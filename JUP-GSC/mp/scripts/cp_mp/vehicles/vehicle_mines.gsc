/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_mines.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\engine\utility;
#namespace vehicle_mines;

function vehicle_mines_init() {
  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  leveldata = spawnStruct();
  leveldata.minedata = [];
  level.vehicle.minetriggerdata = leveldata;

  if(issharedfuncdefined("vehicle_mines", "init")) {
    [[getsharedfunc("vehicle_mines", "init")]]();
  }
}

function vehicle_mines_getleveldata() {
  assertex(isDefined(level.vehicle.minetriggerdata), "<dev string:x52>");
  return level.vehicle.minetriggerdata;
}

function vehicle_mines_getleveldataforvehicle(vehicleref, create) {
  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(vehicleref, create);

  if((!isDefined(leveldataforvehicle) || !isDefined(leveldataforvehicle.frontextents)) && istrue(create)) {
    if(!isDefined(leveldataforvehicle)) {
      leveldataforvehicle = spawnStruct();
    }

    leveldataforvehicle.frontextents = 90;
    leveldataforvehicle.backextents = 115;
    leveldataforvehicle.leftextents = 38;
    leveldataforvehicle.rightextents = 38;
    leveldataforvehicle.bottomextents = 20;
    leveldataforvehicle.distancetobottom = 35;
    leveldataforvehicle.loscheckoffset = (0, 0, 37);
    scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicleref).damage = leveldataforvehicle;
  }

  return leveldataforvehicle;
}

function vehicle_mines_getleveldataformine(equipref, create) {
  leveldata = vehicle_mines_getleveldata();
  leveldataformine = leveldata.minedata[equipref];

  if(!isDefined(leveldataformine) && istrue(create)) {
    leveldataformine = spawnStruct();
    leveldataformine.radius = 10;
    leveldataformine.triggercallback = undefined;
    leveldata.minedata[equipref] = leveldataformine;
  }

  return leveldataformine;
}

function vehicle_mines_shouldvehicletriggermine(vehicle, mine) {
  if(!isDefined(vehicle) || !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() || !isDefined(vehicle.origin) || !isDefined(vehicle.angles)) {
    return false;
  }

  leveldataforvehicle = vehicle_mines_getleveldataforvehicle(vehicle.vehiclename);

  if(!isDefined(leveldataforvehicle) || !isDefined(leveldataforvehicle.frontextents) || !isDefined(leveldataforvehicle.leftextents) || !isDefined(leveldataforvehicle.rightextents) || !isDefined(leveldataforvehicle.loscheckoffset)) {
    return false;
  }

  if(!isDefined(mine) || !isDefined(mine.origin)) {
    return false;
  }

  var_c3f020620e873c83 = isDefined(mine.equipmentref) ? mine.equipmentref : mine.killstreakref;

  if(!isDefined(var_c3f020620e873c83)) {
    return false;
  }

  leveldataformine = vehicle_mines_getleveldataformine(var_c3f020620e873c83);

  if(!isDefined(leveldataformine)) {
    return false;
  }

  if(istrue(mine.exploding)) {
    return false;
  }

  if(lengthsquared(vehicle vehicle_getvelocity()) < 100) {
    if(lengthsquared(vehicle vehicle_getangularvelocity()) < 400) {
      return false;
    }
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return false;
  }

  if(istrue(vehicle.var_547a08a57461960d)) {
    return false;
  }

  frontoffsetvec = anglesToForward(vehicle.angles) * leveldataforvehicle.frontextents;
  backoffsetvec = anglesToForward(vehicle.angles) * -1 * leveldataforvehicle.frontextents;
  leftoffsetvec = anglestoright(vehicle.angles) * -1 * leveldataforvehicle.leftextents;
  rightoffsetvec = anglestoright(vehicle.angles) * leveldataforvehicle.rightextents;
  vehicleorigin = vehicle.origin + leveldataforvehicle.loscheckoffset;
  frontleft = vehicleorigin + frontoffsetvec + leftoffsetvec;
  frontright = vehicleorigin + frontoffsetvec + rightoffsetvec;
  backleft = vehicleorigin + backoffsetvec + leftoffsetvec;
  backright = vehicleorigin + backoffsetvec + rightoffsetvec;
  var_6bd8d3846ab52bf3 = (frontright - frontleft) * (1, 1, 0);
  var_29c1906132100543 = (frontleft - backleft) * (1, 1, 0);
  between = frontleft - mine.origin;
  betweendot = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_6bd8d3846ab52bf3)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  betweendot = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_29c1906132100543)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  var_15701247fdeed7f1 = (backleft - backright) * (1, 1, 0);
  var_430a35006e71a02c = (backright - frontright) * (1, 1, 0);
  between = backright - mine.origin;
  betweendot = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_15701247fdeed7f1)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  betweendot = vectordot(vectorNormalize(vehicle_mines_getnormal2d(var_430a35006e71a02c)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  between = vehicleorigin + anglestoup(vehicle.angles) * leveldataforvehicle.bottomextents - mine.origin;
  betweendot = vectordot(between, anglestoup(vehicle.angles));

  if(betweendot > leveldataforvehicle.distancetobottom) {
    return false;
  } else if(betweendot < 0) {
    return false;
  }

  return true;
}

function vehicle_mines_minetrigger(vehicle, mine) {
  var_c3f020620e873c83 = isDefined(mine.equipmentref) ? mine.equipmentref : mine.killstreakref;

  if(!isDefined(var_c3f020620e873c83)) {
    return;
  }

  leveldataformine = vehicle_mines_getleveldataformine(var_c3f020620e873c83);

  if(!isDefined(leveldataformine)) {
    return;
  }

  if(isDefined(leveldataformine.triggercallback)) {
    thread[[leveldataformine.triggercallback]](vehicle, mine);
  }

  leveldataforvehicle = vehicle_mines_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(leveldataforvehicle.triggercallback)) {
    thread[[leveldataforvehicle.triggercallback]](vehicle, mine);
  }

  if(issharedfuncdefined("vehicle_mines", "trigger")) {
    thread[[getsharedfunc("vehicle_mines", "trigger")]](vehicle, mine);
  }
}

function vehicle_mines_isfriendlytomine(mine) {
  friendlytomine = 0;

  if(level.teambased) {
    mineteam = mine.team;

    if(!isDefined(mineteam)) {
      if(isDefined(mine.owner)) {
        mineteam = mine.owner.team;
      }
    }

    if(isDefined(mineteam)) {
      friendlytomine = scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam(self, mineteam);
    }
  } else if(isDefined(mine.owner)) {
    friendlytomine = scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self, mine.owner);
  }

  if(!istrue(friendlytomine)) {
    if(isDefined(self.owner)) {
      if(level.teambased) {
        if(isDefined(mine.team) && self.owner.team == mine.team) {
          friendlytomine = 1;
        }
      } else if(isDefined(mine.owner) && self.owner == mine.owner) {
        friendlytomine = 1;
      }
    }
  }

  return friendlytomine;
}

function vehicle_mines_getnormal2d(vector) {
  return (vector[1], vector[0] * -1, 0);
}

function vehicle_mines_getloscheckcontents() {
  return physics_createcontents(["physicscontents_water", "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight"]);
}