/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1345.gsc
*********************************************/

lib_0541::func_00F9() {
  lib_0541::func_531A();
  lib_0541::func_52A9();
  lib_0541::func_52AA();
  level.var_08D9 = [];
}

lib_0541::func_09C9(param_00, param_01, param_02, param_03, param_04) {
  level.var_65CB[param_00] = [];
  level.var_65CB[param_00][0] = param_01;
  level.var_65CB[param_00][2] = param_02;
  level.var_65CB[param_00][3] = param_03;
  level.var_65CB[param_00][4] = param_04;
}

lib_0541::func_2F92(param_00, param_01) {
  if(!isarray(param_01)) {
    param_01 = [param_01];
  }

  foreach(var_03 in param_01) {
    level.var_65CC[var_03][param_00] = 1;
  }
}

lib_0541::func_531A() {
  level.var_65CB = [];
  lib_0541::func_09C9("crawl", ::lib_0541::func_65C8);
  lib_0541::func_2F92("crawl", ["zombie_heavy", "zombie_fireman", "zombie_exploder", "zombie_berserker"]);
}

lib_0541::func_52A9() {
  lib_0547::func_7BD0("dismemberment_transition", ::lib_0541::func_0EAF, ::lib_0541::func_0EB0, 3);
  level.var_3EFD = 0;
  level.var_2FDE[1]["modelToSpawn"] = "zom_shared_r_arm_slice";
  level.var_2FDE[2]["modelToSpawn"] = "zom_shared_l_arm_slice";
  level.var_2FDE[4]["modelToSpawn"] = "zom_shared_r_leg_slice";
  level.var_2FDE[8]["modelToSpawn"] = "zom_shared_l_leg_slice";
  level.var_2FDE[1]["tagName"] = "J_Shoulder_RI";
  level.var_2FDE[2]["tagName"] = "J_Shoulder_LE";
  level.var_2FDE[4]["tagName"] = "J_Hip_RI";
  level.var_2FDE[8]["tagName"] = "J_Hip_LE";
  level.var_2FDE[16]["tagName"] = "J_Head";
  level.var_2FDE[1]["fxTagName"] = "J_Shoulder_RI";
  level.var_2FDE[2]["fxTagName"] = "J_Shoulder_LE";
  level.var_2FDE[4]["fxTagName"] = "J_Hip_RI";
  level.var_2FDE[8]["fxTagName"] = "J_Hip_LE";
  level.var_2FDE[16]["fxTagName"] = "J_Head";
  level.var_2FDE["full"]["fxTagName"] = "J_MainRoot";
  level.var_2FDE[1]["torsoFX"] = "torso_arm_loss_right";
  level.var_2FDE[2]["torsoFX"] = "torso_arm_loss_left";
  level.var_2FDE[4]["torsoFX"] = "torso_loss_right";
  level.var_2FDE[8]["torsoFX"] = "torso_loss_left";
  level.var_2FDE[16]["torsoFX"] = "torso_head_loss";
  level.var_2FDE[1]["limbFX"] = "arm_loss_right";
  level.var_2FDE[2]["limbFX"] = "arm_loss_left";
  level.var_2FDE[4]["limbFX"] = "limb_loss_right";
  level.var_2FDE[8]["limbFX"] = "limb_loss_left";
  level.var_2FDE[16]["gibFX"] = "head_gibs";
  level.var_2FDE[1]["dismemberSound"] = "zmb_dism_arm";
  level.var_2FDE[2]["dismemberSound"] = "zmb_dism_arm";
  level.var_2FDE[4]["dismemberSound"] = "zmb_dism_leg";
  level.var_2FDE[8]["dismemberSound"] = "zmb_dism_leg";
  level.var_2FDE[16]["dismemberSound"] = "zmb_dism_head";
  level.var_2FDE["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
}

lib_0541::func_52AA() {
  var_00 = "mp/zombieDismembermentModifiers.csv";
  var_01 = 0;
  var_02 = 2;
  var_03 = 3;
  var_04 = 4;
  var_05 = 5;
  var_06 = function_027A(var_00);
  for(var_07 = 0; var_07 < var_06; var_07++) {
    var_08 = tablelookupbyrow(var_00, var_07, var_01);
    var_09 = tablelookupbyrow(var_00, var_07, var_02);
    var_0A = tablelookupbyrow(var_00, var_07, var_03);
    var_0B = tablelookupbyrow(var_00, var_07, var_04);
    var_0C = tablelookupbyrow(var_00, var_07, var_05);
    level.var_2FEA[var_08] = float(var_09);
    level.var_2FEB[var_08] = float(var_0A);
    level.var_4D3D[var_08] = var_0B == "true";
    level.var_2FE9[var_08] = var_0C == "true";
  }
}

lib_0541::func_65C7(param_00) {
  if(!isDefined(level.var_08D9[param_00])) {
    level.var_08D9[param_00] = 0;
  }

  if(!isDefined(self.var_08D9)) {
    self.var_08D9 = [];
  }

  if(isDefined(self.var_08D9[param_00])) {
    return;
  }

  if(isDefined(level.var_65CC[self.var_0A4B])) {
    if(isDefined(level.var_65CC[self.var_0A4B][param_00]) && level.var_65CC[self.var_0A4B][param_00]) {
      return;
    }
  }

  level.var_08D9[param_00]++;
  self.var_08D9[param_00] = 1;
  self[[level.var_65CB[param_00][0]]]();
  if(isDefined(self.var_08D9)) {
    self.var_08D9[param_00] = undefined;
  }

  level.var_08D9[param_00]--;
}

lib_0541::func_9AA4(param_00, param_01) {
  if(isDefined(level.var_0611[param_00 + "_head"])) {
    lib_0547::func_74A5(level.var_0611[param_00 + "_head"], self, "j_head");
  }

  if(isDefined(level.var_0611[param_00 + "_arm_r"])) {
    lib_0547::func_74A5(level.var_0611[param_00 + "_arm_r"], self, "j_shoulder_ri");
  }

  if(isDefined(level.var_0611[param_00 + "_arm_l"])) {
    lib_0547::func_74A5(level.var_0611[param_00 + "_arm_l"], self, "j_shoulder_le");
  }

  if(isDefined(level.var_0611[param_00 + "_back"])) {
    lib_0547::func_74A5(level.var_0611[param_00 + "_back"], self, "j_spineupper");
  }

  if(isDefined(level.var_0611[param_00 + "_spine"])) {
    lib_0547::func_74A5(level.var_0611[param_00 + "_spine"], self, "j_spine4");
  }

  self.var_9AA6 = param_00;
  if(isDefined(param_01)) {
    thread lib_0541::func_9AA5(param_00, param_01);
  }
}

lib_0541::func_9AA5(param_00, param_01) {
  self notify("removeTorsoEffectsDelayed");
  self endon("removeTorsoEffectsDelayed");
  self endon("death");
  if(isDefined(param_01)) {
    wait(param_01);
  }

  if(isDefined(self)) {
    if(isDefined(level.var_0611[param_00 + "_head"])) {
      lib_0547::func_9406(level.var_0611[param_00 + "_head"], self, "j_head");
    }

    if(isDefined(level.var_0611[param_00 + "_arm_r"])) {
      lib_0547::func_9406(level.var_0611[param_00 + "_arm_r"], self, "j_shoulder_ri");
    }

    if(isDefined(level.var_0611[param_00 + "_arm_l"])) {
      lib_0547::func_9406(level.var_0611[param_00 + "_arm_l"], self, "j_shoulder_le");
    }

    if(isDefined(level.var_0611[param_00 + "_back"])) {
      lib_0547::func_9406(level.var_0611[param_00 + "_back"], self, "j_spineupper");
    }

    if(isDefined(level.var_0611[param_00 + "_spine"])) {
      lib_0547::func_9406(level.var_0611[param_00 + "_spine"], self, "j_spine4");
    }
  }
}

lib_0541::func_65C8() {
  lib_0541::func_65D0(12, 0);
}

lib_0541::func_92C5() {
  self.var_2FDA = 1;
  maps\mp\agents\humanoid\_humanoid_util::func_313C();
  if(isDefined(self.var_5F4C)) {
    maps\mp\agents\humanoid\_humanoid_util::func_5F4E(10, 240, 120, "attack_lunge_boost", level.var_0611["boost_lunge"], 1, 255);
  }

  maps\mp\agents\humanoid\_humanoid_util::func_5C51();
  self method_8538(0);
  self method_853C(1);
  self method_83A5(15);
  level.var_2775++;
  thread lib_0547::func_AB18(60);
  self waittill("death");
  level.var_2775--;
}

lib_0541::func_4494(param_00, param_01, param_02) {
  if(lib_0547::func_5731()) {
    return 0;
  }

  var_03 = undefined;
  if(isDefined(param_01)) {
    param_01 = getweapondisplayname(param_01);
    var_03 = param_01;
  } else if(isDefined(param_02)) {
    var_03 = param_02;
  }

  if(!isDefined(var_03)) {
    return 1;
  }

  var_04 = level.var_2FEA[var_03];
  if(isDefined(param_00) && isPlayer(param_00) && isDefined(param_01) && isDefined(var_04) && !maps\mp\_utility::func_5740(param_01)) {
    var_04 = lib_0541::func_21F3(param_00, param_01, var_04);
    return var_04;
  }

  if(isDefined(var_04)) {
    return var_04;
  }

  return 1;
}

lib_0541::func_21F3(param_00, param_01, param_02) {
  var_03 = level.var_2FEB[param_01];
  if(!isDefined(var_03)) {
    return param_02;
  }

  var_04 = lib_0547::func_4747(param_00, param_01);
  if(var_04 <= 1) {
    return param_02;
  }

  var_05 = param_02 - var_03;
  var_06 = param_02 - var_04 / 3 * var_05;
  return clamp(var_06, var_03, param_02);
}

lib_0541::func_4596(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(param_03 >= 1) {
    if(lib_0547::func_21AA("exploder")) {
      return self.var_2FDB;
    }
  }

  var_06 = common_scripts\utility::func_562E(level.var_2FE9[param_01]) || common_scripts\utility::func_562E(level.var_2FE9[param_02]) || lib_0547::func_5731() || issubstr(param_01, "m1911_pap_zm") || issubstr(param_01, "teslagun") || issubstr(param_01, "fliegerfaust_zm") || common_scripts\utility::func_562E(param_01 == "panzerschreck_zm") || issubstr(param_01, "razergun") || common_scripts\utility::func_562E(param_01 == "bazooka_zm") || common_scripts\utility::func_562E(self.luckycrit) || common_scripts\utility::func_562E(param_01 == "island_grenade_hc_zm") || common_scripts\utility::func_562E(param_01 == "jack_in_box_decoy_zm");
  if(param_03 < 1 && lib_0547::func_5565(param_01, "turretweapon_ger_btry_flak38_mp_zombie")) {
    var_06 = 0;
  }

  if(var_06) {
    var_07 = 31;
  } else {
    var_07 = lib_0541::func_5E60(param_01);
  }

  var_08 = 1;
  if(var_07 == 0) {
    return 0;
  }

  if(!isDefined(param_02) || param_02 != "MOD_GRENADE" && param_02 != "MOD_GRENADE_SPLASH" && param_02 != "MOD_EXPLOSIVE") {
    var_07 = var_07 &~12;
  } else if(randomfloat(1) > 0.5) {
    var_07 = 8;
  } else {
    var_07 = 4;
  }

  if(isDefined(level.var_324B) && [[level.var_324B]](self)) {
    var_07 = var_07 &~12;
  }

  var_07 = var_07 &self.var_2FDB;
  var_08 = var_08 * lib_0541::func_4494(param_04, param_01, undefined) * lib_0541::func_4494(param_04, undefined, param_02);
  var_08 = var_08 * -0.7 * param_03 + 1;
  return lib_0541::func_4597(var_07, param_05, param_03, var_08);
}

lib_0541::func_4597(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  if(param_00 &param_00 - 1 > 0) {
    if(param_02 < 1) {
      var_05 = randomint(24);
      var_06 = 228;
      for(var_07 = 4; var_07 > 0; var_07--) {
        var_08 = 1 << var_05 % var_07 * 2;
        var_05 = int(var_05 / var_07);
        var_09 = var_06 % var_08;
        var_0A = int(var_06 / var_08);
        var_06 = var_09 + var_0A >> 2 * var_08;
        var_0B = 1 << var_0A & 3;
        if(param_00 &var_0B != 0 && isDefined(lib_0541::func_18B1(param_01 | var_04 | var_0B))) {
          if(randomfloat(1) > lib_0541::func_20AF(var_0B) * param_03) {
            var_04 = var_04 | var_0B;
          }
        }
      }
    } else {
      while(param_00 > 0) {
        var_0B = param_00 & 0 - param_00;
        if(randomfloat(1) > lib_0541::func_20AF(var_0B) * param_03) {
          var_04 = var_04 | var_0B;
        }

        param_00 = param_00 - var_0B;
      }
    }
  } else if(param_02 >= 1 || isDefined(lib_0541::func_18B1(param_01 | param_00))) {
    if(randomfloat(1) > lib_0541::func_20AF(param_00) * param_03) {
      var_04 = param_00;
    }
  }

  return var_04;
}

lib_0541::func_9E1D(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 0;
  if(isalive(self) && (!maps\mp\agents\_scripted_agent_anim_util::func_57E2() || param_03 >= 1) && self.var_0BA4 != "traverse" && lib_0547::func_4B2C()) {
    var_07 = lib_0541::func_4596(param_00, param_01, param_02, param_03, param_04, self.var_6250);
    if(var_07 != 0) {
      var_08 = !common_scripts\utility::func_562E(self.var_2FDA);
      var_09 = isDefined(self.var_6250) && self.var_6250 == 0;
      if(level.var_2775 < 9999 || self.var_2FDA || var_07 & 12 == 0 || var_07 & 16 != 0 || self.var_6250 & 3 != 0) {
        if(lib_0541::func_65D0(self.var_6250 | var_07, common_scripts\utility::func_562E(level.var_4D3D[param_01]), param_03, param_05, undefined, 1)) {
          if(lib_0547::func_5731()) {
            earthquake(randomfloatrange(0.15, 0.35), 1, self.var_0116, 200);
          }

          var_06 = 1;
        }

        if(isalive(self) && isPlayer(param_04)) {
          if(var_08 && common_scripts\utility::func_562E(self.var_2FDA)) {
            param_04 thread lib_054E::func_72A4("crawl_spawn");
          } else if(var_09 && isDefined(self.var_6250) && self.var_6250 != 0) {
            param_04 thread lib_054E::func_72A4("shoot_arm");
          }
        }
      }
    }
  }

  return var_07;
}

lib_0541::func_56FD() {
  if(!isDefined(self.var_7AD3)) {
    return 0;
  }

  return lib_0547::func_2696(self.var_7AD3) >= 3;
}

lib_0541::func_A0DF(param_00, param_01) {
  var_02 = lib_0541::func_18B1(self.var_6250);
  if(var_02 != self method_85A5()) {
    if(!self.var_2FDA && self.var_6250 & 12 != 0) {
      thread lib_0541::func_92C5();
    }

    if(param_00) {
      var_03 = var_02;
      if(!isDefined(self.var_788C) || self.var_788C != var_02) {
        self.var_788C = var_02;
        self notify("queuedDismembermentTransition");
        switch (self.var_0108) {
          case "walk":
            var_03 = var_03 + "_walk";
            break;

          case "run":
          case "sprint":
            var_03 = var_03 + "_run";
            break;
        }

        if(param_01) {
          var_03 = var_03 + "_highdamage";
        }

        var_04 = [self, "queuedDismembermentTransition"];
        thread lib_0547::func_7D1A("dismemberment_transition", [var_02, var_03], undefined, var_04);
        return;
      }

      return;
    }

    self method_83D5(var_02);
    maps\mp\agents\humanoid\_humanoid_util::func_A18C();
    if(self.var_0BA4 == "idle") {
      var_05 = "idle_noncombat";
      var_06 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_05);
      maps\mp\agents\_scripted_agent_anim_util::func_8415(var_06);
      return;
    }
  }
}

lib_0541::func_0EAF(param_00, param_01) {
  maps\mp\agents\humanoid\_humanoid_util::func_20C3(param_00, param_01);
}

lib_0541::func_0EB0(param_00, param_01) {
  maps\mp\agents\humanoid\_humanoid_util::func_20C4(param_00);
}

lib_0541::func_65D0(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  param_00 = param_00 &self.var_2FDB;
  if(param_00 == self.var_6250) {
    return 0;
  }

  var_06 = !isDefined(lib_0541::func_18B1(param_00)) || param_02 >= 1;
  if(!lib_0547::func_1F4C()) {
    if(param_00 & 16) {
      param_00 = param_00 &~16;
    }

    if(var_06) {
      var_06 = 0;
      param_00 = 0;
    }
  }

  var_07 = self.var_90AB < gettime();
  if(lib_0547::func_2696(param_00) - lib_0547::func_2696(self.var_6250) >= 3) {
    var_07 = 0;
  }

  if(var_06 && common_scripts\utility::func_562E(self.must_gib_head)) {
    param_00 = 16;
  }

  lib_0541::func_2E44(param_00, var_06, param_03, var_07, param_04, param_05);
  if(!var_06) {
    lib_0541::func_A0DF(var_07, param_01);
  }

  return var_06;
}

lib_0541::func_2CD5() {
  self endon("death");
  wait 0.05;
  if(isDefined(self.var_5DAC["tag_eye"])) {
    self.var_5DAC["tag_eye"] delete();
    self.var_5DAC["tag_eye"] = undefined;
  }
}

lib_0541::func_18B1(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case 1:
      var_01 = "zombie_missing_right_arm_animclass";
      break;

    case 2:
      var_01 = "zombie_missing_left_arm_animclass";
      break;

    case 4:
      var_01 = "zombie_missing_right_leg_animclass";
      break;

    case 8:
      var_01 = "zombie_missing_left_leg_animclass";
      break;

    case 12:
      var_01 = "zombie_crawl_animclass";
      break;

    case 0:
      var_01 = "zombie_animclass";
      break;

    default:
      return undefined;
  }

  if(!maps\mp\_utility::func_585F()) {
    var_01 = "mp_" + var_01;
  }

  return var_01;
}

lib_0541::func_5E60(param_00) {
  switch (param_00) {
    case "right_arm_lower":
    case "right_hand":
    case "right_arm_upper":
      return 1;

    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;

    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 4;

    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 8;

    case "neck":
    case "helmet":
    case "head":
      return 16;

    default:
      return 0;
  }
}

lib_0541::func_20AF(param_00) {
  if(isDefined(self.var_4B53) && param_00 != 16) {
    return 1;
  }

  switch (param_00) {
    case 1:
      return 0.45;

    case 2:
      return 0.45;

    case 4:
      return 0.5;

    case 8:
      return 0.5;

    case 16:
      if(common_scripts\utility::func_562E(self.var_4B6E) || common_scripts\utility::func_562E(self.var_4B5A)) {
        return 1;
      }
      return 0.65;

    default:
      return 1;
  }
}

lib_0541::func_4559(param_00, param_01, param_02) {
  if(isDefined(self.var_2FE3) && isDefined(self.var_2FE3[param_00])) {
    var_03 = self.var_2FE3[param_00][param_02];
    if(isDefined(var_03)) {
      return var_03;
    }
  }

  if(isDefined(param_01) && isDefined(level.var_2FDE[param_01])) {
    var_04 = level.var_2FDE[param_01][param_02];
    if(isDefined(var_04)) {
      return var_04;
    }
  }

  var_04 = level.var_2FDE[param_00][param_02];
  return var_04;
}

lib_0541::func_4558(param_00, param_01) {
  var_02 = 40;
  switch (param_00) {
    case 2:
    case 1:
      return self.var_0116 + (0, 0, var_02);

    case 8:
    case 4:
      var_03 = self gettagorigin(param_01);
      return (self.var_0116[0], self.var_0116[1], var_03[2]);

    case 16:
      return self gettagorigin(var_02);
  }
}

detachlimbsupdatemodelqueue(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.mutilate_detach_limb_queue)) {
    level.mutilate_detach_limb_queue = 0;
  }

  var_06 = floor(level.mutilate_detach_limb_queue / 2) * 0.05;
  level.mutilate_detach_limb_queue++;
  var_07 = "entitydeleted";
  if(function_01EF(self)) {
    var_07 = "death";
  }

  self endon(var_07);
  thread decrementlimbqueueondelete(var_07);
  if(var_06 > 0) {
    wait(var_06);
  }

  detachlimbsupdatemodel(param_00, param_01, param_02, param_03, param_04, param_05);
  thread decrementlimbqueue();
  self notify("mutilate_queue_processed");
}

decrementlimbqueueondelete(param_00) {
  self endon("mutilate_queue_processed");
  self waittill(param_00);
  thread decrementlimbqueue();
}

decrementlimbqueue() {
  wait 0.05;
  level.mutilate_detach_limb_queue--;
  level.mutilate_detach_limb_queue = int(max(level.mutilate_detach_limb_queue, 0));
}

lib_0541::func_2E44(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 = param_00 &self.var_2FDB;
  var_06 = ~self.var_6250 &param_00;
  self.var_6250 = self.var_6250 | param_00;
  self.var_7AD3 = var_06;
  if(function_01EF(self)) {
    self[[maps\mp\agents\_agent_utility::func_0A59("on_mutilate")]](var_06);
  }

  if(common_scripts\utility::func_562E(param_05)) {
    thread detachlimbsupdatemodelqueue(param_00, param_01, param_02, param_03, param_04, var_06);
    return;
  }

  detachlimbsupdatemodel(param_00, param_01, param_02, param_03, param_04, var_06);
}

detachlimbsupdatemodel(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(param_03) {
    if(param_05 & 1 != 0) {
      lib_0541::func_903D(1, param_02, param_04);
    }

    if(param_05 & 2 != 0) {
      lib_0541::func_903D(2, param_02, param_04);
    }

    if(param_05 & 4 != 0) {
      lib_0541::func_903D(4, param_02, param_04);
    }

    if(param_05 & 8 != 0) {
      lib_0541::func_903D(8, param_02, param_04);
    }
  }

  if(param_05 & 16 != 0) {
    lib_0541::func_AC26(param_02);
    lib_0541::func_903D(16, param_02, param_04);
    if(isDefined(self.var_5DAC) && isDefined(self.var_5DAC["tag_eye"])) {
      function_014E(self.var_5DAC["tag_eye"], 1);
      thread lib_0541::func_2CD5();
    }
  }

  if(!param_01 && param_03) {
    lib_054D::func_90B0(self, param_05, self.var_08D9);
  }

  lib_0547::func_A19E();
}

lib_0541::func_903D(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = lib_0547::func_4744(param_00);
  var_04 = lib_0541::func_4559(param_00, var_03, "tagName");
  var_05 = lib_0541::func_4558(param_00, var_04);
  var_06 = self gettagangles(var_04);
  var_07 = undefined;
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_08 = lib_0541::func_4559(param_00, var_03, "modelToSpawn");
  if(param_02 && isDefined(var_08)) {
    var_07 = spawn("script_model", var_05);
    var_07 setModel(var_08);
    var_07.var_001D = var_06;
    var_09 = (0, 0, randomfloatrange(1000, 2000));
    var_0A = param_01 * randomfloatrange(500, 1000);
    var_0B = (randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000));
    var_0C = anglestoright(self.var_001D);
    switch (param_00) {
      case 1:
        var_0A = var_0A + var_0C * 750;
        break;

      case 4:
        var_0A = var_0A + var_0C * 500;
        break;

      case 2:
        var_0A = var_0A - var_0C * 750;
        break;

      case 8:
        var_0A = var_0A - var_0C * 500;
        break;
    }

    var_0D = var_09 + var_0A;
    var_0E = length(var_0D);
    var_0F = var_0D / var_0E;
    var_0E = min(var_0E, 1750);
    var_07 method_83C9(var_0F * var_0E, var_0B);
    var_07 method_8553();
    if(level.var_66BF < level.var_2FDD.size) {
      level.var_2FDD[level.var_66BF] delete();
    }

    level.var_2FDD[level.var_66BF] = var_07;
    level.var_66BF = level.var_66BF + 1 % 20;
  }

  var_10 = lib_0541::func_4559(param_00, var_03, "fxTagName");
  var_11 = lib_0541::func_4559(param_00, var_03, "limbFX");
  var_12 = lib_0541::func_4559(param_00, var_03, "gibFX");
  if(common_scripts\utility::func_562E(lib_0541::func_4559(param_00, var_03, "noGib"))) {
    var_12 = undefined;
  }

  if(isDefined(var_12)) {
    var_13 = self gettagangles(var_10);
    var_14 = anglesToForward(var_13);
    var_15 = anglestoup(var_13);
    var_16 = vectornormalize(var_14 + 4 * param_01);
    var_17 = vectornormalize(vectorcross(var_16, var_15));
    if(lengthsquared(var_17) < 0.5) {
      var_17 = anglestoright(var_13);
    }

    var_18 = vectorcross(var_17, var_16);
    playFX(common_scripts\utility::func_44F5(var_12), self gettagorigin(var_10), var_16, var_18);
  }

  if(isDefined(var_11)) {
    lib_0547::func_74A5(common_scripts\utility::func_44F5(var_11), var_07, var_10, 1);
  }

  var_19 = lib_0547::func_4495();
  var_1A = lib_0541::func_4559(param_00, var_03, var_19);
  thread lib_0541::func_70F1(var_1A);
}

lib_0541::func_70F1(param_00) {
  wait 0.05;
  if(self.var_00BC > 0) {
    self playsoundonmovingent(param_00);
    return;
  }

  playclientsound(param_00, undefined, self.var_0116);
}

lib_0541::func_65CD(param_00) {
  self notify("mutatorSpawnSound");
  self endon("mutatorSpawnSound");
  if(common_scripts\utility::func_562E(self.var_6723)) {
    return;
  }

  if(isDefined(level.var_65CB[param_00][2])) {
    wait(randomfloatrange(0.2, 0.8));
    var_01 = level.var_65CB[param_00][2];
    self playsoundonmovingent(var_01);
  }
}

lib_0541::func_6ADD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  foreach(var_0B in level.var_65CB) {
    if(isDefined(var_0B[4])) {
      self[[var_0B[4]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    }
  }
}

lib_0541::func_6B4A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  foreach(var_0A in level.var_65CB) {
    if(isDefined(var_0A[3])) {
      self[[var_0A[3]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    }
  }
}

lib_0541::func_9E19(param_00, param_01, param_02) {
  if(!param_02 == "BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_RIFLE_BULLET") {
    return;
  }

  if(!param_01 == "helmet" || param_01 == "head" || param_01 == "neck") {
    return;
  }

  var_03 = 0.25;
  if(randomfloat(1) > var_03) {
    return;
  }

  lib_0541::func_AC26(param_00);
}

lib_0541::func_2CD9() {
  self endon("death");
  self waittill("helmet_pop", var_00);
  lib_0541::func_AC26(anglestoright(self.var_001D) + anglestoup(self.var_001D), var_00);
}

lib_0541::func_AC26(param_00, param_01) {
  self endon("death");
  self endon("entitydeleted");
  if(self.var_4B6E || self.var_4B5A) {
    var_02 = self.var_4CAA;
    var_03 = self gettagorigin("j_head") + (0, 0, 20);
    var_04 = self gettagangles("j_head");
    self.var_4B6E = 0;
    self.var_4B5A = 0;
    if(isDefined(param_01)) {
      wait(param_01);
    }

    lib_0547::func_A19E();
    var_05 = spawn("script_model", var_03);
    var_05 setModel(var_02);
    var_05.var_001D = var_04;
    var_06 = spawn("script_model", var_05.var_0116);
    var_06 setModel("helmet_collision");
    var_06.var_001D = var_05.var_001D;
    var_05 linkto(var_06);
    var_06.var_6292 = var_05;
    if(!isDefined(param_00)) {
      param_00 = anglesToForward(var_06.var_001D);
    }

    var_07 = param_00;
    var_08 = var_07[0] * 10000 * randomfloat(1);
    var_09 = var_07[1] * 10000 * randomfloat(1);
    var_0A = var_07[2] * 6000 * randomfloat(1);
    var_0B = var_06.var_0116 + param_00 * -5;
    var_06 method_82C5(var_0B, (var_08, var_09, var_0A));
    var_06 method_8553();
    var_05 method_8553();
    var_06 thread lib_0541::func_2395();
    var_06 hideallparts();
  }
}

lib_0541::func_2395() {
  level endon("game_ended");
  wait(15);
  if(isDefined(self)) {
    if(isDefined(self.var_6292)) {
      self.var_6292 delete();
    }

    self delete();
  }
}