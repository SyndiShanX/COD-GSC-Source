/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_score.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_score;

function private autoexec __init__system__() {
  system::register(#"zm_score", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);

  foreach(subdivision in level.var_697c8943) {
    score_cf_register_info("damage" + subdivision, 1, 7);
  }

  score_cf_register_info("death_head", 1, 3, undefined);
  score_cf_register_info("death_melee", 1, 3, undefined);
  score_cf_register_info("transform_kill", 1, 3, undefined);
  clientfield::register_clientuimodel("hudItems.doublePointsActive", #"hud_items", #"doublepointsactive", 1, 1, "int", undefined, 0, 0);
}

function score_cf_register_info(name, version, max_count, func_callback) {
  for(i = 0; i < 5; i++) {
    clientfield::function_5b7d846d("PlayerList.client" + i + ".score_cf_" + name, #"hash_97df1852304b867", [hash(isDefined(i) ? "" + i : ""), #"score_cf_" + name], version, getminbitcountfornum(max_count), "counter", func_callback, 0, 0);
  }
}