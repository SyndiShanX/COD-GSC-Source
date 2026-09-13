/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vehicles.gsc
************************************************/

brvehiclesinit() {
  level.modecontrolledvehiclespawningonly = 1;
  _id_6FC423AF9A153F6B = getdvarint("dvar_BB06B4F8C704366B", 1);
  _id_84F2FDAB2B0451DA = getdvarint("dvar_2D93BD0EAC4C5E38", 24);
  level.br_totalvehiclesmax = 128 - _id_84F2FDAB2B0451DA;
  level.br_totalvehiclesspawned = 0;
  level.br_helosmax = getdvarint("dvar_389F02283326428E", 3);
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level.br_vehtargetnametoref = [];
  level.br_vehtargetnametoref["atv_spawn"] = "atv";
  level.br_vehtargetnametoref["littlebird_spawn"] = "little_bird";
  level.br_vehtargetnametoref["tacrover_spawn"] = "tac_rover";
  level.br_vehtargetnametoref["jltv_spawn"] = "veh9_jltv";
  level.br_vehtargetnametoref["sedan_hatchback_1985_spawn"] = "veh9_sedan_hatchback_1985";
  level.br_vehtargetnametoref["suv_1996_spawn"] = "veh9_suv_1996";
  level.br_vehtargetnametoref["mil_cargo_truck_spawn"] = "veh9_mil_cargo_truck";
  level.br_vehtargetnametoref["hummer_spawn"] = "veh9_hummer";
  level.br_vehtargetnametoref["overland_2016_spawn"] = "veh9_overland_2016";
  level.br_vehtargetnametoref["utv_spawn"] = "veh9_utv";
  level.br_vehtargetnametoref["acv_6x6_spawn"] = "veh9_acv_6x6";
  level.br_vehtargetnametoref["pwc_spawn"] = "veh9_pwc";
  level.br_vehtargetnametoref["civ_lnd_dirt_bike_spawn"] = "veh9_civ_lnd_dirt_bike";
  _id_EBF775F8FDD1D098();

  if(istrue(_id_6FC423AF9A153F6B)) {
    level.br_vehtargetnametoref["rhib_spawn"] = "veh9_rhib";
    level.br_vehtargetnametoref["patrol_boat_spawn"] = "veh9_patrol_boat";
  }

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    if(getdvarint("dvar_81E631C248118CD6", 1) != 1)
      level.br_vehtargetnametoref["palfa_spawn"] = "veh9_palfa";

    level.br_vehtargetnametoref["jltv_mg_spawn"] = "veh9_jltv_mg";
  }

  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(1, ::dangercircletick, ::_id_1A1709943670772A);
  level thread _id_10BD49DA0D1D0E99();
  _id_C3FE673CE43BB311("little_bird", 3.5);
  _id_C3FE673CE43BB311("veh9_palfa", 3.5);
}

_id_EC5F666D56372630(_id_7731ADEF63E19B0C) {
  if(!getdvarint("scr_ssc_enabled", 0))
    return 0;

  if(!scripts\engine\utility::array_contains(level.br_vehtargetnametoref, _id_7731ADEF63E19B0C))
    return 0;

  dvar = _func_2EF675C13CA1C4AF("dvar_EA224DC24C0B7E07", _id_7731ADEF63E19B0C);

  if(!getdvarint(dvar, 0))
    return 0;

  return 1;
}

_id_10BD49DA0D1D0E99() {
  level endon("game_ended");
  scripts\mp\flags::_id_1240434F4201AC9D("POIs_initialized");

  if(_id_EC5F666D56372630("atv")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("atv", ::_id_9F5822D86978B19E);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("atv", ::_id_CA0E152F3297E659);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("atv", ::_id_B5A414EFCEB3F54F);
  }

  if(_id_EC5F666D56372630("little_bird")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("little_bird", ::_id_2102FBA2A828C232);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("little_bird", ::_id_65F7B522956A52FF);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("little_bird", ::_id_291769090B812445);
  }

  if(_id_EC5F666D56372630("tac_rover")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("tac_rover", ::_id_C0A0151F4C0FF8C9);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("tac_rover", ::_id_BE6B6E1D960C1308);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("tac_rover", ::_id_66C2A4789E6491BA);
  }

  if(_id_EC5F666D56372630("veh9_jltv")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_jltv", ::_id_D6AEB6EE47FE74AD);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_jltv", ::_id_CE321A982581AD00);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_jltv", ::_id_71D198D835193A56);
  }

  if(_id_EC5F666D56372630("veh9_sedan_hatchback_1985")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_sedan_hatchback_1985", ::_id_DE57950EF5ACCF81);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_sedan_hatchback_1985", ::_id_274B8E5537A9529A);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_sedan_hatchback_1985", ::_id_0371D960C3B3F2DC);
  }

  if(_id_EC5F666D56372630("veh9_suv_1996")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_suv_1996", ::_id_400C8A3BBFFD0504);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_suv_1996", ::_id_7CEEF8E0541EDFD3);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_suv_1996", ::_id_793F7DE400D83F21);
  }

  if(_id_EC5F666D56372630("veh9_mil_cargo_truck")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_mil_cargo_truck", ::_id_6A336EC87C1F16DE);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_mil_cargo_truck", ::_id_2C6682D4CE4084E7);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_mil_cargo_truck", ::_id_CFC47459234B3FF9);
  }

  if(_id_EC5F666D56372630("veh9_hummer")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_hummer", ::_id_102647F58948E17F);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_hummer", ::_id_014D37362E7D7E22);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_hummer", ::_id_A5439D62CC0526EC);
  }

  if(_id_EC5F666D56372630("veh9_overland_2016")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_overland_2016", ::_id_04411C7CD345DBB3);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_overland_2016", ::_id_3CB42802A742A13A);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_overland_2016", ::_id_25AE72A0ABF6FCC0);
  }

  if(_id_EC5F666D56372630("veh9_utv")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_utv", ::_id_BD8D56D939D2616A);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_utv", ::_id_1B40292EB23222C5);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_utv", ::_id_609800F04ADCAEC3);
  }

  if(_id_EC5F666D56372630("veh9_acv_6x6")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_acv_6x6", ::_id_0859C8CCEF60EC27);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_acv_6x6", ::_id_5E7B8045ECD8CACE);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_acv_6x6", ::_id_5592AEB2E358547C);
  }

  if(_id_EC5F666D56372630("veh9_pwc")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_pwc", ::_id_92A7F0D91A9AD72D);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_pwc", ::_id_D2576F2E7C9DBCC2);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_pwc", ::_id_8F677EF06E614F44);
  }

  if(_id_EC5F666D56372630("veh9_rhib")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_rhib", ::_id_734DE5A5EDF07444);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_rhib", ::_id_11A4DA6CDF9E2401);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_rhib", ::_id_24686392DA4705F7);
  }

  if(_id_EC5F666D56372630("veh9_patrol_boat")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_patrol_boat", ::_id_0F7A22ED2AB89AED);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_patrol_boat", ::_id_751318749BBDA6D4);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_patrol_boat", ::_id_F76D07033BDB9342);
  }

  if(_id_EC5F666D56372630("veh9_palfa")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_palfa", ::_id_E7E505C9082B29AB);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_palfa", ::_id_48BA3B0FEF3ADD30);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_palfa", ::_id_338688A9CF2CAD5E);
  }

  if(_id_EC5F666D56372630("veh9_jltv_mg")) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("veh9_jltv_mg", ::_id_802403521058FBC5);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("veh9_jltv_mg", ::_id_B36F8EBF1E721B70);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("veh9_jltv_mg", ::_id_C9D6726880A36A12);
  }
}

brvehiclesonstartgametype() {
  setupvehiclespawnvolumes();
  brvehiclesreset();
}

setupvehiclespawnvolumes() {
  _id_B6E57C7554EFC295 = "vehicle_volume";

  if(getdvarint("dvar_2CBC9C033FDEA714", 1))
    _id_B6E57C7554EFC295 = "vehicle_volume_simplified";

  level.brvehspawnvols = getEntArray(_id_B6E57C7554EFC295, "script_noteworthy");

  foreach(vol in level.brvehspawnvols)
  initvehiclespawnvolume(vol);

  level.br_vehicleallspawns = [];
  level.br_vehiclealwaysspawns = [];
  level.br_helospawns = [];
  level._id_B54C13AD1BD00973 = [];
  _id_7164111ED75798CC = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(refname in level.br_vehtargetnametoref) {
    _id_7A2113183150C910 = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);

    if(isDefined(level.filtervehiclespawnstructsfunc))
      _id_7A2113183150C910 = [[level.filtervehiclespawnstructsfunc]](_id_7A2113183150C910);

    if(isDefined(level._id_20B5AB3069C073E2))
      _id_7A2113183150C910 = [[level._id_20B5AB3069C073E2]](refname, _id_7A2113183150C910);

    level._id_B54C13AD1BD00973[refname] = _id_7A2113183150C910;
    level.br_vehicleallspawns = scripts\engine\utility::array_combine_unique(level.br_vehicleallspawns, _id_7A2113183150C910);

    foreach(spawnpoint in _id_7A2113183150C910) {
      if(isDefined(spawnpoint.script_priority) && spawnpoint.script_priority > 0) {
        _id_4928EC336FD14163 = level.br_vehiclealwaysspawns.size;
        level.br_vehiclealwaysspawns[_id_4928EC336FD14163] = spawnpoint;
        continue;
      }

      if(isDefined(spawnpoint.targetname) && spawnpoint.targetname == "littlebird_spawn") {
        level.br_helospawns[level.br_helospawns.size] = spawnpoint;
        continue;
      }

      foreach(vol in level.brvehspawnvols) {
        if(ispointinvolume(spawnpoint.origin, vol)) {
          _id_4928EC336FD14163 = vol.vehiclespawns.size;
          vol.vehiclespawns[_id_4928EC336FD14163] = spawnpoint;
          break;
        }
      }
    }
  }
}

initvehiclespawnvolume(vol) {
  vol.vehiclespawns = [];
  vol.vehiclesspawned = 0;
  assignvehicleminimumsforvolume(vol);
}

assignvehicleminimumsforvolume(vol) {
  vol.minvehicles = 0;

  switch (vol.targetname) {
    case "boneyard":
      vol.minvehicles = 2;
      break;
    case "dam":
      vol.minvehicles = 2;
      break;
    case "downtown":
      vol.minvehicles = 4;
      break;
    case "downtownpark":
      vol.minvehicles = 1;
      break;
    case "farm":
      vol.minvehicles = 4;
      break;
    case "gulag":
      vol.minvehicles = 1;
      break;
    case "hospital":
      vol.minvehicles = 0;
      break;
    case "junkyard":
      vol.minvehicles = 1;
      break;
    case "layover":
      vol.minvehicles = 3;
      break;
    case "lumber":
      vol.minvehicles = 2;
      break;
    case "militarybase":
      vol.minvehicles = 3;
      break;
    case "port":
      vol.minvehicles = 2;
      break;
    case "quarry":
      vol.minvehicles = 2;
      break;
    case "stadium":
      vol.minvehicles = 1;
      break;
    case "storagewars":
      vol.minvehicles = 1;
      break;
    case "super":
      vol.minvehicles = 1;
      break;
    case "torez":
      vol.minvehicles = 1;
      break;
    case "transit":
      vol.minvehicles = 2;
      break;
    case "tvstation":
      vol.minvehicles = 1;
      break;
    case "test_zone":
      vol.minvehicles = 1;
      break;
  }
}

_id_9F5822D86978B19E() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("atv");
}

_id_2102FBA2A828C232() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("little_bird");
}

_id_C0A0151F4C0FF8C9() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("tac_rover");
}

_id_D6AEB6EE47FE74AD() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_jltv");
}

_id_DE57950EF5ACCF81() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_sedan_hatchback_1985");
}

_id_400C8A3BBFFD0504() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_suv_1996");
}

_id_6A336EC87C1F16DE() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_mil_cargo_truck");
}

_id_102647F58948E17F() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_hummer");
}

_id_04411C7CD345DBB3() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_overland_2016");
}

_id_BD8D56D939D2616A() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_utv");
}

_id_0859C8CCEF60EC27() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_acv_6x6");
}

_id_92A7F0D91A9AD72D() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_pwc");
}

_id_734DE5A5EDF07444() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_rhib");
}

_id_0F7A22ED2AB89AED() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_patrol_boat");
}

_id_E7E505C9082B29AB() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_palfa");
}

_id_802403521058FBC5() {
  return scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_jltv_mg");
}

emptyallvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  foreach(_id_7731ADEF63E19B0C, _id_E5CD5CE5EE8DC6C9 in level.vehicle.instances) {
    foreach(vehicle in _id_E5CD5CE5EE8DC6C9) {
      if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(vehicle);
    }
  }
}

deleteextantvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_cancelpendingrespawns();

  foreach(_id_7731ADEF63E19B0C, _id_E5CD5CE5EE8DC6C9 in level.vehicle.instances) {
    foreach(vehicle in _id_E5CD5CE5EE8DC6C9) {
      scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);
      vehicle._id_A8F4BB03B366AA80 = 1;
      level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
    }
  }
}

tryspawnavehicle(refname, _id_E035FDEF423A5164, _id_1FDC5457E35DAA15, _id_EE8DA5624236DC89) {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("vehicleSpawns")) {
    return;
  }
  if((refname == "little_bird" || refname == "little_bird_mg") && _id_362C58E8BB39BCDA::isfeaturedisabled("littleBirdSpawns")) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    if(refname == "veh9_overland_2016" && distancesquared(_id_E035FDEF423A5164.origin, (19290, -23687, 1123)) < 250000) {
      return;
    }
    if(refname == "atv" && distancesquared(_id_E035FDEF423A5164.origin, (-19928, -48860, 207)) < 250000) {
      return;
    }
    if(refname == "veh9_pwc" && distancesquared(_id_E035FDEF423A5164.origin, (-7168, 29580, 120)) < 250000) {
      return;
    }
    if(refname == "veh9_hummer" && distancesquared(_id_E035FDEF423A5164.origin, (-3799, -16760, 4537)) < 250000) {
      return;
    }
    if(refname == "veh9_civ_lnd_dirt_bike" && distancesquared(_id_E035FDEF423A5164.origin, (-4061, 1148, 1352)) < 250000) {
      return;
    }
    if(refname == "veh9_mil_cargo_truck" && distancesquared(_id_E035FDEF423A5164.origin, (-3543.3, -24134.3, 4209.84)) < 250000)
      return;
  }

  if(!_id_362C58E8BB39BCDA::isfeatureenabled("gasVehicleSpawns")) {
    if(!_id_2695A20D4011076D::_id_D449927F9683E871(_id_E035FDEF423A5164.origin))
      return;
  }

  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(refname)) {
    _id_1C4D640F34DCB9A7 = spawnavehicle(refname, _id_E035FDEF423A5164, _id_EE8DA5624236DC89);

    if(isDefined(_id_1C4D640F34DCB9A7))
      return _id_1C4D640F34DCB9A7;
  }

  return undefined;
}

spawnavehicle(refname, _id_E035FDEF423A5164, _id_EE8DA5624236DC89) {
  spawnorigin = _id_E035FDEF423A5164.origin;
  spawnangles = _id_E035FDEF423A5164.angles;

  if(!isDefined(spawnangles))
    spawnangles = (0, randomfloat(360), 0);

  spawndata = spawnStruct();
  spawndata.origin = spawnorigin;
  spawndata.angles = spawnangles;
  spawndata.spawntype = "GAME_MODE";
  _id_1C4D640F34DCB9A7 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(refname, spawndata, _id_EE8DA5624236DC89);

  if(isDefined(_id_1C4D640F34DCB9A7))
    _id_715028F54BAD19A1::branalytics_vehiclespawned(_id_1C4D640F34DCB9A7, refname);

  return _id_1C4D640F34DCB9A7;
}

spawninitialvehicles() {
  _id_7164111ED75798CC = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  level.br_totalvehiclesspawned = 0;
  _id_96EB15D5230A7B6E = 0;
  _id_B9188BDFF51C7168 = [];
  _id_5487117230712D7B = level.br_vehicleallspawns;
  _id_D23016D6D9981605 = scripts\engine\utility::array_randomize(level.br_vehiclealwaysspawns);

  foreach(spawnpoint in _id_D23016D6D9981605) {
    _id_EE8DA5624236DC89 = spawnStruct();
    refname = level.br_vehtargetnametoref[spawnpoint.targetname];

    if(_id_EC5F666D56372630(refname)) {
      continue;
    }
    _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, "alwaysSpawn", _id_EE8DA5624236DC89);

    if(isDefined(_id_1C4D640F34DCB9A7)) {
      level.br_totalvehiclesspawned++;
      _id_B9188BDFF51C7168[_id_B9188BDFF51C7168.size] = spawnpoint;
      _id_1D035A86EA1B5E63 = 0;

      foreach(vol in level.brvehspawnvols) {
        if(ispointinvolume(spawnpoint.origin, vol)) {
          vol.vehiclesspawned++;
          _id_1D035A86EA1B5E63 = 1;
          break;
        }
      }

      if(!_id_1D035A86EA1B5E63) {}

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
      continue;
    }

    _id_96EB15D5230A7B6E++;
  }

  _id_82E084D0CB9A7F40 = 0;

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    _id_60C2C2B7CEA6E920 = scripts\engine\utility::array_randomize(level.brvehspawnvols);

    foreach(vol in _id_60C2C2B7CEA6E920) {
      _id_B243344E26FC2116 = vol.minvehicles;

      if(isDefined(_id_B243344E26FC2116) && _id_B243344E26FC2116 > 0) {
        if(_id_B243344E26FC2116 > vol.vehiclespawns.size) {}

        if(vol.vehiclesspawned < _id_B243344E26FC2116 && vol.vehiclespawns.size > 0) {
          _id_848FE69E536B827A = scripts\engine\utility::array_remove_array(scripts\engine\utility::array_randomize(vol.vehiclespawns), _id_B9188BDFF51C7168);

          for(_id_62E50AD3144802A8 = 0; vol.vehiclesspawned < _id_B243344E26FC2116 && _id_62E50AD3144802A8 < _id_848FE69E536B827A.size; _id_62E50AD3144802A8++) {
            _id_EE8DA5624236DC89 = spawnStruct();
            spawnpoint = _id_848FE69E536B827A[_id_62E50AD3144802A8];
            refname = level.br_vehtargetnametoref[spawnpoint.targetname];

            if(_id_EC5F666D56372630(refname)) {
              continue;
            }
            _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, vol.targetname, _id_EE8DA5624236DC89);

            if(!isDefined(_id_1C4D640F34DCB9A7)) {
              _id_82E084D0CB9A7F40++;
              continue;
            }

            level.br_totalvehiclesspawned++;
            _id_B9188BDFF51C7168[_id_B9188BDFF51C7168.size] = spawnpoint;
            vol.vehiclesspawned++;

            if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
              break;
            }

            waitframe();
          }

          if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
            break;
          }
        }
      }
    }
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    _id_56B381327050BC62 = 0;
    _id_5C969801281B9666 = scripts\engine\utility::array_remove_array(scripts\engine\utility::array_randomize(level.br_helospawns), _id_B9188BDFF51C7168);

    foreach(spawnpoint in _id_5C969801281B9666) {
      _id_EE8DA5624236DC89 = spawnStruct();
      refname = level.br_vehtargetnametoref[spawnpoint.targetname];

      if(_id_EC5F666D56372630(refname)) {
        continue;
      }
      _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, "heloSpawn", _id_EE8DA5624236DC89);

      if(isDefined(_id_1C4D640F34DCB9A7)) {
        level.br_totalvehiclesspawned++;
        _id_B9188BDFF51C7168[_id_B9188BDFF51C7168.size] = spawnpoint;
        _id_56B381327050BC62++;

        if(_id_56B381327050BC62 >= level.br_helosmax) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax && _id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_9856AD860555F8B9();
    _id_5487117230712D7B = scripts\engine\utility::array_remove_array(_id_5487117230712D7B, _id_B9188BDFF51C7168);

    foreach(refname, _id_29D9D2428185616D in level._id_B54C13AD1BD00973) {
      if(!isDefined(level._id_A5791492570C75FC) || !isDefined(level._id_A5791492570C75FC[refname])) {
        continue;
      }
      if(_id_EC5F666D56372630(refname)) {
        continue;
      }
      _id_29D9D2428185616D = scripts\engine\utility::array_randomize(_id_29D9D2428185616D);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_A5791492570C75FC[refname]; _id_AC0E594AC96AA3A8++) {
        spawnpoint = _id_29D9D2428185616D[_id_AC0E594AC96AA3A8];

        if(!isDefined(spawnpoint)) {
          break;
        }

        _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, "globalMinSpawns", spawnStruct());

        if(!isDefined(_id_1C4D640F34DCB9A7)) {
          continue;
        }
        level.br_totalvehiclesspawned++;
        _id_B9188BDFF51C7168[_id_B9188BDFF51C7168.size] = spawnpoint;

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }

    _id_5487117230712D7B = scripts\engine\utility::array_remove_array(_id_5487117230712D7B, _id_B9188BDFF51C7168);

    foreach(spawn in _id_5487117230712D7B) {
      _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(spawn.origin);
      _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(spawn.origin, _id_B205D90302DA2F07);

      if(isDefined(_id_D1CF55B36FACF5A8)) {
        if(!isDefined(_id_D1CF55B36FACF5A8._id_6A39DCD2615FB321))
          _id_D1CF55B36FACF5A8._id_6A39DCD2615FB321 = [];

        _id_D1CF55B36FACF5A8._id_6A39DCD2615FB321[_id_D1CF55B36FACF5A8._id_6A39DCD2615FB321.size] = spawn;
      }
    }

    foreach(_id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
        if(!isDefined(_id_D1CF55B36FACF5A8.minvehicles) || _id_D1CF55B36FACF5A8.minvehicles <= 0 || !isDefined(_id_D1CF55B36FACF5A8._id_6A39DCD2615FB321) || _id_D1CF55B36FACF5A8._id_6A39DCD2615FB321.size == 0) {
          _id_D1CF55B36FACF5A8._id_6A39DCD2615FB321 = undefined;
          continue;
        }

        _id_29D9D2428185616D = scripts\engine\utility::array_randomize(_id_D1CF55B36FACF5A8._id_6A39DCD2615FB321);
        _id_AC0E594AC96AA3A8 = 0;

        while(_id_D1CF55B36FACF5A8._id_1903D60D80D1CE1C < _id_D1CF55B36FACF5A8.minvehicles && _id_AC0E594AC96AA3A8 < _id_29D9D2428185616D.size) {
          spawnpoint = _id_29D9D2428185616D[_id_AC0E594AC96AA3A8];
          _id_EE8DA5624236DC89 = spawnStruct();
          refname = level.br_vehtargetnametoref[spawnpoint.targetname];

          if(_id_EC5F666D56372630(refname)) {
            continue;
          }
          _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, "subAreaSpawns", _id_EE8DA5624236DC89);

          if(isDefined(_id_1C4D640F34DCB9A7)) {
            level.br_totalvehiclesspawned++;
            _id_B9188BDFF51C7168[_id_B9188BDFF51C7168.size] = spawnpoint;
            _id_D1CF55B36FACF5A8._id_1903D60D80D1CE1C++;

            if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
              break;
            }

            waitframe();
          }

          _id_AC0E594AC96AA3A8++;
        }

        _id_D1CF55B36FACF5A8._id_6A39DCD2615FB321 = undefined;

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }
      }

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }
    }
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    _id_848FE69E536B827A = 0;
    _id_5487117230712D7B = scripts\engine\utility::array_remove_array(_id_5487117230712D7B, _id_B9188BDFF51C7168);
    _id_5487117230712D7B = scripts\engine\utility::array_randomize(_id_5487117230712D7B);

    foreach(spawnpoint in _id_5487117230712D7B) {
      refname = level.br_vehtargetnametoref[spawnpoint.targetname];

      if(!isDefined(refname)) {
        continue;
      }
      if(_id_EC5F666D56372630(refname)) {
        continue;
      }
      while(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle())
        wait 1;

      _id_EE8DA5624236DC89 = spawnStruct();
      _id_1C4D640F34DCB9A7 = tryspawnavehicle(refname, spawnpoint, "randomSpawns", _id_EE8DA5624236DC89);
      level.br_totalvehiclesspawned++;
      _id_848FE69E536B827A++;

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
    }
  }

  _id_F2EAB7E1DDEEDF9A = 0;
  _id_E158D1582D080CC6 = _id_96EB15D5230A7B6E + _id_82E084D0CB9A7F40;

  if(_id_F2EAB7E1DDEEDF9A > 0)
    return;
}

_id_CB75D1E034823CB5(loc, _id_7731ADEF63E19B0C) {
  if(!isDefined(level._id_7CD5202FEECD6D42))
    level._id_7CD5202FEECD6D42 = [];

  if(!isDefined(level._id_7CD5202FEECD6D42[_id_7731ADEF63E19B0C]))
    level._id_7CD5202FEECD6D42[_id_7731ADEF63E19B0C] = [];

  _id_A61C75B156FC1EE0 = level._id_7CD5202FEECD6D42[_id_7731ADEF63E19B0C].size;
  level._id_7CD5202FEECD6D42[_id_7731ADEF63E19B0C][_id_A61C75B156FC1EE0] = loc;
  return loc;
}

_id_CA0E152F3297E659(loc) {
  return _id_CB75D1E034823CB5(loc, "atv");
}

_id_65F7B522956A52FF(loc) {
  return _id_CB75D1E034823CB5(loc, "little_bird");
}

_id_BE6B6E1D960C1308(loc) {
  return _id_CB75D1E034823CB5(loc, "tac_rover");
}

_id_CE321A982581AD00(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_jltv");
}

_id_274B8E5537A9529A(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_sedan_hatchback_1985");
}

_id_7CEEF8E0541EDFD3(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_suv_1996");
}

_id_2C6682D4CE4084E7(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_mil_cargo_truck");
}

_id_014D37362E7D7E22(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_hummer");
}

_id_3CB42802A742A13A(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_overland_2016");
}

_id_1B40292EB23222C5(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_utv");
}

_id_5E7B8045ECD8CACE(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_acv_6x6");
}

_id_D2576F2E7C9DBCC2(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_pwc");
}

_id_11A4DA6CDF9E2401(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_rhib");
}

_id_751318749BBDA6D4(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_patrol_boat");
}

_id_48BA3B0FEF3ADD30(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_palfa");
}

_id_B36F8EBF1E721B70(loc) {
  return _id_CB75D1E034823CB5(loc, "veh9_jltv_mg");
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

_id_05E2AC14F881014B(loc, _id_7731ADEF63E19B0C) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_7731ADEF63E19B0C, spawndata);
}

_id_FB0DB2FC84DF7793(_id_0FAC0789C390440D, refname) {
  level endon("game_ended");

  if(!getdvarint("scr_ssc_enabled", 0)) {
    return;
  }
  foreach(loc in _id_0FAC0789C390440D) {
    _id_05E2AC14F881014B(loc, refname);
    level.br_totalvehiclesspawned++;
    waitframe();
  }
}

_id_B5A414EFCEB3F54F() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["atv"], "atv");
}

_id_291769090B812445() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["little_bird"], "little_bird");
}

_id_66C2A4789E6491BA() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["tac_rover"], "tac_rover");
}

_id_71D198D835193A56() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_jltv"], "veh9_jltv");
}

_id_0371D960C3B3F2DC() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_sedan_hatchback_1985"], "veh9_sedan_hatchback_1985");
}

_id_793F7DE400D83F21() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_suv_1996"], "veh9_suv_1996");
}

_id_CFC47459234B3FF9() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_mil_cargo_truck"], "veh9_mil_cargo_truck");
}

_id_A5439D62CC0526EC() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_hummer"], "veh9_hummer");
}

_id_25AE72A0ABF6FCC0() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_overland_2016"], "veh9_overland_2016");
}

_id_609800F04ADCAEC3() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_utv"], "veh9_utv");
}

_id_5592AEB2E358547C() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_acv_6x6"], "veh9_acv_6x6");
}

_id_8F677EF06E614F44() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_pwc"], "veh9_pwc");
}

_id_24686392DA4705F7() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_rhib"], "veh9_rhib");
}

_id_F76D07033BDB9342() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_patrol_boat"], "veh9_patrol_boat");
}

_id_338688A9CF2CAD5E() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_palfa"], "veh9_palfa");
}

_id_C9D6726880A36A12() {
  _id_FB0DB2FC84DF7793(level._id_7CD5202FEECD6D42["veh9_jltv_mg"], "veh9_jltv_mg");
}

_id_CD9F2FE51C02D74E() {
  if(!getdvarint("scr_ssc_enabled", 0)) {
    return;
  }
  if(!isDefined(level._id_7CD5202FEECD6D42)) {
    return;
  }
  foreach(refname, _id_0FAC0789C390440D in level._id_7CD5202FEECD6D42)
  _id_FB0DB2FC84DF7793(_id_0FAC0789C390440D, refname);
}

_id_9856AD860555F8B9() {
  table = level._id_09FAB40ED3326F8B;

  if(!isDefined(table)) {
    return;
  }
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);
    _id_71AD22C5D093D90B = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 1));
    minvehicles = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 6));

    if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_71AD22C5D093D90B])) {
      _id_FB65B3577DA146B0 = spawnStruct();
      _id_FB65B3577DA146B0.minvehicles = minvehicles;
      _id_FB65B3577DA146B0._id_1903D60D80D1CE1C = 0;
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_71AD22C5D093D90B].minvehicles = minvehicles;
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_71AD22C5D093D90B]._id_1903D60D80D1CE1C = 0;
      continue;
    }

    if(_id_171F90B9C4C76D44 == "minVehicleSpawns") {
      _id_7731ADEF63E19B0C = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 1);
      vehiclespawns = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 2));

      if(!isDefined(level._id_A5791492570C75FC))
        level._id_A5791492570C75FC = [];

      level._id_A5791492570C75FC[_id_7731ADEF63E19B0C] = vehiclespawns;
    }
  }
}

brvehiclespawnvolreset() {
  level.br_totalvehiclesspawned = 0;
  _id_7164111ED75798CC = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(vol in level.brvehspawnvols)
  vol.vehiclesspawned = 0;
}

waitforvehiclestodeletethenspawninitial() {
  level endon("game_ended");
  level notify("br_vehiclesWaitForDelete");
  level endon("br_vehiclesWaitForDelete");
  waitframe();
  waittillframeend;
  _id_CD9F2FE51C02D74E();

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("spawnInitialVehicles"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("spawnInitialVehicles");
  else
    spawninitialvehicles();

  _id_EE64EBB471957DC7();
}

brvehiclesreset() {
  emptyallvehicles();
  deleteextantvehicles();
  brvehiclespawnvolreset();
  level thread waitforvehiclestodeletethenspawninitial();
}

brvehicleonprematchstarted() {
  wait 1.5;

  if(!istrue(level._id_7BF42D565645A485)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(0);
  brvehiclesreset();
  level thread _id_439D01E25D19543B::_id_E456F5964BA54D64();
  _id_4480C6CE37B2BDF3::_id_B52F35A3FF450ECD();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(1);
}

_id_C3FE673CE43BB311(_id_7731ADEF63E19B0C, _id_83263D327522CBA1) {
  if(!isDefined(level._id_AED9C28063F339CD))
    level._id_AED9C28063F339CD = [];

  value = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_20C93B9A1BF4D35D", _id_7731ADEF63E19B0C, "_pct"), _id_83263D327522CBA1);
  level._id_AED9C28063F339CD[_id_7731ADEF63E19B0C] = value * 0.01;
}

_id_4E336CD994097306(vehicle, _id_A3336B3496D766EF) {
  _id_C4C191BEFB977DB0 = _id_A3336B3496D766EF;
  _id_796DBBB5B21A7303 = level._id_AED9C28063F339CD[vehicle.vehiclename];

  if(isDefined(_id_796DBBB5B21A7303) && _id_796DBBB5B21A7303 > 0.0)
    _id_C4C191BEFB977DB0 = vehicle.maxhealth * _id_796DBBB5B21A7303;

  return _id_C4C191BEFB977DB0;
}

_id_A3C6F2C2714EE754() {
  vehicles = [];
  _id_CC3563F7AEFB3492 = level.vehicle.instances["little_bird"];
  _id_400701C211C2A6C2 = level.vehicle.instances["veh9_palfa"];
  vehicles = scripts\engine\utility::array_combine(_id_CC3563F7AEFB3492, _id_400701C211C2A6C2);
  return vehicles;
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("vehiclesGasDamage")) {
    return;
  }
  _id_C9578424EBA088BD = 160.0;
  _id_0C19221171F30346 = 36.0;
  _id_763565CB1EBE7F95 = 100.0;
  _id_A3336B3496D766EF = getdvarfloat("dvar_B89033584B879669", _id_763565CB1EBE7F95);
  helis = _id_A3C6F2C2714EE754();

  if(isDefined(helis)) {
    foreach(heli in helis) {
      _id_13D5B2AC0E7C768B = 0;
      _id_6F3A90A6B2B8799D = heli.origin;
      _id_24135B85B8E536B8 = distance2d(_id_819EDACDACB810E4, _id_6F3A90A6B2B8799D);

      if(_id_24135B85B8E536B8 + _id_C9578424EBA088BD > _id_E86632D645C137D0)
        _id_13D5B2AC0E7C768B = 1;
      else {
        _id_85DBF781A77FC451 = heli gettagorigin("tail_rotor_jnt");
        _id_24135B85B8E536B8 = distance2d(_id_819EDACDACB810E4, _id_85DBF781A77FC451);

        if(_id_24135B85B8E536B8 + _id_0C19221171F30346 > _id_E86632D645C137D0)
          _id_13D5B2AC0E7C768B = 1;
      }

      if(_id_13D5B2AC0E7C768B) {
        _id_C4C191BEFB977DB0 = _id_4E336CD994097306(heli, _id_A3336B3496D766EF);
        heli dodamage(_id_C4C191BEFB977DB0, _id_6F3A90A6B2B8799D, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }
}

_id_1A1709943670772A() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances) || !istrue(level._id_2DF69B8E552238B6)) {
    return;
  }
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("vehiclesGasDamage")) {
    return;
  }
  _id_C9578424EBA088BD = 160.0;
  _id_763565CB1EBE7F95 = 100.0;
  _id_A3336B3496D766EF = getdvarfloat("dvar_B89033584B879669", _id_763565CB1EBE7F95);
  helis = _id_A3C6F2C2714EE754();

  if(isDefined(helis)) {
    foreach(heli in helis) {
      if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(heli.origin, _id_C9578424EBA088BD)) {
        _id_C4C191BEFB977DB0 = _id_4E336CD994097306(heli, _id_A3336B3496D766EF);
        heli dodamage(_id_C4C191BEFB977DB0, heli.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }
}

_id_B5A8E76FBF49784A(_id_7731ADEF63E19B0C) {
  _id_B5C99E03C0C2DC5C = level._id_A0EB995EDD24354A[_id_7731ADEF63E19B0C];

  if(isDefined(_id_B5C99E03C0C2DC5C))
    setomnvarbit("ui_br_vehicles_spawned", _id_B5C99E03C0C2DC5C, 1);
}

_id_EBF775F8FDD1D098() {
  level._id_A0EB995EDD24354A = [];
  _id_2CC549A811DB0B3B = getscriptbundle("vehicleenum:iw9_vehicle_enum");

  if(!isDefined(_id_2CC549A811DB0B3B))
    return [];

  foreach(id, _id_87A2FFA83754B065 in _id_2CC549A811DB0B3B._id_FBB490B5D203D70C) {
    if(!isnumber(id)) {
      continue;
    }
    if(!isDefined(_id_87A2FFA83754B065)) {
      continue;
    }
    _id_7731ADEF63E19B0C = _id_87A2FFA83754B065.vehicle;

    if(!isDefined(_id_7731ADEF63E19B0C)) {
      continue;
    }
    level._id_A0EB995EDD24354A[_id_7731ADEF63E19B0C] = id;
  }
}

_id_EE64EBB471957DC7() {
  if(level._id_A0EB995EDD24354A.size > 0) {
    foreach(_id_7731ADEF63E19B0C, _id_E5CD5CE5EE8DC6C9 in level.vehicle.instances)
    _id_B5A8E76FBF49784A(_id_7731ADEF63E19B0C);
  }
}