/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_collision.gsc
********************************************************/



#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_collision;

function vehicle_collision_init() {
  assertex(isDefined(level.vehicle), "vehicle_collision_init() called before vehicle_init().");

  if(issharedfuncdefined("vehicle_collision", "init")) {
    [[getsharedfunc("vehicle_collision", "init")]]();
  }

  level.var_f2a4f97f05f255f1 = getdvarint(@ "hash_72990c24f27d9759", 1) == 1;
  level.var_1a644e62fd06f9fb = getdvarint(@ "hash_51781d75e2ddda6a", 1) == 1;
  level.var_9d53e72e2ab97f5 = getdvarfloat(@ "hash_ba56da9845f4904f", 1);
  thread vehicle_collision_update();
}

function vehicle_collision_update() {
  level endon("game_ended");

  while(true) {
    level.var_29fa8b0c83a6cc5f = [];
    waitframe();
  }
}

function vehicle_collision_updateinstance(vehicle) {
  level endon("game_ended");
  assertex(vehicle isvehicle(), "vehicle_collision_updateInstance on an entity without a vehicleName.");
  data = vehicle_collision_getleveldataforvehicle(vehicle.vehiclename, 0, 1);

  if(!isDefined(data)) {
    return;
  }

  handleworldcollision = undefined;

  if(issharedfuncdefined(vehicle function_d93ec4635290febd(), "handleWorldCollision")) {
    handleworldcollision = getsharedfunc(vehicle function_d93ec4635290febd(), "handleWorldCollision");
  }

  vehicle notify("vehicle_collision_updateInstance");
  vehicle endon("vehicle_collision_updateInstance");
  vehicle endon("death");
  vehiclenum = vehicle getentitynumber();
  var_26170c216671748f = gettime() + 5000;
  vehicle vehphys_enablecollisioncallback(1);

  while(isDefined(vehicle)) {
    vehicle waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(isDefined(ent) && istrue(ent.iscrossbowbolt)) {
      continue;
    }

    function_593a829032a8c193(vehicle, ent);

    if(isDefined(vehicle.var_4b75a4ee07200d3b) && !ent isvehicle() && isDefined(ent.classname) && ent.classname != "worldspawn") {
      [[vehicle.var_4b75a4ee07200d3b]](vehicle, ent);
    }

    if(isDefined(handleworldcollision) && (!isDefined(ent) || !isDefined(ent.classname) || ent.classname == "worldspawn" || ent == vehicle)) {
      vehicle thread[[handleworldcollision]](position);
    }

    if(istrue(vehicle.var_9882cd795c6bfaa)) {
      continue;
    }

    if(gettime() < var_26170c216671748f) {
      continue;
    }

    if(isDefined(level.var_29fa8b0c83a6cc5f[vehiclenum]) || isDefined(ent) && isDefined(ent getentitynumber()) && ent isvehicle() && isDefined(level.var_29fa8b0c83a6cc5f[ent getentitynumber()])) {
      continue;
    }

    var_42a333103449127c = isDefined(ent) && isent(ent) && isDefined(ent getentitynumber()) && ent isvehicle() && ent != vehicle;
    level.var_29fa8b0c83a6cc5f[vehiclenum] = 1;

    if(var_42a333103449127c) {
      level.var_29fa8b0c83a6cc5f[ent getentitynumber()] = 1;
    }

    if(level.var_f2a4f97f05f255f1) {
      if(!var_42a333103449127c && isDefined(partenum) && partenum == 5) {
        level thread function_74ce9dc0a18ac393(vehicle, position, normal, normalspeed);
      } else {
        level thread function_10d733624bfda604(vehicle, ent, body0, body1, flag0, flag1, position, normal, normalspeed, partenum);
      }
    }

    if(var_42a333103449127c) {
      foreach(tempvehicle in [vehicle, ent]) {
        if(isDefined(tempvehicle.handleeventcallback)) {
          tempvehicle[[tempvehicle.handleeventcallback]](array_remove([vehicle, ent], tempvehicle)[0]);
        }

        leveldataforvehicle = vehicle_collision_getleveldataforvehicle(tempvehicle function_d93ec4635290febd(), 0, 1);

        if(!isDefined(leveldataforvehicle)) {
          continue;
        }

        if(isDefined(leveldataforvehicle.handleeventcallback)) {
          [[leveldataforvehicle.handleeventcallback]](vehicle, ent);
        }
      }
    }
  }
}

function private function_10d733624bfda604(vehicle, otherent, body0, body1, flag0, flag1, position, normal, normalspeed, partenum) {
  var_8d948973eddceb98 = function_67d6d7481d8ac827(vehicle);
  var_dfc13ccee5420527 = function_67d6d7481d8ac827(otherent);
  waitframe();
  var_ef174a6cfa1abcdd = function_3066f0dd7be2478c(vehicle);
  var_fdd958d93299102c = function_3066f0dd7be2478c(otherent);
  var_7b2c3e974fa33cf2 = isDefined(otherent) && otherent isvehicle() && function_89dc39dc11f3988c(otherent function_d93ec4635290febd()) && isDefined(function_29b4292c92443328(otherent function_d93ec4635290febd()).damage) && isDefined(vehicle);
  impulse = length(var_ef174a6cfa1abcdd - var_8d948973eddceb98) + length(var_dfc13ccee5420527 - var_fdd958d93299102c);
  var_2b2c1e04df704f3 = undefined;
  var_556fb0d021203d03 = undefined;

  if(!var_7b2c3e974fa33cf2) {
    if(isDefined(otherent) && otherent isvehicle() && isDefined(otherent.maxhealth)) {
      var_2b2c1e04df704f3 = otherent;
    } else if(isDefined(vehicle) && isDefined(vehicle.maxhealth)) {
      var_2b2c1e04df704f3 = vehicle;
    } else {
      return;
    }

    ref = var_2b2c1e04df704f3 function_d93ec4635290febd();

    if(!isDefined(ref)) {
      return;
    }

    if(!function_89dc39dc11f3988c(ref)) {
      return;
    }

    if(!level.var_1a644e62fd06f9fb && isDefined(var_2b2c1e04df704f3.riders) && var_2b2c1e04df704f3.riders.size > 0) {
      return;
    }

    alldata = function_29b4292c92443328(ref);

    if(!isDefined(alldata) || !isDefined(alldata.damage)) {
      return;
    }

    var_556fb0d021203d03 = alldata.damage;
    multiplier = 1;

    if(var_2b2c1e04df704f3 isfloating()) {
      multiplier = default_to(var_556fb0d021203d03.var_6c10b5dc07fd6459, 1);
    } else {
      multiplier = default_to(var_556fb0d021203d03.var_5c7f497b7ee6ee55, 1);
    }

    if(multiplier <= 0) {
      return;
    }

    impulse *= multiplier;
  }

  if(false) {
    debugaxis(position, vectortoangles(normal), impulse / 5, 1, 0, 400);
  }

  if(otherent isvehiclekillstreak()) {
    if(isDefined(otherent.var_96419179a661cf96)) {
      [[otherent.var_96419179a661cf96]](otherent, impulse);
      return;
    }
  }

  damagepercentage = 1;
  radius = 35;

  if(impulse > 650) {
    damagepercentage = 1;
    radius = 110;

    if(false) {
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(position, radius, 20, (1, 0, 0));
    }
  } else if(impulse > 450) {
    damagepercentage = 0.75;
    radius = 90;

    if(false) {
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(position, radius, 20, (1, 0, 1));
    }
  } else if(impulse > 275) {
    damagepercentage = 0.5;
    radius = 75;

    if(false) {
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(position, radius, 20, (0, 1, 0));
    }
  } else {
    return;
  }

  if(var_7b2c3e974fa33cf2) {
    basedata = function_29b4292c92443328(vehicle function_d93ec4635290febd()).damage;
    otherdata = function_29b4292c92443328(otherent function_d93ec4635290febd()).damage;
    baseclass = default_to(basedata.class, "medium");
    otherclass = default_to(otherdata.class, "medium");
    [baseweightratio, otherweightratio] = function_1ab37f5b6734e44d(baseclass, otherclass);
    [basespeedratio, otherspeedratio] = function_dcbd541c875c2d66(length(var_8d948973eddceb98), length(var_dfc13ccee5420527));
    basedamage = ter_op(isDefined(vehicle.maxhealth), vehicle.maxhealth, 1) * 2 * damagepercentage * basespeedratio * baseweightratio * function_53c04cefb8acf030(baseclass) * level.var_9d53e72e2ab97f5;
    otherdamage = ter_op(isDefined(otherent.maxhealth), otherent.maxhealth, 1) * 2 * damagepercentage * otherspeedratio * otherweightratio * function_53c04cefb8acf030(otherclass) * level.var_9d53e72e2ab97f5;
    vehicledriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
    otherdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(otherent);

    if(istrue(basedata.skipburndown)) {
      vehicle vehicle_damage_disablestatedamagefloor(1);
    }

    if(istrue(otherdata.skipburndown)) {
      otherent vehicle_damage_disablestatedamagefloor(1);
    }

    vehicle dodamage(int(basedamage), position, otherdriver, otherent, "MOD_CRUSH", otherent.objweapon);
    otherent dodamage(int(otherdamage), position, vehicledriver, vehicle, "MOD_CRUSH", vehicle.objweapon);
    vehicle vehicle_damage_disablestatedamagefloor(0);
    otherent vehicle_damage_disablestatedamagefloor(0);
    function_9c23735bf7534afa(vehicle, basedamage * 0.75, position, radius);
    function_9c23735bf7534afa(otherent, otherdamage * 0.75, position, radius);

    if(otherspeedratio > 0.9 && isDefined(vehicle.owner) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(otherent, vehicle.owner)) {
      vehicle.owner scripts\cp_mp\challenges::reportvehicleevent(vehicle, "high_speed_ram");
    } else if(basespeedratio > 0.9 && isDefined(otherent.owner) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, otherent.owner)) {
      otherent.owner scripts\cp_mp\challenges::reportvehicleevent(otherent, "high_speed_ram");
    }

    return;
  }

  damage = var_2b2c1e04df704f3.maxhealth * function_278754969816f33a(default_to(var_556fb0d021203d03.class, "medium"));

  if(istrue(var_2b2c1e04df704f3.var_6df468049c1f41dc)) {
    damage = var_2b2c1e04df704f3.maxhealth;
  }

  function_9c23735bf7534afa(var_2b2c1e04df704f3, damage * 0.75, position, radius);

  if(damage <= 0 || damagepercentage <= 0.5) {
    return;
  }

  if(istrue(var_556fb0d021203d03.skipburndown)) {
    var_2b2c1e04df704f3 vehicle_damage_disablestatedamagefloor(1);
  }

  var_2b2c1e04df704f3 dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");
  var_2b2c1e04df704f3 vehicle_damage_disablestatedamagefloor(0);
}

function private function_74ce9dc0a18ac393(vehicle, position, normal, timeinair) {
  var_a291b7ea9e74500f = -1 * ips_to_mph(vehicle vehicle_getvelocity()[2]);

  if(var_a291b7ea9e74500f < 15) {
    return;
  }

  data = function_29b4292c92443328(vehicle function_d93ec4635290febd()).damage;
  multiplier = default_to(data.falldamagemultiplier, 1);

  if(multiplier <= 0) {
    return;
  }

  timeinair *= multiplier;
  var_89134acb0056de26 = [2, 2.75, 3.5, 4.5, 10];

  if(getdvarint(@ "hash_12ca000dd2976ebc", 0)) {
    var_89134acb0056de26 = [4.5, 6, 7.5, 9.5, 15];
  }

  damagetier = 0;

  for(tier = var_89134acb0056de26.size; tier > 0; tier--) {
    var_7c462121dd5c5ae0 = var_89134acb0056de26[tier - 1];

    if(timeinair > var_7c462121dd5c5ae0) {
      damagetier = tier;
      break;
    }
  }

  if(!damagetier) {
    return;
  }

  if(false) {
    color = (1, 0, 0);

    switch (damagetier) {
      case 5:
        color = (1, 0, 0);
        break;
      case 4:
        color = (1, 1, 0);
        break;
      case 3:
        color = (0, 0, 1);
        break;
      case 2:
        color = (0, 1, 1);
        break;
      case 1:
        color = (0, 1, 0);
        break;
      default:
        break;
    }

    print3d(position, "<dev string:x1c>" + timeinair + "<dev string:x23>" + damagetier, color, 1, 1, 4000);
    debugaxis(position, vectortoangles(normal), 16, 1, 0, 4000);
  }

  damagepercentage = 1;
  wheeldamage = 50;
  wheelstodamage = 0;

  switch (damagetier) {
    case 5:
      damagepercentage = 1;
      wheeldamage = 250;
      wheelstodamage = 4;
      break;
    case 4:
      damagepercentage = 0.8;
      wheeldamage = 250;
      wheelstodamage = 4;
      break;
    case 3:
      damagepercentage = 0.6;
      wheeldamage = 150;
      wheelstodamage = 2;
      break;
    case 2:
      damagepercentage = 0.4;
      wheeldamage = 100;
      wheelstodamage = 1;
      break;
    case 1:
      damagepercentage = 0.2;
      wheeldamage = 40;
      wheelstodamage = 1;
      break;
    default:
      break;
  }

  function_ecdf1217e332c7d7(vehicle, wheeldamage, position, wheelstodamage);
  class = default_to(data.class, "medium");
  damage = function_a991a29602381df7(class) * damagepercentage * vehicle.maxhealth;

  if(istrue(data.skipburndown)) {
    vehicle vehicle_damage_disablestatedamagefloor(1);
  }

  vehicle dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");
  vehicle vehicle_damage_disablestatedamagefloor(0);

  if(timeinair > 5 && isDefined(vehicle.owner)) {
    vehicle.owner scripts\cp_mp\challenges::reportvehicleevent(vehicle, "vehicle_hang_time");
  }
}

function private function_593a829032a8c193(vehicle, ent) {
  if(!isDefined(ent)) {
    return;
  }

  ent = default_to(ent.cover, ent);

  if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover" && isDefined(ent.deletefunc) && !istrue(ent.ishitbyvehicle)) {
    ent.ishitbyvehicle = 1;
    ent thread[[ent.deletefunc]](undefined, 0, 0);
    return;
  }

  if(isDefined(ent.weapon_name) && ent.weapon_name == "deployed_decoy_mp") {
    ent thread[[ent.entdeletefunc]]();
    return;
  }

  if(is_equal(ent.classname, "misc_turret") || isDefined(ent.turretowner) && is_equal(ent.turretowner.classname, "misc_turret")) {
    if(ent.classname == "misc_turret") {
      turret = ent;
    } else if(isDefined(ent.turretowner) && is_equal(ent.turretowner.classname, "misc_turret")) {
      turret = ent.turretowner;
    }

    turret_parent = turret getlinkedparent();

    if(is_equal(turret_parent, vehicle)) {
      return;
    }

    if(isDefined(turret.hitbyvehiclefunc) && !istrue(turret.ishitbyvehicle)) {
      turret.ishitbyvehicle = 1;
      turret thread[[turret.hitbyvehiclefunc]](vehicle);
    }
  }
}

function function_3066f0dd7be2478c(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle isvehicle()) {
    return (0, 0, 0);
  }

  if(isDefined(vehicle.velocity)) {
    return vehicle.velocity;
  }

  return vehicle vehicle_getvelocity();
}

function function_6eb1fba746b72f46(vehicle) {
  return ips_to_mph(length(function_3066f0dd7be2478c(vehicle)));
}

function private function_67d6d7481d8ac827(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle isvehicle()) {
    return (0, 0, 0);
  }

  if(isDefined(vehicle.velocity)) {
    return vehicle.velocity;
  }

  return vehicle function_c33dba6864d01d35();
}

function private function_1ab37f5b6734e44d(damageclass1, damageclass2) {
  weight1 = function_a46de67ab094e684(damageclass1);
  weight2 = function_a46de67ab094e684(damageclass2);
  sum = weight1 + weight2;
  return [weight2 / sum, weight1 / sum];
}

function private function_dcbd541c875c2d66(speed1, speed2) {
  sum = speed1 + speed2;

  if(sum <= 0) {
    return [0.5, 0.5];
  }

  return [speed2 / sum, speed1 / sum];
}

function private function_a46de67ab094e684(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.1;
    case #"hash_d582c3286e5c390f":
      return 0.2;
    case #"hash_21622ca3ad06efb5":
      return 0.6;
    case #"hash_c71b112fe04823d6":
      return 1;
    case #"hash_53e0b558455f04c6":
      return 3;
    case #"hash_2453c9ffec9f5c20":
      return 5;
    case #"hash_e8ec392f4f2724e4":
      return 10;
    case #"hash_ee4a12a81f84ff3f":
      return 1000;
    default:
      return 1;
  }
}

function private function_278754969816f33a(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.2;
    case #"hash_d582c3286e5c390f":
      return 0.15;
    case #"hash_21622ca3ad06efb5":
      return 0.1;
    case #"hash_c71b112fe04823d6":
      return 0.08;
    case #"hash_53e0b558455f04c6":
      return 0.05;
    case #"hash_2453c9ffec9f5c20":
      return 0.02;
    case #"hash_e8ec392f4f2724e4":
      return 0;
    case #"hash_ee4a12a81f84ff3f":
      return 0;
    default:
      return 0;
  }
}

function private function_a991a29602381df7(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.6;
    case #"hash_d582c3286e5c390f":
      return 0.6;
    case #"hash_21622ca3ad06efb5":
      return 0.6;
    case #"hash_c71b112fe04823d6":
      return 0.6;
    case #"hash_53e0b558455f04c6":
      return 0.6;
    case #"hash_2453c9ffec9f5c20":
      return 0.5;
    case #"hash_e8ec392f4f2724e4":
      return 0.5;
    case #"hash_ee4a12a81f84ff3f":
      return 0;
    default:
      return 0.6;
  }
}

function private function_53c04cefb8acf030(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.6;
    case #"hash_d582c3286e5c390f":
      return 0.5;
    case #"hash_21622ca3ad06efb5":
      return 0.4;
    case #"hash_c71b112fe04823d6":
      return 0.3;
    case #"hash_53e0b558455f04c6":
      return 0.2;
    case #"hash_2453c9ffec9f5c20":
      return 0.15;
    case #"hash_e8ec392f4f2724e4":
      return 0.1;
    case #"hash_ee4a12a81f84ff3f":
      return 0;
    default:
      return 0.4;
  }
}

function vehicle_collision_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehicleref) || !isDefined(function_29b4292c92443328(vehicleref).damage) || !isDefined(function_29b4292c92443328(vehicleref).damage.class))) {
    data = undefined;

    if(!function_89dc39dc11f3988c(vehicleref)) {
      data = spawnStruct();
    } else {
      data = function_29b4292c92443328(vehicleref);
    }

    if(!isDefined(data.damage)) {
      data.damage = spawnStruct();
    }

    data.damage.ref = vehicleref;
    data.damage.class = "medium";
    level.var_a0b2c978ca57ffc5[vehicleref] = data;
  }

  if(function_89dc39dc11f3988c(vehicleref)) {
    return function_29b4292c92443328(vehicleref).damage;
  }
}

function vehicle_collision_ignorefutureevent(vehicle, othervehicle, duration) {
  vehicle endon("death");

  if(!isDefined(vehicle.vehcolignorelist)) {
    vehicle.vehcolignorelist = [];
  }

  othervehicleid = othervehicle getentitynumber();
  vehicle.vehcolignorelist[othervehicleid] = othervehicle;
  wait duration;

  if(isDefined(vehicle) && isDefined(vehicle.vehcolignorelist)) {
    vehicle.vehcolignorelist[othervehicleid] = undefined;
  }

  if(isDefined(vehicle) && isDefined(vehicle.vehcolignorelist) && vehicle.vehcolignorelist.size == 0) {
    vehicle.vehcolignorelist = undefined;
  }
}

function function_d88aed99025a81e4(vehicle, vehicletarget) {
  vehicletargetid = vehicletarget getentitynumber();

  if(isDefined(vehicle.vehcolignorelist) && isDefined(vehicle.vehcolignorelist.size) && vehicle.vehcolignorelist.size > 0) {
    if(isDefined(vehicle.vehcolignorelist[vehicletargetid])) {
      return true;
    }
  }

  return false;
}