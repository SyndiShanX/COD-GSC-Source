/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1818.gsc
*************************************************/

_id_2F38(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = getcompleteweaponname(var_5);
  var_16 = self;
  var_17 = isDefined(var_1);
  var_18 = var_17 && isPlayer(var_1);

  if(!var_18) {
    if(isDefined(var_1)) {
      if(isDefined(var_1._id_00EC) && var_1._id_00EC == "misc_turret") {
        var_0 = var_1;
      }

      if(isDefined(var_1.owner) && (isPlayer(var_1.owner) || isagent(var_1.owner))) {
        var_1 = var_1.owner;
        var_18 = 1;
        var_17 = 1;
      }
    }

    if(!var_18) {
      if(isDefined(var_0) && isDefined(var_0.owner) && (isPlayer(var_0.owner) || isagent(var_0.owner))) {
        var_1 = var_0.owner;
        var_18 = 1;
        var_17 = 1;
      }
    }
  }

  if(!_id_DBF8(var_2, var_1, var_15, var_3, var_18)) {
    return;
  }
  if(_id_4303(1)) {}

  if(var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_16 scripts\cp_mp\utility\player_utility::getvehicle()) && var_16 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }
  if(var_4 == "MOD_CRUSH" && isDefined(var_0) && istrue(var_0._id_4A34)) {
    return;
  }
  if(istrue(var_16.inlaststand)) {
    return;
  }
  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level._id_AD1E[var_15])) {
      level thread[[level._id_AD1E[var_15]]](var_16, var_15);
    }
  }

  var_3 = var_3 | 4;
  var_19 = isDefined(var_4) && (var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH");
  var_20 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_21 = _id_886D(self, var_1);
  var_22 = self._id_AFAA["friendly_explosive_damage_reduction"] != 1.0;
  var_23 = var_17 && var_1 == self;
  var_24 = (var_23 || !var_17) && var_4 == "MOD_SUICIDE";

  if(var_17) {
    if(var_1 == self) {
      if(var_19) {
        var_2 = var_2 * self._id_AFAA["friendly_explosive_damage_reduction"];
      }
    } else if(var_21) {
      var_2 = 0;

      if(isPlayer(var_16) && isPlayer(var_1)) {
        level thread _id_0750::_id_F759(var_16, "check_fire_ally");
      }
    }

    if(var_4 == "MOD_EXPLOSIVE") {
      if(var_15 == "at_mine_ap_mp") {
        var_2 = self.maxhealth * 0.9;
      }

      var_2 = var_2 * _id_0945::_id_664E("enemy_explosive_damage_reduction");

      if(isDefined(level._id_57E7)) {
        if(isPlayer(var_16)) {}

        var_2 = var_2 + var_2 * level._id_57E7;
      }
    } else if(var_4 == "MOD_GRENADE_SPLASH") {
      if(isDefined(level._id_57E7)) {
        if(isPlayer(var_16)) {}

        var_2 = var_2 + var_2 * level._id_57E7;
      }
    }
  }

  if(var_4 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var_2 = 0;
    } else {
      var_2 = self.maxhealth + self._id_1B26;
      physicsexplosionsphere(self.origin, 64, 64, 1);
    }
  }

  var_25 = 0.0;

  if(var_23 && !var_24) {
    var_2 = int(var_2 * var_16 scripts\cp\utility::_id_69C1());
  }

  if(scripts\cp\cp_weapon::_id_8863(var_5, var_4)) {
    var_26 = scripts\cp\cp_weapon::_id_19D3(var_16, var_1, var_6, 0);

    if(!var_26) {
      return;
    }
  }

  var_27 = self getcurrentprimaryweapon();

  if(var_27.type == "melee") {
    var_2 = int(var_2 * self._id_AFAA["carrying_melee_damage_scalar"]);
  }

  if(var_27.basename == "s4_me_rindigo_mp") {
    if(!_id_DBD4(var_0, var_1, var_4)) {
      if(isDefined(var_8) && var_8 == "shield") {
        if(isDefined(self._id_C871)) {
          self._id_C871 = self._id_C871 - var_2;
        }
      }
    }
  }

  if(istrue(self._id_61D4)) {}

  if(self issprinting()) {
    var_2 = int(var_2 * self._id_AFAA["sprint_damage_scalar"]);
  }

  if(self._id_8A07 == 1) {
    var_2 = int(var_2 * self._id_AFAA["revive_damage_scalar"]);
  }

  if(isDefined(self._id_EB0D)) {
    if(var_18) {
      self shellshock("invul_hit", 0.25);
    }

    var_2 = 0;
  }

  if(isDefined(self._id_1024C)) {
    self._id_1024C dodamage(var_2, self._id_1024C.origin);
    var_2 = int(clamp(var_2, 0, self.health - 1));
  }

  var_2 = _id_A008(var_0, var_1, var_16, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_2 <= 0) {
    return;
  }
  if(isPlayer(self) && isDefined(self._id_8C00)) {
    self._id_8C00 = self._id_8C00 - var_2;

    if(self._id_8C00 <= 0) {
      if(var_4 != "MOD_FALLING") {
        var_2 = 0;
      }

      self notify("juggernaut_end_damage");
    }
  }

  if(var_17 && var_2 > 0) {
    if(!_id_4303(1)) {
      if(getdvarint("#x345730d702cdfbb9d", 20) != 20) {
        var_28 = getdvarint("#x345730d702cdfbb9d") * level._id_5F3A * 1000;
      } else {
        var_28 = level._id_5F3A * 1000 * 20;
      }

      self._id_4329 = gettime() + var_28;
    }

    if((isai(var_1) || isPlayer(var_1) && var_1 != self) && !scripts\cp\utility::_id_86C9()) {
      _id_06FC::_id_108F(self, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);

      if(!isDefined(var_1._id_42F6)) {
        var_1._id_42F6 = [];
      }

      var_29 = gettime();
      var_1._id_42F6[var_16.guid] = var_29;
    }
  }

  if(isPlayer(var_1) && isDefined(var_1.pers["participation"])) {
    var_1.pers["participation"]++;
  } else if(isPlayer(var_1)) {
    var_1.pers["participation"] = 1;
  }

  if(isPlayer(self) && isDefined(self.pers["participation"])) {
    self.pers["participation"]++;
  } else if(isPlayer(self)) {
    self.pers["participation"] = 1;
  }

  _id_0752::_id_D58D(self, 1);
  var_30 = 0;

  if(isDefined(var_1) && isai(var_1)) {
    if(istrue(self _meth_86B7()) || istrue(self isskydiving()) || istrue(self _meth_86B8())) {
      var_2 = 1;
    }
  }

  if(!var_21) {
    if(_id_0707::_id_74D5(self) && _id_0707::_id_1B39(var_4, var_5, var_0, var_1)) {
      if(isDefined(var_8) && var_8 != "shield") {
        var_2 = _id_0707::_id_42B7(self, var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8, var_9, var_25, var_10, var_11);
        var_30 = 1;
      }
    }

    if(isDefined(level._id_FCD7)) {
      level thread[[level._id_FCD7]](var_1, var_15, self);
    }

    if(var_2 >= self.health && !_id_DBD4(var_0, var_1, var_4)) {
      if(_id_DAF6(var_2)) {
        var_2 = self.health - 1;
        childthread _id_440B(var_2, var_1, var_7, var_6, undefined, undefined, var_0);
      }

      childthread _id_4333(var_2, var_1, var_7, var_6, undefined, undefined, var_0);
      childthread _id_42F9(var_2, var_1, var_7, var_6, var_4, undefined, var_0);
      var_31 = scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_31)) {
        self._id_24FC = 1;
      } else if(_id_10CFF(var_5)) {
        self._id_24FC = 1;
      }
    }

    if(var_4 == "MOD_CRUSH" && var_2 >= self.health) {
      self._id_DBD8 = 1;
    }

    var_2 = int(var_2);

    if(var_18 && !isPlayer(self) && !var_23) {
      var_1 thread _id_071B::_id_FC47("standard");
    }

    if(istrue(self._id_DBD6)) {
      self._id_DBD6 = undefined;
    }

    if(istrue(self._id_ABE3)) {
      self._id_DBD8 = 1;
      var_2 = self.health + 100;
    }

    _id_5B1C(var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8, var_9, var_25, var_10, var_11, var_30);
    self notify("player_damaged");
  }

  _id_072C::_id_FBA7("personal", "damage_taken", var_2);

  if(var_2 != 0) {
    thread scripts\cp\cp_hud_util::_id_B400();
  }

  if(var_17) {
    if(isagent(var_1)) {
      if(!isDefined(var_1._id_42BC)) {
        var_1._id_42BC = 0;
      } else {
        var_1._id_42BC = var_1._id_42BC + var_2;
      }

      self._id_C0E8 = var_1;

      if(isDefined(level._id_4158)) {
        if(isDefined(level._id_425B)) {
          self[[level._id_425B]](var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8);
        }
      }
    }
  }

  if(scripts\engine\utility::_id_8794(var_4)) {
    var_16 thread _id_0750::_id_10A3(var_1, var_5, var_2);
  }

  if(isagent(var_1) && isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 != var_16) {
    var_16 thread _id_0750::_id_111F(var_1);
  }

  if(isDefined(var_16) && var_16 scripts\cp_mp\utility\player_utility::_isalive() && var_16.health < 30) {
    var_16 thread _id_0750::_id_7BE2();
  }

  if(isDefined(var_16) && var_16 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_1) && var_1 != var_16 && weaponclass(var_5) == "rocketlauncher") {
    level thread _id_0750::_id_F759(var_16, "survive_rpg", undefined, 1.0);
  }

  if(isDefined(var_16) && var_16.health <= 1) {
    var_16 _id_0750::_id_AB70(var_0, var_1, var_2, var_4, var_5);
  }
}

_id_8ACF() {
  if(scripts\cp\utility\player::_id_8ACE()) {
    return 1;
  }

  return 0;
}

_id_DBD4(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 == self) {
    return 1;
  }

  if(istrue(self._id_DBD6)) {
    return 1;
  }

  if(isDefined(var_0) && _id_860B(var_0)) {
    if(var_2 == "MOD_CRUSH") {
      return 1;
    }
  }

  switch (var_2) {
    case "MOD_FALLING":
    case "MOD_TRIGGER_HURT":
    case "MOD_EXECUTION":
    case "MOD_SUICIDE":
      return 1;
  }

  return 0;
}

_id_860B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(level._id_3E85) && isDefined(level._id_3E85._id_3E9B)) {
    if(level._id_3E85._id_3E9B.size > 0) {
      if(scripts\engine\utility::array_contains(level._id_3E85._id_3E9B, var_0)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_10CFF(var_0) {
  switch (var_0.basename) {
    case "lighttank_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mp":
    case "technical_mp":
      return 1;
    default:
      return 0;
  }
}

_id_881E(var_0, var_1) {
  var_2 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);

  if(!isDefined(var_1)) {
    return var_4 > 0;
  }

  return var_4 > var_1;
}

_id_895F(var_0, var_1) {
  if(var_1 == "MOD_TRIGGER_HURT" || var_1 == "MOD_UNKNOWN" || var_1 == "MOD_SUICIDE") {
    return 0;
  }

  if(var_0 >= self.health) {
    return 1;
  }

  return 0;
}

_id_46B8(var_0) {
  self endon("death");
  var_0 endon("death");
  wait 0.05;
  self dodamage(2, self.origin, var_0, undefined, "MOD_MELEE");
}

_id_E94A() {
  self notify("stop_using_remote");
}

_id_FE85(var_0) {
  self.health = var_0 + 1;
  self._id_75D0 = 0;
}

_id_DBF8(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && (var_3 == 256 || var_3 == 258)) {
    return 0;
  }

  if(isDefined(self.inlaststand) && self.inlaststand) {
    return 0;
  }

  if(_id_4303(1)) {
    return 0;
  }

  if(isDefined(level._id_425F) && _func_03AC(level._id_425F)) {
    if(![[level._id_425F]](self)) {
      return 0;
    }
  }

  if(_id_8ACF() && scripts\cp\utility::_id_86C9()) {
    return 0;
  }

  if(isDefined(self._id_0E05)) {
    return 0;
  }

  if(isDefined(var_2) && var_2 == "iw8_la_rpapa7_mp_friendly") {
    return 0;
  }

  if(isDefined(var_2) && var_2 == "overwatch_missile_cp") {
    return 0;
  }

  if(isDefined(var_2) && var_2 == "tur_gun_decho_cp") {
    return 0;
  }

  if(istrue(self._id_7D98)) {
    return 0;
  }

  return 1;
}

_id_3455(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 500;

  if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return var_1;
  }

  if(!isDefined(var_2) || !isPlayer(var_2) || var_4 != "MOD_EXPLOSIVE_BULLET") {
    return var_1;
  }

  if(var_3.classname == "weapon_shotgun") {
    var_6 = distance(var_2.origin, var_0.origin);
    var_7 = max(1, var_6 / var_5);
    var_8 = var_1 * 8;
    var_9 = var_8 * var_7;

    if(var_6 > var_5) {
      return var_1;
    }

    return int(var_9);
  }

  return var_1;
}

_id_8D58() {
  return istrue(self._id_8D57);
}

_id_D267(var_0, var_1) {
  self._id_8D57 = var_1;
}

_id_CB79(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4 != "none") {
    var_1 = _id_3455(self, var_1, var_0, var_3, var_2);
  }

  if(isDefined(var_2) && var_2 == "MOD_EXPLOSIVE_BULLET" && var_4 != "none") {
    if(var_3.classname == "weapon_shotgun") {
      var_1 = var_1 + int(var_1 * level._id_DA57);
    } else {
      var_1 = var_1 + int(var_1 * level._id_57D0);
    }
  }

  return var_1;
}

_id_CB77(var_0, var_1, var_2, var_3) {}

_id_CB78(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_2 = var_0 _id_0946::_id_BBFB();
    var_1 = var_1 * var_2;
    var_1 = int(var_1);
  }

  return var_1;
}

_id_DABC(var_0) {
  if(isDefined(level._id_DABD)) {
    return [[level._id_DABD]](var_0);
  }

  return 1;
}

_id_3467(var_0, var_1, var_2) {}

_id_3329(var_0, var_1, var_2, var_3) {
  self endon("death");
  _id_144F();
  _id_42B6(var_0, var_1, var_2, var_3);
  _id_144E();
}

_id_144F() {
  if(!isDefined(self._id_8569)) {
    self._id_8569 = 0;
  }

  self._id_8569++;

  if(self._id_8569 == 1 && self._id_E3D8 == "alien") {
    if(isDefined(self._id_1210) && self._id_1210 != "minion") {
      self setscriptablepartstate("animpart", "burning");
    }
  }
}

_id_144E() {
  self._id_8569--;

  if(self._id_8569 > 0) {
    return;
  }
  self._id_8569 = undefined;
  self notify("fire_off");

  if(self._id_E3D8 == "alien") {
    self setscriptablepartstate("animpart", "normal");
  }
}

_id_42B6(var_0, var_1, var_2, var_3) {
  var_4 = 150;
  var_5 = 100;
  var_6 = 75;
  var_7 = 133;
  var_8 = 500;
  var_9 = 100;
  var_10 = 3;
  var_11 = 4;
  var_12 = 3;
  var_13 = 4;
  var_14 = 4;
  var_15 = 2;
  var_16 = 1.2;
  self endon("death");

  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_17 = _id_06FE::_id_6305(self);

    switch (var_17) {
      case "goon4":
      case "goon3":
      case "goon2":
      case "goon":
        var_2 = var_6;
        var_1 = var_12;
      case "brute":
      case "brute4":
      case "brute3":
      case "brute2":
        var_2 = var_5;
        var_1 = var_11;
      case "spitter":
        var_2 = var_7;
        var_1 = var_13;
      case "elite":
      case "elite_boss":
        var_2 = var_8;
        var_1 = var_14;
      case "minion":
        var_2 = var_9;
        var_1 = var_15;
      default:
        var_2 = self.maxhealth * 0.5;
        var_1 = var_10;
    }
  } else {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    }

    if(!isDefined(var_1)) {
      var_1 = var_10;
    }
  }

  if(isDefined(var_0) && isDefined(var_3) && var_0 scripts\cp\utility::_id_86F7("incendiary_ammo_upgrade") && isDefined(var_3)) {
    var_2 = var_2 * var_16;
  }

  var_2 = var_2 * level._id_1451[level.players.size];
  var_18 = 0;
  var_19 = 6;
  var_20 = var_1 / var_19;
  var_21 = var_2 / var_19;

  for(var_22 = 0; var_22 < var_19; var_22++) {
    wait(var_20);

    if(isalive(self)) {
      self dodamage(var_21, self.origin, var_0, var_0, "MOD_UNKNOWN");
    }
  }
}

_id_5FB2(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_3 = var_1.team;
  var_4 = level._id_5FA5;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return 1;
  }

  if(var_1 == var_0) {
    return 0;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  if(var_3 != var_0.team) {
    return 1;
  }

  return 0;
}

_id_FB52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isDefined(var_1.owner)) {
    _id_06FE::_id_E9B2(var_1.owner, var_2 * 0.75);
  } else if(isDefined(var_1) && isDefined(var_1._id_B02C) && var_1._id_B02C == 1) {
    _id_06FE::_id_E9B2(var_1.owner, var_2);
  } else {
    _id_06FE::_id_E9B2(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_5)) {
    level thread _id_FBEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
  }

  _id_FB36(var_1, var_2, var_4);
}

_id_FBEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(self._id_4982)) {
    return;
  }
  if(!isDefined(level._id_4158)) {
    return;
  }
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = self[[level._id_422F]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10);

    if(!istrue(var_11)) {
      return;
    }
  }
}

_id_FB36(var_0, var_1, var_2) {
  if(isDefined(level._id_FB36)) {
    [[level._id_FB36]](var_0, var_1, var_2);
  } else {
    _id_FBA5(var_0, var_1, var_2);
  }
}

_id_FBA5(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }
  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }
  _id_072C::_id_FBD9(_id_072C::_id_67C3(), "damage_done_on_alien", var_1);

  if(isPlayer(var_0)) {
    var_0 _id_072C::_id_FBA7("personal", "damage_done_on_alien", var_1);
  } else if(isDefined(var_0.owner)) {
    var_0.owner _id_072C::_id_FBA7("personal", "damage_done_on_alien", var_1);
  }
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C96;

  if(isDefined(var_5) && (var_5 && level._id_7CA3)) {
    var_6 = 0.6 * var_4;
  } else {
    var_6 = var_4;
  }

  var_6 = _id_743D(var_2, var_3, var_6);
  var_6 = _id_746C(var_2, var_3, var_6);
  var_6 = _id_7453(var_2, var_3, var_6);
  return var_6;
}

_id_746C(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "bomb_site_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
      self._id_8EE2 = 1;
      var_3 = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self._id_8EE2 = 0;
      var_3 = var_3 * 2;
      break;
  }

  return var_3;
}

_id_7453(var_0, var_1, var_2) {
  if(_func_010F(var_1)) {
    switch (var_0.basename) {
      case "c4_mp_p":
        var_2 = var_2 * 3;
        break;
      case "bouncing_betty_mp":
      case "frag_grenade_mp":
      case "semtex_mp":
        var_2 = var_2 * 4;
        break;
      default:
        if(var_0._id_0245) {
          var_2 = var_2 * 3;
        }

        break;
    }
  }

  return var_2;
}

_id_7468(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  return var_2;
}

_id_743D(var_0, var_1, var_2) {
  return var_2;
}

_id_741D(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;
  var_5 = 1;

  if(isDefined(var_3) && isDefined(var_3.class) && var_3.class == "engineer" && isDefined(var_1) && scripts\engine\utility::_id_8794(var_1)) {
    var_4 = var_4 + var_5;
  } else {
    var_6 = level._id_1B5C - 1;

    if(scripts\cp\utility::_id_8866(var_0, var_1, var_3)) {
      var_4 = var_4 + var_6;
    }

    if(isDefined(level._id_1B5D)) {
      var_7 = level._id_1B5D - 1;

      if(isDefined(var_3) && var_3 scripts\cp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\cp\cp_weapon::_id_89C7(var_0) && scripts\engine\utility::_id_8794(var_1)) {
        var_4 = var_4 + var_7;
      }
    }
  }

  return var_2 * var_4;
}

_id_7492(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return var_2;
  }

  if(var_0.basename == "none") {
    return var_2;
  }

  if(weaponclass(var_0) != "spread") {
    return var_2;
  }

  return int(min(150, var_2));
}

_id_1B58(var_0, var_1, var_2) {
  return 1.0;
}

_id_886D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(level._id_364C) && isDefined(level._id_36AE) && isDefined(level._id_36AE[0]) && isDefined(level._id_36AE[0]._id_F81F)) {
    if(level._id_364C == var_1) {
      return 0;
    }

    if(scripts\engine\utility::is_equal(level._id_36AE[0], var_1)) {
      return 0;
    }

    if(scripts\engine\utility::is_equal(level._id_36AE[0]._id_F81F, var_1)) {
      return 0;
    }
  }

  if(!level.teambased) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

_id_5B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!_id_2F33(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self)) {
    if(var_2 >= self.health) {
      if(_id_8ACF()) {
        if(!isDefined(var_7)) {
          var_7 = (0, 0, 0);
        }

        if(!isDefined(var_1)) {
          var_1 = self;
        }

        if(!isDefined(var_0)) {
          var_0 = var_1;
        }

        scripts\cp\utility::_id_1566(1);
        var_14 = self _meth_8260(var_0, var_4, var_5, var_8, var_7);
        self._id_59E0 = 1;
        self._id_DBD8 = 1;
        self notify("faux_dead");

        if(!isDefined(self._id_A546)) {
          self._id_25CA = self cloneplayer(var_14, var_1);
        }

        if(!isDefined(self._id_A546) && isDefined(self._id_25CA)) {
          self._id_25CA._id_0481 = "player_corpse";
          self playerhide();
          self _meth_852B(0);
          thread _id_0D84(self._id_25CA, var_4, var_0);
        }

        if(_id_8ACF()) {
          thread _id_B9C7();
          self waittill("stopped_using_remote");
          var_2 = self.health + 100000;

          if(var_8 == "shield") {
            var_8 = "torso_upper";
          }
        }

        self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        self _meth_852B(1);
        scripts\cp\utility::_id_1566(0);
      } else if(isDefined(level._id_4233) && _func_03AC(level._id_4233)) {
        self.health = 1;
        var_2 = 0;
        self[[level._id_4233]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        var_2 = self.health + 100000;

        if(var_8 == "shield") {
          var_8 = "torso_upper";
        }

        self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(istrue(self._id_88DF)) {
        self waittill("juggernaut_end");
        self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(isDefined(self.vehicle)) {
        scripts\engine\utility::_id_108A8(2, "exited_vehicle", "vehicle_exit");
        self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else
        self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    } else
      self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  }

  _id_4327(var_0, var_5, var_4, var_2, var_3, var_1);
}

_id_0D84(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_3 = var_0 _meth_8121();
  var_4 = undefined;
  var_5 = _func_0079(var_3);
  var_6 = undefined;
  var_7 = _func_0011(var_3, "delete_corpse");
  var_8 = _func_0011(var_3, "delete_corpse_delayed");
  var_9 = _func_0011(var_3, "no_ragdoll");
  var_10 = _func_0011(var_3, "start_ragdoll");
  var_4 = 0;

  if(var_10) {
    var_11 = _func_00BB(var_3, "start_ragdoll")[0];
    var_4 = var_11 * var_5;
  }

  wait(var_4);

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0 _meth_81DF()) {
    var_0 startragdoll();
  }

  if(var_7 || var_8) {
    var_12 = var_5;

    if(var_8) {
      var_5 = var_5 + 3;
    }

    if(isDefined(var_4)) {
      var_12 = var_12 - var_4;
    }

    wait(var_12);
    var_0 delete();
  } else
    var_0 _meth_8364();
}

_id_2F33(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_8FB7) && self._id_8FB7 && var_2 >= self.health && isDefined(self._id_3AB0) && self._id_3AB0 == "specialty_endgame") {
    scripts\cp\utility::_id_6FC2("specialty_endgame");
    return 0;
  }

  return 1;
}

_id_B9C7() {
  self endon("disconnect");
  self endon("death");
  self endon("laststand");
  self waittill("stopped_using_remote");
  wait 0.1;

  if(!self.inlaststand) {
    self suicide();
  }
}

_id_4327(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_ABD9(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

_id_ABD9(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");

  switch (var_1) {
    default:
      if(_id_15D4(var_1) && !isai(var_4)) {
        scripts\cp\cp_weapon::_id_D9D4(var_2, var_3);
      }

      break;
  }
}

_id_15D4(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "iw7_zapper_grey":
      case "chopper_boss_minigun_cp":
        return 0;
    }
  }

  return 1;
}

_id_8A8B(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var_0.basename) {
    case "cryo_mine_mp":
    case "blackout_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_mp":
      return 0;
    default:
      return 0;
  }
}

_id_42D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_09BF::_id_ADCA(var_0, var_1, undefined, var_2, var_3, var_4);

  if(var_3 == "MOD_GRENADE") {
    return 1;
  }

  if(var_3 == "MOD_PROJECTILE") {
    return 1;
  }

  if(isDefined(var_0) && var_0 == var_1) {
    return 1;
  }

  if(var_1 _id_09BF::_id_8A6A(var_6)) {
    return 1;
  }

  if(_id_10DA2(var_2, var_5)) {
    return 1;
  }

  return 0;
}

_id_10DA2(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\cp\utility::_id_8A7D(var_2)) {
    return 1;
  }

  switch (var_2) {
    case "bradley_tow_proj_mp":
    case "thermite_av_mp":
    case "artillery_mp":
    case "sentry_shock_mp":
    case "toma_proj_mp":
    case "thermite_ap_mp":
    case "cruise_proj_mp":
    case "apache_proj_mp":
    case "apache_turret_mp":
    case "snapshot_grenade_mp":
    case "bomb_site_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "thermite_mp":
      return 1;
    default:
      return 0;
  }
}

_id_A008(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("#x359267b7c2defc390");
    var_3 = int(var_3);
  }

  if(isDefined(level._id_A00C) && _func_0107(level._id_A00C)) {
    foreach(var_12 in level._id_A00C) {
      var_3 = [[var_12]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(level._id_A00B)) {
    var_3 = [[level._id_A00B]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
  }

  if(!isDefined(var_2._id_4D71)) {
    var_3 = int(var_3 * var_2 scripts\cp\utility::_id_69C1(var_0, var_1, var_2, var_3, var_5, var_6, var_9));
  }

  if(scripts\cp\utility::_id_86C9()) {
    return var_3;
  }

  if(isPlayer(self)) {
    if(isDefined(var_1) && isagent(var_1) && !_func_010F(var_5) && !_id_881E(var_1) && !istrue(var_5 == "MOD_MELEE")) {
      var_3 = var_3 * 0.5;
    }
  }

  return var_3;
}

_id_430B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_6ACC();
  _id_5240();
  wait(var_7);
  _id_4A8E();
}

_id_DB2B(var_0) {
  if(scripts\engine\utility::_id_546E("player_zero_attacker_accuracy")) {
    return 0;
  }

  if(_id_4303(1)) {
    return 0;
  }

  return 1;
}

_id_6ACC() {
  return self._id_7235._id_8535;
}

_id_5240() {
  scripts\engine\utility::_id_5474("player_zero_attacker_accuracy");
  self._id_0074 = 0;
  self._id_022F = 1;
}

_id_4A8E() {
  scripts\engine\utility::_id_5470("player_zero_attacker_accuracy");
  _id_072D::_id_FBAA();
}

_id_440B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_69CB();
  var_8 = _id_69C9();

  if(!scripts\cp\utility::_id_86C9()) {
    var_7 = getdvarint("#x3ebefe88a61124dff", 1);
  }

  _id_D4F9(1, 1);
  _id_5240();
  _id_5243();
  var_9 = level._id_5F3A * 1000 * 40;
  self._id_4329 = gettime() + var_9;

  if(!istrue(self._id_11B4)) {
    _id_10752(var_7, "force_regeneration");
  }

  _id_D4F9(1, 0);
  _id_4A8E();

  if(!istrue(self._id_11B4)) {
    _id_10752(var_8, "force_regeneration");
  }

  _id_4A97();
}

_id_10752(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
}

_id_69C9() {
  return self._id_7235._id_4404;
}

_id_69CB() {
  return self._id_7235._id_8532 * self._id_7235._id_CF6E;
}

_id_5243() {
  _id_D4F9(2, 1);

  if(!scripts\cp_mp\utility\player_utility::_id_B667()) {
    var_0 = 0.5;
    var_1 = 2 + _id_69C9() + _id_6A94() - var_0;
    thread _id_4405(var_1);
    var_2 = 0.5;
    var_3 = var_1 - var_2;
    thread _id_25B1(1, var_3, var_2);
    _id_FC4C();
    self painvisionon();
  }
}

_id_4405(var_0) {
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("disconnect");
  var_1 = 1;
  thread _id_91D3(var_0);

  while(var_1 > 0) {
    var_2 = gettime();
    var_3 = var_2;
    var_4 = scripts\engine\math::_id_5898(1000, 600, self._id_4408);

    while(var_2 < var_3 + var_4) {
      var_2 = gettime();
      var_5 = 0.1;
      var_6 = 0.4;
      var_7 = (var_2 - var_3) / var_4;
      var_8 = scripts\engine\math::_id_A5C7(var_7);
      var_1 = scripts\engine\math::_id_5898(var_5, var_6, var_8);
      var_1 = var_1 * self._id_4408;
      self.damage._id_4405 fadeovertime(0.05);
      self.damage._id_4405.alpha = var_1;
      waitframe();
    }
  }
}

_id_4406() {
  self.damage._id_4405 fadeovertime(0.05);
  self.damage._id_4405.alpha = 0.7;
  waitframe();
  self.damage._id_4405 fadeovertime(0.5);
  self.damage._id_4405.alpha = 0.4;
}

_id_25B1(var_0, var_1, var_2) {
  if(scripts\common\utility::_id_8B11()) {
    return;
  }
  self endon("stopPainOverlays");
  self.damage._id_25B1 fadeovertime(0.05);
  self.damage._id_25B1.alpha = var_0;
  _id_10752(var_1, "force_regeneration");

  if(var_2 <= 0) {
    var_2 = 1;
  }

  self.damage._id_25B1 fadeovertime(var_2);
  self.damage._id_25B1.alpha = 0;
}

_id_FC4C() {
  if(!_id_4303(2)) {
    return 0;
  }

  if(self _meth_8632() || scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_nvg"), 0);
  } else {
    visionsetpain("pain_mp");
  }
}

_id_4A97(var_0) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    var_1 = _id_6A94();
  } else {
    var_1 = 0.0;
  }

  var_2 = _id_6E45(var_1);
  _id_D4F9(2, 0);
}

_id_6E45(var_0) {
  var_1 = 1 / max(0.01, var_0);
  return clamp(var_1, 0, 30);
}

_id_91D3(var_0) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("disconnect");
  var_1 = var_0;
  self._id_4408 = 1;

  while(var_1 > 0) {
    self._id_4408 = scripts\engine\math::_id_A5C5(0, var_0, var_1);
    self._id_4408 = scripts\engine\math::_id_A5CA(self._id_4408);
    var_1 = var_1 - 0.05;
    waitframe();
  }

  self._id_4408 = 0;
}

_id_DAF6(var_0) {
  if(scripts\engine\utility::_id_5C0C("disable_death_shield") && scripts\engine\utility::_id_5C00("disable_death_shield")) {
    return 0;
  }

  if(_id_4303(1)) {
    return 0;
  }

  if(_id_4303(2)) {
    return 0;
  }

  return 1;
}

_id_4303(var_0) {
  return self.damage._id_01C4 &var_0;
}

_id_D4F9(var_0, var_1) {
  if(var_1) {
    self.damage._id_01C4 = self.damage._id_01C4 | var_0;
  } else {
    self.damage._id_01C4 = self.damage._id_01C4 &~var_0;
  }
}

_id_8260() {
  _id_8263();
  _id_825F();
  self setclientomnvar("ui_gettocover_state", 0);
  self setclientomnvar("ui_gettocover_text", "game/get_to_cover");
}

_id_8263() {
  scripts\engine\utility::_id_5473("global_hint_in_use");
  scripts\engine\utility::_id_5473("player_zero_attacker_accuracy");
}

_id_825F() {
  self.damage = spawnStruct();
  self.damage._id_7D55 = scripts\engine\utility::_id_E1E9();
  self.damage._id_7D55 linkto(self);
  self.damage._id_BE25 = scripts\engine\utility::_id_E1E9();
  self.damage._id_BE25 linkto(self);
  self.damage._id_0F59 = [];
  self.damage._id_01C4 = 0;
  self.damage._id_5B68 = 0;
  self.damage._id_5B76 = 100;
  self.damage._id_164D = 0;
  self.damage._id_8FBD = -99999;
  _id_8178();
  _id_817A();
  _id_814F();
}

_id_8178() {
  self.damage._id_AD22 = newclienthudelem(self);
  self.damage._id_AD22.sort = 2;
  self.damage._id_AD22.x = 0;
  self.damage._id_AD22.y = 0;
  self.damage._id_AD22.alignx = "left";
  self.damage._id_AD22.aligny = "top";
  self.damage._id_AD22._id_01D6 = 0;
  self.damage._id_AD22.horzalign = "fullscreen";
  self.damage._id_AD22.vertalign = "fullscreen";
  self.damage._id_AD22.alpha = 0;
  self.damage._id_AD22._id_018D = 1;
  self.damage._id_AD22._id_0288 = 1;
  self.damage._id_AD22 setshader("ui_player_pain_damage_overlay", 640, 480);
}

_id_8192() {
  self.damage._id_5B6D = newclienthudelem(self);
  self.damage._id_5B6D.sort = -1;
  self.damage._id_5B6D.x = 0;
  self.damage._id_5B6D.y = 0;
  self.damage._id_5B6D.alignx = "left";
  self.damage._id_5B6D.aligny = "top";
  self.damage._id_5B6D._id_01D6 = 0;
  self.damage._id_5B6D.horzalign = "fullscreen";
  self.damage._id_5B6D.vertalign = "fullscreen";
  self.damage._id_5B6D.alpha = 0;
  self.damage._id_5B6D._id_018D = 1;
  self.damage._id_5B6D._id_0288 = 1;
  self.damage._id_5B6D setshader("ui_player_pain_fire_overlay", 640, 480);
}

_id_8194() {
  self.damage._id_5B86 = newclienthudelem(self);
  self.damage._id_5B86.sort = -2;
  self.damage._id_5B86.x = 0;
  self.damage._id_5B86.y = 0;
  self.damage._id_5B86.alignx = "left";
  self.damage._id_5B86.aligny = "top";
  self.damage._id_5B86._id_01D6 = 0;
  self.damage._id_5B86.horzalign = "fullscreen";
  self.damage._id_5B86.vertalign = "fullscreen";
  self.damage._id_5B86.alpha = 0;
  self.damage._id_5B86._id_018D = 1;
  self.damage._id_5B86._id_0288 = 1;
  self.damage._id_5B86 setshader("ui_player_pain_impact_overlay", 640, 480);
}

_id_817A() {
  self.damage._id_4405 = newclienthudelem(self);
  self.damage._id_4405.sort = 0;
  self.damage._id_4405.x = 0;
  self.damage._id_4405.y = 0;
  self.damage._id_4405.alignx = "left";
  self.damage._id_4405.aligny = "top";
  self.damage._id_4405._id_01D6 = 0;
  self.damage._id_4405.horzalign = "fullscreen";
  self.damage._id_4405.vertalign = "fullscreen";
  self.damage._id_4405.alpha = 0;
  self.damage._id_4405._id_018D = 1;
  self.damage._id_4405._id_0288 = 1;
  self.damage._id_4405 setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

_id_814F() {
  self.damage._id_25B1 = newclienthudelem(self);
  self.damage._id_25B1.sort = 1;
  self.damage._id_25B1.x = 0;
  self.damage._id_25B1.y = 0;
  self.damage._id_25B1.alignx = "left";
  self.damage._id_25B1.aligny = "top";
  self.damage._id_25B1._id_01D6 = 0;
  self.damage._id_25B1.horzalign = "fullscreen";
  self.damage._id_25B1.vertalign = "fullscreen";
  self.damage._id_25B1.alpha = 0;
  self.damage._id_25B1._id_018D = 1;
  self.damage._id_25B1._id_0288 = 1;
  self.damage._id_25B1 setshader("ui_player_pain_blood_overlay", 640, 480);
}

_id_4333(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  childthread _id_EDAA(var_0, var_1, var_2, var_3, var_4);
}

_id_EDAA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();

  if(_id_DBD1(var_5)) {
    self setclientomnvar("ui_gettocover_state", 1);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 2);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 3);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 4);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 5);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 0);
  }
}

_id_DBD1(var_0, var_1) {
  if(_id_8ACF()) {
    return 0;
  }

  if(self _meth_81CC()) {
    return 0;
  }

  if(self.ignoreme) {
    return 0;
  }

  if(isDefined(self.vehicle)) {
    return 0;
  }

  if(!_id_4303(1)) {
    return 0;
  }

  if(_id_4303(8)) {
    return 0;
  }

  if(istrue(self._id_4AF2)) {
    return 0;
  }

  return 1;
}

_id_42F9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1) || _id_8ACF()) {
    return;
  }
  var_7 = [::_id_4321, ::_id_42E6, ::_id_4317, ::_id_4323, ::_id_FC4A, ::_id_432B];
  var_8 = _id_4320(var_0);

  foreach(var_10 in var_7) {
    self childthread[[var_10]](var_1.origin, var_8, var_4);
  }
}

_id_4320(var_0) {
  return scripts\engine\math::_id_A5C5(40, 160, var_0 / self._id_014A);
}

_id_4324(var_0, var_1, var_2) {
  self endon("damageDefault");

  if(!_id_0707::_id_B4C3(self)) {
    var_3 = "plr_proto_bullet_impact";
    var_4 = "plr_breath_pain_init";
  } else {
    var_3 = "plr_proto_bullet_impact_armor";
    var_4 = "plr_proto_yell_armor";
  }

  self.damage._id_7D55 playSound(var_3);
  wait 0.25;

  if(!_id_4303(4)) {
    var_5 = scripts\engine\math::_id_5898(0.75, 1.75, var_1);
    self.damage._id_7D55 playSound(var_4);
    _id_D4F9(4, 1);
    scripts\engine\utility::delaythread(3.0, ::_id_D4F9, 4, 0);
  }
}

_id_4321(var_0, var_1, var_2) {
  if(var_1 > 0.4) {
    self playrumbleonentity("damage_heavy");
  } else {
    self playrumbleonentity("damage_light");
  }
}

_id_431F(var_0, var_1, var_2) {
  self endon("stopPainOverlays");

  if(_id_4303(32)) {
    return;
  }
  var_3 = scripts\engine\math::_id_5898(0.045, 0.045, var_1);
  var_4 = scripts\engine\math::_id_5898(0.09, 0.09, var_1);
  var_5 = scripts\engine\math::_id_5898(0.2, 0.2, var_1);
  _id_BF16(var_3, var_4, var_5, var_0);
}

_id_BF16(var_0, var_1, var_2, var_3, var_4) {
  self notify("radialDistortion");
  self endon("radialDistortion");
  self setclientdvar("#x33988eef3bc809a98", var_0);
  self setclientdvar("#x320c6aa95071ea85d", -1);
  self setclientdvar("#x31f9ba2c1834330ea", var_1);

  if(isDefined(var_3)) {
    self setclientdvar("#x3296347cda302e6ee", 1);
    self setclientdvar("#x325c41e6cfadc52dc", var_3);
  }

  if(isDefined(var_4)) {
    if(_func_0121(var_4)) {
      self endon(var_4);
      thread _id_C511(var_4);
    } else if(_func_0107(var_4)) {
      foreach(var_6 in var_4) {
        self endon(var_6);
        thread _id_C511(var_6);
      }
    }
  }

  if(isDefined(var_2)) {
    _id_C510(var_2);
  }
}

_id_91BD(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  self notify(var_0 + "_lerp_savedDvar");
  self endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_3 = var_3 + var_7;
      self setclientdvar(var_0, var_3);
      wait(var_5);
    }
  }

  self setclientdvar(var_0, var_1);
}

_id_C510(var_0) {
  childthread _id_91BD("#x33988eef3bc809a98", 0, var_0);
  childthread _id_91BD("#x320c6aa95071ea85d", 0, var_0);
  childthread _id_91BD("#x31f9ba2c1834330ea", 0, var_0);
  childthread _id_91BD("#x3296347cda302e6ee", 0, var_0);
}

_id_C511(var_0) {
  self waittill(var_0);
  self setclientdvar("#x33988eef3bc809a98", 0);
  self setclientdvar("#x320c6aa95071ea85d", 0);
  self setclientdvar("#x31f9ba2c1834330ea", 0);
  self setclientdvar("#x3296347cda302e6ee", 0);
}

_id_4317(var_0, var_1, var_2) {
  self endon("damageDefault");

  if(!_id_DB3B()) {
    return 0;
  }

  if(!_id_0707::_id_74D5(self)) {
    if(self _meth_8632() || scripts\cp_mp\utility\game_utility::isnightmap()) {
      visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_nvg"), 0);
    } else {
      visionsetpain("pain_mp");
    }

    var_3 = scripts\engine\math::_id_5898(0.0, 0.0, var_1);
    var_4 = scripts\engine\math::_id_5898(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::_id_5898(0.05, 0.05, var_1);
  } else {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "pain_mp_night", "damage_armor"), 0);
    var_3 = scripts\engine\math::_id_5898(0.0, 0.0, var_1);
    var_4 = scripts\engine\math::_id_5898(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::_id_5898(0.05, 0.05, var_1);
  }

  self painvisionon();
  wait(var_5);
  self painvisionoff();
}

_id_DB3B() {
  if(_id_4303(2)) {
    return 0;
  }

  if(self.health == 1) {
    return 0;
  }

  return 1;
}

_id_4323(var_0, var_1, var_2) {
  var_3 = scripts\engine\math::_id_5898(0.82, 1.2, var_1);
  var_4 = scripts\engine\math::_id_5898(0.65, 0.8, var_1);
  var_5 = scripts\engine\math::_id_5898(0.68, 1.25, var_1);
  var_6 = scripts\engine\math::_id_5898(1.12, 1.85, var_1);
  var_7 = scripts\engine\math::_id_5898(0.1, 0.32, var_1);
  var_8 = var_6 - var_7 - 0.05;

  if(_func_010F(var_2)) {
    var_3 = var_3 * 5;
    var_4 = var_4 * 5;
    var_5 = var_5 * 5;
  }
}

_id_FC4A(var_0, var_1, var_2) {
  self endon("damageDefault");
  self endon("stopPainOverlays");

  if(scripts\cp_mp\utility\player_utility::_id_B667()) {
    return;
  }
  if(!_id_0707::_id_74D5(self)) {
    self.damage._id_AD22 setshader("ui_player_pain_damage_overlay", 640, 480);
    var_3 = 0.8;
  } else {
    self.damage._id_AD22 setshader("ui_player_pain_damage_overlay", 640, 480);
    var_3 = 0.6;
  }

  self.damage._id_AD22 fadeovertime(0.05);
  self.damage._id_AD22.alpha = max(self.damage._id_AD22.alpha, var_3);
  wait 0.05;
  var_4 = scripts\engine\math::_id_5898(0.2, 0.2, var_1);
  self.damage._id_AD22 fadeovertime(var_4);
  self.damage._id_AD22.alpha = 0;
}

_id_42E6(var_0, var_1, var_2) {
  _id_42E8(var_0, var_1, var_2);
}

_id_42E7(var_0, var_1, var_2) {
  if(scripts\common\utility::_id_8B11()) {
    return;
  }
  var_3 = gettime();

  if(var_3 - self.damage._id_8FBD < 200) {
    return;
  } else {
    self.damage._id_8FBD = var_3;
  }

  var_4 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH"];
  var_5 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  var_6 = _id_6C5E(var_0);
  var_7 = "";

  if(scripts\engine\utility::array_contains(var_4, var_1)) {
    return;
  }
  if(scripts\engine\utility::array_contains(var_5, var_1)) {
    var_8 = "fullscreen_dirt_";
  } else if(!_id_0707::_id_74D5(self)) {
    var_8 = "fullscreen_blood_";

    if(self.damage._id_164D) {
      var_7 = "_alt";
      self.damage._id_164D = 0;
    } else
      self.damage._id_164D = 1;
  } else
    var_8 = "fullscreen_armor_";

  if(!isDefined(var_2)) {
    var_2 = 2.0;
  }

  foreach(var_13, var_1 in var_6) {
    var_10 = var_8 + var_13;
    var_11 = var_10 + "_splash";
    var_10 = var_10 + var_7;
    var_12 = _id_4044(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    _id_4042(var_13, var_10, 0.15, var_2, var_12, 1);
    _id_4042(var_13, var_11, 0.15, 0.15, var_12, 0);
  }
}

_id_42E8(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\player_utility::_id_B667()) {
    return;
  }
  if(_id_4303(2)) {
    return;
  }
  if(istrue(self._id_88DF)) {
    return;
  }
  var_3 = scripts\engine\math::_id_5898(0.6, 0.3, _id_7641());
  var_4 = _id_6A92();
  var_5 = _id_6A94();
  thread _id_25B1(var_3, var_4, var_5);
}

_id_432B(var_0, var_1, var_2) {
  if(_func_010F(var_2)) {
    var_3 = scripts\engine\math::_id_5898(2, 3, var_1);
    self shellshock("explosion_nosound", var_3);
  }
}

_id_7641() {
  return self.health / self.maxhealth;
}

_id_4042(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 3;
  var_6._id_01D6 = 0;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = 0;
  var_6._id_018D = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::_id_5898(0.9, 1.0, var_4["scale"]);

  switch (var_0) {
    case "left":
      var_6.aligny = "top";
      var_6.alignx = "left";
      var_7 = -640;
      var_8 = scripts\engine\math::_id_5898(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::_id_5898(-55, 0, var_4["x"]);
      break;
    case "right":
      var_6.aligny = "top";
      var_6.alignx = "right";
      var_7 = 1280;
      var_8 = scripts\engine\math::_id_5898(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::_id_5898(0, 55, var_4["x"]) + 640;
      break;
    case "bottom":
      var_6.aligny = "bottom";
      var_6.alignx = "left";
      var_8 = 960;
      var_7 = scripts\engine\math::_id_5898(-50, 50, var_4["x"]);
      var_10 = scripts\engine\math::_id_5898(0, 50, var_4["y"]);
      var_10 = var_10 + 480;
      var_9 = var_7;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1);
  thread _id_CC6C(var_6);
}

_id_1882(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("destroySreenEffectOverlay");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait(var_1);
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait(var_2 + 0.05);
  var_0 notify("destroySreenEffectOverlay");
}

_id_CC6C(var_0) {
  self.damage._id_0F59 = scripts\engine\utility::array_add(self.damage._id_0F59, var_0);
  var_0 waittill("destroySreenEffectOverlay");
  self.damage._id_0F59 = scripts\engine\utility::array_remove(self.damage._id_0F59, var_0);
  var_0 destroy();
}

_id_4044(var_0, var_1, var_2) {
  var_3 = [];
  var_3["x"] = var_0;
  var_3["y"] = var_1;
  var_3["scale"] = var_2;
  return var_3;
}

_id_6C5E(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];

  if(abs(var_4) > 0.819152) {
    var_6["bottom"] = 1;
  } else if(var_5 > 0) {
    var_6["right"] = 1;
  } else {
    var_6["left"] = 1;
  }

  return var_6;
}

_id_AA31(var_0, var_1) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self._id_D081) && self._id_D081) {
    wait 0.2;
  }

  if(scripts\cp\utility::_id_8894()) {
    return;
  }
  var_2 = spawnStruct();
  scripts\cp\utility::_id_6CE7(var_2);
  wait(var_2._id_0F03);
  var_3 = gettime();

  for(;;) {
    var_4 = _id_073B::_id_6A8F();
    var_2 = spawnStruct();
    scripts\cp\utility::_id_6CE7(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2._id_C1B4);

      if(var_5 > var_4) {
        var_5 = var_4;
      }

      self.health = var_5;
    } else
      break;

    scripts\engine\utility::_id_108A7(var_2._id_10973, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level._id_B6DF)) {
    self[[level._id_B6DF]]();
  }

  scripts\cp\utility::_id_C602();
}

_id_3D69() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("faux_dead");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10898("damage", "health_perk_upgrade", "force_regeneration");

    if(var_0 == "force_regeneration") {
      _id_C1BC();
      continue;
    }

    if(!scripts\cp\utility::_id_31BC()) {
      continue;
    }
    _id_C1B2();
    _id_C1BC();
  }
}

_id_C1B2() {
  self endon("force_regeneration");
  var_0 = _id_6A92();
  wait(var_0);

  while(_id_4303(2) || _id_4303(32)) {
    waitframe();
  }
}

_id_C1BC() {
  var_0 = self.health;
  thread scripts\cp\utility::_id_2BA0(gettime(), _id_7641());

  while(self.health < self.maxhealth) {
    var_1 = _id_6A93();
    var_2 = var_1 * 0.05;
    var_0 = clamp(var_0 + var_2, 0, self.maxhealth);
    _id_D29F(var_0 / self.maxhealth);
    waitframe();
  }

  self notify("healed");
}

_id_6A93() {
  var_0 = 1;

  if(istrue(self._id_11B4)) {
    var_0 = var_0 * 10;
  } else if(scripts\cp\utility::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    if(isDefined(self._id_3B87) && self._id_3B87 > 2) {
      var_0 = var_0 * 2;
    }
  }

  return var_0 * self._id_7235._id_764A;
}

_id_6A3A() {
  return self._id_7235._id_763D;
}

_id_6A39() {
  return self._id_7235._id_763C;
}

_id_6A94() {
  var_0 = self.maxhealth - self.health;
  var_1 = var_0 / _id_6A93();
  return var_1;
}

_id_6A92() {
  return self._id_7235._id_7644;
}

_id_D29F(var_0) {
  self _meth_835A(var_0);
  self._id_8FE9 = self.health;
}