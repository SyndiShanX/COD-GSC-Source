/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\customization\battle_tracks.gsc
******************************************************************/

_id_620AA345AC2F9963() {
  _id_EECCA1D1275B620D = "enum_7E19E50AD2F7498E";

  switch (_func_03CB5DA19764BAA3()) {
    case "IW9":
      _id_EECCA1D1275B620D = "enum_7E19E50AD2F7498E";
      break;
    case "MGL":
      _id_EECCA1D1275B620D = "enum_7E19E50AD2F7498E";
      break;
    case "JUP":
      _id_EECCA1D1275B620D = "enum_1BBA3E5065A0064F";
      break;
    case "T10":
      _id_EECCA1D1275B620D = "enum_1D035C82139BCD11";
      break;
  }

  level._id_702B32C96429BAEE = getscriptbundle(_id_EECCA1D1275B620D)._id_702B32C96429BAEE;

  if(!isDefined(level._id_702B32C96429BAEE)) {
    return;
  }
  foreach(index, _id_40627B946D4E9A94 in level._id_702B32C96429BAEE) {
    if(index <= 1) {
      continue;
    }
    if(!isDefined(_id_40627B946D4E9A94._id_88CC26B68D5FBA92)) {
      continue;
    }
    _id_79849F0903CCFBEB = _func_2EF675C13CA1C4AF("enum_08F87DCA26D14F0D", _id_40627B946D4E9A94._id_88CC26B68D5FBA92);
    _id_02450B73CCBDAE7D = _func_50F8A8F765BAD85E(_id_79849F0903CCFBEB, ["stat_7FCAF90080DBF68D", "stat_B564DDD34FAB3F00"]);
    _id_40627B946D4E9A94._id_EBB583A772B21A39 = _id_02450B73CCBDAE7D._id_EBB583A772B21A39;
    _id_40627B946D4E9A94._id_CF52BB02EADC20D4 = _id_02450B73CCBDAE7D._id_CF52BB02EADC20D4;

    if(!isDefined(_id_40627B946D4E9A94._id_EBB583A772B21A39)) {}

    if(!isDefined(_id_40627B946D4E9A94._id_CF52BB02EADC20D4)) {}
  }
}

battle_tracks_onentervehicle(vehicle, player) {
  if(_id_C3D244CEADC23533(player)) {
    _id_7718D2895FDBA333(player);

    if(!_id_4C953E9E77258030(vehicle, player))
      battle_tracks_stopbattletrackswhenstandingonvehicle(player);
  }

  if(battle_tracks_shouldstartbattletracks(vehicle))
    battle_tracks_playbattletrackstoplayer(vehicle, player, 0);
}

battle_tracks_vehicleoccupancyenter(vehicle, player, seatid, _id_FC7C7A874B43A31A) {
  _id_DF653126C71EF4CA = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);
  _id_10E0F337938FCFA6 = battle_tracks_isbattletracksowner(vehicle, player);
  battle_tracks_trystopdrivertogglethink(vehicle, player, _id_FC7C7A874B43A31A);
  battle_tracks_hidetogglewidget(player);

  if(_id_DF653126C71EF4CA) {
    if(!_id_10E0F337938FCFA6) {
      battle_tracks_stopbattletrackstoalloccupants(vehicle);
      battle_tracks_updatebattletracks(vehicle, player);
    }

    if(battle_tracks_shouldstartbattletracks(vehicle))
      battle_tracks_playbattletrackstoalloccupants(vehicle);

    if(!battle_tracks_hasemptybattletracks(vehicle))
      player thread battle_tracks_togglethink(player, vehicle);
  }
}

battle_tracks_onexitvehicle(vehicle, player, seatid) {
  battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, player, 0);
  battle_tracks_trystopdrivertogglethink(vehicle, player, seatid);
  battle_tracks_hidetogglewidget(player);
  _id_10E0F337938FCFA6 = battle_tracks_isbattletracksowner(vehicle, player);

  if(_id_10E0F337938FCFA6) {
    battle_tracks_stopbattletrackstoalloccupants(vehicle);
    battle_tracks_clearbattletracks(vehicle);
  }
}

battle_tracks_monitorstandingonvehicles(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    battle_tracks_tryplayingbattletrackswhenstandingonvehicle(player);
    wait 0.5;
  }
}

battle_tracks_updatebattletracks(vehicle, player) {
  vehicle.battletracks = [];
  vehicle.battletracksowner = player;
  vehicle.battletracksmusicstate = "";

  if(battle_tracks_playerselectrandomtracks(vehicle, player))
    battle_tracks_updatebattletracksfromplayerdata(vehicle, player, 1, 9);
  else
    battle_tracks_updatebattletracksfromplayerdata(vehicle, player, 0, 9);

  vehicle.battletracks = scripts\engine\utility::array_randomize(vehicle.battletracks);
}

battle_tracks_updatebattletracksfromplayerdata(vehicle, player, _id_2F55781AF96F22F9, _id_8FA62807749C3F5A) {
  data = scripts\cp_mp\vehicles\vehicle::_id_86F6F784630B11FB(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  for(_id_109EBF347B2F2ECE = _id_2F55781AF96F22F9; _id_109EBF347B2F2ECE <= _id_8FA62807749C3F5A; _id_109EBF347B2F2ECE++) {
    _id_0534056C7A3B8C64 = battle_tracks_gettrackindex(vehicle, player, _id_109EBF347B2F2ECE, data);

    if(isDefined(_id_0534056C7A3B8C64) && _id_0534056C7A3B8C64 > 1) {
      if(getdvarint("dvar_157CDFF8F5182E88", 0) == 0) {
        _id_A244F2F1E8CAC724 = battle_tracks_getsfxalias(_id_0534056C7A3B8C64);

        if(isDefined(_id_A244F2F1E8CAC724) && _id_A244F2F1E8CAC724 != "") {
          vehicle.battletracks = scripts\engine\utility::array_add(vehicle.battletracks, _id_A244F2F1E8CAC724);
          battle_tracks_setmusicstate(vehicle, _id_0534056C7A3B8C64);
        }

        continue;
      }

      vehicle.battletracks = scripts\engine\utility::array_add(vehicle.battletracks, _id_0534056C7A3B8C64);
    }
  }
}

battle_tracks_setmusicstate(vehicle, _id_0534056C7A3B8C64) {
  _id_51941101270F867D = battle_tracks_getmusicstate(_id_0534056C7A3B8C64);

  if(vehicle.battletracksmusicstate == "")
    vehicle.battletracksmusicstate = _id_51941101270F867D;
  else {}
}

battle_tracks_playerselectrandomtracks(vehicle, player) {
  data = scripts\cp_mp\vehicles\vehicle::_id_86F6F784630B11FB(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  _id_5CD83EED6CC7ED18 = battle_tracks_gettrackindex(vehicle, player, 0, data);
  return isDefined(_id_5CD83EED6CC7ED18) && _id_5CD83EED6CC7ED18 == 1;
}

battle_tracks_gettrackindex(vehicle, player, _id_109EBF347B2F2ECE, data) {
  if(isDefined(data) && isDefined(data.ref)) {
    _id_0534056C7A3B8C64 = player getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "tracks", _id_109EBF347B2F2ECE);
    return _id_0534056C7A3B8C64;
  } else
    return undefined;
}

battle_tracks_getsfxalias(_id_0534056C7A3B8C64) {
  if(isDefined(level._id_702B32C96429BAEE) && isDefined(level._id_702B32C96429BAEE[_id_0534056C7A3B8C64]))
    return level._id_702B32C96429BAEE[_id_0534056C7A3B8C64]._id_EBB583A772B21A39;
}

battle_tracks_getmusicstate(_id_0534056C7A3B8C64) {
  if(isDefined(level._id_702B32C96429BAEE) && isDefined(level._id_702B32C96429BAEE[_id_0534056C7A3B8C64]))
    return level._id_702B32C96429BAEE[_id_0534056C7A3B8C64]._id_CF52BB02EADC20D4;
}

battle_tracks_playbattletrackstoalloccupants(vehicle) {
  if(getdvarint("dvar_157CDFF8F5182E88", 0) == 0) {
    _id_6E62512E935B6EEB = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 1), []);

    if(isDefined(vehicle._id_3A442282FB9074E1))
      _id_6E62512E935B6EEB = scripts\engine\utility::array_combine_unique(_id_6E62512E935B6EEB, vehicle._id_3A442282FB9074E1);

    foreach(_id_F85572CD5F6117C6 in _id_6E62512E935B6EEB)
    battle_tracks_playbattletrackstoplayer(vehicle, _id_F85572CD5F6117C6, 0);
  } else
    vehicle _meth_6DB07C8A8C0F9AE6(vehicle.battletracks);
}

battle_tracks_stopbattletrackstoalloccupants(vehicle) {
  if(getdvarint("dvar_157CDFF8F5182E88", 0) == 0) {
    _id_6E62512E935B6EEB = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 1);

    if(isDefined(vehicle._id_3A442282FB9074E1))
      _id_6E62512E935B6EEB = scripts\engine\utility::array_combine_unique(_id_6E62512E935B6EEB, vehicle._id_3A442282FB9074E1);

    if(isDefined(_id_6E62512E935B6EEB)) {
      foreach(_id_F85572CD5F6117C6 in _id_6E62512E935B6EEB)
      battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, _id_F85572CD5F6117C6, 0);

      return;
    }
  } else
    vehicle _meth_3A119112E4018367();
}

battle_tracks_playbattletrackstoplayer(vehicle, player, _id_29172B8E5D02BE98) {
  if(getdvarint("dvar_157CDFF8F5182E88", 0) != 0) {
    return;
  }
  _id_10E0F337938FCFA6 = battle_tracks_isbattletracksowner(vehicle, player);

  if(isDefined(vehicle.battletracksmusicstate) && isDefined(vehicle.battletracks) && isDefined(player)) {
    if(isDefined(vehicle.battletracksowner) && (_id_10E0F337938FCFA6 || _id_29172B8E5D02BE98 || player getwartrackpassengerenabled())) {
      _id_A922E318FF7F4A24 = battle_tracks_getbattletracksid(vehicle);

      if(!_id_59720EFC5C367AF2(vehicle, player, _id_A922E318FF7F4A24)) {
        player.battletracksmusicstate = vehicle.battletracksmusicstate;
        player._id_B132B6A670ABB56E = _id_A922E318FF7F4A24;
        player setplayermusicstate(vehicle.battletracksmusicstate, vehicle.battletracks, vehicle, (0, 0, 0));
      }
    }

    if(!_id_10E0F337938FCFA6 && !_id_29172B8E5D02BE98)
      player thread _id_D9A28875C82616D0(player, vehicle);
  }
}

_id_59720EFC5C367AF2(vehicle, player, _id_A922E318FF7F4A24) {
  if(!isDefined(player.battletracksmusicstate))
    return 0;

  if(!isDefined(player._id_B132B6A670ABB56E))
    return 0;

  return player.battletracksmusicstate == vehicle.battletracksmusicstate && player._id_B132B6A670ABB56E == _id_A922E318FF7F4A24;
}

battle_tracks_stopbattletracksforplayer(battletracksmusicstate, player, _id_29172B8E5D02BE98) {
  if(getdvarint("dvar_157CDFF8F5182E88", 0) != 0) {
    return;
  }
  if(_id_C3D244CEADC23533(player)) {
    if(isDefined(battletracksmusicstate) && isDefined(player)) {
      player.battletracksmusicstate = undefined;
      player._id_B132B6A670ABB56E = undefined;
      player stopplayermusicstate(battletracksmusicstate);

      if(!_id_29172B8E5D02BE98)
        player notify("stop_battle_tracks_option_watch");
    }
  }
}

_id_C3D244CEADC23533(player) {
  return isDefined(player.battletracksmusicstate) && isDefined(player._id_B132B6A670ABB56E);
}

battle_tracks_isbattletracksowner(vehicle, player) {
  return isDefined(vehicle.battletracksowner) && vehicle.battletracksowner == player;
}

battle_tracks_clearbattletracks(vehicle) {
  vehicle.battletracksowner = undefined;
  vehicle.battletracks = undefined;
  vehicle.battletracksmusicstate = undefined;
}

battle_tracks_hasemptybattletracks(vehicle) {
  if(!isDefined(vehicle.battletracks))
    return 1;

  if(vehicle.battletracks.size == 0)
    return 1;

  return 0;
}

battle_tracks_togglethink(player, vehicle) {
  player notify("stop_battle_tracks_toggle_think");
  player endon("stop_battle_tracks_toggle_think");
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  battle_tracks_tryinittogglestate(player);
  _id_4844D16E0D10F08B = battle_tracks_gettogglestate(player);
  battle_tracks_updatetogglestate(player, vehicle, _id_4844D16E0D10F08B);
  _id_5C7FF285B6699ECD = player scripts\engine\utility::is_player_gamepad_enabled();

  if(_id_5C7FF285B6699ECD) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+melee_zoom");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-melee_zoom");
      player._id_23B06600E2A88B42 = "melee_zoom";
    } else {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+frag");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-frag");
      player._id_23B06600E2A88B42 = "frag";
    }
  } else {
    player notifyonplayercommand("update_battle_tracks_toggle_state", "nightvision");
    player._id_23B06600E2A88B42 = "nightvision";
  }

  for(;;) {
    player setclientomnvar("ui_veh_music_toggle_button_holdtime", 0);
    player waittill("update_battle_tracks_toggle_state");
    _id_EAECA8280194353E = battle_tracks_getnewtogglestate(player);

    if(_id_5C7FF285B6699ECD) {
      player childthread _id_338B77C14712DBB3();
      result = player scripts\engine\utility::waittill_notify_or_timeout_return("cancel_battle_tracks_toggle_state", 0.25);

      if(result == "timeout") {
        player notify("cancel_battle_tracks_toggle_state");
        battle_tracks_updatetogglestate(player, vehicle, _id_EAECA8280194353E);
      }

      continue;
    }

    battle_tracks_updatetogglestate(player, vehicle, _id_EAECA8280194353E);
  }
}

_id_338B77C14712DBB3() {
  self endon("cancel_battle_tracks_toggle_state");
  progress = 0;

  for(;;) {
    progress = progress + level.framedurationseconds;
    self setclientomnvar("ui_veh_music_toggle_button_holdtime", min(1.0, progress / 0.25));
    waitframe();
  }
}

battle_tracks_updatetogglestate(player, vehicle, _id_D1D3327F51ED4342) {
  switch (_id_D1D3327F51ED4342) {
    case "on":
      battle_tracks_toggleonstate(player, vehicle);
      break;
    case "off":
      battle_tracks_toggleoffstate(player, vehicle);
      break;
  }
}

battle_tracks_toggleonstate(player, vehicle) {
  battle_tracks_settogglestate(player, "on");
  battle_tracks_playbattletrackstoalloccupants(vehicle);
}

battle_tracks_toggleoffstate(player, vehicle) {
  battle_tracks_settogglestate(player, "off");
  battle_tracks_stopbattletrackstoalloccupants(vehicle);
}

battle_tracks_getnewtogglestate(player) {
  switch (player.pers["battleTracksToggleState"]) {
    case "on":
      return "off";
    case "off":
      return "on";
  }
}

battle_tracks_tryinittogglestate(player) {
  if(!isDefined(player.pers["battleTracksToggleState"]))
    battle_tracks_settogglestate(player, "on");
}

battle_tracks_settogglestate(player, value) {
  player.pers["battleTracksToggleState"] = value;
  _id_587830FD4042BE45 = player getclientomnvar("ui_veh_battle_tracks_toggle_state");

  switch (value) {
    case "on":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 1);
      break;
    case "off":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 2);
      break;
  }
}

battle_tracks_hidetogglewidget(player) {
  if(isDefined(player)) {
    _id_587830FD4042BE45 = player getclientomnvar("ui_veh_battle_tracks_toggle_state");
    player setclientomnvar("ui_veh_battle_tracks_toggle_state", 0);
  }
}

battle_tracks_gettogglestate(player) {
  return player.pers["battleTracksToggleState"];
}

battle_tracks_togglestateis(player, value) {
  return isDefined(player.pers["battleTracksToggleState"]) && player.pers["battleTracksToggleState"] == value;
}

battle_tracks_trystopdrivertogglethink(vehicle, player, seatid) {
  _id_DF653126C71EF4CA = isDefined(seatid) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);

  if(_id_DF653126C71EF4CA)
    player battle_tracks_stoptogglethink(player);
}

battle_tracks_stoptogglethink(player) {
  if(!isDefined(player)) {
    return;
  }
  player notify("stop_battle_tracks_toggle_think");

  if(isDefined(player._id_23B06600E2A88B42)) {
    switch (player._id_23B06600E2A88B42) {
      case "melee_zoom":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "+melee_zoom");
        player notifyonplayercommandremove("cancel_battle_tracks_toggle_state", "-melee_zoom");
        break;
      case "frag":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "+frag");
        player notifyonplayercommandremove("cancel_battle_tracks_toggle_state", "-frag");
        break;
      case "nightvision":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "nightvision");
        break;
    }

    player._id_23B06600E2A88B42 = undefined;
  }
}

_id_12A073AB00FFE201() {
  gametype = level.gametype;

  if(gametype == "br") {
    _id_FAF0D2FAC3F47583 = getDvar("dvar_7611A2790A0BF7FE", "");

    if(_id_FAF0D2FAC3F47583 != "")
      return _id_FAF0D2FAC3F47583;
  }

  return gametype;
}

battle_tracks_shouldstartbattletracks(vehicle) {
  if(_id_12A073AB00FFE201() == "x2")
    return 0;

  if(battle_tracks_hasemptybattletracks(vehicle))
    return 0;

  if(isDefined(vehicle.battletracksowner) && battle_tracks_togglestateis(vehicle.battletracksowner, "off"))
    return 0;

  return 1;
}

battle_tracks_tryplayingbattletrackswhenstandingonvehicle(player) {
  vehicle = player getmovingplatformparent();

  if(battle_tracks_shouldplaybattletrackswhenstandingonvehicle(vehicle, player)) {
    player thread battle_tracks_standingonvehicletimeout(vehicle, player);

    if(!battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player)) {
      battle_tracks_stopbattletrackswhenstandingonvehicle(player);
      battle_tracks_playbattletrackswhenstandingonvehicle(vehicle, player);
    }
  }
}

battle_tracks_playbattletrackswhenstandingonvehicle(vehicle, player) {
  battle_tracks_playbattletrackstoplayer(vehicle, player, 0);
}

battle_tracks_stopbattletrackswhenstandingonvehicle(player) {
  if(_id_C3D244CEADC23533(player)) {
    _id_7718D2895FDBA333(player);
    battle_tracks_stopbattletracksfromstandingonvehicle(player);
  }
}

_id_7718D2895FDBA333(player) {
  player notify("battle_tracks_standingOnVehicleTimeout");
}

battle_tracks_standingonvehicletimeout(vehicle, player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("battle_tracks_standingOnVehicleTimeout");
  player endon("battle_tracks_standingOnVehicleTimeout");
  wait 1;
  battle_tracks_stopbattletracksfromstandingonvehicle(player);
}

_id_D9A28875C82616D0(player, vehicle) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_battle_tracks_option_watch");
  _id_5B0FC1B88F867313 = player getwartrackpassengerenabled();

  for(;;) {
    wait 0.5;
    _id_4192FC05BB9A1187 = player getwartrackpassengerenabled();

    if(_id_4192FC05BB9A1187 != _id_5B0FC1B88F867313) {
      if(_id_4192FC05BB9A1187) {
        if(battle_tracks_shouldstartbattletracks(vehicle))
          battle_tracks_playbattletrackstoplayer(vehicle, player, 1);
      } else
        battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, player, 1);

      _id_5B0FC1B88F867313 = _id_4192FC05BB9A1187;
    }
  }
}

battle_tracks_stopbattletracksfromstandingonvehicle(player) {
  battle_tracks_stopbattletracksforplayer(player.battletracksmusicstate, player, 0);
}

battle_tracks_shouldplaybattletrackswhenstandingonvehicle(vehicle, player) {
  if(!isDefined(vehicle))
    return 0;

  if(!vehicle scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  if(!battle_tracks_vehicleallowlisteningoutsideoccupancy(vehicle))
    return 0;

  if(!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, player))
    return 0;

  if(!battle_tracks_shouldstartbattletracks(vehicle))
    return 0;

  if(!battle_tracks_playerinlisteningzone(vehicle, player))
    return 0;

  return 1;
}

battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player) {
  if(!isDefined(player._id_B132B6A670ABB56E))
    return 0;

  _id_B132B6A670ABB56E = battle_tracks_getbattletracksid(vehicle);
  return _id_B132B6A670ABB56E == player._id_B132B6A670ABB56E;
}

_id_4C953E9E77258030(vehicle, player) {
  if(battle_tracks_hasemptybattletracks(vehicle))
    return 0;

  return battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player);
}

battle_tracks_getbattletracksid(vehicle) {
  _id_F794F29935653F3E = vehicle getentitynumber() + "";
  _id_D92A58C3390F0FF2 = vehicle.battletracksowner getentitynumber() + "";
  return _id_F794F29935653F3E + _id_D92A58C3390F0FF2;
}

battle_tracks_playerinlisteningzone(vehicle, player) {
  switch (vehicle.targetname) {
    case "cargo_truck_mg":
    case "cargo_truck":
      return scripts\cp_mp\utility\train_utility::isplayerinsiderectangularzonebasedonent(player, vehicle, "tag_origin", -85, 0, 77, 185, 125, 40);
    default:
      return 0;
  }
}

battle_tracks_vehicleallowlisteningoutsideoccupancy(vehicle) {
  if(isDefined(vehicle.targetname)) {
    switch (vehicle.targetname) {
      case "cargo_truck_mg":
      case "cargo_truck":
        return 1;
      default:
        return 0;
    }
  } else
    return 0;
}