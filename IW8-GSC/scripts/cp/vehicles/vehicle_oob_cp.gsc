/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_oob_cp.gsc
**************************************************/

function vehicle_oob_cp_registeroutoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_cp_getleveldata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

function vehicle_oob_cp_registerinstance(var_0) {
  scripts\cp\cp_outofbounds::registerentforoob(var_0, "vehicle");
}

function vehicle_oob_cp_deregisterinstance(var_0) {
  scripts\cp\cp_outofbounds::deregisterentforoob(var_0);
}

function vehicle_oob_cp_clearoob(var_0, var_1) {
  scripts\cp\cp_outofbounds::clearoob(var_0, var_1);
}

function vehicle_oob_cp_init() {
  var_0 = spawnStruct();
  var_0.outoftimecallbacks = [];
  level.vehicle.oob = var_0;
  scripts\cp\cp_outofbounds::registeroobentercallback("vehicle", &vehicle_oob_cp_entercallback);
  scripts\cp\cp_outofbounds::registeroobexitcallback("vehicle", &vehicle_oob_cp_exitcallback);
  scripts\cp\cp_outofbounds::registerooboutoftimecallback("vehicle", &vehicle_oob_cp_outoftimecallback);
  scripts\cp\cp_outofbounds::registeroobclearcallback("vehicle", &vehicle_oob_cp_clearcallback);
}

function vehicle_oob_cp_getleveldata() {
  return level.vehicle.oob;
}

function vehicle_oob_cp_entercallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_4 in var_2) {
    vehicle_oob_cp_entercallbackforplayer(var_4);
  }
}

function vehicle_oob_cp_entercallbackforplayer(var_0, var_1, var_2) {
  var_0 setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function vehicle_oob_cp_exitcallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3) {
    vehicle_oob_cp_exitcallbackforplayer(var_5);
  }
}

function vehicle_oob_cp_exitcallbackforplayer(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function vehicle_oob_cp_outoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_cp_getleveldata();
  var_3 = var_2.outoftimecallbacks[self.vehiclename];
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_6 in var_4) {
    var_6.shouldskiplaststand = 1;
  }

  self[[var_3]]();
}

function vehicle_oob_cp_clearcallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_2 in var_0) {
    var_2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}