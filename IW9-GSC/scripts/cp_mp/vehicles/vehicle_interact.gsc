/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_interact.gsc
*******************************************************/

vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).interact))) {
    data = undefined;

    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
      data = spawnStruct();
    else
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(!isDefined(data.interact))
      data.interact = spawnStruct();

    data.interact._id_ED5C39E0B1EF815C = [];
    data.interact._id_29F1EA79ED2B40DD = 180;
    data.interact._id_4C6D695D0920DF19 = 130;
    data.interact._id_4C4A7B5D08FABEF7 = 170;
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).interact;
}

vehicle_interact_getinstancedataforvehicle(vehicle, create, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, create, _id_6ECB77FD1F27C667);

  if(!isDefined(_id_E2818AD39A3341B4))
    return undefined;

  if(!isDefined(vehicle getlinkedscriptableinstance()))
    return undefined;

  _id_72141EAB56FB408F = vehicle.interactdata;

  if(!isDefined(_id_72141EAB56FB408F)) {
    if(istrue(create)) {
      _id_72141EAB56FB408F = spawnStruct();
      vehicle.interactdata = _id_72141EAB56FB408F;
      _id_72141EAB56FB408F.disabledbyallow = 0;
      _id_72141EAB56FB408F.pointdata = [];

      foreach(_id_015FCF7D846A9D9A in _id_E2818AD39A3341B4._id_ED5C39E0B1EF815C)
      _id_72141EAB56FB408F.pointdata[_id_015FCF7D846A9D9A] = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, create, _id_6ECB77FD1F27C667);

      _id_72141EAB56FB408F.dirty = 1;
      _id_72141EAB56FB408F.disabled = undefined;
      _id_72141EAB56FB408F.availableteam = undefined;
    } else {}
  }

  return _id_72141EAB56FB408F;
}

_id_3E11A192D07B42EA(_id_7731ADEF63E19B0C, _id_015FCF7D846A9D9A, _id_1226C93AD199F9F1) {
  _id_E2818AD39A3341B4 = vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C, undefined, 1);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  _id_1B7218958DC3B187 = _id_247FF3BB886C55FF(_id_015FCF7D846A9D9A);
  _id_E2818AD39A3341B4._id_ED5C39E0B1EF815C = scripts\engine\utility::array_add(_id_E2818AD39A3341B4._id_ED5C39E0B1EF815C, _id_015FCF7D846A9D9A);
  _id_CF0F83CC6E448DEB("activate", _id_015FCF7D846A9D9A, _id_1226C93AD199F9F1, _id_E2818AD39A3341B4);
}

vehicle_interact_registerinstance(vehicle) {
  vehicle_interact_getinstancedataforvehicle(vehicle, 1);
  vehicle_interact_makeusable(vehicle);
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();
  _id_962A30A9BB8C0F09.vehicles[vehicle getentitynumber()] = vehicle;
}

vehicle_interact_deregisterinstance(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();

  if(isDefined(_id_962A30A9BB8C0F09.vehicles[vehicle getentitynumber()]))
    vehicle_interact_makeunusable(vehicle);

  _id_962A30A9BB8C0F09.vehicles[vehicle getentitynumber()] = undefined;
  vehicle.interactdata = undefined;
}

vehicle_interact_instanceisregistered(vehicle) {
  return isDefined(vehicle.interactdata);
}

vehicle_interact_allowvehicleuseglobal(_id_E3108E412AFB3811) {
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();

  if(!isDefined(_id_962A30A9BB8C0F09.vehicles)) {
    return;
  }
  if(!_id_E3108E412AFB3811) {
    _id_962A30A9BB8C0F09.disabledbyallow++;

    if(_id_962A30A9BB8C0F09.disabledbyallow == 1) {
      foreach(vehicle in _id_962A30A9BB8C0F09.vehicles) {
        vehicle_interact_setvehicledirty(vehicle);
        vehicle_interact_updateusability(vehicle);
      }
    }
  } else {
    _id_962A30A9BB8C0F09.disabledbyallow--;

    if(_id_962A30A9BB8C0F09.disabledbyallow == 0) {
      foreach(vehicle in _id_962A30A9BB8C0F09.vehicles) {
        vehicle_interact_setvehicledirty(vehicle);
        vehicle_interact_updateusability(vehicle);
      }
    }
  }
}

vehicle_interact_allowvehicleuse(vehicle, _id_E3108E412AFB3811) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  if(!_id_E3108E412AFB3811) {
    _id_72141EAB56FB408F.disabledbyallow++;

    if(_id_72141EAB56FB408F.disabledbyallow == 1) {
      vehicle_interact_setvehicledirty(vehicle);
      vehicle_interact_updateusability(vehicle);
    }
  } else {
    _id_72141EAB56FB408F.disabledbyallow--;

    if(_id_72141EAB56FB408F.disabledbyallow == 0) {
      vehicle_interact_setvehicledirty(vehicle);
      vehicle_interact_updateusability(vehicle);
    }
  }
}

vehicle_interact_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.interact = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.vehicledata = [];
  _id_962A30A9BB8C0F09._id_ED5C39E0B1EF815C = [];
  _id_962A30A9BB8C0F09.disabledbyallow = 0;
  _id_BFC085DDF18E1712("single", ::_id_F1F336C41F281C07, ::_id_CD93C6E46BC00381, ::_id_39C1F2552DCFD9B0, ::_id_C9601FED18D5B11E);
  _id_BFC085DDF18E1712("upgrade", ::_id_2B58C6EEAEA42C35, ::_id_D2B057155910001B, ::_id_2BC48C2BCC22A4FE, ::_id_BD192331E198BE64);
  _id_BFC085DDF18E1712("copyofupgrade", ::_id_2B58C6EEAEA42C35, ::_id_D2B057155910001B, ::_id_2BC48C2BCC22A4FE, ::_id_BD192331E198BE64);
  level thread _id_F588087BF9D7FEFB();
  scripts\engine\scriptable::scriptable_addusedcallback(::vehicle_interact_scriptableused);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_interact", "init", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_interact", "init")]]();

  level thread _id_AE4888C247642906();
}

_id_356EA06606D08642(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("luinotifyserver", _id_EA3E3B2121E6713A);

    if(!isDefined(_id_EA3E3B2121E6713A)) {
      continue;
    }
    _id_6681408AC5FCC6CF = player.pers["telemetry"];

    if(_id_EA3E3B2121E6713A == "vehicle_cruise_control_on" && isDefined(_id_6681408AC5FCC6CF._id_A04E1E3880A078A8))
      _id_6681408AC5FCC6CF._id_A04E1E3880A078A8++;
  }
}

_id_AE4888C247642906() {
  for(;;) {
    waitframe();
    waittillframeend;
    level.vehicle._id_2B6807C7DF9A2B2D = undefined;
  }
}

_id_79E9116EBF7DC551() {
  if(isDefined(level.vehicle._id_2B6807C7DF9A2B2D)) {
    return;
  }
  vehicles = vehicle_interact_getleveldata().vehicles;

  if(isDefined(vehicles) && vehicles.size > 0) {
    level.vehicle._id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28([], 650);

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle) && isDefined(vehicle.origin))
        level.vehicle._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_24BBEFB4BEDA630D(vehicle);
    }
  }
}

_id_BFC085DDF18E1712(_id_015FCD7D846A9934, _id_DA1C69068B772B09, _id_9182C2DD101AE147, activatefunc, _id_B5F98A8061379598) {
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();
  _id_277A287AB71BB547 = spawnStruct();
  callbacks = [];
  callbacks["useInstance"] = _id_DA1C69068B772B09;
  callbacks["cleanInstance"] = _id_9182C2DD101AE147;
  callbacks["activate"] = activatefunc;
  callbacks["createInstance"] = _id_B5F98A8061379598;
  _id_277A287AB71BB547.callbacks = callbacks;
  _id_962A30A9BB8C0F09._id_ED5C39E0B1EF815C[_id_015FCD7D846A9934] = _id_277A287AB71BB547;
}

vehicle_interact_scriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "vehicle_use") {
    vehicle = instance.entity;
    _id_015FCF7D846A9D9A = part;

    if(vehicle_interact_playercanusevehicles(player)) {
      if(istrue(vehicle_interact_vehiclecanbeused(vehicle))) {
        if(vehicle_interact_playercanusevehicle(player, vehicle)) {
          if(vehicle_interact_pointcanbeused(vehicle, _id_015FCF7D846A9D9A)) {
            _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A);
            _id_CF0F83CC6E448DEB("useInstance", _id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, player);
          }
        }
      }
    }
  }
}

vehicle_interact_updateplayerusability(player, vehicles) {
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();

  if(!vehicle_interact_playercanusevehicles(player)) {
    foreach(vehicle in vehicles) {
      if(isDefined(vehicle))
        vehicle disablescriptableplayeruse(player);
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

vehicle_interact_monitorplayerusability(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("update_vehicle_usability", _id_BD572A35F03CED5B);
    vehicle_interact_updateplayerusability(player, _id_BD572A35F03CED5B);
  }
}

vehicle_interact_getleveldata() {
  return level.vehicle.interact;
}

_id_247FF3BB886C55FF(_id_015FCF7D846A9D9A) {
  return level.vehicle.interact._id_ED5C39E0B1EF815C[_id_015FCF7D846A9D9A];
}

_id_CF0F83CC6E448DEB(_id_B1B6487BC37B37FB, _id_015FCF7D846A9D9A, _id_CE4B3AF5B29C05AF, _id_346563F5FDA7D489, _id_72EACC3730EC7823) {
  _id_1B7218958DC3B187 = _id_247FF3BB886C55FF(_id_015FCF7D846A9D9A);
  _id_847D2A046CAA4B54 = _id_1B7218958DC3B187.callbacks[_id_B1B6487BC37B37FB];

  if(isDefined(_id_847D2A046CAA4B54))
    level thread[[_id_847D2A046CAA4B54]](_id_015FCF7D846A9D9A, _id_CE4B3AF5B29C05AF, _id_346563F5FDA7D489, _id_72EACC3730EC7823);
}

vehicle_interact_playercanusevehicles(player) {
  if(!isDefined(player))
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("vehicle_use"))
    return 0;

  if(player isparachuting() || player isskydiving())
    return 0;

  if(player isinexecutionattack() || player isinexecutionvictim())
    return 0;

  if(istrue(level.infiltransistioning))
    return 0;

  return 1;
}

vehicle_interact_vehiclecanbeused(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F))
    return undefined;

  if(_id_72141EAB56FB408F.dirty)
    vehicle_interact_cleanvehicle(vehicle);

  return !_id_72141EAB56FB408F.disabled;
}

vehicle_interact_pointcanbeused(vehicle, _id_015FCF7D846A9D9A) {
  _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, undefined, 1);

  if(!isDefined(_id_1F4CF79F66927511))
    return undefined;

  if(_id_1F4CF79F66927511.dirty)
    vehicle_interact_cleanpoint(vehicle, _id_015FCF7D846A9D9A);

  return !_id_1F4CF79F66927511.disabled;
}

vehicle_interact_playercanusevehicle(player, vehicle) {
  if(level.teambased) {
    team = vehicle_interact_getvehicleavailableteam(vehicle);

    if(isDefined(team) && team != player.team)
      return 0;
  } else {
    playerfriendlyto = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getplayerfriendlyto(vehicle);

    if(isDefined(playerfriendlyto) && playerfriendlyto != player)
      return 0;
  }

  return 1;
}

vehicle_interact_getvehicleavailableteam(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F))
    return undefined;

  if(_id_72141EAB56FB408F.dirty)
    vehicle_interact_cleanvehicle(vehicle);

  return _id_72141EAB56FB408F.availableteam;
}

vehicle_interact_setvehicledirty(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  _id_72141EAB56FB408F.dirty = 1;
}

_id_5C097A8F16A227D5(show) {
  if(isDefined(self) && self isscriptable() && self getscriptablehaspart("visibility"))
    self setscriptablepartstate("visibility", scripts\engine\utility::ter_op(istrue(show), "show", "hide"));
}

vehicle_interact_cleanvehicle(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_interact_getleveldata();
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  if(level.teambased) {
    teamfriendlyto = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(vehicle);

    if(isDefined(teamfriendlyto))
      _id_72141EAB56FB408F.availableteam = teamfriendlyto;
    else {
      availableteam = undefined;
      _id_DB47E5CED41F6CA8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getreserving(vehicle);

      foreach(player in _id_DB47E5CED41F6CA8) {
        if(isDefined(player)) {
          availableteam = player.team;
          break;
        }
      }

      _id_72141EAB56FB408F.availableteam = availableteam;
    }
  }

  if(_id_962A30A9BB8C0F09.disabledbyallow > 0)
    _id_72141EAB56FB408F.disabled = 1;
  else if(_id_72141EAB56FB408F.disabledbyallow > 0)
    _id_72141EAB56FB408F.disabled = 1;
  else
    _id_72141EAB56FB408F.disabled = 0;

  _id_72141EAB56FB408F.dirty = 0;
}

vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, create, _id_6ECB77FD1F27C667) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, create, _id_6ECB77FD1F27C667);

  if(!isDefined(_id_72141EAB56FB408F))
    return undefined;

  _id_1F4CF79F66927511 = _id_72141EAB56FB408F.pointdata[_id_015FCF7D846A9D9A];

  if(!isDefined(_id_1F4CF79F66927511) && isDefined(create)) {
    if(istrue(create)) {
      _id_1F4CF79F66927511 = spawnStruct();
      _id_72141EAB56FB408F.pointdata[_id_015FCF7D846A9D9A] = _id_1F4CF79F66927511;
      _id_1F4CF79F66927511.dirty = 1;
      _id_1F4CF79F66927511.disabled = undefined;
      _id_CF0F83CC6E448DEB("createInstance", _id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle);
    } else {}
  }

  return _id_1F4CF79F66927511;
}

vehicle_interact_pointisdisabled(vehicle, _id_015FCF7D846A9D9A) {
  _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, undefined, 1);

  if(!isDefined(_id_1F4CF79F66927511))
    return undefined;

  if(_id_1F4CF79F66927511.dirty)
    vehicle_interact_cleanpoint(vehicle, _id_015FCF7D846A9D9A);

  return _id_1F4CF79F66927511.disabled;
}

vehicle_interact_pointavailableseat(vehicle, _id_015FCF7D846A9D9A) {
  _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, undefined, 1);

  if(!isDefined(_id_1F4CF79F66927511))
    return undefined;

  if(_id_1F4CF79F66927511.dirty)
    vehicle_interact_cleanpoint(vehicle, _id_015FCF7D846A9D9A);

  return _id_1F4CF79F66927511.availableseatid;
}

vehicle_interact_setpointdirty(vehicle, _id_015FCF7D846A9D9A) {
  _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, undefined, 1);

  if(!isDefined(_id_1F4CF79F66927511)) {
    return;
  }
  _id_1F4CF79F66927511.dirty = 1;
}

vehicle_interact_setpointsdirty(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  foreach(pointdata in _id_72141EAB56FB408F.pointdata)
  pointdata.dirty = 1;

  _id_72141EAB56FB408F.dirty = 1;
}

vehicle_interact_cleanpoint(vehicle, _id_015FCF7D846A9D9A) {
  _id_1F4CF79F66927511 = vehicle_interact_getinstancedataforpoint(vehicle, _id_015FCF7D846A9D9A, undefined, 1);

  if(!isDefined(_id_1F4CF79F66927511)) {
    return;
  }
  _id_CF0F83CC6E448DEB("cleanInstance", _id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle);
  _id_1F4CF79F66927511.dirty = 0;
}

vehicle_interact_makeusable(vehicle) {
  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_6BE1425A9EA8586D)) {
    return;
  }
  vehicle_interact_updateusability(vehicle);
}

vehicle_interact_makeunusable(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_6BE1425A9EA8586D)) {
    return;
  }
  _id_70533A0A3679476B = getarraykeys(_id_72141EAB56FB408F.pointdata);

  foreach(_id_015FCF7D846A9D9A in _id_70533A0A3679476B)
  vehicle setscriptablepartstate(_id_015FCF7D846A9D9A, "vehicle_unusable");
}

vehicle_interact_updateusability(vehicle) {
  _id_72141EAB56FB408F = vehicle_interact_getinstancedataforvehicle(vehicle, undefined, 1);

  if(!isDefined(_id_72141EAB56FB408F)) {
    return;
  }
  if(istrue(vehicle_interact_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_6BE1425A9EA8586D)) {
    return;
  }
  if(_id_72141EAB56FB408F.dirty)
    vehicle_interact_cleanvehicle(vehicle);

  if(_id_72141EAB56FB408F.disabled) {
    vehicle_interact_makeunusable(vehicle);
    return;
  }

  foreach(_id_015FCF7D846A9D9A, pointdata in _id_72141EAB56FB408F.pointdata) {
    if(pointdata.dirty)
      vehicle_interact_cleanpoint(vehicle, _id_015FCF7D846A9D9A);

    if(pointdata.disabled) {
      vehicle setscriptablepartstate(_id_015FCF7D846A9D9A, "vehicle_unusable");
      continue;
    }

    vehicle setscriptablepartstate(_id_015FCF7D846A9D9A, "vehicle_use");
  }
}

_id_F1F336C41F281C07(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, player) {
  seatid = _id_1F4CF79F66927511.availableseatid;

  if(seatid != "driver" && seatid != "gunner")
    seatid = _id_91B9E7FB0F262529(player, vehicle, seatid);

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, seatid, player);
}

_id_91B9E7FB0F262529(player, vehicle, _id_812C17D89F729506) {
  _id_E813FA37F0C5A3C1 = _id_812C17D89F729506;
  _id_E9B865F84C8EAA6B = undefined;

  foreach(seatid, seatdata in scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).occupancy.seatdata) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(vehicle, seatid) && isDefined(seatdata.animtag)) {
      _id_50F1AC2AFF931B50 = distancesquared(player.origin, vehicle gettagorigin(seatdata.animtag));

      if(!isDefined(_id_E9B865F84C8EAA6B) || _id_50F1AC2AFF931B50 < _id_E9B865F84C8EAA6B) {
        _id_E813FA37F0C5A3C1 = seatid;
        _id_E9B865F84C8EAA6B = _id_50F1AC2AFF931B50;
      }
    }
  }

  return _id_E813FA37F0C5A3C1;
}

_id_CD93C6E46BC00381(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, _id_E01D015FC5C02677) {
  _id_9D0537BE150542B3 = _id_1F4CF79F66927511._id_9D0537BE150542B3;
  availableseatid = undefined;

  foreach(seatid in _id_9D0537BE150542B3) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(vehicle, seatid)) {
      availableseatid = seatid;
      break;
    }
  }

  _id_1F4CF79F66927511.disabled = !isDefined(availableseatid);
  _id_1F4CF79F66927511.availableseatid = availableseatid;
}

_id_39C1F2552DCFD9B0(_id_015FCF7D846A9D9A, _id_9D0537BE150542B3, _id_E2818AD39A3341B4, _id_5721B85EA5381B5D) {
  _id_E2818AD39A3341B4._id_9D0537BE150542B3 = _id_9D0537BE150542B3;
}

_id_C9601FED18D5B11E(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, _id_5721B85EA5381B5D) {
  _id_E2818AD39A3341B4 = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  _id_1F4CF79F66927511.availableseatid = undefined;
  _id_1F4CF79F66927511._id_9D0537BE150542B3 = _id_E2818AD39A3341B4._id_9D0537BE150542B3;
}

_id_E1F37F2BD447AB19(vehicle, player) {
  if(isDefined(vehicle)) {
    if(!isDefined(vehicle._id_9AEB5660C6DF86E1))
      vehicle._id_9AEB5660C6DF86E1 = [];

    vehicle._id_9AEB5660C6DF86E1 = scripts\engine\utility::array_add(vehicle._id_9AEB5660C6DF86E1, player);
  }
}

_id_FED77CD5C54EFE19(vehicle, player) {
  if(isDefined(vehicle) && isDefined(vehicle._id_9AEB5660C6DF86E1))
    vehicle._id_9AEB5660C6DF86E1 = scripts\engine\utility::array_remove(vehicle._id_9AEB5660C6DF86E1, player);
}

_id_2B58C6EEAEA42C35(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_upgrade", "init")) {
    if(!isDefined(level.br_pe_data)) {
      player iprintlnbold("BR Kiosk station is not activated in this game mode");
      return;
    }

    [[_id_1F4CF79F66927511._id_4DC9E517025A78B6]](vehicle, player);
    player setclientomnvar("ui_buystation_override", _id_1F4CF79F66927511._id_0420BBDE8D99EC0A);
    player._id_E5B7A6A0EC2B440E = 1;
    player._id_C77002478CDFD85F = vehicle;
    _id_E1F37F2BD447AB19(vehicle, player);
    _id_08CE0CDDAAD539B3 = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_upgrade", "init");
    _id_15B89FF206500554 = _id_D9750CBA41DE6A13(vehicle, _id_015FCF7D846A9D9A);
    player thread[[_id_08CE0CDDAAD539B3]](_id_15B89FF206500554);
  }
}

_id_D2B057155910001B(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, _id_E01D015FC5C02677) {
  _id_1F4CF79F66927511.disabled = 0;
}

_id_2BC48C2BCC22A4FE(_id_015FCF7D846A9D9A, _id_1226C93AD199F9F1, _id_E2818AD39A3341B4, _id_5721B85EA5381B5D) {
  if(!isDefined(_id_E2818AD39A3341B4._id_EE340F5CD8FF86A6))
    _id_E2818AD39A3341B4._id_EE340F5CD8FF86A6 = [];

  if(!isDefined(_id_E2818AD39A3341B4._id_CCA5FC4158FD7CEB))
    _id_E2818AD39A3341B4._id_CCA5FC4158FD7CEB = [];

  if(!isDefined(_id_E2818AD39A3341B4._id_4DC9E517025A78B6))
    _id_E2818AD39A3341B4._id_4DC9E517025A78B6 = [];

  _id_E2818AD39A3341B4._id_EE340F5CD8FF86A6[_id_015FCF7D846A9D9A] = _id_1226C93AD199F9F1[0];
  _id_E2818AD39A3341B4._id_CCA5FC4158FD7CEB[_id_015FCF7D846A9D9A] = _id_1226C93AD199F9F1[1];
  _id_E2818AD39A3341B4._id_4DC9E517025A78B6[_id_015FCF7D846A9D9A] = _id_1226C93AD199F9F1[2];
}

_id_BD192331E198BE64(_id_015FCF7D846A9D9A, _id_1F4CF79F66927511, vehicle, _id_5721B85EA5381B5D) {
  _id_E2818AD39A3341B4 = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  _id_1F4CF79F66927511._id_0420BBDE8D99EC0A = _id_E2818AD39A3341B4._id_CCA5FC4158FD7CEB[_id_015FCF7D846A9D9A];
  _id_1F4CF79F66927511._id_4DC9E517025A78B6 = _id_E2818AD39A3341B4._id_4DC9E517025A78B6[_id_015FCF7D846A9D9A];
  _id_D9F0E1B450F12BBC = _id_E2818AD39A3341B4._id_EE340F5CD8FF86A6[_id_015FCF7D846A9D9A];
  _id_16AB0DCEFAA4C681(vehicle, _id_015FCF7D846A9D9A, _id_D9F0E1B450F12BBC);
}

_id_D9750CBA41DE6A13(vehicle, _id_47187249FC261259) {
  return vehicle._id_62F37D3CD23E2D82[_id_47187249FC261259];
}

_id_16AB0DCEFAA4C681(vehicle, _id_47187249FC261259, _id_D9F0E1B450F12BBC) {
  if(!isDefined(vehicle._id_62F37D3CD23E2D82))
    vehicle._id_62F37D3CD23E2D82 = [];

  _id_15B89FF206500554 = spawnStruct();
  _id_15B89FF206500554 thread _id_12D9B5736427FA79(vehicle, _id_D9F0E1B450F12BBC);
  vehicle._id_62F37D3CD23E2D82[_id_47187249FC261259] = _id_15B89FF206500554;
}

_id_12D9B5736427FA79(vehicle, _id_D9F0E1B450F12BBC) {
  vehicle endon("death");

  for(;;) {
    self.origin = vehicle gettagorigin(_id_D9F0E1B450F12BBC);
    wait 0.5;
  }
}

_id_C4B9D8E33849435E(vehicle, _id_5473A133B9D77893, player) {
  if(!isDefined(vehicle._id_00DF77EACC566F76))
    vehicle._id_00DF77EACC566F76 = [];

  vehicle._id_00DF77EACC566F76[_id_5473A133B9D77893] = 1;
  vehicle notify("give_upgrade", _id_5473A133B9D77893, player);
}

_id_97C32F66EFF29610(vehicle, _id_5473A133B9D77893) {
  return isDefined(vehicle._id_00DF77EACC566F76) && istrue(vehicle._id_00DF77EACC566F76[_id_5473A133B9D77893]);
}

_id_A717A31AE35BA01C() {
  return getdvarint("scr_vehicle_enable_fuel", 0) == 1;
}

_id_F588087BF9D7FEFB() {
  level endon("game_ended");
  waitframe();

  if(!_id_A717A31AE35BA01C()) {
    return;
  }
  _id_354F6E3EEBCE5123 = [];

  if(getdvarint("dvar_860E5AB07780813B", 0) && getdvarint("scr_ssc_enabled", 0)) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("gas_station", ::_id_B062B902747A499E);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("gas_station", ::_id_23960BADDC5086ED);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("gas_station", ::_id_A15A2F4B7FDCE1DB);
  } else {
    _id_8E0D7EB61F44D9D6 = _id_B062B902747A499E();

    foreach(_id_C75620CA74D2E522 in _id_8E0D7EB61F44D9D6) {
      scriptable = _id_23960BADDC5086ED(_id_C75620CA74D2E522);
      _id_354F6E3EEBCE5123[_id_354F6E3EEBCE5123.size] = scriptable;
    }
  }

  if(getdvarint("dvar_EF297C4E7D138CF2", 0) && getdvarint("scr_ssc_enabled", 0)) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("gas_station_marine", ::_id_ED8BF724B6FC2DBC);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("gas_station_marine", ::_id_3B6A430C4C8B247B);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("gas_station_marine", ::_id_256C23777C4515A5);
  } else {
    _id_857DAE96CE3D7EE4 = _id_ED8BF724B6FC2DBC();

    foreach(_id_C75620CA74D2E522 in _id_857DAE96CE3D7EE4) {
      scriptable = _id_3B6A430C4C8B247B(_id_C75620CA74D2E522);
      _id_354F6E3EEBCE5123[_id_354F6E3EEBCE5123.size] = scriptable;
    }
  }

  if(getdvarint("dvar_CA04580F9121BD8E", 0) && getdvarint("scr_ssc_enabled", 0)) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("gas_station_charger", ::_id_C43B3F146F9FE964);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("gas_station_charger", ::_id_17664B81EBF6E309);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("gas_station_charger", ::_id_2F06B20C6C272EA7);
  } else {
    _id_4C1814A099E0C43C = _id_C43B3F146F9FE964();

    foreach(_id_C75620CA74D2E522 in _id_4C1814A099E0C43C) {
      struct = _id_17664B81EBF6E309(_id_C75620CA74D2E522);
      _id_354F6E3EEBCE5123[_id_354F6E3EEBCE5123.size] = struct;
    }
  }

  _id_6C429E1C6F5142ED(_id_354F6E3EEBCE5123);
  level._id_354F6E3EEBCE5123 = _id_354F6E3EEBCE5123;
  level._id_30437143FFCDC44E = undefined;
  level._id_0180FA656436C46C = undefined;
  level._id_5C7ECD97DC20E414 = undefined;
}

_id_6C429E1C6F5142ED(_id_30437143FFCDC44E) {
  if(!isDefined(_id_30437143FFCDC44E)) {
    return;
  }
  _id_ECE1CE8D6ABCD4AE = [];

  foreach(_id_C75620CA74D2E522 in _id_30437143FFCDC44E) {
    if(!isDefined(_id_C75620CA74D2E522._id_F3BC44571C85D5E1)) {
      _id_ECE1CE8D6ABCD4AE[_id_ECE1CE8D6ABCD4AE.size] = _id_C75620CA74D2E522;
      continue;
    }

    triggers = _func_F159C10D5CF8F0B4(_id_C75620CA74D2E522._id_F3BC44571C85D5E1, "targetname");
    _id_C75620CA74D2E522._id_F3BC44571C85D5E1 = undefined;

    if(!isDefined(triggers) || triggers.size == 0) {
      _id_ECE1CE8D6ABCD4AE[_id_ECE1CE8D6ABCD4AE.size] = _id_C75620CA74D2E522;
      continue;
    }

    if(triggers.size == 1)
      _id_C75620CA74D2E522.trigger = triggers[0];
    else
      _id_C75620CA74D2E522.trigger = sortbydistance(triggers, _id_C75620CA74D2E522.origin)[0];

    _id_C75620CA74D2E522 thread _id_8C5BE15142453A9B();
  }

  foreach(_id_C75620CA74D2E522 in _id_ECE1CE8D6ABCD4AE) {
    radius = int(sqrt(_id_C75620CA74D2E522._id_8FA87D2C8780E014));
    _id_C75620CA74D2E522.trigger = spawn("noent_volume_trigger_radius", _id_C75620CA74D2E522.origin - (0, 0, 200), 0, radius, 1000);
    _id_C75620CA74D2E522 thread _id_8C5BE15142453A9B();
  }
}

_id_8C5BE15142453A9B() {
  for(;;) {
    self.trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.vehicle))
      vehicle = ent.vehicle;
    else
      vehicle = ent;

    if(!isDefined(vehicle) || !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() || !isDefined(vehicle.origin)) {
      continue;
    }
    if(!isDefined(vehicle._id_CF9BA498AF4E41E9)) {
      continue;
    }
    if(isDefined(vehicle._id_90C69F8BA6618910)) {
      continue;
    }
    if(istrue(self._id_6234172895D0C06F) && vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() != "veh9_hummer") {
      continue;
    }
    if(distance2dsquared(vehicle.origin, self.origin) > self._id_8FA87D2C8780E014) {
      continue;
    }
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
    thread _id_518F884FC150D957(vehicle, self.origin, self._id_8FA87D2C8780E014, driver);
  }
}

_id_52BA5A6617B2C059(origin, radius, scriptablename) {
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("poi", "isSystemActive") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("poi", "isSystemActive")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("poi", "isInActivePOI") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("poi", "isInActivePOI")]](origin)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isPointWithinInitialDangerCircle") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isPointWithinInitialDangerCircle")]](origin)) {
    return;
  }
  if(isDefined(scriptablename)) {
    if(istrue(level._id_0A9CCAF325F3A76D)) {
      _id_C75620CA74D2E522 = spawn("script_model", origin);
      _id_C75620CA74D2E522 setModel(scriptablename);
    } else
      _id_C75620CA74D2E522 = spawnscriptable(scriptablename, origin);
  } else {
    _id_C75620CA74D2E522 = spawnStruct();
    _id_C75620CA74D2E522.origin = origin;
  }

  _id_C75620CA74D2E522._id_8FA87D2C8780E014 = radius * radius;
  _id_C75620CA74D2E522._id_F3F4EB55AED6E784 = origin[2] - 200;
  _id_C75620CA74D2E522.maxheight = origin[2] + 1000 - 200;
  _id_C75620CA74D2E522._id_F49FED751E517601 = gettime();
  return _id_C75620CA74D2E522;
}

_id_B062B902747A499E() {
  if(!_id_A717A31AE35BA01C()) {
    return;
  }
  _id_8E0D7EB61F44D9D6 = scripts\engine\utility::getStructArray("gas_station", "targetname");
  return _id_8E0D7EB61F44D9D6;
}

_id_ED8BF724B6FC2DBC() {
  if(!_id_A717A31AE35BA01C()) {
    return;
  }
  _id_857DAE96CE3D7EE4 = scripts\engine\utility::getStructArray("gas_station_marine", "targetname");
  return _id_857DAE96CE3D7EE4;
}

_id_C43B3F146F9FE964() {
  if(!_id_A717A31AE35BA01C()) {
    return;
  }
  _id_4C1814A099E0C43C = scripts\engine\utility::getStructArray("charging_station", "targetname");
  return _id_4C1814A099E0C43C;
}

_id_23960BADDC5086ED(_id_6B0D97276985D147) {
  radius = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(_id_6B0D97276985D147.script_noteworthy, "large"), 600.0, 400);
  scriptable = _id_52BA5A6617B2C059(_id_6B0D97276985D147.origin, radius, "dmz_gas_station");

  if(isDefined(scriptable)) {
    scriptable._id_F3BC44571C85D5E1 = _id_6B0D97276985D147.target;

    if(!isDefined(level._id_30437143FFCDC44E))
      level._id_30437143FFCDC44E = [];

    level._id_30437143FFCDC44E[level._id_30437143FFCDC44E.size] = scriptable;
  }

  return scriptable;
}

_id_3B6A430C4C8B247B(_id_6B0D97276985D147) {
  scriptable = _id_52BA5A6617B2C059(_id_6B0D97276985D147.origin, 650, "dmz_gas_station_marine");

  if(isDefined(scriptable)) {
    scriptable._id_F3BC44571C85D5E1 = _id_6B0D97276985D147.target;

    if(!isDefined(level._id_0180FA656436C46C))
      level._id_0180FA656436C46C = [];

    level._id_0180FA656436C46C[level._id_0180FA656436C46C.size] = scriptable;
  }

  return scriptable;
}

_id_17664B81EBF6E309(_id_6B0D97276985D147) {
  radius = 400;

  if(isDefined(_id_6B0D97276985D147.script_noteworthy))
    radius = float(_id_6B0D97276985D147.script_noteworthy);

  struct = _id_52BA5A6617B2C059(_id_6B0D97276985D147.origin, radius);

  if(isDefined(struct)) {
    struct._id_6234172895D0C06F = 1;
    struct._id_F3BC44571C85D5E1 = _id_6B0D97276985D147.target;

    if(!isDefined(level._id_5C7ECD97DC20E414))
      level._id_5C7ECD97DC20E414 = [];

    level._id_5C7ECD97DC20E414[level._id_5C7ECD97DC20E414.size] = struct;
  }

  return struct;
}

_id_A15A2F4B7FDCE1DB() {
  _id_6C429E1C6F5142ED(level._id_30437143FFCDC44E);

  if(!isDefined(level._id_354F6E3EEBCE5123))
    level._id_354F6E3EEBCE5123 = [];

  level._id_354F6E3EEBCE5123 = scripts\engine\utility::array_combine(level._id_354F6E3EEBCE5123, level._id_30437143FFCDC44E);
  level._id_30437143FFCDC44E = undefined;
}

_id_256C23777C4515A5() {
  _id_6C429E1C6F5142ED(level._id_0180FA656436C46C);

  if(!isDefined(level._id_354F6E3EEBCE5123))
    level._id_354F6E3EEBCE5123 = [];

  level._id_354F6E3EEBCE5123 = scripts\engine\utility::array_combine(level._id_354F6E3EEBCE5123, level._id_0180FA656436C46C);
  level._id_0180FA656436C46C = undefined;
}

_id_2F06B20C6C272EA7() {
  _id_6C429E1C6F5142ED(level._id_5C7ECD97DC20E414);

  if(!isDefined(level._id_354F6E3EEBCE5123))
    level._id_354F6E3EEBCE5123 = [];

  level._id_354F6E3EEBCE5123 = scripts\engine\utility::array_combine(level._id_354F6E3EEBCE5123, level._id_5C7ECD97DC20E414);
  level._id_5C7ECD97DC20E414 = undefined;
}

_id_518F884FC150D957(vehicle, point, _id_8FA87D2C8780E014, driver) {
  level endon("game_ended");
  currenttime = gettime();

  if(currenttime - 4000 > self._id_F49FED751E517601) {
    _id_D88CCAA59CB99BE0 = "veh_fuel_gas_station_service_bell";

    if(istrue(self._id_6234172895D0C06F))
      _id_D88CCAA59CB99BE0 = "veh_fuel_ev_station_service_bell_enter";

    playsoundatpos(self.origin, _id_D88CCAA59CB99BE0);
    self._id_F49FED751E517601 = currenttime;
  }

  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_B7898AEE43BB07EF = vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_29F1EA79ED2B40DD = _id_B7898AEE43BB07EF._id_29F1EA79ED2B40DD;
  _id_4E86F19790F68BB3 = istrue(self._id_6234172895D0C06F);
  vehicle._id_90C69F8BA6618910 = vehicle _id_883613626149EBF8(_id_29F1EA79ED2B40DD, _id_4E86F19790F68BB3);
  vehicle._id_7851AEBDD0A34B09 = _id_4E86F19790F68BB3;
  team = vehicle.team;
  wait 1;

  if(!isDefined(vehicle) || !isDefined(vehicle.origin) || !isDefined(vehicle.maxhealth)) {
    if(isDefined(vehicle)) {
      vehicle._id_90C69F8BA6618910 = undefined;
      vehicle._id_7851AEBDD0A34B09 = undefined;
    }

    return;
  }

  if(distancesquared(vehicle.origin, point) >= _id_8FA87D2C8780E014 * 2.25) {
    vehicle._id_90C69F8BA6618910 = undefined;
    vehicle._id_7851AEBDD0A34B09 = undefined;
    return;
  }

  _id_CFB86C8EC12B2D6C = scripts\engine\utility::_id_53C4C53197386572(_id_B7898AEE43BB07EF._id_23F37E83B1CAFB10, 30);
  _id_A1153D5FC785FBE1 = _id_29F1EA79ED2B40DD / _id_CFB86C8EC12B2D6C * 0.25;
  _id_63EEC8CC9E4260E4 = vehicle.maxhealth / _id_CFB86C8EC12B2D6C * 0.25;
  objidnum = undefined;
  _id_22754A38D66516EC = gettime() + 2000;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    vehicle.curorigin = (0, 0, 0);
    vehicle.offset3d = (0, 0, 0);
    vehicle.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
    objidnum = vehicle.objidnum;
  }

  if(isDefined(objidnum) && objidnum != -1) {
    objective_delete(objidnum);
    objective_state(objidnum, "current");
    objective_setshowoncompass(objidnum, 1);
    objective_setplayintro(objidnum, 0);
    objective_setplayoutro(objidnum, 0);
    objective_setbackground(objidnum, 1);
    icon = scripts\engine\utility::ter_op(_id_7731ADEF63E19B0C == "veh9_hummer", "ddos_emp_bolt", "ui_map_icon_gas_refuel");
    objective_icon(objidnum, icon);
    objective_onentity(objidnum, vehicle);
    objective_setzoffset(objidnum, 75);
    objective_setshowprogress(objidnum, 1);
    objective_removeallfrommask(objidnum);
    objective_showtoplayersinmask(objidnum);
  }

  _id_3F95B7AC8E6598BF = 0;
  vehicle._id_90C69F8BA6618910 = vehicle _id_883613626149EBF8(_id_29F1EA79ED2B40DD, _id_4E86F19790F68BB3);

  if(vehicle._id_90C69F8BA6618910 < 0.99) {
    _id_3F95B7AC8E6598BF = 1;

    foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
    vehicle _id_3BFF37824A58EF7A(_id_F85572CD5F6117C6, objidnum, _id_7731ADEF63E19B0C);
  }

  if(vehicle.health < vehicle.maxhealth && vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate() != "heavy")
    playsoundatpos(vehicle.origin, "veh_repair_health");

  if(istrue(level._id_5431E3914CFC0E23)) {
    _id_04FDF99C19DE6454 = 1;
    _id_04FDF99C19DE6454 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](team);

    if(!istrue(self._id_6234172895D0C06F) && _id_04FDF99C19DE6454) {
      self setscriptablepartstate(self _meth_EC5F4851431F3382(), "occupied");
      self _meth_FCA5BDBE24070D20(self _meth_EC5F4851431F3382(), team);

      if(!isDefined(self._id_F0BE68AB550CB2E6))
        self._id_F0BE68AB550CB2E6 = [];

      self._id_F0BE68AB550CB2E6[self._id_F0BE68AB550CB2E6.size] = team;
    }
  }

  while(isDefined(vehicle) && isDefined(vehicle.origin) && distancesquared(vehicle.origin, point) < _id_8FA87D2C8780E014 * 2.25) {
    if(!vehicle _id_FC271F387096702F()) {
      vehicle._id_90C69F8BA6618910 = vehicle _id_883613626149EBF8(_id_29F1EA79ED2B40DD, _id_4E86F19790F68BB3);

      if(isDefined(objidnum) && objidnum != -1)
        objective_setprogress(objidnum, vehicle._id_90C69F8BA6618910);

      if(!_id_3F95B7AC8E6598BF && vehicle._id_90C69F8BA6618910 < 0.99) {
        _id_3F95B7AC8E6598BF = 1;

        foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
        vehicle _id_3BFF37824A58EF7A(_id_F85572CD5F6117C6, objidnum, _id_7731ADEF63E19B0C);
      }

      wait 0.25;
      continue;
    }

    vehicle._id_CF9BA498AF4E41E9 = min(_id_29F1EA79ED2B40DD, vehicle._id_CF9BA498AF4E41E9 + _id_A1153D5FC785FBE1);
    vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::_id_9DA76B0BE4B2A2D4(vehicle._id_CF9BA498AF4E41E9, _id_29F1EA79ED2B40DD);

    if(!_id_4E86F19790F68BB3) {
      if(vehicle.health < vehicle.maxhealth && vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate() != "heavy")
        vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_653B96CE8310763E(_id_63EEC8CC9E4260E4);
    }

    vehicle._id_90C69F8BA6618910 = vehicle _id_883613626149EBF8(_id_29F1EA79ED2B40DD, _id_4E86F19790F68BB3);

    if(isDefined(objidnum) && objidnum != -1)
      objective_setprogress(objidnum, vehicle._id_90C69F8BA6618910);

    if(_id_3F95B7AC8E6598BF && vehicle._id_90C69F8BA6618910 >= 0.99) {
      _id_3F95B7AC8E6598BF = 0;

      foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
      vehicle _id_D051E5F825B704AB(_id_F85572CD5F6117C6, objidnum, _id_7731ADEF63E19B0C, 1);
    }

    if(!_id_4E86F19790F68BB3) {
      if(gettime() > _id_22754A38D66516EC) {
        _id_22754A38D66516EC = gettime() + 2000;

        if(isDefined(vehicle._id_F2B4D0E8470F108B))
          scripts\cp_mp\vehicles\vehicle_damage::_id_E6F68A61BFFC259A(vehicle);
        else
          scripts\cp_mp\vehicles\vehicle_damage::_id_9B27177AD97BB8D8(vehicle);
      }

      if(abs(vehicle._id_CF9BA498AF4E41E9 - _id_29F1EA79ED2B40DD) < 1 && vehicle.health == vehicle.maxhealth && (!isDefined(vehicle._id_C48B10763F1DF79A) || vehicle._id_C48B10763F1DF79A.size == 0)) {
        scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onVehicleFullRefuelAndRepair", vehicle, self);

        if(!isDefined(self._id_D7889CE958977349))
          self._id_D7889CE958977349 = [];

        if(isDefined(vehicle.owner) && !scripts\engine\utility::array_contains(self._id_D7889CE958977349, vehicle)) {
          vehicle.owner scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(vehicle, "gas_station_refuel");
          self._id_D7889CE958977349[self._id_D7889CE958977349.size] = vehicle;
        }
      }
    }

    wait 0.25;
  }

  if(_id_3F95B7AC8E6598BF && isDefined(vehicle) && isDefined(vehicle.occupants)) {
    foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
    vehicle _id_D051E5F825B704AB(_id_F85572CD5F6117C6, objidnum, _id_7731ADEF63E19B0C, 1);
  }

  if(isDefined(objidnum) && objidnum != -1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](objidnum);

    if(isDefined(vehicle))
      vehicle.objidnum = undefined;
  }

  if(isDefined(vehicle)) {
    vehicle._id_90C69F8BA6618910 = undefined;
    vehicle._id_7851AEBDD0A34B09 = undefined;
  }

  if(istrue(level._id_5431E3914CFC0E23)) {
    _id_04FDF99C19DE6454 = 1;
    _id_04FDF99C19DE6454 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](team);

    if(!istrue(self._id_6234172895D0C06F) && _id_04FDF99C19DE6454) {
      self._id_F0BE68AB550CB2E6 = scripts\engine\utility::_id_57091B2D67654A14(self._id_F0BE68AB550CB2E6, team);

      if(self._id_F0BE68AB550CB2E6.size == 0)
        self setscriptablepartstate(self _meth_EC5F4851431F3382(), "idle");
      else {
        _id_04FDF99C19DE6454 = 1;
        _id_04FDF99C19DE6454 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](self._id_F0BE68AB550CB2E6[0]);

        if(_id_04FDF99C19DE6454)
          self _meth_FCA5BDBE24070D20(self _meth_EC5F4851431F3382(), self._id_F0BE68AB550CB2E6[0]);
      }
    }
  }
}

_id_FC271F387096702F() {
  return !isDefined(self.lasttimedamaged) || gettime() - self.lasttimedamaged >= 5000;
}

_id_883613626149EBF8(_id_29F1EA79ED2B40DD, _id_4E86F19790F68BB3) {
  if(_id_4E86F19790F68BB3)
    return self._id_CF9BA498AF4E41E9 / _id_29F1EA79ED2B40DD;
  else
    return 0.5 * self._id_CF9BA498AF4E41E9 / _id_29F1EA79ED2B40DD + 0.5 * self.health / self.maxhealth;
}

_id_C5FE005F06FE5684(vehicle, player) {
  if(isDefined(vehicle._id_90C69F8BA6618910) && vehicle._id_90C69F8BA6618910 < 0.99)
    vehicle _id_3BFF37824A58EF7A(player, vehicle.objidnum, vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
}

_id_DEB83798A724A77E(vehicle, player) {
  if(isDefined(vehicle._id_90C69F8BA6618910) && vehicle._id_90C69F8BA6618910 < 0.99)
    vehicle _id_D051E5F825B704AB(player, vehicle.objidnum, vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
}

_id_3BFF37824A58EF7A(player, objidnum, _id_7731ADEF63E19B0C) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_addclienttomask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_pinforclient(objidnum, player);
    _func_D1B64C3D055CEEB0(2, player);
    _id_E9168D98351236D7 = &"MP/REFUELING";

    if(_id_7731ADEF63E19B0C == "veh9_hummer")
      _id_E9168D98351236D7 = scripts\engine\utility::ter_op(istrue(self._id_7851AEBDD0A34B09), &"MP/CHARGING_FUEL_ONLY", &"MP/CHARGING");

    _func_8B71EB96E1636EDC(_id_E9168D98351236D7, player);
    _id_82A1C76DA877F6A3(player, _id_7731ADEF63E19B0C);
  }
}

_id_D051E5F825B704AB(player, objidnum, _id_7731ADEF63E19B0C, success) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_removeclientfrommask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_unpinforclient(objidnum, player);
    _func_D1B64C3D055CEEB0(0, player);
    _id_BD48158D51404989(player, _id_7731ADEF63E19B0C, success);
  }
}

_id_82A1C76DA877F6A3(player, _id_7731ADEF63E19B0C) {
  if(isDefined(player)) {
    _id_A3C271BD60EC612F = scripts\engine\utility::ter_op(_id_7731ADEF63E19B0C == "veh9_hummer", "uin_veh_fuel_ev_charger", "uin_veh_fuel_gas_ticker");
    player playlocalsound(_id_A3C271BD60EC612F);
  }
}

_id_BD48158D51404989(player, _id_7731ADEF63E19B0C, success) {
  if(isDefined(player)) {
    _id_A3C271BD60EC612F = "uin_veh_fuel_gas_ticker";
    _id_2D2BBCCA8984C48F = "uin_veh_fuel_gas_ticker_stop";

    if(_id_7731ADEF63E19B0C == "veh9_hummer") {
      _id_A3C271BD60EC612F = "uin_veh_fuel_ev_charger";
      _id_2D2BBCCA8984C48F = "uin_veh_fuel_ev_charger_stop";
    }

    player stoplocalsound(_id_A3C271BD60EC612F);

    if(istrue(success))
      player playlocalsound(_id_2D2BBCCA8984C48F);
  }
}

_id_A203F8033EEB57F1(_id_7731ADEF63E19B0C, vehicle) {
  if(!vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2() && _id_A717A31AE35BA01C() && !istrue(vehicle.isfromkillstreak)) {
    vehicle._id_CF9BA498AF4E41E9 = _id_F02703F19A787F77(_id_7731ADEF63E19B0C);
    vehicle thread _id_722B030261C05941(_id_7731ADEF63E19B0C);
  }
}

_id_F02703F19A787F77(_id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(_id_E2818AD39A3341B4._id_4C6D695D0920DF19 >= _id_E2818AD39A3341B4._id_4C4A7B5D08FABEF7)
    return _id_E2818AD39A3341B4._id_4C6D695D0920DF19;

  return randomfloatrange(_id_E2818AD39A3341B4._id_4C6D695D0920DF19, _id_E2818AD39A3341B4._id_4C4A7B5D08FABEF7);
}

_id_722B030261C05941(_id_7731ADEF63E19B0C) {
  self endon("death");
  level endon("game_ended");
  _id_29F1EA79ED2B40DD = vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C)._id_29F1EA79ED2B40DD;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showfuel(occupants);
  scripts\cp_mp\utility\vehicle_omnvar_utility::_id_9DA76B0BE4B2A2D4(self._id_CF9BA498AF4E41E9, _id_29F1EA79ED2B40DD);
  _id_F2478A60DDDE9FAB = self vehicle_gettopspeedforward();
  _id_5639B8EEC4682DF5 = 0;
  _id_A6C30B623DFA92DE = 0;
  _id_94D4410A7169A784 = "uin_veh_warning_low_fuel";
  _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel";

  if(istrue(scripts\common\vehicle::ishelicopter())) {
    _id_94D4410A7169A784 = "uin_veh_warning_low_fuel_heli";
    _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel_heli";
  }

  for(;;) {
    wait 1;

    if(istrue(self.ishovering) || !istrue(self.isempty) && isPlayer(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self))) {
      _id_15F8441922036C46 = min(scripts\engine\utility::ter_op(scripts\common\vehicle::ishelicopter(), 1.0, self vehicle_getspeed() / _id_F2478A60DDDE9FAB), 1.0);
      _id_BE4F52293AADB963 = _id_15F8441922036C46 * scripts\engine\utility::_id_53C4C53197386572(self._id_580DB2147190028A, 1.0);
      self._id_CF9BA498AF4E41E9 = max(self._id_CF9BA498AF4E41E9 - _id_BE4F52293AADB963, 0);
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_9DA76B0BE4B2A2D4(self._id_CF9BA498AF4E41E9, _id_29F1EA79ED2B40DD);

    if(self._id_CF9BA498AF4E41E9 <= 0 && !_id_A6C30B623DFA92DE) {
      _id_A6C30B623DFA92DE = 1;
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_D0092C44C5588870();
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_EE4B8B879B1B120C();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0, 0);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("outOfFuel", scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self), _id_7731ADEF63E19B0C);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "outOfFuel"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "outOfFuel")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onVehicleOutOfFuel"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onVehicleOutOfFuel")]](scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self));

      _id_5A2B3F3E2CD84EB8(_id_94D4410A7169A784);
      _id_7C7694A53FA6720A(_id_85DFCE1880D8E71D);
    } else if(self._id_CF9BA498AF4E41E9 > 0 && _id_A6C30B623DFA92DE) {
      _id_A6C30B623DFA92DE = 0;
      _id_5A2B3F3E2CD84EB8(_id_85DFCE1880D8E71D);
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_7C81E0D41CBBCE7F();
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_9E710C9F3A15FFDA();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("outOfFuel", scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self), _id_7731ADEF63E19B0C);
    }

    if(self._id_CF9BA498AF4E41E9 <= 25 && self._id_CF9BA498AF4E41E9 > 0 && !_id_5639B8EEC4682DF5) {
      _id_5639B8EEC4682DF5 = 1;
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("lowFuel", scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self), _id_7731ADEF63E19B0C);
      _id_7C7694A53FA6720A(_id_94D4410A7169A784);
      player = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "ftue_triggerTip")) {
        _id_C4DC2501D7D2B68B = undefined;
        _id_47415E4E37E805FF = undefined;

        foreach(_id_C75620CA74D2E522 in level._id_354F6E3EEBCE5123) {
          if(!isDefined(_id_C4DC2501D7D2B68B)) {
            _id_C4DC2501D7D2B68B = _id_C75620CA74D2E522;
            _id_47415E4E37E805FF = distancesquared(self.origin, _id_C75620CA74D2E522.origin);
          }

          _id_50F1AC2AFF931B50 = distancesquared(self.origin, _id_C75620CA74D2E522.origin);

          if(_id_50F1AC2AFF931B50 < _id_47415E4E37E805FF) {
            _id_C4DC2501D7D2B68B = _id_C75620CA74D2E522;
            _id_47415E4E37E805FF = distancesquared(self.origin, _id_C75620CA74D2E522.origin);
          }
        }

        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "ftue_triggerTip")]]("br_ftue_driving", _id_C4DC2501D7D2B68B.origin);
      }

      continue;
    }

    if((self._id_CF9BA498AF4E41E9 > 25 || self._id_CF9BA498AF4E41E9 <= 0) && _id_5639B8EEC4682DF5) {
      _id_5639B8EEC4682DF5 = 0;
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("lowFuel", scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self), _id_7731ADEF63E19B0C);
      _id_5A2B3F3E2CD84EB8(_id_94D4410A7169A784);
    }
  }
}

_id_7C7694A53FA6720A(_id_D479EEED3A4DD9DF) {
  if(soundexists(_id_D479EEED3A4DD9DF)) {
    foreach(_id_F85572CD5F6117C6 in scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self)) {
      _id_F85572CD5F6117C6 stoplocalsound(_id_D479EEED3A4DD9DF);
      _id_F85572CD5F6117C6 playlocalsound(_id_D479EEED3A4DD9DF);
    }
  }
}

_id_5A2B3F3E2CD84EB8(_id_D479EEED3A4DD9DF) {
  if(soundexists(_id_D479EEED3A4DD9DF)) {
    foreach(_id_F85572CD5F6117C6 in scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self))
    _id_F85572CD5F6117C6 stoplocalsound(_id_D479EEED3A4DD9DF);
  }
}

_id_557DA58E3AD8A579(_id_A580BC9CCB88CCB4, _id_62CC4A0ECDE06ECF) {
  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(!isDefined(vehicle) || !isDefined(vehicle._id_CF9BA498AF4E41E9)) {
    if(_id_62CC4A0ECDE06ECF)
      return "MP/CANNOT_USE_GAS_CAN_PALFA";

    return "MP/CANNOT_USE_GAS_CAN";
  }

  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_B7898AEE43BB07EF = vehicle_interact_getleveldataforvehicle(ref);

  if(istrue(level._id_C0E521049F7AE2C9) && !_id_62CC4A0ECDE06ECF && ref == "veh9_palfa")
    return "MP/CANNOT_USE_GAS_CAN_IN_PALFA";

  if(_id_62CC4A0ECDE06ECF && ref != "veh9_palfa")
    return "MP/CANNOT_USE_GAS_CAN_PALFA";

  if(!_id_62CC4A0ECDE06ECF && (!isDefined(_id_A580BC9CCB88CCB4.count) || _id_A580BC9CCB88CCB4.count == 1))
    return "MP/GAS_CAN_IS_EMPTY";

  if(ref == "veh9_hummer")
    return "MP/CANNOT_USE_GAS_CAN_ELECTRIC";

  if(_id_B7898AEE43BB07EF._id_29F1EA79ED2B40DD - vehicle._id_CF9BA498AF4E41E9 < 1)
    return "MP/VEHICLE_FULL_GAS";

  _id_A1153D5FC785FBE1 = _id_A580BC9CCB88CCB4.count - 1;

  if(_id_62CC4A0ECDE06ECF && ref == "veh9_palfa")
    _id_A1153D5FC785FBE1 = 1000;

  if(vehicle._id_CF9BA498AF4E41E9 + _id_A1153D5FC785FBE1 > _id_B7898AEE43BB07EF._id_29F1EA79ED2B40DD)
    _id_A1153D5FC785FBE1 = int(floor(_id_B7898AEE43BB07EF._id_29F1EA79ED2B40DD - vehicle._id_CF9BA498AF4E41E9));

  vehicle._id_CF9BA498AF4E41E9 = min(_id_B7898AEE43BB07EF._id_29F1EA79ED2B40DD, vehicle._id_CF9BA498AF4E41E9 + _id_A1153D5FC785FBE1);

  if(_id_62CC4A0ECDE06ECF)
    _id_A580BC9CCB88CCB4.count = 0;
  else
    _id_A580BC9CCB88CCB4.count = int(clamp(_id_A580BC9CCB88CCB4.count - _id_A1153D5FC785FBE1, 1, 150));

  vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::_id_9DA76B0BE4B2A2D4();
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onGasCanRefuel", vehicle, _id_62CC4A0ECDE06ECF);
  return undefined;
}

_id_CF96FB01F9473D0D(_id_F7658EECC6BCC46B) {
  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(!isDefined(vehicle) || !isDefined(vehicle._id_CF9BA498AF4E41E9))
    return ["MP/CANNOT_USE_GAS_CAN", _id_F7658EECC6BCC46B];

  if(!isDefined(_id_F7658EECC6BCC46B) || _id_F7658EECC6BCC46B == 150)
    return ["MP/GAS_CAN_FULL", _id_F7658EECC6BCC46B];

  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_B7898AEE43BB07EF = vehicle_interact_getleveldataforvehicle(ref);

  if(ref == "veh9_hummer")
    return ["MP/GAS_CAN_SIPHON_ON_EV", _id_F7658EECC6BCC46B];

  _id_8BFFB7A992706B84 = 150 - _id_F7658EECC6BCC46B + 1;

  if(vehicle._id_CF9BA498AF4E41E9 < _id_8BFFB7A992706B84)
    _id_8BFFB7A992706B84 = int(floor(vehicle._id_CF9BA498AF4E41E9));

  vehicle._id_CF9BA498AF4E41E9 = max(0, vehicle._id_CF9BA498AF4E41E9 - _id_8BFFB7A992706B84);
  _id_F7658EECC6BCC46B = int(clamp(_id_F7658EECC6BCC46B + _id_8BFFB7A992706B84 - 1, 1, 150));
  vehicle scripts\cp_mp\utility\vehicle_omnvar_utility::_id_9DA76B0BE4B2A2D4();
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onVehicleSiphoned", vehicle);
  return [undefined, _id_F7658EECC6BCC46B];
}

_id_68CDB3D30284BE07() {
  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2()) {
    return;
  }
  _id_8797136EBD7115CB = vehicle_interact_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(!isDefined(level._id_38CC7FDCF6109AF7))
    level._id_38CC7FDCF6109AF7 = getdvarint("dvar_E42FC7D1E9196CFF", 1) == 1;

  if(!level._id_38CC7FDCF6109AF7 || istrue(self._id_408E9E761C8463C5) || !istrue(self.isempty) || !isDefined(_id_8797136EBD7115CB) || !isDefined(_id_8797136EBD7115CB._id_261258CC3A12AF34) || _id_8797136EBD7115CB._id_261258CC3A12AF34 == "" || !self getscriptablehaspart(_id_8797136EBD7115CB._id_261258CC3A12AF34) || !self getscriptableparthasstate(_id_8797136EBD7115CB._id_261258CC3A12AF34, "on")) {
    return;
  }
  self notify("car_alarm_start");
  self endon("car_alarm_start");
  self endon("death");
  self setscriptablepartstate(_id_8797136EBD7115CB._id_261258CC3A12AF34, "on");
  scripts\stealth\event::event_broadcast_generic("cover_blown", self.origin, 2500, self);
  _id_A6CF8B7A0D3630B5();

  if(self getscriptableparthasstate(_id_8797136EBD7115CB._id_261258CC3A12AF34, "off"))
    self setscriptablepartstate(_id_8797136EBD7115CB._id_261258CC3A12AF34, "off");

  self._id_408E9E761C8463C5 = 1;
}

_id_A6CF8B7A0D3630B5(_id_CC748B6D457627FE) {
  self endon("vehicle_owner_update");
  wait 5;
}

_id_C01316C733E017B7() {
  if(!level._id_49B09BD5297D4967 || istrue(self._id_9D9132209B6BB2E7)) {
    return;
  }
  if(istrue(self._id_6A73F11D95750B87)) {
    return;
  }
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights) || data.interact.lights.size == 0) {
    return;
  }
  _id_A75FFF7173989B4D = _id_5519F4E75A7E2D2B();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "off")
      self setscriptablepartstate(light.tag, "on", 1);
    else if(_id_A75FFF7173989B4D && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "off")
      self setscriptablepartstate(light.tag, "on", 1);

    self._id_6A73F11D95750B87 = 1;
  }
}

_id_49EFF91715AE3C1B() {
  if(!level._id_49B09BD5297D4967 || istrue(self._id_9D9132209B6BB2E7)) {
    return;
  }
  if(!istrue(self._id_6A73F11D95750B87)) {
    return;
  }
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights) || data.interact.lights.size == 0) {
    return;
  }
  _id_A75FFF7173989B4D = _id_5519F4E75A7E2D2B();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
      continue;
    }

    if(_id_A75FFF7173989B4D && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "on")
      self setscriptablepartstate(light.tag, "off", 1);
  }

  self._id_6A73F11D95750B87 = undefined;
}

_id_7394E322C553B3F0() {
  if(!level._id_49B09BD5297D4967 || istrue(self._id_9D9132209B6BB2E7)) {
    return;
  }
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights)) {
    return;
  }
  foreach(light in data.interact.lights) {
    if(light.type == "opening_door")
      self setscriptablepartstate(light.tag, "on", 1);
  }
}

_id_89205F33661AE7A7(_id_B28B6726F299E0D0, _id_715B3BAC241CDB32) {
  _id_8899ECB43445ED50(_id_B28B6726F299E0D0, "on", _id_715B3BAC241CDB32);
}

_id_ACF62F098D0588EB(_id_B28B6726F299E0D0, _id_715B3BAC241CDB32) {
  _id_8899ECB43445ED50(_id_B28B6726F299E0D0, "off", _id_715B3BAC241CDB32);
}

_id_8899ECB43445ED50(_id_B28B6726F299E0D0, state, _id_715B3BAC241CDB32) {
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

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
    if(isDefined(_id_B28B6726F299E0D0) && !isarray(_id_B28B6726F299E0D0) && light.group != _id_B28B6726F299E0D0) {
      continue;
    }
    if(isDefined(_id_B28B6726F299E0D0) && isarray(_id_B28B6726F299E0D0) && !scripts\engine\utility::array_contains(_id_B28B6726F299E0D0, light.tag)) {
      continue;
    }
    if(isDefined(_id_715B3BAC241CDB32) && self getscriptablepartstate(light.tag, _id_715B3BAC241CDB32)) {
      self setscriptablepartstate(light.tag, _id_715B3BAC241CDB32);
      continue;
    }

    self setscriptablepartstate(light.tag, state);
  }
}

_id_420769A30AB48A6B(_id_B28B6726F299E0D0) {
  if(!isDefined(self) || !isDefined(self._id_AAB9695C92B0ED96)) {
    return;
  }
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights)) {
    return;
  }
  foreach(light in data.interact.lights) {
    if(isDefined(_id_B28B6726F299E0D0) && !isarray(_id_B28B6726F299E0D0) && light.group != _id_B28B6726F299E0D0) {
      continue;
    }
    if(isDefined(_id_B28B6726F299E0D0) && isarray(_id_B28B6726F299E0D0) && !scripts\engine\utility::array_contains(_id_B28B6726F299E0D0, light.tag)) {
      continue;
    }
    self._id_AAB9695C92B0ED96[light.tag] = undefined;
  }
}

_id_294A35251526F435() {
  self._id_9D9132209B6BB2E7 = 1;
}

_id_5519F4E75A7E2D2B() {
  switch (level.script) {
    case "mp_ai_firefight":
    case "mp_saba_pm":
    case "mp_veh_unit_night":
    case "mp_lighting_dev_saba_pm":
    case "mp_br_mechanics":
    case "mp_kstenod":
      return 1;
    default:
      return 0;
  }
}

vehicle_interact_initdev() {
  _id_D233EA035E59E2F4 = setdvarifuninitialized("dvar_FB517A5A3D736FA0", 0);
}