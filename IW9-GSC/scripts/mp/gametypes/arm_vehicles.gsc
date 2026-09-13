/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arm_vehicles.gsc
*************************************************/

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  _id_4C78E24488A4F0C0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);
  vehicleinfo.vehiclespawns = [];

  foreach(spawn in _id_4C78E24488A4F0C0) {
    if(!isDefined(spawn.script_team) || refname == "light_tank" || refname == "veh9_jltv_mg" || refname == "veh9_cougar")
      vehicleinfo.vehiclespawns[vehicleinfo.vehiclespawns.size] = spawn;
  }

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  level.vehicleinfo[refname] = vehicleinfo;
}

_id_417194D265D63273() {
  registervehicletype("little_bird", ::vehiclespawn_littlebird);
  registervehicletype("atv", ::vehiclespawn_atv);
  registervehicletype("light_tank", ::vehiclespawn_tank);
  registervehicletype("veh9_rhib", ::_id_91397B675B427DA6);
  registervehicletype("veh9_pwc", ::_id_9945B400B938A173);
  registervehicletype("veh9_jltv", ::_id_52E04331732241D7);
  registervehicletype("veh9_suv_1996", ::_id_784AA0F6EE634AE5);
  registervehicletype("veh9_sedan_hatchback_1985", ::_id_DB3F4677D3B1EF4A);
  registervehicletype("veh9_patrol_boat", ::_id_64440E5A2BFD8900);
  registervehicletype("veh9_mil_cargo_truck", ::_id_93F25760D0131658);
  registervehicletype("veh9_utv", ::_id_C43C5200D882B134);
  registervehicletype("veh9_hummer", ::_id_C6436C7F3E995D85);
  registervehicletype("veh9_overland_2016", ::_id_9D7D93DEF34D9958);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleinfo.refname)) {
      continue;
    }
    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(spawnpoint.script_noteworthy) || spawnpoint.script_noteworthy != level.localeid) {
        continue;
      }
      if(!_id_E844513AE4FACC56(vehicleinfo.refname, spawnpoint.origin)) {
        continue;
      }
      spawnpoint = _id_4D91EFCD80FF8810(vehicleinfo.refname, spawnpoint);
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(0) {
    foreach(loc in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  _id_FC617751F654A141 = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles))
    _id_FC617751F654A141 = 25;

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

init_groundwarvehicles() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("little_bird", ::vehiclespawn_littlebird);
  registervehicletype("atv", ::vehiclespawn_atv);
  registervehicletype("light_tank", ::vehiclespawn_tank);
  registervehicletype("veh9_rhib", ::_id_91397B675B427DA6);
  registervehicletype("veh9_pwc", ::_id_9945B400B938A173);
  registervehicletype("veh9_jltv", ::_id_52E04331732241D7);
  registervehicletype("veh9_jltv_mg", ::_id_4FBF67E0D91458F8);
  registervehicletype("veh9_suv_1996", ::_id_784AA0F6EE634AE5);
  registervehicletype("veh9_sedan_hatchback_1985", ::_id_DB3F4677D3B1EF4A);
  registervehicletype("veh9_patrol_boat", ::_id_64440E5A2BFD8900);
  registervehicletype("veh9_mil_cargo_truck", ::_id_93F25760D0131658);
  registervehicletype("veh9_utv", ::_id_C43C5200D882B134);
  registervehicletype("veh9_hummer", ::_id_C6436C7F3E995D85);
  registervehicletype("veh9_overland_2016", ::_id_9D7D93DEF34D9958);
  registervehicletype("veh9_acv_6x6", ::_id_A23B100003FC2003);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "create", ::_id_A53CAAEF0414A722);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_cougar", "create", ::_id_A53CAAEF0414A722);

  if(getdvarint("dvar_50C65A9FB4FA6FAB", 1)) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "alterRespawnData", ::_id_54245B02F897A6D8);
    scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_cougar", "alterRespawnData", ::_id_54245B02F897A6D8);
    level thread _id_B55258E4128D8829();
  }

  level.vehiclespawnlocs = [];
  level.tankspawnlocs_axis = [];
  level.tankspawnlocs_allies = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleinfo.refname)) {
      continue;
    }
    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(spawnpoint.script_noteworthy) || spawnpoint.script_noteworthy != level.localeid) {
        continue;
      }
      if(!_id_E844513AE4FACC56(vehicleinfo.refname, spawnpoint.origin)) {
        continue;
      }
      spawnpoint = _id_4D91EFCD80FF8810(vehicleinfo.refname, spawnpoint);

      if(vehicleinfo.refname == "light_tank") {
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

  if(0) {
    foreach(loc in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  _id_FC617751F654A141 = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles))
    _id_FC617751F654A141 = 25;

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }

  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(getdvarint("dvar_4160846B9ED34B57", 0) == 1)
    wait 5;
  else
    scripts\mp\flags::gameflagwait("prematch_countdown");

  level thread _id_CF5F705446ACB42E();
  level thread _id_67578D114D517147();
}

_id_87328480BCCC7550(points) {
  level._id_DD038F2881E68D7C = points;
}

_id_B55258E4128D8829() {
  _id_DD038F2881E68D7C = scripts\cp_mp\vehicles\vehicle_spawn::_id_25D4B673539659A1();

  if(!isDefined(level._id_DD038F2881E68D7C))
    level._id_DD038F2881E68D7C = _id_DD038F2881E68D7C;
}

_id_54245B02F897A6D8(spawndata) {
  if(!isDefined(level._id_DD038F2881E68D7C) || scripts\engine\utility::is_equal(level._id_DD038F2881E68D7C.size, 0))
    return spawndata;

  _id_94DBDE10D3B62D71 = 0;

  foreach(_id_AC0E594AC96AA3A8 in scripts\engine\utility::array_randomize([0, 1, 2, 3, 4])) {
    if(scripts\engine\utility::is_equal(level.allfobs[_id_AC0E594AC96AA3A8].trigger.gameobject.ownerteam, spawndata.team) && isDefined(level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8]) && (!isDefined(level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][0]) || level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][0] == spawndata.targetname) && (!isDefined(level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][3]) || level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][3] == spawndata.team)) {
      if(!isDefined(spawndata.originalorigin)) {
        spawndata.originalorigin = spawndata.origin;
        spawndata.originalangles = spawndata.angles;
      }

      spawndata.origin = level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][1];
      spawndata.angles = level._id_DD038F2881E68D7C[_id_AC0E594AC96AA3A8][2];
      _id_94DBDE10D3B62D71 = 1;
      break;
    }
  }

  if(!_id_94DBDE10D3B62D71 && isDefined(spawndata.originalorigin)) {
    spawndata.origin = spawndata.originalorigin;
    spawndata.angles = spawndata.originalangles;
  }

  return spawndata;
}

_id_818ECFDB2BE6E33D(_id_7731ADEF63E19B0C, origin, _id_D5B6A54A565BDC23, _id_8B5E29E3D1FA1BFF, _id_7D5E409C9C04D1E3) {
  _id_DB32ABF0A18CADF6 = sortbydistance(scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(_id_7731ADEF63E19B0C), origin)[0];
  scripts\engine\utility::deletestruct_ref(_id_DB32ABF0A18CADF6);
  _id_DB32ABF0A18CADF6.targetname = _id_D5B6A54A565BDC23;
  _id_DB32ABF0A18CADF6.vehicletype = _id_8B5E29E3D1FA1BFF;
  _id_DB32ABF0A18CADF6.script_team = _id_7D5E409C9C04D1E3;
  scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_DB32ABF0A18CADF6);
}

_id_8F3B4AC00DA24665(_id_7731ADEF63E19B0C, origin) {
  if(!isDefined(level._id_DE84AE972D3A7582))
    level._id_DE84AE972D3A7582 = [];

  if(!isDefined(level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C]))
    level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C] = [];

  struct = spawnStruct();
  struct.origin = origin;
  level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C][level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C].size] = struct;
}

_id_E844513AE4FACC56(_id_7731ADEF63E19B0C, origin) {
  if(!isDefined(level._id_DE84AE972D3A7582) || !isDefined(level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C]))
    return 1;

  _id_114AB88507847C50 = sortbydistance(level._id_DE84AE972D3A7582[_id_7731ADEF63E19B0C], origin)[0];
  return distancesquared(origin, _id_114AB88507847C50.origin) >= 400;
}

_id_4925AD96CEF8DEF1(_id_7731ADEF63E19B0C, origin, _id_A9706ADAF7C52E27, _id_B98CF035C97EDEE9) {
  if(!isDefined(level._id_4925AD96CEF8DEF1))
    level._id_4925AD96CEF8DEF1 = [];

  if(!isDefined(level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C]))
    level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C] = [];

  struct = spawnStruct();
  struct.origin = origin;
  struct._id_A9706ADAF7C52E27 = _id_A9706ADAF7C52E27;
  struct._id_B98CF035C97EDEE9 = _id_B98CF035C97EDEE9;
  level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C][level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C].size] = struct;
}

_id_4D91EFCD80FF8810(_id_7731ADEF63E19B0C, _id_DB32ABF0A18CADF6) {
  if(!isDefined(level._id_4925AD96CEF8DEF1) || !isDefined(level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C]))
    return _id_DB32ABF0A18CADF6;

  _id_114AB88507847C50 = sortbydistance(level._id_4925AD96CEF8DEF1[_id_7731ADEF63E19B0C], _id_DB32ABF0A18CADF6.origin)[0];

  if(distancesquared(_id_DB32ABF0A18CADF6.origin, _id_114AB88507847C50.origin) < 400) {
    _id_DB32ABF0A18CADF6.origin = _id_114AB88507847C50._id_A9706ADAF7C52E27;

    if(isDefined(_id_114AB88507847C50._id_B98CF035C97EDEE9))
      _id_DB32ABF0A18CADF6.angles = _id_114AB88507847C50._id_B98CF035C97EDEE9;
  }

  return _id_DB32ABF0A18CADF6;
}

_id_CF5F705446ACB42E() {
  wait(getdvarfloat("dvar_9C149E5FC7B81D01", 0));
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

_id_67578D114D517147() {
  wait(getdvarfloat("dvar_1F1CF80E06786F42", 4));
  registervehicletype("veh9_cougar", ::_id_70199CF52BDA53FA);
  data = level.vehicleinfo["veh9_cougar"];

  foreach(loc in data.vehiclespawns) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(loc.script_noteworthy) || loc.script_noteworthy != level.localeid) {
      continue;
    }
    if(!_id_E844513AE4FACC56("veh9_cougar", loc.origin)) {
      continue;
    }
    loc = _id_4D91EFCD80FF8810("veh9_cougar", loc);
    level thread[[data.spawncallback]](loc);

    if(0)
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

    wait 1;
  }
}

vehiclespawn_hqtanks(_id_9D4B9FCD75D1A736) {
  foreach(loc in _id_9D4B9FCD75D1A736) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || !isDefined(loc.script_noteworthy) || loc.script_noteworthy != level.localeid) {
      continue;
    }
    if(!_id_E844513AE4FACC56(loc.refname, loc.origin)) {
      continue;
    }
    loc = _id_4D91EFCD80FF8810(loc.refname, loc);
    vehicleinfo = level.vehicleinfo[loc.refname];
    level thread[[vehicleinfo.spawncallback]](loc);

    if(0)
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

    wait(randomfloatrange(2.0, 3.0));
  }
}

vehiclespawn_littlebird(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_atv(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_tank(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";

  if(isDefined(loc.script_team) && loc.script_team == "axis") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }
    spawndata._id_14CDE247AC3313A4 = "east";
    spawndata.team = "axis";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }
    spawndata._id_14CDE247AC3313A4 = "west";
    spawndata.team = "allies";
    level.numhqtanks_allies++;
  }

  _id_FE827F03F6233BE7 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, _id_EE8DA5624236DC89);
  return _id_FE827F03F6233BE7;
}

_id_91397B675B427DA6(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", spawndata, _id_EE8DA5624236DC89);
}

_id_9945B400B938A173(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_pwc", spawndata, _id_EE8DA5624236DC89);
}

_id_52E04331732241D7(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata, _id_EE8DA5624236DC89);
}

_id_4FBF67E0D91458F8(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", spawndata, _id_EE8DA5624236DC89);
}

_id_784AA0F6EE634AE5(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawndata, _id_EE8DA5624236DC89);
}

_id_DB3F4677D3B1EF4A(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_sedan_hatchback_1985", spawndata, _id_EE8DA5624236DC89);
}

_id_93F25760D0131658(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata, _id_EE8DA5624236DC89);
}

_id_C43C5200D882B134(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_utv", spawndata, _id_EE8DA5624236DC89);
}

_id_C6436C7F3E995D85(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_hummer", spawndata, _id_EE8DA5624236DC89);
}

_id_9D7D93DEF34D9958(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_overland_2016", spawndata, _id_EE8DA5624236DC89);
}

_id_A23B100003FC2003(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_acv_6x6", spawndata, _id_EE8DA5624236DC89);
}

_id_70199CF52BDA53FA(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";
  spawndata._id_14CDE247AC3313A4 = scripts\engine\utility::ter_op(spawndata.team == "axis", "east", "west");
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_cougar", spawndata, _id_EE8DA5624236DC89);
}

_id_64440E5A2BFD8900(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata, _id_EE8DA5624236DC89);
}

_id_505626AB02E6C2D6(vehicle) {
  level thread _id_53F5EB5DB0AE2AA1(vehicle);
}

_id_53F5EB5DB0AE2AA1(vehicle) {
  scripts\engine\utility::flag_wait("spawn_areas_ready");
  scripts\mp\rally_point::rallypointvehicle_activate(vehicle);
}

_id_A53CAAEF0414A722(vehicle) {
  if(!istrue(level.showteamtanks)) {
    return;
  }
  if(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() == "veh9_cougar")
    icon = "hud_icon_minimap_vehicle_tank_cougar";
  else
    icon = "hud_icon_minimap_vehicle_tank_coscar";

  level thread vehicle_createspawnselectiontankmarker(vehicle, vehicle.team, icon);
}

vehicle_createspawnselectiontankmarker(vehicle, team, icon) {
  if(!isDefined(icon))
    icon = "hud_icon_minimap_vehicle_tank_coscar";

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
    if(isDefined(player) && isDefined(player.team) && player.team == team && istrue(player.inspawnselection))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(marker.objidnum, player);
  }

  vehicle.spawnselectionmarker = marker;
  thread vehicle_watchmarkedtankdeath(vehicle);
  level.trackedtanks[team][level.trackedtanks[team].size] = vehicle;
}

vehicle_watchmarkedtankdeath(vehicle) {
  objidnum = vehicle.spawnselectionmarker.objidnum;
  team = vehicle.team;
  vehicle waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(objidnum);
  level.trackedtanks[team] = scripts\engine\utility::array_remove(level.trackedtanks[team], vehicle);
}

vehicle_showteamtanks() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tank in level.trackedtanks[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(tank.spawnselectionmarker.objidnum, self);

  while(self.inspawnselection)
    waitframe();

  foreach(tank in level.trackedtanks["axis"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);

  foreach(tank in level.trackedtanks["allies"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;

  if(isDefined(loc.script_team))
    spawndata.team = scripts\engine\utility::ter_op(loc.script_team == "axis", "axis", "allies");

  return spawndata;
}

droptank_playincomingdialog(spawndata) {
  team = spawndata.team;
  streakname = "bradley";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[streakname])) {
      if(isDefined(level.killstreakactivatedtime[streakname][team])) {
        if(gettime() < level.killstreakactivatedtime[streakname][team])
          return;
      }
    }

    level.killstreakactivatedtime[streakname][team] = gettime() + scripts\cp_mp\utility\killstreak_utility::getkillstreakdialogcooldown() * 1000;
  }

  scripts\mp\utility\dialog::leaderdialog(team + "_friendly_" + streakname + "_inbound", team, "killstreak_used");
}

init_rallyvehicles() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_apc_8x8", "create", ::_id_505626AB02E6C2D6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_palfa", "create", ::_id_505626AB02E6C2D6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_patrol_boat", "create", ::_id_505626AB02E6C2D6);

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  waitframe();
  level.rallypointvehicles = [];
  _id_29354B69BD8DEF17 = "gw_vehicle_technical_";
  _id_E6FE9018451C854C = "gw_vehicle_apc_";
  _id_FB1D0F7637A20DD6 = "gw_vehicle_armored_boat_";
  _id_B142FC4830A64BEA = "gw_vehicle_littlebird_";
  _id_60A367641181424C = [];
  _id_605CD7AD6472B682 = [];
  _id_7B2A53909CAB7620 = [];

  foreach(team in level.teamnamelist) {
    _id_60A367641181424C[team] = 0;
    _id_605CD7AD6472B682[team] = 0;
    _id_7B2A53909CAB7620[team] = 0;
  }

  _id_13B8ACCBD9C63733 = scripts\engine\utility::getStructArray("rallyPointAPC", "targetname");
  _id_13B8ACCBD9C63733 = scripts\engine\utility::array_combine(_id_13B8ACCBD9C63733, scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("apc_russian"));
  _id_13B8ACCBD9C63733 = scripts\engine\utility::array_combine(_id_13B8ACCBD9C63733, scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_apc_8x8"));

  foreach(loc in _id_13B8ACCBD9C63733) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }
    if(!isDefined(loc.script_team)) {
      continue;
    }
    ref = scripts\engine\utility::ter_op(loc.targetname == "apc_8x8_spawn", "veh9_apc_8x8", "apc_russian");

    if(!_id_E844513AE4FACC56(ref, loc.origin)) {
      continue;
    }
    loc = _id_4D91EFCD80FF8810(ref, loc);

    if(0)
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](ref)) {
      continue;
    }
    team = scripts\engine\utility::ter_op(loc.script_team == "axis", "axis", "allies");
    _id_DA3668523170EA04 = undefined;
    _id_605CD7AD6472B682[team]++;

    if(_id_605CD7AD6472B682[team] <= 2)
      _id_DA3668523170EA04 = _id_E6FE9018451C854C + _id_605CD7AD6472B682[team];
    else {}

    spawndata = getrallyvehiclespawndata(loc, team, _id_DA3668523170EA04);

    if(loc.targetname == "apc_8x8_spawn")
      spawndata._id_14CDE247AC3313A4 = scripts\engine\utility::ter_op(team == "axis", "east", "west");

    _id_EE8DA5624236DC89 = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(ref, spawndata, _id_EE8DA5624236DC89);

    if(isDefined(vehicle))
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
  }

  _id_13B8ACCBD9C63733 = scripts\engine\utility::getStructArray("rallyPointArmoredBoat", "targetname");
  _id_13B8ACCBD9C63733 = scripts\engine\utility::array_combine(_id_13B8ACCBD9C63733, scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_patrol_boat"));

  foreach(loc in _id_13B8ACCBD9C63733) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }
    if(!isDefined(loc.script_team)) {
      continue;
    }
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]]("veh9_patrol_boat")) {
      continue;
    }
    if(!_id_E844513AE4FACC56("veh9_patrol_boat", loc.origin)) {
      continue;
    }
    loc = _id_4D91EFCD80FF8810("veh9_patrol_boat", loc);

    if(0)
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

    team = scripts\engine\utility::ter_op(loc.script_team == "axis", "axis", "allies");
    _id_DA3668523170EA04 = undefined;
    _id_7B2A53909CAB7620[team]++;

    if(_id_7B2A53909CAB7620[team] <= 2)
      _id_DA3668523170EA04 = _id_FB1D0F7637A20DD6 + _id_7B2A53909CAB7620[team];
    else {}

    spawndata = getrallyvehiclespawndata(loc, team, _id_DA3668523170EA04);
    spawndata._id_14CDE247AC3313A4 = scripts\engine\utility::ter_op(team == "axis", "east", "west");
    _id_EE8DA5624236DC89 = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata, _id_EE8DA5624236DC89);

    if(isDefined(vehicle))
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
  }

  foreach(loc in scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_palfa")) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }
    if(!isDefined(loc.script_team)) {
      continue;
    }
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]]("veh9_palfa")) {
      continue;
    }
    if(!_id_E844513AE4FACC56("veh9_palfa", loc.origin)) {
      continue;
    }
    loc = _id_4D91EFCD80FF8810("veh9_palfa", loc);

    if(0)
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));

    team = scripts\engine\utility::ter_op(loc.script_team == "axis", "axis", "allies");
    _id_DA3668523170EA04 = undefined;
    _id_60A367641181424C[team]++;

    if(_id_60A367641181424C[team] <= 2)
      _id_DA3668523170EA04 = _id_B142FC4830A64BEA + _id_60A367641181424C[team];
    else {}

    spawndata = getrallyvehiclespawndata(loc, team, _id_DA3668523170EA04);
    spawndata._id_14CDE247AC3313A4 = scripts\engine\utility::ter_op(team == "axis", "east", "west");
    _id_EE8DA5624236DC89 = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata, _id_EE8DA5624236DC89);

    if(isDefined(vehicle))
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[_id_F90358454413407F][0]))
      waitframe();
  }

  scripts\engine\utility::flag_set("spawn_areas_ready");
}

getrallyvehiclespawndata(loc, team, _id_DA3668523170EA04) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.cannotbesuspended = 1;
  spawndata.ref = _id_DA3668523170EA04;
  spawndata.team = team;
  return spawndata;
}

managec130spawns() {
  level endon("game_ended");
  _id_033BBC02ACA0008B = 6000;
  _id_FDFE2D4AAF8EC33D = 12000;
  _id_F382830CB3A96BF9 = 20000;
  _id_B34D9378696E10BB = 1;
  _id_2B4EE773F94CEDCF = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawnc130[_id_F90358454413407F] = undefined;

  c130_pickrandomflightpath();
  level.spawnc130["axis"] = createc130("axis", level.c130pathstruct_a.startpt + _id_2B4EE773F94CEDCF);
  level.spawnc130["allies"] = createc130("allies", level.c130pathstruct_b.startpt + _id_2B4EE773F94CEDCF);

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    if(!isDefined(level.timeuntilnextc130))
      level.timeuntilnextc130 = [];

    if(!isDefined(level.timeuntilnextc130["axis"]))
      level.timeuntilnextc130["axis"] = 0;

    if(!isDefined(level.timeuntilnextc130["allies"]))
      level.timeuntilnextc130["allies"] = 0;

    timeuntilnextc130 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["axis"] = timeuntilnextc130;
    level.timeuntilnextc130["allies"] = timeuntilnextc130;

    if(0) {
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(_id_B34D9378696E10BB) {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt + _id_2B4EE773F94CEDCF, level.c130pathstruct_a.endpt + _id_2B4EE773F94CEDCF, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt + _id_2B4EE773F94CEDCF, level.c130pathstruct_b.endpt + _id_2B4EE773F94CEDCF, level.flighttime, "allies");
    } else {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "allies");
    }

    level.c130firstpassstarted = 1;
    level scripts\engine\utility::waittill_all_in_array(["C130_path_complete_axis", "C130_path_complete_allies"]);
    c130_fightpathmove();
    _id_AD5699EFE91E15CF = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = _id_AD5699EFE91E15CF;
    _id_AD5699EFE91E15CF = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = _id_AD5699EFE91E15CF;
    _id_B34D9378696E10BB = 0;

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

createc130(team, startpt) {
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
  gunship thread _id_45B2B4A889E633FA::gunship_spawnvfx();
  return gunship;
}

handlec130motion(startpt, endpt, time, team) {
  _id_8F95F32CFD252A35 = vectorNormalize(endpt - startpt);
  dist = distance(endpt, startpt);
  _id_92A519173221837E = startpt + _id_8F95F32CFD252A35 * dist * 0.425;
  _id_E7C3539B6FC3114F = startpt + _id_8F95F32CFD252A35 * dist * 0.55;
  _id_3CF9C28B9CFCBDFC = time * 0.3;
  _id_C27959A7028DB85C = time * 0.6;
  _id_678AE55DDF94D0BD = time * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  dir = vectorNormalize(endpt - startpt);
  self.angles = vectortoangles(dir);
  self.origin = startpt;
  gatherc130playerstospawn();
  self moveTo(endpt, _id_3CF9C28B9CFCBDFC + _id_C27959A7028DB85C + _id_678AE55DDF94D0BD, _id_3CF9C28B9CFCBDFC * 0.25);
  wait(_id_3CF9C28B9CFCBDFC);
  self.canparachute = 1;

  foreach(_id_AC0E424AC96A7113 in self.players)
  _id_AC0E424AC96A7113 notify("canParachute");

  wait(_id_C27959A7028DB85C);
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(_id_AC0E424AC96A7113 in self.players)
  _id_AC0E424AC96A7113 notify("halo_kick_c130");

  wait(_id_678AE55DDF94D0BD);
  level notify("C130_path_complete_" + team);
}

gatherc130playerstospawn() {
  self.players = scripts\engine\utility::array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  radius = 1400;
  _id_AD3758FD3576AE97 = (30, 0, 0);
  _id_7599C0B16DDED944 = anglesToForward(_id_AD3758FD3576AE97) * radius * -1;
  spawnpos = self gettagorigin("tag_origin") + _id_7599C0B16DDED944;
  _id_B7850001037AA074 = self.angles;

  foreach(_id_AC0E424AC96A7113 in self.players) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113.forcespawncameraorg = spawnpos;
    _id_AC0E424AC96A7113.forcespawncameraang = _id_B7850001037AA074;
    _id_AC0E424AC96A7113 notify("c130_ready");
  }
}

removefromspawnselectionaftertime(time) {
  wait(time);
  removefromspawnselection();
}

removefromspawnselection() {
  scripts\mp\spawnselection::removedynamicspawnarea(self.team, "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", self.team);
}

spawnplayertoc130() {
  self endon("disconnect");

  if(!isDefined(level.spawnc130[self.team])) {
    return;
  }
  self waittill("spawn_camera_idle");
  c130 = level.spawnc130[self.team];
  c130.respawnqueue[c130.respawnqueue.size] = self;

  if(istrue(c130.canjoin))
    c130 gatherc130playerstospawn();

  if(istrue(self.inspawncamera))
    self waittill("spawn_camera_complete");
  else
    self waittill("spawned_player");

  _id_3B64EB40368C1450::set("spawnPlayerToC130", "killstreaks", 0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread jumplistener(c130, 0);
  self.br_infil_type = "c130";

  if(!isbot(self))
    thread _id_45B2B4A889E633FA::orbitcam(c130);
}

jumplistener(c130, _id_1B89121EF11344D5) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self.parachute))
    self.parachute delete();

  self.c130 = c130;
  thread listenjump(c130, _id_1B89121EF11344D5);
  thread listenkick(c130, _id_1B89121EF11344D5);
}

listenkick(c130, _id_0A3F91A4A7069575) {
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
  _id_F9805AAD354A150E = c130 _id_60D787A38293225F::calctrailpoint();
  thread parachute(c130, _id_0A3F91A4A7069575);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

listenjump(c130, _id_1B89121EF11344D5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  for(;;) {
    result = scripts\engine\utility::waittill_either("halo_jump_c130", "canParachute");

    if(isDefined(result) && result == "canParachute")
      self iprintlnbold("Press Jump to Parachute!");
    else if(!istrue(c130.canparachute))
      self iprintlnbold("Not over the AO");
    else
      break;

    if(self.sessionstate == "spectator")
      return;
  }

  self cameradefault();
  self unlink();
  wait 0.1;
  thread parachute(c130, _id_1B89121EF11344D5);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

parachute(c130, _id_1B89121EF11344D5) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis")
    _id_69DBCC65237EC970 = level.c130pathstruct_b.midpt;
  else
    _id_69DBCC65237EC970 = level.c130pathstruct_a.midpt;

  _id_C4E660D969DCEEE5 = vectorNormalize(_id_69DBCC65237EC970 - c130.origin);
  c130.players = scripts\engine\utility::array_remove(c130.players, self);

  if(isDefined(c130.playeroffsets) && isDefined(c130.currentplayeroffset)) {
    offset = c130.playeroffsets[c130.currentplayeroffset];
    self setOrigin(c130.origin + offset, 1, 1);
    c130.currentplayeroffset++;

    if(c130.currentplayeroffset == c130.playeroffsets.size)
      c130.currentplayeroffset = 0;
  } else {
    _id_E03CC98B6B9A9F1C = anglesToForward(c130.angles) * c130.br_vieworigin;
    self setOrigin(c130.origin + _id_E03CC98B6B9A9F1C, 1, 1);
  }

  waitframe();
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("arm_vehicles::parachute()");
  self.plotarmor = 0;
  self.c130 = undefined;
  self setplayerangles(vectortoangles(_id_C4E660D969DCEEE5));
  thread scripts\cp_mp\parachute::startfreefall(5.0, 0);
}

debug_randomflightpathstest() {
  wait 10;

  for(;;) {
    c130_pickrandomflightpath();
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - (0, 0, 10000);
    level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - (0, 0, 10000);
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - (0, 0, 10000);
    level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - (0, 0, 10000);
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, (1, 0, 1));
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, (1, 0, 1));
    wait 1;
  }
}

c130_pickrandomflightpath() {
  if(istrue(level.c130alignedtolocale) && istrue(level.useobjectives)) {
    mapcenter = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
    _id_F3C9E115B49A626A = vectortoangles(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
    angle = _id_F3C9E115B49A626A[1];

    if(0)
      thread scripts\mp\utility\debug::drawsphere(mapcenter, 1000, 100000, (0, 1, 0));
  } else {
    mapcenter = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    angle = randomfloatrange(0, 359);
  }

  _id_15C3CD2DAB9EA60C = makec130pathparamsstruct(mapcenter, angle - 90);
  level.c130pathstruct_a = _id_45B2B4A889E633FA::makepathstruct(_id_15C3CD2DAB9EA60C);
  _id_15C3CD2DAB9EA60C.randomangle = _id_15C3CD2DAB9EA60C.randomangle + 180;
  level.c130pathstruct_b = _id_45B2B4A889E633FA::makepathstruct(_id_15C3CD2DAB9EA60C);
  _id_3ABADAB203328AD1 = 0.2;
  _id_B4885B21FE401AC5 = 0;
  _id_A433228CDFB64C3A = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    _id_3ABADAB203328AD1 = 0.1;
    _id_B4885B21FE401AC5 = randomfloatrange(-5000.0, 5000);
    _id_A433228CDFB64C3A = randomfloatrange(-5000.0, 5000);
  }

  right = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = right * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = right * level.c130distapart + level.c130pathstruct_a.endpt;
  right = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = right * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = right * level.c130distapart + level.c130pathstruct_b.endpt;
  offset = (_id_B4885B21FE401AC5, _id_A433228CDFB64C3A, 0);
  level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + offset;
  level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + offset;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + offset;
  level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + offset;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, _id_3ABADAB203328AD1);
  level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

makec130pathparamsstruct(centerpt, angle) {
  _id_F94F9769A1F2D802 = 6.28318;
  randomangle = angle;
  endangleoffset = 180;
  r = level.c130flightdist;
  _id_CD37CE775909957B = spawnStruct();
  _id_CD37CE775909957B.r = r;
  _id_CD37CE775909957B.randomangle = randomangle;
  _id_CD37CE775909957B.endangleoffset = endangleoffset;
  _id_CD37CE775909957B.centerpt = centerpt;
  return _id_CD37CE775909957B;
}

c130_fightpathmove() {
  if(0)
    level.c130movementmethod = 2;

  if(level.c130movementmethod == 0)
    return;
  else if(level.c130movementmethod == 1) {
    if(0) {
      level.c130pathkilltracker["axis"] = 1;
      level.c130pathkilltracker["allies"] = 0;
    }

    if(level.c130pathkilltracker["axis"] > level.c130pathkilltracker["allies"]) {
      if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
        level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      }
    } else if(arenextpathsinsafebounds(level.c130minpathmovementinterval * -1.0)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - level.c130minpathmovementinterval;
    }

    level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
    level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
  } else if(level.c130movementmethod == 2) {
    _id_D320310339164AAC = (0, 0, 0);
    _id_EE6D8B534C2DDD2D = (0, 0, 0);
    _id_6D48EB54C3A800FC = 0;
    _id_9297D08353BAF063 = 0;

    foreach(player in level.players) {
      if(isalive(player)) {
        if(player.team == "axis") {
          _id_D320310339164AAC = _id_D320310339164AAC + player.origin;
          _id_6D48EB54C3A800FC++;
          continue;
        }

        if(player.team == "allies") {
          _id_EE6D8B534C2DDD2D = _id_EE6D8B534C2DDD2D + player.origin;
          _id_9297D08353BAF063++;
        }
      }
    }

    if(_id_6D48EB54C3A800FC == 0 || _id_9297D08353BAF063 == 0) {
      return;
    }
    _id_FABE25D5659F05A9 = _id_D320310339164AAC / _id_6D48EB54C3A800FC;
    _id_C43D9EC2E9A839C6 = _id_EE6D8B534C2DDD2D / _id_9297D08353BAF063;
    _id_0BE2C550023FB372 = vectorlerp(_id_FABE25D5659F05A9, _id_C43D9EC2E9A839C6, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, _id_0BE2C550023FB372, 0.5);
    level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.battlecenter;
    _id_37DFB4F272C7016D = distance2d(level.battlecenter, _id_0BE2C550023FB372);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * _id_37DFB4F272C7016D / 4;
    level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);

    if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);

      if(0) {
        thread scripts\mp\utility\debug::drawsphere(level.battlecenter, 1000, 700, (1, 0, 0));
        thread scripts\mp\utility\debug::drawsphere(_id_0BE2C550023FB372, 1000, 700, (0, 1, 0));
      }

      level.battlecenter = level.battlecenter + level.c130minpathmovementinterval;
    }
  }
}

arenextpathsinsafebounds(offset) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + offset) && ispointinsafebounds(level.c130pathstruct_a.endpt + offset) && ispointinsafebounds(level.c130pathstruct_b.startpt + offset) && ispointinsafebounds(level.c130pathstruct_b.endpt + offset);
}

ispointinsafebounds(_id_CDCD3178F5176585) {
  return _id_CDCD3178F5176585[0] < level.mapsafecorners[0][0] && _id_CDCD3178F5176585[0] > level.mapsafecorners[1][0] && _id_CDCD3178F5176585[1] < level.mapsafecorners[0][1] && _id_CDCD3178F5176585[1] > level.mapsafecorners[1][1];
}