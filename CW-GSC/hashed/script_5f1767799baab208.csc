/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5f1767799baab208.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace helicopter_escape;

function private autoexec __init__system__() {
  system::register(#"hash_fb0b00f613ec7da", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_7732e7b9e5c4e0e")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  zm_ping::function_5ae4a10c(undefined, "helicopter_escape_heli", #"hash_5783e6ae1065d00", "pingVehicle");
  zm_ping::function_5ae4a10c(#"wpn_t9_streak_care_package_friendly_world", "helicopter_escape_crate", #"hash_12f3d2dc40a1670e", #"hash_49f4ae06ae4af262", #"ui_icon_inventory_care_package_friendly_t9");
}

function supply_drop_parachute(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrenderoverridebundle(#"hash_336cece53ae2342f");
    return;
  }

  self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

function on_vehicle_spawned(localclientnum) {
  if(self.vehicletype === # "hash_669d01ea5db4e10c") {
    self function_1f0c7136(3);
    self.var_fc558e74 = "helicopter_escape_heli";
  }
}