#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MEM 256

#include <limits.h>

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

// a

void nabeatu(int max) {
    for (int i = 1; i <= max; i++) {
        if (i % 3 == 0) {
            printf("aho\n");
            continue;
        }
        int flag = 1,
            digit = (int)log10(i) + 1;
        while (flag && digit > 0) {
            if ( (i % (int)pow(10, digit) / (int)pow(10, digit-1)) == 3) {
                printf("aho\n");
                flag = 0;
            }
            digit--;
        }
        if (flag) printf("%d\n", i);
    }
}

// b

void fizzbuzz(int max) {
    for (int i = 1; i <= max; i++) {
        if (i % 15 == 0) {
            printf("fizzbuzz\n");
        } else if (i % 5 == 0) {
            printf("buzz\n");
        } else if (i % 3 == 0) {
            printf("fizz\n");
        } else {
            printf("%d\n", i);
        }
    }
}

// c エラトステネスの篩

void primes_byErat(int* primes_arr, int n) { // n == len(primes_arr)-1
    for (int i = 2; i <= sqrt(n); i++) {
        if (primes_arr[i] == 0) continue;
        for (int j = i * 2; j <= n; j += i) {
            if (primes_arr[j] != 0) primes_arr[j] = 0;
        }
    }

    int res = 0;
    for (int i = 2; i <= n; i++) {
        if (primes_arr[i] != 0) printf("%d\n", i);
        // if (primes_arr[i] != 0) res++;
    }
    // printf("primes num : %d\n", res);
}

// 限界まで攻めてみた -> できなかった...orz
/*
void primes_byErat_ull(unsigned long long int* primes_arr, unsigned long long int n) { // n == len(primes_arr)-1
    for (unsigned long long int i = 2; i <= sqrt(n); i++) {
        if (primes_arr[i] == 0) continue;
        for (unsigned long long int j = i * 2; j <= n; j += i) {
            if (primes_arr[j] != 0) primes_arr[j] = 0;
        }
    }

    unsigned long long int res = 0;
    for (unsigned long long int i = 2; i <= n; i++) {
        // if (primes_arr[i] != 0) printf("%d\n", i);
        if (primes_arr[i] != 0) res++;
        printf("beep\n");
    }
    printf("primes num : %d\n", res);
}
*/

// i 円周率の数値積分

double calculate_pi(double dx) {
    double res = 0;
    for (double x = 0; x <= 1; x += dx) {
        res += sqrt(1 - x*x) * dx;
    }
    return res * 4;
}

int main (void) {

    char str[MEM];

    printf("## a nabeatu\n");
    nabeatu(99);
    printf("\n## b fizzbuzz\n");
    fizzbuzz(99);

    int n = atoi(input(str, "\n## c prime numbers\nn : "));
    int* primes_arr = (int *)malloc((n+1) * sizeof(int));
    for (int i = 0; i <= n; i++) primes_arr[i] = 1;
    primes_byErat(primes_arr, n);
    free(primes_arr);

    // 限界に挑戦しようとしたができなかった
    /*
    unsigned long long int m = ULLONG_MAX;
    unsigned long long int* primes_arr_ull = (unsigned long long int *)malloc((m+1) * sizeof(unsigned long long int));
    if (primes_arr_ull == NULL) {
        printf("Allocating memories was failure.\n");
        return 0;
    }
    for (unsigned long long int i = 0; i <= m; i++) primes_arr[i] = 1;
    printf("Initializing was success.\n");
    primes_byErat_ull(primes_arr_ull, m);
    free(primes_arr_ull); */

    n = atoi(input(str, "\n## d count down\nn : "));
    for (int i = n, j = 0; i > 0; i--, j++) {
        if (j % 10 == 0) printf("\n");
        printf("%2d ", i);
    }
    printf("\n");

    n = atoi(input(str, "\n## e chess board (1) \nn : "));
    for (int i = 0; i < n; i++) {
        if (i % 10 == 0) printf("\n");
        printf("%d ", i % 2);
    }
    printf("\n");

    n = atoi(input(str, "\n## f chess board (2) \nn : "));
    for (int i = 1; i <= n; i++) {
        if (i % 10 == 1) printf("\n");
        printf("%d ", i % 2);
    }
    printf("\n");

    n = atoi(input(str, "\n## g 3^n \nn : "));
    for (int i = 0; i < n; i++) {
        if (i % 10 == 0) printf("\n");
        printf("%d ", (int)pow(3, i));
    }
    printf("\n");

    printf("\n## h multiplication table \n\n* |");
    for (int i = 1; i <= 9; i++) printf(" %2d", i);
    printf("\n---");
    for (int i = 1; i <= 9; i++) printf("---");
    for (int i = 1; i <= 9; i++) {
        printf("\n%d |", i);
        for (int j = 1; j <= 9; j++) printf(" %2d", i*j);
    }
    printf("\n");

    // i C言語で数値積分

    printf("\n## i\npi = %lf\n", calculate_pi(1e-10));

    return 0;
}