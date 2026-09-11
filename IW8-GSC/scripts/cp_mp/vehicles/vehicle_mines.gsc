/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_mines.gsc
****************************************************/

function vehicle_mines_init() {
  var0 = spawnStruct();
  var0.vehicledata = [];
  var0.minedata = [];
  level.vehicle.minetriggerdata = var0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "init")]]();
    return;
  }
}

function vehicle_mines_getleveldata() {
  return level.vehicle.minetriggerdata;
}

function vehicle_mines_getleveldataforvehicle(var0, var1) {
  var2 = vehicle_mines_getleveldata();
  var3 = var2.vehicledata[var0];

  if(!isDefined(var3) && istrue(var1)) {
    var3 = spawnStruct();
    var3.frontextents = 90;
    var3.backextents = 115;
    var3.leftextents = 38;
    var3.rightextents = 38;
    var3.bottomextents = 20;
    var3.distancetobottom = 35;
    var3.loscheckoffset = (0, 0, 37);
    var3.triggercallback = undefined;
    var2.vehicledata[var0] = var3;
  }

  return var3;
}

function vehicle_mines_getleveldataformine(var0, var1) {
  var2 = vehicle_mines_getleveldata();
  var3 = var2.minedata[var0];

  if(!isDefined(var3) && istrue(var1)) {
    var3 = spawnStruct();
    var3.radius = 10;
    var3.triggercallback = undefined;
    var2.minedata[var0] = var3;
  }

  return var3;
}

function vehicle_mines_shouldvehicletriggermine(var0, var1) {
  var2 = vehicle_mines_getleveldataforvehicle(var0.vehiclename);

  if(!isDefined(var2)) {
    return false;
  }

  var3 = vehicle_mines_getleveldataformine(var1.equipmentref);

  if(!isDefined(var3)) {
    return false;
  }

  if(istrue(var1.exploding)) {
    return false;
  }

  if(lengthsquared(var0 vehicle_getvelocity()) < 100) {
    if(lengthsquared(var0 vehicle_getangularvelocity()) < 400) {
      return false;
    }
  }

  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return false;
  }

  var4 = anglesToForward(var0.angles) * var2.frontextents;
  var5 = anglesToForward(var0.angles) * -1 * var2.frontextents;
  var6 = anglestoright(var0.angles) * -1 * var2.leftextents;
  var7 = anglestoright(var0.angles) * var2.rightextents;
  var8 = var0.origin + var4 + var6;
  var9 = var0.origin + var4 + var7;
  var10 = var0.origin + var5 + var6;
  var11 = var0.origin + var5 + var7;
  var12 = (var9 - var8) * (1, 1, 0);
  var13 = (var8 - var10) * (1, 1, 0);
  var14 = var8 - var1.origin;
  var15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var12)), var14);

  if(var15 > var3.radius) {
    return false;
  }

  var15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var13)), var14);

  if(var15 > var3.radius) {
    return false;
  }

  var16 = (var10 - var11) * (1, 1, 0);
  var17 = (var11 - var9) * (1, 1, 0);
  var14 = var11 - var1.origin;
  var15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var16)), var14);

  if(var15 > var3.radius) {
    return false;
  }

  var15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var17)), var14);

  if(var15 > var3.radius) {
    return false;
  }

  var14 = var0.origin + anglestoup(var0.angles) * var2.bottomextents - var1.origin;
  var15 = vectordot(var14, anglestoup(var0.angles));

  if(var15 > var2.distancetobottom) {
    return false;
  } else if(var15 < 0) {
    return false;
  }

  return true;
}

function vehicle_mines_minetrigger(var0, var1) {
  var2 = vehicle_mines_getleveldataformine(var1.equipmentref);

  if(isDefined(var2.triggercallback)) {
    GscBinSkip1(0x74, var2.triggercallback, var0, var1);
  }

  var3 = vehicle_mines_getleveldataforvehicle(var0.vehiclename);

  if(isDefined(var3.triggercallback)) {
    GscBinSkip1(0x74, var3.triggercallback, var0, var1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "trigger")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "trigger"), var0, var1);
  }
}

function vehicle_mines_isfriendlytomine(var0) {
  if(level.teambased) {
    var1 = var0.team;

    if(!isDefined(var1)) {
      if(isDefined(var0.owner)) {
        var1 = var0.owner.team;
      }
    }

    if(isDefined(var1)) {
      return scripts\cp_mp\vehicles\vehicle::ref_141ba(self, var1);
    }
  } else if(isDefined(var0.owner)) {
    return scripts\cp_mp\vehicles\vehicle::ref_141b9(self, var0.owner);
  }

  return 0;
}

function vehicle_mines_getnormal2d(var0) {
  return (var0[1], var0[0] * -1, 0);
}

function vehicle_mines_getloscheckcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_glass", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight"]);
}