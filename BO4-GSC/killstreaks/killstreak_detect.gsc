/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_detect.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\killstreaks\killstreak_hacking;

#namespace killstreak_detect;

init_shared() {
  if(!isDefined(level.var_c3f91417)) {
    level.var_c3f91417 = {};
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
    clientfield::register("missile", "enemyvehicle", 1, 2, "int");
    clientfield::register("actor", "enemyvehicle", 1, 2, "int");
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
  }
}

killstreaktargetset(killstreakentity, offset = (0, 0, 0)) {
  target_set(killstreakentity, offset);

  killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);

}

killstreaktargetclear(killstreakentity) {
  target_remove(killstreakentity);

  killstreakentity thread killstreak_hacking::killstreak_switch_team_end();

}