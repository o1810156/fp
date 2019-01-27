#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include "prac3bcd.h"
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
        b2 = input("val (-1:query, -2:del, -3:show, -4:multi)> ");
        val = atoi(b2);
        switch (val) {
            case -1:
                printf("tbl[%s] == %d\n", b1, tbl_get(b1));
                break;
            case -2:
                tbl_rm(b1);
                break;
            case -3:
                tbl_show();
                break;
            case -4:
                tbl_multi_inputs();
                break;
            default:
                tbl_put(b1, val);
                break;
        }
    }
}
