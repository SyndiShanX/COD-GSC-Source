/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3122530a9381e18b.gsc
***********************************************/

#include script_174ce72cc0f850;
#include script_724752ab26bff81b;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_main_quest;
#include scripts\zm\zm_white_special_rounds;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_item_pickup;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace namespace_ca03bbb4;

preload() {
  namespace_bd74bbd2::register(#"sc_mk2v", 20000, "sc_mk2v", &function_a66f0de2, &function_17f3e9e2);
  clientfield::register("scriptmover", "" + #"hash_7b37fadc13d402a3", 20000, 1, "int");
}

init() {
  level.var_9eccff99 = spawnStruct();
  level.var_9eccff99.var_10630268 = getweapon("ray_gun_mk2v");
  level.var_9eccff99.var_d58b0729 = getweapon("ray_gun_mk2v_upgraded");
  level.var_9eccff99.n_step = 0;
  callback::on_disconnect(&on_disconnect);
}

function_1c530e2d() {
  level endon(#"game_ended");
  level waittill(#"open_sesame");
  zm_white_special_rounds::function_6acd363d(1);
}

  function private function_18a1849f(e_player) {
    if(!isDefined(level.var_9eccff99.e_player)) {
      return false;
    }

    return e_player === level.var_9eccff99.e_player;
  }

private function_f6048ee(e_player) {
  if(isDefined(e_player)) {
    if(!isDefined(level.var_9eccff99.e_player)) {
      if(isDefined(e_player.var_9c20e2c9)) {
        self sethintstring(#"hash_744b68f010abb05");
      } else {
        self sethintstring(#"hash_12346bdab086516e");
      }
    } else if(level.var_9eccff99.e_player == e_player) {
      self sethintstring(#"hash_74fc96e8d58ff646");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_5b4f9f76(e_player) {
  var_2fff5cb5 = level.var_9eccff99.e_player === e_player;
  var_24441d81 = !isDefined(level.var_9eccff99.e_player) && !isDefined(e_player.var_9c20e2c9);
  return var_2fff5cb5 || var_24441d81;
}

private function_a8e75297(w_weapon) {
  return isDefined(w_weapon) && (w_weapon == level.var_9eccff99.var_10630268 || w_weapon == level.var_9eccff99.var_d58b0729);
}

start_quest() {
  start_step_1();
}

private start_step_1() {
  level thread function_cbeb9a33();

  if(!isDefined(level.var_9eccff99.s_start)) {
    level.var_9eccff99.s_start = zm_hms_util::function_4e7f5b2e("mk2v_start");
  }

  level.var_9eccff99.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_yellow_half", level.var_9eccff99.s_start.origin, level.var_9eccff99.s_start.angles);
  e_panel = getent(level.var_9eccff99.s_start.target, "targetname");

  if(isDefined(e_panel)) {
    e_panel setCanDamage(1);
    e_panel val::set("quest_mk2v", "allowDeath", 0);
    e_panel thread function_1129876d();
    exploder::exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);
  } else {
    s_unitrigger = level.var_9eccff99.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  }

  level.var_9eccff99.n_step = 1;
}

private function_1129876d() {
  self endon(#"death");
  pixbeginevent(#"hash_31bd17db0dd4297d");

  while(true) {
    s_notify = self waittill(#"damage");

    if(s_notify zm_hms_util::function_69320b44("zm_aat_kill_o_watt")) {
      self function_d41d20b1();
      break;
    }
  }

  pixendevent();
  self delete();
}

private function_d41d20b1() {
  v_force = anglesToForward(self.angles);
  v_force *= 0.2;
  createdynentandlaunch(self.dyn, self.origin, self.angles, self.origin, v_force);
  exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);
  s_unitrigger = level.var_9eccff99.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
}

private function_9d66ea6f(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x38>");
    println(e_player.name + "<dev string:x38>");
  }

    level.var_9eccff99.e_player = e_player;
  namespace_a01a2431::function_605e5c25(e_player);
  e_player.var_9c20e2c9 = 1;
  e_player playSound("evt_canister_pickup");
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mod_phase", 0, e_player);
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2v_ammo", 1, e_player);
  e_player thread function_130ea633();
  start_step_2();
}

function_130ea633() {
  if(zm_utility::is_classic()) {
    self zm_vo::vo_stop();
    self zm_hms_util::function_51b752a9("vox_ww_v_ammo_pickup");

    if(!zm_white_main_quest::function_6cebbce1()) {
      self zm_audio::do_player_or_npc_playvox("vox_ww_v_elec_hint_rush_0", 1);
    }
  }
}

private start_step_2() {
  if(zm_white_main_quest::function_6cebbce1()) {

    iprintlnbold("<dev string:x65>");

  }

  while(zm_white_main_quest::function_6cebbce1()) {
    wait 3;
  }

  var_685c8f1e = struct::get_array("mk2v_pole_target");
  level.var_9eccff99.var_685c8f1e = array::randomize(var_685c8f1e);
  level.var_9eccff99.var_f8f50111 = 0;
  level.var_9eccff99.var_685c8f1e[0] function_22b5323d();
  level.var_9eccff99.n_step = 2;
}

private function_22b5323d() {
  exploder::exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + self.exploder_id);
  t_damage = spawn("trigger_damage_new", self.origin - (0, 0, 12), 1048576 | 2097152 | 8388608, 24, 24);
  t_damage.var_504994c2 = 0;
  t_damage.s_target = self;
  t_damage thread function_27766b0b();
  self.t_damage = t_damage;
}

private function_27766b0b() {
  self endon(#"death");
  pixbeginevent(#"hash_1d99091c9b9308d1");

  while(true) {
    s_notify = self waittill(#"damage");
    self playSound("evt_insulator_hit");

    if(s_notify zm_hms_util::function_69320b44("zm_aat_kill_o_watt")) {
      self.var_504994c2++;

      if(self.var_504994c2 >= 3) {
        self.s_target function_6d765bb3();
        break;
      }
    }
  }

  pixendevent();
  self delete();
}

private function_6d765bb3() {
  exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + self.exploder_id);
  exploder::exploder("fxexp_quest_raygun_m2_v_stage_4_complete_" + self.exploder_id);
  level.var_9eccff99.var_f8f50111++;

  if(level.var_9eccff99.var_f8f50111 == level.var_9eccff99.var_685c8f1e.size) {

    if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
      iprintlnbold(level.var_9eccff99.e_player.name + "<dev string:xb9>");
      println(level.var_9eccff99.e_player.name + "<dev string:xb9>");
    }

      start_step_3();
    level notify(#"hash_141539da9edb11ab");
    return;
  }

  level.var_9eccff99.var_685c8f1e[level.var_9eccff99.var_f8f50111] function_22b5323d();
}

cleanup_step_2() {
  foreach(var_5c805707 in level.var_9eccff99.var_685c8f1e) {
    exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + var_5c805707.exploder_id);
    exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_4_complete_" + var_5c805707.exploder_id);

    if(isDefined(var_5c805707.t_damage)) {
      var_5c805707.t_damage delete();
    }
  }

  level notify(#"hash_141539da9edb11ab");
}

private start_step_3() {
  s_gen = struct::get("mk2v_gen");
  s_gen zm_unitrigger::create("", 96);
  s_gen thread function_195e54c();
  exploder::exploder("fxexp_quest_raygun_m2_v_stage_5_active");
  exploder::exploder("fxexp_quest_raygun_m2_v_stage_6_active");
  level.var_9eccff99.n_step = 3;
}

private function_195e54c() {
  self endon(#"death", #"stop_think");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    playsoundatposition("evt_rgun_frame_putback", (553, -134, 1));

    if(function_18a1849f(level.var_9eccff99.e_player)) {
      level.var_9eccff99.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_yellow_half", self.origin, self.angles);
      level.var_9eccff99.var_fead3ae9.in_zone = "zone_culdesac_yellow";
      namespace_bd74bbd2::start(#"sc_mk2v");
      level notify(#"hash_2df7109d3c756d8e");
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

private function_a66f0de2() {
  namespace_bd74bbd2::end(#"sc_mk2v");
  s_unitrigger = level.var_9eccff99.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_e90f6026, &function_f6048ee, &function_5b4f9f76);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_9eccff99.var_fead3ae9 setModel("p8_zm_whi_fuse_pickup_fluid_yellow");
  level.var_9eccff99.var_fead3ae9 clientfield::set("" + #"hash_7b37fadc13d402a3", 1);
  level notify(#"hash_b8dfde4a4e85cd2");
}

private function_e90f6026(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:xd6>");
    println(e_player.name + "<dev string:xd6>");
  }

    zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2v_ammo", 2, e_player);
  e_player.var_f7694097 = 0;
  e_player thread function_9d800221();
  e_player playSound("evt_rgun_frame_pickup");
  function_e09a7418();
  start_step_4();
}

function_9d800221() {
  if(zm_utility::is_classic()) {
    zm_hms_util::function_29fe9a5d();
    self zm_vo::vo_stop();
    self zm_hms_util::function_51b752a9("vox_ww_v_pickup");

    if(!zm_white_main_quest::function_6cebbce1()) {
      self zm_audio::do_player_or_npc_playvox("vox_ww_v_pickup_rush_1", 1);
    }
  }
}

function_e09a7418() {
  exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_5_active");
  exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_6_active");
  cleanup_step_2();
}

function_17f3e9e2() {
  s_unitrigger = level.var_9eccff99.var_fead3ae9 zm_unitrigger::create(&function_7015dc35);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_9eccff99.var_fead3ae9 thread function_2ac1278b();
}

private function_7015dc35(e_player) {
  if(isDefined(e_player)) {
    if(level.var_9eccff99.e_player === e_player) {
      self sethintstring(#"hash_14eae7c162ebb8d2");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_2ac1278b() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    e_player = s_notify.e_who;

    if(function_18a1849f(e_player)) {
      namespace_bd74bbd2::start(#"sc_mk2v");
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

cleanup_step_3() {
  function_e09a7418();

  if(isDefined(level.var_9eccff99.var_fead3ae9)) {
    namespace_bd74bbd2::end(#"sc_mk2v");
    level.var_9eccff99.var_fead3ae9 delete();
    return;
  }

  s_gen = struct::get("mk2v_gen");
  s_gen notify(#"stop_think");
  zm_unitrigger::unregister_unitrigger(s_gen.s_unitrigger);
}

private start_step_4() {
  level.var_9eccff99.e_player thread function_cba90c3c();
  level.var_9eccff99.n_step = 4;
}

private function_cba90c3c() {
  self endon(#"death");
  self waittill(#"hash_13f3f231b45420ef");
  self thread function_62ac32b9();
  complete_quest();
}

function_62ac32b9() {
  if(zm_utility::is_classic()) {
    zm_hms_util::function_29fe9a5d();
    self zm_vo::vo_stop();
    self zm_hms_util::function_51b752a9("vox_ww_v_craft");

    if(!zm_white_main_quest::function_6cebbce1()) {
      self zm_audio::do_player_or_npc_playvox("vox_ww_v_craft_rush_1", 1);
    }
  }
}

private complete_quest() {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(level.var_9eccff99.e_player.name + "<dev string:xf3>");
    println(level.var_9eccff99.e_player.name + "<dev string:xf3>");
  }

    level.var_9eccff99.e_player = undefined;
  level.var_9eccff99.n_step = 5;
}

private on_disconnect() {
  if(function_18a1849f(self)) {
    restart_quest();
  }
}

private restart_quest(var_e19b7aed = 1) {
  switch (level.var_9eccff99.n_step) {
    case 1:
      var_e19b7aed = 0;
      break;
    case 2:
      cleanup_step_2();
      break;
    case 3:
      cleanup_step_3();
      break;
  }

  level.var_9eccff99.e_player = undefined;

  if(var_e19b7aed) {
    start_step_1();
  }
}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");
  exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);

  if(isDefined(level.var_9eccff99.var_fead3ae9) && isDefined(level.var_9eccff99.var_fead3ae9.s_unitrigger)) {
    zm_unitrigger::unregister_unitrigger(level.var_9eccff99.var_fead3ae9.s_unitrigger);
    level.var_9eccff99.var_fead3ae9 delete();
  }

  restart_quest(0);
}