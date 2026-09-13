/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\scoreboard.gsc
***********************************************/

processlobbyscoreboards() {
  processmatchscoreboardinfo();

  foreach(player in level.players)
  processcommonplayerdataforplayer(player);
}

processmatchscoreboardinfo() {
  if(level.multiteambased) {
    buildscoreboardtype("multiteam");

    foreach(player in level.players)
    player setplayerdata("common", "round", "scoreboardType", "multiteam");

    if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
      return;
    }
  } else if(level.teambased) {
    _id_43A41488C3C487DF = getteamscore("allies");
    _id_18A3FAB290E780C2 = getteamscore("axis");
    kills = 0;
    deaths = 0;

    foreach(player in level.players) {
      if(isDefined(player.pers["team"]) && player.pers["team"] == "allies") {
        kills = kills + player.pers["kills"];
        deaths = deaths + player.pers["deaths"];
      }
    }

    winner = "tie";

    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        if(game["timeToBeatTeam"] == "none") {
          if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", 0);
            setclientmatchdata("axisTTB", 0);
          }

          winner = "tie";
        } else {
          if("allies" == game["timeToBeatTeam"])
            _id_43A41488C3C487DF++;
          else
            _id_18A3FAB290E780C2++;

          if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
            setclientmatchdata("alliesTTB", scripts\engine\utility::ter_op("allies" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
            setclientmatchdata("axisTTB", scripts\engine\utility::ter_op("axis" == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          }

          winner = game["timeToBeatTeam"];
        }
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {}
    } else if(_id_43A41488C3C487DF == _id_18A3FAB290E780C2)
      winner = "tie";
    else if(_id_43A41488C3C487DF > _id_18A3FAB290E780C2)
      winner = "allies";
    else
      winner = "axis";

    if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", _id_43A41488C3C487DF);
      setclientmatchdata("axisScore", _id_18A3FAB290E780C2);
      setclientmatchdata("alliesKills", kills);
      setclientmatchdata("alliesDeaths", deaths);
    }

    if(winner == "tie") {
      buildscoreboardtype("allies");
      buildscoreboardtype("axis");

      foreach(player in level.players) {
        _id_E59C38A3A9665CFB = player.pers["team"];

        if(!isDefined(_id_E59C38A3A9665CFB)) {
          continue;
        }
        if(_id_E59C38A3A9665CFB == "spectator" || _id_E59C38A3A9665CFB == "codcaster") {
          player setplayerdata("common", "round", "scoreboardType", "allies");
          continue;
        }

        player setplayerdata("common", "round", "scoreboardType", _id_E59C38A3A9665CFB);
      }

      return;
    }

    buildscoreboardtype(winner);

    foreach(player in level.players)
    player setplayerdata("common", "round", "scoreboardType", winner);

    return;
  } else {
    buildscoreboardtype("neutral");

    foreach(player in level.players)
    player setplayerdata("common", "round", "scoreboardType", "neutral");

    if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
      setclientmatchdata("alliesScore", -1);
      setclientmatchdata("axisScore", -1);
      setclientmatchdata("alliesKills", -1);
      setclientmatchdata("alliesDeaths", -1);
    }
  }
}

processcommonplayerdataforplayer(player) {
  if(isDefined(player.pers["summary"])) {
    player setplayerdata("common", "round", "totalXp", player.pers["summary"]["xp"]);
    player setplayerdata("common", "round", "scoreXp", player.pers["summary"]["score"]);
    player setplayerdata("common", "round", "challengeXp", player.pers["summary"]["challenge"]);
    player setplayerdata("common", "round", "matchXp", player.pers["summary"]["match"]);
    player setplayerdata("common", "round", "miscXp", player.pers["summary"]["misc"]);
    player setplayerdata("common", "round", "medalXp", player.pers["summary"]["medal"]);
    player setplayerdata("common", "common_entitlement_xp", player.pers["summary"]["bonusXP"]);
  }
}

setplayerscoreboardinfo() {
  if(getdvarint("online_mp_clientmatchdata_enabled") == 0) {
    return;
  }
  _id_6E36503E0D5BC975 = getclientmatchdata("scoreboardPlayerCount");

  if(_id_6E36503E0D5BC975 < 200) {
    if(isDefined(self.pers["score"]))
      setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);

    if(isDefined(self.pers["kills"])) {
      kills = self.pers["kills"];
      setclientmatchdata("players", self.clientmatchdataid, "kills", kills);
    }

    if(scripts\mp\utility\game::getgametype() == "dm" || scripts\mp\utility\game::getgametype() == "gun")
      assists = self.assists;
    else if(isDefined(self.pers["assists"]))
      assists = self.pers["assists"];
    else
      assists = 0;

    setclientmatchdata("players", self.clientmatchdataid, "assists", assists);

    if(isDefined(self.pers["deaths"])) {
      deaths = self.pers["deaths"];
      setclientmatchdata("players", self.clientmatchdataid, "deaths", deaths);
    }

    if(isDefined(self.pers["team"])) {
      team = self.pers["team"];
      setclientmatchdata("players", self.clientmatchdataid, "team", team);

      if(isDefined(game[self.pers["team"]])) {
        faction = game[self.pers["team"]];
        setclientmatchdata("players", self.clientmatchdataid, "faction", faction);
      }
    }

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(isDefined(self.playercardbackground)) {
        playercardbackground = self.playercardbackground;
        setclientmatchdata("players", self.clientmatchdataid, "extrascore0", playercardbackground);
      }
    } else if(isDefined(self.pers["extrascore0"])) {
      extrascore0 = self.pers["extrascore0"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore0", extrascore0);
    }

    if(isDefined(self.pers["extrascore1"])) {
      extrascore1 = self.pers["extrascore1"];
      setclientmatchdata("players", self.clientmatchdataid, "extrascore1", extrascore1);
    }

    if(isDefined(self.timeplayed["total"])) {
      timeplayed = self.timeplayed["total"];
      setclientmatchdata("players", self.clientmatchdataid, "timeplayed", timeplayed);
    }

    if(isDefined(self.pers["rank"]) && isDefined(self.pers["rankxp"])) {
      _id_00AE17C5A8B1BC1B = scripts\mp\rank::getrank();
      setclientmatchdata("players", self.clientmatchdataid, "rank", _id_00AE17C5A8B1BC1B);
    }

    if(isDefined(self.pers["prestige"])) {
      _id_C52868E86C820DE4 = scripts\mp\rank::getprestigelevel();
      setclientmatchdata("players", self.clientmatchdataid, "prestige", _id_C52868E86C820DE4);
    }

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_7746CA3B56C9AFD3 = _id_1E4A61DB11011446::calculateclientmatchdataextrainfopayload(self);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7746CA3B56C9AFD3.size; _id_AC0E594AC96AA3A8++) {
        _id_1ABC650BB92E6E04 = "extrascore" + _id_AC0E594AC96AA3A8;
        setclientmatchdata("players", self.clientmatchdataid, _id_1ABC650BB92E6E04, _id_7746CA3B56C9AFD3[_id_AC0E594AC96AA3A8]);
      }

      if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder") {
        _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
        placement = _id_C3E10A42A81ADE25[self.team];

        if(isDefined(placement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", placement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("plunder", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
        lootcachesopened = 0;

        if(isDefined(self.lootcachesopened))
          lootcachesopened = self.lootcachesopened;

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", lootcachesopened);
      } else if(scripts\mp\utility\game::getsubgametype() == "kingslayer") {
        _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
        placement = _id_C3E10A42A81ADE25[self.team];
        setclientmatchdata("players", self.clientmatchdataid, "placement", placement);
        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("kingslayer", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
        lootcachesopened = 0;

        if(isDefined(self.lootcachesopened))
          lootcachesopened = self.lootcachesopened;

        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", lootcachesopened);
      } else if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("resurgence", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
      } else if(scripts\mp\utility\game::getsubgametype() == "resurgence_mgl") {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("resurgence_mgl", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
      } else if(scripts\mp\utility\game::getsubgametype() == "champion") {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("champion", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
      } else if(scripts\mp\utility\game::getsubgametype() == "zonecontrol") {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("zonecontrol", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82[0]);
        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", _id_081DAB8953B9DF82[1]);
      } else if(scripts\mp\utility\game::getsubgametype() == "zxp") {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("zxp", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82[0]);
        setclientmatchdata("players", self.clientmatchdataid, "extrascore5", _id_081DAB8953B9DF82[1]);
      } else {
        if(isDefined(self.teamplacement))
          setclientmatchdata("players", self.clientmatchdataid, "placement", self.teamplacement);

        _id_081DAB8953B9DF82 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "packClientMatchData")]]();
        setclientmatchdata("players", self.clientmatchdataid, "extrascore4", _id_081DAB8953B9DF82);
      }
    }

    _id_6E36503E0D5BC975++;
    setclientmatchdata("scoreboardPlayerCount", _id_6E36503E0D5BC975);
    maxplayercount = getdvarint("party_maxplayers", 0);
    setclientmatchdata("maxPlayerCount", maxplayercount);
  } else {}
}

computescoreboardslot(team, index) {
  if(team == "none")
    return 0 + index;

  if(team == "neutral")
    return 200 + index;

  if(team == "allies")
    return 400 + index;

  if(team == "axis")
    return 600 + index;

  if(team == "multiteam")
    return 800 + index;

  return 0;
}

buildscoreboardtype(team) {
  if(getdvarint("online_mp_clientmatchdata_enabled") == 0) {
    return;
  }
  if(team == "multiteam" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    index = 0;

    foreach(_id_FABF84450735DD93 in level.teamnamelist) {
      _id_7273312620004BC3 = undefined;

      if(isDefined(level.placement))
        _id_7273312620004BC3 = level.placement[_id_FABF84450735DD93];

      if(!isDefined(_id_7273312620004BC3))
        _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

      foreach(player in _id_7273312620004BC3) {
        scripts\mp\gamelogic::assignclientmatchdataid(player);
        setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
        index++;
      }
    }
  } else if(team == "neutral") {
    index = 0;

    foreach(player in level.placement["all"]) {
      setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
      index++;
    }
  } else {
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    index = 0;

    foreach(player in level.placement[team]) {
      setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
      index++;
    }

    foreach(player in level.placement[otherteam]) {
      setclientmatchdata("scoreboards", computescoreboardslot(team, index), player.clientmatchdataid);
      index++;
    }
  }
}