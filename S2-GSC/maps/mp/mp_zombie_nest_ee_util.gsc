/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_util.gsc
**********************************************/

func_50F3() {
  var_00 = common_scripts\utility::func_46B5("raven_progress", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = common_scripts\utility::func_46B7(var_00.var_01A2, "targetname");
  var_02 = lib_0557::func_7838("6B Left Hand overcharge", "activate left hand");
  var_03 = lib_0557::func_7838("7 Voice paintings", "enter code pieces");
  var_04 = lib_0557::func_7838("5 Right Hand fuses", "tower confirm hand");
  foreach(var_06 in var_01) {
    switch (var_06.var_0165) {
      case "right":
        var_06.var_3F80 = common_scripts\utility::func_46B5(var_06.var_0165 + "_to_center_fx", "script_noteworthy");
        if(!isDefined(var_06.var_3F80)) {
          return;
        }

        var_06 thread func_7A8C(var_02, var_03);
        break;

      case "right2":
        var_06 thread func_7A8C(var_03, var_03);
        break;

      case "left2":
        var_06.var_3F80 = common_scripts\utility::func_46B5("middle_to_center_fx", "script_noteworthy");
        if(!isDefined(var_06.var_3F80)) {
          return;
        }

        var_06 thread func_7A8C(var_03, var_03);
        break;

      case "left":
        var_06.var_3F80 = common_scripts\utility::func_46B5(var_06.var_0165 + "_to_center_fx", "script_noteworthy");
        if(!isDefined(var_06.var_3F80)) {
          return;
        }

        var_06 thread func_7A8C(var_04, var_03);
        break;

      case "rock_crumble":
        var_06 thread func_7EB3(var_03);
        break;
    }
  }

  var_08 = getEntArray(var_00.var_01A2, "targetname");
  foreach(var_0A in var_08) {
    switch (var_0A.var_0165) {
      case "final_boss_tesla_trigger":
        var_0A thread func_A6A0(var_00, var_03);
        break;
    }
  }
}

func_7A8C(param_00, param_01) {
  common_scripts\utility::func_3CA2(param_00, param_01);
  self.var_001D = (270, 270, 90);
  if(isDefined(self.var_3F80)) {
    var_02 = lib_0547::func_8FBA(self.var_3F80, "hiltroom_connection");
    triggerfx(var_02);
    level waittill("end hilt grabbed");
    var_02 delete();
  }
}

func_7EB3(param_00) {
  for(;;) {
    level waittill("end hilt grabbed", var_01);
    level thread common_scripts\_exploder::func_088E(222);
    earthquake(0.3, 7, var_01, 1000);
  }
}

func_A6CD(param_00) {
  level endon("brute_tesla_skip_cheat");
  common_scripts\utility::func_3C9F(param_00);
}

func_A6A0(param_00, param_01) {
  self notsolid();
  func_A6CD(param_01);
  self solid();
  level.var_4D74 = lib_0547::func_8FBA(param_00, "zmb_hilt_sphere");
  var_02 = getent("hilt_model", "targetname");
  triggerfx(level.var_4D74);
  var_02 lib_0378::func_8D74("aud_start_hilt_sphere_sound");
  wait(5);
  self setCanDamage(1);
  for(var_03 = []; var_03.size < level.var_744A.size; var_03 = []) {
    var_04 = func_A6CE(self, "brute tesla activation fail");
    lib_0378::func_8D74("aud_hilt_destroy");
    if(isDefined(var_04)) {
      if(!common_scripts\utility::func_0F79(var_03, var_04)) {
        var_03 = common_scripts\utility::func_0F6F(var_03, var_04);
      }

      if(var_03.size == 1) {
        thread func_08BD(5, "brute tesla activated", "brute tesla activation fail");
      }

      continue;
    }
  }

  playFX(level.var_0611["zmb_hilt_sphere_explosion"], param_00.var_0116, anglesToForward(param_00.var_001D));
  level.var_4D74 delete();
  var_05 = getent("nest_ee_shard_intro_start_trig", "targetname");
  var_05 common_scripts\utility::func_9DA3();
  var_06 = undefined;
  foreach(var_08 in level.var_744A) {
    if(var_08 func_7403()) {
      var_06 = var_08;
    }
  }

  if(!isDefined(var_06)) {
    var_06 = common_scripts\utility::func_7A33(level.var_744A);
  }

  var_06 thread lib_0367::func_8E3B("conv_hiltrecovered");
  if(lib_0557::func_783E("8A The Hilt", "Use Hilt") && !lib_0557::func_783E("8A The Hilt", "Shoot Hilt")) {
    lib_0557::func_7822("8A The Hilt", &"ZOMBIE_NEST_HINT_STEP_TAKE_HILT");
  }

  var_05 sethintstring(&"ZOMBIE_NEST_SHARD_INTRO_TRIG");
  var_05 waittill("trigger", var_04);
  var_05 common_scripts\utility::func_9D9F();
  lib_0378::func_8D74("aud_pickup_raven_sword");
  common_scripts\utility::func_3C8F("flag_hilt_collected");
  if(isDefined(var_02)) {
    var_02 delete();
  }

  wait(2);
  level notify("end hilt grabbed", var_04.var_0116);
  var_04 thread lib_0367::func_8E3B("conv_hiltroomcollapse");
  wait(5);
  thread func_3BEC();
  thread func_3BE6();
  thread func_1CCC();
  thread func_1CCA();
  level.var_6654 = 1;
}

func_4030(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.var_6666)) {
    level.var_6666 = 0;
  }

  var_09 = common_scripts\utility::func_4461(self.var_0116, level.var_08E3);
  var_0A = 0;
  if(isDefined(var_09) && isDefined(var_09.var_7D24)) {
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

  if(level.var_08E3.size == 0 || common_scripts\utility::func_562E(self.var_8F2B) || var_0A) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_AC10)) {
    return;
  }

  if(isDefined(var_09.var_2E37)) {
    var_0F = var_09 gettagorigin(var_09.var_2E37);
    if(isDefined(var_09.var_8C48)) {
      var_0F = var_0F + var_09.var_8C48;
    }
  } else {
    var_0F = var_0A.var_0116;
  }

  if(isDefined(var_09.var_8C47)) {
    var_10 = bullettracepassed(self getEye(), var_0F, 0, var_09, var_09.var_8C47);
  } else {
    var_10 = bullettracepassed(self getEye(), var_10, 0, var_0A);
  }

  var_11 = func_21CF(var_09, var_09.var_696B, var_09.var_6943);
  if(isDefined(var_09) && var_11 && var_10) {
    self.var_8F2B = 1;
    if(level.var_6666 < 5) {
      thread func_2024(var_09, var_09.var_2E37, var_09.var_2DA5, var_09.var_2DA6);
    }

    if(!common_scripts\utility::func_562E(self.var_2FDA) && !lib_0547::func_5565(self.var_0A4B, "zombie_fireman")) {
      func_865C("scripted_soul_eat", 0);
    }

    var_09.var_AC2C++;
    level notify(var_09.var_695B, var_09);
  }
}

func_08BD(param_00, param_01, param_02) {
  self endon(param_01);
  wait(param_00);
  self notify(param_02);
}

func_A6CE(param_00, param_01) {
  if(isDefined(param_01)) {
    param_00 endon(param_01);
  }

  param_00 setCanDamage(1);
  var_02 = undefined;
  var_03 = "";
  while(!issubstr(var_03, "teslagun_zm")) {
    param_00 waittill("damage", var_04, var_02);
    if(isDefined(var_02) && isPlayer(var_02)) {
      var_03 = var_02 getcurrentweapon();
    }
  }

  return var_02;
}

func_A6CF(param_00, param_01) {
  if(isDefined(param_01)) {
    param_00 endon(param_01);
  }

  param_00 setCanDamage(1);
  var_02 = undefined;
  var_03 = "";
  while(!issubstr(var_03, "teslagun_zm")) {
    if(!common_scripts\utility::func_562E(param_00.var_8C8C)) {
      param_00 waittill("trigger", var_02);
      var_03 = var_02 getcurrentweapon();
      continue;
    }

    return level.var_744A[0];
  }

  return var_02;
}

func_9903(param_00, param_01, param_02, param_03) {
  if(issubstr(param_01, "teslagun_zm")) {
    return 1;
  }

  return 0;
}

func_9902(param_00, param_01, param_02, param_03) {
  self notify("death", param_00, param_02, param_01);
}

func_9EC4() {
  var_00 = function_021F("village_off", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

func_9EC5() {
  var_00 = function_021F("village_off", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

func_3BEC() {
  var_00 = function_021F("fire_on", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire", "enable");
  }
}

func_3BE6() {
  var_00 = function_021F("fill_on", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire_fill", "enable_fill");
  }
}

func_1CCC() {
  var_00 = function_021F("brute_lighting", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

func_1CCA() {
  var_00 = function_021F("brute_fire", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire1", "enable");
  }
}

func_1CCB() {
  var_00 = function_021F("brute_lighting", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

func_1CC9() {
  var_00 = function_021F("brute_fire", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire1", "die");
  }
}

func_283B(param_00) {
  var_01 = newhudelem();
  var_01 setshader("hud_destructibledeathicon", 1, 1);
  var_01.var_0018 = 1;
  var_01.var_0056 = (1, 1, 1);
  var_01.var_01D3 = param_00.var_0116[0];
  var_01.var_01D7 = param_00.var_0116[1];
  var_01.var_01D9 = param_00.var_0116[2];
  var_01 setwaypoint(1);
  var_01 settargetent(param_00);
  return var_01;
}

func_7AC3(param_00) {
  var_01 = self method_83DB(param_00);
  return randomint(var_01);
}

func_8579(param_00) {
  self scragentsetscripted(1);
  self method_839D("noclip");
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", param_00);
}

func_442B() {
  for(var_00 = 0; var_00 < self.var_AB4E.size; var_00++) {
    if(self.var_AB4E[var_00] func_996A()) {
      return self.var_AB4E[var_00];
    }
  }

  return undefined;
}

func_996A() {
  return !isDefined(self.var_65FB) || !isalive(self.var_65FB);
}

func_442D(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(!isDefined(param_00[var_01].var_65FB) || !isalive(param_00[var_01].var_65FB)) {
      return param_00[var_01];
    }
  }

  return undefined;
}

func_7402() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone3_1_com") || lib_055A::func_7413(self, "zone3_2_med") || lib_055A::func_7413(self, "zone3_3_rnd") || lib_055A::func_7413(self, "zone4_1_mine");
}

func_740A() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone1_1_start") || lib_055A::func_7413(self, "zone1_2_gallows") || lib_055A::func_7413(self, "zone1_3_riverside") || lib_055A::func_7413(self, "zone1_4_bridge") || lib_055A::func_7413(self, "zone1_4_bridge_tower") || lib_055A::func_7413(self, "zone1_5_rooftops");
}

func_7403() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone4_2_hilt");
}

func_56B0(param_00, param_01, param_02, param_03) {
  var_04 = param_00.var_0116;
  if(isDefined(param_00.var_2E37)) {
    var_04 = param_00 gettagorigin(param_00.var_2E37);
  }

  if(common_scripts\utility::func_562E(param_03)) {
    var_05 = sighttracepassed(self.var_0116, var_04, 0, self, param_00, 0);
    if(!var_05) {
      return 0;
    }
  }

  if(isDefined(param_02)) {
    return distance2d(var_04, self.var_0116) < param_01 && abs(var_04[2] - self.var_0116[2]) < param_02;
  }

  return distance2d(var_04, self.var_0116) < param_01 && self.var_0116[2] < var_04[2];
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

  playFXOnTag(level.var_0611[var_06], param_00, var_07);
  playFXOnTag(level.var_0611["zmb_gk_claw_battery_charge_1"], level.var_3571, "flap1_shroud");
  playFXOnTag(level.var_0611["zmb_gk_claw_battery_charge_2"], level.var_3571, "flap2_shroud");
  playFXOnTag(level.var_0611["zmb_gk_claw_battery_charge_3"], level.var_3571, "flap3_shroud");
  lib_0378::func_8D74("zombie_soul_suck", var_04.var_0116, param_00.var_0116);
  wait(0.45);
  var_05 delete();
  level.var_6666--;
}

func_9030(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  for(var_03 = 0; var_03 < param_02; var_03++) {
    var_04 = spawn("script_model", self.var_0116);
    var_04 setModel("tag_origin");
    playFXOnTag(common_scripts\utility::func_44F5("zmb_elec_trail"), var_04, "tag_origin");
    var_05 = distance(self.var_0116, param_00.var_0116) / param_01;
    var_04 moveto(param_00.var_0116, var_05);
    wait(var_05);
    var_04 delete();
  }
}

func_283C(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawn("script_model", param_00);
  var_06.var_001D = vectortoangles(param_01 + (0, 0, -50) - param_00);
  var_06 setModel(param_04);
  var_06 scriptmodelplayanim(param_05, "", param_02);
  var_06 rotateroll(randomfloat(param_03), 1, 0.1, 0.1);
  var_06 rotatepitch(-20, 1, 0.1, 0);
  return var_06;
}

func_9066(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.var_0611[param_03])) {
    return;
  }

  var_05 = spawn("script_model", param_02);
  var_05 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5(param_03), var_05, "tag_origin");
  var_05 method_8449(param_00, param_01);
  var_05 thread func_36EC(param_03, param_04);
}

func_36EC(param_00, param_01) {
  level waittill(param_01);
  self delete();
}

func_282D() {}

func_649B(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_08 = 8;
  self.var_5787 = 0;
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(isDefined(param_04)) {
    self.var_9D02 = param_04;
  }

  var_09 = 1;
  while(var_09 < param_00.size) {
    var_0A = param_00[var_09 - 1];
    var_0B = param_00[var_09];
    var_0C = param_00[var_09 + 1];
    var_0D = func_0F3B(param_02, var_0B);
    if(isDefined(param_04) && !self.var_5787) {
      func_930B();
    }

    if(!func_8B8D(var_0B) || var_09 + 1 == param_00.size) {
      var_0E = distance(var_0B.var_0116, var_0A.var_0116) / param_01;
      if(var_0D) {
        var_0F = var_0E / 3;
      } else {
        var_0F = 0;
      }

      func_64D3(var_0B, var_0E, var_0F);
    } else {
      var_0A = var_0A + 1;
      var_10 = var_0B.var_0116;
      var_11 = var_0C.var_0116;
      var_12 = var_0D.var_0116;
      func_64A1(var_10, var_11, var_12, var_09, param_02);
    }

    self waittill("reached node");
    if(var_0E) {
      func_9416();
      func_A699();
      wait(1);
    }

    var_0A++;
  }

  if(param_05) {
    param_06 unlink();
    var_13 = vectornormalize(param_00[param_00.size - 1].var_0116 - param_00[param_00.size - 2].var_0116);
    var_14 = param_01;
    var_15 = (var_14 * var_13[0], var_14 * var_13[1], var_14 * var_13[2]);
    param_06 setvelocity(var_15);
  }

  func_9416();
  self notify("path complete");
}

func_A6AC(param_00) {
  var_01 = common_scripts\utility::func_8FFC();
  foreach(var_03 in param_00) {
    var_03 thread func_6815(var_01);
  }

  var_01 waittill("trigger", var_05);
  var_01 delete();
  return var_05;
}

func_6815(param_00) {
  self waittill("trigger", var_01);
  param_00 notify("trigger", var_01);
}

func_0FB7() {
  foreach(var_01 in self) {
    var_01 common_scripts\utility::func_9D9F();
  }
}

func_0FB8() {
  foreach(var_01 in self) {
    var_01 common_scripts\utility::func_9DA3();
  }
}

func_3C28() {
  self endon("flame_jets_done");
  var_00 = common_scripts\utility::func_46B5("well_explosion", "script_noteworthy");
  var_01 = common_scripts\utility::func_46B5(var_00.var_01A2, "targetname");
  var_02 = common_scripts\utility::func_46B5(var_01.var_01A2, "targetname");
  var_03 = 2;
  var_04 = [];
  for(var_05 = 0; var_05 < var_03; var_05++) {
    var_04[var_05] = [];
    var_04[var_05] = func_45FF("fire_path_launch_side_" + var_05 + 1);
  }

  foreach(var_07 in level.var_744A) {
    thread func_A6A1(var_07, var_00, var_01, var_02, var_04);
  }
}

func_A6A1(param_00, param_01, param_02, param_03, param_04) {
  self endon("flame_jets_done");
  var_05 = [];
  for(var_06 = 0; var_06 < param_04.size; var_06++) {
    if(!param_04[var_06][0].var_01A5 == "fire_path_launch_side_1") {
      var_05 = common_scripts\utility::func_0F6F(var_05, param_04[var_06]);
    }
  }

  for(;;) {
    param_00 waittill("fire_touched");
    if(!common_scripts\utility::func_562E(param_00.var_5685) && common_scripts\utility::func_562E(level.var_665A)) {
      if(distance2d(param_00.var_0116, param_01.var_0116) < param_01.var_014F) {
        param_00.var_5685 = 1;
        param_00 thread func_2FAD();
        param_00 thread func_8CD6(param_01, param_02, param_03);
        continue;
      }

      if(param_00.var_0116[2] < param_01.var_0116[2]) {
        param_00.var_5685 = 1;
        param_00 thread func_2FAD();
        if(common_scripts\utility::func_562E(level.var_1CBA)) {
          param_00 thread func_3C25(var_05);
          continue;
        }

        param_00 thread func_3C25(param_04);
      }
    }
  }
}

func_2FAD() {
  var_00 = self getcurrentweapon();
  self method_8322();
  self shellshock("frag_grenade_mp", 1);
  wait(0.25);
  self method_8323();
}

func_47C2(param_00, param_01, param_02) {
  wait(param_02);
  lib_0586::func_0790(param_00);
  self method_8327();
  lib_0586::func_078E(param_01);
}

func_3C25(param_00) {
  var_01 = [];
  var_02 = -1;
  var_03 = undefined;
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_05 = distance(self.var_0116, param_00[var_04][0].var_0116);
    if(var_02 == -1 || var_05 < var_02) {
      var_03 = param_00[var_04];
      var_02 = var_05;
    }
  }

  var_06 = lib_053F::func_44A6(var_03[0].var_0165);
  if(isDefined(var_06) && !common_scripts\utility::func_562E(var_06.var_6BE1)) {
    return;
  }

  var_07 = var_03;
  var_03 = func_9DC8(var_03, self);
  if(isDefined(var_03) && var_03.size >= 2) {
    func_86E4(var_03);
    return;
  }

  func_86E4(var_07);
}

func_9DC8(param_00, param_01) {
  var_02 = 0;
  var_03 = -1;
  for(var_04 = 1; var_04 < param_00.size; var_04++) {
    var_05 = distance(param_01.var_0116, param_00[var_04].var_0116);
    var_06 = distance(param_01.var_0116, param_00[var_02].var_0116);
    if(var_03 == -1 || var_05 < var_06) {
      var_02 = var_04;
      var_03 = var_05;
    }
  }

  var_07 = [];
  for(var_04 = var_02; var_04 < param_00.size; var_04++) {
    var_07[var_07.size] = param_00[var_04];
  }

  if(var_07.size >= 3) {
    var_07 = common_scripts\utility::func_0F93(var_07, var_07[0]);
  }

  return var_07;
}

func_86E4(param_00) {
  var_01 = func_90A9(self.var_0116);
  var_01.var_0116 = param_00[0].var_0116;
  var_01.var_001D = param_00[0].var_001D;
  self.var_0116 = var_01.var_0116;
  self setangles(var_01.var_001D);
  self playerlinktoabsolute(var_01);
  var_01 thread func_649B(param_00, 1000, 0, undefined, undefined, 1, self);
  var_01 waittill("path complete");
  self unlink();
  var_01 delete();
}

func_8CD6(param_00, param_01, param_02) {
  var_03 = 800;
  var_04 = 800;
  var_05 = param_00.var_0116 + (0, 0, 32);
  var_06 = var_05[2] - self.var_0116[2];
  if(var_06 > 0) {
    var_07 = common_scripts\utility::func_8FFC();
    self playerlinkto(var_07);
    var_08 = var_06 / var_04;
    var_07 moveto((self.var_0116[0], self.var_0116[1], var_05[2]), var_08);
    wait(var_08);
    self unlink();
    var_07 delete();
  }

  var_09 = -64;
  var_0A = abs(param_01.var_0116[2] - self.var_0116[2]);
  var_0A = var_0A + var_09;
  var_0B = abs(distance2d(var_05, param_02.var_0116) - distance2d(var_05, self.var_0116));
  var_0C = sqrt(2 * var_03 * var_0A);
  var_0D = abs(func_8F12(0.5 * var_03, var_0C, var_05[2] - self.var_0116[2]));
  var_0E = var_0C / var_03;
  var_0F = vectornormalize(self.var_0116 - (var_05[0], var_05[1], self.var_0116[2]));
  var_10 = var_0B / var_0D;
  var_11 = (var_10 * var_0F[0], var_10 * var_0F[1], var_0C);
  var_12 = common_scripts\utility::func_46B5("nest_ee_arm_fire_objective_angle", "targetname");
  self setvelocity(var_11);
  thread func_7726(var_0E, param_01.var_0116[2] + var_09);
  thread func_7722(var_0D, distance2d(var_05, param_02.var_0116), var_05);
}

func_A016(param_00, param_01) {
  wait(param_00);
  self unlink();
  param_01 delete();
}

func_8F12(param_00, param_01, param_02) {
  var_03 = param_01 * param_01 - 4 * param_00 * param_02;
  var_04 = 0;
  var_05 = 0;
  if(var_03 > 0) {
    var_04 = -1 * param_01 + sqrt(var_03) / 2 * param_00;
    var_05 = -1 * param_01 - sqrt(var_03) / 2 * param_00;
  }

  return var_05;
}

func_7726(param_00, param_01) {
  wait(param_00);
}

func_7722(param_00, param_01, param_02) {
  wait(param_00);
}

func_9416() {
  self.var_5787 = 0;
  self stoploopsound(self.var_9D02);
}

func_930B() {
  self method_861D(self.var_9D02);
  self.var_5787 = 1;
}

func_8B8D(param_00) {
  return param_00 func_576F();
}

func_202C() {
  return isDefined(level.var_3571) && common_scripts\utility::func_562E(level.var_3571.var_692A);
}

func_64D3(param_00, param_01, param_02) {
  thread func_321A(param_00, param_01, param_02);
}

func_321A(param_00, param_01, param_02) {
  self moveto(param_00.var_0116, param_01, 0, param_02);
  self rotateto(param_00.var_001D, param_01 / 2);
  wait(param_01);
  self notify("reached node");
}

func_0F3B(param_00, param_01) {
  return param_00 && param_01 func_56AC();
}

func_64A1(param_00, param_01, param_02, param_03, param_04) {
  thread func_38DF(param_00, param_01, param_02, param_03, param_04);
}

func_38DF(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00;
  for(var_06 = 0; var_06 < param_03; var_06++) {
    var_07 = var_06 / param_03;
    var_08 = func_1E4C(param_00, param_01, param_02, var_07);
    var_09 = distance(var_08, var_05) / param_04;
    var_05 = var_08;
    if(!var_09 > 0) {
      var_09 = 0.1;
    }

    self moveto(var_08, var_09);
    wait(var_09);
  }

  self notify("reached node");
}

func_A699(param_00, param_01) {
  if(isDefined(param_00) && !isDefined(param_01)) {
    param_01 = "TAG_ORIGIN";
  }

  if(isDefined(param_00)) {
    playFXOnTag(common_scripts\utility::func_44F5(param_00), self, param_01);
  }

  self.var_2DA8 = 1;
  self waittill("destination requirement satisfied");
  self.var_2DA8 = 0;
  if(isDefined(param_00)) {
    stopFXOnTag(common_scripts\utility::func_44F5(param_00), self, param_01);
  }
}

func_56AF(param_00, param_01) {
  return distance2d(param_00, self.var_0116) < param_01;
}

func_5687(param_00) {
  return self.var_0116[2] < param_00[2];
}

func_565C(param_00) {
  return self.var_0116[2] > param_00[2];
}

func_1E4C(param_00, param_01, param_02, param_03) {
  return param_00 * squared(1 - param_03) + param_01 * 2 * param_03 * 1 - param_03 + param_02 * squared(param_03);
}

func_8B8A(param_00) {
  return distance(self.var_0116, param_00) < 64 && isalive(self) && !common_scripts\utility::func_562E(self.var_98EF) && !common_scripts\utility::func_562E(self.var_AC06);
}

func_A6BB() {
  while(!isDefined(level.var_744A)) {
    wait(0.1);
  }
}

func_9484(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01[var_02] = param_00[var_02].var_0116;
  }

  return var_01;
}

func_45FF(param_00) {
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  for(var_02 = [var_01]; !var_01 func_5773(); var_02 = common_scripts\utility::func_0F6F(var_02, var_01)) {
    var_01 = common_scripts\utility::func_46B5(var_01.var_01A2, "targetname");
  }

  return var_02;
}

func_5773() {
  return isDefined(self.var_0165) && self.var_0165 == "path_end";
}

func_576F() {
  return isDefined(self.var_0165) && self.var_0165 == "spline_start";
}

func_56AC() {
  return isDefined(self.var_0165) && self.var_0165 == "destination_point";
}

func_A16D(param_00) {
  if(isDefined(self.var_3F3F)) {
    self.var_3F3F delete();
  }

  var_01 = undefined;
  switch (param_00) {
    case "red":
      var_01 = "zmb_nest_generator_bulb_red";
      break;

    case "green":
      var_01 = "zmb_nest_generator_bulb_green";
      break;

    default:
      break;
  }

  if(isDefined(var_01)) {
    self.var_3F3F = spawnfx(common_scripts\utility::func_44F5(var_01), self.var_0116, anglesToForward(self.var_001D), anglestoup(self.var_001D));
    self.var_2916 = param_00;
  }

  if(gettime() < 500) {
    triggerfx(self.var_3F3F, 0.5);
    return;
  }

  triggerfx(self.var_3F3F);
}

func_21CF(param_00, param_01, param_02, param_03) {
  return func_56B0(param_00, param_01, param_02, param_03);
}

func_865C(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_2A9D = param_00;
    return;
  }

  if(self.var_0BA4 != "traverse") {
    self.var_2A9D = param_00;
  }
}

func_64DC(param_00, param_01, param_02, param_03) {
  self endon(param_02);
  var_04 = self.var_0116;
  var_05 = param_01 / param_03;
  for(var_06 = 0; var_06 < param_01; var_06 = var_06 + var_05) {
    self moveto(vectorlerp(var_04, param_00, var_06 / param_01), var_05);
    wait(var_05);
  }
}

func_90A9(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin");
  return var_01;
}

func_3E23() {
  self setstance("prone");
  self method_8113(0);
  self method_8112(0);
}

func_1F3D() {
  self method_8113(1);
  self method_8112(1);
  thread func_2CEB(0.5);
}

func_2CEB(param_00) {
  wait(param_00);
  self setstance("stand");
}

func_8A64(param_00) {
  lib_0586::func_078C(param_00);
  lib_0586::func_078E(param_00);
}

func_2CDD(param_00) {
  func_A6BB();
  wait(3);
}

func_745D(param_00, param_01, param_02) {
  if(!isDefined(level.var_744A)) {
    return [0, undefined];
  }

  foreach(var_04 in level.var_744A) {
    if(distance2d(var_04.var_0116, param_00) < param_01 && abs(var_04.var_0116[2] - param_00[2]) < param_02 / 2) {
      return [1, var_04];
    }
  }

  return [0, undefined];
}

func_44C8(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = [];
  if(param_01) {
    var_02[0] = common_scripts\utility::func_46B5(param_00, "targetname");
  } else {
    var_02[0] = getent(param_00, "targetname");
  }

  while(isDefined(var_02[var_02.size - 1].var_01A2)) {
    if(param_01) {
      var_02 = common_scripts\utility::func_0F6F(var_02, common_scripts\utility::func_46B5(var_02[var_02.size - 1].var_01A2, "targetname"));
      continue;
    }

    var_02 = common_scripts\utility::func_0F6F(var_02, getent(var_02[var_02.size - 1].var_01A2, "targetname"));
  }

  return var_02;
}

func_73B8() {
  self endon("disconnect");
  for(;;) {
    if(common_scripts\utility::func_3C77("flag_bunker_lights_off")) {
      if(func_7402()) {
        if(!isDefined(self.var_3D4C)) {
          lib_0551::func_3D52(1);
        }
      } else if(isDefined(self.var_3D4C)) {
        lib_0551::func_3D52(0);
      }
    } else {
      if(isDefined(self.var_3D4C)) {
        lib_0551::func_3D52(0);
      }

      common_scripts\utility::func_3C9F("flag_bunker_lights_off");
    }

    wait(1);
  }
}

func_08B0() {
  var_00 = getanimlength(%zmb_untotenpresse_01_reset);
  var_01 = getnotetracktimes(%zmb_untotenpresse_01_reset, "create_ww_part");
  var_02 = var_01[0] * var_00;
  var_03 = function_021F("med_untotenpresse_smasher", "targetname");
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("smasher", "working", 0);
    var_05 lib_0378::func_8D74("aud_start_med_forge");
  }

  wait(getanimlength(%zmb_untotenpresse_01_activate));
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("smasher", "reset", 0);
  }

  wait(var_02);
  level notify("med_create_ww_part");
  wait(var_00 - var_02);
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("smasher", "refill", 0);
  }

  wait(getanimlength(%zmb_untotenpresse_01_refill));
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("smasher", "second_idle", 0);
  }
}

func_08B6() {
  var_00 = % zmb_forge_machine_01_parts_activate_01;
  var_01 = getanimlength(var_00);
  var_02 = getnotetracktimes(var_00, "piston_hit");
  var_03 = getnotetracktimes(var_00, "create_ww_part");
  var_04 = getnotetracktimes(var_00, "show_ww_part");
  var_05 = [];
  for(var_06 = 0; var_06 < var_02.size; var_06++) {
    var_05[var_06] = var_02[var_06] * var_01;
  }

  var_07 = var_04[0] * var_01;
  var_08 = var_03[0] * var_01;
  var_09 = function_021F("rnd_forge_machine_parts", "targetname");
  var_09[0] thread func_7EB0(var_05, var_01);
  foreach(var_0B in var_09) {
    var_0B setscriptablepartstate("pistons", "working", 0);
    var_0B setscriptablepartstate("core", "working", 0);
    var_0B lib_0378::func_8D74("aud_start_rnd_forge");
  }

  wait(var_07);
  level notify("rnd_show_ww_part");
  wait(var_08 - var_07);
  level notify("rnd_create_ww_part");
  wait(var_01 - var_08 - var_07);
  level notify("rnd_stop_pistons");
  foreach(var_0B in var_09) {
    var_0B setscriptablepartstate("core", "idle", 0);
    var_0B setscriptablepartstate("pistons", "idle", 0);
  }
}

func_7EB0(param_00, param_01) {
  level endon("rnd_stop_pistons");
  if(param_00.size == 0) {
    return;
  }

  var_02 = 0;
  var_03 = 0;
  for(;;) {
    if(!isDefined(param_00[var_03])) {
      break;
    }

    wait(param_00[var_03] - var_02);
    var_02 = param_00[var_03];
    var_03++;
    thread func_74D2();
  }
}

func_74D2() {
  earthquake(0.25, 0.25, self.var_0116, 500);
  function_01BB("artillery_rumble", self.var_0116);
}

func_08A8() {
  var_00 = getEntArray("com_control_elec", "targetname");
  foreach(var_02 in var_00) {
    var_02.schnelleeffects = spawnfx(level.var_0611["zmb_electroschnelle_reg_chg_wv"], var_02.var_0116, anglesToForward(var_02.var_001D));
    triggerfx(var_02.schnelleeffects);
  }

  var_04 = function_021F("workbench_inner", "targetname");
  var_05 = getanimlength(%zmb_workbench_01_inner_up);
  var_06 = getanimlength(%zmb_workbench_01_inner_up_idle);
  var_07 = getanimlength(%zmb_workbench_01_inner_down);
  foreach(var_09 in var_04) {
    var_09 setscriptablepartstate("inner", "up", 0);
  }

  playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_1"], level.var_3571, "flap1_shroud");
  playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_2"], level.var_3571, "flap2_shroud");
  playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_3"], level.var_3571, "flap3_shroud");
  wait(var_05);
  foreach(var_09 in var_04) {
    var_09 setscriptablepartstate("inner", "up_idle", 0);
  }

  wait(var_06);
  foreach(var_09 in var_04) {
    var_09 setscriptablepartstate("inner", "down", 0);
  }

  wait(var_07);
  foreach(var_02 in var_00) {
    var_02.schnelleeffects delete();
  }
}

func_8A53() {
  var_00 = spawnStruct();
  var_00.var_6FC5 = getent("ww_part_01_pickup", "targetname");
  var_00.var_6FC2 = getent(var_00.var_6FC5.var_01A2, "targetname");
  playFXOnTag(level.var_0611["zmb_tesla_barrel_prop_idle"], var_00.var_6FC2, "TAG_ORIGIN");
  var_01 = spawnStruct();
  var_01.var_6FC5 = getent("ww_part_02_pickup", "targetname");
  var_01.var_6FC2 = getent(var_01.var_6FC5.var_01A2, "targetname");
  playFXOnTag(level.var_0611["zmb_tesla_tube_prop_idle"], var_01.var_6FC2, "TAG_ORIGIN");
  var_00.var_6FC5 common_scripts\utility::func_9D9F();
  var_01.var_6FC5 common_scripts\utility::func_9D9F();
  var_00.var_6FC5 usetriggerrequirelookat();
  var_01.var_6FC5 usetriggerrequirelookat();
  if(isDefined(var_00.var_6FC2) && isDefined(var_01.var_6FC2)) {
    var_00.var_6FC2 method_805C();
    var_01.var_6FC2 method_805C();
  }

  var_02 = function_021F("rnd_forge_machine_parts", "targetname");
  var_00.var_6FC2 linkto(var_02[0], "input");
  level.var_3E3B = var_00;
  level.var_5981 = var_01;
}

func_8BEC(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    self.var_6FC5 sethintstring(param_03);
  }

  if(isDefined(param_00)) {
    common_scripts\utility::func_3C9F(param_00);
  }

  self.var_6FC2 method_805B();
  if(isDefined(param_02)) {
    common_scripts\utility::func_3C9F(param_02);
  }

  self.var_6FC5 common_scripts\utility::func_9DA3();
  self.var_6FC5 waittill("trigger", var_04);
  if(isDefined(param_01)) {
    common_scripts\utility::func_3C8F(param_01);
  }

  self.var_6FC5 common_scripts\utility::func_9D9F();
  self.var_6FC2 method_805C();
  return var_04;
}

func_4D76() {
  var_00 = % zmb_hilt_altar_control_activate;
  var_01 = getanimlength(var_00);
  self scriptmodelplayanim(getanimname(var_00));
  wait(var_01);
}

func_4D77(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  switch (param_00) {
    case "off":
      self hidepart("TAG_LIGHT_OFF");
      self hidepart("TAG_LIGHT_ON");
      break;

    case "red":
      self hidepart("TAG_LIGHT_ON");
      self showpart("TAG_LIGHT_OFF");
      break;

    case "green":
      self hidepart("TAG_LIGHT_OFF");
      self showpart("TAG_LIGHT_ON");
      break;
  }
}

func_4D78(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = function_021F("hilt_symbol_wheel", "targetname");
  var_02 = getanimlength(%s2_zom_prop_symbol_wheel_lh_p1);
  var_03 = getanimlength(%s2_zom_prop_symbol_wheel_lh_p2);
  var_04 = getanimlength(%s2_zom_prop_symbol_wheel_rh_p1);
  var_05 = getanimlength(%s2_zom_prop_symbol_wheel_rh_p2);
  var_06 = 1;
  var_07 = 1;
  var_08 = "p4_idle";
  var_09 = "p4_idle";
  switch (param_00) {
    case 0:
      break;

    case 1:
      var_08 = "p1";
      var_06 = var_02;
      var_09 = "p4_idle";
      break;

    case 2:
      var_08 = "p1_idle";
      var_09 = "p1";
      var_07 = var_04;
      break;

    case 3:
      var_08 = "p2";
      var_06 = var_03;
      var_09 = "p2";
      var_07 = var_05;
      break;
  }

  foreach(var_0B in var_01) {
    var_0B thread func_A197("wheel_l", var_08, var_06);
    var_0B thread func_A197("wheel_r", var_09, var_07);
  }

  wait(max(var_06, var_07));
}

func_A197(param_00, param_01, param_02) {
  switch (param_01) {
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      self setscriptablepartstate(param_00, param_01);
      wait(param_02);
      self setscriptablepartstate(param_00, param_01 + "_idle");
      break;

    case "p3_idle":
    case "p2_idle":
    case "p1_idle":
    case "p4_idle":
      self setscriptablepartstate(param_00, param_01);
      break;
  }
}

func_7212(param_00) {
  var_01 = func_4649();
  if(isDefined(var_01)) {
    var_01 thread lib_0367::func_8E3C(param_00);
  }
}

func_4649() {
  var_00 = func_440D();
  return common_scripts\utility::func_7A33(var_00);
}

func_440D() {
  var_00 = [];
  foreach(var_02 in level.var_744A) {
    if(isalive(var_02) && !var_02.var_5378) {
      var_00 = common_scripts\utility::func_0F6F(var_00, var_02);
    }
  }

  return var_00;
}

func_8A38(param_00, param_01, param_02) {
  var_03 = undefined;
  foreach(var_05 in level.var_A2A0) {
    if(lib_0547::func_5565(var_05.var_01A5, param_00)) {
      var_03 = var_05;
    }
  }

  if(isDefined(param_01) && isDefined(var_03.var_9D65)) {
    var_03 lib_0547::func_A28D(param_01, param_02);
    var_03.var_9D65 sethintstring(param_01);
  }

  return var_03;
}

func_7213(param_00, param_01, param_02, param_03) {
  var_04 = [0, undefined];
  while(!var_04[0]) {
    var_04 = func_745D(param_01, param_02, param_03);
    wait(1);
  }

  var_04[1] thread lib_0367::func_8E3C(param_00);
}

func_720B(param_00, param_01, param_02, param_03) {
  var_04 = [0, undefined];
  while(!var_04[0]) {
    var_04 = func_745D(param_01, param_02, param_03);
    wait(1);
  }

  var_04[1] thread lib_0367::func_8E3B(param_00);
}

func_4462(param_00) {
  var_01 = func_440D();
  return common_scripts\utility::func_4461(param_00, var_01);
}

func_44BA(param_00) {
  var_01 = "mp/zombieSpecialEnemyWaves.csv";
  var_02 = [];
  param_00 = param_00 - 1;
  var_03 = param_00 * 5;
  var_04 = lib_0547::func_9470(tablelookupbyrow(var_01, var_03 + 0, 2));
  var_05 = lib_0547::func_9470(tablelookupbyrow(var_01, var_03 + 1, 2));
  var_06 = lib_0547::func_9470(tablelookupbyrow(var_01, var_03 + 2, 2));
  var_07 = lib_0547::func_9470(tablelookupbyrow(var_01, var_03 + 3, 2));
  var_08 = lib_0547::func_9470(tablelookupbyrow(var_01, var_03 + 4, 2));
  for(var_09 = 0; var_09 < var_04; var_09++) {
    var_02 = common_scripts\utility::func_0F6F(var_02, "zombie_generic");
  }

  for(var_09 = 0; var_09 < var_05; var_09++) {
    var_02 = common_scripts\utility::func_0F6F(var_02, "zombie_berserker");
  }

  for(var_09 = 0; var_09 < var_06; var_09++) {
    var_02 = common_scripts\utility::func_0F6F(var_02, "zombie_exploder");
  }

  for(var_09 = 0; var_09 < var_07; var_09++) {
    var_02 = common_scripts\utility::func_0F6F(var_02, "zombie_heavy");
  }

  level.var_2932 = 0;
  for(var_09 = 0; var_09 < var_08; var_09++) {
    level.var_2932++;
  }

  return common_scripts\utility::func_0F92(var_02);
}

func_44BB(param_00) {
  param_00 = param_00 - 1;
  var_01 = param_00 * 5;
  var_02 = "mp/zombieSpecialEnemyWaves.csv";
  var_03 = lib_0547::func_9470(tablelookupbyrow(var_02, var_01, 3));
  return var_03;
}

func_A7DF() {
  level notify("exited_special_event");
  wait 0.05;
  maps\mp\zombies\_zombies_magicbox::func_A7E5(0);
  foreach(var_01 in level.var_744A) {
    var_01 notify("special_event_update");
  }
}

func_A7E0() {
  level endon("exited_special_event");
  maps\mp\zombies\_zombies_magicbox::func_A7E5(1);
  foreach(var_01 in level.var_744A) {
    var_01 notify("special_event_update");
  }

  for(;;) {
    level waittill("connected", var_01);
    var_01 notify("special_event_update");
  }
}

func_A725(param_00) {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isPlayer(var_02)) {
      continue;
    }

    if(!isDefined(var_0A) || !issubstr(var_0A, param_00)) {
      continue;
    }

    break;
  }
}

func_98ED(param_00, param_01) {
  switch (param_00) {
    case "teslagun_zm":
      param_01 = 2000;
      break;

    case "teslagun_zm_blood":
      param_01 = 3000;
      break;

    case "teslagun_zm_death":
      param_01 = 3000;
      break;

    case "teslagun_zm_moon":
      param_01 = 3000;
      break;

    case "teslagun_zm_storm":
      param_01 = 3000;
      break;

    default:
      break;
  }

  return param_01;
}