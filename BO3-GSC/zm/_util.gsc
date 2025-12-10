/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace util;

function error(msg) {
  println("", msg);
  wait(0.05);
  if(getdvarstring("") != "") {
    assertmsg("");
  }
}

function warning(msg) {
  println("" + msg);
}

function brush_delete() {
  num = self.v["exploder"];
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait(0.05);
  }
  if(!isDefined(self.model)) {
    return;
  }
  assert(isDefined(self.model));
  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }
  waittillframeend();
  self.model delete();
}

function brush_show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  assert(isDefined(self.model));
  self.model show();
  self.model solid();
}

function brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  ent = undefined;
  if(isDefined(self.v["target"])) {
    ent = getent(self.v["target"], "targetname");
  }
  if(!isDefined(ent)) {
    self.model delete();
    return;
  }
  self.model show();
  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  temp_vec = org - self.v["origin"];
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  self.model rotatevelocity((x, y, z), 12);
  self.model movegravity((x, y, z), 12);
  self.v["exploder"] = undefined;
  wait(6);
  self.model delete();
}

function playsoundonplayers(sound, team) {
  assert(isDefined(level.players));
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(sound);
    }
  } else {
    if(isDefined(team)) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
          player playlocalsound(sound);
        }
      }
    } else {
      for(i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
      }
    }
  }
}

function get_player_height() {
  return 70;
}

function isbulletimpactmod(smeansofdeath) {
  return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");
  while(self usebuttonpressed() != 1) {
    wait(0.05);
  }
}

function setlowermessage(text, time, combinemessageandtimer) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  if(isDefined(self.lowermessageoverride) && text != (&"")) {
    text = self.lowermessageoverride;
    time = undefined;
  }
  self notify("lower_message_set");
  self.lowermessage settext(text);
  if(isDefined(time) && time > 0) {
    if(!isDefined(combinemessageandtimer) || !combinemessageandtimer) {
      self.lowertimer.label = &"";
    } else {
      self.lowermessage settext("");
      self.lowertimer.label = text;
    }
    self.lowertimer settimer(time);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = &"";
  }
  if(self issplitscreen()) {
    self.lowermessage.fontscale = 1.4;
  }
  self.lowermessage fadeovertime(0.05);
  self.lowermessage.alpha = 1;
  self.lowertimer fadeovertime(0.05);
  self.lowertimer.alpha = 1;
}

function setlowermessagevalue(text, value, combinemessage) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  if(isDefined(self.lowermessageoverride) && text != (&"")) {
    text = self.lowermessageoverride;
    time = undefined;
  }
  self notify("lower_message_set");
  if(!isDefined(combinemessage) || !combinemessage) {
    self.lowermessage settext(text);
  } else {
    self.lowermessage settext("");
  }
  if(isDefined(value) && value > 0) {
    if(!isDefined(combinemessage) || !combinemessage) {
      self.lowertimer.label = &"";
    } else {
      self.lowertimer.label = text;
    }
    self.lowertimer setvalue(value);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = &"";
  }
  if(self issplitscreen()) {
    self.lowermessage.fontscale = 1.4;
  }
  self.lowermessage fadeovertime(0.05);
  self.lowermessage.alpha = 1;
  self.lowertimer fadeovertime(0.05);
  self.lowertimer.alpha = 1;
}

function clearlowermessage(fadetime) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  self notify("lower_message_set");
  if(!isDefined(fadetime) || fadetime == 0) {
    setlowermessage(&"");
  } else {
    self endon("disconnect");
    self endon("lower_message_set");
    self.lowermessage fadeovertime(fadetime);
    self.lowermessage.alpha = 0;
    self.lowertimer fadeovertime(fadetime);
    self.lowertimer.alpha = 0;
    wait(fadetime);
    self setlowermessage("");
  }
}

function printonteam(text, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintln(text);
    }
  }
}

function printboldonteam(text, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text);
    }
  }
}

function printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

function printonteamarg(text, team, arg) {}

function printonplayers(text, team) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == team) {
        players[i] iprintln(text);
      }
      continue;
    }
    players[i] iprintln(text);
  }
}

function printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
  shoulddosounds = isDefined(soundfriendly);
  shoulddoenemysounds = 0;
  if(isDefined(soundenemy)) {
    assert(shoulddosounds);
    shoulddoenemysounds = 1;
  }
  if(!isDefined(printarg)) {
    printarg = "";
  }
  if(level.splitscreen || !shoulddosounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.pers["team"];
      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printfriendly) && printfriendly != (&"")) {
          player iprintln(printfriendly, printarg);
          continue;
        }
        if(isDefined(printenemy) && printenemy != (&"")) {
          if(isDefined(enemyteam) && playerteam == enemyteam) {
            player iprintln(printenemy, printarg);
            continue;
          }
          if(!isDefined(enemyteam) && playerteam != team) {
            player iprintln(printenemy, printarg);
          }
        }
      }
    }
    if(shoulddosounds) {
      assert(level.splitscreen);
      level.players[0] playlocalsound(soundfriendly);
    }
  } else {
    assert(shoulddosounds);
    if(shoulddoenemysounds) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printfriendly) && printfriendly != (&"")) {
              player iprintln(printfriendly, printarg);
            }
            player playlocalsound(soundfriendly);
            continue;
          }
          if(isDefined(enemyteam) && playerteam == enemyteam || (!isDefined(enemyteam) && playerteam != team)) {
            if(isDefined(printenemy) && printenemy != (&"")) {
              player iprintln(printenemy, printarg);
            }
            player playlocalsound(soundenemy);
          }
        }
      }
    } else {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printfriendly) && printfriendly != (&"")) {
              player iprintln(printfriendly, printarg);
            }
            player playlocalsound(soundfriendly);
            continue;
          }
          if(isDefined(printenemy) && printenemy != (&"")) {
            if(isDefined(enemyteam) && playerteam == enemyteam) {
              player iprintln(printenemy, printarg);
              continue;
            }
            if(!isDefined(enemyteam) && playerteam != team) {
              player iprintln(printenemy, printarg);
            }
          }
        }
      }
    }
  }
}

function _playlocalsound(soundalias) {
  if(level.splitscreen && !self ishost()) {
    return;
  }
  self playlocalsound(soundalias);
}

function getotherteam(team) {
  if(team == "allies") {
    return "axis";
  }
  if(team == "axis") {
    return "allies";
  }
  return "allies";
}

function getteammask(team) {
  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.ispawn_teammask_free;
  }
  return level.spawnsystem.ispawn_teammask[team];
}

function getotherteamsmask(skip_team) {
  mask = 0;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    mask = mask | getteammask(team);
  }
  return mask;
}

function plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isDefined(r)) {
    r = 1;
  }
  if(!isDefined(g)) {
    g = 1;
  }
  if(!isDefined(b)) {
    b = 1;
  }
  if(!isDefined(timer)) {
    timer = 0.05;
  }
  for(i = 1; i < plotpoints.size; i++) {
    line(lastpoint, plotpoints[i], (r, g, b), 1, timer);
    lastpoint = plotpoints[i];
  }
}

function getfx(fx) {
  assert(isDefined(level._effect[fx]), ("" + fx) + "");
  return level._effect[fx];
}

function set_dvar_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return value;
  }
  return getdvarstring(dvar);
}

function set_dvar_float_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
  }
  return getdvarfloat(dvar);
}

function set_dvar_int_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return int(value);
  }
  return getdvarint(dvar);
}

function isstrstart(string1, substr) {
  return getsubstr(string1, 0, substr.size) == substr;
}

function iskillstreaksenabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

function setusingremote(remotename) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
  assert(!self isusingremote());
  self.usingremote = remotename;
  self disableoffhandweapons();
  self notify("using_remote");
}

function getremotename() {
  assert(self isusingremote());
  return self.usingremote;
}

function setobjectivetext(team, text) {
  game["strings"]["objective_" + team] = text;
}

function setobjectivescoretext(team, text) {
  game["strings"]["objective_score_" + team] = text;
}

function setobjectivehinttext(team, text) {
  game["strings"]["objective_hint_" + team] = text;
}

function getobjectivetext(team) {
  return game["strings"]["objective_" + team];
}

function getobjectivescoretext(team) {
  return game["strings"]["objective_score_" + team];
}

function getobjectivehinttext(team) {
  return game["strings"]["objective_hint_" + team];
}

function registerroundswitch(minvalue, maxvalue) {
  level.roundswitch = math::clamp(getgametypesetting("roundSwitch"), minvalue, maxvalue);
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
}

function registerroundlimit(minvalue, maxvalue) {
  level.roundlimit = math::clamp(getgametypesetting("roundLimit"), minvalue, maxvalue);
  level.roundlimitmin = minvalue;
  level.roundlimitmax = maxvalue;
}

function registerroundwinlimit(minvalue, maxvalue) {
  level.roundwinlimit = math::clamp(getgametypesetting("roundWinLimit"), minvalue, maxvalue);
  level.roundwinlimitmin = minvalue;
  level.roundwinlimitmax = maxvalue;
}

function registerscorelimit(minvalue, maxvalue) {
  level.scorelimit = math::clamp(getgametypesetting("scoreLimit"), minvalue, maxvalue);
  level.scorelimitmin = minvalue;
  level.scorelimitmax = maxvalue;
  setdvar("ui_scorelimit", level.scorelimit);
}

function registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
  setdvar("ui_timelimit", level.timelimit);
}

function registernumlives(minvalue, maxvalue) {
  level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
  level.numlivesmin = minvalue;
  level.numlivesmax = maxvalue;
}

function getplayerfromclientnum(clientnum) {
  if(clientnum < 0) {
    return undefined;
  }
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] getentitynumber() == clientnum) {
      return level.players[i];
    }
  }
  return undefined;
}

function ispressbuild() {
  buildtype = getdvarstring("buildType");
  if(isDefined(buildtype) && buildtype == "press") {
    return true;
  }
  return false;
}

function isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function domaxdamage(origin, attacker, inflictor, headshot, mod) {
  if(isDefined(self.damagedtodeath) && self.damagedtodeath) {
    return;
  }
  if(isDefined(self.maxhealth)) {
    damage = self.maxhealth + 1;
  } else {
    damage = self.health + 1;
  }
  self.damagedtodeath = 1;
  self dodamage(damage, origin, attacker, inflictor, headshot, mod);
}

function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
  maxdists2rd = undefined;
  if(isDefined(maxdist)) {
    maxdists2rd = maxdist * maxdist;
  }
  dist = [];
  index = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }
    if(isinarray(excluders, array[i])) {
      continue;
    }
    if(isvec(array[i])) {
      length = distancesquared(org, array[i]);
    } else {
      length = distancesquared(org, array[i].origin);
    }
    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }
    dist[dist.size] = length;
    index[index.size] = i;
  }
  for(;;) {
    change = 0;
    for(i = 0; i < (dist.size - 1); i++) {
      if(dist[i] <= (dist[i + 1])) {
        continue;
      }
      change = 1;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }
    if(!change) {
      break;
    }
  }
  newarray = [];
  if(max > dist.size) {
    max = dist.size;
  }
  for(i = 0; i < max; i++) {
    newarray[i] = array[index[i]];
  }
  return newarray;
}