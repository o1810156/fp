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
        // pat_len = strlen(pat);
    // char *lim = str + str_len; // *(str + str_len) == '\0'

    char *lim = str + str_len;
    char pat[MEM];
    strcpy(pat, ori_pat);
    char *q = pat;

    int rgb_index = 0;

    for (; *q != '\0'; q++) {
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
    // if (*(str-1) == '\0') return NULL; // 一致しなかった
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
            // pat++;
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
                // while (str[0] == str[++i]); // 横着w
                while (chr_match(str[++i], pat[0], esc, grp_idx)); // 横着w
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