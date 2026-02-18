/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\teamset.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace teamset;

function private autoexec __init__system__() {
  system::register(#"teamset_seals", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.allies_team = # "allies";
  level.axis_team = # "axis";
}