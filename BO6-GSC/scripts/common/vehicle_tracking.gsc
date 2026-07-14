/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_tracking.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace vehicle_tracking;

function spawn_vehicle(spawndata, faildata) {
  function_e0a8c3f4eeb707e(spawndata);

  if(!can_spawn_vehicle()) {
    if(isDefined(faildata)) {
      faildata.fail = "total_limit_exceeded";
    }

    if(level.debugvehiclespawns) {
      println("<dev string:x24>" + spawndata.modelname + "<dev string:x51>" + level.vehiclecount + "<dev string:x6b>" + level.maxvehiclecount);
    }

    return undefined;
  }

  if(utility::issharedfuncdefined(#"game", #"isvalidpointinbounds")) {
    if(![[utility::getsharedfunc(#"game", #"isvalidpointinbounds")]](spawndata.origin)) {
      if(isDefined(faildata)) {
        faildata.fail = "spawn_invalid_location";
      }

      return undefined;
    }
  }

  vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname ?? spawndata.script_vehicleref ?? spawndata.vehicletype, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback);

  if(!isDefined(vehicle.vehiclename)) {
    vehicle.vehiclename = spawndata.vehicletype;
  }

  if(!isDefined(vehicle)) {
    if(isDefined(faildata)) {
      faildata.fail = "total_limit_exceeded";
    }

    if(level.debugvehiclespawns) {
      println("<dev string:x88>" + spawndata.modelname);
    }

    return undefined;
  }

  vehicle.spawndata = spawndata;
  level.vehiclecount++;
  callback::callback(#"vehicle_spawn", {
    #spawndata: spawndata, #vehicle: vehicle
  });
  return vehicle;
}

function function_67616b82fb3a0d53(spawndata, faildata) {
  function_e0a8c3f4eeb707e(spawndata);

  vehicle = spawn("script_model", spawndata.origin);
  vehicle.angles = spawndata.angles;
  vehicle.targetname = spawndata.targetname ?? spawndata.script_vehicleref;
  vehicle.owner = spawndata.owner;
  vehicle.spawndata = spawndata;
  vehicle setModel(spawndata.modelname);
  level.vehiclecount++;
  callback::callback(#"vehicle_spawn", {
    #spawndata: spawndata, #vehicle: vehicle
  });
  return vehicle;
}

function spawn_helicopter(owner, origin, angles, type, modelname) {
  faildata = spawnStruct();
  spawndata = spawnStruct();
  spawndata.modelname = modelname;
  spawndata.vehicletype = type;
  spawndata.origin = origin;
  spawndata.angles = angles;
  spawndata.owner = owner;

  if(!can_spawn_vehicle()) {
    if(isDefined(faildata)) {
      faildata.fail = "total_limit_exceeded";
    }

    return undefined;
  }

  vehicle = utility::callsharedfunc(#"vehicle", #"spawnhelicopter", spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname);

  if(!isDefined(vehicle)) {
    if(isDefined(faildata)) {
      faildata.fail = "code";
    }

    return undefined;
  }

  level.vehiclecount++;
  vehicle.spawndata = spawndata;
  callback::callback(#"helicopter_spawn", {
    #spawndata: spawndata, #vehicle: vehicle
  });
  return vehicle;
}

function delete_vehicle(vehicle) {
  vehicle notify("vehicle_deleted");
  level.vehiclecount--;

  if(isDefined(vehicle)) {
    function_f0f2234a3b887900(vehicle);
    vehicle delete();
  }

  return true;
}

function private function_f0f2234a3b887900(vehicle) {
  if(!isDefined(vehicle.linkedchildren)) {
    return;
  }

  foreach(scriptable in vehicle.linkedchildren) {
    if(!isDefined(scriptable)) {
      continue;
    }

    if(isDefined(scriptable.type) && utility::issharedfuncdefined(scriptable.type, #"delete") && scriptable[[utility::getsharedfunc(scriptable.type, #"delete")]]()) {
      continue;
    }

    scriptable notify("death", vehicle.burndownattacker ?? vehicle);
    scriptable utility::script_func("deregisterScriptable");

    if(scriptable getscriptableisreserved()) {
      scriptable freescriptable();
      continue;
    }

    part = scriptable function_84ad2f70189ee7c3();

    if(scriptable getscriptableparthasstate(part, "hidden")) {
      scriptable setscriptablepartstate(part, "hidden");
    }
  }
}

function can_spawn_vehicle(count = 1) {
  return level.vehiclecount + count <= level.maxvehiclecount;
}

function get_vehicle_count() {
  return level.vehiclecount;
}

function reserve_vehicle(count) {
  if(can_spawn_vehicle()) {
    if(!isDefined(count)) {
      level.vehiclecount++;
      return true;
    }

    availablevehicles = level.maxvehiclecount - level.vehiclecount;

    if(count <= availablevehicles) {
      level.vehiclecount += count;
      return true;
    }
  }

  return false;
}

function function_4f76f5b4541acef1(count) {
  if(!isDefined(count)) {
    count = 1;
  }

  level.vehiclecount -= count;

  if(level.vehiclecount < 0) {
    utility::error("<dev string:xc2>");
  }

  level.vehiclecount = int(max(0, level.vehiclecount));
}

function function_d2bad728e2163c17() {
  return self.spawndata;
}

function function_d53ca0a2fd01145f() {
  if(vehicle::is_husk()) {
    return self.basevehiclespawndata;
  }

  return function_d2bad728e2163c17();
}

function function_2b6c8c165ab5f521(from, to) {
  to.modelname = from.modelname;
  to.var_305ce2bb6ec0993d = from.var_305ce2bb6ec0993d;
  to.targetname = from.targetname;
  to.script_vehicleref = from.script_vehicleref;
  to.script_vehiclerefs = from.script_vehiclerefs;
  to.vehicletype = from.vehicletype;
  to.origin = from.origin;
  to.angles = from.angles;
  to.originalorigin = from.originalorigin;
  to.originalangles = from.originalangles;
  to.owner = from.owner;
  to.initialvelocity = from.initialvelocity;
  to.spawntype = from.spawntype;
  to.team = from.team;
  to.script_team = from.script_team;
  to.ref = from.ref;
  to.script_noteworthy = from.script_noteworthy;
  to.script_modelname = from.script_modelname;
  to.script_vehicle_lights_on = from.script_vehicle_lights_on;
  to.script_disconnectpaths = from.script_disconnectpaths;
  to.script_badplace = from.script_badplace;
  to.script_startinghealth = from.script_startinghealth;
  to.script_godmode = from.script_godmode;
  to.spawnflags = from.spawnflags;
}

function register_instance(vehicle, owner, team) {
  assert(isDefined(level.vehicle), "<dev string:x108>");
  assert(isDefined(level.vehicle.instances), "<dev string:x14f>");
  assert(isDefined(vehicle vehicle::get_ref()), "<dev string:x1a0>");
  deregister_instance(vehicle);
  entitynumber = vehicle getentitynumber();
  level.vehicle.instances[vehicle vehicle::get_ref()][entitynumber] = vehicle;
  level.vehicle.all[entitynumber] = vehicle;

  if(vehicle vehicle::can_fly()) {
    level.vehicle.aircraft[entitynumber] = vehicle;
  }

  vehicle.vehicleowner = owner;
  vehicle.vehicleteam = team;
}

function deregister_instance(vehicle) {
  assert(isDefined(vehicle vehicle::get_ref()), "<dev string:x1e9>");

  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!(isDefined(level.vehicle.instances) && isDefined(level.vehicle.all))) {
    return;
  }

  if(!isDefined(level.vehicle.instances[vehicle vehicle::get_ref()])) {
    return;
  }

  entitynumber = vehicle getentitynumber();
  level.vehicle.instances[vehicle vehicle::get_ref()][entitynumber] = undefined;
  level.vehicle.all[entitynumber] = undefined;

  if(isDefined(level.vehicle.aircraft[entitynumber])) {
    level.vehicle.aircraft[entitynumber] = undefined;
  }

  if(level.vehicle.instances[vehicle vehicle::get_ref()].size <= 0) {
    level.vehicle.instances[vehicle vehicle::get_ref()] = undefined;
  }

  vehicle.vehicleowner = undefined;
  vehicle.vehicleteam = undefined;
}

function function_2b4ad1f3a68a848f(vehicleref, limit, message) {
  assert(isDefined(level.vehicle), "<dev string:x234>");
  assert(isDefined(level.vehicle.instances), "<dev string:x27b>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  level.vehicle.instancelimits[vehicleref] = limit;
  level.vehicle.instancelimitmessages[vehicleref] = message;
}

function function_8d0cbf44f999d0f9(vehicleref, spawntype, limit) {
  assert(isDefined(level.vehicle), "<dev string:x234>");
  assert(isDefined(level.vehicle.instances), "<dev string:x27b>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(!isDefined(level.vehicle.spawntypeinstancelimits[vehicleref])) {
    level.vehicle.spawntypeinstancelimits[vehicleref] = [];
  }

  level.vehicle.spawntypeinstancelimits[vehicleref][spawntype] = limit;
}

function function_29d71103ac6897ea(vehicleref, limit, message) {
  assert(isDefined(level.vehicle), "<dev string:x2cb>");
  assert(isDefined(level.vehicle.instances), "<dev string:x313>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  level.vehicle.ownerinstancelimits[vehicleref] = limit;
  level.vehicle.ownerinstancelimitmessages[vehicleref] = message;
}

function function_5e28a72fa076ebb8(vehicleref, limit, message) {
  assert(isDefined(level.vehicle), "<dev string:x364>");
  assert(isDefined(level.vehicle.instances), "<dev string:x3ab>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  level.vehicle.teaminstancelimits[vehicleref] = limit;
  level.vehicle.teaminstancelimitmessages[vehicleref] = message;
}

function function_279695c41be653f(vehicleref, owner, team, spawntype, sendmessage) {
  assert(isDefined(level.vehicle), "<dev string:x3fb>");
  assert(isDefined(level.vehicle.instances), "<dev string:x43f>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(!isDefined(level.vehicle.instances[vehicleref])) {
    return false;
  }

  gamelimit = level.vehicle.instancelimits[vehicleref];

  if(isDefined(gamelimit)) {
    if(isDefined(level.vehicle.instances[vehicleref]) && level.vehicle.instances[vehicleref].size >= gamelimit) {
      return true;
    }
  }

  spawntypelimit = undefined;
  spawntypecount = undefined;

  if(isDefined(level.vehicle.spawntypeinstancelimits[vehicleref]) && isDefined(level.vehicle.spawntypeinstancelimits) && isDefined(spawntype) && isDefined(level.vehicle.spawntypeinstancelimits[vehicleref][spawntype])) {
    spawntypelimit = level.vehicle.spawntypeinstancelimits[vehicleref][spawntype];
    spawntypecount = 0;
  }

  ownerlimit = undefined;
  ownercount = undefined;

  if(isDefined(owner)) {
    ownerlimit = level.vehicle.ownerinstancelimits[vehicleref];
    ownercount = 0;
  }

  teamlimit = undefined;
  teamcount = undefined;

  if(isDefined(team)) {
    teamlimit = level.vehicle.teaminstancelimits[vehicleref];
    teamcount = 0;
  }

  if(!isDefined(ownerlimit) && !isDefined(teamlimit) && !isDefined(spawntypelimit)) {
    return false;
  }

  foreach(instance in level.vehicle.instances[vehicleref]) {
    if(isDefined(ownerlimit) && isDefined(instance.vehicleowner) && instance.vehicleowner == owner) {
      ownercount++;

      if(ownercount >= ownerlimit) {
        return true;
      }
    }

    if(isDefined(teamlimit) && isDefined(instance.vehicleteam) && instance.vehicleteam == team) {
      teamcount++;

      if(teamcount >= teamlimit) {
        return true;
      }
    }

    if(isDefined(instance.spawndata) && isDefined(spawntypelimit) && isDefined(instance.spawndata.spawntype) && instance.spawndata.spawntype == spawntype) {
      spawntypecount++;

      if(spawntypecount >= spawntypelimit) {
        return true;
      }
    }
  }

  return false;
}

function function_ff2863e4171248be(vehicleref) {
  assert(isDefined(level.vehicle), "<dev string:x48c>");
  assert(isDefined(level.vehicle.instances), "<dev string:x4d1>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(!isDefined(level.vehicle.instances[vehicleref])) {
    return [];
  }

  return level.vehicle.instances[vehicleref];
}

function function_d3fb044434efd77d(vehicleref, owner) {
  assert(isDefined(level.vehicle), "<dev string:x51f>");
  assert(isDefined(level.vehicle.instances), "<dev string:x565>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(!isDefined(level.vehicle.instances[vehicleref])) {
    return [];
  }

  instances = [];

  foreach(instance in level.vehicle.instances[vehicleref]) {
    if(instance.vehicleowner == owner) {
      instances[instances.size] = instance;
    }
  }

  return instances;
}

function function_472a3f4cbac38a9(vehicleref, team) {
  assert(isDefined(level.vehicle), "<dev string:x5b4>");
  assert(isDefined(level.vehicle.instances), "<dev string:x5f9>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(!isDefined(level.vehicle.instances[vehicleref])) {
    return [];
  }

  instances = [];

  foreach(instance in level.vehicle.instances[vehicleref]) {
    if(instance.vehicleteam == team) {
      instances[instances.size] = instance;
    }
  }

  return instances;
}

function function_5820a38c9873992e() {
  assert(isDefined(level.vehicle), "<dev string:x647>");
  return level.vehicle.all;
}

function function_b77f352821482252(vehicleref) {
  assert(isDefined(level.vehicle), "<dev string:x692>");
  assert(isDefined(level.vehicle.instances), "<dev string:x6da>");

  if(isstring(vehicleref) && vehicle::has_data(vehicleref)) {
    if(level.projectbundle.var_53c4124af039142e) {
      if(isDefined(vehicle::get_data(vehicleref).vehicle)) {
        vehicleref = vehicle::get_data(vehicleref).vehicle;
      }
    } else if(isDefined(vehicle::get_data(vehicleref).bundlename)) {
      vehicleref = vehicle::get_data(vehicleref).bundlename;
    }
  }

  if(isDefined(level.vehicle.instancelimits[vehicleref])) {
    return true;
  }

  if(isDefined(level.vehicle.ownerinstancelimits[vehicleref])) {
    return true;
  }

  if(isDefined(level.vehicle.teaminstancelimits[vehicleref])) {
    return true;
  }

  if(isDefined(level.vehicle.spawntypeinstancelimits[vehicleref])) {
    return true;
  }

  return false;
}

function init() {
  assert(isDefined(level.vehicle), "<dev string:x72b>");
  assert(!isDefined(level.vehicle.instances), "<dev string:x764>");
  level.vehicle.instances = [];
  level.vehicle.all = [];
  level.vehicle.aircraft = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle.spawntypeinstancelimits = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.maxvehiclecount = getdvarint(@ "scr_maxvehiclecount", 128);
}

function function_a50a15927bf945c1(spawndata) {
  if(!isDefined(spawndata)) {
    thread utility::error("spawnData must be defined.");
    return false;
  }

  if(!isDefined(spawndata.origin)) {
    thread utility::error("spawnData.origin must be defined.");
    return false;
  }

  return true;
}

function function_e0a8c3f4eeb707e(spawndata) {
  if(!function_a50a15927bf945c1(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread utility::error("<dev string:x79b>");
    return 0;
  }

  if(!isDefined(spawndata.targetname) && !isDefined(spawndata.script_vehicleref) && !isDefined(spawndata.script_vehiclebundle)) {
    thread utility::error("<dev string:x7c5>");
    return 0;
  }

  return 1;
}

function function_6b6a0c78a4707c87(spawndata) {
  if(!function_a50a15927bf945c1(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.owner)) {
    thread utility::error("<dev string:x80d>");
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread utility::error("<dev string:x79b>");
    return 0;
  }

  if(!isDefined(spawndata.modelname)) {
    thread utility::error("<dev string:x831>");
    return 0;
  }

  return 1;
}

# /