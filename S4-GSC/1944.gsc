/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1944.gsc
*************************************************/

init() {
  if(!isDefined(level._id_B02D) && !scripts\common\utility::iscp()) {
    level thread _id_1F26();
  }

  level._id_B02D = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/petWatchTable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = spawnStruct();
    var_2._id_B036 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 2));
    var_2._id_26AB = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 3));
    var_2._id_26C1 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 4));
    var_2._id_49CF = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 5));
    var_2._id_F9B0 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 6));
    var_2._id_7B9D = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 7));
    var_2._id_26AC = tablelookupbyrow("mp/petWatchTable.csv", var_0, 8);
    var_2._id_26C2 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 9));
    var_2._id_49D0 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 10));
    var_2._id_F9B1 = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 11));
    var_2._id_7B9E = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 12));
    level._id_B02D[var_1] = var_2;
    var_0++;
  }

  level._id_B02F = [];
  level._id_B02F["assist"] = 1;
  level._id_B02F["longshot"] = 1;
  level._id_B02F["pointblank"] = 1;
  level._id_B02F["headshot"] = 1;
  level._id_B02F["avenger"] = 1;
  level._id_B02F["save_teammate"] = 1;
  level._id_B02F["posthumous"] = 1;
  level._id_B02F["revenge"] = 1;
  level._id_B02F["firstblood"] = 1;
  level._id_B02F["comeback"] = 1;
  level._id_B02F["backfire"] = 1;
  level._id_B02F["quad_feed"] = 1;
  level._id_B02F["first_place_kill"] = 1;
  level._id_B02F["gun_butt"] = 1;
  level._id_B02F["mode_x_wipeout"] = 1;
  level._id_B02F["grenade_double"] = 1;
}

_id_1F26() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1._id_B030)) {
        var_1 _id_59F6();
      }
    }

    wait 1;
  }
}

_id_D6EB(var_0, var_1) {
  self setclientomnvar("ui_pet_watch_action", var_0 * -1);
  self._id_B030._id_B032 = var_0;
  _id_FD78();
}

_id_4C34(var_0) {
  switch (var_0) {
    case 1:
      _id_7233();
      break;
    case 2:
      _id_59F6();
      break;
    case 3:
      thread _id_FCEF();
      break;
    case 4:
      _id_8258(1);
      break;
  }
}

_id_7233() {
  var_0 = level._id_B02D[self._id_B030._id_B032]._id_B036;
  self._id_B030._id_7234 = var_0;
  _id_44F9(var_0);
}

_id_AB06() {
  self._id_B030 = undefined;
}

_id_8258(var_0, var_1) {
  if(!isDefined(self._id_B030)) {
    self setclientomnvar("ui_pet_watch_state", 0);
    self._id_B030 = spawnStruct();
    self._id_B030._id_B031 = var_1;

    if(var_1 == "pet_black") {
      self._id_B030._id_B68B = "petWatchDataBlack";
    } else {
      self._id_B030._id_B68B = "petWatchData";
    }

    if(var_0) {
      self setclientomnvar("ui_pet_watch_action", -1);
      _id_D648(0);
    } else
      _id_D648(self getplayerdata("common", self._id_B030._id_B68B, "phase"));
  } else {
    if(var_0) {
      self setclientomnvar("ui_pet_watch_action", -1);
      _id_D648(0);
    }

    if(self._id_B030._id_B032 == 0) {
      _id_C62D(1);
    }

    if(!istrue(var_0)) {
      return;
    }
  }

  self._id_B030._id_4504 = 0;

  if(self._id_B030._id_B032 == 0) {
    _id_C62D(1);
  } else {
    self._id_B030._id_26A9 = 0;
    self._id_B030._id_26AA = 0;
    self._id_B030._id_90B3 = self getplayerdata("common", self._id_B030._id_B68B, "lastUpdateTime");
    self._id_B030._id_26BF = self getplayerdata("common", self._id_B030._id_B68B, "boredDmg");
    self._id_B030._id_49CE = self getplayerdata("common", self._id_B030._id_B68B, "dirtyDmg");
    self._id_B030._id_F9AF = self getplayerdata("common", self._id_B030._id_B68B, "unrulyDmg");
    self._id_B030._id_7B9C = self getplayerdata("common", self._id_B030._id_B68B, "hungryDmg");
    self._id_B030._id_26AA = self getplayerdata("common", self._id_B030._id_B68B, "bonusTime");
    self._id_B030._id_340E = self getplayerdata("common", self._id_B030._id_B68B, "charged");
    self._id_B030._id_7234 = self getplayerdata("common", self._id_B030._id_B68B, "growthTime");
    self._id_B030._id_C563 = self getplayerdata("common", self._id_B030._id_B68B, "reproductionStreak");
    self._id_B030.damage = self getplayerdata("common", self._id_B030._id_B68B, "damage");
    self._id_B030._id_8F9A = self._id_B030._id_26BF;
    self._id_B030._id_8FBE = self._id_B030._id_49CE;
    self._id_B030._id_90B1 = self._id_B030._id_F9AF;
    self._id_B030._id_8FF2 = self._id_B030._id_7B9C;
    var_2 = self._id_B030._id_C563 % 10;
    var_3 = var_2 / 10;
    self._id_B030._id_7234 = self._id_B030._id_7234 + var_3;
    self._id_B030._id_26AA = self._id_B030._id_26AA + var_3;
    self._id_B030._id_C563 = int(self._id_B030._id_C563 / 10);
    self._id_B030._id_F949 = self getplayerdata("common", self._id_B030._id_B68B, "orcaPoints");
    self._id_B030._id_FF70 = self getplayerdata("common", self._id_B030._id_B68B, "apachePoints");
    self._id_B030._id_4ED9 = self getplayerdata("common", self._id_B030._id_B68B, "dragonPoints");
    self._id_B030._id_26A5 = self getplayerdata("common", self._id_B030._id_B68B, "killstreakCharge");
    self._id_B030._id_26AD = self getplayerdata("common", self._id_B030._id_B68B, "winGamesCharge");
    self._id_B030._id_26A6 = self getplayerdata("common", self._id_B030._id_B68B, "objectiveScoreCharge");
    self._id_B030._id_26A4 = self getplayerdata("common", self._id_B030._id_B68B, "killsCharge");
    self._id_B030._id_F344 = self getplayerdata("common", self._id_B030._id_B68B, "topKillstreakCharge");
    self._id_B030._id_A72B = self getplayerdata("common", self._id_B030._id_B68B, "nukeCharge");
    self._id_B030._id_10E4D = self getplayerdata("common", self._id_B030._id_B68B, "winGamesTop3");
    self._id_B030._id_B1D9 = self getplayerdata("common", self._id_B030._id_B68B, "plantsCharge");
    self._id_B030._id_5706 = self getplayerdata("common", self._id_B030._id_B68B, "executionsCharge");
    self._id_B030._id_A8ED = 0;
    self._id_B030._id_8DC8 = 0;
    self._id_B030._id_10E4C = 0;
    self._id_B030._id_8D99 = 0;
    self._id_B030._id_8FF3 = 0;
    self._id_B030._id_8F9B = 0;
    self._id_B030._id_90B2 = 0;
    self._id_B030._id_8FBF = 0;
  }

  _id_FD78();
}

_id_6AA8(var_0) {
  var_1 = 3600;
  return int(var_0 / var_1);
}

_id_6AA9(var_0) {
  var_1 = 3600;
  var_2 = 24 * var_1;
  var_3 = var_2 * 365.25;
  var_4 = var_0 / int(var_3);
  var_5 = int(var_0 % var_3) / int(var_2);
  var_6 = int(var_0 % var_2) / int(var_1);
  return int(var_6);
}

_id_F0E5() {
  var_0 = _func_00D7();
  var_1 = var_0 - 300;
  var_2 = var_0 - 7200;
  var_3 = var_0 - 3480;
  var_4 = var_0 - 3720;
  var_5 = var_0 - 43200;
  var_6 = var_0 - 86400;
  var_7 = var_6 - 43200;
  var_8 = var_0 - 604800;
  var_9 = _id_7ABD(var_0, var_1)._id_7ABC;
  var_10 = _id_7ABD(var_0, var_3)._id_7ABC;
  var_11 = _id_7ABD(var_0, var_4)._id_7ABC;
  var_12 = _id_7ABD(var_0, var_2)._id_7ABC;
  var_13 = _id_7ABD(var_0, var_5)._id_7ABC;
  var_14 = _id_7ABD(var_0, var_6)._id_7ABC;
  var_15 = _id_7ABD(var_0, var_7)._id_7ABC;
  var_16 = _id_7ABD(var_0, var_8)._id_7ABC;
  var_17 = 1;
}

_id_BD1D() {
  var_0 = self getplayerdata("common", self._id_B030._id_B68B, "phase");
  var_1 = self getplayerdata("common", self._id_B030._id_B68B, "lastUpdateTime");
  var_2 = self getplayerdata("common", self._id_B030._id_B68B, "boredDmg");
  var_3 = self getplayerdata("common", self._id_B030._id_B68B, "dirtyDmg");
  var_4 = self getplayerdata("common", self._id_B030._id_B68B, "unrulyDmg");
  var_5 = self getplayerdata("common", self._id_B030._id_B68B, "hungryDmg");
  var_6 = self getplayerdata("common", self._id_B030._id_B68B, "bonusTime");
  var_7 = self getplayerdata("common", self._id_B030._id_B68B, "charged");
  var_8 = self getplayerdata("common", self._id_B030._id_B68B, "growthTime");
  var_9 = self getplayerdata("common", self._id_B030._id_B68B, "reproductionStreak");
  var_10 = self getplayerdata("common", self._id_B030._id_B68B, "damage");
  var_11 = self getplayerdata("common", self._id_B030._id_B68B, "orcaPoints");
  var_12 = self getplayerdata("common", self._id_B030._id_B68B, "apachePoints");
  var_13 = self getplayerdata("common", self._id_B030._id_B68B, "dragonPoints");
  var_14 = self getplayerdata("common", self._id_B030._id_B68B, "killstreakCharge");
  var_15 = self getplayerdata("common", self._id_B030._id_B68B, "winGamesCharge");
  var_16 = self getplayerdata("common", self._id_B030._id_B68B, "objectiveScoreCharge");
  var_17 = self getplayerdata("common", self._id_B030._id_B68B, "killsCharge");
  var_18 = self getplayerdata("common", self._id_B030._id_B68B, "topKillstreakCharge");
  var_19 = self getplayerdata("common", self._id_B030._id_B68B, "nukeCharge");
  var_20 = self getplayerdata("common", self._id_B030._id_B68B, "winGamesTop3");
  var_21 = self getplayerdata("common", self._id_B030._id_B68B, "plantsCharge");
  var_22 = self getplayerdata("common", self._id_B030._id_B68B, "executionsCharge");
}

_id_F0DF(var_0) {
  if(!isDefined(self._id_B030)) {
    return;
  }
  switch (var_0) {
    case 1:
      _id_F0E5();
      break;
    case 2:
      _id_BD1D();
      break;
    case 3:
      _id_10DA();
      break;
    case 4:
      _id_1145();
      break;
    case 5:
      _id_1102("debug", 1);
      break;
    case 6:
      _id_1102("debug", 10);
      break;
    case 7:
      _id_1186();
      break;
    case 8:
      _id_110E();
      break;
    case 9:
      _id_10AD();
      break;
    case 10:
      _id_1187();
      break;
    case 11:
      _id_1168();
      break;
    case 12:
      _id_1101();
      break;
    case 13:
      self._id_B030.damage = 0;
      _id_FD78();
      break;
    case 14:
      self._id_B030.damage = 900;
      _id_FD78();
      break;
    case 15:
      self._id_B030.damage = 500;
      _id_FD78();
      break;
    case 16:
      _id_10DB();
      break;
  }
}

_id_7ABD(var_0, var_1, var_2) {
  var_3 = _id_6AA9(var_0);
  var_4 = _id_6AA8(var_0 - var_1);
  var_5 = max(0, var_4);
  var_6 = spawnStruct();
  var_6._id_7ABC = var_5;
  return var_6;
}

_id_FCEF(var_0) {
  self endon("disconnect");
  return;
}

_id_1101() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_A72B++;
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 10000 + self._id_B030._id_A72B);
  }
}

_id_1168() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_F344++;
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20000 + self._id_B030._id_F344);
  }
}

_id_10DB() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_26A5++;
    self._id_B030._id_8DC8++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 30000 + self._id_B030._id_8DC8);
  }
}

_id_110E() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_B1D9++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000 + self._id_B030._id_B1D9);
  }
}

_id_1102(var_0, var_1) {
  if(isDefined(self._id_B030) && (!istrue(level._id_B02F[var_0]) && !issubstr(var_0, "kill"))) {
    self._id_B030._id_26A6 = self._id_B030._id_26A6 + var_1;
    self._id_B030._id_A8ED = self._id_B030._id_A8ED + var_1;
    self setclientomnvar("ui_pet_watch_bonus_earned_3", 50000 + self._id_B030._id_A8ED);
  }
}

_id_1145() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_8D99 = self._id_B030._id_8D99 + 10;
    self._id_B030._id_26A4 = self._id_B030._id_26A4 + 10;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self._id_B030._id_8D99);
  }
}

_id_10DA() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_8D99++;
    self._id_B030._id_26A4++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self._id_B030._id_8D99);
  }
}

_id_10AD() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_5706++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 70000 + self._id_B030._id_5706);
  }
}

_id_1186() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_26AD++;
    self._id_B030._id_10E4C++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000 + self._id_B030._id_10E4C);
    _id_59F6();
  }
}

_id_1187() {
  if(isDefined(self._id_B030)) {
    self._id_B030._id_10E4D++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000 + self._id_B030._id_10E4D);
  }
}

_id_D648(var_0) {
  self._id_B030._id_B032 = var_0;
  self.pers["petWatchData_phase"] = var_0;
}

_id_FD78() {
  var_0 = 0;

  if(self._id_B030._id_26BF < 0) {
    var_0 = var_0 + 20;
  }

  if(self._id_B030._id_49CE < 0) {
    var_0 = var_0 + 100;
  }

  if(self._id_B030._id_F9AF < 0) {
    var_0 = var_0 + 1000;
  }

  if(self._id_B030._id_7B9C < 0) {
    var_0 = var_0 + 10000;
  }

  var_1 = int(self._id_B030.damage / 100) - 1;
  var_1 = int(max(0, min(var_1, 9)));
  var_0 = var_0 + 100000 * var_1;
  var_2 = var_0 + self._id_B030._id_B032;
  self setclientomnvar("ui_pet_watch_state", var_2);
}

_id_C62E() {
  self._id_B030._id_26BF = level._id_B02D[self._id_B030._id_B032]._id_26C2;
  self._id_B030._id_49CE = level._id_B02D[self._id_B030._id_B032]._id_49D0;
  self._id_B030._id_F9AF = level._id_B02D[self._id_B030._id_B032]._id_F9B1;
  self._id_B030._id_7B9C = level._id_B02D[self._id_B030._id_B032]._id_7B9E;
  self._id_B030._id_8FF3 = 0;
  self._id_B030._id_8F9B = 0;
  self._id_B030._id_90B2 = 0;
  self._id_B030._id_8FBF = 0;
  self._id_B030._id_340E = 0;
  self._id_B030._id_7234 = 0;
  self._id_B030._id_26AA = 0;
  self._id_B030._id_26A9 = 0;
  self._id_B030.damage = 0;
  self._id_B030._id_F949 = 0;
  self._id_B030._id_FF70 = 0;
  self._id_B030._id_4ED9 = 0;
  self._id_B030._id_26A5 = 0;
  self._id_B030._id_8DC8 = 0;
  self._id_B030._id_26AD = 0;
  self._id_B030._id_10E4C = 0;
  self._id_B030._id_26A6 = 0;
  self._id_B030._id_A8ED = 0;
  self._id_B030._id_26A4 = 0;
  self._id_B030._id_8D99 = 0;
  self._id_B030._id_F344 = 0;
  self._id_B030._id_A72B = 0;
  self._id_B030._id_10E4D = 0;
  self._id_B030._id_B1D9 = 0;
  self._id_B030._id_5706 = 0;
}

_id_C62D(var_0, var_1) {
  if(isDefined(var_1)) {
    _id_D648(var_1);
  } else {
    _id_D648(1);
  }

  self._id_B030._id_90B3 = _func_00D7();
  _id_C62E();
}

_id_44F9(var_0) {
  self setclientomnvar("ui_pet_watch_action", var_0);
}

_id_59F6() {
  if(!isDefined(self._id_B030)) {
    return;
  }
  if(self._id_B030._id_B032 == 15) {
    return;
  }
  var_0 = self._id_B030._id_8DC8 * 20;
  var_1 = self._id_B030._id_10E4C * 20;
  var_2 = self._id_B030._id_A8ED * 0.5;
  var_3 = self._id_B030._id_8D99 * 1;
  var_4 = self._id_B030._id_8FF3 < var_3;
  var_5 = self._id_B030._id_8FBF < var_1;
  var_6 = self._id_B030._id_8F9B < var_0;
  var_7 = self._id_B030._id_90B2 < var_2;

  if(!var_4 && !var_5 && !var_6 && !var_7) {
    return;
  }
  var_0 = max(-240, min(var_0, 240));
  var_1 = max(-240, min(var_1, 240));
  var_2 = max(-240, min(var_2, 240));
  var_3 = max(-240, min(var_3, 240));

  if(var_5) {
    var_1 = int(var_1);

    if(var_1 == 0) {
      var_1 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_dirty", var_1);
  }

  if(var_7) {
    var_2 = int(var_2);

    if(var_2 == 0) {
      var_2 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_unruly", int(var_2));
  }

  if(var_4) {
    var_3 = int(var_3);

    if(var_3 == 0) {
      var_3 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_hungry", int(var_3));
  }

  if(var_6) {
    var_0 = int(var_0);

    if(var_0 == 0) {
      var_0 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_bored", int(var_0));
  }

  self._id_B030._id_8FF3 = var_3;
  self._id_B030._id_8FBF = var_1;
  self._id_B030._id_8F9B = var_0;
  self._id_B030._id_90B2 = var_2;
  self._id_B030._id_F344 = 0;
  self._id_B030._id_A72B = 0;
  self._id_B030._id_10E4D = 0;
  self._id_B030._id_B1D9 = 0;
  self._id_B030._id_5706 = 0;
  self._id_B030._id_26BF = var_0;
  self._id_B030._id_49CE = var_1;
  self._id_B030._id_F9AF = var_2;
  self._id_B030._id_7B9C = var_3;
}