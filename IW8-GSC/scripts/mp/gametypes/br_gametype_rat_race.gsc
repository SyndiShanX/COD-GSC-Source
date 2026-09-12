/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_rat_race.gsc
*********************************************************/

function activate_laser_trap_parent() {}

function init() {
  if(getDvar("mapname") == "mp_wz_island") {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
    level.decoyassists = &groundz;
    scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &relic_steelballs_health_boost);
    scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &relic_steelballs_health_boost);
    scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  } else {
    level.deletequestobjicon = 1;
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("kioskXP");
  level.ratraceextractionhelienabled = getdvarint("scr_rat_race_heli_extraction_enabled", 1);

  if(!level.ratraceextractionhelienabled) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("teamSpectate");
  }

  if(getdvarint("scr_br_rat_race_latejoin", 1) != 0) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");

  if(getdvarint("scr_bmo_useKiosks", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("kiosk");
  }

  if(getdvarint("scr_bmo_enableTabletReplace", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
  }

  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerShouldRespawn", &ref_12691);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  level.ref_13abd = getdvarint("scr_dmz_teamPlunder", 0);
  level.disable_super_in_turret.ref_11b5d = getdvarint("scr_br_extract_max_extractions", 5);
  level.disable_super_in_turret.ref_11f3b = 0;
  level.disable_super_in_turret.player_enemy_cooldown = "tie";
  level.br_prematchffa = 0;
  setDvar("scr_br_allowLoadout", 1);
  level.ref_13be1 = [];
  level.ref_11a32 = [];
  level.onstun = [];
  level.fuckwithgravity = 0;
  level.fuel_stability_event_init = 0;
  level.fuel_stability_event_start = 0;
  var_0 = getdvarint("scr_dmz_win_cost", 3000);

  if(var_0 > 0) {
    var_0 *= 10;
    var_0 *= 100;
    setDvar("scr_br_scorelimit", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
  }

  setDvar("scr_br_magcount", 3);
  setDvar("scr_br_loadout_option", "nothing");
  setomnvar("ui_br_circle_state", 4);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  setdvarifuninitialized("scr_br_bank_alarm", 1);
  level.scriptedphysicaldofenabled = getdvarint("scr_dmz_giveLoadoutEveryTime", 1);
  level.trackriotshield_tryreset = getdvarint("scr_bmo_instantBleedOutSquadWipe", 1);
  level.debug_kill_tromeo = getdvarint("scr_bmo_bottomPercentageToAdjustEconomy", 50);
  level.ref_13bdf = getdvarint("scr_bmo_topPercentageToAdjustEconomy", 5);
  level.ref_14086 = getdvarint("scr_bmo_useMilestonePhases", 1);
  level.ref_11be6 = getdvarint("scr_rat_race_milestonePhase_VIPs", 0);
  level.ref_11be5 = getdvarint("scr_bmo_milestonePhase_LZs", 30);
  level.ref_11be3 = getdvarint("scr_bmo_milestonePhase_Drops", 50);
  level.ref_11be4 = getdvarint("scr_bmo_milestonePhase_Helis", 75);
  level.br_checkforlaststandwipe = getdvarint("scr_rat_race_airdrop_base_cash_amount", 2500);
  level.br_circle_init_func = getdvarint("scr_rat_race_airdrop_max_cash_pickup_count", 25);
  level.spawn_default_player_spawns = getdvarint("scr_bmo_hidePlacementUntilPercent", 10);
  level.spawn_convoy_and_move = getdvarint("scr_bmo_hideLeaderHashUntilPercent", 0);
  level.ref_13366 = getdvarint("scr_bmo_progressSplashesAndMusic", 1);
  level.ref_12fb3 = getdvarint("scr_bmo_secondsBeforePlacementUpdates", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("scr_bmo_disable_perc_announcements", 0);
  level.teammatelootleadermarkenabled = getdvarint("scr_rat_race_teammate_loot_leader_mark_enabled", 1);
  level.teammatelootleadermarkcount = getdvarint("scr_rat_race_teammate_loot_leader_mark_count", 3);
  level.ref_11a27 = getdvarint("scr_rat_race_loot_leader_mark_count", 6);
  level.ref_11b62 = getdvarint("scr_rat_race_loot_leader_mark_count", 6);
  level.ref_11a2a = getdvarint("scr_bmo_loot_leader_mark_size", 750);
  level.ref_11a31 = getdvarint("scr_dmz_loot_leader_one_per_team", 0) == 1;
  level.ref_11a37 = getdvarfloat("scr_rat_race_loot_leader_update_interval", 5);
  level.ref_11a38 = getdvarfloat("scr_rat_race_loot_leader_update_interval_blink", 2);
  level.ref_11a3b = getdvarint("scr_rat_race_circle_pulse_start", 800);
  level.ref_11a3a = getdvarint("scr_rat_race_circle_pulse_end", 200);
  level.ref_11a2b = getdvarint("scr_bmo_loot_leader_mark_size_dynamic", 1);
  level.ref_11a2d = getdvarint("scr_bmo_loot_leader_mark_info_strong_size", 250);
  level.ref_11a2e = getdvarint("scr_bmo_loot_leader_mark_info_strong_value", 5000);
  level.ref_11a2f = getdvarint("scr_bmo_loot_leader_mark_info_weak_size", 750);
  level.ref_11a30 = getdvarint("scr_bmo_loot_leader_mark_info_weak_value", 2500);
  level.ref_11a35 = getdvarint("scr_rat_race_loot_leader_mark_random_distance_offset_min", 100);
  level.ref_11a34 = getdvarint("scr_rat_race_loot_leader_mark_random_distance_offset_max", 250);
  level.onsquadeliminatedplacement = getdvarint("scr_bmo_loot_leader_expired_enabled", 0) == 1;
  level.ref_11a2c = getdvarint("scr_bmo_loot_leader_mark_top_teams", 0);
  level.ref_127c0 = getdvarfloat("scr_bmo_music_first", 0.3);
  level.ref_127c2 = getdvarfloat("scr_bmo_music_second", 0.5);
  level.ref_127c3 = getdvarfloat("scr_bmo_music_third", 0.75);
  level.ref_127c1 = getdvarfloat("scr_bmo_music_fourth", 0.9);
  level.ref_14062 = getdvarint("scr_dmz_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 20);
  level.ref_13bcd = getdvarint("scr_dmz_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_dmz_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_dmz_respawn_penalty_max", 15);
  level.ref_12ca7 = getdvarint("scr_bmo_respawnHeightOverride", 5000);
  level.ref_12cb4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.ref_121cc = getdvarfloat("scr_bmo_parachuteDeployDelay", 0.5);
  level.current_trigger = getdvarint("scr_dmz_bonusDeathPlunder", 0);
  level.current_volume_allies = getdvarint("scr_dmz_bonusDeathPlunder_ot", 0);
  level.ref_11b6c = getdvarint("scr_bmo_maxPlunderDropOnDeath", 20000);
  level.ref_11c40 = getdvarint("scr_bmo_minPlunderDropOnDeath", 0);
  level.ref_122f5 = getdvarint("scr_bmo_percentagePlunderDrop", 80);
  level.ref_127bc = getdvarint("scr_bmo_plunderFXOnDropThreashold", 750);
  level.ref_11b6b = getdvarint("scr_bmo_maxPlunderDropInOvertime", 20000);
  level.oic_loadouts = getdvarfloat("scr_bmo_executionCashMultiplier", 1);
  level.checkforcorrectinstance = getdvarint("scr_rat_race_autoAssignFirstQuest", 0);
  level.ref_12966 = getdvarint("scr_rat_race_questDomDistMin", 5000);
  level.ref_12965 = getdvarint("scr_rat_race_questDomDistMax", 10000);
  level.ref_12962 = getdvarint("scr_rat_race_questAssDistMin", 2500);
  level.ref_12961 = getdvarint("scr_rat_race_questAssDistMax", 30000);
  level.ref_12968 = getdvarint("scr_rat_race_questScavDistMin", 5000);
  level.ref_12967 = getdvarint("scr_rat_race_questScavDistMax", 10000);
  level.ref_1296a = getdvarint("scr_rat_race_questScavDistMin", 5000);
  level.ref_12969 = getdvarint("scr_rat_race_questScavDistMax", 30000);
  level.ref_139ea = getdvarfloat("scr_rat_race_questTabletReplaceEveryN", 1.5);
  level.ref_133ea = getdvarint("scr_bmo_skipWeaponDropOnDeath", 0);
  level.ref_133cd = getdvarint("scr_bmo_skipEquipmentDropOnDeath", 1);
  level.playerismatchedplayerready = getdvarint("scr_bmo_forceArmorDropOnDeath", 1);
  level.brjuggsettings = getdvarint("scr_bmo_allowFultonDropOnDeath", 1);
  level.ref_13ab9 = getdvarint("scr_bmo_score_exfil", 0) == 1;
  level.ref_13aba = getdvarint("scr_bmo_exfil_showvipteamonly", 0) == 1;
  level.ref_13abc = getdvarint("scr_bmo_vipteam_uav", 0) == 1;
  level.ref_13abb = getdvarint("scr_bmo_exfil_timer", 180);
  level.ref_13368 = getdvarint("scr_bmo_plunderextract_objicon_inworld", 1) == 1;
  level.ref_13363 = getdvarint("scr_bmo_extract_objicon_nonscriptable", 0);
  level.ref_13b85 = getdvarint("scr_bmo_timeout_plunderextract", 0);
  level.ref_11dad = getdvarint("scr_bmo_move_plunderextract_onuse", 0) == 1;
  level.overheatlimit = int(getdvarint("scr_bmo_extract_heli_health", 999) * 100);
  level.overheatreductionamount = getdvarint("scr_bmo_extract_heli_invulnerable", 1);
  level.choppergunner_handledangerzone = getdvarint("scr_bmo_extract_plunder_instant", 1);
  level.ref_127ba = getdvarint("scr_bmo_plunder_extract_alert", 1);
  level.ref_11b3f = getdvarint("scr_bmo_matchstart_extractsitedelay", 120);
  level.spawn_boss_wave_suicidebombers = getdvarint("scr_bmo_plunderextract_hide_unused", 1);
  level.ref_1323e = scripts\engine\utility::ter_op(getDvar("mapname") == "mp_br_mechanics", 0, getdvarint("scr_bmo_plunderextract_distribution", 1));
  level.ref_12f10 = getdvarint("scr_bmo_score_requires_banking", 0);
  level.disableplunderbanking = getdvarint("scr_rat_race_score_uses_deposited_plunder_only", 1);
  level.locale_defaults = getdvarint("scr_bmo_disable_win_on_score", 0);
  level.make_bomb_detonator_interact = getdvarint("scr_bmo_eom_ot_timer", 30);
  level.ref_13124 = level.make_bomb_detonator_interact > 0;
  level.ref_12191 = getdvarint("scr_bmo_ot_as_match_time", 1);
  level.chopperexif_fx_init = getdvarint("scr_bmo_eom_bank_to_end", 0);
  level.ref_11adc = getdvarint("scr_dmz_mapEdgeExtractionLocs", 0);
  level.ref_11c85 = &ref_126a6;
  level.needs_controller = getdvarint("scr_bmo_endMatchCameraTransitions", 1);
  level.ref_12192 = getdvarfloat("scr_bmo_overtimeCashMultiplier", 2);
  setomnvar("ui_br_overtime_cash_multiplier", level.ref_12192);
  level.loadout_updatebrammo = getdvarint("scr_bmo_disable_one_mil_announce", 0);
  level.lootchopper_modifyweapondamage = getdvarint("scr_dmz_loot_leader_update_on_pickup", 0) == 1;
  level.lootcontentsadjusteconomy_bottomtier = getdvarint("scr_dmz_win_cost", 3000) * 1000;
  level.lootchopper_isnearbyoccupiedspawns = getdvarint("scr_br_extract_cost", 300);
  level.lootchopper_oncrateuse = getdvarint("scr_br_extract_cost_min", 40);
  level.lootchopper_managespawns = getdvarint("scr_br_extract_cost_decrease", 20);
  level.ref_11c41 = getdvarint("br_min_plunder_extractions", 7);
  level.ref_11b6d = getdvarint("br_max_plunder_extractions", 7);
  level.disable_back_light = 1;
  level.ref_12a12 = spawnStruct();
  level.ref_12a12.ref_1404c = getdvarint("scr_rat_race_use_alternative_map_location_variant", 0) != 0;
  level.play_nag_players_hvt_callouts = &play_nag_intro_vo;
  ref_13208();
  ref_13209();
  level.ref_12a12.maphints = getdvarint("scr_rat_race_pe_dom_radius", 750);
  level.ref_12a12.ref_122a1 = getdvarint("scr_rat_race_pe_dom_capture_time", 90);
  level.ref_12a12.manualturret_watchturretusetimeout = getdvarfloat("scr_rat_race_pe_dom_stompRate", 2);
  level.ref_12a12.ref_1229c = getdvarint("scr_rat_race_pe_cash_drops_total_count", 10);
  level.ref_12a12.ref_12296 = getdvarint("scr_rat_race_pe_cash_drops_first_wave_count", 5);
  level.spawn_set_jugg_value = spawnStruct();
  level.spawn_set_jugg_value.chosen = undefined;
  level.spawn_set_jugg_value.choppersupport_watchtargetrange = undefined;
  level.ref_12a12.ref_13a9b = [];
  level.ref_12a12.ref_12482 = [];
  thread toggleusbstickinhand();
  thread teleportplayertoselection();
  thread subscribedlocale();
}

function toggleusbstickinhand() {
  waittillframeend();
  level.uavsettings["uav"].timeout = 60;
  scripts\mp\flags::gameflaginit("collect_done", 0);
  scripts\mp\flags::gameflaginit("helipad_wait_done", 0);
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  scripts\mp\flags::gameflaginit("activate_cash_lzs", 0);
  scripts\mp\flags::gameflaginit("activate_cash_drops", 0);
  scripts\mp\flags::gameflaginit("activate_cash_helis", 0);
  scripts\mp\flags::gameflaginit("infil_complete", 0);

  if(getDvar("mapname") != "mp_wz_island") {
    level.ref_12a12.ref_12e2c = put_objective_on_guy("default");
    tank_x1_capacity();
  }

  subwave_progression();
  thread init_plunder_heli_overrides();
  thread init_plunder_fulton_overrides();
  level.ref_11c76 = &dyn_door;
  level.elevator_lights_toggle = &ref_11c50;
  level.ononeleftevent = &ononeleftevent;
  level.onplayerkilled = &onplayerkilled;
  level.ref_12075 = &ref_12075;
  level.ref_13b7e = &ref_13b66;
  level.ontimelimit = &ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&ref_12601);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread ref_1325e();
  level.ref_11a29 = [];
  level.onstompeenemyprogressupdate = [];

  for(var_0 = 0; var_0 < level.ref_11a27; var_0++) {
    var_1 = 1;
    var_2 = scripts\engine\utility::ter_op(level.ref_11a2c > 0 && var_0 == 0, 5, 4);
    var_3 = spawnStruct();
    var_3.modifier = "";
    var_3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var_1, var_2);
    var_3 scripts\mp\gametypes\br_quest_util::ref_1316f(level.ref_11a2a);
    level.ref_11a29[var_0] = var_3;
    var_3 = spawnStruct();
    var_3.modifier = "";
    var_3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var_1, var_2, 2);
    var_3 scripts\mp\gametypes\br_quest_util::ref_1316f(level.ref_11a2a);
    level.onstompeenemyprogressupdate[var_0] = var_3;
  }

  level.teammatelootleadermarks = [];

  foreach(var_5 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
      continue;
    }

    level.teammatelootleadermarks[var_5] = [];

    for(var_0 = 0; var_0 < level.teammatelootleadermarkcount; var_0++) {
      var_3 = spawnStruct();
      var_3.modifier = "";
      init_tape_machine_animations(var_3, "ui_mp_br_mapmenu_icon_teammate_loot_leader_objective", "invisible");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objectiveiconid);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_3.objectiveiconid, 75);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_3.objectiveiconid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_3.objectiveiconid, 0);
      objective_setshowdistance(var_3.objectiveiconid, 0);
      level.teammatelootleadermarks[var_5][var_0] = var_3;
    }
  }

  if(!istrue(level.ref_14086)) {
    thread ref_12397();
  }

  thread ref_14364();
  level thread scripts\mp\gametypes\br_analytics::teamvehicles();
  cleanupents();

  if(level.ref_13abd) {
    if(level.ref_11a37 > 0) {
      thread ref_13ff1();
    }
  }

  if(level.ref_13368 && level.ref_13363) {
    thread init_relic_team_proximity();
  }

  if(level.ref_13b85 > 0) {
    scripts\mp\flags::gameflagwait("prematch_done");

    if(level.ref_11b3f > 0) {
      wait level.ref_11b3f;
    }

    thread ref_1386c();
  }

  if(istrue(level.ref_11adc)) {
    thread test_trigger_spawn();
  }

  level.ref_140d9 = [];
  level.ref_140d9[0] = "assassination";
  level.ref_140d9[1] = "domination";
  level.ref_140d9[2] = "scavenger";
  thread numextractions();

  if(istrue(level.needs_controller)) {
    thread test_pipe_fire();
  }

  var_7 = getdvarint("scr_bmo_c130OverrideSpeed", -1);

  if(var_7 > 0) {
    level.br_level.c130_speedoverride = var_7;
  }

  if(level.make_bomb_detonator_interact && level.ref_12191) {
    thread getburnfxstatepriority();
  }

  thread syringe_out();
}

function syringe_out() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\flags::gameflagwait("infil_complete");
  thread ref_13eee();
  thread ref_13fa8();
}

function getburnfxstatepriority() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = getdvarint("scr_br_timelimit");
  var_1 = int(max(var_0 - level.make_bomb_detonator_interact, 0));

  if(var_1 <= 0) {
    return;
  }

  wait var_1;
  level notify("end_circlestate_timer");
  thread ref_13dc8(level, undefined, undefined);
}

function ref_14363() {
  level endon("game_ended");
  level.audio_railyard_fires = [];
  level.audio_railyard_fires["uktl"] = "dx_bra_uktl_respawning_enemy_in_area";
  level.audio_railyard_fires["rutl"] = "dx_bra_rutl_respawning_enemy_in_area";
  level.audio_railyard_fires["bchr"] = "dx_bra_bchr_respawning_enemy_in_area";
  level.ref_121d0 = getdvarint("scr_parachute_overhead_warning_timeout_ms", 45000);
  level.ref_121ce = getdvarint("scr_parachute_overhead_warning_prematch_timeout_ms", 20000);
  level.ref_121cf = getdvarint("scr_parachute_overhead_warning_radius", 2000);
  level.ref_121cd = getdvarint("scr_parachute_overhead_warning_height", 3000);
  thread ref_144eb(level);
  scripts\mp\flags::gameflagwait("prematch_done");
  level notify("cancel_watch_parachuters_overhead");
  waitframe();
  thread ref_144eb(level);
}

function ref_14364() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread ref_127c6();
}

function cleanupents() {
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("me_electrical_box_street_01", 1);
}

function onplayerdisconnect(var_0) {
  if(isDefined(var_0) && scripts\mp\flags::gameflag("prematch_done")) {
    var_0 scripts\mp\gametypes\br_pickups::droponplayerdeath();

    if(isDefined(level.lootchopper_initspawninfo)) {
      if(level.teamdata[var_0.team]["players"].size == 0) {
        level.lootchopper_initspawninfo--;
        return;
      }

      return;
    }

    scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
    return;
  }
}

function ononeleftevent(var_0) {}

function ref_126f1(var_0) {
  self endon("disconnect");
  self waittill("do_welcome_splashes");
  wait 2;
  level thread scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
  scripts\mp\hud_message::showsplash("br_gametype_rat_race_welcome");

  if(istrue(level.checkforcorrectinstance) && istrue(level.br_prematchstarted)) {
    scripts\mp\gametypes\br_gametype_dmz::checkforlaststandwipe(self);
  }

  while(!self isonground()) {
    waitframe();
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
}

function ref_1365d(var_0) {
  if(istrue(level.dmztut_endgametransition) && scripts\mp\flags::gameflag("prematch_done") && level.mapname != "mp_br_mechanics") {
    var_1 = rear_door_collision(var_0);
    var_2 = spawnStruct();
    var_0.ref_1286f = var_1;
    var_0.ref_1286f.index = -1;
    thread ref_126a4(var_0);
    return true;
  }

  return false;
}

function ref_126a4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = level.teamdata[self.team]["nextRespawn"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(var_2 > 1 && !istrue(level.gameended)) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, undefined, 1);
  }

  if(istrue(level.gameended)) {
    level waittill("forever");
  }

  self.waitingtospawn = 1;
  scripts\mp\gametypes\br::emp_drone_proximity_explode(0);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);

  if(!istrue(level.skipprematchdropspawn)) {
    thread ref_1253a();
  }

  while(!isalive(self)) {
    waitframe();
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  scripts\mp\gametypes\br::ref_13f21(self);
  scripts\mp\damage::resetplayervariables();
  scripts\mp\gametypes\br::ending_fade_in();
  thread ref_13ee7();
  thread init_infil();
}

function ref_1253a() {
  self endon("disconnect");

  while(self.sessionstate != "playing") {
    waitframe();
  }

  thread scripts\cp_mp\parachute::startfreefall(0, 1, undefined, undefined, 1, 0);
  self skydive_deployparachute();
}

function relic_oneclip_stock_adjustment_monitor() {}

function ref_13c61() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  jumpiffalse(scripts\mp\gametypes\br_public::uniquelootitemid()) LOC_00000024;
  return;
}

function play_quarry_intro_vo() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["alivePlayers"].size > 0) {
      return level.teamdata[var_2]["alivePlayers"][0];
    }
  }

  return undefined;
}

function play_train_speaker_vo_internal() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["players"].size == 0) {
      return var_2;
    }
  }

  return "tie";
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\gametypes\br::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var_10 = getdvarint("scr_bmo_mode_splash_window", 7500);

  if(isDefined(level.ref_136f9) && level.ref_136f9 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("bm_vips_marked");
  }

  if(isDefined(level.ref_136f8) && level.ref_136f8 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("bm_extract_heli_start");
  }

  if(isDefined(level.ref_136f6) && level.ref_136f6 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("br_c130airdrop_incoming");
  }

  if(isDefined(level.ref_136f7) && level.ref_136f7 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("br_lootchopper_incoming");
  }

  ref_122a7(var_1, self);
}

function activate_trap_from_interaction() {}

function dyn_door(var_0) {
  return true;
}

function playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.ref_13749) || var_0 == 1) {
    var_1 = 1;
    wait var_1;
  }

  if(istrue(self.hasrespawntoken) && isDefined(level.ref_13bcd)) {
    var_2 = level.ref_13bcd;
  } else if(level.start_persistent_turbulence > 0) {
    var_2 = clamp(self.pers["deaths"] * level.start_persistent_turbulence, 0, level.start_pipe_room);
  } else if(isDefined(level.checkpoint_objective_id)) {
    var_2 = level.checkpoint_objective_id;
  } else {
    var_2 = getdvarint("scr_br_extract_spawn_wait", 20);
  }

  var_3 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 10);

  if(var_2 < var_3) {
    var_2 = var_3;
  }

  if(level.ref_12cb4 != 0) {
    var_2 = 0;
  }

  var_4 = getdvarfloat("scr_bmo_squad_wiped_stream_time", 5);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;

  if(istrue(self.ref_13749) || var_2 == 1) {
    var_5 = scripts\mp\gametypes\br_gulag::ref_125be();
    var_6 = scripts\mp\gametypes\br_gulag::ref_1263e(var_5);
    thread patchfix(0, var_2 > 1);
    wait var_4;
  } else if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_2 * 1000));
    var_7 = var_2 - var_3;
    var_8 = var_2 - var_7;
    var_9 = var_2 - getdvarfloat("scr_bmo_respawn_intermission_time", 6);
    thread patchfix(var_9);
    var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var_7);

    if(var_10 == "squad_wipe_death") {
      var_5 = scripts\mp\gametypes\br_gulag::ref_125be();
      var_6 = scripts\mp\gametypes\br_gulag::ref_1263e(var_5);
      thread patchfix(0, 1);
      wait var_4;
    } else {
      thread ref_1400c();
      var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var_8);

      if(var_10 == "squad_wipe_death") {
        var_5 = scripts\mp\gametypes\br_gulag::ref_125be();
        var_6 = scripts\mp\gametypes\br_gulag::ref_1263e(var_5);
        thread patchfix(0, 1);
        wait var_4;
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  var_5 = spawnStruct();

  if(getdvarint("scr_br_rat_race_respawn_to_squad", 1) == 1) {
    var_5 = scripts\mp\gametypes\br_gulag::ref_125be();
  } else {
    var_5 = rear_door_collision();
  }

  var_6 = scripts\mp\gametypes\br_gulag::ref_1263e(var_5);

  if(istrue(self.ref_13749)) {
    self.ref_13749 = 0;

    if(var_2 > 1 && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
    }
  }

  if(validate_demeanor(self.team)) {
    return;
  }

  if(istrue(self.hasrespawntoken)) {
    thread scripts\mp\gametypes\br_gulag::ref_13dcb(4);
    self.ref_13bcc = 1;
    scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  if(validate_demeanor(self.team)) {
    return;
  }

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && isDefined(level.ref_124e7)) {
    var_5 = scripts\engine\utility::getStruct(level.ref_124e7, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_5, 1, var_6, 1);
  scripts\mp\gametypes\br::ref_13f21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  thread ref_13ee7();
}

function ref_12691(var_0) {
  return true;
}

function ref_1400c() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var_0 = scripts\mp\gametypes\br_gulag::ref_125be();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var_0 = scripts\mp\gametypes\br_gulag::ref_125be(1);
        var_2 = scripts\mp\gametypes\br_gulag::ref_1263e(var_0);
      }
    } else {
      var_0 = scripts\mp\gametypes\br_gulag::ref_125be();
      var_2 = scripts\mp\gametypes\br_gulag::ref_1263e(var_0);
    }

    wait 1;
  }
}

function patchfix(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  var_2 = 1;
  thread fadeoutin();
  wait var_2 - 0.25;
  scripts\mp\gametypes\br::ending_fade_in();

  if(istrue(var_1)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 6);
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  }

  wait 0.25;

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252b();
    var_3 = scripts\mp\gametypes\br_gulag::ref_125be();
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(var_3.origin, var_3.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_3.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function activate_javelin_ammo_refill() {}

function ref_1325e() {
  level.disable_super_in_turret.overheatreductionrate = relic_squadlink_vision_debuff();
  thread ref_11a9e();
}

function relic_squadlink_vision_debuff() {
  var_0 = 2500;
  var_1 = level.br_level.br_mapcenter;
  var_2 = (0, randomfloatrange(0, 360), 0);
  var_3 = anglesToForward(var_2);
  var_4 = level.br_level.br_circleradii[0] * 2;
  var_5 = var_1 + var_3 * var_4;
  var_5 = scripts\mp\gametypes\br_c130::ref_1342e(var_1, var_5);
  var_6 = getEnt("airstrikeheight", "targetname");
  var_7 = (var_5[0], var_5[1], var_6.origin[2]);
  var_8 = tracegroundpoint(var_7);
  var_5 = var_8 + (0, 0, var_0);
  return var_5;
}

function ref_11a9e() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.disable_super_in_turret.objectiveiconid = var_0;

  if(var_0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_0, "current", level.disable_super_in_turret.overheatreductionrate, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
    return;
  }
}

function ref_1325f() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = relic_mythic_should_ai_play_pain();
  var_1 = scripts\mp\gametypes\br_quest_util::getquesttableindex("gt_extract_1");

  foreach(var_3 in level.players) {
    var_3 scripts\mp\gametypes\br_quest_util::ref_131ae(var_1);
    var_3 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(var_0);
  }
}

function relic_mythic_should_ai_play_pain() {
  var_0 = getdvarint("scr_br_extract_xp", 5000);
  var_1 = getdvarint("scr_br_extract_xp_min", 2000);
  var_2 = getdvarint("scr_br_extract_xp_decrease", 200);

  if(var_1 > 0) {
    var_0 = int(max(var_1, var_0 - level.disable_super_in_turret.ref_11f3b * var_2));
  }

  return var_0;
}

function ref_13354(var_0) {
  var_1 = level.teamdata[var_0]["players"];

  foreach(var_3 in var_1) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.disable_super_in_turret.objectiveiconid, var_3);
  }
}

function spawn_carriables_from_prefabs_min_max(var_0) {
  var_1 = level.teamdata[var_0]["players"];

  foreach(var_3 in var_1) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.disable_super_in_turret.objectiveiconid, var_3);
  }
}

function maxvehicledamagedivisor() {
  level.disable_super_in_turret.ref_11f3b++;
  level.disable_super_in_turret.spawn_weapon setvalue(level.disable_super_in_turret.ref_11f3b);
  thread spawn_vindia_assault3();
  thread spawn_vindia_assault3();
  var_0 = relic_healthpacks_think();
  level.disable_super_in_turret.spawn_trucks setvalue(var_0 * 100);

  foreach(var_2 in level.teamdata) {
    if(isDefined(var_2["teamCount"]) && var_2["teamCount"] > 0) {
      ref_14024(var_3);
      LOC_000000a9:
    }
    LOC_000000a9:
  }

  var_4 = relic_mythic_should_ai_play_pain();

  foreach(var_6 in level.players) {
    if(!validate_demeanor(var_6.team)) {
      var_6 thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      var_6 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(var_4);
    }
  }
}

function ref_131ca(var_0) {
  level.teamdata[var_0]["extracted"] = 1;
}

function validate_demeanor(var_0) {
  return istrue(level.teamdata[var_0]["extracted"]);
}

function brendgame() {
  wait 1.5;
  handleendgamesplash();
  scripts\mp\gamelogic::endgame_regularmp(level.disable_super_in_turret.player_enemy_cooldown, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

function handleendgamesplash() {
  foreach(var_1 in level.players) {
    if(!validate_demeanor(var_1.team)) {
      var_1 _calloutmarkerping_handleluinotify_added::ref_13133("post_game_state", 2);
    }
  }
}

function ref_1327a() {
  level endon("game_ended");
  var_0 = 120;
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled)) {
    level waittill("br_ready_to_jump");
  }

  waitframe();
  var_1 = init_relic_trex(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  var_1.alpha = 1;
  var_2 = scripts\mp\hud_util::createservertimer("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_3 = getdvarint("scr_br_extract_timecollect", 180);

  if(var_3 > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(var_3 * 1000));
    var_2 settimer(var_3);
    wait var_3;
  }

  scripts\mp\flags::gameflagset("collect_done");
  var_4 = getdvarint("scr_br_extract_timewaitactive", 180);

  if(var_4 > 0) {
    var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    thread spawn_vindia_assault3();
    setomnvar("ui_hardpoint_timer", gettime() + int(var_4 * 1000));
    var_2 settimer(var_4);
    wait var_4;
  }

  scripts\mp\flags::gameflagset("helipad_wait_done");
  var_5 = getdvarint("scr_br_extract_timeextract", 840);
  var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  thread spawn_vindia_assault3();
  setomnvar("ui_hardpoint_timer", gettime() + int(var_5 * 1000));
  var_2 settimer(var_5);
  var_6 = max(var_5 - var_0, 0);
  wait var_6;
  var_7 = max(var_5 - var_6, 0);
  var_2.color = (1, 0, 0);
  thread spawn_vindia_assault3();
  thread heli_assault2_death_watcher(var_7);
  wait var_7;
  var_2 destroy();
  thread brendgame();
}

function heli_assault2_death_watcher(var_0) {
  level endon("game_ended");

  while(var_0 > 0) {
    var_1 = 0;
    var_2 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_0);

    if(var_0 > 60 && var_0 % 10 == 0 || var_0 <= 60 && var_0 > 30 && var_0 % 2 == 0 || var_0 <= 30) {
      var_1 = 1;
    }

    if(var_1) {
      foreach(var_4 in level.players) {
        var_4 playlocalsound(var_2);
      }
    }

    var_0 -= 1;
    wait 1;
  }
}

function activate_stealth_settings() {}

function ref_13278() {
  var_0 = 155;
  var_1 = 15;
  var_2 = -3;
  var_3 = 3;

  if(level.ref_13abd) {
    var_4 = safehouse_regroup();
    var_5 = &"MP_BR_INGAME/WIN_COST_TEXT";
    var_6 = var_4;
  } else {
    var_4 = relic_healthpacks_think();
    var_5 = &"MP_BR_INGAME/EXTRACT_COST_TEXT";
    var_6 = var_4 * 100;
  }

  level.disable_super_in_turret.spawn_tugofwar_tank = init_relic_trex(var_5, undefined, "LEFT", "CENTER", var_6, var_3, undefined, undefined, 1);
  level.disable_super_in_turret.spawn_trucks = init_relic_trex(&"MP_BR_INGAME/EXTRACT_COST_MILLION", undefined, "LEFT", "CENTER", 65 + var_6, var_3, undefined, undefined, 1);
  level.disable_super_in_turret.spawncrossbowbolt = init_relic_trex(&"MP_BR_INGAME/YOUR_TEAM_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", 5 + var_5, var_3, undefined, undefined, 1);
  var_7 = 0;
  level.disable_super_in_turret.water_immunity_time = init_relic_trex(&"MP_BR_INGAME/LEADER_PLUNDER_TEXT", var_7, "CENTER", "CENTER", 0, var_3 + var_4, undefined, undefined, 1);

  foreach(var_9 in level.teamnamelist) {
    var_10 = init_relic_trex(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", 70 + var_5, var_3, undefined, var_9, 1);
    var_11 = init_relic_trex(&"MP_BR_INGAME/ST_PLACE", undefined, "RIGHT", "CENTER", -65 + var_5, var_3, undefined, var_9, 1);
    var_11 setvalue(1);
    var_10.placement = var_11;
    ref_131ce(var_9, var_10);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled)) {
    level waittill("br_ready_to_jump");
  }

  level.disable_super_in_turret.spawn_tugofwar_tank.alpha = 1;
  level.disable_super_in_turret.spawn_trucks.alpha = 1;
  level.disable_super_in_turret.spawncrossbowbolt.alpha = 1;
  level.disable_super_in_turret.water_immunity_time.alpha = 1;

  foreach(var_9 in level.teamnamelist) {
    var_10 = run_cleanup_funcs_for_unused_objectives(var_9);
    var_10.alpha = 1;
    var_10.placement.alpha = 1;
  }
}

function ref_131ce(var_0, var_1) {
  level.teamdata[var_0]["hudPlunder"] = var_1;
  var_1.plundercount = 0;
  var_1.ref_127b3 = 0;
}

function run_cleanup_funcs_for_unused_objectives(var_0) {
  return level.teamdata[var_0]["hudPlunder"];
}

function init_relic_trex(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_8)) {
    var_8 = 1.5;
  }

  if(isDefined(var_7)) {
    var_10 = newteamhudelem(var_7);
  } else if(isDefined(var_10)) {
    var_10 = newclienthudelem(var_10);
  } else {
    var_10 = newhudelem();
  }

  var_10.elemtype = "font";
  var_10.font = "default";
  var_10.fontscale = var_10;
  var_10.basefontscale = var_10;
  var_10.x = 0;
  var_10.y = 0;
  var_10.width = 0;
  var_10.height = int(level.fontheight * var_10);
  var_10.xoffset = 0;
  var_10.yoffset = 0;
  var_10.children = [];
  var_10 scripts\mp\hud_util::setparent(level.uiparent);
  var_10.hidden = 0;
  var_10.alpha = 0;
  var_10 scripts\mp\hud_util::setpoint(var_4, var_5, var_6, var_7);

  if(isDefined(var_2)) {
    var_10.label = var_2;
  }

  if(isDefined(var_3)) {
    var_10 setvalue(var_3);
  }

  if(isDefined(var_8)) {
    var_10.color = var_8;
  }

  return var_10;
}

function replace_access_card_on_deathordisconnect() {
  var_0 = level.br_plunder.ref_12954[level.br_plunder.ref_12954.size - 1] * 100;
  var_1 = int(ceil(level.lootcontentsadjusteconomy_bottomtier / var_0));
  var_2 = getdvarint("scr_rat_race_max_plunder_scriptable_drops_at_one_time_override", 50);

  if(var_1 > var_2) {
    var_1 = var_2;
  }

  return var_1;
}

function run_common_functions_solider_stealth(var_0) {
  return level.teamdata[var_0]["plunderInDeposit"];
}

function run_died_poorly_funcs(var_0) {
  if(isDefined(level.ref_12a12.ref_13a9b)) {
    return level.ref_12a12.ref_13a9b[var_0];
  }

  return undefined;
}

function run_blima_exfil_sequence(var_0) {
  var_1 = 0;

  if(!level.ref_12f10) {
    var_1 += level.teamdata[var_0]["plunderTeamTotal"];
    var_1 += level.teamdata[var_0]["plunderInDeposit"];
  }

  var_1 += level.teamdata[var_0]["plunderBanked"];
  return var_1;
}

function rpg_shoot_at_trigs(var_0) {
  return level.teamdata[var_0]["plunderTeamTotal"];
}

function registerontimerupdate(var_0) {
  return level.teamdata[var_0]["plunderBanked"];
}

function ref_134d8(var_0, var_1) {
  return var_0 > var_1;
}

function setobjectivecallbacks(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  _calloutmarkerping_handleluinotify_added::ref_13133(var_0, var_2);
}

function setoutputfunc(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  _calloutmarkerping_handleluinotify_added::ref_13134(var_0, var_2);
}

function ref_127c6() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = level.spawn_convoy_and_move != 0;
  level.ref_136f9 = undefined;
  level.ref_136f8 = undefined;
  level.ref_136f6 = undefined;
  level.ref_136f7 = undefined;
  var_9 = gettime();
  var_10 = getdvarfloat("scr_dmz_print_error_cutoff", 30);

  for(;;) {
    waittillframeend();
    var_11 = (gettime() - var_9) / 1000;
    var_12 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
    var_13 = safehouse_regroup();
    var_0 += level.framedurationseconds;

    if(istrue(level.ref_14086)) {
      var_14 = scripts\mp\flags::gameflag("placement_updates_allowed");
    } else {
      var_14 = var_0 > level.ref_12fb3;
    }

    var_15 = level.ref_13366 && var_14;
    var_16 = scripts\mp\gamescore::run_common_functions_stealth();
    var_17 = level.ref_13abd;
    var_18 = undefined;
    var_19 = undefined;
    var_20 = undefined;
    var_21 = [];
    var_22 = [];
    var_23 = [];
    var_24 = "none";
    var_25 = "none";
    var_26 = -1;
    var_27 = -1;

    foreach(var_29 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_29)) {
        continue;
      }

      var_30 = run_blima_exfil_sequence(var_29);
      var_31 = scripts\engine\utility::ter_op(level..disableplunderbanking, run_common_functions_solider_stealth(var_29), var_30);
      var_32 = registerontimerupdate(var_29);
      var_33 = ref_14025(var_31, var_29, level.disable_super_in_turret.player_enemy_cooldown);
      var_34 = revive_or_disconnect_monitor(var_29);
      var_35 = var_16[var_29];

      if(var_31 > var_26) {
        if(var_26 > var_27) {
          var_27 = var_26;
          var_25 = var_24;
        }

        var_26 = var_31;
        var_24 = var_29;
      } else if(var_24 != "none") {
        if(var_31 > var_27) {
          var_27 = var_31;
          var_25 = var_29;
        }
      }

      var_36 = (var_30 - var_32) * 100;
      var_37 = var_30 * 100;
      var_38 = var_37 - var_36;

      if(var_38 > 0) {}

      if(var_36 < 0) {
        var_36 = 0;
      }

      var_39 = var_31 * 100;

      if(var_39 >= var_13 * 0.9) {
        var_18 = var_29;
      } else if(var_39 >= var_13 * 0.75) {
        var_19 = var_29;
      } else if(var_39 >= var_13 * 0.5) {
        var_20 = var_29;
      }

      if(var_39 >= var_13 * level.ref_127c1) {
        thread scripts\mp\music_and_dialog::ref_12791();
      } else if(var_39 >= var_13 * level.ref_127c3) {
        thread scripts\mp\music_and_dialog::ref_127a7();
      } else if(var_39 >= var_13 * level.ref_127c2) {
        thread scripts\mp\music_and_dialog::ref_1278b();
      } else if(var_39 >= var_13 * level.ref_127c0) {
        thread scripts\mp\music_and_dialog::ref_127a9();
      }

      var_40 = scripts\mp\utility\teams::getfriendlyplayers(var_29, 0);

      foreach(var_42 in var_40) {
        var_35 = var_16[var_42.team];

        if(!var_6) {
          var_35 = 155;
        }

        var_42 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var_35);
        var_42 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_player_position", var_35);
        setobjectivecallbacks(var_42, "ui_br_team_cash_banked", int(var_38 * 0.01));
        setobjectivecallbacks(var_42, "ui_br_team_cash_pockets", int(var_36 * 0.01));
        var_22 = var_42.plundercount;
        var_23 = var_42;
      }

      if(var_15) {
        if(var_35 == 1) {
          var_21 = var_29;
        } else if(var_35 <= 5) {
          if(var_34 > 5) {
            showsplashtoteam(var_29, "bm_top_5");
          }
        } else if(var_35 <= 10) {
          if(var_34 > 10) {
            showsplashtoteam(var_29, "bm_top_10");
          }
        }
      }

      if(var_39 >= var_13) {
        if(var_17 && level.make_bomb_detonator_interact > 0 && !level.locale_defaults) {
          thread ref_13dc8(level, var_29);
          continue;
        }

        if(var_17 && level.make_bomb_detonator_interact > 0 && level.locale_defaults) {
          level.time_before_shoot = var_29;
          continue;
        }

        if(level.ref_13ab9 && !istrue(level.exfilactive)) {
          level.exfilactive = 1;
          thread ref_13839(level);
          continue;
        }

        if(!level.ref_13ab9 && var_17 && !level.locale_defaults) {
          thread searchradiusidealmin(level);
        }
      }
    }

    var_45 = [];
    var_46 = [];

    if(level.ref_11a2c == 1) {
      var_45 = setteamplacement(game["teamPlacements"], "up");
    } else if(level.ref_11a2c == 2) {
      var_45 = var_24;
      var_46 = setteamplacement(var_22, "down");
    } else {
      var_46 = setteamplacement(var_22, "down");
    }

    level.disable_super_in_turret.player_enemy_cooldown = var_24;

    if(var_24 == "none") {
      var_1 = [];
      waitframe();
      continue;
    }

    if(var_25 != "none") {
      setoutputfunc("ui_br_cash_second", int(var_27));
    }

    setoutputfunc("ui_br_cash_leader", int(var_26));

    if(!var_8 && var_26 * 100 >= var_13 * level.spawn_convoy_and_move * 0.01) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      var_8 = 1;
    }

    if(!istrue(var_7) && istrue(level.ref_14086)) {
      if(!var_2 && var_26 * 100 >= var_13 * level.ref_11be6 * 0.01) {
        var_2 = 1;
        level.ref_136f9 = gettime();
        scripts\mp\flags::gameflagset("placement_updates_allowed");

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          ref_13371("bm_vips_marked");
        }
      }

      if(!var_3 && (level.ref_12f10 || var_26 * 100 >= var_13 * level.ref_11be5 * 0.01)) {
        var_3 = 1;
        level.ref_136f8 = gettime();
        scripts\mp\flags::gameflagset("activate_cash_lzs");

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          scripts\mp\gametypes\br_public::brleaderdialog("extract_enabled", 0, undefined, undefined, undefined, "bm");
        }
      }

      var_4 = 1;
      var_5 = 1;

      if(!var_6 && var_26 * 100 >= var_13 * level.spawn_default_player_spawns * 0.01) {
        var_6 = 1;
      }

      if(var_2 && var_3 && var_4 && var_5) {
        var_7 = 1;
      }
    }

    if(!var_15) {
      waitframe();
      continue;
    }

    if(level.ref_11a2c > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
        ref_13ff0(var_22, var_46, var_23, var_45);
        level.ref_127d2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
      ref_13ff0(var_22, var_46, var_23);
      level.ref_127d2 = 0;
    }

    if(var_46.size != var_22.size) {
      var_46 = setteamplacement(var_22, "down");
    }

    updateteammatelootleadermarks(var_22, var_46, var_23);

    if(var_26 == 0) {
      waitframe();
      continue;
    }

    foreach(var_29 in var_21) {
      if(!scripts\engine\utility::array_contains(var_1, var_29)) {
        if(istrue(level.ref_13be1[var_29])) {
          if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
            showsplashtoteam(var_29, "bm_top_team_regained");
          }

          continue;
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          showsplashtoteam(var_29, "bm_top_team");
        }

        level.ref_13be1[var_29] = 1;
      }
    }

    if(var_21.size > 0) {
      foreach(var_29 in var_1) {
        if(!scripts\engine\utility::array_contains(var_21, var_29)) {
          showsplashtoteam(var_29, "bm_top_team_lost");
        }
      }
    }

    var_1 = var_21;
    level.ref_13be0 = var_24;
    level.ref_12884 = var_16;

    if(!var_12) {
      if(!level.fuel_stability_event_start && isDefined(var_18)) {
        level.fuel_stability_event_start = 1;

        if(var_11 < var_10) {
          ref_12892(level, "90 Percent", var_11);
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_18, "bm_first_to_90_them");
            showsplashtoteam(var_18, "bm_first_to_90_us");
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_90_perc_first", var_18, 1, undefined, "bm");

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_18) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_90_perc_enemy", var_52, 1, undefined, "bm");
              }
            }
          }
        }
      } else if(!level.fuel_stability_event_init && isDefined(var_19)) {
        level.fuel_stability_event_init = 1;

        if(var_11 < var_10) {
          ref_12892(level, "75 Percent", var_11);
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_19, "bm_first_to_75_them");
            showsplashtoteam(var_19, "bm_first_to_75_us");
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_75_perc_first", var_19, 1, undefined, "bm");

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_19) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_75_perc_enemy", var_52, 1, undefined, "bm");
              }
            }
          }
        }
      } else if(!level.fuckwithgravity && isDefined(var_20)) {
        level.fuckwithgravity = 1;

        if(var_11 < var_10) {
          ref_12892(level, "50 Percent", var_11);
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_20, "bm_first_to_50_them");
            showsplashtoteam(var_20, "bm_first_to_50_us");
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_50_perc_first", var_20, 1, undefined, "bm");

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_20) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_50_perc_enemy", var_52, 1, undefined, "bm");
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

function checkforovertime(var_0) {
  if(!isDefined(level.checkformatchend)) {
    level.checkformatchend = [];
  }

  if(scripts\engine\utility::array_contains(level.checkformatchend, var_0)) {
    return;
  }

  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  var_2 = scripts\mp\gametypes\br_plunder::init_subway_cars();
  var_2.ref_1244d = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.plundercount) && var_4.plundercount > 0) {
      var_4 scripts\mp\gametypes\br_plunder::ref_12618(var_4.plundercount, undefined, var_2);
    }
  }

  level.checkformatchend[level.checkformatchend.size] = var_0;
}

function ref_12192() {
  level thread scripts\mp\gametypes\br_plunder::ref_128a6(level.ref_12192);
}

function ref_12397() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.ref_12fb3)) {
    wait level.ref_12fb3;
  }

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

function revive_or_disconnect_monitor(var_0) {
  if(isDefined(level.ref_12884)) {
    return level.ref_12884[var_0];
  }

  return -1;
}

function ref_13371(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}

function showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_3 scripts\mp\hud_message::showsplash(var_1);
  }
}

function ref_13372(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team != var_0) {
      var_3 scripts\mp\hud_message::showsplash(var_1);
    }
  }
}

function ref_13dc6(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_1 = getdvarfloat("scr_bmo_900k_timer", 10);
  var_2 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var_2].value = var_1;
  level.overridewatchdvars[var_2] = var_1;
}

function ref_14024(var_0) {
  var_1 = run_cleanup_funcs_for_unused_objectives(var_0);
  var_2 = run_blima_exfil_sequence(var_0);
  var_3 = relic_healthpacks_think();

  if(var_2 >= var_3 && var_1.color != (0, 1, 0)) {
    var_1.color = (0, 1, 0);
    var_4 = level.teamdata[var_0]["players"];

    foreach(var_6 in var_4) {
      var_6 playlocalsound("br_plunder_atm_deposit_gtr");
    }

    return;
  }
}

function makepickup(var_0, var_1) {
  var_2 = level.teamdata[var_1]["players"];

  foreach(var_4 in var_2) {
    if(var_0 > 0) {
      if(isDefined(var_4.spawncorpsehider)) {
        var_5 = gettime() - var_4.spawncorpsehider;

        if(var_5 <= 6000) {
          break;
        }
      }

      var_3.spawncorpsehider = gettime();

      if(isalive(var_3)) {
        var_3 playlocalsound("br_plunder_atm_use");
      }

      continue;
    }

    var_3.spawncorpsehider = undefined;
    var_3 stoplocalsound("br_plunder_atm_use");
  }

  var_2 = undefined;
  var_4 = undefined;
}

function searchradiusidealmin(var_0) {
  if(istrue(level.ref_13dc0)) {
    return;
  }

  if(!istrue(level.ref_13dc0)) {
    thread ref_12893();
  }

  level.ref_13dc0 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
}

function playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return true;
  }

  if(istrue(level.gameended)) {
    return true;
  }

  if(istrue(self.unicornpoints)) {
    var_2 = self.plundercount;
    var_3 = self.plundercount;
    var_4 = 0;
  } else {
    jumpiffalse(isDefined(level.ref_11c40) && self.plundercount < level.ref_11c40) LOC_0000006c;
    var_4 = 0;
    var_2 = self.plundercount;
    var_3 = self.plundercount;
    goto LOC_00000095;
  }

  self.plundercountondeath = var_4;

  if(var_3 > 0) {
    scripts\mp\gametypes\br_plunder::ref_1261e(var_3);
  }

  if(var_2 >= level.ref_127bc) {
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 32));
  }

  var_5 = var_2;

  if(istrue(self.ref_14436)) {
    var_5 = int(var_2 * level.oic_loadouts);
  }

  var_6 = var_5;

  if(istrue(level.convoy_handle_stuck_compromise) && (!isDefined(var_4) || self != var_4)) {
    var_6 = int(var_5 * level.ref_12192);

    if(isDefined(level.ref_11b6b) && var_6 > level.ref_11b6b) {
      var_6 = level.ref_11b6b;
    }
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && istrue(self.get_vehicle_ai_spawner)) {
    var_6 = int(var_6 + self.get_vehicle_ai_spawner);
  }

  if(var_6 > 0) {
    var_7 = replace_access_card_on_deathordisconnect();
    var_8 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_6, var_3, var_7);

    foreach(var_10 in var_8) {
      var_10.ref_11a40 = "combat";
    }

    if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
      level notify("victim_death_drop", self, var_4, var_8);
    }
  }

  if(isDefined(var_4) && self == var_4 || !level.killcam) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_dropped", var_3);
  } else {
    self.ref_12801 = var_3;
  }

  scripts\mp\gametypes\br_analytics::ref_13c44(self, "combat", var_3 * -1);

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, self)) {
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 64));
  }

  return true;
}

function ref_12075() {
  if(isDefined(self.ref_12801)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_dropped", int(self.ref_12801));
    self.ref_12801 = undefined;
    return;
  }
}

function relic_healthpacks_think() {
  if(level.lootchopper_oncrateuse > 0) {
    var_0 = int(max(level.lootchopper_oncrateuse, level.lootchopper_isnearbyoccupiedspawns - level.disable_super_in_turret.ref_11f3b * level.lootchopper_managespawns));
  }

  return level.lootchopper_isnearbyoccupiedspawns;
}

function safehouse_regroup() {
  return level.lootcontentsadjusteconomy_bottomtier;
}

function ref_126c1(var_0) {
  if(self.plundercount < var_0) {
    var_0 = self.plundercount;
  }

  if(!isDefined(self.ref_127bb)) {
    self.ref_127bb = 0;
  }

  self.ref_127bb += var_0;
  scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount - var_0);
  return var_0;
}

function ref_13aa8(var_0) {
  var_1 = level.teamdata[var_0]["players"];

  foreach(var_3 in var_1) {
    var_3.ref_127bb = 0;
  }
}

function ref_13abf(var_0) {
  var_1 = level.teamdata[var_0]["players"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.ref_127bb)) {
      var_3 scripts\mp\gametypes\br_plunder::ref_12627(var_3.ref_127bb);
      var_3.ref_127bb = 0;
      var_3 iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

function spawn_vindia_assault3() {
  self endon("death");

  if(istrue(self.ref_1293b)) {
    return;
  }

  var_0 = 0.5;
  var_1 = 4;
  self.ref_1293b = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait var_0;
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self.ref_1293b = undefined;
}

function drophelicrate(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("military_skyhook_backpack");
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["position"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = sqrt(2 * var_7 / 800);
    var_1 moveTo(var_6, var_8, var_8, 0);
    wait var_8;
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_6);
  cratedropplunder(var_1);
  var_1 delete();
}

function cratedropplunder() {
  var_0 = relic_healthpacks_think();
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_2 = replace_access_card_on_deathordisconnect();
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_0, var_1, var_2);
}

function frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 1.57828e-05;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / 2 * var_4;
  var_7 *= 3600;
  var_7 += 1.5;
  return var_7;
}

function frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(30000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

function sortplayerplunderscores(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level.teamdata[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_state", var_0);
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_end_time", var_2);
  }
}

function smoke_door() {
  if(!isDefined(self.plunder)) {
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_success", self.team, 1);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in self.plunder) {
    var_0 += var_3.plundercount;

    if(var_3.player.team != self.team) {
      var_1 = 1;
    }
  }

  scripts\mp\gametypes\br_analytics::detonatefx(self.plunder.size, var_0, "little_bird", var_1, self.endpoint);
  level.br_plunder.oscope_sign_think += var_0;
  level.br_plunder.oscope_sign++;
  scripts\mp\gametypes\br_plunder::num_players_in_safehouse();
}

function heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
    return;
  }
}

function helicleanupdepotonleaving(var_0) {
  self.usable endon("death");
  scripts\engine\utility::waittill_either("leaving", "death");
  heliusecleanup();
}

function helicreateextractvfx(var_0) {
  self.vfxent = spawn("script_model", var_0);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

function helicleanupextract(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var_0) && isDefined(self.site)) {
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
    return;
  }
}

function snapshot_crate_spawn() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }

  wait 5;
  self.vfxent endon("death");
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

function spawnheli(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 99;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_4, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var_6)) {
    return;
  }

  var_7 = var_2 * (1, 1, 0);
  var_6.damagecallback = &callback_vehicledamage;
  var_6.speed = 50;
  var_6.accel = 99999;
  var_6.health = 1000;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6.defendloc = var_2;
  var_6.lifeid = 0;
  var_6.flaresreservecount = var_5;
  var_6.pathgoal = var_2;
  var_6.ref_121ff = var_3;
  var_6.endpoint = var_7;
  var_6.select_mountain_two_spawners = var_4[1];
  var_6.vehiclename = "magma_plunder_chopper";
  var_6 setCanDamage(1);
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  ref_13693(var_6);
  var_6 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  thread showquestcircletoplayer();
  thread handledestroydamage();
  thread smuggler_post_tele_kill();
  return var_6;
}

function ref_13693(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("br_plunder_extraction_delivery_rope");
  var_1 linkTo(var_0, "side_door_l_jnt", (11, 20, 42), (0, 180, 0));
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("br_plunder_extraction_delivery_bag");
  var_2 linkTo(var_1, "dyn_rope_end", (0, 0, 0), (0, 0, 0));
  var_0.rope = var_1;
  var_0.crate = var_2;
}

function smuggler_post_tele_kill() {
  self endon("heli_gone");
  self endon("swapped");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("death", var_2, var_3, var_4, var_5);
  ref_13abf(var_1);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var_2);
}

function smoke_enemy_think() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    self.crate delete();
    return;
  }
}

function snowballfighthint(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::ref_13ac7("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  helicleanupextract(1);
  smuggler_killed_early();
}

function smuggler_killed_early() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function smokesignal(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      helicleanupextract(1);
    }
  }
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function sol_3_4_pool() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  sortplayerplunderscores(3, self.player_weapon_fired_monitor);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.ref_121ff, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("goal");
  self stoploopsound();
  smoke_door();
  sortplayerplunderscores(0, 0);
  self notify("heli_gone");
  smuggler_killed_early();
}

function helidescend(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25, 31.25);
  thread snapplayertotoppos();
  thread snappointtooutofboundstriggertrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("test_f", var_2) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_m", var_3) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_b", var_4) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function tracegroundheight(var_0) {
  var_1 = 125;
  var_2 = tracegroundpoint(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

function tracegroundpoint(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

function heliwatchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread sol_3_4_pool();
}

function activate_gasmask() {}

function test_trigger_spawn() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_0[var_0.size] = (-33750, -36000, 155);
    var_0[var_0.size] = (-41550, -7950, 515);
    var_0[var_0.size] = (-37500, 15350, 1130);
    var_0[var_0.size] = (-31950, 52015, 2265);
    var_0[var_0.size] = (-18510, 64815, 1940);
    var_0[var_0.size] = (15565, 60050, 2680);
    var_0[var_0.size] = (44400, 39255, -50);
    var_0[var_0.size] = (59780, 13800, 555);
    var_0[var_0.size] = (61200, -8445, 30);
    var_0[var_0.size] = (59325, -38390, -210);
    var_0[var_0.size] = (8660, -36630, -640);
  } else {
    switch (level.mapname) {
      case "mp_br_mechanics":
        var_0[var_0.size] = (1500, 1500, 0);
        var_0[var_0.size] = (2500, 1500, 0);
        var_0[var_0.size] = (3500, 1500, 0);
        var_0[var_0.size] = (4500, 1500, 0);
        break;
      case "mp_mb_tut":
        break;
    }
  }

  level.outer = var_0;
  level.oscope_ampl_think = [];
  level thread ref_11d07();
}

function init_relic_noks(var_0) {}

function ref_11d07() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.outer) {
    var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_2, "active", var_1, "icon_waypoint_flag");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
    }

    thread ref_1364f(level);
  }

  for(;;) {
    foreach(var_1 in level.outer) {
      var_5 = scripts\mp\utility\player::getplayersinradius(var_1, 300);

      foreach(var_7 in var_5) {
        if(!scripts\engine\utility::array_contains(level.oscope_ampl_think, var_7) && !istrue(var_7.oscope_temp)) {
          open_spots_and_spawn_truck(var_7, var_1);
        }
      }
    }

    foreach(var_7 in level.oscope_ampl_think) {
      if(distancesquared(var_7.origin, var_7.oscope_temps_think) > 90000) {
        open_selected_doors(var_7);
        continue;
      }

      var_7.outline_ent_index -= level.framedurationseconds;

      if(var_7.outline_ent_index <= 0) {
        open_sliding_door(var_7);
      }
    }

    waitframe();
  }
}

function ref_1364f(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_2 = spawn("script_model", var_1 + (0, 0, 3));
  var_2 setModel("scr_smoke_grenade");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_red"), var_2, "tag_fx");
  var_2 playLoopSound("mp_flare_burn_lp");
}

function open_spots_and_spawn_truck(var_0) {
  self iprintlnbold("Extraction Start!");
  level.oscope_ampl_think = scripts\engine\utility::array_add(level.oscope_ampl_think, self);
  self.oscope_temps_think = var_0;
  self.outline_ent_index = 10;
  thread ref_13355();
}

function ref_13355() {
  self endon("death_or_disconnect");
  self endon("extactionCancel");

  while(self.outline_ent_index > 0) {
    self iprintlnbold("Extracting in " + scripts\engine\math::round_float(self.outline_ent_index, 1));
    waitframe();
  }
}

function open_selected_doors() {
  self notify("extactionCancel");
  self iprintlnbold("Extraction Canceled!");
  level.oscope_ampl_think = scripts\engine\utility::array_remove(level.oscope_ampl_think, self);
  self.oscope_temps_think = undefined;
  self.outline_ent_index = undefined;
}

function open_sliding_door() {
  self iprintlnbold("Extraction Complete!");
  level.oscope_ampl_think = scripts\engine\utility::array_remove(level.oscope_ampl_think, self);
  self.oscope_temp = 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_EXTRACTED");
}

function checkforlaststandwipe(var_0) {
  if(!isDefined(level.questinfo.teamsonquests) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, var_0.team)) {
    return;
  }

  var_1 = [];

  foreach(var_3 in level.ref_140d9) {
    var_1 = scripts\engine\utility::array_combine(var_1, getlootscriptablearrayinradius("brloot_" + var_3 + "_tablet"));
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_1) {
    var_9 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_8.origin);

    if(var_9 <= 16777216 && var_9 >= 16384) {
      var_0 scripts\mp\gametypes\br_quest_util::ref_13a38(var_8);
      return;
    }

    if(!isDefined(var_5) || var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  if(isDefined(var_5)) {
    var_0 scripts\mp\gametypes\br_quest_util::ref_13a38(var_5);
    return;
  }
}

function ref_11c50(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_4 == "circle_peek") {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function setupextractionsites(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  var_2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  foreach(var_4 in level.players) {
    if(var_1.size > 0 && scripts\engine\utility::array_contains(var_1, var_4)) {
      var_4 _calloutmarkerping_handleluinotify_added::ref_13133("post_game_state", var_2);
      var_4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_end_game_splash_type", 11);
      continue;
    }

    var_4 _calloutmarkerping_handleluinotify_added::ref_13133("post_game_state", var_2);
    var_4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_end_game_splash_type", 12);
  }
}

function ref_14025(var_0, var_1, var_2) {
  var_3 = scripts\mp\gamescore::_getteamscore(var_1);
  var_4 = var_0 - var_3;

  if(var_4 != 0) {
    var_5 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_public::uniquelootitemid(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(var_1, var_4, 0, undefined, var_5, var_2);
  }

  return var_4;
}

function ref_13ff1() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  var_0 = level.ref_11a37;
  var_1 = level.ref_11a38;
  var_2 = level.ref_11a3b;
  var_3 = level.ref_11a39;
  var_4 = var_0 - var_1;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");

  for(;;) {
    level.ref_127d2 = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", var_4);

    if(var_1 > 0) {
      foreach(var_6 in level.ref_11a29) {
        var_6.mapcircle setmapcirclestyleindex(2);
      }

      scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", var_1);

      foreach(var_6 in level.ref_11a29) {
        var_6.mapcircle setmapcirclestyleindex(0);
      }
    }
  }
}

function ref_13fcb(var_0, var_1, var_2) {
  var_3 = gettime();
  var_2 *= 1000;
  var_4 = int(var_3 + var_2);
  var_5 = abs(var_0 - var_1);

  for(;;) {
    var_3 = gettime();
    var_6 = clamp(1 - (var_4 - var_3) / var_2, 0, 1);
    var_7 = scripts\engine\utility::ter_op(var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6);
    setDvar("PPRTMPMQM", var_7);

    if(var_6 == 1) {
      break;
    }

    waitframe();
  }
}

function activate_pressure_sensor() {}

function ref_13ff0(var_0, var_1, var_2, var_3) {
  level.ref_11a36 = level.ref_11a32;
  level.ref_11a32 = [];
  level.ref_11a33 = [];

  if(level.ref_11a31) {
    if(istrue(level.convoy_handle_stuck_compromise)) {
      level.ref_11a27 = binoculars_checkpendingtimer();

      foreach(var_5 in level.ref_11a29) {
        var_5.mapcircle hide();
      }
    }
  }

  if(level.ref_11a2c == 1) {
    for(var_7 = 0; var_7 < level.ref_11a27; var_7++) {
      var_8 = removeplatepouch(var_7, var_0, var_3);

      if(isDefined(var_8)) {
        level.ref_11a32[level.ref_11a32.size] = var_2[var_8];

        if(istrue(level.onsquadeliminatedplacement)) {
          if(isDefined(var_2[var_8].onstim)) {
            ref_12c17(var_2[var_8].onstim);
          }
        }
      }
    }
  } else {
    jumpiffalse(level.ref_11a2c == 2) LOC_000001b4;
    var_8 = removeplatepouch(0, var_0, var_3);

    if(isDefined(var_8)) {
      level.ref_11a32[0] = var_2[var_8];

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_2[var_8].onstim)) {
          ref_12c17(var_2[var_8].onstim);
        }
      }
    }

    foreach(var_10 in var_1) {
      var_11 = var_2[var_10];
      var_12 = var_0[var_10];

      if(var_12 == 0) {
        break;
      }

      if(scripts\engine\utility::array_contains(level.ref_11a32, var_11)) {
        continue;
      }

      level.ref_11a32[level.ref_11a32.size] = var_11;

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_11.onstim)) {
          ref_12c17(var_11.onstim);
        }
      }

      if(level.ref_11a32.size == level.ref_11a27) {
        break;
      }
    }

    goto LOC_0000029d;
  }

  foreach(var_11 in level.ref_11a36) {
    if(isDefined(var_11) && !scripts\engine\utility::array_contains(level.ref_11a32, var_11)) {
      ref_12c18(var_11);
    }
  }

  for(var_7 = 0; var_7 < level.ref_11a27; var_7++) {
    var_22 = level.ref_11a29[var_7];

    if(isDefined(level.ref_11a32[var_7])) {
      var_22.targetplayer = level.ref_11a32[var_7];
      var_22.targetplayer.ref_11a26 = var_22;
      var_23 = (var_22.targetplayer.origin[0], var_22.targetplayer.origin[1], level.ref_11a2a);

      if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
        var_23 += scripts\engine\math::random_vector_2d() * randomfloatrange(level.ref_11a35, level.ref_11a34);
      }

      var_22 scripts\mp\gametypes\br_quest_util::ref_11dae(var_23);

      if(istrue(level.ref_11a2b)) {
        ref_13fef(var_22);
      }

      var_24 = scripts\engine\utility::array_contains(level.ref_11a32, var_22.targetplayer) && !scripts\engine\utility::array_contains(level.ref_11a36, var_22.targetplayer);
      var_25 = scripts\mp\utility\teams::getenemyplayers(var_22.targetplayer.team, 0);

      foreach(var_11 in var_25) {
        var_22 scripts\mp\gametypes\br_quest_util::ref_1336a(var_11);
      }

      var_28 = scripts\mp\utility\teams::getfriendlyplayers(var_22.targetplayer.team, 0);

      foreach(var_11 in var_28) {
        var_22 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_11);
      }

      if(var_24) {
        battle_tracks_updatebattletracks(var_22);
      }

      continue;
    }

    var_22.targetplayer = undefined;

    foreach(var_11 in level.players) {
      var_22 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_11);
    }
  }
}

function removeplatepouch(var_0, var_1, var_2) {
  var_3 = var_2[var_0];
  var_4 = 0;
  var_5 = 0;

  if(level.teamdata[var_3]["players"].size == 0) {
    return undefined;
  }

  var_6 = level.teamdata[var_3]["players"][0].guid;

  foreach(var_8 in level.teamdata[var_3]["players"]) {
    var_4 = var_1[var_8.guid];

    if(var_4 > var_5) {
      var_5 = var_4;
      var_6 = var_8.guid;
    }
  }

  return var_6;
}

function battle_tracks_updatebattletracks(var_0) {
  var_1 = var_0.targetplayer;

  if(scripts\mp\utility\player::isreallyalive(var_1)) {
    if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
      var_1 scripts\mp\hud_message::showsplash("bm_player_marked");
    }

    get_valid_seats(var_1);

    if(istrue(level.onsquadeliminatedplacement)) {
      thread watchforplayerdeath(var_1);
      return;
    }

    return;
  }
}

function ref_12c18(var_0) {
  if(isDefined(var_0.carriable_set_dropped)) {
    get_valid_starting_station_name_on_track(var_0);
  }

  if(isDefined(var_0.ref_11a26)) {
    foreach(var_2 in level.players) {
      var_0.ref_11a26 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_2);
    }

    var_4 = var_0.ref_11a26.guard_spawners;

    if(istrue(level.onsquadeliminatedplacement)) {
      battle_tracks_trystopdrivertogglethink(var_0, var_4);
    }

    var_0.ref_11a26.targetplayer = undefined;
    var_0.ref_11a26 = undefined;
  }

  level.ref_11a32 = scripts\engine\utility::array_remove(level.ref_11a32, var_0);
}

function watchforplayerdeath(var_0) {
  self endon("disconnect");
  self waittill("death");
  var_1 = self.ref_11a26.guard_spawners;
  ref_12c18(self);
  battle_tracks_trystopdrivertogglethink(self, var_1);
}

function battle_tracks_trystopdrivertogglethink(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level.onstun, var_0)) {
    return;
  }

  level.onstun = scripts\engine\utility::array_add(level.onstun, var_0);
  var_2 = undefined;

  foreach(var_4 in level.onstompeenemyprogressupdate) {
    if(!isDefined(var_4.targetplayer)) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_6 = undefined;

    foreach(var_4 in level.onstompeenemyprogressupdate) {
      if(!isDefined(var_6) || var_4.lastusedtime < var_6) {
        var_6 = var_4.lastusedtime;
        var_2 = var_4;
      }
    }

    var_2.targetplayer notify("stop_update");
  }

  var_2.targetplayer = var_0;
  var_2.lastusedtime = gettime();
  var_0.onstim = var_2;

  if(isDefined(var_1)) {
    var_2 scripts\mp\gametypes\br_quest_util::ref_11dae(var_1);
  } else {
    var_9 = (var_2.targetplayer.origin[0], var_2.targetplayer.origin[1], level.ref_11a2a);
    var_9 += scripts\engine\math::random_vector_2d() * randomfloatrange(level.ref_11a35, level.ref_11a34);
    var_2 scripts\mp\gametypes\br_quest_util::ref_11dae(var_9);
  }

  if(istrue(level.ref_11a2b)) {
    ref_13fef(var_2);
  }

  var_10 = scripts\mp\utility\teams::getenemyplayers(var_2.targetplayer.team, 0);

  foreach(var_4 in var_10) {
    var_2 scripts\mp\gametypes\br_quest_util::ref_1336a(var_4);
  }

  var_13 = scripts\mp\utility\teams::getfriendlyplayers(var_2.targetplayer.team, 0);

  foreach(var_4 in var_13) {
    var_2 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_4);
  }

  thread ref_13fd5(var_2);
}

function ref_13fd5(var_0) {
  var_0.targetplayer endon("stop_update");
  wait 5;
  ref_12c17(var_0);
}

function ref_12c17(var_0) {
  var_1 = var_0.targetplayer;
  level.onstun = scripts\engine\utility::array_remove(level.onstun, var_0.targetplayer);
  var_0.targetplayer.onstim = undefined;
  var_0.targetplayer = undefined;

  foreach(var_3 in level.players) {
    var_0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_3);
  }

  var_1 notify("stop_update");
}

function updateteammatelootleadermarks(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2) || !level.teammatelootleadermarkenabled) {
    return;
  }

  var_3 = [];
  var_4 = getdvarint("scr_rat_race_teammate_loot_leader_mark_min_plunder", 2000);

  foreach(var_6 in var_1) {
    var_7 = var_2[var_6];
    var_8 = var_0[var_6];

    if(var_8 < var_4) {
      break;
    }

    if(!isDefined(var_7) || scripts\mp\gametypes\br_public::updatelootleadersonfixedinterval(var_7)) {
      continue;
    }

    if(!isDefined(var_3[var_7.team])) {
      var_3 = [];
    }

    if(var_3[var_7.team].size >= level.teammatelootleadermarkcount) {
      continue;
    }

    var_3[var_3[var_7.team].size] = var_7;
  }

  foreach(var_11 in level.teamnamelist) {
    if(!isDefined(level.teammatelootleadermarks[var_11])) {
      continue;
    }

    var_12 = var_3[var_11];
    var_13 = [];
    var_14 = gettime();

    for(var_15 = 0; var_15 < level.teammatelootleadermarks[var_11].size; var_15++) {
      var_16 = level.teammatelootleadermarks[var_11][var_15];

      if(isDefined(var_16.nextupdatetime) && var_16.nextupdatetime >= var_14) {
        continue;
      }

      if(isDefined(var_16.player)) {
        var_17 = 1;

        if(isDefined(var_12) && scripts\engine\utility::array_contains(var_12, var_16.player)) {
          if(isDefined(var_16.player.teammatelootleadermarkindex) && var_16.player.teammatelootleadermarkindex == var_15) {
            var_17 = 0;
          }
        }

        if(var_17) {
          var_16.player.teammatelootleadermarkindex = undefined;
          var_16.player = undefined;
        }
      }

      if(!isDefined(var_16.player)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_16.objectiveiconid);
        var_13 = var_15;
      }
    }

    if(!isDefined(var_12)) {
      continue;
    }

    var_18 = 1000;

    foreach(var_7 in var_12) {
      if(!isDefined(var_7)) {
        continue;
      }

      if(isDefined(var_7.teammatelootleadermarkindex)) {
        continue;
      }

      if(var_13.size > 0) {
        var_20 = var_13[0];
        var_16 = level.teammatelootleadermarks[var_11][var_20];
        scripts\mp\objidpoolmanager::update_objective_onentity(var_16.objectiveiconid, var_7);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_16.objectiveiconid, var_11);
        var_16.nextupdatetime = var_14 + var_18;
        var_7.teammatelootleadermarkindex = var_20;
        var_16.player = var_7;
        var_13 = scripts\engine\utility::array_remove(var_13, var_20);
        continue;
      }

      break;
    }
  }
}

function get_valid_seats() {
  self attach("accessory_money_bag_large_closed_player", "tag_stowed_back3", 1, 1);
  self.carriable_set_dropped = "accessory_money_bag_large_closed_player";

  if(self tagexists("j_bag_left")) {
    playFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
  }

  thread get_type_to_drop();
}

function get_valid_starting_station_name_on_track() {
  if(isDefined(self) && isDefined(self.carriable_set_dropped)) {
    if(self tagexists("j_bag_left")) {
      killfxontag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
    }

    self detach(self.carriable_set_dropped, "tag_stowed_back3");
    self.carriable_set_dropped = undefined;
  }

  self notify("killthread_bagModelSwap");
}

function get_type_to_drop() {
  self notify("cashleader_trackDeath");
  self endon("cashleader_trackDeath");
  self endon("killthread_bagModelSwap");
  self waittill("death");
  get_valid_starting_station_name_on_track();
}

function get_unique_id() {
  level endon("game_ended");
  self notify("cashleader_trackVehicleEnter");
  self endon("cashleader_trackVehicleEnter");
  self endon("death");
  get_valid_starting_station_name_on_track();
  self waittill("player_vehicle_exit");

  if(isDefined(self) && isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, self)) {
    get_valid_seats();
    return;
  }
}

function ref_121b6(var_0) {
  var_1 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_1 == "kingslayer" || var_1 == "payload" || var_1 == "mendota") {
    return;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(self.plundercount)) {
    var_3 += self.plundercount;
  }

  if(isDefined(self.plunderbanked)) {
    var_3 += self.plunderbanked;
  }

  var_3 = int(var_3 / 10);

  if(var_3 > 4095) {
    var_3 = 4095;
  }

  var_2 = var_3;
  var_4 = 0;

  if(isDefined(self.ref_11c4f)) {
    var_4 += self.ref_11c4f;
  }

  if(var_4 > 15) {
    var_4 = 15;
  }

  var_2 += var_4 << 12;
  scripts\mp\utility\stats::setextrascore0(var_2);
}

function ref_121b4() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self.plundercount)) {
    var_1 += self.plundercount;
  }

  if(isDefined(self.plunderbanked)) {
    var_1 += self.plunderbanked;
  }

  var_1 = int(var_1 / 10);

  if(var_1 > 4095) {
    var_1 = 4095;
  }

  var_0 = var_1;
  var_2 = 0;

  if(isDefined(self.ref_11c4f)) {
    var_2 += self.ref_11c4f;
  }

  if(var_2 > 15) {
    var_2 = 15;
  }

  var_0 += var_2 << 12;
  return var_0;
}

function ref_12601() {
  self endon("disconnect");

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, self)) {
    scripts\mp\hud_message::showsplash("bm_player_marked");
    get_valid_seats();
    return;
  }
}

function ref_13fef(var_0) {
  if(isDefined(var_0.targetplayer.plundercount)) {
    var_1 = var_0.targetplayer.plundercount;
  } else {
    var_1 = 0;
  }

  var_1 = clamp(var_1, level.ref_11a30, level.ref_11a2e);
  var_2 = level.ref_11a2e - level.ref_11a30;
  var_3 = (var_1 - level.ref_11a30) / var_2;
  var_4 = level.ref_11a2f - level.ref_11a2d;
  var_5 = level.ref_11a2f - var_3 * var_4;
  var_1 scripts\mp\gametypes\br_quest_util::ref_1316f(var_5);
}

function binoculars_checkpendingtimer(var_0) {
  var_1 = 0;
  var_0 = scripts\mp\gamescore::run_common_functions_stealth();
  var_2 = safehouse_regroup();

  for(var_3 = 1; var_3 < level.ref_11b62 + 1; var_3++) {
    foreach(var_5 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
        continue;
      }

      if(var_0[var_5] != var_3) {
        continue;
      }

      var_6 = run_blima_exfil_sequence(var_5) * 100;

      if(var_6 >= var_2 || var_0[var_5] == 1) {
        var_1++;
      }
    }
  }

  if(var_1 > level.ref_11b62) {
    var_1 = level.ref_11b62;
  }

  return var_1;
}

function longdeathtracker(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 20;
  var_1 *= 100;
  var_5 = var_0.plundercount * 100;
  var_6 = var_5 + var_1;
  var_7 = var_6;
  var_8 = var_5;
  var_9 = var_8 - var_6;
  var_10 = scripts\engine\utility::sign(var_9);
  var_11 = var_9 / 2;
  var_12 = int(var_11 * 2 * level.framedurationseconds);

  if(var_12 == 0) {
    return;
  }

  var_13 = init_relic_trex(&"MP_BR_INGAME/PLUNDER_DEATH_LOSS", var_1, "RIGHT", "CENTER", var_2 + 46, var_3, undefined, undefined, 1.25, var_0);
  var_13.alpha = 1;
  var_14 = init_relic_trex(&"MP_BR_INGAME/YOUR_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", var_2, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_14.alpha = 1;
  var_15 = init_relic_trex(&"MP_BR_INGAME/EXTRACT_PLUNDER", var_6, "LEFT", "CENTER", var_2 + 45, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_15.alpha = 1;
  wait 1;

  while(var_7 != var_8) {
    var_7 += var_12;

    if(var_10 > 0 && var_7 > var_8 || var_10 < 0 && var_7 < var_8) {
      var_7 = var_8;
    }

    var_15 setvalue(var_7);
    wait level.framedurationseconds;
  }

  wait 3;
  var_13 destroy();
  var_14 destroy();
  var_15 destroy();
}

function activate_station() {}

function ai_shooting_timer(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }

  var_3 = [];
  var_4 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_4 = int(min(var_1, var_0.size));
  }

  if(level.ref_1323e) {
    var_5 = 0;
    jumpiffalse(level.binoculars_checkexpirationtimer > 0 && istrue(var_2)) LOC_000000d8;
    var_6 = 0;

    for(var_7 = 0; var_7 < var_4; var_7++) {
      if(var_6 > level.ref_121bb.size - 1) {
        var_6 = 0;
      }

      var_8 = level.ref_121bb[var_6];

      foreach(var_10 in var_0) {
        if(ref_127dd(var_10.origin, var_8, level.ref_127de)) {
          var_3 = var_10;
          var_0 = scripts\engine\utility::array_remove(var_0, var_10);
          break;
        }
      }

      var_6++;
    }

    goto LOC_000001e2;
  } else if(var_4.size > 0) {
    var_4 = scripts\engine\utility::array_randomize(var_4);
    var_8 = int(min(var_5, var_4.size));

    for(var_7 = 0; var_7 < var_8; var_7++) {
      var_7 = var_4[var_7];
    }
  }

  if(istrue(level.spawn_boss_wave_suicidebombers)) {
    foreach(var_21 in var_4) {
      if(!scripts\engine\utility::array_contains(var_7, var_21)) {
        var_21 setscriptablepartstate(var_21.type, "hidden");
      }
    }
  }

  return var_7;
}

function ref_127dd(var_0, var_1, var_2) {
  var_3 = var_1[0] - var_2;
  var_4 = var_1[0] + var_2;
  var_5 = var_1[1] - var_2;
  var_6 = var_1[1] + var_2;
  return var_0[0] >= var_3 && var_0[0] <= var_4 && var_0[1] >= var_5 && var_0[1] <= var_6;
}

function ai_weapons_free(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }

  var_2 = undefined;

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!scripts\engine\utility::array_contains(level.br_plunder_sites, var_0[var_3])) {
        var_2 = var_0[var_3];
        break;
      }
    }
  }

  return var_2;
}

function play_tape_machine_animations(var_0) {
  var_1 = ai_weapons_free(scripts\mp\gametypes\br_plunder::register_vfx(), level.ref_11b6d);
  var_1.disabled = undefined;
  var_1.snapshot_crate_player_at_max_ammo = undefined;
  var_2 = scripts\engine\utility::ter_op(level.ref_13368 && !level.ref_13363, var_1.audio_jugg_spawn, var_1.audio_shf_kill_hangar_lights);
  var_1 setscriptablepartstate(var_1.type, var_2);

  if(level.ref_13368 && level.ref_13363) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.locale.objectiveiconid);
    var_0.locale.objectiveiconid = -1;
    var_3 = spawnStruct();
    init_tape_machine_animations(var_3, "ui_mp_br_mapmenu_icon_atm", "current", var_1.origin + (0, 0, 200));
    var_1.locale = var_3;
  }

  level.br_plunder_sites = scripts\engine\utility::array_remove(level.br_plunder_sites, var_0);
  level.br_plunder_sites = scripts\engine\utility::array_add(level.br_plunder_sites, var_1);
}

function ref_1386c() {
  scripts\mp\flags::gameflagwait("prematch_done");
  waitframe();

  foreach(var_1 in level.br_plunder_sites) {
    var_1.disabled = undefined;
    var_2 = scripts\engine\utility::ter_op(level.ref_13368 && !level.ref_13363, var_1.audio_jugg_spawn, var_1.audio_shf_kill_hangar_lights);
    var_1 setscriptablepartstate(var_1.type, var_2);
    thread ref_12e1e();

    if(level.ref_13368 && level.ref_13363) {
      thread ref_13b86();
    }
  }

  thread ref_12e0e();
}

function ref_12e1e() {
  wait level.ref_13b85;
  self.disabled = 1;
  self.snapshot_crate_player_at_max_ammo = 1;
  self setscriptablepartstate(self.type, self.load_relics_from_playlistdvars);
}

function ref_12e0e() {
  wait level.ref_13b85 + 1;
  level.br_plunder_sites = ai_shooting_timer(scripts\mp\gametypes\br_plunder::register_vfx(), level.ref_11b6d);

  if(level.ref_13368 && level.ref_13363) {
    thread init_relic_team_proximity();
  }

  thread ref_1386c();
}

function activate_scout_drone() {}

function init_relic_team_proximity() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.br_plunder_sites) {
    var_2 = spawnStruct();
    init_tape_machine_animations(var_2, "ui_mp_br_mapmenu_icon_atm", "current", var_1.origin + (0, 0, 200));
    var_1.locale = var_2;
  }
}

function ref_13b86() {
  var_0 = level.ref_13b85;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = var_0 * 1000;
  var_4 = var_3 - var_2;
  var_5 = gettime() + var_3;

  while(gettime() < var_5) {
    var_6 = var_4 / var_3;
    scripts\mp\objidpoolmanager::objective_show_progress(self.objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objectiveiconid, var_6);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  self.objectiveiconid = -1;
}

function init_tape_machine_animations(var_0, var_1, var_2) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, var_1, (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_2)) {
      ref_11db0(var_2);
      return;
    }

    return;
  }
}

function ref_11db0(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

function ref_1336c(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

function ref_1336b(var_0) {
  objective_addalltomask(var_0);
}

function spawn_downed_friendly(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

function lastdropedtime() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

function achievement_id() {}

function ref_13839(var_0) {
  ref_1314a(level);
  thread ref_13353(level);

  if(level.ref_13abc) {
    thread ref_13881(level);
  }

  if(level.ref_13aba) {
    thread ref_12c13();
  }

  thread ref_13847();
  thread ref_11ef5(level);
}

function ref_1314a() {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_0 = getdvarfloat("scr_bmo_exfil_timer", 180);
  var_1 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var_1].value = var_0;
  level.overridewatchdvars[var_1] = var_0;
}

function ref_13353(var_0) {
  foreach(var_2 in level.teamnamelist) {
    scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_requested", var_2);
  }

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\hud_message::showsplash("callout_bmo_exfil_winners");
    var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(71, undefined, 20);
  }
}

function ref_13881(var_0) {
  level.radarmode[var_0] = "normal_radar";
  level.activeuavs[var_0] = 1;
  level.activeadvanceduavs[var_0] = 0;
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_0, 4);
}

function ref_12c13() {
  level.ref_11a27 = 1;

  if(getdvarint("scr_dmz_loot_leader_update_on_pickup", 0) == 1) {
    if(level.ref_11a37 > 0) {
      thread ref_13ff1();
      return;
    }

    return;
  }
}

function ref_13847() {
  foreach(var_1 in level.br_plunder_sites) {
    var_1 setscriptablepartstate(var_1.type, "inuse");
    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_3 = level.players[0];

    for(var_4 = 0; var_4 < 200; var_4++) {
      var_3 = play_quarry_intro_vo();

      if(isPlayer(var_3)) {
        break;
      }
    }

    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_5 = ref_126a8(var_3, var_2, var_1);

    if(isDefined(var_5)) {
      var_5.site = var_1;
      var_1.heli = var_5;
      helicreateextractvfx(var_5, var_2);
      thread outro_main();
    }
  }
}

function ref_126a8(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2500);
  var_4 = play_skit_and_watch_for_endons(var_3, var_1);
  var_5 = (0, var_4, 0);

  if(getdvarint("scr_br_plunder_heli_adjust_bag", 1) == 1) {
    var_6 = -100;
    var_7 = 60;
    var_8 = anglesToForward(var_5);
    var_9 = anglestoright(var_5);
    var_2 = var_2 + var_8 * var_6 + var_9 * var_7;
  }

  var_10 = var_3 + -1 * anglesToForward(var_5) * 30000;
  var_11 = var_3 + anglesToForward(var_5) * 30000;
  var_12 = spawnheli(self, var_10, var_3, var_11);
  return var_12;
}

function outro_main() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  var_0 = ref_13c30(self.pathgoal);
  var_1 = self.pathgoal[2] - var_0;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_1);
  sortplayerplunderscores(1, self.player_weapon_fired_monitor);
  self waittill("goal");

  foreach(var_3 in level.players) {
    var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(72, undefined, 20);
  }

  thread heliwatchgameendleave();
  thread snapshot_crate_spawn();
  helidescend(self.endpoint, var_0);

  foreach(var_6 in level.teamnamelist) {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_chopper_arrive", var_6, 1);
  }

  soldier_agent_lwfn0();
  helicleanupextract();

  foreach(var_6 in level.teamnamelist) {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_chopper_leave", var_6, 1);
  }

  thread sol_3_4_pool();
}

function soldier_agent_lwfn0() {
  self.isdepot = 1;
  self.usable = self.crate;
  var_0 = self.usable;
  var_0 makeusable();
  var_0 setCursorHint("HINT_NOICON");
  var_0 setuseholdduration("duration_medium");
  var_0 sethintrequiresholding(1);
  var_0 setuserange(230);
  var_0 setHintString(&"MP/BR_USE_EXFIL_CHOPPER");
  var_1 = level.br_depots.size;
  level.br_depots[var_1] = var_0;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {}
  }

  thread helicleanupdepotonleaving();
  thread snowballfight(var_0);
  sortplayerplunderscores(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

function snowballfight(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 scripts\mp\hud_message::showsplash("callout_exfil_success");
    var_1 playerhide();
    var_1 vehiclepinonminimap(0);
    var_1 allowmovement(0);
    var_1 allowfire(0);
    var_1 disableoffhandprimaryweapons(0);
    var_1 disableoffhandsecondaryweapons(0);
    var_1 disableweapons(0);
    var_1 disableweaponswitch(0);
    var_1 setcamerathirdperson(1);
    var_1 allowcrouch(0);
    var_1 allowmelee(0);
    var_1 allowjump(0);
    var_1 allowprone(0);
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 scripts\common\utility::allow_supers(0);
    var_1.ref_12e54 = 1;
    var_0 disableplayeruse(var_1);
  }
}

function showquestcircletoplayer() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self.health = 99999;
  }
}

function ref_13c30(var_0) {
  var_1 = 256;
  var_2 = tracegroundpoint(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

function play_skit_and_watch_for_endons(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.player_respawn)) {
    return var_1.player_respawn;
  }

  var_2 = 10;
  var_3 = scripts\engine\trace::create_world_contents();
  var_4 = 0;

  while(var_4 < 360) {
    var_5 = (0, var_4, 0);
    var_6 = var_0 + -1 * anglesToForward(var_5) * 30000;
    var_7 = var_0 + anglesToForward(var_5) * 30000;
    var_8 = scripts\engine\trace::sphere_trace(var_0, var_7, 100, undefined, var_3, 1);

    if(var_8["fraction"] == 1) {
      if(isDefined(var_1)) {
        var_1.player_respawn = var_4;
      }

      return var_4;
    }

    if(var_4 % 3 == 0) {
      waitframe();
    }

    var_4 += var_2;
  }

  var_4 = randomfloat(360);

  if(isDefined(var_1)) {
    var_1.player_respawn = var_4;
  }

  return var_4;
}

function ref_11ef5(var_0) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, level.ref_13abb);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  var_1 = gettime();
  var_2 = level.ref_13abb * 1000 + var_1;
  setomnvar("ui_nuke_end_milliseconds", level.ref_13abb * 1000 + var_1);

  for(;;) {
    waitframe();

    if(gettime() > var_2) {
      break;
    }
  }

  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function activate_gas_trap_cloud_parent() {}

function ref_13dc8(var_0, var_1, var_2) {
  if(istrue(level.convoy_handle_stuck_compromise)) {
    if(istrue(level.chopperexif_fx_init) && istrue(var_1)) {
      thread convoy_anim_sequence();
    }

    return;
  }

  level.convoy_handle_stuck_compromise = 1;
  level notify("cancel_announcer_dialog");
  thread scripts\mp\music_and_dialog::ref_12792();
  scripts\mp\gametypes\br_publicevents::generic_waittill_button_press();
  thread ref_12192();
  var_3 = scripts\engine\utility::ter_op(level.ref_12192 >= 1, "bm_overtime_double_cash_num", "bm_overtime_double_cash_perc");

  if(isDefined(var_0) && (level.locale_defaults || !level.loadout_updatebrammo)) {
    level.time_before_shoot = var_0;
    ref_13372(var_0, "bm_overtime_start_them");
    showsplashtoteam(var_0, "bm_overtime_start_us");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("bm_gamestate_overtime", var_0);

    foreach(var_5 in level.teamnamelist) {
      if(var_5 != var_0) {
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback("bm_gamestate_overtime_enemy", var_5);
      }
    }
  } else {
    level.time_before_shoot = remove_padding_damage();
  }

  if(!isDefined(var_2)) {
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    var_7 = scripts\engine\utility::ter_op(level.loadout_updatebrammo || istrue(var_2), 7, 12);
    var_8 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
    level.watchdvars[var_8].value = var_7;
    level.overridewatchdvars[var_8] = var_7;

    if(!level.loadout_updatebrammo) {
      wait 5;
    }

    scripts\mp\gametypes\br_gametype_dmz::ref_13371(var_3);
    wait 5;
    level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
  } else {
    level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
    level.playerparachutedetachresetomnvars = 1;
    level.playerplaygestureweaponanim = 1;
    scripts\mp\gametypes\br_gametype_dmz::ref_13371(var_3);
    wait 5;
  }

  level.playerparachutedetachresetomnvars = undefined;
  scripts\mp\flags::gameflagwait("overtime_started");
  setomnvar("ui_br_circle_state", 7);
  var_9 = gettime() + int(level.make_bomb_detonator_interact * 1000);
  setomnvar("ui_hardpoint_timer", var_9);
  wait int(max(level.make_bomb_detonator_interact - getdvarint("scr_rat_race_ot_ending_wait"), 60));
  setomnvar("ui_br_circle_state", 8);
}

function remove_padding_damage() {
  var_0 = "";

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["teamPlacements"][var_2];

    if(var_3 == 1) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

function ontimelimit() {
  if(level.ref_13abd && level.make_bomb_detonator_interact > 0 && !istrue(level.convoy_handle_stuck_compromise)) {
    if(!isDefined(level.time_before_shoot)) {
      level.time_before_shoot = remove_padding_damage();
    }

    thread ref_13dc8(level, level.time_before_shoot);
    level waittill("bmo_overtime_start");

    while(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      wait level.framedurationseconds;
    }
  }

  thread convoy_anim_sequence();
}

function convoy_anim_sequence() {
  if(istrue(level.gameended)) {
    return;
  }

  thread setup_heli_starts_deep();
  level thread scripts\mp\gamelogic::endgame(level.disable_super_in_turret.player_enemy_cooldown, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
}

function setup_heli_starts_deep() {
  var_0 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  foreach(var_2 in level.players) {
    var_2 _calloutmarkerping_handleluinotify_added::ref_13133("post_game_state", var_0);
  }
}

function ref_126a6() {
  if(!istrue(self.controlsfrozen)) {
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");
  }

  var_0 = spawnStruct();
  var_1 = self getspectatingplayer();

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;

  if(!var_1 isonground()) {
    var_2 = scripts\engine\trace::create_default_contents(1);
    var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 0, -20000, undefined, var_2);
  }

  var_0.origin += (0, 0, 100);

  if(!isDefined(level.needs_antenna)) {
    level.needs_antenna = 1;
    thread ref_13db9();
  }

  return true;
}

function numextractions() {
  level waittill("give_match_bonus");
  waitframe();
  var_0 = getdvarfloat("scr_bmo_eom_held_cash_scalar", 1);
  var_1 = getdvarfloat("scr_bmo_eom_banked_cash_scalar", 1);
  var_2 = getdvarint("scr_bmo_eom_initial_winner_bonus", 10000);
  var_3 = getdvarint("scr_bmo_eom_over_wincost_bonus", 7500);
  var_4 = getdvarint("scr_bmo_eom_top10_bonus", 5000);

  foreach(var_6 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_6)) {
      continue;
    }

    var_7 = run_blima_exfil_sequence(var_6) * 100;
    var_8 = var_7 >= safehouse_regroup();
    var_9 = game["teamPlacements"][var_6];
    var_10 = 0;

    if(var_8) {
      var_10 = var_3;
    } else if(var_9 <= 10) {
      var_10 = var_4;
    }

    var_11 = scripts\mp\utility\teams::getteamdata(var_6, "players");

    foreach(var_13 in var_11) {
      var_13 scripts\mp\gametypes\br::ref_138d6();
      var_13 scripts\cp_mp\utility\game_utility::ref_13168(var_9);

      if(!var_13 scripts\mp\utility\game::rankingenabled() || !var_13 hasplayerdata()) {
        continue;
      }

      var_13 scripts\mp\utility\stats::incpersstat("cash", int(var_7 / 10000));
      var_14 = var_13.pers["combatXP"];

      if(!isDefined(var_14)) {
        var_14 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 0, var_14);
      var_15 = var_13.pers["missionXP"];

      if(!isDefined(var_15)) {
        var_15 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 1, var_15);
      var_16 = var_13.pers["lootingXP"];

      if(!isDefined(var_16)) {
        var_16 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 2, var_16);
      var_17 = 0;

      if(isDefined(var_13.plundercount)) {
        var_17 = int(var_13.plundercount * var_0);
      }

      var_18 = 0;

      if(isDefined(var_13.plunderbanked)) {
        var_18 = int(var_13.plunderbanked * var_1);
      }

      var_19 = var_17 + var_18;

      if(var_19 > 0) {
        var_13 scripts\mp\rank::giverankxp("cash_conversion_bonus", var_19, undefined, 1, 1);
      }

      var_13 setplayerdata("mp", "aarValue", 3, var_19);
      var_20 = 0;

      if(isDefined(var_13.matchbonus)) {
        var_20 = int(var_13.matchbonus);
      }

      var_13 setplayerdata("mp", "aarValue", 4, var_20);

      if(var_10 > 0) {
        var_13 scripts\mp\rank::giverankxp("placement_bonus", var_10, undefined, 1, 1);
      }

      var_13 setplayerdata("mp", "aarValue", 5, var_10);
      var_21 = var_13 getplayerdata("mp", "aarValue", 6);
      var_22 = var_21 + var_13.pers["summary"]["xp"];
      var_13 setplayerdata("mp", "aarValue", 7, var_22);
    }
  }
}

function activate_gas_trap_cloud() {}

function test_pipe_fire() {
  var_0 = [];
  level.mp_m_trench_patch = [];
  level.mp_m_speedball_patch = [];

  if(level.mapname == "mp_br_mechanics") {
    level.mp_m_trench_patch[0] = (8682, -1036, 427);
    level.mp_m_speedball_patch[0] = (14, 163, 0);
    level.mp_m_trench_patch[1] = (-1139, -3425, 1116);
    level.mp_m_speedball_patch[1] = (33, 75, 0);
    level.mp_m_trench_patch[2] = (-5567, -4786, 1116);
    level.mp_m_speedball_patch[2] = (37, 192, 0);
  } else {
    level.mp_m_trench_patch[0] = (-36548, -31983, 2400);
    level.mp_m_speedball_patch[0] = (12, 72, 0);
    level.mp_m_trench_patch[1] = (-17592, -36440, 1379);
    level.mp_m_speedball_patch[1] = (17, 90, 0);
    level.mp_m_trench_patch[2] = (-3520, -34298, 1217);
    level.mp_m_speedball_patch[2] = (11, 110, 0);
    level.mp_m_trench_patch[3] = (-9577, -25957, 360);
    level.mp_m_speedball_patch[3] = (357, 82, 0);
    level.mp_m_trench_patch[4] = (23022, -26926, 1359);
    level.mp_m_speedball_patch[4] = (16, 101, 0);
    level.mp_m_trench_patch[5] = (31261, -29753, 1359);
    level.mp_m_speedball_patch[5] = (27, 52, 0);
    level.mp_m_trench_patch[6] = (44843, -41261, 3220);
    level.mp_m_speedball_patch[6] = (16, 52, 0);
    level.mp_m_trench_patch[7] = (44229, -15403, 1331);
    level.mp_m_speedball_patch[7] = (13, 72, 0);
    level.mp_m_trench_patch[8] = (44491, 3484, 1638);
    level.mp_m_speedball_patch[8] = (23, 11, 0);
    level.mp_m_trench_patch[9] = (16047, -3206, 2613);
    level.mp_m_speedball_patch[9] = (27, 309, 0);
    level.mp_m_trench_patch[10] = (5668, -5905, 1614);
    level.mp_m_speedball_patch[10] = (23, 304, 0);
    level.mp_m_trench_patch[11] = (-13412, -20443, 1033);
    level.mp_m_speedball_patch[11] = (11, 109, 0);
    level.mp_m_trench_patch[12] = (-30369, -7811, 1680);
    level.mp_m_speedball_patch[12] = (31, 339, 0);
    level.mp_m_trench_patch[13] = (-26278, 4081, 142);
    level.mp_m_speedball_patch[13] = (6, 110, 0);
    level.mp_m_trench_patch[14] = (-16429, 6021, 847);
    level.mp_m_speedball_patch[14] = (21, 57, 0);
    level.mp_m_trench_patch[15] = (-7525, 11672, 1082);
    level.mp_m_speedball_patch[15] = (14, 46, 0);
    level.mp_m_trench_patch[16] = (8356, 15296, 2021);
    level.mp_m_speedball_patch[16] = (12, 38, 0);
    level.mp_m_trench_patch[17] = (26010, 29975, 2716);
    level.mp_m_speedball_patch[17] = (13, 68, 0);
    level.mp_m_trench_patch[18] = (12043, 30910, 3081);
    level.mp_m_speedball_patch[18] = (21, 88, 0);
    level.mp_m_trench_patch[19] = (7127, 52592, 2100);
    level.mp_m_speedball_patch[19] = (28, 241, 0);
    level.mp_m_trench_patch[20] = (-6693, 56481, 4026);
    level.mp_m_speedball_patch[20] = (16, 246, 0);
    level.mp_m_trench_patch[21] = (-21394, 37175, 757);
    level.mp_m_speedball_patch[21] = (2, 124, 0);
    level.mp_m_trench_patch[22] = (-26151, 25577, 271);
    level.mp_m_speedball_patch[22] = (357, 10, 0);
  }

  if(false) {
    mp_m_stack_patch();
    return;
  }
}

function ref_13db9() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      thread ref_12753(var_2, var_2);
      var_0++;
    }

    if(var_0 == 5) {
      waitframe();
      var_0 = 0;
    }
  }
}

function mp_m_stack_patch() {
  for(;;) {
    var_0 = getdvarint("scr_bmo_testEndCamera", -1);

    if(var_0 > -1) {
      ref_12753(level.players[0], registerquestcategorytablevalues(level.players[0]));
      setDvar("scr_bmo_testEndCamera", -1);
    }

    waitframe();
  }
}

function registerquestcategorytablevalues(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.mp_m_trench_patch) {
    var_5 = distance2dsquared(var_0.origin, var_4);

    if(var_5 <= 9000000) {
      return var_6;
    }

    if(!isDefined(var_2) || var_2 > var_5) {
      var_2 = var_5;
      var_1 = var_6;
    }
  }

  return var_1;
}

function ref_12753(var_0, var_1) {
  var_2 = level.mp_m_trench_patch[var_1];
  var_3 = level.mp_m_speedball_patch[var_1];
  var_4 = var_2 + anglestoright(var_3) * 1000;
  var_5 = var_3;
  var_6 = spawn("script_model", var_2);
  var_6 setModel("tag_origin");
  var_6.angles = var_3;
  var_0 cameralinkTo(var_6, "tag_origin");
  var_6 moveTo(var_4, 60);
  var_6 rotateTo(var_5, 60);

  if(false) {
    wait 5;
    var_0 cameraunlink();
    return;
  }
}

function ref_12893() {
  wait 1;
  var_0 = safehouse_regroup();
  var_1 = setteamplacement(game["teamPlacements"], "up");

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    if(isDefined(level.teamdata[var_1[var_2]]["plunderTeamTotal"])) {
      var_3 = run_blima_exfil_sequence(var_1[var_2]) * 100;
    }
  }
}

function teleportplayertoselection() {
  wait 1;
  game["dialog"]["gametype"] = "gametype_bmo_plunder";
  game["dialog"]["match_start"] = "gametype_bmo_plunder";
  game["dialog"]["boost_short"] = "boost_bmo_short";
  game["dialog"]["offense_obj"] = "boost_bmo";
  game["dialog"]["defense_obj"] = "boost_bmo";
  game["dialog"]["contract_hold_area"] = "bm_contract_hold_area";
  game["dialog"]["contract_loot_chests"] = "bm_contract_loot_chests";
  game["dialog"]["contract_kill_target"] = "bm_contract_kill_target";
  game["dialog"]["event_chopper"] = "bm_event_chopper";
  game["dialog"]["event_airdrop"] = "bm_event_airdrop";
  game["dialog"]["extract_enabled"] = "bm_extract_enabled";
  game["dialog"]["gamestate_25_perc"] = "bm_gamestate_25_perc";
  game["dialog"]["gamestate_50_perc"] = "bm_gamestate_50_perc";
  game["dialog"]["gamestate_75_perc"] = "bm_gamestate_75_perc";
  game["dialog"]["gamestate_90_perc"] = "bm_gamestate_90_perc";
  game["dialog"]["gamestate_25_perc_enemy"] = "bm_gamestate_25_perc_enemy";
  game["dialog"]["gamestate_50_perc_enemy"] = "bm_gamestate_50_perc_enemy";
  game["dialog"]["gamestate_75_perc_enemy"] = "bm_gamestate_75_perc_enemy";
  game["dialog"]["gamestate_90_perc_enemy"] = "bm_gamestate_90_perc_enemy";
  game["dialog"]["gamestate_25_perc_first"] = "bm_gamestate_25_perc_first";
  game["dialog"]["gamestate_50_perc_first"] = "bm_gamestate_50_perc_first";
  game["dialog"]["gamestate_75_perc_first"] = "bm_gamestate_75_perc_first";
  game["dialog"]["gamestate_90_perc_first"] = "bm_gamestate_90_perc_first";
  game["dialog"]["lead_lost"] = "bm_gamestate_lead_lost";
  game["dialog"]["lead_taken"] = "bm_gamestate_lead_taken";
  game["dialog"]["mission_failure"] = "bm_gamestate_lost";
  game["dialog"]["mission_success"] = "bm_gamestate_win";
  game["dialog"]["gamestate_top_3"] = "bm_gamestate_top_3";
  game["dialog"]["gamestate_top_5"] = "bm_gamestate_top_5";
  game["dialog"]["gamestate_top_10"] = "bm_gamestate_top_10";
  game["dialog"]["bm_gamestate_overtime"] = "bm_gamestate_overtime_million_cash_deposited";
  game["dialog"]["bm_gamestate_overtime_enemy"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_get_cash"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_earn_cash"] = "bm_tut_earn_cash";
  game["dialog"]["bm_tut_loot_cash"] = "bm_tut_loot_cash";
  game["dialog"]["event_bank"] = "event_bank";
  game["dialog"]["exfil_arrived"] = "exfil_arrived";
  game["dialog"]["exfil_failed"] = "exfil_failed";
  game["dialog"]["exfil_inbound"] = "exfil_inbound";
  game["dialog"]["exfil_leaving"] = "exfil_leaving";
  game["dialog"]["exfil_start_generic"] = "exfil_start_generic";
  game["dialog"]["exfil_start_win"] = "exfil_start_win";
  game["dialog"]["exfil_start_win_lz"] = "exfil_start_win_lz";
  game["dialog"]["exfil_success_full"] = "exfil_success_full";
  game["dialog"]["exfil_success_partial"] = "exfil_success_partial";
  game["dialog"]["dom_point_friendly_capture_1"] = "dom_point_friendly_capture_1";
  game["dialog"]["dom_point_friendly_capture_2"] = "dom_point_friendly_capture_2";
  game["dialog"]["dom_point_friendly_capture_all"] = "dom_point_friendly_capture_all";
  game["dialog"]["dom_point_enemy_capture_single"] = "dom_point_enemy_capture";
  game["dialog"]["dom_point_enemy_capture_1"] = "dom_point_enemy_capture_1";
  game["dialog"]["dom_point_enemy_capture_2"] = "dom_point_enemy_capture_2";
  game["dialog"]["dom_point_enemy_capture_all"] = "dom_point_enemy_capture_all";
}

function ref_144eb(var_0) {
  level endon("game_ended");
  level endon("cancel_watch_parachuters_overhead");

  for(;;) {
    var_1 = 0;
    var_2 = scripts\mp\utility\game::round_vehicle_logic();

    if(var_2 == "payload") {
      var_1 = scripts\mp\flags::gameflag("prematch_done") && !scripts\mp\flags::gameflag("infil_complete");
    }

    if(var_1) {
      waitframe();
      continue;
    }

    foreach(var_4 in level.audio_player_stop_mud_loop) {
      if(!isDefined(var_4) || !scripts\mp\utility\player::isreallyalive(var_4) || !(var_4 isparachuting() || var_4 isinfreefall())) {
        level.audio_player_stop_mud_loop[var_17] = undefined;
        continue;
      }

      var_5 = scripts\common\utility::playersincylinder(var_4.origin, level.ref_121cf, undefined, level.ref_121cd);
      var_6 = var_4.team;

      foreach(var_8 in var_5) {
        if(scripts\mp\utility\game::updatehistoryhud(var_8)) {
          continue;
        }

        var_9 = var_6 == var_8.team;

        if(var_9) {
          continue;
        }

        var_10 = !scripts\mp\utility\player::isreallyalive(var_8) || istrue(var_8.inlaststand);

        if(var_10) {
          continue;
        }

        var_11 = var_8 isparachuting() || var_8 isinfreefall();

        if(var_11) {
          continue;
        }

        var_12 = gettime();
        var_13 = isDefined(var_8.showteamlittlebirds) && var_12 - var_8.showteamlittlebirds < var_0;

        if(var_13) {
          continue;
        }

        var_8.showteamlittlebirds = var_12;

        if(var_8 scripts\cp_mp\utility\game_utility::ref_140a8()) {
          var_14 = "bchr";
        } else {
          var_15 = scripts\mp\gametypes\br_public::disableannouncer(var_8);
          var_14 = game["voice"][var_15];
        }

        var_8 queuedialogforplayer(level.audio_railyard_fires[var_14], "respawning_enemy_in_area", 2);
      }

      waitframe();
    }

    waitframe();
  }
}

function ref_12892(var_0, var_1) {
  var_2 = scripts\mp\gamescore::run_common_functions_stealth();
}

function play_nag_intro_vo(var_0) {
  var_1 = getdvarint("scr_rat_race_should_filter_vehicle_spawn_structs", 0) != 0;

  if(var_1 == 0) {
    return var_0;
  }

  var_2 = "open_jeep_carpoc_spawn";
  var_3 = level.br_vehtargetnametoref[var_2];

  if(var_0.size > 0) {
    var_4 = scripts\mp\gametypes\br_vehicles::vars_update(var_0[0], var_2, var_3);

    if(var_4) {
      return var_0;
    }
  }

  return [];
}

function baitedbydecoy(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  } else {
    var_2.angles = (0, 0, 0);
  }

  var_2.targetname = "open_jeep_carpoc_spawn";

  if(!isDefined(level.ref_1218b)) {
    level.ref_1218b = [];
  }

  level.ref_1218b[level.ref_1218b.size] = var_2;
  return var_2;
}

function ref_13208() {
  if(level.mapname != "mp_wz_island") {
    return;
  }

  if(level.ref_12a12.ref_1404c) {
    baitedbydecoy((21829, -56164, 242), (0, 352.5, 0));
    baitedbydecoy((23273.7, -52382.6, 366), (0, 120, 0));
    baitedbydecoy((29059.9, -47273.2, 524.897), (0, 182.5, 0));
    baitedbydecoy((26132.2, -43407.8, 690), (0, 212.5, 0));
    baitedbydecoy((27337.9, -40774.9, 653.864), (0, 35, 0));
    baitedbydecoy((18872.8, -49149.1, 642.25), (0, 212.5, 0));
    baitedbydecoy((26485, -49953.8, 535.335), (0, 125, 0));
    baitedbydecoy((14641.5, -50754.1, 443), (0, 205, 0));
    baitedbydecoy((18177.9, -52511.3, 296.52), (0, 5, 0));
    baitedbydecoy((31340.1, -51236.2, 485.647), (0, 212.5, 0));
    baitedbydecoy((26923.4, -53985.7, 341.472), (0, 215, 0));
    baitedbydecoy((15814.4, -33847.7, 4961.59), (0, 2.5, 0));
    baitedbydecoy((13140.3, -33986.8, 5062), (0, 12.5, 0));
    baitedbydecoy((20237.7, -46707.8, 749.25), (0, 120, 0));
    baitedbydecoy((18673.2, -46929.3, 750.987), (0, 212.5, 0));
    baitedbydecoy((28218.5, -56839.5, 323), (0, 170, 0));
    baitedbydecoy((29638.9, -56025.7, 308.468), (0, 262.5, 0));
    baitedbydecoy((8788.77, -54637.7, 561), (0, 307.5, 0));
    baitedbydecoy((10261.7, -54162.6, 561.477), (0, 302.5, 0));
    baitedbydecoy((10794.8, -53842.6, 563.362), (0, 265, 0));
    baitedbydecoy((10175.3, -54896.7, 561.123), (0, 70, 0));
    baitedbydecoy((9113.54, -55194.9, 562.331), (0, 30, 0));
    baitedbydecoy((11842.2, -53605.4, 556.825), (0, 57.5, 0));
    baitedbydecoy((29493.2, -37091.4, 733.981), (0, 167.5, 0));
    baitedbydecoy((28995.2, -37095.5, 731.408), (0, 257.5, 0));
    baitedbydecoy((29229.3, -37784.2, 723.448), (0, 225, 0));
    baitedbydecoy((28802.7, -37644.4, 727.448), (0, 352.5, 0));
    baitedbydecoy((29023.5, -38650.6, 676.476), (0, 22.5, 0));
    baitedbydecoy((29001.4, -39083.9, 681.896), (0, 167.5, 0));
    return;
  }

  baitedbydecoy((-28582, -19482, 889));
  baitedbydecoy((-22569, -20732, 888));
  baitedbydecoy((-20408, -23435, 888));
  baitedbydecoy((-28679, -22099, 884));
  baitedbydecoy((-27214, -25240, 888));
  baitedbydecoy((-24989, -22957, 888));
  baitedbydecoy((-26014, 21203, 2232));
  baitedbydecoy((-20201, 25508, 2664));
  baitedbydecoy((-22648, 24464, 2560));
  baitedbydecoy((-17014, 24577, 3003));
  baitedbydecoy((-21303, 18168, 3500));
  baitedbydecoy((-21657, 22420, 2972));
  baitedbydecoy((-43032, -2120, 412));
  baitedbydecoy((-41880, -6515, 431));
  baitedbydecoy((-26135, 3610, 3525));
  baitedbydecoy((-30175, 7359, 3250));
  baitedbydecoy((-9877, 6187, 952));
  baitedbydecoy((-13139, 5492, 797));
  baitedbydecoy((-17087.2, -10702, 888), (0, 310, 0));
  baitedbydecoy((-2039.2, -18554, 2105.75), (0, 100, 0));
  baitedbydecoy((-2238.8, -29194.7, 2545.96), (0, 129, 0));
  baitedbydecoy((-20306.8, -30970.7, 858.08), (0, 134, 0));
  baitedbydecoy((-26450.8, -4834.7, 1707.32), (0, 194, 0));
  baitedbydecoy((-4102.8, -2402.7, 1810.69), (0, 265, 0));
  baitedbydecoy((-47416, -11744, 218.24), (0, 0, 0));
  baitedbydecoy((-34408, -13224, 158), (0, 240, 0));
  baitedbydecoy((-48480, -17928, 150), (0, 360, 0));
  baitedbydecoy((-42152, -24152, 190.792), (0, 105, 0));
  baitedbydecoy((-34520, -27640, 275.981), (0, 135, 0));
  baitedbydecoy((-38032, -4328, 1219.71), (0, 255, 0));
  baitedbydecoy((-2072, 10824, 3806.23), (0, 90, 0));
  baitedbydecoy((-12560, 12648, 2910.61), (0, 15, 0));
  baitedbydecoy((-2304, 20544, 2335.33), (0, 165, 0));
  baitedbydecoy((-13688, 26992, 3002.13), (0, 300, 0));
  baitedbydecoy((-28672, 12536, 2053), (0, 75, 0));
  baitedbydecoy((-26904, 28496, 2054), (0, 315, 0));
  baitedbydecoy((-2560, 29808, 1057.95), (0, 195, 0));
  baitedbydecoy((-48256, 8688, 151.32), (0, 345, 0));
  baitedbydecoy((-36184, 15440, 1184), (0, 300, 0));
  baitedbydecoy((-44896, 19200, 1563.34), (0, 285, 0));
  baitedbydecoy((-37352, 27304, 1878.76), (0, 30, 0));
  baitedbydecoy((-46088, 568, 578.53), (0, 75, 0));
  baitedbydecoy((-37400, 20480, 2695.61), (0, 360, 0));
}

function ref_13209() {
  level.ref_12178 = [];
  level.ref_12178[level.ref_12178.size] = [(18405.7, -42293, 828), (0, 32.4992, 0)];
  level.ref_12178[level.ref_12178.size] = [(27560.9, -42692.7, 671.782), (0, 32.5, 0)];
  level.ref_12178[level.ref_12178.size] = [(30719.7, -55871.3, 317.407), (0, 352.5, 0)];
  level.ref_12178[level.ref_12178.size] = [(14293.1, -50606.7, 447.147), (0, 9.99992, 0)];
  level.ref_12178[level.ref_12178.size] = [(24952.3, -51440.4, 395.131), (0, 302.499, 0)];
}

function activate_precision_use_lua() {}

function put_objective_on_guy(var_0) {
  var_1 = spawnStruct();
  var_1.ref_13904 = var_0;
  var_2 = 0;
  var_3 = 60;
  var_4 = 3000;
  var_5 = 0;
  var_6 = 10;
  var_7 = 0.75;
  var_8 = 0.9;
  var_9 = 300;
  var_10 = 3000;
  var_11 = 0;
  var_12 = 10;
  var_13 = 0.75;
  var_14 = 0.9;

  if(level.mapname == "mp_wz_island") {
    if(level.ref_12a12.ref_1404c) {
      var_1.ground_detection_think = (23079, -53205, 3525);
      var_1.circle_radius = 32000;
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (10162, -54045, 561);
      level.spawn_set_jugg_value.chosen = (28689, -37165, 760);
      var_3 = 170;
      var_4 = 3000;
      var_5 = 0;
      var_6 = 7;
      var_7 = 0.5;
      var_8 = 0.65;
      var_9 = 55;
      var_10 = 3000;
      var_11 = 0;
      var_12 = 7;
      var_13 = 0.55;
      var_14 = 0.7;
      ref_12af0(var_1, 0, (28868, -55849, 309));
      ref_12af0(var_1, 0, (18402, -45320, 888));
      ref_12af0(var_1, 0, (13942, -34146, 5040));
      ref_12aef(var_1, (8186, -45544, 2411));
      ref_12aef(var_1, (40081, -46767, 315));
      ref_12aef(var_1, (21653, -50408, 440));
      ref_12aef(var_1, (35786.4, -39525.1, 530.743));
      ref_12aef(var_1, (4680, -35440, 4438));
      ref_12aef(var_1, (15320, -41043, 2441));
      ref_12aef(var_1, (31359, -47372, 528));
      ref_12aef(var_1, (17844, -27418, 5516));
      ref_12aef(var_1, (21777, -57498, 378));
      ref_12aef(var_1, (31763, -56480, 326));
    } else {
      var_1.ground_detection_think = (-23030, 659, 0);
      var_1.circle_radius = 32000;
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-22010, 24680, 3022);
      level.spawn_set_jugg_value.chosen = (-24170, -23620, 3022);
      ref_12af0(var_1, 0, (-42744, -7333, 473));
      ref_12af0(var_1, 0, (-27836, 4897, 3279));
      ref_12af0(var_1, 0, (-9169, 6657, 965));
      ref_12af0(var_1, 1, (-8516, 16084, 2060));
    }

    if(getdvarint("scr_rat_race_force_spawn_angles_above_factions", 0)) {
      var_1.ref_134ff = his_removequestinstance(level.spawn_set_jugg_value.choppersupport_watchtargetrange, var_1.ground_detection_think);
      var_1.ref_13500 = his_removequestinstance(level.spawn_set_jugg_value.chosen, var_1.ground_detection_think);
    }

    if(level.ratraceextractionhelienabled) {
      level.spawn_set_jugg_value.plunder_helipad_pos = (26975.3, -52773.1, 383.928);
      level.spawn_set_jugg_value.plunder_helipad_ang = (357.394, 34.9914, -1.08173);
    }
  } else {
    level.spawn_set_jugg_value.choppersupport_watchtargetrange = (8244, -2576, 3022);
    level.spawn_set_jugg_value.chosen = (-4791, -1707, 3022);

    if(level.ratraceextractionhelienabled) {
      level.spawn_set_jugg_value.plunder_helipad_pos = (1726.5, -3760, 3022);
      level.spawn_set_jugg_value.plunder_helipad_ang = (0, 0, 0);
    }
  }

  var_1.ref_1354f = getdvarint("scr_rat_race_spawn_face_enemy", var_2);
  var_1.ref_134ff = getdvarint("scr_rat_race_spawn_angle_allies", var_3);
  var_1.ref_13564 = getdvarint("scr_rat_race_spawn_height_allies", var_4);
  var_1.spawn_angle_min_allies = getdvarint("scr_rat_race_spawn_angle_min_allies", var_5);
  var_1.spawn_angle_max_allies = getdvarint("scr_rat_race_spawn_angle_max_allies", var_6);
  var_1.spawn_dist_min_allies = getdvarfloat("scr_rat_race_spawn_dist_min_allies", var_7);
  var_1.spawn_dist_max_allies = getdvarfloat("scr_rat_race_spawn_dist_max_allies", var_8);
  var_1.ref_13500 = getdvarint("scr_rat_race_spawn_angle_axis", var_9);
  var_1.ref_13565 = getdvarint("scr_rat_race_spawn_height_axis", var_10);
  var_1.spawn_angle_min_axis = getdvarint("scr_rat_race_spawn_angle_min_axis", var_11);
  var_1.spawn_angle_max_axis = getdvarint("scr_rat_race_spawn_angle_max_axis", var_12);
  var_1.spawn_dist_min_axis = getdvarfloat("scr_rat_race_spawn_dist_min_axis", var_13);
  var_1.spawn_dist_max_axis = getdvarfloat("scr_rat_race_spawn_dist_max_axis", var_14);

  if(!isDefined(var_1.circle_radius) || !isDefined(var_1.ground_detection_think)) {
    power_wave_mode_reset_playerdata(var_1, level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);
  }

  if(!isDefined(var_1.arena_bot_seek_dropped_weapon)) {
    poweron_warnings(var_1, level.ref_12a12.ref_1229c, level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);
  }

  if(!isDefined(var_1.manualturret_toggleallowuseactions)) {
    var_15 = scripts\engine\trace::create_default_contents(1);
    var_16 = scripts\engine\utility::drop_to_ground(var_1.ground_detection_think, 10000, -20000, undefined, var_15);
    ref_12af0(var_1, 0, var_16);
  }

  return var_1;
}

function his_removequestinstance(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = (var_0[0], var_0[1], 0);
    var_3 = (var_1[0], var_1[1], 0);

    if(distancesquared(var_2, var_3) > squared(0.1)) {
      var_4 = var_2 - var_3;
      var_4 = vectorNormalize(var_4);
      return vectortoyaw(var_4);
    }
  }

  return 0;
}

function power_wave_mode_reset_playerdata(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = (var_1[0], var_1[1], 0);
    var_3 = (var_0[0], var_0[1], 0);

    if(distancesquared(var_2, var_3) > squared(0.1)) {
      var_4 = var_3 - var_2;
      var_5 = length(var_4);
      var_4 = vectorNormalize(var_4);
      self.circle_radius = int(var_5 * 0.5);
      self.ground_detection_think = var_2 + var_4 * self.circle_radius;
      self.ref_134ff = vectortoyaw(-1 * var_4);
      self.ref_13500 = vectortoyaw(var_4);
      return;
    }

    return;
  }
}

function poweron_warnings(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = (0, 0, 0);
  var_5 = (1, 0, 0);
  var_6 = 3000;
  var_7 = (0, 1, 0);
  var_8 = 1000;

  if(isDefined(self.ground_detection_think)) {
    var_4 = self.ground_detection_think;
  }

  if(isDefined(self.circle_radius)) {
    var_6 = self.circle_radius;
    var_8 = int(min(var_8, self.circle_radius));
  }

  if(isDefined(var_2) && isDefined(var_1)) {
    var_9 = (var_2[0], var_2[1], 0);
    var_10 = (var_1[0], var_1[1], 0);

    if(distancesquared(var_9, var_10) > squared(0.1)) {
      var_7 = vectorNormalize(var_10 - var_9);
      var_5 = vectorcross(var_7, (0, 0, 1));
    }
  }

  var_11 = scripts\engine\trace::create_default_contents(1);

  for(var_12 = 0; var_12 < var_0; var_12++) {
    var_13 = randomint(var_6) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    var_14 = randomint(var_8) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    var_15 = var_4 + var_13 * var_5 + var_14 * var_7;
    var_15 = scripts\engine\utility::drop_to_ground(var_15, 10000, -20000, undefined, var_11);
    var_3 = var_15;
  }

  self.arena_bot_seek_dropped_weapon = var_3;
}

function activate_subway_track_trigger_hurt() {}

function ref_13b66() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);
  scripts\mp\flags::gameflagwait("infil_complete");

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit()) {
      var_4 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var_5 = int(var_4 + 0.5);
      var_6 = 0;

      if(var_3 == 2 && var_5 % 2 == 1) {
        var_6 = 1;
      }

      var_7 = getdvarint("scr_rat_race_pe_dom_flag_start_time_sec", 840) + 20;
      var_8 = getdvarint("scr_rat_race_pe_cash_drops_start_time_sec", 1020) + 20;
      var_9 = getdvarint("scr_rat_race_pe_cash_drops_start_time_sec_2", 660) + 20;

      if(!var_0 && (var_6 == 1 && var_5 == var_7 + 1 || var_6 == 0 && var_5 == var_7)) {
        if(getdvarint("scr_rat_race_pe_dom_flag_enabled", 1)) {
          thread ref_122c0(level);
        }

        var_0 = 1;
      } else if(!var_1 && (var_6 == 1 && var_5 == var_8 + 1 || var_6 == 0 && var_5 == var_8)) {
        if(getdvarint("scr_rat_race_pe_cash_drop_enabled", 1)) {
          thread ref_1229b();
        }

        var_1 = 1;
      } else if(!var_2 && (var_6 == 1 && var_5 == var_9 + 1 || var_6 == 0 && var_5 == var_9)) {
        if(getdvarint("scr_rat_race_pe_cash_drop_enabled", 1)) {
          thread ref_1229a();
        }

        var_2 = 1;
      }

      if(var_4 - floor(var_4) >= 0.05) {
        wait var_4 - floor(var_4);
        continue;
      }
    }

    wait 1;
  }
}

function activate_target() {}

function ref_12af0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = level.ref_12a12.maphints;
  }

  if(!isDefined(self.manualturret_toggleallowuseactions)) {
    self.manualturret_toggleallowuseactions = [];
  }

  if(!isDefined(self.manualturret_toggleallowuseactions[var_0])) {
    self.manualturret_toggleallowuseactions[var_0] = [];
  }

  var_4 = spawnStruct();
  var_4.ref_135ce = var_0;
  var_4.location = getgroundposition(var_1, 5);
  var_4.get_current_building_obj_struct = var_2;
  var_4.mid_bosses = var_3;
  self.manualturret_toggleallowuseactions[var_0] = scripts\engine\utility::array_add(self.manualturret_toggleallowuseactions[var_0], var_4);
}

function ref_122c0(var_0) {
  level endon("game_ended");

  if(!isDefined(level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions) || var_0 >= level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions.size) {
    return;
  }

  var_1 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[var_0];
  level.ref_12a12.ref_12e2c.ref_122b5 = var_0;

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }

  ref_122bf();
  level.objectivescaler = 1;

  if(getdvarint("scr_rat_race_skip_event_wait_times", 0) == 0) {
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
  var_0 = level.ref_12a12.ref_12e2c.ref_122b5;
  var_1 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[var_0];

  foreach(var_3 in var_1) {
    thread ref_122b7();
  }
}

function ref_122be() {
  var_0 = ["_a", "_b", "_c", "_d", "_e"];

  if(!isDefined(level.ref_12a12.are_all_players_in_region)) {
    level.ref_12a12.are_all_players_in_region = [];
    level.ref_12a12.are_all_players_in_region["allies"] = 0;
    level.ref_12a12.are_all_players_in_region["axis"] = 0;
  }

  if(!isDefined(level.ref_12a12.spawnsecretstashlootcache)) {
    level.ref_12a12.spawnsecretstashlootcache = 0;
  }

  var_1 = level.ref_12a12.ref_12e2c.ref_122b5;
  var_2 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[var_1];

  foreach(var_8, var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_4.get_current_building_obj_struct), var_4.get_current_building_obj_struct, level.ref_12a12.maphints);
    var_6 = spawn("trigger_radius", var_4.location, 0, int(var_5), int(level.defend_wave_3));
    var_6.script_label = var_0[level.ref_12a12.spawnsecretstashlootcache];
    var_6.iconname = var_0[level.ref_12a12.spawnsecretstashlootcache];
    level.ref_12a12.spawnsecretstashlootcache++;
    var_2[var_8].trigger = var_6;
    var_7 = scripts\mp\gametypes\obj_dom::setupobjective(var_2[var_8].trigger, "neutral");
    var_7.onuse = &ref_122b2;
    var_7.onbeginuse = &ref_122a8;
    var_7.onuseupdate = &ref_122b3;
    var_7.onenduse = &ref_122aa;
    var_7.oncontested = &ref_122a9;
    var_7.onuncontested = &ref_122af;
    var_7.onunoccupied = &ref_122b0;
    var_7.onpinnedstate = &ref_122ad;
    var_7.onunpinnedstate = &ref_122b1;
    var_7.ref_138b2 = &ref_122ae;
    var_7.stompprogressreward = &ref_122b8;
    var_7.id = "domFlag";
    var_7.pinobj = 1;
    var_7.lockupdatingicons = 1;
    var_7.trigger = var_6;
    var_7.get_current_bush_zone = 0;
    var_7.get_current_building_obj_struct = var_5;
    var_7.pos = var_4.location;
    var_7.vfxent = var_4.vfxent;
    var_7 scripts\mp\gameobjects::setcapturebehavior("persistent");
    var_7 scripts\mp\gameobjects::setusetime(level.ref_12a12.ref_122a1);
    playencryptedcinematicforall(var_7.objidnum, 1);
    var_7.ref_11ad0 = [];
    var_7.ref_11ad0["ally"] = spawnStruct();
    var_7.ref_11ad0["enemy"] = spawnStruct();
    var_7.ref_11ad0["neutral"] = spawnStruct();
    var_7.waittill_pickup_or_timeout = "undefined";
    ref_122a4(var_7.ref_11ad0["neutral"], 9, var_7.curorigin, var_5);
    ref_122a4(var_7.ref_11ad0["ally"], 8, var_7.curorigin, var_5);
    ref_122a4(var_7.ref_11ad0["enemy"], 0, var_7.curorigin, var_5);
    ref_122bb(var_7, "neutral");
    thread ref_122b9();
    thread ref_122ba();
    var_2[var_8].manned_turret_operator_validation_func = var_7;
    wait 0.5;
  }
}

function ref_122ab(var_0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var_0);
  var_0.truck_03_node = 1;
}

function ref_122ac(var_0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var_0);
  var_0.truck_03_node = 0;
}

function ref_122b9() {
  level endon("game_ended");
  self.ref_1265b = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("trigger", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var_0)) {
      ref_122ab(var_0);
    }

    waitframe();
  }
}

function ref_122ba() {
  level endon("game_ended");

  while(!self.get_current_bush_zone) {
    foreach(var_1 in self.ref_1265b) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1)) {
        ref_122ac(var_1);
      }
    }

    wait 0.1;
  }

  foreach(var_1 in self.ref_1265b) {
    ref_122ac(var_1);
  }
}

function ref_122a7(var_0, var_1) {
  if(istrue(var_1.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_enemy_kill", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_enemy_kill");
  }

  if(istrue(var_0.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_defend_kill", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_defend_kill");
    return;
  }
}

function ref_122a4(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var_0, 0, 0, var_1);
  scripts\mp\gametypes\br_quest_util::ref_1316f(int(var_2));
}

function ref_122bb(var_0) {
  if(var_0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var_0;

    foreach(var_2 in self.ref_11ad0) {
      var_2 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    }

    var_4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
    var_5 = undefined;

    foreach(var_7 in level.players) {
      var_8 = var_7.team == self.waittill_pickup_or_timeout;

      if(var_4) {
        var_5 = self.ref_11ad0["neutral"];
      } else {
        var_5 = scripts\engine\utility::ter_op(var_8, self.ref_11ad0["ally"], self.ref_11ad0["enemy"]);
      }

      if(isDefined(var_5)) {
        var_5 scripts\mp\gametypes\br_quest_util::ref_1336a(var_7);
      }
    }

    if(isDefined(var_5)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var_0);
      return;
    }

    return;
  }
}

function ref_122a5() {
  foreach(var_1 in self.ref_11ad0) {
    var_1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }
}

function ref_122b2(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("pe_dom_flag_end");
  thread ref_122a2(var_1);
}

function ref_122a8(var_0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      var_3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_122b3(var_0, var_1, var_2, var_3) {
  self.userate = 1;

  if(var_1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  ref_122bb(var_0);
}

function ref_122aa(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function ref_122a9() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var_0 = scripts\mp\gameobjects::getownerteam();
}

function ref_122af(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = ref_122a6();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    } else if(var_1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    } else if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(var_0 == "none" || var_1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function ref_122b0() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function ref_122ad(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function ref_122b1(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function ref_122ae(var_0) {
  self.userate = level.ref_12a12.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      var_2 = var_5 / self.usetime;
    }
  }
}

function ref_122b8(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function ref_122a2(var_0) {
  if(isDefined(var_0) && var_0 != "tie") {
    level.ref_12a12.are_all_players_in_region[var_0] += 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_0, 15, 0);

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0) {
        thread ref_122b4(var_2, 1);
        var_2 thread scripts\mp\hud_message::showsplash("br_rat_race_point_captured_ally");
        continue;
      }

      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team != var_0) {
        thread ref_122b4(var_2, 0);
        var_2 thread scripts\mp\hud_message::showsplash("br_rat_race_point_captured_enemy");
      }
    }

    var_4 = undefined;

    foreach(var_6 in self.touchlist[var_0]) {
      var_2 = var_6.player;
      var_2 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var_2 getcurrentprimaryweapon());
      var_2 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");

      if(!isDefined(var_4)) {
        var_4 = var_2;
      }
    }

    if(isDefined(var_4)) {
      var_8 = getdvarint("scr_rat_race_pe_dom_plunder_on_capture", 10000);
      var_9 = scripts\mp\gametypes\br_plunder::init_subway_cars();
      var_9.ref_1244d = 0;
      var_4 thread scripts\mp\gametypes\br_plunder::ref_12627(var_8, var_9);
      var_4 thread scripts\mp\gametypes\br_plunder::ref_1261c(var_8, run_died_poorly_funcs(var_0), var_9);
    }

    thread ref_122b6(self.pos);
    thread ref_122a3(self);
    return;
  }
}

function ref_122b4(var_0, var_1) {
  var_2 = level.ref_12a12.are_all_players_in_region[var_1];

  switch (var_2) {
    case 1:
      if(var_0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_1", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_1", self);
      }

      break;
    case 2:
      if(var_0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_2", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_2", self);
      }

      break;
    case 3:
      if(var_0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_all", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_all", self);
      }

      break;
  }
}

function ref_122a3(var_0) {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var_0.vfxent, "tag_origin");
  var_0.vfxent delete();
  ref_122a5(var_0);
  scripts\mp\gametypes\obj_dom::removeobjective(var_0);
}

function ref_122b7() {
  var_0 = spawn("script_model", self.location - (0, 0, 3));
  var_0 setModel("tag_origin");
  self.vfxent = var_0;
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var_0, "tag_origin");
}

function ref_122b6(var_0) {}

function ref_122a6() {
  var_0 = 0;

  foreach(var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "none")) {
      var_0++;
    }
  }

  return var_0;
}

function ref_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, var_0, var_4);
    }
  }
}

function ref_12981(var_0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var_2.ref_136f3, var_2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}

function spawn_br_plunder_dispensers() {
  var_0 = getdvarint("scr_rat_race_broken_atm_interval", 10);
  var_1 = getdvarint("scr_rat_race_broken_atm_instance_limit", 6);

  if(level.mapname == "mp_wz_island") {
    scripts\mp\gametypes\br_plunder_dispenser::dispenser_create(scripts\common\utility::groundpos((28868, -55849, 311)), (0, 180, 0), var_0, var_1);
    scripts\mp\gametypes\br_plunder_dispenser::dispenser_create(scripts\common\utility::groundpos((18402, -45320, 890)), (0, 0, 0), var_0, var_1);
    scripts\mp\gametypes\br_plunder_dispenser::dispenser_create(scripts\common\utility::groundpos((13942, -34146, 5043)), (0, 0, 0), var_0, var_1);
    return;
  }

  var_2 = scripts\engine\trace::create_default_contents(1);
  var_3 = scripts\engine\utility::drop_to_ground(level.ref_12a12.ref_12e2c.ground_detection_think, 10000, -20000, undefined, var_2);
  scripts\mp\gametypes\br_plunder_dispenser::dispenser_create(var_3, (0, 45, 0), var_0, var_1);
  var_4 = var_3 + (-95, -130, 0);
  scripts\mp\gametypes\br_plunder_dispenser::dispenser_create(var_4, (0, 60, 0), var_0, var_1 + 3);
}

function ref_13514() {
  var_0 = "allies";
  var_1 = level.spawn_set_jugg_value.choppersupport_watchtargetrange;
  level.ref_12a12.ref_13a9b[var_0] = scripts\mp\gametypes\br_rat_race_base::ref_140f5(scripts\common\utility::groundpos(var_1), (0, 0, 0), var_0);
  var_0 = "axis";
  var_1 = level.spawn_set_jugg_value.chosen;
  level.ref_12a12.ref_13a9b[var_0] = scripts\mp\gametypes\br_rat_race_base::ref_140f5(scripts\common\utility::groundpos(var_1), (0, 0, 0), var_0);
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
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = var_3;
  level.waypointpulses[var_0] = var_4;
}

function activate_switch_cooldown() {}

function ref_12aef(var_0) {
  if(!isDefined(self.arena_bot_seek_dropped_weapon)) {
    self.arena_bot_seek_dropped_weapon = [];
  }

  self.arena_bot_seek_dropped_weapon[self.arena_bot_seek_dropped_weapon.size] = var_0;
}

function ref_1229b() {
  level endon("game_ended");
  ref_12297();
  thread ref_12299(level);

  if(getdvarint("scr_rat_race_skip_event_wait_times", 0) == 0) {
    ref_12424("br_gametype_rat_race_airdrop_incoming");
    wait 20;
  }

  ref_12424("br_gametype_rat_race_bonus_gold_crates_online");
  wait 3;
  var_0 = level.ref_12a12.ref_12296;
  ref_122ee(var_0);
}

function ref_12297() {
  level.ref_12a12.ref_12e2a = spawnStruct();
  level.ref_12a12.ref_12e2a.aq_playerdisconnect = [];
  level.ref_12a12.ref_12e2a.are_all_alive_players_touching_plane = [];
  level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon = scripts\engine\utility::array_randomize(level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon);
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("battle_royale_c130_loot");
  var_0.capturecallback = &ref_12295;
  var_0.timeout = undefined;
}

function ref_12299(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(!isDefined(level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[var_2 + var_1])) {
      return;
    }

    thread ref_12298(level);
    wait 2;
  }
}

function ref_12298(var_0) {
  var_1 = level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[var_0];
  scripts\mp\gametypes\br_quest_util::ref_140b1(var_1, "dom");
}

function ref_1229a() {
  level endon("game_ended");
  var_0 = level.ref_12a12.ref_12296;
  var_1 = level.ref_12a12.ref_1229c - var_0;
  thread ref_12299(level, var_1);
  wait 20;
  ref_12424("br_gametype_rat_race_bonus_gold_crates_online");
  wait 3;
  ref_122ee(var_1, var_0);
}

function ref_122ee(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[var_2 + var_1];
    var_4 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_3 + (0, 0, 2000), var_3, (0, randomint(360), 0), "battle_royale_c130_loot");
    level.ref_12a12.ref_12e2a.aq_playerdisconnect[level.ref_12a12.ref_12e2a.aq_playerdisconnect.size] = var_4;
    scripts\engine\utility::array_remove(level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon, var_2);
    wait 2.5;
  }
}

function ref_12295(var_0) {
  thread scripts\cp_mp\killstreaks\airdrop::dialog_wait_think_civ(var_0);
  level.ref_12a12.ref_12e2a.aq_playerdisconnect = scripts\engine\utility::array_remove(level.ref_12a12.ref_12e2a.aq_playerdisconnect, self);
  showsplashtoteam(var_0.team, "br_gametype_rat_race_bonus_gold_crate_captured_ally");
}

function activate_laser_shut_down_interaction() {}

function ref_13eee() {
  var_0 = "any";
  var_1 = level.ref_12a12.ref_12e2c.ground_detection_think + vectorNormalize(level.ref_12a12.ref_12e2c.ref_136a8["axis"]) * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631["axis"];
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "axis";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var_2;
  thread ref_13ef2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "axis";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var_2;
  thread ref_13ef2();
  var_1 = level.ref_12a12.ref_12e2c.ground_detection_think + vectorNormalize(level.ref_12a12.ref_12e2c.ref_136a8["allies"]) * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631["allies"];
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "allies";
  level.spawn_set_jugg_value.brjugg_cleanupents = var_2;
  thread ref_13ef2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "allies";
  level.spawn_set_jugg_value.briskillstreakallowed = var_2;
  thread ref_13ef2();
}

function ref_13ef2() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::ter_op(self.team == "axis", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_0)) {
    return;
  }

  self.origin = var_0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var_0);
}

function ref_13ee7() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
}

function activate_all_targets() {}

function relic_steelballs_health_boost() {
  return level.ref_12a12.ref_12e2c.ground_detection_think;
}

function dangercircletick(var_0, var_1) {}

function groundz() {
  level.br_level.ref_13884 = 1;
  level.ref_12a12.ref_12e2c = put_objective_on_guy("default");
  level.grouptorewards = level.ref_12a12.ref_12e2c;
  level.br_level.default_class_chosen = [level.grouptorewards];
  var_0 = getdvarint("scr_br_timelimit");
  level.br_level.br_circledelaytimes = [var_0 * 2];
  level.br_level.br_circleclosetimes = [var_0 * 2];
  level.br_level.br_circleradii = [level.ref_12a12.ref_12e2c.circle_radius, level.ref_12a12.ref_12e2c.circle_radius];
  level.br_level.br_circleminimapradii = [int(level.ref_12a12.ref_12e2c.circle_radius / 2)];
  level.br_level.default_player_connect_black_screen = [0];
  level.br_level.default_suicidebomber_combat = [0];
  tank_x1_capacity();

  if(!isDefined(level.br_circle)) {
    level.br_circle = spawnStruct();
  }

  level.br_circle.circleindex = 0;
  level.br_circle.starttime = gettime();
  level.br_circle.dangercircleent = spawnStruct();
  level.br_circle.dangercircleent.origin = [level.ref_12a12.ref_12e2c.ground_detection_think[0], level.ref_12a12.ref_12e2c.ground_detection_think[1], level.ref_12a12.ref_12e2c.circle_radius];
  level.br_circle.safecircleent = spawnStruct();
  level.br_circle.safecircleent.origin = [level.ref_12a12.ref_12e2c.ground_detection_think[0], level.ref_12a12.ref_12e2c.ground_detection_think[1], level.ref_12a12.ref_12e2c.circle_radius];
  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
  var_1 = level.br_level.br_circleradii.size;

  if(isDefined(var_1) && var_1 > 0) {
    scripts\mp\gametypes\br_circle::teleport_entities_inside_subway_car(var_1);
    return;
  }
}

function activatemeleeblood() {}

function tank_x1_capacity() {
  level.ref_12a12.ref_12e2c.ref_1365e["allies"] = level.ref_12a12.ref_12e2c.ref_13564;
  level.ref_12a12.ref_12e2c.ref_1365e["axis"] = level.ref_12a12.ref_12e2c.ref_13565;
  level.ref_12a12.ref_12e2c.ref_136a8["allies"] = anglesToForward((0, level.ref_12a12.ref_12e2c.ref_134ff, 0));
  level.ref_12a12.ref_12e2c.ref_136a8["axis"] = anglesToForward((0, level.ref_12a12.ref_12e2c.ref_13500, 0));
  level.ref_12a12.ref_12e2c.ref_13608["allies"] = level.ref_12a12.ref_12e2c.spawn_angle_min_allies;
  level.ref_12a12.ref_12e2c.ref_13608["axis"] = level.ref_12a12.ref_12e2c.spawn_angle_min_axis;
  level.ref_12a12.ref_12e2c.ref_13607["allies"] = level.ref_12a12.ref_12e2c.spawn_angle_max_allies;
  level.ref_12a12.ref_12e2c.ref_13607["axis"] = level.ref_12a12.ref_12e2c.spawn_angle_max_axis;
  level.ref_12a12.ref_12e2c.ref_13631["allies"] = level.ref_12a12.ref_12e2c.spawn_dist_min_allies;
  level.ref_12a12.ref_12e2c.ref_13631["axis"] = level.ref_12a12.ref_12e2c.spawn_dist_min_axis;
  level.ref_12a12.ref_12e2c.ref_13630["allies"] = level.ref_12a12.ref_12e2c.spawn_dist_max_allies;
  level.ref_12a12.ref_12e2c.ref_13630["axis"] = level.ref_12a12.ref_12e2c.spawn_dist_max_axis;
  level.ref_12a12.ref_12e2c.spawnorigin["allies"] = level.ref_12a12.ref_12e2c.ground_detection_think + level.ref_12a12.ref_12e2c.ref_136a8["allies"] * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631["allies"];
  level.ref_12a12.ref_12e2c.spawnorigin["axis"] = level.ref_12a12.ref_12e2c.ground_detection_think + level.ref_12a12.ref_12e2c.ref_136a8["axis"] * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631["axis"];
  level.ref_12a12.ref_12e2c.passes_final_capsule_check = level.ref_12a12.ref_12e2c.ref_1354f;
  thread ref_1283f();
}

function ref_1283f() {
  level.ref_12ab4 = [];
  level.ref_12ab4["allies"] = [];
  level.ref_12ab4["axis"] = [];
  var_0 = getdvarint("scr_br_teamsize", 50);
  var_1 = getdvarint("scr_rat_race_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var_2 = 0;
  var_3 = scripts\mp\teams::ref_132e6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "team_two_hundred") {
      continue;
    }

    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = spawnStruct();
      var_8 = vectortoangles(level.ref_12a12.ref_12e2c.ref_136a8[var_5]);
      var_9 = randomfloatrange(level.ref_12a12.ref_12e2c.ref_13608[var_5], level.ref_12a12.ref_12e2c.ref_13607[var_5]);
      var_10 = anglesToForward((0, var_8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_9, var_9 * -1), 0));
      var_11 = randomfloatrange(level.ref_12a12.ref_12e2c.ref_13631[var_5], level.ref_12a12.ref_12e2c.ref_13630[var_5]);
      var_12 = level.ref_12a12.ref_12e2c.ground_detection_think + var_10 * level.ref_12a12.ref_12e2c.circle_radius * var_11;

      if(istrue(level.ref_12a12.ref_12e2c.passes_final_capsule_check)) {
        var_13 = level.ref_12a12.ref_12e2c.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_12;
        var_8 = vectortoangles(var_13);
      } else {
        var_8 = vectortoangles(var_10 * -1);
      }

      var_14 = scripts\engine\trace::create_default_contents(1);
      var_15 = 0;
      var_16 = 0;
      var_17 = 10;
      var_18 = [];

      for(var_19 = 0; var_19 < var_1; var_19++) {
        var_20 = scripts\engine\trace::ray_trace(var_12 + (0, 0, 10000), var_12 - (0, 0, 20000) + anglesToForward(var_8) * var_19 * 2000, undefined, var_14)["position"];
        var_18 = var_20;

        if(var_20[2] > var_15) {
          var_15 = var_20[2];
          var_16 = var_19;
        }

        var_2++;

        if(var_2 == 5) {
          waitframe();
          var_2 = 0;
        }
      }

      var_12 = (var_12[0], var_12[1], var_15 + level.ref_12a12.ref_12e2c.ref_1365e[var_5]);
      var_7.origin = var_12;
      var_7.ref_13c33 = var_18;
      var_7.spawn_exfil_heli = var_16;
      var_7.angles = var_8;
      var_7.time = gettime();
      var_7.team = var_5;
      var_7.index = -1;
      level.ref_12ab4[var_5][level.ref_12ab4[var_5].size] = var_7;
    }
  }
}

function rear_door_collision() {
  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
    return ppkteamnoflag();
  }

  if(self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid) {
    return ppkteamnoflag();
  }

  return self.ref_12ab3;
}

function ppkteamnoflag() {
  var_0 = randomint(level.ref_12ab4[self.team].size);
  var_1 = level.ref_12ab4[self.team][var_0];
  self.ref_12ab3.origin = var_1.origin;
  self.ref_12ab3.angles = var_1.angles;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  return self.ref_12ab3;
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
    var_2 = rear_door_collision(var_1);
    var_3 = var_1 scripts\mp\gametypes\br_gulag::ref_1263e(var_2);
  }

  level.dmztut_endgametransition = 1;
  wait 2;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    thread ref_12496();
  }

  thread ref_138cc();
  scripts\mp\flags::gameflagset("prematch_fade_done");
  scripts\mp\flags::gameflagset("infil_complete");
  waitframe();

  if(isDefined(level.br_pickups)) {
    spawn_br_plunder_dispensers();
  }

  ref_13514();
  setomnvar("ui_br_circle_state", 4);
}

function ref_138cc() {
  level endon("game_ended");
  wait 10;
  level thread scripts\mp\music_and_dialog::stopsuspensemusic();
}

function ref_12496() {
  self endon("disconnect");
  scripts\mp\gametypes\br_public::ref_1264c();
  self.ref_133e7 = 1;
  self.ref_12ca8 = 1;
  self.plotarmor = 1;

  if(!isalive(self)) {
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

function patch_far_wait() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_12495() {
  self endon("disconnect");
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  var_0 = rear_door_collision();
  var_1 = scripts\mp\gametypes\br_gulag::ref_1263e(var_0);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_0, 1, var_1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  waittillframeend();
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self.ref_133e7 = 0;
  scripts\mp\gametypes\br::ending_fade_in();
  thread ref_13ee7();
  thread init_infil();
  self notify("do_welcome_splashes");
}

function ____fulton_extraction_logic() {}

function init_plunder_fulton_overrides() {
  var_0 = "equip_mp_fulton";
  var_1 = scripts\mp\gametypes\br_plunder::ref_1278c(var_0);

  if(level..disableplunderbanking) {
    var_1.ref_14068 = &plunder_repositoryplayerplundereventcallback_vaulttransfer;
    return;
  }
}

function ____helicopter_helipad_extraction_logic() {}

function init_plunder_heli_overrides() {
  if(level.ratraceextractionhelienabled) {
    GscBinSkip1(0x45, 0, scripts\mp\gametypes\br_plunder::ref_1278c("plunderHelipad1"));
  }
}

function ____extraction_object_utility_logic() {}

function plunder_repositoryplayerplundereventcallback_vaulttransfer(var_0, var_1, var_2) {
  var_2 = get_amount_considering_capacity_overfill(var_0, var_2);
  var_3 = run_died_poorly_funcs(var_1.team);
  var_4 = get_plundercount_for_player(var_3.plunder, var_1);
  scripts\mp\gametypes\br_plunder::ref_1279f(var_3, var_1, var_2);
  var_5 = get_plundercount_for_player(var_3.plunder, var_1);
  var_6 = var_5 - var_4;
  add_amount_to_plunder_array(var_0, var_1, var_6);
}

function find_index_of_player_in_plunder_array(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(isDefined(var_3.player) && var_3.player == var_1) {
        return var_4;
      }
    }
  }

  return undefined;
}

function get_plundercount_for_player(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(isDefined(var_3.player) && var_3.player == var_1) {
        return var_3.plundercount;
      }
    }
  }

  return 0;
}

function get_amount_considering_capacity_overfill(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_plunder::ref_1278c(var_0.ref_127c8);

  if(isDefined(var_2.get_closest_enemy_near_turret) && var_2.get_closest_enemy_near_turret > 0) {
    var_3 = 0;

    if(isDefined(var_0.plunder)) {
      foreach(var_5 in var_0.plunder) {
        var_3 += var_5.plundercount;
      }
    }

    var_7 = var_2.get_closest_enemy_near_turret - var_3;

    if(var_1 >= var_7) {
      var_1 = var_7;
      scripts\mp\gametypes\br_plunder::ref_12799(var_0);
    }
  }

  return var_1;
}

function add_amount_to_plunder_array(var_0, var_1, var_2) {
  if(!isDefined(var_0.plunder)) {
    var_0.plunder = [];
  }

  var_3 = find_index_of_player_in_plunder_array(var_0.plunder, var_1);

  if(isDefined(var_3)) {
    var_0.plunder[var_3].plundercount += var_2;
    return;
  }

  var_4 = spawnStruct();
  var_4.player = var_1;
  var_4.team = var_1.team;
  var_4.plundercount = var_2;
  var_0.plunder[var_0.plunder.size] = var_4;
}

function activate_emp_drone_func() {}

function subscribedlocale() {
  thread issidehouseobjective();
  thread debug_watch_for_rat_race_print_match_info_to_console_dvar();
}

function issidehouseobjective() {
  self endon("game_ended");
  var_0 = "src_br_gametype_rat_race_spawn_vehicle_for_everyone_without_one";
  var_1 = "";
  setDvar(var_0, var_1);

  for(;;) {
    if(getDvar(var_0, var_1) != var_1) {
      foreach(var_3 in level.players) {
        if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicles(var_3)) {
          continue;
        }

        var_4 = var_3.origin + (300, 300, 100);
        var_5 = var_3.angles * (0, 1, 0);
        var_6 = spawnStruct();
        var_6.origin = var_4;
        var_6.angles = var_5;
        var_6.owner = var_3;
        var_6.spawntype = "DEVGUI";
        var_6.immediate = 1;
        var_7 = _calloutmarkerping_predicted_isanypingactive::ref_120c1(var_6);
      }

      setDvar(var_0, var_1);
    }

    wait 1;
  }
}

function debug_watch_for_rat_race_print_match_info_to_console_dvar() {
  self endon("game_ended");
  var_0 = "src_br_gametype_rat_race_print_match_info_to_console";
  var_1 = "";
  setDvar(var_0, var_1);

  for(;;) {
    if(getDvar(var_0, var_1) != var_1) {
      rat_race_print_match_info_to_console();
      setDvar(var_0, var_1);
    }

    wait 1;
  }
}

function init_infil() {
  if(!isDefined(self) || isai(self)) {
    return;
  }

  var_0 = spawnStruct();
  var_0.player = self;
  var_1 = scripts\mp\hud_util::createfontstring("default", 1.2);
  var_1 scripts\mp\hud_util::setpoint("TOP", "TOP", 0, 80);
  var_1.color = (1, 1, 1);
  var_1.alpha = 0;
  var_1.hidewheninmenu = 1;
  var_1.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_TEAM_POCKET_CASH_TITLE";
  var_0.ref_121d8 = var_1;
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2 scripts\mp\hud_util::setparent(var_1);
  var_2 scripts\mp\hud_util::setpoint("TOPRIGHT", "TOP", -50, 0);
  var_2.color = (0, 0, 1);
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_0.playersetattractionextradata = var_2;
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2 scripts\mp\hud_util::setparent(var_1);
  var_2 scripts\mp\hud_util::setpoint("TOPLEFT", "TOP", 50, 0);
  var_2.color = (1, 0, 0);
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_0.nuke_abortkillcamonspawn = var_2;
  level.ref_12a12.ref_12482[level.ref_12a12.ref_12482.size] = var_0;
}

function ref_13fa8() {
  while(!level.gameended) {
    if(isDefined(level.ref_12a12.ref_12482)) {
      var_0 = getdvarint("scr_rat_race_plunder_debug_enabled", 1);
      var_1 = [];

      for(var_2 = 0; var_2 < level.ref_12a12.ref_12482.size; var_2++) {
        var_3 = level.ref_12a12.ref_12482[var_2];
        var_4 = var_3.player;

        if(!isDefined(var_4)) {
          var_1 = var_3;
          continue;
        }

        if(isDefined(var_3.ref_121d8)) {
          var_3.ref_121d8.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);
        }

        if(isDefined(var_3.playersetattractionextradata)) {
          ref_13fa9(var_3.playersetattractionextradata, rpg_shoot_at_trigs(var_4.team) * 100);
          var_3.playersetattractionextradata.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);
        }

        if(isDefined(var_3.nuke_abortkillcamonspawn)) {
          var_5 = scripts\mp\utility\teams::getenemyteams(var_4.team);

          for(var_6 = 0; var_6 < var_5.size; var_6++) {
            if(!level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5[var_6])) {
              ref_13fa9(var_3.nuke_abortkillcamonspawn, rpg_shoot_at_trigs(var_5[var_6]) * 100);
              var_3.nuke_abortkillcamonspawn.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);
              break;
            }
          }
        }
      }

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(isDefined(var_1[var_2])) {
          handledropbags(var_1[var_2]);
        }
      }

      level.ref_12a12.ref_12482 = scripts\engine\utility::array_remove_array(level.ref_12a12.ref_12482, var_1);
    }

    waitframe();
  }

  if(isDefined(level.ref_12a12.ref_12482)) {
    for(var_2 = 0; var_2 < level.ref_12a12.ref_12482.size; var_2++) {
      if(isDefined(level.ref_12a12.ref_12482[var_2])) {
        handledropbags(level.ref_12a12.ref_12482[var_2]);
      }
    }

    level.ref_12a12.ref_12482 = undefined;
    return;
  }
}

function ref_13fa9(var_0) {
  var_1 = 1000000;
  var_2 = 1000;

  if(var_0 >= var_1) {
    var_3 = var_0 / var_1;
    self.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_IN_MILLIONS";
    self setvalue(var_3);
    return;
  }

  if(var_0 >= var_2) {
    var_3 = var_0 / var_2;
    self.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_IN_THOUSANDS";
    self setvalue(var_3);
    return;
  }

  self.label = &"MP_BR_INGAME/EXTRACT_PLUNDER";
  self setvalue(var_0);
}

function handledropbags() {
  if(isDefined(self.ref_121d8)) {
    self.ref_121d8 scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.playersetattractionextradata)) {
    self.playersetattractionextradata scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.nuke_abortkillcamonspawn)) {
    self.nuke_abortkillcamonspawn scripts\mp\hud_util::destroyelem();
    return;
  }
}

function build_formatted_key_value_string(var_0, var_1) {
  var_2 = "" + var_0 + ": ";

  if(isDefined(var_1)) {
    var_2 += var_1;
  } else {
    var_2 += "undefined";
  }

  return var_2;
}

function get_game_state_debug_strings() {
  var_0 = spawnStruct();
  var_0.miscstatelist = get_misc_state_list();
  var_0.teamstatelist = get_team_state_list();
  var_0.playerstatelist = get_player_state_list();
  var_0.plunderrepositorystatelist = get_plunder_repository_state_list();
  return var_0;
}

function get_plunder_event_type_as_string(var_0) {
  switch (var_0) {
    case 1:
      return "PICKUP";
    case 2:
      return "DEPOSIT";
    case 3:
      return "BANK";
    case 4:
      return "LOSE";
    case 5:
      return "BANK_DEPOSIT";
    case 6:
      return "LOSE_DEPOSIT";
    case 7:
      return "DEPOSIT_OR_STEAL";
    case 8:
      return "STEAL";
    case 0:
      return "NONE";
  }

  return "Unknown (" + var_0 + ")";
}

function get_misc_state_list() {
  var_0 = [];
  var_0[var_0.size] = build_formatted_key_value_string("Time", gettime());
  var_0[var_0.size] = build_formatted_key_value_string("Frame", gettime() / level.frameduration);

  if(isDefined(level.disable_super_in_turret))
    var_0[var_0.size] = build_formatted_key_value_string("level.brGametype.firstTeam", level.disable_super_in_turret.player_enemy_cooldown);

  var_0[var_0.size] = build_formatted_key_value_string("level.initialWinningTeam", level.time_before_shoot);
  var_1 = [];
  var_1[""] = [];
  var_1[""][0] = var_0;
  return var_1;
}

function get_team_state_list() {
  var_0 = [];

  if(!isDefined(level.teamnamelist)) {
    return var_0;
  }

  foreach(var_2 in level.teamnamelist) {
    var_3 = [];
    var_3 = build_formatted_key_value_string("Team", var_2);
    var_3 = build_formatted_key_value_string("\t Placement ", game["teamPlacements"][var_2]);
    var_3 = build_formatted_key_value_string("\t Score ", game["teamScores"][var_2]);
    var_3 = build_formatted_key_value_string("\t plunderTeamTotal", level.teamdata[var_2]["plunderTeamTotal"]);
    var_3 = build_formatted_key_value_string("\t plunderInDeposit", level.teamdata[var_2]["plunderInDeposit"]);
    var_3 = build_formatted_key_value_string("\t plunderBanked ", level.teamdata[var_2]["plunderBanked"]);
    var_4 = run_died_poorly_funcs(var_2);

    if(!isDefined(var_4)) {
      var_3 = build_formatted_key_value_string("\t Vault ", "undefined");
    } else {
      var_3 = build_formatted_key_value_string("\t Vault ", var_4.ref_127bd);
    }

    var_5 = scripts\mp\utility\teams::getfriendlyplayers(var_2);
    var_3 = build_formatted_key_value_string("\t Players", var_5.size);

    foreach(var_7 in var_5) {
      var_3 = build_formatted_key_value_string("\t\t Name", var_7.name);
    }

    if(!isDefined(var_0[var_2])) {
      var_0 = [];
    }

    var_0[var_0[var_2].size] = var_3;
  }

  return var_0;
}

function get_player_state_list() {
  var_0 = [];

  if(!isDefined(level.players)) {
    return var_0;
  }

  foreach(var_2 in level.players) {
    var_3 = [];
    var_3 = build_formatted_key_value_string("Player", var_2.name);
    var_3 = build_formatted_key_value_string("\t score", var_2.score);
    var_3 = build_formatted_key_value_string("\t team ", var_2.team);
    var_3 = build_formatted_key_value_string("\t br_cash_count", var_2.br_cash_count);
    var_3 = build_formatted_key_value_string("\t plunderbanked", var_2.plunderbanked);
    var_3 = build_formatted_key_value_string("\t plundercount ", var_2.plundercount);
    var_4 = [];

    if(isDefined(var_2.ref_127b9)) {
      foreach(var_6 in getarraykeys(var_2.ref_127b9)) {
        if(!isDefined(var_4[var_6])) {
          var_4 = spawnStruct();
        }

        var_4[var_6].ref_127b9 = var_2.ref_127b9[var_6];
      }
    }

    if(isDefined(var_2.ref_127b8)) {
      foreach(var_6 in getarraykeys(var_2.ref_127b8)) {
        if(!isDefined(var_4[var_6])) {
          var_4 = spawnStruct();
        }

        var_4[var_6].ref_127b8 = var_2.ref_127b8[var_6];
      }
    }

    var_3 = build_formatted_key_value_string("\t plunderEvents", var_4.size);

    foreach(var_6 in getarraykeys(var_4)) {
      var_11 = var_4[var_6];

      if(!isDefined(var_11.ref_127b9)) {
        var_11.ref_127b9 = "undefined";
      }

      if(!isDefined(var_11.ref_127b8)) {
        var_11.ref_127b8 = "undefined";
      }

      var_12 = "V" + var_11.ref_127b9 + ", T" + var_11.ref_127b8 + ", " + get_plunder_event_type_as_string(var_6);
      var_3 = build_formatted_key_value_string("\t\t ", var_12);
    }

    var_3 = "";

    if(!isDefined(var_0[var_2.team])) {
      var_0 = [];
    }

    var_0[var_0[var_2.team].size] = var_3;
  }

  return var_0;
}

function get_plunder_repository_state_list() {
  var_0 = [];

  if(!isDefined(level.ref_127c7)) {
    return var_0;
  }

  foreach(var_2 in level.ref_127c7.instances) {
    var_3 = [];
    var_3 = build_formatted_key_value_string("Repository", var_2.ref_127c8);
    var_3 = build_formatted_key_value_string("\t team ", var_2.team);
    var_3 = build_formatted_key_value_string("\t ID ", var_2.ref_127bd);
    var_3 = build_formatted_key_value_string("\t plundertotal ", var_2.ref_127d0);
    var_3 = build_formatted_key_value_string("\t plunderusable", var_2.ref_127d3);
    var_3 = build_formatted_key_value_string("\t playersusing", var_2.ref_126be.size);

    foreach(var_5 in var_2.ref_126be) {
      var_3 = build_formatted_key_value_string("\t\t Player", var_5.name);
    }

    var_3 = build_formatted_key_value_string("\t plunder", var_2.plunder.size);

    foreach(var_8 in var_2.plunder) {
      var_3 = build_formatted_key_value_string("\t\t Player", var_8.player.name);
      var_3 = build_formatted_key_value_string("\t\t\t plundercount", var_8.plundercount);
      var_3 = build_formatted_key_value_string("\t\t\t team", var_8.team);
    }

    if(!isDefined(var_2.ref_127b1)) {
      var_3 = build_formatted_key_value_string("\t plundercountdownplayers", 0);
    } else {
      var_3 = build_formatted_key_value_string("\t plundercountdownplayers", var_2.ref_127b1.size);

      foreach(var_5 in var_2.ref_127b1) {
        var_3 = build_formatted_key_value_string("\t\t Player", var_5.name);
      }
    }

    var_3 = "";

    if(isDefined(var_2.team)) {
      var_12 = var_2.team;
    } else {
      var_12 = "undefined";
    }

    if(!isDefined(var_0[var_12])) {
      var_0 = [];
    }

    var_0[var_0[var_12].size] = var_3;
  }

  return var_0;
}

function print_game_state_list_to_console(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = 0;

    foreach(var_6 in var_3) {
      foreach(var_8 in var_6) {}
    }
  }
}

function rat_race_print_match_info_to_console() {
  var_0 = get_game_state_debug_strings();
  print_game_state_list_to_console(var_0.miscstatelist, "Misc");
  print_game_state_list_to_console(var_0.teamstatelist, "Team");
  print_game_state_list_to_console(var_0.playerstatelist, "Player");
  print_game_state_list_to_console(var_0.plunderrepositorystatelist, "Plunder");
}