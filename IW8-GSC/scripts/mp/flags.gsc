/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\flags.gsc
***********************************************/

function initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
    return;
  }
}

function gameflaginit(var0, var1) {
  game["flags"][var0] = var1;
}

function playerzombiethermalcleanup(var0) {
  return isDefined(game["flags"][var0]);
}

function gameflag(var0) {
  return game["flags"][var0];
}

function gameflagset(var0) {
  game["flags"][var0] = 1;
  level notify(var0);
}

function gameflagclear(var0) {
  game["flags"][var0] = 0;
}

function gameflagwait(var0) {
  while(!gameflag(var0)) {
    level waittill(var0);
  }
}

function initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
    return;
  }
}

function levelflaginit(var0, var1) {
  level.levelflags[var0] = var1;
}

function levelflag(var0) {
  return level.levelflags[var0];
}

function levelflagset(var0) {
  level.levelflags[var0] = 1;
  level notify(var0);
}

function levelflagclear(var0) {
  level.levelflags[var0] = 0;
  level notify(var0);
}

function levelflagwait(var0) {
  while(!levelflag(var0)) {
    level waittill(var0);
  }
}

function levelflagwaitopen(var0) {
  while(levelflag(var0)) {
    level waittill(var0);
  }
}