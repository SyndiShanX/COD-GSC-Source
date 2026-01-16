/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_utils.gsc
*****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\gametypes\hud_message;
#include scripts\mp_common\gametypes\round;

#namespace globallogic_utils;

is_winner(outcome, team_or_player) {
  if(isplayer(team_or_player)) {
    if(outcome.players.size && outcome.players[0] == team_or_player) {
      return true;
    }

    if(isDefined(outcome.team) && outcome.team == team_or_player.team) {
      return true;
    }
  } else if(isDefined(outcome.team) && outcome.team == team_or_player) {
    return true;
  }

  return false;
}

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

    if(self thread killstreaks::give(hp)) {
      self playlocalsound(level.killstreaks[hp].informdialog);
    }

    wait 20;
  }
}

timeuntilroundend() {
  if(level.gameended) {
    timepassed = float(gettime() - level.gameendtime) / 1000;
    timeremaining = level.roundenddelay[3] - timepassed;

    if(timeremaining < 0) {
      return 0;
    }

    return timeremaining;
  }

  if(level.timelimit <= 0) {
    return undefined;
  }

  if(!isDefined(level.starttime)) {
    return undefined;
  }

  timepassed = float(gettimepassed() - level.starttime) / 1000;
  timeremaining = level.timelimit * 60 - timepassed;
  return timeremaining + level.roundenddelay[3];
}

gettimeremaining() {
  return level.timelimit * int(60 * 1000) - gettimepassed();
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

  if(level.teambased) {
    for(i = 0; i < numplayers - 1; i++) {
      if(level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
        println("<dev string:x38>");

        for(j = 0; j < numplayers; j++) {
          player = level.placement[#"all"][j];
          println("<dev string:x4d>" + j + "<dev string:x52>" + player.name + "<dev string:x57>" + player.score);
        }

        assertmsg("<dev string:x5c>");
        break;
      }
    }

    return;
  }

  for(i = 0; i < numplayers - 1; i++) {
    if(level.placement[#"all"][i].pointstowin < level.placement[#"all"][i + 1].pointstowin) {
      println("<dev string:x38>");

      for(j = 0; j < numplayers; j++) {
        player = level.placement[#"all"][j];
        println("<dev string:x4d>" + j + "<dev string:x52>" + player.name + "<dev string:x57>" + player.pointstowin);
      }

      assertmsg("<dev string:x5c>");
      break;
    }
  }
}

  function isvalidclass(c) {
    return isDefined(c) && c != "";
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
  if(isDefined(self)) {
    self notify(#"stop_ticking");
  }
}

gametimer() {
  level endon(#"game_ended");
  level.var_8a3a9ca4.roundstart = gettime();
  level.starttime = gettime();
  level.discardtime = 0;

  if(isDefined(game.roundmillisecondsalreadypassed)) {
    level.starttime -= game.roundmillisecondsalreadypassed;
    game.roundmillisecondsalreadypassed = undefined;
  }

  prevtime = gettime() - 1000;

  while(game.state == "playing") {
    if(!level.timerstopped) {
      game.timepassed += gettime() - prevtime;
    }

    if(!level.playabletimerstopped) {
      game.playabletimepassed += gettime() - prevtime;
    }

    prevtime = gettime();
    wait 1;
  }
}

disableplayerroundstartdelay() {
  player = self;
  player endon(#"death", #"disconnect");

  if(getroundstartdelay()) {
    wait getroundstartdelay();
  }

  player disableroundstartdelay();
}

getroundstartdelay() {
  waittime = level.roundstartexplosivedelay - float([[level.gettimepassed]]()) / 1000;

  if(waittime > 0) {
    return waittime;
  }

  return 0;
}

applyroundstartdelay() {
  self endon(#"disconnect", #"joined_spectators", #"death");

  if(game.state == "pregame") {
    level waittill(#"game_playing");
  } else {
    waitframe(1);
  }

  self enableroundstartdelay();
  self thread disableplayerroundstartdelay();
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

pausetimer(pauseplayabletimer = 0) {
  level.playabletimerstopped = pauseplayabletimer;

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
  level.playabletimerstopped = 0;
  level.discardtime += gettime() - level.timerpausetime;
}

resumetimerdiscardoverride(discardtime) {
  if(!level.timerstopped) {
    return;
  }

  level.timerstopped = 0;
  level.discardtime = discardtime;
}

getscoreremaining(team) {
  assert(isplayer(self) || isDefined(team));
  scorelimit = level.scorelimit;

  if(isplayer(self)) {
    return (scorelimit - globallogic_score::_getplayerscore(self));
  }

  return scorelimit - getteamscore(team);
}

getteamscoreforround(team) {
  if(level.cumulativeroundscores && isDefined(game.lastroundscore[team])) {
    return (getteamscore(team) - game.lastroundscore[team]);
  }

  return getteamscore(team);
}

getscoreperminute(team) {
  assert(isplayer(self) || isDefined(team));
  minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;

  if(isplayer(self)) {
    return (globallogic_score::_getplayerscore(self) / minutespassed);
  }

  return getteamscoreforround(team) / minutespassed;
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
    case #"mod_melee_assassinate":
    case #"mod_melee":
      return false;
    case #"mod_impact":
      baseweapon = weapons::getbaseweapon(weapon);

      if(!weapon.isballisticknife && baseweapon != level.weaponspecialcrossbow && baseweapon != level.weaponflechette) {
        return false;
      }

      break;
  }

  if(killstreaks::is_killstreak_weapon(weapon)) {
    if(!isDefined(einflictor) || !isDefined(einflictor.controlled) || einflictor.controlled == 0) {
      return false;
    }
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
    if(!isarray(entitylist)) {
      return (entity == entitylist);
    }

    for(index = 0; index < entitylist.size; index++) {
      if(entity == entitylist[index]) {
        return true;
      }
    }

    return false;
  }

function_4aa8d809(index, string) {
  level.var_336c35f1[index] = string;
}

function_8d61a6c2(var_c1e98979) {
  assert(isDefined(var_c1e98979));
  assert(isDefined(level.var_336c35f1[var_c1e98979]));
  log_string = level.var_336c35f1[var_c1e98979];
  winner = round::get_winner();

  if(isplayer(winner)) {
    print("<dev string:x86>" + winner getxuid() + "<dev string:x97>" + winner.name + "<dev string:x9b>");
  }

  if(isDefined(winner)) {
    if(isplayer(winner)) {
      log_string = log_string + "<dev string:x9f>" + winner getxuid() + "<dev string:x97>" + winner.name + "<dev string:x9b>";
    } else {
      log_string = log_string + "<dev string:x9f>" + winner;
    }
  }

  foreach(team, str_team in level.teams) {
    log_string = log_string + "<dev string:xa9>" + str_team + "<dev string:x57>" + game.stat[#"teamscores"][team];
  }

  print(log_string);
}

  function add_map_error(msg) {
    if(!isDefined(level.maperrors)) {
      level.maperrors = [];
    }

    level.maperrors[level.maperrors.size] = msg;
  }

print_map_errors() {
  if(isDefined(level.maperrors) && level.maperrors.size > 0) {

    println("<dev string:xae>");

    for(i = 0; i < level.maperrors.size; i++) {
      println("<dev string:xd7>" + level.maperrors[i]);
    }

    println("<dev string:xe1>");
    util::error("<dev string:x10a>");

      callback::abort_level();
    return true;
  }

  return false;
}

function_308e3379() {
  return strendswith(level.gametype, "_bb");
}