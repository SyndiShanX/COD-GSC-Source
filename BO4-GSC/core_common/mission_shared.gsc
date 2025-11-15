/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\mission_shared.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace mission_utils;

autoexec __init__system__() {
  system::register(#"mission", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

start(mission_index) {
  if(!isDefined(level.mission_active_flags)) {
    level.mission_active_flags = 0;
  }

  level.mission_active_flags |= 1 << mission_index;
  clientfield::set("mission_active_flags", level.mission_active_flags);
  startmission(mission_index);
}

stop(mission_index) {
  if(!isDefined(level.mission_active_flags)) {
    level.mission_active_flags = 0;
    return;
  }

  if(!isDefined(mission_index)) {
    for(i = 0; i < 8; i++) {
      stop(i);
    }

    return;
  }

  if((level.mission_active_flags&1 << mission_index) != 0) {
    level.mission_active_flags &= ~(1 << mission_index);
    clientfield::set("mission_active_flags", level.mission_active_flags);
    stopmission(mission_index);
  }
}