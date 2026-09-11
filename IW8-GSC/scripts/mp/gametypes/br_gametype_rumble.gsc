/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_rumble.gsc
*******************************************************/

function activate_c4_for_pick_up() {}

function activate_laser_trap_parent() {}

function init() {
  table_getrole();
}

function table_getrole() {
  tarmac_techo_start();
  init_locations();
  subwave_progression();
  ref_119f0();
  scripts\mp\utility\sound::besttime("mp_tu_canteen_sfx");
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["small_snowhit"] = loadfx("vfx/core/impacts/small_snowhit");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("playerCountLandmarks");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("c130PlaneLine");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowEndGameXPBonus");
  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::ref_12b11("lastStandAllowed", &watch_flight_collision);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &relic_steelballs_health_boost);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &relic_steelballs_health_boost);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &being_hacked);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &init_relic_aggressive_melee);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &playerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("gulagWinnerRespawn", &gulagwinnerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipInfilSequence", &ref_133d6);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnInitialVehicles", &ref_13570);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addDropOnPlayerDeath", &battle_tracks_hidetogglewidget);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addSpawnLootContents", &beaker_end_time);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("endGame", &defenderflag_starts);
  scripts\mp\gametypes\br_gametypes::ref_12b11("delayedShowTablets", &ks_airdropcratearmor);
  scripts\mp\gametypes\br_gametypes::ref_12b11("calculateBRBonusXP", &forceunsetdemeanor);
  _keypadscriptableused_bunkeralt::init();
  _ispointinbadarea::init();
  _initignoredtabspergamemode::init();
  _keypadscriptableused::init();
  setDvar("LKTPRPKPMR", 1);
  setDvar("LOSOOOTNMS", 0);
  setDvar("NNMLSMNTOQ", -1);
  thread table_getaddblueprintattachments();
}

function tarmac_techo_start() {
  level.endgametutorial_func = spawnStruct();
  level.endgametutorial_func.ref_13376 = getdvarint("scr_brRumble_showTeammateOutlineShader", 0);
  level.endgametutorial_func.juggheli_spawner_jammer5_3 = getdvarint("scr_brRumble_tacmap_zoom", 12000);
  level.endgametutorial_func.ref_13903 = getDvar("scr_brRumble_location_override", "random");
  level.endgametutorial_func.spawnrope = getdvarint("scr_brRumble_default_spawn_height", 3000);
  level.endgametutorial_func.ref_127b6 = getdvarfloat("scr_brRumble_plunderDropPercent", 0);
  level.endgametutorial_func.ref_127b5 = getdvarfloat("scr_brRumble_plunderDropAmount", 5);
  level.endgametutorial_func.ref_127be = getdvarfloat("scr_brRumble_plunderKeepPercent", 1);
  level.endgametutorial_func.spin_fan_blades = getdvarint("scr_brRumble_points_per_kill", 1);
  level.endgametutorial_func.spawnwalltriggers = getdvarint("scr_brRumble_killmonger_kill_bonus", 1);
  level.endgametutorial_func.spawnvehicles = getdvarint("scr_brRumble_killing_killmonger_bonus", 3);
  level.endgametutorial_func.spectatingthisplayer = getdvarint("scr_brRumble_points_for_quest_completion", 1);
  level.endgametutorial_func.spawnrisktoken = getdvarint("scr_brRumble_comeback_mechanics_enabled", 1) == 1;
  level.endgametutorial_func.spawnpointdangertime = getdvarint("scr_brRumble_allow_quad_points", 1);
  level.endgametutorial_func.spreadshotdamagemod = getdvarint("scr_brRumble_xp_per_kill", 125);
  level.endgametutorial_func.sprayed = getdvarint("scr_brRumble_xp_per_assist", 25);
  level.endgametutorial_func.sprayid = getdvarint("scr_brRumble_xp_per_cache_open", 100);
  level.endgametutorial_func.sprint_hint = getdvarint("scr_brRumble_xp_per_minute", 300);
  level.endgametutorial_func.spoutfx = getdvarint("scr_brRumble_xp_for_win", 5000);
  level.endgametutorial_func.spotlimit = getdvarint("scr_brRumble_xp_for_loss", 3000);
  level.endgametutorial_func.parachuteoverheadwarningradius = getdvarfloat("scr_brRumble_questTabletReplaceTime", 450);
  level.endgametutorial_func.spotlight_sweep_to_loc = getdvarint("scr_brRumble_questTabletMaxSpawnPerSide", 10);
  level.endgametutorial_func.spotlight_speed = getdvarint("scr_brRumble_questTabletMaxSpawnNeutral", 5);
  level.endgametutorial_func.spin_light = getdvarint("scr_brRumble_quests_tablet_neutral_distance", 1000);
  level.endgametutorial_func.spotlight_reach_goal_node_dist_sq = getdvarint("scr_brRumble_tablet_min_distance_to_gas", 2000);
  level.endgametutorial_func.player_complete_trial = getdvarint("scr_brRumble_first_pe_dom_only", 1);
  level.endgametutorial_func.ref_122cb = getdvarint("scr_brRumble_pe_hvt_event_available", 0);
  level.endgametutorial_func.maphints = getdvarint("scr_brRumble_pe_dom_radius", 750);
  level.endgametutorial_func.ref_122a1 = getdvarint("scr_brRumble_pe_dom_capture_time", 45);
  level.endgametutorial_func.manualturret_watchturretusetimeout = getdvarfloat("scr_brRumble_pe_dom_stompRate", 2);
  level.endgametutorial_func.ref_122d0 = getdvarint("scr_brRumble_pe_kill_leader_duration", 120);
  level.endgametutorial_func.spectatecommands = getdvarint("scr_brRumble_pe_double_point_zone_radius", 6000);
  level.endgametutorial_func.spectate3rdallowed = getdvarint("scr_brRumble_pe_double_point_zone_height", 6000);
  level.endgametutorial_func.spectatekey = getdvarint("scr_brRumble_pe_double_point_zone_duration", 150);
  level.endgametutorial_func.specialistbr = getdvarint("scr_brRumble_pe_bonus_point_crate_drops_total", 6);
  level.endgametutorial_func.specialdayloadouts = getdvarint("scr_brRumble_pe_bonus_point_crate_drops_first", 3);
  level.endgametutorial_func.spectateprop = getdvarint("scr_brRumble_pe_points_per_crate_capture", 10);
  level.endgametutorial_func.parachutecancutautodeploy = getdvarfloat("scr_brRumble_pe_delay_between_crate_drops", 30);
  level.endgametutorial_func.spectatableprops = getdvarint("scr_brRumble_pe_dogtags_accept_double_points", 0);
  level.endgametutorial_func.spawnzombiedogtags = getdvarfloat("scr_brRumble_pe_bonus_point_crate_capture_time", 5);
  level.endgametutorial_func.spawned_vehicles = [];
  level.endgametutorial_func.ref_14225 = ["tac_rover", "atv", "cargo_truck", "open_jeep_carpoc", "little_bird_mg", "atv", "veh_a10fd", "cargo_truck_susp_aa"];
  level.endgametutorial_func.ref_12b1b = [];
  level.endgametutorial_func.buildblueprintpickupweapon = &scripts\mp\gametypes\br_analytics::destinations;
  level.endgametutorial_func.build_our_weapon = &scripts\mp\gametypes\br_analytics::desired_landing_spot;

  if(getdvarint("scr_brRumble_dangerNotifyCustomization", 1)) {
    level.isbotpracticematch = getdvarfloat("scr_brRumble_dangerNotifyCooldown", 20);
    level.isbrgametypefuncdefined = [];
    level.isbrgametypefuncdefined["uav"] = [];
  }

  level.ref_14062 = getdvarint("scr_brRumble_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarfloat("scr_brRumble_defaultRespawnTime", 5);
  level.ref_13bcd = getdvarint("scr_brRumble_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_brRumble_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_brRumble_respawn_penalty_max", 15);
  level.ref_12ca7 = getdvarint("scr_brRumble_respawnHeightOverride", 3000);
  level.ref_12cb4 = getdvarint("scr_brRumble_respawn_time_disable", 0);
  level.ref_121cc = getdvarfloat("scr_brRumble_parachuteDeployDelay", 0.5);
  level.spawn_set_jugg_value = spawnStruct();
  level.spawn_set_jugg_value.chosen = undefined;
  level.spawn_set_jugg_value.choppersupport_watchtargetrange = undefined;
  level.ref_133ea = getdvarint("scr_brRumble_skipWeaponDropOnDeath", 1);
  level.ref_133cd = getdvarint("scr_brRumble_skipEquipmentDropOnDeath", 1);
  level.playerismatchedplayerready = getdvarint("scr_brRumble_forceArmorDropOnDeath", 1);
  level.ref_133e6 = getdvarint("scr_brRumble_skipSuperDropOnDeath", 1);
  level.laststand = getdvarint("scr_brRumble_allowLastStand", 0);
  level.playerkillstreakgetownerlookatignoreents = !level.laststand;
  level.disable_back_light = 1;
  level.ref_13364 = 1;
  level.ref_133bf = 1;
  scripts\engine\scriptable::ref_12f5b("body", &ref_11ff5);
}

function ref_13209(var0) {
  level.ref_12178 = [];

  switch (var0) {
    case "island_storage":
      level.ref_12178[level.ref_12178.size] = [(-25959, 14148, 2220), (0, 0, 0)];
      level.ref_12178[level.ref_12178.size] = [(-29851, -2135, 3100), (0, 0, 0)];
      break;
    case "island_docks":
      level.ref_12178[level.ref_12178.size] = [(22326, 44353, 688), (0, 135, 0)];
      level.ref_12178[level.ref_12178.size] = [(11367, 53645, 316), (0, 0, 0)];
      break;
    default:
      break;
  }
}

function subwave_progression() {
  _setdomflagiconinfo("waypoint_captureneutral_br_a", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_b", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_c", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_d", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_e", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_capture_br_a", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_capture_br_b", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_capture_br_c", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_capture_br_d", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_capture_br_e", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defend_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defend_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defend_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defend_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defend_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defending_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defending_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defending_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defending_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defending_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_contested_br_a", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_contested_br_b", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_contested_br_c", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_contested_br_d", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_contested_br_e", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_taking_br_a", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_taking_br_b", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_taking_br_c", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_taking_br_d", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_taking_br_e", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_losing_br_a", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_losing_br_b", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_losing_br_c", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_losing_br_d", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_losing_br_e", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1);
  level._effect["vfx_smk_signal_green"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_green");
  scripts\mp\gametypes\br_dom_quest::ref_13239();
  thread ref_13bb1();
}

function subtract_from_spawn_count_from_group() {
  waittillframeend();
  game["dialog"]["gametype"] = "gametype_rumble";
  game["dialog"]["primary_objective"] = "gametype_desc_rumble_alt";
  game["dialog"]["score_friendly_50_percent"] = "score_friendly_50_percent";
  game["dialog"]["score_friendly_90_percent"] = "score_friendly_90_percent";
  game["dialog"]["score_friendly_ahead_50"] = "score_friendly_ahead_50";
  game["dialog"]["score_friendly_win"] = "score_friendly_win";
  game["dialog"]["score_enemy_50_percent"] = "score_enemy_50_percent";
  game["dialog"]["score_enemy_90_percent"] = "score_enemy_90_percent";
  game["dialog"]["score_enemy_ahead_50"] = "score_enemy_ahead_50";
  game["dialog"]["score_enemy_win"] = "score_enemy_win";
  game["dialog"]["dom_point_incoming"] = "dom_point_incoming";
  game["dialog"]["dom_point_started"] = "dom_point_started";
  game["dialog"]["dom_point_friendly_capture_single"] = "dom_point_friendly_capture";
  game["dialog"]["dom_point_friendly_capture_1"] = "dom_point_friendly_capture_1";
  game["dialog"]["dom_point_friendly_capture_2"] = "dom_point_friendly_capture_2";
  game["dialog"]["dom_point_friendly_capture_all"] = "dom_point_friendly_capture_all";
  game["dialog"]["dom_point_enemy_capture_single"] = "dom_point_enemy_capture";
  game["dialog"]["dom_point_enemy_capture_1"] = "dom_point_enemy_capture_1";
  game["dialog"]["dom_point_enemy_capture_2"] = "dom_point_enemy_capture_2";
  game["dialog"]["dom_point_enemy_capture_all"] = "dom_point_enemy_capture_all";
  game["dialog"]["power_zone_incoming"] = "dx_bra_bchr_clsh_power_zone_incoming";
  game["dialog"]["power_zone_active"] = "dx_bra_bchr_clsh_power_zone_active";

  if(!isDefined(game["dialogForAllTeams"])) {
    game["dialogForAllTeams"] = [];
  }

  game["dialogForAllTeams"]["power_zone_incoming"] = 1;
  game["dialogForAllTeams"]["power_zone_active"] = 1;
  game["dialog"]["hvt_incoming"] = "hvt_incoming";
  game["dialog"]["hvt_started"] = "hvt_started";
  game["dialog"]["hvt_hunted"] = "hvt_hunted";
  game["dialog"]["hvt_survived"] = "hvt_survived";
  game["dialog"]["hvt_friendly_down"] = "hvt_friendly_down";
  game["dialog"]["hvt_all_friendlies_down"] = "hvt_friendlies_down";
  game["dialog"]["hvt_enemy_down"] = "hvt_enemy_down";
  game["dialog"]["hvt_all_enemies_down"] = "hvt_enemies_down_all";
}

function _setdomflagiconinfo(var0, var1, var2, var3, var4) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 0;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = var3;
  level.waypointpulses[var0] = var4;
}

function ref_13bb1() {
  level waittill("br_dialog_initialized");
  level.disableinitplayergameobjects = 0;
}

function watch_flight_collision(var0) {
  if(level.laststand) {
    return true;
  }

  return false;
}

function table_getaddblueprintattachments() {
  waitframe();
  level.ref_13b7e = &ref_13b66;
  level.ontimelimit = &ref_11ff6;
  level.endgame = &endgame;
  level.defenderflagreset = &defenderflagbases;
  level.delete_players_black_screen = &defenderflagbase;
  scripts\mp\rank::ref_12189("kill", level.endgametutorial_func.spreadshotdamagemod);
  scripts\mp\rank::ref_12189("assist", level.endgametutorial_func.sprayed);
  scripts\mp\rank::ref_12189("br_cacheopen", level.endgametutorial_func.sprayid);

  if(!level.laststand) {
    scripts\mp\tweakables::settweakablevalue("player", "laststand", 0);
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\flags::gameflaginit("rumble_location_selected", 1);
  scripts\mp\flags::gameflaginit("infil_complete", 0);
  thread subtract_from_spawn_count_from_group();
  thread syringe_out();
}

function syringe_out() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.defensefactormod = 5;
  thread ref_12efb();
  thread ref_13eee();
  thread ref_122d6();
  thread carepackage_glowsticks();
}

function activate_battle_station() {}

function groundz() {
  level.br_level.ref_13884 = 1;
  var0 = ref_12d80();
  level.endgametutorial_func.ref_12e2c = randgetpropsizetoallocate(var0);
  ref_13209(var0);

  if(!scripts\mp\flags::playerzombiethermalcleanup("rumble_location_selected ")) {
    scripts\mp\flags::gameflaginit("rumble_location_selected", 1);
  }

  level notify("rumble_location_selected");
  level.grouptorewards = level.endgametutorial_func.ref_12e2c.ground_detection_think;
  var1 = getdvarint("scr_br_timelimit");
  level.br_level.br_circledelaytimes = [var1 * 2];
  level.br_level.br_circleclosetimes = [var1 * 2];
  level.br_level.br_circleradii = [level.endgametutorial_func.ref_12e2c.circle_radius, level.endgametutorial_func.ref_12e2c.circle_radius];
  level.br_level.br_circleminimapradii = [level.endgametutorial_func.ref_12e2c.circle_radius];
  level.br_level.default_player_connect_black_screen = [0];
  level.br_level.default_suicidebomber_combat = [0];
  tank_x1_capacity();
}

function relic_steelballs_health_boost() {
  return level.endgametutorial_func.ref_12e2c.ground_detection_think;
}

function init_relic_aggressive_melee() {
  var0 = (level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], 0);
  var1 = level.br_level.br_circleradii[0] * 0.66;
  var2 = scripts\mp\gametypes\br_c130::createtestc130path(var0, var1);
  return var2;
}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var1;

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var3.br_infil_type) && var3.br_infil_type == "c130" && !isDefined(var3.jumptype)) {
      var3.jumptype = "outOfBounds";
      var3 notify("halo_kick_c130");
    }
  }
}

function activate_laser_trap() {}

function manage_fakebody_hides() {
  scripts\mp\deathicons::ref_12bfd();

  for(var0 = 0; var0 < level.players.size; var0++) {
    var1 = level.players[var0];

    if(!isDefined(var1)) {
      continue;
    }

    if(!isalive(var1) && !istrue(var1.waitingtospawnamortize)) {
      var1 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var1.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var1);
    }

    var1 setclientomnvar("ui_br_infil_started", 1);
    var1 setclientomnvar("ui_br_infiled", 1);
    var1 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    var2 = rear_door_collision(var1);
    var3 = var1 scripts\mp\gametypes\br_gulag::ref_1263e(var2);
  }

  wait 2;

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    thread ref_12496();
  }

  thread ref_138cc();
  game["music"]["losing_axis"] = [];
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_1";
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_2";
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_3";
  game["music"]["losing_allies"] = [];
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_1";
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_2";
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_3";
  game["music"]["winning_axis"] = [];
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_1";
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_2";
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_3";
  game["music"]["winning_allies"] = [];
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_1";
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_2";
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_3";
  scripts\mp\flags::gameflagset("prematch_fade_done");
  scripts\mp\flags::gameflagset("infil_complete");
  waitframe();

  if(!getdvarint("scr_brRumble_quests_enabled", 1)) {
    level thread scripts\mp\gametypes\br_quest_util::little_bird_mg_mp_enterendinternal();
  }

  setomnvar("ui_br_circle_state", 4);
}

function ref_138cc() {
  level endon("game_ended");
  wait 10;
  level thread scripts\mp\music_and_dialog::stopsuspensemusic();
}

function ref_133d6() {
  scripts\mp\flags::gameflagset("infil_complete");
}

function activatefunc() {}

function ref_126f1(var0) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  self waittill("player_rumble_spawn_complete");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_rumble_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gametype", self, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function tank_x1_capacity() {
  level.endgametutorial_func.ref_12e2c.ref_1365e["allies"] = level.endgametutorial_func.ref_12e2c.ref_13564;
  level.endgametutorial_func.ref_12e2c.ref_1365e["axis"] = level.endgametutorial_func.ref_12e2c.ref_13565;
  level.endgametutorial_func.ref_12e2c.ref_136a8["allies"] = anglesToForward((0, level.endgametutorial_func.ref_12e2c.ref_134ff, 0));
  level.endgametutorial_func.ref_12e2c.ref_136a8["axis"] = anglesToForward((0, level.endgametutorial_func.ref_12e2c.ref_13500, 0));
  level.endgametutorial_func.ref_12e2c.ref_13608 = level.endgametutorial_func.ref_12e2c.ref_13502;
  level.endgametutorial_func.ref_12e2c.ref_13607 = level.endgametutorial_func.ref_12e2c.ref_13501;
  level.endgametutorial_func.ref_12e2c.ref_13631 = level.endgametutorial_func.ref_12e2c.ref_13532;
  level.endgametutorial_func.ref_12e2c.ref_13630 = level.endgametutorial_func.ref_12e2c.ref_13531;
  level.endgametutorial_func.ref_12e2c.ref_13677 = level.endgametutorial_func.ref_12e2c.ref_135aa;
  level.endgametutorial_func.ref_12e2c.ref_13676 = level.endgametutorial_func.ref_12e2c.ref_135a9;
  var0 = level.endgametutorial_func.ref_12e2c.ground_detection_think + level.endgametutorial_func.ref_12e2c.ref_136a8["allies"] * level.endgametutorial_func.ref_12e2c.circle_radius * level.endgametutorial_func.ref_12e2c.ref_13631;
  var1 = level.endgametutorial_func.ref_12e2c.ground_detection_think + level.endgametutorial_func.ref_12e2c.ref_136a8["axis"] * level.endgametutorial_func.ref_12e2c.circle_radius * level.endgametutorial_func.ref_12e2c.ref_13631;
  level.endgametutorial_func.ref_12e2c.spawnorigin["allies"] = var0;
  level.endgametutorial_func.ref_12e2c.spawnorigin["axis"] = var1;
  level.endgametutorial_func.ref_12e2c.passes_final_capsule_check = level.endgametutorial_func.ref_12e2c.ref_1354f;
  thread ref_1283f();
}

function ref_1283f() {
  level.ref_12ab4 = [];
  level.ref_12ab4["allies"] = [];
  level.ref_12ab4["axis"] = [];
  var0 = getdvarint("scr_br_teamsize", 50);
  var1 = getdvarint("scr_brRumble_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var2 = 0;
  var3 = scripts\mp\teams::ref_132e6();

  foreach(var5 in level.teamnamelist) {
    if(var3 && var5 == "team_two_hundred") {
      continue;
    }

    for(var6 = 0; var6 < var0; var6++) {
      var7 = spawnStruct();
      var8 = vectortoangles(level.endgametutorial_func.ref_12e2c.ref_136a8[var5]);
      var9 = randomfloatrange(level.endgametutorial_func.ref_12e2c.ref_13608, level.endgametutorial_func.ref_12e2c.ref_13607);
      var10 = anglesToForward((0, var8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var9, var9 * -1), 0));
      var11 = randomfloatrange(level.endgametutorial_func.ref_12e2c.ref_13631, level.endgametutorial_func.ref_12e2c.ref_13630);
      var12 = level.endgametutorial_func.ref_12e2c.ground_detection_think + var10 * level.endgametutorial_func.ref_12e2c.circle_radius * var11;

      if(istrue(level.endgametutorial_func.ref_12e2c.passes_final_capsule_check)) {
        var13 = level.endgametutorial_func.ref_12e2c.spawnorigin[scripts\mp\utility\game::getotherteam(var5)[0]] - var12;
        var8 = vectortoangles(var13);
      } else {
        var8 = vectortoangles(var10 * -1);
      }

      var14 = scripts\engine\trace::create_default_contents(1);
      var15 = 0;
      var16 = 0;
      var17 = 10;
      var18 = [];

      for(var19 = 0; var19 < var1; var19++) {
        var20 = scripts\engine\trace::ray_trace(var12 + (0, 0, 10000), var12 - (0, 0, 20000) + anglesToForward(var8) * var19 * 2000, undefined, var14)["position"];
        var18 = var20;

        if(var20[2] > var15) {
          var15 = var20[2];
          var16 = var19;
        }

        var2++;

        if(var2 == 5) {
          waitframe();
          var2 = 0;
        }
      }

      var12 = (var12[0], var12[1], var15 + level.endgametutorial_func.ref_12e2c.ref_1365e[var5]);
      var7.origin = var12;
      var7.ref_13c33 = var18;
      var7.spawn_exfil_heli = var16;
      var7.angles = var8;
      var7.time = gettime();
      var7.team = var5;
      var7.index = -1;
      level.ref_12ab4[var5][level.ref_12ab4[var5].size] = var7;
    }
  }
}

function rear_door_collision() {
  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
    return ppkteamnoflag();
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    var0 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(var2 in level.teamnamelist) {
        if(var2 != self.team) {
          self playsoundtoteam("tactical_spawn", var2);
        }
      }
    }

    foreach(var5 in level.ugvs) {
      if(distancesquared(var5.origin, self.setspawnpoint.playerspawnpos) < 1024) {
        var5 notify("damage", 5000, var5.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, getcompleteweaponname("killstreak_jammer_mp"));
      }
    }

    var7 = vectortoangles(level.endgametutorial_func.ref_12e2c.ref_136a8[self.team]);
    var8 = randomfloatrange(level.endgametutorial_func.ref_12e2c.ref_13608, level.endgametutorial_func.ref_12e2c.ref_13607);
    var9 = anglesToForward((0, var7[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var8, var8 * -1), 0));
    var10 = randomfloatrange(level.endgametutorial_func.ref_12e2c.ref_13677, level.endgametutorial_func.ref_12e2c.ref_13676);
    var11 = self.setspawnpoint.playerspawnpos + var9 * var10;

    if(distance2dsquared(var11, level.endgametutorial_func.ref_12e2c.ground_detection_think) > level.endgametutorial_func.ref_12e2c.circle_radius * level.endgametutorial_func.ref_12e2c.circle_radius) {
      var12 = vectorNormalize(var11 - level.endgametutorial_func.ref_12e2c.ground_detection_think);
      var11 = level.endgametutorial_func.ref_12e2c.ground_detection_think + var12 * level.endgametutorial_func.ref_12e2c.circle_radius * 0.99;
    }

    var13 = scripts\engine\trace::create_default_contents(1);
    var14 = scripts\engine\utility::drop_to_ground(var11, 10000, -20000, undefined, var13);
    var11 = (var11[0], var11[1], var14[2]);
    var11 += (0, 0, 1) * level.endgametutorial_func.ref_12e2c.ref_1365e[self.team];
    self.ref_12ab3.origin = var11;
    self.ref_12ab3.angles = self.setspawnpoint.playerspawnangles;
    self.ref_12ab3.lifeid = self.lifeid;
    self.ref_12ab3.time = gettime();
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
  } else if(self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid) {
    return ppkteamnoflag();
  }

  return self.ref_12ab3;
}

function ppkteamnoflag() {
  var0 = randomint(level.ref_12ab4[self.team].size);
  var1 = level.ref_12ab4[self.team][var0];
  self.ref_12ab3.origin = var1.origin;
  self.ref_12ab3.angles = var1.angles;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  return self.ref_12ab3;
}

function ref_12496() {
  self endon("disconnect");
  scripts\mp\gametypes\br_public::ref_1264c();
  self.ref_133e7 = 1;
  self.ref_12ca8 = 1;
  self.plotarmor = 1;

  if(!isalive(self) && !istrue(self.waitingtospawnamortize)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  waitframe();
  thread patch_far_wait();
  scripts\mp\gametypes\br_public::ref_126ed();
  self.plotarmor = undefined;
  self.ref_12ca8 = undefined;
  self.elevator_manager = 1;
  self freezecontrols(1);
  self playerhide();
  thread ref_12495();
}

function ref_12495() {
  self endon("disconnect");
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  var0 = rear_door_collision();
  var1 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var0, 1, var1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  thread script_gameobject();

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    if(level.mapname == "mp_don4" || level.mapname == "mp_don4_pm" || level.mapname == "mp_wz_island") {
      ref_130f1();
    }

    thread ref_1246e();
  }

  waittillframeend();
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self.ref_133e7 = 0;
  scripts\mp\gametypes\br::ending_fade_in();
  thread ref_13ee7();
}

function ref_1246e() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("rumble_remove_spawn_protection");
  self.ref_12d70 = 1;
  thread ref_124cd();
}

function ref_124cd() {
  thread ref_124e2();
  level endon("game_ended");
  self endon("disconnect");
  self endon("rumble_remove_spawn_protection");
  scripts\engine\utility::ref_143bb(10, "vehicle_enter", "weapon_fired", "rumble_remove_spawn_protection_early");
  thread ref_124e1();
}

function ref_124e1() {
  self.ref_12d70 = 0;
  self notify("rumble_remove_spawn_protection");
}

function ref_124e2() {
  self endon("death_or_disconnect");

  while(!self isonground()) {
    waitframe();
  }

  self notify("rumble_remove_spawn_protection_early");
}

function gulagwinnerrespawn(var0) {
  var0 notify("player_rumble_spawn_complete");
  thread script_gameobject();
}

function playerrespawn(var0, var1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(game["state"] == "playing" && !level.timerstopped) {
    var2 = scripts\mp\gamelogic::gettimeremaining() / 1000;

    if(var2 < 12) {
      return false;
    }
  }

  thread ref_126a4(var0);
  return true;
}

function ref_126a4(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  if(istrue(level.gameended)) {
    level waittill("forever");
  }

  wait 3;

  while(istrue(self.killcam)) {
    waitframe();
  }

  var1 = level.checkpoint_objective_id;
  var2 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 5);

  if(var1 < var2) {
    var1 = var2;
  }

  if(level.ref_12cb4 != 0) {
    var1 = 0;
  }

  thread ref_1333f(var1);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  var3 = var1 - var2;
  var4 = var1 - var3;
  var5 = var1 - getdvarfloat("scr_brRumble_respawn_intermission_time", 6);
  thread patchfix();
  wait var3;
  thread ref_1400c();
  wait var4;
  self notify("stop_updatePrestreamRespawn");
  var6 = rear_door_collision();
  var7 = scripts\mp\gametypes\br_gulag::ref_1263e(var6);
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(undefined, 0);
  }

  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var6, 1, var7, 1);
  scripts\mp\gametypes\br::ref_13f21(self);
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit) && self.operatorcustomization.suit != "iw8_suit_mp_wyatt") {
    self.operatorcustomization.suit = "iw8_suit_mp_wyatt";
    scripts\mp\utility\player::_setsuit("iw8_suit_mp_wyatt");
  }

  if(isDefined(self.trophy_get_best_tag)) {
    self.trophy_get_best_tag = undefined;
  }

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    if(level.mapname == "mp_don4" || level.mapname == "mp_don4_pm" || level.mapname == "mp_wz_island") {
      ref_130f1();
    }

    thread ref_1246e();
    return;
  }
}

function ref_1333f(var0) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131a2(1);

  if(isDefined(var0)) {
    wait var0;
  }

  thread spawn_boss_wave_3();
}

function spawn_boss_wave_3() {
  scripts\mp\gametypes\br_gulag::ref_131a2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function script_gameobject() {
  self endon("death_or_disconnect");
  waitframe();
  self.br_armorhealth = self.br_maxarmorhealth;
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
}

function patchfix(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  thread patch_mansion_holes();
  var1 = 1;
  wait var1 - 0.25;
  thread ref_13ee7();
  scripts\mp\gametypes\br::ending_fade_in();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  wait 0.25;

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252b();
    var2 = rear_door_collision();
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(var2.origin, var2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function patch_mansion_holes() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function patch_far_wait() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_1400c() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var0 = rear_door_collision();
      var1 = gettime();

      if(var1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var0 = rear_door_collision();
        var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
      }
    } else {
      var0 = rear_door_collision();
      var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
    }

    wait 1;
  }
}

function ref_1365d(var0) {
  return scripts\mp\flags::gameflag("prematch_done");
}

function modifyplayerdamage(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;

  if(istrue(self.ref_12d70)) {
    if(isDefined(var2) && (isPlayer(var2) || isbot(var2))) {
      var1 = 0;
      var2 scripts\mp\damagefeedback::updatedamagefeedback("hitspawnprotect");
    }
  }

  return var1;
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var1 = var0.victim;
  var2 = var0.attacker;
  _ispointinbadarea::ref_11ff1(var0);
  _initignoredtabspergamemode::ref_11ff1(var0);
  ref_122dc(var2, var1, var0.meansofdeath);

  if(!isDefined(var2) || !isPlayer(var2) || !isDefined(var1)) {
    return;
  }

  foreach(var4 in var1 getweaponslist("primary", "exclusive")) {
    var5 = undefined;

    switch (var4.basename) {
      case "iw8_lm_dblmg_mp":
        var5 = "brloot_weapon_lm_dblmg_lege";
        break;
      case "iw8_la_mike32_mp":
        var5 = "brloot_weapon_la_mike32_lege";
        break;
    }

    if(isDefined(var5)) {
      scripts\mp\gametypes\br_pickups::ml_p1_func(var5, ref_119f1(var1.origin));
    }
  }

  if(var1 == var2) {
    return;
  }

  ref_122c8(var2, var1);
  ref_122a7(var2, var1);
  ref_122da(var2, var1);

  if(isDefined(var2.team)) {
    var7 = level.endgametutorial_func.spin_fan_blades;

    if(istrue(level.endgametutorial_func.spawnpointdangertime)) {
      if(istrue(var2.ref_12827)) {
        var7 *= 2;
      }

      if(istrue(var2.triggerovertimetimer)) {
        var7 *= 2;
      }
    } else if(istrue(var2.ref_12827) || istrue(var2.triggerovertimetimer)) {
      var7 *= 2;
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var2.pers["team"], var7, 0);
    return;
  }
}

function battle_tracks_hidetogglewidget(var0, var1) {
  if(self == var1 || !isDefined(var1)) {
    return;
  }

  var2 = getdvarint("scr_brRumble_powerup_drop_chance_on_death", 33);

  if(istrue(self.triggerovertimetimer)) {
    var2 = 100;
  }

  _keypadscriptableused_bunkeralt::modify_juggernaut_damage(var0, var2);
}

function onplayerconnect(var0) {
  var0 endon("disconnect");
  var0 waittill("spawned_player");

  if(istrue(level.endgametutorial_func.ref_13376)) {
    ref_13e4b(var0);
  }

  thread script_gameobject();
  thread ref_11ff2();
}

function ref_11ff2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread script_gameobject();
  }
}

function playerdropplunderondeath(var0, var1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var2 = self.plundercount;
  } else {
    var2 = 0;
  }

  if(istrue(self.unicornpoints)) {
    var3 = 0;
    var4 = level.endgametutorial_func.ref_127b5;
  } else {
    var3 = int(var4 * level.endgametutorial_func.ref_127be + 0.5);
    var4 = int(level.endgametutorial_func.ref_127b5 + var4 * level.endgametutorial_func.ref_127b6 + 0.5);
  }

  self.plundercountondeath = var3;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var3);

  if(var4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var4, var2);
  return 1;
}

function activate_precision_use_lua() {}

function init_locations() {
  if(level.mapname == "mp_wz_island") {
    ref_12af6("island_mines", 1);
    ref_12af6("island_agport", 1);
    ref_12af6("island_beachhead", 1);
    ref_12af6("island_village", 0);
    ref_12af6("island_capital", 1);
    ref_12af6("island_airfield", 1);
    ref_12af6("island_docks", 1);
    ref_12af6("island_storage", 1);
    ref_12af6("island_full", 0);
    return;
  }

  if(level.mapname == "mp_sm_island_1") {
    ref_12af6("dragons_den", 1);
    return;
  }
}

function ref_12af6(var0, var1) {
  if(!isDefined(level.endgametutorial_func.are_players_in_volume)) {
    level.endgametutorial_func.are_players_in_volume = [];
  }

  var1 = getdvarint("scr_brRumble_location_weight_" + var0, var1);
  level.endgametutorial_func.are_players_in_volume[var0] = var1;
}

function ref_12d80() {
  if(level.mapname != "mp_sm_island_1" && level.mapname != "mp_wz_island") {
    return "default";
  }

  if(isDefined(level.endgametutorial_func.ref_13903) && level.endgametutorial_func.ref_13903 != "random") {
    foreach(var2, var1 in level.endgametutorial_func.are_players_in_volume) {
      if(level.endgametutorial_func.ref_13903 == var2) {
        return var2;
      }
    }
  }

  var3 = 0;

  foreach(var1 in level.endgametutorial_func.are_players_in_volume) {
    var3 += var1;
  }

  var6 = randomintrange(0, var3);

  foreach(var1 in level.endgametutorial_func.are_players_in_volume) {
    if(var6 < var1) {
      return var2;
    }

    var6 -= var1;
  }
}

function randgetpropsizetoallocate(var0) {
  var1 = spawnStruct();
  var1.ref_13904 = "default";
  var1.ground_detection_think = getdvarvector("scr_brRumble_default_circle_center", (300, -800, 0));
  var1.circle_radius = getdvarint("scr_brRumble_default_circle_radius", 6000);
  var1.ref_134ff = getdvarint("scr_brRumble_default_spawn_angle_allies", 0);
  var1.ref_13500 = getdvarint("scr_brRumble_default_spawn_angle_axis", 180);
  var1.ref_13564 = level.endgametutorial_func.spawnrope;
  var1.ref_13565 = level.endgametutorial_func.spawnrope;
  var1.ref_13502 = 0;
  var1.ref_13501 = 30;
  var1.ref_13532 = getdvarfloat("scr_brRumble_default_spawn_dist_min", 0.9);
  var1.ref_13531 = getdvarfloat("scr_brRumble_default_spawn_dist_max", 0.99);
  var1.ref_1354f = 0;
  var1.ref_135aa = 1000;
  var1.ref_135a9 = 3000;
  var1.ref_136e1 = (0, 0, 0);
  var1.ref_136e0 = (0, 0, 0);

  switch (var0) {
    case "island_full":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-1004, 2162, 3098);
      var1.circle_radius = 65000;
      var1.ref_134ff = 0;
      var1.ref_13500 = 180;
      var1.ref_13564 = 10000;
      var1.ref_13565 = 10000;
      var1.ref_13532 = 0.45;
      var1.ref_13531 = 0.55;
      var1.ref_136e1 = (-8516, 16084, 5000);
      var1.ref_136e0 = (21, 63, 0);
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-8540, 29070, 3022);
      level.spawn_set_jugg_value.chosen = (-8655, 3188, 3022);
      ref_12af0(var1, 0, (-18783, 16139, 4381));
      ref_12af0(var1, 0, (-1430, 16412, 2737));
      ref_12af0(var1, 1, (-8516, 16084, 2060));
      ref_12ae8(level, (-8211, 8553, 1315), (0, 255, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-9242, 4462, 671), (0, 87, 0));
      ref_12b04(var1, "atv", (-12413, 6341, 909), (0, 84, 0));
      ref_12b04(var1, "atv", (-7641, 6095, 1024), (0, 84, 0));
      ref_12b04(var1, "atv", (-8109, 9459, 1376), (0, 55, 0));
      ref_12b04(var1, "atv", (-12285, 8144, 1049), (0, 105, 0));
      ref_12b04(var1, "atv", (-8514, 6759, 1015), (0, 62, 0));
      ref_12b04(var1, "tac_rover", (-5822, 7771, 1400), (0, 126, 0));
      ref_12ae8(level, (-12541, 16090, 2443), (0, 174, 0));
      ref_12ae8(level, (-1762, 14977, 3610), (0, 96, 0));
      ref_12b04(var1, "atv", (-13237, 17049, 2531), (0, 279, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-1685, 17036, 3231), (0, 160, 0));
      ref_12b04(var1, "cargo_truck", (-11470, 16776, 1997), (0, 1, 0));
      ref_12ae8(level, (-8989, 22726, 2000), (0, 96, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-5942, 25656, 902), (0, 325, 0));
      ref_12b04(var1, "atv", (-9402, 25915, 1685), (0, 277, 0));
      ref_12b04(var1, "atv", (-5260, 23883, 1169), (0, 313, 0));
      ref_12b04(var1, "atv", (-10385, 23478, 2009), (0, 270, 0));
      ref_12b04(var1, "atv", (-10974, 26085, 2048), (0, 267, 0));
      ref_12b04(var1, "atv", (-8557, 26235, 1298), (0, 289, 0));
      ref_12b04(var1, "tac_rover", (-12140, 25429, 2729), (0, 279, 0));
      break;
    case "island_mines":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-8516, 16084, 2060);
      var1.circle_radius = 15000;
      var1.ref_134ff = 90;
      var1.ref_13500 = 270;
      var1.ref_13564 = 3500;
      var1.ref_13565 = 4250;
      var1.ref_13532 = 0.85;
      var1.ref_13531 = 0.95;
      var1.ref_136e1 = (-8516, 16084, 5000);
      var1.ref_136e0 = (21, 63, 0);
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-8540, 29070, 3022);
      level.spawn_set_jugg_value.chosen = (-8655, 3188, 3022);
      ref_12af0(var1, 0, (-13166, 16035, 2492), 600);
      ref_12af0(var1, 0, (-1430, 16412, 2737), 600);
      ref_12af0(var1, 1, (-6530, 16065, 1743), 600);
      ref_12aee(var1, (-18867, 16264, 4357));
      ref_12aee(var1, (-8532, 16420, 2062));
      ref_12aee(var1, (3379, 16189, 6277));
      ref_12aee(var1, (-15199, 16405, 3667));
      ref_12aee(var1, (-2777, 16333, 3234));
      ref_12aee(var1, (-7165, 16211, 1741));
      ref_12ae8(level, (-8211, 8553, 1315), (0, 255, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-9242, 4462, 671), (0, 87, 0));
      ref_12b04(var1, "atv", (-12413, 6341, 909), (0, 84, 0));
      ref_12b04(var1, "atv", (-7641, 6095, 1024), (0, 84, 0));
      ref_12b04(var1, "atv", (-8109, 9459, 1376), (0, 55, 0));
      ref_12b04(var1, "atv", (-12285, 8144, 1049), (0, 105, 0));
      ref_12b04(var1, "atv", (-8514, 6759, 1015), (0, 62, 0));
      ref_12b04(var1, "tac_rover", (-5822, 7771, 1400), (0, 126, 0));
      ref_12ae8(level, (-12541, 16090, 2443), (0, 174, 0));
      ref_12ae8(level, (-1762, 14977, 3610), (0, 96, 0));
      ref_12b04(var1, "atv", (-13237, 17049, 2531), (0, 279, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-1685, 17036, 3231), (0, 160, 0));
      ref_12b04(var1, "cargo_truck", (-11470, 16776, 1997), (0, 1, 0));
      ref_12ae8(level, (-8989, 22726, 2000), (0, 96, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-5942, 25656, 902), (0, 325, 0));
      ref_12b04(var1, "atv", (-9402, 25915, 1685), (0, 277, 0));
      ref_12b04(var1, "atv", (-5260, 23883, 1169), (0, 313, 0));
      ref_12b04(var1, "atv", (-10385, 23478, 2009), (0, 270, 0));
      ref_12b04(var1, "atv", (-10974, 26085, 2048), (0, 267, 0));
      ref_12b04(var1, "atv", (-8557, 26235, 1298), (0, 289, 0));
      ref_12b04(var1, "tac_rover", (-12140, 25429, 2729), (0, 279, 0));
      break;
    case "island_agport":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-2059, -16473, 2150);
      var1.circle_radius = 15000;
      var1.ref_134ff = 90;
      var1.ref_13500 = 270;
      var1.ref_13564 = 3000;
      var1.ref_13565 = 3000;
      var1.ref_13532 = 0.85;
      var1.ref_13531 = 0.95;
      var1.ref_136e1 = (-2059, -16473, 5000);
      var1.ref_136e0 = (21, 63, 0);
      ref_12af0(var1, 0, (-12703, -16709, 946));
      ref_12af0(var1, 0, (8382, -16352, 2243));
      ref_12af0(var1, 1, (-2100, -16483, 2167), 600);
      ref_12aee(var1, (10965, -16137, 2220));
      ref_12aee(var1, (-2048, -15945, 2161));
      ref_12aee(var1, (-10578, -16134, 946));
      ref_12aee(var1, (-4303, -15918, 1879));
      ref_12aee(var1, (3343, -15967, 2640));
      ref_12aee(var1, (-4508, -16198, 1866));
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-2012, -3744, 2720);
      level.spawn_set_jugg_value.chosen = (-2020, -29244, 2799);
      ref_12b04(var1, "atv", (-7825, -25502, 1855), (0, 78, 0));
      ref_12b04(var1, "atv", (-1409, -25350, 1958), (0, 78, 0));
      ref_12b04(var1, "atv", (4968, -25468, 2505), (0, 103, 0));
      ref_12b04(var1, "atv", (-8756, -26103, 1750), (0, 112, 0));
      ref_12b04(var1, "atv", (6413, -24807, 2514), (0, 75, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-2867, -25782, 1966), (0, 126, 0));
      ref_12b04(var1, "open_jeep_carpoc", (1253, -25449, 2071), (0, 72, 0));
      ref_12ae8(level, (-2014, -25419, 1962), (0, 285, 0));
      ref_12ae8(level, (6966, -24236, 2487), (0, 272, 0));
      ref_12ae8(level, (-8899, -26425, 1761), (0, 279, 0));
      ref_12b04(var1, "atv", (-8430, -8272, 1444), (0, 270, 0));
      ref_12b04(var1, "atv", (4250, -7760, 1874), (0, 288, 0));
      ref_12b04(var1, "atv", (-7588, -8571, 1472), (0, 252, 0));
      ref_12b04(var1, "atv", (-2287, -7904, 1712), (0, 271, 0));
      ref_12b04(var1, "atv", (7652, -8708, 1882), (0, 250, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-2938, -8037, 1717), (0, 284, 0));
      ref_12b04(var1, "open_jeep_carpoc", (1162, -7671, 1709), (0, 274, 0));
      ref_12ae8(level, (-2676, -7781, 1705), (0, 90, 0));
      ref_12ae8(level, (-7318, -8382, 1471), (0, 81, 0));
      ref_12ae8(level, (6451, -7819, 1889), (0, 85, 0));
      ref_12b04(var1, "tac_rover", (-9640, -16157, 882), (0, 269, 0));
      ref_12b04(var1, "open_jeep_carpoc", (9772, -14495, 1968), (0, 202, 0));
      ref_12ae8(level, (-5594, -17685, 1647), (0, 180, 0));
      ref_12ae8(level, (2455, -17363, 2436), (0, 351, 0));
      break;
    case "island_beachhead":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (42336, 26470, 1129);
      var1.circle_radius = 14000;
      var1.ref_134ff = 65;
      var1.ref_13500 = 245;
      var1.ref_13564 = 3500;
      var1.ref_13565 = 3300;
      var1.ref_13532 = 0.75;
      var1.ref_13531 = 0.85;
      var1.ref_13501 = 20;
      var1.ref_136e1 = (-2059, -16473, 5000);
      var1.ref_136e0 = (21, 63, 0);
      ref_12af0(var1, 0, (37138, 30559, 2073), 600);
      ref_12af0(var1, 0, (46599, 24269, 479), 600);
      ref_12af0(var1, 1, (41798, 27031, 1164), 600);
      ref_12aee(var1, (32589, 32742, 2998));
      ref_12aee(var1, (42300, 26859, 1128));
      ref_12aee(var1, (48834, 23696, 388));
      ref_12aee(var1, (38480, 28289, 1625));
      ref_12aee(var1, (45135, 24556, 655));
      ref_12aee(var1, (40370, 27510, 1182));
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (47759, 37415, 256);
      level.spawn_set_jugg_value.chosen = (37190, 15324, 2004);
      ref_12b04(var1, "atv", (39695.7, 24954.5, 1130), (0, 348, 0));
      ref_12b04(var1, "atv", (42922.1, 18544.5, 558.325), (357.935, 136, 0));
      ref_12b04(var1, "open_jeep_carpoc", (34096.9, 23605.4, 1710.88), (356.229, 33.7372, 0));
      ref_12b04(var1, "open_jeep_carpoc", (45750.7, 19208.1, 306.481), (358.154, 111.497, 8.19));
      ref_12b04(var1, "tac_rover", (38916.6, 15767.8, 1943.53), (0, 118.21, 0));
      ref_12b04(var1, "tac_rover", (39756.8, 21830.9, 1125.45), (0, 105.435, 0));
      ref_12b04(var1, "atv", (48147.1, 28409.3, 461.216), (7, 322.284, 0));
      ref_12b04(var1, "atv", (43660.2, 30007, 1075.76), (360, 245.605, 0));
      ref_12b04(var1, "open_jeep_carpoc", (39184.2, 36813.3, 1345.95), (355.382, 129.98, 2.7));
      ref_12b04(var1, "open_jeep_carpoc", (50226.5, 31617.5, 285.036), (358.317, 229.303, 0));
      ref_12b04(var1, "tac_rover", (47794, 36873, 259), (0, 287, 0));
      ref_12b04(var1, "tac_rover", (45469.3, 32590.9, 651.305), (353.611, 233.427, 3.74));
      ref_12b04(var1, "cargo_truck", (49588.8, 23375.7, 289.755), (3.44, 325.306, 0));
      ref_12ae8(level, (51176, 28266, 323), (0, 288.994, 0));
      ref_12ae8(level, (40633, 36646, 1281), (0, 200, 0));
      ref_12ae8(level, (46589, 36622, 212), (0, 353.999, 0));
      ref_12ae8(level, (35152, 25856, 1731), (357.699, 284.999, -0.4002));
      ref_12ae8(level, (38790, 17955, 1946), (0, 218.2, 0));
      ref_12ae8(level, (44393, 18577, 287), (0, 320.198, 0));
      ref_12ae8(level, (43762, 25225, 807), (0, 307.897, 0));
      ref_12ae8(level, (45917, 26832, 736), (0, 0.596145, 0));
      break;
    case "island_village":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-41927, 11992, 1492);
      var1.circle_radius = 14000;
      var1.ref_134ff = 90;
      var1.ref_13500 = 270;
      var1.ref_13564 = 2500;
      var1.ref_13565 = 3000;
      var1.ref_13532 = 0.8;
      var1.ref_13531 = 0.9;
      var1.ref_136e1 = (-43582, 6013, 1121);
      var1.ref_136e0 = (7, 55, 0);
      ref_12aee(var1, var1.ground_detection_think);
      ref_12aee(var1, (-49969, 11480, 246));
      ref_12aee(var1, (-46388, 11467, 1059));
      ref_12aee(var1, (-37979, 11630, 1498));
      ref_12aee(var1, (-34072, 11677, 1905));
      ref_12aee(var1, (-31189, 11333, 2916));
      ref_12af0(var1, 0, (-48102, 11889, 217), 750);
      ref_12af0(var1, 0, (-37194, 11387, 1539), 750);
      ref_12af0(var1, 1, (-42142, 12350, 1525), 550);
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-41944, 23939, 1525);
      level.spawn_set_jugg_value.chosen = (-41932, 348, 1054);
      ref_12ae8(level, (-38905, 20922, 1741), (0, 343.899, 0));
      ref_12ae8(level, (-42695, 22591, 1411), (0, 180, 0));
      ref_12ae8(level, (-46930, 16795, 1405), (0, 301.598, 0));
      ref_12b04(var1, "atv", (-40796.3, 18705, 1888.2), (350, 329.353, 0.01));
      ref_12b04(var1, "atv", (-37331.9, 19336.4, 1805.74), (0, 226, 0));
      ref_12b04(var1, "atv", (-45080, 18300, 1593.75), (0, 217, 0));
      ref_12b04(var1, "cargo_truck", (-43040.6, 23448.1, 1444.46), (8.22, 296.332, 5.29));
      ref_12b04(var1, "open_jeep_carpoc", (-48144.4, 18403.9, 220.901), (0, 212, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-34261, 22942, 883), (0, 321, 0));
      ref_12ae8(level, (-44041, 9432, 1461), (0, 343.899, 0));
      ref_12ae8(level, (-38439, 12616, 1573), (0, 44.797, 0));
      ref_12ae8(level, (-40898, 15989, 2010), (0, 163.996, 0));
      ref_12ae8(level, (-40230, 7295, 1119), (0, 257.595, 0));
      ref_12b04(var1, "atv", (-43816.7, 11136.3, 1457.79), (358.261, 39.1391, 0));
      ref_12b04(var1, "atv", (-40236, 11779, 1316.24), (0, 359, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-48475.4, 13147, 201.345), (6.14, 182.449, 3.70617));
      ref_12ae8(level, (-43744, 2748, 946), (0, 1.79359, 0));
      ref_12ae8(level, (-38980, 2597, 1463), (0, 269.292, 0));
      ref_12ae8(level, (-48214, 7522, 544), (0, 151.398, 0));
      ref_12b04(var1, "atv", (-45607.2, 5247.57, 953.857), (0, 105.099, 0));
      ref_12b04(var1, "atv", (-41428.5, 5815.72, 1035.08), (359, 76.7339, 0));
      ref_12b04(var1, "atv", (-36834.5, 6922.72, 2272), (354, 72.36, 0));
      ref_12b04(var1, "cargo_truck", (-43302, 1791.85, 908.082), (357.468, 1.05, 4.76));
      ref_12b04(var1, "open_jeep_carpoc", (-49482.4, 6606.3, 258.88), (2.39, 97.24, -8.16));
      ref_12b04(var1, "open_jeep_carpoc", (-33852.1, 5157.71, 2792.52), (358.549, 133.215, -6.60096));
      break;
    case "island_capital":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (25362, -48470, 586);
      var1.circle_radius = 14000;
      var1.ref_134ff = 20;
      var1.ref_13500 = 200;
      var1.ref_13564 = 3000;
      var1.ref_13565 = 3000;
      var1.ref_13532 = 0.7;
      var1.ref_13531 = 0.8;
      var1.ref_136e1 = (-2059, -16473, 5000);
      var1.ref_136e0 = (21, 63, 0);
      var2 = 500;
      ref_12af0(var1, 0, (22047, -43116, 853), var2);
      ref_12af0(var1, 0, (30008, -57560, 381), var2);
      ref_12af0(var1, 1, (26159, -49077, 596), var2);
      ref_12aee(var1, (21759, -36974, 2799));
      ref_12aee(var1, (25157, -47678, 593));
      ref_12aee(var1, (28808, -56469, 363));
      ref_12aee(var1, (23270, -44078, 762));
      ref_12aee(var1, (26505, -50982, 554));
      ref_12aee(var1, (27854, -53423, 402));
      level.spawn_set_jugg_value.chosen = (14776, -52301, 983);
      ref_12b04(var1, "open_jeep_carpoc", (17931, -50466, 383), (0, 2.7, 0));
      ref_12b04(var1, "open_jeep_carpoc", (19083, -54517, 301), (0, 10, 0));
      ref_12b04(var1, "atv", (17881, -52344, 295), (0, 354, 0));
      ref_12b04(var1, "atv", (17604, -54495, 265), (0, 23, 0));
      ref_12b04(var1, "atv", (16854, -48015, 702), (0, 14, 0));
      ref_12ae8(level, (17450, -54980, 253), (0, 192, 0));
      ref_12ae8(level, (18303, -51204, 400), (0, 186, 0));
      ref_12ae8(level, (16079, -47258, 776), (0, 198, 0));
      ref_12b04(var1, "open_jeep_carpoc", (31430, -46001, 504), (0, 185, 0));
      ref_12b04(var1, "open_jeep_carpoc", (34931, -48822, 337), (0, 223, 0));
      ref_12b04(var1, "atv", (30520, -43227, 440), (0, 231, 0));
      ref_12b04(var1, "atv", (34187, -49643, 370), (0, 206, 0));
      ref_12b04(var1, "atv", (27757, -41061, 656), (0, 222, 0));
      ref_12ae8(level, (31933, -44949, 557), (0, 82, 0));
      ref_12ae8(level, (35730, -49415, 318), (0, 24, 0));
      ref_12ae8(level, (27941, -40452, 647), (0, 35, 0));
      ref_12b04(var1, "tac_rover", (30082, -55769, 310), (0, 255, 0));
      ref_12b04(var1, "open_jeep_carpoc", (24282, -46307, 589), (0, 31, 0));
      ref_12b04(var1, "little_bird_mg", (24025, -47102, 1006), (0, 303, 0));
      ref_12ae8(level, (27868, -51665, 625), (0, 329, 0));
      ref_12ae8(level, (21421, -41686, 906), (0, 120, 0));
      ref_12ae8(level, (24864, -46841, 624), (0, 120, 0));
      break;
    case "island_airfield":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-24922, -19948, 945);
      var1.circle_radius = 20000;
      var1.ref_134ff = 45;
      var1.ref_13500 = 225;
      var1.ref_13564 = 4000;
      var1.ref_13565 = 4000;
      var1.ref_13532 = 0.52;
      var1.ref_13531 = 0.62;
      var1.ref_136e1 = (-2059, -16473, 5000);
      var1.ref_136e0 = (21, 63, 0);
      var3 = 450;
      ref_12af0(var1, 0, (-31385, -14497, 622), var3);
      ref_12af0(var1, 0, (-18945, -26037, 933), var3);
      ref_12af0(var1, 1, (-25383, -19500, 945), var3);
      ref_12aee(var1, (-37223, -7070, 875));
      ref_12aee(var1, (-24873, -20054, 945));
      ref_12aee(var1, (-13428, -31227, 2152));
      ref_12aee(var1, (-17939, -25998, 940));
      ref_12aee(var1, (-29664, -15299, 1070));
      ref_12aee(var1, (-21948, -20997, 946));
      ref_12b04(var1, "open_jeep_carpoc", (-30846, -22007, 905), (0, 59, 0));
      ref_12b04(var1, "atv", (-28882, -22814, 887), (0, 69, 0));
      ref_12b04(var1, "atv", (-26396, -28261, 888), (0, 47, 0));
      ref_12b04(var1, "tac_rover", (-25040, -7574, 650), (0, 199, 0));
      ref_12b04(var1, "veh_a10fd", (-30205, -29269, 942), (0, 41, 0));
      ref_12b04(var1, "veh_a10fd", (-27998, -28310, 942), (0, 44, 0));
      ref_12b04(var1, "veh_a10fd", (-26382, -25572, 942), (0, 44, 0));
      ref_12b04(var1, "cargo_truck_susp_aa", (-13274, -28859, 2340), (0, 57, 0));
      ref_12b04(var1, "cargo_truck_susp_aa", (-30445, -26797, 885), (0, 312, 0));
      ref_12ae8(level, (-24217, -29554, 887), (0, 225, 0));
      ref_12ae8(level, (-28090, -22981, 888), (0, 222, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-21724, -12245, 883), (0, 221, 0));
      ref_12b04(var1, "atv", (-17802, -13318, 887), (0, 226, 0));
      ref_12b04(var1, "atv", (-14440, -17086, 889), (0, 204, 0));
      ref_12b04(var1, "tac_rover", (-25040, -7574, 650), (0, 199, 0));
      ref_12b04(var1, "veh_a10fd", (-15116, -14244, 942), (0, 223, 0));
      ref_12b04(var1, "veh_a10fd", (-16228, -16680, 942), (0, 225, 0));
      ref_12b04(var1, "veh_a10fd", (-18773, -18010, 942), (0, 223, 0));
      ref_12b04(var1, "cargo_truck_susp_aa", (-13714, -16711, 885), (0, 176, 0));
      ref_12b04(var1, "tac_rover", (-14098, -20800, 883), (0, 219, 0));
      ref_12ae8(level, (-18227, -13066, 946), (0, 43, 0));
      ref_12ae8(level, (-15846, -19813, 895), (0, 43, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-18101, -27845, 861), (0, 127, 0));
      ref_12b04(var1, "atv", (-35382, -11706, 408), (0, 328, 0));
      ref_12b04(var1, "tac_rover", (-27259, -13524, 998), (0, 270, 0));
      ref_12b04(var1, "cargo_truck_susp_aa", (-29837, -6907, 769), (0, 270, 0));
      ref_12b04(var1, "tac_rover", (-29837, -6907, 769), (0, 270, 0));
      ref_12b04(var1, "cargo_truck", (-23466, -20145, 885), (0, 318, 0));
      ref_12ae8(level, (-27862, -15622, 1002), (0, 133, 0));
      ref_12ae8(level, (-18269, -28491, 867), (0, 313, 0));
      ref_12ae8(level, (-24002, -19673, 888), (0, 313, 0));
      break;
    case "island_docks":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (16657, 49035, 479);
      var1.circle_radius = 14500;
      var1.ref_134ff = 135;
      var1.ref_13500 = 315;
      var1.ref_13564 = 3000;
      var1.ref_13565 = 3000;
      var1.ref_13532 = 0.6;
      var1.ref_13531 = 0.7;
      var1.ref_136e1 = (-2059, -16473, 5000);
      var1.ref_136e0 = (21, 63, 0);
      var4 = 550;
      ref_12af0(var1, 0, (12229, 45655, 1059), var4);
      ref_12af0(var1, 0, (21608, 53388, 335), var4);
      ref_12af0(var1, 1, (16657, 49035, 479), var4);
      ref_12b04(var1, "open_jeep_carpoc", (12726, 53523, 317), (0, 312, 0));
      ref_12b04(var1, "atv", (16585, 56520, 320), (0, 314, 0));
      ref_12b04(var1, "atv", (16994, 55944, 229), (0, 307, 0));
      ref_12b04(var1, "open_jeep_carpoc", (15477, 56027, 317), (0, 320, 0));
      ref_12b04(var1, "atv", (8454, 50718, 876), (0, 340, 0));
      ref_12b04(var1, "atv", (8789, 49615, 905), (0, 4, 0));
      ref_12ae8(level, (14020, 52995, 321), (0, 138, 0));
      ref_12b04(var1, "open_jeep_carpoc", (22232, 46647, 264), (0, 127, 0));
      ref_12b04(var1, "atv", (24289, 48605, 259), (0, 145, 0));
      ref_12b04(var1, "atv", (23630, 49169, 249), (0, 164, 0));
      ref_12b04(var1, "open_jeep_carpoc", (19568, 44581, 411), (0, 137, 0));
      ref_12b04(var1, "atv", (17716, 42182, 648), (0, 164, 0));
      ref_12b04(var1, "atv", (17130, 42484, 604), (0, 174, 0));
      ref_12ae8(level, (20305, 45593, 422), (0, 314, 0));
      ref_12b04(var1, "cargo_truck", (17657, 50874, 414), (0, 226, 0));
      ref_12b04(var1, "tac_rover", (8948, 43935, 1070), (0, 30, 0));
      ref_12b04(var1, "tac_rover", (15285, 48254, 430), (0, 40, 0));
      ref_12aee(var1, (15798, 49897, 475));
      ref_12aee(var1, (17421, 48137, 475));
      ref_12aee(var1, (18334, 51135, 338));
      ref_12aee(var1, (22744, 54128, 237));
      ref_12aee(var1, (13944, 46436, 989));
      ref_12aee(var1, (10847, 44006, 965));
      break;
    case "island_storage":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (-27318, 5535, 3325);
      var1.circle_radius = 12500;
      var1.ref_134ff = 165;
      var1.ref_13500 = 345;
      var1.ref_13564 = 1800;
      var1.ref_13565 = 1800;
      var1.ref_13532 = 0.5;
      var1.ref_13531 = 0.6;
      var1.ref_136e1 = (-27318, 5535, 3325);
      var1.ref_136e0 = (21, 63, 0);
      var5 = 500;
      ref_12af0(var1, 0, (-26163, 11898, 2387), var5);
      ref_12af0(var1, 0, (-28944, -1422, 3688), var5);
      ref_12af0(var1, 1, (-27402, 5377, 3331), var5);
      ref_12aee(var1, (-28207, 1387, 3952));
      ref_12aee(var1, (-27887, 4174, 3389));
      ref_12aee(var1, (-28081, 5607, 3501));
      ref_12aee(var1, (-26703, 5256, 3485));
      ref_12aee(var1, (-27205, 6944, 3261));
      ref_12aee(var1, (-27105, 10299, 2558));
      ref_12ae8(level, (-24867, 3672, 3330), (0, 343, 0));
      ref_12ae8(level, (-24975, 7610, 3209), (0, 344, 0));
      ref_12ae8(level, (-31023, 4522, 3394), (0, 167, 0));
      ref_12ae8(level, (-29622, 8111, 3202), (0, 166, 0));
      ref_12b04(var1, "atv", (-24473, 9643, 2864), (0, 115, 0));
      ref_12b04(var1, "atv", (-29010, 9843, 3054), (0, 38, 0));
      ref_12b04(var1, "atv", (-27239, 7509, 3201), (0, 70, 0));
      ref_12b04(var1, "atv", (-28347, 2823, 3393), (0, 68, 0));
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-33338, 7020, 4461);
      level.spawn_set_jugg_value.chosen = (-21013, 3850, 4461);
      break;
    case "dragons_den":
      var1.ref_13904 = var0;
      var1.ground_detection_think = (1087.26, -114.74, 1526.75);
      var1.circle_radius = 15000;
      var1.ref_134ff = 0;
      var1.ref_13500 = 180;
      var1.ref_13564 = 2500;
      var1.ref_13565 = 2500;
      var1.ref_13532 = 0.8;
      var1.ref_13531 = 0.9;
      var1.ref_136e1 = (0, 0, 15000);
      var1.ref_136e0 = (7, 55, 0);
      ref_12aee(var1, (3021, 6566, 1434));
      ref_12aee(var1, (539, -1764, 449));
      ref_12aee(var1, (-6905, -2847, 1104));
      ref_12aee(var1, (10865, 1528, 641));
      ref_12aee(var1, (8022, -5128, 545));
      ref_12aee(var1, (-5416, 2414, 1273));
      ref_12af0(var1, 0, (1875, 4610, 1470), 750);
      ref_12af0(var1, 0, (407, -4452, 201), 750);
      ref_12af0(var1, 1, (15, -1098, 1264), 750);
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (12661.2, 611.71, 876.23);
      level.spawn_set_jugg_value.chosen = (-9029.59, -1547.42, 1108.31);
      ref_12b04(var1, "atv", (5394, -3585, 47), (0, 121, 0));
      ref_12b04(var1, "open_jeep_carpoc", (9036, 2460, 919), (0, 65, 0));
      ref_12b04(var1, "atv", (13605, 257, 173), (0, 267, 0));
      ref_12b04(var1, "cargo_truck", (2079, 5169, 1369), (0, 146, 0));
      ref_12b04(var1, "little_bird_mg", (-2858, 43, 2563), (0, 238, 0));
      ref_12b04(var1, "tac_rover", (6839, 3257, 1187), (0, 225, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-9874, -1389, 332), (0, 262, 0));
      ref_12b04(var1, "tac_rover", (-6181, -5403, 515), (0, 169, 0));
      ref_12b04(var1, "tac_rover", (-4203, -426, 1162), (0, 10, 0));
      ref_12b04(var1, "little_bird_mg", (11760, -3899, 600), (0, 131, 0));
      ref_12b04(var1, "atv", (1156, -1520, 397), (0, 160, 0));
      ref_12b04(var1, "tac_rover", (-2306, -4208, 48), (0, 177, 0));
      ref_12b04(var1, "open_jeep_carpoc", (-4501, 3505, 1305), (0, 319, 0));
      break;
    default:
      break;
  }

  initcarriables(var1, var0);
  initcashtracking(var1, var0);
  initcallbacks(var1, var0);
  thread tac_rover();
  return var1;
}

function initcashtracking(var0) {
  if(var0 == "default") {
    return;
  }

  var1 = "mp/rumble_info_table.csv";
  var2 = tablelookupgetnumrows(var1);
  var3 = 0;
  var4 = 1;
  var5 = 2;
  var6 = 3;
  var7 = ",";

  for(var8 = 0; var8 < var2; var8++) {
    var9 = tablelookupbyrow(var1, var8, var3);

    if(var9 == var0) {
      var10 = tablelookupbyrow(var1, var8, var4);

      if(scripts\engine\utility::array_contains(level.endgametutorial_func.ref_14225, var10)) {
        var11 = strtok(tablelookupbyrow(var1, var8, var5), var7);
        var12 = strtok(tablelookupbyrow(var1, var8, var6), var7);
        var13 = "Rumble CSV Info | row:" + var8 + " | ";

        if(!isDefined(var11[0]) && !isDefined(var12[0])) {
          continue;
        } else if(!isDefined(var11[0])) {
          continue;
        } else if(!isDefined(var12[0])) {
          continue;
        }

        var14 = (float(var11[0]), float(var11[1]), float(var11[2]));
        var15 = (float(var12[0]), float(var12[1]), float(var12[2]));
        ref_12b04(var10, var14, var15);
      }
    }
  }
}

function initcarriables(var0) {
  if(var0 == "default") {
    return;
  }

  var1 = "mp/rumble_info_table.csv";
  var2 = tablelookupgetnumrows(var1);
  var3 = 0;
  var4 = 1;
  var5 = 2;
  var6 = 3;
  var7 = ",";

  for(var8 = 0; var8 < var2; var8++) {
    var9 = tablelookupbyrow(var1, var8, var3);

    if(var9 == var0) {
      var10 = tablelookupbyrow(var1, var8, var4);

      if(var10 == "kiosk") {
        var11 = strtok(tablelookupbyrow(var1, var8, var5), var7);
        var12 = strtok(tablelookupbyrow(var1, var8, var6), var7);
        var13 = "Rumble CSV Info | row:" + var8 + " | ";

        if(!isDefined(var11[0]) && !isDefined(var12[0])) {
          continue;
        } else if(!isDefined(var11[0])) {
          continue;
        } else if(!isDefined(var12[0])) {
          continue;
        }

        var14 = (float(var11[0]), float(var11[1]), float(var11[2]));
        var15 = (float(var12[0]), float(var12[1]), float(var12[2]));
        ref_12ae8(var14, var15);
      }
    }
  }
}

function initcallbacks(var0) {
  if(var0 == "default") {
    return;
  }

  var1 = "mp/rumble_info_table.csv";
  var2 = tablelookupgetnumrows(var1);
  var3 = 0;
  var4 = 1;
  var5 = 2;
  var6 = 3;
  var7 = 4;
  var8 = ",";

  for(var9 = 0; var9 < var2; var9++) {
    var10 = tablelookupbyrow(var1, var9, var3);

    if(var10 == var0) {
      var11 = tablelookupbyrow(var1, var9, var4);

      if(var11 == "dom_flag") {
        var12 = strtok(tablelookupbyrow(var1, var9, var5), var8);
        var13 = tablelookupbyrow(var1, var9, var6);
        var14 = tablelookupbyrow(var1, var9, var7);
        var15 = "Rumble CSV Info | row:" + var9 + " | ";

        if(!isDefined(var12[0]) && !isDefined(var13)) {
          continue;
        } else if(!isDefined(var12[0])) {
          continue;
        } else if(!isDefined(var13)) {
          continue;
        }

        var16 = (float(var12[0]), float(var12[1]), float(var12[2]));
        var17 = int(var13);
        var18 = int(var14);
        ref_12af0(var17, var16, var18);
      }
    }
  }
}

function tac_rover() {
  level endon("game_ended");

  if(level.endgametutorial_func.ref_12b1b.size < 1) {
    return;
  }

  while(!isDefined(level.br_armory_kiosk)) {
    waitframe();
  }

  wait 1;
  scripts\mp\gametypes\br_armory_kiosk::ref_131c0(level.endgametutorial_func.ref_12b1b);
}

function ref_12ae8(var0, var1) {
  var2 = getgroundposition(var0, 2.5);
  var3 = easepower("br_plunder_box", var2, var1);
  level.endgametutorial_func.ref_12b1b[level.endgametutorial_func.ref_12b1b.size] = var3;
}

function ref_12b04(var0, var1, var2) {
  if(var0 == "little_bird_mg" && getdvarfloat("lb_mg_spawn_percent", 100) < 1) {
    var0 = "little_bird";
  }

  if(!scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_canspawnVehicle(var0)) {
    return;
  }

  if(!isDefined(self.ref_141be)) {
    self.ref_141be = [];
  }

  self.ref_141be[self.ref_141be.size] = [var0, var1, var2];
}

function activeadvanceduavcount() {}

function ref_14216(var0) {
  var1 = spawnStruct();
  var2 = scripts\engine\utility::getStruct("launch_code_drop_button", "targetname");
  var1.origin = var2.origin + (0, 0, 50000);

  if(isDefined(var0)) {
    var2.origin = var0;
  }

  var3 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var1);

  if(isDefined(var3)) {
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var3, var2.origin, var3.angles, 1);
    return;
  }
}

function ref_13570() {
  level endon("game_ended");
  var0 = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {} else {
    var0 = 1;
  }

  if(!var0) {
    return;
  }

  scripts\mp\flags::gameflagwait("rumble_location_selected");

  if(!isDefined(level.endgametutorial_func.ref_12e2c.ref_141be)) {
    return;
  }

  foreach(var2 in level.endgametutorial_func.ref_12e2c.ref_141be) {
    var3 = spawnStruct();
    var3.ref = var2[0];
    var3.origin = var2[1];
    var3.angles = var2[2];
    var3.ref_13a22 = var4;
    thread ref_1421b(level);
  }
}

function ref_12b07(var0) {
  level.endgametutorial_func.spawned_vehicles[var0.ref_1352e.ref_13a22] = var0;
}

function lasttuttxt(var0) {
  level.endgametutorial_func.spawned_vehicles[var0.ref_1352e.ref_13a22] = undefined;
}

function ref_1421b(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var0.ref, var0);
  var1.ref_1352e = var0;
  ref_12b07(var1);
  thread vehicle_death_watcher();
  thread ref_141c5();
}

function ref_1420b(var0) {
  level endon("game_ended");
  wait 45;
  ref_1421b(var0);
}

function ref_141c5() {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_pending_respawn");
  var0 = self.origin;
  var1 = 1500;
  var2 = 60;
  self.ref_11e49 = undefined;
  self.ref_11e4a = 0;
  self.ref_1381c = undefined;
  self.mp_layover_patch = undefined;

  for(;;) {
    self.loot_nag = distance2d(var0, self.origin);
    self.ref_141fa = isDefined(self getvehicleowner());

    if(!self.ref_11e4a && self.loot_nag > var1 && !self.ref_141fa) {
      self.ref_1381c = gettime();
      self.mp_layover_patch = gettime() + var2 * 1000;
      self.ref_11e4a = 1;
    } else if(self.ref_11e4a && self.ref_141fa) {
      self.ref_11e4a = 0;
      self.ref_1381c = undefined;
      self.mp_layover_patch = undefined;
      self.ref_11e49 = undefined;
    }

    if(isDefined(self.ref_1381c) && isDefined(self.mp_layover_patch)) {
      var3 = gettime();
      self.ref_11e49 = (self.mp_layover_patch - var3) / 1000;
      var4 = 0;

      if(var3 >= self.mp_layover_patch) {
        foreach(var6 in level.players) {
          if(distance(var6.origin, self.origin) < var1) {
            self.mp_layover_patch = var3 + var2 / 2 * 1000;
            var4 = 1;
            break;
          }
        }

        if(!var4) {
          var8 = self.health * 0.95;
          self dodamage(var8, self.origin);
          break;
        }
      }
    }

    wait 1;
  }
}

function vehicle_death_watcher() {
  level endon("game_ended");
  var0 = self.ref_1352e;
  self waittill("death");
  self notify("vehicle_pending_respawn");
  lasttuttxt(self);

  if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var0.origin)) {
    ref_1420b(var0);
    return;
  }
}

function activate_subway_track_trigger_hurt() {}

function ref_13b66() {
  level endon("game_ended");
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = 0;
  var7 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);
  scripts\mp\flags::gameflagwait("infil_complete");

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit()) {
      var8 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var9 = int(var8 + 0.5);
      var10 = 0;

      if(var7 == 2 && var9 % 2 == 1) {
        var10 = 1;
      }

      if(!var0 && (var10 == 1 && var9 == 681 || var10 == 0 && var9 == 680)) {
        if(level.endgametutorial_func.player_complete_trial || scripts\engine\utility::cointoss()) {
          thread ref_122c0(level);
        } else {
          thread ref_122ca(level);
        }

        var0 = 1;
      } else if(!var3 && (var10 == 1 && var9 == level.endgametutorial_func.parachuteoverheadwarningradius + 1 || var10 == 0 && var9 == level.endgametutorial_func.parachuteoverheadwarningradius)) {
        level notify("quest_tablets_refill");
        var3 = 1;
      } else if(!var1 && (var10 == 1 && var9 == 441 || var10 == 0 && var9 == 440)) {
        if(scripts\engine\utility::cointoss()) {
          thread ref_122c0(level);
        } else {
          thread ref_122ca(level);
        }

        var1 = 1;
      } else if(!var2 && (var10 == 1 && var9 == 201 || var10 == 0 && var9 == 200)) {
        if(level.endgametutorial_func.ref_122cb && scripts\engine\utility::cointoss()) {
          ref_122d7(level.endgametutorial_func.verbal_clip);
        } else {
          thread ref_12293();
        }

        var2 = 1;
      } else if(!var4 && (var10 == 1 && var9 == 61 || var10 == 0 && var9 == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        var4 = 1;
      } else if(!var5 && (var10 == 1 && var9 == 31 || var10 == 0 && var9 == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        level notify("match_ending_soon", "time");
        var5 = 1;
      } else if(!var4 && !var5 && !var6 && var9 >= 30 && var9 <= 45) {
        var6 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
      }

      if(var9 <= 10 || var9 <= 30 && var9 % var7 == var10) {
        if(!var6 && var9 <= 10) {
          var6 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup", var9);
        }

        level notify("match_ending_very_soon");
        var11 = 1;

        if(var9 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var8) {
          var10 = 0;
        }

        if(var10) {
          var12 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var7);
          playsoundatpos((0, 0, 0), var12);
        }
      }

      if(var7 - floor(var7) >= 0.05) {
        wait var7 - floor(var7);
        continue;
      }
    }

    wait 1;
  }
}

function activate_target_group() {}

function ref_122ca(var0) {
  level endon("game_ended");

  if(!isDefined(level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions)) {
    ref_12af0(level.endgametutorial_func.ref_12e2c, var0, level.endgametutorial_func.ref_12e2c.ground_detection_think);
  }

  var1 = level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions[var0];
  level.endgametutorial_func.ref_12e2c.ref_122b5 = var0;

  if(!isDefined(var1) || var1.size <= 0) {
    return;
  }

  ref_122bf();

  if(getdvarint("scr_rumble_skip_event_wait_times", 0) == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("power_zone_incoming", 0);
    ref_12424("br_rumble_pe_double_point_zones_incoming");
    wait 20;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("power_zone_active", 0);
  ref_12424("br_rumble_pe_double_point_zones_online");
  wait 3;
  thread ref_122c9();
}

function ref_122c9() {
  var0 = ["_a", "_b", "_c", "_d", "_e"];

  if(!isDefined(level.endgametutorial_func.spawnsecretstashlootcache)) {
    level.endgametutorial_func.spawnsecretstashlootcache = 0;
  }

  var1 = level.endgametutorial_func.ref_12e2c.ref_122b5;
  var2 = level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions[var1];

  foreach(var4 in var2) {
    scripts\mp\gametypes\br_quest_util::ref_140b1(var4.location, "attack");
    var5 = scripts\engine\utility::ter_op(isDefined(var4.mid_bosses), var4.mid_bosses, level.endgametutorial_func.spectatecommands);
    var6 = scripts\engine\utility::ter_op(isDefined(var4.mid_air_explode), var4.mid_air_explode, level.endgametutorial_func.spectate3rdallowed);
    var7 = var4.location - (0, 0, var6 / 3);

    if(level.endgametutorial_func.ref_12e2c.ref_13904 == "island_storage") {
      var5 = 3000;
    }

    var8 = spawn("trigger_radius", var7, 0, int(var5), int(var6));
    var8.script_label = var0[level.endgametutorial_func.spawnsecretstashlootcache];
    var8.iconname = var0[level.endgametutorial_func.spawnsecretstashlootcache];
    var8.vfxent = var4.vfxent;
    level.endgametutorial_func.spawnsecretstashlootcache++;
    var2[var9].trigger = var8;
    var8 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(2, 14, 0, var8.origin);
    var8 scripts\mp\gametypes\br_quest_util::ref_1316f(int(var5));
    var8 scripts\mp\gametypes\br_quest_util::ref_13369();
    thread ref_122c6();
    thread ref_122c7();
    thread ref_122c3();
    thread ref_122b6(var8);
    wait 0.5;
  }
}

function ref_122c6() {
  level endon("game_ended");
  self endon("death");
  self.ref_1265b = [];

  foreach(var1 in level.players) {
    if(var1 istouching(self) && isalive(var1)) {
      ref_122c4(var1);
    }
  }

  for(;;) {
    self waittill("trigger", var1);

    if((isPlayer(var1) || isbot(var1)) && !scripts\engine\utility::array_contains(self.ref_1265b, var1)) {
      ref_122c4(var1);
    }
  }
}

function ref_122c7() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    for(var0 = 0; var0 < self.ref_1265b.size; var0++) {
      if(isDefined(self.ref_1265b[var0]) && !self.ref_1265b[var0] istouching(self) || !isalive(self.ref_1265b[var0])) {
        ref_122c5(self.ref_1265b[var0]);
        var0--;
      }
    }

    wait 0.1;
  }
}

function ref_122c4(var0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var0);
  var0.triggerovertimetimer = 1;
  var0 playlocalsound("mp_powerup_activate_2x_plr");
  playfxontagforclients(level._effect["vfx_2x_points_screen_fx"], var0, "tag_origin", var0);
}

function ref_122c5(var0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var0);
  var0.triggerovertimetimer = 0;
  stopfxontagforclients(level._effect["vfx_2x_points_screen_fx"], var0, "tag_origin", var0);

  if(isDefined(var0.spawn_silo_door_ai)) {
    var0.spawn_silo_door_ai destroy();
    return;
  }
}

function ref_122c3() {
  level endon("game_ended");
  wait level.endgametutorial_func.spectatekey;
  thread ref_122c2();
}

function ref_122c2() {
  thread ref_122c1();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), self.vfxent, "tag_origin");
  self.vfxent delete();
  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  self delete();
}

function ref_122c1() {
  foreach(var1 in level.players) {
    if(istrue(var1.triggerovertimetimer)) {
      var1.triggerovertimetimer = 0;
      stopfxontagforclients(level._effect["vfx_2x_points_screen_fx"], var1, "tag_origin", var1);

      if(isDefined(var1.spawn_silo_door_ai)) {
        var1.spawn_silo_door_ai destroy();
      }
    }
  }
}

function ref_122c8(var0, var1) {
  if(istrue(var0.triggerovertimetimer)) {
    playFX(level._effect["vfx_2x_points_victim_explosion"], var1.origin);
    var2 = easepower("brloot_rumble_powerup_sfx", var1.origin);
    var2 setscriptablepartstate("sfx", "2x_victim_death_3D");
    var0 playlocalsound("mp_powerup_victim_death_2x_plr");
    var0 thread scripts\mp\rank::giverankxp("rumble_double_point_zone_kill", 50, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("rumble_double_point_zone_kill");
    return;
  }
}

function activate_target() {}

function ref_12af0(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = level.endgametutorial_func.maphints;
  }

  if(!isDefined(self.manualturret_toggleallowuseactions)) {
    self.manualturret_toggleallowuseactions = [];
  }

  if(!isDefined(self.manualturret_toggleallowuseactions[var0])) {
    self.manualturret_toggleallowuseactions[var0] = [];
  }

  var4 = spawnStruct();
  var4.ref_135ce = var0;
  var4.location = getgroundposition(var1, 5);
  var4.get_current_building_obj_struct = var2;
  var4.mid_bosses = var3;
  self.manualturret_toggleallowuseactions[var0] = scripts\engine\utility::array_add(self.manualturret_toggleallowuseactions[var0], var4);
}

function ref_122c0(var0) {
  level endon("game_ended");

  if(!isDefined(level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions)) {
    ref_12af0(level.endgametutorial_func.ref_12e2c, var0, level.endgametutorial_func.ref_12e2c.ground_detection_think);
  }

  var1 = level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions[var0];
  level.endgametutorial_func.ref_12e2c.ref_122b5 = var0;

  if(!isDefined(var1) || var1.size <= 0) {
    return;
  }

  ref_122bf();
  level.objectivescaler = 1;

  if(getdvarint("scr_rumble_skip_event_wait_times", 0) == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("dom_point_incoming", 0);
    ref_12424("br_rumble_pe_dom_flags_incoming");
    wait 20;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("dom_point_started", 0);
  ref_12424("br_rumble_pe_dom_flags_online");
  wait 3;
  thread ref_122be();
}

function ref_122bf() {
  var0 = level.endgametutorial_func.ref_12e2c.ref_122b5;
  var1 = level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions[var0];

  foreach(var3 in var1) {
    thread ref_122b7();
  }
}

function ref_122be() {
  var0 = ["_a", "_b", "_c", "_d", "_e"];

  if(!isDefined(level.endgametutorial_func.are_all_players_in_region)) {
    level.endgametutorial_func.are_all_players_in_region = [];
    level.endgametutorial_func.are_all_players_in_region["allies"] = 0;
    level.endgametutorial_func.are_all_players_in_region["axis"] = 0;
  }

  if(!isDefined(level.endgametutorial_func.spawnsecretstashlootcache)) {
    level.endgametutorial_func.spawnsecretstashlootcache = 0;
  }

  var1 = level.endgametutorial_func.ref_12e2c.ref_122b5;
  var2 = level.endgametutorial_func.ref_12e2c.manualturret_toggleallowuseactions[var1];

  foreach(var8, var4 in var2) {
    var5 = scripts\engine\utility::ter_op(isDefined(var4.get_current_building_obj_struct), var4.get_current_building_obj_struct, level.endgametutorial_func.maphints);
    var6 = spawn("trigger_radius", var4.location, 0, int(var5), int(level.defend_wave_3));
    var6.script_label = var0[level.endgametutorial_func.spawnsecretstashlootcache];
    var6.iconname = var0[level.endgametutorial_func.spawnsecretstashlootcache];
    level.endgametutorial_func.spawnsecretstashlootcache++;
    var2[var8].trigger = var6;
    var7 = scripts\mp\gametypes\obj_dom::setupobjective(var2[var8].trigger, "neutral");
    var7.onuse = &ref_122b2;
    var7.onbeginuse = &ref_122a8;
    var7.onuseupdate = &ref_122b3;
    var7.onenduse = &ref_122aa;
    var7.oncontested = &ref_122a9;
    var7.onuncontested = &ref_122af;
    var7.onunoccupied = &ref_122b0;
    var7.onpinnedstate = &ref_122ad;
    var7.onunpinnedstate = &ref_122b1;
    var7.ref_138b2 = &ref_122ae;
    var7.stompprogressreward = &ref_122b8;
    var7.id = "domFlag";
    var7.pinobj = 1;
    var7.lockupdatingicons = 1;
    var7.trigger = var6;
    var7.get_current_bush_zone = 0;
    var7.get_current_building_obj_struct = var5;
    var7.pos = var4.location;
    var7.vfxent = var4.vfxent;
    var7 scripts\mp\gameobjects::setcapturebehavior("persistent");
    var7 scripts\mp\gameobjects::setusetime(level.endgametutorial_func.ref_122a1);
    playencryptedcinematicforall(var7.objidnum, 1);
    var7.ref_11ad0 = [];
    var7.ref_11ad0["ally"] = spawnStruct();
    var7.ref_11ad0["enemy"] = spawnStruct();
    var7.ref_11ad0["neutral"] = spawnStruct();
    var7.waittill_pickup_or_timeout = "undefined";
    ref_122a4(var7.ref_11ad0["neutral"], 9, var7.curorigin, var5);
    ref_122a4(var7.ref_11ad0["ally"], 8, var7.curorigin, var5);
    ref_122a4(var7.ref_11ad0["enemy"], 0, var7.curorigin, var5);
    ref_122bb(var7, "neutral");
    thread ref_122b9();
    thread ref_122ba();
    var2[var8].manned_turret_operator_validation_func = var7;
    wait 0.5;
  }
}

function ref_122ab(var0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var0);
  var0.truck_03_node = 1;
}

function ref_122ac(var0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var0);
  var0.truck_03_node = 0;
}

function ref_122b9() {
  level endon("game_ended");
  self.ref_1265b = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("trigger", var0);

    if((isPlayer(var0) || isbot(var0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var0)) {
      ref_122ab(var0);
    }

    waitframe();
  }
}

function ref_122ba() {
  level endon("game_ended");

  while(!self.get_current_bush_zone) {
    foreach(var1 in self.ref_1265b) {
      if(!var1 istouching(self.trigger) || !isalive(var1)) {
        ref_122ac(var1);
      }
    }

    wait 0.1;
  }

  foreach(var1 in self.ref_1265b) {
    ref_122ac(var1);
  }
}

function ref_122a7(var0, var1) {
  if(istrue(var1.truck_03_node)) {
    var0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_enemy_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_enemy_kill");
  }

  if(istrue(var0.truck_03_node)) {
    var0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_defend_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_defend_kill");
    return;
  }
}

function ref_122a4(var0, var1, var2) {
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var0, 0, 0, var1);
  scripts\mp\gametypes\br_quest_util::ref_1316f(int(var2));
}

function ref_122bb(var0) {
  if(var0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var0;

    foreach(var2 in self.ref_11ad0) {
      var2 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    }

    var4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
    var5 = undefined;

    foreach(var7 in level.players) {
      var8 = var7.team == self.waittill_pickup_or_timeout;

      if(var4) {
        var5 = self.ref_11ad0["neutral"];
      } else {
        var5 = scripts\engine\utility::ter_op(var8, self.ref_11ad0["ally"], self.ref_11ad0["enemy"]);
      }

      if(isDefined(var5)) {
        var5 scripts\mp\gametypes\br_quest_util::ref_1336a(var7);
      }
    }

    if(isDefined(var5)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var0);
      return;
    }

    return;
  }
}

function ref_122a5() {
  foreach(var1 in self.ref_11ad0) {
    var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }
}

function ref_122b2(var0) {
  var1 = var0.team;
  self.get_current_station_signage_structs = var1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("pe_dom_flag_end");
  thread ref_122a2(var1);
}

function ref_122a8(var0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var3 in var1) {
      var3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_122b3(var0, var1, var2, var3) {
  self.userate = 1;

  if(var1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  ref_122bb(var0);
}

function ref_122aa(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function ref_122a9() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var0 = scripts\mp\gameobjects::getownerteam();
}

function ref_122af(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = undefined;
  var3 = ref_122a6();

  if(var3 <= 1) {
    foreach(var5 in level.teamnamelist) {
      var6 = self.teamprogress[var5];

      if(var6 > 0) {
        var2 = var5;
        break;
      }
    }

    if(isDefined(var2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var2);
    } else if(var1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var1);
    } else if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(var0 == "none" || var1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function ref_122b0() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function ref_122ad(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function ref_122b1(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function ref_122ae(var0) {
  self.userate = level.endgametutorial_func.manualturret_watchturretusetimeout;
  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = undefined;

  foreach(var4 in var1) {
    var5 = self.teamprogress[var4];

    if(var5 > 0) {
      var2 = var5 / self.usetime;
    }
  }
}

function ref_122b8(var0) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function ref_122a2(var0) {
  if(isDefined(var0) && var0 != "tie") {
    level.endgametutorial_func.are_all_players_in_region[var0] += 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var0, 15, 0);

    foreach(var2 in level.players) {
      if(isDefined(var2) && isDefined(var2.team) && var2.team == var0) {
        thread ref_122b4(var2, 1);
        var2 thread scripts\mp\hud_message::showsplash("br_rumble_pe_dom_flag_captured_ally");
        continue;
      }

      if(isDefined(var2) && isDefined(var2.team) && var2.team != var0) {
        thread ref_122b4(var2, 0);
        var2 thread scripts\mp\hud_message::showsplash("br_rumble_pe_dom_flag_captured_enemy");
      }
    }

    foreach(var5 in self.touchlist[var0]) {
      var2 = var5.player;
      var2 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var2 getcurrentprimaryweapon());
      var2 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");
    }

    thread ref_122b6(self.pos);
    thread ref_122a3(self);
    return;
  }
}

function ref_122b4(var0, var1) {
  var2 = level.endgametutorial_func.are_all_players_in_region[var1];

  switch (var2) {
    case 1:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_1", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_1", self);
      }

      break;
    case 2:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_2", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_2", self);
      }

      break;
    case 3:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_all", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_all", self);
      }

      break;
  }
}

function ref_122a3(var0) {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var0.vfxent, "tag_origin");
  var0.vfxent delete();
  ref_122a5(var0);
  scripts\mp\gametypes\obj_dom::removeobjective(var0);
}

function ref_122b7() {
  var0 = spawn("script_model", self.location - (0, 0, 3));
  var0 setModel("tag_origin");
  self.vfxent = var0;
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var0, "tag_origin");
}

function ref_122b6(var0) {
  thread ref_119f7(level, var0, "loot_table_dom_flag_capture_cash");
  thread ref_119f7(level, var0, "loot_table_dom_flag_capture_weapons");
}

function ref_122a6() {
  var0 = 0;

  foreach(var2 in self.numtouching) {
    if(var2 > 0 && (!isstring(var3) || var3 != "none")) {
      var0++;
    }
  }

  return var0;
}

function activate_subway_track_trigger_hurt_internal() {}

function ref_12aee(var0) {
  if(!isDefined(self.arena_bot_pickup_weapon)) {
    self.arena_bot_pickup_weapon = [];
  }

  self.arena_bot_pickup_weapon[self.arena_bot_pickup_weapon.size] = var0;
}

function ref_12293() {
  level endon("game_ended");
  ref_12291();
  thread ref_12290(level);

  if(getdvarint("scr_rumble_skip_event_wait_times", 0) == 0) {
    ref_12424("br_rumble_pe_bonus_point_crates_incoming");
    wait 20;
  }

  ref_12424("br_rumble_pe_bonus_point_crates_online");
  wait 3;
  thread ref_12292();
}

function ref_12291() {
  level.endgametutorial_func.ref_12e29 = spawnStruct();
  level.endgametutorial_func.ref_12e29.aq_ontimerupdate = [];
  level.endgametutorial_func.ref_12e29.are_all_alive_players_touching_plane = [];

  if(!isDefined(level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon)) {
    var0 = (0, 0, 0);

    if(isDefined(level.endgametutorial_func.ref_12e2c.ground_detection_think)) {
      var0 = level.endgametutorial_func.ref_12e2c.ground_detection_think;
    }

    level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon = [var0 + (0, 0, 0), var0 + (1500, 1500, 0), var0 + (1500, -1500, 0), var0 + (-1500, 1500, 0), var0 + (-1500, -1500, 0), var0 + (3000, 3000, 0), var0 + (3000, -3000, 0), var0 + (-3000, 3000, 0), var0 + (-3000, -3000, 0)];
  }

  level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon = scripts\engine\utility::array_randomize(level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon);
  var1 = scripts\cp_mp\killstreaks\airdrop::getleveldata("bonus_points_crate");
  var1.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var1.dummymodel = "military_carepackage_01_br_legendary";
  var1.friendlymodel = undefined;
  var1.enemymodel = undefined;
  var1.mountmantlemodel = undefined;
  var1.supportsownercapture = 0;
  var1.headicon = undefined;
  var1.minimapicon = undefined;
  var1.usepriority = -1;
  var1.usefov = 180;
  var1.timeout = undefined;
  var1.friendlyuseonly = 0;
  var1.ownerusetime = level.endgametutorial_func.spawnzombiedogtags;
  var1.otherusetime = level.endgametutorial_func.spawnzombiedogtags;
  var1.activatecallback = &ref_1228a;
  var1.capturecallback = &ref_1228b;
  var1.destroyoncapture = 1;
}

function ref_12292() {
  level endon("game_ended");
  var0 = level.endgametutorial_func.specialdayloadouts;
  var1 = level.endgametutorial_func.specialistbr - var0;
  ref_12294(var0);

  if(level.endgametutorial_func.parachutecancutautodeploy > 20) {
    wait level.endgametutorial_func.parachutecancutautodeploy - 20;
  }

  thread ref_12290(level, var1);
  wait 20;
  ref_12424("br_rumble_pe_bonus_point_crates_online");
  wait 3;
  ref_12294(var1, var0);
}

function ref_12294(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  for(var2 = 0; var2 < var0; var2++) {
    var3 = level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon[var2 + var1];
    var3 += (0, 0, 2000);
    var4 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "bonus_points_crate", var3, (0, randomint(360), 0));
    level.endgametutorial_func.ref_12e29.aq_ontimerupdate[level.endgametutorial_func.ref_12e29.aq_ontimerupdate.size] = var4;
    thread ref_1228d();
    thread ref_1228e();
    wait 2.5;
  }
}

function ref_1228d() {
  var0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("script_model", var0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("scr_smoke_grenade");
  wait 1;
  self.molotov_delete_oldest_trigger setscriptablepartstate("smoke", "on");
  self.molotov_delete_oldest_trigger setscriptablepartstate("br_rumble_bonus_point_audio", "smoke_sfx");
}

function ref_1228e() {
  self setscriptablepartstate("objective", "bonus_points_10");
}

function ref_12290(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  for(var2 = 0; var2 < var0; var2++) {
    if(!isDefined(level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon[var2 + var1])) {
      return;
    }

    thread ref_1228f(level);
    wait 2;
  }
}

function ref_1228f(var0) {
  var1 = level.endgametutorial_func.ref_12e2c.arena_bot_pickup_weapon[var0];
  scripts\mp\gametypes\br_quest_util::ref_140b1(var1, "dom");
}

function ref_1228a(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function ref_1228b(var0) {
  level.endgametutorial_func.ref_12e29.aq_ontimerupdate = scripts\engine\utility::array_remove(level.endgametutorial_func.ref_12e29.aq_ontimerupdate, self);
  self setscriptablepartstate("jugg_drop_beacon", "off");
  self setscriptablepartstate("bonus_points_audio", "expl_sfx");
  thread ref_1228c(level);
  self notify("captured");
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);
  var1 = randomintrange(3, 5);
  level thread _handlevehiclerepair::ref_13673("bonus_points_crate", self.origin, var1, 0);
  level scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.endgametutorial_func.spectateprop, 0);

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level._effect["small_snowhit"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function ref_1228c(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var2.team) && var2.team == var0) {
      var2 thread scripts\mp\hud_message::showsplash("br_rumble_pe_bonus_point_crate_captured_ally");
    }
  }
}

function activate_timed_laser_trap() {}

function ref_122d6() {
  level.endgametutorial_func.verbal_clip = spawnStruct();
  level.endgametutorial_func.verbal_clip.active = 0;
  ref_122df(level.endgametutorial_func.verbal_clip);
  level.endgametutorial_func.verbal_clip.inited = 1;
}

function ref_122d7() {
  if(getdvarint("scr_rumble_skip_event_wait_times", 0) == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("hvt_incoming", 0);
    scripts\mp\gametypes\br_publicevents::ref_13371("br_rumble_pe_kill_leader_event_incoming");
    wait 20;
  }

  level.endgametutorial_func.verbal_clip.active = 1;
  level.endgametutorial_func.verbal_clip.ref_13009 = [];
  ref_122dd(level.endgametutorial_func.verbal_clip);
  wait 3;
  thread ref_122e6();
  thread ref_122d9();
}

function ref_122da() {
  if(!isDefined(level.endgametutorial_func.verbal_clip.ref_13009)) {
    return;
  }

  var2 = 500;
  var3 = undefined;

  foreach(var5 in level.endgametutorial_func.verbal_clip.ref_13009) {
      if(var5.team == var0.team && var5 != var0) {
        var6 = distance2d(var5.origin, var1.origin) < var2;
        var7 = abs(var5.origin[2] - var1.origin[2]) < 500;
        var8 = var6 && var7;
        var9 = distance2d(var5.origin, var1.origin) < var2;
        var10 = abs(var5.origin[2] - var1.origin[2]) < 500;
        var11 = var9 && var10;

        if(var8 || var11) {
          var0 thread scripts\mp\rank::giverankxp("rumble_hvt_defend_kill", int(50), var0 getcurrentprimaryweapon());
          var0 thread scripts\mp\rank::scoreeventpopup("rumble_hvt_defend_kill");
          break;
        }
      }
    }

    <
    error > = undefined;
  var0 = undefined;
}

function ref_122d9() {
  level endon("game_ended");
  self endon("pe_kill_leader_event_end");
  var0 = gettime() + (level.endgametutorial_func.ref_122d0 - 3) * 1000;
  var1 = spawn("script_origin", (0, 0, 0));
  var1 hide();
  level.endgametutorial_func.verbal_clip.heli_arrived = var1;
  setomnvar("ui_publicevent_timer_type", 3);
  setomnvar("ui_publicevent_timer", var0);
  wait level.endgametutorial_func.ref_122d0 - 5 - 3;

  for(var2 = 0; var2 < 5; var2++) {
    var1 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  thread ref_122d2();
}

function ref_122d2(var0, var1) {
  level endon("game_ended");
  level.endgametutorial_func.verbal_clip.active = 0;

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(isDefined(level.endgametutorial_func.verbal_clip.heli_arrived)) {
    level.endgametutorial_func.verbal_clip.heli_arrived delete();
  }

  setomnvar("ui_publicevent_timer_type", 0);
  var2 = ref_122d4();
  var3 = "br_rumble_pe_kill_leader_event_end_early_contested";
  var4 = var0 == "hvt_team_wiped" && var2 != "contested";

  foreach(var6 in level.players) {
    if(var4) {
      if(var6.team == var2) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_enemies_down", var6, 0);
        var3 = "br_rumble_pe_kill_leader_event_end_early_eliminated_enemy";
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_friendlies_down", var6, 0);
        var3 = "br_rumble_pe_kill_leader_event_end_early_eliminated_ally";
      }
    }

    ref_12425(var6, var3);
  }

  ref_122d5(level.endgametutorial_func);
  ref_122e5();
  level.endgametutorial_func.verbal_clip.ref_13009 = [];
  self notify("pe_kill_leader_event_end");
}

function ref_122d1() {
  var0 = ref_122d3();
  var1 = var0["axis"];
  var2 = var0["allies"];

  if(var1 == 0 || var2 == 0 || level.endgametutorial_func.verbal_clip.ref_13009.size == 0) {
    var3 = 0;
    var4 = undefined;
    thread ref_122d2(level.endgametutorial_func.verbal_clip, "hvt_team_wiped");
    return;
  }
}

function ref_122d3() {
  var0 = 0;
  var1 = 0;
  var2 = [];
  GscBinSkip0(0x2e, "axis", 0);
}

function ref_122d4() {
  var0 = ref_122d3();
  var1 = var0["axis"];
  var2 = var0["allies"];

  if(var1 == var2) {
    return "contested";
  }

  return scripts\engine\utility::ter_op(var1 > var2, "axis", "allies");
}

function ref_122d5() {
  foreach(var1 in level.endgametutorial_func.verbal_clip.ref_13009) {
    ref_122e1(var1);
    ref_122e0(var1);
    var1.verbal_string.trial_thermite_watcher = 0;
    level scripts\mp\gamescore::giveteamscoreforobjective(var1.team, 5, 0);
    var1 thread scripts\mp\gametypes\br_plunder::ref_12627(50);
    thread ref_122d8();
  }
}

function ref_122d8() {
  self endon("death_or_disconnect");
  wait 4;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_survived", self, 0);
  ref_12425(self, "br_rumble_pe_kill_leader_event_survived_player", 5);
  thread scripts\mp\rank::giverankxp("rumble_hvt_survivor", 250, self getcurrentprimaryweapon());
  thread scripts\mp\rank::scoreeventpopup("rumble_hvt_survivor");
}

function ref_122e6() {
  var0 = ref_122d3();
  var1 = var0["axis"];
  var2 = var0["allies"];

  foreach(var4 in level.players) {
    if(isDefined(var4)) {
      switch (var4.team) {
        case "axis":
          var5 = scripts\engine\utility::string(var1) + scripts\engine\utility::string(var2) + scripts\engine\utility::string(1);
          var4 setclientomnvar("rebirth_tracked_teams", int(var5));
          break;
        case "allies":
          var5 = scripts\engine\utility::string(var2) + scripts\engine\utility::string(var1) + scripts\engine\utility::string(1);
          var4 setclientomnvar("rebirth_tracked_teams", int(var5));
          break;
      }
    }
  }
}

function ref_122e5() {
  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      var1 setclientomnvar("rebirth_tracked_teams", 0);
    }
  }
}

function ref_122eb(var0) {
  var1 = 0;
  var2 = 0;

  foreach(var4 in level.endgametutorial_func.verbal_clip.ref_13009) {
    switch (var4.team) {
      case "axis":
        var1++;
        break;
      case "allies":
        var2++;
        break;
    }
  }

  var6 = [];
  GscBinSkip0(0x2e, "axis", var1);
}

function ref_122de(var0) {
  if(!isDefined(var0.verbal_string)) {
    var1 = spawnStruct();
    var1.trial_thermite_watcher = 0;
    var1.ref_11f64 = undefined;
    var0.verbal_string = var1;
    return;
  }
}

function ref_122df() {
  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      ref_122de(var1);
    }
  }
}

function ref_122dc(var0, var1, var2) {
  if(!isDefined(var1) || !isDefined(level.endgametutorial_func.verbal_clip) || !isDefined(level.endgametutorial_func.verbal_clip.inited) || !level.endgametutorial_func.verbal_clip.active) {
    return;
  }

  if(scripts\engine\utility::array_contains(level.endgametutorial_func.verbal_clip.ref_13009, var1)) {
    var3 = isDefined(var2) && (var2 == "MOD_SUICIDE" || var2 == "MOD_FALLING") || isDefined(var0) && var0 == var1;
    ref_122ce(var1, var0, var3);
    ref_122e0(var1);
    ref_122e1(var1);
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var1.origin);
    playsoundatpos(var1.origin, "br_splash_vip_eliminated");

    if(level.endgametutorial_func.verbal_clip.ref_13009.size > 1) {
      thread ref_122e2(level.endgametutorial_func.verbal_clip);
    }

    var1.verbal_string.trial_thermite_watcher = 0;
    level.endgametutorial_func.verbal_clip.ref_13009 = scripts\engine\utility::array_remove(level.endgametutorial_func.verbal_clip.ref_13009, var1);

    foreach(var5 in level.players) {
      ref_122eb(var5, var1);
    }
  }

  ref_122d1();
}

function ref_122e2(var0) {
  level endon("game_ended");

  if(!isDefined(level.endgametutorial_func.verbal_clip.vfx_struct)) {
    level.endgametutorial_func.verbal_clip.vfx_struct = 0;
  }

  if(!level.endgametutorial_func.verbal_clip.vfx_struct) {
    level.endgametutorial_func.verbal_clip.vfx_struct = 1;
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_friendly_down", var0.team);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_enemy_down", scripts\engine\utility::get_enemy_team(var0.team));
    wait 8;
    level.endgametutorial_func.verbal_clip.vfx_struct = 0;
    return;
  }
}

function ref_122ce(var0, var1) {
  var2 = scripts\engine\utility::get_enemy_team(self.team);
  var3 = 4;
  var4 = 25;

  if(istrue(var1)) {
    var3 += 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var2, var3, 0);
    return;
  }

  if(isDefined(var0) && istrue(var0.ref_12827)) {
    var3 *= 2;
    var4 *= 2;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var2, var3, 0);

  if(isDefined(var0) && isPlayer(var0)) {
    var0 thread scripts\mp\gametypes\br_plunder::ref_12627(var4);
    return;
  }
}

function ref_122dd() {
  var0 = ["axis", "allies"];

  foreach(var2 in var0) {
    var3 = scripts\mp\utility\teams::getteamdata(var2, "players");
    var4 = 0;
    var5 = [];

    for(var6 = 0; var6 < 3; var6++) {
      var7 = undefined;
      var8 = 0;

      foreach(var10 in var3) {
        if(!isDefined(var10) || !scripts\mp\utility\player::isreallyalive(var10) || istrue(var10.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var5, var10.squadindex)) {
          continue;
        }

        if(var10.pers["kills"] > var8) {
          var7 = var10;
          var8 = var10.pers["kills"];
        }
      }

      if(isDefined(var7)) {
        ref_122db(var7);
        var5 = var7.squadindex;
        var4++;
        continue;
      }

      break;
    }

    var12 = 5 - var4;

    for(var6 = 0; var6 < var12; var6++) {
      var3 = scripts\engine\utility::array_randomize(var3);
      var7 = undefined;

      foreach(var14 in var3) {
        if(istrue(var14.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var5, var14.squadindex) || !scripts\mp\utility\player::isreallyalive(var14)) {
          continue;
        }

        var7 = var14;
      }

      if(isDefined(var7)) {
        ref_122db(var7);
        var5 = var7.squadindex;
        var4++;
        continue;
      }

      break;
    }
  }

  foreach(var10 in level.players) {
    if(!istrue(var10.verbal_string.trial_thermite_watcher)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_started", var10, 0);
      var10 thread scripts\mp\hud_message::showsplash("br_rumble_pe_kill_leader_event_start_as_hunter");
    }
  }
}

function ref_122db() {
  self.verbal_string.trial_thermite_watcher = 1;
  level.endgametutorial_func.verbal_clip.ref_13009 = scripts\engine\utility::array_add(level.endgametutorial_func.verbal_clip.ref_13009, self);
  thread ref_122e3();
  thread ref_122ed();
  thread scripts\mp\hud_message::showsplash("br_rumble_pe_kill_leader_event_start_as_target");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_hunted", self, 0, 0);
}

function ref_122ed() {
  level endon("game_ended");
  wait 8;
  self.verbal_string.ref_11c3e = [];
  self.verbal_string.ref_11c3e[0] = spawnStruct();
  self.verbal_string.ref_11c3e[1] = spawnStruct();
  self.verbal_string.ref_11c3e[0] scripts\mp\gametypes\br_quest_util::init_tactical_boxes(3, 5, 0, self.origin);
  self.verbal_string.ref_11c3e[1] scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 5, 0, self.origin);
  self.verbal_string.ref_11c3e[0] scripts\mp\gametypes\br_quest_util::ref_1316f(0);
  self.verbal_string.ref_11c3e[1] scripts\mp\gametypes\br_quest_util::ref_1316f(0);
  var0 = scripts\engine\utility::get_enemy_team(self.team);
  var1 = scripts\mp\utility\teams::getteamdata(var0, "players");

  foreach(var3 in level.players) {
    var4 = self.team == var3.team;
    self.verbal_string.ref_11c3e[scripts\engine\utility::ter_op(var4, 0, 1)] scripts\mp\gametypes\br_quest_util::ref_1336a(var3);
  }

  if(isDefined(self.verbal_string.ref_11c3e[0])) {
    thread ref_122ec(self.verbal_string.ref_11c3e[0]);
  }

  if(isDefined(self.verbal_string.ref_11c3e[1])) {
    thread ref_122ec(self.verbal_string.ref_11c3e[1], self);
    return;
  }
}

function ref_122ec(var0, var1) {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var0) || !isalive(var0) || !isDefined(self.mapcircle)) {
      break;
    }

    scripts\mp\gametypes\br_quest_util::ref_11dae(var0.origin);
    scripts\mp\gametypes\br_quest_util::ref_1316f(0);

    if(isDefined(var1)) {
      wait var1;
      continue;
    }

    waitframe();
  }

  ref_122e1(var0);
}

function ref_122e1() {
  if(!isDefined(self.verbal_string.ref_11c3e) || !isDefined(self.verbal_string.ref_11c3e[0]) || !isDefined(self.verbal_string.ref_11c3e[1])) {
    return;
  }

  foreach(var1 in self.verbal_string.ref_11c3e) {
    if(isDefined(var1)) {
      var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
      self.verbal_string.ref_11c3e[var2] = undefined;
    }
  }
}

function ref_122e3() {
  if(isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  var0 = "ui_mp_br_mapmenu_icon_plunder_leader";
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var1, "invisible");
  objective_position(var1, self.origin + (0, 0, 100));
  objective_setplayintro(var1, 0);
  objective_setshowoncompass(var1, 0);
  objective_setshowdistance(var1, 0);
  getbnetigrbattlepassxpmultiplier(var1, 0, 1150);
  getscriptcachecontents(var1, 0.2, 0.3);
  scripts\mp\objidpoolmanager::update_objective_icon(var1, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var1, 100);
  scripts\mp\objidpoolmanager::update_objective_onentity(var1, self);
  var2 = scripts\engine\utility::get_enemy_team(self.team);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var1, 6);

  if(!isDefined(self.verbal_string.ref_11f64)) {
    self.verbal_string.ref_11f64 = [];
  }

  self.verbal_string.ref_11f64[self.verbal_string.ref_11f64.size] = var1;

  if(!isDefined(self.verbal_string.ref_11f64)) {
    self.verbal_string.ref_11f64 = [];
  }

  self.verbal_string.ref_11f64[self.verbal_string.ref_11f64.size] = var1;
}

function ref_122e0() {
  if(!isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  foreach(var1 in self.verbal_string.ref_11f64) {
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(var1);
  }

  self.verbal_string.ref_11f64 = undefined;
}

function active_healthpacks() {}

function ks_airdropcratearmor(var0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  waitframe();
  var1 = [];

  foreach(var3 in var0) {
    var4 = level.endgametutorial_func.ref_12e2c.circle_radius - level.endgametutorial_func.spotlight_reach_goal_node_dist_sq;

    if(scripts\engine\utility::updatescrapassistdata(var3.origin, level.endgametutorial_func.ref_12e2c.ground_detection_think, var4)) {
      var1 = var3;
    }
  }

  var6 = [];
  var7 = [];
  var8 = [];

  foreach(var3 in var1) {
    var10 = distance(level.endgametutorial_func.ref_12e2c.spawnorigin["axis"], var3.origin);
    var11 = distance(level.endgametutorial_func.ref_12e2c.spawnorigin["allies"], var3.origin);
    var12 = abs(var10 - var11);

    if(var12 <= level.endgametutorial_func.spin_light) {
      var8 = var3;
      continue;
    }

    if(var10 < var11) {
      var6 = var3;
      continue;
    }

    var7 = var3;
  }

  var14 = int(min(var6.size / 2, var7.size / 2));
  var14 = int(min(var14, level.endgametutorial_func.spotlight_sweep_to_loc));
  var15 = int(min(var8.size / 2, level.endgametutorial_func.spotlight_speed));

  for(;;) {
    var6 = ref_135b9(var6, var14);
    var7 = ref_135b9(var7, var14);
    var8 = ref_135b9(var6, var15);
    level waittill("quest_tablets_refill");
  }
}

function ref_135b9(var0, var1) {
  var2 = [];
  var3 = int(var1);
  var0 = scripts\engine\utility::array_randomize(var0);

  for(var4 = 0; var4 < var0.size; var4++) {
    if(var3 > 0) {
      var5 = var0[var4];
      var5 scripts\mp\gametypes\br_quest_util::tabletshow();
      var3--;
      continue;
    }

    var2 = var0[var4];
  }

  return var2;
}

function forceunsetdemeanor(var0) {
  var1 = int(scripts\mp\utility\game::gettimepassed() / 1000);
  var2 = scripts\mp\utility\game::gettimelimit();
  var3 = int(level.endgametutorial_func.sprint_hint * var1 / 60);
  var4 = var1 / var2;
  var5 = level.endgametutorial_func.spotlimit;

  if(isDefined(var0) && var0 == 1) {
    var5 = level.endgametutorial_func.spoutfx;
  }

  var5 = int(var5 * var4);
  var6 = var3 + var5;
  return [var6, var3, var5];
}

function ref_13e4b() {
  scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outline_depth_rumble", "level_script");
}

function ref_12efb() {
  level endon("game_ended");
  var0 = 0;
  var1 = 0;
  var2 = getdvarint("scr_br_scorelimit");

  for(;;) {
    var3 = int(game["teamScores"]["allies"]);
    var4 = var3 / var2;
    var5 = int(game["teamScores"]["axis"]);
    var6 = var5 / var2;

    if(!var0) {
      if(var4 > 0.5 && var6 > 0.5) {
        var0 = 1;
        thread ref_12419(level, "tie");
      } else if(var4 > 0.5) {
        var0 = 1;
        thread ref_12419(level, "allies");
      } else if(var6 > 0.5) {
        var0 = 1;
        thread ref_12419(level, "axis");
      }
    } else if(!var1) {
      if(var4 > 0.9 && var6 > 0.9) {
        var1 = 1;
        thread ref_12419(level, "tie");
      } else if(var4 > 0.9) {
        var1 = 1;
        thread ref_12419(level, "allies");
      } else if(var6 > 0.9) {
        var1 = 1;
        thread ref_12419(level, "axis");
      }
    }

    waitframe();
  }
}

function ref_12419(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  switch (var0) {
    case "tie":
      var2 = "score_friendly_";
      var3 = "score_friendly_";
      break;
    case "allies":
      var2 = "score_friendly_";
      var3 = "score_enemy_";
      break;
    case "axis":
      var2 = "score_enemy_";
      var3 = "score_friendly_";
      break;
  }

  var2 = var2 + var1 + "_percent";
  var3 = var3 + var1 + "_percent";
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var2, "allies");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var3, "axis");
}

function carepackage_glowsticks() {
  level endon("game_ended");
  level.endgametutorial_func.spawnprotectionexception = 0;
  level.endgametutorial_func.spawnpointdanger = 0;

  for(;;) {
    level waittill("assassination_quest_completed", var0, var1);

    if(var0 == "axis") {
      level.endgametutorial_func.spawnprotectionexception++;
    } else {
      level.endgametutorial_func.spawnpointdanger++;
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var0, level.endgametutorial_func.spectatingthisplayer, 0);
  }
}

function beaker_end_time() {
  var0 = projectileunlinkonnote(self.waittill_drone_defined);

  if(self.type == "br_loot_cache_lege") {
    var1 = getdvarint("scr_brRumble_powerup_drop_in_cache_lege", 100);
  } else {
    var1 = getdvarint("scr_brRumble_powerup_drop_in_cache_base", 33);
  }

  var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  ref_119eb(var2, var1, var1);
}

function projectileunlinkonnote(var0) {
  if(!level.endgametutorial_func.spawnrisktoken) {
    return;
  }

  var1 = spawnStruct();
  var2 = recent_position_monitor();
  var3 = var2.ref_138fe;
  var4 = var2.splashtime_lzs;
  var1.hideextractionobjectivefromteam = var0.team != var3 && var4 >= 50;

  if(var1.hideextractionobjectivefromteam) {
    var1.hidehistoryhudfromplayer = -1;
    var5 = [50, 75, 100];
    var6 = [45, 55, 62];

    foreach(var8 in var5) {
      if(var4 >= var8) {
        var1.hidehistoryhudfromplayer = var5.size - var9;
        var1.hidehudclear = var6[var9];
      }
    }
  }

  return var1;
}

function ref_11ff6() {
  if(getdvarint("scr_brRumble_disable_game_end_on_timer", 0)) {
    return;
  }

  var0 = "tie";
  var0 = scripts\mp\gamescore::gethighestscoringteam();
  var1 = scripts\engine\utility::get_enemy_team(var0);
  logstring("[KEY_MOMENT] time limit, win: " + var0);
  thread scripts\mp\gametypes\br::brendgame(var0, game["end_reason"]["time_limit_reached"], 0);
}

function endgame(var0, var1, var2, var3) {
  scripts\mp\gametypes\br::brendgame(var0, var1, 0, var3);
}

function defenderflagbases(var0) {}

function defenderflagbase(var0) {
  if(isDefined(level.defensefactormod)) {
    wait level.defensefactormod - 0.5;
    return;
  }
}

function defenderflag_starts(var0) {
  var1 = scripts\engine\utility::ter_op(var0 == "axis", "allies", "axis");
  thread mpweapon();
  thread mp_t_gun_course_patch(level, var0);
  thread mp_speedball_check_trigger_pos(level);
  wait level.defensefactormod - 0.5;
  level thread scripts\mp\gametypes\br::ref_1209b(var1, 2, undefined, 1, 1, 1);
}

function mp_speedball_check_trigger_pos(var0) {
  level thread scripts\mp\gametypes\br::handleendgamesplash(var0);
  level thread scripts\mp\gametypes\br::setup_player_stealth(var0);

  if(istrue(level.ref_13364)) {
    var1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var3 in level.players) {
      if(var3.team != var0 && !isDefined(var3.shoulddropbrprimary)) {
        var3 setclientomnvar("post_game_state", var1);
        var3 setclientomnvar("ui_br_end_game_splash_type", 1);
        var3.shoulddropbrprimary = 1;
      }
    }

    return;
  }
}

function mp_t_gun_course_patch(var0, var1) {
  wait 1;

  if(var0 == "tie") {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_draw", 0, undefined, 1);
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("score_friendly_win", var0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("score_enemy_win", var1);
}

function mpweapon() {
  var0 = level.endgametutorial_func.spawnprotectionexception;
  var1 = level.endgametutorial_func.spawnpointdanger;

  if(isDefined(level.endgametutorial_func.buildblueprintpickupweapon)) {
    [[level.endgametutorial_func.buildblueprintpickupweapon]](var0, var1, level.endgametutorial_func.ref_12e2c.ref_13904);
  }

  var2 = game["teamScores"]["axis"];
  var3 = game["teamScores"]["allies"];

  if(isDefined(level.endgametutorial_func.build_our_weapon)) {
    [[level.endgametutorial_func.build_our_weapon]](var2, var3, level.endgametutorial_func.ref_12e2c.ref_13904);
    return;
  }
}

function dangercircletick(var0, var1) {
  foreach(var3 in level.endgametutorial_func.spawned_vehicles) {
    if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var3.origin)) {
      var4 = var3.maxhealth * 0.15;
      var3 dodamage(var4, var3.origin);
    }
  }
}

function ref_11aff(var0) {
  level endon("game_ended");
  wait 3;
  var1 = getdvarint("scr_brRumble_spawn_camp_trigger_radius", 4400);
  var2 = getdvarint("scr_brRumble_spawn_camp_trigger_height", 5000);
  var3 = getdvarint("scr_brRumble_spawn_camp_trigger_center_offset", 500);
  var4 = getdvarint("scr_brRumble_spawn_camp_trigger_z_offset", -1000);
  var5 = scripts\engine\utility::drop_to_ground(self.origin) + vectorNormalize(level.endgametutorial_func.ref_12e2c.ref_136a8[var0]) * var3;
  var5 += (0, 0, var4);
  var6 = spawn("trigger_radius", var5, 0, var1, var2);
  var6.ref_13ab7 = var0;
  var6 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 0, 2, var5);
  var6 scripts\mp\gametypes\br_quest_util::ref_1316f(var1);

  for(;;) {
    var6 waittill("trigger", var7);

    if(istrue(var7.trophy_get_best_tag) || !isPlayer(var7) && !isagent(var7) || var7.team == var0) {
      continue;
    }

    thread ref_11b0a(var7);
    wait 0.25;
  }
}

function ref_11b0a(var0) {
  self endon("disconnect");
  self.trophy_get_best_tag = 1;
  self setperk("specialty_radarblip", 1);
  thread scripts\cp_mp\killstreaks\helper_drone::markflash();
  var0 scripts\mp\gametypes\br_quest_util::ref_1336a(self);

  while(self istouching(var0) && isalive(self)) {
    thread scripts\cp_mp\killstreaks\helper_drone::markeduion();
    self waittill("markedUIUpdate");
    waitframe();
  }

  var0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
  self.trophy_get_best_tag = undefined;
  self unsetperk("specialty_radarblip", 1);
}

function ref_12425(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  if(isalive(var0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
    return;
  }

  thread ref_12981(var0);
}

function ref_12424(var0, var1) {
  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = undefined;

    if(isalive(var3)) {
      if(isDefined(var1)) {
        var4 = spawnStruct();
        var4.intvar = var1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var3, var0, var4);
      continue;
    }

    if(!isDefined(var4)) {
      var4 = spawnStruct();
    }

    var4.intvar = var1;
    var4.ref_136f3 = var0;
    thread ref_12981(var3);
  }
}

function ref_12981(var0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var0);

  while(isDefined(self) && isDefined(self.isflagcarrymode) && self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var2.ref_136f3, var2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}

function ref_11ff5(var0, var1, var2, var3, var4) {
  if(var1 == "body") {
    var0.waittill_drone_defined = var3;
  }

  if(var0.type == "br_reusable_loot_cache") {
    var5 = 150;
    thread ref_140b2(var0, var0.origin);
    return;
  }
}

function ref_140b2(var0, var1) {
  level endon("game_ended");
  self notify("util_remove_scriptables_nearby");
  self endon("util_remove_scriptables_nearby");
  var2 = 1000;
  wait getdvarint("scr_reusable_cache_recharge_time", 90);

  foreach(var4 in level.players) {
    if(distance(var4.origin, self.origin) < var2) {
      return;
    }
  }

  var6 = canceljoins(undefined, undefined, var0, var1);
  var6 = scripts\engine\utility::array_remove(var6, self);

  foreach(var8 in var6) {
    if(!issubstr(var8.type, "brloot_")) {
      continue;
    }

    if(var8 getscriptableisreserved()) {
      var8 freescriptable();
      continue;
    }

    var9 = var8 getscriptablepartnameatindex(0);
    var8 setscriptablepartstate(var9, "hidden", 1);
  }
}

function recent_position_monitor() {
  var0 = spawnStruct();
  var0.spawnproplist = int(game["teamScores"]["axis"]);
  var0.spawnpointangles = int(game["teamScores"]["allies"]);
  var0.splashtime_lzs = abs(var0.spawnproplist - var0.spawnpointangles);
  var1 = scripts\engine\utility::ter_op(var0.spawnproplist > var0.spawnpointangles, "axis", "allies");

  if(var0.spawnproplist == var0.spawnpointangles) {
    var1 = "contested";
  }

  var0.ref_138fe = var1;
  return var0;
}

function ref_130f1() {
  var0 = level.mapcorners[0].origin[0];
  var1 = level.mapcorners[1].origin[0];
  var2 = var1 - var0;
  var3 = level.mapcorners[0].origin[1];
  var4 = level.mapcorners[1].origin[1];
  var5 = var4 - var3;

  if(!isDefined(var2) || !isDefined(var2)) {
    return;
  }

  var6 = (level.endgametutorial_func.ref_12e2c.ground_detection_think[0] - var0) / var2;
  var7 = (level.endgametutorial_func.ref_12e2c.ground_detection_think[1] - var3) / var5;
  setDvar("MPPMSRPRS", var6);
  setDvar("MNMRTKRKLL", var7);

  if(level.endgametutorial_func.ref_12e2c.ref_13904 == "island_airfield" || level.endgametutorial_func.ref_12e2c.ref_13904 == "island_peak") {
    setDvar("MLNLOPPPK", 0.3);
    return;
  }

  setDvar("MLNLOPPPK", 0.23);
}

function activate_trap_object() {}

function ref_119f0() {
  level.endgametutorial_func.ref_119fc = [];
  var0 = [];
  GscBinSkip0(0x2e, "nothing", getdvarfloat("scr_brRumble_dom_flag_capture_lt_cash_loot_id_nothing_cash_table", 5));
}

function ref_119ec(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = level.endgametutorial_func.ref_119fc[var0];
  var2 = randomfloat(1);

  foreach(var4 in var1) {
    var5 = var4[2];
    var6 = var4[3];

    if(var2 >= var5 && var2 <= var6) {
      return var7;
    }
  }
}

function ref_119f7(var0, var1, var2) {
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var0);
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = (0, 0, randomfloatrange(0, 180));
  var3.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var3.dropstruct.ml_p3_to_safehouse_transition = scripts\engine\utility::ter_op(var2 == 1, 6 + randomintrange(1, 10), 6);
  var3.dropstruct.silencer_pick_up_monitor = 0;
  var4 = level.endgametutorial_func.ref_119fc[var1];

  for(var5 = 0; var5 < var2; var5++) {
    var6 = randomfloat(1);

    foreach(var8 in var4) {
      var9 = var8[2];
      var10 = var8[3];

      if(var6 >= var9 && var6 <= var10) {
        var11 = var12;

        if(var11 == "nothing") {
          continue;
        }

        switch (var1) {
          case "loot_table_dom_flag_capture_cash":
            var3.dropstruct.ml_p3_to_safehouse_transition += 2;
            break;
        }

        thread ref_119f6(var11, var3);
        var3.dropstruct.ml_p3_to_safehouse_transition += 2;
        waitframe();
      }
    }
  }
}

function ref_119f6(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var1.legendary = 0;

  if(issubstr(var0, "lege")) {
    var2 = randomintrange(5, 40);
    var1.dropstruct.ml_p3_to_safehouse_transition = var2;
    var1.legendary = 1;
  }

  var3 = var1.origin + (0, 0, var1.dropstruct.silencer_pick_up_monitor);
  var4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var0, var1.dropstruct, var3, var1.angles, 0, var1.legendary, 0);
  var1.dropstruct.silencer_pick_up_monitor += 15;
}

function ref_119f1(var0) {
  var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var1.origin = var0;
  var1.angles = (0, 0, randomfloatrange(0, 180));
  var1.ml_p3_to_safehouse_transition = randomintrange(1, 10);
  var1.silencer_pick_up_monitor = randomintrange(1, 10);
  return var1;
}

function ref_119e8(var0, var1) {
  var2 = [];
  var3 = 0;

  foreach(var5 in var0) {
    var3 += var5;
  }

  var7 = 0;
  var8 = getarraykeys(var0);
  var9 = undefined;

  foreach(var14, var5 in var0) {
    var2 = [];
    var11 = var5 / var3;

    if(var7 == 0) {
      var12 = 0;
      var13 = var11;
    } else {
      var12 = var9[3];
      var13 = var12 + var11;
    }

    var2 = [var5, var11, var12, var13];
    var9 = var2[var14];
    var7++;
  }

  level.endgametutorial_func.ref_119fc[var1] = var2;
}

function ref_119eb(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 100;
  }

  var3 = randomintrange(1, 101);
  var4 = undefined;
  var5 = undefined;

  if(istrue(var2.hideextractionobjectivefromteam)) {
    if(var2.hidehudclear < var3) {
      return;
    }

    var5 = ref_119ec("loot_table_random_powerup_favor_2x");
  } else {
    if(var1 < var3) {
      return;
    }

    var4 = _keypadscriptableused_bunkeralt::ref_1233d();
    var5 = "brloot_rumble_powerup_" + var4;
  }

  if(!isent(self) || self isscriptable()) {
    var6 = 35;
    var7 = 75;
    var7 += randomfloatrange(-10, 10);
    var8 = var6 + 55 + randomfloatrange(-5, 5);
    var9 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var0, self.origin, self.angles, undefined, var7, var8);
  } else {
    var9 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, self);
  }

  scripts\mp\gametypes\br_pickups::spawnpickup(var9, var9, 1, 1);
}

function active_drones() {}

function ref_13eee() {
  var0 = "any";
  var1 = level.endgametutorial_func.ref_12e2c.ground_detection_think + vectorNormalize(level.endgametutorial_func.ref_12e2c.ref_136a8["axis"]) * level.endgametutorial_func.ref_12e2c.circle_radius * level.endgametutorial_func.ref_12e2c.ref_13631;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "axis";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var2;
  thread ref_13ef2();
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "axis";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var2;
  thread ref_13ef2();
  thread ref_11aff(level.spawn_set_jugg_value.choosebestpropforkillcam);
  var1 = level.endgametutorial_func.ref_12e2c.ground_detection_think + vectorNormalize(level.endgametutorial_func.ref_12e2c.ref_136a8["allies"]) * level.endgametutorial_func.ref_12e2c.circle_radius * level.endgametutorial_func.ref_12e2c.ref_13631;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "allies";
  level.spawn_set_jugg_value.brjugg_cleanupents = var2;
  thread ref_13ef2();
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "allies";
  level.spawn_set_jugg_value.briskillstreakallowed = var2;
  thread ref_13ef2();
  thread ref_11aff(level.spawn_set_jugg_value.briskillstreakallowed);
}

function ref_13ef2() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("rumble_location_selected");
  var0 = scripts\engine\utility::ter_op(self.team == "axis", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var0)) {
    return;
  }

  self.origin = var0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var0);
}

function ref_13ee7() {
  self endon("disconnect");

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
}

function activate_emp_drone_pick_up() {}