/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\util.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace util;

function brush_delete() {
  num = self.v[# "exploder"];

  if(isDefined(self.v[# "delay"])) {
    wait self.v[# "delay"];
  } else {
    wait 0.05;
  }

  if(!isDefined(self.model)) {
    return;
  }

  assert(isDefined(self.model));

  if(!isDefined(self.v[# "fxid"]) || self.v[# "fxid"] == "No FX") {
    self.v[# "exploder"] = undefined;
  }

  waittillframeend();
  self.model delete();
}

function brush_show() {
  if(isDefined(self.v[# "delay"])) {
    wait self.v[# "delay"];
  }

  assert(isDefined(self.model));
  self.model show();
  self.model solid();
}

function brush_throw() {
  if(isDefined(self.v[# "delay"])) {
    wait self.v[# "delay"];
  }

  ent = undefined;

  if(isDefined(self.v[# "target"])) {
    ent = getent(self.v[# "target"], "targetname");
  }

  if(!isDefined(ent)) {
    self.model delete();
    return;
  }

  self.model show();
  startorg = self.v[# "origin"];
  startang = self.v[# "angles"];
  org = ent.origin;
  temp_vec = org - self.v[# "origin"];
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  self.model rotatevelocity((x, y, z), 12);
  self.model movegravity((x, y, z), 12);
  self.v[# "exploder"] = undefined;
  wait 6;
  self.model delete();
}

function playsoundonplayers(sound, team) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(sound);
    }

    return;
  }

  if(isDefined(team)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
        player playlocalsound(sound);
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    level.players[i] playlocalsound(sound);
  }
}

function get_player_height() {
  return 70;
}

function isbulletimpactmod(smeansofdeath) {
  return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

function waitrespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(self useButtonPressed() != 1) {
    waitframe(1);
  }
}

function printonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
      player iprintln(text);
    }
  }
}

function printboldonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
      player iprintlnbold(text);
    }
  }
}

function printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

function printonteamarg(text, team, arg) {}

function printonplayers(text, team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers[# "team"]) && players[i].pers[# "team"] == team) {
        players[i] iprintln(text);
      }

      continue;
    }

    players[i] iprintln(text);
  }
}

function _playlocalsound(soundalias) {
  if(level.splitscreen && !self ishost()) {
    return;
  }

  self playlocalsound(soundalias);
}

function getotherteam(team) {
  if(team == # "allies") {
    return # "axis";
  } else if(team == # "axis") {
    return # "allies";
  } else {
    return # "allies";
  }

  assertmsg("<dev string:x38>" + team);
}

function getteammask(team) {
  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.ispawn_teammask_free;
  }

  return level.spawnsystem.ispawn_teammask[team];
}

function getotherteamsmask(skip_team) {
  mask = 0;

  foreach(team, _ in level.teams) {
    if(team == skip_team) {
      continue;
    }

    mask |= getteammask(team);
  }

  return mask;
}

function getfx(fx) {
  assert(isDefined(level._effect[fx]), "<dev string:x57>" + fx + "<dev string:x5e>");
  return level._effect[fx];
}

function isstrstart(string1, substr) {
  return getsubstr(string1, 0, substr.size) == substr;
}

function iskillstreaksenabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

function getremotename() {
  assert(self isusingremote());
  return self.usingremote;
}

function setobjectivetext(team, text) {
  game.strings["objective_" + level.teams[team]] = text;
}

function setobjectivescoretext(team, text) {
  game.strings["objective_score_" + level.teams[team]] = text;
}

function getobjectivetext(team) {
  return game.strings["objective_" + level.teams[team]];
}

function getobjectivescoretext(team) {
  return game.strings["objective_score_" + level.teams[team]];
}

function getobjectivehinttext(team) {
  return game.strings["objective_hint_" + level.teams[team]];
}

function registerroundswitch(minvalue, maxvalue) {
  level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
}

function registerroundlimit(minvalue, maxvalue) {
  level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
  level.roundlimitmin = minvalue;
  level.roundlimitmax = maxvalue;
}

function registerroundwinlimit(minvalue, maxvalue) {
  level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
  level.roundwinlimitmin = minvalue;
  level.roundwinlimitmax = maxvalue;
}

function registerscorelimit(minvalue, maxvalue) {
  level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
  level.scorelimitmin = minvalue;
  level.scorelimitmax = maxvalue;
}

function registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
}

function registernumlives(minvalue, maxvalue) {
  level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
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
  buildtype = getdvarstring(#"buildtype");

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

    for(i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1]) {
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