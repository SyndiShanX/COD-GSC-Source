/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1738.gsc
*************************************************/

_id_8068() {
  self._id_0419 = spawnStruct();
  self._id_0419._id_1DDE = [];
  self._id_0419._id_1DDF = [];
  self._id_0419._id_1DD6 = [];
  self._id_EBBD = [];
  self._id_0419.calloutpinned = 1;
  scripts\engine\utility::_id_5473("pause_suppression");
  thread _id_2D3E();
  self._id_81F0 = self._id_A25F;
}

_id_EBC8() {
  var_0 = 65;
  var_1 = var_0;
}

_id_6838(var_0) {
  var_1 = var_0.basename;

  switch (var_1) {
    case "s4_ar_stango44_mp":
      return "Medium";
    case "s4_mg_mgolf42_mp":
      return "Large";
    case "s4_ar_balpha_mp":
      return "Large";
    case "s4_sh_becho_mp":
      return "Medium";
    case "s4_sm_mpapa40_mp":
      return "Small";
    case "s4_sm_thotel_mp":
      return "Medium";
    case "s4_mr_kalpha98_mp":
      return "Large";
    case "s4_pi_mike1911_mp":
      return "Small";
    default:
      return "None";
  }
}

_id_2D3E() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  childthread _id_EBB4();
  thread _id_EBB8();
  thread _id_EBC8();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1, var_2, var_3, var_4);

    if(!_id_DB26(var_1, var_0)) {
      continue;
    }
    if(istrue(self._id_88DF)) {
      continue;
    }
    if(scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
      continue;
    }
    if(var_1 <= 64) {
      if(isDefined(var_4)) {
        var_5 = weaponclass(var_4);
      } else {
        var_5 = weaponclass(var_0._id_0133);
      }

      var_6 = _id_6838(var_4);
      _id_FBD4(var_1, var_6, var_5, var_0, var_4);
      _id_EBB6();
      var_7 = var_0 getentitynumber();
      var_8 = _id_EBB3();
      self._id_A25F = self._id_81F0 - self._id_0419._id_0050 * _id_6C68() * var_8;
      scripts\mp\weapons::_id_FCCC();

      if(var_0 scripts\mp\utility\perk::_hasperk("specialty_piercing_vision") && !scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
        var_9 = var_0 getentitynumber();

        if(!isDefined(self._id_EBBD[var_9])) {
          var_10 = spawnStruct();
          var_10.owner = self;
          var_10._id_8747 = 1;
          var_10.attacker = var_0;
          var_10._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "suppression_overlay", "level_script");
          self._id_EBBC[var_9] = var_10._id_ACE5;
          _id_09B5::_id_9B40();
          level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "piercing_vision");
          var_10 thread _id_EBB7();
        }
      }
    }
  }
}

_id_EBBF(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = weaponclass(var_1);
  } else {
    var_4 = weaponclass(var_0._id_0133);
  }

  var_5 = undefined;

  if(_func_010F(var_2) && isDefined(var_3)) {
    var_6 = distance(var_3.origin, self.origin);
    _id_FBD4(var_6, var_5, var_4, var_0, var_1);
  } else if(var_2 == "MOD_FIRE")
    _id_FBD4(0, var_5, "burning", var_0, var_1);
  else {
    _id_FBD4(0, var_5, var_4, var_0, var_1);
  }

  var_7 = var_0 getentitynumber();
  var_8 = _id_EBB3();
  self._id_A25F = self._id_81F0 - self._id_0419._id_0050 * _id_6C68() * var_8;
  scripts\mp\weapons::_id_FCCC();

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_piercing_vision") && !scripts\mp\utility\perk::_hasperk("specialty_dauntless") && self._id_0419._id_1DDE[var_7] >= 0.75) {
    var_9 = var_0 getentitynumber();

    if(!isDefined(self._id_EBBD[var_9])) {
      var_10 = spawnStruct();
      var_10.owner = self;
      var_10._id_8747 = 1;
      var_10.attacker = var_0;
      var_10._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "suppression_overlay", "level_script");
      self._id_EBBC[var_9] = var_10._id_ACE5;
      _id_09B5::_id_9B40();
      level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "piercing_vision");
      var_10 thread _id_EBB7();
    }
  }
}

_id_6C68() {
  var_0 = 0.3;
  var_1 = self getstance();

  if(self issprintsliding()) {
    var_0 = 0;
  } else if(self getstance() == "stand") {
    if(self playerads() > 0.3) {
      var_0 = 0.1;
    } else if(self _meth_86CF()) {
      var_0 = 0.1;
    } else if(self issprinting()) {
      var_0 = 0.2;
    } else {
      var_0 = 0.3;
    }
  } else if(self getstance() == "crouch")
    var_0 = 0.1;
  else if(self getstance() == "prone") {
    var_0 = 0.1;
  } else {
    var_0 = 0;
  }

  var_2 = _func_044E(self getcurrentweapon());
  var_3 = (max(var_2, 0.6) - 0.6) * 2.5;
  var_0 = var_0 * var_3;
  return var_0;
}

_id_DB26(var_0, var_1) {
  if(isDefined(self._id_A6CC) && self._id_A6CC) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isalive(var_1)) {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() != "dm" && isDefined(var_1.team) && isDefined(self.team) && var_1.team == self.team) {
    return 0;
  }

  return 1;
}

_id_FBD4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = 0.05;
  var_7 = scripts\engine\math::_id_A5C5(14, 64, var_0);
  var_8 = scripts\engine\math::_id_5898(var_5, var_6, var_7);
  var_9 = var_3 getentitynumber();

  if(!isDefined(var_4)) {
    var_10 = 1;
  } else {
    var_10 = var_4._id_0299;
  }

  if(!isDefined(var_2)) {
    var_11 = 1;
  } else {
    var_11 = float(_id_5ADA(var_2));
  }

  if(!isDefined(var_2)) {
    var_11 = 1;
  } else {
    var_11 = float(_id_5ADA(var_2));
  }

  if(!isDefined(var_11)) {
    var_11 = 1;
  }

  if(var_4.basename == "s4_sh_bromeo5_mp" && var_4 _meth_8624("bar_xs_sawed_bromeo5")) {
    var_11 = var_11 * 1.5;
  }

  if(var_4.basename == "s4_mr_ptango41_mp" && var_4 _meth_8624("ammo_concussion")) {
    var_11 = var_11 * 10;
    self shellshock("chargemode_mp", 0.8);
    self earthquakeforplayer(0.35, 0.2, self.origin, 400);
    self _meth_827A("plr_rumble_4_mp", self.origin);
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_van_lightweight")) {
    var_12 = 1;
  } else {
    var_12 = 1;
  }

  var_13 = var_8 * var_11 * var_10 / 100 * var_12;
  var_14 = self._id_0419._id_0050 + var_13;
  self._id_0419._id_0050 = scripts\engine\utility::ter_op(var_14 <= 1, var_14, 1);
  self._id_041A = self._id_0419._id_0050;

  if(self._id_041A >= 1) {
    if(self._id_0419.calloutpinned) {
      level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_suppressed");
      self._id_0419.calloutpinned = 0;
    }
  }

  var_15 = _id_5ADB(var_4.basename);
  self._id_0419._id_C156 = var_15;

  if(getdvarint("#x369565f1d08208ddc", 0)) {
    _id_FD4E();
  }

  if(isDefined(self._id_0419._id_1DDE[var_9])) {
    self._id_0419._id_1DDE[var_9] = self._id_0419._id_1DDE[var_9] + var_13;
  } else {
    self._id_0419._id_1DDE[var_9] = var_13;
  }

  if(isDefined(self._id_0419._id_1DDF[var_9])) {
    self._id_0419._id_1DDF[var_9] = self._id_0419._id_1DDF[var_9] + var_13;
  } else {
    self._id_0419._id_1DDF[var_9] = var_13;
  }

  self._id_0419._id_1DDD[var_9] = var_15;

  if(!isDefined(self._id_0419._id_1DD6[var_9])) {
    self._id_0419._id_1DD6[var_9] = var_3;
  }

  self._id_0419._id_1DDE[var_9] = min(self._id_0419._id_1DDE[var_9], 1);

  if(getdvarint("#x367e53e11d45f230", 0)) {
    iprintlnbold("Current Suppression: " + _func_0438(self._id_0419._id_0050, 0.1));
  }

  self._id_0419._id_90CF = gettime();
}

_id_5ADA(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/suppressionWeaponClasses.csv", var_1, 0);
    var_3 = tablelookupbyrow("mp/suppressionWeaponClasses.csv", var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    if(var_2 == var_0) {
      return var_3;
    }

    var_1++;
  }

  return 1;
}

_id_5AB7(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/suppressionWeaponCaliber.csv", var_1, 0);
    var_3 = tablelookupbyrow("mp/suppressionWeaponCaliber.csv", var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    if(var_2 == var_0) {
      return var_3;
    }

    var_1++;
  }

  return 1;
}

_id_5AD9(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/suppressionWeaponCategory.csv", var_1, 0);
    var_3 = tablelookupbyrow("mp/suppressionWeaponCategory.csv", var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    if(var_2 == var_0) {
      return var_3;
    }

    var_1++;
  }
}

_id_5ADB(var_0) {
  var_1 = 0.04;
  var_2 = _id_5AD9(var_0);

  if(!isDefined(var_2)) {
    return var_1;
  }

  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow("mp/suppressionWeaponCategoryMods.csv", var_3, 0);
    var_5 = 0.05 / float(tablelookupbyrow("mp/suppressionWeaponCategoryMods.csv", var_3, 1));

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    if(var_4 == var_2) {
      return var_5;
    }

    var_3++;
  }

  return var_1;
}

_id_EBB4() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_0419._id_0050 = 0;
  self._id_0419._id_90CF = 0;
  self._id_0419._id_3D06 = 100;

  for(;;) {
    if(getdvarint("#x3308f006a16f0e12f") || !scripts\engine\utility::is_equal(self.sessionstate, "playing") || !isalive(self)) {
      waitframe();
      continue;
    }

    if(!isbot(self) && (!_func_011D(self) && isDefined(self)) || isalive(self)) {
      scripts\engine\utility::_id_547B("pause_suppression");
    }

    if(isDefined(self._id_0419._id_0050) && self._id_0419._id_0050 > 0) {
      if(gettime() - self._id_0419._id_90CF > self._id_0419._id_3D06) {
        var_0 = self._id_0419._id_0050 - self._id_0419._id_C156;
        self._id_0419._id_0050 = scripts\engine\utility::ter_op(var_0 >= 0, var_0, 0);
        self._id_041A = self._id_0419._id_0050;

        if(self._id_0419._id_0050 < 0.75) {
          self._id_0419.calloutpinned = 1;
        }

        if(getdvarint("#x369565f1d08208ddc", 0)) {
          _id_FD4E();
        }

        if(self._id_0419._id_0050 <= 0) {
          self notify("suppression_clear");
        }

        foreach(var_3, var_2 in self._id_0419._id_1DDE) {
          self._id_0419._id_1DDE[var_3] = self._id_0419._id_1DDE[var_3] - self._id_0419._id_1DDD[var_3];

          if(self._id_0419._id_1DDE[var_3] <= 0 || self._id_0419._id_0050 <= 0) {
            self._id_0419._id_1DDE[var_3] = undefined;
          }
        }

        if(getdvarint("#x367e53e11d45f230", 0)) {
          iprintlnbold("Current Suppression: " + _func_0438(self._id_0419._id_0050, 0.1));
        }

        var_4 = _id_EBB3();
        self._id_A25F = self._id_81F0 - self._id_0419._id_0050 * _id_6C68() * var_4;
        scripts\mp\weapons::_id_FCCC();
      }
    }

    wait 0.05;
  }
}

_id_EBB6() {
  if(!isDefined(self._id_0419._id_3D06) || gettime() - self._id_0419._id_90CF > 250) {
    self._id_0419._id_3D06 = 150;
  } else {
    self._id_0419._id_3D06 = min(self._id_0419._id_3D06 + 150, 100);
  }
}

_id_EBB1() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("death", "suppression_clear");

    foreach(var_4, var_1 in self._id_0419._id_1DDF) {
      var_2 = self._id_0419._id_1DD6[var_4];
      var_3 = int(var_1 / 0.5) * 5;

      if(var_3 > 0) {
        var_2 thread _id_0A9F::_id_7003("suppression", undefined, var_3, undefined, self);
      }

      self._id_0419._id_1DDF[var_4] = undefined;
    }
  }
}

_id_EBB7() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(!istrue(self._id_8747)) {
    return;
  }
  self notify("update");
  self endon("update");
  thread _id_EBB9();

  while(isDefined(self.attacker)) {
    var_0 = self._id_ACE5;
    var_1 = self.attacker;
    var_2 = var_1 getentitynumber();

    if(!isDefined(var_1) || !scripts\mp\utility\player::isreallyalive(var_1) || !scripts\mp\utility\player::isreallyalive(self.owner)) {
      if(isDefined(self.owner)) {
        self.owner scripts\mp\utility\outline::_id_0C2D();
      }

      scripts\mp\utility\outline::outlinedisable(var_0, self.owner);
      self._id_ACE5 = undefined;
      self.attacker = undefined;
      self.owner._id_EBBC[var_2] = undefined;
    }

    var_3 = self.owner._id_0419._id_1DDE[var_2];

    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    var_4 = scripts\engine\utility::ter_op(getdvarfloat("#x3eed238627a240a6", 0) > 0, getdvarfloat("#x3eed238627a240a6", 0), 0.75);
    var_5 = max((var_3 - 0.75) / 0.25, 0) * var_4;

    if(isDefined(var_3)) {
      self.owner _meth_8804(var_5);
    }

    if(var_3 == 0) {
      break;
    }

    waitframe();
  }

  thread _id_EBB2();
}

_id_EBB9() {
  self endon("death");
  self endon("update");
  _id_EBBA();
  thread _id_EBB2();
}

_id_EBBA() {
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

_id_EBB2() {
  self notify("death");
  self._id_8747 = 0;
  var_0 = self._id_ACE5;

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self.attacker;
  var_2 = var_1 getentitynumber();
  scripts\mp\utility\outline::outlinedisable(var_0, self.owner);
  self.owner._id_EBBC[var_2] = undefined;

  foreach(var_4 in self.owner._id_EBBC) {
    if(isDefined(var_4)) {
      return;
    }
  }

  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility\outline::_id_0C2D();
  }
}

_id_FD4E() {
  var_0 = 0;
  var_1 = 1;
  var_2 = var_1 - var_0;

  if(!isDefined(self._id_EBBE)) {
    self._id_EBBE = newclienthudelem(self);
    self._id_EBBE.x = 0;
    self._id_EBBE.y = 0;
    self._id_EBBE setshader("overlay_healer", 640, 480);
    self._id_EBBE.alignx = "left";
    self._id_EBBE.aligny = "top";
    self._id_EBBE.horzalign = "fullscreen";
    self._id_EBBE.vertalign = "fullscreen";
    self._id_EBBE.alpha = 0;
  }

  self._id_EBBE.alpha = self._id_0419._id_0050 * var_2 + var_0;
}

_id_58B8(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}

_id_58C1(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}

_id_EBB8() {
  scripts\engine\utility::_id_10888(self, "death_or_disconnect", level, "game_ended", self, "joined_team", self, "joined_spectators");

  if(isDefined(self._id_EBBE)) {
    self._id_EBBE.alpha = 0;
  }
}

_id_EBB3() {
  var_0 = 1;
  var_1 = 1.25;

  foreach(var_6, var_3 in self._id_0419._id_1DDE) {
    var_4 = self._id_0419._id_1DD6[var_6];

    if(isDefined(var_4) && var_4 scripts\mp\utility\perk::_hasperk("specialty_disable") && var_0 < var_1 && self._id_0419._id_1DDE[var_6] == self._id_0419._id_0050) {
      var_0 = var_1;
      continue;
    }

    if(isDefined(var_4) && var_4 scripts\mp\utility\perk::_hasperk("specialty_disable") && var_0 < var_1) {
      var_5 = self._id_0419._id_1DDE[var_6] / self._id_0419._id_0050 * 0.25;
      var_0 = var_0 + var_5;
      var_0 = min(var_0, var_1);
    }
  }

  if(self._id_0133 _meth_8624("gunperk_steady")) {
    var_0 = var_0 * 0.5;
  }

  return var_0;
}