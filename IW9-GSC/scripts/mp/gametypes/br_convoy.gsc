/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_convoy.gsc
***********************************************/

unimogtest(c130pathstruct) {
  level thread spawntestconvoy(c130pathstruct);
}

unimogsnatch(c130pathstruct) {
  level thread spawnspreadconvoy(c130pathstruct);
}

spawntestconvoy(c130pathstruct) {
  level.br_convoytrucks = [];
  paths = getvehiclenodearray("br_convoy", "targetname");
  _id_4D4D20D31099D146 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++)
    _id_4D4D20D31099D146[_id_AC0E594AC96AA3A8] = paths[_id_AC0E594AC96AA3A8];

  mapcenter = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  _id_252E739BC4F9BF6A = c130pathstruct.startpt - mapcenter;
  _id_D2392C09DF33A38F = vectortoangles(_id_252E739BC4F9BF6A)[1];
  _id_4A1A4BEC206CBBA2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    _id_06C192636CDB64A8 = _id_4D4D20D31099D146[_id_AC0E594AC96AA3A8].origin - mapcenter;
    _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8] = vectortoangles(_id_06C192636CDB64A8)[1];
  }

  _id_85AB47EF7F70892E = -1;
  _id_76714BF77C396AC3 = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    if(_id_D2392C09DF33A38F < _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8]) {
      _id_76714BF77C396AC3 = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(_id_76714BF77C396AC3 != -1) {
      break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    if(_id_D2392C09DF33A38F > _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8]) {
      _id_85AB47EF7F70892E = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(_id_85AB47EF7F70892E != -1) {
      break;
    }
  }

  if(_id_85AB47EF7F70892E == -1)
    _id_85AB47EF7F70892E = paths.size - 1;

  if(_id_76714BF77C396AC3 == -1)
    _id_76714BF77C396AC3 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4A1A4BEC206CBBA2.size; _id_AC0E594AC96AA3A8++) {}

  _id_3DD1974E56EF9F1C = 1;
  _id_AA14662CAE8D6DEF = [_id_85AB47EF7F70892E, _id_76714BF77C396AC3];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3DD1974E56EF9F1C; _id_AC0E594AC96AA3A8++) {
    if(_id_85AB47EF7F70892E - 1 - _id_AC0E594AC96AA3A8 <= 0)
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = paths.size - 1 - _id_AC0E594AC96AA3A8;
    else
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = _id_85AB47EF7F70892E - 1 - _id_AC0E594AC96AA3A8;

    if(_id_76714BF77C396AC3 + 1 + _id_AC0E594AC96AA3A8 >= paths.size) {
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = 0;
      continue;
    }

    _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = _id_76714BF77C396AC3 + 1 + _id_AC0E594AC96AA3A8;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA14662CAE8D6DEF.size; _id_AC0E594AC96AA3A8++) {}

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA14662CAE8D6DEF.size; _id_AC0E594AC96AA3A8++)
    thread spawnconvoyatpath(paths[_id_AA14662CAE8D6DEF[_id_AC0E594AC96AA3A8]]);
}

spawnspreadconvoy(c130pathstruct) {
  level.br_convoytrucks = [];
  paths = getvehiclenodearray("br_convoy", "targetname");
  _id_A71474BF830DA0CD = [];

  foreach(_id_36809CC9AD8CE6DF in paths) {
    if(distancesquared(_id_36809CC9AD8CE6DF.origin, (19328, 2944, 512)) < 40000)
      _id_A71474BF830DA0CD[_id_A71474BF830DA0CD.size] = _id_36809CC9AD8CE6DF;
  }

  paths = scripts\engine\utility::array_remove_array(paths, _id_A71474BF830DA0CD);
  _id_4D4D20D31099D146 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++)
    _id_4D4D20D31099D146[_id_AC0E594AC96AA3A8] = paths[_id_AC0E594AC96AA3A8];

  mapcenter = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  _id_252E739BC4F9BF6A = c130pathstruct.startpt - mapcenter;
  _id_D2392C09DF33A38F = vectortoangles(_id_252E739BC4F9BF6A)[1];
  _id_4A1A4BEC206CBBA2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    _id_06C192636CDB64A8 = _id_4D4D20D31099D146[_id_AC0E594AC96AA3A8].origin - mapcenter;
    _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8] = vectortoangles(_id_06C192636CDB64A8)[1];
  }

  _id_85AB47EF7F70892E = -1;
  _id_76714BF77C396AC3 = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    if(_id_D2392C09DF33A38F < _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8]) {
      _id_76714BF77C396AC3 = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(_id_76714BF77C396AC3 != -1) {
      break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < paths.size; _id_AC0E594AC96AA3A8++) {
    if(_id_D2392C09DF33A38F > _id_4A1A4BEC206CBBA2[_id_AC0E594AC96AA3A8]) {
      _id_85AB47EF7F70892E = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(_id_85AB47EF7F70892E != -1) {
      break;
    }
  }

  if(_id_85AB47EF7F70892E == -1)
    _id_85AB47EF7F70892E = paths.size - 1;

  if(_id_76714BF77C396AC3 == -1)
    _id_76714BF77C396AC3 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4A1A4BEC206CBBA2.size; _id_AC0E594AC96AA3A8++) {}

  _id_3DD1974E56EF9F1C = 4;
  _id_AA14662CAE8D6DEF = [_id_85AB47EF7F70892E, _id_76714BF77C396AC3];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3DD1974E56EF9F1C; _id_AC0E594AC96AA3A8++) {
    if(_id_85AB47EF7F70892E - 1 - _id_AC0E594AC96AA3A8 <= 0)
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = paths.size - 1 - _id_AC0E594AC96AA3A8;
    else
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = _id_85AB47EF7F70892E - 1 - _id_AC0E594AC96AA3A8;

    if(_id_76714BF77C396AC3 + 1 + _id_AC0E594AC96AA3A8 >= paths.size) {
      _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = 0;
      continue;
    }

    _id_AA14662CAE8D6DEF[_id_AA14662CAE8D6DEF.size] = _id_76714BF77C396AC3 + 1 + _id_AC0E594AC96AA3A8;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA14662CAE8D6DEF.size; _id_AC0E594AC96AA3A8++) {}

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA14662CAE8D6DEF.size; _id_AC0E594AC96AA3A8++)
    thread spawnhalfconvoyatpath(paths[_id_AA14662CAE8D6DEF[_id_AC0E594AC96AA3A8]]);
}

spawnhalfconvoyatpath(path) {
  level endon("game_ended");
  _id_3F04BECC4E20BD5E = 0;

  if(isDefined(path.script_noteworthy)) {
    if(path.script_noteworthy == "left")
      _id_3F04BECC4E20BD5E = 1;
  }

  _id_40D8F3AD63C5ACFD = [];

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 2; _id_AC0E5C4AC96AAA41++) {
    truck = spawntruck(path, path.angles, _id_3F04BECC4E20BD5E);
    _id_40D8F3AD63C5ACFD[_id_40D8F3AD63C5ACFD.size] = truck;
    wait 1.333;
  }

  if(level.mapname == "mp_torez") {
    _id_565E98C561535A89 = 3;
    _id_0F72ADAD998BE7B7 = 17;
  } else {
    _id_565E98C561535A89 = 15;
    _id_0F72ADAD998BE7B7 = 25;
  }

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_40D8F3AD63C5ACFD.size; _id_AC0E5C4AC96AAA41++)
    _id_40D8F3AD63C5ACFD[_id_AC0E5C4AC96AAA41] vehicle_setspeedimmediate(_id_565E98C561535A89, 30, 30);

  wait 10;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_40D8F3AD63C5ACFD.size; _id_AC0E5C4AC96AAA41++)
    _id_40D8F3AD63C5ACFD[_id_AC0E5C4AC96AAA41] vehicle_setspeedimmediate(_id_565E98C561535A89 * 2, 30, 30);

  wait 4;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_40D8F3AD63C5ACFD.size; _id_AC0E5C4AC96AAA41++)
    _id_40D8F3AD63C5ACFD[_id_AC0E5C4AC96AAA41] vehicle_setspeedimmediate(_id_0F72ADAD998BE7B7, 30, 30);
}

spawnconvoyatpath(path) {
  level endon("game_ended");
  _id_3F04BECC4E20BD5E = 0;

  if(isDefined(path.script_noteworthy)) {
    if(path.script_noteworthy == "left")
      _id_3F04BECC4E20BD5E = 1;
  }

  _id_40D8F3AD63C5ACFD = [];

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 4; _id_AC0E5C4AC96AAA41++) {
    _id_40D8F3AD63C5ACFD[_id_40D8F3AD63C5ACFD.size] = spawntruck(path, path.angles, _id_3F04BECC4E20BD5E);
    wait 1.333;
  }

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_40D8F3AD63C5ACFD.size; _id_AC0E5C4AC96AAA41++)
    _id_40D8F3AD63C5ACFD[_id_AC0E5C4AC96AAA41] vehicle_setspeedimmediate(15, 30, 30);

  wait 12;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_40D8F3AD63C5ACFD.size; _id_AC0E5C4AC96AAA41++)
    _id_40D8F3AD63C5ACFD[_id_AC0E5C4AC96AAA41] vehicle_setspeedimmediate(25, 30, 30);
}

spawntruck(path, _id_2626580098D08AE8, left) {
  vehicle = spawnVehicle("veh8_mil_lnd_umike", "umike", "umike", path.origin, _id_2626580098D08AE8);
  vehicle.animname = "umikeVeh";
  vehicle vehicle_setspeedimmediate(25, 30, 30);
  vehicle thread vehiclefollowpath(path);
  vehicle setscriptablepartstate("dustFX", "normal");
  vehicle setscriptablepartstate("exhaustFX", "active");
  level.br_convoytrucks[level.br_convoytrucks.size] = vehicle;
  vehicle.playerslots = [];
  vehicle.br_leftspawn = left;
  return vehicle;
}

vehiclefollowpath(_id_E40DFCD45CBA504F) {
  self endon("death");
  self endon("stop_follow_path");
  self startpath(_id_E40DFCD45CBA504F);
  self playLoopSound("iw8_mp_snatch_convoy_lp");

  for(next_node = getvehiclenode(_id_E40DFCD45CBA504F.target, "targetname"); isDefined(next_node); next_node = getvehiclenode(next_node.target, "targetname")) {
    next_node waittill("trigger");

    if(!isDefined(next_node.target)) {
      break;
    }
  }

  self vehicle_setspeed(0, 30, 30);

  for(vel = self vehicle_getspeed(); vel > 1; vel = self vehicle_getspeed())
    wait 0.1;

  self stoploopsound("iw8_mp_snatch_convoy_lp");
  self stoploopsound("veh_technical_temp_surface");
  level notify("infil_locked");
  thread kickanyremainingplayers();
  wait 3;
  staticmodel = spawn("script_model", self.origin);
  staticmodel setModel("veh8_mil_lnd_umike_static_allied");
  staticmodel.angles = self.angles;
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objid);
  self delete();
}

spawnplayertoconvoy() {
  if(isalive(self)) {
    if(!isDefined(self.didnotselectclassintime)) {
      if(!_id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
        return;
    }

    if(level.teambased)
      playerteam = scripts\mp\utility\teams::getteamdata(self.team, "players");
    else
      playerteam = [self];

    foreach(player in playerteam) {
      player notify("cancel_c130");
      player notify("cancel_heli");
      player unlink();

      if(!isDefined(player.br_truck)) {
        player.br_truck = getnexttruckwithroom(player.team);
        player.br_truck.playerslots[player.br_truck.playerslots.size] = player;
      }

      truck = player.br_truck;
      player.angles = truck.angles;

      if(!isDefined(truck.showonminimap)) {
        truck showicon();
        truck.showonminimap = 1;
      }

      player thread jumplistener(truck);
    }
  }
}

jumplistener(truck) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_convoy");
  self endon("br_jump");
  self.br_infil_type = "convoy";
  thread orbitcam(truck);
  thread listenjump(truck);
  thread listenkick(truck);
}

kickanyremainingplayers() {
  foreach(_id_AC0E424AC96A7113 in self.playerslots) {
    if(isDefined(_id_AC0E424AC96A7113) && isDefined(_id_AC0E424AC96A7113.br_infil_type) && _id_AC0E424AC96A7113.br_infil_type == "convoy") {
      _id_AC0E424AC96A7113 cameradefault();
      _id_AC0E424AC96A7113 unlink();
      _id_AC0E424AC96A7113 thread jumpout(self);
      _id_AC0E424AC96A7113 notify("br_jump");
    }
  }
}

listenkick(truck) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("cancel_heli");
  self endon("br_jump");
  self waittill("halo_kick_c130");
  truck thread kickanyremainingplayers();
}

listenjump(truck) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_convoy");
  self endon("br_jump");

  for(;;) {
    self waittill("halo_jump_c130");

    if(!_id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
      continue;
    }
    if(_id_45B2B4A889E633FA::ispointinbounds(truck.origin)) {
      if(_id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
        _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

        foreach(_id_AC0E424AC96A7113 in _id_6D5ED003AF1F9612) {
          if(_id_AC0E424AC96A7113 != self)
            _id_AC0E424AC96A7113 notify("halo_kick_c130");
        }

        break;
      }
    } else
      self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

    waitframe();
  }

  self cameradefault();
  thread jumpout(truck);
  self notify("br_jump");
}

jumpout(truck) {
  self setclientomnvar("ui_br_infiled", 1);
  self.br_infil_type = undefined;
  _id_71F6A255DCFAA75E = self getplayerangles();
  self unlink();

  if(istrue(truck.br_leftspawn))
    offset = anglestoleft(truck.angles) * 180;
  else
    offset = anglestoright(truck.angles) * 180;

  fwd = anglesToForward(truck.angles);

  if(!isDefined(truck.offloaded))
    truck.offloaded = 0;
  else
    truck.offloaded++;

  if(truck.offloaded == 0)
    offset = offset + fwd * 36;
  else if(truck.offloaded == 1)
    offset = offset - fwd * 36;
  else if(truck.offloaded == 2)
    offset = offset + fwd * 72;
  else
    offset = offset - fwd * 72;

  _id_F9805AAD354A150E = truck.origin + offset + (0, 0, 18000);
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  _id_E021C2744CC7ED68 = physics_raycast(_id_F9805AAD354A150E, _id_F9805AAD354A150E + (0, 0, -20000), contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    castend = _id_E021C2744CC7ED68[0]["position"];
    self setOrigin(castend, 1, 1);
  } else
    self setOrigin(truck.origin + offset, 1, 1);

  waitframe();
  _id_81EF0EBAF8A76116 = game["music"]["snatch_spawn"].size;
  level.cur_infil_track = randomint(_id_81EF0EBAF8A76116);
  self setplayermusicstate(game["music"]["snatch_spawn"][level.cur_infil_track]);
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_convoy::jumpOut()");
  self setplayerangles(_id_71F6A255DCFAA75E);
  self notify("fallDone");
  scripts\cp_mp\parachute::parachutecompletedefault();
}

orbitcam(truck) {
  self.angles = truck.angles;
  self playerlinkTo(truck, "tag_origin");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_convoy::orbitCam()");
  scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0);
  self cameraset("camera_custom_orbit_1");
}

aretrucksvalid() {
  foreach(truck in level.br_convoytrucks) {
    if(!isDefined(truck) || !isDefined(truck.playerslots))
      return 0;
  }

  return 1;
}

getnexttruckwithroom(team) {
  if(level.teambased) {
    foreach(truck in level.br_convoytrucks) {
      if(isDefined(truck.spawnteam) && truck.spawnteam == team && !istruckfull(truck))
        return truck;
    }

    foreach(truck in level.br_convoytrucks) {
      if(!isDefined(truck.spawnteam)) {
        truck.spawnteam = team;
        return truck;
      }
    }
  } else {
    _id_EB444D46ACFE7514 = scripts\engine\utility::array_sort_with_func(level.br_convoytrucks, ::sorttrucksize);

    foreach(truck in _id_EB444D46ACFE7514) {
      if(!istruckfull(truck))
        return truck;
    }
  }

  return undefined;
}

istruckfull(truck) {
  return truck.playerslots.size == 8;
}

sorttrucksize(a, b) {
  return a.playerslots.size < b.playerslots.size;
}

showicon() {
  curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(curobjid == -1)
    return -1;

  scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(curobjid, self);
  scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
  _id_2EAF3F31852684FD = "icon_minimap_bradley";
  scripts\mp\objidpoolmanager::update_objective_icon(curobjid, _id_2EAF3F31852684FD);
  scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(curobjid);
  self.objid = curobjid;
}