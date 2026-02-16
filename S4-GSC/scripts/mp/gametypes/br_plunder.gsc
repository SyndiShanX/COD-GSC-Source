/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_plunder.gsc
*************************************************/

init() {
  level._id_2A9C = getdvarint("#x32d85a17f6033ea7c", 1) != 0;
  thread _id_D8A4();

  if(!istrue(level._id_2A9C)) {
    return;
  }
  _id_81AA();
  _id_81AB();
  level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");
  level._effect["vfx_br_cashLeaderBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  level._id_2A9E = getdvarint("#x337701937599ffd6f", 0) != 0 && istrue(level._id_15CA);
  level._id_2A9B = spawnStruct();
  level._id_2A9B._id_B967 = 16383;
  level._id_2A9B._id_B937 = 0;
  level._id_2A9B._id_B953 = 0;
  level._id_2A9B._id_B936 = 0;
  level._id_2A9B._id_B952 = 0;
  level._id_2A9B._id_8DFC = 0;
  level._id_2A9B._id_8DFB = 0;
  level._id_2A9B._id_581F = 0;
  level._id_2A9B._id_581E = 0;
  level._id_2A9B._id_582A = 0;
  level._id_2A9B._id_5829 = 0;
  level._id_2A9B._id_B92E = 0;
  level._id_2A9B._id_8B3A = [];
  level._id_2A9B._id_8B3A["brloot_plunder_cash_common_1"] = _func_0405("brloot_plunder_cash_common_1");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_1"] = _func_0405("brloot_plunder_cash_uncommon_1");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_2"] = _func_0405("brloot_plunder_cash_uncommon_2");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_3"] = _func_0405("brloot_plunder_cash_uncommon_3");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_rare_1"] = _func_0405("brloot_plunder_cash_rare_1");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_rare_2"] = _func_0405("brloot_plunder_cash_rare_2");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_epic_1"] = _func_0405("brloot_plunder_cash_epic_1");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_epic_2"] = _func_0405("brloot_plunder_cash_epic_2");
  level._id_2A9B._id_8B3A["brloot_plunder_cash_legendary_1"] = _func_0405("brloot_plunder_cash_legendary_1");
  level._id_2A9B._id_8B3A["br_loot_cache"] = _func_0405("br_loot_cache");
  level._id_2A9B._id_8B3A["brloot_mission_tablet"] = _func_0405("brloot_mission_tablet");
  _id_D8A6();
  _id_82B7();
  _id_8273();
  level._id_2A35 = [];
  level thread _id_B931();

  if(_id_82D6()) {
    level._id_2A9D = [];
    thread _id_B968();
  }

  _id_8269();
  _id_B935();
  _id_82AA();
  _id_81AC();

  if(getdvarint("#x35a35439c429ce455", 0) == 1) {
    _id_BD63();
  }
}

_id_B931(var_0, var_1, var_2) {
  level endon("game_ended");
  level waittill("prematch_started");

  for(;;) {
    level waittill("br_circle_started");
    var_3 = scripts\mp\gametypes\br_quest_util::_id_6E30(level.players, level._id_BEAF._id_45B2);
    scripts\mp\gametypes\br_analytics::_id_2AEF(var_3);
  }
}

_id_A003(var_0, var_1) {
  if(level._id_2A9C) {
    level._id_2A9B._id_8B3A[var_0] = level._id_2A9B._id_8B3A[var_0] + var_1;
  }
}

_id_D8A6() {
  level._id_2A9B._id_BE99 = [];
  level._id_2A9B._id_A3D1 = [];
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_uncommon_1";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_uncommon_2";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_uncommon_3";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_rare_1";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_rare_2";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_epic_1";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_epic_2";
  level._id_2A9B._id_A3D1[level._id_2A9B._id_A3D1.size] = "brloot_plunder_cash_legendary_1";

  for(var_0 = 0; var_0 < level._id_2A9B._id_A3D1.size; var_0++) {
    level._id_2A9B._id_BE99[var_0] = level._id_2A95._id_3DAB[level._id_2A9B._id_A3D1[var_0]];

    if(isDefined(level._id_2A9B._id_BE99[var_0 - 1])) {}
  }
}

_id_82B7() {
  game["dialog"]["plunder_extract_requested"] = "plunder_plunder_extract_requested";
  game["dialog"]["plunder_extract_chopper_arrive"] = "plunder_plunder_extract_chopper_arrive";
  game["dialog"]["plunder_extract_chopper_leave"] = "plunder_plunder_extract_chopper_leave";
  game["dialog"]["plunder_extract_success"] = "plunder_plunder_extract_success";
  game["dialog"]["plunder_extract_fail_chopper"] = "plunder_plunder_extract_fail_chopper";
}

_id_8273() {
  level._id_B96D = getEntArray("extract_pad", "targetname");
}

_id_B73F() {
  if(self isswitchingweapon() || self _meth_81E0() || self _meth_81CE() || self _meth_81EF() || self israisingweapon() || self _meth_81CF()) {
    return;
  }
  scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_cash_handoff", 1.84);
}

_id_B764() {
  foreach(var_2, var_1 in self._id_2A62) {
    if(var_1._id_CF22 == "brloot_plunder_cash_uncommon_1") {
      scripts\mp\gametypes\br_public::_id_C4D7(var_2);
      return;
    }
  }
}

_id_4A7B(var_0) {
  for(var_1 = 0; var_1 < level._id_2A35.size; var_1++) {
    var_2 = level._id_2A35[var_1];

    if(isDefined(var_2) && !istrue(var_2._id_4A88)) {
      var_2 _id_47F6(var_0);
    }
  }
}

_id_5238(var_0) {
  for(var_1 = 0; var_1 < level._id_2A35.size; var_1++) {
    var_2 = level._id_2A35[var_1];

    if(isDefined(var_2) && !istrue(var_2._id_4A88)) {
      var_2 _id_47F7(var_0);
    }
  }
}

_id_47F7(var_0) {
  self _meth_80E0(var_0);

  if(isDefined(self._id_A8DA)) {
    _id_07F9::_id_A89D(self._id_A8DA, var_0);
  }
}

_id_47F6(var_0) {
  self disableplayeruse(var_0);

  if(isDefined(self._id_A8DA)) {
    _id_07F9::_id_A89E(self._id_A8DA, var_0);
  }
}

_id_47F5() {
  self makeunusable();

  if(isDefined(self._id_A8DA)) {
    _id_07F9::_id_A89F(self._id_A8DA);
    _id_07F9::_id_C799(self._id_A8DA);
  }
}

_id_825B() {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  if(!isDefined(self._id_B956)) {
    self._id_B956 = 0;
  }

  if(!isDefined(self._id_B955)) {
    self._id_B955 = 0;
  }

  if(!isDefined(self._id_7594)) {
    self._id_7594 = 0;
  }

  if(self._id_B956 == 0) {
    _id_B7A3(0);
  }
}

_id_B69C() {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  _id_B7A3(0);
}

_id_21D8() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_B956) && var_1._id_B956 > 0) {
      var_1 _id_B746(var_1._id_B956);
    }
  }
}

_id_B69D(var_0, var_1) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  if(istrue(scripts\mp\gametypes\br_gametypes::_id_CA24("playerDropPlunderOnDeath", var_0, var_1))) {
    return;
  }
  var_2 = 10.0;
  var_3 = 2.0 / var_2;
  var_4 = 3.0 / var_2;
  var_5 = 5.0 / var_2;

  if(isDefined(self._id_B956) && self._id_B956 > 0) {
    var_6 = self._id_B956;
  } else {
    var_6 = 0;
  }

  var_7 = int(min(var_6, max(2, int(var_6 * var_3))) + 0.5);
  var_8 = int(max(1, int(var_6 * var_5)));
  self._id_B95B = var_7;
  _id_B7A3(var_7);

  if(var_8 <= 0) {
    return;
  }
  _id_5026(var_8, var_0);
}

_id_EDD2(var_0) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_1 = 1;

  if(isDefined(var_0._id_011A)) {
    var_1 = var_0._id_011A;
  }

  if(scripts\engine\utility::array_contains(level._id_2A9B._id_A3D1, var_0._id_CF22)) {
    _id_B756(var_1);
    level._id_2A9B._id_B937 = level._id_2A9B._id_B937 + 1;
    level._id_2A9B._id_B953 = level._id_2A9B._id_B953 + var_1;
    _id_A003(var_0._id_CF22, -1);
    var_2 = "loot";

    if(isDefined(var_0._id_82FC._id_9898)) {
      var_2 = var_0._id_82FC._id_9898;
    }

    scripts\mp\gametypes\br_analytics::_id_F3F7(self, var_2, var_1);
  } else
    scripts\mp\gametypes\br_pickups::_id_F752(var_0._id_CF22, var_1);
}

_id_8269() {
  var_0 = [];
  var_0[1] = "ui_br_plunder_pickedup";
  var_0[2] = "ui_br_plunder_pickedup";
  level._id_B74F = var_0;
  var_1 = [];
  var_1[1] = ::_id_B757;
  var_1[2] = ::_id_B74B;
  var_1[3] = ::_id_B747;
  var_1[4] = ::_id_B753;
  var_1[5] = ::_id_B749;
  var_1[6] = ::_id_B755;
  level._id_B74E = var_1;
}

_id_B756(var_0, var_1) {
  return _id_B74D(var_0, 1, undefined, var_1);
}

_id_B74A(var_0, var_1, var_2) {
  return _id_B74D(var_0, 2, var_1, var_2);
}

_id_B746(var_0, var_1, var_2) {
  return _id_B74D(var_0, 3, var_1, var_2);
}

_id_B752(var_0, var_1) {
  return _id_B74D(var_0, 4, undefined, var_1);
}

_id_B748(var_0, var_1, var_2) {
  return _id_B74D(var_0, 5, var_1, var_2);
}

_id_B754(var_0, var_1, var_2) {
  return _id_B74D(var_0, 6, var_1, var_2);
}

_id_B750(var_0, var_1) {
  return _id_B74D(var_0, 4, undefined, var_1);
}

_id_B74C(var_0, var_1) {
  return _id_B74D(var_0, 4, undefined, var_1);
}

_id_B74D(var_0, var_1, var_2, var_3) {
  if(!istrue(level._id_2A9C) || !isDefined(self._id_B956)) {
    return;
  }
  if(var_1 == 2 || var_1 == 3 || var_1 == 4) {
    var_0 = int(min(self._id_B956, var_0));
  }

  if(!isDefined(self._id_B95F)) {
    self._id_B95F = [];
  }

  if(!isDefined(self._id_B960)) {
    self._id_B960 = [];
  }

  if(!isDefined(self._id_902D)) {
    self._id_902D = 0;
  }

  var_5 = scripts\engine\utility::ter_op(var_1 == 5, 3, var_1);
  var_6 = level._id_B74F[var_5];
  var_7 = self._id_B960[var_1];
  var_8 = self._id_B95F[var_1];

  if(!isDefined(var_8) || gettime() - var_8 > 2000) {
    var_7 = 0;
  }

  var_7 = var_7 + var_0;

  if(isPlayer(self) && isDefined(var_6)) {
    var_9 = int(min(var_7, self._id_B956 + var_0));
    self setclientomnvar(var_6, var_9);
  }

  self._id_902D = var_1;
  self._id_B95F[var_1] = gettime();
  self._id_B960[var_1] = var_7;
  var_10 = level._id_B74E[var_1];

  if(isDefined(var_10)) {
    var_3 = self[[var_10]](var_0, var_2, var_3);
  }

  if(isDefined(var_3)) {
    if(isDefined(var_3.player)) {
      if(isDefined(var_3._id_B7D6) && var_3._id_B7D6 != "none" && !var_3.player scripts\mp\gametypes\br_public::_id_8990()) {
        if(var_3._id_B7D6 != "br_plunder_first_pickup" || !istrue(var_3.player._id_7594)) {
          var_3.player thread scripts\mp\hud_message::showsplash(var_3._id_B7D6);

          if(var_3._id_B7D6 == "br_plunder_first_pickup") {
            var_3.player._id_7594 = 1;
          }
        }
      }

      if(isDefined(var_3._id_B791) && (!isDefined(var_3._id_B792) || var_3._id_B792 > 0)) {
        var_3.player thread _id_0A9F::_id_7003(var_3._id_B791, undefined, var_3._id_B792);
      }
    }

    if(istrue(var_3._id_B350)) {
      if(var_1 == 3) {
        thread _id_B73F();
      } else if(var_1 == 2) {
        thread _id_B740();
      }
    }

    if(isDefined(var_3._id_0050)) {
      var_0 = var_3._id_0050;
    }

    if(istrue(var_3._id_B8BC)) {
      var_11 = scripts\engine\utility::ter_op(isDefined(var_3._id_B978), var_3._id_B978, var_0);
      _id_B8BD(self, var_11);
    }
  }

  switch (var_1) {
    case 4:
    case 3:
    case 2:
      var_0 = var_0 * -1;
      break;
    case 6:
    case 5:
      var_0 = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(var_0)) {
    var_3._id_B95D = var_0;
    thread _id_B7A3(self._id_B956 + var_0, var_3);
  }

  scripts\mp\gametypes\br_gametype_dmz::_id_ADCC();
  return var_3;
}

_id_FF53(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case 6:
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
      return 1;
    default:
      return 0;
  }
}

_id_B757(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  if(!istrue(self._id_7594)) {
    var_2._id_B7D6 = "br_plunder_first_pickup";
    thread scripts\mp\gametypes\br_armory_kiosk::_id_DC99();
  }

  return var_2;
}

_id_B74B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  if(!isDefined(var_2._id_B8BC)) {
    var_2._id_B8BC = 1;
    var_2._id_B978 = undefined;
  }

  if(!isDefined(var_2._id_B350)) {
    var_2._id_B350 = 1;
  }

  if(isDefined(var_1)) {
    var_3 = _id_B934(var_1._id_B972);

    if(isDefined(var_3._id_3212) && var_3._id_3212 > 0) {
      var_4 = var_1._id_B979 + var_0 - var_3._id_3212;

      if(var_4 >= 0) {
        var_0 = var_0 - var_4;

        if(!istrue(var_1._id_B954)) {
          _id_B93F(var_1);
        }
      }
    }

    var_5 = 1;

    foreach(var_7 in var_1._id_B929) {
      var_8 = var_7.player;

      if(isDefined(var_8) && var_8 == self) {
        var_7._id_B956 = var_7._id_B956 + var_0;
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      var_7 = spawnStruct();
      var_7.player = self;
      var_7.team = self.team;
      var_7._id_B956 = var_0;
      var_1._id_B929[var_1._id_B929.size] = var_7;
    }
  }

  var_2._id_0050 = var_0;
  var_1._id_B979 = var_1._id_B979 + var_0;

  if(!isDefined(level._id_EF6A[self.team]["plunderInDeposit"])) {
    level._id_EF6A[self.team]["plunderInDeposit"] = int(var_0);
  } else {
    level._id_EF6A[self.team]["plunderInDeposit"] = level._id_EF6A[self.team]["plunderInDeposit"] + int(var_0);
  }

  return var_2;
}

_id_B747(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  if(!isDefined(var_2._id_B7D6)) {
    var_2._id_B7D6 = "br_plunder_banked";
  }

  if(!isDefined(var_2._id_B791)) {
    var_2._id_B791 = scripts\engine\utility::ter_op(getDvar("#x3f59526763711edc4", "") == "dmz", "plunder_cash_blood_money", "plunder_cash");
  }

  if(!isDefined(var_2._id_B792)) {
    var_2._id_B792 = int(scripts\mp\rank::getscoreinfovalue(var_2._id_B791) * (var_0 / 10));
  }

  if(!isDefined(var_2._id_B8BC)) {
    var_2._id_B8BC = 1;
    var_2._id_B978 = undefined;
  }

  if(!isDefined(var_2._id_B350)) {
    var_2._id_B350 = 1;
  }

  self._id_B955 = self._id_B955 + var_0;

  if(self._id_B955 > level._id_2A9B._id_B967) {
    self._id_B955 = level._id_2A9B._id_B967;
  }

  if(!isDefined(level._id_EF6A[self.team]["plunderBanked"])) {
    level._id_EF6A[self.team]["plunderBanked"] = var_0;
  } else {
    level._id_EF6A[self.team]["plunderBanked"] = level._id_EF6A[self.team]["plunderBanked"] + var_0;
  }

  return var_2;
}

_id_B753(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  return var_2;
}

_id_B749(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  if(!isDefined(var_2._id_B978)) {
    var_2._id_B978 = 0;
  }

  var_2._id_D67F = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1._id_B929)) {
    foreach(var_6, var_5 in var_1._id_B929) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0)) {
          var_0 = var_5._id_B956;
        } else {
          var_0 = min(var_0, var_5._id_B956);
        }

        var_5._id_B956 = var_5._id_B956 - var_0;

        if(var_5._id_B956 == 0) {
          var_1._id_B929[var_6] = undefined;
        }

        self._id_B955 = self._id_B955 + var_0;

        if(self._id_B955 > level._id_2A9B._id_B967) {
          self._id_B955 = level._id_2A9B._id_B967;
        }

        break;
      }
    }

    if(!isDefined(var_2._id_B791)) {
      var_2._id_B791 = scripts\engine\utility::ter_op(getDvar("#x3f59526763711edc4", "") == "dmz", "plunder_cash_blood_money", "plunder_cash");
    }

    if(!isDefined(var_2._id_B792)) {
      var_2._id_B792 = int(scripts\mp\rank::getscoreinfovalue(var_2._id_B791) * (var_0 / 10));
    }
  }

  var_0 = int(var_0);
  level._id_EF6A[var_3]["plunderInDeposit"] = level._id_EF6A[var_3]["plunderInDeposit"] - var_0;
  level._id_EF6A[var_3]["plunderBanked"] = level._id_EF6A[var_3]["plunderBanked"] + var_0;
  return var_2;
}

_id_B755(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = _id_4031(self);
  }

  var_2._id_D67F = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1._id_B929)) {
    foreach(var_6, var_5 in var_1._id_B929) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0)) {
          var_0 = var_5._id_B956;
        } else {
          var_0 = min(var_0, var_5._id_B956);
        }

        var_5._id_B956 = var_5._id_B956 - var_0;

        if(var_5._id_B956 == 0) {
          var_1._id_B929[var_6] = undefined;
        }

        break;
      }
    }
  }

  var_0 = int(var_0);
  level._id_EF6A[var_3]["plunderInDeposit"] = level._id_EF6A[var_3]["plunderInDeposit"] - var_0;
  return var_2;
}

_id_550C(var_0) {
  if(!isDefined(self._id_B929)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = _id_4031();
  }

  var_0._id_1754 = 0;
  var_0._id_EFA0 = [];
  var_0._id_A77B = 0;

  foreach(var_5, var_2 in self._id_B929) {
    if(isDefined(var_2.player) || var_2._id_B956 <= 0) {
      continue;
    }
    var_3 = var_2.team;
    var_4 = var_2._id_B956;
    level._id_EF6A[var_3]["plunderInDeposit"] = level._id_EF6A[var_3]["plunderInDeposit"] - var_4;
    level._id_EF6A[var_3]["plunderBanked"] = level._id_EF6A[var_3]["plunderBanked"] + var_4;
    var_0._id_1754 = var_0._id_1754 + var_4;
    var_0._id_EFA0[var_0._id_EFA0.size] = var_3;
    self._id_B929[var_5] = undefined;
  }

  foreach(var_2 in self._id_B929) {
    if(var_2._id_B956 <= 0) {
      continue;
    }
    var_7 = var_2.player;
    var_3 = var_2.team;
    var_4 = var_2._id_B956;
    var_8 = undefined;

    if(isDefined(var_0)) {
      var_8 = _id_3D65(var_0, var_7, var_3);
    }

    var_8._id_4D98 = 1;
    var_8 = var_7 _id_B748(var_4, self, var_8);

    if(isDefined(var_8) && isDefined(var_8._id_0050)) {
      var_4 = var_8._id_0050;
    }

    var_0._id_1754 = var_0._id_1754 + var_4;
    var_0._id_EFA0[var_0._id_EFA0.size] = var_3;
    var_0._id_A77B++;
  }

  var_10 = "fulton";

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    var_10 = "little_bird";
  }

  var_0._id_EFA0 = scripts\engine\utility::_id_1BC1(var_0._id_EFA0);
  var_11 = 0;

  if(var_0._id_EFA0.size > 1) {
    var_11 = 1;
  } else if(var_0._id_EFA0.size == 1 && var_0._id_EFA0[0] != self.team) {
    var_11 = 1;
  }

  var_12 = _id_B934(self._id_B972, undefined, 1);

  if(isDefined(var_12) && isDefined(var_12._id_5838)) {
    scripts\mp\gametypes\br_analytics::_id_2B03(var_0._id_A77B, var_0._id_1754, var_12._id_5838, var_11, self.origin);
  }

  if(!isDefined(var_0) || !istrue(var_0._id_4D98)) {
    thread scripts\mp\gametypes\br_gametypes::_id_CA24("postPlunder", var_0);
  }

  self._id_B929 = [];
  return var_0;
}

_id_550D(var_0, var_1) {
  if(!isDefined(self._id_B929)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = _id_4031();
  }

  var_1._id_1754 = 0;
  var_1._id_EFA0 = [];
  var_2 = 0;

  foreach(var_7, var_4 in self._id_B929) {
    if(isDefined(var_4.player) || var_4._id_B956 <= 0) {
      continue;
    }
    var_5 = var_4.team;
    var_6 = var_4._id_B956;
    level._id_EF6A[var_5]["plunderInDeposit"] = level._id_EF6A[var_5]["plunderInDeposit"] - var_6;
    var_1._id_1754 = var_1._id_1754 + var_6;
    var_1._id_EFA0[var_1._id_EFA0.size] = var_5;
    self._id_B929[var_7] = undefined;
  }

  foreach(var_4 in self._id_B929) {
    if(var_4._id_B956 <= 0) {
      continue;
    }
    var_9 = var_4.player;
    var_5 = var_4.team;
    var_6 = var_4._id_B956;
    var_10 = undefined;

    if(isDefined(var_1)) {
      var_10 = _id_3D65(var_1, var_9, var_5);
    }

    var_10._id_4D98 = 1;
    var_9 _id_B754(var_6, self, var_10);

    if(isDefined(var_10) && isDefined(var_10._id_0050)) {
      var_6 = var_10._id_0050;
    }

    var_1._id_1754 = var_1._id_1754 + var_6;
    var_1._id_EFA0[var_1._id_EFA0.size] = var_5;
    var_2 = var_2 + var_6;
  }

  if(!isDefined(var_1) || !istrue(var_1._id_4D98)) {
    thread scripts\mp\gametypes\br_gametypes::_id_CA24("postPlunder", var_1);
  }

  self._id_B929 = [];

  if(istrue(var_0)) {
    _id_5052(var_1._id_1754, 0);
  }

  return var_1;
}

_id_4031(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = undefined;

  if(isDefined(var_0)) {
    var_2.player = var_0;
  }

  var_2._id_B7D6 = undefined;
  var_2._id_B791 = undefined;
  var_2._id_B792 = undefined;
  var_2._id_D67F = undefined;
  var_2._id_B8BC = undefined;
  var_2._id_B978 = undefined;
  var_2._id_B350 = undefined;
  return var_2;
}

_id_3D65(var_0, var_1, var_2) {
  var_3 = _id_4031();

  if(isDefined(var_0.player)) {
    var_3.player = var_0.player;
    var_1 = var_0.player;
  } else if(isDefined(var_1))
    var_3.player = var_1;

  if(isDefined(var_0._id_B7D6)) {
    var_3._id_B7D6 = var_0._id_B7D6;
  }

  if(isDefined(var_0._id_B791)) {
    var_3._id_B791 = var_0._id_B791;
  }

  if(isDefined(var_0._id_B792)) {
    var_3._id_B792 = var_0._id_B792;
  }

  if(isDefined(var_0._id_D67F)) {
    var_3._id_D67F = var_0._id_D67F;
  }

  if(isDefined(var_0._id_B8BC)) {
    var_3._id_B8BC = var_0._id_B8BC;
  }

  if(isDefined(var_0._id_B978)) {
    var_3._id_B978 = var_0._id_B978;
  }

  if(isDefined(var_0._id_B350)) {
    var_3._id_B350 = var_0._id_B350;
  }

  return var_3;
}

_id_B7A3(var_0, var_1) {
  if(!isDefined(self._id_B956)) {
    self._id_B956 = 0;
  }

  var_2 = var_0 - self._id_B956;

  if((!isDefined(var_1) || !istrue(var_1._id_D67F)) && var_2 == 0) {
    return;
  }
  self._id_B956 = var_0;

  if(self._id_B956 > level._id_2A9B._id_B967) {
    scripts\mp\hud_message::_id_DCA2("MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED");
    self._id_B956 = level._id_2A9B._id_B967;
  }

  var_3 = self._id_B956;
  _id_B7A4(var_3);

  if(var_0 > 0) {
    if(istrue(level._id_B97C) && var_2 != 0) {
      _id_B92B(self, 1, 1);
    }

    _id_5238(self);

    if(_id_82D6() && var_0 >= 10) {
      thread _id_B68F();
    }
  } else {
    if(istrue(level._id_B97C) && var_2 != 0) {
      _id_B92B(self, 0, 1);
    }

    _id_4A7B(self);
  }

  if(isDefined(var_1) && isDefined(var_1._id_B95D)) {
    level._id_EF6A[self.team]["plunderTeamTotal"] = level._id_EF6A[self.team]["plunderTeamTotal"] + var_1._id_B95D;
  }

  if(!isDefined(var_1) || !istrue(var_1._id_4D98)) {
    thread scripts\mp\gametypes\br_gametypes::_id_CA24("postPlunder", var_1);
  }
}

_id_B7A4(var_0) {
  [var_2, var_3, var_4] = _id_B6B9();
  var_5 = 0;

  if(isDefined(level._id_EF6A[self.team][var_4])) {
    var_5 = level._id_EF6A[self.team][var_4];
  }

  var_6 = _id_6C05(var_0, var_5, var_2, var_3);
  level._id_EF6A[self.team][var_4] = var_6;
  var_7 = level._id_EF6A[self.team]["players"];

  foreach(var_9 in var_7) {
    if(isbot(var_9) && scripts\mp\gametypes\br_public::_id_8AB8()) {
      continue;
    }
    var_9 setclientomnvar(var_4, var_6);
  }
}

_id_6C05(var_0, var_1, var_2, var_3) {
  var_4 = int(_func_01A6(2, var_3)) - 1;
  var_5 = (var_0 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = var_1 &var_6;
  var_8 = var_7 + var_5;
  return var_8;
}

_id_B6B9() {
  var_0 = 0;
  var_1 = 0;
  var_2 = "";

  switch (self._id_2ABC) {
    case 1:
      [var_0, var_1, var_2] = [0, 14, "ui_br_plunder_count"];
      break;
    case 2:
      [var_0, var_1, var_2] = [14, 14, "ui_br_plunder_count"];
      break;
    case 3:
      [var_0, var_1, var_2] = [0, 14, "ui_br_plunder_count2"];
      break;
    case 4:
      [var_0, var_1, var_2] = [14, 14, "ui_br_plunder_count2"];
      break;
    default:
      break;
  }

  return [var_0, var_1, var_2];
}

_id_433F(var_0, var_1) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_2 = var_1 * var_1;

  for(var_3 = 0; var_3 < level._id_2A35.size; var_3++) {
    var_4 = level._id_2A35[var_3];

    if(isDefined(var_4) && !istrue(var_4._id_4A88) && distance2dsquared(var_0, var_4.origin) > var_2) {
      var_4._id_4A88 = 1;
      var_4 _id_47F5();
    }
  }

  for(var_3 = 0; var_3 < level._id_2AA1.size; var_3++) {
    var_5 = level._id_2AA1[var_3];

    if(isDefined(var_5) && !istrue(var_5._id_4A88) && distance2dsquared(var_0, var_5.origin) > var_2) {
      var_5._id_4A88 = 1;
      var_5 setscriptablepartstate(var_5.type, var_5._id_4AAB);
    }
  }
}

_id_B740() {
  self endon("death_or_disconnect");

  if(!scripts\mp\gametypes\br_public::_id_B66F() || self _meth_84B7()) {
    return;
  }
  scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_cash_handoff", 1.84);
}

_id_3E87() {
  if(!isDefined(self._id_B929)) {
    return;
  }
  var_0 = 0;

  for(var_1 = 0; var_1 < self._id_B929.size; var_1++) {
    var_0 = var_0 + self._id_B929[var_1]._id_B956;
  }

  self.angles = (0, 0, 0);
  _id_5052(var_0, 0);
}

_id_5053(var_0, var_1) {
  if(var_1 <= 0) {
    return;
  }
  var_2 = var_0 + (0, 0, 24);
  var_3 = "";
  wait 0.5;

  switch (var_1) {
    case 0:
      break;
    case 1:
      var_3 = "br_drop_plunder_01";
      break;
    case 2:
      var_3 = "br_drop_plunder_02";
      break;
    case 3:
      var_3 = "br_drop_plunder_03";
      break;
    case 4:
      var_3 = "br_drop_plunder_04";
      break;
    case 5:
      var_3 = "br_drop_plunder_05";
      break;
    case 6:
    default:
      var_3 = "br_drop_plunder_06";
      break;
  }

  playsoundatpos(var_2, var_3);
}

_id_5052(var_0, var_1, var_2) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_3 = [];
  var_4 = [];
  var_5 = 0;
  var_6 = 6;

  if(isDefined(var_2)) {
    var_6 = var_2;
  }

  for(var_7 = level._id_2A9B._id_BE99.size - 1; var_7 >= 0; var_7--) {
    var_4[var_7] = int(var_0 / level._id_2A9B._id_BE99[var_7]);
    var_4[var_7] = clamp(var_4[var_7], 0, var_6 - var_5);
    var_5 = var_5 + var_4[var_7];

    if(var_0 <= 0 || var_5 >= var_6) {
      break;
    } else
      var_0 = var_0 - var_4[var_7] * level._id_2A9B._id_BE99[var_7];
  }

  for(var_8 = level._id_2A9B._id_BE99.size - 1; var_8 >= 0; var_8--) {
    if(!isDefined(var_4[var_8])) {
      continue;
    }
    for(var_9 = 0; var_9 < var_4[var_8]; var_9++) {
      [var_11, var_12, var_13] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1 + var_3.size, self.origin, self.angles, self);
      var_14 = scripts\mp\gametypes\br_pickups::_id_E336(level._id_2A9B._id_A3D1[var_8], var_11, var_12, level._id_2A9B._id_BE99[var_8], 1, var_13);
      _id_A003(level._id_2A9B._id_A3D1[var_8], 1);

      if(isDefined(var_14)) {
        var_3[var_3.size] = var_14;

        if(_id_82D6()) {
          level._id_2A9D[level._id_2A9D.size] = var_14;
        }
      }
    }
  }

  level._id_2A9B._id_B936 = level._id_2A9B._id_B936 + var_5;
  level._id_2A9B._id_B952 = level._id_2A9B._id_B952 + var_0;
  level thread _id_5053(self.origin, var_3.size);
  return var_3;
}

_id_5026(var_0, var_1) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level._id_2A9B._id_A3D1.size - 1; var_5 >= 0; var_5--) {
    if(var_0 >= level._id_2A9B._id_BE99[var_5]) {
      var_4 = var_5;
      break;
    }
  }

  [var_7, var_8, var_9] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1 + var_2.size, self.origin, self.angles, self);
  var_10 = scripts\mp\gametypes\br_pickups::_id_E336(level._id_2A9B._id_A3D1[var_4], var_7, var_8, var_0, 1, var_9);
  _id_A003(level._id_2A9B._id_A3D1[var_4], 1);

  if(isDefined(var_10)) {
    var_2[var_2.size] = var_10;

    if(_id_82D6()) {
      level._id_2A9D[level._id_2A9D.size] = var_10;
    }
  }

  level._id_2A9B._id_B936++;
  level._id_2A9B._id_B952 = level._id_2A9B._id_B952 + var_0;
  level thread _id_5053(self.origin, var_2.size);
  return var_2;
}

_id_89B1() {
  if(scripts\mp\gametypes\br_gametypes::_id_8853("plunderSites")) {
    return 0;
  }

  return istrue(level._id_2A9C) && level._id_2AA1.size != 0 && getdvarint("#x3713cc35fe525bcc3", 1) != 0;
}

#using_animtree("mp_vehicles_always_loaded");

_id_81AA() {
  level._id_CC31["plunder_extract_heli"]["heli_in"] = % iw8_br_plunder_heli_in;
  level._id_CC31["plunder_extract_heli"]["heli_loop"] = % iw8_br_plunder_heli_loop;
  level._id_CC31["plunder_extract_heli"]["heli_out"] = % iw8_br_plunder_heli_out;
}

#using_animtree("script_model");

_id_81AB() {
  level._id_CC34["plunder_extract_heli"] = #animtree;
  level._id_CC31["plunder_extract_heli"]["rope_in"] = % iw8_br_plunder_heli_rope_in;
  level._id_CC32["plunder_extract_heli"]["rope_in"] = "iw8_br_plunder_heli_rope_in";
  level._id_CC31["plunder_extract_heli"]["rope_loop"] = % iw8_br_plunder_heli_rope_loop;
  level._id_CC32["plunder_extract_heli"]["rope_loop"] = "iw8_br_plunder_heli_rope_loop";
  level._id_CC31["plunder_extract_heli"]["rope_out"] = % iw8_br_plunder_heli_rope_out;
  level._id_CC32["plunder_extract_heli"]["rope_out"] = "iw8_br_plunder_heli_rope_out";
  level._id_CC31["plunder_extract_heli"]["bag_in"] = % iw8_br_plunder_heli_bag_in;
  level._id_CC32["plunder_extract_heli"]["bag_in"] = "iw8_br_plunder_heli_bag_in";
  level._id_CC31["plunder_extract_heli"]["bag_loop"] = % iw8_br_plunder_heli_bag_loop;
  level._id_CC32["plunder_extract_heli"]["bag_loop"] = "iw8_br_plunder_heli_bag_loop";
  level._id_CC31["plunder_extract_heli"]["bag_out"] = % iw8_br_plunder_heli_bag_out;
  level._id_CC32["plunder_extract_heli"]["bag_out"] = "iw8_br_plunder_heli_bag_out";
}

_id_81AC() {
  var_0 = [];
  var_1 = _id_B934("plunderHelipad1", 1);
  var_1._id_CF2F = "brloot_plunder_extraction_site_01";
  var_0[var_0.size] = var_1;
  var_1 = _id_B934("plunderHelipad2", 1);
  var_1._id_CF2F = "brloot_plunder_extraction_site_02";
  var_0[var_0.size] = var_1;

  foreach(var_1 in var_0) {
    var_1.type = 1;
    var_1._id_FEE7 = 0;
    var_1._id_FE6A = 3;
    var_1._id_FE68 = getdvarint("#x32f2a925ab4548f84", 20000);
    var_1._id_EFB6 = 0;
    var_1._id_FE6C = "MP/CANNOT_DEPOSIT_CASH_HELI_FULL";
    var_1._id_FE6D = "MP/CANNOT_DEPOSIT_CASH_HELI_LEAVING";
    var_1._id_CF30 = "activedepositcurrent";
    var_1._id_CF23 = "visiblecurrent";
    var_1._id_5815 = 0;
    var_1._id_5843 = getdvarint("#x367cbcd48472fae74", 30);
    var_1._id_5816 = "MP/CASH_HELI_LEAVING_IN_N";
    var_1._id_3212 = 0;
    var_1._id_3D9A = ::_id_7794;
    var_1._id_5814 = ::_id_77B6;
    var_1._id_1D56 = ::_id_7766;
    var_1._id_5838 = "little_bird";
  }
}

_id_6C75() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_donetsk") {
    var_0 = _func_03C0("extract_pad", "targetname");
    var_1 = _func_03C0("extract_pad_boneyard", "targetname");

    if(var_1.size > 0) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
    }
  } else {
    var_2 = _func_03C0("plunder_extraction_01", "targetname");
    var_3 = _func_03C0("plunder_extraction_02", "targetname");
    var_0 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(var_0.size > 0) {
    foreach(var_5 in var_0) {
      var_5._id_0F60 = "active";
      var_5._id_0F3E = "activeCurrent";
      var_5._id_4AAB = "visible";
      var_5._id_4A93 = "visible";
    }

    return var_0;
  } else {
    var_0 = _func_03C0("plunder_extraction", "targetname");

    foreach(var_5 in var_0) {
      var_5._id_0F60 = "visible";
      var_5._id_0F3E = "visibleCurrent";
      var_5._id_4AAB = "hidden";
    }

    return var_0;
  }
}

_id_D8A4() {
  level._id_2AA1 = _id_6C75();
  level._id_2A9F = [];
  level._id_2A9F[level._id_2A9F.size] = "brloot_plunder_extraction_site";
  level._id_2A9F[level._id_2A9F.size] = "brloot_plunder_extraction_site_01";
  level._id_2A9F[level._id_2A9F.size] = "brloot_plunder_extraction_site_02";
  level._id_2AA0 = [];
  level._id_2AA0[level._id_2AA0.size] = "active";
  level._id_2AA0[level._id_2AA0.size] = "active2";
  level._id_2AA0[level._id_2AA0.size] = "activecurrent";
  level._id_2AA0[level._id_2AA0.size] = "visiblecurrent";

  if(!_id_89B1()) {
    var_0 = getEntArray("plunder_extraction_visual", "targetname");

    foreach(var_2 in var_0) {
      var_2 delete();
    }

    foreach(var_5 in level._id_2AA1) {
      var_5 setscriptablepartstate(var_5.type, "hidden");
    }

    level._id_2AA1 = [];
    return;
  }

  _id_07D1::_id_60C2("prematch_done");
  _id_07A1::_id_CECB(::_id_B976);

  if(isDefined(level._id_9BF1) && level._id_9BF1 > 0 && !istrue(level._id_FE8D)) {
    wait(level._id_9BF1);
  } else if(istrue(level._id_FE8D)) {
    _id_07D1::_id_60C2("activate_cash_lzs");
  }

  foreach(var_8 in level.players) {
    if(isDefined(var_8)) {
      if(!scripts\mp\gametypes\br_public::_id_8805()) {
        var_8 scripts\mp\hud_message::showsplash("bm_extract_heli_start");
      }
    }
  }

  foreach(var_5 in level._id_2AA1) {
    var_11 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), var_5._id_0F3E, var_5._id_0F60);
    var_5 setscriptablepartstate(var_5.type, var_11);
  }
}

_id_68A6() {
  if(!_id_89B1()) {
    return;
  }
  var_0 = _id_6C75();
  return var_0;
}

_id_D54C(var_0) {
  foreach(var_2 in level._id_2AA1) {
    if(!scripts\engine\utility::array_contains(var_0, var_2)) {
      var_2 setscriptablepartstate(var_2.type, "hidden");
    }
  }

  level._id_2AA1 = var_0;
}

_id_44CD(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 1000));
  var_1 setModel("veh8_mil_air_mindia8_plunder_x");
  var_2 = var_0.origin[0];
  var_3 = var_0.origin[1];
  var_4 = 800;
  var_5 = var_1 _id_F3CB(var_2, var_3);
  var_6 = var_5 + var_4;
  var_7 = (var_2, var_3, var_6);
  var_1.origin = var_7;

  for(;;) {
    waitframe();
  }
}

_id_B976(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  if(!isDefined(level._id_2A9F) || !isDefined(level._id_2AA0)) {
    return;
  }
  var_6 = 1;

  foreach(var_8 in level._id_2A9F) {
    if(var_8 != var_1) {
      continue;
    }
    var_6 = 0;
    break;
  }

  if(var_6) {
    return;
  }
  var_6 = 1;

  foreach(var_11 in level._id_2AA0) {
    if(var_11 != var_2) {
      continue;
    }
    var_6 = 0;
    break;
  }

  if(var_6) {
    return;
  }
  thread _id_B977(var_0, var_1, var_2, var_3);
}

_id_B977(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_4A88)) {
    return;
  }
  if(isDefined(var_0._id_766D)) {
    var_3 _id_B691(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return;
  }

  var_4 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), "inuseCurrent", "inuse");
  var_0 setscriptablepartstate(var_0.type, var_4);
  var_5 = getgroundposition(var_0.origin, 1) + (0, 0, 2);
  var_6 = var_3 _id_B7CF(var_5, var_0);

  if(isDefined(var_6)) {
    var_6._id_DD67 = var_0;
    var_0._id_766D = var_6;
    var_0.team = var_3.team;
    thread _id_404D(var_5);
    var_3 _id_B7FA();

    if(!scripts\mp\gametypes\br_public::_id_8805()) {
      level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_requested", var_3.team, 1);
    }

    level thread scripts\mp\gametypes\br::_id_EFAD("br_extract_heli_incoming", var_3, var_3.team);
    var_6 thread _id_77BA(var_0);
  } else {
    _id_B691(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), var_0._id_0F3E, var_0._id_0F60);
    var_0 setscriptablepartstate(var_0.type, var_4);
    return;
  }

  if(istrue(level._id_B961)) {
    var_7 = scripts\common\utility::_id_B7B6(var_0.origin, 15000);
    var_8 = scripts\mp\utility\teams::_id_6DCA(var_3.team, "players");

    foreach(var_10 in var_7) {
      if(!scripts\engine\utility::array_contains(var_8, var_10)) {
        var_10 thread scripts\mp\hud_message::showsplash("br_extract_heli_incoming_them", undefined, var_3);
      }
    }
  }

  if(istrue(level._id_A248)) {
    var_0._id_4A88 = 1;
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), var_0._id_4A93, var_0._id_4AAB);
    var_0 setscriptablepartstate(var_0.type, var_4);
    level thread scripts\mp\gametypes\br_gametype_dmz::_id_5AFA(var_0);
  }
}

_id_B7FA() {
  self endon("death_or_disconnect");
  scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_plunder_smoke", 1.867);
}

_id_B691(var_0, var_1) {
  scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
  self playlocalsound("br_pickup_deny");

  if(isDefined(var_0)) {
    var_2 = self getweaponammoclip(var_0);
    self setweaponammoclip(var_0, var_2 + 1);
  }
}

_id_404D(var_0) {
  wait 1.35;
  var_1 = spawn("script_model", var_0);
  var_1 setModel("scr_smoke_grenade");
  var_1.angles = (0, 90, 90);
  var_1 playSound("smoke_carepackage_expl_trans");
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  var_1 setscriptablepartstate("smoke", "on");
  wait 17;
  var_1 endon("death");
  var_1 setscriptablepartstate("smoke", "dissipate");
  var_1 playSound("smoke_canister_tail_dissipate");
  wait 1;
  var_1 stoploopsound();
  wait 4.5;
  var_1 delete();
}

_id_B7CF(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2000);
  var_4 = var_2 + (0, 0, 8000);
  var_5 = var_2 + (0, 0, 800);
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = getdvarint("#x312c9d7d388bac7b8", 0);

  if(var_8) {
    var_9 = _id_6A27(var_2);

    if(isDefined(var_9)) {
      var_10 = var_9._id_039B;
      var_7 = var_10.angles;
    } else {
      var_6 = _id_6963(var_1, var_4, var_3);
      var_7 = (0, var_6, 0);
    }
  } else {
    var_6 = _id_6963(var_1, var_4, var_3);
    var_7 = (0, var_6, 0);
  }

  if(getdvarint("#x35f8536dae74161e4", 0) == 1) {
    var_11 = -100;
    var_12 = 60;
    var_13 = anglesToForward(var_7);
    var_14 = anglestoright(var_7);
    var_2 = var_2 + var_13 * var_11 + var_14 * var_12;
    var_3 = var_2 + (0, 0, 2000);
    var_5 = var_2 + (0, 0, 800);
  }

  var_15 = var_4 - anglesToForward(var_7) * 20000;
  var_16 = _id_E2FA(self, var_15, var_3, var_5, var_2);
  return var_16;
}

_id_6A27(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_B96D) {
    if(isDefined(var_3) && distance2dsquared(var_3.origin, var_0) <= 10000) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_6963(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0._id_5CF6)) {
    return var_0._id_5CF6;
  }

  var_3 = 10;
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 0, 1, 1, 0);
  var_5 = 0;

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + var_3) {
    var_5 = var_5 + var_6;
    var_7 = (0, var_5, 0);
    var_8 = var_1 - anglesToForward(var_7) * 20000;
    var_9 = var_2;
    var_10 = scripts\engine\trace::_id_E409(var_8, var_9, 100, undefined, var_4, 1);

    if(var_10["fraction"] == 1) {
      if(isDefined(var_0)) {
        var_0._id_5CF6 = var_5;
      }

      return var_5;
    }

    if(var_6 % 3 == 0) {
      waitframe();
    }
  }

  return var_5;
}

_id_5030(var_0) {
  if(!isDefined(var_0._id_B929)) {
    return;
  }
  level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_fail_chopper", self.team, 1);
  _id_B92C(self._id_3E6D, 0);
  var_1 = self._id_3E6D;
  self._id_3E6D = undefined;
  var_1._id_B929 = var_0._id_B929;
  var_2 = var_1.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["position"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = _func_0218(2 * var_7 / 800);
    var_1 moveto(var_6, var_8, var_8, 0);
    wait(var_8);
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_6);
  _id_550D(var_1, 1);
  var_1 thread _id_7796(var_0);
}

_id_2EEA(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + _func_0218(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

_id_2EE9(var_0) {
  var_1 = _id_2EEA(20000, 100, 125);
  var_2 = _id_2EEA(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

_id_77BA(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = self._id_5818[2];
  var_2 = self._id_480A[2] - var_1;
  self._id_5D49 = _id_2EE9(var_2);
  thread _id_77EA();
  self._id_BC1A = 1;
  _id_779A();
  self._id_BC1A = undefined;
  self setscriptablepartstate("vector_field", "on");

  if(!istrue(level.gameended)) {
    if(!scripts\mp\gametypes\br_public::_id_8805()) {
      level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_arrive", self.team, 1);
    }

    thread _id_77E9(var_0);
    return;
  }

  thread _id_77C2(1);
}

_id_77E9(var_0) {
  var_1 = undefined;

  if(var_0.type == "brloot_plunder_extraction_site_01") {
    var_1 = "plunderHelipad1";
  } else if(var_0.type == "brloot_plunder_extraction_site_02") {
    var_1 = "plunderHelipad2";
  } else {}

  _id_B93D(var_0, var_1);
  var_2 = undefined;

  if(isDefined(self.team)) {
    var_2 = scripts\mp\utility\teams::_id_6A59(self.team);
  }

  thread _id_B94A(var_0, var_2);
  _id_B950(var_0, var_2);
}

_id_7768(var_0) {
  if(!istrue(level.gameended) && !scripts\mp\gametypes\br_public::_id_8805()) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_success", self.team, 1);
  }

  var_1 = var_0 _id_550C();

  if(isDefined(var_1) && isDefined(var_1._id_1754) && var_1._id_1754 > 0) {
    level._id_2A9B._id_582A = level._id_2A9B._id_582A + var_1._id_1754;
    level._id_2A9B._id_5829++;
  }
}

_id_E362(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("misc_rapelling_rope_01_fiber_br");
  var_1 linkto(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_1._id_18AF = var_0._id_18AF;
  var_1 _id_06C6::_id_D47B();
  var_0 _id_06C6::_id_17C2(var_1, "rope_in", "origin_animate_jnt");
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("br_plunder_extraction_delivery_bag");
  var_2 linkto(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_2._id_18AF = var_0._id_18AF;
  var_2 _id_06C6::_id_D47B();
  var_0 _id_06C6::_id_17C2(var_2, "bag_in", "origin_animate_jnt");
  var_0._id_C918 = var_1;
  var_0._id_3E6D = var_2;
}

_id_E2FA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = vectortoangles(var_2 * (1, 1, 0) - var_1 * (1, 1, 0));
  var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_1, var_6, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var_7)) {
    return;
  }
  var_7._id_42E9 = ::_id_2F40;
  var_7.speed = 100;
  var_7.accel = 125;
  var_7.health = scripts\engine\utility::ter_op(scripts\mp\utility\game::_id_6D9E() == "dmz", level._id_5840, 1000);
  var_7.maxhealth = var_7.health;
  var_7.team = var_0.team;
  var_7.owner = var_0;
  var_7._id_936C = 0;
  var_7._id_5C8A = var_5;
  var_7._id_54DE = var_1;
  var_7._id_480A = var_2;
  var_7._id_7B12 = var_3;
  var_7._id_5818 = var_4;
  var_7._id_CBCE = var_6;
  var_7._id_1031E = "magma_plunder_chopper";
  var_7._id_18AF = "plunder_extract_heli";
  var_7 setCanDamage(1);
  var_7 setmaxpitchroll(10, 25);
  var_7 vehicle_setspeed(var_7.speed, var_7.accel);
  var_7 sethoverparams(1, 1, 1);
  var_7 setturningability(0.05);
  var_7 setyawspeed(45, 25, 25, 0.5);
  var_7 setotherent(var_0);
  var_7 setscriptablepartstate("engine", "on");
  var_7 setscriptablepartstate("tail_light", "red");
  var_7 setscriptablepartstate("cockpit_light", "on");
  var_7 setscriptablepartstate("infil_lights", "on");
  var_7._id_CBD0 = spawn("script_model", var_7._id_5818);
  var_7._id_CBD0.angles = var_7._id_CBCE;
  var_7._id_CBD0 setModel("tag_origin");
  var_7._id_CBD0 _id_06C6::_id_17C2(var_7, "heli_in");
  _id_E362(var_7);
  return var_7;
}

_id_7796(var_0) {
  _id_B930(self);
  self hide();

  if(isDefined(var_0)) {
    var_0._id_3E6D = undefined;
  }

  waitframe();
  self delete();
}

_id_779B() {
  self endon("heli_gone");
  var_0 = self.owner;
  self waittill("death", var_1, var_2, var_3, var_4);
  var_5 = 0;

  if(isDefined(self._id_B929)) {
    foreach(var_7 in self._id_B929) {
      var_5 = var_5 + var_7._id_B956;
    }
  }

  scripts\mp\gametypes\br_analytics::_id_2B02(var_5, "little_bird", self._id_5818, self.origin);
  thread _id_5030(self);
  _id_776A();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_8EE2) && !istrue(self._id_87F9)) {
    self vehicle_setspeed(25, 5);
    thread _id_7795(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  _id_77B3(var_1);
}

_id_776A() {
  if(isDefined(self._id_C918)) {
    self._id_C918 delete();
  }

  if(isDefined(self._id_3E6D)) {
    self._id_3E6D thread _id_7796(self);
  }

  if(isDefined(self._id_CBD0)) {
    self._id_CBD0 delete();
  }
}

_id_77B3(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::_id_EFAD("br_extract_heli_shot_down", self.owner, self.team);
  _id_7798();
}

_id_7798() {
  _id_776A();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_7795(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if(istrue(level._id_5841)) {
    return;
  }
  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level._id_5FA5 && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_5, self, var_4, var_2);
  var_1 _id_07C4::_id_FC47("");

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_77C2(var_0) {
  if(istrue(self._id_F74E) || istrue(self._id_916C)) {
    return;
  }
  self endon("death");
  self notify("try_to_leave");
  self._id_F74E = 1;

  if(!istrue(level.gameended) && !scripts\mp\gametypes\br_public::_id_8805()) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_leave", self.team, 1);
  }

  var_1 = self._id_DD67;

  if(isDefined(var_1)) {
    _id_B940(var_1);
    _id_7768(var_1);

    if(isDefined(var_1._id_766D) && var_1._id_766D == self) {
      var_1._id_766D = undefined;
      var_1.team = undefined;
    }

    var_1 thread _id_76A3(self._id_DD67.type);
    self._id_DD67 = undefined;
  }

  self._id_C0AE = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self._id_916C = 1;
  self._id_F74E = undefined;
  var_2 = _func_0079(level._id_CC31[self._id_18AF]["heli_out"]);
  self._id_CBD0 thread _id_06C6::_id_1845(self, "heli_out");
  thread _id_06C6::_id_1845(self._id_C918, "rope_out", "origin_animate_jnt");
  thread _id_06C6::_id_1845(self._id_3E6D, "bag_out", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  self stoploopsound();
  self notify("heli_gone");
  _id_7798();
}

_id_76A3(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), "inuseCurrent", "inuse");
  self setscriptablepartstate(var_0, var_1);
  wait 6;
  var_1 = scripts\engine\utility::ter_op(istrue(level._id_DCD7) && !istrue(level._id_DCCB), self._id_0F3E, self._id_0F60);
  self setscriptablepartstate(var_0, var_1);
}

_id_779A() {
  self endon("death");
  var_0 = _func_0079(level._id_CC31[self._id_18AF]["heli_in"]);
  self._id_CBD0 thread _id_06C6::_id_1845(self, "heli_in");
  thread _id_06C6::_id_1845(self._id_C918, "rope_in", "origin_animate_jnt");
  thread _id_06C6::_id_1845(self._id_3E6D, "bag_in", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  thread _id_77D5();
  thread _id_77D7();
  thread _id_77D6();
}

_id_77D5() {
  self endon("death");
  self._id_CBD0 endon("death");
  var_0 = _func_0079(level._id_CC31[self._id_18AF]["heli_loop"]);

  for(;;) {
    self._id_CBD0 thread _id_06C6::_id_1845(self, "heli_loop");
    wait(var_0);

    if(istrue(self._id_C0AE) && !istrue(self._id_BC1A)) {
      self notify("ready_to_leave");
      break;
    }
  }
}

_id_77D7() {
  self endon("death");
  var_0 = _func_0079(level._id_CC31[self._id_18AF]["rope_loop"]);

  for(;;) {
    thread _id_06C6::_id_1845(self._id_C918, "rope_loop", "origin_animate_jnt");
    wait(var_0);

    if(istrue(self._id_C0AE)) {
      break;
    }
  }
}

_id_77D6() {
  self endon("death");
  var_0 = _func_0079(level._id_CC31[self._id_18AF]["bag_loop"]);

  for(;;) {
    thread _id_06C6::_id_1845(self._id_3E6D, "bag_loop", "origin_animate_jnt");
    wait(var_0);

    if(istrue(self._id_C0AE)) {
      break;
    }
  }
}

_id_54EE() {
  return isalive(self) && (scripts\common\vehicle::_id_8AF5() || isDefined(self.classname) && self.classname == "script_vehicle");
}

_id_779C() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && var_0 _id_54EE()) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

_id_779D() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = _func_0098("script_vehicle", "classname", self.origin, getdvarfloat("#x34b8346a089ba183b", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::_id_3F87();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7036459ed3de1", var_2) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc6f86459ed25b0", var_3) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7076459ed46ad", var_4) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

_id_F3C9(var_0) {
  var_1 = 800;
  var_2 = _id_F3CB(var_0);
  var_3 = var_2 + var_1;
  return var_3;
}

_id_F3CB(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = -99999;
  var_2 = (var_0[0], var_0[1], var_1);
  var_3 = [self];
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0, 1, 1, 0);
  var_5 = scripts\engine\trace::_id_E409(var_0, var_2, 100, var_3, var_4, 1);
  var_6 = var_5["position"][2];
  return var_6;
}

_id_77EA() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread _id_77C2(0);
}

_id_7794(var_0, var_1) {
  _id_B943(var_0);
}

_id_77B6(var_0) {
  if(isDefined(var_0._id_766D)) {
    var_0._id_766D thread _id_77C2(1);
  }
}

_id_7766(var_0) {}

_id_B968() {
  thread _id_1F4E();
}

_id_82D6() {
  return istrue(level._id_2A9C) && istrue(level._id_2A9E) && !_id_07D1::_id_60BE("prematch_done");
}

_id_1F4E() {
  var_0 = 0.1;
  var_1 = 25;
  var_2 = var_1 * var_1;

  while(_id_82D6()) {
    for(var_3 = 0; var_3 < level._id_2A9D.size; var_3++) {
      var_4 = level._id_2A9D[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = var_4.origin;

      for(var_6 = 0; var_6 < level.players.size; var_6++) {
        var_7 = level.players[var_6];

        if(!isalive(var_7)) {
          continue;
        }
        var_8 = distancesquared(var_7.origin, var_5);

        if(var_8 < var_2) {
          var_7 scripts\mp\gametypes\br_pickups::_id_2C2D(var_4, var_7);
          break;
        }
      }
    }

    wait(var_0);
  }
}

_id_B68F() {
  self notify("playerDelayAutoBankPlunder");
  self endon("playerDelayAutoBankPlunder");
  self endon("death");
  level endon("prematch_done");
  level endon("game_ended");
  wait 2;
  _id_B746(self._id_B956);
}

_id_B751(var_0) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  if(_id_82D6()) {
    var_1 = var_0 == "MOD_MELEE";
    var_2 = 1;

    if(var_1 && isDefined(self._id_B956) && self._id_B956 > 1) {
      var_2 = self._id_B956;
      _id_B7A3(0);
    }

    if(var_2 <= 0) {
      return;
    }
    if(level._id_2A9D.size > 0) {
      level._id_2A9D = scripts\engine\utility::_id_1BD1(level._id_2A9D);
    }

    return _id_5026(var_2, 0);
  }
}

_id_82AA() {
  foreach(var_1 in level._id_EF89) {
    level._id_EF6A[var_1]["plunderTeamTotal"] = 0;
    level._id_EF6A[var_1]["plunderInDeposit"] = 0;
    level._id_EF6A[var_1]["plunderBanked"] = 0;
  }
}

_id_6C76(var_0) {
  var_1 = level._id_2A9B._id_A3D1[0];

  for(var_2 = level._id_2A9B._id_BE99.size - 1; var_2 > 0; var_2--) {
    if(var_0 >= level._id_2A9B._id_BE99[var_2]) {
      var_1 = level._id_2A9B._id_A3D1[var_2];
      break;
    }
  }

  return var_1;
}

_id_B8BD(var_0, var_1) {
  if(var_1 == 0) {
    return;
  }
  var_2 = _id_6C76(var_1);
  var_3 = scripts\mp\gametypes\br_pickups::_id_694F(var_0, var_2);
  var_0 playsoundtoplayer(var_3, self);
}

_id_BD63() {
  foreach(var_7, var_1 in level._id_2A9B._id_A3D1) {
    var_2 = getdvarint(_func_0483("#x369f24248c1d1b542", scripts\engine\utility::_id_EA52(var_7)), -1);

    if(var_2 > -1) {
      level._id_2A9B._id_BE99[var_7] = var_2;
      level._id_2A95._id_3DAB[var_1] = var_2;
      var_3 = _func_03C0(var_1);

      foreach(var_5 in var_3) {
        var_5._id_011A = var_2;
      }
    }
  }
}

_id_BD62(var_0) {
  foreach(var_7, var_2 in level._id_2A9B._id_A3D1) {
    level._id_2A9B._id_BE99[var_7] = int(float(level._id_2A9B._id_BE99[var_7]) * var_0);
    level._id_2A95._id_3DAB[var_2] = level._id_2A9B._id_BE99[var_7];
    var_3 = _func_03C0(var_2);

    foreach(var_5 in var_3) {
      var_5._id_011A = level._id_2A9B._id_BE99[var_7];
    }

    waitframe();
  }
}

_id_4434() {
  var_0 = 0;

  foreach(var_4, var_2 in level._id_2A9B._id_A3D1) {
    var_3 = _func_03C0(var_2);
    var_0 = var_0 + var_3.size * level._id_2A95._id_3DAB[var_2];
  }

  var_0 = var_0 * 100;
  level._id_F372 = var_0;
}

_id_B935() {
  level._id_B971 = spawnStruct();
  level._id_B971._id_4350 = [];
  level._id_B971._id_8300 = [];
  level._id_B971._id_F951 = 0;
  level._id_B971._id_EF61 = [];
  level._id_B971._id_EF5E = [];
  level._id_B971._id_EF5F = [];

  for(var_0 = 1; var_0 <= 3; var_0++) {
    level._id_B971._id_EF5E[var_0] = "ui_br_plunder_repo_ent_" + var_0;
    level._id_B971._id_EF5F[var_0] = "ui_br_plunder_repo_info_" + var_0;
  }

  scripts\common\interactive::_id_8397(::_id_B947, "plunderRepository");
  _id_07A1::_id_CECB(::_id_B949);
  _id_0AA3::_id_C28D(::_id_B93C);
  level._id_B97C = getdvarint("#x329f7c51465ed8858", 0) > 0;
}

_id_B934(var_0, var_1, var_2) {
  var_3 = level._id_B971;
  var_4 = var_3._id_4350[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3._id_4350[var_0] = var_4;
      var_4._id_FEE7 = 0.75;
      var_4._id_FE6A = 2;
      var_4._id_FE68 = 250;
      var_4._id_EFB6 = 1;
      var_4._id_EF60 = 0;
      var_4._id_FE6E = "MP/CANNOT_DEPOSIT_LS";
      var_4._id_FE70 = "MP/CANNOT_DEPOSIT_VEHICLE";
      var_4._id_FE6C = "MP/PLACEHOLDER_CANNOT_DEPOSIT_FULL";
      var_4._id_FE6F = "MP/CANNOT_DEPOSIT_NO_CASH";
      var_4._id_FE6D = "MP/PLACEHOLDER_CANNOT_DEPOSIT_LEAVING";
      var_4._id_CF2F = undefined;
      var_4._id_CF30 = undefined;
      var_4._id_CF23 = undefined;
      var_4._id_5815 = 60;
      var_4._id_5843 = 0;
      var_4._id_5816 = "MP/PLACEHOLDER_LEAVING_IN_N";
      var_4._id_3212 = 2000;
      var_4._id_FEC8 = undefined;
      var_4._id_FE2F = ::_id_B945;
      var_4._id_3D9A = undefined;
      var_4._id_5814 = undefined;
      var_4._id_5838 = undefined;
    } else {}
  }

  return var_4;
}

_id_B93D(var_0, var_1) {
  var_2 = level._id_B971;
  var_3 = _id_B934(var_1);
  var_0._id_B972 = var_1;
  var_0._id_E706 = var_0.origin;
  var_0._id_B929 = [];
  var_0._id_B979 = 0;
  var_0._id_B964 = level._id_B971._id_F951;
  level._id_B971._id_F951++;
  var_0._id_B7EA = [];
  var_2._id_8300[var_0._id_B964] = var_0;
  _id_B92A(var_0);

  if(!isDefined(var_3._id_CF2F)) {
    var_0 scripts\common\interactive::_id_8398("plunderRepository");
  }

  _id_B92C(var_0, 1);
}

_id_B930(var_0) {
  var_1 = level._id_B971;
  var_0 notify("plunder_instance_deregistered");
  _id_B92C(var_0, 0, 1);
  var_0._id_B972 = undefined;
  var_0._id_B97B = undefined;
  var_0._id_B954 = undefined;
  var_0._id_E706 = undefined;
  var_0._id_B929 = undefined;
  var_0._id_B979 = undefined;
  _id_B940(var_0);
  var_0._id_B7EA = undefined;

  if(isDefined(var_0._id_B964)) {
    var_1._id_8300[var_0._id_B964] = undefined;
  }

  _id_B93E(var_0);
  var_0 scripts\common\interactive::_id_839F();
}

_id_B944(var_0) {
  var_1 = level._id_B971;

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = undefined;

  if(isDefined(var_0._id_B964)) {
    var_2 = var_1._id_8300[var_0._id_B964];
  }

  return isDefined(var_2) && var_2 == var_0;
}

_id_B92C(var_0, var_1, var_2) {
  var_0 notify("plunder_allowRepositoryUse");
  var_3 = undefined;

  if(isDefined(var_0._id_B972)) {
    var_3 = _id_B934(var_0._id_B972, undefined, var_2);
  }

  if(isDefined(var_3)) {
    if(isDefined(var_3._id_CF2F)) {
      if(var_1) {
        var_0 setscriptablepartstate(var_3._id_CF2F, var_3._id_CF30, 0);
      } else {
        var_0 setscriptablepartstate(var_3._id_CF2F, var_3._id_CF23, 0);
      }
    } else if(var_1)
      var_0 makeuseable();
    else {
      var_0 makeunusable();
    }

    var_4 = istrue(var_0._id_B97B);
    var_0._id_B97B = scripts\engine\utility::ter_op(var_1, var_1, undefined);

    if(!var_4) {
      if(var_1) {
        foreach(var_6 in level.players) {
          _id_B92D(var_0, var_6, _id_B93A(var_0, var_6));
        }
      }
    } else if(!var_1)
      var_0 notify("repository_use_disabled");
  }
}

_id_B92D(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0._id_B972)) {
    var_4 = _id_B934(var_0._id_B972, undefined, var_3);
  }

  if(isDefined(var_4)) {
    if(isDefined(var_4._id_CF2F)) {
      if(var_2) {
        var_0 _meth_86A0(var_4._id_CF2F, var_1);
      } else {
        var_0 _meth_86A1(var_4._id_CF2F, var_1);
      }
    } else if(var_2)
      var_0 _meth_80E0(var_1);
    else {
      var_0 disableplayeruse(var_1);
    }
  }

  if(!var_2) {
    var_0 notify("repository_use_disabled_for_" + var_1 getentitynumber());
  }
}

_id_B92B(var_0, var_1, var_2) {
  var_3 = level._id_B971;

  foreach(var_5 in var_3._id_8300) {
    _id_B92D(var_5, var_0, var_1, 1);
  }
}

_id_B93A(var_0, var_1) {
  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return 0;
  }

  if(scripts\mp\utility\player::_id_88C8(var_1)) {
    return 0;
  }

  var_2 = _id_B934(var_0._id_B972);

  if(istrue(var_2._id_EFB6) && isDefined(var_0.team) && var_1.team != var_0.team) {
    return 0;
  }

  return 1;
}

_id_B93B(var_0, var_1, var_2) {
  var_3 = _id_B934(var_0._id_B972);

  if(!istrue(var_0._id_B97B)) {
    return 0;
  }

  if(var_3._id_FE6A == 2 || var_3._id_FE6A == 3) {
    if(var_1._id_B956 <= 0) {
      if(istrue(var_2) && isDefined(var_3._id_FE6F) && var_3._id_FE6F != "") {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::_id_DCA2(var_3._id_FE6F);
      }

      return 0;
    } else if(istrue(var_0._id_B954)) {
      if(istrue(var_2) && isDefined(var_3._id_FE6C) && var_3._id_FE6C != "") {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::_id_DCA2(var_3._id_FE6C);
      }

      return 0;
    }
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(istrue(var_2) && isDefined(var_3._id_FE70) && var_3._id_FE70 != "") {
      var_1 playlocalsound("br_plunder_atm_cancel");
      var_1 scripts\mp\hud_message::_id_DCA2(var_3._id_FE70);
    }

    return 0;
  }

  if(scripts\mp\utility\player::_id_88C8(var_1)) {
    if(istrue(var_2) && isDefined(var_3._id_FE6E) && var_3._id_FE6E != "") {
      var_1 playlocalsound("br_plunder_atm_cancel");
      var_1 scripts\mp\hud_message::_id_DCA2(var_3._id_FE6E);
    }

    return 0;
  }

  if(var_1 _meth_86B8() || var_1 isskydiving()) {
    return 0;
  }

  if(var_1 _meth_86C8() || var_1 _meth_86C9()) {
    return 0;
  }

  if(isDefined(var_3._id_FEC8)) {
    return [[var_3._id_FEC8]](var_0, var_1, var_2);
  }

  return 1;
}

_id_B949(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    return;
  }
  var_6 = var_0._id_019B;

  if(!isDefined(var_6)) {
    var_6 = var_0;
  }

  if(!_id_B944(var_6)) {
    return;
  }
  var_7 = _id_B934(var_6._id_B972);

  if(!isDefined(var_7._id_CF2F)) {
    return;
  }
  if(var_1 != var_7._id_CF2F) {
    return;
  }
  if(var_2 != var_7._id_CF30) {
    return;
  }
  if(!_id_B93B(var_6, var_3, 1)) {
    return;
  }
  thread _id_B948(var_6, var_3);
}

_id_B947(var_0, var_1) {
  if(!_id_B944(var_0)) {
    return;
  }
  if(!_id_B93B(var_0, var_1, 1)) {
    return;
  }
  thread _id_B948(var_0, var_1);
}

_id_B948(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = gettime();
  _id_B941(var_1, 1);
  _id_B92D(var_0, var_1, 0);
  _id_B94B(var_0, var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      _id_B92D(var_0, var_1, 1);
    }

    if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_B941(var_1, 0);
    }

    var_1._id_B973 = undefined;

    if(isPlayer(var_1)) {
      var_4 = 0;
      var_5 = undefined;

      if(!var_4 && var_1 scripts\cp_mp\utility\player_utility::_isalive() && !var_1 scripts\cp_mp\utility\player_utility::isinvehicle() && !scripts\mp\utility\player::_id_88C8(var_1)) {
        if(istrue(var_0._id_581A)) {
          var_5 = 2;
        } else if(isDefined(var_1._id_B974) && isDefined(var_1._id_B974._id_FE69) && var_1._id_B974._id_FE69 - gettime() <= 1.5) {
          var_5 = 1.5;
        }
      }

      thread _id_B92F(var_1, var_5);
    }
  }

  if(isDefined(var_0) && isDefined(var_0._id_B7EA)) {
    var_0._id_B7EA[var_2] = undefined;
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_B950(var_0, var_1);
  }
}

_id_B94B(var_0, var_1) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  var_0 endon("repository_use_disabled");
  var_0 endon("repository_use_disabled_for_" + var_1 getentitynumber());
  level endon("game_ended");
  var_2 = _id_B934(var_0._id_B972);
  var_0._id_B7EA[var_1 getentitynumber()] = var_1;
  _id_B951(var_1, var_0._id_B964, var_2.type, 1, var_0._id_B957, var_0._id_B979);
  _id_B94C(var_1);
  _id_B950(var_0, var_1);
  var_3 = 0;
  var_4 = 0;
  var_5 = var_2._id_FEE7;

  for(var_6 = 0; var_1 useButtonPressed(); var_4 = var_4 + 0.05) {
    var_7 = undefined;

    if(var_3) {
      var_3 = 0;
      var_7 = 0;
    } else
      var_7 = 1;

    if(!_id_B93B(var_0, var_1, var_7)) {
      return;
    }
    if(var_4 >= var_5) {
      var_8 = int(min(var_1._id_B956, var_2._id_FE68));

      if(isDefined(var_2._id_FE2F)) {
        thread[[var_2._id_FE2F]](var_0, var_1, var_8);
      } else {}

      var_6 = var_4;
      var_5 = var_4 + var_2._id_FEE7;

      if(isDefined(var_1._id_B974)) {
        var_1._id_B974._id_FE69 = gettime();
      }

      var_3 = 1;
    }

    wait 0.05;
  }
}

_id_B945(var_0, var_1, var_2) {
  var_3 = _id_B934(var_0._id_B972);
  var_4 = var_1 _id_B74D(var_2, var_3._id_FE6A, var_0);

  if(isDefined(var_4) && isDefined(var_4._id_0050)) {
    var_2 = var_4._id_0050;
  }

  if(var_2 > 0) {
    _id_B951(var_1, undefined, undefined, undefined, undefined, var_0._id_B979, var_2);
    _id_B94C(var_1);
  }
}

_id_B941(var_0, var_1) {
  var_2 = ["movement", "usability", "weapon_switch", "equipment", "supers", "killstreaks", "fire", "melee", "reload", "ads", "mantle", "mount_top", "mount_side", "execution_attack", "vehicle_use", "cough_gesture"];

  if(istrue(var_0._id_B973) && var_1) {
    return;
  }
  if(!istrue(var_0._id_B973) && !var_1) {
    return;
  }
  var_0 scripts\common\utility::_id_1523(var_2, !var_1);

  if(var_1) {
    var_0._id_B973 = 1;
  } else {
    var_0._id_B973 = undefined;
  }
}

_id_B94A(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("plunder_instance_deregistered");
  var_0 notify("plunder_repositoryWatchCountdown");
  var_0 endon("plunder_repositoryWatchCountdown");
  level endon("game_ended");
  var_2 = _id_B934(var_0._id_B972);

  if(!isDefined(var_0._id_B959)) {
    var_0._id_B959 = [];
    var_0._id_B95A = 0;
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2._id_5843), var_2._id_5843, 0);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_2._id_5815), var_2._id_5815, 0);
    var_0._id_B975 = gettime() + var_3 * 1000;
    var_0._id_B957 = gettime() + (var_3 + var_4) * 1000;
  }

  if(isDefined(var_1)) {
    if(!_func_0107(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_6 in var_1) {
      if(isDefined(var_6) && isPlayer(var_6)) {
        var_0._id_B959[var_6 getentitynumber()] = var_6;
      }
    }
  }

  while(gettime() <= var_0._id_B957) {
    if(gettime() - var_0._id_B95A >= 1000) {
      if(gettime() > var_0._id_B975) {
        var_8 = int(max(0, (var_0._id_B957 - gettime()) / 1000));

        foreach(var_6 in var_0._id_B959) {
          if(isDefined(var_6)) {
            thread _id_B946(var_6, var_0, var_8);
          }
        }
      }

      var_0._id_B95A = gettime();
    }

    wait 0.05;
  }

  thread _id_B942(var_0, 1);
}

_id_B942(var_0, var_1) {
  _id_B940(var_0);
  var_2 = _id_B934(var_0._id_B972);

  if(isDefined(var_2._id_3D9A)) {
    [[var_2._id_3D9A]](var_0, var_1);
  }
}

_id_B940(var_0) {
  var_0 notify("plunder_repositoryWatchCountdown");
  var_0._id_B959 = undefined;
  var_0._id_B957 = undefined;
  var_0._id_B95A = undefined;
}

_id_B946(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 notify("plunder_repositorySendCountdownMessage");
  var_0 endon("plunder_repositorySendCountdownMessage");
  level endon("game_ended");

  if(!isDefined(var_0._id_B958)) {
    var_0._id_B958 = [];
  }

  var_3 = _id_B934(var_1._id_B972);

  if(isDefined(var_3._id_5816)) {
    var_4 = spawnStruct();
    var_4.origin = var_1.origin;
    var_4._id_A2B9 = var_3._id_5816;
    var_4._id_04CB = var_2;
    var_0._id_B958[var_0._id_B958.size] = var_4;
  }

  waittillframeend;

  if(!var_0 scripts\mp\gametypes\br_public::_id_8990() && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_5 = undefined;
    var_6 = 2147483647;

    foreach(var_4 in var_0._id_B958) {
      var_8 = distance2dsquared(var_0.origin, var_4.origin);

      if(var_8 < var_6) {
        var_6 = var_8;
        var_5 = var_4;
      }
    }
  }

  var_0._id_B958 = undefined;
}

_id_B943(var_0) {
  var_0._id_581A = 1;
  _id_B940(var_0);
  _id_B92C(var_0, 0);
  _id_B93E(var_0);
  var_1 = _id_B934(var_0._id_B972);

  if(isDefined(var_1._id_5814)) {
    [[var_1._id_5814]](var_0);
  }
}

_id_B93F(var_0) {
  var_0._id_B954 = 1;
  _id_B92C(var_0, 0);
  var_1 = _id_B934(var_0._id_B972);

  if(isDefined(var_1._id_1D56)) {
    [[var_1._id_1D56]](var_0);
  }
}

_id_B93C() {
  _id_B92B(self, 1, 1);
}

_id_B951(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3) && !var_3) {
    _id_B92F(var_0);
    return;
  }

  var_7 = var_0._id_B974;

  if(!isDefined(var_7)) {
    var_7 = spawnStruct();
    var_0._id_B974 = var_7;
    var_7._id_B964 = var_1;
    var_7.type = var_2;
    var_7._id_10417 = 0;
    var_7._id_534E = undefined;
    var_7._id_B979 = undefined;
    var_7._id_B95E = undefined;
    var_7._id_F27A = undefined;
  } else if(isDefined(var_1) && isDefined(var_7._id_B964) && var_1 != var_7._id_B964) {
    return;
  }
  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = !var_7._id_10417;
    var_7._id_10417 = 1;
  }

  if(isDefined(var_4)) {
    var_7._id_534E = var_4;
  }

  if(isDefined(var_5)) {
    var_7._id_B979 = var_5;
  }

  if(isDefined(var_6)) {
    var_7._id_B95E = var_6;
    var_9 = level._id_B971._id_8300[var_7._id_B964];

    foreach(var_11 in var_9._id_B7EA) {
      if(var_11 != var_0) {
        _id_B951(var_0, undefined, undefined, undefined, undefined, var_5, undefined);
        _id_B94C(var_0);
      }
    }

    if(isDefined(var_9.team)) {
      _id_B950(var_9, scripts\mp\utility\teams::_id_6A59(var_9.team));
    }
  } else if(isDefined(var_7._id_F27A) && var_7._id_F27A < gettime())
    var_7._id_B95E = undefined;

  var_7._id_F27A = gettime();
}

_id_B92F(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("plunder_sendRepositoryWidgetOmnvar");
  var_0._id_B974 = undefined;

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  var_0 setclientomnvar("ui_br_plunder_repository", 0);
}

_id_B94C(var_0) {
  var_0 notify("plunder_sendRepositoryWidgetOmnvar");
  var_1 = var_0._id_B974;

  if(!isDefined(var_1)) {
    var_0 setclientomnvar("ui_br_plunder_repository", 0);
    return;
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = var_1._id_10417;
  var_5 = 1;

  if(isDefined(var_4)) {
    var_2 = var_2 | int(var_4) << var_3;
  }

  var_3 = var_3 + var_5;
  var_4 = var_1.type;
  var_5 = 1;

  if(isDefined(var_4)) {
    var_2 = var_2 | int(var_4) << var_3;
  }

  var_3 = var_3 + var_5;
  var_4 = var_1._id_534E;
  var_5 = 14;

  if(isDefined(var_4)) {
    var_4 = int(var_4 / 250);
    var_4 = var_4 & 16383;
    var_2 = var_2 | int(var_4) << var_3;
  }

  var_3 = var_3 + var_5;

  if(var_1.type == 0) {
    var_4 = var_1._id_B979;
    var_5 = 9;

    if(isDefined(var_4)) {
      var_4 = int(var_4 / 5);
      var_4 = var_4 & 511;
      var_2 = var_2 | int(var_4) << var_3;
    }

    var_3 = var_3 + var_5;
    var_4 = var_1._id_B95E;
    var_5 = 6;

    if(isDefined(var_4)) {
      var_4 = int(var_4 / 5);
      var_4 = var_4 & 63;
      var_2 = var_2 | int(var_4) << var_3;
    }
  } else {
    var_4 = var_1._id_B95E;
    var_5 = 15;

    if(isDefined(var_4)) {
      var_4 = int(var_4 / 5);
      var_4 = var_4 & 32767;
      var_2 = var_2 | int(var_4) << var_3;
    }
  }

  var_0 setclientomnvar("ui_br_plunder_repository", var_2);
}

_id_B92A(var_0) {
  var_1 = level._id_B971;
  var_2 = _id_B934(var_0._id_B972);

  if(!istrue(var_2._id_EF60)) {
    return;
  }
  if(!isDefined(var_1._id_EF61[var_0.team])) {
    var_1._id_EF61[var_0.team] = [];
  }

  var_3 = [];

  for(var_4 = 1; var_4 <= 3; var_4++) {
    var_3[var_4] = var_4;
  }

  foreach(var_6 in var_1._id_EF61[var_0.team]) {
    var_3[var_6._id_1781] = undefined;
  }

  foreach(var_9 in var_3) {
    var_0._id_1781 = var_9;
    break;
  }

  if(isDefined(var_0._id_1781)) {
    var_1._id_EF61[var_0.team] = ::scripts\engine\utility::array_add(var_1._id_EF61[var_0.team], var_0);
    var_11 = var_1._id_EF5E[var_0._id_1781];

    foreach(var_13 in scripts\mp\utility\teams::_id_6A59(var_0.team)) {
      var_13 setclientomnvar(var_11, var_0 getentitynumber());
    }
  } else {}
}

_id_B93E(var_0) {
  var_1 = level._id_B971;
  var_2 = var_0._id_1781;

  if(!isDefined(var_2)) {
    return;
  }
  var_0._id_1781 = undefined;
  var_1._id_EF61[var_0.team] = ::scripts\engine\utility::array_remove(var_1._id_EF61[var_0.team], var_0);

  if(var_1._id_EF61[var_0.team].size == 0) {
    var_1._id_EF61[var_0.team] = undefined;
  }

  var_3 = var_1._id_EF5E[var_2];
  var_4 = var_1._id_EF5F[var_2];

  foreach(var_6 in scripts\mp\utility\teams::_id_6A59(var_0.team)) {
    var_6 setclientomnvar(var_3, -1);
    var_6 setclientomnvar(var_4, 0);
  }
}

_id_B950(var_0, var_1) {
  var_2 = level._id_B971;

  if(!isDefined(var_0._id_1781)) {
    return;
  }
  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  if(var_1.size == 0) {
    return;
  }
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  var_6 = 1;
  var_3 = var_3 + var_5;
  var_4 = var_4 + var_6;
  var_5 = var_0._id_B957;
  var_6 = 14;

  if(isDefined(var_5)) {
    var_5 = var_5 / 250;
    var_5 = int(min(var_5, 16383));
    var_3 = var_3 + (var_5 << var_4);
  }

  var_4 = var_4 + var_6;
  var_5 = var_0._id_B979;
  var_6 = 9;

  if(isDefined(var_5)) {
    var_5 = var_5 / 5;
    var_5 = int(min(var_5, 511));
    var_3 = var_3 + (var_5 << var_4);
  }

  var_7 = var_2._id_EF5F[var_0._id_1781];

  foreach(var_9 in var_1) {
    if(scripts\engine\utility::array_contains(var_0._id_B7EA, var_9)) {
      var_9 setclientomnvar(var_7, var_3 &~1);
      continue;
    }

    var_9 setclientomnvar(var_7, var_3);
  }
}