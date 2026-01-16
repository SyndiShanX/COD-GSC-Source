/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_lights.gsc
********************************/

init2() {
  var_0 = getentarray("generic_flickering", "targetname");
  var_1 = getentarray("generic_pulsing", "targetname");
  var_2 = getentarray("generic_double_strobe", "targetname");
  var_3 = getentarray("burning_trash_fire", "targetname");
  var_4 = getentarray("scripted_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::generic_flickering);
  common_scripts\utility::array_thread(var_1, ::generic_pulsing);
  common_scripts\utility::array_thread(var_2, ::generic_double_strobe);
  common_scripts\utility::array_thread(var_3, ::burning_trash_fire);
  common_scripts\utility::array_thread(var_4, ::init_scripted_light);
}

is_light_entity(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

flickerlight(var_0, var_1, var_2, var_3) {
  self endon("kill_flicker");
  var_4 = var_0;
  var_5 = 0.0;
  maps\_utility::ent_flag_init("stop_flicker");

  for (;;) {
    if(maps\_utility::ent_flag("stop_flicker")) {
      wait 0.05;
      continue;
    }

    var_6 = var_4;
    var_4 = var_0 + (var_1 - var_0) * randomfloat(1.0);

    if(var_2 != var_3)
      var_5 = var_5 + randomfloatrange(var_2, var_3);
    else
      var_5 = var_5 + var_2;

    if(var_5 == 0)
      var_5 = var_5 + 0.0000001;

    for (var_7 = (var_6 - var_4) * (1 / var_5); var_5 > 0 && !maps\_utility::ent_flag("stop_flicker"); var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_7 * var_5);
      wait 0.05;
    }
  }
}

kill_flicker_when_damaged(var_0) {
  var_1 = getentarray(var_0, "script_noteworthy");
  var_2 = undefined;
  var_3 = 100000000.0;

  foreach(var_5 in var_1) {
    var_6 = distance(self.origin, var_5.origin);

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  if(isdefined(var_2)) {
    var_2 waittill("damage", var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    self notify("kill_flicker");
    wait 0.05;
    self setlightcolor((0, 0, 0));
  }
}

generic_pulsing() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
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

  for (;;) {
    var_7 = 0;

    while (var_7 < var_4) {
      var_2 = var_2 - var_6;
      var_2 = clamp(var_2, 0, 100);
      self setlightintensity(var_2);
      var_7 = var_7 + 0.05;
      wait 0.05;
    }

    wait 1;
    var_7 = 0;

    while (var_7 < var_3) {
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
  if(getdvar("r_reflectionProbeGenerate") == "1") {
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

  if(isdefined(self.script_noteworthy)) {
    var_7 = getentarray(self.script_noteworthy, "targetname");

    for (var_8 = 0; var_8 < var_7.size; var_8++) {
      if(is_light_entity(var_7[var_8])) {
        var_5 = 1;
        var_6[var_6.size] = var_7[var_8];
      }

      if(var_7[var_8].classname == "script_model") {
        var_3 = var_7[var_8];
        var_4 = getent(var_3.target, "targetname");
        var_2 = 1;
      }
    }
  }

  for (;;) {
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

getclosests_flickering_model(var_0) {
  var_1 = getentarray("light_flicker_model", "targetname");
  var_2 = [];
  var_3 = common_scripts\utility::getclosest(var_0, var_1);

  if(isdefined(var_3))
    var_2[0] = var_3;

  return var_2;
}

generic_flickering() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  self endon("stop_dynamic_light_behavior");
  self endon("death");
  self.linked_models = 0;
  self.lit_models = undefined;
  self.unlit_models = undefined;
  self.linked_lights = 0;
  self.linked_light_ents = [];
  self.linked_prefab_ents = undefined;
  self.linked_things = [];

  if(isdefined(self.script_linkto)) {
    self.linked_prefab_ents = common_scripts\utility::get_linked_ents();

    foreach(var_1 in self.linked_prefab_ents) {
      if(isdefined(var_1.script_noteworthy) && var_1.script_noteworthy == "on") {
        if(!isdefined(self.lit_models))
          self.lit_models[0] = var_1;
        else
          self.lit_models[self.lit_models.size] = var_1;

        continue;
      }

      if(isdefined(var_1.script_noteworthy) && var_1.script_noteworthy == "off") {
        if(!isdefined(self.unlit_models))
          self.unlit_models[0] = var_1;
        else
          self.unlit_models[self.unlit_models.size] = var_1;

        self.unlit_model = var_1;
        continue;
      }

      if(is_light_entity(var_1)) {
        self.linked_lights = 1;
        self.linked_light_ents[self.linked_light_ents.size] = var_1;
      }
    }

    self.linked_models = 1;
  }

  if(isdefined(self.script_noteworthy))
    self.linked_things = getentarray(self.script_noteworthy, "targetname");

  if(!self.linked_things.size && !isdefined(self.linked_prefab_ents))
    self.linked_things = getclosests_flickering_model(self.origin);

  for (var_3 = 0; var_3 < self.linked_things.size; var_3++) {
    if(is_light_entity(self.linked_things[var_3])) {
      self.linked_lights = 1;
      self.linked_light_ents[self.linked_light_ents.size] = self.linked_things[var_3];
    }

    if(self.linked_things[var_3].classname == "script_model") {
      var_4 = self.linked_things[var_3];

      if(!isdefined(self.lit_models))
        self.lit_models[0] = var_4;
      else
        self.lit_models[self.lit_models.size] = var_4;

      if(!isdefined(self.unlit_models))
        self.unlit_models[0] = getent(var_4.target, "targetname");
      else
        self.unlit_models[self.unlit_models.size] = getent(var_4.target, "targetname");

      self.linked_models = 1;
    }
  }

  if(isdefined(self.lit_models)) {
    foreach(var_4 in self.lit_models) {
      if(isdefined(var_4) && isdefined(var_4.script_fxid)) {
        var_4.effect = common_scripts\utility::createoneshoteffect(var_4.script_fxid);
        var_6 = (0, 0, 0);
        var_7 = (0, 0, 0);

        if(isdefined(var_4.script_parameters)) {
          var_8 = strtok(var_4.script_parameters, ", ");

          if(var_8.size < 3) {

          } else if(var_8.size == 6) {
            var_9 = float(var_8[0]);
            var_10 = float(var_8[1]);
            var_11 = float(var_8[2]);
            var_6 = (var_9, var_10, var_11);
            var_9 = float(var_8[3]);
            var_10 = float(var_8[4]);
            var_11 = float(var_8[5]);
            var_7 = (var_9, var_10, var_11);
          } else {
            var_9 = float(var_8[0]);
            var_10 = float(var_8[1]);
            var_11 = float(var_8[2]);
            var_6 = (var_9, var_10, var_11);
          }
        }

        var_4.effect.v["origin"] = var_4.origin + var_6;
        var_4.effect.v["angles"] = var_4.angles + var_7;
      }
    }
  }

  thread generic_flicker_msg_watcher();
  thread generic_flicker();
}

generic_flicker_msg_watcher() {
  maps\_utility::ent_flag_init("flicker_on");

  if(isdefined(self.script_light_startnotify) && self.script_light_startnotify != "nil") {
    for (;;) {
      level waittill(self.script_light_startnotify);
      maps\_utility::ent_flag_set("flicker_on");

      if(isdefined(self.script_light_stopnotify) && self.script_light_stopnotify != "nil") {
        level waittill(self.script_light_stopnotify);
        maps\_utility::ent_flag_clear("flicker_on");
      }
    }
  } else
    maps\_utility::ent_flag_set("flicker_on");
}

generic_flicker_pause() {
  var_0 = self getlightintensity();

  if(!maps\_utility::ent_flag("flicker_on")) {
    if(self.linked_models) {
      if(isdefined(self.lit_models)) {
        foreach(var_2 in self.lit_models) {
          var_2 hide();

          if(isdefined(var_2.effect))
            var_2.effect common_scripts\utility::pauseeffect();
        }
      }

      if(isdefined(self.unlit_models)) {
        foreach(var_5 in self.unlit_models)
        var_5 show();
      }
    }

    self setlightintensity(0);

    if(self.linked_lights) {
      for (var_7 = 0; var_7 < self.linked_light_ents.size; var_7++)
        self.linked_light_ents[var_7] setlightintensity(0);
    }

    maps\_utility::ent_flag_wait("flicker_on");
    self setlightintensity(var_0);

    if(self.linked_lights) {
      for (var_7 = 0; var_7 < self.linked_light_ents.size; var_7++)
        self.linked_light_ents[var_7] setlightintensity(var_0);
    }

    if(self.linked_models) {
      if(isdefined(self.lit_models)) {
        foreach(var_2 in self.lit_models) {
          var_2 show();

          if(isdefined(var_2.effect))
            var_2.effect maps\_utility::restarteffect();
        }
      }

      if(isdefined(self.unlit_models)) {
        foreach(var_5 in self.unlit_models)
        var_5 hide();
      }
    }
  }
}

generic_flicker() {
  self endon("stop_dynamic_light_behavior");
  self endon("death");
  var_0 = 0.2;
  var_1 = 1.5;
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  while (isdefined(self)) {
    generic_flicker_pause();

    for (var_5 = randomintrange(1, 10); var_5; var_5--) {
      generic_flicker_pause();
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);

        if(self.linked_models) {
          foreach(var_7 in self.lit_models) {
            var_7 hide();

            if(isdefined(var_7.effect))
              var_7.effect common_scripts\utility::pauseeffect();
          }
        }

        if(isdefined(self.unlit_models)) {
          foreach(var_10 in self.unlit_models)
          var_10 show();
        }
      } else {
        var_4 = var_2;

        if(self.linked_models) {
          if(isdefined(self.lit_models)) {
            foreach(var_7 in self.lit_models) {
              var_7 show();

              if(isdefined(var_7.effect))
                var_7.effect maps\_utility::restarteffect();
            }
          }

          if(isdefined(self.unlit_models)) {
            foreach(var_10 in self.unlit_models) {
              var_10 hide();
              soundscripts\_audio::deprecated_aud_send_msg("light_flicker_on", var_10);
            }
          }
        }
      }

      self setlightintensity(var_4);

      if(self.linked_lights) {
        for (var_16 = 0; var_16 < self.linked_light_ents.size; var_16++)
          self.linked_light_ents[var_16] setlightintensity(var_4);
      }
    }

    generic_flicker_pause();
    self setlightintensity(var_2);

    if(self.linked_lights) {
      for (var_16 = 0; var_16 < self.linked_light_ents.size; var_16++)
        self.linked_light_ents[var_16] setlightintensity(var_2);
    }

    if(self.linked_models) {
      if(isdefined(self.lit_models)) {
        foreach(var_7 in self.lit_models) {
          var_7 show();

          if(isdefined(var_7.effect))
            var_7.effect maps\_utility::restarteffect();
        }
      }

      if(isdefined(self.unlit_models)) {
        foreach(var_10 in self.unlit_models)
        var_10 hide();
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

generic_spot() {
  for (;;)
    waitframe();
}

flickerlightintensity(var_0, var_1) {
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  for (;;) {
    for (var_5 = randomintrange(1, 10); var_5; var_5--) {
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

burning_trash_fire() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
  var_1 = var_0;

  for (;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 0.6);
    var_3 = var_3 * 20;

    for (var_4 = 0; var_4 < var_3; var_4++) {
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

  for (;;) {
    var_6 = sin(var_5 * var_4) * 0.5 + 0.5;
    self setlightintensity(var_0 + (var_1 - var_0) * var_6);
    wait 0.05;
    var_5 = var_5 + 0.05;

    if(var_5 > var_2)
      var_5 = var_5 - var_2;

    if(isdefined(var_3)) {
      if(common_scripts\utility::flag(var_3))
        return;
    }
  }
}

changelightcolorto(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  thread changelightcolortoworkerthread(var_0, var_1, var_2, var_3);
}

changelightcolortoworkerthread(var_0, var_1, var_2, var_3) {
  var_4 = self getlightcolor();
  var_5 = 1 / (var_1 * 2 - (var_2 + var_3));
  var_6 = 0;

  if(var_6 < var_2) {
    for (var_7 = var_5 / var_2; var_6 < var_2; var_6 = var_6 + 0.05) {
      var_8 = var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  while (var_6 < var_1 - var_3) {
    var_8 = var_5 * (2 * var_6 - var_2);
    self setlightcolor(vectorlerp(var_4, var_0, var_8));
    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  var_6 = var_1 - var_6;

  if(var_6 > 0) {
    for (var_7 = var_5 / var_3; var_6 > 0; var_6 = var_6 - 0.05) {
      var_8 = 1 - var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  self setlightcolor(var_0);
}

television() {
  thread tv_changes_intensity();
  thread tv_changes_color();
}

tv_changes_intensity() {
  self endon("light_off");
  var_0 = self getlightintensity();
  var_1 = var_0;

  for (;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 1.2);
    var_3 = var_3 * 20;

    for (var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

tv_changes_color() {
  self endon("light_off");
  var_0 = 0.5;
  var_1 = 0.5;
  var_2 = [];
  var_3 = [];

  for (var_4 = 0; var_4 < 3; var_4++) {
    var_2[var_4] = 0;
    var_3[var_4] = 0;
  }

  for (;;) {
    for (var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3[var_4] = var_2[var_4];
      var_2[var_4] = randomfloat(var_0) + var_1;
    }

    var_5 = randomfloatrange(0.3, 1.2);
    var_5 = var_5 * 20;

    for (var_4 = 0; var_4 < var_5; var_4++) {
      var_6 = [];

      for (var_7 = 0; var_7 < var_2.size; var_7++)
        var_6[var_7] = var_2[var_7] * (var_4 / var_5) + var_3[var_7] * ((var_5 - var_4) / var_5);

      self setlightcolor((var_6[0], var_6[1], var_6[2]));
      wait 0.05;
    }
  }
}

sun_shadow_trigger(var_0) {
  var_1 = 1;

  if(isdefined(var_0.script_duration))
    var_1 = var_0.script_duration;

  for (;;) {
    var_0 waittill("trigger", var_2);
    var_0 set_sun_shadow_params(var_1);

    while (var_2 istouching(var_0))
      wait 0.25;
  }
}

set_sun_shadow_params(var_0) {
  var_1 = getdvarint("sm_sunenable", 1);
  var_2 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_3 = getdvarint("sm_spotlimit", 4);
  var_4 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_5 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isdefined(self.script_sunenable))
    var_1 = self.script_sunenable;

  if(isdefined(self.script_sunshadowscale))
    var_2 = self.script_sunshadowscale;

  if(isdefined(self.script_spotlimit))
    var_3 = self.script_spotlimit;

  if(isdefined(self.script_sunsamplesizenear))
    var_4 = self.script_sunsamplesizenear;

  var_4 = min(max(0.016, var_4), 32);

  if(isdefined(self.script_qualityspotshadow))
    var_5 = self.script_qualityspotshadow;

  var_6 = getdvarint("sm_sunenable", 1);
  var_7 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_8 = getdvarint("sm_spotlimit", 4);
  var_9 = getdvarint("sm_qualityspotshadow", 1.0);
  setsaveddvar("sm_sunenable", var_1);
  setsaveddvar("sm_sunshadowscale", var_2);
  setsaveddvar("sm_spotlimit", var_3);
  setsaveddvar("sm_qualityspotshadow", var_5);
  lerp_sunsamplesizenear_overtime(var_4, var_0);
}

lerp_sunsamplesizenear_overtime(var_0, var_1) {
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

    for (var_7 = 0; var_7 < var_4; var_7++) {
      var_6 = var_6 + var_5;
      setsaveddvar("sm_sunSampleSizeNear", var_6);
      wait 0.05;
    }
  }

  setsaveddvar("sm_sunSampleSizeNear", var_0);
}

init_scripted_light() {
  init_linked_ents();
  init_light_def();
}

init_linked_ents() {
  self.lit_models = [];
  self.unlit_models = [];
  self.linked_lights = [];

  if(isdefined(self.target)) {
    var_0 = getentarray(self.target, "targetname");

    if(var_0.size == 0) {
      return;
    }
    foreach(var_2 in var_0) {
      if(is_light_entity(var_2)) {
        self.linked_lights[self.linked_lights.size] = var_2;
        var_2 init_linked_ents();
        continue;
      }

      var_3 = 1;

      if(isdefined(var_2.script_noteworthy)) {
        if(var_2.script_noteworthy == "on") {
          var_3 = 0;
          init_lit_model(var_2);
        } else if(var_2.script_noteworthy == "off") {
          var_3 = 0;
          self.unlit_models[self.unlit_models.size] = var_2;
        }
      }

      if(var_3) {
        init_lit_model(var_2);
        var_4 = getentarray(var_2.target, "targetname");

        foreach(var_6 in var_4)
        self.unlit_models[self.unlit_models.size] = var_6;
      }
    }

    foreach(var_2 in self.lit_models)
    var_2.visible = 1;

    foreach(var_2 in self.unlit_models) {
      var_2.visible = 0;
      var_2 hide();
    }
  }
}

init_lit_model(var_0) {
  self.lit_models[self.lit_models.size] = var_0;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(isdefined(var_0.script_fxid)) {
    var_1 = self.script_fxid;
    var_2 = var_0.origin;
    var_3 = var_0.angles;
  } else if(isdefined(var_0.target)) {
    var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");

    if(isdefined(var_4) && isdefined(var_4.script_fxid)) {
      var_1 = var_4.script_fxid;
      var_2 = var_4.origin;
      var_3 = (0, 0, 0);

      if(isdefined(var_4.angles))
        var_3 = var_4.angles;
    }
  }

  if(isdefined(var_1)) {
    var_0.effect = common_scripts\utility::createoneshoteffect(var_1);
    var_0.effect.v["origin"] = var_2;
    var_0.effect.v["angles"] = var_3;
  }
}

pulse_think() {
  self endon("stop_scripted_light");
  self endon("death");

  for (;;) {
    maps\_utility::script_wait();
    var_0 = self.script_intensity_min;
    var_1 = self.script_intensity_min + (self.script_intensity_max - self.script_intensity_min) * 0.4;
    var_2 = self.script_intensity_max - (self.script_intensity_max - self.script_intensity_min) * 0.4;
    var_3 = self.script_intensity_max;
    var_4 = randomintrange(self.script_count_min, self.script_count_max);

    for (var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = randomfloatrange(var_0, var_1);
      lerp_intensity(var_6, get_delay());
      maps\_utility::script_delay();
      var_6 = randomfloatrange(var_2, var_3);
      lerp_intensity(var_6, get_delay());
    }

    lerp_intensity(self.script_intensity_max, get_delay());
  }
}

lerp_intensity(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self getlightintensity();
  var_4 = (var_0 - var_3) / var_2;

  for (var_5 = 0; var_5 < var_2; var_5++) {
    thread handle_linked_ents(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isdefined(self.linked_lights))
    var_6 = common_scripts\utility::array_combine(var_6, self.linked_lights);

  foreach(var_8 in var_6) {
    var_8 thread handle_linked_ents(var_0);
    var_8 setlightintensity(var_0);
  }
}

handle_linked_ents(var_0) {
  var_1 = var_0 > self.script_threshold;

  foreach(var_3 in self.lit_models) {
    if(var_1 && !var_3.visible) {
      var_3.visible = var_1;
      var_3 show();

      if(isdefined(var_3.effect))
        var_3.effect thread maps\_utility::restarteffect();

      continue;
    }

    if(!var_1 && var_3.visible) {
      var_3.visible = var_1;
      var_3 hide();

      if(isdefined(var_3.effect))
        var_3.effect thread common_scripts\utility::pauseeffect();
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

get_delay() {
  return randomfloatrange(self.script_delay_min, self.script_delay_max);
}

init_light_def() {
  var_0["pulse"] = ::def_pulse;
  var_0["neon"] = ::def_neon;
  var_0["fire"] = ::def_fire;
  [[var_0[self.script_light]]]();
}

def_pulse() {
  set_delays(0.1, 0.2);
  set_waits(1, 4);
  set_counts(3, 6);
  set_threshold(0.5);
  var_0 = self getlightintensity();
  set_intensities(var_0 * 0.25, var_0);
  thread pulse_think();
}

def_neon() {
  set_delays(0.05, 0.1);
  set_waits(2, 5);
  set_counts(1, 3);
  set_threshold(0.5);
  var_0 = self getlightintensity();
  set_intensities(var_0 * 0.1, var_0);
  thread pulse_think();
}

def_fire() {
  set_delays(0.05, 0.1);
  set_waits(0.05, 0.1);
  set_counts(1, 2);
  set_threshold(0.5);
  var_0 = self getlightintensity();
  set_intensities(var_0 * 0.75, var_0);
  thread pulse_think();
}

set_threshold(var_0) {
  if(!isdefined(self.script_threshold))
    self.script_threshold = var_0;

  foreach(var_2 in self.linked_lights) {
    if(!isdefined(var_2.script_threshold))
      var_2.script_threshold = self.script_threshold;
  }
}

set_delays(var_0, var_1) {
  if(!isdefined(self.script_delay_min))
    self.script_delay_min = var_0;

  if(!isdefined(self.script_delay_max))
    self.script_delay_max = var_1;
}

set_waits(var_0, var_1) {
  if(!isdefined(self.script_wait_min))
    self.script_wait_min = var_0;

  if(!isdefined(self.script_wait_max))
    self.script_wait_max = var_1;
}

set_counts(var_0, var_1) {
  if(!isdefined(self.script_count_min))
    self.script_count_min = var_0;

  if(!isdefined(self.script_count_max))
    self.script_count_max = var_1;
}

set_intensities(var_0, var_1) {
  if(!isdefined(self.script_intensity_min))
    self.script_intensity_min = var_0;

  if(!isdefined(self.script_intensity_max))
    self.script_intensity_max = var_1;
}