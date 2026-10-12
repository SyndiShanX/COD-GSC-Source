/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\lighting.gsc
***********************************************/

#using scripts\common\exploder;
#using scripts\common\hud_util;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace lighting;

function is_light() {
  if(self.classname == "light" || self.classname == "light_omni" || self.classname == "light_spot") {
    return 1;
  }

  return 0;
}

function function_70a9f70afd49dead(time, endintensity) {
  self notify("stop intensity lerp");
  self endon("stop intensity lerp");
  self endon("death");
  startintensity = self getlightintensity();
  wait 0.05;
  t = 0.05;

  while(t <= time) {
    self setlightintensity(math::lerp(startintensity, endintensity, t / time));
    wait 0.05;
    t += 0.05;
  }

  self setlightintensity(endintensity);
}

function function_c690755ae1e4d083(time, endcolor) {
  self notify("stop color lerp");
  self endon("stop color lerp");
  self endon("death");
  startcolor = self getlightcolor();
  wait 0.05;
  t = 0.05;

  while(t <= time) {
    self setlightcolor(vectorlerp(startcolor, endcolor, t / time));
    wait 0.05;
    t += 0.05;
  }

  self setlightcolor(endcolor);
}

function function_8b766b3f91e671e2(time, endradius) {
  self notify("stop radius lerp");
  self endon("stop radius lerp");
  self endon("death");
  startradius = self getlightradius();
  wait 0.05;
  t = 0.05;

  while(t <= time) {
    self setlightradius(math::lerp(startradius, endradius, t / time));
    wait 0.05;
    t += 0.05;
  }

  self setlightradius(endradius);
}

function private function_90d577e206f6609() {
  if(!istrue(level.var_f86dca03b4e10a79)) {
    self dontinterpolate();
  }
}

function flicker_light(min_delay, max_delay, var_327a4187018839, var_894b79fbcc60eeef, min_time, max_time, lerp_amount, min_num, max_num, min_pause, max_pause, pause_scale, intensity) {
  if(!isDefined(self.islightflickering)) {
    self.islightflickering = 1;
  }

  if(!isDefined(self.islightflickerpaused)) {
    self.islightflickerpaused = 0;
  }

  self endon("kill_flicker");
  self endon("death");

  if(!isDefined(min_delay)) {
    min_delay = 0.1;
  }

  if(!isDefined(max_delay)) {
    max_delay = 1;
  }

  if(!isDefined(var_327a4187018839)) {
    var_327a4187018839 = 0;
  }

  if(!isDefined(var_894b79fbcc60eeef)) {
    var_894b79fbcc60eeef = 0.5;
  }

  if(!isDefined(min_time)) {
    min_time = 0.1;
  }

  if(!isDefined(max_time)) {
    max_time = 0.2;
  }

  if(!isDefined(lerp_amount)) {
    lerp_amount = 0;
  }

  if(!isDefined(min_num)) {
    min_num = 1;
  }

  if(!isDefined(max_num)) {
    max_num = 1;
  }

  if(!isDefined(min_pause)) {
    min_pause = 0;
  }

  if(!isDefined(max_pause)) {
    max_pause = 0;
  }

  if(!isDefined(pause_scale)) {
    pause_scale = 1;
  }

  if(isDefined(intensity)) {
    self setlightintensity(intensity);
  } else {
    intensity = self getlightintensity();
  }

  min_intensity = intensity * var_327a4187018839;
  max_intensity = intensity * var_894b79fbcc60eeef;

  if(min_num < max_num) {
    num_flicker = randomintrange(min_num, max_num);
  } else {
    num_flicker = max_num;
  }

  if(min_pause < max_pause) {
    pause_time = randomfloatrange(min_pause, max_pause);
  } else {
    pause_time = max_pause;
  }

  for(;;) {
    for(z = 0; z < num_flicker; z++) {
      if(min_intensity < max_intensity) {
        flicker_intensity = randomfloatrange(min_intensity, max_intensity);
      } else {
        flicker_intensity = max_intensity;
      }

      if(min_delay < max_delay) {
        d_time = randomfloatrange(min_delay, max_delay);
      } else {
        d_time = max_delay;
      }

      if(min_time < max_time) {
        f_time = randomfloatrange(min_time, max_time);
      } else {
        f_time = max_time;
      }

      while(self.islightflickerpaused) {
        wait 0.05;
      }

      if(lerp_amount > 0 && lerp_amount <= 1) {
        if(d_time > 0) {
          l_time = f_time / 2 * lerp_amount;
          t = 0;

          while(t <= l_time) {
            self setlightintensity(math::lerp(intensity, flicker_intensity, t / l_time));
            wait 0.05;
            t += 0.05;
          }

          self setlightintensity(flicker_intensity);
          wait f_time - f_time * lerp_amount;
          t = 0;

          while(t <= l_time) {
            self setlightintensity(math::lerp(flicker_intensity, intensity, t / l_time));
            wait 0.05;
            t += 0.05;
          }

          self setlightintensity(intensity);
        } else {
          l_time = f_time * lerp_amount;
          t = 0;

          while(t <= l_time) {
            self setlightintensity(math::lerp(intensity, flicker_intensity, t / l_time));
            wait 0.05;
            t += 0.05;
          }

          self setlightintensity(flicker_intensity);
          wait f_time - f_time * lerp_amount;
        }
      } else {
        self setlightintensity(flicker_intensity);
        wait f_time;
        self setlightintensity(intensity);
      }

      wait d_time;
    }

    self setlightintensity(intensity * pause_scale);

    if(min_pause < max_pause) {
      pause_time = randomfloatrange(min_pause, max_pause);
    } else {
      pause_time = max_pause;
    }

    t = 0;

    while(t < pause_time) {
      while(self.islightflickerpaused) {
        wait 0.05;
      }

      wait 0.05;
      t += 0.05;
    }

    if(min_num < max_num) {
      num_flicker = randomintrange(min_num, max_num);
      continue;
    }

    num_flicker = max_num;
  }
}

function function_d688e745daa6f5d(min_time, max_time, var_327a4187018839, var_894b79fbcc60eeef, max_move, intensity) {
  self endon("kill_flicker");
  self endon("death");

  if(!isDefined(var_327a4187018839)) {
    var_327a4187018839 = 0.6;
  }

  if(!isDefined(var_894b79fbcc60eeef)) {
    var_894b79fbcc60eeef = 1.2;
  }

  if(!isDefined(min_time)) {
    min_time = 0.2;
  }

  if(!isDefined(max_time)) {
    max_time = 0.8;
  }

  if(!isDefined(max_move)) {
    max_move = 0;
  }

  if(isDefined(intensity)) {
    self setlightintensity(intensity);
  } else {
    intensity = self getlightintensity();
  }

  thread flicker_light(0, 0, var_327a4187018839, var_894b79fbcc60eeef, min_time, max_time, 0.5, undefined, undefined, undefined, undefined, undefined, intensity);

  if(max_move > 0) {
    start_origin = self.origin;

    while(true) {
      x = start_origin[0] + randomfloatrange(0 - max_move, max_move);
      y = start_origin[1] + randomfloatrange(0 - max_move, max_move);
      z = start_origin[2] + randomfloatrange(0 - max_move, max_move);
      move_time = randomfloatrange(0.1, 0.5);
      self moveTo((x, y, z), move_time, move_time * 0.25, move_time * 0.25);
      wait move_time;
    }
  }
}

function blink_light(on_time, off_time, lerp_amount, blink_num, pause, intensity) {
  if(!isDefined(on_time)) {
    on_time = 1;
  }

  if(!isDefined(off_time)) {
    off_time = 1;
  }

  if(!isDefined(lerp_amount)) {
    lerp_amount = 0;
  }

  if(!isDefined(blink_num)) {
    blink_num = 1;
  }

  if(!isDefined(pause)) {
    pause = 1;
  }

  if(isDefined(intensity)) {
    self setlightintensity(intensity);
  } else {
    intensity = self getlightintensity();
  }

  flicker_light(on_time, on_time, 0, 0, off_time, off_time, lerp_amount, blink_num, blink_num, pause, pause, 0, intensity);
}

function light_init() {
  if(!isDefined(level._light)) {
    level._light = spawnStruct();
    light_setup_common_dof_presets();
    light_setup_common_flickerlight_presets();
    light_message_init();
  }
}

function light_setup_common_flickerlight_presets() {
  create_flickerlight_preset("fire", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 8);
  create_flickerlight_preset("blue_fire", (0.445098, 0.62451, 0.972549), (0.05, 0.150451, 0.307843), 0.005, 0.2, 8);
  create_flickerlight_preset("white_fire", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 8);
  create_flickerlight_preset("white_fire_dim", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 0.5);
  create_flickerlight_preset("street_light", (0.972549, 0.972549, 0.972549), (0.572549, 0.572549, 0.572549), 0.005, 0.2, 8);
  create_flickerlight_preset("pulse", (0, 0, 0), (255, 107, 107), 0.2, 1, 8);
  create_flickerlight_preset("lightbulb", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 6);
  create_flickerlight_preset("fluorescent", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 7);
  create_flickerlight_preset("static_screen", (0.63, 0.72, 0.92), (0.4, 0.43, 0.48), 0.005, 0.2, 7);
  create_flickerlight_preset("sfb_fire", (1, 0.65, 0.8), (0.4, 0.24, 0.3), 0.005, 0.2, 8);
}

function create_flickerlight_preset(name, color0, color1, intensity, mindelay, maxdelay, maxmove) {
  if(!isDefined(level._light.flicker_motion_presets)) {
    level._light.flicker_motion_presets = [];
  }

  new_preset = spawnStruct();
  new_preset.color0 = color0;
  new_preset.color1 = color1;
  new_preset.intensity = intensity;
  new_preset.mindelay = mindelay;
  new_preset.maxdelay = maxdelay;
  new_preset.maxmove = maxmove;
  level._light.flicker_motion_presets[name] = new_preset;
}

function get_flickerlight_motion_preset(name) {
  if(isDefined(level._light.flicker_motion_presets) && isDefined(level._light.flicker_motion_presets[name])) {
    return level._light.flicker_motion_presets[name];
  }

  return undefined;
}

function play_flickerlight_preset(name, targetname, intensity_) {
  assert(isstring(name));
  assert(isstring(targetname));
  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x1c>" + name + "<dev string:x5a>" + targetname + "<dev string:x9f>");
    return;
  }

  preset = get_flickerlight_motion_preset(name);

  if(!isDefined(preset)) {
    println("<dev string:xa5>" + name + "<dev string:xd2>");
    return;
  }

  if(isDefined(intensity_)) {
    if(intensity_ < 0) {
      println("<dev string:x125>" + name + "<dev string:x146>");
      intensity_ = 0;
    }

    preset.intensity = intensity_;
  }

  foreach(ent in ents) {
    ent setlightintensity(preset.intensity);
    ent.islightflickering = 1;
    ent.islightflickerpaused = 0;
    ent thread dyn_motion_flickerlight(preset.color0, preset.color1, preset.intensity, preset.mindelay, preset.maxdelay, preset.maxmove);
    ent function_90d577e206f6609();
  }
}

function stop_flickerlight(name, targetname, intensity_, lerptime) {
  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x18c>" + name + "<dev string:x1b9>" + targetname + "<dev string:x9f>");
    return;
  }

  foreach(ent in ents) {
    if(!isDefined(ent.islightflickering)) {
      println("<dev string:x1ea>");
      return;
    }

    if(isDefined(intensity_)) {
      if(intensity_ < 0) {
        println("<dev string:x125>" + name + "<dev string:x146>");
        intensity_ = 0;
      }
    }

    if(!isDefined(intensity_)) {
      intensity_ = ent getlightintensity();
      ent.islightflickerpaused = 1;
    }

    if(isDefined(lerptime)) {
      if(intensity_) {
        thread lerp_spot_intensity(ent.targetname, lerptime, intensity_);
      } else {
        thread lerp_spot_intensity(ent.targetname, lerptime, 0);
      }
    } else {
      ent setlightintensity(intensity_);
    }

    ent notify("kill_flicker");
    ent.islightflickering = 0;

    if(default_to(lerptime, 0) <= 0) {
      ent function_90d577e206f6609();
    }
  }
}

function dyn_motion_flickerlight(color0, color1, intensity, mindelay, maxdelay, maxmove) {
  assert(isDefined(self.islightflickering));
  assert(isDefined(self.islightflickerpaused));
  self endon("kill_flicker");
  self endon("death");

  if(isDefined(color1)) {
    tocolor = color0;
  } else {
    self setlightcolor(color0);
  }

  self setlightintensity(intensity);
  min_delay = mindelay;
  max_delay = maxdelay;
  thread fire_flicker(min_delay, max_delay);
  original_origin = self.origin;
  random_x = maxmove;
  random_y = maxmove;
  random_z = maxmove;

  while(true) {
    delay = randomfloatrange(min_delay, max_delay);
    x = random_x * randomfloatrange(0.1, 1);
    y = random_y * randomfloatrange(0.1, 1);
    z = random_z * randomfloatrange(0.1, 1);
    new_position = original_origin + (x, y, z);
    self moveTo(new_position, delay);
    steps = int(delay / 0.1);

    if(isDefined(color1)) {
      for(i = 1; i <= steps; i++) {
        tocolor = vectorlerp(color0, color1, delay);
        self setlightcolor(tocolor);
      }

      wait 0.05;

      for(i = steps; i > 0; i--) {
        fromcolor = vectorlerp(color1, color0, delay);
        self setlightcolor(fromcolor);
      }

      wait 0.05;
    }

    wait delay;

    while(self.islightflickerpaused) {
      wait 0.05;
    }
  }
}

function fire_flicker(min_delay, max_delay) {
  assert(isDefined(self.islightflickering));
  assert(isDefined(self.islightflickerpaused));
  full = self getlightintensity();
  self endon("kill_flicker");
  self endon("death");

  for(old_intensity = full;; old_intensity = intensity) {
    intensity = randomfloatrange(full * 0.5, full * 1.2);
    timer = randomfloatrange(min_delay, max_delay);
    timer *= 0.75;

    while(self.islightflickerpaused) {
      wait 0.05;
    }

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * i / timer + old_intensity * (timer - i) / timer;
      self setlightintensity(new_intensity);
      wait 0.05;
    }
  }
}

function create_light_object(script_noteworthy, fxid) {
  light_object = spawnStruct();
  ents = getEntArray(script_noteworthy, "script_noteworthy");
  light_object.lightents = [];
  light_object.modelents = [];

  foreach(ent in ents) {
    if(ent.classname == "script_model") {
      light_object.modelents[light_object.modelents.size] = ent;
    }

    if(ent.classname == "light") {
      light_object.lightents[light_object.lightents.size] = ent;
    }
  }

  light_object.fxid = fxid;

  light_object.var_91064355da41c488 = 1;

  return light_object;
}

function light_object_set_intensity(intensity, color, is_on) {
  assert(isDefined(self.var_91064355da41c488));

  foreach(lightent in self.lightents) {
    lightent setlightintensity(intensity);
    lightent setlightcolor(color);
  }

  if(is_on && !isDefined(self.was_on)) {
    exploder(self.fxid);

    foreach(modelent in self.modelents) {
      modelent show();
    }

    self.was_on = 1;
    return;
  }

  if(isDefined(self.was_on) && !is_on) {
    stop_exploder(self.fxid);

    foreach(modelent in self.modelents) {
      modelent hide();
    }

    self.was_on = undefined;
  }
}

function flickering_light(light_object, off_color, off_intensity, on_color, on_intensity, min_delay, max_delay) {
  light_object endon("kill_flicker");
  light_object endon("death");
  var_ccfca9f4d7c3b55c = 0;
  delay = 0;

  for(;;) {
    var_b5e0c1d5d4da93 = var_ccfca9f4d7c3b55c;
    var_ccfca9f4d7c3b55c = randomfloat(1);

    if(min_delay != max_delay) {
      delay += randomfloatrange(min_delay, max_delay);
    } else {
      delay += max_delay;
    }

    if(delay == 0) {
      delay += 1e-07;
    }

    var_1110ee97f85f2c27 = (var_ccfca9f4d7c3b55c - var_b5e0c1d5d4da93) / delay;

    while(delay > 0) {}
  }
}

function perlin_flickering_light(light_object, off_color, off_intensity, on_color, on_intensity) {
  light_object endon("kill_flicker");
  light_object endon("death");
  base_frequency = 2;
  octaves = 3;
  var_e777d084f2b6407d = 5;

  for(;;) {}
}

function function_bf134e4c6c36436(name, minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause) {
  if(!isDefined(level._light.var_7946c098158094a8)) {
    level._light.var_7946c098158094a8 = [];
  }

  new_preset = spawnStruct();
  new_preset.minintensity = minintensity;
  new_preset.maxintensity = maxintensity;
  new_preset.mindelay = mindelay;
  new_preset.maxdelay = maxdelay;
  new_preset.minflicker = minflicker;
  new_preset.maxflicker = maxflicker;
  new_preset.minpause = minpause;
  new_preset.maxpause = maxpause;
  level._light.var_7946c098158094a8[name] = new_preset;
}

function function_ec6b3b3a4ca37980(name) {
  if(isDefined(level._light.var_7946c098158094a8) && isDefined(level._light.var_7946c098158094a8[name])) {
    return level._light.var_7946c098158094a8[name];
  }

  return undefined;
}

function function_bb536503bca3484c(name, targetname, minintensity, maxintensity) {
  assert(isstring(name));
  assert(isstring(targetname));
  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x25c>" + name + "<dev string:x1b9>" + targetname + "<dev string:x9f>");
    return;
  }

  preset = function_ec6b3b3a4ca37980(name);

  if(!isDefined(preset)) {
    println("<dev string:x2a3>" + name + "<dev string:x2d9>");
    return;
  }

  if(isDefined(minintensity)) {
    if(minintensity < 0) {
      println("<dev string:x125>" + name + "<dev string:x146>");
      minintensity = 0;
    }

    preset.minintensity = minintensity;
  }

  if(isDefined(maxintensity)) {
    if(maxintensity < 0) {
      println("<dev string:x125>" + name + "<dev string:x146>");
      maxintensity = 0;
    }

    preset.maxintensity = maxintensity;
  }

  foreach(ent in ents) {
    ent setlightintensity(preset.maxintensity);
    ent.islightflickering = 1;
    ent.islightflickerpaused = 0;
    ent thread function_8ebd596ef73e60c7(preset.minintensity, preset.maxintensity, preset.mindelay, preset.maxdelay, preset.minflicker, preset.maxflicker, preset.minpause, preset.maxpause);
    ent function_90d577e206f6609();
  }
}

function function_8ebd596ef73e60c7(minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause) {
  assert(isDefined(self.islightflickering));
  assert(isDefined(self.islightflickerpaused));
  self endon("kill_flicker");
  self endon("death");
  min_delay = mindelay;
  max_delay = maxdelay;
  min_flicker = minflicker;
  max_flicker = maxflicker;
  min_pause = minpause;
  max_pause = maxpause;
  min_intensity = minintensity;
  max_intensity = maxintensity;

  if(max_flicker < min_flicker || max_flicker == 0) {
    min_flicker = 1;
    max_flicker = 3;
    println("<dev string:x335>");
  }

  if(max_pause < min_pause || max_pause == 0) {
    min_pause = 8;
    max_pause = 15;
    println("<dev string:x382>");
  }

  if(max_intensity < min_intensity || max_intensity == 0) {
    min_intensity = 0;
    max_intensity = 10;
    println("<dev string:x3cd>");
  }

  thread electric_flicker(min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause);
  original_origin = self.origin;
}

function electric_flicker(min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause) {
  assert(isDefined(self.islightflickering));
  assert(isDefined(self.islightflickerpaused));
  self endon("kill_flicker");
  self endon("death");
  self setlightintensity(max_intensity);
  pause_time = randomfloatrange(min_pause, max_pause);
  num_flicker = randomintrange(min_flicker, max_flicker);
  var_da011e1105e9147a = pause_time;
  var_3c672bdc3ad1c909 = num_flicker;
  old_intensity = max_intensity;

  for(;;) {
    if(pause_time == 0 || pause_time < 0) {
      if(num_flicker == 0 || num_flicker < 0) {
        self setlightintensity(max_intensity);
        pause_time = randomfloatrange(min_pause, max_pause);
        var_da011e1105e9147a = pause_time;
      } else {
        for(z = 0; z < var_3c672bdc3ad1c909; z++) {
          intensity = randomfloatrange(min_intensity, max_intensity);
          timer = randomfloatrange(min_delay, max_delay);
          timer *= 0.75;

          while(self.islightflickerpaused) {
            wait 0.05;
          }

          for(i = 0; i < timer; i++) {
            new_intensity = intensity * i / timer + old_intensity * (timer - i) / timer;
            self setlightintensity(new_intensity);
            wait 0.05;
            num_flicker -= 1;
          }

          old_intensity = intensity;
        }
      }

      continue;
    }

    for(i = 0; i < var_da011e1105e9147a; i++) {
      intensity = randomfloatrange(max_intensity * 0.95, max_intensity);

      while(self.islightflickerpaused) {
        wait 0.05;
      }

      self setlightintensity(intensity);
      wait 0.05;
      pause_time -= 1;
      num_flicker = randomintrange(min_flicker, max_flicker);
      var_3c672bdc3ad1c909 = num_flicker;
      wait 1;
    }
  }
}

function lerp_spot_intensity(targetname, time, endintensity, flickerpercentage) {
  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  if(ents.size == 0) {
    iprintlnbold("<dev string:x41c>" + targetname + "<dev string:x435>");

    return;
  }

  foreach(ent in ents) {
    thread lerp_spot_intensity_manage(ent, time, endintensity, flickerpercentage);
  }
}

function lerp_spot_intensity_manage(ent, time, endintensity, flickerpercentage) {
  if(!isDefined(ent)) {
    return;
  }

  ent notify("kill_lerp_spot_intensity_manage");
  ent endon("kill_lerp_spot_intensity_manage");
  ent endon("death");
  startintensity = ent getlightintensity();
  ent.endintensity = endintensity;
  t = 0;

  if(isDefined(flickerpercentage)) {
    while(t < time) {
      new_intensity = startintensity + (endintensity - startintensity) * t / time;
      new_intensity *= 1 + flickerpercentage;
      t += 0.05;
      ent setlightintensity(new_intensity);
      function_e5074ba6c35b7cc5(ent, new_intensity);
      wait 0.05;
    }
  } else {
    while(t < time) {
      new_intensity = startintensity + (endintensity - startintensity) * t / time;
      t += 0.05;
      ent setlightintensity(new_intensity);
      function_e5074ba6c35b7cc5(ent, new_intensity);
      wait 0.05;
    }
  }

  ent setlightintensity(endintensity);

  if(time <= 0) {
    ent function_90d577e206f6609();
  }

  if(isDefined(ent.target)) {
    otherlights = getEntArray(ent.target, "targetname");

    foreach(otherlight in otherlights) {
      if(isDefined(otherlight) && otherlight.classname == "light") {
        otherlight setlightintensity(endintensity);

        if(time <= 0) {
          otherlight function_90d577e206f6609();
        }
      }
    }
  }
}

function function_e5074ba6c35b7cc5(ent, new_intensity) {
  if(isDefined(ent.target)) {
    otherlights = getEntArray(ent.target, "targetname");

    foreach(otherlight in otherlights) {
      if(isDefined(otherlight) && otherlight.classname == "light") {
        otherlight setlightintensity(new_intensity);
      }
    }
  }
}

function lerp_spot_radius(targetname, time, endradius) {
  ent = getEnt(targetname, "targetname");
  startradius = ent getlightradius();
  ent.endradius = endradius;
  t = 0;

  while(t < time) {
    new_radius = startradius + (endradius - startradius) * t / time;
    t += 0.05;
    ent setlightradius(new_radius);
    wait 0.05;
  }

  ent setlightradius(endradius);
}

function set_light_intensity(targetname, endintensity) {
  ent = getEnt(targetname, "targetname");
  ent setlightintensity(endintensity);
}

function lerp_spot_color(targetname, time, endcolor) {
  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  foreach(ent in ents) {
    thread function_b8c80e21f9ae102d(ent, time, endcolor);
  }
}

function function_b8c80e21f9ae102d(ent, time, endcolor) {
  startcolor = ent getlightcolor();
  ent.endcolor = endcolor;
  t = 0;

  while(t < time) {
    new_color = startcolor + (endcolor - startcolor) * t / time;
    t += 0.05;
    ent setlightcolor(new_color);
    wait 0.05;
  }

  ent setlightcolor(endcolor);
}

function set_light_color(targetname, endcolor) {
  ent = getEnt(targetname, "targetname");
  ent setlightcolor(endcolor);
}

function model_flicker_preset(targetname, var_595f214a0c836320, min_intensity, max_intensity, fxid1, fxid2, var_7a699ba6660f6247, var_73423fd4b925b5f1, var_e40d0e4f030018db, var_75289c46941c448d, ender, snd_params, offint, oneshot_sfx) {
  assert(isstring(targetname));
  self endon("death");

  if(isDefined(ender)) {
    level endon(ender);
  }

  ents = [];
  ents1 = getEntArray(targetname, "targetname");
  ents2 = getEntArray(targetname, "script_noteworthy");
  ents = array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x446>");
    return;
  }

  lightents = [];
  modelents = [];

  foreach(ent in ents) {
    if(ent.classname == "script_model") {
      modelents[modelents.size] = ent;
    }

    if(ent.classname == "light") {
      lightents[lightents.size] = ent;
      intensity = min_intensity;

      if(max_intensity > min_intensity) {
        intensity = randomfloatrange(min_intensity, max_intensity);
      }

      ent setlightintensity(intensity);
    }
  }

  var_ea7a04c2f8e0fb74 = 0;
  var_ca7bc2703ad3530d = undefined;
  var_215c17d15e981cc9 = undefined;
  var_ca6eb2703ac51b58 = undefined;
  var_f7bc0821c055a686 = undefined;
  var_deb4177eaaf20b8e = undefined;
  snd_vol = 1;

  if(isarray(snd_params)) {
    var_ca7bc2703ad3530d = snd_params["on"];
    var_215c17d15e981cc9 = snd_params["off"];
    var_ca6eb2703ac51b58 = snd_params["loop"];
    var_deb4177eaaf20b8e = snd_params["vol_env"];
  }

  flicker_count = 0;

  if(isDefined(fxid1)) {
    exploder(fxid1);
  }

  level.accelerationfactor = 1;

  while(flicker_count < var_595f214a0c836320 || var_595f214a0c836320 == 0) {
    on = undefined;

    if(isDefined(offint)) {
      off = offint;
    } else {
      off = 0.05;
    }

    delay = 0;

    if(isDefined(var_7a699ba6660f6247) && isDefined(var_73423fd4b925b5f1)) {
      var_59674125085e7f6c = randomfloatrange(var_7a699ba6660f6247, var_73423fd4b925b5f1) * level.accelerationfactor;
    } else {
      var_59674125085e7f6c = randomfloatrange(0.1, 0.8) * level.accelerationfactor;
    }

    if(isDefined(var_e40d0e4f030018db) && isDefined(var_75289c46941c448d)) {
      var_fcb73e7167f9ba86 = randomfloatrange(var_e40d0e4f030018db, var_75289c46941c448d) * level.accelerationfactor;
    } else {
      var_fcb73e7167f9ba86 = randomfloatrange(0.1, 0.8) * level.accelerationfactor;
    }

    if(isDefined(fxid1)) {
      foreach(light_ent in lightents) {
        if(var_ea7a04c2f8e0fb74) {
          if(isstring(var_f7bc0821c055a686)) {
            level notify(var_f7bc0821c055a686);
          }

          if(isDefined(var_215c17d15e981cc9)) {
            var_ea7a04c2f8e0fb74 = 0;
          }
        }
      }

      kill_exploder(fxid1);
    }

    if(isDefined(fxid2)) {
      foreach(light_ent in lightents) {
        if(var_ea7a04c2f8e0fb74) {
          if(isstring(var_f7bc0821c055a686)) {
            level notify(var_f7bc0821c055a686);
          }

          if(isDefined(var_215c17d15e981cc9)) {
            var_ea7a04c2f8e0fb74 = 0;
          }
        }
      }

      kill_exploder(fxid2);
    }

    foreach(model01 in modelents) {
      model01 hide();
    }

    foreach(light in lightents) {
      on = light getlightintensity();
      light setlightintensity(off);
    }

    wait var_fcb73e7167f9ba86;

    if(isDefined(fxid1)) {
      foreach(light_ent in lightents) {
        intensity = min_intensity;

        if(max_intensity > min_intensity) {
          intensity = randomfloatrange(min_intensity, max_intensity);
        }

        light_ent setlightintensity(intensity);

        if(isDefined(var_ca7bc2703ad3530d) && !var_ea7a04c2f8e0fb74) {
          if(isarray(var_deb4177eaaf20b8e)) {
            if(isDefined(var_ca7bc2703ad3530d)) {
              if(isDefined(var_ca6eb2703ac51b58)) {
                var_ea7a04c2f8e0fb74 = 1;
              }
            }
          }
        }
      }

      exploder(fxid1);
    }

    if(isDefined(fxid2)) {
      foreach(light_ent in lightents) {
        intensity = min_intensity;

        if(max_intensity > min_intensity) {
          intensity = randomfloatrange(min_intensity, max_intensity);
        }

        light_ent setlightintensity(intensity);

        if(isDefined(var_ca7bc2703ad3530d) && !var_ea7a04c2f8e0fb74) {
          if(isarray(var_deb4177eaaf20b8e)) {
            if(isDefined(var_ca7bc2703ad3530d)) {
              if(isDefined(var_ca6eb2703ac51b58)) {
                var_ea7a04c2f8e0fb74 = 1;
              }
            }
          }
        }
      }

      exploder(fxid2);
    }

    foreach(model01 in modelents) {
      model01 show();
    }

    foreach(light in lightents) {
      light setlightintensity(on);

      if(isDefined(oneshot_sfx)) {
        light playsoundonentity(oneshot_sfx);
      }
    }

    wait var_59674125085e7f6c;

    if(var_595f214a0c836320 != 0) {
      flicker_count++;
    }
  }
}

function function_86db5c6ec8a91629(ent, ent2, var_595f214a0c836320, min_intensity, var_7a699ba6660f6247, var_73423fd4b925b5f1, var_e40d0e4f030018db, var_75289c46941c448d, ender, snd_params, offint) {
  self endon("death");

  if(isDefined(ender)) {
    level endon(ender);
  }

  if(!isDefined(ent)) {
    println("<dev string:x479>");
    return;
  }

  if(!isDefined(ent2)) {
    println("<dev string:x490>");
    return;
  }

  lightents = [];
  modelents = [];

  for(flicker_count = 0; flicker_count < var_595f214a0c836320 || var_595f214a0c836320 == 0; flicker_count++) {
    on = undefined;

    if(isDefined(offint)) {
      off = offint;
    } else {
      off = 0.05;
    }

    delay = 0;

    if(isDefined(var_7a699ba6660f6247) && isDefined(var_73423fd4b925b5f1)) {
      var_59674125085e7f6c = randomfloatrange(var_7a699ba6660f6247, var_73423fd4b925b5f1);
    } else {
      var_59674125085e7f6c = randomfloatrange(0.1, 0.8);
    }

    if(isDefined(var_e40d0e4f030018db) && isDefined(var_75289c46941c448d)) {
      var_fcb73e7167f9ba86 = randomfloatrange(var_e40d0e4f030018db, var_75289c46941c448d);
    } else {
      var_fcb73e7167f9ba86 = randomfloatrange(0.1, 0.8);
    }

    ent hide();
    ent2 show();
    wait var_fcb73e7167f9ba86;
    ent show();
    ent2 hide();
    wait var_59674125085e7f6c;

    if(var_595f214a0c836320 != 0) {}
  }
}

function light_message_init() {
  assert(isDefined(level._light));
  level._light.messages = [];
}

function light_debug_dvar_init() {
  setdvarifuninitialized(@ "hash_4e1c5767f995ad93", 0);
}

function light_register_message(message, callback) {
  assertex(isDefined(level._light), "<dev string:x4a8>");
  assert(isarray(level._light.messages));
  level._light.messages[message] = callback;
}

function light_message(message, arg1, arg2, arg3) {
  assertex(isDefined(level._light), "<dev string:x4a8>");
  assert(isarray(level._light.messages));

  if(isDefined(level._light.messages[message])) {
    if(isDefined(arg3)) {
      thread[[level._light.messages[message]]](arg1, arg2, arg3);
    } else if(isDefined(arg2)) {
      thread[[level._light.messages[message]]](arg1, arg2);
    } else if(isDefined(arg1)) {
      thread[[level._light.messages[message]]](arg1);
    } else {
      thread[[level._light.messages[message]]]();
    }
  }

}

function lerp_light_fov_range(outer_start, inner_start, outer_end, inner_end, duration) {
  t = 0;

  while(t <= duration) {
    time_fraction = t / duration;
    waitframe();
    t += 0.05;
  }
}

function vfx_sunflare(fx_name) {
  thread fx_flare_to_sun_flare(fx_name, 50000);
}

function fx_flare_to_sun_flare(fxid, dist) {
  level endon("kill_sun2");
  level endon("death");

  if(!isDefined(dist)) {
    dist = 50000;
  }

  level.sunflare = spawn_tag_origin();
  level.sunflare.origin = level.player.origin + get_sun_direction() * dist;
  level.sunflare show();
  playFXOnTag(getfx(fxid), level.sunflare, "tag_origin");
  thread function_39eced3283796f8d(fxid, level.sunflare);
  delay = 0.1;

  while(true) {
    level.sunflare moveTo(level.player.origin + get_sun_direction() * dist, delay);
    wait delay;
  }
}

function function_39eced3283796f8d(fxid, ent) {
  level waittill("kill_sun");
  killfxontag(getfx(fxid), ent, "tag_origin");
  level notify("kill_sun2");
}

function set_sun_flare_position(sun_flare_position) {
  level.sun_flare_position = sun_flare_position;
  wait 0.3;
}

function get_sun_direction() {
  if(isDefined(level.sun_flare_position)) {
    return anglesToForward(level.sun_flare_position);
  }

  return getmapsundirection();
}

function lerp_fov_overtime(time, destfov) {
  foreach(player in level.players) {
    player modifybasefov(destfov, time);
  }

  wait time;
}

function function_c58a66b712fbc58e(time, destfov) {
  foreach(player in level.players) {
    player lerpfov(destfov, time);
  }

  wait time;
}

function lerp_fov_over_distance_trigger() {
  linepoints = strtok(self.script_parameters, " ");
  linepointstructs = [];

  foreach(linepoint in linepoints) {
    linepointstructs[linepointstructs.size] = getStruct(linepoint, "targetname");
  }

  startfov = float(linepointstructs[0].script_parameters);
  endfov = float(linepointstructs[1].script_parameters);
  var_d22cc214680148b9 = distance(linepointstructs[0].origin, linepointstructs[1].origin);

  while(true) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_c12ff48eb31835c2 = pointonsegmentnearesttopoint(linepointstructs[0].origin, linepointstructs[1].origin, level.player.origin);
      delta = math::normalize_value(0, var_d22cc214680148b9, distance(linepointstructs[0].origin, var_c12ff48eb31835c2));
      targetfov = math::factor_value(startfov, endfov, delta);
      level.player modifybasefov(targetfov, 0.05);

      if(level.player adsButtonPressed()) {
        wait 0.3;
      } else {
        level.player modifybasefov(targetfov, 0.05);
      }

      waitframe();
    }
  }
}

function function_9ce312d3d1b90fc4(var_d17bc90beaceba66, var_235ac5072a1ae788, var_b3c4e0e491f9176b, in_time, wait_time, out_time) {
  self notify("end_dof_loops");
  self endon("end_dof_loops");
  level.var_6a722d3b33217661 = undefined;
  prev_time = gettime();
  prev_move_speed = length(self getvelocity());
  waitframe();
  strength_goal = 0;
  distortion_goal = 0;
  radius_goal = 0;
  state = "DOWN";
  var_84345b7ef10c4e74 = undefined;
  var_1339c9f748769b8b = 0;
  var_3b7da3be0a320c51 = 0;

  while(true) {
    text = "";
    var_6030244e11bf3e1b = length(self getvelocity());
    var_bf8e19640d7f4ad0 = gettime() - prev_time;
    stick_mag = length2d(self getnormalizedmovement());

    if(istrue(level.var_6a722d3b33217661)) {
      state = "QUIT";
    }

    switch (state) {
      case #"hash_faa298f6bdc36b00":
        if(var_6030244e11bf3e1b == 0 || var_6030244e11bf3e1b < prev_move_speed && stick_mag < 0.05) {
          state = "wait";
          var_84345b7ef10c4e74 = gettime() + wait_time * 1000;
        }

        break;
      case #"hash_1e6e35d002e26a35":
        if(var_6030244e11bf3e1b > prev_move_speed || var_6030244e11bf3e1b == prev_move_speed && stick_mag > 0.95 && var_6030244e11bf3e1b > 10) {
          state = "UP";
          var_1339c9f748769b8b = in_time;
          strength_goal = var_235ac5072a1ae788;
          distortion_goal = var_d17bc90beaceba66;
          radius_goal = var_b3c4e0e491f9176b;
        }

        break;
      case #"hash_bdf347744138cb00":
        if(var_6030244e11bf3e1b > prev_move_speed || var_6030244e11bf3e1b == prev_move_speed && stick_mag > 0.95 && var_6030244e11bf3e1b > 10) {
          state = "UP";
          var_1339c9f748769b8b = in_time;
          strength_goal = var_235ac5072a1ae788;
          distortion_goal = var_d17bc90beaceba66;
          radius_goal = var_b3c4e0e491f9176b;
        } else if(gettime() > var_84345b7ef10c4e74 || var_6030244e11bf3e1b < prev_move_speed && stick_mag > 0.05) {
          state = "DOWN";
          var_1339c9f748769b8b = out_time;
          strength_goal = 0;
          distortion_goal = 0;
          radius_goal = 0;
        }

        break;
      case #"hash_ca04c44443c6fa96":
        var_1339c9f748769b8b = out_time;
        strength_goal = 0;
        distortion_goal = 0;
        radius_goal = 0;
        break;
    }

    if(state != "wait") {
      level.var_9f347f3156d0dee3 = "<dev string:x4eb>";

      done1 = function_830e692e8b173603(@ "hash_960ef00238357bbc", state, var_6030244e11bf3e1b, strength_goal, var_235ac5072a1ae788, var_1339c9f748769b8b, var_bf8e19640d7f4ad0);
      done2 = function_830e692e8b173603(@ "hash_ed28298c207316ae", state, var_6030244e11bf3e1b, distortion_goal, var_d17bc90beaceba66, var_1339c9f748769b8b, var_bf8e19640d7f4ad0);
      done3 = function_830e692e8b173603(@ "hash_979b5474be3b9b47", state, var_6030244e11bf3e1b, radius_goal, var_b3c4e0e491f9176b, var_1339c9f748769b8b, var_bf8e19640d7f4ad0);
      var_3b7da3be0a320c51 = done1 && done2 && done3;

      if(var_3b7da3be0a320c51) {
        text = state + "<dev string:x4ef>" + "<dev string:x4f7>" + var_6030244e11bf3e1b + "<dev string:x502>" + level.var_9f347f3156d0dee3;
      } else {
        text = state + "<dev string:x4f7>" + var_6030244e11bf3e1b + "<dev string:x502>" + level.var_9f347f3156d0dee3;
      }
    } else {
      var_8fc9ec8f91bf68b4 = var_84345b7ef10c4e74 - gettime();

      if(var_8fc9ec8f91bf68b4 < 0) {
        var_8fc9ec8f91bf68b4 = 0;
      }

      text = state + "<dev string:x4f7>" + var_6030244e11bf3e1b + "<dev string:x507>" + var_8fc9ec8f91bf68b4 * 0.001 + "<dev string:x511>" + wait_time + "<dev string:x502>";
    }

    prev_time = gettime();

    if(state != "wait") {
      prev_move_speed = var_6030244e11bf3e1b;
    }

    if(istrue(level.var_6a722d3b33217661) && var_3b7da3be0a320c51) {
      break;
    }

    waitframe();
  }

  level.var_6a722d3b33217661 = undefined;
}

function function_6a722d3b33217661() {
  level.var_6a722d3b33217661 = 1;
}

function function_830e692e8b173603(dvar_name, state, var_6030244e11bf3e1b, strength_goal, var_235ac5072a1ae788, var_1339c9f748769b8b, var_bf8e19640d7f4ad0) {
  var_bbcbab73e67c2fb0 = undefined;
  var_9fc794ffae3a33b6 = undefined;
  is_done = 0;
  curr_strength = getdvarfloat(dvar_name);

  if(true) {
    var_9fc794ffae3a33b6 = var_6030244e11bf3e1b / getdvarfloat(@ "g_speed");
  } else {
    var_9fc794ffae3a33b6 = var_6030244e11bf3e1b / 340;
  }

  if(var_9fc794ffae3a33b6 > 1) {
    var_9fc794ffae3a33b6 = 1;
  }

  var_65ce6f8a79b7508 = strength_goal * var_9fc794ffae3a33b6;

  if(var_1339c9f748769b8b == 0) {
    var_bbcbab73e67c2fb0 = 1e+06;
  } else {
    var_8a7efc4b7d261b0a = var_235ac5072a1ae788 / var_1339c9f748769b8b;
    var_bbcbab73e67c2fb0 = var_8a7efc4b7d261b0a * var_bf8e19640d7f4ad0 * 0.001;
  }

  if(curr_strength != strength_goal) {
    if(state == "UP") {
      var_9e9430cfada07d0e = curr_strength + var_bbcbab73e67c2fb0;

      if(var_9e9430cfada07d0e > var_235ac5072a1ae788 * var_9fc794ffae3a33b6) {
        var_9e9430cfada07d0e = var_65ce6f8a79b7508;
      }
    } else {
      var_9e9430cfada07d0e = curr_strength - var_bbcbab73e67c2fb0;

      if(var_9e9430cfada07d0e < 0) {
        var_9e9430cfada07d0e = 0;
      }
    }

    noself_func("setsaveddvar", dvar_name, var_9e9430cfada07d0e);
    is_done = 0;
  } else {
    var_9e9430cfada07d0e = curr_strength;
    is_done = 1;
  }

  if(var_235ac5072a1ae788 > 0) {
    dvar_short = "<dev string:x516>";

    if(dvar_name == @ "hash_ed28298c207316ae") {
      dvar_short = "<dev string:x51d>";
    }

    if(dvar_name == @ "hash_979b5474be3b9b47") {
      dvar_short = "<dev string:x524>";
    }

    level.var_9f347f3156d0dee3 = dvar_short + "<dev string:x52b>" + var_9e9430cfada07d0e + "<dev string:x511>" + var_65ce6f8a79b7508 + "<dev string:x502>" + level.var_9f347f3156d0dee3;
  }

  return is_done;
}

function function_d8d7817826eadad8(ent, time, target) {
  ent notify("stop lerp");
  ent endon("stop lerp");
  ent endon("death");
  startorigin = ent.origin;
  t = 0;

  while(t < time) {
    ent.origin = vectorlerp(startorigin, target, t / time);
    t += 0.05;
    wait 0.05;
  }

  ent.origin = target;
}

function function_a73453a4796f91f4() {
  while(true) {
    self waittill("trigger");
    vals = strtok(self.script_parameters, " ");
    targettime = float(vals[0]);
    targetdistance = float(vals[1]);
    thread sunshadowscale_lerp(targettime, targetdistance);
    waitframe();

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_31c01ed170a03ed6(var_3ab4fd4794242e73, var_8a618ecfa14c2858, var_9e8f0007b795320f, spotdistcull, var_b2f5ddc90a053b53, endflag, var_8d3d30eebe904364) {
  level endon(endflag);

  if(isDefined(var_9e8f0007b795320f)) {
    if(isarray(var_9e8f0007b795320f)) {
      foreach(group in var_9e8f0007b795320f) {
        lights = getEntArray(group, "script_noteworthy");

        foreach(light in lights) {}
      }
    }
  }

  var_c3b392000803f5c4 = var_8a618ecfa14c2858;
  var_896a8c43ef2cd38b = [];

  if(isDefined(var_8d3d30eebe904364)) {
    var_896a8c43ef2cd38b[0] = (1, 0, 0);
    var_896a8c43ef2cd38b[1] = (0, 1, 0);
    var_896a8c43ef2cd38b[2] = (0, 0, 1);
    var_896a8c43ef2cd38b[3] = (1, 0, 1);
    var_896a8c43ef2cd38b[4] = (0, 1, 1);
    var_896a8c43ef2cd38b[5] = (1, 1, 0);
    var_896a8c43ef2cd38b[6] = (1, 1, 1);
    var_896a8c43ef2cd38b[7] = (0, 0.5, 0.5);
  }

  if(isDefined(var_8a618ecfa14c2858)) {
    noself_func("setsaveddvar", @ "hash_63eb1893f96ac98d", var_c3b392000803f5c4);
    noself_func("setsaveddvar", @ "hash_e08232af8b8b695c", 6);
    noself_func("setsaveddvar", @ "hash_1dde331a8e0153d8", var_c3b392000803f5c4);
  }

  if(isDefined(spotdistcull)) {
    noself_func("setsaveddvar", @ "hash_8667c0bb90c5bfc3", spotdistcull);
  }

  lights = getEntArray(var_3ab4fd4794242e73, "script_noteworthy");
  permanent_lights = [];

  if(isDefined(var_b2f5ddc90a053b53)) {
    permanent_lights = getEntArray(var_b2f5ddc90a053b53, "script_noteworthy");
  }

  while(!isDefined(level.player)) {
    wait 0.2;
  }

  angles = level.player getplayerangles();
  forward = anglesToForward(angles);
  player_eye_pos = level.player.origin + (0, 0, 48);
  trace_result = ray_trace(player_eye_pos, player_eye_pos + forward * 30000);
  var_a4cbddad94b691c0 = trace_result["position"];
  sorted_lights = sortbydistance(lights, var_a4cbddad94b691c0);

  while(true) {
    angles = level.player getplayerangles();
    forward = anglesToForward(angles);
    player_eye_pos = level.player.origin + (0, 0, 48);
    trace_result = ray_trace(player_eye_pos, player_eye_pos + forward * 30000);
    var_a4cbddad94b691c0 = trace_result["position"];
    sorted_lights = sortbydistance(lights, var_a4cbddad94b691c0);
    var_6eeebda7526c440d = [];
    index = 0;

    if(isDefined(var_b2f5ddc90a053b53)) {
      foreach(light in permanent_lights) {
        intensity = light getlightintensity();

        if(intensity < 0.1) {
          continue;
        }

        var_6eeebda7526c440d[index] = light;
        index += 1;
      }
    }

    foreach(light in sorted_lights) {
      intensity = light getlightintensity();

      if(intensity < 0.1) {
        continue;
      }

      var_6eeebda7526c440d[index] = light;
      index += 1;
    }

    for(i = 0; i < var_6eeebda7526c440d.size; i++) {
      dist = distance(var_6eeebda7526c440d[i].origin, level.player.origin);
      dot = vectordot(vectorNormalize(var_6eeebda7526c440d[i].origin - level.player.origin), forward);

      if(dist < spotdistcull) {
        if(isDefined(var_8d3d30eebe904364) && var_8d3d30eebe904364) {
          line(var_a4cbddad94b691c0, var_6eeebda7526c440d[i].origin, var_896a8c43ef2cd38b[i], 1, 0, 4);
        }
      }
    }

    if(var_6eeebda7526c440d.size > var_c3b392000803f5c4) {
      for(i = var_c3b392000803f5c4; i < var_6eeebda7526c440d.size; i++) {}
    }

    wait 0.4;
  }
}

function function_4bcc2f384d0be5d8() {
  level.var_97134dad75782583 = 0;
  waitframe();
}

function dazed_effect(intensity, time) {
  noself_func("setsaveddvar", @ "hash_8fef9b7e4f880571", 1);

  if(!isDefined(time)) {
    time = 3;
  }

  if(intensity == 1) {
    level thread function_e1f5d98cfa1ab7a(time);
  }

  if(intensity == 2) {
    level thread function_1a6f8798d7db1402(time);
  }

  if(intensity == 3) {
    level thread function_4593f6ae7d958614(time);
  }
}

function function_e1f5d98cfa1ab7a(time) {
  noself_func("setsaveddvar", @ "hash_ea4c44a08cd23d5d", 1);
  noself_func("setsaveddvar", @ "hash_c7590c5a3289a2d", 3);
  noself_func("setsaveddvar", @ "hash_960ef00238357bbc", 0.07);
  wait time;
  noself_func("setsaveddvar", @ "hash_ea4c44a08cd23d5d", 0);
  noself_func("setsaveddvar", @ "hash_c7590c5a3289a2d", 0);
  noself_func("setsaveddvar", @ "hash_960ef00238357bbc", 0);
  wait 0.05;
  noself_func("setsaveddvar", @ "hash_8fef9b7e4f880571", 0);
}

function function_1a6f8798d7db1402(time) {
  noself_func("setsaveddvar", @ "hash_ea4c44a08cd23d5d", 2);
  noself_func("setsaveddvar", @ "hash_c7590c5a3289a2d", 2);
  noself_func("setsaveddvar", @ "hash_960ef00238357bbc", 0.05);
  wait 0.1;
  noself_func("setsaveddvar", @ "hash_ea4c44a08cd23d5d", 1);
  noself_func("setsaveddvar", @ "hash_c7590c5a3289a2d", 1);
  noself_func("setsaveddvar", @ "hash_960ef00238357bbc", 0.007);
  wait time;
  noself_func("setsaveddvar", @ "hash_960ef00238357bbc", 0);
  wait 0.05;
  noself_func("setsaveddvar", @ "hash_8fef9b7e4f880571", 0);
}

function function_4593f6ae7d958614(time) {
  thread function_c62d87226808cd1c(0.007, 0.2);
  wait time;
  thread function_c62d87226808cd1c(0, 1);
}

function function_c62d87226808cd1c(end_value, duration) {
  start_value = getdvarfloat(@ "hash_960ef00238357bbc");
  t = 0;

  while(t <= duration) {
    time_fraction = t / duration;
    noself_func("setsaveddvar", @ "hash_960ef00238357bbc", math::lerp(start_value, end_value, time_fraction));
    waitframe();
    t += 0.05;
  }
}

function lerp_dvar(dvar, end_value, duration) {
  start_value = getdvarfloat(dvar);
  t = 0.05;

  while(t <= duration + 0.0001) {
    time_fraction = t / duration;
    time_fraction = round(time_fraction, 0.0001);
    noself_func("setsaveddvar", dvar, math::lerp(start_value, end_value, time_fraction));
    waitframe();
    t += 0.05;
  }
}

function light_setup_common_dof_presets() {
  create_dof_preset("default", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  create_dof_preset("viewmodel_blur", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  create_dof_preset("close_none_viewmodel_blur", 1, 50, 4, 1000, 7000, 0.05, 0.5);
  create_dof_preset("river", 1, 104, 9, 500, 500, 1.8, 0.5);
  create_dof_preset("medium_none_viewmodel_blur", 1, 500, 10, 1000, 7000, 0.05, 0.5);
}

function create_dof_preset(name, nstart, nend, nblur, fstart, fend, fblur, fbias) {
  if(!isDefined(level._light.dof_presets)) {
    level._light.dof_presets = [];
  }

  new_dof = [];
  new_dof["nearStart"] = nstart;
  new_dof["nearEnd"] = nend;
  new_dof["nearBlur"] = nblur;
  new_dof["farStart"] = fstart;
  new_dof["farEnd"] = fend;
  new_dof["farBlur"] = fblur;
  new_dof["bias"] = fbias;
  level._light.dof_presets[name] = new_dof;
}

function light_get_dof_preset(name) {
  if(isDefined(level._light.dof_presets) && isDefined(level._light.dof_presets[name])) {
    return level._light.dof_presets[name];
  }

  println("<dev string:x530>" + name + "<dev string:x560>");
}

function blend_dof_presets(preset1, preset2, time) {
  assert(isDefined(preset1));
  assert(isDefined(preset2));
  assert(isDefined(time) && time >= 0);

  if(isDefined(level._light.dof_presets)) {
    dof1 = light_get_dof_preset(preset1);
    dof2 = light_get_dof_preset(preset2);

    if(isDefined(dof1) && isDefined(dof2)) {}
  }
}

function light_setup_common_dof_viewmodel_presets() {
  create_dof_viewmodel_preset("default", 2, 8);
  create_dof_viewmodel_preset("viewmodel_blur", 10, 90);
  create_dof_viewmodel_preset("max", 2, 128);
}

function create_dof_viewmodel_preset(name, start, end) {
  if(!isDefined(level._light.dof_viewmodel_presets)) {
    level._light.dof_viewmodel_presets = [];
  }

  var_28e91b4b7dcbfd6e["start"] = start;
  var_28e91b4b7dcbfd6e["end"] = end;
  level.player.viewmodel_dof_start = var_28e91b4b7dcbfd6e["start"];
  level.player.viewmodel_dof_end = var_28e91b4b7dcbfd6e["end"];
  level._light.dof_viewmodel_presets[name] = var_28e91b4b7dcbfd6e;
}

function light_get_dof_viewmodel_preset(name) {
  if(isDefined(level._light.dof_viewmodel_presets) && isDefined(level._light.dof_viewmodel_presets[name])) {
    return level._light.dof_viewmodel_presets[name];
  }

  println("<dev string:x530>" + name + "<dev string:x560>");
}

function blend_dof_viewmodel_presets(preset1, preset2, time) {
  assert(isDefined(preset1));
  assert(isDefined(preset2));
  assert(isDefined(time) && time >= 0);

  if(isDefined(level._light.dof_viewmodel_presets)) {
    start_viewmodel = light_get_dof_viewmodel_preset(preset1);
    end_viewmodel = light_get_dof_viewmodel_preset(preset2);

    if(isDefined(start_viewmodel) && isDefined(end_viewmodel)) {
      blend_viewmodel_dof(start_viewmodel, end_viewmodel, time);
    }
  }
}

function blend_viewmodel_dof(start_viewmodel, end_viewmodel, time) {
  if(time > 0) {
    var_a43d50fddef154c2 = (end_viewmodel["start"] - start_viewmodel["start"]) * 0.05 / time;
    var_fbd33eaf8837fcaf = (end_viewmodel["end"] - start_viewmodel["end"]) * 0.05 / time;
    thread lerp_viewmodel_dof(end_viewmodel, var_a43d50fddef154c2, var_fbd33eaf8837fcaf);
    return;
  }

  level.player.viewmodel_dof_start = end_viewmodel["start"];
  level.player.viewmodel_dof_end = end_viewmodel["end"];
}

function lerp_viewmodel_dof(end_viewmodel, var_a43d50fddef154c2, var_fbd33eaf8837fcaf) {
  level notify("lerp_viewmodel_dof");
  level endon("lerp_viewmodel_dof");
  start_done = 0;
  end_done = 0;

  while(!start_done || !end_done) {
    if(!start_done) {
      level.player.viewmodel_dof_start += var_a43d50fddef154c2;

      if(var_a43d50fddef154c2 > 0 && level.player.viewmodel_dof_start > end_viewmodel["start"] || var_a43d50fddef154c2 < 0 && level.player.viewmodel_dof_start < end_viewmodel["start"]) {
        level.player.viewmodel_dof_start = end_viewmodel["start"];
        start_done = 1;
      }
    }

    if(!end_done) {
      level.player.viewmodel_dof_end += var_fbd33eaf8837fcaf;

      if(var_fbd33eaf8837fcaf > 0 && level.player.viewmodel_dof_end > end_viewmodel["end"] || var_fbd33eaf8837fcaf < 0 && level.player.viewmodel_dof_end < end_viewmodel["end"]) {
        level.player.viewmodel_dof_end = end_viewmodel["end"];
        end_done = 1;
      }
    }

    level.player setviewmodeldepthoffield(level.player.viewmodel_dof_start, level.player.viewmodel_dof_end);
    wait 0.05;
  }
}

function lighting_target_dof(player, target, aperture, var_965582b4f1f2f995, var_a90c6783e05bab5f, tag) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x576>");
    return;
  }

  if(!isDefined(aperture)) {
    assertmsg("<dev string:x5bc>");
    return;
  }

  level notify("end_lighting_target_dof");
  level endon("end_lighting_target_dof");

  if(!isDefined(var_965582b4f1f2f995)) {
    var_965582b4f1f2f995 = 1;
  }

  if(!isDefined(var_a90c6783e05bab5f)) {
    var_a90c6783e05bab5f = 1;
  }

  level thread function_87231e6662dd640e();
  waitframe();
  level.player enablephysicaldepthoffieldscripting();
  fstop = aperture;
  flag_clear("flag_autofocus_on");

  while(true) {
    if(!isDefined(target)) {
      assertmsg("<dev string:x604>");
      return;
    }

    if(isDefined(tag) && target tagexists(tag)) {
      dof_dist = distance(level.player getEye(), target gettagorigin(tag));
    } else {
      dof_dist = distance(level.player getEye(), target.origin);
    }

    fstop = aperture;

    if(dof_dist < 60) {
      fstop += abs(60 - dof_dist) * 0.1;
    }

    level.player setphysicaldepthoffield(fstop, dof_dist, var_965582b4f1f2f995, var_a90c6783e05bab5f);

    if(isDefined(level.var_eab94425e32d22e9)) {
      if(isDefined(tag)) {
        print3d(target gettagorigin(tag), "<dev string:x659>", (1, 1, 1), 1, 1, 2);

        iprintln(dof_dist);
      } else {
        print3d(target.origin, "<dev string:x659>", (1, 1, 1), 1, 1, 2);

        iprintln(dof_dist);
      }
    }

    waitframe();
  }
}

function function_87231e6662dd640e() {
  level waittill("end_lighting_target_dof");
  flag_set("flag_autofocus_on");
  level.player disablephysicaldepthoffieldscripting();
}

function screen_effect_base(time, materials, fadein_, fadeout_, var_f9d4ee89841a793b, xpos, ypos, sort) {
  assert(isDefined(time));
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = var_f9d4ee89841a793b;
  overlay thread cleanup_overlay();

  if(isDefined(xpos)) {
    overlay.x = xpos;
  }

  if(isDefined(ypos)) {
    overlay.y = ypos;
  }

  if(isDefined(sort)) {
    overlay.sort = sort;
  }

  if(isarray(materials)) {
    foreach(material in materials) {
      assert(isstring(material));
      overlay setshader(material, 640, 480);
    }
  } else {
    assert(isstring(materials));
    overlay setshader(materials, 640, 480);
  }

  if(time > 0) {
    overlay.alpha = 0;
    fadein = 1;

    if(isDefined(fadein_)) {
      assert(fadein_ >= 0);
      fadein = fadein_;
    }

    fadeout = 1;

    if(isDefined(fadeout_)) {
      assert(fadeout_ >= 0);
      fadeout = fadeout_;
    }

    max_alpha = 1;

    if(isDefined(var_f9d4ee89841a793b)) {
      assert(var_f9d4ee89841a793b >= 0);
      max_alpha = clamp(var_f9d4ee89841a793b, 0, 1);
    }

    step_time = 0.05;

    if(fadein > 0) {
      current_alpha = 0;
      increment_alpha = max_alpha / fadein / step_time;
      assertex(increment_alpha > 0, "<dev string:x65e>");

      while(current_alpha < max_alpha) {
        overlay.alpha = current_alpha;
        current_alpha += increment_alpha;
        wait step_time;
      }
    }

    overlay.alpha = max_alpha;
    wait time - fadein + fadeout;

    if(fadeout > 0) {
      if(isDefined(overlay)) {
        current_alpha = max_alpha;
        decrement_alpha = max_alpha / fadeout / step_time;
        assertex(decrement_alpha > 0, "<dev string:x685>");

        while(current_alpha > 0) {
          overlay.alpha = current_alpha;
          current_alpha -= decrement_alpha;
          wait step_time;
        }
      }
    }

    if(isDefined(overlay)) {
      overlay.alpha = 0;
      overlay destroy();
    }
  }

  if(isDefined(overlay)) {
    level.overlay = overlay;
    return level.overlay;
  }
}

function cleanup_overlay() {
  level waittill("end_screen_effect");
  self destroy();
}

function blood_splatter_simple() {}

function dirt_splatter_simple() {
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("fullscreen_dirt_bottom", 640, 480);
  overlay setshader("fullscreen_dirt_bottom_b", 640, 480);
  overlay setshader("fullscreen_dirt_left", 640, 480);
  overlay setshader("fullscreen_dirt_right", 640, 480);
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay fadeovertime(3);
  overlay.alpha = 0;
}

function bob_mask(hudelement) {
  self endon("stop_mask_bob");
  weapidletime = 0;
  previousangles = level.player getplayerangles();
  offsety = 0;
  offsetx = 0;
  addyoffset = hudelement.y;
  addxoffset = hudelement.x;
  frametime = 0.05;

  while(true) {
    if(isDefined(hudelement)) {
      angles = level.player getplayerangles();
      velocity = level.player getvelocity();
      zvelocity = velocity[2];
      velocity -= velocity * (0, 0, 1);
      speedxy = length(velocity);
      stance = level.player getstance();
      speedscale = clamp(speedxy, 0, 280) / 280;
      var_c5eb2145895f4e62 = 0.1 + speedscale * 0.25;
      var_fd0ce72d0d2c8085 = 0.1 + speedscale * 0.25;
      bobscale = 1;

      if(stance == "crouch") {
        bobscale = 0.75;
      }

      if(stance == "prone") {
        bobscale = 0.4;
      }

      if(stance == "stand") {
        bobscale = 1;
      }

      idlespeed = 5;
      adsspeed = 0.9;
      playerads = level.player playerads();
      bobspeed = idlespeed * (1 - playerads) + adsspeed * playerads;
      bobspeed *= 1 + speedscale * 2;
      var_7202918161cd8cc9 = 5;
      var_279806421fd9b8af = var_7202918161cd8cc9 * var_c5eb2145895f4e62 * bobscale;
      var_279805421fd9b67c = var_7202918161cd8cc9 * var_fd0ce72d0d2c8085 * bobscale;
      weapidletime += frametime * 1000 * bobspeed;
      var_b4469da4bc031c17 = 57.2958;
      verticalbob = sin(weapidletime * 0.001 * var_b4469da4bc031c17);
      horizontalbob = sin(weapidletime * 0.0007 * var_b4469da4bc031c17);
      anglediffyaw = angleclamp180(angles[1] - previousangles[1]);
      anglediffyaw = clamp(anglediffyaw, -10, 10);
      offsetxtarget = anglediffyaw / 10 * var_7202918161cd8cc9 * (1 - var_c5eb2145895f4e62);
      offsetxchange = offsetxtarget - offsetx;
      offsetx += clamp(offsetxchange, -1, 1);
      offsetytarget = clamp(zvelocity, -200, 200) / 200 * var_7202918161cd8cc9 * (1 - var_fd0ce72d0d2c8085);
      offsetychange = offsetytarget - offsety;
      offsety += clamp(offsetychange, -0.6, 0.6);
      hudelement moveovertime(0.05);
      hudelement.x = addxoffset + clamp(verticalbob * var_279806421fd9b8af + offsetx - var_7202918161cd8cc9, 0 - 2 * var_7202918161cd8cc9, 0);
      hudelement.y = addyoffset + clamp(horizontalbob * var_279805421fd9b67c + offsety - var_7202918161cd8cc9, 0 - 2 * var_7202918161cd8cc9, 0);
      previousangles = angles;
    }

    wait frametime;
  }
}

function gasmask_on_player(bfadein, fadeouttime, fadeintime, darktime) {
  assert(isPlayer(self));

  if(!isDefined(bfadein)) {
    bfadein = 1;
  }

  if(!isDefined(fadeouttime)) {
    fadeouttime = 0;
  }

  if(!isDefined(fadeintime)) {
    fadeintime = 1;
  }

  if(!isDefined(darktime)) {
    darktime = 0.25;
  }

  if(bfadein) {
    fade_out(fadeouttime);
  }

  self.gasmask_hud_elem = newclienthudelem(self);
  self.gasmask_hud_elem.x = 0;
  self.gasmask_hud_elem.y = 0;
  self.gasmask_hud_elem.horzalign = "fullscreen";
  self.gasmask_hud_elem.vertalign = "fullscreen";
  self.gasmask_hud_elem.foreground = 0;
  self.gasmask_hud_elem.sort = -1;
  self.gasmask_hud_elem setshader("gasmask_overlay_delta2_top", 650, 138);
  self.gasmask_hud_elem.alpha = 1;
  self.gasmask_hud_elem1 = newclienthudelem(self);
  self.gasmask_hud_elem1.x = 0;
  self.gasmask_hud_elem1.y = 352;
  self.gasmask_hud_elem1.horzalign = "fullscreen";
  self.gasmask_hud_elem1.vertalign = "fullscreen";
  self.gasmask_hud_elem1.foreground = 0;
  self.gasmask_hud_elem1.sort = -1;
  self.gasmask_hud_elem1 setshader("gasmask_overlay_delta2_bottom", 650, 138);
  self.gasmask_hud_elem1.alpha = 1;
  level.player delaythread(1, &gasmask_breathing);
  thread bob_mask(self.gasmask_hud_elem);
  thread bob_mask(self.gasmask_hud_elem1);

  if(bfadein) {
    wait darktime;
    fade_in(fadeintime);
  }
}

function gasmask_off_player() {
  assert(isPlayer(self));
  fade_out(0.25);
  self notify("stop_mask_bob");

  if(isDefined(self.gasmask_hud_elem)) {
    self.gasmask_hud_elem destroy();
    self.gasmask_hud_elem = undefined;
  }

  if(isDefined(self.gasmask_hud_elem1)) {
    self.gasmask_hud_elem1 destroy();
    self.gasmask_hud_elem1 = undefined;
  }

  level.player notify("stop_breathing");
  wait 0.25;
  fade_in(1.5);
}

function gasmask_breathing() {
  delay = 1;
  self endon("stop_breathing");

  while(true) {
    wait delay;
  }
}

function gasmask_on_npc() {
  self.gasmask = spawn("script_model", (0, 0, 0));
  self.gasmask setModel("prop_sas_gasmask");
  self.gasmask linkTo(self, "tag_eye", (-4, 0, 2), (120, 0, 0));
}

function gasmask_off_npc() {
  if(isDefined(self.gasmask)) {
    self.gasmask delete();
  }
}

function sunshadowscale_lerp(time, targetsample) {
  noself_func("setsaveddvar", @ "hash_1048f749a8b7aa91", 1);
  currframe = 0;
  numframes = time * 20;
  numframes_less = numframes - 1;
  currsample = getdvarfloat(@ "sm_sunsamplesizenear");

  while(currframe < numframes) {
    var_c3c8ead438d06ca0 = (targetsample - currsample) * currframe / numframes_less;
    var_c3c8ead438d06ca0 += currsample;
    noself_func("setsaveddvar", @ "sm_sunsamplesizenear", var_c3c8ead438d06ca0);
    currframe++;
    waitframe();
  }

  noself_func("setsaveddvar", @ "hash_1048f749a8b7aa91", 0);
}

function function_395761b4520b0c62(time, target_value) {
  level notify("changing_volumetricDepth");
  level endon("changing_volumetricDepth");
  old_value = getDvar(@ "hash_5a83a561cb4970b2");

  if(!isDefined(old_value) || target_value == old_value) {
    return;
  }

  start_time_ms = gettime();
  end_time_ms = gettime() + time * 1000;
  time_ms = time * 1000;

  while(gettime() <= end_time_ms) {
    time_percentage = 1 - (end_time_ms - gettime()) / time_ms;
    var_f7c220750e1ce883 = math::lerp(old_value, target_value, time_percentage);
    noself_func("setsaveddvar", @ "hash_5a83a561cb4970b2", var_f7c220750e1ce883);
    waitframe();
  }

  noself_func("setsaveddvar", @ "hash_5a83a561cb4970b2", target_value);
}

function function_e3e16e6e2ec15751() {
  flag_init("enable_grass_dof");
  flag_init("enable_grass_dof_crouch");
  flag_init("enable_grass_dof_prone");
  flag_wait("player_spawned_with_loadout");
  thread function_4a7732ef052bbd94();
  thread function_46434b79368903f9();
}

function function_4a7732ef052bbd94() {
  level.grass_dof_trigger_count = 0;
  var_eb5116b9494ff691 = getEntArray("DOF_GRASS_ON", "targetname");

  foreach(grass_dof_trigger in var_eb5116b9494ff691) {
    grass_dof_trigger thread function_89243203381caa61();
  }

  while(true) {
    level waittill("grass_dof_trigger_count_updated");
    waittillframeend();

    if(level.grass_dof_trigger_count > 0) {
      flag_set("enable_grass_dof");
      continue;
    }

    flag_clear("enable_grass_dof");
  }
}

function function_89243203381caa61() {
  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player function_13efea510c8ee6e7()) {
      level.grass_dof_trigger_count++;
      level notify("grass_dof_trigger_count_updated");

      while(player istouching(self) && player function_13efea510c8ee6e7()) {
        wait 0.1;
      }

      level.grass_dof_trigger_count--;
      level notify("grass_dof_trigger_count_updated");
    }
  }
}

function function_13efea510c8ee6e7() {
  stance = self getstance();

  if(stance != "stand") {
    if(stance == "crouch") {
      flag_set("enable_grass_dof_crouch");
      flag_clear("enable_grass_dof_prone");
    } else if(stance == "prone") {
      flag_set("enable_grass_dof_prone");
      flag_clear("enable_grass_dof_crouch");
    }

    return true;
  }

  return false;
}

function function_46434b79368903f9() {
  wait 0.05;

  while(true) {
    flag_wait("enable_grass_dof");

    while(flag("enable_grass_dof") && flag("equipment_interact") == 0) {
      level.player enablephysicaldepthoffieldscripting();

      if(flag("enable_grass_dof_crouch") == 1 && flag("equipment_interact") == 0) {
        level.player setphysicaldepthoffield(2, 400);
        level.player setphysicalviewmodeldepthoffield(1, 25);
        wait 0.1;
      }

      if(flag("enable_grass_dof_prone") == 1 && flag("equipment_interact") == 0) {
        level.player setphysicaldepthoffield(0.25, 800);
        level.player setphysicalviewmodeldepthoffield(0.5, 25);
        wait 0.1;
      }

      wait 0.1;
    }

    if(flag("enable_grass_dof") && flag("equipment_interact") == 1) {
      while(flag("enable_grass_dof") && flag("equipment_interact") == 1) {
        level.player enablephysicaldepthoffieldscripting();

        if(flag("enable_grass_dof_crouch") == 1 && flag("equipment_interact") == 1) {
          level.player setphysicaldepthoffield(2, 400);
          wait 0.1;
        }

        if(flag("enable_grass_dof_prone") == 1 && flag("equipment_interact") == 1) {
          level.player setphysicaldepthoffield(0.25, 800);
          wait 0.1;
        }

        level.player setphysicalviewmodeldepthoffield(30, 20);
        wait 0.1;
      }
    }

    level.player setphysicalviewmodeldepthoffield(30, 20);
    level.player disablephysicaldepthoffieldscripting();
    wait 0.1;
  }
}

function function_61a998996cc98831() {
  function_ee7c0ccde65de2ec(%"hw_cine_lastgen");
}

function function_9160006a3f10b2cd() {
  function_90fb4916aa7fd9f3(%"hw_cine_lastgen");
}

function function_3f730819900e0fa0(duration, end_value) {
  self notify("stop lightfov lerp");
  self endon("stop lightfov lerp");
  self endon("death");
  start_value = self getlightfovouter();
  wait 0.05;
  t = 0.05;

  while(t <= duration) {
    self setlightfovrange(math::lerp(start_value, end_value, t / duration));
    wait 0.05;
    t += 0.05;
  }

  self setlightfovrange(end_value);
}

function lerplightradius(duration, end_value) {
  self notify("stop lightradius lerp");
  self endon("stop lightradius lerp");
  self endon("death");
  start_value = self getlightradius();
  wait 0.05;
  t = 0.05;

  while(t <= duration) {
    self setlightradius(math::lerp(start_value, end_value, t / duration));
    wait 0.05;
    t += 0.05;
  }

  self setlightradius(end_value);
}

function function_a18b3876df7ffbb1(timeleft) {
  level.accelerationfactor = 1;
  finalacceleration = 0.03;
  stepsize = (level.accelerationfactor - finalacceleration) / timeleft * 20;

  while(level.accelerationfactor > finalacceleration) {
    level.accelerationfactor -= stepsize;

    if(level.accelerationfactor < finalacceleration) {
      level.accelerationfactor = finalacceleration;
    }

    wait 0.05;
    timeleft -= 0.05;
  }
}