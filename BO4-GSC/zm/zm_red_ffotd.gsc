/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace zm_red_ffotd;

autoexec __init__system__() {
  system::register(#"zm_red_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  spawncollision("collision_clip_128x128x128", "cliff_ruins_spawn_closet", (-3199, 7000, 508), (0, 245, 0));
  spawncollision("collision_clip_ramp_128x24", "collider", (21527.5, 21421, 900), (0, 126.3, 0));
  spawncollision("collision_clip_64x64x256", "amphitheater_statue_top_1", (-2080, 1553, 512), (0, 0, 0));
  spawncollision("collision_clip_64x64x256", "amphitheater_statue_top_2", (-1944.54, 1468.39, 512), (0, 347.199, 0));
  spawncollision("collision_clip_wall_512x512x10", "temple_terrace_column", (-328, -533, 291), (0, 280.2, 0));
  spawncollision("collision_clip_256x256x256", "apollo_temple_stairs", (-1228, -801, -64), (0, 10, 0));
  spawncollision("collision_clip_wall_128x128x10", "river_of_sorrows_murder_door", (-689, 5442, 1376), (0, 315, 0));
}