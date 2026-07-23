/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\138.gsc
**************************************/

is_light_entity(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

flickerlight(var_0, var_1, var_2, var_3) {
  self endon("kill_flicker");
  var_4 = var_0;
  var_5 = 0.0;
  maps\_utility::ent_flag_init("stop_flicker");

  for(;;) {
    if(maps\_utility::ent_flag("stop_flicker")) {
      wait 0.05;
      continue;
    }

    var_6 = var_4;
    var_4 = var_0 + (var_1 - var_0) * randomfloat(1.0);

    if(var_2 != var_3) {
      var_5 = var_5 + randomfloatrange(var_2, var_3);
    } else {
      var_5 = var_5 + var_2;
    }
    if(var_5 == 0) {
      var_5 = var_5 + 0.0000001;
    }
    for(var_7 = (var_6 - var_4) * (1 / var_5); var_5 > 0 && !maps\_utility::ent_flag("stop_flicker"); var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_7 * var_5);
      wait 0.05;
    }
  }
}

kill_flicker_when_damaged(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;
  var_3 = 100000000.0;

  foreach(var_5 in var_1) {
    var_6 = distance(self.origin, var_5.origin);

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  if(isDefined(var_2)) {
    var_2 waittill("damage", var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    self notify("kill_flicker");
    wait 0.05;
    self setlightcolor((0, 0, 0));
  }
}

generic_pulsing() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
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
  if(getDvar("r_reflectionProbeGenerate") == "1") {
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

getclosests_flickering_model(var_0) {
  var_1 = getEntArray("light_flicker_model", "targetname");
  var_2 = [];
  var_3 = maps\_utility::getclosest(var_0, var_1);

  if(isDefined(var_3)) {
    var_2[0] = var_3;
  }
  return var_2;
}

generic_flickering() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
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

  if(isDefined(self.script_linkto)) {
    self.linked_prefab_ents = common_scripts\utility::get_linked_ents();

    foreach(var_1 in self.linked_prefab_ents) {
      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "on") {
        if(!isDefined(self.lit_models)) {
          self.lit_models[0] = var_1;
        } else {
          self.lit_models[self.lit_models.size] = var_1;
        }
        continue;
      }

      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "off") {
        if(!isDefined(self.unlit_models)) {
          self.unlit_models[0] = var_1;
        } else {
          self.unlit_models[self.unlit_models.size] = var_1;
        }
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

  if(isDefined(self.script_noteworthy)) {
    self.linked_things = getEntArray(self.script_noteworthy, "targetname");
  }
  if(!self.linked_things.size && !isDefined(self.linked_prefab_ents)) {
    self.linked_things = getclosests_flickering_model(self.origin);
  }
  for(var_3 = 0; var_3 < self.linked_things.size; var_3++) {
    if(is_light_entity(self.linked_things[var_3])) {
      self.linked_lights = 1;
      self.linked_light_ents[self.linked_light_ents.size] = self.linked_things[var_3];
    }

    if(self.linked_things[var_3].classname == "script_model") {
      var_4 = self.linked_things[var_3];

      if(!isDefined(self.lit_models)) {
        self.lit_models[0] = var_4;
      } else {
        self.lit_models[self.lit_models.size] = var_4;
      }
      if(!isDefined(self.unlit_models)) {
        self.unlit_models[0] = getEnt(var_4.target, "targetname");
      } else {
        self.unlit_models[self.unlit_models.size] = getEnt(var_4.target, "targetname");
      }
      self.linked_models = 1;
    }
  }

  if(isDefined(self.lit_models)) {
    foreach(var_4 in self.lit_models) {
      if(isDefined(var_4) && isDefined(var_4.script_fxid)) {
        var_4.effect = common_scripts\utility::createoneshoteffect(var_4.script_fxid);
        var_6 = (0, 0, 0);
        var_7 = (0, 0, 0);

        if(isDefined(var_4.script_parameters)) {
          var_8 = strtok(var_4.script_parameters, ", ");

          if(var_8.size < 3) {} else if(var_8.size == 6) {
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

  if(isDefined(self.script_light_startnotify) && self.script_light_startnotify != "nil") {
    for(;;) {
      level waittill(self.script_light_startnotify);
      maps\_utility::ent_flag_set("flicker_on");

      if(isDefined(self.script_light_stopnotify) && self.script_light_stopnotify != "nil") {
        level waittill(self.script_light_stopnotify);
        maps\_utility::ent_flag_clear("flicker_on");
      }
    }
  } else {
    maps\_utility::ent_flag_set("flicker_on");
  }
}

generic_flicker_pause() {
  var_0 = self getlightintensity();

  if(!maps\_utility::ent_flag("flicker_on")) {
    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(var_2 in self.lit_models) {
          var_2 hide();

          if(isDefined(var_2.effect)) {
            var_2.effect common_scripts\utility::pauseeffect();
          }
        }
      }

      if(isDefined(self.unlit_models)) {
        foreach(var_5 in self.unlit_models) {}
        var_5 show();
      }
    }

    self setlightintensity(0);

    if(self.linked_lights) {
      for(var_7 = 0; var_7 < self.linked_light_ents.size; var_7++) {
        self.linked_light_ents[var_7] setlightintensity(0);
      }
    }

    maps\_utility::ent_flag_wait("flicker_on");
    self setlightintensity(var_0);

    if(self.linked_lights) {
      for(var_7 = 0; var_7 < self.linked_light_ents.size; var_7++) {
        self.linked_light_ents[var_7] setlightintensity(var_0);
      }
    }

    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(var_2 in self.lit_models) {
          var_2 show();

          if(isDefined(var_2.effect)) {
            var_2.effect maps\_utility::restarteffect();
          }
        }
      }

      if(isDefined(self.unlit_models)) {
        foreach(var_5 in self.unlit_models) {}
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

  while(isDefined(self)) {
    generic_flicker_pause();

    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      generic_flicker_pause();
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);

        if(self.linked_models) {
          foreach(var_7 in self.lit_models) {
            var_7 hide();

            if(isDefined(var_7.effect)) {
              var_7.effect common_scripts\utility::pauseeffect();
            }
          }
        }

        if(isDefined(self.unlit_models)) {
          foreach(var_10 in self.unlit_models) {}
          var_10 show();
        }
      } else {
        var_4 = var_2;

        if(self.linked_models) {
          if(isDefined(self.lit_models)) {
            foreach(var_7 in self.lit_models) {
              var_7 show();

              if(isDefined(var_7.effect)) {
                var_7.effect maps\_utility::restarteffect();
              }
            }
          }

          if(isDefined(self.unlit_models)) {
            foreach(var_10 in self.unlit_models) {
              var_10 hide();
              maps\_audio::aud_send_msg("light_flicker_on", var_10);
            }
          }
        }
      }

      self setlightintensity(var_4);

      if(self.linked_lights) {
        for(var_16 = 0; var_16 < self.linked_light_ents.size; var_16++) {
          self.linked_light_ents[var_16] setlightintensity(var_4);
        }
      }
    }

    generic_flicker_pause();
    self setlightintensity(var_2);

    if(self.linked_lights) {
      for(var_16 = 0; var_16 < self.linked_light_ents.size; var_16++) {
        self.linked_light_ents[var_16] setlightintensity(var_2);
      }
    }

    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(var_7 in self.lit_models) {
          var_7 show();

          if(isDefined(var_7.effect)) {
            var_7.effect maps\_utility::restarteffect();
          }
        }
      }

      if(isDefined(self.unlit_models)) {
        foreach(var_10 in self.unlit_models) {}
        var_10 hide();
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

generic_spot() {
  for(;;) {
    level common_scripts\utility::waitframe();
  }
}

flickerlightintensity(var_0, var_1) {
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  for(;;) {
    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);
      } else {
        var_4 = var_2;
      }
      self setlightintensity(var_4);
    }

    self setlightintensity(var_2);
    wait(randomfloatrange(var_0, var_1));
  }
}

burning_trash_fire() {
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

    if(var_5 > var_2) {
      var_5 = var_5 - var_2;
    }
    if(isDefined(var_3)) {
      if(common_scripts\utility::flag(var_3)) {
        return;
      }
    }
  }
}

changelightcolorto(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
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

television() {
  thread tv_changes_intensity();
  thread tv_changes_color();
}

tv_changes_intensity() {
  self endon("light_off");
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 1.2);
    var_3 = var_3 * 20;

    for(var_4 = 0; var_4 < var_3; var_4++) {
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

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_2[var_4] = 0;
    var_3[var_4] = 0;
  }

  for(;;) {
    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3[var_4] = var_2[var_4];
      var_2[var_4] = randomfloat(var_0) + var_1;
    }

    var_5 = randomfloatrange(0.3, 1.2);
    var_5 = var_5 * 20;

    for(var_4 = 0; var_4 < var_5; var_4++) {
      var_6 = [];

      for(var_7 = 0; var_7 < var_2.size; var_7++) {
        var_6[var_7] = var_2[var_7] * (var_4 / var_5) + var_3[var_7] * ((var_5 - var_4) / var_5);
      }
      self setlightcolor((var_6[0], var_6[1], var_6[2]));
      wait 0.05;
    }
  }
}

sun_shadow_trigger(var_0) {
  var_1 = 1;

  if(isDefined(var_0.script_duration)) {
    var_1 = var_0.script_duration;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 set_sun_shadow_params(var_1);
  }
}

set_sun_shadow_params(var_0) {
  var_1 = getdvarint("sm_sunenable", 1);
  var_2 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_3 = getdvarint("sm_spotlimit", 4);
  var_4 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_5 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isDefined(self.script_sunenable)) {
    var_1 = self.script_sunenable;
  }
  if(isDefined(self.script_sunshadowscale)) {
    var_2 = self.script_sunshadowscale;
  }
  if(isDefined(self.script_spotlimit)) {
    var_3 = self.script_spotlimit;
  }
  if(isDefined(self.script_sunsamplesizenear)) {
    var_4 = self.script_sunsamplesizenear;
  }
  var_4 = min(max(0.016, var_4), 32);

  if(isDefined(self.script_qualityspotshadow)) {
    var_5 = self.script_qualityspotshadow;
  }
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

    for(var_7 = 0; var_7 < var_4; var_7++) {
      var_6 = var_6 + var_5;
      setsaveddvar("sm_sunSampleSizeNear", var_6);
      wait 0.05;
    }
  }

  setsaveddvar("sm_sunSampleSizeNear", var_0);
}