/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_oob_mp.gsc
**************************************************/

function vehicle_oob_mp_registeroutoftimecallback(var0, var1) {
  var2 = vehicle_oob_mp_getleveldata();
  var2.outoftimecallbacks[var0] = var1;
}

function vehicle_oob_mp_registerinstance(var0) {
  scripts\mp\outofbounds::registerentforoob(var0, "vehicle");
}

function vehicle_oob_mp_deregisterinstance(var0) {
  scripts\mp\outofbounds::deregisterentforoob(var0);
}

function vehicle_oob_mp_clearoob(var0, var1) {
  scripts\mp\outofbounds::clearoob(var0, var1);
}

function vehicle_oob_mp_init() {
  var0 = spawnStruct();
  var0.outoftimecallbacks = [];
  level.vehicle.oob = var0;
  scripts\mp\outofbounds::registeroobentercallback("vehicle", &vehicle_oob_mp_entercallback);
  scripts\mp\outofbounds::registeroobexitcallback("vehicle", &vehicle_oob_mp_exitcallback);
  scripts\mp\outofbounds::registerooboutoftimecallback("vehicle", &vehicle_oob_mp_outoftimecallback);
  scripts\mp\outofbounds::registeroobclearcallback("vehicle", &vehicle_oob_mp_clearcallback);
}

function vehicle_oob_mp_getleveldata() {
  return level.vehicle.oob;
}

function vehicle_oob_mp_entercallback(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var5 in var3) {
    vehicle_oob_mp_entercallbackforplayer(var5, undefined, undefined, var2);
  }
}

function vehicle_oob_mp_entercallbackforplayer(var0, var1, var2, var3) {
  var4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(var3) && var3 == "restricted") {
    var4 = 2;
  }

  var0 setclientomnvar("ui_out_of_bounds_type", var4);
  var0 setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function vehicle_oob_mp_exitcallback(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var5 in var3) {
    vehicle_oob_mp_exitcallbackforplayer(var5);
  }
}

function vehicle_oob_mp_exitcallbackforplayer(var0, var1, var2, var3) {
  var0 setclientomnvar("ui_out_of_bounds_type", 0);
  var0 setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function vehicle_oob_mp_outoftimecallback(var0, var1) {
  var2 = vehicle_oob_mp_getleveldata();
  var3 = var2.outoftimecallbacks[self.vehiclename];
  self[[var3]]();
}

function vehicle_oob_mp_clearcallback() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var2 in var0) {
    var2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}