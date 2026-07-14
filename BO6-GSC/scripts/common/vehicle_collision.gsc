/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_collision.gsc
************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace vehicle_collision;

function init() {
  assert(isDefined(level.vehicle), "<dev string:x24>");

  if(utility::issharedfuncdefined(#"vehicle_collision", #"init")) {
    [[utility::getsharedfunc(#"vehicle_collision", #"init")]]();
  }

  level.var_b69d75a0873a5870 = getdvarint(@ "hash_72990c24f27d9759", 1) == 1;
  level.var_d444ccbc31b10404 = getdvarint(@ "hash_51781d75e2ddda6a", 1) == 1;
  level.var_fa176214d87ef2fc = getdvarfloat(@ "hash_ba56da9845f4904f", 1);
  thread update();
}

function private update() {
  level endon("game_ended");

  while(true) {
    level.var_a4174766ac7188e6 = [];
    waitframe();
  }
}

function update_instance(vehicle) {
  level endon("game_ended");
  assert(vehicle vehicle::is_vehicle(), "<dev string:x5f>");
  data = get_data(vehicle vehicle::get_ref(), 0, 1);

  if(!isDefined(data)) {
    return;
  }

  handleWorldCollision = undefined;

  if(utility::issharedfuncdefined(vehicle vehicle::get_ref(), #"handleWorldCollision")) {
    handleWorldCollision = utility::getsharedfunc(vehicle vehicle::get_ref(), #"handleWorldCollision");
  }

  vehicle notify("vehicle_collision_updateInstance");
  vehicle endon("vehicle_collision_updateInstance");
  vehicle endon("death");
  vehiclenum = vehicle getentitynumber();
  var_9a4868e46f325cd0 = gettime() + 5000;
  vehicle vehphys_enablecollisioncallback(1);

  while(isDefined(vehicle)) {
    vehicle waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent);

    if(isDefined(ent) && ent.iscrossbowbolt) {
      continue;
    }

    if(vehicle vehicle::ishelicopter() && (!(isDefined(ent) && isDefined(ent.classname)) || ent.classname == "worldspawn")) {
      vehicle thread function_9a12b1f4777c3cb3();
    }

    function_9b8e86b29db35414(vehicle, ent);

    if(isDefined(vehicle.var_c971b9fb0896d7c6) && !ent vehicle::is_vehicle() && isDefined(ent.classname) && ent.classname != "worldspawn") {
      [[vehicle.var_c971b9fb0896d7c6]](vehicle, ent);
    }

    if(isDefined(handleWorldCollision) && (!(isDefined(ent) && isDefined(ent.classname)) || ent.classname == "worldspawn" || ent == vehicle)) {
      vehicle thread[[handleWorldCollision]](position);
    }

    if(vehicle.var_300686ebe3a78e39) {
      continue;
    }

    if(gettime() < var_9a4868e46f325cd0) {
      continue;
    }

    if(isDefined(level.var_a4174766ac7188e6[vehiclenum]) || isDefined(ent) && isDefined(ent getentitynumber()) && ent vehicle::is_vehicle() && isDefined(level.var_a4174766ac7188e6[ent getentitynumber()])) {
      continue;
    }

    var_5e3b5b2143fc9c3d = isent(ent) && isDefined(ent getentitynumber()) && ent vehicle::is_vehicle() && ent != vehicle;
    level.var_a4174766ac7188e6[vehiclenum] = 1;

    if(var_5e3b5b2143fc9c3d) {
      level.var_a4174766ac7188e6[ent getentitynumber()] = 1;
      ent notify("veh_hit_veh", self);
    }

    if(level.var_b69d75a0873a5870) {
      if(!var_5e3b5b2143fc9c3d && !vehicle vehicle::ishelicopter() && normal[2] > 0.9) {
        level thread function_ac5b0f729eb13c08(vehicle, position, normal);
      } else {
        level thread function_1bad3c9d42a3bf11(vehicle, ent, body0, body1, flag0, flag1, position, normal, normalspeed);
      }
    }

    if(var_5e3b5b2143fc9c3d) {
      foreach(tempvehicle in [vehicle, ent]) {
        if(isDefined(tempvehicle.handleeventcallback)) {
          tempvehicle[[tempvehicle.handleeventcallback]](arrayremove([vehicle, ent], tempvehicle)[0]);
        }

        leveldataforvehicle = get_data(tempvehicle vehicle::get_ref(), 0, 1);

        if(!isDefined(leveldataforvehicle)) {
          continue;
        }

        if(isDefined(leveldataforvehicle.handleeventcallback)) {
          [[leveldataforvehicle.handleeventcallback]](vehicle, ent, position);
        }
      }
    }
  }
}

function private function_1bad3c9d42a3bf11(vehicle, otherent, body0, body1, flag0, flag1, position, normal, normalspeed) {
  level endon("game_ended");

  if(vehicle.var_d095febef1095bf9 && vehicle.var_d095febef1095bf9 + 300 > gettime()) {
    return;
  }

  var_4528dc04bda9ec95 = function_5d778229abbf7183(vehicle);
  var_4cdc7c696999f528 = function_5d778229abbf7183(otherent);
  waitframe();

  if(!isDefined(vehicle)) {
    return;
  }

  var_366bdf70365083e6 = get_velocity(vehicle);
  var_244de96e6b3df4ed = get_velocity(otherent);
  var_e226e0a127eb0853 = isDefined(otherent) && otherent vehicle::is_vehicle() && vehicle::has_data(otherent vehicle::get_ref()) && isDefined(vehicle::get_data(otherent vehicle::get_ref()).damage) && isDefined(vehicle);
  impulse = length(var_366bdf70365083e6 - var_4528dc04bda9ec95) + length(var_4cdc7c696999f528 - var_244de96e6b3df4ed);
  var_14af063128b4f612 = undefined;
  var_bf3fa5b592aa573e = undefined;

  if(var_e226e0a127eb0853) {
    handle_stability([vehicle, otherent], [var_4528dc04bda9ec95, var_4cdc7c696999f528], normal);
  }

  if(!var_e226e0a127eb0853) {
    if(isDefined(otherent) && otherent vehicle::is_vehicle() && isDefined(otherent.maxhealth)) {
      var_14af063128b4f612 = otherent;
    } else if(isDefined(vehicle) && isDefined(vehicle.maxhealth)) {
      var_14af063128b4f612 = vehicle;
    } else {
      return;
    }

    ref = var_14af063128b4f612 vehicle::get_ref();

    if(!isDefined(ref)) {
      return;
    }

    if(!vehicle::has_data(ref)) {
      return;
    }

    if(!level.var_d444ccbc31b10404 && isDefined(var_14af063128b4f612.riders) && var_14af063128b4f612.riders.size > 0) {
      return;
    }

    alldata = vehicle::get_data(ref);

    if(!(isDefined(alldata) && isDefined(alldata.damage))) {
      return;
    }

    var_bf3fa5b592aa573e = alldata.damage;
    var_429d5e520209434f = vehicle.var_429d5e520209434f;
    multiplier = 1;

    if(var_14af063128b4f612 vehicle::is_floating()) {
      multiplier = var_429d5e520209434f.var_998a69fa223f881a ?? var_bf3fa5b592aa573e.var_998a69fa223f881a ?? 1;
    } else {
      multiplier = var_429d5e520209434f.var_efa813d230db5cdc ?? var_bf3fa5b592aa573e.var_efa813d230db5cdc ?? 1;
    }

    if(multiplier <= 0) {
      return;
    }

    impulse *= multiplier;
  }

  if(false) {
    debugaxis(position, vectortoangles(normal), impulse / 5, 1, 0, 400);
  }

  if(isDefined(otherent.var_514172427acb20c1)) {
    vehicle[[otherent.var_514172427acb20c1]](otherent, impulse);
    return;
  }

  damagepercentage = 0;
  radius = 35;

  if(impulse > 650) {
    damagepercentage = 1;
    radius = 110;

    if(false) {
      sphere(position, radius, (1, 0, 0), 0, 400);
    }
  } else if(impulse > 450) {
    damagepercentage = 0.75;
    radius = 90;

    if(false) {
      sphere(position, radius, (1, 0, 1), 0, 400);
    }
  } else if(impulse > 250) {
    damagepercentage = 0.5;
    radius = 75;

    if(false) {
      sphere(position, radius, (0, 1, 0), 0, 400);
    }
  }

  if(var_e226e0a127eb0853) {
    if(damagepercentage < 0.5) {
      return;
    }

    basedata = vehicle::get_data(vehicle vehicle::get_ref()).damage;
    otherdata = vehicle::get_data(otherent vehicle::get_ref()).damage;
    baseclass = basedata.class ?? "medium";
    otherclass = otherdata.class ?? "medium";
    [baseweightratio, otherweightratio] = function_22707821bd11e2bd(baseclass, otherclass);
    [basespeedratio, otherspeedratio] = function_5232395ba95c6896(length(var_4528dc04bda9ec95), length(var_4cdc7c696999f528));
    basespeedratio = clamp(basespeedratio, 0.2, 0.8);
    otherspeedratio = clamp(otherspeedratio, 0.2, 0.8);
    vehiclemaxhealth = (vehicle.maxhealth ?? 1) - (vehicle.healthbuffer ?? 0);
    otherentmaxhealth = (otherent.maxhealth ?? 1) - (otherent.healthbuffer ?? 0);
    var_add95e283856b5c9 = vehicle.var_429d5e520209434f.var_df106d0e92fab581 ?? basedata.var_df106d0e92fab581 ?? 1;
    var_8328cd590754592c = otherent.var_429d5e520209434f.var_df106d0e92fab581 ?? otherdata.var_df106d0e92fab581 ?? 1;
    basemultiplier = var_add95e283856b5c9 * 2 * damagepercentage * basespeedratio * baseweightratio * level.var_fa176214d87ef2fc;
    othermultiplier = var_8328cd590754592c * 2 * damagepercentage * otherspeedratio * otherweightratio * level.var_fa176214d87ef2fc;
    basedamage = vehiclemaxhealth * function_b7337cb1631d8998(baseclass) * basemultiplier;
    otherdamage = otherentmaxhealth * function_b7337cb1631d8998(otherclass) * othermultiplier;
    vehicledriver = vehicle_occupancy::get_driver(vehicle);
    otherdriver = vehicle_occupancy::get_driver(otherent);

    if(basedata.skipburndown) {
      vehicle vehicle_damage::function_658976b407a5b2e1(1);
    }

    if(otherdata.skipburndown) {
      otherent vehicle_damage::function_658976b407a5b2e1(1);
    }

    vehicle dodamage(int(basedamage), position, otherdriver, otherent, "MOD_CRUSH", otherent.objweapon);
    otherent dodamage(int(otherdamage), position, vehicledriver, vehicle, "MOD_CRUSH", vehicle.objweapon);

    if(isDefined(vehicle)) {
      vehicle vehicle_damage::function_658976b407a5b2e1(0);
    }

    if(isDefined(otherent)) {
      otherent vehicle_damage::function_658976b407a5b2e1(0);
    }

    vehicle_damage::function_eb89abdecc0cacc0(vehicle, basedamage * 0.75, position, radius);
    vehicle_damage::function_eb89abdecc0cacc0(otherent, otherdamage * 0.75, position, radius);

    if(isDefined(vehicle)) {
      vehicle.var_d095febef1095bf9 = gettime();
    }

    if(isDefined(otherent)) {
      otherent.var_d095febef1095bf9 = gettime();
    }

    return;
  }

  var_429d5e520209434f = vehicle.var_429d5e520209434f;

  if(var_429d5e520209434f.var_7b3d457e74c528c3) {
    damage = impulse;
  } else {
    damage = (var_14af063128b4f612.maxhealth - (var_14af063128b4f612.healthbuffer ?? 0)) * function_f4e935cfd9063a8a(var_bf3fa5b592aa573e.class ?? "medium");
  }

  if(var_14af063128b4f612.var_937263baf40c151) {
    damage = var_14af063128b4f612.maxhealth;
  }

  vehicle_damage::function_eb89abdecc0cacc0(var_14af063128b4f612, damage * 0.75, position, radius);

  if(damage <= 0 || impulse <= (vehicle.var_429d5e520209434f.var_5ff053fe35a3561c ?? alldata.damage.var_5ff053fe35a3561c)) {
    return;
  }

  if(var_bf3fa5b592aa573e.skipburndown) {
    var_14af063128b4f612 vehicle_damage::function_658976b407a5b2e1(1);
  }

  var_14af063128b4f612 dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");

  if(isDefined(var_14af063128b4f612)) {
    var_14af063128b4f612 vehicle_damage::function_658976b407a5b2e1(0);
    var_14af063128b4f612.var_d095febef1095bf9 = gettime();
  }
}

function private handle_stability(vehicles, var_3eba1586ed890796, normal) {
  foreach(index, hitvehicle in vehicles) {
    if(hitvehicle isscriptable()) {
      if(!hitvehicle getscriptablehaspart("stability")) {
        continue;
      }
    } else {
      continue;
    }

    if(vehicle_occupancy::get_all_occupants(hitvehicle).size > 0) {
      continue;
    }

    othervehicle = vehicles[1 - index];
    data = vehicle::get_data(hitvehicle vehicle::get_ref());
    var_4cdc7c696999f528 = var_3eba1586ed890796[1 - index];
    var_d466040bf789c15d = abs(vectordot(var_4cdc7c696999f528, normal));
    var_470e203ce88b45f7 = 1;

    if(othervehicle.code_classname == "script_vehicle") {
      var_470e203ce88b45f7 = othervehicle function_8d5e756e5cd572ae("mass");
    }

    if(var_d466040bf789c15d >= (data.var_2a3667dbc24f2786 ?? 0) && var_470e203ce88b45f7 >= (data.var_da8458e7145339c3 ?? 0)) {
      hitvehicle utility::function_7c10ea82c1e305b8("stability", "unstable");
    }
  }
}

function private function_ac5b0f729eb13c08(vehicle, position, normal) {
  data = vehicle::get_data(vehicle vehicle::get_ref()).damage;
  fallspeed = -1 * function_5d778229abbf7183(vehicle)[2] * 0.056818;
  multiplier = vehicle.var_429d5e520209434f.falldamagemultiplier ?? data.falldamagemultiplier ?? 1;

  if(multiplier <= 0) {
    return;
  }

  var_5a168b79b608557f = [25, 35, 45, 55, 65];
  damagetier = 0;

  for(tier = var_5a168b79b608557f.size; tier > 0; tier--) {
    var_ec7df50de2f847 = var_5a168b79b608557f[tier - 1];

    if(fallspeed > var_ec7df50de2f847) {
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

    print3d(position, "<dev string:xa7>" + damagetier, color, 1, 1, 4000);
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

  vehicle_damage::function_95120e6392cd14f1(vehicle, wheeldamage, position, wheelstodamage);
  class = data.class ?? "medium";
  damage = function_ef056874538d5fe7(class) * damagepercentage * multiplier * vehicle.maxhealth;

  if(data.skipburndown) {
    vehicle vehicle_damage::function_658976b407a5b2e1(1);
  }

  vehicle dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");
  vehicle vehicle_damage::function_658976b407a5b2e1(0);
}

function private function_9b8e86b29db35414(vehicle, ent) {
  if(!isDefined(ent)) {
    return;
  }

  ent = ent.cover ?? ent;

  if(ent.equipmentref == "equip_tac_cover" && isDefined(ent.deletefunc) && !ent.ishitbyvehicle) {
    ent.ishitbyvehicle = 1;
    ent thread[[ent.deletefunc]](undefined, 0, 0);
    return;
  }

  if(ent.weapon_name == "deployed_decoy_mp") {
    ent thread[[ent.entdeletefunc]]();
    return;
  }

  if(ent.isriotshield) {
    ent thread[[ent.deletefunc]](ent.hintobj, ent.owner, ent, 1);
    return;
  }

  if(ent.classname == "misc_turret" || isDefined(ent.turretowner) && ent.turretowner.classname == "misc_turret") {
    if(ent.classname == "misc_turret") {
      turret = ent;
    } else if(isDefined(ent.turretowner) && ent.turretowner.classname == "misc_turret") {
      turret = ent.turretowner;
    }

    turret_parent = turret getlinkedparent();

    if(turret_parent == vehicle) {
      return;
    }

    if(isDefined(turret.hitbyvehiclefunc) && !turret.ishitbyvehicle) {
      turret.ishitbyvehicle = 1;
      turret thread[[turret.hitbyvehiclefunc]](vehicle);
    }
  }
}

function function_9a12b1f4777c3cb3() {
  self notify("5ec251ad539a2218");
  self endon("5ec251ad539a2218");
  self endon("death");

  while(true) {
    if(isDefined(vehicle_occupancy::get_driver(self))) {
      break;
    }

    if(self vehicle_isonground()) {
      self setrotorsactive(0);
      break;
    }

    waitframe();
  }
}

function get_velocity(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static()) {
    return (0, 0, 0);
  }

  var_7237854e3be197ca = vehicle.velocity;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return vehicle vehicle_getvelocity();
}

function get_speed(vehicle) {
  return length(get_velocity(vehicle)) * 0.056818;
}

function private function_5d778229abbf7183(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static()) {
    return (0, 0, 0);
  }

  var_7237854e3be197ca = vehicle.velocity;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return vehicle function_19e2beab469c788e();
}

function private function_22707821bd11e2bd(damageclass1, damageclass2) {
  weight1 = function_1b971a2963c4d589(damageclass1);
  weight2 = function_1b971a2963c4d589(damageclass2);
  sum = weight1 + weight2;
  return [weight2 / sum, weight1 / sum];
}

function private function_5232395ba95c6896(speed1, speed2) {
  sum = speed1 + speed2;

  if(sum <= 0) {
    return [0.5, 0.5];
  }

  return [speed2 / sum, speed1 / sum];
}

function private function_1b971a2963c4d589(damageclass) {
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

function private function_f4e935cfd9063a8a(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.065;
    case #"hash_d582c3286e5c390f":
      return 0.05;
    case #"hash_21622ca3ad06efb5":
      return 0.03;
    case #"hash_c71b112fe04823d6":
      return 0.025;
    case #"hash_53e0b558455f04c6":
      return 0.015;
    case #"hash_2453c9ffec9f5c20":
      return 0.005;
    case #"hash_e8ec392f4f2724e4":
      return 0;
    case #"hash_ee4a12a81f84ff3f":
      return 0;
    default:
      return 0;
  }
}

function private function_ef056874538d5fe7(damageclass) {
  switch (damageclass) {
    case #"hash_d2a55c7ac538641b":
      return 0.25;
    case #"hash_d582c3286e5c390f":
      return 0.25;
    case #"hash_21622ca3ad06efb5":
      return 0.25;
    case #"hash_c71b112fe04823d6":
      return 0.25;
    case #"hash_53e0b558455f04c6":
      return 0.25;
    case #"hash_2453c9ffec9f5c20":
      return 0.2;
    case #"hash_e8ec392f4f2724e4":
      return 0.2;
    case #"hash_ee4a12a81f84ff3f":
      return 0;
    default:
      return 0.25;
  }
}

function private function_b7337cb1631d8998(damageclass) {
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

function get_data(vehicleref, create, var_e6c819f806ce2c86) {
  if(create && (!vehicle::has_data(vehicleref) || !isDefined(vehicle::get_data(vehicleref).damage) || !isDefined(get_data(vehicleref).damage.class))) {
    data = undefined;

    if(!vehicle::has_data(vehicleref)) {
      data = spawnStruct();
    } else {
      data = vehicle::get_data(vehicleref);
    }

    if(!isDefined(data.damage)) {
      data.damage = spawnStruct();
    }

    data.damage.ref = vehicleref;
    data.damage.class = "medium";
    vehicle::add_data(vehicleref, data);
  }

  if(vehicle::has_data(vehicleref)) {
    return vehicle::get_data(vehicleref).damage;
  }
}

function function_b456610deaad175(vehicle, othervehicle, duration) {
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

function function_91f418a1d64293b4(vehicle, vehicletarget) {
  vehicletargetid = vehicletarget getentitynumber();

  if(vehicle.vehcolignorelist.size > 0) {
    if(isDefined(vehicle.vehcolignorelist[vehicletargetid])) {
      return true;
    }
  }

  return false;
}

function function_419e88170394a188(vehicle, player) {
  if(vehicle_occupancy::function_8266feb1ae1c46bd(vehicle, player)) {
    playerwasinlaststand = istrue(player.inlaststand);
    var_ca02bfdd611a56f4 = player.health;

    if(isDefined(vehicle.objweapon)) {
      level.overrideobituarymod = "MOD_EXPLOSIVE";
    }

    attacker = undefined;

    if(isDefined(vehicle.streakinfo)) {
      attacker = vehicle.owner ?? player;
    } else {
      attacker = vehicle_occupancy::get_driver(vehicle) ?? player;
    }

    player dodamage(1000, vehicle.origin, attacker, vehicle, "MOD_CRUSH", vehicle.objweapon);
    level.overrideobituarymod = undefined;

    if(!isalive(player)) {
      return true;
    }

    if(!playerwasinlaststand && player.inlaststand) {
      return true;
    }

    if(var_ca02bfdd611a56f4 > player.health) {
      return true;
    }
  }

  return false;
}

function function_e3bc60c772acd609(vehicle, player) {
  player endon("disconnect");
  player notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player endon("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player.vehiclecollisionignorearray = [];
  player.vehiclecollisionignorearray["inflictor"] = vehicle;
  player.vehiclecollisionignorearray["meansOfDeath"] = "MOD_CRUSH";
  function_790f8f52eaa61daf(player);
  thread function_c9850217a7d398f3(player);
}

function private function_790f8f52eaa61daf(player) {
  player endon("death");

  if(isDefined(level.vehicle.occupancy) && isDefined(level.vehicle) && isDefined(level.vehicle.occupancy.var_f706d2ddeaba4c7)) {
    wait level.vehicle.occupancy.var_f706d2ddeaba4c7;
    return;
  }

  wait 4;
}

function function_c9850217a7d398f3(player) {
  player notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player.vehiclecollisionignorearray = undefined;
}

function function_898c68dd6412f983(inflictor, victim, meansofdeath, objweapon) {
  if(!isDefined(victim.vehiclecollisionignorearray)) {
    return false;
  }

  if(!isDefined(inflictor)) {
    return false;
  }

  if(!(inflictor === victim.vehiclecollisionignorearray["inflictor"])) {
    return false;
  }

  if(isDefined(meansofdeath) && !(meansofdeath === victim.vehiclecollisionignorearray["meansOfDeath"])) {
    return false;
  }

  return true;
}

function function_dc1f303123867705(inflictor, victim, smeansofdeath) {
  if(!(smeansofdeath == "MOD_CRUSH")) {
    return false;
  }

  if(!(isDefined(victim) && isDefined(victim.origin))) {
    return false;
  }

  if(!(isDefined(inflictor.origin) && isDefined(inflictor) && isDefined(inflictor.angles))) {
    return false;
  }

  if(!inflictor vehicle::is_vehicle() || inflictor vehicle::get_ref() == "cargo_train" || !isent(inflictor) || inflictor.classname != "script_vehicle") {
    return false;
  }

  vehicleref = inflictor vehicle::get_ref();

  if(!vehicle::has_data(vehicleref)) {
    return false;
  }

  data = vehicle::get_data(vehicleref);

  if(data.canfly || data.isboat) {
    return false;
  }

  extents = data.occupancy.exitextents;

  if(!isDefined(extents)) {
    return false;
  }

  if(!inflictor vehicle_isonground()) {
    return false;
  }

  if(inflictor vehicle_getspeed() < 1) {
    return false;
  }

  if(!(isDefined(extents["front"]) && isDefined(extents["back"]))) {
    return false;
  }

  forward = anglesToForward(inflictor.angles);
  moving = inflictor vehicle_getvelocity();
  between = math::anglebetweenvectors(forward, moving);
  movingforward = undefined;

  if(between < 45) {
    movingforward = 1;
  } else if(between > 135) {
    movingforward = 0;
  } else {
    return false;
  }

  localorigin = coordtransformtranspose(victim.origin, inflictor.origin, inflictor.angles);

  if(movingforward && localorigin[0] < extents["front"] - 30) {
    return true;
  }

  if(!movingforward && localorigin[0] > -1 * (extents["back"] - 30)) {
    return true;
  }

  return false;
}

function function_ff24898d8aa594cd(deathdata) {
  if(deathdata.meansofdeath != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(deathdata.inflictor) || !deathdata.inflictor vehicle::is_vehicle()) {
    return false;
  }

  return true;
}

function function_202aa0d37286dc21(deathdata) {
  return isdismembermentenabled() && !deathdata.victim.liveragdoll && deathdata.inflictor.isheli && deathdata.damage == 999999;
}

function function_9a63065217865db4(deathdata) {
  if(!function_ff24898d8aa594cd(deathdata)) {
    return;
  }

  if(function_202aa0d37286dc21(deathdata)) {
    thread function_829ecad9ab2396ac(deathdata.victim, "corpseMist", 1);
    return;
  }

  speed = deathdata.inflictor vehicle_getspeed();

  if(abs(speed) > 1) {
    showcorpse = 1;
    part = "runOverSlow";
    speedthreshold = 40;

    if(abs(speed) > speedthreshold) {
      showcorpse = 0;
      part = "runOverFast";
    }

    thread function_829ecad9ab2396ac(deathdata.victim, part, !showcorpse);
    return;
  }

  playsoundatpos(deathdata.victim.origin, "vehicle_body_hit");
}

function function_829ecad9ab2396ac(victim, part, nocorpse) {
  var_9df9bbec75709f0f = 35;

  if(nocorpse) {
    victim.nocorpse = 1;
  }

  if(!isDefined(level.playerswithoutdismemberment) || level.playerswithoutdismemberment.size < var_9df9bbec75709f0f) {
    fxent = spawn("script_model", victim gettagorigin("j_mainroot"));
    fxent.angles = victim.angles;
    fxent setModel("iw9_player_death_fx");

    if(fxent.model != "") {
      fxent setscriptablepartstate(part, "effects", 0);
    }

    if(isDefined(level.playerswithoutdismemberment)) {
      foreach(player in level.playerswithoutdismemberment) {
        fxent hidefromplayer(player);
      }
    }

    wait 0.5;
    fxent delete();
  }
}