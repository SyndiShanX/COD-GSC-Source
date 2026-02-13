/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_quest_util.gsc
**************************************************/

_id_807D() {
  if(!getdvarint("#x3b1e1f1d65661c8df", 1)) {
    return;
  }
  level._id_BEAF = spawnStruct();
  level._id_BEAF._id_BEB8 = [];
  level._id_BEAF._id_F109 = [];
  level._id_BEAF._id_EC87 = [];
  level._id_BEAF._id_EFA9 = [];
  level._id_BEAF._id_F10A = 0;
  level._id_BEAF._id_EC90 = [];
  level._id_BEAF._id_C811 = spawnStruct();
  level._id_BEAF._id_C811._id_3332 = [];
  level._id_BEAF._id_C811._id_7232 = [];
  level._id_BEAF._id_C811._id_CB87 = [];
  level._id_BEAF._id_C811._id_C816 = [];
  level._id_BEAF._id_C811._id_C817 = [];
  level._id_BEAF._id_F1E7 = [];
  level._id_BEAF._id_45B2 = [];
  level._id_BEAF._id_45B2[0] = ::_id_5A49;
  level._id_BEAF._id_45B2[1] = ::_id_5A48;
  level._id_BEAF._id_6886 = ::_id_68A3;
  _id_0A8E::_id_C285(::_id_AB63);
  scripts\mp\gametypes\br_assassination_quest::init();
  scripts\mp\gametypes\br_dom_quest::init();
  scripts\mp\gametypes\br_scavenger_quest::init();
  scripts\mp\gametypes\br_vip_quest::init();
  scripts\mp\gametypes\br_timedrun_quest::init();
  scripts\mp\gametypes\br_collection_quest::init();
  thread _id_82A7();
  thread _id_D859();
  game["dialog"]["mission_gen_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_misc_success"] = "contract_misc_success";
  game["dialog"]["mission_obj_change"] = "mission_mission_obj_change";
  game["dialog"]["mission_obj_moved"] = "mission_mission_obj_moved";
  game["dialog"]["mission_obj_next_ptarget"] = "mission_mission_obj_next_ptarget";
  game["dialog"]["mission_obj_next_nptarget"] = "mission_mission_obj_next_nptarget";
  game["dialog"]["mission_obj_warning_time"] = "mission_mission_obj_warning_time";
  game["dialog"]["mission_obj_warning_capture"] = "mission_mission_obj_warning_capture";
  game["dialog"]["mission_obj_circle_fail"] = "mission_mission_obj_circle_fail";
  game["dialog"]["mission_gen_fail"] = "mission_mission_gen_fail";
  game["dialog"]["mission_teammate_down"] = "mission_teammate_down";
  game["dialog"]["mission_enemy_down"] = "mission_enemy_down";
  level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");
  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  level._id_2BF0 = undefined;
}

_id_82A7() {
  level._id_BEAF._id_0F62 = [];
  var_3 = getdvarfloat("#x34c08cd0f4313c87c", 0.667);
  var_4 = [];

  foreach(var_2, var_1 in level._id_BEAF._id_EC87) {
    var_6 = _id_6B21(var_2);
    var_7 = _func_03C2(var_6);

    if(!var_1._id_523F) {
      continue;
    }
    var_8 = getdvarfloat("#x32d12eb6bacd11886", 1200.0);

    if(var_8 > 0) {
      var_9 = 0;

      foreach(var_11 in level._id_2A10._id_CF26) {
        var_12 = _func_03C3(var_6, undefined, var_11.origin, var_8);

        foreach(var_14 in var_12) {
          if(istrue(var_14._id_E699)) {
            continue;
          }
          var_14._id_E699 = 1;
          var_9++;
        }
      }

      for(var_17 = var_7.size - 1; var_17 >= 0 && var_9; var_17--) {
        if(istrue(var_7[var_17]._id_E699)) {
          var_7[var_17] = var_7[var_7.size - 1];
          var_7[var_7.size - 1] = undefined;
          var_9--;
        }
      }
    }

    if(istrue(level._id_98D1) && scripts\mp\gametypes\br::_id_98CF()) {
      var_18 = getdvarfloat("#x3ba37ae522a409641", 0.8);
      var_19 = int(min(var_7.size, var_7.size * (1.0 - var_18) + 0.5));

      for(var_17 = 0; var_17 < var_19; var_17++) {
        var_20 = randomintrange(0, var_7.size);
        var_7[var_20]._id_E699 = 1;
        var_7[var_20] = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    for(var_17 = var_7.size - 1; var_17 >= 0; var_17--) {
      var_21 = var_7[var_17];
      var_21 _id_EC88(var_2);

      if(!var_21.init) {
        var_7[var_17]._id_E699 = 1;
        var_7[var_17] = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    if(var_7.size) {
      var_22 = _id_6C95(var_2);
      _func_01EB("ui_br_objective_types", var_22, 1);
    }

    var_23 = var_7.size * var_3;
    var_24 = int(var_23);
    var_25 = var_23 - var_24;

    if(randomfloat(1.0) < var_25) {
      var_24++;
    }

    for(var_17 = 0; var_17 < var_24; var_17++) {
      var_20 = randomintrange(0, var_7.size);
      var_21 = var_7[var_20];
      var_7[var_20]._id_E699 = 1;
      var_4[var_4.size] = var_7[var_20];
      var_7[var_20] = var_7[var_7.size - 1];
      var_7[var_7.size - 1] = undefined;
    }
  }

  var_26 = getarraykeys(level._id_2F7C._id_A3CF);
  var_27 = [];
  var_28 = getdvarint("#x38119c8f3411c279e", 1);

  if(var_28 > 0) {
    foreach(var_30 in var_26) {
      var_27[var_30] = var_28;
    }
  }

  var_32 = 0;

  foreach(var_2, var_1 in level._id_BEAF._id_EC87) {
    var_7 = _func_03C2(_id_6B21(var_2));
    var_32 = var_32 + var_7.size;

    if(var_1._id_523F) {
      foreach(var_21 in var_7) {
        if(istrue(var_21._id_E699)) {
          var_21 _id_EC85();
          continue;
        }

        var_21 _id_EC8C();

        if(var_27.size > 0) {
          var_35 = scripts\mp\gametypes\br_callouts::_id_6B1D(var_21.origin);

          if(isDefined(var_27[var_35])) {
            var_27[var_35]--;

            if(!var_27[var_35]) {
              var_27[var_35] = undefined;
            }
          }
        }
      }

      continue;
    }

    foreach(var_21 in var_7) {
      var_21 _id_EC85();
    }
  }

  if(var_27.size) {
    var_4 = scripts\engine\utility::array_randomize(var_4);

    for(var_17 = 0; var_17 < var_4.size; var_17++) {
      var_21 = var_4[var_17];
      var_35 = scripts\mp\gametypes\br_callouts::_id_6B1D(var_21.origin);

      if(isDefined(var_27[var_35])) {
        var_21 _id_EC8C();
        var_27[var_35]--;

        if(!var_27[var_35]) {
          var_27[var_35] = undefined;

          if(!var_27.size) {
            break;
          }
        }
      }
    }
  }

  var_40 = level._id_BEAF._id_0F62.size;
  var_41 = var_4.size;
  scripts\mp\gametypes\br_analytics::_id_2AF5(var_32, var_40, var_41, var_3);

  if(scripts\mp\gametypes\br_gametypes::_id_8854("tabletReplace")) {
    thread _id_EC8A(var_4);
  } else {
    thread _id_46C2(var_4);
  }
}

_id_EC8A(var_0) {
  if(!isDefined(level._id_2A73)) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    level waittill("quest_started");

    if(isDefined(level._id_EC8B) && level._id_EC8B != -1) {
      var_1++;

      if(var_1 >= level._id_EC8B) {
        var_3 _id_EC8C();
        level._id_EC8B = level._id_EC8B + level._id_EC8B;
      }

      continue;
    }

    var_3 _id_EC8C();
  }
}

_id_46C2(var_0) {
  if(!isDefined(level._id_2A73)) {
    return;
  }
  var_1 = level._id_2A73._id_2A21.size - 1 - getdvarint("#x3c8cc7959a3a2337", 4);
  var_2 = getdvarfloat("#x3ea63f4fb29558019", 0.3);
  _id_07D1::_id_60C2("prematch_done");
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    var_5._id_372F = scripts\mp\gametypes\br_circle::_id_695A(var_5.origin);

    if(var_5._id_372F >= 0) {
      var_3[var_3.size] = var_5;
    }
  }

  var_0 = scripts\engine\utility::array_randomize(var_3);

  for(;;) {
    level waittill("br_circle_set");

    if(!level._id_2A1B._id_372F) {
      scripts\mp\gametypes\br_analytics::_id_2AE6(0, var_2, var_3.size, 0);
      continue;
    }

    var_3 = [];

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_5 = var_0[var_4];

      if(var_5._id_372F >= level._id_2A1B._id_372F) {
        var_3[var_3.size] = var_5;
      }
    }

    var_6 = int(_func_0037(var_3.size * var_2));
    var_7 = int(max(0, getdvarint("#x3d645acd0d7475926", 100) - level._id_BEAF._id_0F62.size));
    var_6 = int(min(var_6, var_7));

    for(var_4 = 0; var_4 < var_6; var_4++) {
      var_5 = var_3[var_4];
      var_5 _id_EC8C();
    }

    var_0 = [];

    for(var_4 = var_6; var_4 < var_3.size; var_4++) {
      var_0[var_0.size] = var_3[var_4];
    }

    scripts\mp\gametypes\br_analytics::_id_2AE6(level._id_2A1B._id_372F, var_2, var_3.size, var_6);

    if(level._id_2A1B._id_372F >= var_1) {
      break;
    }
  }
}

_id_4A7C() {
  foreach(var_6, var_1 in level._id_BEAF._id_EC87) {
    var_2 = _func_03C2(_id_6B21(var_6));

    if(var_1._id_523F) {
      foreach(var_4 in var_2) {
        var_4 _id_EC85();
      }
    }
  }
}

_id_EC85() {
  thread _id_0D91();
}

_id_0D91() {
  self endon("show");
  _id_07D1::_id_60C2("prematch_done");
  scripts\mp\gametypes\br_pickups::_id_9885(self);
}

_id_EC8C() {
  self notify("show");
  var_0 = self.type;
  self setscriptablepartstate(var_0, "visible");
  level._id_BEAF._id_0F62["" + self.index] = self;
  scripts\mp\gametypes\br_analytics::_id_2B0A(self);
}

_id_EC88(var_0) {
  if(isDefined(self.init)) {
    return;
  }
  self.init = 1;
  self._id_EC8D = var_0;
  var_1 = level._id_BEAF._id_BEB8[var_0]._id_6035["tabletInit"];

  if(isDefined(var_1)) {
    self.init = self[[var_1]]();

    if(!self.init) {
      scripts\mp\gametypes\br_analytics::_id_2AF6(self);
    }
  }
}

_id_AB83(var_0) {
  if(isDefined(level._id_BEAF._id_0F62["" + var_0.index])) {
    level._id_BEAF._id_0F62["" + var_0.index] = undefined;
  }
}

_id_6B21(var_0) {
  return "brloot_" + var_0 + "_tablet";
}

_id_C2C0(var_0, var_1) {
  scripts\mp\gametypes\br_analytics::_id_2AFF(self, var_1);
  level._id_BEAF._id_EFA9 = scripts\engine\utility::array_add(level._id_BEAF._id_EFA9, var_0);

  if(!isDefined(level._id_BEAF._id_9C8F)) {
    level._id_BEAF._id_9C8F = [];
  }

  level._id_BEAF._id_9C8F[var_0] = _id_6C97(var_0, 1);
  level notify("quest_started", var_0);
}

_id_C305(var_0) {
  if(isDefined(level._id_BEAF._id_9C8F)) {
    level._id_BEAF._id_9C8F[var_0] = undefined;
    _id_0A6B::_id_FD56(var_0);
  }

  level._id_BEAF._id_EFA9 = scripts\engine\utility::array_remove(level._id_BEAF._id_EFA9, var_0);
  var_1 = _id_6CA3(var_0);
  var_2 = [];

  if(isDefined(self._id_0372) && self._id_0372 == "success") {
    foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
      if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
        continue;
      }
      var_4._id_2BEE = scripts\mp\gametypes\br::_id_6516(var_4._id_2BEE) + 1;
      var_4 scripts\mp\gametypes\br_public::_id_FC1A("missionsCompleted", var_4._id_2BEE);
      var_4 scripts\mp\utility\stats::_id_7DAE("contracts", 1);

      if(!isDefined(var_4._id_2BEF)) {
        var_4._id_2BEF = [];
      }

      var_4._id_2BEF[self._id_BEAD] = ::scripts\mp\gametypes\br::_id_6516(var_4._id_2BEF[self._id_BEAD]) + 1;
    }

    var_2 = _id_6FDB(var_0, self._id_C810, self._id_C805, self._id_C812, self._id_3C5F);
  }

  if(isDefined(self._id_0372)) {
    var_6 = scripts\engine\utility::ter_op(self._id_0372 == "success", 1, 2);
    var_7 = self._id_332F;

    foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
      if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
        continue;
      }
      var_4 _id_07BC::_id_AA8E(self._id_332F, var_6, 1);
      var_4 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self._id_EF0A)) {
      var_10 = scripts\engine\utility::ter_op(self._id_0372 == "success", 2, 1);

      foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(self._id_EF0A, "players")) {
        if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
          continue;
        }
        var_4 _id_07BC::_id_AA8E(self._id_332F, var_10, 2);
      }
    }
  }

  var_13 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_14 = var_13.size;
  scripts\mp\gametypes\br_analytics::_id_2AFE(self, var_1, var_2, var_14);
  self notify("questEnded");

  if(isDefined(self._id_C812)) {
    self._id_C812 notify("questEnded");
  }
}

_id_E72C(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_2, "players")) {
    if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
      continue;
    }
    var_4 _id_07BC::_id_AA8F(var_0, var_1);
  }
}

_id_EDD4(var_0) {
  switch (var_0.type) {
    case "brloot_assassination_tablet":
      scripts\mp\gametypes\br_assassination_quest::_id_EDD3(var_0);
      break;
    case "brloot_collection_tablet":
      scripts\mp\gametypes\br_collection_quest::_id_EDD3(var_0);
      break;
    case "brloot_domination_tablet":
      scripts\mp\gametypes\br_dom_quest::_id_EDD3(var_0);
      break;
    case "brloot_scavenger_tablet":
      scripts\mp\gametypes\br_scavenger_quest::_id_EDD3(var_0);
      break;
    case "brloot_vip_tablet":
      scripts\mp\gametypes\br_vip_quest::_id_EDD3(var_0);
      break;
    case "brloot_timedrun_tablet":
      scripts\mp\gametypes\br_timedrun_quest::_id_EDD3(var_0);
      break;
  }

  scripts\mp\gametypes\br_plunder::_id_A003("brloot_mission_tablet", -1);
}

_id_433F(var_0, var_1, var_2) {
  if(!isDefined(level._id_BEAF)) {
    return;
  }
  foreach(var_4 in level._id_BEAF._id_0F62) {
    if(distance2dsquared(var_0, var_4.origin) > var_1 * var_1) {
      scripts\mp\gametypes\br_pickups::_id_9885(var_4);
      scripts\mp\gametypes\br_plunder::_id_A003("brloot_mission_tablet", -1);
    }
  }

  foreach(var_7 in level._id_BEAF._id_BEB8) {
    if(isDefined(var_7._id_6035["circleTick"])) {
      foreach(var_9 in var_7._id_8300) {
        var_9[[var_7._id_6035["circleTick"]]](var_0, var_2);
      }
    }
  }
}

_id_4039(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_BEAD = var_0;
  var_4._id_523F = 1;
  var_4._id_332F = var_0;
  var_4._id_7C8C = var_1;
  var_4._id_9F9A = "" + var_2;
  var_4._id_C812 = var_3;
  var_4 _id_0B43();
  return var_4;
}

_id_1118(var_0, var_1) {
  if(!istrue(level._id_BEAF._id_891D)) {
    _id_0C32();
    level._id_BEAF thread _id_0CA8();
  }

  if(!_id_0C40(var_0) && isDefined(level._id_BEAF._id_BEB8[var_0]._id_A799)) {
    if(_id_0B97(var_0, "initQuestVars")) {
      level._id_BEAF._id_BEB8[var_0] _id_0CC9(var_0);
    }

    _id_0CC1(var_0, var_1);
    _id_0CC2(var_0);
  } else
    _id_0CC1(var_0, var_1);
}

_id_C50F() {
  if(istrue(self._id_C488)) {
    return;
  }
  self._id_C488 = 1;
  var_0 = self._id_BEAD;
  _id_0CCE(var_0);

  if(isDefined(self._id_EABF)) {
    _id_9169();
  }

  if(_id_0CA7(var_0) <= 0) {
    if(_id_0B97(var_0, "clearQuestVars")) {
      level._id_BEAF._id_BEB8[var_0] _id_0CC4(var_0);
    }

    if(_id_0CA9() <= 0) {
      _id_0CBA();
    }
  }
}

_id_89D0(var_0) {
  return isDefined(var_0._id_EABE);
}

_id_0C32() {
  level._id_BEAF._id_891D = 1;
}

_id_0CBA() {
  level notify("end_quest_manager_thread");
  level._id_BEAF._id_891D = 0;
}

_id_0CA8() {
  level endon("game_ended");
  level endon("end_quest_manager_thread");

  for(;;) {
    wait 0.05;
    level._id_BEAF._id_F10A++;

    foreach(var_1 in level._id_BEAF._id_F109) {
      if(!level._id_BEAF._id_BEB8[var_1]._id_523F) {
        continue;
      }
      foreach(var_3 in level._id_BEAF._id_BEB8[var_1]._id_8300) {
        if(var_3._id_523F) {
          var_3 _id_0CCD(var_1);
        }
      }
    }
  }
}

_id_0CCD(var_0) {
  for(var_1 = 0; var_1 < level._id_BEAF._id_BEB8[var_0]._id_A799; var_1++) {
    if((level._id_BEAF._id_F10A - (self._id_F10B + self._id_5BDF)) % level._id_BEAF._id_BEB8[var_0]._id_F10D[var_1] == 0) {
      var_2 = "questThink" + var_1;
      [[level._id_BEAF._id_BEB8[var_0]._id_6035[var_2]]]();
    }
  }
}

_id_0B43() {
  if(!isDefined(level._id_BEAF._id_F10B)) {
    level._id_BEAF._id_F10B = 0;
  }

  self._id_F10B = level._id_BEAF._id_F10B;
  self._id_5BDF = level._id_BEAF._id_F10A;
  level._id_BEAF._id_F10B++;
}

_id_0CB4(var_0, var_1, var_2) {
  level._id_BEAF._id_BEB8[var_0]._id_6035[var_2] = var_1;
}

_id_0B97(var_0, var_1) {
  return isDefined(level._id_BEAF._id_BEB8[var_0]._id_6035[var_1]);
}

_id_C2A1(var_0, var_1) {
  var_2 = getdvarint(_func_0483("#x3cc6dc48dd0a717c6", var_0, "_quest"), var_1);

  if(scripts\mp\gametypes\br_gametypes::_id_8853("missions")) {
    var_2 = 0;
  }

  var_3 = spawnStruct();
  var_3._id_523F = var_2;
  level._id_BEAF._id_EC87[var_0] = var_3;

  if(!var_2) {
    return 0;
  }

  _id_0CB3(var_0);
  return 1;
}

_id_C2A4(var_0) {
  _id_0CB3(var_0);
}

_id_0CB3(var_0) {
  if(!isDefined(level._id_BEAF._id_BEB8[var_0])) {
    level._id_BEAF._id_BEB8[var_0] = spawnStruct();
    level._id_BEAF._id_BEB8[var_0]._id_8199 = 0;
    level._id_BEAF._id_BEB8[var_0]._id_7577 = 0;
    level._id_BEAF._id_BEB8[var_0]._id_6035 = [];
    level._id_BEAF._id_BEB8[var_0]._id_8300 = [];
    level._id_BEAF._id_BEB8[var_0]._id_523F = 1;
    _id_C2A2(var_0);
  }
}

_id_C2A2(var_0) {
  level._id_BEAF._id_EC90[var_0] = spawnStruct();
  level._id_BEAF._id_EC90[var_0].index = _id_6CA6(var_0);
}

_id_C264(var_0, var_1) {
  _id_0CB4(var_0, var_1, "initQuestVars");
  level._id_BEAF._id_BEB8[var_0]._id_7577 = 1;
}

_id_C2A5(var_0, var_1, var_2) {
  if(!isDefined(level._id_BEAF._id_BEB8[var_0]._id_A799)) {
    level._id_BEAF._id_BEB8[var_0]._id_A799 = 0;
  }

  var_3 = int(var_2 * 20);
  level._id_BEAF._id_BEB8[var_0]._id_F10D[level._id_BEAF._id_BEB8[var_0]._id_A799] = var_3;
  var_4 = "questThink" + level._id_BEAF._id_BEB8[var_0]._id_A799;
  _id_0CB4(var_0, var_1, var_4);
  level._id_BEAF._id_BEB8[var_0]._id_A799 = level._id_BEAF._id_BEB8[var_0]._id_A799 + 1;
}

_id_C2A3(var_0, var_1) {
  _id_0CB4(var_0, var_1, "circleTick");
}

_id_C2A7(var_0, var_1) {
  _id_0CB4(var_0, var_1, "removeInstance");
}

_id_C247(var_0, var_1) {
  _id_0CB4(var_0, var_1, "clearQuestVars");
}

_id_C29B(var_0, var_1, var_2) {
  if(!isDefined(level._id_BEAF._id_BEB8[var_0]._id_5A53)) {
    level._id_BEAF._id_BEB8[var_0]._id_5A53 = [];
  }

  if(isDefined(var_2)) {
    level._id_BEAF._id_BEB8[var_0]._id_5A53[var_2] = var_1;
  } else {
    var_3 = level._id_BEAF._id_BEB8[var_0]._id_5A53.size;
    level._id_BEAF._id_BEB8[var_0]._id_5A53[var_3] = var_1;
  }
}

_id_C28C(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onPlayerKilled");
}

_id_C288(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onPlayerDisconnect");
}

_id_C286(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onEnterGulag");
}

_id_C28E(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onRespawn");
}

_id_C290(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onTimerUpdate");
}

_id_C28F(var_0, var_1) {
  _id_0CB4(var_0, var_1, "onTimerExpired");
}

_id_C2BF(var_0, var_1) {
  _id_0CB4(var_0, var_1, "tabletInit");
}

_id_0BA0(var_0) {
  var_1 = [];
}

_id_AB70(var_0, var_1) {
  if(!isDefined(level._id_BEAF)) {
    return;
  }
  foreach(var_3 in level._id_BEAF._id_BEB8) {
    if(isDefined(var_3._id_6035["onPlayerKilled"])) {
      foreach(var_5 in var_3._id_8300) {
        var_5[[var_3._id_6035["onPlayerKilled"]]](var_0, var_1);
      }
    }
  }
}

onplayerconnect(var_0) {
  if(!isDefined(var_0.team)) {
    return;
  }
  _id_D68D(var_0.team, _id_6CA3(var_0.team));
}

_id_AB63(var_0) {
  if(!isDefined(level._id_BEAF)) {
    return;
  }
  foreach(var_2 in level._id_BEAF._id_BEB8) {
    if(isDefined(var_2._id_6035["onPlayerDisconnect"])) {
      foreach(var_4 in var_2._id_8300) {
        var_4[[var_2._id_6035["onPlayerDisconnect"]]](var_0);
      }
    }
  }
}

_id_AB67() {
  if(!isDefined(level._id_BEAF)) {
    return;
  }
  foreach(var_1 in level._id_BEAF._id_BEB8) {
    if(isDefined(var_1._id_6035["onEnterGulag"])) {
      foreach(var_3 in var_1._id_8300) {
        var_3[[var_1._id_6035["onEnterGulag"]]](self);
      }
    }
  }
}

_id_AB74() {
  if(!isDefined(level._id_BEAF)) {
    return;
  }
  foreach(var_1 in level._id_BEAF._id_BEB8) {
    if(isDefined(var_1._id_6035["onRespawn"])) {
      foreach(var_3 in var_1._id_8300) {
        var_3[[var_1._id_6035["onRespawn"]]](self);
      }
    }
  }
}

_id_0CC9(var_0) {
  [[level._id_BEAF._id_BEB8[var_0]._id_6035["initQuestVars"]]]();
}

_id_0CC2(var_0) {
  if(!_id_0C40(var_0)) {
    var_2 = level._id_BEAF._id_F109.size;
    level._id_BEAF._id_F109[var_2] = var_0;
    level._id_BEAF._id_BEB8[var_0]._id_523F = 1;
  } else {}
}

_id_0CC1(var_0, var_1) {
  level._id_BEAF._id_BEB8[var_0]._id_8300[var_1._id_7C8C] = var_1;
}

_id_0CCE(var_0) {
  self[[level._id_BEAF._id_BEB8[var_0]._id_6035["removeInstance"]]]();
  self notify("removed");
  level._id_BEAF._id_BEB8[var_0]._id_8300[self._id_7C8C] = undefined;
}

_id_0CC4(var_0) {
  [[level._id_BEAF._id_BEB8[var_0]._id_6035["clearQuestVars"]]]();
  level._id_BEAF._id_F109 = scripts\engine\utility::array_remove(level._id_BEAF._id_F109, var_0);
  level._id_BEAF._id_BEB8[var_0]._id_523F = 0;
}

_id_0C40(var_0) {
  if(scripts\engine\utility::array_contains(level._id_BEAF._id_F109, var_0)) {
    return 1;
  }

  return 0;
}

_id_0CA7(var_0) {
  if(isDefined(level._id_BEAF._id_BEB8[var_0]._id_8300)) {
    return level._id_BEAF._id_BEB8[var_0]._id_8300.size;
  }

  return 0;
}

_id_0CA9() {
  if(isDefined(level._id_BEAF._id_F109)) {
    return level._id_BEAF._id_F109.size;
  }

  return 0;
}

_id_400D(var_0, var_1, var_2) {
  var_3 = _id_4039(var_0, var_2, "invalid");
  var_3._id_EAC1 = var_1;
  _id_6C94(var_1)._id_96CB = var_0;
  var_3._id_EABE = [];
  return var_3;
}

_id_C24F(var_0, var_1) {
  _id_0CB4(var_0, var_1, "create_locale");
}

_id_C279(var_0, var_1) {
  _id_0CB4(var_0, var_1, "move_locale");
}

_id_C246(var_0, var_1) {
  _id_0CB4(var_0, var_1, "check_available");
}

_id_0BBD(var_0) {
  switch (var_0._id_CFB5) {
    case "GetEntitylessScriptableArray":
      return _func_03C0(var_0._id_8B34, "classname", var_0._id_CFAF, var_0._id_CFBA);
    case "getUnusedLootCacheArray":
      var_1 = _func_03F7(var_0._id_CFAF, var_0._id_CFBA, 0, 1);
      return var_1;
    case "questPointsArray":
      return _func_03F9(var_0._id_BEBE, var_0._id_CFAF, var_0._id_CFBA, 0, 1);
    case "getKiosks":
      var_2 = scripts\mp\gametypes\br_armory_kiosk::_id_68AD();
      var_3 = [];

      foreach(var_5 in level._id_2A10._id_CF26) {
        if(!istrue(var_5._id_4A88)) {
          var_3[var_3.size] = var_5;
        }
      }

      return var_3;
    default:
  }
}

_id_0BE4(var_0, var_1) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  if(!isDefined(var_1._id_9F41)) {
    var_1._id_9F41 = 0;
  }

  if(!isDefined(var_1._id_F4C2)) {
    var_1._id_F4C2 = 190;
  }

  var_2 = isDefined(var_1._id_CFB8) && isDefined(var_1._id_CFB9);

  if(istrue(var_1._id_CFB2)) {
    var_3 = scripts\mp\gametypes\br_circle::_id_6B5E(var_1._id_CFAF);
  } else {
    var_3 = 0;
  }

  var_4 = spawnStruct();
  var_5 = undefined;
  var_6 = var_1._id_CFBA;

  foreach(var_13, var_8 in var_0) {
    var_9 = distance2d(var_8.origin, var_1._id_CFAF);

    if(var_9 < var_1._id_CFBB) {
      continue;
    }
    if(!level._id_2A1D) {
      var_10 = scripts\mp\gametypes\br_circle::_id_6B5E(var_8.origin);

      if(var_10 < var_3) {
        continue;
      }
      if(var_1._id_F4C2 > 0) {
        var_11 = var_9 / var_1._id_F4C2;
        var_10 = var_10 - var_11;
      }

      if(var_10 < var_1._id_9F41) {
        continue;
      }
    }

    if(var_2) {
      if(var_9 < var_1._id_CFB8) {
        if(var_9 >= var_1._id_CFB9) {
          var_12 = 0;
        } else {
          var_12 = var_1._id_CFB9 - var_9;
        }
      } else
        var_12 = var_9 - var_1._id_CFB8;

      if(var_12 < var_6) {
        var_6 = var_12;
        var_5 = var_13;

        if(var_12 <= 0) {
          break;
        }
      }

      continue;
    }

    var_5 = var_13;
  }

  var_14 = undefined;

  if(isDefined(var_5)) {
    var_14 = var_0[var_5];
  } else {}

  return var_14;
}

_id_0CC6(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = self[[level._id_BEAF._id_BEB8[var_0]._id_6035["create_locale"]]](var_1);
  } else {
    var_2 = self[[level._id_BEAF._id_BEB8[var_0]._id_6035["create_locale"]]]();
  }

  return var_2;
}

_id_0CCA(var_0, var_1) {
  if(isDefined(var_1)) {
    self[[level._id_BEAF._id_BEB8[var_0]._id_6035["move_locale"]]](var_1);
  } else {
    self[[level._id_BEAF._id_BEB8[var_0]._id_6035["move_locale"]]]();
  }
}

_id_0CC3(var_0) {
  return self[[level._id_BEAF._id_BEB8[var_0]._id_6035["check_available"]]]();
}

_id_0BE0(var_0, var_1) {
  var_2 = _id_6C94(var_0);

  if(!isDefined(var_2) || !isDefined(var_2._id_8300)) {
    return undefined;
  }

  foreach(var_4 in var_2._id_8300) {
    var_5 = distance2d(var_1._id_CFAF, var_4._id_4140);

    if(var_5 > var_1._id_CFBA) {
      continue;
    }
    if(!var_4 _id_0CC3(var_0)) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

_id_5B04(var_0, var_1) {
  if(isDefined(var_1._id_C59A)) {
    var_2 = var_1._id_C59A;
  } else {
    var_3 = _id_0BBD(var_1);
    var_2 = _id_0BE4(var_3, var_1);
  }

  return var_2;
}

_id_C580(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2) || !var_2) {
    var_3 = _id_0BE0(var_0, var_1);
  }

  if(!isDefined(var_3)) {
    var_4 = _id_5B04(var_0, var_1);
    var_3 = _id_0CC6(var_0, var_4);
  }

  _id_EAC2(var_3);
  return var_3;
}

_id_EAC2(var_0) {
  self._id_EABF = var_0;
  var_0._id_EABE = scripts\engine\utility::array_add(var_0._id_EABE, self);
}

_id_A24A(var_0, var_1) {
  var_2 = _id_5B04(var_0, var_1);
  _id_0CCA(var_0, var_2);
}

_id_9169() {
  var_0 = _id_6C94(self._id_BEAD)._id_96CB;
  var_1 = self._id_EABF;
  var_1._id_EABE = scripts\engine\utility::array_remove(var_1._id_EABE, self);

  if(var_1._id_EABE.size <= 0) {
    var_1 _id_C50F();
  }
}

_id_6C94(var_0) {
  return level._id_BEAF._id_BEB8[var_0];
}

_id_6C96(var_0, var_1) {
  return level._id_BEAF._id_BEB8[var_0]._id_8300[var_1];
}

_id_3508(var_0, var_1) {
  if(isDefined(level._id_BEAF._id_BEB8[var_0]._id_8300[var_1])) {
    return 1;
  }

  return 0;
}

_id_0DB9(var_0) {
  if(isDefined(var_0)) {
    if(isint(var_0)) {
      return level._id_BEAF._id_BEB8[self._id_BEAD]._id_5A53[var_0];
    }

    if(_func_0107(var_0)) {
      return var_0;
    }
  } else if(isDefined(level._id_BEAF._id_BEB8[self._id_BEAD]._id_5A53))
    return level._id_BEAF._id_BEB8[self._id_BEAD]._id_5A53[0];
  else {
    return level._id_BEAF._id_45B2;
  }
}

_id_0DB8(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(![[var_3]](var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_89A6(var_0, var_1) {
  var_2 = _id_0DB9(var_1);
  return _id_0DB8(var_0, var_2);
}

_id_8A9A(var_0, var_1) {
  var_2 = _id_0DB9(var_1);

  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(_id_0DB8(var_4, var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_8827(var_0, var_1) {
  var_2 = _id_0DB9(var_1);

  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(!_id_0DB8(var_4, var_2)) {
      return 0;
    }
  }

  return 1;
}

_id_6E31(var_0, var_1) {
  var_2 = _id_0DB9(var_1);
  var_3 = [];

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(_id_0DB8(var_5, var_2)) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_6E30(var_0, var_1) {
  var_2 = _id_0DB9(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(_id_0DB8(var_5, var_2)) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_E03C(var_0, var_1) {
  var_2 = _id_0DB9(var_1);
  var_3 = [];
  var_3["valid"] = [];
  var_3["invalid"] = [];

  foreach(var_5 in var_0) {
    if(_id_0DB8(var_5, var_2)) {
      var_3["valid"][var_3["valid"].size] = var_5;
      continue;
    }

    var_3["invalid"][var_3["invalid"].size] = var_5;
  }

  return var_3;
}

_id_6DC7(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = _id_6E31(var_0, var_1);

  if(var_3.size <= 0) {
    return var_2;
  }

  foreach(var_5 in var_3) {
    var_2 = var_2 + var_5.origin;
  }

  var_2 = var_2 / var_3.size;
  return var_2;
}

_id_5A49(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  return 1;
}

_id_5A4A(var_0) {
  if(istrue(var_0.inlaststand)) {
    return 0;
  }

  return 1;
}

_id_5A48(var_0) {
  if(var_0 scripts\mp\gametypes\br_public::_id_8991()) {
    return 0;
  }

  return 1;
}

_id_5A46(var_0) {
  if(isDefined(var_0._id_7262)) {
    return 0;
  }

  return 1;
}

_id_ADCE(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = var_2;
  var_3 = var_3 << 5 | var_1;
  var_3 = var_3 << 5 | var_0;
  return var_3;
}

_id_4B82(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(var_4 scripts\mp\gametypes\br_public::_id_8990()) {
      continue;
    }
    if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
      continue;
    }
    if(isDefined(var_2)) {
      if(isDefined(var_2._id_56DD)) {
        if(scripts\engine\utility::array_contains(var_2._id_56DD, var_4)) {
          continue;
        }
      }
    }

    _id_4B7A(var_4, var_1, var_2);
  }
}

_id_4B7A(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_2._id_ADCB)) {
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2._id_ADCB);
  } else if(isDefined(var_2) && isDefined(var_2._id_84EE)) {
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2._id_84EE);
  } else {
    var_0 thread scripts\mp\hud_message::showsplash(var_1);
  }
}

_id_4B7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 * var_2;
  var_6 = [];

  foreach(var_8 in level.players) {
    var_9 = distancesquared(var_1, var_8.origin);

    if(var_9 > var_5) {
      continue;
    }
    if(isDefined(var_4._id_56DE) && scripts\engine\utility::array_contains(var_4._id_56DE, var_8.team)) {
      continue;
    }
    if(isDefined(var_4._id_56DD) && scripts\engine\utility::array_contains(var_4._id_56DD, var_8)) {
      continue;
    }
    if(!_id_89A6(var_8, var_3)) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  if(var_6.size > 0) {
    foreach(var_8 in var_6) {
      _id_4B7A(var_8, var_0, var_4);
    }
  }
}

_id_4B80(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = 0;
  var_4 = var_2 << 12 | var_3 << 4 | var_1;
  self setclientomnvar("ui_br_expanded_obit_message", var_4);
}

_id_4B81(var_0, var_1, var_2, var_3) {
  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    var_5 _id_4B80(var_1, var_2, var_3);
  }
}

_id_6FCD(var_0, var_1) {
  var_0 thread _id_0A9F::_id_7003(var_1);
}

_id_7000(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    var_3 thread _id_0A9F::_id_7003(var_1);
  }
}

_id_2F5D(var_0, var_1) {
  var_0 thread scripts\mp\gametypes\br_rewards::_id_E29B(var_1);
  level thread scripts\mp\gametypes\br_rewards::_id_9A19();
}

_id_6FFF(var_0, var_1) {
  var_2 = getdvarfloat("#x3e91a77ae43c75ed7", 0.4);
  var_3 = 0;

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(isbot(var_5) && scripts\mp\gametypes\br_public::_id_8AB8()) {
      continue;
    }
    var_6 = var_1;

    if(!scripts\mp\utility\player::isreallyalive(var_5)) {
      var_6 = int(var_1 * var_2);
    }

    var_5 scripts\mp\gametypes\br_plunder::_id_B756(var_6);
    level._id_2A9B._id_B92E = level._id_2A9B._id_B92E + var_6;
  }
}

_id_6FFE(var_0, var_1) {
  var_2 = int(var_1 / var_0.size);

  foreach(var_4 in var_0) {
    if(isbot(var_4) && scripts\mp\gametypes\br_public::_id_8AB8()) {
      continue;
    }
    var_4 scripts\mp\gametypes\br_plunder::_id_B756(var_2);
    level._id_2A9B._id_B92E = level._id_2A9B._id_B92E + var_2;
    scripts\mp\gametypes\br_analytics::_id_F3F7(var_4, "mission", var_2);
  }
}

_id_5051(var_0, var_1, var_2, var_3) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_4 = 0;
  var_5 = 1;
  var_6 = 2;
  var_7[0] = ["brloot_plunder_cash_uncommon_3", level._id_2A9B._id_BE9B, getdvarfloat("#x378407e7fb33aa466", 0.2)];
  var_7[1] = ["brloot_plunder_cash_uncommon_2", level._id_2A9B._id_BE9D, getdvarfloat("#x3da21f852e4ee2f07", 0.3)];
  var_7[2] = ["brloot_plunder_cash_uncommon_1", level._id_2A9B._id_BE9A, getdvarfloat("#x35a7a44710b8fe0ee", 0.5)];
  var_8 = 0;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_8 = var_8 + var_10[var_6];
  }

  var_11 = 0;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_10[var_6] = var_10[var_6] / var_8;
    var_11 = var_11 + var_10[var_5] * var_10[var_6];
  }

  var_12 = var_0 / var_11;
  var_13 = var_0;
  var_14 = [];

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_14[var_9] = int(var_12 * var_10[var_6]);
    var_13 = var_13 - var_14[var_9] * var_10[var_5];
  }

  if(var_13 > 0) {
    for(var_9 = 0; var_9 < var_7.size; var_9++) {
      var_10 = var_7[var_9];
      var_15 = int(var_13 / var_10[var_5]);
      var_14[var_9] = var_14[var_9] + var_15;
      var_13 = var_13 - var_15 * var_10[var_5];
    }
  }

  var_16 = [];

  for(var_9 = 0; var_9 < var_14.size; var_9++) {
    for(var_17 = 0; var_17 < var_14[var_9]; var_17++) {
      var_16[var_16.size] = var_9;
    }
  }

  var_16 = scripts\engine\utility::array_randomize(var_16);

  for(var_9 = 0; var_9 < var_16.size; var_9++) {
    [var_19, var_20, var_21] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_9, var_1, var_2, var_3);
    scripts\mp\gametypes\br_pickups::_id_E336(var_7[var_16[var_9]][var_4], var_19, var_20, var_7[var_16[var_9]][var_5], 1, var_21);
  }

  level._id_2A9B._id_B92E = level._id_2A9B._id_B92E + var_0;
  level thread scripts\mp\gametypes\br_plunder::_id_5053(var_1, var_16.size);
}

_id_6C95(var_0) {
  return level._id_BEAF._id_EC90[var_0].index;
}

_id_6CA6(var_0) {
  var_1 = int(_func_0222("mp/brmissions.csv", 1, var_0, 0));
  return var_1;
}

_id_F921(var_0) {
  var_1 = _id_6C95(var_0);
  _id_D68B(var_1);
}

_id_F922(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_1, "players")) {
    var_3 _id_F921(var_0);
  }
}

_id_F91E() {
  _id_D68B(0);
}

_id_F91F(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    var_2 _id_F91E();
  }
}

_id_F920(var_0) {
  self setclientomnvar("ui_br_objective_param", var_0);
}

_id_4038(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self._id_9AAD = _func_03EF(var_3[0], var_3[1], var_3[2]);
    self._id_3730 = var_3;
  } else {
    self._id_9AAD = _func_03EF(0, 0, 0);
    self._id_3730 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self._id_9AAD _meth_872C(var_0);
  self._id_9AAD _meth_872E(var_1);
  self._id_9AAD _meth_872D(var_2);
  self._id_9AAD hide();
}

_id_A249(var_0) {
  self._id_9AAD.origin = var_0;
  self._id_3730 = var_0;
}

_id_DCDA(var_0) {
  self._id_9AAD showtoplayer(var_0);
}

_id_7913(var_0) {
  self._id_9AAD hidefromplayer(var_0);
}

_id_4788() {
  self._id_9AAD delete();
}

_id_D5EE(var_0) {
  self._id_9AAD.origin = (self._id_9AAD.origin[0], self._id_9AAD.origin[1], var_0);
}

_id_403A(var_0, var_1, var_2) {
  self._id_A8DA = _id_07F9::_id_C57D(1);

  if(self._id_A8DA != -1) {
    _id_07F9::_id_A867(self._id_A8DA, var_1, (0, 0, 0), var_0);
    _id_07F9::_id_FB98(self._id_A8DA, 1);
    _func_018C(self._id_A8DA);
    _id_07F9::_id_A8B1(self._id_A8DA, 1);

    if(isDefined(var_2)) {
      _id_A24B(var_2);
    }
  } else {}
}

_id_A24B(var_0) {
  _id_07F9::_id_FB97(self._id_A8DA, var_0);
}

_id_DCDC(var_0) {
  _func_0185(self._id_A8DA, var_0);
}

_id_DCDB(var_0) {
  _func_0188(var_0);
}

_id_7914(var_0) {
  _func_0189(self._id_A8DA, var_0);
}

_id_34FF() {
  return isDefined(self._id_A8DA);
}

_id_4789() {
  _id_07F9::_id_A89F(self._id_A8DA);
  _id_07F9::_id_C799(self._id_A8DA);
}

_id_FF21(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 0, 0);
  var_3 = scripts\engine\trace::ray_trace(var_0 + (0, 0, 4000), var_0, undefined, var_2, undefined, 1)["position"];
  var_4 = spawn("script_model", var_3);
  var_4.angles = vectortoangles((0, 0, 1));
  var_4 setModel("equip_flare_br");
  wait 0.5;
  var_4 setscriptablepartstate("launch", "start", 0);
  var_5 = "start";

  if(var_1 == "revive") {
    var_5 = "start_revive";
  }

  var_4 setscriptablepartstate("travel", var_5, 0);
  var_4 thread _id_0DB5(var_1);
}

_id_0DB5(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = 3.125;
  self moveto(self.origin + (0, 0, 2500), var_1);
  wait(var_1);
  _id_0DB3(var_0);
}

_id_0DB3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "<undefined>";
  }

  self setscriptablepartstate("travel", "off", 0);

  if(!_id_0DB4(var_0)) {
    return;
  }
  var_1 = "start_" + var_0;
  self setscriptablepartstate("explode", var_1, 0);
  thread _id_D903();
}

_id_0DB4(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "revive":
      case "dom":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_D903() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);
  wait 12;
  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

_id_BEB4(var_0) {
  var_1 = 0;

  if(var_0._id_03EA & 4) {
    var_1 = 256;
  } else if(var_0._id_03EA & 2) {
    var_1 = 128;
  } else if(var_0._id_03EA & 1) {
    var_1 = 168;
  }

  return var_1;
}

_id_BEBA(var_0, var_1) {
  var_2 = _id_6C94(var_0);
  var_2._id_FEAB = getdvarint(_func_0483("#x3cc6dc48dd0a717c6", var_0, "_enableQuestTime"), var_1);
}

_id_BEBB(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = var_0 + var_1;
  var_3 = _id_6C94(self._id_332F);

  if(!var_3._id_FEAB) {
    return;
  }
  self._id_9F9F = gettime() + var_2 * 1000;
  _id_BEBC();
}

_id_BEB9(var_0) {
  var_1 = _id_6C94(self._id_332F);

  if(!var_1._id_FEAB) {
    return;
  }
  self._id_9F9F = self._id_9F9F + var_0 * 1000;
  _id_BEBC();
}

_id_BEBC() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self._id_7C8C, "players")) {
    var_1 setclientomnvar("ui_br_objective_countdown_timer", self._id_9F9F);
  }

  var_3 = _id_6C94(self._id_332F);
  var_4 = var_3._id_6035["onTimerUpdate"];

  if(isDefined(var_4)) {
    [[var_4]]();
  }

  thread _id_0CAA();
}

_id_0CAA() {
  self notify("updateQuestTimer");
  self endon("game_ended");
  self endon("updateQuestTimer");
  self endon("questEnded");
  var_0 = (self._id_9F9F - gettime()) / 1000;
  wait(var_0);
  var_1 = _id_6C94(self._id_332F);
  var_2 = var_1._id_6035["onTimerExpired"];

  if(isDefined(var_2)) {
    [[var_2]]();
  }

  self._id_0372 = "timeout";
  thread _id_C50F();
}

_id_C24A(var_0) {
  if(!isDefined(self._id_3C5F)) {
    self._id_3C5F = [];
  }

  if(!scripts\engine\utility::array_contains(self._id_3C5F, var_0)) {
    self._id_3C5F[self._id_3C5F.size] = var_0;
  }
}

_id_6FDB(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  }

  foreach(var_6 in var_4) {
    if(!isDefined(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_9F9B)) {
      var_6._id_9F9B = 1;
    } else {
      var_6._id_9F9B++;
    }

    var_6 scripts\mp\gametypes\br_gametype_dmz::_id_ADCC();
  }

  return _id_6FDA(self._id_BEAD, self._id_C80A, self._id_02D0, var_0, var_1, var_2, var_3, var_4);
}

_id_6FDA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_6C9C(var_0, var_1, var_2);
  return _id_6FD8(var_8, var_3, var_4, var_5, var_6, var_7);
}

_id_6FD8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = _id_6C9E(var_0);

  foreach(var_13, var_9 in var_7) {
    [var_11, var_12] = _id_6FD9(var_13, var_9, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_6[var_11])) {
      if(_func_0121(var_6[var_11])) {
        var_6[var_11] = var_6[var_11] + "," + var_12;
      } else {
        var_6[var_11] = var_6[var_11] + var_12;
      }

      continue;
    }

    var_6[var_11] = var_12;
  }

  return var_6;
}

_id_6FD9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_6CA3(var_2);
  var_8 = _id_6CA1(var_0);
  var_9 = _id_6CA2(var_0);

  if(!_func_0121(var_9)) {
    var_10 = _id_6CA5(var_1, var_7);

    if(var_10 != 1.0) {
      var_9 = var_9 * var_10;
      var_9 = _id_3315(var_8, var_9);
    }
  }

  var_9 = _id_6FD7(var_8, var_9, var_2, var_3, var_4, var_5, var_6);
  return [var_8, var_9];
}

_id_6FD7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  switch (var_0) {
    case "plunder":
      if(istrue(level._id_2A9C)) {
        if(getDvar("#x3f59526763711edc4", "") != "dmz") {
          _id_6FFF(var_2, var_1);
        } else if(var_6.size > 0) {
          _id_6FFE(var_6, var_1);
        } else {
          var_1 = 0;
        }
      } else
        var_1 = 0;

      break;
    case "xp":
      foreach(var_8 in scripts\mp\utility\teams::_id_6DCA(var_2, "players")) {
        var_8 thread _id_07CE::_id_8D83("br_missionComplete", 0);
        var_8 scripts\mp\rank::giverankxp("br_missionComplete", var_1);
        var_8._id_2A2C = scripts\mp\gametypes\br::_id_6516(var_8._id_2A2C) + var_1;
      }

      break;
    case "weapon_xp":
      foreach(var_8 in scripts\mp\utility\teams::_id_6DCA(var_2, "players")) {
        var_11 = var_8._id_9021;
        var_8 scripts\mp\gametypes\br::_id_6F88("", var_1, var_11, 0, 0);
      }

      break;
    case "loot_table":
      if(getDvar("#x3f59526763711edc4", "") != "dmz") {
        var_13 = _func_0408(var_5, var_1);
        _id_BEB6(var_13, var_3, var_4, 0);
      }

      break;
    case "loot_cache":
      var_13 = _func_0408(var_5, var_1);
      _id_BEB6(var_13, var_3, var_4, 1);
      break;
    case "loot_items":
      var_13 = strtok(var_1, " ");
      _id_BEB6(var_13, var_3, var_4, 0);
      break;
    case "drop_bag":
      var_14 = scripts\mp\utility\teams::_id_6DCA(var_2, "players")[0];
      _id_2F5D(var_14, var_3);
      break;
    case "circle_peek":
      _id_BEB5(var_2);
      break;
    case "reward_tier":
      thread _id_111A(var_2, var_1);
      break;
    case "none":
      break;
    default:
      break;
  }

  return var_1;
}

_id_D859() {
  if(istrue(level._id_2A1D)) {
    return;
  }
  level._id_3732 = [];
  level._id_EFB2 = [];

  for(var_0 = 1; var_0 < level._id_2A73._id_2A25.size; var_0++) {
    var_1 = level._id_2A73._id_2A25[var_0];
    var_2 = level._id_2A73._id_2A1F[var_0];
    level._id_3732[var_0] = _func_03EF(var_2[0], var_2[1], var_1);
    level._id_3732[var_0] _meth_872C(4);
    level._id_3732[var_0] _meth_872D(1);
    level._id_3732[var_0] hide();
  }

  level thread _id_3731();
}

_id_3731() {
  self endon("game_ended");
  level endon("CirclePeekCleanup");

  for(;;) {
    level waittill("br_circle_set");
    level._id_3732[level._id_2A1B._id_372F + 1] delete();

    foreach(var_1 in getarraykeys(level._id_EFB2)) {
      level._id_EFB2[var_1]--;

      if(level._id_EFB2[var_1] < 0) {
        level._id_EFB2[var_1] = 0;
      }
    }
  }
}

_id_BEB5(var_0) {
  if(istrue(level._id_2A1D)) {
    return;
  }
  if(!isDefined(level._id_EFB2[var_0])) {
    level._id_EFB2[var_0] = 0;
  }

  level._id_EFB2[var_0]++;
  var_1 = level._id_EFB2[var_0] + level._id_2A1B._id_372F + 1;

  if(!isDefined(level._id_3732[var_1])) {
    foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
      var_3 _id_0A99::_id_D5EB("circle_peek_limit", undefined, 5);
    }

    return;
  }

  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    level._id_3732[var_1] showtoplayer(var_3);
  }
}

_id_6CA8(var_0) {
  var_1 = level._id_BEAF._id_C811._id_3332[var_0];

  if(!isDefined(var_1)) {
    var_1 = _func_0222("mp/brmissions.csv", 1, var_0, 7);
    level._id_BEAF._id_C811._id_3332[var_0] = var_1;
  }

  return var_1;
}

_id_6C9E(var_0) {
  var_1 = _id_6CA0();
  var_2 = level._id_BEAF._id_C811._id_7232[var_0];

  if(!isDefined(var_2)) {
    var_2 = [];
    var_3 = 2;
    var_4 = 3;

    for(;;) {
      var_5 = _func_0222(var_1, 0, var_0, var_3);

      if(var_5 == "") {
        break;
      }

      var_6 = _func_0222(var_1, 0, var_0, var_4);
      var_2[var_5] = var_6;
      var_3 = var_3 + 2;
      var_4 = var_4 + 2;
    }

    if(isDefined(level._id_2BF0)) {
      var_2 = [[level._id_2BF0]](var_2);
    }

    level._id_BEAF._id_C811._id_7232[var_0] = var_2;
  }

  return var_2;
}

_id_6CA1(var_0) {
  var_1 = "mp/brmission_rewards.csv";

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    var_1 = "mp/brmission_rewards_dmz.csv";
  }

  var_2 = level._id_BEAF._id_C811._id_C816[var_0];

  if(!isDefined(var_2)) {
    var_2 = _func_0222(var_1, 0, var_0, 1);
    level._id_BEAF._id_C811._id_C816[var_0] = var_2;
  }

  return var_2;
}

_id_6CA2(var_0) {
  var_1 = "mp/brmission_rewards.csv";

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    var_1 = "mp/brmission_rewards_dmz.csv";
  }

  var_2 = level._id_BEAF._id_C811._id_C817[var_0];

  if(!isDefined(var_2)) {
    var_3 = _id_6C9B(var_0);

    if(isDefined(var_3)) {
      var_2 = var_3;
    } else {
      var_2 = _func_0222(var_1, 0, var_0, 2);
    }

    var_4 = _id_6CA1(var_0);
    var_2 = _id_3315(var_4, var_2);
    level._id_BEAF._id_C811._id_C817[var_0] = var_2;
  }

  if(istrue(level._id_25BB)) {
    var_2 = int(var_2 * level._id_AD72);
  }

  return var_2;
}

_id_6C9B(var_0) {
  var_1 = getdvarint(_func_0483("#x37360c0c8f934a58f", var_0), -1);

  if(var_1 > -1) {
    return var_1;
  }

  return undefined;
}

_id_6C9F(var_0) {
  var_1 = level._id_BEAF._id_C811._id_CB87[var_0];

  if(!isDefined(var_1)) {
    var_1 = [];
    var_2 = 1;
    var_3 = 2;

    for(;;) {
      var_4 = _func_0222("mp/brmission_reward_scalers.csv", 0, var_0, var_2);

      if(var_4 == "") {
        break;
      }

      var_4 = int(var_4);
      var_5 = float(_func_0222("mp/brmission_reward_scalers.csv", 0, var_0, var_3));
      var_1[var_4] = var_5;
      var_2 = var_2 + 2;
      var_3 = var_3 + 2;
    }

    level._id_BEAF._id_C811._id_CB87[var_0] = var_1;
  }

  return var_1;
}

_id_6C99(var_0) {
  return _id_6C98(self._id_BEAD, var_0, self._id_02D0, self._id_C80A);
}

_id_6CAD(var_0) {
  return _id_6CAC(self._id_BEAD, var_0, self._id_02D0, self._id_C80A);
}

_id_6CAB(var_0) {
  return _id_6CAA(self._id_BEAD, var_0, self._id_02D0, self._id_C80A);
}

_id_6C98(var_0, var_1, var_2, var_3) {
  if(!level._id_2A9C) {
    return 0;
  }

  return _id_6CA4(var_0, var_1, "plunder", var_2, var_3);
}

_id_6CAC(var_0, var_1, var_2, var_3) {
  return _id_6CA4(var_0, var_1, "xp", var_2, var_3);
}

_id_6CAA(var_0, var_1, var_2, var_3) {
  return _id_6CA4(var_0, var_1, "weapon_xp", var_2, var_3);
}

_id_6CA4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_6CA8(var_0);
  _id_6C9C(var_0, var_4, var_3);
  var_6 = _id_6C9E(var_5);
  var_7 = 0;

  foreach(var_13, var_9 in var_6) {
    var_10 = _id_6CA1(var_13);

    if(var_10 == var_2) {
      var_11 = _id_6CA2(var_13);
      var_12 = _id_6CA5(var_9, var_1);
      var_7 = var_7 + var_11 * var_12;
    }
  }

  var_7 = _id_3315(var_2, var_7);
  return var_7;
}

_id_6CA5(var_0, var_1) {
  var_2 = 1.0;
  var_3 = _id_6C9F(var_0);
  var_4 = 0.0;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    if(isDefined(var_3[var_5])) {
      var_4 = var_3[var_5];
    }

    var_2 = var_2 + var_4;
  }

  return var_2;
}

_id_6C97(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;

  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    if(istrue(var_4._id_7546)) {
      var_2++;
    }
  }

  if(!var_1 && isDefined(level._id_BEAF._id_9C8F) && isDefined(level._id_BEAF._id_9C8F[var_0])) {
    var_2 = int(min(var_2, level._id_BEAF._id_9C8F[var_0]));
  }

  return var_2;
}

_id_BEB6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in var_0) {
    if(scripts\mp\gametypes\br_lootcache::_id_31DF(var_7)) {
      var_8 = level._id_2A95._id_2A65[var_7];

      if(isDefined(var_8) && var_8 == 4 && var_5 == 0) {
        scripts\mp\gametypes\br_lootcache::_id_9899(var_7, var_4, var_1, var_2, var_3, 1);
        var_4++;
        var_5 = 1;
      } else {
        scripts\mp\gametypes\br_lootcache::_id_9899(var_7, var_4, var_1, var_2, var_3, 0);
        var_4++;
      }
    }
  }
}

_id_6C9C(var_0, var_1, var_2) {
  var_3 = _id_6CA8(var_0);
  var_4 = var_3;

  if(isDefined(var_2)) {
    var_4 = var_4 + var_2;
  }

  if(isDefined(var_1)) {
    var_4 = var_4 + var_1;
  }

  if(_id_BEB7(var_4)) {
    return var_4;
  }

  var_4 = var_3;

  if(isDefined(var_1)) {
    var_4 = var_4 + var_1;
  }

  if(_id_BEB7(var_4)) {
    return var_4;
  }

  return var_3;
}

_id_BEB7(var_0) {
  var_1 = _id_6CA0();
  var_2 = _func_0222(var_1, 0, var_0, 0);
  return var_2 != "";
}

_id_6CF5(var_0) {
  switch (var_0) {
    case "drop_bag":
    case "loot_cache":
    case "loot_table":
    case "weapon_xp":
    case "reward_tier":
    case "circle_peek":
    case "plunder":
    case "xp":
    case "none":
      return "int";
    case "loot_items":
      return "string";
    default:
      break;
  }
}

_id_3315(var_0, var_1) {
  var_2 = _id_6CF5(var_0);

  switch (var_2) {
    case "int":
      var_1 = int(var_1);
      break;
    case "float":
      var_1 = float(var_1);
      break;
    case "string":
      var_1 = "" + var_1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_6CA0() {
  var_0 = "mp/brmission_reward_groups.csv";

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    return "mp/brmission_reward_groups_dmz.csv";
  } else {
    return "mp/brmission_reward_groups.csv";
  }
}

_id_6C9D(var_0) {
  var_1 = _id_6CA0();
  return int(_func_0222(var_1, 0, var_0, 1));
}

_id_6CA3(var_0) {
  var_1 = level._id_BEAF._id_F1E7[var_0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  return var_1;
}

_id_D68D(var_0, var_1) {
  level._id_BEAF._id_F1E7[var_0] = var_1;
  _id_D68F(var_0, var_1);
}

_id_1119(var_0, var_1) {
  _id_D68D(var_0, _id_6CA3(var_0) + var_1);
}

_id_111A(var_0, var_1) {
  waittillframeend;
  _id_D68D(var_0, _id_6CA3(var_0) + var_1);
}

_id_D68C(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    var_3 _id_D68B(var_1);
  }
}

_id_D68B(var_0) {
  self setclientomnvar("ui_br_objective_index", var_0);
}

_id_D68F(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
    var_3 _id_D68E(var_1);
  }
}

_id_D68E(var_0) {
  self setclientomnvar("ui_br_objective_reward_tier", var_0);
}

_id_3157() {
  foreach(var_5, var_1 in level._id_BEAF._id_BEB8) {
    foreach(var_3 in var_1._id_8300) {
      var_3._id_0372 = "cancel";
      var_3 _id_C50F();
    }
  }
}

_id_68A3(var_0) {
  var_1 = [];

  foreach(var_8, var_3 in level._id_BEAF._id_BEB8) {
    foreach(var_7, var_5 in var_3._id_8300) {
      if(var_7 != var_0) {
        continue;
      }
      if(_id_89D0(var_5)) {
        continue;
      }
      var_6 = spawnStruct();
      var_6._id_82FC = var_5;

      switch (var_5._id_332F) {
        case "assassination":
          if(isDefined(var_5._id_EEF3)) {
            var_6.origin = var_5._id_EEF3.origin;
          }

          break;
        case "domination":
          if(isDefined(var_5._id_EABF) && isDefined(var_5._id_EABF._id_4D1E) && isDefined(var_5._id_EABF._id_4D1E._id_4140)) {
            var_6.origin = var_5._id_EABF._id_4D1E._id_4140 + (0, 0, 60);
          }

          break;
        case "scavenger":
          if(isDefined(var_5._id_EABF._id_2EA6.origin) && isDefined(var_5._id_EABF._id_2EA6)) {
            var_6.origin = var_5._id_EABF._id_2EA6.origin + (0, 0, 50);
          }

          break;
        case "timedrun":
          break;
        case "collection":
          break;
        case "vip":
          break;
        default:
          break;
      }

      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}