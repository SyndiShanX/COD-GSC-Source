/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_lighting.gsc
**************************************/

main() {
  init_lights();
  level.spec_cg = 3.3;
  level.spec_ng = 15.0;
  maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", level.spec_cg, level.spec_ng);
  maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.5, 1.5);
  level.spec_cg_fireworks_low = 2;
  level.spec_cg_fireworks_high = 2.6;
  level.spec_ng_fireworks_low = 1.5;
  level.spec_ng_fireworks_high = 1.8;
}

init_post_main() {
  thread horizontal_sunlight();
  thread setup_fixtures();
}

init_lights() {
  var_0 = getEntArray("cnd_fire_rappel_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::cnd_fire_rappel_light);
  var_1 = getEntArray("cnd_fire_horizontal_light", "targetname");
  common_scripts\utility::array_thread(var_1, ::cnd_fire_horizontal_light);
  var_2 = getEntArray("cnd_shaft_flickering", "targetname");
  common_scripts\utility::array_thread(var_2, ::cnd_shaft_flickering);
}

lerp_dof() {}

virus_dynamic_dof(var_0) {}

horizontal_sunlight() {
  common_scripts\utility::flag_wait("teleport");
  thread horizontal_sunlight_flicker();
}

horizontal_sunlight_flicker() {
  var_0 = (1, 0.58, 0.3);
  var_1 = 0.65;
  var_2 = 1.5;
  var_3 = 0.1;
  var_4 = 0.37;

  for(;;) {
    var_5 = randomfloatrange(var_1, var_2);
    var_6 = randomfloatrange(var_3, var_4);
    var_7 = var_0 * var_5;
    var_8 = var_0;
    sun_lerp_value(var_8, var_7, var_6);
    var_6 = randomfloatrange(var_3, var_4);
    sun_lerp_value(var_7, var_8, var_6);
  }
}

sun_lerp_value(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = 0;

  while(var_3 > 0) {
    var_3 = var_3 - 0.05;
    var_4 = (var_2 - var_3) / var_2;
    var_5 = var_0 + (var_1 - var_0) * var_4;
    setsunlight(var_5[0], var_5[1], var_5[2]);
    level.currentsunlightcolor = (var_5[0], var_5[1], var_5[2]);
    common_scripts\utility::waitframe();
  }
}

cnd_reception_elevator() {
  var_0 = getent("rec_elevator_light", "targetname");
  var_1 = var_0 getlightintensity();
  var_0 setlightintensity(0.01);
  var_2 = var_0 getlightintensity();
  var_3 = var_1 / 20;
  common_scripts\utility::flag_wait("courtyard_intro_elevator_opening");
  wait 0.4;

  for(var_4 = 0; var_4 < 19; var_4++) {
    var_0 setlightintensity(var_2 + var_3);
    var_2 = var_0 getlightintensity();
    common_scripts\utility::waitframe();
  }
}

cnd_fire_rappel_light() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.3, var_0 * 1.5);
    var_3 = randomfloatrange(0.05, 0.1);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.02;
    }

    var_1 = var_2;
  }
}

cnd_fire_horizontal_light() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 1.1, var_0 * 1.8);
    var_3 = randomfloatrange(0.05, 0.2);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.02;
    }

    var_1 = var_2;
  }
}

cnd_restarteffect() {
  common_scripts\_createfx::restart_fx_looper();
}

cnd_ent_flag_clear(var_0) {
  if(self.ent_flag[var_0]) {
    self.ent_flag[var_0] = 0;
    self notify(var_0);
  }
}

cnd_ent_flag_set(var_0) {
  self.ent_flag[var_0] = 1;
  self notify(var_0);
}

cnd_ent_flag_init(var_0) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var_0] = 0;
}

cnd_is_light_entity(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

cnd_getclosests_flickering_model(var_0) {
  var_1 = getEntArray("light_flicker_model", "targetname");
  var_2 = [];
  var_3 = common_scripts\utility::getclosest(var_0, var_1);

  if(isDefined(var_3)) {
    var_2[0] = var_3;
  }

  return var_2;
}

cnd_shaft_flickering() {
  self endon("stop_dynamic_light_behavior");
  self.linked_models = 0;
  self.lit_models = undefined;
  self.unlit_models = undefined;
  self.linked_lights = 0;
  self.linked_light_ents = [];
  self.linked_prefab_ents = undefined;
  self.linked_things = [];

  if(isDefined(self.script_noteworthy)) {
    self.linked_things = getEntArray(self.script_noteworthy, "targetname");
  }

  if(!self.linked_things.size && !isDefined(self.linked_prefab_ents)) {
    self.linked_things = cnd_getclosests_flickering_model(self.origin);
  }

  for(var_0 = 0; var_0 < self.linked_things.size; var_0++) {
    if(cnd_is_light_entity(self.linked_things[var_0])) {
      self.linked_lights = 1;
      self.linked_light_ents[self.linked_light_ents.size] = self.linked_things[var_0];
    }

    if(self.linked_things[var_0].classname == "script_model") {
      var_1 = self.linked_things[var_0];

      if(!isDefined(self.lit_models)) {
        self.lit_models[0] = var_1;
      } else {
        self.lit_models[self.lit_models.size] = var_1;
      }

      if(!isDefined(self.unlit_models)) {
        self.unlit_models[0] = getent(var_1.target, "targetname");
      } else {
        self.unlit_models[self.unlit_models.size] = getent(var_1.target, "targetname");
      }

      self.linked_models = 1;
    }
  }

  if(isDefined(self.lit_models)) {
    foreach(var_1 in self.lit_models) {
      if(isDefined(var_1) && isDefined(var_1.script_fxid)) {
        var_1.effect = common_scripts\utility::createoneshoteffect(var_1.script_fxid);
        var_3 = (0, 0, 0);
        var_4 = (0, 0, 0);

        if(isDefined(var_1.script_parameters)) {
          var_5 = strtok(var_1.script_parameters, ", ");

          if(var_5.size < 3) {} else if(var_5.size == 6) {
            var_6 = float(var_5[0]);
            var_7 = float(var_5[1]);
            var_8 = float(var_5[2]);
            var_3 = (var_6, var_7, var_8);
            var_6 = float(var_5[3]);
            var_7 = float(var_5[4]);
            var_8 = float(var_5[5]);
            var_4 = (var_6, var_7, var_8);
          } else {
            var_6 = float(var_5[0]);
            var_7 = float(var_5[1]);
            var_8 = float(var_5[2]);
            var_3 = (var_6, var_7, var_8);
          }
        }

        var_1.effect.v["origin"] = var_1.origin + var_3;
        var_1.effect.v["angles"] = var_1.angles + var_4;
      }
    }
  }

  thread cnd_generic_flicker_msg_watcher();
  thread cnd_generic_flicker();
}

cnd_generic_flicker_msg_watcher() {
  cnd_ent_flag_init("flicker_on");

  if(isDefined(self.script_light_startnotify) && self.script_light_startnotify != "nil") {
    for(;;) {
      level waittill(self.script_light_startnotify);
      cnd_ent_flag_set("flicker_on");

      if(isDefined(self.script_light_stopnotify) && self.script_light_stopnotify != "nil") {
        level waittill(self.script_light_stopnotify);
        cnd_ent_flag_clear("flicker_on");
      }
    }
  } else
    cnd_ent_flag_set("flicker_on");
}

cnd_generic_flicker_pause() {
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
        foreach(var_5 in self.unlit_models) {
          var_5 show();
        }
      }
    }

    self setlightintensity(0);

    if(self.linked_lights) {
      for(var_7 = 0; var_7 < self.linked_light_ents.size; var_7++) {
        self.linked_light_ents[var_7] setlightintensity(0);
      }
    }

    self waittill("flicker_on");
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
            var_2.effect cnd_restarteffect();
          }
        }
      }

      if(isDefined(self.unlit_models)) {
        foreach(var_5 in self.unlit_models) {
          var_5 hide();
        }
      }
    }
  }
}

cnd_generic_flicker() {
  self endon("stop_dynamic_light_behavior");
  self endon("death");
  var_0 = 0.2;
  var_1 = 1.0;
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  while(isDefined(self)) {
    cnd_generic_flicker_pause();

    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      cnd_generic_flicker_pause();
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
          foreach(var_10 in self.unlit_models) {
            var_10 show();
          }
        }
      } else {
        var_4 = var_2;

        if(self.linked_models) {
          if(isDefined(self.lit_models)) {
            foreach(var_7 in self.lit_models) {
              var_7 show();

              if(isDefined(var_7.effect)) {
                var_7.effect cnd_restarteffect();
              }
            }
          }

          if(isDefined(self.unlit_models)) {
            foreach(var_10 in self.unlit_models) {
              var_10 hide();
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

    cnd_generic_flicker_pause();
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
            var_7.effect cnd_restarteffect();
          }
        }
      }

      if(isDefined(self.unlit_models)) {
        foreach(var_10 in self.unlit_models) {
          var_10 hide();
        }
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

setup_fixtures() {
  var_0 = getEntArray("hvt_office_light_fixture_off", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_0 = getEntArray("stairwell_light_fixture_off", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }
}

hvt_office_light() {
  var_0 = getEntArray("hvt_office_light", "targetname");
  var_1 = getEntArray("hvt_office_light_fixture_on", "targetname");
  var_2 = getEntArray("hvt_office_light_fixture_off", "targetname");
  var_3 = 0.5;
  var_4 = 1.65;
  var_5 = 18;
  var_6 = 0.03;
  var_7 = 0.12;
  var_8 = 0.05;
  var_9 = 0.15;
  thread fixture_blink_lights(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

stairwell_light(var_0) {
  var_1 = getEntArray("stairwell_light_blink", "targetname");
  var_2 = getEntArray("stairwell_light_fixture_on", "targetname");
  var_3 = getEntArray("stairwell_light_fixture_off", "targetname");
  var_4 = 0.5;
  var_5 = 1.45;
  var_6 = var_0;
  var_7 = 0.06;
  var_8 = 0.12;
  var_9 = 0.05;
  var_10 = 0.1;
  thread fixture_blink_lights(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

fixture_blink_lights(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level notify("stop_blinking_fixtures");
  level endon("stop_blinking_fixtures");
  thread cleanup_fixtures(var_0, var_1, var_2, var_4, "stop_blinking_fixtures");

  for(var_10 = 0; var_10 < var_5; var_10++) {
    foreach(var_12 in var_0) {
      var_12 setlightintensity(0);
    }

    foreach(var_15 in var_1) {
      var_15 hide();
    }

    foreach(var_15 in var_2) {
      var_15 show();
    }

    wait(randomfloatrange(var_6, var_7));
    var_19 = randomfloatrange(var_3, var_4);

    foreach(var_12 in var_0) {
      var_12 setlightintensity(var_19);
    }

    foreach(var_15 in var_1) {
      var_15 show();
    }

    foreach(var_15 in var_2) {
      var_15 hide();
    }

    wait(randomfloatrange(var_8, var_9));
  }

  level notify("stop_blinking_fixtures");
}

cleanup_fixtures(var_0, var_1, var_2, var_3, var_4) {
  level waittill(var_4);

  foreach(var_6 in var_0) {
    var_6 setlightintensity(var_3);
  }

  foreach(var_9 in var_1) {
    var_9 show();
  }

  foreach(var_9 in var_2) {
    var_9 hide();
  }
}

fireworks_intro() {
  var_0 = "intro";
  common_scripts\utility::waitframe();
  fireworks_init(var_0);
  fireworks_finale(66);
  var_1 = 0;
  thread _fireworks_internal(var_0, var_1);
  thread _fireworks_meteor_internal(var_0, var_1);
}

fireworks_intro_post() {
  common_scripts\utility::waitframe();
  thread fireworks_start("intro");
}

fireworks_stealth_rappel() {
  common_scripts\utility::waitframe();
  thread fireworks_start("stealth");
}

fireworks_courtyard() {
  var_0 = "courtyard";
  fireworks_init(var_0);
  common_scripts\utility::waitframe();
  thread fireworks_courtyard_stairs();
  var_1 = 0;
  thread _fireworks_internal(var_0, var_1);
  thread _fireworks_meteor_internal(var_0, var_1);
}

fireworks_courtyard_post() {
  common_scripts\utility::waitframe();
  thread fireworks_start("courtyard_stairs");
}

fireworks_courtyard_stairs() {
  common_scripts\utility::flag_wait("move_to_courtyard_entrance");
  thread fireworks_start("courtyard_stairs");
}

fireworks_junction() {
  var_0 = "junction";
  fireworks_init(var_0);
  common_scripts\utility::waitframe();
  var_1 = 0;
  thread _fireworks_internal(var_0, var_1);
  thread _fireworks_meteor_internal(var_0, var_1);
}

fireworks_junction_post() {
  common_scripts\utility::waitframe();
  thread fireworks_start("junction");
}

firework_light(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0.8;
  }

  if(!isDefined(var_4)) {
    var_4 = 2.8;
  }

  var_5 = 20 * var_3;

  if(!isDefined(self.script_parameters)) {
    var_6 = 10.0;
  } else {
    var_6 = int(self.script_parameters);
  }

  var_7 = self getlightintensity();
  self setlightcolor(var_2);
  var_8 = (var_6 - var_7) / var_5;
  var_9 = 20 * var_4;
  var_10 = var_6 / var_9;
  var_11 = level.fireworklightindextracker[var_0];

  for(var_12 = 0; var_12 < var_5; var_12++) {
    if(!(level.fireworklightindextracker[var_0] == var_11)) {
      break;
    }

    var_7 = var_7 + var_8;
    self setlightintensity(min(var_7, var_6));
    wait 0.05;
  }

  if(level.fireworklightindextracker[var_0] == var_11) {
    for(var_12 = 0; var_12 < var_9; var_12++) {
      if(!(level.fireworklightindextracker[var_0] == var_11)) {
        break;
      }

      var_7 = var_7 - var_10;
      self setlightintensity(max(0.01, var_7));
      wait 0.05;
    }
  }
}

startfireworklightsonsection(var_0, var_1) {
  if(var_0 >= 0 && var_0 <= 3) {
    var_2 = level.fireworklights[var_0];
    level.fireworklightindextracker[var_0] = level.fireworklightindextracker[var_0] + 1;

    if(level.fireworklightindextracker[var_0] > 48) {
      level.fireworklightindextracker[var_0] = 0;
    }

    for(var_3 = 0; var_3 < level.fireworklights[var_0].size; var_3++) {
      level.fireworklights[var_0][var_3] thread firework_light(var_0, var_3, var_1);
    }
  }
}

fireworks_start(var_0) {
  var_1 = isDefined(level.fireworks) || isDefined(level.meteorfireworks) || isDefined(level.fireworkstructs) || isDefined(level.meteorfireworkstructs);
  fireworks_init(var_0);

  if(var_1) {
    return;
  }
  thread _fireworks_internal(var_0);
  thread _fireworks_meteor_internal(var_0);
}

fireworks_stop() {
  if(!isDefined(level.fireworks) || !isDefined(level.meteorfireworks) || !isDefined(level.fireworkstructs) || !isDefined(level.meteorfireworkstructs)) {
    return;
  }
  level notify("stop_fireworks");
  thread _fireworks_cleanup();
}

fireworks_init(var_0) {
  level.fireworks = [];
  level.fireworkstructs = [];
  level.meteorfireworks = [];
  level.meteorfireworkstructs = [];
  level.currentfireworkslocation = var_0;

  if(maps\_utility::is_gen4()) {
    var_1 = (0.792969, 0.5625, 0.332031);
    var_2 = (0.878906, 0.539062, 0.03125);
    var_3 = (0.582031, 0.917969, 0.933594);
    var_4 = (0.648438, 0.351562, 0.75);
    var_5 = (0.503906, 0.945312, 0.375);
    var_6 = (0.996094, 0.605469, 0.214844);
  } else {
    var_1 = (0.792969, 0.5625, 0.332031);
    var_2 = (0.878906, 0.628906, 0.710938);
    var_3 = (0.628906, 0.746094, 0.878906);
    var_4 = (0.652344, 0, 0.898438);
    var_5 = (0.628906, 0.878906, 0.707031);
    var_6 = (0.75, 0.75, 0.75);
  }

  var_7 = 0;
  var_8 = 1;
  var_9 = 2;
  var_10 = -1;

  if(var_0 == "intro") {
    if(maps\_utility::is_gen4()) {
      var_11 = (0.819608, 0.976471, 1);
    } else {
      var_11 = (0.823529, 0.980392, 1);
    }

    var_12 = 0.6;
    var_1 = (var_11 + var_1 * var_12) / 2;
    var_2 = (var_11 + var_2 * var_12) / 2;
    var_3 = (var_11 + var_3 * var_12) / 2;
    var_4 = (var_11 + var_4 * var_12) / 2;
    var_5 = (var_11 + var_5 * var_12) / 2;
    var_6 = (var_11 + var_6 * var_12) / 2;
  }

  level.fireworklights[var_7] = getEntArray("firework_light_02", "targetname");
  level.fireworklights[var_8] = getEntArray("firework_light_01", "targetname");
  level.fireworklights[var_9] = getEntArray("firework_light_03", "targetname");

  for(var_13 = 0; var_13 < 3; var_13++) {
    level.fireworklightindextracker[var_13] = 0;

    for(var_14 = 0; var_14 < level.fireworklights[var_13].size; var_14++) {
      var_15 = level.fireworklights[var_13][var_14] getlightintensity();
      level.fireworklights[var_13][var_14].script_parameters = var_15;
      level.fireworklights[var_13][var_14] setlightintensity(0.01);
    }
  }

  var_16 = [var_1, var_2, var_3, var_4, var_5, var_6];

  if(var_0 == "intro") {
    var_17 = [(-32596, 53993, 14595), (2067, 37400.8, 17595.8), (35664, 7879.75, 16595.8)];
    var_18 = [(271, 360, 0), (271, 360, 0), (271, 360, 0)];
    var_19 = [0, 1, 2];
    setup_current_fireworks(var_17, var_18, var_19, var_16);
    var_17 = [(-15299, 46161, 19744), (5834, 14505.8, 21545.8)];
    setup_current_fireworks(var_17, var_18, [0.5, 1.5], var_16, 1);
  } else if(var_0 == "junction") {
    var_17 = [(-67465, 8665, 21595), (-40058, 48365.8, 21595)];
    var_18 = [(271, 360, 0), (271, 360, 0)];
    var_19 = [-1, 2];
    setup_current_fireworks(var_17, var_18, var_19, var_16);
  } else if(var_0 == "garden") {
    var_17 = [(-34561, 42696, 21595), (9465, 30726, 21595), (18776, -870, 21595)];
    var_18 = [(271, 360, 0), (271, 360, 0), (271, 360, 0)];
    var_19 = [0, 1, 2];
    setup_current_fireworks(var_17, var_18, var_19, var_16);
  } else if(var_0 == "stealth") {
    var_17 = [(13800, -7987.75, 19595.8)];
    var_18 = [(271, 360, 0)];
    var_19 = [2];
    setup_current_fireworks(var_17, var_18, var_19, var_16);
    var_17 = [(-54000, -20000, 16500)];
    var_18 = [(271, 360, 0)];
    var_19 = [-1];
    setup_current_fireworks(var_17, var_18, var_19, var_16, undefined, 1);
  } else if(var_0 == "courtyard" || var_0 == "courtyard_stairs") {
    var_17 = [(-30321, 49026, 21595), (3630, 32949, 21595), (30216, 500, 21595)];
    var_18 = [(271, 360, 0), (271, 360, 0), (271, 360, 0)];
    var_19 = [0, 1, 2];
    setup_current_fireworks(var_17, var_18, var_19, var_16);
  } else {}

  level.fireworks_sun = _get_location_sunlight(var_0);
  level.fireworks_location = var_0;
}

setup_current_fireworks(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3[0];
  var_7 = var_3[1];
  var_8 = var_3[2];
  var_9 = var_3[3];
  var_10 = var_3[4];
  var_11 = var_3[5];
  var_12 = 0;

  if(!isDefined(var_5)) {
    if(!isDefined(var_4)) {
      foreach(var_14 in var_2) {
        var_15 = var_0[var_12];
        var_16 = anglesToForward(var_1[var_12]);
        var_17 = anglestoup(var_1[var_12]);
        var_18 = spawnfx(level._effect["fireworks_blue_lrg"], var_15, var_16, var_17);
        var_19 = spawnfx(level._effect["fireworks_red_lrg"], var_15, var_16, var_17);
        var_20 = spawnfx(level._effect["fireworks_green_lrg"], var_15, var_16, var_17);
        var_21 = spawnfx(level._effect["fireworks_white_lrg"], var_15, var_16, var_17);
        var_22 = spawnfx(level._effect["fireworks_blue"], var_15, var_16, var_17);
        var_23 = spawnfx(level._effect["fireworks_red"], var_15, var_16, var_17);
        var_24 = spawnfx(level._effect["fireworks_green"], var_15, var_16, var_17);
        var_25 = spawnfx(level._effect["fireworks_white"], var_15, var_16, var_17);
        var_26 = spawnfx(level._effect["vfx_fireworks_ground_straight"], var_15, var_16, var_17);
        var_27 = spawnfx(level._effect["fireworks_popping"], var_15, var_16, var_17);
        var_28 = spawnfx(level._effect["vfx_fireworks_groundflare_oneshot3"], var_15, var_16, var_17);
        var_29 = spawnfx(level._effect["vfx_fireworks_groundflare_oneshot2"], var_15, var_16, var_17);
        var_30 = spawnfx(level._effect["vfx_fireworks_groundflare_oneshot"], var_15, var_16, var_17);
        var_31 = spawnfx(level._effect["vfx_fireworks_ground_straight_single"], var_15, var_16, var_17);
        var_32 = spawnfx(level._effect["vfx_fireworks_meteors_trails"], var_15, var_16, var_17);
        add_large_firework(var_18, var_8, var_14, 6);
        add_large_firework(var_19, var_7, var_14, 6);
        add_large_firework(var_20, var_10, var_14, 6);
        add_large_firework(var_21, var_11, var_14, 6);
        add_small_firework(var_22, var_8, var_14, 8);
        add_small_firework(var_23, var_7, var_14, 8);
        add_small_firework(var_24, var_10, var_14, 8);
        add_small_firework(var_25, var_11, var_14, 8);
        add_meteor_firework(var_26, var_6, var_14, 4);
        add_meteor_firework(var_27, var_6, var_14, 4);
        add_meteor_firework(var_28, var_6, var_14, 4);
        add_meteor_firework(var_29, var_6, var_14, 4);
        add_meteor_firework(var_30, var_6, var_14, 4);
        add_meteor_firework(var_31, var_6, var_14, 4);
        add_meteor_firework(var_32, var_6, var_14, 4);
        var_12 = var_12 + 1;
      }

      return;
    }

    var_12 = 0;

    foreach(var_14 in var_2) {
      var_15 = var_0[var_12];
      var_16 = anglesToForward(var_1[var_12]);
      var_17 = anglestoup(var_1[var_12]);
      var_18 = spawnfx(level._effect["fireworks_blue_lrg"], var_15, var_16, var_17);
      var_19 = spawnfx(level._effect["fireworks_red_lrg"], var_15, var_16, var_17);
      var_20 = spawnfx(level._effect["fireworks_green_lrg"], var_15, var_16, var_17);
      var_21 = spawnfx(level._effect["fireworks_white_lrg"], var_15, var_16, var_17);
      var_22 = spawnfx(level._effect["fireworks_blue"], var_15, var_16, var_17);
      var_23 = spawnfx(level._effect["fireworks_red"], var_15, var_16, var_17);
      var_24 = spawnfx(level._effect["fireworks_green"], var_15, var_16, var_17);
      var_25 = spawnfx(level._effect["fireworks_white"], var_15, var_16, var_17);
      add_small_firework(var_18, var_8, var_14, 1);
      add_small_firework(var_19, var_7, var_14, 1);
      add_small_firework(var_20, var_10, var_14, 1);
      add_small_firework(var_21, var_11, var_14, 1);
      add_small_firework(var_22, var_8, var_14, 2);
      add_small_firework(var_23, var_7, var_14, 2);
      add_small_firework(var_24, var_10, var_14, 2);
      add_small_firework(var_25, var_11, var_14, 2);
      var_12 = var_12 + 1;
    }

    return;
  } else {
    foreach(var_14 in var_2) {
      var_15 = var_0[var_12];
      var_16 = anglesToForward(var_1[var_12]);
      var_17 = anglestoup(var_1[var_12]);
      var_22 = spawnfx(level._effect["fireworks_blue_sm"], var_15, var_16, var_17);
      var_23 = spawnfx(level._effect["fireworks_red_sm"], var_15, var_16, var_17);
      var_24 = spawnfx(level._effect["fireworks_green_sm"], var_15, var_16, var_17);
      var_25 = spawnfx(level._effect["fireworks_white_sm"], var_15, var_16, var_17);
      var_37 = spawnfx(level._effect["fireworks_all_sm"], var_15, var_16, var_17);
      add_small_firework(var_22, var_8, var_14, 4);
      add_small_firework(var_23, var_7, var_14, 4);
      add_small_firework(var_24, var_10, var_14, 4);
      add_small_firework(var_25, var_11, var_14, 4);
      add_small_firework(var_37, var_11, var_14, 8);
      var_12 = var_12 + 1;
    }
  }
}

add_meteor_firework(var_0, var_1, var_2, var_3) {
  if(!var_3) {
    var_3 = 1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    setup_meteor_firework(var_0, var_1, 2.5, "meteor", 1, var_2);
  }
}

add_small_firework(var_0, var_1, var_2, var_3) {
  if(!var_3) {
    var_3 = 1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    setup_firework(var_0, var_1, 3, "small", 2, var_2);
  }
}

add_large_firework(var_0, var_1, var_2, var_3) {
  if(!var_3) {
    var_3 = 1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    setup_firework(var_0, var_1, 6, "large", 3, var_2);
  }
}

setup_firework(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.fireworks.size;
  level.fireworkstructs[var_6] = spawnStruct();
  level.fireworkstructs[var_6].color = var_1;
  level.fireworkstructs[var_6].time = var_2;
  level.fireworkstructs[var_6].type = var_3;
  level.fireworkstructs[var_6].girth = var_4;
  level.fireworkstructs[var_6].loc = var_5;
  level.fireworks[var_6] = var_0;
}

setup_meteor_firework(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.meteorfireworks.size;
  level.meteorfireworkstructs[var_6] = spawnStruct();
  level.meteorfireworkstructs[var_6].color = var_1;
  level.meteorfireworkstructs[var_6].time = var_2;
  level.meteorfireworkstructs[var_6].type = var_3;
  level.meteorfireworkstructs[var_6].girth = var_4;
  level.meteorfireworkstructs[var_6].loc = var_5;
  level.meteorfireworks[var_6] = var_0;
}

fireworks_finale(var_0) {
  thread fireworks_finale_streamers(var_0 / 3);
  thread fireworks_finale_explosions(var_0);
}

fireworks_finale_streamers(var_0) {
  var_1 = 0;
  wait 0.5;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 = get_random_streamer_num(var_1);
    activate_firework(var_1, "meteor");
    wait(randomfloatrange(0.55, 0.71));
  }
}

fireworks_finale_explosions(var_0) {
  var_1 = level.fireworks_sun;

  if(var_1 != level.fireworks_sun) {
    var_1 = level.fireworks_sun;
  }

  var_2 = 0;
  wait 0.5;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_2 = get_random_firework_num(var_2);

    if(level.fireworkstructs[var_2].type == "large") {
      thread _firework_sunlight(var_2, var_1);

      if(maps\_utility::is_gen4()) {
        if(level.fireworkstructs[var_2].loc != -1) {
          if(level.fireworkstructs[var_2].loc == 0.5) {
            level thread startfireworklightsonsection(0, level.fireworkstructs[var_2].color);
            level thread startfireworklightsonsection(1, level.fireworkstructs[var_2].color);
          } else if(level.fireworkstructs[var_2].loc == 1.5) {
            level thread startfireworklightsonsection(1, level.fireworkstructs[var_2].color);
            level thread startfireworklightsonsection(2, level.fireworkstructs[var_2].color);
          } else
            level thread startfireworklightsonsection(level.fireworkstructs[var_2].loc, level.fireworkstructs[var_2].color);
        }
      }
    }

    activate_firework(var_2);
    wait(randomfloatrange(0.4, 0.51));
  }
}

_fireworks_internal(var_0, var_1) {
  level endon("stop_fireworks");
  var_2 = 0;

  for(;;) {
    var_3 = level.fireworks_sun;

    if(var_3 != level.fireworks_sun) {
      var_3 = level.fireworks_sun;
    }

    if(var_0 != level.fireworks_location) {
      var_0 = level.fireworks_location;
      var_2 = get_random_firework_num();
    }

    if(level.fireworkstructs[var_2].type == "large") {
      thread _firework_sunlight(var_2, var_3);

      if(maps\_utility::is_gen4()) {
        if(level.fireworkstructs[var_2].loc != -1) {
          if(level.fireworkstructs[var_2].loc == 0.5) {
            level thread startfireworklightsonsection(0, level.fireworkstructs[var_2].color);
            level thread startfireworklightsonsection(1, level.fireworkstructs[var_2].color);
          } else if(level.fireworkstructs[var_2].loc == 1.5) {
            level thread startfireworklightsonsection(1, level.fireworkstructs[var_2].color);
            level thread startfireworklightsonsection(2, level.fireworkstructs[var_2].color);
          } else
            level thread startfireworklightsonsection(level.fireworkstructs[var_2].loc, level.fireworkstructs[var_2].color);
        }
      }
    }

    activate_firework(var_2, "explosion");
    var_4 = get_random_firework_num(var_2);
    _firework_wait(var_2, var_4, var_0, "explosion");
    var_2 = var_4;
    wait 0.05;
  }
}

_fireworks_meteor_internal(var_0, var_1) {
  level endon("stop_fireworks");
  var_2 = 0;

  for(;;) {
    if(var_0 != level.fireworks_location) {
      var_0 = level.fireworks_location;
      var_2 = get_random_streamer_num();
    }

    activate_firework(var_2, "meteor");
    var_3 = get_random_streamer_num(var_2);
    _firework_wait(var_2, var_3, var_0, "meteor");
    var_2 = var_3;
    wait 0.05;
  }
}

activate_firework(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "explosion";
  }

  if(var_1 == "explosion") {
    if(var_0 == -1) {
      var_0 = get_random_firework_num();
    }

    if(var_0 >= level.fireworkstructs.size) {
      var_0 = level.fireworkstructs.size - 1;
    }

    var_2 = level.fireworks[var_0];
    triggerfx(var_2);
  } else if(var_1 == "meteor") {
    if(var_0 == -1) {
      var_0 = get_random_streamer_num();
    }

    if(var_0 >= level.meteorfireworkstructs.size) {
      var_0 = level.meteorfireworkstructs.size - 1;
    }

    var_2 = level.meteorfireworks[var_0];
    triggerfx(var_2);
  }
}

get_random_streamer_num(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = randomintrange(0, level.meteorfireworkstructs.size - 1);

  if(var_0 == var_1) {
    var_1 = var_1 + 1;

    if(var_1 + 1 > level.meteorfireworkstructs.size) {
      var_1 = 0;
    }
  }

  if(isDefined(var_0)) {
    var_2 = level.meteorfireworkstructs[var_1];
    var_3 = level.meteorfireworkstructs[var_0];
    var_4 = var_1 == var_0;
    var_5 = var_2.girth == var_3.girth;

    if(var_5 && isDefined(var_2.loc) && isDefined(var_3.loc) && var_2.loc != var_3.loc) {
      var_5 = 0;
    }

    if(var_4 || var_5) {
      var_1 = (var_0 + 2) % level.meteorfireworkstructs.size;
    }
  }

  if(var_1 == level.meteorfireworkstructs.size) {
    var_1 = var_1 - 1;
  }

  return var_1;
}

get_random_firework_num(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = randomintrange(0, level.fireworkstructs.size - 1);

  if(var_0 == var_1) {
    var_1 = var_1 + 1;

    if(var_1 + 1 > level.fireworkstructs.size) {
      var_1 = 0;
    }
  }

  if(isDefined(var_0)) {
    var_2 = level.fireworkstructs[var_1];
    var_3 = level.fireworkstructs[var_0];
    var_4 = var_1 == var_0;
    var_5 = var_2.girth == var_3.girth;

    if(var_5 && isDefined(var_2.loc) && isDefined(var_3.loc) && var_2.loc != var_3.loc) {
      var_5 = 0;
    }

    if(var_4 || var_5) {
      var_1 = (var_0 + 2) % level.fireworkstructs.size;
    }
  }

  if(var_1 == level.fireworkstructs.size) {
    var_1 = var_1 - 1;
  }

  return var_1;
}

_firework_wait(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "meteor";
  }

  var_4 = 0.8;
  var_5 = 1.0;

  if(var_2 == "junction" || var_2 == "intro") {
    if(var_3 == "explosion") {
      var_4 = 0.53;
      var_5 = 0.8;
    } else {
      var_4 = 1.2;
      var_5 = 1.7;
    }
  } else if(var_3 == "explosion") {
    var_4 = 0.95;
    var_5 = 1.4;
  } else {
    var_4 = 2.7;
    var_5 = 3.4;
  }

  var_6 = randomfloatrange(var_4, var_5);
  wait(var_6);
}

_firework_sunlight(var_0, var_1) {
  level notify("new_firework");
  level endon("new_firework");
  var_2 = level.fireworkstructs[var_0];

  switch (var_2.type) {
    case "large":
      _firework_large(var_1, var_2.color, var_2.time);
      break;
  }
}

_firework_large(var_0, var_1, var_2) {
  var_3 = 0.8;
  var_4 = 0.05;
  var_5 = 2.8;

  if(isDefined(level.currentsunlightcolor)) {
    var_0 = level.currentsunlightcolor;
  }

  if(isDefined(level.currentfireworkslocation)) {
    var_6 = _get_location_sunlight(level.currentfireworkslocation);

    if(common_scripts\utility::flag("do_specular_sun_lerp")) {
      thread lerp_spec_color_scale(level.spec_cg_fireworks_high, level.spec_ng_fireworks_high, var_3);
    }

    var_7 = 1.5;

    if(maps\_utility::is_gen4()) {
      sun_lerp_value(var_0, var_1 * var_7, var_3);
    } else {
      sun_lerp_value(var_0, var_1, var_3);
    }

    wait(var_4);

    if(common_scripts\utility::flag("do_specular_sun_lerp")) {
      thread lerp_spec_color_scale(level.spec_cg_fireworks_low, level.spec_ng_fireworks_low, var_5);
    }

    if(maps\_utility::is_gen4()) {
      sun_lerp_value(var_1 * var_7, var_6, var_5);
    } else {
      sun_lerp_value(var_1, var_6, var_5);
    }
  }
}

do_specular_sun_lerp(var_0) {
  if(var_0) {
    thread _turn_on_spec_sun_lerp();
  } else {
    thread _turn_off_spec_sun_lerp();
  }
}

_turn_on_spec_sun_lerp() {
  lerp_spec_color_scale(level.spec_cg_fireworks_low, level.spec_ng_fireworks_low, 1);
  common_scripts\utility::flag_set("do_specular_sun_lerp");
}

_turn_off_spec_sun_lerp() {
  common_scripts\utility::flag_clear("do_specular_sun_lerp");
  thread lerp_spec_color_scale(level.spec_cg, level.spec_ng, 1);
}

_fireworks_cleanup() {
  level.fireworks = undefined;
  level.fireworkstructs = undefined;
  level.meteorfireworks = undefined;
  level.meteorfireworkstructs = undefined;
  level.fireworks_stop = undefined;
  level.fireworks_sun = undefined;
  level.fireworks_location = undefined;
}

_get_location_sunlight(var_0) {
  switch (var_0) {
    case "junction":
      if(maps\_utility::is_gen4()) {
        return (0.348633, 0.292578, 0.213281);
      } else {
        return (0.348633, 0.292578, 0.213281);
      }
    case "garden":
      if(maps\_utility::is_gen4()) {
        return (0.996094, 0.980469, 0.863281);
      } else {
        return (0.996094, 0.980469, 0.863281);
      }
    case "intro":
      if(maps\_utility::is_gen4()) {
        return (0.819608, 0.976471, 1);
      } else {
        return (0.823529, 0.980392, 1);
      }
    case "courtyard_stairs":
    case "stealth":
    case "courtyard":
      if(maps\_utility::is_gen4()) {
        return (0.597656, 0.588281, 0.517969);
      } else {
        return (0.597656, 0.588281, 0.517969);
      }
    default:
      break;
  }
}

get_fog_ent(var_0) {
  var_1 = "";

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else if(isDefined(level.player.vision_set_transition_ent)) {
    var_1 = level.player.vision_set_transition_ent.vision_set;
  } else {
    var_1 = level.vision_set_transition_ent.vision_set;
  }

  return level.vision_set_fog[var_1];
}

set_fog_ent(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.transitiontime;
  }

  maps\_utility::set_fog_to_ent_values(var_0, var_1);
  wait(var_1);
}

handle_fog_changes() {
  common_scripts\utility::flag_wait("parachute_exfil");
  var_0 = get_fog_ent("cornered_09");
  var_0.sundir = (0, 0, 1);
  set_fog_ent(var_0, 1);
}

lerp_spec_color_scale(var_0, var_1, var_2) {
  level notify("lerp_spec_color_scale");
  level endon("lerp_spec_color_scale");
  var_3 = 0.05;
  var_4 = var_0;

  if(maps\_utility::is_gen4()) {
    var_4 = var_1;
  }

  var_5 = getdvarfloat("r_specularcolorscale");

  if(var_5 == var_4) {
    return;
  }
  var_6 = var_4 - var_5;
  var_7 = var_2 / var_3;
  var_8 = var_6 / var_7;

  for(var_9 = 0; var_9 < var_7; var_9++) {
    var_5 = var_5 + var_8;
    setsaveddvar("r_specularcolorscale", var_5);
    wait(var_3);
  }

  setsaveddvar("r_specularcolorscale", var_4);
}