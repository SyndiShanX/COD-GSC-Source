/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_mines.gsc
***********************************************/

vehicle_mines_init() {
  var_0 = spawnStruct();
  var_0.vehicledata = [];
  var_0.minedata = [];
  level.vehicle.minetriggerdata = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_830C0ECECA434BB11B56F5D6D23759E6", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_830C0ECECA434BB11B56F5D6D23759E6", "_encstr_88C5055208731B")]]();
}

vehicle_mines_getleveldata() {
  return level.vehicle.minetriggerdata;
}

vehicle_mines_getleveldataforvehicle(var_0, var_1) {
  var_2 = vehicle_mines_getleveldata();
  var_3 = var_2.vehicledata[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_3.frontextents = 90;
    var_3.backextents = 115;
    var_3.leftextents = 38;
    var_3.rightextents = 38;
    var_3.bottomextents = 20;
    var_3.distancetobottom = 35;
    var_3.loscheckoffset = (0, 0, 37);
    var_3.triggercallback = undefined;
    var_2.vehicledata[var_0] = var_3;
  }

  return var_3;
}

vehicle_mines_getleveldataformine(var_0, var_1) {
  var_2 = vehicle_mines_getleveldata();
  var_3 = var_2.minedata[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_3.radius = 10;
    var_3.triggercallback = undefined;
    var_2.minedata[var_0] = var_3;
  }

  return var_3;
}

vehicle_mines_shouldvehicletriggermine(var_0, var_1) {
  var_2 = vehicle_mines_getleveldataforvehicle(var_0.vehiclename);

  if(!isDefined(var_2))
    return 0;

  var_3 = vehicle_mines_getleveldataformine(var_1.equipmentref);

  if(!isDefined(var_3))
    return 0;

  if(istrue(var_1.exploding))
    return 0;

  if(lengthsquared(var_0 vehicle_getvelocity()) < 100) {
    if(lengthsquared(var_0 vehicle_getangularvelocity()) < 400)
      return 0;
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicledestroyed())
    return 0;

  var_4 = anglesToForward(var_0.angles) * var_2.frontextents;
  var_5 = anglesToForward(var_0.angles) * -1 * var_2.frontextents;
  var_6 = anglestoright(var_0.angles) * -1 * var_2.leftextents;
  var_7 = anglestoright(var_0.angles) * var_2.rightextents;
  var_8 = var_0.origin + var_4 + var_6;
  var_9 = var_0.origin + var_4 + var_7;
  var_10 = var_0.origin + var_5 + var_6;
  var_11 = var_0.origin + var_5 + var_7;
  var_12 = (var_9 - var_8) * (1, 1, 0);
  var_13 = (var_8 - var_10) * (1, 1, 0);
  var_14 = var_8 - var_1.origin;
  var_15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_12)), var_14);

  if(var_15 > var_3.radius)
    return 0;

  var_15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_13)), var_14);

  if(var_15 > var_3.radius)
    return 0;

  var_16 = (var_10 - var_11) * (1, 1, 0);
  var_17 = (var_11 - var_9) * (1, 1, 0);
  var_14 = var_11 - var_1.origin;
  var_15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_16)), var_14);

  if(var_15 > var_3.radius)
    return 0;

  var_15 = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_17)), var_14);

  if(var_15 > var_3.radius)
    return 0;

  var_14 = var_0.origin + anglestoup(var_0.angles) * var_2.bottomextents - var_1.origin;
  var_15 = vectordot(var_14, anglestoup(var_0.angles));

  if(var_15 > var_2.distancetobottom)
    return 0;
  else if(var_15 < 0)
    return 0;

  return 1;
}

vehicle_mines_minetrigger(var_0, var_1) {
  var_2 = vehicle_mines_getleveldataformine(var_1.equipmentref);

  if(isDefined(var_2.triggercallback))
    thread[[var_2.triggercallback]](var_0, var_1);

  var_3 = vehicle_mines_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_3.triggercallback))
    thread[[var_3.triggercallback]](var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_830C0ECECA434BB11B56F5D6D23759E6", "_encstr_8F5C086405E70FBA4B4A"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_830C0ECECA434BB11B56F5D6D23759E6", "_encstr_8F5C086405E70FBA4B4A")]](var_0, var_1);
}

vehicle_mines_isfriendlytomine(var_0) {
  if(level.teambased) {
    var_1 = var_0.team;

    if(!isDefined(var_1)) {
      if(isDefined(var_0.owner))
        var_1 = var_0.owner.team;
    }

    if(isDefined(var_1))
      return scripts\cp_mp\vehicles\vehicle::_id_141BA(self, var_1);
  } else if(isDefined(var_0.owner))
    return scripts\cp_mp\vehicles\vehicle::_id_141B9(self, var_0.owner);

  return 0;
}

vehicle_mines_getnormal2d(var_0) {
  return (var_0[1], var_0[0] * -1, 0);
}

vehicle_mines_getloscheckcontents() {
  return physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);
}