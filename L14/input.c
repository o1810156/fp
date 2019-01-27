#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#ifndef _MEM_
#define _MEM_ 256
#endif

char* input(char *desc, ...) {
    size_t input_str_mem = _MEM_ * sizeof(char);
    char *input_str = (char *)malloc(input_str_mem);
    int len = 0;

    if (input_str == NULL) {
        printf("!!coution!! : buffers are lacked!\n");
        return NULL;
    }

    *input_str = '\0'; // input_str = ""

    va_list args;
    va_start(args, desc);
    vprintf(desc, args);
    va_end(args);

    // fgets(_input_str[_input_str_index], _MEM_, stdin);
    for (char c = getchar(); c != '\n' && c != EOF; c = getchar(), len++) {
        if (len+1 >= input_str_mem / sizeof(char)) {
            // input_str[len]にも'\0'が入るのでlen+1 == input_str_memのときメモリを取り直す必要がある
            char *tmp = realloc(input_str, input_str_mem + _MEM_ * sizeof(char));
            // char *tmp = NULL; // デバッグ用
            if (tmp == NULL) {
                printf("failed to malloc.\n");
                while (c != '\n' && c != EOF) c = getchar();
                len--;
                break;
            }
            input_str = tmp;
            input_str_mem += _MEM_ * sizeof(char);
        }
        input_str[len] = c;
    }

    // '\0'挿入
    input_str[len] = '\0';

    return input_str;
}
