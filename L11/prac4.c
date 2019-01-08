#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

// 絶対値

double d_abs(double x) {
    if (x < 0) {
        return -x;
    } else {
        return x;
    }
}

double my_sqrt(double x, double acc) {
    if (x == 0) return 0;
    if (x < 0) x *= -1;

    double
        a = 0,
        b = x > 1 ? x : 1,
        c = x / 2.0;
    double dif = c*c - x;
    int counter = 0;

    while (d_abs(dif) > acc) {
        if (dif > 0) {
            b = c;
        } else {
            a = c;
        }
        c = (a + b) / 2.0;
        dif = c*c - x;
        counter++;
    }
    printf("counter : %d\n", counter);
    // printf("%d\n", counter);
    return c;
}

int main (void) {

    char str[MEM];
    
    double x = atof(input(str, "x : "));
    printf("sqrt(%.2lf) = %.10lf", x, my_sqrt(x, 1e-4));
    /*
    for (int i = 1; i <= 15; i++) {
        my_sqrt(5, pow(10, -i));
    } */

    return 0;
}

/*
// 1e-1
x : 5
counter : 6
sqrt(5.00) = 2.2265625000

// 1e-2
x : 5
counter : 8
sqrt(5.00) = 2.2363281250

// 1e-3
x : 5
counter : 13
sqrt(5.00) = 2.2360229492

// 1e-4
x : 5
counter : 16
sqrt(5.00) = 2.2360610962

// 1e-5
x : 5
counter : 19
sqrt(5.00) = 2.2360658646

// 1e-6
x : 5
counter : 23
sqrt(5.00) = 2.2360679507

// 1e-7
x : 5
counter : 26
sqrt(5.00) = 2.2360679880

// 1e-8
x : 5
counter : 28
sqrt(5.00) = 2.2360679787

// 1e-9
x : 5
counter : 31
sqrt(5.00) = 2.2360679775
*/

/*
6
8
13
16
19
23
26
28
31
31
31
41
44
48
52
*/