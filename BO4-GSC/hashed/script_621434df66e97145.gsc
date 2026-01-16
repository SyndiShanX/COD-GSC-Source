/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_621434df66e97145.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace namespace_87b5173f;

preload() {
  clientfield::register("actor", "shower_trap_death_fx", 1, 1, "int");
  clientfield::register("scriptmover", "shower_trap_fx", 1, 1, "int");
  clientfield::register("toplayer", "player_shower_trap_post_fx", 18000, 1, "int");
  clientfield::register("toplayer", "player_fire_trap_post_fx", 18000, 1, "int");
  clientfield::register("scriptmover", "fire_trap_fx", 1, 1, "int");
  clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int");
  clientfield::register("actor", "spinning_trap_eye_fx", 1, 1, "int");
  clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int");
}

init() {
  level thread init_weapons_locker();
  level thread function_33e9442f();
  level thread function_31c7123b();
  level thread function_d8a7606();
  level thread function_982029e3();
}

init_weapons_locker() {
  level.s_weapons_locker = struct::get("s_weapons_locker", "targetname");
  level.s_weapons_locker.a_weapons = getEntArray(level.s_weapons_locker.target, "targetname");

  foreach(weapon in level.s_weapons_locker.a_weapons) {
    weapon setinvisibletoall();
  }

  if(zm_utility::is_ee_enabled() || zm_utility::is_trials()) {
    foreach(e_player in getplayers()) {
      if(isDefined(e_player)) {
        e_player function_af613bbf(level.s_weapons_locker.a_weapons);
        e_player.var_5a5bf8e7 = 0;
      }
    }
  }

  callback::on_connect(&on_player_connect);
  level flag::wait_till(#"hash_25d9ccebd2bdecd9");
  e_door_l = getent("e_sarge_l", "targetname");
  e_door_r = getent("e_sarge_r", "targetname");
  e_door_l playSound(#"hash_75410a9cb6086f34");
  e_door_l rotateyaw(185, 0.85, 0.1, 0.1);
  e_door_r rotateyaw(-220, 1, 0.05, 0.05);
  level.s_weapons_locker zm_unitrigger::create(&function_9d485d13, 64);
  level.s_weapons_locker thread function_4ef09c7a();
}

function_33e9442f() {
  level.s_ray_gun_case = struct::get("s_ray_gun_case", "targetname");
  level.s_ray_gun_case.s_case = struct::get("rg_case", "targetname");
  level.s_ray_gun_case.s_case scene::play("idle");
  level.s_ray_gun_case.e_ray_gun = getent(level.s_ray_gun_case.target, "targetname");
  level.s_ray_gun_case.e_ray_gun.w_pickup = level.a_w_ray_guns[3];

  if(zm_utility::is_ee_enabled()) {
    s_unitrigger = level.s_ray_gun_case.e_ray_gun zm_unitrigger::create(&zm_white_util::function_358da2a7);
    level.s_ray_gun_case.e_ray_gun.var_4f84520b = 0;
    level flag::wait_till(#"enable_countermeasure_5");
    level.s_ray_gun_case.s_case scene::play("open");
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
    level.s_ray_gun_case.e_ray_gun thread zm_white_util::function_d1ca61a7();
    return;
  }

  level.s_ray_gun_case.e_ray_gun hide();
}

function_31c7123b() {
  level.s_shower_trap = struct::get("s_shower_trap", "targetname");
  s_trap = level.s_shower_trap;
  s_trap._trap_type = "acid";
  s_trap.e_volume = getent(s_trap.target, "targetname");
  s_trap.e_volume._trap_type = "acid";
  s_trap.var_28ea1870 = struct::get_array(s_trap.target3, "targetname");
  s_trap.a_s_buttons = struct::get_array(s_trap.target2, "targetname");
  s_trap.a_e_lights = getEntArray(s_trap.target4, "targetname");
  s_trap.a_s_panels = struct::get_array(s_trap.target5, "targetname");
  s_trap.var_6b64b967 = 0;
  s_trap.var_41ee2ddc = 1;
  level flag::wait_till("all_players_spawned");
  level flag::wait_till(#"hash_25d9cdebd2bdee8c");

  foreach(s_button in s_trap.a_s_buttons) {
    s_button.s_trap = s_trap;
    s_button zm_unitrigger::create(&function_67b12ae8, 64);
    s_button thread function_6c029b7();
    s_button thread function_79eec899();
  }
}

function_6c029b7() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
      continue;
    }

    if(isDefined(self.power_flag) && !level flag::get(self.power_flag)) {
      continue;
    }

    if(level.s_shower_trap.var_6b64b967 === 1) {
      continue;
    }

    if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
      continue;
    }

    if(zm_utility::is_player_valid(e_who) && level.s_shower_trap.var_41ee2ddc === 1) {
      b_purchased = self.s_trap.a_e_lights[0] zm_traps::trap_purchase(e_who, 1000);

      if(!b_purchased) {
        continue;
      }

      self notify(#"hash_41d1d9f238b43a7");
      self.e_activator = e_who;
      level.s_shower_trap.activated_by_player = e_who;

      if(!(isDefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::can_speak()) {
        e_who thread zm_audio::create_and_play_dialog(#"trap_generic", #"activate");
      }
    }
  }
}

function_79eec899() {
  level endon(#"end_game");
  function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
  open_panels(level.s_shower_trap.a_s_panels);

  while(true) {
    self waittill(#"hash_41d1d9f238b43a7");
    function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
    level.s_shower_trap.var_6b64b967 = 1;
    e_who = self.e_activator;

    if(isDefined(e_who)) {
      zm_utility::play_sound_at_pos("purchase", e_who.origin);
      level notify(#"trap_activated", {
        #trap_activator: e_who, 
        #trap: self
      });
    }

    level.s_shower_trap function_17b07f6c(e_who);
    level.s_shower_trap.var_6b64b967 = 0;
    level.s_shower_trap.var_41ee2ddc = 0;
    n_cooldown = zm_traps::function_da13db45(60, e_who);
    wait n_cooldown;
    function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
    level.s_shower_trap.var_41ee2ddc = 1;
    playsoundatposition(#"zmb_trap_ready", self.origin);
  }
}

function_17b07f6c(e_player) {
  level endon(#"end_game");
  n_total_time = 0;
  self thread shower_trap_fx(1);

  while(n_total_time < 40) {
    self thread function_9c9d3bdc(e_player);
    self thread function_17f9c268();
    wait 0.1;
    n_total_time += 0.1;
  }

  self thread shower_trap_fx(0);
}

function_9c9d3bdc(e_activator) {
  foreach(ai in getaiteamarray(level.zombie_team)) {
    if(isalive(ai) && ai istouching(self.e_volume)) {
      ai thread function_a77f3804(e_activator, self.e_volume);
    }
  }
}

function_a77f3804(e_activator, e_volume) {
  self endon(#"death");
  self.marked_for_death = 1;

  if(isDefined(level.s_shower_trap.activated_by_player) && isplayer(level.s_shower_trap.activated_by_player)) {
    level.s_shower_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    level.s_shower_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }

  self clientfield::set("shower_trap_death_fx", 1);
  level notify(#"hash_336bf8053ce21208", {
    #e_player: e_activator
  });
  wait randomfloatrange(0.25, 0.5);

  if(isalive(self)) {
    self zombie_utility::gib_random_parts();
    self thread function_d55cc959();
    self.var_12745932 = 1;
    self dodamage(self.health + 1000, e_volume.origin, e_volume);
  }
}

shower_trap_fx(var_9d9f02b4) {
  if(var_9d9f02b4) {
    foreach(var_9e659454 in self.var_28ea1870) {
      var_9e659454.mdl_fx = util::spawn_model("tag_origin", var_9e659454.origin, var_9e659454.angles);
      var_9e659454.mdl_fx clientfield::set("shower_trap_fx", 1);
    }

    return;
  }

  foreach(var_9e659454 in self.var_28ea1870) {
    var_9e659454.mdl_fx clientfield::set("shower_trap_fx", 0);
    waitframe(1);
    var_9e659454.mdl_fx delete();
  }
}

function_d55cc959() {
  wait 2;

  if(isDefined(self)) {
    self clientfield::set("shower_trap_death_fx", 0);
  }
}

function_17f9c268() {
  foreach(e_player in getplayers()) {
    if(e_player istouching(self.e_volume)) {
      e_player thread function_b691c69(self);
    }
  }
}

function_b691c69(s_trap) {
  self endon(#"death", #"disconnect");

  if(!isDefined(self.var_e613b44) || !self.var_e613b44) {
    self.var_e613b44 = 1;
    e_volume = s_trap.e_volume;
    self thread function_24c4375b();

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

function_24c4375b() {
  self endon(#"bled_out", #"disconnect");

  if(self clientfield::get_to_player("player_shower_trap_post_fx") === 1) {
    return;
  }

  self clientfield::set_to_player("player_shower_trap_post_fx", 1);
  wait 1;
  self.var_e613b44 = 0;
  self clientfield::set_to_player("player_shower_trap_post_fx", 0);
}

function_13e49422(trap) {
  playsoundatposition(#"hash_4b93c2d674807e60", self.origin);
  self waittill(#"available");
  playsoundatposition(#"zmb_acid_trap_available", self.origin);
}

function_d8a7606() {
  level.s_fire_trap = struct::get("s_fire_trap", "targetname");
  s_trap = level.s_fire_trap;
  s_trap._trap_type = "fire";
  s_trap.e_volume = getent(s_trap.target, "targetname");
  s_trap.e_volume._trap_type = "fire";
  s_trap.var_28ea1870 = struct::get_array(s_trap.target3, "targetname");
  s_trap.a_s_buttons = struct::get_array(s_trap.target2, "targetname");
  s_trap.a_e_lights = getEntArray(s_trap.target4, "targetname");
  s_trap.a_s_panels = struct::get_array(s_trap.target5, "targetname");
  s_trap.var_6b64b967 = 0;
  s_trap.var_41ee2ddc = 1;
  level flag::wait_till("all_players_spawned");
  level flag::wait_till(#"hash_25d9caebd2bde973");

  foreach(s_button in s_trap.a_s_buttons) {
    s_button.s_trap = s_trap;
    s_button zm_unitrigger::create(&function_67b12ae8, 64);
    s_button thread function_f24b1ecb();
    s_button thread function_64fa1b6a();
    s_button thread function_cbeb9a33();
  }
}

function_f24b1ecb() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
      continue;
    }

    if(isDefined(self.power_flag) && !level flag::get(self.power_flag)) {
      continue;
    }

    if(level.s_fire_trap.var_6b64b967 === 1) {
      continue;
    }

    if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
      continue;
    }

    if(zm_utility::is_player_valid(e_who) && level.s_fire_trap.var_41ee2ddc === 1) {
      b_purchased = self.s_trap.a_e_lights[0] zm_traps::trap_purchase(e_who, 1000);

      if(!b_purchased) {
        continue;
      }

      self notify(#"fire_trap_activated");
      self.e_activator = e_who;
      level.s_fire_trap.activated_by_player = e_who;

      if(!(isDefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::can_speak()) {
        e_who thread zm_audio::create_and_play_dialog(#"trap_generic", #"activate");
      }
    }
  }
}

function_64fa1b6a() {
  level endon(#"end_game");
  function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
  open_panels(level.s_fire_trap.a_s_panels);

  while(true) {
    self waittill(#"fire_trap_activated");
    function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
    level.s_fire_trap.var_6b64b967 = 1;
    e_who = self.e_activator;

    if(isDefined(e_who)) {
      zm_utility::play_sound_at_pos("purchase", e_who.origin);
      level notify(#"trap_activated", {
        #trap_activator: e_who, 
        #trap: self
      });
    }

    level.s_fire_trap fire_trap_activate(e_who);
    level.s_fire_trap.var_6b64b967 = 0;
    level.s_fire_trap.var_41ee2ddc = 0;
    n_cooldown = zm_traps::function_da13db45(60, e_who);
    wait n_cooldown;
    function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
    level.s_fire_trap.var_41ee2ddc = 1;
    playsoundatposition(#"zmb_trap_ready", self.origin);
  }
}

fire_trap_activate(e_player) {
  level endon(#"end_game");
  n_total_time = 0;
  self thread fire_trap_fx(1);

  while(n_total_time < 40) {
    self thread function_bd117af1(e_player);
    self thread function_956ddb52();
    wait 0.1;
    n_total_time += 0.1;
  }

  self thread fire_trap_fx(0);
}

function_bd117af1(e_activator) {
  foreach(ai in getaiteamarray(level.zombie_team)) {
    if(isalive(ai) && ai istouching(self.e_volume)) {
      ai thread function_11e5b2ee(e_activator, self.e_volume);
    }
  }
}

function_11e5b2ee(e_activator, e_volume) {
  self endon(#"death");
  self.marked_for_death = 1;

  if(isDefined(level.s_fire_trap.activated_by_player) && isplayer(level.s_fire_trap.activated_by_player)) {
    level.s_fire_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    level.s_fire_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }

  level notify(#"fire_trap_kill", {
    #e_player: e_activator
  });

  if(isDefined(self.animname) && self.animname != "zombie_dog") {
    if(level.burning_zombies.size < 6) {
      level.burning_zombies[level.burning_zombies.size] = self;
      self thread zm_traps::zombie_flame_watch();
      self playSound(#"zmb_ignite");
      self thread zombie_death::flame_death_fx();
      playFXOnTag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
      wait randomfloat(1.25);
    } else {
      refs[0] = "guts";
      refs[1] = "right_arm";
      refs[2] = "left_arm";
      refs[3] = "right_leg";
      refs[4] = "left_leg";
      refs[5] = "no_legs";
      refs[6] = "head";
      self.a.gib_ref = refs[randomint(refs.size)];
      playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
      wait randomfloat(1.25);
      self playSound(#"wpn_zmb_electrap_zap");
    }
  }

  self.var_12745932 = 1;
  self dodamage(self.health + 666, self.origin, e_volume);
}

fire_trap_fx(var_9d9f02b4) {
  if(var_9d9f02b4) {
    foreach(var_9e659454 in self.var_28ea1870) {
      var_9e659454.mdl_fx = util::spawn_model("tag_origin", var_9e659454.origin, var_9e659454.angles);
      var_9e659454.mdl_fx clientfield::set("fire_trap_fx", 1);
    }

    return;
  }

  foreach(var_9e659454 in self.var_28ea1870) {
    var_9e659454.mdl_fx clientfield::set("fire_trap_fx", 0);
    waitframe(1);
    var_9e659454.mdl_fx delete();
  }
}

function_956ddb52() {
  foreach(e_player in getplayers()) {
    if(e_player istouching(self.e_volume)) {
      e_player thread function_5c6fd230(self);
    }
  }
}

function_5c6fd230(s_trap) {
  self endon(#"death", #"disconnect");

  if(self zm_traps::function_3f401e8d(self)) {
    return;
  }

  if(!(isDefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand()) {
    self.is_burning = 1;
    self thread function_867c70bf();

    if(isDefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered) {
      visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
    } else {
      self setburn(1.25);
    }

    self notify(#"burned");
    self dodamage(50, self.origin);
    wait 0.2;
    self.is_burning = undefined;
  }
}

function_867c70bf() {
  self endon(#"death");

  if(self clientfield::get_to_player("player_fire_trap_post_fx") === 1) {
    return;
  }

  self clientfield::set_to_player("player_fire_trap_post_fx", 1);
  wait 1.45;
  self.is_burning = undefined;
  self clientfield::set_to_player("player_fire_trap_post_fx", 0);
}

function_982029e3() {
  level.s_spinning_trap = struct::get("s_spinning_trap", "targetname");
  s_trap = level.s_spinning_trap;
  s_trap._trap_type = "rotating";
  s_trap.e_volume = getent(s_trap.target, "targetname");
  s_trap.e_volume._trap_type = "rotating";
  s_trap.a_s_buttons = struct::get_array(s_trap.target2, "targetname");
  s_trap.a_e_lights = getEntArray(s_trap.target4, "targetname");
  s_trap.a_s_panels = struct::get_array(s_trap.target5, "targetname");
  s_trap.e_trap = struct::get(s_trap.target3, "targetname");
  s_trap.e_trap thread scene::play("idle");
  s_trap.var_6b64b967 = 0;
  s_trap.var_41ee2ddc = 1;
  level flag::wait_till("all_players_spawned");
  level flag::wait_till(#"hash_25d9cbebd2bdeb26");

  foreach(s_button in s_trap.a_s_buttons) {
    s_button.s_trap = s_trap;
    s_button zm_unitrigger::create(&function_67b12ae8, 64);
    s_button thread function_6facfabc();
    s_button thread function_7fffc105();
    s_button thread function_cbeb9a33();
  }
}

function_6facfabc() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
      continue;
    }

    if(isDefined(self.power_flag) && !level flag::get(self.power_flag)) {
      continue;
    }

    if(level.s_spinning_trap.var_6b64b967 === 1) {
      continue;
    }

    if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
      continue;
    }

    if(zm_utility::is_player_valid(e_who) && level.s_spinning_trap.var_41ee2ddc === 1) {
      b_purchased = self.s_trap.a_e_lights[0] zm_traps::trap_purchase(e_who, 1000);

      if(!b_purchased) {
        continue;
      }

      self notify(#"hash_5a7f89c0b12d9f27");
      self.e_activator = e_who;
      level.s_spinning_trap.activated_by_player = e_who;

      if(!(isDefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::can_speak()) {
        e_who thread zm_audio::create_and_play_dialog(#"trap_generic", #"activate");
      }
    }
  }
}

function_7fffc105() {
  level endon(#"end_game");
  function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
  open_panels(level.s_spinning_trap.a_s_panels);

  while(true) {
    self waittill(#"hash_5a7f89c0b12d9f27");
    function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
    level.s_spinning_trap.var_6b64b967 = 1;
    e_who = self.e_activator;

    if(isDefined(e_who)) {
      zm_utility::play_sound_at_pos("purchase", e_who.origin);
      level notify(#"trap_activated", {
        #trap_activator: e_who, 
        #trap: self
      });
    }

    level.s_spinning_trap.e_volume playSound(#"hash_345bf7f9d6f848b9");
    level.s_spinning_trap spinning_trap_activate(e_who);
    level.s_spinning_trap.var_6b64b967 = 0;
    level.s_spinning_trap.var_41ee2ddc = 0;
    n_cooldown = zm_traps::function_da13db45(60, e_who);
    wait n_cooldown;
    function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
    level.s_spinning_trap.var_41ee2ddc = 1;
    playsoundatposition(#"zmb_trap_ready", self.origin);
  }
}

spinning_trap_activate(e_player) {
  level endon(#"end_game");
  n_total_time = 0;
  self.e_trap scene::play("intro");
  snd_ent = spawn("script_origin", level.s_spinning_trap.origin);
  snd_ent playLoopSound(#"hash_57820fd1863bbf19");

  while(n_total_time < 40) {
    self thread function_74a809fd();
    self thread function_b45556a4(e_player);
    self thread function_fcac4b4e();
    wait 0.1;
    n_total_time += 0.1;
  }

  self notify(#"spinning_trap_complete");
  level.s_spinning_trap.e_volume playSound(#"hash_632248542476cd73");
  snd_ent stoploopsound();
  self.e_trap scene::play("outro");
  snd_ent delete();
}

function_74a809fd() {
  self endon(#"spinning_trap_complete");

  while(true) {
    self.e_trap scene::play("loop");
  }
}

function_b45556a4(e_activator) {
  foreach(ai in getaiteamarray(level.zombie_team)) {
    if(isalive(ai) && ai istouching(self.e_volume)) {
      ai thread function_7bd8cfde(e_activator, self);
    }
  }
}

function_7bd8cfde(e_activator, s_trap) {
  self endon(#"death");

  if(isDefined(self.var_bd4627e1) && self.var_bd4627e1) {
    return;
  }

  if(isDefined(self.var_ad81ef15) && self.var_ad81ef15) {
    return;
  }

  self.var_ad81ef15 = 1;
  self.marked_for_death = 1;

  if(isDefined(s_trap.activated_by_player) && isplayer(s_trap.activated_by_player)) {
    s_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    s_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }

  level notify(#"hash_63be45d89436088", {
    #e_player: e_activator
  });

  if(isalive(self) && (!isDefined(self.var_bd4627e1) || !self.var_bd4627e1)) {
    self clientfield::set("spinning_trap_blood_fx", 1);
  }

  self playSound(#"hash_42c6cc2204b7fbbd");
  v_hook = s_trap.e_trap.scene_ents[#"prop 1"] gettagorigin("tag_fan_blade_A_2");
  n_dist = distance2d(self.origin, v_hook);

  if(!(isDefined(s_trap.var_705682df) && s_trap.var_705682df) && self.zm_ai_category === #"basic" && n_dist <= 128 && self.team != #"allies") {
    self thread function_bcfd9acb(s_trap);
    a_e_players = util::get_array_of_closest(self.origin, getplayers());
    return;
  }

  if(isai(self) && !isvehicle(self)) {
    self thread a_a_arms();
  }

  if(self.zm_ai_category === #"basic" && !isvehicle(self)) {
    if(randomint(100) < 20) {
      gibserverutils::annihilate(self);
    } else {
      self function_63e5e387(s_trap);
    }

    level notify(#"hash_148b3ce521088846", {
      #e_player: e_activator
    });
    self dodamage(self.health + 1000, self.origin, s_trap.e_volume);
    return;
  }

  level notify(#"hash_148b3ce521088846", {
    #e_player: e_activator
  });
  self dodamage(self.health + 1000, self.origin, s_trap.e_volume);
}

function_bcfd9acb(s_trap) {
  s_trap.var_705682df = 1;
  self.var_bd4627e1 = 1;
  self clientfield::set("spinning_trap_eye_fx", 1);
  var_e72c9959 = util::spawn_model("tag_origin", s_trap.e_trap.scene_ents[#"prop 1"] gettagorigin("tag_fan_blade_A_2"), s_trap.e_trap.scene_ents[#"prop 1"] gettagangles("tag_fan_blade_A_2"));
  var_e72c9959 linkto(s_trap.e_trap.scene_ents[#"prop 1"], "tag_fan_blade_A_2");
  self val::set("spinning_trap", "ignoreall", 1);
  self val::set("spinning_trap", "allowdeath", 0);
  self.b_ignore_cleanup = 1;
  self.health = 1;
  self notsolid();
  self setteam(util::get_enemy_team(self.team));
  self zombie_utility::makezombiecrawler(1);
  var_e72c9959 thread scene::init(#"aib_vign_zm_mob_hook_trap_zombie", self);
  playsoundatposition(#"hash_42c6cc2204b7fbbd", self.origin);
  s_trap waittill(#"spinning_trap_complete");
  var_44342e79 = var_e72c9959 scene::function_8582657c(#"p8_fxanim_zm_esc_trap_fan_play", "Shot 2");
  var_e72c9959 scene::play(#"aib_vign_zm_mob_hook_trap_zombie", self);

  if(isDefined(self)) {
    self val::reset("spinning_trap", "ignoreall");
    self val::reset("spinning_trap", "allowdeath");
    self.b_ignore_cleanup = 0;
    self solid();
    self setteam(level.zombie_team);
    self clientfield::set("spinning_trap_eye_fx", 0);
    self dodamage(self.health + 1000, self.origin);
  }

  var_e72c9959 unlink();
  var_e72c9959 delete();
  s_trap.var_705682df = undefined;
}

function_63e5e387(s_trap) {
  n_lift_height = randomintrange(8, 64);
  v_away_from_source = vectornormalize(self.origin - s_trap.e_volume.origin);
  v_away_from_source *= 128;
  v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
  a_trace = physicstraceex(self.origin + (0, 0, 32), self.origin + v_away_from_source, (-16, -16, -16), (16, 16, 16), self);
  self setplayercollision(0);
  self startragdoll();
  self launchragdoll(150 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
}

function_fcac4b4e() {
  foreach(e_player in getplayers()) {
    if(e_player istouching(self.e_volume)) {
      e_player thread function_1259cbbb(self);
    }
  }
}

function_1259cbbb(s_trap) {
  self endon(#"death", #"disconnect");

  if(!isDefined(self.var_c87b7253) || !self.var_c87b7253) {
    e_volume = s_trap.e_volume;

    if(e_volume zm_traps::function_3f401e8d(self)) {
      return;
    }

    if(!self laststand::player_is_in_laststand()) {
      if(zm_utility::is_standard()) {
        self dodamage(50, self.origin, undefined, e_volume);
        return;
      }

      self.var_c87b7253 = 1;

      if(self.health >= 200) {
        self dodamage(50, self.origin, undefined, e_volume);
        wait 0.75;
        self.var_c87b7253 = 0;
        return;
      }

      if(self.health >= 100) {
        self dodamage(35, self.origin, undefined, e_volume);
        wait 0.75;
        self.var_c87b7253 = 0;
        return;
      }

      self dodamage(15, self.origin, undefined, e_volume);
      wait 0.75;
      self.var_c87b7253 = 0;
    }
  }
}

a_a_arms() {
  wait 2;

  if(isDefined(self)) {
    self clientfield::set("spinning_trap_blood_fx", 0);
  }
}

function_af613bbf(a_weapons) {
  self endon(#"disconnect");
  self.var_45c57fa5 = array::random(a_weapons);

  switch (self.var_45c57fa5.script_string) {
    case #"tr":
      self.var_af561b1f = #"hash_4176883a68b00090";
      self.var_a794d091 = #"hash_2fa3f09f73bf523c";
      self.var_636a8bf7 = #"tr_longburst_t8_upgraded";
      self.var_45c57fa5 setinvisibletoplayer(self, 0);
      break;
    case #"lmg":
      self.var_af561b1f = #"hash_4e543dd90408cd76";
      self.var_a794d091 = #"hash_2e3938a646e43352";
      self.var_636a8bf7 = #"lmg_standard_t8_upgraded";
      self.var_45c57fa5 setinvisibletoplayer(self, 0);
      break;
    case #"ar":
      self.var_af561b1f = #"hash_6dd7b677c74ebba9";
      self.var_a794d091 = #"hash_24f2c78de733d877";
      self.var_636a8bf7 = #"ar_accurate_t8_upgraded";
      self.var_45c57fa5 setinvisibletoplayer(self, 0);
      break;
    case #"shotgun":
      self.var_af561b1f = #"hash_58eff35154ec1990";
      self.var_a794d091 = #"hash_670dd9efc63b2d3c";
      self.var_636a8bf7 = #"shotgun_pump_t8_upgraded";
      self.var_45c57fa5 setinvisibletoplayer(self, 0);
      break;
  }
}

function_9d485d13(e_player) {
  if(!e_player.var_5a5bf8e7) {
    str_hint = zm_utility::function_d6046228(e_player.var_af561b1f, e_player.var_a794d091);
    self sethintstring(str_hint);
    return true;
  } else {
    self sethintstring("");
  }

  return false;
}

function_4ef09c7a() {
  self endon(#"hash_5cc6008e5cdc03de");

  while(true) {
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(!isDefined(e_who.var_5a5bf8e7) || e_who.var_5a5bf8e7) {
      continue;
    }

    if(isDefined(e_who.var_636a8bf7)) {
      w_reward = getweapon(e_who.var_636a8bf7);
    }

    e_who thread swap_weapon(w_reward);
    e_who.var_45c57fa5 setinvisibletoplayer(e_who, 1);
    e_who.var_5a5bf8e7 = 1;
    e_who notify(#"hash_9e146af7233ec36");
  }
}

on_player_connect() {
  self function_af613bbf(level.s_weapons_locker.a_weapons);
  self.var_5a5bf8e7 = 0;
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

  if(isDefined(s_button.power_flag) && !level flag::get(s_button.power_flag)) {
    self sethintstring(#"zombie/need_power");
    return 1;
  }

  if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
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
    self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
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

swap_weapon(w_reward) {
  var_6822257f = self getweaponslist();

  foreach(w_gun in var_6822257f) {
    if(w_gun.rootweapon === w_reward) {
      self zm_weapons::function_7c5dd4bd(w_gun);
      return;
    }
  }

  if(!self hasweapon(w_reward, 1)) {
    self function_e2a25377(w_reward);
  }
}

function_e2a25377(w_reward) {
  if(self hasweapon(zm_weapons::get_base_weapon(w_reward), 1)) {
    self takeweapon(zm_weapons::get_base_weapon(w_reward), 1);
  }

  self zm_weapons::weapon_give(w_reward, 1);
}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}