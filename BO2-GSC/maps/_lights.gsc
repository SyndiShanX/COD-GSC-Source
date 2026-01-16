/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_lights.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

generic_pulsing() {
  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  on = self getlightintensity();
  curr = on;
  increment_on = (on - 0.05) / (0.3 / 0.05);
  increment_off = (on - 0.05) / (0.6 / 0.05);

  for(;;) {
    time = 0;

    while(time < 0.6) {
      curr = curr - increment_off;
      self setlightintensity(curr);
      time = time + 0.05;
      wait 0.05;
    }

    wait 1;
    time = 0;

    while(time < 0.3) {
      curr = curr + increment_on;
      self setlightintensity(curr);
      time = time + 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

generic_double_strobe() {
  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  on = self getlightintensity();
  linked_models = 0;
  lit_model = undefined;
  unlit_model = undefined;
  linked_lights = 0;
  linked_light_ents = [];

  if(isDefined(self.script_noteworthy)) {
    linked_things = getentarray(self.script_noteworthy, "targetname");

    for(i = 0; i < linked_things.size; i++) {
      if(linked_things[i].classname == "light") {
        linked_lights = 1;
        linked_light_ents[linked_light_ents.size] = linked_things[i];
      }

      if(linked_things[i].classname == "script_model") {
        lit_model = linked_things[i];
        unlit_model = getent(lit_model.target, "targetname");
        linked_models = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(0.05);

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
    self setlightintensity(0.05);

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

getclosests_flickering_model(origin) {
  array = getentarray("light_flicker_model", "targetname");
  return_array = [];
  model = getclosest(origin, array);

  if(isDefined(model))
    return_array[0] = model;

  return return_array;
}

generic_flickering() {
  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  min_flickerless_time = 0.2;
  max_flickerless_time = 1.5;

  if(isDefined(self.script_wait_min))
    min_flickerless_time = self.script_wait_min;

  if(isDefined(self.script_wait_max))
    max_flickerless_time = self.script_wait_max;

  min_flicker_delay = 0.05;
  max_flicker_delay = 0.1;

  if(isDefined(self.script_delay_min))
    min_flicker_delay = self.script_delay_min;

  if(isDefined(self.script_delay_max))
    max_flicker_delay = self.script_delay_max;

  min_intensity = 0;
  max_intensity = 0.3;

  if(isDefined(self.script_intensity_min))
    min_intensity = self.script_intensity_min;

  if(isDefined(self.script_intensity_max))
    max_intensity = self.script_intensity_max;

  min_burst = 1;
  max_burst = 10;

  if(isDefined(self.script_burst_min))
    min_burst = self.script_burst_min;

  if(isDefined(self.script_burst_max))
    max_burst = self.script_burst_max;

  on = self getlightintensity();
  curr = on;
  num = 0;
  linked_models = 0;
  lit_model = undefined;
  unlit_model = undefined;
  linked_lights = 0;
  linked_light_ents = [];
  linked_things = [];

  if(isDefined(self.script_noteworthy))
    linked_things = getentarray(self.script_noteworthy, "targetname");

  if(!linked_things.size)
    linked_things = getclosests_flickering_model(self.origin);

  for(i = 0; i < linked_things.size; i++) {
    if(linked_things[i].classname == "light") {
      linked_lights = 1;
      linked_light_ents[linked_light_ents.size] = linked_things[i];
    }

    if(linked_things[i].classname == "script_model") {
      lit_model = linked_things[i];
      unlit_model = getent(lit_model.target, "targetname");
      linked_models = 1;
    }
  }

  for(;;) {
    for(num = randomintrange(min_burst, max_burst); num; num--) {
      wait(randomfloatrange(min_flicker_delay, max_flicker_delay));

      if(curr > on * 0.5) {
        curr = randomfloatrange(min_intensity, max_intensity);

        if(linked_models) {
          lit_model hide();
          unlit_model show();
        }
      } else {
        curr = on;

        if(linked_models) {
          lit_model show();
          unlit_model hide();
        }
      }

      self setlightintensity(curr);

      if(linked_lights) {
        for(i = 0; i < linked_light_ents.size; i++)
          linked_light_ents[i] setlightintensity(curr);
      }
    }

    self setlightintensity(on);

    if(linked_lights) {
      for(i = 0; i < linked_light_ents.size; i++)
        linked_light_ents[i] setlightintensity(on);
    }

    if(linked_models) {
      lit_model show();
      unlit_model hide();
    }

    wait(randomfloatrange(min_flickerless_time, max_flickerless_time));
  }
}

fire_flicker() {
  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    return;
  }
  min_delay = 0.1;
  max_delay = 0.5;

  if(isDefined(self.script_delay_min))
    min_delay = self.script_delay_min;

  if(isDefined(self.script_delay_max))
    max_delay = self.script_delay_max;

  min_intensity = 0.25;
  max_intensity = 1;

  if(isDefined(self.script_intensity_min))
    min_intensity = self.script_intensity_min;

  if(isDefined(self.script_intensity_max))
    max_intensity = self.script_intensity_max;

  intensity = self getlightintensity();
  curr_intensity = intensity;

  for(;;) {
    temp_intensity = intensity * randomfloatrange(min_intensity, max_intensity);
    time = randomfloatrange(min_delay, max_delay);
    steps = time * 20;
    div = (curr_intensity - temp_intensity) / steps;

    for(i = 0; i < steps; i++) {
      curr_intensity = curr_intensity - div;

      if(curr_intensity < 0)
        curr_intensity = 0;

      self setlightintensity(curr_intensity);
      wait 0.05;
    }

    curr_intensity = temp_intensity;
  }
}