/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_traps_firegates.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_mansion_triad;
#include scripts\zm\zm_mansion_util;
#include scripts\zm\zm_mansion_ww_lvl3_quest;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace namespace_a35b43eb;

autoexec __init__system__() {
  system::register(#"zm_trap_firegate", &__init__, &__main__, undefined);
}

__init__() {
  level thread function_85839afe();
  callback::on_finalize_initialization(&init);

  if(!isDefined(level.var_db63b33b)) {
    level.var_db63b33b = new throttle();
    [[level.var_db63b33b]] - > initialize(2, 0.1);
  }

  init_clientfields();
}

__main__() {}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"trap_light", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"hash_17df66ef5f71c0de", 8000, 2, "int");
}

init() {
  callback::on_connect(&function_96e29e5f);
}

function_96e29e5f() {}

function_85839afe() {
  a_zombie_traps = getEntArray("zombie_trap", "targetname");
  level.var_ba53c5c5 = array::filter(a_zombie_traps, 0, &function_960a9a04);

  if(zm_custom::function_901b751c(#"zmtrapsenabled")) {
    level.var_940ee624 = 0;
    level.var_adc872f3 = 0;
    level.var_bdcd506f = 0;
    level thread function_a8f79714();
  }

  foreach(zm_trap_firegate in level.var_ba53c5c5) {
    zm_trap_firegate function_bd8eddac();
  }

  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  zm_traps::register_trap_basic_info("firegate", &function_16746b30, &function_30db46c1);
  zm_traps::register_trap_damage("firegate", &function_26578bc6, &function_5ad19000);
}

function_960a9a04(e_ent) {
  return e_ent.script_noteworthy === "firegate";
}

function_bd8eddac() {
  self flag::init(#"enabled");
  self flag::init(#"activated");
  self flag::init(#"friendly");
  self.var_a768e132 = [];
  self.var_3a2026c0 = [];
  self.var_3d6b88c4 = [];
  self.var_872ce8b7 = [];
  a_e_elements = getEntArray(self.target, "targetname");

  foreach(e_element in a_e_elements) {
    if(e_element.script_noteworthy === "trap_console") {
      self.var_3d6b88c4[self.var_3d6b88c4.size] = e_element;
      continue;
    }

    if(e_element.script_noteworthy === "trap_lever") {
      self.var_872ce8b7[self.var_872ce8b7.size] = e_element;
      continue;
    }

    if(e_element.script_noteworthy === "bulletclip") {
      e_element notsolid();
      self.bulletclip = e_element;
    }
  }

  a_s_elements = struct::get_array(self.target, "targetname");

  foreach(s_element in a_s_elements) {
    if(s_element.script_noteworthy === "source_trig_pos") {
      self.var_3a2026c0[self.var_3a2026c0.size] = s_element;
      continue;
    }

    if(s_element.script_noteworthy === "energy_source") {
      self.var_a768e132[self.var_a768e132.size] = s_element;
    }
  }

  array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "off");
  self thread function_aa539d7b();
}

function_aa539d7b() {
  level flag::wait_till("all_players_spawned");
  self deactivate_trap();

  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  if(!zm_utility::is_standard()) {
    level flag::wait_till(self.var_78f643be);
  }

  self.var_23769a97 = [];

  foreach(s_src in self.var_3a2026c0) {
    str_prompt = zm_utility::function_d6046228(#"hash_888d5fd1e90d685", #"hash_f1db4a15f0e12bb");
    var_47323b73 = mansion_util::create_unitrigger(s_src, &function_5b8a557f, str_prompt, 0, 0, 0);
    var_47323b73.e_trap = self;
    var_47323b73.prompt_and_visibility_func = &function_9026cbcd;
    self.var_23769a97[self.var_23769a97.size] = var_47323b73;
  }

  if(zm_utility::is_standard()) {
    self flag::set(#"enabled");
    level flag::set(self.script_flag_wait);
    array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "green");

    foreach(mdl_console in self.var_3d6b88c4) {
      var_fe316a03 = util::spawn_model(#"p8_zm_man_fire_trap_power_core_on", mdl_console gettagorigin("energy_core_tag"), mdl_console gettagangles("energy_core_tag"));
      var_fe316a03 linkto(mdl_console, "energy_core_tag");
    }

    return;
  }

  self flag::wait_till(#"enabled");
  playsoundatposition(#"hash_277a6124c088ba6d", self.origin);
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playLoopSound(#"hash_39e79a32dcbea912");
  level flag::set(self.script_flag_wait);
  array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "green");

  foreach(mdl_console in self.var_3d6b88c4) {
    var_fe316a03 = util::spawn_model(#"p8_zm_man_fire_trap_power_core_on", mdl_console gettagorigin("energy_core_tag"), mdl_console gettagangles("energy_core_tag"));
    var_fe316a03 linkto(mdl_console, "energy_core_tag");
  }
}

function_5b8a557f() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;
    e_trap = self.stub.e_trap;

    if(isDefined(e_trap.var_23aecef0) && e_trap.var_23aecef0 || zm_utility::is_standard()) {
      if(!zm_utility::can_use(e_player)) {
        continue;
      }

      if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
        continue;
      }

      if(isDefined(e_trap.is_cooling) && e_trap.is_cooling || isDefined(e_trap._trap_in_use) && e_trap._trap_in_use) {
        continue;
      }

      if(zm_utility::is_player_valid(e_player) && !(isDefined(e_trap._trap_in_use) && e_trap._trap_in_use)) {
        b_purchased = self zm_traps::trap_purchase(e_player, e_trap.zombie_cost);

        if(!b_purchased) {
          continue;
        }

        if(isDefined(e_trap) && isalive(e_player)) {
          level thread zm_traps::trap_activate(e_trap, e_player);
        }
      }

      continue;
    }

    if(level.var_940ee624 > 0) {
      e_player thread function_1bcb6813();
      e_trap.var_23aecef0 = 1;
      mdl_trap = arraygetclosest(self.stub.origin, level.var_ba53c5c5);
      mdl_trap flag::set(#"enabled");
      level.var_940ee624--;
      level.var_bdcd506f++;
      level thread function_7b170638(level.var_bdcd506f, 0);
    }
  }
}

private function_1bcb6813() {
  if(!(isDefined(self.var_72a21e82) && self.var_72a21e82)) {
    self.var_72a21e82 = self zm_audio::create_and_play_dialog(#"fire_trap", #"set");
  }
}

function_9026cbcd(player) {
  self.hint_string = self.stub.hint_string;

  if(player zm_utility::is_drinking() || isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
    return false;
  }

  if(isDefined(self.stub.e_trap._trap_in_use) && self.stub.e_trap._trap_in_use) {
    return false;
  }

  if(isDefined(self.stub.e_trap.is_cooling) && self.stub.e_trap.is_cooling) {
    self sethintstring(#"zombie/trap_cooldown");
    return true;
  }

  if(isDefined(self.stub.e_trap.var_23aecef0) && self.stub.e_trap.var_23aecef0 && !zm_utility::is_standard()) {
    if(function_8b1a219a()) {
      self sethintstring(#"hash_6e8ef1b690e98e51", self.stub.e_trap.zombie_cost);
      return true;
    } else {
      self sethintstring(#"hash_23c1c09e94181fdb", self.stub.e_trap.zombie_cost);
      return true;
    }
  } else if(zm_utility::is_standard()) {
    if(function_8b1a219a()) {
      self sethintstring(#"hash_61d85c966dd9e83f");
      return true;
    } else {
      self sethintstring(#"hash_24a438482954901");
      return true;
    }
  } else if(level.var_940ee624 > 0) {
    str_prompt = zm_utility::function_d6046228(#"hash_888d5fd1e90d685", #"hash_f1db4a15f0e12bb");
    self sethintstring(str_prompt);
    return true;
  } else {
    self sethintstring(#"hash_5f05371ea87b812e");
    return true;
  }

  return true;
}

function_a8f79714() {
  if(zm_utility::is_standard()) {
    return;
  }

  level.var_4f17d729 = [];

  if(math::cointoss()) {
    array::add(level.var_4f17d729, function_2a5a929("mansion_downstairs"));
  } else {
    array::add(level.var_4f17d729, function_2a5a929("mansion_upstairs"));
  }

  if(math::cointoss()) {
    array::add(level.var_4f17d729, function_2a5a929("cemetery"));
  } else {
    array::add(level.var_4f17d729, function_2a5a929("mausoleum"));
  }

  if(math::cointoss()) {
    array::add(level.var_4f17d729, function_2a5a929("greenhouse"));
    return;
  }

  array::add(level.var_4f17d729, function_2a5a929("gardens"));
}

function_2a5a929(str_location, mdl_orb) {
  a_s_locs = struct::get_array("s_firegate_energy_src_" + str_location, "targetname");

  for(var_d0ed2a4c = 0; !var_d0ed2a4c; var_d0ed2a4c = 1) {
    s_loc = array::random(a_s_locs);

    if(!isDefined(s_loc.b_occupied)) {
      s_loc.b_occupied = 1;
    }
  }

  str_prompt = zm_utility::function_d6046228(#"hash_78bf6e69946b64ca", #"hash_7042b50d373a6fce");
  var_47323b73 = mansion_util::create_unitrigger(s_loc, &function_b1bd4115, str_prompt, 0, undefined, 0);
  var_47323b73.mdl = util::spawn_model(#"p8_zm_man_fire_trap_power_core_on", s_loc.origin, s_loc.angles);
  var_47323b73.mdl notsolid();
  var_47323b73.mdl thread pickup_spin();
  var_47323b73.str_location = str_location;
  return var_47323b73;
}

function_b1bd4115() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;

    if(zm_utility::is_player_valid(e_player)) {
      level.var_940ee624++;
      level.var_adc872f3++;
      level thread function_7b170638(level.var_adc872f3, 1);
      e_player thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
      arrayremovevalue(level.var_4f17d729, self, 0);
      playsoundatposition(#"hash_7512ff4121bb5604", e_player.origin);

      if(isDefined(self.stub.mdl)) {
        self.stub.mdl delete();
      }

      zm_unitrigger::unregister_unitrigger(self.stub);
    }
  }
}

function_7b170638(var_8163cc4, b_found) {
  switch (var_8163cc4) {
    case 1:
      var_7a0a29e3 = #"hash_379a0cb8e272c259";
      break;
    case 2:
      var_7a0a29e3 = #"hash_379a09b8e272bd40";
      break;
    case 3:
      var_7a0a29e3 = #"hash_379a0ab8e272bef3";
      break;
  }

  if(isDefined(var_7a0a29e3)) {
    if(b_found) {
      level zm_ui_inventory::function_7df6bb60(var_7a0a29e3, 1);
      return;
    }

    level zm_ui_inventory::function_7df6bb60(var_7a0a29e3, 2);
  }
}

pickup_spin() {
  self endon(#"death");
  self playLoopSound(#"hash_3b9597774dea00d6");

  while(true) {
    self rotateyaw(180, 1);
    wait 1;
  }
}

function_16746b30() {
  self._trap_duration = 30;
  self._trap_cooldown_time = 30;

  if(isDefined(level.sndtrapfunc)) {
    level thread[[level.sndtrapfunc]](self, 1);
  }

  self.activated_by_player thread function_45a2294f(self.script_string);

  foreach(e_trap in level.var_ba53c5c5) {
    if(e_trap.script_string === self.script_string) {
      e_trap thread zm_traps::trap_damage();
    }
  }

  self waittilltimeout(self._trap_duration, #"trap_deactivate");

  foreach(e_trap in level.var_ba53c5c5) {
    if(e_trap.script_string === self.script_string) {
      e_trap notify(#"trap_done");
    }
  }
}

function_30db46c1() {}

function_45a2294f(str_id) {
  foreach(e_trap in level.var_ba53c5c5) {
    if(e_trap.script_string === str_id) {
      e_trap thread activate_trap(self);
      array::thread_all(e_trap.var_3d6b88c4, &function_e714e3a8, "red");
      array::run_all(e_trap.var_872ce8b7, &rotatepitch, 90, 0.5);
    }
  }

  level notify(#"traps_activated", {
    #var_be3f58a: str_id
  });
  wait 30;
  level notify(#"traps_cooldown", {
    #var_be3f58a: str_id
  });
  n_cooldown = zm_traps::function_da13db45(30, self);

  foreach(e_trap in level.var_ba53c5c5) {
    if(e_trap.script_string === str_id) {
      e_trap.is_cooling = 1;
    }
  }

  wait n_cooldown;
  level notify(#"traps_available", {
    #var_be3f58a: str_id
  });

  foreach(e_trap in level.var_ba53c5c5) {
    if(e_trap.script_string === str_id) {
      e_trap.is_cooling = undefined;
      array::thread_all(e_trap.var_3d6b88c4, &function_e714e3a8, "green");
      array::run_all(e_trap.var_872ce8b7, &rotatepitch, -90, 0.5);
    }
  }
}

activate_trap(e_player) {
  if(!self flag::get(#"activated")) {
    self flag::set(#"activated");

    if(isDefined(e_player)) {
      self.activated_by_player = e_player;
    }

    self function_7d9e84f9();
    self thread function_21fd7c39();
    wait 30;
    self deactivate_trap();
  }
}

deactivate_trap() {
  self function_5627d722();
  self thread function_7947b7ee();
  self flag::clear(#"activated");
  self flag::clear(#"friendly");
  self notify(#"deactivate");
  self notify(#"trap_deactivate");
  self notify(#"trap_done");
}

function_7d9e84f9(str_color = "red") {
  if(isDefined(self.str_exploder)) {
    exploder::stop_exploder(self.str_exploder);
    self.str_exploder = undefined;
  }

  switch (self.script_string) {
    case #"firegate_entrance_hall":
      self.str_exploder = "fxexp_tf_" + str_color + "_mh";
      break;
    case #"firegate_cellar":
      self.str_exploder = "fxexp_tf_" + str_color + "_clr";
      break;
    case #"firegate_bedroom":
      self.str_exploder = "fxexp_tf_" + str_color + "_br";
      break;
    case #"firegate_library":
      self.str_exploder = "fxexp_tf_" + str_color + "_lb";
      break;
    case #"firegate_cemetery":
      self.str_exploder = "fxexp_tf_" + str_color + "_msm";
      break;
    case #"firegate_greenhouse":
      self.str_exploder = "fxexp_tf_" + str_color + "_gh";
      break;
  }

  exploder::exploder(self.str_exploder);
  self playSound(#"hash_370460eab1a33ee6");
}

function_5627d722() {
  if(isDefined(self.str_exploder)) {
    exploder::stop_exploder(self.str_exploder);
    self playSound(#"hash_5d8ec72f0838594e");
    self.str_exploder = undefined;
  }
}

function_5ad19000(e_trap) {
  self endon(#"death");

  if(self.zm_ai_category === #"popcorn") {
    return;
  }

  if(self.subarchetype === #"catalyst_plasma" && e_trap flag::get(#"friendly") == 0) {
    return;
  }

  if(self.team === #"allies") {
    return;
  }

  if(self.zm_ai_category === #"miniboss" || self.zm_ai_category === #"heavy" || self.zm_ai_category === #"boss") {
    if(self.archetype === #"blight_father") {
      e_trap deactivate_trap();
    }

    if(e_trap flag::get(#"friendly") === 0) {
      if(!(isDefined(self.is_on_fire) && self.is_on_fire)) {
        self thread zombie_death::flame_death_fx();
      }

      return;
    }

    self dodamage(self.health * 0.1, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
    return;
  }

  self thread zombie_death::flame_death_fx();

  if(isDefined(self.var_5475b4ad)) {
    self[[self.var_5475b4ad]](e_trap);
    return;
  }

  [[level.var_db63b33b]] - > waitinqueue(self);
  level notify(#"trap_kill", {
    #e_victim: self, 
    #e_trap: e_trap
  });

  if(isDefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
    e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    e_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }

  self dodamage(20000, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
}

function_26578bc6(t_damage) {
  if(!t_damage flag::get(#"friendly") && self getstance() === "stand" && !self issliding()) {
    self dodamage(50, t_damage.origin, undefined, t_damage, undefined, "MOD_BURNED", 0, undefined);
  }
}

function_21fd7c39() {
  self endon(#"trap_done");
  self.bulletclip solid();
  self.bulletclip.health = 100000;
  self.bulletclip setCanDamage(1);
  b_friendly = 0;

  while(!b_friendly) {
    s_notify = self.bulletclip waittill(#"damage");

    if(s_notify.weapon === level.var_74cf08b1 || s_notify.weapon === level.var_4b14202f) {
      b_friendly = 1;
      continue;
    }

    self.bulletclip.health = 100000;
  }

  self flag::set(#"friendly");

  if(s_notify.weapon === level.var_4b14202f) {
    self thread function_7d9e84f9("blue");
    self thread blue_fire();
    e_player = s_notify.attacker;

    if(isalive(e_player) && !(isDefined(e_player.var_a46d8eee) && e_player.var_a46d8eee)) {
      e_player thread function_1eeda1e5();
    }

    return;
  }

  if(s_notify.weapon === level.var_74cf08b1) {
    self thread function_7d9e84f9("green");
  }
}

private function_1eeda1e5() {
  self endon(#"disconnect");
  self.var_a46d8eee = 1;
  n_character_index = zm_characters::function_d35e4c92();
  str_vo = "vox_generic_responses_positive_plr_" + n_character_index + "_" + randomint(9);
  self thread zm_vo::vo_say(str_vo, 0, 1, 9999);
}

function_7947b7ee() {
  self.bulletclip setCanDamage(0);
  self.bulletclip notsolid();
}

blue_fire() {
  self thread mansion_triad::function_40e665ab();
  self flag::wait_till_clear(#"friendly");
  self notify(#"extinguish");
}

private function_e714e3a8(str_state = "off") {
  switch (str_state) {
    case #"off":
      self hidepart("light_green");
      self hidepart("light_red");
      self showpart("light_off");
      break;
    case #"green":
      self clientfield::set("" + #"trap_light", 1);
      self hidepart("light_off");
      self hidepart("light_red");
      self showpart("light_green");
      break;
    case #"red":
      self clientfield::set("" + #"trap_light", 2);
      self hidepart("light_green");
      self hidepart("light_off");
      self showpart("light_red");
      break;
  }
}