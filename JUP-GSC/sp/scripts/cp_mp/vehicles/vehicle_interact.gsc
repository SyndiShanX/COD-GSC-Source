/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\vehicles\vehicle_interact.gsc
**********************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\stealth\event;
#namespace vehicle_interact;

function vehicle_interact_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehicleref) || !isDefined(function_29b4292c92443328(vehicleref).interact))) {
    data = undefined;

    if(!function_89dc39dc11f3988c(vehicleref)) {
      data = spawnStruct();
    } else {
      data = function_29b4292c92443328(vehicleref);
    }

    if(!isDefined(data.interact)) {
      data.interact = spawnStruct();
    }

    data.interact.interactiontypes = [];
    data.interact.maxfuel = 180;
    data.interact.var_4c6d695d0920df19 = 130;
    data.interact.var_4c4a7b5d08fabef7 = 170;
    level.var_a0b2c978ca57ffc5[vehicleref] = data;
  }

  if(function_89dc39dc11f3988c(vehicleref)) {
    return function_29b4292c92443328(vehicleref).interact;
  }
}

function vehicle_interact_getinstancedataforvehicle(vehicle, create, var_6ecb77fd1f27c667) {
  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    return undefined;
  }

  leveldataforvehicle = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, create, var_6ecb77fd1f27c667);

  if(!isDefined(leveldataforvehicle)) {
    return undefined;
  }

  if(!isDefined(vehicle getlinkedscriptableinstance())) {
    return undefined;
  }

  instancedataforvehicle = vehicle.interactdata;

  if(!isDefined(instancedataforvehicle)) {
    if(istrue(create)) {
      instancedataforvehicle = spawnStruct();
      vehicle.interactdata = instancedataforvehicle;
      instancedataforvehicle.disabledbyallow = 0;
      instancedataforvehicle.pointdata = [];

      foreach(pointref in leveldataforvehicle.interactiontypes) {
        instancedataforvehicle.pointdata[pointref] = vehicle_interact_getinstancedataforpoint(vehicle, pointref, create, var_6ecb77fd1f27c667);
      }

      instancedataforvehicle.dirty = 1;
      instancedataforvehicle.disabled = undefined;
      instancedataforvehicle.availableteam = undefined;
    } else {
      assertex(istrue(var_6ecb77fd1f27c667), "vehicle_interact_getInstanceDataForVehicle called with an invalid vehicle.");
    }
  }

  return instancedataforvehicle;
}

function function_3e11a192d07b42ea(vehicleref, pointref, activationdata) {
  leveldataforvehicle = vehicle_interact_getleveldataforvehicle(vehicleref, undefined, 1);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  var_1b7218958dc3b187 = function_247ff3bb886c55ff(pointref);
  assertex(isDefined(var_1b7218958dc3b187), "<dev string:x1c>" + pointref + "<dev string:x3d>");
  leveldataforvehicle.interactiontypes = scripts\engine\utility::array_add(leveldataforvehicle.interactiontypes, pointref);
  function_cf0f83cc6e448deb("activate", pointref, activationdata, leveldataforvehicle);
}

function vehicle_interact_registerinstance(vehicle) {
  vehicle_interact_getinstancedataforvehicle(vehicle, 1);
  vehicle_interact_makeusable(vehicle);
  leveldata = vehicle_interact_getleveldata();
  leveldata.vehicles[vehicle getentitynumber()] = vehicle;
}

function vehicle_interact_deregisterinstance(vehicle) {
  leveldata = vehicle_interact_getleveldata();

  if(isDefined(leveldata.vehicles[vehicle getentitynumber()])) {
    vehicle_interact_makeunusable(vehicle);
  }

  leveldata.vehicles[vehicle getentitynumber()] = undefined;
  vehicle.interactdata = undefined;
}

function vehicle_interact_instanceisregistered(vehicle) {
  return isDefined(vehicle.interactdata);
}

function vehicle_interact_allowvehicleuseglobal(bool) {
  leveldata = vehicle_interact_getleveldata();

  if(!isDefined(leveldata.vehicles)) {
    return;
  }

  if(!bool) {
    leveldata.disabledbyallow++;

    if(leveldata.disabledbyallow == 1) {
      foreach(vehicle in leveldata.vehicles) {
        vehicle_interact_setvehicledirty(vehicle);
        vehicle_interact_updateusability(vehicle);
      }
    }

    return;
  }

  assertex(leveldata.disabledbyallow > 0, "vehicle_interact_allowVehicleUseGlobal(" + bool + ") called when use is already allowed.");
  leveldata.disabledbyallow--;

  if(leveldata.disabledbyallow == 0) {
    foreach(vehicle in leveldata.vehicles) {
      vehicle_interact_setvehicledirty(vehicle);
      vehicle_interact_updateusability(vehicle);
    }
  }
}

function vehicle_interact_allowvehicleuse(vehicle, bool) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(!bool) {
    instancedataforvehicle.disabledbyallow++;

    if(instancedataforvehicle.disabledbyallow == 1) {
      vehicle_interact_setvehicledirty(vehicle);
      vehicle_interact_updateusability(vehicle);
    }

    return;
  }

  assertex(instancedataforvehicle.disabledbyallow > 0, "vehicle_interact_allowVehicleUse(" + bool + ") called when use is already allowed.");
  instancedataforvehicle.disabledbyallow--;

  if(instancedataforvehicle.disabledbyallow == 0) {
    vehicle_interact_setvehicledirty(vehicle);
    vehicle_interact_updateusability(vehicle);
  }
}

function vehicle_interact_init() {
  assertex(isDefined(level.vehicle), "vehicle_interact_init() called before vehicle_init().");
  assertex(!isDefined(level.vehicle.interact), "vehicle_interact_init() should only be called once.");
  leveldata = spawnStruct();
  level.vehicle.interact = leveldata;
  leveldata.vehicledata = [];
  leveldata.interactiontypes = [];
  leveldata.disabledbyallow = 0;
  function_bfc085ddf18e1712("single", &function_f1f336c41f281c07, &function_cd93c6e46bc00381, &function_39c1f2552dcfd9b0, &function_c9601fed18d5b11e);
  function_bfc085ddf18e1712("upgrade", &function_2b58c6eeaea42c35, &function_d2b057155910001b, &function_2bc48c2bcc22a4fe, &function_bd192331e198be64);
  function_bfc085ddf18e1712("copyofupgrade", &function_2b58c6eeaea42c35, &function_d2b057155910001b, &function_2bc48c2bcc22a4fe, &function_bd192331e198be64);
  level thread function_f588087bf9d7fefb();
  scripts\engine\scriptable::scriptable_addusedcallback(&vehicle_interact_scriptableused);

  if(issharedfuncdefined("vehicle_interact", "init", 1)) {
    [[getsharedfunc("vehicle_interact", "init")]]();
  }

  level thread function_ae4888c247642906();
}

function function_356ea06606d08642(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    player waittill("luinotifyserver", notification);

    if(!isDefined(notification)) {
      continue;
    }

    var_6681408ac5fcc6cf = player.pers["telemetry"];

    if(notification == "vehicle_cruise_control_on" && isDefined(var_6681408ac5fcc6cf.vehicle_autofwd_count)) {
      var_6681408ac5fcc6cf.vehicle_autofwd_count++;
    }
  }
}

function function_ae4888c247642906() {
  while(true) {
    waitframe();
    waittillframeend();
    level.vehicle.partition = undefined;
  }
}

function function_79e9116ebf7dc551() {
  if(isDefined(level.vehicle.partition)) {
    return;
  }

  vehicles = vehicle_interact_getleveldata().vehicles;

  if(isDefined(vehicles) && vehicles.size > 0) {
    level.vehicle.partition = create_partition([], 650);

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle) && isDefined(vehicle.origin)) {
        level.vehicle.partition function_24bbefb4beda630d(vehicle);
      }
    }
  }
}

function function_bfc085ddf18e1712(pointred, useinstancefunc, cleaninstancefunc, activatefunc, createinstancefunc) {
  leveldata = vehicle_interact_getleveldata();
  interactiontype = spawnStruct();
  callbacks = [];
  callbacks["useInstance"] = useinstancefunc;
  callbacks["cleanInstance"] = cleaninstancefunc;
  callbacks["activate"] = activatefunc;
  callbacks["createInstance"] = createinstancefunc;
  interactiontype.callbacks = callbacks;
  leveldata.interactiontypes[pointred] = interactiontype;
}

function vehicle_interact_scriptableused(instance, part, state, player, bautouse, usestring) {
  if(state == "vehicle_use") {
    vehicle = instance.entity;
    pointref = part;
    assertex(isDefined(vehicle), "vehicle_interact_scriptableUsed called on an entityless scriptable.");

    if(vehicle_interact_playercanusevehicles(player)) {
      if(istrue(vehicle_interact_vehiclecanbeused(vehicle))) {
        if(vehicle_interact_playercanusevehicle(player, vehicle)) {
          if(vehicle_interact_pointcanbeused(vehicle, pointref)) {
            instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref);
            function_cf0f83cc6e448deb("useInstance", pointref, instancedataforpoint, vehicle, player);
          }
        }
      }
    }
  }
}

function vehicle_interact_updateplayerusability(player, vehicles) {
  leveldata = vehicle_interact_getleveldata();

  if(!vehicle_interact_playercanusevehicles(player)) {
    foreach(vehicle in vehicles) {
      if(isDefined(vehicle)) {
        vehicle disablescriptableplayeruse(player);
      }
    }

    return;
  }

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle)) {
      continue;
    }

    if(istrue(vehicle_interact_vehiclecanbeused(vehicle)) && vehicle_interact_playercanusevehicle(player, vehicle)) {
      vehicle enablescriptableplayeruse(player);
      continue;
    }

    vehicle disablescriptableplayeruse(player);
  }
}

function vehicle_interact_monitorplayerusability(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    player waittill("update_vehicle_usability", vehiclelist);
    vehicle_interact_updateplayerusability(player, vehiclelist);
  }
}

function vehicle_interact_getleveldata() {
  assertex(isDefined(level.vehicle), "vehicle_interact_getLevelData() called before vehicle_init().");
  assertex(isDefined(level.vehicle.interact), "vehicle_interact_getLevelData() called before vehicle_interact_init().");
  return level.vehicle.interact;
}

function function_247ff3bb886c55ff(pointref) {
  assertex(isDefined(level.vehicle), "vehicle_interact_getLevelData() called before vehicle_init().");
  assertex(isDefined(level.vehicle.interact), "vehicle_interact_getLevelData() called before vehicle_interact_init().");
  return level.vehicle.interact.interactiontypes[pointref];
}

function function_cf0f83cc6e448deb(callbackref, pointref, var_ce4b3af5b29c05af, var_346563f5fda7d489, var_72eacc3730ec7823) {
  var_1b7218958dc3b187 = function_247ff3bb886c55ff(pointref);
  callbackfunc = var_1b7218958dc3b187.callbacks[callbackref];

  if(isDefined(callbackfunc)) {
    level thread[[callbackfunc]](pointref, var_ce4b3af5b29c05af, var_346563f5fda7d489, var_72eacc3730ec7823);
  }
}

function vehicle_interact_playercanusevehicles(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!player val::get("vehicle_use")) {
    return false;
  }

  if(player isparachuting() || player isskydiving()) {
    return false;
  }

  if(player isinexecutionattack() || player isinexecutionvictim()) {
    return false;
  }

  if(istrue(level.infiltransistioning)) {
    return false;
  }

  return true;
}

function vehicle_interact_vehiclecanbeused(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return undefined;
  }

  if(instancedataforvehicle.dirty) {
    vehicle_interact_cleanvehicle(vehicle);
  }

  if(vehicle function_f9142d4bd3d810f4()) {
    return 0;
  }

  return !instancedataforvehicle.disabled;
}

function vehicle_interact_pointcanbeused(vehicle, pointref) {
  instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return undefined;
  }

  if(instancedataforpoint.dirty) {
    vehicle_interact_cleanpoint(vehicle, pointref);
  }

  return !instancedataforpoint.disabled;
}

function vehicle_interact_playercanusevehicle(player, vehicle) {
  if(level.teambased) {
    team = vehicle_interact_getvehicleavailableteam(vehicle);

    if(isDefined(team) && team != player.team) {
      return false;
    }
  } else {
    playerfriendlyto = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getplayerfriendlyto(vehicle);

    if(isDefined(playerfriendlyto) && playerfriendlyto != player) {
      return false;
    }
  }

  return true;
}

function vehicle_interact_getvehicleavailableteam(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return undefined;
  }

  if(instancedataforvehicle.dirty) {
    vehicle_interact_cleanvehicle(vehicle);
  }

  return instancedataforvehicle.availableteam;
}

function vehicle_interact_setvehicledirty(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  instancedataforvehicle.dirty = 1;
}

function function_5c097a8f16a227d5(show) {
  if(isDefined(self) && self isscriptable() && self getscriptablehaspart("visibility")) {
    self setscriptablepartstate("visibility", ter_op(istrue(show), "show", "hide"));
  }
}

function vehicle_interact_cleanvehicle(vehicle) {
  leveldata = vehicle_interact_getleveldata();
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(level.teambased) {
    teamfriendlyto = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(vehicle);

    if(isDefined(teamfriendlyto)) {
      instancedataforvehicle.availableteam = teamfriendlyto;
    } else {
      availableteam = undefined;
      reserving = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getreserving(vehicle);

      foreach(player in reserving) {
        if(isDefined(player)) {
          availableteam = player.team;
          break;
        }
      }

      instancedataforvehicle.availableteam = availableteam;
    }
  }

  if(leveldata.disabledbyallow > 0) {
    instancedataforvehicle.disabled = 1;
  } else if(instancedataforvehicle.disabledbyallow > 0) {
    instancedataforvehicle.disabled = 1;
  } else {
    instancedataforvehicle.disabled = 0;
  }

  instancedataforvehicle.dirty = 0;
}

function vehicle_interact_getinstancedataforpoint(vehicle, pointref, create, var_6ecb77fd1f27c667) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, create, var_6ecb77fd1f27c667);

  if(!isDefined(instancedataforvehicle)) {
    return undefined;
  }

  instancedataforpoint = instancedataforvehicle.pointdata[pointref];

  if(!isDefined(instancedataforpoint) && isDefined(create)) {
    if(istrue(create)) {
      instancedataforpoint = spawnStruct();
      instancedataforvehicle.pointdata[pointref] = instancedataforpoint;
      instancedataforpoint.dirty = 1;
      instancedataforpoint.disabled = undefined;
      function_cf0f83cc6e448deb("createInstance", pointref, instancedataforpoint, vehicle);
    } else {
      assertex(istrue(var_6ecb77fd1f27c667), "vehicle_interact_getInstanceDataForPoint called with an invalid pointRef.");
    }
  }

  return instancedataforpoint;
}

function vehicle_interact_pointisdisabled(vehicle, pointref) {
  instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return undefined;
  }

  if(instancedataforpoint.dirty) {
    vehicle_interact_cleanpoint(vehicle, pointref);
  }

  return instancedataforpoint.disabled;
}

function vehicle_interact_pointavailableseat(vehicle, pointref) {
  instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return undefined;
  }

  if(instancedataforpoint.dirty) {
    vehicle_interact_cleanpoint(vehicle, pointref);
  }

  return instancedataforpoint.availableseatid;
}

function vehicle_interact_setpointdirty(vehicle, pointref) {
  instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return;
  }

  instancedataforpoint.dirty = 1;
}

function vehicle_interact_setpointsdirty(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  foreach(pointdata in instancedataforvehicle.pointdata) {
    pointdata.dirty = 1;
  }

  instancedataforvehicle.dirty = 1;
}

function vehicle_interact_cleanpoint(vehicle, pointref) {
  instancedataforpoint = vehicle_interact_getinstancedataforpoint(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return;
  }

  function_cf0f83cc6e448deb("cleanInstance", pointref, instancedataforpoint, vehicle);
  instancedataforpoint.dirty = 0;
}

function vehicle_interact_makeusable(vehicle) {
  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle function_d93ec4635290febd()).var_6be1425a9ea8586d)) {
    return;
  }

  vehicle_interact_updateusability(vehicle);
}

function vehicle_interact_makeunusable(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle function_d93ec4635290febd()).var_6be1425a9ea8586d)) {
    return;
  }

  pointrefs = getarraykeys(instancedataforvehicle.pointdata);

  foreach(pointref in pointrefs) {
    vehicle setscriptablepartstate(pointref, "vehicle_unusable");
  }
}

function vehicle_interact_updateusability(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle function_d93ec4635290febd()).var_6be1425a9ea8586d)) {
    return;
  }

  if(instancedataforvehicle.dirty) {
    vehicle_interact_cleanvehicle(vehicle);
  }

  if(instancedataforvehicle.disabled) {
    vehicle_interact_makeunusable(vehicle);
    return;
  }

  foreach(pointref, pointdata in instancedataforvehicle.pointdata) {
    if(pointdata.dirty) {
      vehicle_interact_cleanpoint(vehicle, pointref);
    }

    if(pointdata.disabled) {
      vehicle setscriptablepartstate(pointref, "vehicle_unusable");
      continue;
    }

    vehicle setscriptablepartstate(pointref, "vehicle_use");
  }
}

function function_f1f336c41f281c07(pointref, instancedataforpoint, vehicle, player) {
  seatid = instancedataforpoint.availableseatid;

  if(seatid != "driver" && seatid != "gunner") {
    seatid = function_91b9e7fb0f262529(player, vehicle, seatid);
  }

  forceseatid = getdvarint(@ "hash_fb517a5a3d736fa0", 0);

  if(forceseatid > 0) {
    seatids = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getallvehicleseats(vehicle);
    forceseatid = int(min(forceseatid - 1, seatids.size - 1));
    seatid = seatids[forceseatid];
    iprintlnbold("<dev string:x75>" + seatid);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, seatid, player);
  params = {
    #vehicle: vehicle, #seatid: seatid, #player: player
  };
  player callback::callback("player_vehicle_enter", params);
}

function function_91b9e7fb0f262529(player, vehicle, nextavailableseat) {
  closestseat = nextavailableseat;
  closestdistancesqr = undefined;

  foreach(seatid, seatdata in function_29b4292c92443328(vehicle function_d93ec4635290febd()).occupancy.seatdata) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(vehicle, seatid) && isDefined(seatdata.animtag)) {
      distancesqr = distancesquared(player.origin, vehicle gettagorigin(seatdata.animtag));

      if(!isDefined(closestdistancesqr) || distancesqr < closestdistancesqr) {
        closestseat = seatid;
        closestdistancesqr = distancesqr;
      }
    }
  }

  return closestseat;
}

function function_cd93c6e46bc00381(pointref, instancedataforpoint, vehicle, unusedtwo) {
  var_9d0537be150542b3 = instancedataforpoint.var_9d0537be150542b3;
  assertex(isDefined(var_9d0537be150542b3), "vehicle_interact_cleanPoint pointRef has no seatEnterArray.");
  availableseatid = undefined;

  foreach(seatid in var_9d0537be150542b3) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(vehicle, seatid)) {
      availableseatid = seatid;
      break;
    }
  }

  instancedataforpoint.disabled = !isDefined(availableseatid);
  instancedataforpoint.availableseatid = availableseatid;
}

function function_39c1f2552dcfd9b0(pointref, var_9d0537be150542b3, leveldataforvehicle, unusedone) {
  assertex(isDefined(var_9d0537be150542b3), "<dev string:x7f>");
  leveldataforvehicle.var_9d0537be150542b3 = var_9d0537be150542b3;
}

function function_c9601fed18d5b11e(pointref, instancedataforpoint, vehicle, unusedone) {
  leveldataforvehicle = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  assertex(isDefined(leveldataforvehicle.var_9d0537be150542b3), "<dev string:xc0>");
  instancedataforpoint.availableseatid = undefined;
  instancedataforpoint.var_9d0537be150542b3 = leveldataforvehicle.var_9d0537be150542b3;
}

function function_e1f37f2bd447ab19(vehicle, player) {
  if(isDefined(vehicle)) {
    if(!isDefined(vehicle.var_9aeb5660c6df86e1)) {
      vehicle.var_9aeb5660c6df86e1 = [];
    }

    vehicle.var_9aeb5660c6df86e1 = scripts\engine\utility::array_add(vehicle.var_9aeb5660c6df86e1, player);
  }
}

function function_fed77cd5c54efe19(vehicle, player) {
  if(isDefined(vehicle) && isDefined(vehicle.var_9aeb5660c6df86e1)) {
    vehicle.var_9aeb5660c6df86e1 = scripts\engine\utility::array_remove(vehicle.var_9aeb5660c6df86e1, player);
  }
}

function function_2b58c6eeaea42c35(pointref, instancedataforpoint, vehicle, player) {
  if(issharedfuncdefined("vehicle_upgrade", "init")) {
    if(!isDefined(level.br_pe_data)) {
      player iprintlnbold("BR Kiosk station is not activated in this game mode");
      return;
    }

    [[instancedataforpoint.var_4dc9e517025a78b6]](vehicle, player);
    player setclientomnvar("ui_buystation_override", instancedataforpoint.var_420bbde8d99ec0a);
    player.var_e5b7a6a0ec2b440e = 1;
    player.var_c77002478cdfd85f = vehicle;
    function_e1f37f2bd447ab19(vehicle, player);
    var_8ce0cddaad539b3 = getsharedfunc("vehicle_upgrade", "init");
    kiosk = function_d9750cba41de6a13(vehicle, pointref);
    player thread[[var_8ce0cddaad539b3]](kiosk);
  }
}

function function_d2b057155910001b(pointref, instancedataforpoint, vehicle, unusedtwo) {
  instancedataforpoint.disabled = 0;
}

function function_2bc48c2bcc22a4fe(pointref, activationdata, leveldataforvehicle, unusedone) {
  if(!isDefined(leveldataforvehicle.kiosktagarrays)) {
    leveldataforvehicle.kiosktagarrays = [];
  }

  if(!isDefined(leveldataforvehicle.var_cca5fc4158fd7ceb)) {
    leveldataforvehicle.var_cca5fc4158fd7ceb = [];
  }

  if(!isDefined(leveldataforvehicle.var_4dc9e517025a78b6)) {
    leveldataforvehicle.var_4dc9e517025a78b6 = [];
  }

  leveldataforvehicle.kiosktagarrays[pointref] = activationdata[0];
  leveldataforvehicle.var_cca5fc4158fd7ceb[pointref] = activationdata[1];
  leveldataforvehicle.var_4dc9e517025a78b6[pointref] = activationdata[2];
}

function function_bd192331e198be64(pointref, instancedataforpoint, vehicle, unusedone) {
  leveldataforvehicle = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  assertex(isDefined(leveldataforvehicle.kiosktagarrays), "<dev string:x11b>");
  assertex(isDefined(leveldataforvehicle.kiosktagarrays[pointref]), "<dev string:x16d>");
  instancedataforpoint.var_420bbde8d99ec0a = leveldataforvehicle.var_cca5fc4158fd7ceb[pointref];
  instancedataforpoint.var_4dc9e517025a78b6 = leveldataforvehicle.var_4dc9e517025a78b6[pointref];
  kiosktag = leveldataforvehicle.kiosktagarrays[pointref];
  function_16ab0dcefaa4c681(vehicle, pointref, kiosktag);
}

function function_d9750cba41de6a13(vehicle, kioskid) {
  assertex(isDefined(vehicle.kioskstructs), "<dev string:x1cb>");
  assertex(isDefined(vehicle.kioskstructs[kioskid]), "<dev string:x1cb>");
  return vehicle.kioskstructs[kioskid];
}

function function_16ab0dcefaa4c681(vehicle, kioskid, kiosktag) {
  if(!isDefined(vehicle.kioskstructs)) {
    vehicle.kioskstructs = [];
  }

  kiosk = spawnStruct();
  kiosk thread function_12d9b5736427fa79(vehicle, kiosktag);
  vehicle.kioskstructs[kioskid] = kiosk;
}

function function_12d9b5736427fa79(vehicle, kiosktag) {
  vehicle endon("death");

  while(true) {
    self.origin = vehicle gettagorigin(kiosktag);
    wait 0.5;
  }
}

function function_c4b9d8e33849435e(vehicle, upgradetype, player) {
  if(!isDefined(vehicle.upgradeactivated)) {
    vehicle.upgradeactivated = [];
  }

  vehicle.upgradeactivated[upgradetype] = 1;
  vehicle notify("give_upgrade", upgradetype, player);
}

function function_97c32f66eff29610(vehicle, upgradetype) {
  return isDefined(vehicle.upgradeactivated) && istrue(vehicle.upgradeactivated[upgradetype]);
}

function function_a717a31ae35ba01c() {
  if(istrue(level.var_b017944f02bb5e97)) {
    return 0;
  }

  if(getdvarint(@ "scr_vehicle_enable_fuel", 1) == 0) {
    return 0;
  }

  return getmatchrulesdata("commonOption", "vehicleFuelEnabled");
}

function private function_f588087bf9d7fefb() {
  level endon("game_ended");
  waitframe();

  if(!function_a717a31ae35ba01c()) {
    return;
  }

  if(getdvarint(@ "hash_48bb9b301ddec6d5", 0)) {
    flag_wait("gas_station_create_script_initialized");
  }

  var_33e3b4a298c2935 = ["gas_station", "gas_station_marine", "gas_station_charger"];
  gasstations = [];

  foreach(var_68848470e627ce84 in var_33e3b4a298c2935) {
    if(getdvarint(hashcat(@ "hash_ea224dc24c0b7e07", var_68848470e627ce84), 0) && getdvarint(@ "scr_ssc_enabled", 0)) {
      scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517(var_68848470e627ce84, &function_b062b902747a499e);
      scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e(var_68848470e627ce84, &function_23960baddc5086ed);
      scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd(var_68848470e627ce84, &function_a15a2f4b7fdce1db);
      continue;
    }

    var_8e0d7eb61f44d9d6 = function_b062b902747a499e(var_68848470e627ce84);

    foreach(gasstation in var_8e0d7eb61f44d9d6) {
      scriptable = function_23960baddc5086ed(var_68848470e627ce84, gasstation);
      gasstations[gasstations.size] = scriptable;
    }
  }

  function_6c429e1c6f5142ed(gasstations);
  level.gasstations = gasstations;
  level.gasstationspawns = undefined;
}

function function_6c429e1c6f5142ed(gasstationspawns) {
  if(!isDefined(gasstationspawns)) {
    return;
  }

  var_ece1ce8d6abcd4ae = [];

  foreach(gasstation in gasstationspawns) {
    if(!isDefined(gasstation.triggertargetname)) {
      var_ece1ce8d6abcd4ae[var_ece1ce8d6abcd4ae.size] = gasstation;
      continue;
    }

    triggers = getnoentvolumearray(gasstation.triggertargetname, "targetname");
    gasstation.triggertargetname = undefined;

    if(!isDefined(triggers) || triggers.size == 0) {
      var_ece1ce8d6abcd4ae[var_ece1ce8d6abcd4ae.size] = gasstation;
      continue;
    }

    if(getdvarint(@ "hash_18e99507526e4c5d", 0)) {
      gasstation.triggers = triggers;

      foreach(trigger in triggers) {
        if(isDefined(trigger.struct) && isDefined(trigger.struct.radius)) {
          trigger.radiussquared = trigger.struct.radius * trigger.struct.radius;
        } else {
          trigger.radiussquared = gasstation.radiussquared;
        }

        gasstation thread function_8c5be15142453a9b(trigger);
      }

      continue;
    }

    if(triggers.size == 1) {
      gasstation.trigger = triggers[0];
    } else {
      gasstation.trigger = sortbydistance(triggers, gasstation.origin)[0];
    }

    gasstation.trigger.radiussquared = gasstation.radiussquared;
    gasstation thread function_8c5be15142453a9b(gasstation.trigger);
  }

  foreach(gasstation in var_ece1ce8d6abcd4ae) {
    radius = int(sqrt(gasstation.radiussquared));
    gasstation.trigger = spawn("noent_volume_trigger_radius", gasstation.origin - (0, 0, 200), 0, radius, 1000);
    gasstation.trigger.radiussquared = gasstation.radiussquared;
    gasstation thread function_8c5be15142453a9b(gasstation.trigger);
  }
}

function private function_8c5be15142453a9b(trigger) {
  while(true) {
    trigger waittill("trigger", vehicle);

    if(!isDefined(vehicle) || !vehicle isvehicle() || !isDefined(vehicle.origin)) {
      continue;
    }

    if(!isDefined(vehicle.fuel)) {
      continue;
    }

    if(isDefined(vehicle.refuelingpercentage)) {
      continue;
    }

    if(istrue(self.var_6234172895d0c06f) && vehicle function_d93ec4635290febd() != "veh9_hummer") {
      continue;
    }

    if(distance2dsquared(vehicle.origin, trigger.origin) > trigger.radiussquared) {
      continue;
    }

    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
    thread function_518f884fc150d957(vehicle, trigger.origin, trigger.radiussquared, driver);
  }
}

function private function_52ba5a6617b2c059(origin, radius, scriptablename) {
  level endon("game_ended");

  if(issharedfuncdefined("poi", "isSystemActive") && [[getsharedfunc("poi", "isSystemActive")]]() && issharedfuncdefined("poi", "isInActivePOI") && ![[getsharedfunc("poi", "isInActivePOI")]](origin)) {
    return;
  }

  if(issharedfuncdefined("game", "isPointWithinInitialDangerCircle") && ![[getsharedfunc("game", "isPointWithinInitialDangerCircle")]](origin)) {
    return;
  }

  if(isDefined(scriptablename)) {
    if(issharedfuncdefined("<dev string:x20a>", "<dev string:x212>")) {
      [[getsharedfunc("<dev string:x20a>", "<dev string:x212>")]]("<dev string:x21b>", scriptablename, "<dev string:x226>", undefined, undefined, undefined, undefined, origin);
    }

    if(istrue(level.var_a9ccaf325f3a76d)) {
      gasstation = spawn("script_model", origin);
      gasstation setModel(scriptablename);
    } else {
      gasstation = spawnscriptable(scriptablename, origin);
    }
  } else {
    gasstation = spawnStruct();
    gasstation.origin = origin;
  }

  gasstation.radiussquared = radius * radius;
  gasstation.minheight = origin[2] - 200;
  gasstation.maxheight = origin[2] + 1000 - 200;
  gasstation.var_f49fed751e517601 = gettime();
  return gasstation;
}

function function_b062b902747a499e(structname) {
  if(!function_a717a31ae35ba01c()) {
    return;
  }

  var_8e0d7eb61f44d9d6 = getStructArray(structname, "targetname");
  return var_8e0d7eb61f44d9d6;
}

function function_23960baddc5086ed(structname, gasstationstruct) {
  if(structname == "gas_station") {
    radius = ter_op(is_equal(gasstationstruct.script_noteworthy, "large"), 600, 400);
    scriptablename = "dmz_gas_station";
  } else if(structname == "gas_station_marine") {
    radius = 650;
    scriptablename = "dmz_gas_station_marine";
  } else if(structname == "gas_station_charger") {
    radius = 400;

    if(isDefined(gasstationstruct.script_noteworthy)) {
      radius = float(gasstationstruct.script_noteworthy);
    }
  }

  scriptable = function_52ba5a6617b2c059(gasstationstruct.origin, radius, scriptablename);

  if(isDefined(scriptable)) {
    scriptable.var_6234172895d0c06f = structname == "gas_station_charger";
    scriptable.triggertargetname = gasstationstruct.target;

    if(!isDefined(level.gasstationspawns)) {
      level.gasstationspawns = [];
    }

    if(!isDefined(level.gasstationspawns[structname])) {
      level.gasstationspawns[structname] = [];
    }

    level.gasstationspawns[structname][level.gasstationspawns[structname].size] = scriptable;
  }

  return scriptable;
}

function function_a15a2f4b7fdce1db(structname) {
  function_6c429e1c6f5142ed(level.gasstationspawns[structname]);

  if(!isDefined(level.gasstations)) {
    level.gasstations = [];
  }

  level.gasstations = array_combine(level.gasstations, level.gasstationspawns[structname]);
  level.gasstationspawns[structname] = undefined;
}

function private function_518f884fc150d957(vehicle, point, radiussquared, driver) {
  level endon("game_ended");
  currenttime = gettime();

  if(currenttime - 4000 > self.var_f49fed751e517601) {
    var_d88ccaa59cb99be0 = "veh_fuel_gas_station_service_bell";

    if(istrue(self.var_6234172895d0c06f)) {
      var_d88ccaa59cb99be0 = "veh_fuel_ev_station_service_bell_enter";
    }

    playsoundatpos(self.origin, var_d88ccaa59cb99be0);
    self.var_f49fed751e517601 = currenttime;
  }

  vehicleref = vehicle function_d93ec4635290febd();
  interactinfo = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(vehicleref);
  maxfuel = interactinfo.maxfuel;
  isfuelonly = istrue(self.var_6234172895d0c06f);
  vehicle.refuelingpercentage = vehicle function_883613626149ebf8(maxfuel, isfuelonly);
  vehicle.evcharging = isfuelonly;
  team = vehicle.team;
  var_a8cc95b22d8a90cd = istrue(maxfuel == -1);
  wait 1;

  if(!isDefined(vehicle) || !isDefined(vehicle.origin) || !isDefined(vehicle.maxhealth)) {
    if(isDefined(vehicle)) {
      vehicle.refuelingpercentage = undefined;
      vehicle.evcharging = undefined;
    }

    return;
  }

  if(distancesquared(vehicle.origin, point) >= radiussquared * 2.25) {
    vehicle.refuelingpercentage = undefined;
    vehicle.evcharging = undefined;
    return;
  }

  timestamp = gettime();
  refilltime = default_to(interactinfo.var_23f37e83b1cafb10, 30);

  if(!var_a8cc95b22d8a90cd) {
    refillamount = maxfuel / refilltime * 0.25;
  }

  repairamount = vehicle.maxhealth / refilltime * 0.25;
  objidnum = undefined;
  var_bbe8a876aba8451e = 2000;
  var_e78b08d58673cb9f = timestamp + var_bbe8a876aba8451e;

  if(!var_a8cc95b22d8a90cd && isDefined(driver) && isPlayer(driver) && isDefined(driver.var_a7004ed1f5ca8132)) {
    desiredtime = refilltime * driver.var_a7004ed1f5ca8132;
    refillamount = maxfuel / desiredtime * 0.25;
  }

  if(isDefined(driver) && isPlayer(driver) && isDefined(driver.var_2da660fa32b4cd1)) {
    desiredtime = refilltime * driver.var_2da660fa32b4cd1;
    repairamount = vehicle.maxhealth / desiredtime * 0.25;
    var_bbe8a876aba8451e = 2000 * driver.var_2da660fa32b4cd1;
    var_e78b08d58673cb9f = timestamp + var_bbe8a876aba8451e;
  }

  if(issharedfuncdefined("game", "requestObjectiveID")) {
    vehicle.curorigin = (0, 0, 0);
    vehicle.offset3d = (0, 0, 0);
    vehicle.objidnum = [[getsharedfunc("game", "requestObjectiveID")]](99);
    objidnum = vehicle.objidnum;
  }

  if(isDefined(objidnum) && objidnum != -1) {
    objective_delete(objidnum);
    objective_state(objidnum, "current");
    objective_setshowoncompass(objidnum, 1);
    objective_setplayintro(objidnum, 0);
    objective_setplayoutro(objidnum, 0);
    objective_setbackground(objidnum, 1);
    icon = ter_op(vehicleref == "veh9_hummer", "ddos_emp_bolt", "ui_map_icon_gas_refuel");
    objective_icon(objidnum, icon);
    objective_onentity(objidnum, vehicle);
    objective_setzoffset(objidnum, 75);
    objective_setshowprogress(objidnum, 1);
    objective_removeallfrommask(objidnum);
    objective_showtoplayersinmask(objidnum);
  }

  progressbarvisible = 0;
  vehicle.refuelingpercentage = vehicle function_883613626149ebf8(maxfuel, isfuelonly);

  if(vehicle.refuelingpercentage < 0.99) {
    progressbarvisible = 1;

    foreach(occupant in vehicle.occupants) {
      vehicle function_3bff37824a58ef7a(occupant, objidnum, vehicleref);
    }
  }

  if(vehicle.health < vehicle.maxhealth && vehicle vehicle_damage_getstate() != "heavy") {
    playsoundatpos(vehicle.origin, "veh_repair_health");
  }

  if(istrue(level.var_5431e3914cfc0e23)) {
    validteam = 1;
    validteam = issharedfuncdefined("game", "isGameplayTeam") && [[getsharedfunc("game", "isGameplayTeam")]](team);

    if(!istrue(self.var_6234172895d0c06f) && validteam) {
      self setscriptablepartstate(self function_ec5f4851431f3382(), "occupied");
      self function_fca5bdbe24070d20(self function_ec5f4851431f3382(), team);

      if(!isDefined(self.var_f0be68ab550cb2e6)) {
        self.var_f0be68ab550cb2e6 = [];
      }

      self.var_f0be68ab550cb2e6[self.var_f0be68ab550cb2e6.size] = team;
    }
  }

  while(isDefined(vehicle) && isDefined(vehicle.origin) && distancesquared(vehicle.origin, point) < radiussquared * 2.25) {
    if(!vehicle function_fc271f387096702f()) {
      vehicle.refuelingpercentage = vehicle function_883613626149ebf8(maxfuel, isfuelonly);

      if(isDefined(objidnum) && objidnum != -1) {
        objective_setprogress(objidnum, vehicle.refuelingpercentage);
      }

      if(!progressbarvisible && vehicle.refuelingpercentage < 0.99) {
        progressbarvisible = 1;

        foreach(occupant in vehicle.occupants) {
          vehicle function_3bff37824a58ef7a(occupant, objidnum, vehicleref);
        }
      }

      wait 0.25;
      continue;
    }

    if(!var_a8cc95b22d8a90cd) {
      vehicle.fuel = min(maxfuel, vehicle.fuel + refillamount);
      vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4(vehicle.fuel, maxfuel);
    }

    if(!isfuelonly) {
      if(vehicle.health < vehicle.maxhealth && vehicle vehicle_damage_getstate() != "heavy") {
        vehicle function_653b96ce8310763e(repairamount);
      }
    }

    vehicle.refuelingpercentage = vehicle function_883613626149ebf8(maxfuel, isfuelonly);

    if(isDefined(objidnum) && objidnum != -1) {
      objective_setprogress(objidnum, vehicle.refuelingpercentage);
    }

    if(progressbarvisible && vehicle.refuelingpercentage >= 0.99) {
      progressbarvisible = 0;

      foreach(occupant in vehicle.occupants) {
        vehicle function_d051e5f825b704ab(occupant, objidnum, vehicleref, 1);
      }

      if(isDefined(driver)) {
        params = spawnStruct();
        params.player = driver;
        params.vehicle = vehicle;
        callback::callback("on_vehicle_refueled", params);
      }
    }

    waittime = 0.25;

    if(!isfuelonly) {
      timestamp = gettime();
      var_b02cfed22dabbbbc = isDefined(vehicle.deadwheels) && vehicle.deadwheels.size > 0;
      var_ea7662cd92ec78e = var_b02cfed22dabbbbc && isDefined(var_e78b08d58673cb9f) && timestamp >= var_e78b08d58673cb9f;

      if(var_b02cfed22dabbbbc && !var_ea7662cd92ec78e && timestamp + 250 >= var_e78b08d58673cb9f) {
        var_145c969594928415 = var_e78b08d58673cb9f - timestamp;
        wait var_145c969594928415 / 1000;
        var_ea7662cd92ec78e = 1;
        waittime = (250 - var_145c969594928415) / 1000;
        timestamp = gettime();
      }

      if(var_b02cfed22dabbbbc && var_ea7662cd92ec78e) {
        var_e78b08d58673cb9f = timestamp + var_bbe8a876aba8451e;
        function_e6f68a61bffc259a(vehicle);
      }

      if(abs(vehicle.fuel - maxfuel) < 1 && vehicle.health == vehicle.maxhealth && (!isDefined(vehicle.var_c48b10763f1df79a) || vehicle.var_c48b10763f1df79a.size == 0)) {
        scripts\engine\utility::callsharedfunc("pmc_missions", "onVehicleFullRefuelAndRepair", vehicle, self);

        if(!isDefined(self.refueled)) {
          self.refueled = [];
        }

        if(isDefined(vehicle.owner) && !array_contains(self.refueled, vehicle)) {
          vehicle.owner scripts\cp_mp\challenges::reportvehicleevent(vehicle, "gas_station_refuel");
          self.refueled[self.refueled.size] = vehicle;
        }
      }
    }

    wait waittime;
  }

  if(progressbarvisible && isDefined(vehicle) && isDefined(vehicle.occupants)) {
    foreach(occupant in vehicle.occupants) {
      vehicle function_d051e5f825b704ab(occupant, objidnum, vehicleref, 1);
    }
  }

  if(isDefined(objidnum) && objidnum != -1 && issharedfuncdefined("game", "returnObjectiveID")) {
    [[getsharedfunc("game", "returnObjectiveID")]](objidnum);

    if(isDefined(vehicle)) {
      vehicle.objidnum = undefined;
    }
  }

  if(isDefined(vehicle)) {
    vehicle.refuelingpercentage = undefined;
    vehicle.evcharging = undefined;
  }

  if(istrue(level.var_5431e3914cfc0e23)) {
    validteam = 1;
    validteam = issharedfuncdefined("game", "isGameplayTeam") && [[getsharedfunc("game", "isGameplayTeam")]](team);

    if(!istrue(self.var_6234172895d0c06f) && validteam) {
      self.var_f0be68ab550cb2e6 = function_57091b2d67654a14(self.var_f0be68ab550cb2e6, team);

      if(self.var_f0be68ab550cb2e6.size == 0) {
        self setscriptablepartstate(self function_ec5f4851431f3382(), "idle");
        return;
      }

      validteam = 1;
      validteam = issharedfuncdefined("game", "isGameplayTeam") && [[getsharedfunc("game", "isGameplayTeam")]](self.var_f0be68ab550cb2e6[0]);

      if(validteam) {
        self function_fca5bdbe24070d20(self function_ec5f4851431f3382(), self.var_f0be68ab550cb2e6[0]);
      }
    }
  }
}

function function_fc271f387096702f() {
  return !isDefined(self.lasttimedamaged) || gettime() - self.lasttimedamaged >= 5000;
}

function private function_883613626149ebf8(maxfuel, isfuelonly) {
  if(maxfuel == -1) {
    return (self.health / self.maxhealth);
  }

  if(isfuelonly) {
    return (self.fuel / maxfuel);
  }

  return 0.5 * self.fuel / maxfuel + 0.5 * self.health / self.maxhealth;
}

function function_c5fe005f06fe5684(vehicle, player) {
  if(isDefined(vehicle.refuelingpercentage) && vehicle.refuelingpercentage < 0.99) {
    vehicle function_3bff37824a58ef7a(player, vehicle.objidnum, vehicle function_d93ec4635290febd());
  }
}

function function_deb83798a724a77e(vehicle, player) {
  if(isDefined(vehicle.refuelingpercentage) && vehicle.refuelingpercentage < 0.99) {
    vehicle function_d051e5f825b704ab(player, vehicle.objidnum, vehicle function_d93ec4635290febd());
  }
}

function private function_3bff37824a58ef7a(player, objidnum, vehicleref) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_addclienttomask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_pinforclient(objidnum, player);
    objective_setshowpinnedprogressbar(2, player);
    refuelingtext = &"MP/REFUELING";

    if(vehicleref == "veh9_hummer") {
      refuelingtext = ter_op(istrue(self.evcharging), &"MP/CHARGING_FUEL_ONLY", &"MP/CHARGING");
    } else if(vehicleref == "veh9_motorcycle_blood_burner_physics") {
      refuelingtext = &"MP/REPAIRING";
    }

    objective_setpinnedprogressbartext(refuelingtext, player);
    function_82a1c76da877f6a3(player, vehicleref);
  }
}

function private function_d051e5f825b704ab(player, objidnum, vehicleref, success) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_removeclientfrommask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_unpinforclient(objidnum, player);
    objective_setshowpinnedprogressbar(0, player);
    function_bd48158d51404989(player, vehicleref, success);
  }
}

function private function_82a1c76da877f6a3(player, vehicleref) {
  if(isDefined(player)) {
    refuelingsound = ter_op(vehicleref == "veh9_hummer", "uin_veh_fuel_ev_charger", "uin_veh_fuel_gas_ticker");
    player playlocalsound(refuelingsound);
  }
}

function private function_bd48158d51404989(player, vehicleref, success) {
  if(isDefined(player)) {
    refuelingsound = "uin_veh_fuel_gas_ticker";
    var_2d2bbcca8984c48f = "uin_veh_fuel_gas_ticker_stop";

    if(vehicleref == "veh9_hummer") {
      refuelingsound = "uin_veh_fuel_ev_charger";
      var_2d2bbcca8984c48f = "uin_veh_fuel_ev_charger_stop";
    }

    player stoplocalsound(refuelingsound);

    if(istrue(success)) {
      player playlocalsound(var_2d2bbcca8984c48f);
    }
  }
}

function function_a203f8033eeb57f1(vehicleref, vehicle) {
  if(!vehicle scripts\cp_mp\vehicles\vehicle::isvehiclehusk() && function_a717a31ae35ba01c() && !istrue(vehicle.isfromkillstreak)) {
    vehicle.fuel = function_f02703f19a787f77(vehicleref);
    vehicle thread function_722b030261c05941(vehicleref);
  }
}

function private function_f02703f19a787f77(vehicleref) {
  leveldataforvehicle = vehicle_interact_getleveldataforvehicle(vehicleref);

  if(leveldataforvehicle.var_4c6d695d0920df19 >= leveldataforvehicle.var_4c4a7b5d08fabef7) {
    return leveldataforvehicle.var_4c6d695d0920df19;
  }

  return randomfloatrange(leveldataforvehicle.var_4c6d695d0920df19, leveldataforvehicle.var_4c4a7b5d08fabef7);
}

function private function_722b030261c05941(vehicleref) {
  self endon("death");
  level endon("game_ended");
  maxfuel = vehicle_interact_getleveldataforvehicle(vehicleref).maxfuel;

  if(maxfuel < 0) {
    return;
  }

  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showfuel(occupants);
  scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4(self.fuel, maxfuel);
  topspeed = self vehicle_gettopspeedforward();
  lowfuel = 0;
  outoffuel = 0;
  lowfuelsound = "uin_veh_warning_low_fuel";
  outoffuelsound = "uin_veh_warning_out_of_fuel";

  if(istrue(scripts\common\vehicle::ishelicopter())) {
    lowfuelsound = "uin_veh_warning_low_fuel_heli";
    outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
  }

  while(true) {
    wait 1;

    if(istrue(self.ishovering) || !istrue(self.isempty) && isPlayer(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self))) {
      speedfraction = min(ter_op(scripts\common\vehicle::ishelicopter(), 1, self vehicle_getspeed() / topspeed), 1);
      player = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(!istrue(scripts\common\vehicle::ishelicopter()) && isDefined(player.var_dc3b97ba2322ca5a)) {
        speedfraction *= player.var_dc3b97ba2322ca5a;
      }

      speedfraction *= getdvarfloat(@ "hash_deab88f9a10a5bc8", 1);

      lostfuel = speedfraction * default_to(self.fuelmultiplier, 1);
      self.fuel = max(self.fuel - lostfuel, 0);
    }

    if(getdvarint(@ "hash_f6ba20712f854462", 0) == 1) {
      self.fuel = maxfuel;
      outoffuel = 0;
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4(self.fuel, maxfuel);

    if(self.fuel <= 0 && !outoffuel) {
      outoffuel = 1;
      scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
      scripts\cp_mp\vehicles\vehicle_occupancy::function_ee4b8b879b1b120c();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0, 0);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("outOfFuel", scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self), vehicleref);

      if(issharedfuncdefined(vehicleref, "outOfFuel")) {
        [[getsharedfunc(vehicleref, "outOfFuel")]]();
      }

      if(issharedfuncdefined("pmc_missions", "onVehicleOutOfFuel")) {
        [[getsharedfunc("pmc_missions", "onVehicleOutOfFuel")]](scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self));
      }

      function_5a2b3f3e2cd84eb8(lowfuelsound);
      function_7c7694a53fa6720a(outoffuelsound);
    } else if(self.fuel > 0 && outoffuel) {
      outoffuel = 0;
      function_5a2b3f3e2cd84eb8(outoffuelsound);
      scripts\cp_mp\vehicles\vehicle_occupancy::function_7c81e0d41cbbce7f();
      scripts\cp_mp\vehicles\vehicle_occupancy::function_9e710c9f3a15ffda();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("outOfFuel", scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self), vehicleref);
    }

    if(self.fuel <= 25 && self.fuel > 0 && !lowfuel) {
      lowfuel = 1;
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("lowFuel", scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self), vehicleref);
      function_7c7694a53fa6720a(lowfuelsound);
      player = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(player) && scripts\engine\utility::issharedfuncdefined("hud", "ftue_triggerTip")) {
        closestgasstation = undefined;
        var_47415e4e37e805ff = undefined;

        foreach(gasstation in level.gasstations) {
          if(!isDefined(closestgasstation)) {
            closestgasstation = gasstation;
            var_47415e4e37e805ff = distancesquared(self.origin, gasstation.origin);
          }

          distancesqr = distancesquared(self.origin, gasstation.origin);

          if(distancesqr < var_47415e4e37e805ff) {
            closestgasstation = gasstation;
            var_47415e4e37e805ff = distancesquared(self.origin, gasstation.origin);
          }
        }

        player[[scripts\engine\utility::getsharedfunc("hud", "ftue_triggerTip")]]("br_ftue_driving", closestgasstation.origin);
      }

      continue;
    }

    if((self.fuel > 25 || self.fuel <= 0) && lowfuel) {
      lowfuel = 0;
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("lowFuel", scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self), vehicleref);
      function_5a2b3f3e2cd84eb8(lowfuelsound);
    }
  }
}

function function_7c7694a53fa6720a(soundaliasname) {
  if(soundexists(soundaliasname)) {
    foreach(occupant in scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self)) {
      occupant stoplocalsound(soundaliasname);
      occupant playlocalsound(soundaliasname);
    }
  }
}

function function_5a2b3f3e2cd84eb8(soundaliasname) {
  if(soundexists(soundaliasname)) {
    foreach(occupant in scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self)) {
      occupant stoplocalsound(soundaliasname);
    }
  }
}

function function_557da58e3ad8a579(gascan, var_62cc4a0ecde06ecf) {
  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(!isDefined(vehicle) || !isDefined(vehicle.fuel)) {
    if(var_62cc4a0ecde06ecf) {
      return "MP/CANNOT_USE_GAS_CAN_PALFA";
    }

    return "MP/CANNOT_USE_GAS_CAN";
  }

  ref = vehicle function_d93ec4635290febd();
  interactinfo = vehicle_interact_getleveldataforvehicle(ref);

  if(istrue(level.var_c0e521049f7ae2c9) && !var_62cc4a0ecde06ecf && ref == "veh9_palfa") {
    return "MP/CANNOT_USE_GAS_CAN_IN_PALFA";
  }

  if(var_62cc4a0ecde06ecf && ref != "veh9_palfa") {
    return "MP/CANNOT_USE_GAS_CAN_PALFA";
  }

  if(!var_62cc4a0ecde06ecf && (!isDefined(gascan.count) || gascan.count == 1)) {
    return "MP/GAS_CAN_IS_EMPTY";
  }

  if(ref == "veh9_hummer") {
    return "MP/CANNOT_USE_GAS_CAN_ELECTRIC";
  }

  if(interactinfo.maxfuel - vehicle.fuel < 1) {
    return "MP/VEHICLE_FULL_GAS";
  }

  refillamount = gascan.count - 1;

  if(var_62cc4a0ecde06ecf && ref == "veh9_palfa") {
    refillamount = 1000;
  }

  if(vehicle.fuel + refillamount > interactinfo.maxfuel) {
    refillamount = int(floor(interactinfo.maxfuel - vehicle.fuel));
  }

  vehicle.fuel = min(interactinfo.maxfuel, vehicle.fuel + refillamount);

  if(var_62cc4a0ecde06ecf) {
    gascan.count = 0;
  } else {
    gascan.count = int(clamp(gascan.count - refillamount, 1, 150));
  }

  vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4();
  scripts\engine\utility::callsharedfunc("pmc_missions", "onGasCanRefuel", vehicle, var_62cc4a0ecde06ecf);
  return undefined;
}

function function_cf96fb01f9473d0d(gascancount) {
  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(!isDefined(vehicle) || !isDefined(vehicle.fuel)) {
    return ["MP/CANNOT_USE_GAS_CAN", gascancount];
  }

  if(!isDefined(gascancount) || gascancount == 150) {
    return ["MP/GAS_CAN_FULL", gascancount];
  }

  ref = vehicle function_d93ec4635290febd();
  interactinfo = vehicle_interact_getleveldataforvehicle(ref);

  if(ref == "veh9_hummer") {
    return ["MP/GAS_CAN_SIPHON_ON_EV", gascancount];
  }

  siphonamount = 150 - gascancount + 1;

  if(vehicle.fuel < siphonamount) {
    siphonamount = int(floor(vehicle.fuel));
  }

  vehicle.fuel = max(0, vehicle.fuel - siphonamount);
  gascancount = int(clamp(gascancount + siphonamount - 1, 1, 150));
  vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::function_9da76b0be4b2a2d4();
  scripts\engine\utility::callsharedfunc("pmc_missions", "onVehicleSiphoned", vehicle);
  return [undefined, gascancount];
}

function function_68cdb3d30284be07() {
  if(isvehiclehusk()) {
    return;
  }

  vehicleleveldata = vehicle_interact_getleveldataforvehicle(function_d93ec4635290febd());

  if(!isDefined(level.caralarmenabled)) {
    level.caralarmenabled = getdvarint(@ "hash_e42fc7d1e9196cff", 1) == 1;
  }

  if(!level.caralarmenabled || istrue(self.playedcaralarm) || isDefined(self.var_c8ef06006ce062c1) && self.var_c8ef06006ce062c1 >= gettime() || !istrue(self.isempty) || !isDefined(vehicleleveldata) || !isDefined(vehicleleveldata.alarmpartname) || vehicleleveldata.alarmpartname == "" || !self getscriptablehaspart(vehicleleveldata.alarmpartname) || !self getscriptableparthasstate(vehicleleveldata.alarmpartname, "on")) {
    return;
  }

  self notify("car_alarm_start");
  self endon("car_alarm_start");
  self endon("death");
  self setscriptablepartstate(vehicleleveldata.alarmpartname, "on");
  scripts\stealth\event::event_broadcast_generic("cover_blown", self.origin, 2500, self);

  if(isDefined(level.var_503460970f6e03c1)) {
    self.var_c8ef06006ce062c1 = gettime() + level.var_503460970f6e03c1;
  } else {
    self.playedcaralarm = 1;
  }

  params = spawnStruct();
  params.vehicle = self;
  callback::callback("car_alarm_on", params);
  function_a6cf8b7a0d3630b5();

  if(self getscriptableparthasstate(vehicleleveldata.alarmpartname, "off")) {
    self setscriptablepartstate(vehicleleveldata.alarmpartname, "off");
  }

  callback::callback("car_alarm_off", params);
}

function private function_a6cf8b7a0d3630b5(seconds) {
  self endon("vehicle_owner_update");

  if(isDefined(level.vehiclealarmtime)) {
    wait level.vehiclealarmtime;
    return;
  }

  wait 5;
}

function function_c01316c733e017b7() {
  if(!level.vehiclelightsenabled || istrue(self.var_9d9132209b6bb2e7)) {
    return;
  }

  if(istrue(self.enginelightson)) {
    return;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return;
  }

  data = function_29b4292c92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights) || data.interact.lights.size == 0) {
    return;
  }

  isnight = function_5519f4e75a7e2d2b();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
      self.enginelightson = 1;
      continue;
    }

    if(isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
      self.enginelightson = 1;
    }
  }
}

function function_49eff91715ae3c1b() {
  if(!level.vehiclelightsenabled || istrue(self.var_9d9132209b6bb2e7)) {
    return;
  }

  if(!istrue(self.enginelightson)) {
    return;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return;
  }

  data = function_29b4292c92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights) || data.interact.lights.size == 0) {
    return;
  }

  isnight = function_5519f4e75a7e2d2b();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
      continue;
    }

    if(isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
    }
  }

  self.enginelightson = undefined;
}

function function_7394e322c553b3f0() {
  if(!level.vehiclelightsenabled || istrue(self.var_9d9132209b6bb2e7)) {
    return;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return;
  }

  data = function_29b4292c92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights)) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(light.type == "opening_door") {
      self setscriptablepartstate(light.tag, "on", 1);
    }
  }
}

function function_89205f33661ae7a7(var_b28b6726f299e0d0, overridestate) {
  function_8899ecb43445ed50(var_b28b6726f299e0d0, "on", overridestate);
}

function function_acf62f098d0588eb(var_b28b6726f299e0d0, overridestate) {
  function_8899ecb43445ed50(var_b28b6726f299e0d0, "off", overridestate);
}

function function_8899ecb43445ed50(var_b28b6726f299e0d0, state, overridestate) {
  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return;
  }

  data = function_29b4292c92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights)) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(!self getscriptablehaspart(light.tag)) {
      continue;
    }

    if(self getscriptablepartstate(light.tag) == "death") {
      continue;
    }

    if(isDefined(var_b28b6726f299e0d0) && !isarray(var_b28b6726f299e0d0) && light.group != var_b28b6726f299e0d0) {
      continue;
    }

    if(isDefined(var_b28b6726f299e0d0) && isarray(var_b28b6726f299e0d0) && !array_contains(var_b28b6726f299e0d0, light.tag)) {
      continue;
    }

    if(isDefined(overridestate) && self getscriptablepartstate(light.tag, overridestate)) {
      self setscriptablepartstate(light.tag, overridestate);
      continue;
    }

    self setscriptablepartstate(light.tag, state);
  }
}

function function_420769a30ab48a6b(var_b28b6726f299e0d0) {
  if(!isDefined(self) || !isDefined(self.damageableparts)) {
    return;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return;
  }

  data = function_29b4292c92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights)) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(isDefined(var_b28b6726f299e0d0) && !isarray(var_b28b6726f299e0d0) && light.group != var_b28b6726f299e0d0) {
      continue;
    }

    if(isDefined(var_b28b6726f299e0d0) && isarray(var_b28b6726f299e0d0) && !array_contains(var_b28b6726f299e0d0, light.tag)) {
      continue;
    }

    self.damageableparts[light.tag] = undefined;
  }
}

function function_294a35251526f435() {
  self.var_9d9132209b6bb2e7 = 1;
}

function private function_5519f4e75a7e2d2b() {
  switch (level.script) {
    case #"hash_75b253ac88bdcfe":
    case #"hash_2920b53ef96ab8ff":
    case #"hash_2de697274b41ff79":
    case #"hash_4aa5d6e97851bdbd":
    case #"hash_7615425c9b75fff2":
    case #"hash_9606e63421f54d69":
      return 1;
    default:
      return 0;
  }
}

function vehicle_interact_initdev() {
  forceseatid = setdvarifuninitialized(@ "hash_fb517a5a3d736fa0", 0);
}

function function_c2f090b27fcd0e43(vehicle) {
  instancedataforvehicle = vehicle_interact_getinstancedataforvehicle(vehicle, 0);
  return getarraykeys(instancedataforvehicle.pointdata);
}

function function_d66fa700ce5b783() {
  return "<dev string:x235>";
}

# /