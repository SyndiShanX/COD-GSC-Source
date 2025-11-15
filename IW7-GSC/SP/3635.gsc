/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3635.gsc
************************/

func_8CFA() {
  precacheshader("hud_ar57");
  precacheshader("weapon_kac");
  precacheshader("hud_erad");
  precacheshader("weapon_p226");
  level.var_8CEE = ["steel_dragon"];
  level.player.var_8CED = undefined;
  level.player.var_1030C = undefined;
  level.player thread func_8CFB();
  level.player thread func_8CF5();
  level.player getraidspawnpoint();
  level.player notifyonplayercommand("weapnext", "+weapnext");
  setdvarifuninitialized("heavy_slot_hud", 1);
  setdvarifuninitialized("heavy_slot_hud_heavyhanded", 1);
  level.player scripts\sp\utility::func_65E0("player_heavy_weapon_active");
  scripts\sp\utility::func_16EB("heavy_weapon_slot_hint", "HOLD ^3[{+weapnext}]^7 TO USE HEAVY WEAPON", ::func_8CF9);
}

_meth_82D7(param_00) {
  self.var_8CED = param_00;
  self giveweapon(param_00);
  self notify("give_heavy_weapon");
}

func_8CF5() {
  var_00 = "none";
  for(;;) {
    self waittill("pickup");
    self waittill("weapon_change");
    var_01 = self getcurrentweapon();
    if(scripts\engine\utility::array_contains(level.var_8CEE, var_01)) {
      self.var_8CED = var_01;
      self notify("give_heavy_weapon");
    }

    var_00 = var_01;
  }
}

settenthstimerstatic(param_00, param_01) {}

func_8CFB(param_00) {
  self endon("death");
  for(;;) {
    childthread func_8CEF();
    var_01 = scripts\engine\utility::waittill_any_return("give_heavy_weapon", "give_next_weapon");
    if(!self _meth_843C()) {
      continue;
    }

    if(var_01 == "give_heavy_weapon") {
      if(!isDefined(self.var_8CED)) {
        continue;
      }

      level.player scripts\sp\utility::func_65E1("player_heavy_weapon_active");
      var_02 = self getcurrentweapon();
      self.var_1030C = var_02;
      self switchtoweaponimmediate(self.var_8CED);
      self waittill("weapnext");
      level.player scripts\sp\utility::func_65DD("player_heavy_weapon_active");
      self switchtoweaponimmediate(var_02);
    } else {
      if(isDefined(self.var_8CED) && isDefined(self.var_8D0B)) {
        self.var_8D0B[self.var_8CED].var_9070 scripts\sp\hud_util::updatebar(0);
      }

      var_03 = self getweaponslistprimaries();
      foreach(var_05 in var_03) {
        if(scripts\engine\utility::array_contains(level.var_8CEE, var_05)) {
          continue;
        }

        if(var_05 != self getcurrentweapon()) {
          if(isDefined(self.var_8CED) && var_05 == self.var_8CED) {
            continue;
          }

          self switchtoweaponimmediate(var_05);
          break;
        }
      }
    }

    while(self buttonpressed("BUTTON_Y")) {
      scripts\engine\utility::waitframe();
    }
  }
}

func_8CEF() {
  self endon("give_heavy_weapon");
  if(isDefined(self.var_8CED) && isDefined(self.var_8D0B)) {
    self.var_8D0B[self.var_8CED].var_9070 scripts\sp\hud_util::updatebar(0);
    self.var_8D0B[self.var_8CED].var_9070 func_9071(0);
  }

  self waittill("weapnext");
  if(isDefined(self.var_8CED) && self getcurrentweapon() != self.var_8CED) {
    childthread func_C137();
    while(self buttonpressed("BUTTON_Y")) {
      scripts\engine\utility::waitframe();
    }
  }

  self notify("give_next_weapon");
}

func_C137() {
  self endon("give_next_weapon");
  wait(0.15);
  if(isDefined(self.var_8D0B)) {
    self.var_8D0B[self.var_8CED] func_9071(0.8);
  }

  var_00 = 0.2;
  var_00 = var_00 * 1000;
  var_01 = gettime();
  while(gettime() - var_01 <= var_00) {
    var_02 = gettime() - var_01;
    var_03 = var_02 / var_00;
    if(isDefined(self.var_8D0B)) {
      self.var_8D0B[self.var_8CED] scripts\sp\hud_util::updatebar(var_03);
    }

    wait(0.05);
  }

  self notify("give_heavy_weapon");
}

func_8CF0() {
  var_00 = func_7A28();
  var_01 = [];
  var_02 = [190, 255, 220];
  var_03 = [170, 170, 200];
  var_04 = 285;
  var_05 = 90;
  var_06 = [0, 65, 30];
  var_02 = [];
  foreach(var_09, var_08 in var_06) {
    var_02[var_09] = var_04 + var_08;
  }

  var_06 = [0, 0, 30];
  var_03 = [];
  foreach(var_09, var_08 in var_06) {
    var_03[var_09] = var_05 + var_08;
  }

  var_0B = level.player getweaponslistprimaries();
  for(var_09 = 0; var_09 < 3; var_09++) {
    var_0C = undefined;
    if(isDefined(var_0B[var_09])) {
      var_0D = strtok(var_0B[var_09], "+");
      var_0C = var_0D[0];
    }

    var_0E = 0.3;
    var_0F = 60;
    var_10 = "hud_ar57";
    if(isDefined(var_0C) && isDefined(var_00[var_0C])) {
      var_10 = var_00[var_0C];
    }

    var_11 = level.player scripts\sp\hud_util::createicon(var_10, var_0F, int(var_0F / 2));
    var_11 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_02[var_09], var_03[var_09]);
    var_11.alpha = var_0E;
    if(var_09 == 2) {
      var_11.var_8D0A = 1;
      var_12 = level.player scripts\sp\hud_util::func_4997("white", "black", 70, 5);
      var_12 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_02[var_09], var_03[var_09] + 15);
      var_12 func_9071(var_0E);
      var_12 scripts\sp\hud_util::updatebar(1);
      var_11.var_9070 = var_12;
    }

    if(!isDefined(var_0C)) {
      var_11.alpha = 0;
      if(isDefined(var_11.var_9070)) {
        var_11.var_9070 func_9071(0.3);
      }

      var_11.var_13CFB = "undefined";
      var_01["undefined"] = var_11;
      continue;
    }

    var_11.var_13CFB = var_0C;
    var_01[var_0C] = var_11;
  }

  thread func_8CF3();
  level.player.var_8D0B = var_01;
}

func_9071(param_00) {
  self.alpha = param_00;
  self.bar.alpha = param_00;
}

func_8CF3() {
  level.player endon("death");
  var_00 = "none";
  for(;;) {
    while(level.player getcurrentweapon() == "none") {
      wait(0.05);
    }

    var_01 = level.player getcurrentweapon();
    while(var_01 == var_00) {
      var_01 = level.player getcurrentweapon();
      wait(0.05);
    }

    func_8CF2(var_01);
    var_00 = var_01;
    level.player scripts\engine\utility::waittill_any_3("weapon_change", "pickup");
  }
}

func_8CF4() {
  level.player endon("death");
  for(;;) {
    level.player waittill("pickup");
    var_00 = func_8CF1();
    func_8CF2(var_00);
  }
}

func_8CF2(param_00) {
  var_01 = strtok(param_00, "+");
  param_00 = var_01[0];
  if(!isDefined(level.player.var_8D0B)) {
    return;
  }

  if(!isDefined(level.player.var_8D0B[param_00])) {
    func_8CF1(param_00);
  }

  var_02 = func_7A28();
  var_03 = func_7BFC();
  foreach(var_05 in var_03) {
    var_06 = 0.4;
    var_07 = 60;
    if(param_00 == var_05) {
      var_06 = 1;
      var_07 = 80;
    }

    var_08 = "hud_ar57";
    if(isDefined(var_02[var_05])) {
      var_08 = var_02[var_05];
    }

    level.player.var_8D0B[var_05] setshader(var_08, var_07, int(var_07 / 2));
    level.player.var_8D0B[var_05].alpha = var_06;
    if(isDefined(level.player.var_8D0B[var_05].var_9070)) {
      if(param_00 == var_05) {
        level.player.var_8D0B[var_05].var_9070 func_9071(0);
      }
    }
  }
}

func_8CF1(param_00) {
  var_01 = func_7BFC();
  var_02 = func_7A28();
  var_03 = undefined;
  foreach(var_05 in level.player.var_8D0B) {
    if(param_00 == "steel_dragon") {
      var_03 = "undefined";
      break;
    }

    if(var_05.var_13CFB == "undefined") {
      continue;
    }

    if(!scripts\engine\utility::array_contains(var_01, var_05.var_13CFB)) {
      var_03 = var_05.var_13CFB;
    }
  }

  level.player.var_8D0B[param_00] = level.player.var_8D0B[var_03];
  level.player.var_8D0B[param_00].var_13CFB = param_00;
  level.player.var_8D0B[var_03] = undefined;
  return param_00;
}

func_7BFC() {
  var_00 = level.player getweaponslistprimaries();
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = strtok(var_03, "+");
    var_01 = scripts\engine\utility::array_add(var_01, var_04[0]);
  }

  return var_01;
}

func_7A28() {
  var_00 = [];
  var_00["iw7_ar57"] = "hud_ar57";
  var_00["iw7_erad"] = "hud_erad";
  var_00["p226"] = "weapon_p226";
  var_00["steel_dragon"] = "weapon_kac";
  return var_00;
}

func_8CF9() {
  if(level.player scripts\sp\utility::func_65DB("player_heavy_weapon_active")) {
    return 1;
  }

  return 0;
}