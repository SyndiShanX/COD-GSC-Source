/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_dart.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace dart;

function autoexec __init__sytem__() {
  system::register("dart", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "dart_update_ammo", 1, 2, "int", &update_ammo, 0, 0);
  clientfield::register("toplayer", "fog_bank_3", 1, 1, "int", &fog_bank_3_callback, 0, 0);
  level.dartbundle = struct::get_script_bundle("killstreak", "killstreak_dart");
  vehicle::add_vehicletype_callback(level.dartbundle.ksdartvehicle, &spawned);
  visionset_mgr::register_visionset_info("dart_visionset", 1, 1, undefined, "mp_vehicles_dart");
  visionset_mgr::register_visionset_info("sentinel_visionset", 1, 1, undefined, "mp_vehicles_sentinel");
  visionset_mgr::register_visionset_info("remote_missile_visionset", 1, 1, undefined, "mp_hellstorm");
}

function update_ammo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo"), newval);
}

function spawned(localclientnum) {
  self.killstreakbundle = level.dartbundle;
}

function fog_bank_3_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval != newval) {
    if(newval == 1) {
      setworldfogactivebank(localclientnum, 4);
    } else {
      setworldfogactivebank(localclientnum, 1);
    }
  }
}