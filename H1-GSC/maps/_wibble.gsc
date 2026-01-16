/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_wibble.gsc
********************************/

set_cloth_wibble(var_0) {
  setshaderconstant(0, "x", 1.0);
  setshaderconstant(0, "y", var_0);
}

setup_wibble_triggers(var_0, var_1, var_2, var_3, var_4) {
  if(var_3)
    set_cloth_wibble(1.0);

  level.current_wibble_location = var_2;

  if(var_4 && var_2 == "exterior" && !var_3)
    set_cloth_wibble(0.5);

  var_5 = getentarray("trigger_wibble", "targetname");
  common_scripts\utility::array_thread(var_5, ::wibble_trigger_think, var_0, var_1, var_4);
  thread setup_wibble_helis(var_0, var_1);
}

setup_wibble_helis(var_0, var_1) {
  if(isdefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  if(var_0) {
    wait 2;
    level endon("wibble_heli_check_stop");
    var_2 = 1690000;

    for (;;) {
      var_3 = 0;

      if(isdefined(level.helis)) {
        level.helis = common_scripts\utility::array_removeundefined(level.helis);

        foreach(var_5 in level.helis) {
          var_6 = distancesquared(level.player.origin, var_5.origin);

          if(var_6 <= var_2) {
            var_3 = 0.5;
            break;
          }
        }
      }

      set_cloth_wibble(var_3);
      wait 0.5;
    }
  } else
    set_cloth_wibble(0.5);
}

wibble_trigger_think(var_0, var_1, var_2) {
  for (;;) {
    self waittill("trigger");

    if(self.script_noteworthy != level.current_wibble_location) {
      switch (self.script_noteworthy) {
        case "exterior":
          if(var_2) {
            set_cloth_wibble(0.5);
            break;
          } else {
            thread setup_wibble_helis(var_0, var_1);
            break;
          }
        case "interior":
          level notify("wibble_heli_check_stop");
          set_cloth_wibble(0.0);
          break;
      }

      level.current_wibble_location = self.script_noteworthy;
    }
  }
}

wibble_add_heli_to_track(var_0) {
  if(!isdefined(level.helis))
    level.helis = [];

  level.helis = common_scripts\utility::array_add(level.helis, var_0);
}