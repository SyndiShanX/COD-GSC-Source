/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\vehicle_common.gsc
***********************************************/

function requestentervehicle(var0, var1, var2, var3) {
  self.vehiclerequest = spawnStruct();
  self.vehiclerequest.vehicle = var0;
  self.vehiclerequest.chosenvehicleposition = var2;
  self.vehiclerequest.chosenvehicleanimpos = var3;
  self.vehiclerequest.spawninvehicle = var1;
}

function waitforentervehicle() {
  var0 = scripts\engine\utility::ref_143af("entervehicle", "death", "long_death", "failedentervehicle");

  if(var0 != "entervehicle") {
    return false;
  }

  return true;
}

function waitforarrivedatvehicle() {
  self endon("death");
  self endon("long_death");

  while(isDefined(self.vehiclerequest) || isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.startedenteringvehicle) && !istrue(self._blackboard.enteredvehicle) && !istrue(self._blackboard.invehicle)) {
    waitframe();
  }
}

function entervehicle(var0, var1, var2, var3) {
  requestentervehicle(var0, var1, var2, var3);
  return waitforentervehicle();
}

function requestexitvehicle() {
  self.exitvehiclerequested = 1;
}

function waitforexitvehicle() {
  self endon("death");
  self endon("long_death");

  while(!istrue(self.hasexitedvehicle)) {
    waitframe();
  }

  self.hasexitedvehicle = undefined;
}

function exitvehicle() {
  requestexitvehicle();
  waitforexitvehicle();
}

function hasvehicle() {
  return isDefined(self.vehiclerequest) || isDefined(self._blackboard.currentvehicle);
}

function setuprope() {
  self._blackboard.vehiclesetuprope = 1;
}

function exitingvehicle() {
  if(scripts\common\utility::issp()) {
    return;
  }

  self._blackboard.currentvehicle.get_allowed_population = 0;
  thread onriotshieldstow_force();
}

function onriotshieldstow_force() {
  self endon("death");
  waitframe();
  self.get_allowed_population = 1;
}