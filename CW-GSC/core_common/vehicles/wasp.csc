/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\wasp.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace wasp;

function private autoexec __init__system__() {
  system::register(#"wasp", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
  level.sentinelbundle = getscriptbundle("killstreak_sentinel");

  if(isDefined(level.sentinelbundle)) {
    vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
  }
}

function spawned(localclientnum) {
  self.killstreakbundle = level.sentinelbundle;
}

function handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(isDefined(self)) {
    if(self function_4add50a7()) {
      self sethighdetail(1);
      waitframe(1);
      self vehicle::lights_off(bwastimejump);
    }
  }
}