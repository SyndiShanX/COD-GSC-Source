/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_freeze_trap.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_orange_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_orange_freeze_trap;

init() {
  clientfield::register("actor", "freeze_trap_death_fx", 24000, 1, "int");
  clientfield::register("scriptmover", "freeze_trap_fx", 24000, 1, "int");
  clientfield::register("toplayer", "player_freeze_trap_post_fx", 24000, 1, "int");
}

main() {
  level thread function_e62e184a();
}

function_e62e184a() {
  level.s_freeze_trap = struct::get("s_freeze_trap", "targetname");
  s_trap = level.s_freeze_trap;
  s_trap._trap_type = "freeze";
  s_trap.e_volume = getent(s_trap.target, "targetname");
  s_trap.e_volume._trap_type = "freeze";
  s_trap.var_28ea1870 = struct::get_array(s_trap.target3, "targetname");
  s_trap.a_s_buttons = struct::get_array(s_trap.target2, "targetname");
  s_trap.a_e_lights = getEntArray(s_trap.target4, "targetname");
  s_trap.a_s_panels = struct::get_array(s_trap.target5, "targetname");
  s_trap.var_6b64b967 = 0;
  s_trap.var_41ee2ddc = 1;
  level flag::wait_till("all_players_spawned");

  foreach(s_button in s_trap.a_s_buttons) {
    s_button.s_trap = s_trap;
    s_button zm_unitrigger::create(&function_67b12ae8, 64);
    s_button thread function_c2e32275();
    s_button thread function_270aecf7();
  }
}

function_c2e32275() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
      continue;
    }

    if(isDefined(self.wait_flag) && !level flag::get(self.wait_flag)) {
      continue;
    }

    if(isDefined(self.power_flag) && !level flag::get(self.power_flag)) {
      continue;
    }

    if(level.s_freeze_trap.var_6b64b967 === 1) {
      continue;
    }

    if(zm_utility::is_player_valid(e_who) && level.s_freeze_trap.var_41ee2ddc === 1) {
      if(level flag::get(#"half_price_traps")) {
        b_purchased = self.s_trap.a_e_lights[0] zm_traps::trap_purchase(e_who, int(500));
      } else {
        b_purchased = self.s_trap.a_e_lights[0] zm_traps::trap_purchase(e_who, 1000);
      }

      if(!b_purchased) {
        continue;
      }

      self notify(#"hash_35807fa157a46934");
      self.e_activator = e_who;
      level.s_freeze_trap.activated_by_player = e_who;

      if(!(isDefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::can_speak()) {
        e_who thread zm_audio::create_and_play_dialog(#"trap_ice", #"activate");
      }
    }
  }
}

function_270aecf7() {
  level endon(#"end_game");
  function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light");

  if(isDefined(self.wait_flag)) {
    level flag::wait_till(self.wait_flag);
  }

  if(isDefined(self.power_flag)) {
    level flag::wait_till(self.power_flag);
  }

  function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
  open_panels(level.s_freeze_trap.a_s_panels);

  while(true) {
    self waittill(#"hash_35807fa157a46934");
    function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
    level.s_freeze_trap.var_6b64b967 = 1;
    e_who = self.e_activator;

    if(isDefined(e_who)) {
      zm_utility::play_sound_at_pos("purchase", e_who.origin);
      level notify(#"trap_activated", {
        #trap_activator: e_who, 
        #trap: self
      });
      level.s_freeze_trap.e_volume.activated_by_player = e_who;
    }

    level.s_freeze_trap function_4bbed101(e_who);
    level.s_freeze_trap.var_6b64b967 = 0;
    level.s_freeze_trap.var_41ee2ddc = 0;
    n_cooldown = zm_traps::function_da13db45(60, e_who);
    wait n_cooldown;
    function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
    level.s_freeze_trap.var_41ee2ddc = 1;
    playsoundatposition(#"zmb_trap_ready", self.origin);
  }
}

function_4bbed101(e_player) {
  level endon(#"end_game");
  n_total_time = 0;
  self thread freeze_trap_fx(1);
  sndent = spawn("script_origin", self.origin);
  sndent playLoopSound(#"hash_1df9464f442b0b6d", 1);

  if(isDefined(level.s_soapstone) && isDefined(level.s_soapstone.s_placement)) {
    level.s_soapstone.var_e15f0d15 = 1;

    if(!level.s_soapstone.is_charged || level.s_soapstone.is_hot) {
      level thread zm_orange_util::function_fd24e47f("vox_generic_responses_positive", -1, 1, 0);
    }
  }

  while(n_total_time < 40) {
    self thread function_3d9b6ed6(e_player);
    self thread function_c38e2c52();
    wait 0.1;
    n_total_time += 0.1;
  }

  if(isDefined(level.s_soapstone) && isDefined(level.s_soapstone.s_placement) && level.s_soapstone.var_e15f0d15 === 1) {
    if(!level.s_soapstone.is_charged || level.s_soapstone.is_hot) {
      level thread zm_orange_util::function_fd24e47f("vox_soap_stones_freeze", -1, 1, 0);
    }

    level.s_soapstone.is_charged = 1;
    level.s_soapstone.is_hot = 0;
    level.s_soapstone.s_placement.e_stone clientfield::set("soapstone_start_fx", 1);
    level.s_soapstone.s_placement.e_stone setModel("p8_zm_ora_soapstone_01_cold");

    if(level.s_soapstone.var_b6e5b65f == 2) {
      level.s_soapstone.s_placement.var_28f1732d clientfield::set("soapstone_start_fx", 1);
      level.s_soapstone.s_placement.var_28f1732d setModel("p8_zm_ora_soapstone_01_cold");
    }
  }

  sndent stoploopsound(1);
  sndent delete();
  self thread freeze_trap_fx(0);
}

function_3d9b6ed6(e_activator) {
  foreach(ai in getaiteamarray(level.zombie_team)) {
    if(isalive(ai) && ai istouching(self.e_volume) && (!isDefined(ai.marked_for_death) || !ai.marked_for_death)) {
      ai thread function_92f341d0(e_activator, self.e_volume);
    }
  }
}

function_92f341d0(e_activator, e_volume) {
  self endon(#"death");
  self.marked_for_death = 1;
  wait randomfloatrange(0.25, 0.5);

  if(isalive(self)) {
    self.water_damage = 1;

    if(isplayer(level.s_freeze_trap.activated_by_player)) {
      level.s_freeze_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
      level.s_freeze_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
    }

    level notify(#"trap_kill", {
      #victim: self, 
      #trap: e_volume
    });
    self dodamage(self.health + 1000, e_volume.origin, e_volume);
  }
}

freeze_trap_fx(var_9d9f02b4) {
  if(var_9d9f02b4) {
    exploder::exploder("fxexp_frost_trap");
    return;
  }

  exploder::stop_exploder("fxexp_frost_trap");
}

function_cedd130e() {
  wait 2;

  if(isDefined(self)) {
    self clientfield::set("freeze_trap_death_fx", 0);
  }
}

function_c38e2c52() {
  foreach(e_player in getplayers()) {
    if(e_player istouching(self.e_volume)) {
      e_player thread function_67a7a129(self);
    }
  }
}

function_67a7a129(s_trap) {
  self endon(#"death", #"disconnect");

  if(!isDefined(self.var_88eddb97) || !self.var_88eddb97) {
    self.var_88eddb97 = 1;
    e_volume = s_trap.e_volume;
    self thread function_be814134();

    if(e_volume zm_traps::function_3f401e8d(self)) {
      return;
    }

    if(!self laststand::player_is_in_laststand()) {
      if(zm_utility::is_standard()) {
        self dodamage(50, self.origin, undefined, e_volume);
      } else {
        self dodamage(150, self.origin, undefined, e_volume);
      }

      self zm_audio::playerexert("cough");
    }
  }
}

function_be814134() {
  self endon(#"bled_out", #"disconnect");

  if(self clientfield::get_to_player("player_freeze_trap_post_fx") === 1) {
    return;
  }

  self clientfield::set_to_player("player_freeze_trap_post_fx", 1);
  self playsoundtoplayer(#"hash_35baaf86bb47b64d", self);
  wait 0.25;
  self clientfield::set_to_player("player_freeze_trap_post_fx", 0);
  wait 1;
  self.var_88eddb97 = 0;
}

function_e32bd356(trap) {
  playsoundatposition(#"hash_4b93c2d674807e60", self.origin);
  self waittill(#"available");
  playsoundatposition(#"zmb_acid_trap_available", self.origin);
}

function_67b12ae8(e_player) {
  s_button = self.stub.related_parent;

  if(e_player zm_utility::is_drinking()) {
    self sethintstring("");
    return 0;
  }

  if(s_button.s_trap.var_6b64b967 === 1) {
    self sethintstring(#"zombie/trap_active");
    return 1;
  }

  if(isDefined(s_button.wait_flag) && !level flag::get(s_button.wait_flag)) {
    self sethintstring(#"zombie/trap_locked");
    return 1;
  }

  if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
    self sethintstring(#"zombie/trap_locked");
    return 1;
  }

  if(isDefined(s_button.power_flag) && !level flag::get(s_button.power_flag)) {
    self sethintstring(#"zombie/need_power");
    return 1;
  }

  if(s_button.s_trap.var_41ee2ddc === 0) {
    self sethintstring(#"zombie/trap_cooldown");
    return 1;
  }

  if(util::get_game_type() == "zstandard") {
    if(function_8b1a219a()) {
      self sethintstring(#"hash_61d85c966dd9e83f");
      return 1;
    } else {
      self sethintstring(#"hash_24a438482954901");
      return 1;
    }

    return;
  }

  if(function_8b1a219a()) {
    if(level flag::get(#"half_price_traps")) {
      self sethintstring(#"hash_6e8ef1b690e98e51", int(500));
      return 1;
    } else {
      self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
      return 1;
    }

    return;
  }

  if(level flag::get(#"half_price_traps")) {
    self sethintstring(#"hash_23c1c09e94181fdb", int(500));
    return 1;
  }

  self sethintstring(#"hash_23c1c09e94181fdb", 1000);
  return 1;
}

open_panels(a_s_panels) {
  foreach(panel in a_s_panels) {
    panel thread scene::play("open");
  }
}

function_91ecec97(a_e_lights, str_model) {
  foreach(light in a_e_lights) {
    light setModel(str_model);
  }
}