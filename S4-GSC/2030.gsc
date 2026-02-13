/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2030.gsc
*************************************************/

init() {
  if(getdvarint("#x366fca6702ea24ddf") != 0 && !isDefined(game["gamestarted"])) {
    _func_01E0("ddl/mp/matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(level._id_74C4) {
      var_0 = scripts\mp\utility\game::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var_0);
    } else
      setmatchdata("commonMatchData", "gametype", scripts\mp\utility\game::getgametype());

    setmatchdata("commonMatchData", "build_version", _func_007E());
    setmatchdata("commonMatchData", "build_number", _func_007D());
    setmatchdata("commonMatchData", "is_private_match", scripts\mp\utility\game::privatematch());
    setmatchdata("firstOvertimeRoundIndex", -1);

    if(scripts\mp\utility\game::_id_8932()) {
      setmatchdata("codESportsRules", 1);
    }
  }

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    if(level.gametype == "br") {
      level._id_9C85 = 200;
    } else {
      level._id_9C85 = 30;
    }
  } else
    level._id_9C85 = 0;

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
  level._id_9BBC = ::_id_AB91;
  level._id_9BB4 = ::_id_97A4;
  level._id_9BB5 = ::_id_97A8;
  level._id_9BB6 = ::_id_97A9;
  level._id_9BBD = ::_id_C14E;
  level._id_9BB0 = ::_id_9755;
  level._id_9BAD = ::_id_2D1E;
  level._id_9BB2 = ::_id_975B;
  level._id_9BB1 = ::_id_9759;
  level thread _id_5330();
}

_id_AB91() {
  level._id_5350 = _func_00D7();
  setmatchdata("commonMatchData", "utc_end_time_s", level._id_5350);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\mp\rank::_id_6A74()));
  setmatchdata("globalWeaponXpModifier", int(_id_0826::_id_6A75()));
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

_id_A14E() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread _id_A14F();
    var_0 = self._id_8FC2;
    var_0 = scripts\mp\utility\weapon::_id_9ACB(var_0);
    var_1 = getcompleteweaponname(var_0);
    thread scripts\mp\gamelogic::_id_F13D(var_1, 1, "trigger_pulls");
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

_id_97A8(var_0, var_1, var_2, var_3) {
  if(!_id_8AE1(self)) {
    return;
  }
  if(!isDefined(var_0) && var_2 == "MOD_FALLING") {
    var_0 = self;
  }

  var_4 = getweaponbasename(var_3);

  if(var_4 == "agent_mp") {
    var_5 = [];
  } else {
    var_5 = scripts\mp\utility\weapon::_id_6E69(var_3);
    var_5 = scripts\mp\utility\weapon::_id_1DB3(var_5, var_3);
  }

  var_6 = _id_6DE4(gettime());
  var_7 = 0;

  if(isDefined(var_0._id_E393)) {
    var_7 = var_0._id_E393;
  }

  var_8 = _id_6DE4(var_7);
  var_9 = 0;

  if(isDefined(self._id_E393)) {
    var_9 = self._id_E393;
  }

  var_10 = _id_6DE4(var_9);
  var_11 = -1;
  var_12 = -1;
  var_13 = [];

  if(_id_8AE1(var_0)) {
    var_14 = var_0;
    var_15 = var_0 scripts\mp\utility\weapon::_id_897E(var_3);
    var_16 = var_0 _meth_8543(var_3);

    if(scripts\mp\utility\weapon::_id_8799(var_3)) {
      var_17 = var_0 playerads();
    } else {
      var_17 = 0.0;
    }

    var_18 = 0.4226;
    var_19 = scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0.origin, var_18);
    var_20 = scripts\engine\utility::_id_10E76(var_0.origin, var_0.angles, self.origin, var_18);
    var_21 = var_0 _id_A1C1();
    var_22 = var_0.origin;
    var_23 = var_0.angles;

    if(isDefined(var_0._id_9BC0)) {
      var_11 = var_0._id_9BC0;
    }

    if(isDefined(var_0._id_9678)) {
      var_12 = var_0._id_9678;
    }

    var_24 = var_0 _id_6C44();

    if(istrue(var_24[0])) {
      var_13[var_13.size] = "UAV_ACTIVE";
    }

    if(istrue(var_24[1])) {
      var_13[var_13.size] = "DEADSILENCE_ACTIVE";
    }

    if(istrue(var_24[2])) {
      var_13[var_13.size] = "HAS_STOPPING_POWER";
    }

    var_25 = var_0 _id_6C4A();

    if(istrue(var_25[0])) {
      var_13[var_13.size] = "CUAV_ACTIVE";
    }

    if(istrue(var_25[1])) {
      var_13[var_13.size] = "IS_MARKED";
    }

    if(istrue(var_25[2])) {
      var_13[var_13.size] = "IS_FLASHED";
    }

    if(istrue(var_25[3])) {
      var_13[var_13.size] = "IS_STUNNED";
    }

    if(istrue(var_25[4])) {
      var_13[var_13.size] = "IN_GAS";
    }

    if(istrue(var_25[5])) {
      var_13[var_13.size] = "IN_BURNING";
    }

    if(istrue(var_25[6])) {
      var_13[var_13.size] = "IS_SNAPSHOTTED";
    }

    if(istrue(var_25[7])) {
      var_13[var_13.size] = "IN_SMOKE";
    }

    if(istrue(var_25[8])) {
      var_13[var_13.size] = "IS_EMPED";
    }

    if(istrue(var_25[9])) {
      var_13[var_13.size] = "IN_WHITE_PHOSPHOROUS";
    }

    if(var_0 _meth_8632()) {
      var_13[var_13.size] = "NVG_ENABLED";
    }

    if(scripts\mp\utility\weapon::_id_88F6(var_4)) {
      var_13[var_13.size] = "KILLSTREAK";
    }
  } else {
    var_14 = undefined;
    var_4 = "";
    var_15 = 0;
    var_16 = 0;
    var_17 = 0.0;
    var_19 = 0;
    var_20 = 0;
    var_21 = "MOUNT_NONE";
    var_22 = [];
    var_22[0] = 0.0;
    var_22[1] = 0.0;
    var_22[2] = 0.0;
    var_23 = [];
    var_23[0] = 0.0;
    var_23[1] = 0.0;
    var_23[2] = 0.0;
  }

  var_26 = [];
  var_27 = _id_6C44();

  if(istrue(var_27[0])) {
    var_26[var_26.size] = "UAV_ACTIVE";
  }

  if(istrue(var_27[1])) {
    var_26[var_26.size] = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var_27[2])) {
    var_26[var_26.size] = "HAS_STOPPING_POWER";
  }

  var_28 = _id_6C4A();

  if(istrue(var_28[0])) {
    var_26[var_26.size] = "CUAV_ACTIVE";
  }

  if(istrue(var_28[1])) {
    var_26[var_26.size] = "IS_MARKED";
  }

  if(istrue(var_28[2])) {
    var_26[var_26.size] = "IS_FLASHED";
  }

  if(istrue(var_28[3])) {
    var_26[var_26.size] = "IS_STUNNED";
  }

  if(istrue(var_28[4])) {
    var_26[var_26.size] = "IN_GAS";
  }

  if(istrue(var_28[5])) {
    var_26[var_26.size] = "IN_BURNING";
  }

  if(istrue(var_28[6])) {
    var_26[var_26.size] = "IS_SNAPSHOTTED";
  }

  if(istrue(var_28[7])) {
    var_26[var_26.size] = "IN_SMOKE";
  }

  if(istrue(var_28[8])) {
    var_26[var_26.size] = "IS_EMPED";
  }

  if(istrue(var_28[9])) {
    var_26[var_26.size] = "IN_WHITE_PHOSPHOROUS";
  }

  if(self _meth_8632()) {
    var_26[var_26.size] = "NVG_ENABLED";
  }

  var_29 = undefined;
  var_30 = [];
  var_31 = "";

  if(isDefined(self._id_90CE)) {
    var_29 = self._id_90CE;
    var_30 = scripts\mp\utility\weapon::_id_6E69(var_29);
    var_30 = scripts\mp\utility\weapon::_id_1DB3(var_30, var_29);
    var_31 = getweaponbasename(var_29);
    var_32 = scripts\mp\utility\weapon::_id_897E(var_29);
    var_33 = self _meth_8543(var_29, 0, 1);
    var_34 = self playerads();
  } else {
    var_32 = 0;
    var_33 = 0;
    var_34 = 0.0;
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_31)) {
    var_26[var_26.size] = "KILLSTREAK";
  }

  var_35 = _id_A1C1();
  var_36 = self._id_9BC0;
  var_37 = -1;

  if(isDefined(self._id_9678)) {
    var_37 = self._id_9678;
  }

  var_38 = 0;

  if(isDefined(self.pers["summary"]["xp"])) {
    var_39 = self.pers["summary"]["xp"];
    var_38 = var_39 - self.pers["xpAtLastDeath"];
    self.pers["xpAtLastDeath"] = var_39;
  }

  var_40 = self._id_038F - self.pers["scoreAtLastDeath"];
  self.pers["scoreAtLastDeath"] = self._id_038F;
  var_41 = -1;

  if(scripts\mp\utility\game::isroundbased()) {
    var_41 = game["roundsPlayed"];

    if(var_2 == "MOD_GAME_ENDED" || var_2 == "MOD_ROUND_ENDED") {
      var_41--;

      if(var_41 < 0) {
        var_41 = 0;
      }
    }
  }

  var_42 = 0;

  if(isDefined(var_0) && isDefined(var_0._id_9FFB)) {
    var_42 = istrue(var_0._id_9FFB["hipfire"]);
  }

  self _meth_870F("dlog_event_mp_damage", ["attacker", var_14, "damage_time_from_match_start_ms", var_6, "attacker_spawn_time_from_match_start_ms", var_8, "victim_spawn_time_from_match_start_ms", var_10, "victim_weapon", var_31, "victim_weapon_attachments", var_30, "attacker_weapon", var_4, "attacker_weapon_attachments", var_5, "victim_pos_x", self.origin[0], "victim_pos_y", self.origin[1], "victim_pos_z", self.origin[2], "victim_angle_x", self.angles[0], "victim_angle_y", self.angles[1], "victim_angle_z", self.angles[2], "attacker_pos_x", var_22[0], "attacker_pos_y", var_22[1], "attacker_pos_z", var_22[2], "attacker_angle_x", var_23[0], "attacker_angle_y", var_23[1], "attacker_angle_z", var_23[2], "means_of_death", var_2, "attacker_weapon_alt_mode", var_16, "attacker_weapon_picked_up", var_15, "victim_weapon_alt_mode", var_33, "victim_weapon_picked_up", var_32, "attacker_ads_value", var_17, "victim_ads_value", var_34, "attacker_was_in_victim_fov", var_19, "victim_was_in_attacker_fov", var_20, "attacker_mount_type", var_21, "victim_mount_type", var_35, "xp_earned", var_38, "score_earned", var_40, "victim_life_index", var_36, "victim_loadout_index", var_37, "attacker_life_index", var_11, "attacker_loadout_index", var_12, "victim_was_reloading", self _meth_81E0(), "victim_was_executing", self _meth_86C8(), "round", var_41, "is_hipfire", var_42, "damage", var_1]);

  if(_id_8AE1(var_0)) {
    _func_0396(self getxuid(), var_0 getxuid(), var_3, var_2 == "MOD_HEAD_SHOT");

    if(isDefined(level._id_9BDA)) {
      var_43 = gettime();
      [[level._id_9BDA]](self._id_399D, self.team, "DEATH", self.origin[0], self.origin[1], var_43);

      if(issubstr(tolower(var_2), "bullet") && isDefined(var_3) && !scripts\mp\utility\weapon::_id_88F6(var_3)) {
        [[level._id_9BDA]](var_0._id_399D, var_0.team, "BULLET", var_0.origin[0], var_0.origin[1], var_43, undefined, self.origin[0], self.origin[1]);
      }
    }
  }
}

_id_6C44() {
  var_0 = [];
  var_0[0] = ::scripts\cp_mp\utility\killstreak_utility::_id_EF77(self.team);
  var_0[1] = ::scripts\mp\utility\perk::_hasperk("specialty_quieter");
  var_0[2] = ::scripts\mp\utility\perk::_hasperk("specialty_bulletdamage");
  return var_0;
}

_id_6C4A() {
  var_0 = gettime();
  var_1 = [];
  var_1[0] = ::scripts\cp_mp\utility\killstreak_utility::_id_5413(self.team);
  var_1[1] = _id_09B5::_id_8A90();
  var_1[2] = istrue(self._id_5C96);
  var_1[3] = istrue(self._id_3B5C);
  var_1[4] = isDefined(self._id_61DD) && self._id_61DD.size > 0 || isDefined(self._id_8FDB) && self._id_8FDB + 5000 > var_0;
  var_1[5] = isDefined(self._id_2D8D) || isDefined(self._id_8F9E) && self._id_8F9E + 5000 > var_0;
  var_1[6] = isDefined(self._id_9049) && self._id_9049 + 5000 > var_0;
  var_1[7] = isDefined(self._id_8FF7) && self._id_8FF7 + 5000 > var_0;
  var_1[8] = istrue(self._id_5191);
  var_1[9] = istrue(self._id_10FA0);
  return var_1;
}

_id_411F() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!self _meth_85AD()) {
    return;
  }
  var_0 = scripts\mp\utility\game::getgametype();
  var_1 = scripts\mp\utility\stats::_id_6C29("kills");
  var_2 = scripts\mp\utility\stats::_id_6C29("deaths");
  var_3 = scripts\mp\utility\stats::_id_6C29("headshots");
  var_4 = scripts\mp\utility\stats::_id_6C29("assists");
  var_5 = scripts\mp\utility\stats::_id_6C29("suicides");
  var_6 = scripts\mp\utility\stats::_id_6C29("score");
  var_7 = scripts\mp\rank::getrankxp();
  var_8 = scripts\mp\rank::getrankforxp(var_7);
  var_9 = scripts\mp\utility\stats::_id_6C29("utc_connect_time_s");

  if(!isDefined(var_9) && isDefined(self.pers["telemetry"]) && isDefined(self.pers["telemetry"].utc_connect_time_s)) {
    var_9 = self.pers["telemetry"].utc_connect_time_s;
  }

  var_10 = 0;

  if(isDefined(var_9)) {
    var_10 = _func_00D7() - var_9;
  }

  self _meth_8749(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_8, var_10);
}

_id_97A9(var_0) {
  if(!_id_8AE1(self)) {
    return;
  }
  _id_411F();

  if(!isai(self) && !scripts\mp\utility\game::rankingenabled()) {
    var_1 = scripts\mp\rank::_id_411C(self);
    scripts\mp\rank::_id_411D(self._id_4120, var_1);
  }

  self _meth_8723();
  self _meth_87B4();
}

_id_5330() {
  level waittill("game_ended", var_0);

  foreach(var_2 in level.players) {
    wait 0.05;

    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_10DDD)) {
      var_2 _id_4E9B();
      var_3 = 0;

      if(var_2._id_10DDD.size > 3) {
        for(var_4 = var_2._id_10DDD.size - 1; var_4 > var_2._id_10DDD.size - 3; var_4--) {
          var_2 setplayerdata("common", "round", "weaponsUsed", var_3, var_2._id_10DDD[var_4]);
          var_2 setplayerdata("common", "round", "weaponXpEarned", var_3, var_2._id_10DED[var_4]);
          var_3++;
        }
      } else {
        for(var_4 = var_2._id_10DDD.size - 1; var_4 >= 0; var_4--) {
          var_2 setplayerdata("common", "round", "weaponsUsed", var_3, var_2._id_10DDD[var_4]);
          var_2 setplayerdata("common", "round", "weaponXpEarned", var_3, var_2._id_10DED[var_4]);
          var_3++;
        }
      }
    } else {
      var_2 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_2 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_2 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_2 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_2 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_2 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_2._id_33B3)) {
      var_2 setplayerdata("common", "round", "challengeNumCompleted", var_2._id_33B3.size);
    } else {
      var_2 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_4 = 0; var_4 < 20; var_4++) {
      if(isDefined(var_2._id_33B3) && isDefined(var_2._id_33B3[var_4]) && var_2._id_33B3[var_4] != "ch_prestige" && !issubstr(var_2._id_33B3[var_4], "_daily") && !issubstr(var_2._id_33B3[var_4], "_weekly")) {
        var_2 setplayerdata("common", "round", "challengesCompleted", var_4, var_2._id_33B3[var_4]);
        continue;
      }

      var_2 setplayerdata("common", "round", "challengesCompleted", var_4, "ch_none");
    }

    var_5 = tolower(getDvar("#x376847958d67972ef"));
    var_2 setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
    var_2 setplayerdata("common", "round", "map", var_5);
  }
}

_id_C14E() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = tolower(getDvar("#x376847958d67972ef"));

    foreach(var_2 in level.players) {
      for(var_3 = 4; var_3 > 0; var_3--) {
        var_4 = var_2 getplayerdata(level.progressiongroup, "mapsPlayed", var_3 - 1);
        var_2 setplayerdata(level.progressiongroup, "mapsPlayed", var_3, var_4);
      }

      var_2 setplayerdata(level.progressiongroup, "mapsPlayed", 0, var_0);
    }
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