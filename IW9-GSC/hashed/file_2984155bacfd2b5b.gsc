/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2984155bacfd2b5b.gsc
***********************************************/

_id_5FA1FE4DAE3FB84F() {
  if(!isDefined(level.quests))
    level.quests = spawnStruct();

  if(!isDefined(level.quests._id_9FB489F117738FAA))
    level.quests._id_9FB489F117738FAA = [];
}

_id_89AEDD24EB702B29(function, config) {
  level endon("game_ended");
  self endon("disconnect");
  _id_5041F2BFDC1EABDD = _id_5A82971F97B0916D(function);

  switch (_id_5041F2BFDC1EABDD.state) {
    case 0:
      _id_9632C09E3E228DBC(function, config);
      break;
    case 1:
      _id_8733E0C0EBC700DB(function);
      break;
    case 2:
      return;
  }
}

_id_5A82971F97B0916D(function) {
  _id_5041F2BFDC1EABDD = _id_BB00D006668F2D8A(function);

  if(!isDefined(_id_5041F2BFDC1EABDD)) {
    _id_5041F2BFDC1EABDD = spawnStruct();
    _id_5041F2BFDC1EABDD.state = 0;
    _id_5041F2BFDC1EABDD._id_C2C6969C7FD22BF5 = _id_0B295BCB1A0224F3();
    _id_7D5B3426B48D62F0(function, _id_5041F2BFDC1EABDD);
  }

  return _id_5041F2BFDC1EABDD;
}

_id_0B295BCB1A0224F3() {
  return "match_preparation_received_" + level.quests._id_9FB489F117738FAA.size;
}

_id_BB00D006668F2D8A(_id_E95A2E8C8D9344A5) {
  return level.quests._id_9FB489F117738FAA[_id_E95A2E8C8D9344A5];
}

_id_7D5B3426B48D62F0(function, _id_5041F2BFDC1EABDD) {
  level.quests._id_9FB489F117738FAA[function] = _id_5041F2BFDC1EABDD;
}

_id_3CE5B96051C45330(function, state) {
  _id_5B071BBBCF76739B = _id_5A82971F97B0916D(function);
  _id_5B071BBBCF76739B.state = state;
}

_id_9632C09E3E228DBC(function, config) {
  level endon("game_ended");
  self endon("disconnect");
  _id_3CE5B96051C45330(function, 1);
  _id_3CE5B96051C45330(function, 2);
  _id_3FB19206A647E38F = _id_5A82971F97B0916D(function);
  level notify(_id_3FB19206A647E38F._id_C2C6969C7FD22BF5);
}

_id_8733E0C0EBC700DB(_id_E95A2E8C8D9344A5) {
  level endon("game_ended");
  self endon("disconnect");
  _id_3FB19206A647E38F = _id_5A82971F97B0916D(_id_E95A2E8C8D9344A5);
  level waittill(_id_3FB19206A647E38F._id_C2C6969C7FD22BF5);
}