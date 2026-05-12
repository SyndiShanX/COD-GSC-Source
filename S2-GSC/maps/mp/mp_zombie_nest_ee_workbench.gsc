/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_workbench.gsc
***************************************************/

func_536B() {
  var_00 = spawnStruct();
  var_00.var_10BD = getent("assemble_ww_trig", "targetname");
  var_00.var_AA68 = function_021F(var_00.var_10BD.var_01A2, "targetname");
  foreach(var_02 in var_00.var_AA68) {
    var_03 = var_02 method_85CE();
    switch (var_03) {
      case "animated_zmb_workbench_doors":
        var_00.var_3291 = var_02;
        break;

      default:
        break;
    }
  }

  var_05 = getEntArray(var_00.var_10BD.var_01A2, "targetname");
  foreach(var_07 in var_05) {
    if(!isDefined(var_07.var_0165)) {
      continue;
    }

    var_08 = var_07.var_0165;
    switch (var_08) {
      case "workbench_gunrack":
        var_00.var_48F2 = var_07;
        var_00.var_48F2 method_805C();
        break;

      case "ww_model_frame":
      case "ww_model":
        var_00.var_10C0 = var_07;
        var_00.var_10C0 method_805C();
        break;

      case "ww_model_barrel":
        var_00.var_10BE = var_07;
        var_00.var_10BE method_805C();
        break;

      case "ww_model_core":
        var_00.var_10BF = var_07;
        var_00.var_10BF method_805C();
        break;

      default:
        break;
    }
  }

  var_00.var_10BE linkto(var_00.var_10C0);
  var_00.var_10BF linkto(var_00.var_10C0);
  var_00.var_6FDB = getEntArray(var_00.var_10C0.var_01A2, "targetname");
  foreach(var_0B in var_00.var_6FDB) {
    var_0B common_scripts\utility::func_9D9F();
  }

  level.var_AA67 = var_00;
  thread func_AA6C();
  var_00 thread func_AA6B();
}

func_536D() {
  level.var_3578 = 0;
  if(!isDefined(level.var_AACA)) {
    level.var_AACA = [];
  }

  var_00 = common_scripts\utility::func_46B5("ww_upgrade_pickup_central", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = [];
  var_01 = func_536C(var_00);
  return var_01;
}

func_536C(param_00) {
  var_01 = getEntArray(param_00.var_01A2, "targetname");
  var_02 = [];
  foreach(var_04 in var_01) {
    switch (var_04.var_0165) {
      case "ww_upgrade_pickup_blue":
        var_02["moon weapon trig"] = var_04;
        break;

      case "ww_upgrade_pickup_purple":
        var_02["storm weapon trig"] = var_04;
        break;

      case "ww_upgrade_pickup_red":
        var_02["blood weapon trig"] = var_04;
        break;

      case "ww_upgrade_pickup_black":
        var_02["death weapon trig"] = var_04;
        break;

      default:
        break;
    }
  }

  return var_02;
}

func_AA6B() {
  var_00 = func_AA70();
  maps\mp\gametypes\zombies::func_47A8("ZM_TESLA");
  thread maps\mp\mp_zombie_nest_ee_util::func_08A8();
  level.var_3571 thread maps\mp\mp_zombie_nest_ee_cart::func_202D("com_2");
  lib_0378::func_8D74("aud_activate_workbench", self.var_48F2.var_0116);
  common_scripts\utility::func_3C8F("flag_ww_forged");
  level notify("stop_workbench_assembly_info");
  lib_0559::func_2D8E(level.var_AA67.var_4D91);
  self.var_10BD delete();
  var_01 = % zmb_workbench_01_gunrack_spin;
  var_02 = getanimlength(var_01);
  self.var_48F2 method_8278(getanimname(var_01));
  thread func_74C8(var_01, "zmb_tesla_gunrack_beam", self.var_48F2, self.var_48F2, "beam_start", "beam_end", "charger_l", "charger_r");
  wait(var_02);
  foreach(var_04 in self.var_6FDB) {
    var_04 common_scripts\utility::func_9DA3();
  }

  thread func_AA6D(self.var_10C0, var_00);
}

func_AA70() {
  self.var_10BD usetriggerrequirelookat();
  self.var_10BD thread func_AA6A();
  var_00 = undefined;
  var_01 = "flag_ww_part_01_placed";
  var_02 = "flag_ww_part_02_placed";
  var_03 = lib_0557::func_7838("4 cart", "head to com");
  var_04 = "flag_ww_part_01_picked_up";
  var_05 = "flag_ww_part_02_picked_up";
  for(;;) {
    self.var_10BD waittill("trigger", var_00);
    if(common_scripts\utility::func_3C77(var_04) && common_scripts\utility::func_3C77(var_05) && common_scripts\utility::func_3C77(var_03)) {
      if(!common_scripts\utility::func_3C77(var_01) || !common_scripts\utility::func_3C77(var_02)) {
        self.var_10BF method_805B();
        self.var_10BE method_805B();
        common_scripts\utility::func_3C8F(var_01);
        common_scripts\utility::func_3C8F(var_02);
      }

      break;
    } else if(common_scripts\utility::func_3C77(var_04) && common_scripts\utility::func_3C77(var_05)) {
      if(!common_scripts\utility::func_3C77(var_01) || !common_scripts\utility::func_3C77(var_02)) {
        self.var_10C0 linkto(self.var_48F2, "clamp");
        self.var_10BF method_805B();
        self.var_10BE method_805B();
        common_scripts\utility::func_3C8F(var_01);
        common_scripts\utility::func_3C8F(var_02);
      }

      continue;
    } else if(common_scripts\utility::func_3C77(var_04)) {
      if(!common_scripts\utility::func_3C77(var_01)) {
        self.var_10BE method_805B();
        common_scripts\utility::func_3C8F(var_01);
      }

      if(!isDefined(var_00.var_3079) && isPlayer(var_00)) {
        var_06 = var_00 lib_0367::func_8E3D("workbenchpart2", undefined, 1);
        if(isDefined(var_06)) {
          var_00.var_3079 = 1;
        }
      }

      continue;
    } else {
      if(!isDefined(var_00.var_3078) && isPlayer(var_00)) {
        var_06 = var_00 lib_0367::func_8E3D("workbenchpart", undefined, 1);
        if(isDefined(var_06)) {
          var_00.var_3078 = 1;
        }
      }

      continue;
    }
  }

  return var_00;
}

func_AA6A() {
  self sethintstring(&"ZOMBIES_BUILDABLE_NO_PARTS");
  var_00 = "flag_ww_part_01_picked_up";
  var_01 = "flag_ww_part_02_picked_up";
  var_02 = "flag_ww_part_01_placed";
  var_03 = "flag_ww_part_02_placed";
  var_04 = lib_0557::func_7838("4 cart", "head to com");
  common_scripts\utility::func_3C9F(var_00);
  func_7C05();
  self sethintstring(&"ZOMBIE_NEST_PLACE_WW_PART");
  var_05 = common_scripts\utility::func_3CA4(var_02, var_01);
  if(var_05 == var_02) {
    self sethintstring(&"ZOMBIES_BUILDABLE_NO_PARTS");
    common_scripts\utility::func_3C9F(var_01);
    self sethintstring(&"ZOMBIE_NEST_PLACE_WW_PART");
  }

  var_05 = common_scripts\utility::func_3CA4(var_03, var_04);
  if(var_05 == var_03) {
    self sethintstring(&"ZOMBIE_NEST_WAITING_FOR_CART");
    common_scripts\utility::func_3C9F(var_04);
  }

  self sethintstring(&"ZOMBIE_NEST_ASSEMBLE_WW");
}

func_7C05() {
  level.var_AA67.var_4D91 = lib_0559::func_7BE3(level.var_AA67.var_10BD, "teslagun_station");
}

func_AA6D(param_00, param_01) {
  var_02 = "teslagun_zm";
  var_03 = getEntArray(param_00.var_01A2, "targetname");
  for(var_04 = 0; var_04 < 4; var_04++) {
    var_03[var_04].var_AAC5 = param_00;
    level thread func_AA6E(var_03[var_04], var_02);
    if(level.var_A980 <= 6) {
      level.var_400E[level.var_400E.size] = ["raven_set 4 1", "all"];
    }
  }
}

func_AA6E(param_00, param_01) {
  level endon("game_ended");
  param_00.var_A9E0 = param_01;
  param_00.var_6C5C = param_01;
  param_00.var_9DA0 = 0;
  param_00.var_2925 = 5000;
  lib_0547::func_8A4F(param_00, ::func_10E7);
  for(;;) {
    var_02 = param_00 lib_0547::func_A795();
    var_03 = var_02[0];
    var_04 = var_02[1];
    var_05 = var_03 getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_05) || lib_0547::func_5862(var_05) || lib_0547::iszombieconsumableweapon(var_05)) {
      continue;
    }

    var_06 = var_03 getweaponslistprimaries();
    var_07 = var_03 getweaponslistall();
    var_08 = 0;
    if(var_06.size > 0) {
      foreach(var_0A in var_06) {
        if(issubstr(var_0A, "teslagun_zm")) {
          var_08 = 1;
        }
      }
    }

    if(lib_0547::func_73F9(var_03, param_01)) {
      if(!0) {
        continue;
      }

      if(maps\mp\zombies\_zombies_magicbox::func_4B6A(var_03, param_01)) {
        maps\mp\zombies\_zombies_magicbox::func_300A(var_03, 0);
        continue;
      }

      if(!var_03 maps\mp\gametypes\zombies::func_11C2(param_00.var_2925)) {
        var_03 thread lib_054E::func_0695("needmoney");
        continue;
      }
    } else if(var_08) {
      foreach(var_0A in var_06) {
        if(issubstr(var_0A, "teslagun_zm")) {
          var_03 lib_0586::func_0790(var_0A);
        }
      }
    } else if(!var_03 lib_0586::func_05DF(param_01)) {
      var_0E = var_03 lib_0586::func_0637();
      if(function_01A9(var_0E) != "melee") {
        var_03 lib_0586::func_0790(var_0E);
      }
    }

    level.var_400E[level.var_400E.size] = ["survivalist_set 3 -1", var_03];
    level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", var_03];
    var_03 lib_0586::func_078C(param_01);
    if(isDefined(var_03.var_A2AF) && isDefined(var_03.var_A2AF[param_01])) {
      var_03 setweaponammostock(param_01, var_03.var_A2AF[param_01]);
    }

    if(isDefined(var_03.var_A2B0) && isDefined(var_03.var_A2B0[param_01])) {
      var_03 method_82FA(param_01, var_03.var_A2B0[param_01]);
    } else {
      var_03 method_82FA(param_01, weaponclipsize(param_01));
    }

    var_03 lib_0586::func_078E(param_01);
    var_03 thread func_AA69(param_01);
    level thread func_AA78(var_03, param_01, 0);
  }
}

func_AA6C() {
  level.var_AA67.var_3291 setscriptablepartstate("doors", "open", 0);
  var_00 = % zmb_workbench_01_gunrack_up_01;
  level.var_AA67.var_48F2 method_805B();
  if(isDefined(level.var_AA67.var_10C0)) {
    level.var_AA67.var_10C0 method_805B();
    level.var_AA67.var_10C0 linkto(level.var_AA67.var_48F2, "clamp");
  }

  level.var_AA67.var_48F2 method_8278(getanimname(var_00));
  var_01 = getanimlength(var_00) * 0.5;
  wait(var_01);
}

func_10E7(param_00) {
  lib_0559::func_7BE2(param_00, self, "teslagun");
  thread func_AA6F(param_00);
}

func_AA6F(param_00) {
  param_00 endon("disconnect");
  var_01 = 1;
  var_02 = lib_0552::func_7BE1(param_00, self);
  for(;;) {
    if(var_01) {
      var_01 = 0;
    } else {
      param_00 common_scripts\utility::func_A70A("weapon_change", "new_equipment");
    }

    var_03 = 0;
    var_04 = "";
    var_05 = 0;
    var_06 = param_00 getweaponslistall();
    foreach(var_08 in var_06) {
      var_04 = getweapondisplayname(var_08);
      if(var_04 == self.var_A9E0) {
        var_03 = 1;
        break;
      }

      if(issubstr(var_08, "teslagun_zm")) {
        var_05 = 1;
      }
    }

    var_0A = param_00 getcurrentprimaryweapon();
    if(0) {
      self setcursorhint("HINT_NOICON");
    }

    if(lib_0547::func_57AF(var_0A) || lib_0547::func_5862(var_0A) || lib_0547::iszombieconsumableweapon(var_0A)) {
      if(0) {
        self sethintstring("");
        self setsecondaryhintstring("");
        self.var_3006 = undefined;
      }

      if(1) {
        var_02.var_2F74 = 1;
        var_02.var_6642 = 1;
      }

      continue;
    }

    if(var_03) {
      if(0) {
        self.var_3006 = self.var_2925;
        if(0) {
          self sethintstring(maps\mp\zombies\_zombies_magicbox::func_4412(self));
          self setsecondaryhintstring(maps\mp\zombies\_zombies_magicbox::func_4411(self, 0));
        }

        if(1) {}
      } else {
        if(0) {
          self sethintstring("");
          self setsecondaryhintstring("");
          self.var_3006 = undefined;
        }

        if(1) {
          var_02.var_2F74 = 1;
          var_02.var_6642 = 1;
        }
      }

      continue;
    }

    if(var_05 && !var_03) {
      if(1) {
        var_02.var_4028 = lib_0552::func_44FF("ww_already_have");
        var_02.var_2F74 = 0;
        var_02.var_6642 = 1;
      }

      continue;
    }

    self.var_3006 = 0;
    if(0) {
      self sethintstring(&"ZOMBIE_NEST_PICKUP_WW");
    }

    if(1) {
      var_02.var_4028 = lib_0552::func_44FF("ww_pickup");
      var_02.var_2F74 = 0;
      var_02.var_6642 = 1;
    }
  }
}

func_74C8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = getnotetracktimes(param_00, param_04);
  var_09 = var_08[0] * getanimlength(param_00);
  var_0A = getnotetracktimes(param_00, param_05);
  var_0B = var_0A[0] * getanimlength(param_00);
  wait(var_09);
  var_0C = launchbeam(param_01, param_02, param_06, param_03, param_07);
  wait(var_0B - var_09);
  var_0C delete();
}

func_AA75() {
  var_00 = common_scripts\utility::func_46B5("ww_upgrade_pickup_central", "targetname");
  self usetouchtriggerrequirefacingposition(1, var_00.var_0116);
  common_scripts\utility::func_9D9F();
  var_01 = function_021F(self.var_01A2, "targetname");
  foreach(var_03 in var_01) {
    var_04 = var_03 method_85CE();
    switch (var_04) {
      case "animated_zmb_workbench_doors":
        self.var_3291 = var_03;
        break;

      default:
        break;
    }
  }

  var_06 = getEntArray(self.var_01A2, "targetname");
  foreach(var_08 in var_06) {
    if(!isDefined(var_08.var_0165)) {
      continue;
    }

    switch (var_08.var_0165) {
      case "workbench_gunrack":
        self.var_48F2 = var_08;
        self.var_48F2 method_805C();
        self.var_48F2.var_9189 = self.var_48F2.var_001D;
        self.var_48F2.var_9255 = self.var_48F2.var_0116;
        break;

      case "workbench_ww_model":
        self.var_AAC8 = var_08;
        self.var_AAC8 method_805C();
        break;

      case "workbench_ww_model_core":
        self.var_AAC7 = var_08;
        self.var_AAC7 method_805C();
        break;

      case "workbench_ww_model_barrel":
        self.var_AAC6 = var_08;
        self.var_AAC6 method_805C();
        break;
    }
  }

  if(isDefined(self.var_48F2) && isDefined(self.var_AAC8)) {
    self.var_AAC8 linkto(self.var_48F2, "clamp");
  }

  if(isDefined(self.var_48F2) && isDefined(self.var_AAC7)) {
    self.var_AAC7 linkto(self.var_48F2, "clamp");
  }

  if(isDefined(self.var_48F2) && isDefined(self.var_AAC6)) {
    self.var_AAC6 linkto(self.var_48F2, "clamp");
  }
}

func_AA73(param_00) {
  level notify(self.var_A9E0 + "_assembled");
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self.var_2916 = "building";
  self.var_78A1 = "working";
  if(!level.var_3578) {
    thread func_AA74();
  }

  if(param_00) {
    self.var_AAC8 method_805B();
    self.var_AAC6 method_805B();
    self.var_AAC7 method_805B();
  }

  var_01 = self.var_3291 getscriptablepartstate("doors");
  if(var_01 != "opened_idle") {
    self.var_3291 func_AA7E("opened_idle");
  }

  var_02 = % zmb_workbench_01_gunrack_up_01;
  var_03 = % zmb_workbench_01_gunrack_up_idle_01;
  var_04 = % zmb_workbench_01_gunrack_down_01;
  var_05 = % zmb_workbench_01_gunrack_spin;
  var_06 = getanimlength(var_04);
  var_07 = getanimlength(var_02);
  var_08 = launchbeam("zmb_tesla_gunrack_beam", self.var_48F2, "charger_l", self.var_48F2, "charger_r");
  self.var_48F2 scriptmodelclearanim();
  self.var_48F2 method_8278(getanimname(var_04));
  wait(var_06);
  self.var_3291 func_AA7E("close");
  self.var_AAC6 method_805B();
  self.var_AAC7 method_805B();
  self.var_AAC8 method_805B();
  func_AA77();
  wait(3);
  self.var_48F2 scriptmodelclearanim();
  self.var_48F2 method_8495(getanimname(var_02), self.var_48F2.var_9255, self.var_48F2.var_9189);
  wait(0.1);
  self.var_48F2 scriptmodelpauseanim(1);
  self.var_3291 func_AA7E("open");
  self.var_48F2 scriptmodelpauseanim(0);
  wait(var_07 - 0.1);
  var_08 delete();
  self.var_48F2 scriptmodelclearanim();
  self.var_48F2 scriptmodelplayanim(getanimname(var_05), "", 9.2);
  wait(0.8666667);
  self.var_78A1 = "finished";
  self.var_2916 = "available";
}

func_AA74() {
  level.var_3578 = 1;
  thread maps\mp\mp_zombie_nest_ee_util::func_08A8();
  lib_0378::func_8D74("aud_activate_workbench", self.var_48F2.var_0116);
  level.var_3571 maps\mp\mp_zombie_nest_ee_cart::func_202D("com_2");
  level.var_3578 = 0;
}

func_AA7E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "closed_idle";
  }

  var_01 = 0;
  var_02 = 0.1;
  switch (param_00) {
    case "closed_idle":
      var_02 = 0.1666667;
      var_01 = 1;
      break;

    case "close":
      var_02 = 1.4;
      var_01 = 1;
      break;

    case "open":
      var_02 = 2.033333;
      var_01 = 1;
      break;

    case "opened_idle":
      var_02 = 0.2;
      var_01 = 1;
      break;

    default:
      break;
  }

  if(var_01) {
    self setscriptablepartstate("doors", param_00);
    wait(var_02);
  }
}

func_AA7A(param_00) {
  self endon("disconnect");
  var_01 = % zmb_workbench_01_gunrack_up_01;
  var_02 = % zmb_workbench_01_gunrack_up_idle_01;
  var_03 = % zmb_workbench_01_gunrack_up_idle_02;
  var_04 = % zmb_workbench_01_gunrack_down_01;
  var_05 = % zmb_workbench_01_gunrack_idle_01;
  var_06 = % zmb_workbench_01_gunrack_spin;
  var_07 = getanimlength(var_04);
  var_08 = getanimlength(var_01);
  param_00.var_78A1 = "opening";
  param_00.var_48F2 method_805B();
  if(param_00.var_2916 == "available") {
    param_00.var_AAC5 method_805B();
  }

  param_00.var_48F2 scriptmodelclearanim();
  param_00.var_48F2 method_8495(getanimname(var_01), param_00.var_48F2.var_9255, param_00.var_48F2.var_9189);
  wait(0.1);
  param_00.var_48F2 scriptmodelpauseanim(1);
  param_00.var_3291 func_AA7E("open");
  param_00.var_48F2 scriptmodelpauseanim(0);
  wait(var_08 - 0.1);
  param_00.var_48F2 scriptmodelclearanim();
  param_00.var_48F2 scriptmodelplayanim(getanimname(var_06), "", 9.2);
  wait(0.8666667);
  param_00.var_78A1 = "opened";
}

func_AA77() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  switch (self.var_A9E0) {
    case "teslagun_zm_blood":
      var_00 = "zmb_teslagun_crystal_01_blood";
      var_01 = "zmb_teslagun_barrel_01_blood";
      var_02 = "zmb_teslagun_base_01_blood";
      break;

    case "teslagun_zm_storm":
      var_00 = "zmb_teslagun_crystal_01_storm";
      var_01 = "zmb_teslagun_barrel_01_storm";
      var_02 = "zmb_teslagun_base_01_storm";
      break;

    case "teslagun_zm_moon":
      var_00 = "zmb_teslagun_crystal_01_moon";
      var_01 = "zmb_teslagun_barrel_01_moon";
      var_02 = "zmb_teslagun_base_01_moon";
      break;

    case "teslagun_zm_death":
      var_00 = "zmb_teslagun_crystal_01_death";
      var_01 = "zmb_teslagun_barrel_01_death";
      var_02 = "zmb_teslagun_base_01_death";
      break;
  }

  if(isDefined(var_00)) {
    self.var_AAC7 setModel(var_00);
  }

  if(isDefined(var_01)) {
    self.var_AAC6 setModel(var_01);
  }

  if(isDefined(var_02)) {
    self.var_AAC8 setModel(var_02);
  }
}

func_AA79(param_00) {
  self endon("disconnect");
  level endon(param_00.var_A9E0 + "_assembled");
  var_01 = 250;
  var_02 = var_01 * var_01;
  var_03 = % zmb_workbench_01_gunrack_up_01;
  var_04 = % zmb_workbench_01_gunrack_up_idle_01;
  var_05 = % zmb_workbench_01_gunrack_up_idle_02;
  var_06 = % zmb_workbench_01_gunrack_down_01;
  var_07 = % zmb_workbench_01_gunrack_idle_01;
  var_08 = % zmb_workbench_01_gunrack_spin;
  var_09 = getanimlength(var_06);
  var_0A = getanimlength(var_03);
  for(;;) {
    if(distancesquared(self.var_0116, param_00.var_48F2.var_9255) > var_02 && param_00.var_78A1 == "opened") {
      param_00.var_78A1 = "closing";
      param_00.var_9D65 makeunusable();
      param_00.var_48F2 scriptmodelclearanim();
      param_00.var_48F2 method_8278(getanimname(var_06), "");
      wait(var_09);
      param_00.var_3291 func_AA7E("close");
      param_00.var_48F2 method_805C();
      if(param_00.var_2916 == "available") {
        param_00.var_AAC5 method_805C();
      }

      param_00.var_78A1 = "closed";
    } else if(distancesquared(self.var_0116, param_00.var_48F2.var_9255) < var_02 && param_00.var_78A1 == "closed") {
      param_00.var_78A1 = "opening";
      param_00.var_48F2 method_805B();
      if(param_00.var_2916 == "available") {
        param_00.var_AAC5 method_805B();
      }

      param_00.var_48F2 scriptmodelclearanim();
      param_00.var_48F2 method_8495(getanimname(var_03), param_00.var_48F2.var_9255, param_00.var_48F2.var_9189);
      wait(0.1);
      param_00.var_48F2 scriptmodelpauseanim(1);
      param_00.var_3291 func_AA7E("open");
      param_00.var_48F2 scriptmodelpauseanim(0);
      wait(var_0A - 0.1);
      param_00.var_48F2 scriptmodelclearanim();
      param_00.var_48F2 scriptmodelplayanim(getanimname(var_08), "", 9.2);
      wait(0.8666667);
      param_00.var_9D65 makeusable();
      param_00.var_78A1 = "opened";
    }

    wait(0.25);
  }
}

func_AA7D(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_9D65 = param_01;
  var_02.var_AAC7 = param_01.var_AAC7;
  var_02.var_AAC8 = param_01.var_AAC8;
  var_02.var_AAC6 = param_01.var_AAC6;
  var_02.var_48F2 = param_01.var_48F2;
  var_02.var_3291 = param_01.var_3291;
  var_02.var_A9E0 = param_00;
  var_02.var_2916 = "not built";
  var_02.var_78A1 = "closed";
  var_02.var_2909 = undefined;
  return var_02;
}

func_AA76() {
  var_00 = "teslagun";
  if(self.var_A9E0 == "teslagun_zm_blood") {
    var_00 = "teslagun_blood";
  } else if(self.var_A9E0 == "teslagun_zm_storm") {
    var_00 = "teslagun_storm";
  } else if(self.var_A9E0 == "teslagun_zm_moon") {
    var_00 = "teslagun_moon";
  } else if(self.var_A9E0 == "teslagun_zm_death") {
    var_00 = "teslagun_death";
  }

  lib_0559::func_7BE3(self.var_9D65, var_00);
  for(;;) {
    var_01 = self.var_9D65 lib_0547::func_A795();
    var_02 = var_01[0];
    var_03 = var_01[1];
    var_04 = var_02 getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_04) || lib_0547::func_5862(var_04) || lib_0547::iszombieconsumableweapon(var_04)) {
      continue;
    }

    var_05 = var_02 maps\mp\zombies\_zombies_magicbox::func_473B();
    var_06 = 0;
    var_07 = 0;
    if(var_05.size > 0) {
      foreach(var_09 in var_05) {
        if(self.var_A9E0 == var_09) {
          var_06 = 1;
        }

        if(issubstr(var_09, "teslagun_zm")) {
          var_07 = 1;
        }
      }
    }

    if(var_06) {
      continue;
    } else if(var_07) {
      foreach(var_09 in var_05) {
        if(issubstr(var_09, "teslagun_zm")) {
          var_02 lib_0586::func_0790(var_09);
        }
      }
    } else if(!var_02 lib_0586::func_05DF(self.var_A9E0)) {
      var_0D = var_02 lib_0586::func_0637();
      if(function_01A9(var_0D) != "melee") {
        var_02 lib_0586::func_0790(var_0D);
      }
    }

    level.var_400E[level.var_400E.size] = ["survivalist_set 3 -1", var_02];
    level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", var_02];
    var_02 lib_0586::func_078C(self.var_A9E0);
    if(isDefined(var_02.var_A2AF) && isDefined(var_02.var_A2AF[self.var_A9E0])) {
      var_02 setweaponammostock(self.var_A9E0, var_02.var_A2AF[self.var_A9E0]);
    }

    if(isDefined(var_02.var_A2B0) && isDefined(var_02.var_A2B0[self.var_A9E0])) {
      var_02 method_82FA(self.var_A9E0, var_02.var_A2B0[self.var_A9E0]);
    } else {
      var_02 method_82FA(self.var_A9E0, weaponclipsize(self.var_A9E0));
    }

    var_02 lib_0586::func_078E(self.var_A9E0);
    func_AA7C(self.var_A9E0, var_02);
    var_02 thread func_AA69(self.var_A9E0);
    level thread func_AA78(var_02, self.var_A9E0);
  }
}

func_AA78(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  for(;;) {
    var_03 = param_00 common_scripts\utility::func_A715("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");
    if(var_03 == "weapon_change") {
      if(lib_0547::func_577E(param_00)) {
        continue;
      } else if(!lib_0547::func_73F9(param_00, param_01)) {
        if(param_02) {
          func_AA7B(param_01);
          level.var_AACA[param_01] thread func_AA76();
        }

        level notify(param_01 + "_stop_tracking");
        return;
      }

      continue;
    }

    if(var_03 == "bleedout" || var_03 == "becameSpectator" || var_03 == "disconnect") {
      if(param_02) {
        func_AA7B(param_01);
        level.var_AACA[param_01] thread func_AA76();
      }

      return;
    }
  }
}

func_AA7B(param_00) {
  level.var_AACA[param_00] func_AA73(0);
  level.var_AACA[param_00].var_9D65 common_scripts\utility::func_9DA3();
  level.var_AACA[param_00].var_9D65.var_AAC8 method_805B();
  level.var_AACA[param_00].var_9D65.var_AAC7 method_805B();
  level.var_AACA[param_00].var_9D65.var_AAC6 method_805B();
  level.var_AACA[param_00].var_2916 = "available";
  level.var_AACA[param_00].var_2909 = undefined;
}

func_AA7C(param_00, param_01) {
  level.var_AACA[param_00].var_9D65 common_scripts\utility::func_9D9F();
  level.var_AACA[param_00].var_9D65.var_AAC8 method_805C();
  level.var_AACA[param_00].var_9D65.var_AAC7 method_805C();
  level.var_AACA[param_00].var_9D65.var_AAC6 method_805C();
  level.var_AACA[param_00].var_2916 = "taken";
  level.var_AACA[param_00].var_2909 = param_01;
}

func_AA72(param_00) {
  var_01 = &"ZOMBIE_NEST_GRAB_DEATH";
  switch (param_00) {
    case "teslagun_zm_moon":
      var_01 = &"ZOMBIE_NEST_GRAB_MOON";
      break;

    case "teslagun_zm_death":
      var_01 = &"ZOMBIE_NEST_GRAB_DEATH";
      break;

    case "teslagun_zm_blood":
      var_01 = &"ZOMBIE_NEST_GRAB_BLOOD";
      break;

    case "teslagun_zm_storm":
      var_01 = &"ZOMBIE_NEST_GRAB_STORM";
      break;
  }

  return var_01;
}

func_AA71(param_00) {
  var_01 = &"ZOMBIE_NEST_ASSEMBLE_DEATH";
  switch (param_00) {
    case "teslagun_zm_moon":
      var_01 = &"ZOMBIE_NEST_ASSEMBLE_MOON";
      break;

    case "teslagun_zm_death":
      var_01 = &"ZOMBIE_NEST_ASSEMBLE_DEATH";
      break;

    case "teslagun_zm_blood":
      var_01 = &"ZOMBIE_NEST_ASSEMBLE_BLOOD";
      break;

    case "teslagun_zm_storm":
      var_01 = &"ZOMBIE_NEST_ASSEMBLE_STORM";
      break;
  }

  return var_01;
}

func_AA69(param_00) {
  self endon("death");
  level endon(param_00 + "_stop_tracking");
  for(;;) {
    common_scripts\utility::func_A70C(self, "missile_fire", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");
    if(self hasweapon(param_00)) {
      self.var_A2AF[param_00] = self getweaponammostock(param_00);
      self.var_A2B0[param_00] = self getweaponammoclip(param_00);
    }
  }
}