/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1788.gsc
*************************************************/

_id_C1C3() {
  level._id_11EF["soldier_agent"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["soldier_agent"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["soldier_agent"]["gametype_on_killed"] = ::_id_2F55;
  level._id_11EF["soldier"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["soldier"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["soldier"]["gametype_on_killed"] = ::_id_2F55;
  level._id_11EF["civilian"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["civilian"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["civilian"]["gametype_on_killed"] = ::_id_2F55;
  level._id_11EF["juggernaut_agent"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["juggernaut_agent"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["juggernaut_agent"]["gametype_on_killed"] = ::_id_2F55;
  level._id_11EF["juggernaut"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["juggernaut"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["juggernaut"]["gametype_on_killed"] = ::_id_2F55;
  level._id_11EF["suicidebomber"]["on_damaged"] = ::_id_2F53;
  level._id_11EF["suicidebomber"]["gametype_on_damage_finished"] = ::_id_2F54;
  level._id_11EF["suicidebomber"]["gametype_on_killed"] = ::_id_2F55;
}

_id_2F53(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13._id_1210)) {
    return;
  }
  if(_id_08DF::_id_75C2() && isPlayer(var_1)) {}

  if(!isDefined(var_12)) {
    var_12 = var_5;
  }

  if(var_4 != "MOD_SUICIDE") {
    if(scripts\cp\utility::_id_85D9(var_13, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_13;
  }

  var_14 = _id_DA89(var_1, var_2, var_4, var_5, var_8, var_13);

  if(!var_14) {
    return;
  }
  var_3 = var_3 | 4;
  var_15 = var_2;
  var_16 = isDefined(var_13._id_1210);
  var_17 = var_12.basename;
  var_18 = var_12.classname;
  var_19 = _id_85C3();
  var_20 = istrue(var_1.inlaststand);
  var_21 = var_4 == "MOD_MELEE";
  var_22 = var_13 scripts\cp\utility::_id_1217();
  var_23 = scripts\engine\utility::_id_8794(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_24 = isDefined(var_1) && isPlayer(var_1);
  var_25 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_26 = isDefined(var_1) && isDefined(var_1._id_1210) && var_1._id_1210 == "soldier_agent";
  var_27 = isDefined(var_13._id_04B9) && var_13._id_04B9 == "juggernaut";
  var_28 = var_23 && scripts\cp\utility::_id_8891(var_12, var_8, var_4, var_1);
  var_29 = var_4 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_30 = var_4 == "MOD_FIRE";
  var_31 = 0;
  var_32 = var_24 && var_1 scripts\cp\utility::_hasperk("specialty_bulletdamage");
  var_33 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_34 = var_33 && var_4 == "MOD_CRUSH";
  var_35 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && !isDefined(var_1.owner);
  var_36 = var_35 && var_4 == "MOD_CRUSH";

  if((var_24 || var_25) && istrue(var_13._id_852E) && var_4 != "MOD_SUICIDE") {
    return;
  }
  if(var_27) {
    if(var_21) {
      var_37 = [];
      var_38 = spawnStruct();
      var_38.type = "break_stealth_with_no_damage";
      var_38._id_019B = var_1;
      var_37[0] = var_38;
      var_13 notify("ai_events", var_37);
      return;
    } else {
      if(var_17 == "thermite_ap_mp" || var_17 == "thermite_proj_cp") {
        var_2 = var_2 * 15;
      }

      if(var_17 == "cruise_proj_mp") {
        var_2 = self.health + 1000;
      }
    }

    if(var_34) {
      var_39 = ["atv"];

      if(scripts\engine\utility::array_contains(var_39, var_1._id_1031E)) {
        var_1 dodamage(10000, var_1.origin, var_13);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        var_2 = self.health + 1000;
      }
    }
  } else if(var_24) {
    if(var_17 == "throwingknife_mp") {
      var_2 = self.health + 1000;
    }
  }

  if(istrue(self._id_24F9)) {
    if(_id_748E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
      return;
    }
    if(var_8 == "shield" && (var_4 == "MOD_GRENADE" || var_4 == "MOD_PROJECTILE") && var_2 > 175) {
      var_2 = var_2 * 0.05;
      var_8 = "torso_lower";
    }
  }

  if(var_19) {
    if(var_17 == "emp_drone_player_mp") {
      var_2 = self.health + 1000;
    }
  }

  if(var_34) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");

    if(!istrue(level._id_7041)) {}
  }

  if(var_36) {
    if(istrue(self._id_852C)) {
      var_2 = 0;
      var_13 notify("veh_crush_damage", var_1);
    }
  }

  if(var_24) {
    var_13._id_42ED = 1;

    if(var_28) {
      if(var_27) {
        if(scripts\cp\utility::_id_86C9()) {
          var_2 = var_2 * 0.3;
        } else {
          var_2 = _id_1190(var_2, var_5, var_18, var_4, var_1);
        }
      }
    }

    if(var_32) {
      var_2 = var_2 * 2;
    }

    if(var_29) {
      var_2 = var_2 + var_2 * 2.5;
    }

    if(var_30) {
      var_2 = var_2 + var_2 * 3.5;
    }

    if(var_21) {
      if(istrue(var_13._id_7D49)) {
        var_2 = 0;
        var_13 notify("melee_hit_on_melee_immune", var_1);
      } else {
        var_2 = 150;
        var_2 = var_2 * var_1 _id_0945::_id_664E("melee_scalar");

        if(issubstr(var_17, "s4_ar_stango44")) {
          var_2 = 350;
        } else if(isDefined(var_12._id_02D8) && issubstr(var_12._id_02D8, "muzzlemelee")) {
          var_2 = 350;
        }
      }
    }

    if(var_23) {
      if(!var_28) {
        if(!isDefined(level._id_2D25)) {
          level._id_2D25 = 1;
        }

        var_2 = var_2 * level._id_2D25;
      }

      var_2 = var_2 * var_1 _id_0945::_id_664E("bullet_damage_scalar");
    }

    if(_id_8727()) {
      if(var_27 || var_8 == "torso_upper" || var_8 == "torso_lower") {
        var_2 = _id_071A::_id_741D(var_12, var_4, var_2, var_1);
        var_2 = var_2 * 0.5;
      }
    }

    if(var_2 < var_13.health) {
      var_1 _id_074E::_id_6F28(10, "large", var_8);
    } else if(var_24) {
      if(var_27 && !scripts\cp\utility::_id_86C9()) {
        thread _id_0709::_id_33BA();
      }

      thread _id_06FA::_id_0E6B(var_1, var_4, var_17);
    }

    var_40 = var_1 _id_0945::_id_664E("short_range_damage_scalar");

    if(var_40 > 1) {
      var_41 = distancesquared(var_1.origin, var_13.origin);

      if(var_41 < 40000) {
        var_2 = var_2 * var_40;
      }
    }
  }

  if(var_24 || var_25 || var_34) {
    if(!scripts\cp\utility::_id_86C9()) {
      if(var_25) {
        var_1 = var_1.owner;
      }

      _id_108F(self, var_1, var_0, var_12, var_2, var_6, var_7, var_8, var_9, var_4);
    }

    if(var_2 >= var_13.health) {
      if(var_12.basename == "none") {
        if(isDefined(var_0) && isDefined(var_0.weapon_name)) {
          var_12 = makeweapon(var_0.weapon_name);
        }
      }

      var_42 = spawnStruct();
      var_42._id_511D = var_0;
      var_42._id_50FF = var_1;
      var_42._id_7C8D = var_2;
      var_42._id_7C97 = var_3;
      var_42._id_DE2B = var_4;
      var_42._id_EC0F = var_5;
      var_42._id_106B7 = var_6;
      var_42._id_FFD4 = var_7;
      var_42._id_D9E0 = var_8;
      var_42._id_F21F = var_9;
      var_42._id_9FDA = var_10;
      var_42._id_031A = var_11;
      var_42.objweapon = var_12;
      thread _id_125B(var_42);
    }
  }

  if(!var_27 && var_31) {
    var_2 = self.health + 100;
  }

  if(isDefined(var_17) && var_17 == "tur_bradley_mp" && isDefined(var_4) && var_4 == "MOD_PROJECTILE_SPLASH") {
    var_2 = var_2 * 2;
  }

  if(isPlayer(var_1)) {
    _id_0752::_id_D58D(var_1, 1);

    if(isDefined(var_1.pers["participation"])) {
      var_1.pers["participation"]++;
    } else {
      var_1.pers["participation"] = 1;
    }

    if(isDefined(var_1.pers["periodic_xp_participation"])) {
      var_1.pers["periodic_xp_participation"]++;
    } else {
      var_1.pers["periodic_xp_participation"] = 1;
    }
  }

  var_43 = isDefined(var_4) && var_4 == "MOD_EXECUTION";

  if(var_43) {
    var_1 thread _id_0750::_id_10AE();
  }

  var_2 = _id_071A::_id_A008(var_0, var_1, var_13, var_2, var_3, var_4, var_12, var_6, var_7, var_8);
  _id_BD4D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  var_2 = int(min(var_2, var_13.maxhealth));

  if(isDefined(level._id_FCD7)) {
    level thread[[level._id_FCD7]](var_1, var_5, var_13, var_4, var_8, var_9);
  }

  if(_id_85D4(var_17, var_12, var_0) && var_4 == "MOD_GRENADE_SPLASH") {
    var_13 notify("flashbang", var_8, 1, undefined, var_1, "allies");
  }

  if(_id_85DE(var_17) && var_4 == "MOD_GRENADE_SPLASH") {
    var_13 notify("flashbang", var_8, 1, undefined, var_1, "allies");
  }

  if(isDefined(var_13._id_04B9) && isDefined(level._id_11EF[var_13._id_04B9]) && isDefined(level._id_11EF[var_13._id_04B9]["on_damaged_finished"])) {
    var_13[[level._id_11EF[var_13._id_04B9]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  } else {
    var_13[[level._id_11EF[var_13._id_1210]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  }
}

_id_BD4D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_13 endon("death");

  if(!isPlayer(var_1)) {
    return;
  }
  if(var_2 >= var_13.health) {
    if(!scripts\cp\utility::_id_86C9()) {
      var_1 thread _id_072A::_id_8D7A(undefined, self, var_12, var_4, var_0, 0);
    }
  }
}

_id_748E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_12.basename;
  var_14 = 0;

  if(isDefined(var_0) && (issubstr(var_13, "thermite") || isDefined(var_12._id_028D) && issubstr(var_12._id_028D, "boltfire") || isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "incendiary"))) {
    var_14 = 1;
    var_15 = var_8 == "shield";

    if(var_15) {
      var_16 = scripts\engine\trace::_id_3EE0();
      var_17 = vectornormalize(var_7);
      var_18 = var_6 - var_17 * 12;
      var_19 = var_6 + var_17 * 12;
      var_20 = scripts\engine\trace::_id_C051(var_18, var_19, undefined, var_16);

      if(var_20["fraction"] > 0 && var_20["fraction"] < 1) {
        var_21 = var_6 - self.origin;
        var_21 = (var_21[0], var_21[1], 0);

        if(vectordot(var_21, var_20["normal"]) < 0) {
          var_15 = 0;
        }
      } else
        var_15 = 0;
    }

    if(var_15) {
      var_22 = var_0 _meth_8151();

      if(isDefined(var_22) && var_22 == self) {
        self._id_24FA = 1;
        self._id_F104 = 0;
      }
    } else if(var_8 != "none") {
      self._id_24FA = undefined;
      self._id_F104 = undefined;
    }
  }

  if(var_8 == "shield") {
    if(var_14) {
      return 1;
    }
  } else if(var_8 == "none" && isDefined(var_0)) {
    var_23 = var_0 _meth_8151();

    if(istrue(self._id_24FA) && var_14 && isDefined(var_23) && var_23 == self) {
      if(!isDefined(self._id_F105)) {
        self._id_F105 = [var_0];
      } else if(!scripts\engine\utility::array_contains(self._id_F105, var_0)) {
        self._id_F105[self._id_F105.size] = var_0;
      }

      self._id_F104++;
      return 1;
    } else if(issubstr(var_13, "molotov")) {
      var_24 = var_0.origin - self.origin;
      var_25 = vectornormalize((var_24[0], var_24[1], 0));
      var_24 = vectornormalize(var_24);

      if(vectordot(anglesToForward(self.angles), var_25) > 0.5 && -0.98 < var_24[2] && var_24[2] < 0.98) {
        return 1;
      }
    }
  }

  if(var_4 == "MOD_MELEE") {
    if(isDefined(var_1)) {
      var_26 = vectornormalize(var_1.origin - self.origin);
    } else {
      var_26 = vectornormalize(var_6 - self.origin);
    }

    var_27 = anglesToForward(self.angles);

    if(vectordot(var_27, var_26) > 0.5) {
      return 1;
    }
  }

  return 0;
}

_id_1190(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  switch (var_2) {
    case "rifle":
      var_5 = min(var_0, 84);
      break;
    case "smg":
      var_5 = min(var_0, 110);
      break;
    case "mg":
      var_5 = min(var_0, 105);
      break;
    case "spread":
      var_5 = min(var_0, 84);
      break;
    case "pistol":
      var_5 = min(var_0, 75);
      break;
    case "sniper":
      var_5 = min(var_0, 130);
      break;
    default:
      var_5 = var_0;
      break;
  }

  return var_0;
}

_id_85C3() {
  return istrue(isDefined(self._id_04B9) && self._id_04B9 == "suicidebomber");
}

_id_3450() {
  level endon("game_ended");
  level._id_2D25 = 1;

  for(;;) {
    var_0 = getdvarfloat("#x3c16aa5ab050ca214", 1.0);

    if(level._id_2D25 != var_0) {
      level._id_2D25 = var_0;
    }

    wait 1;
  }
}

_id_C1C4() {
  _id_C1DE("weapon", ::_id_5004, ::_id_DA9E, 0);
}

_id_C1DE(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_125C)) {
    level._id_125C = [];
  }

  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4._id_33BD = var_2;
  var_4._id_6016 = var_1;
  var_4._id_038F = 0;
  var_4._id_4649 = var_3;
  var_4._id_A467 = 0;
  level._id_125C[level._id_125C.size] = var_4;
}

_id_125B(var_0) {
  if(!isDefined(level._id_125C)) {
    return;
  }
  if(isDefined(self._id_5E4B)) {
    var_1 = _id_64BB(self._id_5E4B);
    self thread[[var_1]](var_0);
  } else
    var_2 = _id_3451(var_0);
}

_id_64BB(var_0) {
  for(var_1 = 0; var_1 < level._id_125C.size; var_1++) {
    if(level._id_125C[var_1].name == var_0) {
      return level._id_125C[var_1]._id_6016;
    }
  }
}

_id_4FFB(var_0, var_1) {
  var_2 = gettime();
  self thread[[var_0._id_6016]](var_1);
  var_0._id_038F = 0;
  var_0._id_A467 = var_2 + var_0._id_4649 * 1000;
}

_id_3451(var_0) {
  var_1 = gettime();
  var_2 = 0;
  var_3 = scripts\engine\utility::array_randomize(level._id_125C);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(!var_2) {
      if(var_1 > var_5._id_A467) {
        if(var_5._id_038F > 99) {
          _id_4FFB(var_5, var_0);
          var_2 = 1;
          continue;
        }

        if([[var_5._id_33BD]](var_0)) {
          _id_4FFB(var_5, var_0);
          var_2 = 1;
        }
      }
    }
  }

  return var_2;
}

_id_5004(var_0) {
  self._id_0188 = 1;

  if(!isPlayer(var_0._id_50FF)) {
    return;
  }
  if(var_0._id_50FF.class == "crusader" || isDefined(level._id_1260)) {
    if(_id_DA95(var_0._id_50FF)) {
      _id_4FE5(var_0);
    }
  }

  if(var_0._id_50FF scripts\cp\utility::_hasperk("specialty_scavenger")) {
    if(_id_DA9D(var_0._id_50FF)) {
      var_1 = self.origin - (10, 10, 0);
      _id_4FFC(var_0, var_1);
    }
  }
}

_id_DA9D(var_0) {
  if(isDefined(self._id_3700)) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  if(isDefined(self._id_C83B)) {
    return 0;
  }

  if(!isDefined(var_0._id_8F0B)) {
    var_0._id_8F0B = gettime();
    return 1;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0._id_8F0B;

  if(var_2 > var_1) {
    var_0._id_8F0B = gettime();
    return 1;
  }

  return 0;
}

_id_4FFC(var_0, var_1) {
  var_2 = self.origin;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = spawn("script_model", var_2);
  var_3 thread _id_0ED0(var_0._id_50FF);
}

_id_0ED0(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self hidefromplayer(var_2);
    }
  }

  self setModel("equipment_scavenger_bag");
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 10);
  thread scripts\cp\utility::_id_46C7(20);
  self.trigger thread scripts\cp\utility::_id_46C7(20);

  for(;;) {
    self.trigger waittill("trigger", var_4);

    if(var_4 == var_0) {
      var_4 playlocalsound("weap_ammo_pickup");
      var_4 _id_6EC3();
      var_4 thread _id_071B::_id_7B6B("scavenger");
      self.trigger delete();
      self delete();
    }
  }
}

_id_6ED2() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(weapontype(var_2) == "riotshield") {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_861F(var_2)) {
      continue;
    }
    if(_id_3184()) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = self getweaponammostock(var_2);
      var_5 = weaponclipsize(var_2);
      var_6 = var_3 + var_4 + var_5;

      if(var_6 == var_5) {
        self setweaponammoclip(var_2, var_6);
      } else {
        self setweaponammoclip(var_2, var_5);
        var_7 = var_6 - var_5;
        self setweaponammostock(var_2, var_7);
      }
    }
  }
}

_id_6EC3() {
  var_0 = 30;
  var_1 = 0;
  var_2 = self getcurrentprimaryweapon();

  if(!scripts\cp\utility::_id_8708()) {
    var_1 = 1;
  }

  if(weapontype(var_2) == "riotshield") {
    var_1 = 1;
  }

  if(scripts\cp\cp_weapon::_id_8607(var_2)) {
    var_1 = 1;
  }

  if(scripts\cp\cp_weapon::_id_861F(var_2)) {
    var_1 = 1;
  }

  if(!var_1) {
    if(_id_3184()) {
      var_0 = _id_68BB(var_2);
      var_3 = self getweaponammostock(var_2);
      var_4 = weaponmaxammo(var_2);
      var_5 = var_3 + var_0;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_2, var_6);
      return;
    }
  }

  var_7 = self getweaponslistprimaries();

  foreach(var_2 in var_7) {
    if(!scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(weapontype(var_2) == "riotshield") {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_861F(var_2)) {
      continue;
    }
    if(_id_3184()) {
      var_0 = _id_68BB(var_2);
      var_3 = self getweaponammostock(var_2);
      var_4 = weaponmaxammo(var_2);
      var_5 = var_3 + var_0;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_2, var_6);
      return;
    }
  }
}

_id_68BB(var_0) {
  var_1 = var_0 _meth_8625();
  var_2 = weaponclipsize(var_1);
  var_3 = scripts\cp\utility::getweaponrootname(var_0);
  var_4 = 30;
  var_5 = var_4;

  if(var_0._id_0245) {
    var_6 = scripts\cp\utility::_id_1DA5(var_0._id_04B7);

    switch (var_6) {
      case "glsemtex":
      case "glgas":
      case "gl":
      case "glsnap":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glsmoke":
        var_5 = 1;
        break;
      case "ubshtgn":
        var_5 = 999;
        break;
      default:
        var_5 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "spread":
        switch (var_3) {
          case "s4_ar_stango44":
            var_5 = 6;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      case "sniper":
        switch (var_3) {
          case "s4_ar_stango44":
            var_5 = 3;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      default:
        var_5 = int(min(var_2, var_4));
    }
  }

  return var_5;
}

_id_3184() {
  var_0 = scripts\cp\utility::_id_6E34();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2) {
    return 1;
  } else {
    return 0;
  }
}

_id_DA95(var_0) {
  if(isDefined(self._id_3700)) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  if(isDefined(self._id_C83B)) {
    return 0;
  }

  if(!isDefined(var_0._id_8F27)) {
    var_0._id_8F27 = gettime();
    return 1;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0._id_8F27;

  if(var_2 > var_1) {
    var_0._id_8F27 = gettime();
    return 1;
  }

  return 0;
}

_id_4FE5(var_0) {
  var_1 = self.origin + (10, 10, 0);
  _id_4FE6(var_0, var_1);
}

_id_4FE6(var_0, var_1, var_2) {
  var_3 = self.origin;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = scripts\cp\utility::_id_3FF0(var_3, "HINT_BUTTON", "cp_crate_icon_lethalrefill", &"COOP_GAME_PLAY/PICK_GRENADE", 5, "duration_short", "show", 200, undefined, 100, 360);
  var_4 setModel("offhand_wm_grenade_mike67");
  var_4 thread _id_0EB1();
  var_4 thread scripts\cp\utility::_id_46C7(30);

  if(isDefined(var_2)) {
    foreach(var_6 in level.players) {
      if(var_6 != var_2) {
        var_4 hidefromplayer(var_6);
      }
    }
  }
}

_id_0EB1() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 _meth_84AF("ges_pickup");
    var_0 playlocalsound("weap_ammo_pickup");

    foreach(var_2 in var_0._id_BADE) {
      if(var_2._id_DDEF == "primary") {
        var_0 notify("pickup_equipment", var_2._id_10DE9);
        waitframe();
      }
    }

    self delete();
  }
}

_id_8727() {
  if(self._id_04B9 == "juggernaut") {
    return 1;
  } else {
    return 0;
  }
}

_id_DA89(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return 0;
  } else if(var_0 != var_5 && isDefined(var_0.team) && var_0.team == var_5.team) {
    return 0;
  } else if(isDefined(level._id_DA88) && ![[level._id_DA88]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return 0;
  } else {
    return 1;
  }
}

_id_88A1(var_0) {
  return var_0.classname == "sniper" || var_0.classname == "dmr";
}

_id_DA9E(var_0) {
  var_1 = getdvarint("#x3b1b040d9253d0c73");

  if(var_1) {
    return 1;
  }

  if(!isDefined(level._id_10CF1)) {
    return 0;
  }

  if(isDefined(self._id_04B9) && self._id_04B9 == "suicidebomber") {
    return 0;
  }

  if(!isDefined(var_0._id_50FF)) {
    return 0;
  }

  var_2 = 5;
  var_3 = gettime();
  var_4 = var_0._id_50FF getentitynumber();

  if(!isDefined(level._id_10CF1[var_4])) {
    level._id_10CF1[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  if(var_3 > level._id_10CF1[var_4]) {
    level._id_10CF1[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  return 0;
}

_id_85D4(var_0, var_1, var_2) {
  if(isDefined(var_1._id_04B7)) {
    var_3 = scripts\cp\utility::_id_1DA5(var_1._id_04B7);

    if(var_3 == "glflash" || var_3 == "glconc") {
      return 1;
    }
  }

  return var_0 == "flash_grenade_mp";
}

_id_85DE(var_0) {
  return var_0 == "gas_mp";
}

_id_2F54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_4 == "MOD_SUICIDE") {
    return;
  }
  var_3 = 0;

  if(!isDefined(self._id_ADF1)) {
    return;
  }
  if(gettime() > self._id_A468) {
    if(_func_0205(self._id_ADF1)) {
      self playSound(self._id_ADF1);
    }

    self._id_A468 = gettime() + 500;
  }
}

_id_2F55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_06FE::_id_4386();

  if(isDefined(level._id_E31C)) {
    [[level._id_E31C]](var_1, var_4);
  }

  if(_id_85C3()) {
    if(!istrue(self._id_4982)) {
      level notify("grenade_exploded_during_stealth", self.origin, "suicide_vest", _id_678E(var_0, var_1, self.origin));
    }
  }

  if(var_3 == "MOD_SUICIDE") {
    return;
  }
  if(istrue(self._id_9B33)) {
    self._id_9B33 = undefined;
  }

  if(isDefined(self._id_43C3)) {
    var_9 = spawnStruct();
    var_9._id_511D = var_0;
    var_9._id_50FF = var_1;
    var_9._id_7C8D = var_2;
    var_9._id_DE2B = var_3;
    var_9._id_EC0F = var_4;
    var_9._id_FFD4 = var_5;
    var_9._id_D9E0 = var_6;
    var_9._id_F21F = var_7;
    var_9._id_43D5 = var_8;
    thread[[self._id_43C3]](var_9);
  }

  if(isPlayer(var_1)) {
    level notify("zombie_killed_by", var_1);
    level thread _id_73EE(var_1, self, var_3);
    self._id_4982 = undefined;
    var_10 = _id_0726::_id_642F(var_1);
    var_11 = 1;
    _id_0705::_id_976F(var_1, self, var_4);

    if(isDefined(var_1._id_AFAA) && var_1 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
      var_12 = 10;
      var_13 = var_12 * var_1._id_AFAA["super_fill_scalar"];
    }
  }

  if(getDvar("#x3359dcde5b6e0e6ac", "") != "") {
    if(isPlayer(var_1) && isDefined(level._id_FCDB)) {
      level thread[[level._id_FCDB]](var_4, var_1, self, var_3, var_6);
    }
  }

  if(isDefined(level._id_C4BC)) {
    level thread[[level._id_C4BC]](self);
  }

  if(isDefined(self._id_1DDE)) {
    foreach(var_15 in self._id_1DDE) {
      if(!isDefined(_id_0DB6(var_15))) {
        continue;
      }
      if(var_15 == var_1) {
        continue;
      }
      if(self == var_15) {
        continue;
      }
      if(isDefined(level._id_1D2C)) {
        continue;
      }
      var_16 = undefined;

      if(isDefined(self._id_1DD4)) {
        var_17 = self._id_1DD4[var_15.guid];

        if(isDefined(var_17)) {
          var_16 = var_17.objweapon;
        }
      }

      var_18 = 0;

      if(self._id_1DD4[var_15.guid].damage >= 35) {
        var_18 = 1;
      }

      if(self._id_1DD4[var_15.guid].damage >= 70) {
        var_18 = 2;
      }

      var_15 thread _id_072C::_id_BD5D(self, var_16, var_18);
    }
  }

  _id_6ECC(var_0, var_1, var_6, var_3, var_4);
  var_20 = 0;
  _id_0741::_id_BD3D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level thread scripts\cp\utility::_id_1049("ai_killed", self.origin, var_4, var_3, var_1, self, self.team);
}

_id_F3D6() {
  self endon("death_or_disconnect");
  self notify("stop_tracking_consec_kills");
  self endon("stop_tracking_consec_kills");

  for(;;) {
    level waittill("ai_killed", var_0, var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(self._id_3B87)) {
      self._id_3B87 = 1;
    } else {
      self._id_3B87 = self._id_3B87 + 1;
    }

    thread _id_F227();
  }
}

_id_F227() {
  self endon("death_or_disconnect");
  self notify("stop_timeout_consec_kills");
  self endon("stop_timeout_consec_kills");
  wait(_id_640D());
  self._id_3B87 = undefined;
}

_id_640D() {
  var_0 = 3;

  if(scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak")) {
    var_0 = var_0 + 3;
  }

  return var_0;
}

_id_73EE(var_0, var_1, var_2) {
  if(!scripts\engine\utility::_id_8794(var_2)) {
    return;
  }
  if(isDefined(var_1._id_440C) && _func_0205(var_1._id_440C)) {
    playsoundatpos(var_1.origin, var_1._id_440C);
  }

  var_3 = 0;

  if(var_3) {
    var_4 = var_1;

    if(var_2 == "MOD_HEAD_SHOT") {
      var_4 playsoundtoplayer("bullet_impact_headshot", var_0);
      var_4 playsoundtoteam("bullet_impact_headshot_npc", var_0.team, var_0);
    } else {
      var_4 playsoundtoplayer("mp_kill_alert", var_0);
      var_4 playsoundtoteam("mp_hit_alert_final_npc", var_0.team, var_0);
    }
  }
}

_id_6ECC(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(self.team) && isDefined(var_1.team) && self.team == var_1.team) {
    return;
  }
  if(!isDefined(self._id_1210)) {
    return;
  }
  var_5 = _id_07F7::_id_6305(self);
  var_6 = getdvarint("#x3c66712b7e6debf8d", 0);

  if(var_6 != 0) {
    var_7 = var_6;
  } else {
    var_7 = level._id_11ED[var_5]["reward"];
  }

  var_8 = level._id_11ED[var_5]["xp"];
  var_9 = 0;
  var_10 = _id_85C3();
  var_11 = isDefined(var_4) && (var_4.basename == "incendiary_ammo_mp" || var_4.basename == "slayer_ammo_mp");

  if(isDefined(var_1.classname) && var_1.classname == "trigger_radius") {
    if(isDefined(level._id_3BAD)) {
      var_12 = var_7 * (level._id_32FF + level._id_3BAD);
    } else {
      var_12 = var_7 * level._id_32FF;
    }

    foreach(var_14 in level.players) {
      if(!var_14 scripts\cp\utility::_id_8708()) {
        continue;
      }
      if(isDefined(level._id_1105F)) {
        var_14 _id_074E::_id_6F38(int(var_8));
      }

      if(istrue(level._id_E3C2)) {
        continue;
      }
      var_15 = "large";
      var_2 = "none";
      var_14 _id_074E::_id_6F28(var_12, var_15, var_2, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
    return;
  }
  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
    var_9 = 1;
  }

  if(!var_11 && (var_5 == "generic_zombie" || var_5 == "fast_zombie" || var_5 == "zombie_cop")) {
    if(scripts\cp\utility::_id_8891(var_4, var_2, var_3, var_1) && !var_9 && scripts\engine\utility::_id_8794(var_3) && !var_10) {
      var_7 = int(100);
      var_8 = int(75);
    }

    if(isDefined(var_3) && var_3 == "MOD_MELEE" && !issubstr(var_4.basename, "axe")) {
      var_7 = int(130);
      var_8 = int(100);
    }
  }

  if(isPlayer(var_1)) {
    if(!istrue(var_1.pers["ignoreWeaponMatchBonus"]) && (scripts\cp\cp_weapon::_id_879A(var_4) || scripts\cp\cp_weapon::_id_879C(var_4))) {
      if(!isDefined(var_1.pers["weaponMatchBonusKills"])) {
        var_1.pers["weaponMatchBonusKills"] = 1;
      } else {
        var_1.pers["weaponMatchBonusKills"]++;
      }

      if(var_1.pers["weaponMatchBonusKills"] > _id_0776::_id_6A64()) {
        var_1.pers["ignoreWeaponMatchBonus"] = 1;
        var_1.pers["weaponMatchBonusKills"] = undefined;
        var_1.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(var_1.pers["killsPerWeapon"])) {
          var_1.pers["killsPerWeapon"] = [];
        }

        var_17 = scripts\cp\utility::getweaponrootname(var_4);
        var_18 = 0;

        foreach(var_21, var_20 in var_1.pers["killsPerWeapon"]) {
          if(var_21 == var_17) {
            var_20._id_8D6E++;
            var_18 = 1;
            break;
          }
        }

        if(!var_18) {
          var_20 = spawnStruct();
          var_20._id_8D6E = 1;
          var_20.basename = var_4.basename;
          var_20._id_AC63 = var_1.pers["killsPerWeapon"].size;
          var_1.pers["killsPerWeapon"][var_17] = var_20;
        }
      }
    }
  }

  if(isDefined(level._id_8D4A)) {
    var_7 = [[level._id_8D4A]](var_0, var_1, var_2, var_3, var_4, var_5, var_7);
  }

  if(isDefined(var_7)) {
    _id_6FAA(var_0, var_1, var_7, var_8, "large", var_2, var_4, var_3);
  }
}

_id_6FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level._id_3BAD)) {
    var_2 = var_2 * (level._id_32FF + level._id_3BAD);
  } else {
    var_2 = var_2 * level._id_32FF;
  }

  var_1 thread _id_6FC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 _id_074E::_id_C13B(var_6, var_5, var_7, var_1);

  if(isDefined(self._id_D9B2)) {
    foreach(var_9 in level.players) {
      if(!var_9 scripts\cp\utility::_id_8708()) {
        continue;
      }
      if(istrue(level._id_E3C2)) {
        continue;
      }
      var_9 _id_074E::_id_6F28(var_2, var_4, var_5, 1, "crafted");
    }
  } else if(_id_DAA5(var_0, var_1, var_6))
    var_1 _id_074E::_id_6F28(var_2, var_4, var_5, 1);

  if(!scripts\cp\utility::_id_86C9()) {
    var_1 thread _id_0752::_id_7003("kill", var_6);
  }
}

_id_6FC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(_id_DAA5(var_0, var_1, var_6)) {
    if(var_1 scripts\cp\utility::_id_8580("extra_sniping_points") && scripts\engine\utility::_id_8794(var_7) && var_6.classname == "weapon_sniper" && _id_34DF(var_6)) {
      var_8 = 300;

      if(var_6 == "iw7_shared_fate_weapon") {
        var_1 scripts\cp\utility::_id_A689("extra_sniping_points");
      } else {
        var_1 scripts\cp\utility::_id_A689("extra_sniping_points");
        var_1 thread _id_46CC(var_8, var_4, var_5, "bonus", 0.15);
      }
    }

    if(isPlayer(var_1) && isDefined(var_1._id_32FF)) {
      if(isDefined(var_1._id_3301) && var_1._id_3301 == scripts\cp\utility::_id_6CE3(var_6)) {
        var_9 = int(var_2 * var_1._id_32FF - var_2);
        var_1 thread _id_46CC(var_9, var_4, var_5, "bonus", 0.25);
      }

      if(isDefined(var_1._id_3300) && var_1._id_3300 == scripts\cp\utility::_id_6CE3(var_6) && istrue(var_6._id_0245) && istrue(var_1._id_1647)) {
        var_9 = int(var_2 * var_1._id_32FF - var_2);
        var_1 thread _id_46CC(var_9, var_4, var_5, "bonus", 0.25);
      }
    }
  }
}

_id_46CC(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  wait(var_4);
  _id_074E::_id_6F28(var_0, var_1, var_2, 1, var_3);
}

_id_DAA5(var_0, var_1, var_2) {
  if(isPlayer(var_1) && _id_073B::_id_B4EF(var_1)) {
    return 0;
  }

  if(scripts\cp\utility::_id_86EC(var_0, var_2)) {
    return 0;
  }

  if(istrue(level._id_E3C2)) {
    return 0;
  }

  return 1;
}

_id_34DF(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = scripts\cp\utility::_id_6902(var_0);

  switch (var_1) {
    case "iw7_m8":
      if(scripts\cp\utility::_id_874D(var_0)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

_id_108F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(var_0._id_A72E)) {
    return;
  }
  if(!isDefined(var_0._id_1DD4)) {
    var_0._id_1DD4 = [];
  }

  var_10 = var_1;

  if(!isPlayer(var_10) && istrue(var_10._id_86F2) && isDefined(var_10.brain_rot_player)) {
    var_10 = var_10.brain_rot_player;
  }

  if(!isDefined(var_10.guid) && (isagent(var_10) || isPlayer(var_10))) {
    var_10.guid = var_10 scripts\cp\utility\player::getuniqueid();
  }

  if(!isDefined(var_10.guid)) {
    return;
  }
  if(!isDefined(var_0._id_1DD4[var_10.guid])) {
    var_0._id_1DDE[var_10.guid] = var_10;
    var_0._id_1DD4[var_10.guid] = spawnStruct();
    var_0._id_1DD4[var_10.guid].damage = 0;
    var_0._id_1DD4[var_10.guid]._id_1DD6 = var_10;
    var_0._id_1DD4[var_10.guid]._id_5BE2 = gettime();
    var_0._id_1DD4[var_10.guid]._id_79A3 = 1;
    var_0._id_1DD4[var_10.guid].covenantactive = 0;
  } else
    var_0._id_1DD4[var_10.guid]._id_79A3++;

  if(scripts\cp\cp_weapon::_id_879A(var_3) && !scripts\cp\cp_weapon::_id_879C(var_3)) {
    var_0._id_1DD4[var_10.guid]._id_4968 = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0._id_1DD4[var_10.guid]._id_4973 = 1;
  }

  var_11 = scripts\cp\utility::_id_6A18(var_3.basename);

  if(isDefined(var_11)) {
    if(var_11 == "lethal") {
      var_0._id_1DD4[var_10.guid]._id_4967 = 1;
    }

    if(var_11 == "tactical") {
      var_0._id_1DD4[var_10.guid]._id_4969 = 1;
    }
  }

  if(var_3.basename == "s4_thermite_zm") {
    _id_072A::addplayereffects("thermite", var_0, var_10, 5);
  }

  var_0._id_1DD4[var_10.guid].damage = var_0._id_1DD4[var_10.guid].damage + var_4;
  var_0._id_1DD4[var_10.guid]._id_04F6 = getcompleteweaponname(var_3);
  var_0._id_1DD4[var_10.guid].objweapon = var_3;
  var_0._id_1DD4[var_10.guid]._id_106B7 = var_5;
  var_0._id_1DD4[var_10.guid]._id_FFD4 = var_6;
  var_0._id_1DD4[var_10.guid]._id_D9E0 = var_7;
  var_0._id_1DD4[var_10.guid]._id_0354 = var_8;
  var_0._id_1DD4[var_10.guid]._id_DE2B = var_9;
  var_0._id_1DD4[var_10.guid]._id_1DD6 = var_10;
  var_0._id_1DD4[var_10.guid]._id_90A7 = gettime();

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2._id_034C)) {
    var_0._id_1DD4[var_10.guid]._id_E44C = var_2._id_034C;
  } else if(isDefined(var_10) && isPlayer(var_10) && !isnullweapon(var_10 getcurrentprimaryweapon())) {
    var_0._id_1DD4[var_10.guid]._id_E44C = getcompleteweaponname(var_10 getcurrentprimaryweapon());
  } else {
    var_0._id_1DD4[var_10.guid]._id_E44C = undefined;
  }

  var_12 = scripts\cp\covenants\cp_covenants::damage_covenant_active(var_0, var_10, var_2, var_3, var_4, var_6, var_7, var_8, var_9);
  var_0._id_1DD4[var_10.guid].covenantactive = var_0._id_1DD4[var_10.guid].covenantactive || var_12;
}

_id_678E(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    return var_1.name;
  }

  if(isPlayer(var_0)) {
    return var_0.name;
  }

  if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    return var_0.owner.name;
  }

  var_3 = scripts\engine\utility::_id_6969(var_2, level.players);
  return var_3.name;
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