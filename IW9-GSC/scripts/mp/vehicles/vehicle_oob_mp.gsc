/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_oob_mp.gsc
**************************************************/

vehicle_oob_mp_registeroutoftimecallback(vehiclename, callback) {
  _id_962A30A9BB8C0F09 = vehicle_oob_mp_getleveldata();
  _id_962A30A9BB8C0F09.outoftimecallbacks[vehiclename] = callback;
}

vehicle_oob_mp_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.outoftimecallbacks = [];
  level.vehicle.oob = _id_962A30A9BB8C0F09;
  scripts\mp\outofbounds::registerooboutoftimecallback("vehicle", ::vehicle_oob_mp_outoftimecallback);
  scripts\mp\outofbounds::registeroobclearcallback("vehicle", ::vehicle_oob_mp_clearcallback);
}

vehicle_oob_mp_getleveldata() {
  return level.vehicle.oob;
}

vehicle_oob_mp_outoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  _id_962A30A9BB8C0F09 = vehicle_oob_mp_getleveldata();
  callback = _id_962A30A9BB8C0F09.outoftimecallbacks[self.vehiclename];
  self._id_A8F4BB03B366AA80 = 1;
  self[[callback]]();
}

vehicle_oob_mp_clearcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(_id_F85572CD5F6117C6 in occupants)
  _id_F85572CD5F6117C6 setclientomnvar("ui_out_of_bounds_countdown", 0);
}