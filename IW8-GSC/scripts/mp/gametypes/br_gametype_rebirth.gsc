/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_rebirth.gsc
********************************************************/

function init() {
  thread enabledfeatures();
  thread enabledskipdeathshield();
  thread enable_traversals_for_bombers();
  thread enabledbasejumping();
  setdvarifuninitialized("scr_br_rebirth_circle_setting", 0);
  setDvar("scr_br_project_kick", 1500);
  thread enabledskiplaststand();
}

function enabledskiplaststand(var_0) {
  var_1 = getDvar("scr_br_gametype");

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter()) {
    timeoutonabandoneddelay("mp/classtable_br_rebirth_ww2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2_ww2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3_ww2.csv");
  } else if(var_1 == "rebirth_dbd") {
    timeoutonabandoneddelay("mp/classtable_br_rebirth_dbd.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2_dbd.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3_dbd.csv");
  } else {
    timeoutonabandoneddelay("mp/classtable_br_rebirth.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3.csv");
  }

  level.disable_super_in_turret.ref_140a3 = getdvarint("scr_br_use_tracked_teams", 1);
  level.disable_super_in_turret.ref_140a5 = getdvarint("scr_br_use_vengeance", 1);
  level.disable_super_in_turret.ref_1428b = getdvarint("scr_br_vengeance_use_any_kill", 0);
  level.disable_super_in_turret.ref_140a6 = getdvarint("scr_br_use_vengeance_decrease_respawn_timer", 1);
  level.disable_super_in_turret.ref_14094 = getdvarint("scr_br_use_respawn_waves", 0);
  level.disable_super_in_turret.ref_1408d = getdvarint("scr_br_use_points_to_reduce_respawn_time", 1);
  level.disable_super_in_turret.botpickskinid = getdvarfloat("scr_br_rebirth_aircraft_max_allowed", 30);
  level.disable_super_in_turret.br_ammo_player_is_maxed_out = getdvarfloat("scr_br_rebirth_aircraft_type", 1);
  level.disable_super_in_turret.startingloadoutindex = getdvarint("scr_br_rebirth_starting_loadout_index", 0);
  level.ref_12ca7 = getdvarint("scr_bmo_respawnHeightOverride", 7500);
  level.disable_super_in_turret.ref_12c92 = getdvarint("scr_br_rebirth_respawn_should_wait_prestreaming_end", 0);
  level.disable_super_in_turret.ref_12c91 = getdvarint("scr_br_rebirth_respawn_should_notify_started_spawn", 1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &empty_function);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", &end_silo_thrust);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &end_intro_obj);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropLoadout", &brrebirth_playerdroploadout);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getDefaultLoadout", &enable_spawner);
  scripts\mp\gametypes\br_gametypes::ref_12b11("kioskRevivePlayer", &enablejuggernautcrateobjective);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);

  if(getdvarint("scr_br_custom_final_circle_override", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &ref_12181);
    scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &ref_12181);
  }

  if(!istrue(level.tryupdategenericprogress)) {
    scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &end_game_tutorial_func);
  }

  if(istrue(var_0)) {
    brrebirth_initneverendingresurgence();
  }

  waittillframeend();

  if(level.disable_super_in_turret.ref_1408d) {
    level.ref_12073 = &end_game_win;
  }

  scripts\mp\gametypes\br_skydive_protection::init();
  tomastrike_findoptimallaunchpos();
  thread end_paratroopers_group();
  thread end_reach_exhaust_waste();
  thread end_reach_icbm_launch();
  thread end_origin_final();
  thread end_pipe_room();
}

function enabledfeatures() {
  if(getdvarint("scr_br_rebirth_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) != 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
    return;
  }
}

function enabledskipdeathshield() {
  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) != 0) {
    scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &enable_leaderboard);
    scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &emp_target_monitor);

    if(getdvarint("scr_rebirth_shouldSetInitalDropDelay", 1) == 1) {
      thread end_nuke_vault();
    }
  }

  waittillframeend();
  level.ontimelimit = &end_gates;
  enable_keypad_interaction();
  level.ref_140d9 = [];
  level.ref_140d9[0] = "assassination";
  level.ref_140d9[1] = "domination";
  level.ref_140d9[2] = "scavenger";
  scripts\mp\rank::ref_12189("kill", 100);
  scripts\mp\rank::ref_12189("br_cacheOpen", 200);
}

function loop(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getentitynumber();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = 4;
  var_6 = var_5;
  var_7 = 8;
  var_8 = var_6 + var_7;
  var_9 = 16;
  var_10 = 0;
  var_11 = var_8 + var_9;

  foreach(var_13 in var_3) {
    var_10 |= var_13 << var_11;
    var_11++;
  }

  var_15 = 0;
  var_15 = var_10 | var_2 << var_8 | var_4 << var_6 | var_1;
  self setclientomnvar("ui_br_expanded_obit_message", var_15);
}

function loop_emp_spark_vfx(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in scripts\mp\utility\teams::getteamdata(var_0, "players")) {
    loop(var_6, var_1, var_2, var_3, var_4);
  }
}

function end_game_cheer(var_0, var_1, var_2) {
  if(getdvarint("scr_br_notify_team_vengeance", 1) == 0) {
    return;
  }

  var_3 = var_1 getentitynumber();
  var_4 = var_0 getentitynumber();
  var_5 = [];
  var_6 = 1;
  var_7 = scripts\mp\utility\teams::getteamdata(level.players[var_4].team, "players");

  foreach(var_9 in var_7) {
    if(var_9 == level.players[var_4]) {
      var_5 = 0;
      var_6++;
      continue;
    }

    var_5 = 0;

    foreach(var_11 in var_2) {
      if(var_9 == var_11) {
        var_5 = 1;
        break;
      }
    }

    var_6++;
  }

  for(var_14 = var_6; var_14 < 4; var_14++) {
    var_5 = 0;
  }

  loop_emp_spark_vfx(level.players[var_4].team, level.players[var_4], 13, var_3, var_5);
}

function enable_traversals_for_bombers() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");

  if(level.disable_super_in_turret.name == "rebirth_dbd") {
    game["dialog"]["match_desc"] = "gametype_desc_resurgence_trials";
  } else {
    game["dialog"]["match_desc"] = "gametype_desc_resurgence";
  }

  game["dialog"]["match_start"] = "gametype_resurgence";
  game["dialog"]["last_man_standing"] = "rsrg_squad_last_alive";
  game["dialog"]["rebirth_avenge_teammate"] = "rebirth_avenge_teammate";
  game["dialog"]["rebirth_redeploy"] = "rebirth_redeploy";
  game["dialog"]["rebirth_disabled"] = "rebirth_reinforcement_disabled";
  game["dialog"]["rebirth_ending"] = "rebirth_reinforcement_ending";
  game["dialog"]["rebirth_teammate_respawn"] = "rebirth_teammate_respawn";
}

function brrebirth_initdialogrespawndisabled() {
  game["dialog"]["last_man_standing"] = "rebirth_last_alive";
}

function enable_keypad_interaction() {
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("me_electrical_box_street_01", 1);
}

function enabledbasejumping() {}

function end_paratroopers_group() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.disable_super_in_turret.ref_12ca4 = 1;
}

function end_reach_exhaust_waste() {
  waittillframeend();
  var_0 = level.allteamnamelist;

  foreach(var_2 in var_0) {
    level.teamdata[var_2]["index"] = var_3;
  }

  var_4 = getdvarint("scr_br_tracked_teams_for_entire_team", 0);

  if(istrue(var_4)) {
    foreach(var_2 in level.teamdata) {
      level.teamdata[var_6]["trackedTeams"] = [];
    }

    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(var_8 in level.players) {
    var_8.ref_13c4b = [];
  }
}

function end_reach_icbm_launch() {
  foreach(var_1 in level.teamdata) {
    level.teamdata[var_2]["deadPlayers"] = [];
  }
}

function end_gates() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function empty_function(var_0) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread end_unlock_silo();

    if(!istrue(level.disable_super_in_turret.useneverendingresurgence)) {
      scripts\mp\gametypes\br::ref_11b15(var_0);
    }
  }

  return true;
}

function end_freight_lift(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "players")) {
    if(!istrue(var_2.shouldgamelobbyremainintact) && isalive(var_2) && var_0 != var_2) {
      var_2.shouldgamelobbyremainintact = 1;
      var_2 thread scripts\mp\hud_message::showsplash("br_rebirth_first_dead");
    }
  }
}

function end_health() {
  if(!isDefined(self.endgame_finitewaves_music)) {
    self.endgame_finitewaves_music = 0;
  }

  var_0 = self.endgame_finitewaves_music;

  if(var_0 > 255) {
    var_0 = 255;
  }

  self.extrascore0 = var_0;
  self.pers["extrascore0"] = var_0;
  return var_0;
}

function end_trans_1_obj(var_0, var_1) {
  var_2 = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

  if(var_2) {
    level.teamdata[self.team]["teamHadFirstRevive"] = 1;
  }

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.endgame_finitewaves_music)) {
      var_4.endgame_finitewaves_music = 0;
    }

    var_4.endgame_finitewaves_music++;

    if(scripts\mp\utility\game::round_vehicle_logic() != "mendota") {
      var_4 scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", var_4.endgame_finitewaves_music);
      end_health(var_4);
    }

    var_5 = !isDefined(var_1) || var_4 != var_1;
    var_6 = var_2 && var_5;

    if(var_6) {
      var_4 thread scripts\mp\hud_message::showsplash("br_rebirth_first_revive");
    }
  }
}

function enablejuggernautcrateobjective(var_0, var_1) {
  var_2 = self;
  var_2 thread scripts\mp\gametypes\br_gulag::playergulagautowin("rebirth", var_0, var_1);
  end_trans_1_obj(var_2, level.teamdata[var_2.team]["alivePlayers"], var_0);
  end_jugg_maze();
}

function droponplayerdeath(var_0) {
  if(istrue(level.disable_super_in_turret.loadoutrestore) && !isDefined(self.ref_12eb0)) {
    scripts\mp\gametypes\br::ref_125fc();
  }

  return false;
}

function end_game_tutorial_func(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(!isDefined(var_0.victim)) {
    return;
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12e05("preOnPlayerKilled", var_0);
  thread end_freight_lift(var_0.victim);

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || var_0.attacker == var_0.victim) {
    return;
  }

  var_1 = scripts\mp\utility\teams::getteamdata(var_0.attacker.team, "aliveCount");

  if(var_1 <= 0) {
    return;
  }

  end_this_module(var_0.attacker, var_0.attacker.team, var_0.victim.team);
  thread end_slow_mode_safe(var_0.attacker, var_0.attacker.team);
}

function end_this_module(var_0, var_1) {
  if(!level.disable_super_in_turret.ref_140a3) {
    return;
  }

  end_silo_jump(var_0, var_1);
}

function end_slow_mode_safe(var_0, var_1) {
  level endon("game_ended");

  if(!level.disable_super_in_turret.ref_140a5) {
    return;
  }

  if(!istrue(level.disable_super_in_turret.ref_12ca4)) {
    return;
  }

  var_2 = scripts\mp\utility\teams::getteamdata(var_0, "aliveCount");

  if(var_2 <= 0) {
    return;
  }

  var_3 = level.teamdata[var_0]["deadPlayers"];

  if(var_3.size <= 0) {
    return;
  }

  var_4 = enable_super(var_3, var_1);
  empty_collision_handler(var_4, var_1);
}

function enable_super(var_0, var_1) {
  var_2 = [];
  jumpiffalse(istrue(level.disable_super_in_turret.ref_1428b)) LOC_00000056;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
    break;
  }

  goto LOC_000000b5;
}

function empty_collision_handler(var_0, var_1) {
  if(var_0.size <= 0) {
    return;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }

    empendearly(var_3);
  }

  if(!istrue(level.disable_super_in_turret.ref_140a6)) {
    end_game_cheer(self, var_1, var_0);
  }

  thread scripts\mp\events::killeventtextpopup("br_rebirth_vengeance", 0, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("rebirth_avenge_teammate", self);
}

function empendearly(var_0) {
  if(istrue(level.disable_super_in_turret.ref_140a6)) {
    var_0.ref_12ca1 -= getdvarint("scr_br_vengeance_decrease_respawn_delay", 5);
    return;
  }

  thread enable_oob_immunity_on_riders(var_0, 1);
}

function play_track_damage_screen_vfx(var_0) {
  var_1 = -1;
  var_2 = 2147483647;

  foreach(var_4 in var_0) {
    if(var_4["startTime"] < var_2) {
      var_1 = var_5;
      var_2 = var_4["startTime"];
    }
  }

  return var_1;
}

function getteamindex(var_0) {
  return level.teamdata[var_0]["index"];
}

function start_reach_pipe_room(var_0, var_1) {
  var_2 = -1;

  foreach(var_4 in var_0) {
    if(var_4["name"] == var_1) {
      var_2 = var_5;
      break;
    }
  }

  return var_2;
}

function ref_14023(var_0, var_1, var_2) {
  var_3 = int(pow(2, 8));
  var_4 = 8 * var_2;
  var_5 = var_3 - 1;
  var_5 <<= var_4;
  var_6 = ~var_5;
  var_0 &= var_6;
  var_7 = var_1 << var_4;
  var_0 |= var_7;
  return var_0;
}

function ref_14029(var_0, var_1, var_2) {
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(isDefined(var_5)) {
      if(var_3 < 0) {
        var_3 = var_5 calloutmarkerping_entityzoffset("rebirth_tracked_teams");
        var_3 = ref_14023(var_3, var_1, var_2);
      }

      var_5 setclientomnvar("rebirth_tracked_teams", var_3);
    }
  }
}

function run_lbravo_spawner() {
  var_0 = getdvarint("scr_br_tracked_teams_for_entire_team", 0);
  var_1 = [];

  if(istrue(var_0)) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "trackedTeams");
  } else {
    if(!isDefined(self.ref_13c4b)) {
      self.ref_13c4b = [];
    }

    var_1 = self.ref_13c4b;
  }

  return var_1;
}

function end_silo_jump(var_0, var_1) {
  var_2 = -1;
  var_3 = run_lbravo_spawner();
  var_2 = start_reach_pipe_room(var_3, var_1);

  if(var_2 < 0) {
    if(var_3.size == 4) {
      var_2 = play_track_damage_screen_vfx(var_3);
    } else {
      var_2 = var_3.size;
    }
  }

  if(var_2 < 0 || var_2 >= 4) {
    return;
  }

  thread end_silo_elevator(var_0, var_1, var_2);
}

function end_silo_elevator(var_0, var_1, var_2) {
  if(var_2 < 0 || var_2 >= 4) {
    return;
  }
  var_3 = "trackTeam" + var_0 + var_2;
  var_4 = [];
  var_5 = [];
  var_5["name"] = var_1;
  var_5["startTime"] = gettime();
  var_6 = getdvarint("scr_br_tracked_teams_for_entire_team", 0);

  if(istrue(var_6)) {
    level notify(var_3);
    level endon(var_3);
    level.teamdata[var_0]["trackedTeams"][var_2] = var_5;
    var_4 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  } else {
    self notify(var_3);
    self endon(var_3);
    self.ref_13c4b[var_2] = var_5;
    var_4 = [self];
  }

  var_7 = getteamindex(var_1);
  ref_14029(var_4, var_7, var_2);
  var_8 = getdvarfloat("scr_br_tracked_teams_clear_delay", 2.5);
  wait(var_8);
  ref_14029(var_4, 0, var_2);
}

function end_origin_final() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) == 0) {
    level waittill("infils_ready");
  }

  var_0 = rocket_attack_min_cooldown();
  var_1 = 0;

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0)) {
    var_1 = 1;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 += level.br_level.br_circleclosetimes[var_2] + level.br_level.br_circledelaytimes[var_2];
  }

  var_3 = int(var_1 * 1000);
  var_4 = gettime();
  var_5 = var_4 + var_3;
  setomnvarforallclients("ui_br_plunder_extract_end_time", var_5);
  level.ally_movement_defend_0 = var_1;
  var_6 = var_3;
  var_7 = getdvarint("scr_br_rebirth_show_respawn_closed_timer_max_time", 90000);
  thread end_mine_caves(var_6 / 1000);

  while(var_6 > var_7) {
    wait(var_6 - var_7) / 1000;
    var_8 = gettime() - var_4;
    var_6 = var_3 - var_8;
  }

  setomnvarforallclients("ui_br_plunder_extract_end_time", int(gettime() + var_6));

  foreach(var_10 in level.players) {
    if(!isDefined(var_10)) {
      continue;
    }

    var_10 thread scripts\mp\hud_message::showsplash("br_rebirth_reinforcement_closing");
  }
}

function end_mine_caves(var_0) {
  wait var_0 - 90;
  scripts\mp\gametypes\br_public::brleaderdialog("rebirth_ending");
}

function end_pipe_room() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.disable_super_in_turret.ref_12ca1 = [];
  level.disable_super_in_turret.ref_14093 = getdvarint("scr_br_use_respawn_delay_per_circle", 1);

  if(level.disable_super_in_turret.ref_14093) {
    var_0 = rocket_attack_min_cooldown();

    for(var_1 = 0; var_1 < var_0; var_1++) {
      level.disable_super_in_turret.ref_12ca1[var_1] = getdvarint("scr_br_rebirth_respawn_delay_circle" + var_1 + 1, 30);
    }

    return;
  }

  level.disable_super_in_turret.ref_12ca1[0] = getdvarint("scr_br_rebirth_respawn_delay", 30);
}

function brrebirth_hiderebirthrespawntimer() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 &~16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function brrebirth_showrebirthrespawntimer() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 | 16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function brrebirth_setrebirthrespawntimervengeanceflag() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 | 32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function brrebirth_resetrebirthrespawntimervengeanceflag() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 &~32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function brrebirth_setrebirthrespawntimervalue(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_2 = var_1 &~16383;
  var_3 = var_2 | var_0;
  self setclientomnvar("ui_rebirthRespawnTimer", var_3);
}

function brrebirth_setrebirthrespawntimerdeltavalue(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_2 = var_1 &~2147418112;
  var_3 = var_1 & 1073741824;

  if(var_3 != 0) {
    var_3 = 0;
  } else {
    var_3 = 1073741824;
  }

  var_4 = var_2 | var_0 << 16 | var_3;
  self setclientomnvar("ui_rebirthRespawnTimer", var_4);
}

function carriable_init(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
    var_5 = isalive(var_3) && !istrue(var_3.inlaststand);

    if(var_3 != var_0 && var_5 && !var_4) {
      return true;
    }
  }

  return false;
}

function end_ml_p3_exfil() {
  var_0 = self;

  if(var_0 scripts\mp\gametypes\br_gulag::ref_12517()) {
    end_trans_1_obj(var_0, level.teamdata[var_0.team]["alivePlayers"]);
    end_jugg_maze();
    var_0 scripts\mp\playerlogic::addtoalivecount("rebirth1");
    scripts\mp\gametypes\br::ref_13f21(var_0, "rebirth1");
    var_1 = scripts\mp\gametypes\br::dynamic_door(var_0);

    if(!var_1) {
      scripts\mp\gametypes\br_gulag::entergulag(var_0);
    }

    self.waitingtospawn = 0;
    return;
  }
}

function empty_vo_func() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  if(istrue(level.disable_super_in_turret.ref_14081)) {
    while(carriable_init(self)) {
      waitframe();
    }

    brrebirth_hiderebirthrespawntimer();
    self notify("squad_wiped");
    waitframe();
    end_ml_p3_exfil();
    return;
  }

  for(var_0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"); var_0 > 0; var_0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount")) {
    waitframe();
  }

  brrebirth_hiderebirthrespawntimer();
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
  self notify("squad_wiped");
}

function end_game_win(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isalive(var_0)) {
    return;
  }

  if(var_1 <= 0) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || !scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(isDefined(var_2) && isDefined(var_3) && var_2 == "br_kioskBuy" && var_3 == "br_team_revive") {
    var_4 = scripts\mp\utility\teams::getteamdata(var_0.team, "aliveCount");
    var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "teamCount");
    var_6 = var_5 - var_4;

    if(var_6 == 1) {
      return;
    }
  }

  var_7 = getdvarfloat("scr_br_rebirth_points_to_second_ratio", 0.02);
  var_8 = getdvarint("scr_br_rebirth_points_to_first_second_offset", 50);
  var_9 = int(floor((var_1 + var_8) * var_7));

  if(isDefined(var_2)) {
    if(var_2 == "br_kioskBuy") {
      var_10 = getdvarfloat("scr_br_rebirth_points_to_second_kiosk_buy_ratio", 0.3);
      var_9 = int(ceil(var_9 * var_10));
    } else if(var_2 == "kill") {
      var_9 = int(floor((250 + var_8) * var_7));
    } else if(var_2 == "br_cacheOpen") {
      var_9 = int(floor((100 + var_8) * var_7));
    }
  }

  if(var_9 <= 0) {
    return;
  }

  var_11 = level.teamdata[var_0.team];

  if(!isDefined(var_11)) {
    return;
  }

  if(isDefined(level.obit_activation) && isDefined(level.obit_activation.ref_121ad) && isDefined(level.obit_activation.ref_129d1) && var_0.team == level.obit_activation.ref_129d1) {
    var_9 *= level.obit_activation.ref_121ad;
  }

  var_12 = var_11["deadPlayers"];

  if(!isDefined(var_12)) {
    return;
  }

  var_13 = 0;

  foreach(var_15 in var_12) {
    if(isDefined(var_15) && isDefined(var_15.player) && var_15.player != var_0) {
      if(var_15.player.ref_12ca1 > 0) {
        var_15.player.ref_12ca1 = int(max(0, var_15.player.ref_12ca1 - var_9));

        if(!isDefined(var_15.player.ref_12ca3)) {
          var_15.player.ref_12ca3 = 0;
        }

        var_15.player.ref_12ca3 += var_9;
        var_13 = 1;
      }
    }
  }

  if(var_13) {
    if(istrue(var_0.alternate_breach_anim_func)) {
      var_0.ally_spawns += var_9;
      return;
    }

    var_0.alternate_breach_anim_func = 1;
    var_0.ally_spawns = var_9;
    thread end_reach_wind_room();
    return;
  }
}

function end_reach_wind_room() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  wait 0.5;

  if(isDefined(self.ally_spawns) && self.ally_spawns > 0) {
    brrebirth_setrebirthrespawntimerdeltavalue(self.ally_spawns);
  }

  self.ally_spawns = undefined;
  self.alternate_breach_anim_func = 0;
}

function end_unlock_silo() {
  if(!istrue(level.disable_super_in_turret.ref_12ca4)) {
    return;
  }

  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("squad_wiped");
  var_0 endon("force_stop_respawn");

  if(!istrue(level.disable_super_in_turret.useneverendingresurgence)) {
    thread empty_vo_func();
  }

  thread enable_motionblur();

  if(isDefined(level.disable_super_in_turret.ref_12a7b)) {
    var_0.ref_12ca1 = level.disable_super_in_turret.ref_12a7b;
  } else {
    var_1 = int(min(level.br_circle.circleindex, level.disable_super_in_turret.ref_12ca1.size - 1));
    var_1 = int(max(var_1, 0));
    var_0.ref_12ca1 = level.disable_super_in_turret.ref_12ca1[var_1];

    if(istrue(level.disable_super_in_turret.ref_14094)) {
      var_0.ref_12ca1 = level.disable_super_in_turret.ref_1452f;
    }
  }

  if(!isDefined(var_0.ref_12ca1)) {
    var_2 = "Respawn delay was not properly set. scr_br_rebirth_respawn_delay or scr_br_rebirth_respawn_delay_circle should have been set. Defaulting to 30 'level.br_circle.circleIndex' is set to " + scripts\engine\utility::ter_op(isDefined(level.br_circle.circleindex), level.br_circle.circleindex, "undefined") + " " + "'level.brGametype.rebirthDelayOverride' is set to " + scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.ref_12a7b), level.disable_super_in_turret.ref_12a7b, "undefined");
    var_3 = "\n";
    var_4 = getarraykeys(game["flags"]);

    foreach(var_6 in var_4) {
      var_3 += var_6 + " -> " + game["flags"][var_6] + "\n";
    }

    var_2 += var_3;
    scripts\mp\utility\script::laststand_dogtags(var_2);
    var_0.ref_12ca1 = 30;
  }

  if(getdvarint("rebirth_no_respawn_bug_check", 1) == 1 && isalive(var_0)) {
    scripts\mp\utility\script::laststand_dogtags("Alive player added to rebirth countdown. IsAlive: " + isalive(var_0) + ". Sessionstate: " + var_0.sessionstate);
    waitframe();
    scripts\mp\utility\script::laststand_dogtags("Alive player added to rebirth countdown - after waitframe. IsAlive: " + isalive(var_0) + ". Sessionstate: " + var_0.sessionstate);
  }

  brrebirth_resetrebirthrespawntimervengeanceflag(var_0);
  brrebirth_showrebirthrespawntimer(var_0);
  brrebirth_setrebirthrespawntimervalue(var_0, var_0.ref_12ca1);
  var_0.ref_12ca3 = 0;

  while(var_0.ref_12ca1 > 0) {
    if(isalive(var_0)) {
      var_0.ref_12ca1 = 0;
    } else {
      brrebirth_setrebirthrespawntimervalue(var_0, var_0.ref_12ca1);
    }

    brrebirth_setrebirthrespawntimerdeltavalue(var_0, var_0.ref_12ca3);
    var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", var_0.ref_12ca1);
    var_0.ref_12ca3 = 0;
    wait 1;
    var_0.ref_12ca1--;
  }

  brrebirth_hiderebirthrespawntimer(var_0);
  brrebirth_setrebirthrespawntimerdeltavalue(var_0, 0);
  var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);

  if(!isalive(var_0)) {
    if(isDefined(var_0.team)) {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_0.team, var_0, 12, 1);

      foreach(var_9 in level.teamdata[var_0.team]["alivePlayers"]) {
        if(!istrue(var_9.showteamtanks)) {
          thread enable_nvgs();
        }
      }
    }

    thread enable_oob_immunity_on_riders(var_0, 0);
    return;
  }
}

function enable_nvgs() {
  level endon("game_ended");
  self.showteamtanks = 1;
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("rebirth_teammate_respawn", self);
  wait 5;
  self.showteamtanks = undefined;
}

function enable_motionblur() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  empdrone_gameendedthink();
}

function empdrone_gameendedthink() {
  if(istrue(level.disable_super_in_turret.fly_to_laser_trap_start_pos)) {
    return;
  }

  var_0 = self;

  if(!istrue(level.disable_super_in_turret.ref_1428b)) {
    var_0 = spawnStruct();
    var_0.player = self;
    var_0.viphud_hidefromplayer = self.lastkilledby;
  }

  var_1 = [];
  var_2 = level.teamdata[self.team]["deadPlayers"];

  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_1 = var_4.player.name;
    }
  }

  level.teamdata[self.team]["deadPlayers"] = scripts\engine\utility::array_add(level.teamdata[self.team]["deadPlayers"], var_0);
}

function end_jugg_maze() {
  if(istrue(level.disable_super_in_turret.fly_to_laser_trap_start_pos)) {
    return;
  }

  var_0 = level.teamdata[self.team]["deadPlayers"];

  if(istrue(level.disable_super_in_turret.ref_1428b)) {
    var_0 = scripts\engine\utility::array_remove(var_0, self);
  } else {
    var_1 = [];

    foreach(var_3 in var_0) {
      if(isDefined(var_3) && var_3.player != self) {
        var_1 = var_3;
      }
    }

    var_0 = var_1;
  }

  level.teamdata[self.team]["deadPlayers"] = var_0;
}

function enable_oob_immunity_on_riders(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 notify("doingRespawn");

  if(istrue(var_2.respawningfromtoken)) {
    return;
  }

  var_2.respawningfromtoken = 1;

  if(istrue(level.disable_super_in_turret.ref_12c91)) {
    var_2 notify("started_spawnPlayer");
  }

  if(istrue(var_0)) {
    brrebirth_setrebirthrespawntimervengeanceflag(var_2);
    var_2 thread scripts\mp\events::killeventtextpopup("br_rebirth_vengeance", 0, 0);
    wait 1.5;
  }

  end_trans_1_obj(var_2, var_1);
  end_jugg_maze();
  var_2 scripts\mp\playerlogic::addtoalivecount("rebirth2");
  scripts\mp\gametypes\br::ref_13f21(var_2, "rebirth2");
  var_2 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  var_3 = 0;

  if(istrue(level.disable_super_in_turret.ref_12c92)) {
    var_3 = var_2 scripts\mp\gametypes\br_gulag::ref_126e8();
  }

  var_4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_5 = scripts\mp\gametypes\br_gulag::ref_125be(0, var_4);
  var_6 = scripts\mp\gametypes\br_gulag::ref_1263e(var_5);
  self.forcespawnorigin = var_6;

  if(var_3) {
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_7 = 1;
  var_2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  wait var_7;
  brrebirth_hiderebirthrespawntimer(var_2);
  var_2 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  var_2 scripts\mp\playerlogic::spawnplayer(undefined, 0);
  var_2 scripts\cp_mp\execution::_clearexecution();
  var_2 scripts\mp\gametypes\br_pickups::initplayer();
  var_2 scripts\mp\gametypes\br_spectate::ref_1252a();
  var_2.respawningfromtoken = undefined;
  brrebirth_resetrebirthrespawntimervengeanceflag(var_2);
  var_2 thread scripts\mp\gametypes\br_gulag::ref_13dcb(20);
  end_loop_emp_spark_vfx(var_2, var_5, var_6);
}

function end_silo_thrust() {
  wait 0.5;
  return true;
}

function end_loop_emp_spark_vfx(var_0, var_1) {
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  scripts\mp\gametypes\br::scriptednode(self);
  ref_12a7d();

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\gametypes\br_gulag::ref_125be();
  }

  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = var_2;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  scripts\mp\gametypes\br_gulag::set_scriptable_states();
  self setOrigin(var_4, 1);
  self setplayerangles(var_3);
  var_5 = spawn("script_model", var_4);
  var_5 setModel("tag_origin");
  var_5.angles = var_3;
  var_5 hide();
  var_5 showtoplayer(self);
  self playerlinktoabsolute(var_5, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var_5);
  waitframe();
  ref_1264e();

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\gametypes\br_public::ref_1252b();

  if(isDefined(var_1)) {
    var_5.origin = var_2;
  }

  var_5 playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("deaths_door_mp");

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  }

  self clearclienttriggeraudiozone(1);
  self playershow();
  ref_12677(1);
  var_6 = 0;

  if(isDefined(level.ref_121cc)) {
    var_6 = level.ref_121cc;
  }

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    thread scripts\cp_mp\parachute::startfreefall(var_6, 0, undefined, undefined, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  scripts\mp\gametypes\br_gulag::ref_12c7a();
  scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_quest_util::ref_12072();
  scripts\mp\gametypes\br_rewards::ref_12072();
  scripts\mp\gametypes\br_pickups::removerespawntoken();
  scripts\mp\gametypes\br_gametypes::ref_12e05("giveStartingPlunder");
  var_7 = level.ph_setfinalkillcamwinner > 0 && randomfloat(1) < level.ph_setfinalkillcamwinner;

  if(istrue(var_7) && isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.br_ammo_player_is_maxed_out)) {
    var_8 = 0;

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      var_8 = level.vehicle.instances["veh_a10fd"].size;
    }

    if(var_8 < level.disable_super_in_turret.botpickskinid) {
      thread ref_1268c(var_2);
      wait 1.5;
    }
  }

  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\gametypes\br_gulag::ref_12523();
  }

  waitframe();
  var_5 delete();

  if(istrue(level.ref_133ef)) {
    scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused(1);
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(!istrue(level.stage)) {
    thread scripts\mp\hud_message::showsplash("br_rebirth_redeploy", 20);
  }

  if(level.disable_super_in_turret.name == "olaride") {
    scripts\mp\hud_message::showsplash("br_olaride_objectiveReminder");
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("rebirth_redeploy", self);
}

function ref_1264e() {
  self notify("rebirthRespawn");
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);
}

function ref_12a7d() {
  if(isDefined(level.deletescriptableinstanceaftertime) || getdvarint("scr_br_fc_loadouts", 1) != 0) {
    self.set_shouldrespawn = 1;
    return;
  }
}

function ref_12677(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
    return;
  }

  self disableoffhandweapons();
  self disableusability();
}

function enable_spawner() {
  var_0 = level.deletescriptableinstanceaftertime;

  if(isDefined(level.ref_12a7d)) {
    var_1 = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var_2 = 0;

      if(isDefined(level.disable_super_in_turret.startingloadoutindex)) {
        var_2 = level.disable_super_in_turret.startingloadoutindex;
      }

      var_1 = min(level.br_circle.circleindex + var_2, level.ref_12a7d.size);
      var_1 = int(var_1);
    }

    if(isDefined(level.rebirthloadoutlist[var_1])) {
      var_0 = level.ref_12a7d[var_1][level.rebirthloadoutlist[var_1]];
    }
  }

  return var_0;
}

function enable_spawner_after_vehicle_death() {
  var_0 = 0;

  if(isDefined(level.ref_12a7d)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level.ref_12a7d.size - 1) {
        var_0 = 1;
      }
    }
  }

  return var_0;
}

function end_intro_obj() {
  if(istrue(level.disable_super_in_turret.loadoutrestore) && isDefined(self.ref_12eb0)) {
    scripts\mp\gametypes\br::ref_125fb();
  } else {
    level.deletescriptableinstanceaftertime = enable_spawner();
    var_0 = enable_spawner_after_vehicle_death();
    scripts\mp\gametypes\br::searchcircleorigin(0, 1, var_0);
  }

  if(isDefined(level.obit_activation) && level.obit_activation.ref_129da == 1) {
    scripts\mp\gametypes\br::disablearmorykiosk();
  }

  brrebirth_playerdroploadout();
  return false;
}

function brrebirth_playerdroploadout() {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(!isDefined(self.player_enable_invulnerability)) {
    self.player_enable_invulnerability = 1;
    var_0 = getdvarint("scr_br_give_self_revive_on_spawn", 1);

    if(var_0) {
      scripts\mp\gametypes\br_pickups::bdroppingshield(1);
    }

    var_1 = getdvarint("scr_br_give_specialist_on_spawn", 0);

    if(var_1) {
      scripts\mp\perks\perks::bears();
      return;
    }

    return;
  }

  var_0 = getdvarint("scr_br_give_self_revive_on_respawn", 0);

  if(var_0) {
    scripts\mp\gametypes\br_pickups::bdroppingshield(1);
  }

  var_1 = getdvarint("scr_br_give_specialist_on_spawn", 0);

  if(var_1) {
    scripts\mp\perks\perks::bears();
    return;
  }
}

function rocket_attack_min_cooldown() {
  return getdvarint("scr_br_rebirth_stop_respawn_circle_index", 3);
}

function circletimer(var_0) {
  if(istrue(level.disable_super_in_turret.ref_12ca4)) {
    var_1 = rocket_attack_min_cooldown();

    if(var_0 >= var_1) {
      loadoutcustomperkdiscount();
      return;
    }

    return;
  }
}

function loadoutcustomperkdiscount() {
  level.disable_super_in_turret.ref_12ca4 = 0;
  level.disable_super_in_turret.useneverendingresurgence = undefined;
  brrebirth_initdialogrespawndisabled();
  scripts\mp\gametypes\br_gametypes::ref_12e05("rebirthDisable");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_1, "respawn_disabled", undefined, 2);
    var_1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
    var_1 scripts\mp\gametypes\br_gametypes::ref_12e05("playerRebirthDisable");
  }

  scripts\mp\gametypes\br_public::brleaderdialog("rebirth_disabled");
}

function timeoutonabandoneddelay(var_0) {
  if(!isDefined(level.ref_12a7d)) {
    level.ref_12a7d = [];
  }

  var_1 = level.ref_12a7d.size;
  var_2 = tablelookupgetnumcols(var_0) - 1;
  level.ref_12a7d[var_1] = [];

  for(var_3 = 0; var_3 < var_2; var_3++) {
    level.ref_12a7d[var_1][level.ref_12a7d[var_1].size] = init_structs_mp_don3(var_3, var_0);
  }

  level.rebirthloadoutlist = [];

  foreach(var_6, var_5 in level.ref_12a7d) {
    if(isDefined(level.ref_12a7d[var_6]) && level.ref_12a7d[var_6].size > 0) {
      level.rebirthloadoutlist[var_6] = randomintrange(0, level.ref_12a7d[var_6].size);
    }
  }
}

function init_structs_mp_don3(var_0, var_1) {
  var_2["loadoutArchetype"] = "archetype_assault";
  var_2["loadoutPrimary"] = tablelookup(var_1, 0, "loadoutPrimary", var_0 + 1);
  var_2["loadoutPrimaryAttachment"] = tablelookup(var_1, 0, "loadoutPrimaryAttachment1", var_0 + 1);
  var_2["loadoutPrimaryAttachment2"] = tablelookup(var_1, 0, "loadoutPrimaryAttachment2", var_0 + 1);
  var_2["loadoutPrimaryAttachment3"] = tablelookup(var_1, 0, "loadoutPrimaryAttachment3", var_0 + 1);
  var_2["loadoutPrimaryAttachment4"] = tablelookup(var_1, 0, "loadoutPrimaryAttachment4", var_0 + 1);
  var_2["loadoutPrimaryAttachment5"] = tablelookup(var_1, 0, "loadoutPrimaryAttachment5", var_0 + 1);
  var_2["loadoutPrimaryCamo"] = tablelookup(var_1, 0, "loadoutPrimaryCamo", var_0 + 1);
  var_2["loadoutPrimaryReticle"] = tablelookup(var_1, 0, "loadoutPrimaryReticle", var_0 + 1);
  var_2["loadoutSecondary"] = tablelookup(var_1, 0, "loadoutSecondary", var_0 + 1);
  var_2["loadoutSecondaryAttachment"] = tablelookup(var_1, 0, "loadoutSecondaryAttachment1", var_0 + 1);
  var_2["loadoutSecondaryAttachment2"] = tablelookup(var_1, 0, "loadoutSecondaryAttachment2", var_0 + 1);
  var_2["loadoutSecondaryAttachment3"] = tablelookup(var_1, 0, "loadoutSecondaryAttachment3", var_0 + 1);
  var_2["loadoutSecondaryAttachment4"] = tablelookup(var_1, 0, "loadoutSecondaryAttachment4", var_0 + 1);
  var_2["loadoutSecondaryAttachment5"] = tablelookup(var_1, 0, "loadoutSecondaryAttachment5", var_0 + 1);
  var_2["loadoutSecondaryCamo"] = tablelookup(var_1, 0, "loadoutSecondaryCamo", var_0 + 1);
  var_2["loadoutSecondaryReticle"] = tablelookup(var_1, 0, "loadoutSecondaryReticle", var_0 + 1);
  var_2["loadoutMeleeSlot"] = "none";
  var_2["loadoutEquipmentPrimary"] = tablelookup(var_1, 0, "loadoutEquipmentPrimary", var_0 + 1);
  var_2["loadoutEquipmentSecondary"] = tablelookup(var_1, 0, "loadoutEquipmentSecondary", var_0 + 1);
  var_2["loadoutStreakType"] = "assault";
  var_2["loadoutKillstreak1"] = "none";
  var_2["loadoutKillstreak2"] = "none";
  var_2["loadoutKillstreak3"] = "none";
  var_2["loadoutSuper"] = "super_br_extract";
  var_2["loadoutPerks"] = [tablelookup(var_1, 0, "loadoutPerk1", var_0 + 1), tablelookup(var_1, 0, "loadoutPerk2", var_0 + 1), tablelookup(var_1, 0, "loadoutPerk3", var_0 + 1), tablelookup(var_1, 0, "loadoutExtraPerk1", var_0 + 1), tablelookup(var_1, 0, "loadoutExtraPerk2", var_0 + 1), tablelookup(var_1, 0, "loadoutExtraPerk3", var_0 + 1)];
  var_2["loadoutGesture"] = "playerData";
  var_2["tableColumn"] = var_0;
  return var_2;
}

function tomastrike_findoptimallaunchpos() {
  if(!istrue(level.disable_super_in_turret.ref_14094)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_1452e)) {
    level.disable_super_in_turret.ref_1452e = [60, 30];
  }

  thread ref_14013();
}

function ref_14013() {
  level endon("game_ended");
  var_0 = 0;
  level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[var_0];
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level waittill("infils_ready");

  while(level.disable_super_in_turret.ref_12ca4) {
    while(level.disable_super_in_turret.ref_1452f > 0) {
      wait 1;
      level.disable_super_in_turret.ref_1452f--;
    }

    wait 1;
    var_0 = int(min(var_0 + 1, level.disable_super_in_turret.ref_1452e.size - 1));
    level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[var_0];
  }
}

function end_breach_fx_structs() {
  self endon("death_or_disconnect");
  self endon("rebirth_remove_spawn_protection");
  self.ref_12a78 = 1;

  while(!self isonground()) {
    waitframe();
  }

  self.ref_12a78 = 0;
  self notify("rebirth_remove_spawn_protection");
}

function enablesplitscreen() {
  self endon("death_or_disconnect");
  self endon("rebirth_remove_launcher_protection");
  self.ref_12a75 = 1;

  while(!self isonground()) {
    waitframe();
  }

  self.ref_12a75 = 0;
  self notify("rebirth_remove_launcher_protection");
}

function end_chopper_boss() {
  self endon("death_or_disconnect");
  self endon("rebirth_remove_spawn_protection");
  self.ref_12a78 = 1;
  self waittill("weapon_fired");
  self.ref_12a78 = 0;
  self notify("rebirth_remove_spawn_protection");
}

function end_flares(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(level.ref_12a78) {
    if(isDefined(var_1.ref_12a78) && var_1.ref_12a78 == 1) {
      var_3 *= level.ref_12a79;
    }

    if(isDefined(var_2) && isDefined(var_2.ref_12a75) && var_2.ref_12a75 == 1) {
      switch (var_4) {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE_SPLASH":
          var_3 *= level.ref_12a77;
          break;
      }
    }
  }

  var_3 = scripts\mp\gametypes\br::brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_3;
}

function enable_leaderboard() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function emp_target_monitor() {
  thread enablefeature();
}

function enablefeature() {
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

function end_nuke_vault() {
  var_0 = -15;
  var_1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player(1);
  var_2 = max(0, var_1 + var_0);
  var_3 = getdvarfloat("scr_br_dropbag_delay", var_2);
  scripts\mp\gametypes\br_gametypes::ref_12b10("dropBagDelay", var_3);
}

function ref_12181() {
  var_0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var_0;
}

function ref_1268c(var_0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    return;
  }

  var_1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var_1])) {
    var_1 = level.br_circle.circleindex;
  }

  var_2 = vectortoyaw(level.br_level.default_class_chosen[var_1] - var_0);
  var_3 = spawnStruct();
  var_3.origin = (var_0[0], var_0[1], var_0[2] + 4000);
  var_3.angles = (0, var_2, 0);
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();
  var_5 = "veh_a10fd";

  if(randomfloat(1) > level.disable_super_in_turret.br_ammo_player_is_maxed_out) {
    var_5 = "veh_bt";
  }

  var_3.targetname = var_5;

  switch (var_5) {
    case "veh_bt":
      var_3.modelname = "veh_s4_mil_air_bomber_wz";
      var_3.vehicletype = "bt_mp";
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_3, var_4);
      break;
    case "veh_a10fd":
      var_4.modelname = "veh_s4_mil_air_dalpha_wz";
      var_4.vehicletype = "a10_warthog_fd";
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_4, var_5);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_6, "pilot", self);
}

function brrebirth_initneverendingresurgence() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("isTeamEliminated", &brrebirth_isteameliminated);
  level.disable_super_in_turret.useneverendingresurgence = 1;
  level.supportnovalidspectateplayer = 1;
}

function brrebirth_isteameliminated(var_0) {
  return !istrue(level.disable_super_in_turret.useneverendingresurgence);
}