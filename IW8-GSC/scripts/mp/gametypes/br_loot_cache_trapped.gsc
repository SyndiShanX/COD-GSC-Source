/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_loot_cache_trapped.gsc
**********************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("trappedchest", &ref_13d04);
}

function ref_136a2(var0, var1) {
  var2 = easepower("br_loot_cache_trapped", var0, var1);
  var2.ref_13a98 = spawn("trigger_radius", var0, 0, 90, 64);
  var2.ref_13a98.ref_121d6 = var2;
  scripts\mp\utility\trigger::makeenterexittrigger(var2.ref_13a98, &ref_13a97, undefined);
  return var2;
}

function ref_13a97(var0, var1) {
  wait 0.3;
  var2 = var1.ref_121d6 getscriptablepartstate("trappedchest");

  if(var2 != "closed") {
    var1 delete();
    return;
  }

  var3 = ["dx_brm_stc_trap_active_10", "dx_brm_stc_trap_active_30"];
  playsoundatpos(var1.origin + (0, 0, 50), scripts\engine\utility::random(var3));
  var1 delete();
}

function ref_13d04(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var0 endon("death");
  var5 = ["dx_brm_stc_timer_go_10", "dx_brm_stc_player_death_10", "dx_brm_stc_player_death_20", "dx_brm_stc_timer_go_20", "dx_brm_stc_trap_active_20"];
  playsoundatpos(var0.origin + (0, 0, 50), scripts\engine\utility::random(var5));
  var0 setscriptablepartstate(var1, "opening");
  var6 = level.hud_set_progress[var0.hud_racetrack_timer];
  var7 = "controlRoomExploder_" + var6.id;
  scripts\engine\utility::exploder(var7);
  var8 = gettime();
  var9 = getdvarfloat("scr_br_trappedChest_gasDamageTime", 30) * 1000;
  var10 = getdvarfloat("scr_br_trappedChest_gasDamageInterval", 1);

  while(gettime() - var8 < var9) {
    foreach(var3 in var6.ref_12699) {
      var0 scripts\mp\equipment\binoculars::lootleadermarkstrongsize(var3, var3, 9);
    }

    wait var10;
  }

  scripts\engine\utility::stop_exploder(var7);
  var6 notify("gas_end");
  var0 setscriptablepartstate(var1, "complete");
}