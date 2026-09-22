/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1369.gsc
**************************************/

init() {
  level._id_AC0C = [];
  level._id_47DD = [];

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = spawnStruct();
    var_1._id_4DBA = 0;
    var_1._id_2900 = undefined;
    var_1._id_A902 = [];
    level._id_AC0C = common_scripts\utility::_id_0F6F(level._id_AC0C, var_1);
  }

  level thread _id_A1D1();
}

_id_A1D1() {
  for(;;) {
    level waittill("connected", var_0);
    level thread _id_A154(var_0);
  }
}

_id_7C03(var_0, var_1, var_2) {
  return _id_7C02(var_0, 1, var_2, var_1);
}

_id_7BE2(var_0, var_1, var_2) {
  return _id_7C02(var_0, 2, var_2, var_1);
}

_id_7BE3(var_0, var_1, var_2) {
  var_3 = _id_280D(2, var_1, var_0, var_2);
  level._id_47DD = common_scripts\utility::_id_0F6F(level._id_47DD, var_3);
  level thread maps\mp\_utility::_id_6F74(::_id_09E3, var_3, var_2);
  return var_3;
}

_id_280D(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_7B79 = var_1;
  var_4.type = var_0;
  var_4._id_9D65 = var_2;
  var_4._id_6642 = 0;
  var_4._id_2F74 = 0;

  if(isDefined(var_3)) {
    var_4._id_5A16 = var_3;
  }

  return var_4;
}

_id_09E3(var_0) {
  var_1 = self getentitynumber();
  var_2 = level._id_AC0C[var_1];
  var_2._id_A902 = common_scripts\utility::_id_0F6F(var_2._id_A902, var_0);
}

_id_7C02(var_0, var_1, var_2, var_3) {
  var_4 = _id_280D(var_1, var_2, var_3);
  var_0 _id_09E3(var_4);
  return var_4;
}

_id_2D8F(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = level._id_AC0C[var_2];
  var_3._id_A902 = common_scripts\utility::_id_0F93(var_3._id_A902, var_1);
}

_id_2D8E(var_0) {
  foreach(var_2 in level.players) {
    _id_2D8F(var_2, var_0);
  }

  if(isDefined(var_0._id_5A16)) {
    level notify(var_0._id_5A16);
  }
}

_id_8655(var_0, var_1) {
  var_2 = _tablelookuprownum("mp/zombieHintTable.csv", 2, var_1._id_7B79);

  if(var_2 == -1) {
    return;
  }
  var_3 = int(_tablelookupbyrow("mp/zombieHintTable.csv", var_2, 0));
  var_4 = int(_tablelookupbyrow("mp/zombieHintTable.csv", var_2, 1));
  var_5 = (var_4 << 4) + var_3;
  var_0 setclientomnvar("ui_zm_contexthint_data", var_5);
  var_1._id_6642 = 0;
}

_id_A154(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0 getentitynumber();
  var_2 = level._id_AC0C[var_1];

  for(;;) {
    if(isDefined(var_2._id_2900) && !isDefined(var_2._id_2900._id_9D65)) {
      _id_2D8F(var_0, var_2._id_2900);

      if(var_2._id_4DBA) {
        var_2._id_4DBA = 0;
        var_2._id_2900 = undefined;
        var_0 setclientomnvar("ui_zm_contexthint_data", 0);
      }

      wait 0.2;
      continue;
    }

    if(var_2._id_4DBA) {
      if(!isDefined(var_2._id_2900._id_9D65) || !var_0 istouching(var_2._id_2900._id_9D65) || var_2._id_2900._id_2F74) {
        var_2._id_4DBA = 0;
        var_2._id_2900 = undefined;
        var_0 setclientomnvar("ui_zm_contexthint_data", 0);
      } else if(var_2._id_2900._id_6642)
        _id_8655(var_0, var_2._id_2900);
    } else {
      var_3 = var_2._id_A902.size;

      for(var_1 = 0; var_1 < var_3; var_1++) {
        var_4 = var_2._id_A902[var_1];

        if(!var_4._id_2F74 && isDefined(var_4._id_9D65) && var_0 istouching(var_4._id_9D65)) {
          var_2._id_4DBA = 1;
          var_2._id_2900 = var_4;
          _id_8655(var_0, var_4);
        }
      }
    }

    wait 0.2;
  }
}