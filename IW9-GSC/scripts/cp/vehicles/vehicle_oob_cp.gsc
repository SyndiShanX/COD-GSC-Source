/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_oob_cp.gsc
**************************************************/

vehicle_oob_cp_registeroutoftimecallback(vehiclename, callback) {
  _id_962A30A9BB8C0F09 = vehicle_oob_cp_getleveldata();
  _id_962A30A9BB8C0F09.outoftimecallbacks[vehiclename] = callback;
}

vehicle_oob_cp_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.outoftimecallbacks = [];
  level.vehicle.oob = _id_962A30A9BB8C0F09;
  scripts\cp\cp_outofbounds::registeroobentercallback("vehicle", ::vehicle_oob_cp_entercallback);
  scripts\cp\cp_outofbounds::registeroobexitcallback("vehicle", ::vehicle_oob_cp_exitcallback);
  scripts\cp\cp_outofbounds::registerooboutoftimecallback("vehicle", ::vehicle_oob_cp_outoftimecallback);
  scripts\cp\cp_outofbounds::registeroobclearcallback("vehicle", ::vehicle_oob_cp_clearcallback);
}

vehicle_oob_cp_getleveldata() {
  return level.vehicle.oob;
}

vehicle_oob_cp_entercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(_id_F85572CD5F6117C6 in occupants)
  vehicle_oob_cp_entercallbackforplayer(_id_F85572CD5F6117C6);
}

vehicle_oob_cp_entercallbackforplayer(player, _id_44E306D53285E1F8, _id_93F5DB7E81311353) {
  player setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

vehicle_oob_cp_exitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(_id_F85572CD5F6117C6 in occupants)
  vehicle_oob_cp_exitcallbackforplayer(_id_F85572CD5F6117C6);
}

vehicle_oob_cp_exitcallbackforplayer(player, _id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  player setclientomnvar("ui_out_of_bounds_countdown", 0);
}

vehicle_oob_cp_outoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  _id_962A30A9BB8C0F09 = vehicle_oob_cp_getleveldata();
  callback = _id_962A30A9BB8C0F09.outoftimecallbacks[self.vehiclename];
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(_id_F85572CD5F6117C6 in occupants)
  _id_F85572CD5F6117C6.shouldskiplaststand = 1;

  self[[callback]]();
}

vehicle_oob_cp_clearcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(_id_F85572CD5F6117C6 in occupants)
  _id_F85572CD5F6117C6 setclientomnvar("ui_out_of_bounds_countdown", 0);
}