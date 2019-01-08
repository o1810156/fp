#include <stdio.h>

int main(void) {char s[256] = "#include <stdio.h>%c%cint main(void) {char s[256] = %c%s%c; printf(s, (char)10, (char)10, (char)34, s, (char)34); return 0;}"; printf(s, (char)10, (char)10, (char)34, s, (char)34); return 0;}