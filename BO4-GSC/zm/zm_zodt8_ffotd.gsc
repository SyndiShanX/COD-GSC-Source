/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace zm_zodt8_ffotd;

autoexec __init__system__() {
  system::register(#"zm_zodt8_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  spawncollision("collision_clip_wall_128x128x10", "collider", (190, -3839, 1149), (0, 270, 0));
}