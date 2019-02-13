#include "img.h"
#include "3d_pic.h"
#include <math.h>

#ifndef M_PI
#define M_PI 3.141592653589793
#endif

int main(void) {

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
    const struct color aqua = {0, 255, 255};

    camera_init(100, z_max, z_min); // カメラの位置を指定 スクリーンの距離 z軸最大座標 z軸最小座標
    light_init((struct vector3){0, 0, -1}); // 無限遠光源の仮想位置
    center_init(center);

    for (int i = 0; i < 360; i+=5) {

        clear3d(); // img_clearではなくclear3dを呼んでください。

        double theta = M_PI * i / 180.0;

        struct vector3 box_center = {center_x+100, center_y-100, center_z};
        // 箱の中心の回転
        box_center = roteY(box_center, theta);

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

        // 箱の頂点の回転
        center_init(box_center);
        for (int j = 0; j < 8; j++) {
            box_points[j] = roteY(box_points[j], theta);
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
            fill_polygon(shaded(aqua, norm), 4, sfs[j]);
        }

        img_write();
    }
}