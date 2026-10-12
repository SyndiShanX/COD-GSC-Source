/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\flags.gsc
***********************************************/

#namespace flags;

function initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

function gameflaginit(flagname, isenabled) {
  assert(isDefined(game["<dev string:x1c>"]));
  game["flags"][flagname] = isenabled;
}

function gameflagexists(flagname) {
  return isDefined(game["flags"]) && isDefined(game["flags"][flagname]);
}

function gameflag(flagname) {
  assertex(isDefined(game["<dev string:x1c>"][flagname]), "<dev string:x25>" + flagname + "<dev string:x32>");
  return game["flags"][flagname];
}

function gameflagset(flagname) {
  assertex(isDefined(game["<dev string:x1c>"][flagname]), "<dev string:x25>" + flagname + "<dev string:x32>");
  game["flags"][flagname] = 1;
  level notify(flagname);
}

function gameflagclear(flagname) {
  assertex(isDefined(game["<dev string:x1c>"][flagname]), "<dev string:x25>" + flagname + "<dev string:x32>");
  game["flags"][flagname] = 0;
}

function gameflagwait(flagname) {
  assertex(isDefined(game["<dev string:x1c>"][flagname]), "<dev string:x25>" + flagname + "<dev string:x32>");

  while(!gameflag(flagname)) {
    level waittill(flagname);
  }
}

function function_1240434f4201ac9d(flagname) {
  while(!gameflagexists(flagname)) {
    waitframe();
  }

  gameflagwait(flagname);
}

function initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
  }
}

function levelflaginit(flagname, isenabled) {
  assert(isDefined(level.levelflags));
  level.levelflags[flagname] = isenabled;
}

function levelflag(flagname) {
  assertex(isDefined(level.levelflags[flagname]), "<dev string:x87>" + flagname + "<dev string:x95>");
  return level.levelflags[flagname];
}

function levelflagset(flagname) {
  assertex(isDefined(level.levelflags[flagname]), "<dev string:x87>" + flagname + "<dev string:x95>");
  level.levelflags[flagname] = 1;
  level notify(flagname);
}

function levelflagclear(flagname) {
  assertex(isDefined(level.levelflags[flagname]), "<dev string:x87>" + flagname + "<dev string:x95>");
  level.levelflags[flagname] = 0;
  level notify(flagname);
}

function levelflagwait(flagname) {
  assertex(isDefined(level.levelflags[flagname]), "<dev string:x87>" + flagname + "<dev string:x95>");

  while(!levelflag(flagname)) {
    level waittill(flagname);
  }
}

function levelflagwaitopen(flagname) {
  assertex(isDefined(level.levelflags[flagname]), "<dev string:x87>" + flagname + "<dev string:x95>");

  while(levelflag(flagname)) {
    level waittill(flagname);
  }
}