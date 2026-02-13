/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2058.gsc
*************************************************/

init() {
  level._id_CC07 = [];
  var_0 = getdvarint("#x3210420a7dc973e8c", 1);

  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  _id_10B3(var_0, "online_mp_xpscale");
  var_1 = getdvarint("#x32a2a182348da7327", 1);

  if(var_1 > 4 || var_1 < 0) {
    exitlevel(0);
  }

  _id_10B1(var_1, "online_battle_xpscale_dvar");
  var_2 = getdvarint("#x3dde311efe70e3fb1", 1);

  if(var_2 > 4 || var_2 < 0) {
    exitlevel(0);
  }

  _id_10B2(var_2, "online_operator_xpscale");
  var_3 = getdvarint("#x37c8dbdca5951e25", 1);

  if(var_3 > 4 || var_3 < 0) {
    exitlevel(0);
  }

  addglobalclanxpmultiplier(var_3, "online_clan_xpscale");
  var_4 = getdvarint("#x37ece014de673113d", 1);
  level.sonyxpscale = var_4;
  level.ranktable = [];
  level._id_10DC3 = [];
  level.maxrank = int(_func_0222("mp/rankTable.csv", 0, "maxrank", 1));
  level._id_9C68 = int(_func_0222("mp/rankTable.csv", 0, "maxelder", 1));

  for(var_5 = 0; var_5 <= level.maxrank; var_5++) {
    level.ranktable[var_5][0] = int(_func_0222("mp/rankTable.csv", 0, var_5, 2));
    level.ranktable[var_5][1] = int(_func_0222("mp/rankTable.csv", 0, var_5, 3));
    level.ranktable[var_5][2] = int(_func_0222("mp/rankTable.csv", 0, var_5, 7));
    level.ranktable[var_5][3] = _func_0222("mp/rankTable.csv", 0, var_5, 15);
  }

  _id_0826::init();
  _id_0AA3::_id_C28D(::onplayerspawned);
  level._id_BBFE = [];
  level thread onplayerconnect();
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
  var_1 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_score_") + var_0;

  if(getDvar(var_1) != "") {
    return getdvarint(var_1);
  } else {
    return level._id_CC07[var_0]["value"];
  }
}

_id_6D0C(var_0, var_1) {
  if(!isDefined(level._id_CC07[var_0])) {
    return;
  }
  if(istrue(level._id_C4DB)) {
    return;
  }
  switch (var_1) {
    case "value":
      var_2 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_score_") + var_0;

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
  return level.ranktable[var_0][0];
}

_id_6CDE(var_0) {
  return level.ranktable[var_0][1];
}

getrankinfomaxxp(var_0) {
  return level.ranktable[var_0][2];
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

_id_411C(var_0) {
  var_1 = spawnStruct();
  var_1._id_B64E = var_0 getplayerdata("rankedloadouts", "squadMembers", "player_xp");
  return var_1;
}

_id_411E(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;

  if(var_3 != 0) {
    var_2._id_10FD5 = var_2._id_10FD5 + var_3;
    var_2._id_011A++;
  }
}

_id_411D(var_0, var_1) {
  var_2 = var_1._id_B64E - var_0._id_B64E;
  var_3 = spawnStruct();
  var_3._id_10FD5 = 0;
  var_3._id_011A = 0;

  if(var_2 != 0 || var_3._id_10FD5 != 0) {
    self _meth_870F("dlog_event_player_stats_hack", ["player_xp_start", var_0._id_B64E, "player_xp_end", var_1._id_B64E, "diff_weapon_xp_count", var_3._id_011A, "diff_weapon_xp", var_3._id_10FD5]);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      var_0._id_4120 = _id_411C(var_0);
    }

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["rankxp"] = var_0 getplayerdata("rankedloadouts", "squadMembers", "player_xp");
        var_1 = var_0 getplayerdata("rankedloadouts", "squadMembers", "season_rank");

        if(!isDefined(var_0.pers["xpEarnedThisMatch"])) {
          var_0.pers["xpEarnedThisMatch"] = 0;
        }

        if(isbpxpenabled()) {
          var_0 thread handlexpovertime();
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
      var_0.pers["summary"]["accolade"] = 0;
      var_0.pers["summary"]["weaponXP"] = 0;
      var_0.pers["summary"]["operatorXP"] = 0;
      var_0.pers["summary"]["clanXP"] = 0;
      var_0.pers["summary"]["battlepassXP"] = 0;
    }

    var_0 setclientdvar("#x32add9cc9e0c920a1", 0);

    if(level.playerxpenabled && !isai(var_0)) {
      var_3 = getdvarint("#x36ffcac04370655e7", 1);
      var_4 = var_0 getprivatepartysize() > 1;

      if(var_4) {
        var_0 _id_111C(var_3, "online_mp_party_xpscale");
      }

      if(var_0 getplayerdata(level.progressiongroup, "prestigeDoubleWeaponXp")) {
        var_0._id_BBFD = 1;
      } else {
        var_0._id_BBFD = 0;
      }
    }

    var_0 setplayerdata(level.progressiongroup, "playerTriggeredFavWeaponCombo", 0);
    var_0 setplayerdata(level.progressiongroup, "favWeaponComboOperatorId", 0);
    var_0._id_CBFA = 0;
    var_0._id_CBFD = 0;
    var_0 setclientomnvar("ui_score_event_control", -1);
    var_0 setclientomnvar("ui_potg_score_event_control", -1);
  }
}

handlexpovertime() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = gettime();
  var_1 = var_0;
  var_2 = var_0 + 60000;
  var_3 = 3025 * _id_6A6F();
  var_3 = int(var_3);
  var_4 = 0;

  while(var_4 < 30) {
    var_1 = gettime();

    if(var_1 >= var_2) {
      self reportchallengeuserevent("144115188075856006", [5, var_3, 7, var_3]);
      var_2 = var_2 + 60000;
      var_4++;
    }

    wait 1;
  }
}

onplayerspawned() {
  if(isai(self)) {
    self.pers["rankxp"] = ::scripts\mp\bots\bots_util::_id_66EC();
  } else if(!level.playerxpenabled) {
    self.pers["rankxp"] = 0;
  } else {}

  _id_B80A();
}

_id_B80A() {
  var_0 = self.pers["rankxp"];

  if(var_0 < 0) {
    var_0 = 0;
    self.pers["rankxp"] = 0;
  }

  var_1 = getrankforxp(var_0);
  self.pers["rank"] = var_1;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self._id_2CA1)) {
      var_2 = _id_6C89();
    } else {
      var_2 = 0;
    }

    self setrank(var_1, var_2);
    self.pers["prestige"] = var_2;
  }
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

giverankxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self)) {
    self.owner giverankxp(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  var_5 = _func_03CF(self);
  var_1 = int(var_1 * var_5);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!level.playerxpenabled) {
    if(var_3 == 0) {
      _id_0A9F::_id_4B7E(var_1, var_0);
    }

    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }
  if(!isDefined(level.forceranking) || !level.forceranking) {
    if(level.teambased) {
      var_6 = 0;

      foreach(var_8 in level._id_EF89) {
        if(scripts\mp\utility\teams::_id_6DCA(var_8, "teamCount")) {
          var_6++;

          if(var_6 >= 2) {
            break;
          }
        }
      }

      if(var_6 < 2) {
        return;
      }
    } else {
      var_10 = 0;

      foreach(var_8 in level._id_EF89) {
        var_10 = var_10 + scripts\mp\utility\teams::_id_6DCA(var_8, "teamCount");

        if(var_10 >= 2) {
          break;
        }
      }

      if(var_10 < 2) {
        return;
      }
    }
  }

  if(!var_3) {
    _id_0A9F::_id_4B7E(var_1, var_0);
  }

  thread waitandapplyxp(var_0, var_1, var_2, var_4);
}

waitandapplyxp(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    waitframe();
    scripts\mp\utility\script::_id_1096C();
  }

  var_4 = getrankxp();

  if(updaterank(var_4)) {}

  _id_EC46();
  incrankxp(var_1, var_2, var_0);
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
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_1;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_1;
      break;
    case "medal":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var_1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var_1;
      }

      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var_1;
      break;
    case "combat":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var_1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      break;
    case "looting":
      if(!isDefined(self.pers["lootingXP"])) {
        self.pers["lootingXP"] = var_1;
      } else {
        self.pers["lootingXP"] = self.pers["lootingXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      break;
    case "missions":
      if(!isDefined(self.pers["missionXP"])) {
        self.pers["missionXP"] = var_1;
      } else {
        self.pers["missionXP"] = self.pers["missionXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      break;
    case "accolade":
      self.pers["summary"]["accolade"] = self.pers["summary"]["accolade"] + var_1;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
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

    if(isDefined(var_4) && var_4 == var_0) {
      var_3 iprintln(&"RANK/PLAYER_WAS_PROMOTED", self, var_1 + 1);
    }
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
  if(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_81D3() && !scripts\mp\utility\player::_id_8ACE()) {
    if(!istrue(var_1) || scripts\mp\utility\player::_id_88C7()) {
      _id_BED8(var_0);
      thread _id_5D28();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self._id_CC25 = self._id_CC25 + var_0;
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
  var_0 = self._id_CC01;
  self._id_CC01 = [];

  foreach(var_2 in var_0) {
    _id_CC00(var_2);
  }
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

_id_CBFB(var_0) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return 0;
  }

  var_1 = _id_6D0C(var_0, "dialogAlias");

  if(!isDefined(var_1)) {
    return "";
  }

  return var_1;
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

_id_CC00(var_0) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return;
  }
  if(isDefined(self.owner)) {
    self.owner _id_CC00(var_0);
  }

  if(!isPlayer(self)) {
    return;
  }
  var_1 = _id_6D0C(var_0, "eventID");
  var_2 = _id_6D0C(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_81D3() && !scripts\mp\utility\player::_id_8ACE()) {
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

  self setclientomnvar("ui_potg_score_event_list_" + self._id_CBFD, var_1);
  self setclientomnvar("ui_score_event_list_" + self._id_CBFD, var_1);
  self setclientomnvar("ui_score_event_control", self._id_CBFA % 10);
  self setclientomnvar("ui_potg_score_event_control", self._id_CBFA % 10);
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

incrankxp(var_0, var_1, var_2) {
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

  var_3 = _id_6D0C(var_2, "allowBonus");

  if(istrue(var_3)) {
    var_0 = var_0 * 1.38;
    var_0 = int(var_0);
  }

  var_4 = "";
  var_5 = -1;
  var_6 = 0;

  if(isDefined(var_1) && _id_0826::_id_10DD2(var_1.basename)) {
    var_4 = scripts\mp\utility\weapon::_id_69D8(var_1.basename);
    var_7 = _func_0222("mp/statstable.csv", 5, var_4, 4);
    var_8 = var_7 + "_variant_0";
    var_5 = int(_func_0222("loot/weapon_ids.csv", 9, var_8, 0));
    var_6 = var_0;

    if(istrue(var_3)) {
      var_6 = var_6 * _id_0826::_id_6E87(var_1);
      var_6 = var_6 * 1.2;
      var_6 = int(var_6);
    }
  }

  if(var_6 > 0 && var_5 == -1) {}

  if(isDefined(var_2) && var_2 == "WeaponMatchBonus") {
    var_0 = 0;
  }

  var_9 = getrankxp();
  var_10 = int(min(var_9 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var_10 >= getrankinfomaxxp(level.maxrank)) {
    var_10 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["rankxp"] = var_10;
  var_11 = var_0;

  if(istrue(var_3)) {
    var_12 = _id_6CE1();
    var_11 = var_11 * var_12;
    var_11 = int(var_11);
  }

  var_13 = var_0;

  if(istrue(var_3)) {
    var_14 = _id_6905();
    var_15 = _id_6CE0();
    var_16 = _id_6A74();
    var_13 = var_13 * var_14 * var_15 * var_16;
    var_13 = int(var_13);
  }

  var_17 = -1;
  var_18 = self._id_AC3D._id_AC41;

  if(isDefined(var_18)) {
    var_17 = int(_func_0222("loot/operator_ids.csv", 1, var_18, 0));
  }

  var_19 = var_0;

  if(istrue(var_3)) {
    var_20 = _id_6BDB();
    var_19 = var_19 * var_20;
    var_19 = int(var_19);
  }

  var_21 = var_0;

  if(istrue(var_3)) {
    var_22 = getclanxpmultipliertotal();
    var_21 = var_21 * var_22;
    var_21 = int(var_21);
  }

  if(var_17 != -1 && isDefined(var_18) && var_5 != -1 && var_4 != "") {
    var_23 = _func_0222("operators.csv", 1, var_18, 28);

    if(var_4 == var_23 + "_mp") {
      var_6 = var_6 * 1.1;
      var_6 = int(var_6);
      var_19 = var_19 * 1.1;
      var_19 = int(var_19);
      self setplayerdata(level.progressiongroup, "playerTriggeredFavWeaponCombo", 1);
      self setplayerdata(level.progressiongroup, "favWeaponComboOperatorId", var_17);
    }
  }

  var_24 = [];
  var_25 = 0;

  if(var_11 > 0) {
    var_24[var_24.size] = 0;
    var_24[var_24.size] = var_11;

    if(level._id_C02A["online_mp_xpscale"] >= 2) {
      var_25 = var_25 | 1;
    }
  }

  if(var_6 > 0) {
    var_24[var_24.size] = 2;
    var_24[var_24.size] = var_6;
    var_24[var_24.size] = 1;
    var_24[var_24.size] = var_5;

    if(level._id_10DC4["online_mp_weapon_xpscale"] >= 2) {
      var_25 = var_25 | 2;
    }
  }

  if(isbpxpenabled()) {
    if(var_13 > 0) {
      var_24[var_24.size] = 5;
      var_24[var_24.size] = var_13;

      if(level._id_2381["online_battle_xpscale_dvar"] >= 2) {
        var_25 = var_25 | 8;
      }
    }
  }

  if(var_19 > 0) {
    var_24[var_24.size] = 4;
    var_24[var_24.size] = var_19;
    var_24[var_24.size] = 3;
    var_24[var_24.size] = var_17;

    if(level._id_AC40["online_operator_xpscale"] >= 2) {
      var_25 = var_25 | 4;
    }
  }

  if(var_21 > 0) {
    var_24[var_24.size] = 6;
    var_24[var_24.size] = var_21;

    if(level.clanrankxpmultipliers["online_clan_xpscale"] >= 2) {
      var_25 = var_25 | 16;
    }
  }

  if(var_24.size == 0) {
    return;
  }
  var_24[var_24.size] = 8;
  var_24[var_24.size] = var_25;
  self reportchallengeuserevent("144115188075856006", var_24);
  _id_07A9::_id_9790(self, var_0, var_4, var_6, var_2);
  _id_C152(var_2, var_11, var_6, var_13, var_19, var_21);

  if(isDefined(var_1) && (scripts\mp\utility\weapon::_id_879A(var_1) || scripts\mp\utility\weapon::_id_879C(var_1))) {
    if(!scripts\mp\utility\weapon::_id_897E(var_1) || scripts\mp\utility\game::getgametype() == "br") {
      var_26 = spawnStruct();
      var_26._id_04FE = scripts\mp\utility\weapon::getweaponrootname(var_1);
      var_26.statname = "xp_earned";
      var_26.incvalue = var_6;
      var_26._id_04CC = -1;
      _id_06E2::_id_4C2A("callback_update_weapon_stats", var_26);
    }
  }
}

_id_EC46() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var_1 > var_0) {
    return;
  }
  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var_0);
}

_id_46D4(var_0, var_1, var_2) {
  wait(var_0);
  thread _id_0A9F::_id_7003(var_1);
}

_id_6A68() {
  if(!isDefined(level._id_60FC)) {
    var_0 = getdvarfloat("#x3ca0ba2dcaed1d421", 1.0);

    if(var_0 != 1.0) {
      level._id_60FC = var_0;
    } else {
      level._id_60FC = float(_func_0222("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 17));
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

getintensityxpmultiplier() {
  var_0 = 1.0;

  switch (scripts\mp\utility\game::_id_6C73()) {
    case "very_low":
      var_0 = 1.1;
      break;
    case "low":
      var_0 = 1.1;
      break;
    case "medium":
      var_0 = 1.0;
      break;
    case "high":
      var_0 = 1.0;
      break;
    case "very_high":
      var_0 = 1.0;
      break;
  }

  return var_0;
}

getmapxpmultiplier() {
  var_0 = 1.0;

  switch (scripts\cp_mp\utility\game_utility::_id_6B2D()) {
    default:
      var_0 = 1.0;
      break;
  }

  return var_0;
}

_id_6CE1() {
  var_0 = _id_6CE0();
  var_1 = _id_6A74();
  var_2 = _id_6DD7(self.team);
  var_3 = _id_6C3F();
  var_4 = _id_6A68();
  var_5 = getintensityxpmultiplier();
  var_6 = getmapxpmultiplier();
  var_7 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_8 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5 * var_6 * var_7;
  return var_8;
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
  var_3 = _id_6A68();
  var_4 = getintensityxpmultiplier();
  var_5 = getmapxpmultiplier();
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5 * 1.32 * 0.72;
  return var_6;
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
  var_2 = _id_6A68();
  var_3 = getintensityxpmultiplier();
  var_4 = getmapxpmultiplier();
  var_5 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
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
  var_2 = _id_6A68();
  var_3 = getintensityxpmultiplier();
  var_4 = getmapxpmultiplier();
  var_5 = scripts\engine\utility::ter_op(_func_047B(self), 1.0, 0);
  var_6 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_7 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5 * var_6;
  return var_7;
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

isbpxpenabled() {
  var_0 = getdvarint("#x31f918455340def2f", 0);

  if(isDefined(var_0) && var_0 < 6) {
    return 1;
  } else {
    return 0;
  }
}