/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\compass.gsc
***********************************************/

setupminimap(material, _id_11F306B80AE0C39E, _id_03B70DD7D0D5B9A8) {
  _id_D0C656DDDD860089 = getdvarfloat("scr_requiredmapaspectratio", 1);

  if(!isDefined(_id_11F306B80AE0C39E))
    _id_11F306B80AE0C39E = material;

  _id_7BA521E5CC4CB125 = [];
  _id_E8972BA2455EA052 = getEntArray("minimap_corner", "targetname");
  _id_9454B445960CB2A3 = scripts\mp\utility\game::getgametype() == "war";

  if(scripts\cp_mp\utility\game_utility::isdonetskmap() && !scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && isDefined(level._id_2C81DE0E95B02675)) {
    _id_7BA521E5CC4CB125 = [];

    switch (level._id_2C81DE0E95B02675) {
      case "scrapyard":
        _id_7BA521E5CC4CB125[0] = spawn("script_origin", (-29090, -7407, -52));
        _id_7BA521E5CC4CB125[1] = spawn("script_origin", (-22443, -13974, -52));
        break;
      case "tvstation":
        _id_7BA521E5CC4CB125[0] = spawn("script_origin", (9791, 22530, 0));
        _id_7BA521E5CC4CB125[1] = spawn("script_origin", (17989, 14337, 0));
        break;
      case "supercenter":
        _id_7BA521E5CC4CB125[0] = spawn("script_origin", (-17723, 13495, 0));
        _id_7BA521E5CC4CB125[1] = spawn("script_origin", (-8060, 3721, 0));
        break;
      default:
        return;
    }
  } else if(!_id_9454B445960CB2A3 && isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && !scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    if(level.localeid != "locale_6") {
      _id_7BA521E5CC4CB125 = getcornersfromarray(_id_E8972BA2455EA052, 1);

      if(_id_7BA521E5CC4CB125.size != 2)
        _id_7BA521E5CC4CB125 = getcornersfromarray(_id_E8972BA2455EA052, 0);
    } else {
      _id_7BA521E5CC4CB125 = [];
      _id_7BA521E5CC4CB125[0] = spawn("script_origin", (-1040, 12288, -136));
      _id_7BA521E5CC4CB125[1] = spawn("script_origin", (44016, -32768, -136));
    }

    switch (scripts\mp\utility\game::getgametype()) {
      case "rescue":
      case "bigctf":
      case "conflict":
      case "cyber":
      case "sd":
      case "arm":
        material = material + "_" + level.localeid;
        _id_11F306B80AE0C39E = _id_11F306B80AE0C39E + "_" + level.localeid;
        break;
    }
  } else if(scripts\cp_mp\utility\game_utility::isdonetskmap() || scripts\cp_mp\utility\game_utility::getmapname() == "mp_br_quarry") {
    _id_7BA521E5CC4CB125 = [];
    _id_7BA521E5CC4CB125[0] = spawn("script_origin", (-65536, 86016, 5400));
    _id_7BA521E5CC4CB125[1] = spawn("script_origin", (81920, -61440, -2048));
  } else
    _id_7BA521E5CC4CB125 = getcornersfromarray(_id_E8972BA2455EA052, 0);

  if(_id_7BA521E5CC4CB125.size != 2) {
    return;
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

  setminimap(material, _id_6C2FE87A3F4D8BC7[0], _id_6C2FE87A3F4D8BC7[1], _id_1996B8BC8D47D84F[0], _id_1996B8BC8D47D84F[1], _id_03B70DD7D0D5B9A8, _id_11F306B80AE0C39E);
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