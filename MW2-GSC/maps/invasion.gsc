/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\invasion.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include maps\invasion_anim;

main() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  setsaveddvar("r_specularcolorscale", "2.3");

  level.min_time_between_uav_launches = 4 * 1000;
  level.obj_direction = undefined;
  level.min_btr_fighting_range = 400;
  level.attackheliRange = 7000;
  level.redshirts = [];
  level.goodFriendlyDistanceFromPlayerSquared = 300 * 300;
  level.cosine["90"] = cos(90);
  level.cosine["60"] = cos(60);
  level.cosine["25"] = cos(25);
  level.droppers = 0;
  level.dropped = 0;
  level.bmps_from_north_dead = 0;
  level.bcs_maxThreatDistFromPlayer = 3500;
  level.no_remote_missile_reminders = true;

  PreCacheItem("remote_missile_invasion");
  level.remote_missile_invasion = true;

  precacheString(&"INVASION_LINE1");
  precacheString(&"INVASION_LINE2");
  precacheString(&"INVASION_LINE3");
  precacheString(&"INVASION_LINE4");
  precacheString(&"INVASION_LINE5");

  level.weaponClipModels = [];
  level.weaponClipModels[0] = "weapon_scar_h_clip";
  level.weaponClipModels[1] = "weapon_ak47_clip";
  level.weaponClipModels[2] = "weapon_ump45_clip";
  level.weaponClipModels[3] = "weapon_fn2000_clip";
  level.weaponClipModels[4] = "weapon_mp5_clip";
  level.weaponClipModels[5] = "weapon_saw_clip";
  level.weaponClipModels[6] = "weapon_mp44_clip";
  level.weaponClipModels[7] = "weapon_m16_clip";

  build_light_override("btr80", "vehicle_btr80", "spotlight", "TAG_FRONT_LIGHT_RIGHT", "misc/spotlight_btr80_daytime", "spotlight", 0.2);
  build_light_override("btr80", "vehicle_btr80", "spotlight_turret", "TAG_TURRET_LIGHT", "misc/spotlight_btr80_daytime", "spotlight_turret", 0.0);

  maps\invasion_precache::main();
  maps\invasion_fx::main();
  maps\createart\invasion_art::main();

  precacheItem("smoke_grenade_american");
  precacheItem("remote_missile_not_player_invasion");
  precacheModel("weapon_stinger_obj");
  precacheModel("weapon_uav_control_unit_obj");
  precacheItem("flash_grenade");

  precacheItem("zippy_rockets");
  precacheItem("stinger_speedy");

  default_start(::start_humvee);
  add_start("humvee", ::start_humvee);
  add_start("yards", ::start_yards);
  add_start("bmp", ::start_bmp);
  add_start("pizza", ::start_pizza);
  add_start("gas_station", ::start_gas_station);
  add_start("crash", ::start_crash);
  add_start("nates_roof", ::start_nates_roof);

  add_start("attack_diner", ::start_attack_diner);
  add_start("defend_diner", ::start_diner_defend);
  add_start("diner", ::start_diner);
  add_start("burgertown", ::start_burgertown);
  add_start("vip_escort", ::start_vip_escort);
  add_start("defend_BT", ::start_defend_BT);
  add_start("helis", ::start_helis);
  add_start("convoy", ::start_convoy);

  add_start("start_btr80_smash", ::start_btr80_smash);

  maps\_attack_heli::preLoad();
  maps\_drone_ai::init();

  maps\_load::main();
  maps\_carry_ai::initCarry();
  thread maps\invasion_amb::main();
  common_scripts\_sentry::main();
  array_thread(getvehiclenodearray("plane_sound", "script_noteworthy"), maps\_mig29::plane_sound_node);

  maps\_stinger::init();

  maps\invasion_anim::main_anim();

  maps\_remotemissile::init();

  thread setup_stingers();

  thread setup_nates_kitchen_ladder_clip();
  thread setup_bt_ktichen_ladder_clip();

  level.bcs_maxTalkingDistFromPlayer = 1500;
  level.bcs_maxThreatDistFromPlayer = 5000;

  if(level.start_point == "no_game") {
    return;
  }
  flag_init("notetrack_gimmesitrep");
  flag_init("notetrack_status");
  flag_init("notetrack_whatelse");
  flag_init("notetrack_sentrygunsouth");
  flag_init("notetrack_checkout");
  flag_init("notetrack_meatlocker");
  flag_init("notetrack_unconscious");
  flag_init("notetrack_supplydrop");

  flag_init("house_destroyer_moving_back");
  flag_init("btr_backed_away");
  flag_init("btr_smoke_starting");
  flag_init("btr_smoked");
  flag_init("follow_foley");
  flag_init("northside_roof");
  flag_init("smoke_screen_starting");
  flag_init("bmp_out_of_sight");
  flag_init("player_goto_roof");
  flag_init("wells_intro_done");
  flag_init("truck_guys_retreat");
  flag_init("diner_attack");
  flag_init("time_to_go_get_UAV_control");
  flag_init("time_to_clear_burgertown");
  flag_init("time_to_destroy_bmps");
  flag_init("taco_goes_to_roof");
  flag_init("player_defended_burgertown");
  flag_init("player_at_convoy");
  flag_init("bmp_north_left_dead");
  flag_init("bmp_north_mid_dead");
  flag_init("move_president_to_prep");
  flag_init("bmp1_spotted_player");
  flag_init("bmp2_spotted_player");
  flag_init("juggernaut_dead");
  flag_init("nates_bomb_incoming");
  flag_init("nates_bombed");
  flag_init("bank_guys_retreat");
  flag_init("back_door_attack_start");

  flag_init("bmps_from_north_dead");
  thread bmps_from_north_dead();

  maps\_compass::setupMiniMap("compass_map_invasion");

  flag_init("player_in_pos_to_cover_vip");
  flag_init("convoy_is_here");
  flag_init("threw_semtex");
  flag_init("threw_smoke");

  flag_init("first_attack_heli_spawned");
  flag_init("second_attack_heli_spawned");

  flag_init("first_attack_heli_dead");
  flag_init("second_attack_heli_dead");
  flag_init("time_to_goto_convoy");

  flag_init("bmp_has_spotted_player");

  yards_roof_parachute_guy = getent("roof_parachute_landing_guy_yards", "targetname");
  humvee_roof_parachute_guy = getent("humvee_ride_roof_landing", "targetname");

  yards_roof_parachute_guy add_spawn_function(::setup_roof_parachute_guy);
  humvee_roof_parachute_guy add_spawn_function(::setup_roof_parachute_guy, "humvee_guy");

  array_thread(getEntArray("commander", "script_noteworthy"), ::add_spawn_function, ::setup_raptor);
  array_thread(getEntArray("taco", "script_noteworthy"), ::add_spawn_function, ::setup_taco);
  array_thread(getEntArray("worm", "script_noteworthy"), ::add_spawn_function, ::setup_worm);

  array_thread(getEntArray("alley_nates_attackers", "script_noteworthy"), ::add_spawn_function, ::alley_nates_attackers_setup);
  array_thread(getEntArray("wells", "script_noteworthy"), ::add_spawn_function, ::setup_wells);
  array_thread(getEntArray("BT_nates_attackers", "script_noteworthy"), ::add_spawn_function, ::BT_nates_attackers_setup);

  wounded_carry_attackers = getEntArray("wounded_carry_attackers", "script_noteworthy");
  array_thread(wounded_carry_attackers, ::add_spawn_function, ::setup_wounded_carry_attackers);

  BT_enemy_defenders = getEntArray("BT_enemy_defenders", "script_noteworthy");
  array_thread(BT_enemy_defenders, ::add_spawn_function, ::setup_BT_enemy_defenders);

  nates_defenders = getEntArray("nates_defenders", "script_noteworthy");
  array_thread(nates_defenders, ::add_spawn_function, ::nates_defenders_setup);
  array_thread(nates_defenders, ::add_spawn_function, ::set_threatbias_group, "nates_defenders");

  president = getEntArray("president", "script_noteworthy");
  array_thread(president, ::add_spawn_function, ::setup_president);

  truck_group_enemies = getEntArray("truck_group_enemies", "script_noteworthy");
  array_thread(truck_group_enemies, ::add_spawn_function, ::truck_group_enemies_setup);
  array_thread(truck_group_enemies, ::add_spawn_function, ::truck_group_enemies_setup_retreat);
  array_thread(truck_group_enemies, ::add_spawn_function, ::truck_group_enemies_count_deaths);

  bank_nates_attackers = getEntArray("bank_nates_attackers", "targetname");
  array_thread(bank_nates_attackers, ::add_spawn_function, ::bank_enemies_setup_retreat);

  spawners = getEntArray("diner_enemy_defenders_mobile", "script_noteworthy");
  array_thread(spawners, ::add_spawn_function, ::setup_diner_backdoor_attackers);

  gas_station_truck_guys = getEntArray("gas_station_truck_guys", "targetname");
  array_thread(gas_station_truck_guys, ::add_spawn_function, ::set_threatbias_group, "gas_station_truck_enemies");

  array_thread(getEntArray("tangled_parachute_guy", "script_noteworthy"), ::add_spawn_function, maps\invasion_anim::tangled_parachute_guy);

  add_global_spawn_function("axis", ::setup_count_predator_infantry_kills);
  add_global_spawn_function("axis", ::setup_remote_missile_target_guy);

  flag_init("player_has_predator_drones");
  predator_drone_control = getent("predator_drone_control", "targetname");
  predator_drone_control hide();

  thread bt_locker_door_open();
  thread nates_locker_door_open();

  level.paradropper_left = getent("paradrop_guy_left", "script_noteworthy");
  level.paradropper_right = getent("paradrop_guy_right", "script_noteworthy");

  paradrop_plane_triggers = getEntArray("paradrop_plane_trigger", "targetname");
  array_thread(paradrop_plane_triggers, ::paradrop_vehicle);

  thread paradrops_ambient();

  level.uav = spawn_vehicle_from_targetname_and_drive("uav");
  level.uav playLoopSound("uav_engine_loop");
  level.uavRig = spawn("script_model", level.uav.origin);
  level.uavRig setModel("tag_origin");
  thread UAVRigAiming();

  flag_init("sentry_in_position");
  level.obj_sentry = getent("obj_sentry", "script_noteworthy");
  level.obj_sentry thread sentry_init_owner();

  thread diner_window_traverses();

  createThreatBiasGroup("nates_defenders");
  createThreatBiasGroup("gas_station_truck_enemies");
  createThreatBiasGroup("players_group");
  level.player setthreatbiasgroup("players_group");

  ignoreEachOther("nates_defenders", "gas_station_truck_enemies");

  friendly_redshirt_rpg = getEntArray("friendly_redshirt_rpg", "script_noteworthy");
  array_thread(friendly_redshirt_rpg, ::add_spawn_function, ::setup_rpg_redshirts);

  add_hint_string("hint_predator_drone_vs_bmps_4", &"HELLFIRE_USE_DRONE", ::should_break_use_drone_vs_bmps);
  add_hint_string("hint_predator_drone_vs_bmps_2", &"HELLFIRE_USE_DRONE_2", ::should_break_use_drone_vs_bmps);
  add_hint_string("hint_steer_drone", &"SCRIPT_PLATFORM_STEER_DRONE", ::should_break_steer_drone);

  add_hint_string("hint_throw_smoke", &"INVASION_THROW_SMOKE", ::should_break_throw_smoke);
  add_hint_string("hint_get_smoke", &"INVASION_GET_SMOKE", ::should_break_get_smoke);

  add_hint_string("hint_smoke_too_far", &"INVASION_SMOKE_TOO_FAR", ::should_break_smoke_too_far);
  add_hint_string("hint_ads_with_stinger", &"INVASION_ADS_WITH_STINGER", ::should_break_ads_with_stinger);
  add_hint_string("hint_toggle_ads_with_stinger", &"INVASION_TOGGLE_ADS_WITH_STINGER", ::should_break_ads_with_stinger);

  waittillframeend;

  setsaveddvar("ai_busyEventDistDeath", "400");
  setsaveddvar("ai_busyEventDistGunShot", "800");

  thread objective_main();
  thread spawn_nates_defenders();
}

sentry_init_owner() {
  wait .5;
  owner = spawn("script_origin", self.origin);
  owner.targetname = "fake_sentry_owner";

  self.owner = owner;

  while(1) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      break;
    }
  }

  self.owner = ent;
}

turret_spotlight() {
  vehicle_lights_on("spotlight spotlight_turret");
}

/using_animtree( "vehicles" );

start_humvee() {
  thread handler_humvee_to_yards();
}

start_bmp_paradrop() {
  start = getstruct("start_yards", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);
  level.bmp_paradrop = true;
}

start_yards() {
  start = getstruct("start_yards", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_yards_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  thread handler_yards_to_house_destroyer();
}

start_bmp() {
  start_bmp = getstruct("start_bmp", "targetname");
  level.player setOrigin(start_bmp.origin);
  level.player setPlayerAngles(start_bmp.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_bmp_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  thread handler_house_destroyer_to_pizza();
}

start_pizza() {
  start_pizza = getstruct("start_pizza", "targetname");
  level.player setOrigin(start_pizza.origin);
  level.player setPlayerAngles(start_pizza.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_pizza_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  flag_set("spawn_nates_attackers_in_alley");
  thread spawn_nates_attackers_in_alley();

  thread handler_pizza_to_gas_station();
}

start_gas_station() {
  player_start = getstruct("start_gas_station", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_gas_station_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  activate_trigger_with_targetname("BT_attackers_trigger");

  thread handler_gas_station_to_crash();
}

start_crash() {
  player_start = getstruct("start_crash", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_crash_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  thread spawn_president();

  level.taco set_force_color("g");
  level.raptor set_force_color("y");

  activate_trigger_with_targetname("move_to_wells_intro");

  flag_set("leaving_gas_station");

  wait 1;

  thread handler_crash();
}

start_nates_roof() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_roof_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  flag_set("leaving_gas_station");
  flag_set("crash_objective");
  thread spawn_president();
  thread spawn_wells();

  thread handler_crash_to_roof();
}

start_roof_northside() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_roof_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }

  flag_set("leaving_gas_station");
  flag_set("sentry_in_position");
  flag_set("crash_objective");
  thread spawn_president();
  thread spawn_wells();
  magic_smoke_grenades = getEntArray("magic_smoke_grenade", "targetname");
  array_thread(magic_smoke_grenades, ::enemy_uses_smoke);
  thread wait_to_spawn_diner_defenders();

  thread handler_roof_north_side();
}

start_attack_diner() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_roof_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  flag_set("leaving_gas_station");
  flag_set("crash_objective");
  thread spawn_president();
  thread spawn_wells();

  flag_set("sentry_in_position");
  thread wait_to_spawn_diner_defenders();

  wait .1;

  thread handler_roof_to_diner();
}

start_btr80_smash() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  friendlies = getEntArray("secretservice_friendly", "targetname");

  friendly_starts = getStructArray("start_roof_friendly", "targetname");

  for(i = 0; i < friendly_starts.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  flag_set("leaving_gas_station");
  flag_set("crash_objective");
  thread spawn_president();
  thread spawn_wells();
  level.obj_sentry kill();

  level.btr80_smash = true;
  flag_set("sentry_in_position");
  thread wait_to_spawn_diner_defenders();
  thread handler_roof_to_diner();
}

start_diner_defend() {
  player_start = getstruct("start_diner", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_diner_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  friendly_starts = getStructArray("start_roof_friendly", "targetname");
  raptor_spawner.origin = friendly_starts[0].origin;
  raptor_spawner.angles = friendly_starts[0].angles;
  raptor_spawner spawn_ai();

  thread spawn_president();
  thread spawn_wells();
  flag_set("leaving_gas_station");
  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();
  level.obj_sentry kill();

  wait .1;

  thread two_bmps_from_north();

  thread handler_diner_defend();
}

start_diner() {
  player_start = getstruct("start_diner", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_diner_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  friendly_starts = getStructArray("start_roof_friendly", "targetname");
  raptor_spawner.origin = friendly_starts[0].origin;
  raptor_spawner.angles = friendly_starts[0].angles;
  raptor_spawner spawn_ai();

  thread spawn_president();
  thread spawn_wells();
  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();

  thread diner_back_door_open();
  level.obj_sentry kill();

  flag_set("nates_bomb_incoming");

  activate_trigger_with_targetname("burger_town_enemy_defenders_trigger");
  thread taco_goes_to_BT();

  thread handler_diner_to_burgertown();
}

start_burgertown() {
  player_start = getstruct("start_BT", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_BT_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  friendly_starts = getStructArray("start_roof_friendly", "targetname");
  raptor_spawner.origin = friendly_starts[0].origin;
  raptor_spawner.angles = friendly_starts[0].angles;
  raptor_spawner spawn_ai();

  thread spawn_president();
  thread spawn_wells();
  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();

  flag_set("nates_bomb_incoming");

  thread diner_back_door_open();
  level.obj_sentry kill();

  remove_tvs();
  exploder(333);

  thread handler_burgertown();
}

start_vip_escort() {
  player_start = getstruct("start_vip_escort", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_BT_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  friendly_starts = getStructArray("start_roof_friendly", "targetname");
  raptor_spawner.origin = friendly_starts[0].origin;
  raptor_spawner.angles = friendly_starts[0].angles;
  raptor_spawner spawn_ai();

  thread spawn_president();
  thread spawn_wells();
  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();

  remove_tvs();
  exploder(333);

  thread taco_goes_to_BT_roof();
  flag_set("taco_goes_to_roof");

  wells_in_bushes = getnode("wells_in_bushes", "targetname");
  level.wells setgoalnode(wells_in_bushes);

  flag_set("nates_bomb_incoming");

  thread diner_back_door_open();
  level.obj_sentry kill();

  thread handler_vip_escort();
}

start_defend_BT() {
  player_start = getstruct("start_BT", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_BT_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  raptor_start = getent("president_in_burgertown_meat_locker", "targetname");
  raptor_spawner.origin = raptor_start.origin;
  raptor_spawner.angles = raptor_start.angles;
  raptor_spawner spawn_ai();

  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();

  remove_tvs();
  exploder(333);

  thread taco_goes_to_BT_roof();
  flag_set("taco_goes_to_roof");

  flag_set("nates_bomb_incoming");

  thread diner_back_door_open();
  level.obj_sentry kill();
  flag_set("president_in_BT_meat_locker");

  thread handler_defend_BT();
}

start_helis() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  taco_spawner = getent("taco", "script_noteworthy");
  friendly_start = getstruct("start_BT_taco", "targetname");
  taco_spawner.origin = friendly_start.origin;
  taco_spawner.angles = friendly_start.angles;
  taco_spawner spawn_ai();

  raptor_spawner = getent("commander", "script_noteworthy");
  raptor_start = getent("president_in_burgertown_meat_locker", "targetname");
  raptor_spawner.origin = raptor_start.origin;
  raptor_spawner.angles = raptor_start.angles;
  raptor_spawner spawn_ai();

  flag_set("crash_objective");
  flag_set("sentry_in_position");
  thread give_player_predator_drone();

  remove_tvs();
  exploder(333);

  thread taco_goes_to_BT_roof();
  flag_set("taco_goes_to_roof");

  flag_set("nates_bomb_incoming");

  thread diner_back_door_open();
  level.obj_sentry kill();
  flag_set("president_in_BT_meat_locker");

  level.num_of_enemy_forces_spawned = 3;
  flag_set("first_attack_heli_spawned");

  thread handler_defend_BT();
}

start_convoy() {
  player_start = getstruct("start_nates_roof", "targetname");
  level.player setOrigin(player_start.origin);
  level.player setPlayerAngles(player_start.angles);

  flag_set("crash_objective");
  flag_set("sentry_in_position");

  remove_tvs();
  exploder(333);

  flag_set("taco_goes_to_roof");

  flag_set("nates_bomb_incoming");

  thread diner_back_door_open();
  level.obj_sentry kill();
  flag_set("president_in_BT_meat_locker");

  thread handler_convoy();
}

black_screen_intro() {
  setSavedDvar("hud_drawhud", "0");
  level.player freezeControls(true);

  thread maps\_introscreen::introscreen_generic_black_fade_in(5.3, 1);

  lines = [];

  lines[lines.size] = &"INVASION_LINE1";

  lines["date"] = &"INVASION_LINE2";

  lines[lines.size] = &"INVASION_LINE3";

  lines[lines.size] = &"INVASION_LINE4";
  lines[lines.size] = &"INVASION_LINE5";

  maps\_introscreen::introscreen_feed_lines(lines);

  wait 5;
  level.player setplayerangles((0, 180, 0));

  level.player freezeControls(false);

  wait 1.8;

  level notify("introscreen_complete");

  wait(2);

  autosave_by_name("levelstart");
}

handler_humvee_to_yards() {
  level.vtmodel = "vehicle_hummer_viewmodel";
  level.vttype = "humvee";
  build_radiusdamage((0, 0, 53), 512, 90, 20, false);

  thread black_screen_intro();
  battlechatter_off("allies");

  thread dialog_intro();

  thread MusicPlayWrapper("invasion_intro");

  wait 2.5;

  first_planes = getent("first_flight", "script_noteworthy");
  first_planes notify("trigger");
  first_planes trigger_off();

  wait 1.5;

  level.player disableweapons();
  level.humvee_front = spawn_vehicle_from_targetname_and_drive("humvee_front");
  level.humvee_front.dontunloadonend = true;

  shotgun_guy = getent("shotgun", "script_noteworthy");
  shotgun_guy add_spawn_function(::setup_shotgun_guy);
  backseat_right_guy = getent("backseat_right", "script_noteworthy");
  backseat_right_guy add_spawn_function(::setup_backseat_right_guy);

  humvee_blows_up_riders = getEntArray("humvee_blows_up_riders", "targetname");
  array_thread(humvee_blows_up_riders, ::spawn_ai);

  level.humvee_player = spawn_vehicle_from_targetname_and_drive("humvee_player");
  level.humvee_player playSound("scn_invasion_humvee_ridein");
  level.humvee_player.dontunloadonend = true;

  org = level.humvee_player player_rides_shotgun_in_humvee();

  flag_wait("humvee_ride_roof_landing");

  thread roof_parachute_landing_guy_humvee();

  flag_wait("start_humvee_destroyer");

  level.raptor pushplayer(true);
  level.taco pushplayer(true);
  level.worm pushplayer(true);
  level.worm thread magic_bullet_shield();

  level.humvee_destroyer = spawn_vehicle_from_targetname_and_drive("humvee_destroyer");

  level.humvee_destroyer.veh_pathtype = "constrained";
  level.humvee_destroyer thread humvee_destroyer_action();

  wait 2;

  level.raptor thread dialogue_queue("inv_six_gotbmp");

  level.humvee_player Vehicle_SetSpeed(0, 10);

  wait 1;

  level.humvee_player thread vehicle_unload();
  activate_trigger_with_targetname("flee_humvee");
  wait 1;

  level.raptor pushplayer(true);
  level.taco pushplayer(true);
  level.worm pushplayer(true);

  org player_leaves_humvee();

  thread dialog_go_to_yards();

  wait 1;
  setSavedDvar("hud_drawhud", "1");

  level.raptor pushplayer(true);
  level.taco pushplayer(true);
  level.worm pushplayer(true);

  thread handler_yards_to_house_destroyer();
}

handler_yards_to_house_destroyer() {
  battlechatter_off("allies");

  spawner = getent("roof_parachute_landing_guy_yards", "targetname");

  flag_wait("entering_yards");

  autosave_by_name("yards");

  if(isalive(level.worm)) {
    if(isDefined(level.worm.magic_bullet_shield))
      level.worm thread stop_magic_bullet_shield();
  }
  level.raptor pushplayer(false);
  level.taco pushplayer(false);
  if(isalive(level.worm))
    level.worm pushplayer(false);

  thread enable_water_fx();

  level.roof_paratrooper = spawner spawn_ai();
  level.roof_paratrooper.ignoreme = true;

  thread dialog_yards_story();

  thread handler_house_destroyer_to_pizza();
}

handler_house_destroyer_to_pizza() {
  flag_wait("start_house_destroyer");

  autosave_by_name("hd");

  thread spawn_nates_attackers_in_alley();

  flag_init("house_destroyer_unloading");
  level.house_destroyer = spawn_vehicle_from_targetname("house_destroyer");
  level.house_destroyer thread setup_house_destroyer();

  thread dialog_bmp_hasnt_spotted_us();

  flag_wait("got_visual_on_crash");

  level.raptor dialogue_queue("inv_six_viscrashsite");

  battlechatter_on("allies");

  thread dialog_house_destroyer_unloading();
  thread flag_save("house_destroyer_unloading");

  thread wait_till_btr_smoked();
  thread watch_for_smoke_throws();
  thread dialog_semtex_that_bmp();

  thread btr_backed_off();

  thread handler_pizza_to_gas_station();
}

handler_pizza_to_gas_station() {
  thread spawn_tangled_chute_struggler();

  flag_wait("gas_station_truck_spawned");
  thread maps\_utility::set_ambient("invasion_ext3");
  thread setup_gas_station_truck();

  thread flag_save("leaving_gas_station");

  thread handler_gas_station_to_crash();
}

handler_gas_station_to_crash() {
  flag_wait("leaving_gas_station");

  burning_tree = getent("burning_tree", "script_noteworthy");
  burning_tree notify("stop_burning_tree");

  level.obj_direction = "north";
  thread dialog_going_to_crash_site();
  thread one_bmp_from_south();
  thread dialog_dont_engage_that_APC();
  thread dialog_waiting_at_crash_site();
  thread player_shooting_nates();
  thread spawn_president();

  if(!isDefined(level.wells)) {
    wells_spawner = getent("wells", "script_noteworthy");
    wells_spawner spawn_ai();
  }

  activate_trigger_with_targetname("advance_towards_nates");

  flag_wait("goto_wells_intro");
  thread mig_fly_overs();

  thread handler_crash();
}

handler_crash() {
  if(!isDefined(level.wells)) {
    wells_spawner = getent("wells", "script_noteworthy");
    wells_spawner spawn_ai();
  }

  thread police_car_cover_moment();
  level.taco set_force_color("g");

  activate_trigger_with_targetname("move_to_wells_intro");

  bank_nates_attackers = getEntArray("bank_nates_attackers", "targetname");
  foreach(spawner in bank_nates_attackers)
  guy = spawner spawn_ai();

  flag_wait("crash_objective");
  autosave_by_name("crash_site");
  level.obj_direction = "north";
  thread cleanse_the_world();

  thread handler_crash_to_roof();
}

police_car_cover_moment() {
  anim_node = getstruct("police_car_moment", "script_noteworthy");

  BadPlace_Cylinder("police_car_moment", -1, anim_node.origin, 600, 300, "axis");

  anim_node thread anim_generic_loop(level.wells, "invasion_vehicle_cover_dialogue_guy1_idle", "stop_invasion_vehicle_cover_dialogue_guy1_idle");

  level.raptor disable_ai_color();
  anim_node anim_generic_reach(level.raptor, "invasion_vehicle_cover_dialogue_guy2");

  flag_wait("crash_objective");

  thread dialog_wells_intro();

  anim_node notify("stop_invasion_vehicle_cover_dialogue_guy1_idle");

  anim_node thread anim_generic(level.wells, "invasion_vehicle_cover_dialogue_guy1");
  anim_node anim_generic(level.raptor, "invasion_vehicle_cover_dialogue_guy2");

  thread move_raptor_wells_and_worm();

  BadPlace_Delete("police_car_moment");
}

dialog_wells_intro() {
  if(flag("player_on_roof"))
    return;
  level endon("player_on_roof");

  thread battlechatter_off("allies");

  flag_wait("notetrack_gimmesitrep");

  level.raptor playSound("inv_six_gimmesitrep");

  flag_wait("notetrack_meatlocker");

  level.wells playSound("inv_sgw_meatlocker");

  flag_wait("notetrack_status");

  level.raptor playSound("inv_six_status");

  flag_wait("notetrack_unconscious");

  level.wells playSound("inv_sgw_unconscious");

  flag_wait("notetrack_whatelse");

  level.raptor playSound("inv_six_whatelse");

  flag_wait("notetrack_checkout");

  thread taco_to_meat_locker();

  flag_wait("notetrack_supplydrop");

  level.wells playSound("inv_sgw_supplydrop");

  flag_wait("notetrack_sentrygunsouth");

  level.raptor playSound("inv_six_sentrygunsouth");

  wait 3;

  flag_set("player_goto_roof");
  thread battlechatter_on("allies");

  wait 12;

  level.raptor dialogue_queue("inv_six_antitank");

  level.wells dialogue_queue("inv_sgw_allout");

  wait 1;

  level.raptor dialogue_queue("inv_six_rogerthat");

  flag_set("wells_intro_done");
}

handler_crash_to_roof() {
  thread kill_friendlies_on_roof();
  thread dialog_sentry_nags();
  thread dialog_enemies_on_roof();

  flag_wait("player_on_roof");

  thread battlechatter_on("allies");

  level.obj_direction = "south";

  nates_roof_volume_south = getent("nates_roof_volume_south", "targetname");
  friendlies = getaiarray("allies");
  for(i = 0; i < friendlies.size; i++) {
    if(i == 5) {
      break;
    }
    friendlies[i].goalheight = 80;
    friendlies[i].goalradius = 500;
    friendlies[i].fixednode = false;
    friendlies[i] setgoalpos(nates_roof_volume_south.origin);
    friendlies[i] setgoalvolume(nates_roof_volume_south);
  }
  level.raptor.goalheight = 80;
  level.raptor.goalradius = 500;
  level.raptor.fixednode = false;
  level.raptor setgoalpos(nates_roof_volume_south.origin);
  level.raptor setgoalvolume(nates_roof_volume_south);

  level.taco.goalheight = 80;
  level.taco.goalradius = 500;
  level.taco.fixednode = false;
  level.taco setgoalpos(nates_roof_volume_south.origin);
  level.taco setgoalvolume(nates_roof_volume_south);

  autosave_by_name("sentry_in_position");

  flag_set("bank_guys_retreat");

  wait 3;

  enemies = getaiarray("axis");
  foreach(guy in enemies)
  guy thread rush_restaurant_enemies_setup();

  level.truck_group_enemies_count_lives = 0;
  level.truck_group_enemies_alive = 0;
  level.truck_group_enemies_count_deaths = 0;
  truck1 = thread spawn_vehicle_from_targetname_and_drive("truck_group_left");
  truck1.veh_pathtype = "constrained";
  wait .1;

  truck2 = thread spawn_vehicle_from_targetname_and_drive("truck_group_right");
  truck2.veh_pathtype = "constrained";

  magic_smoke_grenades = getEntArray("magic_smoke_grenade", "targetname");
  array_thread(magic_smoke_grenades, ::enemy_uses_smoke);
  thread dialog_they_are_using_smoke();

  radio_dialogue("inv_six_headsupladies");
  thread dialog_foot_mobiles();

  wait 1;
  while(level.truck_group_enemies_alive > 5)
    wait 1;

  autosave_by_name("trucks_to_north");
  thread handler_roof_north_side();
}

handler_roof_north_side() {
  level.obj_direction = "north";
  magic_smoke_grenades = getEntArray("magic_smoke_grenade_north", "targetname");
  array_thread(magic_smoke_grenades, ::enemy_uses_smoke);

  level.truck_group_enemies_count_lives = 0;

  level.truck_group_enemies_count_deaths = 0;

  truck3 = thread spawn_vehicle_from_targetname_and_drive("truck_north_right");
  truck3.veh_pathtype = "constrained";
  wait .1;
  truck4 = thread spawn_vehicle_from_targetname_and_drive("truck_north_left");
  truck4.veh_pathtype = "constrained";

  thread dialog_smoke_to_north();

  radio_dialogue("inv_tco_incomingnorth");

  radio_dialogue("inv_six_rogerthat");

  thread friendlies_shift_north();
  flag_set("northside_roof");

  wait 6;

  radio_dialogue("inv_tco_contactnorth");

  radio_dialogue("inv_six_contactsn");

  radio_dialogue("inv_six_shiftfiren");

  thread wait_to_spawn_diner_defenders();

  while(level.truck_group_enemies_alive > 5)
    wait 1;

  level.obj_direction = "west";

  flag_set("truck_guys_retreat");

  wait 6;
  autosave_by_name("truck_retreat");

  south_side_nodes = getnodearray("south_side_nodes", "targetname");
  n = 0;
  nates_roof_volume_south = getent("nates_roof_volume_south", "targetname");
  friendlies = getaiarray("allies");
  for(i = 0; i < friendlies.size; i++) {
    if(cointoss()) {
      if(n >= south_side_nodes.size) {
        break;
      }

      friendlies[i].fixednode = false;
      friendlies[i] setgoalnode(south_side_nodes[n]);
      friendlies[i] setgoalvolume(nates_roof_volume_south);
      n++;
    }
  }

  radio_dialogue("inv_six_hadenough");

  radio_dialogue("inv_six_sitreponraptor");

  radio_dialogue("inv_tco_secureandstable");

  radio_dialogue("inv_six_checkammo");

  dialog_two_bmps_from_north();

  thread handler_roof_to_diner();
}

handler_roof_to_diner() {
  level.obj_direction = "west";
  if(isDefined(level.btr80_smash))
    thread btr80_smash();

  thread set_up_predator_drone_control_pickup();
  thread hellfire_attacks();

  friendlies = getaiarray("allies");
  foreach(friend in friendlies)
  friend cleargoalvolume();

  thread friendlies_try_to_get_off_roof();

  taco_scopes_diner = getnode("taco_scopes_diner", "targetname");
  if(isDefined(taco_scopes_diner))
    level.taco SetGoalNode(taco_scopes_diner);

  thread dialog_hellfire_attack_reaction();

  flag_waitopen("player_on_roof");

  flag_set("diner_attack");

  bmps = two_bmps_from_north();

  thread dialog_taco_sees_uav_op();

  thread taco_goes_to_diner();

  level add_wait(::flag_wait, "player_inside_nates");
  level add_func(::autosave_by_name, "go_to_diner");
  level thread do_wait();

  thread dialog_pickup_drone_control_nag();
  thread diner_backdoor_attack();

  thread handler_diner_defend();
}

handler_diner_defend() {
  flag_wait("player_has_predator_drones");
  level.obj_direction = "east";
  thread get_friendlies_away_from_nates_destruction();
  autosave_by_name("has_drones");

  activate_trigger_with_targetname("burger_town_enemy_defenders_trigger");
  thread taco_goes_to_BT();

  thread dialog_time_to_destroy_BMPS();

  thread spawn_battle_when_in_uav();

  flag_wait("bmp_north_left_dead");
  flag_wait("bmp_north_mid_dead");

  autosave_by_name("bmps_destroyed");

  thread dialog_regroup_at_nates_nag();

  thread handler_diner_to_burgertown();
}

handler_diner_to_burgertown() {
  flag_wait("leaving_diner");

  flag_set("nates_bomb_incoming");
  bomb_nates();

  level.obj_direction = "south";

  BT_goal = getnode("taco_in_BT", "script_noteworthy");
  BT_org = BT_goal.origin;
  BT_goal_volume = getent("BT_goal_volume", "targetname");

  redshirts_desired = 3;
  level.redshirts = redshirts_respawn(redshirts_desired);
  foreach(redshirt in level.redshirts)
  redshirt thread smart_barney("player_in_burgertown", BT_org, BT_goal_volume);

  flag_set("move_president_to_prep");

  thread dialog_nates_bombing_reaction();

  thread dialog_clear_burgertown_nag();

  level add_wait(::flag_wait, "player_in_burgertown");
  level add_func(::autosave_by_name, "player_in_burgertown");
  level thread do_wait();

  flag_wait("burger_town_lower_cleared");

  autosave_by_name("burgertown_cleared");
  thread handler_burgertown();
}

handler_burgertown() {
  flag_set("move_president_to_prep");

  level.obj_direction = undefined;

  wait 3;

  thread taco_goes_to_BT_roof();
  flag_set("taco_goes_to_roof");
  flag_set("time_to_clear_burgertown");

  wells_in_bushes = getnode("wells_in_bushes", "targetname");
  level.wells setgoalnode(wells_in_bushes);

  nates_regroup_enemies = getEntArray("nates_regroup_enemies", "targetname");
  array_thread(nates_regroup_enemies, ::spawn_ai);

  thread handler_vip_escort();
}

handler_vip_escort() {
  flag_set("move_president_to_prep");

  end_volume = getent("BT_goal_volume", "targetname");
  end_goal = getent("president_in_burgertown_meat_locker", "targetname").origin;

  redshirts_desired = 3;
  level.redshirts = redshirts_respawn(redshirts_desired);
  foreach(redshirt in level.redshirts)
  redshirt thread smart_barney_on_raptor(end_goal, end_volume);

  autosave_by_name("defend_prez");

  wait 1;

  radio_dialogue("inv_six_lockandload");

  wait 5;

  flag_waitopen_or_timeout("player_in_burgertown", 6);

  thread wells_cover_path();

  bt_locker = getent("president_in_burgertown_meat_locker", "targetname");

  level.president invisibleNotSolid();
  level.raptor pushplayer(true);
  level.raptor.dontchangepushplayer = true;
  wounded_carry_path = getent("wounded_carry_path", "targetname");

  level.raptor thread maps\_carry_ai::move_president_to_node(level.president, wounded_carry_path);

  radio_dialogue("inv_six_onthree");

  wait 1;

  radio_dialogue("inv_six_one");

  wait 1;

  radio_dialogue("inv_six_two");

  wait 1;

  radio_dialogue("inv_six_three");

  wait 1;

  radio_dialogue("inv_six_gogogo2");

  level.wells thread stop_magic_bullet_shield();
  level.raptor thread keep_enemies_away();
  thread dialog_keep_guys_off_me();
  thread wounded_carry_attackers();

  flag_wait("president_in_BT_meat_locker");

  thread dialog_team_were_inside();

  thread handler_defend_BT();
}

handler_defend_BT() {
  thread stinger_hint();
  thread bt_locker_door_close();
  setup_hunter_enemies();
  thread enemy_monitor();
  thread spawn_redshirts_during_BT_defend();

  flag_wait("first_attack_heli_spawned");
  eHeli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
  eHeli.circling = true;
  eHeli.no_attractor = true;
  level.attack_heli = thread maps\_attack_heli::begin_attack_heli_behavior(eHeli);

  thread dialog_first_attack_heli();

  thread spawn_rpg_redshirts();

  attacker = undefined;
  if(isalive(level.attack_heli))
    level.attack_heli waittill("death", attacker);
  flag_set("first_attack_heli_dead");

  if(isDefined(attacker) && isPlayer(attacker))
    thread dialog_shot_down_heli();
  thread autosave_by_name("heli_death");

  flag_wait("second_attack_heli_spawned");
  eHeli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
  eHeli.circling = true;
  eHeli.no_attractor = true;
  level.attack_heli = thread maps\_attack_heli::begin_attack_heli_behavior(eHeli);

  thread spawn_rpg_redshirts();
  thread dialog_second_attack_heli();

  attacker = undefined;
  if(isalive(level.attack_heli))
    level.attack_heli waittill("death", attacker);
  flag_set("second_attack_heli_dead");

  if(isDefined(attacker) && isPlayer(attacker))
    thread dialog_shot_down_heli();
  thread autosave_by_name("heli_death");

  wait 12;
  thread handler_convoy();
}

music_invasion_regroup_and_end() {
  thread music_regroup();

  flag_wait("player_at_convoy");

  music_stop(3);

  level.player playSound("invasion_ending");
}

music_regroup() {
  if(flag("player_at_convoy")) {
    return;
  }
  music_TIME = musicLength("invasion_regroup");

  level endon("player_at_convoy");

  while(1) {
    MusicPlayWrapper("invasion_regroup");

    wait music_TIME;
  }
}

handler_convoy() {
  wait 1;

  level.obj_direction = "south";
  center_spawner = undefined;
  convoy = getEntArray("convoy", "targetname");
  foreach(member in convoy) {
    if(!isDefined(member.script_noteworthy))
      continue;
    if(member.script_noteworthy == "obj_vehicle")
      center_spawner = member;
  }

  if(isDefined(center_spawner)) {
    while(player_looking_at(center_spawner.origin, 0, true) && flag("player_on_roof"))
      wait 1;
  }

  thread music_invasion_regroup_and_end();

  targets = getStructArray("convoy_targets", "targetname");
  humvees = [];

  thread dialog_come_to_convoy();
  foreach(member in convoy) {
    vehicle = member thread maps\_vehicle::spawn_vehicle_and_gopath();

    vehicle.dontunloadonend = true;

    vehicle thread convoy_targets(targets);
    vehicle thread setup_brakes();
    if(isDefined(member.script_noteworthy)) {
      humvees[humvees.size] = vehicle;
      if(member.script_noteworthy == "obj_vehicle")
        level.convoy = vehicle;
    }
  }
  flag_set("time_to_goto_convoy");

  enemies = getaiarray("axis");
  total = enemies.size;

  if(total < 12) {
    wounded_carry_attackers_TC = getEntArray("wounded_carry_attackers_TC", "targetname");
    array_thread(wounded_carry_attackers_TC, ::spawn_ai);
  }

  if(total < 6) {
    wounded_carry_attackers_gas = getEntArray("wounded_carry_attackers_gas", "targetname");
    array_thread(wounded_carry_attackers_gas, ::spawn_ai);
  }

  flag_wait("convoy_has_arrived");

  if(!isDefined(level.convoy.usedPositions)) {
    level.convoy.usedPositions = [];
  }
  level.convoy.usedPositions[3] = true;

  flag_set("convoy_in_position");

  flag_wait("player_at_convoy");
  thread friendlies_enter_humvees(humvees);
  thread player_enters_convoy_humvee();
  set_vision_set("invasion_near_convoy", 3);

  radio_dialogue("inv_hqr_sitrep");

  radio_dialogue("inv_six_cargosecure");

  radio_dialogue("inv_hqr_goodjob");

  wait 1;

  radio_dialogue("inv_fly_2kcivvies");

  nextmission();
}

stinger_hint() {
  flag_wait("first_attack_heli_spawned");

  while(1) {
    level.player waittill("begin_firing");
    weap = level.player GetCurrentWeapon();
    if(weap == "stinger") {
      if(level.player playerads() == 1.0)
        return;
      else {
        if(is_command_bound("+toggleads_throw"))
          display_hint_timeout("hint_toggle_ads_with_stinger", 5);
        else
          display_hint_timeout("hint_ads_with_stinger", 5);
      }
    }
  }
}

should_break_ads_with_stinger() {
  weap = level.player GetCurrentWeapon();
  if(weap == "stinger") {
    if(level.player playerads() == 1.0)
      return true;
    else
      return false;
  } else {
    return true;
  }
}

player_enters_convoy_humvee() {
  humvee = level.convoy;
  while(1) {
    if(humvee.veh_speed == 0) {
      break;
    }
    wait .5;
  }
  goal_pos = humvee gettagorigin("tag_guy1");

  while(1) {
    d = Distance(goal_pos, level.player.origin);
    if(d <= 70) {
      break;
    }
    wait .5;
  }
  move_time = 0.6;

  level.player AllowCrouch(false);
  level.player AllowProne(false);
  level.player DisableWeapons();

  org = spawn_tag_origin();
  org.origin = level.player.origin;
  org.angles = level.player.angles;
  level.player PlayerLinkTo(org, "tag_origin", 0.8, 180, 180, 40, 40);

  goal_pos = humvee gettagorigin("tag_guy1");
  org MoveTo(goal_pos + (0, 0, -30), move_time, move_time * 0.5, move_time * 0.5);

  wait(move_time);
}

setup_brakes() {
  self ent_flag_init("apply_brakes");

  self ent_flag_wait("apply_brakes");

  self.veh_brake = 1;
}

friendlies_enter_humvees(humvees) {
  friendly_redshirts = getEntArray("friendly_redshirt", "script_noteworthy");
  foreach(thing in friendly_redshirts) {
    if(!isai(thing)) {
      if(isspawner(thing)) {
        thing remove_spawn_function(::keep_red_shirts_alive_until_close);
        thing remove_spawn_function(::smart_roaming_barney);
      }
    }
  }

  humvees_left = humvees.size;
  while(humvees_left) {
    new_guys = spawn_humvee_boarders();
    foreach(guy in new_guys)
    thread guy_runtovehicle_load(guy, humvees[humvees_left - 1]);
    humvees_left--;
    wait 3;
  }
}

spawn_humvee_boarders() {
  group = "redshirt_spawn_group_BT";

  redshirt_spawn_groups = getStructArray(group, "targetname");
  farthest = getfarthest(level.player.origin, redshirt_spawn_groups);
  spawners = getEntArray(farthest.target, "targetname");
  println(" selected redshirt group: " + farthest.script_noteworthy);

  guys = [];
  foreach(spawner in spawners) {
    if(guys.size < 3) {
      spawner.count = 1;
      guys[guys.size] = spawner spawn_ai();
    }
  }
  return guys;
}

dialog_enemies_on_roof() {
  flag_wait("player_on_roof");
  level endon("diner_attack");

  dialog = [];

  dialog[dialog.size] = "inv_six_roofbehind";

  dialog[dialog.size] = "inv_six_enemiesonroof";

  dialog[dialog.size] = "inv_six_insideperim";

  dialog[dialog.size] = "inv_six_turnaround";

  current_line = 0;

  trig = getent("enemies_on_roof", "targetname");
  while(1) {
    trig waittill("trigger", other);

    println(other.classname + "" + other.origin);
    level.raptor dialogue_queue(dialog[current_line]);
    current_line++;
    if(current_line >= dialog.size)
      current_line = 0;

    wait 10;
  }
}

wait_to_spawn_diner_defenders() {
  flag_wait("player_on_roof");
  flag_waitopen("player_on_roof");

  activate_trigger_with_targetname("diner_enemy_defenders_trigger");
}

setup_remote_missile_target_guy() {
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "paradrop_guy_left")
      return;
    if(self.script_noteworthy == "paradrop_guy_right")
      return;
  }
  if(isDefined(self.ridingvehicle)) {
    self endon("death");
    self waittill("jumpedout");
  }
  self maps\_remotemissile::setup_remote_missile_target();
}

get_friendlies_away_from_nates_destruction() {
  nates_roof_volume_south = getent("nates_roof_volume_south", "targetname");
  destroyed_nates_inaccessable_volume = getent("destroyed_nates_inaccessable_volume", "targetname");

  destroyed_nates_safe_volume = getent("destroyed_nates_safe_volume", "targetname");
  destroyed_nates_safe_goal = getent("raptor_in_nates_prep", "targetname");

  friendlies = getaiarray("allies");
  foreach(friend in friendlies) {
    if((friend istouching(destroyed_nates_inaccessable_volume)) || (friend istouching(nates_roof_volume_south))) {
      friend.goalradius = 500;
      friend setgoalpos(destroyed_nates_safe_goal.origin);
      friend setgoalvolume(destroyed_nates_safe_volume);
      friend.fixednode = false;
    }
  }

  BadPlace_Brush("destroyed_nates_inaccessable_volume", -1, destroyed_nates_inaccessable_volume, "allies", "axis");
  BadPlace_Brush("nates_roof_volume_south", -1, nates_roof_volume_south, "allies", "axis");

  flag_wait("nates_bomb_incoming");

  BadPlace_Delete("destroyed_nates_inaccessable_volume");
  BadPlace_Delete("nates_roof_volume_south");
}

kill_friendlies_on_roof() {
  level endon("player_on_roof");
  roof_volume = getent("roof_volume", "targetname");
  friendlies = getaiarray("allies");
  foreach(friend in friendlies) {
    if(friend istouching(roof_volume)) {
      if(isDefined(friend.magic_bullet_shield))
        friend stop_magic_bullet_shield();
      friend kill();
      wait .5;
    }
  }
}

btr80_smash() {
  scripted_node = getent("btr80_smash", "targetname");

  scripted_node.origin = (805.9, -1688.8, 2309.7);

  scripted_node.angles = (0, 149, 0);
  level.player waittill_in_range(scripted_node.origin, 1350);

  btr = spawn_anim_model("btr_ground_smash");
  car = spawn_anim_model("btr_squashedcar");

  btr playSound("scn_invasion_btr_drop");
  scripted_node thread anim_single_solo(car, "btr_squashedcar");
  scripted_node thread anim_single_solo(btr, "btr_ground_smash");
}

friendlies_shift_north() {
  north_side_nodes = getnodearray("north_side_nodes", "targetname");
  nates_roof_volume_north = getent("nates_roof_volume_north", "targetname");
  friendlies = getaiarray("allies");

  level.raptor.goalheight = 80;
  level.raptor.goalradius = 500;
  level.raptor.fixednode = false;
  level.raptor setgoalnode(north_side_nodes[0]);
  level.raptor setgoalvolume(nates_roof_volume_north);

  num = 1;

  for(i = 0; i < friendlies.size; i++) {
    if(num >= north_side_nodes.size) {
      break;
    }
    if(!isalive(friendlies[i])) {
      continue;
    } else {
      friendlies[i].goalheight = 80;
      friendlies[i].goalradius = 500;
      friendlies[i].fixednode = false;
      friendlies[i] setgoalnode(north_side_nodes[num]);
      friendlies[i] setgoalvolume(nates_roof_volume_north);
      num++;
      wait 1;
    }
  }
}

spawn_nates_defenders() {
  flag_wait("leaving_gas_station");

  if(flag("nates_bomb_incoming"))
    return;
  nates_defenders = getEntArray("nates_defenders", "script_noteworthy");
  foreach(guy in nates_defenders)
  guy spawn_ai();
}

spawn_nates_attackers_in_alley() {
  flag_wait("spawn_nates_attackers_in_alley");
  alley_nates_attackers = getEntArray("alley_nates_attackers", "script_noteworthy");
  foreach(guy in alley_nates_attackers)
  guy spawn_ai();
}

spawn_battle_when_in_uav() {
  level waittill("player_is_controlling_UAV");

  uav_ambient_battle = getEntArray("uav_ambient_battle", "targetname");
  array_thread(uav_ambient_battle, ::spawn_ai);
}

convoy_targets(targets) {
  if(self.classname == "script_vehicle_hummer_minigun") {
    turret = self.mgturret[0];
    turret waittill("turret_ready");
    mg_guy = turret getturretowner();

    mg_guy.ignoreall = true;
    turret thread animscripts\hummer_turret\common::set_manual_target(level.player, 1, 6);
    mg_guy.ignoreall = false;
  } else {
    while(!flag("player_at_convoy")) {
      targets = array_randomize(targets);
      foreach(tgt in targets) {
        self setturrettargetvec(tgt.origin);
        self waittill("turret_on_target");
        self fireweapon();
        wait(randomfloatrange(.2, .6));
      }
    }
  }
}

dialog_shot_down_heli() {
  wait 3;

  radio_dialogue("inv_six_niceoneheli");
}

dialog_come_to_convoy() {
  level endon("player_at_convoy");

  wait 10;

  radio_dialogue("inv_six_convoyshere");

  wait 4;

  radio_dialogue("inv_six_southofbtown");

  wait 4;

  radio_dialogue("inv_tco_backtoconvoy");

  while(1) {
    wait 15;

    radio_dialogue("inv_six_convoyshere");

    wait 15;

    radio_dialogue("inv_six_southofbtown");

    wait 15;

    radio_dialogue("inv_tco_backtoconvoy");
  }
}

dialog_uav_the_infantry() {
  wait 8;

  if(isDefined(level.player.is_controlling_UAV))
    return;
  level endon("player_is_controlling_UAV");

  if(cointoss()) {
    radio_dialogue("inv_six_theinfantry");
  } else {
    radio_dialogue("inv_six_theinfantry2");
  }

  wait 5;

  level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone"));
}

dialog_first_attack_heli() {
  radio_dialogue("inv_hqr_enemyhelo");

  radio_dialogue("inv_six_takedown");

  thread dialog_get_stinger();
}

dialog_get_stinger() {
  level.attack_heli endon("death");
  wait 3;

  nates_dialog_current = 0;
  nates_dialog = [];

  nates_dialog[nates_dialog.size] = "inv_tco_roofofnates";

  nates_dialog[nates_dialog.size] = "inv_tco_killthathelo";

  nates_dialog[nates_dialog.size] = "inv_six_checktheroof";

  nates_dialog[nates_dialog.size] = "inv_six_supplydroponroof";

  diner_dialog_current = 0;
  diner_dialog = [];

  diner_dialog[diner_dialog.size] = "inv_tco_dispatchchopper";

  diner_dialog[diner_dialog.size] = "inv_tco_insidediner";

  diner_dialog[diner_dialog.size] = "inv_tco_nexttostation";

  diner_dialog[diner_dialog.size] = "inv_tco_dineruav";

  while(1) {
    needs_stinger = true;
    weapons = level.player GetWeaponsListAll();
    foreach(weap in weapons)
    if(weap == "stinger")
      needs_stinger = false;

    if(!needs_stinger) {
      wait 3;
      continue;
    }

    diner_stinger = getent("diner", "script_noteworthy");
    if(isDefined(diner_stinger)) {
      selected_line = diner_dialog[diner_dialog_current];
      radio_dialogue(selected_line);

      if(selected_line == "inv_tco_roofofnates")
        radio_dialogue("inv_tco_roofofnates2");

      if(selected_line == "inv_tco_killthathelo")
        radio_dialogue("inv_tco_killthathelo2");

      diner_dialog_current++;
      if(diner_dialog_current >= diner_dialog.size)
        diner_dialog_current = 0;
    } else {
      selected_line = nates_dialog[nates_dialog_current];

      radio_dialogue(selected_line);

      if(selected_line == "inv_tco_dispatchchopper")
        radio_dialogue("inv_tco_dispatchchopper2");

      if(selected_line == "inv_tco_insidediner")
        radio_dialogue("inv_tco_insidediner2");

      nates_dialog_current++;
      if(nates_dialog_current >= nates_dialog.size)
        nates_dialog_current = 0;
    }
    wait 50;
  }
}

dialog_destroyed_btr_with_uav() {
  level waittill("bmp_died");

  if(isDefined(level.player.fired_hellfire_missile)) {
    wait 3;
    if(flag("bmps_from_north_dead")) {
      return;
    }
    radio_dialogue("inv_six_onemore");
  }
}

dialog_second_attack_heli() {
  radio_dialogue("inv_hqr_relaygol1");

  radio_dialogue("inv_tco_eyesup");

  radio_dialogue("inv_six_anotherhelo");

  thread dialog_get_stinger();
}

fire_stinger_at_uav() {
  if(isDefined(level.uav_is_destroyed)) {
    return;
  }
  level.uav maps\_vehicle::godoff();
  level.uav.health = 400;

  level waittill("player_is_controlling_UAV");

  wait 2;

  thread dialog_missile_fired_at_stinger();

  forward = anglesToForward(level.uav.angles);
  forwardfar = vector_multiply(forward, 10000);
  end = forwardfar + level.uav.origin;

  attractor = Missile_CreateAttractorEnt(level.uav, 100000, 60000);

  newMissile = MagicBullet("zippy_rockets", (497.8, -3564.4, 2346), end);
  newMissile Missile_SetTargetEnt(level.uav);

  old_org = level.uav.origin;
  old_dist = 9999999999;
  while(isDefined(newMissile)) {
    if(!isalive(level.uav)) {
      break;
    }
    dist = Distance(newMissile.origin, level.uav.origin);
    if(dist <= 200) {
      break;
    }
    if(dist > (old_dist + 100)) {
      break;
    }
    old_dist = dist;
    old_org = level.uav.origin;
    wait .05;
  }
  Missile_DeleteAttractor(attractor);

  if(isDefined(newMissile))
    newMissile delete();
  playFX(getfx("uav_explosion"), old_org);

  level.uav_is_destroyed = true;
  level.player maps\_remotemissile::remove_uav_weapon();

  if(isDefined(level.uav))
    level.uav delete();
  level notify("uav_destroyed");

  wait 2;
  radio_dialogue_clear_stack();

  radio_dialogue("inv_tco_uavoffline");
}

dialog_missile_fired_at_stinger() {
  wait 2;
  radio_dialogue_clear_stack();

  radio_dialogue("inv_tco_firedmissile");
}

dialog_enemy_attack_heli() {
  radio_dialogue("inv_hqr_enemyhelo");

  radio_dialogue("inv_hqr_relaygol1");

  radio_dialogue("inv_hqr_capunavail");

  radio_dialogue("inv_tco_eyesup");
}

spawn_redshirts_during_BT_defend() {
  friendly_redshirts = getEntArray("friendly_redshirt", "script_noteworthy");
  foreach(thing in friendly_redshirts) {
    if(isai(thing)) {
      if(isalive(thing)) {
        thing thread keep_red_shirts_alive_until_close();
        thing thread smart_roaming_barney();
      }
    } else {
      if(isspawner(thing)) {
        thing add_spawn_function(::keep_red_shirts_alive_until_close);
        thing add_spawn_function(::smart_roaming_barney);
      }
    }
  }

  if(!isDefined(level.redshirts))
    level.redshirts = [];

  level endon("time_to_goto_convoy");

  while(1) {
    wait 1;

    redshirts_desired = 3;

    level.redshirts = redshirts_respawn(redshirts_desired);
  }
}

keep_red_shirts_alive_until_close() {
  self.ignored_by_attack_heli = true;
  self thread magic_bullet_shield();

  self waittill_entity_in_range(level.player, 600);

  self.ignored_by_attack_heli = undefined;
  self thread stop_magic_bullet_shield();
}

smart_barney(end_flag, end_goal, end_volume) {
  self endon("stop_barney");
  self endon("death");
  self ClearGoalVolume();
  self thread friendly_adjust_movement_speed();
  self.goalheight = 80;
  self.goalradius = 500;
  self.useChokePoints = false;

  self.fixednode = false;

  nates_roof_goal_volume = getent("nates_roof_goal_volume", "targetname");
  BT_roof_goal_volume = getent("BT_roof_goal_volume", "targetname");

  if(!isDefined(self.favoriteenemy)) {
    goal_enemies = end_volume get_ai_touching_volume("axis");
    if(goal_enemies.size)
      self.favoriteenemy = goal_enemies[0];
  }

  while(!flag(end_flag)) {
    if(flag("player_on_burgertown_roof")) {
      self setgoalpos(BT_roof_goal_volume.origin);
      self setgoalvolume(BT_roof_goal_volume);
    } else if(flag("player_on_roof")) {
      self setgoalpos(nates_roof_goal_volume.origin);
      self setgoalvolume(nates_roof_goal_volume);
    } else {
      self cleargoalvolume();
      player = level.player.origin;
      vec = VectorNormalize(end_goal - player);
      forward = vector_multiply(vec, 400);
      goal = forward + player;
      self setgoalpos(goal);
    }

    wait 2;
    self.favoriteenemy = undefined;
  }
  self notify("stop_adjust_movement_speed");
  self.moveplaybackrate = 1.0;

  self setgoalpos(end_goal);
  self setgoalvolume(end_volume);
}

smart_roaming_barney() {
  self notify("stop_barney");
  self endon("stop_barney");
  self endon("death");
  self ClearGoalVolume();
  self thread friendly_adjust_movement_speed();
  self.goalheight = 80;
  self.useChokePoints = false;
  if(!isDefined(self.big_goal))
    self.goalradius = 500;
  else
    self.goalradius = 1000;
  self.fixednode = false;

  nates_roof_goal_volume = getent("nates_roof_goal_volume", "targetname");
  BT_roof_goal_volume = getent("BT_roof_goal_volume", "targetname");

  while(1) {
    if(flag("player_on_burgertown_roof")) {
      self setgoalpos(BT_roof_goal_volume.origin);
      self setgoalvolume(BT_roof_goal_volume);
    } else if(flag("player_on_roof")) {
      self setgoalpos(nates_roof_goal_volume.origin);
      self setgoalvolume(nates_roof_goal_volume);
    } else {
      self cleargoalvolume();
      if(isDefined(level.obj_pos)) {
        end_goal = level.obj_pos;
        player = level.player.origin;
        vec = VectorNormalize(end_goal - player);
        forward = vector_multiply(vec, 400);

        my_origin = self.origin;
        forward = (forward[0], forward[1], 0);
        goal = forward + player;
      } else {
        goal = level.player.origin;
      }
      self setgoalpos(goal);
    }

    wait 2;
  }
  self notify("stop_adjust_movement_speed");
  self.moveplaybackrate = 1.0;
}

enemy_monitor() {
  if(!isDefined(level.num_of_enemy_forces_spawned))
    level.num_of_enemy_forces_spawned = 0;

  level.enemy_force[0] = "taco_enemies";
  level.enemy_force[1] = "gas_station_enemies";
  level.enemy_force[2] = "bank_enemies";

  level.dialog = [];

  level.dialog["bank_enemies"][0] = "inv_hqr_enemynorth";

  level.dialog["bank_enemies"][1] = "inv_hqr_banktonorth";

  level.dialog["bank_enemies"][2] = "inv_hqr_footmobiles";

  level.dialog["taco_enemies"][0] = "inv_hqr_southeast";

  level.dialog["taco_enemies"][1] = "inv_hqr_visualse";

  level.dialog["taco_enemies"][2] = "inv_hqr_tacojoint";

  level.dialog["gas_station_enemies"][0] = "inv_hqr_novagasstation";

  level.dialog["gas_station_enemies"][1] = "inv_hqr_enemywest";

  level.dialog["gas_station_enemies"][2] = "inv_hqr_dinerwest";

  level.enemy_heli_attacking = false;
  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  level.enemy_groups = getEntArray("enemy_groups", "targetname");

  while(true) {
    enemies = getaiarray("axis");
    total = enemies.size;
    roaming = total;
    println(" total: " + total);

    if(roaming < 7) {
      if(flag("first_attack_heli_dead")) {
        level.num_of_enemy_forces_spawned++;
        level notify("enemy_group_spawning");
        println(" level.num_of_enemy_forces_spawned: " + level.num_of_enemy_forces_spawned);
        spawn_enemy_group();

        wait 9;

        flag_set("second_attack_heli_spawned");
        thread autosave_by_name("reinforcements");

        flag_wait("second_attack_heli_dead");
        thread autosave_by_name("reinforcements");
        return;
      }

      if((level.num_of_enemy_forces_spawned == 3) && !flag("first_attack_heli_spawned")) {
        wait 12;
        thread autosave_by_name("reinforcements");
        flag_set("first_attack_heli_spawned");
        flag_wait("first_attack_heli_dead");

        wait 5;
        continue;
      }

      if(level.num_of_enemy_forces_spawned >= 2)
        thread fire_stinger_at_uav();

      level.num_of_enemy_forces_spawned++;
      level notify("enemy_group_spawning");
      println(" level.num_of_enemy_forces_spawned: " + level.num_of_enemy_forces_spawned);
      if(level.num_of_enemy_forces_spawned == 1)
        thread dialog_uav_the_infantry();
      if(level.num_of_enemy_forces_spawned == 2)
        thread dialog_uav_the_infantry();

      spawn_enemy_group();
    }
    wait 1;
  }
}

spawn_enemy_group() {
  closest = getclosest(level.player.origin, level.enemy_groups);

  if(closest.target == level.enemy_force[level.selection])
    level.selection++;
  if(level.selection >= level.enemy_force.size)
    level.selection = 0;

  selection = level.enemy_force[level.selection];

  level.selection++;
  if(level.selection >= level.enemy_force.size)
    level.selection = 0;

  if(selection == "bank_enemies")
    level.obj_direction = "north";
  if(selection == "gas_station_enemies")
    level.obj_direction = "west";
  if(selection == "taco_enemies")
    level.obj_direction = "east";

  wait 1;

  thread autosave_by_name("reinforcements");

  wait 3;

  enemy_spawners = getEntArray(selection, "targetname");
  for(i = 0; i < enemy_spawners.size; i++) {
    enemy_spawners[i].count = 1;
    guy = enemy_spawners[i] spawn_ai();
    wait .1;
  }
  wait 1;

  sound_selection = randomint(level.dialog[selection].size);
  thread radio_dialogue(level.dialog[selection][sound_selection]);

  wait 3;

  if(!isDefined(level.uavTargetPos)) {
    if(level.num_of_enemy_forces_spawned < 3) {
      foreach(group in level.enemy_groups)
      if(group.target == selection)
        level.uavTargetPos = group.origin;
    }
  }
}

dialog_team_were_inside() {
  radio_dialogue("inv_six_gotthepresident");

  radio_dialogue("inv_six_friedlyconvoy");
}

mission_fail_if_leaves_BT() {
  level endon("convoy_is_here");
  while(1) {
    flag_waitopen("player_is_close_to_BT");
    thread mission_fail_if_leaves_BT_waiter();

    flag_wait("player_is_close_to_BT");
  }
}

mission_fail_if_leaves_BT_waiter() {
  level endon("convoy_is_here");
  level endon("player_is_close_to_BT");
  level notify("warning_player_is_leaving_BT");

  wait 2;

  level notify("warning_player_is_leaving_BT");

  wait 2;

  level notify("warning_player_is_leaving_BT");

  wait 1;

  setDvar("ui_deadquote", &"INVASION_FAIL_ABANDONED");
  maps\_utility::missionFailedWrapper();
}

nates_locker_door_open() {
  nates_meat_locker_door = getent("nates_meat_locker_door", "targetname");
  nates_meat_locker_door_model = getent(nates_meat_locker_door.target, "targetname");
  nates_meat_locker_door_model LinkTo(nates_meat_locker_door);
  nates_meat_locker_door rotateyaw(-82, .1, 0, 0);
  nates_meat_locker_door connectpaths();

  flag_wait("player_on_roof");

  wait 3;

  flag_wait("player_on_roof");

  nates_meat_locker_door rotateyaw(82, .1, 0, 0);
  nates_meat_locker_door disconnectpaths();
}

bt_locker_door_open() {
  BT_locker_door = getent("BT_locker_door", "targetname");
  BT_locker_door rotateyaw(-172, .1, 0, 0);
  BT_locker_door connectpaths();
}

bt_locker_door_close() {
  wait 1;
  flag_waitopen("player_is_near_BT_locker_door");

  BT_locker_door = getent("BT_locker_door", "targetname");
  BT_locker_door rotateyaw(172, .1, 0, 0);
  BT_locker_door disconnectpaths();

  thread radio_dialogue("inv_six_gotthepresident2");

  if(isalive(level.president)) {
    if(isDefined(level.president.being_carried))
      level.president waittill("stop_putdown");

    level.president stop_magic_bullet_shield();
    level.president delete();
  }
  level.raptor stop_magic_bullet_shield();
  level.raptor delete();
}

keep_enemies_away() {
  vip_escort_bad_place1 = getent("vip_escort_bad_place1", "targetname");
  vip_escort_bad_place2 = getent("vip_escort_bad_place2", "targetname");
  vip_escort_bad_place3 = getent("vip_escort_bad_place3", "targetname");

  BadPlace_Brush("vip_escort_bad_place1", -1, vip_escort_bad_place1, "axis");
  BadPlace_Brush("vip_escort_bad_place2", -1, vip_escort_bad_place2, "axis");
  BadPlace_Brush("vip_escort_bad_place3", -1, vip_escort_bad_place3, "axis");
  flag_wait("president_in_BT_meat_locker");
  BadPlace_Delete("vip_escort_bad_place1");
  BadPlace_Delete("vip_escort_bad_place2");
  BadPlace_Delete("vip_escort_bad_place3");
}

dialog_go_to_yards() {
  wait 2;
  flag_set("follow_foley");

  level.raptor dialogue_queue("inv_six_teamthisway");
}

dialog_yards_story() {
  level endon("dialog_bmp_hasnt_spotted_us");

  level.raptor dialogue_queue("inv_six_reqairsupport");

  level.raptor dialogue_queue("inv_hqr_engaged");

  level.raptor dialogue_queue("inv_hqr_engaged2");

  level.raptor dialogue_queue("inv_six_onfoot");

  level.raptor dialogue_queue("inv_six_onfoot2");

  level.raptor dialogue_queue("inv_hqr_goodluck");

  wait 2;

  level.raptor dialogue_queue("inv_tco_fourselves");

  level.taco dialogue_queue("inv_six_prettymuch");

  wait 4;

  level.raptor dialogue_queue("inv_six_300meast");

  level.taco dialogue_queue("inv_tco_rogerthat");
}

bomb_nates() {
  migs = spawn_vehicles_from_targetname_and_drive("bomb_nates");

  thread radio_dialogue("inv_six_fastmovers");

  wait 3.5;

  remove_tvs();
  exploder(333);

  bomb_center = (257.2, -4669.1, 2381);
  if(distance(level.player.origin, bomb_center) < 500)
    level.player dodamage((level.player.health + 1000), bomb_center);

  delaythread(2, ::falling_debri_on_player);

  earthquake(.4, 3, level.player.origin, 8000);
}

falling_debri_on_player() {
  player = getEntArray("player", "classname")[0];
  numLoops = 30;

  for(i = 0; i < numLoops; i++) {
    playFX(level._effect["falling_debris_player"], player.origin + (0, 0, 500));
    wait(0.25);
  }
}

remove_tvs() {
  destructible_tvs = getEntArray("exploder_tv_333", "script_noteworthy");
  foreach(tvi, tv in destructible_tvs)
  tv Delete();
}

enable_water_fx() {
  friendlies = getaiarray("allies");
}

friendlies_try_to_get_off_roof() {
  wait 5;
  off_roof_array = getnodearray("off_roof", "targetname");
  pos = 0;
  roof_volume = getent("roof_volume", "targetname");
  friendlies = getaiarray("allies");
  foreach(friend in friendlies) {
    if(friend == level.taco)
      continue;
    if(friend istouching(roof_volume)) {
      friend setgoalnode(off_roof_array[pos]);
      pos++;
      friend.goalradius = 96;
      friend.goalheight = 64;
    }
  }
}

setup_count_predator_infantry_kills() {
  self waittill("death");

  wait .05;

  if(!isDefined(level.enemies_killed))
    level.enemies_killed = 1;
  else
    level.enemies_killed++;
}

dialog_handle_predator_infantry_kills() {
  dialog10 = [];

  dialog10[dialog10.size] = "inv_hqr_tenpluskia";

  dialog10[dialog10.size] = "inv_hqr_tenmoreconfirms";

  dialog10[dialog10.size] = "inv_hqr_fivenotenkills";
  current_dialog10 = 0;

  dialog5 = [];

  dialog5[dialog5.size] = "inv_hqr_fiveplus";

  dialog5[dialog5.size] = "inv_hqr_another5plus";

  dialog5[dialog5.size] = "inv_hqr_morethanfive";
  current_dialog5 = 0;

  said_hes_down = false;
  said_direct_hit = false;
  level.enemies_killed = 0;
  kills = 0;

  while(1) {
    level waittill("remote_missile_exploded");
    old_num = level.enemies_killed;

    wait .1;

    if(isDefined(level.uav_killstats["ai"]))
      kills = level.uav_killstats["ai"];

    if(kills == 0) {
      continue;
    }
    wait .5;

    if(isDefined(level.uav_is_destroyed)) {
      return;
    }
    if(kills == 1) {
      if(said_hes_down) {
        radio_dialogue("inv_hqr_yougotem");
        said_hes_down = false;
      } else {
        radio_dialogue("inv_hqr_hesdown");
        said_hes_down = true;
      }
      continue;
    }
    if(kills >= 10) {
      radio_dialogue(dialog10[current_dialog10]);
      current_dialog10++;
      if(current_dialog10 >= dialog10.size)
        current_dialog10 = 0;
      continue;
    }
    if(kills >= 5) {
      radio_dialogue(dialog5[current_dialog5]);
      current_dialog5++;
      if(current_dialog5 >= dialog5.size)
        current_dialog5 = 0;
      continue;
    } else {
      if(said_direct_hit) {
        radio_dialogue("inv_hqr_goodkills");
        said_direct_hit = false;
      } else {
        radio_dialogue("inv_hqr_directhit");
        said_direct_hit = true;
      }
      continue;
    }
  }
}

diner_backdoor_attack() {
  flag_wait("player_in_diner");
  autosave_by_name("at_diner");
  wait 2;
  flag_wait("player_in_diner");

  level.taco dialogue_queue("inv_tco_incoming");

  thread diner_back_door_open();

  trigger = getent("diner_enemy_counter_attack_trigger", "targetname");
  spawners = getEntArray(trigger.target, "targetname");
  array_thread(spawners, ::add_spawn_function, ::setup_diner_backdoor_attackers);
  activate_trigger_with_targetname("diner_enemy_counter_attack_trigger");
  flag_set("back_door_attack_start");

  level.taco dialogue_queue("inv_tco_backdoor");
}

diner_back_door_open() {
  diner_back_door = getent("diner_back_door", "targetname");
  diner_back_door rotateyaw(85, .3);
  diner_back_door playSound("diner_backdoor_slams_open");
  diner_back_door connectpaths();
}

dialog_smoke_to_north() {
  flag_clear("smoke_screen_starting");

  flag_wait("smoke_screen_starting");
  wait 4;

  radio_dialogue("inv_tco_smokescrnth");

  radio_dialogue("inv_six_switchthermal");
}

prep_prez_for_run() {
  wells_in_nates_prep = getent("wells_in_nates_prep", "targetname");
  level.wells setgoalpos(wells_in_nates_prep.origin);

  raptor_prep = getent("raptor_in_nates_prep", "targetname");
  level.raptor maps\_carry_ai::move_president_to_node(level.president, raptor_prep);
}

wounded_carry_attackers() {
  while((getaiarray("axis")).size > 4)
    wait 1;

  wounded_carry_attackers_gas = getEntArray("wounded_carry_attackers_gas", "targetname");
  array_thread(wounded_carry_attackers_gas, ::spawn_ai);

  while((getaiarray("axis")).size > 4)
    wait 1;

  wounded_carry_attackers = getEntArray("wounded_carry_attackers_bus", "targetname");
  array_thread(wounded_carry_attackers, ::spawn_ai);

  while((getaiarray("axis")).size > 4)
    wait 1;

  wounded_carry_attackers_TC = getEntArray("wounded_carry_attackers_TC", "targetname");
  array_thread(wounded_carry_attackers_TC, ::spawn_ai);
}

wells_cover_path() {
  level.raptor endon("death");
  level.wells endon("death");
  wells_cover_path = getnode("wells_cover_path", "script_noteworthy");
  level.wells SetGoalNode(wells_cover_path);
  level.wells waittill("goal");

  current_node = wells_cover_path;
  while(1) {
    while(distance(level.wells.origin, level.raptor.origin) > 300)
      wait .1;

    if(!isDefined(current_node.target)) {
      break;
    }
    new_goal = getnode(current_node.target, "targetname");

    level.wells SetGoalNode(new_goal);
    current_node = new_goal;
    level.wells waittill("goal");
  }
}

dialog_keep_guys_off_me() {
  level endon("president_in_BT_meat_locker");
  level.raptor endon("death");

  wait 6;

  level.raptor dialogue_queue("inv_six_teamthisway");

  wait 5;

  level.raptor dialogue_queue("inv_six_keepoffme");

  wait 1;

  level.taco dialogue_queue("inv_tco_hesdown");

  wait 5;

  level.raptor dialogue_queue("inv_six_onme");

  level.raptor dialogue_queue("inv_six_gogogo");

  wait 4;
}

dialog_regroup_at_nates_nag() {
  flag_wait("bmp_north_left_dead");
  flag_wait("bmp_north_mid_dead");

  diner_backdoor_fight_area = getent("diner_backdoor_fight_area", "targetname");
  diner_backdoor_fight_area waittill_volume_dead();

  if(flag("leaving_diner"))
    return;
  level endon("leaving_diner");

  while(1) {
    wait 2;

    radio_dialogue("inv_six_regroup");

    wait 15;

    radio_dialogue("inv_six_regroupinrest");

    wait 15;
  }
}

spawn_wells(start_ent) {
  if(isDefined(level.wells))
    return;
  spawner = getent("wells", "script_noteworthy");
  level.wells = spawner spawn_ai();

  if(isDefined(start_ent)) {
    wait .5;

    level.wells teleport_ent(start_ent);
    level.wells setgoalpos(start_ent.origin);
  }
}

spawn_president() {
  if(isDefined(level.president))
    return;
  president_spawner = getent("president", "script_noteworthy");
  level.president = president_spawner spawn_ai();
}

setup_president() {
  self.has_no_ir = true;
  level.president = self;
  self thread magic_bullet_shield();

  president_start_node = getent("president_in_nates_meat_locker", "targetname");
  self thread maps\_carry_ai::setWounded(president_start_node);

  flag_wait("move_president_to_prep");
  president_start_node notify("stop_wounded_idle");

  president_start_node = getent("president_in_nates_prep", "targetname");
  self maps\_carry_ai::setWounded(president_start_node);
}

dialog_house_destroyer_unloading() {
  flag_wait("house_destroyer_unloading");
  autosave_by_name("unloading");

  level.raptor dialogue_queue("inv_six_grabrpg");
}

dialog_incoming_south_side() {
  radio_dialogue("inv_tco_incomingnorth");

  radio_dialogue("inv_tco_contactnorth");
}

dialog_incoming_northside() {
  radio_dialogue("inv_tco_incomingsouth");

  radio_dialogue("inv_tco_contactsouth");
}

dialog_foot_mobiles() {
  wait 12;

  radio_dialogue("inv_six_2dozen");
}

dialog_intro() {
  radio_dialogue("inv_gm1_eastof95");

  radio_dialogue("inv_gm2_airsupport");

  radio_dialogue("inv_gm3_cutoff");

  radio_dialogue("inv_gm4_brokenarrow");

  radio_dialogue("inv_gm1_495and50");
}

player_shooting_nates() {
  level endon("player_on_roof");
  level endon("crash_objective");
  flag_wait("player_shooting_nates");

  level.raptor thread dialogue_queue("inv_six_purplebuilding");
}

dialog_going_to_crash_site() {
  radio_dialogue("inv_six_onme");

  radio_dialogue("inv_six_gogogo");
}

dialog_waiting_at_crash_site() {
  last_line = true;
  level endon("crash_objective");
  flag_wait("raptor_at_crash_site");

  while(1) {
    wait 10;

    if(last_line) {
      radio_dialogue("inv_six_crashsite");
      last_line = false;
    } else {
      radio_dialogue("inv_six_northofnates");
      last_line = true;
    }
  }
}

friendlies_duck_from_house_destroyer() {
  wait 1;

  allies = getaiarray("allies");
  for(i = 0; i < allies.size; i++) {
    allies[i] thread prone_till_flag("bmp_out_of_sight");
  }

  wait 5;

  flag_set("bmp_out_of_sight");
}

prone_till_flag(msg) {
  self endon("death");
  wait(randomfloatrange(0, .5));
  self allowedstances("prone");
  old_goal = self.goalpos;
  self anim_generic_custom_animmode(self, "gravity", "pronehide_dive");

  flag_wait(msg);

  wait(randomfloatrange(0, .5));

  self allowedstances("stand", "prone", "crouch");
}

btr_backed_off() {
  pos = getvehiclenode("friendlies_move_to_alley", "script_noteworthy");
  pos waittill("trigger");

  flag_set("btr_backed_away");
  level.house_destroyer notify("backed_away");

  activate_trigger_with_targetname("friendlies_hide_in_alley");
}

hint_drone_steering() {
  while(!flag("bmps_from_north_dead")) {
    level waittill("player_fired_remote_missile");
    num = level.bmps_from_north_dead;
    level waittill("remote_missile_exploded");
    wait 1;
    if(!(level.bmps_from_north_dead > num)) {
      level.hint_steer_drone_time = gettime();
      level.player thread display_hint("hint_steer_drone");
    }
  }
}

wait_till_time_to_destroy_BMPS() {
  level endon("leaving_diner");

  diner_backdoor_fight_area = getent("diner_backdoor_fight_area", "targetname");
  diner_backdoor_fight_area waittill_volume_dead();

  wait 2;
}

dialog_time_to_destroy_BMPS() {
  level endon("bmps_from_north_dead");
  wait_till_time_to_destroy_BMPS();

  if(flag("bmps_from_north_dead")) {
    return;
  }

  radio_dialogue("inv_six_neutralizearmor");

  level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));

  thread hint_drone_steering();

  wait 25;

  while(1) {
    if((flag("bmp_north_left_dead")) || (flag("bmp_north_mid_dead"))) {
      r = randomint(3);
      if(r == 0) {
        dialog_time_to_destroy_BMPS_action("inv_six_stillonebmp");

        level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));
      } else if(r == 1) {
        dialog_time_to_destroy_BMPS_action("inv_six_wastethatbmpnow");

        level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));
      } else {
        dialog_time_to_destroy_BMPS_action("inv_six_neutralizearmor");

        level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));
      }
    } else {
      if(cointoss()) {
        dialog_time_to_destroy_BMPS_action("inv_six_wastebmpsnow");

        level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));
      } else {
        dialog_time_to_destroy_BMPS_action("inv_six_destroyapcs");

        level.player thread display_hint(level.player get_remotemissile_hint_string("hint_predator_drone_vs_bmps"));
      }
    }
    wait 25;
  }
}

dialog_time_to_destroy_BMPS_action(dialog) {
  if(flag("nates_bomb_incoming") && !flag("nates_bombed")) {
    return;
  }
  radio_dialogue(dialog);
}

dialog_dont_engage_that_APC() {
  level endon("crash_objective");

  pos = getvehiclenode("dont_engage_dialog", "script_noteworthy");
  pos waittill("trigger", apc);

  apc waittill_player_lookat_for_time(.4, .99);

  level.raptor thread dialogue_queue("inv_six_dontengageapc");
}

dialog_two_bmps_from_north() {
  radio_dialogue("inv_six_bmpsfromnorth");

  radio_dialogue("inv_tco_rogerthat");
}

dialog_clear_burgertown_nag() {
  if(flag("burger_town_lower_cleared"))
    return;
  level endon("burger_town_lower_cleared");
  wait 60;
  while(1) {
    flag_waitopen("player_in_burgertown");

    radio_dialogue("inv_six_hostilesinbt");
    wait 20;

    flag_waitopen("player_in_burgertown");

    radio_dialogue("inv_six_needtomove");
    wait 20;

    flag_waitopen("player_in_burgertown");

    radio_dialogue("inv_six_whatsholdup");
    wait 20;
  }
}

spawn_rpg_redshirts() {
  group = "friendly_redshirt_rpg_BT_spawners";

  redshirt_spawn_groups = getEntArray(group, "targetname");

  respawns = 5;

  while(respawns > 0) {
    farthest_spawner = getfarthest(level.player.origin, redshirt_spawn_groups);
    farthest_spawner.count = 1;
    guy = farthest_spawner spawn_ai();
    respawns--;

    if(isalive(guy))
      guy waittill("death");
    else
      wait 1;
  }
}

setup_rpg_redshirts() {
  self.big_goal = true;

  self thread smart_roaming_barney();

  self.ignored_by_attack_heli = true;
  self thread magic_bullet_shield();

  self waittill_entity_in_range(level.player, 600);

  self.ignored_by_attack_heli = undefined;
  self thread stop_magic_bullet_shield();

  self endon("death");
  while(!isalive(level.attack_heli))
    wait 1;
  self.combatmode = "no_cover";
  self setentitytarget(level.attack_heli);
  wait 1;
  self.combatmode = "no_cover";

  while(isalive(level.attack_heli))
    wait 1;

  self clearentitytarget();
}

spawn_redshirts(desired_num) {
  if(!isDefined(desired_num))
    desired_num = 3;
  if(flag("president_in_BT_meat_locker"))
    group = "redshirt_spawn_group_BT";
  else
    group = "redshirt_spawn_group";

  redshirt_spawn_groups = getStructArray(group, "targetname");
  farthest = getfarthest(level.player.origin, redshirt_spawn_groups);
  spawners = getEntArray(farthest.target, "targetname");
  println(" selected redshirt group: " + farthest.script_noteworthy);

  guys = [];
  foreach(spawner in spawners) {
    if(guys.size < desired_num) {
      spawner.count = 1;
      guys[guys.size] = spawner spawn_ai();
    }
  }
  return guys;
}

redshirts_respawn(redshirts_desired) {
  current_redshirts = [];
  foreach(redshirt in level.redshirts) {
    if(isalive(redshirt))
      current_redshirts[current_redshirts.size] = redshirt;
  }
  num_desired = redshirts_desired - current_redshirts.size;
  new_guys = [];
  if(num_desired > 0)
    new_guys = spawn_redshirts(num_desired);

  guys = array_merge(current_redshirts, new_guys);
  return guys;
}

taco_goes_to_BT() {
  flag_wait("leaving_diner");

  BT_goal = getnode("taco_in_BT", "script_noteworthy");
  BT_org = BT_goal.origin;
  BT_goal_volume = getent("BT_goal_volume", "targetname");

  level.taco thread smart_barney("player_in_burgertown", BT_org, BT_goal_volume);

  redshirts_desired = 3;

  level.redshirts = redshirts_respawn(redshirts_desired);

  foreach(redshirt in level.redshirts)
  redshirt thread smart_barney("player_in_burgertown", BT_org, BT_goal_volume);
}

taco_goes_to_diner() {
  flag_waitopen("player_on_roof");
  wait 2;
  flag_waitopen("player_inside_nates");

  diner_goal_volume = getent("diner_goal_volume", "targetname");
  diner_org = getent("predator_drone_control", "targetname").origin;

  level.taco thread smart_barney("player_in_diner", diner_org, diner_goal_volume);
  level.redshirts = spawn_redshirts(3);
  foreach(redshirt in level.redshirts)
  redshirt thread smart_barney("player_in_diner", diner_org, diner_goal_volume);
}

smart_barney_on_raptor(end_goal, end_volume) {
  self endon("stop_barney");
  self endon("death");
  self ClearGoalVolume();

  self.goalheight = 80;
  self.goalradius = 500;

  self.fixednode = false;

  while(!flag("president_in_BT_meat_locker")) {
    leader = level.raptor.origin;
    vec = VectorNormalize(end_goal - leader);
    forward = vector_multiply(vec, 400);
    goal = forward + leader;
    self setgoalpos(goal);

    if(!isDefined(self.favoriteenemy)) {
      self.favoriteenemy = get_closest_ai(self.origin, "axis");
    }

    wait .5;
  }

  self setgoalpos(end_goal);
  self setgoalvolume(end_volume);
}

friendly_adjust_movement_speed() {
  self notify("stop_adjust_movement_speed");
  self endon("death");
  self endon("stop_adjust_movement_speed");

  for(;;) {
    wait randomfloatrange(.5, 1.5);

    while(friendly_should_speed_up()) {
      self.moveplaybackrate = 2.5;
      wait 0.05;
    }

    self.moveplaybackrate = 1.0;
  }
}

friendly_should_speed_up() {
  prof_begin("friendly_movement_rate_math");

  if(distanceSquared(self.origin, self.goalpos) <= level.goodFriendlyDistanceFromPlayerSquared) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(within_fov(level.player.origin, level.player getPlayerAngles(), self.origin, level.cosine["60"])) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  prof_end("friendly_movement_rate_math");

  return true;
}

taco_goes_to_BT_roof() {
  level.taco.goalradius = 128;
  level.taco.goalheight = 64;
  level.taco SetGoalNode(getnode("taco_on_BT_roof", "script_noteworthy"));

  flag_wait("president_in_BT_meat_locker");

  level.taco.goalradius = 1024;
}

set_up_predator_drone_control_pickup() {
  predator_drone_control = getent("predator_drone_control", "targetname");
  predator_drone_control show();
  predator_drone_control glow();

  predator_drone_control setCursorHint("HINT_NOICON");

  predator_drone_control setHintString(&"INVASION_DRONE_PICKUP");
  predator_drone_control makeUsable();

  predator_drone_control waittill("trigger", player);

  predator_drone_control playSound("scn_invasion_controlrig_pickup");
  thread give_player_predator_drone();
  predator_drone_control stopGlow();
}

give_player_predator_drone() {
  flag_set("player_has_predator_drones");

  thread dialog_handle_predator_infantry_kills();

  level.player maps\_remotemissile::give_remotemissile_weapon("remote_missile_detonator");

  predator_drone_control = getent("predator_drone_control", "targetname");
  predator_drone_control hide();
  predator_drone_control makeUnusable();
}

enemy_uses_smoke() {
  self waittill("trigger");

  flag_set("smoke_screen_starting");
  playFX(getfx("smokescreen"), self.origin);
  self thread play_sound_in_space("smokegrenade_explode_default");
}

dialog_they_are_using_smoke() {
  flag_wait("smoke_screen_starting");
  wait 7;

  radio_dialogue("inv_tco_usingsmoke");
  wait 1;

  radio_dialogue("inv_six_thermaloptics");
}

dialog_pickup_drone_control_nag() {
  last_line = true;
  flag_wait("player_in_diner");
  flag_wait("back_door_attack_start");
  wait 4;

  diner_backdoor_fight_area = getent("diner_backdoor_fight_area", "targetname");
  diner_backdoor_fight_area waittill_volume_dead();

  wait 4;

  while(!flag("player_has_predator_drones")) {
    if(last_line) {
      level.taco dialogue_queue("inv_tco_controlrig");
      last_line = false;
    } else {
      level.taco dialogue_queue("inv_tco_pickupcontrolrig");
      last_line = true;
    }
    wait 15;
  }
}

dialog_nates_bombing_reaction() {
  if(flag("taco_goes_to_roof"))
    return;
  level endon("taco_goes_to_roof");
  wait 3;

  radio_dialogue("inv_tco_stillthere");
  wait 1;

  radio_dialogue("inv_six_newplan");

  radio_dialogue("inv_six_secureburgertown");

  flag_set("time_to_clear_burgertown");

  radio_dialogue("inv_six_listenup");

  radio_dialogue("inv_six_anotherpass");

  flag_set("nates_bombed");
}

dialog_hellfire_attack_reaction() {
  wait 4.5;
  if(flag("player_on_roof")) {
    radio_dialogue("inv_wrm_whatwasthat");
  }
  wait 1;

  while(flag("player_on_roof")) {
    r = randomint(3);
    if(r == 0) {
      radio_dialogue("inv_six_offtheroof");
    }
    if(r == 1) {
      radio_dialogue("inv_six_getoffroof2");
    }
    if(r == 2) {
      radio_dialogue("inv_six_getoffroofnow");
    }

    wait(randomfloatrange(1, 2));
  }
}

hellfire_attacks() {
  thread hellfire_attacks_after_player_got_off_roof();
  level endon("player_on_roof");
  level.player endon("death");
  targets = getEntArray("hellfire_attack_target", "targetname");

  first_tgt = get_closest_to_player_view(targets);
  rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), first_tgt.origin);
  wait(randomfloatrange(3, 5));

  remainingtargets = array_remove(targets, first_tgt);
  targetpos = get_closest_to_player_view(remainingtargets);

  rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), targetpos.origin);
  wait(randomfloatrange(3, 5));

  remainingtargets = array_remove(targets, targetpos);
  targetpos = remainingtargets[randomint(remainingtargets.size)];
  rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), targetpos.origin);
  wait(randomfloatrange(3, 5));

  remainingtargets = array_remove(targets, targetpos);
  targetpos = remainingtargets[randomint(remainingtargets.size)];
  rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), targetpos.origin);
  wait(randomfloatrange(3, 5));

  if(flag("player_on_roof")) {
    rocket_target = level.player.origin;
    rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), rocket_target);
    while(isDefined(rocket))
      wait .05;
    if(flag("player_on_roof"))
      level.player dodamage((level.player.health + 1000), rocket_target);
  }
}

hellfire_attacks_after_player_got_off_roof() {
  wait .2;
  flag_waitopen("player_on_roof");

  ceiling_dust = getEntArray("ceiling_dust", "targetname");
  if(sentry_is_on_roof()) {
    level waittill("hellfire");
    rocket_target = level.obj_sentry.origin;
    rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), rocket_target);
    array_thread(ceiling_dust, ::drop_dust);
    while(isDefined(rocket))
      wait .05;
    level.obj_sentry notify("deleted");
    level.obj_sentry delete();
  }

  targets = getEntArray("hellfire_attack_target_roof", "targetname");
  while(1) {
    level waittill("hellfire");
    targetpos = targets[randomint(targets.size)];
    target_org = targetpos.origin;

    rocket = MagicBullet("remote_missile_not_player_invasion", (level.uav.origin + (0, 0, -128)), target_org);
    array_thread(ceiling_dust, ::drop_dust);
  }
}

sentry_is_on_roof() {
  if(isDefined(level.player.placingSentry))
    return false;
  if(!isDefined(level.obj_sentry))
    return false;

  roof_volume = getent("roof_volume", "targetname");
  if(level.obj_sentry isTouching(roof_volume))
    return true;
  else
    return false;
}

drop_dust() {
  wait 3;
  playFX(getfx("ceiling_dust"), self.origin);
}

dialog_taco_sees_uav_op() {
  level notify("hellfire");
  wait 4;

  radio_dialogue("inv_tco_uavop");

  radio_dialogue("inv_tco_uavop2");

  radio_dialogue("inv_six_killthatsob");

  radio_dialogue("inv_six_killthatsob2");

  level notify("hellfire");

  flag_set("time_to_go_get_UAV_control");

  if(flag("player_inside_nates"))
    autosave_by_name("go_to_diner2");

  wait 3;

  level notify("hellfire");

  wait 4;
}

setup_gas_station_truck() {
  gas_station_truck = spawn_vehicle_from_targetname_and_drive("gas_station_truck");

  wait 4;

  level.raptor dialogue_queue("inv_six_truck12");
}

dialog_bmp_hasnt_spotted_us() {
  wait 2;

  if(isalive(level.house_destroyer)) {
    level notify("dialog_bmp_hasnt_spotted_us");

    level.raptor dialogue_queue("inv_six_hangright");
  }

  if(isalive(level.house_destroyer)) {
    level.raptor dialogue_queue("inv_six_staybehind");
  }
}

spawn_tangled_chute_struggler() {
  flag_wait("take_point");

  tangled_parachute_guy = getent("tangled_parachute_guy", "script_noteworthy");
  guy = tangled_parachute_guy spawn_ai();
}

dialog_sentry_nags() {
  flag_wait("wells_intro_done");
  level endon("player_on_roof");

  wait 5;

  while(!flag("player_on_roof")) {
    if(flag("truck_guys_retreat")) {
      return;
    }
    if(cointoss()) {
      radio_dialogue("inv_six_ladderinkitchen");
    } else {
      radio_dialogue("inv_six_gettoroof");
    }
    wait 15;
  }
}

taco_to_meat_locker() {
  meat_locker_taco = getnode("meat_locker_taco", "script_noteworthy");
  level.taco disable_ai_color();
  level.taco setgoalnode(meat_locker_taco);
  level.taco.goalradius = 16;
}

move_raptor_wells_and_worm() {
  wells_inside = getnode("wells_kitchen", "targetname");
  if(isalive(level.wells)) {
    level.wells disable_ai_color();
    level.wells setgoalnode(wells_inside);
    level.wells.goalradius = 64;
    level.wells.fixednode = true;
  }

  raptor_inside = getnode("raptor_kitchen", "targetname");
  level.raptor disable_ai_color();
  level.raptor setgoalnode(raptor_inside);
  level.raptor.goalradius = 64;
  level.raptor.fixednode = true;

  if(isalive(level.worm)) {
    worm_inside = getnode("worm_inside", "script_noteworthy");
    level.worm disable_ai_color();
    level.worm setgoalnode(worm_inside);
    level.worm.goalradius = 190;
    level.worm.fixednode = false;
  }
}

should_break_get_smoke() {
  clipCount = level.player GetWeaponAmmoStock("smoke_grenade_american");
  if(clipCount < 1)
    return false;
  else
    return true;
}

should_break_throw_smoke() {
  if(flag("threw_smoke"))
    return true;
  else
    return false;
}

dialog_semtex_that_bmp() {
  level endon("btr_smoke_starting");

  level endon("entered_alley");

  dialog = [];

  dialog[dialog.size] = "inv_six_rpgsupplydrop";

  dialog[dialog.size] = "inv_six_pickup";

  dialog[dialog.size] = "inv_six_getmore";
  dialog_start = 0;

  throw_dialog = [];

  throw_dialog[throw_dialog.size] = "inv_six_throwsemtex";

  throw_dialog[throw_dialog.size] = "inv_six_getsemtex";

  throw_dialog[throw_dialog.size] = "inv_six_destroy";
  throw_dialog_start = 0;

  flag_wait("house_destroyer_unloading");

  wait 4;

  level.house_destroyer endon("backed_away");
  while(1) {
    player_has_semtex = level.player GetWeaponAmmoStock("smoke_grenade_american");
    if(player_has_semtex) {
      if(!flag("threw_smoke")) {
        thread watch_for_smoke_throws();

        level.raptor dialogue_queue(throw_dialog[throw_dialog_start]);
        throw_dialog_start++;
        if(throw_dialog_start >= throw_dialog.size)
          throw_dialog_start = 0;

        level.player thread display_hint_timeout("hint_throw_smoke", 5);
      }
    } else {
      level.player thread display_hint_timeout("hint_get_smoke", 5);
      level.raptor dialogue_queue(dialog[dialog_start]);
      dialog_start++;
      if(dialog_start >= dialog.size)
        dialog_start = 0;
    }

    wait 10;
  }
}

watch_for_smoke_throws() {
  flag_clear("threw_smoke");
  while(1) {
    level.player waittill("grenade_fire", grenade, weaponName);
    if(weaponname == "smoke_grenade_american") {
      break;
    }
  }
  flag_set("threw_smoke");
  wait 5;
  flag_clear("threw_smoke");
}

wait_till_btr_smoked() {
  level endon("btr_smoke_starting");
  thread hint_if_smoke_too_far();
  smoke_position = getvehiclenode("house_destroyer_backwards_path", "targetname").origin;

  while(1) {
    level.player waittill("grenade_fire", grenade, weaponName);
    if(weaponname == "smoke_grenade_american") {
      tracker = spawn("script_origin", (0, 0, 0));
      grenade thread track_grenade_origin(tracker);
      grenade thread flag_if_close_to_btr(tracker, smoke_position);
    }
  }
}

track_grenade_origin(tracker) {
  level endon("btr_smoked");
  self endon("death");
  while(1) {
    tracker.origin = self.origin;
    wait .05;
  }
}

flag_if_close_to_btr(tracker, smoke_position) {
  level endon("btr_smoke_starting");

  self waittill("death");

  if(distance(tracker.origin, smoke_position) < 400)
    thread dialog_goto_alley();
  else
    level notify("btr_smoke_too_far");
}

hint_if_smoke_too_far() {
  if(flag("house_destroyer_moving_back"))
    return;
  level endon("house_destroyer_moving_back");

  level waittill("btr_smoke_too_far");
  if(!flag("btr_smoke_starting"))
    display_hint_timeout("hint_smoke_too_far", 5);
}

should_break_smoke_too_far() {
  if(flag("btr_smoke_starting"))
    return true;
  else
    return false;
}

dialog_goto_alley() {
  flag_set("btr_smoke_starting");

  wait 10;

  autosave_by_name("btr_smoked");
  flag_set("btr_smoked");
  activate_trigger_with_targetname("friendlies_hide_in_alley");

  level.raptor dialogue_queue("inv_six_coverofsmoke");

  wait 5;

  if(flag("entered_alley")) {
    return;
  }

  level.raptor dialogue_queue("inv_six_cometoalley");
}

diner_window_traverses() {
  diner_window_traverses = getent("diner_window_traverses", "targetname");
  if(!isDefined(diner_window_traverses))
    return;
  diner_window_traverses disconnectpaths();

  flag_wait("crash_objective");

  diner_window_traverses MoveZ(-1000, .1, 0, 0);

  diner_window_traverses connectpaths();
}

truck_group_enemies_count_deaths() {
  level.truck_group_enemies_count_lives++;
  level.truck_group_enemies_alive++;
  self waittill("death");
  level.truck_group_enemies_count_deaths++;
  level.truck_group_enemies_alive--;
  level notify("truck_guy_died");
}

truck_group_enemies_setup_retreat() {
  self endon("death");
  flag_wait("truck_guys_retreat");

  if(isDefined(self.target))
    self setgoalpos(getent(self.target, "targetname").origin);
  else
    self setgoalpos(getent("truck_guy_retreat_goal", "targetname").origin);

  self.goalradius = 32;
  self waittill("goal");
  while(self cansee(level.player))
    wait 1;
  self kill();
}

bank_enemies_setup_retreat() {
  self endon("death");
  flag_wait("bank_guys_retreat");

  self setgoalpos(getent("north_trucks_retreat_point", "targetname").origin);

  self.ignoreme = true;
  self.goalradius = 32;
  self waittill("goal");
  while(self cansee(level.player))
    wait 1;
  self kill();
}

mission_fail_if_sentry_dies() {
  level endon("sentry_in_position");
  self waittill("death");

  setDvar("ui_deadquote", &"INVASION_FAIL_SENTRY");
  maps\_utility::missionFailedWrapper();
}

mig_fly_overs() {
  migs = spawn_vehicles_from_targetname_and_drive("first_fast_movers");

  wait 7;

  flag_wait("wells_intro_done");

  migs = spawn_vehicles_from_targetname_and_drive("first_fast_movers");
}

one_bmp_from_south() {
  bmp = thread spawn_vehicle_from_targetname_and_drive("crash_objective_bmp");
  bmp thread turret_spotlight();
  bmp thread maps\_vehicle::damage_hints();

  bmp endon("death");

  current = getent("west_side", "targetname");
  bmp SetTurretTargetVec(current.origin);

  pos = getvehiclenode("first_volley_at_nates", "script_noteworthy");
  pos waittill("trigger");

  bmp bmp_fires_first_volley_at_nates();

  pos = getvehiclenode("crash_obj_bmp_in_pos", "script_noteworthy");
  pos waittill("trigger");

  bmp vehicle_setspeed(0, 15, 15);

  bmp bmp_fires_at_nates();

  bmp vehicle_setspeed(10, 3, 3);

  bmp thread bmp_fires_more_volleys_at_nates();

  bmp waittill("reached_end_node");

  bmp thread bmp_turret_attack_player(false, false);

  flag_wait("crash_objective");
  bmp delete();
}

two_bmps_from_north() {
  level.bmp_north_mid = spawn_vehicle_from_targetname_and_drive("nate_attacker_mid");
  level.bmp_north_left = spawn_vehicle_from_targetname_and_drive("nate_attacker_left");
  array_thread(getvehiclenodearray("new_target", "script_noteworthy"), ::new_target_think);

  bmps = [];
  bmps[bmps.size] = level.bmp_north_mid;
  bmps[bmps.size] = level.bmp_north_left;

  thread aim_predator_drone_at_btrs();
  thread dialog_bmp_spotted_you();
  thread dialog_destroyed_btr_with_uav();

  foreach(vehicle in bmps) {
    vehicle thread watch_for_player();
    vehicle thread maps\_remotemissile::setup_remote_missile_target();
    vehicle thread save_on_death();
    vehicle thread ent_flag_init("spotted_player");
    vehicle thread turret_spotlight();
    vehicle thread maps\_vehicle::damage_hints();
  }

  return bmps;
}

aim_predator_drone_at_btrs() {
  while(1) {
    level waittill("starting_predator_drone_control");

    bmps = [];
    if(isalive(level.bmp_north_mid))
      bmps[bmps.size] = level.bmp_north_mid;
    if(isalive(level.bmp_north_left))
      bmps[bmps.size] = level.bmp_north_left;

    if(bmps.size == 0) {
      level.uavTargetEnt = undefined;
      return;
    }

    if(bmps.size > 1)
      level.uavTargetEnt = (get_closest_to_player_view(bmps));
    else
      level.uavTargetEnt = bmps[0];
  }
}

save_on_death() {
  self waittill("death");

  if(self ent_flag("spotted_player"))
    flag_clear("bmp_has_spotted_player");

  level notify("bmp_died");
  level.bmps_from_north_dead++;
}

dialog_bmp_spotted_you() {
  level endon("player_has_predator_drones");
  num = randomint(3);
  while(1) {
    flag_wait("bmp_has_spotted_player");

    switch (num) {
      case 0:

        dialog_bmp_spotted_you_action("inv_six_bmpspottedyou");
        break;
      case 1:

        dialog_bmp_spotted_you_action("inv_six_bmphasavisual");
        break;
      case 2:

        dialog_bmp_spotted_you_action("inv_six_behindsolid");
        break;
    }
    num++;
    if(num > 2)
      num = 0;

    wait 10;
  }
}

dialog_bmp_spotted_you_action(dialog) {
  if(flag("player_in_diner"))
    return;
  if(flag("player_in_burgertown"))
    return;
  if(flag("player_on_burgertown_roof")) {
    return;
  }
  radio_dialogue(dialog);
}

dialog_bmp_lost_you() {
  level endon("player_has_predator_drones");
  level.player endon("death");
  min_time_between = 10;

  while(1) {
    flag_wait("bmp_has_spotted_player");
    dialog_on_clear("inv_six_bmplostyou");

    wait min_time_between;

    flag_wait("bmp_has_spotted_player");
    dialog_on_clear("inv_six_bmplostyoumove");

    wait min_time_between;

    flag_wait("bmp_has_spotted_player");
    dialog_on_clear("inv_six_bmplostyougo");

    wait min_time_between;
  }
}

dialog_on_clear(dialog) {
  level endon("bmp_died");
  flag_waitopen("bmp_has_spotted_player");
  wait 4;
  flag_waitopen("bmp_has_spotted_player");

  radio_dialogue(dialog);
}

watch_for_player() {
  self endon("death");
  self.turret_busy = false;

  while(1) {
    wait .05;
    if(flag("player_inside_nates"))
      continue;
    if(flag("player_in_diner"))
      continue;
    if(flag("bmp_has_spotted_player"))
      continue;
    if(distance(self.origin, level.player.origin) > 2400)
      continue;
    if(distance(self.origin, level.player.origin) < level.min_btr_fighting_range)
      continue;
    tag_flash_angles = self getTagAngles("tag_flash");
    if(!within_fov(self.origin, tag_flash_angles, level.player.origin, level.cosine["25"]))
      continue;
    if(!can_see_player(level.player)) {
      continue;
    }

    flag_set("bmp_has_spotted_player");
    self notify("new_target");
    self.turret_busy = true;
    self ent_flag_set("spotted_player");

    miss_player(level.player);
    wait(randomfloatrange(0.8, 2.4));

    miss_player(level.player);
    wait(randomfloatrange(0.8, 2.4));

    while(can_see_player(level.player)) {
      fire_at_player(level.player);
      wait(randomfloatrange(2, 3));
    }

    self clearturrettarget();
    self.turret_busy = false;
    self ent_flag_clear("spotted_player");

    flag_clear("bmp_has_spotted_player");
  }
}

new_target_think() {
  level endon("bmps_from_north_dead");
  targets = getEntArray(self.script_linkto, "script_linkname");
  while(1) {
    self waittill("trigger", vehicle);

    if(!isalive(vehicle))
      return;
    if(vehicle.turret_busy) {
      continue;
    }
    vehicle notify("new_target");

    vehicle setturrettargetent(targets[0]);

    thread btr_fire_at_targets(vehicle);
  }
}

btr_fire_at_targets(vehicle) {
  vehicle endon("new_target");

  vehicle endon("death");

  vehicle waittill("turret_on_target");

  while(1) {
    s = randomintrange(4, 6);
    for(j = 0; j < s; j++) {
      vehicle fireWeapon();
      wait .2;
    }
    wait(randomfloatrange(1, 2));
  }
}

rush_restaurant_enemies_setup() {
  self endon("death");
  nates_restaurant_goal = getent("nates_restaurant_goal", "targetname");
  self ClearGoalVolume();
  self.goalheight = 100;

  self enable_danger_react(5);
  self setgoalpos(nates_restaurant_goal.origin);
  self.goalradius = 4000;
  self.aggressivemode = true;

  flag_wait("truck_guys_retreat");

  self setgoalpos(getent("truck_guy_retreat_goal", "targetname").origin);

  self.goalradius = 32;
  self waittill("goal");
  while(self cansee(level.player))
    wait 1;
  self kill();
}

truck_group_enemies_setup() {
  self waittill("jumpedout");
  level endon("truck_guys_retreat");
  self endon("death");
  nates_restaurant_goal = getent("nates_restaurant_goal", "targetname");
  self.goalheight = 100;

  self enable_danger_react(5);

  if(randomint(3) > 0) {
    self setgoalpos(nates_restaurant_goal.origin);
    self.goalradius = nates_restaurant_goal.radius;

    cover_time = randomintrange(1, 22);
    wait cover_time;
    self setgoalpos(self.origin);
    self.goalradius = 900;
    wait randomfloatrange(2, 4);

    self setgoalpos(nates_restaurant_goal.origin);
    self.goalradius = nates_restaurant_goal.radius;
  } else {
    self setgoalpos(nates_restaurant_goal.origin);
    self.goalradius = 4000;
  }
}

BT_nates_attackers_setup() {
  while(1) {
    self waittill("enemy");
    if(isPlayer(self.enemy)) {
      self.goalradius = 3000;
      break;
    }
  }
}

alley_nates_attackers_setup() {
  while(1) {
    self waittill("enemy");
    if(isPlayer(self.enemy)) {
      self.goalradius = 3000;
      break;
    }
  }
}

setup_hunter_enemies() {
  goals = getEntArray("closest_goal_radius", "targetname");
  level.current_goal = getclosest(level.player.origin, goals);

  level.hunter_enemies = [];

  current_enemies = getaiarray("axis");
  array_thread(current_enemies, ::create_hunter_enemy);

  bank_enemies = getEntArray("bank_enemies", "targetname");
  gas_station_enemies = getEntArray("gas_station_enemies", "targetname");
  taco_enemies = getEntArray("taco_enemies", "targetname");
  array_thread(bank_enemies, ::add_spawn_function, ::create_hunter_enemy);
  array_thread(gas_station_enemies, ::add_spawn_function, ::create_hunter_enemy);
  array_thread(taco_enemies, ::add_spawn_function, ::create_hunter_enemy);

  array_thread(bank_enemies, ::add_spawn_function, ::setup_predator_deaths);
  array_thread(gas_station_enemies, ::add_spawn_function, ::setup_predator_deaths);
  array_thread(taco_enemies, ::add_spawn_function, ::setup_predator_deaths);

  thread maintain_closest_goal(goals);
}

predator_death_func() {
  if(isDefined(self.damageMod) && self.damageMod == "MOD_PROJECTILE_SPLASH" && isDefined(self.lastAttacker) && isDefined(self.lastAttacker.fired_hellfire_missile))
    self.skipDeathAnim = true;

  return false;
}

setup_predator_deaths() {
  self.deathFunction = ::predator_death_func;
}

maintain_closest_goal(goals) {
  while(1) {
    closest_goal = getclosest(level.player.origin, goals);

    if(level.current_goal != closest_goal) {
      level.current_goal = closest_goal;
      move_hunters_to_new_goal(closest_goal);
    }
    wait 1;
  }
}

create_hunter_enemy() {
  self.goalradius = 2048;
  self.goalheight = 512;
  level.hunter_enemies[self.unique_id] = self;
  self setgoalpos(level.current_goal.origin);
  self.pathrandompercent = 200;
  self enable_danger_react(5);

  self waittill("death");

  level.hunter_enemies[self.unique_id] = undefined;
}

move_hunters_to_new_goal(closest_goal) {
  waittillframeend;

  foreach(enemy in level.hunter_enemies)
  enemy setgoalpos(closest_goal.origin);
}

wounded_carry_attackers_counter() {
  self waittill("death");
  level.wounded_carry_attackers_dead++;
}

setup_wounded_carry_attackers() {
  self endon("death");
  self.aggressivemode = true;
  self.useChokePoints = false;

  self waittill("goal");
  self.goalradius = 2000;
  self waittill("goal");
  self.goalradius = 2000;
}

setup_diner_backdoor_attackers() {
  self endon("death");
  self.aggressivemode = true;
  self.useChokePoints = false;

  wait 12;

  self.goalradius = 100;
  self.favoriteenemy = level.player;
  self setgoalentity(level.player);
}

setup_BT_enemy_defenders() {
  self endon("death");
  self.combatMode = "ambush";
  self.grenadeawareness = .9;
  flag_wait("player_in_burgertown");
  wait 8;
  self.combatMode = "cover";
  self setgoalentity(level.player);
  self.goalradius = 100;
}

nates_defenders_setup() {
  self endon("death");

  self thread magic_bullet_shield();

  flag_wait("player_on_roof");
  self stop_magic_bullet_shield();
}

setup_wells() {
  level.wells = self;
  self.animname = "wells";
  self thread magic_bullet_shield();

  level.wells setgoalnode(getnode("wells_intro_node", "targetname"));
  level.wells.goalradius = 16;

  flag_wait("move_president_to_prep");

  wells_in_nates_prep = getent("wells_in_nates_prep", "targetname");
  level.wells setgoalpos(wells_in_nates_prep.origin);
}

setup_worm() {
  level.worm = self;
  self.animname = "worm";
}

setup_taco() {
  level.taco = self;
  self.animname = "taco";
  self thread magic_bullet_shield();
}

setup_raptor() {
  level.raptor = self;
  self.animname = "raptor";
  self thread magic_bullet_shield();

  flag_wait("move_president_to_prep");

  level.raptor.goalradius = 64;
  raptor_prep = getent("raptor_in_nates_prep", "targetname");
  level.raptor setgoalpos(raptor_prep.origin);
}

is_west_group(group_name) {
  if(group_name == "ambient_paradrop3")
    return true;
  if(group_name == "ambient_west_group3")
    return true;
  if(group_name == "ambient_west_group2")
    return true;
  return false;
}

paradrops_ambient() {
  flag_wait_either("leaving_gas_station", "crash_objective");

  drop_groups = [];
  drop_groups[drop_groups.size] = "ambient_paradrop1";
  drop_groups[drop_groups.size] = "ambient_paradrop2";
  drop_groups[drop_groups.size] = "ambient_paradrop3";
  drop_groups[drop_groups.size] = "ambient_west_group3";
  drop_groups[drop_groups.size] = "ambient_west_group2";
  drop_groups[drop_groups.size] = "ambient_south_group2";
  drop_groups[drop_groups.size] = "ambient_south_group3";
  drop_groups[drop_groups.size] = "ambient_east_group2";
  drop_groups[drop_groups.size] = "ambient_east_group3";
  drop_groups[drop_groups.size] = "ambient_north_group1";
  drop_groups[drop_groups.size] = "ambient_north_group2";
  drop_groups[drop_groups.size] = "ambient_north_group3";
  drop_groups[drop_groups.size] = "curved_mig_flight1";

  drop_groups[drop_groups.size] = "paradrop_escort";

  drop_groups = array_randomize(drop_groups);
  selected = 0;

  north_groups = [];
  north_groups[north_groups.size] = "ambient_north_group1";
  north_groups[north_groups.size] = "ambient_north_group2";
  north_groups[north_groups.size] = "ambient_north_group3";

  south_groups = [];
  south_groups[south_groups.size] = "ambient_paradrop2";
  south_groups[south_groups.size] = "ambient_south_group2";
  south_groups[south_groups.size] = "ambient_south_group3";

  west_groups = [];
  west_groups[west_groups.size] = "ambient_paradrop3";
  west_groups[west_groups.size] = "ambient_west_group3";
  west_groups[west_groups.size] = "ambient_west_group2";

  east_groups = [];
  east_groups[east_groups.size] = "ambient_paradrop1";
  east_groups[east_groups.size] = "ambient_east_group2";
  east_groups[east_groups.size] = "ambient_east_group3";

  while(1) {
    planes = undefined;
    dir_selection = undefined;
    old_selection = undefined;

    if(isDefined(level.obj_direction)) {
      if(level.obj_direction == "east")
        dir_selection = east_groups[randomint(east_groups.size)];
      if(level.obj_direction == "north")
        dir_selection = north_groups[randomint(north_groups.size)];
      if(level.obj_direction == "south")
        dir_selection = south_groups[randomint(south_groups.size)];
      if((level.obj_direction == "west") && !flag("player_is_near_houses"))
        dir_selection = west_groups[randomint(west_groups.size)];

      if(isDefined(dir_selection)) {
        planes = getEntArray(dir_selection, "targetname");
        println(" z: ambient paradrop: " + dir_selection);
      }
    }
    if(!isDefined(planes)) {
      if(selected >= drop_groups.size)
        selected = 0;

      group_name = drop_groups[selected];

      if(flag("player_is_near_houses") && is_west_group(group_name)) {
        selected++;
        continue;
      }
      println(" %%%% ambient paradrop: " + group_name);

      planes = getEntArray(drop_groups[selected], "targetname");
      old_selection = selected;

      selected++;
    }

    first_plane = true;
    antonov = false;
    foreach(plane in planes) {
      if(plane.classname == "script_vehicle_antonov")
        antonov = true;

      if(antonov) {
        if(first_plane) {
          plane thread paradrop(first_plane);
          first_plane = false;
        } else {
          plane thread paradrop();
        }
      } else {
        plane thread maps\_vehicle::spawn_vehicle_and_gopath();
      }
    }
    if(!antonov) {
      drop_groups = array_remove(drop_groups, drop_groups[old_selection]);
    }

    wait 20;

    if(getDvar("invasion_minspec") == "1")
      wait 80;
  }
}

paradrop_vehicle() {
  airplane_spawner = undefined;

  self waittill("trigger");
  targets = getEntArray(self.target, "targetname");
  for(i = 0; i < targets.size; i++) {
    if(i == 0) {
      first_plane = true;
      targets[i] thread paradrop(first_plane);
    } else {
      targets[i] thread paradrop();
    }
  }
}

drop_bmp() {
  chute = spawn_anim_model("bmp_chute_paradrop");
  chuteA = spawn_anim_model("paradrop_cargo_tank_chuteA");
  chuteB = spawn_anim_model("paradrop_cargo_tank_chuteB");
  chuteC = spawn_anim_model("paradrop_cargo_tank_chuteC");
  bmp = spawn_anim_model("bmp_paradrop");

  bmp linkto(self);
  chute linkto(self);
  chuteA linkto(self);
  chuteB linkto(self);
  chuteC linkto(self);

  self thread anim_single_solo(chute, "bmp_chute_paradrop");
  self thread anim_single_solo(chuteA, "paradrop_cargo_tank_chuteA");
  self thread anim_single_solo(chuteB, "paradrop_cargo_tank_chuteB");
  self thread anim_single_solo(chuteC, "paradrop_cargo_tank_chuteC");
  self anim_single_solo(bmp, "bmp_paradrop");

  chute delete();
  chuteA delete();
  chuteB delete();
  chuteC delete();
  bmp delete();
}

paradrop(first_plane) {
  assert(isDefined(level.paradropper_left));
  assert(isDefined(level.paradropper_right));

  airplane = self thread maps\_vehicle::spawn_vehicle_and_gopath();
  if(isDefined(first_plane))
    airplane playLoopSound("veh_jet_passenger_slow");
  airplane.script_vehicle_selfremove = 1;
  airplane ent_flag_init("start_drop");
  airplane ent_flag_init("stop_drop");

  airplane endon("stop_drop");

  drop_time = 16;
  if(isDefined(self.script_duration))
    drop_time = self.script_duration;

  airplane ent_flag_wait("start_drop");

  println("start drop, airplane num: ");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "drop_bmp") {
    airplane thread drop_bmp();
    wait 2;
  }

  while(1) {
    level.paradropper_right.count = 1;
    level.paradropper_left.count = 1;
    paradrop_guy_left = level.paradropper_left spawn_ai();
    paradrop_guy_left thread setup_paradrop_guy_left(airplane, drop_time);

    paradrop_guy_right = level.paradropper_right spawn_ai();
    paradrop_guy_right thread setup_paradrop_guy_right(airplane, drop_time);

    wait(randomfloatrange(.4, .8));
  }
}

setup_paradrop_guy_left(paradrop_airplane, drop_time) {
  level.droppers++;

  self.health = 1;
  self.ignoreme = true;
  chute = spawn_anim_model("distant_parachute_guy");
  self linkto(paradrop_airplane);
  chute linkto(paradrop_airplane);
  if(cointoss()) {
    paradrop_airplane thread anim_single_solo(chute, "distant_parachute_guy_left1");
    paradrop_airplane thread anim_generic(self, "distant_parachute_guy_left1");
  } else {
    paradrop_airplane thread anim_single_solo(chute, "distant_parachute_guy_left2");
    paradrop_airplane thread anim_generic(self, "distant_parachute_guy_left2");
  }
  wait drop_time;
  chute delete();
  if(isalive(self))
    self delete();
  level.droppers--;
  level.dropped++;
}

setup_paradrop_guy_right(paradrop_airplane, drop_time) {
  level.droppers++;

  self.health = 1;
  self.ignoreme = true;
  chute = spawn_anim_model("distant_parachute_guy");
  self linkto(paradrop_airplane);
  chute linkto(paradrop_airplane);
  if(cointoss()) {
    paradrop_airplane thread anim_single_solo(chute, "distant_parachute_guy_right1");
    paradrop_airplane thread anim_generic(self, "distant_parachute_guy_right1");
  } else {
    paradrop_airplane thread anim_single_solo(chute, "distant_parachute_guy_right2");
    paradrop_airplane thread anim_generic(self, "distant_parachute_guy_right2");
  }
  wait drop_time;
  chute delete();
  if(isalive(self))
    self delete();
  level.droppers--;
  level.dropped++;
}

setup_shotgun_guy2() {
  humvee_opening_node = getent("humvee_opening", "targetname");
  humvee_opening_node anim_generic(self, "invasion_opening_hummer1_soldier2");

  self.allowdeath = true;
  self.a.nodeath = true;
  self kill();
}

setup_backseat_right_guy2() {
  humvee_opening_node = getent("humvee_opening", "targetname");
  humvee_opening_node anim_generic(self, "invasion_opening_hummer1_soldier1");

  self.allowdeath = true;
  self.a.nodeath = true;
  self kill();
}

setup_player_humvee_driver() {
  humvee_opening_node = getent("humvee_opening", "targetname");
  humvee_opening_node anim_generic(self, "invasion_opening_hummer2_soldier1");
}

btr80_notetrack_fire(guy) {
  level.humvee_destroyer fireWeapon();

  level notify("humvee_destroyer_fired");
}

fire_at_chain(current) {
  self endon("death");
  while(1) {
    self SetTurretTargetVec(current.origin);

    house_destroyer_fire(current.origin);
    exploder(current.script_prefab_exploder);

    if(!isDefined(current.target)) {
      break;
    }
    next = getent(current.target, "targetname");
    if(!isDefined(next)) {
      break;
    }
    current = next;
  }
}

bmp_fires_first_volley_at_nates() {
  self endon("death");
  current = getent("north_side_low", "targetname");

  self SetTurretTargetVec(current.origin);
  self waittill("turret_on_target");

  self fire_at_chain(current);

  current = getent("north_side_high", "targetname");

  self SetTurretTargetVec(current.origin);
  self waittill("turret_on_target");

  self fire_at_chain(current);
}

bmp_fires_more_volleys_at_nates() {
  self endon("reached_end_node");
  self endon("death");
  targets = getEntArray("hellfire_attack_target_roof", "targetname");
  while(1) {
    wait randomfloatrange(1, 3);
    target_origin = targets[randomint(targets.size)];
    self SetTurretTargetVec(target_origin.origin);
    shots = randomintrange(3, 6);
    for(i = 0; i < shots; i++) {
      self fireWeapon();
      wait .2;
    }
  }
}

setup_nates_kitchen_ladder_clip() {
  nates_kitchen_ladder_clip = getent("nates_kitchen_ladder_clip", "targetname");

  while(1) {
    nates_kitchen_ladder_clip notsolid();

    flag_wait("player_on_roof");
    while(level.player istouching(nates_kitchen_ladder_clip))
      wait 1;

    nates_kitchen_ladder_clip solid();

    flag_waitopen("player_on_roof");
  }
}

setup_bt_ktichen_ladder_clip() {
  bt_ktichen_ladder_clip = getent("bt_ktichen_ladder_clip", "targetname");

  while(1) {
    bt_ktichen_ladder_clip notsolid();

    flag_wait("player_on_burgertown_roof");
    while(level.player istouching(bt_ktichen_ladder_clip))
      wait 1;

    bt_ktichen_ladder_clip solid();

    flag_waitopen("player_on_burgertown_roof");
  }
}

bmp_fires_at_nates() {
  current = getent("west_side", "targetname");

  self SetTurretTargetVec(current.origin);
  self waittill("turret_on_target");
  self fire_at_chain(current);
}

add_org_to_tank_targets(ent, org, exploder) {
  array = [];
  array["exploder"] = exploder;
  array["origin"] = org;
  ent.targets[ent.targets.size] = array;
}

roof_parachute_landing_guy_humvee() {
  roof_parachute_landing_guy_humvee = getent("humvee_ride_roof_landing", "targetname");
  level.roof_parachute_landing_guy_humvee = roof_parachute_landing_guy_humvee spawn_ai();
  if(isDefined(level.animated_ride_in))
    level.roof_parachute_landing_guy_humvee.ignoreme = true;
  level.roof_parachute_landing_guy_humvee waittill("death");

  if(isDefined(level.animated_ride_in))
    return;
  turret = level.humvee_front.mgturret[0];
  target = getent("humvee_destroyer_init_target", "targetname");
  turret_guy = turret getTurretOwner();
  turret_guy.ignoreall = true;
  turret thread animscripts\hummer_turret\common::set_manual_target(target);

  level waittill("humvee_destroyer_fired");

  turret_guy kill();
}

humvee_explosion1(guy) {
  playFX(getfx("humvee_explosion"), level.humvee_front.origin);
}

humvee_explosion2(guy) {
  level.humvee_front maps\_vehicle::godoff();
  level.humvee_front kill();
}

humvee_destroyer_action() {
  self endon("death");
  self thread turret_spotlight();
  self thread maps\_vehicle::damage_hints();

  level.humvee_front.health = 30000;
  level.humvee_player.health = 30000;

  self setturrettargetent(level.humvee_front, (0, 0, 40));

  wait 1.5;

  level notify("humvee_blows_up");

  wait 2.5;

  turret_guys = getEntArray("turret_guy", "script_noteworthy");
  foreach(guy in turret_guys) {
    if(isalive(guy))
      guy kill();
  }

  for(j = 0; j < 2; j++) {
    physicsSphere(level.humvee_front.origin);
    self fireWeapon();
    wait .2;
  }

  self setturrettargetent(level.humvee_player, (0, 0, 40));
  wait 1;

  for(j = 0; j < 3; j++) {
    self fireWeapon();
    wait .2;
  }

  level.humvee_player maps\_vehicle::godoff();
  level.humvee_player kill();

  self setturrettargetent(level.humvee_front, (0, 0, 40));
  wait 1;

  for(j = 0; j < 5; j++) {
    self fireWeapon();
    wait .2;
  }

  humvee_destroyer_fires_at_pillars_and_player();
}

humvee_destroyer_fires_at_pillars_and_player() {
  self endon("death");
  ent = spawnStruct();
  ent.targets = [];
  org = getstruct("pillar1", "targetname").origin;
  add_org_to_tank_targets(ent, org, 9990);
  org = getstruct("pillar2", "targetname").origin;
  add_org_to_tank_targets(ent, org, 9991);
  org = getstruct("pillar3", "targetname").origin;
  add_org_to_tank_targets(ent, org, 9992);

  self setturrettargetvec(ent.targets[0]["origin"]);
  wait 1.5;

  for(i = 0; i < ent.targets.size; i++) {
    self setturrettargetvec(ent.targets[i]["origin"]);

    house_destroyer_fire(ent.targets[i]["origin"]);
    Earthquake(0.3, .3, ent.targets[i]["origin"], 850);

    if(ent.targets[i]["exploder"] > 0)
      exploder(ent.targets[i]["exploder"]);
  }

  wait 1;

  self ent_flag_init("spotted_player");
  thread bmp_turret_attack_player(false, true);

  flag_wait("start_house_destroyer");
  self delete();
}

setup_house_destroyer() {
  self thread turret_spotlight();
  self thread maps\_vehicle::damage_hints();
  self thread house_destroyer_move();
  self.damageIsFromPlayer = true;

  self endon("death");

  ent = spawnStruct();
  ent.targets = [];
  org = getstruct("bh_roof", "targetname").origin;
  add_org_to_tank_targets(ent, org, 12);
  org = getstruct("bh_corner", "targetname").origin;
  add_org_to_tank_targets(ent, org, 13);
  org = getstruct("bh_garage_left", "targetname").origin;
  add_org_to_tank_targets(ent, org, 10);
  org = getstruct("bh_garage_right", "targetname").origin;
  add_org_to_tank_targets(ent, org, 11);

  for(i = 0; i < ent.targets.size; i++) {
    self setturrettargetvec(ent.targets[i]["origin"]);

    house_destroyer_fire(ent.targets[i]["origin"]);

    if(ent.targets[i]["exploder"] > 0)
      exploder(ent.targets[i]["exploder"]);
  }

  t = getstruct("cop_car", "targetname");
  self setturrettargetvec(t.origin);
  self waittill("turret_on_target");

  while(!flag("house_destroyer_stage2")) {
    s = randomintrange(4, 6);
    for(j = 0; j < s; j++) {
      self fireWeapon();
      wait .2;
    }
    delay = (randomintrange(40, 60));
    for(d = 0; d < delay; d++) {
      if(flag("house_destroyer_stage2")) {
        break;
      }
      wait(.05);
    }
  }

  ent = spawnStruct();
  ent.targets = [];
  org = getstruct("roof_corner", "targetname").origin;
  add_org_to_tank_targets(ent, org, 4);
  org = getstruct("bh_corner", "targetname").origin;
  add_org_to_tank_targets(ent, org, 2);
  org = getstruct("big_windows", "targetname").origin;
  add_org_to_tank_targets(ent, org, 1);
  org = getstruct("back_windows", "targetname").origin;
  add_org_to_tank_targets(ent, org, 3);

  thread animate_burning_tree();
  thread maps\invasion_fx::tree_fire_light();
  for(i = 0; i < ent.targets.size; i++) {
    self setturrettargetvec(ent.targets[i]["origin"]);

    house_destroyer_fire(ent.targets[i]["origin"]);

    if(ent.targets[i]["exploder"] > 0)
      exploder(ent.targets[i]["exploder"]);
  }

  self endon("stop_shooting");
  thread house_destroyer_shoot_agro_player();

  t = getstruct("beemer", "targetname");
  self setturrettargetvec(t.origin);
  self waittill("turret_on_target");

  s = randomintrange(4, 6);
  for(j = 0; j < s; j++) {
    self fireWeapon();
    wait .2;
  }

  t = getstruct("barrier_car", "targetname");
  self setturrettargetvec(t.origin);
  self waittill("turret_on_target");

  for(i = 0; i < 3; i++) {
    s = randomintrange(4, 6);
    for(j = 0; j < s; j++) {
      self fireWeapon();
      wait .2;
    }
  }

}

house_destroyer_shoot_agro_player() {
  self endon("death");
  self endon("stop_shooting");

  while(1) {
    if(within_fov(self.origin, self.angles, level.player.origin, level.cosine["60"]))
      if(SightTracePassed((self.origin + (0, 0, 64)), level.player getEye(), false, self)) {
        break;
      }
    wait 1;
  }

  thread bmp_turret_attack_player();
}

house_destroyer_move() {
  self endon("death");
  self ent_flag_init("spotted_player");

  house_destroyer_first_path = getVehicleNode("house_destroyer_first_path", "targetname");
  self startPath(house_destroyer_first_path);

  flag_wait("house_destroyer_stage2");

  house_destroyer_path = getVehicleNode("house_destroyer_path", "targetname");
  self startPath(house_destroyer_path);
  self waittill("reached_end_node");

  level.player waittill_entity_in_range_or_timeout(self, 950, 4);

  flag_set("house_destroyer_unloading");

  self thread vehicle_unload();

  wait 6;

  thread bmp_turret_attack_player();

  wait 16;
  flag_wait("take_point");

  bmp_bad_places = getEntArray("bmp_bad_places", "script_noteworthy");
  foreach(place in bmp_bad_places) {
    BadPlace_Cylinder("", 20, place.origin, place.radius, 300);
  }

  flag_set("house_destroyer_moving_back");
  house_destroyer_backwards_path = getVehicleNode("house_destroyer_backwards_path", "targetname");
  self startPath(house_destroyer_backwards_path);
  self vehicle_wheels_backward();

  flag_wait("leaving_gas_station");
  self notify("stop_shooting");

  self delete();
}

house_destroyer_fire(center) {
  physicsSphere(center);
  self fireWeapon();
  wait .2;
}

physicsSphere(center) {
  assert(isDefined(center));
  wait 0.1;

  physicsExplosionSphere(center, 200, 100, 4.0);
}

bmp_turret_attack_player(end_if_cant_see, no_misses) {
  if(!isDefined(end_if_cant_see))
    end_if_cant_see = false;

  if(!isDefined(no_misses))
    no_misses = false;

  self notify("stop_shooting");

  self endon("stop_shooting");
  self endon("death");
  self endon("delete");
  while(1) {
    player = get_closest_player(self.origin);

    wait(randomfloatrange(0.8, 1.3));

    while(!can_see_player(player))
      wait(randomfloatrange(0.2, 0.6));

    if(!no_misses) {
      miss_player(player);
      wait(randomfloatrange(0.8, 2.4));

      miss_player(player);
      wait(randomfloatrange(0.8, 2.4));
    }

    while(can_see_player(player)) {
      fire_at_player(player);
      wait(randomfloatrange(2, 3));
    }

    if(end_if_cant_see) {
      if(!can_see_player(player)) {
        self clearturrettarget();
        self.turret_busy = false;
        self ent_flag_clear("spotted_player");
        flag_clear("bmp_has_spotted_player");
        self notify("stop_shooting");
      }
    }

  }
}

debug_bmp_hit_player() {
  self endon("death");
  while(1) {
    level.player waittill("damage", amount, who);
    if(who == self)
      println(" bmp damaged player");
  }
}

fire_at_player(player) {
  burstsize = randomintrange(3, 5);
  println(" **HITTING PLAYER, burst: " + burstsize);
  fireTime = .2;
  for(i = 0; i < burstsize; i++) {
    self setturrettargetent(player, randomvector(20) + (0, 0, 32));
    self fireweapon();
    wait fireTime;
  }
}

miss_player(player) {
  forward = anglesToForward(level.player.angles);
  forwardfar = vector_multiply(forward, 100);
  miss_vec = forwardfar + randomvector(50);

  burstsize = randomintrange(4, 6);
  fireTime = .2;
  for(i = 0; i < burstsize; i++) {
    offset = randomvector(15) + miss_vec + (0, 0, 64);

    self setturrettargetent(player, offset);
    self fireweapon();
    wait fireTime;
  }
}

can_see_player(player) {
  if(flag("player_inside_nates"))
    return false;

  if(flag("player_in_diner"))
    return false;

  if(distance(self.origin, level.player.origin) < level.min_btr_fighting_range)
    return false;

  tag_flash_loc = self getTagOrigin("tag_flash");

  player_eye = player getEye();
  if(SightTracePassed(tag_flash_loc, player_eye, false, self)) {
    if(isDefined(level.debug))
      line(tag_flash_loc, player_eye, (0.2, 0.5, 0.8), 0.5, false, 60);
    return true;
  } else {
    return false;
  }
}

end_of_script() {
  iprintlnbold(&"SCRIPT_DEBUG_LEVEL_END");
}

flag_save(_flag) {
  flag_wait(_flag);

  autosave_by_name("hello");;
}

registerObjective(objName, objText, objOrigin) {
  flag_init(objName);
  if(!isDefined(level.objectives))
    level.objectives = [];
  objID = level.objectives.size;

  newObjective = spawnStruct();
  newObjective.name = objName;
  newObjective.id = objID;
  newObjective.state = "invisible";
  newObjective.text = objText;
  newObjective.origin = objOrigin;
  newObjective.added = false;

  level.objectives[objName] = newObjective;

  return newObjective;
}

setObjectiveState(objName, objState) {
  assert(isDefined(level.objectives[objName]));

  objective = level.objectives[objName];
  objective.state = objState;

  if(!objective.added) {
    objective_add(objective.id, objective.state, objective.text, objective.origin);
    objective.added = true;
  } else {
    objective_state(objective.id, objective.State);
  }

  if(objective.state == "done")
    flag_set(objName);
}

setObjectiveString(objName, objString) {
  objective = level.objectives[objName];
  objective.text = objString;

  objective_string(objective.id, objString);
}

setObjectiveLocation(objName, objLoc) {
  level notify("moving " + objName);
  level endon("moving " + objName);

  objective = level.objectives[objName];
  objective.loc = objLoc;
  level.obj_pos = objLoc;
  objective_position(objective.id, level.obj_pos);
}

setObjectiveLocation_nearest_enemy(objName) {
  level notify("moving " + objName);
  level endon("moving " + objName);
  objective = level.objectives[objName];
  closest_enemy = undefined;
  setObjectiveWaypoint(objName, &"INVASION_WAYPOINT_HOSTILES");
  north_trucks_retreat_point = getent("north_trucks_retreat_point", "targetname");

  while(objective.state != "done") {
    enemies = getaiarray("axis");
    if(enemies.size < 1) {
      level.obj_pos = north_trucks_retreat_point.origin;
      objective_position(objective.id, level.obj_pos);
      wait 3;
    } else {
      enemy_positions = [];
      foreach(guy in enemies)
      enemy_positions[enemy_positions.size] = guy.origin;
      level.obj_pos = AveragePoint(enemy_positions);
      objective_position(objective.id, level.obj_pos + (0, 0, 70));

      wait 2.2;
    }
  }
}

setObjectiveWaypoint(objName, text) {
  objective = level.objectives[objName];
  if(isDefined(text))
    Objective_SetPointerTextOverride(objective.id, text);
  else
    Objective_SetPointerTextOverride(objective.id);
}

setObjectiveLocationMoving(objName, objEnt, offset) {
  level notify("moving " + objName);
  level endon("moving " + objName);
  objective = level.objectives[objName];

  Objective_OnEntity(objective.id, objEnt, offset);
}

setObjectiveRemaining(objName, objString, objRemaining) {
  assert(isDefined(level.objectives[objName]));

  objective = level.objectives[objName];

  if(!objRemaining)
    objective_string(objective.id, objString);
  else
    objective_string(objective.id, objString, objRemaining);
}

set_threatbias_group(group) {
  assert(threatbiasgroupexists(group));
  self setthreatbiasgroup(group);
}

bmps_from_north_dead() {
  flag_wait("bmp_north_left_dead");
  flag_wait("bmp_north_mid_dead");

  flag_set("bmps_from_north_dead");
  level notify("bmps_from_north_dead");
}

should_break_use_drone_vs_bmps() {
  break_hint = false;
  if(isDefined(level.player.is_flying_missile))
    break_hint = true;
  if(level.player getCurrentWeapon() == "remote_missile_detonator")
    break_hint = true;
  if(flag("bmps_from_north_dead"))
    break_hint = true;

  return break_hint;
}

should_break_use_drone() {
  break_hint = false;
  if(isDefined(level.player.is_flying_missile))
    break_hint = true;
  if(level.player getCurrentWeapon() == "remote_missile_detonator")
    break_hint = true;

  return break_hint;
}

should_break_steer_drone() {
  break_hint = false;
  if(level.player getCurrentWeapon() == "remote_missile_detonator")
    break_hint = true;
  if((level.hint_steer_drone_time + 5000) < gettime())
    break_hint = true;

  return break_hint;
}

magic_glass_breaker() {
  toweaken = getdvarfloat("glass_damageToWeaken");
  todestroy = getdvarfloat("glass_damageToDestroy");
  bullets = (toweaken + todestroy) / 100;
  trgt = getent(self.target, "targetname");
  for(i = 0; i < bullets; i++) {
    magicbullet("nosound_magicbullet", self.origin, trgt.origin);
  }
}

UAVRigAiming() {
  level.uav endon("death");
  for(;;) {
    if(isDefined(level.uavTargetEnt))
      targetPos = level.uavTargetEnt.origin;
    else if(isDefined(level.uavTargetPos))
      targetPos = level.uavTargetPos;
    else
      targetpos = (-553.753, -2970, 2369.84);

    angles = VectorToAngles(targetPos - level.uav.origin);

    level.uavRig MoveTo(level.uav.origin, 0.10, 0, 0);
    level.uavRig RotateTo(ANGLES, 0.10, 0, 0);
    wait 0.05;
  }
}

cleanse_the_world() {
  volume = getent("house_area_volume", "targetname");

  entities = getEntArray();

  ignore_classnames = [];
  ignore_classnames["script_vehicle_corpse"] = true;
  ignore_classnames["script_model"] = true;
  ignore_classnames["script_brushmodel"] = true;

  ignore_classnames["script_vehicle_collmap"] = true;
  ignore_classnames["info_volume_breachroom"] = true;
  ignore_classnames["actor_ally_hero_foley"] = true;
  ignore_classnames["actor_ally_hero_dunn"] = true;
  ignore_classnames["stage"] = true;

  foreach(ent in entities) {
    if(isalive(ent)) {
      continue;
    }

    if(!isDefined(ent.classname)) {
      if(ent istouching(volume)) {
        ent delete();
      }

      continue;
    }

    if(isDefined(ignore_classnames[ent.classname])) {
      continue;
    }
    if(isDefined(ignore_classnames[ent.code_classname])) {
      continue;
    }
    if(ent == volume) {
      continue;
    }
    if(ent needs_ent_testing()) {
      org = spawn("script_origin", ent.origin);
      if(org istouching(volume)) {
        ent delete();
      }
      org delete();

      continue;
    }

    if(ent istouching(volume))
      ent delete();
  }
}

needs_ent_testing() {
  if(issubstr(self.code_classname, "script_vehicle"))
    return true;
  if(issubstr(self.code_classname, "script_vehicle_corpse"))
    return true;
  if(issubstr(self.code_classname, "script_brushmodel"))
    return true;
  if(issubstr(self.code_classname, "trigger"))
    return true;
  return self.code_classname == "info_volume";
}

delete_house_area_entities() {
  house_area_volume = getent("house_area_volume", "targetname");
  ents = getEntArray();
  foreach(thing in ents) {
    if(!isDefined(thing))
      continue;
    if(thing istouching(house_area_volume))
      thing delete();
  }
}

objective_main() {
  switch (level.start_point) {
    case "default":
    case "humvee":
      wait_for_yards();
    case "yards":
    case "bmp":
    case "pizza":
    case "gas_station":
    case "crash":
      objective_crash();
    case "nates_roof":
      objective_roof();

      objective_defend_roof();
    case "attack_diner":
      objective_predator();
    case "defend_diner":
      objective_BMPs();
    case "diner":
      objective_burgertown();
    case "burgertown":
    case "vip_escort":

    case "defend_bt":
    case "helis":
      objective_defend_raptor();
      objective_destroy_helicopter();
      objective_defend_raptor2();
      objective_destroy_helicopter2();
      objective_defend_raptor3();
    case "convoy":
      objective_convoy();
  }
}

wait_for_yards() {
  flag_wait_either("follow_foley", "entering_yards");
}

objective_crash() {
  obj = getstruct("police_car_moment", "script_noteworthy");
  origin = obj.origin;

  registerObjective("obj_crash", &"INVASION_OBJ_FOLEY", level.raptor.origin);
  setObjectiveState("obj_crash", "current");
  thread setObjectiveLocationMoving("obj_crash", level.raptor, (0, 0, 70));

  flag_wait("crash_objective");
  flag_wait_either("player_goto_roof", "player_on_roof");

  setObjectiveState("obj_crash", "done");
}

objective_roof() {
  if(!flag("player_on_roof")) {
    origin = level.obj_sentry.origin;

    registerObjective("obj_roof", &"INVASION_OBJ_ROOF", origin);
    setObjectiveState("obj_roof", "current");

    flag_wait("player_on_roof");

    setObjectiveState("obj_roof", "done");
  }
}

objective_defend_roof() {
  south_side_of_roof = getstruct("south_side_of_roof_obj_loc", "targetname");
  origin = south_side_of_roof.origin;

  registerObjective("obj_defend", &"INVASION_OBJ_DEFEND", origin);
  setObjectiveState("obj_defend", "current");
  setObjectiveWaypoint("obj_defend", &"INVASION_WAYPOINT_DEFEND");

  flag_wait("northside_roof");

  northside_roof = getstruct("northside_roof", "targetname");
  setObjectiveLocation("obj_defend", northside_roof.origin);
  setObjectiveWaypoint("obj_defend", &"INVASION_WAYPOINT_DEFEND");

  flag_wait("truck_guys_retreat");

  off_the_roof = getstruct("off_the_roof", "targetname");
  setObjectiveLocation("obj_defend", off_the_roof.origin);
  setObjectiveWaypoint("obj_defend");

  flag_wait("time_to_go_get_UAV_control");

  setObjectiveState("obj_defend", "done");
}

objective_predator() {
  predator_drone_control = getent("predator_drone_control", "targetname");
  origin = predator_drone_control.origin;

  registerObjective("obj_predator", &"INVASION_OBJ_PREDATOR", origin);
  setObjectiveState("obj_predator", "current");

  flag_wait("player_has_predator_drones");

  setObjectiveState("obj_predator", "done");
}

objective_burgertown() {
  nates_restaurant_goal = getent("nates_restaurant_goal", "targetname");
  origin = nates_restaurant_goal.origin;

  registerObjective("obj_burgertown", &"INVASION_OBJ_REGROUP", origin);
  setObjectiveState("obj_burgertown", "current");

  flag_wait("time_to_clear_burgertown");

  objective_burgertown_groundfloor = getent("objective_burgertown_groundfloor", "targetname");
  origin = objective_burgertown_groundfloor.origin;

  setObjectiveString("obj_burgertown", &"INVASION_OBJ_BURGERTOWN");
  setObjectiveLocation("obj_burgertown", origin);

  flag_wait("burger_town_lower_cleared");
  wait 2;

  setObjectiveState("obj_burgertown", "done");
}

objective_BMPs() {
  wait .2;
  if(!flag("bmp_north_left_dead")) {
    registerObjective("obj_bmps", &"INVASION_OBJ_BMPS", level.bmp_north_left.origin);
    setObjectiveState("obj_bmps", "current");
    thread setObjectiveLocationMoving("obj_bmps", level.bmp_north_left, (0, 0, 96));
  } else {
    if(!flag("bmp_north_mid_dead")) {
      registerObjective("obj_bmps", &"INVASION_OBJ_BMPS", level.bmp_north_mid.origin);
      setObjectiveState("obj_bmps", "current");
      thread setObjectiveLocationMoving("obj_bmps", level.bmp_north_mid, (0, 0, 96));
    } else
      return;
  }
  flag_wait("bmp_north_left_dead");
  if(!flag("bmp_north_mid_dead")) {
    thread setObjectiveLocationMoving("obj_bmps", level.bmp_north_mid, (0, 0, 96));
  }

  flag_wait("bmp_north_mid_dead");

  setObjectiveState("obj_bmps", "done");
}

objective_regroup_at_nates() {
  objective = getent("raptor_in_nates_prep", "targetname");
  origin = objective.origin;

  registerObjective("obj_nates_regroup", &"INVASION_OBJ_NATES_REGROUP", origin);
  setObjectiveState("obj_nates_regroup", "current");

  flag_wait("player_in_pos_to_cover_vip");

  setObjectiveState("obj_nates_regroup", "done");
}

objective_defend_raptor() {
  origin = level.raptor.origin;

  registerObjective("obj_raptor_defend", &"INVASION_OBJ_VIP_ESCORT", origin);
  setObjectiveState("obj_raptor_defend", "current");

  thread setObjectiveLocationMoving("obj_raptor_defend", level.raptor, (0, 0, 70));
  setObjectiveWaypoint("obj_raptor_defend", &"INVASION_WAYPOINT_PROTECT");

  flag_wait("president_in_BT_meat_locker");

  setObjectiveString("obj_raptor_defend", &"INVASION_OBJ_BURGERTOWN_DEFEND");
  thread setObjectiveLocation_nearest_enemy("obj_raptor_defend");

  flag_wait("first_attack_heli_spawned");
  wait 9;
}

setup_stingers() {
  level.nates_stinger = [];
  nates_stinger = getent("nates_stinger", "script_noteworthy");
  level.nates_stinger["origin"] = nates_stinger.origin;
  level.nates_stinger["angles"] = nates_stinger.angles;
  level.nates_stinger["classname"] = nates_stinger.classname;

  level waittill("attack_heli_spawned");

  diner_stinger = getent("diner", "script_noteworthy");
  if(isDefined(diner_stinger))
    diner_stinger setModel("weapon_stinger_obj");

  if(isDefined(nates_stinger))
    nates_stinger setModel("weapon_stinger_obj");

  while(1) {
    wait 2;
    if(!isalive(level.attack_heli)) {
      continue;
    }
    needs_stinger = true;
    weapons = level.player GetWeaponsListAll();
    foreach(weap in weapons)
    if(weap == "stinger")
      needs_stinger = false;

    if(!needs_stinger) {
      continue;
    }
    nates_stinger = getent("nates_stinger", "script_noteworthy");
    if(!isDefined(nates_stinger)) {
      weapon = spawn(level.nates_stinger["classname"], level.nates_stinger["origin"], 1);
      weapon.angles = level.nates_stinger["angles"];
      weapon ItemWeaponSetAmmo(1, 0);
      weapon.script_noteworthy = "nates_stinger";
      weapon setModel("weapon_stinger_obj");
    }
  }
}

objective_destroy_helicopter(second_heli) {
  level notify("attack_heli_spawned");
  needs_stinger = true;
  weapons = level.player GetWeaponsListAll();
  foreach(weap in weapons)
  if(weap == "stinger")
    needs_stinger = false;

  if(needs_stinger) {
    stinger_loc = level.nates_stinger["origin"];

    diner_stinger = getent("diner", "script_noteworthy");
    if(isDefined(diner_stinger)) {
      stinger_loc = diner_stinger.origin;
      level.obj_direction = "west";
    } else {
      level.obj_direction = "east";
    }
    origin = stinger_loc;
  } else {
    origin = level.attack_heli.origin;
  }

  level notify("moving obj_raptor_defend");
  setObjectiveString("obj_raptor_defend", &"INVASION_OBJ_ATTACK_HELI");
  setObjectiveLocation("obj_raptor_defend", origin);
  setObjectiveWaypoint("obj_raptor_defend");

  if(needs_stinger)
    level.attack_heli waittill_death_or_stinger();

  if(isalive(level.attack_heli)) {
    level notify("moving obj_raptor_defend");
    thread setObjectiveLocationMoving("obj_raptor_defend", level.attack_heli, (0, 0, 128));

    level.attack_heli waittill("death");
  }
}

waittill_death_or_stinger() {
  self endon("death");

  while(1) {
    level.player waittill("weapon_change");

    weap = level.player getCurrentWeapon();
    if(weap == "stinger") {
      autosave_by_name("got_stinger");
      break;
    }
  }
}

objective_defend_raptor2() {
  level notify("moving obj_raptor_defend");
  setObjectiveString("obj_raptor_defend", &"INVASION_OBJ_BURGERTOWN_DEFEND");

  thread setObjectiveLocation_nearest_enemy("obj_raptor_defend");

  flag_wait("second_attack_heli_spawned");
  wait 9;
}

objective_destroy_helicopter2() {
  second_heli = true;
  objective_destroy_helicopter(second_heli);
}

objective_defend_raptor3() {
  level notify("moving obj_raptor_defend");

  setObjectiveString("obj_raptor_defend", &"INVASION_OBJ_BURGERTOWN_DEFEND");

  thread setObjectiveLocation_nearest_enemy("obj_raptor_defend");

  flag_wait("time_to_goto_convoy");

  setObjectiveState("obj_raptor_defend", "done");
}

objective_convoy() {
  flag_wait("time_to_goto_convoy");

  if(!isDefined(level.convoy))
    level.convoy = getent("convoy_obj", "targetname");

  registerObjective("obj_convoy", &"INVASION_OBJ_CONVOY", level.convoy.origin);
  thread setObjectiveLocationMoving("obj_convoy", level.convoy, (0, 0, 128));
  setObjectiveState("obj_convoy", "current");
}
get_remotemissile_hint_string(str) {
  if(isDefined(self.remotemissile_actionslot)) {
    return str + "_" + self.remotemissile_actionslot;
  } else {
    return str + "_4";
  }
}