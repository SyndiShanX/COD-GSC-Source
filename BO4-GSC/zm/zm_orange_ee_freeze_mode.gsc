/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_freeze_mode.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_orange_water;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_utility;
#namespace zm_orange_ee_freeze_mode;

preload() {}

main() {
  level flag::init(#"freeze_mode");
  level flag::init(#"all_freeze");
  zm_audio::sndannouncervoxadd(#"freeze_mode", #"vox_freeze_mode");
  level.var_50c3a25b = getEntArray("freeze_mode_ice", "targetname");

  foreach(ice in level.var_50c3a25b) {
    ice hide();
    ice notsolid();
  }

  level.var_c422a9ae = getEntArray("freeze_mode_blockers", "targetname");

  foreach(barrier in level.var_c422a9ae) {
    barrier notsolid();
  }

  zm_sq::register(#"freeze_mode", #"step_1", #"freeze_quest", &freeze_quest, &freeze_quest_cleanup);
  zm_sq::start(#"freeze_mode", zm_utility::is_ee_enabled());
  callback::on_spawned(&function_1bb74851);
}

freeze_quest(var_a276c861) {
  level flag::wait_till_any(array(#"all_freeze", #"hell_on_earth", #"trials_hell_on_earth"));
}

freeze_quest_cleanup(var_a276c861, var_19e802fa) {
  if(var_a276c861) {
    level flag::set(#"all_freeze");
  }

  if(level flag::get(#"hell_on_earth") || level flag::get(#"trials_hell_on_earth")) {
    return;
  }

  var_e08890fb = getent("freeze_mode_button", "targetname");
  var_e08890fb movez(var_e08890fb.script_int, 2, 0.2, 0.2);
  wait 1.5;
  var_57e06cb = struct::get("freeze_mode_struct", "targetname");
  var_57e06cb zm_hms_util::function_6099877a(72, "end_game", #"hash_6001ebf204288bf8", #"hash_3fe9eae6f03accce");
  var_898a45da = level.var_45827161[level.round_number + 1];

  if(isDefined(var_898a45da)) {
    zm_round_spawning::function_43aed0ca(level.round_number + 1);
  }

  level flag::clear(#"zipline_handle_picked_up");
  level.func_get_delay_between_rounds = &function_f85d3d98;
  zm_hms_util::function_2ba419ee(1, int(max(199, level.round_number)));
  level flag::clear(#"break_freeze_faster");

  foreach(zone in level.zones) {
    if(zone.name != "docks_1" && zone.name != "docks_2") {
      zone.is_enabled = 0;
    }
  }

  foreach(ice in level.var_50c3a25b) {
    ice show();
    ice solid();
  }

  foreach(barrier in level.var_c422a9ae) {
    barrier solid();
    barrier disconnectpaths();
  }

  zm_audio::sndannouncerplayvox(#"freeze_mode");
  level zm_utility::function_e64ac3b6(18, #"hash_552f81c78340aeb3");

  foreach(player in getplayers()) {
    player thread function_1aab918f();
  }

  callback::on_spawned(&function_1aab918f);
  level waittill(#"start_of_round");
  level flag::set(#"infinite_round_spawning");
}

function_1aab918f() {
  self thread function_e42e358e();
}

function_1bb74851() {
  self.var_e1257157 = 0;
  self.var_adf5d9b4 = [];
  self.var_adf5d9b4[#"hash_2fb0927a65d8a9e"] = 0;
  self.var_adf5d9b4[#"hash_75f05448c75c06f"] = 0;
  self.var_adf5d9b4[#"hash_335d7ee067ac0e68"] = 0;
  self.var_adf5d9b4[#"hash_63f7af429c316620"] = 0;
  self.var_adf5d9b4[#"hash_1e6b498a976cdcb5"] = 0;
  self.var_adf5d9b4[#"hash_3a98581b802c0296"] = 0;
  self.var_adf5d9b4[#"hash_3461ddd73c20a747"] = 0;
  self.var_adf5d9b4[#"hash_99011c41f3d5380"] = 0;
  self.var_adf5d9b4[#"hash_381e2912fb0376dc"] = 0;
  self.var_adf5d9b4[#"hash_18aaabdeba54214a"] = 0;
}

function_3931c78() {
  if(isDefined(self.var_adf5d9b4[self.var_5417136]) && !self.var_adf5d9b4[self.var_5417136]) {
    self.var_adf5d9b4[self.var_5417136] = 1;
    self.var_e1257157++;

    if(self.var_e1257157 >= self.var_adf5d9b4.size) {
      level flag::set(#"all_freeze");
    }
  }
}

function_f85d3d98() {
  return false;
}

function_e42e358e() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");

  while(true) {
    wait 0.1;

    if(!self issprinting() && !self laststand::player_is_in_laststand()) {
      self function_f0bdc5df();
      return;
    }
  }
}

function_f0bdc5df() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");
  self thread function_6577cacc();
  self notify(#"player_entered_water");
  self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
  self allowslide(0);
  self thread function_1b305413();
}

function_1b305413() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");

  while(true) {
    wait 0.1;

    if(self issprinting() || self laststand::player_is_in_laststand()) {
      self player_sprinting();
      return;
    }
  }
}

player_sprinting() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");
  self notify(#"player_exited_water");
  self allowslide(1);
  self thread zm_orange_water::function_d2dd1f2b();
  self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
  self thread function_e42e358e();
}

function_6577cacc() {
  level endon(#"end_game");
  self endon(#"death", #"player_exited_water");

  if(!isDefined(self.var_36a93d1)) {
    self.var_36a93d1 = 0;
  }

  while(true) {
    wait 1;
    self.var_36a93d1++;
    var_24e0e73d = 15;

    if(self.var_36a93d1 >= var_24e0e73d) {
      waitframe(1);
      self thread function_9364acc1();
      self.var_36a93d1 = 0;
      return;
    }
  }
}

function_9364acc1() {
  self endoncallback(&zm_orange_water::function_c64292f, #"death");
  self.var_7dc2d507 = 1;
  self notify(#"player_frozen");
  self zm_orange_water::function_bad6907c();
  self clientfield::set("" + #"water_player_freeze_fx", 1);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 1);
  t_ice = spawn("trigger_damage", self.origin, 0, 15, 72);
  t_ice enablelinkto();
  t_ice linkto(self);
  self.t_ice = t_ice;
  self thread zm_orange_water::function_872ec0b2(t_ice);
  self thread zm_orange_water::function_6cadbaff();

  if(self.var_d844486 !== 1) {
    self thread zm_equipment::show_hint_text(#"hash_4b6950ec49c7e04c", 3);
    self.var_d844486 = 1;
  }

  self waittill(#"water_player_freeze_broken");
  self playSound(#"hash_2f8c9575cb36a298");
  self.var_7dc2d507 = 0;
  self zm_orange_water::function_46c3bbf7();
  self clientfield::set("" + #"water_player_freeze_fx", 0);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 0);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
  waitframe(2);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);

  if(isDefined(t_ice)) {
    t_ice delete();
    self.t_ice = undefined;
  }

  self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
  waitframe(2);
  self thread function_e42e358e();
}