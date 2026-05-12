/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_hc_toy_arms.gsc
*****************************************************/

func_00F9() {
  level.var_665D = [];
  level.var_665F = [randomint(12) + 1, randomint(12) + 1, randomint(12) + 1];
  common_scripts\utility::func_3C87("flag_nest_hc_ee_record_acquired");
  var_00 = func_52EE();
  lib_0557::func_4BC9("toy 0 get");
  lib_0557::func_4BC9("toy 1 get");
  lib_0557::func_4BC9("toy 2 get");
  lib_0557::func_4BC9("toy record get", "obtaining toy record", "CONST_HC_ANALYTICS_TOY_RECORD_GET");
  lib_0557::func_4BC9("fire monkey down", "grabbing toys", "CONST_HC_ANALYTICS_TOYS_GOTTEN");
  level thread func_171D(var_00);
  level thread func_21AF(var_00["trigger"]);
  level thread func_7E3C(var_00["reward_pickup"], var_00["trigger"]);
}

func_47A4() {
  level.var_665D[0] = 1;
  level.var_665D[1] = 2;
  level.var_665D[2] = 3;
}

func_7E3C(param_00, param_01) {
  param_00 method_805C();
  level waittill("hc_nest_toy_obj_complete");
  var_02 = getent("nest_hc_record_drawer", "targetname");
  var_03 = common_scripts\utility::func_46B5(var_02.var_01A2, "targetname");
  param_00 method_805B();
  param_00 method_8449(var_02);
  var_02 lib_0378::func_8D74("aud_spinning_top_drawer_open");
  var_02 moveto(var_03.var_0116, 1.5, 0, 0.5);
  wait(1.5);
  param_00 unlink();
  param_00 func_A665(param_01);
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_record_acquired");
  param_00 delete();
  level.var_4BD3 = 1;
  var_02 lib_0378::func_8D74("aud_spinning_top_record_obtained");
  lib_0557::func_4BC8("toy record get");
  getrecordreward();
}

func_A665(param_00) {
  for(var_01 = 0; !var_01; var_01 = maps\mp\_utility::func_3B8E(var_02, self, 15)) {
    param_00 waittill("trigger", var_02);
  }
}

func_8F6F(param_00, param_01) {
  var_02 = spawn("script_model", self.var_0116);
  var_02 setModel("zmb_ob_topper_0" + self.var_0165);
  var_02.var_001D = self.var_001D;
  var_02.var_01A2 = self.var_01A2;
  var_02.var_0F5E = param_00;
  var_02.var_01A5 = "nest_ee_hc_shootable_arm_spawn";
  var_02 thread func_8B1B();
  if(common_scripts\utility::func_562E(param_01)) {
    var_02 hudoutlineenable(param_00, 0);
  }
}

func_8573(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B7(param_00, "targetname");
  foreach(var_04 in var_02) {
    var_05 = common_scripts\utility::func_44BE(var_04.var_01A2, "targetname");
    foreach(var_07 in var_05) {
      if(!isDefined(var_07.var_0165)) {
        continue;
      }

      switch (var_07.var_0165) {
        case "hc_dial_1":
          var_04.var_4BCC = var_07;
          break;

        case "hc_dial_2":
          var_04.var_4BCD = var_07;
          break;

        case "hc_rotor_holder":
          var_04.var_4BD2 = var_07;
          break;

        case "hc_rotor_bow":
          var_04.var_4BD1 = var_07;
          break;

        case "hc_dial_light":
          var_04.var_4BCE = var_07;
          break;
      }
    }
  }

  var_0A = common_scripts\utility::func_7A33(var_02);
  foreach(var_04 in var_02) {
    if(var_04 == var_0A) {
      continue;
    }

    var_04.var_4BCC delete();
    var_04.var_4BCD delete();
    var_04.var_4BD2 delete();
    var_04.var_4BD1 delete();
  }

  var_0A thread func_7A50(level.var_665F[param_01]);
  return var_0A;
}

func_8BD3() {
  if(isDefined(self.var_4BCE)) {
    var_00 = lib_0547::func_8FBA(self.var_4BCE, "zmb_hc_rotor_lighting_fx");
    triggerfx(var_00);
  }
}

func_171D(param_00) {
  var_01 = 0;
  var_02 = func_8573("nest_ee_hc_rotor_red", 2);
  var_03 = func_8573("nest_ee_hc_rotor_yellow", 0);
  var_04 = func_8573("nest_ee_hc_rotor_blue", 1);
  wait 0.05;
  var_02 func_8BD3();
  var_03 func_8BD3();
  var_04 func_4CEA();
  foreach(var_07 in param_00["shootable_arms"]) {
    var_0E = var_01;
    var_01++;
    common_scripts\utility::func_3C87("flag_nest_hc_ee_has_arm_" + var_01);
    var_08 = common_scripts\utility::func_46B7(var_07.var_01A2, "targetname");
    var_0F = common_scripts\utility::func_7A33(var_08);
    var_0F func_8F6F(var_0E);
  }

  var_11 = func_4421();
  level.var_47CC = 0;
  var_12 = [];
  for(var_13 = 0; var_13 < 3; var_13++) {
    var_12[var_13] = spawn("script_model", param_00["trigger"].var_65DD[var_13].var_0116);
    var_12[var_13].var_01A5 = "nest_ee_hc_top_interact";
    var_12[var_13].var_65E9 = "zmb_ob_topper_0" + var_13 + 1;
    var_12[var_13] setModel("tag_origin");
    var_12[var_13].var_001D = var_11[5].var_001D;
    var_12[var_13].var_65E0 = 6;
  }

  var_12[0].var_65E5 = 0;
  var_12[1].var_65E5 = 2;
  var_12[2].var_65E5 = 1;
  param_00["trigger"].var_7EF9 = var_12;
  param_00["trigger"] thread func_6803(var_12);
  foreach(var_15 in var_12) {
    var_15 thread func_7EEC(var_11);
  }

  var_17 = getent("firewell_grab_test", "targetname");
  var_18 = getent(var_17.var_01A2, "targetname");
  level thread func_4833(var_17, var_04);
}

func_4CEA() {
  self.var_4BCC method_805C();
  self.var_4BCD method_805C();
  self.var_4BD2 method_805C();
  self.var_4BD1 method_805C();
}

func_8BD2() {
  self.var_4BCC method_805B();
  self.var_4BCD method_805B();
  self.var_4BD2 method_805B();
  self.var_4BD1 method_805B();
}

func_7A50(param_00) {
  var_01[0] = self.var_4BCC;
  var_01[1] = self.var_4BCD;
  var_02 = [0, 0];
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = 0;
    var_05 = pow(10, var_02.size - var_03);
    while(param_00 >= var_05 / 10) {
      param_00 = param_00 - var_05 / 10;
      var_04++;
    }

    var_02[var_03] = var_04;
  }

  var_06 = 36;
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_07 = var_06 * var_02[var_03] - 1;
    var_01[var_03] rotateby((0, 0, -1 * var_07), 0.5);
  }
}

func_6803(param_00) {
  for(;;) {
    self waittill("trigger", var_01);
    foreach(var_03 in param_00) {
      if(maps\mp\_utility::func_3B8E(var_01, var_03, 15)) {
        var_03 notify("top_interact", var_01);
        break;
      }
    }
  }
}

func_7EEC(param_00) {
  level endon("hc_nest_toy_obj_complete");
  self.var_65E0 = 6;
  self.var_001D = param_00[5].var_001D;
  var_01 = 0;
  var_02 = getglass("window_shatter_toyshop");
  while(!var_01) {
    self waittill("top_interact", var_03);
    if(isDefined(var_02)) {
      destroyglass(var_02);
    }

    if(common_scripts\utility::func_0F79(level.var_665D, self.var_65E5 + 1)) {
      var_01 = 1;
      level.var_665D = common_scripts\utility::func_0F93(level.var_665D, self.var_65E5 + 1);
      lib_0378::func_8D74("aud_spinning_top_place");
    }
  }

  self setModel(self.var_65E9);
  for(;;) {
    self waittill("top_interact", var_03);
    self.var_65E0 = common_scripts\utility::func_98E7(self.var_65E0 == 12, 1, self.var_65E0 + 1);
    var_04 = param_00[self.var_65E0 - 1].var_001D;
    lib_0378::func_8D74("aud_spinning_top_turn");
    self rotateby((-30, 0, 0), 0.05);
    wait 0.05;
    if(self.var_65E0 == 9) {
      self.var_001D = var_04;
    }

    level notify("nest_ee_arm_code_check");
  }
}

func_4833(param_00, param_01) {
  param_00 lib_0547::func_AC41(&"ZOMBIES_EMPTY_STRING");
  param_00 waittill("player_used");
  var_02 = common_scripts\utility::func_46B5("monkey_hc_dropper", "targetname");
  var_03 = common_scripts\utility::func_46B7(var_02.var_01A2, "targetname");
  var_04 = function_021F("monkey_destructible", "targetname");
  var_05 = var_04[0];
  var_05 thread func_2DB2();
  foreach(var_07 in var_03) {
    var_08 = undefined;
    switch (var_07.var_0165) {
      case "zmb_code_dial_01":
        var_08 = "zmb_code_dial_01";
        break;
    }

    if(!isDefined(var_08)) {
      continue;
    }

    var_09 = spawn("script_model", var_07.var_0116);
    var_09 setModel(var_08);
    var_09.var_001D = var_07.var_001D;
  }

  param_01 func_8BD2();
  param_01 func_8BD3();
  lib_0557::func_4BC8("fire monkey down");
}

func_2DB2() {
  self setscriptablepartstate("Sign", "Fractured");
  wait 0.05;
  physicsexplosionsphere(self.var_0116, 100, 90, 1);
}

func_8B1B() {
  self setCanDamage(1);
  self waittill("damage");
  lib_0378::func_8D74("aud_spinning_top_shot");
  self.var_65E2 = common_scripts\utility::func_46B5(self.var_01A2, "targetname");
  func_348C(self.var_65E2);
  lib_0378::func_8D74("aud_spinning_top_fall");
  lib_0547::func_AC41(&"ZOMBIES_EMPTY_STRING", (0, 0, 64));
  self waittill("player_used", var_00);
  switch (self.var_0F5E) {
    case 0:
      lib_0557::func_4BC8("toy 0 get");
      break;

    case 1:
      lib_0557::func_4BC8("toy 1 get");
      break;

    case 2:
      lib_0557::func_4BC8("toy 2 get");
      break;
  }

  level.var_665D = common_scripts\utility::func_0F6F(level.var_665D, self.var_0F5E + 1);
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_has_arm_" + self.var_0F5E + 1);
  lib_0547::func_AC40();
  self delete();
}

func_348C(param_00) {
  var_01 = (0, 0, -800);
  var_02 = param_00.var_0116 - self.var_0116;
  var_03 = sqrt(abs(var_02[2] * 2 / 800));
  var_04 = 1 / var_03;
  var_05 = var_02 * (var_04, var_04, 0);
  self gravitymove(var_05, var_03);
  self rotateby((720, 720, 720), var_03, 0, var_03 / 2);
  wait(var_03);
  self.var_0116 = param_00.var_0116;
  if(isDefined(param_00.var_001D)) {
    self.var_001D = param_00.var_001D;
  }
}

func_21AF(param_00) {
  level endon("hc_nest_toy_obj_complete");
  var_01 = 0;
  while(!isDefined(param_00.var_7EF9)) {
    wait 0.05;
  }

  while(var_01 != param_00.var_7EF9.size) {
    level waittill("nest_ee_arm_code_check");
    var_01 = 0;
    for(var_02 = 0; var_02 < param_00.var_7EF9.size; var_02++) {
      if(param_00.var_7EF9[var_02].var_65E0 == level.var_665F[var_02]) {
        var_01++;
      }
    }
  }

  level notify("hc_nest_toy_obj_complete");
}

func_42F3() {
  return "flag_nest_hc_ee_record_acquired";
}

func_40AC(param_00) {
  return "flag_nest_hc_ee_has_arm_" + param_00;
}

func_6FCD() {
  var_00 = spawn("trigger_radius", self.var_0116, 0, 64, 64);
  var_01 = undefined;
  while(!isDefined(var_01) || !isPlayer(var_01)) {
    var_00 waittill("trigger", var_01);
  }

  var_00 delete();
  self delete();
  var_01 thread lib_057D::func_4766();
}

func_4421() {
  var_00 = [];
  for(var_01 = 0; var_01 < 12; var_01++) {
    var_00[var_01] = common_scripts\utility::func_46B5(var_01 + 1 + "oc", "script_noteworthy");
  }

  return var_00;
}

func_52EE() {
  var_00 = common_scripts\utility::func_46B5("nest_ee_hc_arm_models_struct", "targetname");
  var_01 = common_scripts\utility::func_46B7(var_00.var_01A2, "targetname");
  var_02 = getent("nest_ee_hc_arm_trig", "targetname");
  var_03 = maps\mp\mp_zombie_nest_ee_util::func_44C8("nest_ee_hc_arm_model_window", 1);
  var_02.var_65DD = var_03;
  var_04 = [];
  var_04["trigger"] = var_02;
  var_04["shootable_arms"] = var_01;
  var_04["reward_pickup"] = getent("nest_hc_record_spawn", "targetname");
  return var_04;
}

getrecordreward() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("record");
  }
}