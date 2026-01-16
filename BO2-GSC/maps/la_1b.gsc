/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1b.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\la_utility;
#include maps\la_1b_util;
#include maps\la_1b_fx;
#include maps\_quadrotor;
#include maps\la_1b_anim;
#include maps\_load;
#include maps\la_1b_amb;
#include maps\createart\la_1b_art;
#include maps\_rusher;
#include maps\_lockonmissileturret;
#include maps\_fxanim;
#include maps\la_plaza;
#include maps\_turret;
#include maps\_fire_direction;
#include maps\la_street;
#include maps\la_intersection;

main() {
  maps\la_1b_fx::main();
  maps\_quadrotor::init();
  visionsetnaked("la_1");
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  level.supportspistolanimations = 1;
  level.vehiclespawncallbackthread = ::global_vehicle_spawn_func;
  level.ignoreneutralfriendlyfire = 1;
  init_vehicles();
  maps\la_1b_anim::main();
  maps\_load::main();
  maps\la_1b_amb::main();
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_nophysics", ::manage_plaza_truck);
  onplayerconnect_callback(::on_player_connect);
  level thread maps\createart\la_1b_art::main();
  maps\_rusher::init_rusher();
  maps\_lockonmissileturret::init(0, undefined, 6);
  level thread objectives();
  level.veh_roof_sam = spawn_vehicle_from_targetname("intruder_sam");
  setdvar("footstep_sounds_cutoff", 8000);
  setsaveddvar("cg_aggressiveCullRadius", "100");
  level thread do_eye();
  level thread la_1b_fxanim_deconstruct();
}

do_eye() {
  setsaveddvar("r_stereo3DEyeSeparationScaler", 0.333333);
  wait 30;

  for(val = 0.2; val <= 0.6; val = val + 0.1) {
    setsaveddvar("r_stereo3DEyeSeparationScaler", val / 0.6);
    wait 0.1;
  }
}

player_give_grenades() {
  flag_wait("level.player");
  level.player giveweapon("frag_grenade_future_sp");
}

la_1b_fxanim_deconstruct() {
  maps\_fxanim::fxanim_deconstruct("f35_walkway");
  maps\_fxanim::fxanim_deconstruct("f35_tower_01");
  maps\_fxanim::fxanim_deconstruct("f35_tower_02");
  maps\_fxanim::fxanim_deconstruct("f35_env_stay");
  maps\_fxanim::fxanim_deconstruct("fxanim_bldg_convoy_block");
  maps\_fxanim::fxanim_deconstruct("fxanim_spire_collapse");
  maps\_fxanim::fxanim_deconstruct("f35_column");
  model_convert_areas();
  flag_wait("bdog_front_dead_friendlies_moved");
  maps\_fxanim::fxanim_reconstruct("f35_walkway");
  maps\_fxanim::fxanim_reconstruct("f35_column");
  maps\_fxanim::fxanim_reconstruct("f35_tower_01");
  maps\_fxanim::fxanim_reconstruct("f35_tower_02");
  maps\_fxanim::fxanim_reconstruct("f35_env_stay");
  flag_wait("intersection_started");
  model_restore_area("intersection");
  maps\_fxanim::fxanim_reconstruct("fxanim_spire_collapse");
  maps\_fxanim::fxanim_reconstruct("fxanim_bldg_convoy_block");
}

load_roof_gump() {
  while(true) {
    trigger_wait("load_roof_gump");
    maps\la_plaza::cleanup_street();
    spawn_roof_sam();
    trigger_wait("load_plaza_gump");

    if(isDefined(level.veh_roof_sam))
      level.veh_roof_sam delete();

    wait 0.25;
    level thread load_gump("la_1b_gump_1");
  }
}

spawn_roof_sam() {
  level endon("flushing_la_1b_gump_3");
  load_gump("la_1b_gump_3");
  wait 0.25;
  level.veh_roof_sam = spawn_vehicle_from_targetname("intruder_sam");
}

on_player_connect() {
  level_settings();
  setsaveddvar("aim_target_fixed_actor_size", 1);
}

level_settings() {
  level thread setup_story_states();
}

manage_plaza_truck() {
  self endon("death");
  self maps\_turret::set_turret_burst_parameters(3, 4.5, 1, 1.5, 1);
}

init_vehicles() {
  a_script_models = getentarray("script_model", "classname");
  a_vehicles = arraycombine(a_script_models, getentarray("script_vehicle", "classname"), 0, 0);

  foreach(veh in a_vehicles)
  global_vehicle_spawn_func(veh);
}

global_vehicle_spawn_func(veh) {
  if(is_police_car(veh))
    veh thread police_car();
  else if(is_police_motorcycle(veh))
    veh thread police_motorcycle();
}

level_precache() {
  precachemodel("c_usa_cia_combat_harper_head_scar");
  precacheitem("frag_grenade_future_sp");
  precacheitem("frag_grenade_sonar_sp");
  precacheitem("usrpg_player_sp");
  precacheitem("usrpg_magic_bullet_sp");
  precacheitem("quadrotor_turret_explosive");
  precacheitem("qcw05_sp");
  precacheshellshock("khe_sanh_woods_verb");
  precachestring(&"la_pip_seq_1");
  precachestring(&"la_pip_seq_2");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachemodel("veh_t6_air_fa38_landing_gear");
  precachemodel("veh_t6_civ_18wheeler_trailer_props");
  precachemodel("t6_wpn_special_storm_world");
  precachemodel("veh_t6_drone_avenger_x2");
  precachemodel("veh_t6_police_car_destroyed");
  precachemodel("veh_t6_mil_cougar_low_dead");
  precacherumble("la_1b_building_collapse");
  precacherumble("flyby");
  maps\_fire_direction::precache();
}

setup_skiptos() {
  add_skipto("intro", ::skipto_la_1);
  add_skipto("after_the_attack", ::skipto_la_1);
  add_skipto("sam", ::skipto_la_1);
  add_skipto("cougar_fall", ::skipto_la_1);
  add_skipto("sniper_rappel", ::skipto_la_1);
  add_skipto("g20_group1", ::skipto_la_1);
  add_skipto("drive", ::skipto_la_1);
  add_skipto("skyline", ::skipto_la_1);
  add_skipto("street", maps\la_street::skipto_street, & "SKIPTO_STRING_HERE", maps\la_street::main);
  add_skipto("plaza", maps\la_plaza::skipto_plaza, & "SKIPTO_STRING_HERE", maps\la_plaza::main);
  add_skipto("intersection", maps\la_intersection::skipto_intersection, & "SKIPTO_STRING_HERE", maps\la_intersection::main);
  add_skipto("f35_wakeup", ::skipto_la_2);
  add_skipto("f35_boarding", ::skipto_la_2);
  add_skipto("f35_flying", ::skipto_la_2);
  add_skipto("f35_ground_targets", ::skipto_la_2);
  add_skipto("f35_pacing", ::skipto_la_2);
  add_skipto("f35_rooftops", ::skipto_la_2);
  add_skipto("f35_dogfights", ::skipto_la_2);
  add_skipto("f35_trenchrun", ::skipto_la_2);
  add_skipto("f35_hotel", ::skipto_la_2);
  add_skipto("f35_eject", ::skipto_la_2);
  add_skipto("f35_outro", ::skipto_la_2);
  default_skipto("street");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_la_1() {
  changelevel("la_1", 1);
}

skipto_la_2() {
  changelevel("la_2", 1);
}