/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2887.gsc
**************************************/

init() {
  var_0 = getEntArray("script_light", "targetname");
  var_1 = getEntArray("script_light_toggle", "targetname");
  var_2 = getEntArray("script_light_flicker", "targetname");
  var_3 = getEntArray("script_light_pulse", "targetname");
  var_4 = getEntArray("generic_double_strobe", "targetname");
  var_5 = getEntArray("burning_trash_fire", "targetname");
  var_6 = getEntArray("generic_pulsing", "targetname");
  scripts\engine\utility::array_thread(var_0, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_1, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_2, ::init_light_flicker);
  scripts\engine\utility::array_thread(var_3, ::init_light_pulse_iw7);
  scripts\engine\utility::array_thread(var_4, ::_id_774A);
  scripts\engine\utility::array_thread(var_5, ::_id_3299);
  scripts\engine\utility::array_thread(var_6, ::_id_7765);
}

init_light_generic_iw7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait 0.05;
  self._id_99E6 = _id_95A8([self.script_intensity_01, var_0, self _meth_8134()]);
  self._id_438F = _id_95A8([self._id_ED31, var_1, self _meth_8131()]);
  self._id_99E7 = _id_95A8([self._id_EDEE, var_2, 0]);
  self._id_4390 = _id_95A8([self._id_ED32, var_3, (0, 0, 0)]);
  self._id_C14B = _id_95A8([self._id_EDFF, var_4]);
  self._id_C14C = _id_95A8([self._id_EE00, var_5]);
  self._id_10D0C = _id_95A8([self._id_EECC, var_6]);
  self._id_ACA5 = _id_95A8([self.script_type, "generic"]);
  self._id_50D3 = issubstr(self._id_ACA5, "delaystart");

  if(!scripts\sp\utility::_id_65DF("light_on"))
    scripts\sp\utility::_id_65E0("light_on");

  self._id_AD83 = [];
  self._id_12BB6 = [];
  self._id_AD22 = [];
  self._id_127C9 = [];
  var_8 = scripts\sp\utility::_id_7A8F();

  foreach(var_10 in var_8) {
    if(_id_9C37(var_10)) {
      self._id_AD22[self._id_AD22.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "on") {
      self._id_AD83[self._id_AD83.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "off") {
      self._id_12BB6[self._id_12BB6.size] = var_10;
      continue;
    }

    if(issubstr(var_10.classname, "trigger"))
      self._id_127C9[self._id_127C9.size] = var_10;
  }

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    _id_F466(0, (0, 0, 0));
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target))
    self._id_EF3C = getscriptablearray(self.target, "targetname");

  if(self._id_AD83.size != 0 || self._id_12BB6.size != 0) {}

  scripts\engine\utility::array_thread(self._id_127C9, ::init_light_trig, self);

  foreach(var_13 in self._id_AD83) {
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

  self._id_9586 = 1;
  self notify("script_light_init_complete");

  if(isDefined(var_7) && var_7) {
    return;
  }
  if(isDefined(self._id_C14B) || isDefined(self._id_C14C) || self._id_127C9.size > 0)
    thread _id_ACA2();
}

_id_ACA2() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self._id_10D0C) && self._id_10D0C)
    _id_ACA4();
  else if(isDefined(self._id_C14B) || isDefined(self._id_12711))
    _id_ACA3();

  for(;;) {
    if(!scripts\sp\utility::_id_65DB("light_on")) {
      level scripts\engine\utility::waittill_any("bemani_573", self._id_12711, self._id_C14B);
      scripts\sp\utility::script_delay();

      if(isDefined(self._id_50D3)) {
        if(isDefined(self.script_delay))
          self._id_C3D6 = self.script_delay;

        if(isDefined(self.script_delay_max))
          self._id_C3D7 = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self._id_C3D8 = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      _id_ACA4();
    }

    level scripts\engine\utility::waittill_any("bemani_573", self._id_12712, self._id_C14C);
    scripts\sp\utility::script_delay();

    if(isDefined(self._id_50D3)) {
      if(isDefined(self.script_delay))
        self._id_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self._id_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self._id_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    _id_ACA3();

    if(isDefined(self._id_C3D6))
      self.script_delay = self._id_C3D6;

    if(isDefined(self._id_C3D7))
      self.script_delay_max = self._id_C3D7;

    if(isDefined(self._id_C3D8))
      self.script_delay_min = self._id_C3D8;

    wait 0.05;
  }
}

init_light_flicker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  init_light_generic_iw7(var_0, var_1, var_4, var_5, var_9, var_10, var_11, 1);

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  _id_B27A(var_2, var_3, var_6, var_7, var_8, var_12, var_13);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread _id_10C9A();
}

_id_B27A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  init_light_type(var_5);
  self._id_1098E = _id_95A8([self._id_EEBF, var_4, 1]);
  self._id_C4B5 = max(_id_95A8([self._id_ED75, var_6, 3]) / self._id_1098E, 0.25);

  if(isDefined(self._id_EF17) && !isDefined(self._id_EF16) || !isDefined(self._id_EF17) && isDefined(self._id_EF16))
    self._id_8E57 = max(_id_95A8([self._id_EF17, self._id_EF16]) / self._id_1098E, 0.05);
  else {
    self._id_13585 = max(_id_95A8([self._id_EF17, var_0, 0.05]) / self._id_1098E, 0.05);
    self._id_13584 = max(_id_95A8([self._id_EF16, var_1, 0.1]) / self._id_1098E, 0.1);

    if(self._id_13585 > self._id_13584) {
      var_7 = self._id_13584;
      self._id_13584 = self._id_13585;
      self._id_13585 = var_7;
    }
  }

  if(isDefined(self._id_EF19) && !isDefined(self._id_EF18) || !isDefined(self._id_EF19) && isDefined(self._id_EF18))
    self._id_ADA3 = max(_id_95A8([self._id_EF19, self._id_EF18]) / self._id_1098E, 0.05);
  else {
    self._id_13587 = max(_id_95A8([self._id_EF19, var_2, 0.05]) / self._id_1098E, 0.05);
    self._id_13586 = max(_id_95A8([self._id_EF18, var_3, 0.75]) / self._id_1098E, 0.1);

    if(self._id_13587 > self._id_13586) {
      var_7 = self._id_13586;
      self._id_13586 = self._id_13587;
      self._id_13587 = var_7;
    }
  }
}

_id_10C9A() {
  if(self._id_12AE2 || self._id_12AE1)
    thread _id_AC89();
  else
    thread _id_AC88();
}

_id_AC88() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self._id_10D0C) && self._id_10D0C)
    _id_ACA4();
  else if(isDefined(self._id_C14B) || isDefined(self._id_12711))
    _id_ACA3(undefined, self._id_12ACF);

  if(isDefined(self._id_C14B) && isDefined(self._id_C14C)) {
    for(;;) {
      scripts\sp\utility::script_delay();

      if(isDefined(self._id_50D3)) {
        if(isDefined(self.script_delay))
          self._id_C3D6 = self.script_delay;

        if(isDefined(self.script_delay_max))
          self._id_C3D7 = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self._id_C3D8 = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      _id_AC8A();

      if(isDefined(self._id_10D0C) && self._id_10D0C)
        _id_ACA4();
      else
        _id_ACA3(undefined, self._id_12ACF);

      if(isDefined(self._id_C3D6))
        self.script_delay = self._id_C3D6;

      if(isDefined(self._id_C3D7))
        self.script_delay_max = self._id_C3D7;

      if(isDefined(self._id_C3D8))
        self.script_delay_min = self._id_C3D8;

      wait 0.05;
    }
  } else {
    _id_AC8A();

    if(isDefined(self._id_10D0C) && self._id_10D0C) {
      _id_ACA4();
      return;
    }

    _id_ACA3(undefined, self._id_12ACF);
  }
}

_id_AC89() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self._id_10D0C) && self._id_10D0C)
    _id_ACA4();
  else if(isDefined(self._id_C14B) || isDefined(self._id_12711))
    _id_ACA3(undefined, self._id_12ACF);

  for(;;) {
    if(!scripts\sp\utility::_id_65DB("light_on") && (isDefined(self._id_12711) || isDefined(self._id_C14B)))
      level scripts\engine\utility::waittill_any("bemani_573", self._id_12711, self._id_C14B);

    scripts\sp\utility::script_delay();

    if(isDefined(self._id_50D3)) {
      if(isDefined(self.script_delay))
        self._id_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self._id_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self._id_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self._id_12AE2 && !scripts\sp\utility::_id_65DB("light_on")) {
      childthread _id_AC8A(1, self._id_DC8B);

      if(self._id_10E46)
        wait(self._id_C4B5);
      else
        wait(randomfloat(self._id_C4B5));

      self notify("stop_flicker");
    }

    _id_ACA4();

    if(!isDefined(self._id_C14B) && !isDefined(self._id_12711)) {
      return;
    }
    if(!self._id_12AE3)
      level scripts\engine\utility::waittill_any("bemani_573", self._id_12712, self._id_C14C);
    else
      _id_AC8A(1);

    if(self._id_12AE1) {
      childthread _id_AC8A(1, self._id_DC8A);

      if(self._id_10E46)
        wait(self._id_C4B5);
      else
        wait(randomfloat(self._id_C4B5));

      self notify("stop_flicker");
    }

    _id_ACA3(undefined, self._id_12ACF);

    if(isDefined(self._id_C3D6))
      self.script_delay = self._id_C3D6;

    if(isDefined(self._id_C3D7))
      self.script_delay_max = self._id_C3D7;

    if(isDefined(self._id_C3D8))
      self.script_delay_min = self._id_C3D8;

    wait 0.05;

    if(!isDefined(self._id_C14B) && !isDefined(self._id_C14C))
      return;
  }
}

_id_AC8A(var_0, var_1) {
  self notify("stop_flicker");
  self endon("stop_flicker");

  if(isDefined(self._id_12712))
    level endon(self._id_12712);

  if(isDefined(self._id_C14C))
    level endon(self._id_C14C);

  if(!isDefined(var_0) && (isDefined(self._id_12711) || isDefined(self._id_C14B)))
    level scripts\engine\utility::waittill_any("bemani_573", self._id_12711, self._id_C14B);

  for(;;) {
    _id_ACA4(var_1);

    if(isDefined(self._id_8E57))
      wait(self._id_8E57);
    else
      wait(randomfloatrange(self._id_13585, self._id_13584));

    _id_ACA3(var_1);

    if(isDefined(self._id_ADA3)) {
      wait(self._id_ADA3);
      continue;
    }

    wait(randomfloatrange(self._id_13587, self._id_13586));
  }
}

init_light_pulse_iw7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  init_light_generic_iw7(var_0, var_1, var_4, var_5, var_9, var_10, undefined, 1);

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  _id_B27B(var_2, var_3, var_6, var_7, var_8, var_12, var_13, var_11);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread _id_10C9B();
}

_id_B27B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self._id_10D0C = _id_95A8([self._id_EECC, var_7, 1]);
  init_light_type(var_5);
  self._id_1098E = _id_95A8([self._id_EEBF, var_4, 1]);
  self._id_C4B5 = max(_id_95A8([self._id_ED75, var_6, 3]) / self._id_1098E, 3);

  if(isDefined(self._id_EF17) && !isDefined(self._id_EF16) || !isDefined(self._id_EF17) && isDefined(self._id_EF16))
    self._id_8E57 = max(_id_95A8([self._id_EF17, self._id_EF16]) / self._id_1098E, 0.05);
  else {
    self._id_13585 = max(_id_95A8([self._id_EF17, var_0, 0.05]) / self._id_1098E, 0.05);
    self._id_13584 = max(_id_95A8([self._id_EF16, var_1, 0.5]) / self._id_1098E, 0.1);

    if(self._id_13585 > self._id_13584) {
      var_8 = self._id_13584;
      self._id_13584 = self._id_13585;
      self._id_13585 = var_8;
    }
  }

  if(isDefined(self._id_EF19) && !isDefined(self._id_EF18) || !isDefined(self._id_EF19) && isDefined(self._id_EF18)) {
    self._id_ADA3 = max(_id_95A8([self._id_EF19, self._id_EF18]) / self._id_1098E, 0.05);
    var_9 = int(self._id_ADA3 * 20);
    self._id_10F88 = 2 / var_9;
    self._id_99EA = 2 * (self._id_99E6 - self._id_99E7) / var_9;
  } else {
    self._id_13587 = max(_id_95A8([self._id_EF19, var_2, 0.25]) / self._id_1098E, 0.05);
    self._id_13586 = max(_id_95A8([self._id_EF18, var_3, 0.75]) / self._id_1098E, 0.1);

    if(self._id_13587 > self._id_13586) {
      var_8 = self._id_13586;
      self._id_13586 = self._id_13587;
      self._id_13587 = var_8;
    }

    var_9 = int(self._id_13586 * 20);
    self._id_10F88 = 2 / var_9;
    self._id_99EA = 2 * (self._id_99E6 - self._id_99E7) / var_9;
  }
}

_id_10C9B() {
  if(self._id_12AE2 || self._id_12AE1)
    thread _id_AC9D();
  else
    thread _id_AC9C();
}

_id_AC9C() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self._id_10D0C) && self._id_10D0C)
    _id_ACA4();
  else if(isDefined(self._id_C14B) || isDefined(self._id_12711))
    _id_ACA3(undefined, self._id_12ACF);

  if(isDefined(self._id_C14B) && isDefined(self._id_C14C)) {
    for(;;) {
      _id_AC9E();

      if(isDefined(self._id_10D0C) && self._id_10D0C)
        _id_ACA4();
      else
        _id_ACA3(undefined, self._id_12ACF);

      wait 0.05;
    }
  } else {
    _id_AC9E();

    if(isDefined(self._id_10D0C) && self._id_10D0C) {
      _id_ACA4();
      return;
    }

    _id_ACA3(undefined, self._id_12ACF);
  }
}

_id_AC9D() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self._id_10D0C) && self._id_10D0C)
    _id_ACA4();
  else if(isDefined(self._id_C14B) || isDefined(self._id_12711))
    _id_ACA3(undefined, self._id_12ACF);

  for(;;) {
    if(!scripts\sp\utility::_id_65DB("light_on") && (isDefined(self._id_12711) || isDefined(self._id_C14B)))
      level scripts\engine\utility::waittill_any("bemani_573", self._id_12711, self._id_C14B);

    scripts\sp\utility::script_delay();

    if(isDefined(self._id_50D3)) {
      if(isDefined(self.script_delay))
        self._id_C3D6 = self.script_delay;

      if(isDefined(self.script_delay_max))
        self._id_C3D7 = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self._id_C3D8 = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self._id_12AE2 && !scripts\sp\utility::_id_65DB("light_on")) {
      childthread _id_AC9E(1);

      if(self._id_10E46)
        wait(self._id_C4B5);
      else
        wait(randomfloat(self._id_C4B5));

      self notify("stop_pulse");
    }

    _id_ACA4();

    if(!isDefined(self._id_C14B) && !isDefined(self._id_12711)) {
      return;
    }
    if(!self._id_12AE3)
      level scripts\engine\utility::waittill_any("bemani_573", self._id_12712, self._id_C14C);
    else
      _id_AC9E(1);

    if(self._id_12AE1) {
      childthread _id_AC9E(1);

      if(self._id_10E46)
        wait(self._id_C4B5);
      else
        wait(randomfloat(self._id_C4B5));

      self notify("stop_flicker");
    }

    _id_ACA3(undefined, self._id_12ACF);

    if(isDefined(self._id_C3D6))
      self.script_delay = self._id_C3D6;

    if(isDefined(self._id_C3D7))
      self.script_delay_max = self._id_C3D7;

    if(isDefined(self._id_C3D8))
      self.script_delay_min = self._id_C3D8;

    wait 0.05;

    if(!isDefined(self._id_C14B) && !isDefined(self._id_C14C))
      return;
  }
}

_id_AC9E(var_0) {
  self notify("stop_pulse");
  self endon("stop_pulse");

  if(isDefined(self._id_12712))
    level endon(self._id_12712);

  if(isDefined(self._id_C14C))
    level endon(self._id_C14C);

  if(!isDefined(var_0) && (isDefined(self._id_12711) || isDefined(self._id_C14B)))
    level scripts\engine\utility::waittill_any("bemani_573", self._id_12711, self._id_C14B);

  for(;;) {
    _id_ACA4();

    if(isDefined(self._id_8E57))
      wait(self._id_8E57);
    else
      wait(randomfloatrange(self._id_13585, self._id_13584));

    if(isDefined(self._id_ADA3)) {
      _id_AC9B(self._id_ADA3);
      continue;
    }

    _id_AC9B(randomfloatrange(self._id_13587, self._id_13586));
  }
}

init_light_trig(var_0) {
  self endon("death");
  var_1 = undefined;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var_1 = "trig_light_stop_" + scripts\sp\utility::string(var_0 getentitynumber());
    var_0._id_12712 = var_1;
  } else {
    var_1 = "trig_light_start_" + scripts\sp\utility::string(var_0 getentitynumber());
    var_0._id_12711 = var_1;
  }

  self waittill("trigger");
  level notify(var_1);
}

_id_ACA4(var_0) {
  scripts\sp\utility::_id_65E1("light_on");

  if(isDefined(var_0) && var_0 && self._id_99E6 > 0)
    _id_F466(randomfloatrange(self._id_99E6 * 0.25, self._id_99E6), self._id_438F);
  else
    _id_F466(self._id_99E6, self._id_438F);

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::exploder(self.script_prefab_exploder);

  foreach(var_2 in self._id_EF3C)
  var_2 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self._id_12BB6, ::hide);

  foreach(var_5 in self._id_AD83) {
    var_5 show();

    if(isDefined(var_5.effect))
      var_5.effect scripts\sp\utility::_id_E2B0();
  }
}

_id_ACA3(var_0, var_1) {
  scripts\sp\utility::_id_65DD("light_on");

  if(isDefined(var_1) && var_1)
    _id_F466(0, (0, 0, 0));
  else if(isDefined(var_0) && var_0 && self._id_99E7 > 0)
    _id_F466(randomfloatrange(self._id_99E7 * 0.25, self._id_99E7), self._id_4390);
  else
    _id_F466(self._id_99E7, self._id_4390);

  if(isDefined(self.script_prefab_exploder))
    scripts\sp\utility::_id_10FEC(self.script_prefab_exploder);

  foreach(var_3 in self._id_EF3C)
  var_3 setscriptablepartstate("onoff", "off");

  foreach(var_6 in self._id_AD83) {
    var_6 hide();

    if(isDefined(var_6.effect))
      var_6.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self._id_12BB6, ::show);
}

_id_AC9B(var_0) {
  scripts\sp\utility::_id_65DD("light_on");
  var_1 = int(var_0 / 0.1);

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    var_3 = max(0, self._id_99E6 - self._id_99EA * var_2);
    var_4 = vectorlerp(self._id_438F, self._id_4390, self._id_10F88 * var_2);
    _id_F466(var_3, var_4);
    wait 0.05;
  }

  for(var_2 = var_1; var_2 > 0; var_2--) {
    var_3 = max(0, self._id_99E6 - self._id_99EA * var_2);
    var_4 = vectorlerp(self._id_438F, self._id_4390, self._id_10F88 * var_2);
    _id_F466(var_3, var_4);
    wait 0.05;
  }
}

_id_ACD1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, var_1);
  scripts\engine\utility::array_thread(var_5, ::_id_1298C, var_2, var_3, var_4);
}

_id_1298C(var_0, var_1, var_2) {
  if(!isDefined(self._id_9586))
    self waittill("script_light_init_complete");

  if(isDefined(var_2) && var_2)
    self notify("stop_script_light_loop");

  var_3 = self._id_99E6;
  var_4 = self._id_438F;

  if(isDefined(var_0))
    var_3 = var_0;

  if(isDefined(var_1))
    var_4 = var_1;

  scripts\sp\utility::_id_65E1("light_on");
  _id_F466(var_3, var_4);

  foreach(var_6 in self._id_EF3C)
  var_6 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self._id_12BB6, ::hide);

  foreach(var_9 in self._id_AD83) {
    var_9 show();

    if(isDefined(var_9.effect))
      var_9.effect scripts\sp\utility::_id_E2B0();
  }
}

_id_ACD0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, var_1);
  scripts\engine\utility::array_thread(var_5, ::_id_12968, var_2, var_3, var_4);
}

_id_12968(var_0, var_1, var_2) {
  if(!isDefined(self._id_9586))
    self waittill("script_light_init_complete");

  if(isDefined(var_2) && var_2)
    self notify("stop_script_light_loop");

  var_3 = self._id_99E7;
  var_4 = self._id_4390;

  if(isDefined(var_0))
    var_3 = var_0;

  if(isDefined(var_1))
    var_4 = var_1;

  scripts\sp\utility::_id_65DD("light_on");
  _id_F466(var_3, var_4);

  foreach(var_6 in self._id_EF3C)
  var_6 setscriptablepartstate("onoff", "off");

  foreach(var_9 in self._id_AD83) {
    var_9 hide();

    if(isDefined(var_9.effect))
      var_9.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self._id_12BB6, ::show);
}

_id_F466(var_0, var_1) {
  if(isDefined(var_0))
    var_0 = max(0, var_0);

  if(isDefined(var_1))
    var_1 = (max(0, var_1[0]), max(0, var_1[1]), max(0, var_1[2]));

  if(isDefined(var_0)) {
    self setlightintensity(var_0);

    if(isDefined(self._id_AD22))
      scripts\engine\utility::array_call(self._id_AD22, ::setlightintensity, var_0);
  }

  if(isDefined(var_1)) {
    self _meth_82FC(var_1);

    if(isDefined(self._id_AD22))
      scripts\engine\utility::array_call(self._id_AD22, ::_meth_82FC, var_1);
  }
}

_id_9C37(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

_id_95A8(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      return var_2;
  }

  return undefined;
}

init_light_type(var_0) {
  self._id_ACA5 = _id_95A8([self.script_type, var_0, "generic"]);
  self._id_12ACF = issubstr(self._id_ACA5, "two_color");
  self._id_12AE2 = issubstr(self._id_ACA5, "on");
  self._id_12AE1 = issubstr(self._id_ACA5, "off");
  self._id_12AE3 = issubstr(self._id_ACA5, "running");
  self._id_10E46 = issubstr(self._id_ACA5, "timed");
  self._id_50D3 = issubstr(self._id_ACA5, "delaystart");
  self._id_DC8B = issubstr(self._id_ACA5, "on_random_intensity");
  self._id_DC8A = issubstr(self._id_ACA5, "off_random_intensity");
}

_id_7765() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self _meth_8134();
  var_1 = 0.05;
  var_2 = var_0;
  var_3 = 0.3;
  var_4 = 0.6;
  var_5 = (var_0 - var_1) / (var_3 / 0.05);
  var_6 = (var_0 - var_1) / (var_4 / 0.05);

  for(;;) {
    var_7 = 0;

    while(var_7 < var_4) {
      var_2 = var_2 - var_6;
      var_2 = clamp(var_2, 0, 100);
      self setlightintensity(var_2);
      var_7 = var_7 + 0.05;
      wait 0.05;
    }

    wait 1;
    var_7 = 0;

    while(var_7 < var_3) {
      var_2 = var_2 + var_5;
      var_2 = clamp(var_2, 0, 100);
      self setlightintensity(var_2);
      var_7 = var_7 + 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

_id_774A() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self _meth_8134();
  var_1 = 0.05;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;
  var_6 = [];

  if(isDefined(self.script_noteworthy)) {
    var_7 = getEntArray(self.script_noteworthy, "targetname");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(_id_9C37(var_7[var_8])) {
        var_5 = 1;
        var_6[var_6.size] = var_7[var_8];
      }

      if(var_7[var_8].classname == "script_model") {
        var_3 = var_7[var_8];
        var_4 = getEnt(var_3.target, "targetname");
        var_2 = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(var_1);

    if(var_2) {
      var_3 hide();
      var_4 show();
    }

    wait 0.8;
    self setlightintensity(var_0);

    if(var_2) {
      var_3 show();
      var_4 hide();
    }

    wait 0.1;
    self setlightintensity(var_1);

    if(var_2) {
      var_3 hide();
      var_4 show();
    }

    wait 0.12;
    self setlightintensity(var_0);

    if(var_2) {
      var_3 show();
      var_4 hide();
    }

    wait 0.1;
  }
}

_id_776F() {
  for(;;)
    level scripts\engine\utility::waitframe();
}

_id_3299() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self _meth_8134();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 0.6);
    var_3 = var_3 * 20;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

_id_11155(var_0, var_1, var_2, var_3) {
  var_4 = 360 / var_2;
  var_5 = 0;

  for(;;) {
    var_6 = sin(var_5 * var_4) * 0.5 + 0.5;
    self setlightintensity(var_0 + (var_1 - var_0) * var_6);
    wait 0.05;
    var_5 = var_5 + 0.05;

    if(var_5 > var_2)
      var_5 = var_5 - var_2;

    if(isDefined(var_3)) {
      if(scripts\engine\utility::flag(var_3))
        return;
    }
  }
}

_id_3C57(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  thread _id_3C58(var_0, var_1, var_2, var_3);
}

_id_3C58(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_8131();
  var_5 = 1 / (var_1 * 2 - (var_2 + var_3));
  var_6 = 0;

  if(var_6 < var_2) {
    for(var_7 = var_5 / var_2; var_6 < var_2; var_6 = var_6 + 0.05) {
      var_8 = var_7 * var_6 * var_6;
      self _meth_82FC(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  while(var_6 < var_1 - var_3) {
    var_8 = var_5 * (2 * var_6 - var_2);
    self _meth_82FC(vectorlerp(var_4, var_0, var_8));
    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  var_6 = var_1 - var_6;

  if(var_6 > 0) {
    for(var_7 = var_5 / var_3; var_6 > 0; var_6 = var_6 - 0.05) {
      var_8 = 1 - var_7 * var_6 * var_6;
      self _meth_82FC(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  self _meth_82FC(var_0);
}

_id_6F19(var_0, var_1) {
  var_2 = self _meth_8134();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  for(;;) {
    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2)
        var_4 = randomfloatrange(0, 0.3);
      else
        var_4 = var_2;

      self setlightintensity(var_4);
    }

    self setlightintensity(var_2);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_11203(var_0) {
  var_1 = 1;

  if(isDefined(var_0._id_ED75))
    var_1 = var_0._id_ED75;

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 _id_F5B8(var_1);
  }
}

_id_F5B8(var_0) {
  var_1 = getdvarint("sm_sunenable", 1);
  var_2 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_3 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_4 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isDefined(self._id_EED5))
    var_1 = self._id_EED5;

  if(isDefined(self._id_EED7))
    var_2 = self._id_EED7;

  if(isDefined(self._id_EED6))
    var_3 = self._id_EED6;

  var_3 = min(max(0.016, var_3), 32);

  if(isDefined(self._id_EE8E))
    var_4 = self._id_EE8E;

  var_5 = getdvarint("sm_sunenable", 1);
  var_6 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_7 = getdvarint("sm_qualityspotshadow", 1.0);
  setsaveddvar("sm_sunenable", var_1);
  setsaveddvar("sm_sunshadowscale", var_2);
  setsaveddvar("sm_qualityspotshadow", var_4);
  _id_ABA0(var_3, var_0);
}

_id_ABA0(var_0, var_1) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var_2 = getdvarfloat("sm_sunSampleSizeNear", 0.25);

  if(var_0 == var_2) {
    return;
  }
  var_3 = var_0 - var_2;
  var_4 = var_1 / 0.05;

  if(var_4 > 0) {
    var_5 = var_3 / var_4;
    var_6 = var_2;

    for(var_7 = 0; var_7 < var_4; var_7++) {
      var_6 = var_6 + var_5;
      setsaveddvar("sm_sunSampleSizeNear", var_6);
      wait 0.05;
    }
  }

  setsaveddvar("sm_sunSampleSizeNear", var_0);
}

_id_AB83(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self _meth_8134();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread _id_8924(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self._id_AD22))
    var_6 = scripts\engine\utility::array_combine(var_6, self._id_AD22);

  foreach(var_8 in var_6) {
    var_8 thread _id_8924(var_0);
    var_8 setlightintensity(var_0);
  }
}

_id_8924(var_0) {
  if(isDefined(self.script_threshold)) {
    var_1 = var_0 > self.script_threshold;

    foreach(var_3 in self._id_AD83) {
      if(var_1 && !var_3._id_13438) {
        var_3._id_13438 = var_1;
        var_3 show();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\sp\utility::_id_E2B0();

        continue;
      }

      if(!var_1 && var_3._id_13438) {
        var_3._id_13438 = var_1;
        var_3 hide();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }

    foreach(var_3 in self._id_12BB6) {
      if(!var_1 && !var_3._id_13438) {
        var_3._id_13438 = 1;
        var_3 show();
        continue;
      }

      if(var_1 && var_3._id_13438) {
        var_3._id_13438 = 0;
        var_3 hide();
      }
    }
  }
}