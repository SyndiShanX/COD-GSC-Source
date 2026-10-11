/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\vehicles\vehicle_oob_mp.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\outofbounds;
#namespace vehicle_oob_mp;

function vehicle_oob_mp_registeroutoftimecallback(vehiclename, callback) {
  leveldata = vehicle_oob_mp_getleveldata();
  leveldata.outoftimecallbacks[vehiclename] = callback;
}

function vehicle_oob_mp_init() {
  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  assertex(!isDefined(level.vehicle.oob), "<dev string:x53>");
  leveldata = spawnStruct();
  leveldata.outoftimecallbacks = [];
  level.vehicle.oob = leveldata;
  registerooboutoftimecallback("vehicle", &vehicle_oob_mp_outoftimecallback);
  registeroobclearcallback("vehicle", &vehicle_oob_mp_clearcallback);
}

function vehicle_oob_mp_getleveldata() {
  assertex(isDefined(level.vehicle), "<dev string:x88>");
  assertex(isDefined(level.vehicle.oob), "<dev string:xc7>");
  return level.vehicle.oob;
}

function vehicle_oob_mp_outoftimecallback(timeoutendnotify, clearnotify) {
  leveldata = vehicle_oob_mp_getleveldata();
  callback = leveldata.outoftimecallbacks[self.vehiclename];
  assertex(isDefined(callback), "<dev string:x10d>");
  self.dontspawnhusk = 1;
  self[[callback]]();
}

function vehicle_oob_mp_clearcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(occupant in occupants) {
    occupant setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}