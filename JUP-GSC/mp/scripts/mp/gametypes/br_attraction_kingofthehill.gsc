/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_attraction_kingofthehill.gsc
*******************************************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_attractions;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;
#namespace br_attraction_kingofthehill;

function init() {
  level.brattractions["koth"] = spawnStruct();
  level.brattractions["koth"].locations = [];
  registerlocations();
}

function registerlocations() {
  switch (level.script) {
    case #"hash_c9458e4403b73c27":
    case #"hash_d7b993f67c508b1d":
    case #"hash_e9af1c05b2cb1afd":
      registerlocation((21616, -16071, 1910), 730, 204, 2000, 2151);
      registerlocation((15884, 18421, 846), 500, 108, 3000, 720);
      registerlocation((-1111, -18991, 932), 800, 188, 2000, 1162);
      registerlocation((8223, -25884, 696), 1185, 188, 2000, 982);
      registerlocation((-16115, -25460, 55), 750, 340, 2000, 266);
      registerlocation((16734, -34808, 842), 457, 108, 2000, 768);
      break;
    case #"hash_4aa5d6e97851bdbd":
      registerlocation((117, -1854, 0), 300, 60, 800, 0);
      registerlocation((-3896, -2143, 335), 500, 334, 2000, 335);
    default:
      break;
  }
}

function registerlocation(origin, captureradius, captureheight, var_ccb00530d7a24ee3, groundoffsetz) {
  var_f98843815888ea41 = 30;
  nextindex = level.brattractions["koth"].locations.size;
  level.brattractions["koth"].locations[nextindex] = spawnStruct();
  location = level.brattractions["koth"].locations[nextindex];
  location.capturetrigger = spawn("trigger_radius", origin, 0, captureradius, captureheight);
  location.capturetrigger.radius = captureradius;
  location.capturetrigger.players = [];
  scripts\mp\utility\trigger::makeenterexittrigger(location.capturetrigger, &playerlocationtriggerenter, &playerlocationtriggerexit);
  trigorigin = origin + (0, 0, -1 * groundoffsetz);
  iconzoffset = groundoffsetz + var_f98843815888ea41;
  location.icontrigger = scripts\mp\gametypes\br_attractions::createattractionicontrigger("koth", 0, trigorigin, iconzoffset, "ui_mp_br_mapmenu_icon_poi_sb_koh", var_ccb00530d7a24ee3, &playerattractiontriggerenter, &playerattractiontriggerexit, "br_attraction_koth");
  location.capturetrigger.objectiveiconid = location.icontrigger.closeobjectiveiconid;
  location.icontrigger scripts\mp\gametypes\br_attractions::triggeraddobjectivetext(&"MP_BR_INGAME/ATTRACT_KOTH_CAPTURE");
  location.icontrigger.location = location;
  location.capturetrigger.location = location;
  location.besttime = 0;
  location.bestplayer = undefined;
  location.besttimestate = 0;
  location.contested = 0;
}

function getkothlocations() {
  return level.brattractions["koth"].locations;
}

function playerlocationtriggerenter(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  player endon("disconnect");
  player endon("playerLocationTriggerExit");
  player notify("playerLocationTriggerEnter");
  player endon("playerLocationTriggerEnter");
  waittillplayerlanded(player);

  if(istrue(level.brgametype.useserverhud)) {
    if(!isDefined(player.hudkothtimer)) {
      player.hudkothtimer = scripts\mp\gametypes\br_attractions::createhudtimer(1);
    } else {
      player notify("keepHudKothTimer");
      player.hudkothtimer.alpha = 1;
      player.hudkothtimer.color = (1, 1, 1);
    }
  }

  player.kothtotaltime = 0;
  player.kothlaststarttime = -1;

  if(istrue(level.brgametype.useserverhud)) {
    time = max(self.kothtotaltime / 1000, 0.001);
    player.hudkothtimer settenthstimerstatic(time);
  }

  trigger.players[trigger.players.size] = player;
  trigger locationtriggerupdate();
}

function playerlocationtriggerexit(player, trigger) {
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

  if(isbestplayertime(location, player.kothtotaltime, player)) {
    location.besttimestate = 0;
  }

  player.kothtotaltime = undefined;
  player.kothlaststarttime = undefined;
  trigger.players = array_remove(trigger.players, player);
  trigger locationtriggerupdate();
  updatelocationbesttimehud(location);

  if(istrue(level.brgametype.useserverhud)) {
    player thread playerstoptimerdelete();
  }
}

function waittillplayerlanded(player) {
  while(!player isonground()) {
    waitframe();
  }
}

function playerstoptimerdelete() {
  self endon("keepHudKothTimer");
  var_c01f079eb027d3bc = 1.5;
  var_b2d4b76e9bbd89ed = 2;
  timer = self.hudkothtimer;
  timer.color = (1, 1, 0);
  wait var_c01f079eb027d3bc;
  timer fadeovertime(var_b2d4b76e9bbd89ed);
  timer.alpha = 0;
  wait var_b2d4b76e9bbd89ed;

  if(isDefined(timer)) {
    timer destroy();
  }

  if(isDefined(self)) {
    self.hudkothtimer = undefined;
  }
}

function validplayer(player) {
  return isDefined(player) && isalive(player) && !istrue(player.disconnecting);
}

function locationtriggerupdate() {
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

function locationtriggersetpaused(ispaused) {
  location = self.location;
  location.besttimestate = 0;
  location notify("stopTimeTracking");

  foreach(player in self.players) {
    if(!validplayer(player)) {
      continue;
    }

    if(ispaused) {
      player playertimestamp();
      updatelocationbesttime(location, player.kothtotaltime, player);
    } else {
      player playertimestart(location);
    }

    player playerupdatehudstate(location);
  }

  if(ispaused) {
    location notify("zone_reset");
  } else {
    thread awardcapturepoints(location, self);
  }

  if(location.besttimestate == 0) {
    updatelocationbesttimehud(location);
  }
}

function awardcapturepoints(location, trigger) {
  level endon("game_ended");
  level endon("zone_reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  seconds = 1;

  while(!level.gameended) {
    for(waittime = 0; waittime < seconds && !level.gameended; waittime = 0) {
      wait level.framedurationseconds;
      waittime += level.framedurationseconds;

      if(istrue(location.contested)) {}
    }

    if(level.gameended) {
      break;
    }

    if(!istrue(location.contested) && !level.gameended) {
      foreach(player in trigger.players) {
        if(!isPlayer(player)) {
          continue;
        }

        player scripts\mp\utility\points::doscoreevent(#"hash_32eed765ef0d59f6");
      }
    }
  }
}

function playertimestart(location) {
  if(self.kothlaststarttime == -1) {
    self.kothlaststarttime = gettime();
    time = max(self.kothtotaltime / 1000, 0.001);

    if(istrue(level.brgametype.useserverhud)) {
      self.hudkothtimer settenthstimerup(time);
    }
  }

  thread playerstarttimetracking(location);
  thread playerstartbesttimetracking(location);
}

function playerstarttimetracking(location) {
  self endon("disconnect");
  self notify("playerStartTimeTracking");
  self endon("playerStartTimeTracking");
  location endon("stopTimeTracking");

  while(true) {
    var_5fd2522e101604a5 = playergettotaltime();
    scripts\mp\gametypes\br_attractions::playersetattractiontime(var_5fd2522e101604a5);
    waitframe();
  }
}

function playertimestamp() {
  if(self.kothlaststarttime > 0) {
    self.kothtotaltime = playergettotaltime();
    self.kothlaststarttime = -1;
    time = max(self.kothtotaltime / 1000, 0.001);

    if(istrue(level.brgametype.useserverhud)) {
      self.hudkothtimer settenthstimerstatic(time);
    }
  }
}

function playergettotaltime() {
  totaltime = 0;

  if(isDefined(self.kothtotaltime)) {
    totaltime = self.kothtotaltime;
  }

  if(isDefined(self.kothlaststarttime) && self.kothlaststarttime > 0) {
    totaltime += gettime() - self.kothlaststarttime;
  }

  return totaltime;
}

function onplayerdisconnect(player) {
  if(isDefined(player) && isDefined(player.hudkothtimer)) {
    player.hudkothtimer destroy();
  }

  foreach(location in level.brattractions["koth"].locations) {
    if(isDefined(player)) {
      location.capturetrigger.players = array_remove(location.capturetrigger.players, player);
    } else {
      location.capturetrigger.players = array_removeundefined(location.capturetrigger.players);
    }

    location.capturetrigger locationtriggerupdate();
  }
}

function playerattractiontriggerenter(player, trigger) {
  player.hudkothbesttime = scripts\mp\gametypes\br_attractions::createhudtimer(3);
  player.hudkothbesttimelabel = scripts\mp\gametypes\br_attractions::createhudstring(2);
  trigger.location.capturetrigger locationtriggerupdate();
  player playerupdatebesttimehud(trigger.location);
}

function playerattractiontriggerexit(player, trigger) {
  if(isDefined(player.hudkothbesttimelabel)) {
    player.hudkothbesttimelabel destroy();
  }

  if(isDefined(player.hudkothbesttime)) {
    player.hudkothbesttime destroy();
  }
}

function isbestplayertime(location, time, player) {
  return isDefined(location.bestplayer) && location.bestplayer == player && time == location.besttime;
}

function updatelocationbesttime(location, time, player) {
  if(isDefined(time) && time >= location.besttime) {
    location.besttime = time;
    location.bestplayer = player;
  }
}

function updatelocationbesttimehud(location) {
  foreach(ent in location.icontrigger.triggerenterents) {
    if(isDefined(ent) && isPlayer(ent) && validplayer(ent)) {
      player = ent;
      player playerupdatebesttimehud(location);
    }
  }
}

function playerupdatebesttimehud(location) {
  if(istrue(level.brgametype.useserverhud)) {
    if(isDefined(location.bestplayer)) {
      self.hudkothbesttimelabel.label = &"MP_BR_INGAME/ATTRACT_KOTH_BEST_PLAYER";
      self.hudkothbesttimelabel setplayernamestring(location.bestplayer);
    } else {
      self.hudkothbesttimelabel.label = &"MP_BR_INGAME/ATTRACT_KOTH_BEST";
    }

    time = max(location.besttime / 1000, 0.001);

    if(location.besttimestate == 0) {
      self.hudkothbesttime settenthstimerstatic(time);
    } else {
      self.hudkothbesttime settenthstimerup(time);
    }
  }

  playerupdatehudstate(location);
}

function playerstartbesttimetracking(location) {
  self endon("disconnect");
  self notify("playerStartBestTimeTracking");
  self endon("playerStartBestTimeTracking");
  location endon("stopTimeTracking");
  time = location.besttime / 1000;
  var_5fd2522e101604a5 = playergettotaltime();
  time -= var_5fd2522e101604a5 / 1000;

  if(time > 0) {
    wait time;
  }

  while(location.besttimestate == 1) {
    waitframe();
  }

  location.besttimestate = 1;
  var_5fd2522e101604a5 = playergettotaltime();
  updatelocationbesttime(location, var_5fd2522e101604a5, self);
  updatelocationbesttimehud(location);
}

function playerupdatehudstate(location) {
  state = 0;
  var_5fd2522e101604a5 = playergettotaltime();
  offsite = !isDefined(self.kothtotaltime);

  if(offsite) {
    if(!isDefined(location.besttime) || location.besttime == 0) {
      state = 0;
    } else if(location.besttimestate == 1) {
      state = 3;
    } else if(isDefined(location.bestplayer)) {
      state = 2;
    } else {
      state = 1;
    }
  } else if(istrue(location.contested)) {
    state = 4;
  } else if(!isDefined(location.bestplayer)) {
    state = 5;
  } else if(!isbestplayertime(location, var_5fd2522e101604a5, self)) {
    state = 6;
  } else {
    state = 7;
  }

  scripts\mp\gametypes\br_attractions::playersetattractionstateindex(state);
  scripts\mp\gametypes\br_attractions::playersetattractiontime(var_5fd2522e101604a5);
  scripts\mp\gametypes\br_attractions::playersetattractionbestplayer(location.bestplayer);

  if(state == 7 || state == 3) {
    thread playerstartbesttimeupdate(location);
    return;
  }

  scripts\mp\gametypes\br_attractions::playersetattractionbesttime(location.besttime);
}

function playerstartbesttimeupdate(location) {
  self endon("disconnect");
  self notify("playerStartBestTimeUpdate");
  self endon("playerStartBestTimeUpdate");
  location endon("stopTimeTracking");

  while(isDefined(location.bestplayer)) {
    var_8ef5a089a5b9cbf3 = location.bestplayer playergettotaltime();
    scripts\mp\gametypes\br_attractions::playersetattractionbesttime(var_8ef5a089a5b9cbf3);
    waitframe();
  }
}