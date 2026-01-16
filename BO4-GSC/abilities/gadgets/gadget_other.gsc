/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_other.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\system_shared;

#namespace gadget_other;

autoexec __init__system__() {
  system::register(#"gadget_other", &__init__, undefined, undefined);
}

__init__() {
  ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
}

gadget_other_is_inuse(slot) {
  return self gadgetisactive(slot);
}

gadget_other_is_flickering(slot) {
  return self gadgetflickering(slot);
}

set_gadget_other_status(weapon, status, time) {
  timestr = "<dev string:x38>";

  if(isDefined(time)) {
    timestr = "<dev string:x3b>" + "<dev string:x40>" + time;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold("<dev string:x4b>" + weapon.name + "<dev string:x5b>" + status + timestr);
  }
}

