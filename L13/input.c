#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#ifndef _MEM_
#define _MEM_ 256
#endif

char _input_str[_MEM_][_MEM_];
int _input_str_index = 0;

char* input(char *disc, ...) {
    if (_input_str_index == _MEM_) {
        printf("!!coution!! : buffers are lacked!\n");
        // return NULL;
        _input_str_index = 0; // 古いものから上書き
    }

    va_list args;
    va_start(args, disc);
    vprintf(disc, args);
    va_end(args);

    fgets(_input_str[_input_str_index], _MEM_, stdin);
    
    // '\n'削除

    // int len = 0;
    // for (;_input_str[_input_str_index][len] != '\0'; len++);
    int len = strlen(_input_str[_input_str_index]);
    
    if (_input_str[_input_str_index][len-1] == '\n') {
        _input_str[_input_str_index][len-1] = '\0';
    }

    return _input_str[_input_str_index++];
}
