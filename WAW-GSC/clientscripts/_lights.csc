/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_lights.csc
**************************************/

#include clientscripts\_utility;

add_light(clientNum) {
  light = spawn(clientNum, self.origin);
  light makelight(self.pl);

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    light setLightIntensity(0);
  }

  return (light);
}

create_lights(clientNum) {
  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  self.lights[clientNum] = self add_light(clientNum);
}

generic_flickering(clientNum) {}

generic_pulsing(clientNum) {
  assertex(isDefined(self.lights) && isDefined(self.lights[clientNum]), "Light not setup before script thread run on it.");

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    self.lights[clientNum] setLightIntensity(0);
    return;
  }

  on = self.lights[clientNum] getLightIntensity();
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
      self.lights[clientNum] setLightIntensity(curr);
      time += .05;
      wait(.05);
    }

    wait(1);

    time = 0;
    while(time < transition_on) {
      curr += increment_on;
      self.lights[clientNum] setLightIntensity(curr);
      time += .05;
      wait(.05);
    }

    wait(.5);
  }
}

generic_double_strobe(clientNum) {
  assertex(isDefined(self.lights) && isDefined(self.lights[clientNum]), "Light not setup before script thread run on it.");
}
ber3b_firelight(clientNum) {
  assertex(isDefined(self.lights) && isDefined(self.lights[clientNum]), "Light not setup before script thread run on it.");

  full = self.lights[clientNum] GetLightIntensity();

  old_intensity = full;

  while(1) {
    intensity = RandomFloatRange(full * 0.63, full * 1.2);

    timer = RandomFloatRange(2, 5);

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * (i / timer) + old_intensity * ((timer - i) / timer);

      self.lights[clientNum] SetLightIntensity(new_intensity);
      wait(0.05);
    }

    old_intensity = intensity;
  }
}

fire_flicker(clientNum) {
  assertex(isDefined(self.lights) && isDefined(self.lights[clientNum]), "Light not setup before script thread run on it.");

  self endon("stop_flicker");

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

  intensity = self.lights[clientNum] GetLightIntensity();
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

      self.lights[clientNum] SetLightIntensity(curr_intensity);
      wait(0.05);
    }

    curr_intensity = temp_intensity;
  }
}

init_lights(clientNum) {
  lights = GetStructArray("light", "classname");

  if(isDefined(lights)) {
    array_thread(lights, ::create_lights, clientNum);
    println("*** Client : Lights " + lights.size);
  } else {
    println("*** Client : No Lights");
  }

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  flickering_lights = GetStructArray("generic_flickering", "targetname");
  pulsing_lights = GetStructArray("generic_pulsing", "targetname");
  double_strobe = GetStructArray("generic_double_strobe", "targetname");
  fire_flickers = GetStructArray("fire_flicker", "targetname");
  fire_casters = GetStructArray("firecaster", "targetname");

  asylum_lights = GetStructArray("elect_light", "targetname");
  asylum_controlroom_light = getstructarray("elect_flicker", "script_noteworthy");

  if(isDefined(flickering_lights)) {
    println("*** Client : " + flickering_lights.size + " flickering lights.");
    array_thread(flickering_lights, ::generic_flickering, clientNum);
  }

  if(isDefined(pulsing_lights)) {
    println("*** Client : " + pulsing_lights.size + " pulsing_lights.");
    array_thread(pulsing_lights, ::generic_pulsing, clientNum);
  }

  if(isDefined(double_strobe)) {
    println("*** Client : " + double_strobe.size + " double_strobe.");
    array_thread(double_strobe, ::generic_double_strobe, clientNum);
  }

  if(isDefined(fire_flickers)) {
    println("*** Client : " + fire_flickers.size + " fire_flickers.");
    array_thread(fire_flickers, ::fire_flicker, clientNum);
  }

  if(isDefined(fire_casters)) {
    println("*** Client : " + fire_casters.size + " fire_casters.");
    array_thread(fire_casters, ::ber3b_firelight, clientNum);
  }

  if(isDefined(asylum_lights)) {
    println("*** Client : " + asylum_lights.size + " asylum lights.");
    array_thread(asylum_lights, ::asylum_light_think, clientNum);
  }

  if(isDefined(asylum_controlroom_light)) {
    println("*** Client : " + asylum_controlroom_light.size + " control lights.");
    array_thread(asylum_controlroom_light, ::asylum_controlroom_light_think, clientNum);
  }

  power_lights = GetStructArray("light_electric", "targetname");
  if(isDefined(power_lights)) {
    println("*** Client : " + power_lights.size + " power lights.");
    array_thread(power_lights, ::power_lights_think, clientNum);
  }
}
asylum_light_think(clientnum) {
  self.lights[clientNum] setLightIntensity(0);
  level waittill("start_lights");
  self.lights[clientnum] setLightIntensity(2);
}

asylum_controlroom_light_think(clientnum) {
  level waittill("start_lights");

  println("control room client num: " + clientnum);

  self notify("stop_flicker");
  self.lights[clientnum] setLightIntensity(0);
}
power_lights_think(clientNum) {
  while(1) {
    level waittill("pl1");

    println("power lights on client num: " + clientnum);
    if(isDefined(self.script_float)) {
      self.lights[clientNum] SetLightIntensity(self.script_float);
    } else {
      self.lights[clientNum] SetLightIntensity(1.5);
    }
    level waittill("lights_off");

    println("power lights off client num: " + clientnum);
    self.lights[clientNum] SetLightIntensity(0.001);
  }
}
power_lights_flicker_think(clientNum) {
  assertex(isDefined(self.lights) && isDefined(self.lights[clientNum]), "Light not setup before script thread run on it.");

  self endon("stop_flicker");

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

  if(isDefined(self.target)) {
    self.light_model = GetEnt(clientNum, self.target, "targetname");
  }

  min_intensity = 0.25;
  max_intensity = 1;
  if(isDefined(self.script_intensity_min)) {
    min_intensity = self.script_intensity_min;
  }

  if(isDefined(self.script_intensity_max)) {
    max_intensity = self.script_intensity_max;
  }

  intensity = self.lights[clientNum] GetLightIntensity();
  curr_intensity = intensity;
  model_swap_1 = intensity + min_intensity + ((max_intensity - min_intensity) / 3);
  model_swap_2 = intensity + max_intensity - ((max_intensity - min_intensity) / 3);

  println("power lights on client num: " + clientnum);
  if(isDefined(self.script_float)) {
    self.lights[clientNum] SetLightIntensity(self.script_float);
  } else {
    self.lights[clientNum] SetLightIntensity(0.001);
  }

  level waittill("pl1");

  model = "";
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

      self.lights[clientNum] SetLightIntensity(curr_intensity);

      println("*** Client : light flicker " + curr_intensity);
      if(isDefined(self.light_model)) {
        if(curr_intensity < model_swap_1) {
          model = "lights_berlin_subway_hat_0";
          println("*** Client : light flickerhat 0");
        } else if(curr_intensity > model_swap_2) {
          model = "lights_berlin_subway_hat_100";
          println("*** Client : light flickerhat50");
        } else {
          model = "lights_berlin_subway_hat_50";
          println("*** Client : light flickerhat 100");
        }

        if(model != self.light_model.model) {
          self.light_model setModel(model);
        }
      }
      wait(0.05);
    }

    curr_intensity = temp_intensity;
  }
}