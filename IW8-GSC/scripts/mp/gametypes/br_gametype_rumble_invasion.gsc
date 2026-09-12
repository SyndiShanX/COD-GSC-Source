/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_rumble_invasion.gsc
****************************************************************/

function activate_c4_for_pick_up() {}

function activate_laser_trap_parent() {}

function init() {
  table_getrole();
}

function table_getrole() {
  tarmac_techo_start();
  subwave_progression();
  takerevivepickup();
  scripts\mp\utility\sound::besttime("mp_tu_canteen_sfx");
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("playerCountLandmarks");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::ref_12b11("lastStandAllowed", &watch_flight_collision);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &relic_steelballs_health_boost);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &relic_steelballs_health_boost);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &being_hacked);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &init_relic_aggressive_melee);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::playerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("gulagWinnerRespawn", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_1264f);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipInfilSequence", &ref_133d6);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnInitialVehicles", &scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_13570);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addDropOnPlayerDeath", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::battle_tracks_hidetogglewidget);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addSpawnLootContents", &beaker_end_time);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("endGame", &defenderflag_starts);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerHandleRedeploy", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_125c4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipKioskUse", &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_1269b);
  scripts\cp_mp\utility\script_utility::registersharedfunc("aa_turret", "destroyedTurretThink", &scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_12d35);
  _keypadscriptableused_bunkeralt::init();
  _ispointinbadarea::init();
  _initignoredtabspergamemode::init();
  _keypadscriptableused::init();
  setDvar("voice_proximity_team", 1);
  setDvar("voice_proximity_enemy", 0);
  setDvar("voice_proximity_radius", -1);
  thread table_getaddblueprintattachments();
}

function tarmac_techo_start() {
  level.start_reach_exhaust_waste = spawnStruct();
  level.start_reach_exhaust_waste.ref_11b1e = getdvarint("scr_br_timelimit");
  level.start_reach_exhaust_waste.ref_13376 = getdvarint("scr_ri_showTeammateOutlineShader", 0);
  level.start_reach_exhaust_waste.spawnrope = getdvarint("scr_ri_default_spawn_height", 12000);
  level.start_reach_exhaust_waste.ref_127b6 = getdvarfloat("scr_ri_plunderDropPercent", 0);
  level.start_reach_exhaust_waste.ref_127b5 = getdvarfloat("scr_ri_plunderDropAmount", 5);
  level.start_reach_exhaust_waste.ref_127be = getdvarfloat("scr_ri_plunderKeepPercent", 1);
  level.start_reach_exhaust_waste.spin_fan_blades = getdvarint("scr_ri_points_per_kill", 1);
  level.start_reach_exhaust_waste.spectatingthisplayer = getdvarint("scr_ri_points_for_quest_completion", 5);
  level.start_reach_exhaust_waste.spawnrisktoken = getdvarint("scr_ri_comeback_mechanics_enabled", 1) == 1;
  level.start_reach_exhaust_waste.maphints = getdvarint("scr_ri_pe_dom_radius", 750);
  level.start_reach_exhaust_waste.ref_122a1 = getdvarint("scr_ri_pe_dom_capture_time", 30);
  level.start_reach_exhaust_waste.manualturret_watchturretusetimeout = getdvarfloat("scr_ri_pe_dom_stompRate", 2);
  level.start_reach_exhaust_waste.spawned_vehicles = [];
  level.start_reach_exhaust_waste.ref_14225 = ["tac_rover", "atv", "cargo_truck", "jeep", "little_bird_mg", "motorcycle"];
  level.start_reach_exhaust_waste.ref_12b1b = [];
  level.ref_14062 = getdvarint("scr_ri_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarfloat("scr_ri_defaultRespawnTime", 5);
  level.ref_13bcd = getdvarint("scr_ri_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_ri_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_ri_respawn_penalty_max", 15);
  level.ref_12ca7 = getdvarint("scr_ri_respawnHeightOverride", 12000);
  level.ref_12cb4 = getdvarint("scr_ri_respawn_time_disable", 0);
  level.ref_121cc = getdvarfloat("scr_ri_parachuteDeployDelay", 0.5);
  level.brking_initdialog = 1;
  level.spawn_set_jugg_value = spawnStruct();
  level.spawn_set_jugg_value.chosen = undefined;
  level.spawn_set_jugg_value.choppersupport_watchtargetrange = undefined;
  level.ref_133ea = getdvarint("scr_ri_skipWeaponDropOnDeath", 1);
  level.ref_133cd = getdvarint("scr_ri_skipEquipmentDropOnDeath", 1);
  level.playerismatchedplayerready = getdvarint("scr_ri_forceArmorDropOnDeath", 1);
  level.ref_133e6 = getdvarint("scr_ri_skipSuperDropOnDeath", 1);
  level.laststand = getdvarint("scr_ri_allowLastStand", 0);
  level.playerkillstreakgetownerlookatignoreents = !level.laststand;
  level.disable_back_light = 1;
  level.ref_13364 = 1;
  scripts\engine\scriptable::ref_12f5b("body", &ref_11ff5);
  thread tank_path();
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

function tank_path() {
  waittillframeend();
  scripts\mp\gametypes\br_rumble_invasion_aav_mp_wz_island::initstructs();
  level.aq_ontimerexpired = scripts\engine\utility::getStructArray("brRumbleInv_a_a_v_spawn_locations", "targetname");

  if(isDefined(level.aq_ontimerexpired)) {
    level.ref_13400.aq_ontimerexpired = [];

    foreach(var_1 in level.aq_ontimerexpired) {
      level.ref_13400.aq_ontimerexpired[level.ref_13400.aq_ontimerexpired.size] = [var_1.origin, var_1.angles];
    }

    return;
  }
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
  game["dialog"]["hvt_incoming"] = "hvt_incoming";
  game["dialog"]["hvt_started"] = "hvt_started";
  game["dialog"]["hvt_hunted"] = "hvt_hunted";
  game["dialog"]["hvt_survived"] = "hvt_survived";
  game["dialog"]["hvt_friendly_down"] = "hvt_friendly_down";
  game["dialog"]["hvt_all_friendlies_down"] = "hvt_friendlies_down";
  game["dialog"]["hvt_enemy_down"] = "hvt_enemy_down";
  game["dialog"]["hvt_all_enemies_down"] = "hvt_enemies_down_all";
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = var_3;
  level.waypointpulses[var_0] = var_4;
}

function ref_13bb1() {
  level waittill("br_dialog_initialized");
  level.disableinitplayergameobjects = 0;
}

function watch_flight_collision(var_0) {
  if(level.laststand) {
    return true;
  }

  return false;
}

function tabletreplace() {
  level.objective_locations = [4, 5, 13, 1, 100, 102, 6];
  level.manned_turret_createhintobject = 895;
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_dom::init();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_bonus_point_crate::init();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::init();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_bombardment::init();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_choppers::init();
  level.delete_crate_objectives = 1;
  var_0 = getdvarint("scr_br_pe_count", 3);
  level.ref_122cd = int(level.start_reach_exhaust_waste.ref_11b1e / (var_0 + 1));
  level.ref_122cc = 0;
  level.ref_13006 = [];
  var_1 = getdvarint("scr_br_pe_force_type", 0);

  if(var_1 != 0) {
    level.ref_13006[0] = var_1;
    level.ref_13006[1] = 6;
    level.ref_122cd = getdvarint("scr_br_pe_force_delay", 45);
    return;
  }

  for(var_2 = 0; var_2 <= var_0; var_2++) {
    for(var_3 = 0; !var_3; var_3 = 1) {
      var_4 = randomint(level.objective_locations.size);
      var_5 = level.objective_locations[var_4];

      if(isDefined(var_5) && !scripts\engine\utility::array_contains(level.ref_13006, var_5)) {
        level.ref_13006[level.ref_13006.size] = var_5;
      }
    }
  }
}

function strict_ff_disable() {
  var_0 = getdvarfloat("scr_ri_specialist_in_trucks_odds", 1);
  _handlevehiclerepair::ref_11a44("ai_convoy_killstreaks", "brloot_specialist_bonus", var_0);
}

function table_getaddblueprintattachments() {
  waitframe();
  level.ref_13b7e = &ref_13b66;
  level.ontimelimit = &ref_11ff6;
  level.endgame = &endgame;
  level.defenderflagreset = &defenderflagpickupscorefrozen;
  level.ref_12888 = &scripts\mp\gametypes\rumble_invasion\br_ri_spawns::emp_drone_proximity_explode;
  level.ph_endgame = undefined;

  if(!level.laststand) {
    scripts\mp\tweakables::settweakablevalue("player", "laststand", 0);
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\flags::gameflaginit("rumble_location_selected", 1);
  scripts\mp\flags::gameflaginit("infil_complete", 0);
  thread strict_ff_disable();
  thread tabletreplace();
  thread subtract_from_spawn_count_from_group();
  thread syringe_out();
}

function syringe_out() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "teamJuggMaxReached", &changecirclestateatlowtime);
  thread ref_13277(game["attackers"], "outline_ally");
  thread ref_13277(game["defenders"], "outline_ally");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.defensefactormod = 5;
  thread ref_12efb();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_13eee();
  thread carepackage_glowsticks();
  scripts\mp\gametypes\rumble_invasion\br_ri_dom::maphint_computerscriptableused();
  var_0 = level.allteamnamelist;

  foreach(var_2 in var_0) {
    level.teamdata[var_2]["index"] = var_3;
  }
}

function changecirclestateatlowtime() {
  return false;
}

function ref_13277(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_4 in var_2) {
    scripts\mp\utility\outline::outlineenableforteam(var_4, var_0, var_1, "level_script");
  }
}

function activate_battle_station() {}

function groundz() {
  level.br_level.ref_13884 = 1;
  level.start_reach_exhaust_waste.ref_12e2c = randgetpropsizetoallocate();

  if(!scripts\mp\flags::playerzombiethermalcleanup("rumble_location_selected ")) {
    scripts\mp\flags::gameflaginit("rumble_location_selected", 1);
  }

  level notify("rumble_location_selected");
  level.grouptorewards = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think;
  level.br_level.default_class_chosen = [level.grouptorewards];
  level.br_level.br_circledelaytimes = [level.start_reach_exhaust_waste.ref_11b1e * 2];
  level.br_level.br_circleclosetimes = [level.start_reach_exhaust_waste.ref_11b1e * 2];
  level.br_level.br_circleradii = [level.start_reach_exhaust_waste.ref_12e2c.circle_radius, level.start_reach_exhaust_waste.ref_12e2c.circle_radius];
  level.br_level.br_circleminimapradii = [level.start_reach_exhaust_waste.ref_12e2c.circle_radius];
  level.br_level.default_player_connect_black_screen = [0];
  level.br_level.default_suicidebomber_combat = [0];
  scripts\mp\gametypes\rumble_invasion\br_ri_spawns::tank_x1_capacity();

  if(!isDefined(level.br_circle)) {
    level.br_circle = spawnStruct();
  }

  level.br_circle.circleindex = 0;
  level.br_circle.starttime = gettime();
  level.br_circle.dangercircleent = spawnStruct();
  level.br_circle.dangercircleent.origin = [0, 0, 52780];
  level.br_circle.safecircleent = spawnStruct();
  level.br_circle.safecircleent.origin = [0, 0, 52780];
}

function relic_steelballs_health_boost() {
  return level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think;
}

function init_relic_aggressive_melee() {}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}

function activate_laser_trap() {}

function manage_fakebody_hides() {
  scripts\mp\deathicons::ref_12bfd();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isDefined(var_1)) {
      continue;
    }

    if(!isalive(var_1)) {
      var_1 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var_1.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var_1);
    }

    var_1 setclientomnvar("ui_br_infil_started", 1);
    var_1 setclientomnvar("ui_br_infiled", 1);
    var_1 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    var_2 = var_1 scripts\mp\gametypes\rumble_invasion\br_ri_spawns::rear_door_collision(0);
    var_3 = var_1 scripts\mp\gametypes\br_gulag::ref_1263e(var_2);
  }

  wait 2;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 thread scripts\mp\gametypes\rumble_invasion\br_ri_spawns::ref_12496();
  }

  thread ref_138cc();
  scripts\mp\flags::gameflagset("prematch_fade_done");
  scripts\mp\flags::gameflagset("infil_complete");
  waitframe();

  if(!getdvarint("scr_ri_quests_enabled", 1)) {
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

function activate_precision_use_lua() {}

function randgetpropsizetoallocate() {
  var_0 = spawnStruct();
  var_0.ground_detection_think = (7300, 3300, 0);
  var_0.circle_radius = 45600;
  var_0.ref_134ff = 45;
  var_0.ref_13500 = 225;
  var_0.ref_13564 = level.start_reach_exhaust_waste.spawnrope;
  var_0.ref_13565 = level.start_reach_exhaust_waste.spawnrope;
  var_0.ref_13502 = 0;
  var_0.ref_13501 = 30;
  var_0.ref_13532 = 0.9;
  var_0.ref_13531 = 0.99;
  var_0.ref_1354f = 0;
  var_0.ref_135aa = 1000;
  var_0.ref_135a9 = 3000;
  var_0.ref_136e1 = (0, 0, 0);
  var_0.ref_136e0 = (0, 0, 0);
  var_0.ref_122b5 = -1;
  scripts\mp\gametypes\br_rumble_invasion_veh_mp_wz_island::initstructs();
  level.start_reach_exhaust_waste.ref_14218 = [];
  var_1 = scripts\engine\utility::getStructArray("brRumbleInv_vehicle_spawns", "targetname");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      var_4 = var_3.script_parameters;

      if(!isDefined(level.start_reach_exhaust_waste.ref_14218[var_4])) {
        level.start_reach_exhaust_waste.ref_14218[var_4] = [];
      }

      level.start_reach_exhaust_waste.ref_14218[var_4] = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.ref_14218[var_4], var_3);
      ref_12b04(var_0, var_4, var_3.origin, var_3.angles);
    }
  }

  scripts\mp\gametypes\br_rumble_invasion_kiosk_mp_wz_island::initstructs();
  level.start_reach_exhaust_waste.wait_display_pavelow_boss_health_bar = scripts\engine\utility::getStructArray("brRumbleInv_kiosk_locations", "targetname");

  foreach(var_7 in level.start_reach_exhaust_waste.wait_display_pavelow_boss_health_bar) {
    ref_12ae8(var_7.origin, var_7.angles);
  }

  thread tac_rover();
  thread killed_enemies();
  level thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_bonus_point_crate::killed_by_chopper();
  thread kill_all_enemies();
  return var_0;
}

function killed_enemies() {
  waittillframeend();
  scripts\mp\gametypes\br_rumble_invasion_jug_mp_wz_island::initstructs();
  level.vehicle_isneutraltoplayer = scripts\engine\utility::getStructArray("brRumbleInv_jugg_drops", "targetname");
}

function kill_all_enemies() {
  scripts\mp\gametypes\br_rumble_invasion_spw_mp_wz_island::initstructs();
}

function tac_rover() {
  level endon("game_ended");

  if(level.start_reach_exhaust_waste.ref_12b1b.size < 1) {
    return;
  }

  while(!isDefined(level.br_armory_kiosk)) {
    waitframe();
  }

  wait 1;

  if(getdvarint("scr_ri_default_kiosk_spawns", 0) != 0) {
    level.start_reach_exhaust_waste.ref_12b1b = scripts\engine\utility::array_combine(level.start_reach_exhaust_waste.ref_12b1b, level.br_armory_kiosk.scriptables);
  }

  scripts\mp\gametypes\br_armory_kiosk::ref_131c0(level.start_reach_exhaust_waste.ref_12b1b);
}

function ref_12ae8(var_0, var_1) {
  var_2 = getgroundposition(var_0, 2.5);
  var_3 = easepower("br_plunder_box", var_2, var_1);
  level.start_reach_exhaust_waste.ref_12b1b[level.start_reach_exhaust_waste.ref_12b1b.size] = var_3;
}

function ref_12b04(var_0, var_1, var_2) {
  if(var_0 == "little_bird_mg" && getdvarfloat("lb_mg_spawn_percent", 100) < 1) {
    var_0 = "little_bird";
  }

  if(!isDefined(self.ref_141be)) {
    self.ref_141be = [];
  }

  self.ref_141be[self.ref_141be.size] = [var_0, var_1, var_2];
}

function activate_subway_track_trigger_hurt() {}

function ref_13b66() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = 0;
  level.manned_turret_createhintobject = 895;
  level.manifest_music_started = -1;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);
  var_6 = getdvarint("scr_ri_pe_wait", 1);
  scripts\mp\flags::gameflagwait("infil_complete");

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit()) {
      var_7 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var_8 = int(var_7 + 0.5);
      var_9 = level.start_reach_exhaust_waste.ref_11b1e - level.ref_122cd * (level.ref_122cc + 1);
      var_10 = 0;

      if(var_5 == 2 && var_8 % 2 == 1) {
        var_10 = 1;
      }

      if(var_8 == level.manned_turret_createhintobject) {} else if(var_8 == var_9 && level.ref_122cc < level.ref_13006.size - 1) {
        level thread scripts\mp\gametypes\br_publicevents::ref_12e1f(level.ref_13006[level.ref_122cc], var_6);
        level.ref_122cc++;
      } else if(var_8 == getdvarint("scr_ri_ot_start_time", 180) && !istrue(level.start_reach_exhaust_waste.inovertime)) {
        ref_13dad();
      } else if(!var_2 && (var_10 == 1 && var_8 == 61 || var_10 == 0 && var_8 == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        var_2 = 1;
      } else if(!var_3 && (var_10 == 1 && var_8 == 31 || var_10 == 0 && var_8 == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        level notify("match_ending_soon", "time");
        var_3 = 1;
      } else if(!var_2 && !var_3 && !var_4 && var_8 >= 30 && var_8 <= 45) {
        var_4 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
      }

      if(var_8 <= 10 || var_8 <= 30 && var_8 % var_5 == var_10) {
        if(!var_4 && var_8 <= 10) {
          var_4 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup", var_8);
        }

        level notify("match_ending_very_soon");
        var_11 = 1;

        if(var_8 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var_7) {
          var_10 = 0;
        }

        if(var_10) {
          var_12 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_6);
          playsoundatpos((0, 0, 0), var_12);
        }
      }

      if(var_6 - floor(var_6) >= 0.05) {
        wait var_6 - floor(var_6);
        continue;
      }
    }

    wait 1;
  }
}

function ref_13dad(var_0) {
  if(istrue(level.start_reach_exhaust_waste.inovertime) && !istrue(var_0)) {
    return;
  }

  level.start_reach_exhaust_waste.inovertime = 1;

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 thread scripts\mp\hud_message::showsplash("br_ri_overtime");
    }
  }

  if(isDefined(level.start_reach_exhaust_waste.verbal_clip) && istrue(level.start_reach_exhaust_waste.verbal_clip.active)) {
    level.start_reach_exhaust_waste.verbal_clip thread scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::obj_room_fire_10();
    return;
  }

  for(var_4 = level.ref_122cc; var_4 < level.ref_13006.size - 1; var_4++) {
    if(level.ref_13006[var_4] == 100) {
      level.ref_13006[var_4] = level.ref_13006[level.ref_13006.size - 1];
    }
  }
}

function ref_124fa() {
  var_0 = scripts\engine\utility::ter_op(self.team == "allies", "axis", "allies");
  self notify("ri_ot_trackTeam");
  self endon("ri_ot_trackTeam");
  var_1 = [self];
  var_2 = scripts\mp\gametypes\br_gametype_rebirth::getteamindex(var_0);
  var_3 = 2;
  scripts\mp\gametypes\br_gametype_rebirth::ref_14029(var_1, var_2, var_3);
  var_4 = getdvarfloat("scr_br_tracked_teams_clear_delay", 2.5);
  wait var_4;
  scripts\mp\gametypes\br_gametype_rebirth::ref_14029(var_1, 0, var_3);
}

function active_healthpacks() {}

function ref_13e4b() {
  scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outline_depth_rumble", "level_script");
}

function ref_12efb() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = getdvarint("scr_br_scorelimit", 1000);

  for(;;) {
    var_3 = int(game["teamScores"]["allies"]);
    var_4 = var_3 / var_2;
    var_5 = int(game["teamScores"]["axis"]);
    var_6 = var_5 / var_2;

    if(!var_0) {
      if(var_4 > 0.5 && var_6 > 0.5) {
        var_0 = 1;
        thread ref_12419(level, "tie");
      } else if(var_4 > 0.5) {
        var_0 = 1;
        thread ref_12419(level, "allies");
      } else if(var_6 > 0.5) {
        var_0 = 1;
        thread ref_12419(level, "axis");
      }
    } else if(!var_1) {
      if(var_4 > 0.9 && var_6 > 0.9) {
        var_1 = 1;
        thread ref_12419(level, "tie");
      } else if(var_4 > 0.9) {
        var_1 = 1;
        thread ref_12419(level, "allies");
      } else if(var_6 > 0.9) {
        var_1 = 1;
        thread ref_12419(level, "axis");
      }
    }

    if(!istrue(level.start_reach_exhaust_waste.ref_12fc4)) {
      if(var_4 >= 0.7 || var_6 >= 0.7) {
        ref_13dad();
      }
    }

    waitframe();
  }
}

function ref_12419(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  switch (var_0) {
    case "tie":
      var_2 = "score_friendly_";
      var_3 = "score_friendly_";
      break;
    case "allies":
      var_2 = "score_friendly_";
      var_3 = "score_enemy_";
      break;
    case "axis":
      var_2 = "score_enemy_";
      var_3 = "score_friendly_";
      break;
  }

  var_2 = var_2 + var_1 + "_percent";
  var_3 = var_3 + var_1 + "_percent";
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_2, "allies");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_3, "axis");
}

function carepackage_glowsticks() {
  level endon("game_ended");

  for(;;) {
    level waittill("assassination_quest_completed", var_0, var_1);
    level scripts\mp\gamescore::giveteamscoreforobjective(var_0, level.start_reach_exhaust_waste.spectatingthisplayer, 0);
  }
}

function beaker_end_time() {
  var_0 = projectileunlinkonnote(self.waittill_drone_defined);

  if(self.type == "br_loot_cache_lege") {
    var_1 = getdvarint("scr_ri_powerup_drop_in_cache_lege", 100);
  } else {
    var_1 = getdvarint("scr_ri_powerup_drop_in_cache_base", 33);
  }

  var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  ref_119eb(var_2, var_1, var_1);
}

function projectileunlinkonnote(var_0) {
  if(!level.start_reach_exhaust_waste.spawnrisktoken) {
    return;
  }

  var_1 = spawnStruct();
  var_2 = recent_position_monitor();
  var_3 = var_2.ref_138fe;
  var_4 = var_2.splashtime_lzs;
  var_1.hideextractionobjectivefromteam = var_0.team != var_3 && var_4 >= 50;

  if(var_1.hideextractionobjectivefromteam) {
    var_1.hidehistoryhudfromplayer = -1;
    var_5 = [50, 75, 100];
    var_6 = [45, 55, 62];

    foreach(var_8 in var_5) {
      if(var_4 >= var_8) {
        var_1.hidehistoryhudfromplayer = var_5.size - var_9;
        var_1.hidehudclear = var_6[var_9];
      }
    }
  }

  return var_1;
}

function ref_11ff6() {
  if(getdvarint("scr_ri_disable_game_end_on_timer", 0)) {
    return;
  }

  var_0 = "tie";
  var_0 = scripts\mp\gamescore::gethighestscoringteam();
  var_1 = scripts\engine\utility::get_enemy_team(var_0);
  logstring("[KEY_MOMENT] time limit, win: " + var_0);
  thread scripts\mp\gametypes\br::brendgame(var_0, game["end_reason"]["time_limit_reached"], 0);
}

function endgame(var_0, var_1, var_2, var_3) {
  scripts\mp\gametypes\br::brendgame(var_0, var_1, 0);
}

function defenderflagpickupscorefrozen(var_0) {}

function defenderflag_starts(var_0) {
  var_1 = scripts\engine\utility::ter_op(var_0 == "axis", "allies", "axis");
  thread mp_t_gun_course_patch(level, var_0);
  thread mp_speedball_check_trigger_pos(level);
  wait level.defensefactormod - 0.5;
  level thread scripts\mp\gametypes\br::ref_1209b(var_1, 2, undefined, 1, 1, 1);
}

function mp_speedball_check_trigger_pos(var_0) {
  level thread scripts\mp\gametypes\br::handleendgamesplash(var_0);
  level thread scripts\mp\gametypes\br::setup_player_stealth(var_0);

  if(istrue(level.ref_13364)) {
    var_1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var_3 in level.players) {
      if(var_3.team != var_0 && !isDefined(var_3.shoulddropbrprimary)) {
        var_3 setclientomnvar("post_game_state", var_1);
        var_3 setclientomnvar("ui_br_end_game_splash_type", 1);
        var_3.shoulddropbrprimary = 1;
      }
    }

    return;
  }
}

function mp_t_gun_course_patch(var_0, var_1) {
  wait 1;

  if(var_0 == "tie") {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_draw", 0, undefined, 1);
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("score_friendly_win", var_0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("score_enemy_win", var_1);
}

function dangercircletick(var_0, var_1) {
  foreach(var_3 in level.start_reach_exhaust_waste.spawned_vehicles) {
    if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_3.origin)) {
      var_4 = var_3.maxhealth * 0.15;
      var_3 dodamage(var_4, var_3.origin);
    }
  }
}

function ref_11aff(var_0) {
  level endon("game_ended");
  wait 3;
  var_1 = getdvarint("scr_ri_spawn_camp_trigger_radius", 4400);
  var_2 = getdvarint("scr_ri_spawn_camp_trigger_height", 5000);
  var_3 = getdvarint("scr_ri_spawn_camp_trigger_center_offset", 500);
  var_4 = getdvarint("scr_ri_spawn_camp_trigger_z_offset", -1000);
  var_5 = scripts\engine\utility::drop_to_ground(self.origin) + vectorNormalize(level.start_reach_exhaust_waste.ref_12e2c.ref_136a8[var_0]) * var_3;
  var_5 += (0, 0, var_4);
  var_6 = spawn("trigger_radius", var_5, 0, var_1, var_2);
  var_6.ref_13ab7 = var_0;
  var_6 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 0, 2, var_5);
  var_6 scripts\mp\gametypes\br_quest_util::ref_1316f(var_1);

  for(;;) {
    var_6 waittill("trigger", var_7);

    if(istrue(var_7.trophy_get_best_tag) || !isPlayer(var_7) && !isagent(var_7) || var_7.team == var_0) {
      continue;
    }

    thread ref_11b0a(var_7);
    wait 0.25;
  }
}

function ref_11b0a(var_0) {
  self endon("disconnect");
  self.trophy_get_best_tag = 1;
  self setperk("specialty_radarblip", 1);
  thread scripts\cp_mp\killstreaks\helper_drone::markflash();
  var_0 scripts\mp\gametypes\br_quest_util::ref_1336a(self);

  while(self istouching(var_0) && isalive(self)) {
    thread scripts\cp_mp\killstreaks\helper_drone::markeduion();
    self waittill("markedUIUpdate");
    waitframe();
  }

  var_0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
  self.trophy_get_best_tag = undefined;
  self unsetperk("specialty_radarblip", 1);
}

function ref_11ff5(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "body") {
    var_0.waittill_drone_defined = var_3;
  }

  if(var_0.type == "br_reusable_loot_cache") {
    var_5 = 150;
    thread ref_140b2(var_0, var_0.origin);
    return;
  }
}

function ref_140b2(var_0, var_1) {
  level endon("game_ended");
  self notify("util_remove_scriptables_nearby");
  self endon("util_remove_scriptables_nearby");
  var_2 = 1000;
  wait getdvarint("scr_reusable_cache_recharge_time", 90);

  foreach(var_4 in level.players) {
    if(distance(var_4.origin, self.origin) < var_2) {
      return;
    }
  }

  var_6 = canceljoins(undefined, undefined, var_0, var_1);
  var_6 = scripts\engine\utility::array_remove(var_6, self);

  foreach(var_8 in var_6) {
    if(!issubstr(var_8.type, "brloot_")) {
      continue;
    }

    if(var_8 getscriptableisreserved()) {
      var_8 freescriptable();
      continue;
    }

    var_9 = var_8 getscriptablepartnameatindex(0);
    var_8 setscriptablepartstate(var_9, "hidden", 1);
  }
}

function recent_position_monitor() {
  var_0 = spawnStruct();
  var_0.spawnproplist = int(game["teamScores"]["axis"]);
  var_0.spawnpointangles = int(game["teamScores"]["allies"]);
  var_0.splashtime_lzs = abs(var_0.spawnproplist - var_0.spawnpointangles);
  var_1 = scripts\engine\utility::ter_op(var_0.spawnproplist > var_0.spawnpointangles, "axis", "allies");

  if(var_0.spawnproplist == var_0.spawnpointangles) {
    var_1 = "contested";
  }

  var_0.ref_138fe = var_1;
  return var_0;
}

function activate_trap_object() {}

function takerevivepickup() {
  _handlevehiclerepair::init();
  level.start_reach_exhaust_waste.ref_119fc = [];
  var_0 = [];
  GscBinSkip0(0x2e, "nothing", getdvarfloat("scr_ri_dom_flag_capture_lt_cash_loot_id_nothing_cash_table", 5));
}

function ref_119ec(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = level.start_reach_exhaust_waste.ref_119fc[var_0];
  var_2 = randomfloat(1);

  foreach(var_4 in var_1) {
    var_5 = var_4[2];
    var_6 = var_4[3];

    if(var_2 >= var_5 && var_2 <= var_6) {
      return var_7;
    }
  }
}

function ref_119f7(var_0, var_1, var_2) {
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var_0);
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = (0, 0, randomfloatrange(0, 180));
  var_3.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_3.dropstruct.ml_p3_to_safehouse_transition = scripts\engine\utility::ter_op(var_2 == 1, 6 + randomintrange(1, 10), 6);
  var_3.dropstruct.silencer_pick_up_monitor = 0;
  var_4 = level.start_reach_exhaust_waste.ref_119fc[var_1];

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = randomfloat(1);

    foreach(var_8 in var_4) {
      var_9 = var_8[2];
      var_10 = var_8[3];

      if(var_6 >= var_9 && var_6 <= var_10) {
        var_11 = var_12;

        if(var_11 == "nothing") {
          continue;
        }

        switch (var_1) {
          case "loot_table_dom_flag_capture_cash":
            var_3.dropstruct.ml_p3_to_safehouse_transition += 3;
            break;
          case "loot_table_dom_flag_capture_weapons":
            var_3.dropstruct.ml_p3_to_safehouse_transition += 3;
            break;
        }

        thread ref_119f6(var_11, var_3);
        var_3.dropstruct.ml_p3_to_safehouse_transition += 2;
        waitframe();
      }
    }
  }
}

function ref_119f6(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1.legendary = 0;

  if(issubstr(var_0, "lege")) {
    var_2 = randomintrange(5, 40);
    var_1.dropstruct.ml_p3_to_safehouse_transition = var_2;
    var_1.legendary = 1;
  }

  var_3 = var_1.origin + (0, 0, var_1.dropstruct.silencer_pick_up_monitor);
  var_4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_0, var_1.dropstruct, var_3, var_1.angles, 0, var_1.legendary, 0);
  var_1.dropstruct.silencer_pick_up_monitor += 15;
}

function ref_119f1(var_0) {
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_1.origin = var_0;
  var_1.angles = (0, 0, randomfloatrange(0, 180));
  var_1.ml_p3_to_safehouse_transition = randomintrange(1, 10);
  var_1.silencer_pick_up_monitor = randomintrange(1, 10);
  return var_1;
}

function ref_119e8(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_3 += var_5;
  }

  var_7 = 0;
  var_8 = getarraykeys(var_0);
  var_9 = undefined;

  foreach(var_14, var_5 in var_0) {
    var_2 = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2 = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  level.start_reach_exhaust_waste.ref_119fc[var_1] = var_2;
}

function ref_119eb(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  var_3 = randomintrange(1, 101);
  var_4 = undefined;
  var_5 = undefined;

  if(istrue(var_2.hideextractionobjectivefromteam)) {
    if(var_2.hidehudclear < var_3) {
      return;
    }

    var_5 = ref_119ec("loot_table_random_powerup_favor_2x");
  } else {
    if(var_1 < var_3) {
      return;
    }

    var_4 = _keypadscriptableused_bunkeralt::ref_1233d();
    var_5 = "brloot_rumble_powerup_" + var_4;
  }

  if(!isent(self) || self isscriptable()) {
    var_6 = 35;
    var_7 = 75;
    var_7 += randomfloatrange(-10, 10);
    var_8 = var_6 + 55 + randomfloatrange(-5, 5);
    var_9 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, self.origin, self.angles, undefined, var_7, var_8);
  } else {
    var_9 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  }

  scripts\mp\gametypes\br_pickups::spawnpickup(var_9, var_9, 1, 1);
}