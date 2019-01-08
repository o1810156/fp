#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

double my_sqrt(double x, double dx) {
    if (x == 0) return 0;
    if (x < 0) x *= -1;

    double res = 0;
    for (; res*res - x < 0 ; res += dx);
    return res;
}

int main (void) {

    char str[MEM];
    
    double x = atof(input(str, "x : "));
    printf("sqrt(%.2lf) = %.10lf", x, my_sqrt(x, 1e-9));

    return 0;
}

/*
// 1e-5
x : 5
sqrt(5.00) = 2.2360700000

// 1e-6
x : 5
sqrt(5.00) = 2.2360680000

// 1e-7
x : 5
sqrt(5.00) = 2.2360679999

// 1e-8
x : 5
sqrt(5.00) = 2.2360679848

// 1e-9
x : 5
sqrt(5.00) = 2.2360679778
*/