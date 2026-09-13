/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bosses.gsc
***********************************************/

_id_1CCD859721E5EAEE() {
  if(!isDefined(level._id_6A4C9FBD7AA58544))
    level._id_6A4C9FBD7AA58544 = [];

  level._id_807BA62516150E8C = [];
  _id_CA63205FB8544163("additive", getdvarint("dvar_F0A1D4031CB20FE9", 1));
  _id_CA63205FB8544163("main", getdvarint("dvar_48D8172671E73A92", 5));
  _id_CA63205FB8544163("haunting", getdvarint("dvar_8F379698D97F1895", 5), 1);
  level._id_1E1F7470C9CC40F2 = getdvarint("dvar_5838A46670C2521F", 4000);
  level._id_B1149892B2595056 = getdvarint("dvar_1F7FC5197974A94F", 2000);
  level._id_7B10B08DDB3F610F = getdvarint("dvar_EAD6FBE92BC47426", 6000);
  level._id_22405C0E11052FFF = getdvarint("dvar_31F0A801B6BC5215", 1) == 1;
  level._id_E8E2A2FC82E5F664 = getdvarint("dvar_F03824C32A6E9662", 12000);

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    _id_20FC47823E95E4AF::_id_C96F19C0BEBDC014();
  else {
    _id_72DC6C18408CECCC::_id_4FF27C88E74047B5();
    _id_020D5705546AF47B::_id_FBFF191ACE79186C();
    _id_2AC1B431C0F54D19::_id_4C60C607A6E7B9AE();
    _id_20FC47823E95E4AF::_id_C96F19C0BEBDC014();
    _id_7B6E624E36C4B29B::_id_021DBD0C4441BF5C();
    _id_7466563C270FA1D2::_id_4A755326CD53D3B3();
    _id_234914E9B5F97C29::_id_C247624CDECDD6EE();
    _id_0660791DE0BEF12F::_id_42B7D23D72665D9C();
  }

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    _id_D4B9E030F49735D5 = 0;
    _id_69C38213C88354EE = undefined;

    foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
      if(isDefined(_id_E2958F412A7425C0._id_649245B52DBF88A9)) {
        _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + _id_E2958F412A7425C0._id_649245B52DBF88A9;

        if(!isDefined(_id_69C38213C88354EE))
          _id_69C38213C88354EE = _id_E2958F412A7425C0.name;
      }
    }

    _id_162B86F62CD92B56 = randomint(_id_D4B9E030F49735D5 + 1);

    foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
      if(isDefined(_id_E2958F412A7425C0._id_649245B52DBF88A9)) {
        _id_162B86F62CD92B56 = _id_162B86F62CD92B56 - _id_E2958F412A7425C0._id_649245B52DBF88A9;

        if(_id_162B86F62CD92B56 < 0)
          _id_69C38213C88354EE = _id_E2958F412A7425C0.name;
      }
    }

    level._id_7F7B9B8BB18CC33C = _id_69C38213C88354EE;
  } else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    level._id_7F7B9B8BB18CC33C = "getaway";

  if(level.mapname == "mp_sealion" || getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    _id_63B3F723EC33DB92::_id_D634CFB1BF1B4867();

  level notify("register_dmz_bosses");

  while(!isDefined(level._id_41670C1C65F3D3CF))
    waitframe();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_5DEF7AF2A9F04234::_id_3D397C9451F80077("bossArea");
    level._id_DBB3DD5AB77CCD48[level._id_DBB3DD5AB77CCD48.size] = "bossArea";
    struct = spawnStruct();
    struct._id_25087194B5E05D51 = 0;
    _func_B49CDE2A52702967("bossArea", "everybody");
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07["bossArea"] = struct;
    _func_572838690D80D959("bossArea");
    level._id_7DA9883D4168B7F1["bossArea"] = [];
    _id_029260D0089DF816 = spawnStruct();
    _id_029260D0089DF816._id_B205D90302DA2F07 = "bossArea";
    _id_029260D0089DF816._id_71AD22C5D093D90B = "orphan";
    _id_029260D0089DF816._id_7DA9883D4168B7F1 = spawnStruct();
    _id_029260D0089DF816._id_7DA9883D4168B7F1._id_6409D4F5F62F669C = 0;
    _id_029260D0089DF816._id_7DA9883D4168B7F1._id_74FD03286DAECF85 = 0;
    _id_029260D0089DF816._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E = getdvarint("dvar_74E1D62FCE88A3F6", 60);
    _id_029260D0089DF816._id_7DA9883D4168B7F1._id_F1BAB2A8FA8FE3F0 = 0;
    _id_029260D0089DF816._id_3EBB6024E3F220CA = [];
    _id_029260D0089DF816._id_25087194B5E05D51 = 0;
    _id_029260D0089DF816._id_D276B08C96430BFC = [];
    _id_029260D0089DF816._id_24A2CD19EED8F75D = [];
    _id_029260D0089DF816._id_37C530D20DF6BCDB = [];
    level._id_B205D90302DA2F07["bossArea"]["subAreas"] = [];
    level._id_B205D90302DA2F07["bossArea"]["subAreas"][0] = _id_029260D0089DF816;
    level._id_7DA9883D4168B7F1["bossArea"]["orphan"] = _id_029260D0089DF816._id_7DA9883D4168B7F1;
  }

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(getdvarint(_func_2EF675C13CA1C4AF("scr_", _id_E2958F412A7425C0.name, "_disabled"), 0) == 1)
      _id_E2958F412A7425C0.disabled = 1;

    if(getdvarint(_id_B170E67029D0B874(_id_E2958F412A7425C0.name), 0) == 1)
      _id_E2958F412A7425C0.disabled = 0;

    if(isDefined(_id_E2958F412A7425C0._id_2832364FEAFD665F) && !istrue(_id_E2958F412A7425C0.disabled))
      level._id_807BA62516150E8C[_id_E2958F412A7425C0._id_2832364FEAFD665F]._id_6A4C9FBD7AA58544[level._id_807BA62516150E8C[_id_E2958F412A7425C0._id_2832364FEAFD665F]._id_6A4C9FBD7AA58544.size] = _id_E2958F412A7425C0.name;
  }

  if(getdvarint("dvar_0D4C9B49A2E48D72", 0) != 1)
    _id_86AA0C2095854338();

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(!istrue(_id_E2958F412A7425C0.disabled)) {
      if(isDefined(_id_E2958F412A7425C0._id_EC2EC5F083DF61CD))
        [[_id_E2958F412A7425C0._id_EC2EC5F083DF61CD]](_id_E2958F412A7425C0);

      if(isDefined(_id_E2958F412A7425C0.spawnfunc))
        [[_id_E2958F412A7425C0.spawnfunc]]();
    }
  }
}

_id_B170E67029D0B874(_id_47BDE44B1ACEC603) {
  return _func_2EF675C13CA1C4AF("scr_", _id_47BDE44B1ACEC603, "_enabled");
}

_id_CA63205FB8544163(name, _id_802F2DFE1D158D89, _id_E9F87C46806E63FF) {
  level._id_807BA62516150E8C[name] = spawnStruct();
  level._id_807BA62516150E8C[name]._id_802F2DFE1D158D89 = _id_802F2DFE1D158D89;
  level._id_807BA62516150E8C[name]._id_6A4C9FBD7AA58544 = [];
  level._id_807BA62516150E8C[name].selected = [];
  level._id_807BA62516150E8C[name]._id_E9F87C46806E63FF = _id_E9F87C46806E63FF;
}

_id_469ECEAE21900C7D(_id_AED74300DAF62896, _id_7C1A491F33EEDB58, _id_302E82DA1A1989AD) {
  _id_AED74300DAF62896._id_02A7ACE0322B3320 = _id_302E82DA1A1989AD;
  _id_AED74300DAF62896._id_2832364FEAFD665F = _id_7C1A491F33EEDB58;
}

_id_86AA0C2095854338() {
  foreach(category in level._id_807BA62516150E8C) {
    if(istrue(category._id_E9F87C46806E63FF)) {
      continue;
    }
    _id_C7856E174C7CA8DD = 0;

    foreach(_id_E2958F412A7425C0 in category._id_6A4C9FBD7AA58544) {
      level._id_6A4C9FBD7AA58544[_id_E2958F412A7425C0].disabled = 1;
      _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD + level._id_6A4C9FBD7AA58544[_id_E2958F412A7425C0]._id_02A7ACE0322B3320;
    }

    if(category._id_802F2DFE1D158D89 > category._id_6A4C9FBD7AA58544.size)
      category._id_802F2DFE1D158D89 = category._id_6A4C9FBD7AA58544.size;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < category._id_802F2DFE1D158D89; _id_AC0E594AC96AA3A8++) {
      _id_302E82DA1A1989AD = randomfloat(_id_C7856E174C7CA8DD);

      foreach(_id_E2958F412A7425C0 in category._id_6A4C9FBD7AA58544) {
        if(!scripts\engine\utility::array_contains(category.selected, _id_E2958F412A7425C0))
          _id_302E82DA1A1989AD = _id_302E82DA1A1989AD - level._id_6A4C9FBD7AA58544[_id_E2958F412A7425C0]._id_02A7ACE0322B3320;

        if(_id_302E82DA1A1989AD <= 0) {
          category.selected[category.selected.size] = _id_E2958F412A7425C0;
          level._id_6A4C9FBD7AA58544[_id_E2958F412A7425C0].disabled = 0;
          _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD - level._id_6A4C9FBD7AA58544[_id_E2958F412A7425C0]._id_02A7ACE0322B3320;
          break;
        }
      }
    }
  }
}

_id_613E13E7416BFAA5(_id_B99F2F7D93950BAC) {
  level._id_6A4C9FBD7AA58544[_id_B99F2F7D93950BAC.name] = _id_B99F2F7D93950BAC;
  level._id_6A4C9FBD7AA58544[_id_B99F2F7D93950BAC.name].instances = [];
}

_id_97349B31C9626FD0(name) {
  if(!isDefined(level._id_6A4C9FBD7AA58544) || !isDefined(level._id_6A4C9FBD7AA58544[name]))
    return 0;

  return 1;
}

_id_2E6E2B664DFE3186(name, _id_1435F6F97C873063) {
  instance = spawnStruct();
  instance._id_7D8AD21E5DFD7C94 = [];
  instance._id_673ECECEE90D036E = [];
  instance.name = name;
  level._id_6A4C9FBD7AA58544[name].instances[level._id_6A4C9FBD7AA58544[name].instances.size] = instance;

  if(!istrue(_id_1435F6F97C873063))
    instance thread _id_081302C0F753EFF0();

  return instance;
}

_id_8002B09B8348902C(origin, icon, _id_E01BA8D40CCE06F4) {
  self.curorigin = origin;
  self.offset3d = (0, 0, 50);
  _id_ED70C2DA45D716DE = 1;

  if(isDefined(_id_E01BA8D40CCE06F4))
    _id_ED70C2DA45D716DE = _id_E01BA8D40CCE06F4;

  scripts\mp\gameobjects::requestid(_id_ED70C2DA45D716DE, 1, undefined, 1, 1);

  if(isDefined(icon))
    scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, icon);

  if(isDefined(self.objidnum)) {
    _id_A7C6C5D6C3D369AA = getdvarint("dvar_5CDEA3A4C5246C8F", level._id_1E1F7470C9CC40F2);
    _id_0467F4D9B8D9063B = getdvarint("dvar_A134915451DE90C6", level._id_1E1F7470C9CC40F2 * 1.05);
    scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(self.objidnum, _id_A7C6C5D6C3D369AA, _id_0467F4D9B8D9063B);
  }

  objective_setbackground(self.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.objidnum, 100);

  if(getdvarint("dvar_5D815786C431535B", 1)) {
    objective_removeallfrommask(self.objidnum);
    objective_showtoplayersinmask(self.objidnum);
  }
}

_id_8CF8796583FE070E() {
  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(istrue(_id_E2958F412A7425C0.disabled)) {
      continue;
    }
    if(isDefined(_id_E2958F412A7425C0._id_4EA49A8926593523))
      [[_id_E2958F412A7425C0._id_4EA49A8926593523]]();
  }
}

_id_7D97C0571433F835(name, loc) {
  [[level._id_6A4C9FBD7AA58544[name].spawnfunc]](loc);
}

_id_720C3B7ABF4BAAC8(name, _id_B700D8D067B3EEDB, _id_787D4BE10BA144D6) {
  self._id_B582B10663B5B2A9 = 0;
  self._id_685390C6753C2CC7 = istrue(_id_B700D8D067B3EEDB);
  self.battlechatterallowed = 0;
  self._id_47BDE44B1ACEC603 = name;
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "bossName", name);
  self._id_F2A62F02827DAAA5 = 1.0;
  thread _id_2676819F01AE14ED(name, _id_787D4BE10BA144D6);
}

_id_2676819F01AE14ED(name, _id_787D4BE10BA144D6, _id_C026F33AC9E83DEB) {
  self endon("boss_despawn");
  instance = self._id_0566868292EE2A1B;
  _id_0D42CFFB8DAA15E0 = self._id_0D42CFFB8DAA15E0;
  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(instance)) {
    instance notify("boss_death");
    instance._id_6181D0250AFA3CEC = 1;
    instance._id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    players = scripts\mp\utility\teams::getteamdata(_id_6181DE250AFA5BB6.team, "players");

    foreach(player in players) {
      if(!isDefined(player._id_8C8050D7D861D06C))
        player._id_8C8050D7D861D06C = 0;

      player._id_8C8050D7D861D06C++;
    }
  }

  droploot(_id_787D4BE10BA144D6, _id_C026F33AC9E83DEB, _id_0D42CFFB8DAA15E0);
}

droploot(_id_8CB92419E054019D, _id_C026F33AC9E83DEB, _id_0D42CFFB8DAA15E0) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  if(isDefined(_id_C026F33AC9E83DEB)) {
    droporigin = self gettagorigin(_id_C026F33AC9E83DEB);
    dropangles = self gettagangles(_id_C026F33AC9E83DEB);
  } else {
    droporigin = self.origin;
    dropangles = self.angles;
  }

  if(isDefined(_id_8CB92419E054019D) && !_id_3AACF02225CA0DA5::_id_FC1CE25282BCBA83()) {
    _id_203302B9AC91E7F4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, self);
    _id_203302B9AC91E7F4.instance = self._id_0566868292EE2A1B;
    _id_3AACF02225CA0DA5::_id_1BAFB1F579534EF6(_id_203302B9AC91E7F4, undefined, _id_8CB92419E054019D);
  } else if(!istrue(_id_0D42CFFB8DAA15E0)) {
    _id_4A6176A9A2C4C6FD = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, self);
    _id_7E52B56769FA7774::spawnpickup("brloot_valuable_gold_skull", _id_4A6176A9A2C4C6FD, 1, 1);
    _id_598E45FD9FAB6581 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, self);
    _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_598E45FD9FAB6581, 1, 1);
  }

  if(!istrue(_id_0D42CFFB8DAA15E0)) {
    _id_239A1AA79219750D = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, self);

    if(randomfloat(1) > 0.3)
      _id_7E52B56769FA7774::spawnpickup("brloot_plate_carrier_2", _id_239A1AA79219750D, 1, 1);
    else
      _id_7E52B56769FA7774::spawnpickup("brloot_plate_carrier_3", _id_239A1AA79219750D, 1, 1);
  }
}

_id_977E79522D33A02C(agent, _id_87583859F07B58E3, _id_AA1ED8F12D71A7A5) {}

_id_3BCF85FF011D31F8(_id_47BDE44B1ACEC603) {
  return scripts\engine\utility::random(level._id_6A4C9FBD7AA58544[_id_47BDE44B1ACEC603]._id_BFE291B401A9BF2A);
}

_id_5B42C74153E8DF1E(_id_C30FAD505D6EC113, _id_C30FAE505D6EC346) {
  if(isDefined(_id_C30FAD505D6EC113.instances[0]._id_E2958F412A7425C0))
    _id_12B347CBEAAA73C6 = _id_C30FAD505D6EC113.instances[0]._id_E2958F412A7425C0.origin;
  else
    _id_12B347CBEAAA73C6 = _id_C30FAD505D6EC113.instances[0]._id_FB1DEF007972B25A;

  if(isDefined(_id_C30FAE505D6EC346.instances[0]._id_E2958F412A7425C0))
    _id_12B346CBEAAA7193 = _id_C30FAE505D6EC346.instances[0]._id_E2958F412A7425C0.origin;
  else
    _id_12B346CBEAAA7193 = _id_C30FAE505D6EC346.instances[0]._id_FB1DEF007972B25A;

  return distance(level._id_2CB9134B39839C1F, _id_12B347CBEAAA73C6) < distance(level._id_2CB9134B39839C1F, _id_12B346CBEAAA7193);
}

_id_8B655A333DDB63CC(instance) {
  if(isDefined(instance._id_E2958F412A7425C0) && isDefined(instance._id_E2958F412A7425C0.origin))
    return 1;
  else if(isDefined(instance._id_FB1DEF007972B25A))
    return 1;

  return 0;
}

_id_B34CF3006201B016(player, showicon, origin) {
  if(!isDefined(showicon))
    showicon = 1;

  _id_2CF357B1074EEFC9 = [];

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(isDefined(_id_E2958F412A7425C0.instances) && isDefined(_id_E2958F412A7425C0.instances[0]) && isDefined(_id_E2958F412A7425C0._id_7232C52496C3A94A) && _id_8B655A333DDB63CC(_id_E2958F412A7425C0.instances[0]))
      _id_2CF357B1074EEFC9[_id_2CF357B1074EEFC9.size] = _id_E2958F412A7425C0;
  }

  level._id_2CB9134B39839C1F = origin;
  _id_6A4C9FBD7AA58544 = scripts\engine\utility::array_sort_with_func(_id_2CF357B1074EEFC9, ::_id_5B42C74153E8DF1E);

  foreach(name, _id_E2958F412A7425C0 in _id_6A4C9FBD7AA58544) {
    _id_350151B82BA9C8FC = _id_E2958F412A7425C0.instances[0][[_id_E2958F412A7425C0._id_7232C52496C3A94A]](player, showicon);

    if(istrue(_id_350151B82BA9C8FC)) {
      break;
    }
  }
}

_id_081302C0F753EFF0() {
  self endon("boss_death");
  self waittill("boss_spawned");

  for(;;) {
    wait 1;

    if(!isDefined(self._id_E2958F412A7425C0)) {
      return;
    }
    _id_B9CEAB2F62602996 = 1;

    if(isDefined(self._id_E2958F412A7425C0._id_0109D6AFBC11C5F9))
      _id_B9CEAB2F62602996 = self._id_E2958F412A7425C0._id_0109D6AFBC11C5F9;

    players = scripts\mp\utility\player::getplayersinradius(self._id_E2958F412A7425C0.origin, level._id_1E1F7470C9CC40F2 * _id_B9CEAB2F62602996);

    foreach(player in players) {
      if(isDefined(self._id_7D8AD21E5DFD7C94)) {
        if(scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, player.team)) {
          continue;
        }
        if(isDefined(level._id_22ABCD778E5212B6)) {
          [[level._id_22ABCD778E5212B6]](self, player);
          continue;
        }

        _id_0AE49568842BCE7E(player, self.name, 0);
      }
    }
  }
}

_id_0AE49568842BCE7E(player, _id_47BDE44B1ACEC603, showicon) {
  _id_E2958F412A7425C0 = level._id_6A4C9FBD7AA58544[_id_47BDE44B1ACEC603];

  if(isDefined(_id_E2958F412A7425C0.instances) && isDefined(_id_E2958F412A7425C0.instances[0]) && isDefined(_id_E2958F412A7425C0._id_7232C52496C3A94A)) {
    _id_350151B82BA9C8FC = _id_E2958F412A7425C0.instances[0][[_id_E2958F412A7425C0._id_7232C52496C3A94A]](player, showicon);

    if(istrue(_id_350151B82BA9C8FC))
      return;
  }
}

_id_35826E6CD8838C47(_id_47BDE44B1ACEC603) {
  _id_E2958F412A7425C0 = level._id_6A4C9FBD7AA58544[_id_47BDE44B1ACEC603];

  if(isDefined(_id_E2958F412A7425C0.instances) && isDefined(_id_E2958F412A7425C0.instances[0]))
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_E2958F412A7425C0.instances[0].objidnum);
}

_id_49725DC1ABCC7B7E(dist) {
  self endon("death");
  self notify("stopDDOSOnApproach");
  self endon("stopDDOSOnApproach");
  objweapon = makeweapon("emp_pulse_mp");

  for(;;) {
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    players = scripts\mp\utility\player::getplayersinradius(self.origin, dist);
    _id_8B46F59F3B68959B = 0;

    foreach(player in players) {
      if(isDefined(player.vehicle) && !istrue(player.vehicle._id_D547BF7EEC5D2FC3)) {
        if(!_id_8B46F59F3B68959B) {
          playsoundatpos(self.origin, "iw9_emp_blast");
          _id_8B46F59F3B68959B = 1;
        }

        thread _id_88AEB060FA33DF32(objweapon, player.vehicle);
      }
    }
  }
}

_id_88AEB060FA33DF32(objweapon, ent) {
  ent thread _id_504B107D5BEB809A(10, self);
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
  scripts\cp_mp\emp_debuff::_id_662905D3B9455612(data, 10, 0);
}

_id_504B107D5BEB809A(duration, target) {
  self endon("death");
  target endon("death");
  self._id_D547BF7EEC5D2FC3 = 1;

  while(duration > 0) {
    duration = duration - 0.1;

    if(distancesquared(self.origin, target.origin) < 122500) {
      self _meth_65AA053C077C003A(1);
      wait(duration);
      break;
    }

    wait 0.1;
  }

  self _meth_65AA053C077C003A(0);
  self._id_D547BF7EEC5D2FC3 = 0;
}

_id_3C9B7EA5BE9B4602(_id_E2958F412A7425C0, event) {
  level endon("game_ended");
  self endon("death");
  _id_E2958F412A7425C0 endon("death");

  if(!isDefined(event))
    event = "weapons_case_circle";

  _id_C28C201A029CD864 = [];

  while(scripts\cp_mp\utility\game_utility::_id_ACAA75CA8754452E()) {
    foreach(player in level.players) {
      if(!isbot(player) && scripts\mp\utility\player::isreallyalive(player) && !scripts\engine\utility::array_contains(_id_C28C201A029CD864, player.team) && distance2d(player.origin, scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4()) < level._id_E8E2A2FC82E5F664) {
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9(event, player.team);
        _id_C28C201A029CD864[_id_C28C201A029CD864.size] = player.team;
      }
    }

    wait 5;
  }
}

_id_DCB165F2C4A3540E() {
  level._id_A269859F35C262DB = spawnStruct();
  level._id_A269859F35C262DB.active = [];

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544)
  level._id_A269859F35C262DB.active[_id_E2958F412A7425C0.name] = [];

  level._id_A269859F35C262DB._id_50D5778DEE4DC179 = [];
}

_id_3A444DB2E20B0C55(_id_47BDE44B1ACEC603) {
  if(!isDefined(level._id_A269859F35C262DB))
    _id_DCB165F2C4A3540E();

  level._id_A269859F35C262DB.active[_id_47BDE44B1ACEC603] = [];
}

_id_C5D5102D273166DA(name, _id_B205D90302DA2F07, player) {
  struct = spawnStruct();
  struct._id_887FC780763A1CEE = name;
  struct._id_F16943ECDB32A1A3 = _id_B205D90302DA2F07;
  struct._id_C77C162080853A11 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  struct._id_48133D2CBBB25B21 = player.origin[0];
  struct._id_48133C2CBBB258EE = player.origin[1];
  struct._id_48133B2CBBB256BB = player.origin[2];
  struct.player = player;
  return struct;
}

_id_A3C846C7AE153DF3(name, player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon(name + "dlogEnd");

  if(!isDefined(level._id_A269859F35C262DB))
    _id_DCB165F2C4A3540E();

  player waittill("death", _id_6181DE250AFA5BB6);
  _id_06A87B8028EC2B55 = scripts\engine\utility::ter_op(isPlayer(_id_6181DE250AFA5BB6), "player killed by player", "player killed by agents");

  if(!isDefined(level._id_A269859F35C262DB.active[player.guid])) {
    return;
  }
  level._id_A269859F35C262DB.active[player.guid]._id_A69779B02ECC27FB = _id_06A87B8028EC2B55;
  _id_556D526C176D2CA2(name, player);
}

_id_EDFC0980C118308F(name, player, _id_616EA41542B3D45A, dist) {
  level endon("game_ended");
  player endon("disconnect");
  player endon(name + "dlogEnd");
  distsq = dist * dist;

  while(distance2dsquared(player.origin, _id_616EA41542B3D45A.origin) < distsq)
    wait 1;

  _id_1A3F3207B8B08CBD(name, player);
}

_id_9483543F1B1BFA73(name, _id_B205D90302DA2F07, player, _id_616EA41542B3D45A, dist) {
  if(!isDefined(level._id_A269859F35C262DB))
    _id_DCB165F2C4A3540E();

  if(isDefined(level._id_A269859F35C262DB.active[name][player.guid])) {
    return;
  }
  level._id_A269859F35C262DB.active[name][player.guid] = _id_C5D5102D273166DA(name, _id_B205D90302DA2F07, player);

  if(isent(_id_616EA41542B3D45A) && isDefined(dist))
    player thread _id_EDFC0980C118308F(name, player, _id_616EA41542B3D45A, dist);

  player thread _id_A3C846C7AE153DF3(name, player);
}

_id_1A3F3207B8B08CBD(name, player) {
  if(!isDefined(level._id_A269859F35C262DB))
    _id_DCB165F2C4A3540E();

  if(!isDefined(level._id_A269859F35C262DB.active[name][player.guid])) {
    return;
  }
  level._id_A269859F35C262DB.active[name][player.guid]._id_A69779B02ECC27FB = "player fled";

  if(isDefined(name) && name == "UFO") {
    player stopplayermusicstate("mx_dmz_boss_ufo_combat_ship");
    player.nosuspensemusic = undefined;
  }

  _id_556D526C176D2CA2(name, player);
}

_id_3E409004EDF37731(name) {
  if(!isDefined(level._id_A269859F35C262DB))
    _id_DCB165F2C4A3540E();

  foreach(active in level._id_A269859F35C262DB.active[name]) {
    active._id_A69779B02ECC27FB = "boss killed";
    _id_556D526C176D2CA2(name, active.player);
  }
}

_id_556D526C176D2CA2(name, player) {
  player notify(name + "dlogEnd");

  if(!isDefined(player) || !isDefined(level._id_A269859F35C262DB.active[name][player.guid])) {
    return;
  }
  struct = level._id_A269859F35C262DB.active[name][player.guid];
  struct._id_C8A87E0DA59FED1C = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  player dlog_recordplayerevent("dlog_event_dmz_boss_encounter", ["boss_name", _func_1823FF50BB28148D(struct._id_887FC780763A1CEE), "combat_start_timestamp", struct._id_C77C162080853A11, "combat_end_timestamp", struct._id_C8A87E0DA59FED1C, "boss_outcome", _func_1823FF50BB28148D(struct._id_A69779B02ECC27FB), "boss_poi", _func_1823FF50BB28148D(struct._id_F16943ECDB32A1A3), "player_position_x", struct._id_48133D2CBBB25B21, "player_position_y", struct._id_48133C2CBBB258EE, "player_position_z", struct._id_48133B2CBBB256BB]);
  level._id_A269859F35C262DB.active[name][player.guid] = undefined;
}