/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1790.gsc
*************************************************/

_id_E329(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_6A56(var_0);

  if(isDefined(var_5)) {
    var_5._id_3B86 = gettime();
    var_5 _id_D133(var_5, var_0);
    var_5 _id_D135(var_5, var_0);
    var_5 _id_E3DA();

    if(_id_86AE(var_0)) {
      var_5 = _id_E1EB(var_5, var_0, var_2, var_3);
    } else {
      var_5 = _id_E1D6(var_5, var_2, var_3);
    }

    var_5 _id_D74B(var_0);
    var_5 _id_D136(var_1);
    var_5 _id_D134(var_5, var_0);
    var_5 _id_D137(var_5, var_0);
    var_5 _id_115A();
    var_5 _id_0EE4();
  }

  return var_5;
}

_id_D133(var_0, var_1) {
  var_0 _meth_809E();

  if(isDefined(level._id_11062) && level._id_11ED[var_1]["traversal_unit_type"] == "zombie") {
    var_0[[level._id_11062]](var_1);
  } else {
    var_0 setModel(level._id_11ED[var_1]["body_model"]);
    var_2 = strtok(level._id_11ED[var_1]["other_body_parts"], " ");

    foreach(var_4 in var_2) {
      var_0 attach(var_4, "", 1);
    }
  }

  var_0 show();
}

_id_86AE(var_0) {
  return level._id_11ED[var_0]["animclass"] != "";
}

_id_E1EB(var_0, var_1, var_2, var_3) {
  var_0._id_AAC5 = var_0 _id_E3DB("on_enter_animstate");
  var_0._id_86AE = 1;
  var_0 _meth_83D1(var_2, var_3, level._id_11ED[var_1]["animclass"], 15, 60);
  return var_0;
}

_id_E1D6(var_0, var_1, var_2) {
  var_0._id_86AE = 0;
  var_0 _meth_83D1(var_1, var_2);
  return var_0;
}

_id_8548(var_0) {
  return var_0._id_86AE;
}

_id_8551() {
  return isagent(self) && isDefined(self._id_E3D8) && self._id_E3D8 == "alien";
}

_id_D74B(var_0) {
  var_1 = level._id_11ED[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1["setup_func"];

  if(!isDefined(var_2)) {
    return;
  }
  self[[var_2]]();
}

_id_11F1(var_0, var_1, var_2, var_3, var_4) {
  if(_id_8548(self)) {
    self _meth_8326(var_0);
  } else {
    self _meth_8058(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_D135(var_0, var_1) {
  if(!isDefined(level._id_11EF[var_1])) {
    level._id_11EF[var_1] = [];
  }

  var_0._id_E3D8 = level._id_11ED[var_1]["species"];
  _id_1CF0("spawn", ::_id_458A);
  _id_1CF0("on_damaged", ::_id_4579);
  _id_1CF0("on_damaged_finished", ::_id_457A);
  _id_1CF0("on_killed", ::_id_457C);
}

_id_1CF0(var_0, var_1) {
  var_2 = self._id_1210;

  if(!isDefined(level._id_11EF[var_2][var_0])) {
    if(!isDefined(level._id_E3D9[self._id_E3D8]) || !isDefined(level._id_E3D9[self._id_E3D8][var_0])) {
      level._id_11EF[var_2][var_0] = var_1;
    } else {
      level._id_11EF[var_2][var_0] = level._id_E3D9[self._id_E3D8][var_0];
    }
  }
}

_id_D134(var_0, var_1) {
  var_0 _id_D132(level._id_11ED[var_1]["health"]);
}

_id_D137(var_0, var_1) {
  if(!_id_30F8(var_0)) {
    return;
  }
  var_0 _meth_82C4(level._id_11ED[var_1]["traversal_unit_type"]);
}

_id_30F8(var_0) {
  if(_id_8548(var_0)) {
    return 1;
  }

  return 0;
}

_id_E3DA() {
  if(isDefined(level._id_E3D9[self._id_E3D8]) && isDefined(level._id_E3D9[self._id_E3D8]["pre_spawn_init"])) {
    self[[level._id_E3D9[self._id_E3D8]["pre_spawn_init"]]]();
  }
}

_id_6A56(var_0) {
  var_1 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var_3 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3._id_10847) && var_3._id_10847) {
          continue;
        }
        var_1 = var_3;
        var_1._id_1210 = var_0;
        var_1 _id_812C();
        break;
      }
    }
  }

  return var_1;
}

_id_812C() {
  self.pers = [];
  self._id_7552 = 0;
  self.isactive = 0;
  self._id_E393 = 0;
  self._id_5501 = self getentitynumber();
  self._id_11F0 = 0;
  self _meth_809E();
  _id_826D();
}

_id_826D() {
  self.class = undefined;
  self._id_A25F = undefined;
  self._id_1FAF = undefined;
  self.guid = undefined;
  self.name = undefined;
  self._id_CB42 = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self._id_A8EC = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  scripts\common\input_allow::_id_38B0("weapon");
  scripts\common\input_allow::_id_38B0("weaponSwitch");
  scripts\common\input_allow::_id_38B0("offhandWeaps");
  scripts\common\input_allow::_id_38B0("usability");
  self._id_A546 = undefined;
  self.ignoreme = 0;
  self._id_0229 = 0;
  self._id_F080 = undefined;
  self._id_3AD5 = undefined;
  self._id_417A = undefined;
  self._id_4C08 = undefined;
  self._id_30B9 = 0;
  self._id_1DC9 = undefined;
  self._id_54D1 = 0;
  self._id_9B33 = undefined;
  self._id_F4B9 = undefined;
  self._id_75BE = 0;
  self._id_4982 = 0;
  self._id_8873 = undefined;
  self._id_5D22 = undefined;
  self._id_2382 = undefined;
  self._id_DABE = undefined;
  self._id_86D9 = undefined;
  self._id_869D = undefined;
  self._id_857A = undefined;
}

_id_D136(var_0, var_1) {
  self.team = var_0;
  self._id_002E = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

_id_115A() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

_id_1215(var_0) {
  if(isDefined(self._id_04B9) && isDefined(level._id_11EF[self._id_04B9]) && isDefined(level._id_11EF[self._id_04B9][var_0])) {
    return level._id_11EF[self._id_04B9][var_0];
  } else {
    return level._id_11EF[self._id_1210][var_0];
  }
}

_id_E3DB(var_0) {
  return level._id_E3D9[self._id_E3D8][var_0];
}

_id_FF45(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

_id_D132(var_0) {
  self._id_002C = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}

_id_458A(var_0, var_1, var_2) {
  var_3 = _id_E329("soldier", "axis", var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3 _meth_8058(var_3.origin, 0, "hunt");
  var_3 _meth_805B("stand");
  var_3 takeallweapons();

  if(isDefined(var_2)) {
    var_3 giveweapon(var_2);
  } else {
    var_3 giveweapon("iw6_dlcweap02_mp");
  }

  var_3 _meth_8053("maxInaccuracy", 4.5);
  var_3 _meth_8053("minInaccuracy", 2.25);
  return var_3;
}

_id_4579(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(scripts\cp\utility::_id_85D9(var_12, var_0)) {
    return;
  }
  if(isPlayer(var_1) && !scripts\cp\utility::_id_86EC(var_0, var_5)) {
    var_2 = _id_071A::_id_CB77(var_1, var_2, var_4, var_5);
    var_2 = _id_071A::_id_CB79(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = _id_C872(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_2 = _id_071A::_id_CB78(var_1, var_2);
  var_2 = int(var_2);
  _id_BD49(var_1, var_2, var_4);
  _id_BD48(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_12[[level._id_11EF[var_12._id_1210]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

_id_C872(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_10._id_C874 = undefined;

  if(var_8 == "shield") {
    var_10._id_C874 = 1;
    var_2 = 0;
  }

  return var_2;
}

_id_BD49(var_0, var_1, var_2) {
  if(isDefined(level._id_FB35)) {
    [[level._id_FB35]](var_0, var_1, var_2);
  }
}

_id_457A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self _meth_80F1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  return 1;
}

_id_457C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  _id_4386();
}

_id_6BAB(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = _id_6882(var_0);
  return var_1.size;
}

_id_6882(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "all" || var_3._id_1210 == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_68A1(var_0) {
  var_1 = [];

  foreach(var_3 in level.agentarray) {
    if(isalive(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_6881(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3._id_E3D8 == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_68A0() {
  var_0 = [];

  foreach(var_2 in level.agentarray) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_0EE4() {
  self.isactive = 1;
}

_id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(self._id_75A6)) {
    scripts\cp\utility::_id_90FE(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread _id_4783();
        var_10.owner = self;
        var_10._id_ADAD = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(isDefined(self._id_A546)) {
    return;
  }
  var_11 = self;
  self._id_25CA = self _meth_808C(var_8);

  if(_id_DA8D(self)) {
    _id_4C08(self._id_25CA);
  } else {
    thread _id_46E0(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
  }

  _id_BD50(var_1, var_11, var_6, var_4, var_3);

  if(isDefined(level._id_FB76)) {
    [[level._id_FB76]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

_id_DA8D(var_0) {
  return istrue(var_0._id_4C08);
}

_id_4C08(var_0) {
  if(isDefined(var_0)) {
    var_0 startragdoll();
  }
}

_id_46E0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 _meth_8121();

    if(_func_0011(var_6, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level._id_A5BB) && level._id_A5BB.size) {
    foreach(var_8 in level._id_A5BB) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536) {
        return;
      }
    }
  }

  wait 0.2;

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 _meth_81DF()) {
    return;
  }
  var_6 = var_0 _meth_8121();
  var_10 = 0.35;

  if(_func_0011(var_6, "start_ragdoll")) {
    var_11 = _func_00BB(var_6, "start_ragdoll");

    if(isDefined(var_11)) {
      var_10 = var_11[0];
    }
  }

  var_12 = var_10 * _func_0079(var_6);
  wait(var_12);

  if(isDefined(var_0)) {
    var_0 startragdoll();
  }
}

_id_4783() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_BD48(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_071A::_id_FB52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_BD50(var_0, var_1, var_2, var_3, var_4) {
  _id_0759::_id_6ECC(var_0, var_2);
  var_5 = _id_6305(var_1);
  var_6 = scripts\cp\utility::_id_6376(var_0);

  if(isDefined(var_6)) {
    _id_074E::_id_C13B(var_3, var_2, var_4, var_6);

    if(isDefined(level._id_9855) && isDefined(var_5)) {
      [[level._id_9855]](var_5, self.origin, var_0);
    }
  }
}

_id_6884(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.team != var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_6322() {
  var_0 = _id_68A1("axis");
  var_1 = [];

  if(isDefined(level._id_4BC4)) {
    var_1 = [[level._id_4BC4]]();
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_0;
}

_id_6305(var_0) {
  return var_0._id_1210;
}

is_zm_normal() {
  if(scripts\engine\utility::is_equal(self.zm_ai_category, "normal")) {
    return 1;
  }

  return 0;
}

is_zm_special() {
  if(scripts\engine\utility::is_equal(self.zm_ai_category, "special")) {
    return 1;
  }

  return 0;
}

is_zm_elite() {
  if(scripts\engine\utility::is_equal(self.zm_ai_category, "elite")) {
    return 1;
  }

  return 0;
}

is_zm_boss() {
  if(scripts\engine\utility::is_equal(self.zm_ai_category, "boss")) {
    return 1;
  }

  return 0;
}

_id_E9B2(var_0, var_1) {
  var_0 = scripts\cp\utility::_id_6376(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_1DD0)) {
    self._id_1DD0 = [];
  }

  foreach(var_3 in self._id_1DD0) {
    if(var_3.player == var_0) {
      var_3.damage = var_3.damage + var_1;
      return;
    }
  }

  var_5 = spawnStruct();
  var_5.player = var_0;
  var_5.damage = var_1;
  self._id_1DD0[self._id_1DD0.size] = var_5;
}

_id_4386() {
  if(scripts\cp\utility::_id_8877(self)) {
    scripts\cp\utility::_id_C4B0();
  }

  scripts\cp\utility::_id_C4A7();
  scripts\cp\utility::_id_C4B5();
  self.isactive = 0;
  self._id_7552 = 0;
  self._id_9B2B = undefined;
  self._id_A1AA = undefined;
  self.owner = undefined;
  self._id_3B86 = undefined;
  self._id_10847 = undefined;
  self._id_8569 = undefined;
  self._id_85AF = undefined;
  self._id_EAA3 = undefined;
  self._id_0481 = undefined;
  self._id_039B = undefined;
  self._id_0398 = undefined;
  self._id_0399 = undefined;
  self.target = undefined;
  self._id_A363 = undefined;

  foreach(var_1 in level.characters) {
    if(isDefined(var_1._id_1DDE)) {
      foreach(var_4, var_3 in var_1._id_1DDE) {
        if(var_3 == self) {
          var_1._id_1DDE[var_4] = undefined;
        }
      }
    }
  }

  if(isDefined(self._id_7611)) {
    self._id_7611 = undefined;
  }

  _id_07F7::_id_4386();
  self notify("disconnect");
}

_id_7EB7() {
  level._id_121A = [];

  if(!isDefined(level._id_1219)) {
    return;
  }
  var_0 = level._id_1219;
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = spawnStruct();
    var_3.index = int(var_2);
    var_3._id_C189 = _func_0222(var_0, 0, var_2, 1);
    var_3._id_25E4 = _func_0222(var_0, 0, var_2, 2);
    var_3._id_7611 = _func_0222(var_0, 0, var_2, 3);
    level._id_121A[var_3._id_C189] = var_3;
    var_1++;
  }
}