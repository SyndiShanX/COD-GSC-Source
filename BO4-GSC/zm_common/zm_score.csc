/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_score.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_score;

autoexec __init__system__() {
  system::register(#"zm_score", &__init__, undefined, undefined);
}

__init__() {
  level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);

  foreach(subdivision in level.var_697c8943) {
    score_cf_register_info("damage" + subdivision, 1, 7);
  }

  score_cf_register_info("death_head", 1, 3, undefined);
  score_cf_register_info("death_melee", 1, 3, undefined);
  score_cf_register_info("transform_kill", 1, 3, undefined);
  clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int", undefined, 0, 0);
}

score_cf_register_info(name, version, max_count, func_callback) {
  for(i = 0; i < 4; i++) {
    clientfield::register("worlduimodel", "PlayerList.client" + i + ".score_cf_" + name, version, getminbitcountfornum(max_count), "counter", func_callback, 0, 0);
  }
}