/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_9e8ccad6488211b.gsc
***********************************************/

_id_89E1A31BD1DE0567() {
  return _id_5C61825C1DCE3571::_id_94B952789D039ABB() && getdvarint("dvar_81F6CB3096A4D43D", 1) == 1;
}

_id_EE43F827080726B1() {
  player = self;
  _id_FE9B2D3F30F59726 = 0;

  if(player _id_5C61825C1DCE3571::_id_83FC92D8CE12EC9E(3))
    _id_FE9B2D3F30F59726 = istrue(player._id_B0F02709599E955C);
  else
    _id_FE9B2D3F30F59726 = player _id_5C61825C1DCE3571::_id_83FC92D8CE12EC9E(2);

  return _id_FE9B2D3F30F59726;
}

_id_8B22E17D9E3AAEA3(player) {
  if(isbot(player))
    return undefined;

  if(player _id_EE43F827080726B1() && _id_89E1A31BD1DE0567()) {
    player._id_F4E78B41C7D793A2 = 1;
    return player _id_2D8BAC720C7F42BB();
  }

  return undefined;
}

_id_70781ACE6E552A59() {
  return isPlayer(self) && !isbot(self) && scripts\mp\gamelogic::_id_1147BBC93EA9B83C() && _id_EE43F827080726B1();
}

_id_4E21C98001BA4234() {
  return getdvarint("dvar_13A4ACE57E9B30C9", 3);
}

_id_D6BB894ECEEAD27A() {
  return getdvarint("dvar_6BC7552224FA36E3", 1);
}

_id_15CA97C3FBEB7F4C() {
  return getDvar("dvar_9652FDEEE6B218AB", "iw9_ar_mike4");
}

_id_7AEEF922B38C730B() {
  player = self;
  return !isbot(player) && player scripts\mp\rank::getrankxp() < scripts\mp\rank::getrankinfomaxxp(_id_4E21C98001BA4234());
}

_id_F2A89A989CFA8BC7() {
  player = self;
  _id_C27E2A04BAB78C1F = _id_15CA97C3FBEB7F4C();
  return !isbot(player) && scripts\mp\weaponrank::getplayerweaponrank(_id_C27E2A04BAB78C1F) < _id_D6BB894ECEEAD27A();
}

_id_2D8BAC720C7F42BB() {
  player = self;
  _id_09FE50C508CCE09F = player _id_7AEEF922B38C730B();
  _id_B6ABC53FE90BF80B = player _id_F2A89A989CFA8BC7();
  values = spawnStruct();
  _id_DFE29A76A113F620 = 0;

  if(_id_09FE50C508CCE09F)
    _id_DFE29A76A113F620 = player _id_AB7376CF3322041F();

  values._id_EFE4124EAA21EA43 = _id_DFE29A76A113F620;
  values._id_05DB83A557FCD180 = _id_DFE29A76A113F620;
  values._id_DD7D0DDB84506614 = _id_DFE29A76A113F620;
  values._id_E2DDE397B32F23BC = 0;
  values._id_68EB858FD6EA5428 = 0;
  _id_46B845634A24856C = 0;
  _id_904C82687DDFEB02 = 0;

  if(_id_B6ABC53FE90BF80B) {
    _id_1BD089321BB876B3 = _id_15CA97C3FBEB7F4C();

    if(isDefined(level.weaponmapdata[_id_1BD089321BB876B3]) && isDefined(level.weaponmapdata[_id_1BD089321BB876B3]._id_904C82687DDFEB02))
      _id_904C82687DDFEB02 = level.weaponmapdata[_id_1BD089321BB876B3]._id_904C82687DDFEB02;

    _id_46B845634A24856C = player _id_8CB6F3856A8745AF();
  }

  values._id_904C82687DDFEB02 = _id_904C82687DDFEB02;
  values._id_CC603E175ABFEF2D = _id_46B845634A24856C;
  return values;
}

_id_AB7376CF3322041F() {
  player = self;
  _id_C0BE48950CF3E343 = getdvarint("dvar_13A4ACE57E9B30C9", 0);
  _id_C5732E73897E110B = scripts\mp\rank::getrankinfomaxxp(_id_C0BE48950CF3E343);
  _id_450A34EF30AB6217 = player getplayerdata("common", "mpProgression", "playerLevel", "xp") + player.pers["summary"]["xp"];
  return int(max(_id_C5732E73897E110B - 1 - _id_450A34EF30AB6217, 0));
}

_id_8CB6F3856A8745AF() {
  player = self;
  return int(max(scripts\mp\weaponrank::getweaponrankinfominxp(_id_D6BB894ECEEAD27A()) - player scripts\mp\weaponrank::getplayerweaponrankxp(_id_15CA97C3FBEB7F4C(), "mp"), 0));
}