#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "tbl.h"
#define MAXTBL 1000000

struct ent { char *key; int val; };
struct ent tbl[MAXTBL];
int tblsize = 0;

int tbl_get(char *k) {
    int i;
    for(i = 0; i < tblsize; ++i) {
        if(strcmp(tbl[i].key, k) == 0) { return tbl[i].val; }
    }
    return -1;
}

bool tbl_put(char *k, int v) {
    int i;
    for(i = 0; i < tblsize; ++i) {
        if(strcmp(tbl[i].key, k) == 0) { tbl[i].val = v; return true; }
    }

    if(tblsize+1 >= MAXTBL) { return false; }
    char *s = (char*)malloc(strlen(k)+1);
    if(s == NULL) { return false; }
    strcpy(s, k); tbl[tblsize].key = s; tbl[tblsize].val = v;
    ++tblsize; return true;
}
