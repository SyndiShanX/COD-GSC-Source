/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombies_soul_collection.gsc
**************************************************/

func_170B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  self.var_695B = param_03;
  self.var_696B = param_01;
  self.var_6943 = param_02;
  self.checklos = param_0E;
  self.var_2E37 = param_05;
  self.var_2DA5 = param_06;
  self.var_2DA6 = param_07;
  self.var_AC2D = param_00;
  self.var_AC2C = 0;
  if(isDefined(param_08)) {
    self.var_7D24 = param_08;
  }

  if(isDefined(param_09)) {
    self.var_8C47 = param_09;
  }

  if(isDefined(param_0A)) {
    self.var_8C48 = param_0A;
  }

  if(isDefined(param_0C)) {
    self.sightignore = param_0C;
  }

  if(isDefined(param_0D)) {
    self.optionaldisablearclightning = param_0D;
  }

  if(!isDefined(level.var_8E3)) {
    level.var_8E3 = [];
  }

  level.var_8E3 = common_scripts\utility::func_F6F(level.var_8E3, self);
  while(!isDefined(level.var_376B)) {
    wait 0.05;
  }

  if(!isDefined(param_04) && !common_scripts\utility::func_F79(level.var_376B, ::func_4030)) {
    lib_0547::func_7BA9(::func_4030);
  }

  if(isDefined(param_04)) {
    self.hasnongenerickillfunc = 1;
    if(!common_scripts\utility::func_F79(level.var_376B, param_04)) {
      lib_0547::func_7BA9(param_04);
    }
  }

  if(isDefined(param_0B)) {
    thread func_4DED(param_0B);
  }

  while(self.var_AC2D == -1 || self.var_AC2C < self.var_AC2D) {
    level waittill(self.var_695B);
    if(self.var_AC2D != -1 && self.var_AC2C >= self.var_AC2D) {
      break;
    }
  }

  if(isDefined(param_0B)) {
    thread func_9408();
  }

  if(!common_scripts\utility::func_562E(self.disable_end_sound)) {
    lib_0378::func_8D74("zombie_soul_suck_threshold", self.var_116);
  }

  if(isDefined(param_04) && !common_scripts\utility::func_562E(self.disable_auto_deregister)) {
    lib_0547::func_2D8C(param_04);
  }

  level.var_8E3 = common_scripts\utility::func_F93(level.var_8E3, self);
}

beginazombiesoulcollectionobjectiveonstruct(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  var_0F = self;
  var_10 = var_0F common_scripts\utility::func_8FFC();
  var_10 method_805B();
  var_0F.collector = var_10;
  if(isDefined(self.onzombiesacrificedfunc)) {
    var_0F.collector.onzombiesacrificedfunc = self.onzombiesacrificedfunc;
  }

  if(isDefined(self.optionaldisablearclightning)) {
    var_0F.collector.optionaldisablearclightning = self.optionaldisablearclightning;
  }

  if(common_scripts\utility::func_562E(var_0F.ignoresighttrace)) {
    var_10.ignoresighttrace = 1;
  }

  var_10 func_170B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E);
  var_10 delete();
}

func_4030(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.soulcollectinvalid)) {
    return;
  }

  if(level.var_8E3.size == 0) {
    return;
  }

  if(isDefined(param_03) && param_03 == "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(level.zmb_max_soul_collection_beams)) {
    level.zmb_max_soul_collection_beams = 3;
  }

  if(!isDefined(level.var_6666)) {
    level.var_6666 = 0;
  }

  var_09 = common_scripts\utility::func_4461(self.var_116, level.var_8E3);
  if(!isDefined(var_09)) {
    return;
  }

  var_0A = 0;
  if(common_scripts\utility::func_562E(var_09.hasnongenerickillfunc)) {
    return;
  }

  if(isDefined(var_09.var_7D24)) {
    if(isarray(var_09.var_7D24)) {
      var_0B = 0;
      foreach(var_0D in var_09.var_7D24) {
        if(param_04 == var_0D) {
          var_0B = 1;
        }
      }

      if(!var_0B) {
        var_0A = 1;
      }
    } else if(param_04 != var_09.var_7D24) {
      var_0A = 1;
    }
  }

  if(isDefined(var_09.desired_zombie_type)) {
    if(self.var_A4B != var_09.desired_zombie_type) {
      return;
    }
  }

  if(level.var_8E3.size == 0 || common_scripts\utility::func_562E(self.var_8F2B) || var_0A) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_AC10) || common_scripts\utility::func_562E(self.not_valid_sacrifice)) {
    return;
  }

  if(isDefined(var_09.var_2E37) && var_09 method_8445(var_09.var_2E37) != -1) {
    var_0F = var_09 gettagorigin(var_09.var_2E37);
    if(isDefined(var_09.var_8C48)) {
      var_0F = var_0F + var_09.var_8C48;
    }
  } else {
    var_0F = var_0A.var_116;
  }

  if(isDefined(var_09.ignoresighttrace) && var_09.ignoresighttrace) {
    var_10 = 1;
  } else if(isDefined(var_0A.var_8C47)) {
    var_10 = bullettracepassed(self getEye(), var_10, 0, var_0A, var_0A.var_8C47);
  } else {
    var_10 = bullettracepassed(self getEye(), var_10, 0, var_0A);
  }

  var_11 = func_21CF(var_09, var_09.var_696B, var_09.var_6943, var_09.checklos);
  if(var_11 && var_10) {
    self.var_8F2B = 1;
    if(!common_scripts\utility::func_562E(var_09.optionaldisablearclightning)) {
      if(level.var_6666 < level.zmb_max_soul_collection_beams) {
        thread func_2024(var_09, var_09.var_2E37, var_09.var_2DA5, var_09.var_2DA6);
      }

      try_play_scripted_soul_suck_anim("scripted_soul_eat");
    }

    if(isDefined(var_09.onzombiesacrificedfunc)) {
      self thread[[var_09.onzombiesacrificedfunc]](var_09);
    }

    var_09.var_AC2C++;
    if(isDefined(self) && isDefined(self.var_A4B)) {
      level notify(var_09.var_695B, var_09, self.var_A4B);
      return;
    }

    level notify(var_09.var_695B, var_09);
  }
}

try_play_scripted_soul_suck_anim(param_00) {
  if(!common_scripts\utility::func_562E(self.var_2FDA) && !lib_0547::func_5565(self.var_A4B, "zombie_fireman")) {
    func_865C(param_00, 0);
  }
}

func_2024(param_00, param_01, param_02, param_03) {
  lib_0378::func_8D74("aud_zombie_soul_absorb");
  if(!isDefined(level.var_6666)) {
    level.var_6666 = 0;
  }

  self waittill("body_spawned", var_04);
  if(!isDefined(var_04)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  level.var_6666++;
  var_05 = launchbeam("zmb_geistkraft_reg_beam_med", var_04, "j_neck", param_00, param_01);
  if(!isDefined(param_02)) {
    var_06 = "zmb_cart_charge_pnt";
  } else {
    var_06 = param_03;
  }

  if(!isDefined(param_03)) {
    var_07 = param_01;
  } else {
    var_07 = var_04;
  }

  playFXOnTag(level.var_611[var_06], param_00, var_07);
  if(isDefined(level.var_3571)) {
    playFXOnTag(level.var_611["zmb_gk_claw_battery_charge_1"], level.var_3571, "flap1_shroud");
    playFXOnTag(level.var_611["zmb_gk_claw_battery_charge_2"], level.var_3571, "flap2_shroud");
    playFXOnTag(level.var_611["zmb_gk_claw_battery_charge_3"], level.var_3571, "flap3_shroud");
  }

  lib_0378::func_8D74("zombie_soul_suck", var_04.var_116, param_00.var_116);
  wait(0.45);
  if(isDefined(var_05)) {
    var_05 delete();
  }

  level.var_6666--;
}

func_21CF(param_00, param_01, param_02, param_03) {
  return func_56B0(param_00, param_01, param_02, param_03);
}

func_56B0(param_00, param_01, param_02, param_03) {
  var_04 = param_00.var_116;
  if(isDefined(param_00.var_2E37)) {
    var_04 = param_00 gettagorigin(param_00.var_2E37);
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(common_scripts\utility::func_562E(param_03)) {
    var_05 = sighttracepassed(self.var_116, var_04, 0, self, param_00, 0);
    if(!var_05) {
      return 0;
    }
  }

  if(isDefined(param_02)) {
    return distance2d(var_04, self.var_116) < param_01 && abs(var_04[2] - self.var_116[2]) < param_02;
  }

  return distance2d(var_04, self.var_116) < param_01 && self.var_116[2] < var_04[2];
}

func_865C(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_2A9D = param_00;
    return;
  }

  if(self.var_BA4 != "traverse") {
    self.var_2A9D = param_00;
  }
}

func_4DED(param_00) {
  self endon("stop_sould_bucket_leak");
  for(;;) {
    var_01 = 0;
    while(!var_01) {
      var_02 = self.var_AC2C;
      wait(param_00);
      if(self.var_AC2C <= var_02) {
        var_01 = 1;
      }
    }

    func_35FC();
  }
}

func_35FC() {
  self endon("stop_sould_bucket_leak");
  level endon(self.var_695B);
  while(self.var_AC2C > 0) {
    self.var_AC2C--;
    wait(0.25);
  }

  self.var_AC2C = 0;
}

func_9408() {
  self notify("stop_sould_bucket_leak");
}