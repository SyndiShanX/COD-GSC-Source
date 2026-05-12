/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid_melee.gsc
*******************************************************/

func_00F9() {
  self endon("death");
  self endon("killanimscript");
  self.var_28D2 endon("disconnect");
  var_00 = maps\mp\agents\humanoid\_humanoid::func_457E(self.var_28D2);
  if(func_5753(self.var_28D2)) {
    return func_60E7(self.var_28D2);
  }

  if(common_scripts\utility::func_562E(self.var_5F4C) && var_00.var_A266) {
    if(!isDefined(self.var_5F48)) {
      self.var_5F48 = 0;
    }

    if(isDefined(self.var_60ED)) {
      var_01 = gettime() - self.var_5F48 > self.var_5F46;
      var_02 = maps\mp\agents\humanoid\_humanoid_util::func_1F51(self.var_0116, var_00.var_0116);
      var_03 = distancesquared(self.var_28D2.var_0116, self.var_0116) > self.var_5F50;
      if(var_01 && var_02 && var_03) {
        self.var_5F48 = gettime();
        func_3108(self.var_28D2, var_00.var_0116);
        return;
      }
    }

    if(!maps\mp\agents\humanoid\_humanoid_util::func_AA52(self.var_28D2)) {
      func_5F4D(self.var_28D2);
      return;
    }
  }

  func_3109(self.var_28D2, var_00.var_0116);
}

func_5753(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.var_28D2;
  }

  var_01 = self.var_0116 + (0, 0, self.var_60E1);
  var_02 = param_00.var_0116 + (0, 0, self.var_60E1);
  var_03 = undefined;
  if(isDefined(param_00.var_003A) && param_00.var_003A == "misc_turret" && isDefined(param_00.var_0B40)) {
    var_03 = physicstrace(var_01, var_02, param_00.var_0B40);
  } else {
    var_03 = physicstrace(var_01, var_02);
  }

  return distancesquared(var_03, var_02) > 1;
}

func_0085() {
  self method_839A(1, 1);
}

func_3107(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self.var_5BBE = undefined;
  self.var_5BBF = undefined;
  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  var_08 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(param_02);
  var_09 = self method_83D8(param_02, var_08);
  var_0A = getanimlength(var_09);
  var_0B = [];
  foreach(var_0D in ["hit", "attack", "zombie_melee"]) {
    var_0B = common_scripts\utility::func_0F73(var_0B, getnotetracktimes(var_09, var_0D));
  }

  if(var_0B.size == 0) {
    var_0B = [0.33];
  } else if(var_0B.size >= 2) {
    var_0B = common_scripts\utility::func_7897(var_0B);
  }

  self method_839D("gravity");
  if(common_scripts\utility::func_562E(param_07)) {
    self scragentsetorientmode("face angle abs", self.var_001D);
  } else if(param_04) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(param_00.var_0116 - self.var_0116), 0));
  }

  self method_839C("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::func_8415(param_02, var_08, param_05);
  var_0F = 0;
  for(var_10 = 0; var_10 < var_0B.size; var_10++) {
    var_11 = var_0B[var_10];
    var_12 = var_0F;
    var_13 = param_05;
    if(var_10 == 0 && param_06) {
      var_14 = getnotetracktimes(var_09, "lunge_start");
      if(var_14.size > 0 && var_14[0] < var_11) {
        var_12 = var_14[0];
      }

      var_15 = var_12 - var_0F * var_0A / param_05;
      wait(var_15);
      maps\mp\agents\humanoid\_humanoid_util::func_70C9(self.var_5F47);
      if(self.var_5F44) {
        var_16 = param_01 - self.var_0116;
        var_17 = getmovedelta(var_09, var_12, var_11);
        var_18 = maps\mp\agents\_scripted_agent_anim_util::func_441C(var_16, var_17);
        var_13 = param_05 * clamp(1 / var_18.var_AAE3, 0.5, 1);
        maps\mp\agents\_scripted_agent_anim_util::func_8415(param_02 + "_norestart", var_08, var_13);
      }
    }

    var_19 = var_11 - var_12 * var_0A / param_05;
    var_1A = "";
    var_1B = "";
    var_1C = 30;
    var_1D = -1.8;
    var_1E = self.var_0116;
    if(param_03) {
      childthread func_A12D(param_00, var_19, 1, self.var_5F49);
      maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoAttack");
    } else {
      self method_839A(1, 1);
    }

    wait(var_19);
    self method_85D4(param_05);
    self notify("cancel_updatelerppos");
    self method_839C("anim deltas");
    self method_839A(1, 1);
    if(param_03) {
      maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "DoAttack");
    }

    var_21 = func_11AF(param_00);
    if(var_21) {
      var_22 = 0;
      if(isDefined(param_00)) {
        var_22 = param_00.var_00BC;
      }

      if(isDefined(self.var_60E2)) {
        var_22 = self.var_60E2;
      }

      if(isalive(param_00)) {
        func_3210(param_00, var_22, "MOD_IMPACT");
      }
    }

    var_23 = common_scripts\utility::func_98E7(var_21, "attack_hit", "attack_miss");
    if(!isDefined(param_00.shield_hit_blocked) || gettime() != param_00.shield_hit_blocked) {
      self notify(var_23, param_00, param_01);
    }

    self.var_5BC1 = self.var_0116;
    var_0F = var_11;
  }

  var_24 = 1 - var_0F * var_0A / param_05;
  if(var_24 > 0) {
    maps\mp\agents\_scripted_agent_anim_util::func_A79F("attack_anim", "end", var_24);
  }

  self.var_5BC0 = gettime();
}

func_11AF(param_00) {
  if(!isalive(param_00)) {
    return 0;
  }

  if(!func_AA50(param_00)) {
    return 0;
  }

  if(func_56DA(param_00, self.var_60E5)) {
    return 1;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::func_56DD(param_00)) {
    return 1;
  }

  return 0;
}

func_56DA(param_00, param_01) {
  var_02 = vectornormalize(param_00.var_0116 - self.var_0116 * (1, 1, 0));
  var_03 = anglesToForward(self.var_001D);
  var_04 = vectordot(var_02, var_03);
  return var_04 > param_01;
}

func_AA50(param_00) {
  if(!maps\mp\agents\humanoid\_humanoid::func_7AC0("normal", param_00)) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::func_4580() > self.var_60F0 && !maps\mp\agents\humanoid\_humanoid_util::func_AA52(param_00)) {
    return 0;
  }

  return 1;
}

func_3109(param_00, param_01) {
  var_02 = "attack_stand";
  var_03 = self.var_672D;
  var_04 = 0;
  if(isDefined(self.var_60ED)) {
    var_02 = "attack_" + self.var_60ED;
    var_04 = 1;
    self.var_60ED = undefined;
  }

  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_02);
  func_3107(param_00, param_01, var_05, 0, var_04, var_03);
}

func_3108(param_00, param_01) {
  func_3107(param_00, param_01, self.var_5F45, 1, 1, self.var_672D, 1);
}

func_A12D(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  param_00 endon("disconnect");
  param_00 endon("death");
  var_04 = self.var_0116;
  var_05 = param_01;
  var_06 = 0.05;
  self method_839A(0, 1);
  for(;;) {
    if(var_05 <= 0) {
      break;
    }

    var_07 = func_4707(param_00, param_02);
    if(!isDefined(var_07)) {
      break;
    }

    if(isDefined(param_03)) {
      var_08 = param_03;
    } else {
      var_08 = maps\mp\agents\humanoid\_humanoid_util::func_4580() - self.var_014F;
    }

    var_09 = var_07 - var_04;
    if(lengthsquared(var_09) > var_08 * var_08) {
      var_07 = var_04 + vectornormalize(var_09) * var_08;
    }

    if(self method_85DF()) {
      var_0A = common_scripts\utility::func_3D5D(var_07 - self.var_0116);
      var_0B = length(var_0A);
      if(var_0B > 1) {
        var_0C = vectornormalize(common_scripts\utility::func_3D5D(anglesToForward(self.var_001D)));
        var_0D = var_0A / var_0B;
        var_0E = acos(clamp(vectordot(var_0D, var_0C), -1, 1));
        var_0F = self method_85DD();
        var_10 = lib_0547::func_9A6C(var_0F);
        if(var_0E > var_10) {
          var_11 = self.var_0116 + var_0C * var_0B * max(0, vectordot(var_0C, var_0D));
          if(distance(var_04, var_11) > var_08) {
            var_11 = var_04 + vectornormalize(var_11 - var_04) * var_08;
          }

          var_07 = var_11;
        }
      }
    }

    self scragentsetorientmode("face enemy");
    self method_83A4(self.var_0116, var_07, var_05);
    wait(var_06);
    var_05 = var_05 - var_06;
  }
}

func_4707(param_00, param_01) {
  if(!param_01) {
    var_02 = lib_0547::func_34A6(param_00.var_0116);
    return var_02;
  }

  var_03 = param_00.var_0116 - self.var_0116;
  var_04 = length(var_03);
  if(var_04 < self.var_11AB) {
    return self.var_0116;
  }

  var_03 = var_03 / var_04;
  var_05 = maps\mp\agents\humanoid\_humanoid::func_457E(param_00);
  if(maps\mp\agents\humanoid\_humanoid_util::func_1F51(self.var_0116, var_05.var_0116)) {
    return var_05.var_0116;
  }

  return undefined;
}

func_5797(param_00) {
  if(param_00 maps\mp\_riotshield::func_4B8C()) {
    var_01 = self.var_0116 - param_00.var_0116;
    var_02 = vectornormalize((var_01[0], var_01[1], 0));
    var_03 = anglesToForward(param_00.var_001D);
    var_04 = vectordot(var_03, var_01);
    if(param_00 maps\mp\_riotshield::func_4B8D()) {
      if(var_04 > 0.766) {
        return 1;
      }
    } else if(var_04 < -0.766) {
      return 1;
    }
  }

  return 0;
}

func_3210(param_00, param_01, param_02) {
  if(func_5797(param_00)) {
    return;
  }

  param_00 dodamage(param_01, self.var_0116, self, self, param_02);
}

func_60E7(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.var_28D2;
  }

  self.var_5BBE = self.var_0116;
  self.var_5BBF = param_00.var_0116;
}

func_5F4D(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.var_28D2;
  }

  self.var_5BBB = self.var_0116;
  self.var_5BBC = param_00.var_0116;
}