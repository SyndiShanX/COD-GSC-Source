/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz\wz_escape_alt_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace wz_escape_ffotd_alt;

autoexec __init__system__() {
  system::register(#"wz_escape_ffotd_alt", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  col_origin = (6512, 5109, 874);
  var_a9430bbc = (0, 324, 0);
  hack_col = spawncollision("collision_clip_wall_256x256x10", "hack_collider", col_origin, var_a9430bbc);
  hack_col disconnectpaths(0, 0);
  hack_col notsolid();
  spawncollision("p8_col_rock_large_04", "collider", (-7044.5, -5855.5, 63.2374), (359.701, 349.702, 0.437607));
}