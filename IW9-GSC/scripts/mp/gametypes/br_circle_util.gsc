/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_circle_util.gsc
***************************************************/

_id_C7F3AE56442546D1(origin, _id_CF3800024083ABBE, _id_79A6E85C95FE549B, _id_B7C9FE00120EA96C, _id_437C3E3159A04F4E) {
  if(!isDefined(_id_CF3800024083ABBE) || _id_CF3800024083ABBE.size < 2 || _id_CF3800024083ABBE[0] <= 0)
    return undefined;

  _id_38A4C729748AD94C = getdvarint("dvar_67A8C844BAD5A45B", 0);

  if(!_id_38A4C729748AD94C && _id_362C58E8BB39BCDA::isfeatureenabled("circleSnapToNavMesh"))
    _id_38A4C729748AD94C = 1;

  _id_8AE269616D09DFC5 = [];
  _id_8AE269616D09DFC5[0] = (origin[0], origin[1], 0.0);
  radius = _id_CF3800024083ABBE[0];
  _id_D6BAC3BF0F64D280 = 1.0 - _id_CF3800024083ABBE[1] / radius;
  _id_2082F17F2E1C69BF = _id_CF3800024083ABBE.size - 1;
  _id_8AE269616D09DFC5[_id_2082F17F2E1C69BF] = _id_2695A20D4011076D::getrandompointinboundscircle(origin, radius, 0.0, _id_D6BAC3BF0F64D280, 1, _id_38A4C729748AD94C, 1);

  if(istrue(_id_437C3E3159A04F4E))
    return _id_8AE269616D09DFC5;

  _id_7A50883C31353C77 = getdvarfloat("dvar_917B939513F89B55", 200);
  _id_11C1E6222DA58849 = getdvarint("dvar_E65611A4D524BCBE", 0);

  for(circleindex = _id_2082F17F2E1C69BF - 1; circleindex >= 0; circleindex--) {
    origin = _id_8AE269616D09DFC5[circleindex + 1];
    radius = _id_CF3800024083ABBE[circleindex];
    _id_9BEDD0ECB39838D6 = 0.0;
    _id_D6BAC3BF0F64D280 = 1.0 - _id_CF3800024083ABBE[circleindex + 1] / radius;
    _id_B1D0BC03029F6A2C = _id_9BEDD0ECB39838D6 + randomfloat(_id_D6BAC3BF0F64D280 - _id_9BEDD0ECB39838D6);
    _id_C2D7D58BFAD1B1EE = _id_79A6E85C95FE549B[circleindex];
    prevradius = _id_CF3800024083ABBE[circleindex + 1];
    _id_6041996E5CA4B1F3 = radius - prevradius;
    _id_C9F9B6297AB4434A = _id_6041996E5CA4B1F3 / _id_C2D7D58BFAD1B1EE;
    _id_599CA8AAC66AED6F = max(0, _id_7A50883C31353C77 - _id_C9F9B6297AB4434A);
    _id_797B88A97BEDC494 = _id_599CA8AAC66AED6F * _id_C2D7D58BFAD1B1EE;
    _id_6443D240572E7A5B = _id_797B88A97BEDC494 / radius;
    _id_3F139F4756AD700E = _id_B1D0BC03029F6A2C > _id_6443D240572E7A5B;

    if(_id_3F139F4756AD700E && !istrue(_id_B7C9FE00120EA96C)) {
      _id_9ED6827753DB2370 = _id_C9F9B6297AB4434A + _id_B1D0BC03029F6A2C * radius / _id_C2D7D58BFAD1B1EE;
      dlog_recordevent("dlog_event_br_circle_speed_warning", ["player_speed", _id_7A50883C31353C77, "circle_speed", _id_9ED6827753DB2370, "circle_close_time", float(_id_C2D7D58BFAD1B1EE), "circle_current_radius", float(radius), "circle_next_radius", float(prevradius)]);
    }

    if(circleindex) {
      if(_id_11C1E6222DA58849 && _id_3F139F4756AD700E)
        _id_B1D0BC03029F6A2C = _id_9BEDD0ECB39838D6 + randomfloat(_id_6443D240572E7A5B - _id_9BEDD0ECB39838D6);

      _id_8AE269616D09DFC5[circleindex] = _id_2695A20D4011076D::getrandompointinboundscircle(origin, radius, _id_B1D0BC03029F6A2C, _id_B1D0BC03029F6A2C, 1, _id_38A4C729748AD94C, 1);
      continue;
    }
  }

  return _id_8AE269616D09DFC5;
}

_id_A09532919AE80718(_id_FC0802BC96B1CCBE, _id_8AE269616D09DFC5, _id_CF3800024083ABBE, _id_38A4C729748AD94C) {
  _id_48C37D0BEF1C3760 = [];

  for(circleindex = 1; circleindex <= _id_FC0802BC96B1CCBE; circleindex++) {
    _id_9D2610F6A0B725A4 = _id_CF3800024083ABBE[circleindex - 1];
    _id_A754CFA0FF072630 = _id_8AE269616D09DFC5[circleindex - 1];
    _id_2E8E1BBFFD8BC082 = _id_CF3800024083ABBE[circleindex];
    _id_636C8575D7A7768B = _id_9D2610F6A0B725A4 + _id_2E8E1BBFFD8BC082 + level.br_level.br_movingcirclemovedistmin;
    maxdist = _id_9D2610F6A0B725A4 + _id_2E8E1BBFFD8BC082 + level.br_level.br_movingcirclemovedistmax;
    _id_48C37D0BEF1C3760[circleindex - 1] = _id_2695A20D4011076D::getrandompointinboundscircle(_id_A754CFA0FF072630, maxdist, _id_636C8575D7A7768B / maxdist, 1.0, 1, _id_38A4C729748AD94C, 1);
  }

  return _id_48C37D0BEF1C3760;
}

_id_D987886BB9DE9137() {
  if(!istrue(level._id_2DF69B8E552238B6))
    return 0;

  return level._id_B31733F431ED12E0._id_209967C144016964;
}

_id_D8FBACC18E5D8498() {
  return _id_D987886BB9DE9137() > 1 && level.br_circle.circleindex + 1 == level._id_B31733F431ED12E0._id_C22567ED8CFE3761;
}

_id_29E8194FF7E13E2E() {
  return _id_49411683F5A51DAA(level.br_circle.circleindex + 1);
}

_id_49411683F5A51DAA(circleindex) {
  if(isDefined(level._id_B31733F431ED12E0._id_29E8194FF7E13E2E))
    return [[level._id_B31733F431ED12E0._id_29E8194FF7E13E2E]](circleindex);

  return _id_D987886BB9DE9137() > 1 && (circleindex < level._id_B31733F431ED12E0._id_8A10C39962F6D9FD || circleindex > level._id_B31733F431ED12E0._id_C22567ED8CFE3761);
}

_id_57F3FD16B628C829(circleindex) {
  _id_A9ED63230D9A3C95 = level.br_level.br_circleshowdelaydanger[circleindex];

  if(_id_A9ED63230D9A3C95 > 0) {
    _id_2695A20D4011076D::hidedangercircle();
    scripts\engine\utility::delaythread(_id_A9ED63230D9A3C95, _id_2695A20D4011076D::showdangercircle);
  }

  _id_4F48A6344EC8A9C7 = level.br_level.br_circleshowdelaysafe[circleindex];

  if(_id_4F48A6344EC8A9C7 > 0) {
    _id_2695A20D4011076D::hidesafecircle();
    scripts\engine\utility::delaythread(_id_4F48A6344EC8A9C7, _id_2695A20D4011076D::showsafecircle);
  }
}

_id_47759B7ED0818A3F(circleindex, _id_F007CE073DC3C519) {
  if(_id_2695A20D4011076D::canplaycircleopendialog(circleindex)) {
    if(_id_F007CE073DC3C519)
      _id_2CEDCC356F1B9FC8::brleaderdialog("first_circle", 1);
    else
      _id_2CEDCC356F1B9FC8::brleaderdialog("new_circle", 1);
  }
}

_id_8D09229C08ABD549(circleindex, _id_6B890E6BE7982EFB) {
  if(_id_2695A20D4011076D::canplaycircleclosedialog(circleindex)) {
    if(_id_6B890E6BE7982EFB)
      _id_2CEDCC356F1B9FC8::brleaderdialog("final_circle", 1);
    else {
      _id_2CEDCC356F1B9FC8::brleaderdialog("circle_closing", 1);
      thread _id_2695A20D4011076D::brcirclebattlechatter(circleindex);
    }
  }
}

_id_6AB5543CE292E3FC(circleindex) {}

_id_D19F6D13E6CEFCE8(circleindex) {}

_id_EA6CDF6492DFB4FA() {
  return getdvarint("dvar_AFE2A26CDA0AAF42", 0);
}

_id_8C0F978940451524(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(isDefined(level._id_9EBEF1EFB6E8A3A9)) {
    foreach(callback in level._id_9EBEF1EFB6E8A3A9)[[callback]](_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A);
  }
}

_id_EBDD2E77A8ADE959() {
  if(isDefined(level._id_C7FD2B5CF3ACB3DA)) {
    foreach(_id_7F590F6AE7F3BC83, callback in level._id_C7FD2B5CF3ACB3DA) {
      _id_CC99AC1EFB0BDA2B = [[callback]]();

      if(isDefined(_id_CC99AC1EFB0BDA2B) && _id_CC99AC1EFB0BDA2B.size > 0 && !_id_EA6CDF6492DFB4FA()) {
        _id_CC99AC1EFB0BDA2B = scripts\engine\utility::array_remove_duplicates(_id_CC99AC1EFB0BDA2B);
        level._id_8A12E160A2617C92[_id_7F590F6AE7F3BC83] = scripts\engine\utility::array_combine_unique(level._id_8A12E160A2617C92[_id_7F590F6AE7F3BC83], _id_CC99AC1EFB0BDA2B);
      }
    }
  }
}

_id_0799FE4EE850F911(circleindex) {
  if(!isDefined(level._id_B31733F431ED12E0) || !isDefined(level._id_B31733F431ED12E0._id_8D99DD732455FBF2) || !isDefined(level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]) || !isDefined(level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]._id_3FF449A8EEC1B966))
    return (0, 0, 0);

  _id_2EA62E9EF5A332E8 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]._id_3FF449A8EEC1B966._id_933B2A39EBFD2AD9;

  if(!isDefined(_id_2EA62E9EF5A332E8))
    return (0, 0, 0);

  return (_id_2EA62E9EF5A332E8.origin[0], _id_2EA62E9EF5A332E8.origin[1], 0.0);
}

_id_8A985543E6853BBD(circleindex) {
  _id_2EA62E9EF5A332E8 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]._id_3FF449A8EEC1B966._id_933B2A39EBFD2AD9;

  if(!isDefined(_id_2EA62E9EF5A332E8))
    return 0.0;

  return _id_2EA62E9EF5A332E8.origin[2];
}

_id_755C691F70EAFE3B(circleindex) {
  _id_C74ADCAAE49E4E42 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]._id_3FF449A8EEC1B966._id_46870B6FA8AD4427;

  if(!isDefined(_id_C74ADCAAE49E4E42))
    return (0, 0, 0);

  return (_id_C74ADCAAE49E4E42.origin[0], _id_C74ADCAAE49E4E42.origin[1], 0.0);
}

_id_0A835B5DFF878F77(circleindex) {
  _id_C74ADCAAE49E4E42 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[circleindex]._id_3FF449A8EEC1B966._id_46870B6FA8AD4427;

  if(!isDefined(_id_C74ADCAAE49E4E42))
    return 0.0;

  return _id_C74ADCAAE49E4E42.origin[2];
}

_id_D277283FB9AD5D46(origin, index, _id_BE8E05F747D3CA77) {
  _id_C74ADCAAE49E4E42 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[index]._id_3FF449A8EEC1B966._id_46870B6FA8AD4427;

  if(!isDefined(_id_C74ADCAAE49E4E42))
    return 0;

  if(!isDefined(origin))
    return 0;

  _id_819EDACDACB810E4 = (_id_C74ADCAAE49E4E42.origin[0], _id_C74ADCAAE49E4E42.origin[1], 0.0);
  _id_E86632D645C137D0 = _id_C74ADCAAE49E4E42.origin[2];

  if(isDefined(_id_BE8E05F747D3CA77))
    _id_E86632D645C137D0 = _id_E86632D645C137D0 + _id_BE8E05F747D3CA77;

  if(distance2dsquared(_id_819EDACDACB810E4, origin) < _id_E86632D645C137D0 * _id_E86632D645C137D0)
    return 1;

  return 0;
}

_id_EE854FDD1E77EFC4(origin, _id_427D3B5A8969DEF8) {
  if(!istrue(level._id_2DF69B8E552238B6))
    return 0;

  if(!isDefined(_id_427D3B5A8969DEF8))
    _id_427D3B5A8969DEF8 = 0;

  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_29E8194FF7E13E2E())
    _id_C669C821EE772A3D = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_B7A43CF03194D69A = _id_D277283FB9AD5D46(origin, _id_AC0E594AC96AA3A8, _id_427D3B5A8969DEF8);

    if(istrue(_id_B7A43CF03194D69A))
      return 1;
  }

  return 0;
}

_id_783961B002F33360(origin, index, _id_BE8E05F747D3CA77) {
  if(!isDefined(level._id_B31733F431ED12E0._id_8D99DD732455FBF2[index]._id_3FF449A8EEC1B966))
    return undefined;

  _id_2EA62E9EF5A332E8 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[index]._id_3FF449A8EEC1B966._id_933B2A39EBFD2AD9;
  _id_ADD4FD7502A75A8A = (_id_2EA62E9EF5A332E8.origin[0], _id_2EA62E9EF5A332E8.origin[1], 0.0);
  _id_77E882DA07E78CFE = _id_2EA62E9EF5A332E8.origin[2];

  if(isDefined(_id_BE8E05F747D3CA77))
    _id_77E882DA07E78CFE = _id_77E882DA07E78CFE + _id_BE8E05F747D3CA77;

  if(distance2dsquared(_id_ADD4FD7502A75A8A, origin) < _id_77E882DA07E78CFE * _id_77E882DA07E78CFE)
    return 1;

  return 0;
}

_id_27779E30FE4C0D62(origin) {
  if(!istrue(level._id_2DF69B8E552238B6))
    return 0;

  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_29E8194FF7E13E2E())
    _id_C669C821EE772A3D = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_001B33A8292E7044 = _id_783961B002F33360(origin, _id_AC0E594AC96AA3A8);

    if(istrue(_id_001B33A8292E7044))
      return 1;
  }

  return 0;
}

_id_77CEC84F05CA9418(point1, _id_BF69DB3C5A539FAD, _id_BE8E05F747D3CA77) {
  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    if(_id_D277283FB9AD5D46(point1, _id_AC0E594AC96AA3A8, _id_BE8E05F747D3CA77) && _id_D277283FB9AD5D46(_id_BF69DB3C5A539FAD, _id_AC0E594AC96AA3A8, _id_BE8E05F747D3CA77))
      return 1;
  }

  return 0;
}

_id_DE2F1B656EE04BA9() {
  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D > 1) {
    _id_F2C46154D60D119B = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      safeorigin = _id_0799FE4EE850F911(_id_AC0E594AC96AA3A8);
      _id_F2C46154D60D119B[_id_F2C46154D60D119B.size] = safeorigin;
    }

    return _id_F2C46154D60D119B;
  } else {
    safeorigin = _id_2695A20D4011076D::getsafecircleorigin();
    return [safeorigin];
  }
}

_id_54798383FA7F572B() {
  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D > 1) {
    _id_5960287DE2E9EB0D = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      _id_F434D604C09196AA = _id_8A985543E6853BBD(_id_AC0E594AC96AA3A8);
      _id_5960287DE2E9EB0D[_id_5960287DE2E9EB0D.size] = _id_F434D604C09196AA;
    }

    return _id_5960287DE2E9EB0D;
  } else {
    _id_F434D604C09196AA = _id_2695A20D4011076D::getsafecircleradius();
    return [_id_F434D604C09196AA];
  }
}

_id_7D381171EAE99B77() {
  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D > 1) {
    _id_C86BC952D8CC7C15 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      _id_EF8F7E66DC0FEB2C = _id_755C691F70EAFE3B(_id_AC0E594AC96AA3A8);
      _id_C86BC952D8CC7C15[_id_C86BC952D8CC7C15.size] = _id_EF8F7E66DC0FEB2C;
    }

    return _id_C86BC952D8CC7C15;
  } else {
    _id_EF8F7E66DC0FEB2C = _id_2695A20D4011076D::getdangercircleorigin();
    return [_id_EF8F7E66DC0FEB2C];
  }
}

_id_BF15A5AA7E72AEE9() {
  _id_C669C821EE772A3D = _id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D > 1) {
    _id_18A9373B09AC2FB7 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      _id_B2739C0F5213D0E8 = _id_0A835B5DFF878F77(_id_AC0E594AC96AA3A8);
      _id_18A9373B09AC2FB7[_id_18A9373B09AC2FB7.size] = _id_B2739C0F5213D0E8;
    }

    return _id_18A9373B09AC2FB7;
  } else {
    _id_B2739C0F5213D0E8 = _id_2695A20D4011076D::getdangercircleradius();
    return [_id_B2739C0F5213D0E8];
  }
}

_id_A465E3C1371D7DAB(point) {
  if(istrue(level.br_circle_disabled))
    return 1;
  else if(_id_D987886BB9DE9137() > 1)
    return _id_27779E30FE4C0D62(point);
  else
    return _id_2695A20D4011076D::ispointincurrentsafecircle(point);
}

_id_778A4C3D053ED0A9(point) {
  if(istrue(level.br_circle_disabled))
    return 1;
  else if(_id_D987886BB9DE9137() > 1)
    return _id_EE854FDD1E77EFC4(point);
  else
    return _id_2695A20D4011076D::_id_C11714256F856E10(point);
}

_id_D12A7C7251710CBF() {
  totaltime = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circleclosetimes.size; _id_AC0E594AC96AA3A8++)
    totaltime = totaltime + level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++)
    totaltime = totaltime + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];

  logstring("br_circle_util::logTotalMatchTime = " + totaltime + " seconds");
}

_id_60951B84C58915AB(_id_208B20B100E6C745, _id_FF696AC4914036EE) {
  if(!isDefined(_id_FF696AC4914036EE))
    _id_FF696AC4914036EE = 0.0;

  times = [];

  if(istrue(level._id_2DF69B8E552238B6))
    _id_ED09715E306A1455 = level._id_B31733F431ED12E0;
  else {
    _id_ED09715E306A1455 = spawnStruct();
    _id_ED09715E306A1455._id_8D99DD732455FBF2[0] = spawnStruct();
    _id_ED09715E306A1455._id_8D99DD732455FBF2[0]._id_8AE269616D09DFC5 = level.br_level.br_circlecenters;
  }

  for(_id_C669C821EE772A3D = 0; _id_C669C821EE772A3D < _id_ED09715E306A1455._id_8D99DD732455FBF2.size; _id_C669C821EE772A3D++) {
    currenttime = 0;
    _id_8AE269616D09DFC5 = _id_ED09715E306A1455._id_8D99DD732455FBF2[_id_C669C821EE772A3D]._id_8AE269616D09DFC5;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AE269616D09DFC5.size - 1; _id_AC0E594AC96AA3A8++) {
      _id_8ACE8BF028CAA1D8 = _id_8AE269616D09DFC5[_id_AC0E594AC96AA3A8];
      nextorigin = _id_8AE269616D09DFC5[_id_AC0E594AC96AA3A8 + 1];
      _id_069FB8ED6A22E7FC = level.br_level.br_circleradii[_id_AC0E594AC96AA3A8];
      nextradius = level.br_level.br_circleradii[_id_AC0E594AC96AA3A8 + 1];
      currenttime = currenttime + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
      _id_CDDE4278F5299544 = _id_8E302A1EC10649A7(_id_208B20B100E6C745, _id_8ACE8BF028CAA1D8, _id_069FB8ED6A22E7FC, nextorigin, nextradius, _id_AC0E594AC96AA3A8);

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_CDDE4278F5299544.size; _id_AC0E5C4AC96AAA41++) {
        _id_CDDE4278F5299544[_id_AC0E5C4AC96AAA41].time = currenttime + level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] * _id_CDDE4278F5299544[_id_AC0E5C4AC96AAA41].time;
        times[times.size] = _id_CDDE4278F5299544[_id_AC0E5C4AC96AAA41];
      }

      currenttime = currenttime + level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];
    }
  }

  _id_44AE6500062C31B4 = scripts\mp\utility\script::quicksort(times, ::_id_71B56C961304206D);
  _id_CBF0338845C22288 = 0;

  for(_id_C669C821EE772A3D = 0; _id_C669C821EE772A3D < _id_ED09715E306A1455._id_8D99DD732455FBF2.size; _id_C669C821EE772A3D++) {
    _id_8AE269616D09DFC5 = _id_ED09715E306A1455._id_8D99DD732455FBF2[_id_C669C821EE772A3D]._id_8AE269616D09DFC5;
    dist = distance2d(_id_208B20B100E6C745, _id_8AE269616D09DFC5[0]);

    if(dist < level.br_level.br_circleradii[0])
      _id_CBF0338845C22288++;
  }

  times = [];
  times[0] = _id_A0662C2865628336(0.0, scripts\engine\utility::ter_op(_id_CBF0338845C22288 > 0, 0, 1), -1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_44AE6500062C31B4.size; _id_AC0E594AC96AA3A8++) {
    addtime = 0;
    state = _id_44AE6500062C31B4[_id_AC0E594AC96AA3A8].state;

    if(state == 0) {
      addtime = _id_CBF0338845C22288 == 0;
      _id_CBF0338845C22288++;
    } else {
      _id_CBF0338845C22288--;
      addtime = _id_CBF0338845C22288 == 0;
    }

    if(addtime) {
      times[times.size] = _id_44AE6500062C31B4[_id_AC0E594AC96AA3A8];

      if(_id_FF696AC4914036EE > 0 && times.size > 2) {
        _id_56DDE920C84C7B04 = times[times.size - 1].time - times[times.size - 2].time;

        if(_id_56DDE920C84C7B04 <= _id_FF696AC4914036EE) {
          times[times.size - 1] = undefined;
          times[times.size - 1] = undefined;
        }
      }
    }
  }

  return times;
}

_id_03E0A90B32E551AD(_id_208B20B100E6C745) {
  times = _id_60951B84C58915AB(_id_208B20B100E6C745);
  return _id_7D8550B9A2C52852(times);
}

_id_7D8550B9A2C52852(times) {
  return _id_097DC13FD8DE003A(times, 1);
}

_id_F487A2A306E21BDB(_id_208B20B100E6C745) {
  times = _id_60951B84C58915AB(_id_208B20B100E6C745);
  return _id_169347C7DE51F088(times);
}

_id_169347C7DE51F088(times) {
  return _id_097DC13FD8DE003A(times, 0);
}

_id_097DC13FD8DE003A(times, state) {
  _id_E39D8E5A89E12A3E = level.br_circle._id_5B8569581E64D55A;

  if(!isDefined(_id_E39D8E5A89E12A3E))
    _id_E39D8E5A89E12A3E = gettime();

  _id_F17B39DCB7F8FC64 = (gettime() - _id_E39D8E5A89E12A3E) / 1000;
  _id_32D80FCB3FAEFE9B = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < times.size; _id_AC0E594AC96AA3A8++) {
    if(times[_id_AC0E594AC96AA3A8].time <= _id_F17B39DCB7F8FC64)
      _id_32D80FCB3FAEFE9B = _id_AC0E594AC96AA3A8;
  }

  if(times[_id_32D80FCB3FAEFE9B].state == state)
    return 0;
  else if(_id_32D80FCB3FAEFE9B == times.size - 1)
    return 999999;
  else
    return times[_id_32D80FCB3FAEFE9B + 1].time - _id_F17B39DCB7F8FC64;
}

_id_D5CF183EE258BEFB(_id_208B20B100E6C745, _id_3BC3E3FAACFEA87F) {
  times = _id_60951B84C58915AB(_id_208B20B100E6C745);
  return _id_AE20EFD2C4B04628(times, _id_3BC3E3FAACFEA87F);
}

_id_AE20EFD2C4B04628(times, _id_3BC3E3FAACFEA87F) {
  if(!isDefined(_id_3BC3E3FAACFEA87F))
    _id_3BC3E3FAACFEA87F = 0;

  _id_E39D8E5A89E12A3E = level.br_circle._id_5B8569581E64D55A;

  if(!isDefined(_id_E39D8E5A89E12A3E))
    _id_E39D8E5A89E12A3E = gettime();

  _id_F17B39DCB7F8FC64 = (gettime() - _id_E39D8E5A89E12A3E) / 1000 + _id_3BC3E3FAACFEA87F;
  _id_32D80FCB3FAEFE9B = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < times.size; _id_AC0E594AC96AA3A8++) {
    if(times[_id_AC0E594AC96AA3A8].time <= _id_F17B39DCB7F8FC64)
      _id_32D80FCB3FAEFE9B = _id_AC0E594AC96AA3A8;
  }

  if(times[_id_32D80FCB3FAEFE9B].state == 1)
    return times[_id_32D80FCB3FAEFE9B].circleindex;
  else if(_id_32D80FCB3FAEFE9B == times.size - 1)
    return level.br_level.br_circleradii.size - 1;
  else
    return times[_id_32D80FCB3FAEFE9B + 1].circleindex;
}

_id_A0662C2865628336(time, state, circleindex) {
  s = spawnStruct();
  s.time = time;
  s.state = state;
  s.circleindex = circleindex;
  return s;
}

_id_71B56C961304206D(left, right) {
  if(left.time == right.time)
    return left.state == 0;

  return left.time <= right.time;
}

_id_8E302A1EC10649A7(point, _id_E0134DCE95218ED1, _id_918D83C6C0649565, _id_F0FFC87D0DB8E9F0, _id_F44DA00498B2397C, circleindex) {
  point = scripts\engine\utility::flat_origin(point);
  _id_E0134DCE95218ED1 = scripts\engine\utility::flat_origin(_id_E0134DCE95218ED1);
  _id_F0FFC87D0DB8E9F0 = scripts\engine\utility::flat_origin(_id_F0FFC87D0DB8E9F0);
  _id_FF9F30CB636C0C11 = _id_F0FFC87D0DB8E9F0 - _id_E0134DCE95218ED1;
  _id_0ACF5677037D72B7 = _id_F44DA00498B2397C - _id_918D83C6C0649565;
  _id_00F9C704A1505E0E = _func_767CEA82B001F645(point - _id_E0134DCE95218ED1);
  _id_B4CCF27C9108E492 = point - _id_FF9F30CB636C0C11;
  _id_AC0E564AC96A9D0F = _id_B4CCF27C9108E492 - point;
  f = point - _id_E0134DCE95218ED1;
  a = vectordot(_id_AC0E564AC96A9D0F, _id_AC0E564AC96A9D0F) - _id_0ACF5677037D72B7 * _id_0ACF5677037D72B7;
  b = 2.0 * vectordot(f, _id_AC0E564AC96A9D0F) - 2.0 * _id_0ACF5677037D72B7 * _id_918D83C6C0649565;
  c = vectordot(f, f) - _id_918D83C6C0649565 * _id_918D83C6C0649565;
  results = [];
  _id_7FD3C5B70FED3FE8 = b * b - 4 * a * c;

  if(_id_7FD3C5B70FED3FE8 >= 0 && a != 0) {
    _id_7FD3C5B70FED3FE8 = sqrt(_id_7FD3C5B70FED3FE8);
    _id_CDDE8478F52A266A = (-1.0 * b - _id_7FD3C5B70FED3FE8) / (2 * a);
    _id_CDDE8378F52A2437 = (-1.0 * b + _id_7FD3C5B70FED3FE8) / (2 * a);

    if(_id_CDDE8478F52A266A >= 0 && _id_CDDE8478F52A266A <= 1)
      results[results.size] = _id_A0662C2865628336(_id_CDDE8478F52A266A, 0, circleindex);

    if(_id_CDDE8378F52A2437 >= 0 && _id_CDDE8378F52A2437 <= 1)
      results[results.size] = _id_A0662C2865628336(_id_CDDE8378F52A2437, 1, circleindex);
  }

  return results;
}

_id_06EC3B4C4B5A9EDD(time) {
  starttime = level.br_circle._id_5B8569581E64D55A;

  if(!isDefined(starttime))
    return undefined;

  if(istrue(level._id_2DF69B8E552238B6))
    _id_ED09715E306A1455 = level._id_B31733F431ED12E0;
  else {
    _id_ED09715E306A1455 = spawnStruct();
    _id_ED09715E306A1455._id_8D99DD732455FBF2[0] = spawnStruct();
    _id_ED09715E306A1455._id_8D99DD732455FBF2[0]._id_8AE269616D09DFC5 = level.br_level.br_circlecenters;
  }

  _id_0DCD431A09A9A211 = [];

  for(_id_C669C821EE772A3D = 0; _id_C669C821EE772A3D < _id_ED09715E306A1455._id_8D99DD732455FBF2.size; _id_C669C821EE772A3D++) {
    _id_E858A946B115578A = (time - starttime) / 1000;
    _id_23F4DD5F3CFEE9F5 = spawnStruct();
    _id_8AE269616D09DFC5 = _id_ED09715E306A1455._id_8D99DD732455FBF2[_id_C669C821EE772A3D]._id_8AE269616D09DFC5;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AE269616D09DFC5.size - 1; _id_AC0E594AC96AA3A8++) {
      _id_8ACE8BF028CAA1D8 = _id_8AE269616D09DFC5[_id_AC0E594AC96AA3A8];
      _id_069FB8ED6A22E7FC = level.br_level.br_circleradii[_id_AC0E594AC96AA3A8];
      _id_E858A946B115578A = _id_E858A946B115578A - level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];

      if(_id_E858A946B115578A <= 0) {
        _id_23F4DD5F3CFEE9F5.origin = _id_8ACE8BF028CAA1D8;
        _id_23F4DD5F3CFEE9F5.radius = _id_069FB8ED6A22E7FC;
        break;
      }

      _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];
      _id_E858A946B115578A = _id_E858A946B115578A - _id_C2D7D58BFAD1B1EE;

      if(_id_E858A946B115578A <= 0) {
        frac = (_id_E858A946B115578A + _id_C2D7D58BFAD1B1EE) / _id_C2D7D58BFAD1B1EE;
        frac = clamp(frac, 0.0, 1.0);
        nextorigin = _id_8AE269616D09DFC5[_id_AC0E594AC96AA3A8 + 1];
        _id_23F4DD5F3CFEE9F5.origin = vectorlerp(_id_8ACE8BF028CAA1D8, nextorigin, frac);
        nextradius = level.br_level.br_circleradii[_id_AC0E594AC96AA3A8 + 1];
        _id_23F4DD5F3CFEE9F5.radius = scripts\engine\math::lerp(_id_069FB8ED6A22E7FC, nextradius, frac);
        break;
      }
    }

    if(_id_E858A946B115578A > 0) {
      _id_23F4DD5F3CFEE9F5.origin = _id_8AE269616D09DFC5[_id_8AE269616D09DFC5.size - 1];
      _id_23F4DD5F3CFEE9F5.radius = level.br_level.br_circleradii[_id_8AE269616D09DFC5.size - 1];
    }

    _id_0DCD431A09A9A211[_id_C669C821EE772A3D] = _id_23F4DD5F3CFEE9F5;
  }

  return _id_0DCD431A09A9A211;
}

_id_8E779F490BBD1AE9() {
  if(getdvarint("dvar_CB361CA8AA1B869F", 0) == 0) {
    return;
  }
  _id_9676775270CEF770 = _id_0A3920E4DDD93CF3();

  for(;;) {
    level waittill("br_circle_set");
    _id_758A502ACDAE3FFB = _id_0A3920E4DDD93CF3();

    if(_id_758A502ACDAE3FFB._id_0C0AB0189903C9D4 <= 0) {
      _id_9676775270CEF770 = _id_758A502ACDAE3FFB;
      continue;
    }

    _id_D04962FA7F3EF6A1 = gettime();
    _id_A9E9A1C18405739C = _id_D04962FA7F3EF6A1 + 10000;

    while(gettime() < _id_A9E9A1C18405739C) {
      progress = (gettime() - _id_D04962FA7F3EF6A1) / 10000;
      _id_0C0AB0189903C9D4 = scripts\engine\math::lerp(_id_9676775270CEF770._id_0C0AB0189903C9D4, _id_758A502ACDAE3FFB._id_0C0AB0189903C9D4, progress);
      radius = scripts\engine\math::lerp(_id_9676775270CEF770.radius, _id_758A502ACDAE3FFB.radius, progress);
      _func_2EB76CBE682595C3(vectorlerp(_id_9676775270CEF770.origin, _id_758A502ACDAE3FFB.origin, progress), radius + 2000, radius + 5000, 0, 4000, _id_0C0AB0189903C9D4 / 2, _id_0C0AB0189903C9D4, 0.35, 1.0);
      wait 1;
    }

    _func_2EB76CBE682595C3(_id_758A502ACDAE3FFB.origin, _id_758A502ACDAE3FFB.radius + 2000, _id_758A502ACDAE3FFB.radius + 5000, 0, 4000, _id_758A502ACDAE3FFB._id_0C0AB0189903C9D4 / 2, _id_758A502ACDAE3FFB._id_0C0AB0189903C9D4, 0.35, 1.0);
    _id_9676775270CEF770 = _id_758A502ACDAE3FFB;
  }
}

_id_0A3920E4DDD93CF3() {
  struct = spawnStruct();
  struct.origin = scripts\engine\utility::drop_to_ground(_id_2695A20D4011076D::getsafecircleorigin());
  struct.radius = _id_2695A20D4011076D::getsafecircleradius();
  _id_600D2706A3F4287F = level.br_level.br_circleclosetimes.size - level.br_circle.circleindex - 1;

  switch (_id_600D2706A3F4287F) {
    case 0:
      struct._id_0C0AB0189903C9D4 = 300;
      break;
    case 1:
      struct._id_0C0AB0189903C9D4 = 200;
      break;
    case 2:
      struct._id_0C0AB0189903C9D4 = 100;
      break;
    case 3:
      struct._id_0C0AB0189903C9D4 = 50;
      break;
    default:
      struct._id_0C0AB0189903C9D4 = 0;
      break;
  }

  return struct;
}