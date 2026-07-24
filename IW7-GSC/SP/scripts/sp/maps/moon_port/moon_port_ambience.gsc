/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_ambience.gsc
************************************************************/

_id_F8B8() {
  scripts\engine\utility::flag_init("ambient_cap_ships_start_pathing");
  scripts\engine\utility::flag_init("ambient_battle_destroyer_1_end_path");
  scripts\engine\utility::flag_init("ambient_battle_destroyer_2_end_path");
  setdvarifuninitialized("debug_moon_ships", 0);
  level._id_4B3C = "";
  var_0 = getEntArray("ambient_ships_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_1DED();

  thread _id_1D7A();
}

_id_1DED() {
  level endon("stop_ambient_air_battle");

  for(;;) {
    self waittill("trigger");

    if(level._id_4B3C == self.script_noteworthy) {
      wait 0.1;
      continue;
    }

    if(!isDefined(self.script_parameters) || self.script_parameters != "oneoff")
      level._id_4B3C = self.script_noteworthy;

    switch (self.script_noteworthy) {
      case "ambient_ships_intro":
        thread _id_1DC7("ambient_jackals_intro", 0, 215, 280, 2.0, 5.0, 1);
        var_0 = scripts\engine\utility::getStruct("airlock_door_interact", "targetname");
        var_0 waittill("trigger");
        level notify("stop_ambient_ships");
        return;
      case "ambient_ships_tutorials":
        thread _id_1DC7("ambient_jackals_tutorials", 0, 250, 300, 1.5, 4, 1);
        break;
      case "ambient_ships_concourse_a":
        thread _id_1DC7("ambient_jackals_concourse_a", 0, 250, 300, 1.5, 4, 1);
        break;
      case "ambient_ships_concourse_b":
        thread _id_1DC7("ambient_jackals_concourse_b", 0, 250, 300, 1.2, 3.5, 1);
        _id_F935("tigris", "ambient_tigris_fly_to_battle");
        level._id_1DEB["tigris"] scripts\sp\utility::_id_65E0("tigris_start_firing");
        break;
      case "ambient_ships_fob":
        break;
      case "ambient_ships_harass":
        break;
      default:
        break;
    }

    wait 0.1;
  }
}

_id_1D7A() {
  if(!isDefined(level._id_10CDA)) {
    return;
  }
  switch (level._id_10CDA) {
    case "concourse start":
      var_0 = getEntArray("ambient_ships_tutorials", "script_noteworthy");
      var_0[0] notify("trigger");
      break;
    case "concourse second intro":
    case "concourse combat":
      var_0 = getEntArray("ambient_ships_concourse_a", "script_noteworthy");
      var_0[0] notify("trigger");
      break;
    case "concourse curved":
      var_0 = getEntArray("ambient_ships_concourse_b", "script_noteworthy");
      var_0[0] notify("trigger");
      break;
    case "fob":
    case "fob halls":
      var_0 = getEntArray("ambient_ships_fob", "script_noteworthy");
      var_0[0] notify("trigger");
      break;
    default:
      break;
  }
}

_id_1DC7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level notify("stop_ambient_ships");
  level endon("stop_ambient_ships");
}

_id_1DC8(var_0) {
  var_1 = scripts\sp\utility::_id_8201(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\vehicle::_id_1080B();
    var_4._id_55A4 = 1;
  }
}

_id_1DC9(var_0) {
  var_1 = scripts\sp\utility::_id_8200(var_0, "targetname");
  var_2 = var_1 scripts\sp\vehicle::_id_1080B();
  var_2._id_55A4 = 1;
  var_2 scripts\sp\utility::_id_65E0("death");
}

#using_animtree("generic_human");

_id_B03C(var_0, var_1, var_2) {
  level endon("stop_fake_actors");

  if(!isDefined(var_1))
    var_1 = 5;

  if(!isDefined(var_2))
    var_2 = 12;

  for(;;) {
    var_3 = getEntArray(var_0, "targetname");

    foreach(var_5 in var_3) {
      var_6 = var_5 scripts\sp\utility::_id_10619(1);
      var_6._id_AFED = 32;
      var_6._id_B04E = 0.2;
      var_6 scripts\sp\fakeactor::_id_F584(%run_lowready_f_relative);
    }

    wait(randomfloatrange(var_1, var_2));
  }
}

_id_1DF9() {
  scripts\sp\utility::_id_65E3("tigris_start_firing");
  wait 5.0;
  wait 3.0;
}

_id_F935(var_0, var_1) {
  if(!isDefined(level._id_1DEB))
    level._id_1DEB = [];

  if(isDefined(level._id_1DEB[var_0]))
    _id_DFF4(var_0);

  wait 0.1;
  var_2 = scripts\sp\vehicle::_id_1080D(var_1);
  var_2 notify("kill_rumble_forever");
  var_2._id_934D = "turret";
  var_2._id_4D1E = spawnStruct();
  var_2._id_4D1E._id_DCCA = 50000;
  var_2._id_4D1E._id_B428 = 0;
  var_2._id_4D1E._id_B73D = 0;
  var_2._id_4D1E._id_B465 = 0;
  var_2._id_4D1E._id_B753 = 0;
  var_2._id_4D1E._id_1060D = 200;
  var_2._id_4D1E._id_DCCC = 9000;
  var_2._id_4D1E._id_DCCB = 1500;
  var_2._id_4D1E._id_32B2 = 200;
  var_2._id_4D1E._id_32B9 = 1500;
  var_2._id_FB6B = "";
  level._id_1DEB[var_0] = var_2;
  return var_2;
}

_id_DFF4(var_0) {
  if(!isDefined(level._id_1DEB) || !isDefined(level._id_1DEB[var_0])) {
    return;
  }
  level._id_1DEB[var_0]._id_4D1E = undefined;
  level._id_1DEB[var_0] delete();
  level._id_1DEB[var_0] = undefined;
}

_id_1DEC() {
  foreach(var_2, var_1 in level._id_1DEB)
  _id_DFF4(var_2);
}

_id_FD66(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  var_3 = (0, 90, 0);
  var_4 = (0, 270, 0);
  var_5 = 3;
  var_6 = 7;
  var_7 = 12;
  var_8 = 1;
  var_9 = [];
  var_9[0] = (9276, 1678, -1187);
  var_9[1] = (8236, 1678, -1187);
  var_9[2] = (5900, 3406, 777);
  var_9[3] = (5284, 3406, 777);
  var_9[4] = (4692, 3406, 777);
  var_9[5] = (1216, 3406, 777);
  var_9[6] = (1216, 3406, 777);
  var_9[7] = (-616, 3208, -1187);
  var_9[8] = (-1656, 3184, -1187);
  var_9[9] = (-1656, 3184, -1187);
  var_10 = [];
  var_10[0] = (9276, -1678, -1187);
  var_10[1] = (8236, -1678, -1187);
  var_10[2] = (5900, -3406, 777);
  var_10[3] = (5284, -3406, 777);
  var_10[4] = (4692, -3406, 777);
  var_10[5] = (1216, -3406, 777);
  var_10[6] = (1216, -3406, 777);
  var_10[7] = (-616, -3208, -1187);
  var_10[8] = (-1656, -3184, -1187);
  var_10[9] = (-1656, -3184, -1187);
  var_11 = var_9;
  var_12 = var_3;

  if(var_0 == "right") {
    var_11 = var_10;
    var_12 = var_4;
  }

  for(;;) {
    var_13 = var_5;

    while(var_13 > 0) {
      foreach(var_15 in var_11) {
        if(var_0 == "right")
          var_15[1] = var_15[1] * -1;

        var_16 = transformmove(self.origin, self.angles, (0, 0, 0), (0, 0, 0), var_15, var_12);
        var_17 = var_16["origin"];
        var_18 = var_1.origin - self.origin;
        var_18 = vectorNormalize(var_18);
        var_19 = vectortoangles(var_18);
        var_20 = 200;
        var_15 = (randomfloatrange(-1 * var_20, var_20), randomfloatrange(-1 * var_20, var_20), randomfloatrange(-1 * var_20, var_20));
        var_21 = 10000;
        var_22 = var_17 + var_21 * anglesToForward(var_19) + var_15;
        var_23 = vectortoangles(var_22 - var_17);

        if(scripts\engine\utility::cointoss())
          wait(randomfloatrange(0.05, 0.08));
      }

      var_13--;
      wait(randomfloatrange(0.9, 1.2));
    }

    if(self.script_team == "allies" && (randomint(10) <= 7 || var_8)) {
      thread _id_6D0F(var_0, var_12, var_1, var_2);
      var_8 = 0;
    } else if(randomint(10) <= 2)
      thread _id_6D0F(var_0, var_12, var_1, var_2);

    wait(randomfloatrange(var_6, var_7));
  }
}

_id_6D0F(var_0, var_1, var_2, var_3) {
  var_4 = 6;
  var_5[0] = (9276, 1678, -1187);
  var_5[1] = (8236, 1678, -1187);
  var_5[2] = (5900, 3406, 777);
  var_5[3] = (5284, 3406, 777);
  var_5[4] = (4692, 3406, 777);
  var_5[5] = (1216, 3406, 777);
  var_5[6] = (1216, 3406, 777);
  var_5[7] = (-616, 3208, -1187);
  var_5[8] = (-1656, 3184, -1187);
  var_5[9] = (-1656, 3184, -1187);
  var_6 = 0;

  if(isDefined(var_3) && scripts\engine\utility::cointoss() && scripts\engine\utility::cointoss())
    var_6 = 1;

  var_7 = var_2;

  if(isDefined(var_3) && scripts\engine\utility::cointoss())
    var_7 = var_3;

  while(var_4 > 0) {
    if(var_6 == 1) {
      var_7 = var_2;

      if(scripts\engine\utility::cointoss())
        var_7 = var_3;
    }

    var_8 = var_5[2];

    if(var_4 == 4 || var_4 == 3)
      var_8 = var_5[4];
    else if(var_4 == 2 || var_4 == 1)
      var_8 = var_5[5];

    var_9 = transformmove(self.origin, self.angles, (0, 0, 0), (0, 0, 0), var_8, var_1);
    var_10 = var_9["origin"];
    var_11 = var_7.origin - self.origin;
    var_11 = vectorNormalize(var_11);
    var_12 = vectortoangles(var_11);
    var_13 = scripts\engine\utility::spawn_tag_origin();
    var_13.origin = var_10;
    var_13.angles = var_12;
    var_14 = scripts\engine\utility::spawn_tag_origin();
    var_14._id_5F27 = 1;
    var_9 = transformmove(var_7.origin, var_7.angles, (0, 0, 0), (0, 0, 0), var_5[randomint(9)], var_12);
    var_14.origin = var_9["origin"];
    var_13 thread _id_0BDD::_id_A274(var_14, 1, self, undefined, undefined, (0, 0, 0));
    var_4--;
    wait(randomfloatrange(0.05, 0.18));
  }
}

_id_C959(var_0) {
  scripts\engine\utility::flag_wait(var_0);
}