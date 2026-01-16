/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\wing_drone.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;

#namespace wing_drone;

autoexec __init__system__() {
  system::register(#"wing_drone", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.var_c23a525e)) {
    level.var_c23a525e = {};
    clientfield::register("vehicle", "wing_drone_reload", 1, 1, "int", &reload, 0, 0);
  }
}

reload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self function_d309e55a("tag_turret_control_animate", 0);
    return;
  }

  self function_d309e55a("tag_turret_control_animate", 1);
}