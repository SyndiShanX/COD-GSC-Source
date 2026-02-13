/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2070.gsc
*************************************************/

_id_80B6() {
  if(!isDefined(level._id_E0FB)) {
    level._id_E0FB = 250000;
  }

  if(!isDefined(level._id_542A)) {
    level._id_542A = 810000;
  }

  _id_C25A("preferOptimalTTLOS", ::_id_BB8A, 0, undefined);
  _id_C25A("avoidShortTimeToEnemySight", ::_id_1FBB, 0, undefined);
  _id_C25A("preferAlliesByDistance", ::_id_BB80, 0, undefined);
  _id_C25A("preferCloseToAlly", ::_id_BB83, 0, undefined);
  _id_C25A("avoidRecentlyUsedByEnemies", ::_id_1FB6, 0, undefined);
  _id_C25A("avoidEnemiesByDistance", ::_id_1FAA, 0, undefined);
  _id_C25A("avoidEnemyInfluence", ::_id_1FAB, 0, undefined);
  _id_C25A("avoidLastDeathLocation", ::_id_1FB1, 0, undefined);
  _id_C25A("avoidLastAttackerLocation", ::_id_1FB0, 0, undefined);
  _id_C25A("avoidShortTimeToJumpingEnemySight", ::_id_1FBC, 0, undefined);
  _id_C25A("avoidVeryShortTimeToJumpingEnemySight", ::_id_1FBE, 0, undefined);
  _id_C25A("avoidSameSpawn", ::_id_1FBA, 0, undefined);
  _id_C25A("avoidRecentlyUsedByAnyone", ::_id_1FB5, 0, undefined);
  _id_C25A("randomSpawnScore", ::_id_C017, 0, undefined);
  _id_C25A("preferNearLastTeamSpawn", ::_id_BB87, 0, undefined);
  _id_C25A("preferNearGroupsOfTeamMates", ::_id_BB86, 0, undefined);
  _id_C25A("preferOccupiedLanes", ::_id_BB89, 0, undefined);
  _id_C25A("preferToBalanceLanes", ::_id_BB91, 0, undefined);
  _id_C25A("avoidClosestEnemy", ::_id_1FA5, 0, undefined);
  _id_C25A("scriptOnlyTest", ::_id_CF94, 1, ["test"]);
  _id_C25A("avoidClosestEnemyByDistance", ::_id_1FA6, 1, ["closestEnemyInfluenceDistSq"]);
  _id_C25A("preferNearSinglePoint", ::_id_BB88, 1, ["singlePointPos", "minDistToSinglePointSq", "maxDistToSinglePointSq", "distRangeToSinglePointSq"]);
  _id_C25A("preferDomPoints", ::_id_BB84, 1, ["preferredDomPoints", "secondaryDomPoints"]);
  _id_C25A("preferShortestDistToKOTHZone", ::_id_BB90, 1, ["activeKOTHZoneNumber", "maxSquaredDistToObjective"]);
  _id_C25A("avoidCloseToKOTHZone", ::_id_1FA7, 1, ["activeKOTHZoneNumber", "kothZoneDeadzoneDistSq"]);
  _id_C25A("preferClosePoints", ::_id_BB82, 1, ["closestPoints"]);
  _id_C25A("avoidRugbyOffsides", ::_id_1FB8, 1, ["juggPos", "rugbyFieldDir2D"]);
  _id_C25A("oneUseSpawns", ::_id_AAD3, 1, undefined);
  _id_C25A("avoidFireBomb", ::avoidfirebomb, 1, undefined);
  _id_C25A("avoidGoliaths", ::avoidgoliaths, 1, undefined);
  _id_819C();
}

_id_C25A(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_E2F4._id_589A)) {
    level._id_E2F4._id_589A = [];
  }

  var_4 = spawnStruct();
  level._id_E2F4._id_589A[var_0] = var_4;
  var_4._id_6037 = var_1;
  var_4._id_AE49 = var_3;
  var_4._id_8A1E = var_2;
}

_id_884D(var_0) {
  return isDefined(level._id_E2F4._id_589A[var_0]);
}

_id_884E(var_0) {
  return level._id_E2F4._id_589A[var_0]._id_8A1E;
}

_id_6A30(var_0) {
  return level._id_E2F4._id_589A[var_0]._id_6037;
}

_id_6A31(var_0) {
  return level._id_E2F4._id_589A[var_0]._id_AE49;
}

_id_2EE6(var_0, var_1, var_2) {
  if(!_id_884D(var_1)) {
    return 0;
  }

  var_3 = _id_6A30(var_1);
  var_4 = _id_6A31(var_1);
  var_5 = level._id_E2F4._id_0F5D;

  if(isDefined(var_4)) {
    if(!isDefined(var_5._id_5899)) {}
  }

  var_13 = [[var_3]](var_0);
  var_13 = clamp(var_13, 0, 100);
  var_13 = var_13 * var_2;
  var_0._id_F37D = var_0._id_F37D + 100 * var_2;
  var_0._id_903B[self.team] = var_0._id_903B[self.team] + var_13;
  var_0._id_0497 = var_0._id_0497 + var_13;
  return var_13;
}

_id_408A(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

_id_1FA3(var_0) {
  foreach(var_2 in level._id_326E) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

avoidgoliaths(var_0) {
  if(isDefined(level._id_C343)) {
    foreach(var_2 in level._id_C343) {
      if(distancesquared(var_0.origin, var_2.origin) < 12544) {
        return 0;
      }
    }
  }

  return 100;
}

avoidfirebomb(var_0) {
  if(isDefined(level._id_0F6B)) {
    foreach(var_2 in level._id_0F6B) {
      if(distancesquared(var_0.origin, var_2.origin) < 2250000) {
        return 0;
      }
    }
  }

  return 100;
}

_id_1FAE(var_0) {
  foreach(var_2 in level._id_7177) {
    if(!isDefined(var_2) || !var_2 _id_8843(self) || istrue(var_2._id_DB89)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

_id_1FB2(var_0) {
  var_1 = level._id_9EE2;

  if(isDefined(level._id_F4C0) && level._id_F4C0.size > 0) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_F4C0);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 _id_8843(self) || istrue(var_3._id_DB89)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

_id_8843(var_0) {
  if(!level.teambased || level._id_5FA5 || !isDefined(var_0.team)) {
    return 1;
  } else {
    var_1 = undefined;

    if(isDefined(self.owner)) {
      if(var_0 == self.owner) {
        return 1;
      }

      var_1 = self.owner.team;
    }

    if(isDefined(var_1)) {
      return var_1 != var_0.team;
    } else {
      return 1;
    }
  }
}

_id_1FA8(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  if(var_0._id_3D75[var_1] > 0) {
    return 0;
  }

  return 100;
}

_id_1FAD(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  if(var_0._id_5FF9[var_1] > 0) {
    return 0;
  }

  return 100;
}

_id_1FA4(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\utility\teams::_id_6A01(self.team)[0];
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0._id_F37B[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  foreach(var_4 in var_2) {
    if(var_0._id_9EB9[var_4] < level._id_E0FB) {
      return 0;
    }
  }

  return 100;
}

_id_1FBD(var_0) {
  return 100;
}

_id_1FBA(var_0) {
  if(isDefined(self._id_904C) && self._id_904C == var_0) {
    return 0;
  }

  return 100;
}

_id_1FAC(var_0) {
  if(isDefined(self.team) && isDefined(var_0._id_904E) && (!level.teambased || var_0._id_904E != self.team)) {
    var_1 = var_0._id_904F + 500;

    if(gettime() < var_1) {
      return 0;
    }
  }

  return 100;
}

_id_1FB6(var_0) {
  var_1 = !level.teambased || isDefined(var_0._id_904E) && self.team != var_0._id_904E;

  if(var_1 && isDefined(var_0._id_904F)) {
    var_2 = gettime() - var_0._id_904F;
    var_0._id_1755._id_E39F = var_2 / 1000;

    if(var_2 > 4000) {
      return 100;
    }

    return var_2 / 4000 * 100;
  }

  return 100;
}

_id_1FB5(var_0) {
  if(isDefined(var_0._id_904F)) {
    var_1 = gettime() - var_0._id_904F;
    var_0._id_1755._id_F272 = var_1 / 1000;

    if(var_1 > 4000) {
      return 100;
    }

    return var_1 / 4000 * 100;
  }

  return 100;
}

_id_1FB1(var_0) {
  if(!isDefined(self._id_8FBB)) {
    return 100;
  }

  var_1 = distancesquared(var_0.origin, self._id_8FBB);

  if(var_1 > 810000) {
    return 100;
  }

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

_id_1FB0(var_0) {
  if(!isDefined(self._id_026E) || !isDefined(self._id_026E.origin)) {
    return 100;
  }

  if(!scripts\mp\utility\player::isreallyalive(self._id_026E)) {
    return 100;
  }

  var_1 = distancesquared(var_0.origin, self._id_026E.origin);

  if(var_1 > 810000) {
    return 100;
  }

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

_id_819C() {
  var_0 = _id_6A70();

  if(getdvarint("#x33d79f7e318c464db", 0) == 1) {
    return;
  }
  var_1 = [];

  if(istrue(level._id_F0E4)) {
    var_2 = getdvarfloat("#x3fcd377cace885f3b", randomfloatrange(0, 359));
    var_0._id_FF00 = 1;
    var_0._id_1773 = anglesToForward((0, var_2, 0));
    var_0._id_1783 = anglestoright((0, var_2, 0));

    if(isDefined(level._id_9AAC)) {
      var_0._id_BCCD = (level._id_9AAC[0], level._id_9AAC[1], 0);
    }

    level._id_EF39 = var_0;
  } else {
    var_1 = getEntArray("mp_frontline_anchor", "classname");

    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
      var_3 = [];

      foreach(var_5 in var_1) {
        if(isDefined(var_5._id_039B) && var_5._id_039B == level._id_96CC) {
          var_3[var_3.size] = var_5;
          continue;
        }

        var_5 delete();
      }

      var_1 = var_3;
    } else if(var_1.size != 1) {
      var_7 = [];

      foreach(var_5 in var_1) {
        if(!isDefined(var_5._id_039B) || !issubstr(var_5._id_039B, "locale")) {
          var_7[var_7.size] = var_5;
          continue;
        }

        var_5 delete();
      }

      var_1 = var_7;
    }

    if(var_1.size != 0) {
      if(!isDefined(var_1[0].angles)) {
        var_1[0].angles = (0, 0, 0);
      }

      var_0._id_FF00 = 1;
      var_0._id_1773 = anglesToForward(var_1[0].angles);
      var_0._id_BCCD = (var_1[0].origin[0], var_1[0].origin[1], 0);
    }
  }
}

_id_FC70(var_0) {
  if(!_id_FC72()) {
    return;
  }
  _id_CA3D(var_0);
  _id_FC71();
}

_id_FC72() {
  if(!_id_41F2()) {
    return 0;
  }

  var_0 = _id_6A70();
  var_1 = gettime();

  if(!isDefined(var_0._id_90B3)) {
    var_0._id_90B3 = var_1;
  } else if(var_0.isactive["allies"] && var_0.isactive["axis"]) {
    var_0._id_FDAC = var_0._id_FDAC + var_0._id_90B4;
  } else {
    var_0._id_4EBB = var_0._id_4EBB + var_0._id_90B4;
  }

  var_2 = (var_1 - var_0._id_90B3) / 1000.0;
  var_0._id_90B3 = var_1;
  var_0._id_90B4 = var_2;
  var_3 = _id_6A5C("allies");

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3 = (var_3[0], var_3[1], 0);
  var_0._id_150D = var_3;
  var_4 = _id_6A5C("axis");

  if(!isDefined(var_4)) {
    return 0;
  }

  var_4 = (var_4[0], var_4[1], 0);
  var_0._id_1FE2 = var_4;

  if(var_0._id_FF00) {
    var_5 = var_3 - var_0._id_BCCD;
    var_6 = vectordot(var_0._id_1773, var_5);
    var_7 = var_0._id_1773 * var_6 + var_0._id_BCCD;
    var_0._id_BD98 = var_7;
    var_5 = var_4 - var_0._id_BCCD;
    var_8 = vectordot(var_0._id_1773, var_5);
    var_9 = var_0._id_1773 * var_8 + var_0._id_BCCD;
    var_0._id_BD99 = var_9;
    var_10 = abs(var_6 - var_8);

    if(var_10 < 600 && isDefined(var_0._id_EF6C)) {
      var_0._id_3BEC = 1;
    } else {
      var_0._id_3BEC = 0;
      var_0._id_9E8B = var_7 + (var_9 - var_7) * 0.5;
      var_11 = var_9 - var_7;
      var_0._id_EF6C = _func_0261(var_11);
    }
  } else {
    var_12 = var_4 - var_3;
    var_13 = _func_0261(var_12);
    var_0._id_EF6C = var_13;
    var_14 = var_3 + var_12 * 0.5;
    var_0._id_9E8B = var_14;
  }

  var_15 = anglesToForward((0, var_0._id_EF6C, 0));
  var_16 = level._id_E34D;
  var_16 = _id_0818::_id_34F7(var_16);

  foreach(var_18 in var_16) {
    var_19 = var_0._id_9E8B - var_18.origin;
    var_20 = vectordot(var_19, var_15);
    var_18._id_5FE2 = scripts\engine\utility::ter_op(var_20 > 0, "allies", "axis");
  }

  return 1;
}

_id_FC71() {
  var_0 = isDefined(level._id_9BDA) && isDefined(level._id_9BD1);
  var_1 = _id_07A9::_id_1768();

  if(!var_0 && !var_1) {
    return;
  }
  var_2 = _id_6A70();

  if(!isDefined(var_2._id_979D) && isDefined(level._id_9BD1)) {
    var_2._id_979D = [];
    var_2._id_979D["alliesCenter"] = [[level._id_9BD1]]();
    var_2._id_979D["axisCenter"] = [[level._id_9BD1]]();
  }

  if(!var_2.isactive["allies"] && !var_2.isactive["axis"]) {
    return;
  }
  var_3 = (var_2._id_9E8B[0], var_2._id_9E8B[1], level._id_9AAC[2]);
  var_4 = anglestoright((0, var_2._id_EF6C, 0));
  _id_9796(var_3, var_4, var_2.isactive["allies"], var_2.isactive["axis"]);

  if(isDefined(level._id_9BDA)) {
    var_5 = scripts\engine\utility::ter_op(var_2.isactive["axis"], var_2._id_1FE2, (10000, 10000, 10000));
    [[level._id_9BDA]](var_2._id_979D["axisCenter"], "axis", "ANCHOR", var_5[0], var_5[1], gettime());
    var_6 = scripts\engine\utility::ter_op(var_2.isactive["allies"], var_2._id_150D, (10000, 10000, 10000));
    [[level._id_9BDA]](var_2._id_979D["alliesCenter"], "allies", "ANCHOR", var_6[0], var_6[1], gettime());
  }
}

_id_9796(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_9BDA)) {
    var_4 = var_0 + var_1 * 5000;
    var_5 = var_0 - var_1 * 5000;

    if(!isDefined(level._id_9BD0)) {
      level._id_9BD0 = [[level._id_9BD1]]();
    }

    var_6 = undefined;

    if(var_2 && var_3) {
      var_6 = "FRONT_LINE";
    } else {
      var_6 = scripts\engine\utility::ter_op(var_2, "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level._id_9BDA]](level._id_9BD0, "allies", var_6, var_4[0], var_4[1], gettime(), undefined, var_5[0], var_5[1]);
  }
}

_id_6A5C(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }
    if(!var_3 scripts\mp\utility\player::_id_898A()) {
      continue;
    }
    if(var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = scripts\mp\utility\entity::_id_68F1(var_1);
  return var_5;
}

_id_CA3D(var_0) {
  if(!_id_41F2()) {
    return;
  }
  var_1 = _id_6A70();
  var_1.isactive[var_0] = 1;

  if(getdvarint("#x39a9c4d7485d3bbc") == 0) {
    return;
  }
  var_2 = getdvarint("#x377d48b16c892f6ce", 0);

  if(var_2 == 0) {
    var_2 = 4;
  }

  var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  var_4 = 0;
  var_5 = level._id_E34D;
  var_5 = _id_0818::_id_34F7(var_5);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7._id_5FE2) || var_7._id_5FE2 != var_0) {
      continue;
    }
    if(!isDefined(var_7._id_5FF9) || !isDefined(var_7._id_5FF9[var_3]) || var_7._id_5FF9[var_3] <= 0) {
      var_4++;
    }
  }

  var_9 = var_4 / var_5.size;

  if(var_4 < var_2 || var_9 < 0.0) {
    if(var_4 < var_2) {
      var_1._id_4AA7[var_0] = 0;
    } else {
      var_1._id_4AA7[var_0] = 1;
    }

    var_1.isactive[var_0] = 0;
  }
}

_id_41F2() {
  return istrue(level._id_E2F4._id_5FE0[level._id_E2F4._id_0F5E]);
}

_id_6A70() {
  if(!isDefined(level._id_5FDF)) {
    level._id_5FDF = spawnStruct();
    level._id_5FDF.isactive = [];
    level._id_5FDF.isactive["allies"] = 0;
    level._id_5FDF.isactive["axis"] = 0;
    level._id_5FDF._id_FDAC = 0.0;
    level._id_5FDF._id_4EBB = 0.0;
    level._id_5FDF._id_3BEC = 0;
    level._id_5FDF._id_FF00 = 0;
  }

  return level._id_5FDF;
}

_id_BB80(var_0) {
  if(var_0._id_F37B[self.team] == 0) {
    return 0;
  }

  var_1 = var_0._id_4BBB[self.team] / var_0._id_F37B[self.team];
  var_1 = min(var_1, 3240000);
  var_0._id_1755._id_1622 = var_1;
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

_id_BB83(var_0) {
  var_1 = min(var_0._id_9EB9[self.team], 3240000);
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

_id_1FAA(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\utility\teams::_id_6A01(self.team)[0];
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0._id_F37B[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  foreach(var_4 in var_2) {
    if(var_0._id_9EB9[var_4] < 250000) {
      return 0;
    }
  }

  var_8 = 0;
  var_9 = 0;

  foreach(var_4 in var_2) {
    var_8 = var_8 + var_0._id_4BBC[var_4];
    var_9 = var_9 + var_0._id_F37B[var_4];
  }

  var_12 = var_8 / var_9;
  var_12 = min(var_12, 7290000);
  var_13 = var_12 / 7290000;
  var_0._id_1755._id_5405 = var_12;
  return var_13 * 100;
}

_id_1FAB(var_0) {
  var_1 = undefined;

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  } else {
    var_1 = "all";
  }

  if(var_0._id_9EB9[var_1] < level._id_542A) {
    return 0;
  }

  return 100;
}

_id_1FA5(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\utility\teams::_id_6A01(self.team)[0];
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0._id_F37B[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  var_6 = 0;

  foreach(var_4 in var_2) {
    if(var_0._id_9EB9[var_4] < 250000) {
      return 0;
    }

    var_8 = min(var_0._id_9EB9[var_4], 3240000);
    var_9 = var_8 / 3240000;
    var_6 = var_6 + var_9 * 100;
  }

  return var_6 / var_2.size;
}

_id_1FA6(var_0) {
  var_1 = level._id_E2F4._id_0F5D._id_5899["closestEnemyInfluenceDistSq"];
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  var_3 = 0;

  foreach(var_5 in level._id_EF6A[var_2]["players"]) {
    var_6 = distancesquared(var_0.origin, var_5.origin);

    if(var_6 < var_3) {
      var_3 = var_6;
    }
  }

  if(var_3 < 250000) {
    return 0;
  }

  var_8 = min(var_3, var_1);
  var_9 = var_8 / var_1;
  return var_9 * 100;
}

_id_BB84(var_0) {
  var_1 = level._id_E2F4._id_0F5D._id_5899["preferredDomPoints"];
  var_2 = level._id_E2F4._id_0F5D._id_5899["secondaryDomPoints"];
  var_3 = var_0._id_CF35;

  if(isDefined(var_3._id_4D2A)) {
    if(var_3._id_4D2A &var_1) {
      return 100;
    } else if(var_3._id_4D2A &var_2) {
      return 50.0;
    }
  }

  return 0;
}

_id_BB82(var_0) {
  var_1 = level._id_E2F4._id_0F5D._id_5899["closestPoints"];

  foreach(var_3 in var_1) {
    if(var_0 == var_3) {
      return 100;
    }
  }

  return 0;
}

_id_BB81(var_0, var_1) {
  if(isDefined(var_0._id_EF64) && var_0._id_EF64 == var_1) {
    return 100;
  }

  return 0;
}

_id_BB8A(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  var_2 = 1.0 - var_0._id_9CA1[var_1];
  var_3 = _id_0817::_id_6B3B();
  var_4 = var_2 * var_3;

  if(var_4 > 600) {
    var_5 = (var_3 - var_4) / (var_3 - 600);
    return 100 * var_5;
  } else {
    var_5 = var_4 / 600;
    return 100 * var_5;
  }
}

_id_1FBB(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  var_2 = 1.0 - var_0._id_9CA1[var_1];
  var_0._id_1755._id_9C6A = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

_id_1FBC(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  var_2 = 1.0 - var_0._id_9C7D[var_1];
  var_0._id_1755._id_9C7C = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

_id_1FBE(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  var_2 = 1.0 - var_0._id_9C7D[var_1];
  var_3 = var_2 * _id_0817::_id_6B3B();

  if(var_3 < 300) {
    return 0;
  } else {
    return 100;
  }
}

_id_C017(var_0) {
  var_0._id_1755._id_C016 = randomintrange(0, 99);
  return var_0._id_1755._id_C016;
}

_id_9C94(var_0) {
  return 3240000;
}

_id_BB90(var_0) {
  var_1 = level._id_E2F4._id_0F5D;
  var_2 = var_1._id_5899["activeKOTHZoneNumber"];
  var_3 = var_0._id_CF35._id_4BB9[var_2];
  var_4 = var_1._id_5899["maxSquaredDistToObjective"];
  var_5 = 1.0 - var_3 / var_4;
  return 100 * var_5 + 0;
}

_id_1FA7(var_0) {
  var_1 = level._id_E2F4._id_0F5D;
  var_2 = var_1._id_5899["activeKOTHZoneNumber"];
  var_3 = var_0._id_CF35._id_4BB9[var_2];
  var_4 = var_1._id_5899["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var_3 < var_4, 0, 100);
}

_id_BB87(var_0) {
  var_1 = level._id_E2F4._id_90A0[self.team];

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_2 = int(min(var_2, 9000000));
  var_3 = 1.0 - var_2 / 9000000;
  return 100 * var_3 + 0;
}

_id_BB86(var_0) {
  var_1 = level._id_E2F4;
  var_2 = -1;

  foreach(var_4 in var_1._id_EF68[self.team]._id_3A0A) {
    if(var_4.players.size <= 1) {
      continue;
    }
    var_5 = distance2dsquared(var_4._id_3385, var_0.origin);

    if(var_2 < 0 || var_5 < var_2) {
      var_2 = var_5;
    }
  }

  if(var_2 < 0) {
    return 0;
  }

  if(var_2 < 10000) {
    return 100;
  }

  var_2 = int(min(var_2, 9000000));
  var_7 = 1.0 - (var_2 - 10000) / 8990000;
  return 100 * var_7 + 0;
}

_id_BB89(var_0) {
  var_1 = level._id_E2F4;
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::_id_6A01(self.team)[0];
  }

  if(!isDefined(var_1._id_A928[var_2])) {
    return 0;
  }

  if((var_0._id_8EAC &var_1._id_A928[var_2]) != 0) {
    return 100;
  } else {
    return 0;
  }
}

_id_BB91(var_0) {
  var_1 = level._id_E2F4;
  var_2 = _id_0817::_id_6D5E(self);
  var_3 = "all";

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::_id_6A01(var_2)[0];
  }

  if(!isDefined(var_1._id_A928[var_3])) {
    return 0;
  }

  var_4 = var_0._id_8EAC &var_1._id_A928[var_3];
  var_5 = isDefined(var_1._id_A928[var_2]) && var_0._id_8EAC &var_1._id_A928[var_2];

  if(var_4 && !var_5) {
    return 100;
  } else {
    return 0;
  }
}

_id_CF94(var_0) {
  return 0;
}

_id_BB88(var_0) {
  var_1 = level._id_E2F4._id_0F5D;
  var_2 = var_1._id_5899["singlePointPos"];
  var_3 = var_1._id_5899["minDistToSinglePointSq"];
  var_4 = var_1._id_5899["maxDistToSinglePointSq"];
  var_5 = var_1._id_5899["distRangeToSinglePointSq"];
  var_6 = distance2dsquared(var_2, var_0.origin);

  if(var_6 >= var_4) {
    return 0;
  }

  if(var_6 <= var_3) {
    return 100;
  }

  var_7 = 1.0 - (var_6 - var_3) / var_5;
  return 100 * var_7;
}

_id_1FB8(var_0) {
  var_1 = level._id_E2F4._id_0F5D;
  var_2 = var_1._id_5899["juggPos"];
  var_3 = var_1._id_5899["rugbyFieldDir2D"];
  var_4 = (var_0.origin - var_2) * (1, 1, 0);
  var_5 = vectordot(var_4, var_3);

  if(var_5 >= 0) {
    return 0;
  }

  return 100;
}

_id_AAD3(var_0) {
  var_1 = var_0._id_CF35;

  if(istrue(var_1._id_FE3A)) {
    return 0;
  } else {
    return 100;
  }
}