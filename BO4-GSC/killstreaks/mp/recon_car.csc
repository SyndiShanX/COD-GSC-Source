/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\recon_car.csc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\killstreak_detect;
#include scripts\killstreaks\mp\killstreak_vehicle;

#namespace recon_car;

autoexec __init__system__() {
  system::register(#"recon_car", &__init__, undefined, #"killstreaks");
}

__init__() {
  killstreak_detect::init_shared();
  bundle = struct::get_script_bundle("killstreak", sessionmodeiswarzonegame() ? "killstreak_recon_car_wz" : "killstreak_recon_car");
  level.var_af161ca6 = bundle;
  killstreak_vehicle::init_killstreak(bundle);
  vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned);
}

spawned(localclientnum, killstreak_duration) {
  self.killstreakbundle = level.var_af161ca6;
}