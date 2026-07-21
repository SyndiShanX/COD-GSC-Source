/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\lights.gsc
***********************************************/

init() {
  var_0 = getEntArray("script_light", "targetname");
  var_1 = getEntArray("script_light_toggle", "targetname");
  var_2 = getEntArray("script_light_destructable", "targetname");
  var_3 = getEntArray("script_light_flicker", "targetname");
  var_4 = getEntArray("script_light_pulse", "targetname");
  var_5 = getEntArray("generic_double_strobe", "targetname");
  var_6 = getEntArray("burning_trash_fire", "targetname");
  var_7 = getEntArray("generic_pulsing", "targetname");
  scripts\engine\utility::array_thread(var_0, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_1, ::init_light_generic_iw7);
  scripts\engine\utility::array_thread(var_2, ::init_light_destructable);
  scripts\engine\utility::array_thread(var_3, ::init_light_flicker);
  scripts\engine\utility::array_thread(var_4, ::init_light_pulse_iw7);
  scripts\engine\utility::array_thread(var_5, ::generic_double_strobe);
  scripts\engine\utility::array_thread(var_6, ::burning_trash_fire);
  scripts\engine\utility::array_thread(var_7, ::generic_pulsing);
  var_8 = getEntArray("light_spot", "classname");
  var_8 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var_8);

  foreach(var_10 in var_8) {
    if(!isDefined(var_10.script_type)) {
      continue;
    }
    switch (var_10.script_type) {
      case "pulse":
        var_10 thread init_pulse();
        break;
      case "strobe":
        var_10 thread init_strobe();
        break;
    }
  }
}

init_pulse() {
  init_light();

  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }
  thread light_think();
}

init_strobe() {
  init_light();

  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }
  if(!isDefined(self.script_delay2) && !isDefined(self.script_delay2_max) && !isDefined(self.script_delay2_min))
    self.script_delay2 = 0.1;

  thread light_think();
}

light_think() {
  self endon("death");
  var_0 = self.script_intensity < self.script_intensity2;
  var_1 = var_0;

  if(isDefined(self.script_flag) && !scripts\engine\utility::flag(self.script_flag)) {
    if(isDefined(self.script_start_intensity))
      set_lights_internal(self.script_start_intensity);
    else if(isDefined(self.script_start_state)) {
      if(self.script_start_state == "on")
        var_1 = !var_0;
    }
  }

  var_2 = 0;

  for(;;) {
    if(isDefined(self.script_flag)) {
      if(!scripts\engine\utility::flag(self.script_flag)) {
        if(!var_2) {
          if(self.script_start_state == "off")
            set_lights_internal(0);
          else
            set_light_values_by_frac(var_1);
        } else
          set_light_values_by_frac(var_0);

        scripts\engine\utility::flag_wait(self.script_flag);
      }
    }

    if(!var_2) {
      var_2 = 1;
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

pulse() {
  self endon("death");
  var_0 = get_script_delay();

  if(has_script_delay2())
    var_0 = get_script_delay2();
  else
    var_0 = get_script_delay();

  light_lerp(var_0);

  if(has_script_wait())
    scripts\engine\utility::script_wait();

  if(has_script_delay2())
    var_0 = get_script_delay2();
  else
    var_0 = get_script_delay();

  light_lerp(var_0, 1);
}

strobe() {
  self endon("death");
  set_light_values_by_frac(1);
  var_0 = get_script_delay();
  wait(var_0);
  var_1 = get_script_loop();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    set_light_values_by_frac(0);

    if(has_script_delay2())
      var_0 = get_script_delay2();
    else
      var_0 = get_script_delay();

    wait(var_0);
    set_light_values_by_frac(1);

    if(var_2 == var_1 - 1) {
      break;
    }

    if(has_script_delay2())
      var_0 = get_script_delay2();
    else
      var_0 = get_script_delay();

    wait(var_0);
  }

  if(has_script_wait())
    scripts\engine\utility::script_wait();
}

light_lerp(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = int(var_0 * 20);
  var_3 = (self.script_intensity - self.script_intensity2) / var_2;
  var_4 = undefined;
  var_5 = undefined;

  if(has_script_color())
    var_5 = (self.script_color - self.script_color2) / var_2;

  for(var_6 = 1; var_6 < var_2; var_6++) {
    if(var_1)
      var_7 = 1 - var_6 / var_2;
    else
      var_7 = var_6 / var_2;

    set_light_values_by_frac(var_7);
    waitframe();
  }

  if(var_1)
    var_7 = 0;
  else
    var_7 = 1;

  set_light_values_by_frac(var_7);
  waitframe();
}

set_light_values_by_frac(var_0) {
  var_1 = scripts\engine\math::lerp(self.script_intensity2, self.script_intensity, var_0);
  var_2 = undefined;

  if(has_script_color())
    var_2 = vectorlerp(self.script_color, self.script_color2, var_0);

  set_lights_internal(var_1, var_2);
}

set_lights_internal(var_0, var_1) {
  if(isDefined(var_0)) {
    self setlightintensity(var_0);

    if(isDefined(self.linked_lights))
      scripts\engine\utility::array_call(self.linked_lights, ::setlightintensity, var_0);
  }

  if(isDefined(var_1)) {
    self setlightcolor(var_1);

    if(isDefined(self.linked_lights))
      scripts\engine\utility::array_call(self.linked_lights, ::setlightcolor, var_1);
  }

  if(var_0 > 0.2)
    set_light_parts_on();
  else if(var_0 < 0.2)
    set_light_parts_off();
}

set_light_parts_on() {
  scripts\engine\utility::ent_flag_set("light_on");

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::exploder(self.script_prefab_exploder);

  if(isDefined(self.scriptables)) {
    foreach(var_1 in self.scriptables)
    var_1 setscriptablepartstate("onoff", "on");
  }

  scripts\engine\utility::array_call(self.models_unlit, ::hide);

  foreach(var_4 in self.models_lit) {
    var_4 show();

    if(isDefined(var_4.script_fxid)) {
      if(isDefined(var_4.fxobj))
        var_4.fxobj delete();

      var_4.fxobj = spawnfx(scripts\engine\utility::getfx(var_4.script_fxid), var_4.fx_origin, var_4.fx_forward, var_4.fx_up);
      triggerfx(var_4.fxobj);
      var_4.fxobj willneverchange();
    }
  }
}

set_light_parts_off() {
  scripts\engine\utility::ent_flag_clear("light_on");

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::stop_exploder(self.script_prefab_exploder);

  if(isDefined(self.scriptables)) {
    foreach(var_1 in self.scriptables)
    var_1 setscriptablepartstate("onoff", "off");
  }

  foreach(var_4 in self.models_lit) {
    var_4 hide();

    if(isDefined(var_4.fxobj))
      var_4.fxobj delete();
  }

  scripts\engine\utility::array_call(self.models_unlit, ::show);
}

init_light() {
  self.script_intensity = get_defined_value([self.script_intensity, self getlightintensity()]);
  self.script_color = get_defined_value([self.script_color, self getlightcolor()]);
  self.script_intensity2 = get_defined_value([self.script_intensity2, 0]);
  self.script_color2 = get_defined_value([self.script_color2]);
  self.script_notify_start = get_defined_value([self.script_notify_start]);
  self.script_notify_stop = get_defined_value([self.script_notify_stop]);
  self.script_startrunning = get_defined_value([self.script_startrunning]);

  if(!isDefined(self.script_delay) && !isDefined(self.script_delay_max) && !isDefined(self.script_delay_min))
    self.script_delay = 0.8;

  if(!scripts\engine\utility::ent_flag_exist("light_on"))
    scripts\engine\utility::ent_flag_init("light_on");

  self.models_lit = [];
  self.models_unlit = [];
  self.linked_lights = [];
  self.triggers = [];
  var_0 = scripts\engine\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    if(is_light_entity(var_2)) {
      self.linked_lights[self.linked_lights.size] = var_2;
      continue;
    }

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "on") {
      self.models_lit[self.models_lit.size] = var_2;
      continue;
    }

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "off") {
      self.models_unlit[self.models_unlit.size] = var_2;
      continue;
    }

    if(var_2.code_classname == "trigger_multiple" || var_2.code_classname == "trigger_once")
      self.triggers[self.triggers.size] = var_2;
  }

  if(getdvarint("LLQQOPKTKM") == 1) {
    set_light_parts_off();
    set_lights_values(0);
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target))
    self.scriptables = getscriptablearray(self.target, "targetname");

  scripts\engine\utility::array_thread(self.triggers, ::trigger_light, self);

  foreach(var_5 in self.models_lit) {
    if(isDefined(var_5.script_fxid)) {
      if(isDefined(var_5.script_offset))
        var_6 = var_5.origin + var_5.script_offset;
      else
        var_6 = var_5.origin;

      if(isDefined(var_5.script_angles))
        var_7 = var_5.angles + var_5.script_angles;
      else
        var_7 = var_5.angles;

      var_5.fx_origin = var_6;
      var_5.fx_forward = anglesToForward(var_7);
      var_5.fx_up = anglestoup(var_7);
      var_5.fxobj = spawnfx(scripts\engine\utility::getfx(var_5.script_fxid), var_5.fx_origin, var_5.fx_forward, var_5.fx_up);
    }
  }

  self notify("init_light_complete");
}

trigger_light(var_0) {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var_1 = "trigger_light_stop";
    var_0.trig_notify_stop = var_1;
  } else {
    var_1 = "trigger_light_start";
    var_0.trig_notify_start = var_1;
  }

  self waittill("trigger");

  if(isDefined(var_0))
    var_0 notify(var_1);
}

get_defined_value(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      return var_2;
  }

  return undefined;
}

start_delay() {
  if(isDefined(self.script_startdelay_min) && isDefined(self.script_startdelay_max))
    wait(randomfloatrange(self.script_startdelay_min, self.script_startdelay_max));
  else if(isDefined(self.script_startdelay))
    wait(self.script_startdelay);
}

script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max))
    wait(randomfloatrange(self.script_wait2_min, self.script_delay2_max));
  else if(isDefined(self.script_delay2))
    wait(self.script_delay2);
}

get_script_delay() {
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max))
    return randomfloatrange(self.script_delay_min, self.script_delay_max);
  else if(isDefined(self.script_delay))
    return self.script_delay;

  return 0;
}

get_script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max))
    return randomfloatrange(self.script_delay2_min, self.script_delay2_max);
  else if(isDefined(self.script_delay2))
    return self.script_delay2;

  return 0;
}

get_script_loop() {
  if(isDefined(self.script_count_min) && isDefined(self.script_count_max))
    return randomintrange(self.script_count_min, self.script_count_max);
  else if(isDefined(self.script_count))
    return self.script_count;

  return 1;
}

has_script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max))
    return 1;
  else if(isDefined(self.script_delay2))
    return 1;

  return 0;
}

has_script_wait() {
  if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max))
    return 1;
  else if(isDefined(self.script_wait))
    return 1;

  return 0;
}

has_script_color() {
  if(isDefined(self.script_color) && isDefined(self.script_color2))
    return 1;

  return 0;
}

light_debug_thread() {
  var_0 = getEntArray("light_spot", "classname");
  var_0 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var_0);

  for(;;) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(isDefined(var_3)) {
        var_3 light_debug_draw();
        continue;
      }

      var_1 = 1;
    }

    if(var_1)
      var_0 = scripts\engine\utility::array_removeundefined(var_0);

    waitframe();
  }
}

light_debug_draw() {
  if(distancesquared(self.origin, level.player.origin) < 2000) {
    return;
  }
  light_debug_print3d("Intensity: " + self getlightintensity());
}

light_debug_print3d(var_0) {
  if(!isDefined(var_0))
    return;
}

init_light_generic_iw7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(self.script_type)) {
    return;
  }
  wait 0.05;
  self.intensity_01 = get_defined_value([self.script_intensity_01, var_0, self getlightintensity()]);
  self.color_01 = get_defined_value([self.script_color_01, var_1, self getlightcolor()]);
  self.intensity_02 = get_defined_value([self.script_intensity_02, var_2, 0]);
  self.color_02 = get_defined_value([self.script_color_02, var_3, (0, 0, 0)]);
  self.notify_start = get_defined_value([self.script_light_startnotify, var_4]);
  self.notify_stop = get_defined_value([self.script_light_stopnotify, var_5]);
  self.start_running = get_defined_value([self.script_startrunning, var_6]);
  self.light_type = get_defined_value([self.script_type, "generic"]);
  self.delay_start = issubstr(self.light_type, "delaystart");

  if(!scripts\engine\utility::ent_flag_exist("light_on"))
    scripts\engine\utility::ent_flag_init("light_on");

  self.lit_models = [];
  self.unlit_models = [];
  self.linked_lights = [];
  self.triggers = [];
  var_8 = scripts\engine\utility::get_linked_ents();

  foreach(var_10 in var_8) {
    if(is_light_entity(var_10)) {
      self.linked_lights[self.linked_lights.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "on") {
      self.lit_models[self.lit_models.size] = var_10;
      continue;
    }

    if(isDefined(var_10.script_noteworthy) && var_10.script_noteworthy == "off") {
      self.unlit_models[self.unlit_models.size] = var_10;
      continue;
    }

    if(issubstr(var_10.classname, "trigger"))
      self.triggers[self.triggers.size] = var_10;
  }

  if(getDvar("LLQQOPKTKM") == "1") {
    set_lights_values(0, (0, 0, 0));
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");

  if(isDefined(self.target))
    self.scriptables = getscriptablearray(self.target, "targetname");

  if(self.lit_models.size != 0 || self.unlit_models.size != 0) {}

  scripts\engine\utility::array_thread(self.triggers, ::init_light_trig, self);

  foreach(var_13 in self.lit_models) {
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

  self.init_complete = 1;
  self notify("script_light_init_complete");

  if(isDefined(var_7) && var_7) {
    return;
  }
  if(isDefined(self.notify_start) || isDefined(self.notify_stop) || self.triggers.size > 0)
    thread light_toggle_loop();
}

init_light_destructable() {
  if(isDefined(self.script_type)) {
    return;
  }
  init_light_generic_iw7();
}

light_toggle_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running)
    light_turn_on();
  else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start))
    light_turn_off();

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on")) {
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);
      scripts\engine\utility::script_delay();

      if(isDefined(self.delay_start)) {
        if(isDefined(self.script_delay))
          self.old_script_delay = self.script_delay;

        if(isDefined(self.script_delay_max))
          self.old_script_delay_max = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self.old_script_delay_min = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      light_turn_on();
    }

    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay))
        self.old_script_delay = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.old_script_delay_max = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.old_script_delay_min = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    light_turn_off();

    if(isDefined(self.old_script_delay))
      self.script_delay = self.old_script_delay;

    if(isDefined(self.old_script_delay_max))
      self.script_delay_max = self.old_script_delay_max;

    if(isDefined(self.old_script_delay_min))
      self.script_delay_min = self.old_script_delay_min;

    wait 0.05;
  }
}

init_light_flicker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(self.script_type)) {
    return;
  }
  init_light_generic_iw7(var_0, var_1, var_4, var_5, var_9, var_10, var_11, 1);

  if(getDvar("LLQQOPKTKM") == "1") {
    return;
  }
  make_light_flicker(var_2, var_3, var_6, var_7, var_8, var_12, var_13);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread start_light_flicker();
}

make_light_flicker(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  init_light_type(var_5);
  self.speed_scale = get_defined_value([self.script_speed_scale, var_4, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, var_6, 3]) / self.speed_scale, 0.25);

  if(isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max))
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, var_0, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, var_1, 0.1]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      var_7 = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = var_7;
    }
  }

  if(isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max))
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
  else {
    self.wait_02_min = max(get_defined_value([self.script_wait_02_min, var_2, 0.05]) / self.speed_scale, 0.05);
    self.wait_02_max = max(get_defined_value([self.script_wait_02_max, var_3, 0.75]) / self.speed_scale, 0.1);

    if(self.wait_02_min > self.wait_02_max) {
      var_7 = self.wait_02_max;
      self.wait_02_max = self.wait_02_min;
      self.wait_02_min = var_7;
    }
  }
}

start_light_flicker() {
  if(self.type_on || self.type_off)
    thread light_flicker_on_off_loop();
  else
    thread light_flicker_loop();
}

light_flicker_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running)
    light_turn_on();
  else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start))
    light_turn_off(undefined, self.two_color);

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    for(;;) {
      scripts\engine\utility::script_delay();

      if(isDefined(self.delay_start)) {
        if(isDefined(self.script_delay))
          self.old_script_delay = self.script_delay;

        if(isDefined(self.script_delay_max))
          self.old_script_delay_max = self.script_delay_max;

        if(isDefined(self.script_delay_min))
          self.old_script_delay_min = self.script_delay_min;

        self.script_delay = undefined;
        self.script_delay_max = undefined;
        self.script_delay_min = undefined;
      }

      light_flicker_proc();

      if(isDefined(self.start_running) && self.start_running)
        light_turn_on();
      else
        light_turn_off(undefined, self.two_color);

      if(isDefined(self.old_script_delay))
        self.script_delay = self.old_script_delay;

      if(isDefined(self.old_script_delay_max))
        self.script_delay_max = self.old_script_delay_max;

      if(isDefined(self.old_script_delay_min))
        self.script_delay_min = self.old_script_delay_min;

      waitframe();
    }
  } else {
    light_flicker_proc();

    if(isDefined(self.start_running) && self.start_running) {
      light_turn_on();
      return;
    }

    light_turn_off(undefined, self.two_color);
  }
}

light_flicker_on_off_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running)
    light_turn_on();
  else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start))
    light_turn_off(undefined, self.two_color);

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start)))
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);

    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay))
        self.old_script_delay = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.old_script_delay_max = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.old_script_delay_min = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.type_on && !scripts\engine\utility::ent_flag("light_on")) {
      childthread light_flicker_proc(1, self.random_intensity_on);

      if(self.static_time)
        wait(self.on_off_time);
      else
        wait(randomfloat(self.on_off_time));

      self notify("stop_flicker");
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }
    if(!self.type_run)
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    else
      light_flicker_proc(1);

    if(self.type_off) {
      childthread light_flicker_proc(1, self.random_intensity_off);

      if(self.static_time)
        wait(self.on_off_time);
      else
        wait(randomfloat(self.on_off_time));

      self notify("stop_flicker");
    }

    light_turn_off(undefined, self.two_color);

    if(isDefined(self.old_script_delay))
      self.script_delay = self.old_script_delay;

    if(isDefined(self.old_script_delay_max))
      self.script_delay_max = self.old_script_delay_max;

    if(isDefined(self.old_script_delay_min))
      self.script_delay_min = self.old_script_delay_min;

    wait 0.05;

    if(!isDefined(self.notify_start) && !isDefined(self.notify_stop))
      return;
  }
}

light_flicker_proc(var_0, var_1) {
  self notify("stop_flicker");
  self endon("stop_flicker");

  if(isDefined(self.trig_notify_stop))
    level endon(self.trig_notify_stop);

  if(isDefined(self.notify_stop))
    level endon(self.notify_stop);

  if(!isDefined(var_0) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start)))
    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);

  for(;;) {
    light_turn_on(var_1);

    if(isDefined(self.hi_wait))
      wait(self.hi_wait);
    else
      wait(randomfloatrange(self.wait_01_min, self.wait_01_max));

    light_turn_off(var_1);

    if(isDefined(self.lo_wait)) {
      wait(self.lo_wait);
      continue;
    }

    wait(randomfloatrange(self.wait_02_min, self.wait_02_max));
  }
}

init_light_pulse_iw7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(self.script_type)) {
    return;
  }
  init_light_generic_iw7(var_0, var_1, var_4, var_5, var_9, var_10, undefined, 1);

  if(getDvar("LLQQOPKTKM") == "1") {
    return;
  }
  make_light_pulse(var_2, var_3, var_6, var_7, var_8, var_12, var_13, var_11);

  if(isDefined(var_14) && var_14) {
    return;
  }
  thread start_light_pulse();
}

make_light_pulse(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self.start_running = get_defined_value([self.script_startrunning, var_7, 1]);
  init_light_type(var_5);
  self.speed_scale = get_defined_value([self.script_speed_scale, var_4, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, var_6, 3]) / self.speed_scale, 3);

  if(isDefined(self.script_wait_01_min) && !isDefined(self.script_wait_01_max) || !isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max))
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, var_0, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, var_1, 0.5]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      var_8 = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = var_8;
    }
  }

  if(isDefined(self.script_wait_02_min) && !isDefined(self.script_wait_02_max) || !isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max)) {
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
    var_9 = int(self.lo_wait * 20);
    self.step_inc = 2 / var_9;
    self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / var_9;
  } else {
    self.wait_02_min = max(get_defined_value([self.script_wait_02_min, var_2, 0.25]) / self.speed_scale, 0.05);
    self.wait_02_max = max(get_defined_value([self.script_wait_02_max, var_3, 0.75]) / self.speed_scale, 0.1);

    if(self.wait_02_min > self.wait_02_max) {
      var_8 = self.wait_02_max;
      self.wait_02_max = self.wait_02_min;
      self.wait_02_min = var_8;
    }

    var_9 = int(self.wait_02_max * 20);
    self.step_inc = 2 / var_9;
    self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / var_9;
  }
}

start_light_pulse() {
  if(self.type_on || self.type_off)
    thread light_pulse_on_off_loop();
  else
    thread light_pulse_loop();
}

light_pulse_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running)
    light_turn_on();
  else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start))
    light_turn_off(undefined, self.two_color);

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    for(;;) {
      light_pulse_proc_iw7();

      if(isDefined(self.start_running) && self.start_running)
        light_turn_on();
      else
        light_turn_off(undefined, self.two_color);

      waitframe();
    }
  } else {
    light_pulse_proc_iw7();

    if(isDefined(self.start_running) && self.start_running) {
      light_turn_on();
      return;
    }

    light_turn_off(undefined, self.two_color);
  }
}

light_pulse_on_off_loop() {
  self endon("death");
  self notify("stop_script_light_loop");
  self endon("stop_script_light_loop");

  if(isDefined(self.start_running) && self.start_running)
    light_turn_on();
  else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start))
    light_turn_off(undefined, self.two_color);

  for(;;) {
    if(!scripts\engine\utility::ent_flag("light_on") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start)))
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);

    scripts\engine\utility::script_delay();

    if(isDefined(self.delay_start)) {
      if(isDefined(self.script_delay))
        self.old_script_delay = self.script_delay;

      if(isDefined(self.script_delay_max))
        self.old_script_delay_max = self.script_delay_max;

      if(isDefined(self.script_delay_min))
        self.old_script_delay_min = self.script_delay_min;

      self.script_delay = undefined;
      self.script_delay_max = undefined;
      self.script_delay_min = undefined;
    }

    if(self.type_on && !scripts\engine\utility::ent_flag("light_on")) {
      childthread light_pulse_proc_iw7(1);

      if(self.static_time)
        wait(self.on_off_time);
      else
        wait(randomfloat(self.on_off_time));

      self notify("stop_pulse");
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }
    if(!self.type_run)
      level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop);
    else
      light_pulse_proc_iw7(1);

    if(self.type_off) {
      childthread light_pulse_proc_iw7(1);

      if(self.static_time)
        wait(self.on_off_time);
      else
        wait(randomfloat(self.on_off_time));

      self notify("stop_flicker");
    }

    light_turn_off(undefined, self.two_color);

    if(isDefined(self.old_script_delay))
      self.script_delay = self.old_script_delay;

    if(isDefined(self.old_script_delay_max))
      self.script_delay_max = self.old_script_delay_max;

    if(isDefined(self.old_script_delay_min))
      self.script_delay_min = self.old_script_delay_min;

    waitframe();

    if(!isDefined(self.notify_start) && !isDefined(self.notify_stop))
      return;
  }
}

light_pulse_proc_iw7(var_0) {
  self notify("stop_pulse");
  self endon("stop_pulse");

  if(isDefined(self.trig_notify_stop))
    level endon(self.trig_notify_stop);

  if(isDefined(self.notify_stop))
    level endon(self.notify_stop);

  if(!isDefined(var_0) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start)))
    level scripts\engine\utility::waittill_any("FAKE_WAITTILL", self.trig_notify_start, self.notify_start);

  for(;;) {
    light_turn_on();

    if(isDefined(self.hi_wait))
      wait(self.hi_wait);
    else
      wait(randomfloatrange(self.wait_01_min, self.wait_01_max));

    if(isDefined(self.lo_wait)) {
      light_pulse(self.lo_wait);
      continue;
    }

    light_pulse(randomfloatrange(self.wait_02_min, self.wait_02_max));
  }
}

init_light_trig(var_0) {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stop") {
    var_1 = "trigger_light_stop";
    var_0.trig_notify_stop = var_1;
  } else {
    var_1 = "trigger_light_start";
    var_0.trig_notify_start = var_1;
  }

  self waittill("trigger");

  if(isDefined(var_0))
    var_0 notify(var_1);
}

light_turn_on(var_0) {
  scripts\engine\utility::ent_flag_set("light_on");

  if(isDefined(var_0) && var_0 && self.intensity_01 > 0)
    set_lights_values(randomfloatrange(self.intensity_01 * 0.25, self.intensity_01), self.color_01);
  else
    set_lights_values(self.intensity_01, self.color_01);

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::exploder(self.script_prefab_exploder);

  foreach(var_2 in self.scriptables)
  var_2 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self.unlit_models, ::hide);

  foreach(var_5 in self.lit_models) {
    var_5 show();

    if(isDefined(var_5.effect))
      var_5.effect scripts\engine\sp\utility::restarteffect();
  }
}

light_turn_off(var_0, var_1) {
  scripts\engine\utility::ent_flag_clear("light_on");

  if(isDefined(var_1) && var_1)
    set_lights_values(0, (0, 0, 0));
  else if(isDefined(var_0) && var_0 && self.intensity_02 > 0)
    set_lights_values(randomfloatrange(self.intensity_02 * 0.25, self.intensity_02), self.color_02);
  else
    set_lights_values(self.intensity_02, self.color_02);

  if(isDefined(self.script_prefab_exploder))
    scripts\engine\utility::stop_exploder(self.script_prefab_exploder);

  foreach(var_3 in self.scriptables)
  var_3 setscriptablepartstate("onoff", "off");

  foreach(var_6 in self.lit_models) {
    var_6 hide();

    if(isDefined(var_6.effect))
      var_6.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self.unlit_models, ::show);
}

light_pulse(var_0) {
  scripts\engine\utility::ent_flag_clear("light_on");
  var_1 = int(var_0 / 0.1);

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    var_3 = max(0, self.intensity_01 - self.intensity_inc * var_2);
    var_4 = vectorlerp(self.color_01, self.color_02, self.step_inc * var_2);
    set_lights_values(var_3, var_4);
    wait 0.05;
  }

  for(var_2 = var_1; var_2 > 0; var_2--) {
    var_3 = max(0, self.intensity_01 - self.intensity_inc * var_2);
    var_4 = vectorlerp(self.color_01, self.color_02, self.step_inc * var_2);
    set_lights_values(var_3, var_4);
    wait 0.05;
  }
}

lights_turn_on(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, var_1);
  scripts\engine\utility::array_thread(var_5, ::turn_on_proc, var_2, var_3, var_4);
}

turn_on_proc(var_0, var_1, var_2) {
  if(!isDefined(self.init_complete))
    self waittill("script_light_init_complete");

  if(isDefined(var_2) && var_2)
    self notify("stop_script_light_loop");

  var_3 = self.intensity_01;
  var_4 = self.color_01;

  if(isDefined(var_0))
    var_3 = var_0;

  if(isDefined(var_1))
    var_4 = var_1;

  scripts\engine\utility::ent_flag_set("light_on");
  set_lights_values(var_3, var_4);

  foreach(var_6 in self.scriptables)
  var_6 setscriptablepartstate("onoff", "on");

  scripts\engine\utility::array_call(self.unlit_models, ::hide);

  foreach(var_9 in self.lit_models) {
    var_9 show();

    if(isDefined(var_9.effect))
      var_9.effect scripts\engine\sp\utility::restarteffect();
  }
}

lights_turn_off(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, var_1);
  scripts\engine\utility::array_thread(var_5, ::turn_off_proc, var_2, var_3, var_4);
}

turn_off_proc(var_0, var_1, var_2) {
  if(!isDefined(self.init_complete))
    self waittill("script_light_init_complete");

  if(isDefined(var_2) && var_2)
    self notify("stop_script_light_loop");

  var_3 = self.intensity_02;
  var_4 = self.color_02;

  if(isDefined(var_0))
    var_3 = var_0;

  if(isDefined(var_1))
    var_4 = var_1;

  scripts\engine\utility::ent_flag_clear("light_on");
  set_lights_values(var_3, var_4);

  foreach(var_6 in self.scriptables)
  var_6 setscriptablepartstate("onoff", "off");

  foreach(var_9 in self.lit_models) {
    var_9 hide();

    if(isDefined(var_9.effect))
      var_9.effect scripts\engine\utility::pauseeffect();
  }

  scripts\engine\utility::array_call(self.unlit_models, ::show);
}

set_lights_values(var_0, var_1) {
  if(isDefined(var_0))
    var_0 = max(0, var_0);

  if(isDefined(var_1))
    var_1 = (max(0, var_1[0]), max(0, var_1[1]), max(0, var_1[2]));

  if(isDefined(var_0)) {
    self setlightintensity(var_0);

    if(isDefined(self.linked_lights))
      scripts\engine\utility::array_call(self.linked_lights, ::setlightintensity, var_0);
  }

  if(isDefined(var_1)) {
    self setlightcolor(var_1);

    if(isDefined(self.linked_lights))
      scripts\engine\utility::array_call(self.linked_lights, ::setlightcolor, var_1);
  }
}

is_light_entity(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

init_light_type(var_0) {
  self.light_type = get_defined_value([self.script_type, var_0, "generic"]);
  self.two_color = issubstr(self.light_type, "two_color");
  self.type_on = issubstr(self.light_type, "on");
  self.type_off = issubstr(self.light_type, "off");
  self.type_run = issubstr(self.light_type, "running");
  self.static_time = issubstr(self.light_type, "timed");
  self.delay_start = issubstr(self.light_type, "delaystart");
  self.random_intensity_on = issubstr(self.light_type, "on_random_intensity");
  self.random_intensity_off = issubstr(self.light_type, "off_random_intensity");
}

generic_pulsing() {
  if(isDefined(self.script_type)) {
    return;
  }
  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
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

generic_double_strobe() {
  if(isDefined(self.script_type)) {
    return;
  }
  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
  var_1 = 0.05;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;
  var_6 = [];

  if(isDefined(self.script_noteworthy)) {
    var_7 = getEntArray(self.script_noteworthy, "targetname");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(is_light_entity(var_7[var_8])) {
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

generic_spot() {
  for(;;)
    waitframe();
}

burning_trash_fire() {
  if(isDefined(self.script_type)) {
    return;
  }
  if(getDvar("LLQQOPKTKM") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
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

strobelight(var_0, var_1, var_2, var_3) {
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

changelightcolorto(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  thread changelightcolortoworkerthread(var_0, var_1, var_2, var_3);
}

changelightcolortoworkerthread(var_0, var_1, var_2, var_3) {
  var_4 = self getlightcolor();
  var_5 = 1 / (var_1 * 2 - (var_2 + var_3));
  var_6 = 0;

  if(var_6 < var_2) {
    for(var_7 = var_5 / var_2; var_6 < var_2; var_6 = var_6 + 0.05) {
      var_8 = var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  while(var_6 < var_1 - var_3) {
    var_8 = var_5 * (2 * var_6 - var_2);
    self setlightcolor(vectorlerp(var_4, var_0, var_8));
    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  var_6 = var_1 - var_6;

  if(var_6 > 0) {
    for(var_7 = var_5 / var_3; var_6 > 0; var_6 = var_6 - 0.05) {
      var_8 = 1 - var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  self setlightcolor(var_0);
}

flickerlightintensity(var_0, var_1) {
  var_2 = self getlightintensity();
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

sun_shadow_trigger(var_0) {
  var_1 = 1;

  if(isDefined(var_0.script_duration))
    var_1 = var_0.script_duration;

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 set_sun_shadow_params(var_1);
  }
}

set_sun_shadow_params(var_0) {
  var_1 = getdvarint("MQRQQONQSL", 1);
  var_2 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_3 = getdvarfloat("NPONLLLSPL", 0.25);
  var_4 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isDefined(self.script_sunenable))
    var_1 = self.script_sunenable;

  if(isDefined(self.script_sunshadowscale))
    var_2 = self.script_sunshadowscale;

  if(isDefined(self.script_sunsamplesizenear))
    var_3 = self.script_sunsamplesizenear;

  var_3 = min(max(0.016, var_3), 32);

  if(isDefined(self.script_qualityspotshadow))
    var_4 = self.script_qualityspotshadow;

  var_5 = getdvarint("MQRQQONQSL", 1);
  var_6 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_7 = getdvarint("sm_qualityspotshadow", 1.0);
  setsaveddvar("MQRQQONQSL", var_1);
  setsaveddvar("sm_sunshadowscale", var_2);
  setsaveddvar("sm_qualityspotshadow", var_4);
  lerp_sunsamplesizenear_overtime(var_3, var_0);
}

lerp_sunsamplesizenear_overtime(var_0, var_1) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var_2 = getdvarfloat("NPONLLLSPL", 0.25);

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
      setsaveddvar("NPONLLLSPL", var_6);
      wait 0.05;
    }
  }

  setsaveddvar("NPONLLLSPL", var_0);
}

lerp_intensity(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self getlightintensity();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread handle_linked_ents(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self.linked_lights))
    var_6 = scripts\engine\utility::array_combine(var_6, self.linked_lights);

  foreach(var_8 in var_6) {
    var_8 thread handle_linked_ents(var_0);
    var_8 setlightintensity(var_0);
  }
}

handle_linked_ents(var_0) {
  if(isDefined(self.script_threshold)) {
    var_1 = var_0 > self.script_threshold;

    foreach(var_3 in self.lit_models) {
      if(var_1 && !var_3.visible) {
        var_3.visible = var_1;
        var_3 show();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\engine\sp\utility::restarteffect();

        continue;
      }

      if(!var_1 && var_3.visible) {
        var_3.visible = var_1;
        var_3 hide();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }

    foreach(var_3 in self.unlit_models) {
      if(!var_1 && !var_3.visible) {
        var_3.visible = 1;
        var_3 show();
        continue;
      }

      if(var_1 && var_3.visible) {
        var_3.visible = 0;
        var_3 hide();
      }
    }
  }
}