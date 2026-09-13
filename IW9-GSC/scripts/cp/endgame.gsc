/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\endgame.gsc
***********************************************/

init() {
  _id_14609B809484646E::_id_8ECE37593311858A(::playerconnectwatcher);
  register_end_game_string_index();
}

playerconnectwatcher() {
  if(isDefined(level.postgamestate)) {
    self setclientomnvar("post_game_state", level.postgamestate);

    if(isDefined(self.pers["team"]) && level.winner == self.pers["team"])
      _id_C8FC76EDCE2FEB09 = get_end_game_string_index("win");
    else
      _id_C8FC76EDCE2FEB09 = get_end_game_string_index("fail");

    self setclientomnvar("ui_round_end_title", _id_C8FC76EDCE2FEB09);
  }
}

setpostgamestate(state) {
  level.postgamestate = state;
  setomnvarforallclients("post_game_state", state);
}

_id_1D589506AF8D2811() {
  if(!isDefined(self.pers))
    self.pers = [];

  self.pers["restarted"] = 1;
}

_id_936FCCB404737EEF() {
  foreach(player in level.players) {
    if(isDefined(player.pers) && istrue(player.pers["restarted"]))
      player.pers["restarted"] = undefined;
  }
}

endgame(winner, _id_1379934A423852EF) {
  if(gamealreadyended()) {
    return;
  }
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    if(isDefined(game["checkpoint_attempts"]) && isDefined(game["checkpoint_attempts"][checkpoint]))
      game["checkpoint_attempts"][checkpoint]++;
  }

  result = "FAIL";

  switch (_id_1379934A423852EF) {
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

  markgameended();
  _id_04CDABCD91A92977::_id_4064A2271DE12B97();
  level thread _id_180B06D3D67D483C();
  _id_7A34D05C87DE4D53 = _id_0998572FF3C96EE5::_id_399CCFE790A8B2EB();

  if(isDefined(_id_7A34D05C87DE4D53) && _id_7A34D05C87DE4D53 != "") {
    value = int(tablelookup("cp/missionsbesttimes.csv", 0, _id_7A34D05C87DE4D53, 1));
    setomnvar("ui_so_iwbest", value);
  }

  foreach(player in level.players) {
    player notify("showing_final_killcam");
    player notify("stealth_disabled");

    if(istrue(player isparachuting()) || istrue(player isskydiving()))
      player skydive_interrupt();

    player thread _id_0AFB7E332AEE4BF2::hide_all_revive_icons(player);
    player setclientomnvar("ui_securing_progress", 0);
    player setclientomnvar("ui_securing", 0);
    player clearsoundsubmix("deaths_door_mp", 1);
    player setsoundsubmix("cp_matchend", 2);

    if(_id_1379934A423852EF == 3)
      player thread deathfx();
  }

  if(isDefined(level.intel_headicons)) {
    foreach(headicon in level.intel_headicons)
    deleteheadicon(headicon);

    level.intel_headicons = [];
  }

  setDvar("dvar_DB88B998734440CC", "");
  setDvar("dvar_E6D511D33E0FE486", 0);
  setnojiptime(1);
  level notify("game_ended", winner);
  freezeallplayers(1.0, "cg_fovScale", 1);
  _id_10D864DD73F88213 = tolower(getDvar("ui_mapname"));

  foreach(player in level.players) {
    if(isDefined(level.gametype) && level.gametype != "incursion") {
      player setplayerdata("common", "round", "gameMode", level.gametype);
      player setplayerdata("common", "round", "map", _id_10D864DD73F88213);
    }
  }

  if(_id_1379934A423852EF == 3)
    wait 1;

  splitscreen = 0;

  switch (_id_1379934A423852EF) {
    case 1:
      _id_187A04151C40FB72::rankedmatchupdates("allies");
      break;
    case 4:
      _id_187A04151C40FB72::rankedmatchupdates("axis");
      break;
    default:
      _id_187A04151C40FB72::rankedmatchupdates("axis");
      break;
  }

  if(isDefined(level.pre_map_restart_func))
    [[level.pre_map_restart_func]](result);

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  level.ingraceperiod = 0;
  setomnvar("allow_server_pause", 0);

  foreach(player in level.players)
  player setclientdvar("ui_opensummary", 1);

  waitframe();
  scripts\cp\utility::_id_2C08BE5ADB8B60F4();
  setomnvar("zm_time_survived", level.time_survived);

  if(isDefined(level.eogscoringtable)) {}

  setpostgamestate(1);
  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("bg_compassShowEnemies", 0);
  setDvar("scr_gameended", 1);
  setgameendtime(0);
  setslowmotion(1, 1, 0);

  foreach(player in level.players) {
    cleanup_player_on_game_end(player);
    player _id_2AFB89230A848A3C(result);
  }

  if(result == "SUCCESS")
    _id_1E22D314CC16F807::_id_0F601F9FACF5F2C1();

  setpostgamestate(0);
  level.winner = winner;
  displaygameend(winner, _id_1379934A423852EF);
  _id_B39D508145FF6B20 = should_load_new_map(_id_1379934A423852EF);

  if(isDefined(_id_B39D508145FF6B20)) {
    if(isDefined(level.load_new_map_func))
      [[level.load_new_map_func]](_id_1379934A423852EF);

    load_new_map(_id_B39D508145FF6B20);
    return;
  } else if(players_want_to_restart(winner, _id_1379934A423852EF)) {
    _id_1E22D314CC16F807::_id_578C2B4D51D13B9A();
    _id_4681153436825797 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(!isDefined(_id_4681153436825797) || _id_4681153436825797 == "")
      game["star_rewards_times"] = undefined;

    _id_C8FC76EDCE2FEB09 = get_end_game_string_index("restarting");

    foreach(player in level.players) {
      player setclientomnvar("ui_round_end_title", _id_C8FC76EDCE2FEB09);

      if(!level._id_F44EAC8D457AA051) {
        player.pers["loadout"] = undefined;
        player.pers["equipment"] = undefined;
      }
    }

    wait 1.0;
    restart_map(undefined, result);
    return;
  } else {
    _id_C8FC76EDCE2FEB09 = get_end_game_string_index("exiting");

    foreach(player in level.players)
    player setclientomnvar("ui_round_end_title", _id_C8FC76EDCE2FEB09);
  }

  _id_116171939929AF39::_id_EA9FC8F6656867D7();

  foreach(player in level.players) {
    if(scripts\cp\utility::matchmakinggame() && (result == "SUCCESS" || result == "FAIL"))
      player scripts\cp_mp\utility\game_utility::stopkeyearning(result);

    _id_9C571F8C5058B16E = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("downs");
    _id_708B0E4925A97D80 = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("revives");
    _id_DB24F499F4608B0D = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("kills");
    setclientmatchdata("player", player.clientid, "xuidHigh", player getxuidhigh());
    setclientmatchdata("player", player.clientid, "xuidLow", player getxuidlow());
    setclientmatchdata("player", player.clientid, "zombie_death", _id_DB24F499F4608B0D);
    setclientmatchdata("player", player.clientid, "dropped_to_last_stand", _id_9C571F8C5058B16E);
    setclientmatchdata("player", player.clientid, "revived_another_player", _id_708B0E4925A97D80);

    if(isDefined(player.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      _id_00AE17C5A8B1BC1B = player _id_187A04151C40FB72::getrank();
      setclientmatchdata("player", player.clientid, "rank", _id_00AE17C5A8B1BC1B);
    }

    if(isDefined(player.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      _id_C52868E86C820DE4 = player _id_187A04151C40FB72::getprestigelevel();
      setclientmatchdata("player", player.clientid, "prestige", _id_C52868E86C820DE4);
    }

    if(player isps4player())
      setclientmatchdata("player", player.clientid, "platform", "ps4");
    else if(player isxb3player())
      setclientmatchdata("player", player.clientid, "platform", "xb3");
    else if(player ispcplayer())
      setclientmatchdata("player", player.clientid, "platform", "bnet");
    else
      setclientmatchdata("player", player.clientid, "platform", "none");

    player scripts\cp\cp_matchdata::logplayerdata(result);
  }

  setDvar("dvar_9138AFE32459DDB3", 0);
  setDvar("dvar_C9ECF9B70BF071C8", 0);
  _id_116171939929AF39::reset_map_dvars();
  setDvar("dvar_F2A4B47C16A549B3", "");

  if(isDefined(level.pre_end_game_display_func))
    [[level.pre_end_game_display_func]]();

  _id_BEBA97D4D0A18C9C = get_end_condition(_id_1379934A423852EF);
  _id_2C2BCE30DE469AE1 = get_play_time();
  scripts\cp\cp_analytics::endgame(_id_BEBA97D4D0A18C9C, _id_2C2BCE30DE469AE1);
  _id_5814D27874B48E54 = spawnStruct();
  _id_5814D27874B48E54.result = result;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_match_end", _id_5814D27874B48E54);
  reset_players_subparty_data();
  wait 1;
  _id_D6A0A72D985E3414 = level.intermissionfunc;

  if(isDefined(level.custom_intermission_func))
    _id_D6A0A72D985E3414 = level.custom_intermission_func;

  _id_1E22D314CC16F807::_id_578C2B4D51D13B9A();
  wait 0.5;

  foreach(player in level.players)
  player thread[[_id_D6A0A72D985E3414]](_id_1379934A423852EF);

  if(getdvarint("dvar_AD0B067F443D7F4F")) {
    restart_map(undefined, result);
    return;
  }

  level notify("exitLevel_called");
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_server_exit_level");
  exitlevel(0);
}

_id_8CF553A1A6826B6C() {
  player = self;
  name = player.name;
  _id_DB24F499F4608B0D = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("kills");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Kills", "count", _id_DB24F499F4608B0D, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::_id_512417BDDBE63792(), "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E()]);
  _id_9C571F8C5058B16E = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("downs");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Last Stands", "count", _id_9C571F8C5058B16E, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::_id_512417BDDBE63792(), "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E()]);
  _id_708B0E4925A97D80 = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("revives");
  player dlog_recordplayerevent("dlog_event_cpdata_plr_eog", ["levelname", level.script, "name", name, "stat_type", "Revives", "count", _id_708B0E4925A97D80, "description", "Game Ended", "sharedaccount_uid", player scripts\cp\cp_analytics::_id_512417BDDBE63792(), "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E()]);
  return [_id_DB24F499F4608B0D, _id_9C571F8C5058B16E, _id_708B0E4925A97D80];
}

_id_2AFB89230A848A3C(result) {
  player = self;
  [_id_DB24F499F4608B0D, _id_9C571F8C5058B16E, _id_708B0E4925A97D80] = player _id_8CF553A1A6826B6C();
  setclientmatchdata("player", player.clientid, "xuidHigh", player getxuidhigh());
  setclientmatchdata("player", player.clientid, "xuidLow", player getxuidlow());
  setclientmatchdata("player", player.clientid, "zombie_death", _id_DB24F499F4608B0D);
  setclientmatchdata("player", player.clientid, "dropped_to_last_stand", _id_9C571F8C5058B16E);
  setclientmatchdata("player", player.clientid, "revived_another_player", _id_708B0E4925A97D80);

  if(isDefined(player.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
    _id_00AE17C5A8B1BC1B = player _id_187A04151C40FB72::getrank();
    setclientmatchdata("player", player.clientid, "rank", _id_00AE17C5A8B1BC1B);
  }

  if(isDefined(player.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
    _id_C52868E86C820DE4 = player _id_187A04151C40FB72::getprestigelevel();
    setclientmatchdata("player", player.clientid, "prestige", _id_C52868E86C820DE4);
  }

  if(player isps4player())
    setclientmatchdata("player", player.clientid, "platform", "ps4");
  else if(player isxb3player())
    setclientmatchdata("player", player.clientid, "platform", "xb3");
  else if(player ispcplayer())
    setclientmatchdata("player", player.clientid, "platform", "bnet");
  else
    setclientmatchdata("player", player.clientid, "platform", "none");

  player scripts\cp\cp_matchdata::logplayerdata(result);
}

reset_players_subparty_data() {
  foreach(player in level.players)
  player setplayerdata("cp", "CPSession", "subParty", -1);
}

forceendgame() {
  level thread endgame("axis", get_end_game_string_index("host_end"));
}

_id_74D2CA228D4852D6() {
  level thread endgame("allies", get_end_game_string_index("win"));
}

markgameended() {
  game["state"] = "postgame";
  level.gameended = 1;
}

gamealreadyended() {
  return game["state"] == "postgame" || level.gameended;
}

freezeallplayers(delay, _id_8C7CA5DE1B4ED9A8, _id_7E99EC33D27A716E) {
  if(!isDefined(delay))
    delay = 0;

  foreach(player in level.players) {
    player thread freezeplayerforroundend(delay);
    player thread roundenddof(4.0);
    player freegameplayhudelems();
    player setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(_id_8C7CA5DE1B4ED9A8) && isDefined(_id_7E99EC33D27A716E))
      player setclientdvars(_id_8C7CA5DE1B4ED9A8, _id_7E99EC33D27A716E);
  }

  foreach(agent in level.agentarray)
  agent scripts\cp\utility::freezecontrolswrapper(1);
}

freezeplayerforroundend(delay) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(delay))
    delay = level.framedurationseconds;

  wait(delay);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 0);
  scripts\cp\utility::_id_4CBAED764C116A25(1);

  if(self isonground() || self isonladder())
    self allowmovement(0);
  else
    thread gameendfreezemovement();
}

gameendfreezemovement() {
  _id_8A5D258252579930 = 0.0;

  while(_id_8A5D258252579930 < 1) {
    if(!self isonground())
      _id_8A5D258252579930 = _id_8A5D258252579930 + level.framedurationseconds;
    else {
      self allowmovement(0);
      break;
    }

    wait(level.framedurationseconds);
  }

  self allowmovement(0);
}

_id_5E7F66A5F2064CF1() {
  _id_8A5D258252579930 = 0.0;

  while(_id_8A5D258252579930 < 1) {
    if(!self isonground())
      _id_8A5D258252579930 = _id_8A5D258252579930 + level.framedurationseconds;
    else {
      self allowmovement(1);
      break;
    }

    wait(level.framedurationseconds);
  }

  self allowmovement(1);
}

_id_07F47E1420FD2B2A(delay) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(delay))
    delay = level.framedurationseconds;

  wait(delay);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 1);

  if(self isonground() || self isonladder())
    self allowmovement(1);
  else
    thread _id_5E7F66A5F2064CF1();

  scripts\cp\utility::_id_4CBAED764C116A25(0);
}

roundenddof(time) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

get_play_time() {
  _id_F5CA237F98FB4CF6 = 0;

  if(isDefined(level.starttime))
    _id_F5CA237F98FB4CF6 = gettime() - level.starttime;

  return _id_F5CA237F98FB4CF6;
}

freegameplayhudelems() {
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

  if(isDefined(self.proxbar))
    self.proxbar scripts\cp\utility::destroyelem();

  if(isDefined(self.proxbartext))
    self.proxbartext scripts\cp\utility::destroyelem();
}

cleanup_player_on_game_end(player) {
  player notify("select_mode");
  player notify("reset_outcome");
  player.pers["stats"] = player.stats;
  player scripts\cp\utility::allow_player_ignore_me(1);
  player _id_3BCAA2CBAF54ABDD::set_player_currency(0);
  player scripts\cp\utility::clearlowermessages();

  if(isDefined(player.consumables_equipped))
    player.consumables_equipped = [];

  player clear_powers_hud();
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
}

should_load_new_map(index) {
  if((index == 1 || index == 2) && getDvar("ui_mapname") == "cp_jackal_ass")
    return "cp_titan";

  return undefined;
}

load_new_map(_id_DDAC31817B064B95) {
  kill_em_all();
  level scripts\engine\utility::waittill_any_timeout_1(15, "intermission_over");
  setDvar("ui_mapname", _id_DDAC31817B064B95);
  setDvar("g_gametype", "aliens");
  _id_CF75101FA0F3C9DD = "map " + _id_DDAC31817B064B95;
}

restart_map(delay, result) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_match_in_progress", 0);
    level.players[_id_AC0E594AC96AA3A8] clearsoundsubmix("player_swimming_underwater", 0);
    level.players[_id_AC0E594AC96AA3A8] clearsoundsubmix("iw9_player_drowning", 0);
    level.players[_id_AC0E594AC96AA3A8] clearsoundsubmix("iw9_underwater_vo", 0);
    level.players[_id_AC0E594AC96AA3A8] clearclienttriggeraudiozone(0);
    level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_hide_hud", 1);

    if(!isDefined(result))
      result = "";

    if(scripts\cp\utility::matchmakinggame() && (result == "SUCCESS" || result == "FAIL"))
      level.players[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::stopkeyearning(result);

    _id_9C571F8C5058B16E = level.players[_id_AC0E594AC96AA3A8] getplayerdata("cp", "alienSession", "downed");
    _id_708B0E4925A97D80 = level.players[_id_AC0E594AC96AA3A8] getplayerdata("cp", "alienSession", "revives");
    _id_DB24F499F4608B0D = level.players[_id_AC0E594AC96AA3A8] getplayerdata("cp", "alienSession", "kills");
    setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "xuidHigh", level.players[_id_AC0E594AC96AA3A8] getxuidhigh());
    setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "xuidLow", level.players[_id_AC0E594AC96AA3A8] getxuidlow());
    setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "zombie_death", _id_DB24F499F4608B0D);
    setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "dropped_to_last_stand", _id_9C571F8C5058B16E);
    setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "revived_another_player", _id_708B0E4925A97D80);

    if(isDefined(level.players[_id_AC0E594AC96AA3A8].pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      _id_00AE17C5A8B1BC1B = level.players[_id_AC0E594AC96AA3A8] _id_187A04151C40FB72::getrank();
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "rank", _id_00AE17C5A8B1BC1B);
    }

    if(isDefined(level.players[_id_AC0E594AC96AA3A8].pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      _id_C52868E86C820DE4 = level.players[_id_AC0E594AC96AA3A8] _id_187A04151C40FB72::getprestigelevel();
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "prestige", _id_C52868E86C820DE4);
    }

    if(level.players[_id_AC0E594AC96AA3A8] isps4player())
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "platform", "ps4");
    else if(level.players[_id_AC0E594AC96AA3A8] isxb3player())
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "platform", "xb3");
    else if(level.players[_id_AC0E594AC96AA3A8] ispcplayer())
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "platform", "bnet");
    else
      setclientmatchdata("player", level.players[_id_AC0E594AC96AA3A8].clientid, "platform", "none");

    level.players[_id_AC0E594AC96AA3A8] scripts\cp\cp_matchdata::logplayerdata(result);
  }

  kill_em_all();
  setomnvar("allow_server_pause", 1);
  setpostgamestate(0);
  setomnvarforallclients("reset_wave_loadout", 1);

  if(!isDefined(delay))
    delay = 3;

  for(_id_AC0E594AC96AA3A8 = delay; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--)
    wait 1;

  foreach(player in level.players) {
    player clearsoundsubmix("cp_matchend", 4);
    player clearsoundsubmix("mp_matchend_music", 4);
    player _id_1D589506AF8D2811();
  }

  level notify("map_restarted");
  game["map_restarted"] = 1;
  map_restart(1);
}

kill_em_all() {
  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(isPlayer(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(isagent(_id_7DC3241E7F3C6B24)) {
      _id_7DC3241E7F3C6B24.nocorpse = 1;
      _id_7DC3241E7F3C6B24.diequietly = 1;
      _id_7DC3241E7F3C6B24._id_D0E9753B09126417 = undefined;
      _id_7DC3241E7F3C6B24._id_AD799295A6692B29 = 1;

      if(isalive(_id_7DC3241E7F3C6B24) && isDefined(_id_7DC3241E7F3C6B24.magic_bullet_shield))
        _id_7DC3241E7F3C6B24 scripts\common\ai::stop_magic_bullet_shield();

      _id_7DC3241E7F3C6B24 _id_18A73A64992DD07D::script_kill_ai(0);
      continue;
    }

    _id_7DC3241E7F3C6B24 dodamage(100000, _id_7DC3241E7F3C6B24.origin);
  }
}

players_want_to_restart(winner, _id_1379934A423852EF) {
  if(allow_players_to_restart(_id_1379934A423852EF)) {
    _id_10D864DD73F88213 = tolower(getDvar("ui_mapname"));

    if(istrue(level.focus_test_mode) || scripts\cp\utility::is_raid_gamemode() || _id_10D864DD73F88213 == "cp_hostage")
      return 1;

    level.retry_total_votes = 0;
    level.retry_yes_votes = 0;
    level.retry_timer = 0;
    level.retry_no_votes = 0;
    _id_9CB0E2863A9EE57B = 0;

    foreach(player in level.players) {
      if(istestclient(player)) {
        _id_9CB0E2863A9EE57B++;
        continue;
      }

      player thread display_retry_dialog(winner, _id_1379934A423852EF);
    }

    _id_BBE675B048F3A784 = level.players.size - _id_9CB0E2863A9EE57B;

    for(_id_4BB2514C37C4F07C = _id_BBE675B048F3A784 - level.retry_total_votes; level.retry_total_votes < _id_BBE675B048F3A784; level.retry_timer = level.retry_timer + 0.5) {
      if(level.retry_no_votes != 0) {
        wait 1.0;
        return 0;
      }

      setomnvar("ui_votesys_time", 59 - int(level.retry_timer));

      if(level.retry_timer >= 59)
        return 0;

      _id_82CF67BC4BE60D2A = _id_4BB2514C37C4F07C;
      _id_4BB2514C37C4F07C = _id_BBE675B048F3A784 - level.retry_total_votes;

      if(_id_4BB2514C37C4F07C != _id_82CF67BC4BE60D2A)
        iprintlnbold("Waiting for " + _id_4BB2514C37C4F07C + " player's to vote");

      wait 0.5;
    }

    if(level.retry_yes_votes == _id_BBE675B048F3A784 && level.retry_no_votes == 0) {
      wait 1.0;
      return 1;
    }
  }

  return 0;
}

allow_players_to_restart(_id_1379934A423852EF) {
  if(isDefined(level.allow_players_to_restart))
    return [[level.allow_players_to_restart]](_id_1379934A423852EF);
  else
    return _id_3A8FE76966B98424(_id_1379934A423852EF);
}

_id_3A8FE76966B98424(_id_1379934A423852EF) {
  _id_B124CFB559178992 = [3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
  return scripts\engine\utility::array_contains(_id_B124CFB559178992, _id_1379934A423852EF);
}

display_retry_dialog(winner, _id_3558C2912C0FAD64) {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  _id_0AFB7E332AEE4BF2::clear_last_stand_timer(self);
  wait 1.0;

  if(!isDefined(self.connectedpostgame) || !(self.pers["team"] == "spectator")) {
    team = self.pers["team"];

    if(!isDefined(team) || team != "allies" && team != "axis")
      team = "allies";

    if(isDefined(self.pers["team"]) && winner == team)
      _id_C8FC76EDCE2FEB09 = get_end_game_string_index("win");
    else
      _id_C8FC76EDCE2FEB09 = get_end_game_string_index("fail");

    if(isDefined(_id_3558C2912C0FAD64))
      self setclientomnvar("ui_round_end_reason", _id_3558C2912C0FAD64);
  }

  setpostgamestate(9);
  vote = -1;

  for(;;) {
    self waittill("luinotifyserver", msg);

    if(msg == "retry_level" || msg == "quit_level") {
      if(msg == "retry_level") {
        if(vote < 0) {
          level.retry_total_votes = level.retry_total_votes + 1;
          level.retry_yes_votes = level.retry_yes_votes + 1;
          vote = 1;
          setomnvar("ui_votesys_player" + self getentitynumber(), 1);
        } else if(vote == 0) {
          level.retry_yes_votes = level.retry_yes_votes + 1;
          vote = 1;
          setomnvar("ui_votesys_player" + self getentitynumber(), 1);
        }
      } else if(msg == "quit_level") {
        setomnvar("ui_votesys_player" + self getentitynumber(), 2);
        level.retry_no_votes = 1;
      }

      return;
    }
  }
}

clear_powers_hud() {
  if(isDefined(self.powers)) {
    foreach(power in getarraykeys(self.powers)) {
      _id_BB3A4ED149FCAF82 = self.powers[power].charges * -1;

      if(isDefined(level.power_adjustcharges))
        self[[level.power_adjustcharges]](_id_BB3A4ED149FCAF82);
    }
  }

  if(isDefined(level.powers_clearpower)) {
    self[[level.powers_clearpower]]("secondary");
    self[[level.powers_clearpower]]("primary");
  }
}

get_end_condition(_id_1379934A423852EF) {
  switch (_id_1379934A423852EF) {
    case 1:
      return "win";
    case 19:
    case 18:
    case 17:
    case 16:
    case 15:
    case 14:
    case 13:
    case 12:
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
    case 3:
    case 2:
      return "died";
    case 4:
      return "host_quit";
    default:
  }
}

displaygameend(winner, _id_1379934A423852EF) {
  setomnvar("ui_match_over", 1);

  foreach(player in level.players) {
    if(isDefined(player.connectedpostgame) || player.pers["team"] == "spectator") {
      continue;
    }
    player thread outcomenotify(winner, _id_1379934A423852EF);
    player thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", winner);
  roundendwait(3.0, 1);
}

outcomenotify(winner, _id_3558C2912C0FAD64) {
  self endon("disconnect");
  self notify("reset_outcome");
  team = self.pers["team"];

  if(!isDefined(team) || team != "allies" && team != "axis")
    team = "allies";

  while(scripts\cp\cp_hud_message::isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && winner == team) {
    _id_C8FC76EDCE2FEB09 = get_end_game_string_index("win");
    self setplayerdata("cp", "CPSession", "hasCompletedLastMatch", 1);
  } else {
    _id_C8FC76EDCE2FEB09 = get_end_game_string_index("fail");
    self setplayerdata("cp", "CPSession", "hasCompletedLastMatch", 0);
  }

  self setclientomnvar("ui_round_end_title", _id_C8FC76EDCE2FEB09);

  if(isDefined(_id_3558C2912C0FAD64))
    self setclientomnvar("ui_round_end_reason", _id_3558C2912C0FAD64);

  setpostgamestate(2);
}

register_end_game_string_index() {
  if(isDefined(level.end_game_string_override))
    [[level.end_game_string_override]]();
  else
    register_default_end_game_string_index();
}

register_default_end_game_string_index() {
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
  level.end_game_string_index["op_room_player_killed"] = 18;
  level.end_game_string_index["maze_players_killed"] = 19;
}

get_end_game_string_index(key) {
  return level.end_game_string_index[key];
}

roundendwait(_id_5EF4D54BB701E295, matchbonus) {
  _id_E41A0047B2421A2C = 0;

  while(!_id_E41A0047B2421A2C) {
    players = level.players;
    _id_E41A0047B2421A2C = 1;

    foreach(player in players) {
      if(!isDefined(player.doingsplash)) {
        continue;
      }
      if(!player scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      _id_E41A0047B2421A2C = 0;
    }

    wait 0.5;
  }

  if(!matchbonus) {
    wait(_id_5EF4D54BB701E295);
    level notify("round_end_finished");
    return;
  }

  wait(_id_5EF4D54BB701E295 / 2);
  level notify("give_match_bonus");
  wait(_id_5EF4D54BB701E295 / 2);
  _id_E41A0047B2421A2C = 0;

  while(!_id_E41A0047B2421A2C) {
    players = level.players;
    _id_E41A0047B2421A2C = 1;

    foreach(player in players) {
      if(!isDefined(player.doingsplash)) {
        continue;
      }
      if(!player scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      _id_E41A0047B2421A2C = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}

deathfx() {
  player = self;
  player.death = spawnStruct();
  player.death.huds = [];
  _id_00CA20019EE673FF = 3.0;
  _id_411F1D6833233BC3 = 5;

  if(istrue(player.skip_screen_fx)) {
    return;
  }
  if(!player scripts\cp_mp\utility\player_utility::playerbloodrestricted()) {
    visionsetpain("damage_dead", 0.2);
    player painvisionon();
    player thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  }

  player thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  player thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, _id_00CA20019EE673FF, 20);
  wait 1;
  player setblurforplayer(6, _id_411F1D6833233BC3);
}

deathfxoverlay(name, shader, delay, _id_F69BA8D7B96E8326, sort) {
  self endon("disconnect");
  wait(delay);
  self.death.huds[name] = create_death_hudelem();
  self.death.huds[name] setshader(shader, 640, 480);

  if(_id_F69BA8D7B96E8326 > 0)
    self.death.huds[name] fadeovertime(_id_F69BA8D7B96E8326);

  self.death.huds[name].alpha = 1;
  self.death.huds[name].sort = sort;
}

create_death_hudelem() {
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

_id_A8A9D2FB0FEAF8EB(_id_256D0E44EE22C83C) {
  if(!isDefined(level._id_646444267BCF2E45))
    level._id_646444267BCF2E45 = [];

  level._id_646444267BCF2E45[level._id_646444267BCF2E45.size] = _id_256D0E44EE22C83C;
}

_id_1D10F2E8A8DE2799(_id_256D0E44EE22C83C) {
  if(isDefined(level._id_646444267BCF2E45)) {
    _id_6D906809844C7CB1 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_646444267BCF2E45.size; _id_AC0E594AC96AA3A8++) {
      if(_id_256D0E44EE22C83C == level._id_646444267BCF2E45[_id_AC0E594AC96AA3A8]) {
        continue;
      }
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = level._id_646444267BCF2E45[_id_AC0E594AC96AA3A8];
    }

    level._id_646444267BCF2E45 = _id_6D906809844C7CB1;
  }
}

_id_180B06D3D67D483C(_id_9F1A28D4CBE0A89E) {
  description = "Failed";

  if(isDefined(_id_9F1A28D4CBE0A89E))
    description = _id_9F1A28D4CBE0A89E;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_646444267BCF2E45.size; _id_AC0E594AC96AA3A8++)
    scripts\cp\cp_analytics::_id_B6283AC45A607764(level._id_646444267BCF2E45[_id_AC0E594AC96AA3A8], description);
}

_id_3167B5F4F0E8EB9E(_id_379D26C8AC032E3D, _id_46260B6EEE9C6E62) {
  level._id_661917DB8151A820 = 1;

  if(!scripts\engine\utility::array_contains(level._id_F897D54E1C59990C, self))
    level._id_F897D54E1C59990C = scripts\engine\utility::array_add(level._id_F897D54E1C59990C, self);

  _id_4F105563CA74CF73 = _id_862FFE99247B8AC5(_id_379D26C8AC032E3D, _id_46260B6EEE9C6E62);

  foreach(player in level.players)
  player thread _id_166B4E48C8756C40(_id_4F105563CA74CF73, _id_379D26C8AC032E3D, _id_46260B6EEE9C6E62);

  scripts\engine\utility::flag_wait("endgame_bink_complete");
  level._id_661917DB8151A820 = undefined;

  foreach(player in level.players) {
    level._id_F897D54E1C59990C = scripts\engine\utility::array_remove(level._id_F897D54E1C59990C, player);
    player _id_9D0952C80896F141();
    player _id_07F47E1420FD2B2A();
  }
}

_id_1A1F3C44EDEC248E() {
  switch (level.script) {
    case "cp_raid1":
      return 119;
    case "cp_raid1_trap":
      return 136;
    case "cp_raid1_boss1":
      return 66;
    case "cp_jugg_maze":
      return 151;
  }

  return 90;
}

_id_166B4E48C8756C40(_id_4F105563CA74CF73, _id_379D26C8AC032E3D, _id_46260B6EEE9C6E62) {
  self endon("disconnect");
  freezeplayerforroundend();
  thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 1, 1);
  _id_56EF8D52FE1B48A1::end_super_meter_progress_early();
  level._id_BBEEFAD58B75989A = 1;

  if(!isDefined(_id_4F105563CA74CF73))
    _id_4F105563CA74CF73 = _id_862FFE99247B8AC5(_id_379D26C8AC032E3D, _id_46260B6EEE9C6E62);

  self._id_52D4CFB878CEDD94 = 1;
  _id_12CCCCD25DAFE834(_id_4F105563CA74CF73);

  if(istrue(level._id_ED5707896C1F5275)) {
    thread _id_0598E0C00C8151F7::userskip_wait();
    result = scripts\engine\utility::waittill_any_return_2("userskipped", "endgame_bink_complete");

    if(result == "userskipped") {
      if(scripts\cp\utility::_id_138028CA2B958511()) {
        _id_0598E0C00C8151F7::votesys_new("vote_igc_skip", _id_1A1F3C44EDEC248E());
        _id_0598E0C00C8151F7::vote_player_set("vote_igc_skip", 1);
        _id_A9B8FA5C0A14AD43 = scripts\engine\utility::waittill_any_return_3("voted_skip_bink", "bink_skip_failed", "release_players_from_skipped_state");

        if(_id_A9B8FA5C0A14AD43 == "voted_skip_bink")
          scripts\engine\utility::flag_set("endgame_bink_complete");
      }

      _id_64AC0FC15661A9C1();
    }

    _id_0598E0C00C8151F7::userskip_stop();
  } else
    scripts\engine\utility::ent_flag_wait("endgame_bink_complete");
}

_id_64AC0FC15661A9C1() {
  self setclientomnvar("ui_cp_bink_overlay_state", 0);
  self stopcinematicforplayer(1);
  scripts\engine\utility::ent_flag_set("endgame_bink_complete");
}

_id_9D0952C80896F141() {
  self._id_52D4CFB878CEDD94 = undefined;
}

_id_0482434E2ECB4A45() {
  while(istrue(self._id_52D4CFB878CEDD94))
    waitframe();
}

_id_A2F88A21031715B3() {
  foreach(player in level.players)
  player _id_0482434E2ECB4A45();
}

_id_862FFE99247B8AC5(_id_379D26C8AC032E3D, _id_46260B6EEE9C6E62) {
  if(istrue(_id_379D26C8AC032E3D)) {
    if(_id_46260B6EEE9C6E62 == "SUCCESS")
      return _id_3B0BD187AD281276();

    if(_id_46260B6EEE9C6E62 == "HOST QUIT")
      return "mp_nukesequence_nighttime";

    return "mp_dmz_load_screen";
  }

  return "mp_nukesequence_daytime";
}

_id_3B0BD187AD281276() {
  switch (level.script) {
    case "cp_raid1":
      return "cp_raid1_cine_outro";
    case "cp_raid1_trap":
      return "cp_raid2_cine_outro";
    case "cp_raid1_boss1":
      return "cp_raid3_cine_outro";
    case "cp_jugg_maze":
      return "cp_raid4_cine_outro";
    default:
      return "mp_nukesequence_nighttime";
  }
}

_id_1B7E57BFE648F609(_id_4F105563CA74CF73) {
  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self preloadcinematicforplayer(_id_4F105563CA74CF73);
}

_id_12CCCCD25DAFE834(_id_4F105563CA74CF73) {
  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self setplayermusicstate("");
  self playcinematicforplayer(_id_4F105563CA74CF73);
  self setclientomnvar("ui_cp_bink_overlay_state", 3);
}

_id_51A7FD1C0C6690F9(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete") {
    if(isDefined(self._id_4B668A8CB58C3B0E) && self._id_4B668A8CB58C3B0E != 666) {
      return;
    }
    level notify("play_video_complete");
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self stopcinematicforplayer();
    scripts\engine\utility::ent_flag_set("endgame_bink_complete");
    scripts\engine\utility::flag_set("endgame_bink_complete");

    foreach(player in level.players)
    player notify("release_players_from_skipped_state");
  } else if(_id_7148C1A6F25491F8 == "skip_bink_input")
    scripts\engine\utility::ent_flag_set("userskipped");
}