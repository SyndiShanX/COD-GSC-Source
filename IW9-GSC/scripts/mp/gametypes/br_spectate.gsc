/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_spectate.gsc
************************************************/

spectate_init() {
  level thread updateactivespectatorcounts();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_AA1A345E6EC0499B);
}

initplayer() {
  playerclearspectatekillchainsystem();
}

getbestspectatecandidate(victim, attacker, _id_E65AF3DBF45178E6) {
  playertospectate = _id_0EE535FC3C5AF554(victim, attacker, _id_E65AF3DBF45178E6);

  if(getdvarint("dvar_B09C8A3C1763BE50", 0) && !isbot(victim)) {
    if(isDefined(playertospectate))
      logstring("Get best spectator with id: " + playertospectate getentitynumber() + " name: " + playertospectate.name + " origin: " + playertospectate.origin);
    else {
      _id_E1E65E11F75F9CBB = 0;

      if(isDefined(level._id_7B37B2193F163B9B))
        _id_E1E65E11F75F9CBB = level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;

      logstring("Fail to find suitable player to spectate, total players: " + level.players.size + " UIBots: " + _id_E1E65E11F75F9CBB);
    }
  }

  return playertospectate;
}

_id_0EE535FC3C5AF554(victim, attacker, _id_E65AF3DBF45178E6) {
  playertospectate = undefined;

  if(istrue(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getBestSpectateCandidate"))) {
    playertospectate = _id_362C58E8BB39BCDA::runbrgametypefunc("getBestSpectateCandidate", victim, attacker);

    if(isvalidspectatetarget(playertospectate))
      return playertospectate;
  }

  if(istrue(victim.gulag) && _id_5BC60484D17FA95C::_id_1980065CE4DC067B() && !istrue(_id_E65AF3DBF45178E6)) {
    _id_C9B50559B928DD40 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(victim);

    if(isvalidspectatetarget(_id_C9B50559B928DD40))
      return _id_C9B50559B928DD40;
  }

  if(isDefined(victim.nextplayertospectate)) {
    playertospectate = getnextspectatecandidatefromchain(victim.nextplayertospectate);
    victim.nextplayertospectate = undefined;
  }

  if(!isvalidspectatetarget(playertospectate))
    playertospectate = victim _id_5BAB271917698DC4::playergetbestrespawnteammate(undefined, undefined, 1);

  if(!isvalidspectatetarget(playertospectate) && isDefined(victim.team)) {
    friendlies = scripts\mp\utility\teams::getfriendlyplayers(victim.team);
    playertospectate = _id_964FB56006392A0F(victim, friendlies);
  }

  if(!isvalidspectatetarget(playertospectate) && isDefined(attacker) && isPlayer(attacker)) {
    attackerteam = attacker.team;
    victimteam = victim.team;

    if(!isDefined(attackerteam) || !isDefined(victimteam) || attackerteam != victimteam) {
      if(isalive(attacker) && !istrue(attacker.gulag) && !istrue(attacker.inlaststand))
        playertospectate = attacker;
      else if(isDefined(attackerteam)) {
        _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(attackerteam);
        playertospectate = _id_964FB56006392A0F(victim, _id_6D5ED003AF1F9612);
      }
    }
  }

  if(!isvalidspectatetarget(playertospectate) && isDefined(attacker) && isPlayer(attacker) && attacker != victim)
    playertospectate = getnextspectatecandidatefromchain(attacker);

  if(!isvalidspectatetarget(playertospectate))
    playertospectate = _id_964FB56006392A0F(victim, level.players);

  if(!isvalidspectatetarget(playertospectate) && level.players.size > 1 && !istrue(level.gameended) && !istrue(level._id_9F2C0D537922A861)) {
    _id_5F387F573C75FC2B = 0;

    foreach(player in level.players) {
      if(istrue(player.br_iseliminated))
        _id_5F387F573C75FC2B++;
    }

    if(!(scripts\mp\utility\game::getsubgametype() == "dmz"))
      scripts\mp\utility\script::demoforcesre("getBestSpectateCandidate - no valid players found (" + _id_5F387F573C75FC2B + " of " + level.players.size + ") eliminated");
  }

  if(isvalidspectatetarget(playertospectate))
    return playertospectate;

  return undefined;
}

debugforcesre1(player, _id_8F7C03EC5F22FE86, _id_5F5E891346A87FAE) {
  _id_396A43E6475305FE = "player: " + player.name + ", candidate: " + _id_8F7C03EC5F22FE86.name + ", playersChecked.size: " + _id_5F5E891346A87FAE.size;
  scripts\mp\utility\script::demoforcesre(_id_396A43E6475305FE);
  _id_396A43E6475305FE = "";
  maxplayers = int(min(_id_5F5E891346A87FAE.size, 3));
  count = 0;

  foreach(_id_AC0E424AC96A7113 in _id_5F5E891346A87FAE) {
    _id_396A43E6475305FE = _id_396A43E6475305FE + (" - player: " + _id_AC0E424AC96A7113.name + ", eliminated: " + istrue(_id_AC0E424AC96A7113.br_iseliminated));
    count++;

    if(count > maxplayers) {
      break;
    }
  }

  scripts\mp\utility\script::demoforcesre(_id_396A43E6475305FE);
}

getnextspectatecandidatefromchain(player) {
  _id_5F5E891346A87FAE = [];
  count = 0;

  for(_id_8F7C03EC5F22FE86 = player; isDefined(_id_8F7C03EC5F22FE86) && !isvalidspectatetarget(_id_8F7C03EC5F22FE86); _id_8F7C03EC5F22FE86 = _id_8F7C03EC5F22FE86 playergetspectatingplayer()) {
    count++;
    entnum = _id_8F7C03EC5F22FE86 getentitynumber();

    if(count >= 150 || isDefined(_id_5F5E891346A87FAE[entnum]))
      return undefined;

    _id_5F5E891346A87FAE[entnum] = _id_8F7C03EC5F22FE86;
  }

  return _id_8F7C03EC5F22FE86;
}

_id_964FB56006392A0F(victim, players) {
  playertospectate = undefined;
  _id_B0BB95D539F6B4CF = [];
  _id_994343182144E8BC = [];
  _id_994346182144EF55 = [];

  foreach(player in players) {
    if(!isDefined(player) || !isvalidspectatetarget(player) || player == victim) {
      continue;
    }
    if(istrue(player.gulag)) {
      _id_994343182144E8BC[_id_994343182144E8BC.size] = player;
      continue;
    }

    if(istrue(player.inlaststand)) {
      _id_994346182144EF55[_id_994346182144EF55.size] = player;
      continue;
    }

    _id_B0BB95D539F6B4CF[_id_B0BB95D539F6B4CF.size] = player;
  }

  if(_id_B0BB95D539F6B4CF.size > 0) {
    _id_610520BE555433B2 = randomint(_id_B0BB95D539F6B4CF.size);
    playertospectate = _id_B0BB95D539F6B4CF[_id_610520BE555433B2];
  }

  if(!isDefined(playertospectate) && _id_994343182144E8BC.size > 0) {
    _id_610520BE555433B2 = randomint(_id_994343182144E8BC.size);
    playertospectate = _id_994343182144E8BC[_id_610520BE555433B2];
  }

  if(!isDefined(playertospectate) && _id_994346182144EF55.size > 0) {
    _id_610520BE555433B2 = randomint(_id_994346182144EF55.size);
    playertospectate = _id_994346182144EF55[_id_610520BE555433B2];
  }

  return playertospectate;
}

isvalidspectatetarget(player) {
  if(!isDefined(player))
    return 0;

  if(istrue(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("isValidSpectateTarget")))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("isValidSpectateTarget", player);

  if(!isalive(player) && !_id_393455DDE05F567C(player) && (istrue(player.gulagarena) || !istrue(player.gulag)))
    return 0;

  if(istrue(player._id_E7AF56A2DF18030D) || istrue(player.extracted))
    return 0;

  if(istrue(player.disconnecting))
    return 0;

  return !istrue(player.br_iseliminated);
}

spawnintermissionatplayer(player) {
  spawnpoint = spawnStruct();

  if(isDefined(player) && isDefined(player.spectatepoint)) {
    spawnpoint = player.spectatepoint;
    player.spectatepoint = undefined;
  } else if(isDefined(player)) {
    spawnpoint.origin = player.origin + (0, 0, 100);
    spawnpoint.angles = player.angles;
  } else {
    spawnpoint.origin = self.origin + (0, 0, 100);
    spawnpoint.angles = self.angles;
  }

  scripts\mp\playerlogic::spawnintermission(spawnpoint, undefined, 0);
  self._id_D7A39ED80C939737 = 1;
}

_id_28A7C47D17FDA8FF(camera) {
  self notify("deleteCamOnLeave");
  self endon("deleteCamOnLeave");
  team = self.team;

  if(!isDefined(team)) {
    return;
  }
  self waittill("disconnect");

  if(level.teamdata[team]["players"].size > 0) {
    return;
  }
  if(isDefined(level._id_11D0C321045F514F[team])) {
    level._id_11D0C321045F514F[team] delete();
    level._id_11D0C321045F514F[team] = undefined;
  }
}

_id_3C5421C26D253EB0(_id_13669D61D3D44913) {
  if(!isDefined(level._id_11D0C321045F514F))
    level._id_11D0C321045F514F = [];

  _id_5940F376A254619D = undefined;

  if(isDefined(level._id_11D0C321045F514F) && isDefined(level._id_11D0C321045F514F[self.team]))
    _id_5940F376A254619D = level._id_11D0C321045F514F[self.team];
  else {
    _id_5940F376A254619D = spawn("script_model", self.origin + (0, 0, 50));
    _id_5940F376A254619D setModel("tag_origin");
    _id_5940F376A254619D.angles = self.angles;
    level._id_11D0C321045F514F[self.team] = _id_5940F376A254619D;
  }

  if(scripts\mp\utility\player::isreallyalive(self))
    self cameralinkTo(_id_5940F376A254619D, "tag_origin");

  players = level.teamdata[self.team]["players"];

  if(isDefined(players) && players.size > 0) {
    foreach(player in players) {
      if(isDefined(player)) {
        if(istrue(_id_13669D61D3D44913) && (!scripts\mp\utility\player::isreallyalive(player) || isDefined(player) && istrue(player.extracted)) && !istrue(_id_14D3930854CB398C::_id_C1E2F014739D7903(player)))
          player cameralinkTo(_id_5940F376A254619D, "tag_origin");

        player thread _id_28A7C47D17FDA8FF(_id_5940F376A254619D);
      }
    }
  } else
    thread _id_28A7C47D17FDA8FF(_id_5940F376A254619D);
}

spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7, _id_899BEB1FC66D0EC6) {
  self endon("gulag_auto_win");

  if(_id_2CEDCC356F1B9FC8::istutorial()) {
    return;
  }
  if(istrue(self.squadwiped) && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")) {
    self.br_spectatorinitialized = 1;
    self notify("br_spectatorInitialized");
    return;
  }

  victim = self;
  victim spawnintermissionatplayer(victim);
  thread _id_67708F418B1FAC79::playerspawningasspectator();

  if(!istrue(_id_899BEB1FC66D0EC6))
    victim thread triggereliminatedoverlay();

  attacker = undefined;

  if(isDefined(_id_642470E1ABC1BBF9))
    attacker = _id_642470E1ABC1BBF9.attacker;

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate")) {
    return;
  }
  playertospectate = getbestspectatecandidate(victim, attacker);

  if(isDefined(playertospectate))
    assignspectatortospectateplayer(victim, playertospectate);
  else
    logstring("[ spawnSpectator ] spectator not found for player:" + victim.name + " ... this player will not be set to out-of-gulag in forcePlayerSpectateTarget()");

  if(!istrue(victim.br_spectatorinitialized)) {
    victim notify("br_spectatorInitialized");
    victim.br_spectatorinitialized = 1;
  }
}

_id_A7F4ED43A56864AD() {
  player = self;
  _id_7D30891078FF1E29 = undefined;

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("canPlayerSpectateGulag"))
    _id_7D30891078FF1E29 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("canPlayerSpectateGulag");

  if(istrue(_id_7D30891078FF1E29)) {
    _id_229E3676E299B693 = undefined;

    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("shouldPlayerSpectateGulag")) {
      _id_229E3676E299B693 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("shouldPlayerSpectateGulag");

      if(istrue(_id_229E3676E299B693)) {
        if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagSpectatorWatchMatchOver"))
          _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagSpectatorWatchMatchOver");
      }
    }
  }
}

triggereliminatedoverlay() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  _id_DF38ED143464F3C1 = [];

  if(isDefined(self.team) && scripts\mp\utility\teams::isgameplayteam(self.team))
    _id_DF38ED143464F3C1 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  if(_id_DF38ED143464F3C1.size > 0) {
    _id_700E5BDE49FCE648 = 1;

    switch (scripts\mp\utility\game::getsubgametype()) {
      case "zone_control":
      case "rumble_mgl":
      case "risk":
      case "plunder":
        _id_700E5BDE49FCE648 = 0;
        break;
      case "truckwar":
        _id_700E5BDE49FCE648 = !isDefined(level.teamvehicles[self.team]);
        break;
      case "resurgence":
        _id_700E5BDE49FCE648 = !istrue(level.brgametype._id_BBDE847AED85512A);
        break;
    }

    if(_id_700E5BDE49FCE648) {
      thread setbuybackpingmessage();
      thread _id_72173D4A7C4845BB();
      wait 0.25;
      self setclientomnvar("ui_br_end_game_splash_type", 5);
      wait 1.0;
      self setclientomnvar("ui_br_end_game_splash_type", 0);
      return;
    }
  } else
    self setclientomnvar("ui_requestRedeployButton_state", -1);
}

_id_72173D4A7C4845BB() {
  scripts\engine\utility::waittill_any_return_4("disconnect", "br_team_fully_eliminated", "started_spawnPlayer", "gulag_auto_win");

  if(isDefined(self))
    self setclientomnvar("ui_requestRedeployButton_state", -1);
}

setbuybackpingmessage() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  self endon("started_spawnPlayer");
  self endon("gulag_auto_win");

  if(!istrue(level.br_plunder_enabled) || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "plunder") {
    waittillspectating(self);

    if(_id_2CEDCC356F1B9FC8::isrespawningfromtoken(self)) {
      return;
    }
    if(scripts\mp\utility\game::getsubgametype() == "zxp") {
      if(_id_362C58E8BB39BCDA::runbrgametypefunc("remainingPlayersAliveOnTeam", self.team) == 0)
        return;
    }

    _id_9B07A6C625FC48D3 = getdvarint("dvar_FD0A280901F0AA8C", 10);
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_ping_nearest_supply");
    self setclientomnvar("ui_requestRedeployButton_state", 0);
    _id_B4320BCE0FBC5FF9 = 0;

    for(;;) {
      waittillframeend;

      if(isDefined(self.playertospectate) && istrue(self.playertospectate.gulag)) {
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
        self setclientomnvar("ui_requestRedeployButton_state", -1);
        scripts\engine\utility::waittill_any_return_4("br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle", "spectated_player_wins_gulag");
        continue;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar("br_ping_nearest_supply");
      self setclientomnvar("ui_requestRedeployButton_state", 0);
      msg = scripts\engine\utility::waittill_any_return_5("buybackRequested", "br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle", "death");

      if(msg == "buybackRequested") {
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
        endtime = gettime() + _id_9B07A6C625FC48D3 * 1000;
        self setclientomnvar("ui_requestRedeployButton_state", int(max(endtime, 0)));

        foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
          if(!isDefined(_id_F0EA4030349A33D5)) {
            continue;
          }
          if(_id_F0EA4030349A33D5 != self && !istrue(_id_F0EA4030349A33D5.gulag))
            _id_F0EA4030349A33D5 _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_buyback");
        }

        wait(_id_9B07A6C625FC48D3);
      }
    }
  }
}

debugforcesre2(player, playertospectate) {
  _id_396A43E6475305FE = "player: " + player.name;

  if(isDefined(playertospectate) && isDefined(playertospectate.name))
    _id_396A43E6475305FE = _id_396A43E6475305FE + (", playerToSpectate: " + playertospectate.name + ", alive: " + isalive(playertospectate) + ", eliminated: " + istrue(playertospectate.br_iseliminated) + ", gulag: " + istrue(playertospectate.gulag));

  scripts\mp\utility\script::demoforcesre(_id_396A43E6475305FE);
  waitframe();

  if(isDefined(playertospectate) && isDefined(playertospectate.name))
    _id_396A43E6475305FE = "waitframe - playerToSpectate: " + playertospectate.name + ", alive: " + isalive(playertospectate) + ", eliminated: " + istrue(playertospectate.br_iseliminated) + ", gulag: " + istrue(playertospectate.gulag);

  scripts\mp\utility\script::demoforcesre(_id_396A43E6475305FE);
}

playerclearspectatekillchainsystem() {
  self.prestreamingspectatetarget = undefined;
  self.nextplayertospectate = undefined;
  self.playertospectate = undefined;

  if(istrue(self._id_D7A39ED80C939737)) {
    if(!getdvarint("dvar_8117734E3E0F8BE5", 0))
      scripts\mp\utility\player::_freezecontrols(0, undefined, "spawnIntermission");

    self._id_D7A39ED80C939737 = undefined;
  }

  self setclientomnvar("ui_show_spectateHud", -1);
  self notify("forcePlayerSpectateTarget");
  self notify("playerMonitorSpectatorCycle");
}

playerspawnintermissionifneeded() {
  player = self;

  if(player.sessionstate != "intermission") {
    _id_F3201060EAC7D7D7 = player playergetspectatingplayer();

    if(isDefined(_id_F3201060EAC7D7D7) && istrue(_id_F3201060EAC7D7D7.wasingulag)) {
      player _id_67708F418B1FAC79::playersetwasingulag(1);
      level notify("update_circle_hide");
    }

    player spawnintermissionatplayer(_id_F3201060EAC7D7D7);
  }
}

forceplayerspectatetarget(playertospectate) {
  if(istrue(level.brspawnplayersending)) {
    return;
  }
  player = self;
  level endon("brSpawnPlayersEnding");
  player endon("disconnect");
  player notify("forcePlayerSpectateTarget");
  player endon("forcePlayerSpectateTarget");
  player.prestreamingspectatetarget = 1;
  player playerspawnintermissionifneeded();

  if(!isDefined(playertospectate) || !isPlayer(playertospectate) || !isalive(playertospectate) && !isDefined(playertospectate.streampoint)) {
    if(level.gameended || level.players.size == 1) {
      player setclientomnvar("ui_show_spectateHud", player getentitynumber());
      player.prestreamingspectatetarget = undefined;
      return;
    }

    thread debugforcesre2(player, playertospectate);
    playertospectate = getbestspectatecandidate(player);

    if(!isDefined(playertospectate)) {
      player setclientomnvar("ui_show_spectateHud", player getentitynumber());
      player.prestreamingspectatetarget = undefined;
      return;
    }
  }

  playertospectate endon("disconnect");
  _id_CE41748027B9CF64 = playertospectate getentitynumber();
  player.playertospectate = playertospectate;
  player setclientomnvar("ui_show_spectateHud", _id_CE41748027B9CF64);
  player setadditionalstreamloaddist(0.0);
  _id_11F3B4465C8B637B = playertospectate.origin;

  if(isDefined(playertospectate.streampoint)) {
    _id_11F3B4465C8B637B = playertospectate.streampoint.origin;
    player _meth_670863FC4008C3D8(_id_11F3B4465C8B637B);
  } else
    player _meth_670863FC4008C3D8(_id_11F3B4465C8B637B, 0, playertospectate);

  player loadcustomizationplayerview(playertospectate);
  weapons = playertospectate getweaponslistprimaries();
  player loadweaponsforplayer(weapons, 1);
  waitframe();
  _id_E044DB8497EEE961 = getdvarint("dvar_8F060C92B126A91B", 2500);
  _id_2D124F5CAC8360E2 = getdvarint("dvar_CEB0792519B8EEA2", 500);
  _id_6DF0EF0DBA50FD51 = getdvarint("dvar_FF561F8C33F431BA", 9000);
  _id_E1BD90CD85D2938E = gettime() + _id_2D124F5CAC8360E2;
  timeout = gettime() + _id_6DF0EF0DBA50FD51;

  while(isDefined(player) && (!player isadditionalstreamposready() || isDefined(playertospectate) && !player hasloadedcustomizationplayerview(playertospectate) || !player hasloadedviewweapons(weapons)) && gettime() < timeout) {
    if(isDefined(playertospectate) && !isDefined(playertospectate.streampoint) && gettime() > _id_E1BD90CD85D2938E) {
      distsq = distance2dsquared(playertospectate.origin, _id_11F3B4465C8B637B);

      if(!isDefined(distsq)) {
        if(!isDefined(_id_11F3B4465C8B637B))
          logstring("Log this in IW9-428811: streamOrigin was undefined");
        else if(!isDefined(playertospectate.origin))
          logstring("Log this in IW9-428811: playerToSpectate.origin was undefined");
        else
          logstring("Log this in IW9-428811: Inputs were defined. Error exists in BGScr_Distance2DSquared. Inputs: " + playertospectate.origin + " and " + _id_11F3B4465C8B637B);
      }

      if(distsq > _id_E044DB8497EEE961) {
        _id_11F3B4465C8B637B = playertospectate.origin;
        player _meth_670863FC4008C3D8(_id_11F3B4465C8B637B, 0, playertospectate);
        _id_E1BD90CD85D2938E = gettime() + _id_2D124F5CAC8360E2;
      }
    }

    waitframe();
  }

  _id_1E41981F0FA40795 = getdvarint("dvar_CEB0792519B8EEA2", 2000);
  timeout = gettime() + _id_6DF0EF0DBA50FD51;
  _id_8CABE71736D798A7 = 0;

  while((isDefined(playertospectate.streampoint) || !isalive(playertospectate) || istrue(playertospectate.gulag) && !istrue(playertospectate.jailed)) && gettime() < timeout) {
    if(gettime() > _id_8CABE71736D798A7) {
      player _meth_670863FC4008C3D8(_id_11F3B4465C8B637B);
      _id_8CABE71736D798A7 = gettime() + _id_1E41981F0FA40795;
    }

    waitframe();
  }

  if(isDefined(playertospectate))
    player playerforcespectatorclientwait(playertospectate);

  player thread playermonitorspectatorcycle();
  player clearadditionalstreampos();

  if(istrue(player.wasingulag)) {
    player _id_67708F418B1FAC79::playersetwasingulag(0);
    level notify("update_circle_hide");
  }

  self notify("force_spectate_done");
}

playerforcespectatorclientwait(playertospectate) {
  player = self;

  if(isDefined(playertospectate) && !playertospectate _id_5BAB271917698DC4::playeriscinematicblacklayeron())
    player thread _id_5BAB271917698DC4::playercinematicfadeout();
  else if(!player _id_5BAB271917698DC4::playeriscinematicblacklayeron()) {
    player _id_5BAB271917698DC4::playercinematicfadein();
    wait 0.5;
  }

  if(istrue(player._id_D7A39ED80C939737)) {
    if(!getdvarint("dvar_8117734E3E0F8BE5", 0))
      player scripts\mp\utility\player::_freezecontrols(0, undefined, "spawnIntermission");

    player._id_D7A39ED80C939737 = undefined;
  }

  _id_CE41748027B9CF64 = undefined;

  if(isDefined(playertospectate)) {
    _id_CE41748027B9CF64 = playertospectate getentitynumber();
    player scripts\mp\utility\player::updatesessionstate("spectator");
    player.forcespectatorclient = _id_CE41748027B9CF64;
    player setallstreamloaddist(0.0);
    player setclientomnvar("ui_show_spectateHud", -1);
    _id_E972C5A415D85B37 = player getspectatingplayer();

    while(!isDefined(_id_E972C5A415D85B37) || _id_CE41748027B9CF64 != _id_E972C5A415D85B37 getentitynumber()) {
      waitframe();
      _id_E972C5A415D85B37 = player getspectatingplayer();

      if(!isDefined(playertospectate) || !isvalidspectatetarget(playertospectate)) {
        break;
      }
    }
  }

  player notify("br_spectator_end_forced_spectator");
  player.forcespectatorclient = -1;

  if(isDefined(playertospectate) && isvalidspectatetarget(playertospectate))
    player spectateclientnum(_id_CE41748027B9CF64, 1);

  player.prestreamingspectatetarget = undefined;
}

_id_AA1A345E6EC0499B(_id_7148C1A6F25491F8, _id_5B057D5C19CC3D92) {
  player = self;

  if(!isDefined(_id_5B057D5C19CC3D92)) {
    return;
  }
  if(_id_7148C1A6F25491F8 == "br_spectate_player") {
    _id_6EE5484560EC747C = scripts\mp\playerlogic::getplayerfromclientnum(_id_5B057D5C19CC3D92);

    if(isvalidspectatetarget(_id_6EE5484560EC747C))
      player spectateclientnum(_id_5B057D5C19CC3D92, 1);
  }
}

assignspectatortospectateplayer(spectator, playertospectate) {
  if(getdvarint("dvar_5DF0FED95481409D", 1))
    spectator scripts\mp\utility\player::_freezecontrols(0, undefined, "spawnIntermission");

  result = _id_362C58E8BB39BCDA::runbrgametypefunc("assignSpectatorToSpectatePlayer", spectator, playertospectate);

  if(istrue(result)) {
    return;
  }
  spectator allowspectateteam("freelook", 0);
  spectator allowspectateteam("none", 0);
  spectator allowspectateallteams(getdvarint("dvar_87720D5EC286812B", 0));

  if(level.teambased && isDefined(playertospectate))
    spectator allowspectateteam(playertospectate.team, 1);

  spectator thread forceplayerspectatetarget(playertospectate);
  self notify("playertospectate_set");
}

playermonitorspectatorcycle() {
  self notify("playerMonitorSpectatorCycle");
  self endon("playerMonitorSpectatorCycle");
  self endon("forcePlayerSpectateTarget");
  self endon("disconnect");
  self endon("started_spawnPlayer");

  for(;;) {
    self waittill("spectating_cycle_start", playertospectate);

    if(!isDefined(playertospectate)) {
      continue;
    }
    if(istrue(self.gulagarena) && !istrue(self._id_4AF73CE40A5D8572) && _id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
      _id_13C5603D4BEEA2FC = self getspectatingplayer();

      if(isDefined(_id_13C5603D4BEEA2FC)) {
        self.forcespectatorclient = _id_13C5603D4BEEA2FC getentitynumber();
        continue;
      }
    }

    if(playertospectate _id_5BAB271917698DC4::playeriscinematicblacklayeron())
      _id_5BAB271917698DC4::playercinematicfadein();

    success = playerwaittillspectatecycle(playertospectate);
    _id_F7632B4589B2BED4 = self getspectatingplayer();

    if(!istrue(success) || !isDefined(_id_F7632B4589B2BED4)) {
      stopspectateplayer(self getentitynumber(), 1);

      if(isvalidspectatetarget(self.playertospectate))
        playerforcespectatorclientwait(self.playertospectate);
      else {
        playertospectate = getbestspectatecandidate(self);

        if(isDefined(playertospectate)) {
          if(!playertospectate _id_5BAB271917698DC4::playeriscinematicblacklayeron())
            thread _id_5BAB271917698DC4::playercinematicfadeout();

          assignspectatortospectateplayer(self, playertospectate);
        }
      }

      continue;
    }

    self.playertospectate = playertospectate;

    if(_id_F7632B4589B2BED4 != playertospectate)
      self.playertospectate = _id_F7632B4589B2BED4;

    if(self.playertospectate _id_5BAB271917698DC4::playeriscinematicblacklayeron()) {
      if(!_id_5BAB271917698DC4::playeriscinematicblacklayeron())
        _id_5BAB271917698DC4::playercinematicfadein();

      continue;
    }

    thread _id_5BAB271917698DC4::playercinematicfadeout();
  }
}

playerwaittillspectatecycle(playertospectate) {
  playertospectate endon("death_or_disconnect");
  self waittill("spectating_cycle");
  return 1;
}

playergetspectatingplayer() {
  _id_13C5603D4BEEA2FC = undefined;

  if(!istrue(self.spectatekillcam))
    _id_13C5603D4BEEA2FC = self getspectatingplayer();

  if(!isDefined(_id_13C5603D4BEEA2FC) && isDefined(self.nextplayertospectate))
    _id_13C5603D4BEEA2FC = self.nextplayertospectate;

  if(!isDefined(_id_13C5603D4BEEA2FC) && isDefined(self.playertospectate))
    _id_13C5603D4BEEA2FC = self.playertospectate;

  return _id_13C5603D4BEEA2FC;
}

_id_4A8746C1AA6BB002(timeout, _id_2307459D7AE05EE8) {
  level endon("game_ended");
  self endon("disconnect");
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  scripts\engine\utility::waittill_any_timeout_1(timeout, _id_2307459D7AE05EE8);
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

_id_6D5206BDBA79E8C3(targetplayer) {
  playerlist = [];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_3E4A838DCBD0C40D = player getspectatingplayer();

    if(!isDefined(_id_3E4A838DCBD0C40D)) {
      continue;
    }
    if((player.team == "spectator" || player.team == "codcaster") && _id_3E4A838DCBD0C40D == targetplayer)
      playerlist[playerlist.size] = player;
  }

  return playerlist;
}

getspectatorsofplayer(targetplayer) {
  playerlist = [];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isvalidspectatetarget(player)) {
      continue;
    }
    if(!istrue(player.br_spectatorinitialized)) {
      continue;
    }
    _id_13C5603D4BEEA2FC = player playergetspectatingplayer();

    if(!isDefined(_id_13C5603D4BEEA2FC)) {
      continue;
    }
    if(_id_13C5603D4BEEA2FC == targetplayer)
      playerlist[playerlist.size] = player;
  }

  return playerlist;
}

migratespectators(victim, attacker, _id_F424F125A0BBA2DC) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(_id_393455DDE05F567C(victim)) {
    return;
  }
  playertospectate = getbestspectatecandidate(victim, attacker);

  if(_id_F424F125A0BBA2DC && !istrue(victim.gulag))
    victim.nextplayertospectate = playertospectate;

  if(!isvalidspectatetarget(playertospectate)) {
    if(scripts\mp\utility\game::getsubgametype() == "dmz" && getdvarint("dvar_9204E47E241583A1", 1) == 1) {
      if(isDefined(victim) && isDefined(victim.team)) {
        players = level.teamdata[victim.team]["players"];

        if(isDefined(players) && players.size > 0) {
          foreach(player in players) {
            if(isvalidspectatetarget(player)) {
              updateexistingspectatorsofvictim(victim, player);
              return;
            }
          }
        }

        victim _id_3C5421C26D253EB0(1);
      }
    }

    return;
  }

  updateexistingspectatorsofvictim(victim, playertospectate);
}

updateexistingspectatorsofvictim(victim, playertospectate) {
  _id_664365936020571F = getspectatorsofplayer(victim);

  foreach(spectator in _id_664365936020571F) {
    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && istrue(spectator.gulagarena)) {
      _id_6B34091DBD072E53 = getbestspectatecandidate(spectator, undefined, 1);

      if(isDefined(_id_6B34091DBD072E53) && spectator.team == _id_6B34091DBD072E53.team) {
        assignspectatortospectateplayer(spectator, _id_6B34091DBD072E53);
        continue;
      }
    }

    if(isDefined(playertospectate) && victim.team == spectator.team && playertospectate.team != victim.team && isDefined(victim.streampoint)) {
      assignspectatortospectateplayer(spectator, victim);
      continue;
    }

    if(isDefined(spectator.nextplayertospectate)) {
      spectator.nextplayertospectate = playertospectate;
      continue;
    }

    assignspectatortospectateplayer(spectator, playertospectate);
  }
}

updateactivespectatorcounts() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    _id_B75EBFA25066FB2A = [];

    foreach(player in level.players) {
      if(isDefined(player)) {
        _id_7418903E36376E0B = player getspectatingplayer();

        if(isDefined(_id_7418903E36376E0B)) {
          _id_9C38AF357B506FE9 = _id_7418903E36376E0B getentitynumber();
          _id_B75EBFA25066FB2A[_id_9C38AF357B506FE9] = _id_1E4A61DB11011446::get_int_or_0(_id_B75EBFA25066FB2A[_id_9C38AF357B506FE9]) + 1;
        }
      }
    }

    _id_A602D20A8058431C = 0;

    foreach(player in level.players) {
      if(isDefined(player)) {
        _id_C53E78332A6C514F = player getentitynumber();
        _id_F83EE2B3E5C5125D = _id_1E4A61DB11011446::get_int_or_0(_id_B75EBFA25066FB2A[_id_C53E78332A6C514F]);
        _id_3E955591D6FEBC8D = player getclientomnvar("ui_br_active_spectators");

        if(_id_F83EE2B3E5C5125D != _id_3E955591D6FEBC8D)
          player setclientomnvar("ui_br_active_spectators", _id_F83EE2B3E5C5125D);

        _id_A602D20A8058431C++;

        if(_id_A602D20A8058431C % 10 == 0)
          waitframe();
      }
    }

    wait 1.0;
  }
}

waittillspectating(player) {
  while(player.sessionstate != "intermission")
    waitframe();

  while(player.sessionstate == "intermission")
    waitframe();

  while(player.sessionstate != "spectator")
    waitframe();
}

_id_393455DDE05F567C(player) {
  return isDefined(player) && (player _id_2CEDCC356F1B9FC8::hasrespawntoken() && !_id_7E52B56769FA7774::respawntokendisabled() || istrue(player.respawningfromtoken));
}

_id_F83BF537661EC58C(winner) {
  _id_721982228624D657 = getspectatorsofplayer(winner);

  foreach(spectator in _id_721982228624D657) {
    if(isalliedsentient(spectator, winner))
      spectator notify("spectated_player_wins_gulag");
  }
}