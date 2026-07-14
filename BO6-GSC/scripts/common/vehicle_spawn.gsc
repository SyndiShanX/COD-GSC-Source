/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_spawn.gsc
********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\engine\utility;
#namespace vehicle_spawn;

function get_data(vehicleref, create) {
  if(create && (!vehicle::has_data(vehicleref) || !isDefined(vehicle::get_data(vehicleref).spawn))) {
    data = undefined;

    if(!vehicle::has_data(vehicleref)) {
      data = spawnStruct();
    } else {
      data = vehicle::get_data(vehicleref);
    }

    data.spawn = spawnStruct();
    data.spawn.maxinstancecount = 0;
    data.spawn.priority = 50;
    vehicle::add_data(vehicleref, data);
  }

  if(vehicle::has_data(vehicleref)) {
    return vehicle::get_data(vehicleref).spawn;
  }
}

function function_de8a2dba98bdeb4e(vehicleref, spawndata) {
  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  data = vehicle::get_data(vehicleref);
  spawndata.script_vehicleref = data.ref;

  if(isDefined(spawndata.vehicleoverride)) {
    spawndata.vehicletype = spawndata.vehicleoverride;
  } else if(spawndata.initai && isDefined(data.ai.vehicle)) {
    spawndata.vehicletype = data.ai.vehicle;
  } else if(isDefined(data.vehicle)) {
    spawndata.vehicletype = data.vehicle;
  }

  model = data.model;

  if(isDefined(spawndata.script_modelname)) {
    model = spawndata.script_modelname;
  } else if(spawndata.initai && isDefined(data.ai.model)) {
    model = data.ai.model;
  }

  if(isDefined(spawndata.var_305ce2bb6ec0993d)) {
    skin = utility::random(strtok(spawndata.var_305ce2bb6ec0993d, ","));

    if(skin != "base") {
      spawndata.modelname = skin + "::" + model;
    } else {
      spawndata.modelname = model;
    }
  } else if(isDefined(data.skinoverride) && data.skinoverride != "" && model == data.model) {
    spawndata.modelname = data.skinoverride + "::" + model;
  } else {
    spawndata.modelname = model;
  }

  return spawndata;
}

function function_456e98b54b607964(vehicleref, spawndata, fallbackvehicletype) {
  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  data = vehicle::get_data(vehicleref);
  spawndata.script_vehicleref = data.husk.ref;
  spawndata.vehicletype = data.vehicle;

  if(data.husk.var_883a7fffbc09c22f && isDefined(data.husk.models) && data.husk.models.size > 0) {
    modelstruct = utility::random(data.husk.models);
    spawndata.modelname = modelstruct.compositemodel ?? modelstruct.model;
  } else {
    spawndata.modelname = data.husk.model;
  }

  if(!isDefined(spawndata.vehicletype)) {
    spawndata.vehicletype = fallbackvehicletype;
  }

  spawndata.dospawnedcallback = 0;
  return spawndata;
}

function function_93f7a778f0b3b5cb(vehicle, vehicleref) {
  data = vehicle::get_data(vehicleref);
  spawndata = spawnStruct();
  spawndata.origin = vehicle.origin;
  spawndata.angles = vehicle.angles;
  spawndata.initialvelocity = anglestoup(vehicle.angles) * data.husk.belowvelocityscale;
  spawndata.damageableparts = vehicle_damage::function_62b5a7480945627a(vehicleref, vehicle.damageableparts);
  spawndata.basevehiclespawndata = vehicle vehicle_tracking::function_d2bad728e2163c17();
  spawndata.contents = vehicle.contents;
  spawndata.mtx = vehicle.mtx;
  spawndata.var_5c2a5a3e858d8962 = vehicle.var_5c2a5a3e858d8962;

  if(isDefined(vehicle_occupancy::function_921d1edcf33652ee(vehicleref, "driver"))) {
    spawndata.var_6b0d261794318b6d = vectortoangles(rotatevectorinverted(anglesToForward(vehicle getturretworldangles()), vehicle.angles));
  }

  if(isDefined(spawndata.basevehiclespawndata)) {
    spawndata.var_305ce2bb6ec0993d = spawndata.basevehiclespawndata.var_305ce2bb6ec0993d;
  }

  if(vehicle vehicle_getspeed() > data.husk.momentumthreshold) {
    spawndata.initialvelocity = vehicle vehicle_getvelocity() * data.husk.abovevelocityscale;
  }

  if(level.var_caec56ac747c5a55) {
    spawndata.corpses = [];

    foreach(ent in vehicle getlinkedchildren()) {
      if(ent isragdoll()) {
        continue;
      }

      if(isactor(ent) && !isalive(ent) || isactorcorpse(ent)) {
        tagindex = ent function_8cc549d92d18d4c7();

        if(isDefined(tagindex)) {
          tagname = vehicle function_cb497b712374573a(tagindex);

          if(isDefined(tagname)) {
            if(!isarray(spawndata.corpses[tagname])) {
              spawndata.corpses[tagname] = [];
            }

            spawndata.corpses[tagname][spawndata.corpses[tagname].size] = ent;
          }
        }
      }
    }
  }

  spawndata.isphysicsvehicle = vehicle vehicle_isphysveh();
  spawndata.isamphibious = vehicle function_5bf8fedff42637e2();
  spawndata.isgroundvehicle = vehicle vehphys_isgroundvehicle();
  return spawndata;
}

function function_ab128b19257dc458(vehicleref, basevehiclespawndata) {
  basevehiclespawndata.script_vehicleref = vehicleref;
  huskspawndata = {
    #basevehiclespawndata: basevehiclespawndata
  };
  vehicle_tracking::function_2b6c8c165ab5f521(basevehiclespawndata, huskspawndata);
  return huskspawndata;
}

function can_spawn_vehicle(vehicleref, owner, team, spawntype) {
  if(level.debugvehiclespawns) {
    println("<dev string:x24>" + (getxhashsourcename(vehicleref) ?? "<dev string:x57>"));
  }

  if(!isDefined(vehicleref)) {
    if(level.debugvehiclespawns) {
      println("<dev string:x64>");
    }

    return 0;
  }

  if(!vehicle::has_data(vehicleref)) {
    if(level.debugvehiclespawns) {
      println("<dev string:x96>" + getxhashsourcename(vehicleref));
    }

    return 0;
  }

  data = vehicle::get_data(vehicleref);
  spawndata = get_data(vehicleref);

  if(!data || !spawndata) {
    if(level.debugvehiclespawns) {
      println("<dev string:xcb>" + getxhashsourcename(vehicleref));
    }

    return 0;
  }

  vehicleref = data.ref;

  if(!vehicleref) {
    if(level.debugvehiclespawns) {
      println("<dev string:x108>" + data.vehicle);
    }

    return 0;
  }

  if(!vehicle_tracking::can_spawn_vehicle()) {
    if(level.debugvehiclespawns) {
      println("<dev string:x14d>" + vehicleref + "<dev string:x18d>" + vehicle_tracking::get_vehicle_count() + "<dev string:x192>" + level.maxvehiclecount);
    }

    return 0;
  }

  if(utility::issharedfuncdefined(#"vehicle_spawn", #"canspawnvehicle") && !utility::callsharedfunc(#"vehicle_spawn", #"canspawnvehicle", vehicleref)) {
    if(level.debugvehiclespawns) {
      println("<dev string:x199>" + vehicleref);
    }

    return 0;
  }

  if(vehicle_tracking::function_b77f352821482252(vehicleref) && vehicle_tracking::function_279695c41be653f(vehicleref, owner, team, spawntype)) {
    if(level.debugvehiclespawns) {
      println("<dev string:x1ec>" + vehicleref);
    }

    return 0;
  }

  if(!level.ignorevehicletypeinstancelimit && isDefined(spawndata.maxinstancecount) && vehicle_tracking::function_ff2863e4171248be(vehicleref).size >= spawndata.maxinstancecount) {
    if(level.debugvehiclespawns) {
      println("<dev string:x227>" + vehicleref);
    }

    return 0;
  }

  if(isDefined(spawndata.canspawncallback)) {
    return [[spawndata.canspawncallback]](owner, team);
  }

  return 1;
}

function function_8738b8aa2d9b9586(structnameoptional) {
  while(!level.var_3985cc8cf0923257) {
    waitframe();
  }

  var_e58c88b8ee826d55 = [];

  foreach(ref, data in level.var_a7bf93687486b5ba) {
    if(isstring(ref)) {
      continue;
    }

    if(!(isDefined(data.spawn) && isDefined(data.spawn.var_33390c2e78b276d9))) {
      continue;
    }

    var_e58c88b8ee826d55[data.spawn.var_33390c2e78b276d9] = data;
  }

  points = [];
  structs = [];

  foreach(targetname, data in var_e58c88b8ee826d55) {
    structs = arraycombine(structs, utility::getStructArray(targetname, "targetname"));
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

    points[num] = [var_e58c88b8ee826d55[struct.script_vehicleref].ref, struct.origin, struct.angles, struct.script_team];
  }

  return points;
}

function add_spawn_struct(vehicleref, origin, angles, targetname, vehicletype, script_noteworthy) {
  if(!(isDefined(vehicleref) && isDefined(origin))) {
    assertmsg("<dev string:x261>");
    return;
  }

  if(!isDefined(vehicletype)) {
    vehicletype = get_vehicle_asset(vehicleref);
  }

  if(!isDefined(vehicletype)) {
    assertmsg("<dev string:x2b7>" + getxhashsourcename(vehicleref) + "<dev string:x2ea>");
    return;
  }

  struct = spawnStruct();
  struct.origin = origin;
  struct.angles = angles;
  struct.targetname = targetname;

  if(isstring(vehicleref)) {
    struct.script_vehicleref = vehicleref;
  } else if(isxhashasset(vehicleref)) {
    struct.script_vehiclebundle = vehicleref;
  }

  struct.vehicletype = vehicletype;
  struct.script_noteworthy = script_noteworthy;
  vehiclehash = vehicle::function_451bd53633bae879(vehicleref);

  if(!isDefined(level.vehicle_spawns[vehiclehash])) {
    level.vehicle_spawns[vehiclehash] = [];
  }

  level.vehicle_spawns[vehiclehash][level.vehicle_spawns[vehiclehash].size] = struct;
  utility::addstruct(struct);
}

function function_8edce56318b85be7(vehicleref, requireflags, excludeflags, randomizespawns = 1) {
  if(!isDefined(vehicleref)) {
    return [];
  }

  if(!isDefined(requireflags)) {
    requireflags = [];
  }

  if(!isDefined(excludeflags)) {
    excludeflags = [1, 2, 4];
  }

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  structs = level.vehicle_spawns[vehicleref];

  if(!isDefined(structs) || structs.size == 0) {
    return [];
  }

  foreach(flag in requireflags) {
    structs = function_c099079754c457aa(structs, flag);
  }

  foreach(flag in excludeflags) {
    structs = function_4c65f104a4b40ec3(structs, flag);
  }

  if(randomizespawns && structs.size > 1) {
    structs = utility::array_randomize(structs);
  }

  return structs;
}

function get_vehicle_asset(vehicleref) {
  if(!vehicle::has_data(vehicleref)) {
    return undefined;
  }

  data = vehicle::get_data(vehicleref);

  if(isDefined(data)) {
    return data.vehicle;
  }
}

function function_4c65f104a4b40ec3(spawnstructs, bit) {
  flagmask = 1 << bit - 1;
  filteredstructs = [];

  foreach(struct in spawnstructs) {
    if(isDefined(struct.spawnflags) && struct.spawnflags &flagmask) {
      continue;
    }

    filteredstructs[filteredstructs.size] = struct;
  }

  return filteredstructs;
}

function function_c099079754c457aa(spawnstructs, bit) {
  flagmask = 1 << bit - 1;
  filteredstructs = [];

  foreach(struct in spawnstructs) {
    if(isDefined(struct.spawnflags) && struct.spawnflags &flagmask) {
      filteredstructs[filteredstructs.size] = struct;
    }
  }

  return filteredstructs;
}

function set_flag(flag, bool = 1) {
  if(!isDefined(self.spawnflags)) {
    self.spawnflags = 0;
  }

  mask = 1 << flag - 1;

  if(bool) {
    self.spawnflags |= mask;
    return;
  }

  self.spawnflags &= ~mask;
}

function has_flag(flag) {
  return isDefined(self) && isDefined(self.spawnflags) && self.spawnflags & 1 << flag - 1;
}

function function_7cb78fe251a14b5b() {
  defaultvalue = !isDefined(level.gametypebundle) || !level.gametypebundle.var_b220cf080f65ec52;
  return getdvarint(@ "hash_bd25469fa7e9f44f", defaultvalue);
}

function function_e4d68d1fa03b6917() {
  if(!isDefined(level.var_a7bf93687486b5ba)) {
    return;
  }

  utility::flag_wait("scriptables_ready");

  if(utility::issharedfuncdefined(#"vehiclespawn", #"shouldspawnvehicles") && !utility::callsharedfunc(#"vehiclespawn", #"shouldspawnvehicles")) {
    return;
  }

  foreach(vehicleref in vehicle::function_75acd2d48a8f3605(1)) {
    if(!can_spawn_vehicle(vehicleref)) {
      continue;
    }

    foreach(spawn in function_8edce56318b85be7(vehicleref, [4], [1, 2])) {
      if(utility::callsharedfunc(#"poi", #"isSystemActive") && !utility::callsharedfunc(#"poi", #"isactive", spawn.origin)) {
        continue;
      }

      if(isDefined(spawn.used)) {
        continue;
      }

      spawn.used = 1;
      spawn vehicle::function_dcbcdc00863e94d6();
    }
  }
}

function init() {
  assert(isDefined(level.vehicle), "<dev string:x32a>");
  assert(!isDefined(level.vehicle.spawn), "<dev string:x360>");
  leveldata = spawnStruct();
  level.vehicle.spawn = leveldata;
  leveldata.databyref = [];
  leveldata.spawnfromstructsdelayornotify = 5;

  if(utility::callsharedfunc(#"game", #"isusingmatchrulesdata")) {
    leveldata.respawndelaymatchrules = utility::callsharedfunc(#"game", #"getmatchrulesdata", "commonOption", "vehicleRespawnDelay") ?? 0;
    leveldata.abandonedtimeoutmatchrules = utility::callsharedfunc(#"game", #"getmatchrulesdata", "commonOption", "vehicleAbandonedTimeout") ?? 0;
    leveldata.vehicleAbandonedTimeoutEnabled = utility::callsharedfunc(#"game", #"getmatchrulesdata", "commonOption", "vehicleAbandonedTimeoutEnabled") ?? 1;
    leveldata.vehicleHuskTimeoutEnabled = utility::callsharedfunc(#"game", #"getmatchrulesdata", "commonOption", "vehicleHuskTimeoutEnabled") ?? 1;
  } else {
    leveldata.respawndelaymatchrules = 0;
    leveldata.abandonedtimeoutmatchrules = 0;
    leveldata.vehicleAbandonedTimeoutEnabled = 0;
    leveldata.vehicleHuskTimeoutEnabled = 0;
  }

  leveldata.respawndelayoverride = getdvarint(@ "hash_1f347fd0c3d771a2", 0);
  leveldata.abandonedtimeoutoverride = getdvarint(@ "hash_e547fe8dfe1679f6", 0);
  leveldata.respawndelay = getdvarint(@ "hash_8fdbbb498db9480a", 60);
  leveldata.abandonedtimeoutdelay = getdvarint(@ "hash_36374c04e23480b6", 30);

  level.debugvehiclespawns = getdvarint(@ "scr_vehicle_spawn_debug", 0) == 1;

  function_eecac55f712ae63d();
  utility::callsharedfunc(#"vehicle_spawn", #"init");
  level.ignorevehicletypeinstancelimit = getdvarint(@ "hash_37f76437c65cd04e", 1);
  init_late();

  if(level.projectbundle.var_53c4124af039142e) {
    level thread find_vehicle_spawns();
    return;
  }

  level thread function_e299a3a85c5104f8();
}

function private init_late() {
  if(utility::issharedfuncdefined(#"vehicle_spawn", #"initLate")) {
    [[utility::getsharedfunc(#"vehicle_spawn", #"initLate")]]();
  }
}

function private function_e299a3a85c5104f8() {
  level.vehicle_spawns = [];
  var_9dc8537849d839c2 = [];

  foreach(key, array in level.struct_class_names["script_vehicleref"]) {
    foreach(struct in array) {
      if(isstring(struct.script_vehiclerefs)) {
        foreach(vehicleref in strtok(struct.script_vehiclerefs, ",")) {
          if(!isDefined(var_9dc8537849d839c2[vehicleref])) {
            var_9dc8537849d839c2[vehicleref] = vehicle::function_451bd53633bae879(vehicleref) ?? 0;
          }

          hash = var_9dc8537849d839c2[vehicleref];

          if(!hash) {
            if(level.debugvehiclespawns) {
              println("<dev string:x394>" + vehicleref);
            }

            continue;
          }

          if(!isDefined(level.vehicle_spawns[hash])) {
            level.vehicle_spawns[hash] = [];
          }

          if(!isDefined(struct.script_vehiclebundle)) {
            struct.script_vehiclebundle = hash;
          }

          level.vehicle_spawns[hash][level.vehicle_spawns[hash].size] = struct;
        }

        continue;
      }

      if(!isDefined(var_9dc8537849d839c2[key])) {
        var_9dc8537849d839c2[key] = vehicle::function_451bd53633bae879(key) ?? 0;
      }

      hash = var_9dc8537849d839c2[key];

      if(!hash) {
        if(level.debugvehiclespawns) {
          println("<dev string:x394>" + key);
        }

        continue;
      }

      if(!isDefined(level.vehicle_spawns[hash])) {
        level.vehicle_spawns[hash] = [];
      }

      struct.script_vehiclebundle = hash;
      level.vehicle_spawns[hash][level.vehicle_spawns[hash].size] = struct;
    }
  }

  foreach(key, array in level.struct_class_names["script_vehiclebundle"]) {
    hash = hashcat(%"vehiclebundle:", key);

    if(!isDefined(level.vehicle_spawns[hash])) {
      level.vehicle_spawns[hash] = [];
    }

    foreach(struct in array) {
      struct.script_vehiclebundle = hash;
      level.vehicle_spawns[hash][level.vehicle_spawns[hash].size] = struct;
    }
  }
}

function private find_vehicle_spawns() {
  level.vehicle_spawns = level.struct_class_names["vehicletype"];

  foreach(key, array in level.vehicle_spawns) {
    foreach(struct in array) {
      if(!isstring(struct.script_vehiclerefs)) {
        continue;
      }

      foreach(vehicleref in strtok(struct.script_vehiclerefs, ",")) {
        if(!vehicle::has_data(vehicleref)) {
          if(level.debugvehiclespawns) {
            println("<dev string:x394>" + vehicleref);
          }

          continue;
        }

        hash = get_vehicle_asset(vehicleref);

        if(!isDefined(level.vehicle_spawns[hash])) {
          level.vehicle_spawns[hash] = [];
        }

        level.vehicle_spawns[hash] = arraycombineunique(level.vehicle_spawns[hash], [struct]);
      }
    }
  }

  foreach(key, array in level.struct_class_names["script_vehiclebundle"]) {
    hash = getxhashasset(key);

    if(!isDefined(level.vehicle_spawns[hash])) {
      level.vehicle_spawns[hash] = [];
    }

    foreach(struct in array) {
      struct.vehicletype = hash;
      level.vehicle_spawns[hash][level.vehicle_spawns[hash].size] = struct;
    }
  }
}

function function_a7d53b59eb27fac6(vehicledataa, vehicledatab) {
  return vehicledataa.priority >= vehicledatab.priority;
}

function get_level_data() {
  assert(isDefined(level.vehicle), "<dev string:x3e6>");
  assert(isDefined(level.vehicle.spawn), "<dev string:x433>");
  return level.vehicle.spawn;
}

function is_vehicle_spawn_struct() {
  return self.vehicletype && self.script_vehicleref || self.script_vehiclebundle;
}

function function_eecac55f712ae63d() {
  leveldata = get_level_data();
  leveldata.clearancecheckminradii = [];
}

function function_c49e68f891a06e6f(position, vehicleref, contentsoverride, ignorelistoverride, positionoffsetz) {
  leveldata = get_level_data();
  checkradius = 200;
  checkheight = 200;
  leveldataforvehicle = get_data(vehicleref);
  assert(isDefined(leveldataforvehicle), "<dev string:x486>");
  minradius = leveldataforvehicle.clearancecheckradius;

  if(!isDefined(minradius)) {
    minradius = leveldata.clearancecheckminradii[vehicleref];
  }

  assert(isDefined(minradius), "<dev string:x4cf>" + getxhashsourcename(vehicleref) + "<dev string:x500>");

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
    ignorelist[ignorelist.size] = vehicle_tracking::function_ff2863e4171248be("emp_drone");
    ignorelist[ignorelist.size] = vehicle_tracking::function_ff2863e4171248be("cruise_predator");

    if(isDefined(level.supportdrones)) {
      ignorelist[ignorelist.size] = level.supportdrones;
    }

    ignorelist = utility::array_combine_multiple(ignorelist);
  }

  ents = physics_aabbbroadphasequery(aabbmin, aabbmax, contents, ignorelist);

  if(isDefined(ents) && ents.size > 0) {
    foreach(ent in ents) {
      if(isDefined(ent vehicle::get_ref())) {
        var_2e8bb41846790a42 = get_data(ent vehicle::get_ref());
        _minradius = undefined;

        if(isDefined(var_2e8bb41846790a42)) {
          _minradius = var_2e8bb41846790a42.clearancecheckradius;
        }

        if(!isDefined(_minradius)) {
          _minradius = leveldata.clearancecheckminradii[ent vehicle::get_ref()];
        }

        if(!isDefined(_minradius)) {
          continue;
        }

        mindist2dsqr = pow(minradius + _minradius, 2);

        if(mindist2dsqr < distance2dsquared(ent.origin, position)) {
          continue;
        }

        return false;
      }

      if(isPlayer(ent)) {
        if(distance2dsquared(ent.origin, position) < minradius * minradius) {
          return false;
        }
      }
    }
  }

  return true;
}

function function_3a15dcf060e81fe(ref, minradius) {
  leveldata = get_level_data();
  leveldataforvehicle = get_data(ref);

  if(isDefined(leveldataforvehicle)) {
    leveldataforvehicle.clearancecheckradius = minradius;
    return;
  }

  leveldata.clearancecheckminradii[ref] = minradius;
}

function function_79bec4a35ef5586d() {
  thread function_c3e17ab979acc6e4();
}

function function_c3e17ab979acc6e4() {
  spawndata = spawnStruct();
  vehicle_tracking::function_2b6c8c165ab5f521(vehicle_tracking::function_d53ca0a2fd01145f(), spawndata);
  faildata = spawnStruct();
  vehicle = function_d9bf163821eb62c6(spawndata.script_vehicleref, spawndata, faildata);
}

function function_fd587db0cd7ec2d() {
  thread function_db0e1e30b11b3197();
}

function function_db0e1e30b11b3197() {
  oldspawndata = vehicle_tracking::function_d53ca0a2fd01145f();
  spawndata = spawnStruct();
  vehicle_tracking::function_2b6c8c165ab5f521(oldspawndata, spawndata);
  faildata = spawnStruct();
  vehicle = function_d9bf163821eb62c6(vehicle::get_ref(), spawndata, faildata);
}

function function_d9bf163821eb62c6(ref, spawndata, faildata) {
  level endon("game_ended");
  level endon("cancel_pending_vehicle_respawns");
  leveldataforvehicle = get_data(ref);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  leveldata = get_level_data();
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

    if(can_spawn_vehicle(ref)) {
      if(utility::issharedfuncdefined(ref, #"alterRespawnData")) {
        spawndata = [[utility::getsharedfunc(ref, #"alterRespawnData")]](spawndata);
      }

      if(function_c49e68f891a06e6f(spawndata.origin, ref)) {
        vehicle = vehicle::spawn(ref, spawndata, faildata);

        if(!isDefined(vehicle)) {
          continue;
        }

        return vehicle;
      }
    }
  }
}

function prevent_respawn() {
  if(vehicle::is_vehicle()) {
    vehicle_tracking::function_d53ca0a2fd01145f() set_flag(8);
    return;
  }

  set_flag(8);
}

function function_78ba3de276c30bc4() {
  level notify("cancel_pending_vehicle_respawns");
}

function function_dbc69ecc19a5dca3() {
  self notify("a49e42bc4bb8b7d6");
  self endon("a49e42bc4bb8b7d6");

  if(self.donotwatchabandoned) {
    return;
  }

  self endon("death");
  self endon("stop_watching_abandoned");
  wait 60;
  vehicle_occupancy::function_d96c2b596c63c80e();
}

function function_438bb45fa24276e7(ishusk) {
  leveldata = get_level_data();
  return ishusk ? leveldata.vehicleHuskTimeoutEnabled : leveldata.vehicleAbandonedTimeoutEnabled;
}

function watch_abandoned() {
  ishusk = vehicle::is_husk();

  if(!function_438bb45fa24276e7(ishusk)) {
    return;
  }

  if(self.watchingabandoned) {
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

  if(self.isdestroyed) {
    return;
  }

  if(self.donotwatchabandoned) {
    return;
  }

  leveldataforvehicle = get_data(vehicle::get_ref());

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  if(!isDefined(leveldataforvehicle.abandonedtimeoutcallback)) {
    return;
  }

  self.watchingabandoned = 1;
  self endon("death");
  self endon("stop_watching_abandoned");
  leveldata = get_level_data();
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

  if(vehicle::is_boat() && self vehicle_isonground()) {
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
  thread abandoned_timeout();
}

function stop_watching_abandoned() {
  self notify("stop_watching_abandoned");
  self.watchingabandoned = undefined;
}

function abandoned_timeout() {
  stop_watching_abandoned();
  self.donotwatchabandoned = 1;
  leveldataforvehicle = get_data(vehicle::get_ref());
  self thread[[leveldataforvehicle.abandonedtimeoutcallback]]();
}

function stuck_timeout() {
  stop_watching_abandoned();
  self.donotwatchabandoned = 1;
  thread abandoned_timeout_callback();
}

function abandoned_timeout_callback() {
  damagestate = vehicle_damage::get_state();

  if(damagestate != "heavy") {
    heavystatemaxhealth = vehicle_damage::function_8c4b44320250db18(self);

    if(isDefined(heavystatemaxhealth)) {
      newhealth = int(min(heavystatemaxhealth, self.health));

      if(utility::issp()) {
        self setnormalhealth(newhealth / self.maxhealth);
      } else {
        self.health = newhealth;
      }

      vehicle_omnvar::function_ca8a66bb3a611610(self);
      vehicle_damage::set_state("heavy", damagestate);
    }
  }
}

function get_abandoned_timeout(vehicleref) {
  return get_data(vehicleref).timeoutonabandoneddelay;
}

function function_b65e41134b5a89af(vehicleref) {
  return vehicle::get_data(vehicleref).transitionparts;
}

function init_dev() {
  setdevdvarifuninitialized(@ "scr_spawnvehicle", "<dev string:x505>");
  setdevdvarifuninitialized(@ "hash_37b6962333b896f9", "<dev string:x505>");
  setdevdvarifuninitialized(@ "hash_8af4302fef6d5e56", "<dev string:x505>");
  setdevdvarifuninitialized(@ "hash_c6bdc7ccd09be1d9", "<dev string:x505>");
  setdevdvarifuninitialized(@ "hash_9ec4150c7e03e3ee", "<dev string:x505>");
  setdevdvarifuninitialized(@ "hash_1f347fd0c3d771a2", 0);
  setdevdvarifuninitialized(@ "hash_8fdbbb498db9480a", 60);
  setdevdvarifuninitialized(@ "hash_e547fe8dfe1679f6", 0);
  setdevdvarifuninitialized(@ "hash_36374c04e23480b6", 30);
}

# /