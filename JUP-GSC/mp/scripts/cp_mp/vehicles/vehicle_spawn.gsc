/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\vehicles\vehicle_spawn.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace vehicle_spawn;

function vehicle_spawn_getleveldataforvehicle(vehicleref, create) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehicleref) || !isDefined(function_29b4292c92443328(vehicleref).spawn))) {
    data = undefined;

    if(!function_89dc39dc11f3988c(vehicleref)) {
      data = spawnStruct();
    } else {
      data = function_29b4292c92443328(vehicleref);
    }

    data.spawn = spawnStruct();
    data.spawn.maxinstancecount = 0;
    data.spawn.priority = 50;
    level.var_a0b2c978ca57ffc5[vehicleref] = data;
  }

  if(function_89dc39dc11f3988c(vehicleref)) {
    return function_29b4292c92443328(vehicleref).spawn;
  }
}

function function_37480e9c9c701cf2(vehicleref, spawndata) {
  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  validatespawndata(spawndata);

  leveldataforvehicle = vehicle_getleveldataforvehicle(vehicleref);
  spawndata.targetname = vehicleref;

  if(isDefined(leveldataforvehicle.vehicle)) {
    spawndata.vehicletype = leveldataforvehicle.vehicle;
  }

  if(isDefined(spawndata.vehicleoverride)) {
    spawndata.vehicletype = spawndata.vehicleoverride;
  }

  model = leveldataforvehicle.model;

  if(istrue(spawndata.initai) && isDefined(leveldataforvehicle.ai.model)) {
    model = leveldataforvehicle.ai.model;
  }

  if(isDefined(spawndata.skinoverride)) {
    spawndata.modelname = spawndata.skinoverride + "::" + model;
  } else if(isDefined(leveldataforvehicle.skinoverride) && leveldataforvehicle.skinoverride != "") {
    spawndata.modelname = leveldataforvehicle.skinoverride + "::" + model;
  } else {
    spawndata.modelname = model;
  }

  if(isDefined(spawndata.modeloverride)) {
    spawndata.modelname = spawndata.modeloverride;
  }

  return spawndata;
}

function function_1cc780d5cac1e7cd(vehicleref, spawndata, fallbackvehicletype) {
  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  validatespawndata(spawndata);

  leveldataforvehicle = vehicle_getleveldataforvehicle(vehicleref);
  spawndata.targetname = leveldataforvehicle.husk.ref;
  spawndata.vehicletype = ter_op(isDefined(leveldataforvehicle.husk.vehicle), leveldataforvehicle.husk.vehicle, leveldataforvehicle.vehicle);
  huskmodelname = leveldataforvehicle.husk.model;

  if(istrue(leveldataforvehicle.husk.var_45c781fb466d2281)) {
    if(isDefined(spawndata.skinoverride)) {
      spawndata.modelname = spawndata.skinoverride + "::" + huskmodelname;
    } else if(isDefined(leveldataforvehicle.skinoverride) && leveldataforvehicle.skinoverride != "") {
      spawndata.modelname = leveldataforvehicle.skinoverride + "::" + huskmodelname;
    } else {
      spawndata.modelname = huskmodelname;
    }
  } else {
    spawndata.modelname = huskmodelname;
  }

  if(!isDefined(spawndata.vehicletype)) {
    spawndata.vehicletype = fallbackvehicletype;
  }

  spawndata.dospawnedcallback = 0;
  return spawndata;
}

function function_75ce57f81b582b38(vehicle, vehicleref) {
  leveldataforvehicle = vehicle_getleveldataforvehicle(vehicleref);
  spawndata = spawnStruct();
  spawndata.origin = vehicle.origin;
  spawndata.angles = vehicle.angles;
  spawndata.initialvelocity = anglestoup(vehicle.angles) * leveldataforvehicle.husk.belowvelocityscale;
  spawndata.var_ec2df2acaf230179 = vehicleref;
  spawndata.huskref = leveldataforvehicle.husk.huskref;
  spawndata.damageableparts = scripts\cp_mp\vehicles\vehicle_damage::function_7a5070220fc8ce9e(vehicleref, vehicle.damageableparts);
  spawndata.basevehiclespawndata = getvehiclespawndata(vehicle);
  spawndata.preventrespawn = vehicle.preventrespawn;

  if(isDefined(spawndata.basevehiclespawndata)) {
    spawndata.skinoverride = spawndata.basevehiclespawndata.skinoverride;
  }

  if(vehicle vehicle_getspeed() > leveldataforvehicle.husk.momentumthreshold) {
    spawndata.initialvelocity = vehicle vehicle_getvelocity() * leveldataforvehicle.husk.abovevelocityscale;
  }

  return spawndata;
}

function vehicle_spawn_canspawnVehicle(vehicleref, owner, team, spawntype) {
  if(istrue(level.debugvehiclespawns)) {
    println("<dev string:x1c>" + vehicleref);
  }

  if(canspawnVehicle()) {
    issharedfuncdefined("<dev string:x4f>", "<dev string:x60>", 1);

    if([[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleref)) {
      if(isDefined(vehicleref)) {
        if(!vehicle_tracking_instancesarelimited(vehicleref) || !vehicle_tracking_atinstancelimit(vehicleref, owner, team, spawntype)) {
          leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(vehicleref);

          if(isDefined(leveldataforvehicle)) {
            if(istrue(level.ignorevehicletypeinstancelimit) || !isDefined(leveldataforvehicle.maxinstancecount) || vehicle_tracking_getgameinstances(vehicleref).size < leveldataforvehicle.maxinstancecount) {
              if(isDefined(leveldataforvehicle.canspawncallback)) {
                return [[leveldataforvehicle.canspawncallback]](owner, team);
              } else {
                return 1;
              }
            } else {
              if(istrue(level.debugvehiclespawns)) {
                println("<dev string:x73>" + vehicleref);
              }
            }
          } else {
            if(istrue(level.debugvehiclespawns)) {
              println("<dev string:xad>" + vehicleref);
            }
          }
        } else {
          if(istrue(level.debugvehiclespawns)) {
            println("<dev string:xe2>" + vehicleref);
          }
        }
      } else {
        if(istrue(level.debugvehiclespawns)) {
          println("<dev string:x11d>");
        }
      }
    } else {
      if(istrue(level.debugvehiclespawns)) {
        println("<dev string:x14f>" + vehicleref);
      }
    }
  } else {
    if(istrue(level.debugvehiclespawns)) {
      println("<dev string:x1a2>" + vehicleref + "<dev string:x1e2>" + getvehiclecount() + "<dev string:x1e7>" + level.maxvehiclecount);
    }
  }

  return 0;
}

function function_25d4b673539659a1() {
  while(!level.var_54c8acfd634a416c) {
    waitframe();
  }

  var_c9ed6663f76bec8a = [];

  foreach(data in level.var_a0b2c978ca57ffc5) {
    if(!isDefined(data.spawn) || !isDefined(data.spawn.var_32b659cdf8f93ae2)) {
      continue;
    }

    var_c9ed6663f76bec8a[data.spawn.var_32b659cdf8f93ae2] = data;
  }

  points = [];
  structs = [];

  foreach(targetname, data in var_c9ed6663f76bec8a) {
    structs = array_combine(structs, getStructArray(targetname, "targetname"));
  }

  foreach(struct in structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }

    num = -1;

    switch (tolower(struct.script_noteworthy)) {
      case #"hash_31103fbc01bd840c":
        num = 0;
        break;
      case #"hash_311042bc01bd88c5":
        num = 1;
        break;
      case #"hash_311041bc01bd8732":
        num = 2;
        break;
      case #"hash_31103cbc01bd7f53":
        num = 3;
        break;
      case #"hash_31103bbc01bd7dc0":
        num = 4;
        break;
    }

    if(num == -1) {
      continue;
    }

    points[num] = [var_c9ed6663f76bec8a[struct.targetname].ref, struct.origin, struct.angles, struct.script_team];
  }

  return points;
}

function function_9f3ee4972dec5b57(vehicleref, origin, angles, targetname, vehicletype, script_noteworthy) {
  if(!isDefined(vehicleref) || !isDefined(origin)) {
    assertmsg("<dev string:x1ee>");
    return;
  }

  if(!isDefined(targetname)) {
    targetname = function_348b69ec4082ceba(vehicleref);
  }

  if(!isDefined(vehicletype)) {
    vehicletype = function_8fb5b3da3ad4d628(vehicleref);
  }

  if(!isDefined(targetname) || !isDefined(vehicletype)) {
    assertmsg("<dev string:x244>" + vehicleref + "<dev string:x277>");
    return;
  }

  struct = spawnStruct();
  struct.origin = origin;
  struct.angles = angles;
  struct.targetname = targetname;
  struct.vehicletype = vehicletype;
  struct.script_noteworthy = script_noteworthy;
  addstruct(struct);
}

function function_b08e7e3a0b14f76f(vehicleref) {
  targetname = function_348b69ec4082ceba(vehicleref);

  if(!isDefined(targetname)) {
    return [];
  }

  structs = getStructArray(targetname, "targetname");

  if(structs.size > 0) {
    structs = vehicle_spawn_removespawnstructswithflag(structs);

    if(structs.size > 1) {
      structs = array_randomize(structs);
    }
  }

  return structs;
}

function function_5a6b4f3358f3e3cc(vehicleref) {
  targetname = function_348b69ec4082ceba(vehicleref);

  if(!isDefined(targetname)) {
    return [];
  }

  structs = getStructArray(targetname, "targetname");

  if(structs.size > 0) {
    structs = vehicle_spawn_removespawnstructswithflag(structs);
  }

  return structs;
}

function function_348b69ec4082ceba(vehicleref) {
  if(!function_38f50decb5603d7(vehicleref)) {
    return undefined;
  }

  if(!function_89dc39dc11f3988c(vehicleref)) {
    return getscriptbundlefieldvalue("vehiclebundle:" + vehicleref + ter_op(!iscp(), "_mp", "_cp"), #"targetname");
  }

  data = function_29b4292c92443328(vehicleref);

  if(isDefined(data)) {
    return data.targetname;
  }
}

function function_8fb5b3da3ad4d628(vehicleref) {
  if(!function_38f50decb5603d7(vehicleref)) {
    return undefined;
  }

  if(!function_89dc39dc11f3988c(vehicleref)) {
    return getscriptbundlefieldvalue("vehiclebundle:" + vehicleref + ter_op(!iscp(), "_mp", "_cp"), #"vehicle");
  }

  data = function_29b4292c92443328(vehicleref);

  if(isDefined(data)) {
    return data.vehicle;
  }
}

function vehicle_spawn_removespawnstructswithflag(spawnstructs) {
  if(getdvarint(@ "hash_d451d5012c6af909", 0) == 1) {
    return spawnstructs;
  }

  spawnflagmask = 1 >> 0;
  filteredstructs = [];

  foreach(struct in spawnstructs) {
    if(isDefined(struct.spawnflags) && struct.spawnflags &spawnflagmask) {
      continue;
    }

    filteredstructs[filteredstructs.size] = struct;
  }

  return filteredstructs;
}

function vehicle_spawn_gamemodesupportsrespawn(vehicleref) {
  defaultvalue = utility::iscp() ? 0 : 1;
  var_13a977502a245310 = getdvarint(@ "hash_bd25469fa7e9f44f", defaultvalue);

  if(var_13a977502a245310 && istrue(level.br_prematchstarted) && isDefined(vehicleref)) {
    dvarname = hashcat(@ "hash_6ad21ac4436249d9", vehicleref);
    var_13a977502a245310 = getdvarint(dvarname, defaultvalue);
  }

  return var_13a977502a245310;
}

function vehicle_spawn_init() {
  assertex(isDefined(level.vehicle), "<dev string:x2c4>");
  assertex(!isDefined(level.vehicle.spawn), "<dev string:x2fa>");
  leveldata = spawnStruct();
  level.vehicle.spawn = leveldata;
  leveldata.databyref = [];
  leveldata.spawnfromstructsdelayornotify = 5;

  if(isusingmatchrulesdata()) {
    leveldata.respawndelaymatchrules = default_to(getmatchrulesdata("commonOption", "vehicleRespawnDelay"), 0);
    leveldata.abandonedtimeoutmatchrules = default_to(getmatchrulesdata("commonOption", "vehicleAbandonedTimeout"), 0);
  } else {
    leveldata.respawndelaymatchrules = 0;
    leveldata.abandonedtimeoutmatchrules = 0;
  }

  leveldata.respawndelayoverride = getdvarint(@ "hash_1f347fd0c3d771a2", 0);
  leveldata.abandonedtimeoutoverride = getdvarint(@ "hash_e547fe8dfe1679f6", 0);
  leveldata.respawndelay = getdvarint(@ "hash_8fdbbb498db9480a", 60);
  leveldata.abandonedtimeoutdelay = getdvarint(@ "hash_36374c04e23480b6", 30);

  level.debugvehiclespawns = getdvarint(@ "hash_528ed37a0fec0b6d", 0) == 1;

  vehicle_spawn_initspawnclearance();

  issharedfuncdefined("<dev string:x4f>", "<dev string:x32e>", 1);

  [[getsharedfunc("vehicle_spawn", "init")]]();
  vehicle_spawn_initlate();
  level.ignorevehicletypeinstancelimit = getdvarint(@ "hash_37f76437c65cd04e", 1);
}

function vehicle_spawn_initlate() {
  if(issharedfuncdefined("vehicle_spawn", "initLate")) {
    [[getsharedfunc("vehicle_spawn", "initLate")]]();
  }
}

function vehicle_spawn_spawnfromstructscomparefunc(vehicledataa, vehicledatab) {
  return vehicledataa.priority >= vehicledatab.priority;
}

function vehicle_spawn_getleveldata() {
  assertex(isDefined(level.vehicle), "<dev string:x336>");
  assertex(isDefined(level.vehicle.spawn), "<dev string:x374>");
  return level.vehicle.spawn;
}

function vehicle_spawn_isvehiclespawnStruct() {
  targetname = self.targetname;

  if(isDefined(targetname)) {
    switch (targetname) {
      case #"hash_6814f5e14262cd1":
      case #"hash_1479e2073c83cda2":
      case #"hash_1be85ecd6eb9915e":
      case #"hash_257440848fa1e781":
      case #"hash_297027751cd2c948":
      case #"hash_5976269dab51a932":
      case #"hash_5b97d59c5aa200ba":
      case #"hash_5c5417975c844e03":
      case #"hash_8d97f13aa572972d":
      case #"hash_9fae9f2b4d8960b5":
      case #"hash_b970b9f69d11cd68":
      case #"hash_c30f8ac20d6114ae":
      case #"hash_ce76a6942e01af7b":
      case #"hash_e0700813f3933328":
      case #"hash_f248c9f68e2ba5bb":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function vehicle_spawn_initspawnclearance() {
  leveldata = vehicle_spawn_getleveldata();
  leveldata.clearancecheckminradii = [];
}

function vehicle_spawn_checkspawnclearance(position, vehicleref, contentsoverride, ignorelistoverride, positionoffsetz) {
  leveldata = vehicle_spawn_getleveldata();
  checkradius = 200;
  checkheight = 200;
  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(vehicleref);
  assertex(isDefined(leveldataforvehicle), "<dev string:x3b8>");
  minradius = leveldataforvehicle.clearancecheckradius;

  if(!isDefined(minradius)) {
    minradius = leveldata.clearancecheckminradii[vehicleref];
  }

  assertex(isDefined(minradius), "<dev string:x401>" + vehicleref + "<dev string:x432>");

  if(isDefined(leveldataforvehicle.clearancecheckradius)) {
    checkradius = leveldataforvehicle.clearancecheckradius;
  }

  if(isDefined(leveldataforvehicle.clearancecheckheight)) {
    checkheight = leveldataforvehicle.clearancecheckheight;
  }

  if(isDefined(positionoffsetz)) {
    position += (0, 0, positionoffsetz);
  }

  radiusvector = (checkradius, checkradius, checkheight);
  aabbmin = position - radiusvector;
  aabbmax = position + radiusvector;
  contents = contentsoverride;

  if(!isDefined(contents)) {
    contents = physics_createcontents(["physicscontents_vehicle"]);
  }

  ignorelist = ignorelistoverride;

  if(!isDefined(ignorelist)) {
    ignorelist = [];
    ignorelist[ignorelist.size] = vehicle_tracking_getgameinstances("emp_drone");
    ignorelist[ignorelist.size] = vehicle_tracking_getgameinstances("cruise_predator");

    if(isDefined(level.supportdrones)) {
      ignorelist[ignorelist.size] = level.supportdrones;
    }

    ignorelist = scripts\engine\utility::array_combine_multiple(ignorelist);
  }

  vehicles = physics_aabbbroadphasequery(aabbmin, aabbmax, contents, ignorelist);

  if(isDefined(vehicles) && vehicles.size > 0) {
    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.vehiclename)) {
        var_deca1b39a5edfa25 = vehicle_spawn_getleveldataforvehicle(vehicle.vehiclename);
        _minradius = undefined;

        if(isDefined(var_deca1b39a5edfa25)) {
          _minradius = var_deca1b39a5edfa25.clearancecheckradius;
        }

        if(!isDefined(_minradius)) {
          _minradius = leveldata.clearancecheckminradii[vehicle.vehiclename];
        }

        if(!isDefined(_minradius)) {
          continue;
        }

        mindist2dsqr = pow(minradius + _minradius, 2);

        if(isDefined(mindist2dsqr) && mindist2dsqr < distance2dsquared(vehicle.origin, position)) {
          continue;
        }

        return false;
      }
    }
  }

  return true;
}

function vehicle_spawn_setclearancecheckminradius(ref, minradius) {
  leveldata = vehicle_spawn_getleveldata();
  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(ref);

  if(isDefined(leveldataforvehicle)) {
    leveldataforvehicle.clearancecheckradius = minradius;
    return;
  }

  leveldata.clearancecheckminradii[ref] = minradius;
}

function function_b09e91c2e808dbcd(spawndata, faildata) {}

function function_fa044e2304e9e1a4() {
  thread function_fc6ead687e73f25f();
}

function function_fc6ead687e73f25f() {
  spawndata = spawnStruct();
  copyvehiclespawndata(self.basevehiclespawndata, spawndata);
  faildata = spawnStruct();
  vehicle = vehicle_spawn_waitandrespawn(spawndata.targetname, spawndata, faildata);
}

function function_284795e4a9e3762c() {
  thread function_9a5d0431afaf5b80();
}

function function_9a5d0431afaf5b80() {
  oldspawndata = getvehiclespawndata(self);

  if(isDefined(oldspawndata.basevehiclespawndata)) {
    oldspawndata = oldspawndata.basevehiclespawndata;
  }

  spawndata = spawnStruct();
  copyvehiclespawndata(oldspawndata, spawndata);
  faildata = spawnStruct();
  vehicle = vehicle_spawn_waitandrespawn(self.vehiclename, spawndata, faildata);
}

function vehicle_spawn_waitandrespawn(ref, spawndata, faildata) {
  level endon("game_ended");
  level endon("cancel_pending_vehicle_respawns");
  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(ref);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  leveldata = vehicle_spawn_getleveldata();
  delay = undefined;

  if(leveldata.respawndelayoverride != 0) {
    delay = leveldata.respawndelayoverride;
  } else if(leveldata.respawndelaymatchrules != 0) {
    delay = leveldata.respawndelaymatchrules;
  } else if(isDefined(leveldataforvehicle.respawndelay)) {
    delay = leveldataforvehicle.respawndelay;
  } else {
    delay = leveldata.respawndelay;
  }

  if(delay >= 1) {
    if(delay >= 9999) {
      return undefined;
    }
  } else {}

  for(delay = 1; true; delay = 5) {
    wait delay;

    if(vehicle_spawn_canspawnVehicle(ref)) {
      if(issharedfuncdefined(ref, "alterRespawnData")) {
        spawndata = [[getsharedfunc(ref, "alterRespawnData")]](spawndata);
      }

      var_c65c40f752ce7d39 = 1;

      if(!var_c65c40f752ce7d39 || vehicle_spawn_checkspawnclearance(spawndata.origin, ref)) {
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(ref, spawndata, faildata);

        if(!isDefined(vehicle)) {
          continue;
        }

        return vehicle;
      }
    }
  }
}

function vehicle_spawn_preventrespawn(vehicle) {
  vehicle.preventrespawn = 1;
}

function vehicle_spawn_cancelpendingrespawns() {
  level notify("cancel_pending_vehicle_respawns");
}

function function_6c65df1f40e10037() {
  if(istrue(self.donotwatchabandoned)) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  if(self.occupants.size > 0) {
    return;
  }

  if(isDefined(self.turretoccupants) && self.turretoccupants.size > 0) {
    return;
  }

  if(isDefined(self.ridingplayers) && self.ridingplayers.size > 0) {
    return;
  }

  self endon("death");
  self endon("stop_watching_abandoned");
  wait 60;

  if(scripts\cp_mp\utility\game_utility::getgametype() == "wm") {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
}

function vehicle_spawn_gamemodesupportsabandonedtimeout(ishusk) {
  defaultvalue = 1;

  if(utility::ismp() && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    defaultvalue = 0;
  }

  if(utility::iscp() && level.gametype != "cp_survival") {
    defaultvalue = 0;
  }

  if(ishusk && istrue(level.var_45496c9df00f2bd4)) {
    defaultvalue = 1;
  }

  dvar = ter_op(ishusk, @ "hash_1d79ef11c80ba28f", @ "hash_aa11765fde7e66f6");
  return getdvarint(dvar, defaultvalue);
}

function vehicle_spawn_watchabandoned() {
  ishusk = isvehiclehusk();

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsabandonedtimeout(ishusk)) {
    return;
  }

  if(istrue(self.watchingabandoned)) {
    return;
  }

  if(self.occupants.size > 0) {
    return;
  }

  if(isDefined(self.turretoccupants) && self.turretoccupants.size > 0) {
    return;
  }

  if(isDefined(self.ridingplayers) && self.ridingplayers.size > 0) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  if(istrue(self.donotwatchabandoned)) {
    return;
  }

  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(function_d93ec4635290febd());

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  if(!isDefined(leveldataforvehicle.abandonedtimeoutcallback)) {
    return;
  }

  self.watchingabandoned = 1;
  self endon("death");
  self endon("stop_watching_abandoned");
  leveldata = vehicle_spawn_getleveldata();
  delay = undefined;

  if(leveldata.abandonedtimeoutoverride != 0 && !ishusk) {
    delay = leveldata.abandonedtimeoutoverride;
  } else if(leveldata.abandonedtimeoutmatchrules != 0 && !ishusk) {
    delay = leveldata.abandonedtimeoutmatchrules;
  } else if(isDefined(leveldataforvehicle.abandonedtimeoutdelay) && !ishusk) {
    delay = leveldataforvehicle.abandonedtimeoutdelay;
  } else {
    delay = leveldata.abandonedtimeoutdelay;
  }

  if(scripts\cp_mp\vehicles\vehicle::isvehicleboat() && self vehicle_isonground()) {
    delay *= 0.3;
  }

  if(delay >= 1) {
    if(delay >= 9999) {
      return;
    }
  } else {
    delay = 1;
  }

  wait delay;
  thread vehicle_spawn_abandonedtimeout();
}

function vehicle_spawn_stopwatchingabandoned() {
  self notify("stop_watching_abandoned");
  self.watchingabandoned = undefined;
}

function vehicle_spawn_abandonedtimeout() {
  vehicle_spawn_stopwatchingabandoned();
  self.donotwatchabandoned = 1;
  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle(function_d93ec4635290febd());
  self thread[[leveldataforvehicle.abandonedtimeoutcallback]]();
}

function function_357783d7c1d96273() {
  vehicle_spawn_stopwatchingabandoned();
  self.donotwatchabandoned = 1;
  thread vehicle_spawn_abandonedtimeoutcallback();
}

function vehicle_spawn_abandonedtimeoutcallback() {
  damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();

  if(damagestate != "heavy") {
    heavystatemaxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth(self);

    if(isDefined(heavystatemaxhealth)) {
      self.health = int(min(heavystatemaxhealth, self.health));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
    }

    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate("heavy", damagestate);
  }
}

function function_17bb29fece7da497(vehicleref) {
  return vehicle_spawn_getleveldataforvehicle(vehicleref).timeoutonabandoneddelay;
}

function function_aade62c6cf163888(vehicleref) {
  data = function_29b4292c92443328(vehicleref);

  if(isDefined(data.husk) && istrue(data.husk.hashusk)) {
    return function_29b4292c92443328(vehicleref).husk.vdef;
  }
}

function function_89cda5ba9bfc8d56(vehicleref) {
  return function_29b4292c92443328(vehicleref).transitionparts;
}

function vehicle_spawn_initdev() {
  setdevdvarifuninitialized(@ "hash_d451d5012c6af909", 0);
  setdevdvarifuninitialized(@ "scr_spawnvehicle", "<dev string:x437>");
  setdevdvarifuninitialized(@ "hash_29ad65e1f5a10c7d", "<dev string:x437>");
  setdevdvarifuninitialized(@ "hash_37b6962333b896f9", "<dev string:x437>");
  setdevdvarifuninitialized(@ "hash_c6bdc7ccd09be1d9", "<dev string:x437>");
  setdevdvarifuninitialized(@ "hash_9ec4150c7e03e3ee", "<dev string:x437>");
  setdevdvarifuninitialized(@ "hash_1f347fd0c3d771a2", 0);
  setdevdvarifuninitialized(@ "hash_8fdbbb498db9480a", 60);
  setdevdvarifuninitialized(@ "hash_e547fe8dfe1679f6", 0);
  setdevdvarifuninitialized(@ "hash_36374c04e23480b6", 30);
}

# /