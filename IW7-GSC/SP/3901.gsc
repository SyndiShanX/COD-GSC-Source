/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3901.gsc
*********************************************/

func_3E96(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = lib_0A1E::func_235D(var_1);
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

  var_4 = undefined;
  var_5 = scripts\asm\asm_bb::func_2928(var_3);
  if(isDefined(var_5)) {
    var_3 = lib_0A1E::func_235D(var_2, var_5);
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
  } else {
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_3);
  }

  return var_4;
}

func_3EB6(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    return func_3E96(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3EB3(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "idle")) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "idle");
    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    var_5 = self.node func_8169();
    var_6 = 1;
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(var_5[var_7] == "over") {
        var_6 = 0;
      }
    }

    if(var_6) {
      var_3 = var_3 + "_high";
    }
  }

  return func_3EAB(var_1, var_2, var_3);
}

func_3EA1(var_0, var_1, var_2) {
  var_2 = "";
  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    var_3 = self.node func_8169();
    var_4 = 1;
    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(var_3[var_5] == "over") {
        var_4 = 0;
      }
    }

    if(var_4) {
      var_2 = var_2 + "_high";
    }
  }

  return func_3EAB(var_0, var_1, var_2);
}

func_3EAB(var_0, var_1, var_2) {
  var_3 = weaponclass(self.weapon);
  var_4 = undefined;
  if(!isDefined(var_2)) {
    var_4 = lib_0A1E::func_235D(var_1);
  } else {
    var_4 = var_2;
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3 + var_4)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + var_4);
}

func_B050(var_0, var_1, var_2, var_3) {
  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

func_CEA8(var_0, var_1, var_2, var_3) {
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_CEDA(var_0, var_1, var_2, var_3) {
  self playSound(var_3);
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_CEA1(var_0, var_1, var_2, var_3) {
  lib_0A1E::func_2361(var_0, var_1, var_2);
}

func_CEA0(var_0, var_1, var_2, var_3) {
  lib_0A1E::func_2363(var_0, var_1, var_2);
}

func_CECD(var_0, var_1, var_2, var_3) {
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_D4DD(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread func_136B4(var_0, var_1, var_3);
  thread func_136E7(var_0, var_1, var_3);
  var_4 = 1;
  scripts\asm\asm::asm_updatefrantic();
  lib_0A1E::func_235F(var_0, var_1, var_2, var_4, 1);
  scripts\asm\asm::asm_updatefrantic();
}

func_D4E0(var_0, var_1, var_2, var_3) {
  if(self pathdisttogoal() > 64) {
    self.var_36C = 1;
  }

  func_D4DD(var_0, var_1, var_2, var_3);
}

func_D4E1(var_0, var_1, var_2) {
  self.var_36C = 0;
}

func_D4E2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread func_136B4(var_0, var_1, var_3);
  thread func_136E7(var_0, var_1, var_3);
  var_4 = 1;
  scripts\asm\asm::asm_updatefrantic();
  func_2360(var_0, var_1, var_2, var_4, 1);
  scripts\asm\asm::asm_updatefrantic();
}

func_2360(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_5, var_2);
  if(isDefined(var_4) && var_4) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_6 = lib_0A1E::func_2356("Knobs", "move");
      self func_84F2(var_6);
    }
  }

  var_7 = var_5;
  var_8 = var_3;
  var_9 = lib_0A1E::func_2355();
  var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "one_hand_run");
  for(;;) {
    var_11 = 3;
    var_12 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
    var_13 = var_12;
    if(isarray(var_13) && var_13.size == 4) {
      if((isDefined(self.asm.movementgunposeoverride) && self.asm.movementgunposeoverride == "run_gun_down") || isDefined(var_9) && var_9) {
        var_13 = var_12[3];
        self.asm.var_13CAF = 1;
        self.asm.movementgunposeoverride = undefined;
      } else if((scripts\engine\utility::cointoss() && var_10 != var_12[2]) || var_10 == var_12[0]) {
        if(var_10 == var_12[3]) {
          var_13 = var_12[0];
          var_11 = 1;
          self.asm.var_13CAF = 0;
        } else {
          var_13 = var_12[1];
          self.asm.var_13CAF = 0;
        }
      } else if(var_10 == var_12[1]) {
        var_13 = var_12[2];
        var_11 = 1;
        self.asm.var_13CAF = 1;
      } else {
        var_13 = var_12[3];
        self.asm.var_13CAF = 1;
      }
    }

    if(isDefined(var_4) && var_4) {
      var_3 = scripts\asm\asm::asm_getmoveplaybackrate();
      self func_84F1(var_3);
    }

    if(var_13 != var_7 || var_3 != var_8) {
      self give_left_powers(var_1, var_13, 1, var_2, var_3);
      var_8 = var_3;
    }

    lib_0A1E::func_2369(var_0, var_1, var_13);
    var_7 = var_13;
    var_10 = var_13;
    for(var_14 = 0; var_14 < var_11; var_14++) {
      wait(0.05);
      lib_0A1E::func_231F(var_0, var_1, undefined, scripts\asm\asm::func_2341(var_0, var_1));
    }
  }
}

func_4EA8(var_0) {
  self notify("debug_anim_time");
  self endon("debug_anim_time");
  for(;;) {
    var_1 = self getscoreinfocategory(var_0);
    wait(0.05);
  }
}

func_13D08(var_0, var_1) {
  var_2 = [];
  var_3 = undefined;
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self getscoreinfocategory(var_4);
  var_6 = getnotetracktimes(var_4, "footstep_left_small");
  var_7 = getnotetracktimes(var_4, "footstep_right_small");
  var_8 = getnotetracktimes(var_4, "footstep_left_large");
  var_9 = getnotetracktimes(var_4, "footstep_left_large");
  var_10 = self.asm.footsteps.foot;
  if(var_10 == "right") {
    if(var_7.size > 0) {
      var_2 = func_3711(var_7, var_6, var_5);
    } else if(var_9.size > 0) {
      var_2 = func_3711(var_9, var_8, var_5);
    }
  } else if(var_6.size > 0) {
    var_2 = func_3711(var_6, var_7, var_5);
  } else if(var_8.size > 0) {
    var_2 = func_3711(var_8, var_9, var_5);
  }

  if(var_2.size == 0) {
    var_11 = var_4 + " is missing footstep notetracks!Footmatching failed.";
    return;
  }

  if(var_2[0] == 0) {
    var_3 = 0;
  }

  if(var_2[1] == 1) {
    var_3 = 1;
  }

  if(var_2[0] != 0 && var_2[1] != 1) {
    var_3 = var_2[0] + var_2[1] / 2;
  }

  if(var_3 < var_5) {
    if(var_10 == "right") {
      self.asm.footsteps.foot = "left";
      return;
    }

    self.asm.footsteps.foot = "right";
    return;
  }
}

func_3711(var_0, var_1, var_2) {
  var_3 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(var_0[var_4] <= var_2) {
      var_3[0] = var_0[var_4];
    }
  }

  if(var_3.size < 1) {
    var_3[0] = 0;
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] >= var_3[0]) {
      var_3[1] = var_1[var_4];
      break;
    }
  }

  if(var_3.size < 2) {
    var_3[1] = 1;
  }

  return var_3;
}

func_136B4(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.print3d = 1;
  self waittill("cover_approach", var_3);
  scripts\asm\asm::asm_fireevent(var_1, "cover_approach", var_3);
  self.a.var_20EE = var_3;
}

func_136E7(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self waittill("path_changed", var_3, var_4, var_5, var_6);
  var_7 = [var_3, var_4, var_5, var_6];
  scripts\asm\asm::asm_fireevent(var_1, "sharp_turn", var_7);
  thread func_136E7(var_0, var_1, var_2);
  thread scripts\asm\asm::func_2310(var_0, var_1, 0);
}

func_444B(var_0) {
  self notify("StopCommitToAction");
  self._blackboard.var_444A = 1;
  thread func_444C(var_0);
}

func_444C(var_0) {
  self endon("death");
  self endon("StopCommitToAction");
  self waittill(var_0 + "_finished");
  self._blackboard.var_444A = 0;
}

func_11065() {
  self notify("StopCommitToAction");
  self._blackboard.var_444A = 0;
}

handlenotetrack(var_0, var_1) {
  switch (var_0) {
    case "start_aim":
      lib_0A1E::func_2380(undefined, var_1, 0.3);
      break;
  }
}

func_6D6D(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireevent(var_1, var_2);
}

func_10033(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return 0;
  }

  if(var_3[0]) {
    if(self.a.movement == "stop") {
      return 0;
    }

    if(!scripts\asm\asm_bb::bb_moverequested()) {
      return 0;
    }
  } else if(scripts\asm\asm_bb::bb_moverequested() && self.a.movement != "stop") {
    return 0;
  }

  if(var_3[1] != self._blackboard.movetype) {
    return 0;
  }

  return 1;
}

func_FFB6(var_0, var_1, var_2, var_3) {
  if(!func_100A3(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 1;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

func_6A7B(var_0, var_1, var_2, var_3) {
  var_4 = abs(angleclamp180(vectortoyaw(self.setocclusionpreset) - self.angles[1]));
  return self.livestreamingenable && var_4 <= self.var_129AF;
}

func_100A3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.livestreamingenable && !self._blackboard.alwaysrunforward;
}

func_1FCB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.a.movement = "run";
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_1FCC(var_0, var_1, var_2) {
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
  if(isDefined(self.physics_querypoint) && !self func_858D()) {
    return self.physics_querypoint;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  if(isDefined(self.weaponmaxdist) && isDefined(self.vehicle_getspawnerarray) && distance2dsquared(self.weaponmaxdist.origin, self.vehicle_getspawnerarray) < 36) {
    return self.weaponmaxdist;
  }

  if(isDefined(self.var_A906)) {
    return self.var_A906;
  }

  return self.var_A905;
}

func_3ECB(var_0, var_1) {
  return int(var_1.origin[0] + var_1.origin[1] + var_1.origin[2] + var_0 getentitynumber()) % 2;
}

func_9D4C(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  if(isDefined(self.asm.var_4C86.var_22F1)) {
    return var_4 == "Custom";
  }

  var_5 = func_7DD6();
  if(!isDefined(var_5) || !isDefined(var_5.type) || var_5.type == "struct") {
    if(scripts\engine\utility::actor_is3d()) {
      return var_4 == "Exposed 3D";
    } else {
      return var_4 == "Exposed";
    }
  }

  var_6 = scripts\asm\asm::asm_getdemeanor();
  var_7 = (!isnode(var_5) || var_5 getrandomattachments("stand")) && self getteleportlonertargetplayer("stand");
  var_8 = (!isnode(var_5) || var_5 getrandomattachments("crouch")) && self getteleportlonertargetplayer("crouch") && var_6 != "casual" && var_6 != "casual_gun";
  if(var_0 == "zero_gravity_space") {
    switch (var_4) {
      case "Exposed 3D":
        return scripts\engine\utility::isnodeexposed3d(var_5) && var_7;

      case "Cover 3D":
        return var_5.type == "Cover 3D";

      case "Cover Stand 3D":
        return scripts\asm\shared_utility::func_C04B(var_5);

      case "Cover Exposed 3D":
        return scripts\asm\shared_utility::func_C04A(var_5);

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
  } else if(var_0 == "zero_gravity") {
    switch (var_4) {
      case "Exposed":
        return (var_5.type == "Path" || var_5.type == "Exposed") && var_7;

      case "Exposed Crouch":
        return (var_5.type == "Path" || var_5.type == "Exposed") && var_8;

      case "Cover Crouch":
        return var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch";

      case "Cover Stand":
        return var_5.type == "Cover Stand" || var_5.type == "Conceal Stand";

      case "Cover Right Crouch":
      case "Cover Left Crouch":
      case "Cover Prone":
      case "Cover Right":
      case "Cover Left":
        break;
    }
  } else {
    switch (var_4) {
      case "Exposed":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_8 && func_3ECB(self, var_5)) {
          return 0;
        }
        return var_7;

      case "Exposed Crouch":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_7 && !func_3ECB(self, var_5)) {
          return 0;
        }
        return var_8;

      case "Cover Crouch":
        return var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch" || var_5.type == "Cover Crouch Window";

      case "Cover Stand":
        return var_5.type == "Cover Stand" || var_5.type == "Conceal Stand";

      case "Cover Prone":
        return var_5.type == "Cover Prone" || var_5.type == "Conceal Prone";

      case "Cover Left":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_8 && func_3ECB(self, var_5)) {
          return 0;
        }
        return var_7;

      case "Cover Left Crouch":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_7 && !func_3ECB(self, var_5)) {
          return 0;
        }
        return var_8;

      case "Cover Right":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_8 && func_3ECB(self, var_5)) {
          return 0;
        }
        return var_7;

      case "Cover Right Crouch":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_7 && !func_3ECB(self, var_5)) {
          return 0;
        }
        return var_8;

      case "Cover Crouch LMG":
        return (var_5.type == "Cover Crouch" || var_5.type == "Cover Prone") && scripts\asm\shared_utility::func_1C9C();

      case "Cover Stand LMG":
        return var_5.type == "Cover Stand" && scripts\asm\shared_utility::func_1C9C();
    }
  }

  return var_4 == var_5.type;
}

func_C057(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.var_ED88) && isDefined(var_0.angles)) {
    return 1;
  }

  if(isstruct(var_0)) {
    return 0;
  }

  return isDefined(var_0.type) && var_0.type != "Path" && !scripts\engine\utility::isnodeexposed3d(var_0);
}

func_CEC0(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_2356(var_1, "add_fire");
  self clearanim(var_3, 0.2);
  self shootstopsound();
}

func_CEC1(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_2356(var_1, "add_idle");
  self clearanim(var_3, 0.2);
  self shootstopsound();
}

func_FE7E(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
    var_4 = scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7);
    return !scripts\asm\asm::func_232B(var_4, "start_aim");
  }

  return 0;
}

func_FE6B(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
    return 1;
  }

  var_4 = scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7);
  return scripts\asm\asm::func_232B(var_4, "start_aim");
}

func_5122(var_0, var_1, var_2, var_3) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  setslowmotion(var_1, var_2, var_3);
}

func_510F(var_0, var_1, var_2) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  level.player func_81DE(var_1, var_2);
}

func_5103(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  scripts\sp\art::func_583F(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_50E8(var_0) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  scripts\sp\art::func_583D(0.5);
}

func_108F6() {
  var_0 = spawn("script_model", level.player.origin);
  var_0.var_E6E5 = % root;
  var_0 setModel("viewmodel_base_viewhands_iw7");
  var_0 glinton(#animtree);
  var_0 hide();
  return var_0;
}

func_D394(var_0) {
  level.player scripts\sp\utility::func_1C34(0);
  if(!isDefined(var_0)) {
    level.player getradiuspathsighttestnodes();
    level.player disableusability();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(var_0 == "seeker") {
    level.player getradiuspathsighttestnodes();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(var_0 == "crawlmelee") {
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
  level.player func_80A6();
  level.player enableusability();
  level.player scripts\sp\utility::func_1C34(1);
}

func_D3A3() {
  self endon("death");
  wait(0.2);
  var_0 = 3;
  var_1 = gettime() + var_0 * 1000;
  self.var_8CAE.alpha = self.var_8CAE.alpha + 1 - level.player.var_8CAE.alpha * 0.8;
  self.var_8CAE fadeovertime(3);
  self.var_8CAE.alpha = 0;
  while(gettime() < var_1) {
    if(self.health <= 0 || getdvarint("cg_useplayerbreathsys")) {
      return;
    }

    if(isDefined(self.var_550A) && self.var_550A) {
      continue;
    }

    if(isDefined(level.var_7684)) {
      [[level.var_7684]]("breathing_hurt");
    } else {
      self playlocalsound("breathing_hurt");
    }

    var_2 = 0.1;
    wait(var_2 + randomfloat(0.8));
  }
}

func_B575(var_0, var_1) {
  if(isDefined(self.var_B623) && self.var_B623) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    if(!isDefined(level.var_B5F7)) {
      return 1;
    }

    if(!isDefined(level.var_B5F7[var_0])) {
      return 1;
    }

    return gettime() > level.var_B5F7[var_0];
  }

  if(!isDefined(level.var_B5F8)) {
    return 1;
  }

  if(!isDefined(level.var_B5F8[var_0])) {
    return 1;
  }

  return gettime() > level.var_B5F8[var_0];
}

func_B60F() {
  self.var_87F6 = 0;
  self.melee.var_9904 = 1;
  if(isDefined(anim)) {
    if(isPlayer(self.melee.target)) {
      level.var_B5F7[self.unittype] = gettime() + level.var_B5F6[self.unittype];
      return;
    }

    level.var_B5F8[self.unittype] = gettime() + level.var_B5F5[self.unittype];
  }
}

func_B611(var_0) {
  level.player endon("meleegrab_interupt");
  level.player endon("bt_stop_meleegrab");
  var_1 = 0.5;
  var_2 = gettime();
  var_3 = var_0 - var_1;
  var_4 = var_2 + var_3 * 1000;
  var_5 = var_0;
  var_6 = var_2 + var_5 * 1000;
  thread func_B618(var_3, var_5);
  thread func_B610(var_3, var_1);
  while(func_D377()) {
    wait(0.05);
  }

  for(;;) {
    var_2 = gettime();
    if(var_2 >= var_6) {
      break;
    }

    if(func_D377()) {
      if(var_2 > var_4 && var_2 < var_6) {
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

func_B618(var_0, var_1) {
  level.player endon("meleegrab_interupt");
  wait(var_0);
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

func_B610(var_0, var_1) {
  level.player endon("meleegrab_interupt");
  var_2 = 0.2;
  var_3 = 0.3;
  wait(var_0 - var_2 - 0.05);
  if(isDefined(self.melee.var_B5FE)) {
    self.melee.var_B5FE destroy();
  }

  self.melee.var_B5FE = newclienthudelem(level.player);
  self.melee.var_B5FE.color = (1, 1, 1);
  self.melee.var_B5FE settext(&"SCRIPT_PLATFORM_HINT_MELEE_COUNTER");
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
  self.melee.var_B5FE fadeovertime(var_2);
  self.melee.var_B5FE changefontscaleovertime(var_2);
  self.melee.var_B5FE.fontscale = 1.3;
  self.melee.var_B5FE.alpha = 1;
  wait(var_2);
  if(!isDefined(self.melee.var_B5FE)) {
    return;
  }

  self.melee.var_B5FE fadeovertime(var_3);
  self.melee.var_B5FE changefontscaleovertime(var_3);
  self.melee.var_B5FE.fontscale = 1.2;
}

func_B642(var_0, var_1, var_2, var_3) {
  return isDefined(level.player.melee.var_46B6);
}

func_B5FC(var_0, var_1, var_2, var_3) {
  return isDefined(level.player.melee.var_46B6) && level.player.melee.var_46B6;
}

func_B5FD(var_0, var_1, var_2, var_3) {
  return isDefined(level.player.melee.var_46B6) && !level.player.melee.var_46B6;
}

func_46B5(var_0) {
  if(isDefined(var_0)) {
    level.player.melee.var_B5FE fadeovertime(var_0);
    level.player.melee.var_B5FE changefontscaleovertime(var_0);
    level.player.melee.var_B5FE.fontscale = 2;
    level.player.melee.var_B5FE.alpha = 0;
    wait(var_0);
  }

  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_B5FE)) {
    level.player.melee.var_B5FE destroy();
  }
}