/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_payload.gsc
********************************************************/

function init() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("playerCountLandmarks");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");

  if(getdvarint("scr_br_payload_latejoin", 1) != 0) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &playerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipInfilSequence", &ref_133d6);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerHandleRedeploy", &ref_125c4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnInitialVehicles", &spawninitialvehicles);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipPrimaryWeaponDrop", &ref_133e1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipLootPickupAnim", &ref_133db);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("activateKillstreakOnPurchase", &attempted_to_use_gunship);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &scripts\engine\utility::void);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postPlunder", &ref_12804);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onConnectSpawnPoint", &ref_12006);

  if(istrue(game["switchedsides"])) {
    level.ref_133e0 = 1;
  }

  scripts\mp\gametypes\br_gametypes::ref_12b10("allowedEntities", ["br", "br_payload"]);
  var_0 = "downtown2";

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var_0 = "livingquarters";
  }

  level.disable_super_in_turret.ref_1226a = getDvar("scr_br_payload_path", var_0);
  level.disable_super_in_turret.getquestscalervalue = getdvarint("scr_br_payload_checkpoint_time", 240);
  level.disable_super_in_turret.maxtime = getdvarint("scr_br_payload_max_time", 300);
  level.disable_super_in_turret.getpropspawnlocation = getdvarint("scr_br_payload_checkpoint_remain", 60);
  level.disable_super_in_turret.ref_14242 = getdvarfloat("scr_br_payload_vehicle_mph", 6);
  level.disable_super_in_turret.ref_14243 = getdvarfloat("scr_br_payload_vehicle_mph_slow", 1);
  level.disable_super_in_turret.ref_14240 = getdvarfloat("scr_br_payload_vehicle_auto_mph", 12);
  level.disable_super_in_turret.ref_14241 = getdvarfloat("scr_br_payload_vehicle_mph_fast", 8);
  level.disable_super_in_turret.ref_1422d = getdvarfloat("scr_br_payload_vehicle_back_mph", 2);
  level.disable_super_in_turret.ref_1422e = getdvarfloat("scr_br_payload_vehicle_back_mph_slow", 1);
  level.disable_super_in_turret.ref_13633 = getdvarfloat("scr_br_payload_spawn_dist_defend", 7500);
  level.disable_super_in_turret.ref_13632 = getdvarfloat("scr_br_payload_spawn_dist_attack", 5500);
  level.disable_super_in_turret.ref_13660 = getdvarfloat("scr_br_payload_spawn_height_defend", 1500);
  level.disable_super_in_turret.ref_1365f = getdvarfloat("scr_br_payload_spawn_height_attack", 1000);
  level.disable_super_in_turret.ref_1368f = getdvarfloat("scr_br_payload_spawn_radius_defend", 500);
  level.disable_super_in_turret.ref_1368e = getdvarfloat("scr_br_payload_spawn_radius_attack", 500);
  level.disable_super_in_turret.ref_11b58 = getdvarint("scr_br_payload_max_damage_collision", 25);
  level.disable_super_in_turret.ref_1225f = getdvarint("scr_br_payload_econ", 1);
  level.disable_super_in_turret.ref_129cb = getdvarint("scr_br_payload_radial_spawn", 1);
  level.disable_super_in_turret.set_force_aitype_sniper = getdvarint("scr_br_payload_ground_spawn", 1);
  level.disable_super_in_turret.set_force_aitype_shotgun = getdvarint("scr_br_payload_ground_spawn_max", 20);
  level.disable_super_in_turret.ref_13746 = getdvarint("scr_br_payload_squad_spawn", 0);
  level.disable_super_in_turret.ref_13601 = getdvarint("scr_br_payload_attacker_air", 0);
  level.disable_super_in_turret.ref_13602 = getdvarint("scr_br_payload_attacker_air_max", 0);
  level.disable_super_in_turret.ref_13604 = getdvarint("scr_br_payload_spawn_protect_air_time", 5);
  level.disable_super_in_turret.ref_1365c = getdvarint("scr_br_payload_spawn_protect_ground_time", 10);
  level.juggheli_spawner_jammer5_3 = getdvarint("scr_br_payload_tacmap_zoom", 12000);
  level.disable_super_in_turret.checkpoint_objective = getdvarint("scr_br_payload_auto_kiosks", 1);
  level.disable_super_in_turret.getquestscaledvalue = getdvarint("scr_br_payload_checkpoint_models", 1);
  level.disable_super_in_turret.getpropsize = getdvarint("scr_br_payload_bunker_price", 5000);
  level.disable_super_in_turret.getquesttimefrac = getdvarint("scr_br_payload_tower_price", 2500);
  level.disable_super_in_turret.mine_caves_turret_1_support = getdvarint("scr_br_payload_vehicles", 0);
  level.disable_super_in_turret.ref_136ab = getdvarfloat("scr_br_payload_spawn_vehicle_time", 10);
  level.disable_super_in_turret.ref_142f8 = getdvarfloat("scr_br_payload_vo_help", 20000);
  level.disable_super_in_turret.ref_14305 = getdvarfloat("scr_br_payload_vo_same", 20000);
  level.disable_super_in_turret.ref_142f6 = getdvarfloat("scr_br_payload_vo_help", 5000);
  level.disable_super_in_turret.ref_142ff = getdvarfloat("scr_br_payload_vo_next", 10000);
  level.disable_super_in_turret.brking_oncrateuse = getdvarint("scr_br_payload_all_paths", 1);
  level.disable_super_in_turret.convoy = getdvarint("scr_br_payload_convoy", 1);
  level.disable_super_in_turret.idflags_hyper_burst_round = getdvarint("scr_br_payload_convoy_dist", 750);
  level.disable_super_in_turret.idflags_no_dismemberment = level.disable_super_in_turret.idflags_hyper_burst_round * level.disable_super_in_turret.idflags_hyper_burst_round;
  level.disable_super_in_turret.little_bird_mg_mp_spawncallback = getdvarint("scr_br_payload_disable_ascenders", 1);
  var_1 = getdvarfloat("scr_br_payload_vo_near_check", 1500);
  level.disable_super_in_turret.ref_142fe = var_1 * var_1;
  var_2 = getdvarfloat("scr_br_payload_vo_obs", 700);
  level.disable_super_in_turret.ref_14300 = var_2 * var_2;
  level.disable_super_in_turret.brmini_kickplayersatcircleedge = getdvarint("scr_br_payload_time_per_checkpoint", 120);
  level.disable_super_in_turret.ref_136c4 = getdvarint("scr_br_spawn_zones", 1);
  level.disable_super_in_turret.ref_136c2 = getdvarint("scr_br_spawn_zone_radius", 1700);
  level.disable_super_in_turret.ref_136be = getdvarint("scr_br_spawn_zones_hide", 1);
  level.disable_super_in_turret.ref_136c1 = getdvarfloat("scr_br_spawn_zones_outline_dur", 3);
  level.disable_super_in_turret.ref_136c5 = getdvarint("scr_br_spawn_zone_warning", 1);
  level.disable_super_in_turret.ref_136c9 = getdvarint("scr_br_spawn_zone_warning_rad", 300);
  level.disable_super_in_turret.ref_136c0 = getdvarint("scr_br_spawn_zone_oob_forgive_time", 1000);
  level.disable_super_in_turret.ref_136bf = getdvarint("scr_br_spawn_zone_oob_forgive_scale", 2);
  level.disable_super_in_turret.start_drones_event = getdvarint("scr_br_in_bounds_trigger", 1);
  level.disable_super_in_turret.ref_13ded = getdvarint("scr_br_truck_armor_box", 1);
  level.disable_super_in_turret.playerplunderdeposit = getdvarint("scr_br_payload_force_tiebreaker", 0);
  level.disable_super_in_turret.ref_12caa = getdvarint("scr_br_payload_respawn_overview", 1);
  level.disable_super_in_turret.ref_11f9d = getdvarint("scr_br_payload_obstacle_pay_scale", 40);
  level.disable_super_in_turret.ref_121fc = getdvarint("scr_br_payload_path_redeploy", 5);
  level.disable_super_in_turret.ref_12199 = getdvarint("scr_br_payload_overtime_max", 120);
  level.disable_super_in_turret.ref_1219e = getdvarint("scr_br_payload_overtime_s1", 60);
  level.disable_super_in_turret.ref_1219f = getdvarint("scr_br_payload_overtime_s2", 70);
  level.disable_super_in_turret.ref_121a0 = getdvarint("scr_br_payload_overtime_s3", 80);
  level.disable_super_in_turret.ref_121a1 = getdvarint("scr_br_payload_overtime_s4", 90);
  level.ref_127cd = 11;
  level.ref_13c56 = 1;
  level.playerlocationtriggerexit = 1;
  level.debug_silo_thrust = spawnStruct();
  level.debug_silo_thrust.disabled = 0;
  level.debug_silo_thrust.minigameapplyplayernamesettings = getdvarint("scr_br_alt_mode_payload_drop_max", -1);
  level.debug_silo_thrust.minigamewinnersettings = getdvarfloat("scr_br_alt_mode_payload_drop_percent", 0.33);

  if(level.disable_super_in_turret.checkpoint_objective) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("placedKiosks");
  }

  if(level.mapname == "mp_br_mechanics" && level.disable_super_in_turret.ref_1226a != "all") {
    level.disable_super_in_turret.ref_1226a = "standard";
  }

  level.dialog_wait_ready_civ = 4;
  level.debug_safehouse_gunshop_start = 1;
  level.disable_super_in_turret.paths = [];
  level.playerzombieupdatetagobjectives = ["apc_russian", "atv", "big_bird", "cargo_truck", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van", "loot_chopper"];
  setDvar("LKTPRPKPMR", 1);
  setDvar("LOSOOOTNMS", 0);
  setDvar("NNMLSMNTOQ", 0);
  thread toggleusbstickinhand();
  thread delay_start_escort_enter_vehicle_objective();
}

function toggleusbstickinhand() {
  waittillframeend();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 2);
  level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("roundlimit");
  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  scripts\mp\utility\dvars::setoverridewatchdvar("roundswitch", 1);
  level.roundswitch = scripts\mp\utility\dvars::getwatcheddvar("roundswitch");
  level.ref_12888 = &emp_drone_proximity_explode;
  level.ref_11c76 = &dyn_door;
  level.defenderflagreset = &eliminatedhudmonitor;
  level.ref_12db7 = &endgame_stars;
  level.ontimelimit = &ontimelimit;
  level.ref_11c7b = &ref_12607;
  level.ref_11c7c = &ref_12608;
  level.ref_13b7e = &timelimitclock;
  level.ref_11c68 = &ref_11c68;
  level.ref_12059 = &munition_source_getridof;
  level.modeonspawnplayer = &embassy_level_init;
  level.ref_11c73 = &ref_12054;
  level.forcegivesuper = &eliminateplayer;

  if(level.disable_super_in_turret.ref_1225f) {
    level.ref_11c7a = &ref_1226b;
  }

  scripts\mp\flags::gameflaginit("infil_complete", 0);
  scripts\mp\flags::gameflaginit("infil_anim_started", 0);
  level.disable_back_light = 1;
  level.roundenddelay = 5;
  level.checkforlaststandfinish = 1;
  level.ref_133e6 = 1;
  level.ref_133cd = 1;
  level.ref_133d7 = 1;
  level.set_tier_lights = getdvarfloat("scr_br_payload_gunner_dmg_reduction", 0.4);
  level.set_total_successful_vehicle_spawns_from_module = getdvarfloat("scr_br_payload_gunner_dmg_pen", 0.4);
  level.ref_12281 = "cargo_truck_mg";
  level.ref_12283 = "mkilo_physics_mg_payload";
  level.disable_super_in_turret.ref_1426e = 250;
  level.disable_super_in_turret.ref_1426d = 200;
  level.disable_super_in_turret.ref_14249 = (0, 0, 200);
  level.disable_super_in_turret.ref_1226e = getdvarint("scr_br_payload_quests", 1);
  level.disable_super_in_turret.ref_12275 = getdvarint("scr_br_payload_reset_quest_tracking", 0);
  level.disable_super_in_turret.ref_12271 = getdvarint("scr_br_payload_quests_num_squads", 1);
  level.disable_super_in_turret.ref_12272 = getdvarint("scr_br_payload_quests_tablets", 1);
  level.disable_super_in_turret.ref_12273 = getdvarint("scr_br_payload_versus_tablets", 1);
  level.disable_super_in_turret.ref_1226f = getdvarint("scr_br_payload_quests_give_att", 1);
  level.disable_super_in_turret.ref_12270 = getdvarint("scr_br_payload_quests_give_def", 0);
  level.disable_super_in_turret.ref_1227c = getdvarint("scr_br_payload_speed_reward_time", 45);
  level.disable_super_in_turret.ref_12288 = getdvarint("scr_br_payload_xp_checkpoint", 2000);
  scripts\mp\rank::ref_12189("kill", 100);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn);
  level.vehicle.spawn.ref_12ca2 = getdvarint("scr_br_payload_vehicle_respawn", 30);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14176(level.ref_12281, &ref_14259);
  var_2 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");
  var_2.ref_13e92 = "tur_gun_payload_truck_mp";
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d(level.ref_12281, "single", ["gunner"]);
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(level.ref_12281, var_3);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, [var_3]);
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(level.ref_12281, var_3);
  var_4.exitids = ["back", "back_left", "back_right", "front", "side_right"];
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, [var_3]);
  var_4.ref_13e8a = getcompleteweaponname("tur_gun_payload_truck_mp");
  var_4.ref_13e92 = "tur_gun_payload_truck_mp";
  scripts\cp_mp\vehicles\vehicle_interact::ref_141a7("upgrade", &ref_1418d, &ref_141ae, &ref_1418d, &ref_1418d);
  scripts\cp_mp\vehicles\vehicle_interact::ref_141a7("copyofupgrade", &ref_1418d, &ref_141ae, &ref_1418d, &ref_1418d);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d(level.ref_12281, "upgrade", ["tag_screen_left", 0, &ref_1418c]);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d(level.ref_12281, "copyofupgrade", ["tag_screen_right", 0, &ref_1418c]);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "specialCase_canUseCrate", &eliminate_drone_spotlight_speed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "createCustomStreakData", &init_relic_fastbleedout);
  level.headiconbox = undefined;
  timetonextcheckpoint();
  toggle_fx_trap();
  time_between_rocket_fire();
  timed_laser_trap_trigger();
  thankyou_photo();
  totalcollecteditems();
  timed_death();
  tracegroundheightexfil();
  technical_initdamage();
  terminal_pusher_approach_array_counter();
  time_on_floor();
  thread toggle_player_settings();
  tmtyl_vip_interactions();
  thread totalmuncurrencyearned();
  tomastrike_isflyingvehicle();
  hideinvisiblecollisions();
  level.teamdata[game["attackers"]]["respawnDelay"] = getdvarint("scr_br_payload_spawn_delay_attack", 0);
  level.teamdata[game["defenders"]]["respawnDelay"] = getdvarint("scr_br_payload_spawn_delay_defend", 15);
  thread ref_1452d(game["attackers"]);
  thread ref_1452d(game["defenders"]);

  if(istrue(level.disable_super_in_turret.ref_1226e)) {
    scripts\mp\gametypes\br_capshoot_quest::init();
    thread ref_1226d();
  }

  thread ref_1225e();
  thread ref_1226c();
  thread ref_12258();
  thread ref_131d6();
  level.isoutside = 0;
  level.isopenable = 0;
}

function hideinvisiblecollisions() {
  var_0 = getEnt("buildable_checkpoint_clipbrush", "targetname");
  var_1 = getEnt("buildable_guardtower_clipbrush", "targetname");
  var_2 = (0, 0, 0);
  var_0.origin = var_2;
  var_1.origin = var_2;
}

function ref_141ae(var_0, var_1, var_2, var_3) {
  var_1.disabled = 1;
}

function player_get_primary_weapon_object(var_0) {
  if(!isDefined(var_0)) {
    return "super_ammo_drop";
  }

  switch (var_0) {
    case "super_tac_insert":
    case "super_emp_drone":
    case "none":
      return "super_ammo_drop";
    default:
      return var_0;
  }
}

function eliminateplayer(var_0, var_1, var_2, var_3) {
  var_0 = player_get_primary_weapon_object(var_0);
  scripts\mp\gametypes\br_pickups::forcegivesuper(var_0, var_1, var_2, var_3);
}

function ref_1226c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  setomnvar("ui_hardpoint_timer", gettime());
  thread ref_13277(game["attackers"]);
  thread ref_13277(game["defenders"]);
  scripts\mp\flags::gameflagwait("infil_complete");

  foreach(var_1 in level.players) {
    if(isDefined(var_1 scripts\mp\supers::getcurrentsuper())) {
      var_1 scripts\mp\supers::setsuperbasepoints(0);
      var_1 scripts\mp\supers::setsuperextrapoints(0);
    }
  }
}

function ref_13277(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in var_1) {
    scripts\mp\utility\outline::outlineenableforteam(var_3, var_0, "outline_depth_payload", "level_script");
  }
}

function ref_11c68() {
  setomnvar("ui_current_round", 1);
  setomnvarforallclients("post_game_state", 2);
  scripts\mp\gametypes\br_public::brleaderdialog("halftime", 0, undefined, 1, 2);
  wait 10;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_br_extended_load_screen", 1);
    var_1 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  }
}

function onplayerconnect(var_0) {
  var_0 waittill("spawned_player");

  if(var_0.team == game["attackers"]) {
    ref_13184(var_0, 0);
  } else {
    ref_13184(var_0, 1);
  }

  thread ref_13277(game["attackers"]);
  thread ref_13277(game["defenders"]);

  if(scripts\mp\flags::gameflag("infil_complete")) {
    thread ref_1268d();
    thread ref_126e0();

    if(isDefined(var_0 scripts\mp\supers::getcurrentsuper())) {
      var_0 scripts\mp\supers::setsuperbasepoints(0);
      var_0 scripts\mp\supers::setsuperextrapoints(0);
    }
  }

  var_0.heli_landing_volumes = [];
}

function onplayerspawned() {
  level endon("prematch_done");

  for(;;) {
    play_smoke_fx(self);
    self waittill("spawned_player");
  }
}

function onplayerkilled(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(isDefined(var_2.vehicle) && isDefined(var_2.vehicle.occupants) && isDefined(var_2.vehicle.occupants["gunner"])) {
    if(var_2 == var_2.vehicle.occupants["gunner"]) {
      var_2 thread scripts\mp\rank::giverankxp("br_payload_kill_as_gunner", 50);
      var_2 thread scripts\mp\rank::scoreeventpopup("br_payload_kill_as_gunner");
      var_2 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(50, "br_payload_kill_as_gunner");
    }
  }

  if(isDefined(var_1.vehicle) && isDefined(var_1.vehicle.occupants) && isDefined(var_1.vehicle.occupants["gunner"])) {
    if(var_1 == var_1.vehicle.occupants["gunner"]) {
      var_2 thread scripts\mp\rank::giverankxp("br_payload_killed_gunner", 100, undefined);
      var_2 thread scripts\mp\gametypes\br::scriptableusestate("br_payload_killed_gunner", int(50), var_2.currentweapon, 1);
      var_2 thread scripts\mp\rank::scoreeventpopup("br_payload_killed_gunner");
      var_2 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(100, "br_payload_killed_gunner");
      return;
    }

    return;
  }
}

function ref_12054(var_0) {
  scripts\mp\gametypes\br_weapons::droptogroundmultitrace(var_0);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    ref_12508();
    return;
  }
}

function ref_12508() {
  var_0 = getdvarint("scr_br_payload_start_ammo", 2);

  if(var_0 == -2) {
    foreach(var_2 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_2)) {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
        self givemaxammo(var_2);
      }
    }
  } else if(var_0 == -1) {
    scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  } else if(var_0 > 0) {
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();

    foreach(var_6 in [self.primaryweapon, self.secondaryweapon]) {
      ref_13197(var_6, var_0);
    }

    ref_13141();
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
}

function ref_13141() {
  foreach(var_1 in [self.primaryweapon, self.secondaryweapon]) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var_1, "iw8_sn_crossbow") || scripts\engine\utility::string_starts_with(var_1, "iw8_sn_t9crossbow")) {
      var_2 = asmdevgetallstates(var_1);
      var_3 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_2);

      if(isDefined(var_3)) {
        var_4 = getdvarint("scr_br_crossbow_ammo_override", 20);
        scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, var_3, var_4, 0);
      }

      break;
    }
  }
}

function ref_13197(var_0, var_1) {
  var_2 = asmdevgetallstates(var_0);
  var_3 = scripts\mp\utility\weapon::getweaponbasenamescript(var_2);
  var_4 = weaponclass(var_3);
  var_5 = "scr_br_payload_ammoscale_" + var_4;
  var_6 = int(max(0, getdvarint(var_5, var_1)));
  var_7 = weaponclipsize(var_0);
  var_8 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_2);

  if(isDefined(var_8)) {
    self.br_ammo[var_8] = 0;

    if(istrue(var_2.should_spawn_boss_one)) {
      scripts\mp\gametypes\br_weapons::zone_bounds(var_2, 1);
      return;
    }

    scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, var_8, var_7 * var_6, 0);
    return;
  }
}

function attempted_to_use_gunship(var_0) {
  switch (var_0) {
    case "juggernaut":
      return 1;
    default:
      return undefined;
  }
}

function totalmuncurrencyearned() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");

  foreach(var_1 in level.players) {
    var_1.shouldfinishshootinglongdeath = 0;
  }

  for(;;) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      if(istrue(var_4.hidesmokinggunhudfromplayer)) {
        continue;
      }

      if(!isDefined(var_4.obj_payload_stage)) {
        continue;
      }

      foreach(var_6 in var_4.obj_payload_stage.touchlist) {
        foreach(var_8 in var_6) {
          foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_8.player.team, var_8.player.squadindex)) {
            if(!isDefined(var_1.ref_1227e)) {
              var_1.ref_1227e = 0;
            }

            var_1.ref_1227e += 5;

            if(var_1.ref_1227e >= 20) {
              if(!var_1.shouldfinishshootinglongdeath) {
                var_1 thread scripts\mp\rank::scoreeventpopup("br_payload_squad_on_payload");
              }

              var_1.shouldfinishshootinglongdeath = 1;
              var_10 = getdvarint("scr_br_timeOnPayload_xpOverride", 18);
              var_11 = int(var_10) * var_1.ref_1227e;
              var_1 thread scripts\mp\rank::giverankxp("br_payload_squad_on_payload", var_11, undefined);
              var_1 thread scripts\mp\gametypes\br::searchradiusidealmax(min(40, var_1.ref_1227e) * 1000);
              var_1 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(var_11, "br_payload_squad_on_payload");
              var_1.ref_1227e = 0;
            }
          }
        }
      }
    }

    foreach(var_1 in level.players) {
      var_1.shouldfinishshootinglongdeath = 0;
    }

    wait 5;
  }
}

function ref_1418c(var_0, var_1) {}

function ref_1418d(var_0, var_1, var_2, var_3) {}

function vehicle_spawn_mp_gamemodesupportsrespawn() {
  return true;
}

function ref_126f1(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"]) && !istrue(game["switchedsides"])) {
    scripts\mp\hud_message::showsplash("br_prematch_welcome");
    return;
  }
}

function ref_1365d(var_0) {
  if(istrue(level.dmztut_endgametransition) && isDefined(self.thrust_fx_model) && !istrue(var_0.br_infilstarted)) {
    var_1 = spawnStruct();
    var_0.br_infilstarted = 1;
    var_0.ref_1286f = var_0.thrust_fx_model;
    var_0.ref_1286f.index = -1;
    thread ref_126a4(var_0);
  }

  if(istrue(game["switchedsides"]) && isDefined(self.thrust_fx_model)) {
    return true;
  }

  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

function manage_fakebody_hides() {
  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  level.disable_super_in_turret.ref_13916 = 0;

  if(!istrue(game["switchedsides"])) {
    scripts\mp\deathicons::ref_12bfd();
  } else {
    ref_143f7();
  }

  ref_1361b();
  level.dmztut_endgametransition = 1;
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      thread ref_1255f();
    }
  }

  thread maxnumsites();

  if(!istrue(game["switchedsides"])) {
    wait 2;
  }

  scripts\mp\flags::gameflagset("prematch_fade_done");
  ref_143f8(getdvarfloat("scr_br_payload_infil_wait", 9));

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      thread ref_1255d();
    }
  }

  scripts\mp\flags::gameflagset("infil_anim_started");
  wait 6.66667;
  waitframe();
  scripts\mp\flags::gameflagset("infil_complete");
  waitframe();
  last_unresolved_collision_time();
}

function maxnumsites() {
  level endon("infil_complete");

  for(;;) {
    level waittill("connected", var_0);

    if(!scripts\mp\flags::gameflag("infil_anim_started")) {
      thread ref_1255f(var_0);
      continue;
    }

    thread ref_1255d();
  }
}

function ref_143f7() {
  var_0 = gettime() + 10000;

  while(gettime() < var_0 && getactiveclientcount() != level.players.size) {
    waitframe();
  }
}

function ref_133d6() {
  scripts\mp\flags::gameflagset("infil_complete");
}

function ref_1361b() {
  var_0 = 8;
  level.disable_super_in_turret.gas_trigger_player_think = [];
  var_1 = int(max(getactiveclientcount(), level.players.size));

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 setModel("generic_prop_x3");
    level.disable_super_in_turret.gas_trigger_player_think[level.disable_super_in_turret.gas_trigger_player_think.size] = var_3;

    if((var_2 + 1) % var_0 == 0) {
      waitframe();
    }
  }
}

function last_unresolved_collision_time() {
  foreach(var_1 in level.disable_super_in_turret.gas_trigger_player_think) {
    if(isDefined(var_1) && !istrue(var_1.inuse)) {
      var_1 delete();
    }
  }

  level.disable_super_in_turret.gas_trigger_player_think = undefined;
}

function ref_1255f(var_0) {
  self endon("disconnect");

  if(isDefined(self.cameraent)) {
    return;
  }

  self.br_infilstarted = 1;

  if(istrue(var_0)) {
    waitframe();
  }

  if(!isDefined(level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()])) {
    var_1 = spawn("script_model", (0, 0, 0));
    var_1 setModel("generic_prop_x3");
    level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()] = var_1;
  }

  self.cameraent = level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()];
  self.cameraent.inuse = 1;

  if(!istrue(game["switchedsides"])) {
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  }

  var_2 = round_enemies_push_logic(self.team, self.squadindex);
  var_3 = level.disable_super_in_turret.paths[var_2];

  if(!isDefined(self.ref_13689)) {
    ref_12689(var_3);
    self.ref_13689 = ref_1257c(var_3);
  }

  self.cameraent.origin = self.ref_13689.origin;
  self.cameraent.angles = ref_1257a(var_3, self.cameraent.origin);
  var_4 = ref_1257b();
  self.cameraent scriptmodelplayanim(var_4, "spawn_camera_anim");
  self.cameraent scriptmodelpauseanim(1);
  waittillframeend();
  var_5 = self.cameraent gettagorigin("j_prop_1");
  var_6 = getdvarint("scr_br_initial_stream_timeout_pl_ms", 12000);
  scripts\mp\gametypes\br_public::ref_126b9(var_5, var_6, 1);

  if(!istrue(var_0) && !istrue(game["switchedsides"])) {
    wait 2;
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 1);
  scripts\mp\gametypes\br::spawnintermission(var_5, self.cameraent.angles);

  if(!istrue(game["switchedsides"])) {
    self setclientomnvar("ui_br_bink_overlay_state", 5);
  }

  scripts\mp\gametypes\br_public::ref_126ed();
  level.disable_super_in_turret.ref_13916++;
}

function ref_1257a(var_0, var_1) {
  if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
    var_2 = var_0.nodes[0].origin - var_1;
  } else if(self.team == game["attackers"]) {
    var_2 = var_1.nodes[var_1.nodes.size - 1].origin - var_2;
  } else {
    var_2 = var_2.nodes[0].origin - var_2;
  }

  var_3 = vectortoangles(var_2);
  return (0, var_3[1], 0);
}

function ref_1257b() {
  switch (level.disable_super_in_turret.ref_1226a) {
    case "livingquarters":
      if(self.team == game["attackers"]) {
        return "iw8_br_payload_escape4_intro_camera_swoop_LQ_Atck";
      } else {
        return "iw8_br_payload_escape4_intro_camera_swoop_LQ_Dfnd";
      }

      break;
    case "chemicaleng":
      if(self.team == game["attackers"]) {
        return "iw8_br_payload_escape4_intro_camera_swoop_CE_Atck";
      } else {
        return "iw8_br_payload_escape4_intro_camera_swoop_CE_Dfnd";
      }

      break;
    case "shore":
      if(self.team == game["attackers"]) {
        return "iw8_br_payload_escape4_intro_camera_swoop_S_Atck";
      } else {
        return "iw8_br_payload_escape4_intro_camera_swoop_S_Dfnd";
      }

      break;
    default:
      if(self.team == game["attackers"]) {
        return "iw8_br_payload_intro_camera_swoop_attackers";
      } else {
        return "iw8_br_payload_intro_camera_swoop_defenders";
      }

      break;
  }
}

function round_enemies_push_logic(var_0, var_1) {
  if(isDefined(level.squaddata[var_0][var_1].time_after_shoot)) {
    return level.squaddata[var_0][var_1].time_after_shoot;
  }

  if(!isDefined(level.teamdata[var_0]["nextSpawnIndex"])) {
    var_2 = relic_squadlink_outline_monitor(var_0);

    if(isDefined(level.teamdata[var_2]["nextSpawnIndex"])) {
      level.teamdata[var_0]["nextSpawnIndex"] = level.teamdata[var_2]["nextSpawnIndex"];
    } else {
      level.teamdata[var_0]["nextSpawnIndex"] = randomint(level.disable_super_in_turret.paths.size);
    }
  }

  level.squaddata[var_0][var_1].time_after_shoot = level.teamdata[var_0]["nextSpawnIndex"];
  level.teamdata[var_0]["nextSpawnIndex"]++;

  if(level.teamdata[var_0]["nextSpawnIndex"] >= level.disable_super_in_turret.paths.size) {
    level.teamdata[var_0]["nextSpawnIndex"] = 0;
  }

  return level.squaddata[var_0][var_1].time_after_shoot;
}

function ref_1255d() {
  self endon("disconnect");

  if(self.sessionstate != "intermission") {
    ref_1255f(1);
  } else {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  ref_1255c();

  if(!istrue(game["switchedsides"])) {
    self setclientomnvar("ui_br_bink_overlay_state", 5);
  }

  ref_13185(1);
  var_0 = 1;
  var_1 = 6.66667 - var_0;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1);
  self clearsoundsubmix("mp_br_mode_payload_completed", 0.5);
  self clearpredictedstreampos();
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
  self cameralinkTo(self.cameraent, "j_prop_1", 1, 1);
  self.cameraent scriptmodelpauseanim(0);
  thread ref_12560();
  wait var_1;
  var_2 = angleclamp180(angleclamp180(self.angles[1]) - angleclamp180(self.cameraent.angles[1]));
  self.cameraent rotateYaw(var_2, var_0, 0.1, 0.1);
  wait var_0;
  thread ref_1255e();
  wait 1;
  self.cameraent delete();
}

function ref_12560() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = 1;
  var_2 = 6.66667 - var_0 - var_1;
  self setsoundsubmix("iw8_br_payload_infil_camera");
  wait var_0;
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("payload_welcome", self);

  if(self.team == game["defenders"]) {
    var_3 = "br_payload_welcome_defenders";

    if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
      var_3 = "br_payload_welcome_defenders_mini";
    }

    scripts\mp\hud_message::showsplash(var_3);
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("defend_intro1", self);
  } else {
    var_3 = "br_payload_welcome_attackers";

    if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
      var_3 = "br_payload_welcome_attackers_mini";
    }

    scripts\mp\hud_message::showsplash(var_3);
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("attack_intro1", self);
  }

  wait var_2;
  self setplayermusicstate("br3_payload_round_start");
  wait var_3;
  self clearsoundsubmix("iw8_br_payload_infil_camera", 6);
}

function ref_1255c(var_0) {
  self endon("disconnect");
  self notify("playerPayloadFirstSpawn");
  self endon("playerPayloadFirstSpawn");
  scripts\mp\gametypes\br_public::ref_1264c();
  self.forcespawnorigin = self.ref_13689.origin;
  self.forcespawnangles = self.ref_13689.angles;
  self.ref_12ca8 = !game["switchedsides"];

  if(!isalive(self)) {
    self.prematchendeddeadfixup = 1;
  }

  self.plotarmor = 1;
  scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  waitframe();
  self.ref_13689 = undefined;
  self.plotarmor = undefined;
  self.ref_12ca8 = undefined;
  self.thrust_fx_model = undefined;
  self freezecontrols(1);
  self playerhide();
}

function ref_1255e() {
  self cameraunlink();
  self freezecontrols(0);
  self playershow();

  if(scripts\mp\gametypes\br_gulag::set_relic_punchbullets()) {
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  }

  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);

  if(level.disable_super_in_turret.ref_13602 > -1) {
    thread ref_1253a();
  }

  ref_13185(0);

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    scripts\mp\supers::setsuperbasepoints(0);
    scripts\mp\supers::setsuperextrapoints(0);
  }

  ref_1255b();
}

function ref_143f8(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1 && level.disable_super_in_turret.ref_13916 < level.players.size) {
    waitframe();
  }
}

function ref_136aa(var_0) {
  ref_13230();

  foreach(var_2 in level.disable_super_in_turret.paths) {
    ref_1367a(var_2, game["attackers"], var_0);

    if(level.disable_super_in_turret.convoy) {
      ref_1367b(var_2, game["attackers"], var_0);
    }
  }

  init_relic_doubletap(game["attackers"]);
  init_relic_doubletap(game["defenders"]);
  thread ref_13c54();
}

function ref_1367a(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = var_0;
  var_5 = undefined;
  var_6 = 0;

  if(level.disable_super_in_turret.convoy) {
    var_6 = 1;
  }

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[var_6]) && isDefined(var_0.nodes[var_6 + 1])) {
    var_4 = var_0.nodes[var_6];
    var_5 = var_0.nodes[var_6 + 1];
    var_3 = vectortoangles(var_5.origin - var_4.origin);
  } else if(isDefined(var_0.target)) {
    if(level.disable_super_in_turret.convoy) {
      var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    } else {
      var_4 = var_0;
    }

    if(isDefined(var_4) && isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");
      var_3 = vectortoangles(var_5.origin - var_4.origin);
    }
  }

  var_7 = spawnStruct();
  var_7.origin = var_4.origin;
  var_7.angles = var_3;
  var_7.spawntype = "GAME_MODE";
  var_7.spawnmethod = "place_at_position_unsafe";
  var_7.team = var_1;
  var_7.player_rig_create = &ref_1423f;
  var_7.vehicletype = level.ref_12283;
  var_7.modelname = "veh8_mil_lnd_mkilo23_payload";
  var_7.turretmodel = "veh8_mil_lnd_mkilo23_turret_payload";
  var_8 = spawnStruct();
  var_9 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(level.ref_12281, var_7, var_8);
  var_9.ondeathrespawn = undefined;
  var_9 unmarkkeyframedmover(1);
  var_9 method_87c2(1);

  foreach(var_11 in var_9.turrets) {
    var_11 setscriptablepartstate("barrel", "show");
    ref_136a4(var_11);
  }

  if(istrue(var_2) && level.disable_super_in_turret.ref_13ded) {
    ref_1360a(var_9);
  }

  if(isDefined(var_5)) {
    var_0.vehicle = var_9;
    var_9.path = var_0;
  }

  ref_14260(var_9, var_0);

  if(isDefined(var_5)) {
    thread ref_1422f(var_9);
  }

  return var_9;
}

function ref_136a4(var_0) {
  if(getdvarint("scr_br_payload_tcol", 1) == 0) {
    return;
  }

  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("veh8_mil_lnd_mkilo23_turret_payload_nomesh");
  var_1 linkTo(var_0, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  var_0.ref_13e84 = var_1;
}

function ref_1360a(var_0) {
  var_1 = (-158, -43, 67);
  var_2 = (0, 0, 0);
  var_3 = 80;
  var_4 = "ui_mp_br_loot_icon_health_armor_box";
  var_5 = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
  var_6 = "equip_armorBox";
  var_7 = spawn("script_model", var_0.origin);
  var_7 setModel("offhand_wm_supportbox_armor_br");
  var_7 linkTo(var_0, "tag_origin", var_1, var_2);
  var_7 setscriptablepartstate("beacon", "active", 0);
  var_7 setscriptablepartstate("anims", "openIdle", 0);
  var_7.ref_13f0f = 1;
  var_7.team = game["attackers"];
  var_7 scripts\mp\equipment\support_box::supportbox_addheadicon(var_4);
  var_7 thread scripts\mp\equipment\support_box::supportbox_makeusable(var_6, var_5);
  var_7 setuserange(var_3);
  var_7 setusefov(90);
  var_7 notsolid();
  setheadiconsnaptoedges(var_7.showdroplocations, var_3);
  setheadiconsnaptoedges(var_7.showemergencyhint, var_3);
  var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel = var_7;
}

function ref_14234() {
  level endon("game_ended");
  self notify("vehicleCleanupLoot");
  self endon("vehicleCleanupLoot");
  self endon("pathComplete");
  self endon("death");

  for(;;) {
    var_0 = canceljoins(undefined, undefined, self.origin, level.disable_super_in_turret.ref_1426e);

    foreach(var_2 in var_0) {
      if(issubstr(var_2.type, "_weapon_")) {
        var_2 scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
      }
    }

    waitframe();
  }
}

function ref_133e1(var_0) {
  var_1 = self;

  foreach(var_3 in level.disable_super_in_turret.paths) {
    if(isDefined(var_3.vehicle) && ref_11a3e(var_3.vehicle, var_1.origin)) {
      return true;
    }

    foreach(var_5 in var_3.ref_11f9e) {
      if(isDefined(var_5) && ref_11a3d(var_5, var_1.origin)) {
        return true;
      }
    }
  }

  return false;
}

function ref_11a3e(var_0, var_1) {
  var_2 = level.disable_super_in_turret.ref_1426e * level.disable_super_in_turret.ref_1426e;
  var_3 = distance2dsquared(var_1, var_0.origin);
  return var_3 < var_2;
}

function ref_11a3d(var_0, var_1) {
  var_2 = 10000;
  var_3 = distance2dsquared(self.origin, var_0.origin);
  return var_3 < var_2;
}

function ref_133db(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(isDefined(var_2.vehicle) && ref_11a3e(var_2.vehicle, var_0.origin)) {
      return true;
    }

    foreach(var_4 in var_2.ref_11f9e) {
      if(ref_11a3d(var_4, var_0.origin)) {
        return true;
      }
    }
  }

  return false;
}

function ref_1367b(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = undefined;

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[1])) {
    var_4 = var_0.nodes[1];
    var_3 = vectortoangles(var_4.origin - var_0.origin);
  }

  var_5 = spawnStruct();
  var_5.origin = var_0.origin;
  var_5.angles = var_3;
  var_5.spawntype = "GAME_MODE";
  var_5.spawnmethod = "place_at_position_unsafe";
  var_5.team = var_1;
  var_5.player_rig_create = &ref_1423f;
  var_5.vehicletype = level.ref_12283;
  var_5.modelname = "veh8_mil_lnd_mkilo23_payload_convoy";
  var_5.turretmodel = "veh8_mil_lnd_mkilo23_turret_payload";
  var_6 = spawnStruct();
  var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(level.ref_12281, var_5, var_6);
  var_7.ondeathrespawn = undefined;
  var_7 method_87c2(1);

  foreach(var_9 in var_7.turrets) {
    var_9 setscriptablepartstate("barrel", "show");
    ref_136a4(var_9);
  }

  if(istrue(var_2)) {
    ref_13dec(var_7, var_0.ref_12358, 0);

    if(level.disable_super_in_turret.ref_13ded) {
      ref_1360a(var_7);
    }
  }

  if(isDefined(var_4)) {
    var_0.idle_sfx = var_7;
    var_7.path = var_0;
  }

  if(level.ref_12281 == "cargo_truck_mg") {
    var_7 setscriptablepartstate("upgrade", "vehicle_unusable");
    var_7 setscriptablepartstate("copyofupgrade", "vehicle_unusable");
  }

  var_7.uav_getenemyplayersinrange = 1;

  if(isDefined(var_4)) {
    thread ref_14236(var_7);
  }

  return var_7;
}

function ref_1423f(var_0, var_1) {}

function ref_14259(var_0) {
  return !isDefined(self.path);
}

function ref_14260(var_0) {
  if(!isDefined(var_0.trigger)) {
    var_0.trigger = spawn("trigger_radius", self.origin, 0, level.disable_super_in_turret.ref_1426e, level.disable_super_in_turret.ref_1426d);
  }

  if(!istrue(var_0.trigger.x1loadout)) {
    var_0.trigger enablelinkTo();
    var_0.trigger.x1loadout = 1;
  }

  var_0.trigger linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.trigger.brkillstreakbeginusefunc = 1;

  if(!isDefined(var_0.obj_payload_stage)) {
    var_0.obj_payload_stage = scripts\mp\gameobjects::createuseobject(self.team, var_0.trigger, [], level.disable_super_in_turret.ref_14249);
  }

  var_0.obj_payload_stage.usecondition = &getlocationnameforpoint;
  var_0.obj_payload_stage.getrandompointincirclewithindistance = 1;
  var_0.obj_payload_stage.nousebar = 1;
  var_0.obj_payload_stage scripts\mp\gameobjects::allowuse("any");
  var_0.obj_payload_stage scripts\mp\gameobjects::setvisibleteam("any");
  var_0.obj_payload_stage scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_0.obj_payload_stage.iconname = self.path.iconname;
  var_0.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
  var_0.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_escort_neutral", "waypoint_halt_neutral");
  function_042c(var_0.obj_payload_stage.objidnum, 1);
  playencryptedcinematicforall(var_0.obj_payload_stage.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_0.obj_payload_stage.objidnum, self);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_0.obj_payload_stage.objidnum, var_0.obj_payload_stage.offset3d[2]);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.obj_payload_stage.objidnum, 0);

  if(level.ref_12281 == "cargo_truck_mg") {
    self setscriptablepartstate("upgrade", "vehicle_unusable");
    self setscriptablepartstate("copyofupgrade", "vehicle_unusable");
  }

  self.obj_payload_stage = var_0.obj_payload_stage;
}

function relic_squadlink_outline_monitor(var_0) {
  if(var_0 == "axis") {
    return "allies";
  }

  return "axis";
}

function ref_14251() {
  level endon("game_ended");
  level endon("payloadComplete");
  self notify("vehicleMoveUpdate");
  self endon("vehicleMoveUpdate");
  self endon("pathComplete");
  self endon("death");
  waittillframeend();
  var_0 = getdvarint("scr_br_payload_vehicle_pay_time_tick", 6000);
  var_1 = getdvarint("scr_br_payload_vehicle_pay_scale", 4);
  var_2 = getdvarint("scr_br_payload_vehicle_defender_pay_scale", 7);
  var_3 = gettime() + var_0;
  var_4 = self.path;
  var_5 = var_4.idle_sfx;
  ref_14247(var_5);
  var_6 = gettime() + 1000;

  for(;;) {
    var_7 = ref_14245(self.team);
    var_8 = ref_14245(relic_squadlink_outline_monitor(self.team));
    ref_14274(var_7, var_8);
    ref_14272();

    if(var_3 < gettime()) {
      var_3 = gettime() + var_0;
      ref_12284(var_7, var_8, var_1, var_2);
    }

    if(gettime() >= var_6) {
      ref_1422c();
      var_6 = gettime() + 1000;
    }

    var_9 = undefined;

    if(istrue(level.disable_super_in_turret.ref_1227b)) {
      var_10 = level.disable_super_in_turret.ref_14241;
    } else {
      var_10 = level.disable_super_in_turret.ref_14242;
    }

    var_11 = var_10;
    var_12 = level.disable_super_in_turret.ref_1422d;

    if(isDefined(var_5)) {
      var_13 = distance2dsquared(self.origin, var_5.origin);

      if(var_13 < level.disable_super_in_turret.idflags_no_dismemberment) {
        var_11 = level.disable_super_in_turret.ref_14243;
        var_12 = level.disable_super_in_turret.ref_1422e;
      }
    }

    if(!var_7 && var_8 && !self.carriable_explode) {
      self vehicle_setspeed(var_12);
      self.veh_transmission = "reverse";

      if(isDefined(var_5)) {
        if(!istrue(var_5.carriable_fuse_light_watch)) {
          var_5 vehicle_setspeed(level.disable_super_in_turret.ref_1422d);
          var_5.veh_transmission = "reverse";
        } else {
          var_5 vehicle_setspeed(0);
        }
      }

      var_9 = "reverse";

      if(isDefined(self.tutonplayerkilled) && isDefined(self.cone)) {
        var_14 = anglesToForward(self.angles) * -1;
        var_15 = vectorNormalize(self.origin - self.cone);
        var_16 = vectordot(var_14, var_15);

        if(var_16 > 0) {
          var_17 = distance(self.cone, self.origin);

          if(var_17 > getdvarfloat("scr_payload_unblock_distance", 2)) {
            self.tutonplayerkilled = undefined;
            self.carriable_physics_launch = undefined;
            self.cone = undefined;
          }
        }
      }
    } else if(isDefined(self.tutonplayerkilled)) {
      var_9 = "blocked";
      self vehicle_setspeed(0);

      if(isDefined(var_5)) {
        var_5 vehicle_setspeed(0);
      }
    } else if(var_7 && !var_8) {
      self vehicle_setspeed(var_10);
      self.veh_transmission = "forward";
      self.carriable_explode = 0;
      ref_14273();

      if(isDefined(self.carriable_physics_launch)) {
        ref_11f9b(self.carriable_physics_launch);
        self.carriable_physics_launch = undefined;
      }

      if(isDefined(var_5)) {
        var_5 vehicle_setspeed(var_11);
        var_5.veh_transmission = "forward";
        var_5.carriable_fuse_light_watch = 0;
      }

      var_9 = "forward";
    } else {
      if(var_7 && var_8) {
        var_9 = "contested";
      }

      self vehicle_setspeed(0);

      if(isDefined(var_5)) {
        var_5 vehicle_setspeed(0);
      }
    }

    if(!var_7) {
      ref_1425b();
    }

    var_18 = ref_14252(var_9);
    var_9 = var_18[0];
    var_19 = var_18[1];
    var_18 = undefined;
    var_20 = var_7 > 0;
    ref_11f92(self.path, var_20, var_9, var_19);
    waitframe();
  }
}

function ref_14247(var_0) {
  self vehicle_setspeed(level.disable_super_in_turret.ref_14242);

  if(isDefined(var_0)) {
    var_0 vehicle_setspeed(level.disable_super_in_turret.ref_14242);
  }

  wait 0.5;
}

function ref_14252(var_0) {
  var_1 = relic_amped_last_kill_time(self.path);

  if(var_1 < 0 || !isDefined(var_0) || var_0 != "forward") {
    return [var_0, undefined];
  }

  var_2 = self.path;
  var_3 = var_2.getquestreward_checkforvalueoverride[var_1].ref_11ea5;
  var_4 = var_2.nodes[var_3].origin;
  var_5 = distance2dsquared(self.origin, var_4);

  if(var_5 < level.disable_super_in_turret.ref_142fe) {
    return ["near", var_1 + 1];
  }

  return [var_0, undefined];
}

function ref_1423a() {
  level endon("game_ended");
  self notify("vehicleDamageVehicles");
  self endon("vehicleDamageVehicles");
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers()) {
      ref_1423e(var_7, self);
      continue;
    }

    if(isDefined(var_7.equipmentref) && var_7.equipmentref == "equip_tac_cover") {
      var_7 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 1);
    }
  }
}

function ref_1423e(var_0) {
  self.ref_12282 = 1;
  self dodamage(self.health, var_0.origin, var_0, var_0);

  if(isDefined(self)) {
    self.ref_12282 = undefined;
    return;
  }
}

function ref_14274(var_0, var_1) {
  if(!var_0 && var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(relic_squadlink_outline_monitor(self.team));
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_halting", "waypoint_escort");
    ref_12206(self.path, game["attackers"], "red");
    ref_12206(self.path, game["defenders"], "blue");
    var_2 = scripts\engine\utility::ter_op(!game["switchedsides"], "halt0", "halt1");
    self setscriptablepartstate("radiusEffect", var_2, 0);
    function_042c(self.obj_payload_stage.objidnum, 0);
    self.status = "back";
    ref_13190(self.path.script_index, 2);
  } else if(isDefined(self.tutonplayerkilled)) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam("neutral");
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blocked");
    ref_12206(self.path, game["attackers"], "yellow");
    ref_12206(self.path, game["defenders"], "yellow");
    self setscriptablepartstate("radiusEffect", "contest", 0);
    function_042c(self.obj_payload_stage.objidnum, 0);
    self.status = "blocked";
    ref_13190(self.path.script_index, 0);
  } else if(var_0 && !var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_escorting", "waypoint_halt");
    ref_12206(self.path, game["attackers"], "blue");
    ref_12206(self.path, game["defenders"], "red");
    var_2 = scripts\engine\utility::ter_op(!game["switchedsides"], "escort0", "escort1");
    self setscriptablepartstate("radiusEffect", var_2, 0);
    function_042c(self.obj_payload_stage.objidnum, 0);
    self.status = "forward";
    ref_13190(self.path.script_index, 1);
  } else if(var_0 && var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam("neutral");
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
    ref_12206(self.path, game["attackers"], "yellow");
    ref_12206(self.path, game["defenders"], "yellow");
    self setscriptablepartstate("radiusEffect", "contest", 0);
    function_042c(self.obj_payload_stage.objidnum, 0);
    self.status = "contested";
    ref_13190(self.path.script_index, 3);
  } else {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_escort_neutral", "waypoint_halt_neutral");
    ref_12206(self.path, game["attackers"], "white");
    ref_12206(self.path, game["defenders"], "white");
    self setscriptablepartstate("radiusEffect", "idle", 0);
    function_042c(self.obj_payload_stage.objidnum, 1);
    self.status = "idle";
    ref_13190(self.path.script_index, 4);
  }

  ref_14272();
}

function ref_14272() {
  var_0 = self.path;
  var_1 = ref_14244();
  var_2 = var_1 / var_0.ref_13bf1;

  if(var_0.getquestplunderrewardinstance >= 0) {
    var_3 = 0;

    if(var_0.getquestplunderrewardinstance > 0) {
      var_3 = var_0.getquestreward_checkforvalueoverride[var_0.getquestplunderrewardinstance - 1].loot_choppers;
    }

    var_4 = var_0.getquestreward_checkforvalueoverride[var_0.getquestplunderrewardinstance].loot_choppers - var_3;
    var_1 -= var_3;
    var_5 = var_1 / var_4;
  } else {
    var_5 = 0;
  }

  ref_1318f(var_1.script_index, var_5);

  if(isDefined(level.teamdata[game["attackers"]]["checkpoint"].choppersupport_modifydamage_trial[var_1.script_index])) {
    level.teamdata[game["attackers"]]["checkpoint"].choppersupport_modifydamage_trial[var_1.script_index].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(var_5, 0);
  }

  if(isDefined(level.teamdata[game["defenders"]]["checkpoint"].choppersupport_modifydamage_trial[var_1.script_index])) {
    level.teamdata[game["defenders"]]["checkpoint"].choppersupport_modifydamage_trial[var_1.script_index].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(var_5, 0);
  }

  var_5 = clamp(var_5, 0, 1);
  objective_setprogress(self.obj_payload_stage.objidnum, var_5);
}

function ref_14244() {
  var_0 = self;
  var_1 = var_0.path;

  if(istrue(var_1.hidesmokinggunhudfromplayer)) {
    return var_1.ref_13bf1;
  }

  var_2 = var_1.ref_136fc[var_1.ref_136fb].points[var_1.initial_enemy_spawner];
  var_3 = var_1.ref_136fc[var_1.ref_136fb].points[var_1.initial_enemy_spawner + 1];
  var_4 = pointonsegmentnearesttopoint(var_2, var_3, var_0.origin);
  var_5 = distance(var_4, var_2);
  var_6 = var_1.ref_136fc[var_1.ref_136fb].armsrace_c4_planter_internal[var_1.initial_enemy_spawner];
  var_6 += var_5;
  return var_6;
}

function ref_14273() {
  var_0 = self;

  if(isDefined(var_0.ref_12945) || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  var_0.ref_12945 = spawnStruct();
  var_0.ref_12945.starttime = gettime();
  var_0.ref_12945.ref_13842 = ref_14244(var_0);
}

function ref_1425b() {
  var_0 = self;

  if(!isDefined(var_0.ref_12945) || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  var_1 = ref_14244(var_0);
  var_2 = var_1 - var_0.ref_12945.ref_13842;
  var_3 = var_0.path;

  if(var_3.ref_119d6 < var_2) {
    var_3.ref_119d6 = var_2;
  }

  var_4 = gettime() - var_0.ref_12945.starttime;
  var_3.ref_13bf5 += var_4;
  var_0.ref_12945 = undefined;
}

function ref_1422c() {
  foreach(var_1 in self.obj_payload_stage.touchlist[game["attackers"]]) {
    var_2 = var_1.player;
    var_2 scripts\mp\utility\stats::incpersstat("objTime", 1);
    var_2 scripts\mp\persistence::statsetchild("round", "objTime", var_2.pers["objTime"]);
    var_2 scripts\mp\gametypes\br_public::updatebrscoreboardstat("objTime", var_2.pers["objTime"]);
  }

  foreach(var_1 in self.obj_payload_stage.touchlist[game["defenders"]]) {
    var_2 = var_1.player;
    var_2 scripts\mp\utility\stats::incpersstat("objTime", 1);
    var_2 scripts\mp\gametypes\br_public::updatebrscoreboardstat("objTime", var_2.pers["objTime"]);
  }
}

function freight_lift_build(var_0, var_1) {
  var_2 = 1.57828e-05;
  var_3 = 3600;
  var_4 = 10;
  var_5 = distance(var_0, var_1);
  var_6 = var_5 * var_2;
  var_7 = max(var_6 / level.disable_super_in_turret.ref_14242 * var_3, var_4);
  return var_7;
}

function freeze_timer_at_max_time_bomb_vest(var_0, var_1) {
  var_0.ref_136fc = [];
  var_0.getquestreward_checkforvalueoverride = [];
  var_0.ref_11f9e = [];
  var_0.initial_enemy_spawner = 0;
  var_0.ref_136fb = 0;

  if(level.disable_super_in_turret.checkpoint_objective) {
    var_0.wait_for_at_least_one_player_spawns_in = [];
  }

  if(level.disable_super_in_turret.convoy) {
    var_0.idflags_penetration_player_only = spawnStruct();
    var_0.idflags_penetration_player_only.points = [];
    var_0.idflags_penetration_player_only.times = [];
  }

  var_2 = var_0.nodes;

  if(!isDefined(var_2) || istrue(var_1)) {
    if(isDefined(var_0.target)) {
      var_3 = var_0;
      var_2 = [var_0];

      for(;;) {
        var_3 = scripts\engine\utility::getStruct(var_3.target, "targetname");
        var_2 = var_3;

        if(!isDefined(var_3.target)) {
          break;
        }
      }

      var_0.nodes = var_2;
    }
  }

  var_9 = int(var_2.size / 31);
  var_10 = var_2.size - var_9 * 31;

  if(var_10 != 0) {
    var_9++;
  }

  var_11 = var_10 > 0 && var_10 < 4;
  var_12 = var_9 - 2;
  var_13 = var_9 - 1;
  var_14 = undefined;

  if(level.disable_super_in_turret.checkpoint_objective) {
    var_0.wait_for_at_least_one_player_spawns_in[0] = 0;
  }

  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;

  for(var_21 = 0; var_21 < var_9; var_21++) {
    var_0.ref_136fc[var_21] = spawnStruct();
    var_0.ref_136fc[var_21].points = [];
    var_0.ref_136fc[var_21].times = [];
    var_0.ref_136fc[var_21].tv_station_interior_enemy_should_break_stealth_immediately = [];
    var_0.ref_136fc[var_21].update_player_enemy_on_death = [];
    var_0.ref_136fc[var_21].armsrace_c4_planter_internal = [];
    var_22 = 31;

    if(var_21 == var_12 && var_11) {
      var_22 = 27 + var_10;
    } else if(var_21 == var_13 && var_10 > 0) {
      if(var_10 >= 4) {
        var_22 = var_10;
      } else {
        var_22 = 4;
      }
    }

    var_23 = 0;

    if(var_21 > 0) {
      var_0.ref_136fc[var_21].points[var_23] = var_2[var_16].origin;
      var_0.ref_136fc[var_21].times[var_23] = freight_lift_build(var_2[var_16].origin, var_2[var_16].origin);
      var_0.ref_136fc[var_21].armsrace_c4_planter_internal[var_23] = var_19;
      var_23++;
      var_22++;
      var_2[var_16].ref_136fb = var_21;
    } else {
      var_2[var_21].ref_136fb = var_21;
    }

    for(var_24 = var_23; var_24 < var_22; var_24++) {
      var_25 = var_24;

      if(level.disable_super_in_turret.convoy && var_21 == 0) {
        var_0.idflags_penetration_player_only.points[var_25] = var_2[var_15].origin;
        var_0.idflags_penetration_player_only.times[var_25] = freight_lift_build(var_2[var_16].origin, var_2[var_15].origin);
        var_25 -= 1;

        if(var_25 == 0) {
          var_16 = 1;
        }
      }

      if(!level.disable_super_in_turret.convoy || var_21 > 0 || var_25 >= 0) {
        var_0.ref_136fc[var_21].points[var_25] = var_2[var_15].origin;
        var_0.ref_136fc[var_21].times[var_25] = freight_lift_build(var_2[var_16].origin, var_2[var_15].origin);
        var_26 = distance(var_2[var_16].origin, var_2[var_15].origin);
        var_19 += var_26;
        var_0.ref_136fc[var_21].armsrace_c4_planter_internal[var_25] = var_19;

        if(isDefined(var_2[var_15].checkpoint)) {
          var_0.ref_136fc[var_21].tv_station_interior_enemy_should_break_stealth_immediately[var_25] = var_17;
          var_0.getquestreward_checkforvalueoverride[var_17] = spawnStruct();
          var_0.getquestreward_checkforvalueoverride[var_17].loot_choppers = var_19;
          var_0.getquestreward_checkforvalueoverride[var_17].ref_11ea5 = var_15;
          var_2[var_15].checkpoint = var_0.getquestreward_checkforvalueoverride[var_17];

          if(level.disable_super_in_turret.checkpoint_objective) {
            var_27 = var_15 - var_20;
            var_28 = int(var_27 * 0.33) + var_20;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_28;
            var_29 = int(var_27 * 0.66) + var_20;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_29;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_15;
            var_20 = var_15;
          }

          var_17++;
        }

        if(isDefined(var_2[var_15].obstacle)) {
          var_0.ref_136fc[var_21].update_player_enemy_on_death[var_25] = var_18;

          if(!isent(var_2[var_15].obstacle)) {
            var_2[var_15].obstacle = init_structs(var_2[var_15].obstacle.origin, var_2[var_15].obstacle.angles);
          }

          var_0.ref_11f9e[var_18] = var_2[var_15].obstacle;
          var_0.ref_11f9e[var_18].path = var_0;
          var_0.ref_11f9e[var_18].dist = var_19;
          var_0.ref_11f9e[var_18].index = var_18;
          var_0.ref_11f9e[var_18].getquestplunderrewardinstance = var_17;
          var_18++;
        }

        var_16 = var_15;
      }

      var_15++;
    }
  }

  var_30 = var_15 - 1;

  if(level.disable_super_in_turret.checkpoint_objective) {
    var_27 = var_15 - var_20;
    var_28 = int(var_27 * 0.33) + var_20;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_28;
    var_29 = int(var_27 * 0.66) + var_20;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_29;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_30;
  }

  var_0.getquestreward_checkforvalueoverride[var_17] = spawnStruct();
  var_0.getquestreward_checkforvalueoverride[var_17].loot_choppers = var_19;
  var_0.getquestreward_checkforvalueoverride[var_17].ref_11ea5 = var_30;
  var_0.ref_13bf1 = var_19;
}

function ref_1422f(var_0, var_1) {
  self notify("vehicleBeginPath");
  self endon("vehicleBeginPath");
  self endon("death");
  var_2 = 1;
  self.carriable_explode = 1;
  self.tutonplayerkilled = undefined;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_0.initial_enemy_spawner = 0;
  var_0.ref_136fb = var_1;

  foreach(var_4 in var_0.ref_11f9e) {
    ref_11f9c(var_4, 0);
  }

  thread ref_14251();
  thread ref_1423a();
  thread ref_14234();
  var_6 = 1;

  while(var_0.ref_136fb < var_0.ref_136fc.size) {
    self startpathnodes(var_0.ref_136fc[var_0.ref_136fb].points, var_0.ref_136fc[var_0.ref_136fb].times, 0, 0.5, 0.5, 0, 0, var_2, 1, !var_6, 1, 1);
    var_2 = 0;
    var_6 = ref_14275(var_0, var_6);

    if(unset_relic_gas_martyr()) {
      break;
    }
  }

  self vehicle_setspeed(0);

  if(isDefined(var_0.idle_sfx)) {
    var_0.idle_sfx vehicle_setspeed(0);
  }

  self notify("pathComplete");
  var_0.hidesmokinggunhudfromplayer = 1;
  var_0 notify("pathComplete");

  if(level.disable_super_in_turret.ref_13601) {
    var_0.ref_13620.hidesmokinggunhudfromplayer = 1;
  }

  ref_1425b();
  loadoutexecutionquip(var_0);

  if(!unset_relic_gas_martyr() && ref_132fd(var_0)) {
    ref_12aa3(var_0);
    var_0.getquestplunderrewardinstance++;
    start_pipe_room_menu();

    if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
      var_7 = relic_amped_monitor();

      foreach(var_9 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo) {
        var_9 setvalue(var_7);
      }
    }

    var_0 notify("checkPointUpdate");
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();
    getquestrewardgroupstablerewards();
    return;
  }

  if(!unset_relic_gas_martyr() && level.disable_super_in_turret.brking_oncrateuse) {
    player_death(var_0);
    return;
  }
}

function player_death(var_0) {
  scripts\mp\gametypes\br::ref_13ac7("br_payload_all_to_end", undefined, game["attackers"]);
  scripts\mp\gametypes\br::ref_13ac7("br_payload_all_to_end_enemy", undefined, game["defenders"]);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.vehicle.obj_payload_stage.objidnum);
  ref_12206(var_0, game["attackers"], "white");
  ref_12206(var_0, game["defenders"], "white");
  var_1 = relic_amped_last_kill_time(var_0);
  thread ref_11f92(var_0, 1, "checkpoint", var_1 + 1);
  ref_12aa3(var_0);
  var_0.getquestplunderrewardinstance++;
  start_pipe_room_menu();
  ref_1322f(var_0);
  ref_1326a(var_0, var_0.getquestplunderrewardinstance);
  var_0 notify("checkPointUpdate");

  if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
    var_2 = relic_amped_monitor();

    foreach(var_4 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo) {
      var_4 setvalue(var_2);
    }
  }

  thread ref_12cb8(var_0);

  if(level.disable_super_in_turret.ref_121fc) {
    thread ref_121fc(var_0);
    return;
  }
}

function ref_14236(var_0, var_1) {
  self notify("vehicleBeginPath");
  self endon("vehicleBeginPath");
  var_0 endon("pathComplete");
  self endon("death");
  var_2 = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.initial_enemy_spawner = 0;
  self.ref_136fb = var_1;
  thread ref_1423a();
  var_3 = 1;

  while(self.ref_136fb < var_0.ref_136fc.size) {
    if(self.ref_136fb == 0) {
      var_4 = var_0.idflags_penetration_player_only.points;
      var_5 = var_0.idflags_penetration_player_only.times;
    } else {
      var_4 = var_0.ref_136fc[self.ref_136fb].points;
      var_5 = var_0.ref_136fc[self.ref_136fb].times;
    }

    self startpathnodes(var_4, var_5, 0, 0.5, 0.5, 0, 0, var_2, 1, !var_3, 1, 1);
    var_2 = 0;
    var_3 = ref_14237(var_0, var_4);

    if(unset_relic_gas_martyr()) {
      break;
    }
  }

  self vehicle_setspeed(0);
}

function ref_14237(var_0, var_1) {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death");
  var_2 = var_1.size - 1;

  for(;;) {
    self waittill("trigger", var_3);
    var_4 = self.ref_136fb == 0 && var_3 == 0;
    self.initial_enemy_spawner = var_3;

    if(var_4) {
      self.carriable_fuse_light_watch = 1;
      continue;
    }

    if(var_3 <= 0) {
      self.ref_136fb--;
      self.initial_enemy_spawner = var_1.size - 2;
      return 0;
    }

    if(var_3 >= var_2) {
      self.ref_136fb++;
      self.initial_enemy_spawner = 0;
      return 1;
    }
  }
}

function ref_132fd(var_0) {
  if(level.disable_super_in_turret.brking_oncrateuse) {
    foreach(var_0 in level.disable_super_in_turret.paths) {
      if(!istrue(var_0.hidesmokinggunhudfromplayer)) {
        return false;
      }
    }
  }

  return true;
}

function ref_14275(var_0, var_1) {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death");
  var_2 = var_0.ref_136fc[var_0.ref_136fb];
  var_3 = var_2.points.size - 1;

  if(var_1) {
    var_4 = 0;
  } else {
    var_4 = var_4;
  }

  var_5 = var_2;

  for(;;) {
    self waittill("trigger", var_6);
    var_7 = var_1.ref_136fb == 0 && var_6 == 0;

    if(!var_7 && var_6 == var_1.initial_enemy_spawner) {
      var_5 = !var_5;
      var_1.initial_enemy_spawner = var_6 - 1;
    } else {
      var_5 = var_7 || var_6 > var_1.initial_enemy_spawner;
      var_1.initial_enemy_spawner = var_6;
    }

    if(isDefined(var_3.update_player_enemy_on_death[var_6])) {
      var_8 = var_3.update_player_enemy_on_death[var_6];
      var_9 = var_1.ref_11f9e[var_8];

      if(istrue(var_9.hostdefensefactormod) && var_5) {
        self.tutonplayerkilled = var_9;
        self.cone = var_3.points[var_6];
      } else if(!istrue(var_9.hostdefensefactormod) && var_5) {
        ref_11f9b(var_9);
      } else if(!istrue(var_9.hostdefensefactormod) && !var_5) {
        ref_11f9c(var_9, 1);
      }
    }

    if(var_7 || isDefined(var_3.tv_station_interior_enemy_should_break_stealth_immediately[var_6]) && var_6 < var_4) {
      self.carriable_explode = 1;

      if(var_6 > var_4 && isDefined(var_3.tv_station_interior_enemy_should_break_stealth_immediately[var_6])) {
        level thread scripts\mp\gametypes\br_quest_util::ref_140b1(self.origin, "dom");
        ref_11e6f(var_3.tv_station_interior_enemy_should_break_stealth_immediately[var_6], var_1);
      }
    } else if(var_6 <= 0) {
      var_1.ref_136fb--;
      var_1.initial_enemy_spawner = var_1.ref_136fc[var_1.ref_136fb].points.size - 2;
      return 0;
    } else if(var_6 >= var_4) {
      var_1.ref_136fb++;
      var_1.initial_enemy_spawner = 0;
      return 1;
    }

    var_4 = var_6;
  }
}

function ref_14245(var_0) {
  if(!isDefined(self.obj_payload_stage)) {
    return 0;
  }

  return self.obj_payload_stage.numtouching[var_0];
}

function ref_125f2(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(isDefined(var_2.trigger) && var_0 istouching(var_2.trigger)) {
      return true;
    }
  }

  return false;
}

function ref_13c54() {
  level endon("game_ended");
  level notify("trackPlayersPerPath");
  level endon("trackPlayersPerPath");

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_1.numplayers = [];
  }

  var_3 = game["attackers"];

  for(;;) {
    foreach(var_1 in level.disable_super_in_turret.paths) {
      var_1.numplayers[var_3] = 0;
    }

    foreach(var_7 in level.players) {
      if(!isDefined(var_7) || !isalive(var_7) || var_7.team != var_3) {
        continue;
      }

      var_8 = ref_12575(var_7);
      var_9 = ref_12576(var_7);

      if(isDefined(var_8) && var_9 > gettime()) {
        var_8.numplayers[var_3]++;
        continue;
      }

      var_10 = ref_1255a(var_7);

      if(isDefined(var_10)) {
        var_10.numplayers[var_3]++;
        ref_12689(var_7, var_10);
        ref_12679(var_7);
      }
    }

    var_3 = relic_squadlink_outline_monitor(var_3);
    waitframe();
  }
}

function ref_1255a() {
  var_0 = undefined;
  var_1 = undefined;

  if(!isDefined(self.heli_landing_volumes) || self.heli_landing_volumes.size == 0) {
    return;
  }

  foreach(var_3 in level.disable_super_in_turret.paths) {
    var_4 = self.heli_landing_volumes[var_3.label];
    var_5 = var_3.nodes[var_4];
    var_6 = distance2dsquared(var_5.origin, self.origin);
    var_7 = var_4;
    var_8 = var_6;
    var_9 = var_6;

    for(var_10 = var_4 + 1; var_10 < var_3.nodes.size; var_10++) {
      var_11 = var_3.nodes[var_10];
      var_12 = distance2dsquared(var_11.origin, self.origin);

      if(var_12 < var_8) {
        var_7 = var_10;
        var_8 = var_12;
      }

      if(var_12 > var_9) {
        break;
      }

      var_9 = var_12;
    }

    for(var_10 = var_4 - 1; var_10 >= 0; var_10--) {
      var_11 = var_3.nodes[var_10];
      var_12 = distance2dsquared(var_11.origin, self.origin);

      if(var_12 < var_8) {
        var_7 = var_10;
        var_8 = var_12;
      }

      if(var_12 > var_9) {
        break;
      }

      var_9 = var_12;
    }

    self.heli_landing_volumes[var_3.label] = var_7;

    if(!isDefined(var_0) || var_8 < var_1) {
      var_0 = var_3;
      var_1 = var_8;
    }
  }

  return var_0;
}

function ref_12679() {
  var_0 = 3500;

  if(getdvarint("scr_br_payload_oob_far", 0) == 0) {
    return;
  }

  if(!scripts\mp\flags::gameflag("infil_complete")) {
    return;
  }

  var_1 = ref_12575();
  var_2 = self.heli_landing_volumes[var_1.label];
  var_3 = var_1.nodes[var_2];
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(var_2 + 1 >= var_1.nodes.size) {
    var_6 = var_2 - 1;
    var_4 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_6].origin, self.origin);
  } else if(var_2 - 1 < 0) {
    var_6 = var_2 + 1;
    var_4 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_6].origin, self.origin);
  } else {
    var_7 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_2 + 1].origin, self.origin);
    var_8 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_2 - 1].origin, self.origin);
    var_9 = distance2dsquared(self.origin, var_7);
    var_10 = distance2dsquared(self.origin, var_8);

    if(var_10 < var_9) {
      var_4 = var_8;
      var_5 = var_10;
      var_6 = var_2 - 1;
    } else {
      var_4 = var_7;
      var_5 = var_9;
      var_6 = var_2 + 1;
    }
  }

  if(!isDefined(var_5)) {
    var_5 = distance2dsquared(self.origin, var_4);
  }

  var_11 = getdvarint("scr_br_payload_max_dist_away", var_0);
  var_12 = var_11 * var_11;
  var_13 = 0;

  if(var_5 > var_12) {
    var_13 = 1;
  }

  if(var_13 && !isDefined(self.ref_12268)) {
    var_14 = relic_squadlink_outline_monitor(self.team);
    self.ref_12268 = scripts\mp\utility\outline::outlineenableforteam(self, var_14, "outline_nodepth_red", "level_script");
    return;
  }

  if(!var_13 && isDefined(self.ref_12268)) {
    scripts\mp\utility\outline::outlinedisable(self.ref_12268, self);
    self.ref_12268 = undefined;
    return;
  }
}

function ref_12559() {
  self endon("endOOBFar");
  self endon("disconnect");
  self waittill("death");
  self.ref_12268 = undefined;
}

function thankyou_photo() {
  if(!istrue(level.disable_super_in_turret.set_force_aitype_sniper)) {
    return;
  }

  switch (level.mapname) {
    case "mp_br_mechanics":
      scripts\mp\gametypes\br_payload_spawns_mp_br_mechanics::initspawns();
      break;
    case "mp_don4":
      scripts\mp\gametypes\br_payload_spawns_mp_don4::initspawns();
      break;
    case "mp_escape4":
      scripts\mp\gametypes\br_payload_spawns_mp_escape4::initspawns();
      break;
  }

  if(level.disable_super_in_turret.ref_13695[game["attackers"]].size == 0 || level.disable_super_in_turret.ref_13695[game["defenders"]].size == 0) {
    level.disable_super_in_turret.set_force_aitype_sniper = 0;
  }

  if(level.disable_super_in_turret.set_force_aitype_sniper) {
    ref_1326f(game["attackers"]);
    ref_1326f(game["defenders"]);
    return;
  }
}

function play_spotrep_capture_sfx(var_0) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_1 = var_0.radius + 50;
  var_2 = anglesToForward(var_0.angles);
  var_0.playergetplunderomnvarbitpackinginfo = var_0.origin + var_2 * var_1;
}

function ref_1326f(var_0) {
  var_1 = level.disable_super_in_turret.ref_13695[var_0];

  if(isDefined(level.disable_super_in_turret.ref_13876)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.disable_super_in_turret.ref_13876[var_0]);
  }

  foreach(var_3 in var_1) {
    play_smoke_fx(var_3);
    play_spotrep_capture_sfx(var_3);
  }
}

function play_smoke_fx(var_0) {
  var_0.heli_landing_volumes = [];

  foreach(var_2 in level.disable_super_in_turret.paths) {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;

    for(var_6 = 0; var_6 < var_2.nodes.size; var_6++) {
      var_7 = var_2.nodes[var_6];
      var_8 = distance2dsquared(var_7.origin, var_0.origin);

      if(!isDefined(var_3) || var_8 < var_4) {
        var_3 = var_6;
        var_4 = var_8;
      }

      if(!isDefined(var_5)) {
        var_5 = var_8;
        continue;
      }

      if(var_8 > var_5) {
        break;
      }
    }

    var_0.heli_landing_volumes[var_2.label] = var_3;
  }
}

function ref_1452d(var_0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.teamdata[var_0]["nextRespawn"] = 0;

  if(level.teamdata[var_0]["respawnDelay"] == 0) {
    return;
  }

  for(;;) {
    level.teamdata[var_0]["nextRespawn"] = gettime() + level.teamdata[var_0]["respawnDelay"] * 1000;
    wait level.teamdata[var_0]["respawnDelay"];
  }
}

function runkilltriger(var_0, var_1) {
  if(level.teamdata[var_0]["respawnDelay"] == 0) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = level.teamdata[var_0]["nextRespawn"];
  }

  var_2 = max(var_1 - gettime(), 0);
  var_3 = int(var_2 / 1000);
  return var_3;
}

function dyn_door(var_0) {
  if(scripts\mp\flags::gameflag("prematch_done") && istrue(level.disable_super_in_turret.ref_12caa)) {
    ref_126bb();
  }

  return true;
}

function playerrespawn(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("prematch_done") || !istrue(self.br_infilstarted) || isDefined(self.cameraent)) {
    return false;
  }

  thread ref_126a4(var_0);
  return true;
}

function ref_126a4(var_0) {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("disconnect");

  if(!istrue(level.debug_safehouse_regroup_start)) {
    self.class = scripts\mp\gametypes\br::ref_1234a();
  }

  var_1 = level.teamdata[self.team]["nextRespawn"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(var_2 > 1 && !unset_relic_gas_martyr()) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, undefined, 1);
  }

  headlightright();

  if(unset_relic_gas_martyr()) {
    level waittill("forever");
  }

  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  thread ref_1253a();

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();
  ref_1255b();
  scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outline_depth_payload", "level_script");
  var_3 = !self calloutmarkerping_getEnt();
  var_4 = gettime();

  if(var_3) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_4 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
  scripts\mp\gametypes\br::ref_13f21(self);
  scripts\mp\damage::resetplayervariables();
}

function ref_1255b() {
  if(getdvarint("scr_br_payload_last_stand", 0) != 0) {
    scripts\mp\gametypes\br::scriptednode(self);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  ref_12508();
  scripts\mp\gametypes\br_public::ref_1252b();
  thread ref_126ac();
  thread ref_126ad();
  self.warroomtvs = undefined;
}

function ref_1369e(var_0) {
  self endon("disconnect");
  self notify("reset_timer");
  waitframe();
  self setclientomnvar("ui_privateevent_timer_type", 4);
  var_1 = var_0;
  var_2 = gettime() + var_1 * 1000;
  self setclientomnvar("ui_privateevent_timer", var_2);
  scripts\engine\utility::ref_143ba(var_0, "reset_timer", "death");
  self setclientomnvar("ui_privateevent_timer_type", 0);
}

function ref_126ac() {
  self endon("disconnect");

  if(!isDefined(self.warroomtvs)) {
    return;
  }

  if(getdvarint("scr_br_payload_spawn_speed", 1) == 0) {
    return;
  }

  if(isbot(self)) {
    return;
  }

  if(self.team == game["defenders"]) {
    return;
  }

  var_0 = self.warroomtvs;

  if(isPlayer(var_0) || istrue(var_0.bot_gametype_attacker_limit_for_team)) {
    return;
  }

  var_1 = var_0;

  if(get_bomb_vest_id_vfx(var_1)) {
    while(isalive(self) && !self isonground()) {
      waitframe();
    }
  }

  if(!isalive(self)) {
    return;
  }

  var_2 = 0;
  var_3 = getdvarint("scr_br_payload_spawn_speed_time", 0);

  if(var_3 == 0) {
    var_4 = getdvarint("scr_br_payload_spawn_speed_boost", 290);
    var_5 = var_1.vehicle;
    var_6 = distance(self.origin, var_5.origin);
    var_3 = var_6 / var_4 - getdvarfloat("scr_br_payload_spawn_speed_boost_adj", 5);

    if(var_3 < 0) {
      var_3 = 0;
    }
  }

  var_7 = getdvarfloat("scr_br_payload_speed_mult", 0.4);
  thread ref_1369e(var_3);
  var_8 = self.fastcrouchspeedmod;
  self.fastcrouchspeedmod = var_7;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  while(isalive(self) && var_2 < var_3) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    wait 0.1;
    var_2 += 0.1;
  }

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    ref_12e60("specialty_sprintmelee");
    ref_12e60("specialty_sprintads");
    ref_12e60("specialty_marathon");
  }

  self.fastcrouchspeedmod = var_8;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("default_2seconds");
}

function ref_12e60(var_0) {
  if(scripts\mp\utility\perk::_hasperk(var_0)) {
    scripts\mp\utility\perk::removeperk(var_0);
    return;
  }
}

function ref_12695() {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self.ref_12204;

  if(isbot(self)) {
    if(!isDefined(var_0)) {
      var_0 = respawnfade("A");
      ref_12689(var_0);
    }

    return var_0;
  }

  if(getdvarint("debug_gsc_spawn_choice_enabled", 0) == 1) {
    var_1 = scripts\mp\hud_util::createicon("progress_bar_fill", 400, 35);
    var_1.sort = 0;
    var_1.color = relic_doubletap_helper("lightblue");
    var_1.archived = 0;
    var_1.alpha = 0.5;
    var_2 = [];
    var_3 = respawnfade("A");
    var_4 = undefined;
    var_5 = undefined;

    if(isDefined(var_3)) {
      var_4 = scripts\mp\hud_util::createfontstring("default", 2);
      var_4.archived = 0;
      var_4.label = &"BR_PAYLOAD/SPAWN_A";
      var_4.path = var_3;
      thread spawndogtagtoken(var_4, self);

      if(isDefined(var_0) && !isPlayer(var_0) && var_3 == var_0) {
        var_1.getteamtokenshud = var_4;
      }

      var_2 = var_4;

      if(level.disable_super_in_turret.ref_13601 && self.team == game["attackers"]) {
        var_5 = scripts\mp\hud_util::createfontstring("default", 2);
        var_5.archived = 0;
        var_5.label = &"BR_PAYLOAD/SPAWN_B_AIR";
        var_5.path = var_3.ref_13620;

        if(isDefined(var_0) && !isPlayer(var_0) && var_3.ref_13620 == var_0) {
          var_1.getteamtokenshud = var_5;
        }

        var_2 = var_5;
      }
    }

    var_6 = respawnfade("B");
    var_7 = undefined;
    var_8 = undefined;

    if(isDefined(var_6)) {
      var_7 = scripts\mp\hud_util::createfontstring("default", 2);
      var_7.archived = 0;
      var_7.label = &"BR_PAYLOAD/SPAWN_B";
      var_7.path = var_6;
      thread spawndogtagtoken(var_7, self);

      if(isDefined(var_0) && !isPlayer(var_0) && var_6 == var_0) {
        var_1.getteamtokenshud = var_7;
      }

      var_2 = var_7;

      if(level.disable_super_in_turret.ref_13601 && self.team == game["attackers"]) {
        var_8 = scripts\mp\hud_util::createfontstring("default", 2);
        var_8.archived = 0;
        var_8.label = &"BR_PAYLOAD/SPAWN_B_AIR";
        var_8.path = var_6.ref_13620;

        if(isDefined(var_0) && !isPlayer(var_0) && var_6.ref_13620 == var_0) {
          var_1.getteamtokenshud = var_8;
        }

        var_2 = var_8;
      }
    }

    var_9 = [];

    if(level.disable_super_in_turret.ref_13746) {
      var_10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

      foreach(var_12 in var_10) {
        var_13 = scripts\mp\hud_util::createfontstring("default", 1.5);
        var_13.archived = 0;
        var_13 setplayernamestring(var_12);
        var_13.player = var_12;
        var_13.ref_1284f = scripts\mp\hud_util::createfontstring("default", 1.5);
        var_13.ref_1284f.archived = 0;
        var_9 = var_13;
        LOC_0000030c:
      }
    }

    if(!isDefined(var_1.getteamtokenshud)) {
      var_1.getteamtokenshud = var_2[0];
    }

    var_15 = undefined;
    scripts\mp\utility\player::_freezecontrols(0, 1, "payload_choice");
    var_16 = 250;
    var_17 = 300;
    var_18 = undefined;
    var_19 = undefined;
    var_20 = undefined;

    while(!isDefined(var_15)) {
      var_21 = ref_134d7(var_2, var_9);
      var_22 = self getnormalizedmovement();
      var_23 = var_22[0] > 0;
      var_24 = var_22[0] < 0;

      if(isDefined(var_19)) {
        if(gettime() >= var_19 || !var_23 && !var_24) {
          var_19 = undefined;
        }
      } else if(var_23) {
        var_20 = -1;
      } else if(var_24) {
        var_20 = 1;
      }

      for(var_25 = 0; var_25 < var_21.size; var_25++) {
        var_26 = var_21[var_25];

        if(var_1.getteamtokenshud == var_26) {
          if(!isDefined(var_26.path) && !isDefined(var_26.player)) {
            var_1.getteamtokenshud = var_2[0];
            var_27 = undefined;
            var_28 = undefined;
            var_18 = undefined;
            var_20 = undefined;
          } else if(isDefined(var_20)) {
            var_29 = var_25 + var_20;

            if(var_29 < 0) {
              var_29 = var_21.size - 1;
            } else if(var_29 >= var_21.size) {
              var_29 = 0;
            }

            var_30 = var_21[var_29];
            var_1.getteamtokenshud = var_30;
            var_1 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_30.yoffset);
            var_20 = undefined;
            var_27 = undefined;
            var_28 = undefined;
            var_19 = gettime() + var_17;
          } else {
            var_1 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_26.yoffset);
          }

          break;
        }
      }

      ref_13fe1(var_2, var_9, var_1);
      ref_139d8(var_1.getteamtokenshud.path);
      var_20 = undefined;

      if(self useButtonPressed()) {
        if(isDefined(var_18) && gettime() >= var_18) {
          var_31 = var_1.getteamtokenshud;

          if(isDefined(var_31.path) && !istrue(var_31.path.hidesmokinggunhudfromplayer)) {
            var_15 = var_31.path;
          } else if(isDefined(var_31.player) && isalive(var_31.player) && !issquadmateindanger(var_31.player)) {
            var_15 = var_31.player;
          }
        } else if(!isDefined(var_18)) {
          var_18 = gettime() + var_16;
        }
      } else {
        var_18 = undefined;
      }

      waitframe();
    }

    self notify("spawnChoice");
    var_1 destroy();

    foreach(var_33 in var_2) {
      var_33 destroy();
    }

    foreach(var_36, var_33 in var_9) {
      var_33.ref_1284f destroy();
      var_33 destroy();
    }

    return var_15;
  }

  if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
    ref_13182(0);
    self notify("spawnChoice");
    return respawnfade("A");
  }

  if(istrue(level.disable_super_in_turret.ref_12caa)) {
    thread startspectatorview();
  }

  var_15 = undefined;

  while(!isDefined(var_15)) {
    var_3 = respawnfade("A");
    thread ref_13621(self, var_3);
    var_6 = respawnfade("B");
    thread ref_13621(self, var_6);
    self waittill("luinotifyserver", var_37, var_38);

    if(var_37 == "spawn_choice_path") {
      if(0 == var_38) {
        var_36 = respawnfade("A");
      } else {
        var_36 = respawnfade("B");
      }

      var_15 = var_36;
      ref_13182(0);
    } else if(var_37 == "spawn_hover_path") {
      if(0 == var_38) {
        var_36 = respawnfade("A");
      } else {
        var_36 = respawnfade("B");
      }

      thread playergulaggetrespawnpoint(var_36);
    } else if(var_37 == "spawn_choice_player") {
      var_15 = scripts\mp\playerlogic::getplayerfromclientnum(var_38);
      ref_13182(0);
    }

    if(isDefined(var_15)) {
      self notify("spawnChoice");
      return var_15;
    }
  }
}

function playergulaggetrespawnpoint(var_0) {
  self notify("followTrackCamThink");
  self endon("followTrackCamThink");
  self endon("spawnChoice");

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\mp\gametypes\br::get_int_or_0(self.playergulagvictorysetcontrols) - gettime();

  if(var_1 > 0) {
    wait var_1;
  }

  self.playergulagvictorysetcontrols = gettime() + 250;
  ref_139d8(var_0);
}

function ref_134d7(var_0, var_1) {
  var_2 = -60;
  var_3 = 30;
  var_4 = var_2;
  var_5 = [];

  foreach(var_7 in var_0) {
    var_7 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_4);
    var_5 = var_7;
    var_4 += var_3;

    foreach(var_9 in var_1) {
      if(!isDefined(var_9.player)) {
        continue;
      }

      var_10 = ref_12575(var_9.player);

      if(var_10 == var_7.path) {
        var_9 scripts\mp\hud_util::setpoint("LEFT", "CENTER", 0, var_4);
        var_9.ref_1284f scripts\mp\hud_util::setpoint("RIGHT", "CENTER", 0, var_4);
        var_5 = var_9;
        var_4 += var_3;
      }
    }
  }

  return var_5;
}

function ref_13fe1(var_0, var_1, var_2) {
  var_3 = -60;
  var_4 = 30;
  var_5 = 0;

  foreach(var_7 in var_1) {
    if(!isDefined(var_7.player)) {
      var_7.alpha = 0;
      var_7.ref_1284f.alpha = 0;
      continue;
    }

    if(!isalive(var_7.player)) {
      var_7.color = (1, 0, 0);
      var_7.ref_1284f.color = (1, 0, 0);
      var_7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_DEAD";
      continue;
    }

    if(issquadmateindanger(var_7.player)) {
      var_7.color = (1, 0, 0);
      var_7.ref_1284f.color = (1, 0, 0);
      var_7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_COMBAT";
      continue;
    }

    var_7.color = (0, 1, 1);
    var_7.ref_1284f.color = (1, 1, 1);

    if(var_2.getteamtokenshud == var_7) {
      var_7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_VALID_HOLD";
      var_5 = 1;
      continue;
    }

    var_7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_VALID";
  }

  foreach(var_10 in var_0) {
    var_11 = !istrue(var_10.path.hidesmokinggunhudfromplayer);

    if(!var_11) {
      var_10.color = (1, 0, 0);
    }

    if(istrue(var_10.path.bot_gametype_attacker_limit_for_team) && var_10.path.path.label == "A") {
      if(var_2.getteamtokenshud == var_10 && var_11) {
        var_10.label = &"BR_PAYLOAD/SPAWN_A_AIR_HOLD";
      } else {
        var_10.label = &"BR_PAYLOAD/SPAWN_A_AIR";
      }

      continue;
    }

    if(istrue(var_10.path.bot_gametype_attacker_limit_for_team) && var_10.path.path.label == "B") {
      if(var_2.getteamtokenshud == var_10 && var_11) {
        var_10.label = &"BR_PAYLOAD/SPAWN_B_AIR_HOLD";
      } else {
        var_10.label = &"BR_PAYLOAD/SPAWN_B_AIR";
      }

      continue;
    }

    if(var_10.path.label == "A") {
      if(var_2.getteamtokenshud == var_10 && var_11) {
        var_10.label = &"BR_PAYLOAD/SPAWN_A_HOLD";
      } else {
        var_10.label = &"BR_PAYLOAD/SPAWN_A";
      }

      continue;
    }

    if(var_10.path.label == "B") {
      if(var_2.getteamtokenshud == var_10 && var_11) {
        var_10.label = &"BR_PAYLOAD/SPAWN_B_HOLD";
        continue;
      }

      var_10.label = &"BR_PAYLOAD/SPAWN_B";
    }
  }
}

function issquadmateindanger(var_0) {
  var_1 = 5000;
  var_2 = 3000;
  var_3 = 450;
  var_4 = 200;
  var_5 = gettime();

  if(isDefined(var_0) && isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + var_1 > var_5 || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + var_1 > var_5) {
    return true;
  }

  if(var_0 isonladder()) {
    return true;
  }

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + var_2 > var_5) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane)) {
    return true;
  }

  var_6 = var_0 getspawnbucketforplayer(var_3, var_4, 1);

  if(isDefined(var_6)) {
    return true;
  }

  if(isDefined(var_0.vehicle)) {
    return true;
  }

  if(var_0 scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  var_7 = ref_12575(var_0);

  if(isDefined(var_7)) {
    var_8 = var_7.vehicle;

    if(var_0 istouching(var_7.trigger) && var_8.status == "contested") {
      return true;
    }
  }

  if(!var_0 isonground()) {
    var_9 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_0.origin, 0, -200);

    if(var_9["fraction"] == 1) {
      return true;
    }
  }

  return false;
}

function respawnfade(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.label == var_0) {
      return var_2;
    }
  }

  return undefined;
}

function respawn_enemies(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_0 != var_2) {
      return var_2;
    }
  }

  return undefined;
}

function ref_121fc(var_0) {
  var_1 = respawn_enemies(var_0);

  if(var_1.getquestplunderrewardinstance + 1 < var_0.getquestplunderrewardinstance) {
    foreach(var_3 in level.players) {
      if(!isalive(var_3)) {
        continue;
      }

      var_4 = ref_12575(var_3);

      if(var_4 == var_0 && !isDefined(var_3.ref_12276)) {
        thread ref_125c5(var_3);
      }
    }

    return;
  }
}

function ref_125c5(var_0) {
  var_1 = level.disable_super_in_turret.ref_121fc;
  var_2 = gettime() + var_1 * 1000;
  scripts\mp\utility\lower_message::ref_1316e("br_payload_redeploy", var_2, var_1);
  wait var_1;
  ref_125c4(var_0);
}

function ref_125c4(var_0) {
  var_1 = "ui_br_open_purchase_killstreak";
  var_2 = 0;
  var_3 = "ui_br_purchase_killstreak_response";
  var_4 = 1;
  self setclientomnvar(var_3, var_4);
  self setclientomnvar(var_1, var_2);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
  var_5 = var_0;

  if(!isDefined(var_5)) {
    var_5 = ref_12695();
  }

  if(isPlayer(var_5)) {
    var_6 = ref_12575(var_5);
  } else if(istrue(var_6.bot_gametype_attacker_limit_for_team)) {
    var_6 = var_6.path;
  } else {
    var_6 = var_6;
  }

  self.warroomtvs = var_6;
  ref_12689(var_6);

  if(isDefined(self)) {
    var_7 = ref_1257c(var_6);
    self notify("_watchToAutoCloseMenu_end");
    ref_12648(var_7);
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");
    return 1;
  }

  return 0;
}

function ref_12648(var_0) {
  var_1 = self;
  level endon("payloadComplete");
  level endon("game_ended");
  var_1 endon("disconnect");
  var_2 = var_1 scripts\mp\gametypes\br_gulag::ref_1263e(var_0);
  var_3 = 1;
  scripts\mp\gametypes\br::ending_fade_in(var_0.origin[0], var_0.origin[1], level.juggheli_spawner_jammer5_3);
  self setclientomnvar("ui_br_transition_type", 2);
  var_1 playerhide();
  wait var_3;
  scripts\mp\gametypes\br_public::ref_1264c();
  var_1 scripts\mp\gametypes\br_gulag::ref_126c3(var_0.origin, var_0.angles);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "redeploy");
  waitframe();
  var_1 scripts\mp\gametypes\br_public::ref_126ed();
  var_1 scripts\mp\gametypes\br_public::ref_1252b();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "redeploy");
  var_1 playershow();
  var_1 setclientomnvar("ui_br_transition_type", 0);
  var_1 setclientomnvar("ui_show_spectateHud", -1);

  if(level.disable_super_in_turret.ref_13602 > -1) {
    thread ref_1253a();
  }

  ref_1255b();
}

function spawndogtagtoken(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("spawnChoice");
  var_0 endon("disconnect");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = -1;

  for(;;) {
    if(var_2 != var_1.numplayers[var_0.team]) {
      self setvalue(var_1.numplayers[var_0.team]);
      var_2 = var_1.numplayers[var_0.team];
      ref_1318b(var_1.script_index, var_1.numplayers[var_0.team]);
    }

    waitframe();
  }
}

function ref_13621(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("spawnChoice");
  var_0 endon("disconnect");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = -1;

  for(;;) {
    if(var_2 != var_1.numplayers[var_0.team]) {
      var_2 = var_1.numplayers[var_0.team];
      ref_1318b(var_1.script_index, var_1.numplayers[var_0.team]);
    }

    waitframe();
  }
}

function ref_1253a() {
  self endon("disconnect");
  self endon("payload_remove_spawn_protection_flying");

  while(self.sessionstate != "playing") {
    waitframe();
  }

  if(self.spawnpos[2] <= 1100) {
    thread scripts\cp_mp\parachute::startfreefall(undefined, 0, undefined, undefined, 1, 0, 1);
  } else {
    thread scripts\cp_mp\parachute::startfreefall(0, 1, undefined, undefined, 1, 0);
    self skydive_deployparachute();
  }

  if(scripts\mp\flags::gameflag("prematch_done") && level.disable_super_in_turret.ref_13604) {
    self.ref_12278 = 1;
    thread ref_126a9();
    var_0 = gettime() + level.disable_super_in_turret.ref_13604 * 1000;

    while(!self isonground() && self playerads() < 0.5 && gettime() < var_0) {
      waitframe();
    }

    self.ref_12278 = undefined;
    self notify("payload_remove_spawn_protection_flying");
    return;
  }
}

function ref_126a9() {
  self endon("death_or_disconnect");
  self endon("payload_remove_spawn_protection_flying");
  self waittill("weapon_fired");
  self.ref_12278 = undefined;
  self notify("payload_remove_spawn_protection_flying");
}

function embassy_level_init() {
  scripts\mp\gametypes\br::onspawnplayer();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br_armor::searchcirclesize(1);
    return;
  }
}

function emp_drone_should_take_damage() {
  self endon("disconnect");
  self waittill("brWaitAndSpawnClientComplete");
  self clearpredictedstreampos();
  self setclientomnvar("ui_br_transition_type", 0);

  if(!istrue(game["switchedsides"]) || scripts\mp\flags::gameflag("infil_complete")) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }
}

function emp_drone_proximity_explode(var_0, var_1) {
  var_2 = 4;
  var_3 = 3;
  var_4 = var_2 + var_3;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br::emp_drone_proximity_explode(var_0);
    return;
  }

  if(self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1);

  if(unset_relic_gas_martyr()) {
    level waittill("forever");
  }

  thread emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    var_5 = runkilltriger(self.team, var_1);
    var_6 = var_5 > 0;
    var_7 = undefined;
    var_8 = max(var_5 - var_4, 0);

    if(var_6) {
      var_7 = var_5 * 1000;
      var_9 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

      if(var_9 == 1) {
        self setclientomnvar("ui_show_spectateHud", self getentitynumber());
        scripts\mp\gametypes\br_spectate::ref_1252a();
        scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
        scripts\mp\spectating::setdisabled();
        scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_7));
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_7));
      wait var_8;
    }

    var_10 = gettime();
    var_11 = ref_12695();

    if(isPlayer(var_11)) {
      var_12 = ref_12575(var_11);
      var_11 thread scripts\mp\rank::giverankxp("br_payload_squadmate_redeploy", 20);
      var_11 thread scripts\mp\rank::scoreeventpopup("br_payload_squadmate_redeploy");
    } else if(istrue(var_12.bot_gametype_attacker_limit_for_team)) {
      var_12 = var_12.path;
    } else {
      var_12 = var_12;
    }

    if(istrue(var_12.hidesmokinggunhudfromplayer)) {
      var_12 = respawn_enemies(var_12);
      var_12 = var_12;

      if(istrue(var_12.hidesmokinggunhudfromplayer)) {
        level waittill("forever");
      }
    }

    self.warroomtvs = var_12;
    ref_12689(var_12);
    var_13 = (gettime() - var_12) / 1000;
    ref_126bc(var_12, var_11, var_13, var_7, var_8, var_10);
  } else {
    self.thrust_fx_model = undefined;
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

function ref_126bc(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("payloadComplete");
  level endon("game_ended");
  self notify("playerStreamRespawn");
  self endon("playerStreamRespawn");
  self.ref_12276 = 1;
  self.ref_1286f = ref_1257c(var_0);

  if(isDefined(self.ref_1286f)) {
    self.ref_1286f.index = -1;
  }

  var_6 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
  var_7 = self.ref_1286f.origin;
  scripts\mp\gametypes\br_public::ref_126b9(var_7, var_6, 1, 0, var_5);
  var_8 = 1;
  var_9 = 0.25;
  var_10 = var_8 - var_9;
  thread scripts\mp\gametypes\br_gulag::fadeoutin(var_8);
  wait var_10;
  scripts\mp\gametypes\br_spectate::ref_1252a();
  scripts\mp\gametypes\br::spawnintermission(var_7, self.ref_1286f.angles);
  scripts\mp\spectating::setdisabled();

  if(getdvarint("scr_br_alt_mode_mini", 0) == 0) {
    scripts\mp\gametypes\br::ending_fade_in(var_7[0], var_7[1], level.juggheli_spawner_jammer5_3);
  }

  self setclientomnvar("ui_br_transition_type", 2);
  wait var_9;

  if(var_4) {
    var_11 = max(var_3 - var_1 - var_2 - var_8, 0);
    wait var_11;

    if(self.ref_12276 > 1) {
      scripts\mp\gametypes\br_public::ref_126ed();
    } else {
      scripts\mp\gametypes\br_public::ref_1252b();
    }
  } else {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  self setclientomnvar("ui_show_spectateHud", -1);
  self.ref_12276 = undefined;
}

function ref_12006() {
  if(istrue(game["switchedsides"]) || scripts\mp\flags::gameflag("infil_complete")) {
    var_0 = round_enemies_push_logic(self.team, self.squadindex);
    var_1 = level.disable_super_in_turret.paths[var_0];
    ref_12689(var_1);
    self.ref_13689 = ref_1257c(var_1);
    return self.ref_13689;
  }
}

function get_bomb_vest_id_vfx(var_0) {
  if(level.disable_super_in_turret.ref_13602 < 0) {
    return false;
  }

  if(!isDefined(var_0.getquestplunderrewardinstance)) {
    return true;
  }

  return var_0.getquestplunderrewardinstance <= level.disable_super_in_turret.ref_13602;
}

function ref_1257c(var_0) {
  var_1 = var_0;

  if(isPlayer(var_0)) {
    var_1 = ref_12575(var_0);
  } else if(istrue(var_0.bot_gametype_attacker_limit_for_team)) {
    var_1 = var_0.path;
  }

  var_2 = self.team == game["attackers"] && get_bomb_vest_id_vfx(var_1) || istrue(var_0.bot_gametype_attacker_limit_for_team);

  if(level.disable_super_in_turret.set_force_aitype_sniper && !var_2) {
    if(isPlayer(var_0)) {
      ref_1252e(var_0);
      var_3 = ref_1256c(var_0, var_0.origin, var_0.angles);
      var_4 = var_3[0];
      var_5 = var_3[1];
      var_3 = undefined;
    } else {
      var_4 = ref_1256a(var_2);
    }

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  var_6 = var_2.ref_136fc[var_2.ref_136fb].points[var_2.initial_enemy_spawner];

  if(var_4) {
    var_7 = ref_1257f(var_2);
    var_8 = var_7[0];
    var_9 = var_7[1];
    var_7 = undefined;
  } else {
    jumpiffalse(level.disable_super_in_turret.ref_129cb) LOC_0000011d;
    var_10 = ref_12578(var_6);
    var_8 = var_10[0];
    var_9 = var_10[1];
    var_10 = undefined;
    goto LOC_000001e3;
  }

  LOC_000001e3:
    if(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_11, 0)) {
      var_11 = scripts\mp\gametypes\br_c130::ref_1342e(var_9, var_11);
      var_20 = vectorNormalize(var_9 - var_11);
      var_11 += var_20 * 100;
    }

  if(level.disable_super_in_turret.start_drones_event) {
    var_21 = physics_createcontents(["physicscontents_playertrigger"]);
    var_22 = scripts\engine\trace::ray_trace_ents(var_11, var_9, [var_9.start_drones_event], var_21);

    if(var_22["fraction"] < 1) {
      var_11 = var_22["position"];
    }
  }

  var_11 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_11);
  var_16 = vectortoangles(var_9 - var_11);
  var_4 = spawnStruct();
  var_4.origin = var_11 + (0, 0, var_12);
  var_4.angles = var_16;
  var_4.height = var_12;
  return var_4;
}

function ref_1257f(var_0) {
  var_1 = 21;
  var_2 = 11;
  var_3 = 50;
  var_4 = isDefined(level.disable_super_in_turret.ref_13876) && isDefined(self.cameraent);
  var_5 = var_2;

  if(var_4) {
    var_5 = var_1;
  }

  var_6 = ref_1256a(var_0, 1, var_5);
  var_7 = var_0.spawncount[self.team];
  var_8 = var_7 % 2 == 0;
  var_9 = int(var_7 / 2);
  var_10 = var_9 * var_3;
  var_11 = var_6.origin;

  if(var_8) {
    var_12 = anglestoright(var_6.angles);
    var_11 = var_6.origin + var_12 * var_10;
  } else {
    var_13 = anglestoleft(var_6.angles);
    var_11 = var_6.origin + var_13 * var_10;
  }

  return [(var_11[0], var_11[1], 0), level.disable_super_in_turret.ref_1365f];
}

function ref_12578(var_0) {
  var_1 = 20;
  var_2 = 1;
  var_3 = getdvarfloat("scr_br_payload_spawn_degrees", var_1);
  var_4 = getdvarfloat("scr_br_payload_spawn_degrees", var_2);
  var_5 = var_0.ref_136fc[var_0.ref_136fb].points[var_0.initial_enemy_spawner];

  if(!isDefined(var_0.ref_13603) || var_0.ref_13603 != var_0.initial_enemy_spawner) {
    var_6 = var_0.ref_136fc[var_0.ref_136fb].points[var_0.initial_enemy_spawner + 1];
    var_7 = vectorNormalize(var_6 - var_5);
    var_0.ref_13603 = var_0.initial_enemy_spawner;
    var_0.ref_136b6 = vectortoyaw(var_7);
    var_0.ref_136b5 = vectortoyaw(-1 * var_7);
    var_0.ref_136b8 = -1 * var_3;
    var_0.ref_136b7 = -1 * var_3;
  }

  if(self.team == game["defenders"]) {
    var_8 = level.disable_super_in_turret.ref_13633;
    var_9 = level.disable_super_in_turret.ref_13660;
    var_10 = level.disable_super_in_turret.ref_1368f;
    var_11 = var_0.ref_136b6 + var_0.ref_136b8;
    var_0.ref_136b8 += var_4;

    if(var_0.ref_136b8 > var_3) {
      var_0.ref_136b8 = -1 * var_3;
    }
  } else {
    var_8 = level.disable_super_in_turret.ref_13632;
    var_9 = level.disable_super_in_turret.ref_1365f;
    var_10 = level.disable_super_in_turret.ref_1368e;
    var_11 = var_4.ref_136b5 + var_4.ref_136b7;
    var_4.ref_136b7 += var_10;

    if(var_4.ref_136b7 > var_9) {
      var_4.ref_136b7 = -1 * var_9;
    }
  }

  var_12 = var_11[0] + var_8 * cos(var_11);
  var_13 = var_11[1] + var_8 * sin(var_11);
  return [(var_12, var_13, 0), var_9];
}

function ref_1256a(var_0, var_1, var_2) {
  var_3 = self.team;
  var_4 = isDefined(level.disable_super_in_turret.ref_13876) && isDefined(self.cameraent);

  if(isDefined(var_0.getquestplunderrewardinstance)) {
    var_5 = var_0.getquestplunderrewardinstance;
  } else {
    var_5 = 0;
  }

  var_6 = var_1.initchallengeandeventglobals;

  if(!isDefined(var_1.ref_13695[var_4]) || var_5 != var_1.ref_1361e[var_4] || !var_5 && istrue(var_1.ref_13874)) {
    if(var_5) {
      var_1.ref_13695[var_4] = scripts\engine\utility::array_randomize(remove_dko_spawnflags(var_4, var_6));
      var_1.ref_13874 = 1;
    } else {
      var_1.ref_13695[var_4] = scripts\engine\utility::array_randomize(remove_crusader_class(var_4, var_6, var_5));
      var_1.ref_13874 = 0;
    }

    if(var_1.ref_13695[var_4].size == 0) {
      iprintlnbold("Spawns not setup for this path");
      return;
    }

    var_1.ref_13663[var_4] = randomint(var_1.ref_13695[var_4].size);
    var_1.spawncount[var_4] = 0;
    var_1.spawntime[var_4] = gettime();
    var_1.ref_1361e[var_4] = var_5;
  }

  if(var_1.ref_13695[var_4].size == 0) {
    iprintlnbold("Spawns not setup for this path");
    return;
  }

  var_7 = var_1.ref_13663[var_4];
  var_8 = var_1.ref_13695[var_4][var_7];

  if(!isDefined(var_3)) {
    var_3 = level.disable_super_in_turret.set_force_aitype_shotgun;

    if(isDefined(var_8.radius) && var_8.radius < 200) {
      var_3 /= 2;
    }
  }

  if(var_1.spawntime[var_4] + 3000 < gettime() || var_1.spawncount[var_4] >= var_3) {
    var_1.spawncount[var_4] = 0;
    var_1.ref_13663[var_4]++;

    if(var_1.ref_13663[var_4] >= var_1.ref_13695[var_4].size) {
      var_1.ref_13663[var_4] = 0;
    }

    var_7 = var_1.ref_13663[var_4];
    var_8 = var_1.ref_13695[var_4][var_7];
  }

  if(!isDefined(var_8.angles)) {
    var_8.angles = (0, 0, 0);
  }

  ref_1252e(var_8);

  if(istrue(var_2)) {
    var_1.spawntime[var_4] = gettime();
    var_1.spawncount[var_4] += 1;
    return var_8;
  }

  var_9 = ref_1256c(var_8.origin, var_8.angles, var_1.spawncount[var_4]);
  var_10 = var_9[0];
  var_11 = var_9[1];
  var_9 = undefined;
  var_12 = var_8.playergetplunderomnvarbitpackinginfo - var_10.origin;
  var_10.angles = vectortoangles(var_12);
  var_1.spawntime[var_4] = gettime();
  var_1.spawncount[var_4] = var_11 + 1;
  return var_10;
}

function ref_1256c(var_0, var_1, var_2, var_3) {
  var_4 = 32;
  var_5 = 8;
  var_6 = 50;
  var_7 = 20;
  var_8 = 5;
  var_9 = -200;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_10 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_11 = isscriptabledefined() && getdvarint("scr_br_payload_spawn_navmesh", 1);
  var_12 = 0;
  var_13 = 0;
  var_14 = var_2;

  for(;;) {
    var_15 = remove_closest_chopper_boss_vandalize_node_down(var_0, var_1[1], var_14);

    if(var_11 && !ispointonnavmesh(var_15)) {
      var_15 = getclosestpointonnavmesh(var_15);
    }

    var_16 = var_15 + (0, 0, var_7);
    var_17 = var_15 + (0, 0, var_9);
    var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
    var_12++;

    if(var_18["fraction"] == 0) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_16 = var_15 + (0, 0, var_6);
      var_17 = var_15 + (0, 0, var_9);
      var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
      var_12++;
    }

    if(var_18["fraction"] == 0) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_16 = var_15 + (0, 0, var_8);
      var_17 = var_15 + (0, 0, var_9);
      var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
      var_12++;
    }

    if(var_18["fraction"] > 0 && var_18["fraction"] != 1) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_19 = var_0 + (0, 0, 60);
      var_20 = var_18["position"] + (0, 0, 60);
      var_21 = scripts\engine\trace::ray_trace(var_19, var_20, self, var_10);
      var_12++;

      if(var_21["fraction"] != 1) {
        if(!istrue(var_3) && var_12 >= var_5) {
          var_12 = 0;
          waitframe();
        }

        var_19 = var_0 + (0, 0, 25);
        var_20 = var_18["position"] + (0, 0, 60);
        var_21 = scripts\engine\trace::ray_trace(var_19, var_20, self, var_10);
        var_12++;
      }

      if(var_21["fraction"] == 1) {
        var_22 = spawnStruct();
        var_22.origin = var_18["position"];
        var_22.angles = var_1;
        var_22.height = 0;
        return [var_22, var_14];
      }
    }

    var_15++;
    var_14++;

    if(var_14 >= var_5) {
      var_16 = var_1;

      if(var_12 && !ispointonnavmesh(var_16)) {
        var_16 = getclosestpointonnavmesh(var_16);
      }

      var_22 = spawnStruct();
      var_22.origin = var_16;
      var_22.angles = var_2;
      var_22.height = 0;
      return [var_22, var_3];
    }

    if(!istrue(var_5) && var_14 >= var_7) {
      var_14 = 0;
      waitframe();
    }
  }
}

function ref_1252e(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    self.heli_landing_volumes[var_2.label] = var_0.heli_landing_volumes[var_2.label];
  }
}

function remove_dko_spawnflags(var_0, var_1) {
  var_2 = level.disable_super_in_turret.ref_13876[var_0];
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5.script_group == var_1) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function remove_crusader_class(var_0, var_1, var_2) {
  var_3 = level.disable_super_in_turret.ref_13695[var_0];
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6.script_group == var_1 && var_6.script_index == var_2) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function remove_closest_chopper_boss_vandalize_node_down(var_0, var_1, var_2) {
  var_3 = 10;
  var_4 = 100;
  var_5 = 100;
  var_6 = 90;
  var_7 = 10;
  var_8 = 360 / var_3;
  var_9 = int(var_2 / var_3);
  var_10 = var_2 - var_9 * var_3;
  var_11 = var_1 + var_6 + var_10 * var_8 + var_9 * var_7;
  var_12 = var_4 + var_9 * var_5;
  var_13 = (0, var_11, 0);
  var_14 = anglesToForward(var_13);
  var_15 = var_0 + var_14 * var_12;
  return var_15;
}

function respawnheightoverride(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.script_index == var_0) {
      return var_2;
    }
  }
}

function respawndelayoverride(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.initchallengeandeventglobals == var_0) {
      return var_2;
    }
  }
}

function isused(var_0, var_1) {
  level notify("debugSpawnOrigin");
  level endon("debugSpawnOrigin");

  for(;;) {
    waitframe();
  }
}

function ref_12689(var_0) {
  var_1 = 500;

  if(isDefined(self.ref_12204) && self.ref_12204 == var_0) {
    return;
  }

  var_2 = self.ref_12204;
  self.ref_12204 = var_0;
  self.ref_12202 = gettime() + var_1;
  ref_13181(var_0.label != "A");
}

function ref_12575() {
  return self.ref_12204;
}

function ref_12576() {
  return self.ref_12202;
}

function modifyplayerdamage(var_0) {
  var_1 = var_0.damage;

  if(istrue(self.ref_12279) || istrue(self.ref_12278)) {
    var_1 = 0;

    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker)) {
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hitspawnprotect");
    }
  }

  if(self.team == game["attackers"]) {
    var_2 = isDefined(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() && istrue(var_0.attacker.ref_12282);

    if(var_2) {
      var_1 = int(min(var_1, level.disable_super_in_turret.ref_11b58));
    }
  }

  if(isDefined(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() && isDefined(var_0.attacker.path)) {
    var_1 = 0;
  }

  if(getdvarint("scr_br_payload_mod_gunner_dmg", 1) && isDefined(var_0.victim.set_thirdperson)) {
    if(isPlayer(var_0.attacker) && scripts\engine\utility::isbulletdamage(var_0.meansofdeath) && var_1 < 100) {
      var_3 = var_0.idflags &level.idflags_penetration;
      var_4 = scripts\mp\utility\damage::isheadshot(var_0.shitloc, var_0.meansofdeath, var_0.attacker);
      var_5 = weaponclass(var_0.objweapon) == "spread";

      if(var_3) {
        var_1 *= level.set_total_successful_vehicle_spawns_from_module;
      } else if(!var_4 || !var_5) {
        var_1 *= level.set_tier_lights;
      }
    }
  }

  return var_1;
}

function ref_1226b(var_0, var_1) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    var_2 = var_0.attacker;

    if(!isDefined(var_2) || !isPlayer(var_2)) {
      if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner) && isPlayer(var_0.attacker.owner)) {
        var_2 = var_0.attacker.owner;
      } else if(isDefined(var_0.inflictor) && isPlayer(var_0.inflictor)) {
        var_2 = var_0.inflictor;
      } else if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.owner) && isPlayer(var_0.inflictor.owner)) {
        var_2 = var_0.inflictor.owner;
      } else {
        var_2 = undefined;
      }
    }

    if(isDefined(var_2) && var_2 != self) {
      var_3 = 0;

      if(var_2.team == game["attackers"]) {
        var_3 = getdvarint("scr_br_payload_attacker_kill_pay_scale", 4);
      } else {
        var_3 = getdvarint("scr_br_payload_defender_kill_pay_scale", 3);
      }

      if(ref_125f2(var_2)) {
        var_3 += 4;
      }

      ref_12261(var_2, var_3, "payload_kill");
    }
  }

  return scripts\mp\gametypes\br::emp_drone_damage_monitor(var_0, var_1);
}

function playerdropplunderondeath(var_0, var_1) {
  if(self.team == game["attackers"]) {
    if(getdvarint("scr_br_payload_attacker_plunderdrop", 1) == 0) {
      return true;
    }

    var_2 = getdvarint("scr_br_payload_attacker_saveshare", 7);
    var_3 = getdvarint("scr_br_payload_attacker_taxshare", 0);
    var_4 = getdvarint("scr_br_payload_attacker_dropshare", 0);
  } else {
    if(getdvarint("scr_br_payload_defender_plunderdrop", 1) == 0) {
      return true;
    }

    var_2 = getdvarint("scr_br_payload_defender_saveshare", 7);
    var_3 = getdvarint("scr_br_payload_defender_taxshare", 0);
    var_4 = getdvarint("scr_br_payload_defender_dropshare", 0);
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var_5 = self.plundercount;
  } else {
    scripts\mp\gametypes\br_plunder::ml_p3_func(0, var_4);
    return true;
  }

  var_6 = var_2 + var_3 + var_4;
  var_7 = var_2 / var_6;
  var_8 = int(max(var_5 - 5, int(min(var_5, max(2, int(var_5 * var_7))) + 0.5)));
  var_9 = int(var_5 - var_8);
  var_10 = max(1, var_3 + var_4);
  var_11 = var_3 / var_10;
  var_12 = var_4 / var_10;
  var_13 = int(max(0, int(var_9 * var_12)));
  self.plundercountondeath = var_8;
  var_14 = spawnStruct();
  var_14.ref_133e4 = 1;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var_8, var_14);

  if(var_13 <= 0) {
    return true;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var_13, var_3);
  return true;
}

function ref_12284(var_0, var_1, var_2, var_3) {
  if(!level.disable_super_in_turret.ref_1225f) {
    return;
  }

  if(var_0) {
    var_4 = self.obj_payload_stage.touchlist[self.team];
    ref_12262(var_4, var_2, "vehicle_tick_att");
  }

  if(var_1 || isDefined(self.tutonplayerkilled)) {
    var_4 = self.obj_payload_stage.touchlist[game["defenders"]];
    ref_12262(var_4, var_3, "vehicle_tick_def");
    return;
  }
}

function ref_12262(var_0, var_1, var_2) {
  var_3 = getdvarfloat("scr_br_plunder_while_spectating", 0.4);
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(isbot(var_6.player) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var_7 = var_1;

    if(!scripts\mp\utility\player::isreallyalive(var_6.player)) {
      var_7 = int(max(var_1 * var_3, 1));
    }

    if(!isDefined(var_6.player.plundercount)) {
      var_6.player.plundercount = 0;
    }

    var_6.player scripts\mp\gametypes\br_plunder::ref_12627(var_7);
    level.br_plunder.ref_12784 += var_7;
    var_6.player scripts\mp\gametypes\br_analytics::ref_13c44(var_6.player, var_2, var_7);
  }
}

function ref_12261(var_0, var_1, var_2) {
  var_3 = getdvarfloat("scr_br_plunder_while_spectating", 0.5);
  var_4 = 0;

  if(isbot(var_0) && scripts\mp\gametypes\br_public::validtousesticker()) {
    return;
  }

  var_5 = var_1;

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    var_5 = int(var_1 * var_3);
  }

  if(!isDefined(var_0.plundercount)) {
    var_0.plundercount = 0;
  }

  var_0 scripts\mp\gametypes\br_plunder::ref_12627(var_5);
  level.br_plunder.ref_12784 += var_5;
  var_0 scripts\mp\gametypes\br_analytics::ref_13c44(var_0, var_2, var_5);
}

function totalcollecteditems() {
  if(!level.disable_super_in_turret.ref_136c4) {
    return;
  }

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_2 = ref_11f46(var_1);
    var_3 = var_2[0];
    var_4 = var_2[1];
    var_2 = undefined;
    var_1.ref_136c3 = [];
    var_1.ref_136c3[game["attackers"]] = [];
    var_1.ref_136c3[game["defenders"]] = [];

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_6 = init_trap_room_wave(var_1);
      var_1.ref_136c3[game["attackers"]][var_5] = var_6;
    }

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = init_trap_room_wave(var_1);
      var_1.ref_136c3[game["defenders"]][var_5] = var_6;
    }
  }

  if(istrue(level.disable_super_in_turret.ref_136c5)) {
    level.disable_super_in_turret.ref_136ae = [1500, 2000, 2500, 2800, 3000, 3200, 3500];
    level._effect["payload_oob_1500"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_1500");
    level._effect["payload_oob_2000"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2000");
    level._effect["payload_oob_2500"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2500");
    level._effect["payload_oob_2800"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2800");
    level._effect["payload_oob_3000"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3000");
    level._effect["payload_oob_3200"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3200");
    level._effect["payload_oob_3500"] = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3500");
    return;
  }
}

function ref_140d5() {
  foreach(var_1 in level.disable_super_in_turret.ref_136c3) {}
}

function init_trap_room_wave(var_0) {
  var_1 = getmaxobjectivecount(0, 0, level.disable_super_in_turret.ref_136c2);
  var_1 setmapcirclecolorindex(0);
  var_1 hide();
  var_1.enabled = 0;
  var_1.path = var_0;
  return var_1;
}

function ref_11f46(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, game["attackers"], []);
}

function init_trigger_spawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("trigger_radius", var_0, 0, var_1, 2000);
  var_5.targetname = "OutOfBounds";
  var_5.radius = var_1;
  var_5.script_team = var_2;
  var_5.ref_136bc = var_3;
  var_5.spawntime = gettime();

  if(!istrue(var_4)) {
    thread scripts\mp\outofbounds::watchoobtrigger(var_5);
  }

  return var_5;
}

function ref_13270(var_0, var_1) {
  if(!level.disable_super_in_turret.ref_136c4) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_complete");
  ref_13271(var_0, var_1, game["attackers"]);
  ref_13271(var_0, var_1, game["defenders"]);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
}

function ref_13271(var_0, var_1, var_2) {
  var_3 = relic_squadlink_outline_monitor(var_2);
  var_4 = remove_crusader_class(var_2, var_0.initchallengeandeventglobals, var_1);
  var_5 = rootweapon(var_4, var_0, var_1, var_2);
  var_6 = removeplayeraslootleader(var_4);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_6 = undefined;

  for(var_9 = 0; var_9 < var_0.ref_136c3[var_2].size; var_9++) {
    var_10 = var_0.ref_136c3[var_2][var_9];

    if(isDefined(var_10.trigger)) {
      lastdialogfinishedtime(var_10.trigger);
    }

    has_relic_amped_victim_filled_bar(var_10);

    if(var_9 < var_5.size) {
      var_11 = var_5[var_9];
      var_10.origin = (var_11.origin[0], var_11.origin[1], var_11.radius);
      var_12 = (var_11.origin[0], var_11.origin[1], var_7 + -1000);
      var_10.trigger = init_trigger_spawn(var_12, var_11.radius, var_3, var_10);

      if(istrue(level.disable_super_in_turret.ref_136c5)) {
        var_13 = init_trigger_spawn(var_12, int(var_11.radius + level.disable_super_in_turret.ref_136c9), var_3, var_10, 1);
        var_13.targetname = "OobWarning";
        scripts\mp\utility\trigger::makeenterexittrigger(var_13, &ref_136c6, &ref_136c7);
        var_10.ref_14427 = var_13;
        var_10.radius = var_11.radius;
      }

      if(!var_10.enabled) {
        if(!level.disable_super_in_turret.ref_136be) {
          showtoteam(var_10, var_3);
        }

        var_10.enabled = 1;
      }

      var_10.enabled = 1;
      continue;
    }

    var_10 hide();
    var_10.enabled = 0;
  }
}

function lastdialogfinishedtime(var_0) {
  foreach(var_2 in var_0.entstouching) {
    if(isDefined(var_2.oob) && var_2.oob > 0) {
      scripts\mp\outofbounds::disableoob(var_2);
    }

    var_2.oobtriggers = scripts\engine\utility::array_remove(var_2.oobtriggers, var_0);

    if(var_2.oobtriggers.size == 0) {
      var_2.oobtriggers = undefined;
    }
  }

  var_0 notify("clearOOB");
  var_0 delete();
}

function loadoutexecutionquip(var_0) {
  if(!level.disable_super_in_turret.ref_136c4) {
    return;
  }

  foreach(var_2 in var_0.ref_136c3[game["attackers"]]) {
    if(isDefined(var_2.trigger)) {
      lastdialogfinishedtime(var_2.trigger);
    }

    has_relic_amped_victim_filled_bar(var_2);
    var_2.enabled = 0;
    var_2 hide();
  }

  foreach(var_2 in var_0.ref_136c3[game["defenders"]]) {
    if(isDefined(var_2.trigger)) {
      lastdialogfinishedtime(var_2.trigger);
    }

    has_relic_amped_victim_filled_bar(var_2);
    var_2.enabled = 0;
    var_2 hide();
  }
}

function ropeguy(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = [];

  if(isDefined(level.disable_super_in_turret.ref_136c3) && level.disable_super_in_turret.ref_136c3.size > 0) {
    foreach(var_5 in level.disable_super_in_turret.ref_136c3) {
      if(var_5.script_group != var_0.initchallengeandeventglobals) {
        continue;
      }

      if(var_5.script_index != var_1) {
        continue;
      }

      var_6 = scripts\engine\utility::ter_op(var_5.team == "allies", game["attackers"], game["defenders"]);

      if(var_6 != var_2) {
        continue;
      }

      var_3 = var_5;
    }
  }

  return var_3;
}

function rootweapon(var_0, var_1, var_2, var_3) {
  var_4 = ropeguy(var_1, var_2, var_3);

  if(var_4.size == 0) {
    var_5 = removeplayeraslootleader(var_0);
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_5 = undefined;
    var_8 = (var_7[0], var_7[1], var_6);
    var_4 = spawnStruct();
    var_4[0].origin = var_8;
    var_4[0].radius = level.disable_super_in_turret.ref_136c2;
  }

  return var_4;
}

function removeplayeraslootleader(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_1 += var_4.origin;

    if(!isDefined(var_2) || var_4.origin[2] < var_2) {
      var_2 = var_4.origin[2];
    }
  }

  var_6 = var_1;

  if(var_0.size > 0) {
    var_6 /= var_0.size;
  }

  return [var_2, var_6];
}

function showtoteam(var_0) {
  self hide();
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in var_1) {
    self showtoplayer(var_3);
  }
}

function ref_126ad() {
  self endon("death_or_disconnect");
  self endon("payload_remove_spawn_protection");

  if(isDefined(self.warroomtvs) && (isPlayer(self.warroomtvs) || istrue(self.warroomtvs.bot_gametype_attacker_limit_for_team))) {
    return;
  }

  if(isDefined(self.warroomtvs)) {
    var_0 = self.warroomtvs;
  } else {
    var_0 = ref_12575();
  }

  if(get_bomb_vest_id_vfx(var_0)) {
    return;
  }

  self.ref_12279 = 1;
  thread ref_126ae();
  var_1 = gettime() + level.disable_super_in_turret.ref_1365c * 1000;
  var_2 = ref_1257e(var_0);

  while(isDefined(var_2) && isDefined(var_2.trigger) && self istouching(var_2.trigger) && self playerads() < 0.5 && gettime() < var_1) {
    waitframe();
  }

  self.ref_12279 = undefined;
  self notify("payload_remove_spawn_protection");
}

function ref_1257e(var_0) {
  if(!isDefined(var_0)) {
    var_0 = ref_12575();
  }

  var_1 = var_0.ref_136c3[self.team];

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(!istrue(var_3.enabled)) {
        continue;
      }

      if(self istouching(var_3.trigger)) {
        return var_3;
      }
    }

    return;
  }
}

function ref_126ae() {
  self endon("death_or_disconnect");
  self endon("payload_remove_spawn_protection");
  self waittill("weapon_fired");
  self.ref_12279 = undefined;
  self notify("payload_remove_spawn_protection");
}

function room_doors(var_0) {
  var_1 = "payload_oob_" + var_0;
  return var_1;
}

function ref_136c6(var_0, var_1) {
  if(!isPlayer(var_0) || var_0.team != var_1.script_team) {
    return;
  }

  var_2 = var_1.ref_136bc;

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_2.ref_14425)) {
    var_2.ref_14425 = [];
  }

  var_3 = var_0 getentitynumber();
  var_4 = room_doors(var_2.radius);
  var_5 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
  var_2.ref_14425[var_3] = spawn("script_model", var_5);
  var_2.ref_14425[var_3] setModel("tag_origin");
  var_2.ref_14425[var_3] hide();
  var_2.ref_14425[var_3] showtoplayer(var_0);
  thread ref_136c8(var_0, var_2.ref_14425[var_3], var_4);
}

function ref_136c8(var_0, var_1, var_2) {
  var_1 endon("death");
  var_0 endon("disconnect");
  waitframe();
  var_1 unmarkkeyframedmover(1);
  playFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "tag_origin");
  var_3 = var_1.origin[0];
  var_4 = var_1.origin[1];

  for(;;) {
    var_1.origin = (var_3, var_4, var_0.origin[2]);
    waitframe();
  }
}

function ref_136c7(var_0, var_1) {
  if(!isPlayer(var_0) || var_0.team != var_1.script_team) {
    return;
  }

  var_2 = var_0 getentitynumber();
  var_3 = var_1.ref_136bc;

  if(!isDefined(var_3) || !isDefined(var_3.ref_14425) || !isDefined(var_3.ref_14425[var_2])) {
    return;
  }

  var_3.ref_14425[var_2] delete();
  var_3.ref_14425[var_2] = undefined;
}

function has_relic_amped_victim_filled_bar() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.ref_14427)) {
    var_0.ref_14427 delete();
    var_0.ref_14427 = undefined;
  }

  if(isDefined(var_0.ref_14425)) {
    foreach(var_2 in var_0.ref_14425) {
      if(isDefined(var_2)) {
        var_2 delete();
      }
    }

    var_0.ref_14425 = undefined;
    return;
  }
}

function ref_131d4(var_0) {
  if(var_0 <= 0) {
    setomnvar("ui_hardpoint_timer", gettime());
    return;
  }

  var_1 = scripts\mp\utility\game::gettimepassed();
  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));
  var_2 = int(var_1 / 1000);
  var_3 = var_2 + var_0;
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", var_3);
  setDvar("scr_br_timelimit", var_3);
}

function unset_relic_gas_martyr() {
  return istrue(level.ref_1225c) || istrue(level.gameended);
}

function ontimelimit() {
  if(unset_relic_gas_martyr()) {
    return;
  }

  if(waittill_player_uses_munition()) {
    return;
  }

  if(istrue(level.ref_1227f) || unset_relic_gas_martyr()) {
    return;
  }

  level.ref_1227f = 1;
  ref_12aa3();
  ref_12aa5();
  var_0 = game["attackers"];
  var_1 = game["defenders"];
  var_2 = "time_limit_reached";
  thread ref_14301("stopped", undefined, undefined, 2);
  thread scripts\mp\gametypes\br::ref_1209b(var_0, 2, undefined, 1, 1, 1);
  munition_slot_gunship_emptied_message();
  ref_1225d(1, var_1);
  ref_11ecc(var_1);
  thread scripts\mp\gametypes\br::brendgame(var_1, game["end_reason"][var_2], 0);
}

function ref_11ecc(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && var_2.team == var_0) {
      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    }
  }
}

function munition_slot_gunship_emptied_message() {
  if(!istrue(game["switchedsides"])) {
    return;
  }

  foreach(var_1 in level.players) {
    var_2 = var_1.pers["score"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_score"]), var_1.pers["round1_score"], 0);
    var_1.score = var_2;
    var_3 = var_1.pers["kills"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_kills"]), var_1.pers["round1_kills"], 0);
    var_1.kills = var_3;
    var_4 = var_1.pers["deaths"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_deaths"]), var_1.pers["round1_deaths"], 0);
    var_1.deaths = var_4;
    var_5 = var_1.pers["assists"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_assists"]), var_1.pers["round1_assists"], 0);
    var_1.assists = var_5;
    var_6 = var_1.pers["damage"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_damage"]), var_1.pers["round1_damage"], 0);
    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var_6);
    var_7 = var_1.pers["objTime"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["round1_objTime"]), var_1.pers["round1_objTime"], 0);
    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("objTime", var_7);
  }
}

function munition_source_getridof() {
  foreach(var_1 in level.players) {
    function_0435(var_1);
  }

  foreach(var_1 in level.players) {
    var_1.force_remove_stim = var_1.pers["team"];
    var_1.force_var_to_array = var_1.pers["recordedLoss"];
    var_1.forced_aitypes = var_1.pers["score"];
    var_1.force_teleport_player_into_plane = var_1.pers["kills"];
    var_1.cachedeaths = var_1.pers["deaths"];
    var_1.cacheassists = var_1.pers["assists"];
    var_1.force_maze_ai_state = var_1.pers["damage"];
    var_1.forceabshotfoot = var_1.pers["objTime"];
    var_1.forcearmordropondeath = var_1.pers["roundsAFK"];
  }

  function_0436();

  foreach(var_1 in level.players) {
    var_1.pers["team"] = var_1.force_remove_stim;
    var_1.pers["recordedLoss"] = var_1.force_var_to_array;
    var_1.pers["round1_score"] = var_1.forced_aitypes;
    var_1.pers["round1_kills"] = var_1.force_teleport_player_into_plane;
    var_1.pers["round1_deaths"] = var_1.cachedeaths;
    var_1.pers["round1_assists"] = var_1.cacheassists;
    var_1.pers["round1_damage"] = var_1.force_maze_ai_state;
    var_1.pers["round1_objTime"] = var_1.forceabshotfoot;
    var_1.pers["roundsAFK"] = var_1.forcearmordropondeath;
  }

  game["gamestarted"] = undefined;
  game["clientMatchDataDef"] = undefined;
}

function ref_13230() {
  level.disable_super_in_turret.initsharedomnvars = 0;
  level.disable_super_in_turret.waittill_scout_drone_defined = 0;
  ref_1313a(0);

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_1.getquestplunderrewardinstance = -1;
    ref_11e6f(var_1.getquestplunderrewardinstance, var_1);
  }
}

function relic_amped_last_kill_time(var_0) {
  return var_0.getquestplunderrewardinstance;
}

function ref_11e6f(var_0, var_1) {
  if(!getquesttablerewardgroup()) {
    return;
  }

  if(var_1.getquestplunderrewardinstance >= 0) {
    level notify("checkPointUpdate", var_1);
  }

  if(var_1.getquestplunderrewardinstance >= 0) {
    ref_12aa3(var_1);
    start_pipe_room_menu();
  }

  var_2 = var_1.getquestplunderrewardinstance;
  var_1.getquestplunderrewardinstance++;
  level.disable_super_in_turret.initsharedomnvars = gettime();

  if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
    var_3 = relic_amped_monitor();

    foreach(var_5 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo) {
      var_5 setvalue(var_3);
    }
  }

  if(var_1.getquestplunderrewardinstance > 0) {
    ref_1318a(var_1.script_index, var_1.getquestplunderrewardinstance);
    var_7 = "br_payload_checkpoint";
    var_8 = "br_payload_checkpoint_enemy";
    scripts\mp\gametypes\br::ref_13ac7(var_7, undefined, game["attackers"]);
    scripts\mp\gametypes\br::ref_13ac7(var_8, undefined, game["defenders"]);

    foreach(var_10 in level.teamdata[game["attackers"]]["players"]) {
      var_10 thread scripts\mp\rank::giverankxp("br_payload_reached_checkpoint", level.disable_super_in_turret.ref_12288, undefined);
      var_10 thread scripts\mp\gametypes\br::scriptableusestate("br_payload_reached_checkpoint", int(level.disable_super_in_turret.ref_12288 / 2), var_10.currentweapon, 1);
      var_10 thread scripts\mp\rank::scoreeventpopup("br_payload_reached_checkpoint");
    }

    ref_11f92(var_1, 1, "checkpoint", var_1.getquestplunderrewardinstance);
    thread ref_13639(game["attackers"]);
    thread ref_13639(game["defenders"]);
  }

  if(game["switchedsides"] && isfinalpush()) {
    setnojiptime(1, 1);
    setnojipscore(1, 1);
    level.nojip = 1;
  }

  var_1 notify("checkPointUpdate");
  thread getquestperkbonus(level);
  thread ref_1322f(var_1);
  thread ref_13270(var_1, var_1.getquestplunderrewardinstance);
  thread ref_13260(var_1, var_1.getquestplunderrewardinstance);
  thread ref_1286a(var_1.getquestplunderrewardinstance, var_1);
  thread ref_1326a(var_1, var_1.getquestplunderrewardinstance);
  thread ref_13257(var_1, var_1.getquestplunderrewardinstance);
  thread ref_12cb8(var_1);
}

function ref_12cb8(var_0) {
  var_1 = var_0;

  if(istrue(var_0.hidesmokinggunhudfromplayer)) {
    var_1 = respawn_enemies(var_0);
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3.ref_12276) && var_3.ref_12276 > 0) {
      var_4 = ref_12575(var_3);

      if(var_4 == var_0) {
        var_3.ref_12276++;
        var_3.ref_1286f = ref_1257c(var_3, var_1);

        if(isDefined(var_3.ref_1286f)) {
          var_3.ref_1286f.index = -1;
        }

        var_5 = var_3.ref_1286f.origin;
        var_6 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
        var_3 scripts\mp\gametypes\br_public::ref_126b9(var_5, var_6, 1, 0);
        var_3 scripts\mp\gametypes\br_spectate::ref_1252a();
        var_3 scripts\mp\gametypes\br::spawnintermission(var_5, var_3.ref_1286f.angles);
        var_3 scripts\mp\spectating::setdisabled();
        var_3 scripts\mp\gametypes\br::ending_fade_in(var_5[0], var_5[1], level.juggheli_spawner_jammer5_3);
        var_3 setclientomnvar("ui_br_transition_type", 2);
      }
    }
  }
}

function relic_amped_monitor() {
  var_0 = 0;

  foreach(var_2 in level.disable_super_in_turret.paths) {
    var_3 = 0;

    if(isDefined(var_2.getquestplunderrewardinstance)) {
      var_3 = var_2.getquestplunderrewardinstance;
    }

    var_0 += var_3;
  }

  return var_0;
}

function isfinalpush() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    if(!isDefined(var_1.getquestplunderrewardinstance) || var_1.getquestplunderrewardinstance + 1 < var_1.getquestreward_checkforvalueoverride.size) {
      return false;
    }
  }

  return true;
}

function ref_1322f(var_0) {
  level notify("setupCheckpoint");
  level endon("setupCheckpoint");

  if(var_0.getquestplunderrewardinstance == 0) {
    var_1 = level.disable_super_in_turret.getquestscalervalue;
  } else {
    var_1 = int(level.disable_super_in_turret.waittill_scout_drone_defined / 1000) + level.disable_super_in_turret.brmini_kickplayersatcircleedge;
    setmusicstate("br3_payload_time_added_outro");

    if(level.disable_super_in_turret.maxtime > 0) {
      var_1 = int(min(var_1, level.disable_super_in_turret.maxtime));
    }

    level notify("cancel_announcer_dialog");
    thread timelimitclock();
  }

  scripts\mp\flags::gameflagwait("infil_complete");
  ref_131d4(var_1);
  ref_1313b(var_1);
}

function ref_131d6() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");
  wait 1;
  ref_1318e(1);
}

function ref_12aa3(var_0) {
  if(!getquesttablerewardgroup()) {
    return;
  }

  var_1 = gettime() - level.disable_super_in_turret.initsharedomnvars;

  if(isDefined(var_0)) {
    level.disable_super_in_turret.waittill_scout_drone_timeout = var_0;
  }

  var_2 = relic_amped_on_ai_kill();

  if(var_1 > var_2) {
    var_1 = var_2;
  }

  level.disable_super_in_turret.waittill_scout_drone_defined = var_2 - var_1;
}

function ref_1313c(var_0, var_1, var_2) {
  var_3 = "time_split_" + var_1;
  game[var_0 + "_payload"][var_3] = var_2;
}

function relic_amped_pause(var_0, var_1) {
  var_2 = "time_split_" + var_1;
  var_3 = game[var_0 + "_payload"][var_2];
  return var_3;
}

function ref_1313b(var_0, var_1) {
  var_2 = "time_limit_objective";
  game[var_2] = int(var_0 * 1000);
}

function relic_amped_on_ai_kill(var_0) {
  var_1 = "time_limit_objective";
  return game[var_1];
}

function ref_1313a(var_0) {
  if(!game["switchedsides"]) {
    game["num_checkpoints_objective"] = var_0;
    return;
  }
}

function start_pipe_room_menu() {
  if(!game["switchedsides"]) {
    game["num_checkpoints_objective"] = game["num_checkpoints_objective"] + 1;
    return;
  }
}

function relic_amped_monitor_beeps() {
  return game["num_checkpoints_objective"];
}

function getquesttablerewardgroup() {
  var_0 = 1;
  return var_0;
}

function getquestrewardgroupstablerewards() {
  if(unset_relic_gas_martyr()) {
    return;
  }

  level.ontimelimit = &scripts\engine\utility::void;
  ref_12aa5();
  setomnvar("ui_hardpoint_timer", 0);
  ref_1318e(0);
  var_0 = game["defenders"];
  var_1 = game["attackers"];
  var_2 = "objective_completed";
  thread ref_14301("finished", undefined, undefined, 2);
  thread scripts\mp\gametypes\br::ref_1209b(var_0, 2, undefined, 1, 1, 1);
  munition_slot_gunship_emptied_message();
  ref_1225d(0, var_1);
  ref_11ecc(var_1);
  thread scripts\mp\gametypes\br::brendgame(var_1, game["end_reason"][var_2], 0);
}

function eliminatedhudmonitor(var_0) {
  if(game["switchedsides"]) {
    level thread scripts\mp\gametypes\br::handleendgamesplash(var_0);
    level thread scripts\mp\gametypes\br::setup_player_stealth(var_0);

    if(istrue(level.ref_13364)) {
      level thread scripts\mp\gametypes\br::setup_player_marks(var_0);
    }

    if(isDefined(level.defensefactormod)) {
      wait level.defensefactormod;
    }

    level thread scripts\mp\gametypes\br::setup_player_stealth(var_0);

    if(istrue(level.ref_13364)) {
      level thread scripts\mp\gametypes\br::setup_player_marks(var_0);
      return;
    }

    return;
  }
}

function endgame_stars(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  if(!var_1) {
    wait var_0;
  } else {
    wait var_0 / 2;
    level notify("give_match_bonus");
    wait var_0 / 2;
  }

  level notify("round_end_finished");
}

function relic_squadlink_onsteppedfar(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(level.disable_super_in_turret.waittill_scout_drone_timeout) && isDefined(level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle) && (!var_0 || var_1 == "tie")) {
    var_2 = level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle;
  } else {
    var_3 = undefined;

    foreach(var_5 in level.disable_super_in_turret.paths) {
      if(istrue(var_5.hidesmokinggunhudfromplayer) || !isDefined(var_5.vehicle)) {
        continue;
      }

      if(!isDefined(var_3) || var_5.getquestplunderrewardinstance > var_3.getquestplunderrewardinstance) {
        var_3 = var_5;
        var_6 = var_5.getquestplunderrewardinstance;
      }
    }

    var_2 = var_3.vehicle;
  }

  return var_2;
}

function ref_1426b() {
  var_0 = self.path;
  var_1 = var_0.idle_sfx;

  if(var_0.getquestplunderrewardinstance == 0) {
    var_2 = 1;
    var_3 = 0;
  } else {
    var_2 = var_2.getquestreward_checkforvalueoverride[var_2.getquestplunderrewardinstance - 1].ref_11ea5;
    var_3 = var_2 - 2;
  }

  var_4 = var_2.nodes[var_2];
  var_5 = var_4.origin;
  var_6 = respawningbr(var_2, var_2);
  var_7 = vectortoangles(var_6);
  self vehicle_teleport(var_5, var_7);
  var_8 = var_2.nodes[var_3];
  var_9 = var_8.origin;
  var_6 = respawningbr(var_2, var_3);
  var_10 = vectortoangles(var_6);
  var_3 vehicle_teleport(var_9, var_10);
  return [var_5, var_7];
}

function relic_squadlink_onbecameinvalidplayer(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == game["attackers"]) {
    var_3 = var_1.nodes[var_1.nodes.size - 1];
    var_2 = var_3.origin;
  } else {
    if(var_1.getquestplunderrewardinstance == 0) {
      var_4 = 1;
    } else {
      var_4 = var_2.getquestreward_checkforvalueoverride[var_2.getquestplunderrewardinstance - 1].ref_11ea5;
    }

    var_5 = var_2.nodes[var_4];
    var_4 = var_5.origin;
  }

  return var_4;
}

function registerbrsquadleaderjumpcommands(var_0, var_1) {
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  if(var_1 == game["defenders"] && level.disable_super_in_turret.ref_1226a == "port" && var_0.label == "A" && var_0.getquestplunderrewardinstance == 1) {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["attackers"] && level.disable_super_in_turret.ref_1226a == "trainstation2" && var_0.label == "A") {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["attackers"] && level.disable_super_in_turret.ref_1226a == "downtown2" && var_0.label == "B") {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["attackers"] && level.disable_super_in_turret.ref_1226a == "downtown2" && var_0.label == "A") {
    var_4 = (0, 25, 0);
  }

  return [var_3, var_4];
}

function ref_1225d(var_0, var_1, var_2, var_3) {
  level.ref_1225c = 1;
  level notify("payloadComplete");
  level notify("ending_sequence");
  var_4 = relic_squadlink_onsteppedfar(var_0, var_1);
  var_5 = var_4.path;
  var_6 = relic_squadlink_onbecameinvalidplayer(var_1, var_5);

  foreach(var_9, var_8 in level.players) {
    var_8 notify("abort_killcam");
    var_8.cancelkillcam = 1;

    if(var_8.team == var_1) {
      var_8 setclientomnvar("ui_br_player_position", 1);
    }

    ref_13182(var_8, 0);
    var_8 freezecontrols(1);
    var_8 clearsoundsubmix("iw8_mp_spawn_camera");
    var_8 clearsoundsubmix("deaths_door_mp");
    var_8 setclientomnvar("ui_br_transition_type", 0);
    var_8 setclientomnvar("ui_br_extended_load_screen", 0);

    if(isDefined(var_8.ref_12135)) {
      var_8.ref_12135 stoploopsound(self.ref_12136);
      var_8.ref_12135 delete();
      var_8.ref_12135 = undefined;
      var_8.ref_12136 = undefined;
    }

    var_8 scripts\mp\gametypes\br_public::ref_126b9(var_6);
  }

  setomnvarforallclients("post_game_state", 9);
  wait 3;
  setomnvar("scriptable_loot_hide", 1);
  removeallcorpses();

  if(level.disable_super_in_turret.getquestscaledvalue) {
    foreach(var_11 in level.disable_super_in_turret.getquestrewardstabletype) {
      var_11.getquestrewardstablevaluecolumnindex hide();

      if(isDefined(var_11.getquestrewardstablevaluecolumnindex.turret)) {
        var_11.getquestrewardstablevaluecolumnindex.turret hide();
      }
    }

    foreach(var_11 in level.disable_super_in_turret.ref_13c1a) {
      var_11.getquestrewardstablevaluecolumnindex hide();
    }
  }

  var_15 = undefined;

  if(var_1 == game["attackers"]) {
    var_15 = spawn("script_model", var_4.origin);
    var_15.angles = (0, var_4.angles[1], 0);
    var_15 setModel("vfx_br_payload_checkpoint");
    var_15 unmarkkeyframedmover(1);
    var_15 setscriptablepartstate("checkpoint", "finish");
  } else {
    thread contestedtime(var_4);
  }

  if(var_1 == game["attackers"]) {
    if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
      var_16 = "mp_payload_escape4_victory_cam";
      var_17 = "mp_payload_escape4_loss_cam";
      goto LOC_00000254;
    }

    var_16 = "mp_payload_victory_cam";
    var_17 = "mp_payload_loss_cam";
    var_18 = var_7.nodes[var_7.nodes.size - 1];
    var_19 = var_18.origin;
    var_20 = respawningbr(var_7, var_7.nodes.size - 1);
    var_21 = vectortoangles(var_20);
  } else {
    if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
      var_16 = "mp_payload_escape4_loss_cam";
      var_17 = "mp_payload_escape4_victory_cam";
    } else {
      var_16 = "mp_payload_loss_cam";
      var_17 = "mp_payload_victory_cam";
    }

    var_19 = var_17.origin;
    var_21 = var_17.angles;
  }

  var_22 = registerbrsquadleaderjumpcommands(var_16, var_9);
  var_23 = var_22[0];
  var_24 = var_22[1];
  var_22 = undefined;
  var_25 = var_21 + var_23;
  var_26 = var_21 + var_24;
  var_27 = spawn("script_model", var_19);
  var_27.angles = var_25;
  var_27 setModel("generic_prop_x3");
  var_27 unmarkkeyframedmover(1);
  var_28 = spawn("script_model", var_19);
  var_28.angles = var_26;
  var_28 setModel("generic_prop_x3");
  var_28 unmarkkeyframedmover(1);
  var_27 scriptmodelplayanim(var_16, "payload_complete");
  var_28 scriptmodelplayanim(var_17, "payload_complete");
  var_29 = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");

  foreach(var_21 in var_29) {
    var_21 thread scripts\mp\playerlogic::respawn_asspectator(var_19 + (0, 0, 60), (0, 0, 0));
    var_21 scripts\mp\spectating::setdisabled();
    var_21 cameralinkTo(var_27, "j_prop_1", 1, 1);
  }

  var_32 = scripts\mp\utility\teams::getteamdata(game["defenders"], "players");

  foreach(var_21 in var_32) {
    var_21 thread scripts\mp\playerlogic::respawn_asspectator(var_19 + (0, 0, 60), (0, 0, 0));
    var_21 scripts\mp\spectating::setdisabled();
    var_21 cameralinkTo(var_28, "j_prop_1", 1, 1);
  }

  foreach(var_21 in level.players) {
    if(var_21.team == var_9) {
      var_21 setplayermusicstate("br3_payload_completed_win");
    } else {
      var_21 setplayermusicstate("br3_payload_completed_lose");
    }

    var_21 thermalvisionoff();
    var_21 setsoundsubmix("mp_br_mode_payload_completed", 0.5);
  }
}

function contestedtime(var_0) {
  wait 1.5;
  var_1 = var_0.path;
  var_2 = var_1.idle_sfx;

  if(isDefined(var_1.ref_12358)) {
    var_1.ref_12358 delete();
  }

  foreach(var_4 in var_1.pieces) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }

  if(isDefined(var_2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel)) {
    var_2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();
  }

  var_2 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
  wait 1;

  if(isDefined(var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel)) {
    var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();
  }

  var_0 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
}

function toggle_fx_trap() {
  var_0 = scripts\engine\utility::getStructArray("payloadPath", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(level.disable_super_in_turret.paths)) {
      level.disable_super_in_turret.paths = [];
    }

    var_3 = level.disable_super_in_turret.paths.size;
    level.disable_super_in_turret.paths[var_3] = var_2;
  }

  for(var_5 = 0; var_5 < level.disable_super_in_turret.paths.size; var_5++) {
    var_2 = level.disable_super_in_turret.paths[var_5];
    var_6 = "E";
    var_7 = "_e";
    var_8 = &"BR_PAYLOAD/PATH_E";

    switch (var_2.script_index) {
      case 0:
        var_6 = "A";
        var_7 = "_a";
        var_8 = &"BR_PAYLOAD/PATH_A";
        break;
      case 1:
        var_6 = "B";
        var_7 = "_b";
        var_8 = &"BR_PAYLOAD/PATH_B";
        break;
      case 2:
        var_6 = "C";
        var_7 = "_c";
        var_8 = &"BR_PAYLOAD/PATH_C";
        break;
      case 3:
        var_6 = "D";
        var_7 = "_d";
        var_8 = &"BR_PAYLOAD/PATH_D";
        break;
      default:
        break;
    }

    var_2.label = var_6;
    var_2.iconname = var_7;
    var_2.ref_12201 = var_8;
    var_2.ref_13695 = [];
    var_2.ref_13663 = [];
    var_2.spawncount = [];
    var_2.ref_1361e = [];
    var_2.spawntime = [];
    var_2.numplayers = [];
    var_2.numplayers[game["attackers"]] = 0;
    var_2.numplayers[game["defenders"]] = 0;
    var_2.ref_14307 = "none";
    var_2.ref_14306 = 0;
    var_2.ref_142f7 = 0;
    var_2.ref_142f9 = 0;
    var_2.objidnum = [];
    var_2.ref_12cd5 = [];
    var_2.ref_11f48 = [];
    var_2.pieces = [];
    var_2.wait_for_computer_power = [];
    var_2.ref_11f9f = 0;
    var_2.ref_119d6 = 0;
    var_2.ref_13bf5 = 0;

    if(level.disable_super_in_turret.ref_13601) {
      var_2.ref_136bd = 0;
      var_2.ref_13620 = spawnStruct();
      var_2.ref_13620.bot_gametype_attacker_limit_for_team = 1;
      var_2.ref_13620.path = var_2;
    }

    if(level.disable_super_in_turret.ref_13602 > -1) {
      var_2.ref_136bd = 0;
    }

    if(level.disable_super_in_turret.getquestscaledvalue) {
      var_2.getquestscaledvalue = [];
    }

    freeze_timer_at_max_time_bomb_vest(var_2);
  }
}

function time_on_floor() {
  if(!level.disable_super_in_turret.start_drones_event) {
    return;
  }

  thread time_passed_no_target_threshold();
}

function time_passed_no_target_threshold() {
  var_0 = getEntArray("payload_oob", "targetname");

  if(var_0.size == 0) {
    return;
  }

  var_1 = undefined;

  foreach(var_3 in level.disable_super_in_turret.paths) {
    foreach(var_5 in var_0) {
      if(var_3.initchallengeandeventglobals == var_5.script_group) {
        var_1 = var_5;
        var_1.index = 0;
        break;
      }
    }

    if(isDefined(var_1)) {
      break;
    }
  }

  foreach(var_3 in level.disable_super_in_turret.paths) {
    var_3.start_drones_event = var_1;
  }

  scripts\mp\flags::gameflagwait("infil_complete");
  thread ref_12285(var_1);
}

function ref_12285(var_0) {
  var_0.entstouching = [];
  thread ref_12287(var_0);
  thread ref_12286(var_0);
}

function ref_12286(var_0) {
  level endon("payloadComplete");
  level endon("game_ended");
  var_0 endon("IBTrigger");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1.sq_entergulag) && var_1.sq_entergulag > 0) {
      continue;
    }

    ref_12265(var_0, var_1);
  }
}

function ref_12287(var_0) {
  level endon("payloadComplete");
  level endon("game_ended");
  var_0 endon("IBTrigger");

  for(;;) {
    var_1 = var_0.entstouching;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        var_0.entstouching[var_4] = undefined;
      }

      if(isDefined(var_3) && !var_0 istouching(var_3)) {
        ref_12266(var_0, var_3);
      }
    }

    waitframe();
  }
}

function ref_12265(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_1.ref_12cce)) {
    var_1.ref_12cce = undefined;
  }

  if(isDefined(var_0.ref_13ab7) && isDefined(var_1.owner) && var_0.ref_13ab7 != var_1.owner.team) {
    return;
  }

  if(isDefined(var_0.ref_13ab7) && !isDefined(var_1.owner) && var_0.ref_13ab7 != var_1.team) {
    return;
  }

  if(!isDefined(var_1.sq_movequestlocale)) {
    var_1.sq_movequestlocale = [];

    for(var_3 = 0; var_3 < level.disable_super_in_turret.paths.size; var_3++) {
      var_1.sq_movequestlocale[var_3] = 0;
    }
  }

  var_1.sq_movequestlocale[var_0.index] = 1;
  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobtriggers)) {
    var_1.oobtriggers = [];
  }

  var_4 = [var_0];

  foreach(var_6 in var_1.oobtriggers) {
    var_4 = var_6;
  }

  var_1.oobtriggers = var_4;

  if(isDefined(var_1.sq_entergulag)) {
    var_1.sq_entergulag++;
  } else {
    var_1.sq_entergulag = 1;
  }

  if(isDefined(var_1.oob) && var_1.oob > 0) {
    scripts\mp\outofbounds::disableoob(var_1);
    return;
  }
}

function ref_12266(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.ref_13ab7) && isDefined(var_1.owner) && var_0.ref_13ab7 != var_1.owner.team) {
    return;
  }

  if(isDefined(var_0.ref_13ab7) && !isDefined(var_1.owner) && var_0.ref_13ab7 != var_1.team) {
    return;
  }

  if(isDefined(var_1.sq_entergulag) && var_1.sq_entergulag > 0 && var_1.sq_movequestlocale[var_0.index]) {
    var_1.sq_movequestlocale[var_0.index] = 0;
    var_1.sq_entergulag--;

    foreach(var_4 in var_1.sq_movequestlocale) {
      if(istrue(var_4)) {
        return;
      }
    }

    scripts\mp\outofbounds::enableoob(var_1);
  }

  if(isDefined(var_1.oobtriggers)) {
    var_1.oobtriggers = scripts\engine\utility::array_remove(var_1.oobtriggers, var_0);

    if(var_1.oobtriggers.size == 0) {
      var_1.oobtriggers = undefined;
      return;
    }

    return;
  }
}

function ref_12607(var_0, var_1, var_2) {
  var_3 = scripts\mp\outofbounds::getlastoobtrigger(self);

  if(isDefined(var_3) && isDefined(var_3.spawntime)) {
    if(gettime() - var_3.spawntime < level.disable_super_in_turret.ref_136c0) {
      var_4 = scripts\mp\outofbounds::getoutofboundstime(var_2, self);
      var_4 *= level.disable_super_in_turret.ref_136bf;
      self.oobendtime = int(gettime() + var_4 * 1000);
      thread scripts\mp\outofbounds::watchooboutoftime(self, var_4);
    }
  }

  scripts\mp\outofbounds::playerentercallback(var_0, var_1, var_2);
  self notify("playerDelayDisableOOBOutline");

  if(!isDefined(self.ref_12269)) {
    var_5 = relic_squadlink_outline_monitor(self.team);
    self.ref_12269 = scripts\mp\utility\outline::outlineenableforteam(self, var_5, "outline_nodepth_red", "level_script");
  }

  if(level.disable_super_in_turret.ref_136be) {
    if(isDefined(self.ref_12267)) {
      self.ref_12267 hidefromplayer(self);
      self.ref_12267 = undefined;
    }

    foreach(var_3 in self.oobtriggers) {
      if(isDefined(var_3.ref_136bc)) {
        var_3.ref_136bc showtoplayer(self);
        self.ref_12267 = var_3.ref_136bc;
      }
    }
  }

  thread ref_1260a();
}

function ref_12608(var_0, var_1, var_2) {
  scripts\mp\outofbounds::playerexitcallback(var_0, var_1, var_2);

  if(isDefined(self.ref_12cd3)) {
    self.ref_12cd3.alpha = 0;
  }

  if(isDefined(self.ref_12269)) {
    thread ref_12537();
    return;
  }
}

function ref_12537() {
  self endon("disconnect");
  self notify("playerDelayDisableOOBOutline");
  self endon("playerDelayDisableOOBOutline");
  wait level.disable_super_in_turret.ref_136c1;
  scripts\mp\utility\outline::outlinedisable(self.ref_12269, self);
  self.ref_12269 = undefined;

  if(isDefined(self.ref_12267)) {
    self.ref_12267 hidefromplayer(self);
    self.ref_12267 = undefined;
    return;
  }
}

function headlightright() {
  var_0 = self;
  var_0.sq_movequestlocale = undefined;
  var_0.sq_entergulag = undefined;
}

function toggle_player_settings() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_1.trigger.playersintrigger = [];
    thread ref_144ec();
    thread ref_144ed();
  }
}

function ref_144ec() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var_1 = var_0 getentitynumber();

    if(isDefined(self.playersintrigger[var_1])) {
      continue;
    }

    self.playersintrigger[var_1] = var_0;
    ref_12026(var_0);
  }
}

function ref_144ed() {
  for(;;) {
    foreach(var_1 in self.playersintrigger) {
      if(isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 istouching(self)) {
        continue;
      }

      ref_1202f(var_1);
      self.playersintrigger[var_2] = undefined;
    }

    wait 1;
  }
}

function ref_12026(var_0) {
  thread ref_12609();
}

function ref_1202f(var_0) {
  var_0 notify("left_payload_trigger");
}

function ref_12609() {
  level endon("game_ended");
  self endon("left_payload_trigger");

  for(;;) {
    wait 1;

    if(!isDefined(self.ref_13bf4)) {
      self.ref_13bf4 = 0;
    }

    self.ref_13bf4 += 1;

    if(self.ref_13bf4 % 5 == 0) {
      scripts\cp\vehicles\vehicle_compass_cp::ref_12004("pay_5");
    }
  }
}

function tmtyl_vip_interactions() {
  level.disable_super_in_turret.ref_11e97 = [];
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (18755, -21000, -160), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (21415, -17040, -170), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (21900, -16675, -195), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (20890, -23335, -170), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (24850, -19405, -190), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "downtown2", (25935, -14950, -240), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (37075, -26140, -550), 150, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (35945, -27130, -550), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (36375, -25765, -550), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (38735, -23415, -540), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (38530, -23595, -540), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (38400, -23735, -540), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "port", (34305, -25675, -550), 180, 90);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-22730, -27155, -120), 150, 90);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-19540, -25000, -180), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-13500, -21525, -320), 180, 120);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-22445, -28805, -105), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-15630, -24035, -260), 275, 90);
  battle_tracks_toggleoffstate("mp_don4", "trainstation2", (-8735, -21455, -270), 275, 90);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (1930, -7157.5, 712.5), 80, 160);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-253.5, -7015.5, 712.5), 60, 150);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-346, -6995, 712.5), 60, 150);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-1109.5, -6707, 712.5), 60, 150);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-1202.5, -6662, 712.5), 60, 150);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-1714, -6184, 707.5), 40, 128);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-1822.5, -6050, 707.5), 40, 128);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-4613, -977, 708.5), 50, 128);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-4631.5, -894.5, 708.5), 50, 128);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-4066, 4178, 620), 75, 120);
  battle_tracks_toggleoffstate("mp_escape4", "livingquarters", (-3628.5, 5052, 610.5), 75, 120);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1217, 4405.5, 864.5), 85, 110);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (708, 4182, 952), 80, 60);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1018, 4570, 855), 200, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1268, 4270, 862), 50, 120);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1286, 4124, 866), 200, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1388, 3932, 862), 60, 120);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1402, 3744, 866), 200, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1492, 3364, 866), 200, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1592, 2974, 866), 200, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1648, 2812, 830), 60, 120);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1656, 2618, 858), 200, 70);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1710, 2252, 849), 200, 55);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1797, 2009, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1809, 1897, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1822, 1787, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1834, 1672, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1849, 1544, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1858, 1436, 853), 75, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1888, 1318, 853), 82, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1910, 1206, 853), 82, 75);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1934, 1093, 856), 90, 50);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (2000, 983, 856), 118, 50);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1154, 2289, 1006), 125, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1144, 2438, 995), 125, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1135, 2579, 980), 125, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1134, 2703, 974), 125, 80);
  battle_tracks_toggleoffstate("mp_escape4", "chemicaleng", (1127, 2848, 968), 125, 80);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-2137, 9697.5, 669.5), 120, 300);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2729, 5032, 383), 60, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2912.5, 4905.5, 383), 200, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2820, 4740, 383), 60, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2983, 4661, 383), 200, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2878.5, 4528, 383), 60, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3039.5, 4463, 383), 200, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3096, 4273, 383), 200, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3091, 4118, 383), 150, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3027.5, 4006.5, 383), 60, 140);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (1097, 6176, 600), 82, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (1038, 6257, 600), 82, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (998, 6356, 600), 82, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (971, 6463, 600), 82, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (202, 8582, 715), 260, 120);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (48, 8794, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-44, 8870, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-136, 8948, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-228, 9032, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-320, 9116, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (-400, 9184, 715), 81, 200);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3114, 2007, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3089, 2104, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3065, 2203, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3035, 2313, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3007, 2420, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (2983, 2524, 345), 77, 240);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3523, 2898, 210), 300, 120);
  battle_tracks_toggleoffstate("mp_escape4", "shore", (3161, 3734, 210), 110, 160);
}

function battle_tracks_toggleoffstate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.disable_super_in_turret.ref_11e97)) {
    return;
  }

  if(var_0 != level.mapname || var_1 != level.disable_super_in_turret.ref_1226a) {
    return;
  }

  var_5 = spawn("trigger_radius", var_2, 0, var_3, var_4);
  var_5.targetname = "payload_no_contest_trigger";
  var_5.radius = var_3;
  var_5.height = var_4;
  level.disable_super_in_turret.ref_11e97[level.disable_super_in_turret.ref_11e97.size] = var_5;
}

function getlocationnameforpoint(var_0) {
  if(!isDefined(var_0) || !isPlayer(var_0) || level.disable_super_in_turret.ref_11e97.size == 0) {
    return true;
  }

  foreach(var_2 in level.disable_super_in_turret.ref_11e97) {
    if(var_0 istouching(var_2)) {
      return false;
    }
  }

  return true;
}

function timetonextcheckpoint() {
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_0::toggle_farah_lights(0, "all", 0);
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_1::toggle_farah_lights(1, "all", 1);
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_2::toggle_farah_lights(2, "all", 2);
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_3::toggle_farah_lights(3, "all", 3);
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_0::toggle_farah_lights(0, "standard", 0);
  scripts\mp\gametypes\br_payload_path_mp_br_mechanics_1::toggle_farah_lights(1, "standard", 1);
  scripts\mp\gametypes\br_payload_path_mp_don4_0::toggle_farah_lights(0, "downtown", 0);
  scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights(1, "downtown", 1);
  scripts\mp\gametypes\br_payload_path_mp_don4_2::toggle_farah_lights(2, "downtown", 2);
  scripts\mp\gametypes\br_payload_path_mp_don4_3::toggle_farah_lights(0, "trainstation", 3);
  scripts\mp\gametypes\br_payload_path_mp_don4_4::toggle_farah_lights(1, "trainstation", 4);
  scripts\mp\gametypes\br_payload_path_mp_don4_5::toggle_farah_lights(2, "trainstation", 5);
  scripts\mp\gametypes\br_payload_path_mp_don4_6::toggle_farah_lights(0, "promenade", 6);
  scripts\mp\gametypes\br_payload_path_mp_don4_7::toggle_farah_lights(1, "promenade", 7);
  scripts\mp\gametypes\br_payload_path_mp_don4_8::toggle_farah_lights(2, "promenade", 8);
  scripts\mp\gametypes\br_payload_path_mp_don4_9::toggle_farah_lights(0, "eastriver", 9);
  scripts\mp\gametypes\br_payload_path_mp_don4_10::toggle_farah_lights(1, "eastriver", 10);
  scripts\mp\gametypes\br_payload_path_mp_don4_11::toggle_farah_lights(2, "eastriver", 11);
  scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights(0, "downtown2", 1);
  scripts\mp\gametypes\br_payload_path_mp_don4_0::toggle_farah_lights(1, "downtown2", 0);
  scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights(0, "downtown3", 1);
  scripts\mp\gametypes\br_payload_path_mp_don4_2::toggle_farah_lights(1, "downtown3", 2);
  scripts\mp\gametypes\br_payload_path_mp_don4_3::toggle_farah_lights(0, "trainstation2", 3);
  scripts\mp\gametypes\br_payload_path_mp_don4_4::toggle_farah_lights(1, "trainstation2", 4);
  scripts\mp\gametypes\br_payload_path_mp_don4_12::toggle_farah_lights(0, "port", 12);
  scripts\mp\gametypes\br_payload_path_mp_don4_13::toggle_farah_lights(1, "port", 13);
  scripts\mp\gametypes\br_payload_path_mp_escape4_3::toggle_farah_lights(0, "livingquarters", 0);
  scripts\mp\gametypes\br_payload_path_mp_escape4_4::toggle_farah_lights(0, "chemicaleng", 1);
  scripts\mp\gametypes\br_payload_path_mp_escape4_5::toggle_farah_lights(0, "shore", 2);

  if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
    ref_1318d(1, -1);
    return;
  }
}

function ref_1318d(var_0, var_1) {
  if(var_1 > 31 || var_0 >= 2) {
    return;
  }

  var_2 = 5;
  var_3 = var_0 * 5;
  var_4 = int(pow(2, var_2)) - 1;
  var_5 = (var_1 &var_4) << var_3;
  var_6 = ~(var_4 << var_3);
  var_7 = getomnvar("ui_br_paths");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  setomnvar("ui_br_paths", var_9);
}

function balloon_deposit_cash_vo_explanation(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.targetname = var_0;
  var_3.target = var_1;
  var_3.script_index = var_2;

  if(isDefined(var_3.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][var_3.targetname])) {
      level.struct_class_names["targetname"][var_3.targetname] = [];
    }

    var_4 = level.struct_class_names["targetname"][var_3.targetname].size;
    level.struct_class_names["targetname"][var_3.targetname][var_4] = var_3;
  }

  if(isDefined(var_3.target)) {
    if(!isDefined(level.struct_class_names["target"][var_3.target])) {
      level.struct_class_names["target"][var_3.target] = [];
    }

    var_4 = level.struct_class_names["target"][var_3.target].size;
    level.struct_class_names["target"][var_3.target][var_4] = var_3;
  }

  if(isDefined(var_3.script_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_noteworthy"][var_3.script_noteworthy])) {
      level.struct_class_names["script_noteworthy"][var_3.script_noteworthy] = [];
    }

    var_4 = level.struct_class_names["script_noteworthy"][var_3.script_noteworthy].size;
    level.struct_class_names["script_noteworthy"][var_3.script_noteworthy][var_4] = var_3;
  }

  return var_3;
}

function ref_13929(var_0, var_1) {
  self.origin = var_0;
}

function init_relic_trex(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 2;

  if(isDefined(var_7)) {
    var_9 = newteamhudelem(var_7);
  } else {
    var_9 = newhudelem();
  }

  var_9.elemtype = "font";
  var_9.font = "default";
  var_9.fontscale = var_9;
  var_9.basefontscale = var_9;
  var_9.x = 0;
  var_9.y = 0;
  var_9.width = 0;
  var_9.height = int(level.fontheight * var_9);
  var_9.xoffset = 0;
  var_9.yoffset = 0;
  var_9.children = [];
  var_9 scripts\mp\hud_util::setparent(level.uiparent);
  var_9.hidden = 0;
  var_9.archived = 0;
  var_9.alpha = 1;
  var_9 scripts\mp\hud_util::setpoint(var_3, var_4, var_5, var_6);

  if(isDefined(var_1)) {
    var_9.label = var_1;
  }

  if(isDefined(var_2)) {
    var_9 setvalue(var_2);
  }

  if(isDefined(var_7)) {
    var_9.color = var_7;
  }

  return var_9;
}

function time_between_rocket_fire() {
  var_0 = 0;
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_neutral_a", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_neutral_b", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_neutral_c", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_c", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_neutral_d", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_d", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_neutral_e", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_e", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_a", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_b", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_c", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_c", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_d", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_d", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_e", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_e", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escorting_a", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escorting_b", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escorting_c", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_c", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escorting_d", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_d", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escorting_e", var_0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_e", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_neutral_a", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_neutral_b", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_neutral_c", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_c", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_neutral_d", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_d", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_neutral_e", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_e", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_a", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_b", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_c", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_c", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_d", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_d", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halt_e", var_0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_e", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halting_a", var_0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halting_b", var_0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halting_c", var_0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_c", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halting_d", var_0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_d", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_halting_e", var_0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_e", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", var_0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_b", var_0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_c", var_0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_c", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_d", var_0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_d", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_e", var_0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_e", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_a", var_0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_b", var_0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_c", var_0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_c", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_d", var_0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_d", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_e", var_0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_e", 1);
}

function init_relic_doubletap(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 15;
  level.teamdata[var_0]["checkpoint"] = spawnStruct();
  level.teamdata[var_0]["checkpoint"].choppersupport_modifydamage_trial = [];
  var_7 = var_2;
  var_8 = scripts\engine\utility::ter_op(level.disable_super_in_turret.paths.size <= var_1, level.disable_super_in_turret.paths.size, var_1);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_10 = level.disable_super_in_turret.paths[var_9];
    level.teamdata[var_0]["checkpoint"].choppersupport_modifydamage_trial[var_10.script_index] = init_relic_damage_from_above(var_0, var_7, var_10);
    var_7 += var_3;
  }
}

function ref_12206(var_0, var_1, var_2) {
  var_3 = relic_doubletap_helper(var_2);
  var_4 = level.teamdata[var_1]["checkpoint"].choppersupport_modifydamage_trial[var_0.script_index];

  if(isDefined(var_4)) {
    var_4.choppergunner_refillmissiles.bar.color = var_3;
    return;
  }
}

function relic_doubletap_helper(var_0) {
  switch (var_0) {
    case "red":
      return (1, 0, 0);
    case "blue":
      return (0, 0.75, 1);
    case "yellow":
      return (1, 1, 0);
    case "green":
      return (0, 1, 0);
    case "orange":
      return (1, 0.5, 0);
    case "lightblue":
      return (0.25, 0.5, 1);
    case "white":
    default:
      return (1, 1, 1);
  }
}

function init_relic_damage_from_above(var_0, var_1, var_2) {
  var_3 = 14;
  var_4 = 14;
  var_5 = 14;
  var_6 = 140;
  var_7 = var_3 + var_4;
  var_8 = newteamhudelem(var_0);
  var_8.fontscale = 1.2;
  var_8.x = var_3;
  var_8.y = var_1;
  var_8.alignx = "left";
  var_8.aligny = "top";
  var_8.horzalign = "left_adjustable";
  var_8.vertalign = "top_adjustable";
  var_8.alpha = 0.5;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;
  var_8.label = var_2.ref_12201;
  var_9 = init_tut_doors(var_0, (1, 1, 1), var_6, var_5);
  var_9.x = var_7;
  var_9.y = var_1;
  var_9.alignx = "left";
  var_9.aligny = "top";
  var_9.horzalign = "left_adjustable";
  var_9.vertalign = "top_adjustable";
  var_9.alpha = 0.5;
  ref_132a8(var_9);
  var_9.archived = 1;
  var_9.hidewheninmenu = 1;
  var_9.bar.archived = 1;
  var_9.bar.hidewheninmenu = 1;
  var_9.bar.alpha = 0.5;
  var_8.choppergunner_refillmissiles = var_9;
  var_8.ticks = [];
  var_8.med_transport_initomnvars = [];

  for(var_10 = 0; var_10 < var_2.getquestreward_checkforvalueoverride.size - 1; var_10++) {
    var_8.ticks[var_10] = init_relic_doomslayer(var_0, var_7, var_1, var_5, var_6, var_2, var_10);
  }

  for(var_10 = 0; var_10 < var_2.ref_11f9e.size; var_10++) {
    var_8.med_transport_initomnvars[var_10] = init_structs_mp_br_mechanics(var_0, var_7, var_1, var_5, var_6, var_2, var_10);
  }

  return var_8;
}

function last_vampire_sound(var_0) {
  foreach(var_2 in var_0.ticks) {
    var_2 destroy();
  }

  var_0.ticks = undefined;

  foreach(var_5 in var_0.med_transport_initomnvars) {
    var_5 destroy();
  }

  var_0.med_transport_initomnvars = undefined;
  var_0.choppergunner_refillmissiles.bar destroy();
  var_0.choppergunner_refillmissiles.bar = undefined;
  var_0.choppergunner_refillmissiles destroy();
  var_0.choppergunner_refillmissiles = undefined;
  var_0 destroy();
}

function ref_132a8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;
  self.bar.x = self.x;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

function init_tut_doors(var_0, var_1, var_2, var_3, var_4) {
  var_5 = newteamhudelem(var_0);
  var_5.x = 0;
  var_5.y = 0;
  var_5.frac = 0;
  var_5.color = var_1;
  var_5.sort = -2;
  var_5.shader = "progress_bar_fill";
  var_5 setshader("progress_bar_fill", var_2, var_3);
  var_5.hidden = 0;

  if(isDefined(var_4)) {
    var_5.flashfrac = var_4;
  }

  var_6 = newteamhudelem(var_0);
  var_6.elemtype = "bar";
  var_6.width = var_2;
  var_6.height = var_3;
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_6.bar = var_5;
  var_6.children = [];
  var_6.sort = -3;
  var_6.color = (0, 0, 0);
  var_6.alpha = 0.5;
  var_6 scripts\mp\hud_util::setparent(level.uiparent);
  var_6 setshader("progress_bar_bg", var_2, var_3);
  var_6.hidden = 0;
  return var_6;
}

function init_relic_doomslayer(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1;
  var_8 = var_5.getquestreward_checkforvalueoverride[var_6].loot_choppers / var_5.ref_13bf1;
  var_9 = var_1 + var_8 * var_4;
  var_10 = newteamhudelem(var_0);
  var_10.shader = "progress_bar_fill";
  var_10 setshader("progress_bar_fill", var_7, var_3);
  var_10.x = var_9;
  var_10.y = var_2;
  var_10.alignx = "left";
  var_10.aligny = "top";
  var_10.horzalign = "left_adjustable";
  var_10.vertalign = "top_adjustable";
  var_10.alpha = 0.5;
  var_10.glowalpha = 0;
  var_10.hidewheninmenu = 1;
  var_10.archived = 1;
  var_10.color = (1, 1, 1);
  return var_10;
}

function init_structs_mp_br_mechanics(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 3;
  var_8 = 4;
  var_9 = var_5.ref_11f9e[var_6].dist / var_5.ref_13bf1;
  var_10 = var_1 + var_9 * var_4 - var_7 / 2;
  var_11 = var_2 + var_3 / 2 - var_8 / 2;
  var_12 = newteamhudelem(var_0);
  var_12.shader = "progress_bar_fill";
  var_12 setshader("progress_bar_fill", var_7, var_8);
  var_12.x = var_10;
  var_12.y = var_11;
  var_12.alignx = "left";
  var_12.aligny = "top";
  var_12.horzalign = "left_adjustable";
  var_12.vertalign = "top_adjustable";
  var_12.alpha = 1;
  var_12.glowalpha = 0;
  var_12.hidewheninmenu = 1;
  var_12.archived = 0;
  var_12.color = relic_oneclip_monitor(var_0, 0);
  return var_12;
}

function has_balloon() {
  foreach(var_1 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_1]["checkpoint"])) {
      foreach(var_3 in level.teamdata[var_1]["checkpoint"].choppersupport_modifydamage_trial) {
        last_vampire_sound(var_3);
      }
    }
  }
}

function init_trap_room_obj(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.archived = 0;
  return var_2;
}

function init_trap_room_interactions(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.frac = 0;
  var_3.color = var_0;
  var_3.sort = -2;
  var_3.shader = "progress_bar_fill";
  var_3 setshader("progress_bar_fill", var_1, var_2);
  var_3.hidden = 0;
  var_3.archived = 0;
  var_4 = newhudelem();
  var_4.elemtype = "bar";
  var_4.width = var_1;
  var_4.height = var_2;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.bar = var_3;
  var_4.children = [];
  var_4.sort = -3;
  var_4.color = (0, 0, 0);
  var_4.alpha = 0.5;
  var_4 scripts\mp\hud_util::setparent(level.uiparent);
  var_4 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_4.hidden = 0;
  var_4.archived = 0;
  return var_4;
}

function init_structs(var_0, var_1) {
  var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, 100, -100);
  var_2 = (0, var_1[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = var_0 + var_3 * 110;
  var_5 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_4, 100, -100);
  var_4 = var_5["position"];
  var_6 = vectortopitch(var_5["normal"]) + 90;
  var_7 = (var_6, var_1[1], 0);
  var_8 = var_0 + var_3 * -30;
  var_5 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_8, 100, -100);
  var_8 = var_5["position"];
  var_6 = vectortopitch(var_5["normal"]) + 90;
  var_9 = (var_6, var_1[1], 0);
  var_10 = spawn("script_model", var_4);
  var_10.angles = var_7;
  var_10 setModel("uk_tool_box_small_01");
  var_10 notsolid();
  var_10 hide();
  var_10.ref_11fa2 = var_4;
  var_10.ref_11fa1 = var_7;
  var_10.ref_11f97 = var_8;
  var_10.ref_11f96 = var_9;
  var_11 = var_1[1] - 90;
  var_10.scriptable = spawn("script_model", var_0);
  var_10.scriptable.angles = (0, var_11, -1 * var_6);
  var_10.scriptable setModel("payload_bld_barrier_constructed_01");
  var_10.scriptable unmarkkeyframedmover(1);
  var_10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_10.objidnum != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10.objidnum, "active", var_0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_10.objidnum);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_10.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_10.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(var_10.objidnum, "ui_mp_br_mapmenu_icon_obstacle");
    function_0421(var_10.objidnum, 1);
  }

  var_10.hostdefensefactormod = 0;
  ref_11f9b(var_10);
  return var_10;
}

function ref_13260(var_0, var_1) {
  foreach(var_3 in var_0.ref_11f9e) {
    if(var_1 == 0) {
      var_3 show();
      var_3.scriptable setscriptablepartstate("obstacle", "destroyed");
      var_3.scriptable notsolid();
    }

    if(var_3.getquestplunderrewardinstance == var_1) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_3.objidnum);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objidnum);
  }
}

function ref_1268d() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    foreach(var_3 in var_1.ref_11f9e) {
      if(var_3.getquestplunderrewardinstance == var_1.getquestplunderrewardinstance) {
        if(istrue(self.hostdefensefactormod) && self.team == game["attackers"] || !istrue(self.hostdefensefactormod) && self.team == game["defenders"]) {
          self enableplayeruse(self);
          self hudoutlineenableforclient(self, "outline_depth_cyan");
          continue;
        }

        self disableplayeruse(self);
        self hudoutlinedisableforclient(self);
      }
    }
  }
}

function ref_144e8() {
  var_0 = 5;
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death");
  self notify("watchObstacleUse");
  self endon("watchObstacleUse");

  if(!istrue(self.firstinit)) {
    wait 3;
    self.firstinit = 1;
  }

  var_1 = self;
  var_1 setCursorHint("HINT_NOICON");
  var_1 sethintonobstruction("show");
  var_1 setusepriority(-1);
  var_1 setuseholdduration("duration_none");
  var_1 setuserange(100);
  var_1 setHintString(&"BR_PAYLOAD/OBSTACLE_BUILD");
  var_1.userate = 1;
  var_1.curprogress = 0;
  var_1.usetime = var_0;
  var_1.inuse = 0;
  var_1.playerusing = undefined;
  ref_11fa0(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(get_cave_combat_logic(var_2)) {
      ref_13880(var_2);
      var_1.playerusing = var_2;
      var_1 makeunusable();
      var_3 = ref_144e9(var_2);

      if(istrue(var_1.isusable)) {
        var_1 makeusable();
      }

      var_1.playerusing = undefined;

      if(istrue(var_3)) {
        ref_11f98(var_2);
      }
    }
  }
}

function ref_144e9(var_0) {
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_1 = self;
  var_1.id = "destroy";
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);

  if(!istrue(self.hostdefensefactormod)) {
    var_1.id = "build";
    self.scriptable setscriptablepartstate("obstacle", "building");
  }

  var_2 = gettime();

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && get_alive_able_players(var_0) && var_0 useButtonPressed(1) && istrue(var_0.tuttxtbox)) {
    var_1.curprogress += level.framedurationseconds * var_1.userate;

    if(var_1.curprogress >= var_1.usetime) {
      if(isDefined(var_0)) {
        ref_138f6(var_0);
      }

      var_1.playerusing = undefined;
      var_1.curprogress = 0;
      return true;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);
    waitframe();
  }

  if(self.hostdefensefactormod) {
    self show();
  }

  var_1.playerusing = undefined;

  if(isDefined(var_0)) {
    ref_138f6(var_0);
  }

  jumpiftrue(istrue(self.hostdefensefactormod)) LOC_00000143;
  var_3 = (gettime() - var_2) / 1000;
  ref_11f99(0, var_3);
  goto LOC_00000177;
}

function ref_11f9c(var_0) {
  self.isusable = 1;
  self makeusable();
  ref_11fa0();

  if(var_0) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);
  }

  thread ref_144e8();
}

function ref_11f9b() {
  self notify("makeObstacleUnusable");
  self.isusable = 0;
  self.playerusing = undefined;
  self makeunusable();
  self hudoutlinedisable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
}

function ref_13880(var_0) {
  var_1 = self;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 0);
    }
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
    }

    var_0.tuttxtbox = 1;

    if(self.hostdefensefactormod) {
      self hide();
      thread ref_125c3(var_0, "briefcase_bomb_mp");
    } else {
      thread ref_125c0(var_0, "buildable_tool_mp");
    }
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
}

function ref_138f6(var_0) {
  var_1 = self;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 1);
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_1, 0);
  }

  var_0.tuttxtbox = undefined;
  var_0 notify("obstacle_use_end");
}

function get_cave_combat_logic(var_0) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 isonladder()) {
    return false;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()])) {
    return false;
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return false;
    }

    if(var_0.squadindex != self.squadindex || var_0.team != self.team) {
      return false;
    }
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return false;
    }

    if(var_0.team != self.team) {
      return false;
    }
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "botIsKillstreakSupported")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "grnd" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "botIsKillstreakSupported")]](self.cratetype)) {
          return false;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "isKillstreakBlockedForBots")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "isKillstreakBlockedForBots")]](self.cratetype)) {
        return false;
      }
    }
  }

  if(!self.isusable) {
    return false;
  }

  if(var_0 isskydiving()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(isDefined(self.playerusing) && self.playerusing != var_0) {
    return false;
  }

  return true;
}

function get_alive_able_players(var_0) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(distancesquared(var_0.origin, self.origin) >= 10000) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function ref_11f98(var_0) {
  if(istrue(self.hostdefensefactormod)) {
    self.hostdefensefactormod = 0;
    self.path.ref_11f9f++;
    self setHintString(&"BR_PAYLOAD/OBSTACLE_BUILD");
    ref_11f99(1);
    self setModel("uk_tool_box_small_01");
    self.origin = self.ref_11fa2;
    self.angles = self.ref_11fa1;
    self dontinterpolate();
    self show();
    var_1 = 0;

    if(isDefined(self.path.vehicle.tutonplayerkilled) && self.path.vehicle.tutonplayerkilled == self) {
      self.path.vehicle.tutonplayerkilled = undefined;
      self.path.vehicle.cone = undefined;
      self.path.vehicle.carriable_physics_launch = self;
      var_1 = 1;
    } else {
      var_2 = distance2dsquared(self.path.vehicle.origin, self.origin);

      if(var_2 < level.disable_super_in_turret.ref_14300) {
        var_1 = 1;
      }
    }

    if(var_1) {
      ref_11f92(self.path, 0, "obstacleRemoved");
    }

    foreach(var_4 in level.players) {
      if(!isalive(var_4)) {
        continue;
      }

      var_4 thread scripts\mp\hud_message::showsplash("br_payload_obstacle_removed", undefined, var_0);
    }

    if(isDefined(var_0)) {
      foreach(var_4 in level.teamdata[var_0.team]["players"]) {
        var_7 = getdvarint("br_payload_obstacle_destroyed_xpOverride", 500);
        var_4 thread scripts\mp\rank::giverankxp("br_payload_obstacle_destroyed", 500, var_7, undefined);
        var_4 thread scripts\mp\gametypes\br::scriptableusestate("br_payload_obstacle_destroyed", int(250), var_4.currentweapon, 1);
        var_4 thread scripts\mp\rank::scoreeventpopup("br_payload_obstacle_destroyed");
        var_4 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(500, "br_payload_obstacle_destroyed");
      }
    }

    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, game["attackers"]);
  } else {
    self.hostdefensefactormod = 1;
    self.origin = self.ref_11f97;
    self.angles = self.ref_11f96;
    self dontinterpolate();
    self setHintString(&"BR_PAYLOAD/OBSTACLE_REMOVE");
    self setModel("offhand_wm_briefcase_bomb");
    self.scriptable setscriptablepartstate("obstacle", "constructed");

    if(isDefined(self.path.vehicle.carriable_physics_launch) && self.path.vehicle.carriable_physics_launch == self) {
      self.path.vehicle.tutonplayerkilled = self;
      self.path.vehicle.carriable_physics_launch = undefined;
    }

    jumpiffalse(isDefined(var_4)) LOC_0000031e;

    foreach(var_4 in level.teamdata[var_4.team]["players"]) {
      var_7 = getdvarint("br_payload_obstacle_built_xpOverride", 1000);
      var_4 thread scripts\mp\rank::giverankxp("br_payload_obstacle_built", 1000, var_7, undefined);
      var_4 thread scripts\mp\gametypes\br::scriptableusestate("br_payload_obstacle_built", int(500), var_4.currentweapon, 1);
      var_4 thread scripts\mp\rank::scoreeventpopup("br_payload_obstacle_built");
      var_4 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(1000, "br_payload_obstacle_built");
    }

    var_11 = self.scriptable physics_getentityaabb();
    var_12 = physics_createcontents(["physicscontents_player"]);
    var_13 = physics_aabbbroadphasequery(var_11["min"], var_11["max"], var_12, []);
    var_14 = self.ref_11fa2 - self.ref_11f97;
    var_15 = vectorNormalize(var_14);
    var_16 = distance(self.ref_11fa2, self.ref_11f97);
    var_17 = var_16 / 2;
    var_18 = self.ref_11f97 + var_15 * var_17;

    foreach(var_4 in var_13) {
      if(!isDefined(var_4) || !isalive(var_4)) {
        continue;
      }

      var_20 = var_4.origin - var_18;
      var_21 = vectorNormalize(var_20);
      var_22 = var_4.origin - self.ref_11f97;
      var_23 = var_4.origin - self.ref_11fa2;
      var_24 = vectordot(var_15, var_22);
      var_25 = vectordot(var_15, var_23);

      if(!(var_24 > 0 && var_25 < 0)) {
        continue;
      }

      var_26 = vectordot(var_15, var_21);
      var_27 = var_26 * var_17;
      var_27 = abs(var_27);
      var_28 = var_17 + 35 - var_27;
      var_28 *= scripts\engine\utility::sign(var_26);
      var_29 = var_4.origin + var_15 * var_28;
      var_29 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_29, 100, -100);
      var_4 setOrigin(var_29);
    }

    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, game["defenders"]);
  }

  ref_1318c(self.path.script_index, self.index, self.hostdefensefactormod);

  if(isDefined(var_4)) {
    ref_12261(var_4, level.disable_super_in_turret.ref_11f9d, "obstacle");
  }

  ref_11fa0();
  ref_11fa3(game["attackers"]);
  ref_11fa3(game["defenders"]);
}

function ref_11f99(var_0, var_1) {
  var_2 = 2;
  self makeunusable();

  if(var_0) {
    playsoundatpos(self.origin + (0, 0, 50), "payload_buildable_bomb_timer");
    wait 2;
    self hide();
  }

  var_3 = "destroying";
  var_4 = var_2;

  if(isDefined(var_1)) {
    if(var_1 <= 2.3) {
      var_3 = "building_failed5";
      var_4 = 0.7;
    } else if(var_1 <= 3) {
      var_3 = "building_failed4";
      var_4 = 1;
    } else if(var_1 <= 3.6) {
      var_3 = "building_failed3";
      var_4 = 1.4;
    } else if(var_1 <= 4.3) {
      var_3 = "building_failed2";
      var_4 = 1.7;
    } else {
      var_3 = "building_failed1";
      var_4 = 1.9;
    }
  }

  self.scriptable setscriptablepartstate("obstacle", var_3);
  wait var_4;

  if(istrue(self.isusable)) {
    self makeusable();
    ref_11fa0();
    return;
  }
}

function relic_oneclip_monitor(var_0, var_1) {
  if(istrue(var_1)) {
    if(var_0 == game["attackers"]) {
      return relic_doubletap_helper("red");
    }

    return relic_doubletap_helper("blue");
  }

  if(var_0 == game["attackers"]) {
    return relic_doubletap_helper("blue");
  }

  return relic_doubletap_helper("red");
}

function ref_11fa3(var_0) {
  var_1 = level.teamdata[var_0]["checkpoint"].choppersupport_modifydamage_trial[self.path.script_index];

  if(isDefined(var_1)) {
    var_2 = var_1.med_transport_initomnvars[self.index];
    var_2.color = relic_oneclip_monitor(var_0, self.hostdefensefactormod);
    return;
  }
}

function ref_11fa0() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");
  var_1 = scripts\mp\utility\teams::getteamdata(game["defenders"], "players");
  jumpiffalse(istrue(self.hostdefensefactormod)) LOC_000000a1;

  foreach(var_3 in var_0) {
    self enableplayeruse(var_3);
  }

  foreach(var_3 in var_1) {
    self disableplayeruse(var_3);
  }

  if(var_0.size > 0) {
    self hudoutlineenableforclients(var_0, "outline_depth_cyan");
  }

  if(var_1.size > 0) {
    self hudoutlinedisableforclients(var_1);
    return;
  }

  return;
}

function ref_11f92(var_0, var_1, var_2, var_3) {
  thread ref_14301(var_2, var_3, var_0);

  if(istrue(var_1)) {
    ref_12194(var_0.label);
    return;
  }
}

function timed_laser_trap_trigger() {
  level.disable_super_in_turret.overtime = [];
  ref_121a3();
  ref_13189(0);
  thread ref_11e10();
}

function ref_12194(var_0) {
  ref_121a3();

  if(ref_12198()) {
    level.disable_super_in_turret.overtime[var_0] = level.disable_super_in_turret.ref_121a2 + ref_1219d();
  } else {
    level.disable_super_in_turret.overtime[var_0] = gettime();
  }

  level.disable_super_in_turret.overtime[var_0] += respawn_solo() * 1000;
}

function ref_12198() {
  var_0 = ref_1219b();
  return var_0 >= ref_1219d();
}

function ref_1219b() {
  if(isDefined(level.disable_super_in_turret.ref_121a2)) {
    return (gettime() - level.disable_super_in_turret.ref_121a2);
  }

  return 0;
}

function ref_1219c() {
  return level.disable_super_in_turret.ref_12199;
}

function ref_1219d() {
  return int(ref_1219c() * 1000);
}

function ref_121a3() {
  var_0 = ref_1219b();
  var_1 = var_0 / 1000;
  var_2 = [5, 4, 3, 2, 1];

  if(var_1 < level.disable_super_in_turret.ref_1219e || ref_12198()) {
    var_3 = var_2[0];
  } else if(var_2 < level.disable_super_in_turret.ref_1219f) {
    var_3 = var_3[1];
  } else if(var_3 < level.disable_super_in_turret.ref_121a0) {
    var_3 = var_3[2];
  } else if(var_3 < level.disable_super_in_turret.ref_121a1) {
    var_3 = var_3[3];
  } else {
    var_3 = var_3[4];
  }

  level.disable_super_in_turret.ref_1219a = var_3;
  ref_13188(int(var_3));
}

function respawn_solo() {
  return level.disable_super_in_turret.ref_1219a;
}

function respawn_state_greyout(var_0) {
  var_1 = var_0;
  var_1 -= gettime();

  if(var_1 <= 0) {
    var_1 = 0;
  }

  return var_1;
}

function respawn_trigger_think() {
  var_0 = gettime();

  foreach(var_2 in level.disable_super_in_turret.overtime) {
    if(var_2 > var_0) {
      var_0 = var_2;
    }
  }

  ref_13189(respawn_state_greyout(int(var_0)));
  return int(var_0);
}

function respawn_state_ready() {
  var_0 = respawn_trigger_think();
  var_0 = (var_0 - gettime()) / 1000;

  if(var_0 <= 0) {
    var_0 = 0;
  }

  return var_0;
}

function respawn_state_hidden() {
  var_0 = respawn_trigger_think();
  var_0 -= gettime();

  if(var_0 <= 0) {
    var_0 = 0;
  }

  return var_0;
}

function waittill_player_uses_munition() {
  var_0 = respawn_state_ready();

  if(var_0 <= 0) {
    return false;
  }

  ref_12194("minOvertime");
  level.timelimitoverride = 1;
  level.disable_super_in_turret.ref_121a2 = gettime();
  level notify("start_overtime");
  thread ref_14301("overtime");
  thread waittill_player_uses_scavenger_contract();

  while(scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0) {
    waitframe();
  }

  level notify("stop_overtime");
  ref_13189(0);
  level.timelimitoverride = 0;
  level.disable_super_in_turret.ref_121a2 = undefined;
  ref_121a3();
  return scripts\mp\gamelogic::gettimeremaining() > 0;
}

function waittill_player_uses_scavenger_contract() {
  level endon("stop_overtime");

  for(;;) {
    waittillframeend();
    var_0 = respawn_state_ready();
    waitframe();
  }
}

function ref_12197() {
  return scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0;
}

function ref_12193() {
  var_0 = "scr_overtime_debug";
  setDvar(var_0, 0);

  for(;;) {
    while(!getdvarint(var_0, 0)) {
      wait 0.5;
    }

    var_1 = scripts\mp\hud_util::createservertimer("hudbig", 1);
    var_1 scripts\mp\hud_util::setpoint("LEFTBOTTOM", undefined, 15, -80);
    var_1.color = (1, 0, 0);
    var_1.archived = 0;
    var_1.label = &"Overtime Seconds: ";
    var_2 = scripts\mp\hud_util::createservertimer("hudbig", 1);
    var_2 scripts\mp\hud_util::setpoint("LEFTBOTTOM", undefined, 15, -60);
    var_2.color = (1, 0, 0);
    var_2.archived = 0;
    var_2.label = &"Overtime Seconds Max: ";
    var_3 = scripts\mp\hud_util::createservertimer("hudbig", 1);
    var_3 scripts\mp\hud_util::setpoint("LEFTBOTTOM", undefined, 15, -40);
    var_3.color = (1, 0, 0);
    var_3.archived = 0;
    var_3.label = &"Total Overtime: ";
    var_4 = scripts\mp\hud_util::createservertimer("hudbig", 1);
    var_4 scripts\mp\hud_util::setpoint("LEFTBOTTOM", undefined, 15, -20);
    var_4.color = (1, 0, 0);
    var_4.archived = 0;
    var_4.label = &"Total Overtime Max: ";

    while(getdvarint(var_0, 0)) {
      waitframe();
      waittillframeend();
      var_1 setvalue(respawn_state_ready());
      var_2 setvalue(respawn_solo());
      var_3 setvalue(ref_1219b() / 1000);
      var_4 setvalue(ref_1219c());
    }

    level notify("stop_overtime");
    var_1 destroy();
    var_2 destroy();
    var_3 destroy();
    var_4 destroy();
  }
}

function timed_death() {
  if(!level.disable_super_in_turret.checkpoint_objective) {
    return;
  }

  var_0 = [];

  if(isDefined(level.disable_super_in_turret.wait_for_gl_pickup) && level.disable_super_in_turret.wait_for_gl_pickup.size > 0) {
    foreach(var_2 in level.disable_super_in_turret.wait_for_gl_pickup) {
      var_3 = var_2.script_group;

      if(!isDefined(var_3)) {
        continue;
      }

      var_4 = respawndelayoverride(var_3);

      if(isDefined(var_4)) {
        var_5 = var_2.angles;

        if(!isDefined(var_5)) {
          var_5 = (0, 0, 0);
        }

        var_6 = easepower("br_plunder_box", var_2.origin, var_5);

        if(isDefined(var_6)) {
          var_6.path = var_4;
          var_6.getquestplunderrewardinstance = var_2.script_index;

          if(!isDefined(var_6.getquestplunderrewardinstance)) {
            var_6.getquestplunderrewardinstance = 0;
          }

          var_0 = var_6;
          var_4.wait_for_computer_power[var_4.wait_for_computer_power.size] = var_6;
        }
      }
    }
  }

  if(var_0.size == 0) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      foreach(var_10 in var_4.wait_for_at_least_one_player_spawns_in) {
        var_11 = var_4.nodes[var_10].origin;
        var_12 = respawningbr(var_4, var_10);
        var_6 = init_seq_button(var_11, var_12, var_4.script_index);

        if(isDefined(var_6)) {
          var_6.path = var_4;
          var_6.getquestplunderrewardinstance = var_4.script_index;

          if(!isDefined(var_6.getquestplunderrewardinstance)) {
            var_6.getquestplunderrewardinstance = 0;
          }

          var_0 = var_6;
          var_4.wait_for_computer_power[var_4.wait_for_computer_power.size] = var_6;
        }
      }
    }
  }

  thread ref_1316a(var_0);
}

function ref_1316a(var_0) {
  scripts\mp\flags::gameflagwait("infil_complete");
  scripts\mp\gametypes\br_armory_kiosk::ref_131c0(var_0);
}

function init_seq_button(var_0, var_1, var_2) {
  var_3 = 300;
  var_4 = 600;
  var_5 = 50;
  var_6 = 100;
  var_7 = vectortoangles(var_1);
  var_8 = anglestoright(var_7);
  var_9 = -1 * var_8;
  var_10 = var_3;

  while(var_10 <= var_4) {
    var_11 = var_0 + var_10 * var_8;
    var_12 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_11);
    var_13 = abs(var_0[2] - var_12[2]);

    if(var_13 < var_6) {
      var_14 = vectortoangles(var_9);
      var_15 = easepower("br_plunder_box", var_12, var_14);
      return var_15;
    }

    var_14 = var_2 + var_12 * var_11;
    var_15 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_14);
    var_17 = abs(var_2[2] - var_15[2]);

    if(var_17 < var_8) {
      var_14 = vectortoangles(var_10);
      var_15 = easepower("br_plunder_box", var_15, var_14);
      return var_15;
    }

    var_16 += var_9;
  }
}

function isusingremotekillstreak(var_0, var_1, var_2, var_3) {
  isteamonlycrate(var_0, var_1, var_2, (0, 1, 0), var_3);
}

function isspreadweapon(var_0, var_1, var_2, var_3) {
  isteamonlycrate(var_0, var_1, var_2, (1, 1, 0), var_3);
}

function isteamonlycrate(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    if(getdvarint("debugPathPoint", 0) != var_2) {
      waitframe();
      continue;
    }

    if(isDefined(var_1)) {}

    if(isDefined(var_4)) {}

    waitframe();
  }
}

function ref_13257(var_0, var_1) {
  foreach(var_3 in var_0.wait_for_computer_power) {
    if(var_3.getquestplunderrewardinstance == var_1) {
      var_3 setscriptablepartstate("br_plunder_box", "visible");
      continue;
    }

    var_3 setscriptablepartstate("br_plunder_box", "hidden");
  }
}

function toggle_in_use() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("payload_c130_loot");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_01_br";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 2;
  var_0.otherusetime = 2;
  var_0.activatecallback = &scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
  var_0.capturecallback = &dialog_wait_think_civ;
  var_0.destroycallback = &scripts\cp_mp\killstreaks\airdrop::dialogqueue;
  var_0.ingame = &scripts\cp_mp\killstreaks\airdrop::dialogueindex;
  var_0.destroyoncapture = 0;
}

function dialog_wait_think_civ(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_c130_box_open");
  var_0.ref_12cd2 = 1;
}

function eliminate_drone_spotlight_speed() {
  return !istrue(self.ref_12cd2);
}

function init_relic_fastbleedout(var_0, var_1) {
  if(var_1 == "juggernaut") {
    var_0.ref_133ce = 1;
  }

  return var_0;
}

function tracegroundheightexfil() {
  game["dialog"]["payload_welcome"] = "gametype_payload";
  game["dialog"]["halftime"] = "gametype_payload_halftime";
  game["dialog"]["timesup_120"] = "payload_2_min";
  game["dialog"]["timesup_60"] = "payload_60_sec";
  game["dialog"]["timesup_45"] = "payload_45_sec";
  game["dialog"]["timesup_20"] = "payload_20_sec";
  game["dialog"]["timesup_10"] = "payload_10_sec";
  game["dialog"]["payload_oob"] = "payload_out";
  game["dialog"]["redeploy"] = "payload_attack_prepare";
  game["dialog"]["contract_acquired"] = "contract_acquired";
  game["dialog"]["contract_complete"] = "contract_complete";
  game["dialog"]["contract_fail"] = "contract_fail";
  game["dialog"]["attack_intro1"] = "gametype_desc_payload_attack";
  game["dialog"]["attack_intro2"] = "gametype_desc_payload_attack2";
  game["dialog"]["attack_securing_a"] = "payload_attack_alpha_move";
  game["dialog"]["attack_securing_b"] = "payload_attack_bravo_move";
  game["dialog"]["attack_losing_a"] = "payload_attack_a_back";
  game["dialog"]["attack_losing_b"] = "payload_attack_b_back";
  game["dialog"]["attack_contested_a"] = "payload_attack_a_contest";
  game["dialog"]["attack_contested_b"] = "payload_attack_b_contest";
  game["dialog"]["attack_blocked_a"] = "payload_attack_a_blocked";
  game["dialog"]["attack_blocked_b"] = "payload_attack_b_blocked";
  game["dialog"]["attack_obstacle_a"] = "payload_obs_a";
  game["dialog"]["attack_obstacle_b"] = "payload_obs_b";
  game["dialog"]["attack_secured1_a"] = ["payload_attack_a_success", "payload_attack_sat_1"];
  game["dialog"]["attack_secured1_b"] = ["payload_attack_b_success", "payload_attack_sat_1"];
  game["dialog"]["attack_secured2_a"] = ["payload_attack_a_success", "payload_attack_sat_2"];
  game["dialog"]["attack_secured2_b"] = ["payload_attack_b_success", "payload_attack_sat_2"];
  game["dialog"]["attack_secured3_a"] = ["payload_attack_path_a", "payload_attack_sat_3"];
  game["dialog"]["attack_secured3_b"] = ["payload_attack_path_b", "payload_attack_sat_3"];
  game["dialog"]["payload_attack_a_success"] = "payload_attack_a_success";
  game["dialog"]["payload_attack_b_success"] = "payload_attack_b_success";
  game["dialog"]["payload_attack_path_a"] = "payload_attack_path_a";
  game["dialog"]["payload_attack_path_b"] = "payload_attack_path_b";
  game["dialog"]["payload_attack_sat_1"] = "payload_attack_sat_1";
  game["dialog"]["payload_attack_sat_2"] = "payload_attack_sat_2";
  game["dialog"]["payload_attack_sat_3"] = "payload_attack_sat_3";
  game["dialog"]["attack_overtime"] = "payload_attack_overtime";
  game["dialog"]["attack_near1_a"] = "payload_attack_a_near1";
  game["dialog"]["attack_near1_b"] = "payload_attack_b_near1";
  game["dialog"]["attack_near2_a"] = "payload_attack_a_near2";
  game["dialog"]["attack_near2_b"] = "payload_attack_b_near2";
  game["dialog"]["attack_near3_a"] = "payload_attack_a_near3";
  game["dialog"]["attack_near3_b"] = "payload_attack_b_near3";
  game["dialog"]["attack_finished"] = "payload_attack_win";
  game["dialog"]["attack_stopped"] = "payload_attack_lose";
  game["dialog"]["defend_intro1"] = "gametype_desc_payload_defend";
  game["dialog"]["defend_intro2"] = "gametype_desc_payload_defend2";
  game["dialog"]["defend_losing_a"] = "payload_defend_a_move";
  game["dialog"]["defend_losing_b"] = "payload_defend_b_move";
  game["dialog"]["defend_securing_a"] = "payload_defend_a_retreat";
  game["dialog"]["defend_securing_b"] = "payload_defend_b_retreat";
  game["dialog"]["defend_contested_a"] = "payload_defend_a_contest";
  game["dialog"]["defend_contested_b"] = "payload_defend_b_contest";
  game["dialog"]["defend_blocked_a"] = "payload_defend_a_block";
  game["dialog"]["defend_blocked_b"] = "payload_defend_b_block";
  game["dialog"]["defend_obstacle_a"] = "payload_defend_a_destroy";
  game["dialog"]["defend_obstacle_b"] = "payload_defend_b_destroy";
  game["dialog"]["defend_lost1_a"] = ["payload_defend_cross_fail1", "payload_defend_sat_1"];
  game["dialog"]["defend_lost1_b"] = ["payload_defend_cross_fail1", "payload_defend_sat_1"];
  game["dialog"]["defend_lost2_a"] = ["payload_defend_cross_fail2", "payload_defend_sat_2"];
  game["dialog"]["defend_lost2_b"] = ["payload_defend_cross_fail2", "payload_defend_sat_2"];
  game["dialog"]["defend_lost3_a"] = ["payload_defend_path_a", "payload_defend_sat_3"];
  game["dialog"]["defend_lost3_b"] = ["payload_defend_path_b", "payload_defend_sat_3"];
  game["dialog"]["payload_defend_cross_fail1"] = "payload_defend_cross_fail1";
  game["dialog"]["payload_defend_cross_fail2"] = "payload_defend_cross_fail2";
  game["dialog"]["payload_defend_path_a"] = "payload_defend_path_a";
  game["dialog"]["payload_defend_path_b"] = "payload_defend_path_b";
  game["dialog"]["payload_defend_sat_1"] = "payload_defend_sat_1";
  game["dialog"]["payload_defend_sat_2"] = "payload_defend_sat_2";
  game["dialog"]["payload_defend_sat_3"] = "payload_defend_sat_3";
  game["dialog"]["defend_overtime"] = "payload_defend_overtime";
  game["dialog"]["defend_near1_a"] = "payload_defend_a_near1";
  game["dialog"]["defend_near1_b"] = "payload_defend_b_near1";
  game["dialog"]["defend_near2_a"] = "payload_defend_a_near2";
  game["dialog"]["defend_near2_b"] = "payload_defend_b_near2";
  game["dialog"]["defend_near3_a"] = "payload_defend_a_near3";
  game["dialog"]["defend_near3_b"] = "payload_defend_b_near3";
  game["dialog"]["defend_stopped"] = "payload_defend_win";
  game["dialog"]["defend_finished"] = "payload_defend_lose";
  game["dialog"]["round_success"] = undefined;
  game["dialog"]["round_failure"] = undefined;
  game["dialog"]["round_draw"] = undefined;
}

function ref_14301(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_2.ref_14307 = "none";
    var_2.ref_14306 = gettime() + level.disable_super_in_turret.ref_14305;
    var_2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
    return;
  }

  if(isDefined(var_3)) {
    wait var_3;
  }

  var_4 = ref_1332c(var_0);
  var_5 = isDefined(var_2) && var_2.ref_14307 == var_0;

  if(!var_4 && var_5 && isDefined(var_2) && var_2.ref_14306 > gettime() && var_2.ref_142f9 > gettime()) {
    var_2.ref_142f7 = gettime() + level.disable_super_in_turret.ref_142f6;
    return;
  }

  if(!var_4 && !var_5 && isDefined(var_2) && var_2.ref_142f7 > gettime()) {
    var_2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
    var_2.ref_14306 = gettime() + level.disable_super_in_turret.ref_142ff;
    return;
  }

  var_6 = var_5 && isDefined(var_2) && var_2.ref_142f9 <= gettime();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = var_4;
  var_10 = var_4;
  var_11 = undefined;

  switch (var_0) {
    case "forward":
      var_7 = "attack_securing" + var_2.iconname;
      var_8 = "defend_losing" + var_2.iconname;

      if(var_6) {
        var_10 = 1;
      }

      break;
    case "reverse":
      var_7 = "attack_losing" + var_2.iconname;
      var_8 = "defend_securing" + var_2.iconname;

      if(var_6) {
        var_9 = 1;
      }

      break;
    case "contested":
      var_7 = "attack_contested" + var_2.iconname;
      var_8 = "defend_contested" + var_2.iconname;

      if(var_6) {
        var_9 = 1;
      }

      break;
    case "blocked":
      var_7 = "attack_blocked" + var_2.iconname;
      break;
    case "obstacleRemoved":
      var_7 = "attack_obstacle" + var_2.iconname;
      var_8 = "defend_obstacle" + var_2.iconname;
      break;
    case "checkpoint":
      var_7 = "attack_secured" + var_1 + var_2.iconname;
      var_8 = "defend_lost" + var_1 + var_2.iconname;
      var_11 = 2;
      break;
    case "overtime":
      var_7 = "attack_overtime";
      var_8 = "defend_overtime";
      break;
    case "near":
      var_7 = "attack_near" + var_1 + var_2.iconname;
      var_8 = "defend_near" + var_1 + var_2.iconname;

      if(var_6) {
        var_10 = 1;
      }

      break;
    case "finished":
      var_7 = "attack_finished";
      var_8 = "defend_finished";
      break;
    case "stopped":
      var_7 = "attack_stopped";
      var_8 = "defend_stopped";
      break;
    default:
      return;
  }

  if(var_9) {
    thread watchweapondrop(var_7, game["attackers"], 1, var_11, undefined, 1);
  } else if(isDefined(var_7)) {
    thread watchweapondrop(var_7, game["attackers"], 1, var_11, undefined, 1, var_2);
  }

  if(var_10) {
    thread watchweapondrop(var_8, game["defenders"], 1, var_11, undefined, 1);
  } else if(isDefined(var_8)) {
    thread watchweapondrop(var_8, game["defenders"], 1, var_11, undefined, 1, var_2);
  }

  if(isDefined(var_2)) {
    var_2.ref_14307 = var_0;
    var_2.ref_142f7 = gettime() + level.disable_super_in_turret.ref_142f6;
    var_2.ref_14306 = gettime() + level.disable_super_in_turret.ref_14305;

    if(!var_5 || var_6) {
      var_2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
      return;
    }

    return;
  }
}

function watchweapondrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isarray(game["dialog"][var_0])) {
    for(var_7 = 0; var_7 < game["dialog"][var_0].size; var_7++) {
      var_8 = game["dialog"][var_0][var_7];

      if(isDefined(var_6)) {
        watchweapondeathordisconnect(var_8, var_1, var_6, var_3);
      } else {
        scripts\mp\gametypes\br_public::dmztut_luicallback(var_8, var_1, var_2, var_3, var_4, var_5);
      }

      waitframe();
    }

    return;
  }

  if(isDefined(var_6)) {
    watchweapondeathordisconnect(var_0, var_1, var_6, var_3);
    return;
  }

  scripts\mp\gametypes\br_public::dmztut_luicallback(var_0, var_1, var_2, var_3, var_4, var_5);
}

function ref_1332c(var_0) {
  switch (var_0) {
    case "obstacleRemoved":
    case "finished":
    case "checkpoint":
    case "stopped":
    case "overtime":
      return true;
    default:
      break;
  }

  return false;
}

function watchweapondeathordisconnect(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_7 = ref_12575(var_6);

    if(isDefined(var_7) && var_2 != var_7) {
      continue;
    }

    scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_6, 1, 1, var_3);
  }
}

function ref_1260a() {
  self endon("disconnect");

  if(istrue(self.ref_142f5)) {
    return;
  }

  self.ref_142f5 = 1;
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("payload_oob", self);
  wait 5;
  self.ref_142f5 = undefined;
}

function timelimitclock() {
  level endon("cancel_announcer_dialog");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(scripts\mp\utility\game::gettimelimit() == 0) {
      waitframe();
      continue;
    }

    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted)) {
      var_6 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var_7 = int(var_6 + 0.5);

      if(game["switchedsides"] && !isfinalpush()) {
        var_8 = scripts\mp\gamelogic::checkdefaultjiprules();

        if(!isDefined(level.nojip) || var_8 != level.nojip) {
          setnojiptime(var_8, var_8);
          level.nojip = var_8;
        }
      }

      var_9 = 0;

      if(var_5 == 2 && var_7 % 2 == 1) {
        var_9 = 1;
      }

      if(!var_0 && (var_9 == 1 && var_7 == 121 || var_9 == 0 && var_7 == 120)) {
        scripts\mp\gametypes\br_public::brleaderdialog("timesup_120", 0, undefined, 1);
        var_0 = 1;
      } else if(!var_1 && (var_9 == 1 && var_7 == 61 || var_9 == 0 && var_7 == 60)) {
        scripts\mp\gametypes\br_public::brleaderdialog("timesup_60", 0, undefined, 1);
        var_1 = 1;
      } else if(!var_2 && (var_9 == 0 && var_7 == 46 || var_9 == 1 && var_7 == 45)) {
        scripts\mp\gametypes\br_public::brleaderdialog("timesup_45", 0, undefined, 1);
        var_2 = 1;
      } else if(!var_3 && (var_9 == 1 && var_7 == 21 || var_9 == 0 && var_7 == 20)) {
        scripts\mp\gametypes\br_public::brleaderdialog("timesup_20", 0, undefined, 1);
        setmusicstate("br3_payload_20_sec_left");
        var_3 = 1;
      } else if(!var_4 && (var_9 == 1 && var_7 == 11 || var_9 == 0 && var_7 == 10)) {
        scripts\mp\gametypes\br_public::brleaderdialog("timesup_10", 0, undefined, 1);
        var_4 = 1;
      }

      if(var_7 <= 10 || var_7 <= 30 && var_7 % var_5 == var_9) {
        level notify("match_ending_very_soon");
        var_10 = 1;

        if(var_7 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var_6) {
          var_9 = 0;
        }

        if(var_9) {
          var_11 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_5);
          playsoundatpos((0, 0, 0), var_11);
        }
      }

      if(var_5 - floor(var_5) >= 0.05) {
        wait var_5 - floor(var_5);
        continue;
      }
    }

    wait 1;
  }
}

function technical_initdamage() {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }

  setomnvar("requires_scriptmover_ladder_checks", 1);
  ref_13231(level.disable_super_in_turret.getquestrewardstabletype, "buildable_checkpoint", "buildable_checkpoint_clipbrush", "checkpoint_01_anim", "iw8_br_payload_raise_bunker", &"BR_PAYLOAD/PURCHASE_BUNKER", &"BR_PAYLOAD/PURCHASE_BUNKER_DISABLED", level.disable_super_in_turret.getpropsize, "ui_mp_br_mapmenu_icon_bunker");
  ref_13231(level.disable_super_in_turret.ref_13c1a, "buildable_guardtower", "buildable_guardtower_clipbrush", "guardtower_01_anim", "iw8_br_payload_raise_tower", &"BR_PAYLOAD/PURCHASE_TOWER", &"BR_PAYLOAD/PURCHASE_TOWER_DISABLED", level.disable_super_in_turret.getquesttimefrac, "ui_mp_br_mapmenu_icon_tower");
  toggle_in_use();
}

function ref_13231(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStructArray(var_1, "targetname");
  }

  foreach(var_10 in var_0) {
    if(!isDefined(var_10.angles)) {
      var_10.angles = (0, 0, 0);
    }

    var_10.ref_11c75 = var_3;
    var_10.helistoreplunder = var_2;
    var_10.ref_13931 = var_1;
    var_10.ref_129f0 = var_4;
    var_10.ref_1293f = 0;
    var_11 = spawn("script_model", var_10.origin);
    var_11.angles = var_10.angles;
    var_11 setModel("tag_origin");
    var_11 hide();
    var_11.ref_14082 = var_5;
    var_11.price = var_7;
    var_11.loc = var_10;
    var_10.getquestrewardstablevaluecolumnindex = var_11;
    var_11.scriptable = spawn("script_model", var_10.origin);
    var_11.scriptable.angles = var_10.angles;
    var_11.scriptable setModel("military_hq_crate_02_payload");
    var_11.scriptable unmarkkeyframedmover(1);
    var_11.scriptable setscriptablepartstate("main", "idle");
    var_12 = var_11.scriptable;
    var_12.ref_14082 = var_6;
    var_12.price = var_7;
    var_12.loc = var_10;
    var_10.getquestrewardtier = var_12;
    var_10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(var_10.objidnum != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_10.objidnum, "active", var_10.origin);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_10.objidnum);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_10.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_10.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_10.objidnum, 0);
      scripts\mp\objidpoolmanager::update_objective_icon(var_10.objidnum, var_8);
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_10.objidnum, game["defenders"]);
      function_0421(var_10.objidnum, 1);
    }

    var_13 = 0;

    if(isDefined(var_10.script_group)) {
      var_13 = var_10.script_group;
    } else {
      var_10.script_group = var_13;
    }

    var_14 = respawndelayoverride(var_13);

    if(isDefined(var_14)) {
      var_15 = var_14.getquestscaledvalue.size;

      if(isDefined(var_10.script_index)) {
        var_15 = var_10.script_index;
      } else {
        var_10.script_index = var_15;
      }

      if(!isDefined(var_14.getquestscaledvalue[var_15])) {
        var_14.getquestscaledvalue[var_15] = [];
      }

      var_16 = var_14.getquestscaledvalue[var_15].size;
      var_14.getquestscaledvalue[var_15][var_16] = var_10;
    }
  }
}

function ref_1286a(var_0, var_1) {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }

  var_2 = var_0 - 1;
  scripts\mp\flags::gameflagwait("infil_complete");

  if(isDefined(var_1)) {
    if(var_0 > 0 && isDefined(var_1.getquestscaledvalue[var_2])) {
      foreach(var_4 in var_1.getquestscaledvalue[var_2]) {
        if(!istrue(var_4.ref_1293f)) {
          ref_1392d(var_4);
        }
      }
    }

    if(isDefined(var_1.getquestscaledvalue[var_0])) {
      foreach(var_7, var_4 in var_1.getquestscaledvalue[var_0]) {
        ref_1392e(var_4);
      }

      return;
    }

    return;
  }

  foreach(var_4 in level.disable_super_in_turret.paths) {
    if(var_6 > 0 && isDefined(var_4.getquestscaledvalue[var_7])) {
      foreach(var_4 in var_4.getquestscaledvalue[var_7]) {
        if(!istrue(var_4.ref_1293f)) {
          ref_1392d(var_4);
        }
      }
    }

    if(isDefined(var_4.getquestscaledvalue[var_6])) {
      foreach(var_4 in var_4.getquestscaledvalue[var_6]) {
        ref_1392e(var_4);
      }
    }
  }
}

function ref_13932() {
  var_0 = 5;
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death");
  self endon("makeStructureUnusable");
  self notify("structureWatchUse");
  self endon("structureWatchUse");
  var_1 = self;
  var_1 setCursorHint("HINT_NOICON");
  var_1 sethintonobstruction("show");
  var_1 setusepriority(-1);
  var_1 setuseholdduration("duration_none");
  var_1 setHintString(var_1.ref_14082);
  var_1 sethintstringparams(var_1.price);
  var_1.userate = 1;
  var_1.curprogress = 0;
  var_1.usetime = var_0;
  var_1.inuse = 0;
  var_1.playerusing = undefined;

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(ref_1392a(var_1, var_2)) {
      var_3 = int(var_1.price / 100);
      var_2 scripts\mp\gametypes\br_plunder::playersetplundercount(var_2.plundercount - var_3);
      ref_1361f(var_1.loc, var_2);
      return;
    }
  }
}

function ref_1392a(var_0) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 isonladder()) {
    return false;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()])) {
    return false;
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return false;
    }

    if(var_0.squadindex != self.squadindex || var_0.team != self.team) {
      return false;
    }
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return false;
    }

    if(var_0.team != self.team) {
      return false;
    }
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "botIsKillstreakSupported")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "grnd" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "botIsKillstreakSupported")]](self.cratetype)) {
          return false;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "isKillstreakBlockedForBots")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "isKillstreakBlockedForBots")]](self.cratetype)) {
        return false;
      }
    }
  }

  if(!self.isusable) {
    return false;
  }

  if(var_0 isskydiving()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(isDefined(self.playerusing) && self.playerusing != var_0) {
    return false;
  }

  var_1 = int(self.price / 100);

  if(var_0.plundercount < var_1) {
    return false;
  }

  return true;
}

function ref_1392e() {
  self.getquestrewardstablevaluecolumnindex show();
  self.getquestrewardstablevaluecolumnindex.isusable = 1;
  self.getquestrewardtier.isusable = 1;
  self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate("main", "idle");
  self.getquestrewardstablevaluecolumnindex makeusable();
  self.getquestrewardtier makeusable();
  var_0 = int(self.getquestrewardstablevaluecolumnindex.price / 100);
  var_1 = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");

  foreach(var_3 in var_1) {
    self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
    self.getquestrewardtier disableplayeruse(var_3);
    self.getquestrewardstablevaluecolumnindex disableplayeruse(var_3);
  }

  var_5 = scripts\mp\utility\teams::getteamdata(game["defenders"], "players");

  foreach(var_3 in var_5) {
    var_7 = isDefined(var_3.plundercount) && var_3.plundercount >= var_0;
    var_8 = !istrue(self.ref_1293f);

    if(var_8 && var_7 == 0) {
      self.getquestrewardstablevaluecolumnindex disableplayeruse(var_3);
      self.getquestrewardtier enableplayeruse(var_3);
      self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
      continue;
    }

    self.getquestrewardstablevaluecolumnindex enableplayeruse(var_3);
    self.getquestrewardtier disableplayeruse(var_3);

    if(var_8 && var_7) {
      self.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient(var_3, "outline_depth_cyan");
      continue;
    }

    self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
  }

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.getquestrewardstablevaluecolumnindex.loc.objidnum, game["defenders"]);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.getquestrewardstablevaluecolumnindex.loc.objidnum);
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.getquestrewardstablevaluecolumnindex.loc.objidnum, game["defenders"]);
  thread ref_13932();
  thread ref_13932();
}

function ref_1392d() {
  self.getquestrewardstablevaluecolumnindex notify("makeStructureUnusable");
  self.getquestrewardtier notify("makeStructureUnusable");
  self.getquestrewardstablevaluecolumnindex.isusable = 0;
  self.getquestrewardtier.isusable = 0;
  self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate("main", "idle");
  self.getquestrewardstablevaluecolumnindex makeunusable();
  self.getquestrewardtier makeunusable();
  ref_13930(self.getquestrewardstablevaluecolumnindex);
  ref_13930(self.getquestrewardtier);
  ref_1392b(self.getquestrewardstablevaluecolumnindex.scriptable);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.getquestrewardstablevaluecolumnindex.loc.objidnum);
  self.getquestrewardstablevaluecolumnindex hide();
}

function ref_13930() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");
  var_1 = scripts\mp\utility\teams::getteamdata(game["defenders"], "players");

  foreach(var_3 in var_1) {
    self enableplayeruse(var_3);
  }

  foreach(var_3 in var_0) {
    self disableplayeruse(var_3);
  }
}

function ref_1392b() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");
  var_1 = scripts\mp\utility\teams::getteamdata(game["defenders"], "players");

  if(var_0.size > 0) {
    self hudoutlinedisableforclients(var_0);
  }

  if(var_1.size > 0) {
    self hudoutlinedisableforclients(var_1);
    return;
  }
}

function ref_126e0() {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }

  if(self.team == game["defenders"]) {
    foreach(var_1 in level.disable_super_in_turret.getquestrewardstabletype) {
      ref_126df(var_1);
    }

    foreach(var_1 in level.disable_super_in_turret.ref_13c1a) {
      ref_126df(var_1);
    }

    return;
  }
}

function ref_126df(var_0) {
  if(var_0.ref_1293f == 0) {
    var_1 = int(var_0.getquestrewardstablevaluecolumnindex.price / 100);

    if(self.plundercount >= var_1) {
      var_0.getquestrewardstablevaluecolumnindex enableplayeruse(self);
      var_0.getquestrewardtier disableplayeruse(self);

      if(istrue(var_0.getquestrewardstablevaluecolumnindex.isusable)) {
        var_0.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient(self, "outline_depth_cyan");
        return;
      }

      return;
    }

    if(self.plundercount < var_1) {
      var_0.getquestrewardstablevaluecolumnindex disableplayeruse(self);
      var_0.getquestrewardtier enableplayeruse(self);
      var_0.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(self);
      return;
    }

    return;
  }
}

function ref_1361f(var_0, var_1) {
  var_0.ref_1293f = 1;
  var_2 = var_0.getquestrewardstablevaluecolumnindex;
  var_2 makeunusable();
  var_0.getquestrewardstablevaluecolumnindex = var_2;
  ref_1392f(var_2, var_1, var_0.ref_11c75, var_0.ref_129f0);
  var_3 = getEnt(var_0.helistoreplunder, "targetname");

  if(isDefined(var_3)) {
    var_4 = spawn("script_model", var_0.origin);
    var_4.angles = var_0.angles;
    var_4 clonebrushmodeltoscriptmodel(var_3);
    var_2.collision = var_4;
    var_5 = getentarrayinradius("player", "classname", var_0.origin, 500);

    foreach(var_1 in var_5) {
      if(!isalive(var_1)) {
        continue;
      }

      if(var_1 istouching(var_4)) {
        var_1 setOrigin(var_0.origin);
      }
    }
  }

  if(var_0.ref_13931 == "buildable_checkpoint") {
    thread flagwatchradarownerlost();
  } else if(var_0.ref_13931 == "buildable_guardtower") {
    ref_13c18(var_2, var_1);
  }

  return var_2;
}

function ref_1392f(var_0, var_1, var_2) {
  var_3 = 1.53;
  var_4 = anglesToForward(self.angles);
  var_5 = self.origin + var_4 * 50;
  var_6 = spawn("script_model", self.origin);
  var_6.angles = self.angles;
  var_6 setModel("generic_prop_x3");
  var_6 scriptmodelplayanim(var_2, "structure_reveal");
  var_6 scriptmodelpauseanim(1);
  self.scriptable delete();
  self setModel(var_1);
  self linkTo(var_6, "j_prop_1", (0, 0, 0), (0, 0, 0));
  self dontinterpolate();
  var_6 scriptmodelpauseanim(0);
  wait var_3;
  waitframe();
  var_6 delete();
}

function br_circle_closing_music(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_0 + (0, 0, 3000), var_0, (0, 0, 0), "payload_c130_loot", "inactive", undefined, 1);
  var_2.nevertimeout = 1;
  var_2 setotherent(var_1);
  var_2 waittill("collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  waitframe();
  var_2 scripts\cp_mp\killstreaks\airdrop::makecrateunusable();
  var_2 delete();
}

function run_techo_spawner(var_0, var_1, var_2) {
  if(!isDefined(var_0.getquestscaledvalue[var_1])) {
    return;
  }

  foreach(var_4 in var_0.getquestscaledvalue[var_1]) {
    if(var_4.ref_13931 == var_2 && !istrue(var_4.ref_1293f)) {
      return var_4;
    }
  }
}

function firesalediscount(var_0, var_1) {
  return fix_door_clip(var_0, var_1, "buildable_checkpoint");
}

function fix_wall_traversal(var_0, var_1) {
  return fix_door_clip(var_0, var_1, "buildable_guardtower");
}

function fix_door_clip(var_0, var_1, var_2) {
  var_3 = 25;
  var_4 = 26;
  var_5 = var_1.path;
  var_6 = level.disable_super_in_turret.getquestplunderrewardinstance;

  if(var_6 == 0 && var_0.team == game["attackers"]) {
    var_0 scripts\mp\gametypes\br_armory_kiosk::addtop3brcharge(var_3);
    return false;
  }

  if(var_0.team == game["attackers"]) {
    var_6--;
  }

  if(isDefined(var_5.getquestscaledvalue[var_6])) {
    var_7 = run_techo_spawner(var_5, var_6, var_2);

    if(isDefined(var_7)) {
      ref_1361f(var_7, var_0);
      return true;
    }
  }

  var_0 scripts\mp\gametypes\br_armory_kiosk::addtop3brcharge(var_4);
  return false;
}

function flagwatchradarownerlost() {
  level endon("game_ended");
  var_0 = (0, -30, 0);
  var_1 = (0, -90, 0);
  var_2 = rotatevector(var_0, self.angles);
  var_3 = self.origin + var_2;
  var_4 = spawnturret("misc_turret", var_3, "manual_turret_payload_mp", 0);
  var_4.angles = (0, self.angles[1], 0) + var_1;
  var_4 setModel("weapon_wm_mg_mobile_turret");
  var_4 setscriptablepartstate("hide_reticle", 1, 0);
  self.turret = var_4;
  var_5 = "j_trigger";
  var_6 = var_4 gettagorigin(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
    var_4.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_6, "HINT_BUTTON", undefined, &"BR_PAYLOAD/TURRET_MG", -1, "duration_none", undefined, 80, 60, 80, 60);
  }

  var_4.useownerobj linkTo(var_4, var_5);
  var_4 setdefaultdroppitch(0);
  var_4 setturretmodechangewait(1);
  var_4.maxhealth = 999999;
  var_4.health = var_4.maxhealth;
  var_4 makeunusable();

  for(;;) {
    var_4.useownerobj waittill("trigger", var_7);
    var_8 = var_7.origin;
    var_7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(0);
    var_7 disableturretdismount();
    var_4.owner = var_7;
    var_7 giveweapon("manual_turret_payload_mp", -1, 0, -1, 1);
    var_9 = var_7 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("manual_turret_payload_mp", 1);

    if(!istrue(var_9)) {
      if(isalive(var_7)) {
        var_7 enableturretdismount();
        var_7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(1);

        if(var_7 hasweapon("manual_turret_payload_mp")) {
          var_7 takeweapon("manual_turret_payload_mp");
        }

        var_7 scripts\mp\utility\inventory::switchtolastweapon();
      }

      continue;
    }

    var_4 setotherent(var_7);
    var_4 setentityowner(var_7);
    var_7 controlturreton(var_4);
    var_7 setclientomnvar("ui_mobile_turret_controls", 2);
    var_7 setplayerangles(var_4.angles);
    var_7 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(var_7, 0.5, 1);
    waitframe();

    while(var_7 useButtonPressed()) {
      waitframe();
    }

    while(isalive(var_7) && !var_7 useButtonPressed() && !var_7 isinexecutionvictim()) {
      waitframe();
    }

    if(isDefined(var_7)) {
      var_7 enableturretdismount();
      var_7 controlturretoff(var_4);
      var_7 setclientomnvar("ui_mobile_turret_controls", 0);
      var_7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(1);

      if(var_7 hasweapon("manual_turret_payload_mp")) {
        var_7 takeweapon("manual_turret_payload_mp");
      }

      var_7 scripts\mp\utility\inventory::switchtolastweapon();
      var_7 thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac7();
      var_7 setOrigin(var_8);
    }

    var_4.owner = undefined;
    var_4 setotherent(undefined);
    var_4 setentityowner(undefined);
    wait 0.5;
  }
}

function ref_13c18(var_0) {
  var_1 = 4;

  if(!isDefined(level.disable_super_in_turret.ref_129c6)) {
    level.disable_super_in_turret.ref_129c6 = [];
  }

  if(level.disable_super_in_turret.ref_129c6.size >= var_1) {
    var_2 = undefined;
    var_3 = undefined;

    foreach(var_5 in level.disable_super_in_turret.ref_129c6) {
      if(!isDefined(var_3) || var_5.ref_129c7 < var_3) {
        var_2 = var_6;
        var_3 = var_5.ref_129c7;
      }
    }

    level.disable_super_in_turret.ref_129c6[var_2] clearportableradar();
    level.disable_super_in_turret.ref_129c6[var_2] = undefined;
  }

  self.ref_129c7 = gettime();
  self makeportableradar(var_0);
  level.disable_super_in_turret.ref_129c6[self getentitynumber()] = self;
}

function ref_1225e() {
  level endon("game_ended");
  wait 1;

  if(!level.disable_super_in_turret.little_bird_mg_mp_spawncallback) {
    return;
  }

  var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_ascender", "classname");
  var_1 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_ascender_solo", "classname");
  var_2 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_ascender_soa_tower", "classname");
  var_3 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_ascender_solo_soa_tower", "classname");

  if(var_0.size) {
    foreach(var_5 in var_0) {
      if(var_5 getscriptablehaspart("ascender")) {
        var_5 setscriptablepartstate("ascender", "noprompt");
      }
    }
  }

  if(var_1.size) {
    foreach(var_5 in var_1) {
      if(var_5 getscriptablehaspart("ascender_solo")) {
        var_5 setscriptablepartstate("ascender_solo", "noprompt");
      }
    }
  }

  if(var_2.size) {
    foreach(var_5 in var_2) {
      if(var_5 getscriptablehaspart("ascender")) {
        var_5 setscriptablepartstate("ascender", "noprompt");
      }
    }
  }

  if(var_3.size) {
    foreach(var_5 in var_3) {
      if(var_5 getscriptablehaspart("ascender_solo")) {
        var_5 setscriptablepartstate("ascender_solo", "noprompt");
      }
    }

    return;
  }
}

function terminal_pusher_approach_array_counter() {
  if(!level.disable_super_in_turret.mine_caves_turret_1_support) {
    return;
  }

  var_0 = ["jeep", "tac_rover"];
  var_1 = 0;

  if(!isDefined(level.disable_super_in_turret.vehiclespawns)) {
    level.disable_super_in_turret.vehiclespawns = scripts\engine\utility::getStructArray("payload_vehicle_spawns", "script_noteworthy");
  }

  foreach(var_3 in level.disable_super_in_turret.vehiclespawns) {
    var_3.ref_1425c = var_3.script_parameters;

    if(!isDefined(var_3.ref_1425c)) {
      var_3.ref_1425c = var_0[var_1];
      var_1++;

      if(var_1 >= var_0.size) {
        var_1 = 0;
      }
    }

    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = var_3.script_index;
    var_5 = var_3.script_group;
    var_6 = respawndelayoverride(var_5);

    if(isDefined(var_6)) {
      var_7 = var_6.getquestreward_checkforvalueoverride[var_4];

      if(!isDefined(var_7.vehiclespawns)) {
        var_7.vehiclespawns = [];
      }

      var_8 = game["attackers"];

      if(var_3.targetname == "defender") {
        var_8 = game["defenders"];
      }

      if(!isDefined(var_7.vehiclespawns[var_8])) {
        var_7.vehiclespawns[var_8] = [];
      }

      var_9 = var_7.vehiclespawns[var_8].size;
      var_7.vehiclespawns[var_8][var_9] = var_3;
    }
  }
}

function spawninitialvehicles() {
  if(!scripts\mp\flags::gameflag("prematch_done") && !istrue(game["switchedsides"])) {
    scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
    return;
  }

  ref_136aa(1);
  thread ref_13639(game["attackers"]);
  thread ref_13639(game["defenders"]);
}

function ref_13639(var_0) {
  level endon("game_ended");
  level notify("spawnDrivableVehiclesTimer_" + var_0);
  level endon("spawnDrivableVehiclesTimer_" + var_0);
  var_1 = 2;
  var_2 = 1;

  foreach(var_4 in level.disable_super_in_turret.paths) {
    var_4.ref_11f48[var_0] = 0;
  }

  for(;;) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      var_7 = relic_amped_last_kill_time(var_4);

      if(var_7 < 0) {
        var_7 = 0;
      }

      var_8 = var_4.getquestreward_checkforvalueoverride[var_7];

      if(isDefined(var_8) && isDefined(var_8.vehiclespawns)) {
        var_9 = var_8.vehiclespawns[var_0];

        foreach(var_11 in var_9) {
          if(var_4.ref_11f48[var_0] >= var_1) {
            break;
          }

          if(istrue(var_11.inuse)) {
            goto LOC_0000012a;
          }

          var_12 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle(var_11.ref_1425c, var_11, "alwaysSpawn");
          jumpiffalse(isDefined(var_12)) LOC_0000012a;
          scripts\cp_mp\vehicles\vehicle_spawn::ref_14219(var_12);
          thread ref_14250(var_12, var_4, var_11);
        }
      }
    }

    var_2 = 0;
    wait level.disable_super_in_turret.ref_136ab;
  }
}

function ref_14250(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0.ref_11f48[var_2]++;
  var_1.inuse = 1;
  self waittill("death");
  var_0.ref_11f48[var_2]--;
  var_1.inuse = undefined;
}

function respawningbr(var_0, var_1) {
  var_2 = var_0.nodes[var_1].origin;
  jumpiffalse(var_1 + 1 < var_0.nodes.size) LOC_00000047;
  var_3 = var_0.nodes[var_1 + 1].origin;
  var_4 = var_3 - var_2;
  goto LOC_00000064;
}

function ref_132f6(var_0) {
  if(level.disable_super_in_turret.ref_1226a == "port" && var_0.label == "B" && var_0.getquestplunderrewardinstance == 0 || level.disable_super_in_turret.ref_1226a == "trainstation2" && var_0.label == "A" && var_0.getquestplunderrewardinstance == 1) {
    return true;
  }

  return false;
}

function getquestperkbonus(var_0) {
  var_1 = play_rooftop_success_vo(var_0, var_0.getquestplunderrewardinstance);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_5 = var_1[3];
  var_1 = undefined;
  thread init_relic_dogtags(var_0, var_2, var_4);
  thread init_relic_dogtags(var_0, var_3, var_4);
}

function play_rooftop_success_vo(var_0, var_1) {
  var_2 = 150;
  var_3 = 200;
  var_4 = 5;
  var_5 = 30;
  var_6 = 184;
  var_7 = var_2 - var_4;
  var_8 = 50;
  var_9 = var_0.getquestreward_checkforvalueoverride[var_1].ref_11ea5;
  var_10 = var_0.nodes[var_9].origin;
  var_11 = var_0.nodes[var_9].angles;
  var_12 = vectorNormalize(respawningbr(var_0, var_9));
  var_13 = vectortoangles(var_12);
  var_14 = anglestoright(var_13);
  var_15 = -1 * var_14;
  var_16 = var_10 + var_6 * var_12 + var_2 * var_14;
  var_17 = var_10 + var_6 * var_12 + var_2 * var_15;
  var_18 = 0;
  var_19 = 0;
  var_20 = var_2;

  while(var_20 <= var_3) {
    var_21 = var_10 + var_6 * var_12 + var_20 * var_14;
    var_22 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_21);
    var_23 = abs(var_10[2] - var_22[2]);
    var_24 = var_23 < var_5;

    if(var_24 && !var_19) {
      var_17 = var_22;
      var_19 = 1;
    }

    var_25 = var_10 + var_6 * var_12 + var_20 * var_15;
    var_26 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_25);
    var_27 = abs(var_10[2] - var_26[2]);
    var_28 = var_27 < var_5;

    if(var_28 && !var_18) {
      var_16 = var_26;
      var_18 = 1;
    }

    if(var_28 && var_24) {
      return [var_22, var_26, var_13, 1];
    }

    var_20 += var_4;
  }

  waitframe();

  if(!var_18 || !var_19) {
    var_20 = var_8;

    while(var_20 <= var_7) {
      if(!var_19) {
        var_21 = var_10 + var_6 * var_12 + var_20 * var_14;
        var_22 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_21);
        var_23 = abs(var_10[2] - var_22[2]);
        var_24 = var_23 < var_5;

        if(var_24) {
          var_17 = var_22;
          var_19 = 1;
        }
      }

      if(!var_18) {
        var_25 = var_10 + var_6 * var_12 + var_20 * var_15;
        var_26 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_25);
        var_27 = abs(var_10[2] - var_26[2]);
        var_28 = var_27 < var_5;

        if(var_28) {
          var_16 = var_26;
          var_18 = 1;
        }
      }

      if(var_18 && var_19) {
        break;
      }

      var_20 -= var_4;
    }
  }

  return [var_16, var_17, var_13, 0];
}

function init_relic_dogtags(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = (0, var_2[1], 0);
  var_3 setModel("vfx_br_payload_checkpoint");
  var_3 unmarkkeyframedmover(1);
  var_4 = "checkpoint";

  if(ref_132f6(var_0)) {
    var_4 = "checkpoint_ohcheck";
  }

  var_3 setscriptablepartstate("checkpoint", var_4);
  ref_1438d(var_0);
  var_3 setscriptablepartstate("checkpoint", "checkpoint_clear");
  wait 5;
  var_3 delete();
}

function ref_1438d(var_0) {
  var_0 waittill("checkPointUpdate");
}

function ref_125c3(var_0, var_1) {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self giveweapon(var_0);
  self setweaponammostock(var_0, 0);
  self setweaponammoclip(var_0, 0);
  scripts\mp\supers::allowsuperweaponstow();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0, 1);

  if(!istrue(var_2)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    } else {
      self takeweapon(var_0);
    }
  }

  var_1 notify("build_tool_ready");

  while(istrue(self.tuttxtbox)) {
    waitframe();

    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0)) {
      self.tuttxtbox = 0;
    }
  }

  var_1 show();
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  var_1 notify("build_complete");
}

function ref_125c0(var_0, var_1) {
  var_2 = self;
  level endon("payloadComplete");
  level endon("game_ended");
  var_2 endon("death_or_disconnect");

  if(var_2 isgestureplaying("iw8_ges_payload_build_barrier")) {
    return;
  }

  var_2 enableoffhandweapons();
  var_2 giveandfireoffhand(var_0);
  waitframe();

  if(!var_2 hasweapon(var_0)) {
    var_2 giveandfireoffhand(var_0);
    waitframe();
  }

  var_1 notify("build_tool_ready");

  while(istrue(var_2.tuttxtbox)) {
    waitframe();
  }

  self takeweapon(var_0);
  var_1 notify("build_complete");
}

function ref_1226d() {
  if(!istrue(level.disable_super_in_turret.ref_12272)) {
    return;
  }

  level endon("payloadComplete");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_13ac8 = [];
  level.ref_13ac8[game["attackers"]] = [];
  level.ref_13ac8[game["defenders"]] = [];
  level.ref_13abe = [];
  level.ref_13abe[game["attackers"]] = undefined;
  level.ref_13abe[game["defenders"]] = undefined;

  for(var_0 = 1;; var_0 = 0) {
    level waittill("checkPointUpdate", var_1);
    var_2 = int(max(relic_amped_monitor() - 1, 0));
    wait 3;
    var_3 = undefined;
    var_4 = undefined;

    if(istrue(level.disable_super_in_turret.ref_1226f) || istrue(level.disable_super_in_turret.ref_12273)) {
      var_5 = scripts\mp\gametypes\br_capshoot_quest::registermovequestlocale();
      var_3 = var_5[var_2 % var_5.size];
    }

    if(istrue(level.disable_super_in_turret.ref_12270) || istrue(level.disable_super_in_turret.ref_12273)) {
      var_6 = scripts\mp\gametypes\br_capshoot_quest::relic_nuketimer_playvo();
      var_4 = var_6[var_2 % var_6.size];
    }

    var_7 = level.disable_super_in_turret.ref_12271;

    if(istrue(level.disable_super_in_turret.ref_1226f)) {
      thread init_relic_bang_and_boom(var_1, var_7, game["attackers"], var_3, game["defenders"], var_4);

      if(var_0) {
        ref_13357(game["attackers"]);
      }
    }

    if(istrue(level.disable_super_in_turret.ref_12270)) {
      thread init_relic_bang_and_boom(var_1, var_7, game["defenders"], var_4, game["attackers"], var_3);

      if(var_0) {
        ref_13357(game["defenders"]);
      }
    }

    if(var_0) {}
  }
}

function init_relic_bang_and_boom(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify("create_quest_tablets");
  level endon("create_quest_tablets");

  for(var_6 = 0; var_6 < var_1; var_6++) {
    init_relic_amped(var_0, var_2, var_3, var_4, var_5);
  }
}

function init_relic_amped(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  var_5 = -600;
  var_6 = -300;
  var_7 = 15;
  var_8 = var_0;

  if(istrue(var_0.hidesmokinggunhudfromplayer)) {
    var_8 = respawn_enemies(var_0);
  }

  var_9 = undefined;

  if(isDefined(var_8.idle_sfx)) {
    var_9 = var_8.idle_sfx;
  } else {
    var_9 = var_8.vehicle;
  }

  if(isDefined(var_9)) {
    var_10 = randomfloatrange(-1 * var_7, var_7);
    var_11 = (0, var_9.angles[1] + var_10, 0);
    var_12 = anglesToForward(var_11);
    var_13 = randomfloatrange(var_5, var_6);
    var_14 = var_9.origin + var_12 * var_13;
    var_15 = ref_1361c(var_14, var_1, var_2, var_3, var_4);
    var_15.path = var_8;
    return;
  }
}

function ref_1361c(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 20;
  var_6 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0);
  var_6 += (0, 0, var_5);
  var_7 = scripts\mp\gametypes\br_quest_util::ref_135df(var_2, var_6);

  if(isDefined(var_7)) {
    var_7.team = var_1;

    if(van_infil_sfx_chief()) {
      var_7.ref_12395 = &play_reset_sequences;
    }

    if(istrue(level.disable_super_in_turret.ref_12273)) {
      var_7.ref_12157 = &registerscriptableinstance;
      var_7.otherteam = var_3;
      var_7.ref_12158 = var_4;
    }

    scripts\mp\gametypes\br_pickups::ref_12b3a(var_7);
  }

  return var_7;
}

function play_reset_sequences(var_0, var_1) {
  var_2 = var_1.path;

  if(!van_infil_sfx_chief() || !isDefined(var_2)) {
    return undefined;
  }

  level.disable_super_in_turret.ref_1297a = var_2;
  var_3 = scripts\engine\utility::array_sort_with_func(level.disable_super_in_turret.ref_12979, &ammorestock_used);
  level.disable_super_in_turret.ref_1297a = undefined;
  var_4 = var_3[0];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_7 = 0;

    foreach(var_9 in var_2.ref_136c3[var_0.team]) {
      if(isDefined(var_9.trigger) && ispointinvolume(var_6.origin, var_9.trigger)) {
        continue;
      }

      if(isDefined(var_9.ref_14427) && ispointinvolume(var_6.origin, var_9.ref_14427)) {
        continue;
      }

      var_7 = 1;
    }

    if(!istrue(var_7)) {
      continue;
    }

    var_4 = var_6;
    break;
  }

  var_11 = spawnStruct();
  var_11.origin = var_4.origin;
  var_11.angles = var_4.angles;
  var_11.spawnflags = 16;
  var_11.ref_12978 = var_4;
  return var_11;
}

function registerscriptableinstance(var_0) {
  var_1 = var_0.otherteam;
  var_2 = var_0.path;

  if(!isDefined(var_1) || !isDefined(var_2) || !isDefined(var_2.vehicle)) {
    return undefined;
  }

  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.squaddata[var_1]) {
    var_7 = 0;
    var_8 = var_6.players.size;

    if(var_8 > 0) {
      foreach(var_10 in var_6.players) {
        var_7 += distancesquared(var_10.origin, var_2.vehicle.origin);
      }

      var_7 /= var_8;

      if(!istrue(var_4) || var_7 > var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3) && var_3.players.size > 0) {
    return var_3.players[0];
  }

  return undefined;
}

function ref_13357(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 thread scripts\mp\hud_message::showsplash("br_capshoot_quest_first_tablet_alert");
    }
  }
}

function van_infil_sfx_chief() {
  return isDefined(level.disable_super_in_turret.ref_12979) && level.disable_super_in_turret.ref_12979.size > 0;
}

function ammorestock_used(var_0, var_1) {
  var_2 = level.disable_super_in_turret.ref_1297a;
  var_3 = var_2.vehicle.origin;
  return distancesquared(var_0.origin, var_3) < distancesquared(var_1.origin, var_3);
}

function ref_13181(var_0) {
  ref_13156("current_player_path_assignment", var_0);
}

function ref_13184(var_0) {
  ref_13156("current_player_team_assignment", var_0);
}

function ref_13182(var_0) {
  ref_13156("current_player_respawn", var_0);
}

function ref_13183(var_0) {
  ref_13156("current_player_tacmap", var_0);
}

function ref_13185(var_0) {
  ref_13156("in_cinematic_controls_locked", var_0);
}

function ref_1318b(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "number_of_teammates_on_path_b", "number_of_teammates_on_path_a");
  ref_13157(var_2, var_1);
}

function ref_13190(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "path_b_state", "path_a_state");
  ref_13157(var_2, var_1);
}

function ref_1318a(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "path_b_checkpoints_complete", "path_a_checkpoints_complete");
  ref_13157(var_2, var_1);
}

function ref_13189(var_0) {
  var_1 = int(var_0 / 100);
  var_1 = scripts\engine\utility::ter_op(var_1 <= 0, 0, var_1);
  ref_13157("last_chance_time", var_1);
}

function ref_13188(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  ref_13157("last_chance_max_time", var_0);
}

function ref_1318e(var_0) {
  ref_13157("payload_timer_initialized", var_0);
}

function ref_11aa2(var_0) {
  var_1 = 0;

  if(var_0 >= 0.999) {
    var_1 = 10000;
  } else if(var_0 > 0) {
    var_1 = int(var_0 * 10000);
  }

  return var_1;
}

function ref_1318f(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "path_b_percent_complete", "path_a_percent_complete");
  var_3 = ref_11aa2(var_1);
  ref_13157(var_2, var_3);
}

function ref_1318c(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0 == 1, "path_b_obstacle_state", "path_a_obstacle_state");
  var_4 = scripts\engine\utility::ter_op(var_2 == 1, 1, 0);
  ref_13157(var_3, var_4, var_1);
}

function ref_13157(var_0, var_1, var_2) {
  var_3 = reload_use_trigger(var_0, var_1);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_1 = var_3[3];
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_4 += var_2;
  }

  if(var_6 == "") {
    return;
  }

  ref_1260e(var_6, var_1, var_4, var_5);
}

function ref_13156(var_0, var_1) {
  var_2 = reload_use_trigger(var_0, var_1);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_1 = var_2[3];
  var_2 = undefined;

  if(var_5 == "") {
    return;
  }

  ref_1260d(var_5, var_1, var_3, var_4);
}

function reload_use_trigger(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  switch (var_0) {
    case "current_player_path_assignment":
      var_5 = [0, 1];
      var_2 = var_5[0];
      var_3 = var_5[1];
      var_5 = undefined;
      var_4 = "ui_br_payload_data_client";
      break;
    case "current_player_team_assignment":
      var_6 = [1, 1];
      var_2 = var_6[0];
      var_3 = var_6[1];
      var_6 = undefined;
      var_4 = "ui_br_payload_data_client";
      break;
    case "current_player_respawn":
      var_7 = [2, 1];
      var_2 = var_7[0];
      var_3 = var_7[1];
      var_7 = undefined;
      var_4 = "ui_br_payload_data_client";
      break;
    case "in_cinematic_controls_locked":
      var_8 = [3, 1];
      var_2 = var_8[0];
      var_3 = var_8[1];
      var_8 = undefined;
      var_4 = "ui_br_payload_data_client";
      break;
    case "current_player_tacmap":
      var_9 = [4, 1];
      var_2 = var_9[0];
      var_3 = var_9[1];
      var_9 = undefined;
      var_4 = "ui_br_payload_data_client";
      break;
    case "number_of_teammates_on_path_a":
      var_10 = [0, 6];
      var_2 = var_10[0];
      var_3 = var_10[1];
      var_10 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "number_of_teammates_on_path_b":
      var_11 = [6, 6];
      var_2 = var_11[0];
      var_3 = var_11[1];
      var_11 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "path_a_state":
      var_12 = [12, 3];
      var_2 = var_12[0];
      var_3 = var_12[1];
      var_12 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "path_b_state":
      var_13 = [15, 3];
      var_2 = var_13[0];
      var_3 = var_13[1];
      var_13 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "path_a_checkpoints_complete":
      var_14 = [18, 2];
      var_2 = var_14[0];
      var_3 = var_14[1];
      var_14 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "path_b_checkpoints_complete":
      var_15 = [20, 2];
      var_2 = var_15[0];
      var_3 = var_15[1];
      var_15 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "last_chance_time":
      var_16 = [22, 10];
      var_2 = var_16[0];
      var_3 = var_16[1];
      var_16 = undefined;
      var_4 = "ui_br_payload_data";
      break;
    case "path_a_obstacle_state":
      var_17 = [0, 1];
      var_2 = var_17[0];
      var_3 = var_17[1];
      var_17 = undefined;
      var_4 = "ui_br_payload_data_2";
      break;
    case "path_b_obstacle_state":
      var_18 = [10, 1];
      var_2 = var_18[0];
      var_3 = var_18[1];
      var_18 = undefined;
      var_4 = "ui_br_payload_data_2";
      break;
    case "last_chance_max_time":
      var_19 = [20, 3];
      var_2 = var_19[0];
      var_3 = var_19[1];
      var_19 = undefined;
      var_4 = "ui_br_payload_data_2";
      break;
    case "payload_timer_initialized":
      var_20 = [23, 1];
      var_2 = var_20[0];
      var_3 = var_20[1];
      var_20 = undefined;
      var_4 = "ui_br_payload_data_2";
      break;
    case "path_a_percent_complete":
      var_21 = [0, 16];
      var_2 = var_21[0];
      var_3 = var_21[1];
      var_21 = undefined;
      var_4 = "ui_br_payload_percents";
      break;
    case "path_b_percent_complete":
      var_22 = [16, 16];
      var_2 = var_22[0];
      var_3 = var_22[1];
      var_22 = undefined;
      var_4 = "ui_br_payload_percents";
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

function ref_1260d(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7) {
    self setclientomnvar(var_0, var_9);
    return;
  }
}

function ref_1260e(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = getomnvar(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7) {
    setomnvar(var_0, var_9);
    return;
  }
}

function ref_12258() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
    wait 7.66667;
    thread ref_12257();
    return;
  }

  wait 6;
  thread ref_12257();
  scripts\mp\flags::gameflagwait("infil_complete");
  wait randomintrange(20, 25);
  thread ref_12257();
}

#using_animtree("script_model");

function ref_12257() {
  level endon("game_ended");
  var_0 = [];
  var_1 = undefined;
  var_2 = level.disable_super_in_turret.ref_1226a;
  var_3 = [];
  var_4 = 1.2;

  switch (var_2) {
    case "port":
      var_0 = (38775, -23332, 197);
      var_0 = (33582, -25827, -278);
      var_1 = 255;
      break;
    case "trainstation2":
      var_0 = (-9592, -17688, -360);
      var_0 = (-7456, -20160, 592);
      var_1 = 15;
      break;
    case "downtown2":
      var_0 = (24012, -22726, 371);
      var_0 = (21811, -18619, 784);
      var_1 = 60;
      break;
    case "standard":
      var_0 = (0, 0, 0);
      var_1 = 0;
      break;
    case "livingquarters":
      var_0 = (-17, -7150.75, 707.5);
      var_0 = (-1349.5, -7417, 640.75);
      var_0 = (-1654.75, -6373.75, 701);
      var_1 = 170;
      break;
    case "chemicaleng":
      var_0 = (1281.5, 4766.75, 830.25);
      var_0 = (1323.5, 3293.75, 948.25);
      var_0 = (269.5, 3797.75, 1199.25);
      var_1 = 270;
      break;
    case "shore":
      var_0 = (-3363, 3374.75, 616.75);
      var_0 = (-4397, 3984.75, 615);
      var_0 = (-2523.5, 5642, 879.25);
      var_1 = 65;
      break;
    default:
      break;
  }

  var_5 = spawnStruct();
  var_5.streakname = "precision_airstrike";
  var_5.owner = play_random_sound_event();
  var_5.score = 0;
  var_5.shots_fired = 0;
  var_5.hits = 0;
  var_5.damage = 0;
  var_5.kills = 0;
  var_5.setuptimelimit = 0;
  var_5.brmini_ontimelimit = 0;
  var_6 = undefined;
  var_7 = % mp_alfa10_flyin;
  var_8 = undefined;
  var_9 = 24000;
  var_10 = 6500;
  var_11 = 1000;
  var_12 = 1500;

  if(getdvarint("scr_br_alt_mode_mini", 0) > 0) {
    var_5.setuptimelimit = 1;
    var_11 = 1200;
  }

  var_13 = 215;
  var_14 = (0, var_1, 0);
  var_15 = undefined;
  var_16 = play_random_sound_event();

  if(isDefined(var_16) && istrue(var_0.size > 0)) {
    for(var_17 = 0; var_17 < var_0.size; var_17++) {
      var_18 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0[var_17], var_14, var_9, 1, var_11, var_10, var_12, var_5.streakname, var_15);
      wait var_4;
      var_11 += randomintrange(200, 300);
      level thread scripts\cp_mp\killstreaks\airstrike::doplanestrike(var_0[var_17], var_18["startPoint"], var_18["endPoint"], var_11, var_6, var_5, var_7, var_5.owner, var_8);

      if(var_17 == 0 && getdvarint("scr_br_alt_mode_mini", 0) > 0) {
        thread onteammatereviveweapontaken(level, var_2);
      }
    }

    if(getdvarint("scr_br_alt_mode_mini", 0) == 0) {
      thread onteammatereviveweapontaken(level, var_2);
      return;
    }

    return;
  }
}

function onteammatereviveweapontaken(var_0, var_1) {
  level endon("game_ended");
  wait 5;

  switch (var_0) {
    case "port":
      scripts\engine\utility::exploder("pl_intro_exp_docks");
      wait var_1 - 1;
      scripts\engine\utility::exploder("pl_intro_exp_docks2");
      break;
    case "trainstation2":
      wait 0.5;
      scripts\engine\utility::exploder("pl_intro_exp_trnstn");
      wait var_1 - 0.7;
      scripts\engine\utility::exploder("pl_intro_exp_trnstn2");
      break;
    case "downtown2":
      wait var_1 - 1;
      scripts\engine\utility::exploder("pl_intro_exp_dwtn");
      scripts\engine\utility::exploder("pl_intro_exp_dwtn2");
      break;
    case "livingquarters":
      wait 2.5;
      scripts\engine\utility::exploder("pl_intro_exp_livingquarters_01");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_livingquarters_02");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_livingquarters_03");
      break;
    case "chemicaleng":
      wait 2.5;
      scripts\engine\utility::exploder("pl_intro_exp_chemicaleng_01");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_chemicaleng_02");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_chemicaleng_03");
      break;
    case "shore":
      wait 2.5;
      scripts\engine\utility::exploder("pl_intro_exp_shore_01");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_shore_02");
      wait var_1;
      scripts\engine\utility::exploder("pl_intro_exp_shore_03");
      break;
    case "standard":
      scripts\engine\utility::exploder("pl_intro_exp_1");
      break;
    default:
      break;
  }
}

function play_random_sound_event() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(isalive(var_2) && var_2.team == game["attackers"]) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

function startspectatorview() {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  scripts\mp\gametypes\br_spectate::ref_1252a();

  if(isbot(self)) {
    return;
  }

  thread ref_12535();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  ref_13182(1);
  waitframe();
  var_0 = respawntokenclosewithgulag();

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self cameralinkTo(var_0, "tag_origin", 1);
  self visionsetthermalforplayer("ac130_color");
  self thermalvisionon();
  self playlocalsound("mp_cmd_camera_zoom_out");
  self setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self waittill("spawnChoice");
  self clearclienttriggeraudiozone(0.5);
}

function ref_13fd8(var_0, var_1, var_2, var_3) {
  self unlink();
  var_4 = self.origin;
  var_5 = self.angles;
  var_6 = 0;

  if(var_1[0] != var_4[0]) {
    self moveTo(var_1, 0.1);
    var_6 = 1;
  }

  if(istrue(var_6)) {
    var_7 = anglesToForward(var_2) * 300;
    var_7 *= (1, 1, 0);
    var_0 earthquakeforplayer(0.03, 15, var_1 + var_7, 1000);
  }

  thread x1fin_think(var_3);
}

function x1fin_think(var_0) {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("death");
  self waittill("movedone");

  if(isDefined(var_0)) {
    self linkTo(var_0);
    return;
  }
}

function ref_139d8(var_0) {
  if(isDefined(self.play_nuclear_core_vo) && isDefined(self.ref_12204) && !isbot(self)) {
    var_1 = ref_12574(var_0);
    var_2 = var_1[0];
    var_3 = var_1[1];
    var_4 = var_1[2];
    var_1 = undefined;
    ref_13fd8(self.play_nuclear_core_vo, self, var_2, var_3, var_4);
    return;
  }
}

function ref_12574(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.ref_12204)) {
      var_0 = self.ref_12204;
    } else {
      var_0 = level.disable_super_in_turret.paths[0];
    }
  }

  var_1 = var_0.label;
  var_2 = 0;

  if(var_1 != "A") {
    var_2 = 1;
  }

  var_3 = respawnheightoverride(var_2);
  var_4 = var_3.vehicle;
  var_5 = 88;
  var_6 = var_4.angles[1];
  var_7 = anglesToForward((0, var_6, 0));
  var_8 = 500;
  var_9 = 5000;
  var_10 = (var_4.origin[0] + var_7[0] * var_8, var_4.origin[1] + var_7[1] * var_8, var_9);
  var_11 = (var_5, var_6, 0);

  if(self.team == game["defenders"]) {
    var_11 = (var_5, var_6 + 180, 0);
  }

  return [var_10, var_11, var_4];
}

function respawntokenclosewithgulag() {
  if(isDefined(self.play_nuclear_core_vo)) {
    return self.play_nuclear_core_vo;
  }

  var_0 = ref_12575();
  var_1 = ref_12574(var_0);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_1 = undefined;
  var_5 = spawn("script_model", var_2);
  var_5.angles = var_3;
  var_5 setModel("tag_origin");
  var_5 hide();
  var_5 unmarkkeyframedmover(1);
  var_5 showtoplayer(self);
  self.play_nuclear_core_vo = var_5;
  return self.play_nuclear_core_vo;
}

function ref_126bb() {
  var_0 = ref_12575();
  var_1 = ref_12574(var_0);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_1 = undefined;
  scripts\mp\gametypes\br_public::ref_126b9(var_2);
}

function ref_125e7() {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("disconnect");
  self waittill("playerPrestreamComplete");
  wait 2;
  thread scripts\mp\spawncamera::startoperatorsound();
  waitframe();

  if(isDefined(self.ref_12135)) {
    self.ref_12135.origin = self.origin + (0, 0, 80);
    self.ref_12135 linkTo(self);
  }

  scripts\mp\flags::gameflagwait("infil_complete");

  if(isDefined(self.ref_12135)) {
    self clearsoundsubmix("iw8_mp_spawn_camera");
    self.ref_12135 unlink();
    self.ref_12135 stoploopsound(self.ref_12136);
    self.ref_12135 delete();
    self.ref_12135 = undefined;
    self.ref_12136 = undefined;
    return;
  }
}

function ref_12535() {
  level endon("payloadComplete");
  level endon("game_ended");
  self endon("disconnect");
  thread scripts\mp\spawncamera::startoperatorsound();
  waitframe();

  if(isDefined(self.ref_12135)) {
    self.ref_12135.origin = self.origin + (0, 0, 80);
    self.ref_12135 linkTo(self);
    return;
  }
}

function tomastrike_isflyingvehicle() {
  if(!isDefined(level.disable_super_in_turret.ref_12eac)) {
    var_0 = [];

    foreach(var_2 in level.disable_super_in_turret.paths) {
      var_0 = ref_13697("ee_machinery_satellite_solarpanel_04_dmg_payload_ch3", var_2.initchallengeandeventglobals, 0, "satellite_solarpanel_col");
      var_0 = ref_13697("ee_machinery_satellite_solarpanel_04_dmg_payload_ch3", var_2.initchallengeandeventglobals, 1, "satellite_solarpanel_col");
      var_0 = ref_13697("ee_machinery_satellite_panel_01_payload_ch3", var_2.initchallengeandeventglobals, 2, "satellite_panel_col");
    }

    level.disable_super_in_turret.ref_12eac = var_0;
  }

  var_4 = getEnt("payload_satellite_clipbrush", "script_noteworthy");

  if(isDefined(var_4)) {
    var_4 delete();
  }

  foreach(var_2 in level.disable_super_in_turret.paths) {
    foreach(var_7 in level.disable_super_in_turret.ref_12eac) {
      if(var_7.script_group == var_2.initchallengeandeventglobals) {
        var_8 = var_7;

        if(!isent(var_8)) {
          var_8 = ref_13697(var_7.model, var_7.script_group, var_7.script_index + 1);
        }

        var_2.pieces[var_2.pieces.size] = var_8;
      }
    }

    var_2.ref_12358 = ref_13697("ee_machinery_satellite_thruster_module_nopanel_dmg_payload");
  }
}

function ref_13697(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.script_group = var_1;
  var_4.script_index = var_2;

  if(isDefined(var_3)) {
    var_5 = getEnt(var_3, "targetname");

    if(isDefined(var_5)) {
      var_6 = spawn("script_model", var_4.origin);
      var_6.angles = var_4.angles;
      var_6 clonebrushmodeltoscriptmodel(var_5);
      var_6 linkTo(var_4);
    }
  }

  var_4 hide();
  return var_4;
}

function rocket_fuel_x1(var_0, var_1) {
  foreach(var_3 in var_0.pieces) {
    if(var_3.script_index == var_1) {
      return var_3;
    }
  }
}

function ref_1326a(var_0, var_1) {
  if(var_1 > 0) {
    var_2 = rocket_fuel_x1(var_0, var_1);
    ref_13dec(var_0.idle_sfx, var_2, var_1);
    return;
  }
}

function ref_13dec(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = (0, 0, 0);
  var_3 = (0, 0, 0);

  switch (var_1) {
    case 0:
      var_3 = (-41.3, -9.2, 106.1);
      break;
    case 1:
      var_3 = (-23.7, 40.8, 127.1);
      var_2 = (0, 2, -80);
      break;
    case 2:
      var_3 = (-70.7, 40.8, 127.1);
      var_2 = (0, 2, -80);
      break;
    case 3:
      var_3 = (9.7, -1.8, 100.1);
      var_2 = (0, -90, -84);
      break;
    default:
      break;
  }

  var_0 show();
  var_0 linkTo(self, "tag_origin", var_3, var_2);
}

function delay_start_escort_enter_vehicle_objective() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_mode_payload_sfx");
  setglobalsoundcontext("gamemode", "payload");
}

function ref_11e11() {
  level endon("stop_overtime");
  var_0 = 0;
  var_1 = respawn_trigger_think();

  for(;;) {
    var_2 = respawn_trigger_think();

    if(var_2 > var_1) {
      if(var_0 >= 10) {
        foreach(var_4 in level.players) {
          var_4 playlocalsound("mus_payload_overtime_hit");
        }
      }

      var_0 = 0;
    } else if(var_2 == var_1) {
      var_0 += 1;
    }

    var_1 = var_2;
    waitframe();
  }
}

function ref_11e12() {
  while(isDefined(level.allowmeleevehicledamage) == 1) {
    foreach(var_1 in level.players) {
      var_2 = isDefined(var_1.allowmodestructs);

      if(var_2 == 0) {
        var_1 setplayermusicstate("br3_payload_overtime_suspense");
        var_1 playlocalsound("mus_payload_overtime_hit");
        var_1.allowmodestructs = 1;
      }
    }

    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = isDefined(var_1.allowmodestructs);

    if(var_2 == 1) {
      var_1 setplayermusicstate("br3_payload_overtime_slam");
      var_1.allowmodestructs = undefined;
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(4.5);

  foreach(var_1 in level.players) {
    var_1 setplayermusicstate("");
  }
}

function ref_11e10() {
  for(;;) {
    level waittill("start_overtime");
    level.allowmeleevehicledamage = 1;
    thread ref_11e12();
    thread ref_11e11();
    level waittill("stop_overtime");
    waittillframeend();
    level.allowmeleevehicledamage = undefined;
  }
}

function ref_12804(var_0) {
  thread ref_126e0();
}

function ref_12aa5() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    if(!isDefined(var_1) || !isDefined(var_1.vehicle)) {
      continue;
    }

    var_2 = var_1.vehicle;
    ref_1425b(var_2);
    getentitylessscriptablearray("dlog_event_br_payload_game_end", ["path_name", level.disable_super_in_turret.ref_1226a, "path_index", var_1.script_index, "total_push_distance", ref_14244(var_2), "longest_push_distance", var_1.ref_119d6, "total_push_time", var_1.ref_13bf5, "checkpoints_completed", var_1.getquestplunderrewardinstance, "obstacles_destroyed", var_1.ref_11f9f]);
  }
}