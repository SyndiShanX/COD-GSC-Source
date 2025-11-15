/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_traps.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_traps;

function autoexec __init__sytem__() {
  system::register("zm_traps", & __init__, undefined, undefined);
}

function __init__() {
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

function is_trap_registered(a_registered_traps) {
  return isDefined(a_registered_traps[self.script_noteworthy]);
}