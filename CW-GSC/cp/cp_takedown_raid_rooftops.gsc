/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_raid_rooftops.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3626f1b2cf51a99c;
#using script_3d18e87594285298;
#using script_3dc93ca9902a9cda;
#using script_5431e074c1428743;
#using script_61cfc2ab8e60625;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_raid_apt;
#using scripts\cp\cp_takedown_raid_bar;
#using scripts\cp\cp_takedown_raid_slide;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace tkdn_raid_roof;

function starting(var_d3440450) {
  var_8a3bb97c = getspawnerarray("raid_adler", "targetname");
  var_8a3bb97c[0] spawner::add_spawn_function(&namespace_b100dd86::function_9109a1fe);
  woods_spawner = getspawnerarray("raid_woods", "targetname");
  woods_spawner[0] spawner::add_spawn_function(&namespace_b100dd86::function_87d56d50);
  level.adler = var_8a3bb97c[0] spawner::spawn(1);
  level.woods = woods_spawner[0] spawner::spawn(1);
  var_fcbd93e0 = struct::get("raid_roof_adler", "targetname");
  var_1100faeb = struct::get("raid_roof_woods", "targetname");
  level.adler forceteleport(var_fcbd93e0.origin, var_fcbd93e0.angles);
  level.woods forceteleport(var_1100faeb.origin, var_1100faeb.angles);
  player = getplayers()[0];
  var_5ca6956f = getweapon(#"ar_accurate_t9", "steadyaim", "reflex");
  var_a3379ef0 = getweapon(#"ar_standard_t9", "steadyaim", "reflex");
  level.woods setweapon(var_a3379ef0);
  level.adler setweapon(var_5ca6956f);
  player giveweapon(var_5ca6956f);
  player switchtoweapon(var_5ca6956f);
  var_d1a2cc43 = getspawnerarray("qasim_runner", "script_noteworthy");

  foreach(spawner in var_d1a2cc43) {
    spawner spawner::add_spawn_function(&namespace_b100dd86::function_6578b894);
  }

  tkdn_raid_apt::function_aeaba0c9("glass_door_start_left", "glass_door_dest_left", 0);
  tkdn_raid_apt::function_aeaba0c9("glass_door_start_right", "glass_door_dest_right", 0);
  tkdn_raid_apt::function_aeaba0c9("glass_door_start_left", "glass_door_dest_left", 0);
  tkdn_raid_apt::function_aeaba0c9("glass_door_start_right", "glass_door_dest_right", 0);
  tkdn_raid_apt::function_aeaba0c9("glass_door_start_left", "glass_door_dest_left", 0);
  tkdn_raid_apt::function_aeaba0c9("glass_door_start_right", "glass_door_dest_right", 0);
  level scene::play("scene_tkd_hit2_apt_blindfire_bathroom", "death");
  thread objectives::scripted("obj_takedown_capture", undefined, #"hash_49c1d860c97e3792");
}

function main(var_d3440450, var_50cc0d4f) {
  exploder::exploder("lgt_vista_lights");
  level notify(#"hash_530a04ce72c2c9");
  level thread namespace_b100dd86::function_c212022b(180);

  if(var_50cc0d4f) {
    level namespace_a052577e::function_1dc92e4f();
    level thread scene::init("scene_tkd_hit2_adler_alley");
    level thread scene::play("scene_tkd_hit2_adler_alley", "gate_closed");
    getactorarray("apt_blindfire_bathroom", "targetname")[0] delete();
    var_efac709f = getent("player_breach_clip", "targetname");
    var_efac709f connectpaths();
    var_efac709f delete();
    level battlechatter::function_2ab9360b(1);
  }

  level thread savegame::checkpoint_save(1);
  level.woods.script_accuracy = 1;
  level.adler.script_accuracy = 1;
  player = getplayers()[0];
  var_6097a10b = getspawnerarray("qasim_vault", "targetname");
  var_6097a10b[0] spawner::add_spawn_function(&function_a1d9cae0);
  level thread takedown_tutorial();
  level thread function_fb0dffdf();
  level thread rooftop_vo();
  thread namespace_a052577e::function_38a8c5b0();
  self util::blend_movespeedscale(0.85, 1);
  level flag::wait_till("raid_roof_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function takedown_tutorial() {
  player = getplayers()[0];
  player thread function_aec55b72();
  level flag::wait_till("flag_takedown_tutorial_player_mantling");
  player val::set(#"takedown_tutorial", "allow_sprint", 0);
  player util::delay(1, undefined, &val::set, #"takedown_tutorial", "freezecontrols", 1);
  level thread scene::play("scene_tkd_hit2_apt_takedown_tutorial");
  player playgestureviewmodel(#"hash_320d152af1fadd63", undefined, 1, 1, 0, 1, 1);
  wait 1.25;
  player stopanimscripted();
  hint_data = [hint_tutorial::function_f0104b5([#"hash_5f8c7ca0a178e810", #"hash_46b1d4bb698b8298"])];
  hint_tutorial::function_4c2d4fc4(#"hash_e67c810a4c45083", #"hash_4f8907e75463e084", undefined, undefined, undefined, undefined, undefined, 1, hint_data);
  hint_tutorial::pause("+melee_zoom;+melee", #"hash_2b84cc72687b168a");
  player val::reset_all(#"takedown_tutorial");
  victim = player.takedown.potential_victims[0];

  if(isDefined(victim)) {
    victim.takedamage = 1;
    victim.var_ab101371 = # "hash_10e2d6b9f9bef6a3";
    player.takedown.victim[#"takedown"] = victim;
    player.takedown.scene[#"takedown"] = victim.var_ab101371;
    player.takedown.victim[#"body_shield"] = victim;
    action = level.player_actions.actions[#"takedown"];
    player namespace_9c83b58d::function_7a061b23(0, "takedown");
    player actions::function_8488e359("melee");
  }

  level notify(#"hash_79050352d0066bd8");
  player val::reset(#"slide_allowjump", "allow_jump");
  player val::reset(#"hash_304cd84bed4b8707", "allow_mantle");
  util::delay(0.7, undefined, &namespace_b100dd86::function_53531f27, "trig_start_rooftop_combat");
  objectives::follow("follow_adler", level.adler, undefined, 0, 0);
}

function function_d6a2486(command, flag) {
  self waittill(command);
  self flag::set(flag);
}

function function_aec55b72() {
  level.var_d6f941c8 = 0;
  level endon(#"hash_79050352d0066bd8");

  while(true) {
    if(level flag::get("flag_listen_for_mantle") && level.var_d6f941c8 == 0) {
      self val::set(#"slide_allowjump", "allow_jump", 0);
      self val::set(#"hash_304cd84bed4b8707", "allow_mantle", 0);
      level thread function_c39dde0e();
    } else if(level flag::get("flag_clear_listen_for_mantle")) {
      level.var_d6f941c8 = 0;
      level notify(#"hash_34688d2980137bca");
    }

    waitframe(1);
  }
}

function function_c39dde0e() {
  player = getplayers()[0];
  level.var_d6f941c8 = 1;
  level endon(#"hash_34688d2980137bca");
  player notifyonplayercommand("tutorial_pressed_jump", "+gostand");

  while(true) {
    player waittill(#"tutorial_pressed_jump");

    if(!player flag::get("body_shield_active")) {
      level flag::set("flag_takedown_tutorial_player_mantling");
    }

    waitframe(1);
  }
}

function function_fb0dffdf() {
  player = getplayers()[0];
  player endon(#"death");
  level scene::init("scene_tkd_hit2_roof_chase_enemy_spawn_01");
  level scene::init("scene_tkd_hit2_roof_chase_enemy_spawn_03");
  level flag::wait_till("flag_enemy_before_rooftop");
  ai_spawned = spawner::simple_spawn_single("dude_before_roof");
  ai_spawned.var_c681e4c1 = 1;
  var_23811abd = snd::play("vox_cp_tdwn_04200_irg2_fuckingamerican_9b", [ai_spawned, "j_head"]);
  slide_guy1 = getspawnerarray("slide_guy1", "script_noteworthy");
  array::run_all(slide_guy1, &spawner::add_spawn_function, &function_4ae05934);
  slide_guy2 = getspawnerarray("slide_guy2", "script_noteworthy");
  array::run_all(slide_guy2, &spawner::add_spawn_function, &function_5d9afea9);
  var_35447b42 = getspawnerarray("rooftop_door_guy1", "targetname");
  array::run_all(var_35447b42, &spawner::add_spawn_function, &function_f57c8f19);
  level flag::wait_till("flag_qasim_on_roof");
  level thread savegame::function_7790f03(0);
  level flag::wait_till("flag_start_rooftop_combat");
  level.adler ai::set_behavior_attribute("demeanor", "combat");
  level.woods ai::set_behavior_attribute("demeanor", "combat");
  var_8c129dc2 = array_spawn_targetname("initial_rooftop_guys");
  level thread function_8ddafa22(var_8c129dc2, "trig_rooftop_combat", undefined);
  level flag::wait_till("flag_rooftop_combat_wave2");
  savegame::checkpoint_save(0);
  var_3d1b4310 = array_spawn_targetname("rootop_ledge_guys");

  foreach(guy in var_3d1b4310) {
    guy.ignoresuppression = 1;
  }

  level thread function_8ddafa22(var_3d1b4310, "trig_rooftop_combat_wave3", "trig_colors_roof1", 1);
  level flag::wait_till("flag_rooftop_combat_wave3");
  savegame::checkpoint_save(0);
  wait 2;
  var_158599d4 = array_spawn_targetname("rootop_wave3_guys");

  foreach(guy in var_158599d4) {
    guy.ignoresuppression = 1;
  }

  level thread function_29f2624a("rooftop_wave3a", "trig_colors_roof3a", undefined, 1);
  level flag::wait_till("flag_colors_roof3a");
  level thread function_29f2624a("rooftop_wave3b", "trig_colors_roof3b", undefined, 1);
  level flag::wait_till("flag_colors_roof3b");
  wait 2;
  var_70b55036 = array_spawn_targetname("rootop_wave4_guys");

  foreach(guy in var_70b55036) {
    guy.ignoresuppression = 1;
  }

  level thread function_8ddafa22(var_70b55036, "trig_colors_roof4");
}

function function_4ae05934() {
  player = getplayers()[0];
  self endon(#"death");
  self endon(#"finished_slide");
  self.health = 999;
  self.var_c681e4c1 = 1;
  self.a.nodeath = 1;
  self.skipdeath = 1;
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  var_ea0ede96 = ["scene_t9_tkd_hit2_roof_chase_enemy01_slide_death_01", "scene_t9_tkd_hit2_roof_chase_enemy01_slide_death_02", "scene_t9_tkd_hit2_roof_chase_enemy01_slide_death_03"];
  level thread scene::play("scene_tkd_hit2_roof_chase_enemy_spawn_01", "Shot 1");
  self thread function_9bfd5b8f("vol_first_roof");
  self waittill(#"damage");
  self notify(#"not_death");
  level.player playhitmarker(undefined, 5, undefined, 1);
  level scene::stop("scene_tkd_hit2_roof_chase_enemy_spawn_01");
  var_92be0c59 = array::random(var_ea0ede96);
  self scene::play(var_92be0c59, "Shot 1");
  self notify(#"play_death");
  self kill();
}

function function_5d9afea9() {
  player = getplayers()[0];
  self endon(#"death");
  self endon(#"finished_slide");
  self.health = 999;
  self.var_c681e4c1 = 1;
  self.a.nodeath = 1;
  self.skipdeath = 1;
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  var_ea0ede96 = ["scene_t9_tkd_hit2_roof_chase_enemy02_slide_death_01", "scene_t9_tkd_hit2_roof_chase_enemy02_slide_death_02", "scene_t9_tkd_hit2_roof_chase_enemy02_slide_death_03"];
  level thread scene::play("scene_tkd_hit2_roof_chase_enemy_spawn_02", "Shot 1");
  self thread function_9bfd5b8f("vol_last_roof");
  self waittill(#"damage");
  self notify(#"not_death");
  level.player playhitmarker(undefined, 5, undefined, 1);
  level scene::stop("scene_tkd_hit2_roof_chase_enemy_spawn_02");
  self scene::play(array::random(var_ea0ede96));
  self notify(#"play_death");
  self kill();
}

function function_9bfd5b8f(goal_vol) {
  self endon(#"death");
  self waittill(#"finished_slide");
  self.var_c681e4c1 = 0;
  self.a.nodeath = 0;
  self.skipdeath = 0;
  self.skipdeathanim = 0;
  self.noragdoll = 0;
  self.health = 10;
  self ai::set_goal(goal_vol, "targetname");
}

function function_f57c8f19() {
  level thread scene::play("scene_tkd_hit2_roof_chase_enemy_spawn_03", "Shot 1");
  self waittill(#"finished_slide");
  self.fixednode = 1;
  self.ai.var_5a4e769f = 1024;
  self ai::set_goal("rooftop_guy1_node", "targetname");
}

function function_90288964() {}

function array_spawn_targetname(targetname) {
  spawners = getspawnerarray(targetname, "targetname");
  ai = spawner::simple_spawn(spawners);
  return ai;
}

function function_a1d9cae0() {
  self thread namespace_b100dd86::function_a0f1fa27();
  level notify(#"hash_530a04ce72c2c9");
  objectives::follow("obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf");
  self val::set(#"qasim", "ignoreall", 1);
  self val::set(#"qasim", "ignoreme", 1);
  self.forcesprint = 1;
  self disableaimassist();
  lmg = getweapon(#"lmg_light_t9");
  self setweapon(lmg);
  self val::reset_all(#"qasim");
  self.script_accuracy = 0.2;
  level flag::wait_till("flag_qasim_flees_last_roof");
  self val::set(#"hash_1a1aed5c6944bf9c", "ignoreall", 1);
  self val::set(#"hash_1a1aed5c6944bf9c", "ignoreme", 1);
  self.forcesprint = 1;
  level thread scene::play("scene_tkd_hit2_qasim_vault", "Vault");
  self waittill(#"end_vault");
  objectives::remove("obj_takedown_qasim");
  self notify(#"hash_637416a1c8f37fe3");
  self deletedelay();
  level thread namespace_b100dd86::function_a3c6d04c();
  level thread namespace_b100dd86::function_c212022b(180);
}

function function_8ddafa22(array, trigger, var_cc856f8d, var_c550e48f) {
  if(isDefined(var_cc856f8d)) {
    var_bb96f34c = getent(var_cc856f8d, "targetname");
  }

  function_1eaaceab(array);

  if(array.size > 0) {
    if(isDefined(var_c550e48f)) {
      level ai::waittill_dead(array, array.size - var_c550e48f);
    } else {
      level ai::waittill_dead(array, array.size);
    }
  }

  namespace_b100dd86::function_53531f27(trigger);

  if(isDefined(var_bb96f34c)) {
    var_bb96f34c delete();
  }
}

function function_29f2624a(aigroup, trigger, var_cc856f8d, var_c550e48f, delay) {
  if(isDefined(var_cc856f8d)) {
    var_bb96f34c = getent(var_cc856f8d, "targetname");
  }

  aienemies = getaiarray(aigroup, "script_aigroup");
  function_1eaaceab(aienemies);

  if(aienemies.size > 0) {
    if(isDefined(var_c550e48f)) {
      level ai::waittill_dead(aienemies, aienemies.size - var_c550e48f);
    } else {
      level ai::waittill_dead(aienemies, aienemies.size);
    }
  }

  if(isDefined(delay)) {
    wait delay;
  }

  namespace_b100dd86::function_53531f27(trigger);

  if(isDefined(var_bb96f34c)) {
    var_bb96f34c delete();
  }
}

function rooftop_vo() {
  level thread function_6d063272();
  level flag::wait_till("flag_qasim_is_fast");
  level.adler dialogue::queue("vox_cp_tdwn_03800_adlr_theresqasim_a2");
  wait 1;
  level.adler dialogue::queue("vox_cp_tdwn_03800_adlr_movequicklyweca_64");
  level flag::wait_till("flag_rooftop_combat_wave3");
  wait 5;
  level flag::wait_till("flag_colors_roof3b");
  wait 7;
  level.adler dialogue::queue("vox_cp_tdwn_03800_adlr_watchitwoodswen_b4");
  level.woods dialogue::queue("vox_cp_tdwn_03800_wood_youworrytoomuch_0d");
}

function function_6d063272() {
  level endon(#"hash_5f84172c70d1eb4c");

  while(true) {
    wait randomintrange(8, 10);
    level.adler dialogue::queue("vox_cp_tdwn_04100_adlr_movemove_9d");
    wait randomintrange(8, 10);
    level.adler dialogue::queue("vox_cp_tdwn_03800_adlr_gogo_f9");
    wait randomintrange(11, 14);
    level.adler dialogue::queue("vox_cp_tdwn_03800_adlr_hurryup_40");
    wait randomintrange(8, 10);
    level.adler dialogue::queue("vox_cp_tdwn_04100_adlr_letsgocomeon_86");
    wait randomintrange(11, 14);
    level.adler dialogue::queue("vox_cp_tdwn_04100_adlr_qasimcantescape_7b");
    wait randomintrange(8, 10);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("raid_apt_complete");
}

function init_clientfields() {}

function function_22b7fffd() {}