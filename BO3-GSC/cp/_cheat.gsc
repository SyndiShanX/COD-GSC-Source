/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_cheat.gsc
*************************************************/

#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#namespace cheat;

function autoexec __init__sytem__() {
  system::register("cheat", & __init__, undefined, undefined);
}

function __init__() {
  level.cheatstates = [];
  level.cheatfuncs = [];
  level.cheatdvars = [];
  level flag::init("has_cheated");
  level thread death_monitor();
}

function player_init() {
  self thread specialfeaturesmenu();
}

function death_monitor() {
  setdvars_based_on_varibles();
}

function setdvars_based_on_varibles() {
  for(index = 0; index < level.cheatdvars.size; index++) {
    setdvar(level.cheatdvars[index], level.cheatstates[level.cheatdvars[index]]);
  }
}

function addcheat(toggledvar, cheatfunc) {
  setdvar(toggledvar, 0);
  level.cheatstates[toggledvar] = getdvarint(toggledvar);
  level.cheatfuncs[toggledvar] = cheatfunc;
  if(level.cheatstates[toggledvar]) {
    [[cheatfunc]](level.cheatstates[toggledvar]);
  }
}

function checkcheatchanged(toggledvar) {
  cheatvalue = getdvarint(toggledvar);
  if(level.cheatstates[toggledvar] == cheatvalue) {
    return;
  }
  if(cheatvalue) {
    level flag::set("has_cheated");
  }
  level.cheatstates[toggledvar] = cheatvalue;
  [[level.cheatfuncs[toggledvar]]](cheatvalue);
}

function specialfeaturesmenu() {
  level endon("unloaded");
  addcheat("sf_use_ignoreammo", & ignore_ammomode);
  level.cheatdvars = getarraykeys(level.cheatstates);
  for(;;) {
    for(index = 0; index < level.cheatdvars.size; index++) {
      checkcheatchanged(level.cheatdvars[index]);
    }
    wait(0.5);
  }
}

function ignore_ammomode(cheatvalue) {
  if(cheatvalue) {
    setsaveddvar("player_sustainAmmo", 1);
  } else {
    setsaveddvar("player_sustainAmmo", 0);
  }
}

function is_cheating() {
  return level flag::get("has_cheated");
}