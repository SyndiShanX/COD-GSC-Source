/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\leagueplay_br.gsc
***********************************************/

init() {
  if(!level._id_77907D733ABE8B63) {
    return;
  }
  _id_04CDABCD91A92977::_id_8CE5B106FBBA9E9F(::ondisconnect);
  _id_04CDABCD91A92977::_id_8FE6D6539ED31A88(::_id_ADCDFD1B1A3EFA51);
  _id_04CDABCD91A92977::_id_0EAD10448A780A58(::_id_3E87EBE7F88F1249);
  level._id_C8001F5313A05589 = getdvarint("dvar_B5256FB3F4ED76AF", 0);
  level._id_7272C293F31C587C = getdvarint("dvar_0A94C6ED8A414196", 0);
  level._id_8EED04DC7BDC9766 = getdvarint("leagueplay_wait_for_players_s", 60);
  level._id_764459B234D5C391 = getdvarint("live_lobby_minplayers_start", 0);
  level._id_58BEC65EC9494D11 = getdvarint("max_time_to_backfill_s", 60);
  level._id_8A4997CA061AA1E5 = getdvarint("dvar_683C426D1EE9A40B", 3);
  level._id_809AA817D70FD977 = getdvarint("minplayers_before_disband", 99);
  level._id_CCE73E718062D33C = getdvarint("max_vsps_during_backfill", 150);
  level._id_79814D80C62F8EBE = getdvarint("dvar_4838B7C39021124C", 1);
  level._id_A176083F858EC97B = getdvarint("wz_leagueplay_sr_triggers_version", 0);
  scripts\mp\rank::registerscoreinfo("stat_E3569AEC4686A8D6", "stat_7CE4FD9430E80CEA", 25);
  level._id_B70D036A3245E389 = _func_9BE1E9F1351A5C97();
  level._id_75B72A33AEAB21D4 = _func_CE30512FCD3A11A1();
  level._id_CBBF84A8E78CAEEE = _func_08345F2AC499E5AB();
  level._id_BBCB5F6B1B0A78AE = 1;
  level._id_7B46FD91DB5FEFDC = 0;

  if(!isDefined(level._id_75B72A33AEAB21D4))
    level._id_75B72A33AEAB21D4 = 0;

  _id_04AE5C8D79E73D36 = 3;

  if(isusingmatchrulesdata())
    _id_04AE5C8D79E73D36 = getmatchrulesdata("commonOption", "squadSize");

  level thread _id_3340318A370A7CB2();
  level thread _id_3F15B5152EF99080();
  _id_5F4A4AACB73B91D7 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1));
  level._id_F67EE22DA6041B9B = _func_1E73E03E20E15DFF();

  if(getdvarint("dvar_3438D68F1F0E7C0A", 1) && istrue(level._id_77907D733ABE8B63)) {
    level._id_561ADDF876799987 = ::_id_0BC0B95EFA029FFB;
    level._id_90420335F9A84867 = ::_id_7E9F0B973F0CDDA3;
    level._id_C596A10A13C5CD7C = ::_id_5B4B593ACE7E0AC1;
    level _id_B9A99D80C18F3C6B();
  }

  level thread _id_CA85981CA17B83EF();
  level thread _id_4D903C5FD2ADF82A();
}

_id_3340318A370A7CB2() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(istrue(level._id_15C7D73680EA5496)) {
      return;
    }
    if(!isPlayer(player) || isbot(player)) {
      return;
    }
    xuid = player getxuid();

    if(!_id_4707C41ED8BAE2D2(player))
      player _id_6C42F05B6C82B35E();

    if(getdvarint("dvar_7E8B150C928A062F", 0))
      player _id_6DB00EEF7EF6F325();

    _id_DA4DA6075AA47D27 = scripts\engine\utility::ter_op(istrue(player.pers["LPAllowLeave"]), 2, 3);
    player setclientomnvar("ui_leagueplay_allow_quit", _id_DA4DA6075AA47D27);
    player setclientomnvar("ui_league_play_br_can_leave_with_party", 0);
  }
}

_id_ADCDFD1B1A3EFA51(player) {
  if(istrue(level._id_15C7D73680EA5496)) {
    return;
  }
  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  player.pers["leaguePlayDisconnected"] = 0;
  player.pers["leaguePlayMatchCompleted"] = 0;
  xuid = player getxuid();

  if(_id_4707C41ED8BAE2D2(player)) {
    _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(player.team, "players");
    _id_F5398F303C73CEA8 = 1;

    foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1) {
      _id_558CE91125646A22 = _id_8F7040E569EC9E98 getxuid();
      logstring("LeaguePlay: Checking user: " + _id_558CE91125646A22);

      if(isDefined(_id_8F7040E569EC9E98.pers["leaguePlayDisconnected"]) && _id_8F7040E569EC9E98.pers["leaguePlayDisconnected"] == 1) {
        logstring("LeaguePlay: Incomplete squad, skipping loss forgiveness changes due to" + _id_558CE91125646A22 + " still disconnected");
        _id_F5398F303C73CEA8 = 0;
        break;
      }
    }

    if(_id_F5398F303C73CEA8)
      player _id_B64CCF1F4584F9BE(0);

    _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

    if(_id_BCA6691D9622C899 > -1)
      player _meth_DB073176839D77FB("50", [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 12, _id_BCA6691D9622C899, 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
    else
      player _meth_DB073176839D77FB("50", [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
  }
}

ondisconnect(player) {
  if(!isDefined(player))
    logstring("LeaguePlay: Skipping disconnect penalty due to undefined player parameter");
  else {
    xuid = player getxuid();

    if(!isDefined(xuid))
      logstring("LeaguePlay: Skipping disconnect penalty due to undefined xuid");
    else {
      if(!isPlayer(player) || isbot(player)) {
        logstring("LeaguePlay: Skipping disconnect penalty due to not being a player, or a bot, xuid " + xuid);
        return;
      }

      if(istrue(player.pers["leaguePlayMatchCompleted"]) || istrue(level._id_15C7D73680EA5496) || istrue(level.gameended)) {
        logstring("LeaguePlay: Skipping disconnect penalty due to game already ended, xuid " + xuid);
        return;
      }

      if(!isDefined(player.team)) {
        logstring("LeaguePlay: Skipping disconnect penalty due to undefined team, xuid " + xuid);
        return;
      }

      if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
        logstring("LeaguePlay: Skipping disconnect penalty due to not being initialized, xuid " + xuid);
        return;
      }

      _id_51F2B611A0573B40 = [];

      if(istrue(level.matchmakingmatch))
        _id_51F2B611A0573B40 = player getfireteammembers();

      foreach(ent in level.players) {
        if(scripts\engine\utility::is_equal(ent.team, player.team) && isPlayer(ent)) {
          if(scripts\engine\utility::array_contains(_id_51F2B611A0573B40, ent))
            ent setclientomnvar("ui_leagueplay_allow_quit", 0);
          else
            ent setclientomnvar("ui_leagueplay_allow_quit", 2);

          ent.pers["LPAllowLeave"] = 1;
        }
      }

      _id_934DC135AAF6F953 = 0;
      _id_3511C7EE351E5C90 = scripts\mp\teams::countplayers();
      _id_6AA85AD804FE30F6 = player getclientomnvar("ui_league_play_br_leave_penalty_timer");

      if(isDefined(_id_3511C7EE351E5C90) && isDefined(_id_3511C7EE351E5C90[player.team]) && _id_3511C7EE351E5C90[player.team] == level._id_79814D80C62F8EBE - 1)
        _id_934DC135AAF6F953 = 1;
      else
        _id_934DC135AAF6F953 = 2;

      if(isDefined(player._id_3FCC771F2C65C38F) && istrue(player._id_3FCC771F2C65C38F))
        _id_934DC135AAF6F953 = 3;
      else if(isDefined(player._id_72C19B43B99E7097) && istrue(player._id_72C19B43B99E7097))
        _id_934DC135AAF6F953 = 7;
      else if(istrue(player.pers["leaguePlayIncompleteSquad"])) {
        logstring("LeaguePlay: Sending unpenalized disconnect due to incomplete squad kick, xuid " + xuid);
        _id_934DC135AAF6F953 = 13;
      } else if(isDefined(player.pers["leaguePlayActivityPartyKick"])) {
        logstring("LeaguePlay: Skipping unpenalized disconnect due to incomplete activity party kick, xuid " + xuid);
        _id_934DC135AAF6F953 = 13;
      } else if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
        _id_934DC135AAF6F953 = 9;

        if(getdvarint("dvar_6AAD2F4DF487C409", 1) && isDefined(player.pers["subpartyIndex"]) && player.pers["subpartyIndex"] != -1) {
          _id_CCF0A6B6BA756356 = player getxuid();
          _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(player.team, "players");

          foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1) {
            if(_id_CCF0A6B6BA756356 != _id_8F7040E569EC9E98 getxuid()) {
              if(isDefined(_id_8F7040E569EC9E98.pers["subpartyIndex"]) && _id_8F7040E569EC9E98.pers["subpartyIndex"] != -1 && _id_8F7040E569EC9E98.pers["subpartyIndex"] == player.pers["subpartyIndex"]) {
                logstring("LeaguePlay: Marking client for kick, xuid: " + _id_8F7040E569EC9E98 getxuid() + " ( subpartyId: " + _id_8F7040E569EC9E98.pers["subpartyIndex"] + " ) due to disconnected activity party member in prematch");
                _id_8F7040E569EC9E98.pers["leaguePlayActivityPartyKick"] = 0;
              }
            }
          }
        }
      } else if(isDefined(_id_6AA85AD804FE30F6) && _id_6AA85AD804FE30F6 == 0)
        _id_934DC135AAF6F953 = 12;

      if(!scripts\mp\gamelogic::_id_1147BBC93EA9B83C() && _id_934DC135AAF6F953 != 9 && _id_934DC135AAF6F953 != 13) {
        placement = scripts\cp_mp\challenges::_id_5D99311B5A7DFFDA() + 1;

        if(getdvarint("dvar_DA00458FF3DCC382", 0) && isDefined(player.teamplacement))
          placement = player.teamplacement;

        _id_BBA9F88228A1053C = !(istrue(player.squadwiped) && _id_1E4A61DB11011446::_id_99E3948BFD8A99B8(player.team) == 0);
        logstring("LeaguePlay: Triggering match end for disconnecting(" + _id_BBA9F88228A1053C + ") player xuid " + xuid);
        _id_D1092FECB16D3B3C(placement, 0, _id_BBA9F88228A1053C);
      }

      if(istrue(player.squadwiped)) {
        logstring("LeaguePlay: Skipping disconnect penalty due to player squad wiped, xuid " + xuid);
        return;
      }

      if(_id_1E4A61DB11011446::_id_99E3948BFD8A99B8(player.team) == 0) {
        logstring("LeaguePlay: Skipping disconnect penalty due to player squad eliminated, xuid " + xuid);
        return;
      }

      if(getdvarint("dvar_0B748147AF48F0DB", 0)) {
        _id_A3865961CC8323CD = _id_934DC135AAF6F953 == 1;
        _id_A3865961CC8323CD = _id_A3865961CC8323CD || _id_934DC135AAF6F953 == 3;
        _id_A3865961CC8323CD = _id_A3865961CC8323CD || _id_934DC135AAF6F953 == 7;

        if(_id_A3865961CC8323CD)
          player _id_B64CCF1F4584F9BE(100);
      }

      player.pers["leaguePlayDisconnected"] = 1;
      logstring("LeaguePlay: Disconnection for user " + xuid + " ( subpartyId: " + player.pers["subpartyIndex"] + " ) with reason: " + _id_934DC135AAF6F953);
      _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

      if(_id_BCA6691D9622C899 > -1)
        return [6, 1, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 13, _id_934DC135AAF6F953, 12, _id_BCA6691D9622C899, 4, _id_04CDABCD91A92977::_id_FB67B62BBD718B34(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()];
    }
  }
}

_id_3E87EBE7F88F1249(player, _id_C4F3E9732AA81389) {
  if(_id_C4F3E9732AA81389 == 2 || _id_C4F3E9732AA81389 == 14) {
    _id_6AA85AD804FE30F6 = player getclientomnvar("ui_league_play_br_leave_penalty_timer");

    if(isDefined(_id_6AA85AD804FE30F6) && _id_6AA85AD804FE30F6 == 0 && istrue(level._id_8C4A1A7B619D8E7C))
      return 0;
  }

  return 1;
}

_id_3F15B5152EF99080() {
  level endon("game_ended");
  level waittill("br_prematchEnded");

  if(istrue(level._id_15C7D73680EA5496)) {
    return;
  }
  if(getdvarint("dvar_3438D68F1F0E7C0A", 1) && istrue(level._id_77907D733ABE8B63)) {
    _id_123FC096F9059FE0(1);
    thread _id_3EC6D3CD62B16199();
  }

  _id_9502B0BB442142B6("on_game_playing");

  if(!getdvarint("dvar_7E8B150C928A062F", 0)) {
    foreach(player in level.players)
    player _id_6DB00EEF7EF6F325();
  }
}

_id_B64CCF1F4584F9BE(_id_281E4D6C73B42D68) {
  player = self;
  _id_CCF0A6B6BA756356 = player getxuid();
  _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1) {
    _id_558CE91125646A22 = _id_8F7040E569EC9E98 getxuid();

    if(_id_CCF0A6B6BA756356 != _id_558CE91125646A22) {
      if(isDefined(_id_8F7040E569EC9E98.pers["subpartyIndex"])) {
        if(_id_8F7040E569EC9E98.pers["subpartyIndex"] != -1 && _id_8F7040E569EC9E98.pers["subpartyIndex"] != player.pers["subpartyIndex"]) {
          logstring("LeaguePlay: due to user: " + _id_CCF0A6B6BA756356 + " disconnecting, setting forgiveness to " + _id_281E4D6C73B42D68 + " for user " + _id_558CE91125646A22);
          _id_8F7040E569EC9E98.pers["forgiveness_level"] = _id_281E4D6C73B42D68;
        }
      }
    }
  }
}

_id_4D903C5FD2ADF82A() {
  if(istrue(level.skipprematch)) {
    return;
  }
  level._id_7BF0BA85EC52E893 = 1;
  level waittill("prematch_done");
  level._id_7BF0BA85EC52E893 = 0;
}

_id_9502B0BB442142B6(string) {}

_id_237DAA716DE2F328() {
  if(getdvarint("dvar_520364DD384DB9E7", 1) == 1) {
    foreach(team in level.teamnamelist) {
      _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(team, "teamCount");

      if(_id_652F47620AC4713F != level._id_79814D80C62F8EBE) {
        players = scripts\mp\utility\teams::getteamdata(team, "players");

        foreach(player in players) {
          player dlog_recordplayerevent("dlog_event_br_lp_kick", ["reason", "Kicked due to incomplete squad"]);
          logstring("LeaguePlay: Kicking " + player getxuid() + " due to incomplete squad");
          player.pers["leaguePlayIncompleteSquad"] = 1;
          kick(player getentitynumber());
        }
      }
    }
  }
}

_id_D794D8A20E142EFA() {
  level endon("game_ended");
  level endon("prematch_done");

  if(getdvarint("dvar_F5C6C9DE0D50A94A", 1) == 0) {
    return;
  }
  for(;;) {
    _id_237DAA716DE2F328();
    wait 3;
  }
}

_id_CA85981CA17B83EF() {
  level endon("game_ended");
  waitforplayers();
  logstring("LeaguePlay: done waiting for players to stream in");

  if(getdvarint("dvar_4E03166C385327EE", 1) == 1) {
    timeout = gettime() + level._id_58BEC65EC9494D11 * 1000;

    while(gettime() < timeout) {
      _id_D6B13083B4470881 = _id_5A7CB04F2683C1DF();

      if(_id_D6B13083B4470881 >= level._id_764459B234D5C391) {
        if(getdvarint("dvar_17699FE04FAC9749", 1) == 1) {
          logstring("LeaguePlay: live_lobby_minplayers_start ( " + level._id_764459B234D5C391 + " ) requirement satisfied");
          break;
        } else if(getdvarint("dvar_EFBA2AE3C5B484C7", 1) == 1) {
          if(_id_D6B13083B4470881 >= level._id_CCE73E718062D33C) {
            logstring("LeaguePlay: max_vsps_during_backfill requirement satisfied");
            break;
          }
        }
      }

      foreach(player in level.players) {
        if(isDefined(player.pers["leaguePlayActivityPartyKick"]) && player.pers["leaguePlayActivityPartyKick"] == 0) {
          player dlog_recordplayerevent("dlog_event_br_lp_kick", ["reason", "Activity party kick"]);
          logstring("LeaguePlay: kicking player xuid: " + player getxuid() + " since they've been marked for activity party kick");
          player.pers["leaguePlayActivityPartyKick"] = 1;
          kick(player getentitynumber());
        }
      }

      if(isDefined(level.players) && level.players.size < level._id_809AA817D70FD977) {
        if(getdvarint("dvar_42B032B7E139B113", 1) == 1) {
          dlog_recordevent("dlog_event_br_lp_match_cancel", ["reason", "Player count dropped below minplayersBeforeDisband while backfilling", "player_count", level.players.size, "min_players", level._id_809AA817D70FD977]);
          logstring("LeaguePlay: cancel match due to player count(" + level.players.size + ") dropping below disband threshold(" + level._id_809AA817D70FD977 + ")");
          thread _id_DC56B195BBF80D31();
          return;
        }
      }

      wait(level._id_8A4997CA061AA1E5);
    }
  }

  logstring("LeaguePlay: closing join in progress");
  _id_9502B0BB442142B6("join in progress closed");
  _id_5EA9C8005581107F();
  _id_237DAA716DE2F328();
  logstring("LeaguePlay: kicked incomplete players if there were any, notifying that backfill closed");

  if(getdvarint("dvar_51AA9C88BB0C1224", 1) == 1)
    level notify("leagueplay_br_backfill_closed");
}

_id_5A7CB04F2683C1DF() {
  _id_FB40706EAB350D91 = getdvarint("dvar_52C2D6EA6600D2AA", -1);

  if(_id_FB40706EAB350D91 >= 0)
    return _id_FB40706EAB350D91;

  _id_D6B13083B4470881 = 0;

  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(team, "teamCount");

    if(_id_652F47620AC4713F == level._id_79814D80C62F8EBE)
      _id_D6B13083B4470881 = _id_D6B13083B4470881 + _id_652F47620AC4713F;
  }

  return _id_D6B13083B4470881;
}

_id_5EA9C8005581107F() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

waitforplayers() {
  starttime = gettime();
  endtime = starttime + level._id_8EED04DC7BDC9766 * 1000;

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_B7652EEA48AE3D62 = scripts\mp\gamelogic::getstreamedinplayercount();
    _id_93E3FE0E5693889B = _id_B7652EEA48AE3D62 >= level._id_809AA817D70FD977 + 4;

    if(_id_93E3FE0E5693889B || _id_6B7BEE46F2C6DA28 > endtime) {
      break;
    }

    wait 1;
  }
}

_id_562F080949959CFC() {
  level endon("game_ended");
  level endon("prematch_done");

  if(getdvarint("dvar_42B032B7E139B113", 1) == 0) {
    return;
  }
  _id_AED019C0E09D9E8B = getdvarint("br_minplayers", 1);

  while(_id_5A7CB04F2683C1DF() >= _id_AED019C0E09D9E8B)
    wait 1;

  dlog_recordevent("dlog_event_br_lp_match_cancel", ["reason", "Low VSP count in prematch", "player_count", level.players.size, "min_players", _id_AED019C0E09D9E8B]);
  thread _id_DC56B195BBF80D31();
}

_id_9A30317C91CFAF5E() {
  if(level._id_7B46FD91DB5FEFDC) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player) && istrue(player._id_632BAD3EDB4E449E) && istrue(player._id_02FF6825157B156E)) {
      logstring("LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to squads dropping below rejoinable threshold");
      _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

      if(_id_BCA6691D9622C899 > -1)
        player _id_04CDABCD91A92977::_id_E90D7800FB5EEC03(0, [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 12, _id_BCA6691D9622C899, 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
      else
        player _id_04CDABCD91A92977::_id_E90D7800FB5EEC03(0, [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
    }
  }

  level._id_7B46FD91DB5FEFDC = 1;
}

_id_E197F06B7037E7A1(team) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player) && istrue(player._id_632BAD3EDB4E449E) && istrue(player._id_02FF6825157B156E)) {
      logstring("LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to no teammates being alive");
      _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

      if(_id_BCA6691D9622C899 > -1)
        player _id_04CDABCD91A92977::_id_E90D7800FB5EEC03(0, [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 12, _id_BCA6691D9622C899, 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
      else
        player _id_04CDABCD91A92977::_id_E90D7800FB5EEC03(0, [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
    }
  }
}

_id_4707C41ED8BAE2D2(player) {
  if(isDefined(player.pers["leaguePlayInit"]))
    return player.pers["leaguePlayInit"] == 1;

  return 0;
}

_id_6C42F05B6C82B35E() {
  player = self;

  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  if(isDefined(player.pers["leaguePlayInit"]) && player.pers["leaguePlayInit"] == 1) {
    return;
  }
  xuid = player getxuid();
  player.pers["subpartyIndex"] = _func_508D1CBB2F7D25C1(xuid);
  logstring("LeaguePlay: initializing subparty index to: " + player.pers["subpartyIndex"] + " for xuid: " + xuid);
  player.pers["sr"] = player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "season", level._id_F67EE22DA6041B9B, "sr");
  player.pers["leaguePlayInit"] = 1;
}

_id_DC56B195BBF80D31() {
  level endon("game_ended");
  _id_1E6C2CB81CC42E5A = getdvarfloat("dvar_D8ED8C2FCCD1D9B1", 30);

  if(_id_1E6C2CB81CC42E5A > 0) {
    level._id_60F7D8BD0181980F = 1;
    thread scripts\mp\gamelogic::_id_46EB417B582D5179(_id_1E6C2CB81CC42E5A * 1000, "match_cancelling_in_squads");
  }

  setomnvar("ui_prematch_period", 0);
  level._id_15C7D73680EA5496 = 1;
  level._id_7EBDE40AF908FCF8 = 0;
  wait(_id_1E6C2CB81CC42E5A);

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    foreach(player in level.players) {
      if(!isDefined(player.clientmatchdataid))
        scripts\mp\gamelogic::assignclientmatchdataid(player);

      setclientmatchdata("players", player.clientmatchdataid, "leaguePlayMatchCancelled", level._id_15C7D73680EA5496);
    }
  }

  scripts\mp\gamescore::updateplacement();
  scripts\mp\gamelogic::processlobbydata();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    _id_E6DA5914F27071A0();
    wait 1;
    level notify("exitLevel_called");
    exitlevel(0);
  } else
    level thread scripts\mp\gamelogic::forceend();
}

_id_78FCC96BE9D69371() {
  if(isDefined(level._id_F67EE22DA6041B9B) && level._id_F67EE22DA6041B9B >= 0)
    return level._id_F67EE22DA6041B9B;

  return -1;
}

_id_883F3D0FDEF74FBF(placement, _id_9536B5B9BFF06DED) {
  player = self;

  if(_id_9536B5B9BFF06DED)
    return 0;

  if(!isDefined(placement))
    return 2;

  if(placement == 1)
    return 3;

  return 1;
}

_id_6DB00EEF7EF6F325() {
  player = self;

  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
    return;
  }
  if(istrue(player.pers["leaguePlayDisconnected"])) {
    return;
  }
  _id_156E078B5445FFAA = _func_4F9373A1227DB35C();
  _id_F7E96D6052425187 = _func_94C7AE7049488358();
  _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

  if(isDefined(level._id_B70D036A3245E389) && _id_BCA6691D9622C899 > -1)
    player _meth_DB073176839D77FB("461", [0, level._id_B70D036A3245E389, 12, _id_BCA6691D9622C899, 7, _id_F7E96D6052425187, 19, _id_156E078B5445FFAA, 16, level._id_75B72A33AEAB21D4, 25, level._id_CBBF84A8E78CAEEE, 33, level._id_A176083F858EC97B]);
}

_id_D1092FECB16D3B3C(placement, _id_BEDBE1CE13E22104, _id_BBA9F88228A1053C) {
  player = self;
  xuid = player getxuid();

  if(!isDefined(placement))
    placement = 0;

  if(!isDefined(_id_BEDBE1CE13E22104))
    logstring("LeaguePlay: Skipping match_end due to undefined at_match_end for xuid " + xuid);
  else {
    if(!isPlayer(player) || isbot(player)) {
      logstring("LeaguePlay: Skipping match_end due to entity not being a player.");
      return;
    }

    if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
      logstring("LeaguePlay: Skipping match_end due to leaguePlayInit not being set for xuid " + xuid);
      return;
    }

    if(istrue(player.pers["leaguePlayMatchCompleted"])) {
      logstring("LeaguePlay: Skipping match_end since it has already been sent for xuid " + xuid);
      return;
    }

    player.pers["leaguePlayMatchCompleted"] = 1;
    _id_9536B5B9BFF06DED = istrue(level._id_15C7D73680EA5496);
    _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();
    _id_156E078B5445FFAA = _func_4F9373A1227DB35C();
    _id_F7E96D6052425187 = _func_94C7AE7049488358();
    _id_ABBF42875A7797AD = getdvarint("dvar_74B99125B3898193", 86400);
    _id_702F6A20E9A0D6AF = player.pers["forgiveness_level"];

    if(!isDefined(_id_702F6A20E9A0D6AF))
      _id_702F6A20E9A0D6AF = 0;

    _id_E8F096C8BFC6C153 = player _id_883F3D0FDEF74FBF(placement, _id_9536B5B9BFF06DED);

    if(!isDefined(level._id_B70D036A3245E389)) {
      logstring("LeaguePlay: Skipping match end event due to invalid league ID for user " + xuid);
      return;
    }

    if(!isDefined(_id_E8F096C8BFC6C153)) {
      logstring("LeaguePlay: Skipping match end event due to invalid match result for user " + xuid);
      return;
    }

    if(_id_BCA6691D9622C899 <= -1) {
      logstring("LeaguePlay: Skipping match end event due to invalid league season for user " + xuid);
      return;
    }

    logstring("LeaguePlay: Sending match end event for user " + xuid);
    _id_5C285CEB07F57B85 = [0, level._id_B70D036A3245E389, 1, _id_E8F096C8BFC6C153, 12, _id_BCA6691D9622C899, 7, _id_F7E96D6052425187, 19, _id_156E078B5445FFAA, 16, level._id_75B72A33AEAB21D4, 17, _id_ABBF42875A7797AD, 18, _id_BEDBE1CE13E22104, 25, level._id_CBBF84A8E78CAEEE, 30, _id_702F6A20E9A0D6AF, 29, placement, 6, _id_BBA9F88228A1053C, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()];

    if(getdvarint("dvar_6C80C23763BC8EFB", 0)) {
      player thread _id_43230C03C0098996(_id_5C285CEB07F57B85);
      return;
    }

    player _meth_DB073176839D77FB("80", _id_5C285CEB07F57B85);
  }
}

_id_43230C03C0098996(_id_5C285CEB07F57B85) {
  _id_2876BD36736C8C7F = getdvarfloat("dvar_743498C38D8AA460", 2.0);
  scripts\engine\utility::waittill_any_timeout_1(_id_2876BD36736C8C7F, "disconnect");
  self _meth_DB073176839D77FB("80", _id_5C285CEB07F57B85);
}

_id_E6DA5914F27071A0() {
  level.gameended = 1;
  level._id_F25335848C8EA5A0 = 1;
  _id_9536B5B9BFF06DED = istrue(level._id_15C7D73680EA5496);
  _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();
  _id_156E078B5445FFAA = _func_4F9373A1227DB35C();
  _id_F7E96D6052425187 = _func_94C7AE7049488358();
  _id_ABBF42875A7797AD = getdvarint("dvar_74B99125B3898193", 86400);

  foreach(player in level.players) {
    if(!isPlayer(player) || isbot(player)) {
      continue;
    }
    if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
      continue;
    }
    if(istrue(player.pers["leaguePlayDisconnected"])) {
      continue;
    }
    placement = 0;
    _id_E8F096C8BFC6C153 = player _id_883F3D0FDEF74FBF(undefined, _id_9536B5B9BFF06DED);

    if(isDefined(level._id_B70D036A3245E389) && isDefined(_id_E8F096C8BFC6C153) && _id_BCA6691D9622C899 > -1)
      player _meth_DB073176839D77FB("80", [0, level._id_B70D036A3245E389, 1, _id_E8F096C8BFC6C153, 12, _id_BCA6691D9622C899, 7, _id_F7E96D6052425187, 19, _id_156E078B5445FFAA, 16, level._id_75B72A33AEAB21D4, 17, _id_ABBF42875A7797AD, 18, 1, 25, level._id_CBBF84A8E78CAEEE, 30, 100, 29, placement, 6, 0, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
  }
}

_id_B9A99D80C18F3C6B() {
  if(isDefined(level._id_E461F6B82B97CC19)) {
    return;
  }
  _id_8EB7E89F7B38DFBA = "wzleagueplaysrtriggers:iw9_wz_leagueplay_sr_triggers";

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_8EB7E89F7B38DFBA = "wzleagueplaysrtriggers:mgl_wz_leagueplay_sr_triggers";

  _id_257795CB138D946A = getscriptbundle(_id_8EB7E89F7B38DFBA);
  _id_5EAFC68070D5E0CD = undefined;

  foreach(_id_0307D37C6248A5F8 in _id_257795CB138D946A._id_9E33E57BB41164EB) {
    _id_AB73A4E49CDD7413 = scripts\engine\utility::ter_op(isDefined(_id_0307D37C6248A5F8._id_5159F960A67ED33B), _id_0307D37C6248A5F8._id_5159F960A67ED33B, 0);

    if(_id_AB73A4E49CDD7413 == level._id_A176083F858EC97B) {
      _id_5EAFC68070D5E0CD = _id_0307D37C6248A5F8;
      break;
    }

    _id_5A96955026675112 = scripts\engine\utility::ter_op(isDefined(_id_5EAFC68070D5E0CD) && isDefined(_id_5EAFC68070D5E0CD._id_5159F960A67ED33B), _id_5EAFC68070D5E0CD._id_5159F960A67ED33B, 0);

    if(_id_5EAFC68070D5E0CD == undefined || _id_AB73A4E49CDD7413 > _id_5A96955026675112)
      _id_5EAFC68070D5E0CD = _id_0307D37C6248A5F8;
  }

  if(!isDefined(_id_5EAFC68070D5E0CD)) {
    return;
  }
  level._id_E461F6B82B97CC19 = spawnStruct();
  level._id_E461F6B82B97CC19._id_696B5913BD732376 = [];

  foreach(triggertype in _id_5EAFC68070D5E0CD.triggers) {
    _id_F99ECB86AB6C905C = spawnStruct();
    _id_F99ECB86AB6C905C._id_5763131521E910E1 = [];
    _id_F99ECB86AB6C905C._id_602223D6E01FD5B5 = [];

    foreach(trigger in triggertype.triggers) {
      _id_75A8EB8AF196B837 = trigger._id_5763131521E910E1;

      if(!isDefined(_id_75A8EB8AF196B837))
        _id_75A8EB8AF196B837 = 0;

      _id_F99ECB86AB6C905C._id_5763131521E910E1[_id_F99ECB86AB6C905C._id_5763131521E910E1.size] = _id_75A8EB8AF196B837;
      _id_428DB5776D5471D3 = trigger.sr;

      if(!isDefined(_id_428DB5776D5471D3))
        _id_428DB5776D5471D3 = 0;

      _id_F99ECB86AB6C905C._id_602223D6E01FD5B5[_id_F99ECB86AB6C905C._id_602223D6E01FD5B5.size] = _id_428DB5776D5471D3;
    }

    if(triggertype._id_A95CF9509CE0D814 == "placement") {
      _id_F99ECB86AB6C905C._id_602223D6E01FD5B5 = _id_0546E92E285C884A(_id_F99ECB86AB6C905C._id_602223D6E01FD5B5);
      level._id_E461F6B82B97CC19._id_696B5913BD732376[3] = _id_F99ECB86AB6C905C;
      _id_95EB99747525D474 = level._id_E461F6B82B97CC19._id_696B5913BD732376[3]._id_5763131521E910E1.size - 1;
      level._id_E461F6B82B97CC19._id_0AC0560FFA2EA0AD = _id_95EB99747525D474;
      continue;
    }

    if(triggertype._id_A95CF9509CE0D814 == "kill") {
      level._id_E461F6B82B97CC19._id_696B5913BD732376[0] = _id_F99ECB86AB6C905C;
      continue;
    }

    if(triggertype._id_A95CF9509CE0D814 == "assist") {
      level._id_E461F6B82B97CC19._id_696B5913BD732376[1] = _id_F99ECB86AB6C905C;
      continue;
    }

    if(triggertype._id_A95CF9509CE0D814 == "unassisted") {
      level._id_E461F6B82B97CC19._id_696B5913BD732376[2] = _id_F99ECB86AB6C905C;
      continue;
    }
  }

  _id_0D89814E8459F9A1 = "wzleagueplaydeploymentfees:iw9_wz_leagueplay_deployment_fees";

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_0D89814E8459F9A1 = "wzleagueplaydeploymentfees:mgl_wz_leagueplay_deployment_fees";

  _id_2C900D8096471151 = getscriptbundle(_id_0D89814E8459F9A1);
  _id_A6AD8A7AB133E16E = spawnStruct();
  _id_A6AD8A7AB133E16E._id_E03F12A82126047B = [];
  _id_A6AD8A7AB133E16E._id_E3EFF345F14F6437 = [];
  _id_A6AD8A7AB133E16E._id_40106B227641B343 = [];
  index = 0;

  foreach(_id_B6468E2E27024876 in _id_2C900D8096471151._id_F592A79EC9880803) {
    _id_E03F12A82126047B = 0;
    _id_E3EFF345F14F6437 = 0;
    _id_EDB25303E8F77CEF = 0;

    if(isDefined(_id_B6468E2E27024876._id_E03F12A82126047B))
      _id_E03F12A82126047B = _id_B6468E2E27024876._id_E03F12A82126047B;

    if(isDefined(_id_B6468E2E27024876._id_E3EFF345F14F6437))
      _id_E3EFF345F14F6437 = _id_B6468E2E27024876._id_E3EFF345F14F6437;

    if(isDefined(_id_B6468E2E27024876._id_EDB25303E8F77CEF))
      _id_EDB25303E8F77CEF = _id_B6468E2E27024876._id_EDB25303E8F77CEF;

    _id_A6AD8A7AB133E16E._id_E03F12A82126047B[index] = _id_E03F12A82126047B;
    _id_A6AD8A7AB133E16E._id_E3EFF345F14F6437[index] = _id_E3EFF345F14F6437;
    _id_A6AD8A7AB133E16E._id_40106B227641B343[index] = _id_EDB25303E8F77CEF;
    index++;
  }

  level._id_E461F6B82B97CC19._id_696B5913BD732376[4] = _id_A6AD8A7AB133E16E;
}

_id_0546E92E285C884A(_id_AB5627A359C23F27) {
  _id_BFC65A378A6D8EFE = [];

  for(index = 0; index < _id_AB5627A359C23F27.size; index++) {
    if(index == _id_AB5627A359C23F27.size - 1) {
      _id_BFC65A378A6D8EFE[index] = _id_AB5627A359C23F27[index];
      break;
    }

    _id_2A83DF6C49112D96 = _id_AB5627A359C23F27[index] - _id_AB5627A359C23F27[index + 1];
    _id_BFC65A378A6D8EFE[index] = _id_2A83DF6C49112D96;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_0BC0B95EFA029FFB(_id_2D23F02E647A1ED5, _id_4963A9CEB1F3EF5F) {
  player = self;

  if(_id_2D23F02E647A1ED5 == "kill")
    player _id_CC11B7AEFFD6B54A(0, _id_4963A9CEB1F3EF5F);
  else if(_id_2D23F02E647A1ED5 == "assist")
    player _id_CC11B7AEFFD6B54A(1, _id_4963A9CEB1F3EF5F);
  else if(_id_2D23F02E647A1ED5 == "unassisted")
    player _id_CC11B7AEFFD6B54A(2, _id_4963A9CEB1F3EF5F);
  else if(_id_2D23F02E647A1ED5 == "placement")
    _id_123FC096F9059FE0(0, _id_4963A9CEB1F3EF5F);
  else if(_id_2D23F02E647A1ED5 == "deploymentfee")
    player _id_CC11B7AEFFD6B54A(4);
  else {}
}

_id_CFFF1DFA3522761A(_id_9C311372FE855C74, _id_1EC56F9E5EC2EF34) {
  _id_12A061CEEA3EE7CB = _id_D262826255E696E9(_id_9C311372FE855C74);
  _id_458732D7065D0BB9 = _id_12A061CEEA3EE7CB._id_5763131521E910E1.size - 1;
  _id_5763131521E910E1 = scripts\cp_mp\challenges::_id_5D99311B5A7DFFDA();

  if(_id_9C311372FE855C74 != 3 && isDefined(_id_1EC56F9E5EC2EF34))
    _id_5763131521E910E1 = _id_5B4B593ACE7E0AC1(_id_5763131521E910E1, _id_1EC56F9E5EC2EF34);

  for(tierindex = 0; tierindex <= _id_458732D7065D0BB9; tierindex++) {
    if(_id_5763131521E910E1 > _id_12A061CEEA3EE7CB._id_5763131521E910E1[tierindex])
      continue;
    else
      return tierindex;
  }

  return _id_458732D7065D0BB9;
}

_id_93F8804217884A25(_id_9C311372FE855C74, _id_1EC56F9E5EC2EF34) {
  player = self;

  if(_id_9C311372FE855C74 == 3)
    return _id_BE03C4A8B29D8CFC(_id_9C311372FE855C74, level._id_E461F6B82B97CC19._id_0AC0560FFA2EA0AD);

  if(_id_9C311372FE855C74 == 4)
    return player _id_C92BF3B55444D379();

  tierindex = _id_CFFF1DFA3522761A(_id_9C311372FE855C74, _id_1EC56F9E5EC2EF34);
  return _id_BE03C4A8B29D8CFC(_id_9C311372FE855C74, tierindex);
}

_id_BE03C4A8B29D8CFC(_id_9C311372FE855C74, tierindex) {
  _id_12A061CEEA3EE7CB = _id_D262826255E696E9(_id_9C311372FE855C74);
  return _id_12A061CEEA3EE7CB._id_602223D6E01FD5B5[tierindex];
}

_id_D262826255E696E9(_id_9C311372FE855C74) {
  return level._id_E461F6B82B97CC19._id_696B5913BD732376[_id_9C311372FE855C74];
}

_id_C92BF3B55444D379() {
  player = self;
  _id_5776DDF038E9E73D = 0;

  if(isDefined(player.pers["sr"]))
    _id_5776DDF038E9E73D = player.pers["sr"];

  _id_A6AD8A7AB133E16E = _id_D262826255E696E9(4);
  _id_3829B53649865904 = _id_A6AD8A7AB133E16E._id_40106B227641B343[_id_A6AD8A7AB133E16E._id_40106B227641B343.size - 1];

  for(index = 0; index < _id_A6AD8A7AB133E16E._id_40106B227641B343.size; index++) {
    if(_id_5776DDF038E9E73D >= _id_A6AD8A7AB133E16E._id_E03F12A82126047B[index] && _id_5776DDF038E9E73D < _id_A6AD8A7AB133E16E._id_E3EFF345F14F6437[index]) {
      _id_3829B53649865904 = _id_A6AD8A7AB133E16E._id_40106B227641B343[index];
      break;
    }
  }

  return -1 * _id_3829B53649865904;
}

_id_3EC6D3CD62B16199() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_5C882C8F7BB9C72A = _id_1E4A61DB11011446::_id_F297F4741391514D();

  foreach(player in level.players)
  player[[level._id_561ADDF876799987]]("deploymentfee");
}

_id_123FC096F9059FE0(forceupdate, _id_4C25FEF43734CDD0) {
  if(isDefined(_id_4C25FEF43734CDD0))
    _id_00F6185E055127F5(_id_4C25FEF43734CDD0, 1);

  tierindex = _id_CFFF1DFA3522761A(3);

  if(tierindex < level._id_E461F6B82B97CC19._id_0AC0560FFA2EA0AD || istrue(forceupdate)) {
    level._id_E461F6B82B97CC19._id_0AC0560FFA2EA0AD = tierindex;
    thread _id_54A23BEB9C779F84();
  }
}

_id_54A23BEB9C779F84() {
  level endon("game_ended");
  waitframe();
  _id_BB26FE41CF283738 = _id_1E4A61DB11011446::_id_F297F4741391514D();

  foreach(player in _id_BB26FE41CF283738)
  player _id_CC11B7AEFFD6B54A(3);
}

_id_9A9E71365EB6010B(_id_10F37E0E73FD3A4C, victim) {
  attacker = self;
  level endon("game_ended");

  if(isDefined(attacker.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    _id_1321C1081173DFC4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](attacker.team, "players");

    if(isDefined(_id_10F37E0E73FD3A4C)) {
      if(!isarray(_id_10F37E0E73FD3A4C))
        _id_10F37E0E73FD3A4C = [_id_10F37E0E73FD3A4C];

      _id_1321C1081173DFC4 = scripts\engine\utility::array_remove_array(_id_1321C1081173DFC4, _id_10F37E0E73FD3A4C);
    }

    foreach(_id_8F7040E569EC9E98 in _id_1321C1081173DFC4) {
      if(_id_8F7040E569EC9E98 != attacker)
        _id_8F7040E569EC9E98 _id_CC11B7AEFFD6B54A(2, victim);
    }
  }
}

_id_00F6185E055127F5(team, hidden) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player _id_7B4D239188B80BB1(hidden);
}

_id_7B4D239188B80BB1(hidden) {
  player = self;
  player setclientomnvar("ui_br_skillrank_widget_hidden", hidden);
}

_id_CC11B7AEFFD6B54A(_id_9C311372FE855C74, _id_4963A9CEB1F3EF5F) {
  if(!istrue(level._id_77907D733ABE8B63)) {
    return;
  }
  player = self;

  if(!isDefined(player._id_8EDA8A21EC98626F))
    player._id_8EDA8A21EC98626F = 0;

  _id_36F3228E1D630F1B = player _id_93F8804217884A25(_id_9C311372FE855C74, _id_4963A9CEB1F3EF5F);
  player._id_8EDA8A21EC98626F = player._id_8EDA8A21EC98626F + _id_36F3228E1D630F1B;
  _id_F6ADBCD287921AB6 = player._id_8EDA8A21EC98626F < 0;
  _id_1343AB307CE38F3B = _id_36F3228E1D630F1B < 0;
  _id_081DAB8953B9DF82 = 0;
  _id_47EF1080427D4D3A = 134217727;
  _id_B3C8B592F2286B09 = 0;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(abs(player._id_8EDA8A21EC98626F)) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  _id_B3C8B592F2286B09 = _id_B3C8B592F2286B09 + 10;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(_id_F6ADBCD287921AB6) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  _id_B3C8B592F2286B09 = _id_B3C8B592F2286B09 + 1;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(abs(_id_36F3228E1D630F1B)) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  _id_B3C8B592F2286B09 = _id_B3C8B592F2286B09 + 8;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(_id_1343AB307CE38F3B) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  _id_B3C8B592F2286B09 = _id_B3C8B592F2286B09 + 1;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(level._id_E461F6B82B97CC19._id_0AC0560FFA2EA0AD) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  _id_B3C8B592F2286B09 = _id_B3C8B592F2286B09 + 4;
  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + ((int(_id_9C311372FE855C74) &_id_47EF1080427D4D3A) << _id_B3C8B592F2286B09);
  player setclientomnvar("ui_br_skillrank_widget_data", _id_081DAB8953B9DF82);
}

_id_7E9F0B973F0CDDA3(attacker, _id_B9C265F657115663) {
  victim = self;

  if(istrue(_id_B9C265F657115663)) {
    attacker scripts\mp\gamescore::_id_5A48DE6E3FB64115();

    if(isDefined(level._id_561ADDF876799987))
      attacker[[level._id_561ADDF876799987]]("assist", victim);
  } else {
    if(isDefined(level._id_561ADDF876799987))
      attacker[[level._id_561ADDF876799987]]("kill", victim);

    _id_10F37E0E73FD3A4C = victim.attackers;

    if(istrue(victim._id_F215F63A4834BB72))
      _id_10F37E0E73FD3A4C[_id_10F37E0E73FD3A4C.size] = self.lastattackedshieldplayer;

    attacker scripts\mp\gamescore::_id_6251F7723BE2F90C(victim, _id_10F37E0E73FD3A4C);
  }
}

_id_5B4B593ACE7E0AC1(_id_00280E3E6B1C00A2, victim) {
  if(isDefined(victim) && _id_1E4A61DB11011446::_id_99E3948BFD8A99B8(victim.team) == 0)
    _id_00280E3E6B1C00A2 = _id_00280E3E6B1C00A2 + 1;

  return _id_00280E3E6B1C00A2;
}