/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_spawn.gsc
****************************************************/

vehicle_spawn_getleveldataforvehicle(_id_7731ADEF63E19B0C, create) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).spawn))) {
    data = undefined;

    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
      data = spawnStruct();
    else
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    data.spawn = spawnStruct();
    data.spawn.maxinstancecount = 0;
    data.spawn.priority = 50;
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).spawn;
}

_id_37480E9C9C701CF2(_id_7731ADEF63E19B0C, spawndata) {
  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, 0, 0);

  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  spawndata.targetname = _id_7731ADEF63E19B0C;

  if(isDefined(_id_E2818AD39A3341B4.vehicle))
    spawndata.vehicletype = _id_E2818AD39A3341B4.vehicle;

  if(isDefined(spawndata.vehicleoverride))
    spawndata.vehicletype = spawndata.vehicleoverride;

  model = _id_E2818AD39A3341B4.model;

  if(istrue(spawndata._id_F16652E1462A3739) && isDefined(_id_E2818AD39A3341B4.ai.model))
    model = _id_E2818AD39A3341B4.ai.model;

  if(isDefined(spawndata._id_14CDE247AC3313A4))
    spawndata.modelname = spawndata._id_14CDE247AC3313A4 + "::" + model;
  else if(isDefined(_id_E2818AD39A3341B4._id_14CDE247AC3313A4) && _id_E2818AD39A3341B4._id_14CDE247AC3313A4 != "")
    spawndata.modelname = _id_E2818AD39A3341B4._id_14CDE247AC3313A4 + "::" + model;
  else
    spawndata.modelname = model;

  if(isDefined(spawndata._id_3474B4E818850C46))
    spawndata.modelname = spawndata._id_3474B4E818850C46;

  return spawndata;
}

_id_1CC780D5CAC1E7CD(_id_7731ADEF63E19B0C, spawndata, _id_DEE73A1FA79B1B6D) {
  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, 0, 0);

  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  spawndata.targetname = _id_E2818AD39A3341B4._id_FB41D1CA75009BF0.ref;
  spawndata.vehicletype = scripts\engine\utility::ter_op(isDefined(_id_E2818AD39A3341B4._id_FB41D1CA75009BF0.vehicle), _id_E2818AD39A3341B4._id_FB41D1CA75009BF0.vehicle, _id_E2818AD39A3341B4.vehicle);
  spawndata.modelname = _id_E2818AD39A3341B4._id_FB41D1CA75009BF0.model;

  if(!isDefined(spawndata.vehicletype))
    spawndata.vehicletype = _id_DEE73A1FA79B1B6D;

  spawndata._id_0131EA86B569E731 = 0;
  return spawndata;
}

_id_75CE57F81B582B38(vehicle, _id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  spawndata = spawnStruct();
  spawndata.origin = vehicle.origin;
  spawndata.angles = vehicle.angles;
  spawndata.initialvelocity = anglestoup(vehicle.angles) * _id_E2818AD39A3341B4._id_FB41D1CA75009BF0._id_71DF88882A7EC721;
  spawndata._id_EC2DF2ACAF230179 = _id_7731ADEF63E19B0C;
  spawndata._id_064A02A3BA94254D = _id_E2818AD39A3341B4._id_FB41D1CA75009BF0._id_064A02A3BA94254D;
  spawndata._id_AAB9695C92B0ED96 = scripts\cp_mp\vehicles\vehicle_damage::_id_7A5070220FC8CE9E(_id_7731ADEF63E19B0C, vehicle._id_AAB9695C92B0ED96);
  spawndata._id_6DC04302DA1A9D03 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(vehicle);
  spawndata._id_22AA4AA0CF0AA6BB = vehicle._id_22AA4AA0CF0AA6BB;

  if(isDefined(spawndata._id_6DC04302DA1A9D03))
    spawndata._id_14CDE247AC3313A4 = spawndata._id_6DC04302DA1A9D03._id_14CDE247AC3313A4;

  if(vehicle vehicle_getspeed() > _id_E2818AD39A3341B4._id_FB41D1CA75009BF0._id_5C46723E5C84C4B6)
    spawndata.initialvelocity = vehicle vehicle_getvelocity() * _id_E2818AD39A3341B4._id_FB41D1CA75009BF0._id_C1A04B9D422DB491;

  return spawndata;
}

vehicle_spawn_canspawnVehicle(_id_7731ADEF63E19B0C, owner, team, spawntype) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](_id_7731ADEF63E19B0C)) {
      if(isDefined(_id_7731ADEF63E19B0C)) {
        if(!scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_instancesarelimited(_id_7731ADEF63E19B0C) || !scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit(_id_7731ADEF63E19B0C, owner, team, spawntype)) {
          _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(_id_7731ADEF63E19B0C);

          if(isDefined(_id_E2818AD39A3341B4)) {
            if(istrue(level.ignorevehicletypeinstancelimit) || !isDefined(_id_E2818AD39A3341B4.maxinstancecount) || scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(_id_7731ADEF63E19B0C).size < _id_E2818AD39A3341B4.maxinstancecount) {
              if(isDefined(_id_E2818AD39A3341B4.canspawncallback))
                return [[_id_E2818AD39A3341B4.canspawncallback]](owner, team);
              else
                return 1;
            } else {}
          } else {}
        } else {}
      } else {}
    } else {}
  } else {}

  return 0;
}

_id_25D4B673539659A1() {
  while(!level._id_54C8ACFD634A416C)
    waitframe();

  _id_C9ED6663F76BEC8A = [];

  foreach(ref, data in level._id_A0B2C978CA57FFC5) {
    if(!isDefined(data.spawn) || !isDefined(data.spawn._id_32B659CDF8F93AE2)) {
      continue;
    }
    _id_C9ED6663F76BEC8A[data.spawn._id_32B659CDF8F93AE2] = data;
  }

  points = [];
  _id_9E4E1482CB40C9C5 = [];

  foreach(targetname, data in _id_C9ED6663F76BEC8A)
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::array_combine(_id_9E4E1482CB40C9C5, scripts\engine\utility::getStructArray(targetname, "targetname"));

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }
    num = -1;

    switch (tolower(struct.script_noteworthy)) {
      case "a":
        num = 0;
        break;
      case "b":
        num = 1;
        break;
      case "c":
        num = 2;
        break;
      case "d":
        num = 3;
        break;
      case "e":
        num = 4;
        break;
    }

    if(num == -1) {
      continue;
    }
    points[num] = [_id_C9ED6663F76BEC8A[struct.targetname].ref, struct.origin, struct.angles, struct.script_team];
  }

  return points;
}

_id_9F3EE4972DEC5B57(_id_7731ADEF63E19B0C, origin, angles, targetname, vehicletype, script_noteworthy) {
  if(!isDefined(_id_7731ADEF63E19B0C) || !isDefined(origin)) {
    return;
  }
  if(!isDefined(targetname))
    targetname = _id_348B69EC4082CEBA(_id_7731ADEF63E19B0C);

  if(!isDefined(vehicletype))
    vehicletype = _id_8FB5B3DA3AD4D628(_id_7731ADEF63E19B0C);

  if(!isDefined(targetname) || !isDefined(vehicletype)) {
    return;
  }
  struct = spawnStruct();
  struct.origin = origin;
  struct.angles = angles;
  struct.targetname = targetname;
  struct.vehicletype = vehicletype;
  struct.script_noteworthy = script_noteworthy;
  scripts\engine\utility::_id_1F6C1A9B7564DC61(struct);
}

_id_B08E7E3A0B14F76F(_id_7731ADEF63E19B0C) {
  targetname = _id_348B69EC4082CEBA(_id_7731ADEF63E19B0C);

  if(!isDefined(targetname))
    return [];

  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(targetname, "targetname");

  if(_id_9E4E1482CB40C9C5.size > 0) {
    _id_9E4E1482CB40C9C5 = vehicle_spawn_removespawnstructswithflag(_id_9E4E1482CB40C9C5);

    if(_id_9E4E1482CB40C9C5.size > 1)
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::array_randomize(_id_9E4E1482CB40C9C5);
  }

  return _id_9E4E1482CB40C9C5;
}

_id_348B69EC4082CEBA(_id_7731ADEF63E19B0C) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_038F50DECB5603D7(_id_7731ADEF63E19B0C))
    return undefined;

  if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return _func_06A36B14E6B79459("vehiclebundle:" + _id_7731ADEF63E19B0C + scripts\engine\utility::ter_op(!scripts\common\utility::iscp(), "_mp", "_cp"), "stat_59912BCE9911324B");
  else {
    data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(isDefined(data))
      return data.targetname;
  }
}

_id_8FB5B3DA3AD4D628(_id_7731ADEF63E19B0C) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_038F50DECB5603D7(_id_7731ADEF63E19B0C))
    return undefined;

  if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return _func_06A36B14E6B79459("vehiclebundle:" + _id_7731ADEF63E19B0C + scripts\engine\utility::ter_op(!scripts\common\utility::iscp(), "_mp", "_cp"), "stat_FAD9715041E583AF");
  else {
    data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(isDefined(data))
      return data.vehicle;
  }
}

vehicle_spawn_removespawnstructswithflag(_id_BFE291B401A9BF2A) {
  if(getdvarint("dvar_D451D5012C6AF909", 0) == 1)
    return _id_BFE291B401A9BF2A;

  _id_6AA95E939196DB86 = 1;
  _id_42B00A533D5E71FC = [];

  foreach(struct in _id_BFE291B401A9BF2A) {
    if(isDefined(struct.spawnflags) && struct.spawnflags &_id_6AA95E939196DB86) {
      continue;
    }
    _id_42B00A533D5E71FC[_id_42B00A533D5E71FC.size] = struct;
  }

  return _id_42B00A533D5E71FC;
}

vehicle_spawn_gamemodesupportsrespawn() {
  if(scripts\common\utility::iscp())
    _id_FC8AFB765C52482B = 0;
  else {
    _id_FC8AFB765C52482B = 1;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_0B55EDC994348913 = getDvar("dvar_7611A2790A0BF7FE", "");

      if(_id_0B55EDC994348913 == "plunder" || _id_0B55EDC994348913 == "risk" || istrue(level._id_291B51C7AF8D1204))
        _id_FC8AFB765C52482B = 1;
      else
        _id_FC8AFB765C52482B = 0;
    }
  }

  return getdvarint("dvar_BD25469FA7E9F44F", _id_FC8AFB765C52482B);
}

_id_81D89CA10080F386() {
  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(spawndata._id_6DC04302DA1A9D03))
    spawndata = spawndata._id_6DC04302DA1A9D03;

  return !istrue(self._id_22AA4AA0CF0AA6BB) && !istrue(spawndata._id_F16652E1462A3739);
}

vehicle_spawn_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.spawn = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.databyref = [];
  _id_962A30A9BB8C0F09.spawnfromstructsdelayornotify = 5;
  _id_962A30A9BB8C0F09.respawndelayoverride = getdvarint("dvar_1F347FD0C3D771A2", 0);
  _id_962A30A9BB8C0F09.abandonedtimeoutoverride = getdvarint("dvar_E547FE8DFE1679F6", 0);
  _id_962A30A9BB8C0F09.respawndelay = getdvarint("dvar_8FDBBB498DB9480A", 60);
  _id_962A30A9BB8C0F09.abandonedtimeoutdelay = getdvarint("dvar_36374C04E23480B6", 30);
  vehicle_spawn_initspawnclearance();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "init")]]();
  vehicle_spawn_initlate();
  level.ignorevehicletypeinstancelimit = getdvarint("dvar_37F76437C65CD04E", 1);
}

vehicle_spawn_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_spawn", "initLate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "initLate")]]();
}

vehicle_spawn_spawnfromstructscomparefunc(_id_336FD2A2DB40C0EE, _id_336FD1A2DB40BEBB) {
  return _id_336FD2A2DB40C0EE.priority >= _id_336FD1A2DB40BEBB.priority;
}

vehicle_spawn_getleveldata() {
  return level.vehicle.spawn;
}

vehicle_spawn_isvehiclespawnStruct() {
  targetname = self.targetname;

  if(isDefined(targetname)) {
    switch (targetname) {
      case "hooptytruck_spawn":
      case "hoopty_spawn":
      case "cargotruck_spawn":
      case "apcrussian_spawn":
      case "tacrover_spawn":
      case "copcar_spawn":
      case "pickuptruck_spawn":
      case "largetransport_spawn":
      case "atv_spawn":
      case "littlebird_spawn":
      case "van_spawn":
      case "technical_spawn":
      case "jeep_spawn":
      case "mediumtransport_spawn":
      case "lighttank_spawn":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

vehicle_spawn_initspawnclearance() {
  _id_962A30A9BB8C0F09 = vehicle_spawn_getleveldata();
  _id_962A30A9BB8C0F09.clearancecheckminradii = [];
}

vehicle_spawn_checkspawnclearance(position, _id_7731ADEF63E19B0C, _id_C3FBB6661B91750F, _id_4AAF9F2CE5798F37, _id_71434C5ACF1C3551) {
  _id_962A30A9BB8C0F09 = vehicle_spawn_getleveldata();
  _id_1BFA1D374486DA61 = 200;
  _id_C473EEEB53BA4F3C = 200;
  _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  minradius = _id_E2818AD39A3341B4.clearancecheckradius;

  if(!isDefined(minradius))
    minradius = _id_962A30A9BB8C0F09.clearancecheckminradii[_id_7731ADEF63E19B0C];

  if(isDefined(_id_E2818AD39A3341B4.clearancecheckradius))
    _id_1BFA1D374486DA61 = _id_E2818AD39A3341B4.clearancecheckradius;

  if(isDefined(_id_E2818AD39A3341B4.clearancecheckheight))
    _id_C473EEEB53BA4F3C = _id_E2818AD39A3341B4.clearancecheckheight;

  if(isDefined(_id_71434C5ACF1C3551))
    position = position + (0, 0, _id_71434C5ACF1C3551);

  _id_B65B7AEAB526E1AC = (_id_1BFA1D374486DA61, _id_1BFA1D374486DA61, _id_C473EEEB53BA4F3C);
  _id_80745CF3E2877DF5 = position - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = position + _id_B65B7AEAB526E1AC;
  contents = _id_C3FBB6661B91750F;

  if(!isDefined(contents))
    contents = physics_createcontents(["physicscontents_vehicle"]);

  ignorelist = _id_4AAF9F2CE5798F37;

  if(!isDefined(ignorelist)) {
    ignorelist = [];
    ignorelist[ignorelist.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("emp_drone");
    ignorelist[ignorelist.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("cruise_predator");

    if(isDefined(level.supportdrones))
      ignorelist[ignorelist.size] = level.supportdrones;

    ignorelist = scripts\engine\utility::array_combine_multiple(ignorelist);
  }

  vehicles = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, contents, ignorelist);

  if(isDefined(vehicles) && vehicles.size > 0) {
    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.vehiclename)) {
        _id_DECA1B39A5EDFA25 = vehicle_spawn_getleveldataforvehicle(vehicle.vehiclename);
        _id_BB076E4CA88A53EC = undefined;

        if(isDefined(_id_DECA1B39A5EDFA25))
          _id_BB076E4CA88A53EC = _id_DECA1B39A5EDFA25.clearancecheckradius;

        if(!isDefined(_id_BB076E4CA88A53EC))
          _id_BB076E4CA88A53EC = _id_962A30A9BB8C0F09.clearancecheckminradii[vehicle.vehiclename];

        if(!isDefined(_id_BB076E4CA88A53EC)) {
          continue;
        }
        _id_87733E27A41D9EF9 = pow(minradius + _id_BB076E4CA88A53EC, 2);

        if(isDefined(_id_87733E27A41D9EF9) && _id_87733E27A41D9EF9 < distance2dsquared(vehicle.origin, position)) {
          continue;
        }
        return 0;
      }
    }
  }

  return 1;
}

vehicle_spawn_setclearancecheckminradius(ref, minradius) {
  _id_962A30A9BB8C0F09 = vehicle_spawn_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(ref);

  if(isDefined(_id_E2818AD39A3341B4)) {
    _id_E2818AD39A3341B4.clearancecheckradius = minradius;
    return;
  }

  _id_962A30A9BB8C0F09.clearancecheckminradii[ref] = minradius;
}

_id_B09E91C2E808DBCD(spawndata, _id_EE8DA5624236DC89) {
  return;
}

_id_FA044E2304E9E1A4() {
  thread _id_FC6EAD687E73F25F();
}

_id_FC6EAD687E73F25F() {
  spawndata = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(self._id_6DC04302DA1A9D03, spawndata);
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = vehicle_spawn_waitandrespawn(spawndata.targetname, spawndata, _id_EE8DA5624236DC89);
}

_id_284795E4A9E3762C() {
  thread _id_9A5D0431AFAF5B80();
}

_id_9A5D0431AFAF5B80() {
  _id_575EF651FFAB4369 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(_id_575EF651FFAB4369._id_6DC04302DA1A9D03))
    _id_575EF651FFAB4369 = _id_575EF651FFAB4369._id_6DC04302DA1A9D03;

  spawndata = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(_id_575EF651FFAB4369, spawndata);
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = vehicle_spawn_waitandrespawn(self.vehiclename, spawndata, _id_EE8DA5624236DC89);
}

vehicle_spawn_waitandrespawn(ref, spawndata, _id_EE8DA5624236DC89) {
  level endon("game_ended");
  level endon("cancel_pending_vehicle_respawns");
  _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(ref);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  _id_962A30A9BB8C0F09 = vehicle_spawn_getleveldata();
  delay = undefined;

  if(_id_962A30A9BB8C0F09.respawndelayoverride != 0)
    delay = _id_962A30A9BB8C0F09.respawndelayoverride;
  else if(isDefined(_id_E2818AD39A3341B4.respawndelay))
    delay = _id_E2818AD39A3341B4.respawndelay;
  else
    delay = _id_962A30A9BB8C0F09.respawndelay;

  if(delay >= 1) {
    if(delay >= 9999)
      return undefined;
  } else
    delay = 1;

  for(;;) {
    wait(delay);

    if(vehicle_spawn_canspawnVehicle(ref)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "alterRespawnData"))
        spawndata = [[scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "alterRespawnData")]](spawndata);

      if(vehicle_spawn_checkspawnclearance(spawndata.origin, ref)) {
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(ref, spawndata, _id_EE8DA5624236DC89);

        if(!isDefined(vehicle)) {
          continue;
        }
        return vehicle;
      }
    }

    delay = 5;
  }
}

vehicle_spawn_preventrespawn(vehicle) {
  vehicle._id_22AA4AA0CF0AA6BB = 1;
}

vehicle_spawn_cancelpendingrespawns() {
  level notify("cancel_pending_vehicle_respawns");
}

_id_6C65DF1F40E10037() {
  if(istrue(self.donotwatchabandoned)) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(self.occupants.size > 0) {
    return;
  }
  if(isDefined(self._id_3A442282FB9074E1) && self._id_3A442282FB9074E1.size > 0) {
    return;
  }
  if(isDefined(self._id_8784C427B1AF24A6) && self._id_8784C427B1AF24A6.size > 0) {
    return;
  }
  self endon("death");
  self endon("stop_watching_abandoned");
  wait 60;
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();
}

vehicle_spawn_gamemodesupportsabandonedtimeout(_id_5E1984DBB5848080) {
  _id_FC8AFB765C52482B = 1;

  if(scripts\common\utility::ismp() && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_FC8AFB765C52482B = 0;

  if(scripts\common\utility::iscp() && level.gametype != "cp_survival")
    _id_FC8AFB765C52482B = 0;

  if(_id_5E1984DBB5848080 && istrue(level._id_45496C9DF00F2BD4))
    _id_FC8AFB765C52482B = 1;

  dvar = scripts\engine\utility::ter_op(_id_5E1984DBB5848080, "dvar_1D79EF11C80BA28F", "dvar_AA11765FDE7E66F6");
  return getdvarint(dvar, _id_FC8AFB765C52482B);
}

vehicle_spawn_watchabandoned() {
  _id_5E1984DBB5848080 = scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2();

  if(!vehicle_spawn_gamemodesupportsabandonedtimeout(_id_5E1984DBB5848080)) {
    return;
  }
  if(istrue(self._id_7E5374C9FB7F2BD8)) {
    return;
  }
  if(self.occupants.size > 0) {
    return;
  }
  if(isDefined(self._id_3A442282FB9074E1) && self._id_3A442282FB9074E1.size > 0) {
    return;
  }
  if(isDefined(self._id_8784C427B1AF24A6) && self._id_8784C427B1AF24A6.size > 0) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(istrue(self.donotwatchabandoned)) {
    return;
  }
  _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  if(!isDefined(_id_E2818AD39A3341B4.abandonedtimeoutcallback)) {
    return;
  }
  self._id_7E5374C9FB7F2BD8 = 1;
  self endon("death");
  self endon("stop_watching_abandoned");
  _id_962A30A9BB8C0F09 = vehicle_spawn_getleveldata();
  delay = undefined;

  if(_id_962A30A9BB8C0F09.abandonedtimeoutoverride != 0 && !_id_5E1984DBB5848080)
    delay = _id_962A30A9BB8C0F09.abandonedtimeoutoverride;
  else if(isDefined(_id_E2818AD39A3341B4.abandonedtimeoutdelay) && !_id_5E1984DBB5848080)
    delay = _id_E2818AD39A3341B4.abandonedtimeoutdelay;
  else
    delay = _id_962A30A9BB8C0F09.abandonedtimeoutdelay;

  if(scripts\cp_mp\vehicles\vehicle::_id_7C62CA52F72901A1() && self vehicle_isonground())
    delay = delay * 0.3;

  if(delay >= 1) {
    if(delay >= 9999)
      return;
  } else
    delay = 1;

  wait(delay);
  thread vehicle_spawn_abandonedtimeout();
}

vehicle_spawn_stopwatchingabandoned() {
  self notify("stop_watching_abandoned");
  self._id_7E5374C9FB7F2BD8 = undefined;
}

vehicle_spawn_abandonedtimeout() {
  vehicle_spawn_stopwatchingabandoned();
  self.donotwatchabandoned = 1;
  _id_E2818AD39A3341B4 = vehicle_spawn_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  self thread[[_id_E2818AD39A3341B4.abandonedtimeoutcallback]]();
}

_id_357783D7C1D96273() {
  vehicle_spawn_stopwatchingabandoned();
  self.donotwatchabandoned = 1;
  thread vehicle_spawn_abandonedtimeoutcallback();
}

vehicle_spawn_abandonedtimeoutcallback() {
  damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();

  if(damagestate != "heavy") {
    _id_4E49623DC4538A67 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth(self);

    if(isDefined(_id_4E49623DC4538A67)) {
      self.health = int(min(_id_4E49623DC4538A67, self.health));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
    }

    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate("heavy", damagestate);
  }
}

_id_17BB29FECE7DA497(_id_7731ADEF63E19B0C) {
  return vehicle_spawn_getleveldataforvehicle(_id_7731ADEF63E19B0C).timeoutonabandoneddelay;
}

_id_AADE62C6CF163888(_id_7731ADEF63E19B0C) {
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

  if(isDefined(data._id_FB41D1CA75009BF0) && istrue(data._id_FB41D1CA75009BF0._id_F2CF04C055FD760E))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C)._id_FB41D1CA75009BF0._id_A7D11025C5CD54EC;
}

_id_89CDA5BA9BFC8D56(_id_7731ADEF63E19B0C) {
  return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C)._id_99B969DE33FE3BE4;
}

vehicle_spawn_initdev() {}