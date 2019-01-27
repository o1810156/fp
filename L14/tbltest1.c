#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include "tbl.h"
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

int main(void) {
    char *b1, *b2;
    int val;
    while(true) {
        b1 = input("key (empty for quit)> ");
        if(!b1 || strlen(b1) == 0) return 0;
        b2 = input("val (-1 for query)> ");
        val = atoi(b2);
        if(val != -1) {
            tbl_put(b1, val);
        } else {
            printf("tbl[%s] == %d\n", b1, tbl_get(b1));
        }
    }
}

/*
int main(void) {
    char b1[100], b2[100];
    int val;
    while(true) {
        printf("key (empty for quit)> ");
        if(!getline(b1, 100) || strlen(b1) == 0) { return 0; }
        printf("val (-1 for query)> "); getline(b2, 100); val = atoi(b2);
        if(val != -1) { tbl_put(b1, val); }
        else { printf("tbl[%s] == %d\n", b1, tbl_get(b1)); }
    }
}
*/