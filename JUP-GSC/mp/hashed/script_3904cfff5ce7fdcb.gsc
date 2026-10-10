/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3904cfff5ce7fdcb.gsc
*************************************************/

#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#namespace gulag;

function function_88039a31ef9e74dd() {
  alreadywin = isDefined(self.gulagloser) && !self.gulagloser;

  if(alreadywin) {
    return;
  }

  ignoremeold = self.ignoreme;
  ignoreallold = self.ignoreall;
  olddifficulty = self botgetdifficulty();

  if(olddifficulty != "recruit") {
    self botsetdifficulty("recruit");
  } else {
    olddifficulty = undefined;
  }

  function_c1a20b04ac6141bf();
  self.ignoreme = ignoremeold;
  self.ignoreall = ignoreallold;

  if(isDefined(olddifficulty)) {
    self botsetdifficulty(olddifficulty);
  }
}

function function_c1a20b04ac6141bf() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  function_5643932de03d949d();
  function_7b827ec625eac6f5();
  function_35c340e0c5d514f();
}

function function_5643932de03d949d() {
  setenemy(undefined);
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.jailed) && !istrue(self.gulagarena)) {
    wait 1;
  }
}

function function_7b827ec625eac6f5() {
  function_142b713a2846f9ac("Gulag 2F");

  while(istrue(self.jailed)) {
    self.ignoreall = 0;
    actiontype = randomint(100);

    if(actiontype < 20) {
      self botpressbutton("jump");
      wait 1;
      continue;
    }

    if(actiontype < 50) {
      self botclearscriptgoal();
      sec = randomintrange(1, 3);
      wait sec;
      continue;
    }

    self botclearscriptgoal();
    arena = self.arena;
    idx = randomint(arena.jailspawns.size);
    pointonnavmesh = arena.jailspawns[idx].origin;
    dest = function_207ba502560fa1d2(pointonnavmesh);
    setscriptgoal(dest, randomintrange(50, 400));
    waittill_any_ents_or_timeout_return(5, self, "goal", self, "bad_path", self, "initPlayerArena");
  }
}

function function_35c340e0c5d514f() {
  while(true) {
    wait 0.2;

    if(!isDefined(self.var_600419d0dbb63af7)) {
      break;
    }
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  self botclearscriptgoal();
  function_142b713a2846f9ac("Gulag 1F");
  lastdestination = undefined;
  target = undefined;
  var_7a336bd948b61bd9 = 20;

  while(!isDefined(target) && istrue(self.gulagarena)) {
    if(!isDefined(lastdestination) || distance(self.origin, lastdestination) <= var_7a336bd948b61bd9 || !self bothasscriptgoal()) {
      lastdestination = function_80d441566c90edc6();

      if(isDefined(lastdestination)) {
        setscriptgoal(lastdestination, var_7a336bd948b61bd9);
      }
    }

    target = selecttarget();

    if(isDefined(target)) {
      break;
    }

    wait 0.2;
  }

  if(isDefined(target)) {
    self botclearscriptgoal();
    self getenemyinfo(target);
    self botsetscriptenemy(target);

    while(istrue(self.gulagarena)) {
      wait 0.5;
    }

    self botclearscriptenemy();
  }
}

function selecttarget() {
  var_caa829fe86bc833b = 392;

  foreach(player in self.arena.arenaplayers) {
    if(player != self) {
      if(function_3569a4bec8b9af17(player) || self botcanseeentity(player, 1) || distance(self.origin, player.origin) < var_caa829fe86bc833b) {
        return player;
      }
    }
  }

  return undefined;
}

function function_80d441566c90edc6() {
  playermark = undefined;

  foreach(player in self.arena.arenaplayers) {
    if(player != self) {
      playermark = player.origin;
      break;
    }
  }

  if(!isDefined(playermark)) {
    playermark = self.origin;
  }

  wander_distance = 392;

  for(i = 0; i < 10; i++) {
    destination = namespace_41f4dfb71dd08362::selectdestination(wander_distance, playermark);

    if(abs(destination[2] - self.origin[2]) < 50) {
      return destination;
    }
  }

  return undefined;
}