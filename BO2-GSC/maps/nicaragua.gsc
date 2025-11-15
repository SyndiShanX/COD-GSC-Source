/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\nicaragua_util;
#include maps\nicaragua_fx;
#include maps\nicaragua_anim;
#include maps\_load;
#include maps\_drones;
#include maps\_patrol;
#include maps\_rusher;
#include maps\_civilians;
#include maps\_mortarteam;
#include maps\nicaragua_amb;
#include maps\createart\nicaragua_art;
#include maps\_objectives;
#include maps\nicaragua_menendez_rage;
#include maps\nicaragua_intro;
#include maps\nicaragua_menendez_hill;
#include maps\nicaragua_menendez_execution;
#include maps\nicaragua_menendez_stables;
#include maps\nicaragua_menendez_to_mission;
#include maps\nicaragua_menendez_enter_mission;
#include maps\nicaragua_menendez_hallway;
#include maps\nicaragua_mason_intro;
#include maps\nicaragua_mason_hill;
#include maps\nicaragua_mason_truck;
#include maps\nicaragua_mason_donkeykong;
#include maps\nicaragua_mason_woods_freakout;
#include maps\nicaragua_mason_to_mission;
#include maps\nicaragua_mason_bunker;
#include maps\nicaragua_mason_final_push;
#include maps\nicaragua_mason_shattered;
#include maps\nicaragua_mason_outro;
#include maps\_horse;

main() {
  level.reset_clientdvars = ::reset_client_dvars;
  maps\nicaragua_fx::main();
  setup_objectives();
  level_precache();
  level_init_flags();
  setup_skipto();
  init_spawn_funcs();
  maps\nicaragua_anim::main();
  level.supportsflamedeaths = 1;
  level.actor_charring_client_flag = 15;
  maps\_load::main();
  maps\_drones::init();
  maps\_patrol::patrol_init();
  maps\_rusher::init_rusher();
  maps\_civilians::init_civilians();
  maps\_mortarteam::main();
  level thread maps\nicaragua_amb::main();
  level thread maps\createart\nicaragua_art::main();
  onplayerconnect_callback(::on_player_connect);
  onsaverestored_callback(::on_saved_restored);
  setnorthyaw(-90);
  setsaveddvar("phys_buoyancy", 1);
  setsaveddvar("phys_ragdoll_buoyancy", 1);
  setsaveddvar("phys_disableEntsAndDynEntsCollision", 1);
  level thread maps\_objectives::objectives();
  level thread setup_challenges();
  level thread maps\nicaragua_menendez_rage::setup_rage();
  level thread fxanim_deconstructions();
  level thread model_convert_areas();
}

on_player_connect() {
  achievement_stop_brutality();
}

on_saved_restored() {
  if(!flag("menendez_section_done"))
    setsaveddvar("ammoCounterHide", 1);
}

reset_client_dvars() {
  if(!flag("menendez_section_done"))
    self setclientdvars("compass", "1", "hud_showStance", "1", "cg_cursorHints", "4", "hud_showobjectives", "1", "ammoCounterHide", "1", "miniscoreboardhide", "0", "ui_hud_hardcore", "0", "credits_active", "0", "hud_missionFailed", "0", "cg_cameraUseTagCamera", "1", "cg_drawCrosshair", "1", "r_heroLightScale", "1 1 1", "player_sprintUnlimited", "0", "r_bloomTweaks", "0", "r_exposureTweak", "0");
  else
    self setclientdvars("compass", "1", "hud_showStance", "1", "cg_cursorHints", "4", "hud_showobjectives", "1", "ammoCounterHide", "0", "miniscoreboardhide", "0", "ui_hud_hardcore", "0", "credits_active", "0", "hud_missionFailed", "0", "cg_cameraUseTagCamera", "1", "cg_drawCrosshair", "1", "r_heroLightScale", "1 1 1", "player_sprintUnlimited", "0", "r_bloomTweaks", "0", "r_exposureTweak", "0");

  self resetfov();
  self allowspectateteam("allies", 0);
  self allowspectateteam("axis", 0);
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
}

setup_skipto() {
  add_skipto("mason_intro_briefing", ::skipto_mason_intro_briefing, "Mason Intro Briefing", maps\nicaragua_intro::mason_intro);
  add_skipto("menendez_intro", ::skipto_menendez_intro, "Menendez Intro", maps\nicaragua_intro::menendez_intro);
  add_skipto("menendez_sees_noriega", ::skipto_menendez_sees_noriega, "Menendez Sees Noriega", maps\nicaragua_intro::noriega_arrives_scene);
  add_skipto("menendez_hill", ::skipto_menendez_hill, "Menendez Hill", maps\nicaragua_menendez_hill::main);
  add_skipto("dev_no_rage_menendez_hill", ::skipto_dev_menendez_hill, "Dev Menendez Hill", maps\nicaragua_menendez_hill::main);
  add_skipto("menendez_execution", ::skipto_menendez_execution, "Menendez Execution", maps\nicaragua_menendez_execution::main);
  add_skipto("dev_no_rage_menendez_execution", ::skipto_dev_menendez_execution, "Dev Menendez Execution", maps\nicaragua_menendez_execution::main);
  add_skipto("menendez_stables", ::skipto_menendez_stables, "Menendez Stables", maps\nicaragua_menendez_stables::main);
  add_skipto("menendez_to_mission", ::skipto_menendez_to_mission, "Menendez To Mission", maps\nicaragua_menendez_to_mission::main);
  add_skipto("menendez_enter_mission", ::skipto_menendez_enter_mission, "Menendez Enter Mission", maps\nicaragua_menendez_enter_mission::main);
  add_skipto("menendez_hallway", ::skipto_menendez_hallway, "Menendez Hallway", maps\nicaragua_menendez_hallway::main);
  add_skipto("mason_intro", ::skipto_mason_intro, "Mason Intro", maps\nicaragua_mason_intro::main);
  add_skipto("mason_hill", ::skipto_mason_hill, "Mason Hill", maps\nicaragua_mason_hill::main);
  add_skipto("mason_truck", ::skipto_mason_truck, "Mason Truck", maps\nicaragua_mason_truck::main);
  add_skipto("mason_donkeykong", ::skipto_mason_donkeykong, "Mason Donkey Kong", maps\nicaragua_mason_donkeykong::main);
  add_skipto("mason_woods_freakout", ::skipto_mason_woods_freakout, "Mason Woods Freakout", maps\nicaragua_mason_woods_freakout::main);
  add_skipto("mason_to_mission", ::skipto_mason_to_mission, "Mason To Mission", maps\nicaragua_mason_to_mission::main);
  add_skipto("mason_bunker", ::skipto_mason_bunker, "Mason Bunker", maps\nicaragua_mason_bunker::main);
  add_skipto("mason_final_push", ::skipto_mason_final_push, "Mason To Mission", maps\nicaragua_mason_final_push::main);
  add_skipto("mason_shattered", ::skipto_mason_shattered, "Mason Shattered", maps\nicaragua_mason_shattered::main);
  add_skipto("mason_outro", ::skipto_mason_outro, "Mason Outro", maps\nicaragua_mason_outro::main);
  default_skipto("mason_intro_briefing");
  set_skipto_cleanup_func(maps\nicaragua_util::skipto_setup);
}

level_precache() {
  precacheshader("cinematic2d");
  precachemodel("p6_binoculars_anim");
  precachemodel("c_mul_menendez_nicaragua_viewhands");
  precachemodel("c_mul_menendez_nicaragua_viewbody");
  precachemodel("c_mul_menendez_nicaragua_b_viewbody");
  precachemodel("c_mul_menendez_nicaragua_d_viewbody");
  precachemodel("c_mul_menendez_nicaragua_m_viewbody");
  precachemodel("c_mul_menendez_nicaragua_m_viewhands");
  precachemodel("c_pan_noriega_military_head_wnded");
  precachemodel("p_anim_rus_key");
  precachemodel("com_hand_radio");
  maps\_horse::precache_models();
  precacheitem("machete_held_sp");
  precacheitem("rpg_player_sp");
  precacheitem("spas_menendez_sp");
  precacherumble("explosion_generic");
  precacheitem("binocular_sp");
  precacheitem("molotov_dpad_sp");
  precacheitem("molotov_sp");
  precacheitem("napalmblob_sp");
  precacheitem("machete_sp");
  precacheitem("rpg_magic_bullet_sp");
  precacheitem("mortar_shell_dpad_sp");
  precachemodel("veh_iw_pickup_bloody_glass");
  precachemodel("c_usa_seal80s_mason_viewhands");
  precachemodel("c_usa_seal80s_mason_viewbody");
  precacheshellshock("mason_shattered");
  precacheshellshock("mason_outro");
  precacheshader("overlay_cocaine");
}

init_spawn_funcs() {
}

skipto_setup() {
  skipto = level.skipto_point;

  if(skipto == "mason_intro") {
    return;
  }
  if(skipto == "mason_village") {
    return;
  }
  if(skipto == "mason_trucks") {
    return;
  }
  if(skipto == "mason_gasoline") {
    return;
  }
  if(skipto == "mason_to_mission") {
    return;
  }
  if(skipto == "mason_intel") {
    return;
  }
  if(skipto == "menendez_intro") {
    return;
  }
  if(skipto == "menendez_hill") {
    return;
  }
  if(skipto == "menendez_stables") {
    return;
  }
  if(skipto == "menendez_to_mission") {
    return;
  }
  if(skipto == "menendez_hallway") {
    return;
  }
  if(skipto == "the_mission") {
    return;
  }
  if(skipto == "the_hallway") {
    return;
  }
  if(skipto == "the_cache") {
    return;
  }
  if(skipto == "the_belltower") {
    return;
  }
  if(skipto == "the_escape_route") {
    return;
  }
  if(skipto == "the_landing_zone")
    return;
}