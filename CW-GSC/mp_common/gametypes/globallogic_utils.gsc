/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_utils.gsc
*****************************************************/

#using script_7f6cd71c43c45c57;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\round;
#namespace globallogic_utils;

function is_winner(outcome, team_or_player) {
  if(isPlayer(team_or_player)) {
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

function gettimeremaining() {
  return level.timelimit * int(60 * 1000) - gettimepassed();
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

        for(j = 0; j < numplayers; j++) {
          player = level.placement[#"all"][j];
          println("<dev string:x4e>" + j + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.score);
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

      for(j = 0; j < numplayers; j++) {
        player = level.placement[#"all"][j];
        println("<dev string:x4e>" + j + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.pointstowin);
      }

      assertmsg("<dev string:x60>");
      break;
    }
  }
}

function isvalidclass(c) {
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

function stoptickingsound() {
  if(isDefined(self)) {
    self notify(#"stop_ticking");
  }
}

function gametimer() {
  level endon(#"game_ended");
  level.var_8a3a9ca4.roundstart = gettime();
  level.starttime = gettime();
  level.discardtime = 0;

  if(isDefined(game.roundmillisecondsalreadypassed)) {
    level.starttime -= game.roundmillisecondsalreadypassed;
    game.roundmillisecondsalreadypassed = undefined;
  }

  prevtime = gettime() - 1000;

  while(game.state == # "playing") {
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

function disableplayerroundstartdelay() {
  player = self;
  player endon(#"death", #"disconnect");

  if(getroundstartdelay()) {
    wait getroundstartdelay();
  }

  player disableroundstartdelay();
}

function getroundstartdelay() {
  waittime = level.roundstartexplosivedelay - float([[level.gettimepassed]]()) / 1000;

  if(waittime > 0) {
    return waittime;
  }

  return 0;
}

function applyroundstartdelay() {
  self endon(#"disconnect", #"joined_spectators", #"death");

  if(game.state == # "pregame") {
    level waittill(#"game_playing");
  } else {
    waitframe(1);
  }

  self enableroundstartdelay();
  self thread disableplayerroundstartdelay();
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

function pausetimer(pauseplayabletimer = 0) {
  level.playabletimerstopped = pauseplayabletimer;

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
  level.playabletimerstopped = 0;

  if(isDefined(level.discardtime)) {
    level.discardtime += gettime() - level.timerpausetime;
  }
}

function resumetimerdiscardoverride(discardtime) {
  if(!level.timerstopped) {
    return;
  }

  level.timerstopped = 0;
  level.discardtime = discardtime + level.var_9d348da1;
}

function getscoreremaining(score) {
  return level.scorelimit - score;
}

function function_fd90317f(user, var_b393387d) {
  if(level.cumulativeroundscores && isDefined(game.lastroundscore[user])) {
    return (var_b393387d - game.lastroundscore[user]);
  }

  return var_b393387d;
}

function getscoreperminute(var_d0266750) {
  minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;
  return var_d0266750 / minutespassed;
}

function getestimatedtimeuntilscorelimit(total_score, var_d0266750) {
  scoreperminute = self getscoreperminute(var_d0266750);
  scoreremaining = self getscoreremaining(total_score);

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

function function_4aa8d809(index, string) {
  level.var_336c35f1[index] = string;
}

function function_8d61a6c2(var_c1e98979) {
  assert(isDefined(var_c1e98979));
  assert(isDefined(level.var_336c35f1[var_c1e98979]));
  log_string = level.var_336c35f1[var_c1e98979];
  winner = round::get_winner();

  if(isPlayer(winner)) {
    print("<dev string:x8b>" + winner getxuid() + "<dev string:x9d>" + winner.name + "<dev string:xa2>");
  }

  if(isDefined(winner)) {
    if(isPlayer(winner)) {
      log_string = log_string + "<dev string:xa7>" + winner getxuid() + "<dev string:x9d>" + winner.name + "<dev string:xa2>";
    } else {
      log_string = log_string + "<dev string:xa7>" + winner;
    }
  }

  foreach(team, str_team in level.teams) {
    log_string = log_string + "<dev string:xb2>" + str_team + "<dev string:x5a>" + game.stat[#"teamscores"][team];
  }

  print(log_string);
}

function add_map_error(msg) {
  if(!isDefined(level.maperrors)) {
    level.maperrors = [];
  }

  level.maperrors[level.maperrors.size] = msg;
}

function print_map_errors() {
  if(isDefined(level.maperrors) && level.maperrors.size > 0) {
    println("<dev string:xb8>");

    for(i = 0; i < level.maperrors.size; i++) {
      println("<dev string:xe2>" + level.maperrors[i]);
    }

    println("<dev string:xed>");
    util::error("<dev string:x117>");

    callback::abort_level();
    return true;
  }

  return false;
}

function function_308e3379() {
  return strendswith(level.gametype, "_bb");
}