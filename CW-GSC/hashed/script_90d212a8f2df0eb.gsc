/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_90d212a8f2df0eb.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_5a7c9cfbe3d9580c;
#using script_61fee52bb750ac99;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_prisoner;
#using scripts\cp\cp_nam_prisoner_fx;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;
#namespace namespace_dfa5ee23;

function start(str_objective) {}

function main(str_objective, var_50cc0d4f) {
  if(level.var_731c10af.var_42659717 == 0) {
    next_obj = "path_end_1";
  }

  if(level.var_731c10af.var_42659717 == 1) {
    next_obj = "path_end_2";
  }

  if(level.var_731c10af.var_42659717 == 2) {
    next_obj = "path_end_3";
  }

  if(level.var_731c10af.var_42659717 == 3) {
    next_obj = "path_end_4";
  }

  level thread cp_nam_prisoner::function_1f911b89(next_obj);
  flag = "village";
  level flag::wait_till(flag + "_complete");
  level skipto::function_4e3ab877(var_50cc0d4f, 0);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  wait 1;
  village_heli = getEntArray("village_heli", "targetname");

  if(isDefined(village_heli)) {
    array::thread_all(village_heli, &namespace_d9b153b9::ent_cleanup);
  }

  village_allies_01 = getEntArray("village_allies_01", "targetname");
  array::thread_all(village_allies_01, &namespace_d9b153b9::ent_cleanup);
  village_allies_02 = getEntArray("village_allies_02", "targetname");
  array::thread_all(village_allies_02, &namespace_d9b153b9::ent_cleanup);
  village_enemies_01 = getEntArray("village_enemies_01", "targetname");
  array::thread_all(village_enemies_01, &namespace_d9b153b9::ent_cleanup);
  village_enemies_02 = getEntArray("village_enemies_02", "targetname");
  array::thread_all(village_enemies_02, &namespace_d9b153b9::ent_cleanup);
  village_enemies_03 = getEntArray("village_enemies_03", "targetname");
  array::thread_all(village_enemies_03, &namespace_d9b153b9::ent_cleanup);
  village_enemies_04 = getEntArray("village_enemies_04", "targetname");
  array::thread_all(village_enemies_04, &namespace_d9b153b9::ent_cleanup);
  village_enemies_05 = getEntArray("village_enemies_05", "targetname");
  array::thread_all(village_enemies_05, &namespace_d9b153b9::ent_cleanup);
  village_enemies_06 = getEntArray("village_enemies_06", "targetname");
  array::thread_all(village_enemies_06, &namespace_d9b153b9::ent_cleanup);
  village_bridge_and_gate_clip = getEntArray("village_bridge_and_gate_clip", "targetname");
  array::thread_all(village_bridge_and_gate_clip, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_village_heli_bridge_explosion_smart_models");
  var_fc3729bf = getent("village_barrel", "targetname");

  if(isDefined(var_fc3729bf)) {
    var_233809e = getEntArray(var_fc3729bf.target, "targetname");
  }

  if(isDefined(var_233809e)) {
    if(!isDefined(var_233809e)) {
      var_233809e = [];
    } else if(!isarray(var_233809e)) {
      var_233809e = array(var_233809e);
    }

    var_233809e[var_233809e.size] = var_fc3729bf;
    arrayremovevalue(var_233809e, undefined);
    array::thread_all(var_233809e, &namespace_d9b153b9::ent_cleanup);
  }

  village_barrels_clip = getEntArray("village_barrels_clip", "targetname");
  array::thread_all(village_barrels_clip, &namespace_d9b153b9::ent_cleanup);
  gates = getEntArray("village_gates_whole", "targetname");
  array::thread_all(gates, &namespace_d9b153b9::ent_cleanup);
  var_e2c87cc0 = getent("village_left_tower_roof", "targetname");

  if(isDefined(var_e2c87cc0)) {
    var_e2c87cc0 thread namespace_d9b153b9::ent_cleanup();
  }

  village_triggers = getEntArray("village_triggers", "script_noteworthy");
  array::thread_all(village_triggers, &namespace_d9b153b9::ent_cleanup);
  village_volumes = getEntArray("village_volumes", "script_noteworthy");
  array::thread_all(village_volumes, &namespace_d9b153b9::ent_cleanup);
  village_siege_anim_scripted_clip = getEntArray("village_siege_anim_scripted_clip", "targetname");
  array::thread_all(village_siege_anim_scripted_clip, &namespace_d9b153b9::ent_cleanup);
  door_struct = namespace_d9b153b9::door_setup("village_door_struct", 1, 1);
  door_struct thread namespace_d9b153b9::ent_cleanup();
}

function function_c26b0bc0() {
  level flag::init("start_village_ally_vo");
  level flag::init("village_complete");
  level flag::init("flag_village_heli_exit");
}

function village() {
  level endon(#"start_outro");
  var_c79d614f = "village";
  level flag::wait_till("flag_" + var_c79d614f);
  level.var_3f5c80c8 = "village";
  level.player clientfield::set_to_player("force_stream_weapons", 1);
  level thread namespace_d9b153b9::function_27efd762(3, ["flag_village"], ["village_complete"]);
  level thread function_83e9c57d();
  level thread exploder::exploder("lgt_village_explosion_left");
  level thread exploder::exploder("lgt_village_explosion_right");
  level thread savegame::checkpoint_save();
  var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
  str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f;
  bb::function_cd497743(str, level.player);
  level thread function_6f9e660();
  level thread namespace_979752dc::disable_stealth_system();
  level flag::set("no_corpse_pickup ");
  level scene::init("scene_pri_tower_left_tower");
  level scene::init("scene_pri_tower_right_tower");
  level scene::init("scene_pri_village_bridge");
  level clientfield::set("dmg_models_and_vol_decals_village", 0);
  level thread village_chickens();
  level flag::set("flag_village_observe_adler_door_sm");

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
    level thread function_10575162();
  }

  level thread function_da7ec7d7(var_c79d614f);
  level thread function_3327e7a6();
  level thread function_6dca0648();
  level thread namespace_b6fe1dbe::music("16.0_village");
  createthreatbiasgroup("enemies");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("player");
  createthreatbiasgroup("chopper_enemies");
  level.player setthreatbiasgroup("player");
  setthreatbias("allies", "enemies", -100);
  level thread village_allies();
  level thread village_enemies();
  level thread village_heli();
  level flag::wait_till(var_c79d614f + "_door_opened");
  level notify(#"hash_51ed2c8b384afa58");
  namespace_d9b153b9::function_e106e062(var_c79d614f);
  level thread namespace_979752dc::enable_stealth_system();
  level flag::clear("no_corpse_pickup ");
  level flag::clear("flag_village_observe_adler_door_sm");
  level flag::set(var_c79d614f + "_complete");
}

function village_allies() {
  var_dd865b5e = spawner::simple_spawn("village_allies_01", &function_12c3e749);
  var_5d5fdb17 = spawner::simple_spawn("village_allies_02", &function_12c3e749);
  level function_5afed205(var_dd865b5e, var_5d5fdb17);
  level function_9d29fc1a();
}

function function_5afed205(var_dd865b5e, var_5d5fdb17) {
  level thread scene::play("scene_pri_village_entrance", var_dd865b5e);
  var_dd865b5e thread function_8de694ca();
  level thread scene::init("scene_pri_wounded_drag", var_5d5fdb17);
  level flag::wait_till("flag_start_village_drag");
  level thread scene::play("scene_pri_wounded_drag", var_5d5fdb17);
  var_95bb853 = arraycombine(var_dd865b5e, var_5d5fdb17);

  foreach(ai_ally in var_95bb853) {
    ai_ally clearforcedgoal();
  }
}

function function_9d29fc1a() {
  level flag::wait_till("flag_village_heli_exit");
  a_allies = spawner::get_ai_group_ai("village_allies");

  foreach(guy in a_allies) {
    guy util::stop_magic_bullet_shield();
    guy thread function_f71455a3();
  }

  trigger::use("village_ally_end_trigger", "targetname");
  wait 5;
  a_allies = spawner::get_ai_group_ai("village_allies");

  foreach(guy in a_allies) {
    guy ai::set_behavior_attribute("demeanor", "patrol");
    wait randomfloatrange(0.5, 1.5);
  }
}

function village_chickens() {
  level thread scene::play("village_chickens");
  level flag::wait_till("village_complete");
  level scene::stop("village_chickens", 1);
}

function function_f71455a3() {
  ai = self;
  namespace_d9b153b9::function_34961864(ai);
}

function function_12c3e749() {
  self.grenadeammo = 0;
  self.old_accuracy = self.script_accuracy;
  self.script_accuracy = 0.3;
  self.health = int(self.maxhealth * 1.5);
  self.goalradius = 32;
  self util::magic_bullet_shield();
  self setthreatbiasgroup("allies");
}

function village_enemies() {
  level thread function_623afbee();
  var_74d58cc5 = spawner::simple_spawn("village_enemies_01", &function_40d1ab18);
  level thread ai::function_b0bd06fa("village_enemies", 7, "flag_village_start_wave_02");
  level flag::wait_till("flag_village_start_wave_02");
  level thread ai::function_bb79f1ad("village_enemies", "vol_village_corner");
  waitframe(1);
  level thread function_a099daab("trigger_village_start_wave_02");
  wait 1;
  var_9715d145 = spawner::simple_spawn("village_enemies_02", &function_e1642537);
  level thread ai::function_b0bd06fa("village_enemies", 6, "flag_village_start_wave_03");
  level flag::wait_till("flag_village_start_wave_03");
  level thread ai::function_bb79f1ad("village_enemies", "vol_village_corner");
  waitframe(1);
  level thread function_a099daab("trigger_village_start_wave_03");
  wait 3;
  var_c953b5c0 = spawner::simple_spawn("village_enemies_03", &function_e1642537);
  level thread ai::function_b0bd06fa("village_enemies", 5, "flag_village_start_wave_04");
  level flag::wait_till("flag_village_start_wave_04");
  level thread ai::function_bb79f1ad("village_enemies", "vol_village_mid");
  waitframe(1);
  level thread function_a099daab("trigger_village_start_wave_04");
  var_bd949e42 = spawner::simple_spawn("village_enemies_04", &function_e1642537);
  level thread ai::function_b0bd06fa("village_enemies", 4, "flag_village_start_wave_05");
  level flag::wait_till("flag_village_start_wave_05");
  level thread ai::function_bb79f1ad("village_enemies", "vol_village_courtyard");
  waitframe(1);
  level thread function_a099daab("trigger_village_start_wave_05");
  level thread function_b88d43ca();
  var_4692bf6 = spawner::simple_spawn("village_enemies_05", &function_e1642537);
  level flag::wait_till("flag_village_start_wave_06");
  level thread ai::function_bb79f1ad("village_enemies", "vol_village_final_retreat", 1);
  waitframe(1);
  var_f62b8f7b = spawner::simple_spawn("village_enemies_06", &function_4b09eae1);
}

function function_623afbee() {
  level endon(#"flag_village_start_wave_04");
  level flag::wait_till("flag_village_start_wave_03_house");
  var_c953b5c0 = spawner::simple_spawn("village_enemies_03_house", &function_e1642537);
}

function function_b88d43ca() {
  allies = spawner::get_ai_group_ai("village_allies");

  foreach(guy in allies) {
    guy.script_accuracy = 1000;
    guy.perfectaim = 1;
  }
}

function function_59006d99() {
  allies = spawner::get_ai_group_ai("village_allies");

  foreach(guy in allies) {
    guy.script_accuracy = 1;
    guy.perfectaim = 0;
  }
}

function function_a484ebe4() {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level thread function_b88d43ca();
  guys = spawner::get_ai_group_ai("village_enemies");
  player = getplayers()[0];

  while(guys.size > 0) {
    guys = spawner::get_ai_group_ai("village_enemies");
    function_1eaaceab(guys);
    guys = array::randomize(guys);
    e_guy = guys[0];

    if(isalive(e_guy) && !e_guy flag::get("in_action")) {
      var_1fc3ca35 = randomintrange(-48, 49);
      magicbullet(getweapon(#"hash_4ff481a4f55ed901"), player.origin + anglesToForward(player getplayerangles()) + (var_1fc3ca35, -128, 56), e_guy gettagorigin("tag_eye"));
      e_guy kill();
    }

    wait randomfloatrange(0.5, 1.5);
  }
}

function function_e1642537() {
  self endon(#"death");
  self setthreatbiasgroup("enemies");

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "village_bridge_enemy_01" || self.script_noteworthy == "village_bridge_enemy_02" || self.script_noteworthy == "village_bridge_enemy_03") {
      self thread function_b792b738();
    }
  }

  if(isDefined(self.script_aigroup) && self.script_aigroup == "village_heli_enemies") {
    level flag::wait_till("flag_village_start_wave_06");
    self thread function_4b09eae1();
  }
}

function function_40d1ab18() {
  self.grenadeammo = 0;
  self setthreatbiasgroup("enemies");
}

function function_b792b738() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "village_bridge_enemy_01") {
    level.village_bridge_enemy_01 = self;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "village_bridge_enemy_02") {
    level.village_bridge_enemy_02 = self;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "village_bridge_enemy_03") {
    level.village_bridge_enemy_03 = self;
  }
}

function function_4b09eae1() {
  self.grenadeammo = 0;
  self.old_accuracy = self.script_accuracy;
  self.script_accuracy = 0.15;
  self.fixednode = 1;
  self val::set("chopper_attack", "ignoreme", 1);

  switch (self.script_noteworthy) {
    case # "hash_194f7fca3276c659":
      self thread function_7538985e();
      self thread function_d559f227("village_heli_kill_guy_01");
      break;
    case # "hash_194f7cca3276c140":
      self thread function_7538985e();
      self thread function_d559f227("village_heli_kill_guy_02");
      break;
    case # "hash_194f7dca3276c2f3":
      self thread function_7538985e();
      self thread function_d559f227("village_heli_kill_guy_03");
      break;
    case # "hash_194f82ca3276cb72":
      self thread function_d559f227("village_heli_kill_guy_04");
      break;
    case # "hash_194f83ca3276cd25":
      self thread function_d559f227("village_heli_kill_guy_05");
      break;
    case # "hash_194f80ca3276c80c":
      self thread function_7538985e();
      self thread function_d559f227("village_heli_kill_guy_06");
      break;
  }
}

function function_7538985e() {
  self endon(#"death");

  while(!isDefined(level.var_a1414070)) {
    wait 0.25;
  }

  if(isalive(self)) {
    self ai::shoot_at_target("normal", level.var_a1414070, "tag_origin", 10);
  }
}

function village_heli() {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level flag::wait_till("flag_village_start_wave_06");
  level.player namespace_6cecf2d8::function_9fa1a484();
  level.var_a1414070 = vehicle::simple_spawn_single("village_heli");
  level.var_a1414070 setrotorspeed(1);
  level.var_a1414070.ignoreme = 1;
  level.var_a1414070 vehicle::bullet_shielded(1);
  level.var_a1414070 vehicle::toggle_tread_fx(1);
  level.var_a1414070 vehicle::toggle_exhaust_fx(1);
  level.var_a1414070 vehicle::toggle_sounds(0);
  level.var_a1414070 playrumblelooponentity("cp_nam_prisoner_heli_flyby");
  level.var_a1414070 endon(#"death");
  level thread namespace_b6fe1dbe::function_2faf67e();
  level thread namespace_b6fe1dbe::function_25065c16(level.var_a1414070);
  level thread namespace_b6fe1dbe::function_2c89f1cf(level.var_a1414070);
  village_heli_riders = spawner::simple_spawn("village_heli_riders", &function_755ddd07);
  var_d8bef009 = util::spawn_model("p7_generic_prop_x3");
  level.var_88166dcc = util::spawn_model("tag_origin", var_d8bef009 gettagorigin("j_prop_1"), var_d8bef009 gettagangles("j_prop_1"));
  level.var_88166dcc linkto(var_d8bef009, "j_prop_1");
  a_ents = [];
  a_ents[#"village_heli"] = level.var_a1414070;
  a_ents[#"hash_26400e73546a78c8"] = var_d8bef009;
  level thread scene::add_scene_func("scene_pri_village_destruction_heli", &function_94850755, "play");
  level thread scene::init("scene_pri_village_destruction_heli", a_ents);
  waitframe(1);
  level scene::play("scene_pri_village_destruction_heli", a_ents);
  wait 2.5;
  level.var_88166dcc delete();
  level flag::wait_till("village_complete");
  level scene::stop("scene_pri_tower_left_tower");
  level scene::delete_scene_spawned_ents("scene_pri_tower_left_tower");
  level scene::stop("scene_pri_tower_right_tower");
  level scene::delete_scene_spawned_ents("scene_pri_tower_right_tower");
  level scene::stop("scene_pri_village_bridge");
  level scene::delete_scene_spawned_ents("scene_pri_village_bridge");
  level scene::stop("scene_pri_village_destruction_heli");
  level scene::delete_scene_spawned_ents("scene_pri_village_destruction_heli");
  level thread exploder::stop_exploder("village_missile_strike_01");
  level thread exploder::stop_exploder("village_missile_strike_02_bridge");
  level thread exploder::stop_exploder("village_missile_strike_02_gate");
}

function function_755ddd07() {
  self endon(#"death");
  self animation::detach_weapon(self.weapon);
  self util::magic_bullet_shield();
  self.script_allowdeath = 0;
  self.allowdeath = 0;
  self.ignoreme = 1;
  waitframe(1);
  self vehicle::get_in(self, level.var_a1414070);
  util::waittill_any_ents(level.var_a1414070, "death", level, "village_complete");

  if(isDefined(self)) {
    self util::stop_magic_bullet_shield();
    self.script_allowdeath = 1;
    self.allowdeath = 1;
    self delete();
  }
}

function function_94850755() {
  level waittill(#"village_heli_missile");
  level thread scene::play("scene_pri_tower_left_tower");
  screenshake(getent("camshake_tower_l_missile", "targetname").origin, 1.5, 1, 1, 0.3, 0, 0.1, 2239, 10, 0, 1, 1.5);
  level thread exploder::exploder("village_missile_strike_01");
  level.player playrumbleonentity("damage_heavy");
  var_e2c87cc0 = getent("village_left_tower_roof", "targetname");
  var_e2c87cc0 delete();
  level flag::set("village_missile_strike_explo_1");
  var_2dd62fba = getEntArray("village_end_spotlight_model", "targetname");

  foreach(var_a498d2d1 in var_2dd62fba) {
    if(isDefined(var_a498d2d1)) {
      var_a498d2d1 delete();
    }
  }

  var_16d40914 = getent("brushmodel_tower_left", "targetname");
  var_16d40914 delete();
  level thread exploder::stop_exploder("lgt_village_explosion_left");
  level waittill(#"hash_851da51ba378f2d");
  level thread function_a484ebe4();
  level thread function_e05f6671();
  level flag::set("village_missile_strike_explo_3");
  var_a4394835 = getent("vol_village_heli_kill_zone", "targetname");
  a_targets = var_a4394835 ai::function_18c4ff86("axis");
  level.var_a1414070 turretsettarget(1, level.var_88166dcc);
  level.var_a1414070 thread function_66311af9();
  level.var_a1414070 thread function_8ce745a6(level.var_88166dcc);
  level waittill(#"hash_3db629f9bf3c2182");
  level thread scene::play("scene_pri_tower_right_tower");
  var_10f7891b = getent("village_end_spotlight_model_r", "targetname");

  if(isDefined(var_10f7891b)) {
    var_10f7891b delete();
  }

  var_f84681a7 = getent("brushmodel_tower_right", "targetname");
  var_f84681a7 delete();
  level thread exploder::stop_exploder("lgt_village_explosion_right");
  wait 2.49;
  screenshake(getent("camshake_tower_r_collapse", "targetname").origin, 1, 1, 1, 0.2, 0, 0.1, 2239, 8, 0, 1, 2.5);
  level.player playrumbleonentity("damage_heavy");
}

function function_d559f227(wait_till) {
  level endon(#"hash_45a240c655ea4901");
  level waittill(wait_till);

  if(isalive(self)) {
    self ai::bloody_death();
  }

  waitframe(1);

  if(isalive(self) && !self flag::get("in_action")) {
    self kill();
  }
}

function function_83e9c57d() {
  level.player endon(#"death");
  village_siege_anim_scripted_clip = getEntArray("village_siege_anim_scripted_clip", "targetname");

  foreach(ent in village_siege_anim_scripted_clip) {
    if(isDefined(ent)) {
      ent notsolid();
    }
  }

  level flag::wait_till("village_missile_strike_explo_barrel");
  wait 3;
  vol = getent("village_siege_anim_volume", "targetname");

  if(!isDefined(vol)) {
    return;
  }

  var_10ea3e21 = 0;

  while(true) {
    foreach(ent in village_siege_anim_scripted_clip) {
      if(!level.player istouching(vol)) {
        var_10ea3e21++;
      }
    }

    if(var_10ea3e21 == village_siege_anim_scripted_clip.size) {
      break;
    } else {
      var_10ea3e21 = 0;
    }

    wait 1;
  }

  foreach(ent in village_siege_anim_scripted_clip) {
    if(isDefined(ent)) {
      ent solid();
    }
  }
}

function function_66311af9() {
  level waittill(#"hash_7d03df6a2b110ebe");
  level scene::play("scene_pri_village_bridge");
  level thread exploder::exploder("village_missile_strike_02_bridge");
  level flag::set("village_missile_strike_explo_barrel");
  screenshake(getent("camshake_bridge_ammo_exp", "targetname").origin, 1.5, 1, 1, 0.3, 0, 0.1, 2239, 11, 0, 1, 1.5);
  wait 0.3;
  level thread exploder::exploder("village_missile_strike_02_gate");
  level thread function_181a46f();
  village_bridge_and_gate_clip = getEntArray("village_bridge_and_gate_clip", "targetname");
  array::thread_all(village_bridge_and_gate_clip, &namespace_d9b153b9::ent_cleanup);
  level clientfield::set("dmg_models_and_vol_decals_village", 1);
  level flag::set("flag_village_heli_bridge_explosion_smart_models");
  screenshake(getent("camshake_barrel_l_exp", "targetname").origin, 3.5, 1, 3, 0.5, 0, 0.3, 2239, 10, 0, 1, 1.2);
  wait 0.35;
  screenshake(getent("camshake_barrel_r_exp", "targetname").origin, 2.5, 0.8, 0.5, 1.5, 0, 1.5, 2239, 10, 0, 1, 1.2);
  level flag::set("village_missile_strike_explo_2");
  wait 0.3;
  var_fc3729bf = getent("village_barrel", "targetname");
  var_233809e = getEntArray(var_fc3729bf.target, "targetname");
  array::delete_all(var_233809e);
  var_fc3729bf delete();
  village_barrels_clip = getEntArray("village_barrels_clip", "targetname");
  array::thread_all(village_barrels_clip, &namespace_d9b153b9::ent_cleanup);
  gates = getEntArray("village_gates_whole", "targetname");

  foreach(gate in gates) {
    gate setModel(#"p9_vnm_gate_dest_01");
  }
}

function function_181a46f() {
  wait 0.3;

  if(isalive(level.village_bridge_enemy_01)) {
    level.village_bridge_enemy_01 delete();
  }

  if(isalive(level.village_bridge_enemy_02)) {
    level.village_bridge_enemy_02 delete();
  }

  if(isalive(level.village_bridge_enemy_03)) {
    level.village_bridge_enemy_03 delete();
  }

  village_bridge_volume = getent("village_bridge_volume", "targetname");
  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    if(isactorcorpse(corpse) && corpse istouchingvolume(village_bridge_volume.origin, village_bridge_volume getmins(), village_bridge_volume getmaxs())) {
      corpse delete();
    }
  }
}

function function_e05f6671() {
  level waittill(#"hash_45a240c655ea4901");
  level flag::set("flag_village_heli_exit");
}

function function_8ce745a6(var_28c80d45) {
  wait 1;
  level flag::set("flag_village_heli_turret_loop_start");
  var_af2a1727 = [(0, 0, 128), (-128, -128, -128)];

  while(!level flag::get("flag_village_heli_exit")) {
    if(isalive(self) && isDefined(var_28c80d45)) {
      self fireweapon(1, var_28c80d45);
    }

    waitframe(2);

    if(isalive(self) && isDefined(var_28c80d45)) {
      self fireweapon(1, var_28c80d45);
    }

    waitframe(2);
  }

  if(isalive(self)) {
    self stopfireweapon();
    self turretcleartarget(1);
  }

  wait 0.2;

  if(isalive(self)) {
    self stopfireweapon();
  }

  level flag::set("flag_village_heli_turret_loop_stop");
}

function function_3327e7a6() {
  level flag::wait_till("flag_village_heli_exit");
  level thread namespace_b6fe1dbe::music("23.0_napalm_ending");
}

function function_6dca0648() {
  level flag::wait_till("flag_village_bunker_found");
  level thread namespace_b6fe1dbe::music("10.0_door_2");
}

function function_da7ec7d7(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level childthread function_a553718();

  if(level.var_baa7cf92 != "village") {
    thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);
  } else {
    thread namespace_b6fe1dbe::function_34830cda(var_c79d614f);
  }

  thread dialogue::radio("vox_cp_prsn_05800_adlr_seeingafirefigh_69");
  wait 2;
  level flag::set("start_village_ally_vo");
  level thread namespace_d9b153b9::force_weapon_loadout("village");
  level childthread namespace_d9b153b9::function_f6cbf7fd(&function_afa54b01, 1, 20, "flag_village_start_wave_04");
  level flag::wait_till("flag_village_heli_exit");
  level childthread namespace_d9b153b9::function_f6cbf7fd(&function_af3cf52a, 1, 20, "flag_village_bunker_found");
  level flag::wait_till("flag_village_bunker_found");
  dialogue::radio("vox_cp_prsn_05800_adlr_yesthiswasthebu_9c");
  level childthread namespace_d9b153b9::function_f6cbf7fd(&function_84f506c9, 1, 10, "village_complete");
}

function function_8de694ca() {
  foreach(leader in self) {
    if(isDefined(leader.animname) && leader.animname == "Squad Leader") {
      leader function_62764b43();
      break;
    }
  }

  level thread namespace_b6fe1dbe::function_51f7c962();
  self function_4eae827f();
  self function_27aeb480();
  self function_7af05b02();
  self function_60e32704();
  self function_8d8bb4cc();
  self function_26d5ea4c();
}

function function_62764b43() {
  self endon(#"death");
  self dialogue::queue("vox_cp_prsn_36500_ams1_gogogogettocove_be");
  level flag::wait_till("start_village_ally_vo");
  self dialogue::queue("vox_cp_prsn_36600_ams1_commandwevestir_c5");
  wait 1;
  dialogue::radio("vox_cp_prsn_36600_cmnd_rogerthatchoppe_cb");
}

function function_4eae827f() {
  level endon(#"flag_village_start_wave_02");

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_32000_ams1_comingfromthewi_15");
  }

  wait 2;

  if(isalive(self[1])) {
    self[1] dialogue::queue("vox_cp_prsn_32000_ams1_getbehindsometh_b9");
  }

  wait 2;

  if(isalive(self[2])) {
    self[2] thread dialogue::queue("vox_cp_prsn_32000_ams3_laydownsuppress_8b");
  }

  if(isalive(self[1])) {
    self[1] dialogue::queue("vox_cp_prsn_32000_ams2_jonesisdown_7e");
  }

  wait 2;

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams2_pushforward_d6");
  }
}

function function_27aeb480() {
  level endon(#"flag_village_start_wave_03");
  level flag::wait_till("flag_village_start_wave_02");

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams2_behindthathouse_80");
  }

  wait 3;

  if(isalive(self[1])) {
    self[1] thread dialogue::queue("vox_cp_prsn_36600_ams2_pushforward_d6");
  }

  if(isalive(self[2])) {
    self[2] dialogue::queue("vox_cp_prsn_32000_ams3_2oclock_73");
  }

  wait 4;

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams2_pushforward_d6");
  }

  wait 4;

  if(isalive(self[2])) {
    self[2] thread dialogue::queue("vox_cp_prsn_32000_ams3_laydownsuppress_8b");
  }
}

function function_7af05b02() {
  level endon(#"flag_village_start_wave_04");
  level flag::wait_till("flag_village_start_wave_03");

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams3_behindthatboat_02");
  }

  wait 3;

  if(isalive(self[1])) {
    self[1] thread dialogue::queue("vox_cp_prsn_36600_ams3_sniperuptop_0a");
  }

  wait 1;

  if(isalive(self[2])) {
    self[2] dialogue::queue("vox_cp_prsn_36600_ams3_behindthewall_9c");
  }

  wait 3;

  if(isalive(self[1])) {
    self[1] dialogue::queue("vox_cp_prsn_32000_ams2_covermeimdry_7e");
  }

  wait 4;

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams2_pushforward_d6");
  }
}

function function_60e32704() {
  level endon(#"flag_village_start_wave_05");
  level flag::wait_till("flag_village_start_wave_04");

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams2_vconthebalcony_20");
  }

  wait 4;

  if(isalive(self[1])) {
    self[1] thread dialogue::queue("vox_cp_prsn_36600_ams2_pushupthehill_f0");
  }

  wait 2;

  if(isalive(self[2])) {
    self[2] dialogue::queue("vox_cp_prsn_32000_ams3_laydownsuppress_8b");
  }

  wait 4;

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams3_sniperuptop_0a");
  }

  wait 4;

  if(isalive(self[1])) {
    self[1] thread dialogue::queue("vox_cp_prsn_36600_ams2_pushupthehill_f0");
  }
}

function function_8d8bb4cc() {
  level flag::wait_till("flag_village_start_wave_05");
  dialogue::radio("vox_cp_prsn_36600_ams1_wheresmygoddamn_d8");
  level flag::wait_till("flag_village_start_wave_06");
  wait 1.75;
  dialogue::radio("vox_cp_prsn_36600_pilo_redteamengaging_db");
}

function function_26d5ea4c() {
  level endon(#"village_complete");
  level flag::wait_till("flag_village_heli_exit");

  if(isalive(self[2])) {
    self[2] thread dialogue::queue("vox_cp_prsn_36600_ams2_cheer_58");
  }

  if(isalive(self[0])) {
    self[0] thread dialogue::queue("vox_cp_prsn_36600_ams3_cheer_58");
  }

  wait 2.25;
  dialogue::radio("vox_cp_prsn_36600_pilo_threatneutraliz_27");

  if(isalive(self[1])) {
    self[1] thread dialogue::queue("vox_cp_prsn_36600_ams2_fuckyeah_71");
  }

  if(isalive(self[2])) {
    self[2] thread dialogue::queue("vox_cp_prsn_37200_ams3_cheer_58");
  }

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_37200_ams2_cheer_58");
  }

  if(isalive(self[0])) {
    self[0] dialogue::queue("vox_cp_prsn_36600_ams1_thanksbuddyidon_53");
  }
}

function function_10575162() {
  level flag::wait_till_any(array("flag_adler_village_disappear", "flag_adler_village_disappear_2"));

  if(level flag::get("flag_adler_village_disappear")) {
    level thread scene::play_from_time("scene_pri_village_observe", "shot 2", undefined, 0.5);
  } else {
    level thread scene::play_from_time("scene_pri_village_observe", "shot 2", undefined, 0.15);
  }

  level waittill(#"hash_77a198ac8c44bc25");
  village_observe_adler_door = getent("village_observe_adler_door", "targetname");

  if(isDefined(village_observe_adler_door)) {
    village_observe_adler_door rotateyaw(90, 0.75);
  }

  level waittill(#"hash_9dc03befc6c3e71");

  if(isDefined(village_observe_adler_door)) {
    village_observe_adler_door rotateyaw(-90, 0.75);
  }
}

function function_a553718() {
  level flag::wait_till("flag_village_house_01_vo");
  dialogue::radio("vox_cp_prsn_14700_adlr_thatsallweneedt_4b");
}

function function_f7fc9267() {
  level flag::wait_till("flag_village_house_02_vo");
  dialogue::radio("vox_cp_prsn_14700_adlr_okayyoufoundsom_6b");
}

function function_2e3afee3() {
  level flag::wait_till("flag_village_house_03_vo");
  dialogue::radio("vox_cp_prsn_14700_adlr_weaponsanddrugs_27");
}

function function_afa54b01() {
  namespace_d9b153b9::function_f76551eb("vox_cp_prsn_14700_park_bellyouredoingf_ba", "vox_cp_prsn_14700_lazr_hangintherebell_6f", "vox_cp_prsn_14700_sims_youredoinggreat_e8");
}

function function_af3cf52a() {
  level childthread namespace_d9b153b9::function_f6cbf7fd(&function_df0e0956, 1, 10);
}

function function_df0e0956() {
  dialogue::radio("vox_cp_prsn_14700_adlr_whathappenedaft_fc");
}

function function_84f506c9() {
  dialogue::radio("vox_cp_prsn_14700_adlr_bellwhatdidyouf_b2");
}

function function_909afeee(str_objective, var_50cc0d4f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  var_c79d614f = "<dev string:x38>";
  level flag::set("<dev string:x43>" + var_c79d614f);
  level.var_3f5c80c8 = "<dev string:x38>";
  level thread namespace_d9b153b9::force_weapon_loadout("<dev string:x38>");
  createthreatbiasgroup("<dev string:x4c>");
  createthreatbiasgroup("<dev string:x57>");
  createthreatbiasgroup("<dev string:x61>");
  createthreatbiasgroup("<dev string:x6b>");
  level function_b94d034f(var_c79d614f);
}

function function_b94d034f(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level scene::init("<dev string:x7e>");
  level scene::init("<dev string:x9c>");
  level scene::init("<dev string:xbb>");
  level clientfield::set("<dev string:xd7>", 0);
  level.player setthreatbiasgroup("<dev string:x61>");
  setthreatbias("<dev string:x57>", "<dev string:x4c>", -100);
  var_f62b8f7b = spawner::simple_spawn("<dev string:xfc>", &function_4b09eae1);
  level thread village_heli();
  level flag::set("<dev string:x112>");
}

function function_a099daab(var_9c878bb5) {
  wait 3;

  if(isDefined(getent(var_9c878bb5, "targetname"))) {
    trigger::use(var_9c878bb5);
  }
}

function function_6f9e660() {
  level flag::wait_till("flag_village_backtrack_blocker");
  cp_nam_prisoner_fx::function_f5f449bd();
}