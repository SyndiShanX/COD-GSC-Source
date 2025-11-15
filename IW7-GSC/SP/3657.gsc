/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3657.gsc
************************/

func_660C() {
  thread func_F34E("normal");
  thread func_51E0(::func_694B);
}

func_694B() {}

func_660D() {
  thread func_F34E("relaxed");
  thread func_51E0(::func_694C);
}

func_694C() {}

func_660E(param_00) {
  thread func_F34E("safe");
  if(!isDefined(param_00) || param_00 == 0) {
    thread scripts\sp\utility::func_2B76(0.8, 0.2);
    self.var_77C1.var_51E5 = 1;
  }

  self getrawbaseweaponname(0.7, 0.7);
  thread func_EA1E();
  scripts\engine\utility::allow_melee(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_doublejump(0);
  scripts\engine\utility::allow_wallrun(0);
  scripts\engine\utility::allow_ads(0);
  thread func_51E0(::func_694D);
}

func_694D(param_00) {
  if(isDefined(self.var_77C1.var_51E5) && self.var_77C1.var_51E5 == 1) {
    thread scripts\sp\utility::func_2B77(0.2);
    self.var_77C1.var_51E5 = 0;
  }

  self _meth_80A6();
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_doublejump(1);
  scripts\engine\utility::allow_wallrun(1);
  scripts\engine\utility::allow_ads(1);
}

func_660B() {
  self goto_selected("safe", "ges_demeanor_magboots");
  thread func_51E0(::func_694A);
}

func_694A() {}

func_EA1E() {
  self endon("entering_new_demeanor");
  self endon("death");
  self.var_77C1.var_EA1F = getdvarint("cg_fov");
  childthread func_EA1C();
  childthread func_EA1D();
  thread func_EA1B();
}

func_EA1C() {
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");
  for(;;) {
    self waittill("safe_zoom_pressed");
    self _meth_81DE(self.var_77C1.var_EA1F - 9, 0.14);
  }
}

func_EA1D() {
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");
  for(;;) {
    self waittill("safe_zoom_released");
    self _meth_81DE(self.var_77C1.var_EA1F, 0.1);
  }
}

func_EA1B() {
  self endon("death");
  self waittill("entering_new_demeanor");
  self _meth_81DE(self.var_77C1.var_EA1F, 0.1);
}

func_51E0(param_00) {
  self waittill("entering_new_demeanor");
  self[[param_00]]();
}

func_F34E(param_00) {
  self endon("entering_new_demeanor");
  self endon("death");
  for(;;) {
    var_01 = self goto_selected(param_00);
    if(var_01) {
      break;
    }

    wait(0.05);
  }
}

func_D092(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  self endon("death");
  if(!isDefined(self.var_77C1)) {
    self.var_77C1 = spawnStruct();
  }

  if(isDefined(param_01) && param_01 == 1) {
    if(level.player getstance() == "prone") {
      if(isDefined(self.var_77C1.var_DA82)) {} else if(isDefined(level.player.var_BCF5)) {
        self.var_77C1.var_DA82 = level.player.var_BCF5;
      } else {
        self.var_77C1.var_DA82 = 1;
      }

      scripts\sp\utility::func_2B76(0);
      thread func_D094(param_00);
      if(!isDefined(self.var_77C1.var_E2F4)) {
        self.var_77C1.var_E2F4 = 0;
      }

      self.var_77C1.var_E2F4++;
    } else {
      if(!isDefined(self.var_77C1.var_E2F5)) {
        self.var_77C1.var_E2F5 = 0;
      }

      self.var_77C1.var_E2F5++;
      scripts\engine\utility::allow_prone(0);
    }

    self.var_77C1.var_E2F3 = 1;
  }

  if(isDefined(param_02) && param_02 == 1) {
    if(!isDefined(self.var_77C1.var_E2F0)) {
      self.var_77C1.var_E2F0 = 0;
    }

    self.var_77C1.var_E2F0++;
    scripts\engine\utility::allow_mantle(0);
  }

  if(isDefined(param_03) && param_03 == 1) {
    if(!isDefined(self.var_77C1.var_E2F7)) {
      self.var_77C1.var_E2F7 = 0;
    }

    self.var_77C1.var_E2F7++;
    scripts\engine\utility::allow_sprint(0);
  }

  if(isDefined(param_04) && param_04 == 1) {
    if(!isDefined(self.var_77C1.var_E2EF)) {
      self.var_77C1.var_E2EF = 0;
    }

    self.var_77C1.var_E2EF++;
    scripts\engine\utility::allow_fire(0);
  }

  if(isDefined(param_05) && param_05 == 1) {
    if(!isDefined(self.var_77C1.var_E2F6)) {
      self.var_77C1.var_E2F6 = 0;
    }

    self.var_77C1.var_E2F6++;
    scripts\engine\utility::allow_reload(0);
  }

  if(isDefined(param_06) && param_06 == 1) {
    if(!isDefined(self.var_77C1.var_E2F9)) {
      self.var_77C1.var_E2F9 = 0;
    }

    self.var_77C1.var_E2F9++;
    scripts\engine\utility::allow_weapon_switch(0);
  }

  if(isDefined(param_07) && param_07 == 1) {
    if(!isDefined(self.var_77C1.var_E2ED)) {
      self.var_77C1.var_E2ED = 0;
    }

    self.var_77C1.var_E2ED++;
    scripts\engine\utility::allow_ads(0);
  }

  if(isDefined(param_08) && param_08 == 1) {
    if(!isDefined(self.var_77C1.var_E2F8)) {
      self.var_77C1.var_E2F8 = 0;
    }

    self.var_77C1.var_E2F8++;
    scripts\engine\utility::allow_wallrun(0);
  }

  if(isDefined(param_09) && param_09 == 1) {
    if(!isDefined(self.var_77C1.var_E2EE)) {
      self.var_77C1.var_E2EE = 0;
    }

    self.var_77C1.var_E2EE++;
    scripts\engine\utility::allow_doublejump(0);
  }

  if(isDefined(param_0A) && param_0A == 1) {
    if(!isDefined(self.var_77C1.var_E2F1)) {
      self.var_77C1.var_E2F1 = 0;
    }

    self.var_77C1.var_E2F1++;
    scripts\engine\utility::allow_melee(0);
  }

  if(isDefined(param_0B) && param_0B == 1) {
    if(!isDefined(self.var_77C1.var_E2F2)) {
      self.var_77C1.var_E2F2 = 0;
    }

    self.var_77C1.var_E2F2++;
    scripts\engine\utility::allow_offhand_weapons(0);
  }

  if(isDefined(param_0C)) {
    wait(param_0C);
  } else {
    self waittill("gesture_stopped", var_0D);
    if(var_0D != param_00) {
      for(;;) {
        if(!self isgestureplaying(param_00)) {
          break;
        }

        wait(0.05);
      }
    }
  }

  self notify(param_00 + "gesture_stopped_internal");
  func_D093(param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_D093(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(self.var_77C1)) {
    self.var_77C1 = spawnStruct();
  }

  if(isDefined(param_00) && param_00 > 0) {
    if(isDefined(self.var_77C1.var_E2F4) && self.var_77C1.var_E2F4 > 0) {
      if(isDefined(level.player.var_BCF5) && level.player.var_BCF5 == 0) {
        self.var_77C1.var_E2F4--;
        if(self.var_77C1.var_E2F4 <= 0) {
          scripts\sp\utility::func_2B76(self.var_77C1.var_DA82);
          self.var_77C1.var_DA82 = undefined;
        }
      }
    }

    if(isDefined(self.var_77C1.var_E2F5) && self.var_77C1.var_E2F5 > 0) {
      self.var_77C1.var_E2F5--;
      scripts\engine\utility::allow_prone(1);
    }
  }

  if(isDefined(param_01) && param_01 == 1) {
    scripts\engine\utility::allow_mantle(1);
  }

  if(isDefined(param_02) && param_02 == 1) {
    scripts\engine\utility::allow_sprint(1);
  }

  if(isDefined(param_03) && param_03 == 1) {
    scripts\engine\utility::allow_fire(1);
  }

  if(isDefined(param_04) && param_04 == 1) {
    scripts\engine\utility::allow_reload(1);
  }

  if(isDefined(param_05) && param_05 == 1) {
    scripts\engine\utility::allow_weapon_switch(1);
  }

  if(isDefined(param_06) && param_06 == 1) {
    scripts\engine\utility::allow_ads(1);
  }

  if(isDefined(param_07) && param_07 == 1) {
    scripts\engine\utility::allow_wallrun(1);
  }

  if(isDefined(param_08) && param_08 == 1) {
    scripts\engine\utility::allow_doublejump(1);
  }

  if(isDefined(param_09) && param_09 == 1) {
    scripts\engine\utility::allow_melee(1);
  }

  if(isDefined(param_0A) && param_0A == 1) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }
}

func_D094(param_00) {
  self endon("death");
  self endon(param_00 + "gesture_stopped_internal");
  var_01 = 1;
  while(var_01) {
    if(self getstance() != "prone") {
      waittillframeend;
      if(isDefined(level.player.var_BCF5) && level.player.var_BCF5 == 0) {
        self.var_77C1.var_E2F4--;
        if(self.var_77C1.var_E2F4 <= 0) {
          scripts\sp\utility::func_2B76(self.var_77C1.var_DA82);
          self.var_77C1.var_DA82 = undefined;
        }
      }

      if(!isDefined(self.var_77C1.var_E2F5)) {
        self.var_77C1.var_E2F5 = 0;
      }

      self.var_77C1.var_E2F5++;
      scripts\engine\utility::allow_prone(0);
      var_01 = 0;
    }

    wait(0.05);
  }
}