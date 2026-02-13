/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2287.gsc
*************************************************/

_id_8C36(var_0) {
  self endon("asm_terminated");
  self endon("death");

  if(isDefined(self._id_EAB8) && self._id_EAB8 == "juggernaut" || isDefined(self._id_1210) && self._id_1210 == "juggernaut") {
    childthread _id_8C5C();

    if(isDefined(level._id_8C3E)) {
      self childthread[[level._id_8C3E]]();
    } else {
      childthread _id_8C3C();
    }

    var_1 = 0;

    if(!var_1 && scripts\common\utility::iscp()) {
      childthread _id_7FC7();
    }
  }
}

_id_8133(var_0) {
  if(_func_03A3(var_0)) {
    return;
  }
  anim._id_8C7E = 1;
  _func_03A2(var_0, "walk", 40);
  _func_03A2(var_0, "jog", 113);
  _func_03A2(var_0, "run", 170);
}

_id_8C50() {
  return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || (self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "s4_pi_mike1911" && self.damagemod != "MOD_MELEE");
}

_id_8C6C() {
  for(;;) {
    self waittill("pain");
    self._id_8C79 = gettime();
  }
}

_id_8C5C() {
  childthread _id_8C6C();

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(self.health > 0 && var_0 >= self._id_02B2) {
      if(_func_0205("generic_pain_enemy_1")) {
        self playSound("generic_pain_enemy_1");
      }

      self _meth_85CF(self._id_1CB8);
      var_10 = self._id_02B2;
      self._id_02B2 = var_10 * 3;
      wait 5;
      self._id_02B2 = var_10;
    }
  }
}

_id_8C3C() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(_id_8C50()) {
      continue;
    }
    if(self.damageweapon.basename == "s4_pi_mike1911") {
      if(var_7 == "j_head" || var_7 == "j_neck" || var_7 == "j_helmet") {
        var_10 = 70;
      } else {
        var_10 = 40;
      }
    } else
      var_10 = 40;

    if(var_0 < var_10) {
      var_10 = abs(var_0 - 5);
    }

    self.health = self.health + int(var_10);

    if(istrue(self._id_42D5)) {
      _id_19C0(self._id_0148, var_0);
    }
  }
}

_id_7FC7() {
  scripts\engine\utility::_id_5C24("scriptables_ready");

  if(!scripts\engine\utility::is_equal(self.model, "body_opforce_juggernaut_basebody")) {
    return;
  }
  self._id_42D5 = 1;
  self setscriptablepartstate("base", "pristine");
  _id_3F2E("left_arm", 100, ["left_arm_upper", "left_arm_lower", "left_hand"]);
  _id_3F2E("right_arm", 100, ["right_arm_upper", "right_arm_lower", "right_hand"]);
}

_id_3F2E(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.health = var_1;
  var_3._id_865A = 0;

  if(!isDefined(self._id_42F0)) {
    self._id_42F0 = [];
  }

  self._id_42F0[var_0] = var_3;

  if(!isDefined(self._id_42F1)) {
    self._id_42F1 = [];
  }

  foreach(var_5 in var_2) {
    self._id_42F1[var_5] = var_0;
  }
}

_id_19C0(var_0, var_1) {
  if(!isDefined(self._id_42F1[var_0])) {
    return;
  }
  var_2 = self._id_42F1[var_0];
  var_3 = self._id_42F0[var_2];
  var_3.health = var_3.health - var_1;

  if(var_3.health <= 0 && !istrue(var_3._id_865A)) {
    self setscriptablepartstate(var_2, "dmg", 1);
    var_3._id_865A = 1;
  }
}

_id_51E3() {
  if(isDefined(self._id_010D)) {
    self._id_37E5 = self._id_010D;
  }

  self._id_010D = "no_cover";
  self _meth_800D("stand");
  self._id_00DD = 1;
  self._id_4DA8 = 1;
  self._id_4DA7 = 1;
  self._id_37E6 = self._id_0206;
  self._id_0206 = 0;
  self._id_37E4 = istrue(self._id_002F);
  self._id_002F = 1;
  self._id_0230 = 1;
  scripts\engine\utility::set_movement_speed(50);
  self._id_04A8 = 0.1;
  self._id_0047 = 0;
  self._id_0168 = 1;
  self._id_4DB6 = 1;
  self._id_4A83 = 1;
  self._id_A441 = 1;
  self._id_016E = 1;
  self._id_00DA = 1;
  self._id_7D1A = 1;
  self._id_4DA3 = 1;
  self._id_5ECE = 1;
  self._id_0321 = 0;

  if(isDefined(self._id_0DDF)) {
    self._id_0DDF._id_4AC4 = 1;
  }

  var_0 = weaponclass(self._id_04F6);
  _id_8133("juggernaut");
  self _meth_87CF("juggernaut");
  var_1 = "casual_killer";

  if(var_0 == "mg") {
    var_1 = "casual_killer_lmg";
  }

  self _meth_87CB("casual_killer", var_1, 1);
  thread _id_3321();

  if(var_0 == "mg" || var_0 == "rifle" || var_0 == "smg") {
    thread _id_3320();
  }

  if(var_0 == "rifle" || var_0 == "smg") {
    self._id_03D2 = "full";
  }

  thread _id_331F();
}

_id_49E7() {
  if(!istrue(self._id_0272)) {
    thread _id_49E8();
  }
}

_id_49E8() {
  if(!isDefined(level._id_3322) || gettime() > level._id_3322) {
    self._id_02E4 = gettime() + 3000;
    self._id_02E2 = 1;
    self._id_5EB4 = 1;
  }

  self._id_0272 = 1;
  self _meth_807A();
  self._id_01BD = undefined;
  self._id_0212 = undefined;

  if(isDefined(self._id_0323)) {
    self _meth_84BC(2, self _meth_84A6(64));
  }

  scripts\engine\utility::waittill_any_2("leaveCasualKiller", "death");

  if(!isalive(self) || !isDefined(self)) {
    return;
  }
  self._id_00DD = 0;
  self._id_4DA8 = 0;
  self._id_0206 = self._id_37E6;

  if(istrue(self._id_37E4)) {
    self._id_002F = 1;
  }

  scripts\common\utility::_id_97EE(undefined);
  scripts\common\utility::_id_97F0(undefined);
  self._id_0230 = 0;
  self._id_4DA7 = 0;
  self._id_04A8 = 0.3;
  scripts\common\utility::_id_38ED();
  self._id_0168 = 0;
  self._id_0047 = 1;
  self._id_4DB6 = undefined;
  self._id_4A83 = undefined;
  self._id_A441 = undefined;
  self._id_016E = 0;
  self._id_00DA = 0;
  self._id_00DB = undefined;
  self._id_0321 = 192;
  self._id_0181 = 0;
  self._id_03D2 = undefined;
  self._id_7D1A = undefined;
  self._id_4DA3 = undefined;
  self._id_5ECE = 0;
  self._id_0212 = undefined;
  self._id_0036 = 0;
  self _meth_84C0(2);

  if(isDefined(self._id_37E7)) {
    self._id_37E7 delete();
  }

  if(isDefined(self._id_0DDF)) {
    self._id_0DDF._id_4AC4 = 0;
  }

  self _meth_800D("stand", "crouch", "prone");

  if(isDefined(self._id_37E5)) {
    self._id_010D = self._id_37E5;
    self._id_37E5 = undefined;
  } else
    self._id_010D = "cover";
}

_id_331E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    self notify("ck_player_attacked_me");
  }
}

_id_331F() {
  self endon("leaveCasualKiller");
  self endon("death");

  if(!isDefined(self._id_42C0)) {
    self._id_42C0 = [];
  }

  self._id_42C0[self._id_42C0.size] = ::_id_331E;
  self waittill("ck_player_attacked_me");
  self._id_01BD = undefined;
  self _meth_807A();
  self _meth_8390("axis");
}

_id_3321() {
  self endon("leaveCasualKiller");
  self endon("death");
  wait 1;
  self._id_37E7 = spawn("script_origin", self.origin);
  thread scripts\engine\utility::_id_472E(self._id_37E7);
  var_0 = undefined;
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    waitframe();

    if(!isDefined(self) || !isalive(self) || istrue(self._id_0272)) {
      return;
    }
    self._id_0212 = "disable";
    var_4 = anglesToForward(self.angles);
    var_5 = self _meth_884D();

    if(var_1) {
      if(!isalive(var_0)) {
        var_2 = gettime();
        self _meth_8314(self._id_37E7);
        self _meth_86DE();
        var_1 = 0;
        var_3 = undefined;
      } else
        self._id_37E7.origin = var_0.origin;
    }

    var_6 = int(gettime() / 50);

    if(self getentitynumber() % 4 != var_6 % 4) {
      if(isDefined(var_2) && var_2 + 3000 > gettime()) {
        var_7 = self._id_37E7.origin - self.origin;

        if(length(var_7) > 100) {
          var_7 = vectornormalize(var_7);
          var_8 = abs(_func_000B(_func_0002(clamp(vectordot(var_4, var_7), -1.0, 1.0))));

          if(var_8 > 30 && gettime() < var_2 + 1500) {
            continue;
          }
          if(var_8 < 90) {
            continue;
          }
        }
      }

      var_2 = undefined;

      if(!isDefined(var_3) || gettime() > var_3 + 3000) {
        self _meth_807A();
        self _meth_86DE();

        if(isalive(self._id_0192)) {
          if(var_1 && self._id_0192 == var_0) {
            var_9 = self._id_0192;
            var_10 = self._id_0192.origin - self.origin;
            var_10 = vectornormalize(var_10);
            var_11 = clamp(vectordot(var_4, var_10), -1.0, 1.0);
            var_12 = abs(_func_000B(_func_0002(var_11)));

            if(var_12 > 70) {
              var_13 = self _meth_84C2();

              if(isDefined(var_13)) {
                foreach(var_15 in var_13) {
                  var_7 = var_15.origin - self.origin;
                  var_7 = vectornormalize(var_7);
                  var_8 = abs(_func_000B(_func_0002(clamp(vectordot(var_4, var_7), -1.0, 1.0))));

                  if(var_8 < var_12) {
                    var_12 = var_8;
                    var_9 = var_15;
                  }
                }

                if(var_9 != self._id_0192) {
                  if(_func_011D(var_9)) {
                    self._id_01BD = var_9;
                    self _meth_86DE();
                    self._id_01BD = undefined;
                    var_3 = gettime();
                  }
                }
              }
            }
          }

          var_1 = isalive(self._id_0192);

          if(var_1) {
            var_0 = self._id_0192;
          } else {
            var_0 = undefined;
          }

          continue;
        } else {
          self _meth_8314(self._id_37E7);
          self _meth_86DE();

          if(isDefined(var_2) && var_2 + 7000 > gettime()) {
            if(vectordot(var_4, self._id_37E7.origin - var_5) > 0) {
              continue;
            }
          }

          self._id_37E7.origin = self.origin + (0, 0, 40) + var_4 * 400;
        }
      }
    }
  }
}

_id_3320() {
  self endon("leaveCasualKiller");
  self endon("death");
  var_0 = 100;
  var_1 = 1000;
  var_2 = 20;
  var_3 = -1;
  var_4 = [40, 50, 60];
  var_5 = [20, 25, 30];
  var_6 = 0;
  var_7 = 0;
  var_8 = scripts\engine\utility::random(var_4);
  var_9 = scripts\engine\utility::random(var_5);
  var_10 = 0;
  var_11 = undefined;
  var_12 = undefined;

  foreach(var_14 in var_5) {
    if(var_14 > var_6) {
      var_6 = var_14;
    }
  }

  while(isalive(self) && isDefined(self)) {
    waitframe();
    self._id_0275 = 90;
    self._id_0377 = -90;
    self._id_0036 = 180;
    var_16 = anglesToForward(self.angles);
    var_17 = self _meth_884D();

    if(isDefined(self._id_0192)) {
      if(!isDefined(self._id_0323) || self._id_0280 > self _meth_8644()) {
        var_11 = self._id_0192 _meth_8176();
      }
    }

    var_18 = _id_0009::_id_1C43(self._id_006C, "aim") || _id_0009::_id_1C43(self._id_006C, "notetrackAim");

    if(var_18) {
      var_18 = isDefined(var_11);
    }

    var_19 = _id_0009::_id_1C5F(self._id_1CB8);

    if(var_19 == "exposed_arrival" || var_19 == "exposed_reload") {
      var_18 = 0;
    }

    if(var_18) {
      var_20 = self _meth_84A6(self _meth_8644());
      var_21 = var_11 - var_20;
      var_21 = (var_21[0], var_21[1], 0);
      var_22 = vectornormalize(var_21);
      var_23 = self._id_0275;

      if(!istrue(var_12)) {
        var_23 = max(0, self._id_0275 - 20);
      }

      var_24 = abs(_func_000B(_func_0002(clamp(vectordot(var_22, var_16), -1.0, 1.0))));

      if(var_24 >= var_23) {
        var_11 = undefined;
        var_10 = 0;
        var_18 = 0;
      }
    }

    if(!istrue(var_18)) {
      scripts\common\utility::_id_97EE(undefined);
      scripts\common\utility::_id_97F0(var_17 + var_16 * 200);
      self._id_00DB = var_17 + var_16 * 200;
      var_2 = 20 * var_3;
      var_3 = var_3 * -1;
      var_10 = 0;
      self._id_0181 = 1;
      var_12 = 0;
      continue;
    }

    var_12 = 1;
    self._id_0181 = 0;

    if(isDefined(var_11)) {
      scripts\common\utility::_id_97F0(var_11);
    } else {
      scripts\common\utility::_id_97EE(undefined);
      scripts\common\utility::_id_97F0(undefined);
    }

    var_21 = var_11 - var_17;
    var_25 = length(var_21);
    var_22 = vectornormalize(var_21);
    var_24 = abs(_func_000B(_func_0002(clamp(vectordot(var_16, var_22), -1.0, 1.0))));
    var_26 = _func_0017(var_22, anglestoright(self.angles), anglestoup(self.angles));
    var_27 = var_26[1];

    if(istrue(self._id_0272)) {
      if(var_2 > 0) {
        var_2 = var_2 - min(var_2, var_8 * level._id_5F3A);
        var_3 = -1;
      } else if(var_2 < 0) {
        var_2 = var_2 + min(var_2 * -1, var_8 * level._id_5F3A);
        var_3 = 1;
      }
    } else if(var_24 + var_6 < abs(self._id_0275) && var_24 + var_6 < abs(self._id_0377) && var_25 > var_0 && (var_25 < var_1 || isDefined(self._id_0192) && self._id_0192 == level.player)) {
      if(gettime() > var_7) {
        var_28 = level._id_5F3A * var_8 * var_3;
        var_2 = var_2 + var_28;

        if(scripts\engine\utility::_id_DD3F(var_2) == scripts\engine\utility::_id_DD3F(var_3) && abs(var_2) > var_9) {
          var_3 = var_3 * -1;
          var_8 = scripts\engine\utility::random(var_4);
          var_9 = scripts\engine\utility::random(var_5);
          var_7 = gettime() + 350;
        }
      }

      var_27 = var_27 + var_2;
    }

    var_29 = _func_0017(var_22, anglestoright(self.angles), anglestoup(self.angles));
    var_29 = (var_29[0], var_27, var_29[2]);
    var_22 = anglesToForward(var_29);
    self._id_00DB = var_22 * var_25 + var_17;

    if(istrue(self._id_0272) && var_2 == 0) {
      return;
    }
  }
}