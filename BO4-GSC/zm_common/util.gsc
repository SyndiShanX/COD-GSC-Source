/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\struct;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;

#namespace util;

brush_delete() {
  num = self.v[#"exploder"];

  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  } else {
    wait 0.05;
  }

  if(!isDefined(self.model)) {
    return;
  }

  assert(isDefined(self.model));

  if(!isDefined(self.v[#"fxid"]) || self.v[#"fxid"] == "No FX") {
    self.v[#"exploder"] = undefined;
  }

  waittillframeend();
  self.model delete();
}

brush_show() {
  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  }

  assert(isDefined(self.model));
  self.model show();
  self.model solid();
}

brush_throw() {
  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  }

  ent = undefined;

  if(isDefined(self.v[#"target"])) {
    ent = getent(self.v[#"target"], "targetname");
  }

  if(!isDefined(ent)) {
    self.model delete();
    return;
  }

  self.model show();
  startorg = self.v[#"origin"];
  startang = self.v[#"angles"];
  org = ent.origin;
  temp_vec = org - self.v[#"origin"];
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  self.model rotatevelocity((x, y, z), 12);
  self.model movegravity((x, y, z), 12);
  self.v[#"exploder"] = undefined;
  wait 6;
  self.model delete();
}

playsoundonplayers(sound, team) {
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

      if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
        player playlocalsound(sound);
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    level.players[i] playlocalsound(sound);
  }
}

get_player_height() {
  return 70;
}

isbulletimpactmod(smeansofdeath) {
  return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

waitrespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(self usebuttonpressed() != 1) {
    waitframe(1);
  }
}

printonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintln(text);
    }
  }
}

printboldonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintlnbold(text);
    }
  }
}

printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

printonteamarg(text, team, arg) {}

printonplayers(text, team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team) {
        players[i] iprintln(text);
      }

      continue;
    }

    players[i] iprintln(text);
  }
}

printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
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
      playerteam = player.pers[#"team"];

      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printfriendly) && printfriendly != #"") {
          player iprintln(printfriendly, printarg);
          continue;
        }

        if(isDefined(printenemy) && printenemy != #"") {
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

    return;
  }

  assert(shoulddosounds);

  if(shoulddoenemysounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.pers[#"team"];

      if(isDefined(playerteam)) {
        if(playerteam == team) {
          if(isDefined(printfriendly) && printfriendly != #"") {
            player iprintln(printfriendly, printarg);
          }

          player playlocalsound(soundfriendly);
          continue;
        }

        if(isDefined(enemyteam) && playerteam == enemyteam || !isDefined(enemyteam) && playerteam != team) {
          if(isDefined(printenemy) && printenemy != #"") {
            player iprintln(printenemy, printarg);
          }

          player playlocalsound(soundenemy);
        }
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    playerteam = player.pers[#"team"];

    if(isDefined(playerteam)) {
      if(playerteam == team) {
        if(isDefined(printfriendly) && printfriendly != #"") {
          player iprintln(printfriendly, printarg);
        }

        player playlocalsound(soundfriendly);
        continue;
      }

      if(isDefined(printenemy) && printenemy != #"") {
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

_playlocalsound(soundalias) {
  if(level.splitscreen && !self ishost()) {
    return;
  }

  self playlocalsound(soundalias);
}

getotherteam(team) {
  if(team == #"allies") {
    return #"axis";
  } else if(team == #"axis") {
    return #"allies";
  } else {
    return #"allies";
  }

  assertmsg("<dev string:x38>" + team);
}

getteammask(team) {
  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.ispawn_teammask_free;
  }

  return level.spawnsystem.ispawn_teammask[team];
}

getotherteamsmask(skip_team) {
  mask = 0;

  foreach(team, _ in level.teams) {
    if(team == skip_team) {
      continue;
    }

    mask |= getteammask(team);
  }

  return mask;
}

getfx(fx) {
  assert(isDefined(level._effect[fx]), "<dev string:x56>" + fx + "<dev string:x5c>");
  return level._effect[fx];
}

isstrstart(string1, substr) {
  return getsubstr(string1, 0, substr.size) == substr;
}

iskillstreaksenabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

getremotename() {
  assert(self isusingremote());
  return self.usingremote;
}

setobjectivetext(team, text) {
  game.strings["objective_" + level.teams[team]] = text;
}

setobjectivescoretext(team, text) {
  game.strings["objective_score_" + level.teams[team]] = text;
}

getobjectivetext(team) {
  return game.strings["objective_" + level.teams[team]];
}

getobjectivescoretext(team) {
  return game.strings["objective_score_" + level.teams[team]];
}

getobjectivehinttext(team) {
  return game.strings["objective_hint_" + level.teams[team]];
}

registerroundswitch(minvalue, maxvalue) {
  level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
}

registerroundlimit(minvalue, maxvalue) {
  level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
  level.roundlimitmin = minvalue;
  level.roundlimitmax = maxvalue;
}

registerroundwinlimit(minvalue, maxvalue) {
  level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
  level.roundwinlimitmin = minvalue;
  level.roundwinlimitmax = maxvalue;
}

registerscorelimit(minvalue, maxvalue) {
  level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
  level.scorelimitmin = minvalue;
  level.scorelimitmax = maxvalue;
}

registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
}

registernumlives(minvalue, maxvalue) {
  level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
  level.numlivesmin = minvalue;
  level.numlivesmax = maxvalue;
}

getplayerfromclientnum(clientnum) {
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

ispressbuild() {
  buildtype = getdvarstring(#"buildtype");

  if(isDefined(buildtype) && buildtype == "press") {
    return true;
  }

  return false;
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

domaxdamage(origin, attacker, inflictor, headshot, mod) {
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

get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
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