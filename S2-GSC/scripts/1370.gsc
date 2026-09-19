/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1370.gsc
**************************************/

init() {
  level._id_AC80 = spawnStruct();
  level._id_AC80._id_9054 = ["zombie_spawner", "zombie_sky_spawner"];
  level._id_AC80._id_ACB3 = [];
  level._id_AC80._id_2914 = [];
  level._id_AC80._id_290A = [];
  level._id_AC80._id_9065 = ::_id_1E4E;
  level._id_AC80._id_8FE7 = 0;
  level._id_1F1D = ::_id_1F66;
  level._id_4200 = ::_id_4562;
  level._id_43F2 = ::_id_474A;
  level._id_8C96 = undefined;
  level._id_43F4 = ::_id_474B;
  level._id_38D1 = undefined;
  level._id_7D20 = undefined;
  level._id_38D2 = [];
  level._id_7D21 = [];
}

_id_6B3F() {
  if(!isDefined(level._id_AC80)) {
    return;
  }
  foreach(var_1 in level._id_AC80._id_ACB3) {
    var_2 = [];
    var_1._id_37C3 = [];
    var_1.players = [];
    var_1.zombies = [];
    var_1 _id_ACA1();

    for(var_3 = 0; var_3 < var_1._id_ABFE.size; var_3++) {
      var_4 = var_1._id_ABFE[var_3];

      if(_id_0547::_id_AC0F(var_4, var_1._id_AC8A + " spawner", undefined, var_1._id_AC8A))
        var_2[var_2.size] = var_4;
    }

    var_1._id_ABFE = var_2;
  }
}

_id_3155(var_0) {
  var_1 = isDefined(level._id_AC80._id_ACB3[var_0]);
  return var_1;
}

_id_0F4F(var_0) {
  foreach(var_2 in level._id_AC80._id_ACB3) {
    if(common_scripts\utility::_id_562E(var_0)) {
      if(isDefined(level.zmb_registered_quest_zones) && common_scripts\utility::_id_0F79(level.zmb_registered_quest_zones, var_2._id_AC8A))
        continue;
    }

    if(!var_2._id_556E)
      return 0;
  }

  return 1;
}

_id_586A(var_0) {
  return level._id_AC80._id_ACB3[var_0]._id_556E;
}

_id_1F66(var_0) {
  return level._id_AC80._id_ACB3[var_0]._id_5614;
}

_id_5780(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1 && !_id_586A(var_0))
    return 0;

  foreach(var_3 in level.players) {
    if(_id_7413(var_3, var_0, var_1))
      return 1;
  }

  return 0;
}

_id_A100() {
  level endon("game_ended");
  level notify("updating_connection_distances");
  level endon("updating_connection_distances");
  level._id_AC80._id_2585 = [];

  foreach(var_1 in level._id_AC80._id_ACB3) {
    foreach(var_3 in level._id_AC80._id_ACB3) {
      if(var_1._id_AC8A == var_3._id_AC8A) {
        continue;
      }
      if(isDefined(level._id_AC80._id_2585[var_1._id_AC8A]) && isDefined(level._id_AC80._id_2585[var_1._id_AC8A][var_3._id_AC8A])) {
        continue;
      }
      _id_474A(var_1._id_AC8A, var_3._id_AC8A);
      waitframe();
    }
  }

  if(isDefined(level._id_AC88)) {
    level._id_AC80._id_511B = [];

    foreach(var_1 in level._id_AC80._id_ACB3) {
      foreach(var_3 in level._id_AC80._id_ACB3) {
        if(var_1._id_AC8A == var_3._id_AC8A) {
          continue;
        }
        if(isDefined(level._id_AC80._id_511B[var_1._id_AC8A]) && isDefined(level._id_AC80._id_511B[var_1._id_AC8A][var_3._id_AC8A])) {
          continue;
        }
        _id_474B(var_1._id_AC8A, var_3._id_AC8A);
        waitframe();
      }
    }
  }
}

_id_7BDC(var_0, var_1, var_2) {
  level._id_AC80._id_2585[var_0][var_1] = var_2;
  level._id_AC80._id_2585[var_1][var_0] = var_2;
}

_id_474A(var_0, var_1) {
  if(var_0 == var_1)
    return 0;

  if(!isDefined(level._id_AC80._id_2585))
    return -1;

  if(isDefined(level._id_AC80._id_2585[var_0]) && isDefined(level._id_AC80._id_2585[var_0][var_1]))
    return level._id_AC80._id_2585[var_0][var_1];

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level._id_AC80._id_ACB3[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = common_scripts\utility::_id_0F9A(var_2, 0);
    var_5[var_3._id_AC8A] = 1;

    foreach(var_7 in var_3._id_0A01) {
      if(isDefined(var_5[var_7._id_AC8A])) {
        continue;
      }
      if(var_7._id_554C) {
        var_8 = var_4 + 1;

        if(var_7._id_AC8A == var_1) {
          _id_7BDC(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0)
          var_9 = 0;

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0)
            var_9 = var_11;

          if(var_2[var_11]["zone"] == var_7._id_AC8A) {
            if(var_12)
              var_10 = var_11;

            break;
          }
        }

        if(var_10 >= 0)
          var_2 = common_scripts\utility::_id_0F9A(var_2, var_10);

        if(var_11 == var_2.size && var_9 < 0)
          var_9 = var_2.size;

        if(var_9 >= 0) {
          var_13["zone"] = var_7._id_AC8A;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::_id_0F86(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

_id_7BE7(var_0, var_1, var_2) {
  level._id_AC80._id_511B[var_0][var_1] = var_2;
  level._id_AC80._id_511B[var_1][var_0] = var_2;
}

_id_474B(var_0, var_1) {
  if(var_0 == var_1)
    return 0;

  if(!isDefined(level._id_AC80._id_2585))
    return -1;

  if(isDefined(level._id_AC80._id_511B[var_0]) && isDefined(level._id_AC80._id_511B[var_0][var_1]))
    return level._id_AC80._id_511B[var_0][var_1];

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level._id_AC80._id_ACB3[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = common_scripts\utility::_id_0F9A(var_2, 0);
    var_5[var_3._id_AC8A] = 1;

    foreach(var_7 in var_3._id_0A01) {
      if(isDefined(var_5[var_7._id_AC8A])) {
        continue;
      }
      if([[level._id_AC88]](var_7._id_AC8A)) {
        continue;
      }
      if(var_7._id_554C) {
        var_8 = var_4 + 1;

        if(var_7._id_AC8A == var_1) {
          _id_7BE7(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0)
          var_9 = 0;

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0)
            var_9 = var_11;

          if(var_2[var_11]["zone"] == var_7._id_AC8A) {
            if(var_12)
              var_10 = var_11;

            break;
          }
        }

        if(var_10 >= 0)
          var_2 = common_scripts\utility::_id_0F9A(var_2, var_10);

        if(var_11 == var_2.size && var_9 < 0)
          var_9 = var_2.size;

        if(var_9 >= 0) {
          var_13["zone"] = var_7._id_AC8A;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::_id_0F86(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

_id_462D() {
  if(self.sessionstate == "spectator" || self.sessionstate == "intermission")
    return undefined;

  updatecurrentzones();
  var_0 = getarraykeys(self.currentzones);

  if(var_0.size > 0)
    return var_0[0];

  return undefined;
}

getagentzone() {
  updatecurrentzones();
  var_0 = getarraykeys(self.currentzones);

  if(var_0.size > 0)
    return var_0[0];

  return undefined;
}

_id_4482(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = _id_4483(var_0);
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = var_4._id_AC8A;

  return var_2;
}

_id_4483(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    var_4 updatecurrentzones();

    foreach(var_7, var_6 in var_4.currentzones) {
      if(!isDefined(var_1[var_7])) {
        if(!var_0 || _id_586A(var_7)) {
          var_1[var_7] = 1;
          var_2[var_2.size] = level._id_AC80._id_ACB3[var_7];
          continue;
        }

        var_1[var_7] = 0;
      }
    }
  }

  return var_2;
}

_id_5860(var_0) {
  var_0 updatecurrentzones();

  if(!isDefined(var_0.currentzones))
    return 0;

  return var_0.currentzones.size > 0;
}

_id_5861(var_0) {
  var_0 updatecurrentzones();

  if(!isDefined(var_0.currentzones))
    return 0;

  foreach(var_2 in var_0.currentzones) {
    if(_id_586A(var_2))
      return 1;
  }

  return 0;
}

getzoneclosesttopoint(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = undefined;

  foreach(var_4 in level._id_AC80._id_ACB3) {
    if(var_1 && !_id_586A(var_4._id_AC8A)) {
      continue;
    }
    foreach(var_6 in var_4._id_A615) {
      if(_ispointinvolume(var_0, var_6))
        return var_4._id_AC8A;
    }

    if(!isDefined(var_2)) {
      var_2 = var_4;
      continue;
    }

    if(distance(var_0, var_4._id_74DC) < distance(var_0, var_2._id_74DC))
      var_2 = var_4;
  }

  return var_2._id_AC8A;
}

_id_5771(var_0) {
  foreach(var_2 in level._id_AC80._id_ACB3) {
    foreach(var_4 in var_2._id_A615) {
      if(_ispointinvolume(var_0.origin, var_4))
        return 1;

      if(_ispointinvolume(var_0.origin + (0, 0, 20), var_4))
        return 1;
    }
  }

  return 0;
}

_id_5772(var_0) {
  foreach(var_2 in level._id_AC80._id_ACB3) {
    if(!_id_586A(var_2._id_AC8A)) {
      continue;
    }
    foreach(var_4 in var_2._id_A615) {
      if(_ispointinvolume(var_0.origin, var_4))
        return 1;

      if(_ispointinvolume(var_0.origin + (0, 0, 20), var_4))
        return 1;
    }
  }

  return 0;
}

_id_578A(var_0, var_1) {
  var_2 = _id_578B(var_0, var_1);
  return isDefined(var_2);
}

_id_578B(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level._id_AC80._id_ACB3) {
    if(var_1 && !_id_586A(var_3._id_AC8A)) {
      continue;
    }
    foreach(var_5 in var_3._id_A615) {
      if(_ispointinvolume(var_0, var_5))
        return var_3._id_AC8A;
    }
  }

  return;
}

_id_4562(var_0) {
  if(isDefined(level._id_AC80)) {
    foreach(var_2 in level._id_AC80._id_ACB3) {
      foreach(var_4 in var_2._id_A615) {
        if(_ispointinvolume(var_0, var_4))
          return var_2._id_AC8A;

        if(_ispointinvolume(var_0 + (0, 0, 20), var_4))
          return var_2._id_AC8A;
      }
    }
  }

  return undefined;
}

_id_0F14(var_0) {
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  if(var_1.size == 0)
    return 0;

  var_2 = level._id_AC80._id_ACB3[var_0];

  foreach(var_4 in var_1)
  var_4 updatecurrentzones();

  var_6 = var_2 zombies_in_zone_internal();
  return var_6.size > 0;
}

zombies_in_zone_internal() {
  var_0 = self;
  var_1 = [];

  foreach(var_4, var_3 in var_0.zombies) {
    if(isDefined(var_3) && isalive(var_3))
      var_1[var_1.size] = var_3;
  }

  var_0.zombies = var_1;
  return var_1;
}

players_in_zone_internal() {
  var_0 = self;
  var_1 = [];

  foreach(var_4, var_3 in var_0.players) {
    if(isDefined(var_3) && isPlayer(var_3) && var_3.sessionstate != "spectator")
      var_1[var_1.size] = var_3;
  }

  var_0.players = var_1;
  return var_1;
}

updatecurrentzones() {
  var_0 = self;

  if(isDefined(var_0.lastzoneupdateorigin)) {
    if(var_0.origin == var_0.lastzoneupdateorigin)
      return;
  }

  var_0.lastzoneupdateorigin = var_0.origin;
  var_1 = var_0.currentzones;
  var_0.currentzones = [];
  var_2 = isPlayer(var_0) && var_0.sessionstate == "spectator";
  var_3 = _isagent(var_0) && !isalive(var_0);

  if(!var_2 && !var_3) {
    foreach(var_9, var_5 in level._id_AC80._id_ACB3) {
      foreach(var_7 in var_5._id_A615) {
        if(var_0 istouching(var_7)) {
          var_0.currentzones[var_9] = 1;
          break;
        }
      }
    }
  }

  if(isDefined(var_1)) {
    var_10 = getarraykeys(var_1);

    foreach(var_9 in var_10) {
      if(!isDefined(var_0.currentzones[var_9]))
        var_0 thread onentityleftzone(var_9);
    }
  } else
    var_1 = [];

  var_13 = getarraykeys(var_0.currentzones);

  foreach(var_9 in var_13) {
    if(!isDefined(var_1) || !isDefined(var_1[var_9]))
      var_0 thread onentityfoundinzone(var_9);
  }
}

onentityfoundinzone(var_0) {
  var_1 = self;
  var_2 = level._id_AC80._id_ACB3[var_0];
  var_3 = var_1 getentitynumber();
  var_2._id_37C3[var_3] = var_1;

  if(isPlayer(var_1))
    var_2.players[var_3] = var_1;

  if(isDefined(var_1._id_000A) && var_1._id_000A != level._id_746E)
    var_2.zombies[var_3] = var_1;
}

onentityleftzone(var_0) {
  var_1 = self;
  var_2 = level._id_AC80._id_ACB3[var_0];
  var_3 = var_1 getentitynumber();
  var_2._id_37C3[var_3] = undefined;

  if(isPlayer(var_1))
    var_2.players[var_3] = undefined;

  if(isDefined(var_1._id_000A) && var_1._id_000A != level._id_746E)
    var_2.zombies[var_3] = undefined;
}

_id_45BF(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1 && !_id_586A(var_0))
    return 0;

  var_2 = level._id_AC80._id_ACB3[var_0];
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(_id_7413(var_5, var_0, var_1))
      var_3++;
  }

  return var_3;
}

_id_4626(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = [];

  if(var_2 && !_id_586A(var_0))
    return var_3;

  var_4 = level._id_AC80._id_ACB3[var_0];
  var_5 = [var_0];

  if(var_1) {
    foreach(var_7 in var_4._id_0A01) {
      if(!var_2 || _id_586A(var_7._id_AC8A))
        var_5[var_0.size] = var_7._id_AC8A;
    }
  }

  foreach(var_10 in level.players) {
    foreach(var_0 in var_5) {
      if(_id_7413(var_10, var_0, var_2))
        var_3[var_3.size] = var_10;
    }
  }

  return var_3;
}

_id_7413(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(var_0.sessionstate == "spectator")
    return 0;

  var_0 updatecurrentzones();

  if(var_2 && !_id_586A(var_1))
    return 0;

  return common_scripts\utility::_id_562E(var_0.currentzones[var_1]);
}

_id_AC29(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(var_2 && !_id_586A(var_1))
    return 0;

  var_0 updatecurrentzones();
  return common_scripts\utility::_id_562E(var_0.currentzones[var_1]);
}

_id_45C3(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1 && !_id_586A(var_0))
    return 0;

  var_2 = _id_0547::_id_408F();

  if(var_2.size == 0)
    return 0;

  var_3 = level._id_AC80._id_ACB3[var_0];

  foreach(var_5 in var_2)
  var_5 updatecurrentzones();

  return var_3.zombies.size;
}

_id_530A(var_0, var_1, var_2) {
  if(isDefined(level._id_AC80._id_ACB3[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = spawnStruct();
  var_3._id_0A01 = [];
  var_3._id_55CA = 0;
  var_3._id_556E = var_1;
  var_3._id_5614 = var_1;
  var_3._id_552B = 0;
  var_3._id_AC8A = var_0;

  if(isDefined(var_2))
    var_3._id_5614 = var_2;

  var_3._id_A615 = [];
  var_4 = getEntArray(var_0, "targetname");

  foreach(var_6 in var_4) {
    if(var_6.classname == "info_volume")
      var_3._id_A615[var_3._id_A615.size] = var_6;
  }

  common_scripts\utility::flag_init(var_3._id_AC8A);

  if(var_1)
    common_scripts\utility::flag_set(var_3._id_AC8A);

  level._id_AC80._id_ACB3[var_0] = var_3;
  var_3._id_75FF = _id_4634(var_0);
  var_8 = _id_4694(var_0);
  var_3._id_ABFE = _id_3ACB(var_8, "zombie_spawner");

  if(!isDefined(level._id_AC4F))
    level._id_AC4F = [];

  var_9 = _id_3ACB(var_8, "zombie_sky_spawner");
  var_3._id_ABFE = common_scripts\utility::_id_0F73(var_3._id_ABFE, var_9);
  var_3._id_9050 = [];

  foreach(var_11 in var_3._id_ABFE) {
    _id_5374(var_11);

    if(isDefined(var_11.getnegotiationnextnode))
      var_3._id_9050[var_11.getnegotiationnextnode] = 1;
  }

  level._id_AC4F = common_scripts\utility::_id_0F73(level._id_AC4F, var_3._id_ABFE);

  if(_id_0547::_id_2306()) {
    var_3._id_2300 = _id_3ACB(var_8, "civilian_extract");
    var_3._id_2302 = _id_3ACB(var_8, "civilian_spawner");

    if(!isDefined(level._id_AC4E))
      level._id_AC4E = [];

    level._id_AC4E = common_scripts\utility::_id_0F73(level._id_AC4E, var_3._id_2302);
  }
}

_id_5374(var_0) {
  switch (var_0._id_0165) {
    case "zombie_sky_spawner":
      var_0._id_8C95 = 1;
    case "zombie_spawner":
      if(isDefined(var_0.getnegotiationnextnode) && !common_scripts\utility::_id_3C83(var_0.getnegotiationnextnode))
        common_scripts\utility::flag_init(var_0.getnegotiationnextnode);

      break;
  }
}

_id_4634(var_0) {
  var_1 = common_scripts\utility::_id_46B7("power_switch", "targetname");

  foreach(var_3 in var_1) {
    if(_id_57F4(var_3, level._id_AC80._id_ACB3[var_0]._id_A615))
      return var_3;
  }

  return undefined;
}

_id_57F4(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(_ispointinvolume(var_0.origin, var_3))
      return 1;
  }

  return 0;
}

_id_4694(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_AC80._id_9054) {
    foreach(var_5 in getEntArray(var_3, "script_noteworthy"))
    var_1[var_1.size] = var_5;
  }

  var_8 = [];

  foreach(var_10 in level._id_AC80._id_ACB3[var_0]._id_A615) {
    if(isDefined(var_10.target)) {
      var_11 = common_scripts\utility::_id_46B7(var_10.target, "targetname");

      foreach(var_13 in var_11) {
        if(!common_scripts\utility::_id_0F79(var_8, var_13)) {
          var_13._id_AC8A = var_0;
          var_8[var_8.size] = var_13;
        }
      }
    }

    foreach(var_5 in var_1) {
      if(_ispointinvolume(var_5.origin, var_10) && !common_scripts\utility::_id_0F79(var_8, var_5)) {
        var_5._id_AC8A = var_0;
        var_8[var_8.size] = var_5;
      }
    }
  }

  return var_8;
}

_id_3ACB(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    if(var_4._id_0165 != var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0993(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(level._id_3C77[var_2]))
    common_scripts\utility::flag_init(var_2);

  _id_5FBF(var_0, var_1, var_2, 0);
  _id_5FBF(var_1, var_0, var_2, var_3);
}

_id_5FBF(var_0, var_1, var_2, var_3) {
  var_4 = level._id_AC80._id_ACB3[var_0];

  if(!isDefined(var_4._id_0A01[var_1])) {
    var_5 = spawnStruct();
    var_5._id_AC8A = var_1;
    var_5._id_3CC5[0] = var_2;
    var_5._id_554C = 0;
    var_5._id_6B2C = var_3;
    var_4._id_0A01[var_1] = var_5;
  } else {
    var_6 = var_4._id_0A01[var_1];
    var_6._id_3CC5[var_6._id_3CC5.size] = var_2;
  }
}

getadjacentzones(var_0) {
  var_1 = [];
  var_2 = level._id_AC80._id_ACB3[var_0];

  foreach(var_4 in var_2._id_0A01)
  var_1[var_1.size] = var_4;

  return var_1;
}

_id_088A(var_0) {
  if(isDefined(var_0))
    level._id_AC80._id_9065 = var_0;

  foreach(var_2 in level._id_AC80._id_ACB3) {
    foreach(var_5, var_4 in var_2._id_0A01)
    level thread _id_ACC1(var_2, var_5);
  }

  level thread _id_63E4();
  level thread _id_ACAC();
  level._id_AC80._id_08A9 = 1;
}

_id_63E4() {
  level endon("game_ended");
  var_0 = 1.0;

  for(;;) {
    level._id_AC80._id_8FE7 = 1;

    while(level._id_AC80._id_8FE7)
      waitframe();

    wait(var_0);
  }
}

_id_ACC1(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in var_0._id_0A01[var_1]._id_3CC5)
  level thread _id_ACC2(var_0, var_3, var_1);
}

_id_ACC2(var_0, var_1, var_2) {
  level endon("game_ended");
  common_scripts\utility::_id_3C9F(var_1);
  var_3 = level._id_AC80._id_ACB3[var_2];
  var_3._id_556E = 1;
  common_scripts\utility::flag_set(var_0._id_AC8A);
  var_0._id_0A01[var_2]._id_554C = 1;
  level thread _id_A100();
}

_id_445A(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = _id_4482();

  for(var_5 = var_4.size; var_5 > 0; var_5--) {
    var_6 = var_4[var_3];
    var_7 = level._id_AC80._id_ACB3[var_6];

    if(var_0)
      var_2 = common_scripts\utility::_id_0F73(var_2, var_7._id_2302);
    else {
      var_2 = common_scripts\utility::_id_0F73(var_2, var_7._id_2300);

      foreach(var_9 in var_2) {
        if(!isDefined(var_9.setlookatent))
          var_2 = common_scripts\utility::_id_0F93(var_2, var_9);
      }
    }

    if(_id_586A(var_7._id_AC8A)) {
      foreach(var_12 in var_7._id_0A01) {
        if(!_id_586A(var_12._id_AC8A)) {
          if(!var_0) {
            continue;
          }
          if(var_12._id_6B2C)
            continue;
        }

        if(!common_scripts\utility::_id_0F79(var_4, var_12._id_AC8A)) {
          var_4[var_4.size] = var_12._id_AC8A;
          var_5++;
        }
      }
    }

    var_3++;
  }

  var_2 = _sortbydistance(var_2, var_1);

  for(var_14 = var_2.size - 1; var_14 >= 0; var_14--) {
    if(!isDefined(var_2[var_14]._id_4B57)) {
      var_2[var_14]._id_4B57 = 1;
      return var_2[var_14];
    }
  }

  var_2[var_2.size - 1]._id_4B57 = 1;
  return var_2[var_2.size - 1];
}

_id_4696(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_AC80))
    return undefined;

  if(level._id_AC80._id_8FE7) {
    level._id_AC80._id_8FE7 = 0;
    _id_A166();
  }

  return [[level._id_AC80._id_9065]](var_0, var_1, var_2, var_3);
}

_id_A166() {
  foreach(var_1 in level._id_AC80._id_ACB3) {
    var_1._id_552B = _id_5780(var_1._id_AC8A);
    var_1._id_552C = 0;
  }

  foreach(var_1 in level._id_AC80._id_ACB3) {
    if(var_1._id_552B) {
      foreach(var_5 in var_1._id_0A01) {
        var_6 = level._id_AC80._id_ACB3[var_5._id_AC8A];

        if(!var_6._id_552B)
          var_6._id_552C = 1;
      }
    }
  }

  var_9 = [];
  var_10 = [];

  foreach(var_1 in level._id_AC80._id_ACB3) {
    if(var_1._id_552B || var_1._id_552C && var_1._id_556E)
      var_9[var_9.size] = var_1._id_AC8A;

    if(var_1._id_552C)
      var_10[var_10.size] = var_1._id_AC8A;
  }

  level._id_AC80._id_2914 = var_9;
  level._id_AC80._id_290A = var_10;
}

_id_583C(var_0) {
  var_1 = 0;

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      var_4 = _func_38E(var_0, var_3.origin);

      if(var_4 < 2000) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

_id_4692() {
  var_0 = [];

  foreach(var_2 in level._id_AC80._id_2914) {
    var_3 = level._id_AC80._id_ACB3[var_2];

    foreach(var_5 in var_3._id_ABFE)
    var_0[var_0.size] = var_5;
  }

  return var_0;
}

_id_4693(var_0) {
  var_1 = [];
  var_2 = level._id_AC80._id_ACB3[var_0];

  foreach(var_4 in var_2._id_ABFE)
  var_1[var_1.size] = var_4;

  return var_1;
}

_id_4691() {
  var_0 = [];

  foreach(var_2 in level._id_AC80._id_290A) {
    var_3 = level._id_AC80._id_ACB3[var_2];

    foreach(var_5 in var_3._id_ABFE)
    var_0[var_0.size] = var_5;
  }

  return var_0;
}

_id_582C() {
  if(isDefined(self._id_8C95) && self._id_8C95) {
    if(isDefined(level._id_8C96))
      return [[level._id_8C96]]();
    else
      return 1;
  } else
    return 1;
}

_id_1E55(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_7A5D) && isDefined(level._id_7A5D[var_0]))
    return [[level._id_7A5D[var_0]]]();

  if(level._id_AC80._id_2914.size == 0)
    return undefined;

  var_4 = undefined;

  if(var_2)
    var_5 = common_scripts\utility::array_randomize(_id_4691());
  else if(isDefined(var_3))
    var_5 = common_scripts\utility::array_randomize(_id_4693(var_3));
  else
    var_5 = common_scripts\utility::array_randomize(_id_4692());

  var_6 = [];

  foreach(var_8 in var_5) {
    if((var_8 _id_905D() || isDefined(var_3)) && var_8 _id_905C(var_0, var_1) && (isDefined(var_3) || (var_2 || _id_583C(var_8.origin)) && var_8 _id_582C())) {
      var_4 = var_8;
      break;
    }
  }

  if(!isDefined(var_4) && common_scripts\utility::_id_562E(level._id_7D20)) {
    var_10 = common_scripts\utility::array_randomize(level._id_AC4F);

    foreach(var_8 in var_10) {
      if(var_8 _id_905D() && var_8 _id_905C(var_0, var_1)) {
        var_4 = var_8;
        break;
      }
    }
  }

  if(!isDefined(var_4)) {
    var_17 = randomint(level._id_AC80._id_2914.size);
    var_18 = level._id_AC80._id_2914[var_17];
    var_19 = level._id_AC80._id_ACB3[var_18];

    foreach(var_8 in var_19._id_ABFE) {
      if(var_8 _id_905C(var_0, var_1)) {
        var_4 = var_8;
        break;
      }
    }
  }

  return var_4;
}

_id_1E58(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    var_4 = [var_3];
  else
    var_4 = level._id_AC80._id_2914;

  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = level._id_AC80._id_ACB3[var_7];
    var_5 = common_scripts\utility::_id_0F73(var_5, var_8._id_ABFE);
  }

  var_10 = _id_0558::_id_4746(var_5, var_0, var_1);
  var_10._id_5BE2 = gettime();
  return var_10;
}

_id_1E4E(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    var_4 = [var_3];
  else
    var_4 = level._id_AC80._id_2914;

  var_9 = [];

  foreach(var_7 in var_4) {
    var_11 = level._id_AC80._id_ACB3[var_7];

    foreach(var_13 in var_11._id_ABFE) {
      if(!var_13 _id_905D()) {
        continue;
      }
      if(!var_13 _id_905C(var_0, var_1)) {
        continue;
      }
      if(!var_13 _id_582C()) {
        continue;
      }
      if(isDefined(var_13.setflaggedanimknoball) && common_scripts\utility::_id_562E(var_13._id_50D5)) {
        continue;
      }
      var_9[var_9.size] = var_13;
    }
  }

  var_16 = 2;
  var_17 = undefined;
  var_18 = undefined;
  var_19 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_21 in level.players) {
    if(!isalive(var_21) || common_scripts\utility::_id_562E(var_21.inlaststand)) {
      continue;
    }
    var_22 = 0;

    foreach(var_24 in var_19) {
      if(isDefined(var_24._id_0088) && var_24._id_0088 == var_21)
        var_22++;
    }

    if(common_scripts\utility::_id_562E(var_21._id_AC5B))
      var_22 = var_19.size;

    var_22 = var_22 + _randomfloat(var_16);

    if(!isDefined(var_18) || var_22 < var_18) {
      var_18 = var_22;
      var_17 = var_21;
    }
  }

  if(!isDefined(var_17))
    return common_scripts\utility::random(var_9);

  var_27 = 20;
  var_28 = 0.3;
  var_29 = 0.2;
  var_30 = common_scripts\utility::_id_5D93(level._id_A980, 1, 10, 40, 80);
  var_31 = 10;
  var_32 = 3;
  var_33 = 2;
  var_34 = undefined;
  var_35 = undefined;

  foreach(var_37 in var_9) {
    var_5 = "";
    var_38 = 0;

    if(common_scripts\utility::_id_562E(var_37._id_8C95)) {
      var_38 = var_38 + var_32;
      var_39 = var_37._id_487C;
    } else {
      var_39 = var_37.origin;
      var_37 _id_054D::_id_A0DA();
      var_38 = var_38 + var_31 * var_37._id_AC3D.size;

      if(isDefined(var_37._id_3C5B) && _id_0547::_id_562C(var_37._id_3C5B))
        var_38 = var_38 + var_33 * var_37._id_3C5B._id_15CB._id_17EC;
    }

    var_40 = _func_38E(var_39, var_17.origin);
    var_38 = var_38 + var_40 / var_30;
    var_38 = var_38 / common_scripts\utility::_id_5D93(vectordot(vectorNormalize(var_17 getvelocity()), vectorNormalize(var_39 - var_17.origin)), 0, 1, 1, 1 + var_29);
    var_38 = var_38 + _randomfloat(var_38 * var_28 + var_27);

    if(!isDefined(var_34) || var_38 < var_34) {
      var_34 = var_38;
      var_35 = var_37;
    }
  }

  return var_35;
}

_id_905C(var_0, var_1) {
  if(isDefined(self.setlookatent)) {
    var_2 = strtok(self.setlookatent, " ,");
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(var_6 == var_0)
        var_3 = 1;

      if(var_6 == "exclusive")
        var_4 = 1;
    }

    if(!var_3 && (var_4 || var_1))
      return 0;
  } else if(var_1)
    return 0;

  return 1;
}

_id_905D() {
  if(common_scripts\utility::_id_562E(self._id_3A1B))
    return 0;

  if(common_scripts\utility::_id_562E(self.is_zombies_spawner_script_disabled))
    return 0;

  if(common_scripts\utility::_id_562E(level._id_7D20) && !isDefined(self.getnegotiationnextnode))
    return 0;
  else if(common_scripts\utility::_id_562E(level._id_38D1) && !isDefined(self.getnegotiationnextnode)) {
    var_0 = level._id_AC80._id_ACB3[self._id_AC8A];

    foreach(var_3, var_2 in var_0._id_9050) {
      if(common_scripts\utility::_id_3C77(var_3))
        return 0;
    }
  }

  if(isDefined(self.getnegotiationnextnode)) {
    if(!common_scripts\utility::_id_3C77(self.getnegotiationnextnode))
      return 0;
  }

  return 1;
}

_id_8729(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0))
    level._id_38D2[var_1] = 1;
  else
    level._id_38D2[var_1] = undefined;

  if(level._id_38D2.size > 0)
    level._id_38D1 = 1;
  else
    level._id_38D1 = undefined;
}

_id_8712(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0))
    level._id_7D21[var_1] = 1;
  else
    level._id_7D21[var_1] = undefined;

  if(level._id_7D21.size > 0)
    level._id_7D20 = 1;
  else
    level._id_7D20 = undefined;
}

_id_ACA1() {
  var_0 = common_scripts\utility::_id_46B5(self._id_AC8A, "targetname");

  if(isDefined(var_0)) {
    var_1 = _func_2E1(var_0.origin);
    self._id_74DC = var_1;
    return;
  }

  foreach(var_3 in _id_050D::_id_44F9("allies")) {
    if(_id_0547::_id_5565(var_3._id_0165, self._id_AC8A)) {
      var_1 = _func_2E1(var_3.origin);
      self._id_74DC = var_1;
      return;
    }
  }

  foreach(var_6 in self._id_A615) {
    var_7 = var_6 getpointinbounds(0, 0, 0);
    var_8 = _func_2E1(var_7);

    if(_ispointinvolume(var_8, var_6)) {
      self._id_74DC = var_8;
      return;
    }
  }
}

_id_ACB0(var_0) {
  var_1 = "mp/zombieZoneTable.csv";
  var_2 = _tablegetcolumncount(var_1);
  return tablelookup(var_1, 0, var_0, 1);
}

_id_ACAC() {
  if(common_scripts\utility::_id_562E(level._id_ACA3)) {
    return;
  }
  foreach(var_7, var_1 in level._id_AC80._id_ACB3) {
    var_2 = _id_ACB0(var_7);
    var_1._id_ACAD = var_2 != "";
  }

  maps\mp\_utility::_id_6F74(::zonehudupdateplayerthread);
}

zonehudupdateplayerthread() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0._id_ACA6 = [];
  var_0 thread _id_ACAB();

  foreach(var_3, var_2 in level._id_AC80._id_ACB3)
  var_0 common_scripts\utility::_id_3799(var_3);

  for(;;) {
    var_3 = var_0 _id_462D();

    if(!isDefined(var_3)) {} else {
      var_2 = level._id_AC80._id_ACB3[var_3];

      if(_id_0547::_id_5565(var_0._id_5BB6, var_3)) {} else {
        var_5 = "unknown";

        if(isDefined(var_0._id_5BB6))
          var_5 = var_0._id_5BB6;

        var_0 _id_ACA7("ui_zm_previous_zone_name", var_5);
        var_0 _id_ACA7("ui_zm_current_zone_name", var_3);
        var_6 = "ui_zm_player_" + var_0 getentitynumber() + "_zone_name";
        _setomnvar(var_6, var_3);
        var_0._id_5BB6 = var_3;

        if(!var_0 common_scripts\utility::_id_3794(var_3))
          var_0 common_scripts\utility::_id_379A(var_3);
      }
    }

    waitframe();
  }
}

_id_ACAB() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    if(var_0._id_ACA6.size == 0)
      var_0 waittill("ZoneHud");

    var_1 = var_0._id_ACA6[0];
    var_0._id_ACA6 = common_scripts\utility::_id_0F9A(var_0._id_ACA6, 0);
    var_0[[var_1._id_1E61]](var_1._id_2A35);
  }
}

_id_ACA8(var_0) {
  var_1 = self;
  var_1 _id_ACA2(var_0, ::_id_ACAA);
}

_id_ACA7(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();
  var_3._id_6A70 = var_0;
  var_3._id_6A71 = var_1;
  var_2 _id_ACA2(var_3, ::_id_ACA9);
}

_id_ACA2(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();
  var_3._id_2A35 = var_0;
  var_3._id_1E61 = var_1;
  var_2._id_ACA6 = common_scripts\utility::_id_0F6F(var_2._id_ACA6, var_3);
  var_2 notify("ZoneHud");
}

_id_ACAA(var_0) {
  wait(var_0);
}

_id_ACA9(var_0) {
  var_1 = self;
  var_2 = var_0._id_6A70;
  var_3 = var_0._id_6A71;
  var_1 setclientomnvar(var_2, var_3);
}