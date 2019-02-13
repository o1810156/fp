#include "img.h"
#include "3d_pic.h"
#include <math.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.141592653589793
#endif

#ifndef MEM
#define MEM 1024
#endif

#ifndef DELTA
#define DELTA 0
#endif

void dice_eyes(struct vector3 circle_points[][MEM], int points_len[21], struct vector3 sf_g[6]){

    int r = 6;
    // サイコロの目の描写
    // 面が最初上下を向いている場合
    //1の目
    double sf_x, sf_y, sf_z;
    sf_x = sf_g[0].x;
    sf_y = sf_g[0].y;
    sf_z = sf_g[0].z;
    for (int i = -r; i < r; i++) {
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[0][points_len[0]++] = (struct vector3){sf_x + j, sf_y + DELTA, sf_z + i};
            }
        }
    }
    //6の目
    sf_x = sf_g[1].x;
    sf_y = sf_g[1].y;
    sf_z = sf_g[1].z;
    sf_x=sf_x-25;
    sf_z=sf_z-25;
    for (int i = -r; i < r; i++) {//1/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
	            circle_points[1][points_len[1]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }
    sf_z=sf_z+25;
    for (int i = -r; i < r; i++) {//2/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[2][points_len[2]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }
    sf_z=sf_z+25;
    for (int i = -r; i < r; i++) {//3/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[3][points_len[3]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }

    sf_x=sf_x+50;
    for (int i = -r; i < r; i++) {//4/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[4][points_len[4]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }
    sf_z=sf_z-25;
    for (int i = -r; i < r; i++) {//5/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[5][points_len[5]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }
    sf_z=sf_z-25;
    for (int i = -r; i < r; i++) {//6/6
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[6][points_len[6]++] = (struct vector3){sf_x + j, sf_y - DELTA, sf_z + i};
            }
        }
    }
    // 面が最初左右を向いている場合
    //3の目
    sf_x = sf_g[2].x;
    sf_y = sf_g[2].y;
    sf_z = sf_g[2].z;
    for (int i = -r; i < r; i++) {//1/3
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[7][points_len[7]++] = (struct vector3){sf_x + DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    sf_z=sf_z-25;
    sf_y=sf_y-25;
    for (int i = -r; i < r; i++) {//2/3
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[8][points_len[8]++] = (struct vector3){sf_x + DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    sf_z=sf_z+50;
    sf_y=sf_y+50;
    for (int i = -r; i < r; i++) {//3/3
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[9][points_len[9]++] = (struct vector3){sf_x + DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    //4の目
    sf_x = sf_g[3].x;
    sf_y = sf_g[3].y;
    sf_z = sf_g[3].z;
    sf_z=sf_z-25;
    sf_y=sf_y-25;
    for (int i = -r; i < r; i++) {//1/4
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[10][points_len[10]++] = (struct vector3){sf_x - DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    sf_y=sf_y+50;
    for (int i = -r; i < r; i++) {//2/4
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[11][points_len[11]++] = (struct vector3){sf_x - DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    sf_z=sf_z+50;
    for (int i = -r; i < r; i++) {//3/4
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[12][points_len[12]++] = (struct vector3){sf_x - DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    sf_y=sf_y-25;
    for (int i = -r; i < r; i++) {//4/4
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[13][points_len[13]++] = (struct vector3){sf_x - DELTA, sf_y + i, sf_z + j};
            }
        }
    }
    // 面が最初手前と奥を向いている場合
    //2の目
    sf_x = sf_g[4].x;
    sf_y = sf_g[4].y;
    sf_z = sf_g[4].z;
    sf_x=sf_x-17;
    sf_y=sf_y-17;
    for (int i = -r; i < r; i++) {//1/2
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[14][points_len[14]++] = (struct vector3){sf_x + i, sf_y + j, sf_z - DELTA};
            }
        }
    }
    sf_x=sf_x+33;
    sf_y=sf_y+33;
    for (int i = -r; i < r; i++) {//2/2
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[15][points_len[15]++] = (struct vector3){sf_x + i, sf_y + j, sf_z - DELTA};
            }
        }
    }
    //5の目
    sf_x = sf_g[5].x;
    sf_y = sf_g[5].y;
    sf_z = sf_g[5].z;
    for (int i = -r; i < r; i++) {//1/5
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[16][points_len[16]++] = (struct vector3){sf_x + i, sf_y + j, sf_z + DELTA};
            }
        }
    }
    sf_x=sf_x-25;
    sf_y=sf_y-25;
    for (int i = -r; i < r; i++) {//2/5
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[17][points_len[17]++] = (struct vector3){sf_x + i, sf_y + j, sf_z + DELTA};
            }
        }
    }
    sf_y=sf_y+50;
    for (int i = -r; i < r; i++) {//3/5
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[18][points_len[18]++] = (struct vector3){sf_x + i, sf_y + j, sf_z + DELTA};
            }
        }
    }
    sf_x=sf_x+50;
    for (int i = -r; i < r; i++) {//4/5
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[19][points_len[19]++] = (struct vector3){sf_x + i, sf_y + j, sf_z + DELTA};
            }
        }
    }
    sf_y=sf_y-50;
    for (int i = -r; i < r; i++) {//5/5
        for (int j = -r; j < r; j++) {
            if (i*i + j*j < r*r) {
                circle_points[20][points_len[20]++] = (struct vector3){sf_x + i, sf_y + j, sf_z + DELTA};
            }
        }
    }
}
// サイコロの目の描写ここまで


int main(void) {
    struct vector3 circle_points[21][MEM];
    int cp_len[21]; // circle_pointsのインデックス


    // 左手系(xは右、yは上、zは奥)

    // 座標関連
    const int
        z_max = 250, // z軸の最大座標
        z_min = 50; // z軸の最小座標

    const int
        center_x = WIDTH / 2,
        center_y = HEIGHT / 2,
        center_z = (z_max+z_min) / 2;

    const struct vector3 center = {center_x, center_y, center_z};

    // 箱の描画関連
    const int box_size = 100;
    const int bsh = box_size / 2; // box_size_halfの略 
    const struct color white = {255, 255, 255};
    const struct color gray = {200, 200, 200};
 
    camera_init(100, z_max, z_min); // カメラの位置を指定 スクリーンの距離 z軸最大座標 z軸最小座標
    light_init((struct vector3){0, 0, -1}); // 無限遠光源の仮想位置
    center_init(center);

    for (int i = 180; i < 360; i+=5) {

        clear3d();

        for (int j = 0; j < WIDTH; j++) {
            for (int k = 0; k < HEIGHT; k++) {
                img_putpixel(gray, j, k);
            }
        }

        for(int j = 0; j < 21; j++){
            cp_len[j] = 0;
        }

        double theta = M_PI * i / 180.0;

        struct vector3 box_center = {center_x+100, center_y-100, center_z+100};
        // 箱の中心の回転
        box_center = roteZ(box_center, theta);

        struct vector3 box_points[] = {
	          {box_center.x-bsh, box_center.y+bsh, box_center.z-bsh+200},
            {box_center.x+bsh, box_center.y+bsh, box_center.z-bsh+200},
            {box_center.x+bsh, box_center.y-bsh, box_center.z-bsh+200},
            {box_center.x-bsh, box_center.y-bsh, box_center.z-bsh+200},

            {box_center.x-bsh, box_center.y+bsh, box_center.z+bsh+200},
            {box_center.x+bsh, box_center.y+bsh, box_center.z+bsh+200},
            {box_center.x+bsh, box_center.y-bsh, box_center.z+bsh+200},
            {box_center.x-bsh, box_center.y-bsh, box_center.z+bsh+200}
        };
        struct vector3 sf_g[] = {
            {(box_points[0].x + box_points[1].x + box_points[5].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[5].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[5].z + box_points[4].z) / 4.0},
            {(box_points[3].x + box_points[2].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[3].y + box_points[2].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[3].z + box_points[2].z + box_points[6].z + box_points[7].z) / 4.0},
            {(box_points[1].x + box_points[2].x + box_points[6].x + box_points[5].x) / 4.0,
            (box_points[1].y + box_points[2].y + box_points[6].y + box_points[5].y) / 4.0,
            (box_points[1].z + box_points[2].z + box_points[6].z + box_points[5].z) / 4.0},
            {(box_points[0].x + box_points[3].x + box_points[7].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[3].y + box_points[7].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[3].z + box_points[7].z + box_points[4].z) / 4.0},
            {(box_points[0].x + box_points[1].x + box_points[2].x + box_points[3].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[2].y + box_points[3].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[2].z + box_points[3].z) / 4.0},
            {(box_points[4].x + box_points[5].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[4].y + box_points[5].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[4].z + box_points[5].z + box_points[6].z + box_points[7].z) / 4.0}
        };

    	dice_eyes(circle_points, cp_len, sf_g);

        // 箱の頂点の回転
        center_init(box_center);

        for (int j = 0; j < 8; j++) {
            box_points[j] = roteX(box_points[j], theta);
        }
        for (int j = 0; j < 21; j++){
            for (int k = 0; k < cp_len[j]; k++){
                circle_points[j][k] = roteX(circle_points[j][k], theta);
                struct color c = j == 0 ? (struct color){255, 0, 0} : (struct color){0, 0, 0};
                projection(circle_points[j][k], c);
            }
        }
        center_init(center);

        // 面の描画

        // 面の配列
        struct vector3 sfs[][4] = {
            {box_points[0], box_points[1], box_points[2], box_points[3]},
            {box_points[0], box_points[1], box_points[5], box_points[4]},
            {box_points[3], box_points[2], box_points[6], box_points[7]},
            {box_points[4], box_points[5], box_points[6], box_points[7]},
            {box_points[0], box_points[3], box_points[7], box_points[4]},
            {box_points[1], box_points[2], box_points[6], box_points[5]}
        };

        
        // 法線ベクトルの取得と描画
        for (int j = 0; j < 6; j++) {
            struct vector3 norm = get_normal(sfs[j][0], sfs[j][1], sfs[j][2]);
            fill_polygon(shaded(white, norm), 4, sfs[j]);
        }

        img_write();
    }
    for (int i = 0; i < 180; i+=5) {

        clear3d();

        for (int j = 0; j < WIDTH; j++) {
            for (int k = 0; k < HEIGHT; k++) {
                img_putpixel(gray, j, k);
            }
        }

        for(int j = 0; j < 21; j++){
            cp_len[j] = 0;
        }

        double theta = M_PI * i / 180.0;

        struct vector3 box_center = {center_x+100, center_y-100, center_z+250};
        // 箱の中心の回転
	      box_center = roteZ(box_center, theta);

        struct vector3 box_points[] = {
	        {box_center.x-bsh, box_center.y+bsh, box_center.z-bsh},
            {box_center.x+bsh, box_center.y+bsh, box_center.z-bsh},
            {box_center.x+bsh, box_center.y-bsh, box_center.z-bsh},
            {box_center.x-bsh, box_center.y-bsh, box_center.z-bsh},

            {box_center.x-bsh, box_center.y+bsh, box_center.z+bsh},
            {box_center.x+bsh, box_center.y+bsh, box_center.z+bsh},
            {box_center.x+bsh, box_center.y-bsh, box_center.z+bsh},
            {box_center.x-bsh, box_center.y-bsh, box_center.z+bsh}
        };
        struct vector3 sf_g2[] = {
            {(box_points[0].x + box_points[1].x + box_points[5].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[5].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[5].z + box_points[4].z) / 4.0},
            {(box_points[3].x + box_points[2].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[3].y + box_points[2].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[3].z + box_points[2].z + box_points[6].z + box_points[7].z) / 4.0},
            {(box_points[1].x + box_points[2].x + box_points[6].x + box_points[5].x) / 4.0,
            (box_points[1].y + box_points[2].y + box_points[6].y + box_points[5].y) / 4.0,
            (box_points[1].z + box_points[2].z + box_points[6].z + box_points[5].z) / 4.0},
            {(box_points[0].x + box_points[3].x + box_points[7].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[3].y + box_points[7].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[3].z + box_points[7].z + box_points[4].z) / 4.0},
            {(box_points[0].x + box_points[1].x + box_points[2].x + box_points[3].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[2].y + box_points[3].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[2].z + box_points[3].z) / 4.0},
            {(box_points[4].x + box_points[5].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[4].y + box_points[5].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[4].z + box_points[5].z + box_points[6].z + box_points[7].z) / 4.0}
        };

	    dice_eyes(circle_points, cp_len, sf_g2);

        // 箱の頂点の回転
        center_init(box_center);

        for (int j = 0; j < 8; j++) {
            box_points[j] = roteX(box_points[j], theta);
            box_points[j] = roteY(box_points[j], theta);
        }
        for (int j = 0; j < 21; j++){
            for (int k = 0; k < cp_len[j]; k++){
                circle_points[j][k] = roteX(circle_points[j][k], theta);
                circle_points[j][k] = roteY(circle_points[j][k], theta);
                struct color c = j == 0 ? (struct color){255, 0, 0} : (struct color){0, 0, 0};
                projection(circle_points[j][k], c);
            }
        }
        center_init(center);

        // 面の描画

        // 面の配列
        struct vector3 sfs[][4] = {
            {box_points[0], box_points[1], box_points[2], box_points[3]},
            {box_points[0], box_points[1], box_points[5], box_points[4]},
            {box_points[3], box_points[2], box_points[6], box_points[7]},
            {box_points[4], box_points[5], box_points[6], box_points[7]},
            {box_points[0], box_points[3], box_points[7], box_points[4]},
            {box_points[1], box_points[2], box_points[6], box_points[5]}
        };
        
        // 法線ベクトルの取得と描画
        for (int j = 0; j < 6; j++) {
            struct vector3 norm = get_normal(sfs[j][0], sfs[j][1], sfs[j][2]);
            fill_polygon(shaded(white, norm), 4, sfs[j]);
        }

        img_write();
    }
    for (int i = 0; i < 360; i+=5) {

        clear3d();

        for (int j = 0; j < WIDTH; j++) {
            for (int k = 0; k < HEIGHT; k++) {
                img_putpixel(gray, j, k);
            }
        }

        for(int j = 0; j < 21; j++){
            cp_len[j] = 0;
        }

        double theta = M_PI * i / 180.0;

        struct vector3 box_center = {center_x-100, center_y+100, center_z+250};
        // 箱の中心の回転
    	//  box_center = roteZ(box_center, theta);

        struct vector3 box_points[] = {
	        {box_center.x-bsh, box_center.y+bsh, box_center.z-bsh},
            {box_center.x+bsh, box_center.y+bsh, box_center.z-bsh},
            {box_center.x+bsh, box_center.y-bsh, box_center.z-bsh},
            {box_center.x-bsh, box_center.y-bsh, box_center.z-bsh},

            {box_center.x-bsh, box_center.y+bsh, box_center.z+bsh},
            {box_center.x+bsh, box_center.y+bsh, box_center.z+bsh},
            {box_center.x+bsh, box_center.y-bsh, box_center.z+bsh},
            {box_center.x-bsh, box_center.y-bsh, box_center.z+bsh}
        };

        struct vector3 sf_g3[] = {
            {(box_points[0].x + box_points[1].x + box_points[5].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[5].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[5].z + box_points[4].z) / 4.0},
            {(box_points[3].x + box_points[2].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[3].y + box_points[2].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[3].z + box_points[2].z + box_points[6].z + box_points[7].z) / 4.0},
            {(box_points[1].x + box_points[2].x + box_points[6].x + box_points[5].x) / 4.0,
            (box_points[1].y + box_points[2].y + box_points[6].y + box_points[5].y) / 4.0,
            (box_points[1].z + box_points[2].z + box_points[6].z + box_points[5].z) / 4.0},
            {(box_points[0].x + box_points[3].x + box_points[7].x + box_points[4].x) / 4.0,
            (box_points[0].y + box_points[3].y + box_points[7].y + box_points[4].y) / 4.0,
            (box_points[0].z + box_points[3].z + box_points[7].z + box_points[4].z) / 4.0},
            {(box_points[0].x + box_points[1].x + box_points[2].x + box_points[3].x) / 4.0,
            (box_points[0].y + box_points[1].y + box_points[2].y + box_points[3].y) / 4.0,
            (box_points[0].z + box_points[1].z + box_points[2].z + box_points[3].z) / 4.0},
            {(box_points[4].x + box_points[5].x + box_points[6].x + box_points[7].x) / 4.0,
            (box_points[4].y + box_points[5].y + box_points[6].y + box_points[7].y) / 4.0,
            (box_points[4].z + box_points[5].z + box_points[6].z + box_points[7].z) / 4.0}
        };
	
        dice_eyes(circle_points, cp_len, sf_g3);

        // 箱の頂点の回転
        center_init(box_center);
        /* for (int j = 0; j < 8; j++) {
            box_points[j] = roteX(box_points[j], theta);
        } */
        for (int j = 0; j < 21; j++){
            for (int k = 0; k < cp_len[j]; k++){
                // circle_points[j][k] = roteX(circle_points[j][k], theta);
                circle_points[j][k] = roteZ(circle_points[j][k], M_PI);
                struct color c = j == 0 ? (struct color){255, 0, 0} : (struct color){0, 0, 0};
                projection(circle_points[j][k], c);
            }
        }
        center_init(center);

        // 面の描画

        // 面の配列
        struct vector3 sfs[][4] = {
            {box_points[0], box_points[1], box_points[2], box_points[3]},
            {box_points[0], box_points[1], box_points[5], box_points[4]},
            {box_points[3], box_points[2], box_points[6], box_points[7]},
            {box_points[4], box_points[5], box_points[6], box_points[7]},
            {box_points[0], box_points[3], box_points[7], box_points[4]},
            {box_points[1], box_points[2], box_points[6], box_points[5]}
        };
        
        // 法線ベクトルの取得と描画
        for (int j = 0; j < 6; j++) {
            struct vector3 norm = get_normal(sfs[j][0], sfs[j][1], sfs[j][2]);
            fill_polygon(shaded(white, norm), 4, sfs[j]);
        }

        img_write();
    }
}
