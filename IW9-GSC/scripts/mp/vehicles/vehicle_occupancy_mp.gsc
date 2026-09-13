/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_occupancy_mp.gsc
********************************************************/

vehicle_occupancy_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", ::vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", ::vehicle_occupancy_mp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerInstance", ::vehicle_occupancy_mp_registerinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "deregisterInstance", ::vehicle_occupancy_mp_deregisterinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateOwner", ::vehicle_occupancy_mp_updateowner);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerSentient", ::vehicle_occupancy_mp_registersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "unregisterSentient", ::vehicle_occupancy_mp_unregistersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "isSentient", ::vehicle_occupancy_mp_issentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", ::vehicle_occupancy_mp_takeriotshield);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", ::vehicle_occupancy_mp_giveriotshield);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", ::vehicle_occupancy_mp_updateriotshield);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "hideCashBag", ::vehicle_occupancy_mp_hidecashbag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "showCashBag", ::vehicle_occupancy_mp_showcashbag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "changedSeats", ::vehicle_occupancy_mp_changedseats);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("vehicle_passenger", ["gesture", "supers", "cp_munitions"]);
}

vehicle_occupancy_mp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {
  player scripts\mp\utility\perk::giveperk("specialty_ghost");
  player scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  _id_FDD4CB56C3B978A3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(!_id_FDD4CB56C3B978A3 || scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, _id_7558F98F3236963D))
    player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicle", 0);
  else if(_id_FDD4CB56C3B978A3)
    player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicle_passenger", 0);

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_6AFF3948CF4CCA03::plunder_allowallrepositoryuseforplayer(player, 0, 1);

  _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerEnterVehicle", vehicle, player);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player thread scripts\cp_mp\challenges::_id_607400C13E44E916(vehicle);

  vehicle_occupancy_mp_takeriotshield(player);
  vehicle_occupancy_mp_updatemarkfilter(vehicle);

  if(isDefined(level._id_8C0F3022529BE75E) && scripts\mp\vehicles\vehicle_mp::_id_DD9423AA2B333DF5(vehicle))
    player _id_7C03AB87C5F9F420::_id_A1650EF824A7BE56(1);
}

vehicle_occupancy_mp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(!istrue(data.playerdisconnect)) {
    if(!istrue(data.playerdeath)) {
      player scripts\mp\utility\perk::removeperk("specialty_ghost");
      player scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
      _id_FDD4CB56C3B978A3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

      if(!_id_FDD4CB56C3B978A3 || scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, _id_FC7C7A874B43A31A))
        player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicle");
      else if(_id_FDD4CB56C3B978A3)
        player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicle_passenger");

      if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
        _id_6AFF3948CF4CCA03::plunder_allowallrepositoryuseforplayer(player, 1, 1);
    }

    vehicle_occupancy_mp_giveriotshield(player, data.playerdeath, data.playerlaststand);

    if(isDefined(level._id_8C0F3022529BE75E) && scripts\mp\vehicles\vehicle_mp::_id_DD9423AA2B333DF5(vehicle))
      player _id_7C03AB87C5F9F420::_id_A1650EF824A7BE56(0);

    player notify("vehicle_exit");

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      player scripts\cp_mp\challenges::_id_DDE9993EDD2D9834(vehicle);

    level thread _id_53280C8DEFB18363(player, vehicle);
  }

  vehicle_occupancy_mp_updatemarkfilter(vehicle);
}

_id_53280C8DEFB18363(player, vehicle) {
  player._id_C7C386DFCCF6492F = vehicle;
  wait 1;

  if(isDefined(player) && scripts\engine\utility::is_equal(player._id_C7C386DFCCF6492F, vehicle))
    player._id_C7C386DFCCF6492F = undefined;
}

vehicle_occupancy_mp_changedseats(player, vehicle, _id_FC7C7A874B43A31A, seatid) {
  _id_FDD4CB56C3B978A3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_FDD4CB56C3B978A3 && isDefined(_id_FC7C7A874B43A31A) && isDefined(seatid)) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, _id_FC7C7A874B43A31A)) {
      player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicle");
      player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicle_passenger", 0);
    } else if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid)) {
      player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicle_passenger");
      player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicle", 0);
    }
  }
}

vehicle_occupancy_mp_updatemarkfilter(vehicle) {
  if(!isDefined(vehicle.occupants)) {
    return;
  }
  if(!isDefined(vehicle.marksenabled))
    vehicle.marksenabled = 1;

  _id_E8144973B1C57819 = vehicle.marksenabled;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);
  vehicle.marksenabled = occupants.size > 0;

  if(_id_E8144973B1C57819 && !vehicle.marksenabled)
    vehicle disableplayermarks("killstreak");
  else if(!_id_E8144973B1C57819 && vehicle.marksenabled)
    vehicle enableplayermarks("killstreak");

  if(vehicle.marksenabled) {
    if(level.teambased) {
      _id_C95B61BAB9571249 = [];

      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(isDefined(_id_F85572CD5F6117C6.team) && !scripts\engine\utility::array_contains(_id_C95B61BAB9571249, _id_F85572CD5F6117C6.team))
          _id_C95B61BAB9571249[_id_C95B61BAB9571249.size] = _id_F85572CD5F6117C6.team;
      }

      vehicle filteroutplayermarks(_id_C95B61BAB9571249);
    } else
      vehicle filteroutplayermarks(occupants);
  }
}

vehicle_occupancy_mp_registerinstance(vehicle) {}

vehicle_occupancy_mp_deregisterinstance(vehicle) {}

vehicle_occupancy_mp_hidecashbag(vehicle, _id_7558F98F3236963D, player, data) {
  if(isDefined(_id_7558F98F3236963D)) {
    _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_7558F98F3236963D);

    if(istrue(_id_0C50B485A43752FD.showcashbag))
      return;
  }

  scripts\mp\utility\player::_id_EFC7B5130B976314(player);
}

vehicle_occupancy_mp_showcashbag(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(isDefined(_id_FC7C7A874B43A31A)) {
    _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_FC7C7A874B43A31A);

    if(istrue(_id_0C50B485A43752FD.showcashbag))
      return;
  }

  scripts\mp\utility\player::_id_AFFAEFA6EA1B971D(player);
}

vehicle_occupancy_mp_updateowner(vehicle) {
  vehicle_occupancy_mp_updatemarkfilter(vehicle);

  if(isDefined(vehicle.owner))
    vehicle._id_628A2EBA2E3D4AF4 = vehicle.owner;
}

vehicle_occupancy_mp_takeriotshield(player, vehicle, _id_7558F98F3236963D) {
  _id_EABB2F4030699112 = undefined;
  riotshieldiscurrentprimary = undefined;
  _id_102D661B1CAA8BC1 = undefined;
  primaryweapons = player getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(isnullweapon(weapon)) {
      continue;
    }
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      _id_EABB2F4030699112 = weapon;

      if(issameweapon(_id_EABB2F4030699112, player getcurrentprimaryweapon()))
        riotshieldiscurrentprimary = 1;

      continue;
    }

    if(!isDefined(_id_102D661B1CAA8BC1)) {
      _id_DD9181EB18C4DB69 = weapon getnoaltweapon();

      if(_id_DD9181EB18C4DB69.inventorytype != "primary") {
        continue;
      }
      _id_102D661B1CAA8BC1 = weapon;
    }
  }

  if(!isDefined(_id_EABB2F4030699112) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && _id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

    if(isDefined(_id_9AC5E72784815708) && scripts\cp_mp\utility\weapon_utility::isriotshield(_id_9AC5E72784815708))
      _id_EABB2F4030699112 = _id_9AC5E72784815708;
  }

  _id_FE4048AD22C35D73 = 0;

  if(isDefined(_id_EABB2F4030699112)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2()) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
        _id_A1C804FFA2416774 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, _id_AC0E594AC96AA3A8);

        if(isDefined(_id_A1C804FFA2416774) && _id_A1C804FFA2416774 == _id_EABB2F4030699112) {
          _id_FE4048AD22C35D73 = _id_AC0E594AC96AA3A8;

          if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
            _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(player, _id_AC0E594AC96AA3A8);
            player._id_D3143125B9854467 = _id_96C4059AA2EABFB8;
          }

          break;
        }
      }
    }

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(_id_FE4048AD22C35D73 == 2)
        _id_2D9D24F7C63AC143::_id_954372D604277278(player);
      else
        player _id_7E52B56769FA7774::_id_D655F2006CFE7789(_id_EABB2F4030699112);
    } else
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_EABB2F4030699112);

    player.riotshieldtaken = _id_EABB2F4030699112;
    player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;

    if(istrue(riotshieldiscurrentprimary))
      vehicle_occupancy_mp_updateriotshield(player, vehicle, _id_7558F98F3236963D);

    player scripts\mp\class::riotshieldonweaponchange(_id_102D661B1CAA8BC1);
    player notify("modified_riot_shield");
    player endon("modified_riot_shield");
    player childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(_id_102D661B1CAA8BC1);
  }
}

vehicle_occupancy_mp_giveriotshield(player, _id_FCEF8D217A441961, _id_8FEAFCEA3627EB2B) {
  if(isDefined(player.riotshieldtaken)) {
    _id_FDD4CB56C3B978A3 = level.gametype == "br";

    if(!istrue(_id_FCEF8D217A441961) && (_id_FDD4CB56C3B978A3 || !istrue(_id_8FEAFCEA3627EB2B))) {
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.weapon = player.riotshieldtaken;
        _id_60227BFF1E9478CC.count = 1;
        _id_60227BFF1E9478CC.countlefthand = 0;
        _id_60227BFF1E9478CC.origin = player.origin;
        _id_60227BFF1E9478CC.angles = player.angles;
        _id_60227BFF1E9478CC._id_4A08890FD43D6BC7 = _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player) > 5 && !player hasweapon("iw9_me_fists_mp");

        if(_id_60227BFF1E9478CC._id_4A08890FD43D6BC7)
          _id_60227BFF1E9478CC._id_F51BBB191526DFA4 = 1;

        if(isDefined(player._id_D3143125B9854467))
          _id_60227BFF1E9478CC._id_4E479E14D0837E84 = player._id_D3143125B9854467;

        _id_A2917FAB2B2235DD = scripts\mp\weapons::isfistweapon(player getcurrentweapon());
        player _id_724736FCF0FB6604::takeweaponpickup(_id_60227BFF1E9478CC, undefined, undefined, undefined, undefined, !_id_A2917FAB2B2235DD);
      } else
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.riotshieldtaken);

      player scripts\mp\class::trackriotshield_tryreset();

      if(istrue(player.riotshieldiscurrentprimary)) {
        player notify("modified_riot_shield");
        player endon("modified_riot_shield");

        if(!istrue(_id_8FEAFCEA3627EB2B))
          player childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(player.riotshieldtaken);
      }
    }

    player.riotshieldtaken = undefined;
    player.riotshieldiscurrentprimary = undefined;
    player notify("modified_riot_shield");
  }
}

vehicle_occupancy_mp_updateriotshield(player, vehicle, _id_7558F98F3236963D) {
  if(isDefined(player.riotshieldtaken) && istrue(player.riotshieldiscurrentprimary)) {
    if(!isDefined(_id_7558F98F3236963D)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, _id_7558F98F3236963D)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_shouldhideoccupantforseat(vehicle, _id_7558F98F3236963D)) {
      return;
    }
    _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_7558F98F3236963D);

    if(isDefined(_id_0C50B485A43752FD.turretobjweapon)) {
      return;
    }
    player.riotshieldiscurrentprimary = undefined;
  }
}

vehicle_occupancy_mp_registersentient(vehicle) {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(!isDefined(_id_E2818AD39A3341B4.threatbiasgroup)) {
    return;
  }
  if(level.teambased) {
    team = vehicle.team;

    if(isDefined(vehicle.team) && vehicle.team == "neutral")
      team = undefined;

    if(!isDefined(team) && isDefined(vehicle.owner))
      team = vehicle.owner.team;

    if(isDefined(team)) {
      if(!isDefined(vehicle.sentientteam) || vehicle.sentientteam != team) {
        vehicle_occupancy_mp_unregistersentient(vehicle);
        vehicle scripts\mp\sentientpoolmanager::registersentient(_id_E2818AD39A3341B4.threatbiasgroup, team);
        vehicle.sentientteam = team;
      }
    } else if(isDefined(vehicle.sentientteam))
      vehicle_occupancy_mp_unregistersentient(vehicle);
  }
}

vehicle_occupancy_mp_unregistersentient(vehicle) {
  vehicle notify("remove_sentient");
  vehicle.sentientteam = undefined;
}

vehicle_occupancy_mp_issentient(vehicle) {
  return isDefined(vehicle.sentientteam);
}