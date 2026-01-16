/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\la_1_fx;
#include maps\la_1_anim;
#include maps\_load;
#include maps\_apc_cougar_ride;
#include maps\createart\la_1_art;
#include maps\_lockonmissileturret;
#include maps\la_1_amb;
#include maps\_objectives;
#include maps\_avenger;
#include maps\la_intro;
#include maps\la_sam;
#include maps\la_low_road;
#include maps\la_drive;
#include maps\_vehicle_death;

main() {
  level.createfx_callback_thread = ::createfx_setup;
  maps\la_1_fx::main();
  maps\la_1_anim::main();
  visionsetnaked("la_1");
  createthreatbiasgroup("potus");
  createthreatbiasgroup("potus_rushers");
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  setup_clips();
  level.ignoreneutralfriendlyfire = 1;
  maps\_load::main();
  maps\_apc_cougar_ride::init();
  onplayerconnect_callback(::on_player_connect);
  level thread maps\createart\la_1_art::main();
  level.callbackvehicledamage = ::la_1_vehicle_damage;
  level.vehiclespawncallbackthread = ::global_vehicle_spawn_func;
  maps\_lockonmissileturret::init(0, undefined, 6);
  setup_spawn_funcs();
  init_vehicles();
  maps\la_1_amb::main();
  level thread maps\_objectives::objectives();
  setsaveddvar("vehicle_sounds_cutoff", 30000);
  setdvar("footstep_sounds_cutoff", 3000);
  setsaveddvar("cg_aggressiveCullRadius", "100");
  battlechatter_on("allies");
  battlechatter_on("axis");
  cleanup();
}

setup_spawn_funcs() {
  add_spawn_function_veh_by_type("drone_avenger_fast", maps\_avenger::update_objective_model);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret", ::veh_brake_unload);
  add_spawn_function_veh_by_type("civ_pickup_red", ::veh_brake_unload);
  add_spawn_function_veh_by_type("plane_fa38_hero", ::f35_vtol_spawn_func);
  add_spawn_function_veh_by_type("civ_pickup_red", ::dont_free_vehicle);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret", ::dont_free_vehicle);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret", ::manage_vehicles_low_road);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_light", ::manage_vehicles_low_road);
  add_spawn_function_veh("flyby", ::spawn_func_scripted_flyby);
  add_spawn_function_veh("flyby", ::play_a_word);
}

play_a_word() {
  level.player playsound("evt_fake_f35_flyby");
  wait 0.8;
  level.player playsound("evt_fake_f35_flyby");
}

on_player_connect() {
  self thread sam_visionset();
  level_settings();
  hide_freeway_collapse();
  waittillframeend;
  self player_flag_wait("loadout_given");
  give_max_ammo_for_sniper_weapons();
}

level_settings() {
  self setclientdvar("cg_tracerSpeed", 20000);
  setsaveddvar("vehicle_collision_prediction_time", 0.3);
  level thread setup_story_states();
}

level_precache() {
  precachemodel("c_usa_cia_combat_harper_head_scar");
  precachemodel("veh_t6_mil_cougar_turret_sam");
  precachemodel("veh_t6_mil_cougar_destroyed_low");
  precachemodel("veh_t6_mil_cougar_low");
  precachemodel("veh_t6_mil_cougar_hood_obj");
  precachemodel("veh_t6_cougar_hatch_shadow");
  precachemodel("veh_t6_mil_cougar_door_obj");
  precachemodel("veh_t6_mil_cougar_interior_obj");
  precachemodel("veh_t6_air_blackhawk_stealth_dead");
  precachemodel("veh_t6_mil_cougar_interior");
  precachemodel("veh_t6_mil_cougar_interior_attachment");
  precachemodel("veh_t6_mil_cougar_interior_shadow");
  precachemodel("veh_t6_mil_cougar_interior_front");
  precachemodel("veh_t6_mil_cougar_hood_detail");
  precachemodel("fxanim_la_cougar_interior_static_mod");
  precachemodel("veh_t6_cougar_roof_decal");
  precachemodel("fxanim_gp_secret_serv_backpack_mod");
  precachemodel("fxanim_gp_secret_serv_gasmask_mod");
  precachemodel("p_jun_vc_ammo_crate");
  precachemodel("p_jun_vc_ammo_crate_open_single");
  precachemodel("c_usa_cia_masonjr_viewbody_vson");
  precachemodel("adrenaline_syringe_small_animated");
  precachemodel("jun_ammo_crate");
  precachemodel("com_ammo_pallet");
  precacheitem("usrpg_player_sp");
  precacheitem("usrpg_magic_bullet_sp");
  precacheitem("avenger_side_minigun_no_explosion");
  precacheitem("f35_missile_turret");
  precacheturret("sam_turret_sp");
  precacheshellshock("la_1_crash_exit");
  precacheshellshock("khe_sanh_woods_verb");
  precacheshellshock("la1b_crash_exit");
  precacherumble("la_1_fa38_intro_rumble");
  precacherumble("flyby");
  precacherumble("rappel_falling");
  precachemodel("veh_t6_drone_avenger_x2");
  precachemodel("veh_t6_drone_pegasus");

  if(isassetloaded("weapon", "riotshield_sp"))
    precacheitem("riotshield_sp");
}

setup_skiptos() {
  add_skipto("intro", maps\la_intro::skipto_intro, & "SKIPTO_STRING_HERE", maps\la_intro::main);
  add_skipto("after_the_attack", maps\la_sam::skipto_after_attack, & "SKIPTO_STRING_HERE", maps\la_sam::main);
  add_skipto("sam_jump", maps\la_sam::skipto_sam_jump, & "SKIPTO_STRING_HERE", maps\la_sam::main);
  add_skipto("sam", maps\la_sam::skipto_sam, & "SKIPTO_STRING_HERE", maps\la_sam::sam_main);
  add_skipto("cougar_fall", maps\la_sam::skipto_cougar_fall, & "SKIPTO_STRING_HERE", maps\la_sam::cougar_fall);
  add_skipto("sniper_rappel", maps\la_low_road::skipto_sniper_rappel, & "SKIPTO_STRING_HERE", maps\la_low_road::main);
  add_skipto("sniper_exit", maps\la_low_road::skipto_sniper_exit, & "SKIPTO_STRING_HERE", maps\la_low_road::last_stand_main);
  add_skipto("g20_group1", maps\la_low_road::skipto_g20, & "SKIPTO_STRING_HERE", maps\la_low_road::last_stand_main);
  add_skipto("drive", maps\la_drive::skipto_drive, & "SKIPTO_STRING_HERE", maps\la_drive::main);
  add_skipto("skyline", maps\la_drive::skipto_skyline, & "SKIPTO_STRING_HERE", maps\la_drive::main);
  add_skipto("street", ::skipto_la_1b);
  add_skipto("plaza", ::skipto_la_1b);
  add_skipto("intersection", ::skipto_la_1b);
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
  default_skipto("intro");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_la_1b() {
  changelevel("la_1b", 1);
}

skipto_la_2() {
  changelevel("la_2", 1);
}

sam_visionset() {
  self endon("death");

  while(true) {
    self waittill("missileTurret_on");
    self.lockonmissileturret thread maps\_vehicle_death::vehicle_damage_filter(undefined, 5, 1, 1);
    wait 0.05;
    clientnotify("sam_on");
    battlechatter_off("allies");
    battlechatter_off("axis");
    visionset = self getvisionsetnaked();
    self visionsetnaked("sam_turret", 0.5);

    if(!level.wiiu)
      cin_id = start3dcinematic("sam_gizmos_v2", 1, 1);

    self waittill("missileTurret_off");
    clientnotify("sam_off");

    if(!level.wiiu)
      stop3dcinematic(cin_id);

    battlechatter_on("allies");
    battlechatter_on("axis");
    self visionsetnaked(visionset, 0);
  }
}

sam_hint() {
  screen_message_create(&"LA_SHARED_SAM_HINT_ADS", & "LA_SHARED_SAM_HINT_FIRE");
  level waittill("sam_hint_drone_killed");
  screen_message_delete();
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
  else if(is_suv(veh) && (!isDefined(veh.script_animation) && !isDefined("open_suv_doors") || isDefined(veh.script_animation) && isDefined("open_suv_doors") && veh.script_animation == "open_suv_doors"))
    veh open_suv_doors();
}

cleanup() {
  getent("shadow_cougar", "targetname") delete();
  add_flag_function("rappel_option", ::cleanup_kvp, "cougarfalls_f35intro_car01", "targetname");
  add_flag_function("rappel_option", ::cleanup_kvp, "cougarfalls_f35intro_car02", "targetname");
  add_flag_function("rappel_option", ::cleanup_kvp, "cougarfalls_f35intro_van", "targetname");
  add_flag_function("sniper_option", ::cleanup_kvp, "cougarfalls_f35intro_car01", "targetname");
  add_flag_function("sniper_option", ::cleanup_kvp, "cougarfalls_f35intro_car02", "targetname");
  add_flag_function("sniper_option", ::cleanup_kvp, "cougarfalls_f35intro_van", "targetname");
  add_flag_function("player_driving", ::cleanup_kvp, "g20_group1_cougar2", "targetname");
  add_flag_function("player_driving", ::cleanup_kvp, "sam_cougar", "targetname");
  add_flag_function("player_driving", ::cleanup_kvp, "freeway_battle_vehicles", "script_noteworthy");
}

setup_clips() {
  t_clip = getent("clip_freeway_debris_pile", "targetname");
  t_clip trigger_off();
  t_clip connectpaths();
}