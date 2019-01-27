#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#define MAXTBL 1000000
#ifndef MEM
#define MEM 256
#endif

struct ent {
    char *key;
    int val[MEM];
};

struct ent tbl[MAXTBL];
int tblsize = 0;
const int val_max_ind = MEM;

int tbl_get(char *k, int ind) {
    if (ind < 0 || ind >= val_max_ind) return -1;
 
    for(int i = 0; i < tblsize; ++i) {
        if(strcmp(tbl[i].key, k) == 0) return tbl[i].val[ind];
    }
    return -1;
}

bool tbl_put(char *k, int v, int ind) {
    if (ind < 0 || ind >= val_max_ind) return false;

    for(int i = 0; i < tblsize; ++i) {
        if(strcmp(tbl[i].key, k) == 0) {
            tbl[i].val[ind] = v;
            return true;
        }
    }

    if(tblsize + 1 >= MAXTBL) return false;

    char *s = (char*)malloc(strlen(k)+1);
    if(s == NULL) return false;

    strcpy(s, k);
    tbl[tblsize].key = s;
    tbl[tblsize++].val[ind] = v;

    return true;
}
