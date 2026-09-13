/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_attraction_kingofthehill.gsc
****************************************************************/

init() {
  level.brattractions["koth"] = spawnStruct();
  level.brattractions["koth"].locations = [];
  registerlocations();
}

registerlocations() {
  switch (level.script) {
    case "mp_donetsk":
    case "mp_donetsk2":
    case "mp_don3":
      registerlocation((21616, -16071, 1910), 730, 204, 2000, 2151);
      registerlocation((15884, 18421, 846), 500, 108, 3000, 720);
      registerlocation((-1111, -18991, 932), 800, 188, 2000, 1162);
      registerlocation((8223, -25884, 696), 1185, 188, 2000, 982);
      registerlocation((-16115, -25460, 55), 750, 340, 2000, 266);
      registerlocation((16734, -34808, 842), 457, 108, 2000, 768);
      break;
    case "mp_br_mechanics":
      registerlocation((117, -1854, 0), 300, 60, 800, 0);
      registerlocation((-3896, -2143, 335), 500, 334, 2000, 335);
    default:
      break;
  }
}

registerlocation(origin, _id_029A79D378C70E0B, _id_DFE92BB3A3B6A89A, _id_CCB00530D7A24EE3, _id_A943937478CD458D) {
  _id_F98843815888EA41 = 30;
  _id_94E49A1D99BFD258 = level.brattractions["koth"].locations.size;
  level.brattractions["koth"].locations[_id_94E49A1D99BFD258] = spawnStruct();
  location = level.brattractions["koth"].locations[_id_94E49A1D99BFD258];
  location.capturetrigger = spawn("trigger_radius", origin, 0, _id_029A79D378C70E0B, _id_DFE92BB3A3B6A89A);
  location.capturetrigger.radius = _id_029A79D378C70E0B;
  location.capturetrigger.players = [];
  scripts\mp\utility\trigger::makeenterexittrigger(location.capturetrigger, ::playerlocationtriggerenter, ::playerlocationtriggerexit);
  trigorigin = origin + (0, 0, -1 * _id_A943937478CD458D);
  _id_21EFA20E3C93C7D5 = _id_A943937478CD458D + _id_F98843815888EA41;
  location.icontrigger = _id_6731BE38C3B94FF7::createattractionicontrigger("koth", 0, trigorigin, _id_21EFA20E3C93C7D5, "ui_mp_br_mapmenu_icon_poi_sb_koh", _id_CCB00530D7A24EE3, ::playerattractiontriggerenter, ::playerattractiontriggerexit, "br_attraction_koth");
  location.capturetrigger.objectiveiconid = location.icontrigger.closeobjectiveiconid;
  location.icontrigger _id_6731BE38C3B94FF7::triggeraddobjectivetext(&"MP_BR_INGAME/ATTRACT_KOTH_CAPTURE");

  if(getdvarint("dvar_9612881716DBB8B2", 0))
    location.icontrigger _id_6731BE38C3B94FF7::triggercombatarea();

  location.icontrigger.location = location;
  location.capturetrigger.location = location;
  location.besttime = 0;
  location.bestplayer = undefined;
  location.besttimestate = 0;
  location.contested = 0;
}

getkothlocations() {
  return level.brattractions["koth"].locations;
}

playerlocationtriggerenter(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player endon("disconnect");
  player endon("playerLocationTriggerExit");
  player notify("playerLocationTriggerEnter");
  player endon("playerLocationTriggerEnter");
  waittillplayerlanded(player);

  if(istrue(level.brgametype.useserverhud)) {
    if(!isDefined(player.hudkothtimer))
      player.hudkothtimer = _id_6731BE38C3B94FF7::createhudtimer(1);
    else {
      player notify("keepHudKothTimer");
      player.hudkothtimer.alpha = 1;
      player.hudkothtimer.color = (1, 1, 1);
    }
  }

  player.kothtotaltime = 0;
  player.kothlaststarttime = -1;

  if(istrue(level.brgametype.useserverhud)) {
    time = max(self.kothtotaltime / 1000.0, 0.001);
    player.hudkothtimer settenthstimerstatic(time);
  }

  trigger.players[trigger.players.size] = player;
  trigger locationtriggerupdate();
}

playerlocationtriggerexit(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player notify("playerLocationTriggerExit");

  if(!isDefined(player.kothtotaltime)) {
    return;
  }
  player playertimestamp();
  location = trigger.location;
  updatelocationbesttime(location, player.kothtotaltime, player);

  if(isbestplayertime(location, player.kothtotaltime, player))
    location.besttimestate = 0;

  player.kothtotaltime = undefined;
  player.kothlaststarttime = undefined;
  trigger.players = scripts\engine\utility::array_remove(trigger.players, player);
  trigger locationtriggerupdate();
  updatelocationbesttimehud(location);

  if(istrue(level.brgametype.useserverhud))
    player thread playerstoptimerdelete();
}

waittillplayerlanded(player) {
  while(!player isonground())
    waitframe();
}

playerstoptimerdelete() {
  self endon("keepHudKothTimer");
  _id_C01F079EB027D3BC = 1.5;
  _id_B2D4B76E9BBD89ED = 2.0;
  timer = self.hudkothtimer;
  timer.color = (1, 1, 0);
  wait(_id_C01F079EB027D3BC);
  timer fadeovertime(_id_B2D4B76E9BBD89ED);
  timer.alpha = 0;
  wait(_id_B2D4B76E9BBD89ED);

  if(isDefined(timer))
    timer destroy();

  if(isDefined(self))
    self.hudkothtimer = undefined;
}

validplayer(player) {
  return isDefined(player) && isalive(player) && !istrue(player.disconnecting);
}

locationtriggerupdate() {
  contested = 0;
  ownerteam = undefined;

  foreach(player in self.players) {
    if(!validplayer(player)) {
      continue;
    }
    if(!isDefined(ownerteam)) {
      ownerteam = player.team;
      continue;
    }

    if(player.team != ownerteam) {
      contested = 1;
      break;
    }
  }

  self.location.contested = contested;

  if(contested) {
    locationtriggersetpaused(1);
    objective_setownerteam(self.objectiveiconid, undefined);
    objective_setprogressteam(self.objectiveiconid, undefined);
    objective_setlabel(self.objectiveiconid, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
  } else {
    locationtriggersetpaused(0);

    if(isDefined(ownerteam)) {
      objective_setownerteam(self.objectiveiconid, ownerteam);
      objective_setprogressteam(self.objectiveiconid, ownerteam);
      objective_setfriendlylabel(self.objectiveiconid, &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
      objective_setenemylabel(self.objectiveiconid, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS");
    } else {
      objective_setownerteam(self.objectiveiconid, undefined);
      objective_setprogressteam(self.objectiveiconid, undefined);
      objective_setneutrallabel(self.objectiveiconid, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS");
    }
  }

  objective_sethot(self.objectiveiconid, contested);
}

locationtriggersetpaused(_id_EC45F849CE9A05CF) {
  location = self.location;
  location.besttimestate = 0;
  location notify("stopTimeTracking");

  foreach(player in self.players) {
    if(!validplayer(player)) {
      continue;
    }
    if(_id_EC45F849CE9A05CF) {
      player playertimestamp();
      updatelocationbesttime(location, player.kothtotaltime, player);
    } else
      player playertimestart(location);

    player playerupdatehudstate(location);
  }

  if(_id_EC45F849CE9A05CF)
    location notify("zone_reset");
  else
    thread awardcapturepoints(location, self);

  if(location.besttimestate == 0)
    updatelocationbesttimehud(location);
}

awardcapturepoints(location, trigger) {
  level endon("game_ended");
  level endon("zone_reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  _id_CC748B6D457627FE = 1;

  while(!level.gameended) {
    waittime = 0.0;

    while(waittime < _id_CC748B6D457627FE && !level.gameended) {
      wait(level.framedurationseconds);
      waittime = waittime + level.framedurationseconds;

      if(istrue(location.contested))
        waittime = 0.0;
    }

    if(level.gameended) {
      break;
    }

    if(!istrue(location.contested) && !level.gameended) {
      foreach(player in trigger.players) {
        if(!isPlayer(player)) {
          continue;
        }
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_32EED765EF0D59F6");
      }
    }
  }
}

playertimestart(location) {
  if(self.kothlaststarttime == -1) {
    self.kothlaststarttime = gettime();
    time = max(self.kothtotaltime / 1000.0, 0.001);

    if(istrue(level.brgametype.useserverhud))
      self.hudkothtimer settenthstimerup(time);
  }

  thread playerstarttimetracking(location);
  thread playerstartbesttimetracking(location);
}

playerstarttimetracking(location) {
  self endon("disconnect");
  self notify("playerStartTimeTracking");
  self endon("playerStartTimeTracking");
  location endon("stopTimeTracking");

  for(;;) {
    _id_5FD2522E101604A5 = playergettotaltime();
    _id_6731BE38C3B94FF7::playersetattractiontime(_id_5FD2522E101604A5);
    waitframe();
  }
}

playertimestamp() {
  if(self.kothlaststarttime > 0) {
    self.kothtotaltime = playergettotaltime();
    self.kothlaststarttime = -1;
    time = max(self.kothtotaltime / 1000.0, 0.001);

    if(istrue(level.brgametype.useserverhud))
      self.hudkothtimer settenthstimerstatic(time);
  }
}

playergettotaltime() {
  totaltime = 0;

  if(isDefined(self.kothtotaltime))
    totaltime = self.kothtotaltime;

  if(isDefined(self.kothlaststarttime) && self.kothlaststarttime > 0)
    totaltime = totaltime + (gettime() - self.kothlaststarttime);

  return totaltime;
}

onplayerdisconnect(player) {
  if(isDefined(player) && isDefined(player.hudkothtimer))
    player.hudkothtimer destroy();

  foreach(location in level.brattractions["koth"].locations) {
    if(isDefined(player))
      location.capturetrigger.players = scripts\engine\utility::array_remove(location.capturetrigger.players, player);
    else
      location.capturetrigger.players = scripts\engine\utility::array_removeundefined(location.capturetrigger.players);

    location.capturetrigger locationtriggerupdate();
  }
}

playerattractiontriggerenter(player, trigger) {
  player.hudkothbesttime = _id_6731BE38C3B94FF7::createhudtimer(3);
  player.hudkothbesttimelabel = _id_6731BE38C3B94FF7::createhudstring(2);
  trigger.location.capturetrigger locationtriggerupdate();
  player playerupdatebesttimehud(trigger.location);
}

playerattractiontriggerexit(player, trigger) {
  if(isDefined(player.hudkothbesttimelabel))
    player.hudkothbesttimelabel destroy();

  if(isDefined(player.hudkothbesttime))
    player.hudkothbesttime destroy();
}

isbestplayertime(location, time, player) {
  return isDefined(location.bestplayer) && location.bestplayer == player && time == location.besttime;
}

updatelocationbesttime(location, time, player) {
  if(isDefined(time) && time >= location.besttime) {
    location.besttime = time;
    location.bestplayer = player;
  }
}

updatelocationbesttimehud(location) {
  foreach(ent in location.icontrigger.triggerenterents) {
    if(isDefined(ent) && isPlayer(ent) && validplayer(ent)) {
      player = ent;
      player playerupdatebesttimehud(location);
    }
  }
}

playerupdatebesttimehud(location) {
  if(istrue(level.brgametype.useserverhud)) {
    if(isDefined(location.bestplayer)) {
      self.hudkothbesttimelabel.label = &"MP_BR_INGAME/ATTRACT_KOTH_BEST_PLAYER";
      self.hudkothbesttimelabel setplayernamestring(location.bestplayer);
    } else
      self.hudkothbesttimelabel.label = &"MP_BR_INGAME/ATTRACT_KOTH_BEST";

    time = max(location.besttime / 1000.0, 0.001);

    if(location.besttimestate == 0)
      self.hudkothbesttime settenthstimerstatic(time);
    else
      self.hudkothbesttime settenthstimerup(time);
  }

  playerupdatehudstate(location);
}

playerstartbesttimetracking(location) {
  self endon("disconnect");
  self notify("playerStartBestTimeTracking");
  self endon("playerStartBestTimeTracking");
  location endon("stopTimeTracking");
  time = location.besttime / 1000.0;
  _id_5FD2522E101604A5 = playergettotaltime();
  time = time - _id_5FD2522E101604A5 / 1000.0;

  if(time > 0)
    wait(time);

  while(location.besttimestate == 1)
    waitframe();

  location.besttimestate = 1;
  _id_5FD2522E101604A5 = playergettotaltime();
  updatelocationbesttime(location, _id_5FD2522E101604A5, self);
  updatelocationbesttimehud(location);
}

playerupdatehudstate(location) {
  state = 0;
  _id_5FD2522E101604A5 = playergettotaltime();
  _id_F63C334678A03505 = !isDefined(self.kothtotaltime);

  if(_id_F63C334678A03505) {
    if(!isDefined(location.besttime) || location.besttime == 0)
      state = 0;
    else if(location.besttimestate == 1)
      state = 3;
    else if(isDefined(location.bestplayer))
      state = 2;
    else
      state = 1;
  } else if(istrue(location.contested))
    state = 4;
  else if(!isDefined(location.bestplayer))
    state = 5;
  else if(!isbestplayertime(location, _id_5FD2522E101604A5, self))
    state = 6;
  else
    state = 7;

  _id_6731BE38C3B94FF7::playersetattractionstateindex(state);
  _id_6731BE38C3B94FF7::playersetattractiontime(_id_5FD2522E101604A5);
  _id_6731BE38C3B94FF7::playersetattractionbestplayer(location.bestplayer);

  if(state == 7 || state == 3)
    thread playerstartbesttimeupdate(location);
  else
    _id_6731BE38C3B94FF7::playersetattractionbesttime(location.besttime);
}

playerstartbesttimeupdate(location) {
  self endon("disconnect");
  self notify("playerStartBestTimeUpdate");
  self endon("playerStartBestTimeUpdate");
  location endon("stopTimeTracking");

  while(isDefined(location.bestplayer)) {
    _id_8EF5A089A5B9CBF3 = location.bestplayer playergettotaltime();
    _id_6731BE38C3B94FF7::playersetattractionbesttime(_id_8EF5A089A5B9CBF3);
    waitframe();
  }
}