/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_ffotd.gsc
***********************************************/

#using scripts\core_common\system_shared;
#namespace zm_gold_ffotd;

function private autoexec __init__system__() {
  system::register(#"zm_gold_ffotd", &preinit, &postinit, undefined, undefined);
}

function private preinit() {}

function private postinit() {
  spawncollision("collision_clip_64x64x256", "collider", (-48885, -20837, 733), (0, 112.398, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48849, -20837, 733), (0, 69.199, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48834, -20856, 733), (0, 9.6, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48858, -20908, 733), (0, 41.4, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48883, -20914, 733), (0, 74.4, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48907, -20894, 733), (0, 25.799, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-48918, -20852, 733), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (-48874, -20866, 880), (316.026, 291.994, 53.6488));
  spawncollision("collision_clip_256x256x256", "collider", (-49635, -20069, 945), (0, 353.799, 0));
  spawncollision("collision_clip_512x512x512", "collider", (-49765, -20612, 1270), (0, 0, 0));
  spawncollision("collision_clip_ramp_64x24", "collider", (-49408, -21103, 771), (0, 129.996, 90));
  spawncollision("collision_clip_ramp_64x24", "collider", (-49405, -21101, 707), (82, 39.996, -180));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-48753, -21211, 711), (0, 270, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-48753, -21211, 839), (0, 270, 0));
  spawncollision("collision_clip_ramp_64x24", "collider", (-49486, -21009, 740), (0, 129.996, 90));
  spawncollision("collision_clip_ramp_64x24", "collider", (-49486, -21009, 676), (0, 309.996, -90));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-48884, -21280, 744), (306.4, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-48884, -21408, 744), (306.4, 0, 0));
  spawncollision("collision_slick_ramp_64x24", "collider", (1121, -15864.7, 7382.2), (0, 0, -144.4));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-48777.5, -21214.5, 839), (0, 180, 0));
  spawncollision("collision_clip_32x32x128", "collider", (-1314.96, -11389, 7491.49), (0, 0, 0));
  spawncollision("collision_clip_32x32x128", "collider", (-1314.96, -11395, 7491.49), (0, 0, 0));
  spawncollision("collision_slick_32x32x32", "collider", (-3588.5, -15397, 7351), (51.5842, 30.1996, -9.08977e-06));
  spawncollision("collision_slick_32x32x32", "collider", (-3593, -15389, 7351), (51.5842, 30.1996, -9.08977e-06));
  spawncollision("collision_slick_ramp_64x24", "collider", (-49356.7, -21134.4, 817.905), (359.582, 310.014, -3.97821));
  spawncollision("collision_slick_ramp_64x24", "collider", (-49362.7, -21126.4, 817.905), (359.582, 310.014, -3.97821));
  spawncollision("collision_slick_ramp_64x24", "collider", (-49429.7, -21048.4, 817.905), (359.582, 310.014, -3.97821));
  spawncollision("collision_slick_ramp_64x24", "collider", (-49435.7, -21040.4, 817.905), (359.582, 310.014, -3.97821));
  spawncollision("collision_clip_wall_256x256x10", "collider", (-50141.5, -20627.1, 877.464), (0, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (867, -15571.5, 7389.98), (0, 270, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (867, -15571.5, 7516.48), (0, 270, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (867, -15571.5, 7643.98), (0, 270, 0));
  spawncollision("collision_clip_32x32x128", "collider", (829.383, -15578.5, 7657.44), (0, 0, 0));
  spawncollision("collision_clip_32x32x128", "collider", (829.383, -15610.5, 7657.44), (0, 0, 0));
  spawncollision("collision_clip_32x32x128", "collider", (797.383, -15610.5, 7657.44), (0, 0, 0));
  spawncollision("collision_clip_32x32x128", "collider", (765.383, -15610.5, 7657.44), (0, 0, 0));
  spawncollision("collision_slick_cylinder_32x128", "collider", (1547.75, -16114.3, 7296), (0, 0, 0));
  spawncollision("collision_slick_128x128x128", "collider", (-48861, -20873, 968), (0, 0, 0));
  spawncollision("collision_clip_wall_512x512x10", "collider", (-48543, -20837, 1403), (0, 0, 0));
  spawncollision("collision_clip_wall_512x512x10", "collider", (-48543, -20728, 1403), (0, 0, 0));
  spawncollision("collision_clip_wall_512x512x10", "collider", (-48802, -20467, 1461), (0, 270, 0));
  spawncollision("collision_clip_256x256x256", "collider", (-49040, -20364, 1333), (0, 0, 0));
}