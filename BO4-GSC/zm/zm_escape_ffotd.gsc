/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_escape_ffotd;

autoexec __init__system__() {
  system::register(#"zm_escape_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  spawncollision("collision_clip_ramp_256x24", "collider", (758, 6590, 495), (270, 0.2, 18.8));
  spawncollision("collision_clip_wall_256x256x10", "collider", (-1382.5, 5724, 177.5), (0, 11.6, 0));
  spawncollision("collision_clip_ramp_256x24", "collider", (376, 10144, 1568), (270, 270, 0));
}