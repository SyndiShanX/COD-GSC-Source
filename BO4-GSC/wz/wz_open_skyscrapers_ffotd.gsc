/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz\wz_open_skyscrapers_ffotd.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace wz_open_skyscrapers_ffotd;

autoexec __init__system__() {
  system::register(#"wz_open_skyscrapers_ffotd", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  rock = spawn("script_model", (-25996.2, -47315.5, 2366.06));

  if(isDefined(rock)) {
    rock setModel(#"hash_283f153de0d2b7ac");
    rock.angles = (0, 240, 27);
    rock setscale(2);
  }

  spawncollision("collision_clip_256x256x256", "collider", (-9496.5, 39312.5, 2256), (0, 338, 0));
  rock = spawn("script_model", (14653.5, -18402.3, 1475.66));

  if(isDefined(rock)) {
    rock setModel(#"hash_5d5c82725edc89c8");
    rock.angles = (357, 353, -4);
  }

  rock = spawn("script_model", (-6948.21, -24164.6, 1068.76));

  if(isDefined(rock)) {
    rock setModel(#"hash_5d5c82725edc89c8");
    rock.angles = (348, 343, -7);
  }

  rock = spawn("script_model", (-10016.2, -25676.7, 1039.73));

  if(isDefined(rock)) {
    rock setModel(#"hash_5d5c82725edc89c8");
    rock.angles = (1, 328, -17);
  }
}