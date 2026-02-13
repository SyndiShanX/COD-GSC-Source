/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1878.gsc
*************************************************/

init() {
  level._id_CC07 = [];
  var_0 = getdvarfloat("#x37ee7f4c3d5151e16", 1);
  var_1 = getdvarfloat("#x3192f425f399ae5c0", 1);
  var_2 = getdvarint("#x3210420a7dc973e8c", 1);

  if(var_2 > 4 || var_2 < 0) {
    exitlevel(0);
  }

  _id_10B3(var_2, "online_mp_xpscale");
  _id_10B3(var_0, "online_zm_player_xpscale");
  var_3 = getdvarint("#x32a2a182348da7327", 1);

  if(var_3 > 4 || var_3 < 0) {
    exitlevel(0);
  }

  _id_10B1(var_3, "online_battle_xpscale_dvar");
  _id_10B1(var_1, "online_zm_battlepass_xpscale");
  var_4 = getdvarint("#x3dde311efe70e3fb1", 1);

  if(var_4 > 4 || var_4 < 0) {
    exitlevel(0);
  }

  _id_10B2(var_4, "online_operator_xpscale");
  _id_10B2(var_0, "online_zm_player_xpscale");
  var_5 = getdvarint("#x37c8dbdca5951e25", 1);

  if(var_5 > 4 || var_5 < 0) {
    exitlevel(0);
  }

  addglobalclanxpmultiplier(var_5, "online_clan_xpscale");
  addglobalclanxpmultiplier(var_0, "online_zm_player_xpscale");
  var_6 = getdvarint("#x35ea7f9c06d63b220", 1);
  level.sonyxpscale = var_6;
  level.ranktable = [];
  level._id_10DC3 = [];
  level.maxrank = int(_func_0222("mp/rankTable.csv", 0, "maxrank", 1));
  level._id_9C68 = int(_func_0222("mp/rankTable.csv", 0, "maxelder", 1));

  for(var_7 = 0; var_7 <= level.maxrank; var_7++) {
    level.ranktable[var_7]["minXP"] = _func_0222("mp/rankTable.csv", 0, var_7, 2);
    level.ranktable[var_7]["xpToNext"] = _func_0222("mp/rankTable.csv", 0, var_7, 3);
    level.ranktable[var_7]["maxXP"] = _func_0222("mp/rankTable.csv", 0, var_7, 7);
    level.ranktable[var_7]["splash"] = _func_0222("mp/rankTable.csv", 0, var_7, 15);
  }

  _id_0776::init();
  _id_0961::_id_C28D(::onplayerspawned);
  level._id_BBFE = [];
  level thread onplayerconnect();
}

_id_50EB() {
  self notify("earnPeriodicXP");
  self endon("earnPeriodicXP");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = "persistent_xp";

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    waitframe();
  }

  if(!scripts\cp\utility::_id_871A() && !scripts\cp\utility::_id_86C9()) {
    if(!scripts\engine\utility::_id_5472("player_spawned_with_loadout")) {
      scripts\engine\utility::_id_5473("player_spawned_with_loadout");
    }

    scripts\engine\utility::_id_5476("player_spawned_with_loadout");
  } else
    wait 15;

  self.pers["periodic_xp_participation"] = 0;
  var_1 = self.pers["periodic_xp_participation"];

  for(;;) {
    if(var_1 == self.pers["periodic_xp_participation"]) {
      waitframe();
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      waitframe();
      continue;
    }

    var_2 = _id_6D0C(var_0, "xp");
    thread giverankxp(var_0, var_2, undefined, 1);
    var_1 = self.pers["periodic_xp_participation"];
    wait 3;
  }
}

_id_89F5(var_0) {
  if(isDefined(level._id_CC07[var_0])) {
    return 1;
  } else {
    return 0;
  }
}

_id_C2AC(var_0, var_1, var_2) {
  level._id_CC07[var_0][var_1] = var_2;

  if(var_0 == "kill" && var_1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var_2));
  }
}

getscoreinfovalue(var_0) {
  var_1 = _func_0483("#x3ecead486797add6d", scripts\cp\utility::getgametype(), "_score_", var_0);

  if(getDvar(var_1) != "") {
    return getdvarint(var_1);
  } else if(isDefined(level._id_CC07[var_0])) {
    return level._id_CC07[var_0]["value"];
  }
}

_id_6D0C(var_0, var_1) {
  if(!isDefined(level._id_CC07[var_0])) {
    return;
  }
  switch (var_1) {
    case "value":
      var_2 = _func_0483("#x3ecead486797add6d", scripts\cp\utility::getgametype(), "_score_", var_0);

      if(getDvar(var_2) != "") {
        return getdvarint(var_2);
      } else {
        return level._id_CC07[var_0]["value"];
      }
    default:
      return level._id_CC07[var_0][var_1];
  }
}

_id_6CDD(var_0) {
  return int(level.ranktable[var_0]["minXP"]);
}

_id_6CDE(var_0) {
  return int(level.ranktable[var_0]["xpToNext"]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0]["maxXP"]);
}

_id_6CD9(var_0) {
  return _func_0226("mp/rankTable.csv", 0, var_0, 16);
}

_id_6CDA(var_0, var_1) {
  return _func_0222("mp/rankIconTable.csv", 0, var_0, var_1 + 1);
}

_id_6CDB(var_0) {
  return int(_func_0222("mp/rankTable.csv", 0, var_0, 13));
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["rankxp"] = var_0 getplayerdata("common", "mpProgression", "playerLevel", "xp");
        var_1 = var_0 getplayerdata("common", "mpProgression", "playerLevel", "prestige");

        if(!isDefined(var_0.pers["xpEarnedThisMatch"])) {
          var_0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var_1 = 0;
        var_0.pers["rankxp"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["rankxp"] = 0;
    }

    var_0.pers["prestige"] = var_1;

    if(var_0.pers["rankxp"] < 0) {
      var_0.pers["rankxp"] = 0;
    }

    var_2 = var_0 getrankforxp(var_0 getrankxp());
    var_0.pers["rank"] = var_2;
    var_0 setrank(var_2, var_1);
    var_0.pers["participation"] = 0;
    var_0.pers["matchbonus_round_participation_time"] = 0;
    var_0.pers["matchbonus_participation_time"] = 0;
    var_0.pers["battlepass_xp_participation_time"] = 0;
    var_0.pers["battlepass_xp_participation_granted_this_round"] = 0;
    var_0.pers["earned_objective_completion_xp"] = 0;
    var_0._id_CC25 = 0;
    var_0._id_CC14 = 0;
    var_0._id_CC01 = [];
    var_0._id_BA4C = 0;
    var_0 setclientdvar("#x322d96488da65b428", 0);

    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["medal"] = 0;
      var_0.pers["summary"]["bonusXP"] = 0;
      var_0.pers["summary"]["weaponXP"] = 0;
      var_0.pers["summary"]["operatorXP"] = 0;
      var_0.pers["summary"]["clanXP"] = 0;
      var_0.pers["summary"]["battlepassXP"] = 0;
    }

    var_0 setclientdvar("#x32add9cc9e0c920a1", 0);

    if(level.playerxpenabled) {
      var_3 = getdvarint("#x36ffcac04370655e7");
      var_4 = var_0 getprivatepartysize() > 1;

      if(var_4) {
        var_0 _id_111C(var_3, "online_mp_party_xpscale");
      }

      if(var_0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var_0._id_BBFD = 1;
      } else {
        var_0._id_BBFD = 0;
      }

      var_5 = getdvarint("#x36ff46211529c8a75", 40000);
      var_0._id_9CC2 = var_5;
      var_0._id_F389 = 0;
    }

    var_0._id_CBFA = 0;
    var_0._id_CBFD = 0;
    var_0._id_F37A = 0;
    var_0._id_9C89 = 3000;
    var_0 thread accumulatematchbonusxp();
  }
}

accumulatematchbonusxp() {
  self notify("accumulateMatchbonusXP");
  self endon("accumulateMatchbonusXP");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.pers["matchbonus_round_participation_time"]) && isDefined(level.xp_per_round_parameter.matchbonus_limit) && self.pers["matchbonus_round_participation_time"] >= level.xp_per_round_parameter.matchbonus_limit * 60) {
      if(self.pers["battlepass_xp_participation_granted_this_round"] == 0) {
        givebattlepassparticipationxp();
        self.pers["battlepass_xp_participation_granted_this_round"] = 1;
      }

      wait 1;
      continue;
    }

    self.pers["matchbonus_round_participation_time"] = self.pers["matchbonus_round_participation_time"] + 3;
    self.pers["battlepass_xp_participation_time"] = self.pers["battlepass_xp_participation_time"] + 3;
    wait 3;
  }
}

givematchbonusxp() {
  foreach(var_1 in level.players) {
    var_2 = var_1.pers["matchbonus_participation_time"] + var_1.pers["matchbonus_round_participation_time"];
    var_3 = var_2 / 60 * level.matchbonus_perminbase - var_1.pers["earned_objective_completion_xp"];
    var_1 giverankxp("matchbonus_xp", int(max(var_3, randomintrange(1000, 1250))), undefined, undefined, 1);
    var_1.pers["matchbonus_round_participation_time"] = 0;
    var_1.pers["matchbonus_participation_time"] = 0;
    var_1 givebattlepassparticipationxp();
  }
}

givebattlepassparticipationxp() {
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  if(self.pers["battlepass_xp_participation_time"] > 0) {
    var_0 = self.pers["battlepass_xp_participation_time"] / 60 * 3025 * _id_6A6F();
    var_0 = int(var_0);
    self reportchallengeuserevent("144115188075855887", [5, var_0, 7, var_0]);
    self.pers["battlepass_xp_participation_time"] = 0;
  }
}

onplayerspawned() {
  if(isai(self)) {} else if(!level.playerxpenabled)
    self.pers["rankxp"] = 0;
  else if(!scripts\cp\utility::_id_86C9()) {}

  _id_B80A();
  _id_B6E0();
}

_id_B80A() {
  if(self.pers["rankxp"] < 0) {
    self.pers["rankxp"] = 0;
  }

  var_0 = getrankforxp(getrankxp());
  self.pers["rank"] = var_0;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self._id_2CA1)) {
      var_1 = _id_6C89();
    } else {
      var_1 = 0;
    }

    self setrank(var_0, var_1);
    self.pers["prestige"] = var_1;
  }
}

_id_B6E0() {
  _id_0740::_id_8257("lastBulletKillTime");
  _id_0740::_id_8257("bulletStreak");
  _id_0740::_id_8257("assists");
  _id_0740::_id_8257("supersEarned");
}

_id_F756() {
  if(issubstr(self.class, "custom")) {
    if(!level.playerxpenabled) {
      self.pers["rankxp"] = 0;
    } else if(isai(self)) {
      self.pers["rankxp"] = 0;
    } else {}
  }
}

giverankxp(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self) && self.owner != self) {
    self.owner giverankxp(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  var_6 = _func_03CF(self);
  var_1 = int(var_1 * var_6);

  if(!level.playerxpenabled) {
    return;
  }
  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }
  thread waitandapplyxp(var_0, var_1, var_2, var_4, var_5);
}

waitandapplyxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!var_4) {
    waitframe();
    _id_0960::_id_1096C();
  }

  var_5 = getrankxp();

  if(updaterank(var_5)) {
    thread _id_FD0D();
  }

  _id_EC46();

  if(!isDefined(var_3) || !isDefined(var_2) || !_id_0776::_id_10DD2(var_2.basename)) {
    var_3 = 0;
  }

  incrankxp(var_1, var_2, var_3, var_0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_2) && (scripts\cp\cp_weapon::_id_879A(var_2) || scripts\cp\cp_weapon::_id_879C(var_2)) && !scripts\cp\cp_weapon::_id_897E(var_2)) {}
  }

  var_6 = _id_6C89();
  var_7 = getrank();
}

_id_C152(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_1 / getplayerfacingxpbonus();
  var_7 = var_1 - var_6;
  var_7 = int(var_7);
  self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_7;
  self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_1;
  self.pers["summary"]["weaponXP"] = self.pers["summary"]["weaponXP"] + var_2;
  self.pers["summary"]["operatorXP"] = self.pers["summary"]["operatorXP"] + var_4;
  self.pers["summary"]["clanXP"] = self.pers["summary"]["clanXP"] + var_5;
  self.pers["summary"]["battlepassXP"] = self.pers["summary"]["battlepassXP"] + var_3;
  var_8 = _id_6D0C(var_0, "group");

  if(!isDefined(var_8) || var_8 == "") {
    if(var_0 == "WeaponMatchBonus") {
      return;
    }
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_1;
    return;
  }

  switch (var_8) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_6;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_7;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_1;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_6;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_7;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_1;
      break;
    case "medal":
      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var_6;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_7;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_1;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_6;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_7;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_1;
      break;
  }
}

updaterank(var_0) {
  var_1 = getrank();
  var_2 = _id_6C89();
  var_3 = self.pers["rank"] + self.pers["prestige"];
  var_4 = var_1 + var_2;
  self.pers["rank"] = var_1;
  self.pers["prestige"] = var_2;

  if(var_4 == var_3 || var_4 >= level.maxrank + level._id_9C68) {
    return 0;
  }

  self setrank(var_1, var_2);
  return 1;
}

_id_FD0D() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!_id_07D1::_id_9351("game_over")) {
    level scripts\engine\utility::_id_108F5("game_over", 0.25);
  }

  var_1 = self.pers["rank"] + self.pers["prestige"];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    var_4 = var_3.pers["team"];

    if(isDefined(var_4) && var_4 == var_0) {}
  }
}

_id_BED8(var_0) {
  self._id_CC14 = self._id_CC14 + var_0;
}

_id_5D27() {
  _id_CC13(self._id_CC14);
  self._id_CC14 = 0;
}

_id_5D28() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScorePointsPopupQueueOnspawn()");
  self endon("flushScorePointsPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  _id_5D27();
}

_id_CC13(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var_0 == 0) {
    return;
  }
  if(!scripts\cp\utility\player::isreallyalive(self) && !self _meth_81D3() && !scripts\cp\utility\player::_id_8ACE()) {
    if(!istrue(var_1) || scripts\cp\utility\player::_id_88C7()) {
      _id_BED8(var_0);
      thread _id_5D28();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self._id_CC25 = int(clamp(self._id_CC25 + var_0, 0, 99999));
  self setclientomnvar("ui_points_popup", self._id_CC25);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1.0;
  self._id_CC25 = 0;
}

_id_A6AC() {
  waitframe();
  level notify("update_player_score", self, self._id_CC25);
}

_id_BED7(var_0) {
  self._id_CC01[self._id_CC01.size] = var_0;
}

_id_5D25() {
  foreach(var_1 in self._id_CC01) {
    _id_CC00(var_1);
  }

  self._id_CC01 = [];
}

_id_5D26() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScoreEventPopupQueueOnspawn()");
  self endon("flushScoreEventPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  _id_5D25();
}

_id_6D0B(var_0) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return 0;
  }

  var_1 = _id_6D0C(var_0, "priority");

  if(!istrue(var_1)) {
    return 0;
  }

  return var_1;
}

_id_CBF9(var_0) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return 0;
  }

  var_1 = _id_6D0C(var_0, "alwaysShowSplash");

  if(!istrue(var_1)) {
    return 0;
  }

  return 1;
}

_id_CBFC(var_0) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return 0;
  }

  var_1 = _id_6D0C(var_0, "eventID");
  var_2 = _id_6D0C(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return 0;
  }

  return 1;
}

_id_CC00(var_0, var_1) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return;
  }
  if(isDefined(self.owner) && self.owner != self) {
    self.owner _id_CC00(var_0);
  }

  if(!isPlayer(self)) {
    return;
  }
  var_2 = _id_6D0C(var_0, "eventID");
  var_3 = _id_6D0C(var_0, "text");

  if(!isDefined(var_2) || var_2 < 0 || !isDefined(var_3) || var_3 == "") {
    return;
  }
  if(!scripts\cp\utility\player::isreallyalive(self) && !self _meth_81D3() && !scripts\cp\utility\player::_id_8ACE()) {
    _id_BED7(var_0);
    thread _id_5D26();
    return;
  }

  if(!isDefined(self._id_CBFE)) {
    self._id_CBFE = 1;
    thread _id_3975();
  } else {
    self._id_CBFE++;

    if(self._id_CBFE > 5) {
      self._id_CBFE = 5;
      return;
    }
  }

  if(isDefined(var_1) && isDefined(var_1._id_1210)) {
    switch (var_1._id_1210) {
      case "actor_enemy_base_zombie_sumpf_cp":
      case "actor_enemy_base_zombie_skorpion_cp":
      case "actor_enemy_base_zombie_cp":
        var_4 = 1;
        break;
      case "actor_enemy_zombie_screamer_cp":
        var_4 = 2;
        break;
      case "actor_enemy_zombie_juggernaut_cp":
        if(istrue(var_1.b_is_hvt)) {
          var_4 = 6;
        } else {
          var_4 = 3;
        }

        break;
      case "actor_enemy_zombie_trickster_cp":
        if(istrue(var_1.b_is_final_boss)) {
          var_4 = 5;
        } else {
          var_4 = 4;
        }

        break;
      default:
        var_4 = 0;
    }

    self setclientomnvar("ui_score_event_enemy_type_" + self._id_CBFD, var_4);
  }

  self setclientomnvar("ui_score_event_list_" + self._id_CBFD, var_2);
  self setclientomnvar("ui_score_event_control", self._id_CBFA % 10);
  self._id_CBFD++;
  self._id_CBFD = self._id_CBFD % 5;
  self._id_CBFA++;
}

_id_3975() {
  self endon("disconnect");
  self notify("clearScoreEventListAfterWait()");
  self endon("clearScoreEventListAfterWait()");
  scripts\engine\utility::_id_108F5("death", 0.5);
  self._id_CBFE = undefined;
}

getrank() {
  var_0 = self.pers["rankxp"];
  var_1 = self.pers["rank"];

  if(var_0 < _id_6CDD(var_1) + _id_6CDE(var_1)) {
    return var_1;
  } else {
    return getrankforxp(var_0);
  }
}

getrankforxp(var_0) {
  var_1 = level.maxrank;

  if(var_0 >= _id_6CDD(var_1)) {
    return var_1;
  } else {
    var_1--;
  }

  while(var_1 > 0) {
    if(var_0 >= _id_6CDD(var_1) && var_0 < _id_6CDD(var_1) + _id_6CDE(var_1)) {
      return var_1;
    }

    var_1--;
  }

  return var_1;
}

_id_6B30() {
  var_0 = getrank() + 1;
  return (3 + var_0 * 0.5) * 10;
}

_id_6C89() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  } else {
    return self getplayerdata("rankedloadouts", "squadMembers", "season_rank");
  }
}

getrankxp() {
  return self.pers["rankxp"];
}

incrankxp(var_0, var_1, var_2, var_3) {
  if(!level.playerxpenabled) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(level._id_9C58)) {
    level._id_9C58 = getdvarint("#x327b495910d645fc3", 0);
  }

  if(level._id_9C58 > 0 && getrank() + 1 >= level._id_9C58) {
    var_0 = 0;
  }

  var_4 = _id_6D0C(var_3, "allowBonus");
  self._id_F389 = self._id_F389 + var_0;
  var_5 = "";
  var_6 = -1;

  if(isDefined(var_1)) {
    var_5 = scripts\cp\utility::_id_69D8(var_1.basename);
    var_7 = _func_0222("mp/statstable.csv", 5, var_5, 4);
    var_8 = var_7 + "_variant_0";
    var_6 = int(_func_0222("loot/weapon_ids.csv", 9, var_8, 0));

    if(istrue(var_4)) {
      var_2 = var_2 * _id_0776::_id_6E87();
      var_2 = int(var_2);
    }
  }

  if(var_2 > 0 && var_6 == -1) {}

  var_9 = getrankxp();
  var_10 = int(min(var_9 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var_10 >= getrankinfomaxxp(level.maxrank)) {
    var_10 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var_0;
  self.pers["rankxp"] = var_10;
  var_11 = var_0;

  if(istrue(var_4)) {
    var_12 = _id_6CE1();
    var_11 = var_11 * var_12;
    var_11 = int(var_11);
  }

  var_13 = var_0;

  if(istrue(var_4)) {
    var_14 = _id_6905();
    var_15 = _id_6CE0();
    var_16 = _id_6A74();
    var_13 = var_13 * var_14 * var_15 * var_16;
    var_13 = int(var_13);
  }

  var_17 = -1;

  if(isDefined(self.operatorid)) {
    var_17 = self.operatorid;
  }

  var_18 = var_0;

  if(istrue(var_4)) {
    var_19 = _id_6BDB();
    var_18 = var_18 * var_19;
    var_18 = int(var_18);
  }

  var_20 = var_0;

  if(istrue(var_4)) {
    var_21 = getclanxpmultipliertotal();
    var_20 = var_20 * var_21;
    var_20 = int(var_20);
  }

  if(var_17 != -1 && isDefined(self.operatorfaveweap) && var_6 != -1 && var_5 != "") {
    if(var_5 == self.operatorfaveweap + "_mp") {
      var_2 = var_2 * 1.1;
      var_18 = var_18 * 1.1;
      var_2 = int(var_2);
      var_18 = int(var_18);
    }
  }

  var_22 = [];
  var_23 = 0;

  if(var_11 > 0) {
    var_22[var_22.size] = 0;
    var_22[var_22.size] = var_11;

    if(level._id_C02A["online_mp_xpscale"] >= 2) {
      var_23 = var_23 | 1;
    }
  }

  if(var_2 > 0 && var_6 != -1) {
    var_22[var_22.size] = 2;
    var_22[var_22.size] = var_2;
    var_22[var_22.size] = 1;
    var_22[var_22.size] = var_6;

    if(level._id_10DC4["online_mp_weapon_xpscale"] >= 2) {
      var_23 = var_23 | 2;
    }
  }

  if(var_13 > 0) {
    var_22[var_22.size] = 5;
    var_22[var_22.size] = var_13;

    if(level._id_2381["online_battle_xpscale_dvar"] >= 2) {
      var_23 = var_23 | 8;
    }
  }

  if(var_18 > 0 && var_17 != -1) {
    var_22[var_22.size] = 4;
    var_22[var_22.size] = var_18;
    var_22[var_22.size] = 3;
    var_22[var_22.size] = var_17;

    if(level._id_AC40["online_operator_xpscale"] >= 2) {
      var_23 = var_23 | 4;
    }
  }

  if(var_20 > 0) {
    var_22[var_22.size] = 6;
    var_22[var_22.size] = var_20;

    if(level.clanrankxpmultipliers["online_clan_xpscale"] >= 2) {
      var_23 = var_23 | 16;
    }
  }

  if(var_22.size == 0) {
    return;
  }
  var_22[var_22.size] = 8;
  var_22[var_22.size] = var_23;
  self reportchallengeuserevent("144115188075855887", var_22);
  scripts\cp\telemetry_cp::_id_9790(self, var_0, var_5, var_2, var_3);
  _id_C152(var_3, var_11, var_2, var_13, var_18, var_20);
}

_id_EC46() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var_1 > var_0) {
    return;
  }
  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var_0);
}

_id_6A68() {
  if(!isDefined(level._id_60FC)) {
    var_0 = getdvarfloat("#x3ca0ba2dcaed1d421", 1.0);

    if(var_0 != 1.0) {
      level._id_60FC = var_0;
    } else {
      level._id_60FC = float(_func_0222("mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 17));
    }
  }

  return level._id_60FC;
}

_id_10B3(var_0, var_1) {
  level _id_111C(var_0, var_1);
}

_id_6A74() {
  var_0 = level _id_6CE0();
  var_1 = getdvarint("#x321015317a8ce1a35", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

_id_111C(var_0, var_1) {
  var_2 = 4 / level _id_6CE0();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self._id_C02A)) {
    self._id_C02A = [];
  }

  if(isDefined(self._id_C02A[var_1])) {
    self._id_C02A[var_1] = max(self._id_C02A[var_1], var_0);
  } else {
    self._id_C02A[var_1] = var_0;
  }
}

_id_6CE0() {
  if(!isDefined(self._id_C02A)) {
    return 1.0;
  }

  var_0 = 1.0;

  foreach(var_2 in self._id_C02A) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

_id_6C3F() {
  var_0 = 1.0;
  var_1 = _func_047A(self, 1);

  if(self _meth_8754()) {
    var_0 = var_0 * _func_040D();
  } else if(isDefined(scripts\engine\utility::_id_1BAB(var_1, self))) {
    var_0 = var_0 * level.sonyxpscale;
  }

  return var_0;
}

_id_C4C8(var_0) {
  level _id_C512(var_0);
}

_id_C512(var_0) {
  if(!isDefined(self._id_C02A)) {
    return;
  }
  if(!isDefined(self._id_C02A[var_0])) {
    return;
  }
  self._id_C02A[var_0] = undefined;
}

_id_1144(var_0, var_1, var_2) {
  if(!level.teambased) {
    var_1 = "all";
  }

  if(!isDefined(self._id_EF9A)) {
    level._id_EF9A = [];
  }

  if(!isDefined(level._id_EF9A[var_1])) {
    level._id_EF9A[var_1] = [];
  }

  if(isDefined(level._id_EF9A[var_1][var_2])) {
    level._id_EF9A[var_1][var_2] = max(self._id_EF9A[var_1][var_2], var_0);
  } else {
    level._id_EF9A[var_1][var_2] = var_0;
  }
}

_id_C532(var_0, var_1) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level._id_EF9A)) {
    return;
  }
  if(!isDefined(level._id_EF9A[var_0])) {
    return;
  }
  if(!isDefined(level._id_EF9A[var_0][var_1])) {
    return;
  }
  level._id_EF9A[var_0][var_1] = undefined;
}

_id_6DD7(var_0) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(var_0) || !isDefined(level._id_EF9A) || !isDefined(level._id_EF9A[var_0])) {
    return 1.0;
  }

  var_1 = 1.0;

  foreach(var_3 in level._id_EF9A[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1 = var_1 * var_3;
  }

  return var_1;
}

_id_6CE1() {
  var_0 = _id_6CE0();
  var_1 = _id_6A74();
  var_2 = _id_6DD7(self.team);
  var_3 = _id_6C3F();
  var_4 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_5 = var_0 * var_1 * var_2 * var_3 * var_4;
  return var_5;
}

getplayerfacingxpbonus() {
  var_0 = _id_6CE0();
  var_1 = _id_6A74();
  var_2 = _id_6C3F();
  var_3 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  return var_0 * var_1 * var_2 * var_3;
}

_id_10B1(var_0, var_1) {
  level _id_1093(var_0, var_1);
}

_id_6A6F() {
  var_0 = level _id_6904();
  var_1 = getdvarint("#x321015317a8ce1a35", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

_id_1093(var_0, var_1) {
  var_2 = 4 / level _id_6904();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self._id_2381)) {
    self._id_2381 = [];
  }

  if(isDefined(self._id_2381[var_1])) {
    self._id_2381[var_1] = max(self._id_2381[var_1], var_0);
  } else {
    self._id_2381[var_1] = var_0;
  }
}

_id_6904() {
  if(!isDefined(self._id_2381)) {
    return 1.0;
  }

  var_0 = 1.0;

  foreach(var_2 in self._id_2381) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

_id_6905() {
  var_0 = _id_6904();
  var_1 = _id_6A6F();
  var_2 = _id_6C3F();
  var_3 = var_0 * var_1 * var_2 * 1.32;
  return var_3;
}

_id_10B2(var_0, var_1) {
  level _id_1106(var_0, var_1);
}

_id_6A73() {
  var_0 = level _id_6BDA();
  var_1 = getdvarint("#x321015317a8ce1a35", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

_id_1106(var_0, var_1) {
  var_2 = 4 / level _id_6BDA();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self._id_AC40)) {
    self._id_AC40 = [];
  }

  if(isDefined(self._id_AC40[var_1])) {
    self._id_AC40[var_1] = max(self._id_AC40[var_1], var_0);
  } else {
    self._id_AC40[var_1] = var_0;
  }
}

_id_6BDB() {
  var_0 = _id_6BDA();
  var_1 = _id_6A72();
  var_2 = _id_6C3F();
  var_3 = _id_6A68();
  var_4 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_5 = var_0 * var_1 * var_2 * var_3 * var_4;
  return var_5;
}

_id_6BDA() {
  if(!isDefined(self._id_AC40)) {
    return 1.0;
  }

  var_0 = 1.0;

  foreach(var_2 in self._id_AC40) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

_id_6A72() {
  return level _id_6BDA();
}

addglobalclanxpmultiplier(var_0, var_1) {
  level addclanxpmultiplier(var_0, var_1);
}

getglobalclanxpmultiplier() {
  var_0 = level getclanxpmultiplier();
  var_1 = getdvarint("#x321015317a8ce1a35", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

addclanxpmultiplier(var_0, var_1) {
  var_2 = 4 / level getclanxpmultiplier();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self.clanrankxpmultipliers)) {
    self.clanrankxpmultipliers = [];
  }

  if(isDefined(self.clanrankxpmultipliers[var_1])) {
    self.clanrankxpmultipliers[var_1] = max(self.clanrankxpmultipliers[var_1], var_0);
  } else {
    self.clanrankxpmultipliers[var_1] = var_0;
  }
}

getclanxpmultipliertotal() {
  var_0 = getclanxpmultiplier();
  var_1 = getglobalclanrankxpmultiplier();
  var_2 = _id_6C3F();
  var_3 = _id_6A68();
  var_4 = scripts\engine\utility::ter_op(_func_047B(self), 1.0, 0);
  var_5 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
}

getclanxpmultiplier() {
  if(!isDefined(self.clanrankxpmultipliers)) {
    return 1.0;
  }

  var_0 = 1.0;

  foreach(var_2 in self.clanrankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

getglobalclanrankxpmultiplier() {
  return level getclanxpmultiplier();
}

_id_C025(var_0) {
  _id_D8F4(var_0);

  if(_id_7AA3()) {}

  _id_0752::_id_FCBB(var_0);
}

_id_6AA7() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost()) {
      return var_0[var_1];
    }
  }
}

_id_7AA3() {
  var_0 = _id_6AA7();

  if(isDefined(var_0) && !var_0._id_75B4 && !isDefined(var_0._id_D05C)) {
    return 1;
  }

  return 0;
}

_id_D8F4(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3._id_038F) || !isDefined(var_3.pers["team"])) {
      continue;
    }
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3._id_0267) || !isDefined(var_3._id_0157)) {
      continue;
    }
    if(!isDefined(var_3._id_F242) || 120 > var_3._id_F242["total"]) {
      continue;
    }
    var_4 = (var_3._id_0267 - var_3._id_0157) / (var_3._id_F242["total"] / 60);
    _func_01ED(var_3, var_3._id_399D, var_4);
  }
}