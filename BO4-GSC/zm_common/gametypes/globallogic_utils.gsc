/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_utils.gsc
*****************************************************/

#include scripts\core_common\hud_message_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\gametypes\globallogic_score;
#include scripts\zm_common\gametypes\hostmigration;

#namespace globallogic_utils;

testshock() {
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

testhps() {
  self endon(#"death", #"disconnect");
  hps = [];
  hps[hps.size] = "radar";
  hps[hps.size] = "artillery";
  hps[hps.size] = "dogs";

  for(;;) {
    hp = "radar";
    wait 20;
  }
}

timeuntilroundend() {
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
  timeremaining = level.timelimit * 60 - timepassed;
  return timeremaining + level.postroundtime;
}

gettimeremaining() {
  return level.timelimit * 60 * 1000 - gettimepassed();
}

registerpostroundevent(eventfunc) {
  if(!isDefined(level.postroundevents)) {
    level.postroundevents = [];
  }

  level.postroundevents[level.postroundevents.size] = eventfunc;
}

executepostroundevents() {
  if(!isDefined(level.postroundevents)) {
    return;
  }

  for(i = 0; i < level.postroundevents.size; i++) {
    [[level.postroundevents[i]]]();
  }
}

getvalueinrange(value, minvalue, maxvalue) {
  if(value > maxvalue) {
    return maxvalue;
  }

  if(value < minvalue) {
    return minvalue;
  }

  return value;
}

assertproperplacement() {
  numplayers = level.placement[#"all"].size;

  for(i = 0; i < numplayers - 1; i++) {
    if(isDefined(level.placement[#"all"][i]) && isDefined(level.placement[#"all"][i + 1])) {
      if(level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
        println("<dev string:x38>");

        for(i = 0; i < numplayers; i++) {
          player = level.placement[#"all"][i];
          println("<dev string:x4d>" + i + "<dev string:x52>" + player.name + "<dev string:x57>" + player.score);
        }

        assertmsg("<dev string:x5c>");
        break;
      }
    }
  }
}

  function isvalidclass(vclass) {
    if(level.oldschool || sessionmodeiszombiesgame()) {
      assert(!isDefined(vclass));
      return true;
    }

    return isDefined(vclass) && vclass != "";
  }

playtickingsound(gametype_tick_sound) {
  self endon(#"death", #"stop_ticking");
  level endon(#"game_ended");
  time = level.bombtimer;

  while(true) {
    self playSound(gametype_tick_sound);

    if(time > 10) {
      time -= 1;
      wait 1;
    } else if(time > 4) {
      time -= 0.5;
      wait 0.5;
    } else if(time > 1) {
      time -= 0.4;
      wait 0.4;
    } else {
      time -= 0.3;
      wait 0.3;
    }

    hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify(#"stop_ticking");
}

gametimer() {
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

gettimepassed() {
  if(!isDefined(level.starttime)) {
    return 0;
  }

  if(level.timerstopped) {
    return (level.timerpausetime - level.starttime - level.discardtime);
  }

  return gettime() - level.starttime - level.discardtime;
}

pausetimer() {
  if(level.timerstopped) {
    return;
  }

  level.timerstopped = 1;
  level.timerpausetime = gettime();
}

resumetimer() {
  if(!level.timerstopped) {
    return;
  }

  level.timerstopped = 0;
  level.discardtime += gettime() - level.timerpausetime;
}

getscoreremaining(team) {
  assert(isplayer(self) || isDefined(team));
  scorelimit = level.scorelimit;

  if(isplayer(self)) {
    return (scorelimit - globallogic_score::_getplayerscore(self));
  }

  return scorelimit - getteamscore(team);
}

getscoreperminute(team) {
  assert(isplayer(self) || isDefined(team));
  scorelimit = level.scorelimit;
  timelimit = level.timelimit;
  minutespassed = gettimepassed() / 60000 + 0.0001;

  if(isplayer(self)) {
    return (globallogic_score::_getplayerscore(self) / minutespassed);
  }

  return getteamscore(team) / minutespassed;
}

getestimatedtimeuntilscorelimit(team) {
  assert(isplayer(self) || isDefined(team));
  scoreperminute = self getscoreperminute(team);
  scoreremaining = self getscoreremaining(team);

  if(!scoreperminute) {
    return 999999;
  }

  return scoreremaining / scoreperminute;
}

rumbler() {
  self endon(#"disconnect");

  while(true) {
    wait 0.1;
    self playrumbleonentity("damage_heavy");
  }
}

waitfortimeornotify(time, notifyname) {
  self endon(notifyname);
  wait time;
}

waitfortimeornotifynoartillery(time, notifyname) {
  self endon(notifyname);
  wait time;

  while(isDefined(level.artilleryinprogress)) {
    assert(level.artilleryinprogress);
    wait 0.25;
  }
}

isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
  if(shitloc != "head" && shitloc != "helmet") {
    return false;
  }

  switch (smeansofdeath) {
    case #"mod_impact":
    case #"mod_melee":
      return false;
  }

  return true;
}

gethitlocheight(shitloc) {
  switch (shitloc) {
    case #"head":
    case #"helmet":
    case #"neck":
      return 60;
    case #"left_arm_lower":
    case #"left_arm_upper":
    case #"torso_upper":
    case #"right_arm_lower":
    case #"left_hand":
    case #"right_arm_upper":
    case #"gun":
    case #"right_hand":
      return 48;
    case #"torso_lower":
      return 40;
    case #"right_leg_upper":
    case #"left_leg_upper":
      return 32;
    case #"left_leg_lower":
    case #"right_leg_lower":
      return 10;
    case #"left_foot":
    case #"right_foot":
      return 5;
  }

  return 48;
}

debugline(start, end) {
  for(i = 0; i < 50; i++) {
    line(start, end);
    waitframe(1);
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

logteamwinstring(wintype, winner) {
  log_string = wintype;

  if(isDefined(winner)) {
    log_string = log_string + "<dev string:x86>" + winner;
  }

  foreach(team, str_team in level.teams) {
    log_string = log_string + "<dev string:x90>" + str_team + "<dev string:x57>" + game.stat[#"teamscores"][team];
  }

  print(log_string);
}

