/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cheat.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace cheat;

function private autoexec __init__system__() {
  system::register(#"cheat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
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
    setDvar(level.cheatdvars[index], level.cheatstates[level.cheatdvars[index]]);
  }
}

function addcheat(toggledvar, cheatfunc) {
  setDvar(toggledvar, 0);

  level.cheatstates[toggledvar] = getdvarint(toggledvar, 0);
  level.cheatfuncs[toggledvar] = cheatfunc;

  if(level.cheatstates[toggledvar]) {
    [[cheatfunc]](level.cheatstates[toggledvar]);
  }
}

function checkcheatchanged(toggledvar) {
  cheatvalue = getdvarint(toggledvar, 0);

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
  level endon(#"unloaded");
  addcheat("sf_use_ignoreammo", &ignore_ammomode);
  level.cheatdvars = getarraykeys(level.cheatstates);

  for(;;) {
    for(index = 0; index < level.cheatdvars.size; index++) {
      checkcheatchanged(level.cheatdvars[index]);
    }

    wait 0.5;
  }
}

function ignore_ammomode(cheatvalue) {
  if(cheatvalue) {
    setsaveddvar(#"player_sustainammo", 1);
    return;
  }

  setsaveddvar(#"player_sustainammo", 0);
}

function is_cheating() {
  return level flag::get("has_cheated");
}