/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\vehicle_common.gsc
***********************************************/

requestentervehicle(var_0, var_1, var_2, var_3) {
  self.vehiclerequest = spawnStruct();
  self.vehiclerequest.vehicle = var_0;
  self.vehiclerequest.chosenvehicleposition = var_2;
  self.vehiclerequest.chosenvehicleanimpos = var_3;
  self.vehiclerequest.spawninvehicle = var_1;
}

waitforentervehicle() {
  var_0 = scripts\engine\utility::_id_143AF("_encstr_91DC0DACB9A395399DAC0D4B1B8D95", "_encstr_AD75063D571AE108", "_encstr_93530B91C713410FAFEAC86852", "_encstr_842F13A2D7C820851D3DBD8DAD38E3927A332FBAC2");

  if(var_0 != "_encstr_91DC0DACB9A395399DAC0D4B1B8D95")
    return 0;

  return 1;
}

waitforarrivedatvehicle() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");

  while(isDefined(self.vehiclerequest) || isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.startedenteringvehicle) && !istrue(self._blackboard.enteredvehicle) && !istrue(self._blackboard.invehicle))
    waitframe();
}

entervehicle(var_0, var_1, var_2, var_3) {
  requestentervehicle(var_0, var_1, var_2, var_3);
  return waitforentervehicle();
}

requestexitvehicle() {
  self.exitvehiclerequested = 1;
}

waitforexitvehicle() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");

  while(!istrue(self.hasexitedvehicle))
    waitframe();

  self.hasexitedvehicle = undefined;
}

exitvehicle() {
  requestexitvehicle();
  waitforexitvehicle();
}

hasvehicle() {
  return isDefined(self.vehiclerequest) || isDefined(self._blackboard.currentvehicle);
}

setuprope() {
  self._blackboard.vehiclesetuprope = 1;
}

exitingvehicle() {
  if(scripts\common\utility::issp()) {
    return;
  }
  self._blackboard.currentvehicle.get_allowed_population = 0;
  self._blackboard.currentvehicle thread onriotshieldstow_force();
}

onriotshieldstow_force() {
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  self.get_allowed_population = 1;
}