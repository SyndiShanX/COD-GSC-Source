/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_rebirth_reverse.gsc
****************************************************************/

function init() {
  thread enabledfeatures();
  thread enabledskipdeathshield();
  thread enable_traversals_for_bombers();
  thread enabledbasejumping();
  setdvarifuninitialized("scr_br_rebirth_circle_setting", 0);
  setDvar("scr_br_project_kick", 1500);
  var_0 = getDvar("scr_br_gametype");

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter()) {
    timeoutonabandoneddelay("mp/classtable_br_rebirth_ww2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2_ww2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3_ww2.csv");
  } else if(var_0 == "rebirth_dbd_reverse") {
    timeoutonabandoneddelay("mp/classtable_br_rebirth_dbd.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2_dbd.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3_dbd.csv");
  } else {
    timeoutonabandoneddelay("mp/classtable_br_rebirth.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle2.csv");
    timeoutonabandoneddelay("mp/classtable_br_rebirth_circle3.csv");
  }

  level.disable_super_in_turret.ref_140A3 = getdvarint("scr_br_use_tracked_teams", 1);
  level.disable_super_in_turret.ref_140A5 = getdvarint("scr_br_use_vengeance", 1);
  level.disable_super_in_turret.ref_1428B = getdvarint("scr_br_vengeance_use_any_kill", 0);
  level.disable_super_in_turret.ref_140A6 = getdvarint("scr_br_use_vengeance_decrease_respawn_timer", 1);
  level.disable_super_in_turret.ref_14094 = getdvarint("scr_br_use_respawn_waves", 0);
  level.disable_super_in_turret.ref_1408D = getdvarint("scr_br_use_points_to_reduce_respawn_time", 1);
  level.ref_12CA7 = getdvarint("scr_bmo_respawnHeightOverride", 7500);
  level.disable_super_in_turret.ref_12C92 = getdvarint("scr_br_rebirth_respawn_should_wait_prestreaming_end", 0);
  level.disable_super_in_turret.ref_12C91 = getdvarint("scr_br_rebirth_respawn_should_notify_started_spawn", 1);
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
  scripts\mp\gametypes\br_gametypes::ref_12B11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12B11("mayConsiderPlayerDead", &empty_function);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerKilledSpawn", &brrebirth_playerkilledspawn);
  scripts\mp\gametypes\br_gametypes::ref_12B11("markPlayerAsEliminatedOnKilled", &end_escape_silo);
  scripts\mp\gametypes\br_gametypes::ref_12B11("triggerRespawnOverlay", &end_silo_thrust);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerNakedDropLoadout", &end_intro_obj);
  scripts\mp\gametypes\br_gametypes::ref_12B11("getDefaultLoadout", &enable_spawner);
  scripts\mp\gametypes\br_gametypes::ref_12B11("kioskRevivePlayer", &enablejuggernautcrateobjective);
  scripts\mp\gametypes\br_gametypes::ref_12B11("assignLastStandAttacker", &empdrone_killstreaktargetthink);

  if(!istrue(level.tryupdategenericprogress)) {
    scripts\mp\gametypes\br_gametypes::ref_12B11("onPlayerKilled", &end_game_tutorial_func);
  }

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) != 0) {
    scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &enable_leaderboard);
    scripts\mp\gametypes\br_gametypes::ref_12B11("addToC130Infil", &emp_target_monitor);
    thread end_nuke_vault();
  }

  waittillframeend();

  if(level.disable_super_in_turret.ref_1408D) {
    level.ref_12073 = &end_game_win;
  }

  level.ontimelimit = &end_gates;
  enable_keypad_interaction();
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
  scripts\mp\gametypes\br_skydive_protection::init();
  tomastrike_findoptimallaunchpos();
  thread end_paratroopers_group();
  thread end_reach_exhaust_waste();
  thread end_reach_icbm_launch();
  thread end_origin_final();
  thread end_pipe_room();
  thread enabledminimapdisable();
  scripts\mp\rank::ref_12189("kill", 100);
  scripts\mp\rank::ref_12189("br_cacheOpen", 200);
}

function enable_traversals_for_bombers() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["match_start"] = "gametype_resurgence";
  game["dialog"]["match_desc"] = "gametype_desc_resurgence_solo";
  game["dialog"]["rebirth_redeploy"] = "rebirth_redeploy";
  game["dialog"]["rebirth_disabled"] = "rebirth_reinforcement_disabled";
  game["dialog"]["rebirth_ending"] = "rebirth_reinforcement_ending";
}

function enabledminimapdisable() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1.ref_12CA1 = 0;
    }
  }
}

function enable_keypad_interaction() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12C11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("me_electrical_box_street_01", 1);
}

function enabledbasejumping() {}

function end_paratroopers_group() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.disable_super_in_turret.ref_12CA4 = 1;
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

  foreach(var_8 in level.players) {
    var_8.ref_13C4B = [];
  }
}

function end_reach_icbm_launch() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1.ref_1443B = [];
  }
}

function end_gates() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function empty_function(var_0) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    if(istrue(level.disable_super_in_turret.ref_12CA4)) {
      if(!isDefined(var_0.ref_12CA1)) {
        var_0.ref_12CA1 = 0;
      }

      if(var_0.ref_12CA1 <= 0) {
        var_0.respawngranted = 1;
        return false;
      }
    }

    scripts\mp\gametypes\br::ref_11B15(var_0);
    brrebirth_hiderebirthrespawntimer(var_0);
    var_0 notify("squad_wiped");
  }

  return true;
}

function end_escape_silo() {
  var_0 = int(min(level.br_circle.circleindex, level.disable_super_in_turret.ref_12CA1.size - 1));
  var_1 = isDefined(self.ref_12CA1) && self.ref_12CA1 > 0 && self.ref_12CA1 < level.disable_super_in_turret.ref_12CA1[var_0];
  return scripts\mp\flags::gameflag("prematch_done") && (var_1 || !istrue(level.disable_super_in_turret.ref_12CA4));
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
    var_4 scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", var_4.endgame_finitewaves_music);
    end_health(var_4);
    var_5 = !isDefined(var_1) || var_4 != var_1;
    var_6 = var_2 && var_5;

    if(var_6) {
      var_4 thread scripts\mp\hud_message::showsplash("br_rebirth_first_revive");
    }
  }
}

function enablejuggernautcrateobjective(var_0, var_1) {
  var_2 = self;
  var_2 thread scripts\mp\gametypes\br_gulag::playergulagautowin(var_0, var_1);
  end_trans_1_obj(var_2, level.teamdata[var_2.team]["alivePlayers"], var_0);
}

function end_game_tutorial_func(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  ref_121E7(var_0);

  if(level.gameended) {
    return;
  }

  if(!isDefined(var_0.victim)) {
    return;
  }

  thread end_freight_lift(var_0.victim);

  if(!isDefined(var_0.victim.ref_1443B)) {
    var_0.victim.ref_1443B = [];
  }

  if(!scripts\engine\utility::array_contains(var_0.victim.ref_1443B, var_0.attacker)) {
    scripts\engine\utility::array_add(var_0.victim.ref_1443B, var_0.attacker);
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || var_0.attacker == var_0.victim) {
    return;
  }

  thread endcameradebug_think(var_0.attacker);
  thread endcameraorigins(var_0.attacker);
  thread endcameraangles(var_0.attacker);
}

function endcameraangles(var_0) {
  level endon("game_ended");

  if(!level.disable_super_in_turret.ref_140A5) {
    return;
  }

  if(!istrue(level.disable_super_in_turret.ref_12CA4)) {
    return;
  }

  empendearly(var_0);
}

function empendearly(var_0) {
  if(self.ref_12CA1 <= 0) {
    return;
  }

  if(!isDefined(self.ref_1443B)) {
    self.ref_1443B = [];
  }

  if(isDefined(self.ref_1443B) && scripts\engine\utility::array_contains(self.ref_1443B, var_0)) {
    if(istrue(level.disable_super_in_turret.ref_140A6)) {
      self.ref_12CA1 -= getdvarint("scr_br_vengeance_decrease_respawn_delay", 5);
      brrebirth_setrebirthrespawntimervengeanceflag();
      wait 1;
      brrebirth_resetrebirthrespawntimervengeanceflag();
    }

    scripts\engine\utility::array_remove(self.ref_1443B, var_0);
    thread scripts\mp\events::killeventtextpopup("br_rebirth_vengeance", 0, 0);
    return;
  }
}

function endcameraorigins(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("disconnect");
  var_0 endon("squad_wiped");

  if(!level.disable_super_in_turret.ref_140A3) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_0 waittill("respawn_done");
  end_silo_jump(self.team, var_0.team);
}

function endcameradebug_think(var_0) {
  var_1 = self;

  if(istrue(var_0.delay_enter_combat_after_investigating_grenade)) {
    var_1 thread scripts\mp\events::killeventtextpopup("enemy_wiped", 0);
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("enemy_wiped", var_1.ref_145D0);
    thread endac130infilanimsinternal(var_1);
    return;
  }
}

function endac130infilanimsinternal(var_0) {
  var_1 = scripts\mp\gametypes\br::brchooselaststandweapon();
  scripts\mp\gametypes\br::ref_13AD0(var_0, self, var_1);
  var_2 = [];

  if(!isDefined(var_2[self.team])) {
    var_2[self.team] = 1;
    self playsoundtoteam("ui_team_wipe_splash", self.team);
  }
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
    if(!isDefined(self.ref_13C4B)) {
      self.ref_13C4B = [];
    }

    var_1 = self.ref_13C4B;
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
    self.ref_13C4B[var_2] = var_5;
    var_4 = [self];
  }

  var_7 = getteamindex(var_1);
  ref_14029(var_4, var_7, var_2);
  var_8 = getdvarfloat("scr_br_tracked_teams_clear_delay", 2.5);
  wait(var_8);
  var_4 = scripts\engine\utility::array_removeundefined(var_4);
  ref_14029(var_4, 0, var_2);
}

function end_origin_final() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

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
  level.disable_super_in_turret.ref_12CA1 = [];
  level.disable_super_in_turret.ref_14093 = getdvarint("scr_br_use_respawn_delay_per_circle", 1);

  if(level.disable_super_in_turret.ref_14093) {
    var_0 = rocket_attack_min_cooldown();

    for(var_1 = 0; var_1 < var_0; var_1++) {
      level.disable_super_in_turret.ref_12CA1[var_1] = getdvarint("scr_br_rebirth_respawn_delay_circle" + var_1 + 1, 30);
    }

    return;
  }

  level.disable_super_in_turret.ref_12CA1[0] = getdvarint("scr_br_rebirth_respawn_delay", 30);
}

function brrebirth_hiderebirthrespawntimer() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_1 = var_0 &~16384;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_1);
}

function brrebirth_showrebirthrespawntimer() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_1 = var_0 | 16384;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_1);
}

function brrebirth_setrebirthrespawntimervengeanceflag() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_1 = var_0 | 32768;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_1);
}

function brrebirth_resetrebirthrespawntimervengeanceflag() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_1 = var_0 &~32768;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_1);
}

function brrebirth_setrebirthrespawntimervalue(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_2 = var_1 &~16383;
  var_3 = var_2 | var_0;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_3);
}

function brrebirth_setrebirthrespawntimerdeltavalue(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer_solo");
  var_2 = var_1 &~2147418112;
  var_3 = var_1 & 1073741824;

  if(var_3 != 0) {
    var_3 = 0;
  } else {
    var_3 = 1073741824;
  }

  var_4 = var_2 | var_0 << 16 | var_3;
  self setclientomnvar("ui_rebirthRespawnTimer_solo", var_4);
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

  if(!isDefined(var_0.gulaguses) || var_0.gulaguses == 0) {
    end_trans_1_obj(var_0, level.teamdata[var_0.team]["alivePlayers"]);
    var_0 scripts\mp\playerlogic::addtoalivecount();
    scripts\mp\gametypes\br::ref_13F21(var_0);
    scripts\mp\gametypes\br::dynamic_door(var_0);
    scripts\mp\gametypes\br_gulag::entergulag(var_0);
    self.waitingtospawn = 0;
    return;
  }
}

function ref_121E7(var_0) {
  if(!isDefined(var_0.victim) || !isDefined(var_0.attacker)) {
    return;
  }

  if(var_0.victim == var_0.attacker || !isPlayer(var_0.attacker)) {
    return;
  }

  var_1 = scripts\mp\utility\teams::getteamdata(var_0.victim.team, "aliveCount");

  if(var_1 == 0) {
    var_0.attacker scripts\cp\vehicles\vehicle_compass_cp::ref_12004("t_wipe");
    return;
  }
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

  if(!scripts\mp\flags::gameflag("prematch_done")) {
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

  if(isDefined(var_0.ref_12CA1) && var_0.ref_12CA1 > 0) {
    var_0.ref_12CA1 = int(max(0, var_0.ref_12CA1 - var_9));

    if(!isDefined(var_0.ref_12CA3)) {
      var_0.ref_12CA3 = 0;
    }

    var_0.ref_12CA3 += var_9;
    return;
  }
}

function endgame_camera() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("squad_wiped");
  var_0 endon("respawn_disabled");

  while(var_0.ref_12CA1 > 0) {
    if(var_0.ref_12CA1 <= 5) {
      var_0 playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", var_0);
    } else if(var_0.ref_12CA1 <= 10) {
      var_0 playsoundtoplayer("ui_mp_resurgence_timer_half_sec", var_0);
    } else if(var_0.ref_12CA1 % 4 == 2) {
      var_0 playsoundtoplayer("ui_mp_resurgence_timer", var_0);
    } else {
      var_0 playsoundtoplayer("ui_mp_resurgence_timer_tick", var_0);
    }

    brrebirth_setrebirthrespawntimervalue(var_0, var_0.ref_12CA1);
    brrebirth_setrebirthrespawntimerdeltavalue(var_0, var_0.ref_12CA3);
    var_0.ref_12CA3 = 0;
    wait 1;
    var_0.ref_12CA1--;
  }

  brrebirth_hiderebirthrespawntimer(var_0);
  var_0 thread scripts\mp\hud_message::showsplash("br_rebirth_respawn_active");
}

function end_wave_spawn_ahead_of_completion() {
  if(!istrue(level.disable_super_in_turret.ref_12CA4)) {
    return;
  }

  var_0 = self;
  var_0 endon("squad_wiped");
  var_0 endon("respawn_disabled");
  var_0 endon("disconnect");

  if(getdvarint("scr_br_rebirthDelayOverride", 0) != 0) {
    var_0.ref_12CA1 = getdvarint("scr_br_rebirthDelayOverride", 0);
  } else {
    var_1 = int(min(level.br_circle.circleindex, level.disable_super_in_turret.ref_12CA1.size - 1));
    var_0.ref_12CA1 = level.disable_super_in_turret.ref_12CA1[var_1];
  }

  self waittill("respawn_done");
  brrebirth_setrebirthrespawntimervalue(var_0, var_0.ref_12CA1);
  brrebirth_showrebirthrespawntimer(var_0);
  var_0.ref_12CA3 = 0;

  while(!self isonground()) {
    waitframe();
  }

  thread endgame_camera();
}

function brrebirth_playerkilledspawn(var_0, var_1) {
  if(!istrue(level.br_prematchstarted)) {
    return undefined;
  }

  var_2 = self;

  if(istrue(var_2.respawngranted)) {
    var_2.alreadyaddedtoalivecount = 1;
    thread enable_oob_immunity_on_riders();
    thread end_wave_spawn_ahead_of_completion();
  } else {
    var_0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, var_1);
  }

  var_2.respawngranted = undefined;
  return 1;
}

function enable_oob_immunity_on_riders() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("doingRespawn");

  if(istrue(level.disable_super_in_turret.ref_12C91)) {
    var_0 notify("started_spawnPlayer");
  }

  var_1 = 0;

  if(istrue(level.disable_super_in_turret.ref_12C92)) {
    var_1 = var_0 scripts\mp\gametypes\br_gulag::ref_126E8();
  }

  var_2 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_3 = scripts\mp\gametypes\br_gulag::ref_125BE(0, var_2);

  if(level.br_circle.circleindex < 2) {
    var_4 = getclosestpointonnavmesh(var_3.origin);
    var_5 = getdvarint("scr_br_rebirth_respawn_distance", 2500);

    if(distance2d(var_4, var_3.origin) > var_5) {
      var_6 = getrandomnavpoint(var_4, randomfloat(var_5));
      var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
    }
  }

  if(isDefined(self.lastdeathpos)) {
    var_5 = getdvarint("scr_br_rebirth_respawn_distance", 2500);
    var_7 = var_5 * var_5;

    if(distance2dsquared(self.lastdeathpos, var_3.origin) > var_7) {
      var_8 = var_3.origin - self.lastdeathpos;
      var_8 = vectorNormalize(var_8);
      var_8 = (var_8[0] * var_5, var_8[1] * var_5, var_8[2]);
      var_6 = (self.lastdeathpos[0] + var_8[0], self.lastdeathpos[1] + var_8[1], var_8[2]);
      var_6 = getclosestpointonnavmesh(var_6);
      var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
    }
  }

  if(!scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo(var_3.origin, var_2)) {
    var_9 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_10 = scripts\mp\gametypes\br_circle::getsafecircleradius();
    var_8 = var_3.origin - var_9;
    var_8 = vectorNormalize(var_8);
    var_8 = (var_8[0] * var_10, var_8[1] * var_10, var_8[2]);
    var_6 = var_9 + var_8;
    var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
  }

  var_11 = scripts\mp\gametypes\br_gulag::ref_1263E(var_3);
  self.forcespawnorigin = var_11;

  if(var_1) {
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_12 = 1;
  var_0 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  wait var_12;
  brrebirth_showrebirthrespawntimer(var_0);
  var_0 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  var_0 scripts\mp\playerlogic::spawnplayer(undefined, 0);
  var_0 scripts\cp_mp\execution::_clearexecution();
  var_0 scripts\mp\gametypes\br_pickups::initplayer();
  var_0 scripts\mp\gametypes\br_spectate::ref_1252A();
  var_0.respawningfromtoken = undefined;
  var_0 thread scripts\mp\gametypes\br_gulag::ref_13DCB(20);
  end_loop_emp_spark_vfx(var_0, var_3, var_11);
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
  ref_12A7D();

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\gametypes\br_gulag::ref_125BE();
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
  ref_1264E();

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ED();
  }

  scripts\mp\gametypes\br_public::ref_1252B();

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

  if(isDefined(level.ref_121CC)) {
    var_6 = level.ref_121CC;
  }

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    thread scripts\cp_mp\parachute::startfreefall(var_6, 0, undefined, undefined, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  scripts\mp\gametypes\br_gulag::ref_12C7A();
  scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_quest_util::ref_12072();
  scripts\mp\gametypes\br_rewards::ref_12072();
  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\gametypes\br_gulag::ref_12523();
  }

  waitframe();
  var_5 delete();

  if(istrue(level.ref_133EF)) {
    scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused(1);
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(istrue(level.disable_super_in_turret.ref_12CA4)) {
    if(!istrue(level.stage)) {
      thread scripts\mp\hud_message::showsplash("br_rebirth_redeploy", 20);
    }

    if(!istrue(self.player_deposited_heli)) {
      thread scripts\mp\hud_message::showsplash("br_rebirth_survive_countdown");
      self.player_deposited_heli = 1;
    }
  } else {
    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(self, "respawn_disabled", undefined, 2);
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("rebirth_redeploy", self);
  self notify("respawn_done");
}

function ref_1264E() {
  self notify("rebirthRespawn");
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);
}

function ref_12A7D() {
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

  if(isDefined(level.ref_12A7D)) {
    var_1 = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var_1 = min(level.br_circle.circleindex, level.ref_12A7D.size);
      var_1 = int(var_1);
    }

    if(isDefined(level.rebirthloadoutlist[var_1])) {
      var_0 = level.ref_12A7D[var_1][level.rebirthloadoutlist[var_1]];
    }
  }

  return var_0;
}

function enable_spawner_after_vehicle_death() {
  var_0 = 0;

  if(isDefined(level.ref_12A7D)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level.ref_12A7D.size - 1) {
        var_0 = 1;
      }
    }
  }

  return var_0;
}

function end_intro_obj() {
  level.deletescriptableinstanceaftertime = enable_spawner();
  var_0 = enable_spawner_after_vehicle_death();
  scripts\mp\gametypes\br::searchcircleorigin(0, 1, var_0);

  if(isDefined(level.obit_activation) && level.obit_activation.ref_129DA == 1) {
    scripts\mp\gametypes\br::disablearmorykiosk();
  }

  if(!isDefined(self.player_enable_invulnerability)) {
    self.player_enable_invulnerability = 1;
    var_1 = getdvarint("scr_br_give_self_revive_on_spawn", 1);

    if(var_1) {
      scripts\mp\gametypes\br_pickups::bdroppingshield(1);
    }
  } else {
    var_1 = getdvarint("scr_br_give_self_revive_on_respawn", 0);

    if(var_1) {
      scripts\mp\gametypes\br_pickups::bdroppingshield(1);
    }
  }

  return false;
}

function empdrone_killstreaktargetthink(var_0) {
  var_1 = self;

  if(!isDefined(var_1.ref_12CA1)) {
    var_1.ref_12CA1 = 0;
  }

  if(var_1.ref_12CA1 > 0 || !istrue(level.disable_super_in_turret.ref_12CA4)) {
    var_0 = var_1.watch_for_attack;
    return;
  }
}

function rocket_attack_min_cooldown() {
  return getdvarint("scr_br_rebirth_stop_respawn_circle_index", 3);
}

function circletimer(var_0) {
  if(istrue(level.disable_super_in_turret.ref_12CA4)) {
    var_1 = rocket_attack_min_cooldown();

    if(var_0 >= var_1) {
      loadoutcustomperkdiscount();
      return;
    }

    return;
  }
}

function loadoutcustomperkdiscount() {
  level.disable_super_in_turret.ref_12CA4 = 0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_1, "respawn_disabled", undefined, 2);
    var_1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
    var_1 notify("respawn_disabled");
  }

  scripts\mp\gametypes\br_public::brleaderdialog("rebirth_disabled");
}

function timeoutonabandoneddelay(var_0) {
  if(!isDefined(level.ref_12A7D)) {
    level.ref_12A7D = [];
  }

  var_1 = level.ref_12A7D.size;
  var_2 = tablelookupgetnumcols(var_0) - 1;
  level.ref_12A7D[var_1] = [];

  for(var_3 = 0; var_3 < var_2; var_3++) {
    level.ref_12A7D[var_1][level.ref_12A7D[var_1].size] = init_structs_mp_don3(var_3, var_0);
  }

  level.rebirthloadoutlist = [];

  foreach(var_6, var_5 in level.ref_12A7D) {
    if(isDefined(level.ref_12A7D[var_6]) && level.ref_12A7D[var_6].size > 0) {
      level.rebirthloadoutlist[var_6] = randomintrange(0, level.ref_12A7D[var_6].size);
    }
  }
}

function init_structs_mp_don3(var_0, var_1) {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function tomastrike_findoptimallaunchpos() {
  if(!istrue(level.disable_super_in_turret.ref_14094)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_1452E)) {
    level.disable_super_in_turret.ref_1452E = [60, 30];
  }

  thread ref_14013();
}

function ref_14013() {
  level endon("game_ended");
  var_0 = 0;
  level.disable_super_in_turret.ref_1452F = level.disable_super_in_turret.ref_1452E[var_0];
  scripts\mp\flags::gameflagwait("prematch_done");
  level waittill("infils_ready");

  while(level.disable_super_in_turret.ref_12CA4) {
    while(level.disable_super_in_turret.ref_1452F > 0) {
      wait 1;
      level.disable_super_in_turret.ref_1452F--;
    }

    wait 1;
    var_0 = int(min(var_0 + 1, level.disable_super_in_turret.ref_1452E.size - 1));
    level.disable_super_in_turret.ref_1452F = level.disable_super_in_turret.ref_1452E[var_0];
  }
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
  scripts\mp\gametypes\br_gametypes::ref_12B10("dropBagDelay", var_3);
}