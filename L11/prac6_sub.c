#include <stdio.h>

int main(void) {
    char t = '\"';
    printf("%d\n", (int)t );
    printf("%c\n", (char)34 );

    char u = '\n';
    printf("%d\n", (int)u );
    printf("t%ct\n", (char)10 );

    return 0;
}
