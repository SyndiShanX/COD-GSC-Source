/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_oob_mp.gsc
**************************************************/

function vehicle_oob_mp_registeroutoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_mp_getleveldata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

function vehicle_oob_mp_registerinstance(var_0) {
  scripts\mp\outofbounds::registerentforoob(var_0, "vehicle");
}

function vehicle_oob_mp_deregisterinstance(var_0) {
  scripts\mp\outofbounds::deregisterentforoob(var_0);
}

function vehicle_oob_mp_clearoob(var_0, var_1) {
  scripts\mp\outofbounds::clearoob(var_0, var_1);
}

function vehicle_oob_mp_init() {
  var_0 = spawnStruct();
  var_0.outoftimecallbacks = [];
  level.vehicle.oob = var_0;
  scripts\mp\outofbounds::registeroobentercallback("vehicle", &vehicle_oob_mp_entercallback);
  scripts\mp\outofbounds::registeroobexitcallback("vehicle", &vehicle_oob_mp_exitcallback);
  scripts\mp\outofbounds::registerooboutoftimecallback("vehicle", &vehicle_oob_mp_outoftimecallback);
  scripts\mp\outofbounds::registeroobclearcallback("vehicle", &vehicle_oob_mp_clearcallback);
}

function vehicle_oob_mp_getleveldata() {
  return level.vehicle.oob;
}

function vehicle_oob_mp_entercallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3) {
    vehicle_oob_mp_entercallbackforplayer(var_5, undefined, undefined, var_2);
  }
}

function vehicle_oob_mp_entercallbackforplayer(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(var_3) && var_3 == "restricted") {
    var_4 = 2;
  }

  var_0 setclientomnvar("ui_out_of_bounds_type", var_4);
  var_0 setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function vehicle_oob_mp_exitcallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3) {
    vehicle_oob_mp_exitcallbackforplayer(var_5);
  }
}

function vehicle_oob_mp_exitcallbackforplayer(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_out_of_bounds_type", 0);
  var_0 setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function vehicle_oob_mp_outoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_mp_getleveldata();
  var_3 = var_2.outoftimecallbacks[self.vehiclename];
  self[[var_3]]();
}

function vehicle_oob_mp_clearcallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_2 in var_0) {
    var_2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}