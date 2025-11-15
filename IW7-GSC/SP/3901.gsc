/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3901.gsc
************************/

func_3E96(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    var_03 = lib_0A1E::func_235D(param_01);
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  }

  var_04 = undefined;
  var_05 = scripts\asm\asm_bb::func_2928(var_03);
  if(isDefined(var_05)) {
    var_03 = lib_0A1E::func_235D(param_02, var_05);
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_05);
  } else {
    var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, var_03);
  }

  return var_04;
}

func_3EB6(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_getdemeanor();
  if(!scripts\asm\asm::asm_hasalias(param_01, var_03)) {
    return func_3E96(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_3EB3(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_03, "idle")) {
    var_04 = scripts\asm\asm::asm_getdemeanoranimoverride(var_03, "idle");
    if(isarray(var_04)) {
      return var_04[randomint(var_04.size)];
    }

    return var_04;
  }

  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Stand") {
    var_05 = self.target_getindexoftarget _meth_8169();
    var_06 = 1;
    for(var_07 = 0; var_07 < var_05.size; var_07++) {
      if(var_05[var_07] == "over") {
        var_06 = 0;
      }
    }

    if(var_06) {
      var_03 = var_03 + "_high";
    }
  }

  return func_3EAB(param_01, param_02, var_03);
}

func_3EA1(param_00, param_01, param_02) {
  param_02 = "";
  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Stand") {
    var_03 = self.target_getindexoftarget _meth_8169();
    var_04 = 1;
    for(var_05 = 0; var_05 < var_03.size; var_05++) {
      if(var_03[var_05] == "over") {
        var_04 = 0;
      }
    }

    if(var_04) {
      param_02 = param_02 + "_high";
    }
  }

  return func_3EAB(param_00, param_01, param_02);
}

func_3EAB(param_00, param_01, param_02) {
  var_03 = weaponclass(self.var_394);
  var_04 = undefined;
  if(!isDefined(param_02)) {
    var_04 = lib_0A1E::func_235D(param_01);
  } else {
    var_04 = param_02;
  }

  if(!scripts\asm\asm::asm_hasalias(param_01, var_03 + var_04)) {
    var_03 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03 + var_04);
}

func_B050(param_00, param_01, param_02, param_03) {
  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

func_CEA8(param_00, param_01, param_02, param_03) {
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_CEDA(param_00, param_01, param_02, param_03) {
  self playSound(param_03);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_CEA1(param_00, param_01, param_02, param_03) {
  lib_0A1E::func_2361(param_00, param_01, param_02);
}

func_CEA0(param_00, param_01, param_02, param_03) {
  lib_0A1E::func_2363(param_00, param_01, param_02);
}

func_CECD(param_00, param_01, param_02, param_03) {
  childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_D4DD(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread func_136B4(param_00, param_01, param_03);
  thread func_136E7(param_00, param_01, param_03);
  var_04 = 1;
  scripts\asm\asm::asm_updatefrantic();
  lib_0A1E::func_235F(param_00, param_01, param_02, var_04, 1);
  scripts\asm\asm::asm_updatefrantic();
}

func_D4E0(param_00, param_01, param_02, param_03) {
  if(self pathdisttogoal() > 64) {
    self.var_36C = 1;
  }

  func_D4DD(param_00, param_01, param_02, param_03);
}

func_D4E1(param_00, param_01, param_02) {
  self.var_36C = 0;
}

func_D4E2(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread func_136B4(param_00, param_01, param_03);
  thread func_136E7(param_00, param_01, param_03);
  var_04 = 1;
  scripts\asm\asm::asm_updatefrantic();
  func_2360(param_00, param_01, param_02, var_04, 1);
  scripts\asm\asm::asm_updatefrantic();
}

func_2360(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_05, param_02);
  if(isDefined(param_04) && param_04) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_06 = lib_0A1E::func_2356("Knobs", "move");
      self _meth_84F2(var_06);
    }
  }

  var_07 = var_05;
  var_08 = param_03;
  var_09 = lib_0A1E::func_2355();
  var_0A = scripts\asm\asm::asm_lookupanimfromalias(param_01, "one_hand_run");
  for(;;) {
    var_0B = 3;
    var_0C = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
    var_0D = var_0C;
    if(isarray(var_0D) && var_0D.size == 4) {
      if((isDefined(self.asm.movementgunposeoverride) && self.asm.movementgunposeoverride == "run_gun_down") || isDefined(var_09) && var_09) {
        var_0D = var_0C[3];
        self.asm.var_13CAF = 1;
        self.asm.movementgunposeoverride = undefined;
      } else if((scripts\engine\utility::cointoss() && var_0A != var_0C[2]) || var_0A == var_0C[0]) {
        if(var_0A == var_0C[3]) {
          var_0D = var_0C[0];
          var_0B = 1;
          self.asm.var_13CAF = 0;
        } else {
          var_0D = var_0C[1];
          self.asm.var_13CAF = 0;
        }
      } else if(var_0A == var_0C[1]) {
        var_0D = var_0C[2];
        var_0B = 1;
        self.asm.var_13CAF = 1;
      } else {
        var_0D = var_0C[3];
        self.asm.var_13CAF = 1;
      }
    }

    if(isDefined(param_04) && param_04) {
      param_03 = scripts\asm\asm::asm_getmoveplaybackrate();
      self _meth_84F1(param_03);
    }

    if(var_0D != var_07 || param_03 != var_08) {
      self give_left_powers(param_01, var_0D, 1, param_02, param_03);
      var_08 = param_03;
    }

    lib_0A1E::func_2369(param_00, param_01, var_0D);
    var_07 = var_0D;
    var_0A = var_0D;
    for(var_0E = 0; var_0E < var_0B; var_0E++) {
      wait(0.05);
      lib_0A1E::func_231F(param_00, param_01, undefined, scripts\asm\asm::func_2341(param_00, param_01));
    }
  }
}

func_4EA8(param_00) {
  self notify("debug_anim_time");
  self endon("debug_anim_time");
  for(;;) {
    var_01 = self getscoreinfocategory(param_00);
    wait(0.05);
  }
}

func_13D08(param_00, param_01) {
  var_02 = [];
  var_03 = undefined;
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = self getscoreinfocategory(var_04);
  var_06 = getnotetracktimes(var_04, "footstep_left_small");
  var_07 = getnotetracktimes(var_04, "footstep_right_small");
  var_08 = getnotetracktimes(var_04, "footstep_left_large");
  var_09 = getnotetracktimes(var_04, "footstep_left_large");
  var_0A = self.asm.footsteps.foot;
  if(var_0A == "right") {
    if(var_07.size > 0) {
      var_02 = func_3711(var_07, var_06, var_05);
    } else if(var_09.size > 0) {
      var_02 = func_3711(var_09, var_08, var_05);
    }
  } else if(var_06.size > 0) {
    var_02 = func_3711(var_06, var_07, var_05);
  } else if(var_08.size > 0) {
    var_02 = func_3711(var_08, var_09, var_05);
  }

  if(var_02.size == 0) {
    var_0B = var_04 + " is missing footstep notetracks!Footmatching failed.";
    return;
  }

  if(var_02[0] == 0) {
    var_03 = 0;
  }

  if(var_02[1] == 1) {
    var_03 = 1;
  }

  if(var_02[0] != 0 && var_02[1] != 1) {
    var_03 = var_02[0] + var_02[1] / 2;
  }

  if(var_03 < var_05) {
    if(var_0A == "right") {
      self.asm.footsteps.foot = "left";
      return;
    }

    self.asm.footsteps.foot = "right";
    return;
  }
}

func_3711(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(param_00[var_04] <= param_02) {
      var_03[0] = param_00[var_04];
    }
  }

  if(var_03.size < 1) {
    var_03[0] = 0;
  }

  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(param_01[var_04] >= var_03[0]) {
      var_03[1] = param_01[var_04];
      break;
    }
  }

  if(var_03.size < 2) {
    var_03[1] = 1;
  }

  return var_03;
}

func_136B4(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self.print3d = 1;
  self waittill("cover_approach", var_03);
  scripts\asm\asm::asm_fireevent(param_01, "cover_approach", var_03);
  self.a.var_20EE = var_03;
}

func_136E7(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self waittill("path_changed", var_03, var_04, var_05, var_06);
  var_07 = [var_03, var_04, var_05, var_06];
  scripts\asm\asm::asm_fireevent(param_01, "sharp_turn", var_07);
  thread func_136E7(param_00, param_01, param_02);
  thread scripts\asm\asm::func_2310(param_00, param_01, 0);
}

func_444B(param_00) {
  self notify("StopCommitToAction");
  self.var_1198.var_444A = 1;
  thread func_444C(param_00);
}

func_444C(param_00) {
  self endon("death");
  self endon("StopCommitToAction");
  self waittill(param_00 + "_finished");
  self.var_1198.var_444A = 0;
}

func_11065() {
  self notify("StopCommitToAction");
  self.var_1198.var_444A = 0;
}

handlenotetrack(param_00, param_01) {
  switch (param_00) {
    case "start_aim":
      lib_0A1E::func_2380(undefined, param_01, 0.3);
      break;
  }
}

func_6D6D(param_00, param_01, param_02) {
  scripts\asm\asm::asm_fireevent(param_01, param_02);
}

func_10033(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return 0;
  }

  if(param_03[0]) {
    if(self.a.movement == "stop") {
      return 0;
    }

    if(!scripts\asm\asm_bb::bb_moverequested()) {
      return 0;
    }
  } else if(scripts\asm\asm_bb::bb_moverequested() && self.a.movement != "stop") {
    return 0;
  }

  if(param_03[1] != self.var_1198.movetype) {
    return 0;
  }

  return 1;
}

func_FFB6(param_00, param_01, param_02, param_03) {
  if(!func_100A3(param_00, param_01, param_02, param_03)) {
    return 1;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 1;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested(param_00, param_01, param_02, param_03)) {
    return 1;
  }

  return 0;
}

func_6A7B(param_00, param_01, param_02, param_03) {
  var_04 = abs(angleclamp180(vectortoyaw(self.setocclusionpreset) - self.angles[1]));
  return self.livestreamingenable && var_04 <= self.var_129AF;
}

func_100A3(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.livestreamingenable && !self.var_1198.alwaysrunforward;
}

func_1FCB(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.a.movement = "run";
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_1FCC(param_00, param_01, param_02) {
  self orientmode("face angle 3d", self.angles);
}

func_236F() {
  self.bpowerdown = 1;
}

func_2370() {
  self.bpowerdown = undefined;
}

func_138E2() {
  return self.a.pose == "crouch";
}

func_22EA() {
  self waittill(self.a.var_22E5 + "_finished");
}

func_7DD6() {
  if(isDefined(self.physics_querypoint) && !self _meth_858D()) {
    return self.physics_querypoint;
  }

  if(isDefined(self.target_getindexoftarget)) {
    return self.target_getindexoftarget;
  }

  if(isDefined(self.weaponmaxdist) && isDefined(self.vehicle_getspawnerarray) && distance2dsquared(self.weaponmaxdist.origin, self.vehicle_getspawnerarray) < 36) {
    return self.weaponmaxdist;
  }

  if(isDefined(self.var_A906)) {
    return self.var_A906;
  }

  return self.var_A905;
}

func_3ECB(param_00, param_01) {
  return int(param_01.origin[0] + param_01.origin[1] + param_01.origin[2] + param_00 getentitynumber()) % 2;
}

func_9D4C(param_00, param_01, param_02, param_03) {
  var_04 = param_03;
  if(isDefined(self.asm.var_4C86.var_22F1)) {
    return var_04 == "Custom";
  }

  var_05 = func_7DD6();
  if(!isDefined(var_05) || !isDefined(var_05.type) || var_05.type == "struct") {
    if(scripts\engine\utility::actor_is3d()) {
      return var_04 == "Exposed 3D";
    } else {
      return var_04 == "Exposed";
    }
  }

  var_06 = scripts\asm\asm::asm_getdemeanor();
  var_07 = (!isnode(var_05) || var_05 getrandomattachments("stand")) && self getteleportlonertargetplayer("stand");
  var_08 = (!isnode(var_05) || var_05 getrandomattachments("crouch")) && self getteleportlonertargetplayer("crouch") && var_06 != "casual" && var_06 != "casual_gun";
  if(param_00 == "zero_gravity_space") {
    switch (var_04) {
      case "Exposed 3D":
        return scripts\engine\utility::isnodeexposed3d(var_05) && var_07;

      case "Cover 3D":
        return var_05.type == "Cover 3D";

      case "Cover Stand 3D":
        return scripts\asm\shared_utility::func_C04B(var_05);

      case "Cover Exposed 3D":
        return scripts\asm\shared_utility::func_C04A(var_05);

      case "Exposed Crouch":
      case "Cover Right Crouch":
      case "Cover Left Crouch":
      case "Exposed":
      case "Cover Prone":
      case "Path":
      case "Cover Crouch":
      case "Cover Right":
      case "Cover Left":
        break;
    }
  } else if(param_00 == "zero_gravity") {
    switch (var_04) {
      case "Exposed":
        return (var_05.type == "Path" || var_05.type == "Exposed") && var_07;

      case "Exposed Crouch":
        return (var_05.type == "Path" || var_05.type == "Exposed") && var_08;

      case "Cover Crouch":
        return var_05.type == "Cover Crouch" || var_05.type == "Conceal Crouch";

      case "Cover Stand":
        return var_05.type == "Cover Stand" || var_05.type == "Conceal Stand";

      case "Cover Right Crouch":
      case "Cover Left Crouch":
      case "Cover Prone":
      case "Cover Right":
      case "Cover Left":
        break;
    }
  } else {
    switch (var_04) {
      case "Exposed":
        if(var_05.type != "Path" && var_05.type != "Exposed") {
          return 0;
        }

        if(var_08 && func_3ECB(self, var_05)) {
          return 0;
        }
        return var_07;

      case "Exposed Crouch":
        if(var_05.type != "Path" && var_05.type != "Exposed") {
          return 0;
        }

        if(var_07 && !func_3ECB(self, var_05)) {
          return 0;
        }
        return var_08;

      case "Cover Crouch":
        return var_05.type == "Cover Crouch" || var_05.type == "Conceal Crouch" || var_05.type == "Cover Crouch Window";

      case "Cover Stand":
        return var_05.type == "Cover Stand" || var_05.type == "Conceal Stand";

      case "Cover Prone":
        return var_05.type == "Cover Prone" || var_05.type == "Conceal Prone";

      case "Cover Left":
        if(var_05.type != "Cover Left") {
          return 0;
        }

        if(var_08 && func_3ECB(self, var_05)) {
          return 0;
        }
        return var_07;

      case "Cover Left Crouch":
        if(var_05.type != "Cover Left") {
          return 0;
        }

        if(var_07 && !func_3ECB(self, var_05)) {
          return 0;
        }
        return var_08;

      case "Cover Right":
        if(var_05.type != "Cover Right") {
          return 0;
        }

        if(var_08 && func_3ECB(self, var_05)) {
          return 0;
        }
        return var_07;

      case "Cover Right Crouch":
        if(var_05.type != "Cover Right") {
          return 0;
        }

        if(var_07 && !func_3ECB(self, var_05)) {
          return 0;
        }
        return var_08;

      case "Cover Crouch LMG":
        return (var_05.type == "Cover Crouch" || var_05.type == "Cover Prone") && scripts\asm\shared_utility::func_1C9C();

      case "Cover Stand LMG":
        return var_05.type == "Cover Stand" && scripts\asm\shared_utility::func_1C9C();
    }
  }

  return var_04 == var_05.type;
}

func_C057(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.var_ED88) && isDefined(param_00.angles)) {
    return 1;
  }

  if(isstruct(param_00)) {
    return 0;
  }

  return isDefined(param_00.type) && param_00.type != "Path" && !scripts\engine\utility::isnodeexposed3d(param_00);
}

func_CEC0(param_00, param_01, param_02) {
  var_03 = lib_0A1E::func_2356(param_01, "add_fire");
  self clearanim(var_03, 0.2);
  self shootstopsound();
}

func_CEC1(param_00, param_01, param_02) {
  var_03 = lib_0A1E::func_2356(param_01, "add_idle");
  self clearanim(var_03, 0.2);
  self shootstopsound();
}

func_FE7E(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
    var_04 = scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7);
    return !scripts\asm\asm::func_232B(var_04, "start_aim");
  }

  return 0;
}

func_FE6B(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
    return 1;
  }

  var_04 = scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7);
  return scripts\asm\asm::func_232B(var_04, "start_aim");
}

func_5122(param_00, param_01, param_02, param_03) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(param_00);
  setslowmotion(param_01, param_02, param_03);
}

func_510F(param_00, param_01, param_02) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(param_00);
  level.player _meth_81DE(param_01, param_02);
}

func_5103(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(param_00);
  scripts\sp\art::func_583F(param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_50E8(param_00) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(param_00);
  scripts\sp\art::func_583D(0.5);
}

func_108F6() {
  var_00 = spawn("script_model", level.player.origin);
  var_00.var_E6E5 = % root;
  var_00 setModel("viewmodel_base_viewhands_iw7");
  var_00 glinton(#animtree);
  var_00 hide();
  return var_00;
}

func_D394(param_00) {
  level.player scripts\sp\utility::func_1C34(0);
  if(!isDefined(param_00)) {
    level.player getradiuspathsighttestnodes();
    level.player disableusability();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(param_00 == "seeker") {
    level.player getradiuspathsighttestnodes();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(param_00 == "crawlmelee") {
    level.player disableusability();
    level.player allowstand(0);
    level.player allowcrouch(1);
    level.player allowprone(0);
  }

  level.player allowoffhandshieldweapons(0);
  level.player getrawbaseweaponname(0.2, 0.5);
}

func_D3D2() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableweapons();
  level.player allowoffhandshieldweapons(1);
  level.player _meth_80A6();
  level.player enableusability();
  level.player scripts\sp\utility::func_1C34(1);
}

func_D3A3() {
  self endon("death");
  wait(0.2);
  var_00 = 3;
  var_01 = gettime() + var_00 * 1000;
  self.var_8CAE.alpha = self.var_8CAE.alpha + 1 - level.player.var_8CAE.alpha * 0.8;
  self.var_8CAE fadeovertime(3);
  self.var_8CAE.alpha = 0;
  while(gettime() < var_01) {
    if(self.health <= 0 || getdvarint("cg_useplayerbreathsys")) {
      return;
    }

    if(isDefined(self.var_550A) && self.var_550A) {
      continue;
    }

    if(isDefined(level.var_7684)) {
      [
        [level.var_7684]
      ]("breathing_hurt");
    } else {
      self playlocalsound("breathing_hurt");
    }

    var_02 = 0.1;
    wait(var_02 + randomfloat(0.8));
  }
}

func_B575(param_00, param_01) {
  if(isDefined(self.var_B623) && self.var_B623) {
    return 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    if(!isDefined(level.var_B5F7)) {
      return 1;
    }

    if(!isDefined(level.var_B5F7[param_00])) {
      return 1;
    }

    return gettime() > level.var_B5F7[param_00];
  }

  if(!isDefined(level.var_B5F8)) {
    return 1;
  }

  if(!isDefined(level.var_B5F8[param_00])) {
    return 1;
  }

  return gettime() > level.var_B5F8[param_00];
}

func_B60F() {
  self.var_87F6 = 0;
  self.melee.var_9904 = 1;
  if(isDefined(anim)) {
    if(isplayer(self.melee.target)) {
      level.var_B5F7[self.unittype] = gettime() + level.var_B5F6[self.unittype];
      return;
    }

    level.var_B5F8[self.unittype] = gettime() + level.var_B5F5[self.unittype];
  }
}

func_B611(param_00) {
  level.player endon("meleegrab_interupt");
  level.player endon("bt_stop_meleegrab");
  var_01 = 0.5;
  var_02 = gettime();
  var_03 = param_00 - var_01;
  var_04 = var_02 + var_03 * 1000;
  var_05 = param_00;
  var_06 = var_02 + var_05 * 1000;
  thread func_B618(var_03, var_05);
  thread func_B610(var_03, var_01);
  while(func_D377()) {
    wait(0.05);
  }

  for(;;) {
    var_02 = gettime();
    if(var_02 >= var_06) {
      break;
    }

    if(func_D377()) {
      if(var_02 > var_04 && var_02 < var_06) {
        if(isDefined(self.melee.var_B5FE)) {
          level.player thread func_46B5(0.1);
        }

        self.melee.var_46B6 = 1;
        level.player notify("bt_meleegrab_slowmo");
        return;
      }
    }

    wait(0.05);
  }

  level.player notify("bt_meleegrab_slowmo");
}

func_B618(param_00, param_01) {
  level.player endon("meleegrab_interupt");
  wait(param_00);
  setslowmotion(1, 0.3, 0.1);
  if(!isDefined(self.melee.var_46B6)) {
    level.player waittill("bt_meleegrab_slowmo");
  } else {
    wait(0.05);
  }

  setslowmotion(0.2, 1, 0.05);
}

func_D377() {
  return isalive(level.player) && level.player meleebuttonpressed();
}

func_B610(param_00, param_01) {
  level.player endon("meleegrab_interupt");
  var_02 = 0.2;
  var_03 = 0.3;
  wait(param_00 - var_02 - 0.05);
  if(isDefined(self.melee.var_B5FE)) {
    self.melee.var_B5FE destroy();
  }

  self.melee.var_B5FE = newclienthudelem(level.player);
  self.melee.var_B5FE.color = (1, 1, 1);
  self.melee.var_B5FE settext( & "SCRIPT_PLATFORM_HINT_MELEE_COUNTER");
  self.melee.var_B5FE.x = 0;
  self.melee.var_B5FE.y = 20;
  self.melee.var_B5FE.alignx = "center";
  self.melee.var_B5FE.aligny = "middle";
  self.melee.var_B5FE.horzalign = "center";
  self.melee.var_B5FE.vertalign = "middle";
  self.melee.var_B5FE.foreground = 1;
  self.melee.var_B5FE.alpha = 0;
  self.melee.var_B5FE.fontscale = 0.5;
  self.melee.var_B5FE.playrumblelooponposition = 1;
  self.melee.var_B5FE.sort = -1;
  self.melee.var_B5FE endon("death");
  self.melee.var_B5FE fadeovertime(var_02);
  self.melee.var_B5FE changefontscaleovertime(var_02);
  self.melee.var_B5FE.fontscale = 1.3;
  self.melee.var_B5FE.alpha = 1;
  wait(var_02);
  if(!isDefined(self.melee.var_B5FE)) {
    return;
  }

  self.melee.var_B5FE fadeovertime(var_03);
  self.melee.var_B5FE changefontscaleovertime(var_03);
  self.melee.var_B5FE.fontscale = 1.2;
}

func_B642(param_00, param_01, param_02, param_03) {
  return isDefined(level.player.melee.var_46B6);
}

func_B5FC(param_00, param_01, param_02, param_03) {
  return isDefined(level.player.melee.var_46B6) && level.player.melee.var_46B6;
}

func_B5FD(param_00, param_01, param_02, param_03) {
  return isDefined(level.player.melee.var_46B6) && !level.player.melee.var_46B6;
}

func_46B5(param_00) {
  if(isDefined(param_00)) {
    level.player.melee.var_B5FE fadeovertime(param_00);
    level.player.melee.var_B5FE changefontscaleovertime(param_00);
    level.player.melee.var_B5FE.fontscale = 2;
    level.player.melee.var_B5FE.alpha = 0;
    wait(param_00);
  }

  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_B5FE)) {
    level.player.melee.var_B5FE destroy();
  }
}