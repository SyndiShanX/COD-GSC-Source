/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_oob_cp.gsc
***********************************************/

vehicle_oob_cp_registeroutoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_cp_getleveldata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

vehicle_oob_cp_registerinstance(var_0) {
  scripts\cp\cp_outofbounds::registerentforoob(var_0, "_encstr_9A50080BA7292FFA0DA2");
}

vehicle_oob_cp_deregisterinstance(var_0) {
  scripts\cp\cp_outofbounds::deregisterentforoob(var_0);
}

vehicle_oob_cp_clearoob(var_0, var_1) {
  scripts\cp\cp_outofbounds::clearoob(var_0, var_1);
}

vehicle_oob_cp_init() {
  var_0 = spawnStruct();
  var_0.outoftimecallbacks = [];
  level.vehicle.oob = var_0;
  scripts\cp\cp_outofbounds::registeroobentercallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_cp_entercallback);
  scripts\cp\cp_outofbounds::registeroobexitcallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_cp_exitcallback);
  scripts\cp\cp_outofbounds::registerooboutoftimecallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_cp_outoftimecallback);
  scripts\cp\cp_outofbounds::registeroobclearcallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_cp_clearcallback);
}

vehicle_oob_cp_getleveldata() {
  return level.vehicle.oob;
}

vehicle_oob_cp_entercallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_4 in var_2)
  vehicle_oob_cp_entercallbackforplayer(var_4);
}

vehicle_oob_cp_entercallbackforplayer(var_0, var_1, var_2) {
  var_0 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
}

vehicle_oob_cp_exitcallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3)
  vehicle_oob_cp_exitcallbackforplayer(var_5);
}

vehicle_oob_cp_exitcallbackforplayer(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

vehicle_oob_cp_outoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_cp_getleveldata();
  var_3 = var_2.outoftimecallbacks[self.vehiclename];
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_6 in var_4)
  var_6.shouldskiplaststand = 1;

  self[[var_3]]();
}

vehicle_oob_cp_clearcallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_2 in var_0)
  var_2 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}