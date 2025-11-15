/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_skipto;
#include maps\_camo_suit;
#include maps\_scene;
#include maps\yemen_wounded;
#include maps\yemen_fx;
#include maps\_quadrotor;
#include maps\_metal_storm;
#include maps\_cic_turret;
#include maps\createart\yemen_art;
#include maps\_heatseekingmissile;
#include maps\_load;
#include maps\_drones;
#include maps\yemen_amb;
#include maps\yemen_anim;
#include maps\_fxanim;
#include maps\_fire_direction;
#include maps\yemen_speech;
#include maps\yemen_market;
#include maps\yemen_terrorist_hunt;
#include maps\yemen_metal_storms;
#include maps\yemen_morals;
#include maps\yemen_morals_rail;
#include maps\yemen_drone_control;
#include maps\yemen_hijacked;
#include maps\yemen_capture;
#include maps\yemen_utility;
#include maps\_challenges_sp;

main() {
  level.createfx_callback_thread = ::createfx_setup;
  maps\yemen_fx::main();
  maps\_quadrotor::init();
  maps\_metal_storm::init();
  maps\_cic_turret::init();
  setup_objectives();
  level thread maps\_objectives::objectives();
  level_precache();
  level_init_flags();
  setup_skiptos();
  level thread maps\createart\yemen_art::main();
  level thread maps\_heatseekingmissile::init();
  maps\_load::main();
  setup_level();
  level thread maps\_drones::init();
  maps\yemen_fx::main();
  maps\yemen_amb::main();
  maps\yemen_anim::main();
  onplayerconnect_callback(::on_player_connect);
  setsaveddvar("r_skyTransition", 0);
  setsaveddvar("g_destructibleCutoffDistance", 1600);
  setsaveddvar("cg_aggressiveCullRadius", "100");
  level thread art_ent_optimization();
}

art_ent_optimization() {
  maps\_fxanim::fxanim_deconstruct("fxanim_seagulls_circling");
  maps\_fxanim::fxanim_deconstruct("fxanim_drone_control_canopies");
}

on_player_connect() {
  level.player = get_players()[0];
  self thread setup_challenge();
  setsaveddvar("wind_global_vector", "300 200 0");
  setsaveddvar("wind_global_low_altitude", 5000);
  setsaveddvar("wind_global_hi_altitude", 10000);
  setsaveddvar("wind_global_low_strength_percent", 0.7);
  setsaveddvar("g_destructibleCutoffDistance", 1600);
  setsaveddvar("aim_target_fixed_actor_size", 1);
}

autoexec _brute_force_perk() {
  trigger_off("use_bruteforce", "targetname");
  flag_wait("player_has_bruteforce");
  trigger_on("use_bruteforce", "targetname");
  t_bruteforce = getent("use_bruteforce", "targetname");
  t_bruteforce sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  t_bruteforce setcursorhint("HINT_NOICON");
  set_objective_perk(level.obj_bruteforce, t_bruteforce.origin);
  trigger_wait("use_bruteforce");
  remove_objective_perk(level.obj_bruteforce);
  run_scene_and_delete("bruteforce_perk");
  level.player giveweapon("pulwar_sword_sp");
}

level_precache() {
  precacheitem("usrpg_magic_bullet_sp");
  precacheitem("usrpg_player_sp");
  precacheitem("fhj18_sp");
  precacheitem("pulwar_sword_sp");
  precachemodel("c_mul_cordis_drone1_1_fb");
  precachemodel("c_mul_cordis_drone1_2_fb");
  precachemodel("c_mul_cordis_drone1_3_fb");
  precachemodel("c_mul_cordis_drone1_4_fb");
  precachemodel("c_mul_cordis_drone1_5_fb");
  precachemodel("c_mul_cordis_drone2_1_fb");
  precachemodel("c_mul_cordis_drone2_2_fb");
  precachemodel("c_mul_cordis_drone2_3_fb");
  precachemodel("c_mul_cordis_drone2_4_fb");
  precachemodel("c_mul_cordis_drone2_5_fb");
  precachemodel("c_mul_cordis_drone3_1_fb");
  precachemodel("c_mul_cordis_drone3_2_fb");
  precachemodel("c_mul_cordis_drone3_3_fb");
  precachemodel("c_mul_cordis_drone3_4_fb");
  precachemodel("c_mul_cordis_drone3_5_fb");
  precachemodel("c_usa_cia_combat_harper_head_scar");
  precachemodel("c_mul_yemen_farid_viewbody_bloody");
  precachemodel("c_usa_cia_combat_harper_head_scar_shot");
  precachemodel("c_usa_cia_combat_harper_head_shot");
  precachemodel("c_mul_cordis_head1_2_bld");
  precachemodel("c_mul_cordis_head4_3_bld");
  precachemodel("anim_jun_ammo_box");
  precachemodel("p6_street_vendor_goods_table02");
  precachemodel("t6_wpn_pistol_m1911_view");
  precachemodel("t6_wpn_pistol_judge_world");
  precachemodel("t6_wpn_ar_an94_world");
  precachemodel("iw_proj_sidewinder_missile_x2");
  precachemodel("t6_wpn_pistol_fiveseven_prop");
  precachemodel("t6_wpn_launch_fhj18_prop_world");
  precachemodel("veh_t6_air_v78_vtol_burned");
  precachemodel("projectile_at4");
  precachemodel("fxanim_war_sing_rappel_rope_01_mod");
  precachemodel("p6_anim_wooden_door_slats");
  precachemodel("t6_wpn_jaws_of_life_prop");
  precachemodel("t6_wpn_pulwar_sword_prop");
  precacherumble("heartbeat");
  precacherumble("heartbeat_low");
  precacherumble("crash_heli_rumble");
  precachemodel("c_usa_cia_masonjr_viewhands");
  precachemodel("c_usa_cia_masonjr_viewhands_cl");
  precachemodel("c_usa_cia_masonjr_viewbody");
  precachemodel("c_usa_cia_masonjr_armlaunch_viewhands");
  precachestring(&"yemen_men_ally");
  precachestring(&"yemen_drone_cam");
  precachestring(&"yemen_mendz");
  precacheshader("overlay_harper_blood");
  precachestring(&"SCRIPT_FIRE_DIRECTION");
  precachestring(&"SCRIPT_FIRE_DIRECTION_CONFIRM");
  maps\_fire_direction::precache();
  maps\_camo_suit::precache();
}

level_init_flags() {
  flag_init("farid_not_undercover");
  maps\yemen_speech::init_flags();
  maps\yemen_market::init_flags();
  maps\yemen_terrorist_hunt::init_flags();
  maps\yemen_metal_storms::init_flags();
  maps\yemen_morals::init_flags();
  maps\yemen_morals_rail::init_flags();
  maps\yemen_drone_control::init_flags();
  maps\yemen_hijacked::init_flags();
  maps\yemen_capture::init_flags();
}

setup_level() {
  level.spawn_manager_max_frame_spawn = 1;
  level.spawn_manager_max_ai = 23;
  level.alerted_terrorists = [];
  maps\yemen_utility::teamswitch_threatbias_setup();
  maps\yemen_utility::temp_vtol_stop_and_rappel();
  add_spawn_function_group("morals_rail_terrorist", "script_noteworthy", ::watch_for_turret_kill);
  level thread maps\yemen_speech::init_spawn_funcs();
  level thread maps\yemen_market::init_spawn_funcs();
  level thread maps\yemen_morals_rail::init_spawn_funcs();
  level thread maps\yemen_drone_control::init_spawn_funcs();
  level thread maps\yemen_hijacked::init_spawn_funcs();
  maps\yemen_speech::init_doors();
}

load_story_stats() {
  dead_stat = level.player get_story_stat("DEFALCO_DEAD_IN_KARMA");
  level.is_defalco_alive = dead_stat;

  if(dead_stat == 0)
    level.is_defalco_alive = 1;
  else
    level.is_defalco_alive = 0;
}

setup_skiptos() {
  add_skipto("intro", maps\yemen_speech::skipto_intro, "Intro", maps\yemen_speech::intro_main);
  add_skipto("intro_nodefalco", maps\yemen_speech::skipto_intro_defalco_alive, "Intro_NoDefalco", maps\yemen_speech::intro_main);
  add_skipto("speech", maps\yemen_speech::skipto_speech, "Speech", maps\yemen_speech::speech_main);
  add_skipto("market", maps\yemen_market::skipto_market, "Market", maps\yemen_market::main);
  add_skipto("terrorist_hunt", maps\yemen_terrorist_hunt::skipto_terrorist_hunt, "Terrorist_Hunt", maps\yemen_terrorist_hunt::main);
  add_skipto("metal_storms", maps\yemen_metal_storms::skipto_metal_storms, "Metal_Storms", maps\yemen_metal_storms::main);
  add_skipto("morals", maps\yemen_morals::skipto_morals, "Morals", maps\yemen_morals::main);
  add_skipto("morals_rail", maps\yemen_morals_rail::skipto_morals_rail, "Morals_Rail", maps\yemen_morals_rail::main);
  add_skipto("morals_rail_skip", maps\yemen_morals_rail::skipto_morals_rail_skip, "Morals_Rail_Skip", maps\yemen_morals_rail::main);
  add_skipto("morals_rail_menendez", maps\yemen_morals_rail::skipto_morals_rail_menendez, "Morals_Rail_Menendez", maps\yemen_morals_rail::main);
  add_skipto("drone_control", maps\yemen_drone_control::skipto_drone_control, "Drone_Control", maps\yemen_drone_control::main);
  add_skipto("hijacked", maps\yemen_hijacked::skipto_hijacked, "Hijacked", maps\yemen_hijacked::main);
  add_skipto("hijacked_bridge", maps\yemen_hijacked::skipto_hijacked_bridge, "Hijacked_Bridge", maps\yemen_hijacked::main);
  add_skipto("hijacked_menendez", maps\yemen_hijacked::skipto_hijacked_menendez, "Hijacked_Menendez", maps\yemen_hijacked::main);
  add_skipto("capture", maps\yemen_capture::skipto_capture, "Capture", maps\yemen_capture::main);
  add_skipto("dev_drone_crash", maps\yemen_market::skipto_drone_crash, "Capture");
  add_skipto("dev_outro_vtol", maps\yemen_capture::skipto_outro_vtol, "Capture VTOL");
  default_skipto("intro");
  set_skipto_cleanup_func(::skipto_setup);
}

setup_objectives() {
  level.obj_speech = register_objective(&"YEMEN_OBJ_SPEECH");
  level.obj_market_meet_menendez = register_objective(&"YEMEN_OBJ_MEET_MENENDEZ");
  level.obj_interact = register_objective("");
  level.obj_bruteforce = register_objective("");
  level.obj_morals_rail = register_objective(&"YEMEN_OBJ_LZ");
  level.obj_drone_control_bridge = register_objective(&"YEMEN_OBJ_BRIDGE");
  level thread objectives_morals();
  level thread objectives_morals_rail();
  level thread objectives_morals_rail_skipped();
  level thread objectives_drone_control();
  level thread objectives_hijacked();
  level thread objectives_capture();
}

meet_menendez_objectives() {
  objective_breadcrumb(level.obj_market_meet_menendez, "market_end");
  objective_breadcrumb(level.obj_market_meet_menendez, "rockethall_objective_trigger");
  objective_breadcrumb(level.obj_market_meet_menendez, "street_end");
  s_metal_storms_meet = getstruct("obj_metalstorm_meet_manendez", "targetname");
  set_objective(level.obj_market_meet_menendez, s_metal_storms_meet, "breadcrumb");
}

objectives_morals() {
  trigger_wait("morals_at_menendez");
  set_objective(level.obj_market_meet_menendez, undefined, "done");
}

objectives_morals_rail() {
  flag_wait("morals_rail_start");
  set_objective(level.obj_morals_rail);
  flag_wait("drone_control_started");
  s_obj_gauntlet = getstruct("obj_drone_control");
  set_objective(level.obj_drone_control_bridge, level.salazar, "follow");
  set_objective(level.obj_morals_rail, undefined, "done");
}

objectives_morals_rail_skipped() {
  flag_wait("drone_control_started");
  s_obj_gauntlet = getstruct("obj_drone_control");
  set_objective(level.obj_drone_control_bridge, level.salazar, "follow");
}

objectives_drone_control() {
  flag_wait("drone_control_guantlet_started");
  s_obj_gauntlet = getstruct("obj_drone_control_guantlet");
  s_obj_alley = getstruct("obj_drone_control");
  set_objective(level.obj_drone_control_bridge, s_obj_alley, "remove");
  set_objective(level.obj_drone_control_bridge, s_obj_gauntlet, "breadcrumb");
  flag_wait("drone_control_farmhouse_started");
  s_obj_bridge = getstruct("obj_drone_control_bridge");
  set_objective(level.obj_drone_control_bridge, s_obj_gauntlet, "remove");
  set_objective(level.obj_drone_control_bridge, s_obj_bridge, "breadcrumb");
}

objectives_hijacked() {
}

objectives_capture() {
  flag_wait("obj_capture_sitrep");
  t_obj_capture_bc = getent("trig_obj_capture_bc", "targetname");
  s_obj_bridge = getstruct("obj_drone_control_bridge");
  set_objective(level.obj_drone_control_bridge, s_obj_bridge, "remove");
  set_objective(level.obj_drone_control_bridge, t_obj_capture_bc, "breadcrumb");
  trigger_wait("sm_capture_objective");
  s_capture_spot = getent("mission_sucess_trigger", "targetname");
  set_objective(level.obj_drone_control_bridge, t_obj_capture_bc, "remove");
  set_objective(level.obj_drone_control_bridge, s_capture_spot, "breadcrumb");
}

setup_challenge() {
  self thread maps\_challenges_sp::register_challenge("killdrones", ::killdrones_challenge);
  self thread maps\_challenges_sp::register_challenge("swordkills", ::swordkills_challenge);
  self thread maps\_challenges_sp::register_challenge("camomelee", ::camomelee_challenge);
  self thread maps\_challenges_sp::register_challenge("turretqrkills", ::turretqrkills_challenge);
  self thread maps\_challenges_sp::register_challenge("explodingvehicles", ::explodingvehicles_challenge);
  self thread maps\_challenges_sp::register_challenge("killasd", ::killasd_challenge);
  self thread maps\_challenges_sp::register_challenge("turretkills", ::turretkills_challenge);
  self thread maps\_challenges_sp::register_challenge("directquad", maps\yemen_drone_control::drone_kill_challenge);
  self thread maps\_challenges_sp::register_challenge("nodeath", ::nodeath_challenge);
}

nodeath_challenge(str_notify) {
  level.player waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

camomelee_challenge(str_notify) {
  self waittill("camo_suit_equipped");

  while(true) {
    self waittill("melee_kill");

    if(self ent_flag("camo_suit_on"))
      self notify(str_notify);
  }
}

swordkills_challenge(str_notify) {
  while(true) {
    self waittill("sword_kill");
    self notify(str_notify);
  }
}

watch_for_turret_kill() {
  self waittill("death", attacker, type, weapon);

  if(isplayer(attacker) && !flag("morals_rail_done"))
    level.player notify("turret_kill");
}

turretqrkills_challenge(str_notify) {
  flag_wait("metal_storms_start");
  add_spawn_function_veh_by_type("heli_quadrotor", maps\yemen_metal_storms::turretqrkills_death_listener, str_notify);
}

turretkills_challenge(str_notify) {
  while(true) {
    self waittill("turret_kill");
    self notify(str_notify);
  }
}

farid_undercover_damage_callback(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(!isDefined(e_attacker))
    return n_damage;

  if(!(isDefined(e_attacker.classname) && e_attacker.classname == "script_vehicle"))
    flag_set("farid_not_undercover");

  return n_damage;
}

killdrones_challenge(str_notify) {
  add_spawn_function_veh_by_type("heli_quadrotor", ::kill_drones_challenge_spawnfunc, str_notify);
}

kill_drones_challenge_spawnfunc(str_notify) {
  self waittill("death", attacker);

  if(isDefined(attacker) && attacker == level.player)
    level.player notify(str_notify);
}

pickingsides_challenge(str_notify) {
}

explodingvehicles_challenge(str_notify) {
  level.callbackactorkilled = ::track_ai_explodingvehicles_death;
  level.carkills = 0;

  while(level.carkills < 5)
    wait 0.05;

  self notify(str_notify);
}

track_ai_explodingvehicles_death(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(smeansofdeath == "MOD_EXPLOSIVE") {
    if(isDefined(einflictor) && isDefined(einflictor.destructibledef)) {
      if(isDefined(einflictor.destructiblecar) && einflictor.destructiblecar)
        level.carkills++;
    }
  }
}

killasd_challenge(str_notify) {
  flag_wait("metal_storms_start");
  add_spawn_function_veh_by_type("drone_metalstorm", maps\yemen_metal_storms::watch_asd_death);

  while(true) {
    level waittill("player_killed_asd");
    self notify(str_notify);
  }
}