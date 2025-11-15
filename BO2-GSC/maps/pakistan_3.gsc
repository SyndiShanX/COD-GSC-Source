/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_3.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\pakistan_util;
#include maps\_vehicle;
#include maps\pakistan_3_fx;
#include maps\pakistan_3_anim;
#include maps\_soct;
#include maps\_lockonmissileturret;
#include maps\_load;
#include maps\pakistan_3_amb;
#include maps\createart\pakistan_3_art;
#include maps\_boat_soct_ride;
#include maps\pakistan_escape_intro;
#include maps\pakistan_escape;
#include maps\pakistan_escape_end;
#include maps\pakistan_warehouse;
#include maps\pakistan_evac;
#include maps\pakistan_s3_util;
#include maps\_challenges_sp;

main() {
  maps\pakistan_3_fx::main();
  init_flags();
  maps\pakistan_3_anim::main();
  visionsetnaked("default");
  level_precache();
  setup_objectives();
  setup_skiptos();
  maps\_soct::init();
  maps\_lockonmissileturret::init(0, undefined, 1, 1);
  level._vehicle_load_lights = 1;
  maps\_load::main();
  maps\pakistan_3_amb::main();
  onplayerconnect_callback(::on_player_connect);
  setsaveddvar("vehicle_selfCollision", 0);
  setup_spawn_functions();
  level.friendlyfiredisabled = 1;
  level.dukes_of_hazard_mode = 0;
  level.player_soct_test_for_water = 0;
  level thread maps\createart\pakistan_3_art::main();
  setsaveddvar("phys_buoyancy", 1);
  setsaveddvar("phys_ragdoll_buoyancy", 0);
  maps\_boat_soct_ride::init();
  level thread objectives();
  setdvar("scr_health_debug", "0");
}

on_player_connect() {
  setup_challenges();
}

level_precache() {
  precacheitem("usrpg_player_sp");
  precachemodel("c_usa_cia_combat_harper_head_brn");
  precachemodel("veh_t6_mil_soc_t_steeringwheel");
  precachemodel("veh_t6_mil_soc_t_no_col");
  precachemodel("veh_t6_mil_super_soc_t");
  precachemodel("veh_t6_mil_soc_t_damaged");
  precachemodel("veh_t6_mil_super_soc_t_damaged");
  precachemodel("veh_t6_mil_soc_t_dead");
  precachemodel("veh_t6_mil_super_soc_t_dead");
  precacheshader("compass_static");
  precachestring(&"hud_gunner_missile_fire");
  precacheshellshock("soct_boost");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachestring(&"hud_shrink_ammo");
  precachestring(&"hud_expand_ammo");
  precacheitem("usrpg_magic_bullet_sp");
}

setup_skiptos() {
  add_skipto("intro", ::skipto_pakistan);
  add_skipto("market", ::skipto_pakistan);
  add_skipto("dev_market_perk", ::skipto_pakistan);
  add_skipto("dev_market_no_perk", ::skipto_pakistan);
  add_skipto("car_smash", ::skipto_pakistan);
  add_skipto("market_exit", ::skipto_pakistan);
  add_skipto("dev_market_exit_perk", ::skipto_pakistan);
  add_skipto("dev_market_exit_no_perk", ::skipto_pakistan);
  add_skipto("frogger", ::skipto_pakistan);
  add_skipto("bus_street", ::skipto_pakistan);
  add_skipto("bus_dam", ::skipto_pakistan);
  add_skipto("alley", ::skipto_pakistan);
  add_skipto("anthem_approach", ::skipto_pakistan);
  add_skipto("sewer_exterior", ::skipto_pakistan);
  add_skipto("sewer_interior", ::skipto_pakistan);
  add_skipto("dev_sewer_interior_perk", ::skipto_pakistan);
  add_skipto("dev_sewer_interior_no_perk", ::skipto_pakistan);
  add_skipto("anthem", ::skipto_pakistan_2);
  add_skipto("roof_meeting", ::skipto_pakistan_2);
  add_skipto("underground", ::skipto_pakistan_2);
  add_skipto("claw", ::skipto_pakistan_2);
  add_skipto("escape_intro", maps\pakistan_escape_intro::skipto_escape_intro, undefined, maps\pakistan_escape_intro::main);
  add_skipto("escape_battle", maps\pakistan_escape::skipto_escape_battle, undefined, maps\pakistan_escape::main);
  add_skipto("escape_bosses", maps\pakistan_escape_end::skipto_escape_bosses, undefined, maps\pakistan_escape_end::main);
  add_skipto("warehouse", maps\pakistan_warehouse::skipto_warehouse, undefined, maps\pakistan_warehouse::warehouse_main);
  add_skipto("hangar", maps\pakistan_evac::skipto_hangar, undefined, maps\pakistan_evac::hangar_main);
  add_skipto("standoff", maps\pakistan_evac::skipto_standoff, undefined, maps\pakistan_evac::standoff_main);
  default_skipto("escape_intro");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_pakistan() {
  changelevel("pakistan", 1);
}

skipto_pakistan_2() {
  changelevel("pakistan_2", 1);
}

setup_spawn_functions() {
  add_spawn_function_veh("soct_respawner", ::soct_death_challenge);
  add_spawn_function_veh("st_surprise_soct", ::soct_death_challenge);
  add_spawn_function_veh("st_soct_0", ::soct_death_challenge);
  add_spawn_function_veh("st_soct_1", ::soct_death_challenge);
  add_spawn_function_veh("st_surprise_soct", ::soct_death_challenge);
  add_spawn_function_veh("h_soct_0", ::soct_death_challenge);
  add_spawn_function_veh("h_soct_1", ::soct_death_challenge);
  add_spawn_function_veh("h_soct_2", ::soct_death_challenge);
  add_spawn_function_veh("hwy_soct_3", ::soct_death_challenge);
  add_spawn_function_veh("heli_crash_soct", ::soct_death_challenge);
  add_spawn_function_veh("hotel_block_l", ::soct_death_challenge);
  add_spawn_function_veh("hotel_block_r", ::soct_death_challenge);
  add_spawn_function_veh("boss_soct", ::soct_death_challenge);
  add_spawn_function_veh("warehouse_soct_0", ::soct_death_challenge);
  add_spawn_function_veh("di_soct_0", ::soct_death_challenge);
  add_spawn_function_veh("chicken_soct", ::soct_death_challenge);
  add_spawn_function_group("hotel_0", "targetname", ::hotel_0_spwn_fn);
}

hotel_0_spwn_fn() {
  self.favoriteenemy = level.player;
  self.script_ignore_suppression = 1;
}

soct_death_challenge() {
  self waittill("death", e_attacker, damagefromunderneath, weaponname, point, dir);

  if(isDefined(e_attacker) && e_attacker == level.player) {
    if(!maps\pakistan_s3_util::is_player_in_drone())
      level notify("soct_soct_kill");

    return;
  }
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("nodeath", ::challenge_nodeath);
  self thread maps\_challenges_sp::register_challenge("bigjump", ::challenge_big_jumps);
  self thread maps\_challenges_sp::register_challenge("takedown", ::challenge_takedowns);
  self thread maps\_challenges_sp::register_challenge("socttakedown", ::challenge_socttakedowns);
}

challenge_nodeath(str_notify) {
  flag_wait("player_enters_hanger");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

challenge_big_jumps(str_notify) {
  num_big_jumps = 0;

  while(true) {
    level waittill("big_jump");
    num_big_jumps++;

    if(num_big_jumps == 2) {
      self notify(str_notify);
      return;
    }
  }
}

challenge_takedowns(str_notify) {
  level.num_player_drone_soct_kills = 0;

  while(true) {
    level waittill("player_drone_vehicle_kill");
    level.num_player_drone_soct_kills++;

    if(level.num_player_drone_soct_kills >= 20) {
      self notify(str_notify);
      return;
    }
  }
}

challenge_socttakedowns(str_notify) {
  level.num_player_soct_soct_kills = 0;

  while(true) {
    level waittill("soct_soct_kill");
    level.num_player_soct_soct_kills++;

    if(level.num_player_soct_soct_kills >= 8) {
      self notify(str_notify);
      return;
    }
  }
}