/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\dart.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\qrdrone;

#namespace dart;

autoexec __init__system__() {
  system::register(#"dart", &__init__, undefined, #"killstreaks");
}

__init__() {
  qrdrone::init_shared();
  clientfield::register("toplayer", "dart_update_ammo", 1, 2, "int", &update_ammo, 0, 0);
  clientfield::register("toplayer", "fog_bank_3", 1, 1, "int", &fog_bank_3_callback, 0, 0);
  level.dartbundle = struct::get_script_bundle("killstreak", "killstreak_dart");
  vehicle::add_vehicletype_callback(level.dartbundle.ksvehicle, &spawned);
  visionset_mgr::register_visionset_info("dart_visionset", 1, 1, undefined, "mp_vehicles_dart");
  visionset_mgr::register_visionset_info("sentinel_visionset", 1, 1, undefined, "mp_vehicles_sentinel");
  visionset_mgr::register_visionset_info("remote_missile_visionset", 1, 1, undefined, "mp_hellstorm");
}

update_ammo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo"), newval);
}

spawned(localclientnum) {
  self.killstreakbundle = level.dartbundle;
}

fog_bank_3_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval != newval) {
    if(newval == 1) {
      setworldfogactivebank(localclientnum, 4);
      return;
    }

    setworldfogactivebank(localclientnum, 1);
  }
}