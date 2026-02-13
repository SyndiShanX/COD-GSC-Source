/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2039.gsc
*************************************************/

_id_7EB6(var_0) {
  if(!isDefined(level._id_11ED)) {
    level._id_11ED = [];
  }

  _id_80B8();
  var_1 = [];
  var_1["species"] = 3;
  var_1["traversal_unit_type"] = 4;
  var_1["body_model"] = 5;
  var_1["animclass"] = 6;
  var_1["health"] = 7;
  var_1["xp"] = 8;
  var_1["reward"] = 9;
  var_1["behaviorTree"] = 10;
  var_1["asm"] = 11;
  var_1["radius"] = 12;
  var_1["height"] = 13;
  var_1["legacy"] = 14;
  var_2 = 0;
  var_3 = 50;

  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_4, 2);

    if(var_5 == "") {
      break;
    }

    var_6 = [];

    foreach(var_11, var_8 in var_1) {
      var_9 = tablelookupbyrow(var_0, var_4, var_8);

      if(var_9 == "0") {
        var_9 = 0;
      } else if(int(var_9) != 0) {
        var_10 = var_9 + "";

        if(issubstr(var_10, ".")) {
          var_9 = float(var_9);
        } else {
          var_9 = int(var_9);
        }
      }

      var_6[var_11] = var_9;
    }

    level._id_11ED[var_5] = var_6;
  }

  level notify("scripted_agents_initialized");
}

_id_80B8() {
  level._id_11EB = [];
  level._id_1205 = 500;
}

_id_D790() {
  var_0 = level._id_11ED[self._id_1210];

  if(!isDefined(var_0["behaviorTree"]) || var_0["behaviorTree"] == "") {
    return;
  }
  _id_0017::_id_129C(var_0["behaviorTree"], var_0["asm"]);
}

_id_D8C6(var_0) {
  self._id_04F6 = var_0;
  self giveweapon(self._id_04F6);
  self setspawnweapon(self._id_04F6);
  self._id_00CC = weaponclipsize(self._id_04F6);
  self._id_034C = self._id_04F6;
  self._id_020A = _func_0375();
  self._id_0206 = 0;
}

_id_D823(var_0) {
  self._id_03E9 = var_0;
}

_id_E32A(var_0, var_1, var_2) {
  if(!scripts\engine\utility::string_starts_with(var_0, "actor_")) {
    var_0 = "actor_" + var_0;
  }

  if(!isDefined(level._id_11ED[var_0])) {
    return undefined;
  }

  var_3 = _id_E329(var_0, level._id_11ED[var_0]["team"], var_1, var_2);
  return var_3;
}

_id_E329(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_6A56(var_0);

  if(isDefined(var_6)) {
    if(!isDefined(var_3)) {
      var_3 = (0, 0, 0);
    }

    var_6._id_3B86 = gettime();

    if(isDefined(var_5)) {
      var_6 _id_D823(var_5);
    }

    if(!isDefined(var_1)) {
      var_1 = "axis";
    }

    var_6 _id_D136(var_1);
    var_6 _id_D133(var_6, var_0);
    var_6 _id_D135(var_6, var_0);

    if(_id_86AE(var_0)) {
      var_6 = _id_E1EB(var_6, var_0, var_2, var_3);
    } else {
      var_6 = _id_E1D6(var_6, var_2, var_3);
    }

    var_6 _id_D136(var_1);
    var_6 _id_D74B(var_0);
    var_6 _id_D134(var_6, var_0);
    var_6 _id_D137(var_6, var_0);
    var_6 _id_1033();

    if(_id_86FB(var_0)) {
      var_6 _id_D790();
    }

    if(isDefined(var_4)) {
      if(isweapon(var_4)) {
        var_6 _id_D8C6(var_4);
      } else {
        return undefined;
      }
    }

    var_6 _id_0EE4();
    var_6 scripts\engine\utility::_id_D13A();
  }

  return var_6;
}

_id_10A69() {
  self endon("death");

  for(;;) {
    if(!isDefined(self.team)) {
      level notify("agent_missing_team");
    }

    waitframe();
  }
}

_id_D137(var_0, var_1) {
  if(!_id_30F8(var_0)) {
    return;
  }
  if(!isDefined(anim._id_18D7)) {
    scripts\anim\animselector::init();
  }

  var_0._id_04B9 = level._id_11ED[var_1]["traversal_unit_type"];
}

_id_30F8(var_0) {
  if(_id_8548(var_0)) {
    return 1;
  }

  return 0;
}

_id_D133(var_0, var_1) {
  var_2 = level._id_11ED[var_1]["setup_model_func"];

  if(isDefined(var_2)) {
    var_0[[var_2]](var_1);
    return;
  }

  var_0 _meth_809E();
  var_0 setModel(level._id_11ED[var_1]["body_model"]);
  var_0 show();
}

_id_86AE(var_0) {
  return level._id_11ED[var_0]["animclass"] != "";
}

_id_86FB(var_0) {
  if(!isDefined(level._id_11ED[var_0])) {
    return 0;
  }

  return level._id_11ED[var_0]["behaviorTree"] != "";
}

_id_E1EB(var_0, var_1, var_2, var_3) {
  var_0._id_AAC5 = var_0 _id_E3DB("on_enter_animstate");
  var_0._id_86AE = 1;
  var_4 = level._id_11ED[var_1]["radius"];

  if(!isDefined(var_4)) {
    var_4 = 15;
  }

  var_5 = level._id_11ED[var_1]["height"];

  if(!isDefined(var_5)) {
    var_5 = 50;
  }

  var_6 = level._id_11ED[var_1]["legacy"];

  if(!isDefined(var_6) || _func_0121(var_6)) {
    var_6 = 0;
  }

  var_0 _meth_83D1(var_2, var_3, level._id_11ED[var_1]["animclass"], var_4, var_5, undefined, var_6);
  var_0._id_11F3 = var_5;
  var_0._id_1204 = var_4;
  var_0._id_91A3 = spawnStruct();
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

_id_11F1(var_0, var_1, var_2, var_3, var_4) {
  if(_id_8548(self)) {
    self _meth_8326(var_0);
  } else {
    self _meth_8058(var_0, var_1, var_2, var_3, var_4);
  }
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

_id_D135(var_0, var_1) {
  if(!isDefined(level._id_11EF[var_1])) {
    level._id_11EF[var_1] = [];
  }

  var_0._id_E3D8 = level._id_11ED[var_1]["species"];

  if(isDefined(var_0._id_E3D8) && !isDefined(level._id_E3D9[var_0._id_E3D8]) || !isDefined(level._id_E3D9[var_0._id_E3D8]["on_enter_animstate"])) {
    level._id_E3D9[var_0._id_E3D8] = [];
    level._id_E3D9[var_0._id_E3D8]["on_enter_animstate"] = ::_id_457B;
  }

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

_id_6305(var_0) {
  return var_0._id_1210;
}

_id_6A57() {
  if(!isDefined(level.agentarray)) {
    return 0;
  }

  var_0 = gettime();
  var_1 = 0;

  foreach(var_3 in level.agentarray) {
    if(!isDefined(var_3.isactive) || !var_3.isactive) {
      if(isDefined(var_3._id_10847) && var_3._id_10847) {
        continue;
      }
      var_4 = var_3 getentitynumber();

      if(isDefined(level._id_11EB) && isDefined(level._id_11EB[var_4]) && var_0 < level._id_11EB[var_4]) {
        continue;
      }
      var_1++;
    }
  }

  return var_1;
}

_id_6A56(var_0) {
  var_1 = undefined;
  var_2 = gettime();

  if(isDefined(level.agentarray)) {
    foreach(var_4 in level.agentarray) {
      if(!isDefined(var_4.isactive) || !var_4.isactive) {
        if(isDefined(var_4._id_10847) && var_4._id_10847) {
          continue;
        }
        var_5 = var_4 getentitynumber();

        if(isDefined(level._id_11EB) && isDefined(level._id_11EB[var_5]) && var_2 < level._id_11EB[var_5]) {
          continue;
        }
        if(isDefined(level._id_11EB) && isDefined(level._id_11EB[var_5])) {
          level._id_11EB[var_5] = undefined;
        }

        var_1 = var_4;
        var_1._id_1210 = var_0;
        var_1 _id_812C();
        var_1 notify("agent_in_use");
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
  self._id_8735 = 1;
  self._id_E393 = 0;
  self._id_5501 = self getentitynumber();
  self._id_120F = 0;
  self._id_11F0 = 0;
  self._id_002D = undefined;
  self._id_0229 = 0;
  self.ignoreme = 0;
  self _meth_809E();
  _id_826D();
}

_id_826D() {
  self.class = undefined;
  self._id_A25F = undefined;
  self._id_1FAF = undefined;
  self.guid = undefined;
  self.name = undefined;
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

  if(isDefined(level._id_60F1)) {
    self[[level._id_60F1]]();
  }
}

_id_D136(var_0, var_1) {
  self.team = var_0;
  self._id_002E = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

_id_1033() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

_id_1215(var_0) {
  return level._id_11EF[self._id_1210][var_0];
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

_id_458A(var_0, var_1, var_2) {}

_id_85D9(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 1;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return 1;
    }
  }

  return 0;
}

_id_4579(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_14 = undefined;

  if(isDefined(self._id_04B9) && isDefined(level._id_11EF[self._id_04B9])) {
    var_14 = level._id_11EF[self._id_04B9]["gametype_on_damaged"];
  }

  if(isDefined(var_14)) {
    [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  } else {
    var_14 = level._id_11EF[self._id_1210]["gametype_on_damaged"];

    if(isDefined(var_14)) {
      [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }

  if(_id_85D9(var_13, var_0)) {
    return;
  }
  if(istrue(var_13._id_1214)) {
    var_15 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
      var_15 = isDefined(var_12) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](var_12.basename);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleDamageFeedback")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleDamageFeedback")]](var_0, var_1, var_13, var_2, var_4, var_12, var_8, var_3, 0, 0, var_15);
      }
    }
  }

  if(isDefined(var_13._id_04B9) && isDefined(level._id_11EF[var_13._id_04B9]) && isDefined(level._id_11EF[var_13._id_04B9]["on_damaged_finished"])) {
    var_13[[level._id_11EF[var_13._id_04B9]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  } else {
    var_13[[level._id_11EF[var_13._id_1210]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  }
}

_id_457A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self.health;
  var_14 = var_5;
  self._id_42F2 = var_1;
  self._id_431D = var_6;
  self _meth_80F1(var_0, var_1, var_2, var_3, var_4, var_14, var_6, var_7, var_8, var_9, 0.0, var_11, var_12);

  if(self.health > 0 && self.health < var_13) {
    self notify("pain");
    _id_06BE::_id_CA69();
  }

  if(isalive(self)) {
    if(isDefined(self._id_04B9) && isDefined(level._id_11EF[self._id_04B9]) && isDefined(level._id_11EF[self._id_04B9]["gametype_on_damage_finished"])) {
      var_15 = level._id_11EF[self._id_04B9]["gametype_on_damage_finished"];

      if(isDefined(var_15)) {
        [[var_15]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
        return;
      }
    } else if(isDefined(self._id_1210)) {
      var_15 = level._id_11EF[self._id_1210]["gametype_on_damage_finished"];

      if(isDefined(var_15)) {
        [[var_15]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
      }
    }
  }
}

_id_457C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self._id_AA6C)) {
    self[[self._id_AA6C]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  } else {
    _id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  }

  if(isDefined(self._id_04B9) && isDefined(level._id_11EF[self._id_04B9]) && isDefined(level._id_11EF[self._id_04B9]["gametype_on_killed"])) {
    var_9 = level._id_11EF[self._id_04B9]["gametype_on_killed"];

    if(isDefined(var_9)) {
      [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  } else {
    var_9 = level._id_11EF[self._id_1210]["gametype_on_killed"];

    if(isDefined(var_9)) {
      [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }

  _id_4386();
}

_id_457B(var_0, var_1) {
  self._id_13E7 = var_1;

  switch (var_1) {
    case "traverse":
      self._id_4C08 = 1;
      _id_0AED::_id_4E87();
      self._id_4C08 = 0;
      break;
    default:
      break;
  }

  _id_3934();
}

_id_3934() {
  self._id_C0EF = [];
  self._id_430C = 0;
}

_id_4386() {
  var_0 = self getentitynumber();
  level._id_11EB[var_0] = gettime() + 500;
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
  self._id_E224 = gettime();
}

_id_1300(var_0, var_1) {
  if(var_0 != "MOD_CRUSH") {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    return 0;
  }

  return 1;
}

_id_AA46(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_1300(var_3, var_0);
  self _meth_85DD(self._id_1CB8);

  if(isDefined(self._id_43D5)) {
    var_8 = self._id_43D5;
  } else if(var_8 == 0) {
    var_8 = 500;
  }

  if(isDefined(self._id_5D6E)) {
    self[[self._id_5D6E]]();
  }

  if(isDefined(self._id_A546)) {
    return;
  }
  var_11 = self;
  self._id_25CA = self _meth_808C(var_8);

  if(isDefined(self._id_0B67._id_4206)) {
    if(isDefined(var_3) && var_3 == "MOD_FIRE") {
      self._id_BF49 = 0;
    }

    if(!istrue(self._id_0B67._id_84FC) || istrue(self._id_0B67._id_36F1._id_10083)) {
      if(var_10) {
        self._id_25CA _meth_8753(var_0);
      } else if(_id_DA8D(self)) {
        if(isDefined(self._id_BF52) && isDefined(self._id_BF53)) {
          self._id_25CA _meth_83E6(self._id_BF52, self._id_BF53);
        } else {
          _id_4C08(self._id_25CA);
        }
      } else
        thread _id_46E0(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
    } else {
      self._id_25CA _meth_80DB();

      if(istrue(self._id_0B67._id_36F1._id_9513)) {
        self._id_25CA _meth_820D(self._id_0B67._id_4206, self._id_0B67._id_36F1._id_DD6C, 0);
      } else {
        self._id_25CA _meth_820E(self._id_0B67._id_4206, self._id_0B67._id_36F1._id_DD6C);
      }

      if(isDefined(self._id_0B67._id_102F8)) {
        thread _id_46E0(self._id_25CA, var_6, var_4, var_0, var_3);
      } else {
        self._id_25CA thread _id_BF4F(self._id_0B67._id_4206);
      }
    }
  } else if(istrue(self._id_2D90)) {
    if(self _meth_86EE()) {
      var_12 = self _meth_8575("burn_to_death_by_molotov", 1);

      if(isDefined(var_12) && var_12 == "active") {
        self._id_25CA setscriptablepartstate("burn_to_death_by_molotov", "active");
        thread _id_FC1E(self._id_25CA);
        thread _id_46E0(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
      }
    }
  } else if(var_10)
    self._id_25CA _meth_8753(var_0);
  else if(_id_DA8D(self)) {
    if(isDefined(self._id_BF52) && isDefined(self._id_BF53)) {
      self._id_25CA _meth_83E6(self._id_BF52, self._id_BF53);
    } else {
      _id_4C08(self._id_25CA);
    }
  } else
    thread _id_46E0(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
}

_id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_AA46(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_BF4F(var_0) {
  self endon("entitydeleted");

  if(self _meth_81DF()) {
    return;
  }
  if(isDefined(var_0)) {
    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(var_0) || var_0 _id_06E9::_id_1011F()) {
        self unlink();
        self startragdoll();
        return;
      }

      waitframe();
    }
  }
}

_id_DA8D(var_0) {
  if(istrue(var_0._id_4C08)) {
    return 1;
  }

  if(istrue(var_0._id_01D0)) {
    return 1;
  }

  return 0;
}

_id_4C08(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_BF52) && isDefined(var_0._id_BF53)) {
    var_0 _meth_83E6(var_0._id_BF52, var_0._id_BF53);
    return;
  }

  var_1 = 10;
  var_2 = scripts\common\utility::_id_69C4(self.damagemod);

  if(isDefined(self.attacker) && isPlayer(self.attacker) && var_2 == "melee") {
    var_1 = 5;
  }

  var_3 = self._id_014E;

  if(var_2 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    var_3 = min(var_3, 300);
  }

  var_4 = var_1 * var_3;
  var_5 = max(0.3, self._id_0147[2]);
  var_6 = (self._id_0147[0], self._id_0147[1], var_5);

  if(isDefined(self._id_BF49)) {
    var_6 = var_6 * self._id_BF49;
  } else {
    var_6 = var_6 * var_4;
  }

  if(self._id_01D0) {
    var_6 = var_6 + self._id_0344 * 20 * 10;
  }

  if(isDefined(self._id_BF50)) {
    var_6 = var_6 + self._id_BF50 * 10;
  }

  var_7 = self._id_0148;

  if(isDefined(self._id_BF47) && var_7 == "none") {
    var_7 = self._id_BF47;
  }

  var_0 _meth_83E6(var_7, var_6);
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

  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 _meth_81DF()) {
    return;
  }
  var_6 = var_0 _meth_8121();

  if(_func_0335(var_6)) {
    var_10 = 0.35;
    var_11 = _func_00BB(var_6, "start_ragdoll");

    if(isDefined(var_11) && var_11.size > 0) {
      var_10 = var_11[0];
    } else {
      var_11 = _func_00BB(var_6, "vehicle_death_ragdoll");

      if(isDefined(var_11) && var_11.size > 0) {
        var_10 = var_11[0];
      }
    }

    var_12 = var_10 * _func_0079(var_6) - level._id_01E2 / 1000;

    if(var_12 > 0) {
      wait(var_12);
    }
  }

  self unlink();

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_BF52) && isDefined(var_0._id_BF53)) {
      var_0 _meth_83E6(var_0._id_BF52, var_0._id_BF53);
    } else {
      var_0 startragdoll();
    }
  }
}

_id_FC1E(var_0) {
  wait 0.7;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 _meth_8760("burntbody_male_cp", 1);
  var_0 dontinterpolate();
  wait 0.95;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("burn_to_death_by_molotov", "inactive");
}