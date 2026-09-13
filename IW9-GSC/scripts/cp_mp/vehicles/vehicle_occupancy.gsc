/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_occupancy.gsc
********************************************************/

vehicle_occupancy_getleveldataforvehicle(vehiclename, create) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(vehiclename) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehiclename).occupancy))) {
    data = undefined;

    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(vehiclename))
      data = spawnStruct();
    else
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehiclename);

    data.occupancy = spawnStruct();
    data.occupancy.seatdata = [];
    data.occupancy.restrictions = [];
    data.occupancy.damagemodifier = -1;
    data.occupancy.camera = "none";
    data.occupancy.threatbiasgroup = "Level_Vehicle";
    data.occupancy.exitextents = [];
    data.occupancy.exitoffsets = [];
    data.occupancy.exitdirections = [];
    data.occupancy.damagefeedbackgrouplight = "driver";
    data.occupancy.damagefeedbackgroupheavy = "all";
    level._id_A0B2C978CA57FFC5[vehiclename] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(vehiclename))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehiclename).occupancy;
}

_id_C9B87BEB89EC12E2(player, vehicle, exitvehicle) {
  if(isDefined(player)) {
    if(player _meth_793F941D7DFF15ED())
      player _meth_C0505F05660D120C(0, exitvehicle);
  }
}

vehicle_occupancy_getleveldataforseat(vehiclename, seatid, create) {
  return vehicle_occupancy_getleveldataforvehicle(vehiclename).seatdata[seatid];
}

vehicle_occupancy_registerinstance(vehicle) {
  vehicle.occupants = [];
  vehicle.occupantsreserving = [];
  vehicle.isempty = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerInstance"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerInstance")]](vehicle);
}

vehicle_occupancy_deregisterinstance(vehicle) {
  vehicle.occupants = undefined;
  vehicle.occupantsreserving = undefined;
  vehicle.isempty = undefined;
  vehicle.preventspawninto = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "deregisterInstance"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "deregisterInstance")]](vehicle);
}

vehicle_occupancy_instanceisregistered(vehicle) {
  return isDefined(vehicle.occupants);
}

vehicle_occupancy_getallvehicleseats(vehicle, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(_id_E2818AD39A3341B4) && isDefined(_id_E2818AD39A3341B4.seatdata))
    return getarraykeys(_id_E2818AD39A3341B4.seatdata);
  else
    return undefined;
}

vehicle_occupancy_getavailablevehicleseats(vehicle) {
  _id_109A35EF4925C2B1 = [];
  seatids = vehicle_occupancy_getallvehicleseats(vehicle);

  foreach(seatid in seatids) {
    if(!vehicle_occupancy_seatisavailable(vehicle, seatid)) {
      continue;
    }
    _id_109A35EF4925C2B1[_id_109A35EF4925C2B1.size] = seatid;
  }

  return _id_109A35EF4925C2B1;
}

_id_D3D95972F58AD2BC(vehicle) {
  _id_109A35EF4925C2B1 = vehicle_occupancy_getavailablevehicleseats(vehicle);

  if(!isDefined(_id_109A35EF4925C2B1) || _id_109A35EF4925C2B1.size <= 0)
    return undefined;
  else if(_id_109A35EF4925C2B1.size == 1)
    return _id_109A35EF4925C2B1[0];

  _id_585F102C0882558A = _id_109A35EF4925C2B1[0];
  _id_5C49327452EF41BB = -1;
  _id_E1A1A4F1CE293589 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(vehicle.vehiclename)._id_9D0537BE150542B3;

  foreach(seatid in _id_109A35EF4925C2B1) {
    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);
    spawnpriority = _id_0C50B485A43752FD.spawnpriority;
    _id_76BB3B42BFEBB3EC = scripts\engine\utility::array_find(_id_E1A1A4F1CE293589, seatid);

    if(!isDefined(spawnpriority) && isDefined(_id_76BB3B42BFEBB3EC))
      spawnpriority = _id_E1A1A4F1CE293589.size - _id_76BB3B42BFEBB3EC;
    else if(!isDefined(spawnpriority))
      spawnpriority = 0;
    else
      spawnpriority = int(max(0, spawnpriority));

    if(spawnpriority > _id_5C49327452EF41BB) {
      _id_585F102C0882558A = seatid;
      _id_5C49327452EF41BB = spawnpriority;
    }
  }

  return _id_585F102C0882558A;
}

vehicle_occupancy_seatisavailable(vehicle, seatid, player) {
  _id_F85572CD5F6117C6 = vehicle.occupants[seatid];
  _id_5DC30F34F408331D = vehicle.occupantsreserving[seatid];

  if(!isDefined(_id_F85572CD5F6117C6) && !isDefined(_id_5DC30F34F408331D))
    return 1;

  if(isDefined(player)) {
    if(isDefined(_id_F85572CD5F6117C6) && _id_F85572CD5F6117C6 == player)
      return 1;

    if(isDefined(_id_5DC30F34F408331D) && _id_5DC30F34F408331D == player)
      return 1;
  }

  return 0;
}

vehicle_occupancy_getseatoccupant(vehicle, seatid, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  if(isDefined(vehicle.occupants))
    return vehicle.occupants[seatid];
  else
    return undefined;
}

vehicle_occupancy_getalloccupants(vehicle, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  return vehicle.occupants;
}

_id_0EFA75AA7F0A1289(vehicle, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  occupants = vehicle.occupants;

  if(isDefined(vehicle._id_8784C427B1AF24A6))
    occupants = scripts\engine\utility::array_combine_unique(occupants, vehicle._id_8784C427B1AF24A6);

  if(isDefined(vehicle._id_3A442282FB9074E1))
    occupants = scripts\engine\utility::array_combine_unique(occupants, vehicle._id_3A442282FB9074E1);

  return occupants;
}

vehicle_occupancy_getalloccupantsandreserving(vehicle, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  if(!isDefined(vehicle.occupants))
    return undefined;

  return scripts\engine\utility::array_combine_unique(vehicle.occupants, vehicle.occupantsreserving);
}

vehicle_occupancy_getreserving(vehicle, _id_6BE731EC00F344CB) {
  if(!isDefined(_id_6BE731EC00F344CB))
    _id_6BE731EC00F344CB = 1;

  if(!isDefined(vehicle.occupants))
    return undefined;

  return vehicle.occupantsreserving;
}

vehicle_occupancy_getoccupantseat(vehicle, player) {
  foreach(seatid, _id_F85572CD5F6117C6 in vehicle.occupants) {
    if(_id_F85572CD5F6117C6 == player)
      return seatid;
  }

  return undefined;
}

vehicle_occupancy_occupantisvehicledriver(player) {
  if(isDefined(player.vehicle)) {
    seatid = vehicle_occupancy_getoccupantseat(player.vehicle, player);
    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(player.vehicle.vehiclename, seatid);

    if(isDefined(_id_0C50B485A43752FD.animtag)) {
      _id_C39487B3181A24DC = tolower(_id_0C50B485A43752FD.animtag);

      if(_id_C39487B3181A24DC == "tag_seat_0")
        return 1;
    }
  }

  return 0;
}

vehicle_occupancy_getdriver(vehicle, _id_6ECB77FD1F27C667) {
  driverseatid = vehicle_occupancy_getdriverseat(vehicle, _id_6ECB77FD1F27C667);

  if(isDefined(driverseatid))
    return vehicle_occupancy_getseatoccupant(vehicle, driverseatid, !istrue(_id_6ECB77FD1F27C667));

  return undefined;
}

vehicle_occupancy_getdriverseat(vehicle, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename, !istrue(_id_6ECB77FD1F27C667));

  if(!isDefined(_id_E2818AD39A3341B4))
    return undefined;

  driverseatid = _id_E2818AD39A3341B4.driverseatid;

  if(!isDefined(driverseatid)) {
    if(isDefined(_id_E2818AD39A3341B4.seatdata)) {
      foreach(seatid, seatdata in _id_E2818AD39A3341B4.seatdata) {
        if(isDefined(seatdata.animtag) && tolower(seatdata.animtag) == "tag_seat_0") {
          driverseatid = seatid;
          break;
        }
      }
    }

    _id_E2818AD39A3341B4.driverseatid = driverseatid;
  }

  return driverseatid;
}

vehicle_occupancy_isdriverseat(vehicle, seatid) {
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(_id_0C50B485A43752FD.animtag))
    return 0;

  if(tolower(_id_0C50B485A43752FD.animtag) != "tag_seat_0")
    return 0;

  return 1;
}

vehicle_occupancy_enter(vehicle, seatid, player, data, immediate) {
  _id_7C80EF8134378DEA = 0;

  if(isDefined(data) && isDefined(data.useonspawn))
    _id_7C80EF8134378DEA = 1;

  if(!_id_7C80EF8134378DEA && !player scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(istrue(player.inlaststand)) {
    return;
  }
  if(istrue(vehicle.isdestroyed)) {
    return;
  }
  foreach(_id_5DC30F34F408331D in vehicle.occupantsreserving) {
    if(isDefined(_id_5DC30F34F408331D) && _id_5DC30F34F408331D == player)
      return;
  }

  _id_FC7C7A874B43A31A = vehicle_occupancy_getoccupantseat(vehicle, player);

  if(istrue(vehicle_occupancy_seatisavailable(vehicle, seatid, player))) {
    vehicle_occupancy_stopmonitoringoccupant(player);

    if(!isDefined(data))
      data = spawnStruct();

    data.immediate = istrue(immediate);
    data.raceendnotify = "vehicle_race_last_call";
    data.raceendon = "vehicle_race_finished";

    if(!data.immediate) {
      thread vehicle_occupancy_raceplayerdeathdisconnect(player, data);
      thread vehicle_occupancy_racevehicledeath(vehicle, data);
      thread vehicle_occupancy_raceseatunavailable(vehicle, player, seatid, _id_FC7C7A874B43A31A, data);
      thread vehicle_occupancy_racecomplete(_id_FC7C7A874B43A31A, seatid, data);
    }

    if(isDefined(_id_FC7C7A874B43A31A))
      thread vehicle_occupancy_exitstart(vehicle, _id_FC7C7A874B43A31A, seatid, player, data);

    if(isDefined(seatid))
      thread vehicle_occupancy_enterstart(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

    vehicle_occupancy_updatefull(vehicle);
    vehicle_occupancy_updateempty(vehicle);

    if(!data.immediate) {
      data waittill(data.raceendnotify);
      waittillframeend;
      data notify(data.raceendon);
    }

    if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(vehicle)) {
      return;
    }
    success = vehicle_occupancy_raceresults(vehicle, player, _id_FC7C7A874B43A31A, seatid, data);

    if(isDefined(_id_FC7C7A874B43A31A))
      thread vehicle_occupancy_exitend(vehicle, _id_FC7C7A874B43A31A, seatid, player, data);

    if(isDefined(seatid))
      thread vehicle_occupancy_enterend(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

    vehicle_occupancy_updatefull(vehicle);
    vehicle_occupancy_updateempty(vehicle);

    if(success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "changedSeats"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "changedSeats")]](player, vehicle, _id_FC7C7A874B43A31A, seatid);

      thread vehicle_occupancy_monitoroccupant(vehicle, player, seatid);
      player enablereloading();

      if(isDefined(_id_FC7C7A874B43A31A)) {
        _id_DF653126C71EF4CA = vehicle_occupancy_isdriverseat(vehicle, _id_FC7C7A874B43A31A);

        if(istrue(_id_DF653126C71EF4CA) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer"))
          player[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
      }

      if(isDefined(seatid)) {
        _id_DF653126C71EF4CA = vehicle_occupancy_isdriverseat(vehicle, seatid);

        if(istrue(_id_DF653126C71EF4CA)) {
          vehicle _id_9E710C9F3A15FFDA();

          if(isDefined(player.vehiclecustomization)) {
            _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

            if(!isDefined(vehicle._id_35FD13041DDE93E8) && !istrue(vehicle._id_7EE6203C5532A9E6)) {
              _id_35FD13041DDE93E8 = scripts\cp_mp\vehicles\vehicle::_id_471CDE1983A05F66(player, _id_7731ADEF63E19B0C);
              scripts\cp_mp\vehicles\vehicle::_id_4201160D49C885A7(vehicle, _id_35FD13041DDE93E8);
            }

            if(isDefined(player.vehiclecustomization._id_94B01AC7CDDDF04D[_id_7731ADEF63E19B0C]))
              vehicle setvehiclehornsound(player.vehiclecustomization._id_94B01AC7CDDDF04D[_id_7731ADEF63E19B0C]);
            else if(isDefined(vehicle._id_35FD13041DDE93E8) && isDefined(vehicle._id_35FD13041DDE93E8._id_8944BFD3F47B63F2))
              vehicle setvehiclehornsound(vehicle._id_35FD13041DDE93E8._id_8944BFD3F47B63F2);
            else
              vehicle setvehiclehornsound("");
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "startChallengeTimer"))
            player[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "startChallengeTimer")]]("driving");
        }
      }

      if(!isDefined(_id_FC7C7A874B43A31A)) {
        _id_6C6D078A43295C39 = "ENTERED_VEHICLE";

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onVehicleEnter"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onVehicleEnter")]](player, vehicle);
      } else
        _id_6C6D078A43295C39 = "SEAT_SWITCH";

      scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_vehicleoccupancyenter(vehicle, player, seatid, _id_FC7C7A874B43A31A);
      scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_enterevent(vehicle, player, seatid, _id_6C6D078A43295C39);
    } else if(isDefined(_id_FC7C7A874B43A31A) && !istrue(data.vehicledeath)) {
      if(istrue(data.playerdeath) || istrue(data.playerlaststand) || istrue(data.playerdisconnect)) {
        _id_84DCD1AB2AE1DFFA = spawnStruct();
        _id_84DCD1AB2AE1DFFA.playerdeath = data.playerdeath;
        _id_84DCD1AB2AE1DFFA.playerlaststand = data.playerlaststand;
        _id_84DCD1AB2AE1DFFA._id_D4B9AA76041AB0A9 = data._id_D4B9AA76041AB0A9;
        _id_84DCD1AB2AE1DFFA.playerdisconnect = data.playerdisconnect;
        thread vehicle_occupancy_exit(vehicle, _id_FC7C7A874B43A31A, player, _id_84DCD1AB2AE1DFFA, 1);
      } else
        vehicle_occupancy_reenter(vehicle, _id_FC7C7A874B43A31A, seatid, player, data);
    }
  }
}

vehicle_occupancy_exit(vehicle, seatid, player, data, immediate, _id_FE757BF1A5D559B4) {
  if(isDefined(data)) {}

  if(isDefined(player) && player _meth_D09168B16803F5BE())
    player notify("interrupt_roof_exit");

  _id_FC7C7A874B43A31A = seatid;

  if(isDefined(player)) {
    if(!isDefined(_id_FC7C7A874B43A31A))
      _id_FC7C7A874B43A31A = vehicle_occupancy_getoccupantseat(vehicle, player);

    if(!player scripts\cp_mp\utility\player_utility::_isalive())
      immediate = 1;

    if(istrue(player.inlaststand))
      immediate = 1;

    vehicle_occupancy_stopmonitoringoccupant(player);
  } else {
    immediate = 1;
    vehicle_occupancy_purgedataforseatinstance(vehicle, _id_FC7C7A874B43A31A);
  }

  if(istrue(vehicle.isdestroyed))
    immediate = 1;

  if(!isDefined(data))
    data = spawnStruct();

  data.immediate = istrue(immediate);
  data.raceendnotify = "vehicle_race_last_call";
  data.raceendon = "vehicle_race_finished";

  if(!data.immediate) {
    thread vehicle_occupancy_raceplayerdeathdisconnect(player, data);
    thread vehicle_occupancy_racevehicledeath(vehicle, data);
    thread vehicle_occupancy_racecomplete(_id_FC7C7A874B43A31A, undefined, data);
  }

  thread vehicle_occupancy_exitstart(vehicle, _id_FC7C7A874B43A31A, undefined, player, data, _id_FE757BF1A5D559B4);

  if(!data.immediate) {
    data waittill(data.raceendnotify);
    waittillframeend;
    data notify(data.raceendon);
  }

  success = vehicle_occupancy_raceresults(vehicle, player, _id_FC7C7A874B43A31A, undefined, data);
  thread vehicle_occupancy_exitend(vehicle, _id_FC7C7A874B43A31A, undefined, player, data, _id_FE757BF1A5D559B4);
  vehicle_occupancy_updatefull(vehicle);
  vehicle_occupancy_updateempty(vehicle);

  if(istrue(vehicle.isheli) && istrue(vehicle.isempty))
    vehicle thread _id_BA42CF4E5BB24367();

  if(success) {
    if(isDefined(player)) {
      player enablereloading();
      _id_DF653126C71EF4CA = vehicle_occupancy_isdriverseat(vehicle, _id_FC7C7A874B43A31A);

      if(istrue(_id_DF653126C71EF4CA) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
    }
  } else if(!istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data._id_D4B9AA76041AB0A9) && !istrue(data._id_F276D4E53593EC9A) && !istrue(data.playerdisconnect) && !istrue(data.vehicledeath))
    vehicle_occupancy_reenter(vehicle, _id_FC7C7A874B43A31A, undefined, player, data);
}

vehicle_occupancy_isfriendlytoplayer(vehicle, player) {
  if(level.teambased)
    return vehicle_occupancy_isfriendlytoteam(vehicle, player.team);
  else {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return isDefined(vehicle.playerfriendlyto) && vehicle.playerfriendlyto == player;
  }
}

vehicle_occupancy_isenemytoplayer(vehicle, player) {
  if(level.teambased)
    return vehicle_occupancy_isenemytoteam(vehicle, player.team);
  else {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return isDefined(vehicle.playerfriendlyto) && vehicle.playerfriendlyto != player;
  }
}

vehicle_occupancy_isneutraltoplayer(vehicle, player) {
  if(level.teambased)
    return vehicle_occupancy_isneutraltoteam(vehicle, player.team);
  else {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return !isDefined(vehicle.playerfriendlyto);
  }
}

vehicle_occupancy_getplayerfriendlyto(vehicle) {
  if(!level.teambased) {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return vehicle.playerfriendlyto;
  }

  return undefined;
}

vehicle_occupancy_isfriendlytoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return isDefined(vehicle.teamfriendlyto) && vehicle.teamfriendlyto == team;
  }

  return undefined;
}

vehicle_occupancy_isenemytoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return isDefined(vehicle.teamfriendlyto) && vehicle.teamfriendlyto != team;
  }

  return undefined;
}

vehicle_occupancy_isneutraltoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return !isDefined(vehicle.teamfriendlyto);
  }

  return undefined;
}

vehicle_occupancy_getteamfriendlyto(vehicle) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty))
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);

    return vehicle.teamfriendlyto;
  }

  return undefined;
}

vehicle_occupancy_setfriendlystatusdirty(vehicle) {
  vehicle.friendlystatusdirty = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
}

vehicle_occupancy_cleanfriendlystatus(vehicle) {
  if(level.teambased) {
    _id_C61FF99AB15EAE4B = 0;
    _id_757203A7499DFC71 = vehicle.teamfriendlyto;

    if(isDefined(vehicle.team) && vehicle.team != "neutral") {
      vehicle.teamfriendlyto = vehicle.team;
      vehicle.friendlystatusdirty = undefined;
      _id_C61FF99AB15EAE4B = 1;
    }

    if(!_id_C61FF99AB15EAE4B) {
      foreach(_id_F85572CD5F6117C6 in vehicle.occupants) {
        if(isDefined(_id_F85572CD5F6117C6)) {
          vehicle.teamfriendlyto = _id_F85572CD5F6117C6.team;
          vehicle.friendlystatusdirty = undefined;
          _id_C61FF99AB15EAE4B = 1;
          break;
        }
      }
    }

    if(!_id_C61FF99AB15EAE4B) {
      vehicle.teamfriendlyto = undefined;
      vehicle.friendlystatusdirty = undefined;
    }

    if(!isDefined(_id_757203A7499DFC71) && !isDefined(vehicle.teamfriendlyto))
      return 0;

    if(isDefined(_id_757203A7499DFC71) && isDefined(vehicle.teamfriendlyto) && _id_757203A7499DFC71 == vehicle.teamfriendlyto)
      return 0;

    vehicle_occupancy_friendlystatuschangedcallback(vehicle, _id_757203A7499DFC71, vehicle.teamfriendlyto);
    return 1;
  } else {
    _id_C61FF99AB15EAE4B = 0;
    _id_49DC0CD42EFB83E9 = vehicle.playerfriendlyto;

    if(isDefined(vehicle.originalowner)) {
      vehicle.playerfriendlyto = vehicle.originalowner;
      vehicle.friendlystatusdirty = undefined;
      _id_C61FF99AB15EAE4B = 1;
    }

    if(!_id_C61FF99AB15EAE4B) {
      occupants = vehicle_occupancy_getalloccupants(vehicle);

      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(isDefined(_id_F85572CD5F6117C6)) {
          vehicle.playerfriendlyto = _id_F85572CD5F6117C6;
          vehicle.friendlystatusdirty = undefined;
          return;
        }
      }
    }

    if(!isDefined(_id_49DC0CD42EFB83E9) && !isDefined(vehicle.playerfriendlyto))
      return 0;

    if(isDefined(_id_49DC0CD42EFB83E9) && isDefined(vehicle.playerfriendlyto) && _id_49DC0CD42EFB83E9 == vehicle.playerfriendlyto)
      return 0;

    vehicle_occupancy_friendlystatuschangedcallback(vehicle, _id_49DC0CD42EFB83E9, vehicle.playerfriendlyto);
    return 1;
  }
}

vehicle_occupancy_friendlystatuschangedcallback(vehicle, _id_965EA26E6EB230B9, _id_52312180EF1940BE) {
  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_friendlystatuschangedcallback(vehicle, _id_965EA26E6EB230B9, _id_52312180EF1940BE);
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(!isDefined(_id_E2818AD39A3341B4.friendlystatuschangedcallback)) {
    return;
  }
  thread[[_id_E2818AD39A3341B4.friendlystatuschangedcallback]](vehicle, _id_965EA26E6EB230B9, _id_52312180EF1940BE);
}

vehicle_occupancy_setoriginalowner(vehicle, player) {
  vehicle.originalowner = player;
  vehicle_occupancy_updateowner(vehicle);
}

vehicle_occupancy_setowner(vehicle, player, _id_57C14BF60C5BE4AB, _id_13CC810B9974360E) {
  if(!isDefined(vehicle.owners))
    vehicle.owners = [];
  else {
    vehicle_occupancy_clearowner(vehicle, player);
    vehicle.owners = scripts\engine\utility::array_removeundefined(vehicle.owners);
  }

  vehicle.owners[vehicle.owners.size] = player;

  if(isDefined(_id_13CC810B9974360E) && _id_13CC810B9974360E == -1) {} else
    thread vehicle_occupancy_watchowner(vehicle, player, _id_57C14BF60C5BE4AB, _id_13CC810B9974360E);

  vehicle_occupancy_updateowner(vehicle);
}

vehicle_occupancy_updateowner(vehicle) {
  vehicle notify("vehicle_owner_update");
  _id_F986E8DDFAC8AB13 = vehicle.owner;
  _id_FEFFBDC57F0856FA = vehicle.ownerteam;
  _id_B3AEDE46434BB626 = undefined;

  if(isDefined(vehicle.owners)) {
    for(_id_AC0E594AC96AA3A8 = vehicle.owners.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      if(vehicle_occupancy_isplayervalidowner(vehicle, vehicle.owners[_id_AC0E594AC96AA3A8])) {
        _id_B3AEDE46434BB626 = vehicle.owners[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  if(!isDefined(_id_B3AEDE46434BB626)) {
    if(vehicle_occupancy_isplayervalidowner(vehicle, vehicle.originalowner))
      _id_B3AEDE46434BB626 = vehicle.originalowner;
  }

  vehicle.owner = _id_B3AEDE46434BB626;
  _id_443185A3B7BBA89C = 0;

  if(isDefined(_id_B3AEDE46434BB626) || isDefined(_id_F986E8DDFAC8AB13)) {
    if(!isDefined(_id_B3AEDE46434BB626) && isDefined(_id_F986E8DDFAC8AB13))
      _id_443185A3B7BBA89C = 1;
    else if(isDefined(_id_B3AEDE46434BB626) && !isDefined(_id_F986E8DDFAC8AB13))
      _id_443185A3B7BBA89C = 1;
    else if(_id_B3AEDE46434BB626 != _id_F986E8DDFAC8AB13)
      _id_443185A3B7BBA89C = 1;
  }

  _id_1FBDA3BED6B9855F = 0;

  if(isDefined(_id_B3AEDE46434BB626)) {
    if(!isDefined(_id_FEFFBDC57F0856FA) || _id_FEFFBDC57F0856FA != _id_B3AEDE46434BB626.team)
      _id_1FBDA3BED6B9855F = 1;

    vehicle.ownerteam = _id_B3AEDE46434BB626.team;
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_setteamfriendlyto(vehicle, _id_B3AEDE46434BB626.team);
    thread vehicle_occupancy_watchownerjoinedteam(vehicle, _id_B3AEDE46434BB626);
  } else {
    if(_id_443185A3B7BBA89C)
      _id_1FBDA3BED6B9855F = 1;

    vehicle.ownerteam = undefined;
  }

  if(_id_443185A3B7BBA89C) {
    if(!level.teambased)
      vehicle_occupancy_setfriendlystatusdirty(vehicle);

    vehicle scripts\cp_mp\vehicles\vehicle::_id_A2D1400BCF46869A();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateOwner"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateOwner")]](vehicle);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "updateOwner"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "updateOwner")]](vehicle, _id_B3AEDE46434BB626, _id_443185A3B7BBA89C, _id_1FBDA3BED6B9855F);
}

vehicle_occupancy_clearowner(vehicle, player) {
  vehicle notify("vehicle_clear_owner_" + player getentitynumber());

  if(isDefined(vehicle.owners))
    vehicle.owners = scripts\engine\utility::array_remove(vehicle.owners, player);

  if(isDefined(vehicle.owner) && vehicle.owner == player)
    vehicle_occupancy_updateowner(vehicle);
}

vehicle_occupancy_setteam(vehicle, team) {
  _id_4BCF5A0C6C1E3A44 = !isDefined(vehicle.team) || vehicle.team != team;
  vehicle.team = team;

  if(vehicle.classname == "script_vehicle")
    vehicle setvehicleteam(team);

  if(_id_4BCF5A0C6C1E3A44) {
    if(level.teambased)
      vehicle_occupancy_setfriendlystatusdirty(vehicle);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "updateTeam"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "updateTeam")]](vehicle, team, _id_4BCF5A0C6C1E3A44);

  vehicle_occupancy_updateowner(vehicle);
}

#using_animtree("script_model");

vehicle_occupancy_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.occupancy = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.vehicledata = [];
  _id_962A30A9BB8C0F09._id_77B46B8810CB73F3 = getdvarint("dvar_4BF0D02FF4AC62ED", 1) > 0;

  if(_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    _id_962A30A9BB8C0F09._id_51C0466D6F15A77F = 0;
    _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64 = [];
  }

  vehicle_occupancy_initdebug();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "init")]]();
  level._id_073D6C6366970020 = getdvarint("bg_veh_exit_jumpout_enabled", 1);
  level._id_351AAB391DA578A8 = getdvarint("dvar_2BF0E47506040359", 1) == 1;
  level._id_ABE9BCB8A67FF917 = getdvarfloat("dvar_83928D2D50DC276C") + 50;
  level._id_D9DC5B053FB57856 = getdvarfloat("dvar_C9B7B0F34821B869") + 50;
  level._id_DF44F8CC05382071 = getdvarfloat("dvar_94DB90BABE43CDC4", 100);
  level._id_49B09BD5297D4967 = getdvarint("dvar_A459BB531AF563B7", 1);

  if(istrue(level._id_351AAB391DA578A8))
    level.scr_animtree["player_exit_vehicle_to_roof"] = #animtree;
}

vehicle_occupancy_enterstart(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  data endon(data.raceendon);

  if(istrue(player.insertingarmorplate))
    player notify("try_armor_cancel", "vehicle_enter");

  scripts\cp_mp\vehicles\vehicle_damage::_id_EAE2223216B7712C(vehicle, player);
  vehicle.occupantsreserving[seatid] = player;
  player.vehiclereserved = vehicle;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = undefined;

  if(data.immediate)
    timestamp = gettime();

  if(isDefined(data.enterstartwaitmsg))
    player waittill(data.enterstartwaitmsg);

  vehicle_occupancy_deleteseatcorpse(vehicle, seatid, 1);
  enterstartcallback = vehicle_occupancy_getenterstartcallbackforseat(vehicle, seatid);

  if(isDefined(enterstartcallback))
    [[enterstartcallback]](vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

  if(!isDefined(data.enterstartcomplete))
    data.enterstartcomplete = 1;

  if(data.immediate)
    return;
}

vehicle_occupancy_exitstart(vehicle, seatid, _id_7558F98F3236963D, player, data, _id_FE757BF1A5D559B4) {
  data endon(data.raceendon);
  timestamp = undefined;

  if(data.immediate)
    timestamp = gettime();

  if(isDefined(player)) {
    seatdata = vehicle_occupancy_getleveldataforseat(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), seatid);

    if(player _meth_A7DE57196F4B5D16())
      player._id_8BCE248CE93882F2 = 1;
    else
      player._id_8BCE248CE93882F2 = undefined;
  }

  exitstartcallback = vehicle_occupancy_getexitstartcallbackforseat(vehicle, seatid);

  if(isDefined(exitstartcallback))
    [[exitstartcallback]](vehicle, seatid, _id_7558F98F3236963D, player, data, _id_FE757BF1A5D559B4);
  else
    vehicle_occupancy_exitstartcallback(vehicle, seatid, _id_7558F98F3236963D, player, data, _id_FE757BF1A5D559B4);

  if(!isDefined(data.exitstartcomplete))
    data.exitstartcomplete = 1;

  if(data.immediate)
    return;
}

_id_2966F7AB8AE9CCC6(tag) {
  return tag + "_window";
}

_id_43C2C433B8B9B12D(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    _id_5004590331017D88(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

_id_5004590331017D88(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
}

_id_857BF4201A249A99(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    _id_CB4191526E56163C(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_CB4191526E56163C(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect)) {
    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

vehicle_occupancy_exitstartcallback(vehicle, seatid, _id_7558F98F3236963D, player, data, _id_FE757BF1A5D559B4) {
  data endon(data.raceendon);
  result = vehicle_occupancy_findplayerexit(player, vehicle, seatid, _id_7558F98F3236963D, data, _id_FE757BF1A5D559B4);

  if(!result) {
    data.exitstartcomplete = 0;
    vehicle_occupancy_errormessage(player, 2);

    if(!istrue(data.immediate)) {
      waitframe();
      data notify(data.raceendnotify);
    }
  } else if(isDefined(data._id_FE757BF1A5D559B4) && data._id_FE757BF1A5D559B4 == "_to_roof") {
    result = _id_C5819749DB1604F5(player, vehicle, seatid, data);

    if(!istrue(result)) {
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
      vehicle_occupancy_exitstartcallback(vehicle, seatid, _id_7558F98F3236963D, player, data, undefined);
    }
  }
}

vehicle_occupancy_enterend(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success)) {
    vehicle.occupants[seatid] = player;
    vehicle.occupantsreserving[seatid] = undefined;
    player.vehicle = vehicle;
    player.vehiclereserved = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "disableClassSwapAllowed"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "disableClassSwapAllowed")]]();

    vehicle_occupancy_applyrestrictionstooccupant(vehicle, seatid, player, data);
    vehicle_occupancy_updateriotshield(player, vehicle, seatid);
    vehicle_occupancy_hideoccupant(vehicle, seatid, player, data);
    vehicle_occupancy_applycameratooccupant(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
    vehicle_occupancy_applydamagemodifiertooccupant(vehicle, seatid, player, data);
    vehicle_occupancy_hidecashbag(vehicle, seatid, player, data);
    _id_7C295748BBE46EDF(vehicle, seatid, player, data);
    _id_A3428466C78231B0(vehicle, player);

    if(vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_452936099DCD1B94(seatid))
      player thread scripts\cp_mp\vehicles\vehicle_damage::_id_E6EC777562579771(vehicle, seatid);

    if(!isDefined(_id_FC7C7A874B43A31A)) {
      vehicle_occupancy_onentervehicle(vehicle, seatid, player, data);
      vehicle scripts\cp_mp\vehicles\vehicle_interact::_id_7394E322C553B3F0();
      _id_6681408AC5FCC6CF = player.pers["telemetry"];
      _id_E0187E3C57F0F72E = vehicle scripts\cp_mp\vehicles\vehicle::_id_E0187E3C57F0F72E();

      if(isDefined(_id_6681408AC5FCC6CF._id_2C0070B8E9CD250F) && _id_E0187E3C57F0F72E)
        _id_6681408AC5FCC6CF._id_2C0070B8E9CD250F++;

      _id_E9D237C4BA649649 = vehicle scripts\cp_mp\vehicles\vehicle::vehiclecanfly();

      if(isDefined(_id_6681408AC5FCC6CF._id_C60EFB14A77D9DB8) && _id_E9D237C4BA649649)
        _id_6681408AC5FCC6CF._id_C60EFB14A77D9DB8++;
    }

    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

    if(isDefined(_id_0C50B485A43752FD.animtag) && tolower(_id_0C50B485A43752FD.animtag) == tolower("tag_seat_0"))
      vehicle_occupancy_setowner(vehicle, player, 1);

    if(!isDefined(_id_FC7C7A874B43A31A)) {
      player notify("vehicle_enter");

      if(isDefined(_id_0C50B485A43752FD.onenterbattlechatter))
        thread vehicle_occupancy_handleplayerbc(player, _id_0C50B485A43752FD, 1);
    } else {
      player notify("vehicle_change_seat");

      if(isDefined(_id_0C50B485A43752FD.onenterbattlechatter))
        thread vehicle_occupancy_handleplayerbc(player, _id_0C50B485A43752FD, 0);
    }

    _id_C6500DFC575DC550 = vehicle_occupancy_isdriverseat(vehicle, seatid);

    if(_id_C6500DFC575DC550 && istrue(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_941D95491D4D4817))
      vehicle _id_3112242E4BC392DE();

    if(istrue(vehicle.isheli))
      vehicle _id_A91927DF280E94E4();

    if(_id_C6500DFC575DC550 && istrue(vehicle._id_6179B2EEA75DBFE0))
      vehicle _id_9A816E66A02DDB40();
  } else {
    if(isDefined(player))
      player.vehiclereserved = undefined;

    if(!istrue(data.vehicledeath))
      vehicle.occupantsreserving[seatid] = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = gettime();

  if(istrue(data.success)) {
    player thread vehicle_occupancy_animateplayer(vehicle, seatid, _id_FC7C7A874B43A31A);
    _id_C84D89E51C871AA2(vehicle, seatid, player, data);

    if(vehicle _id_72F871BF74995298() && vehicle vehicle_isphysveh())
      vehicle _meth_65AA053C077C003A(1);
  }

  enterendcallback = vehicle_occupancy_getenterendcallbackforseat(vehicle, seatid);

  if(isDefined(enterendcallback))
    [[enterendcallback]](vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
  else
    _id_43C2C433B8B9B12D(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

vehicle_occupancy_exitend(vehicle, seatid, _id_7558F98F3236963D, player, data, _id_FE757BF1A5D559B4) {
  if(data.success) {
    vehicle.occupants[seatid] = undefined;

    if(isDefined(player)) {
      player notify("vehicle_seat_exit");

      if(!isDefined(_id_7558F98F3236963D))
        player.vehicle = undefined;

      vehicle_occupancy_removerestrictionsfromoccupant(vehicle, seatid, player, data);
      vehicle_occupancy_updateriotshield(player, vehicle, _id_7558F98F3236963D);
      vehicle_occupancy_showoccupant(vehicle, seatid, player, data);
      _id_EDCB1116F9160367(vehicle, seatid, player, data);
      _id_E157F2A83AA01EA2(vehicle, seatid, player, data);
      vehicle_occupancy_removecamerafromoccupant(vehicle, _id_7558F98F3236963D, player, data);
      vehicle_occupancy_removedamagemodifierfromoccupant(vehicle, seatid, player, data);
      vehicle_occupancy_showcashbag(vehicle, seatid, player, data);
    }

    if(!isDefined(_id_7558F98F3236963D))
      vehicle_occupancy_onexitvehicle(vehicle, seatid, player, data);

    if(!vehicle scripts\common\vehicle_code::vehicle_is_stopped() && vehicle_occupancy_isdriverseat(vehicle, seatid)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
        _id_CD37CE775909957B = spawnStruct();
        _id_CD37CE775909957B.exitdriver = 1;
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_ghostRideWhip", _id_CD37CE775909957B);
      }
    }

    if(vehicle_occupancy_isdriverseat(vehicle, seatid) && istrue(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_941D95491D4D4817))
      vehicle thread _id_4E7868EF633F4B36();
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = gettime();
  exitendcallback = vehicle_occupancy_getexitendcallbackforseat(vehicle, seatid);

  if(isDefined(exitendcallback))
    [[exitendcallback]](vehicle, seatid, _id_7558F98F3236963D, player, data);
  else
    _id_857BF4201A249A99(vehicle, seatid, _id_7558F98F3236963D, player, data);

  if(isDefined(player)) {
    player usebuttondone();

    if(!isDefined(_id_7558F98F3236963D)) {
      if(isDefined(player.vehoccupancy_lastseatbc))
        player.vehoccupancy_lastseatbc = undefined;

      if(isDefined(player.vehoccupancy_lastbctime))
        player.vehoccupancy_lastbctime = undefined;
    }

    player._id_E86DA3427F911D75 = undefined;
  }
}

vehicle_occupancy_reenter(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {
  thread vehicle_occupancy_monitoroccupant(vehicle, player, _id_9DE41F2EE77C33BA);
  timestamp = gettime();
  reentercallback = vehicle_occupancy_getreentercallbackforseat(vehicle, _id_9DE41F2EE77C33BA);

  if(isDefined(reentercallback))
    [[reentercallback]](vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data);
  else {
    data.success = undefined;
    data.exitposition = undefined;
    data.exitangles = undefined;
    data._id_FE757BF1A5D559B4 = undefined;
    data._id_2B16A165170D3506 = undefined;
    data._id_7862C7C7ADE2B42E = undefined;
    thread vehicle_occupancy_enter(vehicle, _id_9DE41F2EE77C33BA, player, data, 1);
  }
}

vehicle_occupancy_getleveldata() {
  return level.vehicle.occupancy;
}

vehicle_occupancy_handleplayerbc(player, seatdata, _id_4CBE0C5DDB047549) {
  _id_9D2442A09ADBB305 = 5000;

  if(istrue(_id_4CBE0C5DDB047549)) {
    player.vehoccupancy_lastseatbc = seatdata.onenterbattlechatter;
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound")]](player, seatdata.onenterbattlechatter, undefined, 1);
    player.vehoccupancy_lastbctime = gettime();
  } else if(isDefined(player.vehoccupancy_lastseatbc) && isDefined(player.vehoccupancy_lastbctime) && player.vehoccupancy_lastseatbc != seatdata.onenterbattlechatter && gettime() - player.vehoccupancy_lastbctime > _id_9D2442A09ADBB305) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound")]](player, seatdata.onenterbattlechatter);
    player.vehoccupancy_lastseatbc = seatdata.onenterbattlechatter;
    player.vehoccupancy_lastbctime = gettime();
  }
}

vehicle_occupancy_purgedataforseatinstance(vehicle, seatid) {
  vehicle.occupants[seatid] = undefined;
  vehicle.occupantsreserving[seatid] = undefined;
}

vehicle_occupancy_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {
  level notify("enter_vehicle", vehicle, player);
  vehicle_occupancy_setfriendlystatusdirty(vehicle);
  vehicle scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
  player setstance("stand");
  player _id_3B64EB40368C1450::_id_59C053B89257BC95("vehicle_occupant_common", vehicle_occupancy_getoccupantrestrictions(), 0);
  thread vehicle_occupancy_takeriotshield(player, vehicle, _id_7558F98F3236963D);
  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onentervehicle(vehicle, player);
  scripts\cp_mp\vehicles\vehicle_interact::_id_C5FE005F06FE5684(vehicle, player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onEnterVehicle", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onEnterVehicle")]](vehicle, _id_7558F98F3236963D, player, data);
}

vehicle_occupancy_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {
  level notify("exit_vehicle", vehicle, player);

  if(!istrue(data.playerdisconnect)) {
    player vehicle_occupancy_stopmovefeedbackforplayer();
    player vehicle_occupancy_cleardamagefeedbackforplayer();
    scripts\cp_mp\vehicles\vehicle_interact::_id_DEB83798A724A77E(vehicle, player);

    if(!istrue(data.playerdeath)) {
      if(istrue(data.playerlaststand) || istrue(data._id_D4B9AA76041AB0A9))
        data.exittype = "DEATH";
      else if(!isDefined(data.exittype))
        data.exittype = "VOLUNTARY";

      thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
    } else
      data.exittype = "DEATH";

    thread vehicle_occupancy_giveriotshield(player, data.playerdeath, data.playerlaststand);
  } else
    data.exittype = "DISCONNECT";

  vehicle_occupancy_setfriendlystatusdirty(vehicle);
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::_id_6C65DF1F40E10037();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onExitVehicle", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onExitVehicle")]](vehicle, _id_FC7C7A874B43A31A, player, data);

  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_exitevent(vehicle, player, _id_FC7C7A874B43A31A, data.exittype);
  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onexitvehicle(vehicle, player, _id_FC7C7A874B43A31A);
}

vehicle_occupancy_updatefull(vehicle) {
  _id_5E41EE78365ED202 = vehicle_occupancy_getavailablevehicleseats(vehicle).size <= 0;

  if(_id_5E41EE78365ED202) {
    if(!istrue(vehicle.isfull)) {
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(vehicle, "single");
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
      vehicle.isfull = 1;
    } else
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  } else if(istrue(vehicle.isfull)) {
    vehicle.isfull = undefined;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(vehicle, "single");
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  } else
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
}

vehicle_occupancy_updateempty(vehicle) {
  _id_8224E7631D8F04F2 = vehicle_occupancy_getavailablevehicleseats(vehicle);
  _id_12D36E89A6E0742E = vehicle_occupancy_getallvehicleseats(vehicle);
  isempty = _id_8224E7631D8F04F2.size == _id_12D36E89A6E0742E.size;
  vehicle.isempty = isempty;
}

vehicle_occupancy_getenterstartcallbackforseat(vehicle, seatid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "enterStart"))
    return scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "enterStart");
}

vehicle_occupancy_getenterendcallbackforseat(vehicle, seatid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "enterEnd"))
    return scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "enterEnd");
}

vehicle_occupancy_getexitstartcallbackforseat(vehicle, seatid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "exitStart"))
    return scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "exitStart");
}

vehicle_occupancy_getexitendcallbackforseat(vehicle, seatid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "exitEnd"))
    return scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "exitEnd");
}

vehicle_occupancy_getreentercallbackforseat(vehicle, seatid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "reenter"))
    return scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "reenter");
}

vehicle_occupancy_applyrestrictionstooccupant(vehicle, _id_7558F98F3236963D, player, data) {
  if(!vehicle_occupancy_movementisallowed(vehicle) && !vehicle _id_F654C168752ED299()) {
    if(_id_7558F98F3236963D == vehicle_occupancy_getdriverseat(vehicle))
      vehicle_occupancy_allowmovementplayer(vehicle, player, 0, _id_7558F98F3236963D);
  }

  restrictions = vehicle_occupancy_getrestrictionsforseat(vehicle, _id_7558F98F3236963D);
  player _id_3B64EB40368C1450::_id_59C053B89257BC95("vehicle_occupant", restrictions, 0);
}

vehicle_occupancy_removerestrictionsfromoccupant(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(!istrue(data.playerdeath)) {
    vehicle_occupancy_allowmovementplayer(vehicle, player, 1, undefined);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant");
  }
}

_id_031609728116475F() {
  if(!isDefined(level._id_12A9AAC58C679ECA))
    level._id_12A9AAC58C679ECA = getdvarint("dvar_4F6BB46A93A86D18", 1);

  return level._id_12A9AAC58C679ECA;
}

vehicle_occupancy_hideoccupant(vehicle, _id_7558F98F3236963D, player, data) {
  if(vehicle_shouldhideoccupantforseat(vehicle, _id_7558F98F3236963D)) {
    player.nocorpse = 1;

    if(_id_031609728116475F()) {
      player scripts\cp_mp\utility\player_utility::_id_305FB8C759FA4DE5();
      player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("vehicle_occupancy::vehicle_occupancy_hideOccupant() - _playerHideStack");
    } else {
      player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("vehicle_occupancy::vehicle_occupancy_hideOccupant()");
    }
  }
}

_id_C84D89E51C871AA2(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(_id_0F3DB2E446C1457F(vehicle, _id_FC7C7A874B43A31A, player))
    player vehicle_setstowedweaponvisibility(0);
}

_id_23A58D26E5C53E1F(player, data) {
  _id_962A30A9BB8C0F09 = vehicle_occupancy_getleveldata();

  if(!_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    return;
  }
  id = _id_962A30A9BB8C0F09._id_51C0466D6F15A77F;
  _id_962A30A9BB8C0F09._id_51C0466D6F15A77F++;
  player scripts\cp_mp\utility\player_utility::_id_305FB8C759FA4DE5();
  player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("vehicle_occupancy::vehicle_occupancy_hideOccupantDuringTransition() - _playerHideStack");
  _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id] = player;

  if(!isDefined(data._id_DF81EEAB4C9E5F64))
    data._id_DF81EEAB4C9E5F64 = [];

  data._id_DF81EEAB4C9E5F64[id] = player;
  return id;
}

_id_1A067F7DA28CA689(id, data, _id_F4FEDB549A5FA44B) {
  _id_962A30A9BB8C0F09 = vehicle_occupancy_getleveldata();

  if(!_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    return;
  }
  if(istrue(_id_F4FEDB549A5FA44B)) {
    waitframe();
    waitframe();
  }

  if(!_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    return;
  }
  if(!isDefined(_id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id])) {
    return;
  }
  player = _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id];

  if(isDefined(data) && isDefined(data._id_DF81EEAB4C9E5F64))
    data._id_DF81EEAB4C9E5F64[id] = undefined;

  if(isDefined(player)) {
    player scripts\cp_mp\utility\player_utility::_id_F81E91F54BDDAF46();
    player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("vehicle_occupancy::vehicle_occupancy_showOccupantAfterTransitionByEventID() - _playerShowStack");
  }
}

_id_914037C6A5CEC6CD(data, _id_F4FEDB549A5FA44B) {
  _id_962A30A9BB8C0F09 = vehicle_occupancy_getleveldata();

  if(!_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    return;
  }
  if(istrue(_id_F4FEDB549A5FA44B)) {
    waitframe();
    waitframe();
  }

  if(!isDefined(data._id_DF81EEAB4C9E5F64)) {
    return;
  }
  foreach(id, player in data._id_DF81EEAB4C9E5F64) {
    if(isDefined(_id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id])) {
      _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id] = undefined;

      if(isDefined(player)) {
        player scripts\cp_mp\utility\player_utility::_id_F81E91F54BDDAF46();
        player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("vehicle_occupancy::vehicle_occupancy_showOccupantAfterTransitionByEventID() - _playerShowStack");
      }
    }
  }

  data._id_DF81EEAB4C9E5F64 = undefined;
}

_id_037BAD8E4D4B6A7F() {
  _id_962A30A9BB8C0F09 = vehicle_occupancy_getleveldata();

  if(!_id_962A30A9BB8C0F09._id_77B46B8810CB73F3) {
    return;
  }
  foreach(id, player in _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64) {
    if(!isDefined(player))
      _id_962A30A9BB8C0F09._id_DF81EEAB4C9E5F64[id] = undefined;
  }
}

vehicle_occupancy_showoccupant(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(!istrue(data.playerdeath)) {
    if(vehicle_shouldhideoccupantforseat(vehicle, _id_FC7C7A874B43A31A)) {
      if(!istrue(data.nocorpse))
        player.nocorpse = undefined;

      if(_id_031609728116475F()) {
        player scripts\cp_mp\utility\player_utility::_id_F81E91F54BDDAF46();
        player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("vehicle_occupancy::vehicle_occupancy_showOccupant() - _playerShowStack");
      } else {
        player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
        player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("vehicle_occupancy::vehicle_occupancy_showOccupant()");
      }
    }
  }
}

_id_EDCB1116F9160367(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(!istrue(data.playerdeath)) {
    if(_id_0F3DB2E446C1457F(vehicle, _id_FC7C7A874B43A31A, player))
      player vehicle_setstowedweaponvisibility(1);
  }
}

_id_7C295748BBE46EDF(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(_id_E552D137B9591A4C(vehicle, _id_FC7C7A874B43A31A, player) && player tagexists("j_helmet_hide"))
    player hidepart("j_helmet_hide", undefined, 1);
}

_id_E157F2A83AA01EA2(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(_id_E552D137B9591A4C(vehicle, _id_FC7C7A874B43A31A, player) && player tagexists("j_helmet_hide"))
    player showpart("j_helmet_hide", undefined, 1);
}

_id_E552D137B9591A4C(vehicle, seatid, player) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];
  return istrue(_id_0C50B485A43752FD._id_24F53ABCEDB992BC);
}

vehicle_occupancy_applycameratooccupant(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  camera = vehicle_getcameraforseat(vehicle, seatid);

  if(isDefined(camera) && camera != "none") {
    _id_2640F93C42B5DF71 = vehicle_getcameraforseat(vehicle, _id_FC7C7A874B43A31A);

    if(_id_2640F93C42B5DF71 != camera)
      player cameraset(camera);
  }
}

vehicle_occupancy_removecamerafromoccupant(vehicle, _id_7558F98F3236963D, player, data) {
  if(isDefined(_id_7558F98F3236963D)) {
    camera = vehicle_getcameraforseat(vehicle, _id_7558F98F3236963D);

    if(camera == "none") {
      player cameradefault();
      return;
    }
  } else
    player cameradefault();
}

vehicle_occupancy_applydamagemodifiertooccupant(vehicle, _id_7558F98F3236963D, player, data) {
  damagemodifier = vehicle_occupancy_getdamagemodifierforseat(vehicle, _id_7558F98F3236963D);

  if(isDefined(damagemodifier) && damagemodifier != -1)
    player scripts\cp_mp\utility\damage_utility::adddamagemodifier(vehicle.vehiclename + "_" + _id_7558F98F3236963D, damagemodifier, 0, ::vehicle_occupancy_damagemodifierignorefunc);
}

vehicle_occupancy_removedamagemodifierfromoccupant(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(!istrue(data.playerdeath)) {
    damagemodifier = vehicle_occupancy_getdamagemodifierforseat(vehicle, _id_FC7C7A874B43A31A);

    if(isDefined(damagemodifier) && damagemodifier != -1)
      player scripts\cp_mp\utility\damage_utility::removedamagemodifier(vehicle.vehiclename + "_" + _id_FC7C7A874B43A31A, 0);
  }
}

vehicle_occupancy_getrestrictionsforseat(vehicle, seatid) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];
  restrictions = scripts\engine\utility::ter_op(isDefined(_id_0C50B485A43752FD.restrictions), _id_0C50B485A43752FD.restrictions, _id_E2818AD39A3341B4.restrictions);

  if(istrue(_id_E2818AD39A3341B4._id_4B92043C00E4E91B)) {
    if(!vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_B9D5A379EB1AEFC7(seatid))
      restrictions[restrictions.size] = "vehicle_lean_out";
    else
      restrictions = scripts\engine\utility::_id_6D6AF8144A5131F1(restrictions, "melee");
  }

  if(vehicle _id_80D84F556CC8017A() && _id_1003E8D7C662A2FF(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), seatid))
    restrictions[restrictions.size] = "fire";

  return restrictions;
}

vehicle_shouldhideoccupantforseat(vehicle, seatid) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];

  if(isDefined(_id_0C50B485A43752FD.hideoccupant))
    return istrue(_id_0C50B485A43752FD.hideoccupant);
  else
    return istrue(_id_E2818AD39A3341B4.hideoccupant);
}

_id_0F3DB2E446C1457F(vehicle, seatid, player) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];
  return player _meth_793F941D7DFF15ED() && istrue(_id_0C50B485A43752FD.hidestowedweapon);
}

vehicle_getcameraforseat(vehicle, seatid) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(seatid)) {
    _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];
    camera = _id_E2818AD39A3341B4.camera;

    if(isDefined(_id_0C50B485A43752FD.camera))
      camera = _id_0C50B485A43752FD.camera;

    if(isDefined(_id_0C50B485A43752FD.animtag) && tolower(_id_0C50B485A43752FD.animtag) == "tag_seat_0")
      camera = "none";
  } else
    camera = "none";

  return camera;
}

vehicle_occupancy_getdamagemodifierforseat(vehicle, seatid) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  _id_0C50B485A43752FD = _id_E2818AD39A3341B4.seatdata[seatid];
  return scripts\engine\utility::ter_op(isDefined(_id_0C50B485A43752FD.damagemodifier), _id_0C50B485A43752FD.damagemodifier, _id_E2818AD39A3341B4.damagemodifier);
}

vehicle_occupancy_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor);

  if(meansofdeath == "MOD_TRIGGER_HURT")
    return 1;

  if(isDefined(objweapon) && objweapon.basename == "bomb_site_mp")
    return 1;

  if(victim scripts\cp_mp\utility\damage_utility::isstuckdamage(data))
    return 1;

  return 0;
}

_id_A3428466C78231B0(vehicle, player) {
  _id_0E03D4ECE8B05144 = vehicle.oobtriggers;
  _id_F79382813390150D = player.oobtriggers;

  if(isDefined(_id_0E03D4ECE8B05144)) {
    foreach(_id_934C5047D2A77AFD in _id_0E03D4ECE8B05144) {
      _id_5F699F50E6AAE59C = 1;

      if(isDefined(_id_F79382813390150D) && _id_F79382813390150D.size > 0)
        _id_5F699F50E6AAE59C = !scripts\engine\utility::array_contains(_id_F79382813390150D, _id_934C5047D2A77AFD);

      if(istrue(_id_5F699F50E6AAE59C)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onEnterOOBTrigger"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "onEnterOOBTrigger")]](_id_934C5047D2A77AFD, player, 1);
      }
    }
  }

  if(isDefined(_id_F79382813390150D)) {
    foreach(playertrigger in _id_F79382813390150D) {
      _id_5F699F50E6AAE59C = 0;

      if(!isDefined(_id_0E03D4ECE8B05144))
        _id_5F699F50E6AAE59C = 1;
      else if(!scripts\engine\utility::array_contains(_id_0E03D4ECE8B05144, playertrigger))
        _id_5F699F50E6AAE59C = 1;

      if(istrue(_id_5F699F50E6AAE59C)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onExitOOBTrigger"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "onExitOOBTrigger")]](playertrigger, player);
      }
    }
  }
}

vehicle_occupancy_monitoroccupant(vehicle, player, seatid) {
  thread vehicle_occupancy_monitorcontrols(vehicle, player, seatid);

  if(!istrue(level._id_15C7E6EC178FEEF1)) {
    thread vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, 1);
    thread vehicle_occupancy_monitorexit(vehicle, player, seatid);
  }

  thread vehicle_occupancy_monitorgameended(vehicle, player, seatid);
  thread _id_E02E15080A5F5FE4(vehicle, player);
}

vehicle_occupancy_stopmonitoringoccupant(player) {
  player notify("vehicle_occupancy_monitorControls");
  player notify("vehicle_occupancy_monitorSeatSwitch");
  player notify("vehicle_occupancy_monitorExit");
  player notify("vehicle_occupancy_monitorGameEnded");
  player notify("vehicle_occupancy_monitorLeanBlocked");
}

_id_E02E15080A5F5FE4(vehicle, player) {
  player notify("vehicle_occupancy_monitorLeanBlocked");
  player endon("vehicle_occupancy_monitorLeanBlocked");
  player endon("death_or_disconnect");
  player endon("last_stand_start");

  for(;;) {
    player scripts\engine\utility::waittill_any_2("vehicle_leanout_attempt_denied", "vehicle_leanout_forced_return");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("VEHICLES/LEAN_OUT_BLOCKED");
  }
}

vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, _id_36FF66C0883B5AA6) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  vehicle endon("death");
  level endon("game_ended");
  player notify("vehicle_occupancy_monitorSeatSwitch");
  player endon("vehicle_occupancy_monitorSeatSwitch");
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(_id_E2818AD39A3341B4.seatdata.size <= 1) {
    return;
  }
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(_id_0C50B485A43752FD.seatswitcharray) || _id_0C50B485A43752FD.seatswitcharray.size <= 0) {
    return;
  }
  if(!isbot(player)) {
    if(_id_36FF66C0883B5AA6)
      wait 0.2;

    while(player vehswitchseatbuttonPressed() || player _meth_5919151DD97650D2())
      waitframe();

    while(!player vehswitchseatbuttonPressed() && !player _meth_5919151DD97650D2() || istrue(player._id_EA02A8BFCFDE7C4B))
      waitframe();

    if(player _meth_5919151DD97650D2())
      _id_C0125690BC99343D = _id_795D10F52E5291CF(vehicle, player, seatid);
    else
      _id_C0125690BC99343D = vehicle_occupancy_getnextavailableseat(vehicle, player, seatid);

    if(isDefined(_id_C0125690BC99343D))
      thread vehicle_occupancy_enter(vehicle, _id_C0125690BC99343D, player);

    vehicle_occupancy_errormessage(player, scripts\engine\utility::ter_op(istrue(vehicle._id_065DA0A245B653CC), 3, 1));
    thread vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, 0);
  }
}

vehicle_occupancy_getnextavailableseat(vehicle, player, seatid) {
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(_id_0C50B485A43752FD.seatswitcharray) || _id_0C50B485A43752FD.seatswitcharray.size <= 0)
    return undefined;

  foreach(_id_C0125690BC99343D in _id_0C50B485A43752FD.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(vehicle, _id_C0125690BC99343D, player))
      return _id_C0125690BC99343D;
  }
}

_id_795D10F52E5291CF(vehicle, player, seatid) {
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(_id_0C50B485A43752FD.seatswitcharray) || _id_0C50B485A43752FD.seatswitcharray.size <= 0)
    return undefined;

  _id_1CE964595AADD958 = undefined;

  foreach(_id_C0125690BC99343D in _id_0C50B485A43752FD.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(vehicle, _id_C0125690BC99343D, player))
      _id_1CE964595AADD958 = _id_C0125690BC99343D;
  }

  return _id_1CE964595AADD958;
}

vehicle_occupancy_monitorexit(vehicle, player, seatid) {
  player notify("vehicle_occupancy_monitorExit");
  player endon("vehicle_occupancy_monitorExit");
  vehicle endon("death");
  level endon("game_ended");
  _id_FE757BF1A5D559B4 = vehicle_occupancy_monitorexitinternal(vehicle, player, seatid);
  data = spawnStruct();

  if(isDefined(player)) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive())
      data.playerdeath = 1;

    if(istrue(player.inlaststand))
      data.playerlaststand = 1;

    if(istrue(player._id_C4C8B91E0B16AA5E))
      data._id_D4B9AA76041AB0A9 = 1;
  } else
    data.playerdisconnect = 1;

  thread vehicle_occupancy_exit(vehicle, seatid, player, data, undefined, _id_FE757BF1A5D559B4);
}

_id_60631DCD9361C2B5(player) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player endon("enter_live_ragdoll");
  player endon("vehicle_occupancy_monitorExit");
  player waittill("live_ragdoll_vehicle_occupant_unlink");
  player._id_E86DA3427F911D75 = 1;
  player notify("vehicle_occupant_unlink_processed");
}

vehicle_occupancy_monitorexitinternal(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player endon("enter_live_ragdoll");
  player endon("vehicle_occupant_unlink_processed");
  thread _id_60631DCD9361C2B5(player);
  endtime = gettime() + 300;
  _id_B28ED4C7D2FF1C4E = 0;
  _id_C08D88C04569A00B = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_C08D88C04569A00B;
  _id_6511893609889B7A = istrue(level._id_351AAB391DA578A8) && isDefined(_id_C08D88C04569A00B) && _id_C08D88C04569A00B == "stand_up";
  _id_7A888FDBA3DFB003 = istrue(level._id_351AAB391DA578A8) && isDefined(_id_C08D88C04569A00B) && (_id_C08D88C04569A00B == "stand_up" || player _meth_46CA2675C0578280());
  _id_EDC035EC125029EB = istrue(level._id_073D6C6366970020);
  player setclientomnvar("ui_veh_exit_button_holdtime", 0);

  for(;;) {
    if(!player useButtonPressed())
      _id_B28ED4C7D2FF1C4E = 1;

    if(_id_B28ED4C7D2FF1C4E && gettime() >= endtime) {
      break;
    }

    waitframe();
  }

  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_33193F537B85B6D4 = getdvarint("bg_useholdtimeshort", 250) / 1000;
  _id_0B24CF95B8CF123C = 0;
  _id_7F08BBC709D0EFFC = undefined;

  for(;;) {
    _id_23B90B34FECC58CD = 0;
    _id_930201649EAF32AF = player getcurrentusereloadconfig();
    _id_556640F47976049A = 0;
    player setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(player useButtonPressed()) {
      player disablereloading();
      player cancelreloading();
      _id_556640F47976049A = 1;
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;
      _id_86EB80FF19554B0C = player usinggamepad();
      _id_B97750D9099A9B79 = player getuseholdkbmprofile();
      _id_73780D1B420D7903 = !_id_86EB80FF19554B0C && !_id_B97750D9099A9B79;
      _id_CAAA0275D82BFEE1 = !_id_86EB80FF19554B0C && _id_B97750D9099A9B79;
      _id_8B3C790F008214A9 = _id_86EB80FF19554B0C && _id_930201649EAF32AF == 0;
      _id_97E758980ADD17EF = _id_86EB80FF19554B0C && _id_930201649EAF32AF > 0;
      _id_41BD24E292FB94E0 = _id_8B3C790F008214A9 || _id_CAAA0275D82BFEE1;

      if(_id_8B3C790F008214A9 || _id_CAAA0275D82BFEE1)
        player setclientomnvar("ui_veh_exit_button_holdtime", _id_23B90B34FECC58CD / 0.3);

      if(_id_41BD24E292FB94E0 && _id_23B90B34FECC58CD > 0.3 || _id_73780D1B420D7903)
        return scripts\engine\utility::ter_op(_id_EDC035EC125029EB && player _meth_A7DE57196F4B5D16() && vehicle vehicle_getspeed() > 10, "_to_dive", undefined);
      else if(_id_97E758980ADD17EF && _id_23B90B34FECC58CD >= _id_33193F537B85B6D4) {
        player enablereloading();
        player forcereloading();
      }

      wait(_id_038FC7BD1495C4B2);
    }

    if(_id_556640F47976049A && player usinggamepad() && _id_930201649EAF32AF > 0 && _id_23B90B34FECC58CD < _id_33193F537B85B6D4)
      return scripts\engine\utility::ter_op(_id_EDC035EC125029EB && player _meth_A7DE57196F4B5D16() && vehicle vehicle_getspeed() > 10, "_to_dive", undefined);
    else if(_id_556640F47976049A) {
      player enablereloading();
      player forcereloading();
    }

    if(_id_7A888FDBA3DFB003) {
      _id_0B24CF95B8CF123C = _id_0B24CF95B8CF123C | player jumpbuttonPressed();

      if(player jumpbuttonPressed())
        _id_7F08BBC709D0EFFC = gettime();
      else if(_id_0B24CF95B8CF123C && isDefined(_id_7F08BBC709D0EFFC) && _id_7F08BBC709D0EFFC + 400 < gettime())
        _id_0B24CF95B8CF123C = 0;

      if(_id_0B24CF95B8CF123C && !player _meth_E1B085052385D056() && (player _meth_46CA2675C0578280() || _id_6511893609889B7A))
        return "_to_roof";
    }

    waitframe();
  }
}

vehicle_occupancy_errormessage(player, _id_5B67BCF1FFFA8112) {
  _id_4A939FF1F2CAED40 = undefined;

  switch (_id_5B67BCF1FFFA8112) {
    case 1:
      _id_4A939FF1F2CAED40 = "VEHICLES/SEAT_SWITCH_OCCUPIED";
      break;
    case 2:
      _id_4A939FF1F2CAED40 = "VEHICLES/CANNOT_EXIT";
      break;
    case 3:
      _id_4A939FF1F2CAED40 = "VEHICLES/GRENADE_TURRET_LOCKED";
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_4A939FF1F2CAED40);
}

vehicle_occupancy_monitorgameended(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player notify("vehicle_occupancy_monitorGameEnded");
  player endon("vehicle_occupancy_monitorGameEnded");

  if(seatid == vehicle_occupancy_getdriverseat(vehicle)) {
    level waittill("game_ended");
    player allowmovement(0);
  }
}

vehicle_occupancy_monitorcontrols(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  vehicle endon("death");
  level endon("game_ended");
  player notify("vehicle_occupancy_monitorControls");
  player endon("vehicle_occupancy_monitorControls");

  if(scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_controlsarefadedoutorhidden(player)) {
    return;
  }
  if(1)
    wait 1.5;

  childthread vehicle_occupancy_monitormovementcontrols(vehicle, player, seatid);
  childthread vehicle_occupancy_monitorturretcontrols(vehicle, player, seatid);
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(_id_E2818AD39A3341B4.monitorcontrolscallback))
    childthread[[_id_E2818AD39A3341B4.monitorcontrolscallback]](vehicle, player, seatid, "vehicle_occupancy_monitorControls");
}

vehicle_occupancy_fadeoutcontrols(player) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_fadeoutcontrols(player);
  player notify("vehicle_occupancy_monitorControls");
}

vehicle_occupancy_monitormovementcontrols(vehicle, player, seatid) {
  driverseatid = vehicle_occupancy_getdriverseat(vehicle);

  if(seatid == driverseatid) {
    canfly = vehicle scripts\cp_mp\vehicles\vehicle::vehiclecanfly();

    if(canfly) {
      for(;;) {
        forward = vehicle vehicle_getinputvalue(0);
        _id_96B5B2F64547BA5E = vehicle vehicle_getinputvalue(2);
        strafe = vehicle vehicle_getinputvalue(1);
        _id_510E41AFAD57494B = vehicle vehicle_getinputvalue(3);

        if(abs(forward) > 0 || abs(_id_96B5B2F64547BA5E) > 0 || abs(strafe) > 0 || abs(_id_510E41AFAD57494B) > 0)
          vehicle_occupancy_fadeoutcontrols(player);

        wait 0.05;
      }
    } else {
      for(;;) {
        _id_B9E1E30F0AC5AA82 = vehicle vehicle_getinputvalue(4);

        if(abs(_id_B9E1E30F0AC5AA82) >= 0.2)
          vehicle_occupancy_fadeoutcontrols(player);

        wait 0.05;
      }
    }
  }
}

vehicle_occupancy_monitorturretcontrols(vehicle, player, seatid) {
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(isDefined(_id_0C50B485A43752FD.turretobjweapon)) {
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, _id_0C50B485A43752FD.turretobjweapon);

    if(isDefined(turret)) {
      turret scripts\engine\utility::waittill_any_2("turret_fire", "turret_reload");
      vehicle_occupancy_fadeoutcontrols(player);
    }
  }
}

vehicle_occupancy_raceplayerdeathdisconnect(player, data) {
  data endon(data.raceendon);
  result = player scripts\engine\utility::waittill_any_return_no_endon_death_5("death", "disconnect", "last_stand_start", "enter_live_ragdoll", "interrupt_roof_exit");

  if(result == "death")
    data.playerdeath = 1;
  else if(result == "disconnect")
    data.playerdisconnect = 1;
  else if(result == "last_stand_start")
    data.playerlaststand = 1;
  else if(result == "enter_live_ragdoll")
    data._id_D4B9AA76041AB0A9 = 1;
  else if(result == "interrupt_roof_exit")
    data._id_F276D4E53593EC9A = 1;

  data notify(data.raceendnotify);
}

vehicle_occupancy_racevehicledeath(vehicle, data) {
  data endon(data.raceendon);
  vehicle waittill("death");
  data.vehicledeath = 1;
  data notify(data.raceendnotify);
}

vehicle_occupancy_raceseatunavailable(vehicle, player, seatid, _id_FC7C7A874B43A31A, data) {
  data endon(data.raceendon);

  while(isDefined(vehicle)) {
    if(!vehicle_occupancy_seatisavailable(vehicle, seatid, player)) {
      data.seatunavailable = 1;
      data notify(data.raceendnotify);
      break;
    }

    waitframe();
  }
}

vehicle_occupancy_racecomplete(_id_FC7C7A874B43A31A, _id_7558F98F3236963D, data) {
  data endon(data.raceendon);

  if(isDefined(_id_FC7C7A874B43A31A) && isDefined(_id_7558F98F3236963D)) {
    while(!istrue(data.enterstartcomplete) || !istrue(data.exitstartcomplete))
      waitframe();
  } else if(isDefined(_id_FC7C7A874B43A31A)) {
    while(!istrue(data.exitstartcomplete))
      waitframe();
  } else {
    while(!istrue(data.enterstartcomplete))
      waitframe();
  }

  data notify(data.raceendnotify);
}

vehicle_occupancy_raceresults(vehicle, player, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, data) {
  if(!isDefined(data.success))
    data.success = 1;

  if(data.immediate) {
    data.playerdisconnect = scripts\engine\utility::ter_op(isDefined(player), 0, 1);

    if(!data.playerdisconnect) {
      data.playerdeath = !player scripts\cp_mp\utility\player_utility::_isalive();
      data.playerlaststand = istrue(player.inlaststand);
      data._id_D4B9AA76041AB0A9 = istrue(player._id_C4C8B91E0B16AA5E);
    }

    data.vehicledeath = istrue(vehicle.isdestroyed);
  } else if(data.success) {
    if(isDefined(_id_FC7C7A874B43A31A) && !istrue(data.exitstartcomplete))
      data.success = 0;

    if(isDefined(_id_7558F98F3236963D) && !istrue(data.enterstartcomplete))
      data.success = 0;

    if(istrue(data.vehicledeath))
      data.success = 0;

    if(istrue(data._id_F276D4E53593EC9A))
      data.success = 0;
  } else
    return 0;

  if(isDefined(_id_7558F98F3236963D)) {
    if(istrue(data.playerdeath) || istrue(data._id_D4B9AA76041AB0A9) || istrue(data.playerlaststand) || istrue(data.playerdisconnect) || istrue(data.vehicledeath) || istrue(data.seatunavailable))
      data.success = 0;
  } else {}

  return data.success;
}

vehicle_occupancy_watchowner(vehicle, player, _id_57C14BF60C5BE4AB, _id_13CC810B9974360E) {
  player endon("disconnect");
  vehicle endon("death");
  vehicle endon("vehicle_clear_owner_" + player getentitynumber());

  if(istrue(_id_57C14BF60C5BE4AB))
    player waittill("vehicle_seat_exit");

  _id_F86FB0E66B52EA3B = scripts\engine\utility::ter_op(isDefined(_id_13CC810B9974360E), _id_13CC810B9974360E, 20);
  wait(_id_F86FB0E66B52EA3B);
  thread vehicle_occupancy_clearowner(vehicle, player);
}

vehicle_occupancy_watchownerjoinedteam(vehicle, player) {
  player endon("disconnect");
  vehicle endon("death");
  vehicle endon("vehicle_owner_update");
  player scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread vehicle_occupancy_updateowner(vehicle);
}

vehicle_occupancy_isplayervalidowner(vehicle, player) {
  if(!isDefined(player))
    return 0;

  if(level.teambased && isDefined(vehicle.team)) {
    if(vehicle.team != "neutral" && player.team != vehicle.team)
      return 0;
  } else if(isDefined(vehicle.originalowner)) {
    if(player != vehicle.originalowner)
      return 0;
  }

  return 1;
}

vehicle_occupancy_animateplayer(vehicle, seatid, _id_FC7C7A874B43A31A, _id_D5CC8B378F09BD04, _id_D65FF23EFE3B8AA9, _id_3F9690FB0C8EBC84) {
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(_id_0C50B485A43752FD.animtag)) {
    return;
  }
  if(isDefined(_id_D65FF23EFE3B8AA9) || isDefined(_id_3F9690FB0C8EBC84)) {
    _id_D1C52700CB7DDBF3(_id_D65FF23EFE3B8AA9, _id_3F9690FB0C8EBC84);
    thread _id_233275857335E4DC(1);
  }

  self cancelmantle();
  _id_F5724E9559001550 = 0;
  _id_C39487B3181A24DC = _id_0C50B485A43752FD.animtag;

  if(issubstr(_id_C39487B3181A24DC, "tag_seat_"))
    _id_F5724E9559001550 = int(getsubstr(_id_C39487B3181A24DC, 9));
  else if(issubstr(_id_C39487B3181A24DC, "gunner_"))
    _id_F5724E9559001550 = int(getsubstr(_id_C39487B3181A24DC, 7)) + 10 - 1;

  _id_A578A00ADA66FAA3 = !isDefined(seatid);
  _id_C9B87BEB89EC12E2(self, vehicle, _id_A578A00ADA66FAA3);
  _id_21B63BA00FE0B7E3 = !isDefined(_id_FC7C7A874B43A31A) && isDefined(seatid);
  _id_60871098A5B9C669 = self usevehicle(vehicle, _id_F5724E9559001550, _id_21B63BA00FE0B7E3);

  if(istrue(_id_60871098A5B9C669) && vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_452936099DCD1B94(seatid))
    vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_14219D4C7D83499F(seatid);
}

_id_D1C52700CB7DDBF3(type, seat) {
  self notify("OverrideVehicleSeatAnimConditionals");
  self overridevehicleseatanimconditionals(type, seat);
}

_id_233275857335E4DC(_id_CE091DA20E3C7335) {
  self endon("death_or_disconnect");
  self notify("OverrideVehicleSeatAnimConditionals");
  self endon("OverrideVehicleSeatAnimConditionals");

  if(istrue(_id_CE091DA20E3C7335))
    waitframe();

  self overridevehicleseatanimconditionals("", 0);
}

_id_EE4B8B879B1B120C() {
  if(istrue(self.isheli) && self getscriptablehaspart("Exhaust"))
    self setscriptablepartstate("Exhaust", "off");
}

_id_BA42CF4E5BB24367() {
  _id_3E9C60D3D2B4ED07 = self getscriptablehaspart("Exhaust");
  _id_57638606B57E8776 = self getscriptablehaspart("NaviLights");

  if(!_id_3E9C60D3D2B4ED07 && !_id_57638606B57E8776) {
    return;
  }
  self endon("death");
  self notify("stopHeliEffectsAfterTime");
  self endon("stopHeliEffectsAfterTime");
  self._id_19169DA06F71A4F2 = "waitingToTurnOff";
  wait 6;

  while(istrue(self.ishovering))
    wait 2;

  if(!isDefined(self._id_19169DA06F71A4F2) || self._id_19169DA06F71A4F2 != "waitingToTurnOff") {
    return;
  }
  self._id_19169DA06F71A4F2 = undefined;

  if(_id_3E9C60D3D2B4ED07 && self getscriptablepartstate("Exhaust") == "on")
    self setscriptablepartstate("Exhaust", "off");

  if(_id_57638606B57E8776 && self getscriptablepartstate("NaviLights") == "on")
    self setscriptablepartstate("NaviLights", "off");
}

_id_A91927DF280E94E4() {
  if(!isDefined(self._id_19169DA06F71A4F2)) {
    if(self getscriptablehaspart("Exhaust") && scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate() == "pristine" && (!isDefined(self._id_CF9BA498AF4E41E9) || self._id_CF9BA498AF4E41E9 > 0))
      self setscriptablepartstate("Exhaust", "on");

    if(self getscriptablehaspart("NaviLights"))
      self setscriptablepartstate("NaviLights", "on");
  }

  self._id_19169DA06F71A4F2 = "playing";
}

_id_4E7868EF633F4B36() {
  self endon("death");
  self endon("unanchored");

  while(self vehicle_getspeed() > 2)
    wait 0.2;

  self _meth_481C2A63F2BA3332(-1, 100);
}

_id_3112242E4BC392DE() {
  self notify("unanchored");
  self _meth_481C2A63F2BA3332(0);
}

_id_A1A583C3CC871645(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self._id_AB34D06670D41495--;

    if(self._id_AB34D06670D41495 == 0) {
      self._id_AB34D06670D41495 = undefined;

      foreach(_id_F85572CD5F6117C6 in _id_F6CB37189C84811B())
      _id_F85572CD5F6117C6 _id_3B64EB40368C1450::set("vehicle_occupant", "fire", 1);

      if(isDefined(self._id_3A442282FB9074E1)) {
        foreach(_id_F85572CD5F6117C6 in self._id_3A442282FB9074E1)
        _id_F85572CD5F6117C6 _id_3B64EB40368C1450::set("vehicle_turret", "fire", 1);
      }
    }
  } else {
    if(!isDefined(self._id_AB34D06670D41495))
      self._id_AB34D06670D41495 = 0;

    self._id_AB34D06670D41495++;

    if(self._id_AB34D06670D41495 == 1) {
      foreach(_id_F85572CD5F6117C6 in _id_F6CB37189C84811B())
      _id_F85572CD5F6117C6 _id_3B64EB40368C1450::set("vehicle_occupant", "fire", 0);

      if(isDefined(self._id_3A442282FB9074E1)) {
        foreach(_id_F85572CD5F6117C6 in self._id_3A442282FB9074E1)
        _id_F85572CD5F6117C6 _id_3B64EB40368C1450::set("vehicle_turret", "fire", 0);
      }
    }
  }
}

_id_80D84F556CC8017A() {
  return isDefined(self) && isDefined(self._id_AB34D06670D41495) && self._id_AB34D06670D41495 > 0;
}

_id_F6CB37189C84811B() {
  _id_7731ADEF63E19B0C = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_FF131BCD82FF52D9 = [];

  foreach(seatid in vehicle_occupancy_getallvehicleseats(self)) {
    if(_id_1003E8D7C662A2FF(_id_7731ADEF63E19B0C, seatid)) {
      _id_F85572CD5F6117C6 = vehicle_occupancy_getseatoccupant(self, seatid, 0);

      if(isDefined(_id_F85572CD5F6117C6) && isPlayer(_id_F85572CD5F6117C6))
        _id_FF131BCD82FF52D9[_id_FF131BCD82FF52D9.size] = _id_F85572CD5F6117C6;
    }
  }

  return _id_FF131BCD82FF52D9;
}

_id_1003E8D7C662A2FF(_id_7731ADEF63E19B0C, seatid) {
  seatdata = vehicle_occupancy_getleveldataforseat(_id_7731ADEF63E19B0C, seatid);
  return isDefined(seatdata) && istrue(seatdata._id_4C78BDF78D543129);
}

_id_F654C168752ED299() {
  return isDefined(self) && self vehicle_isphysveh() && self _meth_76FA53E72547FF02();
}

vehicle_occupancy_allowmovement(vehicle, _id_E3108E412AFB3811, _id_FFB36A4B82C7AD04, _id_F4942F1848B5B6CA) {
  if(_id_E3108E412AFB3811) {
    vehicle.movementdisabled--;

    if(vehicle.movementdisabled == 0) {
      occupants = _id_0EFA75AA7F0A1289(vehicle);

      if(isDefined(occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("movementDisabled", occupants, vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

        if(vehicle _meth_01E8542A707A8002("p2p"))
          vehicle _meth_77320E794D35465A("p2p", "resume", 1);

        if(vehicle _id_F654C168752ED299())
          vehicle _meth_64D8AE560C3EC9B6(0);
        else {
          foreach(seatid, _id_F85572CD5F6117C6 in vehicle.occupants)
          vehicle_occupancy_allowmovementplayer(vehicle, _id_F85572CD5F6117C6, 1, seatid);
        }
      }

      return 1;
    }
  } else {
    if(!isDefined(vehicle.movementdisabled))
      vehicle.movementdisabled = 0;

    vehicle.movementdisabled++;

    if(vehicle.movementdisabled == 1) {
      occupants = _id_0EFA75AA7F0A1289(vehicle);

      if(isDefined(occupants)) {
        if(!isDefined(_id_FFB36A4B82C7AD04) || _id_FFB36A4B82C7AD04 == 1)
          scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("movementDisabled", occupants, vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

        if(vehicle _meth_01E8542A707A8002("p2p") && !istrue(_id_F4942F1848B5B6CA))
          vehicle _meth_77320E794D35465A("p2p", "pause", 1);

        if(vehicle _id_F654C168752ED299()) {
          vehicle _meth_64D8AE560C3EC9B6(1);
          vehicle.veh_throttle = 0;
        } else {
          foreach(seatid, _id_F85572CD5F6117C6 in vehicle.occupants)
          vehicle_occupancy_allowmovementplayer(vehicle, _id_F85572CD5F6117C6, 0, seatid);
        }
      }

      return 0;
    }
  }
}

vehicle_occupancy_clearallowmovement(vehicle) {
  if(vehicle _id_F654C168752ED299())
    vehicle _meth_64D8AE560C3EC9B6(0);
  else if(isDefined(vehicle.occupants)) {
    foreach(seatid, _id_F85572CD5F6117C6 in vehicle.occupants)
    vehicle_occupancy_allowmovementplayer(1, _id_F85572CD5F6117C6, seatid);
  }

  vehicle.movementdisabled = undefined;
}

vehicle_occupancy_allowmovementplayer(vehicle, player, _id_E3108E412AFB3811, seatid) {
  if(_id_E3108E412AFB3811) {
    if(istrue(player.vehicledisabledmovement)) {
      if(player scripts\cp_mp\utility\player_utility::_isalive())
        player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupancy");

      player.vehicledisabledmovement = undefined;
    }
  } else {
    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

    if(isDefined(_id_0C50B485A43752FD.animtag) && _id_0C50B485A43752FD.animtag == "tag_seat_0") {
      if(!istrue(player.vehicledisabledmovement)) {
        if(player scripts\cp_mp\utility\player_utility::_isalive()) {
          player _id_3B64EB40368C1450::set("vehicle_occupancy", "allow_movement", 0);
          player.vehicledisabledmovement = 1;
        }
      }
    }
  }
}

vehicle_occupancy_clearallowmovementplayer(player, _id_FCEF8D217A441961) {
  if(!istrue(_id_FCEF8D217A441961) && istrue(player.vehicledisabledmovement))
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupancy");

  player.vehicledisabledmovement = undefined;
}

vehicle_occupancy_movementisallowed(vehicle) {
  return !isDefined(vehicle.movementdisabled) || vehicle.movementdisabled <= 0;
}

_id_AC0A3326D43EB8FD() {
  vehicle_occupancy_allowmovement(self, 0, 0);
  _id_D0092C44C5588870();

  if(self vehicle_isphysveh())
    self _meth_65AA053C077C003A(1);

  self.islocked = 1;
  occupants = _id_0EFA75AA7F0A1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("locked", occupants, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
}

_id_474237292E64417E() {
  vehicle_occupancy_allowmovement(self, 1, 0);
  _id_7C81E0D41CBBCE7F();
  _id_9E710C9F3A15FFDA();

  if(self vehicle_isphysveh())
    self _meth_65AA053C077C003A(0);

  self.islocked = undefined;
  occupants = _id_0EFA75AA7F0A1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("locked", occupants, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
}

_id_72F871BF74995298() {
  return isDefined(self) && istrue(self.islocked);
}

vehicle_occupancy_getexitpositionandangles(vehicle, player, seatid, allowairexit, _id_732C1A4DD3A04513, _id_FE757BF1A5D559B4) {
  exitboundinginfo = _id_517F60905F08BF96(vehicle);
  _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), seatid);
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(isDefined(_id_FE757BF1A5D559B4)) {
    _id_5580F4007EC05FC4 = seatid + _id_FE757BF1A5D559B4;
    _id_2B16A165170D3506 = _id_E2818AD39A3341B4.exitdirections[_id_5580F4007EC05FC4];
    position = vehicle_occupancy_getexitposition(vehicle, player, _id_5580F4007EC05FC4, exitboundinginfo, 1);

    if(isDefined(position)) {
      angles = undefined;

      if(!isDefined(_id_0C50B485A43752FD.animtag) || _id_0C50B485A43752FD.animtag != "tag_seat_0")
        angles = vehicle_occupancy_getexitangles(vehicle, player, _id_5580F4007EC05FC4, _id_732C1A4DD3A04513);

      if(_id_FE757BF1A5D559B4 == "_to_roof")
        player notify("roof_exit");

      return [position, angles, _id_FE757BF1A5D559B4, _id_2B16A165170D3506];
    }
  }

  _id_21D45F646111D24F = 0;

  foreach(_id_11C87FAEC6F85F74 in _id_0C50B485A43752FD.exitids) {
    _id_5580F4007EC05FC4 = _id_11C87FAEC6F85F74._id_2B16A165170D3506;
    _id_2B16A165170D3506 = _id_E2818AD39A3341B4.exitdirections[_id_5580F4007EC05FC4];

    if(_id_2B16A165170D3506 == "roof" || _id_2B16A165170D3506 == "dive") {
      continue;
    }
    position = vehicle_occupancy_getexitposition(vehicle, player, _id_5580F4007EC05FC4, exitboundinginfo, allowairexit);

    if(isDefined(position)) {
      angles = undefined;

      if(!isDefined(_id_0C50B485A43752FD.animtag) || _id_0C50B485A43752FD.animtag != "tag_seat_0")
        angles = vehicle_occupancy_getexitangles(vehicle, player, _id_5580F4007EC05FC4, _id_732C1A4DD3A04513);

      return [position, angles, undefined, _id_2B16A165170D3506];
    }
  }

  if(getdvarint("dvar_9C95C78D2EFCA328", 1) == 1) {
    position = _id_CA069B5427D4FF47(vehicle, player);

    if(isDefined(position))
      return [position, undefined, undefined, "front"];
  }

  return undefined;
}

vehicle_occupancy_getexitposition(vehicle, player, _id_5580F4007EC05FC4, _id_1D7A120A5DF60069, allowairexit) {
  if(!isDefined(vehicle) || !isDefined(player) || !isDefined(_id_5580F4007EC05FC4)) {
    return;
  }
  data = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(!isDefined(data)) {
    return;
  }
  if(istrue(_id_1D7A120A5DF60069.exitsfailed[_id_5580F4007EC05FC4])) {
    return;
  }
  if(isDefined(_id_1D7A120A5DF60069.exitpositions[_id_5580F4007EC05FC4]))
    return _id_1D7A120A5DF60069.exitpositions[_id_5580F4007EC05FC4];

  if(!isDefined(data.exitoffsets[_id_5580F4007EC05FC4])) {
    return;
  }
  if(!isDefined(data.exitdirections[_id_5580F4007EC05FC4])) {
    return;
  }
  _id_7862C7C7ADE2B42E = data.exitoffsets[_id_5580F4007EC05FC4];
  _id_2B16A165170D3506 = data.exitdirections[_id_5580F4007EC05FC4];

  if(_id_2B16A165170D3506 == "roof" && data._id_C08D88C04569A00B == "animated") {
    exitposition = vehicle.origin + rotatevector(_id_7862C7C7ADE2B42E, vehicle.angles);
    _id_1D7A120A5DF60069.exitpositions[_id_5580F4007EC05FC4] = exitposition;
    return exitposition;
  }

  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip"]);
  ignorelist = [];

  foreach(ent in vehicle getlinkedchildren(1)) {
    if(!isPlayer(ent))
      ignorelist[ignorelist.size] = ent;
  }

  ignorelist[ignorelist.size] = vehicle;
  ignorelist[ignorelist.size] = player;

  if(_id_2B16A165170D3506 == "inside" || _id_2B16A165170D3506 == "dive" || _id_2B16A165170D3506 == "roof" || _id_2B16A165170D3506 == "top") {
    caststart = vehicle.origin + rotatevector(_id_7862C7C7ADE2B42E, vehicle.angles);
    castend = caststart;
    castend = _id_FE33F8F45B65696E(player, caststart, castend, ignorelist, allowairexit, _id_2B16A165170D3506);

    if(!isDefined(castend)) {
      _id_1D7A120A5DF60069.exitsfailed[_id_5580F4007EC05FC4] = 1;
      return;
    }

    _id_1D7A120A5DF60069.exitpositions[_id_5580F4007EC05FC4] = castend;
    return castend;
  }

  _id_385F836BD472CC20 = scripts\engine\utility::ter_op(vehicle tagexists("tag_body_animate"), "tag_body_animate", "tag_body");
  center = vehicle gettagorigin(_id_385F836BD472CC20);
  _id_B80302A5D53248B7 = scripts\engine\math::anglebetweenvectors(anglestoup(vehicle.angles), (0, 0, 1)) > 90;
  _id_6FD2732998D97E6D = 16;
  _id_A42954201627527E = 0;
  _id_3F21644696AD05F6 = 0;

  switch (_id_2B16A165170D3506) {
    case "front":
      _id_0566B4A8C9324219 = vehicle.angles[0];

      if(_id_0566B4A8C9324219 == 90 || _id_0566B4A8C9324219 == 270)
        _id_33C8684FB7C8588D = 1;
      else
        _id_33C8684FB7C8588D = tan(_id_0566B4A8C9324219);

      _id_3F21644696AD05F6 = _id_33C8684FB7C8588D > 0;

      if(_id_3F21644696AD05F6) {
        _id_A42954201627527E = _id_A42954201627527E + abs(sin(_id_0566B4A8C9324219)) * (data.exitextents["front"] + 16);
        _id_3E656678779CC7E9 = data.exitextents["front"] + abs(_id_33C8684FB7C8588D) * data.exitextents["top"];
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + abs(cos(_id_0566B4A8C9324219) * _id_3E656678779CC7E9);
        _id_7862C7C7ADE2B42E = (max(_id_7862C7C7ADE2B42E[0], _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[1], _id_7862C7C7ADE2B42E[2]);
      } else {
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + min(abs(_id_33C8684FB7C8588D), 1) * (data.exitextents["bottom"] + 10);
        _id_7862C7C7ADE2B42E = (max(_id_7862C7C7ADE2B42E[0], data.exitextents["front"] + _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[1], _id_7862C7C7ADE2B42E[2]);
      }

      break;
    case "back":
      _id_0566B4A8C9324219 = vehicle.angles[0];

      if(_id_0566B4A8C9324219 == 90 || _id_0566B4A8C9324219 == 270)
        _id_33C8684FB7C8588D = 1;
      else
        _id_33C8684FB7C8588D = tan(_id_0566B4A8C9324219);

      _id_3F21644696AD05F6 = _id_33C8684FB7C8588D < 0;

      if(_id_3F21644696AD05F6) {
        _id_A42954201627527E = _id_A42954201627527E + abs(sin(_id_0566B4A8C9324219)) * (data.exitextents["back"] + 16);
        _id_3E656678779CC7E9 = data.exitextents["back"] + abs(_id_33C8684FB7C8588D) * data.exitextents["top"];
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + abs(cos(_id_0566B4A8C9324219) * _id_3E656678779CC7E9);
        _id_7862C7C7ADE2B42E = (min(_id_7862C7C7ADE2B42E[0], -1 * _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[1], _id_7862C7C7ADE2B42E[2]);
      } else {
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + min(abs(_id_33C8684FB7C8588D), 1) * (data.exitextents["bottom"] + 10);
        _id_7862C7C7ADE2B42E = (min(_id_7862C7C7ADE2B42E[0], -1 * (data.exitextents["back"] + _id_6FD2732998D97E6D)), _id_7862C7C7ADE2B42E[1], _id_7862C7C7ADE2B42E[2]);
      }

      break;
    case "left":
      _id_0566B4A8C9324219 = vehicle.angles[2];

      if(_id_0566B4A8C9324219 == 90 || _id_0566B4A8C9324219 == 270)
        _id_33C8684FB7C8588D = 1;
      else
        _id_33C8684FB7C8588D = tan(_id_0566B4A8C9324219);

      _id_3F21644696AD05F6 = _id_33C8684FB7C8588D < 0;

      if(_id_3F21644696AD05F6) {
        _id_A42954201627527E = _id_A42954201627527E + abs(sin(_id_0566B4A8C9324219)) * (data.exitextents["left"] + 16);
        _id_3E656678779CC7E9 = data.exitextents["left"] + abs(_id_33C8684FB7C8588D) * data.exitextents["top"];
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + abs(cos(_id_0566B4A8C9324219)) * _id_3E656678779CC7E9;
        _id_7862C7C7ADE2B42E = (_id_7862C7C7ADE2B42E[0], max(_id_7862C7C7ADE2B42E[1], _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[2]);
      } else {
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + min(abs(_id_33C8684FB7C8588D), 1) * (data.exitextents["bottom"] + 10);
        _id_7862C7C7ADE2B42E = (_id_7862C7C7ADE2B42E[0], max(_id_7862C7C7ADE2B42E[1], data.exitextents["left"] + _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[2]);
      }

      break;
    case "right":
      _id_0566B4A8C9324219 = vehicle.angles[2];

      if(_id_0566B4A8C9324219 == 90 || _id_0566B4A8C9324219 == 270)
        _id_33C8684FB7C8588D = 1;
      else
        _id_33C8684FB7C8588D = tan(_id_0566B4A8C9324219);

      _id_3F21644696AD05F6 = _id_33C8684FB7C8588D > 0;

      if(_id_3F21644696AD05F6) {
        _id_A42954201627527E = _id_A42954201627527E + abs(sin(_id_0566B4A8C9324219)) * (data.exitextents["right"] + 16);
        _id_3E656678779CC7E9 = data.exitextents["right"] + abs(_id_33C8684FB7C8588D) * data.exitextents["top"];
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + abs(cos(_id_0566B4A8C9324219)) * _id_3E656678779CC7E9;
        _id_7862C7C7ADE2B42E = (_id_7862C7C7ADE2B42E[0], min(_id_7862C7C7ADE2B42E[1], -1 * _id_6FD2732998D97E6D), _id_7862C7C7ADE2B42E[2]);
      } else {
        _id_6FD2732998D97E6D = _id_6FD2732998D97E6D + min(abs(_id_33C8684FB7C8588D), 1) * (data.exitextents["bottom"] + 10);
        _id_7862C7C7ADE2B42E = (_id_7862C7C7ADE2B42E[0], min(_id_7862C7C7ADE2B42E[1], -1 * (data.exitextents["right"] + _id_6FD2732998D97E6D)), _id_7862C7C7ADE2B42E[2]);
      }

      break;
  }

  angles = scripts\engine\utility::ter_op(_id_3F21644696AD05F6, (0, vehicle.angles[1], 0), vehicle.angles);
  _id_7862C7C7ADE2B42E = center + rotatevector((_id_7862C7C7ADE2B42E[0], _id_7862C7C7ADE2B42E[1], 10), angles);

  if(_id_B80302A5D53248B7)
    _id_7862C7C7ADE2B42E = _id_7862C7C7ADE2B42E + (0, 0, 20);

  if(!isDefined(_id_1D7A120A5DF60069._id_E076F493B3F213D9))
    _id_1D7A120A5DF60069._id_E076F493B3F213D9 = 16;

  _id_E076F493B3F213D9 = _id_1D7A120A5DF60069._id_E076F493B3F213D9;
  _id_0145D0DC29D9BDE7 = physics_spherecast(center, _id_7862C7C7ADE2B42E, _id_E076F493B3F213D9, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1);

  if(isDefined(_id_0145D0DC29D9BDE7) && istrue(_id_0145D0DC29D9BDE7[1])) {
    if(_id_1D7A120A5DF60069._id_E076F493B3F213D9 == 16)
      _id_1D7A120A5DF60069._id_E076F493B3F213D9 = 10;
    else
      _id_1D7A120A5DF60069._id_E076F493B3F213D9 = 5;
  }

  if(isDefined(_id_0145D0DC29D9BDE7) && (istrue(_id_0145D0DC29D9BDE7[1]) || isDefined(_id_0145D0DC29D9BDE7[0]) && isDefined(_id_0145D0DC29D9BDE7[0][0]) && isDefined(_id_0145D0DC29D9BDE7[0][0]["position"])))
    _id_1D7A120A5DF60069.exitsfailed[_id_5580F4007EC05FC4] = 1;
  else {
    _id_CB94032C1755440C = _id_7862C7C7ADE2B42E + (0, 0, 72);
    _id_2C105CD38617BCCF = physics_raycast(_id_7862C7C7ADE2B42E, _id_CB94032C1755440C, contents, ignorelist, 0, "physicsquery_closest", 1);

    if(isDefined(_id_2C105CD38617BCCF) && isDefined(_id_2C105CD38617BCCF[0]) && isDefined(_id_2C105CD38617BCCF[0]["position"]))
      _id_CB94032C1755440C = _id_2C105CD38617BCCF[0]["position"];

    _id_5D1981EAB4B950F0 = _id_CB94032C1755440C - (0, 0, 82);
    _id_DF0E1A73DC741251 = _id_CB94032C1755440C - (0, 0, data.exitextents["bottom"] + 125 + _id_A42954201627527E);
    castend = _id_FE33F8F45B65696E(player, _id_5D1981EAB4B950F0, _id_DF0E1A73DC741251, ignorelist, allowairexit, _id_2B16A165170D3506);

    if(!isDefined(castend)) {
      _id_1D7A120A5DF60069.exitsfailed[_id_5580F4007EC05FC4] = 1;
      return;
    }

    _id_1D7A120A5DF60069.exitpositions[_id_5580F4007EC05FC4] = castend;
  }
}

_id_CA069B5427D4FF47(vehicle, player) {
  _id_36CEADDAA67AA6BF = [];
  _id_46B3D89477CBF92A = [];
  ignorelist = [player];
  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy"]);

  if(isnavmeshloaded()) {
    _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

    if(vehicle _id_A24042975031E692())
      points = [vehicle.origin + rotatevector((0, _id_E2818AD39A3341B4.exitextents["left"] + 50, 0), vehicle.angles), vehicle.origin + rotatevector((0, -1 * (_id_E2818AD39A3341B4.exitextents["right"] + 50), 0), vehicle.angles), vehicle.origin + rotatevector((-1 * (_id_E2818AD39A3341B4.exitextents["back"] + 50), 0, 0), vehicle.angles), vehicle.origin + rotatevector((_id_E2818AD39A3341B4.exitextents["front"] + 50, 0, 0), vehicle.angles)];
    else
      points = [player.origin];

    foreach(point in points) {
      _id_AB2D20734DD55190 = getclosestpointonnavmesh(point);
      castend = _id_FE33F8F45B65696E(player, _id_AB2D20734DD55190 + (0, 0, 10), _id_AB2D20734DD55190 - (0, 0, 20), ignorelist, 1, "inside");

      if(isDefined(castend)) {
        _id_E021C2744CC7ED68 = physics_raycast(vehicle.origin, castend + (0, 0, 36), contents, [vehicle, player], 0, "physicsquery_all", 1);

        if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
          _id_02A5AD6FBA40D7EE = 0;

          foreach(hit in _id_E021C2744CC7ED68) {
            if(isDefined(hit["hittype"]) && hit["hittype"] != "hittype_entity") {
              _id_02A5AD6FBA40D7EE = 1;
              break;
            }
          }

          if(_id_02A5AD6FBA40D7EE)
            _id_36CEADDAA67AA6BF[_id_36CEADDAA67AA6BF.size] = castend;
          else
            _id_46B3D89477CBF92A[_id_46B3D89477CBF92A.size] = castend;
        } else
          return castend;
      }
    }
  }

  if(_id_46B3D89477CBF92A.size > 0)
    return _id_46B3D89477CBF92A[0];

  if(_id_36CEADDAA67AA6BF.size > 0)
    return _id_36CEADDAA67AA6BF[0];

  nodes = getnodesinradiussorted(vehicle.origin, 800, 0, 250, "path");

  if(!isDefined(nodes) || nodes.size <= 0) {
    _id_96020425B789949E = getrandomnavpoints(vehicle.origin, 800, 6);

    if(!isDefined(_id_96020425B789949E) || _id_96020425B789949E.size <= 0) {
      return;
    }
    nodes = [];

    foreach(_id_06A3A1033FFC2699 in _id_96020425B789949E) {
      node = spawnStruct();
      node.origin = _id_06A3A1033FFC2699;
      nodes[nodes.size] = node;
    }

    nodes = sortbydistance(nodes, vehicle.origin);
  }

  _id_440D4DF82FBF5096 = 0;

  foreach(node in nodes) {
    castend = _id_FE33F8F45B65696E(player, node.origin, node.origin, ignorelist, 1, "inside");

    if(isDefined(castend))
      return castend;

    _id_440D4DF82FBF5096 = _id_440D4DF82FBF5096 + 1;

    if(_id_440D4DF82FBF5096 > 5) {
      break;
    }
  }
}

_id_136FEA30DBEDCE0F(vehicle, player, origin) {
  ignorelist = [];

  foreach(ent in vehicle getlinkedchildren(1)) {
    if(!isPlayer(ent))
      ignorelist[ignorelist.size] = ent;
  }

  ignorelist[ignorelist.size] = vehicle;
  castend = origin;
  castend = _id_FE33F8F45B65696E(player, origin, castend, ignorelist, 1, "inside");
  return isDefined(castend);
}

_id_FE33F8F45B65696E(player, caststart, castend, ignorelist, allowairexit, _id_2B16A165170D3506) {
  _id_DE8DE34672903D23 = 0;
  _id_DAE1D7CF43D6690E = undefined;
  _id_41A388AFBF92867B = undefined;
  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy"]);
  _id_E021C2744CC7ED68 = physics_charactercast(caststart, castend, player, 0, (0, 0, 0), contents, ignorelist, "physicsquery_closest", "physicsquery_any");

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    if(_id_E021C2744CC7ED68[1])
      _id_DE8DE34672903D23 = 1;
    else if(_id_E021C2744CC7ED68[0].size == 0) {
      if(!istrue(allowairexit))
        _id_DE8DE34672903D23 = 1;
      else if(_id_2B16A165170D3506 != "top" && _id_2B16A165170D3506 != "roof" && _id_2B16A165170D3506 != "inside")
        castend = castend + (0, 0, 40);
    } else
      castend = _id_E021C2744CC7ED68[0][0]["shape_position"];
  }

  if(_id_DE8DE34672903D23)
    return undefined;

  return castend;
}

_id_517F60905F08BF96(vehicle) {
  exitboundinginfo = undefined;

  if(isDefined(vehicle.exitboundinginfo) && vehicle.exitboundinginfo.timestamp == gettime())
    exitboundinginfo = vehicle.exitboundinginfo;
  else {
    _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

    if(isDefined(_id_E2818AD39A3341B4) && isDefined(_id_E2818AD39A3341B4.exitextents)) {
      exitboundinginfo = spawnStruct();
      vehicle.exitboundinginfo = exitboundinginfo;
      exitboundinginfo = exitboundinginfo;
      exitboundinginfo.vehicle = vehicle;
      exitboundinginfo.timestamp = gettime();
      exitboundinginfo.exitsfailed = [];
      exitboundinginfo.exitpositions = [];
      exitboundinginfo.orientedboxpoints = [];
      exitboundinginfo.unorientedboxpoints = [];
      exitboundinginfo thread _id_5142E9C0E6EEBAA4();
    }
  }

  return exitboundinginfo;
}

_id_5142E9C0E6EEBAA4() {
  waitframe();

  if(isDefined(self.vehicle)) {
    return;
  }
  if(!isDefined(self.vehicle.exitboundinginfo)) {
    return;
  }
  if(self.vehicle.exitboundinginfo.timestamp != self.timestamp) {
    return;
  }
  self.vehicle.exitboundinginfo = undefined;
}

vehicle_occupancy_getexitangles(vehicle, player, _id_5580F4007EC05FC4, _id_732C1A4DD3A04513) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  exitboundinginfo = _id_517F60905F08BF96(vehicle);
  exitposition = exitboundinginfo.exitpositions[_id_5580F4007EC05FC4];
  _id_C06551440B16249C = undefined;
  _id_DE0520C7C9450953 = 0;

  if(istrue(_id_732C1A4DD3A04513)) {
    _id_C06551440B16249C = vehicle.origin + rotatevector(_id_E2818AD39A3341B4.exitoffsets[_id_5580F4007EC05FC4], vehicle.angles);
    _id_DE0520C7C9450953 = 1;
  }

  if(!isDefined(_id_C06551440B16249C))
    _id_C06551440B16249C = player getvieworigin() + anglesToForward(player getplayerangles()) * 550;

  _id_95EE9A642DBEA4CF = undefined;

  if(istrue(_id_732C1A4DD3A04513))
    _id_95EE9A642DBEA4CF = exitposition + (0, 0, 22);
  else
    _id_95EE9A642DBEA4CF = exitposition + (0, 0, 60);

  _id_6A8A4307EF24181D = vectorNormalize(_id_C06551440B16249C - _id_95EE9A642DBEA4CF);

  if(!_id_DE0520C7C9450953) {
    contents = physics_createcontents(["physicscontents_vehicle", "physicscontents_item"]);
    _id_E021C2744CC7ED68 = physics_raycast(_id_95EE9A642DBEA4CF, _id_95EE9A642DBEA4CF + _id_6A8A4307EF24181D * 300, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
      _id_1D9FB21B4F3023F3 = _id_E021C2744CC7ED68[0]["entity"];
      _id_899FD7301D5E9FCC = 0;

      if(isDefined(_id_1D9FB21B4F3023F3)) {
        _id_00B404AAB7D45C92 = vehicle getlinkedchildren(1);

        if(!isDefined(_id_00B404AAB7D45C92))
          _id_00B404AAB7D45C92 = [];

        _id_00B404AAB7D45C92[_id_00B404AAB7D45C92.size] = vehicle;

        foreach(ent in _id_00B404AAB7D45C92) {
          if(_id_1D9FB21B4F3023F3 == ent) {
            _id_899FD7301D5E9FCC = 1;
            break;
          }
        }
      }

      if(_id_899FD7301D5E9FCC) {
        _id_2B16A165170D3506 = _id_E2818AD39A3341B4.exitdirections[_id_5580F4007EC05FC4];
        angles = (0, vehicle.angles[1], 0);

        if(_id_2B16A165170D3506 == "left" || _id_2B16A165170D3506 == "right")
          _id_0109BACEBD7AB9A8 = anglestoright(angles);
        else
          _id_0109BACEBD7AB9A8 = anglesToForward(angles);

        _id_6A8A4307EF24181D = _id_6A8A4307EF24181D - _id_0109BACEBD7AB9A8 * vectordot(_id_6A8A4307EF24181D, _id_0109BACEBD7AB9A8);
      }
    }
  }

  _id_8C57EF0D95A6EE0C = vectortoangles(_id_6A8A4307EF24181D);
  _id_8C57EF0D95A6EE0C = (clamp(_id_8C57EF0D95A6EE0C[0], -12, 12), _id_8C57EF0D95A6EE0C[1], 0);
  return _id_8C57EF0D95A6EE0C;
}

vehicle_occupancy_findplayerexit(player, vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, data, _id_FE757BF1A5D559B4) {
  if(!isDefined(player) || isDefined(_id_7558F98F3236963D) || istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data._id_D4B9AA76041AB0A9) && !istrue(data._id_E6584EC3FFC0CB7E))
    return 1;

  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  allowairexit = istrue(_id_E2818AD39A3341B4.allowairexit) || istrue(data.allowairexit) || !vehicle vehicle_isonground();
  _id_29187EC6E45D7481 = vehicle_occupancy_getexitpositionandangles(vehicle, player, _id_FC7C7A874B43A31A, allowairexit, data.playerlaststand, _id_FE757BF1A5D559B4);

  if(isDefined(_id_29187EC6E45D7481)) {
    data.exitposition = _id_29187EC6E45D7481[0];
    data.exitangles = _id_29187EC6E45D7481[1];
    data._id_FE757BF1A5D559B4 = _id_29187EC6E45D7481[2];
    data._id_2B16A165170D3506 = _id_29187EC6E45D7481[3];
    data._id_7862C7C7ADE2B42E = rotatevectorinverted(data.exitposition - vehicle.origin, vehicle.angles);
    return 1;
  } else
    return 0;
}

_id_A24042975031E692() {
  if(isDefined(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())) {
    _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
    return isDefined(_id_E2818AD39A3341B4) && isDefined(_id_E2818AD39A3341B4.exitextents) && isDefined(_id_E2818AD39A3341B4.exitextents["front"]) && isDefined(_id_E2818AD39A3341B4.exitextents["back"]) && isDefined(_id_E2818AD39A3341B4.exitextents["left"]) && isDefined(_id_E2818AD39A3341B4.exitextents["right"]) && isDefined(_id_E2818AD39A3341B4.exitextents["top"]) && isDefined(_id_E2818AD39A3341B4.exitextents["bottom"]);
  }

  return 0;
}

_id_9D86FD9A89CD2702(player, vehicle, _id_208B20B100E6C745, _id_F926EDCF0A329428) {
  if(!isDefined(player) || !isDefined(vehicle) || !isDefined(_id_208B20B100E6C745) || !isDefined(vehicle.origin) || !isDefined(vehicle.angles))
    return [undefined, undefined];

  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  data = vehicle_occupancy_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_858F17801EC0A1A3 = undefined;

  if(istrue(_id_F926EDCF0A329428)) {
    forward = anglesToForward(vehicle.angles);
    moving = vehicle vehicle_getvelocity();
    _id_8423818ECF85A883 = scripts\engine\math::anglebetweenvectors(forward, moving);

    if(_id_8423818ECF85A883 < 45)
      _id_858F17801EC0A1A3 = "front";
    else if(_id_8423818ECF85A883 > 135)
      _id_858F17801EC0A1A3 = "back";
  }

  _id_51552A03A376D4E6 = [];

  foreach(ref, offset in data.exitoffsets) {
    dir = data.exitdirections[ref];

    if(scripts\engine\utility::is_equal(_id_858F17801EC0A1A3, dir) || dir == "dive" || dir == "roof") {
      continue;
    }
    _id_9F925F5509626DF1 = spawnStruct();
    _id_9F925F5509626DF1.ref = ref;
    _id_9F925F5509626DF1.dir = dir;
    _id_9F925F5509626DF1.origin = vehicle.origin + rotatevector(offset, vehicle.angles);
    _id_51552A03A376D4E6[_id_51552A03A376D4E6.size] = _id_9F925F5509626DF1;
  }

  _id_51552A03A376D4E6 = sortbydistance(_id_51552A03A376D4E6, _id_208B20B100E6C745);
  exitboundinginfo = _id_517F60905F08BF96(vehicle);
  isinside = istrue(vehicle scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(_id_7731ADEF63E19B0C, "isInInterior", player));

  foreach(_id_9F925F5509626DF1 in _id_51552A03A376D4E6) {
    _id_573B4B4B98766681 = _id_9F925F5509626DF1.dir == "top" || _id_9F925F5509626DF1.dir == "inside";

    if(_id_573B4B4B98766681 != isinside) {
      continue;
    }
    position = vehicle_occupancy_getexitposition(vehicle, player, _id_9F925F5509626DF1.ref, exitboundinginfo, 1);

    if(isDefined(position))
      return [position, _id_9F925F5509626DF1.dir];
  }

  foreach(_id_9F925F5509626DF1 in _id_51552A03A376D4E6) {
    _id_573B4B4B98766681 = _id_9F925F5509626DF1.dir == "top" || _id_9F925F5509626DF1.dir == "inside";

    if(isinside == _id_573B4B4B98766681) {
      continue;
    }
    position = vehicle_occupancy_getexitposition(vehicle, player, _id_9F925F5509626DF1.ref, exitboundinginfo, 1);

    if(isDefined(position))
      return [position, _id_9F925F5509626DF1.dir];
  }

  if(getdvarint("dvar_9C95C78D2EFCA328", 1) == 1) {
    position = _id_CA069B5427D4FF47(vehicle, player);

    if(isDefined(position))
      return [position, undefined, undefined, "front"];
  }

  return [undefined, undefined];
}

vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  _id_AAB3AC0A800CEBC6 = istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data._id_D4B9AA76041AB0A9) && !istrue(data._id_F276D4E53593EC9A);

  if(!isDefined(player) || _id_AAB3AC0A800CEBC6 || isDefined(_id_7558F98F3236963D) || istrue(player._id_E86DA3427F911D75)) {
    if(isDefined(player) && !isDefined(_id_7558F98F3236963D)) {
      _id_C9B87BEB89EC12E2(player, vehicle, !isDefined(_id_7558F98F3236963D));
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant_common");
    }

    return 1;
  }

  _id_12AE002F8D36036F = undefined;

  if(isDefined(data._id_7862C7C7ADE2B42E))
    _id_12AE002F8D36036F = vehicle.origin + rotatevector(data._id_7862C7C7ADE2B42E, vehicle.angles);

  if(isDefined(_id_12AE002F8D36036F) && _id_136FEA30DBEDCE0F(vehicle, player, _id_12AE002F8D36036F))
    exitposition = _id_12AE002F8D36036F;
  else
    exitposition = data.exitposition;

  if(isDefined(exitposition)) {
    if(isDefined(data._id_FE757BF1A5D559B4)) {
      if(data._id_FE757BF1A5D559B4 == "_to_roof")
        _id_AEA8BD0571B7A840(player, vehicle, seatid, data);
      else {
        player _meth_2E8DE69E35A63F1D();
        player _meth_C0505F05660D120C(0, 1);
        player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
        player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant_common");
      }
    } else {
      _id_C9B87BEB89EC12E2(player, vehicle, !isDefined(_id_7558F98F3236963D));

      if(!isDefined(player.sessionstate) || player.sessionstate != "spectator") {
        player dontinterpolate();

        if(data._id_2B16A165170D3506 == "inside" || data._id_2B16A165170D3506 == "top")
          player _meth_0A055801DA45D769(exitposition, vehicle);
        else
          player setOrigin(exitposition, 1, 1);

        player setstance("stand");

        if(isDefined(data.exitangles))
          player setplayerangles(data.exitangles);
      }

      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant_common");
    }

    return 1;
  } else {
    _id_C9B87BEB89EC12E2(player, vehicle, !isDefined(_id_7558F98F3236963D));
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant_common");
    return 0;
  }
}

_id_AEA8BD0571B7A840(player, vehicle, seatid, data) {
  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_2E7B44E2B456F504 = vehicle_occupancy_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(_id_2E7B44E2B456F504._id_C08D88C04569A00B == "animated")
    _id_C9E915E56C1B6170 = player _meth_E5D1AE0CF82E3E7A() + (0, 0, 18);
  else {
    offset = _id_2E7B44E2B456F504.exitoffsets[seatid + "_to_roof"];
    _id_C9E915E56C1B6170 = vehicle.origin + rotatevector(offset, vehicle.angles);
  }

  _id_C9B87BEB89EC12E2(player, vehicle, 1);
  player thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
  stance = scripts\engine\utility::ter_op(_id_2E7B44E2B456F504._id_C08D88C04569A00B == "stand_up", "stand", "crouch");

  if(isbot(player))
    player botsetstance(stance);

  player setstance(stance, 1, 1, 1);
  player dontinterpolate();
  player _meth_0A055801DA45D769(_id_C9E915E56C1B6170, vehicle);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_occupant_common");
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_roof_exit");
}

_id_C5819749DB1604F5(player, vehicle, seatid, data) {
  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_2E7B44E2B456F504 = vehicle_occupancy_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(!isDefined(_id_2E7B44E2B456F504._id_C08D88C04569A00B)) {
    return;
  }
  vehicle thread _id_7F925D6914FA15CC(8000);

  if(_id_2E7B44E2B456F504._id_C08D88C04569A00B == "animated") {
    player endon("death_or_disconnect");
    player endon("last_stand_start");
    player endon("enter_live_ragdoll");
    player endon("vehicle_roof_exit_collision_detected");
    player endon("interrupt_roof_exit");
    vehicle endon("death");
    player _id_3B64EB40368C1450::_id_59C053B89257BC95("vehicle_roof_exit", ["script_weapon_switch", "weapon_switch", "melee", "vehicle_seat_switch", "allow_movement"], 0);
    player _meth_47A2FC8FDEEDA75F();
    endtime = gettime() + scripts\engine\utility::ter_op(player _meth_A7DE57196F4B5D16(), level._id_ABE9BCB8A67FF917, level._id_D9DC5B053FB57856);

    while(!player _meth_D09168B16803F5BE() && gettime() < endtime)
      waitframe();

    while(player _meth_D09168B16803F5BE() && gettime() < endtime)
      waitframe();
  }

  return 1;
}

_id_7F925D6914FA15CC(time) {
  self notify("maintainSpeedForTime");
  self endon("maintainSpeedForTime");

  if(vectordot(self vehicle_getvelocity(), anglesToForward(self.angles)) < 0 || self vehicle_getspeed() < 5) {
    return;
  }
  self endon("death");
  self._id_6179B2EEA75DBFE0 = 1;
  self _meth_6A325F91941ED47C("player");
  self _meth_D2E41C7603BA7697("p2p");
  maxspeed = self vehicle_getspeed();
  endtime = gettime() + time;

  while(gettime() < endtime && istrue(self._id_6179B2EEA75DBFE0) && self vehicle_getspeed() > 5) {
    self _meth_77320E794D35465A("p2p", "manualSpeed", scripts\engine\utility::mph_to_ips(min(maxspeed, self vehicle_getspeed())));
    self _meth_77320E794D35465A("p2p", "goalPoint", self.origin + anglesToForward(self.angles) * 2000);
    waitframe();
  }

  if(!istrue(self._id_6179B2EEA75DBFE0)) {
    return;
  }
  _id_9A816E66A02DDB40();
}

_id_9A816E66A02DDB40() {
  self._id_6179B2EEA75DBFE0 = undefined;
  self _meth_77320E794D35465A("p2p", "manualSpeed", 0);
  self _meth_6A325F91941ED47C("p2p");
}

vehicle_occupancy_getexitcastcontents() {
  return physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_playerclip"]);
}

vehicle_occupancy_getexitcastignorelist(vehicle) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  ignorelist = [vehicle];

  if(isDefined(_id_E2818AD39A3341B4.exitignorelistcallback))
    ignorelist = [[_id_E2818AD39A3341B4.exitignorelistcallback]](vehicle);

  return ignorelist;
}

vehicle_occupancy_watchmovefeedback(driverseatid) {
  self endon("death");

  for(;;) {
    vehicle_occupancy_updatemovefeedback(driverseatid);
    waitframe();
  }
}

vehicle_occupancy_updatemovefeedback(driverseatid) {
  driver = vehicle_occupancy_getseatoccupant(self, driverseatid);
  occupants = vehicle_occupancy_getalloccupants(self);

  if(isDefined(driver)) {
    _id_E394E5E73BE2F081 = driver getnormalizedmovement()[0];

    if(abs(_id_E394E5E73BE2F081) > 0.15) {
      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(_id_F85572CD5F6117C6 scripts\cp_mp\utility\player_utility::_isalive())
          _id_F85572CD5F6117C6 vehicle_occupancy_startmovefeedbackforplayer();
      }

      return;
    }

    foreach(_id_F85572CD5F6117C6 in occupants) {
      if(_id_F85572CD5F6117C6 scripts\cp_mp\utility\player_utility::_isalive())
        _id_F85572CD5F6117C6 vehicle_occupancy_stopmovefeedbackforplayer();
    }

    return;
  } else if(isDefined(occupants)) {
    foreach(_id_F85572CD5F6117C6 in occupants) {
      if(_id_F85572CD5F6117C6 scripts\cp_mp\utility\player_utility::_isalive())
        _id_F85572CD5F6117C6 vehicle_occupancy_stopmovefeedbackforplayer();
    }
  }
}

vehicle_occupancy_startmovefeedbackforplayer() {
  if(istrue(self.vehiclemoveshakeenabled)) {
    return;
  }
  self.vehiclemoveshakeenabled = 1;
  self setscriptablepartstate("vehicleMoveShake", "active1", 0);
}

vehicle_occupancy_stopmovefeedbackforplayer() {
  if(!istrue(self.vehiclemoveshakeenabled)) {
    return;
  }
  self.vehiclemoveshakeenabled = undefined;
  self setscriptablepartstate("vehicleMoveShake", "neutral", 0);
}

vehicle_occupancy_updatedamagefeedback(data) {
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  if(!isDefined(data.damage) || data.damage <= 0) {
    return;
  }
  if(!isDefined(data.meansofdeath)) {
    return;
  }
  _id_0655D44253941F2B = undefined;
  _id_BFF4B44AA047360A = undefined;

  switch (data.meansofdeath) {
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PROJECTILE":
    case "MOD_GRENADE":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
    case "MOD_GRENADE_SPLASH":
      _id_0655D44253941F2B = "light";
      _id_BFF4B44AA047360A = _id_E2818AD39A3341B4.damagefeedbackgrouplight;
      break;
    case "MOD_IMPACT":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_EXPLOSIVE":
      _id_0655D44253941F2B = "heavy";
      _id_BFF4B44AA047360A = _id_E2818AD39A3341B4.damagefeedbackgroupheavy;
      break;
  }

  if(!isDefined(_id_0655D44253941F2B)) {
    return;
  }
  if(!isDefined(_id_BFF4B44AA047360A) || _id_BFF4B44AA047360A == "none") {
    return;
  }
  players = [];

  if(_id_BFF4B44AA047360A == "driver") {
    foreach(seatid, _id_0C50B485A43752FD in _id_E2818AD39A3341B4.seatdata) {
      if(!isDefined(_id_0C50B485A43752FD.animtag)) {
        continue;
      }
      if(_id_0C50B485A43752FD.animtag == "tag_seat_0") {
        players = [vehicle_occupancy_getseatoccupant(self, seatid)];
        break;
      }
    }
  } else if(_id_BFF4B44AA047360A == "all")
    players = vehicle_occupancy_getalloccupants(self);

  if(!isDefined(players) || players.size == 0) {
    return;
  }
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(_id_0655D44253941F2B == "light") {
      player thread vehicle_occupancy_lightdamagefeedbackforplayer();
      continue;
    }

    if(_id_0655D44253941F2B == "heavy")
      player thread vehicle_occupancy_heavydamagefeedbackforplayer();
  }
}

vehicle_occupancy_lightdamagefeedbackforplayer() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearLightDamageFeedbackPlayer");

  if(!isDefined(self.vehiclelightdamagefeedbackid))
    self.vehiclelightdamagefeedbackid = 1;

  self setscriptablepartstate("vehicleDamageShakeLight", "active" + self.vehiclelightdamagefeedbackid, 0);
  self.vehiclelightdamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehiclelightdamagefeedbackid + 1, 3);
  wait 0.15;
  thread vehicle_occupancy_clearlightdamagefeedbackplayer();
}

vehicle_occupancy_clearlightdamagefeedbackplayer() {
  self notify("vehicle_occupancy_clearLightDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeLight", "neutral", 0);
  self.vehiclelightdamagefeedbackid = undefined;
}

vehicle_occupancy_heavydamagefeedbackforplayer() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");

  if(!isDefined(self.vehicleheavydamagefeedbackid))
    self.vehicleheavydamagefeedbackid = 1;

  self setscriptablepartstate("vehicleDamageShakeHeavy", "active" + self.vehicleheavydamagefeedbackid, 0);
  self.vehicleheavydamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehicleheavydamagefeedbackid + 1, 3);
  wait 0.3;
  thread vehicle_occupancy_clearheavydamagefeedbackplayer();
}

vehicle_occupancy_clearheavydamagefeedbackplayer() {
  self notify("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeHeavy", "neutral", 0);
  self.vehicleheavydamagefeedbackid = undefined;
}

vehicle_occupancy_cleardamagefeedbackforplayer() {
  vehicle_occupancy_clearlightdamagefeedbackplayer();
  vehicle_occupancy_clearheavydamagefeedbackplayer();
}

vehicle_occupancy_giveturret(player, vehicle, objweapon) {
  player endon("disconnect");
  player endon("takeTurret");
  _id_91CD55D06B5AD113 = player _meth_793F941D7DFF15ED();
  _id_C9B87BEB89EC12E2(player, vehicle);

  if(_id_91CD55D06B5AD113)
    waitframe();

  player _id_3B64EB40368C1450::set("vehicle_turret", "unresolved_collisions", 0);
  player _id_3B64EB40368C1450::set("vehicle_turret", "killstreaks", 0);

  if(vehicle _id_80D84F556CC8017A())
    player _id_3B64EB40368C1450::set("vehicle_turret", "fire", 0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    player setclientomnvar("ui_br_inventory_disabled", 1);

  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, objweapon);
  turret.owner = player;
  turret setotherent(player);
  turret setentityowner(player);
  turret setsentryowner(player);
  player disableturretdismount();

  if(!player hasweapon(objweapon))
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(objweapon);

  if(!player scripts\cp_mp\utility\inventory_utility::iscurrentweapon(objweapon))
    player childthread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(objweapon, 1, 1);

  player controlturreton(turret);
}

vehicle_occupancy_taketurret(player, vehicle, objweapon, data, _id_504FA7A88BA40E41) {
  if(isDefined(data.raceendon))
    data endon(data.raceendon);

  if(istrue(_id_504FA7A88BA40E41))
    childthread vehicle_occupancy_givetaketurrettimeout(data, 1.5);

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicle_turret");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    player setclientomnvar("ui_br_inventory_disabled", 0);

  player notify("takeTurret");

  if(player hasweapon(objweapon)) {
    result = undefined;
    thread vehicle_occupancy_clearforceweaponswitchallowed(player);

    if(player scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(objweapon)) {
      player scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(makeweapon(objweapon));
      result = 1;
    } else {
      turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, objweapon);

      if(isDefined(turret))
        player controlturretoff(turret);

      if(player hasweapon(objweapon)) {
        _id_5CD91BF870C84920 = player scripts\cp_mp\utility\inventory_utility::iscurrentweapon(objweapon);

        if(_id_5CD91BF870C84920) {
          player scripts\cp_mp\utility\inventory_utility::_takeweapon(objweapon);
          player thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        } else
          player thread scripts\cp_mp\utility\inventory_utility::getridofweapon(objweapon, 1);
      }

      result = 1;
    }

    if(isDefined(result) && !result) {
      data.success = 0;
      data notify(data.raceendnotify);
    }
  }
}

vehicle_occupancy_givetaketurrettimeout(data, timeout) {
  wait(timeout);
  data.success = 0;
  data notify(data.raceendnotify);
}

vehicle_occupancy_clearforceweaponswitchallowed(player) {
  player notify("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch"))
    player enableweaponswitch();
  else
    player disableweaponswitch();
}

vehicle_occupancy_ejectalloccupants(vehicle) {
  if(vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2()) {
    return;
  }
  seatids = vehicle_occupancy_getallvehicleseats(vehicle);

  foreach(seatid in seatids) {
    _id_F85572CD5F6117C6 = vehicle_occupancy_getseatoccupant(vehicle, seatid);

    if(isDefined(_id_F85572CD5F6117C6)) {
      data = spawnStruct();
      data.allowairexit = 1;
      data.exittype = "INVOLUNTARY";
      thread vehicle_occupancy_exit(vehicle, seatid, _id_F85572CD5F6117C6, data, 1);
    }
  }
}

vehicle_occupancy_getoccupantrestrictions() {
  allows = ["crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "crate_use", "ladder_placement", "execution_attack", "execution_victim", "usability"];

  if(getdvarint("dvar_06C68604CD07D358", 0) == 1)
    allows[allows.size] = "offhand_weapons";

  return allows;
}

vehicle_occupancy_getdriverrestrictions() {
  return ["usability", "offhand_weapons", "melee", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture", "armor", "killstreaks"];
}

_id_B9CC4AD5C15D3CEE() {
  return ["usability", "offhand_weapons", "melee", "reload", "autoreload", "weapon_switch", "cough_gesture", "armor", "killstreaks"];
}

vehicle_occupancy_getcombatpassengerrestrictions() {
  return ["weapon_pickup"];
}

vehicle_occupancy_getcombatcabpassengerrestrictions() {
  restrictions = vehicle_occupancy_getcombatpassengerrestrictions();
  return restrictions;
}

vehicle_occupancy_getpassivepassengerrestrictions() {
  return vehicle_occupancy_getdriverrestrictions();
}

vehicle_occupancy_getturretpassengerrestrictions() {
  restrictions = vehicle_occupancy_getcombatpassengerrestrictions();
  restrictions[restrictions.size] = "cough_gesture";
  restrictions[restrictions.size] = "offhand_weapons";
  restrictions[restrictions.size] = "armor";
  restrictions[restrictions.size] = "killstreaks";
  return scripts\engine\utility::array_remove_duplicates(restrictions);
}

vehicle_occupancy_disablefirefortime(player, _id_05AB9EA557C8B0A4, _id_7DFB5B86164129F9) {
  player endon("disconnect");
  player notify("vehicle_occupancy_disableFireForTime");
  player endon("vehicle_occupancy_disableFireForTime");

  if(!istrue(self.vehicledisablefire)) {
    player.vehicledisablefire = 1;
    player _id_3B64EB40368C1450::set("vehicleDisableFire", "fire", 0);
  }

  if(!isDefined(player.vehicledisablefireendtime) || !istrue(_id_7DFB5B86164129F9))
    player.vehicledisablefireendtime = gettime() + _id_05AB9EA557C8B0A4;

  while(isDefined(player.vehicledisablefireendtime) && gettime() < player.vehicledisablefireendtime)
    wait 0.05;

  thread vehicle_occupancy_cleardisablefirefortime(player);
}

vehicle_occupancy_cleardisablefirefortime(player, _id_FCEF8D217A441961) {
  player notify("vehicle_occupancy_disableFireForTime");

  if(isDefined(player.vehicledisablefire)) {
    if(!istrue(_id_FCEF8D217A441961))
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("vehicleDisableFire");
  }

  player.vehicledisablefire = undefined;
  player.vehicledisablefireendtime = undefined;
}

vehicle_occupancy_takeriotshield(player, vehicle, _id_7558F98F3236963D) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "takeRiotShield"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "takeRiotShield")]](player, vehicle, _id_7558F98F3236963D);
}

vehicle_occupancy_giveriotshield(player, _id_FCEF8D217A441961, _id_8FEAFCEA3627EB2B) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "giveRiotShield"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "giveRiotShield")]](player, _id_FCEF8D217A441961, _id_8FEAFCEA3627EB2B);
}

vehicle_occupancy_updateriotshield(player, vehicle, _id_7558F98F3236963D) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateRiotShield"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateRiotShield")]](player, vehicle, _id_7558F98F3236963D);
}

vehicle_occupancy_hidecashbag(vehicle, seatid, player, data) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "hideCashBag"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "hideCashBag")]](vehicle, seatid, player, data);
}

vehicle_occupancy_showcashbag(vehicle, seatid, player, data) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "showCashBag"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "showCashBag")]](vehicle, seatid, player, data);
}

vehicle_occupancy_registersentient(vehicle) {
  if(isDefined(vehicle.sentientdisabled) && vehicle.sentientdisabled > 0) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerSentient"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerSentient")]](vehicle);
}

vehicle_occupancy_unregistersentient(vehicle) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "unregisterSentient"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "unregisterSentient")]](vehicle);
}

vehicle_occupancy_issentient(vehicle) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "isSentient"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "isSentient")]](vehicle);
}

vehicle_occupancy_allowsentient(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self.sentientdisabled--;

    if(self.sentientdisabled == 0)
      vehicle_occupancy_registersentient(self);
  } else {
    if(!isDefined(self.sentientdisabled))
      self.sentientdisabled = 0;

    self.sentientdisabled++;

    if(self.sentientdisabled == 1)
      vehicle_occupancy_unregistersentient(self);
  }
}

vehicle_occupancy_linktooriginandangles(vehicle, _id_6126D8436C986BAF) {
  linktooriginandangles = spawnStruct();

  if(vehicle tagexists(_id_6126D8436C986BAF)) {
    linktooriginandangles.origin = vehicle gettagorigin(_id_6126D8436C986BAF);
    linktooriginandangles.angles = vehicle gettagangles(_id_6126D8436C986BAF);
  } else {
    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_6126D8436C986BAF);

    if(isDefined(_id_0C50B485A43752FD.animtag)) {
      linktooriginandangles.origin = vehicle gettagorigin(_id_0C50B485A43752FD.animtag);
      linktooriginandangles.angles = vehicle gettagangles(_id_0C50B485A43752FD.animtag);
    } else {
      linktooriginandangles.origin = vehicle.origin;
      linktooriginandangles.angles = vehicle.angles;
    }
  }

  return linktooriginandangles;
}

vehicle_occupancy_linkseatcorpse(corpse, vehicle, _id_6126D8436C986BAF) {
  if(vehicle tagexists(_id_6126D8436C986BAF)) {
    corpse enablelinkTo();
    corpse linkTo(vehicle, _id_6126D8436C986BAF);
  } else {
    _id_0C50B485A43752FD = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_6126D8436C986BAF);

    if(isDefined(_id_0C50B485A43752FD.animtag)) {
      corpse enablelinkTo();
      corpse linkTo(vehicle, _id_0C50B485A43752FD.animtag);
    } else {
      corpse enablelinkTo();
      corpse linkTo(vehicle);
    }
  }
}

vehicle_occupancy_assignseatcorpse(corpse, vehicle, _id_6126D8436C986BAF, _id_F9E25038FED22BF0) {
  if(!isDefined(vehicle.corpses))
    vehicle.corpses = [];

  vehicle_occupancy_deleteseatcorpse(vehicle, _id_6126D8436C986BAF, 0);
  vehicle.corpses[_id_6126D8436C986BAF] = corpse;

  if(!_id_F9E25038FED22BF0)
    corpse.dontdeleteonseatenter = 1;
}

vehicle_occupancy_clearseatcorpse(corpse, vehicle, _id_6126D8436C986BAF) {
  if(isDefined(vehicle.corpses) && isDefined(vehicle.corpses[_id_6126D8436C986BAF]))
    vehicle.corpses[_id_6126D8436C986BAF] = undefined;

  corpse.dontdeleteonseatenter = undefined;
}

vehicle_occupancy_deleteseatcorpse(vehicle, _id_6126D8436C986BAF, _id_A710FD9108240C6A) {
  if(isDefined(vehicle.corpses) && isDefined(vehicle.corpses[_id_6126D8436C986BAF])) {
    corpse = vehicle.corpses[_id_6126D8436C986BAF];

    if(isDefined(corpse)) {
      if(!istrue(corpse.dontdeleteonseatenter) || !_id_A710FD9108240C6A) {
        vehicle.corpses[_id_6126D8436C986BAF] delete();
        vehicle.corpses[_id_6126D8436C986BAF] = undefined;
      }
    }
  }
}

vehicle_occupancy_deleteseatcorpses(vehicle) {
  if(isDefined(vehicle.corpses)) {
    foreach(corpse in vehicle.corpses) {
      if(isDefined(corpse))
        corpse delete();
    }
  }

  vehicle.corpses = undefined;
}

vehicle_occupancy_allowspawninto(vehicle, _id_E3108E412AFB3811) {
  if(istrue(vehicle.isdestroyed) || !isDefined(vehicle.occupants))
    vehicle.preventspawninto = undefined;
  else {
    if(_id_E3108E412AFB3811) {
      vehicle.preventspawninto--;
      return;
    }

    if(!isDefined(vehicle.preventspawninto))
      vehicle.preventspawninto = 0;

    vehicle.preventspawninto++;
  }
}

vehicle_occupancy_canspawninto(vehicle) {
  if(istrue(vehicle.isdestroyed) || !isDefined(vehicle.occupants))
    return 0;

  if(isDefined(vehicle.preventspawninto) && vehicle.preventspawninto > 0)
    return 0;

  return 1;
}

vehicle_occupancy_generateseatswitcharray(seatid, _id_EA452AFA253F8034) {
  _id_D6D7814802640F93 = [];
  _id_866452ADE4626D3F = 0;
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    if(!_id_866452ADE4626D3F) {
      if(seatid == _id_EA452AFA253F8034[_id_AC0E594AC96AA3A8])
        _id_866452ADE4626D3F = 1;
    } else {
      _id_AC0E594AC96AA3A8 = scripts\engine\utility::mod(_id_AC0E594AC96AA3A8, _id_EA452AFA253F8034.size);

      if(seatid == _id_EA452AFA253F8034[_id_AC0E594AC96AA3A8]) {
        break;
      }

      _id_D6D7814802640F93[_id_D6D7814802640F93.size] = _id_EA452AFA253F8034[_id_AC0E594AC96AA3A8];
    }

    _id_AC0E594AC96AA3A8++;
  }

  return _id_D6D7814802640F93;
}

vehicle_occupancy_killoccupants(vehicle, damagedata, _id_29187EC6E45D7481) {
  seatids = vehicle_occupancy_getallvehicleseats(self);

  if(!isDefined(seatids)) {
    return;
  }
  if(!isDefined(damagedata.inflictor)) {
    switch (damagedata.meansofdeath) {
      case "MOD_PROJECTILE":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_GRENADE_SPLASH":
        if(isDefined(vehicle.killcament))
          vehicle.killcament delete();

        vehicle.killcament = damagedata.inflictor;
        damagedata.inflictor = vehicle;
    }
  }

  if(!isDefined(damagedata.inflictor))
    damagedata.inflictor = undefined;

  meansofdeath = damagedata.meansofdeath;

  if(meansofdeath == "MOD_PROJECTILE")
    meansofdeath = "MOD_PROJECTILE_SPLASH";
  else if(meansofdeath == "MOD_GRENADE")
    meansofdeath = "MOD_GRENADE_SPLASH";

  foreach(seatid in seatids) {
    _id_F85572CD5F6117C6 = vehicle_occupancy_getseatoccupant(self, seatid);

    if(isDefined(_id_F85572CD5F6117C6)) {
      _id_0A0A415F8F5DB022 = damagedata.attacker;

      if(scripts\common\utility::iscp()) {
        _id_F85572CD5F6117C6.shouldskipdeathsshield = 1;

        if(!isDefined(_id_0A0A415F8F5DB022)) {
          if(isDefined(damagedata.inflictor))
            _id_0A0A415F8F5DB022 = damagedata.inflictor;
        }

        if(!isDefined(_id_0A0A415F8F5DB022))
          _id_0A0A415F8F5DB022 = _id_F85572CD5F6117C6;

        if(isDefined(_id_0A0A415F8F5DB022) && isDefined(_id_0A0A415F8F5DB022.team)) {
          if(_id_0A0A415F8F5DB022.team == _id_F85572CD5F6117C6.team) {
            vehicle_occupancy_exit(self, seatid, _id_F85572CD5F6117C6, undefined, 1);
            _id_F85572CD5F6117C6.skipvehiclespashdamage = 1;
            continue;
          }
        }
      } else if(!isDefined(_id_0A0A415F8F5DB022) || !scripts\cp_mp\utility\player_utility::playersareenemies(_id_0A0A415F8F5DB022, _id_F85572CD5F6117C6))
        _id_0A0A415F8F5DB022 = _id_F85572CD5F6117C6;

      _id_F85572CD5F6117C6.donotmodifydamage = 1;
      _id_AB7B2B4764CFF0F5 = 0;

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && istrue(_id_F85572CD5F6117C6.isjuggernaut)) {
        if(isDefined(_id_F85572CD5F6117C6.juggcontext.juggconfig.vehiclecankillhealth) && _id_F85572CD5F6117C6.health > _id_F85572CD5F6117C6.juggcontext.juggconfig.vehiclecankillhealth)
          _id_AB7B2B4764CFF0F5 = 1;
      }

      if(!istrue(_id_AB7B2B4764CFF0F5) && _id_F85572CD5F6117C6 scripts\cp_mp\utility\player_utility::_isalive()) {
        _id_F85572CD5F6117C6 thread _id_2700EF822671144A(vehicle, _id_0A0A415F8F5DB022, damagedata, meansofdeath);

        if(isDefined(level.vehicleoccupantdeathcustomcallback))
          _id_F85572CD5F6117C6 thread[[level.vehicleoccupantdeathcustomcallback]]();
      }

      _id_F85572CD5F6117C6.donotmodifydamage = undefined;
      thread vehicle_occupancy_exit(vehicle, seatid, _id_F85572CD5F6117C6, _id_29187EC6E45D7481, 1);
    }
  }

  vehicle_occupancy_deleteseatcorpses(vehicle);
}

_id_2700EF822671144A(vehicle, _id_0A0A415F8F5DB022, damagedata, meansofdeath) {
  self endon("death_or_disconnect");
  origin = vehicle.origin;

  while(self _meth_793F941D7DFF15ED())
    waitframe();

  attacker = damagedata.attacker;
  inflictor = damagedata.inflictor;

  if(!isDefined(attacker))
    attacker = scripts\engine\utility::ter_op(isDefined(self._id_9328DED553F15D2B) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, self._id_9328DED553F15D2B)), self._id_9328DED553F15D2B, self);

  if(!isDefined(attacker)) {
    if(isDefined(vehicle))
      attacker = vehicle;
    else
      attacker = self;
  }

  if(!isDefined(inflictor))
    inflictor = self;

  self dodamage(self.maxhealth, origin, attacker, inflictor, meansofdeath, damagedata.objweapon, "torso_upper");
}

_id_34D70AA8129B0D74() {
  self endon("death");
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_675F44ED226AED7D = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "onStartRiding");
  _id_7B468990DA46C73C = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "onEndRiding");
  _id_608B3ABF5EDEE262 = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "isInInterior");
  _id_3F14197C8E0A897A = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "onEnterInterior");
  _id_49C7CC24D3FEB2EC = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "onExitInterior");
  _id_B4525AA23067A8DF = isDefined(_id_608B3ABF5EDEE262);
  self._id_8784C427B1AF24A6 = [];
  _id_A92D51FDC6322F7E = self vehicle_isonground();

  for(;;) {
    _id_EE04FC82FA87166F = self vehicle_isonground();
    _id_94F44A9BF5737C52 = [];

    foreach(player in scripts\common\utility::playersnear(self.origin, 550)) {
      if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && isDefined(player.guid) && !player _meth_793F941D7DFF15ED() && _id_F5174AC9916FE7A6(player, self) && (!_id_997F45F1E19B9DC9(player.origin) || player _meth_415FE9EECA7B2E2B() || player ismantling())) {
        _id_94F44A9BF5737C52[player.guid] = 1;

        if(!isDefined(self._id_8784C427B1AF24A6[player.guid])) {
          self._id_8784C427B1AF24A6[player.guid] = player;
          [[_id_675F44ED226AED7D]](player);

          if(!_id_EE04FC82FA87166F)
            player vehicle_occupancy_startmovefeedbackforplayer();
        }

        if(_id_B4525AA23067A8DF) {
          _id_FEC74450FBDBBE32 = [[_id_608B3ABF5EDEE262]](player);

          if(!istrue(player._id_01ECB70862BB22BB) && _id_FEC74450FBDBBE32)
            [[_id_3F14197C8E0A897A]](player);
          else if(istrue(player._id_01ECB70862BB22BB) && !_id_FEC74450FBDBBE32)
            [[_id_49C7CC24D3FEB2EC]](player);

          player._id_01ECB70862BB22BB = _id_FEC74450FBDBBE32;
        }
      }
    }

    foreach(guid, player in self._id_8784C427B1AF24A6) {
      if(!istrue(_id_94F44A9BF5737C52[guid])) {
        self._id_8784C427B1AF24A6[guid] = undefined;
        [[_id_7B468990DA46C73C]](player);

        if(isDefined(player))
          player vehicle_occupancy_stopmovefeedbackforplayer();

        if(_id_B4525AA23067A8DF) {
          if(istrue(player._id_01ECB70862BB22BB))
            [[_id_49C7CC24D3FEB2EC]](player);

          if(isDefined(player))
            player._id_01ECB70862BB22BB = undefined;
        }
      }
    }

    if(_id_EE04FC82FA87166F != _id_A92D51FDC6322F7E) {
      if(!_id_EE04FC82FA87166F) {
        foreach(player in self._id_8784C427B1AF24A6)
        player vehicle_occupancy_startmovefeedbackforplayer();
      } else {
        foreach(player in self._id_8784C427B1AF24A6)
        player vehicle_occupancy_stopmovefeedbackforplayer();
      }
    }

    _id_A92D51FDC6322F7E = _id_EE04FC82FA87166F;
    wait 0.25;
  }
}

_id_F5174AC9916FE7A6(player, _id_888761054DF5B48C) {
  if(isDefined(_id_888761054DF5B48C) && _id_888761054DF5B48C scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    _id_AA72D15F98B9B21F = _id_2E8745A2D6EC9FD1(player);

    if(isDefined(_id_AA72D15F98B9B21F) && _id_AA72D15F98B9B21F == _id_888761054DF5B48C)
      return 1;
  }

  return 0;
}

_id_2E8745A2D6EC9FD1(player) {
  if(!isDefined(player))
    return undefined;

  _id_888761054DF5B48C = player getmovingplatformparent();
  _id_5C7E5FE501D37E4A = _id_B381868642836183(player);

  if(isDefined(_id_5C7E5FE501D37E4A))
    _id_888761054DF5B48C = _id_5C7E5FE501D37E4A;

  if(isDefined(_id_888761054DF5B48C) && !_id_888761054DF5B48C scripts\cp_mp\vehicles\vehicle::isvehicle())
    return undefined;

  return _id_888761054DF5B48C;
}

_id_3DFE65E73A7D0C86(player, vehicle) {
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    player._id_8D553BC2F713D356 = vehicle;
    player thread _id_7F56221B97C7A6C0();
  }
}

_id_7F56221B97C7A6C0() {
  self endon("disconnect");
  self endon("disabled_force_ride");
  level endon("game_ended");
  self waittill("death");
  self._id_8D553BC2F713D356 = undefined;
}

_id_069F266AF27C2689(player, vehicle) {
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
      player dontinterpolate();
      player _meth_0A055801DA45D769(player.origin, vehicle);
      player notify("disabled_force_ride");
      player thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
    }
  }

  player._id_8D553BC2F713D356 = undefined;
}

_id_B381868642836183(player) {
  if(!isDefined(player))
    return undefined;

  return player._id_8D553BC2F713D356;
}

_id_D419E441D20E67AC() {
  return isDefined(self._id_5BE007B73E4FCE3F);
}

_id_7C81E0D41CBBCE7F() {
  if(!isDefined(self._id_5BE007B73E4FCE3F)) {
    return;
  }
  self._id_5BE007B73E4FCE3F = self._id_5BE007B73E4FCE3F - 1;

  if(self._id_5BE007B73E4FCE3F <= 0)
    self._id_5BE007B73E4FCE3F = undefined;
}

_id_D0092C44C5588870() {
  if(!isDefined(self._id_5BE007B73E4FCE3F))
    self._id_5BE007B73E4FCE3F = 0;

  self._id_5BE007B73E4FCE3F = self._id_5BE007B73E4FCE3F + 1;
  _id_887B4E2CBE3AB92C();
}

_id_9E710C9F3A15FFDA() {
  if(!_id_D419E441D20E67AC()) {
    self vehicle_turnengineon();
    scripts\cp_mp\vehicles\vehicle_interact::_id_C01316C733E017B7();
  }
}

_id_887B4E2CBE3AB92C() {
  self vehicle_turnengineoff();
  scripts\cp_mp\vehicles\vehicle_interact::_id_49EFF91715AE3C1B();
}

_id_4E4CF75E0F7E4184(point) {
  if(!_id_A24042975031E692())
    return 0;

  _id_EA3B9640A6AD3C8E = _func_D559A384B9C4E7D9(point, self.origin, self.angles);
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  return _id_EA3B9640A6AD3C8E[0] > _id_E2818AD39A3341B4.exitextents["back"] * -1 && _id_EA3B9640A6AD3C8E[0] < _id_E2818AD39A3341B4.exitextents["front"] && _id_EA3B9640A6AD3C8E[1] > _id_E2818AD39A3341B4.exitextents["left"] * -1 && _id_EA3B9640A6AD3C8E[1] < _id_E2818AD39A3341B4.exitextents["right"] && _id_EA3B9640A6AD3C8E[2] > _id_E2818AD39A3341B4.exitextents["bottom"] * -1 && _id_EA3B9640A6AD3C8E[2] < _id_E2818AD39A3341B4.exitextents["top"];
}

_id_997F45F1E19B9DC9(point) {
  if(!_id_A24042975031E692())
    return 0;

  _id_EA3B9640A6AD3C8E = _func_D559A384B9C4E7D9(point, self.origin, self.angles);
  _id_E2818AD39A3341B4 = vehicle_occupancy_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  return _id_EA3B9640A6AD3C8E[2] < _id_E2818AD39A3341B4.exitextents["bottom"] * -1;
}

vehicle_occupancy_initdebug() {
  _id_962A30A9BB8C0F09 = vehicle_occupancy_getleveldata();
  _id_962A30A9BB8C0F09.debuginstances = [];
}