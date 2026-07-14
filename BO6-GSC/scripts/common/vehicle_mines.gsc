/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_mines.gsc
********************************************/

#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\engine\utility;
#namespace vehicle_mines;

function init() {
  assert(isDefined(level.vehicle), "<dev string:x24>");
  leveldata = spawnStruct();
  leveldata.minedata = [];
  level.vehicle.minetriggerdata = leveldata;

  if(utility::issharedfuncdefined(#"vehicle_mines", #"init")) {
    [[utility::getsharedfunc(#"vehicle_mines", #"init")]]();
  }
}

function get_level_data() {
  assert(isDefined(level.vehicle.minetriggerdata), "<dev string:x5b>");
  return level.vehicle.minetriggerdata;
}

function get_data(vehicleref, create) {
  leveldataforvehicle = vehicle_damage::get_data(vehicleref, create);

  if(!(isDefined(leveldataforvehicle) && isDefined(leveldataforvehicle.frontextents)) && create) {
    if(!isDefined(leveldataforvehicle)) {
      leveldataforvehicle = spawnStruct();
    }

    leveldataforvehicle.frontextents = 90;
    leveldataforvehicle.backextents = 115;
    leveldataforvehicle.leftextents = 38;
    leveldataforvehicle.rightextents = 38;
    leveldataforvehicle.bottomextents = 40;
    leveldataforvehicle.topextents = 40;
    leveldataforvehicle.loscheckoffset = (0, 0, 37);
    vehicle::get_data(vehicleref).damage = leveldataforvehicle;
  }

  return leveldataforvehicle;
}

function function_fcfe63b165cc9a8(vehicleref, data) {
  leveldataforvehicle = vehicle_damage::get_data(vehicleref);

  if(isDefined(leveldataforvehicle)) {
    leveldataforvehicle.frontextents = data.frontextents;
    leveldataforvehicle.backextents = data.backextents;
    leveldataforvehicle.leftextents = data.leftextents;
    leveldataforvehicle.rightextents = data.rightextents;
    leveldataforvehicle.bottomextents = data.bottomextents;
    leveldataforvehicle.topextents = data.topextents;
    leveldataforvehicle.loscheckoffset = data.loscheckoffset;
    vehicle::get_data(vehicleref).damage = leveldataforvehicle;
  }
}

function function_143a1628400aebb1(equipref, create) {
  leveldata = get_level_data();
  leveldataformine = leveldata.minedata[equipref];

  if(!isDefined(leveldataformine) && create) {
    leveldataformine = spawnStruct();
    leveldataformine.radius = 10;
    leveldataformine.triggercallback = undefined;
    leveldata.minedata[equipref] = leveldataformine;
  }

  return leveldataformine;
}

function function_60d53a1a3bd504cd(vehicle, mine) {
  if(!vehicle vehicle::is_vehicle()) {
    return false;
  }

  if(vehicle.var_1c98f583383286ef) {
    return false;
  }

  leveldataforvehicle = get_data(vehicle vehicle::get_ref()) ?? get_data(vehicle.targetname);

  if(!isDefined(leveldataforvehicle)) {
    return false;
  }

  leveldataformine = function_143a1628400aebb1(mine.equipmentref);

  if(!isDefined(leveldataformine)) {
    return false;
  }

  if(mine.exploding) {
    return false;
  }

  if(lengthsquared(vehicle vehicle_getvelocity()) < 100) {
    if(lengthsquared(vehicle vehicle_getangularvelocity()) < 400) {
      return false;
    }
  }

  if(vehicle vehicle::is_destroyed()) {
    return false;
  }

  forward = anglesToForward(vehicle.angles);
  right = anglestoright(vehicle.angles);
  frontoffsetvec = forward * leveldataforvehicle.frontextents;
  backoffsetvec = forward * -1 * leveldataforvehicle.backextents;
  leftoffsetvec = right * -1 * leveldataforvehicle.leftextents;
  rightoffsetvec = right * leveldataforvehicle.rightextents;
  vehicleorigin = vehicle.origin + leveldataforvehicle.loscheckoffset;
  frontleft = vehicleorigin + frontoffsetvec + leftoffsetvec;
  frontright = vehicleorigin + frontoffsetvec + rightoffsetvec;
  backleft = vehicleorigin + backoffsetvec + leftoffsetvec;
  backright = vehicleorigin + backoffsetvec + rightoffsetvec;
  var_fd16c62c79f9ed28 = (frontright - frontleft) * (1, 1, 0);
  var_d67fbff6f2d6dd52 = (frontleft - backleft) * (1, 1, 0);
  between = frontleft - mine.origin;
  betweendot = vectordot(vectorNormalize(function_5acc9514819ccd43(var_fd16c62c79f9ed28)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  betweendot = vectordot(vectorNormalize(function_5acc9514819ccd43(var_d67fbff6f2d6dd52)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  var_d00c432a6fea236c = (backleft - backright) * (1, 1, 0);
  var_45bdc73e7060352f = (backright - frontright) * (1, 1, 0);
  between = backright - mine.origin;
  betweendot = vectordot(vectorNormalize(function_5acc9514819ccd43(var_d00c432a6fea236c)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  betweendot = vectordot(vectorNormalize(function_5acc9514819ccd43(var_45bdc73e7060352f)), between);

  if(betweendot > leveldataformine.radius) {
    return false;
  }

  up = anglestoup(vehicle.angles);
  vehiclebottom = vehicleorigin - up * leveldataforvehicle.bottomextents;
  var_c32265c39f79f347 = mine.origin - vehiclebottom;
  betweendot = vectordot(var_c32265c39f79f347, up);

  if(betweendot > leveldataforvehicle.bottomextents + leveldataforvehicle.topextents) {
    return false;
  } else if(betweendot < 0) {
    return false;
  }

  return true;
}

function trigger_mine(vehicle, mine) {
  leveldataformine = function_143a1628400aebb1(mine.equipmentref);

  if(isDefined(leveldataformine.triggercallback)) {
    thread[[leveldataformine.triggercallback]](vehicle, mine);
  }

  leveldataforvehicle = get_data(vehicle vehicle::get_ref());

  if(isDefined(leveldataforvehicle.triggercallback)) {
    thread[[leveldataforvehicle.triggercallback]](vehicle, mine);
  }

  if(utility::issharedfuncdefined(#"vehicle_mines", #"trigger")) {
    thread[[utility::getsharedfunc(#"vehicle_mines", #"trigger")]](vehicle, mine);
  }
}

function function_56d954c642e8acea(mine) {
  friendlytomine = 0;

  if(level.teambased) {
    mineteam = mine.team;

    if(!isDefined(mineteam)) {
      if(isDefined(mine.owner)) {
        mineteam = mine.owner.team;
      }
    }

    if(isDefined(mineteam)) {
      friendlytomine = vehicle::function_977daeae4e2f0e30(self, mineteam);
    }
  } else if(isDefined(mine.owner)) {
    friendlytomine = vehicle::function_8957ae4cd340941c(self, mine.owner);
  }

  if(!friendlytomine) {
    if(isDefined(self.owner)) {
      if(level.teambased) {
        if(self.owner.team == mine.team) {
          friendlytomine = 1;
        }
      } else if(self.owner == mine.owner) {
        friendlytomine = 1;
      }
    }
  }

  return friendlytomine;
}

function function_5acc9514819ccd43(vector) {
  return (vector[1], vector[0] * -1, 0);
}

function function_70d072049d790ed7() {
  return physics_createcontents(["physicscontents_water", "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight"]);
}