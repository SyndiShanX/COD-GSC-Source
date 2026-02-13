/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_zonecapture.gsc
****************************************************/

_id_D896(var_0, var_1, var_2, var_3) {
  var_4 = var_0;

  if(!isDefined(var_1)) {
    var_1 = [];
    var_1[0] = var_4;
  }

  if(istrue(var_2)) {
    var_5 = 0;
  } else {
    var_5 = undefined;
  }

  var_4 = _id_07D6::_id_406E("neutral", var_4, var_1, (0, 0, 0), var_5, var_3);
  var_4 _id_07D6::_id_4AD1();

  if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "patrol" || scripts\mp\utility\game::getgametype() == "control" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {
    for(var_6 = 0; var_6 < var_4._id_10430.size; var_6++) {
      var_4._id_10430[var_6] hide();
    }
  } else
    var_4._id_10430[0] _meth_82CB("iw8_mp_military_hq_crate_close");

  var_4 _id_07D6::_id_316A(1);
  var_4._id_37F3 = level._id_110E0 * 1000;
  var_4 _id_07D6::_id_B0E7();

  if(isDefined(var_0._id_A8E1)) {
    var_4._id_A8E1 = var_0._id_A8E1;
  } else {
    var_4._id_A8E1 = var_4 _id_07D6::_id_6AF1();
  }

  if(level._id_FE83 && !level._id_FE81) {
    var_4 _id_07D6::_id_A362(0);
  } else {
    var_4 _id_07D6::_id_A362(1);
  }

  if(scripts\mp\utility\game::getgametype() == "mendota") {
    var_4 _id_07D6::_id_A362(0);
  }

  var_4._id_7C8C = "hardpoint";

  if(isDefined(var_4.trigger.target)) {
    if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {
      var_4 thread _id_1D14(var_4.trigger.target, var_4.trigger._id_CD99);
    } else if(scripts\mp\utility\game::getgametype() == "control") {
      var_4 thread assigncontrolchevrons(var_4.trigger.target, var_4.trigger._id_CD99);
    } else if(scripts\mp\utility\game::getgametype() == "patrol") {
      var_4 thread _id_1D21(var_4.trigger.target, var_4.trigger._id_CD99);
    }
  }

  return var_4;
}

_id_BA5B(var_0) {
  if(level.mapname == "mp_parkour") {
    if(var_0._id_CD99 == "1") {
      var_0.origin = var_0.origin + (0, 0, 135);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(var_0._id_CD99 == "3") {
      var_0.origin = var_0.origin - (0, 0, 50);
    }
  }

  if(level.mapname == "mp_junk") {
    if(var_0._id_CD99 == "4") {
      var_0.origin = var_0.origin - (0, 7, 0);
    }
  }

  return var_0;
}

_id_1D14(var_0, var_1) {
  wait 1.0;
  var_2 = _func_03C0(var_0, "targetname");
  var_2 = _id_C483(var_2, var_1);
  var_2 = _id_BA5E(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6]._id_A776 = 1;

    if(isDefined(var_5._id_039B)) {
      if(var_5._id_039B == "2") {
        var_3[var_6]._id_A776 = 2;
        continue;
      }

      if(var_5._id_039B == "3") {
        var_3[var_6]._id_A776 = 3;
        continue;
      }

      if(var_5._id_039B == "4") {
        var_3[var_6]._id_A776 = 4;
      }
    }
  }

  self._id_3572 = var_3;
}

assigncontrolchevrons(var_0, var_1) {
  wait 1.0;
  var_2 = _func_03C0(var_0, "targetname");
  var_2 = _id_C483(var_2, var_1);
  var_2 = _id_BA5E(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6]._id_A776 = 1;

    if(isDefined(var_5._id_039B)) {
      if(var_5._id_039B == "_b") {
        var_3[var_6]._id_A776 = 2;
      }
    }
  }

  self._id_3572 = var_3;
}

_id_1D21(var_0, var_1) {
  wait 1.0;
  var_2 = getscriptablearray(var_0, "targetname");
  var_2 = _id_C483(var_2, var_1);
  var_2 = _id_BA5E(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6]._id_A776 = 1;
  }

  self._id_3572 = var_3;
}

_id_FC2B(var_0) {
  if(scripts\mp\utility\game::getgametype() != "koth" && scripts\mp\utility\game::getgametype() != "patrol" && scripts\mp\utility\game::getgametype() != "control" && scripts\mp\utility\game::getgametype() != "kspoint" && scripts\mp\utility\game::getgametype() != "mendota") {
    return;
  }
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self._id_3572)) {
    waitframe();
  }

  foreach(var_2 in self._id_3572) {
    for(var_3 = 0; var_3 < var_2._id_A776; var_3++) {
      var_4 = "chevron_";

      if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {
        if(scripts\mp\utility\game::isholidayenabled(2)) {
          var_4 = "chevron_holiday_";
        } else if(scripts\mp\utility\game::isholidayenabled(3)) {
          var_4 = "chevron_vday_";
        }
      }

      var_2 setscriptablepartstate(var_4 + var_3, var_0);
    }
  }
}

_id_0F05() {
  self._id_ABCB = ::_id_110D8;
  self._id_AA79 = ::_id_110D9;
  self._id_ABD4 = ::_id_110DB;
  self._id_AAC2 = ::_id_110DA;
  self._id_ABC8 = ::_id_110D6;
  self._id_AA8D = ::_id_110D2;
  self._id_ABC7 = ::_id_110D5;
  self._id_E86E = ::_id_110DD;
  self._id_AB54 = ::_id_110D4;
  self._id_ABC9 = ::_id_110D7;
  self._id_497A = 0;

  if(!isDefined(level._id_A4EA)) {
    _id_07D6::_id_C579(1, 1, 0, 1, 0);
  }

  var_0 = self._id_4140;

  if(isDefined(level._id_6AA2)) {
    var_0 = [[level._id_6AA2]]();
  }

  var_1 = 1024;

  if(isDefined(level._id_6AA3)) {
    var_1 = [[level._id_6AA3]]();
  }

  var_2 = [];
  var_2[var_2.size] = _id_0817::_id_1135(var_0 - (0, 0, 2048), var_1, 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1);
  var_2[var_2.size] = _id_0817::_id_1135(var_0 - (0, 0, 2048), var_1, 4096, "axis", undefined, undefined, undefined, undefined, undefined, 1);
  self._id_434A = var_2;

  if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {
    self._id_7D35 = 1;
    self._id_165F = 1;

    if(scripts\mp\utility\game::getgametype() == "kspoint") {
      level thread scripts\mp\gametypes\kspoint::_id_1FC4();
    } else if(scripts\mp\utility\game::getgametype() == "mendota") {
      level thread scripts\mp\gametypes\mendota::_id_1FC4();
    } else {
      level thread scripts\mp\gametypes\koth::_id_1FC4();
    }
  } else if(scripts\mp\utility\game::getgametype() == "patrol") {
    self._id_7D35 = 1;
    self._id_165F = 1;
    level thread scripts\mp\gametypes\patrol::_id_1FC4();
  } else if(scripts\mp\utility\game::getgametype() == "control") {
    self._id_7D35 = 1;
    self._id_165F = 1;
    level thread scripts\mp\gametypes\koth::_id_1FC4();
  } else {
    self._id_E86C = ::_id_110DC;
    _id_07F9::_id_FB97(self._id_A908, self._id_10430[0].origin + (0, 0, 70));
    level thread scripts\mp\gametypes\hq::_id_1FC4();
  }
}

_id_4392() {
  self._id_ABCB = undefined;
  self._id_AA79 = undefined;
  self._id_ABD4 = undefined;
  self._id_ABC8 = undefined;
  self._id_AA8D = undefined;
  self._id_ABC7 = undefined;
  self._id_E57B = 0;
  self._id_10A20 = 0;
  self._id_497A = 0;
  thread _id_FC2B("off");

  if(isDefined(self._id_434A)) {
    foreach(var_1 in self._id_434A) {
      _id_0817::_id_C51F(var_1);
    }
  }

  self._id_434A = undefined;

  foreach(var_4 in level.players) {
    _id_07F9::_id_A8CF(self._id_A908, var_4);
  }

  self.trigger scripts\engine\utility::_id_F5E0();
  thread _id_1086F();
  _id_07D6::_id_C300(1, 0);

  if(scripts\mp\utility\game::getgametype() == "hq") {
    self._id_10430[0] playSound("mp_hq_deactivate_sfx");
    self._id_10430[0] _meth_82CB("iw8_mp_military_hq_crate_close");
    level._id_110CF._id_10430[0] stoploopsound();
  }

  level._id_CC08 = 0;
}

_id_110EC() {
  level endon("game_ended");
  level endon("dev_force_zone");
  var_0 = int(level._id_110E6 * 1000 + gettime());

  if(!isDefined(level._id_110EA) || level._id_110EA < 10) {
    thread _id_7B14(level._id_110E6);
  }

  level thread _id_7458(var_0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level._id_110E6);
}

_id_7B14(var_0) {
  level endon("game_ended");

  if(scripts\mp\utility\game::getgametype() == "hq") {
    level endon("zone_destroyed");
  }

  if(int(var_0) > 12) {
    var_1 = var_0 - 12;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

    foreach(var_3 in level._id_EF89) {
      level _id_0A8D::_id_E775("hp_move_soon", var_3);
    }
  }
}

_id_7458(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level endon("zone_captured");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("ui_objective_timer_stopped", 0);

  if(var_1 > 0) {
    setomnvar("ui_hardpoint_timer", level._id_110E4 + var_1);
  } else {
    setomnvar("ui_hardpoint_timer", level._id_110E4);
  }
}

_id_96F8(var_0, var_1) {
  level endon("game_ended");
  var_2 = level._id_5F3A;
  var_3 = var_2 * 1000;
  var_4 = var_0 * 1000;
  var_5 = var_4 - var_3;
  self._id_BF19 = _id_07F9::_id_C57D(99);

  if(self._id_BF19 != -1) {
    var_6 = "invisible";
    _id_07F9::_id_A867(self._id_BF19, var_6, var_1);
    _id_07F9::_id_A8B1(self._id_BF19, 0);
    _id_07F9::_id_A8B2(self._id_BF19, 0);
    _id_07F9::_id_A8A2(self._id_BF19);
    self._id_DCFF = 1;
  }

  _id_07D6::_id_D61B(level._id_7C8A, level._id_7C8A, self._id_BF19);
  var_7 = gettime() + var_4;

  while(gettime() < var_7) {
    var_8 = var_5 / var_4;
    _id_07F9::_id_A8C4(self._id_BF19, 1);
    _id_07F9::_id_A8B4(self._id_BF19, var_8);
    var_5 = max(var_5 - var_3, 1);
    waitframe();
  }

  _id_07F9::_id_C799(self._id_BF19);
  self._id_BF19 = -1;
}

_id_74C7() {
  self notify("flag_neutral");
  _id_07D6::_id_D639("neutral");
  _id_B84D();
  thread _id_FC2B("idle");
}

_id_F403() {
  thread _id_3889();
  level endon("game_ended");
  level endon("zone_moved");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(level._id_110CF.trigger)) {
        var_1 _meth_80CB(1);
        continue;
      }

      var_1 _meth_80CB(0);
    }

    waitframe();
  }
}

_id_3889() {
  level scripts\engine\utility::waittill_any_2("game_ended", "zone_moved");

  foreach(var_1 in level.players) {
    var_1 _meth_80CB(0);
  }
}

on_koth_1minute() {
  level endon("game_ended");

  if(isDefined(self.pers["hardpoint_counter_started"]) && self.pers["hardpoint_counter_started"]) {
    return;
  } else {
    self.pers["hardpoint_counter_started"] = 1;
  }

  while(isDefined(self.pers["objTime"]) && self.pers["objTime"] < 60) {
    wait 1;
  }

  thread _id_07BC::creategametypechallenegeevent("koth_1min");
}

_id_110D8(var_0) {
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
  var_1 = var_0.team;
  var_2 = gettime();
  var_3 = [];
  var_4 = getarraykeys(self._id_F396[var_1]);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_3[var_4[var_5]] = self._id_F396[var_1][var_4[var_5]];
  }

  var_0 thread on_koth_1minute();
  var_0 thread _id_07BC::creategametypechallenegeevent("zone_cap");

  if(level._id_FE83 && !level._id_FE81 && self._id_ADAE != "neutral") {
    setomnvar("ui_hq_ownerteam", 0);
    level notify("zone_destroyed");

    foreach(var_7 in level.players) {
      _id_07F9::_id_A8CF(self._id_A908, var_7);
    }

    level._id_110CF thread _id_1086F();
    level scripts\mp\gametypes\koth::_id_FD24("zone_shift", 0);

    if(isDefined(var_3)) {
      var_9 = getarraykeys(var_3);

      foreach(var_11 in var_9) {
        var_7 = self._id_1D2E[var_1][var_11].player;

        if(isDefined(var_7.owner)) {
          var_7 = var_7.owner;
        }

        if(!isPlayer(var_7)) {
          continue;
        }
        var_7 _id_07BC::_id_AA81();
      }
    }

    level thread scripts\mp\gametypes\hq::_id_6ED1(var_3, var_2, var_1, undefined, var_0);

    if(scripts\mp\utility\game::getgametype() == "hq") {
      level _id_0A8D::_id_E775("hp_captured_friendly", var_0.team);
      level _id_0A8D::_id_E775("hp_owned_lost", self._id_ADAE);
      return;
    }

    level _id_0A8D::_id_E775("hp_captured_friendly", var_0.team);
    level _id_0A8D::_id_E775("hp_captured_enemy", self._id_ADAE);
    return;
  } else {
    if(scripts\mp\utility\game::getgametype() == "hq") {
      var_13 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

      foreach(var_7 in var_13) {
        var_7 _id_07BC::_id_AA81();
        var_7._id_DDC7 = 1;
      }
    }

    var_16 = _id_07D6::_id_6C02();
    var_17 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
    _id_07D6::_id_D639(var_1);

    if(level._id_FE83 && !level._id_FE81) {
      setomnvar("ui_hq_ownerteam", scripts\mp\gametypes\hq::_id_6AAA(self._id_ADAE));
      setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::_id_6DCA(self._id_ADAE, "aliveCount"));
    }

    if(scripts\mp\utility\game::getgametype() == "hq" && !level._id_FE81) {
      var_18 = scripts\mp\gamescore::_id_0C0F(var_1);
      var_19 = scripts\mp\gamescore::_id_0C0F(var_17);

      if(var_18 > var_19) {
        level._id_CC08 = 1;
      }

      _id_11A4(var_1);
    } else if(level._id_AF6F)
      level scripts\mp\gamelogic::pausetimer();

    level._id_FED4 = 0;
    var_20 = 0;
    level._id_110CF _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
    level scripts\mp\gametypes\koth::_id_FD24(var_1, 0);

    if(scripts\mp\utility\game::getgametype() == "hq" && !level._id_FE81) {
      thread scripts\mp\utility\print::_id_BD0C(var_1, var_17, undefined, undefined, "mp_dom_flag_captured", undefined, var_0);
    }

    if(!isDefined(level._id_8FA2) || level._id_8FA2 != var_1) {
      if(scripts\mp\utility\game::getgametype() == "hq" && !level._id_FE81) {
        if(isDefined(level._id_8E3D && level._id_8E3D == 0)) {
          level._id_46D0 = 4;
        } else {
          level._id_46D0 = undefined;
        }

        level thread _id_46AC(var_1, var_17);
      } else if(scripts\mp\utility\game::getgametype() == "patrol") {
        level _id_0A8D::_id_E775("hp_captured_friendly", var_1, "patrol", undefined, undefined, undefined, 1);
        level _id_0A8D::_id_E775("hp_captured_enemy", var_17, "patrol", undefined, undefined, undefined, 1);
      } else {
        level _id_0A8D::_id_E775("hp_captured_friendly", var_1);
        level _id_0A8D::_id_E775("hp_captured_enemy", var_17);
      }

      if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {
        level thread scripts\mp\gametypes\koth::_id_6ED1(var_3, var_2, var_1, level._id_8FA2, var_0);
      } else if(scripts\mp\utility\game::getgametype() == "patrol") {
        level thread scripts\mp\gametypes\patrol::_id_6ED1(var_3, var_2, var_1, level._id_8FA2, var_0);
      } else {
        level thread scripts\mp\gametypes\hq::_id_6ED1(var_3, var_2, var_1, level._id_8FA2, var_0);
      }
    }

    foreach(var_22 in level.players) {
      _id_DC8D(var_1, var_22);
    }

    level._id_110CF thread _id_FC2B(var_1);

    if(scripts\mp\utility\game::getgametype() == "hq") {
      level._id_110CF._id_10430[0] stoploopsound();
      level._id_110CF._id_10430[0] _meth_82CB("iw8_mp_military_hq_crate_open_idle");

      if(!level._id_FE81) {
        var_24 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

        foreach(var_7 in var_24) {
          var_7 thread scripts\mp\gametypes\hq::_id_DCDE();
        }
      }
    }

    level._id_7B15 = var_1;
    self._id_3229++;
    level._id_8FA2 = var_1;

    if(scripts\mp\utility\game::getgametype() == "mendota") {
      scripts\mp\gametypes\mendota::on_team_claimed_zone(var_1);
    }

    level notify("zone_captured");
    level notify("zone_captured" + var_1);
  }
}

_id_1086F() {
  waitframe();
  _id_07D6::_id_D8E0("none");
}

_id_110D9(var_0) {
  if(scripts\mp\utility\game::getgametype() == "hq" && !level._id_FE81) {
    var_1 = _id_07D6::_id_6C02();

    if(var_1 != "neutral" && self._id_37F6 != var_1) {
      _id_11A4(var_1, 1);
    }

    if(!istrue(var_0._id_F90E) || !istrue(self._id_E57B)) {
      if(var_1 == "neutral") {
        var_0 setclientomnvar("ui_objective_state", 1);
      } else {
        var_0 setclientomnvar("ui_objective_state", 2);
      }

      var_0._id_F90E = 1;
    }
  }

  if(!isDefined(self._id_E776)) {
    self._id_E776 = gettime();
  }

  if(self._id_E776 > self._id_E776 + 10000) {
    self._id_497A = 0;
    self._id_E776 = gettime();
  }

  _id_07D6::_id_D8D2(level._id_110E0);

  if(level._id_110E0 > 0) {
    self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    _id_07D6::_id_D61B(level._id_7C6F, level._id_7C87);
  }
}

_id_110DB(var_0, var_1, var_2, var_3) {
  _id_07F9::objective_set_claiming_team(self._id_A908, var_0);
  var_4 = _id_07D6::_id_6C02();

  if(var_4 == "neutral" && self._id_37F6 != var_4) {
    _id_11A4(self._id_37F6);
  } else if(var_4 != "neutral" && self._id_37F6 != var_4) {
    _id_11A4(var_4, 1);
  } else if(level._id_AF6F) {
    level scripts\mp\gamelogic::pausetimer();
  }

  if((scripts\mp\utility\game::getgametype() == "hq" || scripts\mp\utility\game::getgametype() == "arm") && var_1 < 1.0 && !level._id_FE81 && !level.gameended) {
    _id_B370(var_1, var_0);
  }

  var_4 = _id_07D6::_id_6C02();
  var_5 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    if(var_4 == "neutral") {
      _id_0A8D::_id_E775("hp_capturing_friendly", var_0);
      _id_0A8D::_id_E775("hp_capturing_enemy", var_5);
    } else if(scripts\mp\utility\game::getgametype() == "hq") {
      _id_0A8D::_id_E775("hp_disabling_friendly", var_4);
      _id_0A8D::_id_E775("hp_disabling_enemy", var_0);
    } else {
      _id_0A8D::_id_E775("hp_capturing_enemy", var_4);
      _id_0A8D::_id_E775("hp_capturing_friendly", var_0);
    }

    self._id_497A = 1;
  }
}

_id_46AC(var_0, var_1) {
  wait 0.5;
  level _id_0A8D::_id_E775("hp_secured_friendly", var_0);
  level _id_0A8D::_id_E775("hp_captured_enemy", var_1);
}

_id_B370(var_0, var_1) {
  if(!isDefined(self._id_903F)) {
    self._id_903F = gettime();
  }

  if(self._id_903F + 995 < gettime()) {
    self._id_903F = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self._id_10430[0] playsoundtoteam(var_2, var_1);
  }
}

_id_110DA(var_0, var_1, var_2) {
  var_3 = level._id_110CF _id_07D6::_id_6C02();

  if(!var_2) {
    if(scripts\mp\utility\game::getgametype() == "hq") {
      if(level._id_FE81) {
        if(level._id_AF6F) {
          level scripts\mp\gamelogic::resumetimer();
        }
      } else if(var_3 != "neutral")
        _id_11A4(var_3);
    } else if(level._id_AF6F)
      level scripts\mp\gamelogic::resumetimer();
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  if(var_3 == "neutral") {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C74);

    if(istrue(level._id_FE82)) {
      foreach(var_1 in level.players) {
        level._id_110CF _id_DD03(var_1);
      }
    }
  } else {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);

    foreach(var_1 in level.players) {
      level._id_110CF _id_DC8D(var_3, var_1);
    }
  }
}

_id_110D6() {
  if(level._id_FE83 && !level._id_FE81 && self._id_ADAE != "neutral") {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
    _id_11A4(self._id_ADAE);
  } else {
    level notify("zone_destroyed");
    level._id_7B15 = "neutral";

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::resumetimer();
    }

    var_0 = 1;

    foreach(var_2 in level._id_EF89) {
      if(self._id_A79A[var_2] > 0) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      level._id_110CF._id_10A18 = 1;
      level scripts\mp\gametypes\koth::_id_FD24("neutral", 0);
      level._id_110CF _id_07D6::_id_D61B(level._id_7C74);
      level._id_110CF _id_B84D();
      level._id_110CF thread _id_FC2B("idle");
    }
  }

  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
}

_id_110D2() {
  level thread scripts\mp\gametypes\koth::_id_1FC5();

  if(level._id_AF6F) {
    level scripts\mp\gamelogic::resumetimer();
  }

  var_0 = level._id_110CF _id_07D6::_id_6C02();
  level._id_110CF _id_07D6::_id_D61B(level._id_7C48);
  level scripts\mp\gametypes\koth::_id_FD24(var_0, 1);
  level._id_110CF thread _id_FC2B("contested");
  level._id_110CF.iscontested = 1;

  foreach(var_2 in level._id_EF89) {
    if(self._id_F396[var_2].size) {
      var_3 = self._id_F396[var_2];
      var_4 = getarraykeys(var_3);

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_6 = var_3[var_4[var_5]].player;
        var_6 setclientomnvar("ui_objective_state", 3);
      }
    }
  }

  foreach(var_6 in level.players) {
    level._id_110CF _id_DC8D(var_0, var_6);

    if(scripts\mp\utility\game::getgametype() == "patrol") {
      var_6 playlocalsound("ui_mp_patrol_point_contested");
    }
  }

  if(var_0 == "neutral") {
    var_10 = self._id_37F6;
  } else {
    var_10 = var_0;
  }

  foreach(var_12 in level._id_EF89) {
    if(scripts\mp\utility\game::getgametype() == "patrol") {
      _id_0A8D::_id_E775("hp_contested", var_12, "patrol", undefined, undefined, undefined, 1);
      continue;
    }

    _id_0A8D::_id_E775("hp_contested", var_12);
  }

  var_14 = spawnStruct();
  var_14.player = level._id_110CF;
  var_14._id_56B9 = "hill_contested";
  var_14._id_033E = level._id_110CF.trigger.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_14);
  self._id_497A = 1;
  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
}

_id_110D5(var_0) {
  level notify("stop_contested_stats_thread");

  if(level._id_AF6F) {
    level scripts\mp\gamelogic::pausetimer();
  }

  var_1 = level._id_110CF _id_07D6::_id_6C02();

  if(var_0 == "none" || var_1 == "neutral") {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C74);

    if(istrue(level._id_FE82)) {
      foreach(var_3 in level.players) {
        level._id_110CF _id_DD03(var_3);
      }
    }

    var_5 = spawnStruct();
    var_5.player = level._id_110CF;
    var_5._id_56B9 = "hill_empty";
    var_5._id_033E = level._id_110CF.trigger.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_5);
  } else {
    if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "kspoint" || scripts\mp\utility\game::getgametype() == "mendota") {} else if(scripts\mp\utility\game::getgametype() == "grnd") {
      _id_0AA2::_id_B8F1("mp_dropzone_captured_positive", var_1);
      _id_0AA2::_id_B8F1("mp_dropzone_captured_negative", scripts\mp\utility\game::_id_6BE2(var_1)[0]);
    }

    level._id_110CF _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);

    foreach(var_3 in level.players) {
      level._id_110CF _id_DC8D(var_1, var_3);
    }

    var_5 = spawnStruct();
    var_5.player = level._id_110CF;
    var_5._id_56B9 = "hill_uncontested";
    var_5._id_033E = level._id_110CF.trigger.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_5);
  }

  var_8 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  level._id_110CF thread _id_FC2B(var_8);
  level scripts\mp\gametypes\koth::_id_FD24(var_1, 0);
  level._id_110CF.iscontested = 0;
  self._id_497A = 0;
  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
}

_id_110DC(var_0) {
  _id_11A4(var_0);
}

_id_110DD(var_0) {
  var_0 thread scripts\mp\rank::_id_CC00("defend");
  var_0 thread _id_07B1::_id_6FB9("mode_x_defend");
  _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
}

_id_110D4(var_0) {
  if(self._id_ADAE != "neutral" && self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
  }
}

_id_110D7(var_0) {
  if(self._id_ADAE != "neutral" && !self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  }
}

_id_11A4(var_0, var_1) {
  if(!level._id_AF6F) {
    return;
  }
  var_2 = scripts\mp\gamescore::_id_0C0F(var_0);
  var_3 = scripts\mp\gamescore::_id_0C0F(scripts\mp\utility\game::_id_6BE2(var_0)[0]);

  if(istrue(var_1)) {
    if(var_3 > var_2) {
      level scripts\mp\gamelogic::resumetimer();
    } else {
      level scripts\mp\gamelogic::pausetimer();
    }
  } else if(var_2 > var_3)
    level scripts\mp\gamelogic::resumetimer();
  else {
    level scripts\mp\gamelogic::pausetimer();
  }
}

_id_D4F0(var_0) {
  if(isDefined(level._id_EB99) && level._id_EB99 && isDefined(var_0._id_3E59) && var_0._id_3E59) {
    var_0 _id_07C1::_id_D4EE("assist");
  }
}

_id_B84D() {
  if(istrue(level._id_FE82)) {
    foreach(var_1 in level.players) {
      _id_DD03(var_1);
    }
  }
}

_id_DC8D(var_0, var_1) {
  var_2 = var_1.team;
  var_3 = var_1 _meth_81D3();

  if(var_3) {
    if(var_1 _meth_874D() || var_1 _meth_8772()) {
      var_2 = "allies";
    } else {
      var_2 = var_1 _meth_8154();
    }
  }

  if(istrue(level._id_FE82)) {
    if(level._id_110CF._id_E57B) {
      _id_DD00(var_1);
    } else if(var_2 == var_0) {
      _id_DD02(var_1);
    } else {
      _id_DD01(var_1);
    }
  }
}

_id_DD03(var_0) {
  level._id_110CF._id_5FA3 hidefromplayer(var_0);
  level._id_110CF._id_540C hidefromplayer(var_0);
  level._id_110CF._id_3BED hidefromplayer(var_0);
  level._id_110CF._id_A432 showtoplayer(var_0);
}

_id_DD02(var_0) {
  level._id_110CF._id_5FA3 showtoplayer(var_0);
  level._id_110CF._id_540C hidefromplayer(var_0);
  level._id_110CF._id_3BED hidefromplayer(var_0);
  level._id_110CF._id_A432 hidefromplayer(var_0);
}

_id_DD01(var_0) {
  level._id_110CF._id_5FA3 hidefromplayer(var_0);
  level._id_110CF._id_540C showtoplayer(var_0);
  level._id_110CF._id_3BED hidefromplayer(var_0);
  level._id_110CF._id_A432 hidefromplayer(var_0);
}

_id_DD00(var_0) {
  level._id_110CF._id_5FA3 hidefromplayer(var_0);
  level._id_110CF._id_540C hidefromplayer(var_0);
  level._id_110CF._id_3BED showtoplayer(var_0);
  level._id_110CF._id_A432 hidefromplayer(var_0);
}

_id_7911(var_0) {
  self._id_5FA3 hidefromplayer(var_0);
  self._id_540C hidefromplayer(var_0);
  self._id_A432 hidefromplayer(var_0);
  self._id_3BED hidefromplayer(var_0);
}

_id_AB69(var_0) {
  if(var_0.team != "spectator" && level._id_110CF._id_ADAE != "neutral") {
    level._id_110CF _id_DC8D(level._id_110CF._id_ADAE, var_0);
  }
}

_id_C483(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      var_3["1"] = [(-564, 1848, 24)];
      var_3["2"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case "mp_cave_am":
    case "mp_cave":
      var_3["3"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case "mp_raid":
      var_3["8"] = [(688, 256, 280)];
      var_3["20"] = [(212, 1436, 338)];
      break;
    default:
      break;
  }

  if(isDefined(var_3[var_1])) {
    foreach(var_5 in var_0) {
      foreach(var_7 in var_3[var_1]) {
        if(distance(var_5.origin, var_7) < 10) {
          var_2[var_2.size] = var_5;
          break;
        }
      }
    }
  }

  var_0 = scripts\engine\utility::_id_1BBF(var_0, var_2);
  return var_0;
}

_id_BA5E(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      var_2["1"] = [];
      var_2["1"][0] = [(-564, 1880, 24), (0, 180, 0)];
      var_2["1"][1] = [(-564, 1976, 24), (0, 180, 0)];
      var_2["1"][2] = [(-564, 2072, 24), (0, 180, 0)];
      var_2["2"] = [];
      var_2["2"][0] = [(-1314, 472, 24), (0, 180, 0)];
      var_2["2"][1] = [(-1314, 568, 24), (0, 180, 0)];
      var_2["2"][2] = [(-1474, 816, 24), (0, 270, 0)];
      var_2["2"][3] = [(-1378, 816, 24), (0, 270, 0)];
      var_2["4"] = [];
      var_2["4"][0] = [(-1298, 1992, 24), (0, 180, 0)];
      var_2["4"][1] = [(-1400, 2262, 24), (0, 270, 0)];
      var_2["4"][2] = [(-1690, 2264, 24), (0, 270, 0)];
      break;
    case "mp_deadzone":
      var_2["2"] = [];
      var_2["2"][0] = [(436, 3435, 207.694), (0, 360, 0)];
      var_2["2"][1] = [(436, 3188, 247.694), (0, 360, 0)];
      var_2["2"][2] = [(436, 3098, 258.694), (0, 360, 0)];
      var_2["2"][3] = [(1051, 2796, 304), (0, 117.509, 0)];
      var_2["2"][4] = [(931, 2680, 304), (0, 147.509, 0)];
      var_2["2"][5] = [(515, 3522, 215), (0, 276, 0)];
      var_2["12"] = [];
      var_2["12"][0] = [(-400, 651, 436), (0, 180, 0)];
      var_2["12"][1] = [(-400, 557, 439), (0, 180, 0)];
      var_2["12"][2] = [(-400, 461, 446), (0, 180, 0)];
      var_2["12"][3] = [(-410, -65, 446), (0, 180, 0)];
      var_2["12"][4] = [(-408, 31, 448), (0, 180, 0)];
      break;
    case "mp_raid":
      var_2["5"] = [];
      var_2["5"][0] = [(-3118.59, 230.46, 292), (0, 0, 0)];
      var_2["8"] = [];
      var_2["8"][0] = [(688, 256, 295), (0, 270, 0)];
      var_2["8"][1] = [(749, 248, 295), (0, 270, 0)];
      var_2["12"] = [];
      var_2["12"][0] = [(-1490.62, -972.979, 422), (0, 90, 0)];
      var_2["13"] = [];
      var_2["13"][0] = [(-1695.67, 3211.7, 310), (0, 270, 0)];
      var_2["13"][1] = [(-1804.59, 3219.27, 284), (0, 270, 0)];
      var_2["20"] = [];
      var_2["20"][0] = [(260, 1416, 338), (0, 90, 0)];
      break;
    case "mp_cave_am":
    case "mp_cave":
      var_2["3"] = [];
      var_2["3"][0] = [(-514, 1328, 32), (0, 100, 0)];
      var_2["3"][1] = [(-692, 1828, 42), (0, 260, 0)];
      var_2["3"][2] = [(-564, 1804, 44), (0, 260, 0)];
      var_2["3"][3] = [(-500, 1788, 54), (0, 260, 0)];
      var_2["3"][4] = [(-312, 1528, 78), (0, 145, 0)];
      break;
    case "mp_hackney_am":
    case "mp_hackney_yard":
      var_2["8"] = [];
      var_2["8"][0] = [(994.552, 1760.12, 44), (0, 270, 0)];
      var_2["9"] = [];
      var_2["9"][0] = [(1322, -407.18, 29.184), (0, 90, 0)];
      break;
    case "mp_aniyah":
      var_2["13"] = [];
      var_2["13"][0] = [(1995.79, 394.828, 424), (0, 270, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var_2[var_1])) {
    foreach(var_5 in var_2[var_1]) {
      var_6 = var_5[0];
      var_7 = var_5[1];
      var_8 = _func_03C5("hardpoint_chevron", var_6, var_7);
      var_3[var_3.size] = var_8;
    }
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  return var_0;
}

_id_4070(var_0, var_1, var_2) {
  var_0.origin = var_1;
  var_0.angles = var_2;
  return var_0;
}