/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2072.gsc
*************************************************/

_id_34F7(var_0) {
  if(isDefined(level._id_50B9)) {
    var_0 = [[level._id_50B9]](var_0);
  }

  return var_0;
}

_id_D052(var_0, var_1) {
  var_2 = var_0;
  return var_2;
}

_id_5AE3() {
  if(!level.teambased || istrue(level._id_4A82)) {
    return undefined;
  }

  if(getdvarint("#x3d90d2f946e5c54c3", 0) == 1) {
    return undefined;
  }

  if(!_id_0817::_id_1B0C()) {
    _id_0817::_id_FD32();
  }

  var_0 = _id_6DD2(_id_0817::_id_688A().team);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _id_5B06(var_3);

    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = spawnStruct();
    var_5.origin = var_4;
    var_5.angles = _id_6931(var_3, var_5.origin);
    var_5.index = -1;
    var_5._id_2C93 = 1;
    var_5._id_8816 = 1;
    var_5.owner = var_3;
    var_5 _id_0817::_id_E34C();

    if(isDefined(var_3._id_1767) && isDefined(var_3._id_1767._id_B6DA)) {
      var_5._id_2C92 = var_3._id_1767._id_B6DA;
    }

    var_1[var_1.size] = var_5;
  }

  var_7 = [];
  _id_FD31(var_1, 1);

  foreach(var_5 in var_1) {
    if(!_id_F0D3(var_5)) {
      continue;
    }
    _id_CBF5(var_5);
    var_7[var_7.size] = var_5;
  }

  var_10 = undefined;

  foreach(var_5 in var_7) {
    if(!isDefined(var_10) || var_5._id_0497 > var_10._id_0497) {
      var_10 = var_5;
    }
  }

  return var_10;
}

_id_5B07(var_0) {
  if(!level.teambased || istrue(level._id_4A82)) {
    return undefined;
  }

  if(!_id_0817::_id_1B0C()) {
    _id_0817::_id_FD32();
  }

  var_1 = spawnStruct();
  var_1._id_E353 = undefined;
  var_1._id_E266 = (0, var_0.angles[1], 0);
  var_1 = _id_321C(var_1, var_0);

  if(!isDefined(var_1._id_E353)) {
    var_1._id_E353 = var_0.origin;
    var_1._id_E266 = var_0.angles;
  }

  if(isDefined(var_0.vehicle)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_0.vehicle, 1);

    if(var_2.size > 0 && istrue(_id_09E1::_id_10116(var_0.vehicle))) {
      var_3 = spawnStruct();
      var_3._id_FE9B = 1;
      var_3._id_54E5 = "spawned_player";
      thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_0.vehicle, var_2[0], self, var_3);
      var_1._id_E353 = var_0.vehicle.origin;
      var_1._id_E266 = var_0.vehicle.angles;
      self._id_E309 = 1;
      scripts\mp\utility\stats::_id_7DAE("spawnSelectVehicle", 1);
    } else if(!isDefined(var_1._id_E353)) {
      var_1._id_E353 = var_0.vehicle.origin + anglesToForward(var_0.vehicle.angles) * -200 + (0, 0, 64);
      var_1._id_E266 = (0, var_0.vehicle.angles[1], 0);
    }
  }

  var_4 = spawnStruct();
  var_4.origin = var_1._id_E353;
  var_4.angles = var_1._id_E266;
  var_4.index = -1;
  var_4._id_2C93 = 1;
  var_4._id_8816 = 1;
  var_4.owner = var_0;
  var_4 _id_0817::_id_E34C();

  if(isDefined(var_0._id_1767) && isDefined(var_0._id_1767._id_B6DA)) {
    var_4._id_2C92 = var_0._id_1767._id_B6DA;
  }

  return var_4;
}

_id_321C(var_0, var_1) {
  var_2 = 16;
  var_3 = 64;
  var_4 = 64;
  var_5 = 30;
  var_6 = 30;
  var_7 = 180 / var_6;
  var_8 = 1;
  var_9 = 1;
  var_10 = var_2 / (80 - var_2);
  var_11 = var_1.angles;
  var_12 = 1;
  var_13 = undefined;
  var_14 = var_1.origin;

  if(var_1 _meth_8732()) {
    var_14 = var_1 _meth_8724();
  }

  var_15 = var_14 + (0, 0, var_5);
  var_16 = physics_createcontents(["physicscontents_item", "physicscontents_water", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"]);
  var_17 = [var_1];

  while(var_8 < var_7) {
    if(var_12) {
      var_12 = 0;
      var_13 = anglesToForward(var_11);
    } else {
      var_13 = anglesToForward(var_11 + (0, scripts\engine\utility::ter_op(var_9, var_6, var_6 * -1) * var_8, 0));
      var_9 = !var_9;

      if(var_9 == 1) {
        var_8++;
      }
    }

    var_18 = var_14 - var_13 * var_3 + (0, 0, var_5);
    var_19 = var_15 - var_13 * var_2 * 0.5;
    var_20 = scripts\engine\trace::_id_B607(var_19, var_18, (0, 0, 0), var_17, var_16);
    var_21 = var_20["shape_position"];
    var_22 = 0;

    if(var_20["fraction"] < 1 && var_20["fraction"] > var_2 / var_3) {
      var_21 = var_21 + (var_13 * var_2 - (0, 0, var_3 / 2));
      var_22 = 1;
    }

    if(var_20["fraction"] > var_2 / var_3) {
      var_23 = 0;
      var_19 = var_21;
      var_24 = var_19 + (0, 0, -80);
      var_25 = scripts\engine\trace::_id_B607(var_19, var_24, (0, 0, 0), var_17, var_16);

      if(var_25["fraction"] < 1) {
        var_26 = vectortoangles(var_13);
        var_19 = var_25["shape_position"] + (0, 0, 10);
        var_27 = var_19 + anglesToForward(var_26) * -32;
        var_28 = var_27 + (0, 0, -80);
        var_29 = scripts\engine\trace::ray_trace(var_27, var_28, var_17, var_16);

        if(var_29["fraction"] == 1.0) {
          continue;
        }
        var_30 = var_19 + anglestoright(var_26) * -32;
        var_31 = var_30 + (0, 0, -80);
        var_32 = scripts\engine\trace::ray_trace(var_30, var_31, var_17, var_16);

        if(var_32["fraction"] == 1.0) {
          continue;
        }
        var_33 = var_19 + anglestoright(var_26) * 32;
        var_34 = var_33 + (0, 0, -80);
        var_35 = scripts\engine\trace::ray_trace(var_33, var_28, var_17, var_16);

        if(var_35["fraction"] == 1.0) {
          continue;
        }
        var_0._id_E353 = var_25["shape_position"];
        var_0._id_E266 = var_26;
        break;
      } else
        continue;
    }
  }

  return var_0;
}

_id_CBF5(var_0) {
  _id_0816::_id_2EE6(var_0, "avoidShortTimeToEnemySight", 1.0);
  _id_0816::_id_2EE6(var_0, "avoidClosestEnemy", 1.0);
}

_id_6931(var_0, var_1) {
  var_2 = (0, var_0.angles[1], 0);
  return var_2;
}

_id_6DD2(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team != var_0) {
      continue;
    }
    if(var_3 == self) {
      continue;
    }
    if(!_id_31AE(var_3)) {
      continue;
    }
    if(!var_3 scripts\mp\utility\player::_id_898A()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::array_randomize(var_1);
}

_id_31AE(var_0) {
  if(var_0.sessionstate != "playing") {
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 isonground()) {
    return 0;
  }

  if(var_0 isonladder()) {
    return 0;
  }

  if(var_0 scripts\engine\utility::_id_8862()) {
    return 0;
  }

  if(var_0.health < var_0.maxhealth && (!isDefined(var_0._id_8FB5) || gettime() < var_0._id_8FB5 + 3000)) {
    return 0;
  }

  return 1;
}

_id_5B06(var_0) {
  var_1 = _id_0817::_id_6C6C(var_0, 1);
  var_2 = _id_5AE2(var_0, var_1, 0.5);

  if(isDefined(var_2)) {
    return var_2.origin;
  }

  return undefined;
}

_id_5AE2(var_0, var_1, var_2) {
  var_3 = _func_00B5(var_0.origin, 192, 64, var_1, "Path", 1);
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = anglesToForward(var_0.angles);

    foreach(var_7 in var_3) {
      if(isDefined(level._id_20EC) && scripts\engine\utility::array_contains(level._id_20EC, var_7)) {
        continue;
      }
      var_8 = vectornormalize(var_7.origin - var_0.origin);
      var_9 = vectordot(var_5, var_8);

      if(var_9 <= var_2 && !_func_01A5(var_7.origin)) {
        var_4 = var_7;

        if(var_9 <= 0.0) {
          break;
        }
      }
    }
  }

  return var_4;
}

badspawntimeout(var_0) {
  if(scripts\mp\utility\game::isrecentbadspawncriticalfactorenabled()) {
    if(!isDefined(level.lastbadspawn)) {
      level.lastbadspawn = [];
    }

    if(!isDefined(level.lastbadspawn[var_0.team])) {
      level.lastbadspawn[var_0.team] = [];
    }

    if(isDefined(var_0.spawnpointindex)) {
      if(gettime() - var_0._id_E393 < getdvarint("#x31164269ea9b26376", 3000)) {
        level.lastbadspawn[var_0.team][var_0.spawnpointindex] = spawnStruct();
        level.lastbadspawn[var_0.team][var_0.spawnpointindex].spawnpointindex = var_0.spawnpointindex;
        level.lastbadspawn[var_0.team][var_0.spawnpointindex].timeoutstart = gettime();
        level.lastbadspawn[var_0.team][var_0.spawnpointindex]._id_E352 = var_0._id_E352;
      }
    }
  }
}

_id_8282(var_0) {
  var_0._id_0497 = 0;
  var_0._id_F37D = 0;
  var_0._id_8776 = 0;
  var_0._id_903B = [];
  var_0._id_903B["allies"] = 0;
  var_0._id_903B["axis"] = 0;
  var_0._id_1755 = spawnStruct();
  var_0._id_1755._id_1622 = 0;
  var_0._id_1755._id_5405 = 0;
  var_0._id_1755._id_F272 = 0;
  var_0._id_1755._id_9C6A = 0;
  var_0._id_1755._id_C016 = 0;
  var_0._id_1755._id_9C7C = 0;
  var_0._id_1755._id_E39F = 0;
  var_0._id_1755.spawntype = 0;
}

_id_FD31(var_0, var_1) {
  var_2 = _id_0817::_id_6D5E(self);
  var_1 = istrue(var_1);
  var_3 = "all";

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::_id_6A01(var_2)[0];
  }

  foreach(var_5 in var_0) {
    _id_8282(var_5);
    _id_0817::_id_8293(var_5);
    _id_0817::_id_E34B(var_5);
    _id_0817::_id_5676(var_5, var_2);

    if(!var_1) {
      _id_0817::_id_5676(var_5, var_3);
    }
  }

  if(!var_1) {
    _id_0816::_id_FC70(var_2);
  }
}

_id_408C(var_0) {
  if(scripts\mp\utility\game::isrecentbadspawncriticalfactorenabled()) {
    if(isDefined(level.lastbadspawn)) {
      if(isDefined(level.lastbadspawn[self.team])) {
        foreach(var_2 in level.lastbadspawn[self.team]) {
          if(gettime() - var_2.timeoutstart < getdvarint("#x37c1378efcb07a186", 5000)) {
            if(var_0.index == var_2.spawnpointindex) {
              return "bad";
            }

            if(distance2dsquared(var_0.origin, var_2._id_E352) < getdvarint("#x3347c3720ea131ae6", 22500)) {
              return "bad";
            }
          } else
            level.lastbadspawn[self.team][var_2.spawnpointindex] = undefined;
        }
      }
    }
  }

  return "primary";
}

_id_F0D4(var_0) {
  if(!_id_0816::_id_408A(_id_0816::_id_1FAD, var_0)) {
    var_0._id_20F7 = 0;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FAE, var_0)) {
    var_0._id_20F7 = 1;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FB2, var_0)) {
    var_0._id_20F7 = 2;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FA3, var_0)) {
    var_0._id_20F7 = 4;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::avoidgoliaths, var_0)) {
    var_0._id_20F7 = 8;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::avoidfirebomb, var_0)) {
    var_0._id_20F7 = 9;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FBD, var_0)) {
    var_0._id_20F7 = 5;
    return "bad";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FAC, var_0)) {
    var_0._id_20F7 = 6;
    return "bad";
  }

  if(scripts\mp\utility\game::getgametype() != "patrol") {
    if(isDefined(var_0._id_5FE2) && level._id_5FDF.isactive[self.team] && var_0._id_5FE2 != self.team) {
      var_0._id_20F7 = 7;
      return "bad";
    }
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FA8, var_0)) {
    return "secondary";
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FA4, var_0)) {
    return "secondary";
  }

  return "primary";
}

_id_F0D3(var_0) {
  if(!_id_0816::_id_408A(_id_0816::_id_1FAD, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FAE, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FB2, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FA3, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::avoidgoliaths, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FBD, var_0)) {
    return 0;
  }

  if(!_id_0816::_id_408A(_id_0816::_id_1FA4, var_0)) {
    return 0;
  }

  return 1;
}

_id_6D89(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_2 = _id_0817::_id_6889();
  var_0 = _id_34F7(var_0);

  if(!isDefined(var_2) || var_2.size == 0) {
    return _id_0817::_id_6D4C(var_0);
  }

  var_3 = 0;

  foreach(var_5 in var_0) {
    if(_func_0034(var_5.origin) && !_func_01A5(var_5.origin)) {
      var_6 = undefined;

      foreach(var_8 in var_2) {
        var_9 = distancesquared(var_5.origin, var_8.origin);

        if(!isDefined(var_6) || var_9 < var_6) {
          var_6 = var_9;
        }
      }

      if(!isDefined(var_1) || var_6 > var_3) {
        var_1 = var_5;
        var_3 = var_6;
      }
    }
  }

  if(!isDefined(var_1)) {
    return _id_0817::_id_6D4C(var_0);
  }

  return var_1;
}

_id_975A(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_4AEA) && var_1._id_4AEA) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = var_0;
  }

  if(isDefined(level._id_9BDB)) {
    [[level._id_9BDB]]("LOG_BAD_SPAWN", gettime(), var_0);
  }
}

_id_6D4B(var_0, var_1, var_2, var_3, var_4) {
  level._id_E2F4._id_E350 = var_0;
  var_5 = _id_0817::_id_4052(self, self.pers["team"]);
  _id_0817::_id_D462(var_5);
  _id_C62C();
  _id_6D53();

  if(level._id_5E7F) {
    var_6 = _id_5AE3();

    if(isDefined(var_6)) {
      return var_6;
    }
  }

  var_7 = undefined;
  level._id_E2F4._id_E231 = 0;
  var_8 = _id_6D52(var_0, 0);

  if(isDefined(var_8)) {
    if(!istrue(var_8._id_8776)) {
      return var_8;
    } else {
      var_7 = var_8;
    }
  }

  if(isDefined(var_1)) {
    var_9 = _id_6D52(var_1, 3);

    if(isDefined(var_9)) {
      if(istrue(var_9._id_8776)) {
        if(!isDefined(var_7) || var_9._id_0497 > var_7._id_0497) {
          var_7 = var_9;
        }
      } else {
        _id_975A("Using a fallback spawn.", self);
        return var_9;
      }
    }
  }

  if(istrue(var_3)) {
    return undefined;
  }

  _id_975A("Using a LastResort spawn point.", self);

  if(!istrue(var_4)) {
    var_10 = _id_5AE3();

    if(isDefined(var_10)) {
      var_10.spawntype = 7;
      level._id_E2F4._id_2C94 = 0;

      if(isDefined(var_10._id_2C92)) {
        level._id_E2F4._id_2C92 = var_10._id_2C92;
      }

      return var_10;
    }

    _id_975A("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);
  }

  if(level.teambased && !scripts\mp\utility\game::isanymlgmatch()) {
    var_11 = level._id_E2F4._id_8F98[self.team];

    if(isDefined(var_11) && gettime() - var_11 < 5000) {
      var_7 = var_0[randomint(var_0.size)];
    } else {
      level._id_E2F4._id_8F98[self.team] = gettime();
    }
  }

  return var_7;
}

_id_6D52(var_0, var_1) {
  var_0 = _id_34F7(var_0);
  var_2["primary"] = [];
  var_2["secondary"] = [];
  var_2["bad"] = [];
  _id_FD31(var_0);

  foreach(var_4 in var_0) {
    var_5 = _id_F0D4(var_4);
    var_2[var_5][var_2[var_5].size] = var_4;
    var_4._id_8F9D[scripts\engine\utility::ter_op(isDefined(self._id_E31A), self._id_E31A, self.team)] = var_5;

    if(isDefined(var_4._id_1755) && isDefined(var_4._id_1755.spawntype)) {
      if(var_5 == "primary") {
        var_4._id_1755.spawntype = var_1 + 1;
        continue;
      }

      if(var_5 == "secondary") {
        var_4._id_1755.spawntype = var_1 + 2;
        continue;
      }

      var_4._id_1755.spawntype = var_1 + 3;
    }
  }

  if(var_2["primary"].size) {
    var_5 = _id_6A9F(var_2["primary"]);
    var_5._id_E231 = 1;
    return var_5;
  }

  if(var_2["secondary"].size) {
    var_5 = _id_6A9F(var_2["secondary"]);
    var_5._id_E231 = 2;
    return var_5;
  }

  if(var_2["bad"].size) {
    _id_975A("Using Bad Spawn", self);
    var_5 = _id_6A9F(var_2["bad"]);

    if(isDefined(var_5)) {
      var_5._id_8776 = 1;
    }

    return var_5;
  }

  return undefined;
}

_id_C62C() {
  var_0 = level._id_E2F4;
  var_0._id_754E = 0;
  var_0._id_757C = 0;
}

_id_6D53() {
  var_0 = _id_0817::_id_6D5E(self);
  _id_0817::_id_FD32();
  var_1 = level._id_E2F4;

  if(_id_0817::_id_884C("preferNearGroupsOfTeamMates")) {
    var_1._id_EF68 = [];
    var_1._id_EF68[var_0] = _id_0817::_id_2F01(var_0);
  }

  if(_id_0817::_id_884C("preferOccupiedLanes") || _id_0817::_id_884C("preferToBalanceLanes")) {
    var_1._id_A928 = [];

    foreach(var_3 in level._id_E2F4._id_8EAE) {
      foreach(var_5 in level.players) {
        var_6 = _id_0817::_id_6D5E(var_5);

        if(!scripts\mp\utility\player::isreallyalive(var_5)) {
          continue;
        }
        if(!var_5 scripts\mp\utility\player::_id_898A()) {
          continue;
        }
        if(_func_011A(var_5.origin, var_3)) {
          if(!isDefined(var_1._id_A928[var_6])) {
            var_1._id_A928[var_6] = 0;
          }

          var_1._id_A928[var_6] = var_1._id_A928[var_6] | var_3._id_7DFC;
        }
      }
    }
  }
}

_id_6A9F(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    _id_0817::_id_CC18(var_3);

    if(var_3._id_0497 > var_1._id_0497) {
      var_1 = var_3;
    }
  }

  var_1 = _id_D052(var_1, var_0);
  return var_1;
}

_id_E4AC() {
  self endon("death_or_disconnect");
  var_0 = spawnStruct();

  for(;;) {
    var_0._id_E353 = undefined;
    var_0._id_E266 = undefined;
    var_0 = _id_321C(var_0, self);
    var_1 = 0;

    if(!isDefined(var_0._id_E353)) {
      var_0._id_E353 = self.origin;
      var_0._id_E266 = self.angles;
      var_1 = 1;
    }

    thread _id_09C0::_id_4F48(var_0._id_E353, 16, 0.1, scripts\engine\utility::ter_op(var_1, (1, 0, 0), (0, 1, 0)));
    thread _id_09C0::_id_4F32(var_0._id_E353, var_0._id_E266, 0.1, 1.0);
    wait 0.1;
  }
}