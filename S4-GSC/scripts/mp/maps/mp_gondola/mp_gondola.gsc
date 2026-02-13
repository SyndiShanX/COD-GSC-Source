/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_gondola\mp_gondola.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_gondola\mp_gondola_precache::main();
  scripts\mp\maps\mp_gondola\gen\mp_gondola_art::main();
  scripts\mp\maps\mp_gondola\mp_gondola_fx::main();
  scripts\mp\maps\mp_gondola\mp_gondola_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_gondola");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 0;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level.gameobjectsoutofboundsz = -1000;
  _func_01B1("steady_rumble");
  level.map_uses_gondolas = 1;
  level.gondolas_use_triggers = 0;
  gondolas_init();
}

gondolas_init() {
  var_0 = 0;

  for(;;) {
    var_1 = getEntArray("gondola_" + scripts\engine\utility::_id_EA52(var_0), "targetname");

    if(var_1.size > 0) {
      gondola_setup(var_1, var_0);
    } else {
      break;
    }

    waitframe();
    var_0++;
  }

  scripts\engine\utility::_id_5C1B("flag_gondola_setup_complete");
}

gondola_setup(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4._id_039B == "gondola") {
      var_2 = var_4;
      var_2 setModel("tag_origin");
    }
  }

  foreach(var_4 in var_0) {
    switch (var_4._id_039B) {
      case "gondola_model":
        var_2.gmodel = var_4;
        var_4 linkto(var_2, "tag_origin");
        break;
      case "gondola_truck":
        var_2._id_F6A5 = var_4;
        var_2._id_F6A5._id_E6C9 = var_4.angles;
        var_4 linkto(var_2, "tag_origin");
        break;
      case "gondola_light":
        var_2._id_0278 = var_4;
        var_4 linkto(var_2, "tag_origin");
        break;
      case "gondola_clip":
        var_2._id_39A7 = var_4;
        var_2._id_39A7._id_F9A8 = 1;
        var_4 linkto(var_2, "tag_origin");
        var_4._id_A1C0 = 1;
        break;
      case "gondola_touching_trigger":
        var_2.touching_trigger = var_4;

        if(istrue(level.gondolas_use_triggers)) {
          var_2.touching_trigger _meth_80DB();
          var_2.touching_trigger linkto(var_2);
        } else {
          var_2.touching_trigger delete();
          var_2.touching_trigger = undefined;
        }

        break;
    }
  }

  var_8 = scripts\engine\utility::getstruct("gondola_start_" + scripts\engine\utility::_id_EA52(var_1), "script_noteworthy");
  var_2 thread gondola_run(var_8);
}

gondola_run(var_0) {
  while(!isDefined(game["flags"]["prematch_done"])) {
    waitframe();
  }

  thread gondola_wheel_run();
  thread gondola_destroy_blocking_ents();
  _id_07D1::_id_60C2("prematch_done");

  if(scripts\engine\utility::is_equal(self._id_CE18, "extra_start_delay")) {
    wait 8;
  } else {
    wait 5;
  }

  var_1 = var_0;
  self.move_time = 0;
  var_2 = 1;

  for(;;) {
    var_3 = [];
    var_4 = 0;
    var_5 = var_1;
    var_6 = 1;

    for(;;) {
      var_7 = scripts\engine\utility::getstructarray(var_5.target, "targetname");
      var_8 = undefined;

      foreach(var_10 in var_7) {
        if(issubstr(var_10._id_039B, "gondola_start") || scripts\engine\utility::is_equal(var_10._id_039B, "gondola_goal")) {
          var_8 = var_10;
          var_3 = scripts\engine\utility::array_add(var_3, var_8);
        }
      }

      foreach(var_10 in var_7) {
        if(scripts\engine\utility::is_equal(var_10._id_039B, "truck")) {
          var_8.truck_goal = var_10;
        }
      }

      var_14 = distance2d(var_5.origin, var_8.origin);
      var_8.dist_to_next_point = var_14;
      var_4 = var_4 + var_14;

      if(scripts\engine\utility::is_equal(var_8._id_CE18, "trip")) {
        break;
      }

      var_5 = var_8;
    }

    for(var_15 = 0; var_15 < var_3.size; var_15++) {
      var_3[var_15].moved_to = 0;
      var_16 = var_3[var_15].dist_to_next_point / var_4 * 15;
      self.move_time = var_16;

      if(var_2) {
        thread gondola_audio(self);
        self moveto(var_3[var_15].origin, var_16, var_16 * 0.9);
        var_2 = 0;
      } else
        self moveto(var_3[var_15].origin, var_16);

      self rotateto(var_3[var_15].angles, var_16);

      if(isDefined(var_3[var_15].truck_goal)) {
        self._id_F6A5 unlink();
        var_6 = 0;
        self._id_F6A5 moveto(var_3[var_15].truck_goal.origin, var_16);
        self._id_F6A5 rotateto(var_3[var_15].truck_goal.angles, var_16);
      } else if(!var_6) {
        var_6 = 1;
        self._id_F6A5 linkto(self, "tag_origin");
      }

      wait(var_16);
      self notify("goal_reached");
      var_3[var_15].moved_to = 1;
    }

    var_1.moved_to = 0;

    foreach(var_10 in var_3) {
      var_10.moved_to = 0;
    }

    var_1 = var_8;
    self notify("trip_end");
  }
}

gondola_destroy_blocking_ents() {
  level endon("game_ended");
  var_0 = self;

  if(istrue(level.gondolas_use_triggers)) {
    var_1 = var_0.touching_trigger;
  } else {
    var_1 = var_0._id_39A7;
  }

  var_2 = getdvarint("#x32e5f4cf6680e639", 2);

  for(;;) {
    if(getdvarint("#x395b8f11bdf18482a", 1)) {
      var_3 = level._id_9EE2;

      if(!isDefined(level._id_9EE2)) {
        waitframe();
        continue;
      }

      var_4 = [];

      foreach(var_6 in var_3) {
        if(isDefined(var_6) && !_func_0458(var_6) && isDefined(var_6._id_3A5F) && isDefined(var_6._id_3A5F._id_011B)) {
          var_4[var_4.size] = var_6._id_3A5F;
        }
      }

      if(var_4.size > 0) {
        var_8 = var_1 _meth_813D(var_4);

        foreach(var_10 in var_8) {
          if(isDefined(var_10) && !_func_0458(var_10)) {
            var_10._id_011B notify("gondola_moving_plateform_destroy");
          }
        }
      }
    }

    if(getdvarint("#x3472b0e21e3268e1", 1)) {
      var_12 = scripts\mp\utility\killstreak::_id_689A();
      var_13 = [];

      foreach(var_15 in var_12) {
        if(isDefined(var_15) && !_func_0458(var_15) && isDefined(var_15._id_A1C0)) {
          var_13[var_13.size] = var_15._id_A1C0;
        }
      }

      if(var_13.size > 0) {
        var_17 = var_1 _meth_813D(var_13);

        foreach(var_10 in var_17) {
          if(isDefined(var_10) && !_func_0458(var_10)) {
            var_10._id_3E6D thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
          }
        }
      }
    }

    if(getdvarint("#x384713aa33f7ec368", 1)) {
      var_20 = _id_09EF::_id_6882("all");
      var_21 = [];

      foreach(var_23 in var_20) {
        if(issubstr(var_23._id_1210, "dog")) {
          var_21 = scripts\engine\utility::array_add(var_21, var_23);
        }
      }

      if(var_21.size > 0) {
        var_25 = var_1 _meth_813D(var_21);

        if(var_25.size > 0) {
          foreach(var_10 in var_25) {
            if(isDefined(var_10) && !_func_0458(var_10) && isalive(var_10)) {
              var_10 _id_09EF::_id_8D71();
            }
          }
        }
      }
    }

    for(var_28 = 0; var_28 < var_2; var_28++) {
      waitframe();
    }
  }
}

gondola_audio(var_0) {
  var_0 scripts\engine\utility::_id_B278("emt_gondola_movement_lp", (0, 0, 0));
}

gondola_wheel_run() {
  var_0 = getent("gondola_wheel_large", "targetname");
  var_1 = getent("gondola_wheel_small", "targetname");
  var_2 = 15;
  var_3 = 1;

  for(;;) {
    if(var_3) {
      var_0 rotateyaw(360, var_2, var_2 * 0.5);
      var_1 rotateyaw(360, var_2, var_2 * 0.5);
      var_3 = 0;
    }

    var_0 rotateyaw(360, var_2);
    var_1 rotateyaw(360, var_2);
    wait(var_2);
  }
}