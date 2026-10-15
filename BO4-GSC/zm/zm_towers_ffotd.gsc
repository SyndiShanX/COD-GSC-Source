/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_towers_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace zm_towers_ffotd;

autoexec __init__system__() {
  system::register(#"zm_towers_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  var_bb230d1 = spawncollision("collision_bullet_wall_128x128x10", "collider", (940, 948, -216), (0, 45, 0));
}