/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1360.gsc
**************************************/

assert_collectible_table_valid() {
  var_0 = _func_27A("mp/zombieS2CollectibleTable.csv");
}

_id_5543(var_0) {
  return common_scripts\utility::_id_562E(var_0._id_5543);
}

_id_24D4(var_0) {
  assert_collectible_table_valid();
  var_1 = _func_1AE("mp/zombieS2CollectibleTable.csv", var_0, 3);
  var_2 = _func_1AE("mp/zombieS2CollectibleTable.csv", var_0, 0);
  var_3 = spawnStruct();
  var_3._id_2A3C = _func_1AE("mp/zombieS2CollectibleTable.csv", var_0, 0);
  var_3.type = _func_1AE("mp/zombieS2CollectibleTable.csv", var_0, 2);
  var_3.unlocks = strtok(var_1, " ");
  var_3._id_24D1 = _func_1AE("mp/zombieS2CollectibleTable.csv", var_0, 1);
  var_3._id_5543 = 1;
  var_3._id_2A3C = int(var_2);
  return var_3;
}

_id_24D3(var_0) {
  assert_collectible_table_valid();
  var_1 = _func_1B1("mp/zombieS2CollectibleTable.csv", 1, var_0);
  return _id_24D4(var_1);
}

_id_4083() {
  assert_collectible_table_valid();
  var_0 = [];

  for(var_1 = 0; var_1 < _func_27A("mp/zombieS2CollectibleTable.csv"); var_1++) {
    var_2 = _id_24D4(var_1);
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  return var_0;
}

_id_410C(var_0) {
  var_1 = _id_4083();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!_id_415C(var_0, var_4)) {
      continue;
    }
    var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  return var_2;
}

_id_410D() {
  return common_scripts\utility::_id_46A8();
}

_id_415C(var_0, var_1) {
  return var_0 getplayerdata(_id_410D(), "hasS2ZombieCollectibles", var_1._id_2A3C);
}

_id_8470(var_0, var_1, var_2) {
  var_0 setplayerdata(_id_410D(), "hasS2ZombieCollectibles", var_1._id_2A3C, var_2);
}