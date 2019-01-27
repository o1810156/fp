#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "prac3bcd.h"
#include "input.h"
#define MAXTBL 1000000

struct ent {
    char *key;
    int val;
};

struct ent tbl[MAXTBL];
int tblsize = 0;

int tbl_get(char *k) {
    for(int i = 0; i < tblsize; i++) {
        if(strcmp(tbl[i].key, k) == 0) return tbl[i].val;
    }
    return -1;
}

bool tbl_put(char *k, int v) {
    for(int i = 0; i < tblsize; i++) {
        if(strcmp(tbl[i].key, k) == 0) {
            tbl[i].val = v;
            return true;
        }
    }

    if(tblsize + 1 >= MAXTBL) return false;

    char *s = (char*)malloc(strlen(k)+1);
    if(s == NULL) return false;

    strcpy(s, k);
    tbl[tblsize].key = s;
    tbl[tblsize++].val = v;

    return true;
}

bool tbl_rm(char *k) {
    for (int i = 0; i < tblsize; i++) {
        if(strcmp(tbl[i].key, k) == 0) {
            // strcpy(tbl[i].key, "");
            *(tbl[i].key) = '\0';
            free(tbl[i].key);
            tbl[i].val = 0;
            for (int j = i; j < tblsize-1; j++) tbl[j] = tbl[j+1];
            tblsize--;
            return true;
        }
    }
    return false;
}

void tbl_show(void) {
    printf("key\tval\n");
    for (int i = 0; i < tblsize; i++) printf("%s\t%d\n", tbl[i].key, tbl[i].val);
}

void tbl_multi_inputs(void) {
    char *tmp = input("key val :\n");
    while (*tmp != '\0') {
        char *key = strtok(tmp, ": \t");
        int val = atoi(strtok(NULL, ": \t"));
        // printf("key: %s, val: %d\n", key, val);
        tbl_put(key, val);
        tmp = input("");
    }
}
