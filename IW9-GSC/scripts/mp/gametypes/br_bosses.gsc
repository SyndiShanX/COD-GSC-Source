/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bosses.gsc
***********************************************/

_id_1CCD859721E5EAEE() {
  level endon("game_ended");

  if(_id_744CAD313ED0A87E::_id_A9B26D3ED078E149())
    level waittill("spawn_brStrongholdSpawn");
  else {
    while(!isDefined(level._id_F1073FBD45B59A06) || !istrue(level._id_F1073FBD45B59A06._id_9B87FDB80920F442))
      waitframe();
  }

  if(!isDefined(level._id_6A4C9FBD7AA58544))
    level._id_6A4C9FBD7AA58544 = [];

  level._id_1E1F7470C9CC40F2 = getdvarint("dvar_263DED1FD47C7B48", 4000);
  _id_6172179F6BD0769E::_id_4C60C607A6E7B9AE();

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(getdvarint(_func_2EF675C13CA1C4AF("scr_", _id_E2958F412A7425C0.name, "_disabled"), 0) > 0) {
      _id_E2958F412A7425C0.disabled = 1;
      continue;
    }

    if(isDefined(_id_E2958F412A7425C0._id_EC2EC5F083DF61CD))
      [[_id_E2958F412A7425C0._id_EC2EC5F083DF61CD]](_id_E2958F412A7425C0);
  }

  _id_48814951E916AF89::_id_2FC80954FA70D153();

  foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
    if(!istrue(_id_E2958F412A7425C0.disabled) && isDefined(_id_E2958F412A7425C0._id_4EA49A8926593523))
      level thread[[_id_E2958F412A7425C0._id_4EA49A8926593523]]();
  }
}

_id_613E13E7416BFAA5(_id_B99F2F7D93950BAC) {
  level._id_6A4C9FBD7AA58544[_id_B99F2F7D93950BAC.name] = _id_B99F2F7D93950BAC;
}

_id_2E6E2B664DFE3186(name, _id_1435F6F97C873063) {
  if(!isDefined(level._id_6A4C9FBD7AA58544))
    level._id_6A4C9FBD7AA58544 = [];

  instance = spawnStruct();
  instance._id_7D8AD21E5DFD7C94 = [];
  instance._id_673ECECEE90D036E = [];
  instance.name = name;

  if(!isDefined(level._id_6A4C9FBD7AA58544[name].instances))
    level._id_6A4C9FBD7AA58544[name].instances = [];

  level._id_6A4C9FBD7AA58544[name].instances[level._id_6A4C9FBD7AA58544[name].instances.size] = instance;
  return instance;
}

_id_7D97C0571433F835(name, node) {
  return [[level._id_6A4C9FBD7AA58544[name].spawnfunc]](node);
}

_id_C0D4FDA4400B5A08(name) {
  if(!istrue(level._id_3D652C7CD2F573B8)) {
    return;
  }
  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
    if(!isDefined(_id_276AC5E84835EA87._id_E2958F412A7425C0)) {
      continue;
    }
    if(isDefined(_id_276AC5E84835EA87._id_E2958F412A7425C0) && _id_276AC5E84835EA87._id_E2958F412A7425C0.size == 0) {
      continue;
    }
    if(randomfloat(1.0) <= level._id_97430573E62D0760) {
      node = _id_276AC5E84835EA87._id_E2958F412A7425C0[randomint(_id_276AC5E84835EA87._id_E2958F412A7425C0.size)];
      _id_E2958F412A7425C0 = _id_7D97C0571433F835(name, node);

      if(isDefined(_id_E2958F412A7425C0)) {
        _id_276AC5E84835EA87._id_837C4B569AA8A376[_id_276AC5E84835EA87._id_837C4B569AA8A376.size] = _id_E2958F412A7425C0;
        _id_E2958F412A7425C0._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
      }
    }
  }
}

_id_720C3B7ABF4BAAC8(name, _id_B700D8D067B3EEDB) {
  self._id_B582B10663B5B2A9 = 0;
  self._id_685390C6753C2CC7 = istrue(_id_B700D8D067B3EEDB);

  if(getdvarint("dvar_0B3A452DBB8A7C28", 0) > 0)
    self _meth_3DE79443C911D4A5(1, 4, level._id_6A4C9FBD7AA58544[name]._id_C8CDA7EEE067D67C);

  thread _id_2676819F01AE14ED(name);
}

_id_2676819F01AE14ED(name) {
  level endon("game_ended");
  self waittill("death", _id_6181DE250AFA5BB6);
}

_id_97349B31C9626FD0(name) {
  if(!isDefined(level._id_6A4C9FBD7AA58544) || !isDefined(level._id_6A4C9FBD7AA58544[name]))
    return 0;

  return 1;
}

_id_CA63205FB8544163(name, _id_802F2DFE1D158D89, _id_E9F87C46806E63FF) {
  level._id_807BA62516150E8C[name] = spawnStruct();
  level._id_807BA62516150E8C[name]._id_802F2DFE1D158D89 = _id_802F2DFE1D158D89;
  level._id_807BA62516150E8C[name]._id_6A4C9FBD7AA58544 = [];
  level._id_807BA62516150E8C[name].selected = [];
  level._id_807BA62516150E8C[name]._id_E9F87C46806E63FF = [];
}

_id_F7B1205F52BED8EB() {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, "bossArea"))
      level._id_DBB3DD5AB77CCD48[level._id_DBB3DD5AB77CCD48.size] = "bossArea";
    else
      return;

    _id_5DEF7AF2A9F04234::_id_3D397C9451F80077("bossArea");
    level._id_807BA62516150E8C = [];
    _id_CA63205FB8544163("additive", getdvarint("dvar_E3D97F0B560BF50C", 1));
    _id_CA63205FB8544163("main", getdvarint("dvar_3566AD5E92967DEF", 5));
    _id_CA63205FB8544163("haunting", getdvarint("dvar_BE5422B0017A66A8", 5), 1);
  }

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
  _id_029260D0089DF816._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E = getdvarint("dvar_00E792A8AEC3FEED", 50);
  _id_029260D0089DF816._id_7DA9883D4168B7F1._id_F1BAB2A8FA8FE3F0 = 0;
  _id_029260D0089DF816._id_3EBB6024E3F220CA = [];
  _id_029260D0089DF816._id_25087194B5E05D51 = 0;
  _id_029260D0089DF816._id_D276B08C96430BFC = [];
  _id_029260D0089DF816._id_24A2CD19EED8F75D = [];
  _id_029260D0089DF816._id_37C530D20DF6BCDB = [];

  if(!isDefined(level._id_B205D90302DA2F07["bossArea"]["subAreas"]) || level._id_B205D90302DA2F07["bossArea"]["subAreas"].size == 0) {
    level._id_B205D90302DA2F07["bossArea"]["subAreas"] = [];
    level._id_B205D90302DA2F07["bossArea"]["subAreas"][0] = _id_029260D0089DF816;
  }
}