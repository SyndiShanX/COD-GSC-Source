/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_sgen_pallas.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_oed;
#using scripts\cp\_skipto;
#using scripts\cp\_spawn_manager;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_sgen;
#using scripts\cp\cp_mi_sing_sgen_dark_battle;
#using scripts\cp\cp_mi_sing_sgen_revenge_igc;
#using scripts\cp\cp_mi_sing_sgen_sound;
#using scripts\cp\cp_mi_sing_sgen_util;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_globallogic_ui;
#using scripts\cp\gametypes\_save;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#namespace cp_mi_sing_sgen_pallas;

function skipto_descent_init(str_objective, b_starting) {
  if(b_starting) {
    objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
    objectives::complete("cp_level_sgen_investigate_sgen");
    objectives::complete("cp_level_sgen_locate_emf");
    objectives::complete("cp_level_sgen_descend_into_core");
    objectives::complete("cp_level_sgen_goto_signal_source");
    objectives::complete("cp_level_sgen_goto_server_room");
    elevator_setup();
    level flag::set("weapons_research_vo_done");
    load::function_a2995f22();
  }
  level thread handle_pallas_animation();
  level thread elevator_lift_intro();
  level descent_vo();
  objectives::set("cp_level_sgen_confront_pallas", level.ai_pallas);
}

function skipto_descent_done(str_objective, b_starting, b_direct, player) {
  struct::delete_script_bundle("cin_sgen_14_humanlab_3rd_sh005");
}

function skipto_pallas_start_init(str_objective, b_starting) {
  objectives::complete("cp_level_sgen_goto_server_room");
  spawner::add_spawn_function_group("pallas_bot", "script_noteworthy", & robot_mindcontrol);
  spawner::add_spawn_function_group("pallas_core_guard", "script_noteworthy", & robot_mindcontrol_core_guard);
  spawner::add_spawn_function_group("pallas_center_guard", "script_noteworthy", & robot_mindcontrol_center_guard);
  level flag::set("pallas_start");
  level.var_e16e585d = 0;
  level.n_core_guard_count = 0;
  level.var_9945a95d = 0;
  level.var_844375bd = struct::get_array("pallas_robot_dropdown");
  level thread init_fxanim_hoses();
  if(b_starting) {
    objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
    objectives::complete("cp_level_sgen_investigate_sgen");
    objectives::complete("cp_level_sgen_locate_emf");
    objectives::complete("cp_level_sgen_descend_into_core");
    objectives::complete("cp_level_sgen_goto_signal_source");
    objectives::complete("cp_level_sgen_goto_server_room");
    objectives::set("cp_level_sgen_confront_pallas");
    elevator_setup();
    elevator_set_door_state("back", "open");
    e_lift = getent("boss_fight_lift", "targetname");
    e_lift movez(-1750, 0.1);
    load::function_a2995f22();
    level thread handle_pallas_animation();
    array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 2);
  }
  level thread function_8470b8c(b_starting);
  level thread pallas_greeting_event(b_starting);
  foreach(e_player in level.players) {
    e_player util::player_frost_breath(1);
  }
  level.ai_hendricks = util::get_hero("hendricks");
  level.ai_hendricks colors::set_force_color("r");
  level thread function_ab0e4cbe();
  level thread do_hendricks_hacking();
  level thread sgen_util::delete_corpse();
  level thread handle_pallas_pillar_weakspot();
  level thread cleanup_area_arrays();
  level flag::wait_till("core_two_destroyed");
  level thread do_attack_on_hendricks();
  level flag::wait_till("pallas_death");
  level notify("deleting_corpse");
  a_pallas_bot = getaiteamarray("team3");
  foreach(bot in a_pallas_bot) {
    bot delete();
  }
}

function skipto_pallas_start_done(str_objective, b_starting, b_direct, player) {}

function skipto_pallas_end_init(str_objective, b_starting) {
  e_lift = getent("boss_fight_lift", "targetname");
  level thread hide_cracked_glass();
  if(b_starting) {
    sgen::init_hendricks(str_objective);
    e_pallas_spawner = getent("pallas", "targetname");
    e_pallas_spawner spawner::add_spawn_function( & pallas_init);
    spawner::simple_spawn(e_pallas_spawner);
    objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
    objectives::complete("cp_level_sgen_investigate_sgen");
    objectives::complete("cp_level_sgen_locate_emf");
    objectives::complete("cp_level_sgen_descend_into_core");
    objectives::complete("cp_level_sgen_goto_signal_source");
    objectives::complete("cp_level_sgen_goto_server_room");
    objectives::complete("cp_level_sgen_confront_pallas");
    elevator_setup();
    elevator_set_door_state("back", "open");
    e_lift movez(-1750, 0.05);
    level thread scene::init("cin_sgen_19_ghost_3rd_sh010");
    load::function_a2995f22();
  } else {
    level.var_cd52fefe = gettime();
    util::screen_fade_out(0.25, "black", "ghost_fade");
    level util::player_lock_control();
  }
  array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 3);
  if(isDefined(level.bzm_forceaicleanup)) {
    [[level.bzm_forceaicleanup]]();
  }
  level thread all_hoses_break();
  level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh010", & function_48b24f3d, "play");
  level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh040", & function_ac1384da, "play");
  level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh110", & ghost_3rd_sh110, "play");
  level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh050", & function_7d1791ba, "done");
  level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh190", & pallas_end_igc_complete, "done");
  level thread scene::play("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle");
  level thread delete_geo_tower();
  level clientfield::set("set_exposure_bank", 1);
  level scene::play("cin_sgen_19_ghost_3rd_sh010");
  if(isDefined(level.bzm_sgendialogue8callback)) {
    level thread[[level.bzm_sgendialogue8callback]]();
  }
}

function function_509b3c70(a_ents) {
  level waittill("hash_74753696");
  level util::screen_fade_out(0.45, "black", "twin_cover");
}

function function_6610aebe(a_ents) {
  a_ents["pallas_ai_tower"] ghost();
}

function function_c5372adb(a_ents) {
  a_ents["pallas_ai_tower"] show();
}

function function_48b24f3d(a_ents) {
  if(isDefined(level.ai_pallas)) {
    level.ai_pallas ghost();
  }
  if(isDefined(level.var_cd52fefe) && (gettime() - level.var_cd52fefe) < 500) {
    util::wait_network_frame();
  }
  util::screen_fade_in(0, "black", "ghost_fade");
}

function function_ac1384da(a_ents) {
  if(isDefined(level.ai_pallas)) {
    level.ai_pallas show();
  }
}

function function_7d1791ba(a_ents) {
  level.ai_pallas setgoal(level.ai_pallas.origin, 1);
  level.ai_pallas.goalradius = 8;
}

function ghost_3rd_sh110(a_ents) {
  foreach(e_in_scene in a_ents) {
    if(e_in_scene == level.ai_hendricks) {
      e_in_scene cybercom::cybercom_armpulse(1);
    }
  }
}

function delete_geo_tower() {
  wait(0.05);
  a_e_core = getEntArray("pallas_core_destruct", "targetname");
  array::run_all(a_e_core, & delete);
  a_e_rail = getEntArray("pallas_rail_destruct", "targetname");
  array::run_all(a_e_rail, & delete);
}

function skipto_pallas_end_done(str_objective, b_starting, b_direct, player) {
  objectives::complete("cp_level_sgen_confront_pallas");
  if(!b_starting) {
    foreach(e_player in level.players) {
      e_player util::player_frost_breath(0);
    }
  }
}

function pallas_end_igc_complete(a_ents) {
  util::clear_streamer_hint();
  skipto::objective_completed("pallas_end");
}

function descent_vo() {
  level waittill("elevator_vo");
  if(isDefined(level.bzm_sgendialogue7callback)) {
    level thread[[level.bzm_sgendialogue7callback]]();
  }
  level dialog::remote("diaz_listen_do_you_hea_0");
  level dialog::remote("diaz_there_is_blood_on_ou_0", 0.5);
  level dialog::remote("diaz_you_know_who_i_am_i_0", 1);
  level dialog::player_say("plyr_kane_i_ve_got_diaz_0", 0.3);
  level dialog::remote("diaz_taylor_is_right_0", 0.5);
  level dialog::remote("kane_oh_my_god_he_s_wi_0", 0.4);
  level dialog::remote("kane_he_s_directly_contro_0");
  level dialog::remote("kane_listen_to_me_we_0", 1);
  level dialog::remote("kane_right_now_he_s_uploa_0", 1);
}

function link_elevator_light_probe() {
  a_probes = getEntArray("pallas_elevator_probe", "targetname");
  a_lights = getEntArray("pallas_elevator_light", "script_noteworthy");
  e_lift = getent("boss_fight_lift", "targetname");
  array::run_all(a_lights, & linkto, e_lift);
  array::run_all(a_probes, & linkto, e_lift);
}

function handle_pallas_animation() {
  scene::add_scene_func("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_loop", & scene_callback_pallas_loop, "play");
  e_pallas_spawner = getent("pallas", "targetname");
  e_pallas_spawner2 = getent("pallas2", "targetname");
  e_pallas_spawner spawner::add_spawn_function( & pallas_init);
  e_pallas_spawner2 spawner::add_spawn_function( & pallas_init, 1);
  level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_loop");
  videostart("cp_sgen_env_diazserver", 1);
  level waittill("pallas_attacked");
  videostop("cp_sgen_env_diazserver");
  videostart("cp_sgen_env_diazserver", 1);
  level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_stage2");
  level waittill("pallas_attacked");
  videostop("cp_sgen_env_diazserver");
  videostart("cp_sgen_env_diazserver", 1);
  level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_stage3");
  level waittill("pallas_death");
  videostop("cp_sgen_env_diazserver");
}

function scene_callback_pallas_loop(a_ents) {
  level.ai_pallas = a_ents["pallas_model"];
}

function pallas_init(b_doppelganger = 0) {
  self ai::set_ignoreme(1);
  self ai::set_ignoreall(1);
  self disableaimassist();
  self.allowdeath = 0;
  self.nocybercom = 1;
  if(b_doppelganger) {
    self setforcenocull();
    level.var_e934a4b7 = self;
  } else {
    level.ai_pallas = self;
  }
}

function do_hendricks_hacking() {
  level cp_mi_sing_sgen_dark_battle::function_a8cfe9ae();
  level.ai_hendricks.ignoreme = 1;
  st_align = struct::get("hendrick_console_hack", "targetname");
  level thread scene::play("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active", level.ai_hendricks);
  level waittill("pallas_start_terminate");
  st_align thread scene::stop("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active");
}

function main() {}

function function_8470b8c(b_starting) {
  level.pallas_center_guards = [];
  level.pallas_tier_two_guards = [];
  level.pallas_bottom_tier_guards = [];
  var_91f66e00 = getEntArray("pallas_intro_spawner", "targetname");
  foreach(sp_robot in var_91f66e00) {
    ai_robot = spawner::simple_spawn_single(sp_robot);
    if(isDefined(ai_robot)) {
      if(b_starting) {
        if(isDefined(ai_robot.target)) {
          nd_goal = getnode(ai_robot.target, "targetname");
          ai_robot forceteleport(nd_goal.origin, nd_goal.angles);
        }
      }
      ai_robot thread track_intro_death();
      util::wait_network_frame();
    }
  }
}

function cleanup_area_arrays() {
  level endon("pallas_death");
  while(!level flag::get("pallas_death")) {
    level.pallas_center_guards = array::remove_dead(level.pallas_center_guards);
    level.pallas_tier_two_guards = array::remove_dead(level.pallas_tier_two_guards);
    level.pallas_bottom_tier_guards = array::remove_dead(level.pallas_bottom_tier_guards);
    wait(5);
  }
  level.pallas_center_guards = undefined;
  level.pallas_tier_two_guards = undefined;
  level.pallas_bottom_tier_guards = undefined;
}

function function_a7dc2319() {
  self endon("death");
  self ai::set_ignoreall(1);
  level flag::wait_till("pallas_ambush_over");
  self ai::set_ignoreall(0);
}

function robot_mindcontrol() {
  self endon("death");
  self.accuracy = 0.25;
  self ai::set_behavior_attribute("rogue_control_speed", "sprint");
  switch (level.var_e16e585d) {
    case 0: {
      self ai::set_behavior_attribute("rogue_control", "forced_level_1");
      break;
    }
    case 1: {
      self ai::set_behavior_attribute("rogue_control", "forced_level_2");
      break;
    }
    case 2: {
      self ai::set_behavior_attribute("rogue_control", "forced_level_2");
      self.script_string = "potential_hendricks_bot";
      self thread function_39072821();
      break;
    }
    case 3: {
      self thread function_39072821();
      break;
    }
  }
  if(!level flag::get("pallas_ambush_over")) {
    self thread function_a7dc2319();
  } else {
    self function_969fe47();
  }
  level flag::wait_till("pallas_ambush_over");
  v_goal_volume = getent("pallas_tier_two_volume", "targetname");
  self setgoal(v_goal_volume);
}

function robot_mindcontrol_center_guard() {
  self endon("death");
  self.accuracy = 0.25;
  self ai::set_behavior_attribute("rogue_control", "forced_level_1");
  self ai::set_behavior_attribute("can_become_rusher", 0);
  if(!level flag::get("pallas_ambush_over")) {
    self thread function_a7dc2319();
  } else {
    self function_969fe47();
  }
  level flag::wait_till("pallas_ambush_over");
  if(level.pallas_center_guards.size < 3) {
    level.pallas_center_guards[level.pallas_center_guards.size] = self;
    v_goal_volume = getent("pallas_center_volume", "targetname");
  } else {
    if(level.pallas_tier_two_guards.size < 6) {
      level.pallas_tier_two_guards[level.pallas_tier_two_guards.size] = self;
      v_goal_volume = getent("pallas_tier_two_volume", "targetname");
    } else {
      level.pallas_bottom_tier_guards[level.pallas_bottom_tier_guards.size] = self;
      v_goal_volume = getent("pallas_bottom_tier", "targetname");
    }
  }
  self setgoal(v_goal_volume, 1);
  self thread function_39072821();
}

function robot_mindcontrol_core_guard() {
  self endon("death");
  self.accuracy = 0.25;
  self ai::set_behavior_attribute("rogue_control", "forced_level_1");
  self ai::set_behavior_attribute("force_cover", 1);
  self ai::set_behavior_attribute("can_become_rusher", 0);
  self function_969fe47();
  level.n_core_guard_count++;
  nd_guard = getnode("core_guard" + level.n_core_guard_count, "script_noteworthy");
  v_goal_volume = getent("pallas_center_volume", "targetname");
  if(!isDefined(nd_guard) || isnodeoccupied(nd_guard)) {
    self setgoal(v_goal_volume, 1, 16, 16);
  } else {
    self setgoal(nd_guard, 1, 16, 16);
  }
  self thread function_39072821();
}

function function_969fe47() {
  self flag::init("in_playable_space");
  var_85919dec = array::random(level.var_844375bd);
  var_85919dec scene::play("cin_sgen_18_01_pallasfight_aie_jumpdown_robot01", self);
  self flag::set("in_playable_space");
}

function function_39072821() {
  self endon("death");
  level flag::wait_till("tower_three_destroyed");
  self ai::set_behavior_attribute("rogue_control", "forced_level_3");
  if(gettime() < level.var_94d58561) {
    self ai::set_behavior_attribute("rogue_control_speed", "run");
  } else {
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
  }
}

function elevator_setup() {
  e_lift = getent("boss_fight_lift", "targetname");
  e_lift setmovingplatformenabled(1);
  e_lift.a_e_doors = [];
  e_lift.a_e_doors["front"] = getent("pallas_lift_front", "targetname");
  e_lift.a_e_doors["front"].str_state = "close";
  e_lift.a_e_doors["back"] = getent("pallas_lift_back", "targetname");
  e_lift.a_e_doors["back"].str_state = "close";
  array::run_all(e_lift.a_e_doors, & linkto, e_lift);
  e_lift.a_e_doors["front"] clientfield::set("sm_elevator_door_state", 1);
  e_lift.a_e_doors["back"] clientfield::set("sm_elevator_door_state", 2);
}

function elevator_set_door_state(str_side, str_state) {
  e_lift = getent("boss_fight_lift", "targetname");
  if(!e_lift.a_e_doors[str_side].str_state === str_state) {
    e_lift.a_e_doors[str_side].str_state = str_state;
    e_lift.a_e_doors[str_side] unlink();
    n_zvalue = 150;
    if(str_state === "open") {
      n_zvalue = n_zvalue * -1;
    }
    e_lift.a_e_doors[str_side] movez(n_zvalue, 3.947368, 3.947368 * 0.1, 3.947368 * 0.25);
    if(str_state == "open") {
      e_lift.a_e_doors[str_side] playSound("veh_lift_doors_open");
    } else {
      e_lift.a_e_doors[str_side] playSound("veh_lift_doors_close");
    }
    e_lift.a_e_doors[str_side] waittill("movedone");
    e_lift.a_e_doors[str_side] linkto(e_lift);
    if(str_state == "open") {
      level flag::set(("pallas_lift_" + str_side) + "_open");
    } else {
      level flag::clear(("pallas_lift_" + str_side) + "_open");
    }
  }
}

function elevator_set_shaft_state(str_state) {
  e_lift = getent("boss_fight_lift", "targetname");
  if(!e_lift.a_e_shaft_doors["left"].str_state === str_state) {
    foreach(e_shaft_door in e_lift.a_e_shaft_doors) {
      v_move_value = e_shaft_door.script_vector;
      if(str_state == "close") {
        v_move_value = v_move_value * -1;
      }
      e_shaft_door.str_state = str_state;
      e_shaft_door moveto(e_shaft_door.origin + v_move_value, 3.947368, 3.947368 * 0.1, 3.947368 * 0.25);
    }
  }
}

function elevator_set_move_direction(str_direction) {
  array::run_all(level.players, & util::set_low_ready, 1);
  e_lift = getent("boss_fight_lift", "targetname");
  e_lift.str_direction = str_direction;
  e_decon_fx_origin = getent("decon_fx_origin", "targetname");
  e_decon_fx_origin linkto(e_lift);
  playFXOnTag(level._effect["decon_mist"], e_decon_fx_origin, "tag_origin");
  e_decon_fx_origin playSound("veh_lift_mist");
  n_zvalue = 1750;
  if(str_direction == "down") {
    n_zvalue = n_zvalue * -1;
  }
  e_lift movez(n_zvalue, 48.61111, 48.61111 * 0.1, 48.61111 * 0.25);
  e_lift playSound("veh_lift_start");
  loop_snd_ent = spawn("script_origin", e_lift.origin);
  loop_snd_ent linkto(e_lift);
  loop_snd_ent playLoopSound("veh_lift_loop", 0.5);
  e_lift waittill("movedone");
  loop_snd_ent stoploopsound(0.5);
  e_lift playSound("veh_lift_stop");
  loop_snd_ent delete();
  array::run_all(level.players, & util::set_low_ready, 0);
}

function elevator_set_opaque(n_state) {
  e_lift = getent("boss_fight_lift", "targetname");
  e_lift clientfield::set("sm_elevator_shader", n_state);
}

function elevator_lift_intro() {
  elevator_set_door_state("front", "open");
  level flag::wait_till("weapons_research_vo_done");
  t_lift = getent("pallas_lift_trigger", "targetname");
  t_lift sgen_util::gather_point_wait();
  level thread link_elevator_light_probe();
  array::thread_all(getEntArray("head_track_model", "targetname"), & util::delay_notify, 0.05, "stop_head_track_player");
  array::run_all(getEntArray("pallas_lift_front_clip", "targetname"), & movez, 112, 0.05);
  elevator_set_door_state("front", "close");
  elevator_set_opaque(3);
  level thread namespace_d40478f6::function_874f01d();
  level notify("elevator_vo");
  level notify("pallas_elevator_starting");
  a_ai = getaiteamarray("team3");
  foreach(ai in a_ai) {
    if(isalive(ai)) {
      ai delete();
    }
  }
  level clientfield::set("w_underwater_state", 0);
  objectives::complete("cp_level_sgen_goto_server_room_indicator", struct::get("pallas_elevator_descent_objective"));
  util::delay(3, undefined, & skipto::objective_completed, "descent");
  array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 2);
  elevator_set_move_direction("down");
  elevator_set_door_state("back", "open");
  level notify("enter_server");
  a_nd_traverse = getnodearray("pallas_elevator_start", "script_noteworthy");
  foreach(node in a_nd_traverse) {
    linktraversal(node);
  }
}

function elevator_lift_outro(b_starting) {
  elevator_set_door_state("back", "close");
  if(!b_starting) {
    e_lift = getent("boss_fight_lift", "targetname");
    e_lift.origin = e_lift.origin + vectorscale((0, 0, 1), 1750);
  }
  elevator_set_door_state("front", "open");
}

function watch_for_damage() {
  level endon("pallas_ambush_over");
  self util::waittill_either("damage", "death");
  level flag::set("pallas_ambush_over");
}

function function_87d6b629() {
  level endon("pallas_ambush_over");
  array::wait_any(level.players, "weapon_fired");
  level flag::set("pallas_ambush_over");
}

function pallas_greeting_event(b_starting) {
  if(!b_starting) {
    var_34a8e0f = getent("pallas_turret_enable_trigger", "targetname");
    var_34a8e0f.origin = var_34a8e0f.origin + (vectorscale((0, -1, 0), 38));
    level waittill("enter_server");
    trigger::wait_or_timeout(30, "pallas_turret_enable_trigger");
  }
  level thread namespace_d40478f6::function_973b77f9();
  savegame::checkpoint_save();
  level thread function_87d6b629();
  level dialog::player_say("plyr_diaz_you_have_to_s_0", 1);
  array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 1);
  level.ai_pallas dialog::say("diaz_i_am_willing_to_d_0");
  level thread namespace_d40478f6::function_ad14681b();
  level flag::set("pallas_ambush_over");
  level dialog::remote("kane_the_only_way_to_disc_0", 2);
  level dialog::remote("hend_kane_i_m_currently_0");
  level dialog::remote("kane_access_the_primary_s_0");
  level dialog::remote("hend_you_re_the_boss_lad_0");
  level notify("pallas_objective_start");
  wait(2);
  level dialog::remote("kane_got_it_focus_fire_o_0", 2);
  level flag::set("pallas_intro_completed");
}

function function_ab0e4cbe() {
  level endon("pallas_end");
  while(true) {
    level waittill("save_restore");
    for(i = 1; i <= 3; i++) {
      mdl_ball = getent("diaz_ball_" + i, "targetname");
      mdl_ball globallogic_ui::destroyweakpointwidget(&"tag_weakpoint");
    }
  }
}

function handle_pallas_pillar_weakspot() {
  level endon("pallas_start");
  level waittill("pallas_objective_start");
  a_t_coolants = getEntArray("pallas_coolant_control", "targetname");
  foreach(trigger in a_t_coolants) {
    trigger sethintstring(&"CP_MI_SING_SGEN_DESTROY_PILLAR");
    trigger triggerenable(0);
  }
  level flag::wait_till("pallas_intro_completed");
  var_61b0688 = getEntArray("diaz_tower_1", "targetname");
  while(true) {
    level thread function_6030416();
    n_random_int = randomint(var_61b0688.size);
    e_pallas_pillar = var_61b0688[n_random_int];
    var_61b0688 = array::remove_index(var_61b0688, n_random_int);
    e_pallas_pillar movez(114, 4);
    playFX(level._effect["coolant_tower_unleash"], e_pallas_pillar.origin + (vectorscale((0, 0, -1), 250)));
    e_pallas_pillar playSound("evt_pillar_move");
    switch (level.var_e16e585d) {
      case 0: {
        level thread dialog::remote("kane_cooling_tower_one_ex_0", 1);
        break;
      }
      case 1: {
        level thread dialog::remote("kane_cooling_tower_two_ex_0", 1);
        break;
      }
      case 2: {
        level thread dialog::remote("kane_cooling_tower_three_0", 1);
        break;
      }
    }
    level thread cooling_tower_nag();
    e_pallas_pillar waittill("movedone");
    level thread weakspot_damage(e_pallas_pillar.script_float);
    a_t_coolant = getEntArray("pallas_coolant_control", "targetname");
    a_t_coolant = arraysortclosest(a_t_coolant, e_pallas_pillar.origin);
    t_coolant = a_t_coolant[0];
    level thread activate_flood_spawn();
    level waittill("pillar_destroyed");
    array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 2);
    objectives::complete("cp_level_sgen_destroy_tower");
    level.var_e16e585d++;
    e_pallas_pillar playSound("evt_pillar_dest");
    playsoundatposition("evt_diaz_alarm", e_pallas_pillar.origin);
    level thread function_47bd64a2();
    wait(5);
    array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 0);
    level thread core_nag();
    t_coolant triggerenable(1);
    s_temp = spawnStruct();
    s_temp.origin = t_coolant.origin + vectorscale((0, 0, 1), 16);
    s_temp.angles = t_coolant.angles;
    objectives::set("cp_level_sgen_release_coolant", s_temp.origin);
    if(level.var_e16e585d == 3) {
      level thread scene::init("cin_sgen_19_ghost_3rd_sh010");
    }
    b_player_valid = 0;
    while(!b_player_valid) {
      t_coolant waittill("trigger", e_player);
      if(!e_player laststand::player_is_in_laststand()) {
        b_player_valid = 1;
        e_player enableinvulnerability();
      }
    }
    level notify("stage_completed");
    switch (level.var_e16e585d) {
      case 1: {
        spawn_manager::kill("sm_stage1_flood", 0);
        spawn_manager::kill("sm_stage1");
        level thread namespace_d40478f6::function_3d554ba8();
        break;
      }
      case 2: {
        spawn_manager::kill("sm_stage2_flood", 0);
        spawn_manager::kill("sm_stage2");
        level thread namespace_d40478f6::function_af5cbae3();
        break;
      }
      case 3: {
        spawn_manager::kill("sm_stage3_flood", 0);
        level thread namespace_d40478f6::function_895a407a();
        break;
      }
    }
    objectives::complete("cp_level_sgen_release_coolant", s_temp.origin);
    fx_struct = struct::get(t_coolant.target, "targetname");
    str_anim_base = t_coolant.script_noteworthy + t_coolant.script_string;
    switch (level.var_e16e585d) {
      case 1:
      case 2: {
        level scene::play(str_anim_base + "_a", e_player);
        level thread scene::play(str_anim_base + "_b", e_player);
        break;
      }
      case 3: {
        level scene::add_scene_func("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle", & function_c5372adb, "play");
        level scene::add_scene_func("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle", & function_6610aebe, "init");
        level thread scene::play(str_anim_base + "_a", e_player);
        level thread scene::init("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle");
        level waittill(str_anim_base + "_a_done");
        level flag::set("pallas_death");
        array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 3);
        e_player disableinvulnerability();
        level thread skipto::objective_completed("pallas_start");
        break;
      }
    }
    t_coolant delete();
    level waittill("boom");
    level thread detonate_robots();
    fx_model = util::spawn_model("tag_origin", fx_struct.origin, fx_struct.angles);
    level sgen_util::quake(0.5, 1, fx_model.origin, 5000, 4, 7);
    level thread show_cracked_glass(e_pallas_pillar.script_float);
    wait(2);
    if(isDefined(e_player)) {
      e_player disableinvulnerability();
    }
    fx_model delete();
    switch (level.var_e16e585d) {
      case 1: {
        level notify("pallas_attacked");
        level dialog::player_say("plyr_grenade_detonated_0");
        level dialog::remote("kane_it_worked_central_0");
        if(isDefined(level.bzm_overridelocomotion)) {
          level thread[[level.bzm_overridelocomotion]](40, 40, 20);
        }
        if(isDefined(level.bzm_overridehealth)) {
          level thread[[level.bzm_overridehealth]](150, 150, 150);
        }
        if(isDefined(level.bzm_overridesuicidalchance)) {
          level thread[[level.bzm_overridesuicidalchance]](10);
        }
        break;
      }
      case 2: {
        level notify("pallas_attacked");
        level dialog::player_say("plyr_successful_detonatio_0");
        level dialog::remote("kane_central_core_down_to_0");
        exploder::exploder("light_sgen_palas_em");
        s_protect = struct::get("hendrick_console_hack");
        if(isDefined(level.bzm_overridelocomotion)) {
          level thread[[level.bzm_overridelocomotion]](25, 50, 25);
        }
        if(isDefined(level.bzm_overridehealth)) {
          level thread[[level.bzm_overridehealth]](175, 175, 175);
        }
        if(isDefined(level.bzm_overridesuicidalchance)) {
          level thread[[level.bzm_overridesuicidalchance]](15);
        }
        if(!sessionmodeiscampaignzombiesgame()) {
          objectives::set("cp_level_sgen_protect_hendricks", s_protect.origin);
        }
        break;
      }
    }
    savegame::checkpoint_save();
    array::thread_all(level.players, & clientfield::set_to_player, "pallas_monitors_state", 1);
    wait(2);
    switch (level.var_e16e585d) {
      case 1: {
        spawn_manager::enable("sm_stage2");
        break;
      }
      case 2: {
        level.n_core_guard_count = 0;
        spawn_manager::enable("sm_stage3");
        level flag::set("core_two_destroyed");
        break;
      }
    }
    if(level.var_e16e585d == 1) {
      level dialog::remote("kane_working_on_opening_c_0", 2);
      level dialog::player_say("plyr_hurry_up_kane_i_m_0", 3);
      function_75946123("sm_stage2", 4, 20);
    } else if(level.var_e16e585d == 2) {
      level dialog::remote("kane_working_on_tower_thr_0");
      wait(20);
      switch (level.players.size) {
        case 2: {
          n_spawn_count = 25;
          break;
        }
        case 3: {
          n_spawn_count = 30;
          break;
        }
        case 4: {
          n_spawn_count = 35;
          break;
        }
        default: {
          n_spawn_count = 20;
          break;
        }
      }
      function_864a9c57("sm_stage3", n_spawn_count, 30);
      level notify("hash_265b1313");
      level thread function_e8ee435e();
      util::waittill_notify_or_timeout("all_suicide_bots_killed", 15);
      level flag::set("hendricks_attacked_done");
      if(!sessionmodeiscampaignzombiesgame()) {
        objectives::complete("cp_level_sgen_protect_hendricks");
      }
    }
  }
}

function function_47bd64a2() {
  switch (level.var_e16e585d) {
    case 1: {
      level dialog::remote("kane_cooling_tower_one_of_0");
      break;
    }
    case 2: {
      level dialog::remote("kane_cooling_tower_two_of_0");
      break;
    }
    case 3: {
      level.var_94d58561 = gettime() + 30000;
      level flag::set("tower_three_destroyed");
      level dialog::remote("kane_cooling_tower_three_1");
      level dialog::remote("hend_this_better_not_kill_0");
      level dialog::remote("kane_not_the_time_comman_0");
      exploder::exploder_stop("light_sgen_palas_em");
      break;
    }
  }
}

function function_75946123(str_sm_name, n_ai_count, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }
  spawn_manager::wait_till_ai_remaining(str_sm_name, n_ai_count);
}

function function_864a9c57(str_sm_name, n_spawn_count, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }
  spawn_manager::wait_till_spawned_count(str_sm_name, n_spawn_count);
}

function activate_flood_spawn() {
  level endon("stage_completed");
  switch (level.var_e16e585d) {
    case 0: {
      spawn_manager::wait_till_ai_remaining("sm_stage1", 3);
      spawn_manager::enable("sm_stage1_flood");
      break;
    }
    case 1: {
      spawn_manager::wait_till_ai_remaining("sm_stage2", 3);
      spawn_manager::enable("sm_stage2_flood");
      break;
    }
    case 2: {
      level waittill("pillar_destroyed");
      spawn_manager::kill("sm_stage3");
      spawn_manager::enable("sm_stage3_flood");
      break;
    }
  }
}

function weakspot_damage(n_tower) {
  n_tower = int(n_tower);
  e_core = getent("diaz_ball_" + n_tower, "targetname");
  e_core globallogic_ui::createweakpointwidget(&"tag_weakpoint");
  n_total_health = 300 * level.players.size;
  e_core.health = n_total_health;
  e_core thread do_damage_react();
  exploder::exploder("pallas_fight_coolant_tower_" + n_tower);
  while(e_core.health >= (n_total_health / 2)) {
    e_core waittill("damage");
  }
  exploder::exploder("pallas_fight_dmg_1_tower_" + n_tower);
  mdl_fx = util::spawn_model("tag_origin", e_core.origin, e_core.angles);
  playFXOnTag(level._effect["coolant_tower_damage_minor"], mdl_fx, "tag_origin");
  if(e_core.health > 0) {
    e_core waittill("death");
  }
  e_core disableaimassist();
  e_core globallogic_ui::destroyweakpointwidget(&"tag_weakpoint");
  switch (n_tower) {
    case 1: {
      level thread scene::play("coolant_hose_03", "targetname");
      level clientfield::set("tower_chunks2", 1);
      break;
    }
    case 2: {
      level thread scene::play("coolant_hose_01", "targetname");
      level clientfield::set("tower_chunks1", 1);
      break;
    }
    case 3: {
      level thread scene::play("coolant_hose_05", "targetname");
      level clientfield::set("tower_chunks3", 1);
      break;
    }
  }
  level sgen_util::quake(0.5, 1, e_core.origin, 5000, 4, 7);
  exploder::exploder("pallas_fight_exp_tower_" + n_tower);
  mdl_fx delete();
  level notify("pillar_destroyed");
  mdl_fx = util::spawn_model("tag_origin", e_core.origin, e_core.angles);
  playFXOnTag(level._effect["coolant_tower_damage_major"], mdl_fx, "tag_origin");
}

function do_damage_react() {
  self setcontents(8192);
  self setCanDamage(1);
  self enableaimassist();
  self.team = "axis";
  self clientfield::set("cooling_tower_damage", 1);
  objectives::set("cp_level_sgen_destroy_tower", self.origin + vectorscale((0, 0, 1), 18));
  while(self.health > 0) {
    self waittill("damage", damage, attacker, direction, point);
    playFX(level._effect["weakspot_impact"], point, direction * -1);
    attacker damagefeedback::update();
  }
  self clientfield::set("cooling_tower_damage", 0);
  self setcontents(256);
  self setCanDamage(0);
  self disableaimassist();
  self.team = "none";
}

function do_attack_on_hendricks() {
  level endon("pallas_death");
  level endon("hash_265b1313");
  level.a_assault_bot = [];
  level.var_2d3af18b = 0;
  level.var_e15d967a = 8 + (level.players.size * 2);
  var_cf1fb9af = 0;
  while(var_cf1fb9af < level.var_e15d967a) {
    for(i = 0; i < 2; i++) {
      if(!isalive(level.a_assault_bot[i])) {
        potential_hendricks_bots = getEntArray("potential_hendricks_bot", "script_string");
        ai_bot = arraygetclosest(level.ai_hendricks.origin, potential_hendricks_bots);
        if(isalive(ai_bot)) {
          ai_bot.script_string = undefined;
          level.a_assault_bot[i] = ai_bot;
          ai_bot thread explode_robot(i + 1);
          var_cf1fb9af++;
          util::wait_network_frame();
        }
      }
    }
    wait(0.5);
  }
}

function function_e8ee435e() {
  foreach(ai_bot in level.a_assault_bot) {
    if(isalive(ai_bot)) {
      ai_bot waittill("death");
    }
  }
  wait(0.1);
  level notify("hash_e33ac8c");
}

function explode_robot(n_scene) {
  self endon("death");
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  self ai::set_behavior_attribute("rogue_control", "forced_level_3");
  self ai::set_ignoreall(1);
  self flag::wait_till("in_playable_space");
  level thread scene::play("cin_sgen_18_01_pallasfight_vign_takedown_explode0" + n_scene, self);
  self waittill("start_timer");
  level thread check_wall_climb_vo();
  switch (level.players.size) {
    case 2: {
      wait(5);
      break;
    }
    case 3:
    case 4: {
      wait(3);
      break;
    }
    default: {
      wait(7);
      break;
    }
  }
  level thread scene::stop("cin_sgen_18_01_pallasfight_vign_takedown_explode0" + n_scene);
  self ai::set_behavior_attribute("rogue_force_explosion", 1);
  level thread hendricks_attacked();
}

function hendricks_attacked() {
  level.var_2d3af18b++;
  switch (level.var_2d3af18b) {
    case 1: {
      level clientfield::increment("observation_deck_destroy");
      level dialog::remote("hend_shit_kane_hurry_t_0", 1);
      break;
    }
    case 2: {
      level dialog::remote("hend_gimme_a_hand_i_got_0");
      break;
    }
    case 3: {
      level clientfield::increment("observation_deck_destroy");
      level dialog::remote("hend_i_m_getting_torn_up_0", 1);
      break;
    }
    case 4: {
      level dialog::remote("hend_robots_overtaking_my_0");
      break;
    }
    case 5: {
      level thread function_c79b403e();
      break;
    }
  }
}

function function_c79b403e() {
  level clientfield::increment("observation_deck_destroy", 1);
  st_align = struct::get("hendrick_console_hack", "targetname");
  st_align thread scene::stop("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active");
  wait(0.05);
  level.ai_hendricks util::stop_magic_bullet_shield();
  level.ai_hendricks dodamage(level.ai_hendricks.health, level.ai_hendricks.origin);
  wait(3.5);
  util::missionfailedwrapper_nodeath(&"CP_MI_SING_SGEN_HENDRICKS_KILLED");
}

function track_intro_death() {
  self waittill("death");
  level.var_9945a95d++;
  if(level.var_9945a95d == 8) {
    spawn_manager::enable("sm_stage1");
  }
}

function cooling_tower_nag() {
  level endon("pillar_destroyed");
  wait(randomfloatrange(10, 15));
  switch (level.var_e16e585d) {
    case 0: {
      level dialog::remote("hend_focus_fire_take_ou_0");
      wait(randomfloatrange(15, 20));
      level dialog::remote("hend_disable_that_tower_t_0");
      break;
    }
    case 1: {
      level dialog::remote("kane_we_need_to_bring_dow_0");
      break;
    }
    case 2: {
      level dialog::remote("kane_take_the_tower_offli_0");
      break;
    }
  }
}

function core_nag() {
  level endon("stage_completed");
  wait(randomfloatrange(7, 10));
  switch (level.var_e16e585d) {
    case 1: {
      level dialog::remote("kane_you_ve_got_to_get_cl_0");
      wait(randomfloatrange(8, 12));
      level dialog::remote("kane_come_on_climb_the_c_0");
      wait(randomfloatrange(8, 12));
      level dialog::remote("hend_you_heard_her_get_o_0");
      wait(randomfloatrange(8, 12));
      level dialog::remote("hend_climb_the_tower_hi_0");
      break;
    }
    case 2: {
      level dialog::remote("hend_get_another_grenade_0");
      wait(randomfloatrange(12, 16));
      level dialog::remote("hend_we_re_running_out_of_2");
      break;
    }
    case 3: {
      level dialog::remote("hend_get_on_that_tower_an_0");
      wait(randomfloatrange(12, 16));
      level dialog::remote("kane_get_a_grenade_in_the_0");
      wait(randomfloatrange(12, 16));
      level dialog::remote("kane_blow_the_damn_core_0");
      break;
    }
  }
}

function function_6030416() {
  level endon("stage_completed");
  wait(randomfloatrange(3, 5));
  switch (level.var_e16e585d) {
    case 0: {
      level.ai_pallas dialog::say("diaz_listen_only_to_the_s_0");
      wait(randomfloatrange(3, 5));
      level.ai_pallas dialog::say("diaz_let_your_mind_relax_0");
      level.ai_pallas dialog::say("diaz_let_your_thoughts_dr_0");
      wait(randomfloatrange(5, 8));
      level.ai_pallas dialog::say("diaz_let_the_bad_memories_0");
      level.ai_pallas dialog::say("diaz_let_peace_be_upon_yo_0");
      break;
    }
    case 1: {
      level.ai_pallas dialog::say("diaz_surrender_yourself_t_0");
      level.ai_pallas dialog::say("diaz_let_them_wash_over_y_0");
      wait(randomfloatrange(5, 8));
      level.ai_pallas dialog::say("diaz_imagine_somewhere_ca_0");
      level.ai_pallas dialog::say("diaz_imagine_somewhere_sa_0");
      wait(randomfloatrange(5, 8));
      level.ai_pallas dialog::say("diaz_imagine_yourself_0");
      level.ai_pallas dialog::say("diaz_you_are_standing_in_0");
      wait(randomfloatrange(5, 8));
      level.ai_pallas dialog::say("diaz_the_trees_around_you_0");
      level.ai_pallas dialog::say("diaz_pure_white_snowflake_0");
      break;
    }
    case 2: {
      level.ai_pallas dialog::say("diaz_you_can_feel_them_me_0");
      level.ai_pallas dialog::say("diaz_you_are_not_cold_0");
      wait(randomfloatrange(3, 5));
      level.ai_pallas dialog::say("diaz_it_cannot_overcome_t_0");
      level.ai_pallas dialog::say("diaz_can_you_hear_it_0");
      level.ai_pallas dialog::say("diaz_can_you_hear_it_0");
      wait(randomfloatrange(3, 5));
      level.ai_pallas dialog::say("diaz_do_you_hear_it_slowi_0");
      level.ai_pallas dialog::say("diaz_you_are_slowing_it_0");
      wait(randomfloatrange(3, 5));
      level.ai_pallas dialog::say("diaz_you_are_in_control_0");
      level.ai_pallas dialog::say("diaz_calm_0");
      level.ai_pallas dialog::say("diaz_at_peace_0");
      break;
    }
  }
}

function check_wall_climb_vo() {
  if(!isDefined(level.b_wall_climb_vo_played)) {
    level.b_wall_climb_vo_played = 0;
  }
  if(!level.b_wall_climb_vo_played) {
    level.b_wall_climb_vo_played = 1;
    level dialog::remote("hend_hey_i_got_grunts_c_0");
  }
}

function detonate_robots(b_immediate = 0) {
  a_e_enemies = getaiteamarray("team3");
  foreach(e_enemy in a_e_enemies) {
    if(isalive(e_enemy)) {
      e_enemy dodamage(1000, e_enemy.origin);
      if(!b_immediate) {
        wait(randomfloatrange(0.05, 0.2));
      }
    }
  }
}

function init_fxanim_hoses() {
  level thread hide_cracked_glass();
  for(x = 1; x <= 8; x++) {
    level scene::init("coolant_hose_0" + x, "targetname");
  }
}

function all_hoses_break() {
  level waittill("all_hoses_break");
  level thread scene::play("coolant_hose_02", "targetname");
  level thread scene::play("coolant_hose_04", "targetname");
  level thread scene::play("coolant_hose_06", "targetname");
  level thread scene::play("coolant_hose_07", "targetname");
  level thread scene::play("coolant_hose_08", "targetname");
}

function hide_cracked_glass() {
  a_e_glass = getEntArray("pallas_glass_break_whole", "script_noteworthy");
  array::run_all(a_e_glass, & hide);
}

function show_cracked_glass(n_crack) {
  n_crack = int(n_crack);
  switch (n_crack) {
    case 1: {
      e_glass = getent("pallas_glass_break_1", "targetname");
      break;
    }
    case 2: {
      e_glass = getent("pallas_glass_break_3", "targetname");
      break;
    }
    default: {
      e_glass = getent("pallas_glass_break_2", "targetname");
      break;
    }
  }
  e_glass show();
}

function delete_model_on_death(robot) {
  robot waittill("death");
  self delete();
}

function check_for_nearby_players() {
  self endon("death");
  while(true) {
    foreach(player in level.players) {
      if(distancesquared(self.origin, player.origin) < 250000) {
        self notify("nearby_enemy");
      }
    }
    wait(0.1);
  }
}

function handle_robot_sm(str_triggername, str_sm) {
  level endon("pallas_death");
  trigger = getent(str_triggername, "targetname");
  while(true) {
    n_player = 0;
    foreach(player in level.players) {
      if(player istouching(trigger)) {
        n_player = n_player + 1;
      }
    }
    if(n_player > 0) {
      spawn_manager::enable(str_sm);
    } else if(spawn_manager::is_enabled(str_sm)) {
      spawn_manager::disable(str_sm);
    }
    wait(0.5);
  }
}