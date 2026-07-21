/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\vehicle.gsc
***********************************************/

getseatoriginangles(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 gettagorigin(var_2);
  var_5 = var_0 gettagangles(var_2);
  var_6 = getstartorigin(var_4, var_5, var_1);
  var_7 = getstartangles(var_4, var_5, var_1);
  var_8 = getmovedelta(var_1, 0.0, 1.0);
  var_9 = getangledelta3d(var_1, 0.0, 1.0)[1];
  var_3.targetorigin = rotatevector(var_8, var_7) + var_6;
  var_3.targetangles = (var_7[0], angleclamp(var_7[1] + var_9), var_7[2]);
  return var_3;
}

handlevehiclerequest() {
  if(!isDefined(self.vehiclerequest.vehicle) || isDefined(self._blackboard.currentvehicle) || !isalive(self.vehiclerequest.vehicle)) {
    self.vehiclerequest = undefined;
    return;
  }

  self._blackboard.currentvehicle = self.vehiclerequest.vehicle;
  self._blackboard.chosenvehicleposition = self.vehiclerequest.chosenvehicleposition;
  self._blackboard.chosenvehicleanimpos = self.vehiclerequest.chosenvehicleanimpos;
  self._blackboard.currentvehicleanimalias = self.vehiclerequest.vehicle.vehicleanimalias;
  self setavoidanceignoreent(self._blackboard.currentvehicle);
  self.disablepistol = 1;
  scripts\asm\asm_bb::bb_requeststance("stand");
  self._blackboard.currentvehicle gettagorigin(self._blackboard.chosenvehicleanimpos.sittag, 0, 0, 0);

  if(istrue(self.vehiclerequest.spawninvehicle))
    setinvehicle();
  else {
    var_0 = archetypegetrandomalias(self._blackboard.currentvehicleanimalias, "get_in_vehicle", scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position), scripts\asm\asm::asm_isfrantic());
    var_1 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, "get_in_vehicle", var_0);
    var_2 = self._blackboard.currentvehicle gettagorigin(self._blackboard.chosenvehicleanimpos.sittag);
    var_3 = self._blackboard.currentvehicle gettagangles(self._blackboard.chosenvehicleanimpos.sittag);
    var_4 = archetypegetrandomalias(self._blackboard.currentvehicleanimalias, "vehicle_idle", scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position), scripts\asm\asm::asm_isfrantic());
    var_5 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, "vehicle_idle", var_4);
    var_6 = getseatoriginangles(self._blackboard.currentvehicle, var_5, self._blackboard.chosenvehicleanimpos.sittag);
    var_7 = getstartorigin(var_6.targetorigin, var_6.targetangles, var_1);
    var_8 = getstartangles(var_6.targetorigin, var_6.targetangles, var_1);
    var_9 = getclosestpointonnavmesh(var_7);
    self._blackboard.chosenvehicleposition.origin = var_9;
    self._blackboard.chosenvehicleposition.angles = var_8;
    self.asm.customdata.arrivalangles = self._blackboard.chosenvehicleposition.angles;
    self._blackboard.isrunningtovehicle = 1;
    self._blackboard.vehiclestate = 1;
    self notify("movingtovehicle");
  }

  self.vehiclerequest = undefined;
}

movetovehicle_init(var_0) {
  self notify("stop_going_to_node");
}

movetovehicle(var_0) {
  if(!isalive(self._blackboard.currentvehicle)) {
    self notify("failedentervehicle");
    self._blackboard.vehiclestate = 0;
    self._blackboard.currentvehicle = undefined;
    self.disablepistol = 0;
    self clearavoidanceignoreent();
    return anim.failure;
  }

  self setbtgoalpos(1, self._blackboard.chosenvehicleposition.origin);
  self setbtgoalRadius(1, 32);

  if(distance2dsquared(self.origin, self._blackboard.chosenvehicleposition.origin) < 1024) {
    self._blackboard.movedtovehicle = 1;
    self._blackboard.vehiclestate = 2;
    self notify("boarding_vehicle");
  }

  return anim.running;
}

movetovehicle_terminate(var_0) {
  self._blackboard.isrunningtovehicle = undefined;
}

setinvehicle() {
  self._blackboard.invehicle = 1;
  self._blackboard.vehiclestate = 4;
  self._blackboard.startedenteringvehicle = undefined;
  self notify("entervehicle");
}

entervehicle(var_0) {
  if(istrue(self._blackboard.enteredvehicle)) {
    self clearbtgoal(1);
    setinvehicle();
    self._blackboard.enteredvehicle = undefined;
    self._blackboard.movedtovehicle = undefined;
  }

  return anim.running;
}

vehicleidle(var_0) {
  if(isvehicleexitrequested())
    startexitvehicle();

  if(isDefined(self._blackboard.currentvehicle) && istrue(self._blackboard.currentvehicle.vehicledisableweaponreloading))
    scripts\aitypes\combat::reload_cheatammo();

  scripts\aitypes\combat::updatewhizby(var_0);
  return anim.running;
}

vehiclecanshoot(var_0) {
  if(istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && isDefined(self.enemy))
    return anim.success;

  return anim.failure;
}

isvehicleexitrequested() {
  if(isDefined(self._blackboard.currentvehicle) && self._blackboard.currentvehicle vehicle_getspeed() > 1)
    return 0;

  return istrue(self.exitvehiclerequested);
}

startexitvehicle() {
  self._blackboard.exitingvehicle = 1;
  self._blackboard.vehiclestate = 3;
  self.exitvehiclerequested = undefined;
}

exitvehicle(var_0) {
  if(!isDefined(self._blackboard.exitingvehicle)) {
    self._blackboard.vehiclestate = 0;
    self._blackboard.linkedtovehicle = undefined;
    self._blackboard.currentvehicle = undefined;
    self._blackboard.invehicle = undefined;
    self.hasexitedvehicle = 1;
    self.disablepistol = 0;
    self.asm.customdata.arrivalangles = undefined;
    self clearavoidanceignoreent();
    return anim.success;
  }

  return anim.running;
}

getbsmstate(var_0) {
  if(!isDefined(self._blackboard.vehiclestate))
    self._blackboard.vehiclestate = 0;

  if(self._blackboard.vehiclestate != 0 && !isDefined(self._blackboard.currentvehicle)) {
    self._blackboard.vehiclestate = 0;
    self._blackboard.linkedtovehicle = undefined;
    self._blackboard.currentvehicle = undefined;
    self._blackboard.invehicle = undefined;
    self.hasexitedvehicle = 1;
    self.disablepistol = 0;
    self.asm.customdata.arrivalangles = undefined;
    self clearavoidanceignoreent();
    self clearbtgoal(1);
    return "";
  }

  if(self._blackboard.vehiclestate == 0 && isDefined(self.vehiclerequest))
    handlevehiclerequest();

  switch (self._blackboard.vehiclestate) {
    case 1:
      return "MoveToVehicle";
    case 2:
      return "EnterVehicle";
    case 3:
      return "ExitVehicle";
    case 4:
      return "VehicleIdle";
  }

  return "";
}