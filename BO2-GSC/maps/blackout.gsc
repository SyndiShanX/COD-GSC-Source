/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\war_room_util;
#include maps\_music;
#include maps\blackout_util;
#include maps\blackout_fx;
#include maps\_cic_turret;
#include maps\_load;
#include maps\_drones;
#include maps\_rusher;
#include maps\blackout_anim;
#include maps\blackout_amb;
#include maps\createart\blackout_art;
#include maps\blackout_bridge;
#include maps\blackout_menendez_start;
#include maps\_fire_direction;
#include maps\blackout_interrogation;
#include maps\blackout_security;
#include maps\blackout_server_room;
#include maps\blackout_hangar;
#include maps\blackout_deck;
#include maps\_challenges_sp;

main() {
  maps\blackout_fx::main();
  level.supportsvomitingdeaths = 1;
  level_precache();
  init_flags();
  setup_objectives();
  init_spawner_teams();
  init_kill_functions();
  setup_skiptos();
  setup_level();
  level thread maps\_cic_turret::init();
  maps\_load::main();
  maps\_drones::init();
  maps\_rusher::init_rusher();
  onplayerconnect_callback(::on_player_connect);
  onsaverestored_callback(::save_restored_callback);
  init_hackable_turrets();
  level thread run_distant_explosions();
  maps\blackout_anim::main();
  maps\blackout_amb::main();
  maps\blackout_util::init_fxanims();
  maps\blackout_util::init_drones();
  level thread maps\createart\blackout_art::main();
  init_doors();
  level.m_mason_height = getdvarfloatdefault("player_standingViewHeight", 60);
  level.m_menendez_height = level.m_mason_height + 5;
  holo_table_system_init();
  level thread maps\blackout_bridge::holo_table_flicker_out();
  setup_extra_cams();
}

on_player_connect() {
  level.player = get_players()[0];
  level.player thread setup_challenge();
  clip = getent("mason_elevator_clip", "targetname");
  clip notsolid();
  retrieve_story_stats();
}

setup_level() {
  level.is_briggs_alive = 1;
  level.num_seals_saved = 0;
  setdvar("r_waterwaveangle", "0 52.7305 164.841 0");
  setdvar("r_waterwavewavelength", "592 357 286 1");
  setdvar("r_waterwaveamplitude", "25 6 5 0");
  setdvar("r_waterwavespeed", "0.72 1.21 1.14 1");
  setsaveddvar("phys_disableEntsAndDynEntsCollision", 1);
  t_kick_trig = getent("vent_kick_trig", "targetname");
  t_kick_trig trigger_off();
  trigger_off("downstairs_light_trig", "script_noteworthy");
  sp_menendez = get_ent("menendez", "targetname", 1);
  sp_menendez add_spawn_function(::menendez_bloody_version);
}

level_precache() {
  precache_player_models();
  precache_corpse_pose_characters();
  precacherumble("tank_rumble");
  precacherumble("flyby");
  precacheitem("usrpg_magic_bullet_nodrop_sp");
  precacheitem("usrpg_magic_bullet_cmd_sp");
  precacheitem("f35_missile_turret");
  precacheitem("f35_side_minigun");
  precacheitem("cic_turret");
  precacheitem("noweapon_sp");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachemodel("veh_t6_air_fa38_extracam");
  precachemodel("c_usa_cia_combat_harper_head_scar");
  precachemodel("c_mul_menendez_old_captured_body_bld");
  precachemodel("c_mul_menendez_old_captured_head_bleed");
  precachemodel("c_usa_cia_masonjr_armlaunch_viewbody_s");
  precachemodel("c_usa_cia_combat_masonjr_head_shadow");
  precachemodel("com_folding_chair");
  precachemodel("t6_wpn_taser_knuckles_prop_view");
  precachemodel("t6_wpn_hacking_dongle_prop");
  precachemodel("t6_wpn_turret_cic_world");
  precacheitem("tazer_knuckles_sp");
  precachemodel("p_rus_office_table_metal_cufflock");
  precachemodel("c_usa_seal6_assault_head");
  maps\blackout_menendez_start::precache_super_kill_models();
  precachemodel("t6_wpn_pistol_judge_prop_world");
  precachemodel("p6_celerium_chip");
  precachemodel("p6_celerium_chip_eye");
  precachemodel("p6_celerium_chip_eye_broken");
  precachemodel("t6_wpn_pendant_prop_damaged");
  precachemodel("paris_crowbar_02");
  precachemodel("p6_blackout_door_server_room");
  precachemodel("t6_wpn_laser_cutter_prop");
  maps\_fire_direction::claw_precache();
  precachestring(&"blackout_dradis");
  precachestring(&"hud_cic_weapon_heat");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"cctv_hud");
  precachestring(&"blackout_intro_jetwing");
  precachestring(&"blackout_eye_chip");
  precachestring(&"hud_update_visor_text");
  precachestring(&"BLACKOUT_VISOR_REBOOT_1");
  precachestring(&"BLACKOUT_VISOR_REBOOT_2");
  precachestring(&"BLACKOUT_VISOR_REBOOT_3");
  precachestring(&"BLACKOUT_VISOR_REBOOT_4");
  precachestring(&"BLACKOUT_VISOR_TURRET_DESTROYED");
  precachestring(&"BLACKOUT_VISOR_INTERROGATION");
  precachestring(&"menendez_no_hud");
  precachemodel("t6_wpn_jaws_of_life_prop");
  precachemodel("p6_mason_vent_panel");
  precachemodel("p6_mason_second_vent");
  precachemodel("p6_console_chair_swivel");
  precachemodel("t6_wpn_pistol_fiveseven_prop");
}

init_flags() {
  maps\blackout_util::init_flags();
  maps\blackout_interrogation::init_flags();
  maps\blackout_bridge::init_flags();
  maps\blackout_security::init_flags();
  maps\blackout_menendez_start::init_flags();
  maps\blackout_server_room::init_flags();
  maps\blackout_hangar::init_flags();
  maps\blackout_deck::init_flags();
  flag_init("sea_cowbell_running");
  flag_init("bridge_launchers_running");
  flag_init("any_pipes_destroyed");
  flag_init("intruder_perk_used");
  flag_init("brute_force_perk_used");
  flag_init("lockbreaker_used");
  level.branching_scene_debug = 0;
}

init_doors() {
  doors = getentarray("rotating_door", "script_noteworthy");

  for(i = 0; i < doors.size; i++) {
    model = getent(doors[i].target, "targetname");

    if(isDefined(model))
      model linkto(doors[i]);
  }
}

setup_skiptos() {
  add_skipto("mason_start", maps\blackout_interrogation::skipto_mason_start, "Mason Start", maps\blackout_interrogation::run_mason_start);
  add_skipto("mason_interrogation_room", maps\blackout_interrogation::skipto_mason_interrogation_room, "Interrogation Room", maps\blackout_interrogation::run_mason_interrogation_room);
  add_skipto("mason_wakeup", maps\blackout_interrogation::skipto_mason_wakeup, "Mason Wakeup", maps\blackout_interrogation::run_mason_wakeup);
  add_skipto("mason_hallway", maps\blackout_interrogation::skipto_mason_hallway, "Mason Hallway", maps\blackout_interrogation::run_mason_hallway);
  add_skipto("mason_salazar_exit", maps\blackout_bridge::skipto_mason_salazar_exit, "Salazar Exits", maps\blackout_bridge::run_mason_salazar_exit);
  add_skipto("mason_bridge", maps\blackout_bridge::skipto_mason_bridge, "Mason Bridge", maps\blackout_bridge::run_mason_bridge);
  add_skipto("mason_catwalk", maps\blackout_bridge::skipto_mason_catwalk, "Mason Catwalk", maps\blackout_bridge::run_mason_catwalk);
  add_skipto("mason_lower_level", maps\blackout_security::skipto_mason_lower_level, "Mason Lower Level", maps\blackout_security::run_mason_lower_level);
  add_skipto("mason_defend", maps\blackout_security::skipto_mason_security, "Mason Sensitive Room", maps\blackout_security::run_mason_security);
  add_skipto("mason_cctv", maps\blackout_security::skipto_mason_cctv, "Mason CCTV Room", maps\blackout_security::run_mason_cctv);
  add_skipto("menendez_start", maps\blackout_menendez_start::skipto_menendez_start, "SKIPTO_STRING_HERE", maps\blackout_menendez_start::run_menendez_start);
  add_skipto("menendez_meat_shield", maps\blackout_menendez_start::skipto_menendez_meat_shield, "SKIPTO_STRING_HERE", maps\blackout_menendez_start::run_menendez_meat_shield);
  add_skipto("menendez_betrayal", maps\blackout_menendez_start::skipto_menendez_betrayal, "SKIPTO_STRING_HERE", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("mason_vent", maps\blackout_server_room::skipto_mason_vent, "Mason Vent", maps\blackout_server_room::run_mason_vent);
  add_skipto("mason_server_room", maps\blackout_server_room::skipto_mason_server_room, "Mason Server Room", maps\blackout_server_room::run_mason_server_room);
  add_skipto("mason_hangar", maps\blackout_hangar::skipto_mason_hangar, "Mason Hangar", maps\blackout_hangar::run_mason_hangar);
  add_skipto("mason_salazar_caught", maps\blackout_hangar::skipto_mason_salazar_caught, "Mason Meets Salazar", maps\blackout_hangar::run_mason_salazar_caught);
  add_skipto("mason_elevator", maps\blackout_hangar::skipto_mason_elevator, "Mason Elevator", maps\blackout_hangar::run_mason_elevator);
  add_skipto("mason_deck", maps\blackout_deck::skipto_mason_deck, "Mason Deck", maps\blackout_deck::run_mason_deck);
  add_skipto("mason_final", maps\blackout_deck::skipto_mason_deck_final, "Mason Escape", maps\blackout_deck::run_mason_deck_final);
  add_skipto("dev_drones", maps\blackout_deck::dev_skipto_drones, "Dev Drones", maps\blackout_deck::run_dev_drones);
  add_skipto("dev_alive_a", maps\blackout_menendez_start::skipto_menendez_betrayal_alive_a, "alive_a", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("dev_alive_b", maps\blackout_menendez_start::skipto_menendez_betrayal_alive_b, "alive_b", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("dev_alive_c", maps\blackout_menendez_start::skipto_menendez_betrayal_alive_c, "alive_c", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("dev_dead_a", maps\blackout_menendez_start::skipto_menendez_betrayal_dead_a, "dead_a", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("dev_dead_c", maps\blackout_menendez_start::skipto_menendez_betrayal_dead_c, "dead_c", maps\blackout_menendez_start::run_menendez_betrayal);
  add_skipto("dev_dead_d", maps\blackout_menendez_start::skipto_menendez_betrayal_dead_d, "dead_d", maps\blackout_menendez_start::run_menendez_betrayal);
  default_skipto("mason_start");
  set_skipto_cleanup_func(maps\blackout_util::skipto_setup);
}

setup_objectives() {
  level.obj_lock_perk = register_objective(&"");
  level.obj_hack_perk1 = register_objective(&"");
  level.obj_hack_perk2 = register_objective(&"");
  level.obj_interrogate = register_objective(&"BLACKOUT_OBJ_INTERROGATE");
  level.obj_pickup_weapons = register_objective(&"BLACKOUT_OBJ_PICKUP_GUNS");
  level.obj_restore_control = register_objective(&"BLACKOUT_OBJ_RESTORE_CONTROL");
  level.obj_cctv = register_objective(&"BLACKOUT_OBJ_VIEW_CCTV");
  level.obj_help_seals = register_objective(&"BLACKOUT_OBJ_HELP_SEALS");
  level.obj_grab_briggs = register_objective(&"BLACKOUT_OBJ_GRAB_BRIGGS");
  level.obj_shoot_briggs = register_objective(&"BLACKOUT_OBJ_SHOOT_BRIGGS");
  level.obj_fake_interrogate = register_objective(&"BLACKOUT_OBJ_INTERROGATE");
  level.obj_fake_restore_control = register_objective(&"BLACKOUT_OBJ_RESTORE_CONTROL");
  level.obj_server = maps\_objectives::register_objective(&"BLACKOUT_OBJ_SERVER");
  level.obj_find_salazar = maps\_objectives::register_objective(&"BLACKOUT_OBJ_FIND_SALAZAR");
  level.obj_find_menen = maps\_objectives::register_objective(&"BLACKOUT_OBJ_FIND_MENEN");
  level.obj_stop_menen = maps\_objectives::register_objective(&"BLACKOUT_OBJ_STOP_MENEN");
  level.obj_evac = maps\_objectives::register_objective(&"BLACKOUT_OBJ_EVAC");
  level.obj_breadcrumb = maps\_objectives::register_objective(&"");
  level.obj_enter = maps\_objectives::register_objective(&"");
  level.obj_interact = maps\_objectives::register_objective(&"");
  level.obj_follow = maps\_objectives::register_objective(&"");
  level thread maps\_objectives::objectives();
}

setup_challenge() {
  self thread maps\_challenges_sp::register_challenge("nodeath", ::nodeath_challenge);
  self thread maps\_challenges_sp::register_challenge("masonroom", ::masonroom_challenge);
  self thread maps\_challenges_sp::register_challenge("turretkills", ::challenge_turret_kills);
  self thread maps\_challenges_sp::register_challenge("saveseals", ::challenge_seals);
  self thread maps\_challenges_sp::register_challenge("electrocutions", ::challenge_electrocutions);
  self thread maps\_challenges_sp::register_challenge("turretoneshot", ::challenge_turret_oneshot);
  self thread maps\_challenges_sp::register_challenge("gaskills", ::challenge_jetpack_kills);
  self thread maps\_challenges_sp::register_challenge("brutekills", ::challenge_brutekills);
  self thread maps\_challenges_sp::register_challenge("vtoltimer", ::vtol_challenge);
}

challenge_turret_kills(str_notify) {
  while(true) {
    level waittill("player_performed_kill", str_team, str_weapon);

    if(str_weapon == "cic_turret" && str_team == "axis")
      self notify(str_notify);
  }
}

challenge_seals(str_notify) {
  while(true) {
    level waittill("seal_overwatch_complete");
    self notify(str_notify);
  }
}

challenge_electrocutions(str_notify) {
  while(true) {
    level waittill("player_performed_kill", str_team, str_weapon);

    if(str_weapon == "tazer_knuckles_sp" && str_team == "axis")
      self notify(str_notify);
  }
}

challenge_turret_oneshot(str_notify) {
  vehicles = getentarray("script_vehicle", "classname");

  foreach(veh in vehicles) {
    if(veh.vehicletype == "turret_cic")
      veh thread challenge_turret_stun_think();
  }

  add_spawn_function_veh_by_type("turret_cic", ::challenge_turret_stun_think);

  while(true) {
    level waittill("turret_stun_kill");
    self notify(str_notify);
  }
}

challenge_turret_stun_think() {
  self waittill("death");

  if(isDefined(self.emped) && self.emped)
    level notify("turret_stun_kill");
}

challenge_jetpack_kills(str_notify) {
  while(true) {
    level waittill("jetpack_guy_killed_midair");
    self notify(str_notify);
  }
}

challenge_brutekills(str_notify) {
  flag_wait("player_used_brute_force");

  while(true) {
    level waittill("brute_kill");
    self notify(str_notify);
  }
}

nodeath_challenge(str_notify) {
  level.player waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

masonroom_challenge(str_notify) {
  level waittill("masons_personal_effects_found");
  self notify(str_notify);
}

vtol_challenge(str_notify) {
  level waittill("start_vtol_timer");

  for(n_timer = 90; n_timer > 0 && !flag("player_boarded_vtol"); n_timer--)
    wait 1;

  if(flag("player_boarded_vtol") && n_timer > 0)
    self notify(str_notify);
}