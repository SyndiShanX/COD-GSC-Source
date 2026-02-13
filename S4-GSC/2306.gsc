/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2306.gsc
*************************************************/

_id_DBFA(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_2416()) {
    return 0;
  }

  if(isDefined(var_3) && isDefined(self._id_02ED) && isDefined(self._id_02ED.type) && self._id_02ED.type != var_3) {
    return 0;
  }

  var_4 = _id_06BD::_id_23CB();

  if(!isDefined(var_4) || !isDefined(self._id_0192) || var_4 != self._id_0192) {
    _id_0009::_id_1C52("throwgrenade", "end");
    return 0;
  }

  if(_id_06BA::_id_715D(var_4)) {
    var_5 = _id_0009::_id_1C5C(var_0, var_2);

    if(isDefined(var_5)) {
      var_6 = _id_6A7C(var_2, var_5);
      var_7 = self._id_BFFA;
      var_8 = distance(var_4.origin, self.origin);

      if(var_8 < 800) {
        if(var_8 < 256) {
          var_7 = 0;
        } else {
          var_7 = var_7 * ((var_8 - 256) / 544);
        }
      }

      var_9 = self _meth_8073(var_6, var_7, "min energy", "min time", "max time");
      self._id_0DDF._id_A4A4 = gettime() + randomintrange(1000, 2000);

      if(isDefined(var_9)) {
        var_10 = spawnStruct();
        var_10._id_10FD1 = var_5;
        var_10._id_10399 = var_9;
        var_10.target = var_4;
        var_10._id_74B8 = var_6;
        var_10._id_59C2 = 0;
        var_10._id_10E72 = _id_DB0D(self._id_020A);
        var_10._id_F1E8 = gettime();
        self._id_0B67._id_F18A = var_10;
        return 1;
      }
    }
  }

  _id_0009::_id_1C52("throwgrenade", "end");
  return 0;
}

_id_35BE(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _id_0009::_id_1C57(var_1, "exposed_grenade");

  if(_func_0107(var_4)) {
    var_5 = [];

    foreach(var_7 in var_4) {
      var_8 = _id_0009::_id_1C6E(var_1, var_7);
      var_9 = _func_00BB(var_8, "grenade_throw");

      if(var_9.size > 0) {
        var_10 = _func_00B0(var_8, 0, var_9[0]);
      } else {
        var_10 = _func_00B0(var_8);
      }

      var_10 = self _meth_8216(var_10);

      if(self _meth_822C(self.origin, var_10)) {
        var_5[var_5.size] = var_7;
      }
    }

    if(var_5.size > 0) {
      var_3 = var_5[randomint(var_5.size)];
    } else {
      return undefined;
    }
  } else
    var_3 = var_4;

  return var_3;
}

_id_B342(var_0, var_1, var_2) {
  var_3 = self._id_0B67._id_F18A;
  self._id_89C5 = 1;
  var_4 = _id_F747(var_0, var_1, var_3);

  if(!var_4) {
    self endon(var_1 + "_finished");
    wait 0.2;
    _id_0009::_id_1C53(var_0, "end");
  }
}

_id_B374(var_0, var_1, var_2) {
  if(isDefined(self._id_02ED)) {
    self._id_0260 = 1;
  }

  _id_B342(var_0, var_1, var_2);
}

_id_B375(var_0, var_1, var_2) {
  _id_08F4::_id_3931(var_0, var_1, var_2);
  _id_B343(var_0, var_1, var_2);
}

_id_B343(var_0, var_1, var_2) {
  self._id_0B67._id_F18A = undefined;
  _id_0009::_id_1C52("throwgrenade", "end");

  if(scripts\common\utility::issp() && isDefined(self._id_88A6)) {
    scripts\anim\combat_utility::_id_502F();
    self._id_88A6 = undefined;
  }

  self._id_89C5 = undefined;
}

_id_DB0D(var_0) {
  var_1 = var_0.basename;
  return var_1 != "antigrav" && var_1 != "emp" && var_1 != "c8_grenade";
}

_id_F747(var_0, var_1, var_2, var_3) {
  var_4 = var_2._id_4823;
  var_5 = var_2.target;
  var_6 = var_2._id_10E72;

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(isDefined(var_4)) {
    var_7 = _id_6A7C(var_1, var_2._id_10FD1);

    if(!isDefined(var_2._id_59C2)) {
      var_8 = self _meth_8074(var_7, var_4, var_6, "min energy", "min time", "max time");
    } else {
      var_8 = self _meth_8074(var_7, var_4, var_6, "min time", "min energy");
    }
  } else
    var_8 = var_2._id_10399;

  var_5 = var_2.target;

  if(isDefined(var_8)) {
    if(!isDefined(self._id_AA2F)) {
      self._id_AA2F = self._id_0207;
    }

    self._id_0207 = 0;
    var_9 = _id_69DB();
    _id_D57D(self._id_0F43, min(gettime() + 3000, var_9));
    var_10 = 0;

    if(_id_FF17()) {
      var_5._id_A788++;
      thread _id_C17B(var_1, var_5);

      if(var_5._id_A788 > 1) {
        var_10 = 1;
      }

      if(self._id_0F43._id_F25C == "fraggrenade") {
        if(var_5._id_A788 <= 1) {
          var_5._id_8FD7 = gettime();
        }
      }
    }

    if(isDefined(var_3)) {
      thread _id_4CCF(var_0, var_1, var_2._id_10FD1, var_8, var_9, var_10);
    } else {
      _id_4CCF(var_0, var_1, var_2._id_10FD1, var_8, var_9, var_10);
    }

    return 1;
  } else {}

  return 0;
}

_id_6A7C(var_0, var_1) {
  var_2 = (0, 0, 64);
  var_3 = self _meth_87CE();
  var_4 = 0;

  if(isDefined(anim._id_717F)) {
    if(!isDefined(anim._id_717F[var_3])) {
      var_3 = "soldier";
    }

    if(isDefined(anim._id_717F[var_3])) {
      if(isDefined(anim._id_717F[var_3][var_0])) {
        foreach(var_8, var_6 in anim._id_717F[var_3][var_0]) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            if(var_6[var_7] == var_1) {
              var_2 = anim._id_7182[var_3][var_0][var_8][var_7];
              var_4 = 1;
              break;
            }
          }

          if(var_4) {
            break;
          }
        }
      }
    }
  }

  return var_2;
}

_id_69DB() {
  var_0 = undefined;

  if(_id_FF17()) {
    var_1 = self._id_0F43.player;
    var_0 = gettime() + var_1._id_7235._id_B6C1 + randomint(var_1._id_7235._id_B6C2);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

_id_FF17() {
  return self._id_0F43._id_89A2;
}

_id_C17B(var_0, var_1) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(var_0 + "_finished");
  var_1._id_A788--;
}

_id_4CCF(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  _id_0009::_id_1C52("throwgrenade", "start");
  var_6 = _id_06BD::_id_23BC();

  if(!isDefined(var_6) || var_6.type == "Exposed" || var_6.type == "Path") {
    self _meth_8251("face direction", var_3);
  }

  var_7 = _id_0009::_id_1C5E();
  var_8 = _id_0009::_id_1C6E(var_1, var_2);
  _id_0009::_id_1C8E(var_0, var_1, var_8);
  self _meth_85ED(var_1, var_2, _id_59BD());
  thread _id_0009::_id_1C45(var_0, var_1);
  var_9 = scripts\anim\utility_common::_id_6A7B();
  var_10 = "none";
  var_11 = 0;

  while(!var_11) {
    self waittill(var_1, var_12);

    if(!_func_0107(var_12)) {
      var_12 = [var_12];
    }

    foreach(var_14 in var_12) {
      if(var_14 == "grenade_left" || var_14 == "grenade_right") {
        var_10 = _id_1D89(var_1, var_9, "tag_accessory_right");
        self._id_88A6 = 1;
      }

      if(var_14 == "grenade_throw" || var_14 == "grenade throw") {
        if(isDefined(self._id_18F3) && self._id_18F3 == "c6") {
          self playSound("c6_grenade_launch");
        }

        var_11 = 1;
        continue;
      }

      if(var_14 == "end") {
        if(isDefined(self._id_0F43) && isDefined(self._id_0F43.player) && isDefined(self._id_0F43.player._id_A788)) {
          self._id_0F43.player._id_A788--;
        }

        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(_id_FF17()) {
    thread _id_10B72(var_1, self._id_0F43.player, var_4);
  }

  var_22 = self _meth_840D();

  if(!_id_FF17()) {
    _id_D57D(self._id_0F43, var_4);
  }

  if(var_5 && self._id_0F43._id_89A2) {
    var_23 = self._id_0F43.player;

    if(var_23._id_A788 > 1 || gettime() - var_23._id_8FDD < 2000) {
      var_23._id_7184["double_grenade"] = gettime() + min(5000, var_23._id_7235._id_B69A);
    }
  }

  self notify("stop grenade check");

  if(var_10 != "none") {
    self detach(var_9, var_10);
  }

  self._id_88A6 = undefined;
  self._id_89C5 = undefined;
  self._id_0207 = self._id_AA2F;
  self._id_AA2F = undefined;
  self._id_F190 = undefined;

  if(isDefined(var_22)) {
    if(self.team == "axis") {
      level notify("enemy_grenade_fire", var_22);
    } else if(self.team == "allies") {
      level notify("ally_grenade_fire", var_22);
    }
  }

  self waittillmatch(var_1, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

_id_F18D(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_2416()) {
    if(_id_0009::_id_1C50(var_0, "grenade_throw") || _id_0009::_id_1C50(var_0, "grenade throw")) {
      return 0;
    }

    if(_id_0009::_id_1C50(var_0, "grenade_right") || _id_0009::_id_1C50(var_0, "grenade_left")) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_59BD() {
  return 1.5;
}

_id_1D89(var_0, var_1, var_2) {
  self attach(var_1, var_2);
  thread _id_488C(var_0, var_1, var_2);
  return var_2;
}

_id_1096B(var_0) {
  self endon(var_0 + "_finished");
  self waittill("killanimscript");
}

_id_488C(var_0, var_1, var_2) {
  self endon("stop grenade check");
  _id_1096B(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_AA2F)) {
    self._id_0207 = self._id_AA2F;
    self._id_AA2F = undefined;
  }

  self detach(var_1, var_2);
}

_id_10B72(var_0, var_1, var_2) {
  var_1 endon("death");
  _id_10B73(var_0, var_2);
  var_1._id_A788--;
}

_id_10B73(var_0, var_1) {
  var_2 = self._id_0F43;
  var_3 = spawnStruct();
  var_3 thread _id_10B74(5);
  var_3 endon("watchGrenadeTowardsPlayerTimeout");
  var_4 = self._id_020A.basename;
  var_5 = _id_6A7A(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  _id_D57D(var_2, min(gettime() + 5000, var_1));
  var_6 = 62500;
  var_7 = 160000;

  if(var_4 == "flash_grenade") {
    var_6 = 810000;
    var_7 = 1690000;
  }

  var_8 = level.players;
  var_9 = var_5.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_5)) {
      break;
    }

    if(distancesquared(var_5.origin, var_9) < 400) {
      var_10 = [];

      for(var_11 = 0; var_11 < var_8.size; var_11++) {
        var_12 = var_8[var_11];
        var_13 = distancesquared(var_5.origin, var_12.origin);

        if(var_13 < var_6) {
          var_12 _id_716A(var_2, var_1);
          continue;
        }

        if(var_13 < var_7) {
          var_10[var_10.size] = var_12;
        }
      }

      var_8 = var_10;

      if(var_8.size == 0) {
        break;
      }
    }

    var_9 = var_5.origin;
  }
}

_id_716A(var_0, var_1) {
  var_2 = self;
  anim._id_F191 = undefined;

  if(gettime() - var_2._id_8FDD < 3000) {
    var_2._id_7184["double_grenade"] = gettime() + var_2._id_7235._id_B69A;
  }

  var_2._id_8FDD = gettime();
  var_3 = var_2._id_7184[var_0._id_F25C];
  var_2._id_7184[var_0._id_F25C] = max(var_1, var_3);
}

_id_D57D(var_0, var_1) {
  if(var_0._id_89A2) {
    var_2 = var_0.player;
    var_3 = var_2._id_7184[var_0._id_F25C];
    var_2._id_7184[var_0._id_F25C] = max(var_1, var_3);
  } else {
    var_3 = anim._id_7184[var_0._id_F25C];
    anim._id_7184[var_0._id_F25C] = max(var_1, var_3);
  }
}

_id_6A7A(var_0) {
  self endon("killanimscript");
  self endon(var_0 + "_finished");
  self waittill("grenade_fire", var_1);
  return var_1;
}

_id_10B74(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

_id_6A7D(var_0) {
  if(var_0._id_89A2) {
    return var_0.player._id_7184[var_0._id_F25C];
  } else {
    return anim._id_7184[var_0._id_F25C];
  }
}

_id_A984(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}