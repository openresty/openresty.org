<!---
    @title         OpenResty® C Coding Style Guide
--->

OpenResty 在它的 C 语言模块里遵循 NGINX 的代码风格, 比如 OpenResty 自己的那些 NGINX 插件
模块和 OpenResty 的那些 Lua 库的 C 部分. 不太幸运的是，即使是 NGINX core 自己的 C 代码
也没有严格遵循和其他 code base 同样的代码习惯. 能够有一个正式的导则文档以避免混淆是一个非常
被期待的事情.

给 OpenResty core 提交的补丁也应该遵循这些导则，不然它们将会无法通过代码审核也无法得到合并.
OpenResty 和 NGINX 社区也鼓励大家在用 C 开发插件和库的时候去遵循这个导则.

# 命名习惯

和 NGINX 相关的 C 代码, 源文件名称 (包括 `.c` 和 `.h` 文件), 全局变量, 全局函数, C 结构体、
联合体和枚举的名字, 编译单元域内的静态变量和函数，以及头文件里公用的宏定义应该用全称命名, 就像 
`ngx_http_core_module.c`, `ngx_http_finalize_request` 和 ` NGX_HTTP_MAIN_CONF`. 这
很重要，因为 C 语言没有像 C++ 里那样明确的命名空间的概念. 用全称命名有助于避免符号冲突，也有助于调试.

在 Lua 库的 C 模块里, 我们也应该用前缀，比如 `resty_blah_` (假如库的名字是 `lua-resty-blah`) 
用于所有相关的 C 编译单元的顶层 C 符号的命名.

我们应该对 C 函数里的局部变量用简称命名. 在 NGINX core 被广泛使用的简称命名是 `cl`, `ev`, `ctx`, `v`,
`p`, `q`, 等等. 这些变量通常生命周期很短并且作用域有限. 根据霍夫曼原则, 我们应该在一些常见用法里使用简称命名
以避免文字杂音.即使是简称命名也要遵循 NGINX 的习惯. 如无必要别发明自己的命名方式. 一定要用有意义的名字. 即使
像 `p` 和 `q`,它们是在上下文中进行字符处理的字符串指针变量的常见命名.

C 结构体和联合体的名字应该尽可能地用单词的全拼形式(除非名称过于长). 举例子, 在 NGINX core 里 `struct ngx_http_request_s`, 
我们有长的成员名字 `read_event_handler`, `upstream_states`, 和 `request_body_in_persistent_file`.

# 缩进

在 NGINX 的世界里用并且只用 *空格* 作为缩进. 不要用 tabs! 一般我们用 *4-space* 缩进 除了有一些特殊的
对齐要求或者一些特殊情况下的其他要求 (下面的内容有详细解释).

总是恰当地缩进你的代码.

# 80 列限制

所有的代码行应该保持在 80 列以内 (在 NGINX core 的一些代码里甚至保持在 78 列, 但是我建议 80 列作为硬限制). 
对于连续行中使用的缩进, 不同的上下文将具有不同的缩进规则。我们将在下面详细讨论案例细节。

# Line trailing white-spaces

在代码行的结尾不应该有任何空格或者 Tabs, 即使是空行. 很多编辑器支持用户通过操作自动高亮或截去这些空字符. 确认你正确地
配置了你的编辑器或者集成开发环境.

# 函数声明

在头文件或者 `.c` 文件的开头的 C 函数声明 (不是定义!) 应该尽可能地放在单独一行.
以下是一个 NGINX core 里的例子:

```C
ngx_int_t ngx_http_send_special(ngx_http_request_t *r, ngx_uint_t flags);
```

如果一行太长, 超过了 80 列, 然后我们应该把声明分成多行, 带 4-space 的缩进. 比如,

```C
ngx_int_t ngx_http_filter_finalize_request(ngx_http_request_t *r,
    ngx_module_t *m, ngx_int_t error);
```

如果返回类型是指针类型, 在 `*` 之前应该有一个空格，在之后没有, 像这样

```C
char *ngx_http_types_slot(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
```

请注意函数定义遵循不同于函数声明的风格. 详见 [函数定义][] .

# 函数定义

C 函数定义遵循不同于函数声明 (见 [函数声明][]) 的风格. 第一行单独放返回类型, 
第二行是函数名和参数列表, 第三行是单独一个花括号. 以下是一个来自 NGINX core 的例子:

```C
ngx_int_t
ngx_http_compile_complex_value(ngx_http_compile_complex_value_t *ccv)
{
    ...
}
```

请注意在参数列表处的 `(` 字符周围没有空格. 并且前三行是没有缩进的.

如果参数列表太长, 比如超过了 80 列的限制, 我可以分成多行，并在每一个跟随行加 4 空格的缩进. 以下是一个来自 
NGINX core 里的这样的例子:

```c
ngx_int_t
ngx_http_complex_value(ngx_http_request_t *r, ngx_http_complex_value_t *val,
    ngx_str_t *value)
{
    ...
}
```

如果返回类型是指针类型, 在第一个 `*` 之前应该有一个空格, 就像这样:

```C
static char *
ngx_http_core_pool_size(ngx_conf_t *cf, void *post, void *data)
{
    ...
}
```

# 局部变量

在 [命名习惯][] 部分, 我们要求局部变量应用简命名，如 `ev`, `clcf`, 等等. 它们的定义也有一些风格上的要求.

They should always be put at the beginning of each C function definition
block, not just at the beginning of any arbitrary code block, unless to
aid debugging or some other special requirements. Also, their variable
identifiers (excluding any `*` prefixes), must be aligned up vertically.
Below is an example from the NGINX core:

```C
    ngx_str_t            *value;
    ngx_uint_t            i;
    ngx_regex_elt_t      *re;
    ngx_regex_compile_t   rc;
    u_char                errstr[NGX_MAX_CONF_ERRSTR];
```

Please note how the identifiers `value`, `i`, `re`, `rc`, and `errstr`
are aligned up vertically. The `*` prefix does not count in this alignment.

Some times, some local variable's definition may be exceptionally long,
aligning it with the rest of the variables may make the code ugly. Then
we should put a single blank line between this long variable definition
and the rest of the local variable definitions. In this case, the two groups'
identifiers do not need to be aligned vertically. Below is such an example:

```C
static char *
ngx_http_core_open_file_cache(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
    ngx_http_core_loc_conf_t *clcf = conf;

    time_t       inactive;
    ngx_str_t   *value, s;
    ngx_int_t    max;
    ngx_uint_t   i;
    ...
}
```

Note how the variable `clcf`'s definition is separated by a blank line with
the rest of the local variables. The rest of the local variables still
align up vertically.

The local variables declarations also must be followed by a blank line which
separate them from the actual execution code statements of the current
C function. For example:

```C
u_char * ngx_cdecl
ngx_sprintf(u_char *buf, const char *fmt, ...)
{
    u_char   *p;
    va_list   args;

    va_start(args, fmt);
    p = ngx_vslprintf(buf, (void *) -1, fmt, args);
    va_end(args);

    return p;
}
```

There is a blank line right after the local variable definitions.

# Use of blank lines

Successive C function definitions, multi-line global/static variable definitions,
and struct/union/enum definitions must be separated by 2 blank lines. Below
is an example for successive C function definitions:

```c
void
foo(void)
{
    /* ... */
}


int
bar(...)
{
    /* ... */
}
```

And here is an example for successive static variable definitions:

```C
static ngx_conf_bitmask_t  ngx_http_core_keepalive_disable[] = {
    ...
    { ngx_null_string, 0 }
};


static ngx_path_init_t  ngx_http_client_temp_path = {
    ngx_string(NGX_HTTP_CLIENT_TEMP_PATH), { 0, 0, 0 }
};
```

Single-line variable definitions may be grouped together, as in

```C
static ngx_str_t  ngx_http_gzip_no_cache = ngx_string("no-cache");
static ngx_str_t  ngx_http_gzip_no_store = ngx_string("no-store");
static ngx_str_t  ngx_http_gzip_private = ngx_string("private");
```

Below is an example for successive (multi-line) struct definitions:

```C
struct ngx_http_log_ctx_s {
    ngx_connection_t    *connection;
    ngx_http_request_t  *request;
    ngx_http_request_t  *current_request;
};


struct ngx_http_chunked_s {
    ngx_uint_t           state;
    off_t                size;
    off_t                length;
};


typedef struct {
    ngx_uint_t           http_version;
    ngx_uint_t           code;
    ngx_uint_t           count;
    u_char              *start;
    u_char              *end;
} ngx_http_status_t;
```

All separated by 2 blank lines.

And if different kinds of these top-level object definitions should also
be separated by 2 blank lines if they are neighbors, for example:

```C
#if (NGX_HTTP_DEGRADATION)
ngx_uint_t  ngx_http_degraded(ngx_http_request_t *);
#endif


extern ngx_module_t  ngx_http_module;
```

The static function declaration is separated by 2 blank lines from the following
C global variable declaration.

Successive C function declarations do not use 2 blank lines to separate
each other, as in

```C
ngx_int_t ngx_http_discard_request_body(ngx_http_request_t *r);
void ngx_http_discarded_request_body_handler(ngx_http_request_t *r);
void ngx_http_block_reading(ngx_http_request_t *r);
void ngx_http_test_reading(ngx_http_request_t *r);
```

Even when some of them span multiple lines, as in

```C
char *ngx_http_merge_types(ngx_conf_t *cf, ngx_array_t **keys,
    ngx_hash_t *types_hash, ngx_array_t **prev_keys,
    ngx_hash_t *prev_types_hash, ngx_str_t *default_types);
ngx_int_t ngx_http_set_default_types(ngx_conf_t *cf, ngx_array_t **types,
    ngx_str_t *default_type);
```

Still, sometimes we *could* use 2 blank lines to separate them into semantically
meaningful groups, for better code readability, as in

```C
ngx_int_t ngx_http_send_header(ngx_http_request_t *r);
ngx_int_t ngx_http_special_response_handler(ngx_http_request_t *r,
    ngx_int_t error);
ngx_int_t ngx_http_filter_finalize_request(ngx_http_request_t *r,
    ngx_module_t *m, ngx_int_t error);
void ngx_http_clean_header(ngx_http_request_t *r);


ngx_int_t ngx_http_discard_request_body(ngx_http_request_t *r);
void ngx_http_discarded_request_body_handler(ngx_http_request_t *r);
void ngx_http_block_reading(ngx_http_request_t *r);
void ngx_http_test_reading(ngx_http_request_t *r);
```

The first group is mostly about response headers while the latter group
is for request bodies.

# Type casting

The C language does not require explicit type casting when assigning the
value of a void pointer (`void *`) to a non-void pointer. And the NGINX
coding style does not require that either. For instance:

```C
char *
ngx_http_types_slot(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
    char  *p = conf;
    ...
}
```

Here the `conf` variable is a void pointer and the NGINX core assign it
to the local variable `p` of the type `char *` without any explicit type
casting.

When explicit type casting is needed, make sure there is a space before
the first `*` character for the target pointer type name, and also a space
after the `)` character, as in

```C
*types = (void *) -1;
```

There is a space before `*)` and also a space after `)`. This also applies
to the case when the value to be type-casted is an example:

```C
if ((size_t) (last - buf) < len) {
    ...
}
```

Or multiple successive type casting:

```C
aio->aiocb.aio_data = (uint64_t) (uintptr_t) ev;
```

Note the space between `(uint64_t)` and `(uintptr_t)`, as well as the space
after `(uintptr_t)`.

# If statements

NGINX's use of C's if statements also have some style requirements.

First of all, there must be a space after the `if` keyword, and also a
space between the condition's closing parenthesis and the opening curly
bracket. That is,

```C
if (a > 3) {
    ...
}
```

Note the space after `if` and the space before `{`. Note, however, there
is no spaces right after `(` or right before `)`.

Also note that the opening curly bracket must be on the same line as the
`if` keyword, unless this line would exceed 80 columns, in which case,
we should split the condition into multiple lines *and* put the opening
curly bracket on its own line. The following example demonstrates this:

```C
            if (ngx_http_set_default_types(cf, prev_keys, default_types)
                != NGX_OK)
            {
                return NGX_CONF_ERROR;
            }
```

Note how `!= OK` is aligned up vertically with the condition part (excluding
`(`) of the `if` statement.

When logical operators are involved in the long condition part, then we
should make sure the connecting logical operators are at the beginning
of the subsequent lines and the indentation reflects the nesting structure
of the condition expression, as in

```C
        if (file->use_event
            || (file->event == NULL
                && (of->uniq == 0 || of->uniq == file->uniq)
                && now - file->created < of->valid
#if (NGX_HAVE_OPENAT)
                && of->disable_symlinks == file->disable_symlinks
                && of->disable_symlinks_from == file->disable_symlinks_from
#endif
            ))
        {
            ...
        }
```

We can ignore the macro directives in the middle. They are not really relevant
to the coding style of the `if` statement itself.

Usually we should leave a blank line after the `if` statement's code block
if there is other statements following up. For example:

```C
        if (rc != NGX_OK && (of->err == 0 || !of->errors)) {
            goto failed;
        }

        if (of->is_dir) {
            ...
        }
```

Note how a blank line is used to separate successive if statement blocks.
Or with some other statements:

```C
        if (file->is_dir) {

            /*
             * chances that directory became file are very small
             * so test_dir flag allows to use a single syscall
             * in ngx_file_info() instead of three syscalls
             */

            of->test_dir = 1;
        }

        of->fd = file->fd;
        of->uniq = file->uniq;
```

Similarly, there is often a single blank line used before the `if` statement,
as in

```C
        rc = ngx_open_and_stat_file(name, of, pool->log);

        if (rc != NGX_OK && (of->err == 0 || !of->errors)) {
            goto failed;
        }
```

Use of blank lines around such code blocks help make the code less crowded.
The same applies to "while" statements, `for` statements, and etc.

`If` statements must always use curly brackets even when the "then" branch
has only a single statement. For instance,

```C
            if (file->is_dir || file->err) {
                goto update;
            }
```

We must not omit the curly braces in such cases even though the standard
C language allows that.

## else part

When the `if` statement takes an `else` branch, then it also must take
curly braces to group the contained statements. Also, a blank line must
be used before the `} else {` line. Below is an example:

```C
    if (of->disable_symlinks == NGX_DISABLE_SYMLINKS_NOTOWNER
        && !(create & (NGX_FILE_CREATE_OR_OPEN|NGX_FILE_TRUNCATE)))
    {
        fd = ngx_openat_file_owner(at_fd, p, mode, create, access, log);

    } else {
        fd = ngx_openat_file(at_fd, p, mode|NGX_FILE_NOFOLLOW, create, access);
    }
```

Note how `} else {` is put on the same line and there is a blank line right
before the `} else {` line.

# For statements

The `for` statement is similar to the `if` statement style explained in
section [If statements][] in many ways. A space is also required after
the `for` keyword and also before `{`. Additionally, curly braces must
be used for the contained statements. Furthermore, a space is required
right after `;` in the `for` condition part. The following example demonstrates
these requirements:

```C
for (i = 0; i < size; i++) {
    ...
}
```

A special case is the infinite loop, which is usually encoded as below
in the NGINX world:

```C
    for ( ;; ) {
        ...
    }
```

Or when comma expressions are used in the `for` statement's condition part:

```C
    for (i = 0, n = 2; n < cf->args->nelts; i++, n++) {
        ...
    }
```

Or when the loop condition alone is omitted:

```C
    for (p = pool, n = pool->d.next; /* void */; p = n, n = n->d.next) {
        ...
    }
```

# While statements

The `for` statement is similar to the `if` statement style explained in
section [If statements][] in many ways. A space is also required after
the `while` keyword and also before `{`. Additionally, curly braces must
be used for the contained statements. Below is an example:

```C
    while (log->next) {
        if (new_log->log_level > log->next->log_level) {
            new_log->next = log->next;
            log->next = new_log;
            return;
        }

        log = log->next;
    }
```

Do-while statements are also similar:

```C
        do {
            p = h2c->state.handler(h2c, p, end);

            if (p == NULL) {
                return;
            }

        } while (p != end);
```

Note the use of a single space between `do` and `{`, as well as single
space before and after `while`.

# Switch statements

The `for` statement is similar to the `if` statement style explained in
section [If statements][] in many ways. A space is also required after
the `switch` keyword and also before `{`. Additionally, curly braces must
be used for the contained statements. Below is an example:

```C
    switch (unit) {
    case 'K':
    case 'k':
        len--;
        max = NGX_MAX_SIZE_T_VALUE / 1024;
        scale = 1024;
        break;

    case 'M':
    case 'm':
        len--;
        max = NGX_MAX_SIZE_T_VALUE / (1024 * 1024);
        scale = 1024 * 1024;
        break;

    default:
        max = NGX_MAX_SIZE_T_VALUE;
        scale = 1;
    }
```

Note how the `case` labels are aligned vertically with the `switch` keyword.

Sometimes, a blank line is used before the first `case` label line, as
in

```C
        switch (c->log_error) {

        case NGX_ERROR_IGNORE_EINVAL:
        case NGX_ERROR_IGNORE_ECONNRESET:
        case NGX_ERROR_INFO:
            level = NGX_LOG_INFO;
            break;

        default:
            level = NGX_LOG_ERR;
        }
```

# Allocation error handling

The NGINX world has a good habit of always checking memory dynamic allocation
failures. It's everywhere, like this:

```C
    sa = ngx_palloc(cf->pool, socklen);
    if (sa == NULL) {
        return NULL;
    }
```

These two statements appear together so frequently that we usually do not
put a blank line between the allocation statement and the `if` statement.

Make sure you never omit such a check after a dynamic memory allocation
statement.

# Function calls

C function calls should not put any spaces around the opening or closing
parentheses for the argument list. Below is an example:

```C
sa = ngx_palloc(cf->pool, socklen);
```

When the function call is so long that would exceed the 80 column limit,
then we should break up the argument list into separate lines. The subsequent
lines must align up with the first argument vertically, as in

```C
        buf->pos = ngx_slprintf(buf->start, buf->end, "MEMLOG %uz %V:%ui%N",
                                size, &cf->conf_file->file.name,
                                cf->conf_file->line);
```

# Macros

Macro defintions requires a single space after `#define` while (at least)
2 spaces before the definition body part. For example:

```C
#define F(x, y, z)  ((z) ^ ((x) & ((y) ^ (z))))
```

Some times more spaces may be used before the definition body part for
the sake of vertical alignment among multiple closely related macro definitions,
as in

```C
#define NGX_RESOLVE_A         1
#define NGX_RESOLVE_CNAME     5
#define NGX_RESOLVE_PTR       12
#define NGX_RESOLVE_MX        15
#define NGX_RESOLVE_TXT       16
#define NGX_RESOLVE_AAAA      28
#define NGX_RESOLVE_SRV       33
#define NGX_RESOLVE_DNAME     39
#define NGX_RESOLVE_FORMERR   1
#define NGX_RESOLVE_SERVFAIL  2
```

For macro definitions spanning multiple lines, we should align up the line
continuation character `\` vertically, as in

```
#define ngx_conf_init_value(conf, default)
\
    if (conf == NGX_CONF_UNSET) {                                            \
        conf = default;                                                      \
    }
```

We recommend putting `\` on the 78th column though the NGINX core some
times disagrees with itself.

# Global/Static variables

Definitions and declarations for local variables and top-level static variables
should put at least 2 spaces between the type declarator and the variable
identifier part (including any leading `*` modifiers). Below are some examples:

```C
ngx_uint_t   ngx_http_max_module;


ngx_http_output_header_filter_pt  ngx_http_top_header_filter;
ngx_http_output_body_filter_pt    ngx_http_top_body_filter;
ngx_http_request_body_filter_pt   ngx_http_top_request_body_filter;
```

The same applies to variable definitions taking an initializer expression,
as in

```C
ngx_str_t  ngx_http_html_default_types[] = {
    ngx_string("text/html"),
    ngx_null_string
};
```

# Operators

## Binary operators

A single space is required before *and* after most of the binary C operators
like arithmetic operators, bit operators, relational operators, and logical
operators. Below are some examples:

```C
 yday = days - (365 * year + year / 4 - year / 100 + year / 400);
```

and also

```C
if (*p >= '0' && *p <= '9') {
```

For struct/union member operators `->` and `.`, *no* spaces are allowed
around them, for instance:

```C
ls = cycle->listening.elts;
```

For the comma operator, a single space should be used after the comma,
not before:

```C
for (p = pool, n = pool->d.next; /* void */; p = n, n = n->d.next) {
```

NGINX usually avoids the comma operators except in the context of `for`
statement conditions and in multiple variable declarations of the same
type. Better split your comma expressions into separate statements in other
cases.

## Unary operators

We usually do not put any spaces before or after the C unary prefix operators.
Below are some examples:

```C
for (p = salt; *p && *p != '$' && p < last; p++) { /* void */ }
```

```C
#define SET(n)      (*(uint32_t *) &p[n * 4])
```

Note that we do not put any spaces around the unary `*` operator or the
unary `&` operator (the space used before `&` in the 2nd example above
is due to the use of type casting expression; see section [Type casting][]
for more details).

The same applies to the suffix operators:

```C
for (value = 0; n--; line++) {
```

## Ternary operators

Ternary operators also require the use of spaces around the operators,
just as with the binary operators. For example:

```C
node = (rc < 0) ? node->left : node->right;
```

As we can see from this example that when the condition part of the ternary
operator is an expression, we *could* also add a pair of parentheses around
it. This is not required though.

# Struct/union/enum definitions

The definition style for structs, unions, and enums are similar. They should
align up the fields' identifiers vertically, in a similar way to local
variable definitions explained in section [Local variables][]. We will
just give some real examples from the NGINX core to demonstrate the style:

```C
typedef struct {
    ngx_uint_t           http_version;
    ngx_uint_t           code;
    ngx_uint_t           count;
    u_char              *start;
    u_char              *end;
} ngx_http_status_t;
```

Just with the case of local variable definitions, we could also use a blank
line to separate out groups of fields, as in

```C
struct ngx_http_request_s {
    uint32_t                          signature;         /* "HTTP" */

    ngx_connection_t                 *connection;

    void                            **ctx;
    void                            **main_conf;
    void                            **srv_conf;
    void                            **loc_conf;

    ngx_http_event_handler_pt         read_event_handler;
    ngx_http_event_handler_pt         write_event_handler;
    ...
};
```

In this case, each group still must align up the field member identifiers
vertically, but different groups are not required to be aligned (although
we still could, as demonstrated in the example above).

Unions are similar:

```C
typedef union epoll_data {
    void         *ptr;
    int           fd;
    uint32_t      u32;
    uint64_t      u64;
} epoll_data_t
```

So are enums:

```C
typedef enum {
    NGX_HTTP_INITING_REQUEST_STATE = 0,
    NGX_HTTP_READING_REQUEST_STATE,
    NGX_HTTP_PROCESS_REQUEST_STATE,

    NGX_HTTP_CONNECT_UPSTREAM_STATE,
    NGX_HTTP_WRITING_UPSTREAM_STATE,
    NGX_HTTP_READING_UPSTREAM_STATE,

    NGX_HTTP_WRITING_REQUEST_STATE,
    NGX_HTTP_LINGERING_CLOSE_STATE,
    NGX_HTTP_KEEPALIVE_STATE
} ngx_http_state_e;
```

# Typedef definitions

Similar to [Macros][], `typedef` definitions also require at least 2 spaces
(usually just 2) before the definition body part. For instance,

```C
typedef u_int  aio_context_t;
```

More than 2 spaces can be used when a group of typedef definitions are
put together and it's nice to have them align up vertically for aesthetic
reasons, as in

```
typedef struct ngx_module_s          ngx_module_t;
typedef struct ngx_conf_s            ngx_conf_t;
typedef struct ngx_cycle_s           ngx_cycle_t;
typedef struct ngx_pool_s            ngx_pool_t;
typedef struct ngx_chain_s           ngx_chain_t;
typedef struct ngx_log_s             ngx_log_t;
typedef struct ngx_open_file_s       ngx_open_file_t;
```

# Tools

The OpenResty team maintains the [ngx-releng](https://github.com/openresty/openresty-devel-utils/blob/master/ngx-releng)
tool to statically scan the current C source tree for many (but not all)
style issues covered in this document. It's been a must-have for OpenResty
core developers and also be helpful for NGINX module developers and NGINX
core hackers in general. We keep adding more checkers to this tool and
we welcome your contributions as well.

The clang static code analyzer is also immensely helpful for catching subtle
coding problems so does using high optimization flags of gcc to compile
everything.

Many editors provide features to highlight and/or auto-trim line trailing
spaces as well as expanding tabs into spaces. For example, in vim, we could
put the following lines to our `~/.vimrc` file to highlight any line-trailing
white-spaces:

```vim
highlight WhiteSpaceEOL ctermbg=darkgreen guibg=lightgreen
match WhiteSpaceEOL /\s$/
autocmd WinEnter * match WhiteSpaceEOL /\s$/
```

And also to set the indentation facilities properly:

```vim
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
```

# Goto statements and code labels

NGINX uses `goto` statements wisely for error handling. It is a good use
case for the notorious `goto` statement. Many inexperienced C programmers
may panic upon any uses of `goto` statements, which is not fair. It is
just bad to use `goto` statements to jump backward, otherwise it's usually
fine, especially for error handling. NGINX requires that the code labels
to be surrounded by blank lines, as in

```C
        p = ngx_pnalloc(pool, len);
        if (p == NULL) {
            goto failed;
        }

		...

        i++;
    }

    freeaddrinfo(res);
    return NGX_OK;

failed:

    freeaddrinfo(res);
    return NGX_ERROR;
```

# Checking pointer nullity

In the NGINX world, we usually use `p == NULL` instead of `!p` to check
if a pointer value is `NULL`. Follow this convention wherever possible.
It is also recommended to use `p != NULL` instead of `p` to test the opposite,
but it is also fine to simply use `p` to test in this case.

Below are some examles:

```C
if (addrs != NULL) {
```

```C
if (name == NULL) {
```

Testing against `NULL` is usually clearer about the nature of the value
being checked and thus helps improve code readability.

# Author

The author of this guideline is Yichun Zhang, the creator of OpenResty.

# Feedback and patches

Feedback and patches are always welcome! They should go to Yichun Zhang'
s email address `yichun@openresty.com`.
