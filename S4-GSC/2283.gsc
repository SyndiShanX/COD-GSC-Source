/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2283.gsc
*************************************************/

_id_1108B(var_0) {
  self.zm_ai_category = "normal";
  self._id_D603 = _id_0B05::_id_D602;
  self._id_0321 = 0;
  self._id_0322 = 0;
  self._id_0047 = 0;
  self._id_0275 = 34;
  self._id_0377 = -31;
  self._id_04BE = -22;
  self._id_0185 = 26;
  anim._id_135E = 10;
  anim._id_135C = 4096;
  anim._id_135D = 45;
  anim._id_1351 = 20;
  self._id_DDAB = 0;
  self._id_11097 = 72;
  self._id_110A1 = 100;
  self._id_11098 = 100;
  self._id_4A83 = 1;
  self._id_CD7C = 1;
  self._id_A57F = 1;
  var_1 = undefined;

  if(self tagexists("j_sling_pivot")) {
    var_1 = "j_sling_pivot";
  } else {
    var_1 = "j_cosmetic_4";
  }

  _id_0B05::_id_D602("sprint");
  self.playereffects = [];
  level._id_11EF["actor_enemy_zombie_screamer_cp"]["on_damaged"] = ::onscreamerdamage;
  level._id_11EF["actor_enemy_zombie_screamer_cp"]["on_damaged_finished"] = ::_id_AB98;
  level._id_11EF["actor_enemy_zombie_screamer_cp"]["on_killed"] = ::_id_AB99;
  self _meth_8600(0, 32);
  thread _id_57AD();

  if(scripts\common\utility::iscp()) {
    scripts\engine\utility::delaythread(0.2, ::_id_257C, var_1);
  }

  self._id_A5AC = 1.0;
  self._id_4B40 = 0;
  self setscriptablepartstate("tell_trail", "tell_trail_on");
  self setscriptablepartstate("notetrack_handler", "active", 0);
  self _meth_84A8("zombietype", "screamer", 0.1);
  self.set_turned_func = ::set_turned;
  self.set_frozen_func = ::set_frozen;
  return anim._id_EACB;
}

_id_257C(var_0) {}

_id_57AD() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_3, var_4, var_3, var_3, var_3, var_3, var_5, var_3, var_3, var_3, var_6);

    if(scripts\engine\utility::is_equal(var_2, self)) {
      continue;
    }
    if(isDefined(var_4) && var_1 >= 100 && _func_010F(var_4) && !var_0) {
      var_0 = 1;
      self._id_0B67._id_8306 = 1;
      self._id_0B67.exploderequested = 1;

      if(istrue(self._id_992D)) {
        _id_06C5::_id_E8B9();
      }

      self _meth_81FA(self.origin, self._id_026E, self._id_026E, var_4);
    }
  }
}

_id_1108A() {
  if(isDefined(self._id_110A2)) {
    return self._id_110A2;
  }

  return self._id_0192;
}

_id_11088(var_0) {
  var_1 = var_0.origin - self.origin;

  if(_func_0135(var_1) < self._id_11097 * self._id_11097) {
    if(abs(var_1[2]) < self._id_11098) {
      if(self _meth_8067(var_0)) {
        return 1;
      }
    } else if(var_1[2] > 0 && var_1[2] < 200 && !isDefined(self._id_0323) && !self._id_0324) {
      if(self _meth_82CE(var_0, 1)) {
        return 1;
      }

      var_2 = (self.origin[0], self.origin[1], var_0.origin[2]);
      var_3 = scripts\engine\trace::_id_3EF6(1);

      if(scripts\engine\trace::ray_trace_passed(self.origin, var_2, var_3)) {
        return 1;
      }
    }
  }

  return 0;
}

zombiescreamer_shouldexplodedoor(var_0) {
  var_1 = scripts\aitypes\zombie_common\ai_util::get_door_in_path();

  if(isDefined(var_1)) {
    var_2 = self._id_11097 * self._id_11097;

    if(distancesquared(self.origin, var_1.origin) < var_2) {
      return anim._id_EACB;
    }
  }

  return anim._id_58E3;
}

zombiescreamer_shouldexplode(var_0) {
  var_1 = _id_1108A();

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  var_2 = self _meth_84A6(self._id_11097);

  if(_id_11088(var_1)) {
    self._id_0B67.exploderequested = 1;
  } else if(!istrue(self._id_11099)) {
    if(isDefined(self._id_0192) && var_1 != self._id_0192 && _id_11088(self._id_0192) && distancesquared(self._id_0192.origin, var_2) < self._id_110A1 * self._id_110A1) {
      return anim._id_EACB;
    } else {
      var_3 = undefined;
      var_4 = -1;
      var_5 = self _meth_84C2();

      if(isDefined(var_5)) {
        foreach(var_7 in var_5) {
          if(_id_11088(var_7) && distancesquared(var_7.origin, var_2) < self._id_110A1 * self._id_110A1) {
            var_8 = distancesquared(var_7.origin, self.origin);

            if(!isDefined(var_3) || var_8 < var_4) {
              var_3 = var_7;
              var_4 = var_8;
            }
          }
        }
      }

      if(isDefined(var_3)) {
        return anim._id_EACB;
      }
    }
  }

  return anim._id_58E3;
}

zombiescreamer_explode(var_0) {
  if(!istrue(self._id_7560)) {
    self._id_0B67.exploderequested = 1;
  }

  return anim._id_CA5F;
}

_id_11090(var_0) {
  var_1 = _id_1108A();

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_1108D(var_0) {
  var_1 = _id_1108A();

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  var_2 = gettime();
  var_3 = scripts\cp\utility::_id_459B(self._id_0B67.nextpathupdatetime, 0);

  if(var_2 > var_3) {
    self._id_0B67.nextpathupdatetime = var_2 + 500;
    var_4 = self _meth_86F8(var_1.origin);

    if(var_4 == (0, 0, 0) || distancesquared(self.origin, var_4) < 16) {
      var_5 = _func_02AB(var_1.origin, self);

      if(var_5 == (0, 0, 0)) {} else
        var_4 = var_5;
    }

    self _meth_84BC(0, var_4);
  }

  scripts\engine\utility::set_movement_speed(170);
  return anim._id_EACB;
}

onscreamerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  _id_0014::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_13);
}

_id_AB98(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_06FC::_id_108F(self, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);
  }

  scripts\aitypes\zombie_common\push::damage_knockdown(var_2, var_4, var_7);

  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_072E::display_damage_number(var_1, self, var_8, var_4, var_5, var_2, var_6);
  }

  _id_0014::_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_11, var_12);
}

_id_AB99(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(istrue(self.spawn_manager_cleanup)) {
    self._id_DDAB = 1;
  }

  self._id_48CD = var_1;
  _id_0014::_id_0F7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

set_turned(var_0) {
  self setscriptablepartstate("tell_trail", scripts\engine\utility::ter_op(var_0, "brainrot_loop", "tell_trail_on"));
  self setscriptablepartstate("ai_glow", scripts\engine\utility::ter_op(var_0, "brainrot_loop", "base_loop"));
}

set_frozen(var_0) {
  self.base_model = scripts\cp\utility::_id_459B(self.base_model, "c_s4_zmb_screamer_1_wholebody");
  self.frozen_model = scripts\cp\utility::_id_459B(self.frozen_model, "c_s4_zmb_screamer_1_wholebody_frost");
  self setModel(scripts\engine\utility::ter_op(var_0, self.frozen_model, self.base_model));
}