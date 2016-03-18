-- create user openresty with password 'speedtheweb';
-- create database openresty_org;
-- grant all privileges on database openresty_org to openresty;

drop table if exists posts cascade;

create table posts (
    id serial primary key,
    permlink varchar(128) unique not null,
    title text not null,
    html_body text not null,
    txt_body text not null,
    creator varchar(32) not null,
    created timestamp with time zone not null,
    modifier varchar(32) not null,
    modifier_link varchar(128),
    modified timestamp with time zone not null,
    changes int not null,
    textsearch_index_col tsvector
);

\copy posts (title, permlink, html_body, txt_body, creator, created, modifier, modifier_link, modified, changes) from 'posts.tsv'

drop function if exists posts_trigger() cascade;

create function posts_trigger() returns trigger as $$
begin
      new.textsearch_index_col :=
         setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A')
         || setweight(to_tsvector('pg_catalog.english', coalesce(new.txt_body,'')), 'D');
      return new;
end
$$ language plpgsql;

create trigger tsvectorupdate before insert or update
    on posts for each row execute procedure posts_trigger();

create index textsearch_idx on posts using gin(textsearch_index_col);

update posts set title = title;
