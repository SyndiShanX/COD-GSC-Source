/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 20.gsc
*************************************************/

main() {
  if(isDefined(level._id_3FD9) && level._id_3FD9) {
    return;
  }
  level._id_20EE = ::_func_0018;
  level._id_20EF = ::_func_0019;
  level thread _id_0015::init();
  level._id_E411 = 0;
  level _id_06CB::_id_0FA4("objective_ended", ::onobjectiveended);
  level.agent_corpses = [];
}

_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return var_2;
  }

  if(isai(var_1)) {
    if(self.team == var_1.team && var_4 == "MOD_MELEE") {
      return 0;
    }
  }

  if(istrue(self._id_86F2) && (isPlayer(var_1) || istrue(var_1._id_86F2))) {
    return 0;
  }

  scripts\cp\covenants\cp_critical_expertise::try_convert_to_critical_hit(var_1, var_8, var_4);

  if(scripts\cp\covenants\cp_critical_expertise::is_critical_hit(var_1)) {
    var_13 = scripts\cp\covenants\cp_critical_expertise::get_critical_expertise_multiplier(var_1, var_5);
    var_2 = int(var_12 * var_13);
  }

  if(scripts\engine\utility::_id_8794(var_4)) {
    var_14 = _func_0489(var_5);
    var_15 = var_14 < 0;

    if(isPlayer(var_1) && var_14 != 0) {
      var_16 = abs(var_14);
      var_17 = var_16 * 0.02;
      var_18 = max(1, int(var_2 * var_17));

      if(var_15) {
        var_2 = var_2 + var_18;
      } else {
        var_2 = var_2 - var_18;
      }
    }
  }

  if(var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_EXPLOSIVE_BULLET") {
    self._id_FF28 = var_6;

    if(isPlayer(var_1) && isDefined(var_5.basename) && (var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_EXPLOSIVE_BULLET")) {
      switch (var_5.basename) {
        case "s4_la_m1bravo_mp":
          var_2 = var_2 * 3;
          var_19 = var_1 _id_0774::_id_684B(var_5);

          if(var_19 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_palpha_mp":
          var_2 = var_2 * 3;
          var_19 = var_1 _id_0774::_id_684B(var_5);

          if(var_19 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_palpha42_mp":
          var_2 = var_2 * 2.8;
          var_19 = var_1 _id_0774::_id_684B(var_5);

          if(var_19 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_mkilo1_mp":
          var_2 = var_2 * 2.8;
          var_19 = var_1 _id_0774::_id_684B(var_5);

          if(var_19 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_walpha2_mp":
          if(!getdvarint("#x3dee089cb49164e4e", 0)) {
            var_2 = var_2 * 1.0;
          }

          break;
        case "s4_mg_streak_mp":
          if(!getdvarint("#x3dee089cb49164e4e", 0)) {
            var_2 = var_2 * 0.75;
          }

          break;
        default:
          break;
      }
    }
  } else
    self._id_FF28 = undefined;

  var_2 = _id_0774::_id_6C04(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(isDefined(level.chargedshieldslamdamagecalculation) && var_5.basename == "s4_me_rindigoww_mp") {
    var_2 = self[[level.chargedshieldslamdamagecalculation]](var_1.origin - self.origin, var_4, var_2);
  }

  var_20 = 0;

  if(isDefined(var_5) && isDefined(var_5.basename)) {
    if(isDefined(level._id_10CE7) && isDefined(level._id_10CE7[var_5.basename])) {
      var_2 = self[[level._id_10CE7[var_5.basename]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(isPlayer(var_1) && (!scripts\cp\utility::_id_88D7(var_5) || scripts\cp\utility::_id_88F6(var_5)) && (var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_IMPACT" || var_4 == "MOD_FIRE" || var_4 == "MOD_UNKNOWN" || var_4 == "MOD_EXPLOSIVE_BULLET")) {
      if(!getdvarint("#x3dee089cb49164e4e", 0)) {
        var_2 = _id_0728::scale_damage_by_round(var_2, var_5, self.zm_ai_category, self.maxhealth);
      } else {
        [var_2, var_20] = _id_0728::rbz_scale_damage_by_round(var_0, var_2, var_4, var_5, var_6, var_8, self._id_110B0, self.maxhealth);
      }
    }

    if(var_5.basename == "s4_energy_mine_zm") {
      self.damaged_by_energy_mine = 1;
    }
  }

  var_22 = 0.1;
  var_23 = var_1 _id_0945::_id_664E("head_popper_returned_bullet");

  if(isDefined(var_23) && var_23 > 0) {
    var_24 = var_1 getentitynumber();

    if(!isDefined(self.killing_blow_count)) {
      self.killing_blow_count = [];
    }

    if(!isDefined(self.killing_blow_count[var_24])) {
      self.killing_blow_count[var_24] = 0;
    }

    if(_id_8A5B(var_5) || isbuckslugweapon(var_1, var_5)) {
      if(isDefined(self.killing_blow_cooldown_time)) {
        if(isDefined(self.killing_blow_cooldown_time[var_24])) {
          var_25 = gettime();

          if((var_25 - self.killing_blow_cooldown_time[var_24]) / 1000 > var_22) {
            self.killing_blow_cooldown_time[var_24] = gettime();
            self.killing_blow_count[var_24]++;
          }
        } else {
          self.killing_blow_cooldown_time[var_24] = gettime();
          self.killing_blow_count[var_24]++;
        }
      } else {
        self.killing_blow_cooldown_time = [];
        self.killing_blow_cooldown_time[var_24] = gettime();
        self.killing_blow_count[var_24]++;
      }
    } else
      self.killing_blow_count[var_24]++;
  }

  if(isDefined(var_1) && isDefined(var_1._id_1210)) {
    if(_func_010F(var_4) && isDefined(var_1.ai_explosion_damage_mult)) {
      var_2 = var_2 * var_1.ai_explosion_damage_mult;
    }

    var_26 = _id_09A4::zombiegethealthroundscale();
    var_2 = var_2 * var_26;
  }

  if(!getdvarint("#x3dee089cb49164e4e", 0) || !var_20) {
    if(isDefined(self.zm_ai_category) && self.zm_ai_category == "special") {
      var_27 = _func_010F(var_4);
      var_28 = var_4 == "MOD_FIRE";

      if(var_27) {
        var_2 = var_2 * 2;
      } else if(var_28) {
        var_2 = var_2 * 3;
      }
    }
  }

  var_2 = check_damage_callbacks(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_2 = _id_3426(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(!isPlayer(var_1) && isDefined(self._id_A59C)) {
    if(istrue(self._id_A59B)) {
      return self[[self._id_A59C]](var_2, var_5, var_1);
    } else {
      return self[[self._id_A59C]](var_2, var_5);
    }
  }

  if(!isbot(var_1)) {
    level notify("zombie_attacked_by_player");
  }

  if(istrue(self._id_203F)) {
    var_2 = var_2 * 2;
  }

  if(!isDefined(var_2) || !isDefined(var_4)) {
    return var_2;
  }

  if(var_4 == "") {
    return var_2;
  }

  if(isDefined(var_1._id_11E0) && var_4 == "MOD_MELEE") {
    var_29 = spawnStruct();
    var_29.attacker = var_1;
    var_30 = var_1 _id_098C::_id_11E2(var_29);
    var_2 = var_2 * var_30;
  }

  var_2 = _id_098E::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  var_2 = scripts\cp\covenants\cull_the_weak::apply_cull_the_weak_bonus_crit_damage(var_1, var_2, var_4, var_5, var_8);
  self._id_2032 = undefined;

  if(isDefined(self._id_1362)) {
    for(var_24 = 0; var_24 < self._id_1362.size; var_24++) {
      var_31 = self._id_1362[var_24];
      var_2 = self[[var_31]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(var_2 < 1) {
      return 0;
    }

    var_2 = int(var_2 + 0.5);
  }

  var_32 = var_2;
  var_33 = var_2;

  if(isDefined(self._id_0F73)) {
    var_33 = [[self._id_0F73]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(istrue(self._id_7D80)) {
    if(int(var_33) >= self.health) {
      self._id_10C37 = 1;
    }
  }

  if(isDefined(var_0) && isPlayer(var_1) && var_1 == var_0) {
    if(var_4 == "MOD_HEAD_SHOT" || var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET") {
      var_1._id_79B5 = scripts\cp\utility::_id_459B(var_1._id_79B5, 0);
      var_1._id_79B5++;
    }
  }

  if(isPlayer(var_1)) {
    if(isalive(var_1) && (scripts\engine\utility::is_equal(var_4, "MOD_GRENADE") || scripts\engine\utility::is_equal(var_4, "MOD_GRENADE_SPLASH"))) {
      var_1._id_714C = self;
    }

    if(isDefined(var_5)) {
      var_34 = var_1 _id_0945::_id_664E("weapon_damage_scalar");

      if(isDefined(var_34)) {
        var_33 = var_33 * var_34;
      }
    }

    if(scripts\cp\utility::_id_8891(var_5, var_8, var_4, var_1)) {
      var_35 = var_1 _id_0945::_id_664E("crit_damage_increase");

      if(isDefined(var_35)) {
        var_33 = var_33 * var_35;
      }
    }

    var_33 = _id_0990::_id_6515(var_1, var_4, var_8, var_5, var_33);
    self._id_74DB = 1;
    var_1._id_0313 = 0;
  }

  if(isDefined(var_1) && var_33 > 0 && !istrue(self._id_DD8D)) {
    var_36 = 0;

    if(isPlayer(var_1) && var_1 _meth_81E2()) {
      var_37 = scripts\cp\utility::_id_6C5C();

      if(var_37.size == 4) {
        var_36 = 1;
      }
    }

    if(!var_36) {}
  }

  if(isDefined(self._id_8531) && self.health - var_33 <= self._id_8531 && !istrue(self._id_9B33)) {
    var_33 = int(max(0, self.health - self._id_8531));
  } else if(isDefined(self._id_8530) && self.health - var_33 <= self._id_8530 && !istrue(self._id_9B33)) {
    var_33 = int(max(0, self.health - self._id_8530));
  }

  var_38 = self.health - var_33 <= 0;

  if(isDefined(level._id_11024)) {
    foreach(var_40 in level._id_11024) {
      self thread[[var_40]](var_38, var_0, var_1, var_33, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }

  if(isDefined(self._id_2037) && var_33 == 0) {
    return 0;
  }

  if(isDefined(var_0) && var_0 scripts\common\vehicle::_id_8AF5() && scripts\engine\utility::is_equal(var_4, "MOD_CRUSH")) {
    var_42 = self.maxhealth / self._id_22BC;
    var_33 = int(var_33 * var_42);
  }

  if(isDefined(level._id_6031)) {
    var_33 = [[level._id_6031]](var_0, var_1, var_33, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_33 == 0) {
      return 0;
    }
  }

  var_33 = int(scripts\cp\utility::_id_459B(var_33, var_33));

  if(!var_38 || !istrue(self._id_4D7D)) {
    var_29 = spawnStruct();
    var_29._id_511D = var_0;
    var_29._id_50FF = var_1;
    var_29._id_7C8D = var_33;
    var_29._id_7C97 = var_3;
    var_29._id_DE2B = var_4;
    var_29._id_04F6 = var_5;
    var_29._id_106B7 = var_6;
    var_29._id_FFD4 = var_7;
    var_29._id_D9E0 = var_8;
    var_29._id_0354 = var_9;
    var_29._id_9FDA = var_10;
    var_29._id_031A = var_11;

    if(var_29._id_7C8D > 0) {
      _id_06CB::_id_2F23("on_ai_damage", var_29);
    }

    var_43 = undefined;

    if(scripts\cp\utility::_id_8891(var_5, var_8, var_4, var_1)) {
      var_44 = 2;
    } else {
      var_44 = 1;
    }

    if(isDefined(self._id_1210)) {
      if(isDefined(level._id_11EF[self._id_1210]["on_damaged_finished"])) {
        self[[level._id_11EF[self._id_1210]["on_damaged_finished"]]](var_0, var_1, var_33, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
      }
    }
  }

  scripts\cp\covenants\cp_critical_expertise::reset_critical_hit(var_1);
  return int(var_33);
}

check_damage_callbacks(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_2;
  var_13 = spawnStruct();
  var_13.inflictor = var_0;
  var_13.attacker = var_1;
  var_13.damage = var_2;
  var_13._id_01C4 = var_3;
  var_13._id_9CD6 = var_4;
  var_13._id_04F6 = var_5;
  var_13._id_106B7 = var_6;
  var_13._id_FFD4 = var_7;
  var_13._id_D9E0 = var_8;
  var_13._id_0354 = var_9;
  var_13._id_9FDA = var_10;
  var_13._id_031A = var_11;
  var_14 = 1.0;

  foreach(var_16 in level.damage_multiplier_callbacks) {
    if(isDefined(var_16)) {
      var_17 = self[[var_16]](var_13);

      if(!isDefined(var_17)) {
        return 0;
      }

      var_14 = var_14 + var_17;
    }
  }

  var_19 = 0.0;

  foreach(var_21 in level.flat_damage_callbacks) {
    if(isDefined(var_21)) {
      var_22 = self[[var_21]](var_13);
      var_19 = var_19 + var_22;
    }
  }

  return var_12 * var_14 + var_19;
}

_id_3426(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(level._id_0F72)) {
    return var_2;
  }

  for(var_12 = 0; var_12 < level._id_0F72.size; var_12++) {
    var_13 = self[[level._id_0F72[var_12]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!scripts\engine\utility::is_equal(-1, var_13)) {
      return var_13;
    }
  }

  return var_2;
}

_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  update_combat_stats_damage(var_1, var_8, var_5);
  _id_11067(var_2, var_1, var_8, 0);

  if(isDefined(var_0) || isDefined(var_1)) {
    if(!isDefined(var_0)) {
      var_0 = var_1;
    }

    if(isDefined(self._id_15E0) && !self._id_15E0) {
      if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
        return 0;
      }
    }

    if(isDefined(var_0.classname) && var_0.classname == "auto_turret") {
      var_1 = var_0;
    }

    if(isDefined(var_1) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(var_1.team) && var_1.team != self.team) {
          self _meth_82D2(var_1);
        }
      } else
        self _meth_82D2(var_1);
    }
  }

  if(isDefined(var_1)) {
    var_1 notify("zombie_damaged", self, var_4, var_5);

    if(var_1 scripts\cp\utility::_hasperk("specialty_dead_accurate")) {
      var_1 scripts\cp\covenants\cp_dead_accurate::dead_accurate_zombie_damaged(self, var_4, var_5);
    }
  }

  if(isPlayer(var_1)) {
    var_1 thread _id_FCB8(var_5.basename);
  }

  _id_07F7::_id_457A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  return 1;
}

_id_0F7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  update_combat_stats_killed(var_1, var_6, var_3, var_4);

  if(!scripts\engine\utility::is_equal(self._id_2027, 1)) {
    level._id_A393--;

    if(level._id_A393 <= 0 && level scripts\engine\utility::_id_5C00("infinite_round_spawning") && !istrue(level._id_2023)) {
      self._id_2042 = 1;
    }
  }

  var_9 = undefined;
  level._id_A391 = scripts\cp\utility::_id_459B(level._id_A391, 0);

  if(isDefined(var_1)) {
    if(isPlayer(var_1)) {
      var_9 = var_1;
    } else if(isDefined(var_1.owner) && isPlayer(var_1) && var_1.classname == "script_vehicle") {
      var_9 = var_1.owner;
    }
  }

  if(isDefined(var_0)) {
    if(!isPlayer(var_1)) {
      if(isDefined(var_0._id_48CD)) {
        var_1 = var_0._id_48CD;
      } else if(isDefined(var_0.brain_rot_player)) {
        var_1 = var_0.brain_rot_player;
      }
    }
  }

  if(isai(var_1) && isDefined(var_1._id_CE11)) {
    if(var_1._id_CE11.team != self.team) {
      var_1 = var_1._id_CE11;
    }
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    level._id_A391++;
    var_10 = undefined;

    if(isDefined(self._id_18AF)) {
      switch (self._id_18AF) {
        case "quad_zombie":
          var_10 = "quadkill";
          break;
        case "ape_zombie":
          var_10 = "apekill";
          break;
        case "zombie":
          var_10 = "zombiekill";
          break;
        case "zombie_dog":
          var_10 = "dogkill";
          break;
      }
    }
  }

  var_11 = spawnStruct();
  var_11._id_511D = var_0;
  var_11._id_50FF = var_1;
  var_11._id_7C8D = var_2;
  var_11._id_DE2B = var_3;
  var_11._id_04F6 = var_4;
  var_11._id_FFD4 = var_5;
  var_11._id_D9E0 = var_6;
  var_11._id_0354 = var_7;
  _id_06CB::_id_2F23("on_ai_killed", var_11);

  if(isDefined(var_1)) {
    var_1 notify("on_ai_killed");
  }

  if(isDefined(self._id_0F7A)) {
    self[[self._id_0F7A]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  if(isDefined(self._id_43E6)) {
    self[[self._id_43E6]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  var_12 = 0;

  if(isDefined(var_0) && isDefined(var_0._id_50D8)) {
    var_11._id_F811 = var_0._id_50D8;
  } else if(isDefined(var_1) && isDefined(var_1._id_50D8)) {
    var_11._id_F811 = var_1._id_50D8;
    var_11._id_50FF = var_1._id_50D8;
  }

  var_11._id_0192 = self;

  if(!scripts\engine\utility::is_equal(var_3, "MOD_MELEE") && (scripts\engine\utility::is_equal(var_6, "head") || scripts\engine\utility::is_equal(var_6, "helmet"))) {
    var_11._id_761C = 1;
  }

  scripts\cp\zombies\zombie_slow::end_all_slows();
  _id_07F7::_id_457C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_13 = self._id_25CA;

  if(isDefined(var_13)) {
    level.agent_corpses = scripts\engine\utility::_id_1BD1(level.agent_corpses);
    level.agent_corpses = scripts\engine\utility::array_add(level.agent_corpses, var_13);
  }

  if(isPlayer(var_1)) {
    var_1 _id_072A::updateweaponspecifickillingblows(self, var_4, var_3, var_6);
    var_14 = gatherkilleventmodifiers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    _id_070F::_id_4006(var_1, self, var_14, var_4, var_3);
  }

  if(!isPlayer(var_11._id_50FF) || scripts\engine\utility::is_equal(var_11._id_0192._id_7D2A, 0)) {
    return;
  }
  if(isDefined(self._id_1DDE)) {
    foreach(var_9 in self._id_1DDE) {
      if(!isDefined(var_9) || !isPlayer(var_9)) {
        continue;
      }
      if(var_9 == var_1) {
        continue;
      }
      if(self == var_9) {
        continue;
      }
      if(isDefined(level._id_1D2C)) {
        continue;
      }
      var_16 = undefined;

      if(isDefined(self._id_1DD4)) {
        var_17 = self._id_1DD4[var_9.guid];

        if(isDefined(var_17)) {
          if(gettime() - var_17._id_90A7 > 10000) {
            continue;
          }
          var_16 = var_17.objweapon;
        }
      }

      var_9 thread _id_072C::_id_BD5D(self, var_16);
      var_18 = gathereliminationeventmodifiers(self, self, var_2, var_3, var_16, var_5, var_6, var_7, var_8);
      _id_070F::createassistchallengeevent(var_9, self, var_18, var_16, var_3);
    }
  }
}

_id_11067(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_4._id_110B0) && isDefined(var_0) && isDefined(var_1)) {
    if(istrue(var_3)) {
      if(isDefined(var_2) && var_2 == "head") {
        var_1 thread _id_071B::_id_FC47("hitzombieheadshot", var_0 >= self.health, 1, "hitzombieheadshot");
      } else {
        var_1 thread _id_071B::_id_FC47("hitzombieheadshot", var_0 >= self.health, 0, "hitzombieheadshot");
      }
    } else if(isDefined(var_2) && var_2 == "head")
      var_1 thread _id_071B::_id_FC47("standard", var_0 >= self.health, 1);
    else {
      var_1 thread _id_071B::_id_FC47("standard", var_0 >= self.health);
    }
  }
}

_id_FCB8(var_0) {
  waittillframeend;
  self notify("updateMagShots_" + var_0);
}

gathereliminationeventmodifiers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = [];

  if(isPlayer(var_1) && istrue(self._id_86F2) && self.brain_rot_player == var_1) {
    var_9["covenant_kill"] = 1;
  } else if(isDefined(self._id_1DD4)) {
    foreach(var_12, var_11 in self._id_1DD4) {
      if(_func_0121(var_12) && _func_0121(var_1.guid) && var_12 == var_1.guid) {
        if(var_11.covenantactive) {
          var_9["covenant_kill"] = 1;

          if(scripts\cp\covenants\cp_covenants::is_deadshot_daiquiri_active(self, var_1, var_4, var_6, var_3)) {
            var_9["covenant_deadshot_kill"] = 1;
          }
        }

        break;
      }
    }
  }

  var_13 = ["optic", "undermount", "reargrip", "muzzle", "magazine", "backpiece", "frontpiece", "trigger", "gunperk"];
  var_14 = 7;
  var_15 = 6;
  var_16 = scripts\engine\utility::ter_op(var_4.classname == "pistol", var_15, var_14);

  if(var_4._id_0070.size >= var_14) {
    var_17 = [];

    foreach(var_19 in var_4._id_0070) {
      var_17[var_17.size] = ::scripts\cp\utility::_id_68E5(var_19);
    }

    var_21 = 0;

    foreach(var_23 in var_13) {
      if(scripts\engine\utility::array_contains(var_17, var_23)) {
        var_21++;
      }
    }

    if(var_21 >= var_16) {
      var_9["full_attachments"] = 1;
    }
  }

  var_25 = "";

  if(isDefined(var_4) && isDefined(var_4.basename)) {
    var_25 = var_4.basename;
  }

  if(isDefined(var_1.magic_box_weapons) && scripts\engine\utility::array_contains(var_1.magic_box_weapons, var_25)) {
    var_9["magic_box_weapon"] = 1;
  }

  if(isDefined(var_1.chest_weapons) && scripts\engine\utility::array_contains(var_1.chest_weapons, var_25)) {
    var_9["chest_weapon"] = 1;
  }

  if(isDefined(var_4._id_0241) && var_4._id_0241 == "primary") {
    var_9["primary_weapon_kill"] = 1;
  }

  var_26 = _id_0728::_id_6A14(var_4);

  if(isDefined(var_26)) {
    var_9["equipment_kill"] = 1;
  }

  if(is_wonder_weapon(var_4.basename)) {
    var_9["using_wonder_weapon"] = 1;
  }

  return var_9;
}

gatherkilleventmodifiers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = gettime();
  var_10 = gathereliminationeventmodifiers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(scripts\cp\zombies\zombie_slow::is_slowed()) {
    var_10["enemy_slowed"] = 1;
  }

  var_11 = _id_0766::_id_8A7D(var_4);
  var_12 = scripts\cp\zombies\zombie_slow::has_applied_slow(var_1, "frost_blast_aoe_slow");
  var_13 = _id_098E::entity_inside_players_ring_of_fire(var_1, var_1);

  if(var_11 || var_12 || var_13 || istrue(var_1._id_11E0)) {
    var_10["field_upgrade_kill"] = 1;
  }

  if(var_12) {
    var_10["frozen_zombie_kill"] = 1;
  }

  if(var_13) {
    var_10["in_ring_of_fire_zombie_kill"] = 1;
  }

  if(var_1 scripts\cp\utility::_id_8989()) {
    var_10["ads"] = 1;
  } else if(scripts\cp\utility::_id_88D7(var_4)) {
    var_10["hipfire"] = 1;
  }

  var_14 = "";
  var_15 = 5;

  if(isDefined(var_4)) {
    if(isDefined(var_4.basename)) {
      var_14 = var_4.basename;
    }

    if(isDefined(var_4.classname) && (var_4.classname == "rocketlauncher" || var_4.classname == "grenade" && !isDefined(_id_0728::_id_6A14(var_4)))) {
      var_15 = 3;
    } else if(scripts\cp\utility::_id_8A09(var_4)) {
      var_15 = 5;
    }
  }

  if(isDefined(var_1.recentweaponkills) && isDefined(var_1.recentweaponkills[var_14])) {
    if(var_1.recentweaponkills[var_14] > 0 && var_1.recentweaponkills[var_14] % var_15 == 0) {
      var_10["rapid_kill"] = 1;
    }
  }

  if(scripts\cp\utility::_id_8891(var_4, var_6, var_3, var_1)) {
    var_10["critical_kill"] = 1;

    if(isDefined(var_1.recentweaponcriticalkills) && isDefined(var_1.recentweaponcriticalkills[var_14])) {
      if(var_1.recentweaponcriticalkills[var_14] > 0 && var_1.recentweaponcriticalkills[var_14] % 3 == 0) {
        var_10["rapid_critical_kill"] = 1;
      }
    }

    if(isDefined(var_1._id_AFAA["head_popper_returned_bullet"]) && var_1._id_AFAA["head_popper_returned_bullet"] > 0) {
      var_10["critical_kill_with_dead_blow"] = 1;
    }
  }

  if(isDefined(var_1.consecutiveweaponkills) && isDefined(var_1.consecutiveweaponkills[var_14])) {
    if(var_1.consecutiveweaponkills[var_14] > 0 && var_1.consecutiveweaponkills[var_14] % 20 == 0) {
      var_10["consecutive_kill"] = 1;
    }
  }

  if(isDefined(var_1._id_11086) && isDefined(var_1._id_11086["zm_perk_critical_damage"]) && var_1._id_11086["zm_perk_critical_damage"] > 0) {
    var_10["has_damage_perk"] = 1;
  }

  if(isDefined(var_0)) {
    if(istrue(var_0._id_86F2)) {
      var_10["brain_rot_kill"] = 1;
      var_10["covenant_kill"] = 1;

      if(var_0._id_1210 == "actor_enemy_zombie_juggernaut_cp") {
        var_10["brain_rot_juggernaut_kill"] = 1;
      }
    }

    if(isDefined(var_0._id_1210) && var_0._id_1210 == "actor_enemy_zombie_screamer_cp") {
      var_10["screamer_kill"] = 1;
    }
  }

  if(isDefined(var_4) && isDefined(var_4.basename)) {
    if(var_4.basename == "s4_splatterfest_zm") {
      var_10["splatterfest_kill"] = 1;
    }

    if(var_4.basename == "s4_throwing_knife_zm" && isDefined(self._id_1210)) {
      if(!istrue(var_1.throwing_knife_killed_all_types_this_round)) {
        if(!isDefined(var_1.throwing_knife_killed_types_this_round)) {
          var_1.throwing_knife_killed_types_this_round = [];
        }

        if(!istrue(var_1.throwing_knife_killed_types_this_round[self._id_1210])) {
          var_1.throwing_knife_killed_types_this_round[self._id_1210] = 1;

          if(var_1.throwing_knife_killed_types_this_round.size == 3) {
            var_16 = 1;

            foreach(var_18 in var_1.throwing_knife_killed_types_this_round) {
              if(!var_18) {
                var_16 = 0;
                break;
              }
            }

            if(var_16) {
              var_10["throwing_knife_kill_all_type"] = 1;
              var_1.throwing_knife_killed_all_types_this_round = 1;
            }
          }
        }
      }
    }
  }

  if(var_1 _meth_826F() >= 1.0) {
    var_10["mounted"] = 1;
  }

  var_20 = var_1 getstance();

  if(var_20 == "crouch") {
    var_10["crouch"] = 1;
  } else if(var_20 == "prone") {
    var_10["prone"] = 1;
  }

  var_21 = var_1 getvelocity();

  if(_func_0135(var_21) > 0) {
    var_10["moving"] = 1;
  }

  var_22 = _id_072A::_id_6D29(var_1, var_4, var_3, var_1.origin, self);

  if(var_22 == "longshot" || var_22 == "very_longshot") {
    var_10["longshot"] = 1;
  } else if(var_22 == "pointblank") {
    var_10["pointblank"] = 1;
  }

  var_23 = _id_0728::_id_6A14(var_4);

  if(isDefined(var_23)) {
    var_10["equipment_kill"] = 1;
  }

  if(istrue(var_1._id_11B4)) {
    var_10["recent_stim"] = 1;
  }

  if(isDefined(var_1._id_9038) && var_9 - var_1._id_9038 <= 1500) {
    var_10["reload_kill"] = 1;
  }

  if(var_1.health <= 50) {
    var_10["low_health"] = 1;
  }

  var_24 = scripts\cp\cp_weapon::getweapongroup(var_4.basename);

  if(isDefined(var_1._id_8F84) && var_9 - var_1._id_8F84 <= 500 && var_24 == "weapon_sniper") {
    var_10["quickscope"] = 1;
  }

  if(isDefined(var_1._id_90C7) && var_9 - var_1._id_90C7 <= 1500) {
    var_10["weapon_change_kill"] = 1;
  }

  if(_func_0121(self._id_04F6._id_0241) && self._id_04F6._id_0241 == "primary") {
    var_10["primary_weapon_kill"] = 1;
  }

  if(is_wonder_weapon(var_4.basename)) {
    var_10["using_wonder_weapon"] = 1;
  }

  if(var_4.basename == "s4_la_walpha2_mp") {
    var_10["using_warmachine"] = 1;
  }

  if(var_4.basename == "s4_mg_streak_mp") {
    var_10["using_deathmachine"] = 1;
  }

  return var_10;
}

onobjectiveended(var_0) {
  foreach(var_2 in level.players) {
    var_2.throwing_knife_killed_all_types_this_round = undefined;
    var_2.throwing_knife_killed_types_this_round = undefined;
  }
}

update_combat_stats_damage(var_0, var_1, var_2) {
  if(!isDefined(self.numhits)) {
    self.numhits = 1;
  } else {
    self.numhits++;
  }

  if(var_1 == "helmet" || var_1 == "head" || var_1 == "neck") {
    scripts\cp\cp_playerstats::_id_7DF5(var_0, var_2, "criticalHits", 1);
    scripts\cp\cp_playerstats::updateweaponperc(var_0, var_2, "criticalPerc", "criticalHits", "uses");
  } else {
    scripts\cp\cp_playerstats::_id_7DF5(var_0, var_2, "hits", 1);
    scripts\cp\cp_playerstats::updateweaponperc(var_0, var_2, "accuracyPercentage", "hits", "uses");
  }
}

update_combat_stats_killed(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_0)) {
    scripts\cp\telemetry_cp::logevent_aikillinfo(var_0, var_3, self, var_2);
    scripts\cp\cp_playerstats::incrementcombatstat(var_0, "totalEliminations", 1);
    scripts\cp\cp_playerstats::_id_7DF5(var_0, var_3, "deaths", 1);

    if(scripts\engine\utility::is_equal(var_1, "head") || scripts\engine\utility::is_equal(var_1, "helmet") || scripts\engine\utility::is_equal(var_1, "neck")) {
      scripts\cp\cp_playerstats::incrementcombatstat(var_0, "totalCriticalKills", 1);
      scripts\cp\cp_playerstats::_id_7DF5(var_0, var_3, "criticalKills", 1);
    }

    if(var_0 _id_0774::_id_684B(var_3) > 0) {
      scripts\cp\cp_playerstats::_id_7DF5(var_0, var_3, "packedKills", 1);
    }

    var_4 = _id_0728::_id_6A14(var_3);

    if(isDefined(var_4)) {
      var_5 = _id_0728::_id_6A17(var_4);

      if(!istrue(var_5.isquestitem)) {
        var_6 = scripts\cp\utility::getequipmenttypeequipref(var_4);

        if(isDefined(var_6)) {
          if(var_6 == "lethal") {
            scripts\cp\cp_playerstats::incrementcategorystat(var_0, "lethalStats", var_4, "kills", 1);
          } else if(var_6 == "tactical") {
            scripts\cp\cp_playerstats::incrementcategorystat(var_0, "tacticalStats", var_4, "hits", 1);
          }
        }
      }
    }
  }
}

is_wonder_weapon(var_0) {
  return var_0 == "s4_pi_raygun_mp" || var_0 == "s4_me_rindigoww_mp" || var_0 == "s4_ar_tgun_mp";
}

isbuckslugweapon(var_0, var_1) {
  return isDefined(var_1) && weaponclass(var_1) == "rifle" && isDefined(var_1._id_04B7) && issubstr(var_1._id_04B7, "buckslug");
}

_id_8A5B(var_0) {
  return isDefined(var_0) && weaponclass(var_0) == "spread";
}