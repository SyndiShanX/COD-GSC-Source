/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_detect.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_hacking;
#namespace killstreak_detect;

function private autoexec __init__system__() {
  system::register(#"killstreak_detect", &init_shared, undefined, undefined, undefined);
}

function init_shared() {
  if(!isDefined(level.var_c3f91417)) {
    level.var_c3f91417 = {};
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
    clientfield::register("missile", "enemyvehicle", 1, 2, "int");
    clientfield::register("actor", "enemyvehicle", 1, 2, "int");
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
  }
}

function killstreaktargetset(killstreakentity, offset = (0, 0, 0)) {
  target_set(killstreakentity, offset);

  killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
}

function killstreaktargetclear(killstreakentity) {
  target_remove(killstreakentity);

  killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
}