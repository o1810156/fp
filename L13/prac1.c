#include <stdio.h>
#include <stdbool.h>
// #include <string.h>
#define MEM 100

bool getl(char s[], int lim) {
    int c, i = 0;
    for(c = getchar(); c != EOF && c != '\n'; c = getchar()) {
        s[i++] = c; if(i+1 >= lim) { break; }
    }
    s[i] = '\0'; return c != EOF;
}

void printtriangle(char s[]) {
    int i = 0;
    while(s[i] != '\0') { 
        printf("%s\n", s+i);
        i++;
    }
}

void swap(char *str, int i, int j) {
    char tmp = str[i];
    str[i] = str[j];
    str[j] = tmp;
}

// a

int my_strlen(char *s) {
    int res = 0;
    for(;s[res] != '\0';res++);
    return res;
}

// b

void printtriangle_tail(char *s) {
    if (s[0] == '\0') return;

    printf("%s\n", s);
    int i;
    for (i = 0; s[i] != '\0';i++);
    char tmp = s[i-1];
    s[i-1] = '\0';
    printtriangle_tail(s);
    s[i-1] = tmp;
}

// c
void mapchar(char *s, char c1, char c2) {
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c1) s[i] = c2;
    }
}

// d
void deletechar(char *s, char c1) {
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c1) {
            for (int j = i; s[j] != '\0'; j++) s[j] = s[j+1];
        }
    }
}

// void my_strcpy(char *s1, char *s2);

// e
void reverse(char *s) {
    int len = 0;
    for (; s[len] != 0; len++);
    len--;

    for (int j = 0; j < len/2; j++) swap(s, j, len-j);
    /*
    char s2[MEM];
    my_strcpy(s2, s);

    for (int j = 0; j <= len; j++) s[j] = s2[len-j];
    */
}

// f
void my_strcpy(char *s1, char *s2) {
    int i;
    for (i = 0; s2[i] != '\0'; i++) {
        s1[i] = s2[i];
    }
    s1[i] = '\0';
}

// g
void my_strcat(char *s1, char *s2) {
    int i, j;
    for (i = 0; s1[i] != '\0'; i++);
    for (j = i; s2[j-i] != '\0'; j++) s1[j] = s2[j-i];
    s1[j] = '\0';
}

// h
int my_strcmp(char *s1, char *s2) {
    for (int i = 0; s1[i] != '\0' || s2[i] != '\0'; i++) {
        if (s1[i] < s2[i]) {
            return -1;
        } else if (s1[i] > s2[i]) {
            return 1;
        }
    }
    return 0;
}

int main(void) {
    char buf[MEM];
    printf("s> "); getl(buf, MEM);
    printtriangle(buf);

    // a
    printf("\n# a\nlen : %d\n", my_strlen(buf));

    // b
    printf("\n# b\n");
    printtriangle_tail(buf);

    char buf2[MEM];
    my_strcpy(buf2, buf);

    // c
    mapchar(buf2, ' ', '*');
    printf("\n# c\nreplaced : %s\n", buf2);

    my_strcpy(buf2, buf);

    // d
    deletechar(buf2, ' ');
    printf("\n# d\ndeleted : %s\n", buf2);

    my_strcpy(buf2, buf);

    // e
    reverse(buf2);
    printf("\n# e\nreversed : %s\n", buf2);

    // f
    my_strcpy(buf2, buf);
    printf("\n# f\ncopyed : %s\n", buf2);

    // g
    char buf3[MEM];
    printf("\n# g\ns> "); getl(buf3, MEM);
    my_strcat(buf2, buf3);
    printf("concated : %s\n", buf2);

    // h
    printf("\n# h\n");
    printf("abcd abcd -> %d\n", my_strcmp("abcd", "abcd")); // 0
    printf("abcd abaa -> %d\n", my_strcmp("abcd", "abaa")); // 1
    printf("abcd abcz -> %d\n", my_strcmp("abcd", "abcz")); // -1
    printf("abcd abc  -> %d\n", my_strcmp("abcd", "abc")); // 1
    printf("abc  abcd -> %d\n", my_strcmp("abc", "abcd")); // -1

    return 0;
}

/*
s> a b c d
a b c d
 b c d
b c d
 c d
c d
 d
d

# a
len : 7

# b
a b c d
a b c 
a b c
a b 
a b
a 
a

# c
replaced : a*b*c*d

# d
deleted : abcd

# e
reversed : d c b a

# f
copyed : a b c d

# g
s>  e f g h
concated : a b c d e f g h

# h
abcd abcd -> 0
abcd abaa -> 1
abcd abcz -> -1
abcd abc  -> 1
abc  abcd -> -1
*/
