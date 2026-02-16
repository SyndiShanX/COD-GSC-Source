/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters.gsc
*****************************************************/

init() {
  setdvarifuninitialized("#x37e8e066042375daf", 0);

  if(!getdvarint("#x37e8e066042375daf", 0)) {
    return;
  }
  setdvarifuninitialized("#x3b898e34353227ee3", 30);
  var_0 = spawnStruct();
  var_0 _id_7F6F();
  var_0 _id_7FE0();
  var_0 thread _id_5277();
  level._id_4ABE = 0;
}

_id_0FD2(var_0, var_1) {
  _id_0FA9("encounter", var_0, var_1);
}

_id_0FEB(var_0, var_1) {
  _id_0FA9("location", var_0, var_1);
}

_id_0FA9(var_0, var_1, var_2) {
  if(!isDefined(self._id_E690[var_0])) {
    self._id_E690[var_0] = [];
  }

  var_3 = spawnStruct();
  var_3._id_6016 = var_1;
  var_3._id_AE4A = var_2;
  var_4 = self._id_E690[var_0].size;
  self._id_E690[var_0][var_4] = var_3;
}

_id_0FD3(var_0) {
  self._id_601C = var_0;
}

_id_7F6F() {
  self._id_5282 = [];
  self._id_1490 = [];
  var_0 = _id_7F6D("root");
  var_0 _id_0FD2(::_id_3B6B);
  var_0 _id_0FD2(::_id_3B6A, 60);
  var_0 _id_0FD2(::_id_3B69, 70);
  var_0 _id_0FD2(::_id_3B68, 1);
  var_0 _id_0FD2(::_id_3B67, 30);
  var_0 _id_0FEB(::_id_3B6C, 0);
  var_0 _id_0FEB(::_id_3B66);
  var_0 _id_0FD2(::_id_3B62, 2);
  var_0 _id_0FD2(::_id_3B63, 2);
  var_0 _id_0FEB(::_id_3B61, 7500);
  var_0 _id_0FD3(::_id_C90F);
  var_1 = _id_7F6D("root_ai", var_0);
  var_1 _id_0FD3(::_id_C914);
  var_2 = _id_7F6D("bank", var_1);
  var_2 _id_0FEB(::_id_3B60, 3000);
  var_2 _id_0FD3(::_id_21C2);
  var_3 = _id_7F6D("airport", var_1);
  var_3 _id_0FEB(::_id_3B60, 3000);
  var_3 _id_0FD3(::_id_13B7);
  var_4 = _id_7F6D("truck", var_1);
  var_4 _id_0FEB(::_id_3B60, 3000);
  var_4 _id_0FD3(::_id_F6BA);
  var_5 = _id_7F6D("crate_guard", var_1);
  var_5 _id_0FEB(::_id_3B60, 3000);
  var_5 _id_0FD3(::_id_3E8D);
  var_6 = _id_7F6D("jugg", var_1);
  var_6 _id_0FEB(::_id_3B60, 1000);
  var_6 _id_0FD2(::_id_3B65);
  var_7 = _id_7F6D("test", var_1);
  var_7 _id_0FD2(::_id_3B65);
  var_7 _id_0FD3(::_id_F0C1);
  var_8 = _id_7F6D("root_non_ai", var_0);
  var_8 _id_0FEB(::_id_3B60, 2000);
  var_8 _id_0FD3(::_id_C915);
  var_9 = _id_7F6D("dom", var_8);
  var_9 _id_0FD3(::_id_4D0F);
  var_10 = _id_7F6D("bomb_plant", var_8);
  var_10 _id_0FD3(::_id_2662);
  var_11 = _id_7F6D("extraction", var_8);
  var_11 _id_0FD3(::_id_5825);
  var_11 _id_0FD2(::_id_3B65);
  var_12 = _id_7F6D("destruction", var_8);
  var_12 _id_0FD3(::_id_4880);
}

_id_7F6D(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2._id_7E9E = self;
  var_2._id_AE5A = var_1;
  var_2._id_5282 = [];
  var_2._id_E690 = [];
  var_2._id_96DE = [];
  self._id_1490[var_0] = var_2;

  if(isDefined(var_1)) {
    var_1._id_5282[var_1._id_5282.size] = var_2;
  } else {
    self._id_5282[self._id_5282.size] = var_2;
  }

  return var_2;
}

_id_7FE0() {
  self._id_151A = [];
  self._id_0F4D = [];
  var_0 = scripts\engine\utility::getStructArray("ai_encounters", "targetname");

  foreach(var_2 in var_0) {
    _id_7FDF(var_2);
  }
}

_id_7FDF(var_0) {
  var_0.name = var_0._id_039B;
  var_1 = self._id_1490[var_0.name];
  var_1._id_96DE[var_1._id_96DE.size] = var_0;
  var_0._id_5274 = var_1;
  var_0._id_E747 = 0;
  var_2 = self._id_151A.size;
  self._id_151A[var_2] = var_0;
}

_id_5277() {
  for(;;) {
    self._id_FF61 = [];
    _id_FB4B(self._id_5282);

    if(self._id_FF61.size) {
      var_0 = scripts\engine\utility::random(self._id_FF61);
      _id_527A(var_0);
    }

    wait 0.05;
  }
}

_id_FB4B(var_0) {
  foreach(var_2 in var_0) {
    if(!var_2 _id_3442()) {
      continue;
    }
    _id_FB4B(var_2._id_5282);

    foreach(var_4 in var_2._id_96DE) {
      if(!var_4 _id_348C()) {
        continue;
      }
      self._id_FF61[self._id_FF61.size] = var_4;
    }
  }
}

_id_3442() {
  return _id_34C3(self, "encounter", 0);
}

_id_348C() {
  return _id_34C3(self._id_5274, "location", 1);
}

_id_34C3(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_0._id_AE5A)) {
    if(!_id_34C3(var_0._id_AE5A, var_1, var_2)) {
      return 0;
    }
  }

  if(!isDefined(var_0._id_E690[var_1])) {
    return 1;
  }

  for(var_3 = 0; var_3 < var_0._id_E690[var_1].size; var_3++) {
    var_4 = var_0._id_E690[var_1][var_3];

    if(isDefined(var_4._id_AE4A)) {
      var_5 = self[[var_4._id_6016]](var_4._id_AE4A);
    } else {
      var_5 = self[[var_4._id_6016]]();
    }

    if(!var_5) {
      return 0;
    }
  }

  return 1;
}

_id_527A(var_0) {
  var_0._id_E747 = 1;
  self._id_0F4D[self._id_0F4D.size] = var_0;
  var_0._id_E72D = gettime();
  _id_5276(var_0);
}

_id_5276(var_0) {
  var_0 _id_527B(var_0._id_5274);
}

_id_527B(var_0) {
  if(isDefined(var_0._id_AE5A)) {
    _id_527B(var_0._id_AE5A);
  }

  if(isDefined(var_0._id_601C)) {
    self[[var_0._id_601C]]();
  }
}

_id_5275(var_0, var_1) {
  if(var_0) {
    self._id_E747 = 2;
  } else {
    self._id_E747 = 3;
  }

  self._id_534E = gettime();
  self._id_5090 = self._id_534E - self._id_E72D;
  var_2 = self._id_5274._id_7E9E;
  var_2._id_0F4D = scripts\engine\utility::array_remove(var_2._id_0F4D, self);
  var_2._id_8FC5 = self;

  if(self._id_FEC0) {
    foreach(var_4 in self._id_121B) {
      if(isalive(var_4)) {
        var_4 suicide();
      }
    }
  }

  self notify("encounter_end", var_0, var_1);
}

_id_3B65(var_0) {
  return 0;
}

_id_3B6C(var_0) {
  if(self._id_E747 != var_0) {
    return 0;
  }

  return 1;
}

_id_3B61(var_0) {
  var_1 = var_0 * var_0;
  var_2 = _func_0204(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1) {
      return 1;
    } else {
      break;
    }
  }

  return 0;
}

_id_3B60(var_0) {
  var_1 = var_0 * var_0;
  var_2 = _func_0204(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1) {
      return 0;
    } else {
      break;
    }
  }

  return 1;
}

_id_3B66() {
  if(istrue(level._id_2A1D)) {
    return 1;
  }

  if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_CACA)) {
    return 0;
  }

  var_0 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_1 = scripts\mp\gametypes\br_circle::_id_6D03();
  var_2 = distance2dsquared(self.origin, var_0);

  if(var_2 > var_1 * var_1) {
    return 0;
  }

  return 1;
}

_id_3B62(var_0) {
  if(istrue(level._id_2A1D)) {
    return 1;
  }

  if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_CACA)) {
    return 0;
  }

  var_1 = _func_00BE("ui_br_circle_num");

  if(var_1 < var_0) {
    return 0;
  }

  return 1;
}

_id_3B63(var_0) {
  if(istrue(level._id_2A1D)) {
    return 1;
  }

  if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_372F)) {
    return 0;
  }

  var_1 = level._id_2A73._id_2A21.size;
  var_2 = var_1 - level._id_2A1B._id_372F;

  if(var_2 < var_0) {
    return 0;
  }

  return 1;
}

_id_3B69(var_0) {
  if(!isDefined(level._id_EF6A)) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in level._id_EF6A) {
    var_1 = var_1 + var_3["aliveCount"];
  }

  if(var_1 > var_0) {
    return 0;
  }

  return 1;
}

_id_3B68(var_0) {
  if(self._id_7E9E._id_0F4D.size >= var_0) {
    return 0;
  }

  return 1;
}

_id_3B6A(var_0) {
  var_1 = scripts\mp\utility\game::_id_6D1C();

  if(var_1 < var_0) {
    return 0;
  }

  return 1;
}

_id_3B67(var_0) {
  var_1 = self._id_7E9E;

  if(isDefined(var_1._id_8FC5)) {
    var_2 = (gettime() - var_1._id_8FC5._id_534E) / 1000;

    if(var_2 < var_0) {
      return 0;
    }
  }

  return 1;
}

_id_3B6B() {
  if(!isDefined(game["flags"]["prematch_done"])) {
    return 0;
  }

  if(_id_07D1::_id_60BE("prematch_done")) {
    return 1;
  }

  return 0;
}

_id_3B64() {
  if(getdvarint("#x35d7c7dcc702381ff", 0)) {
    return 0;
  }

  return 1;
}

_id_EACD(var_0) {
  self endon("encounter_end");

  for(;;) {
    self waittill("agent_killed");

    if(self._id_121C >= var_0) {
      _id_5275(1);
    }
  }
}

_id_58D6(var_0) {
  self endon("encounter_end");
  var_0 = int(var_0);
  var_1 = var_0;

  for(;;) {
    wait 1;

    if(self._id_B7B8.size > 0) {
      var_0 = var_1;
      continue;
    }

    var_0--;

    if(var_0 <= 0) {
      _id_5275(0);
    }
  }
}

_id_58D7() {
  self endon("encounter_end");

  for(;;) {
    wait 1;

    if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_433D)) {
      continue;
    }
    var_0 = scripts\mp\gametypes\br_circle::_id_69C5();
    var_1 = scripts\mp\gametypes\br_circle::_id_69C6();
    var_2 = distance2dsquared(self.origin, var_0);

    if(var_2 > var_1 * var_1) {
      if(self._id_B7B8.size > 0) {} else
        _id_5275(0);

      continue;
    }
  }
}

_id_EF05(var_0) {
  _id_EF06(var_0);
  var_1 = _id_E0AC(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0._id_708B)) {
      var_2 = scripts\engine\utility::random(var_0._id_708B);
      var_1 _meth_8324(var_2);
    }

    if(isDefined(var_0._id_7091)) {
      var_3 = scripts\engine\utility::random(var_0._id_7091);

      if(var_3._id_1F06) {
        var_1 _meth_8328(var_3);
      } else {
        var_1 _meth_8327(var_3);
      }
    }
  }

  return var_1;
}

_id_EF06(var_0) {
  var_0.team = scripts\mp\gametypes\br_ai_encounters_util::_id_6313();
  var_0._id_13F1 = [[self._id_6020]](var_0);
  var_1 = var_0 scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_039B)) {
      continue;
    }
    switch (var_3._id_039B) {
      case "goal_volume":
        _id_EF08(var_0, var_3, 0);
        break;
      case "goal_volume_auto":
        _id_EF08(var_0, var_3, 1);
        break;
      case "goal_node":
      case "goal":
        _id_EF07(var_0, var_3);
        break;
      default:
        break;
    }
  }
}

_id_EF07(var_0, var_1) {
  if(!isDefined(var_0._id_708B)) {
    var_0._id_708B = [];
  }

  var_0._id_708B[var_0._id_708B.size] = var_1;
}

_id_EF08(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_7091)) {
    var_0._id_7091 = [];
  }

  var_1._id_1F06 = var_2;
  var_0._id_7091[var_0._id_7091.size] = var_1;
}

_id_EF02(var_0) {
  var_1 = _id_07F9::_id_C57D(0);
  _id_07F9::_id_A867(var_1, "current", var_0.origin, "icon_waypoint_objective_general", "icon_regular");
  _func_0178(var_1, 1);
  _func_0172(var_1, 1);
  _func_0167(var_1, self._id_7C6D);
  thread _id_7C3F(var_1);
  self waittill("encounter_end");
  _id_07F9::_id_C799(var_1);
  _func_015C(var_1);
}

_id_EF03(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
  self waittill("encounter_end", var_1, var_2);

  if(!var_1) {
    return;
  }
  var_3 = _id_C813(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_2)) {
    var_4 = [];
    var_5 = [];

    foreach(var_9, var_7 in self._id_B7BB) {
      var_8 = self._id_7261[var_9];

      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8.team == var_2) {
        var_4[var_4.size] = var_8;
        continue;
      }

      var_5[var_5.size] = var_8;
    }

    thread _id_C807(var_3, "icon_waypoint_unlocked", var_4);
    thread _id_C807(var_3, "icon_waypoint_locked", var_5);
    _id_C80C(var_3, var_4, var_5);
  } else {
    var_10 = [];

    foreach(var_9, var_7 in self._id_B7BB) {
      var_8 = self._id_7261[var_9];

      if(!isDefined(var_8)) {
        continue;
      }
      var_10[var_10.size] = var_8;
    }

    thread _id_C807(var_3, "icon_waypoint_unlocked", var_10);
  }
}

_id_EF04(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
  var_1 = _id_C813(var_0);
  scripts\mp\gametypes\br_ai_encounters_util::_id_4AE3(var_1);
  var_2 = _func_02AF(var_1.origin, (30, 15, 10), var_1.angles);
  self waittill("encounter_end", var_3);
  _func_02B1(var_2);

  if(isDefined(var_1)) {
    if(var_3) {
      scripts\mp\gametypes\br_ai_encounters_util::_id_526A(var_1);
      _id_C807(var_1, "icon_waypoint_unlocked");
    } else
      var_1 _meth_86BE();
  }
}

_id_C813(var_0, var_1) {
  var_2 = var_0._id_CE18;

  if(!isDefined(var_2)) {
    var_2 = "brloot_killstreak_clusterstrike";
  }

  var_3 = undefined;

  switch (var_2) {
    case "brloot_killstreak_clusterstrike":
      var_3 = scripts\mp\gametypes\br_pickups::_id_E336(var_2, var_0.origin + (0, 0, 0.1), var_0.angles, 0, 1);
      break;
    default:
  }

  if(isDefined(var_3)) {
    thread _id_C80F(var_3);
    thread _id_C80B(var_3);
  }

  return var_3;
}

_id_C80C(var_0, var_1, var_2) {
  _id_C80E(var_0, var_1);
  var_3 = spawn("script_model", var_0.origin + (0, 0, 30));
  var_3 setModel("tag_origin");
  var_3 makeuseable();
  var_3 sethintstring("MP/DOOR_USE_LOCK");
  var_3 setuseholdduration("duration_long");
  var_3 setusefov(15);
  var_3 setcursorhint("HINT_BUTTON");

  foreach(var_5 in var_1) {
    var_3 disableplayeruse(var_5);
  }

  thread _id_C80B(var_3);
  thread _id_C80D(var_3, var_0);
}

_id_C80D(var_0, var_1) {
  self endon("reward_cleanup");
  var_0 waittill("trigger", var_2);
  var_3 = var_1._id_CF22;
  scripts\mp\gametypes\br_pickups::_id_989B(var_1, var_3, "visible", var_2);
}

_id_C80F(var_0) {
  self endon("reward_cleanup");

  while(isDefined(var_0)) {
    waitframe();
  }

  self notify("reward_cleanup");
}

_id_C80B(var_0) {
  self waittill("reward_cleanup");

  if(isDefined(var_0)) {
    if(var_0 _meth_86EE()) {
      var_0 _meth_86BE();
    } else {
      var_0 delete();
    }
  }
}

_id_C80E(var_0, var_1) {
  scripts\mp\gametypes\br_ai_encounters_util::_id_4AE3(var_0);

  foreach(var_3 in var_1) {
    var_0 _meth_86A7(var_3);
  }
}

_id_C807(var_0, var_1, var_2) {
  var_3 = _id_403E(var_0, var_1);

  if(var_3 < 0) {
    return;
  }
  if(isDefined(var_2)) {
    foreach(var_5 in var_2) {
      _func_0185(var_3, var_5);
    }
  }

  thread _id_C808(var_3);
}

_id_403E(var_0, var_1) {
  var_2 = _id_07F9::_id_C57D();

  if(var_2 >= 0) {
    _id_07F9::_id_A867(var_2, "current", var_0.origin + (0, 0, 50), var_1, "icon_regular");
    _func_0178(var_2, 1);
    _func_0172(var_2, !istrue(self._id_A5BE));
    _func_0167(var_2, "BR_AI_ENCOUNTERS/OBJ_LABEL_REWARD");
    _func_018C(var_2);
    _func_018B(var_2);
  }

  return var_2;
}

_id_C808(var_0) {
  self waittill("reward_cleanup");
  _id_07F9::_id_C799(var_0);
}

_id_7C3F(var_0) {
  self endon("encounter_end");
  _func_018C(var_0);

  for(;;) {
    _func_018B(var_0);

    foreach(var_4, var_2 in self._id_B7BB) {
      var_3 = self._id_7261[var_4];

      if(isDefined(var_3)) {
        _func_0185(var_0, var_3);
      }
    }

    self waittill("notify_list_changed");
  }
}

_id_E0AC(var_0) {
  var_1 = _id_07F7::_id_E329(var_0._id_13F1, var_0.team, var_0.origin, var_0.angles);

  if(isDefined(var_1)) {
    var_1._id_C0F3 = 0;
    var_1._id_C0F1 = 0;
    var_1._id_0267 = 0;
    var_1._id_0157 = 0;
    var_1.pers["cur_kill_streak"] = 0;
    var_1.pers["cur_death_streak"] = 0;
    var_1.pers["cur_kill_streak_for_nuke"] = 0;
    var_1._id_F33C = [];
    var_1._id_8D7E = [];
    var_1.guid = var_1 scripts\mp\utility\player::getuniqueid();
    var_1._id_039B = var_0._id_039B;
    var_1._id_CF46 = 0;
    var_1._id_1214 = 1;
    self._id_121B[self._id_121B.size] = var_1;
    thread _id_10A25(var_1);
  } else {}

  return var_1;
}

_id_10A25(var_0) {
  var_0 waittill("death");
  self._id_121B = scripts\engine\utility::array_remove(self._id_121B, var_0);
  self._id_121C++;
  self notify("agent_killed");
}

_id_EF09(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isagent(var_1)) {
      continue;
    }
    break;
  }

  var_2 = var_0 scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_4 in var_2) {
    _id_EF05(var_4);
  }
}

_id_C90F() {
  thread _id_C912();
  thread _id_C913();
  thread _id_C910();
}

_id_C911(var_0) {
  return var_0.name;
}

_id_C912() {
  self._id_7C6D = "BR_AI_ENCOUNTERS/OBJ_LABEL_GENERIC";
  waittillframeend;
  var_0 = scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(!isDefined(var_3)) {
      continue;
    }
    switch (var_3) {
      case "spawner":
        thread _id_EF05(var_2);
        break;
      case "spawn_trigger":
        thread _id_EF09(var_2);
        break;
      case "icon":
        thread _id_EF02(var_2);
        break;
      case "reward":
        thread _id_EF03(var_2);
        break;
      case "reward_prespawn":
        thread _id_EF04(var_2);
        break;
      default:
        break;
    }
  }
}

_id_C913() {
  self endon("encounter_end");
  self._id_A6B1 = 7500;
  self._id_5454 = 2000;
  self._id_B7BB = [];
  self._id_B7B8 = [];
  self._id_7261 = [];
  waittillframeend;
  var_0 = self._id_A6B1 * self._id_A6B1;
  var_1 = self._id_5454 * self._id_5454;
  var_2 = 20;

  for(;;) {
    var_3 = gettime();
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      var_8 = level.players[var_7];

      if(!isDefined(var_8)) {
        continue;
      }
      self._id_7261[var_8.guid] = var_8;

      if(!isalive(var_8)) {
        if(isDefined(self._id_B7BB[var_8.guid])) {
          var_5 = 1;
          self._id_B7BB[var_8.guid] = undefined;
        }

        if(isDefined(self._id_B7B8[var_8.guid])) {
          var_6 = 1;
          self._id_B7B8[var_8.guid] = undefined;
        }

        continue;
      }

      var_9 = distance2dsquared(var_8.origin, self.origin);

      if(var_9 <= var_0) {
        if(!isDefined(self._id_B7BB[var_8.guid])) {
          var_5 = 1;
        }

        self._id_B7BB[var_8.guid] = var_3;
      } else {
        var_10 = self._id_B7BB[var_8.guid];

        if(isDefined(var_10) && var_3 - var_10 > 2000) {
          var_5 = 1;
          self._id_B7BB[var_8.guid] = undefined;
        }
      }

      if(var_9 <= var_1) {
        if(!isDefined(self._id_B7B8[var_8.guid])) {
          var_6 = 1;
        }

        self._id_B7B8[var_8.guid] = var_3;
      } else {
        var_10 = self._id_B7B8[var_8.guid];

        if(isDefined(var_10) && var_3 - var_10 > 2000) {
          var_6 = 1;
          self._id_B7B8[var_8.guid] = undefined;
        }
      }

      var_4++;

      if(var_4 >= var_2) {
        wait 0.05;
        var_4 = 0;
      }
    }

    if(var_5) {
      self notify("notify_list_changed");
    }

    if(var_6) {
      self notify("engaged_list_changed");
    }

    wait 0.05;
  }
}

_id_C910() {
  self._id_58D8 = 90;
  waittillframeend;
  thread _id_58D6(self._id_58D8);
  thread _id_58D7();
}

_id_C914() {
  self._id_FEC0 = 1;
  self._id_6020 = ::_id_C911;
  self._id_121C = 0;
  self._id_121B = [];
}

_id_21C2() {
  self endon("encounter_end");
  self._id_6020 = ::_id_21C4;
  self._id_7C6D = "BR_AI_ENCOUNTERS/OBJ_LABEL_BANK";
  thread _id_1418();
  thread _id_1417();
  thread _id_FFD3();
  var_0 = getent("bank_vol_01", "targetname");
  var_1 = getent("bank_vol_01_upper", "targetname");
  level._id_10C61 = [];
  var_2 = scripts\engine\utility::getStructArray("enemy_wave_01", "targetname");

  foreach(var_4 in var_2) {
    var_5 = _id_EF05(var_4);

    if(var_5._id_039B == "wave01_upper") {
      var_5 _meth_8328(var_1);
      var_5._id_01FE = 256;
    } else if(var_5._id_039B == "wave01_lower")
      var_5 _meth_8328(var_0);

    level._id_10C61 = scripts\engine\utility::array_add(level._id_10C61, var_5);
  }

  var_7 = getent("wave_01_overrun_trig", "targetname");
  _id_10937(var_7, level._id_10C61, level._id_10C61.size - 3);
  level notify("spawn_wave2");
  var_8 = getent("bank_vol_02", "targetname");
  var_9 = [];
  var_10 = scripts\engine\utility::getStructArray("enemy_wave_02", "targetname");

  foreach(var_12 in var_10) {
    var_5 = _id_EF05(var_12);
    var_5 _meth_8328(var_8);
    var_9 = scripts\engine\utility::array_add(var_9, var_5);
  }

  foreach(var_15 in level._id_10C61) {
    if(isDefined(var_15) && isalive(var_15)) {
      var_15 _meth_8328(var_8);
      var_9 = scripts\engine\utility::array_add(var_9, var_15);
    }
  }

  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_9, var_9.size);
  wait 0.5;
  self notify("open_vault");
  var_17 = getent("bank_vol_03", "targetname");
  var_18 = [];
  var_19 = scripts\engine\utility::getstruct("enemy_wave_03_boss", "targetname");
  var_20 = _id_EF05(var_19);
  var_20 thread _id_8BDD();
  var_18 = scripts\engine\utility::array_add(var_18, var_20);
  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_18, var_18.size);
  _id_5275(1);
}

_id_FFD1() {
  self endon("encounter_end");
  self waittill("open_vault");
}

_id_FFD0(var_0) {
  if(istrue(var_0.init)) {
    var_0.angles = var_0._id_E5A7;
    return;
  }

  var_1 = getent("vault_door_clip", "targetname");
  var_1 linkto(var_0);
  var_0._id_E5A7 = var_0.angles;
  var_0.init = 1;
}

_id_FFD3() {
  var_0 = getent("vault_door", "targetname");
  _id_FFD0(var_0);
  _id_FFD1();
  var_0 thread _id_FFD2();
  var_0 _meth_82A1((0, 180, 0), 5);
}

_id_8BDD() {
  var_0 = _func_0204(level.players, self.origin);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isalive(var_2)) {
      self _meth_812E(var_2);
      self _meth_8323(var_2);
      break;
    }
  }
}

_id_1418() {
  var_0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var_2 in var_0) {
    var_2 playLoopSound("emt_alarm_bank_bell_lp");
  }
}

_id_1416() {
  var_0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var_2 in var_0) {
    var_2 stoploopsound("emt_alarm_bank_bell_lp");
  }
}

_id_FFD2() {
  var_0 = 4000000;

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(distancesquared(var_2.origin, self.origin) <= var_0) {
        var_2 playSound("cp_bank_vault_open");
      }
    }
  }
}

_id_10937(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 endon("done");
  var_4 childthread _id_0DC7(var_0);
  var_4 childthread _id_0DC6(var_1, var_2, var_3);
  var_4 waittill("done");
}

_id_0DC6(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_0, var_1, var_2);
  self notify("done");
}

_id_0DC7(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    break;
  }

  self notify("done");
}

_id_1417() {
  self waittill("encounter_end");
  _id_1416();
}

_id_21C4(var_0) {
  if(isDefined(var_0._id_039B)) {
    switch (var_0._id_039B) {
      case "jugg":
        return "actor_enemy_br_juggernaut";
      default:
        break;
    }
  }

  return "actor_enemy_br_base";
}

_id_13B7() {
  var_0 = getent("ai_encounter_crate", "targetname");
  var_0 movez(256, 0.05);
  wait 0.5;
  _func_02B0(var_0);
  var_1 = getent("kickoff_airport_encounter", "targetname");
  var_1 waittill("trigger", var_2);
  var_3 = "s4_smoke_usa_m18_mp";
  var_4 = magicgrenademanual(var_3, scripts\engine\utility::getstruct("airport_smoke_toss_pos", "targetname").origin, anglesToForward(scripts\engine\utility::getstruct("airport_smoke_toss_pos", "targetname").angles) * 400, 1);
  wait 0.1;
  var_5 = magicgrenademanual(var_3, scripts\engine\utility::getstruct("airport_smoke_toss_pos_02", "targetname").origin, anglesToForward(scripts\engine\utility::getstruct("airport_smoke_toss_pos_02", "targetname").angles) * 400, 1.3);
  var_6 = magicgrenademanual(var_3, scripts\engine\utility::getstruct("airport_smoke_toss_pos_03", "targetname").origin, anglesToForward(scripts\engine\utility::getstruct("airport_smoke_toss_pos_03", "targetname").angles) * 450, 2);
  var_7 = getent("airport_vol_01", "targetname");
  wait 2;
  var_8 = [];
  var_9 = scripts\engine\utility::getStructArray("airport_enemy_wave_01", "targetname");

  foreach(var_11 in var_9) {
    var_12 = _id_EF05(var_11);
    var_12 _meth_8328(var_7);
    var_12 thread _id_13B8();
    var_8 = scripts\engine\utility::array_add(var_8, var_12);
  }

  var_14 = getent("wave_01_overrun_trig", "targetname");
  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_8, var_8.size);
  _id_5275(1);
}

_id_13B8() {
  self._id_7D00 = 1;
  wait(randomfloatrange(1, 2));
  self._id_7D00 = 0;
  self._id_001D = 0.01;
}

_id_F6BA() {
  self endon("encounter_end");
  self._id_6020 = ::_id_F6BC;
  self._id_7C6D = "BR_AI_ENCOUNTERS/OBJ_LABEL_TRUCK";
  thread _id_58D6(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = [];
  var_4 = scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_6 in var_4) {
    var_7 = var_6._id_039B;

    if(!isDefined(var_7)) {
      continue;
    }
    switch (var_7) {
      case "start_trigger":
        var_0 = var_6;
        break;
      case "truck_enemy_wave":
        var_2[var_2.size] = var_6;
        break;
      case "roll_door":
        var_1 = var_6;
        thread _id_F6E3(var_1);
        break;
      case "jump_down_node":
        var_3[var_3.size] = var_6;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("trigger", var_9);

    if(isalive(var_9) && isPlayer(var_9)) {
      break;
    }
  }

  _func_02B1(var_1 getentitynumber());
  _id_F6E4(var_1);
  var_10 = [];

  foreach(var_12 in var_2) {
    var_13 = _id_EF05(var_12);
    var_10 = scripts\engine\utility::array_add(var_10, var_13);
  }

  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_10, var_10.size);
  _id_5275(1);
}

_id_F6E3(var_0) {
  self endon("encounter_end");

  if(!istrue(var_0.init)) {
    var_0._id_1788 = scripts\engine\utility::getstruct(var_0.target, "targetname");

    if(!isDefined(var_0._id_1788.angles)) {
      var_0._id_1788.angles = (0, 0, 0);
    }

    var_0._id_E621 = var_0.origin;
    var_0._id_E5A7 = var_0.angles;
    var_0.init = 1;
  } else {
    var_0.origin = var_0._id_E621;
    var_0.angles = var_0._id_E5A7;
  }
}

_id_F6E4(var_0) {
  var_0 rotatepitch(-90, 1);
  _id_F6E5(var_0);
  self notify("truck_roll_door_open");
}

_id_F6E5(var_0) {
  var_1 = 1000000;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(distancesquared(var_3.origin, var_0.origin) <= var_1) {
        var_3 playSound("cp_bank_gate_fall");
      }
    }
  }
}

_id_F6BC(var_0) {
  return "actor_enemy_br_base";
}

_id_3E8D() {
  self endon("encounter_end");
  self._id_6020 = ::_id_3E8E;
  self._id_7C6D = "BR_AI_ENCOUNTERS/OBJ_LABEL_CRATE_GUARD";
  thread _id_58D6(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_5 in var_3) {
    var_6 = var_5._id_039B;

    if(!isDefined(var_6)) {
      continue;
    }
    switch (var_6) {
      case "guard":
        var_2[var_2.size] = var_5;
        break;
      case "guard_boss":
        var_1 = var_5;
        break;
      case "start_trigger":
        var_0 = var_5;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("trigger", var_8);

    if(isalive(var_8) && isPlayer(var_8)) {
      break;
    }
  }

  var_9 = [];

  foreach(var_11 in var_2) {
    var_12 = _id_EF05(var_11);
    var_9[var_9.size] = var_12;
  }

  var_14 = _id_EF05(var_1);
  var_9[var_9.size] = var_14;
  childthread _id_3E8C(var_14, var_9);
  scripts\mp\gametypes\br_ai_encounters_util::_id_108BD(var_9, var_9.size);
  _id_5275(1);
}

_id_3E8C(var_0, var_1) {
  var_0._id_0229 = 1;
  var_2 = var_1;
  var_2[var_2.size] = var_0;
  scripts\engine\utility::_id_10889(var_2, "death", "damage", "enemy");

  if(isDefined(var_0)) {
    var_0._id_0229 = 0;
  }
}

_id_3E8E(var_0) {
  if(isDefined(var_0._id_039B) && var_0._id_039B == "guard_boss") {
    return "actor_enemy_br_boss";
  }

  return "actor_enemy_br_base";
}

_id_DE57() {
  _id_D758();
  self._id_4412 = "animscripted";
  self._id_43D2 = "smoking_death";
  thread _id_DE59("smoking_idle");
  thread _id_DE5C("smoking_react");
  thread _id_DE58("smoking_death");
}

_id_DE59(var_0) {
  self endon("death");
  self endon("damage");
  thread _id_12BC("smoking");

  for(;;) {
    _id_DE5B("smoking_idle_start");
    _id_0AED::_id_18C7(var_0);
    _id_DE5A("smoking_idle_end");
  }
}

_id_DE5B(var_0) {
  self endon("death");
  self endon("damage");
  _id_0AED::_id_18C7(var_0);
}

_id_DE5A(var_0) {
  self endon("death");
  self endon("damage");
  _id_0AED::_id_18C7(var_0);
}

_id_DE5C(var_0) {
  self endon("death");
  self waittill("damage");
  _id_12E7();
  self._id_4412 = undefined;
  self._id_43D2 = undefined;

  if(isDefined(self._id_7CBF)) {
    self._id_7CBF unlink();
    self._id_7CBF physicslaunchserver(self._id_7CBF.origin, (0, 0, -10));
    self._id_7CBF = undefined;
  }

  _id_0AED::_id_18C7(var_0);
  _id_C5BF(self);
}

_id_DE58(var_0) {
  self endon("damage");
  self waittill("death");
  _id_12E7();
}

_id_12BB(var_0) {
  switch (var_0) {
    case "attach":
      playFXOnTag(level._id_60A1["cigarette_unlit"], self, "tag_accessory_right");
      break;
    case "light":
      playFXOnTag(level._id_60A1["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level._id_60A1["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level._id_60A1["lighter_glow"], self gettagorigin("tag_accessory_right"));
      thread _id_12E6();
      break;
    case "detach":
      stopFXOnTag(level._id_60A1["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level._id_60A1["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level._id_60A1["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
      break;
  }
}

_id_12E6() {
  self endon("smoking_end");
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    playFX(level._id_60A1["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    var_0 = randomintrange(5, 8);
    wait(var_0);
  }
}

_id_12E7() {
  self notify("smoking_end");
  self endon("death");

  if(scripts\engine\utility::hastag(self.model, "tag_accessory_right")) {
    _func_012F(level._id_60A1["cigarette_lit"], self, "tag_accessory_right");
    _func_012F(level._id_60A1["cigarette_unlit"], self, "tag_accessory_right");
  }
}

_id_E58B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  _id_D758();
  self._id_4412 = "animscripted";
  self._id_43D2 = "stand_cellphone_death";
  thread _id_12BC("standing_cellphone");
  _id_E58C("stand_cellphone_intro");

  if(var_0 > 0) {
    _id_E58E("stand_cellphone_loop", var_0);
  }

  _id_E58C("stand_cellphone_exit");
}

_id_E58C(var_0) {
  self endon("death");
  self endon("damage");
  _id_0AED::_id_18C7(var_0);
}

_id_E58E(var_0, var_1) {
  self endon("death");
  self endon("damage");
  _id_0AED::_id_18C5(var_0, var_1);
}

_id_12BA(var_0) {
  self endon("death");
  self endon("damage");

  switch (var_0) {
    case "attach":
      self._id_7CBF = _id_06C6::_id_17EB("equipment_personal_smartphone_01", "tag_accessory_right");
      wait 2;
      break;
    case "detach":
      if(isDefined(self._id_7CBF)) {
        self._id_7CBF delete();
        self._id_7CBF = undefined;
      }

      break;
  }
}

_id_D758() {
  self._id_B85C = 1;
}

_id_C5BF(var_0) {
  var_0 _meth_800D("prone", "stand", "crouch");
  var_0 _id_0AED::_id_18C1();
  var_0 setlookatentity();
  var_0._id_760F = 1;
  var_0._id_0166 = 0;
  var_0._id_4412 = undefined;
  var_0._id_43D2 = undefined;
  var_0._id_0229 = 0;
  var_0._id_B85C = undefined;

  if(isDefined(self._id_1772)) {
    self._id_1772 delete();
  }
}

_id_12BC(var_0) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    self waittill("animscripted", var_1);

    if(!isDefined(var_1)) {
      var_1 = ["undefined"];
    }

    if(!_func_0107(var_1)) {
      var_1 = [var_1];
    }

    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(var_0 == "smoking") {
        _id_12BB(var_4);
        continue;
      }

      if(var_0 == "standing_cellphone") {
        _id_12BA(var_4);
      }
    }
  }
}

_id_F0C1() {}

_id_C915() {
  self._id_FEC0 = 0;
}

_id_4D0F() {
  self._id_A5BE = 1;
  self._id_5454 = 1500;
  _id_4D18();
  var_0 = undefined;
  var_1 = scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_3 in var_1) {
    var_4 = var_3._id_039B;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "trigger_radius":
        var_5 = 315;
        var_6 = 120;
        var_0 = spawn("trigger_radius", var_3.origin, 0, int(var_5), int(var_6));
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  level._id_D530 = ::_id_4D1C;
  var_8 = scripts\mp\gametypes\obj_dom::_id_D896(var_0);
  var_8._id_A5D5 = undefined;
  var_8._id_103BF = "_300";
  var_8._id_ABCB = ::_id_4D1A;
  var_8._id_ABD4 = ::_id_4D1B;
  var_8._id_AAC2 = ::_id_4D19;
  var_8 _id_07D6::_id_D8E0("any");
  var_8 scripts\mp\gametypes\obj_dom::_id_4D27();
  level._id_5C3B = getdvarint("#x3b898e34353227ee3", 30);
  var_8 _id_07D6::_id_D8D2(level._id_5C3B);
  var_8._id_527E = self;
  thread _id_527C(var_8);
  thread _id_7C3F(var_8._id_A908);
}

_id_527C(var_0) {
  var_0 endon("deleted");
  self waittill("encounter_end");

  foreach(var_2 in var_0._id_10430) {
    var_2 delete();
  }

  if(isDefined(var_0._id_5C3F)) {
    var_0._id_5C3F delete();
  }

  if(isDefined(var_0._id_03A9)) {
    var_0._id_03A9 delete();
  }

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
    var_0.trigger = undefined;
  }

  var_0 thread _id_60DA();
  var_0 notify("deleted");
}

_id_60DA() {
  wait 0.1;
  _id_07D6::_id_C300();
}

_id_4D18() {
  level._id_7C74 = "waypoint_captureneutral_br";
  level._id_7C42 = "waypoint_capture_br";
  level._id_7C4B = "waypoint_defend_br";
  level._id_7C50 = "waypoint_defending_br";
  level._id_7C48 = "waypoint_contested_br";
  level._id_7C87 = "waypoint_taking_br";
  level._id_7C6F = "waypoint_losing_br";
  _id_0CE6("icon_waypoint_dom_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _id_0CE6("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _id_0CE6("waypoint_capture_br", "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _id_0CE6("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _id_0CE6("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _id_0CE6("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _id_0CE6("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _id_0CE6("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _id_0CE6("waypoint_captureneutral_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _id_0CE6("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _id_0CE6("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _id_0CE6("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
}

_id_0CE6(var_0, var_1, var_2, var_3) {
  level._id_10CCD[var_0] = var_1;
  level._id_10CCC[var_0] = 0;
  level._id_10CD9[var_0] = var_2;
  level._id_10CD8[var_0] = "icon_waypoint_dom_a";
  level._id_10CD1[var_0] = var_3;
}

_id_4D1B(var_0, var_1, var_2, var_3) {
  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    self._id_497A = 1;
  }
}

_id_4D1A(var_0) {
  self._id_527E _id_5275(1, var_0.team);
}

_id_4D19(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
}

_id_4D1C(var_0, var_1, var_2) {
  switch (var_1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var_1 = "using";

      if(isDefined(var_2)) {
        var_1 = var_1 + var_2;
      }

      self._id_03A9 setscriptablepartstate(var_0, var_1);

      if(var_0 == "pulse") {
        self._id_03A9 setscriptablepartstate("flag", var_1);
      }

      return 1;
  }
}

_id_2662() {}

_id_5825() {
  iprintlnbold("EXTRACTION START");
  var_0 = scripts\mp\gametypes\br_ai_encounters_util::_id_67B6();

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(!isDefined(var_3)) {
      continue;
    }
    switch (var_3) {
      case "use_object":
        _id_5823(var_2);
        break;
      case "goal":
        _id_EF01(var_2);
        break;
      default:
        break;
    }
  }
}

_id_EF01(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
  var_1 = spawn("script_model", var_0.origin + (0, 0, 20));
  var_1 setModel("ctf_game_flag_east");
  self._id_01FA = var_1;
  var_1._id_5274 = self;
}

_id_5823(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 20));
  var_1 setModel("fullbody_usmc_ar");
  var_1 _meth_82CB("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_1 _meth_8642(1);
  var_1 makeuseable();
  var_1 setcursorhint("HINT_NOICON");
  var_1 setuseholdduration("duration_medium");
  var_1 sethintrequiresholding(1);
  var_1 sethintdisplayfov(120);
  var_1 setusefov(120);
  var_1 setuserange(80);
  var_1 sethintstring(&"MP_BR_USE_PLUNDER_CACHE");
  var_1 setasgametypeobjective();
  var_1 show();
  var_1._id_C0AD = 0;
  var_1 thread _id_5826();
  self._id_5619 = var_1;
  var_1._id_5274 = self;
}

_id_5826() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!self._id_C0AD) {
      var_0 _id_582D(self, var_0.team);
      continue;
    }

    thread _id_581D(var_0);
  }
}

_id_582D(var_0, var_1) {
  self endon("droppedBody");
  var_0 makeunusable();
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var_2.label = &"MP/BR_RESPAWN_BODY";
  self._id_79CE = var_2;
  var_0 _meth_82CB("sdr_cp_hostage_walk_hostage");
  var_0 linkto(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  scripts\mp\gametypes\br_respawn::_id_B79F(1);

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  _id_5824(var_0, self, var_2, var_1);
}

_id_5824(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    scripts\mp\gametypes\br_respawn::_id_B79F(0);
  }

  if(isDefined(var_2)) {
    var_2 destroy();
  }

  if(var_0 _meth_81CC()) {
    var_0 unlink();
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0 _meth_82CB("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_0 _meth_8642(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 makeuseable();

  if(var_0 _id_5821()) {
    var_0 _id_5820();
  }

  var_0 notify("droppedBody");
}

_id_5821(var_0) {
  if(distance2d(self.origin, self._id_5274._id_01FA.origin) < 100) {
    return 1;
  } else {
    return 0;
  }
}

_id_5820() {
  self makeuseable();
  self setcursorhint("HINT_NOICON");
  self setuseholdduration("duration_long");
  self sethintrequiresholding(1);
  self sethintstring(&"MP_BR_USE_PLUNDER_CACHE");
  self._id_C0AD = 1;
}

_id_581D(var_0) {
  self._id_5274 _id_5275(1);
  self._id_5274._id_01FA delete();
  self delete();
}

_id_4880() {
  var_0 = getscriptablearray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3._id_039B;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "destroy":
        var_1[var_1.size] = var_3;
        break;
      default:
        break;
    }
  }
}