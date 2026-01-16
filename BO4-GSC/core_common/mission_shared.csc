/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\mission_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace mission_utils;

autoexec __init__system__() {
  system::register(#"mission", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "mission_active_flags", 1, 8, "int", &mission_active_changed, 0, 0);
}

mission_active_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.mission_active_flags)) {
    level.mission_active_flags = 0;
  }

  for(i = 0; i < 8; i++) {
    changedflags = level.mission_active_flags ^ newval;

    if((changedflags&1 << i) != 0) {
      if((level.mission_active_flags&1 << i) != 0) {
        stopmission(i);
      }
    }
  }

  for(i = 0; i < 8; i++) {
    changedflags = level.mission_active_flags ^ newval;

    if((changedflags&1 << i) != 0) {
      if((level.mission_active_flags&1 << i) == 0) {
        startmission(i);
      }
    }
  }

  level.mission_active_flags = newval;
}