/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\lights.gsc
***********************************************/

function init() {
  var0 = getEntArray("script_light", "targetname");
  var1 = getEntArray("script_light_toggle", "targetname");
  var2 = getEntArray("script_light_destructable", "targetname");
  var3 = getEntArray("script_light_flicker", "targetname");
  var4 = getEntArray("script_light_pulse", "targetname");
  var5 = getEntArray("generic_double_strobe", "targetname");
  var6 = getEntArray("burning_trash_fire", "targetname");
  var7 = getEntArray("generic_pulsing", "targetname");
  scripts\engine\utility::array_thread(var0, &init_light_generic_iw7);
  scripts\engine\utility::array_thread(var1, &init_light_generic_iw7);
  scripts\engine\utility::array_thread(var2, &init_light_destructable);
  scripts\engine\utility::array_thread(var3, &init_light_flicker);
  scripts\engine\utility::array_thread(var4, &init_light_pulse_iw7);
  scripts\engine\utility::array_thread(var5, &generic_double_strobe);
  scripts\engine\utility::array_thread(var6, &burning_trash_fire);
  scripts\engine\utility::array_thread(var7, &generic_pulsing);
  var8 = getEntArray("light_spot", "classname");
  var8 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var8);

  foreach(var10 in var8) {
    if(!isDefined(var10.script_type)) {
      continue;
    }

    switch (var10.script_type) {
      case "pulse":
        thread init_pulse();
        break;
      case "strobe":
        thread init_strobe();
        break;
    }
  }
}

function init_pulse() {
  init_light();

  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }

  thread light_think();
}

function init_strobe() {
  init_light();

  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }

  if(!isDefined(self.script_delay2) && !isDefined(self.script_delay2_max) && !isDefined(self.script_delay2_min)) {
    self.script_delay2 = 0.1;
  }

  thread light_think();
}

function light_think() {
  self endon("death");
  var0 = self.script_intensity < self.script_intensity2;
  var1 = var0;

  if(isDefined(self.script_flag) && !scripts\engine\utility::flag(self.script_flag)) {
    if(isDefined(self.script_start_intensity)) {
      set_lights_internal(self.script_start_intensity);
    } else if(isDefined(self.script_start_state)) {
      if(self.script_start_state == "on") {
        var1 = !var0;
      }
    }
  }

  var2 = 0;

  for(;;) {
    if(isDefined(self.script_flag)) {
      if(!scripts\engine\utility::flag(self.script_flag)) {
        if(!var2) {
          if(self.script_start_state == "off") {
            set_lights_internal(0);
          } else {
            set_light_values_by_frac(var1);
          }
        } else {
          set_light_values_by_frac(var0);
        }

        scripts\engine\utility::flag_wait(self.script_flag);
      }
    }

    if(!var2) {
      var2 = 1;
      start_delay();
    }

    switch (self.script_type) {
      case "pulse":
        pulse();
        break;
      case "strobe":
        strobe();
        break;
    }
  }
}

function pulse() {
  self endon("death");
  var0 = get_script_delay();

  if(has_script_delay2()) {
    var0 = get_script_delay2();
  } else {
    var0 = get_script_delay();
  }

  light_lerp(var0);

  if(has_script_wait()) {
    scripts\engine\utility::script_wait();
  }

  if(has_script_delay2()) {
    var0 = get_script_delay2();
  } else {
    var0 = get_script_delay();
  }

  light_lerp(var0, 1);
}

function strobe() {
  self endon("death");
  set_light_values_by_frac(1);
  var0 = get_script_delay();
  wait var0;
  var1 = get_script_loop();

  for(var2 = 0; var2 < var1; var2++) {
    set_light_values_by_frac(0);

    if(has_script_delay2()) {
      var0 = get_script_delay2();
    } else {
      var0 = get_script_delay();
    }

    wait var0;
    set_light_values_by_frac(1);

    if(var2 == var1 - 1) {
      break;
    }

    if(has_script_delay2()) {
      var0 = get_script_delay2();
    } else {
      var0 = get_script_delay();
    }

    wait var0;
  }

  if(has_script_wait()) {
    scripts\engine\utility::script_wait();
    return;
  }
}

function light_lerp(var0, var1) {
  self endon("death");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = int(var0 * 20);
  var3 = (self.script_intensity - self.script_intensity2) / var2;
  var4 = undefined;
  var5 = undefined;

  if(has_script_color()) {
    var5 = (self.script_color - self.script_color2) / var2;
  }

  for(var6 = 1; var6 < var2; var6++) {
    if(var1) {
      var7 = 1 - var6 / var2;
    } else {
      var7 = var6 / var2;
    }

    set_light_values_by_frac(var7);
    waitframe();
  }

  if(var1) {
    var7 = 0;
  } else {
    var7 = 1;
  }

  set_light_values_by_frac(var7);
  waitframe();
}

function set_light_values_by_frac(var0) {
  var1 = scripts\engine\math::lerp(self.script_intensity2, self.script_intensity, var0);
  var2 = undefined;

  if(has_script_color()) {
    var2 = vectorlerp(self.script_color, self.script_color2, var0);
  }

  set_lights_internal(var1, var2);
}

function set_lights_internal(var0, var1) {
  if(isDefined(var0)) {
    self setlightintensity(var0);

    if(isDefined(self.linked_lights)) {
      scripts\engine\utility::array_call(self.linked_lights, &setlightintensity, var0);
    }
  }

  if(isDefined(var1)) {
    self setlightcolor(var1);

    if(isDefined(self.linked_lights)) {
      scripts\engine\utility::array_call(self.linked_lights, &setlightcolor, var1);
    }
  }

  if(var0 > 0.2) {
    set_light_parts_on();
    return;
  }

  if(var0 < 0.2) {
    set_light_parts_off();
    return;
  }
}

function set_light_parts_on() {
  scripts\engine\utility::ent_flag_set("light_on");

  if(isDefined(self.script_prefab_exploder)) {
    scripts\engine\utility::exploder(self.script_prefab_exploder);
  }

  if(isDefined(self.scriptables)) {
    foreach(var1 in self.scriptables) {
      var1 setscriptablepartstate("onoff", "on");
    }
  }

  scripts\engine\utility::array_call(self.models_unlit, &hide);

  foreach(var4 in self.models_lit) {
    var4 show();

    if(isDefined(var4.script_fxid)) {
      if(isDefined(var4.fxobj)) {
        var4.fxobj delete();
      }

      var4.fxobj = spawnfx(scripts\engine\utility::getfx(var4.script_fxid), var4.fx_origin, var4.fx_forward, var4.fx_up);
      triggerfx(var4.fxobj);
      var4.fxobj willneverchange();
    }
  }
}

function set_light_parts_off() {
  scripts\engine\utility::ent_flag_clear("light_on");

  if(isDefined(self.script_prefab_exploder)) {
    scripts\engine\utility::stop_exploder(self.script_prefab_exploder);
  }

  if(isDefined(self.scriptables)) {
    foreach(var1 in self.scriptables) {
      var1 setscriptablepartstate("onoff", "off");
    }
  }

  foreach(var4 in self.models_lit) {
    var4 hide();

    if(isDefined(var4.fxobj)) {
      var4.fxobj delete();
    }
  }

  scripts\engine\utility::array_call(self.models_unlit, &show);
}

function init_light() {
  self.script_intensity = get_defined_value([self.script_intensity, self getlightintensity()]);
  self.script_color = get_defined_value([self.script_color, self getlightcolor()]);
  self.script_intensity2 = get_defined_value([self.script_intensity2, 0]);
  self.script_color2 = get_defined_value([self.script_color2]);
  self.script_notify_start = get_defined_value([self.script_notify_start]);
  self.script_notify_stop = get_defined_value([self.script_notify_stop]);
  self.script_startrunning = get_defined_value([self.script_startrunning]);

  if(!isDefined(self.script_delay) && !isDefined(self.script_delay_max) && !isDefined(self.script_delay_min)) {
    self.script_delay = 0.8;
  }

  if(!scripts\engine\utility::ent_flag_exist("light_on")) {
    scripts\engine\utility::ent_flag_init("light_on");
  }

  self.models_lit = [];
  self.models_unlit = [];
  self.linked_lights = [];
  self.triggers = [];
  var0 = scripts\engine\utility::get_linked_ents();

  foreach(var2 in var0) {
    if(is_light_entity(var2)) {
      self.linked_lights[self.linked_lights.size] = var2;
      continue;
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "on") {
      self.models_lit[self.models_lit.size] = var2;
      continue;
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "off") {
      self.models_unlit[self.models_unlit.size] = var2;
      continue;
    }

    if(var2.code_classname == "trigger_multiple" || var2.code_classname == "trigger_once") {
      self.triggers[self.triggers.size] = var2;
    }
  }

  if(getdvarint("LLQQOPKTKM") == 1) {
    set_light_parts_off();
    set_lights_values(0);
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target)) {
    self.scriptables = getscriptablearray(self.target, "targetname");
  }

  scripts\engine\utility::array_thread(self.triggers, &trigger_light, self);

  foreach(var8, var5 in self.models_lit) {
    if(isDefined(var5.script_fxid)) {
      if(isDefined(var5.script_offset)) {
        var6 = var5.origin + var5.script_offset;
      } else {
        var6 = var8.origin;
      }

      if(isDefined(var8.script_angles)) {
        var7 = var8.angles + var8.script_angles;
      } else {
        var7 = var6.angles;
      }

      var6.fx_origin = var7;
      var6.fx_forward = anglesToForward(var7);
      var6.fx_up = anglestoup(var7);
      var6.fxobj = spawnfx(scripts\engine\utility::getfx(var6.script_fxid), var6.fx_origin, var6.fx_forward, var6.fx_up);
    }
  }

  var6 = undefined;
  self notify("init_light_complete");
}

function trigger_light(var0) {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var1 = "trigger_light_stop";
    var0.trig_notify_stop = var1;
  } else {
    var1 = "trigger_light_start";
    var1.trig_notify_start = var1;
  }

  self waittill("trigger");

  if(isDefined(var1)) {
    var1 notify(var1);
    return;
  }
}

function get_defined_value(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      return var2;
    }
  }

  return undefined;
}

function start_delay() {
  if(isDefined(self.script_startdelay_min) && isDefined(self.script_startdelay_max)) {
    wait randomfloatrange(self.script_startdelay_min, self.script_startdelay_max);
    return;
  }

  if(isDefined(self.script_startdelay)) {
    wait self.script_startdelay;
    return;
  }
}

function script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max)) {
    wait randomfloatrange(self.script_wait2_min, self.script_delay2_max);
    return;
  }

  if(isDefined(self.script_delay2)) {
    wait self.script_delay2;
    return;
  }
}

function get_script_delay() {
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    return randomfloatrange(self.script_delay_min, self.script_delay_max);
  } else if(isDefined(self.script_delay)) {
    return self.script_delay;
  }

  return 0;
}

function get_script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max)) {
    return randomfloatrange(self.script_delay2_min, self.script_delay2_max);
  } else if(isDefined(self.script_delay2)) {
    return self.script_delay2;
  }

  return 0;
}

function get_script_loop() {
  if(isDefined(self.script_count_min) && isDefined(self.script_count_max)) {
    return randomintrange(self.script_count_min, self.script_count_max);
  } else if(isDefined(self.script_count)) {
    return self.script_count;
  }

  return 1;
}

function has_script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max)) {
    return true;
  } else if(isDefined(self.script_delay2)) {
    return true;
  }

  return false;
}

function has_script_wait() {
  if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    return true;
  } else if(isDefined(self.script_wait)) {
    return true;
  }

  return false;
}

function has_script_color() {
  if(isDefined(self.script_color) && isDefined(self.script_color2)) {
    return true;
  }

  return false;
}

function light_debug_thread() {
  var0 = getEntArray("light_spot", "classname");
  var0 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var0);

  for(;;) {
    var1 = 0;

    foreach(var3 in var0) {
      if(isDefined(var3)) {
        light_debug_draw(var3);
        continue;
      }

      var1 = 1;
    }

    if(var1) {
      var0 = scripts\engine\utility::array_removeundefined(var0);
    }

    waitframe();
  }
}

function light_debug_draw() {
  if(distancesquared(self.origin, level.player.origin) < 2000) {
    return;
  }

  light_debug_print3d("Intensity: " + self getlightintensity());
}

function light_debug_print3d(var0) {
  if(!isDefined(var0)) {
    return;
  }
}

function init_light_generic_iw7(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(self.script_type)) {
    return;
  }

  wait 0.05;
  self.intensity_01 = get_defined_value([self.script_intensity_01, var0, self getlightintensity()]);
  self.color_01 = get_defined_value([self.script_color_01, var1, self getlightcolor()]);
  self.intensity_02 = get_defined_value([self.script_intensity_02, var2, 0]);
  self.color_02 = get_defined_value([self.script_color_02, var3, (0, 0, 0)]);
  self.notify_start = get_defined_value([self.script_light_startnotify, var4]);
  self.notify_stop = get_defined_value([self.script_light_stopnotify, var5]);
  self.start_running = get_defined_value([self.script_startrunning, var6]);
  self.light_type = get_defined_value([self.script_type, "generic"]);
  self.delay_start = issubstr(self.light_type, "delaystart");

  if(!scripts\engine\utility::ent_flag_exist("light_on")) {
    scripts\engine\utility::ent_flag_init("light_on");
  }

  self.lit_models = [];
  self.unlit_models = [];
  self.linked_lights = [];
  self.triggers = [];
  var8 = scripts\engine\utility::get_linked_ents();

  foreach(var10 in var8) {
    if(is_light_entity(var10)) {
      self.linked_lights[self.linked_lights.size] = var10;
      continue;
    }

    if(isDefined(var10.script_noteworthy) && var10.script_noteworthy == "on") {
      self.lit_models[self.lit_models.size] = var10;
      continue;
    }

    if(isDefined(var10.script_noteworthy) && var10.script_noteworthy == "off") {
      self.unlit_models[self.unlit_models.size] = var10;
      continue;
    }

    if(issubstr(var10.classname, "trigger")) {
      self.triggers[self.triggers.size] = var10;
    }
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    set_lights_values(0, (0, 0, 0));
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target)) {
    self.scriptables = getscriptablearray(self.target, "targetname");
  }

  if(self.lit_models.size != 0 || self.unlit_models.size != 0) {}

  scripts\engine\utility::array_thread(self.triggers, &init_light_trig, self);

  foreach(var13 in self.lit_models) {
    if(isDefined(var13.script_fxid)) {
      var13.effect = scripts\engine\utility::createoneshoteffect(var13.script_fxid);
      var14 = (0, 0, 0);
      var15 = (0, 0, 0);

      if(isDefined(var13.script_parameters)) {
        var16 = strtok(var13.script_parameters, ", ");
        var14 = (float(var16[0]), float(var16[1]), float(var16[2]));

        if(var16.size >= 6) {
          var15 = (float(var16[3]), float(var16[4]), float(var16[5]));
        }
      }

      var13.effect scripts\common\createfx::set_origin_and_angles(var13.origin + var14, var13.angles + var15);
    }
  }

  self.init_complete = 1;
  self notify("script_light_init_complete");

  if(isDefined(var7) && var7) {
    return;
  }

  if(isDefined(self.notify_start) || isDefined(self.notify_stop) || self.triggers.size > 0) {
    thread light_toggle_loop();
    return;
  }
}

function init_light_destructable() {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7();
}

function light_toggle_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off();
  }

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on")) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
      scripts\engine\utility::script_delay();

      if(isDefined(self.delay_start)) {
        if(isDefined(self.script_delay)) {
          self.old_script_delay = self.script_delay;
        }

        if(isDefined(self.script_delay_max)) {
          self.old_script_delay_max = self.script_delay_max;
        }

        if(isDefined(self.script_delay_min)) {
          self.old_script_delay_min = self.script_delay_min;
        }

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      light_turn_on();
    }

    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay)) {
        self.old_script_delay = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.old_script_delay_max = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.old_script_delay_min = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    light_turn_off();

    if(isDefined(self.old_script_delay)) {
      self.script_delay = self.old_script_delay;
    }

    if(isDefined(self.old_script_delay_max)) {
      self.script_delay_max = self.old_script_delay_max;
    }

    if(isDefined(self.old_script_delay_min)) {
      self.script_delay_min = self.old_script_delay_min;
    }

    wait 0.05;
  }
}

function init_light_flicker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7(var0, var1, var4, var5, var9, var10, var11, 1);

  if(getDvar("LLQQOPKTKM") == "1") {
    return;
  }

  make_light_flicker(var2, var3, var6, var7, var8, var12, var13);

  if(isDefined(var14) && var14) {
    return;
  }

  thread start_light_flicker();
}

function make_light_flicker(var0, var1, var2, var3, var4, var5, var6) {
  init_light_type(var5);
  self.speed_scale = get_defined_value([self.script_speed_scale, var4, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, var6, 3]) / self.speed_scale, 0.25);

  if(isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max)) {
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  } else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, var0, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, var1, 0.1]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      var7 = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = var7;
    }
  }

  if(isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max)) {
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
    return;
  }

  self.wait_02_min = max(get_defined_value([self.script_wait_02_min, var2, 0.05]) / self.speed_scale, 0.05);
  self.wait_02_max = max(get_defined_value([self.script_wait_02_max, var3, 0.75]) / self.speed_scale, 0.1);

  if(self.wait_02_min > self.wait_02_max) {
    var7 = self.wait_02_max;
    self.wait_02_max = self.wait_02_min;
    self.wait_02_min = var7;
    return;
  }
}

function start_light_flicker() {
  if(self.type_on || self.type_off) {
    thread light_flicker_on_off_loop();
    return;
  }

  thread light_flicker_loop();
}

function light_flicker_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    for(;;) {
      scripts\engine\utility::script_delay();

      if(isDefined(self.delay_start)) {
        if(isDefined(self.script_delay)) {
          self.old_script_delay = self.script_delay;
        }

        if(isDefined(self.script_delay_max)) {
          self.old_script_delay_max = self.script_delay_max;
        }

        if(isDefined(self.script_delay_min)) {
          self.old_script_delay_min = self.script_delay_min;
        }

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      light_flicker_proc();

      if(isDefined(self.start_running) && self.start_running) {
        light_turn_on();
      } else {
        light_turn_off(undefined, self.two_color);
      }

      if(isDefined(self.old_script_delay)) {
        self.script_delay = self.old_script_delay;
      }

      if(isDefined(self.old_script_delay_max)) {
        self.script_delay_max = self.old_script_delay_max;
      }

      if(isDefined(self.old_script_delay_min)) {
        self.script_delay_min = self.old_script_delay_min;
      }

      waitframe();
    }

    return;
  }

  light_flicker_proc();

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
    return;
  }

  light_turn_off(undefined, self.two_color);
}

function light_flicker_on_off_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
    }

    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay)) {
        self.old_script_delay = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.old_script_delay_max = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.old_script_delay_min = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.type_on && !scripts\engine\utility::ent_flag("light_on")) {
      GscBinSkip4(0x35, 1, self.random_intensity_on);
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }

    if(!self.type_run) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    } else {
      light_flicker_proc(1);
    }

    if(self.type_off) {
      GscBinSkip4(0x35, 1, self.random_intensity_off);
    }

    light_turn_off(undefined, self.two_color);

    if(isDefined(self.old_script_delay)) {
      self.script_delay = self.old_script_delay;
    }

    if(isDefined(self.old_script_delay_max)) {
      self.script_delay_max = self.old_script_delay_max;
    }

    if(isDefined(self.old_script_delay_min)) {
      self.script_delay_min = self.old_script_delay_min;
    }

    wait 0.05;

    if(!isDefined(self.notify_start) && !isDefined(self.notify_stop)) {
      return;
    }
  }
}

function light_flicker_proc(var0, var1) {
  self notify("stop_flicker");
  self endon("stop_flicker");

  if(isDefined(self.trig_notify_stop)) {
    level endon(self.trig_notify_stop);
  }

  if(isDefined(self.notify_stop)) {
    level endon(self.notify_stop);
  }

  if(!isDefined(var0) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
  }

  for(;;) {
    light_turn_on(var1);

    if(isDefined(self.hi_wait)) {
      wait self.hi_wait;
    } else {
      wait randomfloatrange(self.wait_01_min, self.wait_01_max);
    }

    light_turn_off(var1);

    if(isDefined(self.lo_wait)) {
      wait self.lo_wait;
      continue;
    }

    wait randomfloatrange(self.wait_02_min, self.wait_02_max);
  }
}

function init_light_pulse_iw7(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7(var0, var1, var4, var5, var9, var10, undefined, 1);

  if(getDvar("LLQQOPKTKM") == "1") {
    return;
  }

  make_light_pulse(var2, var3, var6, var7, var8, var12, var13, var11);

  if(isDefined(var14) && var14) {
    return;
  }

  thread start_light_pulse();
}

function make_light_pulse(var0, var1, var2, var3, var4, var5, var6, var7) {
  self.start_running = get_defined_value([self.script_startrunning, var7, 1]);
  init_light_type(var5);
  self.speed_scale = get_defined_value([self.script_speed_scale, var4, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, var6, 3]) / self.speed_scale, 3);

  if(isDefined(self.script_wait_01_min) && !isDefined(self.script_wait_01_max) || !isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max)) {
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  } else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, var0, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, var1, 0.5]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      var8 = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = var8;
    }
  }

  if(isDefined(self.script_wait_02_min) && !isDefined(self.script_wait_02_max) || !isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max)) {
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
    var9 = int(self.lo_wait * 20);
    self.step_inc = 2 / var9;
    self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / var9;
    return;
  }

  self.wait_02_min = max(get_defined_value([self.script_wait_02_min, var3, 0.25]) / self.speed_scale, 0.05);
  self.wait_02_max = max(get_defined_value([self.script_wait_02_max, var4, 0.75]) / self.speed_scale, 0.1);

  if(self.wait_02_min > self.wait_02_max) {
    var8 = self.wait_02_max;
    self.wait_02_max = self.wait_02_min;
    self.wait_02_min = var8;
  }

  var9 = int(self.wait_02_max * 20);
  self.step_inc = 2 / var9;
  self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / var9;
}

function start_light_pulse() {
  if(self.type_on || self.type_off) {
    thread light_pulse_on_off_loop();
    return;
  }

  thread light_pulse_loop();
}

function light_pulse_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    for(;;) {
      light_pulse_proc_iw7();

      if(isDefined(self.start_running) && self.start_running) {
        light_turn_on();
      } else {
        light_turn_off(undefined, self.two_color);
      }

      waitframe();
    }

    return;
  }

  light_pulse_proc_iw7();

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
    return;
  }

  light_turn_off(undefined, self.two_color);
}

function light_pulse_on_off_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
    }

    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay)) {
        self.old_script_delay = self.script_delay;
      }

      if(isDefined(self.script_delay_max)) {
        self.old_script_delay_max = self.script_delay_max;
      }

      if(isDefined(self.script_delay_min)) {
        self.old_script_delay_min = self.script_delay_min;
      }

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.type_on && !scripts\engine\utility::ent_flag("light_on")) {
      GscBinSkip4(0x35, 1);
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }

    if(!self.type_run) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    } else {
      light_pulse_proc_iw7(1);
    }

    if(self.type_off) {
      GscBinSkip4(0x35, 1);
    }

    light_turn_off(undefined, self.two_color);

    if(isDefined(self.old_script_delay)) {
      self.script_delay = self.old_script_delay;
    }

    if(isDefined(self.old_script_delay_max)) {
      self.script_delay_max = self.old_script_delay_max;
    }

    if(isDefined(self.old_script_delay_min)) {
      self.script_delay_min = self.old_script_delay_min;
    }

    waitframe();

    if(!isDefined(self.notify_start) && !isDefined(self.notify_stop)) {
      return;
    }
  }
}

function light_pulse_proc_iw7(var0) {
  self notify("stop_pulse");
  self endon("stop_pulse");

  if(isDefined(self.trig_notify_stop)) {
    level endon(self.trig_notify_stop);
  }

  if(isDefined(self.notify_stop)) {
    level endon(self.notify_stop);
  }

  if(!isDefined(var0) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
  }

  for(;;) {
    light_turn_on();

    if(isDefined(self.hi_wait)) {
      wait self.hi_wait;
    } else {
      wait randomfloatrange(self.wait_01_min, self.wait_01_max);
    }

    if(isDefined(self.lo_wait)) {
      light_pulse(self.lo_wait);
      continue;
    }

    light_pulse(randomfloatrange(self.wait_02_min, self.wait_02_max));
  }
}

function init_light_trig(var0) {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var1 = "trigger_light_stop";
    var0.trig_notify_stop = var1;
  } else {
    var1 = "trigger_light_start";
    var1.trig_notify_start = var1;
  }

  self waittill("trigger");

  if(isDefined(var1)) {
    var1 notify(var1);
    return;
  }
}

function light_turn_on(var0) {
  scripts\engine\utility::ent_flag_set("light_on");

  if(isDefined(var0) && var0 && self.intensity_01 > 0) {
    set_lights_values(randomfloatrange(self.intensity_01 * 0.25, self.intensity_01), self.color_01);
  } else {
    set_lights_values(self.intensity_01, self.color_01);
  }

  if(isDefined(self.script_prefab_exploder)) {
    scripts\engine\utility::exploder(self.script_prefab_exploder);
  }

  foreach(var2 in self.scriptables) {
    var2 setscriptablepartstate("onoff", "on");
  }

  scripts\engine\utility::array_call(self.unlit_models, &hide);

  foreach(var5 in self.lit_models) {
    var5 show();

    if(isDefined(var5.effect)) {
      var5.effect scripts\engine\sp\utility::restarteffect();
    }
  }
}

function light_turn_off(var0, var1) {
  scripts\engine\utility::ent_flag_clear("light_on");

  if(isDefined(var1) && var1) {
    set_lights_values(0, (0, 0, 0));
  } else if(isDefined(var0) && var0 && self.intensity_02 > 0) {
    set_lights_values(randomfloatrange(self.intensity_02 * 0.25, self.intensity_02), self.color_02);
  } else {
    set_lights_values(self.intensity_02, self.color_02);
  }

  if(isDefined(self.script_prefab_exploder)) {
    scripts\engine\utility::stop_exploder(self.script_prefab_exploder);
  }

  foreach(var3 in self.scriptables) {
    var3 setscriptablepartstate("onoff", "off");
  }

  foreach(var6 in self.lit_models) {
    var6 hide();

    if(isDefined(var6.effect)) {
      var6.effect scripts\engine\utility::pauseeffect();
    }
  }

  scripts\engine\utility::array_call(self.unlit_models, &show);
}

function light_pulse(var0) {
  scripts\engine\utility::ent_flag_clear("light_on");
  var1 = int(var0 / 0.1);

  for(var2 = 1; var2 <= var1; var2++) {
    var3 = max(0, self.intensity_01 - self.intensity_inc * var2);
    var4 = vectorlerp(self.color_01, self.color_02, self.step_inc * var2);
    set_lights_values(var3, var4);
    wait 0.05;
  }

  for(var2 = var1; var2 > 0; var2--) {
    var3 = max(0, self.intensity_01 - self.intensity_inc * var2);
    var4 = vectorlerp(self.color_01, self.color_02, self.step_inc * var2);
    set_lights_values(var3, var4);
    wait 0.05;
  }
}

function lights_turn_on(var0, var1, var2, var3, var4) {
  var5 = getEntArray(var0, var1);
  scripts\engine\utility::array_thread(var5, &turn_on_proc, var2, var3, var4);
}

function turn_on_proc(var0, var1, var2) {
  if(!isDefined(self.init_complete)) {
    self waittill("script_light_init_complete");
  }

  if(isDefined(var2) && var2) {
    self notify("stop_script_light_loop");
  }

  var3 = self.intensity_01;
  var4 = self.color_01;

  if(isDefined(var0)) {
    var3 = var0;
  }

  if(isDefined(var1)) {
    var4 = var1;
  }

  scripts\engine\utility::ent_flag_set("light_on");
  set_lights_values(var3, var4);

  foreach(var6 in self.scriptables) {
    var6 setscriptablepartstate("onoff", "on");
  }

  scripts\engine\utility::array_call(self.unlit_models, &hide);

  foreach(var9 in self.lit_models) {
    var9 show();

    if(isDefined(var9.effect)) {
      var9.effect scripts\engine\sp\utility::restarteffect();
    }
  }
}

function lights_turn_off(var0, var1, var2, var3, var4) {
  var5 = getEntArray(var0, var1);
  scripts\engine\utility::array_thread(var5, &turn_off_proc, var2, var3, var4);
}

function turn_off_proc(var0, var1, var2) {
  if(!isDefined(self.init_complete)) {
    self waittill("script_light_init_complete");
  }

  if(isDefined(var2) && var2) {
    self notify("stop_script_light_loop");
  }

  var3 = self.intensity_02;
  var4 = self.color_02;

  if(isDefined(var0)) {
    var3 = var0;
  }

  if(isDefined(var1)) {
    var4 = var1;
  }

  scripts\engine\utility::ent_flag_clear("light_on");
  set_lights_values(var3, var4);

  foreach(var6 in self.scriptables) {
    var6 setscriptablepartstate("onoff", "off");
  }

  foreach(var9 in self.lit_models) {
    var9 hide();

    if(isDefined(var9.effect)) {
      var9.effect scripts\engine\utility::pauseeffect();
    }
  }

  scripts\engine\utility::array_call(self.unlit_models, &show);
}

function set_lights_values(var0, var1) {
  if(isDefined(var0)) {
    var0 = max(0, var0);
  }

  if(isDefined(var1)) {
    var1 = (max(0, var1[0]), max(0, var1[1]), max(0, var1[2]));
  }

  if(isDefined(var0)) {
    self setlightintensity(var0);

    if(isDefined(self.linked_lights)) {
      scripts\engine\utility::array_call(self.linked_lights, &setlightintensity, var0);
    }
  }

  if(isDefined(var1)) {
    self setlightcolor(var1);

    if(isDefined(self.linked_lights)) {
      scripts\engine\utility::array_call(self.linked_lights, &setlightcolor, var1);
      return;
    }

    return;
  }
}

function is_light_entity(var0) {
  return var0.classname == "light_spot" || var0.classname == "light_omni" || var0.classname == "light";
}

function init_light_type(var0) {
  self.light_type = get_defined_value([self.script_type, var0, "generic"]);
  self.two_color = issubstr(self.light_type, "two_color");
  self.type_on = issubstr(self.light_type, "on");
  self.type_off = issubstr(self.light_type, "off");
  self.type_run = issubstr(self.light_type, "running");
  self.static_time = issubstr(self.light_type, "timed");
  self.delay_start = issubstr(self.light_type, "delaystart");
  self.random_intensity_on = issubstr(self.light_type, "on_random_intensity");
  self.random_intensity_off = issubstr(self.light_type, "off_random_intensity");
}

function generic_pulsing() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var0 = self getlightintensity();
  var1 = 0.05;
  var2 = var0;
  var3 = 0.3;
  var4 = 0.6;
  var5 = (var0 - var1) / var3 / 0.05;
  var6 = (var0 - var1) / var4 / 0.05;

  for(;;) {
    var7 = 0;

    while(var7 < var4) {
      var2 -= var6;
      var2 = clamp(var2, 0, 100);
      self setlightintensity(var2);
      var7 += 0.05;
      wait 0.05;
    }

    wait 1;
    var7 = 0;

    while(var7 < var3) {
      var2 += var5;
      var2 = clamp(var2, 0, 100);
      self setlightintensity(var2);
      var7 += 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

function generic_double_strobe() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var0 = self getlightintensity();
  var1 = 0.05;
  var2 = 0;
  var3 = undefined;
  var4 = undefined;
  var5 = 0;
  var6 = [];

  if(isDefined(self.script_noteworthy)) {
    var7 = getEntArray(self.script_noteworthy, "targetname");

    for(var8 = 0; var8 < var7.size; var8++) {
      if(is_light_entity(var7[var8])) {
        var5 = 1;
        var6 = var7[var8];
      }

      if(var7[var8].classname == "script_model") {
        var3 = var7[var8];
        var4 = getEnt(var3.target, "targetname");
        var2 = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(var1);

    if(var2) {
      var3 hide();
      var4 show();
    }

    wait 0.8;
    self setlightintensity(var0);

    if(var2) {
      var3 show();
      var4 hide();
    }

    wait 0.1;
    self setlightintensity(var1);

    if(var2) {
      var3 hide();
      var4 show();
    }

    wait 0.12;
    self setlightintensity(var0);

    if(var2) {
      var3 show();
      var4 hide();
    }

    wait 0.1;
  }
}

function generic_spot() {
  for(;;) {
    waitframe();
  }
}

function burning_trash_fire() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var0 = self getlightintensity();

  for(var1 = var0;; var1 = var2) {
    var2 = randomfloatrange(var0 * 0.7, var0 * 1.2);
    var3 = randomfloatrange(0.3, 0.6);
    var3 *= 20;

    for(var4 = 0; var4 < var3; var4++) {
      var5 = var2 * var4 / var3 + var1 * (var3 - var4) / var3;
      self setlightintensity(var5);
      wait 0.05;
    }
  }
}

function strobelight(var0, var1, var2, var3) {
  var4 = 360 / var2;
  var5 = 0;

  for(;;) {
    var6 = sin(var5 * var4) * 0.5 + 0.5;
    self setlightintensity(var0 + (var1 - var0) * var6);
    wait 0.05;
    var5 += 0.05;

    if(var5 > var2) {
      var5 -= var2;
    }

    if(isDefined(var3)) {
      if(scripts\engine\utility::flag(var3)) {
        return;
      }
    }
  }
}

function changelightcolorto(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  thread changelightcolortoworkerthread(var0, var1, var2, var3);
}

function changelightcolortoworkerthread(var0, var1, var2, var3) {
  var4 = self getlightcolor();
  var5 = 1 / (var1 * 2 - var2 + var3);
  var6 = 0;
  jumpiffalse(var6 < var2) LOC_00000056;
  var7 = var5 / var2;

  while(var6 < var2) {
    var8 = var7 * var6 * var6;
    self setlightcolor(vectorlerp(var4, var0, var8));
    wait 0.05;
    var6 += 0.05;
  }

  while(var6 < var1 - var3) {
    var8 = var5 * (2 * var6 - var2);
    self setlightcolor(vectorlerp(var4, var0, var8));
    wait 0.05;
    var6 += 0.05;
  }

  var6 = var1 - var6;

  if(var6 > 0) {
    var7 = var5 / var3;

    while(var6 > 0) {
      var8 = 1 - var7 * var6 * var6;
      self setlightcolor(vectorlerp(var4, var0, var8));
      wait 0.05;
      var6 -= 0.05;
    }
  }

  self setlightcolor(var0);
}

function flickerlightintensity(var0, var1) {
  var2 = self getlightintensity();
  var3 = 0;
  var4 = var2;
  var5 = 0;

  for(;;) {
    for(var5 = randomintrange(1, 10); var5; var5--) {
      wait randomfloatrange(0.05, 0.1);

      if(var4 > 0.2) {
        var4 = randomfloatrange(0, 0.3);
      } else {
        var4 = var2;
      }

      self setlightintensity(var4);
    }

    self setlightintensity(var2);
    wait randomfloatrange(var0, var1);
  }
}

function sun_shadow_trigger(var0) {
  var1 = 1;
  jumpiffalse(isDefined(var0.script_duration)) LOC_0000001a;
  var1 = var0.script_duration;

  for(;;) {
    var0 waittill("trigger", var2);
    set_sun_shadow_params(var0, var1);
  }
}

function set_sun_shadow_params(var0) {
  var1 = getdvarint("MQRQQONQSL", 1);
  var2 = getdvarfloat("sm_sunshadowscale", 1);
  var3 = getdvarfloat("NPONLLLSPL", 0.25);
  var4 = getdvarfloat("sm_qualityspotshadow", 1);

  if(isDefined(self.script_sunenable)) {
    var1 = self.script_sunenable;
  }

  if(isDefined(self.script_sunshadowscale)) {
    var2 = self.script_sunshadowscale;
  }

  if(isDefined(self.script_sunsamplesizenear)) {
    var3 = self.script_sunsamplesizenear;
  }

  var3 = min(max(0.016, var3), 32);

  if(isDefined(self.script_qualityspotshadow)) {
    var4 = self.script_qualityspotshadow;
  }

  var5 = getdvarint("MQRQQONQSL", 1);
  var6 = getdvarfloat("sm_sunshadowscale", 1);
  var7 = getdvarint("sm_qualityspotshadow", 1);
  setsaveddvar("MQRQQONQSL", var1);
  setsaveddvar("sm_sunshadowscale", var2);
  setsaveddvar("sm_qualityspotshadow", var4);
  lerp_sunsamplesizenear_overtime(var3, var0);
}

function lerp_sunsamplesizenear_overtime(var0, var1) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var2 = getdvarfloat("NPONLLLSPL", 0.25);

  if(var0 == var2) {
    return;
  }

  var3 = var0 - var2;
  var4 = var1 / 0.05;

  if(var4 > 0) {
    var5 = var3 / var4;
    var6 = var2;

    for(var7 = 0; var7 < var4; var7++) {
      var6 += var5;
      setsaveddvar("NPONLLLSPL", var6);
      wait 0.05;
    }
  }

  setsaveddvar("NPONLLLSPL", var0);
}

function lerp_intensity(var0, var1) {
  var2 = int(var1 * 20);
  var3 = self getlightintensity();
  var4 = (var0 - var3) / var2;

  for(var5 = 0; var5 < var2; var5++) {
    thread handle_linked_ents(var0);
    self setlightintensity(var3 + var5 * var4);
    wait 0.05;
  }

  GscBinSkip1(0x45, 0, self);
}

function handle_linked_ents(var0) {
  if(isDefined(self.script_threshold)) {
    var1 = var0 > self.script_threshold;

    foreach(var3 in self.lit_models) {
      if(var1 && !var3.visible) {
        var3.visible = var1;
        var3 show();

        if(isDefined(var3.effect)) {
          var3.effect thread scripts\engine\sp\utility::restarteffect();
        }

        continue;
      }

      if(!var1 && var3.visible) {
        var3.visible = var1;
        var3 hide();

        if(isDefined(var3.effect)) {
          var3.effect thread scripts\engine\utility::pauseeffect();
        }
      }
    }

    foreach(var3 in self.unlit_models) {
      if(!var1 && !var3.visible) {
        var3.visible = 1;
        var3 show();
        continue;
      }

      if(var1 && var3.visible) {
        var3.visible = 0;
        var3 hide();
      }
    }

    return;
  }
}