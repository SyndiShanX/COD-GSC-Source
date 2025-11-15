/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_helicopter_gunner.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace helicopter_gunner;

function autoexec __init__sytem__() {
  system::register("helicopter_gunner", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "vtol_turret_destroyed_0", 1, 1, "int", & turret_destroyed_0, 0, 0);
  clientfield::register("vehicle", "vtol_turret_destroyed_1", 1, 1, "int", & turret_destroyed_1, 0, 0);
  clientfield::register("toplayer", "vtol_update_client", 1, 1, "counter", & update_client, 0, 0);
  clientfield::register("toplayer", "fog_bank_2", 1, 1, "int", & fog_bank_2_callback, 0, 0);
  visionset_mgr::register_visionset_info("mothership_visionset", 1, 1, undefined, "mp_vehicles_mothership");
}

function turret_destroyed_0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function turret_destroyed_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function update_turret_destroyed(localclientnum, ui_model_name, new_value) {
  part_destroyed_ui_model = getuimodel(getuimodelforcontroller(localclientnum), ui_model_name);
  if(isDefined(part_destroyed_ui_model)) {
    setuimodelvalue(part_destroyed_ui_model, new_value);
  }
}

function update_client(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  veh = getplayervehicle(self);
  if(isDefined(veh)) {
    update_turret_destroyed(localclientnum, "vehicle.partDestroyed.0", veh clientfield::get("vtol_turret_destroyed_0"));
    update_turret_destroyed(localclientnum, "vehicle.partDestroyed.1", veh clientfield::get("vtol_turret_destroyed_1"));
  }
}

function fog_bank_2_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval != newval) {
    if(newval == 1) {
      setlitfogbank(localclientnum, -1, 1, 0);
    } else {
      setlitfogbank(localclientnum, -1, 0, 0);
    }
  }
}