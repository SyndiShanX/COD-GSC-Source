/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\lighting.gsc
***************************************/

#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace lighting;

function private autoexec __init__system__() {
  system::register(#"general_lighting", undefined, undefined, &init);
}

function private init() {
  function_abfe2529dcddd39();
}

function is_light() {
  if(self.classname == "T\xf2\xa4:K" || self.classname == "6\xc7\xefqVe\xfa\x94\x145" || self.classname == "\x02\x7f\xe0\v\xf3\xc3 \xb8\x1a\xd5") {
    return 1;
  }

  return 0;
}

function function_9a2e7a44052876f0(time, endintensity) {
  self notify("O2\x02\x0e\xd9\xea!\xcd\xeb(t\x1d\x99\xabK\xa6\xd9\x84\xb1");
  self endon("O2\x02\x0e\xd9\xea!\xcd\xeb(t\x1d\x99\xabK\xa6\xd9\x84\xb1");
  self endon("\x1e\xfd\xd1\xa2\a");
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

function function_140a2d7e5315f75e(time, endcolor) {
  self notify("[-\xea\xbb\x8a\x01\xc5\xfb\xba\x7fih\x1c\xa8E");
  self endon("[-\xea\xbb\x8a\x01\xc5\xfb\xba\x7fih\x1c\xa8E");
  self endon("\x1e\xfd\xd1\xa2\a");
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

function function_73f6cc318a837fbf(time, endradius) {
  self notify("\xda\x9b\x1f\xe2Tu\n:\xf0\xd7\"\xe5\xe8\xe9\xf5;");
  self endon("\xda\x9b\x1f\xe2Tu\n:\xf0\xd7\"\xe5\xe8\xe9\xf5;");
  self endon("\x1e\xfd\xd1\xa2\a");
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

function private function_32c28fbf961dc37c() {
  if(!istrue(level.var_c21639ebfc7aa238)) {
    self dontinterpolate();
  }
}

function flicker_light(min_delay, max_delay, var_70ee8b0bf56fe6b8, var_324a4d3a9ce926be, min_time, max_time, lerp_amount, min_num, max_num, min_pause, max_pause, pause_scale, intensity) {
  if(!isDefined(self.var_f37900751c04450e)) {
    self.var_f37900751c04450e = 1;
  }

  if(!isDefined(self.var_50a4066c0223aab6)) {
    self.var_50a4066c0223aab6 = 0;
  }

  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(min_delay)) {
    min_delay = 0.1;
  }

  if(!isDefined(max_delay)) {
    max_delay = 1;
  }

  if(!isDefined(var_70ee8b0bf56fe6b8)) {
    var_70ee8b0bf56fe6b8 = 0;
  }

  if(!isDefined(var_324a4d3a9ce926be)) {
    var_324a4d3a9ce926be = 0.5;
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

  min_intensity = intensity * var_70ee8b0bf56fe6b8;
  max_intensity = intensity * var_324a4d3a9ce926be;

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

      while(self.var_50a4066c0223aab6) {
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
      while(self.var_50a4066c0223aab6) {
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

function function_84c66c35659feab8(min_time, max_time, var_70ee8b0bf56fe6b8, var_324a4d3a9ce926be, max_move, intensity) {
  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(var_70ee8b0bf56fe6b8)) {
    var_70ee8b0bf56fe6b8 = 0.6;
  }

  if(!isDefined(var_324a4d3a9ce926be)) {
    var_324a4d3a9ce926be = 1.2;
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

  thread flicker_light(0, 0, var_70ee8b0bf56fe6b8, var_324a4d3a9ce926be, min_time, max_time, 0.5, undefined, undefined, undefined, undefined, undefined, intensity);

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
    function_72dc8e6f1255be2b();
    function_fc02e239298a728a();
    function_d2cb16e754850b0b();
  }
}

function function_fc02e239298a728a() {
  function_a3248051da3d8cad("\xcciN\xca", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 8);
  function_a3248051da3d8cad("\xd1t\xf3\fUF\xc1\x97\x91", (0.445098, 0.62451, 0.972549), (0.05, 0.150451, 0.307843), 0.005, 0.2, 8);
  function_a3248051da3d8cad("O\ta\xd7[\x11\xa9jp\xe8", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 8);
  function_a3248051da3d8cad("\xd87Pu\xb5\x91\x7f\x12\xa3_\xd1!\xe4\x17", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 0.5);
  function_a3248051da3d8cad("S\t\xc8\x16B\x82\x9bxy\x93\xf2\xc3", (0.972549, 0.972549, 0.972549), (0.572549, 0.572549, 0.572549), 0.005, 0.2, 8);
  function_a3248051da3d8cad("\x18\x119\xf2\x99", (0, 0, 0), (255, 107, 107), 0.2, 1, 8);
  function_a3248051da3d8cad("\x1c\x91%\xf1\xf1}\xc7Y\xa0", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 6);
  function_a3248051da3d8cad("\xfd\x8bt\xab\"~\x03\xfd\xff\xcd\xcf", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 7);
  function_a3248051da3d8cad("\xf0N\xfa\x04\xb5\xae\x12:\xd4\xe6\xc9\x8a\xa3", (0.63, 0.72, 0.92), (0.4, 0.43, 0.48), 0.005, 0.2, 7);
  function_a3248051da3d8cad("3\x8b\n\xbcI\x93\x8fY", (1, 0.65, 0.8), (0.4, 0.24, 0.3), 0.005, 0.2, 8);
}

function function_a3248051da3d8cad(name, color0, color1, intensity, mindelay, maxdelay, maxmove) {
  if(!isDefined(level._light.var_153531d20c7e0c34)) {
    level._light.var_153531d20c7e0c34 = [];
  }

  new_preset = spawnStruct();
  new_preset.color0 = color0;
  new_preset.color1 = color1;
  new_preset.intensity = intensity;
  new_preset.mindelay = mindelay;
  new_preset.maxdelay = maxdelay;
  new_preset.maxmove = maxmove;
  level._light.var_153531d20c7e0c34[name] = new_preset;
}

function function_3f0711f412d35b06(name) {
  if(isDefined(level._light.var_153531d20c7e0c34) && isDefined(level._light.var_153531d20c7e0c34[name])) {
    return level._light.var_153531d20c7e0c34[name];
  }

  return undefined;
}

function function_5e7e917723d9faeb(name, targetname, intensity_, var_7a865c1bb7520d79) {
  assert(isstring(name));
  assert(isstring(targetname));
  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x24>" + name + "<dev string:x62>" + targetname + "<dev string:xa7>");
    return;
  }

  preset = function_3f0711f412d35b06(name);

  if(!isDefined(preset)) {
    println("<dev string:xad>" + name + "<dev string:xda>");
    return;
  }

  if(isDefined(intensity_)) {
    if(intensity_ < 0) {
      println("<dev string:x12d>" + name + "<dev string:x14e>");
      intensity_ = 0;
    }

    preset.intensity = intensity_;
  }

  foreach(ent in ents) {
    ent setlightintensity(preset.intensity);
    ent.var_f37900751c04450e = 1;
    ent.var_50a4066c0223aab6 = 0;
    ent thread function_906cf129c8718bb1(preset.color0, preset.color1, preset.intensity, preset.mindelay, preset.maxdelay, preset.maxmove, var_7a865c1bb7520d79);
    ent function_32c28fbf961dc37c();
  }
}

function function_24a56587598bc8c3(name, targetname, intensity_, lerptime) {
  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x194>" + name + "<dev string:x1c1>" + targetname + "<dev string:xa7>");
    return;
  }

  foreach(ent in ents) {
    if(!isDefined(ent.var_f37900751c04450e)) {
      println("<dev string:x1f2>");
      return;
    }

    if(isDefined(intensity_)) {
      if(intensity_ < 0) {
        println("<dev string:x12d>" + name + "<dev string:x14e>");
        intensity_ = 0;
      }
    }

    if(!isDefined(intensity_)) {
      intensity_ = ent getlightintensity();
      ent.var_50a4066c0223aab6 = 1;
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

    ent notify("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
    ent.var_f37900751c04450e = 0;

    if((lerptime ?? 0) <= 0) {
      ent function_32c28fbf961dc37c();
    }
  }
}

function private function_72860853cfa1f1a8(var_7a865c1bb7520d79, min_delay, max_delay) {
  if(!isDefined(level._light.var_6142a215b1359ea2)) {
    level._light.var_6142a215b1359ea2 = [];
  }

  if(!isDefined(level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79])) {
    level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79] = [];
    level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79]["\x92\xd3\x9f\xbb"] = 0;
  }

  if(gettime() != level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79]["\x92\xd3\x9f\xbb"]) {
    level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79]["\x92\xd3\x9f\xbb"] = gettime();
    level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79]["C\xd3\x9by\xa3"] = randomfloatrange(min_delay, max_delay);
  }

  return level._light.var_6142a215b1359ea2[var_7a865c1bb7520d79]["C\xd3\x9by\xa3"];
}

function function_906cf129c8718bb1(color0, color1, intensity, mindelay, maxdelay, maxmove, var_7a865c1bb7520d79) {
  assert(isDefined(self.var_f37900751c04450e));
  assert(isDefined(self.var_50a4066c0223aab6));
  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");

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
  delay = undefined;

  while(true) {
    if(isDefined(var_7a865c1bb7520d79)) {
      delay = function_72860853cfa1f1a8(var_7a865c1bb7520d79, min_delay, max_delay);
    } else {
      delay = randomfloatrange(min_delay, max_delay);
    }

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

    while(self.var_50a4066c0223aab6) {
      wait 0.05;
    }
  }
}

function fire_flicker(min_delay, max_delay) {
  assert(isDefined(self.var_f37900751c04450e));
  assert(isDefined(self.var_50a4066c0223aab6));
  full = self getlightintensity();
  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");

  for(old_intensity = full;; old_intensity = intensity) {
    intensity = randomfloatrange(full * 0.5, full * 1.2);
    timer = randomfloatrange(min_delay, max_delay);
    timer *= 0.75;

    while(self.var_50a4066c0223aab6) {
      wait 0.05;
    }

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * i / timer + old_intensity * (timer - i) / timer;
      self setlightintensity(new_intensity);
      wait 0.05;
    }
  }
}

function function_5fe35619eede14ed(script_noteworthy, fxid) {
  light_object = spawnStruct();
  ents = getEntArray(script_noteworthy, #script_noteworthy);
  light_object.lightents = [];
  light_object.modelents = [];

  foreach(ent in ents) {
    if(ent.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
      light_object.modelents[light_object.modelents.size] = ent;
    }

    if(ent.classname == "T\xf2\xa4:K") {
      light_object.lightents[light_object.lightents.size] = ent;
    }
  }

  light_object.fxid = fxid;

  light_object.var_8dd8f574b62e921 = 1;

  return light_object;
}

function function_61d6e04df8f98577(intensity, color, is_on) {
  assert(isDefined(self.var_8dd8f574b62e921));

  foreach(lightent in self.lightents) {
    lightent setlightintensity(intensity);
    lightent setlightcolor(color);
  }

  if(is_on && !isDefined(self.was_on)) {
    utility::exploder(self.fxid);

    foreach(modelent in self.modelents) {
      modelent show();
    }

    self.was_on = 1;
    return;
  }

  if(isDefined(self.was_on) && !is_on) {
    utility::stop_exploder(self.fxid);

    foreach(modelent in self.modelents) {
      modelent hide();
    }

    self.was_on = undefined;
  }
}

function flickering_light(light_object, off_color, off_intensity, on_color, on_intensity, min_delay, max_delay) {
  light_object endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  light_object endon("\x1e\xfd\xd1\xa2\a");
  var_24adf9906e08f795 = 0;
  delay = 0;

  for(;;) {
    var_c0d7c8e31cce6ec6 = var_24adf9906e08f795;
    var_24adf9906e08f795 = randomfloat(1);

    if(min_delay != max_delay) {
      delay += randomfloatrange(min_delay, max_delay);
    } else {
      delay += max_delay;
    }

    if(delay == 0) {
      delay += 1e-07;
    }

    var_7d6069138eac9f36 = (var_24adf9906e08f795 - var_c0d7c8e31cce6ec6) / delay;

    while(delay > 0) {}
  }
}

function function_44210d337a33136a(light_object, off_color, off_intensity, on_color, on_intensity) {
  light_object endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  light_object endon("\x1e\xfd\xd1\xa2\a");
  base_frequency = 2;
  var_605807f0f2c30b6b = 3;
  var_188f33f0ed018af8 = 5;

  for(;;) {}
}

function function_a14d19f822ffaadf(name, minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause) {
  if(!isDefined(level._light.var_708eead3239cdbd)) {
    level._light.var_708eead3239cdbd = [];
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
  level._light.var_708eead3239cdbd[name] = new_preset;
}

function function_5dadaee6af6e05b5(name) {
  if(isDefined(level._light.var_708eead3239cdbd) && isDefined(level._light.var_708eead3239cdbd[name])) {
    return level._light.var_708eead3239cdbd[name];
  }

  return undefined;
}

function function_488d59245a79f441(name, targetname, minintensity, maxintensity) {
  assert(isstring(name));
  assert(isstring(targetname));
  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x264>" + name + "<dev string:x1c1>" + targetname + "<dev string:xa7>");
    return;
  }

  preset = function_5dadaee6af6e05b5(name);

  if(!isDefined(preset)) {
    println("<dev string:x2ab>" + name + "<dev string:x2e1>");
    return;
  }

  if(isDefined(minintensity)) {
    if(minintensity < 0) {
      println("<dev string:x12d>" + name + "<dev string:x14e>");
      minintensity = 0;
    }

    preset.minintensity = minintensity;
  }

  if(isDefined(maxintensity)) {
    if(maxintensity < 0) {
      println("<dev string:x12d>" + name + "<dev string:x14e>");
      maxintensity = 0;
    }

    preset.maxintensity = maxintensity;
  }

  foreach(ent in ents) {
    ent setlightintensity(preset.maxintensity);
    ent.var_f37900751c04450e = 1;
    ent.var_50a4066c0223aab6 = 0;
    ent thread function_6d459faea0cbb792(preset.minintensity, preset.maxintensity, preset.mindelay, preset.maxdelay, preset.minflicker, preset.maxflicker, preset.minpause, preset.maxpause);
    ent function_32c28fbf961dc37c();
  }
}

function function_6d459faea0cbb792(minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause) {
  assert(isDefined(self.var_f37900751c04450e));
  assert(isDefined(self.var_50a4066c0223aab6));
  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");
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
    println("<dev string:x33d>");
  }

  if(max_pause < min_pause || max_pause == 0) {
    min_pause = 8;
    max_pause = 15;
    println("<dev string:x38a>");
  }

  if(max_intensity < min_intensity || max_intensity == 0) {
    min_intensity = 0;
    max_intensity = 10;
    println("<dev string:x3d5>");
  }

  thread electric_flicker(min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause);
  original_origin = self.origin;
}

function electric_flicker(min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause) {
  assert(isDefined(self.var_f37900751c04450e));
  assert(isDefined(self.var_50a4066c0223aab6));
  self endon("\xd0\xf7\xb4\x87F\\+;\x1f\xcd\xccO");
  self endon("\x1e\xfd\xd1\xa2\a");
  self setlightintensity(max_intensity);
  pause_time = randomfloatrange(min_pause, max_pause);
  num_flicker = randomintrange(min_flicker, max_flicker);
  var_fd7a7ae8d3775b63 = pause_time;
  var_11b74bc74642466c = num_flicker;
  old_intensity = max_intensity;

  for(;;) {
    if(pause_time == 0 || pause_time < 0) {
      if(num_flicker == 0 || num_flicker < 0) {
        self setlightintensity(max_intensity);
        pause_time = randomfloatrange(min_pause, max_pause);
        var_fd7a7ae8d3775b63 = pause_time;
      } else {
        for(z = 0; z < var_11b74bc74642466c; z++) {
          intensity = randomfloatrange(min_intensity, max_intensity);
          timer = randomfloatrange(min_delay, max_delay);
          timer *= 0.75;

          while(self.var_50a4066c0223aab6) {
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

    for(i = 0; i < var_fd7a7ae8d3775b63; i++) {
      intensity = randomfloatrange(max_intensity * 0.95, max_intensity);

      while(self.var_50a4066c0223aab6) {
        wait 0.05;
      }

      self setlightintensity(intensity);
      wait 0.05;
      pause_time -= 1;
      num_flicker = randomintrange(min_flicker, max_flicker);
      var_11b74bc74642466c = num_flicker;
      wait 1;
    }
  }
}

function lerp_spot_intensity(targetname, time, endintensity, flickerpercentage) {
  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  if(ents.size == 0) {
    iprintlnbold("<dev string:x424>" + targetname + "<dev string:x43d>");

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

  ent notify("\x1f\x98\xc5S\xfe\xe0\x12a\x16Jg1\x10O\x05\"\xda\x14s(X\n\xe8\xd7_@I'E\xe5\x8b");
  ent endon("\x1f\x98\xc5S\xfe\xe0\x12a\x16Jg1\x10O\x05\"\xda\x14s(X\n\xe8\xd7_@I'E\xe5\x8b");
  ent endon("\x1e\xfd\xd1\xa2\a");
  startintensity = ent getlightintensity();
  ent.endintensity = endintensity;
  t = 0;

  if(isDefined(flickerpercentage)) {
    while(t < time) {
      new_intensity = startintensity + (endintensity - startintensity) * t / time;
      new_intensity *= 1 + flickerpercentage;
      t += 0.05;
      ent setlightintensity(new_intensity);
      function_c7cd224b6c6a0a08(ent, new_intensity);
      wait 0.05;
    }
  } else {
    while(t < time) {
      new_intensity = startintensity + (endintensity - startintensity) * t / time;
      t += 0.05;
      ent setlightintensity(new_intensity);
      function_c7cd224b6c6a0a08(ent, new_intensity);
      wait 0.05;
    }
  }

  ent setlightintensity(endintensity);

  if(time <= 0) {
    ent function_32c28fbf961dc37c();
  }

  if(isDefined(ent.target)) {
    otherlights = getEntArray(ent.target, #targetname);

    foreach(otherlight in otherlights) {
      if(isDefined(otherlight) && otherlight.classname == "T\xf2\xa4:K") {
        otherlight setlightintensity(endintensity);

        if(time <= 0) {
          otherlight function_32c28fbf961dc37c();
        }
      }
    }
  }
}

function function_c7cd224b6c6a0a08(ent, new_intensity) {
  if(isDefined(ent.target)) {
    otherlights = getEntArray(ent.target, #targetname);

    foreach(otherlight in otherlights) {
      if(isDefined(otherlight) && otherlight.classname == "T\xf2\xa4:K") {
        otherlight setlightintensity(new_intensity);
      }
    }
  }
}

function function_632318f1895b2b31(targetname, time, endradius) {
  ent = getEnt(targetname, #targetname);
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

function function_66701be5d77952d7(targetname, endintensity) {
  ent = getEnt(targetname, #targetname);
  ent setlightintensity(endintensity);
}

function function_6d96dace2c234abc(targetname, time, endcolor) {
  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  foreach(ent in ents) {
    thread function_d1402b06de181b54(ent, time, endcolor);
  }
}

function function_d1402b06de181b54(ent, time, endcolor) {
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

function function_c504b477bb448c2d(targetname, endcolor) {
  ent = getEnt(targetname, #targetname);
  ent setlightcolor(endcolor);
}

function function_9c530b62f030bc(targetname, var_993369c88387cba5, min_intensity, max_intensity, fxid1, fxid2, var_a4816baa729ef82a, var_7e62af1e90d76e0c, var_8fa1c9c652261b36, var_cf24a989320c4120, ender, snd_params, offint, oneshot_sfx) {
  assert(isstring(targetname));
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(ender)) {
    level endon(ender);
  }

  ents = [];
  ents1 = getEntArray(targetname, #targetname);
  ents2 = getEntArray(targetname, #script_noteworthy);
  ents = utility::array_combine(ents1, ents2);

  if(!isDefined(ents)) {
    println("<dev string:x44e>");
    return;
  }

  lightents = [];
  modelents = [];

  foreach(ent in ents) {
    if(ent.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
      modelents[modelents.size] = ent;
    }

    if(ent.classname == "T\xf2\xa4:K") {
      lightents[lightents.size] = ent;
      intensity = min_intensity;

      if(max_intensity > min_intensity) {
        intensity = randomfloatrange(min_intensity, max_intensity);
      }

      ent setlightintensity(intensity);
    }
  }

  var_cfe609f620da57fd = 0;
  var_bd7e80824a1578e0 = undefined;
  var_7965c5c7879bc334 = undefined;
  var_6da807361e410c81 = undefined;
  var_488bfec480de6217 = undefined;
  var_78314c5f450304e3 = undefined;
  snd_vol = 1;

  if(isarray(snd_params)) {
    var_bd7e80824a1578e0 = snd_params["\xb8\""];
    var_7965c5c7879bc334 = snd_params["\xf8\x88m"];
    var_6da807361e410c81 = snd_params["\xd0\xce\x88\x9e"];
    var_78314c5f450304e3 = snd_params["h\xad\xe8\x16\xd5\x16\x9b"];
  }

  flicker_count = 0;

  if(isDefined(fxid1)) {
    utility::exploder(fxid1);
  }

  level.accelerationfactor = 1;

  while(flicker_count < var_993369c88387cba5 || var_993369c88387cba5 == 0) {
    on = undefined;

    if(isDefined(offint)) {
      off = offint;
    } else {
      off = 0.05;
    }

    delay = 0;

    if(isDefined(var_a4816baa729ef82a) && isDefined(var_7e62af1e90d76e0c)) {
      var_16c4358f590d772d = randomfloatrange(var_a4816baa729ef82a, var_7e62af1e90d76e0c) * level.accelerationfactor;
    } else {
      var_16c4358f590d772d = randomfloatrange(0.1, 0.8) * level.accelerationfactor;
    }

    if(isDefined(var_8fa1c9c652261b36) && isDefined(var_cf24a989320c4120)) {
      var_adf253ccc359cb3b = randomfloatrange(var_8fa1c9c652261b36, var_cf24a989320c4120) * level.accelerationfactor;
    } else {
      var_adf253ccc359cb3b = randomfloatrange(0.1, 0.8) * level.accelerationfactor;
    }

    if(isDefined(fxid1)) {
      foreach(light_ent in lightents) {
        if(var_cfe609f620da57fd) {
          if(isstring(var_488bfec480de6217)) {
            level notify(var_488bfec480de6217);
          }

          if(isDefined(var_7965c5c7879bc334)) {
            var_cfe609f620da57fd = 0;
          }
        }
      }

      utility::kill_exploder(fxid1);
    }

    if(isDefined(fxid2)) {
      foreach(light_ent in lightents) {
        if(var_cfe609f620da57fd) {
          if(isstring(var_488bfec480de6217)) {
            level notify(var_488bfec480de6217);
          }

          if(isDefined(var_7965c5c7879bc334)) {
            var_cfe609f620da57fd = 0;
          }
        }
      }

      utility::kill_exploder(fxid2);
    }

    foreach(model01 in modelents) {
      model01 hide();
    }

    foreach(light in lightents) {
      on = light getlightintensity();
      light setlightintensity(off);
    }

    wait var_adf253ccc359cb3b;

    if(isDefined(fxid1)) {
      foreach(light_ent in lightents) {
        intensity = min_intensity;

        if(max_intensity > min_intensity) {
          intensity = randomfloatrange(min_intensity, max_intensity);
        }

        light_ent setlightintensity(intensity);

        if(isDefined(var_bd7e80824a1578e0) && !var_cfe609f620da57fd) {
          if(isarray(var_78314c5f450304e3)) {
            if(isDefined(var_bd7e80824a1578e0)) {
              if(isDefined(var_6da807361e410c81)) {
                var_cfe609f620da57fd = 1;
              }
            }
          }
        }
      }

      utility::exploder(fxid1);
    }

    if(isDefined(fxid2)) {
      foreach(light_ent in lightents) {
        intensity = min_intensity;

        if(max_intensity > min_intensity) {
          intensity = randomfloatrange(min_intensity, max_intensity);
        }

        light_ent setlightintensity(intensity);

        if(isDefined(var_bd7e80824a1578e0) && !var_cfe609f620da57fd) {
          if(isarray(var_78314c5f450304e3)) {
            if(isDefined(var_bd7e80824a1578e0)) {
              if(isDefined(var_6da807361e410c81)) {
                var_cfe609f620da57fd = 1;
              }
            }
          }
        }
      }

      utility::exploder(fxid2);
    }

    foreach(model01 in modelents) {
      model01 show();
    }

    foreach(light in lightents) {
      light setlightintensity(on);

      if(isDefined(oneshot_sfx)) {
        light utility::playsoundonentity(oneshot_sfx);
      }
    }

    wait var_16c4358f590d772d;

    if(var_993369c88387cba5 != 0) {
      flicker_count++;
    }
  }
}

function function_b707ffbc906fd9bc(ent, ent2, var_993369c88387cba5, min_intensity, var_a4816baa729ef82a, var_7e62af1e90d76e0c, var_8fa1c9c652261b36, var_cf24a989320c4120, ender, snd_params, offint) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(ender)) {
    level endon(ender);
  }

  if(!isDefined(ent)) {
    println("<dev string:x481>");
    return;
  }

  if(!isDefined(ent2)) {
    println("<dev string:x498>");
    return;
  }

  lightents = [];
  modelents = [];

  for(flicker_count = 0; flicker_count < var_993369c88387cba5 || var_993369c88387cba5 == 0; flicker_count++) {
    on = undefined;

    if(isDefined(offint)) {
      off = offint;
    } else {
      off = 0.05;
    }

    delay = 0;

    if(isDefined(var_a4816baa729ef82a) && isDefined(var_7e62af1e90d76e0c)) {
      var_16c4358f590d772d = randomfloatrange(var_a4816baa729ef82a, var_7e62af1e90d76e0c);
    } else {
      var_16c4358f590d772d = randomfloatrange(0.1, 0.8);
    }

    if(isDefined(var_8fa1c9c652261b36) && isDefined(var_cf24a989320c4120)) {
      var_adf253ccc359cb3b = randomfloatrange(var_8fa1c9c652261b36, var_cf24a989320c4120);
    } else {
      var_adf253ccc359cb3b = randomfloatrange(0.1, 0.8);
    }

    ent hide();
    ent2 show();
    wait var_adf253ccc359cb3b;
    ent show();
    ent2 hide();
    wait var_16c4358f590d772d;

    if(var_993369c88387cba5 != 0) {}
  }
}

function function_d2cb16e754850b0b() {
  assert(isDefined(level._light));
  level._light.messages = [];
}

function function_2e19b36e5bf200f5() {
  setdvarifuninitialized(@ "hash_4e1c5767f995ad93", 0);
}

function function_24f0474a4b13d6cc(message, callback) {
  assert(isDefined(level._light), "<dev string:x4b0>");
  assert(isarray(level._light.messages));
  level._light.messages[message] = callback;
}

function light_message(message, arg1, arg2, arg3) {
  assert(isDefined(level._light), "<dev string:x4b0>");
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

function function_accd046b341f98b0(outer_start, inner_start, outer_end, inner_end, duration) {
  t = 0;

  while(t <= duration) {
    time_fraction = t / duration;
    waitframe();
    t += 0.05;
  }
}

function vfx_sunflare(fx_name) {
  thread function_fcfaf9baeaf52037(fx_name, 50000);
}

function function_fcfaf9baeaf52037(fxid, dist) {
  level endon("\a\x88e\x16'\xf8\x1a\x1fa");
  level endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(dist)) {
    dist = 50000;
  }

  level.sunflare = utility::spawn_tag_origin();
  level.sunflare.origin = level.player.origin + function_f2bc88ecb076a99d() * dist;
  level.sunflare show();
  playFXOnTag(utility::getfx(fxid), level.sunflare, "\xec\xbfK|\au\xcd\xc2\x19<");
  thread function_c5cd9f732d9e4628(fxid, level.sunflare);
  delay = 0.1;

  while(true) {
    level.sunflare moveTo(level.player.origin + function_f2bc88ecb076a99d() * dist, delay);
    wait delay;
  }
}

function function_c5cd9f732d9e4628(fxid, ent) {
  level waittill("dY+7\x7f\xe2i4");
  killfxontag(utility::getfx(fxid), ent, "\xec\xbfK|\au\xcd\xc2\x19<");
  level notify("\a\x88e\x16'\xf8\x1a\x1fa");
}

function function_47e4d813d21f441c(var_acf2b53fcee65775) {
  level.var_acf2b53fcee65775 = var_acf2b53fcee65775;
  wait 0.3;
}

function function_f2bc88ecb076a99d() {
  if(isDefined(level.var_acf2b53fcee65775)) {
    return anglesToForward(level.var_acf2b53fcee65775);
  }

  return getmapsundirection();
}

function function_70648fe902bbd377(time, destfov) {
  foreach(player in level.players) {
    player modifybasefov(destfov, time);
  }

  wait time;
}

function function_4027c0dd94678d7f(time, destfov) {
  foreach(player in level.players) {
    player lerpfov(destfov, time);
  }

  wait time;
}

function lerp_fov_over_distance_trigger() {
  linepoints = strtok(self.script_parameters, "\xda");
  linepointstructs = [];

  foreach(linepoint in linepoints) {
    linepointstructs[linepointstructs.size] = utility::getStruct(linepoint, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  }

  startfov = float(linepointstructs[0].script_parameters);
  endfov = float(linepointstructs[1].script_parameters);
  var_692e5b03bf031868 = distance(linepointstructs[0].origin, linepointstructs[1].origin);

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>");

    while(level.player istouching(self)) {
      var_f109e78a55072d0f = pointonsegmentnearesttopoint(linepointstructs[0].origin, linepointstructs[1].origin, level.player.origin);
      delta = math::normalize_value(0, var_692e5b03bf031868, distance(linepointstructs[0].origin, var_f109e78a55072d0f));
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

function function_c9667f11f5c96d89(var_5e2619b449f16c77, var_25cd69ada7d56759, var_59dfb69dd53177b2, in_time, wait_time, out_time) {
  self notify("\xd50?\x10\xc9\xa1\x13\x15\x8c2\xa0\xcb\x86");
  self endon("\xd50?\x10\xc9\xa1\x13\x15\x8c2\xa0\xcb\x86");
  level.var_16a5f7329a5c9e70 = undefined;
  prev_time = gettime();
  var_892517a6c28b07bd = length(self getvelocity());
  waitframe();
  strength_goal = 0;
  distortion_goal = 0;
  radius_goal = 0;
  state = "_u\xf8\xe5";
  var_6b76a60a54ec10e9 = undefined;
  var_7f0c01b16833c8c6 = 0;
  var_28edfa30e34107a0 = 0;

  while(true) {
    text = "";
    var_561023b55bddc3ea = length(self getvelocity());
    var_207da73d1d051029 = gettime() - prev_time;
    stick_mag = length2d(self getnormalizedmovement());

    if(istrue(level.var_16a5f7329a5c9e70)) {
      state = "E\xaaRT";
    }

    switch (state) {
      case #"hash_faa298f6bdc36b00":
        if(var_561023b55bddc3ea == 0 || var_561023b55bddc3ea < var_892517a6c28b07bd && stick_mag < 0.05) {
          state = "/\xc8,\r";
          var_6b76a60a54ec10e9 = gettime() + wait_time * 1000;
        }

        break;
      case #"hash_1e6e35d002e26a35":
        if(var_561023b55bddc3ea > var_892517a6c28b07bd || var_561023b55bddc3ea == var_892517a6c28b07bd && stick_mag > 0.95 && var_561023b55bddc3ea > 10) {
          state = "\xb3\xb2";
          var_7f0c01b16833c8c6 = in_time;
          strength_goal = var_25cd69ada7d56759;
          distortion_goal = var_5e2619b449f16c77;
          radius_goal = var_59dfb69dd53177b2;
        }

        break;
      case #"hash_bdf347744138cb00":
        if(var_561023b55bddc3ea > var_892517a6c28b07bd || var_561023b55bddc3ea == var_892517a6c28b07bd && stick_mag > 0.95 && var_561023b55bddc3ea > 10) {
          state = "\xb3\xb2";
          var_7f0c01b16833c8c6 = in_time;
          strength_goal = var_25cd69ada7d56759;
          distortion_goal = var_5e2619b449f16c77;
          radius_goal = var_59dfb69dd53177b2;
        } else if(gettime() > var_6b76a60a54ec10e9 || var_561023b55bddc3ea < var_892517a6c28b07bd && stick_mag > 0.05) {
          state = "_u\xf8\xe5";
          var_7f0c01b16833c8c6 = out_time;
          strength_goal = 0;
          distortion_goal = 0;
          radius_goal = 0;
        }

        break;
      case #"hash_ca04c44443c6fa96":
        var_7f0c01b16833c8c6 = out_time;
        strength_goal = 0;
        distortion_goal = 0;
        radius_goal = 0;
        break;
    }

    if(state != "/\xc8,\r") {
      level.var_8d3a8b3f129ac352 = "<dev string:x4f3>";

      done1 = function_7f948d2377a2c48a(@ "r_mbradialoverridestrength", state, var_561023b55bddc3ea, strength_goal, var_25cd69ada7d56759, var_7f0c01b16833c8c6, var_207da73d1d051029);
      done2 = function_7f948d2377a2c48a(@ "r_mbradialoverridedistortion", state, var_561023b55bddc3ea, distortion_goal, var_5e2619b449f16c77, var_7f0c01b16833c8c6, var_207da73d1d051029);
      done3 = function_7f948d2377a2c48a(@ "r_mbradialoverrideradius", state, var_561023b55bddc3ea, radius_goal, var_59dfb69dd53177b2, var_7f0c01b16833c8c6, var_207da73d1d051029);
      var_28edfa30e34107a0 = done1 && done2 && done3;

      if(var_28edfa30e34107a0) {
        text = state + "<dev string:x4f7>" + "<dev string:x4ff>" + var_561023b55bddc3ea + "<dev string:x50a>" + level.var_8d3a8b3f129ac352;
      } else {
        text = state + "<dev string:x4ff>" + var_561023b55bddc3ea + "<dev string:x50a>" + level.var_8d3a8b3f129ac352;
      }
    } else {
      var_1fe26e235baadb05 = var_6b76a60a54ec10e9 - gettime();

      if(var_1fe26e235baadb05 < 0) {
        var_1fe26e235baadb05 = 0;
      }

      text = state + "<dev string:x4ff>" + var_561023b55bddc3ea + "<dev string:x50f>" + var_1fe26e235baadb05 * 0.001 + "<dev string:x519>" + wait_time + "<dev string:x50a>";
    }

    prev_time = gettime();

    if(state != "/\xc8,\r") {
      var_892517a6c28b07bd = var_561023b55bddc3ea;
    }

    if(istrue(level.var_16a5f7329a5c9e70) && var_28edfa30e34107a0) {
      break;
    }

    waitframe();
  }

  level.var_16a5f7329a5c9e70 = undefined;
}

function function_16a5f7329a5c9e70() {
  level.var_16a5f7329a5c9e70 = 1;
}

function function_7f948d2377a2c48a(dvar_name, state, var_561023b55bddc3ea, strength_goal, var_25cd69ada7d56759, var_7f0c01b16833c8c6, var_207da73d1d051029) {
  var_2f6d9e74a7ae15a1 = undefined;
  var_37eb8b76773aaae7 = undefined;
  is_done = 0;
  curr_strength = getdvarfloat(dvar_name);

  if(true) {
    var_37eb8b76773aaae7 = var_561023b55bddc3ea / getdvarfloat(@ "g_speed");
  } else {
    var_37eb8b76773aaae7 = var_561023b55bddc3ea / 340;
  }

  if(var_37eb8b76773aaae7 > 1) {
    var_37eb8b76773aaae7 = 1;
  }

  var_28031fe5487d7b9 = strength_goal * var_37eb8b76773aaae7;

  if(var_7f0c01b16833c8c6 == 0) {
    var_2f6d9e74a7ae15a1 = 1e+06;
  } else {
    var_c8ae00806f904bbb = var_25cd69ada7d56759 / var_7f0c01b16833c8c6;
    var_2f6d9e74a7ae15a1 = var_c8ae00806f904bbb * var_207da73d1d051029 * 0.001;
  }

  if(curr_strength != strength_goal) {
    if(state == "\xb3\xb2") {
      var_fbe28d62e2282413 = curr_strength + var_2f6d9e74a7ae15a1;

      if(var_fbe28d62e2282413 > var_25cd69ada7d56759 * var_37eb8b76773aaae7) {
        var_fbe28d62e2282413 = var_28031fe5487d7b9;
      }
    } else {
      var_fbe28d62e2282413 = curr_strength - var_2f6d9e74a7ae15a1;

      if(var_fbe28d62e2282413 < 0) {
        var_fbe28d62e2282413 = 0;
      }
    }

    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", dvar_name, var_fbe28d62e2282413);
    is_done = 0;
  } else {
    var_fbe28d62e2282413 = curr_strength;
    is_done = 1;
  }

  if(var_25cd69ada7d56759 > 0) {
    dvar_short = "<dev string:x51e>";

    if(dvar_name == @ "r_mbradialoverridedistortion") {
      dvar_short = "<dev string:x525>";
    }

    if(dvar_name == @ "r_mbradialoverrideradius") {
      dvar_short = "<dev string:x52c>";
    }

    level.var_8d3a8b3f129ac352 = dvar_short + "<dev string:x533>" + var_fbe28d62e2282413 + "<dev string:x519>" + var_28031fe5487d7b9 + "<dev string:x50a>" + level.var_8d3a8b3f129ac352;
  }

  return is_done;
}

function function_a51f0a5f5a492ef1(ent, time, target) {
  ent notify("m#\xaf\xb1eA\x93\xe2\xc2");
  ent endon("m#\xaf\xb1eA\x93\xe2\xc2");
  ent endon("\x1e\xfd\xd1\xa2\a");
  startorigin = ent.origin;
  t = 0;

  while(t < time) {
    ent.origin = vectorlerp(startorigin, target, t / time);
    t += 0.05;
    wait 0.05;
  }

  ent.origin = target;
}

function function_3eaa79b606468de1() {
  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>");
    vals = strtok(self.script_parameters, "\xda");
    targettime = float(vals[0]);
    targetdistance = float(vals[1]);
    thread sunshadowscale_lerp(targettime, targetdistance);
    waitframe();

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_aed1bb84b30d270f(var_6434609b2dba330e, var_647e43cda6ca73b5, var_3ee92cb45c5c9456, spotdistcull, var_32bb7d07c6a73c16, endflag, var_4e35348a3e7fad11) {
  level endon(endflag);

  if(isDefined(var_3ee92cb45c5c9456)) {
    if(isarray(var_3ee92cb45c5c9456)) {
      foreach(group in var_3ee92cb45c5c9456) {
        lights = getEntArray(group, #script_noteworthy);

        foreach(light in lights) {}
      }
    }
  }

  var_ad40219ca3f6a5e5 = var_647e43cda6ca73b5;
  var_ea45ba8ce0df8bca = [];

  if(isDefined(var_4e35348a3e7fad11)) {
    var_ea45ba8ce0df8bca[0] = (1, 0, 0);
    var_ea45ba8ce0df8bca[1] = (0, 1, 0);
    var_ea45ba8ce0df8bca[2] = (0, 0, 1);
    var_ea45ba8ce0df8bca[3] = (1, 0, 1);
    var_ea45ba8ce0df8bca[4] = (0, 1, 1);
    var_ea45ba8ce0df8bca[5] = (1, 1, 0);
    var_ea45ba8ce0df8bca[6] = (1, 1, 1);
    var_ea45ba8ce0df8bca[7] = (0, 0.5, 0.5);
  }

  if(isDefined(var_647e43cda6ca73b5)) {
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_spotupdatelimit", var_ad40219ca3f6a5e5);
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_spotupdatelimitdynlight", 6);
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_roundrobinpriorityspotshadows", var_ad40219ca3f6a5e5);
  }

  if(isDefined(spotdistcull)) {
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_spotdistcull", spotdistcull);
  }

  lights = getEntArray(var_6434609b2dba330e, #script_noteworthy);
  permanent_lights = [];

  if(isDefined(var_32bb7d07c6a73c16)) {
    permanent_lights = getEntArray(var_32bb7d07c6a73c16, #script_noteworthy);
  }

  while(!isDefined(level.player)) {
    wait 0.2;
  }

  angles = level.player getplayerangles();
  forward = anglesToForward(angles);
  player_eye_pos = level.player.origin + (0, 0, 48);
  trace_result = trace::ray_trace(player_eye_pos, player_eye_pos + forward * 30000);
  var_62c32d9da46b5cb1 = trace_result["\xc1\xbd\xdci\xe8i{7"];
  sorted_lights = sortbydistance(lights, var_62c32d9da46b5cb1);

  while(true) {
    angles = level.player getplayerangles();
    forward = anglesToForward(angles);
    player_eye_pos = level.player.origin + (0, 0, 48);
    trace_result = trace::ray_trace(player_eye_pos, player_eye_pos + forward * 30000);
    var_62c32d9da46b5cb1 = trace_result["\xc1\xbd\xdci\xe8i{7"];
    sorted_lights = sortbydistance(lights, var_62c32d9da46b5cb1);
    var_d1e1507a5bad0524 = [];
    index = 0;

    if(isDefined(var_32bb7d07c6a73c16)) {
      foreach(light in permanent_lights) {
        intensity = light getlightintensity();

        if(intensity < 0.1) {
          continue;
        }

        var_d1e1507a5bad0524[index] = light;
        index += 1;
      }
    }

    foreach(light in sorted_lights) {
      intensity = light getlightintensity();

      if(intensity < 0.1) {
        continue;
      }

      var_d1e1507a5bad0524[index] = light;
      index += 1;
    }

    for(i = 0; i < var_d1e1507a5bad0524.size; i++) {
      dist = distance(var_d1e1507a5bad0524[i].origin, level.player.origin);
      dot = vectordot(vectorNormalize(var_d1e1507a5bad0524[i].origin - level.player.origin), forward);

      if(dist < spotdistcull) {
        if(isDefined(var_4e35348a3e7fad11) && var_4e35348a3e7fad11) {
          line(var_62c32d9da46b5cb1, var_d1e1507a5bad0524[i].origin, var_ea45ba8ce0df8bca[i], 1, 0, 4);
        }
      }
    }

    if(var_d1e1507a5bad0524.size > var_ad40219ca3f6a5e5) {
      for(i = var_ad40219ca3f6a5e5; i < var_d1e1507a5bad0524.size; i++) {}
    }

    wait 0.4;
  }
}

function function_bf27b3982a88dec1() {
  level.var_a9419315ec573da6 = 0;
  waitframe();
}

function dazed_effect(intensity, time) {
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbenable", 1);

  if(!isDefined(time)) {
    time = 3;
  }

  if(intensity == 1) {
    level thread function_5673a2ea7e09c653(time);
  }

  if(intensity == 2) {
    level thread function_b3d421f2c8025763(time);
  }

  if(intensity == 3) {
    level thread function_52fe9d09d4092b09(time);
  }
}

function function_5673a2ea7e09c653(time) {
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscale", 1);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscaleviewmodel", 3);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0.07);
  wait time;
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscale", 0);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscaleviewmodel", 0);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0);
  wait 0.05;
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbenable", 0);
}

function function_b3d421f2c8025763(time) {
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscale", 2);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscaleviewmodel", 2);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0.05);
  wait 0.1;
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscale", 1);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbvelocityscaleviewmodel", 1);
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0.007);
  wait time;
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0);
  wait 0.05;
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbenable", 0);
}

function function_52fe9d09d4092b09(time) {
  thread function_5586ddeb60ce265d(0.007, 0.2);
  wait time;
  thread function_5586ddeb60ce265d(0, 1);
}

function function_5586ddeb60ce265d(end_value, duration) {
  start_value = getdvarfloat(@ "r_mbradialoverridestrength");
  t = 0;

  while(t <= duration) {
    time_fraction = t / duration;
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", math::lerp(start_value, end_value, time_fraction));
    waitframe();
    t += 0.05;
  }

  if(end_value == 0) {
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_mbradialoverridestrength", 0);
  }
}

function lerp_dvar(dvar, end_value, duration) {
  start_value = getdvarfloat(dvar);
  level endon("\xdct\xb7\x0e_\x91\xec,r}\xc6\xac\xe4\xe0");
  t = 0.05;

  while(t <= duration + 0.0001) {
    time_fraction = t / duration;
    time_fraction = round(time_fraction, 0.0001);
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", dvar, math::lerp(start_value, end_value, time_fraction));
    waitframe();
    t += 0.05;
  }
}

function function_72dc8e6f1255be2b() {
  function_3983b538b431a91a("\x91\xca\xcc\v\xab\xd8:", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  function_3983b538b431a91a("\a?A\xee\a\xe0\xb8\xff\x0e\a\xdf\x02\x1f;", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  function_3983b538b431a91a("\xfeu\xbaM \xdd\xb6c\x87\xf1\xe1G\xf4D\xfa\xa5\xdf\xc8\x94\x1e\x11L\xa1\a,", 1, 50, 4, 1000, 7000, 0.05, 0.5);
  function_3983b538b431a91a("\x93\xa5\xb3\xb2\x9c", 1, 104, 9, 500, 500, 1.8, 0.5);
  function_3983b538b431a91a("\xceL\xd9\xf1\x13\x0f\x7f\xb3\x97V`\x96\x01N\xaf8/\x1a\xdfn\xc0y\xcc\xca\x96%", 1, 500, 10, 1000, 7000, 0.05, 0.5);
}

function function_3983b538b431a91a(name, nstart, nend, nblur, fstart, fend, fblur, fbias) {
  if(!isDefined(level._light.dof_presets)) {
    level._light.dof_presets = [];
  }

  new_dof = [];
  new_dof["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = nstart;
  new_dof["ob\x14J\x84\x02\x9d"] = nend;
  new_dof["9\x90\xb5\xe7u\tV\xd4"] = nblur;
  new_dof["3X\x9c\xa6\xd1a\xe4\xa3"] = fstart;
  new_dof[":\x80A!tU"] = fend;
  new_dof["\xd4\x12\x1b\x8d\x1a\v\xb8"] = fblur;
  new_dof["\x10i\x96\xaf"] = fbias;
  level._light.dof_presets[name] = new_dof;
}

function function_c9a0380854d789a5(name) {
  if(isDefined(level._light.dof_presets) && isDefined(level._light.dof_presets[name])) {
    return level._light.dof_presets[name];
  }

  println("<dev string:x538>" + name + "<dev string:x568>");
}

function function_488a8d2e640c0d90(preset1, preset2, time) {
  assert(isDefined(preset1));
  assert(isDefined(preset2));
  assert(isDefined(time) && time >= 0);

  if(isDefined(level._light.dof_presets)) {
    dof1 = function_c9a0380854d789a5(preset1);
    dof2 = function_c9a0380854d789a5(preset2);

    if(isDefined(dof1) && isDefined(dof2)) {}
  }
}

function function_aea0384f057ce6c6() {
  function_63fc2f055c250141("\x91\xca\xcc\v\xab\xd8:", 2, 8);
  function_63fc2f055c250141("\a?A\xee\a\xe0\xb8\xff\x0e\a\xdf\x02\x1f;", 10, 90);
  function_63fc2f055c250141("a\xa1\xc4", 2, 128);
}

function function_63fc2f055c250141(name, start, end) {
  if(!isDefined(level._light.var_e5173ade0238ba55)) {
    level._light.var_e5173ade0238ba55 = [];
  }

  var_fd31d164b94bf0a7["\x17\xad\v\xde8"] = start;
  var_fd31d164b94bf0a7["8\xdb\x90"] = end;
  level.player.var_dc6d9cbe6e0408c5 = var_fd31d164b94bf0a7["\x17\xad\v\xde8"];
  level.player.var_4c7156d656c0d36c = var_fd31d164b94bf0a7["8\xdb\x90"];
  level._light.var_e5173ade0238ba55[name] = var_fd31d164b94bf0a7;
}

function function_ce214e0e3e1c21ca(name) {
  if(isDefined(level._light.var_e5173ade0238ba55) && isDefined(level._light.var_e5173ade0238ba55[name])) {
    return level._light.var_e5173ade0238ba55[name];
  }

  println("<dev string:x538>" + name + "<dev string:x568>");
}

function function_e9d11c007ea38a29(preset1, preset2, time) {
  assert(isDefined(preset1));
  assert(isDefined(preset2));
  assert(isDefined(time) && time >= 0);

  if(isDefined(level._light.var_e5173ade0238ba55)) {
    start_viewmodel = function_ce214e0e3e1c21ca(preset1);
    end_viewmodel = function_ce214e0e3e1c21ca(preset2);

    if(isDefined(start_viewmodel) && isDefined(end_viewmodel)) {
      function_e85fdf74454314e6(start_viewmodel, end_viewmodel, time);
    }
  }
}

function function_e85fdf74454314e6(start_viewmodel, end_viewmodel, time) {
  if(time > 0) {
    var_c8429109e018017 = (end_viewmodel["\x17\xad\v\xde8"] - start_viewmodel["\x17\xad\v\xde8"]) * 0.05 / time;
    var_7a5f65e862add452 = (end_viewmodel["8\xdb\x90"] - start_viewmodel["8\xdb\x90"]) * 0.05 / time;
    thread lerp_viewmodel_dof(end_viewmodel, var_c8429109e018017, var_7a5f65e862add452);
    return;
  }

  level.player.var_dc6d9cbe6e0408c5 = end_viewmodel["\x17\xad\v\xde8"];
  level.player.var_4c7156d656c0d36c = end_viewmodel["8\xdb\x90"];
}

function lerp_viewmodel_dof(end_viewmodel, var_c8429109e018017, var_7a5f65e862add452) {
  level notify("\xf1\xe5\x14|\xa1\xc7\x97\xda\xee.\xd2,t^\x12\x16\x80\x97");
  level endon("\xf1\xe5\x14|\xa1\xc7\x97\xda\xee.\xd2,t^\x12\x16\x80\x97");
  start_done = 0;
  end_done = 0;

  while(!start_done || !end_done) {
    if(!start_done) {
      level.player.var_dc6d9cbe6e0408c5 += var_c8429109e018017;

      if(var_c8429109e018017 > 0 && level.player.var_dc6d9cbe6e0408c5 > end_viewmodel["\x17\xad\v\xde8"] || var_c8429109e018017 < 0 && level.player.var_dc6d9cbe6e0408c5 < end_viewmodel["\x17\xad\v\xde8"]) {
        level.player.var_dc6d9cbe6e0408c5 = end_viewmodel["\x17\xad\v\xde8"];
        start_done = 1;
      }
    }

    if(!end_done) {
      level.player.var_4c7156d656c0d36c += var_7a5f65e862add452;

      if(var_7a5f65e862add452 > 0 && level.player.var_4c7156d656c0d36c > end_viewmodel["8\xdb\x90"] || var_7a5f65e862add452 < 0 && level.player.var_4c7156d656c0d36c < end_viewmodel["8\xdb\x90"]) {
        level.player.var_4c7156d656c0d36c = end_viewmodel["8\xdb\x90"];
        end_done = 1;
      }
    }

    level.player setviewmodeldepthoffield(level.player.var_dc6d9cbe6e0408c5, level.player.var_4c7156d656c0d36c);
    wait 0.05;
  }
}

function lighting_target_dof(player, target, aperture, var_5845965a97c45a4c, var_656869b5fe619ca, tag) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x57e>");
    return;
  }

  if(!isDefined(aperture)) {
    assertmsg("<dev string:x5c4>");
    return;
  }

  level notify("\xbap\xf2\xe6Q\x18\x89w\xf6\xf1\x99\x0f\xe3\xce\xd8\x18\xfa\xf8\xce\xe2\x19\x98\x83");
  level endon("\xbap\xf2\xe6Q\x18\x89w\xf6\xf1\x99\x0f\xe3\xce\xd8\x18\xfa\xf8\xce\xe2\x19\x98\x83");

  if(!isDefined(var_5845965a97c45a4c)) {
    var_5845965a97c45a4c = 1;
  }

  if(!isDefined(var_656869b5fe619ca)) {
    var_656869b5fe619ca = 1;
  }

  level thread function_7adf8f933e4e4883();
  waitframe();
  level.player enablephysicaldepthoffieldscripting();
  fstop = aperture;
  utility::flag_clear("\xd9aG8\xdfj\x01\xe9\x04\xdfmP\x98^\x15\xd7r");

  while(true) {
    if(!isDefined(target)) {
      assertmsg("<dev string:x60c>");
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

    level.player setphysicaldepthoffield(fstop, dof_dist, var_5845965a97c45a4c, var_656869b5fe619ca);

    if(isDefined(level.var_1defd051b9fb5f2c)) {
      if(isDefined(tag)) {
        print3d(target gettagorigin(tag), "<dev string:x661>", (1, 1, 1), 1, 1, 2);

        iprintln(dof_dist);
      } else {
        print3d(target.origin, "<dev string:x661>", (1, 1, 1), 1, 1, 2);

        iprintln(dof_dist);
      }
    }

    waitframe();
  }
}

function function_7adf8f933e4e4883() {
  level waittill("\xbap\xf2\xe6Q\x18\x89w\xf6\xf1\x99\x0f\xe3\xce\xd8\x18\xfa\xf8\xce\xe2\x19\x98\x83");
  utility::flag_set("\xd9aG8\xdfj\x01\xe9\x04\xdfmP\x98^\x15\xd7r");
  level.player disablephysicaldepthoffieldscripting();
}

function function_c9080e518ef4456c(time, materials, fadein_, fadeout_, var_5de6009425a368e6, xpos, ypos, sort) {
  assert(isDefined(time));
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay.splatter = 1;
  overlay.alignx = "=\xff0b";
  overlay.aligny = "\x1d Q";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.alpha = var_5de6009425a368e6;
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

    if(isDefined(var_5de6009425a368e6)) {
      assert(var_5de6009425a368e6 >= 0);
      max_alpha = clamp(var_5de6009425a368e6, 0, 1);
    }

    step_time = 0.05;

    if(fadein > 0) {
      current_alpha = 0;
      increment_alpha = max_alpha / fadein / step_time;
      assert(increment_alpha > 0, "<dev string:x666>");

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
        assert(decrement_alpha > 0, "<dev string:x68d>");

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
  level waittill("8\x9bj\x80\xcf\xd5\x1cjK\x18Q\xebJ\x10\x939\x91");
  self destroy();
}

function function_7e78be3eca511047() {}

function function_d45254ef89251854() {
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("\xe9\xd8\xbe\x88!\xa6\xa2\x89\x8d@\x86\xd9$V\x90\xc0\xe9hn\xcc\xf1\x97", 640, 480);
  overlay setshader("+\xa8$\x1cw\xa4\x03\xb2\xb2sTk\x10^\f\xaf;aC|\xc6\xcc\xab\xac", 640, 480);
  overlay setshader("/\x04\x84mOj\x06\x12*\xd3S<gz\xd4\xe1,D\x8e\v", 640, 480);
  overlay setshader("\xb1R\b\xca\x94]\x06\xd2*s}\xa3\xfe,\x1awS\xced\xa1\xe9", 640, 480);
  overlay.splatter = 1;
  overlay.alignx = "=\xff0b";
  overlay.aligny = "\x1d Q";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.alpha = 1;
  overlay fadeovertime(3);
  overlay.alpha = 0;
}

function bob_mask(hudelement) {
  self endon("\x7f\xf1\xee\x01A\xd3.8\"\xa4m\x83\x15");
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
      var_67bcf658e8ff69eb = 0.1 + speedscale * 0.25;
      var_345ac97eab9a2364 = 0.1 + speedscale * 0.25;
      bobscale = 1;

      if(stance == "1x\xc5\xb4\xabx") {
        bobscale = 0.75;
      }

      if(stance == "GX\xa9]\x82") {
        bobscale = 0.4;
      }

      if(stance == "\x8b\x90\xb5\xc4W") {
        bobscale = 1;
      }

      idlespeed = 5;
      adsspeed = 0.9;
      playerads = level.player playerads();
      bobspeed = idlespeed * (1 - playerads) + adsspeed * playerads;
      bobspeed *= 1 + speedscale * 2;
      var_c0a195377260d388 = 5;
      var_efd9309e6a432592 = var_c0a195377260d388 * var_67bcf658e8ff69eb * bobscale;
      var_d763e36410abae29 = var_c0a195377260d388 * var_345ac97eab9a2364 * bobscale;
      weapidletime += frametime * 1000 * bobspeed;
      var_bf4502ac2554e9e6 = 57.2958;
      verticalbob = sin(weapidletime * 0.001 * var_bf4502ac2554e9e6);
      horizontalbob = sin(weapidletime * 0.0007 * var_bf4502ac2554e9e6);
      anglediffyaw = angleclamp180(angles[1] - previousangles[1]);
      anglediffyaw = clamp(anglediffyaw, -10, 10);
      offsetxtarget = anglediffyaw / 10 * var_c0a195377260d388 * (1 - var_67bcf658e8ff69eb);
      offsetxchange = offsetxtarget - offsetx;
      offsetx += clamp(offsetxchange, -1, 1);
      offsetytarget = clamp(zvelocity, -200, 200) / 200 * var_c0a195377260d388 * (1 - var_345ac97eab9a2364);
      offsetychange = offsetytarget - offsety;
      offsety += clamp(offsetychange, -0.6, 0.6);
      hudelement moveovertime(0.05);
      hudelement.x = addxoffset + clamp(verticalbob * var_efd9309e6a432592 + offsetx - var_c0a195377260d388, 0 - 2 * var_c0a195377260d388, 0);
      hudelement.y = addyoffset + clamp(horizontalbob * var_d763e36410abae29 + offsety - var_c0a195377260d388, 0 - 2 * var_c0a195377260d388, 0);
      previousangles = angles;
    }

    wait frametime;
  }
}

function function_52053b5fdca62c53(bfadein, fadeouttime, fadeintime, darktime) {
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
    hud_util::fade_out(fadeouttime);
  }

  self.var_e8ba603c4c38a933 = newclienthudelem(self);
  self.var_e8ba603c4c38a933.x = 0;
  self.var_e8ba603c4c38a933.y = 0;
  self.var_e8ba603c4c38a933.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.var_e8ba603c4c38a933.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.var_e8ba603c4c38a933.foreground = 0;
  self.var_e8ba603c4c38a933.sort = -1;
  self.var_e8ba603c4c38a933 setshader("[S\xe8\xbaN\x9d+\xff\xb3\xed\x16\x8a\xfbLUi\x9fB\x0f\xfdn\xcf\xa7\xf5\xf3\xec", 650, 138);
  self.var_e8ba603c4c38a933.alpha = 1;
  self.var_1a5f41308de3e024 = newclienthudelem(self);
  self.var_1a5f41308de3e024.x = 0;
  self.var_1a5f41308de3e024.y = 352;
  self.var_1a5f41308de3e024.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.var_1a5f41308de3e024.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.var_1a5f41308de3e024.foreground = 0;
  self.var_1a5f41308de3e024.sort = -1;
  self.var_1a5f41308de3e024 setshader("7\xf8v\xd4\xbbKg\xa0\x80\x0fN\xa9\xf0? G-\xe8\x19\xf0\xfb\xe3\xc5\xda\x80\x1d\xc2\n\xd5", 650, 138);
  self.var_1a5f41308de3e024.alpha = 1;
  level.player utility::delaythread(1, &gasmask_breathing);
  thread bob_mask(self.var_e8ba603c4c38a933);
  thread bob_mask(self.var_1a5f41308de3e024);

  if(bfadein) {
    wait darktime;
    hud_util::fade_in(fadeintime);
  }
}

function function_8a937add1ca3ba7d() {
  assert(isPlayer(self));
  hud_util::fade_out(0.25);
  self notify("\x7f\xf1\xee\x01A\xd3.8\"\xa4m\x83\x15");

  if(isDefined(self.var_e8ba603c4c38a933)) {
    self.var_e8ba603c4c38a933 destroy();
    self.var_e8ba603c4c38a933 = undefined;
  }

  if(isDefined(self.var_1a5f41308de3e024)) {
    self.var_1a5f41308de3e024 destroy();
    self.var_1a5f41308de3e024 = undefined;
  }

  level.player notify("7\x1d\xf6\a\xebLNVX\xa3\xd0\xb4\xe6\xce");
  wait 0.25;
  hud_util::fade_in(1.5);
}

function gasmask_breathing() {
  delay = 1;
  self endon("7\x1d\xf6\a\xebLNVX\xa3\xd0\xb4\xe6\xce");

  while(true) {
    wait delay;
  }
}

function function_e27a2db8793c3e3() {
  self.gasmask = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
  self.gasmask setModel("\x1c\x93\xbdp\xafn,7\xbe\xd9,s\xadX\xdc\xd6");
  self.gasmask linkTo(self, "\xc7\xae?f\x10\xbcr", (-4, 0, 2), (120, 0, 0));
}

function function_205a2e0d7df43c5d() {
  if(isDefined(self.gasmask)) {
    self.gasmask delete();
  }
}

function sunshadowscale_lerp(time, targetsample) {
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_sunmoving", 1);
  currframe = 0;
  numframes = time * 20;
  numframes_less = numframes - 1;
  currsample = getdvarfloat(@ "sm_sunsamplesizenear");

  while(currframe < numframes) {
    var_797faaeed60c2759 = (targetsample - currsample) * currframe / numframes_less;
    var_797faaeed60c2759 += currsample;
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_sunsamplesizenear", var_797faaeed60c2759);
    currframe++;
    waitframe();
  }

  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "sm_sunmoving", 0);
}

function function_1d5226938748a43(time, target_value) {
  level notify("\xc6\x1aX\xcd;Z\xcd;\xaf;\xde\xd8\xba\xd6\xb2:\xc9K\xc6\x11Yp\x1d\xd0");
  level endon("\xc6\x1aX\xcd;Z\xcd;\xaf;\xde\xd8\xba\xd6\xb2:\xc9K\xc6\x11Yp\x1d\xd0");
  old_value = getDvar(@ "r_volumetricdepth");

  if(!isDefined(old_value) || target_value == old_value) {
    return;
  }

  start_time_ms = gettime();
  end_time_ms = gettime() + time * 1000;
  time_ms = time * 1000;

  while(gettime() <= end_time_ms) {
    time_percentage = 1 - (end_time_ms - gettime()) / time_ms;
    var_c044e2db17b94102 = math::lerp(old_value, target_value, time_percentage);
    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_volumetricdepth", var_c044e2db17b94102);
    waitframe();
  }

  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "r_volumetricdepth", target_value);
}

function function_955f7fa62b5770f0() {
  utility::flag_init("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea");
  utility::flag_init("\x02\x1b\xaf&GE\xfcH\x9bZpqc\xcc\a\x86\x8d\xd1\xe6\x02\x7f&\xf4");
  utility::flag_init("\x83\xb8)\x11\x04\xfd\xf6\x911\x964\x8a\x9d\xd9\xbb\x1a\xd2\x85\x1b\x85\x04\xf8");
  utility::flag_wait("t\x8d\x80w\xe0,\xd4\x84\x9c%\x12(\x9c\xa9\\H\xb8E\xc8O\x18\xd2%<d\x81\b");
  thread function_b1c230f4bfab1499();
  thread function_a1fb2d121398dba8();
}

function function_b1c230f4bfab1499() {
  level.grass_dof_trigger_count = 0;
  var_83b8d6913b740144 = getEntArray("\xa5\xa6\x1aRc?\xca\xb0\x88\xe4\xc2\xc3", #targetname);

  foreach(grass_dof_trigger in var_83b8d6913b740144) {
    grass_dof_trigger thread function_3849223957a8d668();
  }

  while(true) {
    level waittill("\x9f\xb3>\r\f#\x9eX\xe7M\a)u\xca\xf7\xe5\xec\xaf\xe7\x94w\x83\xfc6\x89\xce\xc1XG\xae\x16");
    waittillframeend();

    if(level.grass_dof_trigger_count > 0) {
      utility::flag_set("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea");
      continue;
    }

    utility::flag_clear("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea");
  }
}

function function_3849223957a8d668() {
  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player function_77c8c87519d541a()) {
      level.grass_dof_trigger_count++;
      level notify("\x9f\xb3>\r\f#\x9eX\xe7M\a)u\xca\xf7\xe5\xec\xaf\xe7\x94w\x83\xfc6\x89\xce\xc1XG\xae\x16");

      while(player istouching(self) && player function_77c8c87519d541a()) {
        wait 0.1;
      }

      level.grass_dof_trigger_count--;
      level notify("\x9f\xb3>\r\f#\x9eX\xe7M\a)u\xca\xf7\xe5\xec\xaf\xe7\x94w\x83\xfc6\x89\xce\xc1XG\xae\x16");
    }
  }
}

function function_77c8c87519d541a() {
  stance = self getstance();

  if(stance != "\x8b\x90\xb5\xc4W") {
    if(stance == "1x\xc5\xb4\xabx") {
      utility::flag_set("\x02\x1b\xaf&GE\xfcH\x9bZpqc\xcc\a\x86\x8d\xd1\xe6\x02\x7f&\xf4");
      utility::flag_clear("\x83\xb8)\x11\x04\xfd\xf6\x911\x964\x8a\x9d\xd9\xbb\x1a\xd2\x85\x1b\x85\x04\xf8");
    } else if(stance == "GX\xa9]\x82") {
      utility::flag_set("\x83\xb8)\x11\x04\xfd\xf6\x911\x964\x8a\x9d\xd9\xbb\x1a\xd2\x85\x1b\x85\x04\xf8");
      utility::flag_clear("\x02\x1b\xaf&GE\xfcH\x9bZpqc\xcc\a\x86\x8d\xd1\xe6\x02\x7f&\xf4");
    }

    return true;
  }

  return false;
}

function function_a1fb2d121398dba8() {
  wait 0.05;

  while(true) {
    utility::flag_wait("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea");

    while(utility::flag("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea") && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 0) {
      level.player enablephysicaldepthoffieldscripting();

      if(utility::flag("\x02\x1b\xaf&GE\xfcH\x9bZpqc\xcc\a\x86\x8d\xd1\xe6\x02\x7f&\xf4") == 1 && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 0) {
        level.player setphysicaldepthoffield(2, 400);
        level.player setphysicalviewmodeldepthoffield(1, 25);
        wait 0.1;
      }

      if(utility::flag("\x83\xb8)\x11\x04\xfd\xf6\x911\x964\x8a\x9d\xd9\xbb\x1a\xd2\x85\x1b\x85\x04\xf8") == 1 && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 0) {
        level.player setphysicaldepthoffield(0.25, 800);
        level.player setphysicalviewmodeldepthoffield(0.5, 25);
        wait 0.1;
      }

      wait 0.1;
    }

    if(utility::flag("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea") && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 1) {
      while(utility::flag("\x17\xb2Wo\xee\x86\x0f\xcdPd)<\x90#\xe7\xea") && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 1) {
        level.player enablephysicaldepthoffieldscripting();

        if(utility::flag("\x02\x1b\xaf&GE\xfcH\x9bZpqc\xcc\a\x86\x8d\xd1\xe6\x02\x7f&\xf4") == 1 && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 1) {
          level.player setphysicaldepthoffield(2, 400);
          wait 0.1;
        }

        if(utility::flag("\x83\xb8)\x11\x04\xfd\xf6\x911\x964\x8a\x9d\xd9\xbb\x1a\xd2\x85\x1b\x85\x04\xf8") == 1 && utility::flag("\x8a\xe1\"\x8b\xf15\xda\xa19\xb1+{\xc7\x1dNkW\xfc") == 1) {
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

function function_1faf07d2a2d9e448() {
  function_987ec0b537dac445(%"hw_cine_lastgen");
}

function function_ef11b3adf76f7adc() {
  function_59d0dd333cdb3332(%"hw_cine_lastgen");
}

function function_8cb2b89b173b7d69(duration, end_value) {
  self notify("/\x93\xae\xc7\xd8\xb7M\x1c\x12\xa9x\xbf\xef,\xf0\xf6\x95\xe1");
  self endon("/\x93\xae\xc7\xd8\xb7M\x1c\x12\xa9x\xbf\xef,\xf0\xf6\x95\xe1");
  self endon("\x1e\xfd\xd1\xa2\a");
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
  self notify("\xdbw:Em\fC\xd8\xe4^\xed\xdd\\\x9a\xb5\\\x15\xae\xfa\xc5X");
  self endon("\xdbw:Em\fC\xd8\xe4^\xed\xdd\\\x9a\xb5\\\x15\xae\xfa\xc5X");
  self endon("\x1e\xfd\xd1\xa2\a");
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

function function_21d594b91db8fd2a(time, endsunintensity) {
  startsunintensity = getsuncolorandintensity();
  t = 0;

  while(t < time) {
    new_sunintensity = startsunintensity[3] + (endsunintensity - startsunintensity[3]) * t / time;
    t += 0.05;
    setsuncolorandintensity(new_sunintensity);
    wait 0.05;
  }

  setsuncolorandintensity(endsunintensity);
}

function function_62ea8f58003ea454(time, endsuncolor) {
  startsuncolor = getsuncolorandintensity();
  start_intensity = startsuncolor[3];
  t = 0;

  while(t < time) {
    new_suncolor = [startsuncolor[0] + (endsuncolor[0] - startsuncolor[0]) * t / time, startsuncolor[1] + (endsuncolor[1] - startsuncolor[1]) * t / time, startsuncolor[2] + (endsuncolor[2] - startsuncolor[2]) * t / time];
    t += 0.05;
    setsuncolorandintensity(new_suncolor[0], new_suncolor[1], new_suncolor[2]);
    wait 0.05;
  }

  setsuncolorandintensity(endsuncolor[0], endsuncolor[1], endsuncolor[2]);
}

function function_f86c59b297ac4728(timeleft) {
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

function private function_abfe2529dcddd39() {
  setdvarifuninitialized(@ "hash_49acd06fabbd1dd3", "<dev string:x6b4>");

  if(getDvar(@ "hash_49acd06fabbd1dd3") == "<dev string:x6b9>") {
    reference_triggers = getEntArray("<dev string:x6be>", #classname);

    foreach(trigger in reference_triggers) {
      thread function_36f7b5a49735c46a(trigger);
    }
  }
}

function private function_36f7b5a49735c46a(trigger) {
  delete_trigger = 1;

  delete_trigger = 0;

  if(!isDefined(trigger.script_noteworthy)) {
    return;
  }

  settings = function_859e529aaf5b1a48(trigger.script_parameters);

  while(true) {
    trigger waittill("<dev string:x6e2>", other);

    if(!isalive(other) || !isPlayer(other)) {
      continue;
    }

    function_3b25c1eeedf1cb48(trigger.script_noteworthy);

    if(utility::issp()) {
      setsaveddvar(@ "hash_1b40dfa165e76236", settings["<dev string:x6ed>"]);
      setsaveddvar(@ "hash_ac4e80946d58eaf", settings["<dev string:x6f6>"]);
      setsaveddvar(@ "hash_28b6983a06668e89", "<dev string:x6b9>");
    } else {
      setDvar(@ "hash_1b40dfa165e76236", settings["<dev string:x6ed>"]);
      setDvar(@ "hash_ac4e80946d58eaf", settings["<dev string:x6f6>"]);
      setDvar(@ "hash_28b6983a06668e89", "<dev string:x6b9>");
    }

    while(other istouching(trigger)) {
      wait 0.1;
    }

    if(utility::issp()) {
      setsaveddvar(@ "hash_28b6983a06668e89", "<dev string:x6b4>");
      continue;
    }

    setDvar(@ "hash_28b6983a06668e89", "<dev string:x6b4>");
  }

  if(delete_trigger) {
    trigger delete();
  }
}

function private function_859e529aaf5b1a48(param_string) {
  setting = [];
  bound = "<dev string:x702>";
  stop_adj = "<dev string:x6b4>";

  if(!isDefined(param_string) || param_string == "<dev string:x4f3>") {
    setting["<dev string:x6f6>"] = stop_adj;
    setting["<dev string:x6ed>"] = bound;
    return setting;
  }

  string_tokens = utility::string_split(param_string, "<dev string:x70f>");

  if(string_tokens.size == 1) {
    bound = string_tokens[0];
  } else if(string_tokens.size == 2) {
    bound = string_tokens[0];
    stop_adj = string_tokens[1];
  }

  setting["<dev string:x6f6>"] = stop_adj;
  setting["<dev string:x6ed>"] = bound;
  return setting;
}

# /