/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_terrorist_hunt.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_vehicle;
#include maps\yemen_utility;
#include maps\_objectives;
#include maps\_dialog;
#include maps\yemen;
#include maps\yemen_anim;

init_flags() {
  flag_init("terrorist_hunt_start");
  flag_init("terrorist_hunt_rockethall_start");
  flag_init("rocket_hall_zone_hit");
  flag_init("kill_rocket_hall_vo");
}

init_spawn_funcs() {
}

skipto_terrorist_hunt() {
  load_gump("yemen_gump_speech");
  skipto_teleport("skipto_terrorist_hunt_player");
  level thread maps\yemen::meet_menendez_objectives();
  dead_stat = level.player get_story_stat("DEFALCO_DEAD_IN_KARMA");

  if(dead_stat == 0)
    level.is_defalco_alive = 1;
  else
    level.is_defalco_alive = 0;
}

main() {
  iprintln("Terrorist Hunt");

  flag_set("terrorist_hunt_start");
  add_spawn_function_veh("courtyard_vtol", ::courtyard_vtol_one_fx);
  add_spawn_function_veh("courtyard_vtol_two", ::courtyard_vtol_two_fx);
  level thread vo_terrorist_hunt();
  terrorist_hunt_setup();
  level thread rocket_hall();
  collapse_door_and_load_area();
  flag_wait_either("rocket_hall_bypassed", "rocket_hall_zone_hit");
  flag_set("kill_rocket_hall_vo");
  terrorist_hunt_clean_up();
  autosave_by_name("terrorist_hunt");
}

courtyard_vtol_one_fx() {
  self waittill("vehicle_handleunloadevent");
  exploder(200);
  wait 15;
  stop_exploder(200);
}

courtyard_vtol_two_fx() {
  self waittill("vehicle_handleunloadevent");
  exploder(300);
  wait 15;
  stop_exploder(300);
}

vo_terrorist_hunt() {
  trigger_wait("t_rocket_hall_bypassed");
  level thread vo_rocket_hall();
  level thread vo_downtown_hurry();
  level thread vo_vtol_crash_foreshadow();
}

vo_market_end() {
  if(!flag("kill_rocket_hall_vo")) {
    dialog_start_convo();
    level.player priority_dialog("fari_harper_i_can_t_kee_0");
    level.player priority_dialog("harp_egghead_listen_to_0");
    level.player priority_dialog("harp_whatever_menendez_ha_0");
    level.player priority_dialog("harp_stay_strong_and_i_p_0");
    level.player priority_dialog("fari_yes_1");
    dialog_end_convo();
  }
}

vo_vtol_crash_foreshadow() {
  trigger_wait("vtol_crash_foreshadow_vo");
  dialog_start_convo();
  level.player priority_dialog("harp_farid_did_you_loca_0");
  level.player priority_dialog("fari_negative_0");
  level.player priority_dialog("harp_dammit_he_must_hav_0");
  dialog_end_convo();
}

vo_downtown_hurry() {
  trigger_wait("balcony_terrorist");
  dialog_start_convo();
  level.player priority_dialog("harp_we_re_only_minutes_a_0");
  level.player priority_dialog("harp_just_keep_moving_y_0");
  dialog_end_convo();
}

vo_rocket_hall() {
  dialog_start_convo();
  level.player priority_dialog("harp_you_said_menendez_wa_0");
  level.player priority_dialog("fari_the_west_gate_leads_0");
  level.player priority_dialog("harp_get_there_beat_0");
  dialog_end_convo();
}

collapse_door_and_load_area() {
  trigger_wait("trigger_market_unload");
  level thread load_gump("yemen_gump_morals");
  door = getent("market_unload_door", "targetname");
  door rotateyaw(90, 0.1);
  queue_dialog_ally("cd0_drones_overhead_br_0");
}

terrorist_hunt_setup() {
  add_spawn_function_group("rocket_hall_actors", "script_noteworthy", ::rocket_hall_terrorist_spawnfunc);
  simple_spawn("terrorist_hunt_court_terrorist", maps\yemen_utility::terrorist_teamswitch_spawnfunc);
  sp_spawner = getent("terrorist_hunt_terrorist", "targetname");
  sp_spawner terrorist_spawn_full_count(1);
  spawn_quadrotors_at_structs("terrorist_hunt_court_drones", "terrorist_hunt_court_drones");
}

terrorist_spawn_full_count(b_force) {
  n_count = self.count;

  for(i = 0; i < n_count; i++) {
    ai = self spawn_ai(b_force);
    ai.team = "allies";
    ai disableaimassist();
    wait 0.1;
  }
}

terrorist_hunt_court_clean_up() {
  level waittill("rocket_hall_bypassed");
  cleanup("terrorist_hunt_court_terrorist", "script_noteworthy");
  cleanup("terrorist_hunt_court_drones", "script_noteworthy");
}

terrorist_hunt_clean_up() {
  exploder(1030);
  level notify("fxanim_market_canopy_delete");
}

rocket_hall() {
  level endon("rocket_hall_bypassed");
  trigger_wait("spawn_rockethall");
  maps\yemen_anim::terrorist_hunt_anims();
  rocket_hall_setup();
  level thread rocket_hall_rpgs();
  exploder(330);
  exploder(331);
  exploder(332);
  exploder(333);
  exploder(334);
  level thread rocket_hall_vo();
  level thread rocket_hall_cleanup();
}

rocket_hall_xm25_carrier_spawn_func() {
  self endon("death");
  self queue_dialog("woun_i_am_wounded_0", 2);
  self queue_dialog("woun_take_it_help_the_f_0", 1);
}

rocket_hall_setup() {
  stop_exploder(1010);
  level thread terrorist_hunt_court_clean_up();
  vh_quadrotor = spawn_vehicle_from_targetname("rocket_hall_quadrotor");
  vh_quadrotor.goalpos = vh_quadrotor.origin;
  vh_quadrotor.goalradius = 300;
  vh_quadrotor.targetname = "rocket_hall_quadrotor";
  simple_spawn("rocket_hall_extra_guys");
  e_yemeni_spawner = getent("rocket_hall_yemeni", "targetname");
  e_yemeni_spawner add_spawn_function(::rocket_hall_yemeni_run_in);
  spawn_manager_enable("sm_rocket_hall_yemeni");
  flag_set("terrorist_hunt_rockethall_start");
}

rocket_hall_american_destruction() {
  s_grenade_1 = getstruct("rocket_hall_grenade_1", "targetname");
  s_grenade_2 = getstruct("rocket_hall_grenade_2", "targetname");
  a_zone_ai = get_ai_array("rocket_hall_actors", "script_noteworthy");

  if(isDefined(a_zone_ai[0]) && isalive(a_zone_ai[0]))
    a_zone_ai[0] magicgrenade(s_grenade_1.origin + vectorscale((0, 0, 1), 16.0), s_grenade_1.origin, 1);

  if(isDefined(a_zone_ai[0]) && isalive(a_zone_ai[0]))
    a_zone_ai[0] magicgrenade(s_grenade_2.origin + vectorscale((0, 0, 1), 16.0), s_grenade_2.origin, 1);
}

rocket_hall_rpgs() {
}

rocket_hall_rpg_fire(str_start_struct) {
  s_rpg_start = getstruct(str_start_struct, "targetname");
  s_rpg_end = getstruct(s_rpg_start.target, "targetname");
  magicbullet("usrpg_magic_bullet_sp", s_rpg_start.origin, s_rpg_end.origin);
}

rocket_hall_play_death_anims() {
  level thread run_scene("rocket_hall_death_zone_1");
  level thread run_scene("rocket_hall_death_zone_2");
}

rocket_hall_yemeni_run_in() {
  self endon("death");
  self.team = "axis";
  self enableaimassist();
  s_runto_point = getstruct("rocket_hall_yemeni_goto_spot", "targetname");
  level waittill("rocket_hall_bypassed");
  wait(randomfloatrange(0.05, 3));
  self set_ignoreme(1);
  self force_goal(s_runto_point.origin, 256, 0);
  self delete();
}

rocket_hall_yemeni_spawnfunc() {
  self.team = "axis";
}

rocket_hall_terrorist_spawnfunc() {
  self endon("death");
  self.team = "allies";
  self disableaimassist();
  str_notify = level waittill_any_return("rocket_hall_zone_hit", "rocket_hall_bypassed", "rocket_hall_switch_team");

  if(str_notify == "rocket_hall_bypassed")
    self bloody_death(undefined, 4);
  else {
    self.team = "axis";
    self enableaimassist();
  }
}

rocket_hall_terrorist_switch_team() {
  self endon("death");
  level endon("rocket_hall_switch_team");

  while(self.team == "allies") {
    self waittill("damage", damage, e_attacker);

    if(isplayer(e_attacker))
      level notify("rocket_hall_switch_team");
  }
}

rocket_hall_switch_team() {
  level endon("rocket_hall_zone_hit");
  level endon("rocket_hall_bypassed");
  level waittill("rocket_hall_switch_team");
  getent("rocket_hall_nosight", "targetname") delete();
}

rocket_hall_vo() {
  queue_dialog_ally("cd0_they_are_cut_off_0");
  queue_dialog_ally("cd1_keep_fire_on_them_0");
  queue_dialog_ally("cd2_kill_them_where_they_0");
}

rocket_hall_cleanup() {
  level waittill("rocket_hall_bypassed");
  vh_quadrotor = getent("rocket_hall_quadrotor", "targetname");

  if(isDefined(vh_quadrotor))
    vh_quadrotor delete();
}