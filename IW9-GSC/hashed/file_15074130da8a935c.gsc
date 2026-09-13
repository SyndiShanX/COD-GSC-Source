/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_15074130da8a935c.gsc
***********************************************/

init(_id_224BF1253364B30A, _id_487AA685C1C31808, _id_3B24D8DC30CA944B, _id_8652221C9D53D1A3) {
  level waittill("prematch_over");

  if(!isDefined(level.brgametype)) {
    return;
  }
  if(getdvarint("dvar_22BDD6F7E2988733", 1) == 1) {
    if(isDefined(_id_224BF1253364B30A)) {
      level.brgametype._id_FC940842D42C2893 = getscriptbundle(_id_224BF1253364B30A);

      if(!isDefined(_id_3B24D8DC30CA944B))
        _id_3B24D8DC30CA944B = getdvarfloat("dvar_C7995999EC4E8CF4", 0.6);

      _id_83F276EF36C2E4AB(level.brgametype._id_FC940842D42C2893, _id_3B24D8DC30CA944B);
    }
  }

  if(getdvarint("dvar_6F8A167ABF7E11E0", 1) == 1) {
    if(isDefined(_id_487AA685C1C31808)) {
      _id_428C9AAD17E4E279 = getscriptbundle(_id_487AA685C1C31808);

      if(!isDefined(_id_8652221C9D53D1A3))
        _id_8652221C9D53D1A3 = getdvarfloat("dvar_0809CCD5453BE062", 0.6);

      _id_83F276EF36C2E4AB(_id_428C9AAD17E4E279, _id_8652221C9D53D1A3);
    }
  }
}

_id_83F276EF36C2E4AB(_id_428C9AAD17E4E279, _id_73783E51D7DCA907) {
  if(!isDefined(_id_428C9AAD17E4E279)) {
    return;
  }
  _id_BED8B702214653A5 = _id_428C9AAD17E4E279._id_6C073ECDC1C6DBA5;

  if(_id_BED8B702214653A5.size == 0) {
    return;
  }
  total = scripts\engine\math::round_float(_id_73783E51D7DCA907 * _id_BED8B702214653A5.size, 0, 0);
  spawnlist = [];

  foreach(item in _id_BED8B702214653A5) {
    if(istrue(item.forcespawn))
      spawnlist = scripts\engine\utility::array_add(spawnlist, item);
  }

  _id_BED8B702214653A5 = scripts\engine\utility::array_remove_array(_id_BED8B702214653A5, spawnlist);
  _id_DFA02EACCC952A61 = scripts\engine\utility::array_randomize(_id_BED8B702214653A5);
  _id_97B793950B017FB3 = _id_A7B6924C27B24419(_id_DFA02EACCC952A61);

  for(_id_AC0E594AC96AA3A8 = spawnlist.size; _id_AC0E594AC96AA3A8 < total; _id_AC0E594AC96AA3A8++) {
    _id_08A63095AA5E38B7 = randomfloat(_id_97B793950B017FB3);
    _id_3F458DE11E9ED610 = _id_353D1B9E0A8FBCA5(_id_DFA02EACCC952A61, _id_08A63095AA5E38B7);
    _id_97B793950B017FB3 = _id_97B793950B017FB3 - _id_3F458DE11E9ED610.weight;
    spawnlist = scripts\engine\utility::array_add(spawnlist, _id_3F458DE11E9ED610);
    _id_DFA02EACCC952A61 = scripts\engine\utility::array_remove(_id_DFA02EACCC952A61, _id_3F458DE11E9ED610);
  }

  foreach(item in spawnlist)
  _id_77708FBF186D74D6(item);
}

_id_77708FBF186D74D6(_id_31B8245C9CEA94D0) {
  if(!isDefined(_id_31B8245C9CEA94D0)) {
    return;
  }
  _id_7957AE38C168F3DF = _id_31B8245C9CEA94D0._id_D2D351BEAAB03413;
  _id_22CE7236B68B2334 = _id_31B8245C9CEA94D0._id_96C78BFDAF20AA5A;
  count = _id_7D625073C6379D53::getitemcount(_id_7957AE38C168F3DF);

  if(_id_7E52B56769FA7774::_id_1BE34022A4ACCE73(_id_7957AE38C168F3DF))
    count = undefined;

  _id_F126F0C539F806B1 = randomint(_id_22CE7236B68B2334.size);
  origin = _id_57718C5233376CF1(_id_22CE7236B68B2334[_id_F126F0C539F806B1].spawnorigin);
  angles = _id_57718C5233376CF1(_id_22CE7236B68B2334[_id_F126F0C539F806B1].spawnangle);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);
  scriptable._id_BBC200BC77C5DB2B = 1;
}

_id_57718C5233376CF1(_id_16290C9DDA466BCE) {
  return (scripts\engine\utility::_id_53C4C53197386572(_id_16290C9DDA466BCE.x, 0.0), scripts\engine\utility::_id_53C4C53197386572(_id_16290C9DDA466BCE.y, 0.0), scripts\engine\utility::_id_53C4C53197386572(_id_16290C9DDA466BCE.z, 0.0));
}

_id_353D1B9E0A8FBCA5(array, _id_D0C6C63850505514) {
  _id_356F4E2CFC1AA9B3 = 0;

  foreach(item in array) {
    _id_356F4E2CFC1AA9B3 = _id_356F4E2CFC1AA9B3 + item.weight;

    if(_id_356F4E2CFC1AA9B3 > _id_D0C6C63850505514)
      return item;
  }
}

_id_A7B6924C27B24419(array) {
  _id_C35D9F1ADC6B131F = 0.0;

  foreach(item in array)
  _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + item.weight;

  return _id_C35D9F1ADC6B131F;
}