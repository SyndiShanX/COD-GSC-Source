/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\vehicle.gsc
***********************************************/

function getseatoriginangles(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = var0 gettagorigin(var2);
  var5 = var0 gettagangles(var2);
  var6 = getstartorigin(var4, var5, var1);
  var7 = getstartangles(var4, var5, var1);
  var8 = getmovedelta(var1, 0, 1);
  var9 = getangledelta3d(var1, 0, 1)[1];
  var3.targetorigin = rotatevector(var8, var7) + var6;
  var3.targetangles = (var7[0], angleclamp(var7[1] + var9), var7[2]);
  return var3;
}

function handlevehiclerequest() {
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

  if(istrue(self.vehiclerequest.spawninvehicle)) {
    setinvehicle();
  } else {
    var0 = archetypegetrandomalias(self._blackboard.currentvehicleanimalias, "get_in_vehicle", scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position), scripts\asm\asm::asm_isfrantic());
    var1 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, "get_in_vehicle", var0);
    var2 = self._blackboard.currentvehicle gettagorigin(self._blackboard.chosenvehicleanimpos.sittag);
    var3 = self._blackboard.currentvehicle gettagangles(self._blackboard.chosenvehicleanimpos.sittag);
    var4 = archetypegetrandomalias(self._blackboard.currentvehicleanimalias, "vehicle_idle", scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position), scripts\asm\asm::asm_isfrantic());
    var5 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, "vehicle_idle", var4);
    var6 = getseatoriginangles(self._blackboard.currentvehicle, var5, self._blackboard.chosenvehicleanimpos.sittag);
    var7 = getstartorigin(var6.targetorigin, var6.targetangles, var1);
    var8 = getstartangles(var6.targetorigin, var6.targetangles, var1);
    var9 = getclosestpointonnavmesh(var7);
    self._blackboard.chosenvehicleposition.origin = var9;
    self._blackboard.chosenvehicleposition.angles = var8;
    self.asm.customdata.arrivalangles = self._blackboard.chosenvehicleposition.angles;
    self._blackboard.isrunningtovehicle = 1;
    self._blackboard.vehiclestate = 1;
    self notify("movingtovehicle");
  }

  self.vehiclerequest = undefined;
}

function movetovehicle_init(var0) {
  self notify("stop_going_to_node");
}

function movetovehicle(var0) {
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

function movetovehicle_terminate(var0) {
  self._blackboard.isrunningtovehicle = undefined;
}

function setinvehicle() {
  self._blackboard.invehicle = 1;
  self._blackboard.vehiclestate = 4;
  self._blackboard.startedenteringvehicle = undefined;
  self notify("entervehicle");
}

function entervehicle(var0) {
  if(istrue(self._blackboard.enteredvehicle)) {
    self clearbtgoal(1);
    setinvehicle();
    self._blackboard.enteredvehicle = undefined;
    self._blackboard.movedtovehicle = undefined;
  }

  return anim.running;
}

function vehicleidle(var0) {
  if(isvehicleexitrequested()) {
    startexitvehicle();
  }

  if(isDefined(self._blackboard.currentvehicle) && istrue(self._blackboard.currentvehicle.vehicledisableweaponreloading)) {
    scripts\aitypes\combat::reload_cheatammo();
  }

  scripts\aitypes\combat::updatewhizby(var0);
  return anim.running;
}

function vehiclecanshoot(var0) {
  if(istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && isDefined(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}

function isvehicleexitrequested() {
  if(isDefined(self._blackboard.currentvehicle) && self._blackboard.currentvehicle vehicle_getspeed() > 1) {
    return false;
  }

  return istrue(self.exitvehiclerequested);
}

function startexitvehicle() {
  self._blackboard.exitingvehicle = 1;
  self._blackboard.vehiclestate = 3;
  self.exitvehiclerequested = undefined;
}

function exitvehicle(var0) {
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

function getbsmstate(var0) {
  if(!isDefined(self._blackboard.vehiclestate)) {
    self._blackboard.vehiclestate = 0;
  }

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

  if(self._blackboard.vehiclestate == 0 && isDefined(self.vehiclerequest)) {
    handlevehiclerequest();
  }

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