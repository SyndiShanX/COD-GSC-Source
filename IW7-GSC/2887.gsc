/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2887.gsc
***************************************/

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

init_light_generic_iw7(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  wait 0.05;
  self.func_99E6 = func_95A8([self.script_intensity_01, var_00, self _meth_8134()]);
  self.func_438F = func_95A8([self.func_ED31, var_01, self _meth_8131()]);
  self.func_99E7 = func_95A8([self.func_EDEE, var_02, 0]);
  self.func_4390 = func_95A8([self.func_ED32, var_03, (0, 0, 0)]);
  self.func_C14B = func_95A8([self.func_EDFF, var_04]);
  self.func_C14C = func_95A8([self.func_EE00, var_05]);
  self.func_10D0C = func_95A8([self.func_EECC, var_06]);
  self.func_ACA5 = func_95A8([self.script_type, "generic"]);
  self.func_50D3 = issubstr(self.func_ACA5, "delaystart");

  if(!scripts\sp\utility::func_65DF("light_on"))
    scripts\sp\utility::func_65E0("light_on");

  self.func_AD83 = [];
  self.func_12BB6 = [];
  self.func_AD22 = [];
  self.func_127C9 = [];
  var_08 = scripts\sp\utility::func_7A8F();

  foreach(var_10 in var_08) {
    if(func_9C37(var_10)) {
      self.func_AD22[self.func_AD22.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "on") {
      self.func_AD83[self.func_AD83.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "off") {
      self.func_12BB6[self.func_12BB6.size] = var_10;
      continue;
    }

    if(issubstr(var_10.classname, "trigger"))
      self.func_127C9[self.func_127C9.size] = var_10;
  }

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    func_F466(0, (0, 0, 0));
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target))
    self.func_EF3C = getentitylessscriptablearrayinradius(self.target, "targetname");

  if(self.func_AD83.size != 0 || self.func_12BB6.size != 0) {}

  scripts\engine\utility::array_thread(self.func_127C9, ::init_light_trig, self);

  foreach(var_13 in self.func_AD83) {
    if(isDefined(var_13.script_fxid)) {
      var_13.effect = scripts\engine\utility::createoneshoteffect(var_13.script_fxid);
      var_14 = (0, 0, 0);
      var_15 = (0, 0, 0);

      if(isDefined(var_13.script_parameters)) {
        var_16 = strtok(var_13.script_parameters, ", ");
        var_14 = (float(var_16[0]), float(var_16[1]), float(var_16[2]));

        if(var_16.size >= 6)
          var_15 = (float(var_16[3]), float(var_16[4]), float(var_16[5]));
      }

      var_13.effect scripts\common\createfx::set_origin_and_angles(var_13.origin + var_14, var_13.angles + var_15);
    }
  }

  self.func_9586 = 1;
  self notify("script_light_init_complete");

  if(isDefined(var_07) && var_07) {
    return;
  }
  if(isDefined(self.func_C14B) || isDefined(self.func_C14C) || self.func_127C9.size > 0)
    thread func_ACA2();
}

func_ACA2() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.func_10D0C) && self.func_10D0C)
    func_ACA4();
  else if(isDefined(self.func_C14B) || isDefined(self.func_12711))
    func_ACA3();

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on")) {
      level scripts\engine\utility::waittill_any("bemani_573", self.func_12711, self.func_C14B);
      scripts\sp\utility::script_delay();

      if(isDefined(self.func_50D3)) {
        if(isDefined(self.script_delay))
          self.func_C3D6 = self.script_delay;

        if(isDefined(self.script_delay_max))
          self.func_C3D7 = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self.func_C3D8 = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      func_ACA4();
    }

    level scripts\engine\utility::waittill_any("bemani_573", self.func_12712, self.func_C14C);
    scripts\sp\utility::script_delay();

    if(isDefined(self.func_50D3)) {
      if(isDefined(self.script_delay))
        self.func_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.func_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.func_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    func_ACA3();

    if(isDefined(self.func_C3D6))
      self.script_delay = self.func_C3D6;

    if(isDefined(self.func_C3D7))
      self.script_delay_max = self.func_C3D7;

    if(isDefined(self.func_C3D8))
      self.script_delay_min = self.func_C3D8;

    wait 0.05;
  }
}

init_light_flicker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14) {
  init_light_generic_iw7(var_00, var_01, var_04, var_05, var_09, var_10, var_11, 1);

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  func_B27A(var_02, var_03, var_06, var_07, var_08, var_12, var_13);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread func_10C9A();
}

func_B27A(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  init_light_type(var_05);
  self.func_1098E = func_95A8([self.func_EEBF, var_04, 1]);
  self.func_C4B5 = max(func_95A8([self.func_ED75, var_06, 3]) / self.func_1098E, 0.25);

  if(isDefined(self.func_EF17) && !isDefined(self.func_EF16) || !isDefined(self.func_EF17) && isDefined(self.func_EF16))
    self.func_8E57 = max(func_95A8([self.func_EF17, self.func_EF16]) / self.func_1098E, 0.05);
  else {
    self.func_13585 = max(func_95A8([self.func_EF17, var_00, 0.05]) / self.func_1098E, 0.05);
    self.func_13584 = max(func_95A8([self.func_EF16, var_01, 0.1]) / self.func_1098E, 0.1);

    if(self.func_13585 > self.func_13584) {
      var_07 = self.func_13584;
      self.func_13584 = self.func_13585;
      self.func_13585 = var_07;
    }
  }

  if(isDefined(self.func_EF19) && !isDefined(self.func_EF18) || !isDefined(self.func_EF19) && isDefined(self.func_EF18))
    self.func_ADA3 = max(func_95A8([self.func_EF19, self.func_EF18]) / self.func_1098E, 0.05);
  else {
    self.func_13587 = max(func_95A8([self.func_EF19, var_02, 0.05]) / self.func_1098E, 0.05);
    self.func_13586 = max(func_95A8([self.func_EF18, var_03, 0.75]) / self.func_1098E, 0.1);

    if(self.func_13587 > self.func_13586) {
      var_07 = self.func_13586;
      self.func_13586 = self.func_13587;
      self.func_13587 = var_07;
    }
  }
}

func_10C9A() {
  if(self.func_12AE2 || self.func_12AE1)
    thread func_AC89();
  else
    thread func_AC88();
}

func_AC88() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.func_10D0C) && self.func_10D0C)
    func_ACA4();
  else if(isDefined(self.func_C14B) || isDefined(self.func_12711))
    func_ACA3(undefined, self.func_12ACF);

  if(isDefined(self.func_C14B) && isDefined(self.func_C14C)) {
    for(;;) {
      scripts\sp\utility::script_delay();

      if(isDefined(self.func_50D3)) {
        if(isDefined(self.script_delay))
          self.func_C3D6 = self.script_delay;

        if(isDefined(self.script_delay_max))
          self.func_C3D7 = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self.func_C3D8 = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      func_AC8A();

      if(isDefined(self.func_10D0C) && self.func_10D0C)
        func_ACA4();
      else
        func_ACA3(undefined, self.func_12ACF);

      if(isDefined(self.func_C3D6))
        self.script_delay = self.func_C3D6;

      if(isDefined(self.func_C3D7))
        self.script_delay_max = self.func_C3D7;

      if(isDefined(self.func_C3D8))
        self.script_delay_min = self.func_C3D8;

      wait 0.05;
    }
  } else {
    func_AC8A();

    if(isDefined(self.func_10D0C) && self.func_10D0C) {
      func_ACA4();
      return;
    }

    func_ACA3(undefined, self.func_12ACF);
  }
}

func_AC89() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.func_10D0C) && self.func_10D0C)
    func_ACA4();
  else if(isDefined(self.func_C14B) || isDefined(self.func_12711))
    func_ACA3(undefined, self.func_12ACF);

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on") && (isDefined(self.func_12711) || isDefined(self.func_C14B)))
      level scripts\engine\utility::waittill_any("bemani_573", self.func_12711, self.func_C14B);

    scripts\sp\utility::script_delay();

    if(isDefined(self.func_50D3)) {
      if(isDefined(self.script_delay))
        self.func_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.func_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.func_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.func_12AE2 && !scripts\sp\utility::func_65DB("light_on")) {
      childthread func_AC8A(1, self.func_DC8B);

      if(self.func_10E46)
        wait(self.func_C4B5);
      else
        wait(randomfloat(self.func_C4B5));

      self notify("stop_flicker");
    }

    func_ACA4();

    if(!isDefined(self.func_C14B) && !isDefined(self.func_12711)) {
      return;
    }
    if(!self.func_12AE3)
      level scripts\engine\utility::waittill_any("bemani_573", self.func_12712, self.func_C14C);
    else
      func_AC8A(1);

    if(self.func_12AE1) {
      childthread func_AC8A(1, self.func_DC8A);

      if(self.func_10E46)
        wait(self.func_C4B5);
      else
        wait(randomfloat(self.func_C4B5));

      self notify("stop_flicker");
    }

    func_ACA3(undefined, self.func_12ACF);

    if(isDefined(self.func_C3D6))
      self.script_delay = self.func_C3D6;

    if(isDefined(self.func_C3D7))
      self.script_delay_max = self.func_C3D7;

    if(isDefined(self.func_C3D8))
      self.script_delay_min = self.func_C3D8;

    wait 0.05;

    if(!isDefined(self.func_C14B) && !isDefined(self.func_C14C))
      return;
  }
}

func_AC8A(var_00, var_01) {
  self notify("stop_flicker");
  self endon("stop_flicker");

  if(isDefined(self.func_12712))
    level endon(self.func_12712);

  if(isDefined(self.func_C14C))
    level endon(self.func_C14C);

  if(!isDefined(var_00) && (isDefined(self.func_12711) || isDefined(self.func_C14B)))
    level scripts\engine\utility::waittill_any("bemani_573", self.func_12711, self.func_C14B);

  for(;;) {
    func_ACA4(var_01);

    if(isDefined(self.func_8E57))
      wait(self.func_8E57);
    else
      wait(randomfloatrange(self.func_13585, self.func_13584));

    func_ACA3(var_01);

    if(isDefined(self.func_ADA3)) {
      wait(self.func_ADA3);
      continue;
    }

    wait(randomfloatrange(self.func_13587, self.func_13586));
  }
}

init_light_pulse_iw7(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14) {
  init_light_generic_iw7(var_00, var_01, var_04, var_05, var_09, var_10, undefined, 1);

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  func_B27B(var_02, var_03, var_06, var_07, var_08, var_12, var_13, var_11);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread func_10C9B();
}

func_B27B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self.func_10D0C = func_95A8([self.func_EECC, var_07, 1]);
  init_light_type(var_05);
  self.func_1098E = func_95A8([self.func_EEBF, var_04, 1]);
  self.func_C4B5 = max(func_95A8([self.func_ED75, var_06, 3]) / self.func_1098E, 3);

  if(isDefined(self.func_EF17) && !isDefined(self.func_EF16) || !isDefined(self.func_EF17) && isDefined(self.func_EF16))
    self.func_8E57 = max(func_95A8([self.func_EF17, self.func_EF16]) / self.func_1098E, 0.05);
  else {
    self.func_13585 = max(func_95A8([self.func_EF17, var_00, 0.05]) / self.func_1098E, 0.05);
    self.func_13584 = max(func_95A8([self.func_EF16, var_01, 0.5]) / self.func_1098E, 0.1);

    if(self.func_13585 > self.func_13584) {
      var_08 = self.func_13584;
      self.func_13584 = self.func_13585;
      self.func_13585 = var_08;
    }
  }

  if(isDefined(self.func_EF19) && !isDefined(self.func_EF18) || !isDefined(self.func_EF19) && isDefined(self.func_EF18)) {
    self.func_ADA3 = max(func_95A8([self.func_EF19, self.func_EF18]) / self.func_1098E, 0.05);
    var_09 = int(self.func_ADA3 * 20);
    self.func_10F88 = 2 / var_09;
    self.func_99EA = 2 * (self.func_99E6 - self.func_99E7) / var_09;
  } else {
    self.func_13587 = max(func_95A8([self.func_EF19, var_02, 0.25]) / self.func_1098E, 0.05);
    self.func_13586 = max(func_95A8([self.func_EF18, var_03, 0.75]) / self.func_1098E, 0.1);

    if(self.func_13587 > self.func_13586) {
      var_08 = self.func_13586;
      self.func_13586 = self.func_13587;
      self.func_13587 = var_08;
    }

    var_09 = int(self.func_13586 * 20);
    self.func_10F88 = 2 / var_09;
    self.func_99EA = 2 * (self.func_99E6 - self.func_99E7) / var_09;
  }
}

func_10C9B() {
  if(self.func_12AE2 || self.func_12AE1)
    thread func_AC9D();
  else
    thread func_AC9C();
}

func_AC9C() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.func_10D0C) && self.func_10D0C)
    func_ACA4();
  else if(isDefined(self.func_C14B) || isDefined(self.func_12711))
    func_ACA3(undefined, self.func_12ACF);

  if(isDefined(self.func_C14B) && isDefined(self.func_C14C)) {
    for(;;) {
      func_AC9E();

      if(isDefined(self.func_10D0C) && self.func_10D0C)
        func_ACA4();
      else
        func_ACA3(undefined, self.func_12ACF);

      wait 0.05;
    }
  } else {
    func_AC9E();

    if(isDefined(self.func_10D0C) && self.func_10D0C) {
      func_ACA4();
      return;
    }

    func_ACA3(undefined, self.func_12ACF);
  }
}

func_AC9D() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.func_10D0C) && self.func_10D0C)
    func_ACA4();
  else if(isDefined(self.func_C14B) || isDefined(self.func_12711))
    func_ACA3(undefined, self.func_12ACF);

  for(;;) {
    if(!scripts\sp\utility::func_65DB("light_on") && (isDefined(self.func_12711) || isDefined(self.func_C14B)))
      level scripts\engine\utility::waittill_any("bemani_573", self.func_12711, self.func_C14B);

    scripts\sp\utility::script_delay();

    if(isDefined(self.func_50D3)) {
      if(isDefined(self.script_delay))
        self.func_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.func_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.func_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.func_12AE2 && !scripts\sp\utility::func_65DB("light_on")) {
      childthread func_AC9E(1);

      if(self.func_10E46)
        wait(self.func_C4B5);
      else
        wait(randomfloat(self.func_C4B5));

      self notify("stop_pulse");
    }

    func_ACA4();

    if(!isDefined(self.func_C14B) && !isDefined(self.func_12711)) {
      return;
    }
    if(!self.func_12AE3)
      level scripts\engine\utility::waittill_any("bemani_573", self.func_12712, self.func_C14C);
    else
      func_AC9E(1);

    if(self.func_12AE1) {
      childthread func_AC9E(1);

      if(self.func_10E46)
        wait(self.func_C4B5);
      else
        wait(randomfloat(self.func_C4B5));

      self notify("stop_flicker");
    }

    func_ACA3(undefined, self.func_12ACF);

    if(isDefined(self.func_C3D6))
      self.script_delay = self.func_C3D6;

    if(isDefined(self.func_C3D7))
      self.script_delay_max = self.func_C3D7;

    if(isDefined(self.func_C3D8))
      self.script_delay_min = self.func_C3D8;

    wait 0.05;

    if(!isDefined(self.func_C14B) && !isDefined(self.func_C14C))
      return;
  }
}

func_AC9E(var_00) {
  self notify("stop_pulse");
  self endon("stop_pulse");

  if(isDefined(self.func_12712))
    level endon(self.func_12712);

  if(isDefined(self.func_C14C))
    level endon(self.func_C14C);

  if(!isDefined(var_00) && (isDefined(self.func_12711) || isDefined(self.func_C14B)))
    level scripts\engine\utility::waittill_any("bemani_573", self.func_12711, self.func_C14B);

  for(;;) {
    func_ACA4();

    if(isDefined(self.func_8E57))
      wait(self.func_8E57);
    else
      wait(randomfloatrange(self.func_13585, self.func_13584));

    if(isDefined(self.func_ADA3)) {
      func_AC9B(self.func_ADA3);
      continue;
    }

    func_AC9B(randomfloatrange(self.func_13587, self.func_13586));
  }
}

init_light_trig(var_00) {
  self endon("death");
  var_01 = undefined;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var_01 = "trig_light_stop_" + scripts\sp\utility::string(var_00 getentitynumber());
    var_0.func_12712 = var_01;
  } else {
    var_01 = "trig_light_start_" + scripts\sp\utility::string(var_00 getentitynumber());
    var_0.func_12711 = var_01;
  }

  self waittill("trigger");
  level notify(var_01);
}

func_ACA4(var_00) {
  scripts\sp\utility::func_65E1("light_on");

  if(isDefined(var_00) && var_00 && self.func_99E6 > 0)
    func_F466(randomfloatrange(self.func_99E6 * 0.25, self.func_99E6), self.func_438F);
  else
    func_F466(self.func_99E6, self.func_438F);

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::exploder(self.script_prefab_exploder);

  foreach(var_02 in self.func_EF3C)
  var_02 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self.func_12BB6, ::hide);

  foreach(var_05 in self.func_AD83) {
    var_05 show();

    if(isDefined(var_5.effect))
      var_5.effect scripts\sp\utility::func_E2B0();
  }
}

func_ACA3(var_00, var_01) {
  scripts\sp\utility::func_65DD("light_on");

  if(isDefined(var_01) && var_01)
    func_F466(0, (0, 0, 0));
  else if(isDefined(var_00) && var_00 && self.func_99E7 > 0)
    func_F466(randomfloatrange(self.func_99E7 * 0.25, self.func_99E7), self.func_4390);
  else
    func_F466(self.func_99E7, self.func_4390);

  if(isDefined(self.script_prefab_exploder))
    scripts\sp\utility::func_10FEC(self.script_prefab_exploder);

  foreach(var_03 in self.func_EF3C)
  var_03 setscriptablepartstate("onoff", "off");

  foreach(var_06 in self.func_AD83) {
    var_06 hide();

    if(isDefined(var_6.effect))
      var_6.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self.func_12BB6, ::show);
}

func_AC9B(var_00) {
  scripts\sp\utility::func_65DD("light_on");
  var_01 = int(var_00 / 0.1);

  for(var_02 = 1; var_02 <= var_01; var_2++) {
    var_03 = max(0, self.func_99E6 - self.func_99EA * var_02);
    var_04 = vectorlerp(self.func_438F, self.func_4390, self.func_10F88 * var_02);
    func_F466(var_03, var_04);
    wait 0.05;
  }

  for(var_02 = var_01; var_02 > 0; var_2--) {
    var_03 = max(0, self.func_99E6 - self.func_99EA * var_02);
    var_04 = vectorlerp(self.func_438F, self.func_4390, self.func_10F88 * var_02);
    func_F466(var_03, var_04);
    wait 0.05;
  }
}

func_ACD1(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getEntArray(var_00, var_01);
  scripts\engine\utility::array_thread(var_05, ::func_1298C, var_02, var_03, var_04);
}

func_1298C(var_00, var_01, var_02) {
  if(!isDefined(self.func_9586))
    self waittill("script_light_init_complete");

  if(isDefined(var_02) && var_02)
    self notify("stop_script_light_loop");

  var_03 = self.func_99E6;
  var_04 = self.func_438F;

  if(isDefined(var_00))
    var_03 = var_00;

  if(isDefined(var_01))
    var_04 = var_01;

  scripts\sp\utility::func_65E1("light_on");
  func_F466(var_03, var_04);

  foreach(var_06 in self.func_EF3C)
  var_06 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self.func_12BB6, ::hide);

  foreach(var_09 in self.func_AD83) {
    var_09 show();

    if(isDefined(var_9.effect))
      var_9.effect scripts\sp\utility::func_E2B0();
  }
}

func_ACD0(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getEntArray(var_00, var_01);
  scripts\engine\utility::array_thread(var_05, ::func_12968, var_02, var_03, var_04);
}

func_12968(var_00, var_01, var_02) {
  if(!isDefined(self.func_9586))
    self waittill("script_light_init_complete");

  if(isDefined(var_02) && var_02)
    self notify("stop_script_light_loop");

  var_03 = self.func_99E7;
  var_04 = self.func_4390;

  if(isDefined(var_00))
    var_03 = var_00;

  if(isDefined(var_01))
    var_04 = var_01;

  scripts\sp\utility::func_65DD("light_on");
  func_F466(var_03, var_04);

  foreach(var_06 in self.func_EF3C)
  var_06 setscriptablepartstate("onoff", "off");

  foreach(var_09 in self.func_AD83) {
    var_09 hide();

    if(isDefined(var_9.effect))
      var_9.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self.func_12BB6, ::show);
}

func_F466(var_00, var_01) {
  if(isDefined(var_00))
    var_00 = max(0, var_00);

  if(isDefined(var_01))
    var_01 = (max(0, var_1[0]), max(0, var_1[1]), max(0, var_1[2]));

  if(isDefined(var_00)) {
    self setlightintensity(var_00);

    if(isDefined(self.func_AD22))
      scripts\engine\utility::array_call(self.func_AD22, ::setlightintensity, var_00);
  }

  if(isDefined(var_01)) {
    self _meth_82FC(var_01);

    if(isDefined(self.func_AD22))
      scripts\engine\utility::array_call(self.func_AD22, ::_meth_82FC, var_01);
  }
}

func_9C37(var_00) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

func_95A8(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      return var_02;
  }

  return undefined;
}

init_light_type(var_00) {
  self.func_ACA5 = func_95A8([self.script_type, var_00, "generic"]);
  self.func_12ACF = issubstr(self.func_ACA5, "two_color");
  self.func_12AE2 = issubstr(self.func_ACA5, "on");
  self.func_12AE1 = issubstr(self.func_ACA5, "off");
  self.func_12AE3 = issubstr(self.func_ACA5, "running");
  self.func_10E46 = issubstr(self.func_ACA5, "timed");
  self.func_50D3 = issubstr(self.func_ACA5, "delaystart");
  self.func_DC8B = issubstr(self.func_ACA5, "on_random_intensity");
  self.func_DC8A = issubstr(self.func_ACA5, "off_random_intensity");
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
  var_05 = (var_00 - var_01) / (var_03 / 0.05);
  var_06 = (var_00 - var_01) / (var_04 / 0.05);

  for(;;) {
    var_07 = 0;

    while(var_07 < var_04) {
      var_02 = var_02 - var_06;
      var_02 = clamp(var_02, 0, 100);
      self setlightintensity(var_02);
      var_07 = var_07 + 0.05;
      wait 0.05;
    }

    wait 1;
    var_07 = 0;

    while(var_07 < var_03) {
      var_02 = var_02 + var_05;
      var_02 = clamp(var_02, 0, 100);
      self setlightintensity(var_02);
      var_07 = var_07 + 0.05;
      wait 0.05;
    }

    wait 0.5;
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

    for(var_08 = 0; var_08 < var_7.size; var_8++) {
      if(func_9C37(var_7[var_08])) {
        var_05 = 1;
        var_6[var_6.size] = var_7[var_08];
      }

      if(var_7[var_08].classname == "script_model") {
        var_03 = var_7[var_08];
        var_04 = getent(var_3.target, "targetname");
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

    wait 0.8;
    self setlightintensity(var_00);

    if(var_02) {
      var_03 show();
      var_04 hide();
    }

    wait 0.1;
    self setlightintensity(var_01);

    if(var_02) {
      var_03 hide();
      var_04 show();
    }

    wait 0.12;
    self setlightintensity(var_00);

    if(var_02) {
      var_03 show();
      var_04 hide();
    }

    wait 0.1;
  }
}

func_776F() {
  for(;;)
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

    for(var_04 = 0; var_04 < var_03; var_4++) {
      var_05 = var_02 * (var_04 / var_03) + var_01 * ((var_03 - var_04) / var_03);
      self setlightintensity(var_05);
      wait 0.05;
    }

    var_01 = var_02;
  }
}

func_11155(var_00, var_01, var_02, var_03) {
  var_04 = 360 / var_02;
  var_05 = 0;

  for(;;) {
    var_06 = sin(var_05 * var_04) * 0.5 + 0.5;
    self setlightintensity(var_00 + (var_01 - var_00) * var_06);
    wait 0.05;
    var_05 = var_05 + 0.05;

    if(var_05 > var_02)
      var_05 = var_05 - var_02;

    if(isDefined(var_03)) {
      if(scripts\engine\utility::flag(var_03))
        return;
    }
  }
}

func_3C57(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  thread func_3C58(var_00, var_01, var_02, var_03);
}

func_3C58(var_00, var_01, var_02, var_03) {
  var_04 = self _meth_8131();
  var_05 = 1 / (var_01 * 2 - (var_02 + var_03));
  var_06 = 0;

  if(var_06 < var_02) {
    for(var_07 = var_05 / var_02; var_06 < var_02; var_06 = var_06 + 0.05) {
      var_08 = var_07 * var_06 * var_06;
      self _meth_82FC(vectorlerp(var_04, var_00, var_08));
      wait 0.05;
    }
  }

  while(var_06 < var_01 - var_03) {
    var_08 = var_05 * (2 * var_06 - var_02);
    self _meth_82FC(vectorlerp(var_04, var_00, var_08));
    wait 0.05;
    var_06 = var_06 + 0.05;
  }

  var_06 = var_01 - var_06;

  if(var_06 > 0) {
    for(var_07 = var_05 / var_03; var_06 > 0; var_06 = var_06 - 0.05) {
      var_08 = 1 - var_07 * var_06 * var_06;
      self _meth_82FC(vectorlerp(var_04, var_00, var_08));
      wait 0.05;
    }
  }

  self _meth_82FC(var_00);
}

func_6F19(var_00, var_01) {
  var_02 = self _meth_8134();
  var_03 = 0;
  var_04 = var_02;
  var_05 = 0;

  for(;;) {
    for(var_05 = randomintrange(1, 10); var_05; var_5--) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_04 > 0.2)
        var_04 = randomfloatrange(0, 0.3);
      else
        var_04 = var_02;

      self setlightintensity(var_04);
    }

    self setlightintensity(var_02);
    wait(randomfloatrange(var_00, var_01));
  }
}

func_11203(var_00) {
  var_01 = 1;

  if(isDefined(var_0.func_ED75))
    var_01 = var_0.func_ED75;

  for(;;) {
    var_00 waittill("trigger", var_02);
    var_00 func_F5B8(var_01);
  }
}

func_F5B8(var_00) {
  var_01 = getdvarint("sm_sunenable", 1);
  var_02 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_03 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_04 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isDefined(self.func_EED5))
    var_01 = self.func_EED5;

  if(isDefined(self.func_EED7))
    var_02 = self.func_EED7;

  if(isDefined(self.func_EED6))
    var_03 = self.func_EED6;

  var_03 = min(max(0.016, var_03), 32);

  if(isDefined(self.func_EE8E))
    var_04 = self.func_EE8E;

  var_05 = getdvarint("sm_sunenable", 1);
  var_06 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_07 = getdvarint("sm_qualityspotshadow", 1.0);
  _setsaveddvar("sm_sunenable", var_01);
  _setsaveddvar("sm_sunshadowscale", var_02);
  _setsaveddvar("sm_qualityspotshadow", var_04);
  func_ABA0(var_03, var_00);
}

func_ABA0(var_00, var_01) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var_02 = getdvarfloat("sm_sunSampleSizeNear", 0.25);

  if(var_00 == var_02) {
    return;
  }
  var_03 = var_00 - var_02;
  var_04 = var_01 / 0.05;

  if(var_04 > 0) {
    var_05 = var_03 / var_04;
    var_06 = var_02;

    for(var_07 = 0; var_07 < var_04; var_7++) {
      var_06 = var_06 + var_05;
      _setsaveddvar("sm_sunSampleSizeNear", var_06);
      wait 0.05;
    }
  }

  _setsaveddvar("sm_sunSampleSizeNear", var_00);
}

func_AB83(var_00, var_01) {
  var_02 = int(var_01 * 20);
  var_03 = self _meth_8134();
  var_04 = (var_00 - var_03) / var_02;

  for(var_05 = 0; var_05 < var_02; var_5++) {
    thread func_8924(var_00);
    self setlightintensity(var_03 + var_05 * var_04);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self.func_AD22))
    var_06 = scripts\engine\utility::array_combine(var_06, self.func_AD22);

  foreach(var_08 in var_06) {
    var_08 thread func_8924(var_00);
    var_08 setlightintensity(var_00);
  }
}

func_8924(var_00) {
  if(isDefined(self.script_threshold)) {
    var_01 = var_00 > self.script_threshold;

    foreach(var_03 in self.func_AD83) {
      if(var_01 && !var_3.func_13438) {
        var_3.func_13438 = var_01;
        var_03 show();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\sp\utility::func_E2B0();

        continue;
      }

      if(!var_01 && var_3.func_13438) {
        var_3.func_13438 = var_01;
        var_03 hide();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }

    foreach(var_03 in self.func_12BB6) {
      if(!var_01 && !var_3.func_13438) {
        var_3.func_13438 = 1;
        var_03 show();
        continue;
      }

      if(var_01 && var_3.func_13438) {
        var_3.func_13438 = 0;
        var_03 hide();
      }
    }
  }
}