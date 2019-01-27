#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include "prac3a.h"
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

int main(void) {
    char *b1, *b2;
    int val, ind;
    while(true) {
        b1 = input("key (empty for quit)> ");
        if(!b1 || strlen(b1) == 0) return 0;
        b2 = input("val (-1 for query)> ");
        val = atoi(b2);
        ind = atoi(input("ind (0 ~ %d)> ", val_max_ind-1));
        if(val != -1) {
            tbl_put(b1, val, ind);
        } else {
            printf("tbl[%s][%d] == %d\n", b1, ind, tbl_get(b1, ind));
        }
    }
}
