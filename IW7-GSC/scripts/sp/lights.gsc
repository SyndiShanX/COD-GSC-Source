/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\lights.gsc
*********************************/

init() {
  var_00 = getEntArray("script_light", "targetname");
  var_01 = getEntArray("script_light_toggle", "targetname");
  var_02 = getEntArray("script_light_flicker", "targetname");
  var_03 = getEntArray("script_light_pulse", "targetname");
  var_04 = getEntArray("generic_double_strobe", "targetname");
  var_05 = getEntArray("burning_trash_fire", "targetname");
  var_06 = getEntArray("generic_pulsing", "targetname");
  scripts\engine\utility::array_thread(var_00, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_01, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_02, ::init_light_flicker);
  scripts\engine\utility::array_thread(var_03, ::init_light_pulse_iw7);
  scripts\engine\utility::array_thread(var_04, ::func_774A);
  scripts\engine\utility::array_thread(var_05, ::func_3299);
  scripts\engine\utility::array_thread(var_06, ::func_7765);
}

init_light_generic_iw7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  wait(0.05);
  self.var_99E6 = func_95A8([self.script_intensity_01, param_00, self _meth_8134()]);
  self.var_438F = func_95A8([self.var_ED31, param_01, self _meth_8131()]);
  self.var_99E7 = func_95A8([self.var_EDEE, param_02, 0]);
  self.var_4390 = func_95A8([self.var_ED32, param_03, (0, 0, 0)]);
  self.var_C14B = func_95A8([self.var_EDFF, param_04]);
  self.var_C14C = func_95A8([self.var_EE00, param_05]);
  self.var_10D0C = func_95A8([self.var_EECC, param_06]);
  self.var_ACA5 = func_95A8([self.script_type, "generic"]);
  self.var_50D3 = issubstr(self.var_ACA5, "delaystart");
  if(!scripts\sp\utility::func_65DF("light_on")) {
    scripts\sp\utility::func_65E0("light_on");
  }

  self.var_AD83 = [];
  self.var_12BB6 = [];
  self.var_AD22 = [];
  self.var_127C9 = [];
  var_08 = scripts\sp\utility::func_7A8F();
  foreach(var_0A in var_08) {
    if(func_9C37(var_0A)) {
      self.var_AD22[self.var_AD22.size] = var_0A;
      continue;
    }

    if(isDefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "on") {
      self.var_AD83[self.var_AD83.size] = var_0A;
      continue;
    }

    if(isDefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "off") {
      self.var_12BB6[self.var_12BB6.size] = var_0A;
      continue;
    }

    if(issubstr(var_0A.classname, "trigger")) {
      self.var_127C9[self.var_127C9.size] = var_0A;
    }
  }

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    func_F466(0, (0, 0, 0));
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  if(isDefined(self.target)) {
    self.var_EF3C = getscriptablearray(self.target, "targetname");
  }

  if(self.var_AD83.size != 0 || self.var_12BB6.size != 0) {}

  scripts\engine\utility::array_thread(self.var_127C9, ::init_light_trig, self);
  foreach(var_0D in self.var_AD83) {
    if(isDefined(var_0D.script_fxid)) {
      var_0D.effect = scripts\engine\utility::createoneshoteffect(var_0D.script_fxid);
      var_0E = (0, 0, 0);
      var_0F = (0, 0, 0);
      if(isDefined(var_0D.script_parameters)) {
        var_10 = strtok(var_0D.script_parameters, ", ");
        var_0E = (float(var_10[0]), float(var_10[1]), float(var_10[2]));
        if(var_10.size >= 6) {
          var_0F = (float(var_10[3]), float(var_10[4]), float(var_10[5]));
        }
      }

      var_0D.effect scripts\common\createfx::set_origin_and_angles(var_0D.origin + var_0E, var_0D.angles + var_0F);
    }
  }

  self.var_9586 = 1;
  self notify("script_light_init_complete");
  if(isDefined(param_07) && param_07) {
    return;
  }

  if(isDefined(self.var_C14B) || isDefined(self.var_C14C) || self.var_127C9.size > 0) {
    thread func_ACA2();
  }
}

func_ACA2() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
  } else if(isDefined(self.var_C14B) || isDefined(self.var_12711)) {
    func_ACA3();
  }

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on")) {
      level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12711, self.var_C14B);
      scripts\sp\utility::script_delay();
      if(isDefined(self.var_50D3)) {
        if(isDefined(self.script_delay)) {
          self.var_C3D6 = self.script_delay;
        }

        if(isDefined(self.script_delay_max)) {
          self.var_C3D7 = self.script_delay_max;
        }

        if(isDefined(self.script_delay_min)) {
          self.var_C3D8 = self.script_delay_min;
        }

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      func_ACA4();
    }

    level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12712, self.var_C14C);
    scripts\sp\utility::script_delay();
    if(isDefined(self.var_50D3)) {
      if(isDefined(self.script_delay)) {
        self.var_C3D6 = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.var_C3D7 = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.var_C3D8 = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    func_ACA3();
    if(isDefined(self.var_C3D6)) {
      self.script_delay = self.var_C3D6;
    }

    if(isDefined(self.var_C3D7)) {
      self.script_delay_max = self.var_C3D7;
    }

    if(isDefined(self.var_C3D8)) {
      self.script_delay_min = self.var_C3D8;
    }

    wait(0.05);
  }
}

init_light_flicker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  init_light_generic_iw7(param_00, param_01, param_04, param_05, param_09, param_0A, param_0B, 1);
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  func_B27A(param_02, param_03, param_06, param_07, param_08, param_0C, param_0D);
  if(isDefined(param_0E) && param_0E) {
    return;
  }

  thread func_10C9A();
}

func_B27A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  init_light_type(param_05);
  self.var_1098E = func_95A8([self.var_EEBF, param_04, 1]);
  self.var_C4B5 = max(func_95A8([self.var_ED75, param_06, 3]) / self.var_1098E, 0.25);
  if((isDefined(self.var_EF17) && !isDefined(self.var_EF16)) || !isDefined(self.var_EF17) && isDefined(self.var_EF16)) {
    self.var_8E57 = max(func_95A8([self.var_EF17, self.var_EF16]) / self.var_1098E, 0.05);
  } else {
    self.var_13585 = max(func_95A8([self.var_EF17, param_00, 0.05]) / self.var_1098E, 0.05);
    self.var_13584 = max(func_95A8([self.var_EF16, param_01, 0.1]) / self.var_1098E, 0.1);
    if(self.var_13585 > self.var_13584) {
      var_07 = self.var_13584;
      self.var_13584 = self.var_13585;
      self.var_13585 = var_07;
    }
  }

  if((isDefined(self.var_EF19) && !isDefined(self.var_EF18)) || !isDefined(self.var_EF19) && isDefined(self.var_EF18)) {
    self.var_ADA3 = max(func_95A8([self.var_EF19, self.var_EF18]) / self.var_1098E, 0.05);
    return;
  }

  self.var_13587 = max(func_95A8([self.var_EF19, param_02, 0.05]) / self.var_1098E, 0.05);
  self.var_13586 = max(func_95A8([self.var_EF18, param_03, 0.75]) / self.var_1098E, 0.1);
  if(self.var_13587 > self.var_13586) {
    var_07 = self.var_13586;
    self.var_13586 = self.var_13587;
    self.var_13587 = var_07;
  }
}

func_10C9A() {
  if(self.var_12AE2 || self.var_12AE1) {
    thread func_AC89();
    return;
  }

  thread func_AC88();
}

func_AC88() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
  } else if(isDefined(self.var_C14B) || isDefined(self.var_12711)) {
    func_ACA3(undefined, self.var_12ACF);
  }

  if(isDefined(self.var_C14B) && isDefined(self.var_C14C)) {
    for(;;) {
      scripts\sp\utility::script_delay();
      if(isDefined(self.var_50D3)) {
        if(isDefined(self.script_delay)) {
          self.var_C3D6 = self.script_delay;
        }

        if(isDefined(self.script_delay_max)) {
          self.var_C3D7 = self.script_delay_max;
        }

        if(isDefined(self.script_delay_min)) {
          self.var_C3D8 = self.script_delay_min;
        }

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      func_AC8A();
      if(isDefined(self.var_10D0C) && self.var_10D0C) {
        func_ACA4();
      } else {
        func_ACA3(undefined, self.var_12ACF);
      }

      if(isDefined(self.var_C3D6)) {
        self.script_delay = self.var_C3D6;
      }

      if(isDefined(self.var_C3D7)) {
        self.script_delay_max = self.var_C3D7;
      }

      if(isDefined(self.var_C3D8)) {
        self.script_delay_min = self.var_C3D8;
      }

      wait(0.05);
    }

    return;
  }

  func_AC8A();
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
    return;
  }

  func_ACA3(undefined, self.var_12ACF);
}

func_AC89() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
  } else if(isDefined(self.var_C14B) || isDefined(self.var_12711)) {
    func_ACA3(undefined, self.var_12ACF);
  }

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on") && isDefined(self.var_12711) || isDefined(self.var_C14B)) {
      level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12711, self.var_C14B);
    }

    scripts\sp\utility::script_delay();
    if(isDefined(self.var_50D3)) {
      if(isDefined(self.script_delay)) {
        self.var_C3D6 = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.var_C3D7 = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.var_C3D8 = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.var_12AE2 && !scripts\sp\utility::func_65DB("light_on")) {
      childthread func_AC8A(1, self.var_DC8B);
      if(self.var_10E46) {
        wait(self.var_C4B5);
      } else {
        wait(randomfloat(self.var_C4B5));
      }

      self notify("stop_flicker");
    }

    func_ACA4();
    if(!isDefined(self.var_C14B) && !isDefined(self.var_12711)) {
      return;
    }

    if(!self.var_12AE3) {
      level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12712, self.var_C14C);
    } else {
      func_AC8A(1);
    }

    if(self.var_12AE1) {
      childthread func_AC8A(1, self.var_DC8A);
      if(self.var_10E46) {
        wait(self.var_C4B5);
      } else {
        wait(randomfloat(self.var_C4B5));
      }

      self notify("stop_flicker");
    }

    func_ACA3(undefined, self.var_12ACF);
    if(isDefined(self.var_C3D6)) {
      self.script_delay = self.var_C3D6;
    }

    if(isDefined(self.var_C3D7)) {
      self.script_delay_max = self.var_C3D7;
    }

    if(isDefined(self.var_C3D8)) {
      self.script_delay_min = self.var_C3D8;
    }

    wait(0.05);
    if(!isDefined(self.var_C14B) && !isDefined(self.var_C14C)) {
      return;
    }
  }
}

func_AC8A(param_00, param_01) {
  self notify("stop_flicker");
  self endon("stop_flicker");
  if(isDefined(self.var_12712)) {
    level endon(self.var_12712);
  }

  if(isDefined(self.var_C14C)) {
    level endon(self.var_C14C);
  }

  if(!isDefined(param_00) && isDefined(self.var_12711) || isDefined(self.var_C14B)) {
    level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12711, self.var_C14B);
  }

  for(;;) {
    func_ACA4(param_01);
    if(isDefined(self.var_8E57)) {
      wait(self.var_8E57);
    } else {
      wait(randomfloatrange(self.var_13585, self.var_13584));
    }

    func_ACA3(param_01);
    if(isDefined(self.var_ADA3)) {
      wait(self.var_ADA3);
      continue;
    }

    wait(randomfloatrange(self.var_13587, self.var_13586));
  }
}

init_light_pulse_iw7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  init_light_generic_iw7(param_00, param_01, param_04, param_05, param_09, param_0A, undefined, 1);
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  func_B27B(param_02, param_03, param_06, param_07, param_08, param_0C, param_0D, param_0B);
  if(isDefined(param_0E) && param_0E) {
    return;
  }

  thread func_10C9B();
}

func_B27B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self.var_10D0C = func_95A8([self.var_EECC, param_07, 1]);
  init_light_type(param_05);
  self.var_1098E = func_95A8([self.var_EEBF, param_04, 1]);
  self.var_C4B5 = max(func_95A8([self.var_ED75, param_06, 3]) / self.var_1098E, 3);
  if((isDefined(self.var_EF17) && !isDefined(self.var_EF16)) || !isDefined(self.var_EF17) && isDefined(self.var_EF16)) {
    self.var_8E57 = max(func_95A8([self.var_EF17, self.var_EF16]) / self.var_1098E, 0.05);
  } else {
    self.var_13585 = max(func_95A8([self.var_EF17, param_00, 0.05]) / self.var_1098E, 0.05);
    self.var_13584 = max(func_95A8([self.var_EF16, param_01, 0.5]) / self.var_1098E, 0.1);
    if(self.var_13585 > self.var_13584) {
      var_08 = self.var_13584;
      self.var_13584 = self.var_13585;
      self.var_13585 = var_08;
    }
  }

  if((isDefined(self.var_EF19) && !isDefined(self.var_EF18)) || !isDefined(self.var_EF19) && isDefined(self.var_EF18)) {
    self.var_ADA3 = max(func_95A8([self.var_EF19, self.var_EF18]) / self.var_1098E, 0.05);
    var_09 = int(self.var_ADA3 * 20);
    self.var_10F88 = 2 / var_09;
    self.var_99EA = 2 * self.var_99E6 - self.var_99E7 / var_09;
    return;
  }

  self.var_13587 = max(func_95A8([self.var_EF19, param_03, 0.25]) / self.var_1098E, 0.05);
  self.var_13586 = max(func_95A8([self.var_EF18, param_04, 0.75]) / self.var_1098E, 0.1);
  if(self.var_13587 > self.var_13586) {
    var_08 = self.var_13586;
    self.var_13586 = self.var_13587;
    self.var_13587 = var_08;
  }

  var_09 = int(self.var_13586 * 20);
  self.var_10F88 = 2 / var_09;
  self.var_99EA = 2 * self.var_99E6 - self.var_99E7 / var_09;
}

func_10C9B() {
  if(self.var_12AE2 || self.var_12AE1) {
    thread func_AC9D();
    return;
  }

  thread func_AC9C();
}

func_AC9C() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
  } else if(isDefined(self.var_C14B) || isDefined(self.var_12711)) {
    func_ACA3(undefined, self.var_12ACF);
  }

  if(isDefined(self.var_C14B) && isDefined(self.var_C14C)) {
    for(;;) {
      func_AC9E();
      if(isDefined(self.var_10D0C) && self.var_10D0C) {
        func_ACA4();
        continue;
      }

      func_ACA3(undefined, self.var_12ACF);
      wait(0.05);
    }

    return;
  }

  func_AC9E();
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
    return;
  }

  func_ACA3(undefined, self.var_12ACF);
}

func_AC9D() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");
  if(isDefined(self.var_10D0C) && self.var_10D0C) {
    func_ACA4();
  } else if(isDefined(self.var_C14B) || isDefined(self.var_12711)) {
    func_ACA3(undefined, self.var_12ACF);
  }

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on") && isDefined(self.var_12711) || isDefined(self.var_C14B)) {
      level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12711, self.var_C14B);
    }

    scripts\sp\utility::script_delay();
    if(isDefined(self.var_50D3)) {
      if(isDefined(self.script_delay)) {
        self.var_C3D6 = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.var_C3D7 = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.var_C3D8 = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.var_12AE2 && !scripts\sp\utility::func_65DB("light_on")) {
      childthread func_AC9E(1);
      if(self.var_10E46) {
        wait(self.var_C4B5);
      } else {
        wait(randomfloat(self.var_C4B5));
      }

      self notify("stop_pulse");
    }

    func_ACA4();
    if(!isDefined(self.var_C14B) && !isDefined(self.var_12711)) {
      return;
    }

    if(!self.var_12AE3) {
      level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12712, self.var_C14C);
    } else {
      func_AC9E(1);
    }

    if(self.var_12AE1) {
      childthread func_AC9E(1);
      if(self.var_10E46) {
        wait(self.var_C4B5);
      } else {
        wait(randomfloat(self.var_C4B5));
      }

      self notify("stop_flicker");
    }

    func_ACA3(undefined, self.var_12ACF);
    if(isDefined(self.var_C3D6)) {
      self.script_delay = self.var_C3D6;
    }

    if(isDefined(self.var_C3D7)) {
      self.script_delay_max = self.var_C3D7;
    }

    if(isDefined(self.var_C3D8)) {
      self.script_delay_min = self.var_C3D8;
    }

    wait(0.05);
    if(!isDefined(self.var_C14B) && !isDefined(self.var_C14C)) {
      return;
    }
  }
}

func_AC9E(param_00) {
  self notify("stop_pulse");
  self endon("stop_pulse");
  if(isDefined(self.var_12712)) {
    level endon(self.var_12712);
  }

  if(isDefined(self.var_C14C)) {
    level endon(self.var_C14C);
  }

  if(!isDefined(param_00) && isDefined(self.var_12711) || isDefined(self.var_C14B)) {
    level scripts\engine\utility::waittill_any_3("bemani_573", self.var_12711, self.var_C14B);
  }

  for(;;) {
    func_ACA4();
    if(isDefined(self.var_8E57)) {
      wait(self.var_8E57);
    } else {
      wait(randomfloatrange(self.var_13585, self.var_13584));
    }

    if(isDefined(self.var_ADA3)) {
      func_AC9B(self.var_ADA3);
      continue;
    }

    func_AC9B(randomfloatrange(self.var_13587, self.var_13586));
  }
}

init_light_trig(param_00) {
  self endon("death");
  var_01 = undefined;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var_01 = "trig_light_stop_" + scripts\sp\utility::string(param_00 getentitynumber());
    param_00.var_12712 = var_01;
  } else {
    var_01 = "trig_light_start_" + scripts\sp\utility::string(param_00 getentitynumber());
    param_00.var_12711 = var_01;
  }

  self waittill("trigger");
  level notify(var_01);
}

func_ACA4(param_00) {
  scripts\sp\utility::func_65E1("light_on");
  if(isDefined(param_00) && param_00 && self.var_99E6 > 0) {
    func_F466(randomfloatrange(self.var_99E6 * 0.25, self.var_99E6), self.var_438F);
  } else {
    func_F466(self.var_99E6, self.var_438F);
  }

  if(isDefined(self.script_prefab_exploder)) {
    scripts\engine\utility::exploder(self.script_prefab_exploder);
  }

  foreach(var_02 in self.var_EF3C) {
    var_02 setscriptablepartstate("onoff", "on");
  }

  scripts\engine\utility::array_call(self.var_12BB6, ::hide);
  foreach(var_05 in self.var_AD83) {
    var_05 show();
    if(isDefined(var_05.effect)) {
      var_05.effect scripts\sp\utility::func_E2B0();
    }
  }
}

func_ACA3(param_00, param_01) {
  scripts\sp\utility::func_65DD("light_on");
  if(isDefined(param_01) && param_01) {
    func_F466(0, (0, 0, 0));
  } else if(isDefined(param_00) && param_00 && self.var_99E7 > 0) {
    func_F466(randomfloatrange(self.var_99E7 * 0.25, self.var_99E7), self.var_4390);
  } else {
    func_F466(self.var_99E7, self.var_4390);
  }

  if(isDefined(self.script_prefab_exploder)) {
    scripts\sp\utility::func_10FEC(self.script_prefab_exploder);
  }

  foreach(var_03 in self.var_EF3C) {
    var_03 setscriptablepartstate("onoff", "off");
  }

  foreach(var_06 in self.var_AD83) {
    var_06 hide();
    if(isDefined(var_06.effect)) {
      var_06.effect scripts\engine\utility::pauseeffect();
    }
  }

  scripts\engine\utility::array_call(self.var_12BB6, ::show);
}

func_AC9B(param_00) {
  scripts\sp\utility::func_65DD("light_on");
  var_01 = int(param_00 / 0.1);
  for(var_02 = 1; var_02 <= var_01; var_02++) {
    var_03 = max(0, self.var_99E6 - self.var_99EA * var_02);
    var_04 = vectorlerp(self.var_438F, self.var_4390, self.var_10F88 * var_02);
    func_F466(var_03, var_04);
    wait(0.05);
  }

  for(var_02 = var_01; var_02 > 0; var_02--) {
    var_03 = max(0, self.var_99E6 - self.var_99EA * var_02);
    var_04 = vectorlerp(self.var_438F, self.var_4390, self.var_10F88 * var_02);
    func_F466(var_03, var_04);
    wait(0.05);
  }
}

func_ACD1(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, param_01);
  scripts\engine\utility::array_thread(var_05, ::func_1298C, param_02, param_03, param_04);
}

func_1298C(param_00, param_01, param_02) {
  if(!isDefined(self.var_9586)) {
    self waittill("script_light_init_complete");
  }

  if(isDefined(param_02) && param_02) {
    self notify("stop_script_light_loop");
  }

  var_03 = self.var_99E6;
  var_04 = self.var_438F;
  if(isDefined(param_00)) {
    var_03 = param_00;
  }

  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  scripts\sp\utility::func_65E1("light_on");
  func_F466(var_03, var_04);
  foreach(var_06 in self.var_EF3C) {
    var_06 setscriptablepartstate("onoff", "on");
  }

  scripts\engine\utility::array_call(self.var_12BB6, ::hide);
  foreach(var_09 in self.var_AD83) {
    var_09 show();
    if(isDefined(var_09.effect)) {
      var_09.effect scripts\sp\utility::func_E2B0();
    }
  }
}

func_ACD0(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, param_01);
  scripts\engine\utility::array_thread(var_05, ::func_12968, param_02, param_03, param_04);
}

func_12968(param_00, param_01, param_02) {
  if(!isDefined(self.var_9586)) {
    self waittill("script_light_init_complete");
  }

  if(isDefined(param_02) && param_02) {
    self notify("stop_script_light_loop");
  }

  var_03 = self.var_99E7;
  var_04 = self.var_4390;
  if(isDefined(param_00)) {
    var_03 = param_00;
  }

  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  scripts\sp\utility::func_65DD("light_on");
  func_F466(var_03, var_04);
  foreach(var_06 in self.var_EF3C) {
    var_06 setscriptablepartstate("onoff", "off");
  }

  foreach(var_09 in self.var_AD83) {
    var_09 hide();
    if(isDefined(var_09.effect)) {
      var_09.effect scripts\engine\utility::pauseeffect();
    }
  }

  scripts\engine\utility::array_call(self.var_12BB6, ::show);
}

func_F466(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 = max(0, param_00);
  }

  if(isDefined(param_01)) {
    param_01 = (max(0, param_01[0]), max(0, param_01[1]), max(0, param_01[2]));
  }

  if(isDefined(param_00)) {
    self setlightintensity(param_00);
    if(isDefined(self.var_AD22)) {
      scripts\engine\utility::array_call(self.var_AD22, ::setlightintensity, param_00);
    }
  }

  if(isDefined(param_01)) {
    self _meth_82FC(param_01);
    if(isDefined(self.var_AD22)) {
      scripts\engine\utility::array_call(self.var_AD22, ::_meth_82FC, param_01);
    }
  }
}

func_9C37(param_00) {
  return param_00.classname == "light_spot" || param_00.classname == "light_omni" || param_00.classname == "light";
}

func_95A8(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  return undefined;
}

init_light_type(param_00) {
  self.var_ACA5 = func_95A8([self.script_type, param_00, "generic"]);
  self.var_12ACF = issubstr(self.var_ACA5, "two_color");
  self.var_12AE2 = issubstr(self.var_ACA5, "on");
  self.var_12AE1 = issubstr(self.var_ACA5, "off");
  self.var_12AE3 = issubstr(self.var_ACA5, "running");
  self.var_10E46 = issubstr(self.var_ACA5, "timed");
  self.var_50D3 = issubstr(self.var_ACA5, "delaystart");
  self.var_DC8B = issubstr(self.var_ACA5, "on_random_intensity");
  self.var_DC8A = issubstr(self.var_ACA5, "off_random_intensity");
}

func_7765() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_00 = self _meth_8134();
  var_01 = 0.05;
  var_02 = var_00;
  var_03 = 0.3;
  var_04 = 0.6;
  var_05 = var_00 - var_01 / var_03 / 0.05;
  var_06 = var_00 - var_01 / var_04 / 0.05;
  for(;;) {
    var_07 = 0;
    while(var_07 < var_04) {
      var_02 = var_02 - var_06;
      var_02 = clamp(var_02, 0, 100);
      self setlightintensity(var_02);
      var_07 = var_07 + 0.05;
      wait(0.05);
    }

    wait(1);
    var_07 = 0;
    while(var_07 < var_03) {
      var_02 = var_02 + var_05;
      var_02 = clamp(var_02, 0, 100);
      self setlightintensity(var_02);
      var_07 = var_07 + 0.05;
      wait(0.05);
    }

    wait(0.5);
  }
}

func_774A() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_00 = self _meth_8134();
  var_01 = 0.05;
  var_02 = 0;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = 0;
  var_06 = [];
  if(isDefined(self.script_noteworthy)) {
    var_07 = getEntArray(self.script_noteworthy, "targetname");
    for(var_08 = 0; var_08 < var_07.size; var_08++) {
      if(func_9C37(var_07[var_08])) {
        var_05 = 1;
        var_06[var_06.size] = var_07[var_08];
      }

      if(var_07[var_08].classname == "script_model") {
        var_03 = var_07[var_08];
        var_04 = getent(var_03.target, "targetname");
        var_02 = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(var_01);
    if(var_02) {
      var_03 hide();
      var_04 show();
    }

    wait(0.8);
    self setlightintensity(var_00);
    if(var_02) {
      var_03 show();
      var_04 hide();
    }

    wait(0.1);
    self setlightintensity(var_01);
    if(var_02) {
      var_03 hide();
      var_04 show();
    }

    wait(0.12);
    self setlightintensity(var_00);
    if(var_02) {
      var_03 show();
      var_04 hide();
    }

    wait(0.1);
  }
}

func_776F() {
  level scripts\engine\utility::waitframe();
}

func_3299() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_00 = self _meth_8134();
  var_01 = var_00;
  for(;;) {
    var_02 = randomfloatrange(var_00 * 0.7, var_00 * 1.2);
    var_03 = randomfloatrange(0.3, 0.6);
    var_03 = var_03 * 20;
    for(var_04 = 0; var_04 < var_03; var_04++) {
      var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
      self setlightintensity(var_05);
      wait(0.05);
    }

    var_01 = var_02;
  }
}

func_11155(param_00, param_01, param_02, param_03) {
  var_04 = 360 / param_02;
  var_05 = 0;
  for(;;) {
    var_06 = sin(var_05 * var_04) * 0.5 + 0.5;
    self setlightintensity(param_00 + param_01 - param_00 * var_06);
    wait(0.05);
    var_05 = var_05 + 0.05;
    if(var_05 > param_02) {
      var_05 = var_05 - param_02;
    }

    if(isDefined(param_03)) {
      if(scripts\engine\utility::flag(param_03)) {
        return;
      }
    }
  }
}

func_3C57(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  thread func_3C58(param_00, param_01, param_02, param_03);
}

func_3C58(param_00, param_01, param_02, param_03) {
  var_04 = self _meth_8131();
  var_05 = 1 / param_01 * 2 - param_02 + param_03;
  var_06 = 0;
  if(var_06 < param_02) {
    var_07 = var_05 / param_02;
    while(var_06 < param_02) {
      var_08 = var_07 * var_06 * var_06;
      self _meth_82FC(vectorlerp(var_04, param_00, var_08));
      wait(0.05);
      var_06 = var_06 + 0.05;
    }
  }

  while(var_06 < param_01 - param_03) {
    var_08 = var_05 * 2 * var_06 - param_02;
    self _meth_82FC(vectorlerp(var_04, param_00, var_08));
    wait(0.05);
    var_06 = var_06 + 0.05;
  }

  var_06 = param_01 - var_06;
  if(var_06 > 0) {
    var_07 = var_05 / param_03;
    while(var_06 > 0) {
      var_08 = 1 - var_07 * var_06 * var_06;
      self _meth_82FC(vectorlerp(var_04, param_00, var_08));
      wait(0.05);
      var_06 = var_06 - 0.05;
    }
  }

  self _meth_82FC(param_00);
}

func_6F19(param_00, param_01) {
  var_02 = self _meth_8134();
  var_03 = 0;
  var_04 = var_02;
  var_05 = 0;
  for(;;) {
    for(var_05 = randomintrange(1, 10); var_05; var_05--) {
      wait(randomfloatrange(0.05, 0.1));
      if(var_04 > 0.2) {
        var_04 = randomfloatrange(0, 0.3);
      } else {
        var_04 = var_02;
      }

      self setlightintensity(var_04);
    }

    self setlightintensity(var_02);
    wait(randomfloatrange(param_00, param_01));
  }
}

func_11203(param_00) {
  var_01 = 1;
  if(isDefined(param_00.var_ED75)) {
    var_01 = param_00.var_ED75;
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    param_00 func_F5B8(var_01);
  }
}

func_F5B8(param_00) {
  var_01 = getdvarint("sm_sunenable", 1);
  var_02 = getdvarfloat("sm_sunshadowscale", 1);
  var_03 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_04 = getdvarfloat("sm_qualityspotshadow", 1);
  if(isDefined(self.var_EED5)) {
    var_01 = self.var_EED5;
  }

  if(isDefined(self.var_EED7)) {
    var_02 = self.var_EED7;
  }

  if(isDefined(self.var_EED6)) {
    var_03 = self.var_EED6;
  }

  var_03 = min(max(0.016, var_03), 32);
  if(isDefined(self.var_EE8E)) {
    var_04 = self.var_EE8E;
  }

  var_05 = getdvarint("sm_sunenable", 1);
  var_06 = getdvarfloat("sm_sunshadowscale", 1);
  var_07 = getdvarint("sm_qualityspotshadow", 1);
  setsaveddvar("sm_sunenable", var_01);
  setsaveddvar("sm_sunshadowscale", var_02);
  setsaveddvar("sm_qualityspotshadow", var_04);
  func_ABA0(var_03, param_00);
}

func_ABA0(param_00, param_01) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var_02 = getdvarfloat("sm_sunSampleSizeNear", 0.25);
  if(param_00 == var_02) {
    return;
  }

  var_03 = param_00 - var_02;
  var_04 = param_01 / 0.05;
  if(var_04 > 0) {
    var_05 = var_03 / var_04;
    var_06 = var_02;
    for(var_07 = 0; var_07 < var_04; var_07++) {
      var_06 = var_06 + var_05;
      setsaveddvar("sm_sunSampleSizeNear", var_06);
      wait(0.05);
    }
  }

  setsaveddvar("sm_sunSampleSizeNear", param_00);
}

func_AB83(param_00, param_01) {
  var_02 = int(param_01 * 20);
  var_03 = self _meth_8134();
  var_04 = param_00 - var_03 / var_02;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    thread func_8924(param_00);
    self setlightintensity(var_03 + var_05 * var_04);
    wait(0.05);
  }

  var_06[0] = self;
  if(isDefined(self.var_AD22)) {
    var_06 = scripts\engine\utility::array_combine(var_06, self.var_AD22);
  }

  foreach(var_08 in var_06) {
    var_08 thread func_8924(param_00);
    var_08 setlightintensity(param_00);
  }
}

func_8924(param_00) {
  if(isDefined(self.script_threshold)) {
    var_01 = param_00 > self.script_threshold;
    foreach(var_03 in self.var_AD83) {
      if(var_01 && !var_03.var_13438) {
        var_03.var_13438 = var_01;
        var_03 show();
        if(isDefined(var_03.effect)) {
          var_03.effect thread scripts\sp\utility::func_E2B0();
        }

        continue;
      }

      if(!var_01 && var_03.var_13438) {
        var_03.var_13438 = var_01;
        var_03 hide();
        if(isDefined(var_03.effect)) {
          var_03.effect thread scripts\engine\utility::pauseeffect();
        }
      }
    }

    foreach(var_03 in self.var_12BB6) {
      if(!var_01 && !var_03.var_13438) {
        var_03.var_13438 = 1;
        var_03 show();
        continue;
      }

      if(var_01 && var_03.var_13438) {
        var_03.var_13438 = 0;
        var_03 hide();
      }
    }
  }
}