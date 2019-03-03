<!---
    @title         OpenResty® C 代码风格指南
--->

OpenResty 在它的 C 语言模块里遵循 NGINX 的代码风格，比如 OpenResty 自己的那些 NGINX 插件
模块和 OpenResty 的那些 Lua 库的 C 部分。 不太幸运的是，即使是 NGINX core 自己的 C 代码
也没有严格遵循和其他 code base 同样的代码约定。 能够有一个正式的规范文档以避免混淆是一个非常
被期待的事情。

给 OpenResty core 提交的补丁也应该遵循这些规范，不然它们将会无法通过代码审核也无法得到合并。
OpenResty 和 NGINX 社区也鼓励大家在用 C 开发插件和库的时候去遵循这套规范。

# 命名约定

和 NGINX 相关的 C 代码、源文件名称 (包括 `.c` 和 `.h` 文件)、全局变量、全局函数、 C 结构体、
联合体和枚举的名字，编译单元域内的静态变量和函数，以及头文件里公用的宏定义应该用全称命名，就像
`ngx_http_core_module.c`, `ngx_http_finalize_request` 和 ` NGX_HTTP_MAIN_CONF`。 这
很重要，因为 C 语言没有像 C++ 里那样明确的命名空间的概念。用全称命名有助于避免符号冲突，也有助于调试。

在 Lua 库的 C 模块里，我们也应该用前缀，比如 `resty_blah_` (假如库的名字是 `lua-resty-blah`)
用于所有相关的 C 编译单元的顶层 C 符号的命名。

我们应该对 C 函数里的局部变量用简称命名。 在 NGINX core 被广泛使用的简称命名是 `cl`, `ev`, `ctx`, `v`，
`p`, `q`，等等。这些变量通常生命周期很短并且作用域有限。根据霍夫曼原则，我们应该在一些常见用法里使用简称命名
以避免文字杂音。即使是简称命名也要遵循 NGINX 的约定。如无必要别发明自己的命名方式。 一定要用有意义的名字。 即使
像 `p` 和 `q`，它们是在上下文中进行字符处理的字符串指针变量的常见命名。

C 结构体和联合体的名字应该尽可能地用单词的全拼形式(除非名称过于长)。举例子，在 NGINX core 里 `struct ngx_http_request_s`，
我们有长的成员名字 `read_event_handler`， `upstream_states` 和 `request_body_in_persistent_file`。

我们应该用 `_t` 作为 `typedef` 中指代结构体的类型名称后缀 ， `_s` 用于 `struct` 名称后缀， 以及 `_e` 作为 `typedef`
中指代枚举的类型名称后缀。函数范围内的局部类型定义不受此约定的约束。 以下是一些来自 NGINX core 的例子:

```C
typedef struct ngx_connection_s      ngx_connection_t;
```

```C
typedef struct {
    WSAOVERLAPPED    ovlp;
    ngx_event_t     *event;
    int              error;
} ngx_event_ovlp_t;
```

```C
struct ngx_chain_s {
    ngx_buf_t    *buf;
    ngx_chain_t  *next;
};
```

```C
typedef enum {
    ngx_pop3_start = 0,
    ngx_pop3_user,
    ...
    ngx_pop3_auth_external
} ngx_pop3_state_e;
```

# 缩进

在 NGINX 的世界里用并且只用 *空格* 作为缩进。不要用制表符！一般我们用 *4 空格* 缩进除了有一些特殊的
对齐要求或者一些特殊情况下的其他要求 (下面的内容有详细解释)。

总是恰当地缩进你的代码。

# 80 列限制

所有的代码行应该保持在 80 列以内 (在 NGINX core 的一些代码里甚至保持在 78 列，但是我建议 80 列作为硬限制)。
对于连续行中使用的缩进，不同的上下文将具有不同的缩进规则。我们将在下面详细讨论案例细节。

# 行尾的空字符

在代码行的结尾不应该有任何空格或者制表符, 即使是空行. 很多编辑器支持用户通过操作自动高亮或截去这些空字符。确认你正确地
配置了你的编辑器或者集成开发环境。

# 函数声明

在头文件或者 `.c` 文件的开头的 C 函数声明 (不是定义!) 应该尽可能地放在单独一行。
以下是一个 NGINX core 里的例子：

```C
ngx_int_t ngx_http_send_special(ngx_http_request_t *r, ngx_uint_t flags);
```

如果一行太长，超过了 80 列，然后我们应该把声明分成多行， 带 4 空格的缩进。比如：

```C
ngx_int_t ngx_http_filter_finalize_request(ngx_http_request_t *r,
    ngx_module_t *m, ngx_int_t error);
```

如果返回类型是指针类型， 在 `*` 之前应该有一个空格，在之后没有，像这样：

```C
char *ngx_http_types_slot(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
```

请注意函数定义遵循不同于函数声明的风格。 详见 [函数定义][] 。

# 函数定义

C 函数定义遵循不同于函数声明 (见 [函数声明][]) 的风格。第一行单独放返回类型，
第二行是函数名和参数列表，第三行是单独一个花括号。以下是一个来自 NGINX core 的例子：

```C
ngx_int_t
ngx_http_compile_complex_value(ngx_http_compile_complex_value_t *ccv)
{
    ...
}
```

请注意在参数列表处的 `(` 字符周围没有空格。并且前三行是没有缩进的。

如果参数列表太长，比如超过了 80 列的限制，我可以分成多行，并在每一个跟随行加 4 空格的缩进。以下是一个来自
NGINX core 里的这样的例子：

```c
ngx_int_t
ngx_http_complex_value(ngx_http_request_t *r, ngx_http_complex_value_t *val,
    ngx_str_t *value)
{
    ...
}
```

如果返回类型是指针类型，在第一个 `*` 之前应该有一个空格，就像这样：

```C
static char *
ngx_http_core_pool_size(ngx_conf_t *cf, void *post, void *data)
{
    ...
}
```

# 局部变量

在 [命名约定][] 部分, 我们要求局部变量应用简称命名，如 `ev`, `clcf`，等等。它们的定义也有一些风格上的要求。

它们应该总是被放在每个 C 函数定义块的开始，不仅仅是随意一个代码块的开始，除非是 debugging 需要或者其他特殊要求。
并且，它们的变量名称 (不包括任何 `*` 前缀)，必须垂直对齐。以下是一个 NGINX core 里的例子：

```C
    ngx_str_t            *value;
    ngx_uint_t            i;
    ngx_regex_elt_t      *re;
    ngx_regex_compile_t   rc;
    u_char                errstr[NGX_MAX_CONF_ERRSTR];
```

请注意变量名称 `value`， `i`，`re`，`rc`  和 `errstr` 是如何垂直对齐的。
`*` 前缀并不算在这些对齐之内。

有时候，一些局部变量的定义可能会格外地长，把它和其他变量对齐可能使得代码很难看。
这时候我们应该在这个长变量定义和其他局部变量之间放一个空行。如此一来，这个长变量就不
需要和另一组垂直对齐了。以下是一个这样的例子：

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

注意变量 `clcf` 的定义是如何被一个空行和其他局部变量分开的。剩下的局部变量仍然要垂直对齐。

局部变量的定义之后也要紧跟一个空行，从而把它们和这个 C 函数的实际执行代码语句分开。 比如：

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

在局部变量之后紧跟着有一个空行。

# 空行的运用

连续的 C 函数定义，多行的全局/静态变量定义，和结构/联合/枚举的定义必须用 2 个空行分开。
以下是一个连续 C 函数定义的例子：

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

以及这里是一个连续的静态变量定义的例子：

```C
static ngx_conf_bitmask_t  ngx_http_core_keepalive_disable[] = {
    ...
    { ngx_null_string, 0 }
};


static ngx_path_init_t  ngx_http_client_temp_path = {
    ngx_string(NGX_HTTP_CLIENT_TEMP_PATH), { 0, 0, 0 }
};
```

单行的变量定义可以放到一组，像这样：

```C
static ngx_str_t  ngx_http_gzip_no_cache = ngx_string("no-cache");
static ngx_str_t  ngx_http_gzip_no_store = ngx_string("no-store");
static ngx_str_t  ngx_http_gzip_private = ngx_string("private");
```

以下是一个连续 (多行) 结构体定义的例子：

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

都是以 2 个空行分开。

并且如果是挨着的不同类型的顶层对象定义也应该被 2 个空行分开，比如：

```C
#if (NGX_HTTP_DEGRADATION)
ngx_uint_t  ngx_http_degraded(ngx_http_request_t *);
#endif


extern ngx_module_t  ngx_http_module;
```

静态函数的声明被 2 个空行与后续的全局变量声明分开。

连续的 C 函数声明不使用 2 个空行分开，像以下这样：

```C
ngx_int_t ngx_http_discard_request_body(ngx_http_request_t *r);
void ngx_http_discarded_request_body_handler(ngx_http_request_t *r);
void ngx_http_block_reading(ngx_http_request_t *r);
void ngx_http_test_reading(ngx_http_request_t *r);
```

即使当有些函数声明分成了多行，诸如：

```C
char *ngx_http_merge_types(ngx_conf_t *cf, ngx_array_t **keys,
    ngx_hash_t *types_hash, ngx_array_t **prev_keys,
    ngx_hash_t *prev_types_hash, ngx_str_t *default_types);
ngx_int_t ngx_http_set_default_types(ngx_conf_t *cf, ngx_array_t **types,
    ngx_str_t *default_type);
```

尽管如此，有时候我们 *可以* 用 2 个空行把它们分成不同的有意义的组，以使得代码更易读，就像这样：

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

第一组都是关于 response headers 而接下来那组是关于 request bodies 。

# 类型转换

当把一个无类型指针 (`void *`) 的值赋给一个有类型指针时，C 语言并不要求明确的类型转换。
 并且 NGINX 的代码风格也不要求这些。比如：

```C
char *
ngx_http_types_slot(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
    char  *p = conf;
    ...
}
```

这里的 `conf` 变量是一个无类型指针，并且 NGINX core 把它赋给了局部变量 `p` 类型是 `char *`，
没有做任何明确的类型转换。

当需要明确的类型转换时，确保在第一个 `*` 符号前有一个空格紧随指针类型名称之后，并且在 `)` 之后
也有一个空格，就像这里：

```C
*types = (void *) -1;
```

在 `*)` 之前有一个空格在 `)` 之后也有一个。这也适用于那种对计算结果进行类型转换的情况:

```C
if ((size_t) (last - buf) < len) {
    ...
}
```

或者多个连续的类型转换：

```C
aio->aiocb.aio_data = (uint64_t) (uintptr_t) ev;
```

注意 `(uint64_t)` 和 `(uintptr_t)` 之间的空格, 以及同样的情况在 `(uintptr_t)` 之后的
空格。

# If 语句

NGINX 中对 C 语言的 if 语句使用也有一些风格上的要求。

首先, 在 `if` 关键词之后有一个空格，并且在右小括号和左大括号之间也有一个空格。也就是，

```C
if (a > 3) {
    ...
}
```

注意在 `if` 之后的空格和在 `{` 之前的空格. 注意, 尽管如此, `(` 之后或者 `)` 之前并没有
空格。

也要注意左大括号必须和 `if` 关键词在同一行，除非这一行超过了 80 列，这种情况下，我们应该
分成多行 *并且* 把左大括号单独放一行。以下的例子展示了这种情况：

```C
            if (ngx_http_set_default_types(cf, prev_keys, default_types)
                != NGX_OK)
            {
                return NGX_CONF_ERROR;
            }
```

注意 `!= NGX_OK` 是如何与 `if` 语句的条件部分 (不包含 `(`) 垂直对齐的。

当较长的条件表达式涉及到逻辑运算符时，我们应该确保逻辑运算符位于后续行的开头，并且
缩进反映了条件表达式的嵌套结构，如

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

我们可以忽略这其中的宏指令。它们和 `if` 语句本身的代码风格没什么关系。

通常我们应该放一个空行在 `if` 语句块的后面，如果其后有其他代码的话。比如：

```C
        if (rc != NGX_OK && (of->err == 0 || !of->errors)) {
            goto failed;
        }

        if (of->is_dir) {
            ...
        }
```

注意空行是如何把连续的 if 语句块分开的。或者是和其他语句：

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

相似地, 在 `if` 语句之前经常也有一个空行，如

```C
        rc = ngx_open_and_stat_file(name, of, pool->log);

        if (rc != NGX_OK && (of->err == 0 || !of->errors)) {
            goto failed;
        }
```

在这样的代码块之间应用空行有助于使得代码不那么拥挤。这些同样适用于 "while" 语句， `for` 语句，等等。

`If` 语句必须总是应用大括号即使是 "then" 分支只有一个语句。比如这个例子，

```C
            if (file->is_dir || file->err) {
                goto update;
            }
```

在这里我们不能省去大括号即使 C 语言标准允许这样做。

## else 部分

当 `if` 语句里采用了一个 `else` 分支, 它也必须采用大括号把它包含的语句括起来. 同样,
必须在 `} else {` 这一行之前放一个空行. 以下是一个例子:

```C
    if (of->disable_symlinks == NGX_DISABLE_SYMLINKS_NOTOWNER
        && !(create & (NGX_FILE_CREATE_OR_OPEN|NGX_FILE_TRUNCATE)))
    {
        fd = ngx_openat_file_owner(at_fd, p, mode, create, access, log);

    } else {
        fd = ngx_openat_file(at_fd, p, mode|NGX_FILE_NOFOLLOW, create, access);
    }
```

注意 `} else {` 是如何放成一行并且在 `} else {` 这行之前有一个空行.

# For 语句

`for` 语句在很多方面和 `if` 语句的风格是相似的，正如 [If 语句][] 部分阐述的那样.
在 `for` 关键词之后和 `{` 符号之前也都要求有一个空格. 另外, 必须用大括号把它的语句包起来.
还有, 在 `for` 的条件部分要求在 `;` 之后放一个空格. 以下的例子展示了这种情况:

```C
for (i = 0; i < size; i++) {
    ...
}
```

一个特殊情况是无限循环, 在 NGINX 的世界里经常编写成以下这样:

```C
    for ( ;; ) {
        ...
    }
```

还有逗号表达式被用在 `for` 语句的条件部分:

```C
    for (i = 0, n = 2; n < cf->args->nelts; i++, n++) {
        ...
    }
```

又或者循环条件被单独置空:

```C
    for (p = pool, n = pool->d.next; /* void */; p = n, n = n->d.next) {
        ...
    }
```

# While 语句

`while` 语句在很多方面和 `if` 语句的风格是相似的，正如 [If 语句][] 部分阐述的那样.
在 `while` 关键词之后以及 `{` 符号之前也都要求有一个空格. 另外, 必须用大括号把它的语句包起来.
以下是一个例子:

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

Do-while 语句也是类似的:

```C
        do {
            p = h2c->state.handler(h2c, p, end);

            if (p == NULL) {
                return;
            }

        } while (p != end);
```

注意在 `do` 和 `{` 之间有一个空格, 同样在 `while` 之前和之后都有一个空格.

# Switch 语句

`switch` 语句在很多方面和 `if` 语句的风格是相似的，正如 [If 语句][] 部分阐述的那样.
在 `switch` 关键词之后以及 `{` 符号之前也都要求有一个空格. 另外, 必须用大括号把它的语句包起来.
以下是一个例子:

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

注意那些 `case` 标签是如何与 `switch` 关键词垂直对齐的.

有时候, 在第一个 `case` 之前有一个空行被应用, 如

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

# 内存分配错误处理

在 NGINX 的世界里有一个总是检查内存动态分配失败的好习惯. 每个地方都是, 就像这样:

```C
    sa = ngx_palloc(cf->pool, socklen);
    if (sa == NULL) {
        return NULL;
    }
```

这两个语句出现在一起的频率很高以至于我们经常不在分配语句和 `if` 语句之间加空行了.

确保你在一个动态内存分配语句之后从不忽略这样一个检查.

# 函数调用

C 函数调用不应该放任何空格在参数列表的左右小括号周围. 以下是一个例子:

```C
sa = ngx_palloc(cf->pool, socklen);
```

当函数调用太长以至于超过了 80 列的限制, 我们应该把参数列表打散分成多个单独的行.
被分出来的行必须和第一个参数垂直对齐, 如

```C
        buf->pos = ngx_slprintf(buf->start, buf->end, "MEMLOG %uz %V:%ui%N",
                                size, &cf->conf_file->file.name,
                                cf->conf_file->line);
```

# 宏

宏定义要求在 `#define` 之后空一格，在定义体部分之前至少空 2 格. 比如:

```C
#define F(x, y, z)  ((z) ^ ((x) & ((y) ^ (z))))
```

有时候由于垂直对齐多个相邻有关系的宏定义的缘故，更多的空格可以被应用在定义体部分之前, 如

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

对于被分成多行的宏定义, 我们应该垂直对齐行连接符 `\`, 如下

```
#define ngx_conf_init_value(conf, default)
\
    if (conf == NGX_CONF_UNSET) {                                            \
        conf = default;                                                      \
    }
```

我们推荐放置 \ 在第 78 列, 尽管有时侯 NGINX core 也没有完全这样做.

# 全局/静态变量

局部变量以及顶层静态变量的定义和声明时, 在类型声明和变量名称部分 (包括任何前置的 `*` 修改符)
之间至少空 2 格. 以下是一个例子:

```C
ngx_uint_t   ngx_http_max_module;


ngx_http_output_header_filter_pt  ngx_http_top_header_filter;
ngx_http_output_body_filter_pt    ngx_http_top_body_filter;
ngx_http_request_body_filter_pt   ngx_http_top_request_body_filter;
```

同样适用于变量定义中包含初始化表达式的情况, 如

```C
ngx_str_t  ngx_http_html_default_types[] = {
    ngx_string("text/html"),
    ngx_null_string
};
```

# 操作符

## 二元操作符

大多数二元操作符之前 *和* 之后都要求空一格, 像 算术运算符, 位运算符,
关系运算符, 和逻辑运算符. 以下是一个例子:

```C
 yday = days - (365 * year + year / 4 - year / 100 + year / 400);
```

还有

```C
if (*p >= '0' && *p <= '9') {
```

对于 struct/union 的成员操作符 `->` 和 `.`, *没有* 空格在它们周围, 比如:

```C
ls = cycle->listening.elts;
```

对于逗号操作符, 在逗号之后应该有一个空格, 之前没有:

```C
for (p = pool, n = pool->d.next; /* void */; p = n, n = n->d.next) {
```

除了 `for` 语句的条件部分和声明多个相同类型的变量, NGINX 一般避免使用逗号操作符.
在其他情况下，最好把逗号表达式分成多个单独的语句.

## 一元操作符

在 C 一元前缀操作符之前或之后, 我们一般不放任何空格. 以下是例子:

```C
for (p = salt; *p && *p != '$' && p < last; p++) { /* void */ }
```

```C
#define SET(n)      (*(uint32_t *) &p[n * 4])
```

注意在一元 `*` 操作符和一元 `&` 操作符周围我们没有放置任何空格. (第二个例子里 `&` 之前
的空格是由于类型转换表达式的需要; 详见 [类型转换][] ).

同样的情况也适用于后缀操作符:

```C
for (value = 0; n--; line++) {
```

## 三元操作符

三元操作符也需要在操作符前后放置空格, 和二元操作符一样. 比如:

```C
node = (rc < 0) ? node->left : node->right;
```

就像我们从这个例子看到的，当条件部分是一个表达式，我们 *可以* 加一对小括号给它. 尽管这不是
强制要求的.

# 结构体/联合体/枚举定义

结构体, 联合体, 和枚举的定义风格是相似的. 它们应该垂直对齐域内的变量名称, 和 [局部变量][]
部分阐述的局部变量定义一样. 我们只给出一些来自 NGINX core 的真实例子以展示这种风格:

```C
typedef struct {
    ngx_uint_t           http_version;
    ngx_uint_t           code;
    ngx_uint_t           count;
    u_char              *start;
    u_char              *end;
} ngx_http_status_t;
```

和局部变量的定义一样的情况, 我们可以用空行把字段分成多个组, 如

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

在这种情况下, 每一组的字段成员名称应该垂直对齐, 但不同组并不要求垂直对齐 (那我们依然可以
这样做, 就像上面的例子展示的).

联合体是相似的:

```C
typedef union epoll_data {
    void         *ptr;
    int           fd;
    uint32_t      u32;
    uint64_t      u64;
} epoll_data_t
```

枚举也是这样:

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

# Typedef 的定义

和 [宏][] 类似, `typedef` 的定义也要求在定义体部分之前至少空 2 格(一般就是 2). 比如,

```C
typedef u_int  aio_context_t;
```

当一组 typedef 定义放到一起并且最好垂直对齐以使代码美观时可以用多于 2 个空格, 如

```
typedef struct ngx_module_s          ngx_module_t;
typedef struct ngx_conf_s            ngx_conf_t;
typedef struct ngx_cycle_s           ngx_cycle_t;
typedef struct ngx_pool_s            ngx_pool_t;
typedef struct ngx_chain_s           ngx_chain_t;
typedef struct ngx_log_s             ngx_log_t;
typedef struct ngx_open_file_s       ngx_open_file_t;
```

# 工具

OpenResty 团队维护着 [ngx-releng](https://github.com/openresty/openresty-devel-utils/blob/master/ngx-releng)
这个工具，用以静态扫描当前的 C 代码，检查大部分 (但不是全部) 本文提到的风格.
它是 OpenResty core 开发者必备的，并且也对 NGINX module 开发者和 NGINX core
研究爱好者有帮助. 我们一直在给这个工具增加更多的 checkers, 也欢迎你为此做出贡献.

Clang 静态代码分析器也对发现不易察觉的代码问题非常有帮助, 所以请用打开高优化选项的
gcc 编译一切.

许多编辑器提供高亮 或/和 自动截取行尾空字符的功能，还有展开制表符成空格等. 比如,
在 vim, 我们可以把下述几行放到我们的 `~/.vimrc` 文件里以高亮显示任何行尾的空字符:

```vim
highlight WhiteSpaceEOL ctermbg=darkgreen guibg=lightgreen
match WhiteSpaceEOL /\s$/
autocmd WinEnter * match WhiteSpaceEOL /\s$/
```

还有正确缩进相关的配置:

```vim
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
```

# Goto 语句和代码标签

NGINX 把 `goto` 语句广泛地应用于错误处理. 对于声名狼藉的 `goto` 语句这是非常好的
应用案例. 很多没经验的 C 程序员可能忌惮于任何 `goto` 语句的应用, 这不公平. 只有用 `goto`
语句往回跳这种情况是不好的, 其他情况一般没问题, 尤其是错误处理. NGINX 要求代码标签要被空行
包围, 就像以下

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

# 空指针检查

在 NGINX 的世界里, 我们经常用 `p == NULL` 代替 `!p` 来检查一个指针变量是否是 `NULL`.
尽最大可能地遵循这个约定. 同样也推荐用 `p != NULL` 代替 `p` 来检查指针不是空, 但简单地用 `p`
来检查也是可以的.

以下是一些例子:

```C
if (addrs != NULL) {
```

```C
if (name == NULL) {
```

用 `NULL` 来判断通常能清楚地表达被检查值的真实含义，并且，正因如此，这样做也有助于提高代码的可读性.

# 作者

本文的作者是章亦春, OpenResty 的创始人.

# 反馈和补丁

欢迎提交反馈和补丁! 可以发邮件给章亦春 `yichun@openresty.com`.
