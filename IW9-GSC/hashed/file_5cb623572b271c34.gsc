/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5cb623572b271c34.gsc
***********************************************/

_id_962089C12B654934(player) {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return 0;

  foreach(soldier in level._id_F78FB7634E3797C4) {
    if(isDefined(soldier._id_D219AF81A2A0505B) && soldier._id_D219AF81A2A0505B == player)
      return 1;
  }

  return 0;
}

_id_5C6C98E7D15B8D4A(player) {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return undefined;

  _id_14DC09926E8E1B2F = [];

  foreach(soldier in level._id_F78FB7634E3797C4) {
    owner = soldier.owner;

    if(isDefined(soldier._id_D219AF81A2A0505B))
      owner = soldier._id_D219AF81A2A0505B;

    if(isDefined(owner) && owner == player)
      _id_14DC09926E8E1B2F[_id_14DC09926E8E1B2F.size] = soldier;
  }

  if(_id_14DC09926E8E1B2F.size > 0)
    return _id_14DC09926E8E1B2F;

  return undefined;
}

_id_5BD736549F8D4441() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return undefined;

  _id_14DC09926E8E1B2F = [];

  foreach(soldier in level._id_F78FB7634E3797C4) {
    owner = soldier.owner;

    if(isDefined(soldier._id_D219AF81A2A0505B))
      owner = soldier._id_D219AF81A2A0505B;

    if(isDefined(owner))
      _id_14DC09926E8E1B2F[_id_14DC09926E8E1B2F.size] = soldier;
  }

  if(_id_14DC09926E8E1B2F.size > 0)
    return _id_14DC09926E8E1B2F;

  return undefined;
}

_id_110F112431C654DC() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return 0;

  return level._id_F78FB7634E3797C4.size;
}

_id_87AC668A043AF5DD() {
  if(isDefined(level._id_506605F16EFCE39A))
    return level._id_506605F16EFCE39A;

  return 8;
}