/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_loot_cache_trapped.gsc
**********************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("trappedchest", &ref_13d04);
}

function ref_136a2(var_0, var_1) {
  var_2 = easepower("br_loot_cache_trapped", var_0, var_1);
  var_2.ref_13a98 = spawn("trigger_radius", var_0, 0, 90, 64);
  var_2.ref_13a98.ref_121d6 = var_2;
  scripts\mp\utility\trigger::makeenterexittrigger(var_2.ref_13a98, &ref_13a97, undefined);
  return var_2;
}

function ref_13a97(var_0, var_1) {
  wait 0.3;
  var_2 = var_1.ref_121d6 getscriptablepartstate("trappedchest");

  if(var_2 != "closed") {
    var_1 delete();
    return;
  }

  var_3 = ["dx_brm_stc_trap_active_10", "dx_brm_stc_trap_active_30"];
  playsoundatpos(var_1.origin + (0, 0, 50), scripts\engine\utility::random(var_3));
  var_1 delete();
}

function ref_13d04(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_0 endon("death");
  var_5 = ["dx_brm_stc_timer_go_10", "dx_brm_stc_player_death_10", "dx_brm_stc_player_death_20", "dx_brm_stc_timer_go_20", "dx_brm_stc_trap_active_20"];
  playsoundatpos(var_0.origin + (0, 0, 50), scripts\engine\utility::random(var_5));
  var_0 setscriptablepartstate(var_1, "opening");
  var_6 = level.hud_set_progress[var_0.hud_racetrack_timer];
  var_7 = "controlRoomExploder_" + var_6.id;
  scripts\engine\utility::exploder(var_7);
  var_8 = gettime();
  var_9 = getdvarfloat("scr_br_trappedChest_gasDamageTime", 30) * 1000;
  var_10 = getdvarfloat("scr_br_trappedChest_gasDamageInterval", 1);

  while(gettime() - var_8 < var_9) {
    foreach(var_3 in var_6.ref_12699) {
      var_0 scripts\mp\equipment\binoculars::lootleadermarkstrongsize(var_3, var_3, 9);
    }

    wait var_10;
  }

  scripts\engine\utility::stop_exploder(var_7);
  var_6 notify("gas_end");
  var_0 setscriptablepartstate(var_1, "complete");
}