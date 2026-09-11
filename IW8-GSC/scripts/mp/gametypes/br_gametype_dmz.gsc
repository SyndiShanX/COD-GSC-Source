/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_dmz.gsc
****************************************************/

function init() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("kioskXP");

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("teamSpectate");
  }

  if(getdvarint("scr_br_dmz_latejoin", 0) != 0) {
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
  level.ref_13abd = getdvarint("scr_dmz_teamPlunder", 0);

  if(level.ref_13abd) {}

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
  var_0 = getdvarint("scr_dmz_win_cost", 1000);

  if(var_0 > 0) {
    var_0 *= 10;
    var_0 *= 100;
    setDvar("scr_br_scorelimit", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
  }

  setDvar("scr_br_magcount", 3);
  setDvar("scr_br_loadout_option", "nothing");
  setdvarifuninitialized("scr_br_respawnMaxTeammateOffset", 10000);
  setomnvar("ui_br_circle_state", 4);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  setdvarifuninitialized("scr_br_bank_alarm", 1);
  level.scriptedphysicaldofenabled = getdvarint("scr_dmz_giveLoadoutEveryTime", 1);
  level.trackriotshield_tryreset = getdvarint("scr_bmo_instantBleedOutSquadWipe", 1);
  level.debug_kill_tromeo = getdvarint("scr_bmo_bottomPercentageToAdjustEconomy", 50);
  level.ref_13bdf = getdvarint("scr_bmo_topPercentageToAdjustEconomy", 5);
  level.ref_14086 = getdvarint("scr_bmo_useMilestonePhases", 1);
  level.ref_11be6 = getdvarint("scr_bmo_milestonePhase_VIPs", 10);
  level.ref_11be5 = getdvarint("scr_bmo_milestonePhase_LZs", 30);
  level.ref_11be3 = getdvarint("scr_bmo_milestonePhase_Drops", 50);
  level.ref_11be4 = getdvarint("scr_bmo_milestonePhase_Helis", 75);
  level.br_checkforlaststandwipe = getdvarint("scr_dmz_airdrop_base_cash_amount", 750);
  level.spawn_default_player_spawns = getdvarint("scr_bmo_hidePlacementUntilPercent", 10);
  level.spawn_convoy_and_move = getdvarint("scr_bmo_hideLeaderHashUntilPercent", 0);
  level.ref_13366 = getdvarint("scr_bmo_progressSplashesAndMusic", 1);
  level.ref_12fb3 = getdvarint("scr_bmo_secondsBeforePlacementUpdates", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("scr_bmo_disable_perc_announcements", 0);
  level.ref_11a27 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11b62 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11a2a = getdvarint("scr_bmo_loot_leader_mark_size", 5000);
  level.ref_11a31 = getdvarint("scr_dmz_loot_leader_one_per_team", 1) == 1;
  level.ref_11a2b = getdvarint("scr_bmo_loot_leader_mark_size_dynamic", 1);
  level.ref_11a2d = getdvarint("scr_bmo_loot_leader_mark_info_strong_size", 2000);
  level.ref_11a2e = getdvarint("scr_bmo_loot_leader_mark_info_strong_value", 5000);
  level.ref_11a2f = getdvarint("scr_bmo_loot_leader_mark_info_weak_size", 5000);
  level.ref_11a30 = getdvarint("scr_bmo_loot_leader_mark_info_weak_value", 1000);
  level.onsquadeliminatedplacement = getdvarint("scr_bmo_loot_leader_expired_enabled", 0) == 1;
  level.ref_11a2c = getdvarint("scr_bmo_loot_leader_mark_top_teams", 2);
  level.ref_127c0 = getdvarfloat("scr_bmo_music_first", 0.3);
  level.ref_127c2 = getdvarfloat("scr_bmo_music_second", 0.5);
  level.ref_127c3 = getdvarfloat("scr_bmo_music_third", 0.75);
  level.ref_127c1 = getdvarfloat("scr_bmo_music_fourth", 0.9);
  level.ref_14062 = getdvarint("scr_dmz_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 20);
  level.ref_13bcd = getdvarint("scr_dmz_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_dmz_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_dmz_respawn_penalty_max", 15);
  level.ref_12ca7 = getdvarint("scr_bmo_respawnHeightOverride", 8000);
  level.ref_12cb4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.ref_121cc = getdvarfloat("scr_bmo_parachuteDeployDelay", 0.5);
  level.current_trigger = getdvarint("scr_dmz_bonusDeathPlunder", 200);
  level.current_volume_allies = getdvarint("scr_dmz_bonusDeathPlunder_ot", 250);
  level.ref_11b6c = getdvarint("scr_bmo_maxPlunderDropOnDeath", 10000);
  level.ref_11c40 = getdvarint("scr_bmo_minPlunderDropOnDeath", 200);
  level.ref_122f5 = getdvarint("scr_bmo_percentagePlunderDrop", 50);
  level.ref_127bc = getdvarint("scr_bmo_plunderFXOnDropThreashold", 750);
  level.ref_11b6b = getdvarint("scr_bmo_maxPlunderDropInOvertime", 2000);
  level.oic_loadouts = getdvarfloat("scr_bmo_executionCashMultiplier", 1);
  level.checkforcorrectinstance = getdvarint("scr_dmz_autoAssignFirstQuest", 0);
  level.ref_12966 = getdvarint("scr_bmo_questDomDistMin", 5000);
  level.ref_12965 = getdvarint("scr_bmo_questDomDistMax", 10000);
  level.ref_12962 = getdvarint("scr_bmo_questAssDistMin", 2500);
  level.ref_12961 = getdvarint("scr_bmo_questAssDistMax", 7500);
  level.ref_12968 = getdvarint("scr_bmo_questScavDistMin", 5000);
  level.ref_12967 = getdvarint("scr_bmo_questScavDistMax", 8000);
  level.ref_1296a = getdvarint("scr_bmo_questScavDistMin", 5000);
  level.ref_12969 = getdvarint("scr_bmo_questScavDistMax", 8000);
  level.ref_139ea = getdvarfloat("scr_bmo_questTabletReplaceEveryN", 1.5);
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
  level.lootcontentsadjusteconomy_bottomtier = getdvarint("scr_dmz_win_cost", 1000) * 1000;
  level.lootchopper_isnearbyoccupiedspawns = getdvarint("scr_br_extract_cost", 300);
  level.lootchopper_oncrateuse = getdvarint("scr_br_extract_cost_min", 40);
  level.lootchopper_managespawns = getdvarint("scr_br_extract_cost_decrease", 20);
  level.ref_11c41 = getdvarint("br_min_plunder_extractions", 7);
  level.ref_11b6d = getdvarint("br_max_plunder_extractions", 7);
  level.disable_back_light = 1;
  thread scripts\mp\gametypes\br_lootchopper::init();
  thread toggleusbstickinhand();
  thread teleportplayertoselection();
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
  level.ref_11c76 = &dyn_door;
  level.elevator_lights_toggle = &ref_11c50;
  level.ononeleftevent = &ononeleftevent;
  level.onplayerkilled = &onplayerkilled;
  level.ref_12075 = &ref_12075;
  level.ontimelimit = &ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&ref_12601);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread ref_1325e();
  thread scripts\mp\gametypes\br_lootchopper::ref_11a0f();
  thread scripts\mp\gametypes\br_c130airdrop::fnoffhandfire();
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

  if(!istrue(level.ref_14086)) {
    thread ref_12397();
  }

  thread ref_14364();
  level thread scripts\mp\gametypes\br_analytics::teamvehicles();
  cleanupents();

  if(level.ref_13abd) {
    if(getdvarfloat("scr_dmz_loot_leader_update_interval", 15) > 0) {
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

  var_4 = getdvarint("scr_bmo_c130OverrideSpeed", -1);

  if(var_4 > 0) {
    level.br_level.c130_speedoverride = var_4;
  }

  thread getblockedweaponvariantidsmap();

  if(level.make_bomb_detonator_interact && level.ref_12191) {
    thread getburnfxstatepriority();
    return;
  }
}

function getblockedweaponvariantidsmap() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  level endon("end_circlestate_timer");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = getdvarint("scr_br_timelimit");
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));
  wait int(max(var_0 - 300, 0));
  setomnvar("ui_br_circle_state", 6);
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

    freefallfromplanestatemachine();
    return;
  }
}

function ononeleftevent(var_0) {}

function ref_126f1(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome_dmz");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("joining_Infil");
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  wait 1;
  thread freefallfromplanestatemachine();

  if(soundexists("dx_bra_uktl_bm_tut_earn_cash")) {
    level scripts\mp\gametypes\br_public::dmztut_endgamewithreward("bm_tut_earn_cash", self);
  }

  scripts\mp\hud_message::showsplash("br_gametype_dmz_welcome");

  if(istrue(self.tutorial_usingparachute)) {
    level scripts\mp\gametypes\br_public::dmztut_endgamewithreward("deploy_squad_leader", self, 1, 0, 4.5);
  }

  if(istrue(level.checkforcorrectinstance) && istrue(level.br_prematchstarted)) {
    checkforlaststandwipe(self);
    return;
  }
}

function ref_1365d(var_0) {
  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
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

function freefallfromplanestatemachine() {
  level.lootchopper_initspawninfo = 0;

  foreach(var_1 in level.teamdata) {
    if(var_1["players"].size > 0) {
      level.lootchopper_initspawninfo++;
    }
  }
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
    return;
  }
}

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
  var_5 = scripts\mp\gametypes\br_gulag::ref_125be();
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
      var_31 = registerontimerupdate(var_29);
      var_32 = ref_14025(var_30, var_29, level.disable_super_in_turret.player_enemy_cooldown);
      var_33 = revive_or_disconnect_monitor(var_29);
      var_34 = var_16[var_29];

      if(var_30 > var_26) {
        if(var_26 > var_27) {
          var_27 = var_26;
          var_25 = var_24;
        }

        var_26 = var_30;
        var_24 = var_29;
      } else if(var_24 != "none") {
        if(var_30 > var_27) {
          var_27 = var_30;
          var_25 = var_29;
        }
      }

      var_35 = (var_30 - var_31) * 100;
      var_36 = var_30 * 100;
      var_37 = var_36 - var_35;

      if(var_35 < 0) {
        var_35 = 0;
      }

      if(var_36 >= var_13 * 0.9) {
        var_18 = var_29;
      } else if(var_36 >= var_13 * 0.75) {
        var_19 = var_29;
      } else if(var_36 >= var_13 * 0.5) {
        var_20 = var_29;
      }

      if(var_36 >= var_13 * level.ref_127c1) {
        thread scripts\mp\music_and_dialog::ref_12791();
      } else if(var_36 >= var_13 * level.ref_127c3) {
        thread scripts\mp\music_and_dialog::ref_127a7();
      } else if(var_36 >= var_13 * level.ref_127c2) {
        thread scripts\mp\music_and_dialog::ref_1278b();
      } else if(var_36 >= var_13 * level.ref_127c0) {
        thread scripts\mp\music_and_dialog::ref_127a9();
      }

      var_38 = scripts\mp\utility\teams::getfriendlyplayers(var_29, 0);

      foreach(var_40 in var_38) {
        var_34 = var_16[var_40.team];

        if(!var_6) {
          var_34 = 155;
        }

        var_40 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var_34);
        var_40 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_player_position", var_34);
        setobjectivecallbacks(var_40, "ui_br_team_cash_banked", int(var_37 * 0.01));
        setobjectivecallbacks(var_40, "ui_br_team_cash_pockets", int(var_35 * 0.01));
        var_22 = var_40.plundercount;
        var_23 = var_40;
      }

      if(var_15) {
        if(var_34 == 1) {
          var_21 = var_29;
        } else if(var_34 <= 5) {
          if(var_33 > 5) {
            showsplashtoteam(var_29, "bm_top_5");
          }
        } else if(var_34 <= 10) {
          if(var_33 > 10) {
            showsplashtoteam(var_29, "bm_top_10");
          }
        }
      }

      if(var_36 >= var_13) {
        checkforovertime(var_29);

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

    var_43 = [];
    var_44 = [];

    if(level.ref_11a2c == 1) {
      var_43 = setteamplacement(game["teamPlacements"], "up");
    } else if(level.ref_11a2c == 2) {
      var_43 = var_24;
      var_44 = setteamplacement(var_22, "down");
    } else {
      var_44 = setteamplacement(var_22, "down");
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

      if(!var_4 && var_26 * 100 >= var_13 * level.ref_11be3 * 0.01) {
        var_4 = 1;
        level.ref_136f6 = gettime();
        level.br_level.c130_speedoverride = 3044;
        scripts\mp\flags::gameflagset("activate_cash_drops");
      }

      if(!var_5 && (istrue(level.convoy_handle_stuck_compromise) || var_26 * 100 >= var_13 * level.ref_11be4 * 0.01)) {
        var_5 = 1;

        if(getdvarint("scr_dmz_lc_active", 0)) {
          level.ref_136f7 = gettime();
          scripts\mp\flags::gameflagset("activate_cash_helis");

          if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
            scripts\mp\gametypes\br_public::brleaderdialog("event_chopper", 0, undefined, undefined, undefined, "bm");
          }
        }
      }

      if(!var_6 && var_26 * 100 >= var_13 * level.spawn_default_player_spawns * 0.01) {
        var_6 = 1;
      }

      if(var_2 && var_3 && var_4 && var_5) {
        var_7 = 1;
      }
    }

    if(!var_15 || var_26 == 0) {
      waitframe();
      continue;
    }

    if(level.ref_11a2c > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
        ref_13ff0(var_22, var_44, var_23, var_43);
        level.ref_127d2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
      ref_13ff0(var_22, var_44, var_23);
      level.ref_127d2 = 0;
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

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_18) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_90_perc_enemy", var_50, 1, undefined, "bm");
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

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_19) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_75_perc_enemy", var_50, 1, undefined, "bm");
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

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_20) {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback("gamestate_50_perc_enemy", var_50, 1, undefined, "bm");
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
    var_5 = 32;

    if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
      var_5 = 0;
    }

    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, var_5));
  }

  var_6 = var_2;

  if(istrue(self.ref_14436)) {
    var_6 = int(var_2 * level.oic_loadouts);
  }

  var_7 = var_6;

  if(istrue(level.convoy_handle_stuck_compromise) && (!isDefined(var_4) || self != var_4)) {
    var_7 = int(var_6 * level.ref_12192);

    if(isDefined(level.ref_11b6b) && var_7 > level.ref_11b6b) {
      var_7 = level.ref_11b6b;
    }
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && istrue(self.get_vehicle_ai_spawner)) {
    var_7 = int(var_7 + self.get_vehicle_ai_spawner);
  }

  var_8 = dropplunderbyrarity(var_7, var_3);

  foreach(var_10 in var_8) {
    var_10.ref_11a40 = "combat";
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    level notify("victim_death_drop", self, var_4, var_8);
  }

  if(isDefined(var_4) && self == var_4 || !level.killcam) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_dropped", var_3);
  } else {
    self.ref_12801 = var_3;
  }

  scripts\mp\gametypes\br_analytics::ref_13c44(self, "combat", var_3 * -1);

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, self)) {
    var_5 = 64;

    if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
      var_5 = 0;
    }

    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, var_5));
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

function dropplunderbyrarity(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level.br_plunder.ref_12954.size - 1; var_5 >= 0; var_5--) {
    var_3 = int(var_0 / level.br_plunder.ref_12954[var_5]);
    var_4 += var_3[var_5];

    if(var_0 <= 0) {
      break;
    }

    var_0 -= var_3[var_5] * level.br_plunder.ref_12954[var_5];
  }

  for(var_6 = level.br_plunder.ref_12954.size - 1; var_6 >= 0; var_6--) {
    if(!isDefined(var_3[var_6])) {
      continue;
    }

    for(var_7 = 0; var_7 < var_3[var_6]; var_7++) {
      var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
      var_9 = scripts\mp\gametypes\br_pickups::spawnpickup(level.br_plunder.names[var_6], var_8, level.br_plunder.ref_12954[var_6], 1);
      scripts\mp\gametypes\br_plunder::ref_11c91(level.br_plunder.names[var_6], 1);

      if(isDefined(var_9)) {
        var_2 = var_9;

        if(scripts\mp\gametypes\br_plunder::inplunderlivelobby()) {
          level.br_plunder_ents[level.br_plunder_ents.size] = var_9;
        }
      }
    }
  }

  level.br_plunder.ref_1278f += var_4;

  if(isDefined(var_0)) {
    level.br_plunder.ref_127ac += var_0;
  }

  level thread scripts\mp\gametypes\br_plunder::dropplundersounds(self.origin, var_2.size);
  return var_2;
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
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_0, var_1);
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

function test_trigger_spawn() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    GscBinSkip0(0x2e, var_0.size, (-33750, -36000, 155));
  }

  switch (level.mapname) {
    case "mp_br_mechanics":
      GscBinSkip0(0x2e, var_0.size, (1500, 1500, 0));

    case "mp_mb_tut":
      break;
  }

  level.outer = var_0;
  level.oscope_ampl_think = [];
  thread ref_11d07();
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
  var_0 = getdvarfloat("scr_dmz_loot_leader_update_interval", 15);
  var_1 = getdvarfloat("scr_dmz_loot_leader_update_interval_blink", 5);
  var_2 = getdvarint("scr_bmo_circle_pulse_start", 800);
  var_3 = getdvarint("scr_bmo_circle_pulse_end", 200);
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

function ref_13ff0(var_0, var_1, var_2, var_3) {
  level.ref_11a36 = level.ref_11a32;
  level.ref_11a32 = [];

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
    jumpiffalse(level.ref_11a2c == 2) LOC_000001ae;
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

    goto LOC_0000022c;
  }

  foreach(var_11 in level.ref_11a36) {
    if(isDefined(var_11) && !scripts\engine\utility::array_contains(level.ref_11a32, var_11)) {
      ref_12c18(var_11);
    }
  }

  for(var_7 = 0; var_7 < level.ref_11a27; var_7++) {
    var_18 = level.ref_11a29[var_7];

    if(isDefined(level.ref_11a32[var_7])) {
      var_18.targetplayer = level.ref_11a32[var_7];
      var_18.targetplayer.ref_11a26 = var_18;
      var_19 = (var_18.targetplayer.origin[0], var_18.targetplayer.origin[1], level.ref_11a2a);

      if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
        var_19 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);
      }

      var_18 scripts\mp\gametypes\br_quest_util::ref_11dae(var_19);

      if(istrue(level.ref_11a2b)) {
        ref_13fef(var_18);
      }

      var_20 = scripts\engine\utility::array_contains(level.ref_11a32, var_18.targetplayer) && !scripts\engine\utility::array_contains(level.ref_11a36, var_18.targetplayer);
      var_21 = scripts\mp\utility\teams::getenemyplayers(var_18.targetplayer.team, 0);

      foreach(var_11 in var_21) {
        var_18 scripts\mp\gametypes\br_quest_util::ref_1336a(var_11);
      }

      var_24 = scripts\mp\utility\teams::getfriendlyplayers(var_18.targetplayer.team, 0);

      foreach(var_11 in var_24) {
        var_18 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_11);
      }

      if(var_20) {
        battle_tracks_updatebattletracks(var_18);
      }

      continue;
    }

    var_18.targetplayer = undefined;

    foreach(var_11 in level.players) {
      var_18 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_11);
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
    var_9 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);
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

function get_valid_seats() {
  var_0 = "accessory_money_bag_large_closed_player";

  if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
    var_0 = "accessory_gold_bar_bag_player";
  }

  self attach(var_0, "tag_stowed_back3", 1, 1);
  self.carriable_set_dropped = var_0;

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

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, self) && !isDefined(self.carriable_set_dropped)) {
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
    if(getdvarfloat("scr_dmz_loot_leader_update_interval", 15) > 0) {
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

    ref_13371(var_3);
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
    ref_13371(var_3);
    wait 5;
  }

  level.playerparachutedetachresetomnvars = undefined;
  scripts\mp\flags::gameflagwait("overtime_started");
  setomnvar("ui_br_circle_state", 7);

  if(!isDefined(var_2)) {
    var_9 = gettime() + int(level.make_bomb_detonator_interact * 1000);
    setomnvar("ui_hardpoint_timer", var_9);
  }

  wait int(max(level.make_bomb_detonator_interact - 60, 0));
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