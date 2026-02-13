/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2412.gsc
*************************************************/

init() {
  level._id_1032B = spawnStruct();
  level._id_5D4A = ::_id_ADCA;
  _id_7FB5();
  _id_7FFD();
  _id_7F4D();
  _id_7F6C();
}

_id_7F4D() {
  level._id_1032B._id_42E9 = ::_id_2F40;
  level._id_1032B._id_43DB = ::_id_2F42;
  var_0 = spawnStruct();
  var_0._id_BBB7 = [];
  var_0._id_BA54 = [];
  var_0._id_43DC = [];
  level._id_1032B._id_42EA = var_0;
}

_id_66BF(var_0) {
  return level._id_1032B._id_42EA._id_BBB7[var_0];
}

_id_66B8(var_0) {
  return level._id_1032B._id_42EA._id_BA54[var_0];
}

_id_643E(var_0) {
  return level._id_1032B._id_42EA._id_43DC[var_0];
}

_id_D35F(var_0, var_1) {
  level._id_1032B._id_42EA._id_BBB7[var_0] = var_1;
}

_id_D35C(var_0, var_1) {
  level._id_1032B._id_42EA._id_BA54[var_0] = var_1;
}

_id_D1AC(var_0, var_1) {
  level._id_1032B._id_42EA._id_43DC[var_0] = var_1;
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self endon("death");
  var_13 = _id_ADCA(var_1, self, var_2, var_5, var_4, var_0, var_6, var_7, var_10, var_11, undefined, var_3);
  var_13._id_79A8 = var_8;
  var_13._id_F21F = var_9;
  _id_2F41(var_13);
}

_id_2F41(var_0) {
  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "worldspawn") {
    var_0.attacker = undefined;
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) && !isagent(var_0.attacker) && !_func_0104(var_0.attacker)) {
    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;
    } else if(isDefined(var_0.inflictor)) {
      if(isPlayer(var_0.inflictor) || isagent(var_0.inflictor) || _func_0104(var_0.inflictor)) {
        var_0.attacker = var_0.inflictor;
      } else if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      } else {
        var_0.attacker = var_0.inflictor;
      }
    } else
      var_0.attacker = undefined;
  }

  if(isDefined(level._id_7AAE)) {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  if(istrue(self._id_852E)) {
    return;
  }
  if(var_0.damage <= 0) {
    return;
  }
  if(isDefined(var_0.attacker)) {
    if(isDefined(self._id_A924) && self._id_A924.size > 0) {
      if(scripts\engine\utility::array_contains(self._id_A924, var_0.attacker)) {
        if(isDefined(var_0.attacker.team)) {
          if(isDefined(self._id_EF74) && var_0.attacker.team == self._id_EF74) {
            return;
          }
        }
      }
    }
  }

  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.vehicle)) {
    if(!isDefined(var_0.attacker.team)) {
      if(isDefined(var_0.attacker.vehicle.team)) {
        var_0.attacker.team = var_0.attacker.vehicle.team;
      }
    }
  }

  var_1 = var_0.damage;
  var_2 = self._id_1031E;

  if(isDefined(var_2)) {
    var_3 = _id_66BF(var_2);

    if(isDefined(var_3)) {
      var_4 = self[[var_3]](var_0);

      if(!istrue(var_4)) {
        return;
      }
    }
  }

  if(var_0.damage <= 0) {
    return;
  }
  if(var_0._id_9CD6 == "MOD_MELEE") {
    var_0.damage = 0;
  } else if(var_0._id_9CD6 == "MOD_IMPACT") {
    var_0.damage = 0;
  } else if(_func_010F(var_0._id_9CD6)) {
    if(isDefined(var_2)) {
      var_0.damage = _id_64EC(var_0.damage, self, var_0.objweapon);
    }
  } else if(scripts\engine\utility::_id_8794(var_0._id_9CD6)) {
    if(_id_9CA5(self, var_0.attacker, var_0.objweapon)) {
      var_0.damage = 0;
    } else if(isDefined(var_2)) {
      var_0.damage = _id_65AC(var_0.damage, self, var_0.objweapon, var_0.attacker);
    }
  }

  if(isDefined(var_2)) {
    var_5 = _id_66B8(var_2);

    if(isDefined(var_5)) {
      var_4 = self[[var_5]](var_0);

      if(!istrue(var_4)) {
        return;
      }
    }
  }

  var_6 = scripts\cp_mp\vehicles\vehicle_damage::_id_10078(var_0);

  if(!var_6) {
    var_7 = scripts\cp_mp\vehicles\vehicle_damage::_id_10046();

    if(isDefined(var_7) && var_7 == "heavy") {
      var_8 = scripts\engine\utility::ter_op(_func_010F(var_0._id_9CD6) || var_0._id_9CD6 == "MOD_FIRE", 0.15, 0.25);
      var_0.damage = var_0.damage * var_8;
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_1007A(var_0, 1);
  _id_09CA::_id_10392(self, var_0);

  if(var_0.damage <= 0) {
    return;
  }
  if(isDefined(self._id_1031E) && self._id_1031E == "light_tank") {
    self notify("alerted", var_0);
  }

  var_9 = var_0.damage;
  var_10 = 1 - max(var_1 - var_9, 0) / var_1;
  var_11 = "standard";
  var_12 = var_0.damage >= self.health;

  if(isPlayer(var_0.attacker)) {
    var_0.attacker _id_071B::_id_FC47("hitcritical", var_12, undefined, var_11, undefined, 1);
    _id_06FC::_id_108F(self, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.damage, var_0.point, var_0._id_49CA, var_0._id_79A8, var_0._id_F21F, var_0._id_9CD6);
  }

  if(isDefined(self._id_A924)) {
    var_13 = int(clamp((self.health - var_0.damage) / self.maxhealth * 100, 0, 100));

    foreach(var_15 in self._id_A924) {
      var_15 setclientomnvar("ui_veh_health_percent", int(var_13));
      var_15 setclientomnvar("ui_veh_show_health", 1);
    }
  }

  if(var_12) {
    if(isPlayer(var_0.attacker)) {
      var_0.attacker thread _id_072A::_id_8D7A(undefined, self, var_0.objweapon, var_0._id_9CD6, var_0.inflictor, 0);
    }

    if(isDefined(self._id_43DB)) {
      self thread[[self._id_43DB]](var_0.inflictor, var_0.attacker, var_0.damage, var_0._id_7C97, var_0._id_9CD6, var_0.objweapon, var_0.point, var_0._id_49C1, var_0._id_79A8, var_0._id_F21F, var_0._id_9FDA, var_0._id_031A);
    } else if(isDefined(level._id_1032B) && isDefined(level._id_1032B._id_43DB)) {
      self thread[[level._id_1032B._id_43DB]](var_0);
    } else {
      self _meth_842C(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0._id_7C97, var_0._id_9CD6, var_0.objweapon, var_0.point, var_0._id_49CA, var_0._id_79A8, var_0._id_F21F, var_0.modelname, var_0._id_031A);
    }

    return;
  }

  self _meth_842C(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0._id_4304, var_0._id_9CD6, var_0.objweapon, var_0.point, var_0._id_49CA, var_0._id_79A8, var_0._id_F21F, var_0.modelname, var_0._id_031A);
}

_id_2F42(var_0) {
  var_1 = self._id_1031E;

  if(isDefined(var_1)) {
    var_2 = _id_643E(var_1);

    if(isDefined(var_2)) {
      var_3 = gettime();
      var_4 = self[[var_2]](var_0);

      if(!istrue(var_4)) {
        return;
      }
    }
  }

  self.health = 0;
  self setCanDamage(0);
  _id_A5A2();
  self notify("death");
}

_id_7FFD() {
  var_0 = spawnStruct();
  level._id_1032B._id_9FC6 = var_0;
  var_0._id_1032B = [];
  var_0._id_10D6C = [];
  var_0.perks = [];
  var_0._id_0070 = [];
}

_id_65AC(var_0, var_1, var_2, var_3) {
  var_4 = _id_65AD(var_1, var_2, var_3);
  return var_0 * var_4;
}

_id_65AD(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;
  var_5 = var_0._id_1031E;
  var_6 = _id_6817(var_0._id_1031E);

  if(isDefined(var_6)) {
    var_7 = var_1.classname;
    var_8 = _id_6839(var_7);

    if(isDefined(var_8)) {
      var_9 = var_6._id_10D6B[var_7];

      if(isDefined(var_9)) {
        var_8 = var_9;
      }

      if(var_8._id_02D0 != 0) {
        if(var_8._id_893C) {
          var_4 = var_4 * var_8._id_02D0;
        } else {
          var_3 = var_3 + var_8._id_02D0;
        }
      }
    }

    if(isDefined(var_2) && isDefined(var_2.perks)) {
      foreach(var_14, var_11 in var_2.perks) {
        var_12 = _id_6654(var_14);

        if(isDefined(var_12)) {
          var_13 = var_6._id_AFC9[var_14];

          if(isDefined(var_13)) {
            var_12 = var_13;
          }

          if(var_12._id_02D0 != 0) {
            if(var_12._id_893C) {
              var_4 = var_4 * var_12._id_02D0;
            } else {
              var_3 = var_3 + var_12._id_02D0;
            }
          }
        }
      }
    }

    if(isDefined(var_1._id_0070)) {
      foreach(var_16 in var_1._id_0070) {
        var_16 = scripts\cp\utility::_id_1DA5(var_16);
        var_17 = _id_6375(var_16);

        if(isDefined(var_17)) {
          var_18 = var_6._id_1D92[var_16];

          if(isDefined(var_18)) {
            var_17 = var_18;
          }

          if(var_17._id_02D0 != 0) {
            if(var_17._id_893C) {
              var_4 = var_4 * var_17._id_02D0;
            } else {
              var_3 = var_3 + var_17._id_02D0;
            }
          }
        }
      }
    }
  }

  return var_3 + var_4;
}

_id_6817(var_0, var_1) {
  var_2 = level._id_1032B._id_9FC6._id_1032B[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2._id_10D6B = [];
    var_2._id_AFC9 = [];
    var_2._id_1D92 = [];
    level._id_1032B._id_9FC6._id_1032B[var_0] = var_2;
  }

  return var_2;
}

_id_6839(var_0, var_1) {
  var_2 = level._id_1032B._id_9FC6._id_10D6C[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = _id_3F44();
    level._id_1032B._id_9FC6._id_10D6C[var_0] = var_2;
  }

  return var_2;
}

_id_6654(var_0, var_1) {
  var_2 = level._id_1032B._id_9FC6.perks[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = _id_3F44();
    level._id_1032B._id_9FC6.perks[var_0] = var_2;
  }

  return var_2;
}

_id_6375(var_0, var_1) {
  var_2 = level._id_1032B._id_9FC6._id_0070[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = _id_3F44();
    level._id_1032B._id_9FC6._id_0070[var_0] = var_2;
  }

  return var_2;
}

_id_D444(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = _id_6839(var_0, 1);
  var_3._id_02D0 = var_1;
  var_3._id_893C = var_2;
}

_id_D445(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = _id_6817(var_3, 1);
  _id_6839(var_0, 1);
  var_5 = var_4._id_10D6B[var_0];

  if(!isDefined(var_5)) {
    var_5 = _id_3F44();
  }

  var_5._id_02D0 = var_1;
  var_5._id_893C = var_2;
  var_4._id_10D6B[var_0] = var_5;
}

_id_D30A(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = _id_6654(var_0, 1);
  var_3._id_02D0 = var_1;
  var_3._id_893C = var_2;
}

_id_D30B(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = _id_6817(var_3, 1);
  _id_6654(var_0, 1);
  var_5 = var_4._id_AFC9[var_0];

  if(!isDefined(var_5)) {
    var_5 = _id_3F44();
  }

  var_5._id_02D0 = var_1;
  var_5._id_893C = var_2;
  var_4._id_AFC9[var_0] = var_5;
}

_id_D167(var_0, var_1, var_2) {
  if(var_2) {}

  var_3 = _id_6375(var_0, 1);
  var_3._id_02D0 = var_1;
  var_3._id_893C = var_2;
}

_id_D168(var_0, var_1, var_2, var_3) {
  if(var_2) {}

  var_4 = _id_6817(var_3, 1);
  _id_6375(var_0, 1);
  var_5 = var_4._id_1D92[var_0];

  if(!isDefined(var_5)) {
    var_5 = _id_3F44();
  }

  var_5._id_02D0 = var_1;
  var_5._id_893C = var_2;
  var_4._id_1D92[var_0] = var_5;
}

_id_3F44() {
  var_0 = spawnStruct();
  var_0._id_02D0 = 0;
  var_0._id_893C = 0;
  return var_0;
}

_id_7FB5() {
  var_0 = spawnStruct();
  level._id_1032B._id_79A4 = var_0;
  var_0._id_1032B = [];
  var_0.weapons = [];
}

_id_64EC(var_0, var_1, var_2) {
  var_3 = var_1._id_1031E;
  var_4 = var_2.basename;
  var_5 = _id_6814(var_3);
  var_6 = _id_683B(var_4);

  if(isDefined(var_5) && isDefined(var_6)) {
    var_7 = var_6._id_1030D[var_3];

    if(!isDefined(var_7) || var_7 == 0) {
      var_7 = var_5._id_79C0;
    }

    var_8 = var_5._id_10DA0[var_4];

    if(!isDefined(var_8) || var_8 == 0) {
      var_8 = var_6._id_79BA;
    }

    if(var_7 > 0 && var_8 > 0) {
      var_9 = var_8 / var_7;
      var_0 = int(_func_0037(var_9 * var_1.maxhealth));
    }
  }

  return var_0;
}

_id_6814(var_0, var_1) {
  var_2 = level._id_1032B._id_79A4._id_1032B[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2._id_C189 = var_0;
    var_2._id_79C0 = 0;
    var_2._id_10DA0 = [];
    level._id_1032B._id_79A4._id_1032B[var_0] = var_2;
  }

  return var_2;
}

_id_683B(var_0, var_1) {
  var_2 = level._id_1032B._id_79A4.weapons[var_0];

  if(!isDefined(var_2) && istrue(var_1)) {
    var_2 = spawnStruct();
    var_2._id_C189 = var_0;
    var_2._id_79BA = 0;
    var_2._id_1030D = [];
    level._id_1032B._id_79A4.weapons[var_0] = var_2;
  }

  return var_2;
}

_id_D42B(var_0, var_1) {
  var_2 = _id_6814(var_0, 1);
  var_2._id_79C0 = var_1;
}

_id_D42C(var_0, var_1, var_2) {
  var_3 = _id_6814(var_0, 1);
  var_4 = _id_683B(var_2, 1);
  var_4._id_1030D[var_0] = var_1;
}

_id_D446(var_0, var_1) {
  var_2 = _id_683B(var_0, 1);
  var_2._id_79BA = var_1;
}

_id_D447(var_0, var_1, var_2) {
  var_3 = _id_683B(var_0, 1);
  var_4 = _id_6814(var_2, 1);
  var_4._id_10DA0[var_0] = var_1;
}

_id_7F6C() {
  var_0 = spawnStruct();
  level._id_1032B._id_5192 = var_0;
  var_0._id_2F52 = [];
}

_id_5180(var_0) {
  var_1 = var_0._id_103C2;
  var_1 endon("death");
  var_0._id_5193 = 1;
  var_1 thread _id_2F41(var_0);
  var_2 = _id_646D(var_1._id_1031E);

  if(isDefined(var_2)) {
    thread[[var_2]](var_0);
  }
}

_id_646D(var_0) {
  if(!isDefined(level._id_1032B)) {
    return undefined;
  } else if(!isDefined(level._id_1032B._id_5192)) {
    return undefined;
  }

  return level._id_1032B._id_5192._id_2F52[var_0];
}

_id_D1EA(var_0, var_1) {
  if(!isDefined(level._id_1032B)) {
    return undefined;
  } else if(!isDefined(level._id_1032B._id_5192)) {
    return undefined;
  }

  level._id_1032B._id_5192._id_2F52[var_0] = var_1;
  return;
}

_id_0DB6(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

_id_A5A2() {
  self._id_1DD4 = undefined;
}

_id_9CA5(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_0) && isDefined(var_2)) {
    var_4 = var_0 getentitynumber();
    var_5 = weaponclass(var_2) == "spread";

    if(!var_5) {
      return var_3;
    }

    var_6 = "" + gettime();
    var_7 = undefined;

    if(var_1 _meth_81BC()) {
      var_7 = 8;
    } else {
      var_7 = 4;
    }

    if(!isDefined(var_1._id_AF80) || !isDefined(var_1._id_AF80[var_6])) {
      var_1._id_AF80 = undefined;
      var_1._id_AF80[var_6] = [];
    }

    if(!isDefined(var_1._id_AF80[var_6][var_4])) {
      var_1._id_AF80[var_6][var_4] = 1;
    } else if(var_1._id_AF80[var_6][var_4] + 1 > var_7) {
      var_3 = 1;
    } else {
      var_1._id_AF80[var_6][var_4]++;
    }
  }

  return var_3;
}

_id_ADCA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = spawnStruct();

  if(isDefined(var_0) && isent(var_0)) {
    var_12.attacker = var_0;
  }

  var_12._id_103C2 = var_1;
  var_12.damage = var_2;
  var_12.objweapon = var_3;
  var_12._id_9CD6 = var_4;
  var_12.inflictor = var_5;
  var_12.point = var_6;
  var_12._id_49CA = var_7;
  var_12.modelname = int(var_8);
  var_12._id_031A = var_9;
  var_12._id_79A8 = "none";
  var_12._id_F21F = 150;
  var_12._id_047C = var_10;
  var_12._id_7C97 = var_11;
  var_12._id_4304 = var_11;
  var_12.attacker._id_1D2B = 0;
  return var_12;
}