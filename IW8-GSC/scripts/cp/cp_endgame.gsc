/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_endgame.gsc
***********************************************/

function init() {
  thread ref_1252d();
  register_end_game_string_index();
}

function ref_1252d() {
  for(;;) {
    level waittill("connected", var_0);

    if(isDefined(level.ref_127ff)) {
      var_0 setclientomnvar("post_game_state", level.ref_127ff);

      if(isDefined(var_0.pers["team"]) && level.winner == var_0.pers["team"]) {
        var_1 = get_end_game_string_index("win");
      } else {
        var_1 = get_end_game_string_index("fail");
      }

      var_1 setclientomnvar("ui_round_end_title", var_1);
    }
  }
}

function ref_131ac(var_0) {
  setomnvarforallclients("post_game_state", var_0);
  level.ref_127ff = var_0;
}

function cargo_truck_mg_explode(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
    return;
  }
}

function endgame(var_0, var_1) {
  if(gamealreadyended()) {
    return;
  }

  foreach(var_4, var_3 in level.players) {
    if(istrue(var_3 isparachuting()) || istrue(var_3 isskydiving())) {
      var_3 skydive_interrupt();
    }

    thread scripts\cp\cp_laststand::hide_all_revive_icons(var_3);
  }

  if(isDefined(level.intel_headicons)) {
    foreach(var_6 in level.intel_headicons) {
      level.intel_headicons = scripts\engine\utility::array_remove(level.intel_headicons, var_6);
      setheadiconimage(var_6);
    }
  }

  if(var_1 == 3) {
    foreach(var_3 in level.players) {
      if(isDefined(level.gametype) && level.gametype == "cp_wave_sv") {
        var_9 = game["music"]["spawn_player"].size;
        var_10 = randomint(var_9);
        var_3 setplayermusicstate(game["music"]["cp_roundloss"][var_10]);
      } else {
        var_3 setsoundsubmix("mp_matchend_music", 2);
        var_3 setplayermusicstate("mus_cp_defeat");
      }

      thread deathfx();
    }
  }

  setDvar("scr_init_cs_files", "");
  setnojiptime(1);
  markgameended();
  level notify("game_ended", var_0);
  freezeallplayers(1, "NSSLSNKPN", 1);
  var_12 = tolower(getDvar("mapname"));

  foreach(var_3 in level.players) {
    if(isDefined(level.gametype)) {
      var_3 setplayerdata("common", "round", "gameMode", level.gametype);
      var_3 setplayerdata("common", "round", "map", var_12);
    }
  }

  if(var_1 == 3) {
    wait 1;
  }

  var_15 = 0;
  var_16 = "";

  if(!scripts\cp\utility::tryingtoleave()) {
    var_16 = "FAIL";

    switch (var_1) {
      case 1:
        var_16 = "SUCCESS";
        scripts\cp\drone\emp_drone::rankedmatchupdates("allies");
        break;
      case 4:
        var_16 = "HOST QUIT";
        scripts\cp\drone\emp_drone::rankedmatchupdates("axis");
        break;
      default:
        var_16 = "FAIL";
        scripts\cp\drone\emp_drone::rankedmatchupdates("axis");
        break;
    }

    if(isDefined(level.pre_map_restart_func)) {
      [[level.pre_map_restart_func]](var_16);
    }

    scripts\cp\cp_analytics::ref_119b8(var_16);
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var_3 in level.players) {
    if(scripts\cp\utility::matchmakinggame() && (var_16 == "SUCCESS" || var_16 == "FAIL")) {
      var_3 scripts\cp_mp\utility\game_utility::stopkeyearning(var_16);
    }

    var_18 = get_current_zone(var_3);
    var_19 = var_3 getplayerdata("cp", "alienSession", "kills");
    var_20 = var_3 getplayerdata("cp", "alienSession", "downed");
    var_21 = var_3 getplayerdata("cp", "alienSession", "revives");
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Kills", "count", var_19, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Last Stands", "count", var_20, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Revives", "count", var_21, "description", ""]);
    cargo_truck_mg_explode(var_3);
    setclientmatchdata("player", var_3.clientmatchdataid, "xuidHigh", var_3 getxuidhigh());
    setclientmatchdata("player", var_3.clientmatchdataid, "xuidLow", var_3 getxuidlow());
    setclientmatchdata("player", var_3.clientmatchdataid, "zombie_death", var_19);
    setclientmatchdata("player", var_3.clientmatchdataid, "dropped_to_last_stand", var_20);
    setclientmatchdata("player", var_3.clientmatchdataid, "revived_another_player", var_21);

    if(isDefined(var_3.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var_22 = var_3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("player", var_3.clientmatchdataid, "rank", var_22);
    }

    if(isDefined(var_3.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var_23 = var_3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("player", var_3.clientmatchdataid, "prestige", var_23);
    }

    if(var_3 isps4player()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "ps4");
    } else if(var_3 isxb3player()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "xb3");
    } else if(var_3 ispcplayer()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "none");
    }

    var_3 scripts\cp\agents\agents::logplayerdata(var_16);
    LOC_00000581:
  }

  level.ingraceperiod = 0;
  setomnvar("allow_server_pause", 0);
  waitframe();

  if(isDefined(level.timerstarttime)) {
    level.starttime = level.timerstarttime;
  }

  level.time_survived = int((gettime() - level.starttime) / 1000);

  if(isDefined(level.eogscoringtable)) {}

  setomnvar("zm_time_survived", level.time_survived);
  ref_131ac(1);
  setDvar("SLLNLPRON", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("MPOKQNLPRM", 0);
  setDvar("scr_gameended", 1);
  setgameendtime(0);
  setslowmotion(1, 1, 0);

  foreach(var_3 in level.players) {
    cleanup_player_on_game_end(var_3);
  }

  level.bgameover = 1;

  foreach(var_28 in level.agentarray) {
    if(isDefined(var_28.isactive) && var_28.isactive) {
      var_28.ignoreall = 1;
      var_28 scripts\cp\utility::enable_alien_scripted();
    }
  }

  ref_131ac(0);
  level.winner = var_0;
  displaygameend(var_0, var_1);
  var_30 = should_load_new_map(var_1);

  if(isDefined(var_30)) {
    if(isDefined(level.load_new_map_func)) {
      [[level.load_new_map_func]](var_1);
    }

    load_new_map(var_30);
    return;
  } else if(players_want_to_restart(var_0, var_1)) {
    var_31 = get_end_game_string_index("restarting");

    foreach(var_3 in level.players) {
      var_3 setclientomnvar("ui_round_end_title", var_31);
    }

    wait 1;
    restart_map();
    return;
  } else {
    var_31 = get_end_game_string_index("exiting");

    foreach(var_13 in level.players) {
      var_13 setclientomnvar("ui_round_end_title", var_31);
    }
  }

  scripts\cp\cp_globallogic::ref_12c58();
  setDvar("scr_cp_map_part2", "");

  if(isDefined(level.pre_end_game_display_func)) {
    [[level.pre_end_game_display_func]]();
  }

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_13 in level.players) {
      var_13 setclientdvar("MQNNLTKNTS", 1);
    }
  }

  var_38 = get_end_condition(var_4);
  var_39 = get_play_time();
  scripts\cp\cp_analytics::endgame(var_38, var_39);
  reset_players_subparty_data();
  wait 1;
  var_40 = level.intermissionfunc;

  if(isDefined(level.custom_intermission_func)) {
    var_40 = level.custom_intermission_func;
  }

  wait 0.5;

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_13 in level.players) {
      var_13 thread[[var_40]](var_4);
    }
  }

  level notify("exitLevel_called");
  exitlevel(0);
}

function ref_13446() {
  thread ref_13445(level, "axis");
}

function ref_13445(var_0, var_1) {
  if(gamealreadyended()) {
    return;
  }

  if(var_1 == 3 || var_1 == 2) {
    foreach(var_3 in level.players) {
      var_4 = game["music"]["spawn_player"].size;
      var_5 = randomint(var_4);
      var_3 setplayermusicstate(game["music"]["cp_roundloss"][var_5]);
      var_3 clearclienttriggeraudiozone(0);
      var_3 setsoundsubmix("cp_matchend", 3);
      thread ref_1344a(var_3);

      if(istrue(var_3.musicplaying)) {
        var_3 playlocalsound("mp_jugg_mus_toggle_button");
        var_3 setscriptablepartstate("juggernaut", "neutral", 0);
      }
    }
  }

  if(var_1 == 1) {
    foreach(var_3 in level.players) {
      var_3 clearclienttriggeraudiozone(0);

      if(istrue(var_3.musicplaying)) {
        var_3 playlocalsound("mp_jugg_mus_toggle_button");
        var_3 setscriptablepartstate("juggernaut", "neutral", 0);
      }

      var_3 setplayermusicstate("mus_west_victory");
      var_3 setsoundsubmix("cp_matchend", 3);
    }
  }

  setDvar("scr_init_cs_files", "");
  setnojiptime(1);
  markgameended();
  level notify("game_ended", var_0);
  scripts\cp\cp_analytics::ref_119b8(var_1);
  freezeallplayers(1, "NSSLSNKPN", 1);
  var_9 = tolower(getDvar("mapname"));

  foreach(var_3 in level.players) {
    if(isDefined(level.gametype)) {
      var_3 setplayerdata("common", "round", "gameMode", level.gametype);
      var_3 setplayerdata("common", "round", "map", var_9);
    }
  }

  if(var_1 == 3) {
    wait 1;
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var_3 in level.players) {
    var_13 = get_current_zone(var_3);
    var_14 = var_3 getplayerdata("cp", "alienSession", "kills");
    var_15 = var_3 getplayerdata("cp", "alienSession", "downed");
    var_16 = var_3 getplayerdata("cp", "alienSession", "revives");
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Kills", "count", var_14, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Last Stands", "count", var_15, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var_3.name, "stat_type", "Revives", "count", var_16, "description", ""]);
    cargo_truck_mg_explode(var_3);

    if(isDefined(var_3.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var_17 = var_3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("player", var_3.clientmatchdataid, "rank", var_17);
    }

    if(isDefined(var_3.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var_18 = var_3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("player", var_3.clientmatchdataid, "prestige", var_18);
    }

    setclientmatchdata("player", var_3.clientmatchdataid, "xuidHigh", var_3 getxuidhigh());
    setclientmatchdata("player", var_3.clientmatchdataid, "xuidLow", var_3 getxuidlow());
    setclientmatchdata("player", var_3.clientmatchdataid, "zombie_death", var_14);
    setclientmatchdata("player", var_3.clientmatchdataid, "dropped_to_last_stand", var_15);
    setclientmatchdata("player", var_3.clientmatchdataid, "revived_another_player", var_16);

    if(var_3 isps4player()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "ps4");
    } else if(var_3 isxb3player()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "xb3");
    } else if(var_3 ispcplayer()) {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("player", var_3.clientmatchdataid, "platform", "none");
    }

    var_3 scripts\cp\agents\agents::logplayerdata(var_1);
  }

  level.ingraceperiod = 0;
  waitframe();

  if(level.autoassignlowteamconsistent > -1) {
    level.time_survived = ref_13447();
  } else {
    level.time_survived = 0;
  }

  if(isDefined(level.eogscoringtable)) {}

  setomnvar("zm_time_survived", level.time_survived);
  var_20 = ref_13448(var_0);

  if(var_20.ref_1376c > 0) {
    setomnvar("ui_so_stars_given", var_20.ref_1376c);
  }

  setomnvar("ui_so_next_score", var_20.ref_11e84);
  setomnvar("ui_so_iwbest", var_20.vehicle_compass_cp_init);
  setDvar("SLLNLPRON", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("MPOKQNLPRM", 0);
  setgameendtime(0);

  if(getdvarint("LTSNLQNRKO")) {
    foreach(var_3 in level.players) {
      if(var_20.ref_1376c > 0) {
        ref_1344b(var_3, var_20.ref_1376c, level.time_survived);
        var_22 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
        var_23 = tablelookupbyrow("cp/cp_so_mission_table.csv", var_22, 0);
        var_3 reportchallengeuserevent("spec_ops_end", var_23, var_20.ref_1376c);
      }
    }
  }

  foreach(var_3 in level.players) {
    cleanup_player_on_game_end(var_3);
  }

  foreach(var_28 in level.agentarray) {
    if(isDefined(var_28.isactive) && var_28.isactive) {
      var_28.ignoreall = 1;
    }
  }

  ref_13444(var_0, var_1);
  var_30 = get_end_condition(var_1);
  var_31 = get_play_time();
  scripts\cp\cp_analytics::endgame(var_30, var_31);
  reset_players_subparty_data();

  if(ref_1344c()) {
    wait 0.1;

    foreach(var_3 in level.players) {
      var_3 clearsoundsubmix("cp_matchend", 2);
      var_3 clearsoundsubmix("mp_matchend_music", 2);
    }

    restart_map(0);
    return;
  }

  exitlevel(0);
}

function ref_13447() {
  var_0 = int(gettime() - level.autoassignlowteamconsistent);
  var_0 = int(var_0 / 1000) * 1000;
  return var_0;
}

function trygetlastpotentiallivingplayer() {
  return getdvarint("MRTSTTKTNL") && getdvarint("SNTTNKSRO");
}

function ref_13448(var_0) {
  var_1 = spawnStruct();
  var_1.ref_1376c = 0;
  var_1.ref_11e86 = 1;
  var_1.ref_11e84 = 0;
  var_2 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
  GscBinSkip1(0x45, 0, int(tablelookupbyrow("cp/cp_so_mission_table.csv", var_2, 6)));
}

function ref_1344b(var_0, var_1) {
  var_2 = self getplayerdata("cp", "ClassicSOStarCount", level.script);
  var_3 = self getplayerdata("cp", "ClassicSOBestScore", level.script);

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }

  if(var_0 > var_2) {
    self setplayerdata("cp", "ClassicSOStarCount", level.script, var_0);
  }

  if(var_1 < var_3 || var_3 == 0) {
    self setplayerdata("cp", "ClassicSOBestScore", level.script, var_1);
    return;
  }
}

function ref_1344a(var_0) {
  var_1 = var_0 == self.pers["team"];

  if(var_1 && !scripts\cp_mp\utility\player_utility::ref_12510()) {
    visionsetpain("damage_dead", 0.2);
    self painvisionon();
    thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 1, 18);
  }

  self setblurforplayer(10, 1);
}

function ref_13444(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame) || var_3.pers["team"] == "spectator") {
      continue;
    }

    thread ref_13449(var_3, var_0);
    var_3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }
}

function ref_13449(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var_2 = self.pers["team"];

  if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
    var_2 = "allies";
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var_0 == var_2) {
    var_3 = get_end_game_string_index("win");
  } else {
    var_3 = get_end_game_string_index("fail");
  }

  self setclientomnvar("ui_round_end_title", var_3);

  if(isDefined(var_2)) {
    self setclientomnvar("ui_round_end_reason", var_2);
  }

  ref_131ac(11);
}

function ref_1344c() {
  level.retry_total_votes = 0;
  level.retry_yes_votes = 0;
  var_0 = 35;
  var_1 = 0.1;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    setomnvar("ui_votesys_player" + var_2, 0);
  }

  var_3 = -1;
  var_4 = -1;
  var_5 = 1;

  foreach(var_7 in level.players) {
    thread ref_124e8();
  }

  while(level.retry_total_votes < level.players.size) {
    var_9 = int(var_0);

    if(var_9 >= 0 && var_9 != var_4) {
      var_4 = var_0;
      setomnvar("ui_votesys_time", var_9);
    }

    if(var_0 <= 0) {
      var_5 = 0;
      break;
    }

    wait var_1;
    var_0 -= var_1;
  }

  setomnvar("ui_votesys_time", 0);
  level notify("stop_player_retry_thread");

  if(!var_5) {
    return false;
  }

  if(level.retry_yes_votes == level.players.size) {
    return true;
  }

  return false;
}

function ref_124e8() {
  level endon("stop_player_retry_thread");
  self endon("disconnect");

  for(var_0 = -1;; var_0 = 0) {
    self waittill("luinotifyserver", var_1);

    if(var_1 == "retry_level") {
      if(var_0 < 0) {
        level.retry_total_votes += 1;
        level.retry_yes_votes += 1;
        var_0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      } else if(var_0 == 0) {
        level.retry_yes_votes += 1;
        var_0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      }

      continue;
    }

    if(var_1 == "quit_level") {
      if(var_0 < 0) {
        level.retry_total_votes += 1;
        continue;
      }

      if(var_0 == 1) {
        level.retry_yes_votes -= 0;
      }
    }
  }
}

function reset_players_subparty_data() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "CPSession", "subParty", -1);
  }
}

function get_current_zone(var_0) {
  var_1 = getEntArray("p_ent_zone", "targetname");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3)) {
      return var_3.script_noteworthy;
    }
  }
}

function check_best_score() {}

function vehomn_updateomnvarsperframe() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\cp_skits::movequestobjicon();
  }
}

function forceendgame() {
  thread endgame(level, "axis");
}

function markgameended() {
  game["state"] = "postgame";
  level.gameended = 1;
}

function gamealreadyended() {
  return game["state"] == "postgame" || level.gameended;
}

function freezeallplayers(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_4 in level.players) {
    thread freezeplayerforroundend(var_4);
    thread roundenddof(var_4);
    freegameplayhudelems(var_4);
    var_4 setclientdvars("LQKPQMPRQN", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      var_4 setclientdvars(var_1, var_2);
    }
  }

  foreach(var_7 in level.agentarray) {
    var_7 scripts\cp\utility::freezecontrolswrapper(1);
  }
}

function freezeplayerforroundend(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  wait var_0;
  scripts\cp\utility::freezecontrolswrapper(1);
}

function roundenddof(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

function get_play_time() {
  var_0 = 0;

  if(isDefined(level.starttime)) {
    var_0 = gettime() - level.starttime;
  }

  return var_0;
}

function freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] scripts\cp\utility::destroyelem();
      self.perkname[0] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] scripts\cp\utility::destroyelem();
      self.perkname[1] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] scripts\cp\utility::destroyelem();
      self.perkname[2] scripts\cp\utility::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.lowermessage scripts\cp\utility::destroyelem();
  self.lowertimer scripts\cp\utility::destroyelem();

  if(isDefined(self.proxbar)) {
    self.proxbar scripts\cp\utility::destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext scripts\cp\utility::destroyelem();
    return;
  }
}

function cleanup_player_on_game_end(var_0) {
  var_0 notify("select_mode");
  var_0 notify("reset_outcome");
  var_0.pers["stats"] = var_0.stats;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 scripts\cp\cp_persistence::set_player_currency(0);
  var_0 scripts\cp\utility::clearlowermessages();

  if(isDefined(var_0.pap)) {
    var_0.pap = [];
  }

  if(isDefined(var_0.powerupicons)) {
    var_0.powerupicons = [];
  }

  if(isDefined(var_0.consumables_equipped)) {
    var_0.consumables_equipped = [];
  }

  if(isDefined(var_0.powers)) {
    var_0.powers = [];
  }

  clear_powers_hud(var_0);
}

function should_load_new_map(var_0) {
  if((var_0 == 1 || var_0 == 2) && getDvar("NSQLTTMRMP") == "cp_jackal_ass") {
    return "cp_titan";
  }

  return undefined;
}

function load_new_map(var_0) {
  kill_em_all();
  level scripts\engine\utility::ref_143b9(15, "intermission_over");
  setDvar("NSQLTTMRMP", var_0);
  setDvar("NKTMKRMSKR", "aliens");
  var_1 = "map " + var_0;
}

function restart_map(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
    level.players[var_1] setclientomnvar("ui_match_in_progress", 0);
    level.players[var_1] setclientomnvar("ui_hide_hud", 1);
  }

  kill_em_all();
  setomnvar("allow_server_pause", 1);
  ref_131ac(0);
  setomnvarforallclients("reset_wave_loadout", 1);

  if(!isDefined(var_0)) {
    var_0 = 3;
  }

  for(var_1 = var_0; var_1 > 0; var_1--) {
    wait 1;
  }

  foreach(var_3 in level.players) {
    var_3 clearsoundsubmix("cp_matchend", 4);
    var_3 clearsoundsubmix("mp_matchend_music", 4);
  }

  map_restart(1);
}

function kill_em_all() {
  foreach(var_1 in level.characters) {
    if(isPlayer(var_1)) {
      continue;
    }

    var_1 dodamage(100000, var_1.origin);
  }

  var_3 = scripts\cp\cp_agent_utils::getactiveagentsofspecies("alien");

  foreach(var_5 in var_3) {
    var_5 suicide();
  }
}

function players_want_to_restart(var_0, var_1) {
  if(allow_players_to_restart(var_1)) {
    if(istrue(level.focus_test_mode)) {
      return true;
    }

    level.retry_total_votes = 0;
    level.retry_yes_votes = 0;
    level.retry_timer = 0;
    level.ref_12cdf = 0;

    foreach(var_3 in level.players) {
      thread display_retry_dialog(var_3, var_0);
    }

    var_5 = level.players.size - level.retry_total_votes;

    while(level.retry_total_votes < level.players.size) {
      if(level.ref_12cdf != 0) {
        wait 1;
        return false;
      }

      setomnvar("ui_votesys_time", 33 - int(level.retry_timer));

      if(level.retry_timer >= 33) {
        return false;
      }

      var_6 = var_5;
      var_5 = level.players.size - level.retry_total_votes;

      if(var_5 != var_6) {
        iprintlnbold("Waiting for " + var_5 + " player's to vote");
      }

      wait 0.5;
      level.retry_timer += 0.5;
    }

    if(level.retry_yes_votes == level.players.size && level.ref_12cdf == 0) {
      wait 1;
      return true;
    }
  }

  return false;
}

function allow_players_to_restart(var_0) {
  if(isDefined(level.allow_players_to_restart)) {
    return [[level.allow_players_to_restart]](var_0);
  }

  return var_0 == 3;
}

function display_retry_dialog(var_0, var_1) {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  wait 1;
  scripts\cp\cp_laststand::clear_last_stand_timer(self);

  if(!isDefined(self.connectedpostgame) || !(self.pers["team"] == "spectator")) {
    var_2 = self.pers["team"];

    if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
      var_2 = "allies";
    }

    if(isDefined(self.pers["team"]) && var_0 == var_2) {
      var_3 = get_end_game_string_index("win");
    } else {
      var_3 = get_end_game_string_index("fail");
    }

    if(isDefined(var_2)) {
      self setclientomnvar("ui_round_end_reason", var_2);
    }
  }

  ref_131ac(10);
  var_4 = -1;
  self waittill("luinotifyserver", var_5);

  if(var_5 == "retry_level") {
    if(var_4 < 0) {
      level.retry_total_votes += 1;
      level.retry_yes_votes += 1;
      var_4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      return;
    }

    if(var_4 == 0) {
      level.retry_yes_votes += 1;
      var_4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      return;
    }

    return;
  }

  if(var_5 == "quit_level") {
    setomnvar("ui_votesys_player" + self getentitynumber(), 2);
    level.ref_12cdf = 1;
    return;
  }
}

function clear_powers_hud() {
  if(isDefined(self.powers)) {
    foreach(var_1 in getarraykeys(self.powers)) {
      var_2 = self.powers[var_1].charges * -1;

      if(isDefined(level.power_adjustcharges)) {
        self[[level.power_adjustcharges]](var_2);
      }
    }
  }

  if(isDefined(level.powers_clearpower)) {
    self[[level.powers_clearpower]]("secondary");
    self[[level.powers_clearpower]]("primary");
    return;
  }
}

function get_end_condition(var_0) {
  switch (var_0) {
    case 1:
      return "win";
    case 3:
    case 2:
      return "died";
    case 4:
      return "host_quit";
    default:
      break;
  }
}

function display_retry_loadout() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0);

    if(var_0 == "close_menu") {
      level.loadout_retry_completed += 1;
      continue;
    }

    switch (var_0) {
      case "dpad_team_ammo_ap":
      case "dpad_team_ammo_in":
      case "dpad_team_ammo_stun":
      case "dpad_team_ammo_reg":
        break;
      case "dpad_team_armor":
      case "dpad_team_boost":
      case "dpad_team_adrenaline":
      case "dpad_team_explosives":
        break;
      case "dpad_maaws":
      case "dpad_riotshield":
      case "dpad_death_machine":
      case "dpad_war_machine":
        break;
      case "perk_bullet_damage":
        waitframe();
        waitframe();
        break;
      case "perk_health":
        waitframe();
        waitframe();
        break;
      case "perk_rigger":
        waitframe();
        waitframe();
        break;
      case "perk_medic":
        waitframe();
        waitframe();
        break;
      case "perk_robotics":
        waitframe();
        waitframe();
        break;
      case "perk_demolition":
        waitframe();
        waitframe();
        break;
      case "perk_gunslinger":
        waitframe();
        waitframe();
        break;
      case "perk_hybrid":
        waitframe();
        waitframe();
        break;
      case "perk_pistol_zemc":
      case "perk_pistol_zg18":
      case "perk_pistol_magnum":
      case "perk_pistol_znrg":
        break;
      case "perk_skill_invulnerable":
      case "perk_skill_pet":
      case "perk_skill_electric_arc":
      case "perk_skill_mortar":
      case "perk_skill_drone":
      case "perk_skill_heal_ring":
      case "perk_skill_stasis":
      case "perk_skill_infinite_ammo":
        break;
      case "iw7_forge_mp":
      case "iw7_nrg_mp":
      case "iw7_ake_mp":
      case "iw7_m1_mp":
      case "iw7_ar57_mp":
      case "iw6_microtar_mp":
      case "iw7_cheytac_mp+cheytacscope":
      case "iw7_kbs_mp+kbsscope":
      case "iw6_panzerfaust3_mp":
      case "iw6_kriss_mp":
      case "iw6_cprgm_mp":
      case "iw6_cppanzerfaust3_mp":
      case "iw6_l115a3_mp+acogsniper":
      case "iw6_vks_mp+vksscope":
      case "iw7_m8_mp+m8scope":
      case "iw6_svu_mp":
      case "iw6_g28_mp":
      case "iw6_imbel_mp":
      case "iw6_pdw_mp":
      case "iw6_vepr_mp":
      case "iw6_pp19_mp":
      case "iw6_maul_mp":
      case "iw6_cbjms_mp":
      case "iw6_mts255_mp":
      case "iw6_fp6_mp":
      case "iw6_honeybadger_mp":
      case "iw6_aliendlc11li_mp":
      case "iw6_p226_mp":
      case "iw6_magnum_mp":
      case "iw6_m9a1_mp":
      case "iw6_mp443_mp":
      case "iw6_m27_mp":
      case "iw6_lsat_mp":
      case "iw7_crb_mp":
      case "iw6_dlcweap02_mp+dlcweap02scope":
      case "iw6_plasmaauto_mp":
      case "iw7_erad_mp":
      case "iw7_devastator_mp":
      case "iw7_chargeshot_mp":
      case "iw7_spas_mp":
      case "iw6_arx160_mp":
      case "iw6_kac_mp":
      case "iw7_glprox_mp":
        break;
    }
  }
}

function displaygameend(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame) || var_3.pers["team"] == "spectator") {
      continue;
    }

    thread outcomenotify(var_3, var_0);
    var_3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", var_0);
  roundendwait(3, 1);
}

function outcomenotify(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var_2 = self.pers["team"];

  if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
    var_2 = "allies";
  }

  while(scripts\cp\cp_hud_message::isdoingsplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var_0 == var_2) {
    var_3 = get_end_game_string_index("win");
  } else {
    var_3 = get_end_game_string_index("fail");
  }

  self setclientomnvar("ui_round_end_title", var_3);

  if(isDefined(var_2)) {
    self setclientomnvar("ui_round_end_reason", var_2);
  }

  ref_131ac(2);
}

function register_end_game_string_index() {
  if(isDefined(level.end_game_string_override)) {
    [[level.end_game_string_override]]();
    return;
  }

  register_default_end_game_string_index();
}

function register_default_end_game_string_index() {
  level.end_game_string_index = [];
  level.end_game_string_index["win"] = 1;
  level.end_game_string_index["fail"] = 2;
  level.end_game_string_index["kia"] = 3;
  level.end_game_string_index["host_end"] = 4;
  level.end_game_string_index["restarting"] = 5;
  level.end_game_string_index["exiting"] = 6;
}

function get_end_game_string_index(var_0) {
  return level.end_game_string_index[var_0];
}

function roundendwait(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5.doingsplash)) {
        continue;
      }

      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var_2 = 0;
    }

    wait 0.5;
  }

  if(!var_1) {
    wait var_0;
    level notify("round_end_finished");
    return;
  }

  wait var_0 / 2;
  level notify("give_match_bonus");
  wait var_0 / 2;
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5.doingsplash)) {
        continue;
      }

      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var_2 = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}

function deathfx() {
  var_0 = self;
  var_0.death = spawnStruct();
  var_0.death.huds = [];
  var_1 = 3;
  var_2 = 5;

  if(istrue(var_0.skip_screen_fx)) {
    return;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::ref_12510()) {
    visionsetpain("damage_dead", 0.2);
    var_0 painvisionon();
    thread deathfxoverlay(var_0, "death_overlay", "ui_player_death_overlay", 0, 0);
  }

  thread deathfxoverlay(var_0, "death_tunnel", "ui_player_death_tunnel_overlay", 1, 3);
  thread deathfxoverlay(var_0, "death_black", "ui_player_death_black_overlay", 1, var_1);
  wait 1;
  var_0 setblurforplayer(6, var_2);
}

function deathfxoverlay(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  wait var_2;
  var_5.death.huds[var_0] = create_death_hudelem();
  var_5.death.huds[var_0] setshader(var_1, 640, 480);

  if(var_3 > 0) {
    var_5.death.huds[var_0] fadeovertime(var_3);
  }

  var_5.death.huds[var_0].alpha = 1;
  var_5.death.huds[var_0].sort = var_4;
}

function create_death_hudelem() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.lowresbackground = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  return var_0;
}