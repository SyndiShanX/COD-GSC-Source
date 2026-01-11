/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dart_scriptlights.gsc
********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  init_lights();
}

init_lights() {
  array_thread(getEntArray("mp_dart_discoball_light", "targetname"), ::mp_dart_discoball_light);

  array_thread(getEntArray("mp_dart_discoball_light_reverse", "targetname"), ::mp_dart_discoball_light_reverse);

  mp_dart_pulsing_light = getEntArray("mp_dart_pulsing_light", "targetname");
  array_thread(mp_dart_pulsing_light, maps\mp\mp_dart_scriptlights::mp_dart_pulsing_light);

  mp_dart_tv_flicker = getEntArray("mp_dart_tv_flicker", "targetname");
  array_thread(mp_dart_tv_flicker, maps\mp\mp_dart_scriptlights::mp_dart_tv_flicker);
}

mp_dart_discoball_light() {
  speed = 3;
  time = 150000;

  self rotatevelocity((0, speed, 0), time);
}

mp_dart_discoball_light_reverse() {
  speed = -3;
  time = 150000;

  self rotatevelocity((0, speed, 0), time);
}

mp_dart_restartEffect() {
  self common_scripts\_createfx::restart_fx_looper();
}

ent_flag(message) {
  AssertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  AssertEx(isDefined(self.ent_flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");

  return self.ent_flag[message];
}

mp_dart_ent_flag_clear(message) {
  AssertEx(isDefined(self), "Attempt to clear a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = false;

  if(self.ent_flag[message]) {
    self.ent_flag[message] = false;
    self notify(message);
  }
}

mp_dart_ent_flag_set(message) {
  AssertEx(isDefined(self), "Attempt to set a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = true;

  self.ent_flag[message] = true;
  self notify(message);
}

mp_dart_ent_flag_init(message) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  if(isDefined(level.first_frame) && level.first_frame == -1) {
    AssertEx(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing message: " + message + " on entity.");
  }

  self.ent_flag[message] = false;

  self.ent_flags_lock[message] = false;
}

mp_dart_is_light_entity(ent) {
  return ent.classname == "light_spot" || ent.classname == "light_omni" || ent.classname == "light";
}

mp_dart_pulsing_light() {
  self endon("stop_dynamic_light_behavior");

  self.linked_models = false;
  self.lit_models = undefined;
  self.unlit_models = undefined;
  self.linked_lights = false;
  self.linked_light_ents = [];
  self.linked_prefab_ents = undefined;
  self.linked_things = [];

  if(isDefined(self.script_LinkTo)) {
    self.linked_prefab_ents = self get_linked_ents();
    assertex(self.linked_prefab_ents.size == 2, "Dynamic light at " + self.origin + " needs to script_LinkTo a prefab that contains both on and off light models");
    foreach(ent in self.linked_prefab_ents) {
      if((isDefined(ent.script_noteworthy)) && (ent.script_noteworthy == "on")) {
        if(!isDefined(self.lit_models)) {
          self.lit_models[0] = ent;
        } else {
          self.lit_models[self.lit_models.size] = ent;
        }
        continue;
      }
      if((isDefined(ent.script_noteworthy)) && (ent.script_noteworthy == "off")) {
        if(!isDefined(self.unlit_models)) {
          self.unlit_models[0] = ent;
        } else {
          self.unlit_models[self.unlit_models.size] = ent;
        }
        self.unlit_model = ent;
        continue;
      }
      if(mp_dart_is_light_entity(ent)) {
        self.linked_lights = true;
        self.linked_light_ents[self.linked_light_ents.size] = ent;
      }
    }
    assertex(isDefined(self.lit_models), "Dynamic light at " + self.origin + " needs to script_LinkTo a prefab contains a script_model light with script_noteworthy of 'on' ");
    assertex(isDefined(self.unlit_models), "Dynamic light at " + self.origin + " needs to script_LinkTo a prefab contains a script_model light with script_noteworthy of 'on' ");
    self.linked_models = true;
  }

  self thread mp_dart_generic_flicker_msg_watcher();
  self thread mp_dart_generic_flicker();
}

mp_dart_generic_flicker_msg_watcher() {
  self mp_dart_ent_flag_init("flicker_on");
  if(isDefined(self.script_light_startnotify) && self.script_light_startnotify != "nil") {
    for(;;) {
      level waittill(self.script_light_startnotify);
      self mp_dart_ent_flag_set("flicker_on");
      if(isDefined(self.script_light_stopnotify) && self.script_light_stopnotify != "nil") {
        level waittill(self.script_light_stopnotify);
        self mp_dart_ent_flag_clear("flicker_on");
      }
    }

  } else self mp_dart_ent_flag_set("flicker_on");
}

mp_dart_generic_flicker_pause() {
  f_on = self getLightIntensity();
  if(!self ent_flag("flicker_on")) {
    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(lit_model in self.lit_models) {
          if(isDefined(lit_model.effect)) {
            lit_model.effect Delete();
            lit_model.effect = undefined;
          }
          lit_model hide();
        }
      }
      if(isDefined(self.unlit_models)) {
        foreach(unlit_model in self.unlit_models) {
          unlit_model show();
        }
      }
    }

    self setLightIntensity(0);
    if(self.linked_lights) {
      for(i = 0; i < self.linked_light_ents.size; i++) {
        self.linked_light_ents[i] setLightIntensity(0);
      }
    }

    self waittill("flicker_on");

    self setLightIntensity(f_on);
    if(self.linked_lights) {
      for(i = 0; i < self.linked_light_ents.size; i++) {
        self.linked_light_ents[i] setLightIntensity(f_on);
      }
    }

    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(lit_model in self.lit_models) {
          lit_model show();

          if(!isDefined(lit_model.effect)) {
            lit_model.effect = SpawnFx(level._effect["vfx_bulb_single"], lit_model.origin);
            TriggerFX(lit_model.effect);
            waitframe();
          }
        }
      }
      if(isDefined(self.unlit_models)) {
        foreach(unlit_model in self.unlit_models) {
          unlit_model hide();
        }
      }
    }

  }
}

mp_dart_generic_flicker() {
  self endon("stop_dynamic_light_behavior");
  self endon("death");

  min_flickerless_time = .2;
  max_flickerless_time = 1.0;

  on = self getLightIntensity();
  off = 0;
  curr = on;
  num = 0;

  while(isDefined(self)) {
    self mp_dart_generic_flicker_pause();

    num = randomintrange(1, 10);
    while(num) {
      self mp_dart_generic_flicker_pause();

      wait(randomfloatrange(.05, .1));
      if(curr > .2) {
        curr = randomfloatrange(0, .3);
        if(self.linked_models) {
          foreach(lit_model in self.lit_models) {
            if(isDefined(lit_model.effect)) {
              lit_model.effect Delete();
              lit_model.effect = undefined;
              waitframe();
            }
            lit_model hide();
          }
        }
        if(isDefined(self.unlit_models)) {
          foreach(unlit_model in self.unlit_models) {
            unlit_model show();
          }
        }
      } else {
        curr = on;
        if(self.linked_models) {
          if(isDefined(self.lit_models)) {
            foreach(lit_model in self.lit_models) {
              lit_model show();
              if(!isDefined(lit_model.effect)) {
                lit_model.effect = SpawnFx(level._effect["vfx_bulb_single"], lit_model.origin);
                TriggerFX(lit_model.effect);
                waitframe();
              }
            }
          }
          if(isDefined(self.unlit_models)) {
            foreach(unlit_model in self.unlit_models) {
              unlit_model hide();

            }
          }
        }
      }

      self setLightIntensity(curr);
      if(self.linked_lights) {
        for(i = 0; i < self.linked_light_ents.size; i++) {
          self.linked_light_ents[i] setLightIntensity(curr);
        }
      }
      num--;
    }

    self mp_dart_generic_flicker_pause();

    self setLightIntensity(on);
    if(self.linked_lights) {
      for(i = 0; i < self.linked_light_ents.size; i++) {
        self.linked_light_ents[i] setLightIntensity(on);
      }
    }
    if(self.linked_models) {
      if(isDefined(self.lit_models)) {
        foreach(lit_model in self.lit_models) {
          lit_model show();
          if(!isDefined(lit_model.effect)) {
            lit_model.effect = SpawnFx(level._effect["vfx_bulb_single"], lit_model.origin);
            TriggerFX(lit_model.effect);
            waitframe();
          }
        }
      }
      if(isDefined(self.unlit_models)) {
        foreach(unlit_model in self.unlit_models) {
          unlit_model hide();
        }
      }
    }
    wait(randomfloatrange(min_flickerless_time, max_flickerless_time));
  }
}

mp_dart_tv_flicker() {
  full = self getLightIntensity();

  old_intensity = full;

  for(;;) {
    intensity = randomfloatrange(full * 0.3, full * 0.9);
    timer = randomfloatrange(0.05, 0.1);
    timer *= 15;

    for(i = 0; i < timer; i++) {
      new_intensity = intensity * (i / timer) + old_intensity * ((timer - i) / timer);

      self setLightIntensity(new_intensity);
      wait(0.05);
    }

    old_intensity = intensity;
  }
}