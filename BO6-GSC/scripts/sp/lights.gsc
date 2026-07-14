/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\lights.gsc
**************************************/

#using scripts\common\createfx;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace lights;

function init() {
  generic_lights = getEntArray("\x1fR\xac\x95\x82\x1aF'aF\x8a9", #targetname);
  toggle_lights = getEntArray("\xce\x9c\xc9\x92\xd6\x12}\xbe\xc4~\x05\xf0\xcej\x11-\xa0\xe3K", #targetname);
  destructable_lights = getEntArray("pC3\x9b\xdaY\xe0\xdd\xf5\x90\xda\xf8\x80\xf1\x0fpH!\xd3\x9e9\xfb\x9a\xdd\x95", #targetname);
  flicker_lights = getEntArray("\x1e\xac\x8c\x06P\x14\xa3\xa8\xc5!w\x89\x03\xdc1\xac\xcdblT", #targetname);
  pulse_lights = getEntArray("\xe67UKAv]+\x8d\xed79\x1b\xcc\x86\xce\xefl", #targetname);
  double_strobe = getEntArray("R\x88\xd4\x8d\x89\x1a\"\xf2\xcb\xcf\r&p\xd4\xf4\x94\xe2fC\xa7,", #targetname);
  burning_trash_fire = getEntArray("(\xe0a\\c$\xf1q\t\xde\x1aYo\x82+Fr-", #targetname);
  cine_tank_fire = getEntArray("\xea\xc6\n\xa8^\xfev\x05\x13\xde\xa4\xac{\xfd", #targetname);
  var_f004499af4659e28 = getEntArray("\xbfa\xe6],\x8bh\x8c\x06\xde\x04O\xd7%\x12", #targetname);
  utility::array_thread(generic_lights, &init_light_generic_iw7);
  utility::array_thread(toggle_lights, &init_light_generic_iw7);
  utility::array_thread(destructable_lights, &init_light_destructable);
  utility::array_thread(flicker_lights, &init_light_flicker);
  utility::array_thread(pulse_lights, &init_light_pulse_iw7);
  utility::array_thread(double_strobe, &generic_double_strobe);
  utility::array_thread(burning_trash_fire, &burning_trash_fire);
  utility::array_thread(var_f004499af4659e28, &generic_pulsing);
  utility::array_thread(cine_tank_fire, &cine_tank_fire);
  lights = getEntArray("\x02\x7f\xe0\v\xf3\xc3 \xb8\x1a\xd5", #classname);
  lights = utility::array_combine(getEntArray("6\xc7\xefqVe\xfa\x94\x145", #classname), lights);
  lights = utility::array_combine(getEntArray("T\xf2\xa4:K", #classname), lights);

  foreach(light in lights) {
    if(!isDefined(light.script_type)) {
      continue;
    }

    switch (light.script_type) {
      case #"hash_f16db92e8d0bbd7e":
        light thread init_pulse();
        break;
      case #"hash_5775d4ce52daadc8":
        light thread init_strobe();
        break;
      case #"hash_ceb098150f024a39":
        light thread init_fire();
        break;
    }
  }

}

function init_pulse() {
  init_light();

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  thread light_think();
}

function init_fire() {
  init_light();

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  if(!isDefined(self.script_delay2) && !isDefined(self.script_delay2_max) && !isDefined(self.script_delay2_min)) {
    self.script_delay2 = 0.05;
  }

  thread light_think();
}

function init_strobe() {
  init_light();

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  if(!isDefined(self.script_delay2) && !isDefined(self.script_delay2_max) && !isDefined(self.script_delay2_min)) {
    self.script_delay2 = 0.1;
  }

  thread light_think();
}

function light_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  off_frac = self.script_intensity < self.script_intensity2;
  start_frac = off_frac;

  if(isDefined(self.script_flag) && !utility::flag(self.script_flag)) {
    if(isDefined(self.script_start_intensity)) {
      set_lights_internal(self.script_start_intensity);
    } else if(isDefined(self.script_start_state)) {
      if(self.script_start_state == "\xb8\"") {
        start_frac = !off_frac;
      }
    }
  }

  started = 0;

  while(true) {
    if(isDefined(self.script_flag)) {
      if(!utility::flag(self.script_flag)) {
        if(!started) {
          if(self.script_start_state == "\xf8\x88m") {
            set_lights_internal(0);
          } else {
            set_light_values_by_frac(start_frac);
          }
        } else if(isDefined(self.script_clear_intensity)) {
          set_lights_internal(self.script_clear_intensity);
        } else {
          set_light_values_by_frac(off_frac);
        }

        utility::flag_wait(self.script_flag);
      }
    }

    if(!started) {
      started = 1;
      start_delay();
    }

    switch (self.script_type) {
      case #"hash_f16db92e8d0bbd7e":
        pulse();
        break;
      case #"hash_5775d4ce52daadc8":
        strobe();
        break;
      case #"hash_ceb098150f024a39":
        fire();
        break;
    }
  }
}

function pulse() {
  self endon("\x1e\xfd\xd1\xa2\a");
  time = get_script_delay();
  light_lerp(time);

  if(has_script_wait()) {
    utility::script_wait();
  }

  if(has_script_delay2()) {
    time = get_script_delay2();
  } else {
    time = get_script_delay();
  }

  light_lerp(time, 1);
}

function strobe() {
  self endon("\x1e\xfd\xd1\xa2\a");
  set_light_values_by_frac(1);
  time = get_script_delay();
  wait time;
  count = get_script_loop();

  for(i = 0; i < count; i++) {
    set_light_values_by_frac(0);

    if(has_script_delay2()) {
      time = get_script_delay2();
    } else {
      time = get_script_delay();
    }

    wait time;
    set_light_values_by_frac(1);

    if(i == count - 1) {
      break;
    }

    if(has_script_delay2()) {
      time = get_script_delay2();
    } else {
      time = get_script_delay();
    }

    wait time;
  }

  if(has_script_wait()) {
    utility::script_wait();
  }
}

function fire() {
  self endon("\x1e\xfd\xd1\xa2\a");
  old_intensity = self getlightintensity();
  old_color = self getlightcolor();
  intensity = max(randomfloatrange(self.script_intensity2, self.script_intensity), 0);
  timer = 0.05;

  if(has_script_delay2()) {
    timer = get_script_delay2();
  } else {
    timer = get_script_delay();
  }

  timer *= 20;

  for(i = 0; i < timer; i++) {
    curr_intensity = max(math::lerp(old_intensity, intensity, (i + 1) / timer), 0);
    set_lights_internal(curr_intensity, undefined);
    wait 0.05;
  }

  old_intensity = intensity;

  if(has_script_wait()) {
    utility::script_wait();
  }
}

function light_lerp(time, invert) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(invert)) {
    invert = 0;
  }

  steps = int(time * 20);
  intensity_inc = (self.script_intensity - self.script_intensity2) / steps;
  color = undefined;
  color_inc = undefined;

  if(has_script_color()) {
    color_inc = (self.script_color - self.script_color2) / steps;
  }

  for(i = 1; i < steps; i++) {
    if(invert) {
      frac = 1 - i / steps;
    } else {
      frac = i / steps;
    }

    set_light_values_by_frac(frac);
    waitframe();
  }

  if(invert) {
    frac = 0;
  } else {
    frac = 1;
  }

  set_light_values_by_frac(frac);
  waitframe();
}

function set_light_values_by_frac(frac) {
  intensity = math::lerp(self.script_intensity2, self.script_intensity, frac);
  color = undefined;

  if(has_script_color()) {
    color = vectorlerp(self.script_color, self.script_color2, frac);
  }

  set_lights_internal(intensity, color);
}

function set_lights_internal(intensity, color) {
  if(isDefined(intensity)) {
    self setlightintensity(intensity);

    if(isDefined(self.linked_lights)) {
      utility::array_call(self.linked_lights, &setlightintensity, intensity);
    }
  }

  if(isDefined(color)) {
    self setlightcolor(color);

    if(isDefined(self.linked_lights)) {
      utility::array_call(self.linked_lights, &setlightcolor, color);
    }
  }

  if(intensity > 0.0001) {
    set_light_parts_on();
    return;
  }

  if(intensity < 0.0001) {
    set_light_parts_off();
  }
}

function set_light_parts_on() {
  utility::ent_flag_set("\xaa\xb40w\x14\x96\xfbl");

  if(isDefined(self.script_prefab_exploder)) {
    utility::exploder(self.script_prefab_exploder);
  }

  if(isDefined(self.scriptables)) {
    foreach(scriptable in self.scriptables) {
      scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
    }
  }

  utility::array_call(self.models_unlit, &hide);

  foreach(model in self.models_lit) {
    model show();

    if(isDefined(model.script_fxid)) {
      if(isDefined(model.fxobj)) {
        model.fxobj delete();
      }

      model.fxobj = spawnfx(utility::getfx(model.script_fxid), model.fx_origin, model.fx_forward, model.fx_up);
      triggerfx(model.fxobj);
      model.fxobj willneverchange();
    }
  }
}

function set_light_parts_off() {
  utility::ent_flag_clear("\xaa\xb40w\x14\x96\xfbl");

  if(isDefined(self.script_prefab_exploder)) {
    utility::stop_exploder(self.script_prefab_exploder);
  }

  if(isDefined(self.scriptables)) {
    foreach(scriptable in self.scriptables) {
      scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xf8\x88m");
    }
  }

  foreach(model in self.models_lit) {
    model hide();

    if(isDefined(model.fxobj)) {
      model.fxobj delete();
    }
  }

  utility::array_call(self.models_unlit, &show);
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

  if(!utility::ent_flag_exist("\xaa\xb40w\x14\x96\xfbl")) {
    utility::ent_flag_init("\xaa\xb40w\x14\x96\xfbl");
  }

  self.models_lit = [];
  self.models_unlit = [];
  self.linked_lights = [];
  self.triggers = [];
  ents = utility::get_linked_ents();

  foreach(ent in ents) {
    if(is_light_entity(ent)) {
      self.linked_lights[self.linked_lights.size] = ent;
      continue;
    }

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "\xb8\"") {
      self.models_lit[self.models_lit.size] = ent;
      continue;
    }

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "\xf8\x88m") {
      self.models_unlit[self.models_unlit.size] = ent;
      continue;
    }

    if(ent.code_classname == "E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7" || ent.code_classname == "\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xab\v=\x9a") {
      self.triggers[self.triggers.size] = ent;
    }
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    set_light_parts_off();
    set_lights_values(0);
    return;
  }

  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");

  if(isDefined(self.target)) {
    self.scriptables = getscriptablearray(self.target, #targetname);
  }

  utility::array_thread(self.triggers, &trigger_light, self);

  foreach(model in self.models_lit) {
    if(isDefined(model.script_fxid)) {
      if(isDefined(model.script_offset)) {
        origin = model.origin + model.script_offset;
      } else {
        origin = model.origin;
      }

      if(isDefined(model.script_angles)) {
        angles = model.angles + model.script_angles;
      } else {
        angles = model.angles;
      }

      model.fx_origin = origin;
      model.fx_forward = anglesToForward(angles);
      model.fx_up = anglestoup(angles);
      model.fxobj = spawnfx(utility::getfx(model.script_fxid), model.fx_origin, model.fx_forward, model.fx_up);
    }
  }

  self notify("H\xb0R{4v\xfa\x9a\xbb\xf9 \xba\x98Qy\xe8\xd1\xfdQ");
}

function trigger_light(light) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "\x04M\xed\xab") {
    note = "\x01\xc1\v\x1e\xf8h]Y\xdc\xb7|\x96ls|\x97\xf5+";
    light.trig_notify_stop = note;
  } else {
    note = "qK\a\xf5>]e\xd4\xe7\xd8IO\xc2e+y\x18\x1b\xd4";
    light.trig_notify_start = note;
  }

  self waittill("\x91`\xb1\xe7T\x97>");

  if(isDefined(light)) {
    light notify(note);
  }
}

function get_defined_value(value_array) {
  foreach(value in value_array) {
    if(isDefined(value)) {
      return value;
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
  }
}

function script_delay2() {
  if(isDefined(self.script_delay2_min) && isDefined(self.script_delay2_max)) {
    wait randomfloatrange(self.script_wait2_min, self.script_delay2_max);
    return;
  }

  if(isDefined(self.script_delay2)) {
    wait self.script_delay2;
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

function function_97b058da0ce47fcd(trigger) {
  trigger endon("\x1e\xfd\xd1\xa2\a");
  lights = getEntArray(trigger.target, #targetname);

  foreach(light in lights) {
    light.og_intensity = light getlightintensity();
    light setlightintensity(0);
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(light in lights) {
      light setlightintensity(light.og_intensity);
    }

    while(other istouching(trigger)) {
      wait 0.1;
    }

    foreach(light in lights) {
      light setlightintensity(0);
    }
  }
}

function light_debug_thread() {
  lights = getEntArray("\x02\x7f\xe0\v\xf3\xc3 \xb8\x1a\xd5", #classname);
  lights = utility::array_combine(getEntArray("6\xc7\xefqVe\xfa\x94\x145", #classname), lights);

  while(true) {
    clearundefined = 0;

    foreach(light in lights) {
      if(isDefined(light)) {
        light light_debug_draw();
        continue;
      }

      clearundefined = 1;
    }

    if(clearundefined) {
      lights = utility::array_removeundefined(lights);
    }

    waitframe();
  }
}

function light_debug_draw() {
  if(distancesquared(self.origin, level.player.origin) < 2000) {
    return;
  }

  light_debug_print3d("\xb3\x93\x8b5A\xdb\x0eV,\xeb%" + self getlightintensity());
}

function light_debug_print3d(msg) {
  if(!isDefined(msg)) {
    return;
  }

  print3d(self.origin, msg, (1, 1, 1), 0.8, 0.5);
}

function init_light_generic_iw7(intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, start_running, only_init) {
  if(isDefined(self.script_type)) {
    return;
  }

  wait 0.05;
  self.intensity_01 = get_defined_value([self.script_intensity_01, intensity_01, self getlightintensity()]);
  self.color_01 = get_defined_value([self.script_color_01, color_01, self getlightcolor()]);
  self.intensity_02 = get_defined_value([self.script_intensity_02, intensity_02, 0]);
  self.color_02 = get_defined_value([self.script_color_02, color_02, (0, 0, 0)]);
  self.notify_start = get_defined_value([self.script_light_startnotify, notify_start]);
  self.notify_stop = get_defined_value([self.script_light_stopnotify, notify_stop]);
  self.start_running = get_defined_value([self.script_startrunning, start_running]);
  self.light_type = get_defined_value([self.script_type, "RF\x9e\xe1\xc4\x1f\xe7"]);
  self.delay_start = issubstr(self.light_type, "O\f\xf4?\x94\xb3LM\xeau");

  if(!utility::ent_flag_exist("\xaa\xb40w\x14\x96\xfbl")) {
    utility::ent_flag_init("\xaa\xb40w\x14\x96\xfbl");
  }

  self.lit_models = [];
  self.unlit_models = [];
  self.linked_lights = [];
  self.triggers = [];
  ents = utility::get_linked_ents();

  foreach(ent in ents) {
    if(is_light_entity(ent)) {
      self.linked_lights[self.linked_lights.size] = ent;
      continue;
    }

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "\xb8\"") {
      self.lit_models[self.lit_models.size] = ent;
      continue;
    }

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "\xf8\x88m") {
      self.unlit_models[self.unlit_models.size] = ent;
      continue;
    }

    if(issubstr(ent.classname, "\x91`\xb1\xe7T\x97>")) {
      self.triggers[self.triggers.size] = ent;
    }
  }

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    set_lights_values(0, (0, 0, 0));
    return;
  }

  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");

  if(isDefined(self.target)) {
    self.scriptables = getscriptablearray(self.target, #targetname);
  }

  if(self.lit_models.size != 0 || self.unlit_models.size != 0) {
    assert(self.lit_models.size > 0, "<dev string:x24>" + self.origin + "<dev string:x39>");
    assert(self.unlit_models.size > 0, "<dev string:x24>" + self.origin + "<dev string:x98>");
  }

  utility::array_thread(self.triggers, &init_light_trig, self);

  foreach(model in self.lit_models) {
    if(isDefined(model.script_fxid)) {
      model.effect = utility::createoneshoteffect(model.script_fxid);
      mod_origin = (0, 0, 0);
      mod_angles = (0, 0, 0);

      if(isDefined(model.script_parameters)) {
        tokens = strtok(model.script_parameters, "\xf8\x01");
        assert(tokens.size >= 3, "<dev string:xf8>");
        mod_origin = (float(tokens[0]), float(tokens[1]), float(tokens[2]));

        if(tokens.size >= 6) {
          mod_angles = (float(tokens[3]), float(tokens[4]), float(tokens[5]));
        }
      }

      model.effect createfx::set_origin_and_angles(model.origin + mod_origin, model.angles + mod_angles);
    }
  }

  self.init_complete = 1;
  self notify("\xb5VA)\x84f=L\xb1{\x16\xf0t-\x16,\x89\xaf0!\xf7\x8a\x19#\xccn");

  if(isDefined(only_init) && only_init) {
    return;
  }

  if(isDefined(self.notify_start) || isDefined(self.notify_stop) || self.triggers.size > 0) {
    thread light_toggle_loop();
  }
}

function init_light_destructable() {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7();
}

function light_toggle_loop() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  self endon("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off();
  }

  while(true) {
    if(!utility::ent_flag("\xaa\xb40w\x14\x96\xfbl")) {
      level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_start, self.notify_start);
      utility::script_delay();

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

    level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_stop, self.notify_stop);
    utility::script_delay();

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

function init_light_flicker(intensity_01, color_01, wait_01_min, wait_01_max, intensity_02, color_02, wait_02_min, wait_02_max, speed_scale, notify_start, notify_stop, start_running, light_type, on_off_time, only_init) {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7(intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, start_running, 1);

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    return;
  }

  make_light_flicker(wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time);

  if(isDefined(only_init) && only_init) {
    return;
  }

  thread start_light_flicker();
}

function make_light_flicker(wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time) {
  init_light_type(light_type);
  self.speed_scale = get_defined_value([self.script_speed_scale, speed_scale, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, on_off_time, 3]) / self.speed_scale, 0.25);

  if(isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max)) {
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  } else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, wait_01_min, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, wait_01_max, 0.1]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      max = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = max;

      iprintln("<dev string:x149>" + self.origin + "<dev string:x156>");
    }
  }

  if(isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max)) {
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
    return;
  }

  self.wait_02_min = max(get_defined_value([self.script_wait_02_min, wait_02_min, 0.05]) / self.speed_scale, 0.05);
  self.wait_02_max = max(get_defined_value([self.script_wait_02_max, wait_02_max, 0.75]) / self.speed_scale, 0.1);

  if(self.wait_02_min > self.wait_02_max) {
    max = self.wait_02_max;
    self.wait_02_max = self.wait_02_min;
    self.wait_02_min = max;

    iprintln("<dev string:x149>" + self.origin + "<dev string:x1ae>");
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  self endon("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    while(true) {
      utility::script_delay();

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
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  self endon("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  while(true) {
    if(!utility::ent_flag("\xaa\xb40w\x14\x96\xfbl") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
      level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_start, self.notify_start);
    }

    utility::script_delay();

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

    if(self.type_on && !utility::ent_flag("\xaa\xb40w\x14\x96\xfbl")) {
      childthread light_flicker_proc(1, self.random_intensity_on);

      if(self.static_time) {
        wait self.on_off_time;
      } else {
        wait randomfloat(self.on_off_time);
      }

      self notify("w(n\x17Y\x0em\x86\xad\xea\x1e\x12");
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }

    if(!self.type_run) {
      level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_stop, self.notify_stop);
    } else {
      light_flicker_proc(1);
    }

    if(self.type_off) {
      childthread light_flicker_proc(1, self.random_intensity_off);

      if(self.static_time) {
        wait self.on_off_time;
      } else {
        wait randomfloat(self.on_off_time);
      }

      self notify("w(n\x17Y\x0em\x86\xad\xea\x1e\x12");
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

function light_flicker_proc(start_now, random_intensity) {
  self notify("w(n\x17Y\x0em\x86\xad\xea\x1e\x12");
  self endon("w(n\x17Y\x0em\x86\xad\xea\x1e\x12");

  if(isDefined(self.trig_notify_stop)) {
    level endon(self.trig_notify_stop);
  }

  if(isDefined(self.notify_stop)) {
    level endon(self.notify_stop);
  }

  if(!isDefined(start_now) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
    level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_start, self.notify_start);
  }

  while(true) {
    light_turn_on(random_intensity);

    if(isDefined(self.hi_wait)) {
      wait self.hi_wait;
    } else {
      wait randomfloatrange(self.wait_01_min, self.wait_01_max);
    }

    light_turn_off(random_intensity);

    if(isDefined(self.lo_wait)) {
      wait self.lo_wait;
      continue;
    }

    wait randomfloatrange(self.wait_02_min, self.wait_02_max);
  }
}

function init_light_pulse_iw7(intensity_01, color_01, wait_01_min, wait_01_max, intensity_02, color_02, wait_02_min, wait_02_max, speed_scale, notify_start, notify_stop, start_running, light_type, on_off_time, only_init) {
  if(isDefined(self.script_type)) {
    return;
  }

  init_light_generic_iw7(intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, undefined, 1);

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    return;
  }

  make_light_pulse(wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time, start_running);

  if(isDefined(only_init) && only_init) {
    return;
  }

  thread start_light_pulse();
}

function make_light_pulse(wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time, start_running) {
  self.start_running = get_defined_value([self.script_startrunning, start_running, 1]);
  init_light_type(light_type);
  self.speed_scale = get_defined_value([self.script_speed_scale, speed_scale, 1]);
  self.on_off_time = max(get_defined_value([self.script_duration, on_off_time, 3]) / self.speed_scale, 3);

  if(isDefined(self.script_wait_01_min) && !isDefined(self.script_wait_01_max) || !isDefined(self.script_wait_01_min) && isDefined(self.script_wait_01_max)) {
    self.hi_wait = max(get_defined_value([self.script_wait_01_min, self.script_wait_01_max]) / self.speed_scale, 0.05);
  } else {
    self.wait_01_min = max(get_defined_value([self.script_wait_01_min, wait_01_min, 0.05]) / self.speed_scale, 0.05);
    self.wait_01_max = max(get_defined_value([self.script_wait_01_max, wait_01_max, 0.5]) / self.speed_scale, 0.1);

    if(self.wait_01_min > self.wait_01_max) {
      max = self.wait_01_max;
      self.wait_01_max = self.wait_01_min;
      self.wait_01_min = max;

      iprintln("<dev string:x149>" + self.origin + "<dev string:x156>");
    }
  }

  if(isDefined(self.script_wait_02_min) && !isDefined(self.script_wait_02_max) || !isDefined(self.script_wait_02_min) && isDefined(self.script_wait_02_max)) {
    self.lo_wait = max(get_defined_value([self.script_wait_02_min, self.script_wait_02_max]) / self.speed_scale, 0.05);
    steps = int(self.lo_wait * 20);
    self.step_inc = 2 / steps;
    self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / steps;
    return;
  }

  self.wait_02_min = max(get_defined_value([self.script_wait_02_min, wait_02_min, 0.25]) / self.speed_scale, 0.05);
  self.wait_02_max = max(get_defined_value([self.script_wait_02_max, wait_02_max, 0.75]) / self.speed_scale, 0.1);

  if(self.wait_02_min > self.wait_02_max) {
    max = self.wait_02_max;
    self.wait_02_max = self.wait_02_min;
    self.wait_02_min = max;

    iprintln("<dev string:x149>" + self.origin + "<dev string:x1ae>");
  }

  steps = int(self.wait_02_max * 20);
  self.step_inc = 2 / steps;
  self.intensity_inc = 2 * (self.intensity_01 - self.intensity_02) / steps;
}

function start_light_pulse() {
  if(self.type_on || self.type_off) {
    thread light_pulse_on_off_loop();
    return;
  }

  thread light_pulse_loop();
}

function light_pulse_loop() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  self endon("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  if(isDefined(self.notify_start) && isDefined(self.notify_stop)) {
    while(true) {
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  self endon("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");

  if(isDefined(self.start_running) && self.start_running) {
    light_turn_on();
  } else if(isDefined(self.notify_start) || isDefined(self.trig_notify_start)) {
    light_turn_off(undefined, self.two_color);
  }

  while(true) {
    if(!utility::ent_flag("\xaa\xb40w\x14\x96\xfbl") && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
      level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_start, self.notify_start);
    }

    utility::script_delay();

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

    if(self.type_on && !utility::ent_flag("\xaa\xb40w\x14\x96\xfbl")) {
      childthread light_pulse_proc_iw7(1);

      if(self.static_time) {
        wait self.on_off_time;
      } else {
        wait randomfloat(self.on_off_time);
      }

      self notify("\x9b\xe8\xed8\xd7pWc\xcd\xac");
    }

    light_turn_on();

    if(!isDefined(self.notify_start) && !isDefined(self.trig_notify_start)) {
      return;
    }

    if(!self.type_run) {
      level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_stop, self.notify_stop);
    } else {
      light_pulse_proc_iw7(1);
    }

    if(self.type_off) {
      childthread light_pulse_proc_iw7(1);

      if(self.static_time) {
        wait self.on_off_time;
      } else {
        wait randomfloat(self.on_off_time);
      }

      self notify("w(n\x17Y\x0em\x86\xad\xea\x1e\x12");
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

function light_pulse_proc_iw7(start_now) {
  self notify("\x9b\xe8\xed8\xd7pWc\xcd\xac");
  self endon("\x9b\xe8\xed8\xd7pWc\xcd\xac");

  if(isDefined(self.trig_notify_stop)) {
    level endon(self.trig_notify_stop);
  }

  if(isDefined(self.notify_stop)) {
    level endon(self.notify_stop);
  }

  if(!isDefined(start_now) && (isDefined(self.trig_notify_start) || isDefined(self.notify_start))) {
    level utility::waittill_any("\xe1\x92a\x9e\xe7{!S\xb5\xd1\f\x8d\xff", self.trig_notify_start, self.notify_start);
  }

  while(true) {
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

function init_light_trig(light) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "\x04M\xed\xab") {
    note = "\x01\xc1\v\x1e\xf8h]Y\xdc\xb7|\x96ls|\x97\xf5+";
    light.trig_notify_stop = note;
  } else {
    note = "qK\a\xf5>]e\xd4\xe7\xd8IO\xc2e+y\x18\x1b\xd4";
    light.trig_notify_start = note;
  }

  self waittill("\x91`\xb1\xe7T\x97>");

  if(isDefined(light)) {
    light notify(note);
  }
}

function light_turn_on(random_intensity) {
  utility::ent_flag_set("\xaa\xb40w\x14\x96\xfbl");

  if(isDefined(random_intensity) && random_intensity && self.intensity_01 > 0) {
    set_lights_values(randomfloatrange(self.intensity_01 * 0.25, self.intensity_01), self.color_01);
  } else {
    set_lights_values(self.intensity_01, self.color_01);
  }

  if(isDefined(self.script_prefab_exploder)) {
    utility::exploder(self.script_prefab_exploder);
  }

  foreach(scriptable in self.scriptables) {
    scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
  }

  utility::array_call(self.unlit_models, &hide);

  foreach(model in self.lit_models) {
    model show();

    if(isDefined(model.effect)) {
      model.effect utility_sp::restarteffect();
    }
  }
}

function light_turn_off(random_intensity, two_color) {
  utility::ent_flag_clear("\xaa\xb40w\x14\x96\xfbl");

  if(isDefined(two_color) && two_color) {
    set_lights_values(0, (0, 0, 0));
  } else if(isDefined(random_intensity) && random_intensity && self.intensity_02 > 0) {
    set_lights_values(randomfloatrange(self.intensity_02 * 0.25, self.intensity_02), self.color_02);
  } else {
    set_lights_values(self.intensity_02, self.color_02);
  }

  if(isDefined(self.script_prefab_exploder)) {
    utility::stop_exploder(self.script_prefab_exploder);
  }

  foreach(scriptable in self.scriptables) {
    scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xf8\x88m");
  }

  foreach(model in self.lit_models) {
    model hide();

    if(isDefined(model.effect)) {
      model.effect utility::pauseeffect();
    }
  }

  utility::array_call(self.unlit_models, &show);
}

function light_pulse(pulse_time) {
  utility::ent_flag_clear("\xaa\xb40w\x14\x96\xfbl");
  steps = int(pulse_time / 0.1);

  for(i = 1; i <= steps; i++) {
    new_intensity = max(0, self.intensity_01 - self.intensity_inc * i);
    new_color = vectorlerp(self.color_01, self.color_02, self.step_inc * i);
    set_lights_values(new_intensity, new_color);
    wait 0.05;
  }

  for(i = steps; i > 0; i--) {
    new_intensity = max(0, self.intensity_01 - self.intensity_inc * i);
    new_color = vectorlerp(self.color_01, self.color_02, self.step_inc * i);
    set_lights_values(new_intensity, new_color);
    wait 0.05;
  }
}

function lights_turn_on(name, key, intensity, color, kill_loops) {
  lights = getEntArray(name, key);
  utility::array_thread(lights, &turn_on_proc, intensity, color, kill_loops);
}

function turn_on_proc(intensity, color, kill_loops) {
  if(!isDefined(self.init_complete)) {
    self waittill("\xb5VA)\x84f=L\xb1{\x16\xf0t-\x16,\x89\xaf0!\xf7\x8a\x19#\xccn");
  }

  if(isDefined(kill_loops) && kill_loops) {
    self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  }

  my_intensity = self.intensity_01;
  my_color = self.color_01;

  if(isDefined(intensity)) {
    my_intensity = intensity;
  }

  if(isDefined(color)) {
    my_color = color;
  }

  utility::ent_flag_set("\xaa\xb40w\x14\x96\xfbl");
  set_lights_values(my_intensity, my_color);

  foreach(scriptable in self.scriptables) {
    scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
  }

  utility::array_call(self.unlit_models, &hide);

  foreach(model in self.lit_models) {
    model show();

    if(isDefined(model.effect)) {
      model.effect utility_sp::restarteffect();
    }
  }
}

function lights_turn_off(name, key, intensity, color, kill_loops) {
  lights = getEntArray(name, key);
  utility::array_thread(lights, &turn_off_proc, intensity, color, kill_loops);
}

function turn_off_proc(intensity, color, kill_loops) {
  if(!isDefined(self.init_complete)) {
    self waittill("\xb5VA)\x84f=L\xb1{\x16\xf0t-\x16,\x89\xaf0!\xf7\x8a\x19#\xccn");
  }

  if(isDefined(kill_loops) && kill_loops) {
    self notify("\xcb)\a\x17\x86K\xdd\xafE\xa0\t\xe68%_\x18!\x03B\xc6yi");
  }

  my_intensity = self.intensity_02;
  my_color = self.color_02;

  if(isDefined(intensity)) {
    my_intensity = intensity;
  }

  if(isDefined(color)) {
    my_color = color;
  }

  utility::ent_flag_clear("\xaa\xb40w\x14\x96\xfbl");
  set_lights_values(my_intensity, my_color);

  foreach(scriptable in self.scriptables) {
    scriptable setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xf8\x88m");
  }

  foreach(model in self.lit_models) {
    model hide();

    if(isDefined(model.effect)) {
      model.effect utility::pauseeffect();
    }
  }

  utility::array_call(self.unlit_models, &show);
}

function set_lights_values(intensity, color) {
  if(isDefined(intensity)) {
    intensity = max(0, intensity);
  }

  if(isDefined(color)) {
    color = (max(0, color[0]), max(0, color[1]), max(0, color[2]));
  }

  if(isDefined(intensity)) {
    self setlightintensity(intensity);

    if(isDefined(self.linked_lights)) {
      utility::array_call(self.linked_lights, &setlightintensity, intensity);
    }
  }

  if(isDefined(color)) {
    self setlightcolor(color);

    if(isDefined(self.linked_lights)) {
      utility::array_call(self.linked_lights, &setlightcolor, color);
    }
  }
}

function is_light_entity(ent) {
  return ent.classname == "\x02\x7f\xe0\v\xf3\xc3 \xb8\x1a\xd5" || ent.classname == "6\xc7\xefqVe\xfa\x94\x145" || ent.classname == "T\xf2\xa4:K";
}

function init_light_type(light_type) {
  self.light_type = get_defined_value([self.script_type, light_type, "RF\x9e\xe1\xc4\x1f\xe7"]);
  self.two_color = issubstr(self.light_type, "\xb5i\xc4\xbc\xe1\xfc\xcc\xb7\x83");
  self.type_on = issubstr(self.light_type, "\xb8\"");
  self.type_off = issubstr(self.light_type, "\xf8\x88m");
  self.type_run = issubstr(self.light_type, "\x18R\xd0s\xc6Kd");
  self.static_time = issubstr(self.light_type, "\xfdU\x93\x11\xd8");
  self.delay_start = issubstr(self.light_type, "O\f\xf4?\x94\xb3LM\xeau");
  self.random_intensity_on = issubstr(self.light_type, "\xabm9\xc5=,N\xf8\xf0u\\\x1eXZ\xae\\0\xb6;");
  self.random_intensity_off = issubstr(self.light_type, "\xaaH\xed\xe44\x9e\xc4\x02\xb2\xf4|\xa1\xf5\xde0\xaa{\xb0\xce\x84");
}

function generic_pulsing() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    self setlightintensity(0);
    return;
  }

  on = self getlightintensity();
  off = 0.05;
  curr = on;
  transition_on = 0.3;
  transition_off = 0.6;
  increment_on = (on - off) / transition_on / 0.05;
  increment_off = (on - off) / transition_off / 0.05;

  for(;;) {
    time = 0;

    while(time < transition_off) {
      curr -= increment_off;
      curr = clamp(curr, 0, 100);
      self setlightintensity(curr);
      time += 0.05;
      wait 0.05;
    }

    wait 1;
    time = 0;

    while(time < transition_on) {
      curr += increment_on;
      curr = clamp(curr, 0, 100);
      self setlightintensity(curr);
      time += 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

function generic_double_strobe() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    self setlightintensity(0);
    return;
  }

  on = self getlightintensity();
  off = 0.05;
  linked_models = 0;
  lit_model = undefined;
  unlit_model = undefined;
  linked_lights = 0;
  var_cd96a77f83a0155f = [];

  if(isDefined(self.script_noteworthy)) {
    linked_things = getEntArray(self.script_noteworthy, #targetname);

    for(i = 0; i < linked_things.size; i++) {
      if(is_light_entity(linked_things[i])) {
        linked_lights = 1;
        var_cd96a77f83a0155f[var_cd96a77f83a0155f.size] = linked_things[i];
      }

      if(linked_things[i].classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
        lit_model = linked_things[i];
        unlit_model = getEnt(lit_model.target, #targetname);
        linked_models = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(off);

    if(linked_models) {
      lit_model hide();
      unlit_model show();
    }

    wait 0.8;
    self setlightintensity(on);

    if(linked_models) {
      lit_model show();
      unlit_model hide();
    }

    wait 0.1;
    self setlightintensity(off);

    if(linked_models) {
      lit_model hide();
      unlit_model show();
    }

    wait 0.12;
    self setlightintensity(on);

    if(linked_models) {
      lit_model show();
      unlit_model hide();
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

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    self setlightintensity(0);
    return;
  }

  full = self getlightintensity();

  for(old_intensity = full;; old_intensity = intensity) {
    intensity = randomfloatrange(full * 0.7, full * 1.2);
    timer = randomfloatrange(0.3, 0.6);
    timer *= 20;

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * i / timer + old_intensity * (timer - i) / timer;
      self setlightintensity(new_intensity);
      wait 0.05;
    }
  }
}

function cine_tank_fire() {
  if(isDefined(self.script_type)) {
    return;
  }

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "\x87") {
    self setlightintensity(0);
    return;
  }

  full = self getlightintensity();

  for(old_intensity = full;; old_intensity = intensity) {
    intensity = randomfloatrange(full * 0.7, full * 1.3);
    timer = randomfloatrange(0.1, 0.4);
    timer *= 20;

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * i / timer + old_intensity * (timer - i) / timer;
      self setlightintensity(new_intensity);
      wait 0.05;
    }
  }
}

function strobelight(intensity0, intensity1, period, kill_flag) {
  frequency = 360 / period;
  time = 0;

  while(true) {
    interpolation = sin(time * frequency) * 0.5 + 0.5;
    self setlightintensity(intensity0 + (intensity1 - intensity0) * interpolation);
    wait 0.05;
    time += 0.05;

    if(time > period) {
      time -= period;
    }

    if(isDefined(kill_flag)) {
      if(utility::flag(kill_flag)) {
        return;
      }
    }
  }
}

function changelightcolorto(targetcolor, totaltime, acceltime, deceltime) {
  if(!isDefined(acceltime)) {
    acceltime = 0;
  }

  if(!isDefined(deceltime)) {
    deceltime = 0;
  }

  thread changelightcolortoworkerthread(targetcolor, totaltime, acceltime, deceltime);
}

function changelightcolortoworkerthread(targetcolor, totaltime, acceltime, deceltime) {
  startcolor = self getlightcolor();
  timefactor = 1 / (totaltime * 2 - acceltime + deceltime);
  time = 0;

  if(time < acceltime) {
    halfrate = timefactor / acceltime;

    while(time < acceltime) {
      fraction = halfrate * time * time;
      self setlightcolor(vectorlerp(startcolor, targetcolor, fraction));
      wait 0.05;
      time += 0.05;
    }
  }

  while(time < totaltime - deceltime) {
    fraction = timefactor * (2 * time - acceltime);
    self setlightcolor(vectorlerp(startcolor, targetcolor, fraction));
    wait 0.05;
    time += 0.05;
  }

  time = totaltime - time;

  if(time > 0) {
    halfrate = timefactor / deceltime;

    while(time > 0) {
      fraction = 1 - halfrate * time * time;
      self setlightcolor(vectorlerp(startcolor, targetcolor, fraction));
      wait 0.05;
      time -= 0.05;
    }
  }

  self setlightcolor(targetcolor);
}

function flickerlightintensity(mindelay, maxdelay) {
  on = self getlightintensity();
  off = 0;
  curr = on;
  num = 0;

  for(;;) {
    for(num = randomintrange(1, 10); num; num--) {
      wait randomfloatrange(0.05, 0.1);

      if(curr > 0.2) {
        curr = randomfloatrange(0, 0.3);
      } else {
        curr = on;
      }

      self setlightintensity(curr);
    }

    self setlightintensity(on);
    wait randomfloatrange(mindelay, maxdelay);
  }
}

function sun_shadow_trigger(trigger) {
  duration = 1;

  if(isDefined(trigger.script_duration)) {
    duration = trigger.script_duration;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    trigger set_sun_shadow_params(duration);
  }
}

function set_sun_shadow_params(duration) {
  sunenable = getdvarint(@ "sm_sunenable", 1);
  sunshadowscale = getdvarfloat(@ "sm_sunshadowscale", 1);
  sunsamplesizenear = getdvarfloat(@ "sm_sunsamplesizenear", 0.25);
  qualityspotshadow = getdvarfloat(@ "sm_qualityspotshadow", 1);

  if(isDefined(self.script_sunenable)) {
    sunenable = self.script_sunenable;
  }

  if(isDefined(self.script_sunshadowscale)) {
    sunshadowscale = self.script_sunshadowscale;
  }

  if(isDefined(self.script_sunsamplesizenear)) {
    sunsamplesizenear = self.script_sunsamplesizenear;
  }

  sunsamplesizenear = min(max(0.016, sunsamplesizenear), 32);

  if(isDefined(self.script_qualityspotshadow)) {
    qualityspotshadow = self.script_qualityspotshadow;
  }

  curr_sunenable = getdvarint(@ "sm_sunenable", 1);
  curr_sunshadowscale = getdvarfloat(@ "sm_sunshadowscale", 1);
  curr_qualityspotshadow = getdvarint(@ "sm_qualityspotshadow", 1);
  setsaveddvar(@ "sm_sunenable", sunenable);
  setsaveddvar(@ "sm_sunshadowscale", sunshadowscale);
  setsaveddvar(@ "sm_qualityspotshadow", qualityspotshadow);
  lerp_sunsamplesizenear_overtime(sunsamplesizenear, duration);
}

function lerp_sunsamplesizenear_overtime(value, time) {
  level notify("r\xdf\x88U\x92\xd6\xc0\xadl\xa3,\x02\xba\xa8q\xea\v~\x94\xf7\f\f\xe0\xad\xed\xe3");
  level endon("r\xdf\x88U\x92\xd6\xc0\xadl\xa3,\x02\xba\xa8q\xea\v~\x94\xf7\f\f\xe0\xad\xed\xe3");
  old_value = getdvarfloat(@ "sm_sunsamplesizenear", 0.25);

  if(value == old_value) {
    return;
  }

  diff = value - old_value;
  times = time / 0.05;

  if(times > 0) {
    d = diff / times;
    v = old_value;

    for(i = 0; i < times; i++) {
      v += d;
      setsaveddvar(@ "sm_sunsamplesizenear", v);
      wait 0.05;
    }
  }

  setsaveddvar(@ "sm_sunsamplesizenear", value);
}

function lerp_intensity(intensity, time) {
  steps = int(time * 20);
  curr = self getlightintensity();
  inc = (intensity - curr) / steps;

  for(i = 0; i < steps; i++) {
    thread handle_linked_ents(intensity);
    self setlightintensity(curr + i * inc);
    wait 0.05;
  }

  lights[0] = self;

  if(isDefined(self.linked_lights)) {
    lights = utility::array_combine(lights, self.linked_lights);
  }

  foreach(light in lights) {
    light thread handle_linked_ents(intensity);
    light setlightintensity(intensity);
  }
}

function handle_linked_ents(intensity) {
  if(isDefined(self.script_threshold)) {
    is_on = intensity > self.script_threshold;

    foreach(ent in self.lit_models) {
      if(is_on && !ent.visible) {
        ent.visible = is_on;
        ent show();

        if(isDefined(ent.effect)) {
          ent.effect thread utility_sp::restarteffect();
        }

        continue;
      }

      if(!is_on && ent.visible) {
        ent.visible = is_on;
        ent hide();

        if(isDefined(ent.effect)) {
          ent.effect thread utility::pauseeffect();
        }
      }
    }

    foreach(ent in self.unlit_models) {
      if(!is_on && !ent.visible) {
        ent.visible = 1;
        ent show();
        continue;
      }

      if(is_on && ent.visible) {
        ent.visible = 0;
        ent hide();
      }
    }
  }
}

function light_fade(start_intensity, end_intensity, var_95b21d7890d6c243) {
  lasttimestamp = gettime();
  t = 0;

  while(t <= var_95b21d7890d6c243) {
    t += 0.05;
    var_dbfe17cd204a7df4 = math::lerp(start_intensity, end_intensity, t / var_95b21d7890d6c243);
    self setlightintensity(var_dbfe17cd204a7df4);
    waitframe();
  }

  self setlightintensity(end_intensity);
}

function function_bb927983844de96f(h, s, v) {
  if(s == 0) {
    return (v, v, v);
  }

  h = utility::mod(h, 360);
  hue_sector = floor(h / 60);
  var_e2dc6eb034d762f = h / 60 - hue_sector;
  p = v * (1 - s);
  q = v * (1 - s * var_e2dc6eb034d762f);
  t = v * (1 - s * (1 - var_e2dc6eb034d762f));

  if(hue_sector == 0) {
    return (v, t, p);
  } else if(hue_sector == 1) {
    return (q, v, p);
  } else if(hue_sector == 2) {
    return (p, v, t);
  } else if(hue_sector == 3) {
    return (p, q, v);
  } else if(hue_sector == 4) {
    return (t, p, v);
  } else if(hue_sector == 5) {
    return (v, p, q);
  }

  return (v, p, q);
}