/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3635.gsc
*********************************************/

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

_meth_82D7(var_0) {
  self.var_8CED = var_0;
  self giveweapon(var_0);
  self notify("give_heavy_weapon");
}

func_8CF5() {
  var_0 = "none";
  for(;;) {
    self waittill("pickup");
    self waittill("weapon_change");
    var_1 = self getcurrentweapon();
    if(scripts\engine\utility::array_contains(level.var_8CEE, var_1)) {
      self.var_8CED = var_1;
      self notify("give_heavy_weapon");
    }

    var_0 = var_1;
  }
}

settenthstimerstatic(var_0, var_1) {}

func_8CFB(var_0) {
  self endon("death");
  for(;;) {
    childthread func_8CEF();
    var_1 = scripts\engine\utility::waittill_any_return("give_heavy_weapon", "give_next_weapon");
    if(!self _meth_843C()) {
      continue;
    }

    if(var_1 == "give_heavy_weapon") {
      if(!isDefined(self.var_8CED)) {
        continue;
      }

      level.player scripts\sp\utility::func_65E1("player_heavy_weapon_active");
      var_2 = self getcurrentweapon();
      self.var_1030C = var_2;
      self switchtoweaponimmediate(self.var_8CED);
      self waittill("weapnext");
      level.player scripts\sp\utility::func_65DD("player_heavy_weapon_active");
      self switchtoweaponimmediate(var_2);
    } else {
      if(isDefined(self.var_8CED) && isDefined(self.var_8D0B)) {
        self.var_8D0B[self.var_8CED].var_9070 scripts\sp\hud_util::updatebar(0);
      }

      var_3 = self getweaponslistprimaries();
      foreach(var_5 in var_3) {
        if(scripts\engine\utility::array_contains(level.var_8CEE, var_5)) {
          continue;
        }

        if(var_5 != self getcurrentweapon()) {
          if(isDefined(self.var_8CED) && var_5 == self.var_8CED) {
            continue;
          }

          self switchtoweaponimmediate(var_5);
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

  var_0 = 0.2;
  var_0 = var_0 * 1000;
  var_1 = gettime();
  while(gettime() - var_1 <= var_0) {
    var_2 = gettime() - var_1;
    var_3 = var_2 / var_0;
    if(isDefined(self.var_8D0B)) {
      self.var_8D0B[self.var_8CED] scripts\sp\hud_util::updatebar(var_3);
    }

    wait(0.05);
  }

  self notify("give_heavy_weapon");
}

func_8CF0() {
  var_0 = func_7A28();
  var_1 = [];
  var_2 = [190, 255, 220];
  var_3 = [170, 170, 200];
  var_4 = 285;
  var_5 = 90;
  var_6 = [0, 65, 30];
  var_2 = [];
  foreach(var_9, var_8 in var_6) {
    var_2[var_9] = var_4 + var_8;
  }

  var_6 = [0, 0, 30];
  var_3 = [];
  foreach(var_9, var_8 in var_6) {
    var_3[var_9] = var_5 + var_8;
  }

  var_0B = level.player getweaponslistprimaries();
  for(var_9 = 0; var_9 < 3; var_9++) {
    var_0C = undefined;
    if(isDefined(var_0B[var_9])) {
      var_0D = strtok(var_0B[var_9], "+");
      var_0C = var_0D[0];
    }

    var_0E = 0.3;
    var_0F = 60;
    var_10 = "hud_ar57";
    if(isDefined(var_0C) && isDefined(var_0[var_0C])) {
      var_10 = var_0[var_0C];
    }

    var_11 = level.player scripts\sp\hud_util::createicon(var_10, var_0F, int(var_0F / 2));
    var_11 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_2[var_9], var_3[var_9]);
    var_11.alpha = var_0E;
    if(var_9 == 2) {
      var_11.var_8D0A = 1;
      var_12 = level.player scripts\sp\hud_util::func_4997("white", "black", 70, 5);
      var_12 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_2[var_9], var_3[var_9] + 15);
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
      var_1["undefined"] = var_11;
      continue;
    }

    var_11.var_13CFB = var_0C;
    var_1[var_0C] = var_11;
  }

  thread func_8CF3();
  level.player.var_8D0B = var_1;
}

func_9071(var_0) {
  self.alpha = var_0;
  self.bar.alpha = var_0;
}

func_8CF3() {
  level.player endon("death");
  var_0 = "none";
  for(;;) {
    while(level.player getcurrentweapon() == "none") {
      wait(0.05);
    }

    var_1 = level.player getcurrentweapon();
    while(var_1 == var_0) {
      var_1 = level.player getcurrentweapon();
      wait(0.05);
    }

    func_8CF2(var_1);
    var_0 = var_1;
    level.player scripts\engine\utility::waittill_any_3("weapon_change", "pickup");
  }
}

func_8CF4() {
  level.player endon("death");
  for(;;) {
    level.player waittill("pickup");
    var_0 = func_8CF1();
    func_8CF2(var_0);
  }
}

func_8CF2(var_0) {
  var_1 = strtok(var_0, "+");
  var_0 = var_1[0];
  if(!isDefined(level.player.var_8D0B)) {
    return;
  }

  if(!isDefined(level.player.var_8D0B[var_0])) {
    func_8CF1(var_0);
  }

  var_2 = func_7A28();
  var_3 = func_7BFC();
  foreach(var_5 in var_3) {
    var_6 = 0.4;
    var_7 = 60;
    if(var_0 == var_5) {
      var_6 = 1;
      var_7 = 80;
    }

    var_8 = "hud_ar57";
    if(isDefined(var_2[var_5])) {
      var_8 = var_2[var_5];
    }

    level.player.var_8D0B[var_5] setshader(var_8, var_7, int(var_7 / 2));
    level.player.var_8D0B[var_5].alpha = var_6;
    if(isDefined(level.player.var_8D0B[var_5].var_9070)) {
      if(var_0 == var_5) {
        level.player.var_8D0B[var_5].var_9070 func_9071(0);
      }
    }
  }
}

func_8CF1(var_0) {
  var_1 = func_7BFC();
  var_2 = func_7A28();
  var_3 = undefined;
  foreach(var_5 in level.player.var_8D0B) {
    if(var_0 == "steel_dragon") {
      var_3 = "undefined";
      break;
    }

    if(var_5.var_13CFB == "undefined") {
      continue;
    }

    if(!scripts\engine\utility::array_contains(var_1, var_5.var_13CFB)) {
      var_3 = var_5.var_13CFB;
    }
  }

  level.player.var_8D0B[var_0] = level.player.var_8D0B[var_3];
  level.player.var_8D0B[var_0].var_13CFB = var_0;
  level.player.var_8D0B[var_3] = undefined;
  return var_0;
}

func_7BFC() {
  var_0 = level.player getweaponslistprimaries();
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = strtok(var_3, "+");
    var_1 = scripts\engine\utility::array_add(var_1, var_4[0]);
  }

  return var_1;
}

func_7A28() {
  var_0 = [];
  var_0["iw7_ar57"] = "hud_ar57";
  var_0["iw7_erad"] = "hud_erad";
  var_0["p226"] = "weapon_p226";
  var_0["steel_dragon"] = "weapon_kac";
  return var_0;
}

func_8CF9() {
  if(level.player scripts\sp\utility::func_65DB("player_heavy_weapon_active")) {
    return 1;
  }

  return 0;
}