/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_shipbreaker_scriptlights.gsc
***********************************************************/

main() {
  init_lights();
}

init_lights() {
  var_0 = getEntArray("sb_trash_fire_light_scripted", "targetname");
  common_scripts\utility::array_thread(var_0, ::sb_trash_fire_light_scripted);
  var_1 = getEntArray("vista_ship_weld_light1_scripted", "targetname");
  common_scripts\utility::array_thread(var_1, ::vista_ship_weld_light1_scripted);
  var_2 = getEntArray("vista_ship_weld_light2_scripted", "targetname");
  common_scripts\utility::array_thread(var_2, ::vista_ship_weld_light2_scripted);
  var_3 = getEntArray("vista_ship_weld_light3_scripted", "targetname");
  common_scripts\utility::array_thread(var_3, ::vista_ship_weld_light3_scripted);
  var_4 = getEntArray("sb_sparks_lookout_light_scripted", "targetname");
  common_scripts\utility::array_thread(var_4, ::sb_sparks_lookout_light_scripted);
  var_5 = getEntArray("sb_meat_market_flickering", "targetname");
  common_scripts\utility::array_thread(var_5, ::sb_meat_market_flickering);
}

sb_trash_fire_light_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.3, var_0 * 1.2);
    var_3 = randomfloatrange(0.05, 0.1);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

vista_ship_weld_light1_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0, var_0 * 1.8);
    var_3 = randomfloatrange(0.05, 0.1);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

vista_ship_weld_light2_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.01, var_0 * 1.9);
    var_3 = randomfloatrange(0.04, 0.2);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

vista_ship_weld_light3_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0, var_0 * 1.9);
    var_3 = randomfloatrange(0.03, 0.5);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

sb_sparks_lookout_light_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.9, var_0 * 1.0);
    var_3 = randomfloatrange(0.2, 0.5);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

sb_restarteffect() {
  common_scripts\_createfx::restart_fx_looper();
}

_id_1008(var_0) {
  return self._id_1008[var_0];
}

sb_ent_flag_clear(var_0) {
  if(self._id_1008[var_0]) {
    self._id_1008[var_0] = 0;
    self notify(var_0);
  }
}

sb_ent_flag_set(var_0) {
  self._id_1008[var_0] = 1;
  self notify(var_0);
}

sb_ent_flag_init(var_0) {
  if(!isDefined(self._id_1008)) {
    self._id_1008 = [];
    self._id_25E7 = [];
  }

  self._id_1008[var_0] = 0;
}

sb_is_light_entity(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

sb_meat_market_flickering() {
  self endon("stop_dynamic_light_behavior");
  self._id_1646 = 0;
  self._id_1647 = undefined;
  self._id_1648 = undefined;
  self._id_1649 = 0;
  self._id_164A = [];
  self._id_164B = undefined;
  self._id_164C = [];

  if(isDefined(self.script_linkto)) {
    self._id_164B = common_scripts\utility::get_linked_ents();

    foreach(var_1 in self._id_164B) {
      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "on") {
        if(!isDefined(self._id_1647)) {
          self._id_1647[0] = var_1;
        } else {
          self._id_1647[self._id_1647.size] = var_1;

        }
        continue;
      }

      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "off") {
        if(!isDefined(self._id_1648)) {
          self._id_1648[0] = var_1;
        } else {
          self._id_1648[self._id_1648.size] = var_1;

        }
        self._id_164D = var_1;
        continue;
      }

      if(sb_is_light_entity(var_1)) {
        self._id_1649 = 1;
        self._id_164A[self._id_164A.size] = var_1;
      }
    }

    self._id_1646 = 1;
  }

  thread sb_generic_flicker_msg_watcher();
  thread sb_generic_flicker();
}

sb_generic_flicker_msg_watcher() {
  sb_ent_flag_init("flicker_on");

  if(isDefined(self._id_1651) && self._id_1651 != "nil") {
    for(;;) {
      level waittill(self._id_1651);
      sb_ent_flag_set("flicker_on");

      if(isDefined(self._id_1652) && self._id_1652 != "nil") {
        level waittill(self._id_1652);
        sb_ent_flag_clear("flicker_on");
      }
    }
  } else {
    sb_ent_flag_set("flicker_on");
  }
}

sb_generic_flicker_pause() {
  var_0 = self getlightintensity();

  if(!_id_1008("flicker_on")) {
    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_2 in self._id_1647) {
          var_2 hide();

          if(isDefined(var_2._id_164E)) {
            var_2._id_164E common_scripts\utility::pauseeffect();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_5 in self._id_1648) {}
        var_5 show();
      }
    }

    self setlightintensity(0);

    if(self._id_1649) {
      for(var_7 = 0; var_7 < self._id_164A.size; var_7++) {
        self._id_164A[var_7] setlightintensity(0);
      }
    }

    self waittill("flicker_on");
    self setlightintensity(var_0);

    if(self._id_1649) {
      for(var_7 = 0; var_7 < self._id_164A.size; var_7++) {
        self._id_164A[var_7] setlightintensity(var_0);
      }
    }

    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_2 in self._id_1647) {
          var_2 show();

          if(isDefined(var_2._id_164E)) {
            var_2._id_164E sb_restarteffect();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_5 in self._id_1648) {}
        var_5 hide();
      }
    }
  }
}

sb_generic_flicker() {
  self endon("stop_dynamic_light_behavior");
  self endon("death");
  var_0 = 0.2;
  var_1 = 1.0;
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  while(isDefined(self)) {
    sb_generic_flicker_pause();

    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      sb_generic_flicker_pause();
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);

        if(self._id_1646) {
          foreach(var_7 in self._id_1647) {
            var_7 hide();

            if(isDefined(var_7._id_164E)) {
              var_7._id_164E common_scripts\utility::pauseeffect();
            }
          }
        }

        if(isDefined(self._id_1648)) {
          foreach(var_10 in self._id_1648) {}
          var_10 show();
        }
      } else {
        var_4 = var_2;

        if(self._id_1646) {
          if(isDefined(self._id_1647)) {
            foreach(var_7 in self._id_1647) {
              var_7 show();

              if(isDefined(var_7._id_164E)) {
                var_7._id_164E sb_restarteffect();
              }
            }
          }

          if(isDefined(self._id_1648)) {
            foreach(var_10 in self._id_1648) {}
            var_10 hide();
          }
        }
      }

      self setlightintensity(var_4);

      if(self._id_1649) {
        for(var_16 = 0; var_16 < self._id_164A.size; var_16++) {
          self._id_164A[var_16] setlightintensity(var_4);
        }
      }
    }

    sb_generic_flicker_pause();
    self setlightintensity(var_2);

    if(self._id_1649) {
      for(var_16 = 0; var_16 < self._id_164A.size; var_16++) {
        self._id_164A[var_16] setlightintensity(var_2);
      }
    }

    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_7 in self._id_1647) {
          var_7 show();

          if(isDefined(var_7._id_164E)) {
            var_7._id_164E sb_restarteffect();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_10 in self._id_1648) {}
        var_10 hide();
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}