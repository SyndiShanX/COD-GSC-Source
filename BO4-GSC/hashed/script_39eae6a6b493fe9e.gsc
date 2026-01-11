/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_39eae6a6b493fe9e.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#namespace namespace_ade8e118;

autoexec __init__system__() {
  system::register(#"hash_3e28122e3a96907e", &__init__, &__main__, undefined);
}

private __init__() {
  if(!function_4922937f()) {
    return;
  }
  callback::on_spawned(&on_player_spawned);
}

private __main__() {
  if(!function_4922937f()) {
    return;
  }
  if(!isDefined(level.var_a73c4888)) {
    level.var_a73c4888 = -1;
  }
  if(!isDefined(level.var_baa8fd09)) {
    level.var_baa8fd09 = 3600;
  }
  if(!isDefined(level.var_342aa5b2)) {
    level.var_342aa5b2 = 0.33;
  }
  if(!isDefined(level.var_4d1d42c7)) {
    level.var_4d1d42c7 = 5;
  }
  if(!isDefined(level.var_5f0752c5)) {
    level.var_5f0752c5 = 1000;
  }
  if(!isDefined(level.var_af87760a)) {
    level.var_af87760a = 0.33;
  }
  if(!isDefined(level.var_bc978de9)) {
    level.var_bc978de9 = 8;
  }
  if(!isDefined(level.var_c50e9bdb)) {
    level.var_c50e9bdb = 9;
  }

  level thread setup_devgui();
}

private on_player_spawned() {
  if(!isDefined(self.BGB_TOKEN_LAST_GIVEN_TIME)) {
    self.BGB_TOKEN_LAST_GIVEN_TIME = self zm_stats::get_global_stat("BGB_TOKEN_LAST_GIVEN_TIME");
    self.var_f191a1fc = 0;
    self.var_bc978de9 = level.var_bc978de9 + level.round_number - 1;
  }
}

private function_4922937f() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use) || !level.onlinegame || !getdvarint(#"loot_enabled", 0)) {
    return false;
  }
  return true;
}

function_c2f81136(increment) {
  if(!function_4922937f()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player.var_bc978de9)) {
      player.var_bc978de9 += increment;
    }
  }
}

private setup_devgui() {
  waittillframeend();
  setdvar(#"hash_65992c655655f06b", "<dev string:x30>");
  bgb_devgui_base = "<dev string:x31>";
  adddebugcommand(bgb_devgui_base + "<dev string:x4a>" + "<dev string:x58>" + "<dev string:x6f>");
  level thread function_a29384f8();
}

private function_a29384f8() {
  for(;;) {
    var_2e29895e = getdvarstring(#"hash_65992c655655f06b");
    if(var_2e29895e != "<dev string:x30>") {
      level.players[0] function_32692a60();
    }
    setdvar(#"hash_65992c655655f06b", "<dev string:x30>");
    wait 0.5;
  }
}

function private function_32692a60() {
  var_90491adb = int(getdvarfloat(#"scr_vialsawardedscale", 1));
  for(count = 0; count < var_90491adb; count++) {
    self incrementbgbtokensgained();
  }
  self.var_f191a1fc += var_90491adb;
  self.var_bc978de9 += level.var_c50e9bdb;
  self.BGB_TOKEN_LAST_GIVEN_TIME = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
  self zm_stats::set_global_stat("BGB_TOKEN_LAST_GIVEN_TIME", self.BGB_TOKEN_LAST_GIVEN_TIME);
  uploadstats(self);
  self reportlootreward("3", var_90491adb);
}

private function_2d75b98d(var_ce9d31c4) {
  if(randomfloat(1) < var_ce9d31c4) {
    return true;
  }
  return false;
}

function_51cf4361(var_5561679e) {
  if(!function_4922937f()) {
    return;
  }
  if(0 <= level.var_a73c4888 && self.var_f191a1fc >= level.var_a73c4888) {
    return;
  }
  time_played_total = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
  if(time_played_total - level.var_baa8fd09 > self.BGB_TOKEN_LAST_GIVEN_TIME) {
    if(function_2d75b98d(level.var_342aa5b2)) {
      self function_32692a60();
    }
    return;
  }
  if(level.round_number < level.var_4d1d42c7) {
    return;
  }
  var_95d14cf5 = math::clamp(var_5561679e, 0, level.var_5f0752c5);
  var_741485e6 = float(var_95d14cf5) / level.var_5f0752c5;
  if(!function_2d75b98d(var_741485e6 * level.var_af87760a)) {
    return;
  }
  var_edfe0eb4 = self.var_bc978de9 - level.round_number;
  if(1 > var_edfe0eb4) {
    var_edfe0eb4 = 1;
  }
  var_b8a1486b = float(var_edfe0eb4 * var_edfe0eb4);
  if(!function_2d75b98d(1 / var_b8a1486b)) {
    return;
  }
  self function_32692a60();
}