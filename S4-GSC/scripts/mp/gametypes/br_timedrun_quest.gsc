/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_timedrun_quest.gsc
******************************************************/

init() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("timedrun", 1);
  scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_9F94 = getdvarint("#x3f36f3fc2ba6d1e89", 120);
  scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E02 = getdvarint("#x33d0fd06c78aa05d8", 23000);
  scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E03 = getdvarint("#x33d32c66c78d03792", 10000);
  scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E00 = getdvarint("#x3a740039bec6ae21f", 23000);
  scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E01 = getdvarint("#x3a71cf19bec4472d1", 17000);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("timedrun", ::_id_F3B5);
  scripts\mp\gametypes\br_quest_util::_id_C288("timedrun", ::_id_F3B3);

  if(!var_0) {
    return;
  }
  scripts\mp\gametypes\br_quest_util::_id_C2BF("timedrun", ::_id_F6A4);
  scripts\mp\gametypes\br_quest_util::_id_C2A4("timedrun_locale");
  scripts\mp\gametypes\br_quest_util::_id_C24F("timedrun_locale", ::_id_F3AD);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("timedrun_locale", ::_id_F3B4);
  scripts\mp\gametypes\br_quest_util::_id_C286("timedrun_locale", ::_id_F3AF);
  scripts\mp\gametypes\br_quest_util::_id_C28E("timedrun_locale", ::_id_F3B6);
  scripts\mp\gametypes\br_quest_util::_id_C2A3("timedrun_locale", ::_id_F3AC);
  scripts\mp\gametypes\br_quest_util::_id_C2A5("timedrun_locale", ::_id_F3AE, 0.1);
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
}

_id_F6A4() {
  var_0 = _id_F3B1(self);
  var_1 = scripts\mp\gametypes\br_quest_util::_id_5B04("timedrun", var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  self._id_C59A = var_1;
  return 1;
}

_id_EDD3(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_4039("timedrun", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C2C0(self.team, self);
  var_1.team = self.team;
  var_1._id_E6E1 = self.origin;
  var_1._id_E70B = self;
  scripts\mp\gametypes\br_quest_util::_id_7000(self.team, "br_mission_pickup_tablet");
  var_2 = _id_F3B1(var_0);
  var_1._id_E72D = gettime();
  var_3 = var_1 scripts\mp\gametypes\br_quest_util::_id_C580("timedrun_locale", var_2, 1);
  var_3.team = self.team;

  if(!var_3._id_523F) {
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

  scripts\mp\gametypes\br_quest_util::_id_BEBA("timedrun", 1);
  scripts\mp\gametypes\br_quest_util::_id_C28F("timedrun", ::_id_F3B2);
  var_1 scripts\mp\gametypes\br_quest_util::_id_BEBB(getdvarint("#x3ee5bb554f01ec397", getdvarint("#x3f36f3fc2ba6d1e89", 120)), 4);
  scripts\mp\gametypes\br_quest_util::_id_1118("timedrun", var_1);
  scripts\mp\gametypes\br_quest_util::_id_E72C("timedrun", self, self.team);
  var_6 = spawnStruct();
  var_6._id_56DD = [];
  var_6._id_56DD[0] = self;
  var_6._id_B97D = scripts\mp\gametypes\br_quest_util::_id_6C98("timedrun", scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team));
  scripts\mp\gametypes\br_quest_util::_id_4B7A(self, "br_timedrun_quest_start_tablet_finder", var_6);
  scripts\mp\gametypes\br_quest_util::_id_4B82(var_1.team, "br_timedrun_quest_start_team_notify", var_6);
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_timedrun_accept", var_1.team, 1, 1);
}

_id_3504(var_0) {
  if(var_0.team == self._id_EABE[0].team) {
    return 1;
  } else {
    return 0;
  }
}

_id_F3B7(var_0) {
  var_1 = spawnStruct();
  var_1._id_CFB5 = "GetEntitylessScriptableArray";
  var_1._id_CFAF = var_0;
  var_1._id_CFBA = 6000;
  var_1._id_CFBB = 0;
  var_1._id_CFB8 = 4000;
  var_1._id_CFB9 = 0;
  var_1._id_9F41 = 1;
  return var_1;
}

_id_F3B1(var_0) {
  var_1 = spawnStruct();
  var_1._id_CFB5 = "getKiosks";
  var_1._id_031A = "br_plunder_box";
  var_1._id_E75C = "visible";
  var_1._id_CFAF = var_0.origin;
  var_1._id_CFBA = scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E02;
  var_1._id_CFBB = scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E03;
  var_1._id_CFB8 = scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E00;
  var_1._id_CFB9 = scripts\mp\gametypes\br_quest_util::_id_6C94("timedrun")._id_8E01;
  var_1._id_CFB2 = 1;
  var_1._id_C59A = var_0._id_C59A;
  var_1._id_9F41 = 1;
  return var_1;
}

_id_F3B0(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(distance2d(self._id_E6E1, var_2.origin) < 1500) {
      if(isDefined(var_2.vehicle)) {
        return;
      }
    }
  }

  var_4 = _func_0098("script_vehicle", "classname", var_0._id_CFAF, var_0._id_CFBA);
  var_4 = _func_0204(var_4, var_0._id_CFAF);

  foreach(var_6 in var_4) {
    if(var_6._id_881C) {
      self._id_EF0F = var_6;
      break;
    } else if(var_6._id_ADAE == self.team) {
      break;
    }
  }

  if(!isDefined(self._id_EF0F)) {
    return;
  }
  self._id_10321 = scripts\mp\utility\outline::_id_ACD2(self._id_EF0F, self.team, "outlinefill_nodepth_yellow", "level_script");
  thread _id_38A5();
  thread _id_10B0F();
}

_id_10B0F() {
  level endon("game_ended");
  self endon("remove_TR_Outline");
  var_0 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
  scripts\engine\utility::_id_10889(var_0, "vehicle_enter");

  foreach(var_2 in var_0) {
    if(distance2d(var_2.origin, self._id_EF0F.origin) < 2000) {
      scripts\mp\utility\outline::outlinedisable(self._id_10321, self._id_EF0F);
      self notify("remove_TR_Outline");
    }
  }
}

_id_38A5() {
  level endon("game_ended");
  self endon("remove_TR_Outline");

  for(;;) {
    if(self._id_EF0F._id_881C != 1 || gettime() > self._id_E72D + 60000) {
      scripts\mp\utility\outline::outlinedisable(self._id_10321, self._id_EF0F);
      self notify("remove_TR_Outline");
    }

    wait 0.2;
  }
}

_id_F3AD(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_400D("timedrun_locale", "timedrun", self.team);

  if(!isDefined(var_0)) {
    var_1._id_4140 = (0, 0, 0);
    var_1._id_523F = 0;
    return var_1;
  }

  var_1._id_B711 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
  var_1._id_4140 = var_0.origin;
  var_1 scripts\mp\gametypes\br_quest_util::_id_403A("ui_mp_br_mapmenu_icon_timedrun_objective", "current", var_1._id_4140 + (0, 0, 65));
  scripts\mp\gametypes\br_quest_util::_id_1118("timedrun_locale", var_1);
  var_1 _id_D888(var_0);
  return var_1;
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

  self._id_EEB4 = var_0;
  thread _id_F20C(self._id_EEB4.origin);
  _id_FD62();
  return 1;
}

_id_F20C(var_0, var_1) {
  var_2 = spawnfx(level._effect["vfx_marker_base_orange_pulse"], var_0 + (0, 0, 10));
  var_2.angles = vectortoangles((0, 0, 1));
  var_2 hide();
  wait 0.5;
  triggerfx(var_2);

  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    var_2 showtoplayer(var_4);
  }

  self._id_5B19 = var_2;
}

_id_F3B5() {
  scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
}

_id_F3B4() {
  _id_4798();
  self._id_5B19 delete();
  self._id_B711 = undefined;
  self._id_EABE = undefined;
}

_id_F3AE() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(distance(var_1.origin, self._id_4140) < 150) {
      self._id_EABE[0] _id_3B36(self._id_EEB4);
    }
  }
}

_id_3B36(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team);
  var_3 = scripts\mp\gametypes\br_quest_util::_id_6C95("timedrun");
  var_4 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("timedrun"));
  var_1._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_3, var_2, var_4);
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_timedrun_quest_complete", var_1);
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_misc_success", self.team, 1, 1);
  var_5 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");

  foreach(var_7 in var_5) {
    if(isDefined(var_7) && !istrue(var_7._id_2A63)) {
      scripts\mp\gametypes\br_armory_kiosk::_id_8E04(var_0, var_7);
    }
  }

  self._id_C80A = undefined;
  self._id_0372 = "success";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_58E1() {
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_timedrun_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_obj_circle_fail", self.team, 1, 1);
  self._id_0372 = "fail";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_F3B2() {
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_timedrun_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_timedrun_fail", self.team, 1, 1);
}

_id_F3AC(var_0, var_1) {
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
      var_5 _id_58E1();
    }
  }
}

_id_F3B3(var_0) {
  if(var_0.team == self.team) {
    scripts\mp\gametypes\br_quest_util::_id_6C96("timedrun_locale", self.team)._id_B711 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");

    if(!scripts\mp\gametypes\br_quest_util::_id_8A9A(var_0.team)) {
      self._id_0372 = "fail";
      scripts\mp\gametypes\br_quest_util::_id_C50F();
    }
  }
}

_id_F3AF(var_0) {
  if(!_id_3504(var_0)) {
    return;
  }
  var_0 scripts\mp\gametypes\br_quest_util::_id_F91E();
  scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
}

_id_F3B6(var_0) {
  if(!_id_3504(var_0)) {
    return;
  }
  var_0 scripts\mp\gametypes\br_quest_util::_id_F921("timedrun");
  scripts\mp\gametypes\br_quest_util::_id_DCDC(var_0);
}

_id_FD62() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_E03C(self._id_B711);

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_F921("timedrun");
    scripts\mp\gametypes\br_quest_util::_id_DCDC(var_2);
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_F91E();
    scripts\mp\gametypes\br_quest_util::_id_7914(var_2);
  }
}

_id_7918(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::_id_F91E();
}

_id_4798() {
  foreach(var_1 in self._id_B711) {
    _id_7918(var_1);
  }

  scripts\mp\gametypes\br_quest_util::_id_4789();
}