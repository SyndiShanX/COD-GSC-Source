/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\recon_car.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#namespace recon_car;

function private autoexec __init__system__() {
  system::register(#"recon_car", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_45aec06707484fef"))) {
    return 0;
  }

  clientfield::register("vehicle", "" + # "hash_5b4b44738e08c9b9", 28000, 1, "counter", &function_86e8d9af, 0, 0);
  killstreak_detect::init_shared();
  level.var_af161ca6 = getscriptbundle("killstreak_recon_car_zm");
  killstreak_vehicle::init_killstreak(level.var_af161ca6);
  vehicle::add_vehicletype_callback(level.var_af161ca6.ksvehicle, &spawned);
}

function spawned(localclientnum) {
  self.killstreakbundle = level.var_af161ca6;
}

function function_86e8d9af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_fx = # "hash_5627dee1716af1be";

  if(self.model === # "hash_7dde995ef49216f") {
    str_fx = # "hash_1fd4c0687c9801d2";
  }

  util::playFXOnTag(bwastimejump, str_fx, self, "tag_origin");
  self playSound(bwastimejump, #"hash_3b04ee47d31da098");
  self playrumbleonentity(bwastimejump, "damage_heavy");
}