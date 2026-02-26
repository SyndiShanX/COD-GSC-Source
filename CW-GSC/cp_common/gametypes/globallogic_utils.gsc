/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_utils.gsc
*****************************************************/

#using script_7f6cd71c43c45c57;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\weapons_shared;
#namespace globallogic_utils;

function testshock() {
  self endon(#"death", #"disconnect");

  for(;;) {
    wait 3;
    numshots = randomint(6);

    for(i = 0; i < numshots; i++) {
      iprintlnbold(numshots);
      self shellshock(#"frag_grenade_mp", 0.2);
      wait 0.1;
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

  timepassed = float(gettimepassed() - level.starttime) / 1000;
  timeremaining = level.timelimit * 60 - timepassed;
  return timeremaining + level.postroundtime;
}

function gettimeremaining() {
  if(level.timelimit == 0) {
    return undefined;
  }

  return level.timelimit * 60 * 1000 - gettimepassed();
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
  numplayers = level.placement[#"all"].size;

  if(level.teambased) {
    for(i = 0; i < numplayers - 1; i++) {
      if(level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
        println("<dev string:x38>");

        for(i = 0; i < numplayers; i++) {
          player = level.placement[#"all"][i];
          println("<dev string:x4e>" + i + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.score);
        }

        assertmsg("<dev string:x60>");
        break;
      }
    }

    return;
  }

  for(i = 0; i < numplayers - 1; i++) {
    if(level.placement[#"all"][i].pointstowin < level.placement[#"all"][i + 1].pointstowin) {
      println("<dev string:x38>");

      for(i = 0; i < numplayers; i++) {
        player = level.placement[#"all"][i];
        println("<dev string:x4e>" + i + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.pointstowin);
      }

      assertmsg("<dev string:x60>");
      break;
    }
  }
}

function isvalidclass(c) {
  if(level.oldschool || sessionmodeiszombiesgame()) {
    assert(!isDefined(c));
    return true;
  }

  return isDefined(c) && c != "";
}

function playtickingsound(gametype_tick_sound) {
  self endon(#"death", #"stop_ticking");
  level endon(#"game_ended");
  time = level.bombtimer;

  while(true) {
    self playSound(gametype_tick_sound);

    if(time > 10) {
      time -= 1;
      wait 1;
      continue;
    }

    if(time > 4) {
      time -= 0.5;
      wait 0.5;
      continue;
    }

    if(time > 1) {
      time -= 0.4;
      wait 0.4;
      continue;
    }

    time -= 0.3;
    wait 0.3;
  }
}

function stoptickingsound() {
  self notify(#"stop_ticking");
}

function gametimer() {
  level endon(#"game_ended");
  level waittill(#"prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;

  if(isDefined(game.roundmillisecondsalreadypassed)) {
    level.starttime -= game.roundmillisecondsalreadypassed;
    game.roundmillisecondsalreadypassed = undefined;
  }

  prevtime = gettime();

  while(game.state == "playing") {
    if(!level.timerstopped) {
      game.timepassed += gettime() - prevtime;
    }

    prevtime = gettime();
    wait 1;
  }
}

function gettimepassed() {
  if(!isDefined(level.starttime)) {
    return 0;
  }

  if(level.timerstopped) {
    return (level.timerpausetime - level.starttime - level.discardtime);
  }

  return gettime() - level.starttime - level.discardtime;
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
  level.discardtime += gettime() - level.timerpausetime;
}

function getscoreremaining(team) {
  return level.scorelimit;
}

function getteamscoreforround(team) {
  return false;
}

function getscoreperminute(team) {
  return false;
}

function getestimatedtimeuntilscorelimit(team) {
  assert(isPlayer(self) || isDefined(team));
  scoreperminute = self getscoreperminute(team);
  scoreremaining = self getscoreremaining(team);

  if(!scoreperminute) {
    return 999999;
  }

  return scoreremaining / scoreperminute;
}

function rumbler() {
  self endon(#"disconnect");

  while(true) {
    wait 0.1;
    self playrumbleonentity("damage_heavy");
  }
}

function waitfortimeornotify(time, notifyname) {
  self endon(notifyname);
  wait time;
}

function waitfortimeornotifynoartillery(time, notifyname) {
  self endon(notifyname);
  wait time;

  while(isDefined(level.artilleryinprogress)) {
    assert(level.artilleryinprogress);
    wait 0.25;
  }
}

function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
  if(smeansofdeath != "head" && smeansofdeath != "helmet") {
    return false;
  }

  switch (einflictor) {
    case # "mod_melee_weapon_butt":
    case # "mod_melee_assassinate":
    case # "mod_melee":
      return false;
    case # "mod_impact":
      baseweapon = weapons::getbaseweapon(shitloc);

      if(!shitloc.isballisticknife && baseweapon != level.weaponspecialcrossbow && baseweapon != level.weaponflechette) {
        return false;
      }

      break;
  }

  return true;
}

function gethitlocheight(shitloc) {
  switch (shitloc) {
    case # "head":
    case # "helmet":
    case # "neck":
      return 60;
    case # "left_arm_lower":
    case # "left_arm_upper":
    case # "torso_upper":
    case # "right_arm_lower":
    case # "left_hand":
    case # "right_arm_upper":
    case # "gun":
    case # "right_hand":
      return 48;
    case # "torso_lower":
      return 40;
    case # "right_leg_upper":
    case # "left_leg_upper":
      return 32;
    case # "left_leg_lower":
    case # "right_leg_lower":
      return 10;
    case # "left_foot":
    case # "right_foot":
      return 5;
  }

  return 48;
}

function debugline(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    waitframe(1);
  }
}

function logteamwinstring(wintype, winner) {
  log_string = wintype;

  if(isDefined(winner)) {
    log_string = log_string + ", win: " + winner;
  }

  foreach(team, str_team in level.teams) {
    log_string = log_string + ", " + str_team + ": " + game.stat[#"teamscores"][team];
  }

  print(log_string);
}