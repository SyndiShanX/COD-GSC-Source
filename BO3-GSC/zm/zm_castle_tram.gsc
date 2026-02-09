/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_tram.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_powerup_castle_tram_token;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_castle_vo;
#namespace zm_castle_tram;

function autoexec __init__sytem__() {
  system::register("zm_castle_tram", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "tram_fuse_destroy", 1, 1, "counter");
  clientfield::register("scriptmover", "tram_fuse_fx", 1, 1, "counter");
  clientfield::register("scriptmover", "cleanup_dynents", 1, 1, "counter");
  clientfield::register("world", "snd_tram", 5000, 2, "int");
}

function __main__() {
  level flag::init("tram_moving");
  level flag::init("tram_cooldown");
  level flag::init("tram_docked");
  level flag::init("player_tram_docked");
  level thread function_e16148c8();
  level thread function_3bda7a32();
  level thread function_57f998e3();
  level thread scene::play("p7_fxanim_zm_castle_tram_motor_small_gears_bundle");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_01_down_bundle", &function_310924ec, "init");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_01_start_bundle", &function_3584e778, "play");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_01_a_bundle", &function_3584e778, "play");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_01_b_bundle", &function_3584e778, "play");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_02_a_bundle", &function_3584e778, "play");
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_02_b_bundle", &function_3584e778, "play");
}

function function_e16148c8() {
  s_spawn_pos = struct::get("tram_object_spawn_pos", "targetname");
  level waittill("start_zombie_round_logic");
  exploder::exploder("lgt_tram_car_02_down");
  level._powerup_timeout_override = &function_ccc738b1;
  intro_powerup = zm_powerups::specific_powerup_drop("castle_tram_token", struct::get("tram_token_spawn_pos").origin);
  level._powerup_timeout_override = undefined;
  level thread function_7b56c646();
  level thread function_97f09efd();
  while(true) {
    level waittill("token_tram_moving", e_who);
    level flag::set("tram_moving");
    level thread function_4173be8d("tram_car_02", "tram_docked");
    level thread function_ccd0cc8e();
    level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_02_a_bundle");
    level scene::play("p7_fxanim_zm_castle_tram_car_02_a_bundle");
    level flag::set("tram_docked");
    level flag::clear("tram_moving");
    function_1d6e73d0(e_who, s_spawn_pos);
    while(isDefined(function_9d4a523c("docked_tram_car_interior")) && function_9d4a523c("docked_tram_car_interior")) {
      wait(0.1);
    }
    level flag::set("tram_moving");
    level flag::clear("tram_docked");
    playsoundatposition("vox_maxis_gondola_pa_departing_0", (400, 675, 40));
    level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_02_b_bundle");
    level scene::play("p7_fxanim_zm_castle_tram_car_02_b_bundle");
    level flag::set("tram_cooldown");
    level flag::clear("tram_moving");
    wait(8);
    level flag::clear("tram_cooldown");
  }
}

function function_9d4a523c(var_24ee4867) {
  var_9fa821d4 = getent(var_24ee4867, "targetname");
  foreach(player in level.activeplayers) {
    if(zm_utility::is_player_valid(player, undefined, 1) && player istouching(var_9fa821d4)) {
      return true;
    }
  }
  a_zombies = getaiteamarray(level.zombie_team);
  foreach(ai_zombie in a_zombies) {
    if(ai_zombie istouching(var_9fa821d4)) {
      return true;
    }
  }
  return false;
}

function function_4173be8d(var_d484b386, var_15872fa7) {
  exploder::stop_exploder(("lgt_" + var_d484b386) + "_down");
  while(level flag::get("tram_moving") || level flag::get(var_15872fa7)) {
    exploder::exploder(("lgt_" + var_d484b386) + "_up");
    wait(0.6);
    exploder::stop_exploder(("lgt_" + var_d484b386) + "_up");
    wait(0.6);
  }
  exploder::exploder(("lgt_" + var_d484b386) + "_down");
  if(var_d484b386 === "tram_car_02") {
    level flag::wait_till_clear("tram_cooldown");
    exploder::stop_exploder(("lgt_" + var_d484b386) + "_down");
    exploder::exploder(("lgt_" + var_d484b386) + "_up");
  }
}

function function_3bda7a32() {
  scene::add_scene_func("p7_fxanim_zm_castle_tram_car_01_start_bundle", &function_350d7037, "init");
  level.var_f31afb37 = 1;
  level waittill("start_zombie_round_logic");
  level thread function_3fb91800();
  level thread function_427ee40c();
}

function function_427ee40c() {
  s_spawn_pos = struct::get("player_tram_object_spawn_pos", "targetname");
  exploder::exploder("lgt_tram_car_01_up");
  level flag::set("player_tram_docked");
  level thread scene::init("p7_fxanim_zm_castle_tram_car_01_start_bundle");
  level thread scene::init("p7_fxanim_zm_castle_tram_car_01_down_bundle");
  wait(12);
  level flag::set("tram_moving");
  level flag::clear("player_tram_docked");
  level.var_f31afb37 = undefined;
  level thread function_4173be8d("tram_car_01", "player_tram_docked");
  level scene::play("p7_fxanim_zm_castle_tram_car_01_start_bundle");
  level flag::set("tram_cooldown");
  level flag::clear("tram_moving");
  wait(8);
  level flag::clear("tram_cooldown");
  exploder::stop_exploder("lgt_tram_car_02_down");
  exploder::exploder("lgt_tram_car_02_up");
  while(true) {
    level waittill("player_tram_moving", e_who);
    level flag::set("tram_moving");
    level thread function_4173be8d("tram_car_01", "player_tram_docked");
    level thread function_ccd0cc8e();
    level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_01_a_bundle");
    level scene::play("p7_fxanim_zm_castle_tram_car_01_a_bundle");
    level flag::set("player_tram_docked");
    level flag::clear("tram_moving");
    wait(0.5);
    var_f2c2f39 = 1;
    function_1d6e73d0(e_who, s_spawn_pos, var_f2c2f39);
    while(isDefined(function_9d4a523c("player_tram_car_interior")) && function_9d4a523c("player_tram_car_interior")) {
      wait(0.1);
    }
    level flag::set("tram_moving");
    level flag::clear("player_tram_docked");
    level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_01_b_bundle");
    level scene::play("p7_fxanim_zm_castle_tram_car_01_b_bundle");
    level flag::set("tram_cooldown");
    level flag::clear("tram_moving");
    wait(8);
    level flag::clear("tram_cooldown");
  }
}

function function_38a21d48() {
  level endon("tram_cooldown");
  self setCanDamage(1);
  self.health = 100000;
  while(true) {
    self waittill("damage", n_amount, e_attacker, v_direction, v_point, str_type);
    if(isPlayer(e_attacker) && (str_type == "MOD_GRENADE" || str_type == "MOD_GRENADE_SPLASH")) {
      e_attacker.var_a1ba5103 = 1;
      e_attacker.var_66e0478a = 0;
    }
  }
}

function function_350d7037(a_ents) {
  level.var_423f296e = getent("ee_gondola_clip", "targetname");
  a_ents["tram_car_01"] thread function_38a21d48();
  var_fd0bd09e = getent("castle_tram_2", "script_noteworthy");
  if(isDefined(var_fd0bd09e)) {
    var_fd0bd09e linkto(a_ents["tram_car_01"], "probe_jnt", (0, 0, 0));
  }
  var_abcc129 = getent("castle_tram", "script_noteworthy");
  if(isDefined(var_abcc129)) {
    var_abcc129 linkto(a_ents["tram_car_02"], "probe_jnt", (0, 0, 0));
  }
}

function function_1ff56fb0(str_scene) {
  s_scene = struct::get(str_scene, "scriptbundlename");
  if(isDefined(s_scene)) {
    s_scene.scene_played = 0;
  }
}

function function_3584e778(a_ents) {
  level clientfield::set("snd_tram", 1);
  a_ents["tram_car_01"] thread function_ce881a6();
  a_ents["tram_car_02"] thread function_ce881a6();
  a_ents["tram_car_01"] clientfield::increment("cleanup_dynents");
  a_ents["tram_car_02"] clientfield::increment("cleanup_dynents");
  level waittill(self.scriptbundlename + "_done");
  level notify("hash_a9fe9747");
  level clientfield::set("snd_tram", 2);
}

function function_7b56c646() {
  var_b86004b6 = getEntArray("tram_clip", "targetname");
  var_5cbc86c9 = getEntArray("tram_gates", "targetname");
  foreach(e_gate in var_5cbc86c9) {
    e_gate.start_pos = e_gate.origin;
    var_a6052bbf = struct::get(e_gate.target, "targetname");
    e_gate.open_pos = var_a6052bbf.origin;
  }
  while(true) {
    level flag::wait_till("tram_docked");
    foreach(e_clip in var_b86004b6) {
      e_clip notsolid();
      e_clip connectpaths();
    }
    foreach(e_gate in var_5cbc86c9) {
      e_gate moveto(e_gate.open_pos, 1.5);
      e_gate playSound("evt_tram_station_gate");
    }
    level flag::wait_till_clear("tram_docked");
    foreach(e_clip in var_b86004b6) {
      e_clip solid();
      e_clip disconnectpaths();
    }
    foreach(e_gate in var_5cbc86c9) {
      e_gate moveto(e_gate.start_pos, 0.5);
      e_gate playSound("evt_tram_station_gate");
    }
  }
}

function function_3fb91800() {
  var_b86004b6 = getEntArray("player_tram_clip", "targetname");
  var_5cbc86c9 = getEntArray("player_tram_gates", "targetname");
  foreach(e_gate in var_5cbc86c9) {
    e_gate.start_pos = e_gate.origin;
    var_a6052bbf = struct::get(e_gate.target, "targetname");
    e_gate.open_pos = var_a6052bbf.origin;
  }
  while(isDefined(level.var_f31afb37) && level.var_f31afb37) {
    util::wait_network_frame();
  }
  while(true) {
    level flag::wait_till("player_tram_docked");
    foreach(e_clip in var_b86004b6) {
      e_clip notsolid();
      e_clip connectpaths();
    }
    foreach(e_gate in var_5cbc86c9) {
      e_gate moveto(e_gate.open_pos, 1.5);
      e_gate playSound("evt_tram_station_gate");
    }
    level flag::wait_till_clear("player_tram_docked");
    foreach(e_clip in var_b86004b6) {
      e_clip solid();
      e_clip disconnectpaths();
    }
    foreach(e_gate in var_5cbc86c9) {
      e_gate moveto(e_gate.start_pos, 0.5);
      e_gate playSound("evt_tram_station_gate");
    }
  }
}

function function_1d6e73d0(e_player, s_spawn_pos, var_f2c2f39) {
  n_randy = randomint(100);
  a_bonus_types = [];
  if(getdvarint("") == 1) {
    n_randy = 20;
  } else if(getdvarint("") == 2) {
    n_randy = 5;
  }
  if(n_randy == 1 && level.round_number >= 5) {
    var_929a8e9b = 1;
  } else {
    if(n_randy <= 20 && level.round_number >= 5) {
      array::add(a_bonus_types, "bonus_points_team");
      array::add(a_bonus_types, "fire_sale");
    } else {
      array::add(a_bonus_types, "double_points");
      array::add(a_bonus_types, "insta_kill");
      array::add(a_bonus_types, "full_ammo");
      if(level.round_number >= 5) {
        array::add(a_bonus_types, "nuke");
      }
      if(isDefined(e_player.hasriotshield) && e_player.hasriotshield && e_player getammocount(e_player.weaponriotshield) !== e_player.weaponriotshield.maxammo) {
        array::add(a_bonus_types, "shield_charge");
      }
    }
  }
  var_a11baa62 = array("fire_sale", "double_points", "insta_kill", "full_ammo", "nuke");
  if(isDefined(var_f2c2f39) && var_f2c2f39) {
    var_8b961b44 = function_b29057c7(e_player);
    var_bd4efc7d = s_spawn_pos function_b21df67c(e_player, var_8b961b44);
  } else {
    if(isDefined(var_929a8e9b) && var_929a8e9b) {
      var_8b961b44 = getweapon("ray_gun");
      var_2fd9a02f = zm_pap_util::get_triggers();
      if(zm_magicbox::treasure_chest_canplayerreceiveweapon(e_player, var_8b961b44, var_2fd9a02f)) {
        var_bd4efc7d = s_spawn_pos function_b21df67c(e_player, var_8b961b44);
      } else {
        var_bd4efc7d = zm_powerups::specific_powerup_drop("full_ammo", s_spawn_pos.origin);
        var_bd4efc7d thread function_bb44b161("full_ammo", var_a11baa62);
      }
      var_929a8e9b = undefined;
    } else {
      str_type = array::random(a_bonus_types);
      var_bd4efc7d = zm_powerups::specific_powerup_drop(str_type, s_spawn_pos.origin);
      var_bd4efc7d thread function_bb44b161(str_type, var_a11baa62);
    }
  }
  if(n_randy >= 97) {
    var_f1c9d472 = struct::get("tram_enemy_spawn_pos", "targetname");
    var_88af999e = zombie_utility::spawn_zombie(level.zombie_spawners[0], "tram_car_zombie", var_f1c9d472);
    playFX(level._effect["lightning_dog_spawn"], var_88af999e.origin);
  }
  var_bd4efc7d util::waittill_either("powerup_grabbed", "powerup_timedout");
}

function function_bb44b161(str_powerup, var_a11baa62) {
  self endon("powerup_grabbed");
  var_ee91d5b = self.model;
  for(i = 0; i < 3; i++) {
    for(j = 0; j < var_a11baa62.size; j++) {
      s_powerup = level.zombie_powerups[var_a11baa62[j]];
      self setModel(s_powerup.model_name);
      wait(0.12);
    }
  }
  self setModel(var_ee91d5b);
}

function function_b29057c7(player) {
  var_fdd157a7 = [];
  array::add(var_fdd157a7, getweapon("cymbal_monkey"));
  array::add(var_fdd157a7, getweapon("shotgun_fullauto_upgraded"));
  array::add(var_fdd157a7, getweapon("ar_damage_upgraded"));
  var_fdd157a7 = array::randomize(var_fdd157a7);
  return var_fdd157a7[0];
}

function function_b21df67c(e_player, var_8b961b44) {
  v_spawnpt = self.origin + (0, 0, 40);
  v_spawnang = (0, 0, 0);
  v_angles = e_player getplayerangles();
  v_angles = (0, v_angles[1], 0) + vectorscale((0, 1, 0), 90) + v_spawnang;
  mdl_weapon = zm_utility::spawn_buildkit_weapon_model(e_player, var_8b961b44, undefined, v_spawnpt, v_angles);
  mdl_weapon.angles = v_angles;
  mdl_weapon thread timer_til_despawn(v_spawnpt);
  mdl_weapon endon("powerup_timedout");
  mdl_weapon.trigger = spawn_unitrigger(v_spawnpt, 100);
  mdl_weapon.trigger.wpn = var_8b961b44;
  mdl_weapon.trigger.prompt_and_visibility_func = &weapon_trigger_update_prompt;
  mdl_weapon thread function_cc0d2cc9(var_8b961b44);
  return mdl_weapon;
}

function function_cc0d2cc9(var_8b961b44) {
  self.trigger waittill("trigger", e_who);
  self notify("powerup_grabbed");
  e_who zm_weapons::weapon_give(var_8b961b44, 0, 0);
  if(isDefined(self.trigger)) {
    zm_unitrigger::unregister_unitrigger(self.trigger);
    self.trigger = undefined;
  }
  if(isDefined(self)) {
    playFX(level._effect["powerup_grabbed"], self.origin);
    self delete();
  }
}

function timer_til_despawn(v_float, n_dist) {
  self endon("powerup_grabbed");
  self endon("delete");
  n_start_time = gettime();
  n_total_time = 0;
  self clientfield::set("powerup_fx", 1);
  while(12 > n_total_time) {
    self rotateyaw(360, 1);
    wait(1);
    n_total_time = (gettime() - n_start_time) / 1000;
  }
  self notify("powerup_timedout");
  if(isDefined(self.trigger)) {
    zm_unitrigger::unregister_unitrigger(self.trigger);
    self.trigger = undefined;
  }
  if(isDefined(self)) {
    playFX(level._effect["powerup_grabbed"], self.origin);
    self delete();
  }
}

function weapon_trigger_update_prompt(player) {
  self setcursorhint("HINT_WEAPON", self.stub.wpn);
  self sethintstring(&"ZOMBIE_TRADE_WEAPON_FILL");
  return true;
}

function function_97f09efd() {
  e_lever = struct::get("tram_call_lever_2", "targetname");
  t_use = spawn_unitrigger(e_lever.origin, 60);
  t_use.hint_string = &"ZM_CASTLE_TRAM_REQUIRES_TOKEN";
  t_use.var_5be78056 = 0;
  level thread function_8f0015e0();
  while(true) {
    t_use waittill("trigger", e_who);
    if(zm_powerup_castle_tram_token::function_ed4d87a3(e_who)) {
      if(isDefined(e_who.var_a1ba5103) && e_who.var_a1ba5103) {
        e_who.var_66e0478a++;
      }
      level.var_f0adc88a showpart("j_fuse_main");
      e_who playrumbleonentity("zm_castle_interact_rumble");
      playsoundatposition("vox_maxis_gondola_pa_called_0", (400, 675, 40));
      n_randy = randomint(100);
      if(isDefined(e_who.var_a1ba5103) && e_who.var_a1ba5103 && e_who.var_66e0478a >= 5) {
        level notify("player_tram_moving", e_who);
        e_who.var_a1ba5103 = undefined;
        e_who.var_66e0478a = undefined;
      } else {
        level notify("token_tram_moving", e_who);
      }
      util::wait_network_frame();
      level.var_f0adc88a clientfield::increment("tram_fuse_fx");
      level flag::wait_till_any(array("tram_docked", "player_tram_docked"));
      level.var_f0adc88a clientfield::increment("tram_fuse_destroy");
      level.var_f0adc88a hidepart("j_fuse_main");
      level flag::wait_till("tram_cooldown");
      level flag::wait_till_clear("tram_cooldown");
    } else if(!isDefined(level.var_f6d3c9c0) || (gettime() - level.var_f6d3c9c0) > 12000) {
      level.var_f6d3c9c0 = gettime();
      e_who thread zm_castle_vo::function_b6633a79();
    }
  }
}

function function_8f0015e0() {
  level flag::wait_till("tram_moving");
  level.var_f0adc88a thread scene::play("p7_fxanim_zm_castle_tram_car_01_down_bundle", level.var_f0adc88a);
  level.var_f0adc88a playSound("evt_tram_lever");
  while(true) {
    str_result = level util::waittill_any_return("token_tram_moving", "player_tram_moving");
    if(str_result === "token_tram_moving") {
      level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_02_up_bundle");
      level.var_f0adc88a thread scene::play("p7_fxanim_zm_castle_tram_car_02_up_bundle", level.var_f0adc88a);
      level.var_f0adc88a playSound("evt_tram_lever");
      level flag::wait_till("tram_docked");
      level flag::wait_till("tram_moving");
      level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_02_down_bundle");
      level.var_f0adc88a thread scene::play("p7_fxanim_zm_castle_tram_car_02_down_bundle", level.var_f0adc88a);
      level.var_f0adc88a playSound("evt_tram_lever");
    } else if(str_result === "player_tram_moving") {
      level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_01_up_bundle");
      level.var_f0adc88a thread scene::play("p7_fxanim_zm_castle_tram_car_01_up_bundle", level.var_f0adc88a);
      level.var_f0adc88a playSound("evt_tram_lever");
      level flag::wait_till("player_tram_docked");
      level flag::wait_till("tram_moving");
      level function_1ff56fb0("p7_fxanim_zm_castle_tram_car_01_down_bundle");
      level.var_f0adc88a thread scene::play("p7_fxanim_zm_castle_tram_car_01_down_bundle", level.var_f0adc88a);
      level.var_f0adc88a playSound("evt_tram_lever");
    }
  }
}

function function_310924ec(a_ents) {
  level.var_f0adc88a = a_ents["gondola_console_controls"];
  level.var_f0adc88a hidepart("j_fuse_main");
}

function function_19b8e1e4(str_message, param1) {
  self.hint_string = str_message;
  zm_unitrigger::unregister_unitrigger(self);
  zm_unitrigger::register_static_unitrigger(self, &unitrigger_think);
}

function spawn_unitrigger(origin, radius) {
  trigger_stub = spawnStruct();
  trigger_stub.origin = origin;
  trigger_stub.radius = radius;
  trigger_stub.cursor_hint = "HINT_NOICON";
  trigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  trigger_stub.prompt_and_visibility_func = &function_5ea427bf;
  zm_unitrigger::register_static_unitrigger(trigger_stub, &unitrigger_think);
  return trigger_stub;
}

function function_5ea427bf(player) {
  str_msg = &"";
  if(isDefined(self.stub.var_5be78056) && self.stub.var_5be78056) {
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = self.stub.weapon_pickup;
    self setcursorhint(cursor_hint, cursor_hint_weapon);
  } else {
    if(level flag::get("tram_docked") || level flag::get("player_tram_docked")) {
      self.stub.hint_string = &"ZM_CASTLE_TRAM_DOCKED";
      self sethintstring(self.stub.hint_string);
      return false;
    }
    if(level flag::get("tram_moving")) {
      self.stub.hint_string = &"ZM_CASTLE_TRAM_MOVING";
      self sethintstring(self.stub.hint_string);
      return false;
    }
    if(level flag::get("tram_cooldown")) {
      self.stub.hint_string = &"ZM_CASTLE_TRAM_COOLDOWN";
      self sethintstring(self.stub.hint_string);
      return false;
    }
    if(zm_powerup_castle_tram_token::function_83ef471e(player)) {
      self.stub.hint_string = &"ZM_CASTLE_TRAM_CALL";
      self sethintstring(self.stub.hint_string);
      return true;
    }
    self.stub.hint_string = &"ZM_CASTLE_TRAM_REQUIRES_TOKEN";
    self sethintstring(self.stub.hint_string);
    return true;
  }
}

function unitrigger_think() {
  self endon("kill_trigger");
  self.stub thread unitrigger_refresh_message();
  while(true) {
    self waittill("trigger", var_4161ad80);
    self.stub notify("trigger", var_4161ad80);
  }
}

function unitrigger_refresh_message() {
  self zm_unitrigger::run_visibility_function_for_all_triggers();
}

function function_ccc738b1() {}

function function_ce881a6() {
  self.sndent = spawn("script_origin", self.origin);
  self.sndent linkto(self);
  self.sndent playLoopSound("evt_tram_track");
  level waittill("hash_a9fe9747");
  if(isDefined(self.sndent)) {
    self.sndent stoploopsound(2);
  }
  wait(1);
  if(isDefined(self.sndent)) {
    self.sndent delete();
  }
}

function function_ccd0cc8e() {
  wait(5.4);
  playsoundatposition("vox_maxis_gondola_pa_arriving_0", (400, 675, 40));
}

function function_57f998e3() {
  level waittill("start_zombie_round_logic");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_72d0fbe3);
}

function function_72d0fbe3(cmd) {
  switch (cmd) {
    case "": {
      foreach(e_player in level.activeplayers) {
        e_player.var_a1ba5103 = 1;
        e_player.var_66e0478a = 5;
      }
      break;
    }
  }
}