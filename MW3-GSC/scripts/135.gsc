/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\135.gsc
**************************************/

_id_14FC() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();

  }
  if(!isDefined(level._id_1456._id_14FD)) {
    level._id_1456._id_14FD = spawnStruct();

  }
  _id_1558();
  level._id_1456._id_14FD._id_1458 = 0;
  level._id_1456._id_14FD._id_1459 = 0;
  level._id_1456._id_14FD._id_14FE = 0;
  level._id_1456._id_14FD._id_14FF = 0;
  var_0 = 10;
  thread _id_154D(var_0);
  thread _id_154C(var_0);
  level._id_1456._id_14FD._id_1500 = "";
  level._id_1456._id_14FD._id_1501 = "";
  level._id_1456._id_14FD._id_1502 = [];

  if(!isDefined(level._id_1456._id_1503)) {
    level._id_1456._id_1503 = [];

  }
  level._id_1456._id_14FD._id_1504 = [];
  level._id_1456._id_14FD._id_1473 = [];
  level._id_1456._id_14FD._id_1505 = [];
  level._id_1456._id_14FD._id_1506 = 0.85;
  level._id_1456._id_14FD._id_1507 = 0;
  level._id_1456._id_14FD._id_1508 = "";
  thread _id_153E();
  waittillframeend;
  thread _id_1545();
}

_id_1509(var_0) {
  _id_1556(var_0);
}

_id_150A(var_0, var_1, var_2) {
  if(!level._id_1456._id_14FD._id_14FF) {
    var_3 = 1.0;

    if(isDefined(var_2)) {
      var_3 = var_2;

    }
    level._id_1456._id_14FD._id_1506 = var_1;
    var_4 = _id_1556(var_0);

    if(isDefined(var_4)) {
      level._id_1456._id_14FD._id_150B = var_4;
      _id_153C(var_3, var_0);
    }
  }
}

_id_150C() {
  level._id_1456._id_14FD._id_14FF = 1;
}

_id_150D() {
  level._id_1456._id_14FD._id_14FF = 0;
}

_id_150E() {
  level._id_1456._id_14FD._id_1458 = 1;
  level._id_1456._id_14FD._id_1459 = 0;
}

_id_150F(var_0, var_1) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    if(var_0 != level._id_1456._id_14FD._id_1500) {
      _id_153B(0);
      _id_1535(var_0, var_1);
    }
  }
}

_id_1510(var_0) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    var_1 = _id_1556(var_0);

    if(!isDefined(var_1)) {
      return;
    }
    if(isDefined(level._id_1456._id_14FD._id_1503["zone_mix"])) {
      foreach(var_4, var_3 in level._id_1456._id_14FD._id_1503["zone_mix"]) {
        if(var_4 != "fade_time" && var_4 != "preset_name") {
          level._id_1456._id_14FD._id_1503["zone_mix"][var_4]._id_1511 = 1.0;
        }
      }
    } else {
      level._id_1456._id_14FD._id_1503["zone_mix"] = [];

    }
    level._id_1456._id_14FD._id_1503["zone_mix"]["preset_name"] = var_0;

    foreach(var_4, var_3 in var_1) {
      if(var_4 != "fade_time" && var_4 != "name") {
        level._id_1456._id_14FD._id_1503["zone_mix"][var_4] = spawnStruct();
        level._id_1456._id_14FD._id_1503["zone_mix"][var_4]._id_1511 = var_3;
        level._id_1456._id_14FD._id_1503["zone_mix"][var_4]._id_1512 = var_3;
      }
    }

    var_6 = 1.0;

    if(isDefined(var_1["fade_time"])) {
      var_6 = var_1["fade_time"];

    }
    _id_153C(var_6, "zone_mix");
  }
}

_id_1513(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;

  }
  if(isDefined(level._id_1456._id_14FD._id_1503["zone_mix"])) {
    level._id_1456._id_14FD._id_1503["zone_mix"]["CLEAR"] = 1;
    _id_153C(var_1, "zone_mix");
  }
}

_id_1514(var_0) {
  _id_153B(1, var_0);
}

_id_1515(var_0) {
  level._id_1456._id_14FD._id_1502[var_0] = 1;
}

_id_1516(var_0) {
  level._id_1456._id_14FD._id_1502[var_0] = undefined;
}

_id_1517(var_0, var_1, var_2) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    _id_1535(var_0, var_1, var_2);
  }
}

_id_1518(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_1456._id_14FD._id_1504[var_1])) {
    var_4 = _id_1538(undefined, var_0, var_2);

    if(!isDefined(var_4)) {
      return;
    }
    level._id_1456._id_14FD._id_1504[var_1] = var_4;
    _id_153C(var_3, var_0);
  }
}

_id_1519(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_1456._id_14FD._id_1504[var_2])) {
    var_5 = _id_1538(var_0, var_1, var_3);

    if(!isDefined(var_5)) {
      return;
    }
    level._id_1456._id_14FD._id_1504[var_2] = var_5;
    _id_153C(var_4, var_2);
  }
}

_id_151A(var_0, var_1, var_2) {
  if(isDefined(level._id_1456._id_14FD._id_1504[var_0])) {
    level._id_1456._id_14FD._id_1504[var_0]._id_151B = clamp(var_1, 0, 1);
    _id_153C(var_2, var_0);
  }
}

_id_151C(var_0, var_1) {
  if(isDefined(level._id_1456._id_14FD._id_1504[var_0])) {
    level._id_1456._id_14FD._id_1504[var_0]._id_151D = 1;
    _id_153C(var_1, var_0);
  }
}

_id_151E(var_0, var_1, var_2) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    if(isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
      _id_1536(var_0, var_1);
    } else {
      _id_1537(var_0, var_1);

    }
    _id_153C(var_2, var_0);
  }
}

_id_151F(var_0, var_1) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    if(isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
      level._id_1456._id_14FD._id_1503[var_0]._id_1511 = level._id_1456._id_14FD._id_1503[var_0]._id_1512;
      _id_153C(var_1, var_0);
    }
  }
}

_id_1520(var_0, var_1) {
  if(!level._id_1456._id_14FD._id_14FF && !level._id_1456._id_14FD._id_14FE) {
    if(var_0 == "default") {
      return;
    }
    if(!isDefined(level._id_1456._id_14FD._id_1502[var_0]) && isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
      level._id_1456._id_14FD._id_1503[var_0]["CLEAR"] = 1;
      _id_153C(var_1, var_0);
    }
  }
}

_id_1521() {
  return level._id_1456._id_14FD._id_1500;
}

_id_1522(var_0, var_1, var_2) {
  if(!level._id_1456._id_14FD._id_14FF) {
    if(isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
      return;
    }
    level._id_1456._id_14FD._id_1503[var_0] = [];
    var_3 = 0;
    var_4 = undefined;

    foreach(var_6 in var_1) {
      if(maps\_audio::_id_1523(var_3)) {
        var_4 = var_6;
      } else {
        if(!_id_155F(var_4)) {
          level._id_1456._id_14FD._id_1503[var_0] = undefined;
          return;
        }

        level._id_1456._id_14FD._id_1503[var_0][var_4] = spawnStruct();
        level._id_1456._id_14FD._id_1503[var_0][var_4]._id_1511 = var_6;
        level._id_1456._id_14FD._id_1503[var_0][var_4]._id_1512 = var_6;
        var_4 = undefined;
      }

      var_3++;
    }

    _id_153C(var_2, var_0);
  }
}

_id_1524(var_0, var_1, var_2) {
  if(!level._id_1456._id_14FD._id_14FF) {
    level._id_1456._id_14FD._id_1503[var_0] = [];
    var_3 = 0;
    var_4 = undefined;

    foreach(var_6 in var_1) {
      if(maps\_audio::_id_1523(var_3)) {
        var_4 = var_6;
      } else {
        level._id_1456._id_14FD._id_1503[var_0][var_4] = spawnStruct();
        level._id_1456._id_14FD._id_1503[var_0][var_4]._id_1511 = var_6;
        level._id_1456._id_14FD._id_1503[var_0][var_4]._id_1512 = var_6;
        var_4 = undefined;
      }

      var_3++;
    }

    _id_153C(var_2, var_0);
  }
}

_id_1525(var_0) {
  return isDefined(level._id_1456._id_14FD._id_1503[var_0]);
}

_id_1526(var_0, var_1) {
  if(!level._id_1456._id_14FD._id_14FF) {
    level._id_1456._id_14FD._id_1503["mm_mute"] = [];

    if(isstring(var_0)) {
      if(!isDefined(level._id_1456._id_14FD._id_1503["mm_mute"][var_0])) {
        level._id_1456._id_14FD._id_1503["mm_mute"][var_0] = spawnStruct();

      }
      level._id_1456._id_14FD._id_1503["mm_mute"][var_0]._id_1511 = 0.0;
      level._id_1456._id_14FD._id_1503["mm_mute"][var_0]._id_1512 = 1.0;
    } else {
      foreach(var_3 in var_0) {
        if(!isDefined(level._id_1456._id_14FD._id_1503["mm_mute"][var_3])) {
          level._id_1456._id_14FD._id_1503["mm_mute"][var_3] = spawnStruct();

        }
        level._id_1456._id_14FD._id_1503["mm_mute"][var_3]._id_1511 = 0.0;
        level._id_1456._id_14FD._id_1503["mm_mute"][var_3]._id_1512 = 1.0;
      }
    }

    _id_153C(var_1, "mm_mute");
  }
}

_id_1527(var_0) {
  if(isDefined(level._id_1456._id_1503["mm_mute"])) {
    level._id_1456._id_1503["mm_mute"] = undefined;
    _id_153C(var_0, "mm_mute");
  }
}

_id_1528(var_0, var_1) {
  if(!level._id_1456._id_14FD._id_14FF) {
    level._id_1456._id_14FD._id_1503["mm_solo"] = [];

    foreach(var_4, var_3 in level._id_1456._id_14FD._id_1529) {
      level._id_1456._id_14FD._id_1503["mm_solo"][var_4] = spawnStruct();
      level._id_1456._id_14FD._id_1503["mm_solo"][var_4]._id_1511 = 0.0;
      level._id_1456._id_14FD._id_1503["mm_solo"][var_4]._id_1512 = 1.0;
    }

    if(isstring(var_0)) {
      level._id_1456._id_14FD._id_1503["mm_solo"][var_0]._id_1511 = 1.0;
    } else {
      foreach(var_6 in var_0) {}
      level._id_1456._id_14FD._id_1503["mm_solo"][var_6]._id_1511 = 1.0;
    }

    _id_153C(var_1, "mm_solo");
  }
}

_id_152A(var_0) {
  if(isDefined(level._id_1456._id_14FD._id_1503["mm_solo"])) {
    level._id_1456._id_14FD._id_1503["mm_solo"] = undefined;
    _id_153C(var_0, "mm_solo");
  }
}

_id_152B() {
  return level._id_1456._id_14FD._id_152C;
}

_id_152D() {
  return level._id_1456._id_14FD._id_1503.size;
}

_id_152E() {
  return 0;
}

_id_152F(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_1456._id_14FD._id_1503) && var_0 < level._id_1456._id_14FD._id_1503.size) {
    var_2 = 0;

    foreach(var_6, var_4 in level._id_1456._id_14FD._id_1503) {
      if(var_4.size > 0) {
        if(var_2 == var_0) {
          if(var_6 == "zone_mix") {
            var_5 = level._id_1456._id_14FD._id_1503["zone_mix"]["preset_name"];
            var_6 = "zone_mix : " + var_5;
          }

          var_1 = var_6;
          break;
        }

        var_2++;
      }
    }
  }

  return var_1;
}

_id_1530(var_0) {
  var_1 = undefined;

  if(getsubstr(var_0, 0, 8) == "zone_mix") {
    var_0 = "zone_mix";

  }
  if(isDefined(level._id_1456._id_14FD._id_1503) && isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
    if(level._id_1456._id_14FD._id_1503[var_0].size > 0) {
      var_1 = level._id_1456._id_14FD._id_1503[var_0];
    }
  }

  return var_1;
}

_id_1531(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1);

  if(isDefined(level._id_1456._id_14FD._id_1503["default"])) {
    if(isDefined(level._id_1456._id_14FD._id_1503["default"][var_0])) {
      level._id_1456._id_14FD._id_1503["default"][var_0]._id_1511 = var_1;
      _id_153C(var_2, "default");
    } else {
      maps\_audio::_id_1532("Trying to set a volmod value on the default submix but the volmod doesn't exist: " + var_0);
    }
  } else {
    maps\_audio::_id_1532("Trying to set a volmod value on the default submix but \"default\" doesn't exist.");
  }
}

_id_1533(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_1456._id_14FD._id_1503["default"])) {
    if(isDefined(level._id_1456._id_14FD._id_1503["default"][var_0])) {
      var_1 = level._id_1456._id_14FD._id_1503["default"][var_0]._id_1512;
    } else {
      maps\_audio::_id_1532("Trying to set a volmod value on the default submix but the volmod doesn't exist: " + var_0);
    }
  } else {
    maps\_audio::_id_1532("Trying to set a volmod value on the default submix but \"default\" doesn't exist.");

  }
  return var_1;
}

_id_1534(var_0, var_1) {
  var_2 = _id_1533(var_0);

  if(isDefined(var_2)) {
    _id_1531(var_0, var_2, var_1);
  }
}

_id_1535(var_0, var_1, var_2) {
  _id_1537(var_0, var_2);
  level._id_1456._id_14FD._id_1501 = level._id_1456._id_14FD._id_1500;
  level._id_1456._id_14FD._id_1500 = var_0;
  _id_153C(var_1, var_0);
}

_id_1536(var_0, var_1) {
  if(isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
    foreach(var_4, var_3 in level._id_1456._id_14FD._id_1503[var_0]) {}
    level._id_1456._id_14FD._id_1503[var_0][var_4]._id_1511 = var_3._id_1512 * var_1;
  }
}

_id_1537(var_0, var_1) {
  if(var_0 == "default") {
    return;
  }
  if(!isDefined(level._id_1456._id_14FD._id_1503[var_0])) {
    var_2 = _id_1556(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = 1.0;

    if(isDefined(var_1)) {
      var_3 = var_1;
      var_3 = max(var_3, 0.0);
    }

    level._id_1456._id_14FD._id_1503[var_0] = [];

    foreach(var_6, var_5 in var_2) {
      if(var_6 != "name" && var_6 != "fade_time") {
        level._id_1456._id_14FD._id_1503[var_0][var_6] = spawnStruct();
        level._id_1456._id_14FD._id_1503[var_0][var_6]._id_1511 = var_5 * var_3;
        level._id_1456._id_14FD._id_1503[var_0][var_6]._id_1512 = var_5;
      }
    }
  }
}

_id_1538(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = clamp(var_2, 0, 1);

  }
  var_4 = spawnStruct();
  var_5 = _id_1556(var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_4._id_1539 = var_5;
  var_4._id_1539["fade_time"] = undefined;
  var_4._id_1539["name"] = undefined;

  if(isDefined(var_0)) {
    var_6 = _id_1556(var_0);

    if(!isDefined(var_6)) {
      return;
    }
    var_4._id_153A = var_6;
    var_4._id_153A["fade_time"] = undefined;
    var_4._id_153A["name"] = undefined;
  } else {
    var_4._id_153A = [];

    foreach(var_9, var_8 in var_4._id_1539) {}
    var_4._id_153A[var_9] = 1.0;
  }

  var_4._id_151B = var_3;
  return var_4;
}

_id_153B(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_0)) {
    var_2 = var_0;

  }
  foreach(var_5, var_4 in level._id_1456._id_14FD._id_1503) {
    if(var_5 != "default" && var_5 != "zone_mix" && !isDefined(level._id_1456._id_14FD._id_1502[var_5]) && var_5 != "mm_solo" && var_5 != "mm_mute") {
      level._id_1456._id_14FD._id_1503[var_5]["CLEAR"] = 1;
      level._id_1456._id_14FD._id_1505[var_5] = 1;
    }
  }

  if(var_2) {
    _id_153C(var_1, undefined);
  }
}

_id_153C(var_0, var_1) {
  level._id_1456._id_14FD._id_153D = var_0;

  if(isDefined(var_1)) {
    level._id_1456._id_14FD._id_1505[var_1] = 1;

  }
  level notify("mix_update");
}

_id_153E() {
  level waittill("mix_update");

  for(;;) {
    waittillframeend;
    var_0 = 0;

    if(isDefined(level._id_1456._id_14FD._id_153D)) {
      var_0 = level._id_1456._id_14FD._id_153D;

    }
    _id_1541(var_0);
    level waittill("mix_update");
  }
}

_id_153F() {
  var_0 = [];

  foreach(var_3, var_2 in level._id_1456._id_14FD._id_1503) {
    if(!isDefined(level._id_1456._id_14FD._id_1505[var_3])) {
      var_0[var_3] = 1;
    }
  }

  foreach(var_8, var_5 in level._id_1456._id_14FD._id_1540) {
    foreach(var_3, var_7 in var_0) {
      if(isDefined(level._id_1456._id_14FD._id_1503[var_3][var_8])) {
        level._id_1456._id_14FD._id_1540[var_8] = level._id_1456._id_14FD._id_1540[var_8] * level._id_1456._id_14FD._id_1503[var_3][var_8]._id_1511;
      }
    }
  }
}

_id_1541(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 0.0);
  }

  level._id_1456._id_14FD._id_1540 = undefined;
  _id_1544(0);
  _id_153F();
  var_2 = 0;

  foreach(var_5, var_4 in level._id_1456._id_14FD._id_1540) {
    if(var_5 != "voiceover_critical" && var_5 != "fullvolume") {
      var_4 = var_4 * level._id_1456._id_14FD._id_1506;

    }
    if(var_4 != level._id_1456._id_14FD._id_1529[var_5]._id_1542) {
      var_2 = 1;
      level._id_1456._id_14FD._id_1529[var_5]._id_1542 = var_4;
      level._id_1456._id_14FD._id_1529[var_5]._id_1543 = var_1;
      _id_1547(var_5, var_4, var_1);
    }
  }

  level._id_1456._id_14FD._id_1505 = [];

  if(var_2) {
    level notify("aud_new_volmod_set");
  }
}

_id_1544(var_0) {
  level._id_1456._id_14FD._id_1540 = [];
  var_1 = [];

  foreach(var_16, var_3 in level._id_1456._id_14FD._id_1505) {
    if(isDefined(level._id_1456._id_14FD._id_1503[var_16])) {
      var_4 = level._id_1456._id_14FD._id_1503[var_16];
      var_4["name"] = undefined;
      var_4["fade_time"] = undefined;
      var_4["preset_name"] = undefined;
      var_5 = 0;

      if(isDefined(var_4["CLEAR"])) {
        var_5 = 1;

      }
      var_4["CLEAR"] = undefined;

      foreach(var_8, var_7 in var_4) {
        if(isDefined(level._id_1456._id_14FD._id_1540[var_8]) && !var_5) {
          level._id_1456._id_14FD._id_1540[var_8] = level._id_1456._id_14FD._id_1540[var_8] * var_7._id_1511;
          continue;
        }

        if(var_5 && !isDefined(level._id_1456._id_14FD._id_1540[var_8])) {
          level._id_1456._id_14FD._id_1540[var_8] = 1.0;
          continue;
        }

        if(!var_5) {
          level._id_1456._id_14FD._id_1540[var_8] = var_7._id_1511;
        }
      }

      if(var_5) {
        level._id_1456._id_14FD._id_1503[var_16] = undefined;

      }
      continue;
    }

    if(isDefined(level._id_1456._id_14FD._id_1504[var_16])) {
      var_9 = level._id_1456._id_14FD._id_1504[var_16];
      var_5 = 0;

      if(isDefined(var_9._id_151D)) {
        var_5 = 1;

      }
      foreach(var_8, var_11 in var_9._id_153A) {
        if(!isDefined(var_1[var_8])) {
          var_1[var_8] = 1.0;

        }
        if(!var_5) {
          var_12 = var_9._id_1539[var_8];
          var_13 = var_9._id_153A[var_8];
          var_14 = var_9._id_151B;
          var_15 = var_14 * (var_12 - var_13) + var_13;
          var_1[var_8] = var_1[var_8] * var_15;
        }
      }

      if(var_5) {
        level._id_1456._id_14FD._id_1504[var_16] = undefined;
      }
    }
  }

  foreach(var_18, var_11 in var_1) {
    if(isDefined(level._id_1456._id_14FD._id_1540[var_18])) {
      level._id_1456._id_14FD._id_1540[var_18] = level._id_1456._id_14FD._id_1540[var_18] * var_11;
      continue;
    }

    level._id_1456._id_14FD._id_1540[var_18] = var_11;
  }
}

_id_1545() {
  var_0 = undefined;
  var_1 = undefined;
}

_id_1546(var_0) {
  if(level._id_1456._id_14FD._id_14FF) {
    while(!isDefined(level.player)) {
      wait 0.05;

    }
    _id_1535(var_0);
  }
}

_id_1547(var_0, var_1, var_2) {
  if(!isDefined(level._id_1456._id_14FD._id_1548)) {
    level._id_1456._id_14FD._id_1548 = [];
    level._id_1456._id_14FD._id_1549 = 0;
  }

  var_3 = 0;

  foreach(var_6, var_5 in level._id_1456._id_14FD._id_1548) {
    if(var_5["volmod"] == var_0) {
      var_3 = 1;
      level._id_1456._id_14FD._id_1548[var_6]["volume"] = var_1;
      level._id_1456._id_14FD._id_1548[var_6]["fade_time"] = var_2;
      break;
    }
  }

  if(!var_3) {
    var_7 = [];
    var_7["volmod"] = var_0;
    var_7["volume"] = var_1;
    var_7["fade_time"] = var_2;
    level._id_1456._id_14FD._id_1548[level._id_1456._id_14FD._id_1549] = var_7;
    level._id_1456._id_14FD._id_1549++;
  }
}

_id_154A(var_0, var_1, var_2) {
  if(!isDefined(level._id_1456._id_14FD._id_154B)) {
    level._id_1456._id_14FD._id_154B = [];
    level._id_1456._id_14FD.index = 0;
  }

  var_3 = 0;

  foreach(var_6, var_5 in level._id_1456._id_14FD._id_154B) {
    if(var_5["channel"] == var_0) {
      var_3 = 1;
      level._id_1456._id_14FD._id_154B[var_6]["volume"] = var_1;
      level._id_1456._id_14FD._id_154B[var_6]["fade_time"] = var_2;
      break;
    }
  }

  if(!var_3) {
    var_7 = [];
    var_7["channel"] = var_0;
    var_7["volume"] = var_1;
    var_7["fade_time"] = var_2;
    level._id_1456._id_14FD._id_154B[level._id_1456._id_14FD.index] = var_7;
    level._id_1456._id_14FD.index++;
  }
}

_id_154C(var_0) {
  if(!isDefined(level._id_1456._id_14FD._id_1548)) {
    level._id_1456._id_14FD._id_1548 = [];
    level._id_1456._id_14FD._id_1549 = 0;
  }

  var_1 = 5;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 1);
  }

  for(;;) {
    level waittill("aud_new_volmod_set");

    while(level._id_1456._id_14FD._id_1548.size > 0) {
      var_2 = 0;
      var_3 = [];

      foreach(var_10, var_5 in level._id_1456._id_14FD._id_1548) {
        if(var_2 < var_1) {
          var_2++;
          var_3[var_3.size] = var_10;
          var_6 = level._id_1456._id_14FD._id_1548[var_10];
          var_7 = var_6["volmod"];
          var_8 = var_6["volume"];
          var_9 = var_6["fade_time"];
          var_8 = clamp(var_8, 0.0, 1.0);
          level.player setvolmod(var_7, var_8, var_9);
          continue;
        }

        break;
      }

      for(var_11 = 0; var_11 < var_3.size; var_11++) {
        var_12 = var_3[var_11];
        level._id_1456._id_14FD._id_1548[var_12] = undefined;
      }

      wait 0.05;
    }
  }
}

_id_154D(var_0) {
  if(!isDefined(level._id_1456._id_14FD._id_154B)) {
    level._id_1456._id_14FD._id_154B = [];
    level._id_1456._id_14FD.index = 0;
  }

  var_1 = 5;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 1);
  }

  for(;;) {
    level waittill("aud_new_mix_set");

    while(level._id_1456._id_14FD._id_154B.size > 0) {
      var_2 = 0;
      var_3 = [];

      foreach(var_10, var_5 in level._id_1456._id_14FD._id_154B) {
        if(var_2 < var_1) {
          var_2++;
          var_3[var_3.size] = var_10;
          var_6 = level._id_1456._id_14FD._id_154B[var_10];
          var_7 = var_6["channel"];
          var_8 = var_6["volume"];
          var_9 = var_6["fade_time"];
          var_8 = clamp(var_8, 0.0, 1.0);
          level.player setchannelvolume(var_7, var_8, var_9);
          continue;
        }

        break;
      }

      for(var_11 = 0; var_11 < var_3.size; var_11++) {
        var_12 = var_3[var_11];
        level._id_1456._id_14FD._id_154B[var_12] = undefined;
      }

      wait 0.05;
    }
  }
}

_id_154E(var_0, var_1) {
  var_2 = [];
  var_3 = maps\_audio::_id_154F();
  var_4 = "soundtables/common_mix.csv";

  if(!isDefined(level._id_1456._id_14FD._id_1473)) {
    level._id_1456._id_14FD._id_1473 = [];

  }
  if(isDefined(level._id_1456._id_14FD._id_1473[var_0])) {
    var_2 = level._id_1456._id_14FD._id_1473[var_0];
  } else {
    if(var_1) {
      var_2 = _id_1550(var_3, var_0, 0);

    }
    if(!isDefined(var_2) || var_2.size == 0) {
      var_2 = _id_1550(var_4, var_0, 1);

    }
    if(!isDefined(var_2) || var_2.size == 0) {
      return;
    }
    level._id_1456._id_14FD._id_1473[var_0] = var_2;
  }

  return var_2;
}

_id_1550(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = "";
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = undefined;
  var_9 = [];

  if(!isDefined(level._id_1456._id_14FD._id_1551)) {
    level._id_1456._id_14FD._id_1551 = [];

  }
  if(!isDefined(level._id_1456._id_14FD._id_1551[var_0])) {
    level._id_1456._id_14FD._id_1551[var_0] = [];

    for(var_10 = 1; var_10 < var_3; var_10++) {
      var_11 = tablelookupbyrow(var_0, 0, var_10);
      level._id_1456._id_14FD._id_1551[var_0][var_11] = var_10;
    }
  }

  var_12 = maps\_audio::_id_1552("mix", var_1, var_2);

  if(var_12 != -1) {
    var_5 = var_12;
  } else if(var_2 && maps\_audio::_id_1553() || !var_2 && maps\_audio::_id_1554()) {
    return var_9;

  }
  for(var_13 = 0; var_4 != "EOF" && var_7 < 10; var_5++) {
    var_4 = tablelookupbyrow(var_0, var_5, 0);

    if(var_4 != "") {
      var_7 = 0;

    }
    while(var_4 == var_1) {
      var_6 = 1;

      if(!isDefined(var_8)) {
        var_14 = level._id_1456._id_14FD._id_1551[var_0]["fade_time"];
        var_8 = tablelookupbyrow(var_0, var_5, var_14);

        if(!isDefined(var_8) || isDefined(var_8) && var_8 == "") {
          var_8 = 1.0;
        }
      }

      var_15 = level._id_1456._id_14FD._id_1551[var_0]["channels"];
      var_16 = level._id_1456._id_14FD._id_1551[var_0]["value"];
      var_17 = tablelookupbyrow(var_0, var_5, var_15);
      var_18 = tablelookupbyrow(var_0, var_5, var_16);

      if(var_17 == "set_all" || var_17 == "setall") {
        if(float(var_18) < 1) {
          var_9 = _id_155C(float(var_18));
        }
      } else {
        if(!isDefined(level._id_1456._id_14FD._id_1555[var_17])) {
          maps\_audio::_id_1532("In soundtable " + var_0 + ", " + var_1 + " uses a volmod group name that doesn't exist in the volmodgroups.csv file.");
          return;
        }

        var_9[var_17] = float(var_18);
      }

      var_5++;
      var_4 = tablelookupbyrow(var_0, var_5, 0);
      var_13++;
    }

    var_7++;

    if(var_6) {
      break;
    }
  }

  if(var_6 && isDefined(var_8)) {
    var_9["fade_time"] = float(var_8);

  }
  return var_9;
}

_id_1556(var_0) {
  if(!isDefined(level._id_1456._id_14FD._id_1473)) {
    level._id_1456._id_14FD._id_1473 = [];

  }
  var_1 = [];

  if(isDefined(level._id_1456._id_14FD._id_1473[var_0])) {
    var_1 = level._id_1456._id_14FD._id_1473[var_0];
  } else {
    var_1 = undefined;

    if(level._id_1456._id_14FD._id_1458) {
      var_1 = _id_154E(var_0, 1);
    } else {
      var_1 = _id_154E(var_0, 0);

      if(!isDefined(var_1) || var_1.size == 0) {
        var_1 = maps\_audio::_id_1557(var_0, var_1);
      }
    }

    if(!isDefined(var_1) || var_1.size == 0) {
      return;
    }
    var_1["name"] = var_0;

    if(!isDefined(var_1["fade_time"])) {
      var_1["fade_time"] = 1.0;

    }
    level._id_1456._id_14FD._id_1473[var_0] = var_1;
  }

  return var_1;
}

_id_1558() {
  if(!isDefined(level._id_1456._id_14FD._id_1555)) {
    _id_155D();

  }
  level._id_1456._id_14FD._id_1529 = [];

  foreach(var_2, var_1 in level._id_1456._id_14FD._id_1555) {
    level._id_1456._id_14FD._id_1529[var_2] = spawnStruct();
    level._id_1456._id_14FD._id_1529[var_2]._id_1542 = var_1;
    level._id_1456._id_14FD._id_1529[var_2]._id_1543 = 0.0;
  }

  _id_1559();
}

_id_1559() {
  if(!isDefined(level._id_1456._id_14FD._id_152C)) {
    var_0 = [];
    var_0["physics"] = 1;
    var_0["ambdist1"] = 1;
    var_0["ambdist2"] = 1;
    var_0["auto"] = 1;
    var_0["auto2"] = 1;
    var_0["auto2d"] = 1;
    var_0["autodog"] = 1;
    var_0["explosiondist1"] = 1;
    var_0["explosiondist2"] = 1;
    var_0["explosiveimpact"] = 1;
    var_0["element"] = 1;
    var_0["element_int"] = 1;
    var_0["element_ext"] = 1;
    var_0["bulletimpact"] = 1;
    var_0["bulletflesh1"] = 1;
    var_0["bulletflesh2"] = 1;
    var_0["bulletwhizby"] = 1;
    var_0["vehicle"] = 1;
    var_0["vehiclelimited"] = 1;
    var_0["menu"] = 1;
    var_0["body"] = 1;
    var_0["body2d"] = 1;
    var_0["reload"] = 1;
    var_0["reload2d"] = 1;
    var_0["item"] = 1;
    var_0["explosion1"] = 1;
    var_0["explosion2"] = 1;
    var_0["explosion3"] = 1;
    var_0["explosion4"] = 1;
    var_0["explosion5"] = 1;
    var_0["effects1"] = 1;
    var_0["effects2"] = 1;
    var_0["effects3"] = 1;
    var_0["effects2d1"] = 1;
    var_0["effects2d2"] = 1;
    var_0["vehicle2d"] = 1;
    var_0["weapon_dist"] = 1;
    var_0["weapon_mid"] = 1;
    var_0["weapon"] = 1;
    var_0["weapon2d"] = 1;
    var_0["nonshock"] = 1;
    var_0["nonshock2"] = 1;
    var_0["voice"] = 1;
    var_0["local"] = 1;
    var_0["local2"] = 1;
    var_0["local3"] = 1;
    var_0["ambient"] = 1;
    var_0["hurt"] = 1;
    var_0["player1"] = 1;
    var_0["player2"] = 1;
    var_0["music"] = 1;
    var_0["musicnopause"] = 1;
    var_0["grondo3d"] = 1;
    var_0["grondo2d"] = 1;
    var_0["mission"] = 1;
    var_0["critical"] = 1;
    var_0["announcer"] = 1;
    var_0["shellshock"] = 1;
    level._id_1456._id_14FD._id_152C = var_0;
  }
}

_id_155A() {
  return level._id_1456._id_14FD._id_155B;
}

_id_155C(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in level._id_1456._id_14FD._id_1555) {
    if(var_4 != "hud" && var_4 != "interface" && var_4 != "interface_music") {
      var_1[var_4] = var_0;
    }
  }

  return var_1;
}

_id_155D() {
  var_0 = "soundaliases/volumemodgroups.svmod";
  level._id_1456._id_14FD._id_1555 = [];
  var_1 = 10;
  var_2 = 0;
  var_3 = 0;

  while(var_2 < var_1) {
    var_4 = tablelookupbyrow(var_0, var_3, 0);

    if(var_4 == "") {
      var_2++;
      continue;
    }

    var_5 = getsubstr(var_4, 0, 0);

    if(var_5 == "#") {
      continue;
    }
    var_6 = tablelookupbyrow(var_0, var_3, 1);
    level._id_1456._id_14FD._id_1555[var_4] = float(var_6);
    var_3++;
  }

  if(!isDefined(level._id_1456._id_1503)) {
    level._id_1456._id_1503 = [];

  }
  level._id_1456._id_14FD._id_1503["default"] = [];

  foreach(var_4, var_8 in level._id_1456._id_14FD._id_1555) {
    level._id_1456._id_14FD._id_1503["default"][var_4] = spawnStruct();
    level._id_1456._id_14FD._id_1503["default"][var_4]._id_1511 = var_8;
    level._id_1456._id_14FD._id_1503["default"][var_4]._id_1512 = var_8;
  }
}

_id_155E(var_0) {
  return isDefined(level._id_1456._id_14FD._id_152C[var_0]);
}

_id_155F(var_0) {
  return isDefined(level._id_1456._id_14FD._id_1555[var_0]);
}