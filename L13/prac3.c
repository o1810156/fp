#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "input.h"

// 若干リファクタリング

void putrepl(char c, int count) {
    while(count-- > 0) putchar(c);
}

bool nmatch(char *str, char *pat, int len) {
    while (len-- > 0) {
        if (*str++ != *pat++) return false;
    }
    return true;
}

// char* findstr(char *str, char *pat, int str_len) {
char* findstr(char *str, char *pat) {
    int
        pat_len = strlen(pat), // 可読性を考慮するとlは良くないし、初期化文で代入するべきものではない
        str_len = strlen(str);

    // printf("str_len = %d\n", str_len);

    for (; pat_len <= str_len; str++, str_len--) {
        // printf("str = %s\n", str);
        if (nmatch(str, pat, pat_len)) return str;
    }
    return NULL;
}

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
    // int len = strlen(str);

    for (; str != NULL; str++) {

        // printf("len - (str - ori_str) = %d\n", len - (str - ori_str));
        str = findstr(str, pat);
        if (str == NULL) break;

        printf("%s\n", ori_str);
        putrepl(' ', str - ori_str);
        putrepl('^', strlen(pat));
        printf("\n");
    }
    
    return 0;
}
