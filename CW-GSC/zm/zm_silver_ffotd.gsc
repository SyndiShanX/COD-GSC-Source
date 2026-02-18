/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver_ffotd.gsc
***********************************************/

#using script_58860a35d0555f74;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace zm_silver_ffotd;

function private autoexec __init__system__() {
  system::register(#"zm_silver_ffotd", &preinit, &postinit, undefined, undefined);
}

function private preinit() {}

function private postinit() {
  spawncollision("collision_clip_wall_64x64x10", "collider", (392.963, -57.25, -546.976), (0, 180, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (392.963, -75.75, -546.976), (0, 180, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (392.963, -57.25, -483.476), (0, 180, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (392.963, -75.75, -483.476), (0, 180, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (383.59, -958.093, -146.533), (0, 246.737, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1012.39, 2374.6, 116.898), (0, 289.716, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1119.89, 2336.6, 116.898), (0, 289.716, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-1527, 1505, 164.042), (0, 44.499, 0));
  spawncollision("collision_clip_128x128x128", "collider", (551.949, -94.5506, -379.603), (0, 315, 0));
  spawncollision("collision_clip_128x128x128", "collider", (543.449, -103.051, -379.603), (0, 315, 0));
  spawncollision("collision_clip_128x128x128", "collider", (539.449, -90.051, -379.603), (0, 315, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (239.812, 2123.97, 283.86), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (-200.8, 1669.01, -101.08), (0, 0, 0));
  spawncollision("collision_clip_64x64x256", "collider", (-958.033, 2.664, -311.792), (0, 315, 0));
  spawncollision("collision_clip_64x64x256", "collider", (854.728, -864.741, -173.75), (0, 45, 0));
  spawncollision("collision_clip_128x128x128", "collider", (-143.915, -87.5, 356.035), (0, 0, 0));
  spawncollision("collision_clip_128x128x128", "collider", (-34.917, -102.022, 356.035), (0, 345, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-192, -33, 208), (0, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (241.1, 2104.7, 203.1), (0, 45, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (267.3, 2074.9, 203.4), (0, 45, 0));
  spawncollision("collision_clip_wall_32x32x10", "collider", (732.3, 1850.1, 201.4), (0, 90, 0));
  namespace_1fd59e39::function_1376ec37((352, 733, 353), 100);
  namespace_1fd59e39::function_1376ec37((1403, 1282, 210), 200);
  level thread function_69e91dea();
}

function function_69e91dea() {
  var_79f2a81a = (536, 1192, -355);
  namespace_1fd59e39::function_1376ec37(var_79f2a81a, 200);
  index = level.var_ff7ae671.size - 1;
  level flag::wait_till("connect_trans_to_particle_accelerator");
  arrayremoveindex(level.var_ff7ae671, index);
}