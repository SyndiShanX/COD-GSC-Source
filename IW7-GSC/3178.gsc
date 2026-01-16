/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3178.gsc
*********************************************/

func_100AD(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    return 0;
  }

  var_4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
  if(!isDefined(var_4) || !isDefined(self.enemy) || var_4 != self.enemy) {
    scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
    return 0;
  }

  if(lib_0A18::func_85B5(var_4)) {
    var_5 = self[[self.var_7191]](var_0, var_2);
    if(isDefined(var_5)) {
      var_6 = func_7EE8(var_2, var_5);
      var_7 = self.var_DCAF;
      var_8 = distance(var_4.origin, self.origin);
      if(var_8 < 800) {
        if(var_8 < 256) {
          var_7 = 0;
        } else {
          var_7 = var_7 * var_8 - 256 / 544;
        }
      }

      var_9 = self func_806B(var_6, var_7, "min energy", "min time", "max time");
      self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);
      if(isDefined(var_9)) {
        var_10 = spawnStruct();
        var_10.var_13E0D = var_5;
        var_10.var_1326C = var_9;
        var_10.target = var_4;
        var_10.var_8A09 = var_6;
        var_10.var_6BA0 = 0;
        var_10.var_13D8F = func_FFCE(self.grenadeweapon);
        var_10.time = gettime();
        self._blackboard.var_1180C = var_10;
        return 1;
      }
    }
  }

  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
  return 0;
}

func_3EA8(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = lib_0A1E::func_2356(var_1, "exposed_grenade");
  if(isarray(var_4)) {
    var_5 = [];
    foreach(var_7 in var_4) {
      var_8 = getnotetracktimes(var_7, "grenade_throw");
      if(var_8.size > 0) {
        var_9 = getmovedelta(var_7, 0, var_8[0]);
      } else {
        var_9 = getmovedelta(var_7);
      }

      var_9 = self gettweakablevalue(var_9);
      if(self maymovefrompointtopoint(self.origin, var_9)) {
        var_5[var_5.size] = var_7;
      }
    }

    if(var_5.size > 0) {
      var_3 = var_5[randomint(var_5.size)];
    } else {
      return undefined;
    }
  } else {
    var_3 = var_4;
  }

  return var_3;
}

func_3EA9(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = lib_0A1E::func_2356(var_1, "exposed_seeker_throw");
  if(isarray(var_4)) {
    var_5 = [];
    foreach(var_7 in var_4) {
      var_8 = getnotetracktimes(var_7, "grenade_throw");
      if(var_8.size > 0) {
        var_9 = getmovedelta(var_7, 0, var_8[0]);
      } else {
        var_9 = getmovedelta(var_7);
      }

      var_9 = self gettweakablevalue(var_9);
      if(self maymovefrompointtopoint(self.origin, var_9)) {
        var_5[var_5.size] = var_7;
      }
    }

    if(var_5.size > 0) {
      var_3 = var_5[randomint(var_5.size)];
    } else {
      return undefined;
    }
  } else {
    var_3 = var_4;
  }

  return var_3;
}

func_CEC6(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.var_1180C;
  var_5 = trygrenadethrow(var_0, var_1, var_4, var_2);
  if(!var_5) {
    self endon(var_1 + "_finished");
    wait(0.2);
    scripts\asm\asm::asm_fireevent(var_1, "end");
  }
}

func_CEFE(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node)) {
    self.sendmatchdata = 1;
  }

  func_CEC6(var_0, var_1, var_2, var_3);
}

func_CEFF(var_0, var_1, var_2) {
  lib_0C5E::func_41A2(var_0, var_1, var_2);
  func_CEC7(var_0, var_1, var_2);
}

func_CEC7(var_0, var_1, var_2) {
  self._blackboard.var_1180C = undefined;
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
}

func_FFCE(var_0) {
  return var_0 != "antigrav" && var_0 != "emp" && var_0 != "c8_grenade";
}

func_CEC8(var_0, var_1, var_2, var_3) {
  var_4 = level.player;
  if(isDefined(self.enemy)) {
    var_4 = self.enemy;
  }

  lib_0A18::func_F62B(var_4);
  var_5 = func_7E6D();
  func_F72C(self.var_1652, min(gettime() + 3000, var_5));
  var_6 = archetypegetaliases("soldier", var_1)[0];
  var_7 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwSeeker", "start");
  self.var_C3F3 = self.objective_state_nomessage;
  var_8 = lib_0A1E::asm_getbodyknob();
  scripts\anim\battlechatter_ai::func_67CF(self.grenadeweapon);
  lib_0A1E::func_2369(var_0, var_1, var_7);
  self clearanim(var_8, var_2);
  self func_82EA(var_1, var_7, 1, var_2, func_6B9A());
  thread lib_0A1E::func_231F(var_0, var_1);
  var_9 = "seeker_grenade_folded";
  var_10 = undefined;
  var_11 = 0;
  var_12 = func_810E(var_6);
  while(!var_11) {
    self waittill(var_1, var_13);
    if(!isarray(var_13)) {
      var_13 = [var_13];
    }

    foreach(var_16, var_15 in var_13) {
      if(var_15 == "attach_seeker") {
        if(isDefined(var_12)) {
          thread func_57E0("tag_accessory_left", var_12);
        } else {
          func_2481(var_1, var_9, "tag_accessory_left");
        }

        self.var_9E33 = 1;
      }

      if(var_15 == "grenade_throw" || var_15 == "grenade throw") {
        var_10 = self gettagorigin("tag_accessory_left");
        var_11 = 400;
        var_12 = anglesToForward(self.angles);
        var_13 = anglestoup(self.angles);
        var_13 = var_13 * 0.6;
        var_14 = vectornormalize(var_12 + var_13);
        var_15 = var_14 * var_11;
        var_10 = magicgrenademanual(self.grenadeweapon, var_10, var_15, 2);
        if(isDefined(var_10)) {
          if(self.objective_state > 0) {
            self.objective_state--;
          }

          self notify("grenade_fire", var_10, self.grenadeweapon);
        }

        if(isDefined(self.var_F174)) {
          self.var_F174 delete();
        }

        var_11 = 1;
        continue;
      }

      if(var_15 == "end") {
        self.var_1652.player.numgrenadesinprogresstowardsplayer--;
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

  self.var_9E33 = undefined;
  self.objective_state_nomessage = self.var_C3F3;
  self.var_C3F3 = undefined;
  if(isDefined(var_10) && self.team == "axis") {
    level notify("enemy_grenade_fire", var_10);
  }

  func_F72C(self.var_1652, gettime() + 10000);
  self waittillmatch("end", var_1);
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  scripts\asm\asm::asm_fireephemeralevent("throwSeeker", "end");
}

func_810E(var_0) {
  if(var_0 == "exposed_seeker_throw") {
    return % equip_seeker_throw01;
  }

  return undefined;
}

func_57E0(var_0, var_1) {
  self.var_F174 = spawn("script_model", self gettagorigin(var_0));
  thread scripts\engine\utility::delete_on_death(self.var_F174);
  self.var_F174 endon("death");
  self.var_F174.angles = self gettagangles(var_0);
  self.var_F174 linkto(self, var_0, (0, 0, 0), (0, 0, 0));
  self.var_F174 setModel("seeker_grenade_wm");
  self.var_F174 glinton(#animtree);
  self.var_F174 func_82EA("thrown", var_1, 1, 0.2);
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.destination;
  var_6 = var_2.target;
  var_7 = var_2.var_13D8F;
  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(isDefined(var_5)) {
    var_8 = func_7EE8(var_1, var_2.var_13E0D);
    if(!isDefined(var_2.var_6BA0)) {
      var_9 = self getplayerassets(var_8, var_5, var_7, "min energy", "min time", "max time");
    } else {
      var_9 = self getplayerassets(var_8, var_5, var_7, "min time", "min energy");
    }
  } else {
    var_9 = var_3.var_1326C;
  }

  var_6 = var_2.target;
  if(isDefined(var_9)) {
    if(!isDefined(self.var_C3F3)) {
      self.var_C3F3 = self.objective_state_nomessage;
    }

    self.objective_state_nomessage = 0;
    var_10 = func_7E6D();
    func_F72C(self.var_1652, min(gettime() + 3000, var_10));
    var_11 = 0;
    if(usingplayer()) {
      var_6.numgrenadesinprogresstowardsplayer++;
      thread func_DE37(var_1, var_6);
      if(var_6.numgrenadesinprogresstowardsplayer > 1) {
        var_11 = 1;
      }

      if(self.var_1652.timername == "fraggrenade") {
        if(var_6.numgrenadesinprogresstowardsplayer <= 1) {
          var_6.lastfraggrenadetoplayerstart = gettime();
        }
      }
    }

    if(isDefined(var_4)) {
      thread func_58BA(var_0, var_1, var_2.var_13E0D, var_9, var_3, var_10, var_11);
    } else {
      func_58BA(var_0, var_1, var_2.var_13E0D, var_9, var_3, var_10, var_11);
    }

    return 1;
  }

  return 0;
}

func_7EE8(var_0, var_1) {
  var_2 = (0, 0, 64);
  var_3 = self.asm.archetype;
  var_4 = 0;
  if(isDefined(level.var_85DF)) {
    if(!isDefined(level.var_85DF[var_3])) {
      var_3 = "soldier";
    }

    if(isDefined(level.var_85DF[var_3])) {
      if(isDefined(level.var_85DF[var_3][var_0])) {
        foreach(var_8, var_6 in level.var_85DF[var_3][var_0]) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            if(var_6[var_7] == var_1) {
              var_2 = level.var_85E1[var_3][var_0][var_8][var_7];
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

func_7E6D() {
  var_0 = undefined;
  if(usingplayer()) {
    var_1 = self.var_1652.player;
    var_0 = gettime() + var_1.gs.var_D396 + randomint(var_1.gs.var_D397);
  } else {
    var_0 = gettime() + 30000 + randomint(30000);
  }

  return var_0;
}

usingplayer() {
  return self.var_1652.isplayertimer;
}

func_DE37(var_0, var_1) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(var_0 + "_finished");
  var_1.numgrenadesinprogresstowardsplayer--;
}

func_58BA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  var_7 = scripts\asm\asm_bb::bb_getcovernode();
  if(!isDefined(var_7) || var_7.type == "Exposed" || var_7.type == "Path") {
    self orientmode("face direction", var_3);
  }

  var_8 = lib_0A1E::asm_getbodyknob();
  scripts\anim\battlechatter_ai::func_67CF(self.grenadeweapon);
  lib_0A1E::func_2369(var_0, var_1, var_2);
  self clearanim(var_8, var_4);
  self func_82EA(var_1, var_2, 1, var_4, func_6B9A());
  thread lib_0A1E::func_231F(var_0, var_1);
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
        var_10 = func_2481(var_1, var_9, "tag_accessory_right");
        self.var_9E33 = 1;
      }

      if(var_14 == "grenade_throw" || var_14 == "grenade throw") {
        if(isDefined(self.var_1FEC) && self.var_1FEC == "c6") {
          self playSound("c6_grenade_launch");
        }

        var_11 = 1;
        continue;
      }

      if(var_14 == "end") {
        self.var_1652.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");
  if(usingplayer()) {
    thread func_13A98(var_1, self.var_1652.player, var_5);
  }

  var_16 = self func_83C2();
  if(!usingplayer()) {
    func_F72C(self.var_1652, var_5);
  }

  if(var_6) {
    var_17 = self.var_1652.player;
    if(var_17.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_17.var_A990 < 2000) {
      var_17.grenadetimers["double_grenade"] = gettime() + min(5000, var_17.gs.var_D382);
    }
  }

  self notify("stop grenade check");
  if(var_10 != "none") {
    self detach(var_9, var_10);
  }

  self.var_9E33 = undefined;
  self.objective_state_nomessage = self.var_C3F3;
  self.var_C3F3 = undefined;
  if(isDefined(var_16) && self.team == "axis") {
    level notify("enemy_grenade_fire", var_16);
  }

  self waittillmatch("end", var_1);
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

func_11810(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    if(scripts\asm\asm::func_232B(var_1, "grenade_throw") || scripts\asm\asm::func_232B(var_1, "grenade throw")) {
      return 0;
    }

    if(scripts\asm\asm::func_232B(var_1, "grenade_right") || scripts\asm\asm::func_232B(var_1, "grenade_left")) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_6B9A() {
  return 1.5;
}

func_2481(var_0, var_1, var_2) {
  self attach(var_1, var_2);
  thread func_5392(var_0, var_1, var_2);
  return var_2;
}

func_13841(var_0) {
  self endon(var_0 + "_finished");
  self waittill("killanimscript");
}

func_5392(var_0, var_1, var_2) {
  self endon("stop grenade check");
  func_13841(var_0);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C3F3)) {
    self.objective_state_nomessage = self.var_C3F3;
    self.var_C3F3 = undefined;
  }

  self detach(var_1, var_2);
}

func_13A98(var_0, var_1, var_2) {
  var_1 endon("death");
  func_13A99(var_0, var_2);
  var_1.numgrenadesinprogresstowardsplayer--;
}

func_13A99(var_0, var_1) {
  var_2 = self.var_1652;
  var_3 = spawnStruct();
  var_3 thread func_13A9A(5);
  var_3 endon("watchGrenadeTowardsPlayerTimeout");
  var_4 = self.grenadeweapon;
  var_5 = func_7EE6(var_0);
  if(!isDefined(var_5)) {
    return;
  }

  func_F72C(var_2, min(gettime() + 5000, var_1));
  var_6 = -3036;
  var_7 = 160000;
  if(var_4 == "flash_grenade") {
    var_6 = 810000;
    var_7 = 1690000;
  }

  var_8 = level.players;
  var_9 = var_5.origin;
  for(;;) {
    wait(0.1);
    if(!isDefined(var_5)) {
      break;
    }

    if(distancesquared(var_5.origin, var_9) < 400) {
      var_10 = [];
      for(var_11 = 0; var_11 < var_8.size; var_11++) {
        var_12 = var_8[var_11];
        var_13 = distancesquared(var_5.origin, var_12.origin);
        if(var_13 < var_6) {
          var_12 func_85C8(var_2, var_1);
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

func_85C8(var_0, var_1) {
  var_2 = self;
  anim.var_11813 = undefined;
  if(gettime() - var_2.var_A990 < 3000) {
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.var_D382;
  }

  var_2.var_A990 = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

func_F72C(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
    return;
  }

  var_3 = level.grenadetimers[var_1.timername];
  level.grenadetimers[var_0.timername] = max(var_1, var_3);
}

func_7EE6(var_0) {
  self endon("killanimscript");
  self endon(var_0 + "_finished");
  self waittill("grenade_fire", var_1);
  return var_1;
}

func_13A9A(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

func_7EE9(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  }

  return level.grenadetimers[var_0.timername];
}

func_C371(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}