/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2276.gsc
*************************************************/

_id_4CBD(var_0) {
  self._id_01C2 = 0;
  self._id_010D = "no_cover";
  self._id_EAB8 = "dog";
  self._id_0B67._id_02D7 = "walk";
  self._id_02A3 = 384;
  self._id_02A4 = 384;
  self._id_9D74 = 1;

  if(scripts\common\utility::issp()) {
    self._id_F9A0 = 250000;
  }

  self._id_9D99 = 9216;
  self._id_F930 = 400;
  self._id_02A7 = 72;
  self._id_9DAA = 1;
  self._id_5D9D = ::_id_892B;
  self._id_5D6C = ::_id_3198;
  self._id_5DBF = ::_id_D6F1;
  self._id_5D9A = _id_06B9::_id_88B2;
  self._id_5D9C = _id_06B9::_id_88D8;
  self._id_5D99 = _id_06B9::_id_88AF;
  self._id_5D98 = _id_06B9::_id_87B6;
  self._id_5D9B = _id_06B9::_id_88B4;
  self._id_5DCA = _id_06B9::_id_FD81;
  self._id_DE2D = 589824;
  self._id_DE2C = 685584;
  self._id_226D = 409600;
  self._id_222C = 490000;
  self._id_3AB7 = 262144;
  thread listenforunreachablegoalandbadpath();
  thread monitornearplayers();
  thread scripts\sound\snd_dogs::init_dog_audio_flags();
  return anim._id_EACB;
}

listenforunreachablegoalandbadpath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::_id_108B4("unreachable_goal", "bad_path");
    setcantreachtargettime();
  }
}

setcantreachtargettime() {
  self._id_31FB = gettime();
  self notify("find_new_target");
}

monitornearplayers() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\common\utility::_id_B7B6(self.origin, 100);

    foreach(var_2 in var_0) {
      if(!_func_010E(var_2.team, self.team)) {
        continue;
      }
      var_3 = self.origin - var_2.origin;
      var_3 = (var_3[0], var_3[1], 0);

      if(vectordot(var_3, anglesToForward(var_2.angles)) > 0) {
        var_2 thread extendmeleeheightfortime(40, 0.1);
      }
    }

    waitframe();
  }
}

extendmeleeheightfortime(var_0, var_1) {
  self notify("extendMeleeHeightForTime");
  self endon("extendMeleeHeightForTime");
  self endon("death_or_disconnect");
  self._id_02A5 = var_0;
  wait(var_1);
  self._id_02A5 = 0;
}

_id_3198(var_0, var_1) {
  return self _meth_822C(var_0, var_1, 0, 1);
}

_id_FC57(var_0) {
  if(!isalive(self)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    self._id_5E7C = 0;
  }

  var_1 = scripts\engine\utility::is_equal(self._id_015B, "sprint") || isDefined(self._id_0192);

  if(var_1) {
    var_2 = "run";
  } else {
    var_2 = "walk";
  }

  if(var_2 != self._id_0B67._id_02D7) {
    self._id_0B67._id_02D7 = var_2;

    if(!isDefined(self._id_4CEE)) {
      if(var_1) {
        self _meth_85E2(262);
      } else {
        self _meth_85E2(55);
      }
    }
  }

  return anim._id_EACB;
}

_id_FC5D(var_0) {
  var_1 = level.player;

  switch (self._id_0408._id_2C56) {
    case 0:
      var_2 = distancesquared(var_1.origin, self.origin);

      if(var_2 < self._id_DE2D) {
        _id_D6F1("investigate");
      }

      break;
    case 1:
      var_2 = distancesquared(var_1.origin, self.origin);

      if(var_2 > self._id_DE2C) {
        if(!isDefined(self._id_0408._id_F14A) || self._id_0408._id_F14A) {
          _id_D6F1("idle");
        }
      } else if(var_2 < self._id_3AB7 && self _meth_8067(var_1))
        _id_D6F1("combat");

      break;
  }

  return anim._id_EACB;
}

_id_524D(var_0) {
  var_1 = ["bulletwhizby", "explode", "gunshot", "projectile_impact", "silenced_shot"];

  if(var_0) {
    foreach(var_3 in var_1) {
      self _meth_8000(var_3);
    }
  } else {
    foreach(var_3 in var_1) {
      self _meth_8297(var_3);
    }
  }
}

_id_4CBA() {
  _id_524D(1);
  self _meth_8079();
  _id_08AC::_id_D3A0("hidden");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1._id_0408)) {
      continue;
    }
    if(!isDefined(var_1._id_0408._id_E439)) {
      continue;
    }
    var_1._id_0408._id_E439[self._id_F94F] = undefined;
  }

  _id_08AD::_id_5696();
  thread _id_08AC::_id_D13D("reset");

  if(isDefined(self._id_0408._id_6035["hidden"])) {
    _id_08A8::_id_E79D("hidden");
  }

  if(isDefined(self.target)) {
    self._id_0201 = 32;

    if(isDefined(self._id_5DC7)) {
      self thread[[self._id_5DC7]](undefined, undefined, undefined);
    }
  }
}

_id_4CBB(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  self._id_0408._id_24FE = 0;
}

_id_4CB9(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];
  var_2 = level.player;
  var_3 = self _meth_8515(var_2);
  var_4 = 0.25;

  if(self._id_0408._id_24FE) {
    var_5 = 2000;

    if(gettime() > var_1._id_413C + var_5) {
      if(var_3 < var_4 * 0.9) {
        self._id_0408._id_24FE = 0;
        self._id_0408._id_7CCB = undefined;

        if(!isDefined(self._id_0323) && isDefined(var_1._id_7CCD)) {
          self._id_0B67._id_7CCD = var_1._id_7CCD;
        }
      }
    }
  } else if(var_3 >= var_4) {
    self._id_0408._id_24FE = 1;
    self._id_0408._id_7CCB = var_2;
    var_1._id_413C = gettime();
    var_1._id_7CCD = self._id_0B67._id_7CCD;
    self._id_0B67._id_7CCD = undefined;
  }

  self._id_0B67._id_02D7 = "walk";
  return anim._id_CA5F;
}

_id_4CBC(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0408._id_24FE = undefined;
  self._id_0408._id_7CCB = undefined;
}

_id_4CBF(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  self._id_0408._id_241D = 0;
  self._id_0408._id_24F2 = 0;
}

_id_4CBE(var_0) {
  var_1 = level.player;
  var_2 = distancesquared(self.origin, var_1.origin);

  if(var_2 < self._id_226D) {
    self._id_0408._id_241D = 1;
    self._id_0408._id_24F2 = 0;
  } else if(var_2 > self._id_222C) {
    self._id_0408._id_241D = 0;
    self._id_0408._id_24F2 = 1;
  }

  if(self._id_0408._id_241D || self._id_0408._id_24F2) {
    self._id_0B67.target = var_1;
  } else {
    self._id_0B67.target = undefined;
  }

  self._id_0B67._id_02D7 = "run";
  return anim._id_CA5F;
}

_id_4CC0(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0408._id_241D = undefined;
  self._id_0408._id_24F2 = undefined;
  self._id_0B67.target = undefined;
}

_id_892B(var_0, var_1) {
  if(!_id_06B3::_id_892C(var_0, var_1)) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_4CB7(var_0) {
  var_1 = spawnStruct();
  var_1._id_A4E5 = 0;
  self._id_2C5E._id_82FD[var_0] = var_1;
  thread scripts\sound\snd_dogs::try_play_dog_pursuit_sound();
}

_id_4CB6(var_0) {
  var_1 = self._id_0192;
  var_2 = isDefined(self._id_4CEE) && self._id_4CEE == "guard_dog";
  var_3 = !var_2;

  if(var_2) {
    if(isDefined(self._id_01BD)) {
      var_1 = self._id_01BD;
      var_3 = distancesquared(self.owner.origin, self._id_01BD.origin) < self._id_AD9F || distancesquared(self.origin, self._id_01BD.origin) < self._id_4CC7;
    } else
      var_3 = distancesquared(self.origin, var_1.origin) < self._id_1DF7;

    if(isDefined(self._id_31FB) && gettime() - self._id_31FB < 300 && isDefined(self.usedtarget) && self.usedtarget == var_1) {
      var_3 = 0;
      self _meth_84C0(1);
    }
  }

  if(var_3) {
    var_4 = self._id_2C5E._id_82FD[var_0];
    var_5 = gettime();

    if(var_5 >= var_4._id_A4E5 && !istrue(self._id_4DA7)) {
      var_4._id_A4E5 = var_5 + 500;
      var_6 = var_1.origin - self.origin;
      var_7 = _func_0135(var_6);

      if(var_7 <= 36864) {
        self._id_5E7C = 0;

        if(isDefined(self._id_F9A0) && var_7 < self._id_F9A0) {
          var_8 = isDefined(self._id_8FD2) && var_1 == self._id_8FD2 && gettime() <= self._id_A4B0;

          if(var_8) {
            self._id_5E7C = 1;
          }
        }
      } else {
        self.usedtarget = var_1;
        var_9 = isDefined(self._id_31FB) && isDefined(self._id_F9A0) && var_7 < self._id_F9A0;

        if(var_9) {
          if(gettime() - self._id_31FB > 300) {
            var_10 = _id_06E0::_id_68E7(var_1);
            var_11 = _id_06E0::_id_31A9(self.origin, var_10);

            if(var_11._id_31A8) {
              self._id_31FB = undefined;
              var_9 = 0;
            } else
              setcantreachtargettime();
          }
        }

        if(var_9) {
          self _meth_84C0(1);
          self _meth_8326(self.origin);
        } else {
          var_10 = _id_06E0::_id_68E7(var_1);

          if(scripts\common\utility::issp()) {
            var_10 = self _meth_86F8(var_10);
          }

          self _meth_84BC(1, var_10);
          self _meth_8600(1, 64);
        }

        if(isDefined(self._id_F9A0)) {
          self._id_5E7C = var_9;
        }
      }
    }

    if(isDefined(self._id_0408)) {
      if(!isDefined(self._id_0323)) {
        self._id_0408._id_241D = 1;
      } else {
        self._id_0408._id_241D = undefined;
      }
    }

    return anim._id_CA5F;
  }

  return anim._id_58E3;
}

_id_4CB8(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;

  if(!isDefined(self._id_0192)) {
    self _meth_84C0(1);
  }

  thread scripts\sound\snd_dogs::try_stop_dog_pursuit_sound();
}

_id_4CB5() {
  _id_524D(0);
  _id_08AD::_id_5696();
  _id_08AC::_id_D3A0("spotted");
}

_id_54E7(var_0) {
  _id_5794(self._id_0408._id_2C56);
  self._id_0408._id_2C56 = var_0;

  switch (var_0) {
    case 0:
      _id_4CBA();
      break;
    case 1:
      break;
    case 3:
      _id_4CB5();
      break;
  }
}

_id_5794(var_0) {
  switch (var_0) {
    case 0:
      break;
    case 1:
      break;
  }
}

_id_D6F1(var_0, var_1) {
  switch (var_0) {
    case "idle":
      _id_54E7(0);
      self notify("stealth_idle");
      break;
    case "investigate":
      _id_54E7(1);
      self notify("stealth_investigate");
      break;
    case "combat":
      _id_54E7(3);
      self notify("stealth_combat");
      break;
  }
}