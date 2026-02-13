/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2299.gsc
*************************************************/

_id_87AB(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_9D39) && isDefined(self._id_9D39._id_2B75);
}

_id_B88A(var_0) {
  self endon(var_0 + "_finished");
  var_1 = 4900;
  var_2 = _id_06BD::_id_23C0();

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distancesquared(self.origin, var_2.origin);

    if(var_3 <= var_1) {
      if(isDefined(self._id_9D39)) {
        self._id_9D39._id_2B75 = 1;
      }

      break;
    }

    wait 0.05;
  }
}

_id_4D63(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_1, var_3);

    if(!_func_0107(var_3)) {
      var_3 = [var_3];
    }

    foreach(var_5 in var_3) {
      var_6 = _id_7477(var_0, var_1, var_5);

      if(istrue(var_6)) {
        return;
      }
      if(isDefined(var_2)) {
        self[[var_2]](var_5, var_1);
      }
    }
  }
}

_id_7477(var_0, var_1, var_2) {
  switch (var_2) {
    case "end":
      return 1;
    case "stop":
      var_3 = _id_06BD::_id_23C0();

      if(!isDefined(var_3)) {
        return 1;
      }

      if(!isalive(var_3)) {
        return 1;
      }

      if(!isDefined(self._id_0192) || self._id_0192 != var_3) {
        return 1;
      }

      var_4 = distancesquared(var_3.origin, self.origin);
      var_5 = 4096;

      if(isDefined(self._id_9DA7)) {
        var_5 = self._id_9DA7;
      }

      if(var_4 > var_5) {
        return 1;
      }

      break;
    case "fire":
      var_3 = _id_06BD::_id_23C0();

      if(!isDefined(var_3)) {
        return 1;
      }

      if(isalive(var_3)) {
        if(isPlayer(var_3)) {
          if(isDefined(self._id_9D8D)) {
            var_6 = distance2dsquared(var_3.origin, self.origin);
          } else {
            var_6 = distancesquared(var_3.origin, self.origin);
          }

          var_7 = 4096;

          if(isDefined(self._id_9D6C)) {
            var_7 = self._id_9D6C;
          }

          if(var_6 <= var_7) {
            var_8 = self._id_9D7F;
            var_9 = undefined;
            var_10 = undefined;
            var_11 = 20;
            var_12 = 0.45;
            var_13 = 0.35;
            var_14 = isDefined(var_3._id_A951) && var_3._id_A951._id_0026;

            if(isnullweapon(self._id_04F6)) {
              var_8 = self._id_F930;
            }

            if(var_14) {
              var_11 = 10;
              var_12 = 0.7;
              var_13 = 0.5;
              setsaveddvar("#x3734c3eb0f7c67a04", 0.05);
            }

            var_15 = self _meth_822E(undefined, var_8, _func_0218(var_7), var_9, var_10);

            if(isDefined(var_15)) {
              if(var_14 && (self._id_04B9 == "soldier" || self._id_04B9 == "juggernaut")) {
                self playSound("ai_melee_vs_shield");
              }

              var_3 _id_B4E9(self.origin, var_11);
              var_3 earthquakeforplayer(0.45, 0.35, var_3.origin, 1000);
              var_3 playrumbleonentity("damage_heavy");

              if(!var_14) {
                var_3 _meth_844C(30, self.origin);
              }
            } else {
              self._id_A4B0 = gettime() + randomintrange(3000, 5000);
              self._id_8FD2 = var_3;
            }

            if(var_14) {
              setsaveddvar("#x3734c3eb0f7c67a04", level._id_B719);
            }
          } else {
            self._id_A4B0 = gettime() + randomintrange(3000, 5000);
            self._id_8FD2 = var_3;
          }
        } else
          self _meth_822E();
      }

      break;
    default:
      scripts\anim\notetracks::_id_7476(var_2, var_1);
  }
}

_id_B4E9(var_0, var_1) {
  if(!self isonground()) {
    var_1 = var_1 * 0.1;
  }

  var_2 = vectornormalize(self.origin + (0, 0, 45) - var_0);
  var_3 = var_2 * var_1 * 10;
  self setvelocity(var_3);
}

_id_9D42() {
  var_0 = self._id_9D39.target;

  if(isDefined(self._id_9D68)) {
    self._id_9D39._id_10E53 = 1;
    var_0._id_9D39._id_10E53 = 0;
    return;
  } else if(isDefined(var_0._id_9D68)) {
    self._id_9D39._id_10E53 = 0;
    var_0._id_9D39._id_10E53 = 1;
    return;
  }

  if(isDefined(self._id_992D)) {
    self._id_9D39._id_10E53 = 1;
    var_0._id_9D39._id_10E53 = 0;
  } else if(isDefined(var_0._id_992D)) {
    self._id_9D39._id_10E53 = 0;
    var_0._id_9D39._id_10E53 = 1;
  } else {
    self._id_9D39._id_10E53 = scripts\engine\utility::cointoss();
    var_0._id_9D39._id_10E53 = !self._id_9D39._id_10E53;
  }
}

_id_9D3C() {
  var_0 = self._id_9D39.target;
  var_1 = self.origin - var_0.origin;
  var_2 = _func_0261(var_1);
  var_3 = _func_000B(var_2 - var_0.angles[1]);

  if(-45 < var_3 && var_3 < 45) {
    return "8";
  } else if(var_3 > 135 || var_3 < -135) {
    return "2";
  } else if(var_3 > 45) {
    return "4";
  }

  return "6";
}

_id_9D57(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9D39)) {
    return 1;
  }

  if(isDefined(self._id_9D39._id_2059)) {
    return 1;
  }

  if(!isDefined(self._id_9D39.target)) {
    return 1;
  }

  if(!isalive(self._id_9D39.target)) {
    return 1;
  }

  if(istrue(self._id_9D39.target._id_4DA7)) {
    return 1;
  }

  return 0;
}

_id_9D56(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9D39)) {
    return 1;
  }

  if(isDefined(self._id_9D39._id_2059)) {
    if(isDefined(self._id_9D39._id_2DEC)) {
      if(self._id_9D39._id_2DEC) {
        var_4 = _id_0009::_id_1C50(var_0, "melee_stop");

        if(var_4) {
          self._id_9D39._id_2C53 = 1;
        }

        return var_4;
      }
    } else if(isDefined(self._id_9D39._id_E944)) {
      var_5 = _id_0009::_id_1C50(var_0, "melee_stop");

      if(!var_5) {
        self._id_9D39._id_2DEC = 1;
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_9D4F(var_0, var_1, var_2) {
  self._id_9D39._id_242D = 1;
  self._id_9D39._id_9D69 = var_0;
  self._id_9D39._id_1C07 = var_1;
  self._id_9D39._id_243A = var_2;
}

_id_9D3E(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_9D39._id_242D) && self._id_9D39._id_242D;
}

_id_9D3D() {
  self._id_9D39._id_242D = undefined;
}

_id_9D4D(var_0, var_1, var_2, var_3) {
  if(self._id_9D39._id_10E53 != var_3) {
    return 0;
  }

  return !_id_9D3E();
}

_id_3173(var_0, var_1, var_2, var_3) {}

_id_35BD(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_9D6A);
}

_id_567C(var_0, var_1) {
  var_2 = self._id_9D39.target;
  var_3 = var_2.angles;
  var_4 = var_2.origin - self.origin;
  var_5 = _func_0261(var_4);
  var_6 = 30;
  var_7 = _func_000B(var_5 - self.angles[1]);

  if(abs(var_7) > var_6) {
    return 0;
  }

  if(var_1) {
    var_3 = var_2.angles - (0, var_7 * 0.5, 0);
    var_8 = getstartorigin(var_2.origin, var_3, var_0);
  } else {
    var_3 = var_2.angles - (0, var_7, 0);
    var_8 = getstartorigin(var_2.origin, var_3, var_0);
  }

  var_9 = self.origin - var_8;
  var_10 = vectornormalize(var_2.origin - var_8);
  var_11 = vectordot(var_10, var_9);

  if(var_11 > 12 || var_11 < -12) {
    return 0;
  }

  if(var_1) {
    self._id_9D39._id_E67A = self.angles + (0, var_7 * 0.5, 0);
    self._id_9D39._id_0405 = var_8;
    var_2._id_9D39._id_E73F = var_3[1];
  } else {
    self._id_9D39._id_0405 = var_8;
    self._id_9D39._id_E67A = _func_00D2(var_2.origin, var_3, var_0);
    var_2._id_9D39._id_E73F = var_3[1];
  }

  var_2._id_9D39._id_2DE9 = 1;
  return 1;
}

_id_567B(var_0, var_1, var_2, var_3) {
  var_4 = self._id_9D39.target;

  if(isPlayer(var_4)) {
    return 0;
  }

  if(istrue(self._id_4DB6) || istrue(var_4._id_4DB6)) {
    return 0;
  }

  if(weaponclass(self._id_04F6) == "pistol" || weaponclass(var_4._id_04F6) == "pistol") {
    return 0;
  }

  if(!isDefined(self._id_9D39._id_10E53) || !isDefined(var_4._id_9D39._id_10E53)) {
    _id_9D42();
  }

  var_5 = var_3[0];

  if(self._id_9D39._id_10E53 != var_5) {
    return 0;
  }

  var_6 = var_3[1];
  var_7 = _id_9D3C();
  var_8 = ["a"];

  if(var_7 == "8") {
    var_8 = ["a", "b", "c"];
    var_9 = 3;
    var_10 = randomint(var_9);
    var_11 = randomint(var_9);
    var_12 = var_8[var_10];
    var_8[var_10] = var_8[var_11];
    var_8[var_11] = var_12;
  }

  var_9 = var_8.size;

  for(var_13 = 0; var_13 < var_9; var_13++) {
    var_14 = var_7 + var_8[var_13];
    var_15 = _id_0009::_id_1C7D(var_2, var_14);
    var_16 = _id_0009::_id_1C6E(var_2, var_15);

    if(_id_567C(var_16, var_6)) {
      self._id_9D6A = var_14;
      var_4._id_9D6A = var_14;
      return 1;
    }
  }

  return 0;
}

_id_317A(var_0, var_1, var_2, var_3) {}

_id_317B(var_0, var_1, var_2, var_3) {}

_id_317C(var_0, var_1, var_2, var_3) {}

_id_317D(var_0, var_1, var_2, var_3) {}

_id_3178(var_0, var_1, var_2, var_3) {}

_id_3179(var_0, var_1, var_2, var_3) {}

_id_3177(var_0) {
  var_1 = self._id_9D39.target;
  var_2 = var_1.origin;
  var_3 = self.origin - var_2;
  var_4 = vectortoangles(var_3);
  var_5 = getstartorigin(var_2, var_4, var_0);
  self._id_9D39._id_0405 = var_5;
  self._id_9D39._id_E67A = _func_00D2(var_2, var_4, var_0);
  var_1._id_9D39._id_E73F = var_4[1];
  return 1;
}

_id_3176(var_0) {}

_id_9D5F(var_0, var_1, var_2) {}

_id_10817(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 waittill("entitydeleted");
  self notify("melee_exit");
}

_id_B892(var_0, var_1) {
  self endon(var_1 + "_finished");
  childthread _id_10817(var_1, self._id_9D39._id_AE83);
  self waittill("melee_exit");
  self unlink();
  var_2 = _id_0009::_id_1C50(var_0, "melee_interact");

  if(isDefined(self._id_9D39._id_83B9) && !var_2) {
    self._id_9D39._id_EBD0 = 1;
  } else if(var_2 && !_id_0009::_id_1C50(var_0, "melee_death")) {
    if(isDefined(self._id_9D39._id_834E)) {
      self._id_9D39._id_EBD0 = !_id_0009::_id_1C50(var_0, "drop");
    } else {
      self._id_9D39._id_EBD0 = 0;
    }
  }

  if(!self._id_9D39._id_10E53) {
    if(istrue(self._id_9D39._id_EBD0)) {
      self._id_9D39._id_2059 = 1;
      self._id_9D39._id_2DEC = 0;
    } else if(_id_0009::_id_1C50(var_0, "melee_no_recovery"))
      self._id_9D39._id_21AB = 1;
    else if(_id_0009::_id_1C50(var_0, "melee_stop")) {
      self _meth_81FA();
    } else if(isDefined(self._id_9D39._id_E944)) {
      self._id_9D39._id_2059 = 1;
    } else {
      self._id_9D39._id_21AB = 1;
    }
  } else if(_id_0009::_id_1C50(var_0, "fire"))
    self._id_9D39._id_21AB = 1;
  else if(!isDefined(self._id_9D39._id_25BD)) {
    self._id_9D39._id_2059 = 1;
  }
}

_id_9D58(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_9D39._id_EBD0);
}

_id_9D59(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_9D39._id_2C53);
}

melee_rangecheck(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9D39)) {
    return 0;
  }

  if(!isDefined(self._id_9D39.target)) {
    return 0;
  }

  if(distancesquared(self.origin, self._id_9D39.target.origin) < _func_0219(float(var_3))) {
    return 1;
  }

  return 0;
}

_id_9D60(var_0) {
  self endon(var_0 + "_finished");
  self waittill("weapon_dropped", var_1);

  if(isDefined(var_1)) {
    self._id_9D39._id_504C = var_1;
  }
}

_id_9D49() {
  if(isDefined(self._id_9D39) && !istrue(self._id_9D39._id_2C53)) {
    self._id_9D6A = undefined;
  }

  self._id_9D39 = undefined;
  self._id_9DA6 = undefined;
  self._id_0426 = undefined;
}

_id_9D4A(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = _func_00D6(var_0, 3);
    self playSound(var_1);
    return;
  }

  switch (var_0) {
    case "sync":
      if(!isDefined(self._id_9D39._id_2059)) {
        if(isDefined(self._id_9D39.target)) {
          if(isalive(self._id_9D39.target)) {
            self _meth_820D(self._id_9D39.target, "tag_sync", 1, 1);
          }
        } else if(isDefined(self._id_9D39._id_2DE9) && isDefined(self._id_9D39._id_AE83)) {
          if(isalive(self._id_9D39._id_AE83)) {
            self _meth_820D(self._id_9D39._id_AE83, "tag_sync", 1, 1);
          }
        }
      }

      break;
    case "unsync":
      if(isDefined(self._id_9D39._id_5DCE)) {
        self[[self._id_9D39._id_5DCE]]();
      } else {
        self unlink();
      }

      break;
    case "melee_interact":
      self._id_9D39._id_EBD1 = 1;
      break;
    case "melee_death":
      return var_0;
    case "attach_knife":
      self attach("vm_fsierra_knife_00", "TAG_INHAND", 1);
      self._id_9D39._id_757B = 1;
      break;
    case "detach_knife":
      self detach("vm_fsierra_knife_00", "TAG_INHAND", 1);
      self._id_9D39._id_757B = undefined;
      break;
    case "stab":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;
    case "melee_stop":
      break;
  }
}

_id_B890(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  self._id_9D6A = undefined;
  _id_0009::_id_1C45(var_0, var_1, ::_id_9D4A);
}

_id_B88F(var_0, var_1, var_2) {
  if(isDefined(self._id_9D39) && isDefined(self._id_9D39._id_AE83)) {
    self._id_9D39._id_AE83 notify("melee_exit");
  }

  if(isalive(self) && isDefined(self._id_9D39)) {
    _id_9D45();
  }

  self unlink();

  if(self._id_04B9 == "c6") {
    self._id_735A = 1;
    self.ignoreme = 0;
  }

  _id_9D49();
}

_id_9D45() {
  if(!isnullweapon(self._id_04F6) && !isnullweapon(self._id_90C6)) {
    return;
  }
  if(_func_0376(self._id_9D39._id_04F6)) {
    return;
  }
  scripts\anim\shared::_id_5ED5(self._id_9D39._id_04F6, self._id_9D39._id_10DD5);

  if(isDefined(self._id_9D39._id_504C)) {
    self._id_9D39._id_504C delete();
    self._id_9D39._id_504C = undefined;
  }
}

_id_B891(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_9D39._id_2C5A = 1;
  self _meth_8019("zonly_physics");

  if(isDefined(self._id_9D39._id_E73F)) {
    self _meth_8251("face angle", self._id_9D39._id_E73F);
  } else if(isDefined(self._id_9D39._id_E67A)) {
    self _meth_8251("face angle", self._id_9D39._id_E67A[1]);
  } else {
    self _meth_8251("face current");
  }

  _id_9D5C(var_1, 0);
  thread _id_9D60(var_1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  var_5 = _func_00BB(var_4, "melee_stop");

  if(var_5.size > 0) {
    self._id_9D39._id_E944 = var_5;
  }

  var_6 = _func_00BB(var_4, "melee_interact");

  if(var_6.size > 0) {
    self._id_9D39._id_83B9 = var_6;
  }

  var_7 = _func_00BB(var_4, "drop");

  if(var_7.size > 0) {
    self._id_9D39._id_834E = var_7;
  }

  thread _id_B892(var_0, var_1);
  var_8 = _id_0009::_id_1C45(var_0, var_1, ::_id_9D4A);

  if((var_8 == "melee_death" || !self._id_9D39._id_10E53) && !isDefined(self._id_9D39._id_EBD0)) {
    self._id_0DDF._id_A567 = 0;

    if(isDefined(self._id_9D39._id_AE83) && isDefined(self._id_9D39._id_AE83._id_9D39)) {
      self._id_9D39._id_AE83._id_9D39._id_25BD = 1;
    }

    self _meth_81FA();
  }
}

_id_9D5C(var_0, var_1) {
  self._id_9DA6 = var_0;
  self._id_9D39._id_82D8 = 1;
  self._id_9D39._id_04F6 = self._id_04F6;
  self._id_9D39._id_10DD5 = scripts\anim\utility::_id_69B2();
  self._id_9D39._id_5DCE = ::_id_9D5E;

  if(var_1) {
    _id_06B3::_id_9D54(self._id_04B9);
    self._id_0426 = self._id_9D39.target;
  } else
    self._id_0426 = self._id_9D39._id_AE83;

  if(self._id_04B9 == "c6") {
    self._id_735A = 0;
    self.ignoreme = 1;
  }
}

_id_9D5E() {
  self unlink();

  if(isDefined(self._id_9D39._id_AE83)) {
    self._id_9D39._id_AE83 _meth_8019("zonly_physics");
    self._id_9D39._id_AE83 _meth_8251("face angle", self._id_9D39._id_AE83.angles[1]);
  }

  self _meth_8019("zonly_physics");
  self _meth_8251("face angle", self.angles[1]);
}

_id_B889(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread meleechargetargetimmunewatch(var_1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  thread _id_B88A(var_1);
  _id_0009::_id_1C45(var_0, var_1);
}

_id_B893(var_0, var_1, var_2) {
  _id_B894();
  thread meleechargetargetimmunewatch(var_1);

  if(var_0 == "dog") {
    thread scripts\sound\snd_dogs::play_dog_attack_sound();
  }

  var_3 = _id_06BD::_id_23C0();

  if(!isDefined(var_3)) {
    self _meth_8251("face current");
  } else if(var_3 == self._id_0192) {
    self _meth_8251("face enemy");
  } else {
    self _meth_8251("face point", var_3.origin);
  }

  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  _id_0009::_id_1C52(var_1, "begin");

  if(isDefined(var_2)) {
    self playSound(var_2);
  }

  var_5 = 1.0;

  if(isDefined(self._id_04B9) && self._id_04B9 == "juggernaut") {
    var_5 = 1.5;
  }

  self _meth_85ED(var_1, var_4, var_5);
  self endon(var_1 + "_finished");
  _id_4D63(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  _id_0009::_id_1C53(var_0, "end");
}

_id_B894() {
  if(!isDefined(self._id_0DDF._id_A4AE)) {
    self._id_0DDF._id_A4AE = 0;
  }

  if(isDefined(self._id_0192) && isPlayer(self._id_0192) || randomint(3) == 0) {
    if(gettime() > self._id_0DDF._id_A4AE) {
      if(isDefined(level._id_2359)) {
        scripts\anim\face::saybattlechatterdialogue("melee_attack");
      } else {
        scripts\anim\face::_id_CB6D("meleeattack");
      }

      self._id_0DDF._id_A4AE = gettime() + 8000;
    }
  }
}

_id_B896() {
  if(!isDefined(self._id_0DDF._id_A4AF)) {
    self._id_0DDF._id_A4AF = 0;
  }

  if(isDefined(self._id_0192) && isPlayer(self._id_0192) || randomint(3) == 0) {
    if(gettime() > self._id_0DDF._id_A4AF) {
      if(isDefined(level._id_2359)) {
        scripts\anim\face::saybattlechatterdialogue("melee_charge");
      } else {
        scripts\anim\face::_id_CB6D("meleecharge");
      }

      self._id_0DDF._id_A4AF = gettime() + 8000;
    }
  }
}

_id_B895(var_0, var_1, var_2) {
  _id_B896();
  thread _id_08F1::_id_10800(var_0, var_1, 1);
  thread meleechargetargetimmunewatch(var_1);
  _id_0009::_id_1C81(var_0, var_1, self._id_A246);
}

meleechargetargetimmunewatch(var_0) {
  self endon(var_0 + "_finished");
  thread meleechargetargetimmunereset(var_0);
  var_1 = 0;

  while(isDefined(self._id_9D39) && isDefined(self._id_9D39.target) && isDefined(self.meleechargeimmunedistsq)) {
    var_2 = gettime();
    self._id_02A6 = undefined;

    if(isPlayer(self._id_9D39.target) && self._id_9D39.target _meth_81E6()) {
      var_1 = var_2;
    }

    var_3 = 0;

    if(isDefined(self.meleechargeimmunenext)) {
      var_3 = self.meleechargeimmunenext;
    }

    if(var_2 - var_1 > 250 && var_2 > var_3) {
      if(distancesquared(self._id_9D39.target.origin, self.origin) < self.meleechargeimmunedistsq) {
        var_4 = anglesToForward(self.angles);
        var_5 = self._id_9D39.target.origin - self.origin;
        var_5 = (var_5[0], var_5[1], self.origin[2]);

        if(vectordot(var_4, var_5) > 0) {
          self._id_02A6 = self._id_9D39.target;
        }
      }
    }

    waitframe();
  }

  self._id_02A6 = undefined;
}

meleechargetargetimmunereset(var_0) {
  self notify("MeleeChargeTargetImmuneReset");
  self endon("MeleeChargeTargetImmuneReset");
  self waittill(var_0 + "_finished");

  if(isDefined(self)) {
    if(var_0 == "melee_rusher_charge_attack") {
      self.meleechargeimmunenext = gettime() + 2000;
    }

    self._id_02A6 = undefined;
  }
}

_id_B88E(var_0, var_1, var_2) {
  self._id_9D39._id_2C5A = 1;
  var_3 = self._id_9D39.target;
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  _id_0009::_id_1C52("melee_attack", "begin");
  _id_9D5C(var_1, 1);
  var_6 = _func_00BB(var_5, "melee_stop");

  if(var_6.size > 0) {
    self._id_9D39._id_E944 = var_6;
  }

  var_7 = _func_00BB(var_5, "melee_interact");

  if(var_7.size > 0) {
    self._id_9D39._id_83B9 = var_7;
  }

  thread _id_9D60(var_1);
  var_3 _id_0009::_id_1CA1(var_1 + "_victim");
  self _meth_8019("zonly_physics");
  self _meth_8251("face angle", self._id_9D39._id_E67A[1]);
  self _meth_85ED(var_1, var_4);
  _id_0009::_id_1C8E(var_0, var_1, var_5);
  thread _id_B892(var_0, var_1);
  self endon(var_1 + "_finished");
  var_8 = _id_0009::_id_1C45(var_0, var_1, ::_id_9D4A);

  if((var_8 == "melee_death" || !self._id_9D39._id_10E53) && !istrue(self._id_9D39._id_EBD0)) {
    self._id_0DDF._id_A567 = 0;

    if(isDefined(self._id_9D39.target) && isDefined(self._id_9D39.target._id_9D39)) {
      self._id_9D39.target._id_9D39._id_25BD = 1;
    }

    self _meth_81FA();
  }
}