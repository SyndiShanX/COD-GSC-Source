/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_globallogic_utils.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_message_shared;
#namespace globallogic_utils;

function testmenu() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    wait(10);
    notifydata = spawnStruct();
    notifydata.titletext = &"MP_CHALLENGE_COMPLETED";
    notifydata.notifytext = "wheee";
    notifydata.sound = "mp_challenge_complete";
    self thread hud_message::notifymessage(notifydata);
  }
}

function testshock() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    wait(3);
    numshots = randomint(6);
    for(i = 0; i < numshots; i++) {
      iprintlnbold(numshots);
      self shellshock("frag_grenade_mp", 0.2);
      wait(0.1);
    }
  }
}

function timeuntilroundend() {
  if(level.gameended) {
    timepassed = (gettime() - level.gameendtime) / 1000;
    timeremaining = level.postroundtime - timepassed;
    if(timeremaining < 0) {
      return 0;
    }
    return timeremaining;
  }
  if(level.inovertime) {
    return undefined;
  }
  if(level.timelimit <= 0) {
    return undefined;
  }
  if(!isDefined(level.starttime)) {
    return undefined;
  }
  timepassed = (gettimepassed() - level.starttime) / 1000;
  timeremaining = (level.timelimit * 60) - timepassed;
  return timeremaining + level.postroundtime;
}

function gettimeremaining() {
  if(level.timelimit == 0) {
    return undefined;
  }
  return ((level.timelimit * 60) * 1000) - gettimepassed();
}

function registerpostroundevent(eventfunc) {
  if(!isDefined(level.postroundevents)) {
    level.postroundevents = [];
  }
  level.postroundevents[level.postroundevents.size] = eventfunc;
}

function executepostroundevents() {
  if(!isDefined(level.postroundevents)) {
    return;
  }
  for(i = 0; i < level.postroundevents.size; i++) {
    [[level.postroundevents[i]]]();
  }
}

function getvalueinrange(value, minvalue, maxvalue) {
  if(value > maxvalue) {
    return maxvalue;
  }
  if(value < minvalue) {
    return minvalue;
  }
  return value;
}

function assertproperplacement() {
  numplayers = level.placement[""].size;
  if(level.teambased) {
    for(i = 0; i < (numplayers - 1); i++) {
      if(level.placement[""][i].score < (level.placement[""][i + 1].score)) {
        println("");
        for(i = 0; i < numplayers; i++) {
          player = level.placement[""][i];
          println((((("" + i) + "") + player.name) + "") + player.score);
        }
        assertmsg("");
        break;
      }
    }
  } else {
    for(i = 0; i < (numplayers - 1); i++) {
      if(level.placement[""][i].pointstowin < (level.placement[""][i + 1].pointstowin)) {
        println("");
        for(i = 0; i < numplayers; i++) {
          player = level.placement[""][i];
          println((((("" + i) + "") + player.name) + "") + player.pointstowin);
        }
        assertmsg("");
        break;
      }
    }
  }
}

function isvalidclass(c) {
  if(level.oldschool || sessionmodeiszombiesgame()) {
    assert(!isDefined(c));
    return 1;
  }
  return isDefined(c) && c != "";
}

function playtickingsound(gametype_tick_sound) {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  time = level.bombtimer;
  while(true) {
    self playSound(gametype_tick_sound);
    if(time > 10) {
      time = time - 1;
      wait(1);
    } else {
      if(time > 4) {
        time = time - 0.5;
        wait(0.5);
      } else {
        if(time > 1) {
          time = time - 0.4;
          wait(0.4);
        } else {
          time = time - 0.3;
          wait(0.3);
        }
      }
    }
    hostmigration::waittillhostmigrationdone();
  }
}

function stoptickingsound() {
  self notify("stop_ticking");
}

function gametimer() {
  level endon("game_ended");
  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }
  prevtime = gettime();
  while(game["state"] == "playing") {
    if(!level.timerstopped) {
      game["timepassed"] = game["timepassed"] + (gettime() - prevtime);
    }
    prevtime = gettime();
    wait(1);
  }
}

function gettimepassed() {
  if(!isDefined(level.starttime)) {
    return 0;
  }
  if(level.timerstopped) {
    return (level.timerpausetime - level.starttime) - level.discardtime;
  }
  return (gettime() - level.starttime) - level.discardtime;
}

function pausetimer() {
  if(level.timerstopped) {
    return;
  }
  level.timerstopped = 1;
  level.timerpausetime = gettime();
}

function resumetimer() {
  if(!level.timerstopped) {
    return;
  }
  level.timerstopped = 0;
  level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
}

function getscoreremaining(team) {
  assert(isplayer(self) || isDefined(team));
  scorelimit = level.scorelimit;
  if(isplayer(self)) {
    return scorelimit - globallogic_score::_getplayerscore(self);
  }
  return scorelimit - getteamscore(team);
}

function getteamscoreforround(team) {
  if(level.cumulativeroundscores && isDefined(game["lastroundscore"][team])) {
    return getteamscore(team) - game["lastroundscore"][team];
  }
  return getteamscore(team);
}

function getscoreperminute(team) {
  assert(isplayer(self) || isDefined(team));
  scorelimit = level.scorelimit;
  timelimit = level.timelimit;
  minutespassed = (gettimepassed() / 60000) + 0.0001;
  if(isplayer(self)) {
    return globallogic_score::_getplayerscore(self) / minutespassed;
  }
  return getteamscoreforround(team) / minutespassed;
}

function getestimatedtimeuntilscorelimit(team) {
  assert(isplayer(self) || isDefined(team));
  scoreperminute = self getscoreperminute(team);
  scoreremaining = self getscoreremaining(team);
  if(!scoreperminute) {
    return 999999;
  }
  return scoreremaining / scoreperminute;
}

function rumbler() {
  self endon("disconnect");
  while(true) {
    wait(0.1);
    self playrumbleonentity("damage_heavy");
  }
}

function waitfortimeornotify(time, notifyname) {
  self endon(notifyname);
  wait(time);
}

function waitfortimeornotifynoartillery(time, notifyname) {
  self endon(notifyname);
  wait(time);
  while(isDefined(level.artilleryinprogress)) {
    assert(level.artilleryinprogress);
    wait(0.25);
  }
}

function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
  if(shitloc != "head" && shitloc != "helmet") {
    return false;
  }
  switch (smeansofdeath) {
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
    case "MOD_MELEE_WEAPON_BUTT": {
      return false;
    }
    case "MOD_IMPACT": {
      if(weapon != level.weaponballisticknife) {
        return false;
      }
    }
  }
  return true;
}

function gethitlocheight(shitloc) {
  switch (shitloc) {
    case "head":
    case "helmet":
    case "neck": {
      return 60;
    }
    case "gun":
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_hand":
    case "right_arm_lower":
    case "right_arm_upper":
    case "right_hand":
    case "torso_upper": {
      return 48;
    }
    case "torso_lower": {
      return 40;
    }
    case "left_leg_upper":
    case "right_leg_upper": {
      return 32;
    }
    case "left_leg_lower":
    case "right_leg_lower": {
      return 10;
    }
    case "left_foot":
    case "right_foot": {
      return 5;
    }
  }
  return 48;
}

function debugline(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    wait(0.05);
  }
}

function isexcluded(entity, entitylist) {
  for(index = 0; index < entitylist.size; index++) {
    if(entity == entitylist[index]) {
      return true;
    }
  }
  return false;
}

function waitfortimeornotifies(desireddelay) {
  startedwaiting = gettime();
  waitedtime = (gettime() - startedwaiting) / 1000;
  if(waitedtime < desireddelay) {
    wait(desireddelay - waitedtime);
    return desireddelay;
  }
  return waitedtime;
}

function logteamwinstring(wintype, winner) {
  log_string = wintype;
  if(isDefined(winner)) {
    log_string = (log_string + ", win: ") + winner;
  }
  foreach(team in level.teams) {
    log_string = (((log_string + ", ") + team) + ": ") + game["teamScores"][team];
  }
  print(log_string);
}