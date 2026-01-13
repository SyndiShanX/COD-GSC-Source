/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\gen\cp_rave_art.gsc
*******************************************************/

main() {
  level.tweakfile = 1;
  thread light_control_flags_init();
  thread strobelight_init();
  thread fire_light_flicker_init();
  thread light_fixture_flicker_init();
}

light_control_flags_init() {
  scripts\engine\utility::flag_init("light_fixture_on");
  scripts\engine\utility::flag_init("light_fixture_off");
  scripts\engine\utility::flag_init("strobe_red");
  scripts\engine\utility::flag_init("strobe_green");
  scripts\engine\utility::flag_init("strobe_blue");
}

strobelight_init() {
  var_0 = getEntArray("strobelight_r", "targetname");
  var_1 = getEntArray("strobelight_g", "targetname");
  var_2 = getEntArray("strobelight_b", "targetname");
  thread strobe_light_rand_generator();
  scripts\engine\utility::array_thread(var_0, ::strobelight_setup);
  scripts\engine\utility::array_thread(var_1, ::strobelight_setup);
  scripts\engine\utility::array_thread(var_2, ::strobelight_setup);
}

strobelight_setup() {
  var_0 = parse_noteworthy_values();
  self.light_targetname = self.var_336;
  self.light_position_show = self.origin;
  self.light_position_hide = self.origin - (0, 0, 1024);
  for(;;) {
    if(self.light_targetname == "strobelight_r" && scripts\engine\utility::flag("strobe_red")) {
      self.origin = self.light_position_show;
    }

    if(self.light_targetname == "strobelight_r" && !scripts\engine\utility::flag("strobe_red")) {
      self.origin = self.light_position_hide;
    }

    if(self.light_targetname == "strobelight_g" && scripts\engine\utility::flag("strobe_green")) {
      self.origin = self.light_position_show;
    }

    if(self.light_targetname == "strobelight_g" && !scripts\engine\utility::flag("strobe_green")) {
      self.origin = self.light_position_hide;
    }

    if(self.light_targetname == "strobelight_b" && scripts\engine\utility::flag("strobe_blue")) {
      self.origin = self.light_position_show;
    }

    if(self.light_targetname == "strobelight_b" && !scripts\engine\utility::flag("strobe_blue")) {
      self.origin = self.light_position_hide;
    }

    scripts\engine\utility::waitframe();
  }
}

strobe_light_rand_generator() {
  for(;;) {
    var_0 = randomintrange(0, 150);
    if(var_0 >= 50 && var_0 <= 100) {
      scripts\engine\utility::flag_set("strobe_red");
      scripts\engine\utility::flag_clear("strobe_green");
      scripts\engine\utility::flag_clear("strobe_blue");
    } else if(var_0 >= 100) {
      scripts\engine\utility::flag_clear("strobe_red");
      scripts\engine\utility::flag_set("strobe_green");
      scripts\engine\utility::flag_clear("strobe_blue");
    } else {
      scripts\engine\utility::flag_clear("strobe_red");
      scripts\engine\utility::flag_clear("strobe_green");
      scripts\engine\utility::flag_set("strobe_blue");
    }

    wait(0.5);
  }
}

fire_light_flicker_init() {
  var_0 = getEntArray("fire_light_flicker", "targetname");
  scripts\engine\utility::array_thread(var_0, ::fire_light_flicker_setup);
}

fire_light_flicker_setup() {
  var_0 = parse_noteworthy_values();
  self.frequency = 100;
  self.max_intensity = 750;
  self.min_intensity = 5;
  if(isDefined(var_0["frequency"])) {
    self.frequency = float(var_0["frequency"]);
  }

  if(isDefined(var_0["max_intensity"])) {
    self.max_intensity = float(var_0["max_intensity"]);
  }

  if(isDefined(var_0["min_intensity"])) {
    self.min_intensity = float(var_0["min_intensity"]);
  }

  thread fire_light_flicker();
}

fire_light_flicker() {
  for(;;) {
    var_0 = randomfloatrange(self.min_intensity, self.max_intensity);
    self setlightintensity(var_0);
    wait(1 / self.frequency);
  }
}

light_fixture_flicker_init() {
  thread light_fixture_flicker_rand_generator();
  thread light_fixture_flicker_setup();
}

light_fixture_flicker_setup() {
  var_0 = parse_noteworthy_values();
  var_1 = getEntArray("light_fixture_flicker", "targetname");
  var_2 = getEntArray("light_fixture_flicker_off", "targetname");
  var_3 = getEntArray("light_fixture_flicker_on", "targetname");
  var_4 = 150;
  var_5 = 5;
  for(;;) {
    if(scripts\engine\utility::flag("light_fixture_on")) {
      foreach(var_7 in var_3) {
        var_7 show();
      }

      foreach(var_0A in var_2) {
        var_0A hide();
      }

      foreach(var_0D in var_1) {
        var_0D setlightintensity(var_4);
      }
    } else if(scripts\engine\utility::flag("light_fixture_off")) {
      foreach(var_7 in var_3) {
        var_7 hide();
      }

      foreach(var_0A in var_2) {
        var_0A show();
      }

      foreach(var_0D in var_1) {
        var_0D setlightintensity(var_5);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

light_fixture_flicker_rand_generator() {
  for(;;) {
    var_0 = randomintrange(0, 500);
    if(var_0 >= 250) {
      scripts\engine\utility::flag_clear("light_fixture_off");
      scripts\engine\utility::flag_set("light_fixture_on");
    } else {
      scripts\engine\utility::flag_clear("light_fixture_on");
      scripts\engine\utility::flag_set("light_fixture_off");
    }

    scripts\engine\utility::waitframe();
  }
}

parse_noteworthy_values() {
  var_0 = [];
  if(isDefined(self.script_noteworthy)) {
    var_1 = strtok(self.script_noteworthy, " ");
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, ":");
      var_0[var_4[0]] = var_4[1];
    }
  }

  return var_0;
}