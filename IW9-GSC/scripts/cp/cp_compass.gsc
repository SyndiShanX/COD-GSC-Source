/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_compass.gsc
***********************************************/

setupminimap(material, _id_03B70DD7D0D5B9A8) {
  _id_D0C656DDDD860089 = getdvarfloat("scr_requiredmapaspectratio", 1);
  _id_7BA521E5CC4CB125 = [];
  _id_E8972BA2455EA052 = getEntArray("minimap_corner", "targetname");

  if(_id_E8972BA2455EA052.size < 1) {
    return;
  }
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    _id_7BA521E5CC4CB125 = getcornersfromarray(_id_E8972BA2455EA052, 1);

    if(_id_7BA521E5CC4CB125.size != 2)
      _id_7BA521E5CC4CB125 = getcornersfromarray(_id_E8972BA2455EA052, 0);
  } else
    _id_7BA521E5CC4CB125 = [_id_E8972BA2455EA052[0], _id_E8972BA2455EA052[1]];

  mapname = getDvar("ui_mapname");

  switch (mapname) {
    case "cp_quarry03":
      break;
    case "cp_mission_bads":
      break;
    case "cp_dntsk_raid":
      _id_7BA521E5CC4CB125[0].origin = (-65536, 86016, 0);
      _id_7BA521E5CC4CB125[1].origin = (81920, -61440, 0);
      break;
    case "cp_dwn_twn_2":
      _id_7BA521E5CC4CB125[0].origin = (44048, -32792, -152);
      _id_7BA521E5CC4CB125[1].origin = (-1008, 12264, -152);
      break;
    case "cp_arms_dealer":
      _id_7BA521E5CC4CB125[0].origin = (-33792, 23552, 0);
      _id_7BA521E5CC4CB125[1].origin = (-2048, -8192, 0);
      break;
    case "cp_armsdealer_2":
      _id_7BA521E5CC4CB125[0].origin = (-49152, -24576, 0);
      _id_7BA521E5CC4CB125[1].origin = (16384, 40960, 0);
      break;
    case "cp_smuggler":
      _id_7BA521E5CC4CB125[0].origin = (-24576, 65536, 0);
      _id_7BA521E5CC4CB125[1].origin = (45056, -4096, 0);
      break;
    case "cp_smuggler_2":
      _id_7BA521E5CC4CB125[0].origin = (14336, 53248, 0);
      _id_7BA521E5CC4CB125[1].origin = (47104, 20480, 0);
      break;
    case "cp_landlord":
      _id_7BA521E5CC4CB125[0].origin = (4096, 24576, 0);
      _id_7BA521E5CC4CB125[1].origin = (49152, -20480, 0);
      break;
    case "cp_landlord_2":
      _id_7BA521E5CC4CB125[0].origin = (-12288, 72704, 0);
      _id_7BA521E5CC4CB125[1].origin = (32768, 27648, 0);
      break;
    case "cp_raid_complex":
      _id_685B0D8AFD1764DC = [_id_E8972BA2455EA052[0], _id_E8972BA2455EA052[1]];
      _id_685B0D8AFD1764DC[0].origin = (-2620, 8092, 0);
      _id_685B0D8AFD1764DC[1].origin = (3156, 3486, 0);
      setupminimapmaze("compass_map_cp_jugg_maze", _id_685B0D8AFD1764DC, _id_D0C656DDDD860089);
      _id_7BA521E5CC4CB125[0].origin = (-5508, 10395, 0);
      _id_7BA521E5CC4CB125[1].origin = (6044, 1183, 0);
      break;
    case "cp_mission_esc":
      _id_7BA521E5CC4CB125[0].origin = (-57344, 16384, 0);
      _id_7BA521E5CC4CB125[1].origin = (0, -49152, 0);
      break;
  }

  _id_7BA4DEE5CC4C1DCC = (_id_7BA521E5CC4CB125[0].origin[0], _id_7BA521E5CC4CB125[0].origin[1], 0);
  _id_7BA4DFE5CC4C1FFF = (_id_7BA521E5CC4CB125[1].origin[0], _id_7BA521E5CC4CB125[1].origin[1], 0);
  _id_8EE89AF74376AB13 = _id_7BA4DFE5CC4C1FFF - _id_7BA4DEE5CC4C1DCC;
  _id_66D02DCE4615A1F0 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  _id_DE4ABD1411075732 = (0 - _id_66D02DCE4615A1F0[1], _id_66D02DCE4615A1F0[0], 0);

  if(vectordot(_id_8EE89AF74376AB13, _id_DE4ABD1411075732) > 0) {
    if(vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0) > 0) {
      _id_6C2FE87A3F4D8BC7 = _id_7BA4DFE5CC4C1FFF;
      _id_1996B8BC8D47D84F = _id_7BA4DEE5CC4C1DCC;
    } else {
      _id_A66BA9B157533F5A = vecscale(_id_66D02DCE4615A1F0, vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0));
      _id_6C2FE87A3F4D8BC7 = _id_7BA4DFE5CC4C1FFF - _id_A66BA9B157533F5A;
      _id_1996B8BC8D47D84F = _id_7BA4DEE5CC4C1DCC + _id_A66BA9B157533F5A;
    }
  } else if(vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0) > 0) {
    _id_A66BA9B157533F5A = vecscale(_id_66D02DCE4615A1F0, vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0));
    _id_6C2FE87A3F4D8BC7 = _id_7BA4DEE5CC4C1DCC + _id_A66BA9B157533F5A;
    _id_1996B8BC8D47D84F = _id_7BA4DFE5CC4C1FFF - _id_A66BA9B157533F5A;
  } else {
    _id_6C2FE87A3F4D8BC7 = _id_7BA4DEE5CC4C1DCC;
    _id_1996B8BC8D47D84F = _id_7BA4DFE5CC4C1FFF;
  }

  if(_id_D0C656DDDD860089 > 0) {
    _id_9F72E62E262287DF = vectordot(_id_6C2FE87A3F4D8BC7 - _id_1996B8BC8D47D84F, _id_66D02DCE4615A1F0);
    _id_755D4C721ECB6165 = vectordot(_id_6C2FE87A3F4D8BC7 - _id_1996B8BC8D47D84F, _id_DE4ABD1411075732);
    _id_9EFBEAF97C663AB0 = _id_755D4C721ECB6165 / _id_9F72E62E262287DF;

    if(_id_9EFBEAF97C663AB0 < _id_D0C656DDDD860089) {
      _id_AD1167B62B969063 = _id_D0C656DDDD860089 / _id_9EFBEAF97C663AB0;
      _id_5A976CA4F755DC8A = vecscale(_id_DE4ABD1411075732, _id_755D4C721ECB6165 * (_id_AD1167B62B969063 - 1) * 0.5);
    } else {
      _id_AD1167B62B969063 = _id_9EFBEAF97C663AB0 / _id_D0C656DDDD860089;
      _id_5A976CA4F755DC8A = vecscale(_id_66D02DCE4615A1F0, _id_9F72E62E262287DF * (_id_AD1167B62B969063 - 1) * 0.5);
    }

    _id_6C2FE87A3F4D8BC7 = _id_6C2FE87A3F4D8BC7 + _id_5A976CA4F755DC8A;
    _id_1996B8BC8D47D84F = _id_1996B8BC8D47D84F - _id_5A976CA4F755DC8A;
  }

  _id_7BA521E5CC4CB125[0].origin = _id_6C2FE87A3F4D8BC7;
  _id_7BA521E5CC4CB125[1].origin = _id_1996B8BC8D47D84F;
  level.mapsize = vectordot(_id_6C2FE87A3F4D8BC7 - _id_1996B8BC8D47D84F, _id_66D02DCE4615A1F0);
  level.mapcorners = _id_7BA521E5CC4CB125;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45.0);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45.0);

  if(!isDefined(_id_03B70DD7D0D5B9A8) || _id_03B70DD7D0D5B9A8 < 1)
    _id_03B70DD7D0D5B9A8 = 1;

  setminimap(material, _id_6C2FE87A3F4D8BC7[0], _id_6C2FE87A3F4D8BC7[1], _id_1996B8BC8D47D84F[0], _id_1996B8BC8D47D84F[1], _id_03B70DD7D0D5B9A8);
}

setupminimapmaze(material, _id_7BA521E5CC4CB125, _id_D0C656DDDD860089) {
  _id_7BA4DEE5CC4C1DCC = (_id_7BA521E5CC4CB125[0].origin[0], _id_7BA521E5CC4CB125[0].origin[1], 0);
  _id_7BA4DFE5CC4C1FFF = (_id_7BA521E5CC4CB125[1].origin[0], _id_7BA521E5CC4CB125[1].origin[1], 0);
  _id_8EE89AF74376AB13 = _id_7BA4DFE5CC4C1FFF - _id_7BA4DEE5CC4C1DCC;
  _id_66D02DCE4615A1F0 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  _id_DE4ABD1411075732 = (0 - _id_66D02DCE4615A1F0[1], _id_66D02DCE4615A1F0[0], 0);

  if(vectordot(_id_8EE89AF74376AB13, _id_DE4ABD1411075732) > 0) {
    if(vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0) > 0) {
      _id_6C2FE87A3F4D8BC7 = _id_7BA4DFE5CC4C1FFF;
      _id_1996B8BC8D47D84F = _id_7BA4DEE5CC4C1DCC;
    } else {
      _id_A66BA9B157533F5A = vecscale(_id_66D02DCE4615A1F0, vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0));
      _id_6C2FE87A3F4D8BC7 = _id_7BA4DFE5CC4C1FFF - _id_A66BA9B157533F5A;
      _id_1996B8BC8D47D84F = _id_7BA4DEE5CC4C1DCC + _id_A66BA9B157533F5A;
    }
  } else if(vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0) > 0) {
    _id_A66BA9B157533F5A = vecscale(_id_66D02DCE4615A1F0, vectordot(_id_8EE89AF74376AB13, _id_66D02DCE4615A1F0));
    _id_6C2FE87A3F4D8BC7 = _id_7BA4DEE5CC4C1DCC + _id_A66BA9B157533F5A;
    _id_1996B8BC8D47D84F = _id_7BA4DFE5CC4C1FFF - _id_A66BA9B157533F5A;
  } else {
    _id_6C2FE87A3F4D8BC7 = _id_7BA4DEE5CC4C1DCC;
    _id_1996B8BC8D47D84F = _id_7BA4DFE5CC4C1FFF;
  }

  if(_id_D0C656DDDD860089 > 0) {
    _id_9F72E62E262287DF = vectordot(_id_6C2FE87A3F4D8BC7 - _id_1996B8BC8D47D84F, _id_66D02DCE4615A1F0);
    _id_755D4C721ECB6165 = vectordot(_id_6C2FE87A3F4D8BC7 - _id_1996B8BC8D47D84F, _id_DE4ABD1411075732);
    _id_9EFBEAF97C663AB0 = _id_755D4C721ECB6165 / _id_9F72E62E262287DF;

    if(_id_9EFBEAF97C663AB0 < _id_D0C656DDDD860089) {
      _id_AD1167B62B969063 = _id_D0C656DDDD860089 / _id_9EFBEAF97C663AB0;
      _id_5A976CA4F755DC8A = vecscale(_id_DE4ABD1411075732, _id_755D4C721ECB6165 * (_id_AD1167B62B969063 - 1) * 0.5);
    } else {
      _id_AD1167B62B969063 = _id_9EFBEAF97C663AB0 / _id_D0C656DDDD860089;
      _id_5A976CA4F755DC8A = vecscale(_id_66D02DCE4615A1F0, _id_9F72E62E262287DF * (_id_AD1167B62B969063 - 1) * 0.5);
    }

    _id_6C2FE87A3F4D8BC7 = _id_6C2FE87A3F4D8BC7 + _id_5A976CA4F755DC8A;
    _id_1996B8BC8D47D84F = _id_1996B8BC8D47D84F - _id_5A976CA4F755DC8A;
  }

  setminimapcpraidmaze(material, _id_6C2FE87A3F4D8BC7[0], _id_6C2FE87A3F4D8BC7[1], _id_1996B8BC8D47D84F[0], _id_1996B8BC8D47D84F[1]);
}

vecscale(_id_06A3A1033FFC2699, _id_B79930868F410231) {
  return (_id_06A3A1033FFC2699[0] * _id_B79930868F410231, _id_06A3A1033FFC2699[1] * _id_B79930868F410231, _id_06A3A1033FFC2699[2] * _id_B79930868F410231);
}

getcornersfromarray(array, _id_C6F1388C16A82062) {
  _id_7BA521E5CC4CB125 = [];

  if(_id_C6F1388C16A82062) {
    foreach(_id_4E6D9BE609009734 in array) {
      if(isDefined(_id_4E6D9BE609009734.script_noteworthy) && _id_4E6D9BE609009734.script_noteworthy == level.localeid)
        _id_7BA521E5CC4CB125[_id_7BA521E5CC4CB125.size] = _id_4E6D9BE609009734;
    }
  } else {
    foreach(_id_4E6D9BE609009734 in array) {
      if(!isDefined(_id_4E6D9BE609009734.script_noteworthy) || isDefined(_id_4E6D9BE609009734.script_noteworthy) && !issubstr(_id_4E6D9BE609009734.script_noteworthy, "locale"))
        _id_7BA521E5CC4CB125[_id_7BA521E5CC4CB125.size] = _id_4E6D9BE609009734;
    }
  }

  return _id_7BA521E5CC4CB125;
}