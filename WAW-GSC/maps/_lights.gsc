/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_lights.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

flickerLight(color0, color1, minDelay, maxDelay) {
  toColor = color0;
  delay = 0.0;

  for(;;) {
    fromColor = toColor;
    toColor = color0 + (color1 - color0) * randomfloat(1.0);

    if(minDelay != maxDelay) {
      delay += randomfloatrange(minDelay, maxDelay);
    } else {
      delay += minDelay;
    }

    colorDeltaPerTime = (fromColor - toColor) * (1 / delay);
    while(delay > 0) {
      self setLightColor(toColor + colorDeltaPerTime * delay);
      wait 0.05;
      delay -= 0.05;
    }
  }
}

generic_pulsing() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setLightIntensity(0);
    return;
  }

  on = self getLightIntensity();
  off = .05;
  curr = on;
  transition_on = .3;
  transition_off = .6;
  increment_on = (on - off) / (transition_on / .05);
  increment_off = (on - off) / (transition_off / .05);

  for(;;) {
    time = 0;
    while((time < transition_off)) {
      curr -= increment_off;
      self setLightIntensity(curr);
      time += .05;
      wait(.05);
    }

    wait(1);

    time = 0;
    while(time < transition_on) {
      curr += increment_on;
      self setLightIntensity(curr);
      time += .05;
      wait(.05);
    }

    wait(.5);
  }
}

generic_double_strobe() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setLightIntensity(0);
    return;
  }

  on = self getLightIntensity();
  off = .05;
  linked_models = false;
  lit_model = undefined;
  unlit_model = undefined;
  linked_lights = false;
  linked_light_ents = [];

  if(isDefined(self.script_noteworthy)) {
    linked_things = getEntArray(self.script_noteworthy, "targetname");
    for(i = 0; i < linked_things.size; i++) {
      if(linked_things[i].classname == "light") {
        linked_lights = true;
        linked_light_ents[linked_light_ents.size] = linked_things[i];
      }
      if(linked_things[i].classname == "script_model") {
        lit_model = linked_things[i];
        unlit_model = getent(lit_model.target, "targetname");
        linked_models = true;
      }
    }

  }

  for(;;) {
    self setLightIntensity(off);
    if(linked_models) {
      lit_model hide();
      unlit_model show();
    }
    wait(.8);

    self setLightIntensity(on);
    if(linked_models) {
      lit_model show();
      unlit_model hide();
    }
    wait(.1);

    self setLightIntensity(off);
    if(linked_models) {
      lit_model hide();
      unlit_model show();
    }
    wait(.12);

    self setLightIntensity(on);
    if(linked_models) {
      lit_model show();
      unlit_model hide();
    }
    wait(.1);
  }
}

getclosests_flickering_model(origin) {
  array = getEntArray("light_flicker_model", "targetname");
  return_array = [];
  model = getclosest(origin, array);
  if(isDefined(model)) {
    return_array[0] = model;
  }
  return return_array;
}

generic_flickering() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self setLightIntensity(0);
    return;
  }

  min_flickerless_time = 0.2;
  max_flickerless_time = 1.5;
  if(isDefined(self.script_wait_min)) {
    min_flickerless_time = self.script_wait_min;
  }

  if(isDefined(self.script_wait_max)) {
    max_flickerless_time = self.script_wait_max;
  }

  min_flicker_delay = 0.05;
  max_flicker_delay = 0.1;
  if(isDefined(self.script_delay_min)) {
    min_flicker_delay = self.script_delay_min;
  }

  if(isDefined(self.script_delay_max)) {
    max_flicker_delay = self.script_delay_max;
  }

  min_intensity = 0;
  max_intensity = 0.3;
  if(isDefined(self.script_intensity_min)) {
    min_intensity = self.script_intensity_min;
  }

  if(isDefined(self.script_intensity_max)) {
    max_intensity = self.script_intensity_max;
  }

  min_burst = 1;
  max_burst = 10;
  if(isDefined(self.script_burst_min)) {
    min_burst = self.script_burst_min;
  }

  if(isDefined(self.script_burst_max)) {
    max_burst = self.script_burst_max;
  }

  on = self GetLightIntensity();
  off = 0;
  curr = on;
  num = 0;
  linked_models = false;
  lit_model = undefined;
  unlit_model = undefined;
  linked_lights = false;
  linked_light_ents = [];
  linked_things = [];

  if(isDefined(self.script_noteworthy)) {
    linked_things = getEntArray(self.script_noteworthy, "targetname");
  }

  if(!linked_things.size) {
    linked_things = getclosests_flickering_model(self.origin);
  }

  for(i = 0; i < linked_things.size; i++) {
    if(linked_things[i].classname == "light") {
      linked_lights = true;
      linked_light_ents[linked_light_ents.size] = linked_things[i];
    }

    if(linked_things[i].classname == "script_model") {
      lit_model = linked_things[i];
      unlit_model = GetEnt(lit_model.target, "targetname");
      linked_models = true;
    }
  }

  for(;;) {
    num = RandomIntRange(min_burst, max_burst);
    while(num) {
      wait(RandomFloatRange(min_flicker_delay, max_flicker_delay));
      if(curr > (on * 0.5)) {
        curr = RandomFloatRange(min_intensity, max_intensity);
        if(linked_models) {
          lit_model Hide();
          unlit_model Show();
        }
      } else {
        curr = on;
        if(linked_models) {
          lit_model Show();
          unlit_model Hide();
        }
      }

      self SetLightIntensity(curr);
      if(linked_lights) {
        for(i = 0; i < linked_light_ents.size; i++) {
          linked_light_ents[i] SetLightIntensity(curr);
        }
      }
      num--;
    }

    self SetLightIntensity(on);
    if(linked_lights) {
      for(i = 0; i < linked_light_ents.size; i++) {
        linked_light_ents[i] SetLightIntensity(on);
      }
    }

    if(linked_models) {
      lit_model Show();
      unlit_model Hide();
    }

    wait(RandomFloatRange(min_flickerless_time, max_flickerless_time));
  }
}

flickerLightIntensity(minDelay, maxDelay) {
  on = self getLightIntensity();
  off = 0;
  curr = on;
  num = 0;

  for(;;) {
    num = randomintrange(1, 10);
    while(num) {
      wait(randomfloatrange(.05, .1));
      if(curr > .2) {
        curr = randomfloatrange(0, .3);
      } else {
        curr = on;
      }

      self setLightIntensity(curr);
      num--;
    }

    self setLightIntensity(on);
    wait(randomfloatrange(minDelay, maxDelay));
  }
}

burning_trash_fire() {
  full = self getLightIntensity();

  old_intensity = full;

  for(;;) {
    intensity = randomfloatrange(full * 0.7, full * 1.2);
    timer = randomfloatrange(0.3, 0.6);
    timer *= 20;

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * (i / timer) + old_intensity * ((timer - i) / timer);

      self setLightIntensity(new_intensity);
      wait(0.05);
    }

    old_intensity = intensity;
  }
}
strobeLight(intensity0, intensity1, period) {
  frequency = 360 / period;
  time = 0;

  for(;;) {
    interpolation = sin(time * frequency) * 0.5 + 0.5;
    self setLightIntensity(intensity0 + (intensity1 - intensity0) * interpolation);
    wait 0.05;
    time += 0.05;
    if(time > period) {
      time -= period;
    }
  }
}
changeLightColorTo(targetColor, totalTime, accelTime, decelTime) {
  if(!isDefined(accelTime)) {
    accelTime = 0;
  }
  if(!isDefined(decelTime)) {
    decelTime = 0;
  }
  self thread changeLightColorToWorkerThread(targetColor, totalTime, accelTime, decelTime);
}
changeLightColorToWorkerThread(targetColor, totalTime, accelTime, decelTime) {
  startColor = self getLightColor();
  timeFactor = 1 / (totalTime * 2 - (accelTime + decelTime));
  time = 0;

  if(time < accelTime) {
    halfRate = timeFactor / accelTime;

    while(time < accelTime) {
      fraction = halfRate * time * time;
      self setLightColor(vectorlerp(startColor, targetColor, fraction));
      wait 0.05;
      time += 0.05;
    }
  }

  while(time < totalTime - decelTime) {
    fraction = timeFactor * (2 * time - accelTime);
    self setLightColor(vectorlerp(startColor, targetColor, fraction));
    wait 0.05;
    time += 0.05;
  }

  time = totalTime - time;
  if(time > 0) {
    halfRate = timeFactor / decelTime;

    while(time > 0) {
      fraction = 1 - halfRate * time * time;
      self setLightColor(vectorlerp(startColor, targetColor, fraction));
      wait 0.05;
      time -= 0.05;
    }
  }

  self setLightColor(targetColor);
}

television() {
  thread tv_changes_intensity();
  thread tv_changes_color();
}

tv_changes_intensity() {
  self endon("light_off");
  full = self getLightIntensity();
  old_intensity = full;

  for(;;) {
    intensity = randomfloatrange(full * 0.7, full * 1.2);
    timer = randomfloatrange(0.3, 1.2);
    timer *= 20;

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * (i / timer) + old_intensity * ((timer - i) / timer);

      self setLightIntensity(new_intensity);
      wait(0.05);
    }

    old_intensity = intensity;
  }
}

tv_changes_color() {
  self endon("light_off");

  range = 0.5;
  base = 0.5;
  rgb = [];
  old_rgb = [];

  for(i = 0; i < 3; i++) {
    rgb[i] = 0;
    old_rgb[i] = 0;
  }

  for(;;) {
    for(i = 0; i < rgb.size; i++) {
      old_rgb[i] = rgb[i];
      rgb[i] = randomfloat(range) + base;
    }

    timer = randomfloatrange(0.3, 1.2);
    timer *= 20;

    for(i = 0; i < timer; i++) {
      new_rgb = [];
      for(p = 0; p < rgb.size; p++) {
        new_rgb[p] = rgb[p] * (i / timer) + old_rgb[p] * ((timer - i) / timer);
      }

      self setLightColor((new_rgb[0], new_rgb[1], new_rgb[2]));
      wait(0.05);
    }
  }
}
turn_off() {
  self.default_intensity = self GetLightIntensity();
  self SetLightIntensity(0);
}
turn_on(intensity) {
  if(!isDefined(intensity) && isDefined(self.default_intensity)) {
    intensity = self.default_intensity;
  }

  if(!isDefined(intensity)) {
    return;
  }

  self SetLightIntensity(intensity);
}
fire_flicker() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  min_delay = 0.1;
  max_delay = 0.5;
  if(isDefined(self.script_delay_min)) {
    min_delay = self.script_delay_min;
  }

  if(isDefined(self.script_delay_max)) {
    max_delay = self.script_delay_max;
  }

  min_intensity = 0.25;
  max_intensity = 1;
  if(isDefined(self.script_intensity_min)) {
    min_intensity = self.script_intensity_min;
  }

  if(isDefined(self.script_intensity_max)) {
    max_intensity = self.script_intensity_max;
  }

  intensity = self GetLightIntensity();
  curr_intensity = intensity;

  for(;;) {
    temp_intensity = intensity * RandomFloatRange(min_intensity, max_intensity);
    time = RandomFloatRange(min_delay, max_delay);
    steps = time * 20;
    div = (curr_intensity - temp_intensity) / steps;

    for(i = 0; i < steps; i++) {
      curr_intensity -= div;

      if(curr_intensity < 0) {
        curr_intensity = 0;
      }

      self SetLightIntensity(curr_intensity);
      wait(0.05);
    }

    curr_intensity = temp_intensity;
  }
}