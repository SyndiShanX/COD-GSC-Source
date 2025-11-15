/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_traps.csc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace zm_traps;

autoexec __init__system__() {
  system::register(#"zm_traps", &__init__, undefined, undefined);
}

__init__() {
  s_traps_array = struct::get_array("zm_traps", "targetname");
  a_registered_traps = [];

  foreach(trap in s_traps_array) {
    if(isDefined(trap.script_noteworthy)) {
      if(!trap is_trap_registered(a_registered_traps)) {
        a_registered_traps[trap.script_noteworthy] = 1;
      }
    }
  }
}

is_trap_registered(a_registered_traps) {
  return isDefined(a_registered_traps[self.script_noteworthy]);
}