/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\lead_drone.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace lead_drone;

autoexec __init__system__() {
  system::register(#"lead_drone", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("vehicle", "lead_drone_reload", 1, 1, "int", &reload, 0, 0);
}

reload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self function_d309e55a("tag_gun_deploy_control_animate", 0);
    return;
  }

  self function_d309e55a("tag_gun_deploy_control_animate", 1);
}