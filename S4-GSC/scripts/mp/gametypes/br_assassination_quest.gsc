/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_assassination_quest.gsc
***********************************************************/

init() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("assassination", 1);

  if(!var_0) {
    return;
  }
  scripts\mp\gametypes\br_quest_util::_id_C2A2("assassination_all");
  scripts\mp\gametypes\br_quest_util::_id_C2A2("assassination_all_timed");
  level._id_2A70 = getdvarint("#x35412426037003668", 0) != 0;
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_BEAB = getdvarint("#x3f517e93b10d3300d", 180);
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_BEAC = getdvarint("#x3bf006a38a0c0a6f", 60);
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_C64C = getdvarint("#x3a29ad24fef7e0ed0", 1);
  scripts\mp\gametypes\br_quest_util::_id_C2A5("assassination", ::_id_1A1E, 10);
  scripts\mp\gametypes\br_quest_util::_id_C2A5("assassination", ::_id_1A1F, 0.2);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("assassination", ::_id_1A20);
  scripts\mp\gametypes\br_quest_util::_id_C28C("assassination", ::_id_1A1A);
  scripts\mp\gametypes\br_quest_util::_id_C288("assassination", ::_id_1A1B);
  var_1 = scripts\engine\utility::array_add(level._id_BEAF._id_45B2, ::_id_5A47);
  var_1 = scripts\engine\utility::array_add(level._id_BEAF._id_45B2, scripts\mp\gametypes\br_quest_util::_id_5A4A);
  scripts\mp\gametypes\br_quest_util::_id_C29B("assassination", var_1, 0);
  scripts\mp\gametypes\br_quest_util::_id_BEBA("assassination", 1);
  scripts\mp\gametypes\br_quest_util::_id_C290("assassination", ::_id_1A17);
  scripts\mp\gametypes\br_quest_util::_id_C28F("assassination", ::_id_1A16);
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_15F2 = [];
  _id_1485();
  game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
  game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
  game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
  game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
  game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
  game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
}

_id_5A47(var_0) {
  if(isDefined(var_0._id_7544) && var_0._id_7544) {
    return 0;
  }

  return 1;
}

_id_1A1E() {
  if(self._id_02D0 == "_all_timed") {
    return;
  }
  if(!isDefined(self._id_EEF3)) {
    _id_6B7A();
  }

  _id_48B6(self._id_EEF3);
  _id_48B7();
  _id_FC0E(self._id_EF0A);
}

_id_1A1F() {
  _id_48AA();
}

_id_1A20() {
  scripts\mp\gametypes\br_quest_util::_id_C305(self._id_7BD8);
  _id_C46C();
}

_id_EDD3(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_7000(self.team, "br_mission_pickup_tablet");
  var_1 = self.team;
  var_2 = _id_48B5(self);
  var_3 = _id_6FD6(var_1, var_2, var_0.index, self, "", var_0);

  if(!isDefined(var_3)) {
    _id_0A99::_id_D5EB("br_assassination_notargets", undefined, 5);
    var_4 = spawnStruct();
    var_4.origin = var_0.origin;
    var_4.angles = var_0.angles;
    var_4._id_8B39 = 0;

    if(getDvar("#x3f59526763711edc4", "") == "dmz") {
      var_5 = "mp/loot_set_cache_contents_dmz.csv";
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "health", var_5);
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "ammo", var_5);
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(1, 1, "plunder", var_5);
    } else {
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "health");
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "ammo");
      var_4 scripts\mp\gametypes\br_lootcache::_id_35A1(1, 1, "plunder");
    }

    return;
  }

  var_3 _id_6FDC(self);
}

_id_6FDC(var_0) {
  var_1 = spawnStruct();
  var_1._id_56DD = [];
  var_1._id_56DD[0] = self._id_EEF3;

  if(isDefined(var_0)) {
    var_1._id_56DD[1] = var_0;
  }

  var_1._id_EA61 = self._id_EEF3.name;
  scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_EF0A, "br_assassination_quest_start_target_team", var_1);
  scripts\mp\gametypes\br_quest_util::_id_4B7A(self._id_EEF3, "br_assassination_quest_start_target_player");

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_hunted", self._id_EF0A, 1);
  }

  var_1._id_B97D = scripts\mp\gametypes\br_quest_util::_id_6C99(scripts\mp\gametypes\br_quest_util::_id_6CA3(self._id_7BD8));
  scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7BD8, "br_assassination_quest_start_hunter_team", var_1);

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_accept", self._id_7BD8, 1);
  }

  if(isDefined(var_0)) {
    scripts\mp\gametypes\br_quest_util::_id_4B7A(var_0, "br_assassination_quest_start_tablet_finder", var_1);
    scripts\mp\gametypes\br_quest_util::_id_4B81(self._id_7BD8, var_0, 6, scripts\mp\gametypes\br_quest_util::_id_6C95("assassination"));
  }
}

_id_6FD6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\gametypes\br_quest_util::_id_4039("assassination", var_0, var_2, var_5);
  var_6._id_02D0 = var_4;

  if(!isDefined(var_6._id_02D0)) {
    var_6._id_02D0 = "";
  }

  var_6 scripts\mp\gametypes\br_quest_util::_id_C2C0(var_0, var_3);
  var_6._id_7BD8 = var_0;
  var_6._id_EF0A = var_1;
  var_6._id_EEFC = 0;
  var_6._id_7BD7 = 0;
  var_6._id_EF0B = var_6 scripts\mp\gametypes\br_quest_util::_id_6E31(var_1).size;

  if(!isDefined(var_6._id_EF0A)) {
    _id_315B(var_6);
    return undefined;
  }

  if(var_6._id_02D0 != "_all") {
    var_6 scripts\mp\gametypes\br_quest_util::_id_BEBB(scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_BEAB, 4);
  }

  var_6 scripts\mp\gametypes\br_quest_util::_id_4038(4, 3);
  var_6 _id_6B7A(var_3);

  if(!isDefined(var_6._id_EEF3)) {
    _id_315B(var_6);
    return undefined;
  }

  if(var_6._id_02D0 == "_all_timed") {
    level._id_EF6A[var_0]["hasFailed"] = 0;
  }

  var_6 _id_48B6(var_6._id_EEF3);
  var_6 _id_48B7();
  var_6 _id_FC0E(var_6._id_EF0A);
  var_6 _id_48AA();
  scripts\mp\gametypes\br_quest_util::_id_1118("assassination", var_6);
  scripts\mp\gametypes\br_quest_util::_id_E72C("assassination", var_3, var_0);
  return var_6;
}

_id_315B(var_0) {
  if(isDefined(var_0._id_9AAD)) {
    var_0 scripts\mp\gametypes\br_quest_util::_id_4788();
  }

  var_0._id_0372 = "no_locale";
  var_0 scripts\mp\gametypes\br_quest_util::_id_C305(var_0._id_7BD8);
}

_id_48B5(var_0) {
  var_1 = var_0.team;
  var_2 = undefined;
  var_3 = level.players;
  var_4 = scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_15F2;
  var_5 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");
  var_6 = scripts\engine\utility::_id_1B9D(var_4, var_5);
  var_7 = 0;
  var_8 = level._id_BEAF._id_BEB8["assassination"]._id_5A53[0];
  var_9 = 5000;
  var_10 = 30000;

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    var_9 = level._id_BEA0;
    var_10 = level._id_BE9F;
  }

  while(!isDefined(var_2)) {
    var_7 = var_7 + 5000;
    var_11 = scripts\engine\utility::_id_6369(var_0.origin, var_3, var_6, undefined, var_9 + var_7, var_9);
    var_11 = scripts\mp\gametypes\br_quest_util::_id_6E30(var_11, var_8);

    if(!isDefined(var_11) || var_11.size == 0) {
      if(var_7 > var_10) {
        var_11 = scripts\engine\utility::_id_6369(var_0.origin, var_3, var_6, undefined, undefined, undefined);
        var_11 = scripts\mp\gametypes\br_quest_util::_id_6E30(var_11, var_8);

        if(!isDefined(var_11) || var_11.size == 0) {
          return undefined;
        }
      } else
        continue;
    }

    var_12 = [];

    foreach(var_14 in var_11) {
      var_12[var_14.team] = ::scripts\mp\gametypes\br_quest_util::_id_6E31(var_14.team, var_8).size;
    }

    var_16 = scripts\mp\gametypes\br_quest_util::_id_6DC7(var_1, var_8);
    var_17 = scripts\mp\gametypes\br_quest_util::_id_6E31(var_1, var_8).size;

    foreach(var_25, var_19 in var_12) {
      if(!isDefined(var_2)) {
        var_2 = var_25;
        continue;
      }

      if(getDvar("#x3f59526763711edc4", "") == "dmz") {
        var_20 = scripts\mp\gametypes\br_gametype_dmz::_id_6DC6(var_2);
        var_21 = scripts\mp\gametypes\br_gametype_dmz::_id_6DC6(var_25);

        if(var_21 > 100000) {
          if(var_21 > var_20) {
            var_2 = var_25;
            continue;
          }
        }
      }

      var_22 = abs(var_17 - var_19);

      if(var_22 < abs(var_17 - var_12[var_2])) {
        var_2 = var_25;
        continue;
      } else if(var_22 > abs(var_17 - var_12[var_2])) {
        continue;
      }
      if(var_19 > var_12[var_2]) {
        var_2 = var_25;
        continue;
      } else if(var_19 < var_12[var_2]) {
        continue;
      }
      var_23 = scripts\mp\gametypes\br_quest_util::_id_6DC7(var_25, var_8);
      var_24 = scripts\mp\gametypes\br_quest_util::_id_6DC7(var_2, var_8);

      if(distance2d(var_16, var_23) < distance2d(var_16, var_24)) {
        var_2 = var_25;
        continue;
      }
    }
  }

  if(isDefined(var_2)) {
    scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_15F2 = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_15F2, scripts\mp\utility\teams::_id_6DCA(var_2, "players"));
  }

  return var_2;
}

_id_48B4(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = scripts\mp\gametypes\br_quest_util::_id_6DC7(self._id_7BD8);

  foreach(var_7 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(!scripts\mp\gametypes\br_quest_util::_id_89A6(var_7, _id_6A36(self._id_02D0))) {
      continue;
    }
    if(scripts\mp\gametypes\br_public::_id_8805()) {
      if(scripts\engine\utility::is_equal(var_7._id_039B, "assassination_target")) {
        var_4 = var_7;
        break;
      }
    }

    if(!isDefined(var_4)) {
      var_4 = var_7;
    }

    if(getDvar("#x3f59526763711edc4", "") == "dmz") {
      var_8 = var_7._id_B956;

      if(isDefined(var_8)) {
        var_9 = distance2dsquared(var_1.origin, var_7.origin);

        if(!isDefined(var_3) || var_9 <= var_3) {
          if(!isDefined(var_2) || var_8 >= var_2) {
            var_2 = var_8;
            var_3 = var_9;
            var_4 = var_7;
          }
        }
      }

      continue;
    }

    if(distance2d(var_5, var_7.origin) < distance2d(var_5, var_4.origin)) {
      var_4 = var_7;
    }
  }

  var_4._id_7544 = 0;
  self._id_EEF3 = var_4;
}

_id_48B6(var_0) {
  var_1 = (var_0.origin[0], var_0.origin[1], _id_695D());

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    var_1 = var_1 + scripts\engine\math::_id_BFF0() * randomfloatrange(_id_695C(), _id_695B());
  }

  scripts\mp\gametypes\br_quest_util::_id_A249(var_1);
}

_id_48B7() {
  if(scripts\mp\gametypes\br_public::_id_8805()) {
    scripts\mp\gametypes\br_quest_util::_id_D5EE(level._id_9889);
    self._id_F143 = 2;
  } else {
    var_0 = scripts\mp\gametypes\br_quest_util::_id_6E31(self._id_7BD8);

    if(var_0.size == 0) {
      scripts\mp\gametypes\br_quest_util::_id_D5EE(3500);
      self._id_F143 = 0;
    } else {
      var_1 = undefined;

      foreach(var_3 in var_0) {
        var_4 = distance2d(var_3.origin, self._id_EEF3.origin);

        if(!isDefined(var_1) || var_4 < var_1) {
          var_1 = var_4;
        }
      }

      if(var_1 > 5000) {
        scripts\mp\gametypes\br_quest_util::_id_D5EE(3500);
        self._id_F143 = 0;
        return;
      }

      if(var_1 > 2500) {
        scripts\mp\gametypes\br_quest_util::_id_D5EE(2000);
        self._id_F143 = 1;
        return;
      }

      scripts\mp\gametypes\br_quest_util::_id_D5EE(1500);
      self._id_F143 = 2;
    }
  }
}

_id_48AA() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "players")) {
    var_2 = var_1 scripts\mp\gametypes\br_public::_id_8990();
    var_3 = isDefined(var_1._id_1A10) && var_1._id_1A10;

    if(var_2 && var_3) {
      var_1 _id_78E9(self);
    }

    if(!var_2 && !var_3) {
      var_1 _id_DC85(self);
    }
  }

  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
    var_2 = var_1 scripts\mp\gametypes\br_public::_id_8990();
    var_3 = isDefined(var_1._id_1A28) && var_1._id_1A28;

    if(var_2 && var_3) {
      var_1 _id_78EA();
    }

    if(!var_2 && !var_3) {
      var_1 _id_DC86(self._id_EEF3, self._id_F143);
    }
  }
}

_id_1A17() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
    var_1 setclientomnvar("ui_br_assassination_target_timer", self._id_9F9F);
  }

  if(self._id_02D0 == "_all_timed") {
    thread _id_1CDC();
  }
}

_id_1A16() {
  if(self._id_02D0 == "_all_timed") {
    scripts\mp\utility\teams::_id_D70F(self._id_EF0A, "hasFailed", 1);
    _id_148B(self._id_7BD8);
    scripts\mp\gametypes\br_quest_util::_id_C50F();
  } else {
    scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7BD8, "br_assassination_timer_expire_hunters_lose");
    var_0 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self._id_EF0A);
    var_1 = scripts\mp\gametypes\br_quest_util::_id_6C98("assassination", var_0);
    self._id_C80A = "_averted";
    var_2 = spawnStruct();
    var_3 = scripts\mp\gametypes\br_quest_util::_id_6C95("assassination");
    var_4 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("assassination", self._id_C80A, self._id_02D0));
    var_2._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_3, var_0, var_4);
    scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_EF0A, "br_assassination_timer_expire_targets_win", var_2);
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_fail", self._id_7BD8, 1);
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_hunted_timed_out", self._id_EF0A, 1);

    if(getDvar("#x3f59526763711edc4", "") != "dmz") {
      scripts\mp\gametypes\br_quest_util::_id_6FDB(self._id_EF0A, self._id_EEF3.origin, self._id_EEF3.angles, self._id_C812);
    }
  }
}

_id_1A1A(var_0, var_1) {
  if(var_1 scripts\mp\gametypes\br_public::_id_8990() || var_0 scripts\mp\gametypes\br_public::_id_8990()) {
    return;
  }
  thread _id_1A1C(var_1, var_0);
}

_id_1A1B(var_0) {
  thread _id_1A1C(var_0);
}

_id_1A1C(var_0, var_1) {
  if(self._id_02D0 == "_all_timed" && scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "hasFailed")) {
    return;
  }
  if(scripts\mp\gametypes\br_public::_id_8805()) {
    if(!isbot(var_0)) {
      return;
    }
  }

  if(var_0.team == self._id_EF0A) {
    if(var_0 == self._id_EEF3) {
      var_2 = var_0._id_1DDE;
      wait 0.75;
      var_3 = spawnStruct();
      var_4 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self._id_7BD8);
      var_5 = scripts\mp\gametypes\br_quest_util::_id_6C95("assassination");

      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == self._id_7BD8) {
        var_6 = "br_assassination_complete_hunters_win";
        self._id_C80A = "_target_killed";
        scripts\mp\gametypes\br_quest_util::_id_4B81(self._id_7BD8, var_1, 8, scripts\mp\gametypes\br_quest_util::_id_6C95("assassination"));
      } else {
        var_6 = "br_assassination_complete_target_vanished";
        self._id_C80A = "_target_vanished";
      }

      var_7 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("assassination", self._id_C80A, self._id_02D0));
      var_3._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_5, var_4, var_7);
      scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7BD8, var_6, var_3);

      if(!scripts\mp\gametypes\br_public::_id_8805()) {
        level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_success", self._id_7BD8, 1);
      }

      if(isDefined(var_1)) {
        self._id_C810 = var_1.origin;
        self._id_C805 = var_1.angles;
      }

      if(isDefined(var_2)) {
        foreach(var_9 in var_2) {
          if(isDefined(var_9.team) && var_9.team == self._id_7BD8) {
            scripts\mp\gametypes\br_quest_util::_id_C24A(var_9);
          }
        }
      }

      self._id_0372 = "success";
      scripts\mp\gametypes\br_quest_util::_id_C50F();
    }

    if(self._id_02D0 == "_all_timed") {
      if(!isDefined(level._id_7262) || isDefined(level._id_7262) && !istrue(level._id_7262._id_DD08)) {
        foreach(var_12 in scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "players")) {
          if(istrue(var_12.inlaststand)) {
            var_12 _id_07E8::_id_5B1D("use_hold_revive_success", var_12);
          }

          if(!isalive(var_12)) {
            var_12 scripts\mp\gametypes\br_pickups::_id_1122(1);
            var_12 thread scripts\mp\gametypes\br_gulag::_id_B6C6();
          }
        }
      }
    }
  } else if(var_0.team == self._id_7BD8) {
    if(!scripts\mp\gametypes\br_quest_util::_id_8A9A(self._id_7BD8, _id_6A36(self._id_02D0))) {
      if(getDvar("#x3f59526763711edc4", "") == "dmz") {
        self._id_0372 = "fail";
        scripts\mp\gametypes\br_quest_util::_id_C50F();
      } else {
        self._id_C80A = "_averted";
        var_14 = scripts\mp\gametypes\br_quest_util::_id_6FDB(self._id_EF0A, var_0.origin, var_0.angles, self._id_C812);
        var_3 = spawnStruct();
        var_3._id_B97D = scripts\mp\gametypes\br::_id_6516(var_14["plunder"]);
        scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_EF0A, "br_assassination_complete_targets_win", var_3);
        self._id_0372 = "fail";
        scripts\mp\gametypes\br_quest_util::_id_C50F();
      }
    }
  }
}

_id_6B7A(var_0) {
  _id_48B4(self._id_EF0A, var_0);
  _id_48B6(self._id_EEF3);
  _id_48B7();
  _id_FC0D();
}

_id_C46C() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "players")) {
    var_1 _id_78E9(self);
  }

  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
    var_1 _id_78EA();
  }

  scripts\mp\gametypes\br_quest_util::_id_4788();
}

_id_6C53() {
  if(level._id_2A70) {
    return self._id_8DA5.size;
  } else {
    return self._id_0267;
  }
}

_id_6A36(var_0) {
  switch (var_0) {
    case "_all_timed":
    case "_all":
      return level._id_BEAF._id_45B2;
    default:
      return 0;
  }
}

_id_DC85(var_0) {
  self._id_1A10 = 1;
  scripts\mp\gametypes\br_quest_util::_id_F921("assassination" + var_0._id_02D0);
  var_0 scripts\mp\gametypes\br_quest_util::_id_DCDA(self);
}

_id_78E9(var_0) {
  self._id_1A10 = 0;
  scripts\mp\gametypes\br_quest_util::_id_F91E();
  var_0 scripts\mp\gametypes\br_quest_util::_id_7913(self);
}

_id_FC0C(var_0, var_1) {
  if(isDefined(self._id_1A28) && self._id_1A28) {
    var_2 = var_0 getentitynumber();
  } else {
    var_2 = -1;
  }

  var_2 = var_0 getentitynumber();
  var_2 = var_2 + 1;
  var_3 = var_1 << 8 | var_2;
  self setclientomnvar("ui_br_assassination_target", var_3);
}

_id_FC0E(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
    var_2 _id_FC0C(self._id_EEF3, self._id_F143);
  }
}

_id_DC86(var_0, var_1) {
  self._id_1A28 = 1;
  _id_FC0C(var_0, var_1);
}

_id_78EA() {
  self._id_1A28 = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

_id_FC0D() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "players")) {
    var_1 _id_DC85(self);
    var_1 scripts\mp\gametypes\br_quest_util::_id_F920(self._id_EEF3 getentitynumber());
  }

  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
    var_1 _id_DC86(self._id_EEF3, self._id_F143);
  }
}

_id_1CDC() {
  self notify("assassinationTimeWarning");
  self endon("assassinationTimeWarning");
  self endon("removed");
  var_0 = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(var_2 in var_0) {
    var_3 = (self._id_9F9F - gettime()) / 1000;
    var_4 = var_3 - var_2;

    if(var_4 < 0) {
      continue;
    }
    wait(var_4);
    var_5 = int(var_2 / 60);
    var_6 = scripts\mp\gametypes\br_quest_util::_id_6E30(scripts\mp\utility\teams::_id_6DCA(self._id_7BD8, "players"), _id_6A36(self._id_02D0));

    foreach(var_8 in var_6) {
      var_9 = gettime() + var_2 * 1000;
      var_10 = 5;

      if(var_2 <= 20) {
        var_10 = var_2;
      }

      var_8 _id_0A99::_id_D5EB("br_assassin_mission_time_warning", var_9, var_10);

      if(var_5 >= 2) {
        var_8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_MIN", var_5);
        continue;
      }

      var_8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_SEC", var_2);
    }
  }
}

_id_1485() {
  level thread _id_1484();
}

_id_1484() {
  _id_07D1::_id_60C2("prematch_done");
  var_0 = getdvarint("#x32aa91d1834bc79f8", 0);

  if(!var_0) {
    return;
  }
  var_1 = getdvarint("#x3c0af7338062774d7", 120);
  _id_4AF4();
  wait(var_1);
  _id_1483(var_0);
}

_id_1483(var_0) {
  var_1 = spawnStruct();
  var_1._id_EF81 = [];
  var_1._id_9017 = [];
  var_1._id_C726 = int(getdvarfloat("#x3f31c926a69661b76", 10) * 1000);

  if(var_0 == 1) {
    var_1._id_02D0 = "_all";
  } else if(var_0 == 2) {
    var_1._id_02D0 = "_all_timed";
  } else {}

  if(var_1._id_02D0 == "_all_timed") {
    var_1 _id_1487();
  } else {
    var_1 _id_1486();
  }

  var_1 thread _id_1481();
  var_1 thread _id_148F();
}

_id_1482() {
  var_0 = (0, 0, 0);
  var_1 = _id_148A();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = undefined;
    var_6 = scripts\mp\utility\teams::_id_6DCA(var_4, "players");

    foreach(var_8 in var_6) {
      if(var_8 scripts\mp\gametypes\br_public::_id_8990()) {
        continue;
      }
      if(var_8 scripts\mp\gametypes\br_public::_id_898B()) {
        var_5 = var_8;
        break;
      }

      if(!isDefined(var_5)) {
        var_5 = var_8;
      }
    }

    if(!isDefined(var_5)) {
      continue;
    }
    var_10 = spawnStruct();
    var_10.team = var_4;
    var_10._id_B9FE = var_5.origin;
    var_0 = var_0 + var_10._id_B9FE;
    var_2[var_2.size] = var_10;
  }

  if(var_2.size < 2) {
    return var_2;
  }

  var_0 = var_0 / var_2.size;

  foreach(var_10 in var_2) {
    var_13 = var_10._id_B9FE - var_0;
    var_10._id_E03D = vectortoangles(var_13)[1];
  }

  var_2 = scripts\mp\utility\script::_id_BEF7(var_2, ::_id_1489);
  return var_2;
}

_id_1486() {
  var_0 = _id_1482();
  var_1 = getdvarint("#x35741f2912287709", 150);
  var_2 = var_0.size;

  if(isDefined(var_1)) {
    var_1 = int(min(var_1, var_2));
  } else {
    var_1 = var_2;
  }

  var_3 = int(var_2 / var_1);
  var_4 = var_2 % var_1;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5[var_6] = var_1;
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5[var_6 % var_3]++;
  }

  var_7 = 0;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_1 = var_5[var_6];

    for(var_8 = 0; var_8 < var_1; var_8++) {
      var_9 = var_0[var_7 + var_8].team;
      var_10 = _id_10FA4(var_8 - 1, var_1);
      var_11 = _id_10FA4(var_8 + 1, var_1);
      var_12 = var_0[var_7 + var_10].team;
      var_13 = var_0[var_7 + var_11].team;
      var_14 = spawnStruct();
      var_14._id_EEA1 = var_12;
      var_14._id_EEAB = var_13;
      self._id_EF81[var_9] = var_14;
    }

    var_7 = var_7 + var_1;
  }
}

_id_1487() {
  var_0 = getdvarfloat("#x3fcb95a70a9c62207", 10000);
  var_1 = _id_1482();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2].team;

    if(isDefined(self._id_EF81[var_3])) {
      continue;
    }
    for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
      if(var_4 % 2) {
        var_5 = int(-0.5 * var_4 - 0.5);
      } else {
        var_5 = int(0.5 * var_4 + 1);
      }

      var_6 = _id_10FA4(var_2 + var_5, var_1.size);
      var_7 = var_1[var_6].team;

      if(isDefined(self._id_EF81[var_7])) {
        continue;
      }
      var_8 = var_1[var_6]._id_B9FE;
      var_9 = var_1[var_2]._id_B9FE;

      if(distance(var_8, var_9) > var_0) {
        continue;
      }
      var_10 = spawnStruct();
      var_10._id_EEA1 = var_7;
      var_10._id_EEAB = var_7;
      self._id_EF81[var_3] = var_10;
      var_11 = spawnStruct();
      var_11._id_EEA1 = var_3;
      var_11._id_EEAB = var_3;
      self._id_EF81[var_7] = var_11;
      break;
    }
  }
}

_id_148A() {
  var_0 = gettime();
  var_1 = [];

  foreach(var_5, var_3 in level._id_EF6A) {
    if(isDefined(self._id_EF81[var_5])) {
      continue;
    }
    var_4 = self._id_9017[var_5];

    if(isDefined(var_4) && var_0 < var_4 + self._id_C726) {
      continue;
    }
    if(!scripts\mp\gametypes\br_quest_util::_id_8A9A(var_5, _id_6A36(self._id_02D0))) {
      continue;
    }
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

_id_1488(var_0) {
  var_0 waittill("removed");
  self._id_9017[var_0._id_7BD8] = gettime();
  self notify("update");
}

_id_148F() {
  var_0 = getdvarint("#x33388b0d8a0c24ba1", 10);

  for(;;) {
    scripts\engine\utility::_id_108F5("update", var_0);

    if(self._id_02D0 == "_all_timed") {
      _id_148D();
      continue;
    }

    _id_148C();
  }
}

_id_148D() {
  var_0 = [];

  foreach(var_3, var_2 in self._id_EF81) {
    if(!isDefined(level._id_BEAF._id_BEB8["assassination"]._id_8300[var_3])) {
      var_0[var_0.size] = var_3;
    }
  }

  foreach(var_3 in var_0) {
    self._id_EF81[var_3] = undefined;
  }

  _id_1487();
  _id_1481();
}

_id_148C() {
  var_0 = [];

  foreach(var_3, var_2 in self._id_EF81) {
    if(!isDefined(level._id_BEAF._id_BEB8["assassination"]._id_8300[var_3])) {
      if(var_2._id_EEAB == var_2._id_EEA1) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  foreach(var_3 in var_0) {
    self._id_EF81[var_3] = undefined;
  }

  var_6 = _id_148A();
  var_7 = var_6.size;
  var_0 = [];

  foreach(var_3, var_2 in self._id_EF81) {
    if(!scripts\mp\gametypes\br_quest_util::_id_8A9A(var_3, _id_6A36(self._id_02D0))) {
      if(var_7 > 0) {
        var_7--;
        var_9 = var_6[var_7];
        self._id_EF81[var_9] = spawnStruct();
        self._id_EF81[var_9]._id_EEAB = var_2._id_EEAB;
        self._id_EF81[var_9]._id_EEA1 = var_2._id_EEA1;
        self._id_EF81[var_2._id_EEA1]._id_EEAB = var_9;
        self._id_EF81[var_2._id_EEAB]._id_EEA1 = var_9;
      } else {
        self._id_EF81[var_2._id_EEA1]._id_EEAB = var_2._id_EEAB;
        self._id_EF81[var_2._id_EEAB]._id_EEA1 = var_2._id_EEA1;
      }

      var_0[var_0.size] = var_3;
    }
  }

  foreach(var_3 in var_0) {
    self._id_EF81[var_3] = undefined;
  }

  if(var_7 >= 2) {
    for(var_12 = 0; var_12 < var_7; var_12++) {
      var_3 = var_6[var_12];
      var_13 = _id_10FA4(var_12 - 1, var_7);
      var_14 = _id_10FA4(var_12 + 1, var_7);
      var_15 = var_6[var_13];
      var_16 = var_6[var_14];
      var_17 = spawnStruct();
      var_17._id_EEA1 = var_15;
      var_17._id_EEAB = var_16;
      self._id_EF81[var_3] = var_17;
    }
  }

  if(self._id_EF81.size < 2) {
    return;
  }
  _id_1481();
}

_id_1481() {
  foreach(var_6, var_1 in self._id_EF81) {
    if(isDefined(level._id_BEAF._id_BEB8["assassination"]._id_8300[var_6])) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_1._id_EEAB;
    var_4 = "all_" + var_2 + "_" + var_3;
    var_5 = _id_6FD6(var_2, var_3, var_4, undefined, self._id_02D0);

    if(isDefined(var_5)) {
      var_5 _id_6FDC();

      if(self._id_02D0 == "_all_timed") {
        var_5 thread _id_148E();
      }

      thread _id_1488(var_5);
    }
  }
}

_id_148E() {
  self endon("removed");
  var_0 = getdvarfloat("#x3345acc8db2e1a3a1", 10);
  var_1 = getdvarfloat("#x3d0f465c4a3b052fe", 1.0);

  for(;;) {
    _id_1A1E();
    _id_48B6(self._id_EEF3);
    var_2 = _id_6CA9();
    var_3 = var_0 - var_1;
    wait(var_3 * var_2 + var_1);
  }
}

_id_1489(var_0, var_1) {
  return var_0._id_E03D <= var_1._id_E03D;
}

_id_148B(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6E30(scripts\mp\utility\teams::_id_6DCA(var_0, "players"));

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      var_3 _meth_81FA(var_3.origin, var_3);
    }
  }

  scripts\mp\gametypes\br_quest_util::_id_4B82(var_0, "br_assassination_timer_expire_hunters_lose");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_ass_fail", var_0, 1);
}

_id_10FA4(var_0, var_1) {
  return (var_0 % var_1 + var_1) % var_1;
}

_id_4AF4() {
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4AF5 = 1;
}

_id_4ADD() {
  scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4ADF = 1;
}

_id_351C() {
  return isDefined(scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4AF5) && scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4AF5;
}

_id_351B() {
  return isDefined(scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4ADF) && scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_4ADF;
}

_id_6CA9() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_6C94("assassination")._id_BEAB;
  var_1 = (self._id_9F9F - gettime()) / 1000;
  var_2 = clamp(var_1 / var_0, 0.0, 1.0);
  return var_2;
}

_id_695D() {
  if(self._id_02D0 == "_all_timed") {
    var_0 = getdvarfloat("#x346d2dafda7ded51", 3000.0);
    var_1 = getdvarfloat("#x36633e34e93efc4c6", 200.0);
    var_2 = _id_6CA9();
    var_3 = var_0 - var_1;
    return var_3 * var_2 + var_1;
  } else
    return 2000;
}

_id_695C() {
  if(self._id_02D0 == "_all_timed") {
    return 0;
  } else {
    return 100;
  }
}

_id_695B() {
  if(self._id_02D0 == "_all_timed") {
    var_0 = _id_695D();
    return var_0 * 0.5;
  } else
    return 900;
}