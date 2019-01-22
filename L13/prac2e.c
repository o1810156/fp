#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

/*
月nを入力すると、対応する月と日数を表示するプログラムを作成する。
存在しない月を入力した時には入力しなおさせる。

ただしうるう年はとりあえず考慮しない
*/

int main(int argc, char const *argv[]) {
    int n;

    if (argc > 1) {
        n = atoi(argv[1]);
    } else {
        n = atoi(input("month : "));
    }

    int days = 0;

    char month_list[][MEM] = {
        "Jannuary", "February",
        "March", "April",
        "May", "June",
        "July", "August",
        "September", "October",
        "November", "December"
    };

    while (1) {
        switch (n) {
            // 西向く侍
            case 2:
                days = 28;
                break;

            case 4: case 6:
            case 9: case 11:
                days = 30;
                break;

            case 1: case 3:
            case 5: case 7:
            case 8: case 10:
            case 12:
                days = 31;
                break;

            default:
                printf("No such month. please reinput. (1 ~ 12)\n");
                n = atoi(input("month : "));
                continue;
                break;
        }
        break;
    }
    printf("%d -> %s. in this month there are %d days", n, month_list[n-1], days);

    return 0;
}