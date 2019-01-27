#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "prac6.h"
#include "input.h"
#define MAXTBL 999983 // 1000000以下最大の素数
// #define MAXTBL 23

struct ent {
    char *key;
    int val;
};

struct ent *tbl[MAXTBL]; // NULLを使いたいのでポインタで保存
// char *keys[MAXTBL];
static int _ent_num = 0;

static int hash(char *s, const int p) {
    unsigned int v = 1;
    for (;*s != '\0'; s++) v *= p * (*s) + 1;
    return (int)(v % MAXTBL);
}

static int hash1(char *s) {
    return hash(s, 11);
}

static int hash2(char *s) {
    int res = hash(s, 13);
    return res > 0 ? res % MAXTBL : 1;
}

static int lookup(char *k) {
    for (int i = hash1(k),d = hash2(k);
            tbl[i] != NULL;
            i = (i+d) % MAXTBL) {
            // i = i+d < MAXTBL ? i+d : i+d - MAXTBL) {
        if (strcmp(tbl[i]->key, k) == 0) return i;
        // printf("conflict: %d %d %s %s\n", d, i, k, tbl[i]->key);
    }
    return -1;
}

int tbl_get(char *k) {
    int i = lookup(k);
    return i > 0 ? tbl[i]->val : -1;
}

bool tbl_put(char *k, int v) {
    // MAXTBL-1(== 999982)個以上格納すると検索が止まらなくなる
    if(_ent_num + 1 >= MAXTBL) return false;

    int i = lookup(k);

    if (i != -1) {
        tbl[i]->val = v;
        return true;
    }

    // if(tblsize + 1 >= MAXTBL) return false;

    char *s = (char *)malloc(strlen(k)+1);
    if (s == NULL) return false;

    strcpy(s, k);

    for (int i = hash1(k),d = hash2(k); ; i = (i+d) % MAXTBL) {
        if (tbl[i] == NULL) {
            // tbl[i] = new (struct ent){ s, v };
            tbl[i] = (struct ent*)malloc(sizeof(struct ent));
            tbl[i]->key = s;
            tbl[i]->val = v;
            break;
        }
    }
    // keys[_ent_num++] = s;

    _ent_num++;
    return true;
}

bool tbl_rm(char *k) {
    int i = lookup(k);
    if (i == -1) return false;

    free(tbl[i]->key);
    tbl[i] = NULL;

    _ent_num--;
    return true;
}

// void tbl_show(void) {
//     printf("key\tval\n");
//     for (int i = 0; i < _ent_num; i++) {
//         if (keys[i] == NULL) continue;
//         int j = lookup(keys[i]);
//         if (j != -1) printf("%s\t%d\n", tbl[j]->key, tbl[j]->val);
//     }
// }

void tbl_show(void) {
    printf("key\tval\n");
    for (int i = 0; i < MAXTBL; i++) {
        if (tbl[i] != NULL) printf("%s\t%d\n", tbl[i]->key, tbl[i]->val);
    }
}

void tbl_multi_inputs(void) {
    char *tmp = input("key val :\n");
    while (*tmp != '\0') {
        char *key = strtok(tmp, ": \t");
        int val = atoi(strtok(NULL, ": \t"));
        tbl_put(key, val);
        tmp = input("");
    }
}
