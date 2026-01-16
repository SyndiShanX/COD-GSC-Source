/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_fxanim;
#include maps\_objectives;
#include maps\haiti_util;
#include animscripts\combat_utility;
#include maps\haiti_fx;
#include maps\haiti_anim;
#include maps\_cic_turret;
#include maps\_claw;
#include maps\_fire_direction;
#include maps\_metal_storm;
#include maps\_quadrotor;
#include maps\_load;
#include maps\haiti_amb;
#include maps\createart\haiti_art;
#include maps\_truck_gaztigr;
#include maps\haiti_intro;
#include maps\haiti_front_door;
#include maps\haiti_transmission;
#include maps\haiti_endings;
#include maps\_skipto;
#include maps\_challenges_sp;

main() {
  level.createfx_callback_thread = ::createfx_setup;
  maps\haiti_fx::main();
  maps\haiti_anim::main();
  maps\_cic_turret::init();
  maps\_claw::init();
  maps\_fire_direction::precache();
  maps\_fire_direction::rod_precache();
  maps\_metal_storm::init();
  maps\_quadrotor::init();
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  maps\_load::main();
  init_spawn_funcs();
  setmapcenter((-10392.8, 66916, 46519.9));
  maps\haiti_amb::main();
  onplayerconnect_callback(::on_player_connect);
  onsaverestored_callback(::on_save_restored);
  level thread maps\createart\haiti_art::main();
  maps\_truck_gaztigr::init();
  level.a_sp_actors["seal"] = getent("seal_assault", "targetname");
  level.a_sp_actors["seal_drone"] = getent("seal_drone", "targetname");
  level.a_sp_actors["sco"] = getent("sco_assault", "targetname");
  level.a_sp_actors["pmc"] = getent("pmc_assault", "targetname");
  level.overrideactorkilled = ::global_actor_killed_callback;
  a_m_clips = getentarray("compile_paths_clips", "targetname");

  foreach(m_clip in a_m_clips)
  m_clip delete();

  fxanim_deconstruct();
  model_convert_areas();
}

on_player_connect() {
  flag_wait("all_players_connected");
  level.player = get_players()[0];
  level.player setup_challenges();
  load_story_stats();
  setup_threat_bias_groups();
}

on_save_restored() {
  if(!flag("jetwing_done")) {
    wait_network_frame();
    luinotifyevent(&"hud_shrink_ammo", 0);
  }

  if(flag("fxanim_catwalk_collapse_delete"))
    clientnotify("unhide_debris");
}

level_precache() {
  precacheitem("haiti_missile_turret_sp");
  precacheitem("haiti_missile_turret_alt_sp");
  precacheitem("haiti_missile_turret_intro_sp");
  precacheshader("flamethrowerfx_color_distort_overlay_bloom");
  precachemodel("c_usa_cia_haiti_viewbody_vson");
  precachemodel("c_usa_seal6_flight_helmet_prop");
  precacheitem("usrpg_player_sp");
  precachemodel("veh_t6_air_fa38_low");
  precachemodel("p6_gods_rod_tablet_online");
  precachemodel("p6_claw_hoist");
  precacherumble("anim_light");
  precacherumble("anim_med");
  precacherumble("anim_heavy");
  precachestring(&"generalstore");
  precacheitem("flash_grenade_sp");
  precachemodel("c_usa_cia_quad_viewbody_vson");
  precachestring(&"hud_shrink_ammo");
  precachestring(&"hud_expand_ammo");
  precacheshellshock("default");
  precachemodel("p_glo_clipboard_wpaper");
  precacheitem("kard_nofirstraise_sp");
  precachemodel("t6_wpn_pistol_kard_world");
  precachemodel("t6_wpn_knife_base_prop");
  precachemodel("t6_wpn_pistol_fnp45_view");
  precachemodel("p_glo_clipboard_wpaper");
  precachemodel("c_mul_menendez_old_seal6_shot_head");
  precachemodel("rebar_anim_haiti");
  precachemodel("bandana_anim_haiti");
  precacheitem("quadrotor_turret_explosive");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"plane_jetwing_haiti");
  precachestring(&"hud_jetwing_alpha");
}

init_flags() {
  flag_init("squad_spawning");
  maps\haiti_intro::init_flags();
  maps\haiti_front_door::init_flags();
  maps\haiti_transmission::init_flags();
  maps\haiti_endings::init_flags();
}

init_spawn_funcs() {
  maps\haiti_intro::init_spawn_funcs();
  maps\haiti_front_door::init_spawn_funcs();
  maps\haiti_transmission::init_spawn_funcs();
  maps\haiti_endings::init_spawn_funcs();
}

setup_skiptos() {
  add_skipto("e1_test_harper_dead", maps\haiti_intro::skipto_intro_harper_dead, "INTRO", maps\haiti_intro::intro_main);
  add_skipto("e1_intro", maps\haiti_intro::skipto_intro, "INTRO", maps\haiti_intro::intro_main);
  add_skipto("e1_test_landing", maps\haiti_intro::skipto_landing, "LANDING", maps\haiti_intro::landing_main);
  add_skipto("e2_test_obama", maps\haiti_front_door::skipto_front_door_obama, "Greatest Hits - Support: Obama", maps\haiti_front_door::front_door_main);
  add_skipto("e2_test_sco", maps\haiti_front_door::skipto_front_door_sco, "Greatest Hits - Support: SCO", maps\haiti_front_door::front_door_main);
  add_skipto("e2_test_obama_sco", maps\haiti_front_door::skipto_front_door_obama_sco, "Greatest Hits - Support: Obama + SCO", maps\haiti_front_door::front_door_main);
  add_skipto("e2_test_no_support", maps\haiti_front_door::skipto_front_door_nothing, "Greatest Hits - Support: None", maps\haiti_front_door::front_door_main);
  add_skipto("e2_greatest_hits", maps\haiti_front_door::skipto_front_door, "Greatest Hits", maps\haiti_front_door::front_door_main);
  add_skipto("e2-2_top_of_ramp", maps\haiti_front_door::skipto_ramp_top, "Top of Ramp", maps\haiti_front_door::ramp_top_main);
  add_skipto("e2-3_main_entrance", maps\haiti_front_door::skipto_main_entrance, "Main Entrance", maps\haiti_front_door::main_entrance_main);
  add_skipto("e3_foyer", maps\haiti_transmission::skipto_foyer, "Reception", maps\haiti_transmission::foyer_main);
  add_skipto("e4-1_theater", maps\haiti_transmission::skipto_theater, "Big screen", maps\haiti_transmission::theater_main);
  add_skipto("e4-2_transmission", maps\haiti_transmission::skipto_transmission, "Transmission", maps\haiti_transmission::transmission_main);
  add_skipto("e4-3_its_a_trap", maps\haiti_transmission::skipto_its_a_trap, "It's a trap!", maps\haiti_transmission::its_a_trap_main);
  add_skipto("e5-1_find_menendez", maps\haiti_transmission::skipto_find_menendez, "Find Menendez", maps\haiti_transmission::find_menendez_main);
  add_skipto("e5-2_sliding_door", maps\haiti_transmission::skipto_celerium, "Sliding Door", maps\haiti_transmission::celerium_main);
  add_skipto("e6_d_alive_h_alive", maps\haiti_endings::skipto_endings_scenario1, "Scenario 1 - Defalco Alive and Harper Alive", maps\haiti_endings::endings_main);
  add_skipto("e6_d_alive_h_dead", maps\haiti_endings::skipto_endings_scenario2, "Scenario 2 - Defalco Alive and Harper Dead", maps\haiti_endings::endings_main);
  add_skipto("e6_d_dead_h_alive", maps\haiti_endings::skipto_endings_scenario3, "Scenario 3 - Defalco Dead and Harper Alive", maps\haiti_endings::endings_main);
  add_skipto("e6_d_dead_h_dead", maps\haiti_endings::skipto_endings_scenario4, "Scenario 4 - Defalco Dead and Harper Dead", maps\haiti_endings::endings_main);
  add_skipto("e6_endings", maps\haiti_endings::skipto_endings, "endings", maps\haiti_endings::endings_main);
  default_skipto("e1_intro");
  set_skipto_cleanup_func(::skipto_cleanup);
}

load_gumps() {
  if(maps\_skipto::is_after_skipto("e5-2_sliding_door"))
    load_gump("haiti_gump_hangar");
  else if(maps\_skipto::is_after_skipto("e3_foyer"))
    load_gump("haiti_gump_interior");
  else if(maps\_skipto::is_after_skipto("e1_intro"))
    load_gump("haiti_gump_front_door");
  else
    load_gump("haiti_gump_intro");
}

skipto_cleanup() {
  skipto = level.skipto_point;
  load_gumps();

  if(skipto == "e1_test_harper_dead") {
    return;
  }
  if(skipto == "e1_intro") {
    return;
  }
  cleanup_ents("cleanup_intro");
  level thread fxanim_delete_intro();
  skip_objective(level.obj_stop_transmission);

  if(skipto == "e1_test_landing") {
    return;
  }
  flag_set("jetwing_done");

  if(skipto == "e2_test_obama" || skipto == "e2_test_sco" || skipto == "e2_test_obama_sco" || skipto == "e2_test_no_support" || skipto == "e2_greatest_hits") {
    return;
  }
  flag_set("wall_smash");
  t_obj_main_entrance = getent("obj_main_entrance", "targetname");
  set_objective(level.obj_assault_builidng, t_obj_main_entrance);
  level thread intruder_perk();
  level thread bruteforce_perk();

  if(skipto == "e2-2_top_of_ramp") {
    return;
  }
  if(skipto == "e2-3_main_entrance") {
    return;
  }
  level thread front_door_cleanup();
  flag_set("main_entrance_start");

  if(skipto == "e3_foyer") {
    return;
  }
  set_objective(level.obj_assault_builidng, undefined, "done");
  flag_set("at_foyer_entrance");
  flag_set("close_outer_doors");
  flag_set("player_left_docks");
  t_obj_transmission = getent("obj_transmission", "targetname");
  set_objective(level.obj_goto_control_room, t_obj_transmission);

  if(skipto == "e4-1_theater") {
    return;
  }
  flag_set("theater_doors_open");

  if(skipto == "e4-2_transmission") {
    return;
  }
  set_objective(level.obj_goto_control_room, undefined, "delete");
  skip_objective(level.obj_stop_control);

  if(skipto == "e4-3_its_a_trap") {
    return;
  }
  flag_set("bomb_exploded");

  if(skipto == "e5-1_find_menendez") {
    return;
  }
  set_objective(level.obj_find_menendez);

  if(skipto == "e5-2_sliding_door") {
    return;
  }
  if(skipto == "e6_endings")
    return;
}

setup_objectives() {
  level.obj_stop_transmission = register_objective(&"HAITI_OBJ_STOP_TRANSMISSION");
  level.obj_avoid_collisions = register_objective(&"HAITI_OBJ_AVOID_COLLISIONS");
  level.obj_assault_builidng = register_objective(&"HAITI_OBJ_ASSAULT_BUILDING");
  level.obj_goto_control_room = register_objective(&"HAITI_OBJ_GOTO_CONTROL_ROOM");
  level.obj_stop_control = register_objective(&"HAITI_OBJ_STOP_CONTROL");
  level.obj_find_menendez = register_objective(&"HAITI_OBJ_FIND_MENENDEZ");
  level.obj_perk_intruder = register_objective(&"");
  level.obj_perk_brute_force = register_objective(&"");
  level.obj_perk_lockbreaker = register_objective(&"");
  level thread maps\_objectives::objectives();
}

load_story_stats() {
  level.is_obama_supporting = !level.player get_story_stat("BRIGGS_DEAD");
  level.is_sco_supporting = level.player get_story_stat("CHINA_IS_ALLY");
  level.is_defalco_alive = !level.player get_story_stat("DEFALCO_DEAD_IN_KARMA") && !level.player get_story_stat("DEFALCO_DEAD_IN_COMMAND_CENTER");
  level.is_harper_alive = !level.player get_story_stat("HARPER_DEAD_IN_YEMEN");
  level.is_harper_scarred = level.player get_story_stat("HARPER_SCARRED");
}

setup_threat_bias_groups() {
  createthreatbiasgroup("ally");
  createthreatbiasgroup("ally_priority");
  setthreatbias("ally_priority", "ally", 1500);
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("nodeath", ::nodeath_challenge);
  self thread maps\_challenges_sp::register_challenge("melee_camo", ::malee_camo_challenge);
  self thread maps\_challenges_sp::register_challenge("hotdog", ::avoid_missiles_challenge);
  self thread maps\_challenges_sp::register_challenge("sniperkill", ::sniper_challenge);
  self thread maps\_challenges_sp::register_challenge("kill_emp", ::killemp_challenge);
  self thread maps\_challenges_sp::register_challenge("asd_theater", maps\haiti_transmission::challenge_asd_theater);
  self thread maps\_challenges_sp::register_challenge("qrotor_kills", ::killclaw_challenge);
  self thread maps\_challenges_sp::register_challenge("kill_antiair", ::antiair_challenge);
  self thread maps\_challenges_sp::register_challenge("godrod_kill", ::godrod_challenge);
}

nodeath_challenge(str_notify) {
  level.player waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

malee_camo_challenge(str_notify) {
  while(true) {
    level waittill("player_melee_camo");
    self notify(str_notify);
  }
}

avoid_missiles_challenge(str_notify) {
  while(true) {
    level waittill("player_avoid_missiles");
    self notify(str_notify);
  }
}

sniper_challenge(str_notify) {
  while(true) {
    level waittill("sniper_challenge_shot");
    self notify(str_notify);
  }
}

global_actor_killed_callback(e_inflictor, e_attacker, n_damage, str_means_of_death, str_weapon, v_dir, str_hit_loc, timeoffset) {
  if(self.team == "axis") {
    if(isDefined(e_inflictor) && e_inflictor == level.player) {
      if(issniperrifle(str_weapon)) {
        if(distancesquared(level.player.origin, self.origin) > 2479990.0)
          level notify("sniper_challenge_shot");
      }
    }
  }
}

godrod_challenge(str_notify) {
  level.n_killcount = 0;

  while(true) {
    self waittill("missile_fire", e_projectile, str_weapon);

    if(str_weapon == "god_rod_sp") {
      a_living_enemies = getaiarray("axis");
      array_thread(a_living_enemies, ::challenge_godrod_think);
      wait 1;
      level notify("stop_godrod_challenge_watch");

      if(level.n_killcount >= 5) {
        self notify(str_notify);
        return;
      } else
        level.n_killcount = 0;
    }
  }
}

challenge_godrod_think() {
  level endon("stop_godrod_challenge_watch");
  self waittill("death", attacker, type, weapon);

  if(isDefined(weapon)) {
    if(weapon == "god_rod_sp")
      level.n_killcount++;
  }
}

killemp_challenge(str_notify) {
  add_spawn_function_veh_by_type("heli_quadrotor", ::kill_emp_challenge_spawnfunc, str_notify);
}

kill_emp_challenge_spawnfunc(str_notify) {
  self waittill("death", attacker);

  if(isDefined(self)) {
    if(self.vteam == "axis" && isDefined(self.emped)) {
      if(isDefined(attacker) && attacker == level.player)
        level.player notify(str_notify);
    }
  }
}

killclaw_challenge(str_notify) {
  while(true) {
    level waittill("quadrotors_kill_bigdog");
    self notify(str_notify);
  }
}

antiair_challenge(str_notify) {
  while(true) {
    level waittill("laser_turret_killed");
    self notify(str_notify);
  }
}

delete_ent(str_targetname) {
  a_m_to_delete = getentarray(str_targetname, "targetname");

  foreach(m_to_delete in a_m_to_delete)
  m_to_delete delete();
}

fxanim_deconstruct() {
  fxanim_deconstruct("fxanim_parachutes_ambient");
  fxanim_deconstruct("fxanim_apc_wall_divider");
  fxanim_deconstruct("fxanim_catwalk_collapse");
  fxanim_deconstruct("fxanim_stairwell_ceiling");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_01");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_02_left");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_02_right");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_03_left");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_03_right");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_04_left");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_04_right");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_05");
  fxanim_deconstruct("fxanim_ddm_ceiling");
  fxanim_deconstruct("fxanim_ceiling_collapse_gp_06");
  fxanim_deconstruct("fxanim_emergency_light");
  fxanim_deconstruct("fxanim_floor_collapse");
}

fxanim_delete_intro() {
  fxanim_delete("fxanim_intro");
}

fxanim_construct_front_door() {
  flag_wait("haiti_gump_front_door");
  fxanim_reconstruct("fxanim_parachutes_ambient");
  fxanim_reconstruct("fxanim_apc_wall_divider");
  fxanim_reconstruct("fxanim_catwalk_collapse");
}

fxanim_construct_interior() {
  flag_wait("haiti_gump_interior");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_01");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_02_left");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_02_right");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_03_left");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_03_right");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_04_left");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_04_right");
  fxanim_reconstruct("fxanim_stairwell_ceiling");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_05");
  fxanim_reconstruct("fxanim_ddm_ceiling");
  fxanim_reconstruct("fxanim_ceiling_collapse_gp_06");
}

fxanim_construct_hangar() {
  flag_wait("haiti_gump_hangar");
  fxanim_reconstruct("fxanim_emergency_light");
  fxanim_reconstruct("fxanim_floor_collapse");
}