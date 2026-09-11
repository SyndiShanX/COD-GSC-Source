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

function gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

function playerzombiethermalcleanup(var_0) {
  return isDefined(game["flags"][var_0]);
}

function gameflag(var_0) {
  return game["flags"][var_0];
}

function gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

function gameflagclear(var_0) {
  game["flags"][var_0] = 0;
}

function gameflagwait(var_0) {
  while(!gameflag(var_0)) {
    level waittill(var_0);
  }
}

function initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
    return;
  }
}

function levelflaginit(var_0, var_1) {
  level.levelflags[var_0] = var_1;
}

function levelflag(var_0) {
  return level.levelflags[var_0];
}

function levelflagset(var_0) {
  level.levelflags[var_0] = 1;
  level notify(var_0);
}

function levelflagclear(var_0) {
  level.levelflags[var_0] = 0;
  level notify(var_0);
}

function levelflagwait(var_0) {
  while(!levelflag(var_0)) {
    level waittill(var_0);
  }
}

function levelflagwaitopen(var_0) {
  while(levelflag(var_0)) {
    level waittill(var_0);
  }
}