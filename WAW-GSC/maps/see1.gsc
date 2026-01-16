/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see1.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\see1_code;
#include maps\see1_opening;
#include maps\see1_event1;
#include maps\see1_event2;
#include maps\see1_event3;
#include maps\_music;
#using_animtree("generic_human");

main() {
  flag_init("initial_setup_done");
  flag_init("molotov_tossed");
  flag_init("opening_german1_killed");
  flag_init("opening_german2_killed");
  flag_init("opening_german1_spared");
  flag_init("opening_german2_spared");
  flag_init("ev2_player_fired");
  flag_init("river_halfway_reached");
  flag_init("ev2_tank1_spawned");
  flag_init("ev2_tank2_spawned");
  flag_init("ev2_tank3_spawned");
  flag_init("ev2_tank4_spawned");
  flag_init("ev2_tank5_spawned");
  flag_init("ev2_tank1_at_end");
  flag_init("ev2_tank2_at_end");
  flag_init("ev2_tank3_at_end");
  flag_init("ev2_tank4_at_end");
  flag_init("ev2_tank5_at_end");
  flag_init("ev2_tank1_destroyed");
  flag_init("ev2_tank2_destroyed");
  flag_init("ev2_tank3_destroyed");
  flag_init("ev2_tank4_destroyed");
  flag_init("ev2_tank5_destroyed");
  flag_init("ev2_tank_friend_in_position");
  flag_init("barn_door_anim_ready");
  level.ev2_tank_1_can_mount = false;
  level.ev2_tank_2_can_mount = false;
  level.ev2_tank_3_can_mount = false;
  level.ev2_player_mounted = false;
  flag_init("tank_ride_over");
  flag_init("tank3_in_position_after_ride");
  flag_init("ev3_halftrack1_mg_killed");
  flag_init("ev3_halftrack2_mg_killed");
  flag_init("ev3_player_chase");
  flag_init("ev3_player_passes_barrier");
  flag_init("ev3_flood_spawners_end");
  flag_init("truck3_unloading");
  flag_init("ending_tank_ready");
  flag_init("reznov_on_tank");
  add_start("event0", ::start_opening, & "START_SEE1_1_OPENING");
  add_start("event1", ::start_event1, & "START_SEE1_2_BURNING_FOREST");
  add_start("event2", ::start_event2, & "START_SEE1_3_TANK_BATTLE");
  add_start("event3", ::start_event3, & "START_SEE1_4_CAMP");
  add_start("outro", ::start_event3_outro, & "START_SEE1_5_OUTRO");
  default_start(::start_opening);
  level.campaign = "russian";
  setdvar("r_watersim_enabled", "0");
  maps\_t34::main("vehicle_rus_tracked_t34", "t34");
  maps\_halftrack::main("vehicle_ger_tracked_halftrack", undefined, false);
  maps\_truck::main("vehicle_ger_wheeled_opel_blitz", "opel");
  maps\_destructible_opel_blitz::init();
  PrecacheModel("viewmodel_rus_guard_player");
  maps\_tiger::main("vehicle_ger_tracked_king_tiger");
  maps\_stuka::main("vehicle_rus_airplane_il2", "stuka");
  level.drone_weaponlist_axis = [];
  level.drone_weaponlist_axis[0] = "gewehr43";
  level.drone_spawnFunction["allies"] = maps\see1_code::custom_drone_spawn_allies;
  level.drone_spawnFunction["axis"] = maps\see1_code::custom_drone_spawn_axis;
  maps\_drones::init();
  maps\_mganim::main();
  level.maxfriendlies = 3;
  setsaveddvar("fire_spread_probability", 0.9);
  createthreatbiasgroup("players");
  createthreatbiasgroup("squad");
  precache_items();
  maps\see1_fx::main();
  maps\_load::main();
  maps\see1_anim::main();
  level thread maps\see1_amb::main();
  maps\see1_status::main();
  maps\_vehicle::build_treadfx();
  level.plane_bomb_model["stuka"] = "aircraft_bomb";
  level.plane_bomb_fx["stuka"] = level._effect["dirt_blow_up"];
  level.plane_bomb_sound["stuka"] = "temp_sound";
  maps\_planeweapons::build_bomb_explosions("stuka", randomfloatrange(.3, .5), 3, 1000, 700, 250, 1000);
  flag_wait("initial_setup_done");
  switch (level.start_point) {
    case "opening":
      opening_main();
    case "event1":
      event1_main();
    case "event2":
      event2_main();
    case "event3":
      event3_main();
    case "event3_outro":
      event3_outro_test();
  }
}

debug_model_debug() {
  wait(5);
  players = get_players();
  while (1) {
    all_models = getentarray("script_model", "classname");
    for (i = 0; i < all_models.size; i++) {
      if(all_models[i].model == "char_rus_guard_body1_2") {
        line(players[0].origin, all_models[i].origin, (0.9, 0.9, 0.9), false);
        print3d(all_models[i].origin + (0, 0, 40), "*2*", (0.9, 0.9, 0.9), 1, 3);
      }
      if(all_models[i].model == "char_rus_guard_body1_1") {
        line(players[0].origin, all_models[i].origin, (0.9, 0.9, 0.9), false);
        print3d(all_models[i].origin + (0, 0, 40), "*1*", (0.9, 0.9, 0.9), 1, 3);
      }
    }
    wait(0.05);
  }
}

precache_items() {
  character\char_rus_r_rifle::precache();
  character\char_ger_wrmcht_k98::precache();
  precachemodel("weapon_rus_molotov_grenade");
  precachemodel("weapon_ger_g43_rifle");
  precachemodel("weapon_ger_panzershreck_rocket");
  precachemodel("weapon_ger_panzerschreck_at_obj");
  precachemodel("vehicle_ger_wheeled_opel_blitz_d");
  precachemodel("vehicle_ger_wheeled_opel_blitz");
  precachemodel("vehicle_rus_airplane_il2");
  precachemodel("static_berlin_ger_knife");
  precachemodel("anim_seelow_pocketwatch");
  precachemodel("static_berlin_books_diary");
  precachemodel("anim_seelow_barndoorkick");
  precachemodel("anim_seelow_barndoortank");
  precachemodel("aircraft_bomb");
  precachemodel("weapon_ger_panzerschreck_at");
  precachemodel("mounted_ger_mg42_bipod_mg");
  precachemodel("mounted_ger_fg42_bipod_lmg");
  precachemodel("vehicle_rus_tracked_t34_seta_body");
  precachemodel("vehicle_rus_tracked_t34_seta_turret");
  precachemodel("vehicle_rus_tracked_t34_setb_body");
  precachemodel("vehicle_rus_tracked_t34_setb_turret");
  precachemodel("vehicle_rus_tracked_t34_setc_body");
  precachemodel("vehicle_rus_tracked_t34_setc_turret");
  precacheRumble("artillery_rumble");
  precacheRumble("damage_heavy");
  level.obj1_string = & "SEE1_OBJECTIVE1";
  level.obj2_string = & "SEE1_OBJECTIVE2";
  level.obj1b_string = & "SEE1_OBJECTIVE1_B";
  level.obj1c_string = & "SEE1_OBJECTIVE1_C";
  level.obj3a_string = & "SEE1_OBJECTIVE3A";
  level.obj3b_string = & "SEE1_OBJECTIVE3B";
  level.obj3c_string = & "SEE1_OBJECTIVE3C";
  level.obj3d_string = & "SEE1_OBJECTIVE3D";
  level.obj3e_string = & "SEE1_OBJECTIVE3E";
  level.obj4_string = & "SEE1_OBJECTIVE4";
  level.obj5_string = & "SEE1_OBJECTIVE5";
  level.obj6_string = & "SEE1_OBJECTIVE6";
  level.obj7_string = & "SEE1_OBJECTIVE7";
  level.obj8_string = & "SEE1_OBJECTIVE8";
  level.obj9_string = & "SEE1_OBJECTIVE9";
  level.obj10a_string = & "SEE1_OBJECTIVE10A";
  level.obj10b_string = & "SEE1_OBJECTIVE10B";
  level.obj10c_string = & "SEE1_OBJECTIVE10C";
  level.obj11_string = & "SEE1_OBJECTIVE11";
  level.obj12_string = & "SEE1_OBJECTIVE12";
}

start_opening() {
  if(is_german_build() == false) {
    level thread players_connect_opening();
  }
  share_screen(get_host(), true, true);
  spawn_friendlies();
  if(is_german_build()) {
    teleport_friendlies("german_build_hero1_start", "german_build_hero2_start", "german_build_friend_start");
    teleport_players("german_build_player_start");
  } else {
    teleport_friendlies("opening_hero1_start", "opening_hero2_start", "opening_friend_start");
    teleport_players("opening_player_start");
    players_connect_opening();
  }
  prepare_players();
  level.start_point = "opening";
  flag_set("initial_setup_done");
}

players_connect_opening() {
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] allowstand(true);
    players[i] allowcrouch(false);
    players[i] allowprone(false);
    players[i] setstance("stand");
    players[i] disableWeapons();
    players[i] SetClientDvar("hud_showStance", "0");
    players[i] SetClientDvar("compass", "0");
    players[i] SetClientDvar("ammoCounterHide", "1");
    players[i] setClientDvar("miniscoreboardhide", "1");
  }
}

start_event1() {
  spawn_friendlies();
  wait(0.5);
  teleport_friendlies("event1_hero1_start", "event1_hero2_start", "event1_friend_start");
  teleport_players("event1_player_start");
  prepare_players();
  objective_add(1, "current", level.obj1_string, (3537, -2243, -913));
  level.start_point = "event1";
  flag_set("initial_setup_done");
}

start_event2() {
  spawn_friendlies();
  teleport_friendlies("event2_hero1_start", "event2_hero2_start", "event2_friend_start");
  teleport_players("event2_player_start");
  prepare_players();
  level.start_point = "event2";
  flag_set("initial_setup_done");
}

start_event3() {
  spawn_friendlies();
  teleport_friendlies("event3_hero1_start", "event3_hero2_start", "event3_friend_start");
  teleport_players("event3_player_start");
  prepare_players();
  level.start_point = "event3";
  flag_set("initial_setup_done");
}

start_event3_outro() {
  spawn_friendlies();
  teleport_friendlies("event3_hero1_start", "event3_hero2_start", "event3_friend_start");
  teleport_players("event3_player_start");
  prepare_players();
  level.start_point = "event3_outro";
  flag_set("initial_setup_done");
}