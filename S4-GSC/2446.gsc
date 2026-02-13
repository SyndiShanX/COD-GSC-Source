/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2446.gsc
*************************************************/

init() {
  _id_06CB::_id_AA65(::_id_C86D);
  level._effect["zm_field_upgrade_rof_ring"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_ring_of_fire.vfx");
}

_id_C86D() {
  scripts\engine\utility::_id_5473("zm_field_upgrade_in_use");
  level scripts\engine\utility::_id_5473("ring_of_fire_in_use");
  self._id_2043 = undefined;
  self._id_0DF0 = [];
}

_id_4C1C() {
  scripts\engine\utility::_id_5474("zm_field_upgrade_in_use");
  thread _id_C86A(15);
  return 1;
}

_id_C86A(var_0) {
  self endon("disconnect");
  self._id_2043 = 1;
  self._id_FF29 = self.origin;
  thread _id_3F65(undefined, 200);
  wait(var_0);
  self._id_2043 = undefined;
  scripts\engine\utility::_id_5470("zm_field_upgrade_in_use");
}

_id_4F25(var_0) {
  var_1 = (0, 0, 32);
  var_2 = var_0;
  var_3 = var_0 + var_1;

  while(isDefined(self._id_2043)) {
    wait 0.1;
  }
}

_id_54FD(var_0, var_1) {
  var_2 = var_0._id_A387 * var_0._id_A387;

  if(distance2dsquared(var_0.origin, var_1.origin) <= var_2 && abs(var_1.origin[2] - var_0.origin[2]) <= var_0._id_A37C) {
    return 1;
  }

  return 0;
}

_id_54FC(var_0) {
  if(_func_0107(level._id_0DF2) && isalive(var_0)) {
    foreach(var_2 in level._id_0DF2) {
      if(isDefined(var_2) && _id_54FD(var_2, var_0)) {
        return 1;
      }
    }
  }

  return 0;
}

entity_inside_players_ring_of_fire(var_0, var_1) {
  if(_func_0107(level._id_0DF2) && isPlayer(var_0) && isalive(var_1)) {
    foreach(var_3 in level._id_0DF2) {
      if(isDefined(var_3) && var_3.owner == var_0 && _id_54FD(var_3, var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_3F65(var_0, var_1) {
  var_2 = get_ring_of_fire_level();
  var_3 = scripts\common\utility::groundpos(self.origin);
  var_4 = scripts\cp\utility::_id_E190("tag_origin", var_3);
  var_4.owner = self;
  var_4._id_A387 = var_1;
  var_4._id_A37C = 32;
  var_4._id_2026 = var_2 >= 1;
  var_4._id_A38F = 0;
  var_4._id_A388 = 0.5;
  var_4._id_A376 = 2;
  var_4._id_A378 = 15;
  level._id_0DF2 = scripts\cp\utility::_id_459B(level._id_0DF2, []);
  level._id_0DF2 = scripts\cp\utility::_id_1B8C(level._id_0DF2, var_4);
  scripts\engine\utility::_id_5474("zm_field_upgrade_in_use");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("zm_field_upgrade_rof_ring"), var_4, "tag_origin");
  playsoundatpos(var_3, "zmb_fieldup_ringoffire_activate");
  var_4 playLoopSound("zmb_fieldup_ringoffire_flame_circ");
  var_5 = var_2 >= 2;
  var_6 = var_2 >= 3;
  var_7 = var_2 >= 4;
  var_4 thread _id_FBBE(var_5, var_6, var_7);

  for(var_8 = 0; var_8 <= var_4._id_A378; var_8 = var_8 + 1) {
    if(var_4._id_2026) {
      var_9 = undefined;

      if(isDefined(self)) {
        var_9 = _func_0071(var_4.origin, var_1);
        var_9 = _func_0204(var_9, var_4.origin);
      } else {
        var_9 = _func_0070(level._id_11056);
        var_9 = _func_0204(var_9, var_4.origin, undefined, 0, var_1);
      }

      foreach(var_11 in var_9) {
        if(isalive(var_11) && var_11.zm_ai_category == "normal" && _id_54FD(var_4, var_11)) {
          var_12 = var_11.maxhealth * var_4._id_A376 / 100.0;
          var_11 dodamage(var_12, var_11.origin, scripts\engine\utility::ter_op(_func_0458(self), undefined, self), var_4, "MOD_FIRE", "s4_ring_of_fire_zm", "none");
        }
      }
    }

    wait 1;
  }

  if(isPlayer(self)) {
    scripts\engine\utility::_id_5470("zm_field_upgrade_in_use");
  }

  level._id_0DF2 = scripts\engine\utility::array_remove(level._id_0DF2, var_4);
  var_4 stoploopsound("zmb_fieldup_ringoffire_flame_circ");
  stopFXOnTag(scripts\engine\utility::getfx("zm_field_upgrade_rof_ring"), var_4, "tag_origin");
  var_4 thread scripts\cp\utility::_id_46C7(0.5);
}

_id_FBBE(var_0, var_1, var_2) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 0);
  var_1 = scripts\cp\utility::_id_459B(var_1, 0);
  var_2 = scripts\cp\utility::_id_459B(var_2, 0);
  var_3 = var_1 || var_2;
  self.b_use_stock_ammo = var_0;
  self.b_charge_duration_while_inside = var_1;
  self.b_charge_damage_while_inside = var_2;
  var_4 = 0;

  if(var_3) {
    var_4 = 10;
    self.lastchargeupdate = gettime();
  }

  while(isDefined(self)) {
    foreach(var_6 in scripts\cp\utility::_id_6C5C()) {
      if(isDefined(var_6) && !_func_0107(var_6._id_0DF0)) {
        var_6._id_0DF0 = [];
      }

      if(isalive(var_6) && !scripts\cp\utility::_id_88B7(var_6._id_0DF0, self) && _id_54FD(self, var_6)) {
        if(!var_6._id_0DF0.size) {}

        var_6._id_0DF0 = scripts\engine\utility::array_add(var_6._id_0DF0, self);

        if(isDefined(self.owner) && self.owner == var_6) {
          var_6._id_C86C = 0;
        }

        continue;
      }

      if(scripts\cp\utility::_id_88B7(var_6._id_0DF0, self) && !_id_54FD(self, var_6)) {
        var_6._id_0DF0 = scripts\engine\utility::array_remove(var_6._id_0DF0, self);

        if(isDefined(self.owner) && self.owner == var_6) {
          var_6._id_C86C = undefined;
        }

        if(!var_6._id_0DF0.size) {}
      }
    }

    var_8 = _func_0070();

    foreach(var_10 in var_8) {
      if(!isalive(var_10)) {
        continue;
      }
      if(!var_10 _meth_8679("burning_ring_of_fire")) {
        continue;
      }
      if(!istrue(var_10._id_2038) && _id_54FC(var_10)) {
        var_10 setscriptablepartstate("burning_ring_of_fire", "active");
        var_10._id_2038 = 1;
        continue;
      }

      if(istrue(var_10._id_2038) && !_id_54FC(var_10)) {
        var_10 setscriptablepartstate("burning_ring_of_fire", "neutral");
        var_10._id_2038 = undefined;
      }
    }

    if(var_0) {
      var_12 = scripts\cp\utility::_id_636E();

      foreach(var_6 in var_12) {
        var_6._id_0DF0 = scripts\engine\utility::_id_1BD1(var_6._id_0DF0);

        if(var_6._id_0DF0.size) {
          if(!var_6 scripts\cp\utility::_hasperk("specialty_ammodrainsfromstockfirst")) {
            var_6 scripts\cp\utility::_id_6FC2("specialty_ammodrainsfromstockfirst");
          }

          continue;
        }

        if(var_6 scripts\cp\utility::_hasperk("specialty_ammodrainsfromstockfirst")) {
          var_6 scripts\cp\utility::_id_EDCE("specialty_ammodrainsfromstockfirst");
        }
      }
    }

    if(var_3) {
      var_15 = 0;

      foreach(var_6 in scripts\cp\utility::_id_636E()) {
        if(scripts\cp\utility::_id_88B7(var_6._id_0DF0, self)) {
          var_15 = 1;
          break;
        }
      }

      if(var_15) {
        var_18 = clamp(self._id_A38F / var_4 / 1000.0, 0, 1);

        if(istrue(var_2)) {
          self._id_A388 = scripts\engine\math::_id_91A9(0.5, 0.75, var_18);
        }

        if(istrue(var_1)) {
          self._id_A378 = scripts\engine\math::_id_91A9(15, 20, var_18);
        }

        var_19 = gettime() - self.lastchargeupdate;
        self._id_A38F = self._id_A38F + var_19;
      } else if(isDefined(self)) {
        self._id_A38F = 0;
        self._id_A376 = 2;
        self._id_A388 = 0.5;
        self._id_A378 = 15;
      }

      self.lastchargeupdate = gettime();
    }

    waitframe();
  }

  var_12 = scripts\cp\utility::_id_6C5C();

  foreach(var_6 in var_12) {
    var_6._id_0DF0 = scripts\engine\utility::_id_1BD1(var_6._id_0DF0);

    if(var_0 && !var_6._id_0DF0.size) {
      if(var_6 scripts\cp\utility::_hasperk("specialty_ammodrainsfromstockfirst")) {
        var_6 scripts\cp\utility::_id_EDCE("specialty_ammodrainsfromstockfirst");
      }
    }
  }

  var_8 = _func_0070();

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }
    if(istrue(var_10._id_2038)) {
      var_10 setscriptablepartstate("burning_ring_of_fire", "neutral");
      var_10._id_2038 = undefined;
    }
  }
}

_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_5.basename) && var_5.basename == "s4_ring_of_fire_zm") {
    return int(var_2);
  }

  if(isPlayer(var_1) && _func_0107(var_1._id_0DF0) && var_1._id_0DF0.size) {
    var_10 = 0;

    foreach(var_12 in var_1._id_0DF0) {
      if(isDefined(var_12._id_A388) && var_12._id_A388 > var_10) {
        var_10 = var_12._id_A388;
      }
    }

    var_2 = var_2 + var_2 * var_10;

    if(isDefined(self._id_A389)) {
      var_2 = var_2 * self._id_A389;
    }
  }

  return int(var_2);
}

get_ring_of_fire_level() {
  return self.super_level;
}