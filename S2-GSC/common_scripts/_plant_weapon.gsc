/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_plant_weapon.gsc
*********************************************/

func_5369(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  func_941B(param_01, param_02, param_03, param_04);
  var_07 = getdvarint("weapon_plant_enabled", 1);
  if(!var_07) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(self.var_201C)) {
    var_08 = param_00 == self.var_201C;
    if(var_08) {
      return;
    } else if(func_43DD() == "SCRIPTED_SWAP") {
      self waittill("weapon_plant_dismount");
      func_2399(1);
    }
  }

  self.var_7076 = undefined;
  self.var_76E7 = undefined;
  self.var_76EC = undefined;
  self.var_201C = param_01;
  self.var_7073 = undefined;
  self.var_A6B4 = 0;
  self.var_A1FC = 0;
  self.var_706A = func_4295(param_01);
  if(isDefined(param_06) && param_06) {
    self.var_7077 = "STATE_CARRY_TO_PLANT";
    self.var_7073 = var_07;
    self.var_7075 = var_07;
  } else {
    self.var_7077 = "STATE_FIRST_CARRY";
    if(func_43DD() == "SCRIPTED_ALTSWITCH" || func_43DD() == "NATIVE_DPAD_LEFT") {
      self method_8328();
    }
  }

  if(func_43DD() != "NATIVE_DPAD_LEFT") {
    if(isPlayer(self)) {
      func_680D();
    }
  }

  thread func_9963();
  thread func_62DA();
  thread func_A123();
  thread func_6370();
  if(func_43DD() == "SCRIPTED_SWAP" || func_43DD() == "SCRIPTED_ALTSWITCH") {
    thread func_63F7();
  }
}

func_680D() {
  self notifyonplayercommand("plant_button_down", "+actionslot 3");
  self notifyonplayercommand("plant_button_up", "-actionslot 3");
  self notifyonplayercommand("use_button_down", "+usereload");
  self notifyonplayercommand("use_button_up", "-usereload");
}

func_680C() {
  self notifyonplayercommandremove("plant_button_down", "+actionslot 3");
  self notifyonplayercommandremove("plant_button_up", "-actionslot 3");
  self notifyonplayercommandremove("use_button_down", "+usereload");
  self notifyonplayercommandremove("use_button_up", "-usereload");
}

func_8551(param_00) {
  self.var_7075 = param_00;
}

func_239A() {
  self notify("cleanupWeaponPlantImmediate");
  return func_2399(0);
}

func_2399(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self notify("weapon_plant_cleanup");
  if(self playerisweaponplantenabled()) {
    func_2FED(param_00);
  } else if(!param_00) {
    func_2F97();
  }

  self.var_706A = undefined;
  if(func_43DD() == "SCRIPTED_ALTSWITCH" || func_43DD() == "NATIVE_DPAD_LEFT") {
    self enableweaponswitch();
  }

  self.var_7076 = undefined;
  self.var_76E7 = undefined;
  self.var_76EC = undefined;
  self.var_201C = undefined;
  self.var_7077 = undefined;
  self.var_7073 = undefined;
  self.var_7075 = undefined;
  self.var_A6B4 = undefined;
  self.var_A1FC = undefined;
  func_2373();
  if(isPlayer(self)) {
    func_680C();
  }

  self setclientomnvar("ui_lmg_mount_state", 0);
  self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
}

func_9EA3() {
  var_00 = undefined;
  if(isDefined(self.var_76EC)) {
    var_00 = lengthsquared(self.var_001D - self.var_76EC);
  }

  self.var_76EC = self.var_001D;
  var_01 = getdvarfloat("weapon_plant_max_turn_angle_vect_distance_sq", 70);
  if(isDefined(var_00) && var_00 > var_01) {
    return 1;
  }

  return 0;
}

func_1F65() {
  if(isDefined(self.var_2FAF) && self.var_2FAF) {
    return 0;
  }

  if(isDefined(self.var_2016) && isDefined(self.var_2016.var_201C) && self.var_2016.var_201C == "iw5_carrydrone_mp" || self.var_2016.var_201C == "relic_mp") {
    return 0;
  }

  if(isDefined(self.var_5525) && self.var_5525) {
    return 0;
  }

  if(!self.var_A1FC && self isonground() && !self method_82E5() && !self method_82E4() && !self method_84DE() && !self method_833B() && !self isusingturret() && !self method_817A() && !func_9EA3() && !isDefined(self getmovingplatformparent())) {
    return 1;
  }

  return 0;
}

func_5855() {
  if(self playerisweaponplantenabled()) {
    return 1;
  }

  if(!isDefined(self.var_7077)) {
    return 0;
  }

  switch (self.var_7077) {
    case "STATE_PLANTED_TO_CARRY":
    case "STATE_PLANTED":
    case "STATE_PLANTED_NO_CARRY":
    case "STATE_CARRY_TO_PLANT":
      return 1;

    default:
      return 0;
  }
}

func_584E() {
  if(!isDefined(self.var_7077)) {
    return 0;
  }

  if(self.var_7077 == "STATE_PLANTED_TO_CARRY") {
    return 1;
  }

  return 0;
}

func_2F97() {
  self method_8112(1);
  self method_8113(1);
  self method_8114(1);
  self allowlook(1);
  self method_8307(1);
  self allowjump(1);
  self method_812A(1);
  func_6518(1);
  if(func_8B6B()) {
    common_scripts\utility::func_0617();
  }

  self method_8325();
  self enableusability();
}

func_707A() {
  var_00 = func_43D9();
  var_01 = getdvarfloat("weapon_plant_limits_forward_offset", 0);
  var_02 = getdvarfloat("weapon_plant_limits_upward_offset", 5);
  var_03 = self.var_001D;
  if(isDefined(self.var_7075)) {
    self.var_7073 = self.var_7075;
    self.var_7076 = "stand";
  }

  var_04 = self method_86B0();
  var_05 = max(10, var_04[0] - 15);
  var_04 = (-1 * var_05, var_04[1], var_04[2]);
  var_04 = rotatevector(var_04, var_03);
  var_06 = self.var_7073 + var_04;
  self.var_76E7 = self getstance();
  if(isDefined(self.var_7076)) {
    var_07 = self.var_7076;
    var_08 = self setstance(var_07);
    if(isDefined(self.var_7075) && !var_08) {
      var_08 = self setstance(var_07, 0);
    }
  } else {
    var_07 = self.var_76E7;
  }

  if(isDefined(self.var_7075)) {
    self.var_7075 = undefined;
  }

  var_09 = undefined;
  if(var_07 == "prone") {
    var_09 = vectortoangles(self.var_7073 - self.var_0116);
  } else {
    var_09 = self.var_001D;
  }

  var_0A = func_4355(var_07);
  var_0B = var_0A[0];
  var_0C = var_0A[1];
  var_0D = var_0A[2];
  var_0E = var_0A[3];
  var_0F = var_0B;
  var_10 = var_0C;
  var_11 = var_0D;
  var_12 = var_0E;
  if(func_8B53()) {
    var_13 = common_scripts\_hit_found::func_43D8(self.var_0116[2], self.var_7073, var_06, var_09, var_02, var_01, var_00, var_0B, var_0C, var_0D, var_0E, func_4074());
    var_0F = var_13[0];
    var_10 = var_13[1];
    var_11 = var_13[2];
    var_12 = var_13[3];
  }

  func_941B(var_0F, var_10, var_11, var_12);
  if(var_07 != "stand") {
    self method_8112(0);
  }

  if(var_07 != "crouch") {
    self method_8113(0);
  }

  if(var_07 != "prone") {
    self method_8114(0);
  }

  self allowjump(0);
  self method_8307(0);
  self method_812A(0);
  func_6518(0);
  if(func_8B6B()) {
    common_scripts\utility::func_0603();
  }

  self method_8324();
  self disableusability();
  self playerweaponplantenable(self.var_7073, var_0F, var_10, var_11, var_12);
  func_707B(var_07, self.var_7073, self.var_001D);
  if(func_43DD() == "SCRIPTED_SWAP") {
    var_14 = self getweaponammoclip(self.var_201C);
    var_15 = self getweaponammostock(self.var_201C);
    var_16 = get_weapon_paintjobid();
    var_17 = get_weapon_charmguid();
    self giveweapon(self.var_706A, undefined, 1, self, var_16, var_17);
    self method_82FA(self.var_706A, var_14);
    self setweaponammostock(self.var_706A, var_15);
    self switchtoweapon(self.var_706A);
    self waittill("weapon_change");
  } else if(func_43DD() == "SCRIPTED_ALTSWITCH") {
    self enableweaponswitch();
    self switchtoweapon(self.var_706A);
    wait(1);
    self method_8328();
  } else if(func_43DD() == "NATIVE_DPAD_LEFT") {
    thread func_14F3(0.75);
    while(self getcurrentweapon() != self.var_706A) {
      wait 0.05;
    }

    self method_8328();
    while(self isoffhandweaponreadytothrow() || self isswitchingweapon()) {
      wait 0.05;
    }

    if(self getcurrentweapon() != self.var_706A) {}
  }

  self notify("WEAPON_PLANT_MOUNTED", var_07, self.var_7073, self.var_001D, self.var_706D);
}

func_14F3(param_00) {
  self endon("weapon_change");
  wait(param_00);
  if(self getcurrentweapon() != self.var_706A) {
    self switchtoweapon(self.var_706A);
  }
}

forcedismountweapon() {
  self notify("weapon_plant_cleanup");
}

func_2FED(param_00) {
  self method_8112(1);
  self method_8113(1);
  self method_8114(1);
  if(isDefined(self.var_76E7)) {
    self setstance(self.var_76E7);
    self.var_76E7 = undefined;
  }

  self.var_7076 = undefined;
  self playerweaponplantdisable(1);
  func_2FEE();
  if(func_43DD() == "SCRIPTED_SWAP") {
    if(self hasweapon(self.var_706A)) {
      var_01 = self getweaponammoclip(self.var_706A);
      var_02 = self getweaponammostock(self.var_706A);
      if(self getcurrentweapon() == self.var_706A) {
        self switchtoweapon(self.var_201C);
      }

      self method_82FA(self.var_201C, var_01);
      self setweaponammostock(self.var_201C, var_02);
      common_scripts\utility::func_A71A(1, "weapon_change");
      if(self getcurrentweapon() == self.var_706A) {
        self switchtoweapon(self.var_201C);
      }

      self takeweapon(self.var_706A);
    }
  } else if(func_43DD() == "SCRIPTED_ALTSWITCH") {
    self enableweaponswitch();
    if(param_00) {
      self switchtoweapon(self.var_201C);
      wait(1);
    } else {
      self switchtoweaponimmediate(self.var_201C);
    }

    self method_8328();
  } else if(func_43DD() == "NATIVE_DPAD_LEFT") {
    if(param_00) {
      while(self getcurrentweapon() == self.var_706A) {
        wait 0.05;
      }

      self method_8328();
      while(self isoffhandweaponreadytothrow() || self isswitchingweapon()) {
        wait 0.05;
      }

      if(self getcurrentweapon() == self.var_706A) {}
    } else {
      self switchtoweaponimmediate(self.var_201C);
    }
  }

  func_2F97();
  self notify("weapon_plant_dismount");
}

func_63F7() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  for(;;) {
    self waittill("use_button_down");
    self.var_A1FC = 1;
    self waittill("use_button_up");
    self.var_A1FC = 0;
    wait 0.05;
  }
}

func_63BE() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  self.var_A6B4 = 1;
  self waittill("plant_button_up");
  self.var_A6B4 = 0;
}

func_21B6() {
  if(self.var_A6B4) {
    self waittill("plant_button_up");
  }
}

func_A6A5(param_00) {
  level endon("game_ended");
  func_98DF();
  if(isDefined(param_00)) {
    childthread func_21D0(param_00);
    var_01 = common_scripts\utility::func_A715("plant_button_down", "plantOnEntityRemoved", "native_dpad_force_plant");
    if(isDefined(var_01) && var_01 == "plantOnEntityRemoved") {
      return 1;
    }
  } else {
    var_01 = common_scripts\utility::func_A715("plant_button_down", "native_dpad_force_plant");
  }

  if(func_43DD() != "NATIVE_DPAD_LEFT") {
    func_98E0();
    thread func_63BE();
    var_02 = getdvarfloat("weapon_plant_input_hold_duration", 0.2);
    if(var_02 > 0) {
      common_scripts\utility::func_A63E(var_02, "plant_button_up");
    }
  }

  return 1;
}

func_A774() {
  for(;;) {
    if(self getcurrentweapon() == self.var_706A && !self isswitchingweapon()) {
      return 1;
    } else {
      wait 0.05;
    }
  }
}

func_A772(param_00) {
  func_98DF();
  if(isDefined(param_00)) {
    childthread func_21D0(param_00);
  }

  for(;;) {
    if(self getcurrentweapon() == self.var_201C || self getcurrentweapon() == self.var_706A && self isswitchingweapon()) {
      func_98E0();
      return 1;
    } else {
      wait 0.05;
    }
  }
}

func_A771() {
  for(;;) {
    if((self getcurrentweapon() == self.var_706A && self isoffhandweaponreadytothrow()) || self getcurrentweapon() == self.var_201C && self isswitchingweapon()) {
      wait 0.05;
      continue;
    }

    return 1;
  }
}

func_37BF(param_00) {
  self.var_7077 = param_00;
}

func_38F6() {
  switch (self.var_7077) {
    case "STATE_CARRY":
    case "STATE_FIRST_CARRY":
      func_37BF("STATE_CARRY_TO_PLANT");
      break;

    case "STATE_CARRY_TO_PLANT":
      func_37BF("STATE_PLANTED_NO_CARRY");
      break;

    case "STATE_PLANTED_NO_CARRY":
      func_37BF("STATE_PLANTED");
      break;

    case "STATE_PLANTED":
      func_37BF("STATE_PLANTED_TO_CARRY");
      break;

    case "STATE_PLANTED_TO_CARRY":
      func_37BF("STATE_CARRY_NO_PLANT");
      break;

    case "STATE_CARRY_NO_PLANT":
      func_37BF("STATE_CARRY");
      break;
  }
}

func_9963() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  var_00 = -1;
  var_01 = 0;
  for(;;) {
    var_02 = gettime();
    if(!isDefined(self.var_7077)) {
      return;
    }

    switch (self.var_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        if(isDefined(func_A6A5())) {
          if(isDefined(self.var_7073)) {
            func_38F6();
          } else if(self getstance() == "prone" && func_1F65()) {
            func_3A66();
          }
        }
        break;

      case "STATE_CARRY_TO_PLANT":
        func_707A();
        self allowlook(1);
        func_38F6();
        break;

      case "STATE_PLANTED_NO_CARRY":
        if(func_43DD() == "NATIVE_DPAD_LEFT") {
          func_A774();
        } else {
          func_21B6();
        }

        func_38F6();
        break;

      case "STATE_PLANTED":
        var_03 = undefined;
        if(func_43DD() == "NATIVE_DPAD_LEFT") {
          var_03 = func_A772(self.var_706D);
        } else {
          var_03 = func_A6A5(self.var_706D);
        }

        if(isDefined(var_03)) {
          func_38F6();
        }
        break;

      case "STATE_PLANTED_TO_CARRY":
        func_2FED(1);
        func_38F6();
        break;

      case "STATE_CARRY_NO_PLANT":
        if(func_43DD() == "NATIVE_DPAD_LEFT") {
          func_A771();
        } else {
          func_21B6();
        }

        func_38F6();
        break;

      default:
        break;
    }

    if(var_01 == var_03) {
      var_02++;
      if(var_02 > 5) {
        wait 0.05;
      }

      continue;
    }

    var_01 = 0;
    var_00 = var_02;
  }
}

func_A123() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  for(;;) {
    if(!isDefined(self.var_7077)) {
      return;
    }

    switch (self.var_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        if(self isusingturret()) {
          wait 0.05;
          break;
        }

        if(isDefined(self.var_7073)) {
          self setclientomnvar("ui_lmg_mount_state", 0);
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 1);
        } else {
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
        }
        break;

      case "STATE_PLANTED":
        self setclientomnvar("ui_lmg_mount_state", 1);
        if(!isDefined(self.var_706E) || !self.var_706E) {
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 1);
        } else {
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
        }

        if(func_43DD() == "SCRIPTED_SWAP") {
          if(isDefined(self.var_706A) && self getcurrentweapon() == self.var_706A) {
            var_00 = self getweaponammoclip(self.var_706A);
            var_01 = self getweaponammostock(self.var_706A);
            if(var_01 == 0 && var_00 < 2) {
              self method_82FA(self.var_201C, var_00);
              self setweaponammostock(self.var_201C, var_01);
            }
          }
        }
        break;

      case "STATE_CARRY_NO_PLANT":
      case "STATE_PLANTED_TO_CARRY":
      case "STATE_PLANTED_NO_CARRY":
      case "STATE_CARRY_TO_PLANT":
        self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
        break;
    }

    wait 0.05;
  }
}

func_62DA() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  var_00 = undefined;
  var_01 = 0;
  for(;;) {
    var_02 = getdvarint("weapon_plant_enabled", 1);
    if(!var_02 && isDefined(self.var_7077)) {
      self notify("weapon_plant_cleanup");
      return;
    }

    switch (self.var_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        self.var_7073 = undefined;
        self.var_7070 = undefined;
        self.var_706D = undefined;
        if(!func_1F65()) {
          break;
        }

        var_03 = getdvarint("weapon_plant_prone_plant", 1);
        var_04 = var_03 && self getstance() == "prone";
        var_05 = getdvarint("turret_clip_plant", 1);
        var_06 = getdvarint("turret_mantle_plant", 0);
        var_07 = undefined;
        var_08 = undefined;
        var_07 = getdvarfloat("4485");
        if(var_04) {
          var_08 = var_07;
        }

        var_09 = undefined;
        if(isDefined(self.var_7075)) {
          self.var_7073 = self.var_7075;
        } else {
          var_0A = common_scripts\_hit_found::func_9F90(var_05, var_06, var_04, var_07, var_08);
          var_0B = var_0A[0];
          var_0C = var_0A[1];
          var_09 = var_0A[2];
          if(var_04 && isDefined(var_0B)) {
            self.var_7073 = var_0B;
            self.var_7076 = "prone";
            if(!self playerweaponplantcheckprone(self.var_7073)) {
              self.var_7073 = undefined;
            }
          } else if(isDefined(var_0B) && common_scripts\_hit_found::func_4B43(var_0B, var_07, func_4074())) {
            self.var_7073 = var_0B;
            self.var_7076 = undefined;
            var_0D = getdvarfloat("3235", 48);
            var_0E = getdvarfloat("1492", 34);
            var_0F = var_0B[2] - self.var_0116[2];
            if(var_0F >= var_0D) {
              var_10 = func_43DE();
              var_11 = var_0D + var_10;
              if(var_0F <= var_11 + 0.001) {
                self.var_7076 = "stand";
              } else {
                self.var_7073 = undefined;
                break;
              }
            } else if(var_11 > var_10) {
              self.var_7076 = "stand";
            }

            if(!isDefined(self.var_7076)) {
              if(var_11 <= var_10) {
                var_12 = func_43DA();
                var_13 = var_10 - var_12;
                if(var_11 >= var_13 - 0.001) {
                  self.var_7076 = "crouch";
                } else {
                  self.var_7073 = undefined;
                  break;
                }
              }
            }
          }
        }

        if(isDefined(self.var_7075)) {
          var_08 = self.var_7075;
        } else if(isDefined(self.var_7073)) {
          if(isDefined(self.var_706F) && self.var_706F) {
            self.var_7070 = self.var_7073;
            self.var_7073 = undefined;
          } else {
            self.var_706D = var_11;
            var_08 = self.var_7073;
          }
        }
        break;

      case "STATE_CARRY_TO_PLANT":
        break;

      case "STATE_PLANTED":
      case "STATE_PLANTED_NO_CARRY":
        self.var_7073 = undefined;
        break;

      case "STATE_CARRY_NO_PLANT":
        self.var_7073 = undefined;
        break;
    }

    if(func_43DD() == "NATIVE_DPAD_LEFT") {
      var_14 = undefined;
      if(isDefined(self.var_706E) && self.var_706E) {
        var_14 = 0;
      } else {
        switch (self.var_7077) {
          case "STATE_CARRY":
          case "STATE_FIRST_CARRY":
            var_14 = isDefined(self.var_7073) || isDefined(self.var_7075);
            break;

          case "STATE_CARRY_TO_PLANT":
            var_14 = -1;
            break;

          case "STATE_PLANTED_NO_CARRY":
            var_14 = -1;
            break;

          case "STATE_PLANTED":
            var_14 = 1;
            break;

          case "STATE_PLANTED_TO_CARRY":
            var_14 = -1;
            break;

          case "STATE_CARRY_NO_PLANT":
            var_14 = -1;
            break;
        }
      }

      if(var_14 == 1) {
        if(!self method_85EC()) {
          self enableweaponswitch();
          func_680D();
        }
      } else if(var_14 == 0) {
        if(self method_85EC()) {
          self.var_A1FC = 0;
          self.var_A6B4 = 0;
          self method_8328();
          func_680C();
        }
      }

      if(self.var_7077 == "STATE_CARRY" && !self method_85EC() && self method_86B1("to_alt")) {
        self.var_7073 = var_0F;
        self notify("native_dpad_force_plant");
      }
    }

    wait 0.05;
  }
}

func_6370() {
  self endon("disconnect");
  self endon("cleanupWeaponPlantImmediate");
  self notify("monitor_planted_weapon_cleanup");
  self endon("monitor_planted_weapon_cleanup");
  var_00 = common_scripts\utility::func_A716("weapon_plant_cleanup", "weapon_change", "death", "joined_team", "joined_spectators", "weaponPlantFiringRange");
  if(var_00 == "weapon_change") {
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;
    var_04 = self getcurrentweapon();
    if(func_43DD() == "SCRIPTED_SWAP") {
      var_01 = 0;
      var_02 = isDefined(self.var_706A) && var_04 == self.var_706A;
      var_03 = isDefined(self.var_706A) && var_04 == self.var_201C;
      if(var_03) {
        if(isDefined(self.var_706A) && self hasweapon(self.var_706A)) {
          var_05 = self getweaponammoclip(self.var_706A);
          var_06 = self getweaponammostock(self.var_706A);
          var_07 = var_05 == 0 && var_06 == 0;
          if(var_07) {
            var_08 = getdvarfloat("weapon_plant_input_hold_duration", 0.2);
            self notify("plant_button_down");
            wait(var_08);
            self notify("plant_button_up");
          }
        }
      }
    } else {
      var_01 = var_04 == self.var_201C || var_04 == self.var_706A;
    }

    if(var_04 != "none" && var_01 || var_02 || var_03) {
      thread func_6370();
      return;
    }
  }

  if(common_scripts\utility::func_562E(self.tmpplayerfreeze)) {
    func_98DF();
  }

  func_2399(1);
}

func_98DF() {
  if(func_43DD() != "NATIVE_DPAD_LEFT") {
    self allowlook(1);
  }

  self allowjump(1);
  self method_8307(1);
  self.tmpplayerfreeze = undefined;
}

func_98E0() {
  self.tmpplayerfreeze = 1;
  if(func_43DD() != "NATIVE_DPAD_LEFT") {
    self allowlook(0);
  }

  self allowjump(0);
  self method_8307(0);
}

func_21D0(param_00) {
  self endon("disconnect");
  self endon("cleanupWeaponPlantImmediate");
  var_01 = 0;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  if(!isDefined(param_00)) {
    return;
  }

  var_05 = param_00 func_8C6C();
  var_06 = param_00.var_0106;
  var_07 = "";
  if(param_00.var_003A == "scriptable") {
    var_07 = param_00 getscriptablepartstate(0);
  }

  if(func_5778(param_00)) {
    var_02 = param_00.var_0116;
    var_03 = param_00.var_001D;
    if(param_00 method_8221() && param_00 gettagangles("TAG_YAW") != -1) {
      var_04 = param_00 gettagangles("TAG_YAW");
    }
  }

  for(;;) {
    if(!isDefined(param_00)) {
      var_01 = 1;
    } else if(isDefined(var_05) && !var_05 && (param_00.var_003A == "script_brushmodel" || param_00.var_003A == "script_model") && param_00 func_8C6C()) {
      var_01 = 1;
    } else if((param_00.var_003A == "script_brushmodel" || param_00.var_003A == "script_model") && !param_00 method_86A9()) {
      var_01 = 1;
    } else if(param_00.var_003A == "scriptable" && param_00 getscriptablepartstate(0) != var_07) {
      var_01 = 1;
    } else if(isDefined(param_00.var_0106) && param_00.var_0106 != "" && param_00 isentdestructible() && param_00 getdestructibledestroyedpercent() > 0) {
      var_01 = 1;
    } else if(isDefined(var_02) && distance2dsquared(var_02, param_00.var_0116) > 1) {
      var_01 = 1;
    } else if(isDefined(var_03) && distancesquared(var_03, param_00.var_001D) > 1) {
      var_01 = 1;
    } else if(isDefined(var_04) && distance2dsquared(var_04, param_00 gettagangles("TAG_YAW")) > 1) {
      var_01 = 1;
    }

    if(var_01) {
      self notify("plantOnEntityRemoved");
      if(func_43DD() == "NATIVE_DPAD_LEFT") {
        self switchtoweapon(self.var_201C);
      }

      return;
    }

    wait 0.05;
  }
}

func_6518(param_00) {
  if(isDefined(level.var_A9B1.var_6518)) {
    return self[[level.var_A9B1.var_6518]](param_00);
  }
}

func_4295(param_00) {
  return self[[level.var_A9B1.var_4295]](param_00);
}

func_707B(param_00, param_01, param_02) {
  return self[[level.var_A9B1.var_707B]](param_00, param_01, param_02);
}

func_2FEE() {
  return self[[level.var_A9B1.var_2FEE]]();
}

func_3A66() {
  return self[[level.var_A9B1.var_3A66]]();
}

func_8B6B() {
  return self[[level.var_A9B1.var_8B6B]]();
}

func_43DE() {
  return self[[level.var_A9B1.var_43DE]]();
}

func_43DA() {
  return self[[level.var_A9B1.var_43DA]]();
}

func_941B(param_00, param_01, param_02, param_03) {
  return self[[level.var_A9B1.var_941B]](param_00, param_01, param_02, param_03);
}

func_2373() {
  return self[[level.var_A9B1.var_2373]]();
}

func_4355(param_00) {
  return self[[level.var_A9B1.var_4355]](param_00);
}

func_8B53() {
  return self[[level.var_A9B1.var_8B53]]();
}

func_4074() {
  return self[[level.var_A9B1.var_4074]]();
}

get_weapon_paintjobid() {
  return self[[level.var_A9B1.get_weapon_paintjobid]]();
}

get_weapon_charmguid() {
  return self[[level.var_A9B1.get_weapon_charmguid]]();
}

func_43DD() {
  return func_43DC(self.var_201C);
}

func_43DC(param_00) {
  return self[[level.var_A9B1.var_43DC]](param_00);
}

func_439E(param_00) {
  return self[[level.var_A9B1.var_439E]](param_00);
}

func_41C4() {
  return self[[level.var_A9B1.var_41C4]]();
}

func_41B5() {
  return self[[level.var_A9B1.var_41B5]]();
}

func_43D9() {
  return self[[level.var_A9B1.var_43D9]]();
}

func_8C6C() {
  if(isDefined(level.var_A9B1.var_8C6C)) {
    return self[[level.var_A9B1.var_8C6C]]();
  }

  return undefined;
}

func_5778(param_00) {
  return [[level.var_A9B1.var_5778]](param_00);
}

func_8BAF() {
  return [[level.var_A9B1.var_8BAF]]();
}