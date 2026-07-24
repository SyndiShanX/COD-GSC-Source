/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3133.gsc
**************************************/

_id_3420(var_0, var_1, var_2, var_3) {
  if(isDefined(self.asm._id_51E8)) {
    return;
  }
  self.asm._id_51E8 = 1;
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm._id_7360 = 0;
  self._id_22EE = 1.0;
  scripts\asm\asm_bb::bb_requestmovetype("walk");
  self.sharpturnlookaheaddist = 32;
  self._id_130A9 = 1;
  self._id_130A8 = 1;
  self._id_9322 = 1;
  self.leftaimlimit = 34;
  self.rightaimlimit = -31;
  self.upaimlimit = -22;
  self.downaimlimit = 26;
  self._id_129AF = 55;
  self._id_CBF8 = self._id_5042;
  self._id_10264 = 1;
  self._id_3507 = 250;
  self.meleerangesq = 7056;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 180;
  self.meleechargedistreloadmultiplier = 1;
  self._id_B627 = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self._id_B5E1 = 9216;
  self._id_B5DA = 1;
  self._id_B64F = 400;
  self._id_4E46 = ::_id_3448;
  self._blackboard._id_5280 = 3;
  self._id_C065 = 1;
  _id_346E();
}

_id_346E() {
  if(!isDefined(anim._id_85DF))
    anim._id_85DF = [];

  if(isDefined(anim._id_85DF["c8"])) {
    return;
  }
  anim._id_85DF["c8"] = [];
  anim._id_85E1["c8"] = [];
  anim._id_85DF["c8"]["exposed_throw_grenade"]["exposed_grenade"] = self[[self._id_7190]]("c8", "exposed_throw_grenade", "exposed_grenade");
  anim._id_85E1["c8"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  anim._id_85E1["c8"]["exposed_throw_grenade"]["exposed_grenade"][0] = (24.9795, 12.0519, 64.6692);
}

_id_34D4(var_0) {
  if(!isDefined(self._blackboard.shootparams))
    return 1;

  if(var_0 != self._blackboard.shootparams)
    return 1;

  return 0;
}

_id_3478(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.shootparams))
    return 0;

  return weaponisbeam(self.weapon);
}

_id_34D2(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_2;

  while(gettime() < var_4) {
    if(_id_34D4(var_1))
      return 0;

    wait(var_3);
    self.a._id_A9ED = gettime();

    if(isDefined(var_1.ent)) {
      scripts\sp\gameskill::_id_F288();
      self shoot(1, var_1.ent, 0);
      continue;
    }

    var_5 = self getmuzzlepos();
    var_6 = bulletspread(var_5, var_1.pos, 4);
    self shoot(1, var_6, 0);
  }

  return 1;
}

_id_34D3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._blackboard.shootparams;

  if(isDefined(var_4._id_2AA8))
    var_5 = 0.08;
  else
    var_5 = 0.15;

  for(;;) {
    if(_id_34D4(var_4)) {
      break;
    }

    var_6 = _id_34D2(var_1, var_4, var_4._id_32C5, var_5);

    if(!var_6) {
      break;
    }

    wait(var_4._id_32C2);

    if(!scripts\asm\asm_bb::_id_291C()) {
      break;
    }
  }

  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
}

_id_34D0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._blackboard.shootparams;

  if(isDefined(var_4.ent))
    self _meth_851D(var_4.ent);
  else
    self _meth_851D();

  var_5 = gettime() + var_4._id_32C5;

  while(gettime() < var_5) {
    if(_id_34D4(var_4)) {
      break;
    }

    if(isDefined(var_4.ent))
      self _meth_851D(var_4.ent);
    else
      self _meth_851D();

    wait 0.05;
  }

  self _meth_851E();
  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
}

_id_34D1(var_0, var_1, var_2) {
  self _meth_851E();
}

_id_34ED() {
  self _meth_82AC(_id_0A1E::_id_2356("shield_upper_aims", "4"), 1);
  self _meth_82AC(_id_0A1E::_id_2356("shield_upper_aims", "6"), 1);
  self _meth_82AC(_id_0A1E::_id_2356("shield_upper_aims", "8"), 1);
  self _meth_82AC(_id_0A1E::_id_2356("shield_lower_aims", "2"), 1);
  self _meth_82AC(_id_0A1E::_id_2356("shield_lower_aims", "4"), 1);
  self _meth_82AC(_id_0A1E::_id_2356("shield_lower_aims", "6"), 1);
}

_id_34EA(var_0) {
  self endon("death");
  _id_0A2B::_id_F724();
  self.asm._id_11AC7 = var_0;
  self.asm._id_11A90 = spawnStruct();
  _id_34ED();
  self._blackboard._id_D41A = [];
  self._blackboard._id_D418 = [];

  for(var_1 = 0; var_1 < 30; var_1++) {
    self._blackboard._id_D41A[var_1] = 0;
    self._blackboard._id_D418[var_1] = 0;
  }

  self._blackboard._id_D419 = 0;
  childthread _id_3442();
  childthread _id_3444();
  childthread _id_34CC();
  _id_34EB();
}

_id_34C6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0.2;

  if(var_0 < 0)
    var_8 = var_0 / self.rightaimlimit;
  else if(var_0 > 0)
    var_7 = var_0 / self.leftaimlimit;

  if(var_1 < 0)
    var_9 = var_1 / self.upaimlimit;
  else if(var_1 > 0)
    var_6 = var_1 / self.downaimlimit;

  self _meth_82AC(var_2, var_6, var_10, 1, 1);
  self _meth_82AC(var_3, var_7, var_10, 1, 1);
  self _meth_82AC(var_4, var_8, var_10, 1, 1);
  self _meth_82AC(var_5, var_9, var_10, 1, 1);
}

_id_34C0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0.2;

  if(var_0 < 0)
    var_10 = var_0 / -38;
  else if(var_0 > 0)
    var_9 = var_0 / 33;

  if(var_1 < 0)
    var_11 = var_1 / -26;
  else if(var_1 > 0)
    var_8 = var_1 / 33;

  self _meth_82AC(var_2, scripts\engine\utility::ter_op(var_8 > 0, 1, 0), var_12, 1, 1);
  self _meth_82AC(var_3, scripts\engine\utility::ter_op(var_9 > 0, 1, 0), var_12, 1, 1);
  self _meth_82AC(var_4, scripts\engine\utility::ter_op(var_10 > 0, 1, 0), var_12, 1, 1);
  self _meth_82AC(var_5, scripts\engine\utility::ter_op(var_11 > 0, 1, 0), var_12, 1, 1);
  self _meth_82AC(var_6, max(var_8, var_11), var_12, 1, 1);
  self _meth_82AC(var_7, max(var_9, var_10), var_12, 1, 1);
}

_id_80F5() {
  return self.angles;
}

_id_34EB() {
  var_0 = _id_0A1E::_id_2356("Knobs", "aim_2");
  var_1 = _id_0A1E::_id_2356("Knobs", "aim_4");
  var_2 = _id_0A1E::_id_2356("Knobs", "aim_6");
  var_3 = _id_0A1E::_id_2356("Knobs", "aim_8");
  var_4 = _id_0A1E::_id_2356("shield_aim_knobs", "upper_4");
  var_5 = _id_0A1E::_id_2356("shield_aim_knobs", "upper_6");
  var_6 = _id_0A1E::_id_2356("shield_aim_knobs", "upper_8");
  var_7 = _id_0A1E::_id_2356("shield_aim_knobs", "lower_2");
  var_8 = _id_0A1E::_id_2356("shield_aim_knobs", "lower_4");
  var_9 = _id_0A1E::_id_2356("shield_aim_knobs", "lower_6");
  var_10 = _id_0A1E::_id_2356("torso_aims", "knob");
  var_11 = _id_0A1E::_id_2356("torso_aims", "left");
  var_12 = _id_0A1E::_id_2356("torso_aims", "right");
  var_13 = _id_0A1E::_id_2356("gun_arm_aims", "knob28");
  var_14 = _id_0A1E::_id_2356("gun_arm_aims", "knob46");
  var_15 = _id_0A1E::_id_2356("gun_arm_aims", "u");
  var_16 = _id_0A1E::_id_2356("gun_arm_aims", "d");
  var_17 = _id_0A1E::_id_2356("gun_arm_aims", "l");
  var_18 = _id_0A1E::_id_2356("gun_arm_aims", "r");
  var_19 = _id_0A1E::_id_2356("shield_openclose", "upper_open");
  var_20 = _id_0A1E::_id_2356("shield_openclose", "lower_open");
  self.asm._id_11A90._id_A96D = -99999;
  self.asm._id_11A90._id_A96B = -99999;
  _id_34AD();
  self.asm._id_11A90._id_11A15 = 0;
  var_29 = 0;

  for(;;) {
    waittillframeend;
    var_30 = scripts\asm\asm::_id_231B(self.asm._id_11AC7, "aim");

    if(var_30) {
      if(!var_29)
        _id_34ED();

      var_31 = undefined;

      if(isDefined(self._blackboard.shootparams)) {
        if(isDefined(self._blackboard.shootparams.pos))
          var_31 = self._blackboard.shootparams.pos;
        else if(isDefined(self._blackboard.shootparams.ent))
          var_31 = self._blackboard.shootparams.ent.origin;
      }

      if(!isDefined(var_31) && isDefined(self.enemy))
        var_31 = self.enemy.origin;

      var_32 = undefined;

      if(isDefined(var_31))
        var_32 = angleclamp180(vectortoyaw(var_31 - self.origin));

      var_33 = undefined;
      var_34 = undefined;
      var_35 = undefined;
      var_36 = undefined;
      var_37 = undefined;
      var_38 = 0;
      var_39 = 0;
      var_40 = self islegacyagent(var_11);
      var_41 = self islegacyagent(var_12);
      var_42 = _id_80F5();
      var_43 = self gettagorigin("tag_origin");
      var_44 = angleclamp180(var_42[1] + var_38);
      var_45 = 0;
      var_37 = 0;
      var_46 = gettime();

      if(self._blackboard._id_12F91 != 2) {
        if(var_46 < self.asm._id_11A90._id_A96D + 4000) {
          if(isDefined(self.asm._id_11A90._id_A963)) {
            var_47 = vectortoangles(self.asm._id_11A90._id_A963.origin - var_43);
            var_48 = angleclamp180(var_47[1]);
            var_49 = angleclamp180(var_47[0]);
          } else {
            var_48 = self.asm._id_11A90._id_A96F;
            var_49 = 0;
          }

          var_48 = angleclamp180(var_48 - var_44);

          if(_id_34F5(var_48)) {
            self.asm._id_11A90._id_AA3A = var_48 - 10;
            self.asm._id_11A90._id_AA39 = var_49;
            self.asm._id_11A90._id_AA38 = 1;
          }
        } else if(isDefined(self.enemy)) {
          var_47 = vectortoangles(self.enemy.origin - var_43);
          var_48 = angleclamp180(var_47[1] - var_44);
          var_49 = angleclamp180(var_47[0]);

          if(_id_34F5(var_48)) {
            self.asm._id_11A90._id_AA3A = var_48 - 10;
            self.asm._id_11A90._id_AA39 = var_49;
            self.asm._id_11A90._id_AA38 = 1;
          }
        } else {
          self.asm._id_11A90._id_AA3A = 0;
          self.asm._id_11A90._id_AA39 = 0;
          self.asm._id_11A90._id_AA38 = undefined;
        }

        if(isDefined(self.asm._id_11A90._id_AA38)) {
          var_37 = var_37 + self.asm._id_11A90._id_AA3A;
          var_45++;
        }
      }

      if(self._blackboard._id_B0E3 != 2) {
        if(var_46 < self.asm._id_11A90._id_A96B + 4000) {
          if(isDefined(self.asm._id_11A90._id_A962))
            var_48 = vectortoyaw(self.asm._id_11A90._id_A962.origin - var_43);
          else
            var_48 = self.asm._id_11A90._id_A966;

          var_48 = angleclamp180(var_48 - var_44);

          if(_id_34F5(var_48)) {
            self.asm._id_11A90._id_A9B2 = var_48 - 10;
            self.asm._id_11A90._id_A9B1 = 0;
            self.asm._id_11A90._id_A9B0 = 1;
          }
        } else if(isDefined(self.enemy)) {
          var_48 = angleclamp180(vectortoyaw(self.enemy.origin - var_43) - var_44);

          if(_id_34F5(var_48)) {
            self.asm._id_11A90._id_A9B2 = var_48 - 10;
            self.asm._id_11A90._id_A9B1 = 0;
            self.asm._id_11A90._id_A9B0 = 1;
          }
        } else {
          self.asm._id_11A90._id_A9B2 = 0;
          self.asm._id_11A90._id_A9B1 = 0;
          self.asm._id_11A90._id_A9B0 = 0;
        }

        if(isDefined(self.asm._id_11A90._id_A9B0)) {
          var_37 = var_37 + self.asm._id_11A90._id_A9B2;
          var_45++;
        }
      }

      if(var_45 > 1)
        var_37 = var_37 / var_45;

      var_53 = 0;
      var_54 = 0;

      if(isDefined(var_32)) {
        var_53 = var_53 + angleclamp180(var_32 - var_44);
        var_54++;
      }

      if(isDefined(var_37)) {
        var_53 = var_53 + angleclamp180(var_37);
        var_54++;
      }

      if(var_54 > 1)
        var_53 = var_53 / var_54;

      var_53 = angleclamp180(var_53 + var_39);

      if(_id_34B0())
        var_53 = angleclamp180(var_53 - 20);

      var_53 = clamp(var_53, -53, 38);
      var_55 = 0;

      if(var_53 < 0) {
        var_56 = !self.asm._id_11A90._id_11A15;
        thread _id_34C2(var_10);

        if(var_40 > 0.05) {
          self _meth_82B1(var_11, -3.58077);
          var_55 = var_40;
        } else {
          var_57 = var_41;
          var_58 = var_57 * -53;
          var_59 = (var_53 - var_58) / -1.99248;

          if(abs(var_59) < 0.05)
            var_59 = 0;
          else
            var_59 = clamp(var_59, -2.66, 2.66);

          var_55 = var_57;

          if(var_57 < 0.05) {
            self clearanim(var_11, 0.05);
            self _meth_82AC(var_12, 1, 0.1, var_59);
          } else if(var_56)
            self _meth_82AC(var_12, 1, 0.1, var_59);
          else
            self _meth_82B1(var_12, var_59);
        }
      } else if(1) {
        var_56 = !self.asm._id_11A90._id_11A15;
        thread _id_34C2(var_10);
        var_41 = self islegacyagent(var_12);

        if(var_41 > 0.05) {
          self _meth_82B1(var_12, -2.66);
          var_55 = var_41;
        } else {
          var_57 = var_40;
          var_58 = var_57 * 38;
          var_59 = (var_53 - var_58) / 1.42857;

          if(abs(var_59) < 0.05)
            var_59 = 0;
          else
            var_59 = clamp(var_59, -3.58077, 3.58077);

          var_55 = var_57;

          if(var_57 < 0.05) {
            self clearanim(var_12, 0.05);
            self _meth_82AC(var_11, 1, 0.1, var_59);
          } else if(var_56)
            self _meth_82AC(var_11, 1, 0.1, var_59);
          else
            self _meth_82B1(var_11, var_59);
        }
      } else
        thread _id_3439(var_10);

      if(isDefined(var_31)) {
        var_60 = var_31 - var_43;
        var_61 = (0, var_44 + var_53, 0);
        var_62 = self gettagorigin("tag_weapon_right");
        var_63 = var_31 - var_62;
        var_64 = rotatevectorinverted(var_63, var_61);
        var_65 = vectortoangles(var_64);
        var_69 = 0;

        if(var_53 > 0)
          var_69 = var_69 + var_55 * 39;
        else
          var_69 = var_69 + var_55 * -52;

        var_70 = 0;
        var_71 = angleclamp180(var_65[1]);

        if(var_71 > self.leftaimlimit)
          var_70 = min(var_71 - self.leftaimlimit, 33);
        else if(var_71 < self.rightaimlimit)
          var_70 = max(var_71 - self.rightaimlimit, -38);

        var_71 = var_71 - var_70;
        var_72 = angleclamp180(var_65[0]);
        var_73 = 0;
        _id_34C0(var_70, var_73, var_16, var_17, var_18, var_15, var_13, var_14);
        var_74 = 0.66;
        var_71 = clamp(var_71, self.rightaimlimit, self.leftaimlimit);
        var_72 = clamp(var_72 - var_74, self.upaimlimit, self.downaimlimit);
        _id_34C6(var_71, var_72, var_0, var_1, var_2, var_3);
      } else
        _id_34F6(var_0, var_1, var_2, var_3);

      if(var_53 > 0)
        var_75 = var_55 * 38;
      else
        var_75 = var_55 * -53;

      if(isDefined(self.asm._id_11A90._id_AA38))
        _id_F83D(undefined, var_4, var_5, var_6, self.asm._id_11A90._id_AA3A - var_75, self.asm._id_11A90._id_AA39);
      else
        _id_34F7(var_4, var_5, var_6);

      if(isDefined(self.asm._id_11A90._id_A9B0))
        _id_F83D(var_7, var_8, var_9, undefined, self.asm._id_11A90._id_A9B2 - var_75, self.asm._id_11A90._id_A9B1);
      else
        _id_34F7(var_7, var_8, var_9);
    } else {
      thread _id_3439(var_10);
      _id_34F6(var_0, var_1, var_2, var_3);
      _id_34F7(var_7, var_8, var_9);
      _id_34F7(var_4, var_5, var_6);
      _id_34AD();
    }

    var_29 = var_30;
    wait 0.05;
  }
}

_id_34F6(var_0, var_1, var_2, var_3) {
  self clearanim(var_0, 0.2);
  self clearanim(var_1, 0.2);
  self clearanim(var_2, 0.2);
  self clearanim(var_3, 0.2);
}

_id_34F5(var_0) {
  return -100 < var_0 && var_0 < 110;
}

_id_34F7(var_0, var_1, var_2) {
  self _meth_82AC(var_0, 0, 0.2);
  self _meth_82AC(var_1, 0, 0.2);
  self _meth_82AC(var_2, 0, 0.2);
}

_id_34AD() {
  self.asm._id_11A90._id_AA3A = 0;
  self.asm._id_11A90._id_A9B2 = 0;
  self.asm._id_11A90._id_AA39 = 0;
  self.asm._id_11A90._id_A9B1 = 0;
  self.asm._id_11A90._id_AA38 = undefined;
  self.asm._id_11A90._id_A9B0 = undefined;
}

_id_3439(var_0) {
  if(!self.asm._id_11A90._id_11A15) {
    return;
  }
  self endon("end_cleartorsoknob");
  self endon("death");
  self notify("end_settorsoknob");
  self.asm._id_11A90._id_11A15 = 0;
  var_1 = self _meth_8103(var_0);

  if(var_1 > 1) {
    self _meth_82A2(var_0, 1, 0.2);
    wait 0.2;
  }

  var_1 = self _meth_8103(var_0);

  if(var_1 > 1) {
    self _meth_82A2(var_0, 1, 0.3);
    wait 0.3;
  }

  self clearanim(var_0, 0.5);
  wait 0.5;
}

_id_34C2(var_0) {
  if(self.asm._id_11A90._id_11A15) {
    return;
  }
  self endon("end_settorsoknob");
  self endon("death");
  self notify("end_cleartorsoknob");
  self.asm._id_11A90._id_11A15 = 1;
  var_1 = self _meth_8103(var_0);

  if(var_1 < 1) {
    self _meth_82A2(var_0, 1, 0.3);
    wait 0.3;
  }

  var_1 = self _meth_8103(var_0);

  if(var_1 < 1) {
    self _meth_82A2(var_0, 1, 0.2);
    wait 0.2;
  }

  self _meth_82A2(var_0, 1, 0.2);
  wait 0.2;
}

_id_3456(var_0, var_1) {
  if(self.a._id_5605) {
    return;
  }
  if(isDefined(self.asm._id_2AD2)) {
    return;
  }
  foreach(var_7, var_3 in self._id_164D) {
    if(isDefined(var_3._id_2F3C)) {
      var_4 = var_3._id_4BC0;
      var_5 = anim.asm[var_7].states[var_4];

      if(!isDefined(var_5._id_C87F)) {
        continue;
      }
      var_6 = anim.asm[var_7].states[var_5._id_C87F];

      if(var_0)
        self._blackboard._id_A983 = gettime();

      if(var_1)
        self._blackboard._id_AA21 = gettime();

      scripts\asm\asm::asm_setstate(var_5._id_C87F);
      break;
    }
  }
}

_id_3442() {
  for(;;) {
    self waittill("damage");
    var_0 = _id_100BB(self.damagelocation);
    _id_34CA(var_0, self.lastattacker, self.damageyaw, self.damagemod);

    if(self.damagelocation == "right_arm_upper" || self.damagelocation == "right_arm_lower")
      self.asm._id_11A90._id_A968 = gettime();

    if(isDefined(self.lastattacker) && isPlayer(self.lastattacker)) {
      self._blackboard._id_D419 = (self._blackboard._id_D419 + 1) % 30;
      self._blackboard._id_D41A[self._blackboard._id_D419] = gettime();
      self._blackboard._id_D418[self._blackboard._id_D419] = self.damagetaken;
    }

    if(isexplosivedamagemod(self.damagemod) && self.damagetaken > 50)
      _id_3456(1, 1);
  }
}

_id_3444() {
  self._blackboard._id_A96E = -9999;
  self._blackboard._id_A96C = -9999;

  for(;;) {
    self waittill("damage_subpart", var_0);
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    foreach(var_5 in var_0) {
      var_6 = var_5.point;
      var_7 = var_5.point[2] - self.origin[2] - 40 > 0;
      var_8 = var_5.hitloc;
      var_1 = var_1 + var_5.amount;

      if(isexplosivedamagemod(var_5.type))
        var_2 = var_2 + var_5.amount;
      else
        var_1 = var_1 + var_5.amount;

      _id_34CA(var_7, var_5.attacker, vectortoyaw(var_5._id_00F2) - self.angles[1], var_5.type);

      if(self _meth_850C(var_5.partname, var_5.subpartname) <= 0)
        var_3 = 1;

      var_9 = gettime();

      if(var_5.partname == "shield_upper") {
        if(self._blackboard._id_12F91 == 0) {
          if(!isDefined(self._id_12F8D))
            self._id_12F8D = scripts\engine\utility::spawn_tag_origin();

          self._id_12F8D linkTo(self, "j_wristshield", (1, 0, -10), (180, 0, 0));
          playFXOnTag(level._id_7649["vfx_shield_impact_model"], self._id_12F8D, "tag_origin");
        }

        self._blackboard._id_A96E = var_9;
      } else if(var_5.partname == "shield_lower") {
        if(self._blackboard._id_B0E3 == 0) {
          if(!isDefined(self._id_B0DB))
            self._id_B0DB = scripts\engine\utility::spawn_tag_origin();

          self._id_B0DB linkTo(self, "j_wristbtmshield", (0, 0, 0), (0, 0, 0));
          playFXOnTag(level._id_7649["vfx_shield_impact_model"], self._id_B0DB, "tag_origin");
        }

        self._blackboard._id_A96C = var_9;
      }

      if(var_5.partname == "right_arm")
        self.asm._id_11A90._id_A968 = var_9;

      if(isDefined(var_5.attacker) && isPlayer(var_5.attacker)) {
        self._blackboard._id_D419 = (self._blackboard._id_D419 + 1) % 30;
        self._blackboard._id_D41A[self._blackboard._id_D419] = var_9;
        self._blackboard._id_D418[self._blackboard._id_D419] = var_5.amount;
      }
    }

    var_11 = var_2 > 50;

    if(var_11 || var_3)
      _id_3456(var_11, var_11);
  }
}

_id_34CA(var_0, var_1, var_2, var_3) {
  if(isexplosivedamagemod(var_3)) {
    return;
  }
  var_4 = gettime();

  if(var_0) {
    if(isDefined(self.asm._id_11A90._id_A963) && isPlayer(self.asm._id_11A90._id_A963) && !isPlayer(var_1)) {
      if(var_4 - self.asm._id_11A90._id_A96D < 1000)
        return;
    }

    self.asm._id_11A90._id_A96D = gettime();
    self.asm._id_11A90._id_A96F = angleclamp180(var_2 + 180);
    self.asm._id_11A90._id_A963 = var_1;
  } else {
    if(isDefined(self.asm._id_11A90._id_A962) && isPlayer(self.asm._id_11A90._id_A962) && !isPlayer(var_1)) {
      if(var_4 - self.asm._id_11A90._id_A96B < 1000)
        return;
    }

    self.asm._id_11A90._id_A96B = gettime();
    self.asm._id_11A90._id_A966 = angleclamp180(var_2 + 180);
    self.asm._id_11A90._id_A962 = var_1;
  }
}

_id_34B0() {
  return isDefined(self.asm._id_11A90._id_A968) && gettime() - self.asm._id_11A90._id_A968 < 2000;
}

_id_100BB(var_0) {
  switch (var_0) {
    case "left_hand":
    case "right_arm_upper":
    case "left_arm_upper":
    case "neck":
    case "torso_upper":
    case "torso_lower":
    case "helmet":
    case "head":
      return 1;
  }

  return 0;
}

_id_F83D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 1;

  if(var_4 > 0) {
    var_7 = clamp(var_4 / 50, 0, 1);
    var_8 = 0;
  } else {
    var_4 = var_4 - 15;
    var_7 = 0;
    var_8 = clamp(var_4 / -45, 0, 1);
  }

  self _meth_82AC(var_1, var_7 * var_10);
  self _meth_82AC(var_2, var_8 * var_10);

  if(isDefined(var_0)) {
    if(var_5 > 0)
      var_6 = clamp(var_5 / 48, 0, 1);

    self _meth_82AC(var_0, var_6 * var_10);
  }

  if(isDefined(var_3)) {
    if(var_5 < 0)
      var_9 = clamp(var_5 / -20, 0, 1);

    self _meth_82AC(var_3, var_9 * var_10);
  }
}

_id_34CC() {
  var_0 = _id_0A1E::_id_2356("shield_openclose", "upper_open");
  var_1 = _id_0A1E::_id_2356("shield_openclose", "lower_open");
  var_2 = self _meth_850C("shield_upper", "shield");
  var_3 = self _meth_850C("shield_lower", "shield");
  var_4 = var_2 / 5.5 * 0.05;
  var_5 = var_3 / 5.5 * 0.05;
  self _meth_82A2(var_0, 1, 0, 1);
  self _meth_82B0(var_0, 1);
  self._blackboard._id_12F91 = 0;
  self _meth_82A2(var_1, 1, 0, 1);
  self _meth_82B0(var_1, 1);
  self._blackboard._id_B0E3 = 0;

  for(;;) {
    var_6 = gettime();
    var_7 = scripts\asm\asm_bb::bb_isanimScripted();

    if(!var_7) {
      self._blackboard._id_280C = undefined;
      self._blackboard._id_280B = undefined;
    } else {
      if(self._blackboard._id_12F91 != 2 && !isDefined(self._blackboard._id_280C))
        self._blackboard._id_12F91 = 5;

      if(self._blackboard._id_B0E3 != 2 && !isDefined(self._blackboard._id_280B))
        self._blackboard._id_B0E3 = 5;
    }

    switch (self._blackboard._id_12F91) {
      case 3:
        var_8 = self islegacyagent(var_0);

        if(var_8 >= 1)
          self._blackboard._id_12F91 = 0;

        break;
      case 0:
        if(!isDefined(self._id_12F8D)) {
          self._id_12F8D = scripts\engine\utility::spawn_tag_origin();
          self._id_12F8D linkTo(self, "j_wristshield", (1, 0, -10), (180, 0, 0));
        }

        var_9 = self _meth_850C("shield_upper", "shield");

        if(var_9 < var_2) {
          if(var_6 - 5000 > self._blackboard._id_A96E) {
            var_10 = var_9 + var_4 * 0.5;
            var_10 = clamp(var_10, 0, var_2);
            self _meth_8550("shield_upper", "shield", var_10);
          }
        }

        break;
      case 4:
        self setscriptablepartstate("shield_upper", "normal");
        var_8 = self islegacyagent(var_0);

        if(var_8 < 0.5 && isDefined(self._id_12F8D)) {
          self._id_12F8D delete();
          self._id_12F8D = undefined;
        }

        if(var_8 <= 0) {
          self._blackboard._id_12F91 = 1;
          self hidepart("tag_top_flicker", "weapon_retract_shield_top_wm");
        }

        break;
      case 1:
        if(isDefined(self._blackboard._id_12F90)) {
          var_9 = self _meth_850C("shield_upper", "shield");

          if(var_9 < var_2) {
            var_10 = var_9 + var_4;
            var_10 = clamp(var_10, 0, var_2);
            self _meth_8550("shield_upper", "shield", var_10);

            if(var_10 == var_2)
              _id_348B();
          }
        }

        break;
      case 5:
        if(!var_7) {
          self _meth_82A2(var_0, 1, 0, 1);
          self _meth_82B0(var_0, 1);
          self._blackboard._id_12F91 = 0;
        }

        break;
    }

    switch (self._blackboard._id_B0E3) {
      case 3:
        var_8 = self islegacyagent(var_1);

        if(var_8 >= 1)
          self._blackboard._id_B0E3 = 0;

        break;
      case 0:
        if(!isDefined(self._id_B0DB)) {
          self._id_B0DB = scripts\engine\utility::spawn_tag_origin();
          self._id_B0DB linkTo(self, "j_wristbtmshield", (0, 0, 0), (0, 0, 0));
        }

        var_9 = self _meth_850C("shield_lower", "shield");

        if(var_9 < var_3) {
          if(var_6 - 5000 > self._blackboard._id_A96C) {
            var_10 = var_9 + var_5 * 0.5;
            var_10 = clamp(var_10, 0, var_3);
            self _meth_8550("shield_lower", "shield", var_10);
          }
        }

        break;
      case 4:
        self setscriptablepartstate("shield_lower", "normal");
        var_8 = self islegacyagent(var_1);

        if(var_8 < 0.5 && isDefined(self._id_B0DB)) {
          self._id_B0DB delete();
          self._id_B0DB = undefined;
        }

        if(var_8 <= 0) {
          self._blackboard._id_B0E3 = 1;
          self hidepart("tag_flicker", "weapon_retract_shield_wm");
        }

        break;
      case 1:
        if(isDefined(self._blackboard._id_B0E2)) {
          var_9 = self _meth_850C("shield_lower", "shield");

          if(var_9 < var_3) {
            var_10 = var_9 + var_4;
            var_10 = clamp(var_10, 0, var_3);
            self _meth_8550("shield_lower", "shield", var_10);

            if(var_10 == var_2)
              _id_348A();
          }
        }

        break;
      case 5:
        if(!var_7) {
          self _meth_82A2(var_1, 1, 0, 1);
          self _meth_82B0(var_1, 1);
          self._blackboard._id_B0E3 = 0;
        }

        break;
    }

    wait 0.05;
  }
}

_id_348B(var_0) {
  if(self._blackboard._id_12F91 == 2) {
    return;
  }
  var_1 = _id_0A1E::_id_2356("shield_openclose", "upper_open");

  if(isDefined(var_0)) {
    if(self _meth_8103(var_1) == 0) {
      self _meth_82A2(var_1, 1, 0, 1);
      self _meth_82B0(var_1, 1);
    }

    self._blackboard._id_280C = 1;
  }

  self _meth_82B1(var_1, 1);
  self._blackboard._id_12F91 = 3;
  self showpart("tag_top_flicker", "weapon_retract_shield_top_wm");
  self playSound("c8_shield_open_upper");
}

_id_343B(var_0) {
  self setscriptablepartstate("shield_upper", "normal");

  if(self._blackboard._id_12F91 == 2) {
    return;
  }
  var_1 = _id_0A1E::_id_2356("shield_openclose", "upper_open");

  if(isDefined(var_0)) {
    if(self _meth_8103(var_1) == 0) {
      self _meth_82A2(var_1, 1, 0, 1);
      self _meth_82B0(var_1, 1);
    }

    self._blackboard._id_280C = 1;
  }

  self _meth_82B1(var_1, -1);
  self._blackboard._id_12F91 = 4;
  self playSound("c8_shield_close_upper");
}

_id_348A(var_0) {
  if(self._blackboard._id_B0E3 == 2) {
    return;
  }
  var_1 = _id_0A1E::_id_2356("shield_openclose", "lower_open");

  if(isDefined(var_0)) {
    if(self _meth_8103(var_1) == 0) {
      self _meth_82A2(var_1, 1, 0, 1);
      self _meth_82B0(var_1, 1);
    }

    self._blackboard._id_280B = 1;
  }

  self _meth_82B1(var_1, 1);
  self._blackboard._id_B0E3 = 3;
  self showpart("tag_flicker", "weapon_retract_shield_wm");
  self playSound("c8_shield_open_lower");
}

_id_343A(var_0) {
  self setscriptablepartstate("shield_lower", "normal");

  if(self._blackboard._id_B0E3 == 2) {
    return;
  }
  var_1 = _id_0A1E::_id_2356("shield_openclose", "lower_open");

  if(isDefined(var_0)) {
    if(self _meth_8103(var_1) == 0) {
      self _meth_82A2(var_1, 1, 0, 1);
      self _meth_82B0(var_1, 1);
    }

    self._blackboard._id_280B = 1;
  }

  self _meth_82B1(var_1, -1);
  self._blackboard._id_B0E3 = 4;
  self playSound("c8_shield_close_lower");
}

_id_34C4(var_0) {
  self setscriptablepartstate("shield_upper", "normal");

  if(var_0) {
    self._blackboard._id_12F91 = 2;
    var_1 = _id_0A1E::_id_2356("shield_openclose", "upper_open");
    self clearanim(var_1, 0);
  }
}

_id_34C1(var_0) {
  self setscriptablepartstate("shield_lower", "normal");

  if(var_0) {
    self._blackboard._id_B0E3 = 2;
    var_1 = _id_0A1E::_id_2356("shield_openclose", "lower_open");
    self clearanim(var_1, 0);
  }
}

_id_3428(var_0) {
  return var_0 == 0;
}

_id_34CB(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_2F36);
}

_id_3498(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard._id_FC93;
  self orientmode("face angle", var_4[1]);
  var_5 = self[[self._id_7191]](var_0, var_1);
  self playSound("vox_c8_shieldplant");
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1, ::_id_3499);
}

_id_349A(var_0, var_1, var_2) {
  self._blackboard._id_2F36 = undefined;
}

_id_3499(var_0) {
  if(var_0 == "plant_shield") {
    if(isDefined(self._blackboard._id_FC93))
      var_1 = self._blackboard._id_FC93;
    else
      var_1 = self.angles;

    var_2 = anglesToForward(var_1);
    var_3 = (48, 0, 20);
    var_4 = self localtoworldcoords(var_3);
    self setscriptablepartstate("shield_lower", "planted");
    var_5 = spawn("script_model", var_4);
    var_5 setModel("weapon_retract_shield_wm");
    var_5.origin = var_4 + (0, 0, 4);
    var_5.angles = var_1 - (0, 90, 0);
    var_5 playSound("c8_shield_plant");
    var_6 = 24;
    var_7 = var_4 - var_2 * var_6;
    var_8 = spawncovernode(var_7, var_1, "Cover Crouch");
    var_9 = (var_1[0], angleclamp180(var_1[1] + 180), var_1[2]);
    var_10 = var_4 + var_2 * var_6;
    var_11 = spawncovernode(var_10, var_9, "Cover Crouch");
    var_12 = createnavobstaclebybounds(var_4, (6, 18, 36), var_1);
    self._blackboard._id_B0E3 = 2;
    thread _id_34C8(var_5, var_12, var_8, var_11);
  }
}

_id_34C8(var_0, var_1, var_2, var_3) {
  wait 600;
  despawncovernode(var_2);
  despawncovernode(var_3);
  destroynavobstacle(var_1);
  var_0 delete();
}

_id_3432(var_0, var_1, var_2) {
  return _id_0F3D::_id_3EAB(var_0, var_1, var_2);
}

_id_3424(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_313C) && isDefined(self._blackboard._id_11830);
}

_id_349B(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  self playSound("vox_c8_grenade_launch");
  var_5 = self._blackboard._id_11830;
  var_6 = self._blackboard._id_1182B;
  var_7 = self._blackboard._id_11833;
  var_8 = self._blackboard._id_11834;
  var_9 = vectortoyaw(var_6 - self.origin);
  self orientmode("face angle", var_9);
  thread _id_3491(var_0, var_1);
  scripts\anim\battlechatter_ai::_id_67CF(var_8);
  _id_349C(var_1);
  var_10 = self gettagorigin("tag_accessory_right");
  var_11 = 4;
  self.grenadeweapon = var_8;
  var_12 = self _meth_81ED(var_10, var_6, var_11, 1);

  if(!isDefined(var_12))
    var_12 = self _meth_81EE(var_10, var_7, var_11);

  if(isDefined(var_12))
    var_12 makeunusable();

  self playSound("c8_grenade_launch");
}

_id_3491(var_0, var_1) {
  self endon(var_1 + "_finished");
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_349C(var_0) {
  for(;;) {
    self waittill(var_0, var_1);
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4 == "grenade throw" || var_4 == "grenade_throw") {
        return;
      }
      if(var_4 == "end")
        return;
    }
  }
}

_id_3427() {
  return self._blackboard._id_12F91 == 0 || self._blackboard._id_B0E3 == 0;
}

_id_3435(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getmeleetarget();
  var_4 = vectorNormalize(var_3.origin - self.origin);
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0.707)
    return _id_0A1E::_id_2356(var_1, "f");
  else {
    var_7 = vectorcross(var_5, var_4);

    if(var_7[2] > 0)
      return _id_0A1E::_id_2356(var_1, "l");
    else
      return _id_0A1E::_id_2356(var_1, "r");
  }
}

_id_34A3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  if(self._blackboard._id_12F91 == 0)
    self setscriptablepartstate("shield_upper_fx", "fx_equip_shield_bash");

  if(self._blackboard._id_B0E3 == 0)
    self setscriptablepartstate("shield_lower_fx", "fx_equip_shield_bash");

  thread _id_0B1D::_id_DBDB(self.origin);
  var_5 = var_3[0];
  var_6 = var_3[1];

  if(isDefined(var_6) && var_6) {
    var_7 = getangledelta(var_4);
    childthread _id_34A4(var_1, var_7);
  } else
    self orientmode("face angle", self.angles[1]);

  self playSound("vox_c8_melee");
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1.0, var_2, 1.5);

  if(isDefined(var_5))
    self _meth_82B0(var_4, var_5);

  self endon(var_1 + "_finished");
  _id_0C64::donotetracks_vsplayer(var_0, var_1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_34A4(var_0, var_1) {
  self endon(var_0 + "_finished");
  var_2 = scripts\asm\asm_bb::bb_getmeleetarget();

  for(;;) {
    var_3 = var_2.origin - self.origin;
    var_4 = vectortoyaw(var_3);
    var_5 = var_4 - var_1;
    self orientmode("face angle", var_5);
    wait 0.05;
  }
}

_id_34E2(var_0, var_1, var_2) {
  self._blackboard._id_3132 = undefined;
}

_id_7DD5() {
  if(isDefined(self.scriptedarrivalent))
    return self.scriptedarrivalent.origin;

  if(isDefined(self.node))
    return self.node.origin;

  if(isDefined(self.pathgoalpos))
    return self.pathgoalpos;

  return self.goalpos;
}

_id_7DD4() {
  if(isDefined(self.scriptedarrivalent))
    return self.scriptedarrivalent.angles;

  if(isDefined(self.node))
    return self.node.angles;

  return self.angles;
}

_id_CEAB(var_0, var_1, var_2) {
  self.asm._id_11068 = undefined;
}

_id_342F(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right")
    var_3 = "right";
  else
    var_3 = "left";

  var_4 = [];
  var_4[0] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "0");
  var_4[1] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "1");
  var_4[2] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "2");
  var_4[3] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "3");
  var_4[4] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "4");
  var_4[5] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "5");
  var_4[6] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "6");
  var_4[7] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "7");
  var_4[8] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "8");
  return var_4;
}

_id_348F(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = undefined;

  if(isDefined(self._id_110D5))
    var_5 = self._id_110D5;
  else
    var_5 = self _meth_813E();

  var_6 = _id_0C65::_id_817A(var_5);
  var_7 = 0;
  var_8 = 1.0;
  var_9 = -1;
  var_10 = (0, 0, 0);
  var_11 = 0;
  var_12 = _id_7DD5();
  var_13 = self.angles;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  while(var_7 < var_6.size) {
    if(var_6[var_7] <= 0) {
      var_7++;
      continue;
    }

    if(var_9 < 0 || var_4[var_7] == var_4[var_9]) {
      self _meth_82E1(var_1, var_4[var_7], var_6[var_7], 0.05, var_8, 1);
      var_9 = var_7;
    } else
      self _meth_82A2(var_4[var_7], var_6[var_7], 0.05, var_8, 1);

    var_10 = var_10 + getmovedelta(var_4[var_7]) * var_6[var_7];
    var_11 = var_11 + getangledelta(var_4[var_7]) * var_6[var_7];
    var_7++;
  }

  var_14 = rotatevector(var_10, var_13);
  var_15 = var_12 - var_14;
  var_16 = var_13[1] - var_11;
  self _meth_8396(self.origin, var_16);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self.a.movement = "stop";
}

_id_1008D(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals) && self.disablearrivals)
    return 0;

  var_4 = gettime() - self.asm.footsteps.time;

  if(var_4 > 100)
    return 0;

  var_5 = _id_3463();

  if(abs(angleclamp180(var_5)) > 60 && self._blackboard._id_5280 != 1)
    return 1;

  var_6 = self _meth_813E();

  if(abs(var_6 - self._id_110D5) > 60)
    return 1;

  if(!scripts\asm\asm::_id_232B(var_1, "cover_approach") && isDefined(self.pathgoalpos))
    return 0;

  var_7 = _id_7DD5();

  if(isDefined(var_7) && isDefined(self.pathgoalpos)) {
    var_8 = 48;
    var_9 = var_7 - self.origin;
    var_10 = length(var_9);

    if(var_10 > var_8)
      return 0;
  }

  return 1;
}

_id_3495(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  thread _id_349F(var_1);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_3494(var_0, var_1, var_2, var_3) {
  var_4 = self[[self._id_7191]](var_0, var_1);
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  self _meth_8396(self.origin, self.angles[1]);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self.a.movement = "stop";
}

_id_3722(var_0, var_1, var_2) {
  var_1 = _id_7DD5();
  var_3 = _id_7DD4();
  var_4 = var_1 - self.origin;

  if(length2dsquared(var_4) < 1)
    var_5 = 4;
  else {
    var_6 = vectortoyaw(var_4);
    var_7 = angleclamp180(var_3[1] - var_6);
    var_5 = getangleindex(var_7, 22.5);
  }

  var_8 = _id_0C5D::_id_8174(var_0, undefined, 1);

  if(!isDefined(var_8[var_5]))
    return undefined;

  var_9 = getmovedelta(var_8[var_5]);
  var_10 = getangledelta3d(var_8[var_5]);
  var_11 = rotatevector(var_9, self.angles);
  var_12 = var_11 + self.origin;
  var_13 = 0;
  var_14 = distancesquared(var_12, var_1);

  if(var_14 > var_2 * var_2) {
    var_12 = var_12 + var_11;
    var_15 = distancesquared(var_12, var_1);

    if(var_15 < var_14)
      return undefined;

    var_13 = 1;
  }

  var_16 = self _meth_84AC();
  var_17 = navtrace(var_16, var_12, self, 1);
  var_18 = 0.9;

  if(!var_13)
    var_18 = 0.5;

  if(var_17["fraction"] < var_18) {
    var_19 = getclosestpointonnavmesh(var_12, self);

    if(!_func_2AC(var_16, var_19, self))
      return undefined;
  }

  if(var_13) {
    var_11 = rotatevector(var_9, var_3 - var_10);
    var_20 = var_1 - var_11;
  } else
    var_20 = self.origin;

  var_21 = spawnStruct();
  var_21._id_02C9 = var_8[var_5];
  var_21.angleindex = var_5;
  var_21.startpos = var_20;
  var_21.angledelta = var_10[1];
  var_21._id_0130 = var_3;
  var_21._id_01F3 = var_9;
  return var_21;
}

_id_3431(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_3[1] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_3[2] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3[3] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "3");
  var_3[4] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  var_3[5] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "5");
  var_3[6] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  var_3[7] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "7");
  var_3[8] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "8");
  return var_3;
}

_id_3492(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self.lookaheaddir;
  var_6 = vectortoangles(var_5);
  var_7 = var_6[1];
  var_8 = angleclamp180(var_7 - self.angles[1]);
  var_9 = _id_0C65::_id_817A(var_8);
  var_10 = 0;
  var_11 = 1.0;
  var_12 = -1;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  while(var_10 < var_9.size) {
    if(var_9[var_10] <= 0) {
      var_10++;
      continue;
    }

    if(var_12 < 0 || var_4[var_10] == var_4[var_12]) {
      self _meth_82E1(var_1, var_4[var_10], var_9[var_10], 0.05, var_11, 1);
      var_12 = var_10;
    } else
      self _meth_82A2(var_4[var_10], var_9[var_10], 0.05, var_11, 1);

    var_10++;
  }

  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_34AA(var_0, var_1, var_2, var_3) {
  self._blackboard.btstate_addsubstate = 1;
  scripts\sp\gameskill::_id_54C4();
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_34AB(var_0, var_1, var_2) {
  self._blackboard.btstate_addsubstate = undefined;
}

_id_34A1(var_0, var_1, var_2, var_3) {
  self._blackboard._id_11936 = gettime();
  var_4 = self._id_164D[var_0];

  if(isDefined(var_4._id_10E23) && (var_4._id_10E23 == "stand_run_loop" || var_4._id_10E23 == "stand_walk_loop"))
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);

  _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
}

_id_34A2(var_0, var_1, var_2) {
  self._blackboard._id_11936 = undefined;
}

_id_349D(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("melee_charge_state", "started");
  childthread _id_755A();
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  var_4 = self[[self._id_7191]](var_0, var_1);
  self _meth_82EA(var_1, var_4, 1, var_2, 2.0);

  if(isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge) {
    if(isDefined(self.melee._id_2AC6) && self.melee._id_2AC6) {
      self playSound("vox_c8_melee_rush");
      thread _id_342D(var_1);
    } else
      self playSound("vox_c8_melee_charge");
  }

  self.turnrate = 0.3;
  thread _id_349F(var_1);

  for(;;)
    _id_0A1E::_id_231F(var_0, var_1);
}

_id_349E(var_0, var_1, var_2) {
  if(!isDefined(self._blackboard._id_3105))
    _id_755B();
}

_id_342D(var_0) {
  self _meth_8460("c8_charge", "charging");
  self waittill(var_0 + "_finished");
  self _meth_8460("c8_charge", "");
}

_id_349F(var_0) {
  self endon(var_0 + "_finished");

  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      var_1 = vectortoyaw(self.lookaheaddir);
      self orientmode("face angle", var_1);
    }

    wait 0.05;
  }
}

_id_34B6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee))
    return 1;

  if(isDefined(self.melee._id_2720) && self.melee._id_2720)
    return 1;

  return 0;
}

_id_3423(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_3105);
}

_id_3422(var_0, var_1, var_2, var_3) {
  return !_id_3423(var_0, var_1, var_2, var_3);
}

_id_3496(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self[[self._id_7191]](var_0, var_1);

  if(self _meth_8103(var_4) <= 0.1) {
    self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
    self _meth_82EA(var_1, var_4, 1, var_2, 2);
  } else
    self _meth_82E1(var_1, var_4, 1, var_2, 2);

  thread _id_34E3(var_0, var_1);
  var_5 = self.origin;
  var_6 = 16384;

  for(;;) {
    if(distancesquared(self.origin, var_5) > var_6) {
      break;
    }

    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * sqrt(self.meleerangesq);

    if(navtrace(self.origin, var_8, self)) {
      break;
    }

    wait 0.05;
  }

  self._blackboard._id_3105 = undefined;
}

_id_3497(var_0, var_1, var_2) {
  if(!scripts\asm\asm_bb::bb_meleerequested(var_0, var_1, undefined, var_2))
    _id_755B();
}

_id_34A5(var_0, var_1, var_2, var_3) {
  self._blackboard.bmoving = 1;
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
  _id_34A6(var_0, var_1, var_2, var_3);
}

_id_34A6(var_0, var_1, var_2, var_3) {
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  _id_346F(var_0, var_1, var_2, var_3);
  thread _id_3483(var_0, var_1, var_2, var_3);
}

_id_346F(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  foreach(var_7 in var_5)
  self _meth_82A9(var_7, 1, 0.1, var_4, 1);
}

_id_3436(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_3[1] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_3[2] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3[3] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "3");
  var_3[4] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  var_3[5] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "5");
  var_3[6] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  var_3[7] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "7");
  var_3[8] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "8");
  return var_3;
}

_id_3461() {
  var_0 = undefined;

  if(_id_0C01::_id_347C()) {
    var_0 = self _meth_845C(128);
    self._blackboard._id_5280 = 0;
  } else if(_id_3424()) {
    var_0 = self._blackboard._id_11830.origin;
    self._blackboard._id_5280 = 1;
  } else if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams._id_2AA8) && isDefined(self._blackboard.shootparams.target)) {
    if(isDefined(self._blackboard.shootparams._id_2AA7))
      var_0 = self._blackboard.shootparams.pos;
    else
      var_0 = self._blackboard.shootparams.target.origin;

    self._blackboard._id_5280 = 1;
  } else if(isDefined(self.bt.enemies) && isDefined(self.bt.enemies[0])) {
    var_1 = 192;
    var_2 = 64;
    var_3 = self.bt.enemies[0];
    var_4 = var_1;

    if(self._blackboard._id_5280 == 1)
      var_4 = var_4 + var_2;

    var_5 = distance(self.origin, var_3.origin);

    if(var_5 < var_4) {
      var_0 = var_3.origin;
      self._blackboard._id_5280 = 1;
    } else {
      if(isPlayer(var_3)) {
        var_6 = vectorNormalize(self._blackboard._id_26A7 - self.origin);
        var_7 = vectorNormalize(var_3.origin - self.origin);
        var_8 = vectordot(var_6, var_7);
        var_9 = vectorcross(var_6, var_7);

        if(var_8 < 0 || var_9[2] > 0 && var_8 < 0.833) {
          var_10 = vectortoyaw(var_7);
          var_11 = angleclamp180(var_10 - 75);
          self._blackboard._id_5280 = 4;
          return var_11;
        }
      }

      var_0 = self._blackboard._id_26A7;
      self._blackboard._id_5280 = 2;
    }
  } else if(isDefined(self.pathgoalpos)) {
    var_0 = self _meth_845C(128);
    self._blackboard._id_5280 = 0;
  } else {
    self._blackboard._id_5280 = 3;
    return self.angles[1];
  }

  var_12 = var_0 - self.origin;
  var_13 = vectortoangles(var_12);
  return var_13[1];
}

_id_34E3(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;)
    _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_3483(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1.0;

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._id_110D5 = self _meth_813E();
  self.turnrate = 0.18;
  thread _id_34E3(var_0, var_1);

  for(;;) {
    if(self._blackboard._id_5280 == 1)
      var_6 = _id_3461();
    else
      var_6 = self.angles[1];

    self orientmode("face angle", var_6);
    var_7 = self _meth_813E();

    if(abs(var_7 - self._id_110D5) < 5)
      self._id_110D5 = var_7;
    else if(var_7 > self._id_110D5)
      self._id_110D5 = self._id_110D5 + 5;
    else if(var_7 < self._id_110D5)
      self._id_110D5 = self._id_110D5 - 5;

    var_8 = _id_0C65::_id_817A(self._id_110D5);
    var_9 = -1;

    for(var_10 = 0; var_10 < var_8.size; var_10++) {
      if(isDefined(var_5[var_10])) {
        if(var_8[var_10] > 0 && (var_9 < 0 || var_5[var_10] == var_5[var_9])) {
          self _meth_82E1(var_1, var_5[var_10], var_8[var_10], 0.05, var_4, 1);
          var_9 = var_10;
          continue;
        }

        self _meth_82A2(var_5[var_10], var_8[var_10], 0.05, var_4, 1);
      }
    }

    wait 0.05;
    waittillframeend;
  }
}

_id_3481(var_0, var_1, var_2) {
  self._blackboard.bmoving = undefined;
}

_id_3484(var_0, var_1, var_2, var_3) {
  var_4 = _id_3463();
  return abs(angleclamp180(var_4)) > self._id_129AF;
}

_id_3485(var_0, var_1, var_2, var_3) {
  if(_id_3424(var_0, var_1, var_2, var_3)) {
    var_4 = vectortoyaw(self._blackboard._id_11830.origin - self.origin);
    return abs(angleclamp180(var_4 - self.angles[1])) > 90;
  }

  return 0;
}

_id_3463() {
  var_0 = _id_3461();
  return angleclamp180(var_0 - self.angles[1]);
}

_id_3437(var_0, var_1, var_2) {
  var_3 = _id_3463();

  if(var_3 < 0)
    var_4 = "right";
  else
    var_4 = "left";

  var_3 = abs(var_3);
  var_5 = 0;

  if(var_3 > 157.5)
    var_5 = 180;
  else if(var_3 > 112.5)
    var_5 = 135;
  else if(var_3 > 67.5)
    var_5 = 90;
  else
    var_5 = 45;

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  return var_7;
}

_id_3448() {
  var_0 = _id_0A1E::_id_2356("shield_openclose", "upper_open");
  var_1 = _id_0A1E::_id_2356("shield_openclose", "lower_open");
  self _meth_82A2(var_0, 1, 0.2, 0);
  self _meth_82A2(var_1, 1, 0.2, 0);
  self playSound("vox_c8_death");

  if(!isDefined(self._id_2AAA) || !self._id_2AAA) {
    self.dropweapon = 0;
    self._id_C05C = undefined;
    scripts\anim\shared::_id_5D19();
    self dropweapon("iw7_steeldragon", "right", 0);
  }

  if(isDefined(self._id_6BC7))
    self._id_6BC7 delete();

  return 0;
}

_id_34A9(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self._blackboard._id_12F91 == 0 || self._blackboard._id_12F91 == 3) {
    var_4 = 1;
    thread scripts\engine\utility::delaythread(randomfloatrange(0.0, 2.0), ::_id_343B);
  }

  var_5 = 0;

  if(self._blackboard._id_B0E3 == 0 || self._blackboard._id_B0E3 == 3) {
    var_5 = 1;
    thread scripts\engine\utility::delaythread(randomfloatrange(0.0, 2.0), ::_id_343A);
  }

  _id_0C66::_id_D517(var_0, var_1, var_2, var_3);

  if(var_4)
    thread scripts\engine\utility::delaythread(randomfloatrange(0.0, 4.0), ::_id_348B);

  if(var_5)
    thread scripts\engine\utility::delaythread(randomfloatrange(0.0, 4.0), ::_id_348A);
}

_id_34D7(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_29D3);
}

_id_34A7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread _id_755B();
  self.asm._id_2AD2 = 1;
  var_4 = self[[self._id_7191]](var_0, var_1);

  if(isDefined(self._blackboard._id_AA21) && self._blackboard._id_AA21 == gettime())
    self._blackboard._id_29D3 = undefined;

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 0.35);
  self playSound("vox_c8_pain");
  _id_0A1E::_id_231F(var_0, var_1);
  self playSound("vox_c8_engaging");
}

_id_3493(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._blackboard._id_29D3 = undefined;
  self.asm._id_2AD2 = 1;
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  wait 5;
  scripts\asm\asm::asm_fireevent(var_1, "pain_stun_end");
}

_id_34A8(var_0, var_1, var_2) {
  self.asm._id_2AD2 = undefined;
}

_id_3482(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::_id_BCE7(var_0, var_1, var_2, var_3)) {
    if(scripts\asm\asm_bb::bb_meleerequested(var_0, var_1, var_2, var_3))
      return 1;

    var_4 = distancesquared(self.origin, self.pathgoalpos);

    if(var_4 > 4096)
      return 1;
  }

  return 0;
}

_id_34D5(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_2029);
}

_id_755A() {
  if(self._blackboard._id_12F91 == 0)
    self setscriptablepartstate("shield_upper_fx", "fx_shield_buildup");

  if(self._blackboard._id_B0E3 == 0)
    self setscriptablepartstate("shield_lower_fx", "fx_shield_buildup");

  wait 0.3;

  if(self._blackboard._id_12F91 == 0)
    self setscriptablepartstate("shield_upper_fx", "fx_shield_charging");

  if(self._blackboard._id_B0E3 == 0)
    self setscriptablepartstate("shield_lower_fx", "fx_shield_charging");
}

_id_755B() {
  var_0 = self getscriptablepartstate("shield_upper_fx");
  var_1 = self getscriptablepartstate("shield_lower_fx");

  if(var_0 == "fx_shield_buildup")
    self setscriptablepartstate("shield_upper_fx", "fx_shield_dissipating");
  else if(var_0 == "fx_shield_charging")
    self setscriptablepartstate("shield_upper_fx", "fx_shield_charging_dissipating");

  if(var_1 == "fx_shield_buildup")
    self setscriptablepartstate("shield_lower_fx", "fx_shield_dissipating");
  else if(var_1 == "fx_shield_charging")
    self setscriptablepartstate("shield_lower_fx", "fx_shield_charging_dissipating");
}