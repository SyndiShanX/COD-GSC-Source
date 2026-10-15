/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicles\wasp.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;

#namespace wasp;

autoexec __init__system__() {
  system::register(#"wasp", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
  level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");

  if(isDefined(level.sentinelbundle)) {
    vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
  }
}

spawned(localclientnum) {
  self.killstreakbundle = level.sentinelbundle;
}

handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(isDefined(self)) {
    if(self function_4add50a7()) {
      self sethighdetail(1);
      waitframe(1);
      self vehicle::lights_off(localclientnum);
    }
  }
}