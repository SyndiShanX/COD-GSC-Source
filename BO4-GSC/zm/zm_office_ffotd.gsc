/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace zm_office_ffotd;

autoexec __init__system__() {
  system::register(#"zm_office_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1683, 3653, -654), (0, 357.6, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1519, 3594, -654), (0, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-716, 4286, -654), (0, 2, 0));
}