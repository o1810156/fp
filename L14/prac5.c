#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "prac5.h"
#define MAXTBL 97
// #define MAXTBL 9973
// #define MAXTBL 999983 // 1000000以下最大の素数
// #define MAXTBL 9999991 // 10000000以下の最大の素数

struct ent { char *key; int val; struct ent *next; };
struct ent *tbl[MAXTBL];

static unsigned int hash(char *s) {
    unsigned int v = 1;
    while(*s) { v *= 11 * (*s++) + 1; }
    // unsigned int v = 1, w = 1;
    // char *t = s, *u = s;
    // while(*t) { v *= 11 * (*t++) + 1; }
    // while(*u) { w *= 13 * (*u++) + 1; }
    // while(*s) { v *= 997 * (*s++) + 1; }
    // while(*s) { v *= 9973 * (*s++) + 1; }
    // while(*s) { v *= 99991 * (*s++) + 1; }
    return v % MAXTBL;
    // return (unsigned int)(v^w) % MAXTBL;
}

static struct ent *lookup(struct ent *p, char *k) {
    for( ; p != NULL; p = p->next) {
        if(strcmp(p->key, k) == 0) { return p; }
    }
    return NULL;
}

static int get1(struct ent *p, char *k) {
    struct ent *q = lookup(p, k);
    return (q == NULL) ? -1 : q->val;
}

static bool put1(struct ent **p, char *k, int v) {
    struct ent *q = lookup(*p, k);
    if(q != NULL) { q->val = v; return true; }
    q = (struct ent*)malloc(sizeof(struct ent));
    if(q == NULL) { return false; }
    int len = strlen(k);
    q->key = (char*)malloc(len+1);
    if(q->key == NULL) { return false; }
    strcpy(q->key, k);
    q->val = v; q->next = *p; *p = q; return true;
}

int tbl_get(char *k) {
    return get1(tbl[hash(k)], k);
}

bool tbl_put(char *k, int v) {
    return put1(&tbl[hash(k)], k, v);
}