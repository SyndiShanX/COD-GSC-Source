/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_wasp.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace wasp;

function autoexec __init__sytem__() {
  system::register("wasp", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
  level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");
  if(isDefined(level.sentinelbundle)) {
    vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
  }
}

function spawned(localclientnum) {
  self.killstreakbundle = level.sentinelbundle;
}

function handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(isDefined(self)) {
    if(self islocalclientdriver(localclientnum)) {
      self sethighdetail(1);
      wait(0.05);
      self vehicle::lights_off(localclientnum);
    }
  }
}