/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_oob_mp.gsc
***********************************************/

vehicle_oob_mp_registeroutoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_mp_getleveldata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

vehicle_oob_mp_registerinstance(var_0) {
  scripts\mp\outofbounds::registerentforoob(var_0, "_encstr_9A50080BA7292FFA0DA2");
}

vehicle_oob_mp_deregisterinstance(var_0) {
  scripts\mp\outofbounds::deregisterentforoob(var_0);
}

vehicle_oob_mp_clearoob(var_0, var_1) {
  scripts\mp\outofbounds::clearoob(var_0, var_1);
}

vehicle_oob_mp_init() {
  var_0 = spawnStruct();
  var_0.outoftimecallbacks = [];
  level.vehicle.oob = var_0;
  scripts\mp\outofbounds::registeroobentercallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_mp_entercallback);
  scripts\mp\outofbounds::registeroobexitcallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_mp_exitcallback);
  scripts\mp\outofbounds::registerooboutoftimecallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_mp_outoftimecallback);
  scripts\mp\outofbounds::registeroobclearcallback("_encstr_9A50080BA7292FFA0DA2", ::vehicle_oob_mp_clearcallback);
}

vehicle_oob_mp_getleveldata() {
  return level.vehicle.oob;
}

vehicle_oob_mp_entercallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3)
  vehicle_oob_mp_entercallbackforplayer(var_5, undefined, undefined, var_2);
}

vehicle_oob_mp_entercallbackforplayer(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "_encstr_B81904B04E6B" && isDefined(var_3) && var_3 == "_encstr_83E00BE4CA6ED1272DC68E5632")
    var_4 = 2;

  var_0 setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", var_4);
  var_0 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
}

vehicle_oob_mp_exitcallback(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_5 in var_3)
  vehicle_oob_mp_exitcallbackforplayer(var_5);
}

vehicle_oob_mp_exitcallbackforplayer(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
  var_0 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

vehicle_oob_mp_outoftimecallback(var_0, var_1) {
  var_2 = vehicle_oob_mp_getleveldata();
  var_3 = var_2.outoftimecallbacks[self.vehiclename];
  self[[var_3]]();
}

vehicle_oob_mp_clearcallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  foreach(var_2 in var_0)
  var_2 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}