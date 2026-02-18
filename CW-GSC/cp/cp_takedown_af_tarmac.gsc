/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_tarmac.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace tkdn_af_tarmac;

function starting(var_d3440450) {
  namespace_b100dd86::function_5aabc3fb();
  tkdn_af_hill::function_a2015343(var_d3440450);
  plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(plane, 0);
  exploder::stop_exploder("airfield_assault_lighting_noplane");
  exploder::exploder("airfield_assault_lighting");
  arash = ai::array_spawn("arash")[0];
  level thread scene::skipto_end("scene_tkd_hit3_intro_overlook_arash", "overlook_shot", [arash]);
  arash thread util::delay(0.1, undefined, &delete);
  namespace_b100dd86::function_c8381339(plane, 1);
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  level scene::init("scene_tkd_hit3_intro_overlook", "initial_loop");
  level thread util::delay(0.2, undefined, &scene::stop, "scene_tkd_hit3_intro_overlook");
  setsaveddvar(#"hash_7bf40e4b6a830d11", 0);
  thread namespace_a052577e::function_4074e9b1();
  guys = ai::array_spawn("af_unloader_guy");
  array::thread_all(guys, &namespace_979752dc::function_2324f175, 0);
  level flag::set("af_hill_complete");
  level flag::set("af_tarmac_complete");
  level thread scene::play_from_time("scene_tkd_hit3_intro", "shot 1", undefined, 1, 1, 1, 0, 0);
  util::delay(0.2, undefined, &tkdn_af_hill::function_9967d19b, arash);
}

function main(var_d3440450, var_50cc0d4f) {
  level util::delay(0.1, undefined, &namespace_979752dc::disable_stealth_system);
  level.player = getplayers()[0];
  level.player endon(#"death");
  snd::client_msg(#"hash_1e58e46360c0a83b");
  vehs = getvehiclearray("af_chase_veh", "targetname");
  vehs[0] setmovingplatformenabled(1, 0);
  guys = getaiarray("af_intro_enemies", "script_noteworthy");

  foreach(guy in guys) {
    guy notify(#"stop_going_to_node");
    guy function_a3fcf9e0("attack", level.player, level.player.origin);
    guy ai::set_goal("tarmac_combat_vol", "targetname", 1);
  }

  vehs = getvehiclearray("af_chase_veh", "targetname");
  level.chase_truck = vehs[0];
  level.chase_truck val::set(#"chase", "allowdeath", 0);
  trigger::use("approach_airstrip", "targetname", undefined, 0);
  level.adler val::reset(#"overlook", "ignoreme");
  level.adler val::reset(#"radiant", "ignoreall");
  level.adler val::reset(#"airfield", "ignoreall");
  level.woods val::reset(#"overlook", "ignoreme");
  level.woods val::reset(#"radiant", "ignoreall");
  level.woods val::reset(#"airfield", "ignoreall");
  level.adler.ignoreall = 0;
  level.adler ai::set_behavior_attribute("demeanor", "combat");
  level.woods ai::set_behavior_attribute("demeanor", "combat");
  thread function_b3df3ebf();
  thread function_565588e1();
  level flag::wait_till("woods_to_truck");
  level.woods thread util::function_27f5f662(["vox_cp_tdwn_07200_wood_getarash_50", "vox_cp_tdwn_07200_wood_quickbeforethep_01", "vox_cp_tdwn_07200_wood_hurry_3b"], "woods_to_truck", 2);
  level flag::wait_till("af_tarmac_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("af_tarmac_complete");
}

function init_clientfields() {
  clientfield::register("world", "prop_wash", 1, 1, "int");
}

function function_22b7fffd() {}

function function_b3df3ebf() {
  level.player endon(#"death");
  level flag::wait_till_timeout(5, "woods_to_truck");
  snd::client_msg("start_plane_rev");
  trigger::use("woods_to_truck_trig", "targetname", undefined, 0);
  thread function_3d64bc8b();
  thread namespace_b100dd86::function_19919872();
  wait 1;
  start_pos = struct::get("plane_chase_start_pos", "targetname");
  level.af_plane clientfield::set("clf_cargoplane_door_sparks", 1);

  if(!level flag::get("af_tarmac_complete")) {
    level.plane_mover moveto(start_pos.origin, 20, 20, 0);
    level.plane_mover rotateto(start_pos.angles, 20, 20, 0);
  }

  level clientfield::set("prop_wash", 1);
  level flag::wait_till_all_timeout(10, "af_tarmac_complete");
  trigger::use("start_plane_takeoff", "targetname", undefined, 0);
}

function function_3d64bc8b() {
  level.af_plane scene::play("scene_tkd_hit3_chase_plane", "start_driving");
  level.af_plane thread scene::play("scene_tkd_hit3_chase_plane", "idle_drive");
}

function function_565588e1() {
  level endon(#"af_player_get_in_back");
  level endon(#"af_player_get_in_left");
  level endon(#"af_player_get_in_right");
  level flag::wait_till("woods_to_truck");
  level.woods thread util::delay(3, undefined, &util::function_27f5f662, ["vox_cp_tdwn_07200_adlr_wehavetocatchth_c8", "vox_cp_tdwn_07200_wood_gettothattruck_5e"], "forever", 4);

  while(!isDefined(level.chase_truck)) {
    waitframe(1);
  }

  level.chase_truck scene::play("scene_tkd_hit3_pre_chase", "enter", [level.woods]);
  level.woods stopanimscripted();
  level.woods ai::force_goal(level.woods.origin, 0, "never");
  level flag::set("woods_waiting_at_truck");
  level.woods val::set(#"chase", "ignoreall", 1);
  level.woods.script_fixednode = 1;

  if(level flag::get("woods_get_in_truck")) {
    level endon(#"hash_6d8d592b136c4266");
  } else {
    level endon(#"woods_get_in_truck");
  }

  while(true) {
    var_ca06ae66 = "nag" + string(randomint(2) + 1);
    level.chase_truck scene::play("scene_tkd_hit3_pre_chase", var_ca06ae66, level.woods);
    level.chase_truck scene::play("scene_tkd_hit3_pre_chase", "loop", level.woods);
    wait 2;
  }
}