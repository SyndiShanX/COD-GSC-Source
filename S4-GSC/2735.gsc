/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2735.gsc
*************************************************/

init() {
  level._id_1032B = spawnStruct();
  _id_7FB5();
  _id_7FFD();
  _id_7F4D();
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

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("death");
  var_14 = _id_09BF::_id_ADCA(var_1, self, var_2, var_5, var_4, var_0, var_6, var_7, var_10, var_11, undefined, var_3, var_12);
  var_14._id_79A8 = var_8;
  var_14._id_F21F = var_9;
  var_14._id_79B8 = var_13;
  _id_2F41(var_14);
}

_id_2F41(var_0) {
  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "worldspawn") {
    var_0.attacker = undefined;
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;
    } else if(isDefined(var_0.inflictor)) {
      if(isPlayer(var_0.inflictor)) {
        var_0.attacker = var_0.inflictor;
      } else {
        var_0.attacker = var_0.inflictor.owner;
      }
    } else
      var_0.attacker = undefined;
  }

  if(isDefined(level._id_7AAE)) {
    return;
  }
  if(isDefined(var_0.attacker) && !isDefined(_id_0A8B::_id_0DB6(var_0.attacker))) {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  if(var_0.damage <= 0) {
    return;
  }
  if(_id_DAA2(var_0)) {
    if(_id_5A42(self, var_0.attacker)) {
      return;
    }
  }

  var_1 = scripts\engine\utility::_id_8794(var_0._id_9CD6);

  if(var_1) {
    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && (!isDefined(var_0.inflictor) || var_0.inflictor == var_0.attacker)) {
      var_2 = var_0.attacker scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_2) && var_2 == self) {
        return;
      }
    }
  }

  var_3 = var_0.damage;
  var_4 = self._id_1031E;

  if(isDefined(var_4)) {
    var_5 = _id_66BF(var_4);

    if(isDefined(var_5)) {
      var_6 = self[[var_5]](var_0);

      if(!istrue(var_6)) {
        return;
      }
    }
  }

  if(_id_0A8B::_id_A5A7(var_0.attacker, var_0.objweapon, var_0.inflictor, var_0._id_9CD6)) {
    return;
  }
  if(var_0.damage <= 0) {
    return;
  }
  if(var_0._id_9CD6 == "MOD_MELEE") {
    if(isDefined(var_4) && var_4 == "radar_drone_recon") {} else
      var_0.damage = 0;
  } else if(var_0._id_9CD6 == "MOD_IMPACT") {
    if(isDefined(var_0.inflictor) && isai(var_0.inflictor) && isDefined(var_0.inflictor._id_04B9) && var_0.inflictor._id_04B9 == "zombie") {} else
      var_0.damage = 0;
  } else if((_func_010F(var_0._id_9CD6) || var_0._id_9CD6 == "MOD_FIRE") && var_0._id_9CD6 != "MOD_PROJECTILE_SPLASH") {
    if(isDefined(var_4)) {
      var_0.damage = _id_64EC(var_0.damage, self, var_0.objweapon);
    }
  } else if(var_1) {
    if(_id_07C3::_id_8A5B(var_0.objweapon)) {
      var_0.damage = _id_07C3::_id_E44B(self, var_0.attacker, var_0.objweapon, var_0.damage, var_0._id_7C97);
    } else if(_id_07C3::_id_87DC(var_0.objweapon)) {
      if(_id_07C3::_id_DB1A(var_0.objweapon)) {
        var_0.damage = 1;
      } else {
        var_0.damage = 0;
      }
    } else if(isDefined(var_4))
      var_0.damage = _id_65AC(var_0.damage, self, var_0.objweapon, var_0.attacker);
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_1005B(self, var_0);

  if(isDefined(var_4)) {
    var_7 = _id_66B8(var_4);

    if(isDefined(var_7)) {
      var_6 = self[[var_7]](var_0);

      if(!istrue(var_6)) {
        return;
      }
    }
  }

  var_8 = scripts\cp_mp\vehicles\vehicle_damage::_id_10078(var_0);

  if(!var_8) {
    var_9 = scripts\cp_mp\vehicles\vehicle_damage::_id_10046();

    if(isDefined(var_9) && var_9 == "heavy") {
      var_10 = scripts\engine\utility::ter_op(_func_010F(var_0._id_9CD6) || var_0._id_9CD6 == "MOD_FIRE", 0.15, 0.25);
      var_0.damage = var_0.damage * var_10;
    }
  }

  if(isDefined(var_0.objweapon) && var_0.objweapon.basename != "none") {
    var_0.damage = var_0.damage * _func_0490(var_0.objweapon);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::_id_1007A(var_0, 1);
  } else {
    scripts\cp_mp\vehicles\vehicle_damage::_id_10079(var_0, var_8, 1);
  }

  _id_09CA::_id_10392(self, var_0);

  if(var_0.damage <= 0) {
    return;
  }
  if(istrue(level._id_10308)) {
    var_0.damage = 0;
  }

  _id_0A8B::_id_A5A5(var_0);
  var_11 = var_0.damage;
  var_12 = 1 - max(var_3 - var_11, 0) / var_3;
  var_13 = "hitequip";
  var_14 = var_0.damage >= self.health;
  var_15 = istrue(var_0._id_89EE) || istrue(var_0._id_8A33);

  if(var_15 && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "pac_sentry_turret_mp":
        break;
      case "lighttank_tur_mp":
      case "lighttank_tur_ks_mp":
      case "s4_tank_tur_mp":
        if(isDefined(var_0._id_9CD6) && var_0._id_9CD6 != "MOD_RIFLE_BULLET") {
          var_0.attacker thread _id_0A9F::_id_700C("critical_vehicle_damage");
        }

        break;
      default:
        var_0.attacker thread _id_0A9F::_id_700C("critical_vehicle_damage");
        break;
    }
  }

  if(isDefined(var_0.attacker)) {
    var_0.attacker _id_07C4::_id_FC47("hitequip", var_14, var_15, var_13, undefined, 1, var_0._id_79B8);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_10208(var_0);

  if(var_14) {
    if(isDefined(self._id_43DB)) {
      self thread[[self._id_43DB]](var_0.inflictor, var_0.attacker, var_0.damage, var_0._id_7C97, var_0._id_9CD6, var_0.objweapon, var_0.point, var_0._id_49C1, var_0._id_79A8, var_0._id_F21F, var_0._id_9FDA, var_0._id_031A);
    } else if(isDefined(level._id_1032B) && isDefined(level._id_1032B._id_43DB)) {
      self thread[[level._id_1032B._id_43DB]](var_0);
    } else {
      self _meth_842C(var_0.inflictor, var_0.attacker, int(var_0.damage), var_0._id_7C97, var_0._id_9CD6, var_0.objweapon, var_0.point, var_0._id_49CA, var_0._id_79A8, var_0._id_F21F, var_0.modelname, var_0._id_031A);
    }

    return;
  }

  var_16 = "";

  switch (var_0._id_031A) {
    case "tag_wheel_center_front_left":
      var_16 = "blowUpTire0";
      break;
    case "tag_wheel_center_front_right":
      var_16 = "blowUpTire1";
      break;
    case "tag_wheel_center_back_left":
      var_16 = "blowUpTire2";
      break;
    case "tag_wheel_center_back_right":
      var_16 = "blowUpTire3";
      break;
  }

  if(self _meth_8679(var_16)) {
    if(self _meth_867A(var_16, "blowUp")) {
      self setscriptablepartstate(var_16, "blowUp", 1);
    }
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
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  _id_0A8B::_id_A5A2();
  _id_07CE::_id_10316(var_0);
}

_id_5A42(var_0, var_1, var_2) {
  if(!isDefined(var_1) && !isDefined(var_2)) {
    return 0;
  }

  if(scripts\cp_mp\vehicles\vehicle_damage::_id_10053(var_0)) {
    if(isDefined(var_1) && isDefined(var_0.owner) && var_1 == var_0.owner) {
      return 0;
    }
  }

  var_3 = istrue(level._id_10306) || 0;

  if(level.teambased) {
    if(!var_3) {
      if(isDefined(var_2) && !isDefined(var_1)) {
        return scripts\cp_mp\vehicles\vehicle::_id_10125(var_0, var_2);
      } else {
        return scripts\cp_mp\vehicles\vehicle::_id_10124(var_0, var_1);
      }
    }

    return 0;
  } else {
    if(!var_3) {
      if(isDefined(var_1)) {
        return scripts\cp_mp\vehicles\vehicle::_id_10124(var_0, var_1);
      }

      return 0;
    }

    return 0;
  }
}

_id_DAA2(var_0) {
  if(isDefined(var_0.objweapon)) {
    var_1 = undefined;

    if(_func_0121(var_0.objweapon)) {
      var_1 = var_0.objweapon;
    } else {
      var_1 = var_0.objweapon.basename;
    }

    if(var_1 == "s4_v2_mp") {
      return 0;
    }
  }

  return 1;
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
  return _func_0037(var_0 * var_4);
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
        var_16 = scripts\mp\utility\weapon::_id_1DA5(var_16);
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