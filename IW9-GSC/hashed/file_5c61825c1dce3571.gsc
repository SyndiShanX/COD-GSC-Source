/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5c61825c1dce3571.gsc
***********************************************/

_id_94B952789D039ABB() {
  return getdvarint("dvar_05AD0894B28995C4", 0) == 1;
}

_id_2195503B0DCC12C0() {
  if(_id_A226C96F1BA59CD0()) {
    level._id_98BBC6461BB67F0B = spawnStruct();
    level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9 = [];
    level._id_98BBC6461BB67F0B._id_4FAACF7795179C8F = 1;
  }
}

_id_A226C96F1BA59CD0() {
  return istrue(getdvarint("dvar_9615D7FB7CF74E4C", 0));
}

_id_83FC92D8CE12EC9E(_id_08FA011B559791F7) {
  _id_FB7636D1A4A5A6E3 = _id_8E931D2F54036D6D("ftueProgress", _id_08FA011B559791F7, "completed");
  return _id_FB7636D1A4A5A6E3 > 0;
}

_id_8951A5E5929491BB(_id_08FA011B559791F7) {
  return 1;
}

_id_E05669C955312C22(_id_08FA011B559791F7, value) {
  _id_1E0F3B7CD5051CC6 = _id_8951A5E5929491BB(_id_08FA011B559791F7);
  _id_EF834A530F602E31("ftueProgress", _id_08FA011B559791F7, "completed", value);
  _id_EF834A530F602E31("ftueProgress", _id_08FA011B559791F7, "completedVersion", _id_1E0F3B7CD5051CC6);
  self _meth_4A2DD963E8A112AB(_id_08FA011B559791F7);
}

_id_F3C2D9FE39C96C53(_id_08FA011B559791F7) {
  _id_5159F960A67ED33B = _id_8E931D2F54036D6D("ftueProgress", _id_08FA011B559791F7, "completedVersion");
  return _id_5159F960A67ED33B;
}

_id_A220DAC697D2EA35() {
  return _id_70E4A8C54777F552("brMatchPlayTime");
}

_id_02F80E3CA1B2374A(_id_F5CA237F98FB4CF6) {
  _id_007872BADF3D67B9 = _id_A220DAC697D2EA35() + _id_F5CA237F98FB4CF6;
  _id_9C70C77CCECB444E("brMatchPlayTime", _id_007872BADF3D67B9);
}

_id_0DA8CF8DBDB763AE() {
  return _id_70E4A8C54777F552("matchesCompleted");
}

_id_312E1BABFFBDF863() {
  _id_E3BAE78E134D874D = _id_0DA8CF8DBDB763AE() + 1;
  _id_9C70C77CCECB444E("matchesCompleted", _id_E3BAE78E134D874D);
  return _id_E3BAE78E134D874D;
}

_id_663FCC46A62EBE2B(params) {
  _id_A1E085D89D95DC6F = _id_0DA8CF8DBDB763AE();

  if(_id_A1E085D89D95DC6F >= params._id_31C4C1D952B9E73D)
    return 1;

  return 0;
}

_id_A25D14ECF8DCB49E(index) {
  _id_40145099A2BF47CA = _id_1E6D534CAEF3039F();
  mask = 1 << index;
  _id_40145099A2BF47CA = _id_40145099A2BF47CA | mask;
  _id_E35C082C18FF343B(_id_40145099A2BF47CA);
}

_id_5F50AE7BFF599E0A(index) {
  _id_40145099A2BF47CA = _id_1E6D534CAEF3039F();
  mask = 1 << index;
  return istrue(_id_40145099A2BF47CA &mask);
}

_id_7FBC76F1AEFC8FC5() {
  if(_id_A226C96F1BA59CD0())
    return level._id_98BBC6461BB67F0B._id_4FAACF7795179C8F;
  else
    return _id_70E4A8C54777F552("playerExpertiseOption");
}

_id_523A12B7460EBD22() {
  return _id_70E4A8C54777F552("tooltipsDisabled");
}

_id_70E4A8C54777F552(data) {
  return _id_1E8137ACA9687477("ftueCommonData", data);
}

_id_9C70C77CCECB444E(data, value) {
  _id_7A70551396A38F2B("ftueCommonData", data, value);
}

_id_8E931D2F54036D6D(_id_3CA70D3281EB0441, index, data) {
  return _id_2FB0985CF3162E78("ftueCommonData", _id_3CA70D3281EB0441, index, data);
}

_id_EF834A530F602E31(_id_3CA70D3281EB0441, index, data, value) {
  _id_24615288BDE909B4("ftueCommonData", _id_3CA70D3281EB0441, index, data, value);
}

_id_1E8137ACA9687477(key, data) {
  _id_0AD3658A1088AF24 = self getplayerdata("mp", key, data);
  return _id_0AD3658A1088AF24;
}

_id_2FB0985CF3162E78(key, _id_3CA70D3281EB0441, index, data) {
  _id_0AD3658A1088AF24 = self getplayerdata("mp", key, _id_3CA70D3281EB0441, index, data);
  return _id_0AD3658A1088AF24;
}

_id_7A70551396A38F2B(key, data, value) {
  self setplayerdata("mp", key, data, value);
}

_id_24615288BDE909B4(key, _id_3CA70D3281EB0441, index, data, value) {
  self setplayerdata("mp", key, _id_3CA70D3281EB0441, index, data, value);
}

_id_1E6D534CAEF3039F() {
  _id_40145099A2BF47CA = 0;

  if(_id_A226C96F1BA59CD0())
    _id_40145099A2BF47CA = _id_892873A4B3C135EF(self);
  else
    _id_40145099A2BF47CA = _id_70E4A8C54777F552("tooltipsCompleted_01");

  return _id_40145099A2BF47CA;
}

_id_E35C082C18FF343B(_id_40145099A2BF47CA) {
  if(_id_A226C96F1BA59CD0())
    _id_C79DA86A5696572B(self, _id_40145099A2BF47CA);
  else
    _id_9C70C77CCECB444E("tooltipsCompleted_01", _id_40145099A2BF47CA);

  self _meth_B10F7A73EAC6E1C2(_id_40145099A2BF47CA);
}

_id_892873A4B3C135EF(player) {
  _id_AA20CCA13A2CC9CD(player);

  foreach(_id_F90358454413407F in level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9) {
    if(isDefined(_id_F90358454413407F) && _id_F90358454413407F.player == player)
      return _id_F90358454413407F._id_EFC2B352015E6B82;
  }
}

_id_C79DA86A5696572B(player, value) {
  _id_AA20CCA13A2CC9CD(player);

  foreach(_id_F90358454413407F in level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9) {
    if(isDefined(_id_F90358454413407F) && _id_F90358454413407F.player == player) {
      _id_F90358454413407F._id_EFC2B352015E6B82 = value;
      break;
    }
  }
}

_id_AA20CCA13A2CC9CD(player) {
  foreach(_id_F90358454413407F in level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9) {
    if(isDefined(_id_F90358454413407F) && _id_F90358454413407F.player == player)
      return;
  }

  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F.player = player;
  _id_F90358454413407F._id_EFC2B352015E6B82 = getdvarint("dvar_92E4360591AE4BAF", 0);
  level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9 = scripts\engine\utility::array_add_safe(level._id_98BBC6461BB67F0B._id_F8F7108D5F8686C9, _id_F90358454413407F);
}