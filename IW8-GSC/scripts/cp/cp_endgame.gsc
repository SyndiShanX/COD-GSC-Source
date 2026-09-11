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
    level waittill("connected", var0);

    if(isDefined(level.ref_127ff)) {
      var0 setclientomnvar("post_game_state", level.ref_127ff);

      if(isDefined(var0.pers["team"]) && level.winner == var0.pers["team"]) {
        var1 = get_end_game_string_index("win");
      } else {
        var1 = get_end_game_string_index("fail");
      }

      var1 setclientomnvar("ui_round_end_title", var1);
    }
  }
}

function ref_131ac(var0) {
  setomnvarforallclients("post_game_state", var0);
  level.ref_127ff = var0;
}

function cargo_truck_mg_explode(var0) {
  if(isDefined(var0) && !isDefined(var0.clientmatchdataid)) {
    var0.clientmatchdataid = level.initship;
    level.initship++;
    return;
  }
}

function endgame(var0, var1) {
  if(gamealreadyended()) {
    return;
  }

  foreach(var4, var3 in level.players) {
    if(istrue(var3 isparachuting()) || istrue(var3 isskydiving())) {
      var3 skydive_interrupt();
    }

    thread scripts\cp\cp_laststand::hide_all_revive_icons(var3);
  }

  if(isDefined(level.intel_headicons)) {
    foreach(var6 in level.intel_headicons) {
      level.intel_headicons = scripts\engine\utility::array_remove(level.intel_headicons, var6);
      setheadiconimage(var6);
    }
  }

  if(var1 == 3) {
    foreach(var3 in level.players) {
      if(isDefined(level.gametype) && level.gametype == "cp_wave_sv") {
        var9 = game["music"]["spawn_player"].size;
        var10 = randomint(var9);
        var3 setplayermusicstate(game["music"]["cp_roundloss"][var10]);
      } else {
        var3 setsoundsubmix("mp_matchend_music", 2);
        var3 setplayermusicstate("mus_cp_defeat");
      }

      thread deathfx();
    }
  }

  setDvar("scr_init_cs_files", "");
  setnojiptime(1);
  markgameended();
  level notify("game_ended", var0);
  freezeallplayers(1, "NSSLSNKPN", 1);
  var12 = tolower(getDvar("mapname"));

  foreach(var3 in level.players) {
    if(isDefined(level.gametype)) {
      var3 setplayerdata("common", "round", "gameMode", level.gametype);
      var3 setplayerdata("common", "round", "map", var12);
    }
  }

  if(var1 == 3) {
    wait 1;
  }

  var15 = 0;
  var16 = "";

  if(!scripts\cp\utility::tryingtoleave()) {
    var16 = "FAIL";

    switch (var1) {
      case 1:
        var16 = "SUCCESS";
        scripts\cp\drone\emp_drone::rankedmatchupdates("allies");
        break;
      case 4:
        var16 = "HOST QUIT";
        scripts\cp\drone\emp_drone::rankedmatchupdates("axis");
        break;
      default:
        var16 = "FAIL";
        scripts\cp\drone\emp_drone::rankedmatchupdates("axis");
        break;
    }

    if(isDefined(level.pre_map_restart_func)) {
      [[level.pre_map_restart_func]](var16);
    }

    scripts\cp\cp_analytics::ref_119b8(var16);
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var3 in level.players) {
    if(scripts\cp\utility::matchmakinggame() && (var16 == "SUCCESS" || var16 == "FAIL")) {
      var3 scripts\cp_mp\utility\game_utility::stopkeyearning(var16);
    }

    var18 = get_current_zone(var3);
    var19 = var3 getplayerdata("cp", "alienSession", "kills");
    var20 = var3 getplayerdata("cp", "alienSession", "downed");
    var21 = var3 getplayerdata("cp", "alienSession", "revives");
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Kills", "count", var19, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Last Stands", "count", var20, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Revives", "count", var21, "description", ""]);
    cargo_truck_mg_explode(var3);
    setclientmatchdata("player", var3.clientmatchdataid, "xuidHigh", var3 getxuidhigh());
    setclientmatchdata("player", var3.clientmatchdataid, "xuidLow", var3 getxuidlow());
    setclientmatchdata("player", var3.clientmatchdataid, "zombie_death", var19);
    setclientmatchdata("player", var3.clientmatchdataid, "dropped_to_last_stand", var20);
    setclientmatchdata("player", var3.clientmatchdataid, "revived_another_player", var21);

    if(isDefined(var3.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var22 = var3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("player", var3.clientmatchdataid, "rank", var22);
    }

    if(isDefined(var3.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var23 = var3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("player", var3.clientmatchdataid, "prestige", var23);
    }

    if(var3 isps4player()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "ps4");
    } else if(var3 isxb3player()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "xb3");
    } else if(var3 ispcplayer()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "none");
    }

    var3 scripts\cp\agents\agents::logplayerdata(var16);
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

  foreach(var3 in level.players) {
    cleanup_player_on_game_end(var3);
  }

  level.bgameover = 1;

  foreach(var28 in level.agentarray) {
    if(isDefined(var28.isactive) && var28.isactive) {
      var28.ignoreall = 1;
      var28 scripts\cp\utility::enable_alien_scripted();
    }
  }

  ref_131ac(0);
  level.winner = var0;
  displaygameend(var0, var1);
  var30 = should_load_new_map(var1);

  if(isDefined(var30)) {
    if(isDefined(level.load_new_map_func)) {
      [[level.load_new_map_func]](var1);
    }

    load_new_map(var30);
    return;
  } else if(players_want_to_restart(var0, var1)) {
    var31 = get_end_game_string_index("restarting");

    foreach(var3 in level.players) {
      var3 setclientomnvar("ui_round_end_title", var31);
    }

    wait 1;
    restart_map();
    return;
  } else {
    var31 = get_end_game_string_index("exiting");

    foreach(var13 in level.players) {
      var13 setclientomnvar("ui_round_end_title", var31);
    }
  }

  scripts\cp\cp_globallogic::ref_12c58();
  setDvar("scr_cp_map_part2", "");

  if(isDefined(level.pre_end_game_display_func)) {
    [[level.pre_end_game_display_func]]();
  }

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var13 in level.players) {
      var13 setclientdvar("MQNNLTKNTS", 1);
    }
  }

  var38 = get_end_condition(var4);
  var39 = get_play_time();
  scripts\cp\cp_analytics::endgame(var38, var39);
  reset_players_subparty_data();
  wait 1;
  var40 = level.intermissionfunc;

  if(isDefined(level.custom_intermission_func)) {
    var40 = level.custom_intermission_func;
  }

  wait 0.5;

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var13 in level.players) {
      var13 thread[[var40]](var4);
    }
  }

  level notify("exitLevel_called");
  exitlevel(0);
}

function ref_13446() {
  thread ref_13445(level, "axis");
}

function ref_13445(var0, var1) {
  if(gamealreadyended()) {
    return;
  }

  if(var1 == 3 || var1 == 2) {
    foreach(var3 in level.players) {
      var4 = game["music"]["spawn_player"].size;
      var5 = randomint(var4);
      var3 setplayermusicstate(game["music"]["cp_roundloss"][var5]);
      var3 clearclienttriggeraudiozone(0);
      var3 setsoundsubmix("cp_matchend", 3);
      thread ref_1344a(var3);

      if(istrue(var3.musicplaying)) {
        var3 playlocalsound("mp_jugg_mus_toggle_button");
        var3 setscriptablepartstate("juggernaut", "neutral", 0);
      }
    }
  }

  if(var1 == 1) {
    foreach(var3 in level.players) {
      var3 clearclienttriggeraudiozone(0);

      if(istrue(var3.musicplaying)) {
        var3 playlocalsound("mp_jugg_mus_toggle_button");
        var3 setscriptablepartstate("juggernaut", "neutral", 0);
      }

      var3 setplayermusicstate("mus_west_victory");
      var3 setsoundsubmix("cp_matchend", 3);
    }
  }

  setDvar("scr_init_cs_files", "");
  setnojiptime(1);
  markgameended();
  level notify("game_ended", var0);
  scripts\cp\cp_analytics::ref_119b8(var1);
  freezeallplayers(1, "NSSLSNKPN", 1);
  var9 = tolower(getDvar("mapname"));

  foreach(var3 in level.players) {
    if(isDefined(level.gametype)) {
      var3 setplayerdata("common", "round", "gameMode", level.gametype);
      var3 setplayerdata("common", "round", "map", var9);
    }
  }

  if(var1 == 3) {
    wait 1;
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var3 in level.players) {
    var13 = get_current_zone(var3);
    var14 = var3 getplayerdata("cp", "alienSession", "kills");
    var15 = var3 getplayerdata("cp", "alienSession", "downed");
    var16 = var3 getplayerdata("cp", "alienSession", "revives");
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Kills", "count", var14, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Last Stands", "count", var15, "description", ""]);
    getentitylessscriptablearray("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", getbuildnumber(), "playername", var3.name, "stat_type", "Revives", "count", var16, "description", ""]);
    cargo_truck_mg_explode(var3);

    if(isDefined(var3.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var17 = var3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("player", var3.clientmatchdataid, "rank", var17);
    }

    if(isDefined(var3.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var18 = var3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("player", var3.clientmatchdataid, "prestige", var18);
    }

    setclientmatchdata("player", var3.clientmatchdataid, "xuidHigh", var3 getxuidhigh());
    setclientmatchdata("player", var3.clientmatchdataid, "xuidLow", var3 getxuidlow());
    setclientmatchdata("player", var3.clientmatchdataid, "zombie_death", var14);
    setclientmatchdata("player", var3.clientmatchdataid, "dropped_to_last_stand", var15);
    setclientmatchdata("player", var3.clientmatchdataid, "revived_another_player", var16);

    if(var3 isps4player()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "ps4");
    } else if(var3 isxb3player()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "xb3");
    } else if(var3 ispcplayer()) {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("player", var3.clientmatchdataid, "platform", "none");
    }

    var3 scripts\cp\agents\agents::logplayerdata(var1);
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
  var20 = ref_13448(var0);

  if(var20.ref_1376c > 0) {
    setomnvar("ui_so_stars_given", var20.ref_1376c);
  }

  setomnvar("ui_so_next_score", var20.ref_11e84);
  setomnvar("ui_so_iwbest", var20.vehicle_compass_cp_init);
  setDvar("SLLNLPRON", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("MPOKQNLPRM", 0);
  setgameendtime(0);

  if(getdvarint("LTSNLQNRKO")) {
    foreach(var3 in level.players) {
      if(var20.ref_1376c > 0) {
        ref_1344b(var3, var20.ref_1376c, level.time_survived);
        var22 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
        var23 = tablelookupbyrow("cp/cp_so_mission_table.csv", var22, 0);
        var3 reportchallengeuserevent("spec_ops_end", var23, var20.ref_1376c);
      }
    }
  }

  foreach(var3 in level.players) {
    cleanup_player_on_game_end(var3);
  }

  foreach(var28 in level.agentarray) {
    if(isDefined(var28.isactive) && var28.isactive) {
      var28.ignoreall = 1;
    }
  }

  ref_13444(var0, var1);
  var30 = get_end_condition(var1);
  var31 = get_play_time();
  scripts\cp\cp_analytics::endgame(var30, var31);
  reset_players_subparty_data();

  if(ref_1344c()) {
    wait 0.1;

    foreach(var3 in level.players) {
      var3 clearsoundsubmix("cp_matchend", 2);
      var3 clearsoundsubmix("mp_matchend_music", 2);
    }

    restart_map(0);
    return;
  }

  exitlevel(0);
}

function ref_13447() {
  var0 = int(gettime() - level.autoassignlowteamconsistent);
  var0 = int(var0 / 1000) * 1000;
  return var0;
}

function trygetlastpotentiallivingplayer() {
  return getdvarint("MRTSTTKTNL") && getdvarint("SNTTNKSRO");
}

function ref_13448(var0) {
  var1 = spawnStruct();
  var1.ref_1376c = 0;
  var1.ref_11e86 = 1;
  var1.ref_11e84 = 0;
  var2 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
  GscBinSkip1(0x45, 0, int(tablelookupbyrow("cp/cp_so_mission_table.csv", var2, 6)));
}

function ref_1344b(var0, var1) {
  var2 = self getplayerdata("cp", "ClassicSOStarCount", level.script);
  var3 = self getplayerdata("cp", "ClassicSOBestScore", level.script);

  if(!isDefined(var2) || !isDefined(var3)) {
    return;
  }

  if(var0 > var2) {
    self setplayerdata("cp", "ClassicSOStarCount", level.script, var0);
  }

  if(var1 < var3 || var3 == 0) {
    self setplayerdata("cp", "ClassicSOBestScore", level.script, var1);
    return;
  }
}

function ref_1344a(var0) {
  var1 = var0 == self.pers["team"];

  if(var1 && !scripts\cp_mp\utility\player_utility::ref_12510()) {
    visionsetpain("damage_dead", 0.2);
    self painvisionon();
    thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 1, 18);
  }

  self setblurforplayer(10, 1);
}

function ref_13444(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(var3.connectedpostgame) || var3.pers["team"] == "spectator") {
      continue;
    }

    thread ref_13449(var3, var0);
    var3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }
}

function ref_13449(var0, var1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var2 = self.pers["team"];

  if(!isDefined(var2) || var2 != "allies" && var2 != "axis") {
    var2 = "allies";
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var0 == var2) {
    var3 = get_end_game_string_index("win");
  } else {
    var3 = get_end_game_string_index("fail");
  }

  self setclientomnvar("ui_round_end_title", var3);

  if(isDefined(var2)) {
    self setclientomnvar("ui_round_end_reason", var2);
  }

  ref_131ac(11);
}

function ref_1344c() {
  level.retry_total_votes = 0;
  level.retry_yes_votes = 0;
  var0 = 35;
  var1 = 0.1;

  for(var2 = 0; var2 < level.players.size; var2++) {
    setomnvar("ui_votesys_player" + var2, 0);
  }

  var3 = -1;
  var4 = -1;
  var5 = 1;

  foreach(var7 in level.players) {
    thread ref_124e8();
  }

  while(level.retry_total_votes < level.players.size) {
    var9 = int(var0);

    if(var9 >= 0 && var9 != var4) {
      var4 = var0;
      setomnvar("ui_votesys_time", var9);
    }

    if(var0 <= 0) {
      var5 = 0;
      break;
    }

    wait var1;
    var0 -= var1;
  }

  setomnvar("ui_votesys_time", 0);
  level notify("stop_player_retry_thread");

  if(!var5) {
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

  for(var0 = -1;; var0 = 0) {
    self waittill("luinotifyserver", var1);

    if(var1 == "retry_level") {
      if(var0 < 0) {
        level.retry_total_votes += 1;
        level.retry_yes_votes += 1;
        var0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      } else if(var0 == 0) {
        level.retry_yes_votes += 1;
        var0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      }

      continue;
    }

    if(var1 == "quit_level") {
      if(var0 < 0) {
        level.retry_total_votes += 1;
        continue;
      }

      if(var0 == 1) {
        level.retry_yes_votes -= 0;
      }
    }
  }
}

function reset_players_subparty_data() {
  foreach(var1 in level.players) {
    var1 setplayerdata("cp", "CPSession", "subParty", -1);
  }
}

function get_current_zone(var0) {
  var1 = getEntArray("p_ent_zone", "targetname");

  foreach(var3 in var1) {
    if(ispointinvolume(var0.origin, var3)) {
      return var3.script_noteworthy;
    }
  }
}

function check_best_score() {}

function vehomn_updateomnvarsperframe() {
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2 thread scripts\cp\cp_skits::movequestobjicon();
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

function freezeallplayers(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  foreach(var4 in level.players) {
    thread freezeplayerforroundend(var4);
    thread roundenddof(var4);
    freegameplayhudelems(var4);
    var4 setclientdvars("LQKPQMPRQN", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(var1) && isDefined(var2)) {
      var4 setclientdvars(var1, var2);
    }
  }

  foreach(var7 in level.agentarray) {
    var7 scripts\cp\utility::freezecontrolswrapper(1);
  }
}

function freezeplayerforroundend(var0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(var0)) {
    var0 = 0.05;
  }

  wait var0;
  scripts\cp\utility::freezecontrolswrapper(1);
}

function roundenddof(var0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

function get_play_time() {
  var0 = 0;

  if(isDefined(level.starttime)) {
    var0 = gettime() - level.starttime;
  }

  return var0;
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

function cleanup_player_on_game_end(var0) {
  var0 notify("select_mode");
  var0 notify("reset_outcome");
  var0.pers["stats"] = var0.stats;
  var0 scripts\cp\utility::allow_player_ignore_me(1);
  var0 scripts\cp\cp_persistence::set_player_currency(0);
  var0 scripts\cp\utility::clearlowermessages();

  if(isDefined(var0.pap)) {
    var0.pap = [];
  }

  if(isDefined(var0.powerupicons)) {
    var0.powerupicons = [];
  }

  if(isDefined(var0.consumables_equipped)) {
    var0.consumables_equipped = [];
  }

  if(isDefined(var0.powers)) {
    var0.powers = [];
  }

  clear_powers_hud(var0);
}

function should_load_new_map(var0) {
  if((var0 == 1 || var0 == 2) && getDvar("NSQLTTMRMP") == "cp_jackal_ass") {
    return "cp_titan";
  }

  return undefined;
}

function load_new_map(var0) {
  kill_em_all();
  level scripts\engine\utility::ref_143b9(15, "intermission_over");
  setDvar("NSQLTTMRMP", var0);
  setDvar("NKTMKRMSKR", "aliens");
  var1 = "map " + var0;
}

function restart_map(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    level.players[var1] scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
    level.players[var1] setclientomnvar("ui_match_in_progress", 0);
    level.players[var1] setclientomnvar("ui_hide_hud", 1);
  }

  kill_em_all();
  setomnvar("allow_server_pause", 1);
  ref_131ac(0);
  setomnvarforallclients("reset_wave_loadout", 1);

  if(!isDefined(var0)) {
    var0 = 3;
  }

  for(var1 = var0; var1 > 0; var1--) {
    wait 1;
  }

  foreach(var3 in level.players) {
    var3 clearsoundsubmix("cp_matchend", 4);
    var3 clearsoundsubmix("mp_matchend_music", 4);
  }

  map_restart(1);
}

function kill_em_all() {
  foreach(var1 in level.characters) {
    if(isPlayer(var1)) {
      continue;
    }

    var1 dodamage(100000, var1.origin);
  }

  var3 = scripts\cp\cp_agent_utils::getactiveagentsofspecies("alien");

  foreach(var5 in var3) {
    var5 suicide();
  }
}

function players_want_to_restart(var0, var1) {
  if(allow_players_to_restart(var1)) {
    if(istrue(level.focus_test_mode)) {
      return true;
    }

    level.retry_total_votes = 0;
    level.retry_yes_votes = 0;
    level.retry_timer = 0;
    level.ref_12cdf = 0;

    foreach(var3 in level.players) {
      thread display_retry_dialog(var3, var0);
    }

    var5 = level.players.size - level.retry_total_votes;

    while(level.retry_total_votes < level.players.size) {
      if(level.ref_12cdf != 0) {
        wait 1;
        return false;
      }

      setomnvar("ui_votesys_time", 33 - int(level.retry_timer));

      if(level.retry_timer >= 33) {
        return false;
      }

      var6 = var5;
      var5 = level.players.size - level.retry_total_votes;

      if(var5 != var6) {
        iprintlnbold("Waiting for " + var5 + " player's to vote");
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

function allow_players_to_restart(var0) {
  if(isDefined(level.allow_players_to_restart)) {
    return [[level.allow_players_to_restart]](var0);
  }

  return var0 == 3;
}

function display_retry_dialog(var0, var1) {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  wait 1;
  scripts\cp\cp_laststand::clear_last_stand_timer(self);

  if(!isDefined(self.connectedpostgame) || !(self.pers["team"] == "spectator")) {
    var2 = self.pers["team"];

    if(!isDefined(var2) || var2 != "allies" && var2 != "axis") {
      var2 = "allies";
    }

    if(isDefined(self.pers["team"]) && var0 == var2) {
      var3 = get_end_game_string_index("win");
    } else {
      var3 = get_end_game_string_index("fail");
    }

    if(isDefined(var2)) {
      self setclientomnvar("ui_round_end_reason", var2);
    }
  }

  ref_131ac(10);
  var4 = -1;
  self waittill("luinotifyserver", var5);

  if(var5 == "retry_level") {
    if(var4 < 0) {
      level.retry_total_votes += 1;
      level.retry_yes_votes += 1;
      var4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      return;
    }

    if(var4 == 0) {
      level.retry_yes_votes += 1;
      var4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      return;
    }

    return;
  }

  if(var5 == "quit_level") {
    setomnvar("ui_votesys_player" + self getentitynumber(), 2);
    level.ref_12cdf = 1;
    return;
  }
}

function clear_powers_hud() {
  if(isDefined(self.powers)) {
    foreach(var1 in getarraykeys(self.powers)) {
      var2 = self.powers[var1].charges * -1;

      if(isDefined(level.power_adjustcharges)) {
        self[[level.power_adjustcharges]](var2);
      }
    }
  }

  if(isDefined(level.powers_clearpower)) {
    self[[level.powers_clearpower]]("secondary");
    self[[level.powers_clearpower]]("primary");
    return;
  }
}

function get_end_condition(var0) {
  switch (var0) {
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
    self waittill("luinotifyserver", var0);

    if(var0 == "close_menu") {
      level.loadout_retry_completed += 1;
      continue;
    }

    switch (var0) {
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

function displaygameend(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(var3.connectedpostgame) || var3.pers["team"] == "spectator") {
      continue;
    }

    thread outcomenotify(var3, var0);
    var3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", var0);
  roundendwait(3, 1);
}

function outcomenotify(var0, var1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var2 = self.pers["team"];

  if(!isDefined(var2) || var2 != "allies" && var2 != "axis") {
    var2 = "allies";
  }

  while(scripts\cp\cp_hud_message::isdoingsplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var0 == var2) {
    var3 = get_end_game_string_index("win");
  } else {
    var3 = get_end_game_string_index("fail");
  }

  self setclientomnvar("ui_round_end_title", var3);

  if(isDefined(var2)) {
    self setclientomnvar("ui_round_end_reason", var2);
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

function get_end_game_string_index(var0) {
  return level.end_game_string_index[var0];
}

function roundendwait(var0, var1) {
  var2 = 0;

  while(!var2) {
    var3 = level.players;
    var2 = 1;

    foreach(var5 in var3) {
      if(!isDefined(var5.doingsplash)) {
        continue;
      }

      if(!var5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var2 = 0;
    }

    wait 0.5;
  }

  if(!var1) {
    wait var0;
    level notify("round_end_finished");
    return;
  }

  wait var0 / 2;
  level notify("give_match_bonus");
  wait var0 / 2;
  var2 = 0;

  while(!var2) {
    var3 = level.players;
    var2 = 1;

    foreach(var5 in var3) {
      if(!isDefined(var5.doingsplash)) {
        continue;
      }

      if(!var5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var2 = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}

function deathfx() {
  var0 = self;
  var0.death = spawnStruct();
  var0.death.huds = [];
  var1 = 3;
  var2 = 5;

  if(istrue(var0.skip_screen_fx)) {
    return;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::ref_12510()) {
    visionsetpain("damage_dead", 0.2);
    var0 painvisionon();
    thread deathfxoverlay(var0, "death_overlay", "ui_player_death_overlay", 0, 0);
  }

  thread deathfxoverlay(var0, "death_tunnel", "ui_player_death_tunnel_overlay", 1, 3);
  thread deathfxoverlay(var0, "death_black", "ui_player_death_black_overlay", 1, var1);
  wait 1;
  var0 setblurforplayer(6, var2);
}

function deathfxoverlay(var0, var1, var2, var3, var4) {
  var5 = self;
  wait var2;
  var5.death.huds[var0] = create_death_hudelem();
  var5.death.huds[var0] setshader(var1, 640, 480);

  if(var3 > 0) {
    var5.death.huds[var0] fadeovertime(var3);
  }

  var5.death.huds[var0].alpha = 1;
  var5.death.huds[var0].sort = var4;
}

function create_death_hudelem() {
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.splatter = 1;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.foreground = 0;
  var0.lowresbackground = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 0;
  var0.enablehudlighting = 1;
  return var0;
}