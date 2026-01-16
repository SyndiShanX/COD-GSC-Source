/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_skipto;
#include maps\karma_util;
#include maps\yemen_wounded;
#include maps\karma_2_fx;
#include maps\_metal_storm;
#include maps\_rusher;
#include maps\_load;
#include maps\karma_2_amb;
#include maps\karma_2_anim;
#include maps\_heatseekingmissile;
#include maps\_drones;
#include maps\karma_civilians;
#include maps\_civilians;
#include maps\createart\karma_2_art;
#include maps\_swimming;
#include maps\_challenges_sp;
#include maps\karma_exit_club;
#include maps\karma_enter_mall;
#include maps\karma_little_bird;
#include maps\karma_the_end;
#include maps\_vehicle;
#include animscripts\anims;

main() {
  level.createfx_callback_thread = ::createfx_setup;
  level.supportsvomitingdeaths = 1;
  level thread setup_threat_bias_groups();
  maps\karma_2_fx::main();
  maps\_metal_storm::init();
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  maps\_rusher::init_rusher();
  maps\_load::main();
  init_spawn_funcs();
  maps\karma_2_amb::main();
  maps\karma_2_anim::main();
  maps\_heatseekingmissile::init();
  level.e_extra_cam = getent("endgame_extra_cam", "targetname");
  onplayerconnect_callback(::on_player_connect);
  level thread maps\_drones::init();
  level thread maps\karma_civilians::civ_init();
  maps\_civilians::init_civilians();
  level thread maps\createart\karma_2_art::main();
  maps\_swimming::main();
  setsaveddvar("phys_ragdoll_buoyancy", 1);
  level.overrideactorkilled = ::override_actor_killed;
  maps\yemen_wounded::set_wounded_auto_delete(20);
  setailimit(22);
  level thread brute_force_perk();
  level thread kill_behind_player();
  level thread show_geo_models_trigger();
  level thread deconstruct_models();
}

on_player_connect() {
  level thread battlechatter_on();
  self thread setup_challenge();
  self thread maps\createart\karma_2_art::vision_set_change("sp_karma2_clubexit");
  run_thread_on_targetname("vision_trigger", maps\createart\karma_2_art::vision_set_trigger_think);
  self setclientdvar("cg_aggressiveCullRadius", 100);
}

setup_challenge() {
  self thread maps\_challenges_sp::register_challenge("specialvisionkills", ::special_vision_kills_challenge);
  self thread maps\_challenges_sp::register_challenge("hurtciv", ::no_killing_civ);
  self thread maps\_challenges_sp::register_challenge("nodeath", ::karma_no_death_challenge);
  self thread maps\_challenges_sp::register_challenge("killrappellingenemies", ::rappel_kills_challenge);
  self thread maps\_challenges_sp::register_challenge("electrocutions", ::challenge_electrocutions);
  self thread maps\_challenges_sp::register_challenge("asdalive", ::keep_asd_alive_challenge);
}

level_precache() {
  precacheitem("flash_grenade_sp");
  precachemodel("anim_glo_bullet_tip");
  precachemodel("test_p_anim_specialty_lockbreaker_device");
  precachemodel("test_p_anim_specialty_lockbreaker_padlock");
  precachemodel("test_p_anim_specialty_trespasser_card_swipe");
  precachemodel("test_p_anim_specialty_trespasser_device");
  precachemodel("test_p_anim_karma_toolbox");
  precachemodel("test_p_anim_karma_briefcase");
  precachemodel("com_clipboard_mocap");
  precachemodel("t6_wpn_jaws_of_life_prop");
  precachemodel("t6_wpn_laser_cutter_prop");
  precachemodel("t6_wpn_launch_fhj18_world");
  precachemodel("p6_anim_cell_phone");
  precachemodel("dest_aquarium_glass_karma");
  precachemodel("c_usa_cia_masonjr_viewhands");
  precachemodel("c_usa_unioninsp_harper_scar_cin_fb");
  precachemodel("p_glo_bullet_tip");
  precacheitem("tazer_knuckles_sp");
  precacheitem("usrpg_player_sp");
  precacheitem("ballista_karma_sp");
  precacheitem("fhj18_dpad_sp");
  precacheitem("sa58_sp");
  precacheshellshock("concussion_grenade_mp");
  precachestring(&"KARMA_MSG_ASD_SYNC");
  precachestring(&"karma_pip_security_feed");
  precachestring(&"karma_pip_exiting_the_mall");
  precachestring(&"karma_pip_stairs");
  precachestring(&"karma_pip_helipad");
  precachestring(&"karma_pip_helipad_v2");
  precachemodel("veh_iw_air_osprey_fly");
  maps\karma_civilians::civ_precache();
}

init_flags() {
  flag_init("holster_weapons");
  flag_init("draw_weapons");
  flag_init("player_among_civilians");
  flag_init("player_act_normally");
  flag_init("trespasser_reward_enabled");
  flag_init("e10_player_raise_gun");
  flag_init("e10_close_vtol_door");
  flag_init("close_sundeck_door");
  maps\karma_exit_club::init_flags();
  maps\karma_enter_mall::init_flags();
  maps\karma_little_bird::init_flags();
  maps\karma_the_end::init_flags();
}

init_spawn_funcs() {
  add_global_spawn_function("axis", ::turn_on_enemy_highlight);
  add_global_spawn_function("axis", ::spawn_func_follow_path);
  add_global_spawn_function("axis", ::global_axis_settings);
  add_global_spawn_function("neutral", ::spawn_func_follow_path);
  add_global_spawn_function("neutral", ::global_neutral_settings);
  add_global_spawn_function("allies", ::spawn_func_follow_path);
  add_global_drone_spawn_function("neutral", ::auto_delete_with_ref);
  sp = getent("defalco", "targetname");
  sp add_spawn_function(::spawn_func_defalco);
  sp = getent("harper", "targetname");
  sp add_spawn_function(::spawn_func_harper);
  sp = getent("salazar", "targetname");
  sp add_spawn_function(::spawn_func_salazar);
  add_spawn_function_veh_by_type("heli_blackhawk_stealth_axis", ::spawn_func_helicopter);
  add_spawn_function_veh_by_type("drone_metalstorm_karma", ::spawn_func_asd);
  add_spawn_function_veh("defalco_osprey", ::init_defalco_osprey);
  maps\karma_exit_club::init_spawn_funcs();
  maps\karma_enter_mall::init_spawn_funcs();
  maps\karma_little_bird::init_spawn_funcs();
  maps\karma_the_end::init_spawn_funcs();
}

global_axis_settings() {
  self.pathenemyfightdist = 64;
  self.canflank = 1;
  self.a.neversprintforvariation = 1;
}

init_defalco_osprey() {
  self.a_crash_zones = getstructarray("defalco_crash_zone", "script_noteworthy");
}

spawn_func_follow_path() {
  self endon("death");

  if(!isDefined(self.script_string) && !isDefined("follow_path") || isDefined(self.script_string) && isDefined("follow_path") && self.script_string == "follow_path") {
    a_nodes = getnodearray(self.target, "targetname");
    follow_path(random(a_nodes));

    if(self.team == "neutral") {
      self thread auto_delete_with_ref();
      self thread civ_idle();
    }
  }

  if(self.team == "neutral") {
    self waittill("follow_path_end");
    self thread auto_delete_with_ref();
    self thread civ_idle();
  }
}

setup_skiptos() {
  add_skipto("dev_loading movie 1", maps\karma_exit_club::skipto_loading_movie_1, "loading movie 1", maps\karma_exit_club::loading_movie_1_main);
  add_skipto("dev_loading movie 2", maps\karma_exit_club::skipto_loading_movie_2, "loading movie 2", maps\karma_exit_club::loading_movie_2_main);
  add_skipto("arrival", ::skipto_karma);
  add_skipto("checkin", ::skipto_karma);
  add_skipto("dropdown", ::skipto_karma);
  add_skipto("dropdown2", ::skipto_karma);
  add_skipto("spiderbot", ::skipto_karma);
  add_skipto("gulliver", ::skipto_karma);
  add_skipto("crc", ::skipto_karma);
  add_skipto("construction", ::skipto_karma);
  add_skipto("club solar", ::skipto_karma);
  add_skipto("inner solar", ::skipto_karma);
  add_skipto("solar fight", ::skipto_karma);
  add_skipto("club exit", maps\karma_exit_club::skipto_club_exit, "club exit", maps\karma_exit_club::main);
  add_skipto("mall", maps\karma_enter_mall::skipto_mall, "mall", maps\karma_enter_mall::main);
  add_skipto("sundeck", maps\karma_little_bird::skipto_sundeck, "sundeck", maps\karma_little_bird::main);
  add_skipto("confrontation", maps\karma_the_end::skipto_confrontation, "confrontation", maps\karma_the_end::main);
  add_skipto("getaway", maps\karma_the_end::skipto_getaway, "getaway", maps\karma_the_end::main);
  default_skipto("club exit");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_karma() {
  adddebugcommand("devmap karma");
}

load_gumps_karma() {
  screen_fade_out(0);

  if(is_after_skipto("mall"))
    load_gump("karma_2_gump_sundeck");
  else
    load_gump("karma_2_gump_mall");

  screen_fade_in(0);
}

skipto_cleanup() {
  skipto = level.skipto_point;
  load_gumps_karma();

  if(skipto == "club exit")
    screen_fade_out(0);

  skip_objective(level.obj_security);
  skip_objective(level.obj_enter_crc);
  skip_objective(level.obj_id_karma);
  skip_objective(level.obj_meet_karma);
  set_level_goal("ref_delete_club_exit");

  if(skipto == "club exit") {
    return;
  }
  set_level_goal("ref_delete_mall");

  if(skipto == "mall") {
    return;
  }
  set_level_goal("ref_delete_sundeck");
  flag_set("exit_club_cleanup");
  flag_set("entering_sundeck");
  flag_set("entering_aquarium_room");

  if(skipto == "sundeck") {
    return;
  }
  flag_set("close_sundeck_door");
  maps\_vehicle::spawn_vehicle_from_targetname("defalco_osprey");
}

setup_threat_bias_groups() {
  createthreatbiasgroup("navy_seals");
  createthreatbiasgroup("tacitus");
  createthreatbiasgroup("ship_security");
  createthreatbiasgroup("ship_drones");
  createthreatbiasgroup("civilians");
  setthreatbias("ship_security", "tacitus", 1500);
  setthreatbias("ship_drones", "tacitus", 1500);
  setthreatbias("navy_seals", "tacitus", 1500);
  setthreatbias("civilians", "tacitus", 50);
  setthreatbias("tacitus", "ship_security", 1500);
  setthreatbias("navy_seals", "ship_security", -1500);
  setthreatbias("civilians", "ship_security", -1500);
  setthreatbias("tacitus", "ship_drones", 1500);
  setthreatbias("navy_seals", "ship_drones", 1500);
  setthreatbias("civilians", "ship_drones", -1500);
  setthreatbias("tacitus", "navy_seals", 1500);
  setthreatbias("ship_drones", "navy_seals", 1500);
  setthreatbias("ship_security", "navy_seals", -1500);
  setthreatbias("civilians", "navy_seals", -1500);
  flag_wait("level.player");
  level.player setthreatbiasgroup("navy_seals");
}

deconstruct_models() {
  model_convert_areas();
  add_flag_function("entering_sundeck", ::model_restore_area, "sundeck");
  level thread fxanim_destruct_until_flag("fxanim_aquarium_pillar", "entering_aquarium_room");
  level thread fxanim_destruct_until_flag("fxanim_column_explode", "entering_sundeck");
  add_flag_function("exit_club_cleanup", ::wipe_volume, "cleanup_volume_exit_club");
  add_flag_function("close_sundeck_door", ::wipe_volume, "cleanup_volume_mall");
}

attach_phone() {
  self attach("p6_anim_cell_phone", "tag_weapon_left");
}

spawn_func_harper() {
  level.ai_harper = self;
  flag_wait("level.player");

  if(level.player get_story_stat("HARPER_SCARRED"))
    self setmodel("c_usa_unioninsp_harper_scar_cin_fb");
}

spawn_func_salazar() {
  level.ai_salazar = self;
}

spawn_func_defalco() {
  level.ai_defalco = self;
}

#using_animtree("generic_human");

global_neutral_settings() {
  self.goalradius = 50;
  self.nododgemove = 1;
  self pushplayer(0);
  self.pathenemyfightdist = 0;
  self.usecombatscriptatcover = 1;
  a_cower_anims = array( % ai_civ_cower_idle_01, % ai_civ_cower_idle_02, % ai_civ_cower_idle_03, % ai_civ_cower_idle_04, % ai_civ_cower_idle_05);
  self animscripts\anims::setidleanimoverride(random(a_cower_anims));
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["straight_level"] = % ai_civ_m_idle_stand_cower_01_aim;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["exposed_idle"] = array( % ai_civ_m_idle_stand_cower_01_additive);
  self.anim_array[self.animtype]["move"]["stand"]["none"]["tactical_walk_f"] = % civilian_run_hunched_a;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["tactical_walk_r"] = % civilian_run_hunched_a;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["tactical_walk_l"] = % civilian_run_hunched_a;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["tactical_walk_b"] = % civilian_run_hunched_a;
}