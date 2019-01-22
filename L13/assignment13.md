# 基礎プログラミングおよび演習レポート ＃13

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 1/22

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L13/assignment13.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- `~~ 省略 ~~`として一部実行結果を省略している箇所があります。
- 可読性を考慮し、一部関数名を変更している場合があります。変更はなるべく記載しておりますが、アンダーバーを付けただけのものなどはっきりとわかるものについては省略している場合もあります。基本的にスネークケースを採用しています。
- 字数の都合上、`main`関数を含めた「プログラム全体」は表示していない場合があります。全体についてはgithubから確認できます。
- 今回から、入力関数として`getl`関数ではなく、今までの演習でも使用していた関数を改変した`input`関数を用意して使用している箇所があります。次の[GitHubレポジトリ](https://github.com/anotherhollow1125/clang_input)にある`input.c`、`input.h`を同階層にコピーして使用しております。

## [課題の再掲]

### 演習 1 文字列操作

- a. 文字列の長さを調べて返す関数`int my_strlen(char *s)`を作る。
- b. 1行ごとに末尾の文字が削られて短くなっていく関数`void printtriangle_tail(char *s)`を作る。
- c. 文字列の中に現れる文字`c1`を文字`c2`に置き換える関数`void mapchar(char *s, char c1, char c2)`を作る。
- d. 文字列中の指定した文字`c1`をすべて削除して詰める関数`void deletechar(char *s, char c1)`を作る。
- e. 文字列を左右ひっくり返す関数`void reverse(char *s)`を作る。
- f. 文字列`s2`の内容を別の文字配列`s1`にコピーする関数`void my_strcpy(char *s1, char *s2)`を作る。
- g. 文字列`s2`の内容を別の文字列`s1`の末尾に追加する(くっつける)関数`void my_strcat(char *s1, char *s2)`を作る。
- h. 文字列`s1`と`s2`を比較して等しければ`0`、1番目のものがコード順で後なら`1`、前なら`-1`を返す関数`int my_strcmp(char *s1, char *s2)`を作る。

### 演習 2 switch文、atoi関数、atof関数

- a. 数字列の先頭が`0`ではじまったら`8`進として受け取るようにする。
- b. 数字列の先頭が`0x`ではじまったら`16`進として受け取るようにする。
- c. `atoi`の代わりに自分流`atof`(文字列を実数に変換)を作成する。
- d. 指数記法も扱えるようにする。
- e. [自由課題] : 月`n`を入力すると、対応する月と日数を表示するプログラムを作成する。(うるう年は考えない。)

### 演習 3 パターンマッチ

テキストにあるプログラムをそのまま動かし、動作を確認したら、目印を先頭位置に1文字表示するのでなく、`pat`のあてはまる範囲に連続して表示するように直す。

### 演習 4 正規表現

- a. `+`(1 回以上の繰り返し) に加えて`*`(0回以上の繰り返し)も記述できるようにする。
- b. `?`(直前の文字があってもなくてもよい)を実現する。
- c. `^`(先頭に固定) と`$`(末尾に固定)を実現する。
- d. 文字クラス`[...]`(...の文字のいずれかならあてはまる)を実現してみなさい。`[^...]`(...のいずれでもなければ) も実現できるとなおよいです。
- e. 特殊文字の機能をなくすエスケープ記号`\`を実現する。
- f. [自由課題] : `\s`で空白に、`\S`で空白以外に、`\d`で数字に、`\D`で数字以外にマッチする機能を実装する。

### 演習 5 [自由課題] 2次配列を使用したプログラム

行列の積を求めるプログラムを作成した。

## [実施したこととその結果]

### 演習 1 文字列操作

演習1を一つのプログラムとして作成した(ただし実際にコンパイルしたコードと以下に示すコードは整形のため一部異なる。)。また実行時、一度目の標準入力で`a b c d`を、二度目の標準入力で` e f g h`をそれぞれ渡している。s

```c
#include <stdio.h>
#include <stdbool.h>
#define MEM 100

bool getl(char s[], int lim) {
    int c, i = 0;
    for(c = getchar(); c != EOF && c != '\n'; c = getchar()) {
        s[i++] = c; if(i+1 >= lim) { break; }
    }
    s[i] = '\0'; return c != EOF;
}

int main(void) {
    char buf[MEM];
    printf("s> "); getl(buf, MEM);
    printtriangle(buf);

    // ...

    return 0;
}
```

#### a my_strlen関数

```c
int my_strlen(char *s) {
    int res = 0;
    for(;s[res] != '\0';res++);
    return res;
}
```

main関数部

```c
printf("len : %d\n", my_strlen(buf));
```

実行結果

```
len : 7
```

`res`変数を初期化し、`for`ループでナル文字がくるまでインクリメントし、最後に返り値として返した。

#### b printtriangle_tail関数

```c
void printtriangle_tail(char *s) {
    if (s[0] == '\0') return;

    printf("%s\n", s);
    int i;
    for (i = 0; s[i] != '\0';i++);
    char tmp = s[i-1];
    s[i-1] = '\0';
    printtriangle_tail(s);
    s[i-1] = tmp;
}
```

main関数部

```c
printtriangle_tail(buf);
```

実行結果

```
a b c d
a b c 
a b c
a b 
a b
a 
a
```

`s`を表示したのち、文字列長を調べ`i`に代入し、最後の文字`s[i-1]`に一旦ナル文字を入れ一文字消去した状態とし、再帰的に自身を呼び出したのち、`s[i-1]`に元の文字を入れる、という操作により実現した。

#### c mapchar関数

```c
void mapchar(char *s, char c1, char c2) {
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c1) s[i] = c2;
    }
}
```

main関数部

```c
mapchar(buf, ' ', '*');
printf("replaced : %s\n", buf);
```

実行結果

```
replaced : a*b*c*d
```

`c1`と一致したら`c2`を代入する、というのをナル文字になるまで繰り返しただけである。

#### d deletechar関数

```c
void deletechar(char *s, char c1) {
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c1) {
            for (int j = i; s[j] != '\0'; j++) s[j] = s[j+1];
        }
    }
}
```

main関数部

```c
deletechar(buf, ' ');
printf("deleted : %s\n", buf);
```

実行結果

```
deleted : abcd
```

`s[i] == c1`が真のとき、`for`文により全体を詰めることで消去を実現した。

#### e reverse関数

```c
void swap(char *str, int i, int j) {
    char tmp = str[i];
    str[i] = str[j];
    str[j] = tmp;
}

void reverse(char *s) {
    int len = 0;
    for (; s[len] != 0; len++);
    len--;

    for (int j = 0; j < len/2; j++) swap(s, j, len-j);
}
```

main関数部

```c
reverse(buf);
printf("reversed : %s\n", buf);
```

実行結果

```
reversed : d c b a
```

長さを求めたのち、長さの半分までをスワップすることで反対になる。

#### f my_strcpy関数

```c
void my_strcpy(char *s1, char *s2) {
    int i;
    for (i = 0; s2[i] != '\0'; i++) {
        s1[i] = s2[i];
    }
    s1[i] = '\0';
}
```

main関数部

```c
char buf2[MEM];
my_strcpy(buf2, buf);
printf("copyed : %s\n", buf2);
```

実行結果

```
copyed : a b c d
```

`s2[i]`がナル文字になるまでループし、ループ後に`s1[i]`にナル文字を入れることでコピーしている。このコードは文字配列`s1`の確保領域を見ていないので`s1`は大きめに取っておく必要がある。

#### g my_strcat関数

```c
void my_strcat(char *s1, char *s2) {
    int i, j;
    for (i = 0; s1[i] != '\0'; i++);
    for (j = i; s2[j-i] != '\0'; j++) s1[j] = s2[j-i];
    s1[j] = '\0';
}
```

main関数部

```c
char buf3[MEM];
printf("s> "); getl(buf3, MEM);
my_strcat(buf2, buf3);
printf("concated : %s\n", buf2);
```

実行結果

```
concated : a b c d e f g h
```

`s1`の長さを調べたのち、`s2`の文字を`s1`に格納しつつ文字列長を求め、最後に`s1[j]`にナル文字を入れることで実現した。

#### h my_strcmp関数

```c
int my_strcmp(char *s1, char *s2) {
    for (int i = 0; s1[i] != '\0' || s2[i] != '\0'; i++) {
        if (s1[i] < s2[i]) {
            return -1;
        } else if (s1[i] > s2[i]) {
            return 1;
        }
    }
    return 0;
}
```

main関数部

```c
printf("abcd abcd -> %d\n", my_strcmp("abcd", "abcd"));
printf("abcd abaa -> %d\n", my_strcmp("abcd", "abaa"));
printf("abcd abcz -> %d\n", my_strcmp("abcd", "abcz"));
printf("abcd abc  -> %d\n", my_strcmp("abcd", "abc"));
printf("abc  abcd -> %d\n", my_strcmp("abc", "abcd"));
```

実行結果

```
abcd abcd -> 0
abcd abaa -> 1
abcd abcz -> -1
abcd abc  -> 1
abc  abcd -> -1
```

ナル文字が同時に来たときのみループを抜け`return 0;`が実行されるようにした。一致しない文字が来た時に大きさを比較して値を返すこととなる。ナル文字は`0`であるため比較対象となった場合早い(短い)と判定されるので、別に処理を用意する必要はない。

### 演習 2 switch文、atoi関数、atof関数

a～dに関して、全体のプログラム概形は以下の通りとなった。

```c
#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include "input.h"

int my_atoi(char *s) {
    // ...
}

double my_atof(char *s) {
    // ...
}

int main(int argc, char *argv[]) {
    int n;
    double x;
    if (argc > 1) {
        n = my_atoi(argv[1]);
        x = my_atof(argv[1]);
    } else {
        char *s = input("x : ");
        n = my_atoi(s);
        x = my_atof(s);
    }

    printf("atoi : %d\n", n);
    printf("atof : %.3lf\n", x);

    return 0;
}
```

#### a・b 8進数、16進数

```c
int my_atoi(char *s) {
    int
        sign = 1,
        val = 0;
    
    bool
        oct = false,
        hex = false;

    switch (*s) {
        case '-':
            sign = -1;
        case '+':
            ++s;
            break;
        case '0':
            oct = true;
            ++s;
            break;
    }

    if (oct && *s == 'x') {
        oct = false;
        hex = true;
        s++;
    }

    // a b
    if (hex) {
        while (true) {
            char c = *s++;
            if ('0' <= c && c <= '9') {
                val = val * 16 + (c - '0');
            } else if ('a' <= c && c <= 'f') {
                val = val * 16 + (c - 'a' + 10);
            } else if ('A' <= c && c <= 'F') {
                val = val * 16 + (c - 'A' + 10);
            } else {
                return sign * val;
            }
        }
    } else if (oct) {
        while (true) {
            char c = *s++;
            if ('0' <= c && c < '8') {
                val = val * 8 + (c - '0');
            } else {
                return sign * val;
            }
        }
    } else {
        while(true) {
            char c = *s++;
            switch(c) {
                case '0': case '1':
                case '2': case '3':
                case '4': case '5':
                case '6': case '7':
                case '8': case '9':
                    val = val * 10 + (c - '0');
                    break;
                default:
                    return sign * val;
            }
        }
    }
}
```

真偽値`hex`、`oct`で8進数か16進数かを保存し、それぞれの進数で値が変わるように分岐構造を書いた。

#### c、d atof関数

```c
double my_atof(char *s) {
    int sign = 1;
    double val = 0;

    switch (*s) {
        case '-':
            sign = -1;
        case '+':
            ++s;
    }

    while (true) {
        char c = *s;
        if ('0' <= c && c <= '9') {
            val = val * 10 + (c - '0');
        } else if (c == '.' || c == 'e') {
            break;
        } else {
            return sign * val;
        }
        s++;
    }

    if (*s++ == '.') {
        for (double t = 0.1; true; t *= 0.1) {
            char c = *s++;
            if ('0' <= c && c <= '9') {
                val += (c - '0') * t;
            // d
            } else if (c == 'e') {
                break;
            } else {
                return sign * val;
            }
        }
    }

    int
        e_sign = 1,
        e = 0;

    switch (*s) {
        case '-':
            e_sign = -1;
        case '+':
            ++s;
    }

    char c = *s++;
    if ('1' <= c && c <= '9') {
        e = e * 10 + (c - '0');
    } else {
        return sign * val;
    }

    while (true) {
        char c = *s++;
        if ('0' <= c && c <= '9') {
            e = e * 10 + (c - '0');
        } else {
            return sign * val * pow(10, e_sign * e);
        }
    }
}
```

最初に整数部、次に小数以下を読み取り、最後に指数部を読み取るという流れで実装した。途中に符号がある場合は`switch`文により消費されるようにし、指数部の値は最大桁を`1`～`9`で消費したのちに`while`ループで消費するようにした。

#### a~d 実行例

```bash
$ ./prac2 12.345
atoi : 12
atof : 12.345

$ ./prac2 -12.345e-2
atoi : -12
atof : -0.123

$ ./prac2 0123
atoi : 83
atof : 123.000

$ ./prac2 0xffffff
atoi : 16777215
atof : 0.000
```

#### e 月を入力すると、対応する月と日数を表示するプログラム

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

int main(int argc, char const *argv[]) {
    int n;

    if (argc > 1) {
        n = atoi(argv[1]);
    } else {
        n = atoi(input("month : "));
    }

    int days = 0;

    char month_list[][MEM] = {
        "Jannuary", "February",
        "March", "April",
        "May", "June",
        "July", "August",
        "September", "October",
        "November", "December"
    };

    while (1) {
        switch (n) {
            // 西向く侍
            case 2:
                days = 28;
                break;

            case 4: case 6:
            case 9: case 11:
                days = 30;
                break;

            case 1: case 3:
            case 5: case 7:
            case 8: case 10:
            case 12:
                days = 31;
                break;

            default:
                printf("No such month. please reinput. (1 ~ 12)\n");
                n = atoi(input("month : "));
                continue;
                break;
        }
        break;
    }
    printf("%d -> %s. in this month there are %d days", n, month_list[n-1], days);

    return 0;
}
```

このように飛び飛びの値での分岐が絡む場合に`switch`文が便利な場合がある。ただこのコード中でも示している通り、例えば「月の英語名称」などは配列で分岐するほうがすっきりする。`switch`文を下手に使用して可読性を悪化しないように気を付けたい。

### 演習 3

全体のコードは省略する。(GitHubにある`prac3.c`が該当する。)
\
`printf("^\n");`を`putrepl('^', strlen(pat));`に書き換えればよいだけである。

### 演習 4 正規表現

全体のコードは以下の通りとなった。

なお、「全体のマッチ」を確認する`matchstr`関数を`match`関数に、その下請けとなる「ある地点より先がパターンにマッチしているか」を確認する関数`pmatch`を`_match_sub`にそれぞれ関数名を変更した。

さらに、諸機能を実現するため、文字の比較を単純比較(`==`)ではなく、専用の関数`chr_match`を用いて行うようにした。

```c
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "input.h"
#define MEM 256

char regex_groups_buf[MEM][MEM];

void put_repl(char c, int count);

char* match(char *str, char *pat, char **tail);
/*
<input>
    char *str := 検索対象文字列
    char *pat := 正規表現
    char **tail := 最終位置を返すためのアドレス
</input>
<output>
    char* match(...) := マッチした先頭位置 または NULL
</output>
*/

char* _match_sub(char *str, char *pat, char *lim, int grp_idx);
/*
<input>
    char *str := 検索対象文字列
    char *pat := 正規表現
    char *lim := 終端位置
</input>
<output>
    char* _match_sub(...) := str または NULL
</output>
*/

bool chr_match(char c, char p, bool esc, int idx);
/*
<input>
    char c := 対象文字
    char p := 正規表現
    bool esc := エスケープか否か
    int idx := 文字クラスの番号。
</input>
<output>
    bool chr_match(...) := マッチするかの真偽値
</output>
*/

int main(int argc, char *argv[]) {

    char *ori_str, *str, *pat;

    switch (argc) {
        case 3:
            ori_str = argv[1];
            pat = argv[2];
            break;
        case 2:
            ori_str = argv[1];
            pat = input("pat? : ");
            break;
        default:
            ori_str = input("str? : ");
            pat = input("pat? : ");
            break;
    }

    str = ori_str;

    for (; str != NULL; str++) {

        char *tail;
        str = match(str, pat, &tail);
        if (str == NULL) break;

        printf("%s\n", ori_str);
        put_repl(' ', str - ori_str);
        put_repl('^', tail - str);
        printf("\n");
    }
    
    return 0;
}

void put_repl(char c, int count) {
    while(count-- > 0) putchar(c);
}

char* match(char *str, char *ori_pat, char **tail) {
    int str_len = strlen(str);

    char *lim = str + str_len;
    char pat[MEM];
    strcpy(pat, ori_pat);
    char
        *p = pat,
        *q = pat;

    int rgb_index = 0;

    for (; *p != '\0'; p++) {
        q = p;
        if (*q == '[') {
            char *for_shift = q+1;
            if (q == pat || *(q-1) != '\\') {
                if (*(q+1) == '^') {
                    *q = ']';
                    q++;
                } /* else {
                    *q = '[';
                }*/
                q++;
                for (int i = 0; *q != ']' && *q != '\0'; i++, q++) {
                    if (*q != '\\') {
                        regex_groups_buf[rgb_index][i] = *q;
                    } else {
                        regex_groups_buf[rgb_index][i] = *(++q);
                    }
                }
                q++;
                while (*q != '\0') *for_shift++ = *q++;
                *for_shift = '\0';
            }
            // printf("%s\n", pat);
            // printf("%s\n", regex_groups_buf[rgb_index]);
            rgb_index++;
        }
    }

    // ^と$
    if (pat[0] == '^') {
        char *t = _match_sub(str, pat, lim, -1);
        if (t != NULL) {
            *tail = t; // 終端位置
            return str; // 一致位置
        } else {
            return NULL;
        }
    }

    for (; *str != '\0'; str++) {
        char *t = _match_sub(str, pat, lim, -1);
        if (t != NULL) {
            *tail = t; // 終端位置
            return str; // 一致位置
        }
    }
    return NULL;
}

char* _match_sub(char *str, char *pat, char *lim, int grp_idx) {
    if (str > lim) return NULL; // 一致しなかった
    if (*pat == '\0') return str; // 最後まで一致した

    // 前置表現
    bool esc = false;

    switch (pat[0]) {
        case '\\':
            esc = true;
        case '^':
            pat++;
            break;
        case '[':
        case ']':
            grp_idx++;
            break;
        case '$':
            if (str == lim) {
                return str;
            } else {
                return NULL;
            }
        default:
            break;
    }

    if (chr_match(str[0], pat[0], esc, grp_idx)) {
        // 後置表現 1
        switch (pat[1]) {
            case '+':
            // a
            case '*':
                ;int i = 0;
                while (chr_match(str[++i], pat[0], esc, grp_idx));
                for (; i > 0; i--) { // i > なのは、pat+2と比較させたいのはstr+1以降だから
                    char *t = _match_sub(str+i, pat+2, lim, grp_idx); // pat+2 == '+'のうしろ
                    if(t != NULL) return t;
                }
                return NULL;
            // b
            case '?':
                return _match_sub(str+1, pat+2, lim, grp_idx);
            default:
                return _match_sub(str+1, pat+1, lim, grp_idx);
        }
    } else {
        // 後置表現 2
        switch (pat[1]) {
            // a
            case '*':
            // b
            case '?':
                return _match_sub(str, pat+2, lim, grp_idx);
            default:
                return NULL;
        }
    }
}

bool chr_match(char c, char p, bool esc, int idx) {
    if (esc) {
        bool flag = false;
        switch (p) {
            case 's':
                flag = true;
            case 'S':
                ;char spaces[] = " \t\n\r\f";
                char *s = spaces;
                for (;*s != '\0'; s++) {
                    if (c == *s) return flag;
                }
                return !flag;
            case 'd':
                flag = true;
            case 'D':
                return !( ('0' <= c && c <= '9') ^ flag );
            case 'w':
                flag = true;
            case 'W':
                return !( ( ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') ) ^ flag );
            default:
                return c == p;
        }
    } else {
        bool g_flag = false;
        switch (p) {
            case '.':
                return c != '\0';
            case '[':
                g_flag = true;
            case ']':
                ;char *g = regex_groups_buf[idx];
                for (;*g != '\0'; g++) {
                    if (c == *g) return g_flag;
                }
                return !g_flag;
            default:
                return c == p;
        }
    }
}
```

以下該当部分についてそれぞれ解説していく。

#### a `*` 0回以上の繰り返し & b `?` 直前の文字があってもなくてもよい

`+`、`*`でとりあえず共通の処理(なるべく長いマッチを取る)を行い、`*`に関してはなかった場合でもマッチするように後ろに処理を付け加えた。

`_match_sub`関数内、後置表現2の`switch`文

```c
// 後置表現 2
switch (pat[1]) {
    case '*':
    case '?':
        return _match_sub(str, pat+2, lim, grp_idx);
    default:
        return NULL;
}
```

#### c. `^`(先頭に固定) と`$`(末尾に固定)を実現する。

##### `^`

繰り返し処理となっている部分を、一回だけ(すなわち頭だけ)実行してその結果を見ればよい。

`match`関数内

```c
if (pat[0] == '^') {
    char *t = _match_sub(str, pat, lim, -1);
    if (t != NULL) {
        *tail = t; // 終端位置
        return str; // 一致位置
    } else {
        return NULL;
    }
}
```

##### `$`

終端かどうかを確認し、終端ならマッチ(`str`)を返すという風に書けばよい。

`_match_sub`関数内、前置表現の`switch`文

```c
case '$':
    if (str == lim) {
        return str;
    } else {
        return NULL;
    }
```

#### d. 文字クラス`[...]` ...の文字のいずれかならあてはまる と `[^...]` ...のいずれでもなければ

外側にグローバル配列`char regex_groups_buf[MEM][MEM]`を用意し、`match`関数の中で解析してグループ化 -> `chr_match`関数内でグループをインデックスから取得して比較、という仕組みにした。

また、肯定(`[...]`)グループは一旦`[`に、否定(`[^...]`)グループは一旦`]`に置き換えることで区別している。

#### e　エスケープ記号`\` & f `\s`で空白に、`\S`で空白以外に、`\d`で数字に、`\D`で数字以外にマッチ

エスケープ機能は`chr_match`関数の`esc`変数による`if`文で、メタグループ機能は`chr_match`関数の`switch`文でそれぞれ実現した。

共通の機能が多い場合に`switch`文は便利であるが、可読性が高いとは言いにくい。

#### 実行例

```bash
$ ./prac4
str? : hogefuga
pat? : ea*f
hogefuga
   ^^

$ ./prac4
str? : hogefuga
pat? : eff?u
hogefuga
   ^^^

$ ./prac4
str? : hogefugabarhogebar
pat? : ^h.+bar$
hogefugabarhogebar
^^^^^^^^^^^^^^^^^^

$ ./prac4
str? : hogefuga
pat? : [oge]f[uga]
hogefuga
   ^^^

$ ./prac4
str? : [[hoge][[[fuga]]]bar]][baz]]
pat? : \[\w
[[hoge][[[fuga]]]bar]][baz]]
 ^^
[[hoge][[[fuga]]]bar]][baz]]
         ^^
[[hoge][[[fuga]]]bar]][baz]]
                      ^^
```

### 演習 5

二つの行列の積を求めるプログラムを書いた。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

void dot(double a[][MEM],
        double b[][MEM],
        double c[][MEM],
        int top, int middle, int bottom) {
    for (int i = 0; i < top; i++) {
        for (int j = 0; j < bottom; j++) {
            c[i][j] = 0;
            for (int k = 0; k < middle; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

int main(void) {

    // 入力

    char *shape = input("shape? (i, k, j) : ");
    int
        top = atoi(strtok(shape, " ,")),
        middle = atoi(strtok(NULL, " ,")),
        bottom = atoi(strtok(NULL, " ,"));
    
    double a[MEM][MEM], b[MEM][MEM], c[MEM][MEM];

    printf("a : \n");

    for (int i = 0; i < top; i++) {
        char *line = input("");
        a[i][0] = atof(strtok(line, " ,"));
        for (int k = 1; k < middle; k++) {
            a[i][k] = atof(strtok(NULL, " ,"));
        }
    }

    printf("b : \n");

    for (int k = 0; k < middle; k++) {
        char *line = input("");
        b[k][0] = atof(strtok(line, " ,"));
        for (int j = 1; j < bottom; j++) {
            b[k][j] = atof(strtok(NULL, " ,"));
        }
    }

    // 処理

    dot(a, b, c, top, middle, bottom);

    // 出力

    printf("c = \n");

    for (int i = 0; i < top; i++) {
        for (int j = 0; j < bottom; j++) {
            printf("%.2lf ", c[i][j]);
        }
        printf("\n");
    }

    return 0;
}
```

予め大きめに配列をとっておき、受け取った「一つ目の行列の行」「二つの行列の列行」「二つ目の行列の列」をもとに行列のサイズを決定して計算させた。

#### 実行例

```bash
$ ./prac5
shape? (i, k, j) : 2 3 2
a :
1 2 3
4 5 6
b :
7 8
9 10
11 12
c =
58.00 64.00
139.00 154.00
```

## [考察]

本文中でも何度か言及したが、`switch`文は`break`をあえて除くことで、条件分岐にも関わらず少ない記述量で共通の処理を書けるという利点がある一方、乱用しすぎると逆に可読性を悪化させバグにつながってしまうという欠点がある。

実際に今回のコーディングでも数回`switch`文によるミスを犯したので、無理に使用する必要はないとも考えられる。

正規表現に関しては、特にグループ化などに関して、パターン自体を文字列で維持するのに苦労したことより、オブジェクト指向をよく使える言語での実装のほうが楽だったのではないかと考えた。もしもう一度実装することがあるときはRubyなどの言語で挑みたい。

## [アンケート]

- Q1. 文字列の基本的な操作ができるようになりましたか。

正規表現を使えるぐらいにはなりました。

- Q2. 文字列から整数や実数を作り出す原理が分かりましたか。

今まで曖昧にとらえていたものが鮮明になったので良かったです。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

残り2回も大切な概念(構造体)について学ぶこととなるので気を緩めず頑張っていきたいです！