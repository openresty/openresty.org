-- create user openresty with password 'speedtheweb';
-- create database openresty_org;
-- grant all privileges on database openresty_org to openresty;

-- drop table if exists posts cascade;

drop table if exists posts_en cascade;

create table posts_en (
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

drop table if exists posts_cn cascade;

create table posts_cn (
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

\copy posts_en (title, permlink, html_body, txt_body, creator, created, modifier, modifier_link, modified, changes) from 'posts-en.tsv'
\copy posts_cn (title, permlink, html_body, txt_body, creator, created, modifier, modifier_link, modified, changes) from 'posts-cn.tsv'

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
    on posts_en for each row execute procedure posts_trigger();

-- TODO: we need Chinese full text search configuration here.
create trigger tsvectorupdate before insert or update
    on posts_cn for each row execute procedure posts_trigger();

create index textsearch_idx_en on posts_en using gin(textsearch_index_col);
create index textsearch_idx_cn on posts_cn using gin(textsearch_index_col);

update posts_en set title = title;
update posts_cn set title = title;
