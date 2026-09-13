/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\teams.gsc
***********************************************/

init() {
  level.teambalance = getdvarint("scr_teambalance");
  level.maxclients = getmaxclients();
  level._id_12CA3A9EE540A9ED = getdvarint("dvar_819016FCBA31A2C2");
  _id_F2DA32F8A5F3E866 = ["free", "axis", "allies", "team_three", "team_four", "team_five", "team_six", "team_seven", "team_eight", "team_nine", "team_ten", "team_eleven", "team_twelve", "team_thirteen", "team_fourteen", "team_fifteen", "team_sixteen", "team_seventeen", "team_eighteen", "team_nineteen", "team_twenty", "team_twenty_one", "team_twenty_two", "team_twenty_three", "team_twenty_four", "team_twenty_five", "team_twenty_six", "team_twenty_seven", "team_twenty_eight", "team_twenty_nine", "team_thirty", "team_thirty_one", "team_thirty_two", "team_thirty_three", "team_thirty_four", "team_thirty_five", "team_thirty_six", "team_thirty_seven", "team_thirty_eight", "team_thirty_nine", "team_forty", "team_forty_one", "team_forty_two", "team_forty_three", "team_forty_four", "team_forty_five", "team_forty_six", "team_forty_seven", "team_forty_eight", "team_forty_nine", "team_fifty", "team_fifty_one", "team_fifty_two", "team_fifty_three", "team_fifty_four", "team_fifty_five", "team_fifty_six", "team_fifty_seven", "team_fifty_eight", "team_fifty_nine", "team_sixty", "team_sixty_one", "team_sixty_two", "team_sixty_three", "team_sixty_four", "team_sixty_five", "team_sixty_six", "team_sixty_seven", "team_sixty_eight", "team_sixty_nine", "team_seventy", "team_seventy_one", "team_seventy_two", "team_seventy_three", "team_seventy_four", "team_seventy_five", "team_seventy_six", "team_seventy_seven", "team_seventy_eight", "team_seventy_nine", "team_eighty", "team_eighty_one", "team_eighty_two", "team_eighty_three", "team_eighty_four", "team_eighty_five", "team_eighty_six", "team_eighty_seven", "team_eighty_eight", "team_eighty_nine", "team_ninety", "team_ninety_one", "team_ninety_two", "team_ninety_three", "team_ninety_four", "team_ninety_five", "team_ninety_six", "team_ninety_seven", "team_ninety_eight", "team_ninety_nine", "team_hundred", "team_hundred_one", "team_hundred_two", "team_hundred_three", "team_hundred_four", "team_hundred_five", "team_hundred_six", "team_hundred_seven", "team_hundred_eight", "team_hundred_nine", "team_hundred_ten", "team_hundred_eleven", "team_hundred_twelve", "team_hundred_thirteen", "team_hundred_fourteen", "team_hundred_fifteen", "team_hundred_sixteen", "team_hundred_seventeen", "team_hundred_eightteen", "team_hundred_nineteen", "team_hundred_twenty", "team_hundred_twenty_one", "team_hundred_twenty_two", "team_hundred_twenty_three", "team_hundred_twenty_four", "team_hundred_twenty_five", "team_hundred_twenty_six", "team_hundred_twenty_seven", "team_hundred_twenty_eight", "team_hundred_twenty_nine", "team_hundred_thirty", "team_hundred_thirty_one", "team_hundred_thirty_two", "team_hundred_thirty_three", "team_hundred_thirty_four", "team_hundred_thirty_five", "team_hundred_thirty_six", "team_hundred_thirty_seven", "team_hundred_thirty_eight", "team_hundred_thirty_nine", "team_hundred_forty", "team_hundred_forty_one", "team_hundred_forty_two", "team_hundred_forty_three", "team_hundred_forty_four", "team_hundred_forty_five", "team_hundred_forty_six", "team_hundred_forty_seven", "team_hundred_forty_eight", "team_hundred_forty_nine", "team_hundred_fifty", "team_hundred_fifty_one", "team_hundred_fifty_two", "team_hundred_fifty_three", "team_hundred_fifty_four", "team_hundred_fifty_five", "team_hundred_fifty_six", "team_hundred_fifty_seven", "team_hundred_fifty_eight", "team_hundred_fifty_nine", "team_hundred_sixty", "team_hundred_sixty_one", "team_hundred_sixty_two", "team_hundred_sixty_three", "team_hundred_sixty_four", "team_hundred_sixty_five", "team_hundred_sixty_six", "team_hundred_sixty_seven", "team_hundred_sixty_eight", "team_hundred_sixty_nine", "team_hundred_seventy", "team_hundred_seventy_one", "team_hundred_seventy_two", "team_hundred_seventy_three", "team_hundred_seventy_four", "team_hundred_seventy_five", "team_hundred_seventy_six", "team_hundred_seventy_seven", "team_hundred_seventy_eight", "team_hundred_seventy_nine", "team_hundred_eighty", "team_hundred_eighty_one", "team_hundred_eighty_two", "team_hundred_eighty_three", "team_hundred_eighty_four", "team_hundred_eighty_five", "team_hundred_eighty_six", "team_hundred_eighty_seven", "team_hundred_eighty_eight", "team_hundred_eighty_nine", "team_hundred_ninety", "team_hundred_ninety_one", "team_hundred_ninety_two", "team_hundred_ninety_three", "team_hundred_ninety_four", "team_hundred_ninety_five", "team_hundred_ninety_six", "team_hundred_ninety_seven", "team_hundred_ninety_eight", "team_hundred_ninety_nine", "team_two_hundred", "spectator", "codcaster", "civilian", "team_big_map_agent"];
  level.allteamnamelist = _id_F2DA32F8A5F3E866;
  _id_F5798B9364E0158D = ["axis", "allies"];

  if(getdvarint("dvar_5DABEA153BF14A41", 0) == 1)
    _id_F5798B9364E0158D = ["axis"];

  _id_D44B7B1A5D0E8F39 = ["free", "spectator", "codcaster"];
  _id_656660D323003255 = ["SAS", "RUSF", "USMC", "SABF"];
  _id_7AD00A4D4CF05D81 = scripts\mp\utility\teams::getcustomgametypeteammax();
  _id_7AD00A4D4CF05D81 = min(_id_7AD00A4D4CF05D81, getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_teamcount"), -1));
  level.maxteamsize = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_teamsize"), 0);
  _id_75D2CD1035B7C557 = 1;
  _id_25A6885224803948 = -1;

  if(_id_7AD00A4D4CF05D81 >= 3) {
    for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 < _id_7AD00A4D4CF05D81 + _id_75D2CD1035B7C557; _id_AC0E594AC96AA3A8++) {
      _id_F5798B9364E0158D[_id_F5798B9364E0158D.size] = level.allteamnamelist[_id_AC0E594AC96AA3A8];

      if(!isDefined(game[level.allteamnamelist[_id_AC0E594AC96AA3A8]]))
        game[level.allteamnamelist[_id_AC0E594AC96AA3A8]] = _id_656660D323003255[(_id_AC0E594AC96AA3A8 + _id_25A6885224803948) % _id_656660D323003255.size];
    }
  }

  level.teamnamelist = _id_F5798B9364E0158D;
  level.multiteambased = level.teamnamelist.size > 2 || getdvarint("dvar_2C78E7CF8D058302", 0) == 1;
  level.teamdata = [];

  foreach(team in _id_F2DA32F8A5F3E866)
  _id_53CECC93D53FB16E(team);

  foreach(team in _id_F5798B9364E0158D) {
    scripts\mp\utility\teams::getteamfactionsfrommap(team);
    scripts\mp\utility\teams::getteamname(team);
    scripts\mp\utility\teams::getteamshortname(team);
    scripts\mp\utility\teams::getteamicon(team);
    scripts\mp\utility\teams::getteamheadicon(team);
    scripts\mp\utility\teams::getteamvoiceinfix(team);
  }

  level.teambased = _id_7AD00A4D4CF05D81 > 1 || getdvarint("dvar_6BFDDBBC0765D353", 0) == 1;
  setDvar("ui_numteams", level.teamnamelist.size);

  if(getdvarint("scr_game_forceuav", 0) != 0 && level.teambased)
    level thread scripts\cp_mp\killstreaks\uav::_id_C11936B9C6C3A076(undefined, 1);

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);
  level thread onplayerconnect();
  level thread trackplayedtime();
  _id_D650608C959C9675();
  initnightvisionheadoverrides();
  wait 0.15;
  level thread updateplayertimes();
  level thread finalizeplayertimes();

  if(level.teambased)
    level thread updateteambalance();

  if(scripts\mp\utility\game::matchmakinggame() && !isintournament() && !getdvarint("dvar_9B383028DFD6542D", 0))
    level thread watchafk();

  if(getdvarint("dvar_CF58BC10C64A1977", 0) == 1)
    level thread debugprintteams();

  _id_6F61A7EBCD7859F6();
  _id_67FD50C33D15B163();
}

_id_6F61A7EBCD7859F6() {
  level._id_8439AC7B613822B0 = [];
  _id_95E750BC139E9DA9 = undefined;

  if(!isDefined(level._id_21E8A7768C0260F2))
    _id_95E750BC139E9DA9 = _func_811510B694DDD963();
  else
    _id_95E750BC139E9DA9 = level._id_21E8A7768C0260F2;

  if(isDefined(_id_95E750BC139E9DA9) && isDefined(_id_95E750BC139E9DA9._id_A05DEA7444800C60)) {
    _id_150ADA5DE2119F78 = getscriptbundle("parachutelist:" + _id_95E750BC139E9DA9._id_A05DEA7444800C60);

    if(isDefined(_id_150ADA5DE2119F78) && isDefined(_id_150ADA5DE2119F78._id_B6FD95000E4EE1E1)) {
      foreach(parachute in _id_150ADA5DE2119F78._id_B6FD95000E4EE1E1) {
        lootid = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_56E1B55B9B3FE8F9", parachute._id_54B59037B61F6BE0), "stat_8028887F70BF5EBA");
        ref = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_56E1B55B9B3FE8F9", parachute._id_54B59037B61F6BE0), "stat_89E9C01960F4C582");

        if(isDefined(ref)) {
          level._id_8439AC7B613822B0[lootid] = spawnStruct();
          level._id_8439AC7B613822B0[lootid].ref = ref;
          level._id_8439AC7B613822B0[lootid]._id_C545F61C9BA000A9 = parachute._id_54B59037B61F6BE0;
          continue;
        }
      }
    }
  }
}

_id_67FD50C33D15B163() {
  level._id_A36FDB48E33DEE79 = [];
  _id_95E750BC139E9DA9 = undefined;

  if(!isDefined(level._id_21E8A7768C0260F2))
    _id_95E750BC139E9DA9 = _func_811510B694DDD963();
  else
    _id_95E750BC139E9DA9 = level._id_21E8A7768C0260F2;

  if(isDefined(_id_95E750BC139E9DA9) && isDefined(_id_95E750BC139E9DA9._id_A36FDB48E33DEE79)) {
    _id_94E82EFC0C1E2431 = getscriptbundle("contraillist:" + _id_95E750BC139E9DA9._id_A36FDB48E33DEE79);

    if(isDefined(_id_94E82EFC0C1E2431) && isDefined(_id_94E82EFC0C1E2431._id_98DAEB71E127B3B2)) {
      foreach(_id_6614BE6776236A3D in _id_94E82EFC0C1E2431._id_98DAEB71E127B3B2) {
        lootid = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_03EAD86725B3CFA8", _id_6614BE6776236A3D._id_8D2E4703AFCC8ABD), "stat_8028887F70BF5EBA");
        ref = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_03EAD86725B3CFA8", _id_6614BE6776236A3D._id_8D2E4703AFCC8ABD), "stat_89E9C01960F4C582");

        if(isDefined(ref)) {
          level._id_A36FDB48E33DEE79[lootid] = spawnStruct();
          level._id_A36FDB48E33DEE79[lootid].ref = ref;
          level._id_A36FDB48E33DEE79[lootid]._id_C545F61C9BA000A9 = _id_6614BE6776236A3D._id_8D2E4703AFCC8ABD;
          continue;
        }
      }
    }
  }
}

_id_53CECC93D53FB16E(team) {
  level.teamdata[team] = [];
  level.teamdata[team]["players"] = [];
  level.teamdata[team]["alivePlayers"] = [];
  level.teamdata[team]["teamCount"] = 0;
  level.teamdata[team]["aliveCount"] = 0;
  level.teamdata[team]["livesCount"] = 0;
  level.teamdata[team]["hasSpawned"] = 0;
  level.teamdata[team]["oneLeftTime"] = 0;
  level.teamdata[team]["twoLeft"] = 0;
  level.teamdata[team]["oneLeft"] = 0;
  level.teamdata[team]["noRespawns"] = 0;
  level.teamdata[team]["playagainHostXuid"] = "0";

  if(level.multiteambased)
    level.teamdata[team]["deathEvent"] = 0;

  if(isDefined(level._id_7B37B2193F163B9B)) {
    level.teamdata[team]["UIBotCount"] = 0;
    level.teamdata[team]["UnlockedUIBotCount"] = 0;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.timeplayed = [];
    player.timeplayed["game"] = 0;
    player.timeplayed["total"] = 0;
    player.timeplayed["missionTeam"] = 0;
    player.timeplayed["other"] = 0;
    player.timeplayed["gulag"] = 0;
    player.timeplayed["resurgenceRespawn"] = 0;
    player.timeplayed["infil"] = 0;

    if(!isDefined(player.pers["timeDead"]))
      player.pers["timeDead"] = 0;

    player _meth_C982E24E79A06BD1();
    player _meth_6FB381A0318778F5();
  }
}

onjoinedteam(player) {
  if(getdvarint("ui_br_eliminated", 0) != 0)
    player _id_0A34750D17473C49::updateplayereliminatedomnvar("onJoinedTeam");

  player updateteamtime();
}

onjoinedspectators(player) {
  if(isDefined(player.pers))
    player.pers["teamTime"] = undefined;
}

trackplayedtime() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(!level.gameended) {
    wait 1.0;

    foreach(player in level.players)
    player trackplayedtimeupdate();
  }
}

trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    team = self.sessionteam;

    if(!isDefined(self.timeplayed["game"]))
      self.timeplayed["game"] = 0;
    else
      self.timeplayed["game"]++;

    if(team != "spectator" && team != "codcaster") {
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;

      if(!scripts\mp\utility\player::isreallyalive(self))
        self.pers["timeDead"]++;
    }
  }

  if(isDefined(self._id_73F7116F87A4FAB6) && self._id_73F7116F87A4FAB6 > 0)
    self._id_73F7116F87A4FAB6--;
}

updateplayertimes() {
  level endon("game_ended");

  for(;;) {
    _id_D12A341B40354143 = level.players.size;

    for(startplayer = 0; startplayer < _id_D12A341B40354143; startplayer = startplayer + 20) {
      scripts\mp\hostmigration::waittillhostmigrationdone();

      for(_id_82555C709FBE7CCC = 0; _id_82555C709FBE7CCC < 20; _id_82555C709FBE7CCC++) {
        _id_EF50426720E1DBB8 = startplayer + _id_82555C709FBE7CCC;
        player = level.players[_id_EF50426720E1DBB8];

        if(isDefined(player))
          player updateplayedtime();
      }

      waitframe();
    }

    wait 2.0;
  }
}

finalizeplayertimes() {
  while(!level.gameended)
    wait 2.0;

  foreach(player in level.players) {
    player updateplayedtime();

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      player scripts\mp\persistence::writebufferedstats();
      player scripts\mp\persistence::updateweaponbufferedstats();
    }
  }
}

updateplayedtime() {
  if(isai(self)) {
    return;
  }
  scripts\mp\playerstats_interface::addtoplayerstatbuffered(self.timeplayed["game"], "matchStats", "timePlayedTotal");
  scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["game"], 1);

  if(_id_2CEDCC356F1B9FC8::isplayeringulag())
    self.timeplayed["gulag"] = self.timeplayed["gulag"] + self.timeplayed["game"];
  else if(_id_2CEDCC356F1B9FC8::_id_8F0E6614368F64C2())
    self.timeplayed["resurgenceRespawn"] = self.timeplayed["resurgenceRespawn"] + self.timeplayed["game"];
  else if(isDefined(self.c130) || istrue(self.brneverlanded))
    self.timeplayed["infil"] = self.timeplayed["infil"] + self.timeplayed["game"];

  if(game["state"] == "postgame") {
    return;
  }
  self.timeplayed["game"] = 0;
  self.timeplayed["missionTeam"] = 0;
}

updateteamtime() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

updateteambalancedvar() {
  for(;;) {
    teambalance = getdvarint("scr_teambalance");

    if(level.teambalance != teambalance)
      level.teambalance = getdvarint("scr_teambalance");

    wait 1;
  }
}

updateteambalance() {
  level thread updateteambalancedvar();
  wait 0.15;

  if(level.teambalance && scripts\mp\utility\game::isroundbased()) {
    if(isDefined(game["BalanceTeamsNextRound"]))
      scripts\mp\hud_message::showerrormessagetoallplayers("MP/AUTOBALANCE_NEXT_ROUND");

    level waittill("restarting");

    if(isDefined(game["BalanceTeamsNextRound"])) {
      level balanceteams();
      game["BalanceTeamsNextRound"] = undefined;
    } else if(!getteambalance())
      game["BalanceTeamsNextRound"] = 1;
  } else {
    level endon("game_ended");

    for(;;) {
      if(level.teambalance) {
        if(!getteambalance()) {
          scripts\mp\hud_message::showerrormessagetoallplayers("MP/AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!getteambalance())
            level balanceteams();
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

getteambalance() {
  team["allies"] = 0;
  team["axis"] = 0;
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "allies") {
      team["allies"]++;
      continue;
    }

    if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "axis")
      team["axis"]++;
  }

  if(team["allies"] > team["axis"] + level.teambalance || team["axis"] > team["allies"] + level.teambalance)
    return 0;
  else
    return 1;
}

balanceteams() {
  iprintlnbold(game["strings"]["autobalance"]);
  _id_4B60537D15DF5108 = [];
  _id_650728BA49299C62 = [];
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(players[_id_AC0E594AC96AA3A8].pers["teamTime"])) {
      continue;
    }
    if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "allies") {
      _id_4B60537D15DF5108[_id_4B60537D15DF5108.size] = players[_id_AC0E594AC96AA3A8];
      continue;
    }

    if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "axis")
      _id_650728BA49299C62[_id_650728BA49299C62.size] = players[_id_AC0E594AC96AA3A8];
  }

  _id_946D134EBC6C711D = undefined;

  while(_id_4B60537D15DF5108.size > _id_650728BA49299C62.size + 1 || _id_650728BA49299C62.size > _id_4B60537D15DF5108.size + 1) {
    if(_id_4B60537D15DF5108.size > _id_650728BA49299C62.size + 1) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_4B60537D15DF5108.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(_id_4B60537D15DF5108[_id_AC0E5C4AC96AAA41].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(_id_946D134EBC6C711D)) {
          _id_946D134EBC6C711D = _id_4B60537D15DF5108[_id_AC0E5C4AC96AAA41];
          continue;
        }

        if(_id_4B60537D15DF5108[_id_AC0E5C4AC96AAA41].pers["teamTime"] > _id_946D134EBC6C711D.pers["teamTime"])
          _id_946D134EBC6C711D = _id_4B60537D15DF5108[_id_AC0E5C4AC96AAA41];
      }

      _id_946D134EBC6C711D[[level.onteamselection]]("axis");
    } else if(_id_650728BA49299C62.size > _id_4B60537D15DF5108.size + 1) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_650728BA49299C62.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(_id_650728BA49299C62[_id_AC0E5C4AC96AAA41].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(_id_946D134EBC6C711D)) {
          _id_946D134EBC6C711D = _id_650728BA49299C62[_id_AC0E5C4AC96AAA41];
          continue;
        }

        if(_id_650728BA49299C62[_id_AC0E5C4AC96AAA41].pers["teamTime"] > _id_946D134EBC6C711D.pers["teamTime"])
          _id_946D134EBC6C711D = _id_650728BA49299C62[_id_AC0E5C4AC96AAA41];
      }

      _id_946D134EBC6C711D[[level.onteamselection]]("allies");
    }

    _id_946D134EBC6C711D = undefined;
    _id_4B60537D15DF5108 = [];
    _id_650728BA49299C62 = [];
    players = level.players;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "allies") {
        _id_4B60537D15DF5108[_id_4B60537D15DF5108.size] = players[_id_AC0E594AC96AA3A8];
        continue;
      }

      if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == "axis")
        _id_650728BA49299C62[_id_650728BA49299C62.size] = players[_id_AC0E594AC96AA3A8];
    }
  }
}

playermodelforweapon(weapon, _id_D7B9856A19F9B6B5) {}

countplayers() {
  _id_01ACD58651E36C89 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++)
    _id_01ACD58651E36C89[level.teamnamelist[_id_AC0E594AC96AA3A8]] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] == self) {
      continue;
    }
    if(level.players[_id_AC0E594AC96AA3A8].pers["team"] == "spectator") {
      continue;
    }
    if(level.players[_id_AC0E594AC96AA3A8].pers["team"] == "codcaster") {
      continue;
    }
    if(isDefined(level.players[_id_AC0E594AC96AA3A8].pers["team"]))
      _id_01ACD58651E36C89[level.players[_id_AC0E594AC96AA3A8].pers["team"]]++;
  }

  return _id_01ACD58651E36C89;
}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(!isagent(self)) {
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  }

  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }
}

forcecustomization(index) {
  model = undefined;
  headmodel = undefined;
  _id_56E7CF38A4910BA2 = [];

  switch (index) {
    case 1:
      model = "mp_warfighter_body_1_3";
      headmodel = "mp_warfighter_head_1_3";
      break;
    case 2:
      model = "mp_body_heavy_1_2";
      headmodel = "mp_head_heavy_1_2";
      break;
    case 3:
      if(scripts\mp\utility\game::getgametype() == "infect") {
        model = "mp_synaptic_body_1_4";
        headmodel = "mp_synaptic_head_1_4";
      } else {
        model = "mp_synaptic_body_1_1";
        headmodel = "mp_synaptic_head_1_1";
      }

      break;
    case 4:
      model = "mp_ftl_body_3_1";
      headmodel = "mp_ftl_head_5_1";
      break;
    case 5:
      model = "mp_stryker_body_2_1";
      headmodel = "mp_stryker_head_3_1";
      break;
    case 6:
      model = "mp_ghost_body_1_3";
      headmodel = "mp_ghost_head_1_1";
      break;
  }

  self setcustomization(model, headmodel);
  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
}

getcustomization() {
  _id_56E7CF38A4910BA2 = [];

  if(isDefined(self.operatorcustomization)) {
    _id_56E7CF38A4910BA2["body"] = self.operatorcustomization.body;
    _id_56E7CF38A4910BA2["head"] = self.operatorcustomization.head;
  } else {
    data = getoperatorcustomization();
    _id_56E7CF38A4910BA2["body"] = data[0];
    _id_56E7CF38A4910BA2["head"] = data[1];
  }

  return _id_56E7CF38A4910BA2;
}

setmodelfromcustomization() {
  _id_56E7CF38A4910BA2 = getcustomization();
  self setcustomization(_id_56E7CF38A4910BA2["body"], _id_56E7CF38A4910BA2["head"]);
  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
}

getplayerviewmodelfrombody(_id_C993EC5D5206D3C6) {
  viewmodel = tablelookup("mp/cac/bodies.csv", 1, _id_C993EC5D5206D3C6, 3);

  if(!isDefined(viewmodel) || viewmodel == "")
    viewmodel = "viewhands_mp_base_iw8";

  return viewmodel;
}

getplayerfoleytype(_id_C993EC5D5206D3C6) {
  return tablelookup("mp/cac/bodies.csv", 1, _id_C993EC5D5206D3C6, 5);
}

getplayermodelname(bodyindex) {
  return tablelookup("mp/cac/bodies.csv", 0, bodyindex, 1);
}

setupplayermodel() {
  if(!isDefined(self.operatorcustomization) || self.operatorcustomization.rebuild == 1)
    createoperatorcustomization();

  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  scripts\mp\utility\player::_setsuit(self.operatorcustomization.suit);

  if(isDefined(self.operatorcustomization._id_3291E2CBEC055766))
    self _meth_ 602 B3DE054F2A81(self.operatorcustomization._id_3291E2CBEC055766);

  scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(isDefined(self.operatorcustomization.parachute))
    self _meth_9CD675A7411B6362(self.operatorcustomization.parachute);
}

createoperatorcustomization(operatorref, _id_5864EA4E21A60CD4) {
  self _meth_ECDCCFDA4326DE02();
  self.operatorcustomization = undefined;
  operatorcustomization = spawnStruct();

  if(!isDefined(operatorref) || !isDefined(_id_5864EA4E21A60CD4)) {
    operatorref = lookupcurrentoperator(self.team);
    _id_5864EA4E21A60CD4 = _id_ED273E317490CB02(operatorref);
  }

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0) {
    if(isDefined(self.team) && self.team == "allies") {
      operatorref = "t10_usa_bravo_infiltration";
      _id_5864EA4E21A60CD4 = 22;
    } else {
      operatorref = "t10_uk_stone_security";
      _id_5864EA4E21A60CD4 = 25;
    }
  }

  operatorcustomization.operatorref = operatorref;
  operatorcustomization.skinref = _id_5864EA4E21A60CD4;
  operatorcustomization._id_3291E2CBEC055766 = _id_2DC6EF8B84DFEC64(_id_5864EA4E21A60CD4);
  operatorcustomization._id_D947B7E87C7243AB = _id_29B2AF59258D6501(_id_5864EA4E21A60CD4);
  operatorcustomization.gender = getoperatorgender(operatorref);
  operatorcustomization.voice = getoperatorvoice(operatorref, _id_5864EA4E21A60CD4);
  operatorcustomization.clothtype = getoperatorclothtype(_id_5864EA4E21A60CD4);
  operatorcustomization._id_400EF51562606E7A = _id_E8770349A2B50BEC(_id_5864EA4E21A60CD4);
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  operatorcustomization.execution = getoperatorexecution(operatorref);
  operatorcustomization.executionquip = getoperatorexecutionquip(operatorref);
  operatorcustomization.parachute = _id_66B30579F9F18786();

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    operatorcustomization.suit = "t10_defaultsuit_mp";
  else
    operatorcustomization.suit = _id_ADA9A2308A4046E2(operatorref);

  operatorcustomization.brinfilsmokesuffix = getoperatorbrinfilsmokesuffix();
  operatorcustomization.rebuild = 0;
  self.operatorcustomization = operatorcustomization;
  _id_56E7CF38A4910BA2 = getoperatorcustomization();
  body = _id_56E7CF38A4910BA2[0];
  head = _id_56E7CF38A4910BA2[1];

  if(!isagent(self)) {
    self setcustomization(body, head);
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_0E69FCB0BB9E108B = self getcustomizationviewmodel();
    _id_41BD2EEDA1C033D2 = getplayerviewmodelfrombody(body);
  } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    bodymodelname = "fullbody_usmc_ar_br_infil";
    headmodelname = undefined;
    _id_0E69FCB0BB9E108B = "viewhands_mp_base_iw8";
    _id_41BD2EEDA1C033D2 = "viewhands_mp_base_iw8";
  } else {
    bodymodelname = "body_opforce_london_terrorist_1_2";
    headmodelname = "head_male_bc_03";
    _id_0E69FCB0BB9E108B = "viewmodel_mp_base_iw8";
    _id_41BD2EEDA1C033D2 = "viewmodel_mp_base_iw8";
  }

  self.operatorcustomization.body = body;
  self.operatorcustomization.defaultbody = bodymodelname;
  self.operatorcustomization.head = head;
  self.operatorcustomization.defaulthead = headmodelname;
  self.operatorcustomization.vm = _id_41BD2EEDA1C033D2;
  self.operatorcustomization.defaultvm = _id_0E69FCB0BB9E108B;

  if(istrue(game["isLaunchChunk"])) {
    if(isbot(self)) {
      if(self.team == "allies")
        self.operatorcustomization.voice = "ukft1";
      else
        self.operatorcustomization.voice = "ruft1";
    }
  }

  if(!isagent(self) && !isbot(self) && !isDefined(self.vehiclecustomization))
    self.vehiclecustomization = scripts\cp_mp\vehicles\vehicle::_id_1CD6D75165ECBC48();

  _id_1800697EBA3F6660(self.operatorcustomization);
}

_id_2DC6EF8B84DFEC64(_id_5864EA4E21A60CD4) {
  _id_3291E2CBEC055766 = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 36);

  if(isDefined(_id_3291E2CBEC055766) && _id_3291E2CBEC055766 != "")
    return _id_3291E2CBEC055766;

  return undefined;
}

_id_66B30579F9F18786() {
  parachute = undefined;
  lootid = self getplayerdata("common", "commonCustomization", "parachute");

  if(isDefined(lootid) && lootid != 0) {
    if(isDefined(level._id_8439AC7B613822B0) && isDefined(level._id_8439AC7B613822B0[lootid]))
      parachute = level._id_8439AC7B613822B0[lootid].ref;
  }

  return parachute;
}

_id_1800697EBA3F6660(operatorcustomization) {
  _id_CFBD5DFAB1E96CB1 = getdvarint("dvar_838359D5EBDCC7E0", 0);

  if(_id_CFBD5DFAB1E96CB1 == 0) {
    return;
  }
  _id_E701B52B2BDC35C5 = getdvarint("dvar_B77BB859108E69CD", 0);
  _id_179DD20BBF6C2F02 = getdvarint("dvar_91B801DDFB57AE8A", 0);

  if(scripts\common\utility::iscp() || !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled) {
    return;
  }
  _id_4A654BD9A395C1FF = [];

  if(_id_E701B52B2BDC35C5 == 1)
    _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = self.operatorcustomization._id_D947B7E87C7243AB;

  if(_id_179DD20BBF6C2F02 == 1)
    _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(self.operatorcustomization.execution);

  self _meth_616C0CA219597829(_id_4A654BD9A395C1FF);
}

lookupotheroperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  _id_3EDA0EF65C9478AC = scripts\engine\utility::ter_op(team == "allies", 1, 0);
  operatorref = "";

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(level.teambased && !isai(self))
      operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);
  }

  return operatorref;
}

lookupcurrentoperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  operatorref = undefined;

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.operatorref))
    operatorref = self.operatorcustomization.operatorref;
  else if(isai(self) || self isplayerheadless()) {
    if(isDefined(self.botoperatorref))
      operatorref = self.botoperatorref;
    else {
      _id_D650608C959C9675();

      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = self.team;

        if(!isDefined(level._id_B113F6FE0E7C93BF[self.botoperatorteam])) {
          _id_A35E0C377810107E = getarraykeys(level._id_B113F6FE0E7C93BF);
          self.botoperatorteam = scripts\engine\utility::random(_id_A35E0C377810107E);
        }
      }

      team = self.botoperatorteam;

      if(!isDefined(self.pers["operatorIndex"])) {
        _id_1F9F9C5D4663030C = randomint(level._id_B113F6FE0E7C93BF[team].size);
        self.pers["operatorIndex"] = _id_1F9F9C5D4663030C;
      } else
        _id_1F9F9C5D4663030C = self.pers["operatorIndex"];

      currentindex = 0;

      foreach(_id_257DF77381FCCC70, _id_EEF96DCED6DD39F1 in level._id_B113F6FE0E7C93BF[team]) {
        if(currentindex == _id_1F9F9C5D4663030C) {
          self.botoperatorref = _id_257DF77381FCCC70;
          operatorref = _id_257DF77381FCCC70;
          break;
        }

        currentindex++;
      }
    }

    if(!isDefined(operatorref) || operatorref == "")
      operatorref = "milsim_western_1";
  } else {
    _id_3EDA0EF65C9478AC = scripts\engine\utility::ter_op(team == "allies", 0, 1);

    if(_id_1851DE461471FD20()) {
      _id_1F9F9C5D4663030C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
      _id_3EDA0EF65C9478AC = _id_1F9F9C5D4663030C;
    }

    if(!isDefined(self.defaultoperatorteam)) {
      if(_id_3EDA0EF65C9478AC == 0)
        self.defaultoperatorteam = "allies";
      else
        self.defaultoperatorteam = "axis";
    }

    if(level.gametype == "infect" && team == "axis")
      operatorref = "infected_western";
    else {
      operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);

      if(!isDefined(operatorref) || operatorref == "")
        operatorref = "milsim_western_1";
    }
  }

  return operatorref;
}

_id_1851DE461471FD20() {
  if(level.multiteambased || !level.teambased)
    return 1;

  if(scripts\mp\utility\game::getgametype() == "ballmode")
    return 1;

  return 0;
}

_id_47BA2341114690AD(clientnum, team) {
  _id_A35E0C377810107E = getarraykeys(level._id_B113F6FE0E7C93BF);
  operatorref = undefined;

  if(!isDefined(self._id_E2C5B532EB1566AB)) {
    foreach(_id_7C578F2F3EBFDD97 in _id_A35E0C377810107E) {
      _id_EA61DCDCEDF141E7 = getarraykeys(level._id_B113F6FE0E7C93BF[_id_7C578F2F3EBFDD97]);

      if(!isDefined(level.headlessopindex))
        level.headlessopindex = [];

      if(!isDefined(level.headlessopindex[_id_7C578F2F3EBFDD97]) || level.headlessopindex[_id_7C578F2F3EBFDD97] > _id_EA61DCDCEDF141E7.size)
        level.headlessopindex[_id_7C578F2F3EBFDD97] = 0;

      for(_id_FBAF0295A16D4C79 = _id_EA61DCDCEDF141E7[level.headlessopindex[_id_7C578F2F3EBFDD97]]; isDefined(_id_FBAF0295A16D4C79) && (_id_FBAF0295A16D4C79 == "default_western" || _id_FBAF0295A16D4C79 == "default_eastern"); _id_FBAF0295A16D4C79 = _id_EA61DCDCEDF141E7[level.headlessopindex[_id_7C578F2F3EBFDD97]]) {
        level.headlessopindex[_id_7C578F2F3EBFDD97] = level.headlessopindex[_id_7C578F2F3EBFDD97] + 1;

        if(level.headlessopindex[_id_7C578F2F3EBFDD97] > _id_EA61DCDCEDF141E7.size)
          level.headlessopindex[_id_7C578F2F3EBFDD97] = 0;
      }

      level.headlessopindex[_id_7C578F2F3EBFDD97] = level.headlessopindex[_id_7C578F2F3EBFDD97] + 1;
      self._id_E2C5B532EB1566AB = _id_FBAF0295A16D4C79;
    }

    self.headlesscustomizationops = 1;
  }

  if(!isDefined(self.botoperatorteam))
    self.botoperatorteam = scripts\engine\utility::random(_id_A35E0C377810107E);

  if(getdvarint("dvar_A67BCD0C90BDEFE1", 0) == 1) {
    logprint("name= " + self.name);
    logprint("clientNum = " + clientnum);
    logprint("botOperatorTeam = " + self.botoperatorteam);
    logprint("operatorRef = " + operatorref);
  }

  operatorref = self._id_E2C5B532EB1566AB;
  return operatorref;
}

_id_ED273E317490CB02(operatorref) {
  team = getoperatorteambyref(operatorref);

  if(scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis")
    self.pers["operatorSkinIndex"] = _id_45BF24706CE6AEEF();
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref))
    self.pers["operatorSkinIndex"] = self.operatorcustomization.skinref;
  else if(isai(self) || self isplayerheadless())
    self.pers["operatorSkinIndex"] = botpickskinid(operatorref);
  else
    self.pers["operatorSkinIndex"] = scripts\mp\class::_id_70763795B02C14F4(operatorref);

  return self.pers["operatorSkinIndex"];
}

_id_45BF24706CE6AEEF() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return 666;

  return 245;
}

botpickskinid(operatorref) {
  team = scripts\engine\utility::ter_op(isDefined(self.botoperatorteam), self.botoperatorteam, self.team);
  _id_610520BE555433B2 = randomint(level._id_B113F6FE0E7C93BF[team][operatorref].size);
  return level._id_B113F6FE0E7C93BF[team][operatorref][_id_610520BE555433B2];
}

picklaunchchunkoperatorskin(team) {
  if(!isDefined(level.launchchunkskins)) {
    level.launchchunkskins = [];
    level.launchchunkskins["allies"] = 0;
    level.launchchunkskins["axis"] = 0;
  }

  if(!isDefined(self.launchchunkcustomizationindex)) {
    if(level.launchchunkskins[team] == 2)
      level.launchchunkskins[team] = 0;

    self.launchchunkcustomizationindex = level.launchchunkskins[team];
    level.launchchunkskins[team]++;
  }

  return self.launchchunkcustomizationindex;
}

getoperatorcustomization() {
  _id_56E7CF38A4910BA2 = [];
  body = undefined;
  head = undefined;

  if(istrue(game["isLaunchChunk"])) {
    initlaunchchunkoperatorskins();

    if(!isDefined(self.pers["defaultOperatorSkinIndex"]))
      self.pers["defaultOperatorSkinIndex"] = picklaunchchunkoperatorskin(self.team);

    body = level.defaultoperatorskins[self.team]["body"][self.pers["defaultOperatorSkinIndex"]];
    head = level.defaultoperatorskins[self.team]["head"][self.pers["defaultOperatorSkinIndex"]];
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
  } else {
    operatorskinindex = undefined;

    if(!isDefined(self.operatorcustomization))
      createoperatorcustomization();

    operatorskinindex = int(self.operatorcustomization.skinref);

    if(isDefined(level.modegetforceoperatorcustomization)) {
      _id_91CB23E7AB33F8EF = _id_1B5C55CB118D5CB4(operatorskinindex);
      [_id_91CB23E7AB33F8EF, operatorskinindex] = [[level.modegetforceoperatorcustomization]](self, _id_91CB23E7AB33F8EF, operatorskinindex);
    }

    if(operatorskinindex == -1 || operatorskinindex == -1) {
      initdefaultoperatorskins();
      _id_3060E7B91E020425 = level.teambased && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

      if(!isDefined(self.defaultoperatorteam) || _id_3060E7B91E020425 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
        self.defaultoperatorteam = self.team;

        if(self.team != "allies" && self.team != "axis")
          self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }

      if(!isDefined(self.pers["defaultOperatorSkinIndex"]))
        self.pers["defaultOperatorSkinIndex"] = randomint(level.defaultoperatorskins[self.defaultoperatorteam]["body"].size);

      body = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

      if(!isDefined(self.pers["defaultOperatorHeadIndex"]))
        self.pers["defaultOperatorHeadIndex"] = randomint(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]].size);

      head = level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]][self.pers["defaultOperatorHeadIndex"]];
    } else {
      body = tablelookup("operatorskins.csv", 0, operatorskinindex, 4);
      head = tablelookup("operatorskins.csv", 0, operatorskinindex, 5);
    }

    if(body == "" || head == "") {
      _id_F91A44E31CDE7D97 = tablelookup("operators.csv", 1, self.operatorcustomization.operatorref, 22);
      body = tablelookup("operatorskins.csv", 1, _id_F91A44E31CDE7D97, 4);
      head = tablelookup("operatorskins.csv", 1, _id_F91A44E31CDE7D97, 5);
    }

    self.bodymodelname = body;
    self.backuphead = head;
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
  }

  return _id_56E7CF38A4910BA2;
}

initlaunchchunkoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_ar_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"] = ["head_mp_western_fireteam_west_dmr_2_1", "head_mp_western_fireteam_west_ar_1_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw8_suit_mp_wyatt"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_lmg_lod1"];
  level.defaultoperatorskins["axis"]["head"] = ["head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_lmg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw8_suit_mp_wyatt"];
}

initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["axis"] = [];

  switch (game["allies_outfit"]) {
    case "urban":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1", "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1", "head_mp_western_fireteam_west_smg_1_1"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
      break;
    case "desert":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_2_lod1", "body_mp_western_fireteam_west_smg_1_2_lod1", "body_mp_western_fireteam_west_dmr_1_2_lod1", "body_mp_western_fireteam_west_lmg_1_2_lod1", "body_mp_western_fireteam_west_sg_1_2_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_2", "head_mp_western_fireteam_west_ar_2_2", "head_mp_western_fireteam_west_ar_1_2", "head_mp_western_fireteam_west_ar_2_2"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_2", "head_mp_western_fireteam_west_smg_2_2", "head_mp_western_fireteam_west_smg_1_2"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_2", "head_mp_western_fireteam_west_dmr_2_2"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_2", "head_mp_western_fireteam_west_lmg_2_2"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_2", "head_mp_western_fireteam_west_sg_2_2"];
      break;
    case "woodland":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_3_lod1", "body_mp_western_fireteam_west_smg_1_3_lod1", "body_mp_western_fireteam_west_dmr_1_3_lod1", "body_mp_western_fireteam_west_lmg_1_3_lod1", "body_mp_western_fireteam_west_sg_1_3_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_3", "head_mp_western_fireteam_west_ar_2_3", "head_mp_western_fireteam_west_ar_1_3", "head_mp_western_fireteam_west_ar_2_3"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_3", "head_mp_western_fireteam_west_smg_2_3", "head_mp_western_fireteam_west_smg_1_3"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_3", "head_mp_western_fireteam_west_dmr_2_3"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_3", "head_mp_western_fireteam_west_lmg_2_3"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_3", "head_mp_western_fireteam_west_sg_2_3"];
      break;
    default:
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1", "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1", "head_mp_western_fireteam_west_smg_1_1"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
  }

  switch (game["axis_outfit"]) {
    case "urban":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr", "head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg", "head_mp_eastern_fireteam_east_sg"];
      break;
    case "desert":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_2_lod1", "body_mp_eastern_fireteam_east_smg_2_lod1", "body_mp_eastern_fireteam_east_dmr_2_lod1", "body_mp_eastern_fireteam_east_lmg_2_lod1", "body_mp_eastern_fireteam_east_sg_2_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1_2", "head_mp_eastern_fireteam_east_ar_2_2", "head_mp_eastern_fireteam_east_ar_3_2", "head_mp_eastern_fireteam_east_ar_4_2"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1_2", "head_mp_eastern_fireteam_east_smg_2_2", "head_mp_eastern_fireteam_east_smg_3_2"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr", "head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg", "head_mp_eastern_fireteam_east_sg"];
      break;
    case "woodland":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_3_lod1", "body_mp_eastern_fireteam_east_smg_3_lod1", "body_mp_eastern_fireteam_east_dmr_3_lod1", "body_mp_eastern_fireteam_east_lmg_3_lod1", "body_mp_eastern_fireteam_east_sg_3_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1_3", "head_mp_eastern_fireteam_east_ar_2_3", "head_mp_eastern_fireteam_east_ar_3_3", "head_mp_eastern_fireteam_east_ar_4_3"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1_3", "head_mp_eastern_fireteam_east_smg_2_3", "head_mp_eastern_fireteam_east_smg_3_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr", "head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg", "head_mp_eastern_fireteam_east_sg"];
      break;
    default:
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
  }
}

pickdefaultoperatorskin(weapon) {
  _id_F26451879315CADC = 0;

  if(isDefined(weapon)) {
    _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(weapon);

    switch (_id_CF4209C200F8BBF4) {
      case "weapon_battle":
      case "weapon_assault":
        _id_F26451879315CADC = 0;
        break;
      case "weapon_smg":
        _id_F26451879315CADC = 1;
        break;
      case "weapon_sniper":
      case "weapon_dmr":
        _id_F26451879315CADC = 2;
        break;
      case "weapon_lmg":
        _id_F26451879315CADC = 3;
        break;
      case "weapon_shotgun":
        _id_F26451879315CADC = 4;
        break;
      default:
        _id_F26451879315CADC = 1;
        break;
    }
  }

  return _id_F26451879315CADC;
}

getglcustomization() {
  weapon = self.primaryweapon;
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(weapon);
  _id_0E8F6FDB8F100FF7 = self.loadoutequipmentprimary;
  _id_090A6AFADA84F104 = undefined;
  _id_6D05573579E8816A = undefined;
  _id_555CD24BC240B6A2 = undefined;

  if(_id_0E8F6FDB8F100FF7 == "equip_helmet")
    _id_555CD24BC240B6A2 = "_blstk";
  else
    _id_555CD24BC240B6A2 = "";

  switch (self.team) {
    case "allies":
      faction = "usmc";

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done"))
        _id_2D3B5B36B4481172 = "_wind";
      else
        _id_2D3B5B36B4481172 = "";

      switch (_id_CF4209C200F8BBF4) {
        case "weapon_smg":
        case "weapon_shotgun":
          _id_090A6AFADA84F104 = "_cqc";
          _id_6D05573579E8816A = "_cqc";
          break;
        case "weapon_battle":
        case "weapon_assault":
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
        case "weapon_lmg":
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_lmg";
          break;
        case "weapon_sniper":
        case "weapon_dmr":
          _id_090A6AFADA84F104 = "_cqc";
          _id_6D05573579E8816A = "_cqc";
          break;
        default:
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
      }

      break;
    case "axis":
      faction = "sa_militia";
      _id_2D3B5B36B4481172 = "";

      switch (_id_CF4209C200F8BBF4) {
        case "weapon_smg":
        case "weapon_shotgun":
          _id_090A6AFADA84F104 = "_cqc";
          _id_6D05573579E8816A = "_cqc";
          break;
        case "weapon_battle":
        case "weapon_assault":
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
        case "weapon_lmg":
          _id_090A6AFADA84F104 = "_lmg";
          _id_6D05573579E8816A = "_lmg";
          break;
        case "weapon_sniper":
        case "weapon_dmr":
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
        default:
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
      }

      break;
    default:
      faction = "usmc";
      _id_2D3B5B36B4481172 = "";
      _id_090A6AFADA84F104 = "_ar";
      _id_6D05573579E8816A = "_ar";
      break;
  }

  body = "body_" + faction + _id_090A6AFADA84F104 + _id_2D3B5B36B4481172;
  head = "head_" + faction + _id_6D05573579E8816A + _id_555CD24BC240B6A2;
  self.backuphead = "head_" + faction + _id_6D05573579E8816A;
  self.bodymodelname = "body_" + faction + _id_090A6AFADA84F104;
  _id_56E7CF38A4910BA2 = [];
  _id_56E7CF38A4910BA2[0] = body;
  _id_56E7CF38A4910BA2[1] = head;
  return _id_56E7CF38A4910BA2;
}

getglcustomizationhackney() {
  weapon = self.primaryweapon;
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(weapon);
  _id_0E8F6FDB8F100FF7 = self.loadoutequipmentprimary;
  _id_090A6AFADA84F104 = undefined;
  _id_6D05573579E8816A = undefined;
  _id_555CD24BC240B6A2 = undefined;

  if(_id_0E8F6FDB8F100FF7 == "equip_helmet")
    _id_555CD24BC240B6A2 = "_blstk";
  else
    _id_555CD24BC240B6A2 = "";

  switch (self.team) {
    case "allies":
      faction = "sas_urban";

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done"))
        _id_2D3B5B36B4481172 = "";
      else
        _id_2D3B5B36B4481172 = "_rain";

      switch (_id_CF4209C200F8BBF4) {
        case "weapon_smg":
        case "weapon_shotgun":
          _id_090A6AFADA84F104 = "_cqc";
          _id_6D05573579E8816A = "_mp_cqc";
          break;
        case "weapon_battle":
        case "weapon_assault":
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
        case "weapon_lmg":
          _id_090A6AFADA84F104 = "_lmg";
          _id_6D05573579E8816A = "_lmg";
          break;
        case "weapon_sniper":
        case "weapon_dmr":
          _id_090A6AFADA84F104 = "_dmr";
          _id_6D05573579E8816A = "_mp_dmr";
          break;
        default:
          _id_090A6AFADA84F104 = "_ar";
          _id_6D05573579E8816A = "_ar";
          break;
      }

      break;
    case "axis":
      faction = "al_qatala";
      _id_2D3B5B36B4481172 = "";

      switch (_id_CF4209C200F8BBF4) {
        case "weapon_battle":
        case "weapon_smg":
        case "weapon_shotgun":
        case "weapon_lmg":
        case "weapon_sniper":
        case "weapon_dmr":
        case "weapon_assault":
          _id_090A6AFADA84F104 = "_1_ar";
          _id_6D05573579E8816A = "_ar";
          break;
        default:
          _id_090A6AFADA84F104 = "_1_ar";
          _id_6D05573579E8816A = "_ar";
          break;
      }

      break;
    default:
      faction = "usmc";
      _id_2D3B5B36B4481172 = "";
      _id_090A6AFADA84F104 = "_ar";
      _id_6D05573579E8816A = "_ar";
      break;
  }

  body = "body_" + faction + _id_090A6AFADA84F104 + _id_2D3B5B36B4481172;
  head = "head_" + faction + _id_6D05573579E8816A + _id_2D3B5B36B4481172;
  self.backuphead = "head_" + faction + _id_6D05573579E8816A;
  self.bodymodelname = "body_" + faction + _id_090A6AFADA84F104;
  _id_56E7CF38A4910BA2 = [];
  _id_56E7CF38A4910BA2[0] = body;
  _id_56E7CF38A4910BA2[1] = head;
  return _id_56E7CF38A4910BA2;
}

forcedefaultmodel() {
  if(self.team == "axis") {
    self setModel("mp_fullbody_heavy");
    self setviewmodel("viewmodel_mp_base_iw8");
  } else {
    self setModel("mp_body_infected_a");
    self setviewmodel("viewmodel_mp_base_iw8");
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self attach("head_mp_infected", "", 1);
  self.headmodel = "head_mp_infected";
  self setclothtype("cloth");
}

watchafk() {
  if(getdvarint("dvar_B66208719C6BAE6A", 0) == 1) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_E599E01C671B91C0 = isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0;
  _id_E82B77C55CCC4F76 = gettime();
  _id_07B9BE079890A7B0 = getdvarfloat("dvar_444F3C8B2A24404E", 35);
  _id_07B9BE079890A7B0 = _id_07B9BE079890A7B0 * 1000;
  _id_B5EC3F69645CA491 = getdvarint("dvar_2EA000DB61DABA7B", 30);
  _id_F2B8892CFAA7DF7A = getdvarint("dvar_0EB6378A8E84C183", 60);
  _id_A4C838400457DA2E = getdvarint("dvar_F6ABC159163CDAFA", 60);
  _id_17F6E610B4C861A7 = getdvarint("dvar_DC406362E8A37974", 60);
  _id_CB0D938E64F611FC = getdvarint("dvar_8EEE933F8B6A65EC", 1);
  _id_9BCE2D454A1F6E47 = getdvarint("dvar_DD0BCAD4D12F8993", 1);
  level._id_E04E8F03163C0385 = getdvarint("dvar_213CADD687024445", 15);
  _id_B123D3720D3A03A4 = 0;

  for(;;) {
    _id_B123D3720D3A03A4++;

    if(_id_B123D3720D3A03A4 >= level.players.size)
      _id_B123D3720D3A03A4 = 0;

    if(isDefined(level.players[_id_B123D3720D3A03A4])) {
      if(isai(level.players[_id_B123D3720D3A03A4])) {
        waitframe();
        continue;
      }

      if(level._id_EC2FB549B15AD827) {
        if(_id_CB0D938E64F611FC && _id_E599E01C671B91C0 && gettime() - _id_E82B77C55CCC4F76 < _id_07B9BE079890A7B0)
          level.players[_id_B123D3720D3A03A4] checkforafk(_id_9BCE2D454A1F6E47, _id_B5EC3F69645CA491, _id_F2B8892CFAA7DF7A);
        else
          level.players[_id_B123D3720D3A03A4] checkforafk(_id_9BCE2D454A1F6E47, _id_A4C838400457DA2E, _id_17F6E610B4C861A7);
      } else
        level.players[_id_B123D3720D3A03A4] checkforafk();
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_19300ABFBB10928B() {
  timeplayed = scripts\engine\utility::_id_53C4C53197386572(scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0), 0);
  _id_4CB371A3FCCCCBB6 = scripts\engine\utility::_id_53C4C53197386572(self.pers["timeDead"], 0);
  timeplayed = int(max(timeplayed - _id_4CB371A3FCCCCBB6, 0));

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    timeplayed = timeplayed - scripts\engine\utility::_id_53C4C53197386572(self.timeplayed["gulag"], 0);
    timeplayed = timeplayed - scripts\engine\utility::_id_53C4C53197386572(self.timeplayed["resurgenceRespawn"], 0);
    timeplayed = timeplayed - scripts\engine\utility::_id_53C4C53197386572(self.timeplayed["infil"], 0);
  }

  _id_61C36317DFBAFB1F = scripts\engine\utility::_id_53C4C53197386572(self.pers["timePlayedOnFirstSpawn"], 0);
  return timeplayed - _id_61C36317DFBAFB1F;
}

_id_7B76FFD725358204(time, _id_1DEC950BBB71CDE8, _id_1E6C2CB81CC42E5A) {
  _id_42222D94E3306524 = 0;

  if(time >= _id_1DEC950BBB71CDE8)
    _id_42222D94E3306524 = 2;
  else if(isDefined(_id_1E6C2CB81CC42E5A) && _id_1E6C2CB81CC42E5A > 0 && _id_1DEC950BBB71CDE8 > _id_1E6C2CB81CC42E5A) {
    if(time >= _id_1DEC950BBB71CDE8 - _id_1E6C2CB81CC42E5A)
      _id_42222D94E3306524 = 1;
  }

  return _id_42222D94E3306524;
}

_id_9BA72445F89AAA2F() {
  if(istrue(level.gameended) || !istrue(self.hasspawned))
    return 1;

  if(isDefined(self.c130) || istrue(self.brneverlanded))
    return 1;

  if(istrue(self.ffsm_isgulagrespawn))
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(self.sessionstate == "spectator" || self.sessionstate == "intermission" || self.sessionstate == "playing_but_spectating")
      return 1;

    if(_id_2CEDCC356F1B9FC8::isplayeringulag())
      return 1;

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("dontConsiderAFK") && istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("dontConsiderAFK", self)))
      return 1;

    if(istrue(self.pers["distTrackingPassed"]))
      return 1;
  }

  return 0;
}

checkforafk(_id_6D2F7985DF18659A, _id_55D48EEE7E287CDA, _id_BDBF4608F99AEDB3) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    return;
  }
  if(_id_9BA72445F89AAA2F()) {
    _id_F66FC78C2CB0C0D3(self, "default", 0, 0);
    return;
  }

  if(!isDefined(self._id_73F7116F87A4FAB6))
    self._id_73F7116F87A4FAB6 = 0;
  else if(self._id_73F7116F87A4FAB6 > 0) {
    return;
  }
  if(!isDefined(self.pers["timePlayedOnFirstSpawn"])) {
    return;
  }
  _id_E817FDF4412BA4EC = level._id_E04E8F03163C0385;
  kills = self.pers["kills"];
  assists = self.pers["assists"];
  _id_1AA1F0FB85AA2F76 = scripts\engine\utility::_id_53C4C53197386572(self.pers["downs"], 0);
  _id_80A323CFC33BD9E2 = kills == 0 && assists == 0 && _id_1AA1F0FB85AA2F76 == 0;
  _id_AB0FBBA581D754C8 = 2;

  if(isDefined(self.pers["lastDamageTime"]))
    _id_AB0FBBA581D754C8 = _id_7B76FFD725358204(gettime() - self.pers["lastDamageTime"], 60000, _id_E817FDF4412BA4EC * 1000);

  _id_88D83C00473AB477 = 2;

  if(isDefined(self.pers["lastStanceChangeTime"]))
    _id_88D83C00473AB477 = _id_7B76FFD725358204(gettime() - self.pers["lastStanceChangeTime"], 11000, _id_E817FDF4412BA4EC * 1000);

  _id_2A8062C05D69FCF1 = scripts\engine\utility::_id_53C4C53197386572(self.pers["distTrackingPassedOrResetTime"], 0);
  _id_913292631F9D9E2A = _id_19300ABFBB10928B() - _id_2A8062C05D69FCF1;
  _id_9AF0BD77617D4E0D = 60;
  _id_F6DBA1911B90D82C = _id_80A323CFC33BD9E2 && _id_913292631F9D9E2A > 120;
  _id_D7C6B91D300A1023 = scripts\engine\utility::_id_53C4C53197386572(self._id_03681793BFD7B68E, 0) > gettime();
  _id_0B79528872F8BDDE = istrue(self.pers["distTrackingPassed"]) || _id_D7C6B91D300A1023;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(istrue(self.brkickedfromplane))
      _id_9AF0BD77617D4E0D = getdvarint("dvar_613644AC82DEAD59", 60);
    else
      _id_9AF0BD77617D4E0D = getdvarint("dvar_A6A8CFE5F012E87A", 180);
  } else {
    if(!isDefined(level._id_9AF0BD77617D4E0D)) {
      if(scripts\mp\utility\game::getgametype() == "arena")
        level._id_9AF0BD77617D4E0D = getdvarint("dvar_7F596F03AB14D1B4", 15);
      else if(scripts\mp\utility\game::getgametype() == "ballmode")
        level._id_9AF0BD77617D4E0D = getdvarint("dvar_208180E807D0093B", 60);
      else if(scripts\mp\utility\game::isroundbased())
        level._id_9AF0BD77617D4E0D = getdvarint("dvar_811EB2956DBB3F7D", 120);
      else
        level._id_9AF0BD77617D4E0D = getdvarint("dvar_A6A8CFE5F012E87A", 60);
    }

    _id_9AF0BD77617D4E0D = level._id_9AF0BD77617D4E0D;

    if(isDefined(_id_55D48EEE7E287CDA))
      _id_9AF0BD77617D4E0D = _id_55D48EEE7E287CDA;

    if(isDefined(_id_BDBF4608F99AEDB3))
      level._id_808E471A357552A4 = _id_BDBF4608F99AEDB3;
  }

  if(istrue(level._id_EC2FB549B15AD827) && isDefined(_id_E817FDF4412BA4EC) && _id_E817FDF4412BA4EC > 0 && level._id_808E471A357552A4 > _id_9AF0BD77617D4E0D - _id_E817FDF4412BA4EC)
    level._id_808E471A357552A4 = _id_9AF0BD77617D4E0D - _id_E817FDF4412BA4EC;

  self._id_B0A74A5EFC0D2F8C = 0;
  _id_3D36E66F4DADFE3F = "default";

  if(self _meth_F771642D3445111F() && self.sessionstate == "playing" && _id_80A323CFC33BD9E2 && !_id_0B79528872F8BDDE) {
    self._id_B0A74A5EFC0D2F8C = _id_7B76FFD725358204(_id_913292631F9D9E2A, _id_9AF0BD77617D4E0D, _id_E817FDF4412BA4EC);
    _id_3D36E66F4DADFE3F = "checkForAFK() TRUE, IsCommandInputStale() - " + self.name + "timeSinceLastPassedDistCheck (" + _id_913292631F9D9E2A + ") > afkDistTimeThreshold(" + _id_9AF0BD77617D4E0D + "), lastDistTrackingPassedTime: " + _id_2A8062C05D69FCF1;
  }

  if(self _meth_9EFF7048A5747CC5()) {
    self._id_B0A74A5EFC0D2F8C = 2;
    _id_3D36E66F4DADFE3F = "checkForAFK() TRUE, IsCommandInputRepetitive() - " + self.name + "timeSinceLastPassedDistCheck ( " + _id_913292631F9D9E2A + " ), lastDistTrackingPassedTime: " + _id_2A8062C05D69FCF1;
  }

  if(scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::getgametype() != "ctf") {
    _id_3F775FA731A484C5 = _id_80A323CFC33BD9E2 || level.gametype == "arena" || level.gametype == "ballmode";

    if(level.gametype != "arena") {
      if(_id_F6DBA1911B90D82C) {
        if(_id_AB0FBBA581D754C8 != 0) {
          switch (level.gametype) {
            case "gun":
              if(istrue(level.kick_afk_check))
                self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_AB0FBBA581D754C8);

              break;
          }
        }
      }
    }

    if(_id_3F775FA731A484C5 && !_id_0B79528872F8BDDE) {
      _id_678497FCD540B938 = _id_7B76FFD725358204(_id_913292631F9D9E2A, _id_9AF0BD77617D4E0D, _id_E817FDF4412BA4EC);

      if(scripts\mp\utility\game::getgametype() == "infect") {
        if(self.team == "axis")
          self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_678497FCD540B938);
      } else if(level.gametype == "ballmode") {
        _id_AC1F7E6AECC80188 = isDefined(self.pers["goals"]) && self.pers["goals"] > 0;
        _id_3524F819257867F4 = isDefined(self.pers["assists"]) && self.pers["assists"] > 0;
        _id_4A834A032D48890E = 2;

        if(isDefined(self.pers["lastTouchTime"]))
          _id_7B76FFD725358204(_id_913292631F9D9E2A - self.pers["lastTouchTime"], 60, _id_E817FDF4412BA4EC);

        _id_C8238F8EA16268F7 = 2;

        if(isDefined(self.pers["lastRamTime"]))
          _id_C8238F8EA16268F7 = _id_7B76FFD725358204(_id_913292631F9D9E2A - self.pers["lastRamTime"], 60, _id_E817FDF4412BA4EC);

        if(!_id_AC1F7E6AECC80188 && !_id_3524F819257867F4) {
          _id_58DFEB144008C413 = min(min(_id_4A834A032D48890E, _id_C8238F8EA16268F7), _id_678497FCD540B938);
          self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_58DFEB144008C413);
        }
      } else {
        _id_58DFEB144008C413 = min(_id_678497FCD540B938, _id_88D83C00473AB477);
        self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_58DFEB144008C413);
        _id_3D36E66F4DADFE3F = "checkForAFK() TRUE, " + self.name + "timeSinceLastPassedDistCheck ( " + _id_913292631F9D9E2A + " ), disTrackingPassed: " + _id_0B79528872F8BDDE;
      }
    }

    if(!isDefined(self.pers["roundsAFK"]))
      self.pers["roundsAFK"] = 0;

    _id_FD2FFF5CE3D12EE0 = istrue(_id_6D2F7985DF18659A);

    if(!istrue(_id_6D2F7985DF18659A)) {
      if(self._id_B0A74A5EFC0D2F8C == 2 && !istrue(self.afkroundcounted)) {
        self.afkroundcounted = 1;
        self.pers["roundsAFK"]++;

        if(self.pers["roundsAFK"] > 1)
          _id_FD2FFF5CE3D12EE0 = 1;
      }
    }

    _id_F66FC78C2CB0C0D3(self, _id_3D36E66F4DADFE3F, self._id_B0A74A5EFC0D2F8C, _id_FD2FFF5CE3D12EE0);
    return;
  } else {
    if(!isDefined(self._id_CB9581FC7FF5F394) || self._id_CB9581FC7FF5F394 < 3) {
      if(_id_80A323CFC33BD9E2) {
        _id_B8C4C1E4916A6D00 = _id_7B76FFD725358204(_id_913292631F9D9E2A, _id_9AF0BD77617D4E0D, _id_E817FDF4412BA4EC);
        _id_58DFEB144008C413 = min(_id_B8C4C1E4916A6D00, _id_AB0FBBA581D754C8);

        if(!_id_0B79528872F8BDDE) {
          if(scripts\mp\utility\game::getgametype() == "infect") {
            if(self.team == "axis")
              self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_58DFEB144008C413);
          } else {
            self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_58DFEB144008C413);
            _id_3D36E66F4DADFE3F = "checkForAFK() TRUE, Non Round Based " + self.name + "( noKillsOrAssists(" + _id_80A323CFC33BD9E2 + ") && !recentDamageState(" + _id_AB0FBBA581D754C8 + ") && timeSinceLastPassedDistCheck(" + _id_913292631F9D9E2A + ") >= afkDistTimeThreshold(" + _id_9AF0BD77617D4E0D + "), lastDistTrackingPassedTime: " + _id_2A8062C05D69FCF1;
          }
        }
      }
    }

    if(_id_F6DBA1911B90D82C) {
      if(_id_AB0FBBA581D754C8 != 0) {
        switch (level.gametype) {
          case "gun":
            if(istrue(level.kick_afk_check))
              self._id_B0A74A5EFC0D2F8C = max(self._id_B0A74A5EFC0D2F8C, _id_AB0FBBA581D754C8);

            break;
        }
      }
    }
  }

  _id_F66FC78C2CB0C0D3(self, _id_3D36E66F4DADFE3F, self._id_B0A74A5EFC0D2F8C, 1);
}

kickafkplayer(player, _id_401C3A2E68AAB0FD) {
  player endon("disconnect");

  if(istrue(player._id_72C19B43B99E7097)) {
    return;
  }
  if(isDefined(_id_401C3A2E68AAB0FD)) {}

  player notify("afk_disconnection_imminent");
  player._id_72C19B43B99E7097 = 1;
  wait 1;
  kick(player getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

_id_F66FC78C2CB0C0D3(player, _id_401C3A2E68AAB0FD, _id_B0A74A5EFC0D2F8C, _id_FD2FFF5CE3D12EE0) {
  if(_id_B0A74A5EFC0D2F8C == 2 && istrue(_id_FD2FFF5CE3D12EE0))
    level thread kickafkplayer(player, _id_401C3A2E68AAB0FD);
  else if(_id_B0A74A5EFC0D2F8C == 1 && !istrue(player._id_A34845BE1B8D5CB5)) {
    player._id_A34845BE1B8D5CB5 = 1;
    player setclientomnvar("ui_afk_warning", 1);
  } else if(_id_B0A74A5EFC0D2F8C == 0 && istrue(player._id_A34845BE1B8D5CB5)) {
    player._id_A34845BE1B8D5CB5 = 0;
    player setclientomnvar("ui_afk_warning", 0);
  }
}

getjointeampermissions(team) {
  _id_652F47620AC4713F = 0;
  _id_F4343E072926C2F9 = 0;
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      _id_652F47620AC4713F++;

      if(isbot(player))
        _id_F4343E072926C2F9++;
    }
  }

  if(level.maxteamsize == 0 || _id_652F47620AC4713F < level.maxteamsize)
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "vip" && istrue(isagent(self)))
    return 1;
  else if(_id_F4343E072926C2F9 > 0)
    return 1;
  else if(!scripts\mp\utility\game::matchmakinggame())
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "infect")
    return 1;
  else if(scripts\mp\utility\game::_id_D7EC918E29C0B2F4())
    return 1;
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk"))
    return 1;
  else {
    dlog_recordevent("mp_exceeded_team_max_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);

    if(self ishost())
      wait 1.5;

    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
    return 0;
  }
}

onplayerspawned() {
  if(!isDefined(self.pers["timePlayedOnFirstSpawn"]))
    self.pers["timePlayedOnFirstSpawn"] = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed");

  if(getdvarint("dvar_E4B249F4F77BB3C8", 0) == 1 && !scripts\mp\utility\game::runleanthreadmode()) {
    if(_id_58BE75C518BF0D40::issquadmode())
      thread outlinesquad_apply();
    else
      thread outlinefriendly_apply();
  }
}

outlinefriendly_apply() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(getdvarint("dvar_4B96E5B179C4E4BA", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    return;
  }
  if(scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("prematch_done")))
    level waittill("prematch_over");

  _id_4430B08D5A2D47BF = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "outline_ally_night", "outline_ally");
  outlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, _id_4430B08D5A2D47BF, "level_script");
  thread outlinefriendly_remove(outlineid);
}

outlinefriendly_remove(outlineid) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "joined_team");
  scripts\mp\utility\outline::outlinedisable(outlineid, self);
}

outlinesquad_apply() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(getdvarint("dvar_72CC1D5B07EEE147", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    return;
  }
  if(scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("prematch_done")))
    level waittill("prematch_over");

  _id_4430B08D5A2D47BF = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "outline_squad_night", "outline_squad");
  outlineid = scripts\mp\utility\outline::outlineenableforsquad(self, self.team, self._id_0FF97225579DE16A, _id_4430B08D5A2D47BF, "level_script");
  thread outlinesquad_remove(outlineid);
}

outlinesquad_remove(outlineid) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "joined_squad");
  scripts\mp\utility\outline::outlinedisable(outlineid, self);
}

_id_ADA9A2308A4046E2(operatorref) {
  suit = tablelookup("operators.csv", 1, operatorref, 19);

  if(!isDefined(suit) || suit == "")
    suit = "iw9_suit_generic_west_mp";

  return suit;
}

getoperatorexecution(operatorref) {
  if(getDvar("dvar_F84554214A05EA42", "0") != "0") {
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, getDvar("dvar_32773035C57E71D9", 0), 1);
    return self.loadoutexecution;
  }

  _id_90B23EDBB5FCA35C = 0;

  if(!isagent(self))
    _id_90B23EDBB5FCA35C = scripts\mp\class::_id_05A29E896A16B251(operatorref);

  if(_id_90B23EDBB5FCA35C == 0)
    self.loadoutexecution = tablelookup("operators.csv", 1, operatorref, 24);
  else
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, _id_90B23EDBB5FCA35C, 1);

  return self.loadoutexecution;
}

getoperatorexecutionquip(operatorref) {
  _id_635CB55857199A8D = 0;

  if(!isagent(self))
    _id_635CB55857199A8D = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "taunt");

  if(_id_635CB55857199A8D == 0)
    self.loadoutexecutionquip = tablelookup("operators.csv", 1, operatorref, 23);
  else
    self.loadoutexecutionquip = tablelookup("operatorquips.csv", 0, _id_635CB55857199A8D, 6);

  return self.loadoutexecutionquip;
}

getoperatorsuperfaction(operatorref) {
  faction = tablelookup("operators.csv", 1, operatorref, 3);
  return int(faction);
}

getoperatorvoice(operatorref, _id_5864EA4E21A60CD4) {
  if(operatorref == "default_eastern" || operatorref == "default_western") {
    voice = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 25);

    if(isDefined(voice) && voice != "")
      return voice;
  }

  voice = tablelookup("operators.csv", 1, operatorref, 10);
  return voice;
}

getoperatorclothtype(_id_5864EA4E21A60CD4) {
  clothtype = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 22);
  return clothtype;
}

_id_E8770349A2B50BEC(_id_5864EA4E21A60CD4) {
  _id_400EF51562606E7A = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 23);
  return _id_400EF51562606E7A;
}

getoperatorgender(operatorref) {
  gender = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, operatorref, 11) == "0", "male", "female");
  return gender;
}

_id_29B2AF59258D6501(_id_962EF6817910EC78) {
  _id_0C26FC18BDA607B7 = tablelookup("operatorskins.csv", 0, _id_962EF6817910EC78, 1);
  _id_D947B7E87C7243AB = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_0C26FC18BDA607B7);
  return _id_D947B7E87C7243AB;
}

getoperatorbrinfilsmokesuffix() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_0E4731409BD255E0 = undefined;
    lootid = self getplayerdata("common", "commonCustomization", "contrail");

    if(isDefined(lootid) && lootid != 0) {
      if(isDefined(level._id_A36FDB48E33DEE79) && isDefined(level._id_A36FDB48E33DEE79[lootid]))
        _id_0E4731409BD255E0 = level._id_A36FDB48E33DEE79[lootid].ref;
    }

    return _id_0E4731409BD255E0;
  }

  return undefined;
}

_id_A317055D4D0A4605(_id_5864EA4E21A60CD4) {
  return _id_87E69B1672994E10(_id_5864EA4E21A60CD4, 28);
}

_id_81360519D4836BF7(_id_5864EA4E21A60CD4) {
  return _id_87E69B1672994E10(_id_5864EA4E21A60CD4, 29);
}

_id_08D92D3FB88A9D34(_id_5864EA4E21A60CD4) {
  return _id_87E69B1672994E10(_id_5864EA4E21A60CD4, 30);
}

_id_E0B3EFF8C73F5475(_id_5864EA4E21A60CD4) {
  return _id_87E69B1672994E10(_id_5864EA4E21A60CD4, 31);
}

_id_A3195A1D60BB2D90(_id_5864EA4E21A60CD4) {
  return _id_87E69B1672994E10(_id_5864EA4E21A60CD4, 32);
}

_id_87E69B1672994E10(_id_5864EA4E21A60CD4, _id_B87123A102AA36DA) {
  _id_FC8AFB765C52482B = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, _id_B87123A102AA36DA);

  if(_id_FC8AFB765C52482B != "")
    return int(_id_FC8AFB765C52482B);
}

initnightvisionheadoverrides() {
  if(!scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
    return;
  }
  level.nvgheadoverrides = [];
  _id_962EF6817910EC78 = 0;

  for(;;) {
    head = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 5);
    _id_8CAF1716B3192F8F = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 17);
    _id_F164251D2631366A = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 16);

    if(!isDefined(head) || head == "") {
      break;
    }

    if(_id_8CAF1716B3192F8F != "")
      level.nvgheadoverrides[head]["up"] = _id_8CAF1716B3192F8F;

    if(_id_F164251D2631366A != "")
      level.nvgheadoverrides[head]["down"] = _id_F164251D2631366A;

    _id_962EF6817910EC78++;
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1_3"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2_3"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
}

initheadlessoperatorcustomization() {
  if(isDefined(level.headlessoperatorcustomization)) {
    return;
  }
  level.headlessoperatorcustomization = [];
  _id_F87730061DCB36C4 = tablelookupgetnumrows("operatorskins.csv");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F87730061DCB36C4; _id_AC0E594AC96AA3A8++) {
    if(tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 18) != "") {
      operatorref = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 2);
      lootid = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 0);

      if(!isDefined(level.headlessoperatorcustomization[operatorref])) {
        level.headlessoperatorcustomization[operatorref]["lootIDs"] = [];
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
        level.headlessoperatorcustomization[operatorref]["maxIndex"] = 0;
      }

      level.headlessoperatorcustomization[operatorref]["lootIDs"][level.headlessoperatorcustomization[operatorref]["lootIDs"].size] = int(lootid);
      level.headlessoperatorcustomization[operatorref]["maxIndex"] = level.headlessoperatorcustomization[operatorref]["maxIndex"] + 1;
    }
  }
}

_id_D650608C959C9675() {
  if(isDefined(level._id_B113F6FE0E7C93BF)) {
    return;
  }
  level._id_B113F6FE0E7C93BF = [];
  setDvar("dvar_2B669AD6C3E1D864", 1);
  setdvarifuninitialized("dvar_98C5CADF936AEB15", "");
  _id_B96BB7CC6652F794 = ["shared_iw9_t10"];
  _id_4D466347829517D4 = getDvar("dvar_98C5CADF936AEB15", "");

  if(_id_4D466347829517D4 != "") {
    _id_3F859A3D7AF673E9 = strtok(_id_4D466347829517D4, " ");
    _id_B96BB7CC6652F794 = scripts\engine\utility::array_combine(_id_B96BB7CC6652F794, _id_3F859A3D7AF673E9);
  }

  _id_91CB23E7AB33F8EF = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 1);

    if(!isDefined(operatorref) || operatorref == "") {
      break;
    }

    _id_31BA528E4A274A85 = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 32);

    if(scripts\engine\utility::array_contains(_id_B96BB7CC6652F794, _id_31BA528E4A274A85)) {
      superfaction = getoperatorsuperfaction(operatorref);
      team = scripts\engine\utility::ter_op(superfaction == 0, "allies", "axis");
      _id_7BE8B486A10B3DE8 = int(tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 8));

      if(_id_7BE8B486A10B3DE8) {
        if(!isDefined(level._id_B113F6FE0E7C93BF[team]))
          level._id_B113F6FE0E7C93BF[team] = [];

        level._id_B113F6FE0E7C93BF[team][operatorref] = [];
      }
    }

    _id_91CB23E7AB33F8EF++;
  }

  _id_962EF6817910EC78 = 0;

  for(;;) {
    _id_DF0CFCC0964ACC07 = int(tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 20));
    skinref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 1);
    lootid = int(tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 0));

    if(!isDefined(skinref) || skinref == "") {
      break;
    }

    if(_id_DF0CFCC0964ACC07) {
      operatorref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 2);
      team = getoperatorteambyref(operatorref);

      if(!isDefined(team)) {
        _id_962EF6817910EC78++;
        continue;
      }

      level._id_B113F6FE0E7C93BF[team][operatorref][level._id_B113F6FE0E7C93BF[team][operatorref].size] = lootid;
    }

    _id_962EF6817910EC78++;
  }
}

_id_1B5C55CB118D5CB4(_id_F2FBF2F4F3D38A71) {
  operatorref = tablelookup("operatorskins.csv", 0, _id_F2FBF2F4F3D38A71, 2);
  return operatorref;
}

_id_BE562399EFB845E4(skinref) {
  _id_F2FBF2F4F3D38A71 = tablelookup("operatorskins.csv", 1, skinref, 0);
  return _id_F2FBF2F4F3D38A71;
}

_id_B6B7981D7ED1B94F(executionref) {
  _id_90B23EDBB5FCA35C = tablelookup("mp_cp/executiontable.csv", 1, executionref, 0);
  return _id_90B23EDBB5FCA35C;
}

getoperatorteambyref(operatorref) {
  foreach(team, _id_B6217B906C6BE73E in level._id_B113F6FE0E7C93BF) {
    foreach(operator, _id_0BFBF0D4002DD345 in _id_B6217B906C6BE73E) {
      if(operator == operatorref)
        return team;
    }
  }

  return undefined;
}

getnextoperatorindex(operatorref, _id_96BDB02C18792E2F) {
  if(!_id_96BDB02C18792E2F) {
    _id_BF657FE9053A3502 = 0;

    foreach(_id_48232C7BE8E19692, _id_3FDC6738D163B2E9 in level._id_B113F6FE0E7C93BF[self.team]) {
      if(operatorref == _id_48232C7BE8E19692) {
        break;
      }

      _id_BF657FE9053A3502++;
    }

    _id_D9EE2DF2FB804DF2 = undefined;
    _id_6F74DCA2E27406FB = _id_BF657FE9053A3502 + 1;

    if(_id_6F74DCA2E27406FB == level._id_B113F6FE0E7C93BF[self.team].size)
      _id_6F74DCA2E27406FB = 0;

    return _id_6F74DCA2E27406FB;
  } else
    return randomint(level._id_B113F6FE0E7C93BF[self.team].size);
}

getnextskinindex(operatorref, _id_96BDB02C18792E2F) {
  if(!_id_96BDB02C18792E2F) {
    clientnum = self getentitynumber();
    operatorskinindex = undefined;

    if(isai(self))
      operatorskinindex = self.botskinid;
    else
      operatorskinindex = scripts\mp\class::_id_70763795B02C14F4(operatorref);

    _id_CC7629D19A4C4809 = tablelookup("operatorskins.csv", 0, operatorskinindex, 1);
    _id_5398277FFDAB5211 = 0;

    foreach(_id_0C26FC18BDA607B7, _id_56E7CF38A4910BA2 in level._id_B113F6FE0E7C93BF[self.team][operatorref]) {
      if(_id_CC7629D19A4C4809 == _id_0C26FC18BDA607B7) {
        break;
      }

      _id_5398277FFDAB5211++;
    }

    _id_86D485AA7553B47C = _id_5398277FFDAB5211 + 1;

    if(_id_86D485AA7553B47C == level._id_B113F6FE0E7C93BF[self.team][operatorref].size)
      _id_86D485AA7553B47C = 0;

    return _id_86D485AA7553B47C;
  } else
    return randomint(level._id_B113F6FE0E7C93BF[self.team][operatorref].size);
}

getplayerlookattarget() {
  startpos = self getEye();
  _id_8C57EF0D95A6EE0C = self getplayerangles();
  fwd = anglesToForward(_id_8C57EF0D95A6EE0C);
  endpos = startpos + fwd * 10000;
  _id_8D727BC70842A709 = ["physicscontents_characterproxy"];
  _id_30D537EA3164E799 = physics_createcontents(_id_8D727BC70842A709);
  _id_8C685A74E876C0FD = scripts\engine\trace::sphere_trace(startpos, endpos, 5.0, self, _id_30D537EA3164E799, 0);
  _id_8B39D5984DA1DC7F = _id_8C685A74E876C0FD["entity"];

  if(isDefined(_id_8B39D5984DA1DC7F) && isPlayer(_id_8B39D5984DA1DC7F))
    return _id_8B39D5984DA1DC7F;
  else
    return undefined;
}

devmonitoroperatorcustomizationprint() {
  for(;;) {
    waitframe();
    players = [];

    if(getdvarint("dvar_A61D9425DD087DDF", 0) != 0) {
      _id_D650608C959C9675();
      players = level.players;
    }

    if(getdvarint("dvar_E71BF09704D58AAD", 0) != 0) {
      _id_D650608C959C9675();
      target = level.players[0] getplayerlookattarget();

      if(!isDefined(target)) {
        continue;
      }
      players[0] = target;
    }

    if(players.size > 0) {
      foreach(player in players)
      player printcustomization();
    }
  }
}

printcustomization() {
  if(!scripts\mp\utility\teams::isgameplayteam(self.team)) {
    return;
  }
  _id_1CEEF035C3F3046D = getoperatorcustomization();
}

persistantgametypeteamassign() {
  team = undefined;
  count = 1;

  if(istrue(level.onlinegame)) {
    _id_06980251E86D0A47 = self getfireteammembers();
    count = _id_06980251E86D0A47.size;

    if(isDefined(_id_06980251E86D0A47) && _id_06980251E86D0A47.size > 0) {
      foreach(_id_80EF668C09FFB70F in _id_06980251E86D0A47) {
        if(isDefined(_id_80EF668C09FFB70F) && scripts\mp\utility\teams::isgameplayteam(_id_80EF668C09FFB70F.team)) {
          team = _id_80EF668C09FFB70F.team;
          self.teamstarttime = _id_80EF668C09FFB70F.teamstarttime;
          break;
        }
      }
    }
  }

  if(!isDefined(team))
    team = findavailableteam(count);

  if(!isDefined(self.teamstarttime))
    self.teamstarttime = gettime();

  thread scripts\mp\menus::setteam(team);
}

findavailableteam(count) {
  if(!isDefined(count))
    count = 1;

  team = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamcount(_id_F90358454413407F);
    available = level.maxteamsize - _id_652F47620AC4713F;

    if(available < count) {
      continue;
    }
    if(_id_652F47620AC4713F > 0) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");

      if(isDefined(_id_A6AB8D0FDA441DC2[0].teamstarttime) && gettime() > _id_A6AB8D0FDA441DC2[0].teamstarttime + 300000)
        continue;
    }

    team = _id_F90358454413407F;
    break;
  }

  return team;
}

_id_14A6F65E85694C21() {
  _id_652F47620AC4713F = 0;

  foreach(teamdata in level.teamdata) {
    if(isDefined(teamdata["teamCount"]) && teamdata["teamCount"] > 0)
      _id_652F47620AC4713F++;
  }

  return _id_652F47620AC4713F;
}

getactiveteamcount() {
  _id_652F47620AC4713F = 0;

  foreach(teamdata in level.teamdata) {
    if(isDefined(teamdata["aliveCount"]) && teamdata["aliveCount"] > 0)
      _id_652F47620AC4713F++;
  }

  return _id_652F47620AC4713F;
}

debugprintteams() {
  _id_63F43F469B885EC6 = 25;

  for(;;) {
    if(isDefined(level.teamdata)) {
      _id_1B11EAA9B42E5081 = 400;
      _id_1B11E9A9B42E4E4E = 200;
      _id_7918C27CB3E1349A = 1;
      _id_652F47620AC4713F = 0;

      foreach(team in level.teamnamelist) {
        _id_7918C27CB3E1349A = 1;
        _id_7918C27CB3E1349A++;

        foreach(player in level.teamdata[team]["players"]) {
          color = (1, 1, 1);

          if(istrue(player.squadassignedfromlobby))
            color = (0, 1, 0);

          _id_7918C27CB3E1349A++;
        }

        _id_1B11E9A9B42E4E4E = _id_1B11E9A9B42E4E4E + _id_63F43F469B885EC6 * _id_7918C27CB3E1349A + 50;
        _id_652F47620AC4713F++;

        if(_id_652F47620AC4713F > 6) {
          _id_652F47620AC4713F = 0;
          _id_1B11EAA9B42E5081 = _id_1B11EAA9B42E5081 + 200;
          _id_1B11E9A9B42E4E4E = 200;
        }
      }
    }

    waitframe();
  }
}