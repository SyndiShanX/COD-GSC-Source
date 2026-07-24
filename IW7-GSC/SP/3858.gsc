/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3858.gsc
**************************************/

_id_F9EE(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = "main_objective";
    var_5 = spawnStruct();
    var_6 = undefined;
    var_7 = 0;
    var_8 = 0;

    if(isDefined(var_3.spawnflags)) {
      if(var_3.spawnflags & 1) {
        var_6 = 1;
        var_7 = 1;
      }

      if(var_3.spawnflags & 2) {
        var_6 = 2;
        var_7 = 1;
      }

      if(var_3.spawnflags & 4) {
        var_6 = 3;
        var_7 = 1;
      }

      if(var_3.spawnflags & 8) {
        var_6 = 4;
        var_7 = 1;
      }

      if(var_3.spawnflags & 16) {
        var_6 = 5;
        var_7 = 1;
      }

      if(var_3.spawnflags & 32) {
        var_6 = 6;
        var_7 = 1;
      }

      if(var_3.spawnflags & 64) {
        var_6 = 7;
        var_7 = 1;
      }

      if(var_3.spawnflags & 128)
        var_8 = 1;
    }

    var_5._id_C2A5 = var_3.script_noteworthy;
    var_5._id_113AC = var_4;
    var_5.icon = "icon_ks_air_super";
    var_5.origin = var_3.origin;
    var_5._id_113A8 = level._id_FD5B.size;
    var_5.struct = var_3;
    var_5._id_111A3 = var_6;
    var_5._id_4469 = 0;

    if(var_8)
      var_5._id_BDBD = 1;

    level._id_FD5B[level._id_FD5B.size] = var_5;
    var_1[var_1.size] = var_5;
  }

  if(var_1.size > 0) {
    foreach(var_11 in var_1) {
      if(!isDefined(var_11._id_C2A5)) {
        break;
      }

      if(isDefined(level._id_FD50[var_11._id_C2A5])) {
        level._id_FD50[var_11._id_C2A5] = scripts\engine\utility::array_add(level._id_FD50[var_11._id_C2A5], var_11);
        continue;
      }

      level._id_FD50[var_11._id_C2A5] = [var_11];
    }
  }

  thread _id_FD28();
}

_id_FD02(var_0, var_1, var_2) {
  var_3 = level._id_FD50[var_0];
  var_4 = var_3[0]._id_C2A5;

  if(!isDefined(var_1))
    var_1 = "Objective";

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_7 = var_6._id_111A3;

    if(var_3.size == 1) {
      objective_add(scripts\sp\utility::_id_C264(var_4), "current", var_1, var_6.origin);
      continue;
    }

    if(isDefined(var_7)) {
      if(var_5 == 0)
        objective_add(scripts\sp\utility::_id_C264(var_4), "current", var_1, (0, 0, 0));

      objective_additionalposition(scripts\sp\utility::_id_C264(var_4), var_7, var_6.origin);
      var_6 thread _id_13F4();
      continue;
    }

    if(isDefined(var_6._id_BDBD)) {
      if(var_5 == 0)
        objective_add(scripts\sp\utility::_id_C264(var_4), "current", var_1, (0, 0, 0));

      objective_additionalposition(scripts\sp\utility::_id_C264(var_4), var_5, var_6.origin);
    }
  }

  if(isDefined(var_2))
    objective_setpointertextoverride(scripts\sp\utility::_id_C264(var_4), var_2);
}

_id_13F3(var_0) {
  var_1 = var_0[0]._id_C2A5;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_1));
  level._id_FD50[scripts\sp\utility::_id_C264(var_1)] = undefined;
}

_id_13F4() {
  self.struct waittill("objective_complete");
  objective_additionalposition(scripts\sp\utility::_id_C264(self._id_C2A5), self._id_111A3, (0, 0, 0));
  level notify("sub_objective_complete");
  self._id_4469 = 1;
  var_0 = 1;

  foreach(var_2 in level._id_FD50[self._id_C2A5]) {
    if(var_2._id_4469 == 0)
      var_0 = 0;
  }

  if(var_0)
    _id_FD00(self._id_C2A5);
}

_id_FD01(var_0) {
  objective_state(scripts\sp\utility::_id_C264(var_0), "invisible");
}

_id_FD03(var_0) {
  objective_state(scripts\sp\utility::_id_C264(var_0), "current");
}

_id_FD00(var_0, var_1) {
  var_2 = level._id_FD50[var_0];
  var_3 = var_2[0]._id_C2A5;

  foreach(var_5 in var_2) {
    if(var_2.size == 1) {
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_3));
      level notify(var_0 + " complete");
      level._id_FD50[var_3] = undefined;
      continue;
    }

    if(isDefined(var_5._id_111A3) && !isDefined(var_1)) {
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_3));
      level notify(var_0 + " complete");
      level._id_FD50[var_3] = undefined;
      break;
    } else {
      if(isDefined(var_5._id_111A3) && isDefined(var_1) && var_5._id_111A3 == var_1) {
        var_5.struct notify("objective_complete");
        continue;
      }

      if(isDefined(var_5._id_BDBD)) {
        scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_3));
        level notify(var_0 + " complete");
        level._id_FD50[var_3] = undefined;
        break;
      }
    }
  }
}

_id_FD04(var_0) {
  if(!isDefined(level._id_FD50[var_0])) {
    return;
  }
  level waittill(var_0 + " complete");
}

_id_FD28() {
  level.player endon("death");
  setsaveddvar("objectiveGlobalFadeState", 1);
  level._id_4548 = [];
  level._id_4548["zero_g"] = "hud_objective_life_support";
  level._id_4548["proximity_hack"] = "hud_objective_unknown";
  level._id_4548["proximity_hack_cameras"] = "hud_objective_security_camera";
  level._id_4548["ship_log"] = "hud_objective_ship_log";
  level._id_4548["rss"] = "hud_objective_robot_rack";
  level._id_4540 = 30;

  for(;;) {
    level.player waittill("show_objectives");
    _id_FD16();
  }
}

_id_FD0F() {
  var_0 = getdvarfloat("objectiveArrowWidth");
  var_1 = getdvarfloat("objectiveArrowHeight");
  var_2 = 5;
  var_3 = 1.0;
  var_4 = 0.0;
  var_5 = 4.0;

  while(var_4 < var_3) {
    var_6 = var_2 * (1.0 - pow(var_4 / var_3, var_5));
    setsaveddvar("objectiveArrowWidth", var_0 * var_6);
    setsaveddvar("objectiveArrowHeight", var_1 * var_6);
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  setsaveddvar("objectiveArrowWidth", var_0);
  setsaveddvar("objectiveArrowHeight", var_1);
}

_id_FCD8() {
  var_0 = 30;
  var_1 = pow(1575, 2);
  var_2 = 3;
  var_3 = [];

  foreach(var_9, var_5 in level._id_4548) {
    if(isDefined(level._id_E992[var_9])) {
      foreach(var_7 in level._id_E992[var_9]._id_454F) {
        var_7._id_C26A = undefined;

        if(distancesquared(level.player.origin, var_7.origin) <= var_1 && !scripts\engine\utility::is_true(var_7._id_13081)) {
          var_3[var_3.size] = var_7;
          var_7._id_C29D = var_9;
        }
      }
    }
  }

  var_10 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
  level._id_454A = [];

  foreach(var_12 in var_10) {
    if((!var_12 scripts\sp\utility::_id_65DF("rss_deactivated") || !var_12 scripts\sp\utility::_id_65DB("rss_deactivated")) && (!var_12 scripts\sp\utility::_id_65DF("rss_activated") || !var_12 scripts\sp\utility::_id_65DB("rss_activated"))) {
      if(distancesquared(level.player.origin, var_12.origin) <= var_1) {
        level._id_454A[level._id_454A.size] = var_12 scripts\engine\utility::spawn_tag_origin();
        var_3[var_3.size] = level._id_454A[level._id_454A.size - 1];
        level._id_454A[level._id_454A.size - 1]._id_C29D = "rss";
      }
    }
  }

  if(var_3.size > 0) {
    var_3 = sortbydistance(var_3, level.player.origin);
    level._id_454B = [];

    for(var_14 = 0; var_14 < var_2 && var_14 < var_3.size; var_14++) {
      level._id_454B[var_14] = var_3[var_14];
      var_15 = (0, 0, 0);

      if(var_3[var_14]._id_C29D == "rss")
        var_15 = (0, 0, -10) + anglestoright(var_3[var_14].angles) * 15;
      else
        var_15 = (0, 0, 40) + anglesToForward(var_3[var_14].angles) * 25;

      objective_additionalentity(var_0, 0, var_3[var_14], var_15);
      objective_icon(var_0, level._id_4548[var_3[var_14]._id_C29D]);
      objective_state(var_0, "current");
      _func_2E4(var_0, 0.5);
      _func_2E5(var_0, 1);
      _func_2E6(var_0, 0);
      var_3[var_14]._id_C26A = var_0;
      var_0--;
    }
  }

  level._id_4549 = var_0;
}

_id_FD0D(var_0) {
  if(isDefined(var_0._id_C26A)) {
    objective_delete(var_0._id_C26A);
    var_0._id_C26A = undefined;
  }
}

_id_FD0E() {
  for(var_0 = 30; var_0 > level._id_4549; var_0--)
    objective_delete(var_0);

  foreach(var_2 in level._id_454A)
  var_2 delete();

  level._id_454A = undefined;
}

_id_FD16() {
  level notify("ship_assault_objective_system_show");
  level endon("ship_assault_objective_system_show");
  level._id_C2AB = getDvar("objectiveColor");
  setsaveddvar("objectiveGlobalFadeState", 2);
  setsaveddvar("objectiveColor", "0.98 0.8 0 1");
  _id_0F16::_id_F603("sa_ondemand", 0.2);
  level.player playSound("sa_ui_objectives_open_01");
  _id_FCD8();
  thread _id_FD0F();
  wait 1.5;
  var_0 = level.player.origin;

  while(var_0 == level.player.origin)
    wait 0.05;

  _id_FCF6();
}

_id_FCF6() {
  _id_0F16::_id_E0A8("sa_ondemand", 0.5);
  level.player playSound("sa_ui_objectives_close_01");
  wait 2.0;
  setsaveddvar("objectiveGlobalFadeState", 3);
  wait 0.5;
  setsaveddvar("objectiveColor", level._id_C2AB);
  _id_FD0E();
}