/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1797.gsc
*************************************************/

_id_820F() {
  _id_E5E8("ddl/mp/cp_matchdata.ddl", "ddl/mp/zombieclientmatchdata.ddl", "cp/cp_analytics.csv");
  level._id_F464 = 0;
  level._id_1765 = ::_id_1106C;
  level._id_C7D1 = ::_id_C7D1;
}

_id_8111(var_0) {
  var_0 endon("disconnect");

  while(!isDefined(var_0.pers)) {
    wait 1;
  }

  var_0._id_F28C = [];
  var_0._id_8DF0 = [];
  var_0._id_8B3D = " ";
  var_0._id_F214 = [];

  if(!isDefined(level._id_2C43)) {
    level._id_2C43 = 0;
  }

  if(level._id_10C9F == 0) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"]._id_F279 = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1] = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var_0.pers["timesPerWave"])) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"]._id_F279 = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F] = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1])) {
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery_afterlife"] = 0;
  }

  var_0._id_8B3E = [];
  var_0._id_8B32 = [];
  var_0._id_8B30 = " ";
  var_0._id_8B37 = " ";
  var_0._id_8B35 = " ";
  var_0._id_8B3E[var_0._id_8B35] = 0;
  var_0._id_8B32[var_0._id_8B35] = 0;

  if(!isDefined(var_0._id_F389)) {
    var_0._id_F389 = 0;
  }

  if(!isDefined(var_0._id_CBDD)) {
    var_0._id_CBDD = 0;
  }

  var_0._id_4EB5 = [];
  var_0._id_8DA4 = [];
  var_0._id_10CB8 = [];
  var_0._id_DA68 = [];
  var_0._id_DA6C = [];
  var_0._id_761D = [];
  var_0._id_F365 = 0;
  var_0._id_121F = [];
  var_0._id_10D09 = " ";
  var_0._id_0E5D = 0;
  var_0._id_0E5E = 0;
  var_0._id_57E3 = 0;
  var_0._id_F36B = 0;

  if(!isDefined(var_0._id_5784)) {
    var_0._id_5784 = 0;
  }

  var_0._id_9D91 = 0;
  var_0._id_8E56 = 0;

  if(!isDefined(var_0._id_F4BF)) {
    var_0._id_F4BF = [];
  }

  var_1 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_3 in var_1) {
    if(!isDefined(var_0._id_F4BF[var_3])) {
      var_0._id_F4BF[var_3] = 0;
    }
  }

  var_5 = var_0._id_6E8B;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_0._id_10D09 = scripts\cp\utility::_id_6902(var_7);

      if(!isDefined(var_0._id_121F[var_0._id_10D09])) {
        var_0._id_121F[var_0._id_10D09] = 0;
      }
    }
  }
}

_id_C7D1(var_0) {
  _id_9723("revived_another_player", 1, [var_0._id_399D], [var_0._id_399D], [var_0._id_399D]);
}

_id_1106C() {
  var_0 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_3, var_2 in level.players) {
    _id_9751(var_3, var_2);
    _id_972D(var_3, var_2);
  }
}

_id_972D(var_0, var_1) {
  foreach(var_5, var_3 in var_1._id_761D) {
    if(var_5 == "none" || var_5 == "" || var_3 == 0 || !scripts\engine\utility::array_contains(level._id_965B, var_5)) {
      continue;
    }
    setclientmatchdata("player", var_0, "headShots", scripts\cp\utility::_id_6902(var_5), var_3);
    var_4 = var_1 getplayerdata("cp", "headShots", scripts\cp\utility::_id_6902(var_5));
    var_1 setplayerdata("cp", "headShots", scripts\cp\utility::_id_6902(var_5), var_4 + var_3);
  }

  setclientmatchdata("player", var_0, "total_headshots", var_1._id_F365);
}

_id_9716(var_0, var_1) {
  if(!isDefined(var_1._id_3BB3)) {
    return;
  }
  if(level.gametype != "zombies") {
    return;
  }
  foreach(var_5, var_3 in var_1._id_3BB3) {
    var_4 = var_1 getplayerdata("cp", "cards_used", var_5);
    var_1 setplayerdata("cp", "cards_used", var_5, var_4 + var_3._id_F26C);
  }
}

_id_9725(var_0, var_1) {
  if(!isDefined(var_1._id_57E3)) {
    return;
  }
  var_2 = var_1 getplayerdata("cp", "explosive_kills");
  var_1 setplayerdata("cp", "explosive_kills", var_2 + var_1._id_57E3);
}

_id_9751(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  foreach(var_8, var_6 in var_1._id_121F) {
    if(var_8 == "none" || var_8 == "" || var_6 == 0 || !scripts\engine\utility::array_contains(level._id_965B, var_8)) {
      continue;
    }
    setclientmatchdata("player", var_0, "killsPerWeapon", scripts\cp\utility::_id_6902(var_8), var_6);
    var_7 = var_1 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::_id_6902(var_8));
    var_1 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::_id_6902(var_8), var_7 + var_6);

    if(var_1._id_121F[var_8] > 0 && var_2 == 0) {
      var_3 = var_1._id_121F[var_8];
      var_2 = 1;
      var_4 = scripts\cp\utility::_id_6902(var_8);
    }

    if(var_1._id_121F[var_8] > var_3) {
      var_3 = var_1._id_121F[var_8];
      var_4 = scripts\cp\utility::_id_6902(var_8);
    }
  }

  if(var_3 > 0) {
    setclientmatchdata("player", var_0, "DeadliestWeapon", var_4);
    setclientmatchdata("player", var_0, "DeadliestWeaponKills", var_3);
  }

  var_9 = var_1 getplayerdata("cp", "DeadliestWeaponName");
  var_7 = var_1 getplayerdata("cp", "DeadliestWeaponKills", var_9);

  if(var_7 < var_3) {
    if(var_3 > 0) {
      var_10 = var_1 getplayerdata("cp", "killsPerWeapon", var_4);

      if(!isDefined(var_1._id_121F[var_4])) {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      } else {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      }

      var_1 setplayerdata("cp", "DeadliestWeaponName", var_4);
    }
  } else {
    var_11 = var_1 getplayerdata("cp", "killsPerWeapon", var_9);

    if(!isDefined(var_1._id_121F[var_9])) {
      var_1 setplayerdata("cp", "DeadliestWeaponKills", var_9, var_11);
    } else {
      var_1 setplayerdata("cp", "DeadliestWeaponKills", var_9, var_1._id_121F[var_9] + var_11);
    }

    var_1 setplayerdata("cp", "DeadliestWeaponName", var_9);
  }
}

_id_E5E8(var_0, var_1, var_2) {
  init(var_2);
  _id_7FEE(var_0, var_1);
}

_id_7FEE(var_0, var_1) {
  _func_01D2(var_1);

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    _func_01E0(var_0);
    setmatchdata("commonMatchData", "map", level.script);
    setmatchdata("commonMatchData", "gametype", getDvar("#x3a30c33efc8281eb1"));
    setmatchdata("commonMatchData", "build_version", _func_007E());
    setmatchdata("commonMatchData", "build_number", _func_007D());
    setmatchdata("commonMatchData", "utc_start_time_s", _func_00D7());
    setmatchdata("commonMatchData", "is_private_match", getdvarint("#x310c28bb5d64c8c6d"));
    level thread _id_0740::init();
    setmatchdata("commonMatchData", "is_ranked_match", 1);
  }

  level thread _id_1079A();
}

init(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  var_1._id_DD5F = var_2;
  var_3 = [];
  var_1._id_33AB = var_3;
  level._id_3E16 = var_1;
  _id_7EC3(var_0);
  level._id_B3FA = 0;
  level._id_B3FB = 0;
}

_id_1079A() {
  level endon("gameEnded");
  level waittill("prematch_done");
  setmatchdata("commonMatchData", "player_count_start", _id_FF37(level.players.size));
}

_id_AA5D() {
  _id_B4F9();
  _id_D334();
  _id_D3B8();
  _id_D263();
  level._id_B3FA = level._id_B3FA + 1;
  _id_97AD();
}

_id_97AD() {
  var_0 = spawnStruct();
  var_0.player = self;
  _id_06E2::_id_4C2A("callback_player_match_start", var_0);
}

_id_97AC(var_0) {
  var_1 = spawnStruct();
  var_1.player = self;
  var_1.disconnectreason = var_0;
  _id_06E2::_id_4C2A("callback_player_match_end", var_1);
}

_id_8289() {
  level endon("game_ended");
  level thread _id_C14D();

  for(;;) {
    level waittill("connected", var_0);
    _id_4032(var_0);
  }
}

_id_C14D() {
  level endon("game_ended");
  scripts\cp\utility::_id_60C2("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players) {
      var_1 thread _id_FD01();
    }
  }
}

_id_4032(var_0) {
  var_0._id_D02F = [];
  var_0._id_D02F["distanceTotal"] = 0;
  var_0._id_D02F["movingTotal"] = 0;
  var_0._id_D02F["movementUpdateCount"] = 0;
  var_0._id_CB4D = var_0.origin;
  var_0._id_BA0D = var_0.origin;
}

_id_FD01() {
  self endon("disconnect");

  if(!isDefined(self._id_CB4D)) {
    self._id_CB4D = self.origin;
    self._id_BA0D = self.origin;
  }

  if(scripts\cp\utility::_id_8ACE()) {
    self waittill("stopped_using_remote");
    self._id_CB4D = self.origin;
    self._id_BA0D = self.origin;
    return;
  }

  self._id_D02F["movementUpdateCount"]++;
  self._id_D02F["distanceTotal"] = self._id_D02F["distanceTotal"] + distance2d(self._id_CB4D, self.origin);
  self._id_CB4D = self.origin;

  if(self._id_D02F["movementUpdateCount"] % 5 == 0) {
    var_0 = distance2d(self._id_BA0D, self.origin);
    self._id_BA0D = self.origin;

    if(var_0 > 16) {
      self._id_D02F["movingTotal"]++;
    }
  }
}

_id_AA5E(var_0) {
  _id_D1AB();
  level._id_B3FB = level._id_B3FB + 1;
  _id_97AC(var_0);
}

_id_B4F9() {
  var_0 = spawnStruct();
  var_1 = [];
  var_1["cashSpentOnWeapon"] = _id_6759(0, "int");
  var_1["cashSpentOnAbility"] = _id_6759(0, "int");
  var_1["cashSpentOnTrap"] = _id_6759(0, "int");
  var_0._id_DD5F = var_1;
  var_2 = [];
  var_2["timesDowned"] = [];
  var_2["timesRevived"] = [];
  var_2["timesBledOut"] = [];
  var_0._id_905E = var_2;
  self._id_3E16 = var_0;
}

_id_D334() {
  if(!isDefined(level._id_9C0D)) {
    level._id_9C0D = 0;
  }

  if(level.players.size >= level._id_9C0D) {
    level._id_9C0D = level.players.size + 1;
  }
}

_id_D3B8() {}

_id_D263() {}

_id_BB9C() {
  if(scripts\engine\utility::_id_5C0C("introscreen_over") && scripts\engine\utility::_id_5C00("introscreen_over")) {
    return 1;
  }

  return 0;
}

_id_FB45(var_0, var_1) {
  if(level._id_3E16._id_33AB.size > 25) {
    return;
  }
  var_2 = spawnStruct();
  var_2._id_33A8 = var_0;
  var_2._id_0372 = var_1;
  level._id_3E16._id_33AB[level._id_3E16._id_33AB.size] = var_2;
}

_id_7D8F() {
  _id_7D90("timesDowned");
}

_id_7D91() {
  _id_7D90("timesRevived");
}

_id_7D8E() {
  _id_7D90("timesBledOut");
}

_id_7D90(var_0) {
  if(!isDefined(self._id_3E16._id_905E[var_0][level._id_10C9F])) {
    self._id_3E16._id_905E[var_0][level._id_10C9F] = 0;
  }

  self._id_3E16._id_905E[var_0][level._id_10C9F]++;
}

_id_FBCB(var_0, var_1) {
  switch (var_1) {
    case "weapon":
      self._id_3E16._id_DD5F["cashSpentOnWeapon"]._id_04CB = self._id_3E16._id_DD5F["cashSpentOnWeapon"]._id_04CB + var_0;
      break;
    case "ability":
      self._id_3E16._id_DD5F["cashSpentOnAbility"]._id_04CB = self._id_3E16._id_DD5F["cashSpentOnAbility"]._id_04CB + var_0;
      break;
    case "trap":
      self._id_3E16._id_DD5F["cashSpentOnTrap"]._id_04CB = self._id_3E16._id_DD5F["cashSpentOnTrap"]._id_04CB + var_0;
      break;
    default:
      break;
  }
}

_id_52F7(var_0, var_1) {
  _id_D21E(var_0, var_1);
  _id_10FBC();

  foreach(var_4, var_3 in level.players) {
    _id_074E::_id_7DE4(var_3);
    _id_074E::_id_7DE3(var_3);
    var_3 _id_D338(var_1);
    var_3 _id_D33A();
    var_3 _id_10FBA(var_3, var_4);
  }

  if(isDefined(level._id_1765)) {
    [[level._id_1765]]();
  }

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    _func_01CD();
  }

  _func_01CC();

  if(level.onlinestatsenabled) {
    foreach(var_4, var_3 in level.players) {
      var_6 = "";
      var_7 = -1;
      var_8 = var_3 getweaponslistprimaries();

      foreach(var_10 in var_8) {
        var_11 = scripts\cp\utility::getweaponrootname(var_10);
        var_12 = scripts\cp\cp_playerstats::getweaponstatvalue(var_3, var_11, "deaths");

        if(var_12 > var_7) {
          var_6 = var_11;
          var_7 = var_12;
        }
      }

      scripts\cp\cp_playerstats::updatecombatstat(var_3, "weaponOfChoice", var_6);
      scripts\cp\cp_playerstats::updatecombatstat(var_3, "totalEliminations", var_7);
    }

    var_14 = ["multikillstreak_5", "multikillstreak_10", "multikillstreak_15", "multikillstreak_20", "multikillstreak_25", "crit_finisher_multikill", "oneshot_multikill", "oneshot_explosive_multikill", "melee_weapon_multikill", "killstreak_without_getting_hit"];

    foreach(var_4, var_3 in level.players) {
      var_16 = "";
      var_17 = -1;

      foreach(var_19 in var_14) {
        var_12 = scripts\cp\cp_playerstats::getmedaluse(var_3, var_19);

        if(isDefined(var_12) && var_12 > var_17) {
          var_16 = var_19;
          var_17 = var_12;
        }
      }

      scripts\cp\cp_playerstats::updatecombatstat(var_3, "topMedal", var_16);
    }
  }
}

_id_D338(var_0) {
  var_1 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_2 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 = var_1 + var_0 / 1000;
  var_2 = var_2 + 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var_1));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var_2));
}

_id_D21E(var_0, var_1) {
  var_2 = "challengesCompleted";
  var_3 = level._id_3E16;

  foreach(var_7, var_5 in var_3._id_DD5F) {
    var_6 = _id_FF40(var_5._id_04CB, var_5._id_FF6B);
  }

  foreach(var_10, var_9 in var_3._id_33AB) {}

  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("commonMatchData", "utc_end_time_s", _func_00D7());
  setmatchdata("commonMatchData", "player_count", _id_FF37(level._id_B3FA));
  setmatchdata("commonMatchData", "player_count_left", _id_FF37(level._id_B3FB));
}

_id_D33A() {
  _id_3D57();
  _id_D26B();
  _id_D3A1();
  _id_D1AB();
}

_id_667C(var_0, var_1) {
  if(isDefined(level._id_9BAB["player"][self._id_399D]) && isDefined(level._id_9BAB["player"][self._id_399D][var_0])) {
    return level._id_9BAB["player"][self._id_399D][var_0];
  }

  return var_1;
}

_id_D1AB() {
  var_0 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_1 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var_2 = self getplayerdata("cp", "progression", "playerLevel", "rank");
  var_3 = self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

_id_3D57() {}

_id_D26B() {}

_id_D3A1() {}

_id_FF40(var_0, var_1) {
  switch (var_1) {
    case "byte":
      return _id_FF37(var_0);
    case "short":
      return _id_FF3E(var_0);
    case "int":
      return _id_FF3C(var_0);
    default:
  }
}

_id_FF37(var_0) {
  return int(min(var_0, 127));
}

_id_FF3E(var_0) {
  return int(min(var_0, 32767));
}

_id_FF3C(var_0) {
  return int(min(var_0, 2147483647));
}

_id_6759(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_04CB = var_0;
  var_2._id_FF6B = var_1;
  return var_2;
}

_id_7EC3(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 1;
  var_5 = 2;
  var_6 = 3;
  var_7 = 4;
  var_8 = 5;
  var_9 = 6;
  var_10 = 1;
  var_11 = 100;
  var_12 = 101;
  var_13 = 300;
  level._id_2534 = [];
  level._id_9BBE = [];
  level._id_9BAE = [];
  level._id_9BAB = [];
  level._id_39A1 = [];
  level._id_399F = [];
  level._id_399E = [];

  for(var_14 = var_12; var_14 <= var_13; var_14++) {
    var_15 = _func_0222(var_0, var_1, var_14, var_4);

    if(var_15 == "") {
      continue;
    }
    var_16 = _func_0222(var_0, var_1, var_14, var_5);

    if(var_16 != "") {
      level._id_2534[var_15] = var_16;
    }

    var_17 = _func_0222(var_0, var_1, var_14, var_6);

    if(var_17 != "") {
      level._id_9BAE[var_15] = var_17;
    }

    var_18 = _func_0222(var_0, var_1, var_14, var_7);

    if(var_18 != "") {
      level._id_9BBE[var_15] = [];
      level._id_9BAB[var_15] = [];
    }

    var_19 = _func_0222(var_0, var_1, var_14, var_8);

    if(var_19 != "") {
      level._id_399F[var_15] = var_19;
    }

    var_20 = _func_0222(var_0, var_1, var_14, var_9);

    if(var_20 != "") {
      level._id_39A1[var_15] = [];
      level._id_399E[var_15] = [];
    }
  }

  level._id_1756 = [];

  for(var_14 = var_10; var_14 <= var_11; var_14++) {
    var_21 = _func_0222(var_0, var_1, var_14, var_2);

    if(var_21 == "") {
      break;
    }

    var_22 = _func_0222(var_0, var_1, var_14, var_3);
    level._id_1756[var_21] = var_22;
    var_23 = strtok(var_22, " ");

    foreach(var_25 in var_23) {
      if(isDefined(level._id_9BBE[var_25])) {
        level._id_9BBE[var_25][var_21] = 0;
      }

      if(isDefined(level._id_39A1[var_25]) && isDefined(level._id_399F[var_21])) {
        level._id_39A1[var_25][var_21] = 0;
      }
    }
  }
}

_id_9723(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_643B(var_0);
  _id_971A(var_0, var_5, var_1, var_4);
}

_id_971A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = 0;

  if(_id_8574(var_0)) {
    foreach(var_6 in var_1) {
      if(_id_8575(var_6)) {
        var_7 = var_3[var_4];

        if(!isDefined(level._id_399E[var_6][var_7])) {
          level._id_399E[var_6][var_7] = level._id_39A1[var_6];
        }

        level._id_399E[var_6][var_7][var_0] = level._id_399E[var_6][var_7][var_0] + var_2;
        var_4++;
      }
    }
  }
}

_id_6386(var_0) {
  var_1 = "";

  foreach(var_4, var_3 in var_0) {
    var_1 = var_1 + (var_3 + " " + level._id_2534[var_3]);

    if(var_4 != var_0.size - 1) {
      var_1 = var_1 + " ";
    }
  }

  return var_1;
}

_id_643B(var_0) {
  var_1 = level._id_1756[var_0];
  return strtok(var_1, " ");
}

_id_9736(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(_id_8630(var_6)) {
      var_7 = var_3[var_4];

      if(!isDefined(level._id_9BAB[var_6][var_7])) {
        level._id_9BAB[var_6][var_7] = level._id_9BBE[var_6];
      }

      level._id_9BAB[var_6][var_7][var_0] = level._id_9BAB[var_6][var_7][var_0] + var_2;
      var_4++;
    }
  }
}

_id_8630(var_0) {
  return isDefined(level._id_9BBE[var_0]);
}

_id_8575(var_0) {
  return isDefined(level._id_39A1[var_0]);
}

_id_8574(var_0) {
  return isDefined(level._id_399F[var_0]);
}

_id_10FBC() {
  level._id_10C9F = scripts\cp\utility::_id_6871();
  setclientmatchdata("waves_survived", level._id_10C9F);
  setclientmatchdata("time_survived", level._id_F1FB);

  if(isDefined(level._id_5537)) {
    setclientmatchdata("team_score", level._id_5537);
  }

  if(isDefined(level._id_E59C)) {
    setclientmatchdata("stars_earned", level._id_E59C);
  }

  setclientmatchdata("scoreboardPlayerCount", level.players.size);
  setclientmatchdata("map", level.script);

  if(isDefined(level._id_10FBD)) {
    [[level._id_10FBD]]();
  }
}

_id_10FBA(var_0, var_1) {
  setclientmatchdata("player", var_1, "username", var_0.name);

  if(!scripts\cp\utility::_id_86C9()) {
    if(scripts\cp\utility::matchmakinggame()) {
      setclientmatchdata("player", var_1, "rank", var_0 _id_0756::getrank());
    } else {
      setclientmatchdata("player", var_1, "rank", var_0 _id_074E::_id_6689());
    }
  }

  if(isDefined(var_0._id_B3DD)) {
    setclientmatchdata("player", var_1, "characterIndex", var_0._id_B3DD);
  }

  var_2 = level._id_399E["player"][var_0._id_399D];

  if(isDefined(var_2)) {
    foreach(var_5, var_4 in var_2) {
      setclientmatchdata("player", var_1, var_5, int(var_4));
    }
  }

  if(isDefined(level._id_52FF)) {
    [[level._id_52FF]](var_0, var_1);
  }
}

_id_4BC5() {
  setdvarifuninitialized("#x3ec2c78c164a901ed", 0);
  level._id_1767 = spawnStruct();
  level._id_1767._id_A4C2 = 0;
  level._id_1767._id_A4BB = 0;
  level._id_1767._id_A49B = 0;

  if(!_id_1763()) {
    return;
  }
}

_id_1763() {
  if(_id_176F()) {
    return 1;
  }

  if(_id_1768()) {
    return 1;
  }

  return 0;
}

_id_1768() {
  return getdvarint("#x3ec2c78c164a901ed") == 1;
}

_id_6E24() {
  var_0 = level._id_1767._id_A4BB;
  level._id_1767._id_A4BB++;
  return var_0;
}

_id_2EAA(var_0) {
  if(!isDefined(self._id_1767._id_2EA5)) {
    self._id_1767._id_2EA5 = 0;
  }

  self._id_1767._id_2EA5 = self._id_1767._id_2EA5 | var_0;
}

_id_10AFD() {
  if(!_id_1763()) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);
    var_0 _id_9779();
  }
}

_id_10AF4() {
  self endon("disconnect");

  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_108A1("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(var_0 == "adjustedStance") {
      _id_3560();
      continue;
    }

    if(var_0 == "jumped") {
      _id_2EAA(4);
      continue;
    }

    if(var_0 == "weapon_fired") {
      _id_2EAA(8);
      continue;
    }

    if(var_0 == "reload_start") {
      _id_2EAA(16);
      continue;
    }

    if(var_0 == "spawned_player") {
      thread _id_977E();
    }
  }
}

_id_10B3E() {
  self endon("disconnect");

  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_108A0("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(var_0 == "doubleJumpBegin") {
      _id_2EAA(64);
      continue;
    }

    if(var_0 == "doubleJumpEnd") {
      _id_2EAA(128);
      continue;
    }

    if(var_0 == "sprint_slide_begin") {
      _id_2EAA(256);
    }
  }
}

_id_10B5A() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(getdvarint("#x3decf448ab3afab5f", 0) == 0) {
    return;
  }
  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  for(;;) {
    self waittill("log_user_event_start");
    var_0 = scripts\engine\utility::_id_10897("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var_0) && var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      _id_9774(self.name, self.origin, "Generic User Event");
    }
  }
}

_id_3560() {
  var_0 = self getstance();

  if(var_0 == "prone") {
    _id_2EAA(1);
  } else if(var_0 == "crouch") {
    _id_2EAA(2);
  }
}

_id_9753() {
  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!_id_DB9E(var_3)) {
        continue;
      }
      if(isDefined(var_3) && scripts\cp\utility\player::isreallyalive(var_3)) {
        var_3 _id_9778();
        var_3 _id_9783();
        waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

_id_C142() {
  level endon("game_ended");

  if(!_func_0437("dlog_event_breadcrumbs")) {
    return;
  }
  if(isDefined(scripts\cp\utility::getgametype()) && scripts\cp\utility::getgametype() == "br") {
    var_0 = getdvarfloat("#x32e648476cea761c9", 4.0);
  } else {
    var_0 = getdvarfloat("#x3ef49310374938e00", 2.0);
  }

  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_3 = scripts\cp\utility\player::isreallyalive(var_2) && !isai(var_2);
      var_4 = isDefined(var_2._id_9BC0) && _id_0740::_id_3193(var_2);
      var_5 = isDefined(var_2.team) && var_2.team != "spectator" && var_2.sessionstate == "playing" && var_2.sessionstate != "dead";

      if(var_3 && var_4 && var_5) {
        var_6 = var_2 scripts\cp\utility::_id_8989();
        var_7 = _id_0740::_id_6DE4(gettime());
        var_2 _meth_858E(var_7, var_2._id_9BC0, var_6);
      }
    }

    wait(var_0);
  }
}

_id_6C1A() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self._id_1767._id_2EA5), self._id_1767._id_2EA5, 0);

  if(self _meth_8498()) {
    var_0 = var_0 | 32;
  }

  return var_0;
}

_id_3969() {
  self._id_1767._id_2EA5 = 0;
  _id_3560();
}

_id_2D02() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "prone") {
    var_0 = var_0 | 1;
  } else if(var_1 == "crouch") {
    var_0 = var_0 | 2;
  }

  if(self _meth_846A()) {
    var_0 = var_0 | 4;
  }

  if(isDefined(self._id_9042) && gettime() - self._id_9042 < 500) {
    var_0 = var_0 | 8;
  }

  if(self _meth_81E0()) {
    var_0 = var_0 | 16;
  }

  return var_0;
}

_id_2D04() {
  var_0 = "archetype =" + self._id_965F + ";" + "powerPrimary=" + self._id_966A + ";" + "powerSecondary=" + self._id_966B + ";" + "weaponPrimary =" + self._id_034C + ";" + "weaponSecondary =" + self._id_03B5 + ";";
  return var_0;
}

_id_2D0C(var_0) {
  var_1 = "";

  if(isDefined(var_0._id_8F9D)) {
    if(isDefined(var_0._id_8F9D["allies"])) {
      var_1 = var_1 + ("alliesBucket=" + var_0._id_8F9D["allies"] + ";");
    }

    if(isDefined(var_0._id_8F9D["axis"])) {
      var_1 = var_1 + ("axisBucket=" + var_0._id_8F9D["axis"] + ";");
    }
  }

  return var_1;
}

_id_9778() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = anglesToForward(self getplayerangles());
  _func_03BF("gamecp_path", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_0[0], "gun_orienty", var_0[1], "gun_orientz", var_0[2], "action", _id_6C1A(), "health", _id_6D05()]);
  _id_3969();
}

_id_977E() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = isDefined(self._id_904C) && isDefined(self._id_904C._id_2C93) && self._id_904C._id_2C93;
  var_1 = anglesToForward(self.angles);
  _func_03BF("gamecp_spawn_in", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_1[0], "orienty", var_1[1], "orientz", var_1[2], "loadout", _id_2D04(), "type", scripts\engine\utility::ter_op(var_0, "Buddy", "Normal"), "team", self.team]);
}

_id_9779() {
  if(!_id_1763()) {
    return;
  }
  if(!isDefined(self._id_1767)) {
    self._id_1767 = spawnStruct();
  }

  self._id_1767._id_B6DA = level._id_1767._id_A4C2;
  level._id_1767._id_A4C2++;

  if(!_id_1768()) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self._id_33DA)) {
    var_0 = self._id_33DA._id_EB09;
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var_1 = self getxuid();
  _func_03BF("gamecp_player_connect", ["playerid", self._id_1767._id_B6DA, "player_name", self.name, "player_xuid", var_1, "player_super_name", var_0]);
}

_id_977A(var_0, var_1, var_2) {
  if(!_id_DB9E(self) || !isPlayer(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "s";
  var_12 = 0;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = var_0._id_1767._id_B6DA;

    if(isDefined(var_0.team)) {
      if(var_0.team == "axis") {
        var_11 = "a";
      } else {
        var_11 = "l";
      }
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0._id_936C)) {
      var_12 = var_0._id_936C;
    }

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level._id_1767._id_A49B;
  level._id_1767._id_A49B++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None");
  var_15 = "s";

  if(self.team == "axis") {
    var_15 = "a";
  } else {
    var_15 = "l";
  }

  _func_03BF("134death", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", _id_2D02(), "server_death_id", var_14, "victim_life_index", self._id_936C, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self._id_034C]);

  if(isDefined(var_1) && _func_010F(var_1)) {
    _id_9765(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "generic"), self.origin, var_0, 1.0);
  }

  if(isDefined(self._id_1DDE)) {
    foreach(var_17 in self._id_1DDE) {
      if(isDefined(var_17) && isPlayer(var_17) && var_17 != var_0) {
        _id_9762(var_17._id_1767._id_B6DA, var_14, var_2);
      }
    }
  }
}

_id_977C(var_0, var_1, var_2) {
  if(!_id_DB9E(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  _func_03BF("gamecp_kill", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0._id_1767._id_B6DA, "-1"), "action", _id_2D02(), "attacker_health", _id_6D05(), "victim_pixel_count", 0]);
}

_id_9765(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = (1, 0, 0);
  }

  _func_03BF("gamecp_explosion", ["playerid", var_2._id_1767._id_B6DA, "x", var_1[0], "y", var_1[1], "z", var_1[2], "orientx", var_4[0], "orienty", var_4[1], "orientz", var_4[2], "duration", var_3, "type", var_0]);
}

_id_9769(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamecp_front_line", ["startx", var_0[0], "starty", var_0[1], "endx", var_1[0], "endy", var_1[1], "axis_centerx", var_3[0], "axis_centery", var_3[1], "allies_centerx", var_2[0], "allies_centery", var_2[1], "state", var_4]);
}

_id_976A(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamecp_object", ["uniqueid", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "ownerid", var_3, "type", var_0, "state", var_4]);
}

_id_9774(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamecp_message", ["ownerid", var_0, "x", var_1[0], "y", var_1[1], "z", var_1[2], "message", var_2]);
}

_id_978F(var_0) {
  if(!_id_1768()) {
    return;
  }
  bbPrint("gamecp_matchtags", "message %s", var_0);
}

_id_977F(var_0, var_1) {
  if(!_id_DB9E(self)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  _func_03BF("gamecp_power", ["ownerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_2[0], "orienty", var_2[1], "orientz", var_2[2], "type", var_0, "state", var_1]);
}

_id_9783() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  _func_03BF("gamecp_scoreboard", ["ownerid", self._id_1767._id_B6DA, "score", self._id_038F]);
}

_id_9775() {
  if(!_id_1768()) {
    return;
  }
  var_0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }
  _func_03BF("gamecp_map", ["cornera_x", var_0[0].origin[0], "cornera_y", var_0[0].origin[1], "cornerb_x", var_0[1].origin[0], "cornerb_y", var_0[1].origin[1], "north", _func_00B9()]);
}

_id_9762(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamecp_assists", ["playerid", var_0, "server_death_id", var_1, "weapon", var_2]);
}

_id_6D05() {
  return int(clamp(self.health, 0, 100000));
}

_id_DB9E(var_0) {
  if(!_id_1768()) {
    return 0;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return 0;
  }

  return 1;
}

_id_97A6() {
  var_0 = getDvar("#x3a508f500ec367b3c", "");

  if(var_0 != "") {
    _id_978F(var_0);
  }

  if(scripts\cp\utility::matchmakinggame()) {
    _id_978F("OnlineMatch");
  } else if(getdvarint("#x310c28bb5d64c8c6d")) {
    _id_978F("PrivateMatch");
  } else if(!getdvarint("#x34e9ab8c76756925d")) {
    _id_978F("OfflineMatch");
  }
}

_id_978D(var_0, var_1, var_2, var_3) {
  if(!_id_1768()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_4 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_supers", ["super_name", var_0, "time_to_use", var_1, "num_hits", var_2, "num_kills", var_3, "player_id", var_4]);
}

_id_978C(var_0) {
  if(!_id_1768()) {
    return;
  }
  var_1 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_1 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_super_earned", ["match_time", var_0, "player_id", var_1]);
}

_id_9763(var_0) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("analytics_mp_awards", ["award_message", var_0]);
}

_id_976D(var_0, var_1, var_2, var_3) {
  if(!_id_1768()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_4 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_player_xp", ["current_prestige", var_0, "current_level", var_1, "xp_gained", var_2, "xp_source", var_3, "player_id", var_4]);
}

_id_976B(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  var_5 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_5 = self._id_1767._id_B6DA;
  }

  var_6 = getcompleteweaponname(var_0);
  _func_03BF("analytics_mp_weapon_xp", ["weapon", var_6, "current_prestige", var_1, "current_level", var_2, "xp_gained", var_3, "xp_source", var_4, "player_id", var_5]);
}

_id_9784() {
  if(!_id_1768()) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0[var_2] = 0;
    var_1[var_2] = "";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0[var_2] = var_4._id_1767._id_B6DA;
      var_1[var_2] = var_4 getxuid();
    }

    var_2 = var_2 + 1;
  }

  _func_03BF("analytics_match_player_index_init", ["player1_index", var_0[0], "player1_xuid", var_1[0], "player2_index", var_0[1], "player2_xuid", var_1[1], "player3_index", var_0[2], "player3_xuid", var_1[2], "player4_index", var_0[3], "player4_xuid", var_1[3], "player5_index", var_0[4], "player5_xuid", var_1[4], "player6_index", var_0[5], "player6_xuid", var_1[5], "player7_index", var_0[6], "player7_xuid", var_1[6], "player8_index", var_0[7], "player8_xuid", var_1[7], "player9_index", var_0[8], "player9_xuid", var_1[8], "player10_index", var_0[9], "player10_xuid", var_1[9], "player11_index", var_0[10], "player11_xuid", var_1[10], "player12_index", var_0[11], "player12_xuid", var_1[11]]);
}

_id_176F() {
  return getdvarint("#x39b14953cc5f8daf5") != 0;
}

_id_9786() {
  var_0 = spawnStruct();
  _id_06E2::_id_4C2A("callback_match_start", var_0);
}

_id_9785(var_0) {
  var_1 = spawnStruct();
  var_1.player = self;
  var_1._id_0372 = var_0;
  _id_06E2::_id_4C2A("callback_match_end", var_1);
}

_id_9776(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_munition_used", ["levelname", level.script, "playername", var_0.name, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "munition", var_1, "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_978E(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_super_used", ["levelname", level.script, "playername", var_0.name, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "super", var_1, "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_976E(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_kidnapper", ["levelname", level.script, "version", var_1, "times_kidnapped", var_0._id_F268, "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_978B(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_spawn_via_teamrevive", ["levelname", level.script, "last_stand_id", _id_6543(var_0), "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_9789(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_spawn_via_autorevive", ["levelname", level.script, "last_stand_id", _id_6543(var_0), "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_978A(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cpdata_plr_spawn_via_player", ["reviver", var_1, "levelname", level.script, "last_stand_id", _id_6543(var_0), "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "active_objective", scripts\cp\telemetry_cp::_id_660E()]);
}

_id_976F(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(isPlayer(var_1), var_1.name, var_1._id_1210);
  var_0 _meth_870F("dlog_event_cpdata_plr_combat", ["levelname", level.script, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "stat_type", "Killed", "enemy", var_3, "x2", var_1.origin[0], "y2", var_1.origin[1], "z2", var_1.origin[2], "active_objective", scripts\cp\telemetry_cp::_id_660E(), "weapon", var_2.basename]);
}

_id_9764(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  _id_FB77(var_0);
  var_2 = scripts\engine\utility::ter_op(isagent(var_1) && isDefined(var_1._id_1210), var_1._id_1210, var_0.name);
  var_0 _meth_870F("dlog_event_cpdata_plr_downed", ["levelname", level.script, "enemy", var_2, "last_stand_id", _id_6543(var_0), "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2]]);
}

_id_FB77(var_0) {
  if(!isDefined(var_0._id_9074)) {
    var_0._id_9074 = 0;
  } else {
    var_0._id_9074++;
  }

  return var_0._id_9074;
}

_id_6543(var_0) {
  return var_0._id_9074;
}