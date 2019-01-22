#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include "input.h"

int my_atoi(char *s) {
    int
        sign = 1,
        val = 0;
    
    bool
        oct = false,
        hex = false;

    switch (*s) {
        case '-':
            sign = -1;
        case '0':
            oct = true;
        case '+':
            ++s;
    }

    if (oct && *s == 'x') {
        oct = false;
        hex = true;
        s++;
    }

    // a b
    if (hex) {
        while (true) {
            char c = *s++;
            if ('0' <= c && c <= '9') {
                val = val * 16 + (c - '0');
            } else if ('a' <= c && c <= 'f') {
                val = val * 16 + (c - 'a' + 10);
            } else if ('A' <= c && c <= 'F') {
                val = val * 16 + (c - 'A' + 10);
            } else {
                return sign * val;
            }
        }
    } else if (oct) {
        while (true) {
            char c = *s++;
            if ('0' <= c && c < '8') {
                val = val * 8 + (c - '0');
            } else {
                return sign * val;
            }
        }
    } else {
        while(true) {
            char c = *s++;
            switch(c) {
                case '0': case '1':
                case '2': case '3':
                case '4': case '5':
                case '6': case '7':
                case '8': case '9':
                    val = val * 10 + (c - '0');
                    break;
                default:
                    return sign * val;
            }
        }
    }
}

// e
double my_atof(char *s) {
    int sign = 1;
    double val = 0;

    switch (*s) {
        case '-':
            sign = -1;
        case '+':
            ++s;
    }

    while (true) {
        char c = *s;
        if ('0' <= c && c <= '9') {
            val = val * 10 + (c - '0');
        } else if (c == '.' || c == 'e') {
            break;
        } else {
            return sign * val;
        }
        s++;
    }

    if (*s++ == '.') {
        for (double t = 0.1; true; t *= 0.1) {
            char c = *s++;
            if ('0' <= c && c <= '9') {
                val += (c - '0') * t;
            // d
            } else if (c == 'e') {
                break;
            } else {
                return sign * val;
            }
        }
    }

    int
        e_sign = 1,
        e = 0;

    switch (*s) {
        case '-':
            sign = -1;
        case '+':
            ++s;
    }

    char c = *s++;
    if ('1' <= c && c <= '9') {
        e = e * 10 + (c - '0');
    } else {
        return sign * val;
    }

    while (true) {
        char c = *s++;
        if ('0' <= c && c <= '9') {
            e = e * 10 + (c - '0');
        } else {
            return sign * val * pow(10, e_sign * e);
        }
    }
}

int main(int argc, char *argv[]) {
    // int i = my_atoi(argv[1]);
    int n;
    double x;
    if (argc > 1) {
        n = my_atoi(argv[1]);
        x = my_atof(argv[1]);
    } else {
        char *s = input("x : ");
        n = my_atoi(s);
        x = my_atof(s);
    }

    printf("atoi : %d\n", n);
    printf("atof : %.3lf\n", x);

    return 0;
}
