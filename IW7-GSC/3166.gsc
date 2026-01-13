/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3166.gsc
*********************************************/

func_FFD9() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.isnodeoccupied) && isDefined(self.target_getindexoftarget);
}

func_FFDA(var_0, var_1, var_2, var_3) {
  if(isDefined(self.bt.var_C2) && isDefined(self.var_280A)) {
    return scripts\asm\asm_bb::bb_reloadrequested();
  }

  return 0;
}

func_CF00(var_0, var_1, var_2, var_3) {
  if(var_3 == "alignToNode") {
    if(isDefined(var_1)) {
      if(scripts\engine\utility::actor_is3d()) {
        var_4 = getangledelta3d(var_2);
        var_5 = scripts\asm\shared_utility::getnodeforwardangles(var_1, 0);
        var_6 = combineangles(var_5, -1 * var_4);
        self orientmode("face angle 3d", var_6);
        return;
      }

      var_4 = getangledelta3d(var_5);
      var_5 = (0, scripts\asm\shared_utility::getnodeforwardyaw(var_3), 0);
      var_6 = var_6 - var_5;
      self orientmode("face angle", var_6[1]);
      return;
    }

    return;
  }

  if(var_6 == "stickToNode") {
    var_7 = getmovedelta(var_5);
    if(distancesquared(var_4.origin, self.origin) < 16) {
      self ghost_target_position(var_4.origin);
      return;
    }

    thread func_ABB7(var_4, 4, var_3 + "_finished");
    return;
  }
}

func_3F06(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_4 = getangledelta(var_3, 0, 1);
  var_5 = angleclamp180(180 - var_4);
  if(isDefined(self.vehicle_getspawnerarray) && self.livestreamingenable) {
    var_6 = vectortoangles(self.setocclusionpreset);
    var_7 = var_6[1] - self.angles[1];
    var_8 = angleclamp180(var_7 + var_5);
  } else {
    var_9 = self.isnodeoccupied;
    var_7 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.25, var_9, undefined);
    var_8 = angleclamp180(var_7 + var_5);
  }

  var_0A = spawnStruct();
  if(abs(var_8) > 135) {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  } else if(var_8 < 0) {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  } else {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  }

  var_0A.var_D81F = var_7;
  return var_0A;
}

func_D559(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  var_5 = 1;
  if((scripts\asm\asm_bb::bb_meleechargerequested(var_0, var_1, var_2, var_3) || scripts\asm\asm_bb::bb_meleerequested(var_0, var_1, var_2, var_3)) && isDefined(self.melee.target) && isplayer(self.melee.target)) {
    var_5 = 2;
  }

  self func_82E7(var_1, var_4.var_1299D, 1, var_2, var_5);
  lib_0A1E::func_2369(var_0, var_1, var_4.var_1299D);
  thread func_D55A(var_1, var_4.var_1299D, var_4.var_D81F, var_2);
  var_6 = lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  if(var_6 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

func_D55A(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  self endon("death");
  self endon("entitydeleted");
  var_4 = getangledelta(var_1, 0, 1);
  var_5 = angleclamp180(self.angles[1] + var_4);
  var_6 = angleclamp180(self.angles[1] + var_2);
  var_7 = angleclamp180(var_6 - var_5);
  var_8 = getanimlength(var_1);
  var_9 = int(var_8 - var_3 * 20);
  var_0A = var_7 / var_9;
  var_0B = 0;
  while(var_0B < var_9) {
    self func_80F1(self.origin, self.angles + (0, var_0A, 0));
    var_0B++;
    wait(0.05);
  }
}

func_D558(var_0, var_1, var_2, var_3) {
  var_4 = level.asm[var_0].states[var_1].var_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  var_6 = scripts\asm\asm_bb::bb_getcovernode();
  if(!isDefined(var_6)) {
    if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 4096) {
      var_6 = self.target_getindexoftarget;
    }
  }

  var_7 = undefined;
  if(isDefined(var_6)) {
    var_7 = func_8178(var_0, var_1, var_5, var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_1 + "_finished");
    self.var_4C7E = lib_0F3D::func_22EA;
    self.a.var_22E5 = var_1;
    var_8 = var_7.log;
    var_9 = var_7.areanynavvolumesloaded;
    var_0A = angleclamp180(var_8 - var_7.var_3E);
    self.sendmatchdata = 1;
    self animmode("zonly_physics", 0);
    self orientmode("face current");
    if(self.script == "init") {
      wait(0.05);
    }

    lib_0A1E::func_2369(var_0, var_1, var_7.getgrenadedamageradius);
    self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
    self func_82E7(var_1, var_7.getgrenadedamageradius, 1, var_2, self.animplaybackrate);
    lib_0F3D::func_444B(var_1);
    self func_8396(var_9, var_0A);
    lib_0A1E::func_231F(var_0, var_1);
    self.a.movement = "stop";
    return;
  }

  self.sendmatchdata = 1;
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_4, var_5);
  self orientmode("face current");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_5);
  self func_82E7(var_4, var_8, 1, var_5, 1);
  lib_0A1E::func_2369(var_3, var_4, var_0A);
  lib_0A1E::func_231F(var_3, var_4, scripts\asm\asm::func_2341(var_3, var_4));
}

func_36D9(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

func_8178(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_4 = var_3.origin;
  var_5 = lib_0F3D::func_C057(var_3);
  var_6 = undefined;
  var_7 = undefined;
  if(var_5) {
    var_8 = undefined;
    if((scripts\engine\utility::isnodecoverleft(var_3) && lib_0F3D::func_9D4C(var_0, var_1, undefined, "Cover Left Crouch")) || scripts\engine\utility::isnodecoverright(var_3) && lib_0F3D::func_9D4C(var_0, var_1, undefined, "Cover Right Crouch")) {
      var_8 = "crouch";
    }

    var_6 = scripts\asm\shared_utility::getnodeforwardyaw(var_3, var_8);
    var_7 = var_3.angles;
  }

  var_9 = spawnStruct();
  var_9.getgrenadedamageradius = var_2;
  var_9.var_3F = 3;
  var_9.stricmp = getmovedelta(var_9.getgrenadedamageradius, 0, 1);
  var_9.var_3E = getangledelta(var_9.getgrenadedamageradius, 0, 1);
  var_9.areanynavvolumesloaded = func_36D9(var_4, var_6, var_9.stricmp, var_9.var_3E);
  var_9.angles = var_7;
  var_9.log = var_6;
  return var_9;
}

func_9E30(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 func_8169();
  foreach(var_3 in var_1) {
    if(var_3 == "over") {
      return 0;
    }
  }

  return 1;
}

func_3EC7(var_0, var_1, var_2) {
  var_3 = var_2;
  if(func_9E30(self.target_getindexoftarget)) {
    var_3 = var_3 + "_high";
  }

  var_4 = lib_0A1E::func_2356(var_1, var_3);
  if(isarray(var_4)) {
    return var_4[randomint(var_4.size)];
  }

  return var_4;
}

func_CEFC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.sendmatchdata = 1;
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self orientmode("face current");
  var_5 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      foreach(var_7 in var_3) {
        func_CF00(var_1, var_5, var_4, var_7);
      }
    } else {
      func_CF00(var_1, var_5, var_4, var_3);
    }
  }

  if(scripts\asm\asm::func_2384(var_0, var_1, "notetrackAim")) {
    var_9 = getangledelta(var_4, 0, 1);
    self.var_10F8C = self.angles[1] + var_9;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  self orientmode("face current");
}

func_D46B(var_0, var_1, var_2, var_3) {
  func_CF02(var_0, var_1, var_2, var_3);
}

func_12675(var_0) {
  var_1 = self.var_164D[var_0];
  if(isDefined(var_1.var_10E23)) {
    if(var_1.var_10E23 == "stand_run_loop") {
      return 1;
    } else if(scripts\engine\utility::actor_is3d() && var_1.var_10E23 == "stand_run_strafe_loop") {
      return 1;
    }
  }

  return 0;
}

func_CF01(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asm.var_A961)) {
    var_4 = [scripts\asm\asm_bb::bb_getcovernode(), self.target_getindexoftarget];
    for(var_5 = 0; !isDefined(self.asm.var_A961) && var_5 < var_4.size; var_5++) {
      if(isDefined(var_4[var_5]) && distancesquared(self.origin, var_4[var_5].origin) < 256) {
        self.asm.var_A961 = var_4[var_5];
      }
    }
  }

  func_CF02(var_0, var_1, var_2, var_3);
}

func_CF02(var_0, var_1, var_2, var_3) {
  self.sendmatchdata = 1;
  if(isDefined(var_3)) {
    if(var_3 == "stickToNode") {
      var_4 = scripts\asm\asm_bb::bb_getcovernode();
      if(isDefined(var_4)) {
        if(distancesquared(var_4.origin, self.origin) < 16) {
          self ghost_target_position(var_4.origin);
        } else {
          thread func_ABB7(var_4, 4, var_1 + "_finished");
        }
      }

      self.sendmatchdata = 0;
      if(func_12675(var_0)) {
        childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
      }
    }
  }

  var_5 = archetypegetalias(self.asm.archetype, var_1, "conceal_add", 0);
  var_4 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(var_5) && isDefined(var_4) && var_4.type == "Conceal Crouch" || var_4.type == "Conceal Stand") {
    self give_attacker_kill_rewards(var_5.var_47, 1, 0.2, 1, 1);
    thread func_4497(var_1);
  }

  lib_0F3D::func_B050(var_0, var_1, var_2, var_3);
}

func_4497(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0 + "_finished");
  var_1 = archetypegetalias(self.asm.archetype, "Knobs", "conceal_add", 0);
  self clearanim(var_1.var_47, 0.2);
}

func_ABB7(var_0, var_1, var_2) {
  self endon(var_2);
  for(;;) {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);
    if(var_4 < var_1) {
      self ghost_target_position(var_0.origin);
      break;
    }

    var_3 = var_3 / var_4;
    var_5 = self.origin + var_3 * var_1;
    self ghost_target_position(var_5);
    wait(0.05);
  }
}

func_CEC2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getanimlength(var_4);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
  var_6 = lib_0A1E::func_2323(var_0, var_1, var_5, scripts\asm\asm::func_2341(var_0, var_1));
  if(isDefined(var_6) && var_6 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }

  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_41A2(var_0, var_1, var_2) {
  self.sendmatchdata = 0;
  self.var_10F8C = undefined;
  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        scripts\asm\asm::asm_fireephemeralevent(var_4, "end");
      }

      return;
    }

    scripts\asm\asm::asm_fireephemeralevent(var_2, "end");
  }
}

func_116F2(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  lib_0C68::func_DF4F(var_0, var_1, var_2);
}

func_CEFD(var_0, var_1, var_2, var_3) {
  self.sendmatchdata = 1;
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self orientmode("face current");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_D51A(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["crouch_shuffle_right"] = -90;
  var_4["crouch_shuffle_left"] = 90;
  var_4["stand_shuffle_right"] = -90;
  var_4["stand_shuffle_left"] = 90;
  self endon(var_1 + "_finished");
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_6, var_2);
  self func_82EA(var_1, var_5, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_5);
  if(isDefined(self._blackboard.shufflenode)) {
    var_7 = self._blackboard.shufflenode.angles[1];
  } else if(isDefined(self.target_getindexoftarget)) {
    var_7 = self.target_getindexoftarget.angles[1];
  } else {
    var_7 = self.angles[1];
  }

  if(self.unittype != "c6" && isDefined(var_4[var_1])) {
    var_7 = var_7 + var_4[var_1];
  }

  self orientmode("face angle", var_7);
  lib_0A1E::func_231F(var_0, var_1);
}

func_10054(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::func_235D(var_2);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_6 = getmovedelta(var_5);
  var_7 = lengthsquared(var_6);
  var_8 = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return var_7 <= var_8 + 1;
}

func_FFB5(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.shufflenode)) {
    return 1;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 1;
  }

  if(self._blackboard.shufflenode != self.target_getindexoftarget) {
    return 1;
  }

  return 0;
}

func_FFCA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && self._blackboard.shufflenode.type != var_3) {
    return 0;
  }

  var_4 = lib_0A1E::func_235D(var_2);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_6 = self._blackboard.shufflenode.origin - self.origin;
  var_7 = vectornormalize(var_6);
  var_8 = getmovedelta(var_5, 0, 1);
  var_9 = length(var_8);
  var_0A = self._blackboard.shufflenode.origin - var_7 * var_9;
  var_6 = var_0A - self.origin;
  var_0B = self._blackboard.shufflenode.origin - self._blackboard.var_1016B.origin;
  var_0B = (var_0B[0], var_0B[1], 0);
  if(vectordot(var_0B, var_6) < 0) {
    return 1;
  }

  return 0;
}

func_D518(var_0, var_1, var_2, var_3) {
  self.var_4C7E = lib_0F3D::func_22EA;
  self.a.var_22E5 = var_1;
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  if(isDefined(self._blackboard.shufflenode)) {
    var_7 = self._blackboard.shufflenode;
  } else {
    var_7 = self.target_getindexoftarget;
  }

  if(isDefined(var_7)) {
    var_8 = (0, scripts\asm\shared_utility::getnodeforwardyaw(var_7), 0);
    var_9 = combineangles(var_8, invertangles(var_6));
    var_0A = var_7.origin - rotatevector(var_5, var_9);
  } else {
    var_0A = self.origin;
    var_9 = self.angles;
  }

  self func_8396(var_0A, var_9[1]);
  lib_0A1E::func_231F(var_0, var_1);
}

func_D519(var_0, var_1, var_2) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.var_1016B = undefined;
}

func_4742(var_0, var_1, var_2, var_3) {
  func_CEFC(var_0, var_1, var_2, var_3);
}

func_4700(var_0, var_1, var_2, var_3) {
  self.bt.var_C2.var_46FF = undefined;
  var_4 = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
  var_5 = level.asm[var_0].states[var_2];
  var_6 = scripts\engine\utility::array_randomize(var_5.transitions);
  var_7 = undefined;
  foreach(var_9 in var_6) {
    var_7 = var_9.var_100B1;
    if(var_7 == "up") {
      break;
    }

    var_0A = scripts\anim\utility_common::getcover3dnodeoffset(self.target_getindexoftarget, var_7);
    var_0B = self.target_getindexoftarget.origin + var_0A;
    if(sighttracepassed(var_0B, var_4, 0, undefined)) {
      break;
    }
  }

  self.bt.var_C2.var_46FF = var_0 + "_" + var_2 + "_" + var_7;
  return 1;
}

func_46FE(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + "_" + var_1 + "_" + var_3;
  return var_4 == self.bt.var_C2.var_46FF;
}