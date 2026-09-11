/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_oob_cp.gsc
**************************************************/

function vehicle_oob_cp_registeroutoftimecallback(var0, var1) {
  var2 = vehicle_oob_cp_getleveldata();
  var2.outoftimecallbacks[var0] = var1;
}

function vehicle_oob_cp_registerinstance(var0) {
  scripts\cp\cp_outofbounds::registerentforoob(var0, "vehicle");
}

function vehicle_oob_cp_deregisterinstance(var0) {
  scripts\cp\cp_outofbounds::deregisterentforoob(var0);
}

function vehicle_oob_cp_clearoob(var0, var1) {
  scripts\cp\cp_outofbounds::clearoob(var0, var1);
}

function vehicle_oob_cp_init() {
  var0 = spawnStruct();
  var0.outoftimecallbacks = [];
  level.vehicle.oob = var0;
  scripts\cp\cp_outofbounds::registeroobentercallback("vehicle", &vehicle_oob_cp_entercallback);
  scripts\cp\cp_outofbounds::registeroobexitcallback("vehicle", &vehicle_oob_cp_exitcallback);
  scripts\cp\cp_outofbounds::registerooboutoftimecallback("vehicle", &vehicle_oob_cp_outoftimecallback);
  scripts\cp\cp_outofbounds::registeroobclearcallback("vehicle", &vehicle_oob_cp_clearcallback);
}

function vehicle_oob_cp_getleveldata() {
  return level.vehicle.oob;
}

function vehicle_oob_cp_entercallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var4 in var2) {
    vehicle_oob_cp_entercallbackforplayer(var4);
  }
}

function vehicle_oob_cp_entercallbackforplayer(var0, var1, var2) {
  var0 setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function vehicle_oob_cp_exitcallback(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var5 in var3) {
    vehicle_oob_cp_exitcallbackforplayer(var5);
  }
}

function vehicle_oob_cp_exitcallbackforplayer(var0, var1, var2, var3) {
  var0 setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function vehicle_oob_cp_outoftimecallback(var0, var1) {
  var2 = vehicle_oob_cp_getleveldata();
  var3 = var2.outoftimecallbacks[self.vehiclename];
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var6 in var4) {
    var6.shouldskiplaststand = 1;
  }

  self[[var3]]();
}

function vehicle_oob_cp_clearcallback() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var2 in var0) {
    var2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}