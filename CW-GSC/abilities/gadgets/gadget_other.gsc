/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_other.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\core_common\system_shared;
#namespace gadget_other;

function private autoexec __init__system__() {
  system::register(#"gadget_other", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
}

function gadget_other_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_other_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function set_gadget_other_status(weapon, status, time) {
  timestr = "<dev string:x38>";

  if(isDefined(time)) {
    timestr = "<dev string:x3c>" + "<dev string:x42>" + time;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold("<dev string:x4e>" + weapon.name + "<dev string:x5f>" + status + timestr);
  }
}