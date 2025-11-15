/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3166.gsc
************************/

func_FFD9() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.isnodeoccupied) && isDefined(self.target_getindexoftarget);
}

func_FFDA(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_3135.var_C2) && isDefined(self.var_280A)) {
    return scripts\asm\asm_bb::bb_reloadrequested();
  }

  return 0;
}

func_CF00(param_00, param_01, param_02, param_03) {
  if(param_03 == "alignToNode") {
    if(isDefined(param_01)) {
      if(scripts\engine\utility::actor_is3d()) {
        var_04 = getangledelta3d(param_02);
        var_05 = scripts\asm\shared_utility::getnodeforwardangles(param_01, 0);
        var_06 = combineangles(var_05, -1 * var_04);
        self orientmode("face angle 3d", var_06);
        return;
      }

      var_04 = getangledelta3d(var_05);
      var_05 = (0, scripts\asm\shared_utility::getnodeforwardyaw(param_03), 0);
      var_06 = var_06 - var_05;
      self orientmode("face angle", var_06[1]);
      return;
    }

    return;
  }

  if(var_06 == "stickToNode") {
    var_07 = getmovedelta(var_05);
    if(distancesquared(var_04.origin, self.origin) < 16) {
      self ghost_target_position(var_04.origin);
      return;
    }

    thread func_ABB7(var_04, 4, param_03 + "_finished");
    return;
  }
}

func_3F06(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "2");
  var_04 = getangledelta(var_03, 0, 1);
  var_05 = angleclamp180(180 - var_04);
  if(isDefined(self.vehicle_getspawnerarray) && self.livestreamingenable) {
    var_06 = vectortoangles(self.setocclusionpreset);
    var_07 = var_06[1] - self.angles[1];
    var_08 = angleclamp180(var_07 + var_05);
  } else {
    var_09 = self.isnodeoccupied;
    var_07 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.25, var_09, undefined);
    var_08 = angleclamp180(var_07 + var_05);
  }

  var_0A = spawnStruct();
  if(abs(var_08) > 135) {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(param_01, "2");
  } else if(var_08 < 0) {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(param_01, "6");
  } else {
    var_0A.var_1299D = scripts\asm\asm::asm_lookupanimfromalias(param_01, "4");
  }

  var_0A.var_D81F = var_07;
  return var_0A;
}

func_D559(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  var_05 = 1;
  if((scripts\asm\asm_bb::bb_meleechargerequested(param_00, param_01, param_02, param_03) || scripts\asm\asm_bb::bb_meleerequested(param_00, param_01, param_02, param_03)) && isDefined(self.melee.target) && isplayer(self.melee.target)) {
    var_05 = 2;
  }

  self _meth_82E7(param_01, var_04.var_1299D, 1, param_02, var_05);
  lib_0A1E::func_2369(param_00, param_01, var_04.var_1299D);
  thread func_D55A(param_01, var_04.var_1299D, var_04.var_D81F, param_02);
  var_06 = lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  if(var_06 == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_D55A(param_00, param_01, param_02, param_03) {
  self endon(param_00 + "_finished");
  self endon("death");
  self endon("entitydeleted");
  var_04 = getangledelta(param_01, 0, 1);
  var_05 = angleclamp180(self.angles[1] + var_04);
  var_06 = angleclamp180(self.angles[1] + param_02);
  var_07 = angleclamp180(var_06 - var_05);
  var_08 = getanimlength(param_01);
  var_09 = int(var_08 - param_03 * 20);
  var_0A = var_07 / var_09;
  var_0B = 0;
  while(var_0B < var_09) {
    self _meth_80F1(self.origin, self.angles + (0, var_0A, 0));
    var_0B++;
    wait(0.05);
  }
}

func_D558(param_00, param_01, param_02, param_03) {
  var_04 = level.asm[param_00].states[param_01].var_71A5;
  var_05 = self[[var_04]](param_00, param_01, param_03);
  var_06 = scripts\asm\asm_bb::bb_getcovernode();
  if(!isDefined(var_06)) {
    if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 4096) {
      var_06 = self.target_getindexoftarget;
    }
  }

  var_07 = undefined;
  if(isDefined(var_06)) {
    var_07 = _meth_8178(param_00, param_01, var_05, var_06);
  }

  if(isDefined(var_07)) {
    self endon(param_01 + "_finished");
    self.var_4C7E = ::lib_0F3D::func_22EA;
    self.a.var_22E5 = param_01;
    var_08 = var_07.log;
    var_09 = var_07.areanynavvolumesloaded;
    var_0A = angleclamp180(var_08 - var_07.var_3E);
    self.sendmatchdata = 1;
    self animmode("zonly_physics", 0);
    self orientmode("face current");
    if(self.script == "init") {
      wait(0.05);
    }

    lib_0A1E::func_2369(param_00, param_01, var_07.getgrenadedamageradius);
    self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
    self _meth_82E7(param_01, var_07.getgrenadedamageradius, 1, param_02, self.animplaybackrate);
    lib_0F3D::func_444B(param_01);
    self _meth_8396(var_09, var_0A);
    lib_0A1E::func_231F(param_00, param_01);
    self.a.movement = "stop";
    return;
  }

  self.sendmatchdata = 1;
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_04, var_05);
  self orientmode("face current");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_05);
  self _meth_82E7(var_04, var_08, 1, var_05, 1);
  lib_0A1E::func_2369(param_03, var_04, var_0A);
  lib_0A1E::func_231F(param_03, var_04, scripts\asm\asm::func_2341(param_03, var_04));
}

func_36D9(param_00, param_01, param_02, param_03) {
  var_04 = param_01 - param_03;
  var_05 = (0, var_04, 0);
  var_06 = rotatevector(param_02, var_05);
  return param_00 - var_06;
}

_meth_8178(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_04 = param_03.origin;
  var_05 = lib_0F3D::func_C057(param_03);
  var_06 = undefined;
  var_07 = undefined;
  if(var_05) {
    var_08 = undefined;
    if((scripts\engine\utility::isnodecoverleft(param_03) && lib_0F3D::func_9D4C(param_00, param_01, undefined, "Cover Left Crouch")) || scripts\engine\utility::isnodecoverright(param_03) && lib_0F3D::func_9D4C(param_00, param_01, undefined, "Cover Right Crouch")) {
      var_08 = "crouch";
    }

    var_06 = scripts\asm\shared_utility::getnodeforwardyaw(param_03, var_08);
    var_07 = param_03.angles;
  }

  var_09 = spawnStruct();
  var_09.getgrenadedamageradius = param_02;
  var_09.var_3F = 3;
  var_09.stricmp = getmovedelta(var_09.getgrenadedamageradius, 0, 1);
  var_09.var_3E = getangledelta(var_09.getgrenadedamageradius, 0, 1);
  var_09.areanynavvolumesloaded = func_36D9(var_04, var_06, var_09.stricmp, var_09.var_3E);
  var_09.angles = var_07;
  var_09.log = var_06;
  return var_09;
}

func_9E30(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = param_00 _meth_8169();
  foreach(var_03 in var_01) {
    if(var_03 == "over") {
      return 0;
    }
  }

  return 1;
}

func_3EC7(param_00, param_01, param_02) {
  var_03 = param_02;
  if(func_9E30(self.target_getindexoftarget)) {
    var_03 = var_03 + "_high";
  }

  var_04 = lib_0A1E::func_2356(param_01, var_03);
  if(isarray(var_04)) {
    return var_04[randomint(var_04.size)];
  }

  return var_04;
}

func_CEFC(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.sendmatchdata = 1;
  childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self orientmode("face current");
  var_05 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(param_03)) {
    if(isarray(param_03)) {
      foreach(var_07 in param_03) {
        func_CF00(param_01, var_05, var_04, var_07);
      }
    } else {
      func_CF00(param_01, var_05, var_04, param_03);
    }
  }

  if(scripts\asm\asm::func_2384(param_00, param_01, "notetrackAim")) {
    var_09 = getangledelta(var_04, 0, 1);
    self.var_10F8C = self.angles[1] + var_09;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  self orientmode("face current");
}

func_D46B(param_00, param_01, param_02, param_03) {
  func_CF02(param_00, param_01, param_02, param_03);
}

func_12675(param_00) {
  var_01 = self.var_164D[param_00];
  if(isDefined(var_01.var_10E23)) {
    if(var_01.var_10E23 == "stand_run_loop") {
      return 1;
    } else if(scripts\engine\utility::actor_is3d() && var_01.var_10E23 == "stand_run_strafe_loop") {
      return 1;
    }
  }

  return 0;
}

func_CF01(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.asm.var_A961)) {
    var_04 = [scripts\asm\asm_bb::bb_getcovernode(), self.target_getindexoftarget];
    for(var_05 = 0; !isDefined(self.asm.var_A961) && var_05 < var_04.size; var_05++) {
      if(isDefined(var_04[var_05]) && distancesquared(self.origin, var_04[var_05].origin) < 256) {
        self.asm.var_A961 = var_04[var_05];
      }
    }
  }

  func_CF02(param_00, param_01, param_02, param_03);
}

func_CF02(param_00, param_01, param_02, param_03) {
  self.sendmatchdata = 1;
  if(isDefined(param_03)) {
    if(param_03 == "stickToNode") {
      var_04 = scripts\asm\asm_bb::bb_getcovernode();
      if(isDefined(var_04)) {
        if(distancesquared(var_04.origin, self.origin) < 16) {
          self ghost_target_position(var_04.origin);
        } else {
          thread func_ABB7(var_04, 4, param_01 + "_finished");
        }
      }

      self.sendmatchdata = 0;
      if(func_12675(param_00)) {
        childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
      }
    }
  }

  var_05 = archetypegetalias(self.asm.archetype, param_01, "conceal_add", 0);
  var_04 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(var_05) && isDefined(var_04) && var_04.type == "Conceal Crouch" || var_04.type == "Conceal Stand") {
    self give_attacker_kill_rewards(var_05.var_47, 1, 0.2, 1, 1);
    thread func_4497(param_01);
  }

  lib_0F3D::func_B050(param_00, param_01, param_02, param_03);
}

func_4497(param_00) {
  self endon("death");
  self endon("entitydeleted");
  self waittill(param_00 + "_finished");
  var_01 = archetypegetalias(self.asm.archetype, "Knobs", "conceal_add", 0);
  self clearanim(var_01.var_47, 0.2);
}

func_ABB7(param_00, param_01, param_02) {
  self endon(param_02);
  for(;;) {
    var_03 = param_00.origin - self.origin;
    var_04 = length(var_03);
    if(var_04 < param_01) {
      self ghost_target_position(param_00.origin);
      break;
    }

    var_03 = var_03 / var_04;
    var_05 = self.origin + var_03 * param_01;
    self ghost_target_position(var_05);
    wait(0.05);
  }
}

func_CEC2(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = getanimlength(var_04);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
  var_06 = lib_0A1E::func_2323(param_00, param_01, var_05, scripts\asm\asm::func_2341(param_00, param_01));
  if(isDefined(var_06) && var_06 == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }

  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_41A2(param_00, param_01, param_02) {
  self.sendmatchdata = 0;
  self.var_10F8C = undefined;
  if(isDefined(param_02)) {
    if(isarray(param_02)) {
      foreach(var_04 in param_02) {
        scripts\asm\asm::asm_fireephemeralevent(var_04, "end");
      }

      return;
    }

    scripts\asm\asm::asm_fireephemeralevent(param_02, "end");
  }
}

func_116F2(param_00, param_01, param_02) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  lib_0C68::func_DF4F(param_00, param_01, param_02);
}

func_CEFD(param_00, param_01, param_02, param_03) {
  self.sendmatchdata = 1;
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self orientmode("face current");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_D51A(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04["crouch_shuffle_right"] = -90;
  var_04["crouch_shuffle_left"] = 90;
  var_04["stand_shuffle_right"] = -90;
  var_04["stand_shuffle_left"] = 90;
  self endon(param_01 + "_finished");
  var_05 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_06 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_06, param_02);
  self _meth_82EA(param_01, var_05, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_05);
  if(isDefined(self.var_1198.shufflenode)) {
    var_07 = self.var_1198.shufflenode.angles[1];
  } else if(isDefined(self.target_getindexoftarget)) {
    var_07 = self.target_getindexoftarget.angles[1];
  } else {
    var_07 = self.angles[1];
  }

  if(self.unittype != "c6" && isDefined(var_04[param_01])) {
    var_07 = var_07 + var_04[param_01];
  }

  self orientmode("face angle", var_07);
  lib_0A1E::func_231F(param_00, param_01);
}

func_10054(param_00, param_01, param_02, param_03) {
  var_04 = lib_0A1E::func_235D(param_02);
  var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_02, var_04);
  var_06 = getmovedelta(var_05);
  var_07 = lengthsquared(var_06);
  var_08 = distancesquared(self.origin, self.var_1198.shufflenode.origin);
  return var_07 <= var_08 + 1;
}

func_FFB5(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_1198.shufflenode)) {
    return 1;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 1;
  }

  if(self.var_1198.shufflenode != self.target_getindexoftarget) {
    return 1;
  }

  return 0;
}

func_FFCA(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03) && self.var_1198.shufflenode.type != param_03) {
    return 0;
  }

  var_04 = lib_0A1E::func_235D(param_02);
  var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_02, var_04);
  var_06 = self.var_1198.shufflenode.origin - self.origin;
  var_07 = vectornormalize(var_06);
  var_08 = getmovedelta(var_05, 0, 1);
  var_09 = length(var_08);
  var_0A = self.var_1198.shufflenode.origin - var_07 * var_09;
  var_06 = var_0A - self.origin;
  var_0B = self.var_1198.shufflenode.origin - self.var_1198.var_1016B.origin;
  var_0B = (var_0B[0], var_0B[1], 0);
  if(vectordot(var_0B, var_06) < 0) {
    return 1;
  }

  return 0;
}

func_D518(param_00, param_01, param_02, param_03) {
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = param_01;
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  var_05 = getmovedelta(var_04);
  var_06 = getangledelta3d(var_04);
  if(isDefined(self.var_1198.shufflenode)) {
    var_07 = self.var_1198.shufflenode;
  } else {
    var_07 = self.target_getindexoftarget;
  }

  if(isDefined(var_07)) {
    var_08 = (0, scripts\asm\shared_utility::getnodeforwardyaw(var_07), 0);
    var_09 = combineangles(var_08, invertangles(var_06));
    var_0A = var_07.origin - rotatevector(var_05, var_09);
  } else {
    var_0A = self.origin;
    var_09 = self.angles;
  }

  self _meth_8396(var_0A, var_09[1]);
  lib_0A1E::func_231F(param_00, param_01);
}

func_D519(param_00, param_01, param_02) {
  self.var_1198.shufflenode = undefined;
  self.var_1198.var_1016B = undefined;
}

func_4742(param_00, param_01, param_02, param_03) {
  func_CEFC(param_00, param_01, param_02, param_03);
}

func_4700(param_00, param_01, param_02, param_03) {
  self.var_3135.var_C2.var_46FF = undefined;
  var_04 = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
  var_05 = level.asm[param_00].states[param_02];
  var_06 = scripts\engine\utility::array_randomize(var_05.transitions);
  var_07 = undefined;
  foreach(var_09 in var_06) {
    var_07 = var_09.var_100B1;
    if(var_07 == "up") {
      break;
    }

    var_0A = scripts\anim\utility_common::getcover3dnodeoffset(self.target_getindexoftarget, var_07);
    var_0B = self.target_getindexoftarget.origin + var_0A;
    if(sighttracepassed(var_0B, var_04, 0, undefined)) {
      break;
    }
  }

  self.var_3135.var_C2.var_46FF = param_00 + "_" + param_02 + "_" + var_07;
  return 1;
}

func_46FE(param_00, param_01, param_02, param_03) {
  var_04 = param_00 + "_" + param_01 + "_" + param_03;
  return var_04 == self.var_3135.var_C2.var_46FF;
}