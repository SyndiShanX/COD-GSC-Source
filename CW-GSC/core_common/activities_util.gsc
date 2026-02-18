/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\activities_util.gsc
***********************************************/

#using scripts\core_common\system_shared;
#namespace activities;

function private autoexec __init__system__() {
  system::register(#"activities", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.activities = {};
  level.activities.var_7e507488 = clientsysregister("a:obj");
}

function function_b73af3c(name) {
  level.activities.levelname = name;
}

function function_59e67711(objective) {
  assert(!issubstr(objective, "<dev string:x38>"), "<dev string:x3d>");

  if(isDefined(level.activities.levelname)) {
    clientsyssetstate(level.activities.var_7e507488, "0," + objective + "," + level.gameskill + "," + level.var_1c5d2bf4 + "," + level.activities.levelname);
    level.activities.levelname = undefined;
    return;
  }

  clientsyssetstate(level.activities.var_7e507488, "1," + objective + "," + level.gameskill + "," + level.var_1c5d2bf4);
}