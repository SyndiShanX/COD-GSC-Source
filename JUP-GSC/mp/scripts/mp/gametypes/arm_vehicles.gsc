/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\arm_vehicles.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_helicopters;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rally_point;
#using scripts\mp\spawnselection;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace arm_vehicles;

function registervehicletype(refname, spawnvehiclecallback) {
  assert(isDefined(refname));
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = spawnvehiclecallback;
  var_4c78e24488a4f0c0 = function_b08e7e3a0b14f76f(refname);
  vehicleinfo.vehiclespawns = [];

  foreach(spawn in var_4c78e24488a4f0c0) {
    if(!isDefined(spawn.script_team) || refname == "light_tank" || refname == "veh9_jltv_mg" || refname == "veh9_cougar" || refname == "veh_jup_razorback") {
      vehicleinfo.vehiclespawns[vehicleinfo.vehiclespawns.size] = spawn;
    }
  }

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[refname] = vehicleinfo;
}

function function_417194d265d63273() {
  registervehicletype("little_bird", &vehiclespawn_littlebird);
  registervehicletype("atv", &vehiclespawn_atv);
  registervehicletype("light_tank", &vehiclespawn_tank);
  registervehicletype("veh9_rhib", &function_91397b675b427da6);
  registervehicletype("veh9_pwc", &function_9945b400b938a173);
  registervehicletype("veh9_jltv", &function_52e04331732241d7);
  registervehicletype("veh9_suv_1996", &function_784aa0f6ee634ae5);
  registervehicletype("veh9_sedan_hatchback_1985", &function_db3f4677d3b1ef4a);
  registervehicletype("veh9_patrol_boat", &function_64440e5a2bfd8900);
  registervehicletype("veh9_mil_cargo_truck", &function_93f25760d0131658);
  registervehicletype("veh9_utv", &function_c43c5200d882b134);
  registervehicletype("veh9_hummer", &function_c6436c7f3e995d85);
  registervehicletype("veh9_overland_2016", &function_9d7d93def34d9958);
  registervehicletype("veh_jup_truck_tech_hmg", &function_a566257e1d27492c);
  registervehicletype("veh_jup_orav", &function_3086eb7fdb843535);
  registervehicletype("veh_jup_razorback", &function_725c5ee265b286ce);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

    if(![[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleinfo.refname)) {
      continue;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(spawnpoint.script_noteworthy) || spawnpoint.script_noteworthy != level.localeid) {
        continue;
      }

      if(!function_e844513ae4facc56(vehicleinfo.refname, spawnpoint.origin)) {
        continue;
      }

      spawnpoint = function_4d91efcd80ff8810(vehicleinfo.refname, spawnpoint);
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(false) {
    foreach(loc in level.vehiclespawnlocs) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = array_randomize(level.vehiclespawnlocs);
  numtospawn = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles)) {
    numtospawn = 25;
  }

  if(false) {
    for(i = 0; i < numtospawn; i++) {
      loc = level.vehiclespawnlocs[i];
      thread drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(i = 0; i < numtospawn; i++) {
    loc = level.vehiclespawnlocs[i];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

function init_groundwarvehicles() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("little_bird", &vehiclespawn_littlebird);
  registervehicletype("atv", &vehiclespawn_atv);
  registervehicletype("light_tank", &vehiclespawn_tank);
  registervehicletype("veh9_rhib", &function_91397b675b427da6);
  registervehicletype("veh9_pwc", &function_9945b400b938a173);
  registervehicletype("veh9_jltv", &function_52e04331732241d7);
  registervehicletype("veh9_jltv_mg", &function_4fbf67e0d91458f8);
  registervehicletype("veh9_suv_1996", &function_784aa0f6ee634ae5);
  registervehicletype("veh9_sedan_hatchback_1985", &function_db3f4677d3b1ef4a);
  registervehicletype("veh9_patrol_boat", &function_64440e5a2bfd8900);
  registervehicletype("veh9_mil_cargo_truck", &function_93f25760d0131658);
  registervehicletype("veh9_utv", &function_c43c5200d882b134);
  registervehicletype("veh9_hummer", &function_c6436c7f3e995d85);
  registervehicletype("veh9_overland_2016", &function_9d7d93def34d9958);
  registervehicletype("veh9_acv_6x6", &function_a23b100003fc2003);
  registervehicletype("veh_jup_truck_tech_hmg", &function_a566257e1d27492c);
  registervehicletype("veh_jup_orav", &function_3086eb7fdb843535);
  registervehicletype("veh_jup_razorback", &function_725c5ee265b286ce);
  registersharedfunc("light_tank", "create", &function_a53caaef0414a722);
  registersharedfunc("veh9_cougar", "create", &function_a53caaef0414a722);
  registersharedfunc("veh_jup_razorback", "create", &function_a53caaef0414a722);

  if(getdvarint(@ "hash_50c65a9fb4fa6fab", 1)) {
    registersharedfunc("light_tank", "alterRespawnData", &function_54245b02f897a6d8);
    registersharedfunc("veh9_cougar", "alterRespawnData", &function_54245b02f897a6d8);
    level thread function_b55258e4128d8829();
  }

  level.vehiclespawnlocs = [];
  level.tankspawnlocs_axis = [];
  level.tankspawnlocs_allies = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

    if(![[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleinfo.refname)) {
      continue;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(spawnpoint.script_noteworthy) || spawnpoint.script_noteworthy != level.localeid) {
        continue;
      }

      if(!function_e844513ae4facc56(vehicleinfo.refname, spawnpoint.origin)) {
        continue;
      }

      spawnpoint = function_4d91efcd80ff8810(vehicleinfo.refname, spawnpoint);

      if(vehicleinfo.refname == "light_tank" || vehicleinfo.refname == "veh_jup_razorback") {
        if(isDefined(spawnpoint.script_team) && spawnpoint.script_team == "axis") {
          index = level.tankspawnlocs_axis.size;
          level.tankspawnlocs_axis[index] = spawnpoint;
          level.tankspawnlocs_axis[index].refname = vehicleinfo.refname;
        } else if(isDefined(spawnpoint.script_team) && spawnpoint.script_team == "allies") {
          index = level.tankspawnlocs_allies.size;
          level.tankspawnlocs_allies[index] = spawnpoint;
          level.tankspawnlocs_allies[index].refname = vehicleinfo.refname;
        }

        continue;
      }

      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(false) {
    foreach(loc in level.vehiclespawnlocs) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, loc.refname + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }
  }

  level.vehiclespawnlocs = array_randomize(level.vehiclespawnlocs);
  numtospawn = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles)) {
    numtospawn = 25;
  }

  if(false) {
    for(i = 0; i < numtospawn; i++) {
      loc = level.vehiclespawnlocs[i];
      thread drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(i = 0; i < numtospawn; i++) {
    loc = level.vehiclespawnlocs[i];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }

  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(getdvarint(@ "hash_4160846b9ed34b57", 0) == 1) {
    wait 5;
  } else {
    scripts\mp\flags::gameflagwait("prematch_countdown");
  }

  level thread function_b5f74019852e37fb();
  level thread function_67578d114d517147();
}

function function_87328480bccc7550(points) {
  level.tankrespawnpoints = points;
}

function private function_b55258e4128d8829() {
  tankrespawnpoints = scripts\cp_mp\vehicles\vehicle_spawn::function_25d4b673539659a1();

  if(!isDefined(level.tankrespawnpoints)) {
    level.tankrespawnpoints = tankrespawnpoints;
  }
}

function private function_54245b02f897a6d8(spawndata) {
  if(!isDefined(level.tankrespawnpoints) || is_equal(level.tankrespawnpoints.size, 0)) {
    return spawndata;
  }

  var_94dbde10d3b62d71 = 0;

  foreach(i in array_randomize([0, 1, 2, 3, 4])) {
    if(is_equal(level.allfobs[i].trigger.gameobject.ownerteam, spawndata.team) && isDefined(level.tankrespawnpoints[i]) && (!isDefined(level.tankrespawnpoints[i][0]) || level.tankrespawnpoints[i][0] == spawndata.targetname) && (!isDefined(level.tankrespawnpoints[i][3]) || level.tankrespawnpoints[i][3] == spawndata.team)) {
      if(!isDefined(spawndata.originalorigin)) {
        spawndata.originalorigin = spawndata.origin;
        spawndata.originalangles = spawndata.angles;
      }

      spawndata.origin = level.tankrespawnpoints[i][1];
      spawndata.angles = level.tankrespawnpoints[i][2];
      var_94dbde10d3b62d71 = 1;
      break;
    }
  }

  if(!var_94dbde10d3b62d71 && isDefined(spawndata.originalorigin)) {
    spawndata.origin = spawndata.originalorigin;
    spawndata.angles = spawndata.originalangles;
  }

  return spawndata;
}

function function_818ecfdb2be6e33d(vehicleref, origin, newtargetname, newvehicletype, var_7d5e409c9c04d1e3) {
  vehiclespawn = sortbydistance(function_b08e7e3a0b14f76f(vehicleref), origin)[0];
  deletestruct_ref(vehiclespawn);
  vehiclespawn.targetname = newtargetname;
  vehiclespawn.vehicletype = newvehicletype;
  vehiclespawn.script_team = var_7d5e409c9c04d1e3;
  addstruct(vehiclespawn);
}

function function_8f3b4ac00da24665(vehicleref, origin) {
  if(!isDefined(level.var_de84ae972d3a7582)) {
    level.var_de84ae972d3a7582 = [];
  }

  if(!isDefined(level.var_de84ae972d3a7582[vehicleref])) {
    level.var_de84ae972d3a7582[vehicleref] = [];
  }

  struct = spawnStruct();
  struct.origin = origin;
  level.var_de84ae972d3a7582[vehicleref][level.var_de84ae972d3a7582[vehicleref].size] = struct;
}

function private function_e844513ae4facc56(vehicleref, origin) {
  if(!isDefined(level.var_de84ae972d3a7582) || !isDefined(level.var_de84ae972d3a7582[vehicleref])) {
    return true;
  }

  closest = sortbydistance(level.var_de84ae972d3a7582[vehicleref], origin)[0];
  return distancesquared(origin, closest.origin) >= 400;
}

function function_4925ad96cef8def1(vehicleref, origin, neworigin, newangles) {
  if(!isDefined(level.var_4925ad96cef8def1)) {
    level.var_4925ad96cef8def1 = [];
  }

  if(!isDefined(level.var_4925ad96cef8def1[vehicleref])) {
    level.var_4925ad96cef8def1[vehicleref] = [];
  }

  struct = spawnStruct();
  struct.origin = origin;
  struct.neworigin = neworigin;
  struct.newangles = newangles;
  level.var_4925ad96cef8def1[vehicleref][level.var_4925ad96cef8def1[vehicleref].size] = struct;
}

function private function_4d91efcd80ff8810(vehicleref, vehiclespawn) {
  if(!isDefined(level.var_4925ad96cef8def1) || !isDefined(level.var_4925ad96cef8def1[vehicleref])) {
    return vehiclespawn;
  }

  closest = sortbydistance(level.var_4925ad96cef8def1[vehicleref], vehiclespawn.origin)[0];

  if(distancesquared(vehiclespawn.origin, closest.origin) < 400) {
    vehiclespawn.origin = closest.neworigin;

    if(isDefined(closest.newangles)) {
      vehiclespawn.angles = closest.newangles;
    }
  }

  return vehiclespawn;
}

function function_b5f74019852e37fb() {
  wait getdvarfloat(@ "hash_9c149e5fc7b81d01", 0);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

function function_67578d114d517147() {
  wait getdvarfloat(@ "hash_1f1cf80e06786f42", 4);
  registervehicletype("veh9_cougar", &function_70199cf52bda53fa);
  data = level.vehicleinfo["veh9_cougar"];

  foreach(loc in data.vehiclespawns) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(loc.script_noteworthy) || loc.script_noteworthy != level.localeid) {
      continue;
    }

    if(!function_e844513ae4facc56("veh9_cougar", loc.origin)) {
      continue;
    }

    loc = function_4d91efcd80ff8810("veh9_cougar", loc);
    level thread[[data.spawncallback]](loc);

    if(false) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, "<dev string:x47>" + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }

    wait 1;
  }
}

function vehiclespawn_hqtanks(var_9d4b9fcd75d1a736) {
  foreach(loc in var_9d4b9fcd75d1a736) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(loc.script_noteworthy) || loc.script_noteworthy != level.localeid) {
      continue;
    }

    if(!function_e844513ae4facc56(loc.refname, loc.origin)) {
      continue;
    }

    loc = function_4d91efcd80ff8810(loc.refname, loc);
    vehicleinfo = level.vehicleinfo[loc.refname];
    level thread[[vehicleinfo.spawncallback]](loc);

    if(false) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, loc.refname + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }

    wait randomfloatrange(2, 3);
  }
}

function vehiclespawn_littlebird(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, faildata);
}

function vehiclespawn_atv(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, faildata);
}

function vehiclespawn_tank(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";
  assert(isDefined(level.numhqtanks_axis), "<dev string:x56>");
  assert(isDefined(level.numhqtanks_allies), "<dev string:x7f>");
  assert(isDefined(level.maxhqtanks), "<dev string:xaa>");

  if(isDefined(loc.script_team) && loc.script_team == "axis") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }

    spawndata.skinoverride = "east";
    spawndata.team = "axis";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }

    spawndata.skinoverride = "west";
    spawndata.team = "allies";
    level.numhqtanks_allies++;
  }

  iav = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, faildata);
  return iav;
}

function function_91397b675b427da6(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", spawndata, faildata);
}

function function_9945b400b938a173(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_pwc", spawndata, faildata);
}

function function_52e04331732241d7(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata, faildata);
}

function function_4fbf67e0d91458f8(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", spawndata, faildata);
}

function function_784aa0f6ee634ae5(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawndata, faildata);
}

function function_db3f4677d3b1ef4a(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_sedan_hatchback_1985", spawndata, faildata);
}

function function_93f25760d0131658(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata, faildata);
}

function function_c43c5200d882b134(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_utv", spawndata, faildata);
}

function function_c6436c7f3e995d85(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_hummer", spawndata, faildata);
}

function function_9d7d93def34d9958(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_overland_2016", spawndata, faildata);
}

function function_a23b100003fc2003(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_acv_6x6", spawndata, faildata);
}

function function_a566257e1d27492c(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_truck_tech_hmg", spawndata, faildata);
}

function function_3086eb7fdb843535(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_orav", spawndata, faildata);
}

function function_70199cf52bda53fa(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";
  spawndata.skinoverride = ter_op(spawndata.team == "axis", "east", "west");
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_cougar", spawndata, faildata);
}

function function_725c5ee265b286ce(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";
  spawndata.skinoverride = ter_op(spawndata.team == "axis", "east", "west");
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_razorback", spawndata, faildata);
}

function function_64440e5a2bfd8900(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata, faildata);
}

function function_505626ab02e6c2d6(vehicle) {
  level thread function_53f5eb5db0ae2aa1(vehicle);
}

function private function_53f5eb5db0ae2aa1(vehicle) {
  flag_wait("spawn_areas_ready");
  scripts\mp\rally_point::rallypointvehicle_activate(vehicle);
}

function function_a53caaef0414a722(vehicle) {
  if(!istrue(level.showteamtanks)) {
    return;
  }

  switch (vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd()) {
    case #"hash_cb2498c4a1e415fd":
      icon = "hud_icon_minimap_vehicle_tank_cougar";
      break;
    case #"hash_63cf913c1ee55d64":
      icon = "hud_icon_minimap_vehicle_razorback";
      break;
    case #"hash_7c54070d9b704f70":
    default:
      icon = "hud_icon_minimap_vehicle_tank_coscar";
      break;
  }

  level thread vehicle_createspawnselectiontankmarker(vehicle, vehicle.team, icon);
}

function vehicle_createspawnselectiontankmarker(vehicle, team, icon) {
  if(!isDefined(icon)) {
    icon = "hud_icon_minimap_vehicle_tank_coscar";
  }

  wait 1;
  marker = scripts\mp\gameobjects::createobjidobject(vehicle.origin, team, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, team);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(marker.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, icon);
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(marker.objidnum, vehicle);
  marker.lockupdatingicons = 1;

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && player.team == team && istrue(player.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(marker.objidnum, player);
    }
  }

  vehicle.spawnselectionmarker = marker;
  thread vehicle_watchmarkedtankdeath(vehicle);
  level.trackedtanks[team][level.trackedtanks[team].size] = vehicle;
}

function vehicle_watchmarkedtankdeath(vehicle) {
  objidnum = vehicle.spawnselectionmarker.objidnum;
  team = vehicle.team;
  vehicle waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(objidnum);
  level.trackedtanks[team] = array_remove(level.trackedtanks[team], vehicle);
}

function vehicle_showteamtanks() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tank in level.trackedtanks[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(tank.spawnselectionmarker.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(tank in level.trackedtanks["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
  }

  foreach(tank in level.trackedtanks["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
  }
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;

  if(isDefined(loc.script_team)) {
    spawndata.team = ter_op(loc.script_team == "axis", "axis", "allies");
  }

  return spawndata;
}

function droptank_playincomingdialog(spawndata) {
  team = spawndata.team;
  streakname = "bradley";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[streakname])) {
      if(isDefined(level.killstreakactivatedtime[streakname][team])) {
        if(gettime() < level.killstreakactivatedtime[streakname][team]) {
          return;
        }
      }
    }

    level.killstreakactivatedtime[streakname][team] = gettime() + scripts\cp_mp\utility\killstreak_utility::getkillstreakdialogcooldown() * 1000;
  }

  leaderdialog(team + "_friendly_" + streakname + "_inbound", team, "killstreak_used");
}

function init_rallyvehicles() {
  registersharedfunc("veh9_apc_8x8", "create", &function_505626ab02e6c2d6);
  registersharedfunc("veh9_palfa", "create", &function_505626ab02e6c2d6);
  registersharedfunc("veh9_patrol_boat", "create", &function_505626ab02e6c2d6);

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  waitframe();
  level.rallypointvehicles = [];
  var_29354b69bd8def17 = "gw_vehicle_technical_";
  var_e6fe9018451c854c = "gw_vehicle_apc_";
  var_fb1d0f7637a20dd6 = "gw_vehicle_armored_boat_";
  var_b142fc4830a64bea = "gw_vehicle_littlebird_";
  var_60a367641181424c = [];
  var_605cd7ad6472b682 = [];
  var_7b2a53909cab7620 = [];

  foreach(team in level.teamnamelist) {
    var_60a367641181424c[team] = 0;
    var_605cd7ad6472b682[team] = 0;
    var_7b2a53909cab7620[team] = 0;
  }

  var_13b8accbd9c63733 = getStructArray("rallyPointAPC", "targetname");
  var_13b8accbd9c63733 = array_combine(var_13b8accbd9c63733, function_b08e7e3a0b14f76f("apc_russian"));
  var_13b8accbd9c63733 = array_combine(var_13b8accbd9c63733, function_b08e7e3a0b14f76f("veh9_apc_8x8"));

  foreach(loc in var_13b8accbd9c63733) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }

    if(!isDefined(loc.script_team)) {
      continue;
    }

    ref = ter_op(loc.targetname == "apc_8x8_spawn", "veh9_apc_8x8", "apc_russian");

    if(!function_e844513ae4facc56(ref, loc.origin)) {
      continue;
    }

    loc = function_4d91efcd80ff8810(ref, loc);

    if(false) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, ref + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }

    issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

    if(![[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](ref)) {
      continue;
    }

    team = ter_op(loc.script_team == "axis", "axis", "allies");
    var_da3668523170ea04 = undefined;
    var_605cd7ad6472b682[team]++;

    if(var_605cd7ad6472b682[team] <= 2) {
      var_da3668523170ea04 = var_e6fe9018451c854c + var_605cd7ad6472b682[team];
    } else {
      assert(0, "<dev string:xce>");
    }

    spawndata = getrallyvehiclespawndata(loc, team, var_da3668523170ea04);

    if(loc.targetname == "apc_8x8_spawn") {
      spawndata.skinoverride = ter_op(team == "axis", "east", "west");
    }

    faildata = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(ref, spawndata, faildata);

    if(isDefined(vehicle)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
    }
  }

  var_13b8accbd9c63733 = getStructArray("rallyPointArmoredBoat", "targetname");
  var_13b8accbd9c63733 = array_combine(var_13b8accbd9c63733, function_b08e7e3a0b14f76f("veh9_patrol_boat"));

  foreach(loc in var_13b8accbd9c63733) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }

    if(!isDefined(loc.script_team)) {
      continue;
    }

    issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

    if(![[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]]("veh9_patrol_boat")) {
      continue;
    }

    if(!function_e844513ae4facc56("veh9_patrol_boat", loc.origin)) {
      continue;
    }

    loc = function_4d91efcd80ff8810("veh9_patrol_boat", loc);

    if(false) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, "<dev string:x12f>" + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }

    team = ter_op(loc.script_team == "axis", "axis", "allies");
    var_da3668523170ea04 = undefined;
    var_7b2a53909cab7620[team]++;

    if(var_7b2a53909cab7620[team] <= 2) {
      var_da3668523170ea04 = var_fb1d0f7637a20dd6 + var_7b2a53909cab7620[team];
    } else {
      assert(0, "<dev string:x143>");
    }

    spawndata = getrallyvehiclespawndata(loc, team, var_da3668523170ea04);
    spawndata.skinoverride = ter_op(team == "axis", "east", "west");
    faildata = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata, faildata);

    if(isDefined(vehicle)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
    }
  }

  foreach(loc in function_b08e7e3a0b14f76f("veh9_palfa")) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }

    if(!isDefined(loc.script_team)) {
      continue;
    }

    issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

    if(![[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]]("veh9_palfa")) {
      continue;
    }

    if(!function_e844513ae4facc56("veh9_palfa", loc.origin)) {
      continue;
    }

    loc = function_4d91efcd80ff8810("veh9_palfa", loc);

    if(false) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

      print3d(loc.origin, "<dev string:x1b4>" + "<dev string:x40>" + loc.origin, (1, 0, 0), 1, 1, 100000, 1);
    }

    team = ter_op(loc.script_team == "axis", "axis", "allies");
    var_da3668523170ea04 = undefined;
    var_60a367641181424c[team]++;

    if(var_60a367641181424c[team] <= 2) {
      var_da3668523170ea04 = var_b142fc4830a64bea + var_60a367641181424c[team];
    } else {
      assert(0, "<dev string:x1c2>");
    }

    spawndata = getrallyvehiclespawndata(loc, team, var_da3668523170ea04);
    spawndata.skinoverride = ter_op(team == "axis", "east", "west");
    faildata = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata, faildata);

    if(isDefined(vehicle)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
    }
  }

  foreach(entry in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[entry][0])) {
      waitframe();
    }
  }

  flag_set("spawn_areas_ready");
}

function getrallyvehiclespawndata(loc, team, var_da3668523170ea04) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.cannotbesuspended = 1;
  spawndata.ref = var_da3668523170ea04;
  spawndata.team = team;
  return spawndata;
}

function managec130spawns() {
  level endon("game_ended");
  var_33bbc02aca0008b = 6000;
  c130height = 12000;
  var_f382830cb3a96bf9 = 20000;
  var_b34d9378696e10bb = 1;
  var_2b4ee773f94cedcf = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(entry in level.teamnamelist) {
    level.spawnc130[entry] = undefined;
  }

  c130_pickrandomflightpath();
  level.spawnc130["axis"] = createc130("axis", level.c130pathstruct_a.startpt + var_2b4ee773f94cedcf);
  level.spawnc130["allies"] = createc130("allies", level.c130pathstruct_b.startpt + var_2b4ee773f94cedcf);

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    if(!isDefined(level.timeuntilnextc130)) {
      level.timeuntilnextc130 = [];
    }

    if(!isDefined(level.timeuntilnextc130["axis"])) {
      level.timeuntilnextc130["axis"] = 0;
    }

    if(!isDefined(level.timeuntilnextc130["allies"])) {
      level.timeuntilnextc130["allies"] = 0;
    }

    timeuntilnextc130 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["axis"] = timeuntilnextc130;
    level.timeuntilnextc130["allies"] = timeuntilnextc130;

    if(false) {
      thread drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(var_b34d9378696e10bb) {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt + var_2b4ee773f94cedcf, level.c130pathstruct_a.endpt + var_2b4ee773f94cedcf, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt + var_2b4ee773f94cedcf, level.c130pathstruct_b.endpt + var_2b4ee773f94cedcf, level.flighttime, "allies");
    } else {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "allies");
    }

    level.c130firstpassstarted = 1;
    level waittill_all_in_array(["C130_path_complete_axis", "C130_path_complete_allies"]);
    c130_fightpathmove();
    temppt = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = temppt;
    temppt = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = temppt;
    var_b34d9378696e10bb = 0;

    if(istrue(level.usec130spawnfirstonly)) {
      level.usec130spawn = 0;
      break;
    }
  }

  scripts\mp\spawnselection::removedynamicspawnarea("axis", "dynamic_c130");
  scripts\mp\spawnselection::removedynamicspawnarea("allies", "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "axis");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "allies");
  level.spawnc130["axis"] delete();
  level.spawnc130["allies"] delete();
}

function createc130(team, startpt) {
  gunship = spawn("script_model", startpt);
  gunship setModel("veh8_mil_air_acharlie130");
  gunship setCanDamage(0);
  gunship.maxhealth = 100000;
  gunship.health = gunship.maxhealth;
  gunship.playeroffsets = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  gunship.currentplayeroffset = 0;
  gunship.respawnqueue = [];
  gunship.players = [];
  gunship.team = team;
  gunship playLoopSound("iw8_ks_ac130_lp");
  gunship thread scripts\mp\gametypes\br_c130::gunship_spawnvfx();
  return gunship;
}

function handlec130motion(startpt, endpt, time, team) {
  toend = vectorNormalize(endpt - startpt);
  dist = distance(endpt, startpt);
  var_92a519173221837e = startpt + toend * dist * 0.425;
  var_e7c3539b6fc3114f = startpt + toend * dist * 0.55;
  introtime = time * 0.3;
  dropofftime = time * 0.6;
  outrotime = time * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  dir = vectorNormalize(endpt - startpt);
  self.angles = vectortoangles(dir);
  self.origin = startpt;
  gatherc130playerstospawn();
  self moveTo(endpt, introtime + dropofftime + outrotime, introtime * 0.25);
  wait introtime;
  self.canparachute = 1;

  foreach(p in self.players) {
    p notify("canParachute");
  }

  wait dropofftime;
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(p in self.players) {
    p notify("halo_kick_c130");
  }

  wait outrotime;
  level notify("C130_path_complete_" + team);
}

function gatherc130playerstospawn() {
  self.players = array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  radius = 1400;
  spawnoffset = (30, 0, 0);
  initialoffset = anglesToForward(spawnoffset) * radius * -1;
  spawnpos = self gettagorigin("tag_origin") + initialoffset;
  spawnang = self.angles;

  foreach(p in self.players) {
    if(!isDefined(p)) {
      continue;
    }

    p.forcespawncameraorg = spawnpos;
    p.forcespawncameraang = spawnang;
    p notify("c130_ready");
  }
}

function removefromspawnselectionaftertime(time) {
  wait time;
  removefromspawnselection();
}

function removefromspawnselection() {
  scripts\mp\spawnselection::removedynamicspawnarea(self.team, "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", self.team);
}

function spawnplayertoc130() {
  self endon("disconnect");

  if(!isDefined(level.spawnc130[self.team])) {
    return;
  }

  self waittill("spawn_camera_idle");
  c130 = level.spawnc130[self.team];
  c130.respawnqueue[c130.respawnqueue.size] = self;

  if(istrue(c130.canjoin)) {
    c130 gatherc130playerstospawn();
  }

  if(istrue(self.inspawncamera)) {
    self waittill("spawn_camera_complete");
  } else {
    self waittill("spawned_player");
  }

  val::set("spawnPlayerToC130", "killstreaks", 0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread jumplistener(c130, 0);
  self.br_infil_type = "c130";

  if(!isbot(self)) {
    thread scripts\mp\gametypes\br_c130::orbitcam(c130);
  }
}

function jumplistener(c130, var_1b89121ef11344d5) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  self.c130 = c130;
  thread listenjump(c130, var_1b89121ef11344d5);
  thread listenkick(c130, var_1b89121ef11344d5);
}

function listenkick(c130, forcechute) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenKick()");
  self endon("listenKick()");
  self waittill("halo_kick_c130");
  self cameradefault();
  self unlink();
  wait 0.1;

  if(self.sessionstate == "spectator") {
    return;
  }

  var_f9805aad354a150e = c130 scripts\mp\gametypes\br_helicopters::calctrailpoint();
  thread parachute(c130, forcechute);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function listenjump(c130, var_1b89121ef11344d5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  while(true) {
    result = waittill_either("halo_jump_c130", "canParachute");

    if(isDefined(result) && result == "canParachute") {
      self iprintlnbold("Press Jump to Parachute!");
    } else if(!istrue(c130.canparachute)) {
      self iprintlnbold("Not over the AO");
    } else {
      break;
    }

    if(self.sessionstate == "spectator") {
      return;
    }
  }

  println("<dev string:x225>");
  self cameradefault();
  self unlink();
  wait 0.1;
  thread parachute(c130, var_1b89121ef11344d5);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function parachute(c130, var_1b89121ef11344d5) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis") {
    var_69dbcc65237ec970 = level.c130pathstruct_b.midpt;
  } else {
    var_69dbcc65237ec970 = level.c130pathstruct_a.midpt;
  }

  tofrontline = vectorNormalize(var_69dbcc65237ec970 - c130.origin);
  c130.players = array_remove(c130.players, self);

  if(isDefined(c130.playeroffsets) && isDefined(c130.currentplayeroffset)) {
    offset = c130.playeroffsets[c130.currentplayeroffset];
    self setOrigin(c130.origin + offset, 1, 1);
    c130.currentplayeroffset++;

    if(c130.currentplayeroffset == c130.playeroffsets.size) {
      c130.currentplayeroffset = 0;
    }
  } else {
    worldoffset = anglesToForward(c130.angles) * c130.br_vieworigin;
    self setOrigin(c130.origin + worldoffset, 1, 1);
  }

  waitframe();
  scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
  scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("arm_vehicles::parachute()");
  self.plotarmor = 0;
  self.c130 = undefined;
  self setplayerangles(vectortoangles(tofrontline));
  thread scripts\cp_mp\parachute::startfreefall(5, 0);
}

function debug_randomflightpathstest() {
  wait 10;

  while(true) {
    c130_pickrandomflightpath();
    level.c130pathstruct_a.startpt -= (0, 0, 10000);
    level.c130pathstruct_a.endpt -= (0, 0, 10000);
    level.c130pathstruct_b.startpt -= (0, 0, 10000);
    level.c130pathstruct_b.endpt -= (0, 0, 10000);
    thread drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, (1, 0, 1));
    thread drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, (1, 0, 1));
    wait 1;
  }
}

function c130_pickrandomflightpath() {
  if(istrue(level.c130alignedtolocale) && istrue(level.useobjectives)) {
    mapcenter = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
    var_f3c9e115b49a626a = vectortoangles(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
    angle = var_f3c9e115b49a626a[1];

    if(false) {
      thread drawsphere(mapcenter, 1000, 100000, (0, 1, 0));
    }
  } else {
    mapcenter = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    angle = randomfloatrange(0, 359);
  }

  c130params = makec130pathparamsstruct(mapcenter, angle - 90);
  level.c130pathstruct_a = scripts\mp\gametypes\br_c130::makepathstruct(c130params);
  c130params.randomangle += 180;
  level.c130pathstruct_b = scripts\mp\gametypes\br_c130::makepathstruct(c130params);
  var_3abadab203328ad1 = 0.2;
  randomxoffset = 0;
  randomyoffset = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    var_3abadab203328ad1 = 0.1;
    randomxoffset = randomfloatrange(-5000, 5000);
    randomyoffset = randomfloatrange(-5000, 5000);
  }

  right = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = right * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = right * level.c130distapart + level.c130pathstruct_a.endpt;
  right = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = right * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = right * level.c130distapart + level.c130pathstruct_b.endpt;
  offset = (randomxoffset, randomyoffset, 0);
  level.c130pathstruct_a.startpt += offset;
  level.c130pathstruct_a.endpt += offset;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt += offset;
  level.c130pathstruct_b.endpt += offset;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var_3abadab203328ad1);
  level.c130minpathmovementinterval -= level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

function makec130pathparamsstruct(centerpt, angle) {
  twopi = 6.28318;
  randomangle = angle;
  endangleoffset = 180;
  r = level.c130flightdist;
  paramstruct = spawnStruct();
  paramstruct.r = r;
  paramstruct.randomangle = randomangle;
  paramstruct.endangleoffset = endangleoffset;
  paramstruct.centerpt = centerpt;
  return paramstruct;
}

function c130_fightpathmove() {
  if(false) {
    level.c130movementmethod = 2;
  }

  if(level.c130movementmethod == 0) {
    return;
  }

  if(level.c130movementmethod == 1) {
    if(false) {
      level.c130pathkilltracker["axis"] = 1;
      level.c130pathkilltracker["allies"] = 0;
    }

    if(level.c130pathkilltracker["axis"] > level.c130pathkilltracker["allies"]) {
      if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
        level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
        level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
        level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
        level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
      }
    } else if(arenextpathsinsafebounds(level.c130minpathmovementinterval * -1)) {
      level.c130pathstruct_a.startpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_b.startpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt -= level.c130minpathmovementinterval;
    }

    level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
    level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
    return;
  }

  if(level.c130movementmethod == 2) {
    var_d320310339164aac = (0, 0, 0);
    var_ee6d8b534c2ddd2d = (0, 0, 0);
    var_6d48eb54c3a800fc = 0;
    var_9297d08353baf063 = 0;

    foreach(player in level.players) {
      if(isalive(player)) {
        if(player.team == "axis") {
          var_d320310339164aac += player.origin;
          var_6d48eb54c3a800fc++;
          continue;
        }

        if(player.team == "allies") {
          var_ee6d8b534c2ddd2d += player.origin;
          var_9297d08353baf063++;
        }
      }
    }

    if(var_6d48eb54c3a800fc == 0 || var_9297d08353baf063 == 0) {
      return;
    }

    axiscenter = var_d320310339164aac / var_6d48eb54c3a800fc;
    alliescenter = var_ee6d8b534c2ddd2d / var_9297d08353baf063;
    var_be2c550023fb372 = vectorlerp(axiscenter, alliescenter, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, var_be2c550023fb372, 0.5);
    level.c130minpathmovementinterval -= level.battlecenter;
    var_37dfb4f272c7016d = distance2d(level.battlecenter, var_be2c550023fb372);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * var_37dfb4f272c7016d / 4;
    level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);

    if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
      level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
      level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
      level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
      level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);

      if(false) {
        thread drawsphere(level.battlecenter, 1000, 700, (1, 0, 0));
        thread drawsphere(var_be2c550023fb372, 1000, 700, (0, 1, 0));
      }

      level.battlecenter += level.c130minpathmovementinterval;
    }
  }
}

function arenextpathsinsafebounds(offset) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + offset) && ispointinsafebounds(level.c130pathstruct_a.endpt + offset) && ispointinsafebounds(level.c130pathstruct_b.startpt + offset) && ispointinsafebounds(level.c130pathstruct_b.endpt + offset);
}

function ispointinsafebounds(pt) {
  return pt[0] < level.mapsafecorners[0][0] && pt[0] > level.mapsafecorners[1][0] && pt[1] < level.mapsafecorners[0][1] && pt[1] > level.mapsafecorners[1][1];
}