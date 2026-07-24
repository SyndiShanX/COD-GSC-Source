/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3178.gsc
**************************************/

_id_100AD(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    return 0;
  }

  var_4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var_4) || !isDefined(self.enemy) || var_4 != self.enemy) {
    scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
    return 0;
  }

  if(_id_0A18::_id_85B5(var_4)) {
    var_5 = self[[self._id_7191]](var_0, var_2);

    if(isDefined(var_5)) {
      var_6 = _id_7EE8(var_2, var_5);
      var_7 = self._id_DCAF;
      var_8 = distance(var_4.origin, self.origin);

      if(var_8 < 800) {
        if(var_8 < 256) {
          var_7 = 0;
        } else {
          var_7 = var_7 * ((var_8 - 256) / 544);
        }
      }

      var_9 = self _meth_806B(var_6, var_7, "min energy", "min time", "max time");
      self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);

      if(isDefined(var_9)) {
        var_10 = spawnStruct();
        var_10._id_13E0D = var_5;
        var_10._id_1326C = var_9;
        var_10.target = var_4;
        var_10._id_8A09 = var_6;
        var_10._id_6BA0 = 0;
        var_10._id_13D8F = _id_FFCE(self.grenadeweapon);
        var_10.time = gettime();
        self._blackboard._id_1180C = var_10;
        return 1;
      }
    }
  }

  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
  return 0;
}

_id_3EA8(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _id_0A1E::_id_2356(var_1, "exposed_grenade");

  if(isarray(var_4)) {
    var_5 = [];

    foreach(var_7 in var_4) {
      var_8 = getnotetracktimes(var_7, "grenade_throw");

      if(var_8.size > 0) {
        var_9 = getmovedelta(var_7, 0, var_8[0]);
      } else {
        var_9 = getmovedelta(var_7);
      }

      var_9 = self localtoworldcoords(var_9);

      if(self maymovefrompointtopoint(self.origin, var_9)) {
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

_id_3EA9(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _id_0A1E::_id_2356(var_1, "exposed_seeker_throw");

  if(isarray(var_4)) {
    var_5 = [];

    foreach(var_7 in var_4) {
      var_8 = getnotetracktimes(var_7, "grenade_throw");

      if(var_8.size > 0) {
        var_9 = getmovedelta(var_7, 0, var_8[0]);
      } else {
        var_9 = getmovedelta(var_7);
      }

      var_9 = self localtoworldcoords(var_9);

      if(self maymovefrompointtopoint(self.origin, var_9)) {
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

_id_CEC6(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard._id_1180C;
  var_5 = trygrenadethrow(var_0, var_1, var_4, var_2);

  if(!var_5) {
    self endon(var_1 + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var_1, "end");
  }
}

_id_CEFE(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node)) {
    self.keepclaimednodeifvalid = 1;
  }

  _id_CEC6(var_0, var_1, var_2, var_3);
}

_id_CEFF(var_0, var_1, var_2) {
  _id_0C5E::_id_41A2(var_0, var_1, var_2);
  _id_CEC7(var_0, var_1, var_2);
}

_id_CEC7(var_0, var_1, var_2) {
  self._blackboard._id_1180C = undefined;
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
}

_id_FFCE(var_0) {
  return var_0 != "antigrav" && var_0 != "emp" && var_0 != "c8_grenade";
}

_id_CEC8(var_0, var_1, var_2, var_3) {
  var_4 = level.player;

  if(isDefined(self.enemy)) {
    var_4 = self.enemy;
  }

  _id_0A18::_id_F62B(var_4);
  var_5 = _id_7E6D();
  _id_F72C(self._id_1652, min(gettime() + 3000, var_5));
  var_6 = _func_2F0("soldier", var_1)[0];
  var_7 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwSeeker", "start");
  self._id_C3F3 = self.grenadeawareness;
  var_8 = _id_0A1E::asm_getbodyknob();
  scripts\anim\battlechatter_ai::_id_67CF(self.grenadeweapon);
  _id_0A1E::_id_2369(var_0, var_1, var_7);
  self clearanim(var_8, var_2);
  self _meth_82EA(var_1, var_7, 1.0, var_2, _id_6B9A());
  thread _id_0A1E::_id_231F(var_0, var_1);
  var_9 = "seeker_grenade_folded";
  var_10 = undefined;
  var_11 = 0;
  var_12 = _id_810E(var_6);

  while(!var_11) {
    self waittill(var_1, var_13);

    if(!isarray(var_13)) {
      var_13 = [var_13];
    }

    foreach(var_15 in var_13) {
      if(var_15 == "attach_seeker") {
        if(isDefined(var_12)) {
          thread _id_57E0("tag_accessory_left", var_12);
        } else {
          _id_2481(var_1, var_9, "tag_accessory_left");
        }

        self._id_9E33 = 1;
      }

      if(var_15 == "grenade_throw" || var_15 == "grenade throw") {
        var_16 = self gettagorigin("tag_accessory_left");
        var_17 = 400;
        var_18 = anglesToForward(self.angles);
        var_19 = anglestoup(self.angles);
        var_19 = var_19 * 0.6;
        var_20 = vectorNormalize(var_18 + var_19);
        var_21 = var_20 * var_17;
        var_10 = magicgrenademanual(self.grenadeweapon, var_16, var_21, 2);

        if(isDefined(var_10)) {
          if(self.grenadeammo > 0) {
            self.grenadeammo--;
          }

          self notify("grenade_fire", var_10, self.grenadeweapon);
        }

        if(isDefined(self._id_F174)) {
          self._id_F174 delete();
        }

        var_11 = 1;
        continue;
      }

      if(var_15 == "end") {
        self._id_1652.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");
  self notify("stop grenade check");

  if(!isDefined(var_12)) {
    self detach(var_9, "tag_accessory_left");
  }

  self._id_9E33 = undefined;
  self.grenadeawareness = self._id_C3F3;
  self._id_C3F3 = undefined;

  if(isDefined(var_10) && self.team == "axis") {
    level notify("enemy_grenade_fire", var_10);
  }

  _id_F72C(self._id_1652, gettime() + 10000);
  self waittillmatch(var_1, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  scripts\asm\asm::asm_fireephemeralevent("throwSeeker", "end");
}

#using_animtree("seeker");

_id_810E(var_0) {
  if(var_0 == "exposed_seeker_throw") {
    return % equip_seeker_throw01;
  }

  return undefined;
}

_id_57E0(var_0, var_1) {
  self._id_F174 = spawn("script_model", self gettagorigin(var_0));
  thread scripts\engine\utility::delete_on_death(self._id_F174);
  self._id_F174 endon("death");
  self._id_F174.angles = self gettagangles(var_0);
  self._id_F174 linkTo(self, var_0, (0, 0, 0), (0, 0, 0));
  self._id_F174 setModel("seeker_grenade_wm");
  self._id_F174 _meth_83D0(#animtree);
  self._id_F174 _meth_82EA("thrown", var_1, 1.0, 0.2);
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.destination;
  var_6 = var_2.target;
  var_7 = var_2._id_13D8F;

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(isDefined(var_5)) {
    var_8 = _id_7EE8(var_1, var_2._id_13E0D);

    if(!isDefined(var_2._id_6BA0)) {
      var_9 = self _meth_806C(var_8, var_5, var_7, "min energy", "min time", "max time");
    } else {
      var_9 = self _meth_806C(var_8, var_5, var_7, "min time", "min energy");
    }
  } else
    var_9 = var_2._id_1326C;

  var_6 = var_2.target;

  if(isDefined(var_9)) {
    if(!isDefined(self._id_C3F3)) {
      self._id_C3F3 = self.grenadeawareness;
    }

    self.grenadeawareness = 0;
    var_10 = _id_7E6D();
    _id_F72C(self._id_1652, min(gettime() + 3000, var_10));
    var_11 = 0;

    if(usingplayer()) {
      var_6.numgrenadesinprogresstowardsplayer++;
      thread _id_DE37(var_1, var_6);

      if(var_6.numgrenadesinprogresstowardsplayer > 1) {
        var_11 = 1;
      }

      if(self._id_1652.timername == "fraggrenade") {
        if(var_6.numgrenadesinprogresstowardsplayer <= 1) {
          var_6.lastfraggrenadetoplayerstart = gettime();
        }
      }
    }

    if(isDefined(var_4)) {
      thread _id_58BA(var_0, var_1, var_2._id_13E0D, var_9, var_3, var_10, var_11);
    } else {
      _id_58BA(var_0, var_1, var_2._id_13E0D, var_9, var_3, var_10, var_11);
    }

    return 1;
  } else {}

  return 0;
}

_id_7EE8(var_0, var_1) {
  var_2 = (0, 0, 64);
  var_3 = self.asm.archetype;
  var_4 = 0;

  if(isDefined(anim._id_85DF)) {
    if(!isDefined(anim._id_85DF[var_3])) {
      var_3 = "soldier";
    }

    if(isDefined(anim._id_85DF[var_3])) {
      if(isDefined(anim._id_85DF[var_3][var_0])) {
        foreach(var_8, var_6 in anim._id_85DF[var_3][var_0]) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            if(var_6[var_7] == var_1) {
              var_2 = anim._id_85E1[var_3][var_0][var_8][var_7];
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

_id_7E6D() {
  var_0 = undefined;

  if(usingplayer()) {
    var_1 = self._id_1652.player;
    var_0 = gettime() + var_1.gs._id_D396 + randomint(var_1.gs._id_D397);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

usingplayer() {
  return self._id_1652.isplayertimer;
}

_id_DE37(var_0, var_1) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(var_0 + "_finished");
  var_1.numgrenadesinprogresstowardsplayer--;
}

_id_58BA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  var_7 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var_7) || var_7.type == "Exposed" || var_7.type == "Path") {
    self orientmode("face direction", var_3);
  }

  var_8 = _id_0A1E::asm_getbodyknob();
  scripts\anim\battlechatter_ai::_id_67CF(self.grenadeweapon);
  _id_0A1E::_id_2369(var_0, var_1, var_2);
  self clearanim(var_8, var_4);
  self _meth_82EA(var_1, var_2, 1.0, var_4, _id_6B9A());
  thread _id_0A1E::_id_231F(var_0, var_1);
  var_9 = scripts\anim\utility_common::getgrenademodel();
  var_10 = "none";
  var_11 = 0;

  while(!var_11) {
    self waittill(var_1, var_12);

    if(!isarray(var_12)) {
      var_12 = [var_12];
    }

    foreach(var_14 in var_12) {
      if(var_14 == "grenade_left" || var_14 == "grenade_right") {
        var_10 = _id_2481(var_1, var_9, "tag_accessory_right");
        self._id_9E33 = 1;
      }

      if(var_14 == "grenade_throw" || var_14 == "grenade throw") {
        if(isDefined(self._id_1FEC) && self._id_1FEC == "c6") {
          self playSound("c6_grenade_launch");
        }

        var_11 = 1;
        continue;
      }

      if(var_14 == "end") {
        self._id_1652.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayer()) {
    thread _id_13A98(var_1, self._id_1652.player, var_5);
  }

  var_22 = self _meth_83C2();

  if(!usingplayer()) {
    _id_F72C(self._id_1652, var_5);
  }

  if(var_6) {
    var_23 = self._id_1652.player;

    if(var_23.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_23._id_A990 < 2000) {
      var_23.grenadetimers["double_grenade"] = gettime() + min(5000, var_23.gs._id_D382);
    }
  }

  self notify("stop grenade check");

  if(var_10 != "none") {
    self detach(var_9, var_10);
  }

  self._id_9E33 = undefined;
  self.grenadeawareness = self._id_C3F3;
  self._id_C3F3 = undefined;

  if(isDefined(var_22) && self.team == "axis") {
    level notify("enemy_grenade_fire", var_22);
  }

  self waittillmatch(var_1, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

_id_11810(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    if(scripts\asm\asm::_id_232B(var_1, "grenade_throw") || scripts\asm\asm::_id_232B(var_1, "grenade throw")) {
      return 0;
    }

    if(scripts\asm\asm::_id_232B(var_1, "grenade_right") || scripts\asm\asm::_id_232B(var_1, "grenade_left")) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_6B9A() {
  return 1.5;
}

_id_2481(var_0, var_1, var_2) {
  self attach(var_1, var_2);
  thread _id_5392(var_0, var_1, var_2);
  return var_2;
}

_id_13841(var_0) {
  self endon(var_0 + "_finished");
  self waittill("killanimscript");
}

_id_5392(var_0, var_1, var_2) {
  self endon("stop grenade check");
  _id_13841(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_C3F3)) {
    self.grenadeawareness = self._id_C3F3;
    self._id_C3F3 = undefined;
  }

  self detach(var_1, var_2);
}

_id_13A98(var_0, var_1, var_2) {
  var_1 endon("death");
  _id_13A99(var_0, var_2);
  var_1.numgrenadesinprogresstowardsplayer--;
}

_id_13A99(var_0, var_1) {
  var_2 = self._id_1652;
  var_3 = spawnStruct();
  var_3 thread _id_13A9A(5);
  var_3 endon("watchGrenadeTowardsPlayerTimeout");
  var_4 = self.grenadeweapon;
  var_5 = _id_7EE6(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  _id_F72C(var_2, min(gettime() + 5000, var_1));
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
          var_12 _id_85C8(var_2, var_1);
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

_id_85C8(var_0, var_1) {
  var_2 = self;
  anim._id_11813 = undefined;

  if(gettime() - var_2._id_A990 < 3000) {
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs._id_D382;
  }

  var_2._id_A990 = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

_id_F72C(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
  } else {
    var_3 = anim.grenadetimers[var_0.timername];
    anim.grenadetimers[var_0.timername] = max(var_1, var_3);
  }
}

_id_7EE6(var_0) {
  self endon("killanimscript");
  self endon(var_0 + "_finished");
  self waittill("grenade_fire", var_1);
  return var_1;
}

_id_13A9A(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

_id_7EE9(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  } else {
    return anim.grenadetimers[var_0.timername];
  }
}

_id_C371(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}