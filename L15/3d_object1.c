#include <stdio.h>
#include <math.h>
#include "img.h"
#include "3d_pic.h"

static int
    sp_r = 10,
    box_size = 100,
    mw = WIDTH/2,
    mh = HEIGHT/2,
    mz = 150;

struct color
    red = {255, 0, 0},
    orange = {255, 165, 0},
    yellow = {255, 255, 0},
    green = {0, 128, 0},
    aqua = {0, 255, 255},
    blue = {0, 0, 255};

int main(void) {
    int box_size_2 = box_size / 2;
    camera_init(100, 50, 250);
    center_init((struct vector3){mw, mh, mz});
    light_init((struct vector3){1, 1, -1});

    double
        x = mw,
        y = mh / 2.0,
        z = 55;

    for (int i = 0; i < 360; i+=5) {
        clear3d();
        struct vector3 p[8];
        p[0] = (struct vector3){mw-box_size_2, mh-box_size_2, mz-box_size_2};
        // p[0] = (struct vector3){100, 50, 100};
        p[1] = (struct vector3){mw-box_size_2, mh+box_size_2, mz-box_size_2};
        // p[1] = (struct vector3){100, 150, 100};
        p[2] = (struct vector3){mw+box_size_2, mh+box_size_2, mz-box_size_2};
        // p[2] = (struct vector3){200, 150, 100};
        p[3] = (struct vector3){mw+box_size_2, mh-box_size_2, mz-box_size_2};
        // p[3] = (struct vector3){200, 50, 100};
        p[4] = (struct vector3){mw-box_size_2, mh-box_size_2, mz+box_size_2};
        // p[4] = (struct vector3){100, 50, 200};
        p[5] = (struct vector3){mw-box_size_2, mh+box_size_2, mz+box_size_2};
        // p[5] = (struct vector3){100, 150, 200};
        p[6] = (struct vector3){mw+box_size_2, mh+box_size_2, mz+box_size_2};
        // p[6] = (struct vector3){200, 150, 200};
        p[7] = (struct vector3){mw+box_size_2, mh-box_size_2, mz+box_size_2};
        // p[7] = (struct vector3){200, 50, 200};

        for (int j = 0; j < 8; j++) {
            p[j] = roteZ(p[j], M_PI*(45 / 180.0));
            p[j] = roteX(p[j], M_PI*(i / 180.0));
            p[j] = roteY(p[j], M_PI*(i / 180.0));
        }

        struct vector3
            sf0[] = {p[0], p[1], p[2], p[3]},
            sf1[] = {p[0], p[1], p[5], p[4]},
            sf2[] = {p[3], p[2], p[6], p[7]},
            sf3[] = {p[4], p[5], p[6], p[7]},
            sf4[] = {p[0], p[3], p[7], p[4]},
            sf5[] = {p[1], p[2], p[6], p[5]};

        struct vector3
            sf0_n = get_normal(sf0[0], sf0[1], sf0[2]),
            sf1_n = get_normal(sf1[0], sf1[1], sf1[2]),
            sf2_n = get_normal(sf2[0], sf2[1], sf2[2]),
            sf3_n = get_normal(sf3[0], sf3[1], sf3[2]),
            sf4_n = get_normal(sf4[0], sf4[1], sf4[2]),
            sf5_n = get_normal(sf5[0], sf5[1], sf5[2]);

        fill_polygon(shaded(red, sf0_n), 4, sf0);
        fill_polygon(shaded(orange, sf1_n), 4, sf1);
        fill_polygon(shaded(yellow, sf2_n), 4, sf2);
        fill_polygon(shaded(green, sf3_n), 4, sf3);
        fill_polygon(shaded(aqua, sf4_n), 4, sf4);
        fill_polygon(shaded(blue, sf5_n), 4, sf5);

        img_write();
    }
}