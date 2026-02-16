/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1905.gsc
*************************************************/

_id_810D() {
  if(!isDefined(level._id_10CAE)) {
    if(getDvar("#x3a30c33efc8281eb1") == "cp_wave_sv") {
      level._id_10CAE = "cp/" + getDvar("#x36d16f02578d0ee10") + "_wave_table.csv";
    } else {
      level._id_10CAE = "cp/cp_donetsk_wave_table.csv";
    }
  }

  level thread _id_81DA();
}

_id_81DA() {
  var_0 = [_id_0743::_id_D19D, "grouped_wave_spawning", 0, 0];
  var_1 = [_id_0743::_id_D19D, "grouped_wave_spawning", [_id_0743::_id_6346, 30], 30];
  var_2 = [_id_0743::_id_D19D, "grouped_wave_spawning", [_id_0743::_id_6346, 30], 30];
  _id_0743::_id_C23C("wave_spawning", var_0, var_1, undefined, [::_id_10CAA, undefined, undefined, 0.1, [_id_0743::_id_6832, 0], _id_0743::_id_6831, 1], undefined, ::_id_C78C, ::_id_810F);
  _id_0743::_id_C23C("wave_spawning", var_0, var_2, undefined, [::_id_10CA9, undefined, undefined, [_id_0743::_id_6769, 1], [_id_0743::_id_6832, 0], _id_0743::_id_6831, 1], undefined, _id_0743::_id_C770, ::_id_810E);
  _id_0762::_id_C1FC("wave_spawning", ::_id_AF66, ::_id_F99E);
  _id_0762::_id_C1FB("wave_spawning", [_id_0762::_id_3ACD, "wave_spawning"]);
  _id_0743::_id_C1F8("wave_spawning");

  if(scripts\cp\utility::_id_871A()) {
    _id_0743::_id_C1F7("wave_spawning", [_id_0743::_id_A020, 750]);
    _id_0743::_id_C1F7("wave_spawning", [_id_0743::_id_A01F, 64]);
    _id_0743::_id_D3B2("wave_spawning", 750, 1024, 2500, 1);
  } else
    _id_0743::_id_D3B2("wave_spawning", 1024, 1536, 2500, 1);

  _id_0743::_id_C1F7("wave_spawning", ::_id_7DC4);
  _id_0743::_id_C1F7("wave_paratroopers", ::_id_7DC4);
  _id_0743::_id_C1F6("wave_spawning", ::_id_7DC3);
  _id_0743::_id_C1F6("wave_paratroopers", ::_id_7DC3);
  _id_0743::_id_C1F6("wave_spawning", ::_id_FB50);
  level thread _id_3F58();
  _id_0743::_id_C23C("wave_paratroopers", 0, 30, 8, 0.5, undefined, ::_id_C77B, ::_id_8013);
  _id_0762::_id_C1FB("wave_paratroopers", [_id_0762::_id_3ACD, "wave_spawning"]);
  _id_0743::_id_C1F7("wave_paratroopers", _id_0700::_id_AE4D);
  _id_0743::_id_D3B2("wave_paratroopers", 0, 2000, 200000, 1);
  _id_0743::_id_C1F6("wave_paratroopers", ::_id_FB50);
  _id_0743::_id_C23C("wave_veh_test", 0, 24, undefined, 0.1, undefined, ::_id_C78C, ::_id_5E73);
  _id_0743::_id_C23C("attack_heli_test", 0, 1, undefined, 0.1, 0, "wave_veh_spawners", undefined, undefined, undefined);
  _id_0762::_id_C1FB("attack_heli_test", [::_id_3210, "attack_heli", 1]);
}

_id_7DC4(var_0) {
  level._id_10C8F++;
}

_id_7DC3(var_0) {
  if(!isDefined(var_0) && isDefined(self._id_71F4)) {
    var_0 = self._id_71F4;
  }

  if(isDefined(var_0) && !istrue(var_0._id_8CAA) && istrue(self._id_A43C)) {
    _id_0743::_id_EAC5(var_0);
    _id_0743::_id_F2C1("wave_spawning", undefined, "wave_retry");
    _id_0743::_id_C9CE("wave_spawning", [::_id_D0B4, "wave_delay_over"]);
    level._id_10C8F--;
    return;
  }

  level._id_10C8E++;
}

_id_D0B4(var_0, var_1) {
  var_0 notify(var_1);
}

_id_810E(var_0) {
  level endon("game_ended");

  if(!scripts\engine\utility::_id_5C0C("wave_spawning_initialized")) {
    scripts\engine\utility::_id_5C11("wave_spawning_initialized");
  }

  var_1 = _id_0743::_id_4633(var_0 _id_0743::_id_642D(), 1);

  if(isDefined(level._id_E197[var_0._id_7218])) {
    for(var_2 = 0; var_2 < level._id_E197[var_0._id_7218].size; var_2++) {
      level._id_E197[var_0._id_7218][var_2]._id_10CA5 = var_1;
      level._id_E197[var_0._id_7218][var_2]._id_3DCC = 0;
      level._id_E197[var_0._id_7218][var_2]._id_3DCB = [];
      level._id_E197[var_0._id_7218][var_2]._id_10CAC = [];
      level._id_E197[var_0._id_7218][var_2]._id_C56D = [];
      level._id_E197[var_0._id_7218][var_2]._id_C570 = [];
      level._id_E197[var_0._id_7218][var_2]._id_8F76 = level._id_E197[var_0._id_7218][var_2]._id_10CA5;
      level._id_E197[var_0._id_7218][var_2]._id_8F77 = level._id_E197[var_0._id_7218][var_2]._id_10CA5;
    }
  }

  var_0 _id_0743::_id_803B();
  scripts\engine\utility::_id_5C24("cover_spawners_initialized");
  _id_0743::_id_C9CE("wave_spawning", _id_0743::_id_D83F);
  scripts\engine\utility::_id_5C1B("wave_spawning_initialized");
  var_0 _id_E672();
}

_id_E672() {
  level endon("game_ended");
  level._id_10C8F = 0;
  level._id_10C8E = 0;
  _id_0743::_id_D441();
  _id_FB4F(self);
  _id_0743::_id_DC1F();
}

_id_810F(var_0) {
  level endon("game_ended");

  if(!scripts\engine\utility::_id_5C0C("wave_spawning_initialized")) {
    scripts\engine\utility::_id_5C11("wave_spawning_initialized");
  }

  var_0 _id_0743::_id_803B();
  scripts\engine\utility::_id_5C24("cover_spawners_initialized");
  scripts\engine\utility::_id_5C24("wave_spawning_initialized");
}

_id_3210(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_10005)) {
    var_0._id_10005 = [];
  }

  var_0._id_10005[var_1] = var_2;
}

_id_3F58() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = spawnStruct();
    scripts\cp\utility::_id_1172("targetname", "wave_paratroopers", var_1);
    var_1.origin = _func_02AB((0, 0, 0));
    var_1._id_CD58 = 1;
    var_1 _id_0743::_id_E2CD();
  }
}

_id_C77B(var_0) {
  if(istrue(var_0._id_C6A3)) {
    return _id_0743::_id_C770(var_0);
  } else {
    var_1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
    return var_1;
  }
}

_id_8013(var_0) {
  var_0 _id_0743::_id_3D5E(var_0, "wave_spawning");
  var_1 = var_0 _id_A1FC();
  var_2 = var_1._id_AE1E + (0, 0, 12000);
  var_3 = var_2 + anglesToForward((0, randomint(360), 0)) * -20000;

  if(getdvarint("#x3cd61bd9cfeb7c166", 0)) {
    thread scripts\cp\utility::_id_4F48(var_1.origin, 128, 60, (1, 1, 1));
    thread scripts\cp\utility::_id_4F48(var_2, 128, 60, (1, 1, 0));
    thread scripts\cp\utility::_id_4F48(var_3, 128, 60, (0, 1, 0));
  }

  var_4 = var_1 _id_0700::_id_E1B4(var_0._id_7218, var_3, var_2);
  var_0._id_0E18 = var_4;
  var_4 _id_0700::_id_0E1D(var_2);
  var_4 thread scripts\engine\utility::_id_F126("death", ::_id_52B6);
  var_0 _id_A1FB();
  var_1 = var_0 _id_A1FC(1);
}

_id_52B6() {
  _id_0743::_id_E8BF("wave_paratroopers", 1);
}

_id_A1FB() {
  var_0 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].origin = self._id_0E18.origin;
  }

  waitframe();
}

_id_A1FC(var_0) {
  var_1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  var_2 = _id_66B4(scripts\cp\utility::_id_63BD(level.players));

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].origin = var_2[var_3];
    var_1[var_3]._id_AE1E = var_1[var_3].origin;

    if(istrue(var_0)) {
      if(getdvarint("#x3cd61bd9cfeb7c166", 0)) {
        thread scripts\cp\utility::_id_4F48(var_1[var_3].origin, 32, 60, (0, 1, 1));
      }
    }
  }

  return var_1[0];
}

_id_66B4(var_0) {
  var_1 = [];
  var_2 = 12;
  var_3 = 2048;
  var_4 = 360 / var_2;
  var_5 = var_0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_3;
    var_9 = sin(var_7) * var_3;
    var_10 = var_5[0] + var_8;
    var_11 = var_5[1] + var_9;
    var_12 = var_5[2];
    var_0 = _func_02AB((var_10, var_11, var_12));
    var_13 = scripts\engine\trace::_id_E409(var_5 + (0, 0, 48), var_0, 32, level.characters);

    if(isDefined(var_13) && isDefined(var_13["shape_position"])) {
      var_0 = var_13["shape_position"];
      var_0 = getgroundposition(var_0, 1, 1000, 1000);
      var_1[var_1.size] = var_0;
    }
  }

  return scripts\engine\utility::array_randomize(var_1);
}

_id_5E73(var_0) {
  var_0._id_10CB1 = 1;
  var_0._id_FF34 = [];
  var_0._id_FF34["lbravo_carrier"] = 500;
  var_0._id_FF34["mindia8"] = 500;
  var_0._id_FF34["mindia8_jugg"] = 500;
}

_id_C78C(var_0) {
  if(istrue(var_0._id_C6A3)) {
    return _id_0743::_id_C770(var_0);
  } else if(isDefined(var_0._id_C570) && var_0._id_C570.size > 0) {
    var_1 = [];

    for(var_2 = 0; var_2 < var_0._id_C570.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_0._id_C570[var_2], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_3);
    }

    if(var_1.size > 0) {
      return var_1;
    } else if(istrue(var_0._id_10CB1)) {
      return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
    }
  } else if(istrue(var_0._id_10CB1))
    return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
  else {
    return [];
  }
}

_id_10CA9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("wave_spawn");
  var_0 endon("wave_spawn");

  if(isDefined(var_0._id_AE51) && var_0._id_AE51 > 0) {
    var_0._id_AE51--;
    _id_0743::_id_C9FD("wave_paratroopers");
  }

  if(isDefined(var_0._id_10C90) && var_0._id_10C90 > 0) {
    var_0._id_10C90--;
    var_7 = spawnStruct();
    var_7.streakname = "precision_airstrike";

    if(!isDefined(var_7._id_DA63)) {
      var_7._id_DA63 = 0;
    }

    var_8 = scripts\cp\utility::_id_636E();

    if(var_8.size > 0) {
      var_9 = scripts\engine\utility::random(var_8);
      var_7.owner = var_9;
      var_10 = level._id_CC31[var_7.streakname]["airstrike_flyby"];
    }
  }

  var_1 = _id_0743::_id_4633(var_1, _id_0743::_id_663F());
  var_2 = _id_0743::_id_4633(var_2, _id_0743::_id_663C());
  var_3 = _id_0743::_id_4633(var_3, 0.1);
  var_11 = var_0 _id_0762::_id_676C(["wave_spawning", "wave_paratroopers"]);
  var_12 = var_0 _id_0743::_id_62F8();
  var_4 = _id_0743::_id_663E(var_0, var_4);
  var_5 = _id_0743::_id_663D(var_0, var_5);
  _id_072D::_id_10C94(self._id_10C93);

  if(isDefined(var_4) && isDefined(var_5)) {
    if(istrue(var_0._id_E8F8)) {
      _id_0743::_id_F2C1(var_0._id_7218, 1, "end_wave");
      _id_0743::_id_F2C1("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
    } else if(var_11 < var_0._id_E24A) {
      if(var_12 >= var_5) {
        _id_0743::_id_C9CE(var_0._id_7218, [_id_0743::_id_33CA, "wait_4_count: " + var_4]);
        _id_0743::_id_C9CE("wave_paratroopers", [_id_0743::_id_33CA, "wait_4_count: " + var_4]);
        var_0 _id_0743::_id_7223(var_4);
        return var_3;
      } else {
        _id_0743::_id_C9CE(var_0._id_7218, [_id_0743::_id_33CA, "spawning"]);
        _id_0743::_id_C9CE("wave_paratroopers", [_id_0743::_id_33CA, "spawning"]);
        return var_3;
      }
    } else {
      _id_0743::_id_F2C1(var_0._id_7218, 1, "end_wave");
      _id_0743::_id_F2C1("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
    }
  } else if(isDefined(var_0._id_E24A) && isDefined(var_11) && var_11 >= var_0._id_E24A) {
    _id_0743::_id_F2C1(var_0._id_7218, 1, "end_wave");
    _id_0743::_id_F2C1("wave_paratroopers", 1, "end_wave");
    var_0 waittill("wave_delay_over");
  } else
    return var_3;
}

_id_10CAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("wave_spawn");
  var_0 endon("wave_spawn");

  while(getdvarint("#x3c86f9a2b5ed754e", 0)) {
    wait 1;
  }

  var_1 = _id_0743::_id_4633(var_1, _id_0743::_id_663F());
  var_2 = _id_0743::_id_4633(var_2, _id_0743::_id_663C());
  var_3 = _id_0743::_id_4633(var_3, 0.1);
  var_7 = var_0 _id_0762::_id_676C(["wave_spawning", "wave_paratroopers"]);
  var_8 = var_0 _id_0743::_id_62F8();
  var_4 = _id_0743::_id_663E(var_0, var_4);
  var_5 = _id_0743::_id_663D(var_0, var_5);
  _id_072D::_id_10C94(self._id_10C93);

  if(isDefined(var_4) && isDefined(var_5)) {
    var_9 = var_0 _id_0743::_id_6342();

    if(istrue(var_0._id_FDEC) && (!isDefined(var_9) || var_9.size < 1)) {
      _id_0743::_id_C9CE(var_0._id_7218, ::_id_FA45);
    }

    if(istrue(var_0._id_E8F8)) {
      _id_0743::_id_F2C1(var_0._id_7218, 1, "end_wave");
      _id_0743::_id_F2C1("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
    } else if(var_8 >= var_5) {
      if(var_7 < var_0._id_E24A) {
        _id_0743::_id_C9CE(var_0._id_7218, [_id_0743::_id_33CA, "wait_4_count: " + var_4]);
        _id_0743::_id_C9CE("wave_paratroopers", [_id_0743::_id_33CA, "wait_4_count: " + var_4]);
        var_0 _id_0743::_id_7223(var_4);
        return var_3;
      } else {
        _id_0743::_id_F2C1(var_0._id_7218, 1, "end_wave");
        _id_0743::_id_F2C1("wave_paratroopers", 1, "end_wave");
        var_0 waittill("wave_delay_over");
      }
    } else {
      _id_0743::_id_C9CE(var_0._id_7218, [_id_0743::_id_33CA, "spawning"]);
      _id_0743::_id_C9CE("wave_paratroopers", [_id_0743::_id_33CA, "spawning"]);
      return var_3;
    }
  } else
    return var_3;
}

_id_FA45(var_0, var_1) {
  var_0._id_10CB1 = undefined;
  var_0._id_FDEC = undefined;
}

_id_C0F8() {
  return istrue(self._id_C0F8);
}

_id_7DC5(var_0) {
  var_1 = _id_0743::_id_642D();

  if(isDefined(var_1)) {
    _id_0743::_id_C5E6(self._id_7218);

    if(_func_0121(self._id_A48E) && self._id_A48E != "") {
      self._id_8F77 = self._id_A48E;
    } else if(isint(var_1)) {
      if(var_1 == self._id_8F76) {
        self._id_8F76++;
      } else {
        self._id_8F76 = var_1;
      }

      self._id_8F77 = self._id_8F76;
    } else
      self._id_8F77 = var_1;

    self._id_10CA5 = self._id_8F77;
    _id_0743::_id_D442(self._id_7218, self._id_10CA5, self._id_8F77, self._id_8F76);

    if(istrue(var_0)) {
      return;
    }
    foreach(var_3 in level.players) {
      _id_074E::_id_FBAB(var_3, self._id_8F76, level.players.size);
    }

    _id_E672();
  }
}

_id_AF66(var_0) {
  var_0 _id_0743::_id_33CA(undefined, "Module Paused");
  setomnvar("cp_wave_timer", 0);
}

_id_F99E(var_0) {
  var_0 _id_0743::_id_33CA(undefined, "Module Unpaused");
}

_id_4699(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  _id_0743::_id_D440(var_1);
}

_id_FB50(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else if(isDefined(self._id_71F4)) {
    var_1 = self._id_71F4;
  } else {
    return 0;
  }

  var_2 = var_1 _id_0743::_id_62F8();

  if(var_1 _id_0743::_id_871B() && !istrue(var_1._id_8CAA)) {
    _id_FB62(undefined, var_1);
  }

  if(!istrue(var_1._id_8CAA) && (istrue(var_1._id_E8F8) && var_2 < var_1._id_A486)) {
    _id_0743::_id_C9CE(var_1._id_7218, [_id_0743::_id_F2C3, 1]);
    level thread _id_0743::_id_10C96(var_1);
  }
}

_id_FB62(var_0, var_1) {
  if(isDefined(var_0)) {
    setomnvar("cp_enemies_remaining", var_0);
    level._id_10C95 = var_0;
  } else {
    var_2 = _id_0743::_id_65B4("wave_spawning");
    var_2 = scripts\engine\utility::array_combine(var_2, _id_0743::_id_65B4("wave_paratroopers"));
    var_1._id_F364 = var_1._id_F364 + 1;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(isDefined(var_2[var_4]._id_F364)) {
        var_3 = var_3 + var_2[var_4]._id_F364;
      }
    }

    var_3 = level._id_10C8E;
    var_0 = var_1._id_E24A - var_3;
    setomnvar("cp_enemies_remaining", var_0);
    level._id_10C95 = var_0;
  }
}

_id_FB4F(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_71F4)) {
      var_0 = self._id_71F4;
    } else {
      return 0;
    }
  }

  if(var_0 _id_0743::_id_871B() && var_0._id_F364 == 0) {
    _id_FB62(var_0._id_E24A, var_0);
  }
}