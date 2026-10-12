/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_oob_cp.gsc
**************************************************/



#using scripts\common\utility;
#using scripts\cp\cp_outofbounds;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_oob_cp;

function vehicle_oob_cp_registeroutoftimecallback(vehiclename, callback) {
  leveldata = vehicle_oob_cp_getleveldata();
  leveldata.outoftimecallbacks[vehiclename] = callback;
}

function vehicle_oob_cp_init() {
  assertex(isDefined(level.vehicle), "vehicle_oob_cp_init() called before vehicle_init().");
  assertex(!isDefined(level.vehicle.oob), "vehicle_oob_cp_init() should only be called once.");
  leveldata = spawnStruct();
  leveldata.outoftimecallbacks = [];
  level.vehicle.oob = leveldata;
  registeroobentercallback("vehicle", &vehicle_oob_cp_entercallback);
  registeroobexitcallback("vehicle", &vehicle_oob_cp_exitcallback);
  registerooboutoftimecallback("vehicle", &vehicle_oob_cp_outoftimecallback);
  registeroobclearcallback("vehicle", &vehicle_oob_cp_clearcallback);
}

function vehicle_oob_cp_getleveldata() {
  assertex(isDefined(level.vehicle), "vehicle_oob_cp_getLevelData() called before vehicle_init().");
  assertex(isDefined(level.vehicle.oob), "vehicle_oob_cp_getLevelData() called before vehicle_oob_cp_init().");
  return level.vehicle.oob;
}

function vehicle_oob_cp_entercallback(exitnotify, clearnotify) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(occupant in occupants) {
    vehicle_oob_cp_entercallbackforplayer(occupant);
  }
}

function vehicle_oob_cp_entercallbackforplayer(player, exitnotify, clearnotify) {
  player setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function vehicle_oob_cp_exitcallback(fromdeath, fromclear, clearnotify) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(occupant in occupants) {
    vehicle_oob_cp_exitcallbackforplayer(occupant);
  }
}

function vehicle_oob_cp_exitcallbackforplayer(player, fromdeath, fromclear, clearnotify) {
  player setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function vehicle_oob_cp_outoftimecallback(timeoutendnotify, clearnotify) {
  leveldata = vehicle_oob_cp_getleveldata();
  callback = leveldata.outoftimecallbacks[self.vehiclename];
  assertex(isDefined(callback), "vehicle_oob_cp_outOfTimeCallback() called on a vehicle without a valid outOfTimeCallback.");
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(occupant in occupants) {
    occupant.shouldskiplaststand = 1;
    occupant scripts\cp_mp\armor::setarmorhealth(0);
  }

  self[[callback]]();
}

function vehicle_oob_cp_clearcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(occupant in occupants) {
    occupant setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}