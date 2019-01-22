#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input.h"
#ifndef MEM
#define MEM 256
#endif

void dot(double a[][MEM],
        double b[][MEM],
        double c[][MEM],
        int top, int middle, int bottom) {
    for (int i = 0; i < top; i++) {
        for (int j = 0; j < bottom; j++) {
            c[i][j] = 0;
            for (int k = 0; k < middle; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

int main(void) {

    // 入力

    char *shape = input("shape? (i, k, j) : ");
    int
        top = atoi(strtok(shape, " ,")),
        middle = atoi(strtok(NULL, " ,")),
        bottom = atoi(strtok(NULL, " ,"));
    
    double a[MEM][MEM], b[MEM][MEM], c[MEM][MEM];

    printf("a : \n");

    for (int i = 0; i < top; i++) {
        char *line = input("");
        a[i][0] = atof(strtok(line, " ,"));
        for (int k = 1; k < middle; k++) {
            a[i][k] = atof(strtok(NULL, " ,"));
        }
    }

    printf("b : \n");

    for (int k = 0; k < middle; k++) {
        char *line = input("");
        b[k][0] = atof(strtok(line, " ,"));
        for (int j = 1; j < bottom; j++) {
            b[k][j] = atof(strtok(NULL, " ,"));
        }
    }

    // 処理

    dot(a, b, c, top, middle, bottom);

    // 出力

    printf("c = \n");

    for (int i = 0; i < top; i++) {
        for (int j = 0; j < bottom; j++) {
            printf("%.2lf ", c[i][j]);
        }
        printf("\n");
    }

    return 0;
}