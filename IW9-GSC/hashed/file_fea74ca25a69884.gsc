/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_fea74ca25a69884.gsc
***********************************************/

init() {
  if(getdvarint("dvar_87E38FCA685CEC1D", 0)) {
    _id_2902155747C5C4FE::registerhandlecommand(::_id_DD5235EA93F4AF20);
    thread _id_2902155747C5C4FE::commandwatcher("dvar_97CDA940CB7BD182", _id_2902155747C5C4FE::handlecommand);
  }
}

_id_DD5235EA93F4AF20(_id_10D8148F3496F8DE, _id_434809FD34BABEE0) {
  switch (_id_10D8148F3496F8DE) {
    case "st":
      thread devscriptedtests(_id_434809FD34BABEE0);
      break;
    default:
      break;
  }
}

devscriptedtests(_id_434809FD34BABEE0) {
  level notify("devScriptedTests");
  level endon("devScriptedTests");
  _id_50BBC2CAB314EDAB = gethost(_id_434809FD34BABEE0);

  if(!isDefined(_id_50BBC2CAB314EDAB)) {
    return;
  }
  _id_D721BA3A92DFFD4C();
  _id_8032016446156BAD();
  _id_26E60C051F1C9BA6();
  _id_A77DC072D0E3BE59();
  [_id_92B132654E85CBC4, _id_5D192B4C08040010] = _id_401754DC53CC2D8A(_id_434809FD34BABEE0);
  _id_50BBC2CAB314EDAB iprintlnbold("Test ready");
  wait 2;
  _id_77A10F0EEC39CB4F(_id_434809FD34BABEE0, _id_50BBC2CAB314EDAB, _id_92B132654E85CBC4, _id_5D192B4C08040010);
}

_id_B59FCDDF8EE2D0BA() {
  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    _id_95BEA949F8FC8A68 = [_id_1E4A61DB11011446::createspawnlocation((-21500, 46200, -300), 0, 6000), _id_1E4A61DB11011446::createspawnlocation((51000, -39000, 1401), 0, 4000), _id_1E4A61DB11011446::createspawnlocation((32000, 40000, 767), 0, 5500), _id_1E4A61DB11011446::createspawnlocation((23000, -15000, -158), 0, 6000)];
    return _id_95BEA949F8FC8A68;
  }
}

_id_D721BA3A92DFFD4C() {
  if(istrue(level.usegulag)) {
    foreach(arena in level.gulag.arenas)
    arena.matches = [];

    level.gulag.arenas = sortbydistance(level.gulag.arenas, level.mapcorners[0].origin);
    level.gulag.maxuses = -1;
    level.gulag.timelimit = 15;
    setDvar("scr_br_fc_overtime", 15);
    setDvar("dvar_E5F703A38F6E8043", 95);
    setDvar("dvar_8BDEE07FA09E810A", -1);
    setDvar("dvar_E43719F8CB449C07", 0);
    setDvar("dvar_98B297A8680CBDC2", 0);

    if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
      foreach(arena in level.gulag.arenas)
      arena.shutdown = undefined;

      level.gulag.shutdown = undefined;
    }
  }
}

_id_8032016446156BAD() {
  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  level notify("cancel_public_event");
  setomnvar("ui_prematch_period", 0);
  level.maxteamsize = 3;
  level.br_prematchstarted = 1;
  level.teammaxfill = 1;
  level.disablespawning = 0;
  level.ignorescoring = 0;
  level.allowprematchdamage = 1;
  level.ingraceperiod = 0;
  setDvar("bot_DisableAllAI", 1);
  setDvar("br_minplayers", 150);
  setDvar("live_lobby_minplayers_start", 150);
  setDvar("dvar_2C879521333C4987", 0);
  level._id_0C3A1ED2DB43CE5A = 3;
}

_id_26E60C051F1C9BA6() {
  foreach(player in level.players) {
    if(player isplayerheadless()) {
      player allowmovement(0);
      player allowfire(0);
      player allowmelee(0);
    }

    player _id_DF49F9975E17B225(undefined);
    player.gulag = undefined;
    player.jailed = undefined;
    player.gulagarena = undefined;
    player.wasingulag = undefined;
    player.playertospectate = undefined;
    player.nextplayertospectate = undefined;
    player.gulagloser = undefined;
    player.gulaguses = undefined;
    player.longgulagstream = undefined;
    player.gulagholding = undefined;
    player._id_4AF73CE40A5D8572 = undefined;
    player notify("gulag_end");
    player notify("last_stand_start");
    player scripts\mp\laststand::finishreviveplayer("self_revive_success", player);
    player setstance("stand");
    player setallstreamloaddist(0.0);
    player.setspawnpoint = undefined;
    _id_9FDC1F9E4FC628E4 = spawnStruct();
    _id_9FDC1F9E4FC628E4._id_FB551788DA0FC531 = 0;
    player _id_67708F418B1FAC79::playerrespawngulagcleanup(_id_9FDC1F9E4FC628E4);
    player _id_67708F418B1FAC79::playergulagarenaready();
  }
}

_id_A77DC072D0E3BE59() {
  if(isDefined(level.br_circle.safecircleent)) {
    level.br_circle.dangercircleui.hidden = 1;
    level.br_circle.dangercircleent.hidden = 1;
    level.br_circle.safecircleui.hidden = 1;
    level.br_circle.safecircleent.hidden = 1;
    level notify("update_circle_hide");
  }
}

_id_401754DC53CC2D8A(_id_434809FD34BABEE0) {
  _id_50BBC2CAB314EDAB = gethost(_id_434809FD34BABEE0);
  _id_95BEA949F8FC8A68 = _id_B59FCDDF8EE2D0BA();

  if(!isDefined(level.devspectateloc))
    level.devspectateloc = [];

  _id_E2D2256D6F8BA785 = level._id_0C3A1ED2DB43CE5A - 1;
  count = 0;
  level._id_E1E5BAC199D37317 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
    team = level.teamnamelist[_id_AC0E594AC96AA3A8];

    if(team != _id_50BBC2CAB314EDAB.team) {
      level._id_E1E5BAC199D37317[count] = team;
      count++;

      if(count >= _id_E2D2256D6F8BA785) {
        break;
      }
    }
  }

  reviveteam(_id_50BBC2CAB314EDAB, _id_50BBC2CAB314EDAB.team);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E2D2256D6F8BA785; _id_AC0E594AC96AA3A8++)
    reviveteam(_id_50BBC2CAB314EDAB, level._id_E1E5BAC199D37317[_id_AC0E594AC96AA3A8]);

  level._id_0084931945E7B207 = getteamspawnbots(_id_50BBC2CAB314EDAB, _id_50BBC2CAB314EDAB.team);
  level._id_CC15D00C0DFBF14E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E2D2256D6F8BA785; _id_AC0E594AC96AA3A8++)
    level._id_CC15D00C0DFBF14E[_id_AC0E594AC96AA3A8] = getteamspawnbots(_id_50BBC2CAB314EDAB, level._id_E1E5BAC199D37317[_id_AC0E594AC96AA3A8]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_0084931945E7B207.size; _id_AC0E594AC96AA3A8++) {
    _id_52A462A16496CF97 = level._id_0084931945E7B207[_id_AC0E594AC96AA3A8];
    spawnorigin = _id_52A462A16496CF97.origin;

    if(isDefined(_id_95BEA949F8FC8A68))
      spawnorigin = _id_95BEA949F8FC8A68[_id_AC0E594AC96AA3A8].origin;

    _id_52A462A16496CF97 playerteleporttoloc(spawnorigin, 0);

    for(_id_E1D097C517C3AF5B = 0; _id_E1D097C517C3AF5B < _id_E2D2256D6F8BA785; _id_E1D097C517C3AF5B++) {
      _id_B16A2ED5E620B451 = level._id_CC15D00C0DFBF14E[_id_E1D097C517C3AF5B][_id_AC0E594AC96AA3A8];
      _id_B16A2ED5E620B451 playerteleporttoloc(spawnorigin, _id_E1D097C517C3AF5B + 1);
    }
  }

  level.disablespawning = 1;
  totalplayers = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = totalplayers.size;
  return [level._id_0084931945E7B207, level._id_CC15D00C0DFBF14E];
}

playerteleporttoloc(spawnorigin, _id_DCEF536353EA980B) {
  if(self isplayerheadless()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  entnum = self getentitynumber();

  if(isDefined(level.devspectateloc[entnum]))
    spawnorigin = level.devspectateloc[entnum];
  else {
    dir = anglesToForward((0, 0, 0));
    spawnorigin = spawnorigin + dir * (_id_DCEF536353EA980B * 50);
    spawnorigin = getgroundposition(spawnorigin, 15, 100);
  }

  self setOrigin(spawnorigin);
  self setplayerangles((0, 0, 0));

  if(!isDefined(level.devspectateloc[entnum]))
    level.devspectateloc[entnum] = spawnorigin;
}

reviveteam(_id_50BBC2CAB314EDAB, team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];
  _id_E89FB3807C5150CA = 0;

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isalive(player) || player.sessionstate != "playing") {
      entnum = player getentitynumber();

      if(isDefined(level.devspectateloc[entnum])) {
        player.forcespawnangles = (0, 0, 0);
        player.forcespawnorigin = level.devspectateloc[entnum];
      } else {
        player.forcespawnangles = player.angles;
        player.forcespawnorigin = player.origin;
      }

      player spawnclientdevtest(0);
      _id_E89FB3807C5150CA = 1;
    }

    if(istrue(player.br_iseliminated))
      _id_0A34750D17473C49::unmarkplayeraseliminated(player);
  }

  if(_id_E89FB3807C5150CA) {
    _id_50BBC2CAB314EDAB iprintlnbold("Reviving Team: " + team);
    wait 1.0;
  }
}

getteamspawnbots(_id_50BBC2CAB314EDAB, team) {
  _id_FC617751F654A141 = 0;

  if(level.teamdata[team]["teamCount"] < level.maxteamsize)
    _id_FC617751F654A141 = level.maxteamsize - level.teamdata[team]["teamCount"];

  if(_id_FC617751F654A141 > 0) {
    level.modespawnclient = ::spawnclientdevtest;
    addbots(_id_FC617751F654A141, team);
    _id_50BBC2CAB314EDAB iprintlnbold("Spawning Team: " + team);
    timeout = gettime() + 10000;

    while(gettime() < timeout && level.teamdata[team]["aliveCount"] < level.maxteamsize)
      waitframe();

    level.modespawnclient = _id_1E4A61DB11011446::spawnclientbr;
  }

  return level.teamdata[team]["alivePlayers"];
}

_id_46C357E31A65AF85() {
  team = self.bot_team;
  players = level.teamdata[team]["players"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.maxteamsize; _id_AC0E594AC96AA3A8++) {
    _id_46AD8D2AE6655343 = 1;

    foreach(player in players) {
      if(self == player) {
        continue;
      }
      if(isDefined(player._id_3F78C6A0862F9E25) && player._id_3F78C6A0862F9E25 == _id_AC0E594AC96AA3A8) {
        _id_46AD8D2AE6655343 = 0;
        break;
      }
    }

    if(_id_46AD8D2AE6655343) {
      self._id_3F78C6A0862F9E25 = _id_AC0E594AC96AA3A8;
      break;
    }
  }
}

addbots(_id_14B1F6570A7A8295, team) {
  setDvar("dvar_0FE6355160CB9C51", "1");

  if(!isDefined(team))
    team = "autoassign";

  level thread[[level.bot_funcs["bots_spawn"]]](_id_14B1F6570A7A8295, team, ::_id_46C357E31A65AF85);

  if(level.matchmakingmatch)
    setmatchdata("hasBots", 1);
}

spawnclientdevtest(_id_9156B53BCF7CE573) {
  self.class = _id_1E4A61DB11011446::pickprematchrandomloadout();
  self.pers["class"] = self.class;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  _id_4DE859B9228E5CFD = !self isplayerheadless();

  if(_id_4DE859B9228E5CFD) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist))
      waitframe();
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

_id_DF49F9975E17B225(value) {
  self.br_infilstarted = value;
}

_id_645DE575B455626C(_id_C2012867B496A7CB) {
  kick(_id_C2012867B496A7CB getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
}

killplayer(victim, _id_25012CDC0DFDC53F) {
  enemy = _id_25012CDC0DFDC53F;

  if(isarray(_id_25012CDC0DFDC53F))
    enemy = getnearbyaliveplayer(victim.origin, _id_25012CDC0DFDC53F);

  victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
  wait 1;

  while(isalive(victim)) {
    victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
    waitframe();
  }

  return enemy;
}

killplayerinstant(victim, _id_25012CDC0DFDC53F, _id_E953BCC50C294AE4) {
  enemy = _id_25012CDC0DFDC53F;

  if(isarray(_id_25012CDC0DFDC53F))
    enemy = getnearbyaliveplayer(victim.origin, _id_25012CDC0DFDC53F);

  if(!isDefined(enemy))
    enemy = victim;

  if(!istrue(_id_E953BCC50C294AE4) && victim scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
    victim scripts\mp\utility\perk::removeperk("specialty_pistoldeath");

  while(isalive(victim)) {
    victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());

    if(!isalive(victim)) {
      break;
    }

    waitframe();
  }

  return enemy;
}

putinlaststand(player, _id_25012CDC0DFDC53F) {
  enemy = _id_25012CDC0DFDC53F;

  if(isarray(_id_25012CDC0DFDC53F))
    enemy = getnearbyaliveplayer(player.origin, _id_25012CDC0DFDC53F);

  if(!isDefined(enemy))
    enemy = player;

  if(!player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
    player scripts\mp\utility\perk::giveperk("specialty_pistoldeath");

  while(!istrue(player.inlaststand)) {
    player dodamage(30, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
    wait 0.1;
  }

  return enemy;
}

scriptcircleat(origin, radius) {
  if(!isDefined(level.br_circle.safecircleent)) {
    thread _id_2695A20D4011076D::runcircles(1);
    level.br_circle thread _id_2695A20D4011076D::circledamagetick();
  }

  waitframe();
  level notify("CirclePeekCleanup");
  circleindex = 1;
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = circleindex;
  _id_F007CE073DC3C519 = circleindex == 0;
  _id_6B890E6BE7982EFB = circleindex == level.br_level.br_circleclosetimes.size - 1;
  _id_C3D4CAA5CB4132E6 = level.br_level.br_circledelaytimes[circleindex];
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
  _id_154EF61B7A7F747A = level.br_level.br_circleradii[circleindex + 1];
  setomnvar("ui_br_circle_num", circleindex + 1);
  level.br_circle.centertarget = origin;
  level.br_circle.safecircleent.origin = origin;
  level.br_circle.dangercircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.safecircleent.hidden = 0;
  level notify("update_circle_hide");
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = origin + (0, 0, radius);
  _id_2695A20D4011076D::setstaticuicircles(999, level.br_circle.safecircleui, level.br_circle.dangercircleui, _id_6B890E6BE7982EFB);
  level notify("br_circle_set");
  waitframe();
  level notify("br_circle_started");
  level.br_circle.dangercircleent brcirclemoveTo(origin[0], origin[1], radius, 1);
}

_id_2EA11E29FB71E2AD(_id_434809FD34BABEE0, _id_7F494A77CF41CCB7) {
  if(_id_7F494A77CF41CCB7 <= 0) {
    return;
  }
  level._id_0C3A1ED2DB43CE5A = _id_7F494A77CF41CCB7;
  return _id_401754DC53CC2D8A(_id_434809FD34BABEE0);
}

getnearbyaliveplayer(org, players) {
  players = scripts\engine\utility::array_removeundefined(players);
  players = sortbydistance(players, org);

  if(isalive(players[0])) {
    dist = distance2dsquared(org, players[0].origin);

    if(dist < 40000)
      return players[0];
  }

  _id_2EC9F2281965D86B = undefined;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(isalive(player)) {
      _id_2EC9F2281965D86B = player;
      break;
    }
  }

  return _id_2EC9F2281965D86B;
}

argshave(_id_434809FD34BABEE0, _id_E921CD2D3FB29B66) {
  foreach(_id_8B461603A1F825D3 in _id_434809FD34BABEE0) {
    if(_id_8B461603A1F825D3 == _id_E921CD2D3FB29B66)
      return 1;
  }

  return 0;
}

gethost(_id_434809FD34BABEE0) {
  if(isDefined(level.devspectatetesthost))
    return level.devspectatetesthost;

  _id_50BBC2CAB314EDAB = scripts\mp\gamelogic::gethostplayer();

  if(argshave(_id_434809FD34BABEE0, "clientHost")) {
    foreach(player in level.players) {
      if(!isai(player) && !player isplayerheadless() && (!isDefined(_id_50BBC2CAB314EDAB) || player != _id_50BBC2CAB314EDAB)) {
        _id_50BBC2CAB314EDAB = player;
        break;
      }
    }
  } else if(!isDefined(_id_50BBC2CAB314EDAB)) {
    foreach(player in level.players) {
      if(!isai(player) && !player isplayerheadless()) {
        level.devspectatetesthost = player;
        _id_50BBC2CAB314EDAB = player;
        break;
      }
    }
  } else
    level.maxteamsize = 3;

  if(!isDefined(level.devspectatetesthost))
    level.devspectatetesthost = _id_50BBC2CAB314EDAB;

  return _id_50BBC2CAB314EDAB;
}

playerstartrecondronewait() {
  pickupent = spawnStruct();
  pickupent.scriptablename = "brloot_killstreak_recondrone";
  pickupent.count = 1;
  _id_7E52B56769FA7774::takesuperpickup(pickupent);
  wait 1;
  _id_641083E829D5514C = makeweapon("super_default_mp");
  scripts\mp\supers::trysuperusebegin(_id_641083E829D5514C);

  while(self getcurrentprimaryweapon().basename != "ks_remote_drone_mp")
    waitframe();
}

waitandsuicide(_id_74B5B12BB6514385, player) {
  wait(_id_74B5B12BB6514385);
  player suicide();
}

onprematchstarted2() {
  level notify("onPrematchFadeDoneClear");
  level thread onprematchfadedone2();
  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled))
    c130pathstruct = _id_45B2B4A889E633FA::createtestc130path();

  waitframe();
  level.br_c130spawndone = 0;
  level.br_latejoininfilready = 0;
  _id_7933519955F32C4E::beginbrc130playeraniminfilsequence(c130pathstruct, "player");
  level thread _id_45B2B4A889E633FA::waittoplayinfildialog();
  level notify("infils_ready");
}

onprematchfadedone2() {
  _id_36648016CE75E753 = 1.4;
  level endon("onPrematchFadeDoneClear");

  if(!isDefined(level.spectatetestonprematchfadedone)) {
    level.spectatetestonprematchfadedone = 1;
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level thread _id_1E4A61DB11011446::resetalldoors(_id_36648016CE75E753 * 1.5);
  level thread scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforallplayers(1);
  level thread _id_46AF76764B1FC7F0::brvehicleonprematchstarted();
  level thread _id_1F6BC044DD1738AB::onprematchdone();
  _id_1E4A61DB11011446::cleanupmolotovs();
  _id_46AF76764B1FC7F0::emptyallvehicles();

  foreach(player in level.players) {
    player _id_1E4A61DB11011446::setplayerprematchallows();
    player thread _id_7E52B56769FA7774::resetplayerinventory();

    if(istrue(player.hasspawned)) {
      if(istrue(player.usingascender))
        player scripts\cp_mp\auto_ascender::ascenderinstantstop();

      player thread scripts\mp\weapons::deleteplacedequipment();
    }
  }

  foreach(player in level.players) {
    if(isDefined(player.burninginfo))
      player scripts\mp\equipment\molotov::molotov_clear_burning();

    player scripts\mp\javelin::javelin_forceclear();
  }

  level notify("prematch_cleanup");

  if(!istrue(level.br_circle_disabled))
    level thread _id_2695A20D4011076D::runcircles(1);
}

_id_77A10F0EEC39CB4F(_id_434809FD34BABEE0, _id_50BBC2CAB314EDAB, _id_92B132654E85CBC4, _id_5D192B4C08040010) {
  if(argshave(_id_434809FD34BABEE0, "killcam1") || argshave(_id_434809FD34BABEE0, "killchain") || argshave(_id_434809FD34BABEE0, "disconnect1") || argshave(_id_434809FD34BABEE0, "disconnect2") || argshave(_id_434809FD34BABEE0, "disconnect3")) {
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);

    if(argshave(_id_434809FD34BABEE0, "disconnect2")) {
      while(_id_50BBC2CAB314EDAB.sessionstate != "intermission")
        waitframe();

      while(_id_50BBC2CAB314EDAB.sessionstate == "intermission")
        waitframe();
    } else if(argshave(_id_434809FD34BABEE0, "disconnect3")) {
      while(_id_50BBC2CAB314EDAB.sessionstate != "intermission")
        waitframe();

      wait 0.5;
    } else {
      _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
      wait 3;

      if(argshave(_id_434809FD34BABEE0, "disconnect1")) {
        _id_50BBC2CAB314EDAB iprintlnbold("Waiting");
        wait 10;
      }
    }
  }

  if(argshave(_id_434809FD34BABEE0, "disconnect1") || argshave(_id_434809FD34BABEE0, "disconnect2") || argshave(_id_434809FD34BABEE0, "disconnect3")) {
    playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();
    _id_645DE575B455626C(playertospectate);
  }

  if(argshave(_id_434809FD34BABEE0, "killchain")) {
    for(playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer())
      waitframe();

    killplayer(playertospectate, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 3;
  }

  if(argshave(_id_434809FD34BABEE0, "killchain")) {
    for(playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer())
      waitframe();

    killplayer(playertospectate, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 3;
  }

  if(argshave(_id_434809FD34BABEE0, "killchain")) {
    for(playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer())
      waitframe();

    killplayer(playertospectate, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 3;
  }

  if(argshave(_id_434809FD34BABEE0, "killchain")) {
    for(playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer())
      waitframe();

    killplayer(playertospectate, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 3;
  }

  if(argshave(_id_434809FD34BABEE0, "killchain")) {
    for(playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer())
      waitframe();

    killplayer(playertospectate, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 3;
  }

  if(argshave(_id_434809FD34BABEE0, "gulag1")) {
    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_DF49F9975E17B225(1);
        killplayer(player, _id_5D192B4C08040010[0]);
      }
    }

    wait 10;
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag2") || argshave(_id_434809FD34BABEE0, "gulag3")) {
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_50BBC2CAB314EDAB waittill("killcam_ended");
    wait 2;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_DF49F9975E17B225(1);
        killplayer(player, _id_5D192B4C08040010[0]);
      }
    }

    while(!isDefined(_id_50BBC2CAB314EDAB getspectatingplayer()))
      waitframe();

    _id_3E2EF879EE8848E2 = _id_50BBC2CAB314EDAB getspectatingplayer();
    _id_3E2EF879EE8848E2 _id_DF49F9975E17B225(1);
    wait 1;

    foreach(player in _id_5D192B4C08040010[0]) {
      player _id_DF49F9975E17B225(1);
      killplayer(player, _id_5D192B4C08040010[1]);
    }

    while(!istrue(_id_3E2EF879EE8848E2.gulagarena))
      waitframe();

    wait 5;

    if(argshave(_id_434809FD34BABEE0, "gulag2")) {
      setspawnpoint = spawnStruct();
      setspawnpoint.playerspawnpos = (26474, -16709, -162);
      setspawnpoint.playerspawnangles = (85, 135, 0);
      _id_3E2EF879EE8848E2.setspawnpoint = setspawnpoint;

      foreach(player in _id_5D192B4C08040010[0]) {
        if(istrue(player.gulagarena)) {
          player _id_DF49F9975E17B225(1);
          killplayer(player, _id_5D192B4C08040010[1]);
          break;
        }
      }

      while(!_id_3E2EF879EE8848E2 islinked())
        waitframe();

      while(_id_3E2EF879EE8848E2 islinked())
        waitframe();

      waitframe();
      _id_3C70A7175FBFA3FC = _id_3E2EF879EE8848E2 getplayerangles();
      _id_3E2EF879EE8848E2 setplayerangles((85, _id_3C70A7175FBFA3FC[1], 0));
    } else
      killplayer(_id_3E2EF879EE8848E2, _id_5D192B4C08040010[1]);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag4")) {
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    enemy = killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    enemy _id_DF49F9975E17B225(1);
    killplayer(enemy, _id_92B132654E85CBC4);
  }

  if(argshave(_id_434809FD34BABEE0, "gulaggulag")) {
    _id_19E7EC57B8CFB985 = getdvarint("dvar_AD0DDAF795B2EF1A", 0);
    _id_8AAC3EFABCD3A679 = getdvarint("dvar_AD0DD9F795B2ECE7", 5);
    setDvar("dvar_E5F703A38F6E8043", 9999);
    setDvar("dvar_8BDEE07FA09E810A", _id_19E7EC57B8CFB985);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    enemy = killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    setDvar("dvar_8BDEE07FA09E810A", _id_8AAC3EFABCD3A679);

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_DF49F9975E17B225(1);
        killplayer(player, _id_5D192B4C08040010[0]);
      }
    }

    setDvar("dvar_8BDEE07FA09E810A", _id_19E7EC57B8CFB985);
    enemy _id_DF49F9975E17B225(1);
    killplayer(enemy, _id_5D192B4C08040010[1]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena) && !istrue(enemy.gulagarena))
      waitframe();

    wait 5;
    killplayer(_id_50BBC2CAB314EDAB, enemy);
    setDvar("dvar_E5F703A38F6E8043", 90);
  }

  if(argshave(_id_434809FD34BABEE0, "killkill")) {
    enemy = _id_5D192B4C08040010[0][0];

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayer(player, enemy);
    }

    killplayer(enemy, _id_50BBC2CAB314EDAB);
    wait 10;
    killplayer(_id_50BBC2CAB314EDAB, enemy);
  }

  if(argshave(_id_434809FD34BABEE0, "killcam2")) {
    enemy = killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    wait 3;
    killplayer(_id_50BBC2CAB314EDAB.nextplayertospectate, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag5") || argshave(_id_434809FD34BABEE0, "gulag6")) {
    _id_71A8E3C80DF475A0 = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(!isDefined(_id_71A8E3C80DF475A0) && player != _id_50BBC2CAB314EDAB) {
        _id_71A8E3C80DF475A0 = player;
        continue;
      }

      killplayer(player, _id_5D192B4C08040010[0]);
      _id_6489FCDFE6FA2E36::waittillspectating(player);
    }

    _id_71A8E3C80DF475A0 _id_DF49F9975E17B225(1);

    if(argshave(_id_434809FD34BABEE0, "gulag6")) {
      setDvar("dvar_E5F703A38F6E8043", 9999);
      _id_19E7EC57B8CFB985 = getdvarint("dvar_AD0DDAF795B2EF1A", 5);
      setDvar("dvar_8BDEE07FA09E810A", _id_19E7EC57B8CFB985);
      _id_71A8E3C80DF475A0.longgulagstream = 1;
    }

    killplayer(_id_71A8E3C80DF475A0, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag7")) {
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_50BBC2CAB314EDAB waittill("killcam_ended");
    wait 2;
    _id_435B226327D6361A = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_DF49F9975E17B225(1);
        _id_435B226327D6361A = player;
        _id_435B226327D6361A _id_67708F418B1FAC79::initplayerjail();
        break;
      }
    }

    while(!isDefined(_id_50BBC2CAB314EDAB getspectatingplayer()))
      waitframe();

    wait 1;
    _id_9AF272F7C0618531 = undefined;

    foreach(player in _id_5D192B4C08040010[0]) {
      player _id_DF49F9975E17B225(1);
      _id_9AF272F7C0618531 = player;
      killplayer(player, _id_5D192B4C08040010[1]);
      break;
    }

    while(!istrue(_id_435B226327D6361A.gulagarena) && !istrue(_id_9AF272F7C0618531.gulagarena))
      waitframe();

    wait 5;
    setDvar("dvar_E43719F8CB449C07", 1);
    killplayer(_id_9AF272F7C0618531, _id_435B226327D6361A);

    while(_id_50BBC2CAB314EDAB getspectatingplayer() != _id_435B226327D6361A)
      wait 1;

    wait 5;
    setDvar("dvar_E43719F8CB449C07", 0);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag8")) {
    level.gulag.timelimit = 3;
    setDvar("scr_br_fc_overtime", 3);
    setDvar("dvar_E5F703A38F6E8043", -1);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_50BBC2CAB314EDAB waittill("killcam_ended");
    wait 2;
    _id_435B226327D6361A = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_DF49F9975E17B225(1);
        _id_435B226327D6361A = player;
        _id_435B226327D6361A _id_67708F418B1FAC79::initplayerjail();
        break;
      }
    }

    while(!isDefined(_id_50BBC2CAB314EDAB getspectatingplayer()))
      waitframe();

    while(_id_50BBC2CAB314EDAB getspectatingplayer() != _id_435B226327D6361A) {
      iprintlnbold("Switch to spectating gulag player");
      waitframe();
    }

    wait 1;
    _id_9AF272F7C0618531 = undefined;

    foreach(player in _id_5D192B4C08040010[0]) {
      player _id_DF49F9975E17B225(1);
      _id_9AF272F7C0618531 = player;
      killplayer(player, _id_5D192B4C08040010[1]);
      break;
    }
  }

  if(argshave(_id_434809FD34BABEE0, "gulag9")) {
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    enemy = killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    enemy _id_DF49F9975E17B225(1);
    killplayer(enemy, _id_92B132654E85CBC4);

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayer(player, _id_5D192B4C08040010[0]);
    }

    foreach(player in _id_5D192B4C08040010[0]) {
      if(player != enemy)
        killplayer(player, _id_5D192B4C08040010[1]);
    }

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 5;
    setDvar("dvar_E43719F8CB449C07", 1);
    setDvar("dvar_2C879521333C4987", 3);
    killplayer(_id_50BBC2CAB314EDAB, enemy);
    wait 9;
    setDvar("dvar_E43719F8CB449C07", 0);
    setDvar("dvar_2C879521333C4987", 0);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag10")) {
    _id_57B48EF0392DDD42 = _id_5D192B4C08040010[0][0];
    _id_57B48EF0392DDD42 _id_DF49F9975E17B225(1);
    killplayer(_id_57B48EF0392DDD42, _id_5D192B4C08040010[1]);
    _id_57B48DF0392DDB0F = _id_5D192B4C08040010[1][0];
    _id_57B48DF0392DDB0F _id_DF49F9975E17B225(1);
    killplayer(_id_57B48DF0392DDB0F, _id_5D192B4C08040010[0]);
    wait 1;
    _id_57B896F03931E4B1 = _id_50BBC2CAB314EDAB;
    _id_57B896F03931E4B1 _id_DF49F9975E17B225(1);
    killplayer(_id_57B896F03931E4B1, _id_5D192B4C08040010[0]);
    _id_57B893F03931DE18 = _id_5D192B4C08040010[0][1];
    _id_57B893F03931DE18 _id_DF49F9975E17B225(1);
    killplayer(_id_57B893F03931DE18, _id_5D192B4C08040010[1]);

    while(!istrue(_id_57B48EF0392DDD42.gulagarena) || !istrue(_id_57B48DF0392DDB0F.gulagarena) || !istrue(_id_57B896F03931E4B1.jailed) || !istrue(_id_57B893F03931DE18.jailed))
      waitframe();

    setDvar("dvar_98B297A8680CBDC2", 1);
    _id_52A4B4A1649783ED = _id_5D192B4C08040010[1][1];
    _id_52A4B4A1649783ED _id_DF49F9975E17B225(1);
    killplayer(_id_52A4B4A1649783ED, _id_5D192B4C08040010[0]);
    wait 1;

    while(istrue(_id_52A4B4A1649783ED.gulagloading))
      waitframe();

    _id_67708F418B1FAC79::shutdowngulag("circle_index", 0);
    wait 1;
    _id_645DE575B455626C(_id_52A4B4A1649783ED);
    wait 3;
    setDvar("dvar_98B297A8680CBDC2", 0);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag11")) {
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    putinlaststand(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[1]);
    wait 1;
    _id_67708F418B1FAC79::shutdowngulag("circle_index", 0);
    wait 1;
    _id_50BBC2CAB314EDAB scripts\mp\laststand::finishreviveplayer("self_revive_success", _id_50BBC2CAB314EDAB);
    wait 5;
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "twooneframe")) {
    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        killplayer(player, _id_5D192B4C08040010[0]);
        break;
      }
    }

    wait 5;

    foreach(player in _id_92B132654E85CBC4) {
      if(isalive(player))
        killplayerinstant(player, _id_5D192B4C08040010[0]);
    }
  }

  if(argshave(_id_434809FD34BABEE0, "suicide")) {
    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayer(player, _id_5D192B4C08040010[0]);
    }

    wait 5;

    if(_id_50BBC2CAB314EDAB scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
      _id_50BBC2CAB314EDAB scripts\mp\utility\perk::removeperk("specialty_pistoldeath");

    _id_50BBC2CAB314EDAB suicide();
  }

  if(argshave(_id_434809FD34BABEE0, "team")) {
    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayerinstant(player, _id_5D192B4C08040010[0]);
    }
  }

  if(argshave(_id_434809FD34BABEE0, "moving")) {
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);

    while(!isDefined(_id_50BBC2CAB314EDAB.playertospectate))
      waitframe();

    player = _id_50BBC2CAB314EDAB.playertospectate;
    dir = anglesToForward(player.angles);
    amount = getdvarint("testforward", 5);

    for(_id_13C5603D4BEEA2FC = _id_50BBC2CAB314EDAB getspectatingplayer(); !isDefined(_id_13C5603D4BEEA2FC); _id_13C5603D4BEEA2FC = _id_50BBC2CAB314EDAB getspectatingplayer()) {
      _id_E4A58E54D20994F2 = player.origin + dir * amount;
      player setOrigin(_id_E4A58E54D20994F2);
      waitframe();
    }
  }

  if(argshave(_id_434809FD34BABEE0, "heli1") || argshave(_id_434809FD34BABEE0, "heli2")) {
    _id_3E2EF879EE8848E2 = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        if(!isDefined(_id_3E2EF879EE8848E2)) {
          _id_3E2EF879EE8848E2 = player;
          continue;
        }

        killplayerinstant(player, _id_5D192B4C08040010[0]);
      }
    }

    wait 1;
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 1;
    keys = getarraykeys(level.vehicle.instances["little_bird"]);
    heli = level.vehicle.instances["little_bird"][keys[0]];
    instance = heli getlinkedscriptableinstance();
    _id_3E2EF879EE8848E2 setOrigin(heli.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(instance, "single", "vehicle_use", _id_3E2EF879EE8848E2, 0);

    if(argshave(_id_434809FD34BABEE0, "heli2")) {
      wait 3;
      _id_645DE575B455626C(_id_3E2EF879EE8848E2);
    }
  }

  if(argshave(_id_434809FD34BABEE0, "water"))
    _id_50BBC2CAB314EDAB setOrigin((28252, -32627, -415));

  if(argshave(_id_434809FD34BABEE0, "disconnectswitch1")) {
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    _id_3E2EF879EE8848E2 = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();

    while(!_id_50BBC2CAB314EDAB buttonPressed("BUTTON_RSHLDR"))
      waitframe();

    _id_4995442795B82170 = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB && player != _id_3E2EF879EE8848E2) {
        _id_4995442795B82170 = player;
        break;
      }
    }

    wait 0.5;
    _id_645DE575B455626C(_id_4995442795B82170);
  }

  if(argshave(_id_434809FD34BABEE0, "disconnectswitch2")) {
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    _id_3E2EF879EE8848E2 = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();

    while(!_id_50BBC2CAB314EDAB buttonPressed("BUTTON_RSHLDR"))
      waitframe();

    wait 0.5;
    _id_645DE575B455626C(_id_3E2EF879EE8848E2);
  }

  if(argshave(_id_434809FD34BABEE0, "endspectate")) {
    level.br_infils_disabled = 1;
    setDvar("br_minplayers", 2);
    level.gulag.maxuses = 0;
    wait 1;
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 2;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayerinstant(player, _id_5D192B4C08040010[0]);
    }

    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 2;
    enemy = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();
    killplayerinstant(enemy, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 2;
    enemy = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();
    killplayerinstant(enemy, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 2;
    enemy = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();
    killplayerinstant(enemy, _id_5D192B4C08040010[1]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    wait 2;
  }

  if(argshave(_id_434809FD34BABEE0, "teamwipe1")) {
    setDvar("dvar_2C879521333C4987", 5);

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        killplayerinstant(player, _id_5D192B4C08040010[0]);
    }

    wait(getdvarfloat("test_teamwipe", 5));
    enemy = killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    wait(getdvarfloat("dvar_1F5EA86D19B61851", 13));
    killplayerinstant(enemy, _id_5D192B4C08040010[1]);
  }

  if(argshave(_id_434809FD34BABEE0, "deathswitch1")) {
    setDvar("dvar_2C879521333C4987", 5);
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_6489FCDFE6FA2E36::waittillspectating(_id_50BBC2CAB314EDAB);
    _id_3E2EF879EE8848E2 = _id_50BBC2CAB314EDAB _id_6489FCDFE6FA2E36::playergetspectatingplayer();

    while(!_id_50BBC2CAB314EDAB buttonPressed("BUTTON_RSHLDR"))
      waitframe();

    _id_4995442795B82170 = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB && player != _id_3E2EF879EE8848E2) {
        _id_4995442795B82170 = player;
        break;
      }
    }

    wait 0.5;
    killplayerinstant(_id_4995442795B82170, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "squadwidget")) {
    setDvar("dvar_E5F703A38F6E8043", 9999);
    setDvar("dvar_2C879521333C4987", 3);

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB)
        _id_645DE575B455626C(player);
    }

    wait 5;
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    killplayerinstant(_id_90465AE4437C9ABA, _id_50BBC2CAB314EDAB);
    wait(getdvarfloat("test_squadwidget", 4));
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_904659E4437C9887);
  }

  if(argshave(_id_434809FD34BABEE0, "killall")) {
    level.overrideingraceperiod = 1;
    _id_B0DFD912BE32D040 = _id_92B132654E85CBC4[1];

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_B0DFD912BE32D040)
        killplayerinstant(player, _id_5D192B4C08040010[0]);
    }

    foreach(player in _id_5D192B4C08040010[0])
    killplayerinstant(player, _id_5D192B4C08040010[1]);

    foreach(player in _id_5D192B4C08040010[1])
    killplayerinstant(player, _id_5D192B4C08040010[0]);

    wait 10;
    _id_645DE575B455626C(_id_B0DFD912BE32D040);
    level.overrideingraceperiod = undefined;
  }

  if(argshave(_id_434809FD34BABEE0, "moneykill")) {
    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        player _id_6AFF3948CF4CCA03::playersetplundercount(45);
        player _id_DF49F9975E17B225(1);
        killplayerinstant(player, _id_5D192B4C08040010[0]);
      }
    }

    wait 5;
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "buyback1")) {
    scriptcircleat(_id_50BBC2CAB314EDAB.origin, 500);
    setDvar("dvar_E5F703A38F6E8043", -1);
    _id_52A4B2A164977F87 = _id_50BBC2CAB314EDAB;
    _id_52A4B2A164977F87 _id_DF49F9975E17B225(1);
    killplayer(_id_52A4B2A164977F87, _id_5D192B4C08040010[1]);
    _id_90460AE4437BEACA = _id_5D192B4C08040010[1][0];
    _id_90460AE4437BEACA _id_DF49F9975E17B225(1);
    killplayer(_id_90460AE4437BEACA, _id_5D192B4C08040010[1]);

    while(!istrue(_id_52A4B2A164977F87.gulagarena))
      waitframe();

    wait 5;
    killplayerinstant(_id_52A4B2A164977F87, []);

    while(!isDefined(_id_52A4B2A164977F87 getspectatingplayer()))
      waitframe();

    _id_52A4B3A1649781BA = _id_52A4B2A164977F87 getspectatingplayer();
    _id_52A4B3A1649781BA _id_DF49F9975E17B225(1);
    _id_52A4B4A1649783ED = undefined;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_52A4B2A164977F87 && player != _id_52A4B3A1649781BA) {
        _id_52A4B4A1649783ED = player;
        break;
      }
    }

    _id_52A4B4A1649783ED _id_6AFF3948CF4CCA03::playersetplundercount(45);
    killplayer(_id_52A4B3A1649781BA, _id_5D192B4C08040010[1]);

    while(!istrue(_id_52A4B3A1649781BA.jailed))
      waitframe();

    while(!isDefined(_id_52A4B2A164977F87 getspectatingplayer()) || _id_52A4B2A164977F87 getspectatingplayer() != _id_52A4B3A1649781BA)
      waitframe();

    _id_904609E4437BE897 = _id_5D192B4C08040010[1][1];
    _id_904609E4437BE897 _id_DF49F9975E17B225(1);
    killplayer(_id_904609E4437BE897, _id_5D192B4C08040010[1]);

    while(!istrue(_id_52A4B3A1649781BA.gulagarena))
      waitframe();

    wait 5;
    setDvar("dvar_2C879521333C4987", 3);
    killplayerinstant(_id_52A4B3A1649781BA, []);
    _id_52A4B4A1649783ED _id_7E52B56769FA7774::addrespawntoken(1);
    _id_52A4B2A164977F87 thread _id_67708F418B1FAC79::playergulagautowin(_id_52A4B4A1649783ED, 0);
  }

  if(argshave(_id_434809FD34BABEE0, "teamwipe2")) {
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    _id_50BBC2CAB314EDAB waittill("killcam_ended");
    wait 2;
    count = 0;

    foreach(player in _id_92B132654E85CBC4) {
      if(player != _id_50BBC2CAB314EDAB) {
        if(count > 0) {
          player _id_6AFF3948CF4CCA03::playersetplundercount(45);
          player _id_DF49F9975E17B225(1);
        }

        killplayerinstant(player, _id_5D192B4C08040010[1]);
        count++;
        wait 5;
      }
    }
  }

  if(argshave(_id_434809FD34BABEE0, "gulag11")) {
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    putinlaststand(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[1]);
    wait 1;
    _id_67708F418B1FAC79::shutdowngulag("circle_index", 0);
    wait 1;
    _id_50BBC2CAB314EDAB scripts\mp\laststand::finishreviveplayer("self_revive_success", _id_50BBC2CAB314EDAB);
    wait 5;
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "infilDeath")) {
    thread waitandsuicide(getdvarint("test_suicide", 1), _id_92B132654E85CBC4[1]);
    onprematchstarted2();
    level waittill("br_c130_left_bounds");
    wait 2;
    _id_92B132654E85CBC4[2] _id_DF49F9975E17B225(0);
    killplayerinstant(_id_92B132654E85CBC4[2], _id_5D192B4C08040010[0]);
    wait 5;
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(0);
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
  }

  if(argshave(_id_434809FD34BABEE0, "reconGulag1")) {
    setDvar("br_minplayers", 9);
    wait 5;
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[1][0];
    _id_645DE575B455626C(_id_5D192B4C08040010[0][2]);
    _id_645DE575B455626C(_id_5D192B4C08040010[0][1]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][2]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][1]);
    _id_645DE575B455626C(_id_92B132654E85CBC4[2]);
    _id_645DE575B455626C(_id_92B132654E85CBC4[1]);
    wait 1;
    _id_50BBC2CAB314EDAB playerstartrecondronewait();
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    killplayerinstant(_id_90465AE4437C9ABA, _id_904659E4437C9887);
    wait 7;
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);

    if(!_id_50BBC2CAB314EDAB scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
      _id_50BBC2CAB314EDAB scripts\mp\utility\perk::giveperk("specialty_pistoldeath");

    killplayerinstant(_id_50BBC2CAB314EDAB, _id_904659E4437C9887, 1);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 5;
    killplayerinstant(_id_90465AE4437C9ABA, _id_50BBC2CAB314EDAB);
  }

  if(argshave(_id_434809FD34BABEE0, "reconGulag2")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_4995472795B82809 = _id_92B132654E85CBC4[1];
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995472795B82809 == _id_50BBC2CAB314EDAB)
      _id_4995472795B82809 = _id_92B132654E85CBC4[0];
    else if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[0];

    _id_645DE575B455626C(_id_5D192B4C08040010[0][2]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][2]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][1]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][0]);
    killplayerinstant(_id_4995442795B82170, _id_90465AE4437C9ABA);
    wait 1;
    _id_4995472795B82809 playerstartrecondronewait();
    wait 2;
    killplayerinstant(_id_50BBC2CAB314EDAB, _id_90465AE4437C9ABA);
    _id_50BBC2CAB314EDAB waittill("killcam_ended");
    wait 3;
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayerinstant(_id_904659E4437C9887, _id_4995472795B82809);
    _id_4995472795B82809 _id_DF49F9975E17B225(1);

    if(!_id_4995472795B82809 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
      _id_4995472795B82809 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");

    killplayerinstant(_id_4995472795B82809, _id_90465AE4437C9ABA, 1);

    while(!istrue(_id_4995472795B82809.gulagarena))
      waitframe();

    wait 5;
    killplayerinstant(_id_4995472795B82809, _id_904659E4437C9887);
  }

  if(argshave(_id_434809FD34BABEE0, "endGameTwoDie")) {
    setDvar("br_minplayers", 8);
    wait 5;
    _id_67708F418B1FAC79::shutdowngulag("circle_index", 0);
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_4995472795B82809 = _id_92B132654E85CBC4[1];
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995472795B82809 == _id_50BBC2CAB314EDAB)
      _id_4995472795B82809 = _id_92B132654E85CBC4[0];
    else if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[0];

    killplayerinstant(_id_5D192B4C08040010[0][2], _id_50BBC2CAB314EDAB);
    killplayerinstant(_id_5D192B4C08040010[0][1], _id_50BBC2CAB314EDAB);
    killplayerinstant(_id_5D192B4C08040010[1][2], _id_50BBC2CAB314EDAB);
    killplayerinstant(_id_5D192B4C08040010[1][1], _id_50BBC2CAB314EDAB);
    killplayerinstant(_id_5D192B4C08040010[1][0], _id_50BBC2CAB314EDAB);
    killplayerinstant(_id_4995472795B82809, _id_90465AE4437C9ABA);
    killplayerinstant(_id_4995442795B82170, _id_90465AE4437C9ABA);
    wait 3;
    _id_50BBC2CAB314EDAB scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    wait 3;
    _id_90465AE4437C9ABA dodamage(999, _id_90465AE4437C9ABA.origin, _id_90465AE4437C9ABA, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

    while(isalive(_id_50BBC2CAB314EDAB)) {
      _id_50BBC2CAB314EDAB dodamage(999, _id_50BBC2CAB314EDAB.origin, _id_50BBC2CAB314EDAB, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      waitframe();
    }
  }

  if(argshave(_id_434809FD34BABEE0, "infiniteLoot")) {
    setomnvar("scriptable_loot_hide", 0);
    startorigin = _id_50BBC2CAB314EDAB.origin;
    startangles = _id_50BBC2CAB314EDAB.angles;
    _id_CDE7F7F943B0F728 = 0;
    _id_2E3D43D19BBE802B = 0;
    _id_338DEEFD32D7AE30 = 0;

    for(;;) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(startorigin + (_id_CDE7F7F943B0F728, _id_2E3D43D19BBE802B, 0), startangles);
      _id_7E52B56769FA7774::spawnpickup("brloot_self_revive", _id_CB4FAD49263E20C4);
      _id_338DEEFD32D7AE30++;
      _id_CDE7F7F943B0F728 = _id_CDE7F7F943B0F728 + 10;

      if(_id_CDE7F7F943B0F728 > 5000) {
        _id_CDE7F7F943B0F728 = 0;
        _id_2E3D43D19BBE802B = _id_2E3D43D19BBE802B + 10;

        if(_id_2E3D43D19BBE802B > 100)
          _id_2E3D43D19BBE802B = 0;
      }

      if(_id_338DEEFD32D7AE30 > 8) {
        waitframe();
        _id_338DEEFD32D7AE30 = 0;
      }
    }
  }

  if(argshave(_id_434809FD34BABEE0, "tempTeamTest")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_90465AE4437C9ABA hudoutlineenableforclient(_id_50BBC2CAB314EDAB, "defaulthudoutline");
    _id_50BBC2CAB314EDAB._id_B5091EFEFE8E436B = "axis";
    _id_90465AE4437C9ABA._id_B5091EFEFE8E436B = "axis";
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22a")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[1][0];
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    _id_904658E4437C9654 _id_DF49F9975E17B225(1);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_904658E4437C9654, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 10;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    _id_9AF272F7C0618531 = _id_90465AE4437C9ABA;

    if(_id_F0EA4030349A33D5 == _id_90465AE4437C9ABA)
      _id_9AF272F7C0618531 = _id_904659E4437C9887;

    killplayer(_id_50BBC2CAB314EDAB, _id_9AF272F7C0618531);
    wait(getdvarint("test_wait", 2));
    _id_645DE575B455626C(_id_F0EA4030349A33D5);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22b")) {
    setDvar("dvar_8BDEE07FA09E810A", 0);
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[1][0];
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_B03F2C4AB975486E = _id_92B132654E85CBC4[1];

    if(_id_B03F2C4AB975486E == _id_50BBC2CAB314EDAB || _id_B03F2C4AB975486E == _id_70189B6A231DF8D6)
      _id_B03F2C4AB975486E = _id_92B132654E85CBC4[2];

    _id_B03F2C4AB975486E _id_DF49F9975E17B225(1);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 12;
    killplayer(_id_B03F2C4AB975486E, _id_904658E4437C9654);
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    _id_9AF272F7C0618531 = _id_90465AE4437C9ABA;

    if(_id_F0EA4030349A33D5 == _id_90465AE4437C9ABA)
      _id_9AF272F7C0618531 = _id_904659E4437C9887;

    killplayer(_id_50BBC2CAB314EDAB, _id_9AF272F7C0618531);

    while(!isDefined(_id_50BBC2CAB314EDAB getspectatingplayer()) || _id_50BBC2CAB314EDAB getspectatingplayer() != _id_F0EA4030349A33D5)
      waitframe();

    wait(getdvarint("test_waitafter", 3));
    killplayer(_id_F0EA4030349A33D5, _id_90465AE4437C9ABA);

    while(!isDefined(_id_50BBC2CAB314EDAB getspectatingplayer()) || _id_50BBC2CAB314EDAB getspectatingplayer() != _id_B03F2C4AB975486E)
      waitframe();

    _id_DF2FBB13C226BE75 = "timeout";

    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
      _id_DF2FBB13C226BE75 = "br_twotwo_gulag_win_jail_timeout";

    thread _id_67708F418B1FAC79::gulagvictory(_id_B03F2C4AB975486E.arena, _id_B03F2C4AB975486E, 1, 0, _id_DF2FBB13C226BE75);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22c")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[1][0];
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    _id_904658E4437C9654 _id_DF49F9975E17B225(1);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_904658E4437C9654, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 10;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    _id_9AF272F7C0618531 = _id_90465AE4437C9ABA;

    if(_id_F0EA4030349A33D5 == _id_90465AE4437C9ABA)
      _id_9AF272F7C0618531 = _id_904659E4437C9887;

    killplayer(_id_50BBC2CAB314EDAB, _id_9AF272F7C0618531);
    killplayer(_id_F0EA4030349A33D5, _id_9AF272F7C0618531);
    setDvar("scr_br_pe_jailbreak_duration", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    _id_337BD370F7C5E6F9::_id_145E3D3099BB97C4(eventdata);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22d")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 10;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    _id_24B7D6DC16777F00 = _id_90465AE4437C9ABA;

    if(_id_F0EA4030349A33D5 == _id_90465AE4437C9ABA)
      _id_24B7D6DC16777F00 = _id_904659E4437C9887;

    killplayer(_id_50BBC2CAB314EDAB, _id_24B7D6DC16777F00);
    killplayer(_id_F0EA4030349A33D5, _id_24B7D6DC16777F00);
    wait 10;
    setDvar("scr_br_pe_jailbreak_duration", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    _id_337BD370F7C5E6F9::_id_145E3D3099BB97C4(eventdata);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22e")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);
    wait 1;
    killplayer(_id_4995442795B82170, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 10;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    killplayer(_id_90465AE4437C9ABA, _id_50BBC2CAB314EDAB);
    killplayer(_id_904659E4437C9887, _id_50BBC2CAB314EDAB);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22f")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 5;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    _id_50BBC2CAB314EDAB iprintlnbold("END ARENA");
    _id_50BBC2CAB314EDAB.arena notify("matchEnded");
    _id_50BBC2CAB314EDAB.arena notify("fight_over_early");
    thread _id_67708F418B1FAC79::handleendarena(_id_50BBC2CAB314EDAB.arena, undefined, 1, 1, "debug", _id_4995442795B82170);
    wait 10;
    _id_50BBC2CAB314EDAB iprintlnbold("Kill Players");
    killplayer(_id_90465AE4437C9ABA, _id_50BBC2CAB314EDAB);
    killplayer(_id_904659E4437C9887, _id_50BBC2CAB314EDAB);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22g")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[0][2];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait(getdvarint("test_wait", 12));

    if(getdvarint("test_kill", 0)) {
      killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
      killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);
      wait(getdvarfloat("dvar_3A9D30277E079900", 0));
    } else if(getdvarint("test_kill2", 0)) {
      killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
      wait(getdvarfloat("dvar_3A9D30277E079900", 0));
    }

    arena = _id_50BBC2CAB314EDAB.arena;

    if(getdvarint("test_allies", 0)) {
      _id_160D0F1B81840667::vip_respawnplayer(_id_50BBC2CAB314EDAB, _id_4995442795B82170, "debug");
      _id_160D0F1B81840667::vip_respawnplayer(_id_70189B6A231DF8D6, _id_4995442795B82170, "debug");
    } else {
      _id_160D0F1B81840667::vip_respawnplayer(_id_90465AE4437C9ABA, _id_904658E4437C9654, "debug");
      _id_160D0F1B81840667::vip_respawnplayer(_id_90465AE4437C9ABA, _id_904658E4437C9654, "debug");
    }
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22h")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[0][2];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait(getdvarint("test_wait", 12));

    if(getdvarint("test_kill", 0)) {
      killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
      killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);
      wait(getdvarfloat("dvar_3A9D30277E079900", 0));
    } else if(getdvarint("test_kill2", 1)) {
      killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
      wait(getdvarfloat("dvar_3A9D30277E079900", 1));
    }

    arena = _id_50BBC2CAB314EDAB.arena;

    if(getdvarint("test_allies", 1)) {
      _id_160D0F1B81840667::vip_respawnplayer(_id_50BBC2CAB314EDAB, _id_4995442795B82170, "debug");
      _id_160D0F1B81840667::vip_respawnplayer(_id_70189B6A231DF8D6, _id_4995442795B82170, "debug");
    } else {
      _id_160D0F1B81840667::vip_respawnplayer(_id_90465AE4437C9ABA, _id_904658E4437C9654, "debug");
      _id_160D0F1B81840667::vip_respawnplayer(_id_90465AE4437C9ABA, _id_904658E4437C9654, "debug");
    }
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22i")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[0][2];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait(getdvarint("test_wait", 5));
    _id_645DE575B455626C(_id_70189B6A231DF8D6);
    _id_645DE575B455626C(_id_90465AE4437C9ABA);
    _id_645DE575B455626C(_id_904659E4437C9887);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22j")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_904658E4437C9654 = _id_5D192B4C08040010[0][2];
    _id_90460AE4437BEACA = _id_5D192B4C08040010[1][0];
    _id_904609E4437BE897 = _id_5D192B4C08040010[1][1];
    _id_904608E4437BE664 = _id_5D192B4C08040010[1][2];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    _id_904658E4437C9654 _id_DF49F9975E17B225(1);
    _id_90460AE4437BEACA _id_DF49F9975E17B225(1);
    _id_904609E4437BE897 _id_DF49F9975E17B225(1);
    _id_904608E4437BE664 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_50BBC2CAB314EDAB);
    killplayer(_id_904659E4437C9887, _id_50BBC2CAB314EDAB);
    killplayer(_id_90460AE4437BEACA, _id_50BBC2CAB314EDAB);
    killplayer(_id_904609E4437BE897, _id_50BBC2CAB314EDAB);

    while(!istrue(_id_90465AE4437C9ABA.gulagarena))
      waitframe();

    wait(getdvarint("test_wait", 1));
    killplayer(_id_50BBC2CAB314EDAB, _id_90465AE4437C9ABA);
    killplayer(_id_70189B6A231DF8D6, _id_90465AE4437C9ABA);
    killplayer(_id_904658E4437C9654, _id_50BBC2CAB314EDAB);
    killplayer(_id_904608E4437BE664, _id_50BBC2CAB314EDAB);

    while(!istrue(_id_50BBC2CAB314EDAB.jailed) || !istrue(_id_70189B6A231DF8D6.jailed) || !istrue(_id_904658E4437C9654.jailed) || !istrue(_id_904608E4437BE664.jailed))
      waitframe();

    _id_67708F418B1FAC79::shutdowngulag("debug", 0);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22k")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[0];

    if(_id_70189B6A231DF8D6 == _id_50BBC2CAB314EDAB)
      _id_70189B6A231DF8D6 = _id_92B132654E85CBC4[1];

    _id_70189B6A231DF8D6 _id_DF49F9975E17B225(1);
    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    _id_50BBC2CAB314EDAB _id_DF49F9975E17B225(1);
    _id_90465AE4437C9ABA _id_DF49F9975E17B225(1);
    _id_904659E4437C9887 _id_DF49F9975E17B225(1);
    killplayer(_id_90465AE4437C9ABA, _id_5D192B4C08040010[1]);
    killplayer(_id_904659E4437C9887, _id_5D192B4C08040010[1]);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[0]);
    killplayer(_id_70189B6A231DF8D6, _id_5D192B4C08040010[0]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    wait 12;
    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    killplayer(_id_70189B6A231DF8D6, _id_50BBC2CAB314EDAB);
    killplayer(_id_904659E4437C9887, _id_50BBC2CAB314EDAB);
  }

  if(argshave(_id_434809FD34BABEE0, "jailbreakRespawn")) {
    _id_90465AE4437C9ABA = _id_5D192B4C08040010[0][0];
    _id_904659E4437C9887 = _id_5D192B4C08040010[0][1];
    _id_4995472795B82809 = _id_92B132654E85CBC4[0];

    if(_id_4995472795B82809 == _id_50BBC2CAB314EDAB)
      _id_4995472795B82809 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 _id_DF49F9975E17B225(1);
    killplayer(_id_50BBC2CAB314EDAB, _id_5D192B4C08040010[1]);
    killplayer(_id_4995472795B82809, _id_5D192B4C08040010[1]);
    killplayer(_id_4995442795B82170, _id_5D192B4C08040010[0]);
    wait(getdvarint("dvar_3A9D33277E079F99", 10));
    setDvar("scr_br_pe_jailbreak_duration", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    _id_337BD370F7C5E6F9::_id_145E3D3099BB97C4(eventdata);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22l")) {
    [_id_92B132654E85CBC4, _id_5D192B4C08040010] = _id_2EA11E29FB71E2AD(_id_434809FD34BABEE0, 4);
    _id_52A4B2A164977F87 = _id_50BBC2CAB314EDAB;
    _id_52A4B3A1649781BA = _id_5D192B4C08040010[0][0];
    _id_52A4B4A1649783ED = _id_5D192B4C08040010[1][0];
    _id_52A4ADA164977488 = _id_5D192B4C08040010[2][0];
    _id_52A4AEA1649776BB = _id_5D192B4C08040010[2][1];
    _id_4995472795B82809 = _id_92B132654E85CBC4[0];

    if(_id_4995472795B82809 == _id_50BBC2CAB314EDAB)
      _id_4995472795B82809 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_52A4B2A164977F87 _id_DF49F9975E17B225(1);
    _id_52A4B3A1649781BA _id_DF49F9975E17B225(1);
    _id_52A4B4A1649783ED _id_DF49F9975E17B225(0);
    _id_52A4ADA164977488 _id_DF49F9975E17B225(1);
    _id_52A4AEA1649776BB _id_DF49F9975E17B225(1);
    killplayer(_id_52A4B2A164977F87, _id_5D192B4C08040010[1]);
    killplayer(_id_52A4B3A1649781BA, _id_5D192B4C08040010[1]);
    killplayer(_id_52A4ADA164977488, _id_5D192B4C08040010[0]);
    killplayer(_id_52A4AEA1649776BB, _id_5D192B4C08040010[0]);
    _id_645DE575B455626C(_id_4995472795B82809);
    _id_645DE575B455626C(_id_4995442795B82170);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][1]);
    _id_645DE575B455626C(_id_5D192B4C08040010[1][2]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    wait 10;
    arena = _id_50BBC2CAB314EDAB.arena;
    killplayer(_id_52A4B2A164977F87, _id_52A4ADA164977488);
    wait 3;
    killplayer(_id_52A4B4A1649783ED, _id_5D192B4C08040010[2][2]);

    while(!isDefined(arena._id_707537A8904AA962) || arena._id_707537A8904AA962.size == 0)
      waitframe();

    _id_FB8418425DC67596 = arena._id_707537A8904AA962[0];
    wait 3;

    while(isalive(_id_FB8418425DC67596))
      _id_FB8418425DC67596 dodamage(_id_FB8418425DC67596.health, _id_52A4B3A1649781BA.origin, _id_52A4B3A1649781BA, _id_52A4B3A1649781BA, "MOD_RIFLE_BULLET", _id_52A4B3A1649781BA getcurrentprimaryweapon());

    while(!isalive(_id_52A4B2A164977F87))
      waitframe();

    wait 3;
    _id_52A4B2A164977F87 _id_DF49F9975E17B225(0);
    killplayer(_id_52A4B2A164977F87, _id_52A4ADA164977488);
  }

  if(argshave(_id_434809FD34BABEE0, "gulag22m")) {
    [_id_92B132654E85CBC4, _id_5D192B4C08040010] = _id_2EA11E29FB71E2AD(_id_434809FD34BABEE0, 4);
    _id_52A4B2A164977F87 = _id_50BBC2CAB314EDAB;
    _id_52A4B3A1649781BA = _id_5D192B4C08040010[0][0];
    _id_52A4B4A1649783ED = _id_5D192B4C08040010[1][0];
    _id_52A4ADA164977488 = _id_5D192B4C08040010[1][1];
    _id_4995472795B82809 = _id_92B132654E85CBC4[0];

    if(_id_4995472795B82809 == _id_50BBC2CAB314EDAB)
      _id_4995472795B82809 = _id_92B132654E85CBC4[1];

    _id_4995442795B82170 = _id_92B132654E85CBC4[2];

    if(_id_4995442795B82170 == _id_50BBC2CAB314EDAB)
      _id_4995442795B82170 = _id_92B132654E85CBC4[1];

    _id_52A4B2A164977F87 _id_DF49F9975E17B225(1);
    _id_52A4B3A1649781BA _id_DF49F9975E17B225(1);
    _id_52A4B4A1649783ED _id_DF49F9975E17B225(1);
    _id_52A4ADA164977488 _id_DF49F9975E17B225(1);
    killplayer(_id_52A4B2A164977F87, _id_5D192B4C08040010[1]);
    killplayer(_id_52A4B3A1649781BA, _id_5D192B4C08040010[1]);
    killplayer(_id_52A4B4A1649783ED, _id_5D192B4C08040010[0]);
    killplayer(_id_52A4ADA164977488, _id_5D192B4C08040010[0]);
    _id_645DE575B455626C(_id_4995472795B82809);
    _id_645DE575B455626C(_id_4995442795B82170);
    _id_645DE575B455626C(_id_5D192B4C08040010[0][1]);
    _id_645DE575B455626C(_id_5D192B4C08040010[0][2]);

    while(!istrue(_id_50BBC2CAB314EDAB.gulagarena))
      waitframe();

    _id_F0EA4030349A33D5 = _id_03AA8E63A56E3416::_id_1BD32287885BB933(_id_50BBC2CAB314EDAB);
    wait 10;
    arena = _id_50BBC2CAB314EDAB.arena;
    killplayer(_id_52A4B3A1649781BA, _id_52A4ADA164977488);
    wait 3;
    killplayer(_id_52A4B2A164977F87, _id_52A4ADA164977488);
  }
}