/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_br.gsc
*************************************************/

main() {
  if(scripts\mp\utility\game::_id_6D9E() == "dmz" && scripts\mp\gametypes\br_public::_id_8804()) {
    [[level._id_4BD2]]();
  } else {
    _id_D795();
    _id_D768();
  }
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_270D;
}

_id_D768() {
  setdvarifuninitialized("#x3b9adb39d14379d60", 0.25);
}

_id_270D() {
  self notify("bot_br_think");
  self endon("bot_br_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = randomfloat(1) < getdvarfloat("#x3b9adb39d14379d60", 0.0);
  thread _id_16D7();
  self _meth_8054("ignore_nodes", 1);

  for(;;) {
    if(scripts\mp\gametypes\br_public::_id_878D() && !_id_07D1::_id_60BE("graceperiod_done")) {
      self._id_0229 = 0;
      wait 0.05;
      continue;
    }

    if(isDefined(self._id_2A5E)) {
      if(scripts\mp\gametypes\br_public::_id_878D() && !isDefined(self._id_7E2A)) {
        self._id_0229 = 1;
        self _meth_802B();
      }

      self _meth_8054("disable_all_ai", 1);

      if((scripts\mp\gametypes\br_public::_id_898B() || var_0) && istrue(level._id_2E36)) {
        var_1 = level._id_29F4.origin;
        var_2 = vectornormalize(level._id_7E79._id_2E3A._id_5340 - var_1);
        var_3 = (level._id_2A73._id_2A78[0][0] - var_1[0]) / var_2[0];
        var_4 = (level._id_2A73._id_2A78[0][1] - var_1[0]) / var_2[0];
        var_5 = (level._id_2A73._id_2A78[0][1] - var_1[1]) / var_2[1];
        var_6 = (level._id_2A73._id_2A78[1][1] - var_1[1]) / var_2[1];
        var_7 = [var_3, var_4, var_5, var_6];
        var_8 = -1;

        foreach(var_10 in var_7) {
          if(var_10 > 0) {
            if(var_8 < 0 || var_10 < var_8) {
              var_8 = var_10;
            }
          }
        }

        var_12 = var_1 + var_2 * var_8;
        var_13 = scripts\mp\gametypes\br_c130::_id_6940();
        var_14 = var_8 / var_13;
        var_15 = randomfloatrange(0.1, 0.9) * var_14;
        wait(var_15);

        if(scripts\mp\gametypes\br_public::_id_898B()) {
          self notify("halo_jump_c130");
        } else {
          self notify("halo_jump_solo_c130");
        }

        self._id_7288 = 1;

        if(getdvarint("#x363df2f18e1089133", 1) > 0) {
          self._id_7288 = 0;
        }

        self._id_8C9F = 1;

        while(isDefined(self._id_2A5E)) {
          wait 0.05;
        }
      }

      wait 0.05;
      continue;
    }

    if(scripts\mp\gametypes\br_public::_id_8991()) {
      thread _id_27E4();
      scripts\engine\utility::waittill_any_2("death_or_disconnect", "gulag_end");
      wait 3;
    } else
      self _meth_802A();

    if(isDefined(level._id_2A1B) && _func_03DC()) {
      var_16 = undefined;
      var_17 = self _meth_8042();

      if(var_17) {
        var_16 = self _meth_803B();
      }

      if(!_id_09F9::_id_27ED() && !scripts\mp\bots\bots_util::_id_280F()) {
        if((istrue(self isskydiving()) || istrue(self _meth_86B8())) && istrue(self._id_8C9F) && istrue(scripts\mp\gametypes\br_public::_id_878D())) {
          self _meth_8054("disable_all_ai", 0);
          self _meth_802B();
          _id_2879();
        }

        if(scripts\mp\gametypes\br_public::_id_878D() && !isDefined(self._id_7E2A)) {
          self._id_0229 = 1;
          wait 1;
          continue;
        }

        var_18 = self _meth_86E8();
        var_19 = !var_17 || !var_18 || !scripts\mp\gametypes\br_circle::_id_89B5(var_16);

        if(var_17) {
          var_20 = distancesquared(self.origin, var_16);
          var_21 = self _meth_803D();
          var_22 = var_20 < var_21 * var_21;

          if(!var_22) {
            self._id_90AA = undefined;
          } else if(!isDefined(self._id_90AA)) {
            self._id_90AA = gettime();
          }
        }

        var_23 = level._id_2884[self._id_B023] == "stationary";

        if(isDefined(self._id_90AA)) {
          var_24 = 0;

          if(var_23) {
            var_24 = 20000;
          }

          var_19 = var_19 || gettime() - self._id_90AA >= var_24;
        }

        if(var_19) {
          var_25 = scripts\mp\gametypes\br_circle::_id_6CCB();
          var_26 = self _meth_86F8(var_25);

          if(isDefined(var_26)) {
            self _meth_8058(var_26, 1024, "hunt", undefined, undefined, !var_23);
            self._id_90AA = gettime();
          }
        }
      }
    } else
      _id_09F7::_id_FBA9();

    wait 0.05;
  }
}

_id_2879() {
  self endon("death_or_disconnect");
  self._id_0229 = 1;
  self._id_4816 = _id_27C6();
  var_0 = gettime() + randomfloatrange(5, 10) * 1000;
  var_1 = 0;

  while(istrue(self isskydiving()) || istrue(self _meth_86B8())) {
    if(level._id_2A1B._id_372F > 0 && istrue(level._id_3727) && !scripts\mp\gametypes\br_circle::_id_89B5(self._id_4816)) {
      self._id_4816 = _id_27C6();
    }

    var_2 = _id_27B7(self, self._id_4816);
    var_3 = 1;
    self _meth_8045(self._id_4816, 0.05, "script_forced");
    self _meth_805A(var_2[1], 0.05, var_3);

    if(gettime() > var_0 && !var_1) {
      self _meth_804E("jump", 1);
      var_1 = 1;
    }

    wait 0.05;
  }

  self._id_7E2A = 1;
  self _meth_8045(undefined);
  self._id_0229 = 0;
  _id_27DC();
}

_id_27C6(var_0) {
  if(!isDefined(level._id_5F47) || level._id_5F47.size < 1) {
    level._id_5F47 = _id_6538();
    level._id_5F47 = scripts\engine\utility::array_randomize(level._id_5F47);
  }

  if(isDefined(level._id_2A1B) && _func_03DC()) {
    var_1 = scripts\engine\utility::random(level._id_5F47);

    if(isDefined(var_1)) {
      var_2 = var_1.origin;
      level._id_5F47 = scripts\engine\utility::array_remove(level._id_5F47, var_1);
    } else
      var_2 = scripts\mp\gametypes\br_circle::_id_6CCB();

    return _func_02AB(var_2, self);
  }

  return undefined;
}

_id_6538() {
  var_0 = scripts\mp\gametypes\br_circle::_id_69C6();
  var_1 = scripts\mp\gametypes\br_circle::_id_69C5();
  return scripts\engine\utility::_id_6369(var_1, level._id_282D, undefined, undefined, var_0);
}

_id_27B7(var_0, var_1) {
  var_2 = vectornormalize(var_1 - var_0.origin);
  return vectortoangles(var_2);
}

_id_27BB(var_0, var_1) {
  return distance(var_0.origin, var_1);
}

_id_27DB() {
  if(!isDefined(level._id_26FD)) {
    level._id_26FD = [];
  }

  var_0 = scripts\engine\utility::random(level._id_26FD);

  switch (var_0) {
    default:
      break;
  }

  var_1 = [[level._id_5D69]]([[level._id_5D91]](var_0), [], "none", "none", -1);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponclipsize(var_1));
  self switchtoweapon("none");
}

_id_27DC() {
  self switchtoweapon("none");
  var_0 = _id_6446();

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = _id_6CCC();
  }

  var_0._id_37F0 = 1;
  var_1 = level._id_2884[self._id_B023] == "stationary";
  self _meth_8058(self _meth_86F8(var_0.origin), 256, "guard", undefined, undefined, !var_1);
  scripts\engine\utility::waittill_any_2("goal", "last_stand_start");
  var_0._id_37F0 = undefined;

  if(!istrue(self.inlaststand)) {
    _id_27DB();
  }

  _id_270C();
}

_id_6446() {
  var_0 = _id_6447();
  var_0 = _func_0204(var_0, self.origin);
  var_1 = _id_63F9(var_0);

  if(!isDefined(var_1)) {
    var_1 = _id_63D6(var_0);
  }

  return var_1;
}

_id_6447() {
  var_0 = scripts\mp\gametypes\br_circle::_id_69C6();
  var_1 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_2 = scripts\engine\utility::_id_6369(var_1, level._id_2772, undefined, undefined, var_0);
  return var_2;
}

_id_63F9(var_0) {
  foreach(var_2 in var_0) {
    if(!istrue(var_2._id_37F0)) {
      return var_2;
    }
  }

  return undefined;
}

_id_63D6(var_0) {
  return scripts\engine\utility::_id_6969(self.origin, var_0);
}

_id_4F06() {
  self endon("death_or_disconnect");

  for(;;) {
    wait 0.05;
  }
}

_id_270C() {
  var_0 = level._id_2884[self._id_B023] == "stationary";
  var_1 = 0;

  for(;;) {
    var_2 = _id_6CC8();
    var_1 = _id_2808() || istrue(level._id_3727);

    if(var_1) {
      var_2 = _id_6CCC();
    }

    if(isDefined(var_2)) {
      var_3 = _id_27CC();

      if(istrue(level._id_294B) && isDefined(var_3) && !var_1) {
        thread _id_FBAD();
        self _meth_812E(var_3);

        if(self _meth_803A() != "run_and_gun") {
          scripts\mp\bots\bots_util::_id_28C8("run_and_gun");
        }

        if(self _meth_8042()) {
          self _meth_802B();
        }

        if(!isDefined(self._id_B438)) {
          self _meth_8057(var_3);
          self._id_B438 = var_3;
        }
      } else {
        self._id_B438 = undefined;
        self notify("update_on_death");

        if(self _meth_8042()) {
          self _meth_802B();
        }

        self _meth_802A();

        if(var_1) {
          self _meth_8058(var_2, 128, "critical", undefined, undefined, 0);
        } else {
          self _meth_8058(var_2, 400, "guard", undefined, undefined, 0);
        }

        if(istrue(var_1)) {
          var_1 = 0;
        }

        thread _id_AED2();
        var_4 = scripts\engine\utility::_id_1088C(self, "goal", self, "bad path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout");

        if(isDefined(var_4) && (var_4 != "bad path" && var_4 != "br_circle_started" && var_4 != "path_timeout" && var_4 != "last_stand_start")) {
          var_5 = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < var_5) {
            if(_id_2808()) {
              self._id_B438 = undefined;
              self notify("update_on_death");
              break;
            }

            wait 0.1;
          }
        }
      }
    }

    wait 1;
  }
}

_id_AED2() {
  self endon("last_stand_start");
  level endon("game_ended");
  self endon("goal");
  self endon("bad path");
  level endon("br_circle_started");
  wait 15;
  self notify("path_timeout");
}

_id_27E4() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  var_0 = level._id_2884[self._id_B023] == "stationary";
  self._id_B438 = undefined;
  self.ignoreme = 1;
  self._id_0229 = 1;
  self _meth_802B();

  while(!istrue(self._id_7263)) {
    wait 1;
  }

  self.ignoreme = 0;
  self._id_0229 = 0;
  scripts\mp\bots\bots_util::_id_28C8("run_and_gun");

  for(;;) {
    var_1 = self._id_1A5C;

    foreach(var_3 in var_1._id_1ABE) {
      if(var_3 == self) {
        continue;
      }
      if(istrue(var_1._id_AD6F) && isDefined(var_1._id_4D0D) && isDefined(var_1._id_4D0D._id_1AA6) && isDefined(var_1._id_4D0D._id_1AA6._id_5C3F)) {
        self _meth_8058(var_1._id_4D0D._id_1AA6._id_5C3F.origin, 64, "objective");
        self _meth_802A();
        continue;
      }

      self _meth_812E(var_3);
      self _meth_8058(self _meth_86F8(var_3.origin), 256, "guard");
      self _meth_8057(var_3);
    }

    wait 3;
  }
}

_id_16D7() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getweaponslistprimaries();

    if(var_0.size == 1 && var_0[0].basename == "s4_me_fists_mp") {
      wait 1;
      continue;
    }

    foreach(var_2 in var_0) {
      if(self getweaponammostock(var_2) < weaponclipsize(var_2)) {
        self setweaponammostock(var_2, weaponclipsize(var_2));
      }
    }

    wait 0.1;
  }
}

_id_27CC() {
  if(isDefined(level._id_B439) && gettime() <= level._id_B439) {
    return undefined;
  }

  var_0 = _id_6670();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0;
}

_id_294E() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2)) {
      continue;
    }
    if(var_2 _id_27EB()) {
      var_0++;
    }
  }

  return var_0;
}

_id_27EB() {
  return isDefined(self._id_B438);
}

_id_6670() {
  var_0 = _id_6660();
  var_1 = _func_0219(3000);

  if(istrue(self.inlaststand) || scripts\mp\gametypes\br_public::_id_8991()) {
    return undefined;
  }

  if(!isDefined(var_0) || istrue(var_0.inlaststand) || !isalive(var_0) || var_0 scripts\mp\gametypes\br_public::_id_8991()) {
    return undefined;
  }

  if(_id_2808()) {
    return undefined;
  }

  var_2 = _id_6321();

  if(var_2 >= 3) {
    if(distancesquared(var_0.origin, self.origin) > var_1) {
      return undefined;
    }

    var_3 = _id_294E();

    if(_id_27EB()) {
      return var_0;
    }

    if(var_3 >= 1) {
      return undefined;
    }

    return var_0;
  } else
    return var_0;
}

_id_6660() {
  foreach(var_1 in level.players) {
    if(!isbot(var_1)) {
      return var_1;
    }
  }
}

_id_FBAD() {
  self notify("update_on_death");
  self endon("update_on_death");
  scripts\engine\utility::waittill_any_3("death", "death_or_disconnect", "last_stand_start");
  self._id_B438 = undefined;
  level._id_B439 = gettime() + 7;
}

_id_2808() {
  var_0 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_1 = scripts\mp\gametypes\br_circle::_id_69C6();

  if(istrue(level._id_3727)) {
    var_0 = scripts\mp\gametypes\br_circle::_id_6D02();
    var_1 = scripts\mp\gametypes\br_circle::_id_6D03();
  }

  if(scripts\mp\gametypes\br_public::_id_8991()) {
    return 0;
  }

  if(!isalive(self) || self.sessionstate != "playing") {
    return 0;
  }

  return !scripts\engine\utility::_id_89BA(self.origin, var_0, var_1);
}

_id_6CC9(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::_id_6CCB();

  if(!isDefined(var_0)) {
    var_0 = 1000;
  }

  if(distance2d(self.origin, var_1) > var_0) {
    var_2 = vectortoangles(var_1 - self.origin);
    var_3 = anglesToForward(var_2);
    var_1 = self.origin + var_3 * var_0;
  }

  return self _meth_86F8(var_1);
}

_id_6CCC() {
  var_0 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_1 = scripts\mp\gametypes\br_circle::_id_6D03();
  var_2 = scripts\mp\gametypes\br_circle::_id_6CC7(var_0, var_1, 0.75, 0.9, 1, 1);
  return self _meth_86F8(var_2);
}

_id_6CC8() {
  var_0 = gettime() + 5000;

  while(gettime() < var_0) {
    var_1 = scripts\mp\gametypes\br_circle::_id_6CC7(self.origin, 750, 0.6, 1, 1, 1);
    var_2 = self _meth_86F8(var_1);

    if(_id_89B4(var_2)) {
      return var_2;
    }

    wait 0.05;
  }

  var_3 = scripts\mp\gametypes\br_circle::_id_6CCB();
  return self _meth_86F8(var_3);
}

_id_89B4(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_2 = scripts\mp\gametypes\br_circle::_id_69C6();
  return scripts\engine\utility::_id_89BA(var_0, var_1, var_2);
}

_id_6321() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) || !isalive(var_2) || var_2.sessionstate != "playing") {
      continue;
    }
    var_0++;
  }

  return var_0;
}

_id_2930(var_0) {
  var_1 = level._id_EF6A[var_0.team]["alivePlayers"];

  if(scripts\engine\utility::array_contains(var_1, self)) {
    return 1;
  }

  return 0;
}