/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_multi_circle.gsc
****************************************************/

init() {
  if(getdvarint("scr_br_multi_circle", 0) == 0) {
    return;
  }
  logstring("br_multi_circle::init");

  if(getdvarint("dvar_5BD161F5B9367829", 0) != 0)
    _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");

  game["dialog"]["circle_split"] = "gmst_wzan_crsp";
  game["dialog"]["circle_merge"] = "gmst_wzan_crmr";
  game["dialog"]["circle_victory"] = "gmst_wzan_crsv";
  _id_CCACFDCC7AA6B6D7();
  _id_21FFE8D91278BBAA();

  if(getdvarint("dvar_F4A50B0871EFA9E9", 1) != 0)
    _id_2695A20D4011076D::_id_ECA79FA0F341EE08(12, undefined, undefined, undefined, ::_id_CEE78F828E373996);

  level._id_80C1E8E18146024F = ::_id_FEA1E6F98AFB74F4;
}

_id_CCACFDCC7AA6B6D7() {
  level.br_circle._id_BF394857229861A5 = ::_id_01B21DE2360BEAFF;
  level._id_2DF69B8E552238B6 = 1;
  level._id_B31733F431ED12E0 = spawnStruct();
  level._id_B31733F431ED12E0._id_209967C144016964 = getdvarint("scr_br_multi_circle_count", 1);
  level._id_B31733F431ED12E0._id_8A10C39962F6D9FD = getdvarint("dvar_C87134A23557BE72", 1);
  level._id_B31733F431ED12E0._id_C22567ED8CFE3761 = getdvarint("dvar_638DA851601CA79A", 1);
  level._id_B31733F431ED12E0._id_DFC65F80AF9670DE = getdvarfloat("dvar_8E7EF4C30D5B5A55", 0.0);
  level._id_B31733F431ED12E0._id_117E933D19F2C221 = getdvarint("dvar_4E2F0D19A2F755EE", 1);
  level._id_B31733F431ED12E0._id_7CEE15A31694177C = getdvarint("dvar_DC93C4D0BFB9CF05", 1);
  level._id_B31733F431ED12E0._id_28DA030377A08F4A = getdvarint("dvar_8382DAE948FA600F", 1);
  level._id_B31733F431ED12E0._id_BC58018F3E4A64CC = getdvarfloat("dvar_09E74A59C2151D0A", 0.5);
  level._id_B31733F431ED12E0._id_2E5BB265E73E668A = getdvarfloat("dvar_E87E2D1053DAE898", 0.5);
  level._id_B31733F431ED12E0._id_9539818567FB5EC4 = getdvarfloat("dvar_904276AD1475566A", 1.0);
  level._id_B31733F431ED12E0._id_46E6E2FAF04B1DD8 = getdvarfloat("dvar_389468EE25FF1DD2", 2.0);
  level._id_B31733F431ED12E0._id_4FB3372DF7D3FCB0 = getdvarfloat("dvar_05D8995F6D065BC6", 0.5);
  level._id_B31733F431ED12E0._id_F3EA1A173901B831 = getdvarint("dvar_744515D8C05E3243", 1);
  level._id_B31733F431ED12E0._id_C73CD3AC9DDE962F = getdvarint("dvar_C8F6FBC981B7F489", 0);
  level._id_B31733F431ED12E0.configs = [];
}

_id_21FFE8D91278BBAA() {
  if(getdvarint("dvar_56BF37E58750811D", 0)) {
    return;
  }
  logstring("br_multi_circle::initMultiCircleConfigData");
  _id_0592732704EEC44A = getDvar("scr_br_multi_circle_config_list", "iw9_multicircleconfig_list");
  _id_F6684AC355C9345D = getscriptbundle("multicircleconfiglist:" + _id_0592732704EEC44A);

  if(isDefined(_id_F6684AC355C9345D)) {
    foreach(_id_F90358454413407F in _id_F6684AC355C9345D._id_0204BC53A09C2FAC) {
      _id_F5B9225AA3D3BC58 = "multicircleconfig:" + _id_F90358454413407F.config;
      config = getscriptbundle(_id_F5B9225AA3D3BC58);

      if(isDefined(config))
        _id_D0FDD965ED982F8F(config);
    }
  }

  _id_862A4B386242E67B();
  _id_F92DA29572A7DC78();
}

_id_F92DA29572A7DC78() {
  if(!istrue(level._id_2DF69B8E552238B6)) {
    return;
  }
  config = _id_3AE1773696AB9337();
  _id_8FF39B7A49D2BD92(config);
}

_id_D0FDD965ED982F8F(_id_A5218803B3C3BE55) {
  _id_CF3800024083ABBE = undefined;

  if(isDefined(_id_A5218803B3C3BE55._id_7C6A99996A5E4A78) && _id_A5218803B3C3BE55._id_7C6A99996A5E4A78.size > 0) {
    _id_CF3800024083ABBE = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A5218803B3C3BE55._id_7C6A99996A5E4A78.size; _id_AC0E594AC96AA3A8++)
      _id_CF3800024083ABBE[_id_CF3800024083ABBE.size] = _id_A5218803B3C3BE55._id_7C6A99996A5E4A78[_id_AC0E594AC96AA3A8].radius;
  }

  _id_48380029FBB1007A = spawnStruct();
  _id_48380029FBB1007A.name = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_F5B9225AA3D3BC58, "");
  _id_48380029FBB1007A.weight = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55.weight, 0.0);
  _id_48380029FBB1007A._id_209967C144016964 = _id_A5218803B3C3BE55._id_209967C144016964;
  _id_48380029FBB1007A._id_8A10C39962F6D9FD = _id_A5218803B3C3BE55._id_8A10C39962F6D9FD;
  _id_48380029FBB1007A._id_C22567ED8CFE3761 = _id_A5218803B3C3BE55._id_C22567ED8CFE3761;
  _id_48380029FBB1007A._id_117E933D19F2C221 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_117E933D19F2C221, 0);
  _id_48380029FBB1007A._id_7CEE15A31694177C = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_7CEE15A31694177C, 0);
  _id_48380029FBB1007A._id_28DA030377A08F4A = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_28DA030377A08F4A, 0);
  _id_48380029FBB1007A._id_BC58018F3E4A64CC = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_0D49D3B793F0995E, 0.0);
  _id_48380029FBB1007A._id_2E5BB265E73E668A = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_80380656E112CB14, 0.0);
  _id_48380029FBB1007A._id_672D4686B7455EB8 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_9B248840395C2A72, 0.0);
  _id_48380029FBB1007A._id_F4B1F848582FBE3E = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_13AB99B2A8CF8EB0, 0.0);
  _id_48380029FBB1007A._id_9539818567FB5EC4 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_9539818567FB5EC4, 0.0);
  _id_48380029FBB1007A._id_46E6E2FAF04B1DD8 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_46E6E2FAF04B1DD8, 0.0);
  _id_48380029FBB1007A._id_4FB3372DF7D3FCB0 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_4FB3372DF7D3FCB0, 0.0);
  _id_48380029FBB1007A._id_CF3800024083ABBE = _id_CF3800024083ABBE;
  _id_48380029FBB1007A._id_B4DEBDC14C4F2A53 = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_B4DEBDC14C4F2A53, 0);
  _id_48380029FBB1007A._id_FC8ABDEEAC961E8C = scripts\engine\utility::_id_53C4C53197386572(_id_A5218803B3C3BE55._id_FC8ABDEEAC961E8C, 0.0);
  level._id_B31733F431ED12E0.configs[_id_48380029FBB1007A.name] = _id_48380029FBB1007A;
}

_id_862A4B386242E67B() {
  foreach(config in level._id_B31733F431ED12E0.configs) {
    _id_DE20025C62A6EBB9 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_11299B6AAC0CC23E", config.name, "_first_circle"), -2.0);

    if(_id_DE20025C62A6EBB9 > -2.0) {
      _id_DE20025C62A6EBB9 = clamp(_id_DE20025C62A6EBB9, -1.0, 1.0);
      config._id_FC8ABDEEAC961E8C = _id_DE20025C62A6EBB9;
    }
  }

  _id_161626A430526F7D = getDvar("dvar_A963ED27EC05A745", "");

  if(_id_161626A430526F7D != "" && isDefined(level._id_B31733F431ED12E0.configs[_id_161626A430526F7D])) {
    level._id_B31733F431ED12E0._id_161626A430526F7D = _id_161626A430526F7D;
    return;
  }

  _id_A0634E394FA7AE94 = [];

  foreach(config in level._id_B31733F431ED12E0.configs) {
    _id_F8AE147109A2C415 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_11299B6AAC0CC23E", config.name, "_weight"), -1.0);

    if(_id_F8AE147109A2C415 >= 0.0)
      config.weight = _id_F8AE147109A2C415;

    if(config.weight <= 0.0) {
      continue;
    }
    _id_A0634E394FA7AE94[config.name] = config;
  }

  level._id_B31733F431ED12E0.configs = _id_A0634E394FA7AE94;
}

_id_3AE1773696AB9337() {
  if(isDefined(level._id_B31733F431ED12E0._id_161626A430526F7D))
    return level._id_B31733F431ED12E0.configs[level._id_B31733F431ED12E0._id_161626A430526F7D];

  _id_C35D9F1ADC6B131F = 0.0;

  foreach(config in level._id_B31733F431ED12E0.configs)
  _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + config.weight;

  _id_F3FD55934AF8F5D1 = randomfloat(_id_C35D9F1ADC6B131F);
  _id_6C7BAF3A3EB2576D = 0.0;

  foreach(config in level._id_B31733F431ED12E0.configs) {
    _id_6C7BAF3A3EB2576D = _id_6C7BAF3A3EB2576D + config.weight;

    if(_id_F3FD55934AF8F5D1 <= _id_6C7BAF3A3EB2576D)
      return config;
  }

  return undefined;
}

_id_8FF39B7A49D2BD92(config) {
  if(!isDefined(config)) {
    return;
  }
  level._id_B31733F431ED12E0.config = config;
  level._id_B31733F431ED12E0._id_209967C144016964 = config._id_209967C144016964;
  level._id_B31733F431ED12E0._id_8A10C39962F6D9FD = config._id_8A10C39962F6D9FD;
  level._id_B31733F431ED12E0._id_C22567ED8CFE3761 = config._id_C22567ED8CFE3761;
  level._id_B31733F431ED12E0._id_117E933D19F2C221 = config._id_117E933D19F2C221;
  level._id_B31733F431ED12E0._id_7CEE15A31694177C = config._id_7CEE15A31694177C;
  level._id_B31733F431ED12E0._id_28DA030377A08F4A = config._id_28DA030377A08F4A;
  level._id_B31733F431ED12E0._id_BC58018F3E4A64CC = config._id_BC58018F3E4A64CC;
  level._id_B31733F431ED12E0._id_2E5BB265E73E668A = config._id_2E5BB265E73E668A;
  level._id_B31733F431ED12E0._id_672D4686B7455EB8 = config._id_672D4686B7455EB8;
  level._id_B31733F431ED12E0._id_F4B1F848582FBE3E = config._id_F4B1F848582FBE3E;
  level._id_B31733F431ED12E0._id_9539818567FB5EC4 = config._id_9539818567FB5EC4;
  level._id_B31733F431ED12E0._id_46E6E2FAF04B1DD8 = config._id_46E6E2FAF04B1DD8;
  level._id_B31733F431ED12E0._id_4FB3372DF7D3FCB0 = config._id_4FB3372DF7D3FCB0;
  level._id_B31733F431ED12E0._id_E60BFC21D3DCED49 = undefined;
  logstring("br_multi_circle::applyMultiCircleConfig -> name=" + config.name + " count=" + config._id_209967C144016964 + " split=" + config._id_8A10C39962F6D9FD + " merge=" + config._id_C22567ED8CFE3761);

  if(!isDefined(config._id_68E354FCEB08D97B)) {
    if(getdvarint("dvar_DD0BAB5C26CB2240", 1) == 1)
      setDvar("scr_br_circle_first_placement_scale", config._id_FC8ABDEEAC961E8C);

    level._id_B31733F431ED12E0._id_E60BFC21D3DCED49 = config._id_B4DEBDC14C4F2A53;

    if(isDefined(config._id_8A10C39962F6D9FD) && isDefined(config._id_CF3800024083ABBE)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < config._id_CF3800024083ABBE.size; _id_AC0E594AC96AA3A8++)
        level.br_level.br_circleradii[config._id_8A10C39962F6D9FD + _id_AC0E594AC96AA3A8] = config._id_CF3800024083ABBE[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_598312EB02C8EB61() {
  if(!istrue(level._id_2DF69B8E552238B6)) {
    return;
  }
  _id_B0F5EE01693AB2FD();
  _id_58F20490049AF6AC::_id_D12A7C7251710CBF();
  config = level._id_B31733F431ED12E0.config;

  if(isDefined(config) && isDefined(config._id_68E354FCEB08D97B)) {
    _id_99B71C1BA0ED78B5();
    [[config._id_68E354FCEB08D97B]]();
    level notify("calc_circle_centers");
  } else
    _id_E71987651701448A();
}

_id_01B21DE2360BEAFF(circleindex) {
  _id_9BEDD0ECB39838D6 = 0.0;
  _id_D6BAC3BF0F64D280 = 1.0;

  if(!_id_58F20490049AF6AC::_id_49411683F5A51DAA(circleindex)) {
    if(isDefined(level._id_B31733F431ED12E0._id_672D4686B7455EB8))
      _id_9BEDD0ECB39838D6 = level._id_B31733F431ED12E0._id_672D4686B7455EB8;

    if(isDefined(level._id_B31733F431ED12E0._id_F4B1F848582FBE3E))
      _id_D6BAC3BF0F64D280 = level._id_B31733F431ED12E0._id_F4B1F848582FBE3E;
  }

  return [_id_9BEDD0ECB39838D6, _id_D6BAC3BF0F64D280];
}

_id_FEA1E6F98AFB74F4(_id_7B6D5DB8CB3C5782) {
  if(!istrue(level._id_2DF69B8E552238B6)) {
    return;
  }
  _id_0EBFD46AA8754608();
  _id_74C4ED830065B00C();
  level thread _id_0C6CA870B4CDFF7D();

  if(istrue(_id_7B6D5DB8CB3C5782) && !_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    level waittill("infils_ready");

  if(istrue(level.usegulag))
    _id_67708F418B1FAC79::setupgulagtimer();

  level thread _id_4C7E6F6847607C99();
  level thread _id_5D02313C7D7C9D62();
  level thread _id_D00DEE714982522B();
  level thread _id_70DAB1712E13880C();
  level thread _id_2695A20D4011076D::stopcirclesatgameend();
  level.br_circle._id_5B8569581E64D55A = gettime();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++)
      _id_2D74067ACCCAF1A4(_id_AC0E594AC96AA3A8);
  }

  if(isDefined(level._id_20F62868A14AB570)) {
    foreach(callback in level._id_20F62868A14AB570)[[callback]]();
  }
}

_id_2D74067ACCCAF1A4(circleindex) {
  level endon("game_ended");
  level endon("br_ending_start");

  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("circleTimer", circleindex))) {
    return;
  }
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = circleindex;
  _id_F007CE073DC3C519 = circleindex == 0;
  _id_6B890E6BE7982EFB = circleindex == level.br_level.br_circleclosetimes.size - 1;
  _id_F2E5F195D91A8B4F = circleindex + 1 == level._id_B31733F431ED12E0._id_8A10C39962F6D9FD;
  _id_96CA8E35A7B219E3 = circleindex + 1 == level._id_B31733F431ED12E0._id_C22567ED8CFE3761;
  _id_C3D4CAA5CB4132E6 = level.br_level.br_circledelaytimes[circleindex];
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
  _id_154EF61B7A7F747A = level.br_level.br_circleradii[circleindex + 1];

  if(!isDefined(level._id_E486ACB8F70C45A2)) {
    if(_id_2695A20D4011076D::_id_FC0F865DDCF551AD())
      setomnvar("ui_br_circle_num", circleindex);
    else
      setomnvar("ui_br_circle_num", circleindex + 1);
  }

  thread _id_67708F418B1FAC79::circletimer(circleindex);
  _id_362C58E8BB39BCDA::runbrgametypefunc("circleTimerNext", circleindex);
  level thread _id_2695A20D4011076D::br_lerp_minimap_zoom(circleindex);
  _id_5A6E343A8574AF81 = level.br_level.br_circlecenters[circleindex + 1];
  level.br_circle.centertarget = _id_5A6E343A8574AF81;
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  if(_id_2695A20D4011076D::_id_E32A50F37301A6AB())
    _id_F9B131D3D6EAE27D(_id_C669C821EE772A3D, _id_6B890E6BE7982EFB);

  _id_2695A20D4011076D::_id_2F4FB0777EBB4CC0();
  _id_2695A20D4011076D::cleanupoutercrates();
  _id_878EAEED15433716();
  _id_AC6A89D630FA8DEE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    centertarget = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[circleindex + 1];
    _id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8] = centertarget;
    _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
    _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9.origin = (centertarget[0], centertarget[1], _id_154EF61B7A7F747A);
  }

  if(getdvarint("scr_br_multi_circle_hide_with_delay", 0))
    _id_58F20490049AF6AC::_id_57F3FD16B628C829(circleindex);

  _id_DC59F76C34681EDE = (_id_F2E5F195D91A8B4F || _id_96CA8E35A7B219E3) && _id_C669C821EE772A3D != 1;
  level thread _id_2695A20D4011076D::startuiclosetimer(_id_C3D4CAA5CB4132E6, _id_F007CE073DC3C519, _id_6B890E6BE7982EFB, circleindex, _id_DC59F76C34681EDE);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
    _id_2DCF644323BDFEDB._id_58308F5095B6080E.origin = _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9.origin;
    _id_2DCF644323BDFEDB._id_DDEEC615921CC88C.origin = _id_2DCF644323BDFEDB._id_46870B6FA8AD4427.origin;
  }

  waitframe();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
    _id_1139F778F794FF98(_id_2DCF644323BDFEDB._id_46870B6FA8AD4427, _id_2DCF644323BDFEDB._id_58308F5095B6080E, _id_2DCF644323BDFEDB._id_DDEEC615921CC88C, _id_C3D4CAA5CB4132E6, _id_6B890E6BE7982EFB);
  }

  _id_58F20490049AF6AC::_id_47759B7ED0818A3F(circleindex, _id_F007CE073DC3C519);

  if(_id_C669C821EE772A3D != 1 && !_id_F007CE073DC3C519)
    level thread _id_9BB9ABF5FD67056A(circleindex + 1, 1);

  if(istrue(level.usegulag))
    level thread _id_67708F418B1FAC79::transitioncircle(_id_154EF61B7A7F747A, _id_C3D4CAA5CB4132E6);

  level notify("br_circle_set");

  if(_id_F2E5F195D91A8B4F)
    level notify("multi_circle_show_split");
  else if(_id_96CA8E35A7B219E3)
    level notify("multi_circle_show_merge");

  wait(_id_C3D4CAA5CB4132E6);

  if(_id_C669C821EE772A3D > 1) {
    if(circleindex + 1 == level._id_B31733F431ED12E0._id_8A10C39962F6D9FD) {
      level notify("multi_circle_split");
      _id_715028F54BAD19A1::_id_14099F0F07C09E69(gettime());
    } else if(circleindex + 1 == level._id_B31733F431ED12E0._id_C22567ED8CFE3761) {
      [_id_3511C7EE351E5C90, _id_4B6B489DAE052A24] = _id_59D0AB7E24248AD7();
      _id_715028F54BAD19A1::_id_77C1C837C38EFA21(gettime(), _id_3511C7EE351E5C90, _id_4B6B489DAE052A24);
    }
  }

  level notify("br_circle_started");
  level.circleclosing = 1;

  if(!isDefined(level._id_E486ACB8F70C45A2))
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_C2D7D58BFAD1B1EE * 1000));

  _id_58F20490049AF6AC::_id_8D09229C08ABD549(circleindex, _id_6B890E6BE7982EFB);

  if(_id_C669C821EE772A3D != 1)
    level thread _id_9BB9ABF5FD67056A(circleindex + 1, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
    _id_2DCF644323BDFEDB._id_58308F5095B6080E.origin = _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9.origin;
    _id_2DCF644323BDFEDB._id_DDEEC615921CC88C.origin = _id_2DCF644323BDFEDB._id_46870B6FA8AD4427.origin;
    _id_898CA8FCDF7D6479(_id_2DCF644323BDFEDB._id_46870B6FA8AD4427, _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9, _id_2DCF644323BDFEDB._id_DDEEC615921CC88C, int(_id_C2D7D58BFAD1B1EE), _id_6B890E6BE7982EFB);
    _id_2DCF644323BDFEDB._id_46870B6FA8AD4427 brcirclemoveTo(_id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8][0], _id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8][1], _id_154EF61B7A7F747A, _id_C2D7D58BFAD1B1EE);
  }

  _id_E499790B0786EB88 = !istrue(level.br_circle._id_0A0D948A339EEE04) && !(isDefined(level.isstandardsandbox) && !level.isstandardsandbox);

  if(_id_E499790B0786EB88)
    level thread scripts\mp\music_and_dialog::_id_A486DF26072A530A(level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, 0.4);

  wait(_id_C2D7D58BFAD1B1EE);

  if(_id_C669C821EE772A3D > 1) {
    if(_id_F2E5F195D91A8B4F) {
      level._id_B31733F431ED12E0._id_CE4D234D77082447 = 1;
      [_id_3511C7EE351E5C90, _id_4B6B489DAE052A24] = _id_59D0AB7E24248AD7();
      _id_715028F54BAD19A1::_id_C3CA7338446F4FCE(gettime(), _id_3511C7EE351E5C90, _id_4B6B489DAE052A24);
    } else if(_id_96CA8E35A7B219E3) {
      level._id_B31733F431ED12E0._id_CE4D234D77082447 = 0;
      level notify("multi_circle_merge");
      _id_715028F54BAD19A1::_id_4EB4428FE15D7276(gettime());
    }
  }

  if(_id_2695A20D4011076D::resetdangercircleorigin(circleindex)) {
    if(getdvarint("dvar_E0A1364A76DD764E", 1)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
        _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
        _id_2DCF644323BDFEDB._id_46870B6FA8AD4427.origin = (_id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8][0], _id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8][1], _id_154EF61B7A7F747A);
      }
    }
  }

  level.circleclosing = 0;
  _id_F2DA81FB842E7A5E = 5;

  if(_id_F2DA81FB842E7A5E > 0 && circleindex < _id_F2DA81FB842E7A5E) {
    scripts\mp\rank::addglobalrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(circleindex));
    scripts\mp\weaponrank::addweaponrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(circleindex));
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++)
    _id_2695A20D4011076D::cleanupouterspawnclosets(_id_AC6A89D630FA8DEE[_id_AC0E594AC96AA3A8], _id_154EF61B7A7F747A);
}

_id_F9B131D3D6EAE27D(_id_C669C821EE772A3D, _id_6B890E6BE7982EFB) {
  level endon("game_ended");
  level.br_circle endon("circle_unpaused");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;
      _id_2DCF644323BDFEDB._id_58308F5095B6080E.origin = _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9.origin;
      _id_2DCF644323BDFEDB._id_DDEEC615921CC88C.origin = _id_2DCF644323BDFEDB._id_46870B6FA8AD4427.origin;
      _id_898CA8FCDF7D6479(_id_2DCF644323BDFEDB._id_46870B6FA8AD4427, _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9, _id_2DCF644323BDFEDB._id_DDEEC615921CC88C, int(16777), _id_6B890E6BE7982EFB);
    }

    wait 1;
  }
}

_id_4C7E6F6847607C99() {
  level endon("game_ended");
  level endon("br_ending_start");

  while(level.br_circle.circleindex < 0)
    waitframe();

  if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    level waittill("infils_ready");

  level notify("update_circle_hide");
}

_id_1139F778F794FF98(circleent, _id_933B2A39EBFD2AD9, _id_46870B6FA8AD4427, duration, _id_6B890E6BE7982EFB) {
  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(!isbot(_id_AC0E424AC96A7113)) {
      _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_safecircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);

      if(istrue(_id_6B890E6BE7982EFB))
        _id_AC0E424AC96A7113 _id_2695A20D4011076D::_hidesafecircleui();

      _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_dangercircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
    }
  }

  circleent _meth_F566102230D6730D(_id_933B2A39EBFD2AD9, _id_46870B6FA8AD4427, _id_46870B6FA8AD4427);
  thread _id_2695A20D4011076D::updatecirclehide(duration);
}

_id_898CA8FCDF7D6479(circleent, _id_933B2A39EBFD2AD9, _id_46870B6FA8AD4427, duration, _id_6B890E6BE7982EFB) {
  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(!isbot(_id_AC0E424AC96A7113)) {
      _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_safecircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);

      if(istrue(_id_6B890E6BE7982EFB))
        _id_AC0E424AC96A7113 _id_2695A20D4011076D::_hidesafecircleui();

      _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_dangercircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
    }
  }

  circleent _meth_F566102230D6730D(_id_933B2A39EBFD2AD9, _id_46870B6FA8AD4427, _id_933B2A39EBFD2AD9);
  thread _id_2695A20D4011076D::updatecirclehide(duration);
}

_id_9BB9ABF5FD67056A(circleindex, _id_C286002D25BC3F59) {
  level endon("game_ended");
  level endon("br_ending_start");
  _id_AB0F126B12B30E01 = undefined;
  _id_25A76641870DD568 = undefined;

  if(circleindex == level._id_B31733F431ED12E0._id_8A10C39962F6D9FD) {
    _id_AB0F126B12B30E01 = "br_multi_circle_split";
    _id_25A76641870DD568 = 10;
    _id_2CEDCC356F1B9FC8::brleaderdialog("circle_split");
  } else if(circleindex == level._id_B31733F431ED12E0._id_C22567ED8CFE3761) {
    _id_AB0F126B12B30E01 = "br_multi_circle_merge";
    _id_25A76641870DD568 = 11;
    _id_2CEDCC356F1B9FC8::brleaderdialog("circle_merge");
  }

  if(!isDefined(_id_AB0F126B12B30E01)) {
    return;
  }
  if(_id_C286002D25BC3F59)
    _id_AB0F126B12B30E01 = _id_AB0F126B12B30E01 + "_open";
  else
    _id_AB0F126B12B30E01 = _id_AB0F126B12B30E01 + "_close";

  foreach(player in level.players) {
    if(!isbot(player)) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
        player thread scripts\mp\hud_message::showsplash(_id_AB0F126B12B30E01);

      player setclientomnvar("ui_br_circle_state", _id_25A76641870DD568);
    }
  }

  if(level._id_B31733F431ED12E0._id_C73CD3AC9DDE962F) {
    wait 2;
    setomnvar("ui_publicevent_minimap_pulse", 1);
    wait 2;
    setomnvar("ui_publicevent_minimap_pulse", 0);
  }
}

_id_CEE78F828E373996() {
  level.br_circle.dangercircleui.origin = _id_2695A20D4011076D::getdangercircleorigin();
  level.br_circle.dangercircleent.origin = _id_2695A20D4011076D::getdangercircleorigin();
  duration = getdvarint("dvar_D8DB46472F1970A3", 300);

  foreach(player in level.players) {
    if(!isbot(player)) {
      player setclientomnvar("ui_br_circle0_start_time", 0);
      player setclientomnvar("ui_br_circle1_start_time", gettime());
      player setclientomnvar("ui_br_circle1_duration", int(duration * 1000));
      player setclientomnvar("ui_br_infil_started", 0);
    }
  }
}

_id_5D02313C7D7C9D62() {
  level endon("game_ended");
  level endon("br_ending_start");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0)
    waitframe();

  if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    level waittill("infils_ready");

  level childthread _id_D835881B2D4842D3();

  if(level._id_B31733F431ED12E0._id_F3EA1A173901B831) {
    level childthread _id_47D1A34BDE08097D();

    if(istrue(getdvarint("dvar_072AE262A8559256", 0)))
      level childthread _id_EB2F52408AC501AC();
  }
}

_id_D835881B2D4842D3() {
  _id_A058DC250ACE641D = _id_2695A20D4011076D::_id_CE6456364079CCE7();

  for(;;) {
    if(isDefined(level.br_circle.dangercircleent)) {
      index = level.br_circle.circleindex;

      if(index > level.br_circle.damagetick.size - 1)
        index = level.br_circle.damagetick.size - 1;

      damagetick = level.br_circle.damagetick[index];

      if(isDefined(level.circledamagemultiplier))
        damagetick = damagetick * level.circledamagemultiplier;

      if(damagetick > 0) {
        foreach(player in level.players) {
          if(!isDefined(player) || !isDefined(player.origin)) {
            continue;
          }
          if(isDefined(player) && istrue(player._id_A6637F42471575BC)) {
            continue;
          }
          if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart") && istrue(player.plotarmor)) {
            player _id_2695A20D4011076D::_id_6FCDEA7A7060CE40();
            continue;
          }

          _id_ACFA1A113BA7D7C7 = 0;

          if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(player.origin)) {
            if(player _id_2695A20D4011076D::cancircledamageplayer(player)) {
              _id_ACFA1A113BA7D7C7 = 1;
              player _id_2695A20D4011076D::_id_F8D9C5F59FC6C187();

              if(getdvarint("scr_time_in_gas_damage_modifier_enabled", 0) == 1)
                _id_36E462D047634362 = player _id_2695A20D4011076D::_id_1E0F84E555B3DE7D(_id_A058DC250ACE641D, damagetick);
              else
                _id_36E462D047634362 = damagetick;

              _id_973F8E42FB3C591B = _id_36E462D047634362;

              if(isDefined(level._id_AA1AAED4A9B80D4B) && isDefined(level._id_152D5A9C5AC5CDAD) && level.br_circle.circleindex <= level._id_AA1AAED4A9B80D4B)
                _id_973F8E42FB3C591B = _id_973F8E42FB3C591B * level._id_152D5A9C5AC5CDAD;

              if(scripts\cp_mp\gasmask::hasgasmask(player)) {
                if(_id_7E52B56769FA7774::_id_F213F06EBA604BBD(player)) {
                  if(istrue(player._id_A18181D8BDAA0DAB))
                    player notify("gasmask_buffer_reset");
                  else if(level._id_5312BC14BD5DB377 > 0) {
                    player._id_A18181D8BDAA0DAB = 1;
                    player thread _id_7E52B56769FA7774::_id_A1D897962A19D27E();
                  }
                }

                if(istrue(player._id_A18181D8BDAA0DAB)) {
                  if(!istrue(player.gasmaskequipped))
                    player _id_2695A20D4011076D::_id_81652BAD17CD28BD(_id_36E462D047634362);

                  player scripts\cp_mp\gasmask::processdamage(_id_973F8E42FB3C591B);
                } else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                  player playsoundtoplayer("br_gas_mask_break_plr", player);
                  player _id_7E52B56769FA7774::_id_04D16B9C52EFA3B8();
                  player _id_7E52B56769FA7774::_id_8E9B00A1D2B23D72();
                } else {
                  player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("br_multi_circle");
                  player scripts\cp_mp\gasmask::processdamage(_id_973F8E42FB3C591B);
                }
              } else
                player _id_2695A20D4011076D::_id_81652BAD17CD28BD(_id_36E462D047634362);

              if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
                player _id_2D9D24F7C63AC143::_id_5323BEF1AD6244B9(_id_973F8E42FB3C591B);
            } else
              player _id_2695A20D4011076D::_id_6FCDEA7A7060CE40();
          } else {
            player _id_2695A20D4011076D::_id_6FCDEA7A7060CE40();

            if(scripts\cp_mp\gasmask::hasgasmask(player)) {
              if(_id_7E52B56769FA7774::_id_F213F06EBA604BBD(player)) {
                if(istrue(player._id_A18181D8BDAA0DAB))
                  player notify("gasmask_buffer_reset");
                else if(level._id_5312BC14BD5DB377 > 0) {
                  player._id_A18181D8BDAA0DAB = 1;
                  player thread _id_7E52B56769FA7774::_id_A1D897962A19D27E();
                }
              }

              if(istrue(player._id_A18181D8BDAA0DAB))
                continue;
              else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                player playsoundtoplayer("br_gas_mask_break_plr", player);
                player _id_7E52B56769FA7774::_id_04D16B9C52EFA3B8();
              } else
                player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("br_multi_circle");
            }
          }

          if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
            player _id_2695A20D4011076D::updateindangercirclestate(_id_ACFA1A113BA7D7C7);
        }
      }
    }

    wait 1.0;
  }
}

_id_47D1A34BDE08097D() {
  wait 0.25;

  for(;;) {
    _id_58F20490049AF6AC::_id_EBDD2E77A8ADE959();
    wait 1.0;
  }
}

_id_EB2F52408AC501AC() {
  wait 0.5;

  for(;;) {
    _id_367C2E5A914658D7::_id_C4B698ED8DD5C33D();
    wait 1.0;
    _id_367C2E5A914658D7::_id_974A505E30D0049C();
    wait 1.0;
  }
}

_id_D00DEE714982522B() {
  if(_id_58F20490049AF6AC::_id_EA6CDF6492DFB4FA()) {
    return;
  }
  level endon("game_ended");
  level endon("br_ending_start");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0)
    waitframe();

  if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    level waittill("infils_ready");

  for(;;) {
    wait 1;

    if(isDefined(level._id_8A12E160A2617C92)) {
      foreach(_id_7F590F6AE7F3BC83, _id_D9DBCA8ECF0DC293 in level._id_8A12E160A2617C92) {
        _id_D9DBCA8ECF0DC293 = scripts\engine\utility::array_removeundefined(_id_D9DBCA8ECF0DC293);

        foreach(_id_85EC09C82046805A in _id_D9DBCA8ECF0DC293) {
          _id_CF876CD1A06753F5 = _id_58F20490049AF6AC::_id_F487A2A306E21BDB(_id_85EC09C82046805A.origin);

          if(_id_CF876CD1A06753F5 > 0)
            scripts\engine\utility::delaythread(_id_CF876CD1A06753F5, ::_id_E65C3EE9C7741955, _id_85EC09C82046805A, _id_7F590F6AE7F3BC83);
        }

        level._id_8A12E160A2617C92[_id_7F590F6AE7F3BC83] = [];
      }
    }
  }
}

_id_E65C3EE9C7741955(obj, _id_7F590F6AE7F3BC83) {
  if(!isDefined(obj)) {
    return;
  }
  _id_BCA649C8DD3208D8 = undefined;

  if(isDefined(level._id_725403A0618F5A10))
    _id_BCA649C8DD3208D8 = level._id_725403A0618F5A10[_id_7F590F6AE7F3BC83];

  if(isDefined(_id_BCA649C8DD3208D8))
    [[_id_BCA649C8DD3208D8]](obj);
}

_id_878EAEED15433716() {
  if(!isDefined(level.br_pickups)) {
    return;
  }
  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && !_id_58F20490049AF6AC::_id_27779E30FE4C0D62(crate.origin))
      level.br_pickups.outercrates[level.br_pickups.outercrates.size] = crate;
  }
}

_id_70DAB1712E13880C() {
  _id_A5BC99D4D649F54B();
  _id_04D4DF5D8D091815();
}

_id_A5BC99D4D649F54B() {
  if(level._id_B31733F431ED12E0._id_209967C144016964 == 1) {
    return;
  }
  if(getdvarint("dvar_3250CDAB1DFB0AC4", 1)) {
    return;
  }
  level endon("game_ended");
  level endon("br_ending_start");
  level endon("multi_circle_merge");
  level waittill("multi_circle_split");
  _id_993E5CF734FBD0FC = [];

  if(getdvarint("dvar_37133E3EE3BEAE30", 0))
    _id_993E5CF734FBD0FC = _id_B378FD0A01E94537();

  _id_881F82E9F82546E7 = getdvarint("dvar_DB6F837F9260EC08", 0);
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(;;) {
    _id_545D0B8CA332A79F = [];
    _id_13443B3CFF3E3FE4 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8] = 0;
      _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8] = [];
    }

    foreach(player in level.players) {
      if(!isDefined(player) || !isalive(player) || player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        continue;
      }
      _id_F2D6DB8B91F22768 = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
        _id_3D512B85D7776761 = 0;

        if(_id_881F82E9F82546E7)
          _id_3D512B85D7776761 = _id_58F20490049AF6AC::_id_783961B002F33360(player.origin, _id_AC0E594AC96AA3A8);
        else
          _id_3D512B85D7776761 = _id_58F20490049AF6AC::_id_D277283FB9AD5D46(player.origin, _id_AC0E594AC96AA3A8);

        if(_id_3D512B85D7776761) {
          _id_F2D6DB8B91F22768 = _id_F2D6DB8B91F22768 | 1 << _id_AC0E594AC96AA3A8;
          _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8]++;

          if(isDefined(player.team))
            _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8][player.team] = player.team;
        }
      }

      player setclientomnvar("ui_br_multi_circle_player_data", _id_F2D6DB8B91F22768);
    }

    _id_DC66D1253386E15F = 0;
    _id_5BC1A2A5F43E530B = 0;
    _id_209967C144016964 = int(min(_id_C669C821EE772A3D, 4));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_209967C144016964; _id_AC0E594AC96AA3A8++) {
      _id_DC66D1253386E15F = _id_DC66D1253386E15F | _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8] << _id_AC0E594AC96AA3A8 * 8;
      _id_5BC1A2A5F43E530B = _id_5BC1A2A5F43E530B | _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8].size << _id_AC0E594AC96AA3A8 * 8;
    }

    setomnvar("ui_br_multi_circle_player_count", _id_DC66D1253386E15F);
    setomnvar("ui_br_multi_circle_team_count", _id_5BC1A2A5F43E530B);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_209967C144016964; _id_AC0E594AC96AA3A8++) {
      if(_id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8].size == 1)
        _id_7C70020CF67057AB(_id_AC0E594AC96AA3A8, scripts\engine\utility::array_get_first_item(_id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8]));

      if(isDefined(_id_993E5CF734FBD0FC[_id_AC0E594AC96AA3A8])) {
        overlay = _id_993E5CF734FBD0FC[_id_AC0E594AC96AA3A8];
        value = _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8];

        if(getdvarint("dvar_7042BBD75F3FFC34", 1))
          value = _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8].size;

        overlay setvalue(value);
      }
    }

    wait 1;
  }
}

_id_04D4DF5D8D091815() {
  setomnvar("ui_br_multi_circle_player_count", 0);
  setomnvar("ui_br_multi_circle_team_count", 0);
}

_id_59D0AB7E24248AD7() {
  _id_545D0B8CA332A79F = [];
  _id_13443B3CFF3E3FE4 = [];
  _id_7C22BFFF29A960A3 = [];
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8] = 0;
    _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8] = [];
    _id_7C22BFFF29A960A3[_id_AC0E594AC96AA3A8] = 0;
  }

  for(_id_AC0E594AC96AA3A8 = _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8] = -1;
    _id_7C22BFFF29A960A3[_id_AC0E594AC96AA3A8] = -1;
  }

  foreach(player in level.players) {
    if(!isDefined(player) || !isalive(player) || player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      if(_id_58F20490049AF6AC::_id_D277283FB9AD5D46(player.origin, _id_AC0E594AC96AA3A8)) {
        _id_545D0B8CA332A79F[_id_AC0E594AC96AA3A8]++;

        if(isDefined(player.team))
          _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8][player.team] = player.team;
      }
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++)
    _id_7C22BFFF29A960A3[_id_AC0E594AC96AA3A8] = _id_13443B3CFF3E3FE4[_id_AC0E594AC96AA3A8].size;

  return [_id_545D0B8CA332A79F, _id_7C22BFFF29A960A3];
}

_id_7C70020CF67057AB(index, team) {
  if(!getdvarint("scr_br_multi_circle_winner", 1)) {
    return;
  }
  if(!istrue(level._id_B31733F431ED12E0._id_CE4D234D77082447)) {
    return;
  }
  circle = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[index];

  if(!isDefined(circle) || istrue(circle._id_FA9A850338119F4B)) {
    return;
  }
  circle._id_FA9A850338119F4B = 1;
  _id_398360BB754C9099(team);
  _id_23753850F8E1A765(team);
  _id_2CEDCC356F1B9FC8::brleaderdialogteam("circle_victory", team);
}

_id_398360BB754C9099(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(isalive(player) && !isbot(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
      player thread scripts\mp\hud_message::showsplash("br_multi_circle_winner");
  }
}

_id_23753850F8E1A765(team) {
  _id_501265B5FE210821 = getdvarint("dvar_28BD0ECBFE827FD1", 500);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_501265B5FE210821);
}

_id_0C6CA870B4CDFF7D() {
  if(!getdvarint("dvar_0DDF454C0808D773", 1) || level._id_B31733F431ED12E0._id_209967C144016964 == 1) {
    return;
  }
  level endon("game_ended");
  level endon("br_ending_start");
  level endon("multi_circle_show_merge");

  if(level._id_B31733F431ED12E0._id_8A10C39962F6D9FD != 1)
    level waittill("multi_circle_show_split");

  _id_560A6F9647FF9BE6();
  level thread _id_1EE81753ADBE0CCE();

  for(;;) {
    _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      objid = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8].objid;
      pos = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966._id_933B2A39EBFD2AD9.origin;
      _id_9D5EBD8DBF54C6AC = _id_2CEDCC356F1B9FC8::droptogroundmultitrace((pos[0], pos[1], 0.0));
      scripts\mp\objidpoolmanager::update_objective_position(objid, _id_9D5EBD8DBF54C6AC);
    }

    level waittill("br_circle_set");
  }
}

_id_560A6F9647FF9BE6() {
  objectiveids = [20, 21, 22, 23];
  _id_9BA3781176232EA2 = ["icon_waypoint_circle_a", "icon_waypoint_circle_b", "icon_waypoint_circle_c", "icon_waypoint_circle_d"];
  _id_8907F37A417E18C3 = [ &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_ALPHA", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_BRAVO", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_CHARLIE", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_DELTA"];
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", (0, 0, 0), _id_9BA3781176232EA2[_id_AC0E594AC96AA3A8], "icon_regular");
      scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(objid, objectiveids[_id_AC0E594AC96AA3A8]);
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      _func_A13E72E0427ECAD2(objid, _func_BF3237AB00FD71A1());
      objective_setlabel(objid, _id_8907F37A417E18C3[_id_AC0E594AC96AA3A8]);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
      objective_sethideelevation(objid, 1);
      level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8].objid = objid;
    }
  }
}

_id_1EE81753ADBE0CCE() {
  level scripts\engine\utility::waittill_any_3("game_ended", "br_ending_start", "multi_circle_show_merge");
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    objid = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8].objid;

    if(isDefined(objid)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(objid);
      level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8].objid = undefined;
    }
  }
}

_id_E71987651701448A() {
  _id_F0A1762EEB5BA01F();
  _id_3B5686B7D0848557 = getdvarint("scr_br_multi_circle_reroll", 100);

  for(_id_C4B448E975A0779B = 0; _id_C4B448E975A0779B < _id_3B5686B7D0848557 && _id_BB8DC18FDC2C007A(); _id_C4B448E975A0779B++)
    _id_F0A1762EEB5BA01F();
}

_id_B0F5EE01693AB2FD() {
  if(_id_58F20490049AF6AC::_id_D987886BB9DE9137() <= 1) {
    return;
  }
  _id_988215F0A875942A = level._id_B31733F431ED12E0._id_8A10C39962F6D9FD - 1;

  if(_id_988215F0A875942A >= 0 && _id_988215F0A875942A < level.br_level.br_circleclosetimes.size)
    level.br_level.br_circleclosetimes[_id_988215F0A875942A] = level.br_level.br_circleclosetimes[_id_988215F0A875942A] * level._id_B31733F431ED12E0._id_9539818567FB5EC4;

  _id_C048A22D8171B9F6 = level._id_B31733F431ED12E0._id_C22567ED8CFE3761 - 1;

  if(_id_C048A22D8171B9F6 >= 0 && _id_C048A22D8171B9F6 < level.br_level.br_circleclosetimes.size)
    level.br_level.br_circleclosetimes[_id_C048A22D8171B9F6] = level.br_level.br_circleclosetimes[_id_C048A22D8171B9F6] * level._id_B31733F431ED12E0._id_46E6E2FAF04B1DD8;

  for(_id_AC0E594AC96AA3A8 = _id_988215F0A875942A + 1; _id_AC0E594AC96AA3A8 < _id_C048A22D8171B9F6; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 < level.br_level.br_circleclosetimes.size)
      level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] = level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] * level._id_B31733F431ED12E0._id_4FB3372DF7D3FCB0;

    if(_id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size)
      level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8] = level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8] * level._id_B31733F431ED12E0._id_4FB3372DF7D3FCB0;
  }
}

_id_F0A1762EEB5BA01F() {
  if(!isDefined(level.br_level.br_circlecenters)) {
    return;
  }
  if(!isDefined(level._id_B31733F431ED12E0)) {
    return;
  }
  level._id_B31733F431ED12E0._id_8D99DD732455FBF2 = [];
  _id_38A4C729748AD94C = getdvarint("dvar_67A8C844BAD5A45B", 0);

  if(!_id_38A4C729748AD94C && _id_362C58E8BB39BCDA::isfeatureenabled("circleSnapToNavMesh"))
    _id_38A4C729748AD94C = 1;

  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8] = spawnStruct();
    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5 = [];
  }

  _id_8A10C39962F6D9FD = level._id_B31733F431ED12E0._id_8A10C39962F6D9FD;
  _id_C22567ED8CFE3761 = level._id_B31733F431ED12E0._id_C22567ED8CFE3761;
  _id_D6DFB1E3EE22156E = _id_C22567ED8CFE3761 - _id_8A10C39962F6D9FD;

  if(level._id_B31733F431ED12E0._id_209967C144016964 == 1)
    _id_8A10C39962F6D9FD = level.br_level.br_circlecenters.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_8A10C39962F6D9FD; _id_AC0E5C4AC96AAA41++)
      level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_AC0E5C4AC96AAA41] = level.br_level.br_circlecenters[_id_AC0E5C4AC96AAA41];
  }

  if(level._id_B31733F431ED12E0._id_209967C144016964 == 1) {
    return;
  }
  _id_DFC65F80AF9670DE = level._id_B31733F431ED12E0._id_DFC65F80AF9670DE;
  angleoffset = 360.0 / _id_C669C821EE772A3D;
  _id_C9A27C992548D1EC = getdvarfloat("dvar_7D2DAA00C9DA1E39", 0.0);

  if(getdvarint("dvar_79B501617AC641BD", 1))
    _id_C9A27C992548D1EC = _id_C9A27C992548D1EC + (randomfloat(angleoffset) - angleoffset / 2.0);

  _id_2F93004A3FB7B8F2 = undefined;
  _id_BC58018F3E4A64CC = level._id_B31733F431ED12E0._id_BC58018F3E4A64CC;
  _id_2E5BB265E73E668A = level._id_B31733F431ED12E0._id_2E5BB265E73E668A;
  _id_AC535E4A58F7BC39 = _id_8A10C39962F6D9FD;

  if(istrue(level._id_B31733F431ED12E0._id_28DA030377A08F4A))
    _id_AC535E4A58F7BC39--;

  origin = level.br_level.br_circlecenters[_id_AC535E4A58F7BC39];
  radius = level.br_level.br_circleradii[_id_AC535E4A58F7BC39];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_A08C9EF825C077E9 = origin;
    _id_F157E2C858DD6237 = _id_AC0E594AC96AA3A8 * angleoffset + _id_C9A27C992548D1EC;

    if(istrue(level._id_B31733F431ED12E0._id_7CEE15A31694177C))
      _id_A08C9EF825C077E9 = _id_2695A20D4011076D::getrandompointinboundscircle(origin, radius, _id_BC58018F3E4A64CC, _id_2E5BB265E73E668A, 1, _id_38A4C729748AD94C, 1, undefined, _id_F157E2C858DD6237, _id_F157E2C858DD6237);
    else {
      _id_A2685AC790AEF5AC = randomfloat(_id_DFC65F80AF9670DE) - _id_DFC65F80AF9670DE / 2.0;

      if(!isDefined(_id_2F93004A3FB7B8F2) || !istrue(level._id_B31733F431ED12E0._id_117E933D19F2C221))
        _id_2F93004A3FB7B8F2 = _id_BC58018F3E4A64CC + randomfloat(_id_2E5BB265E73E668A - _id_BC58018F3E4A64CC);

      _id_F157E2C858DD6237 = _id_F157E2C858DD6237 + _id_A2685AC790AEF5AC;
      _id_1E2F2224127D2990 = (radius * _id_2F93004A3FB7B8F2 * cos(_id_F157E2C858DD6237), radius * _id_2F93004A3FB7B8F2 * sin(_id_F157E2C858DD6237), 0);
      _id_A08C9EF825C077E9 = origin + _id_1E2F2224127D2990;
    }

    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_8A10C39962F6D9FD] = _id_A08C9EF825C077E9;
  }

  if(_id_D6DFB1E3EE22156E > 1) {
    _id_78F5D97243A6245F = _id_8A10C39962F6D9FD;
    _id_F46A9099528726CA = _id_8A10C39962F6D9FD + _id_D6DFB1E3EE22156E;
    _id_CF3800024083ABBE = scripts\engine\utility::array_slice(level.br_level.br_circleradii, _id_78F5D97243A6245F, _id_F46A9099528726CA);
    _id_79A6E85C95FE549B = scripts\engine\utility::array_slice(level.br_level.br_circleclosetimes, _id_78F5D97243A6245F, _id_F46A9099528726CA);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      origin = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_8A10C39962F6D9FD];
      _id_8AE269616D09DFC5 = _id_58F20490049AF6AC::_id_C7F3AE56442546D1(origin, _id_CF3800024083ABBE, _id_79A6E85C95FE549B, 1);

      if(isDefined(_id_8AE269616D09DFC5)) {
        for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < _id_8AE269616D09DFC5.size; _id_AC0E5C4AC96AAA41++) {
          _id_DC6CBFDA5CAFD043 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5.size;
          level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_DC6CBFDA5CAFD043] = _id_8AE269616D09DFC5[_id_AC0E5C4AC96AAA41];
        }
      }
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_C22567ED8CFE3761; _id_AC0E5C4AC96AAA41 < level.br_level.br_circlecenters.size; _id_AC0E5C4AC96AAA41++) {
      _id_DC6CBFDA5CAFD043 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5.size;
      level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_DC6CBFDA5CAFD043] = level.br_level.br_circlecenters[_id_AC0E5C4AC96AAA41];
    }
  }

  if(getdvarint("dvar_04B45BB60C8B9D7A", 0) > 0) {
    _id_386253FC27B67432 = level.br_level.br_movingcirclecount;
    _id_38A4C729748AD94C = getdvarint("dvar_67A8C844BAD5A45B", 0);

    if(!_id_38A4C729748AD94C && _id_362C58E8BB39BCDA::isfeatureenabled("circleSnapToNavMesh"))
      _id_38A4C729748AD94C = 1;

    _id_78F5D97243A6245F = _id_C22567ED8CFE3761;
    _id_F46A9099528726CA = _id_C22567ED8CFE3761 + _id_386253FC27B67432 + 1;
    _id_8AE269616D09DFC5 = scripts\engine\utility::array_slice(level.br_level.br_circlecenters, _id_78F5D97243A6245F, _id_F46A9099528726CA);
    _id_CF3800024083ABBE = scripts\engine\utility::array_slice(level.br_level.br_circleradii, _id_78F5D97243A6245F, _id_F46A9099528726CA);
    _id_48C37D0BEF1C3760 = _id_58F20490049AF6AC::_id_A09532919AE80718(_id_386253FC27B67432, _id_8AE269616D09DFC5, _id_CF3800024083ABBE, _id_38A4C729748AD94C);

    if(isDefined(_id_48C37D0BEF1C3760)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_48C37D0BEF1C3760.size; _id_AC0E5C4AC96AAA41++) {
          _id_DC6CBFDA5CAFD043 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5.size;
          level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[_id_DC6CBFDA5CAFD043] = _id_48C37D0BEF1C3760[_id_AC0E5C4AC96AAA41];
        }
      }
    }
  }
}

_id_BB8DC18FDC2C007A() {
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D <= 1)
    return 0;

  _id_2DEF3ADD71FF2D42 = getdvarfloat("dvar_6C976CFF653FE181", 0.5);
  _id_A9B2EBBBED787836 = getdvarfloat("dvar_2D35A2046D6899A9", 0.5);

  for(c = level._id_B31733F431ED12E0._id_8A10C39962F6D9FD; c < level._id_B31733F431ED12E0._id_C22567ED8CFE3761; c++) {
    radius = level.br_level.br_circleradii[c];

    if(radius == 0)
      return 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D - 1; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_C669C821EE772A3D; _id_AC0E5C4AC96AAA41++) {
        _id_12B347CBEAAA73C6 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[c];
        _id_12B346CBEAAA7193 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E5C4AC96AAA41]._id_8AE269616D09DFC5[c];
        dist = distance2d(_id_12B347CBEAAA73C6, _id_12B346CBEAAA7193);
        _id_B1D0BC03029F6A2C = dist / (2.0 * radius);

        if(_id_B1D0BC03029F6A2C < _id_2DEF3ADD71FF2D42)
          return 1;
      }
    }
  }

  index = level._id_B31733F431ED12E0._id_C22567ED8CFE3761 - 1;

  if(index < 1)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_12B347CBEAAA73C6 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[index];
    _id_12B346CBEAAA7193 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[index + 1];
    _id_531A5C376A1C480A = level.br_level.br_circleradii[index];
    _id_531A5B376A1C45D7 = level.br_level.br_circleradii[index + 1];

    if(_id_531A5C376A1C480A + _id_531A5B376A1C45D7 == 0)
      return 0;

    dist = distance2d(_id_12B347CBEAAA73C6, _id_12B346CBEAAA7193);
    _id_B1D0BC03029F6A2C = dist / (_id_531A5C376A1C480A + _id_531A5B376A1C45D7);

    if(_id_B1D0BC03029F6A2C < _id_A9B2EBBBED787836)
      return 1;
  }

  return 0;
}

_id_0EBFD46AA8754608() {
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_8BEBF2BFDBC76342 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[1];
    _id_FB3AA9FBA9719098 = level.br_level.br_circlecenters[0];
    safecircleent = spawn("script_model", (_id_8BEBF2BFDBC76342[0], _id_8BEBF2BFDBC76342[1], level.br_level.br_circleradii[1]));
    safecircleui = spawn("script_model", safecircleent.origin);
    dangercircleent = spawnbrcircle(_id_FB3AA9FBA9719098[0], _id_FB3AA9FBA9719098[1], level.br_level.br_circleradii[0]);
    dangercircleui = spawn("script_model", dangercircleent.origin);
    _id_2DCF644323BDFEDB = spawnStruct();
    _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9 = safecircleent;
    _id_2DCF644323BDFEDB._id_58308F5095B6080E = safecircleui;
    _id_2DCF644323BDFEDB._id_46870B6FA8AD4427 = dangercircleent;
    _id_2DCF644323BDFEDB._id_DDEEC615921CC88C = dangercircleui;
    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966 = _id_2DCF644323BDFEDB;
    dangercircleent thread _id_2695A20D4011076D::dangercircleenthidefromplayers();
    dangercircleent _meth_F566102230D6730D(safecircleent, dangercircleui, dangercircleui);
  }

  _id_2DCF644323BDFEDB = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[0]._id_3FF449A8EEC1B966;
  level.br_circle.safecircleent = _id_2DCF644323BDFEDB._id_933B2A39EBFD2AD9;
  level.br_circle.safecircleui = _id_2DCF644323BDFEDB._id_58308F5095B6080E;
  level.br_circle.dangercircleent = _id_2DCF644323BDFEDB._id_46870B6FA8AD4427;
  level.br_circle.dangercircleui = _id_2DCF644323BDFEDB._id_DDEEC615921CC88C;
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleui.hidden = 0;
}

_id_99B71C1BA0ED78B5() {
  level._id_B31733F431ED12E0._id_8D99DD732455FBF2 = [];
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8] = spawnStruct();
    level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5 = [];
  }
}

_id_74C4ED830065B00C() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleui)) {
    return;
  }
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    _id_3FF449A8EEC1B966 = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_3FF449A8EEC1B966;

    if(isDefined(_id_3FF449A8EEC1B966) && isDefined(_id_3FF449A8EEC1B966._id_46870B6FA8AD4427)) {
      _id_3FF449A8EEC1B966._id_46870B6FA8AD4427 show();
      _id_3FF449A8EEC1B966._id_46870B6FA8AD4427 hide(1);
    }
  }
}

_id_B378FD0A01E94537() {
  _id_827F335C2225D1EA = 10;
  labels = [ &"MP/BR_MULTI_CIRCLE_LABEL_A", &"MP/BR_MULTI_CIRCLE_LABEL_B", &"MP/BR_MULTI_CIRCLE_LABEL_C", &"MP/BR_MULTI_CIRCLE_LABEL_D"];
  _id_993E5CF734FBD0FC = [];
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
    overlay = _id_7196FEE664CFAE44(labels[_id_AC0E594AC96AA3A8], _id_827F335C2225D1EA * _id_AC0E594AC96AA3A8);
    overlay thread _id_B0F35A515A8EE538();
    _id_993E5CF734FBD0FC[_id_993E5CF734FBD0FC.size] = overlay;
  }

  return _id_993E5CF734FBD0FC;
}

_id_7196FEE664CFAE44(label, yoffset) {
  _id_94480E1669B7FF0D = newhudelem();
  _id_94480E1669B7FF0D.label = label;
  _id_94480E1669B7FF0D.x = 720;
  _id_94480E1669B7FF0D.y = 50 + yoffset;
  _id_94480E1669B7FF0D.alignx = "right";
  _id_94480E1669B7FF0D.aligny = "middle";
  _id_94480E1669B7FF0D.sort = 1;
  _id_94480E1669B7FF0D.foreground = 1;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.fontscale = 1;
  _id_94480E1669B7FF0D.font = "objective";
  return _id_94480E1669B7FF0D;
}

_id_B0F35A515A8EE538() {
  level endon("game_ended");
  _id_94480E1669B7FF0D = self;
  level waittill("multi_circle_merge");

  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D destroy();
}