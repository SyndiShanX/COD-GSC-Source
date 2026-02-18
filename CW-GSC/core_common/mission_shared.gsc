/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\mission_shared.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace mission_utils;

function private autoexec __init__system__() {
  system::register(#"mission", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

function start(mission_index) {
  if(!isDefined(level.mission_active_flags)) {
    level.mission_active_flags = 0;
  }

  level.mission_active_flags |= 1 << mission_index;
  clientfield::set("mission_active_flags", level.mission_active_flags);
  startmission(mission_index);
}

function stop(mission_index) {
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

  if((level.mission_active_flags & 1 << mission_index) != 0) {
    level.mission_active_flags &= ~(1 << mission_index);
    clientfield::set("mission_active_flags", level.mission_active_flags);
    stopmission(mission_index);
  }
}