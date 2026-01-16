/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_sgen_testing_lab_igc.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_hacking;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_sgen;
#using scripts\cp\cp_mi_sing_sgen_sound;
#using scripts\cp\cp_mi_sing_sgen_util;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_sing_sgen_testing_lab_igc;

function skipto_testing_lab_igc_init(str_objective, b_starting) {
  level flag::init("lab_door_ready");
  level util::set_streamer_hint(2);
  level thread function_652f4022();
  level thread scene::play("cin_sgen_14_01_humanlab_vign_deadbodies");
  level clientfield::set("testing_lab_wires", 1);
  level clientfield::set("w_underwater_state", 0);
  if(b_starting) {
    sgen::init_hendricks(str_objective);
    objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
    objectives::complete("cp_level_sgen_investigate_sgen");
    objectives::complete("cp_level_sgen_locate_emf");
    objectives::complete("cp_level_sgen_descend_into_core");
    objectives::set("cp_level_sgen_goto_signal_source");
    level thread objectives::breadcrumb("fallen_soldiers_end_breadcrumb_trig");
    level scene::init("cin_sgen_14_humanlab_3rd_sh005");
    level scene::init("cin_sgen_14_humanlab_3rd_doors");
    load::function_a2995f22();
  }
  level thread function_e763362b();
  function_d9cab9d3();
  level waittill("hash_89d9c0f");
  level thread namespace_d40478f6::function_4a262c0b();
  if(isdefined(level.bzm_sgendialogue6callback)) {
    level thread[[level.bzm_sgendialogue6callback]]();
  }
  level.var_280d5f68 = getent("human_lab_door_l", "targetname");
  level.var_280d5f68.v_start_pos = level.var_280d5f68.origin;
  level.var_3c301126 = getent("human_lab_door_r", "targetname");
  level.var_3c301126.v_start_pos = level.var_3c301126.origin;
  level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh005", & humanlab_3rd_sh005, "play");
  level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh200", & dni_lab_igc_complete, "done");
  level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh200", & function_5841c784, "players_done");
  level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh040", & function_7a6f4571, "play");
  level thread scene::play("cin_sgen_14_humanlab_3rd_doors");
  level scene::play("cin_sgen_14_humanlab_3rd_sh005", level.var_2240f121);
  level.var_2240f121 = undefined;
}

function skipto_testing_lab_igc_done(str_objective, b_starting, b_direct, player) {
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_doors");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh005");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh010");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh020");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh020");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh020_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh030");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh040");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh050");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh060");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh070");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh080");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh090");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh100");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh110");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh120");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh120_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh130");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh130_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh140");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh150");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh150_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh160");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh160_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh170");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh170_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh180");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh180_female");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh190");
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh200");
}

function function_652f4022() {
  videoprime("cp_sgen_env_dniroom");
  level waittill("hash_92687102");
  videostart("cp_sgen_env_dniroom", 1);
  level flag::wait_till("dark_battle_hendricks_above");
  videostop("cp_sgen_env_dniroom");
}

function humanlab_3rd_sh005(a_ents) {
  foreach(e_in_scene in a_ents) {
    if(isplayer(e_in_scene)) {
      e_in_scene cybercom::cybercom_armpulse(1);
      e_in_scene clientfield::set_to_player("sndCCHacking", 2);
      e_in_scene util::delay(1, "death", & clientfield::increment_to_player, "hack_dni_fx");
      e_in_scene util::delay(2, "death", & clientfield::set_to_player, "sndCCHacking", 0);
    }
  }
}

function function_7a6f4571(a_ents) {
  level waittill("hash_92687102");
  level.ai_hendricks cybercom::cybercom_armpulse(1);
}

function dni_lab_igc_complete(a_ents) {
  nd_post_dni = getnode("hendricks_post_dni_lab", "targetname");
  level.ai_hendricks setgoal(nd_post_dni, 1, 16);
  util::clear_streamer_hint();
  objectives::set("cp_level_sgen_goto_server_room");
  skipto::objective_completed("testing_lab_igc");
  util::teleport_players_igc("dark_battle");
  level.var_280d5f68.origin = level.var_280d5f68.v_start_pos;
  level.var_3c301126.origin = level.var_3c301126.v_start_pos;
}

function function_5841c784(a_ents) {
  util::teleport_players_igc("dark_battle");
}

function function_d9cab9d3() {
  t_hack = getent("trig_testing_lab_door", "targetname");
  t_hack triggerenable(0);
  level.ai_hendricks setgoal(getnode("fallen_soldiers_hendricks_hack_door_node", "targetname"), 1);
  level flag::wait_till("lab_door_ready");
  objectives::complete("cp_waypoint_breadcrumb");
  t_hack triggerenable(1);
  objectives::set("cp_level_sgen_hack_door_signal_source");
  util::init_interactive_gameobject(t_hack, & "cp_prompt_dni_sgen_hack_door", & "CP_MI_SING_SGEN_HACK", & function_474ab5c2);
}

function function_474ab5c2(e_player) {
  level.var_2240f121 = e_player;
  self gameobjects::disable_object();
  level.ai_hendricks clearforcedgoal();
  level notify("hash_89d9c0f");
  objectives::complete("cp_level_sgen_goto_signal_source");
  objectives::complete("cp_level_sgen_hack_door_signal_source");
  self gameobjects::destroy_object(1);
}

function function_e763362b() {
  trigger::wait_or_timeout(5, "testing_lab_vo_looktrig", "targetname");
  level.ai_hendricks dialog::say("hend_hack_the_panel_i_go_0");
  level flag::set("lab_door_ready");
  do_nag();
}

function do_nag() {
  level endon("hash_89d9c0f");
  wait(5);
  level.ai_hendricks dialog::say("hend_wanna_hurry_up_we_n_0");
}