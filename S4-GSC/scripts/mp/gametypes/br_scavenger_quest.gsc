/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest.gsc
*******************************************************/

init() {
  _id_07A1::_id_CECC("body", ::_id_CBAB);
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("scavenger", 1);

  if(!var_0) {
    return;
  }
  scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_CFB0 = getdvarint("#x3139cbb51e497f1de", 1000);
  scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_9F94 = getdvarint("#x34750bccf028a9243", 300);
  scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_9F95 = getdvarint("#x374a228c9a8fc1cd1", 60);
  scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_C64D = getdvarint("#x3e16a53d98216adbe", 1);
  scripts\mp\gametypes\br_quest_util::_id_C2BF("scavenger", ::_id_E477);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("scavenger", ::_id_E474);
  scripts\mp\gametypes\br_quest_util::_id_C288("scavenger", ::_id_E470);
  scripts\mp\gametypes\br_quest_util::_id_C2A4("scavenger_locale");
  scripts\mp\gametypes\br_quest_util::_id_C24F("scavenger_locale", ::_id_E467);
  scripts\mp\gametypes\br_quest_util::_id_C279("scavenger_locale", ::_id_E46E);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("scavenger_locale", ::_id_E472);
  scripts\mp\gametypes\br_quest_util::_id_C246("scavenger_locale", ::_id_E464);
  scripts\mp\gametypes\br_quest_util::_id_C2A3("scavenger_locale", ::_id_E465);
  scripts\mp\gametypes\br_quest_util::_id_C286("scavenger_locale", ::_id_E468);
  scripts\mp\gametypes\br_quest_util::_id_C28E("scavenger_locale", ::_id_E476);
  scripts\mp\gametypes\br_quest_util::_id_BEBA("scavenger", 1);
  scripts\mp\gametypes\br_quest_util::_id_C28F("scavenger", ::_id_E46F);
  var_1 = [];
  var_1[0] = ::scripts\mp\gametypes\br_quest_util::_id_5A49;
  scripts\mp\gametypes\br_quest_util::_id_C29B("scavenger", var_1);
  game["dialog"]["mission_scav_accept"] = "mission_mission_scav_accept";
  game["dialog"]["mission_scav_success"] = "mission_mission_scav_success";
}

_id_E474() {
  scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
}

_id_E470(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
    scripts\mp\gametypes\br_quest_util::_id_6C96("scavenger_locale", self.team)._id_B711 = var_1;

    if(isDefined(self._id_EABF) && isDefined(self._id_EABF._id_2EA6) && var_1.size) {
      self._id_EABF._id_2EA6 setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::_id_8A9A(var_0.team)) {
      self._id_0372 = "fail";
      scripts\mp\gametypes\br_quest_util::_id_C50F();
    }
  }
}

_id_E468(var_0) {
  if(!_id_3504(var_0)) {
    return;
  }
  var_0 scripts\mp\gametypes\br_quest_util::_id_F91E();
  scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
}

_id_E476(var_0) {
  if(!_id_3504(var_0)) {
    return;
  }
  var_0 scripts\mp\gametypes\br_quest_util::_id_F921("scavenger");
  scripts\mp\gametypes\br_quest_util::_id_DCDC(var_0);
}

_id_3504(var_0) {
  if(var_0.team == self._id_EABE[0].team) {
    return 1;
  } else {
    return 0;
  }
}

_id_E467(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_400D("scavenger_locale", "scavenger", self.team);

  if(!isDefined(var_0)) {
    var_1._id_4140 = (0, 0, 0);
    var_1._id_523F = 0;
    return var_1;
  }

  var_1 scripts\mp\gametypes\br_quest_util::_id_403A("ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current");
  var_1._id_B711 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
  var_1._id_B033 = 0;
  scripts\mp\gametypes\br_quest_util::_id_1118("scavenger_locale", var_1);
  var_1 _id_D888(var_0);
  return var_1;
}

_id_E46E(var_0) {
  self._id_B033++;
  var_1 = _id_D888(var_0);

  if(var_1) {
    self._id_EABE[0]._id_420D = var_0.origin;
    scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_EABE[0].team, "br_scavenger_quest_next_location");
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_obj_next_nptarget", self._id_EABE[0].team, 1);

    if(istrue(scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_C64D)) {
      self._id_EABE[0] scripts\mp\gametypes\br_quest_util::_id_BEBB(scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_9F94, 1);
    } else {
      self._id_EABE[0] scripts\mp\gametypes\br_quest_util::_id_BEB9(scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_9F95);
    }
  }
}

_id_D888(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self._id_EABE[0];

    foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_1.team, "players")) {
      var_3 _id_0A99::_id_D5EB("br_assassination_notargets", undefined, 5);
    }

    var_1._id_0372 = "no_locale";
    var_5 = spawnStruct();
    var_5.origin = self._id_4140;
    var_5.angles = (0, 0, 0);
    var_5._id_8B39 = 0;

    if(getDvar("#x3f59526763711edc4", "") == "dmz") {
      var_6 = "mp/loot_set_cache_contents_dmz.csv";
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "health", var_6);
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "ammo", var_6);
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(1, 1, "plunder", var_6);
    } else {
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "health");
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "ammo");
      var_5 scripts\mp\gametypes\br_lootcache::_id_35A1(1, 1, "plunder");
    }

    var_1 scripts\mp\gametypes\br_quest_util::_id_C50F();
    return 0;
  }

  _func_03FA(var_0.index);
  _id_E366(var_0.origin, var_0.angles, self);
  self._id_4140 = var_0.origin + (0, 0, 50);
  scripts\mp\gametypes\br_quest_util::_id_A24B(self._id_4140);
  _id_FD17();
  return 1;
}

_id_E472() {
  _id_478A();
  self._id_B711 = undefined;
  self._id_EABE = undefined;

  if(isDefined(self._id_2EA6)) {
    if(self._id_2EA6 _meth_8575("body") == "scavenger_closed") {
      self._id_2EA6 delete();
    }
  }
}

_id_E465(var_0, var_1) {
  if(!isDefined(self._id_8FAC)) {
    self._id_8FAC = -1;
  }

  var_2 = gettime();

  if(self._id_8FAC == var_2) {
    return;
  }
  self._id_8FAC = var_2;
  var_3 = distance2d(self._id_4140, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self._id_EABE) {
      var_5 _id_58E0();
    }
  }
}

_id_E464() {
  return 0;
}

_id_EDD3(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_4039("scavenger", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C2C0(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C24A(self);
  var_1.team = self.team;
  var_1._id_E6E1 = self.origin;
  var_1._id_420D = self.origin;
  var_1._id_C59A = var_0._id_C59A;
  var_2 = _id_9867(var_1._id_E6E1, var_1._id_C59A[0]);
  var_3 = var_1 scripts\mp\gametypes\br_quest_util::_id_C580("scavenger_locale", var_2, 1);

  if(!var_3._id_523F) {
    _id_0A99::_id_D5EB("br_assassination_notargets", undefined, 5);
    var_1._id_0372 = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
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

  scripts\mp\gametypes\br_quest_util::_id_F922("scavenger", self.team);
  var_1._id_F37F = 0;
  var_1 scripts\mp\gametypes\br_quest_util::_id_BEBB(scripts\mp\gametypes\br_quest_util::_id_6C94("scavenger")._id_9F94, 4);
  scripts\mp\gametypes\br_quest_util::_id_1118("scavenger", var_1);
  scripts\mp\gametypes\br_quest_util::_id_E72C("scavenger", self, self.team);
  var_6 = spawnStruct();
  var_6._id_56DD = [];
  var_6._id_56DD[0] = self;
  var_6._id_B97D = scripts\mp\gametypes\br_quest_util::_id_6C98("scavenger", scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team));
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_scavenger_quest_start_team", var_6);
  scripts\mp\gametypes\br_quest_util::_id_4B7A(self, "br_scavenger_quest_start_tablet_finder", var_6);

  if(!scripts\mp\gametypes\br_public::_id_8AB8()) {
    scripts\mp\gametypes\br_quest_util::_id_7000(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::_id_4B81(var_1.team, self, 6, scripts\mp\gametypes\br_quest_util::_id_6C95("scavenger"));
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_scav_accept", var_1.team, 1);
}

_id_9867(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_CFB5 = "getUnusedLootCacheArray";
  var_2._id_CFAF = var_0;
  var_2._id_CFBA = 10000;
  var_2._id_CFBB = 0;
  var_2._id_CFB8 = 4000;
  var_2._id_CFB9 = 2000;
  var_2._id_CFB2 = 1;
  var_2._id_C59A = var_1;
  var_2._id_9F41 = 45;

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    if(var_2._id_CFBA < level._id_BEA7) {
      var_2._id_CFBA = level._id_BEA7;
    }

    var_2._id_CFB8 = level._id_BEA7;
    var_2._id_CFB9 = level._id_BEA8;
  }

  return var_2;
}

_id_3B35(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team);
  var_3 = scripts\mp\gametypes\br_quest_util::_id_6C95("scavenger");
  var_4 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("scavenger"));
  var_1._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_3, var_2, var_4);

  if(!scripts\mp\gametypes\br_public::_id_8AB8()) {
    scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_scavenger_quest_complete", var_1);
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_scav_success", self.team, 1, 1);
  }

  self._id_C810 = var_0.origin;
  self._id_C805 = var_0.angles;
  self._id_0372 = "success";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_58E0() {
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_scavenger_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_obj_circle_fail", self.team, 1);
  self._id_0372 = "fail";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_FD17() {
  foreach(var_1 in self._id_B711) {
    var_1 scripts\mp\gametypes\br_quest_util::_id_F920(self._id_B033);
  }

  var_3 = scripts\mp\gametypes\br_quest_util::_id_E03C(self._id_B711);

  foreach(var_1 in var_3["valid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::_id_F921("scavenger");
    scripts\mp\gametypes\br_quest_util::_id_DCDC(var_1);
  }

  foreach(var_1 in var_3["invalid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::_id_F91E();
    scripts\mp\gametypes\br_quest_util::_id_7914(var_1);
  }
}

_id_7916(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::_id_F91E();
}

_id_478A() {
  foreach(var_1 in self._id_B711) {
    _id_7916(var_1);
  }

  scripts\mp\gametypes\br_quest_util::_id_4789();
}

_id_E46F() {
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_scavenger_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_gen_fail", self.team, 1);
}

_id_E366(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_4 = var_2._id_B711[0];
  var_3.angles = var_1;
  var_3 setotherent(var_4);
  var_3 setModel("military_loot_crate_01_br_scavenger_01");
  var_3 setscriptablepartstate("body", "scavenger_closed");
  var_3._id_BEB3 = var_2;
  var_2._id_2EA6 = var_3;

  foreach(var_6 in level.players) {
    if(var_6 != var_4 && (var_4.team == "none" || var_6.team != var_4.team)) {
      var_3 _meth_86A8(var_6);
    }
  }
}

_id_CBAB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "scavenger_closed" && isDefined(var_0._id_019B)) {
    var_6 = var_0._id_019B._id_BEB3._id_EABE[0];

    if(var_3.team != var_6.team) {
      var_3 iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    var_0 setscriptablepartstate("body", "scavenger_opening");
    var_7 = getdvarint("#x386a9ecec46248c4f", 30);
    var_0._id_019B scripts\engine\utility::_id_46A8(var_7, ::delete);
    var_6 scripts\mp\gametypes\br_quest_util::_id_C24A(var_3);

    switch (var_0._id_019B._id_BEB3._id_B033) {
      case 0:
        scripts\mp\gametypes\br_quest_util::_id_6FD8("scavenger_1", var_3.team, var_0.origin, var_0.angles, var_6._id_C812);
        break;
      case 1:
        scripts\mp\gametypes\br_quest_util::_id_6FD8("scavenger_2", var_3.team, var_0.origin, var_0.angles, var_6._id_C812);
        break;
      case 3:
        break;
    }

    if(var_0._id_019B._id_BEB3._id_B033 == 2) {
      var_6._id_C810 = var_0.origin;
      var_6._id_C805 = var_0.angles;
      scripts\mp\gametypes\br_quest_util::_id_4B81(var_6.team, var_3, 8, scripts\mp\gametypes\br_quest_util::_id_6C95("scavenger"));
      var_6 _id_3B35(var_0._id_019B);
    } else {
      scripts\mp\gametypes\br_quest_util::_id_4B81(var_6.team, var_3, 7, scripts\mp\gametypes\br_quest_util::_id_6C95("scavenger"));
      var_8 = _id_9867(var_0.origin, var_6._id_C59A[var_0._id_019B._id_BEB3._id_B033 + 1]);
      var_0._id_019B._id_BEB3 scripts\mp\gametypes\br_quest_util::_id_A24A("scavenger_locale", var_8);
    }

    level notify("lootcache_opened_kill_callout" + var_0.origin);
    var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_3.team, 0);

    foreach(var_11 in var_9) {
      var_11 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }
}

_id_E477() {
  self._id_C59A = [];
  var_0 = self.origin;

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = _id_9867(var_0);
    var_3 = scripts\mp\gametypes\br_quest_util::_id_5B04("scavenger", var_2);

    if(!isDefined(var_3)) {
      return 0;
    }

    _func_03FA(var_3.index);
    var_0 = var_3.origin;
    self._id_C59A[var_1] = var_3;
  }

  return 1;
}