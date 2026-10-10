/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\endgame.gsc
***********************************************/

#using script_3f8889c16399185c;
#using script_48324b060b129b7b;
#using script_4a6760982b403bad;
#using script_4cdabcd91a92977;
#using script_575fda2758b0a36e;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_matchdata;
#using scripts\cp\damage;
#using scripts\cp\endgame;
#using scripts\cp\globallogic;
#using scripts\cp\killcam;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\player_death;
#using scripts\cp\progression;
#using scripts\cp\rank;
#using scripts\cp\star_rewards;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace endgame;

function init() {
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&playerconnectwatcher);
  register_end_game_string_index();
  progression_init();
  thread debug_test_next_mission();
}

function playerconnectwatcher() {
  if(isDefined(level.postgamestate)) {
    self setclientomnvar("post_game_state", level.postgamestate);

    if(isDefined(self.pers["team"]) && level.winner == self.pers["team"]) {
      var_c8fc76edce2feb09 = get_end_game_string_index("win");
    } else {
      var_c8fc76edce2feb09 = get_end_game_string_index("fail");
    }

    self setclientomnvar("ui_round_end_title", var_c8fc76edce2feb09);
  }
}

function setpostgamestate(state) {
  level.postgamestate = state;
  setomnvarforallclients("post_game_state", state);
}

function function_1d589506af8d2811() {
  if(!isDefined(self.pers)) {
    self.pers = [];
  }

  self.pers["restarted"] = 1;
}

function function_936fccb404737eef() {
  foreach(player in level.players) {
    if(isDefined(player.pers) && istrue(player.pers["restarted"])) {
      player.pers["restarted"] = undefined;
    }
  }
}

function endgame(winner, endreasontextindex) {
  if(endreasontextindex == 1) {
    setDvar(@ "start", "");
  }

  if(gamealreadyended()) {
    return;
  }

  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "") {
    if(isDefined(game["checkpoint_attempts"]) && isDefined(game["checkpoint_attempts"][checkpoint])) {
      game["checkpoint_attempts"][checkpoint]++;
    }
  }

  result = "FAIL";

  switch (endreasontextindex) {
    case 1:
      result = "SUCCESS";
      setmusicstate("mp_cp_endgame_1");
      break;
    case 4:
      result = "HOST QUIT";
      break;
    default:
      result = "FAIL";
      setmusicstate("mp_cp_endgame_lose_1");
      break;
  }

  levelindex = getlevelindex(level.script);

  if(!isDefined(levelindex)) {
    return;
  }

  markgameended(result, levelindex);
  namespace_bf9ffd2b22c7d819::function_4064a2271de12b97();
  level thread function_180b06d3d67d483c();
  current_mission = scripts\cp\progression::function_399ccfe790a8b2eb();

  if(isDefined(current_mission) && current_mission != "") {
    value = int(tablelookup("cp/missionsbesttimes.csv", 0, current_mission, 1));
    setomnvar("ui_so_iwbest", value);
  }

  foreach(player in level.players) {
    player notify("showing_final_killcam");
    player notify("stealth_disabled");
    player thread scripts\cp\laststand::hide_all_revive_icons(player);
    player setclientomnvar("ui_securing_progress", 0);
    player setclientomnvar("ui_securing", 0);
    player scripts\common\damage_effects::function_a2b4e6088394bade();
    player setsoundsubmix("cp_matchend", 2);

    if(level.gametype == "dungeons") {
      if(endreasontextindex == 4) {
        player clearallsoundsubmixes();
      } else {
        player setsoundsubmix("cp_jup_loadoutscreen", 4);
      }
    }

    if(endreasontextindex == 3) {
      if(!isDefined(player.pers["deaths"])) {
        player.pers["deaths"] = 0;
      }

      player.pers["deaths"]++;
      player thread deathfx();
    }
  }

  if(isDefined(level.intel_headicons)) {
    foreach(headicon in level.intel_headicons) {
      deleteheadicon(headicon);
    }

    level.intel_headicons = [];
  }

  setDvar(@ "hash_db88b998734440cc", "");
  setDvar(@ "hash_e6d511d33e0fe486", 0);
  setnojiptime(1);

  if(isDefined(level.var_51c1068f1991312e) && scripts\cp\killcam::function_3f8b7ecacb8eb472(level.var_51c1068f1991312e)) {
    level.var_51c1068f1991312e.victim thread scripts\cp\damage::playerkilled_killcam(level.var_51c1068f1991312e);
    level waittill("player_killcam_over");
  }

  level notify("game_ended", winner);
  freezeallplayers(1, @ "hash_682a9bc40f96ca4a", 1);
  current_map = tolower(getDvar(@ "ui_mapname"));

  foreach(player in level.players) {
    if(isDefined(level.gametype) && level.gametype != "incursion") {
      player setplayerdata("common", "round", "gameMode", level.gametype);
      player setplayerdata("common", "round", "map", current_map);
    }

    if(scripts\cp\utility::function_240f7f4e57340e8f()) {
      player setprogressiondata("spData", "currentGameskill", level.gameskill + 1);
    }
  }

  if(endreasontextindex == 3) {
    wait 1.4;
  }

  splitscreen = 0;

  switch (endreasontextindex) {
    case 1:
      scripts\cp\rank::rankedmatchupdates("allies");
      break;
    case 4:
      scripts\cp\rank::rankedmatchupdates("axis");
      break;
    default:
      scripts\cp\rank::rankedmatchupdates("axis");
      break;
  }

  if(isDefined(level.pre_map_restart_func)) {
    [[level.pre_map_restart_func]](result);
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.ingraceperiod = 0;
  setomnvar("allow_server_pause", 0);

  foreach(player in level.players) {
    player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);
  }

  waitframe();
  scripts\cp\utility::function_2c08be5adb8b60f4();
  setomnvar("zm_time_survived", level.time_survived);

  if(isDefined(level.eogscoringtable)) {}

  if(endreasontextindex != 4 || level.gametype != "dungeons") {
    setpostgamestate(1);
  }

  setDvar(@ "g_deadchat", 1);
  setDvar(@ "ui_allow_teamchange", 0);
  setDvar(@ "hash_8ed4dff39f3251f5", 0);
  setDvar(@ "scr_gameended", 1);
  setgameendtime(0);
  setslowmotion(1, 1, 0);

  foreach(player in level.players) {
    cleanup_player_on_game_end(player);
    player function_2afb89230a848a3c(result);
  }

  sendscriptusageanalysisdata(1, 1);

  if(result == "SUCCESS") {
    scripts\cp\cp_checkpoint::function_5ace495feba111d3();

    foreach(player in level.players) {
      player scripts\cp\cp_checkpoint::function_903f68999f98fa78();
    }
  }

  if(endreasontextindex != 4 || level.gametype != "dungeons") {
    if(result == "SUCCESS" && !utility::is_demo()) {
      map_names = function_a629869e3bbbe3c5("sp_jup");
      var_e517a3162a907782 = -1;

      for(i = 0; i < map_names.size - 1; i++) {
        if(map_names[i] == current_map) {
          var_e517a3162a907782 = i + 1;
          break;
        }
      }

      if(var_e517a3162a907782 > -1) {
        var_2d6a4ac260e40fea = map_names[var_e517a3162a907782];
        var_abc09d1bef94f469 = function_b146e0d2e5d91eef(var_2d6a4ac260e40fea);
        level.player setprogressiondata("spData", "currentMission", var_2d6a4ac260e40fea);
        var_dd5f1ceda1154582 = var_abc09d1bef94f469.var_dd5f1ceda1154582;

        if(isDefined(var_dd5f1ceda1154582)) {
          println("<dev string:x1c>" + var_dd5f1ceda1154582);
          level.player playcinematicforplayer(var_dd5f1ceda1154582, 1, 0, 128 | 8192 | 33554432);
          wait 3;
        }

        if(var_abc09d1bef94f469.var_60699f6be12aea0d) {
          println("<dev string:x2f>" + var_2d6a4ac260e40fea);
          changelevel(var_2d6a4ac260e40fea);
        } else {
          wait 1;
          function_bb63844d1b8da6ae(var_2d6a4ac260e40fea);
        }
      } else {
        var_c8fc76edce2feb09 = get_end_game_string_index("exiting");

        foreach(player in level.players) {
          player setclientomnvar("ui_round_end_title", var_c8fc76edce2feb09);
        }
      }
    } else {
      if(endreasontextindex == 18) {
        player thread function_f15beb5edf55a8e7();
        scripts\cp\player_death::set_custom_death_quote(9);
        scripts\cp\player_death::set_death_hint();
      }

      setpostgamestate(0);
      level.winner = winner;
      displaygameend(winner, endreasontextindex);
      wait 4;
      player setclientomnvar("ui_world_fade", 1);

      if(!level.var_f44eac8d457aa051) {
        player.pers["loadout"] = undefined;
        player.pers["equipment"] = undefined;
      }

      restart_map(undefined, result);
      return;
    }
  }

  scripts\cp\globallogic::function_ea9fc8f6656867d7();

  foreach(player in level.players) {
    if(scripts\cp\utility::matchmakinggame() && (result == "SUCCESS" || result == "FAIL")) {
      player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
    }

    last_stand_count = player scripts\cp\persistence::function_c0480dc3a45ef6("downs");
    revive_count = player scripts\cp\persistence::function_c0480dc3a45ef6("revives");
    kill_count = player scripts\cp\persistence::function_c0480dc3a45ef6("kills");
    setclientmatchdata("player", player.clientid, "xuidHigh", player getxuidhigh());
    setclientmatchdata("player", player.clientid, "xuidLow", player getxuidlow());
    setclientmatchdata("player", player.clientid, "zombie_death", kill_count);
    setclientmatchdata("player", player.clientid, "dropped_to_last_stand", last_stand_count);
    setclientmatchdata("player", player.clientid, "revived_another_player", revive_count);

    if(isDefined(player.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      rank = player scripts\cp\rank::getrank();
      setclientmatchdata("player", player.clientid, "rank", rank);
    }

    if(isDefined(player.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      prestige = player scripts\cp\rank::getprestigelevel();
      setclientmatchdata("player", player.clientid, "prestige", prestige);
    }

    if(player isps4player()) {
      setclientmatchdata("player", player.clientid, "platform", "ps4");
    } else if(player isxb3player()) {
      setclientmatchdata("player", player.clientid, "platform", "xb3");
    } else if(player ispcplayer()) {
      setclientmatchdata("player", player.clientid, "platform", "bnet");
    } else {
      setclientmatchdata("player", player.clientid, "platform", "none");
    }

    player scripts\cp\cp_matchdata::logplayerdata(result);
  }

  setDvar(@ "hash_9138afe32459ddb3", 0);
  setDvar(@ "hash_c9ecf9b70bf071c8", 0);

  if(result == "SUCCESS") {
    scripts\cp\globallogic::reset_map_dvars();
  }

  setDvar(@ "hash_f2a4b47c16a549b3", "");

  if(isDefined(level.pre_end_game_display_func)) {
    [[level.pre_end_game_display_func]]();
  }

  end_condition = get_end_condition(endreasontextindex);
  play_time = get_play_time();
  scripts\cp\cp_analytics::endgame(end_condition, play_time);
  var_5814d27874b48e54 = spawnStruct();
  var_5814d27874b48e54.result = result;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_match_end", var_5814d27874b48e54);
  reset_players_subparty_data();
  intermission_func = level.intermissionfunc;

  if(isDefined(level.custom_intermission_func)) {
    intermission_func = level.custom_intermission_func;
  }

  scripts\cp\star_rewards::function_578c2b4d51d13b9a();

  foreach(player in level.players) {
    if(isDefined(intermission_func)) {
      player thread[[intermission_func]](endreasontextindex);
    }
  }

  if(getdvarint(@ "hash_ad0b067f443d7f4f")) {
    restart_map(undefined, result);
    return;
  }

  level notify("exitLevel_called");
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_exit_level");
  exitlevel(0);
}

function function_bfb634214ac10cb6() {
  level endon("game_ended");

  foreach(player in level.players) {
    player thread function_2aa8a9f0bf64f8b9();
  }

  msg = level waittill_any_return_3("retry_level", "quit_level", "continue_to_next_level");
  var_c8fc76edce2feb09 = undefined;

  if(msg == "retry_level") {
    var_c8fc76edce2feb09 = get_end_game_string_index("restarting");
  } else if(msg == "quit_level") {
    var_c8fc76edce2feb09 = get_end_game_string_index("exiting");
  }

  level notify("endgame_lui_threads_end_early");
  return [msg, var_c8fc76edce2feb09];
}

function function_2aa8a9f0bf64f8b9(waittill_notify) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("endgame_lui_threads_end_early");

  while(true) {
    self waittill("luinotifyserver", msg);

    if(msg == "retry_level" || msg == "quit_level" || msg == "continue_to_next_level") {
      level notify(msg);
      return;
    }
  }
}

function function_8cf553a1a6826b6c() {
  player = self;
  name = player.name;
  kill_count = player scripts\cp\persistence::function_c0480dc3a45ef6("kills");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Kills", "count", kill_count, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::function_512417bddbe63792(), "player_kit", player scripts\cp\cp_analytics::function_4bf5c934fad2bc96()]);
  last_stand_count = player scripts\cp\persistence::function_c0480dc3a45ef6("downs");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Last Stands", "count", last_stand_count, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::function_512417bddbe63792(), "player_kit", player scripts\cp\cp_analytics::function_4bf5c934fad2bc96()]);
  revive_count = player scripts\cp\persistence::function_c0480dc3a45ef6("revives");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Revives", "count", revive_count, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::function_512417bddbe63792(), "player_kit", player scripts\cp\cp_analytics::function_4bf5c934fad2bc96()]);
  return [kill_count, last_stand_count, revive_count];
}

function function_2afb89230a848a3c(result) {
  player = self;
  [kill_count, last_stand_count, revive_count] = player function_8cf553a1a6826b6c();
  setclientmatchdata("player", player.clientid, "xuidHigh", player getxuidhigh());
  setclientmatchdata("player", player.clientid, "xuidLow", player getxuidlow());
  setclientmatchdata("player", player.clientid, "zombie_death", kill_count);
  setclientmatchdata("player", player.clientid, "dropped_to_last_stand", last_stand_count);
  setclientmatchdata("player", player.clientid, "revived_another_player", revive_count);

  if(isDefined(player.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
    rank = player scripts\cp\rank::getrank();
    setclientmatchdata("player", player.clientid, "rank", rank);
  }

  if(isDefined(player.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
    prestige = player scripts\cp\rank::getprestigelevel();
    setclientmatchdata("player", player.clientid, "prestige", prestige);
  }

  if(player isps4player()) {
    setclientmatchdata("player", player.clientid, "platform", "ps4");
  } else if(player isxb3player()) {
    setclientmatchdata("player", player.clientid, "platform", "xb3");
  } else if(player ispcplayer()) {
    setclientmatchdata("player", player.clientid, "platform", "bnet");
  } else {
    setclientmatchdata("player", player.clientid, "platform", "none");
  }

  player scripts\cp\cp_matchdata::logplayerdata(result);
}

function reset_players_subparty_data() {
  foreach(player in level.players) {
    player setplayerdata("cp", "CPSession", "subParty", -1);
  }
}

function forceendgame() {
  level thread endgame("axis", get_end_game_string_index("host_end"));
}

function function_74d2ca228d4852d6() {
  level thread endgame("allies", get_end_game_string_index("win"));
}

function markgameended(result, levelindex) {
  game["state"] = "postgame";
  level.gameended = 1;

  if(result == "SUCCESS") {
    levelprogressioncomplete(levelindex);

    foreach(player in level.players) {
      var_a22f6f453396a4f0 = player getprogressiondata("spData", "missionHighestDifficulty", levelindex);

      if(level.lowestgameskill + 1 > var_a22f6f453396a4f0) {
        player setprogressiondata("spData", "missionHighestDifficulty", levelindex, level.lowestgameskill + 1);
      }
    }
  }
}

function gamealreadyended() {
  return game["state"] == "postgame" || level.gameended;
}

function freezeallplayers(delay, var_8c7ca5de1b4ed9a8, var_7e99ec33d27a716e) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  foreach(player in level.players) {
    player thread freezeplayerforroundend(delay);
    player thread roundenddof(4);
    player freegameplayhudelems();
    player setclientdvars(@ "cg_everyonehearseveryone", 1, @ "cg_drawspectatormessages", 0);

    if(isDefined(var_8c7ca5de1b4ed9a8) && isDefined(var_7e99ec33d27a716e)) {
      player setclientdvars(var_8c7ca5de1b4ed9a8, var_7e99ec33d27a716e);
    }
  }

  foreach(agent in level.agentarray) {
    agent scripts\cp\utility::freezecontrolswrapper(1);
  }
}

function freezeplayerforroundend(delay) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(delay)) {
    delay = level.framedurationseconds;
  }

  wait delay;

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
    return;
  }

  thread gameendfreezemovement();
}

function gameendfreezemovement() {
  timecheck = 0;

  while(timecheck < 1) {
    if(!self isonground()) {
      timecheck += level.framedurationseconds;
    } else {
      self allowmovement(0);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(0);
}

function function_5e7f66a5f2064cf1() {
  timecheck = 0;

  while(timecheck < 1) {
    if(!self isonground()) {
      timecheck += level.framedurationseconds;
    } else {
      self allowmovement(1);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(1);
}

function function_7f47e1420fd2b2a(delay) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(delay)) {
    delay = level.framedurationseconds;
  }

  wait delay;
  val::group_set("gameEndFreeze", 1);

  if(self isonground() || self isonladder()) {
    self allowmovement(1);
    return;
  }

  thread function_5e7f66a5f2064cf1();
}

function roundenddof(time) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

function get_play_time() {
  playtime = 0;

  if(isDefined(level.starttime)) {
    playtime = gettime() - level.starttime;
  }

  return playtime;
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

  if(isDefined(self.lowermessage)) {
    self.lowermessage scripts\cp\utility::destroyelem();
  }

  if(isDefined(self.lowertimer)) {
    self.lowertimer scripts\cp\utility::destroyelem();
  }

  if(isDefined(self.proxbar)) {
    self.proxbar scripts\cp\utility::destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext scripts\cp\utility::destroyelem();
  }
}

function cleanup_player_on_game_end(player) {
  player notify("select_mode");
  player notify("reset_outcome");
  player.pers["stats"] = player.stats;
  player scripts\cp\utility::allow_player_ignore_me(1);
  player scripts\cp\persistence::set_player_currency(0);
  player scripts\cp\utility::clearlowermessages();

  if(isDefined(player.consumables_equipped)) {
    player.consumables_equipped = [];
  }

  if(isDefined(player.devgui_setup)) {
    player.devgui_setup = undefined;
  }

  player clear_powers_hud();
  player function_a593971d75d82113();
}

function restart_map(delay, result) {
  for(i = 0; i < level.players.size; i++) {
    level.players[i] setclientomnvar("ui_match_in_progress", 0);
    level.players[i] clearsoundsubmix("player_swimming_underwater", 0);
    level.players[i] clearsoundsubmix("iw9_player_drowning", 0);
    level.players[i] clearsoundsubmix("iw9_underwater_vo", 0);
    level.players[i] clearclienttriggeraudiozone(0);
    level.players[i] setclientomnvar("ui_hide_hud", 1);

    if(!isDefined(result)) {
      result = "";
    }

    if(scripts\cp\utility::matchmakinggame() && (result == "SUCCESS" || result == "FAIL")) {
      level.players[i] scripts\cp_mp\utility\game_utility::stopkeyearning(result);
    }

    last_stand_count = level.players[i] getplayerdata("cp", "alienSession", "downed");
    revive_count = level.players[i] getplayerdata("cp", "alienSession", "revives");
    kill_count = level.players[i] getplayerdata("cp", "alienSession", "kills");
    setclientmatchdata("player", level.players[i].clientid, "xuidHigh", level.players[i] getxuidhigh());
    setclientmatchdata("player", level.players[i].clientid, "xuidLow", level.players[i] getxuidlow());
    setclientmatchdata("player", level.players[i].clientid, "zombie_death", kill_count);
    setclientmatchdata("player", level.players[i].clientid, "dropped_to_last_stand", last_stand_count);
    setclientmatchdata("player", level.players[i].clientid, "revived_another_player", revive_count);

    if(isDefined(level.players[i].pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      rank = level.players[i] scripts\cp\rank::getrank();
      setclientmatchdata("player", level.players[i].clientid, "rank", rank);
    }

    if(isDefined(level.players[i].pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      prestige = level.players[i] scripts\cp\rank::getprestigelevel();
      setclientmatchdata("player", level.players[i].clientid, "prestige", prestige);
    }

    if(level.players[i] isps4player()) {
      setclientmatchdata("player", level.players[i].clientid, "platform", "ps4");
    } else if(level.players[i] isxb3player()) {
      setclientmatchdata("player", level.players[i].clientid, "platform", "xb3");
    } else if(level.players[i] ispcplayer()) {
      setclientmatchdata("player", level.players[i].clientid, "platform", "bnet");
    } else {
      setclientmatchdata("player", level.players[i].clientid, "platform", "none");
    }

    level.players[i] scripts\cp\cp_matchdata::logplayerdata(result);
  }

  kill_em_all();
  setomnvar("allow_server_pause", 1);
  setpostgamestate(0);
  setomnvarforallclients("reset_wave_loadout", 1);

  if(!isDefined(delay)) {
    delay = 3;
  }

  if(level.gametype == "dungeons" && !gamealreadyended()) {
    foreach(player in level.players) {
      player setsoundsubmix("cp_jup_loadoutscreen", max(0, delay - 0.2));
    }
  }

  for(i = delay; i > 0; i--) {
    wait 1;
  }

  foreach(player in level.players) {
    if(level.gametype != "dungeons") {
      player clearsoundsubmix("cp_matchend", 4);
      player clearsoundsubmix("mp_matchend_music", 4);
    }

    player function_1d589506af8d2811();
    player.pers["map_restarted"] = 1;
    player.pers["pauseMenu_restart"] = result == "pauseMenu_restart" ? 1 : 0;
  }

  level notify("map_restarted");
  game["map_restarted"] = 1;
  map_restart(1);
  println("<dev string:x3c>");
}

function kill_em_all() {
  foreach(character in level.characters) {
    if(isPlayer(character)) {
      continue;
    }

    character scripts\cp_mp\agents\agent_utils::despawnagent();
  }
}

function players_want_to_restart(winner, endreasontextindex) {
  if(allow_players_to_restart(endreasontextindex)) {
    current_map = tolower(getDvar(@ "ui_mapname"));

    if(istrue(level.focus_test_mode) || scripts\cp\utility::is_raid_gamemode() || current_map == "cp_hostage") {
      return true;
    }

    level.retry_total_votes = 0;
    level.retry_yes_votes = 0;
    level.retry_timer = 0;
    level.retry_no_votes = 0;
    var_9cb0e2863a9ee57b = 0;

    foreach(player in level.players) {
      if(istestclient(player)) {
        var_9cb0e2863a9ee57b++;
        continue;
      }

      player thread display_retry_dialog(winner, endreasontextindex);
    }

    var_bbe675b048f3a784 = level.players.size - var_9cb0e2863a9ee57b;
    num_remaining = var_bbe675b048f3a784 - level.retry_total_votes;
    setomnvar("ui_votesys_time", 59);

    while(level.retry_total_votes < var_bbe675b048f3a784) {
      if(level.retry_no_votes != 0) {
        wait 1;
        return false;
      }

      if(level.gametype != "dungeons") {
        setomnvar("ui_votesys_time", 59 - int(level.retry_timer));

        if(level.retry_timer >= 59) {
          return false;
        }
      }

      vote_check = num_remaining;
      num_remaining = var_bbe675b048f3a784 - level.retry_total_votes;

      if(num_remaining != vote_check) {
        iprintlnbold("Waiting for " + num_remaining + " player's to vote");
      }

      wait 0.5;
      level.retry_timer += 0.5;
    }

    if(level.retry_yes_votes == var_bbe675b048f3a784 && level.retry_no_votes == 0) {
      wait 1;
      return true;
    }
  }

  return false;
}

function allow_players_to_restart(endreasontextindex) {
  if(isDefined(level.allow_players_to_restart)) {
    return [[level.allow_players_to_restart]](endreasontextindex);
  }

  return function_3a8fe76966b98424(endreasontextindex);
}

function function_3a8fe76966b98424(endreasontextindex) {
  var_b124cfb559178992 = [3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
  return scripts\engine\utility::array_contains(var_b124cfb559178992, endreasontextindex);
}

function display_retry_dialog(winner, var_3558c2912c0fad64) {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  scripts\cp\laststand::clear_last_stand_timer(self);
  wait 1;

  if(!isDefined(self.connectedpostgame) || !(self.pers["team"] == "spectator")) {
    team = self.pers["team"];

    if(!isDefined(team) || team != "allies" && team != "axis") {
      team = "allies";
    }

    if(isDefined(self.pers["team"]) && winner == team) {
      var_c8fc76edce2feb09 = get_end_game_string_index("win");
    } else {
      var_c8fc76edce2feb09 = get_end_game_string_index("fail");
    }

    if(isDefined(var_3558c2912c0fad64)) {
      self setclientomnvar("ui_round_end_reason", var_3558c2912c0fad64);
    }
  }

  setpostgamestate(9);
  vote = -1;

  while(true) {
    self waittill("luinotifyserver", msg);

    if(msg == "retry_level" || msg == "quit_level") {
      if(msg == "retry_level") {
        if(vote < 0) {
          level.retry_total_votes += 1;
          level.retry_yes_votes += 1;
          vote = 1;
          setomnvar("ui_votesys_player" + self getentitynumber(), 1);
          println("<dev string:x52>" + self getentitynumber());
        } else if(vote == 0) {
          level.retry_yes_votes += 1;
          vote = 1;
          setomnvar("ui_votesys_player" + self getentitynumber(), 1);
          println("<dev string:x52>" + self getentitynumber());
        }

        return;
      }

      if(msg == "quit_level") {
        setomnvar("ui_votesys_player" + self getentitynumber(), 2);
        level.retry_no_votes = 1;
      }

      return;
    }
  }
}

function clear_powers_hud() {
  if(isDefined(self.powers)) {
    foreach(power in getarraykeys(self.powers)) {
      adjustment = self.powers[power].charges * -1;

      if(isDefined(level.power_adjustcharges)) {
        self[[level.power_adjustcharges]](adjustment);
      }
    }
  }

  if(isDefined(level.powers_clearpower)) {
    self[[level.powers_clearpower]]("secondary");
    self[[level.powers_clearpower]]("primary");
  }
}

function get_end_condition(endreasontextindex) {
  switch (endreasontextindex) {
    case 1:
      return "win";
    case 2:
    case 3:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
      return "died";
    case 4:
      return "host_quit";
    default:
      assertmsg("Unknown endReasonTextIndex: " + endreasontextindex);
      break;
  }
}

function displaygameend(winner, endreasontextindex) {
  setomnvar("ui_match_over", 1);

  foreach(player in level.players) {
    if(isDefined(player.connectedpostgame) || player.pers["team"] == "spectator") {
      continue;
    }

    player thread outcomenotify(winner, endreasontextindex);
    player thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", winner);
  roundendwait(3, 1);
}

function outcomenotify(winner, var_3558c2912c0fad64) {
  self endon("disconnect");
  self notify("reset_outcome");
  team = self.pers["team"];

  if(!isDefined(team) || team != "allies" && team != "axis") {
    team = "allies";
  }

  while(scripts\cp\cp_hud_message::isdoingsplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && winner == team) {
    var_c8fc76edce2feb09 = get_end_game_string_index("win");
    self setplayerdata("cp", "CPSession", "hasCompletedLastMatch", 1);
  } else {
    var_c8fc76edce2feb09 = get_end_game_string_index("fail");
    self setplayerdata("cp", "CPSession", "hasCompletedLastMatch", 0);
  }

  self setclientomnvar("ui_round_end_title", var_c8fc76edce2feb09);

  if(isDefined(var_3558c2912c0fad64)) {
    self setclientomnvar("ui_round_end_reason", var_3558c2912c0fad64);
  }

  setpostgamestate(2);
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
  level.end_game_string_index["groundteamdead"] = 7;
  level.end_game_string_index["defender_alpha"] = 8;
  level.end_game_string_index["defender_beta"] = 9;
  level.end_game_string_index["defender_charlie"] = 10;
  level.end_game_string_index["enemy_bomb_exploded"] = 11;
  level.end_game_string_index["hostage_killed"] = 12;
  level.end_game_string_index["defender_delta"] = 13;
  level.end_game_string_index["defender_echo"] = 14;
  level.end_game_string_index["trap_gas_enraged"] = 15;
  level.end_game_string_index["hadir_escaped"] = 16;
  level.end_game_string_index["farah_killed"] = 17;
  level.end_game_string_index["civilian_killed"] = 18;
}

function get_end_game_string_index(key) {
  return level.end_game_string_index[key];
}

function roundendwait(defaultdelay, matchbonus) {
  notifiesdone = 0;

  while(!notifiesdone) {
    players = level.players;
    notifiesdone = 1;

    foreach(player in players) {
      if(!isDefined(player.doingsplash)) {
        continue;
      }

      if(!player scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      notifiesdone = 0;
    }

    wait 0.5;
  }

  if(!matchbonus) {
    wait defaultdelay;
    level notify("round_end_finished");
    return;
  }

  wait defaultdelay / 2;
  level notify("give_match_bonus");
  wait defaultdelay / 2;
  notifiesdone = 0;

  while(!notifiesdone) {
    players = level.players;
    notifiesdone = 1;

    foreach(player in players) {
      if(!isDefined(player.doingsplash)) {
        continue;
      }

      if(!player scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      notifiesdone = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}

function deathfx() {
  player = self;

  if(!isDefined(player.death)) {
    player.death = spawnStruct();
  }

  player.death.huds = [];
  blackfadetime = 3;
  blurfadetime = 5;

  if(istrue(player.skip_screen_fx)) {
    return;
  }

  if(!player scripts\cp_mp\utility\player_utility::playerbloodrestricted()) {
    visionsetpain("damage_dead", 0.2);
    player painvisionon();
    player thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  }

  player thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  player thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, blackfadetime, 20);
  wait 1;
  player setblurforplayer(6, blurfadetime);
}

function deathfxoverlay(name, shader, delay, fadetime, sort) {
  self endon("disconnect");
  wait delay;
  self.death.huds[name] = create_death_hudelem();
  self.death.huds[name] setshader(shader, 640, 480);

  if(fadetime > 0) {
    self.death.huds[name] fadeovertime(fadetime);
  }

  self.death.huds[name].alpha = 1;
  self.death.huds[name].sort = sort;
}

function create_death_hudelem() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.lowresbackground = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  overlay.enablehudlighting = 1;
  return overlay;
}

function function_a8a9d2fb0feaf8eb(objective_string) {
  if(!isDefined(level.var_646444267bcf2e45)) {
    level.var_646444267bcf2e45 = [];
  }

  level.var_646444267bcf2e45[level.var_646444267bcf2e45.size] = objective_string;
}

function function_1d10f2e8a8de2799(objective_string) {
  if(isDefined(level.var_646444267bcf2e45)) {
    temp_array = [];

    for(i = 0; i < level.var_646444267bcf2e45.size; i++) {
      if(objective_string == level.var_646444267bcf2e45[i]) {
        continue;
      }

      temp_array[temp_array.size] = level.var_646444267bcf2e45[i];
    }

    level.var_646444267bcf2e45 = temp_array;
  }
}

function function_180b06d3d67d483c(description_override) {
  description = "Failed";

  if(isDefined(description_override)) {
    description = description_override;
  }

  var_1a820516fd78ae03 = level.var_646444267bcf2e45;

  for(i = 0; i < var_1a820516fd78ae03.size; i++) {
    scripts\cp\cp_analytics::function_b6283ac45a607764(var_1a820516fd78ae03[i], description);
  }
}

function function_3167b5f4f0e8eb9e(var_379d26c8ac032e3d, condition) {
  level.var_661917db8151a820 = 1;
  videoname = function_862ffe99247b8ac5(var_379d26c8ac032e3d, condition);

  foreach(player in level.players) {
    player thread function_166b4e48c8756c40(videoname, var_379d26c8ac032e3d, condition);
  }

  scripts\engine\utility::flag_wait("endgame_bink_complete");
  level.var_661917db8151a820 = undefined;

  foreach(player in level.players) {
    player function_9d0952c80896f141();
    player scripts\cp\endgame::function_7f47e1420fd2b2a();
  }
}

function function_1a1f3c44edec248e() {
  switch (level.script) {
    case #"hash_5e656a0bf62ec176":
      return 119;
    case #"hash_e8510abc4b5e935c":
      return 136;
    case #"hash_1a6467aaad3208f1":
      return 66;
  }

  return 90;
}

function private function_166b4e48c8756c40(videoname, var_379d26c8ac032e3d, condition) {
  self endon("disconnect");
  scripts\cp\endgame::freezeplayerforroundend();
  thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 1, 1);
  scripts\cp\super::end_super_meter_progress_early();

  if(!isDefined(videoname)) {
    videoname = function_862ffe99247b8ac5(var_379d26c8ac032e3d, condition);
  }

  self.var_52d4cfb878cedd94 = 1;
  function_12ccccd25dafe834(videoname);

  if(istrue(level.var_ed5707896c1f5275)) {
    thread scripts\cp\globallogic::userskip_wait();
    result = scripts\engine\utility::waittill_any_return_2("userskipped", "endgame_bink_complete");

    if(result == "userskipped") {
      if(scripts\cp\utility::function_138028ca2b958511()) {
        scripts\cp\globallogic::votesys_new("vote_igc_skip", function_1a1f3c44edec248e());
        scripts\cp\globallogic::vote_player_set("vote_igc_skip", 1);
        var_a9b8fa5c0a14ad43 = scripts\engine\utility::waittill_any_return_3("voted_skip_bink", "bink_skip_failed", "release_players_from_skipped_state");

        if(var_a9b8fa5c0a14ad43 == "voted_skip_bink") {
          scripts\engine\utility::flag_set("endgame_bink_complete");
        }
      }

      function_64ac0fc15661a9c1();
    }

    scripts\cp\globallogic::userskip_stop();
    return;
  }

  scripts\engine\utility::ent_flag_wait("endgame_bink_complete");
}

function function_64ac0fc15661a9c1() {
  self setclientomnvar("ui_cp_bink_overlay_state", 0);
  self stopcinematicforplayer(1);
  scripts\engine\utility::ent_flag_set("endgame_bink_complete");
}

function function_9d0952c80896f141() {
  self.var_52d4cfb878cedd94 = undefined;
}

function function_482434e2ecb4a45() {
  while(istrue(self.var_52d4cfb878cedd94)) {
    waitframe();
  }
}

function function_a2f88a21031715b3() {
  foreach(player in level.players) {
    player function_482434e2ecb4a45();
  }
}

function function_862ffe99247b8ac5(var_379d26c8ac032e3d, condition) {
  if(istrue(var_379d26c8ac032e3d)) {
    if(condition == "SUCCESS") {
      return function_3b0bd187ad281276();
    }

    if(condition == "HOST QUIT") {
      return "mp_nukesequence_nighttime";
    }

    return "mp_dmz_load_screen";
  }

  return "mp_nukesequence_daytime";
}

function function_3b0bd187ad281276() {
  switch (level.script) {
    case #"hash_5e656a0bf62ec176":
      return "cp_raid1_cine_outro";
    case #"hash_e8510abc4b5e935c":
      return "cp_raid2_cine_outro";
    case #"hash_1a6467aaad3208f1":
      return "cp_raid3_cine_outro";
    case #"hash_1725f94e0ec2b5f2":
      return "cp_raid3_cine_outro";
    default:
      return "mp_nukesequence_nighttime";
  }
}

function private function_1b7e57bfe648f609(videoname) {
  if(!isDefined(videoname)) {
    return;
  }

  self preloadcinematicforplayer(videoname);
}

function private function_12ccccd25dafe834(videoname) {
  if(!isDefined(videoname)) {
    return;
  }

  self setplayermusicstate("");
  self playcinematicforplayer(videoname);
  self setclientomnvar("ui_cp_bink_overlay_state", 3);
}

function function_51a7fd1c0c6690f9(channel, val) {
  if(channel == "bink_complete") {
    if(isDefined(self.var_4b668a8cb58c3b0e) && self.var_4b668a8cb58c3b0e != 666) {
      return;
    }

    level notify("play_video_complete");
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self stopcinematicforplayer();
    scripts\engine\utility::ent_flag_set("endgame_bink_complete");
    scripts\engine\utility::flag_set("endgame_bink_complete");

    foreach(player in level.players) {
      player notify("release_players_from_skipped_state");
    }

    return;
  }

  if(channel == "skip_bink_input") {
    scripts\engine\utility::ent_flag_set("userskipped");
  }
}

function debug_test_next_mission() {
  version = getbuildversion();

  if(version == "SHIP") {
    return;
  }

  setdvarifuninitialized(@ "test_next_mission", 0);
  wait 10;

  while(getdvarint(@ "test_next_mission") < 1) {
    wait 3;
  }

  setDvar(@ "test_next_mission", 0);
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function progression_init() {
  missionsettings = createmission();
  level.missionsettings = missionsettings;
  level.lowestgameskill = getdvarint(@ "g_gameskill");
  nil = undefined;
  var_e55705af85d11cb9 = function_91d6763e1921a524();

  foreach(mapinfo in var_e55705af85d11cb9) {
    var_f9e628cf36da6985 = undefined;

    if(isDefined(mapinfo.var_f9e628cf36da6985)) {
      var_f9e628cf36da6985 = strtok(mapinfo.var_f9e628cf36da6985, ", ");
    }

    settletime = scripts\engine\utility::default_to(mapinfo.settletime, 10);
    clientsettletime = scripts\engine\utility::default_to(mapinfo.clientsettletime, 100);
    loadbink = mapinfo.var_dd5f1ceda1154582;
    addlevel(mapinfo.mapname, 0, nil, 1, nil, settletime, clientsettletime, nil, var_f9e628cf36da6985, 0, loadbink);
  }

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
  }

  if(scripts\cp\utility::function_240f7f4e57340e8f()) {
    thread startsavedprogression(level.script);
  }
}

function function_899bd4add25ddd3(channel, val) {
  if(channel == "bink_complete") {
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self stopcinematicforplayer(0);

    if(isDefined(self.var_4b668a8cb58c3b0e)) {
      ent_flag_set("intro_bink_complete_" + self.var_4b668a8cb58c3b0e);
    }

    foreach(player in level.players) {
      player notify("release_players_from_skipped_state");

      if(function_9b578c5917366e94("jup_global_igc_skip")) {
        player clearsoundsubmix("jup_global_igc_skip");
      }
    }

    return;
  }

  if(channel == "skip_bink_input") {
    ent_flag_set("userskipped");

    if(function_9b578c5917366e94("jup_global_igc_skip")) {
      level.player clearsoundsubmix("jup_global_igc_skip");
      clearmusicstate();
    }
  }
}

function function_f15beb5edf55a8e7() {
  blackfadetime = 3;
  blurfadetime = 5;
  level.players[0].death.huds = [];

  if(isDefined(level.players[0].death.skip_screen_fx)) {
    return;
  }

  if(utility::iswegameplatform()) {
    return;
  }

  level.players[0] scripts\cp\utility\player::remove_damage_effects_instantly(1);
  namespace_23750629c2b7a3d3::set_slowmo_dialogue_start();
  setslowmotion(1, 0.8, 4.5);
  thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, blackfadetime, 20);
  wait 1;
  level.players[0] setblurforplayer(6, blurfadetime);
}