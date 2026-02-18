/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d81630134db409c.gsc
***********************************************/

#using script_2cd384a0f7be5baf;
#using script_3dc93ca9902a9cda;
#using script_5431e074c1428743;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_8b6f2185feb33ac;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_73841f48;

function function_599d30fb(str_objective, var_50cc0d4f) {
  objectives::complete("obj_yamantau_1");
  level thread objectives::scripted("obj_yamantau_2", undefined, #"hash_282aa5eed264a248");
  level thread namespace_7468806b::function_ac37051f();
  level thread function_bb3bfb17();
  level thread namespace_8a404420::function_876b3ae7();
  level thread function_34d6e3ab();
  savegame::function_7790f03(1);

  if(!namespace_b73b9191::function_315b14d6()) {
    level flag::set("flg_bunker_crossbow_bolt_interacts_active");
    namespace_b73b9191::function_6f1012dd("bunker");
  }

  level thread function_c5b389f1();
  snd::client_msg("audio_level_triton_verb_disable");
  var_1e11c2d3 = spawner::get_ai_group_ai("zipline_helipad_enemies");
  function_1eaaceab(var_1e11c2d3);

  if(var_50cc0d4f) {
    var_6b6b52d6 = spawner::simple_spawn("sp_catwalk_helipad");
  }

  level flag::wait_till("flg_bunker_explore_flashlight_hint");
  level thread function_10bdb4ab();
  var_27fe3d30 = spawner::get_ai_group_ai("zipline_helipad_enemies");

  if(var_27fe3d30.size > 0) {
    foreach(ai in var_27fe3d30) {
      ai thread util::delayed_delete(0.1);
    }
  }

  level flag::wait_till("flg_bunker_explore_encounter_start");
  level notify(#"hash_2add1d7af9007b93");
  savegame::checkpoint_save(1);
  skipto::function_4e3ab877("bunker_explore");
}

function function_c5b389f1() {
  level flag::wait_till("flg_bunker_explore_entered");
  level namespace_5d7a2dac::music("6.0_tunnel");
}

function function_4c079a93() {
  level flag::wait_till("flg_bunker_explore_stairwell_tease");
  ai = spawner::simple_spawn_single("sp_bunker_explore_elevator", &function_4e376bb9, "flg_bunker_encounter_end");
  ai val::set("stairwell", "ignoreall", 1);
  ai thread namespace_7468806b::function_1bf4e6d0();
}

function function_bb3bfb17() {
  level flag::wait_till("flg_bunker_explore_elevator_creak");
  namespace_b73b9191::function_15426f9d("cull_outside_bunkerint");
  exploder::exploder("elev_dust_fall");
  snd::play("evt_yam_elevator_shift_lr", level.player);
  earthquake(0.3, 1, level.player.origin, 150);
  level.player playrumbleonentity("damage_light");
}

function function_b2e9a7bb(weapon) {
  self endon(#"death");

  while(self getweaponammoclip(weapon) <= 0 && self getweaponammostock(weapon) <= 0) {
    waitframe(1);
  }

  self setlowready(0);
}

function function_c3ccbcc8(str_objective) {
  namespace_b73b9191::function_2683ec5d();
  var_b4bb921 = struct::get("woods_bunker_explore", "targetname");
  level.ai_woods forceteleport(var_b4bb921.origin, var_b4bb921.angles);
}

function function_f46b6ef(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  waitframe(1);
}

function function_eea0086d(str_objective, var_50cc0d4f) {
  if(isalive(level.ai_woods)) {
    level.ai_woods delete();
  }

  level.player namespace_9c83b58d::function_a3b724c6(1);
  var_c41d0234 = [];

  if(!isDefined(var_c41d0234)) {
    var_c41d0234 = [];
  } else if(!isarray(var_c41d0234)) {
    var_c41d0234 = array(var_c41d0234);
  }

  var_c41d0234[var_c41d0234.size] = "flg_bunker_encounter_patrol_cleared";

  if(!isDefined(var_c41d0234)) {
    var_c41d0234 = [];
  } else if(!isarray(var_c41d0234)) {
    var_c41d0234 = array(var_c41d0234);
  }

  var_c41d0234[var_c41d0234.size] = "flg_bunker_encounter_end";
  function_931a2938();

  if(var_50cc0d4f) {
    level thread function_10bdb4ab();
    level namespace_5d7a2dac::music("6.0_tunnel");
    snd::client_msg("audio_level_triton_verb_disable");
  }

  level thread namespace_b73b9191::function_e79ede39("flg_bunker_encounter_end");
  level thread function_228e46b7();
  level thread function_fd54f0f2();
  level thread function_d9018071();
  level thread function_e6316fa2();
  level thread function_db968b0c();

  if(!namespace_b73b9191::function_315b14d6() && !level flag::get("flg_bunker_crossbow_bolt_interacts_active")) {
    namespace_b73b9191::function_6f1012dd("bunker");
  }

  level flag::wait_till("flg_bunker_encounter_flashlight_tip");
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_bunker_explore_encounter_arrive");
  self.stealth.maxalertdelay = 0.4;
  level thread function_34d6e3ab();
  namespace_b73b9191::function_ee83e03a("cull_outside_bunkerint");
  level thread namespace_7468806b::function_4acd5495();
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_woods_regroup_callover_start");
  level notify(#"hash_2add1d7af9007b93");
  self.stealth.maxalertdelay = undefined;
  level flag::set("flg_bunker_encounter_end");

  if(!level flag::get("flg_fail_cp_proficient_yamantau")) {
    level.player stats::function_dad108fa(#"cp_proficient_yamantau", 1);
  }

  level.player namespace_9c83b58d::function_a3b724c6(0);
  namespace_b73b9191::function_29b49cb5();
  skipto::function_4e3ab877("bunker_encounter");
}

function function_e6316fa2() {
  level endon(#"flg_bunker_encounter_patrol_cleared");
  level flag::wait_till("flg_bunker_stealth_fail");
  level namespace_5d7a2dac::music("7.0_combat_3");
}

function function_8232a129() {
  level flag::wait_till("flg_bunker_encounter_patrol_cleared");
  wait 3;
  level thread breadcrumb::function_61037c6c(#"hash_6191b396f75dbc49");
}

function function_228e46b7() {
  var_37a49506 = spawner::simple_spawn("sp_bunker_encounter_scavenger", &function_4e376bb9, "flg_bunker_encounter_end");
  array::thread_all(var_37a49506, &function_bea21c44);

  if(level flag::get("flg_bunker_stealth_fail")) {
    stealth_event::event_broadcast_generic("explode", level.player.origin, 1500, level.player);
  }

  level flag::wait_till("flg_bunker_explore_scavenger_move");

  if(!level flag::get("flg_bunker_stealth_fail")) {
    level thread namespace_7468806b::function_d87fc317(var_37a49506[0], var_37a49506[1]);
  }

  level flag::wait_till("flg_bunker_optional_key_found");

  foreach(ai in var_37a49506) {
    if(isalive(ai)) {
      ai deletedelay();
    }
  }
}

function function_bea21c44() {
  self endon(#"death");

  while(true) {
    self.stealth.threatsightratescale = 5;
    level flag::wait_till("flg_bunker_player_off_path");
    self.stealth.threatsightratescale = 1;
    level flag::wait_till_clear("flg_bunker_player_off_path");
  }
}

function function_10bdb4ab() {
  level endon(#"flg_bunker_encounter_patrol_cleared");
  level callback::on_weapon_fired(&function_683839c7);
  level callback::on_grenade_fired(&function_742d345d);
}

function function_683839c7(s_event) {
  if(s_event.weapon.name != # "hash_165cf52ce418f5a1") {
    level flag::set("flg_bunker_stealth_fail");
    self callback::remove_on_weapon_fired(&function_683839c7);
  }

  level flag::set("flg_fail_cp_proficient_yamantau");
}

function function_742d345d(s_event) {
  level flag::set("flg_bunker_stealth_fail");
  level flag::set("flg_fail_cp_proficient_yamantau");
  self callback::remove_on_grenade_fired(&function_742d345d);
}

function function_9137290b() {
  level endon(#"flg_bunker_stealth_fail");
  self endon(#"death");
  self waittill(#"shoot");
  level flag::set("flg_bunker_stealth_fail");
}

function function_d9018071() {
  level.player clientfield::set_to_player("optional_objective_camera_fx", 0);
  level thread scene::init("scene_bunker_locker_interact");
  level thread function_d38043e4();
  level thread function_fc5823d5();
  level thread function_cb78f179();
  level flag::wait_till("flg_bunker_optional_key_found");
  thread function_9fd55cd1();
}

function function_d38043e4() {
  level endon(#"flg_bunker_optional_objective_completed");
  level flag::wait_till("flg_bunker_optional_obj_hint");

  if(!level flag::get("flg_bunker_optional_key_found")) {
    objectives::scripted(#"hash_7c39160a497ca2e8", undefined, #"hash_2086d9cec982e919");
    objectives::function_572778b9(#"hash_7c39160a497ca2e8");
    level notify(#"hash_7e64e93d8fd00029");

    if(!level flag::get("flg_bunker_optional_safe_found")) {
      level flag::set("flg_bunker_optional_safe_found");
    }
  }
}

function function_fc5823d5() {
  e_player = level.player;
  s_bunker_locker = struct::get("s_bunker_locker", "targetname");
  s_bunker_bonus_weapon = struct::get("s_bunker_bonus_weapon", "targetname");
  s_bunker_locker.var_589053fc = 1;
  s_bunker_locker util::create_cursor_hint(undefined, undefined, #"hash_31b752d0d17c599e", undefined, 0.5, &function_a0186be6, undefined, 1280, undefined, undefined, undefined, 0);
  flag::wait_till("flg_bunker_optional_key_found");
  snd::play("wpn_weap_pickup");
  waitframe(1);
  s_bunker_locker util::remove_cursor_hint();
  waitframe(1);
  s_bunker_locker util::create_cursor_hint(undefined, undefined, #"hash_17c01a9047648148", undefined, 1, undefined, undefined, 1280);
  s_bunker_locker waittill(#"trigger");
  level thread scene::play("scene_bunker_locker_interact");
  snd::play("evt_yam_locker_open", s_bunker_locker);
  level.player playrumbleonentity("reload_rechamber");
  e_player thread namespace_b73b9191::function_d7ce9e77(1);
  s_bunker_locker util::remove_cursor_hint();
  level flag::set("flg_bunker_optional_objective_completed");
  savegame::checkpoint_save(1);
  level thread namespace_7468806b::function_fc9043bb();
  level thread function_7abee9fe();
  objectives::complete(#"hash_40c6b4ca8deece21");
  objectives::complete(#"hash_7b814bc685d7ca4");
  level.player stats::function_dad108fa(#"hash_46955261f659bca1", 1);
  player_decision::function_8c0836dd(3);
  s_bonus_weapon = struct::get("s_bonus_weapon", "targetname");
  var_dc039d87 = getweapon(#"hash_3ed4419427e0d85a", "fastreload2", "heavy2", "compensator", "handle2");
  e_weapon = spawnweapon(var_dc039d87, s_bonus_weapon.origin, s_bonus_weapon.angles, 1);
  e_weapon waittill(#"trigger");
  wait 0.5;
  level.player setweaponammoclip(var_dc039d87, 6);
}

function function_7abee9fe() {
  var_d4027fe0 = spawner::get_ai_group_sentient_count("bunker_flashlight_patrol");

  if(var_d4027fe0 <= 0) {
    e_trigger = getent("bunker_return_dialog", "targetname");
    e_trigger waittill(#"trigger");
    a_ai = spawner::simple_spawn("sp_bow_reinforcements", &function_4e376bb9, "flg_woods_regroup_woods_exiting");
    doors::unlock("bunker_situation_door", "targetname", 1);
    a_ai[0] thread namespace_7468806b::function_20b65fc7();
  }
}

function function_a0186be6(s_info) {
  snd::play("evt_locker_locked", self);

  if(is_true(self.var_589053fc)) {
    level thread namespace_7468806b::function_aa09d92b();
    self.var_589053fc = 0;
  }
}

function function_cb78f179() {
  e_bunker_optional_key = getent("e_bunker_optional_key", "targetname");
  s_bunker_optional_key_interact = struct::get("s_bunker_optional_key_interact", "targetname");
  s_bunker_optional_key_interact util::create_cursor_hint(undefined, undefined, #"hash_44460a497a8e27e4", 60, undefined, undefined, undefined, 80, undefined, 0);
  s_bunker_optional_key_interact waittill(#"trigger");
  level.player playgestureviewmodel(#"ges_drophand");
  snd::play("evt_yam_key_pickup", level.player);
  level.player playrumbleonentity("reload_small");
  e_bunker_optional_key delete();
  level flag::set("flg_bunker_optional_key_found");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_be621aea = 1;

  if(!level flag::get("flg_bunker_optional_safe_found")) {
    objectives::scripted(#"hash_7b814bc685d7ca4", undefined, #"hash_18aacf4c2fd65f83");
    objectives::function_572778b9(#"hash_7b814bc685d7ca4");
    level thread namespace_7468806b::function_c21ee7c3();
    return;
  }

  objectives::complete(#"hash_7c39160a497ca2e8");
  wait 0.5;
  objectives::scripted(#"hash_40c6b4ca8deece21", undefined, #"hash_68d32b65121ad78f");
  objectives::function_572778b9(#"hash_40c6b4ca8deece21");
  level thread namespace_7468806b::function_e9a2030c();
}

function function_9fd55cd1() {
  spawner::add_spawn_function_group("sp_bunker_optional", "script_noteworthy", &function_4e376bb9, "flg_bunker_survey_interacted");
  level flag::wait_till("flg_bunker_optional_encounter_alert");
  var_f01bc0fc = spawner::simple_spawn_single("sp_bunker_optional_window");
  var_f507e604 = spawner::simple_spawn_single("sp_bunker_optional_safe");
  level thread namespace_7468806b::function_9cfeeedb(var_f01bc0fc, var_f507e604);
}

function function_99854e6c() {
  e_bunker_optional_key = getent("<dev string:x38>", "<dev string:x51>");

  if(isDefined(e_bunker_optional_key)) {
    s_bunker_optional_key_interact = struct::get("<dev string:x5f>", "<dev string:x51>");
    s_bunker_optional_key_interact notify(#"trigger");
  }
}

function function_c54b46bc() {
  if(!level flag::get("<dev string:x81>")) {
    function_99854e6c();
    wait 1;
  }

  if(!level flag::get("<dev string:xa2>")) {
    s_bunker_bonus_weapon = struct::get("<dev string:xcd>", "<dev string:x51>");
    s_bunker_bonus_weapon notify(#"trigger");
  }
}

function function_931a2938() {
  level flag::set("flg_bunker_stealth_overrides");
  var_5d14e11e = [];
  var_5d14e11e[# "prone"] = 300;
  var_5d14e11e[# "crouch"] = 600;
  var_5d14e11e[# "stand"] = 1155;
  var_8293536e = [];
  var_8293536e[# "prone"] = 8192;
  var_8293536e[# "crouch"] = 8192;
  var_8293536e[# "stand"] = 8192;
  namespace_979752dc::set_detect_ranges(var_5d14e11e, var_8293536e);
}

function function_fd54f0f2() {
  level endon(#"flg_bunker_encounter_end");
  level flag::wait_till("flg_bunker_encounter_scout_spawn");
  var_48cc222e = spawner::simple_spawn("sp_flashlight_patrol_scout", &function_4e376bb9, "flg_bunker_encounter_end");
  array::thread_all(var_48cc222e, &function_7a370566);

  if(level flag::get("flg_bunker_stealth_fail")) {
    wait 0.2;
    stealth_event::event_broadcast_generic("explode", level.player.origin, 1500, level.player);
  }

  level flag::wait_till("flg_bunker_encounter_flashlight_tip");

  if(!level flag::get("flg_bunker_stealth_fail")) {
    var_48cc222e[0] thread namespace_7468806b::function_ca0f56e7();
  }

  level flag::wait_till("flg_bunker_explore_encounter_arrive");
  level.var_5ceb0850 = spawner::simple_spawn("sp_flashlight_patrol", &function_4e376bb9, "flg_bunker_encounter_end");
  level.var_20529448 = spawner::simple_spawn("sp_flashlight_patrol_key", &function_4e376bb9, "flg_bunker_encounter_end");

  if(level flag::get("flg_bunker_stealth_fail")) {
    var_f97a8179 = spawner::simple_spawn("sp_flashlight_patrol_backup", &function_4e376bb9, "flg_bunker_encounter_end");
    wait 0.2;
    stealth_event::event_broadcast_generic("explode", level.player.origin, 1500, level.player);
  }

  level thread namespace_7468806b::function_2712fa2e();
  spawner::waittill_ai_group_ai_count("bunker_flashlight_patrol", 0);
  level flag::set("flg_bunker_encounter_patrol_cleared");
  level namespace_5d7a2dac::music("8.0_ireadyou", 3);
}

function function_7a370566() {
  self endon(#"death");
  goal = getent("vol_bunker_flashlight_patrol", "targetname");
  self flag::set("stealth_override_goal");

  if(level flag::get("flg_bunker_stealth_fail")) {
    goal = getnode(self.script_noteworthy, "targetname");
  }

  self waittill(#"stealth_combat");
  level flag::wait_till("flg_bunker_explore_encounter_arrive");
  self setgoal(goal, 1);
}

function function_4e376bb9(var_c5db42b9) {
  self endon(#"death");
  self ai::poi_enable(1);
  self thread function_9137290b();
  self namespace_979752dc::function_bf1fb16f();
  self.grenadeammo = 0;
  self thread function_3a9ba510(var_c5db42b9);
  self.stealth.corpse_nexttime = 2147483647;
  self ai::set_behavior_attribute("demeanor", "cqb");
  self.flashlightoverride = 1;
  self clientfield::set("set_flashlight_fx", 1);

  if(!level flag::get("flg_bunker_stealth_fail")) {
    self util::delay(0.2, "death", &flashlight::function_7c2f623b);
  }

  self.var_1c936867 = 600;
  self waittill(#"stealth_combat", #"takedown_begin");
  self ai::poi_enable(0);
}

function function_3a9ba510(var_c5db42b9) {
  self endon(#"death");
  level flag::wait_till(var_c5db42b9);
  self delete();
}

function function_b47dd82e(str_objective) {
  objectives::complete("obj_yamantau_1");
  level thread objectives::scripted("obj_yamantau_2", undefined, #"hash_282aa5eed264a248");
}

function function_511f3559(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(!namespace_b73b9191::function_315b14d6()) {
    level flag::clear("flg_bunker_crossbow_bolt_interacts_active");
    namespace_b73b9191::function_2e5072b5("bunker");
  }

  waitframe(1);
  level thread function_db968b0c(1);
  namespace_b73b9191::function_ee83e03a("cull_outside_bunkerint");
}

function function_4e75b98e(str_objective, var_50cc0d4f) {
  namespace_b73b9191::function_2683ec5d();
  level thread function_34d6e3ab();

  if(var_50cc0d4f) {
    snd::client_msg("audio_level_triton_verb_disable");
  }

  if(!namespace_b73b9191::function_315b14d6() && !level flag::get("flg_bunker_crossbow_bolt_interacts_active")) {
    namespace_b73b9191::function_6f1012dd("bunker");
  }

  var_a874ccde = struct::get("woods_ladder_teleport", "targetname");
  level.ai_woods forceteleport(var_a874ccde.origin, var_a874ccde.angles);
  scene::add_scene_func("scene_yam_6010_grp_enter_react_dead_soldiers", &function_61ce8bd0);
  level thread scene::play("scene_yam_6010_grp_enter_react_dead_soldiers");
  level thread namespace_9e8d4ac3::function_8cf4172f();
  level thread namespace_8a404420::function_94b72d13();
  level thread function_471879c2();
  level thread function_90350d0d();
  level flag::wait_till("flg_woods_regroup_woods_exiting");
  level namespace_5d7a2dac::music("9.0_reunited");
  level thread function_8dc5efb();
  var_b9e9c95f = getnode("woods_office_enter", "targetname");
  level.ai_woods setgoal(var_b9e9c95f);
  level flag::wait_till("flg_bunker_office_approach");
  level.player util::function_749362d7(1, #"hash_320ff7b9723b7e5d");
  level thread namespace_7468806b::function_1363110();
  level thread namespace_8a404420::function_2468cb92();
  level flag::wait_till("flg_bunker_office_woods_anim_start");
  level thread function_89f8f4f8();
  level.ai_woods function_9ae1c50();
  level thread namespace_8a404420::scene_yam_6010_grp_enter_react();
  namespace_b73b9191::function_ee83e03a("cull_inside_finale");
  namespace_b73b9191::function_ee83e03a("cull_inside_excavation");
  namespace_b73b9191::function_15426f9d("cull_inside_bunkerext");
  namespace_b73b9191::function_15426f9d("cull_inside_satcom");
  level flag::wait_till("flg_bunker_office_entered");
  level thread namespace_7468806b::function_8d5b3937();
  level.ai_woods function_9ae1c50();
  savegame::checkpoint_save(1);
  objectives::complete("obj_yamantau_2");
  var_86b56671 = struct::get("office_survey_interact_hint", "targetname");
  level flag::wait_till("flg_start_regroup_dialog");
  level thread objectives::goto("obj_yamantau_3", var_86b56671.origin, #"hash_61477572878e9580");
  level thread namespace_c8bf7287::function_c17f029c();
  level flag::wait_till("flg_bunker_survey_interacted");
  level namespace_5d7a2dac::music("10.0_surveying");
  level thread function_a6b2668();
  level thread namespace_9e8d4ac3::function_f5ae4873();
  objectives::complete("obj_yamantau_3");
  level waittill(#"survey_equipment_completed");
  level notify(#"hash_2add1d7af9007b93");
  namespace_b73b9191::function_29b49cb5();
  skipto::function_4e3ab877("woods_regroup");
}

function function_89f8f4f8() {
  tr_woods_survey_look = getent("tr_woods_survey_look", "targetname");
  tr_woods_survey_look thread trigger::look_trigger(tr_woods_survey_look);
  tr_woods_survey_look waittill(#"trigger_look");
  level flag::set("flg_bunker_office_seen");
}

function function_61ce8bd0(a_ents) {
  foreach(ent in a_ents) {
    ent disableaimassist();
  }
}

function function_bfc063c6() {
  level endon(#"flg_bunker_office_entered");
  level.ai_woods waittill(#"goal");
  level thread scene::play("scene_yam_6010_grp_enter_react", "woods_table_idle", array(level.ai_woods));
}

function function_90350d0d() {
  level thread breadcrumb::function_61037c6c(#"hash_4972f0176f3f0bff");
  thread function_ea0c2bef();
}

function function_ea0c2bef() {
  level flag::wait_till("flg_bunker_office_approach");
  level thread breadcrumb::function_61037c6c(#"hash_3b2d107a1774074b");
}

function function_471879c2() {
  self endon(#"flg_bunker_ladder_reached", #"flg_woods_regroup_look_at_woods");
  s_woods_regroup_lookat = struct::get("s_woods_regroup_lookat", "targetname");

  while(!level.player util::is_looking_at(s_woods_regroup_lookat.origin, 0.995)) {
    waitframe(1);
  }

  if(!level flag::get("flg_bunker_ladder_reached")) {
    level flag::set("flg_woods_regroup_look_at_woods");
  }
}

function function_4d07bf4e(str_objective) {
  level thread objectives::scripted("obj_yamantau_2", undefined, #"hash_282aa5eed264a248");
  level flag::set("flg_bunker_encounter_end");
  doors::unlock("bunker_situation_door", "targetname", 1);
  level.player clientfield::set_to_player("optional_objective_camera_fx", 0);
  level thread scene::init("scene_bunker_locker_interact");
  level thread function_d38043e4();
  level thread function_fc5823d5();
  level thread function_cb78f179();
}

function function_53b51eb0(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  waitframe(1);
  namespace_b73b9191::function_ee83e03a("cull_inside_finale");
  namespace_b73b9191::function_ee83e03a("cull_inside_excavation");
  namespace_b73b9191::function_15426f9d("cull_inside_bunkerext");
  namespace_b73b9191::function_15426f9d("cull_inside_satcom");
}

function function_4a6ba207() {
  level endon(#"survey_equipment_completed", #"survey_equipment_crane_line_said");
  s_poi_crane = struct::get("s_poi_crane", "targetname");
  s_poi_bunker = struct::get("s_poi_bunker", "targetname");
  s_poi_loading = struct::get("s_poi_loading", "targetname");
  wait 2;
  level thread namespace_7468806b::function_297633ed();
  objectives::scripted(#"hash_56fd03bb3b4f0273", undefined, #"hash_533823608d027914", 1);
  level thread function_ab20f837(s_poi_crane.origin);

  while(true) {
    if(!is_true(level.var_fe1d813f) && !level flag::get("survey_equipment_crane_line_said") && level.player util::is_player_looking_at(s_poi_crane.origin, 0.99, 0)) {
      level.var_fe1d813f = 1;
      level thread namespace_7468806b::function_8cc6c411();
      var_d69de23d = gettime() - level.player.var_eb71bc34;
      level notify(#"hash_6b2091e6c001e49a", {
        #var_d69de23d: var_d69de23d
      });
      objectives::complete(#"hash_56fd03bb3b4f0273");
      objectives::complete(#"hash_177f2110897e65c0");
      level flag::set("survey_equipment_crane_line_said");
      wait 2.5;
      level.var_fe1d813f = 0;
    } else if(!is_true(level.var_fe1d813f) && !level flag::get("survey_equipment_bunker_located") && level.player util::is_player_looking_at(s_poi_bunker.origin, 0.99, 0)) {
      level.var_fe1d813f = 1;
      wait 2;
      level flag::set("survey_equipment_bunker_located");
      wait 2.5;
      level.var_fe1d813f = 0;
    } else if(!is_true(level.var_fe1d813f) && !level flag::get("survey_equipment_loading_dock_located") && level.player util::is_player_looking_at(s_poi_loading.origin, 0.99, 0) && level.player.var_df3bdc3 > 4) {
      level.var_fe1d813f = 1;
      wait 2;
      level flag::set("survey_equipment_loading_dock_located");
      wait 2.5;
      level.var_fe1d813f = 0;
    }

    waitframe(1);
  }
}

function function_ab20f837(var_d79d7bf4) {
  s_notify = level waittilltimeout(7, #"hash_6b2091e6c001e49a");

  if(s_notify._notify == # "timeout") {
    objectives::goto(#"hash_177f2110897e65c0", var_d79d7bf4, undefined, 1);
    objectives::function_67f87f80(#"hash_177f2110897e65c0", undefined, #"hash_a1f9f57e59cae69");
  }
}

function function_8dc5efb() {
  var_107d17b4 = getent("e_bunker_survey_door_closed_clip", "targetname");
  var_107d17b4 movez(-1024, 0.1);
}

function function_a6b2668() {
  var_fe3b4945 = getent("e_bunker_survey_door_l_clip", "targetname");
  var_8814d16d = getent("e_bunker_survey_door_r_clip", "targetname");
  var_107d17b4 = getent("e_bunker_survey_door_closed_clip", "targetname");
  var_fe3b4945 movez(-1024, 0.1);
  var_8814d16d movez(-1024, 0.1);
  var_107d17b4 movez(1024, 0.1);
}

function function_38479ea0() {
  var_fe3b4945 = getent("e_bunker_survey_door_l_clip", "targetname");
  var_8814d16d = getent("e_bunker_survey_door_r_clip", "targetname");
  var_fe3b4945 movez(-1024, 0.1);
  var_8814d16d movez(-1024, 0.1);
}

function function_34d6e3ab() {
  self endon(#"hash_2add1d7af9007b93");

  while(true) {
    f1 = level flag::get("flg_bunker_office_light_issue_area");
    f2 = level flag::get("flg_woods_regroup_light_issue_area");
    var_9ba7566d = level flag::get("flg_bunker_elevator_light_issue_area");
    var_5247fd9d = getDvar(#"hash_19b5d46719678445");

    if(f1 || f2 || var_9ba7566d) {
      if(!var_5247fd9d) {
        level.player clientfield::set_to_player("set_sun_color_black", 1);
      }
    } else if(var_5247fd9d) {
      level.player clientfield::set_to_player("set_sun_color_black", 0);
    }

    waitframe(1);
  }
}

function function_db968b0c(var_50cc0d4f = 0) {
  if(var_50cc0d4f) {
    wait 1;
  }

  level waittill(#"game_start");
  level.player callback::on_weapon_change(&function_deb7a15b);
  level waittill(#"hash_2fe46a0db2c6edd1");
  level.player callback::remove_on_weapon_change(&function_deb7a15b);
}

function function_deb7a15b(var_6e96c1c2) {
  level.player endon(#"death");
  level endon(#"hash_2fe46a0db2c6edd1");
  level notify(#"hash_2acb72769c464cfa");

  if(isDefined(var_6e96c1c2.weapon.name)) {
    if(var_6e96c1c2.weapon.name == # "hash_165cf52ce418f5a1") {
      level.player thread function_aafaafcd(var_6e96c1c2);
    }
  }
}

function function_aafaafcd(var_6e96c1c2) {
  level.player endon(#"death");
  level endon(#"hash_2acb72769c464cfa");
  level endon(#"hash_2fe46a0db2c6edd1");
  wait 0.3;
  level.player playrumbleonentity("reload_clipout");
}