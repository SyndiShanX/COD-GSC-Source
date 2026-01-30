/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_mp_lights.gsc
***************************************************/

init() {
  if(!isDefined(level.sunenable)) {
    level.sunenable = GetDvarInt("sm_sunenable", 1);
  }
  if(!isDefined(level.sunshadowscale)) {
    level.sunshadowscale = GetDvarFloat("sm_sunshadowscale", 1.0);
  }
  if(!isDefined(level.spotlimit)) {
    level.spotlimit = GetDvarInt("sm_spotlimit", 4);
  }
  if(!isDefined(level.sunsamplesizenear)) {
    level.sunsamplesizenear = GetDvarFloat("sm_sunsamplesizenear", .25);
  }
  if(!isDefined(level.qualityspotshadow)) {
    level.qualityspotshadow = GetDvarFloat("sm_qualityspotshadow", 1.0);
  }
  thread monitorPlayerSpawns();

  if(!isDefined(level._light)) {
    level._light = spawnStruct();
    light_setup_common_flickerLight_presets();
    light_message_init();
  }

  triggers = getEntArray("trigger_multiple_light_sunshadow", "classname");

  for(i = 0; i < triggers.size; i++) {
    level thread sun_shadow_trigger(triggers[i]);
  }

}

set_smdvars(sunenable, sunshadowscale, spotlimit, sunsamplesizenear, qualityspotshadow) {
  if(isDefined(sunenable)) {
    level.sunenable = sunenable;
  }
  if(isDefined(sunshadowscale)) {
    level.sunshadowscale = sunshadowscale;
  }
  if(isDefined(spotlimit)) {
    level.spotlimit = spotlimit;
  }
  if(isDefined(sunsamplesizenear)) {
    level.sunsamplesizenear = sunsamplesizenear;
  }
  if(isDefined(qualityspotshadow)) {
    level.qualityspotshadow = qualityspotshadow;
  }
}

monitorPlayerSpawns() {
  if(isDefined(level.players)) {
    foreach(player in level.players) {
      player initPlayer();
    }
  }
  while(true) {
    level waittill("connected", player);
    player initPlayer();
    player thread monitorDeath();
  }
}

initPlayer() {
  self.sunenable = level.sunenable;
  self.sunshadowscale = level.sunshadowscale;
  self.spotlimit = level.spotlimit;
  self.sunsamplesizenear = level.sunsamplesizenear;
  self.qualityspotshadow = level.qualityspotshadow;
  self SetClientDvars(
    "sm_sunenable", self.sunenable, "sm_sunshadowscale", self.sunshadowscale, "sm_spotlimit", self.spotlimit, "sm_qualityspotshadow", self.qualityspotshadow, "sm_sunSampleSizeNear", self.sunsamplesizenear);
}

monitorDeath() {
  self waittill("spawned");
  self initPlayer();
}

sun_shadow_trigger(trigger) {
  duration = 1;
  if(isDefined(trigger.script_duration)) {
    duration = trigger.script_duration;
  }

  while(true) {
    trigger waittill("trigger", player);

    trigger set_sun_shadow_params(duration, player);
  }
}

set_sun_shadow_params(duration, player) {
  sunenable = player.sunenable;
  sunshadowscale = player.sunshadowscale;
  spotlimit = player.spotlimit;
  sunsamplesizenear = player.sunsamplesizenear;
  qualityspotshadow = player.qualityspotshadow;
  if(isDefined(self.script_sunenable)) sunenable = self.script_sunenable;
  if(isDefined(self.script_sunshadowscale)) sunshadowscale = self.script_sunshadowscale;
  if(isDefined(self.script_spotlimit)) spotlimit = self.script_spotlimit;
  if(isDefined(self.script_sunsamplesizenear)) sunsamplesizenear = self.script_sunsamplesizenear;
  sunsamplesizenear = min(max(0.016, sunsamplesizenear), 32);
  if(isDefined(self.script_qualityspotshadow)) qualityspotshadow = self.script_qualityspotshadow;

  player SetClientDvars(
    "sm_sunenable", sunenable, "sm_sunshadowscale", sunshadowscale, "sm_spotlimit", spotlimit, "sm_qualityspotshadow", qualityspotshadow);
  player.sunenable = sunenable;
  player.sunshadowscale = sunshadowscale;
  player.spotlimit = spotlimit;
  old_sunsamplesizenear = player.sunsamplesizenear;
  player.sunsamplesizenear = sunsamplesizenear;
  player.qualityspotshadow = qualityspotshadow;

  self thread lerp_sunsamplesizenear_overtime(sunsamplesizenear, old_sunsamplesizenear, duration, player);
}

lerp_sunsamplesizenear_overtime(value, old_value, time, player) {
  level notify("changing_sunsamplesizenear" + player.name);
  level endon("changing_sunsamplesizenear" + player.name);

  if(value == old_value) {
    return;
  }

  diff = value - old_value;
  dt = 0.1;

  times = time / dt;

  if(times > 0) {
    d = diff / times;

    v = old_value;
    for(i = 0; i < times; i++) {
      v = v + d;
      player SetClientDvar("sm_sunSampleSizeNear", v);
      player.sunsamplesizenear = v;
      wait(dt);
    }
  }
  player SetClientDvar("sm_sunSampleSizeNear", value);
  player.sunsamplesizenear = value;
}

light_setup_common_flickerLight_presets() {
  create_flickerLight_preset("fire", (0.972549, 0.624510, 0.345098), (.2, 0.1462746, 0.0878432), .005, .2, 8);
  create_flickerLight_preset("blue_fire", (0.445098, 0.624510, 0.972549), (.05, 0.1504510, 0.3078432), .005, .2, 8);
  create_flickerLight_preset("white_fire", (0.972549, 0.972549, 0.972549), (.2, 0.2, 0.2), .005, .2, 8);
  create_flickerLight_preset("pulse", (0, 0, 0), (255, 107, 107), .2, 1, 8);
  create_flickerLight_preset("lightbulb", (0.972549, 0.624510, 0.345098), (.2, 0.1462746, 0.0878432), .005, .2, 6);
  create_flickerLight_preset("fluorescent", (0.972549, 0.624510, 0.345098), (.2, 0.1462746, 0.0878432), .005, .2, 7);
  create_flickerLight_preset("static_screen", (0.63, 0.72, 0.92), (.40, 0.43, 0.48), .005, .2, 7);
}

create_flickerLight_preset(name, color0, color1, minDelay, maxDelay, intensity) {
  if(!isDefined(level._light.flicker_presets)) {
    level._light.flicker_presets = [];
  }

  new_preset = spawnStruct();
  new_preset.color0 = color0;
  new_preset.color1 = color1;
  new_preset.minDelay = minDelay;
  new_preset.maxDelay = maxDelay;
  new_preset.intensity = intensity;

  level._light.flicker_presets[name] = new_preset;
}

get_flickerLight_preset(name) {
  if(isDefined(level._light.flicker_presets) && isDefined(level._light.flicker_presets[name])) {
    return level._light.flicker_presets[name];
  }
  return undefined;
}

play_flickerLight_preset(name, targetName, intensity_) {
  assert(IsString(name));
  assert(IsString(targetName));

  ent = GetEnt(targetName, "targetname");
  if(!isDefined(ent)) {
    println("Error Light Scripts: play_flickerLight_preset with name, \"" + name + "\", was called on a non-existant targetName, \"" + targetName + "\".");
    return;
  }

  preset = get_flickerLight_preset(name);
  if(!isDefined(preset)) {
    PrintLn("Error Light Scripts: flickerLight preset " + name + " is not defined. Please define before calling it with play_flickerLight_preset.");
    return;
  }

  if(isDefined(intensity_)) {
    if(intensity_ < 0) {
      PrintLn("Warning: flickerLight preset " + name + " is playing with an intensity override less than zero. Truncating.");
      intensity_ = 0;
    }

    preset.intensity = intensity_;
  }

  ent SetLightIntensity(preset.intensity);

  ent.isLightFlickering = true;
  ent.isLightFlickerPaused = false;

  ent thread dyn_flickerLight(preset.color0, preset.color1, preset.minDelay, preset.MaxDelay);

  return ent;
}

stop_flickerLight(name, targetName, intensity_) {
  ent = GetEnt(targetName, "targetname");

  if(!isDefined(ent)) {
    println("Error Light Scripts: stop_flickerLight, \"" + name + "\", was called on a non-existant targetName, \"" + targetName + "\".");
    return;
  }

  if(!isDefined(ent.isLightFlickering)) {
    println("Error Light Scripts: stop_flickerLight was called on a flickering light but flickering light isn't flickering.");
    return;
  }
  if(isDefined(intensity_)) {
    if(intensity_ < 0) {
      PrintLn("Warning: flickerLight preset " + name + " is playing with an intensity override less than zero. Truncating.");
      intensity_ = 0;
    }
  }

  ent SetLightIntensity(intensity_);

  ent notify("kill_flicker");
  ent.isLightFlickering = undefined;
}

pause_flickerLight(name, targetName) {
  ent = GetEnt(targetName, "targetname");

  if(!isDefined(ent)) {
    println("Error Light Scripts: pause_flickerLight, \"" + name + "\", was called on a non-existant targetName, \"" + targetName + "\".");
    return;
  }

  if(!isDefined(ent.isLightFlickering)) {
    println("Error Light Scripts: pause_flickerLight was called on a flickering light but flickering light isn't flickering.");
    return;
  }

  ent.isLightFlickerPaused = true;
}

unpause_flickerLight(name, targetName) {
  ent = GetEnt(targetName, "targetname");

  if(!isDefined(ent)) {
    println("Error Light Scripts: unpause_flickerLight, \"" + name + "\", was called on a non-existant targetName, \"" + targetName + "\".");
    return;
  }

  if(!isDefined(ent.isLightFlickering)) {
    println("Error Light Scripts: pause_flickerLight was called on a flickering light but flickering light isn't flickering.");
    return;
  }

  ent.isLightFlickerPaused = false;
}

dyn_flickerLight(color0, color1, minDelay, maxDelay) {
  assert(isDefined(self.isLightFlickering));
  assert(isDefined(self.isLightFlickerPaused));

  self endon("kill_flicker");
  toColor = color0;
  delay = 0.0;

  for(;;) {
    if(self.isLightFlickerPaused) {
      wait 0.05;
    } else {
      fromColor = toColor;
      toColor = color0 + (color1 - color0) * randomfloat(1.0);

      if(minDelay != maxDelay) {
        delay += randomfloatrange(minDelay, maxDelay);
      } else {
        delay += minDelay;
      }

      if(delay == 0) delay += .0000001;
      colorDeltaPerTime = (fromColor - toColor) * (1 / delay);
      while((delay > 0) && !self.isLightFlickerPaused) {
        self setLightColor(toColor + colorDeltaPerTime * delay);
        wait 0.05;
        delay -= 0.05;
      }
    }
  }
}

model_flicker_preset(script_noteworthy, number_of_flickers, fxid1, fxid2) {
  assert(IsString(script_noteworthy));

  ent = getEntArray(script_noteworthy, "script_noteworthy");
  if(!isDefined(ent)) {
    println("please define a targetname");
    return;
  }

  self endon("death");
  flicker_count = 0;
  time_between_flicker = RandomFloatRange(.1, .25);

  if(isDefined(fxid1)) {
    exploder(fxid1);
  }

  while(flicker_count < number_of_flickers) {
    if(isDefined(fxid2)) {
      exploder(fxid2);
    }
    foreach(light in ent) {
      light Show();
    }
    wait time_between_flicker;
    if(isDefined(fxid2)) {
      stop_exploder(fxid2);
    }
    foreach(light in ent) {
      light Hide();
    }
    flicker_count++;
    wait time_between_flicker;
  }
}

light_message_init() {
  assert(isDefined(level._light));
  level._light.messages = [];
}

light_debug_dvar_init() {
  SetDvarIfUninitialized("light_debug_messages", 0);
}

light_register_message(message, callback) {
  assertEx(isDefined(level._light), "Need to call light_message_init() before calling this function.");
  level._light.messages[message] = callback;
}

light_message(message, arg1, arg2, arg3) {
  AssertEx(isDefined(level._light), "Need to call light_message_init() before calling this function.");

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

stop_exploder(num) {
  num += "";

  if(isDefined(level.createFXexploders)) {
    exploders = level.createFXexploders[num];
    if(isDefined(exploders)) {
      foreach(ent in exploders) {
        if(!isDefined(ent.looper)) {
          continue;
        }

        ent.looper Delete();
      }
    }
  } else {
    for(i = 0; i < level.createFXent.size; i++) {
      ent = level.createFXent[i];
      if(!isDefined(ent)) {
        continue;
      }

      if(ent.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(ent.v["exploder"])) {
        continue;
      }

      if(ent.v["exploder"] + "" != num) {
        continue;
      }

      if(!isDefined(ent.looper)) {
        continue;
      }

      ent.looper Delete();
    }
  }
}

exploder(num) {
  [[level.exploderFunction]](num);
}