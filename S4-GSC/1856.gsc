/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1856.gsc
*************************************************/

init() {
  if(getdvarint("#x366fca6702ea24ddf") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdata("commonMatchData", "map", level.script);

    if(level._id_74C4) {
      var_0 = scripts\cp\utility::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var_0);
    } else
      setmatchdata("commonMatchData", "gametype", scripts\cp\utility::getgametype());

    setmatchdata("commonMatchData", "build_version", _func_007E());
    setmatchdata("commonMatchData", "build_number", _func_007D());
    setmatchdata("commonMatchData", "is_private_match", scripts\cp\utility::privatematch());
  }

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    level._id_9C85 = 30;
  } else {
    level._id_9C85 = 0;
  }

  level._id_9C84 = 475;
  level._id_9C8A = 26;
  level._id_9C73 = 250;
  level._id_9C80 = 64;
  level._id_9C81 = 64;
  level._id_9C8D = 10;
  level._id_9C8C = 10;
  level._id_9CAA = 50;
  level._id_9CA9 = 50;
  level._id_9CAB = 50;
  level._id_9BBF = 0;
  level thread _id_5330();
}

_id_AB91() {
  level._id_5350 = _func_00D7();
  setmatchdata("commonMatchData", "utc_end_time_s", level._id_5350);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(_id_0756::_id_6A74()));
  setmatchdata("globalWeaponXpModifier", int(_id_0776::_id_6A75()));
}

_id_6B35() {
  if(getdvarint("#x366fca6702ea24ddf") == 0) {
    return level._id_E730;
  }

  return _func_00AC("commonMatchData", "utc_start_time_s");
}

_id_6B31() {
  if(getdvarint("#x366fca6702ea24ddf") == 0) {
    return level._id_5350;
  }

  return _func_00AC("commonMatchData", "utc_end_time_s");
}

_id_6DE4(var_0) {
  var_1 = var_0;

  if(isDefined(level._id_E72F)) {
    var_1 = var_1 - level._id_E72F;

    if(var_1 < 0) {
      var_1 = 0;
    }
  } else
    var_1 = 0;

  return var_1;
}

_id_97A4(var_0, var_1) {}

_id_9797(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  if(_id_8AE1(self) && scripts\mp\utility\entity::_id_8877(self)) {
    var_2 = self;

    if(isDefined(self._id_9BC0)) {
      var_3 = self._id_9BC0;
    }
  }

  var_4 = _func_00AC("gameEventCount");
  var_5 = var_4 + 1;
  setmatchdata("gameEventCount", var_5);
  var_6 = _id_6DE4(gettime());
  _func_03BF("dlog_event_game_event", ["event_player", var_2, "event_name", var_0, "time_from_match_start_ms", var_6, "player_life_index", var_3, "pos_x", var_1[0], "pos_y", var_1[1], "pos_z", var_1[2]]);
}

_id_A14E() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread _id_A14F();
    var_0 = self._id_8FC2;
    var_0 = scripts\cp\cp_weapon::_id_9ACB(var_0);
    var_1 = getcompleteweaponname(var_0);
    thread _id_F13D(var_1, 1, "trigger_pulls");
  }
}

_id_F13D(var_0, var_1, var_2) {
  self endon("disconnect");
  waittillframeend;
  _id_D8EE(var_0, var_1, var_2);
}

_id_D8EE(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }
  var_3 = undefined;

  if(isweapon(var_0)) {
    var_3 = var_0;
  } else {
    var_3 = makeweaponfromstring(var_0);
  }

  if(scripts\cp\cp_weapon::_id_897E(var_3)) {
    return;
  }
  var_4 = var_3.basename;
  var_5 = scripts\cp\cp_weapon::getweapongroup(var_3);
  var_6 = _func_02F7(var_3);

  if(var_5 == "killstreak" || var_5 == "other" && var_4 != "trophy_mp" || var_5 == "other" && var_4 != "player_trophy_system_mp" || var_5 == "other" && var_4 != "super_trophy_mp") {
    return;
  }
  if(scripts\cp\utility::_id_8834(var_3)) {
    return;
  }
  if(var_5 == "weapon_grenade" || var_5 == "weapon_explosive" || var_4 == "trophy_mp" || var_4 == "forcepush_mp") {
    var_4 = scripts\cp\utility::_id_EA63(var_4, "_mp");
    return;
  }

  if(!isDefined(self._id_F40F)) {
    self._id_F40F = var_3;
  }

  if(var_3 != self._id_F40F) {
    self._id_F40F = var_3;
  }

  switch (var_2) {
    case "shots":
      self._id_F414++;
      break;
    case "hits":
      self._id_F412++;
      break;
    case "headShots":
      self._id_F411++;
      break;
    case "kills":
      self._id_F413++;
      break;
  }

  if(var_2 == "deaths") {
    var_7 = undefined;
    var_8 = scripts\cp\utility::getweaponrootname(var_3);

    if(!scripts\cp\cp_weapon::_id_879A(var_8) && !scripts\cp\cp_weapon::_id_879C(var_8)) {
      return;
    }
    var_9 = scripts\cp\utility::_id_6E69(var_3);

    foreach(var_11 in var_9) {}
  }
}

_id_A14F() {
  self endon("disconnect");
  self._id_90CA = gettime();
  self notify("monitorWeaponFireTime");
  self endon("monitorWeaponFireTime");
  scripts\engine\utility::_id_108C5("end_firing", "death");
  self._id_90C9 = gettime();
}

_id_A1C1() {
  var_0 = self _meth_8270();

  if(isDefined(var_0)) {
    switch (var_0) {
      case "mount_left":
        return "MOUNT_LEFT";
      case "mount_right":
        return "MOUNT_RIGHT";
      case "mount_top":
        return "MOUNT_TOP";
    }
  }

  return "MOUNT_NONE";
}

_id_6C44() {
  var_0 = [];
  var_0[0] = ::scripts\cp\utility::_hasperk("specialty_quieter");
  var_0[1] = ::scripts\cp\utility::_hasperk("specialty_bulletdamage");
  return var_0;
}

_id_6C4A() {
  var_0 = [];
  var_0[0] = istrue(self._id_5C96);
  var_0[1] = istrue(self._id_3B5C);
  var_0[2] = isDefined(self._id_61DD) && self._id_61DD.size > 0 || isDefined(self._id_8FDB) && self._id_8FDB + 5000 > gettime();
  var_0[3] = isDefined(self._id_2D8D) || isDefined(self._id_8F9E) && self._id_8F9E + 5000 > gettime();
  var_0[4] = isDefined(self._id_9049) && self._id_9049 + 5000 > gettime();
  var_0[5] = isDefined(self._id_8FF7) && self._id_8FF7 + 5000 > gettime();
  var_0[6] = istrue(self._id_5191);
  var_0[7] = istrue(self._id_10FA0);
  return var_0;
}

_id_97A9(var_0) {
  if(!_id_8AE1(self)) {
    return;
  }
  _id_0705::_id_97AC(var_0);
  self _meth_8723();
  var_1 = 0;
  var_2 = 0;

  if(!isDefined(self.pers["matchdataWeaponStats"])) {
    return;
  }
  foreach(var_15, var_4 in self.pers["matchdataWeaponStats"]) {
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(scripts\cp\utility::getgametype() != "br") {
      if(_func_030C("common", "LoadoutWeapon", var_4._id_04F6)) {
        var_5 = self getplayerdata("rankedloadouts", "squadMembers", "weapon_xp", var_4._id_04F6);
      }
    }

    foreach(var_14, var_13 in var_4._id_E76F) {
      if(var_14 == "deaths") {
        var_7 = var_7 + var_13;
      }

      if(var_14 == "headshots") {
        var_8 = var_8 + var_13;
      }

      if(var_14 == "hits") {
        var_9 = var_9 + var_13;
        var_2 = var_2 + var_13;
      }

      if(var_14 == "kills") {
        var_10 = var_10 + var_13;
      }

      if(var_14 == "shots") {
        var_11 = var_11 + var_13;
        var_1 = var_1 + var_13;
      }

      if(var_14 == "xp_earned") {
        var_6 = var_6 + var_13;
      }
    }

    if(scripts\cp\utility::getgametype() != "br") {
      self _meth_870F("dlog_event_player_weapon_stats", ["weapon", var_4._id_04F6, "variant_id", var_4._id_04CC, "loadout_index", var_4._id_9678, "starting_weapon_xp", var_5, "xp_earned", var_6, "deaths", var_7, "headshots", var_8, "hits", var_9, "kills", var_10, "shots", var_11]);
    }
  }
}

_id_97B0(var_0) {
  if(scripts\mp\utility\entity::_id_8877(self) == 0) {
    return;
  }
  if(!_id_8AE1(self)) {
    return;
  }
  if(isbot(self) || _func_03DA(self) || isai(self)) {
    return;
  }
  var_1 = _id_6DE4(gettime());
  self _meth_870F("dlog_event_player_score_event", ["time_ms_from_match_start", var_1, "score_event", var_0]);
}

_id_5330() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    wait 0.05;

    if(!isDefined(var_1)) {
      continue;
    }
    var_1 scripts\cp_mp\utility\game_utility::_id_E912();

    if(isDefined(var_1._id_10DDD)) {
      var_1 _id_4E9B();
      var_2 = 0;

      if(var_1._id_10DDD.size > 3) {
        for(var_3 = var_1._id_10DDD.size - 1; var_3 > var_1._id_10DDD.size - 3; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1._id_10DDD[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1._id_10DED[var_3]);
          var_2++;
        }
      } else {
        for(var_3 = var_1._id_10DDD.size - 1; var_3 >= 0; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1._id_10DDD[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1._id_10DED[var_3]);
          var_2++;
        }
      }
    } else {
      var_1 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_1 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_1._id_33B3)) {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", var_1._id_33B3.size);
    } else {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_3 = 0; var_3 < 20; var_3++) {
      if(isDefined(var_1._id_33B3) && isDefined(var_1._id_33B3[var_3]) && var_1._id_33B3[var_3] != "ch_prestige" && !issubstr(var_1._id_33B3[var_3], "_daily") && !issubstr(var_1._id_33B3[var_3], "_weekly")) {
        var_1 setplayerdata("common", "round", "challengesCompleted", var_3, var_1._id_33B3[var_3]);
        continue;
      }

      var_1 setplayerdata("common", "round", "challengesCompleted", var_3, "ch_none");
    }

    var_4 = tolower(getDvar("#x376847958d67972ef"));
    var_1 setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    var_1 setplayerdata("common", "round", "map", var_4);
  }
}

_id_4E9B() {
  var_0 = self._id_10DED;
  var_1 = self._id_10DED.size;

  for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(var_0[var_3 - 1] < var_0[var_3]) {
        var_4 = self._id_10DDD[var_3];
        self._id_10DDD[var_3] = self._id_10DDD[var_3 - 1];
        self._id_10DDD[var_3 - 1] = var_4;
        var_5 = self._id_10DED[var_3];
        self._id_10DED[var_3] = self._id_10DED[var_3 - 1];
        self._id_10DED[var_3 - 1] = var_5;
        var_0 = self._id_10DED;
      }
    }
  }
}

_id_8AE1(var_0) {
  if(istrue(game["isLaunchChunk"])) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  } else if(isagent(var_0)) {
    return 0;
  } else if(!isPlayer(var_0)) {
    return 0;
  }

  return 1;
}

_id_3193(var_0) {
  if(_id_8AE1(var_0)) {
    return var_0._id_399D < level._id_9C85;
  } else {
    return 0;
  }
}

_id_3195(var_0) {
  return var_0 < level._id_9C84;
}

_id_97B7(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::_id_88F6(var_0) || scripts\cp\cp_weapon::_id_8AFA(var_0)) {
    return;
  }
  if(scripts\cp\utility::getgametype() == "br") {
    return;
  }
  var_4 = var_0;

  if(isDefined(self._id_9678)) {
    var_4 = var_4 + "+loadoutIndex" + self._id_9678;
  } else {
    return;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4])) {
    self.pers["matchdataWeaponStats"][var_4] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_4]._id_E76F = [];
    self.pers["matchdataWeaponStats"][var_4]._id_04F6 = var_0;
    self.pers["matchdataWeaponStats"][var_4]._id_9678 = self._id_9678;

    if(isDefined(var_3)) {
      self.pers["matchdataWeaponStats"][var_4]._id_04CC = var_3;
    } else {
      self.pers["matchdataWeaponStats"][var_4]._id_04CC = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4]._id_E76F[var_1])) {
    self.pers["matchdataWeaponStats"][var_4]._id_E76F[var_1] = var_2;
  } else {
    self.pers["matchdataWeaponStats"][var_4]._id_E76F[var_1] = self.pers["matchdataWeaponStats"][var_4]._id_E76F[var_1] + var_2;
  }
}

_id_9755(var_0, var_1, var_2, var_3) {
  if(!level._id_9BBF) {
    return;
  }
}

_id_2D1E() {
  var_0 = [];
  var_1 = 149;

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = _func_0222("mp/statstable.csv", 0, var_2, 4);
    var_4 = _func_0222("mp/statstable.csv", 0, var_2, 2);

    if(!issubstr(var_4, "weapon_")) {
      continue;
    }
    if(var_4 == "weapon_other") {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_975B(var_0, var_1) {}

_id_9759(var_0) {
  if(!_id_8AE1(self)) {
    return;
  }
  if(isbot(self) || _func_03DA(self) || isai(self)) {
    return;
  }
  var_1 = _id_6DE4(gettime());
  self _meth_870F("dlog_event_player_award", ["time_ms_from_match_start", var_1, "award", var_0]);
}

_id_8257(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
  }
}

_id_6C29(var_0) {
  return self.pers[var_0];
}

_id_7DAE(var_0, var_1) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] = self.pers[var_0] + var_1;
  }
}

_id_D550(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A5 = var_0;
  self.pers["extrascore0"] = var_0;
}

_id_D551(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A6 = var_0;
  self.pers["extrascore1"] = var_0;
}

_id_D552(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A7 = var_0;
  self.pers["extrascore2"] = var_0;
}

_id_D553(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A8 = var_0;
  self.pers["extrascore3"] = var_0;
}

getplayerdataloadoutgroup() {
  if(level.rankedmatch) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

_id_31BA() {
  return 0;
}

_id_6D95(var_0) {
  if(_func_030C("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(_func_030C("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}