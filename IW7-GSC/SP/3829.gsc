/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3829.gsc
**************************************/

_id_FDF4(var_0) {
  if(!isDefined(level._id_FD6E._id_ECDC))
    level._id_FD6E._id_ECDC = [];

  switch (var_0) {
    case "shipcrib_moon":
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      var_1 = ["bridge_screen_default_yellow", "bridge_screen_default_08_yellow", "bridge_screen_default_135_yellow", "bridge_screen_default_yellow_lp", "bridge_screen_default_08_yellow_lp", "bridge_screen_default_135_yellow_lp", "bridge_screen_opsmap_08_yellow", "bridge_screen_opsmap_08_yellow_lp", "bridge_screen_semitrans_small_yellow", "bridge_screen_semitrans_small_yellow_lp", "bridge_screen_semitrans_large_yellow", "bridge_screen_semitrans_large_yellow_lp"];
      break;
    case "shipcrib_gravity":
    case "shipcrib_epilogue":
      var_1 = ["bridge_screen_briefing_monitor_01_blue", "bridge_screen_default_blue", "bridge_screen_default_08_blue", "bridge_screen_default_135_blue", "bridge_screen_default_blue_lp", "bridge_screen_default_08_blue_lp", "bridge_screen_default_135_blue_lp", "bridge_screen_opsmap_08_blue", "bridge_screen_opsmap_08_blue_lp", "bridge_screen_semitrans_small_blue", "bridge_screen_semitrans_small_blue_lp", "bridge_screen_semitrans_large_blue", "bridge_screen_semitrans_large_blue_lp"];
      break;
    default:
      var_1 = ["shipcrib_screen_heavy_duty_monitor", "bridge_screen_admiral", "bridge_screen_admiral_cic", "bridge_screen_cic", "bridge_screen_briefing_monitor_01", "bridge_screen_briefing_monitor_01_red", "bridge_screen_briefing_monitor_01_int_01", "bridge_screen_default", "bridge_screen_default_lp", "bridge_screen_default_red", "bridge_screen_default_red_lp", "bridge_screen_default_08", "bridge_screen_default_08_lp", "bridge_screen_default_08_int_01", "bridge_screen_default_08_red", "bridge_screen_default_08_red_lp", "bridge_screen_default_08_red_widgets", "bridge_screen_default_08_red_widgets_lp", "bridge_screen_default_135", "bridge_screen_default_135_lp", "bridge_screen_default_135_red", "bridge_screen_default_135_red_lp", "bridge_screen_opsmap_08", "bridge_screen_opsmap_08_lp", "bridge_screen_opsmap_08_red", "bridge_screen_opsmap_08_red_lp", "bridge_screen_opsmap_08_red_widgets", "bridge_screen_opsmap_08_red_widgets_lp", "bridge_screen_semitrans_small", "bridge_screen_semitrans_small_lp", "bridge_screen_semitrans_small_red", "bridge_screen_semitrans_small_red_lp", "bridge_screen_semitrans_large", "bridge_screen_semitrans_large_lp", "bridge_screen_semitrans_large_red", "bridge_screen_semitrans_large_red_lp", "bridge_screen_monitor_02", "bridge_screen_monitor_02_lp", "bridge_screen_monitor_02_red", "bridge_screen_monitor_02_red_lp", "bridge_screen_standing_console_1", "bridge_screen_standing_console_1_red", "bridge_screen_standing_console_1_red_lp", "bridge_screen_standing_console_3", "bridge_screen_standing_console_3_red", "bridge_screen_standing_console_3_red_lp", "opsmap_screen_do_square", "opsmap_screen_do_wide", "opsmap_screen_nav_square", "opsmap_screen_nav_wide", "shipcrib_screen_equipment_overhead_monitor", "shipcrib_screen_equipment_laptop_intel_08", "lounge_screen_monitor_01", "lounge_screen_monitor_02"];
      break;
  }

  level._id_FD6E._id_ECDC = scripts\engine\utility::array_combine(level._id_FD6E._id_ECDC, var_1);
  level._id_FD6E._id_ECDC = scripts\engine\utility::array_remove_duplicates(level._id_FD6E._id_ECDC);

  foreach(var_3 in level._id_FD6E._id_ECDC)
  precachemodel(var_3);
}

_id_FDF3(var_0) {
  scripts\engine\utility::flag_init("shipcrib_screens_initialized");
  level _id_0EFB::_id_FE05();

  if(!isDefined(level._id_FD6E._id_ECCE))
    level._id_FD6E._id_ECCE = [];

  if(!isDefined(var_0))
    var_0 = level.script;

  level _id_FDF4(var_0);
  level _id_FDF4("undefined");
  var_1 = scripts\engine\utility::getStructArray("opsmap", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_EE52) || var_3._id_EE52 != "shipcrib_screen")
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  var_5 = scripts\engine\utility::getStructArray("shipcrib_screen", "script_noteworthy");
  level._id_FD6E._id_ECCE = scripts\engine\utility::array_combine(var_1, var_5);

  foreach(var_9, var_7 in level._id_FD6E._id_ECCE) {
    var_8 = _id_FDF1(var_7, var_0);
    var_3 = spawn("script_model", var_7.origin);
    var_3.angles = var_7.angles;
    var_3 setModel(var_8);
    var_3 dontcastshadows();
    level._id_FD6E._id_ECCE[var_9].ent = var_3;
  }

  foreach(var_3 in level._id_FD6E._id_ECCE) {
    var_3.ent _id_FDF2();

    if(isDefined(var_3.ent._id_ECD8) && var_3.ent._id_ECD8.size > 1) {
      var_3.ent _meth_8184();
      var_3.ent thread _id_FDF8();
    }

    switch (var_3.ent.model) {
      case "bridge_screen_admiral":
        if(var_3.script_parameters == "admiral_main")
          level._id_FD6E._id_ECCE["admiral_monitor"] = var_3;

        if(var_3.script_parameters == "admiral_captains")
          level._id_FD6E._id_ECCE["admiral_monitor_captains"] = var_3;

        var_3._id_ECD6 = 1;
        var_3.ent _id_FDF0();
        break;
      case "bridge_screen_admiral_cic":
        var_3._id_ECD6 = 1;
        level._id_FD6E._id_ECCE["admiral_monitor_cic"] = var_3;
        var_3.ent _id_FDF0();
        break;
      case "bridge_screen_cic":
        var_3._id_ECD6 = 1;
        level._id_FD6E._id_ECCE["cic"] = var_3;
        var_3.ent _id_FDF0();
        break;
      default:
        break;
    }
  }

  scripts\engine\utility::flag_set("shipcrib_screens_initialized");
}

_id_FDF1(var_0, var_1) {
  if(!isDefined(var_0.script_modelname)) {
    var_0.script_modelname = "tag_origin";
    return "tag_origin";
  }

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "opsmap")
      var_0.script_modelname = "bridge_screen_opsmap_08";
  }

  if(!isDefined(var_1))
    var_1 = level.script;

  switch (var_1) {
    case "shipcrib_moon":
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      var_2 = var_0.script_modelname + "_yellow";
      break;
    case "shipcrib_epilogue":
      var_2 = var_0.script_modelname + "_blue";
      break;
    default:
      var_2 = var_0.script_modelname;
      break;
  }

  if(!isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_2)))
    var_2 = var_0.script_modelname;

  return var_2;
}

_id_FDF7() {
  self _meth_8184();
  var_0 = getnumparts(self.model);

  for(;;) {
    for(var_1 = 0; var_1 < var_0; var_1++) {
      var_2 = getpartname(self.model, var_1);
      self showpart(var_2);
      wait 2;
      self hidepart(var_2);
    }
  }
}

_id_FDF8() {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");
  var_0 = randomint(self._id_ECD8.size);
  self._id_ECBF = var_0;
  self showpart(self._id_ECD8[var_0]);

  for(;;) {
    if(randomint(25) == 1 && !isDefined(self._id_13D1B) && self._id_ECDF.size > 0) {
      self._id_13D1B = 1;
      self showpart(self._id_ECDF[randomint(self._id_ECDF.size)]);
    } else {
      self._id_13D1B = undefined;

      if(randomint(500) == 1 && isDefined(self._id_ECD3)) {
        self _meth_8184();
        self showpart(self._id_ECD3);
        scripts\engine\utility::waittill_notify_or_timeout("restart_screens", 30);
      } else {
        var_1 = 1;
        var_2 = 8;

        for(;;) {
          if(self._id_ECD0.size > 0)
            _id_FDEA();

          var_3 = 0;

          if(self._id_ECD8.size > 0)
            var_3 = randomint(self._id_ECD8.size);
          else {}

          var_4 = _id_FDEF(4);

          if(!scripts\engine\utility::array_contains(var_4, var_3) || var_1 == var_2) {
            if(var_1 == var_2)
              debug_print3d(self.origin, var_1, (1, 0, 0), 1, 0.25, 200);

            if(isDefined(self._id_ECD1))
              childthread _id_FDEB(var_3);

            self._id_ECBF = var_3;

            if(isDefined(self._id_ECD8[var_3])) {
              self _meth_8184();
              self showpart(self._id_ECD8[var_3]);
            }

            break;
          } else {
            var_1 = var_1 + 1;
            scripts\engine\utility::waitframe();
          }
        }
      }
    }

    var_5 = randomfloatrange(15, 30);
    scripts\engine\utility::waittill_notify_or_timeout("restart_screens", var_5);
  }
}

_id_FDEB(var_0) {
  self notify("stop_children");
  self endon("stop_children");
  var_1 = getarraykeys(self._id_ECD1);
  var_2 = self._id_ECD8[var_0];

  if(!scripts\engine\utility::array_contains(var_1, var_2)) {
    return;
  }
  for(;;) {
    foreach(var_0 in self._id_ECD1[var_2]) {
      self showpart(var_0);
      wait(randomfloatrange(2.0, 5.0));
      self hidepart(var_0);
    }
  }
}

_id_FDEA() {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  self endon("screen_stop_animating");
  level endon("screens_stop_thinking");
  var_0 = randomintrange(0, 2);

  switch (var_0) {
    case 0:
      _id_FDED();
      break;
    case 1:
      _id_FDEC();
      break;
  }
}

_id_FDED() {
  var_0 = [randomfloatrange(0.25, 0.5), randomfloatrange(0.05, 0.15), randomfloatrange(0.05, 0.15), randomfloatrange(0.05, 0.15), randomfloatrange(0.05, 0.15), randomfloatrange(0.05, 0.15)];

  for(;;) {
    foreach(var_3, var_2 in self._id_ECD0) {
      self showpart(var_2);
      wait(var_0[var_3]);
      self hidepart(var_2);
    }
  }
}

_id_FDEC() {
  for(;;) {
    self showpart(self._id_ECD0[0]);
    wait(randomfloatrange(0.25, 0.75));
    var_0 = randomintrange(0, 4);

    for(var_1 = 0; var_1 < var_0; var_1++) {
      self hidepart(self._id_ECD0[0]);
      self showpart(self._id_ECD0[1]);
      wait(randomfloatrange(0.05, 0.1));
      self hidepart(self._id_ECD0[1]);
      self showpart(self._id_ECD0[0]);
      wait(randomfloatrange(0.05, 0.1));
    }
  }
}

_id_FDF6(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");

  if(!isDefined(var_1))
    var_1 = 0.5;

  var_3 = 0;
  var_4 = 0;

  switch (var_0) {
    case "red":
      var_0 = "_red";
      break;
    case "red_force":
      var_0 = "_red";
      var_4 = 1;
      break;
    case "prisoner":
    case "gravity":
    case "europa":
    case "rogue":
    case "moon":
    case "titan":
    case "yellow":
      var_0 = "_yellow";
      break;
    case "yellow_lp":
    case "titan_lp":
      var_0 = "_lp";
      var_3 = 1;
      break;
    case "blue_lp":
    case "prisoner_lp":
    case "rogue_lp":
    case "gravity_lp":
    case "europa_lp":
    case "moon_lp":
      var_0 = "_lp";
      var_3 = 1;
      break;
    case "lp":
      var_0 = "_lp";
      var_3 = 1;
      break;
    case "blue":
      var_0 = "_blue";
      break;
    case "interference":
      var_0 = "_int_01";
      break;
    case "default":
    default:
      var_0 = "";
      break;
  }

  foreach(var_6 in level._id_FD6E._id_ECCE) {
    if(isDefined(var_6._id_ECD6)) {
      continue;
    }
    if(isDefined(var_6.ent._id_13D1A))
      var_6.ent._id_13D1A delete();

    if(isDefined(var_2) && isDefined(var_6.script_parameters) && var_6.script_parameters == var_2) {
      if(!isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + var_0))) {
        continue;
      }
      var_6.ent notify("restart_screens");
      var_6.ent notify("screen_stop_animating");
      var_6.ent notify("stop_children");
      var_6.ent._id_ECD1 = undefined;

      if(var_4)
        var_6.ent setModel(var_6.script_modelname + var_0);
      else if(var_0 == "_red" && scripts\engine\utility::cointoss() && isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + "_red_widgets"))) {
        var_6.ent._id_13D1A = spawn("script_model", var_6.ent.origin);
        var_6.ent._id_13D1A.angles = var_6.ent.angles;
        var_6.ent._id_13D1A setModel(var_6.script_modelname + "_red_widgets");
      } else if(var_0 == "_int_01" && isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + "_int_01"))) {
        var_6.ent._id_13D1A = spawn("script_model", var_6.ent.origin);
        var_6.ent._id_13D1A.angles = var_6.ent.angles;
        var_6.ent._id_13D1A setModel(var_6.script_modelname + "_int_01");
      } else if(var_0 == "_red")
        var_6.ent setModel(var_6.script_modelname + var_0);
      else if(var_0 == "_lp") {
        if(!isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.ent.model + var_0))) {
          continue;
        }
        var_6.ent setModel(var_6.ent.model + var_0);
      } else if(issubstr(var_6.ent.model, "_red_lp"))
        var_6.ent setModel(var_6.script_modelname + "_red");
      else
        var_6.ent setModel(var_6.script_modelname + var_0);

      if(var_6.ent._id_ECD8.size <= 1) {
        continue;
      }
      var_6.ent _id_FDF2();
      var_6.ent _meth_8184();

      if(isDefined(var_6.ent._id_13D1A))
        var_6.ent._id_13D1A thread _id_FDF9();

      if(var_3 && randomint(3) > 0) {
        if(var_6.ent._id_ECD8.size > 1)
          var_6.ent showpart(var_6.ent._id_ECD8[randomint(var_6.ent._id_ECD8.size)]);
      } else if(!var_3) {
        if(var_6.ent._id_ECD8.size > 1)
          var_6.ent showpart(var_6.ent._id_ECD8[randomint(var_6.ent._id_ECD8.size)]);
      }

      wait(randomfloatrange(0, var_1));
      continue;
    }

    if(!isDefined(var_2)) {
      if(!isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + var_0))) {
        continue;
      }
      var_6.ent notify("restart_screens");
      var_6.ent notify("screen_stop_animating");
      var_6.ent notify("stop_children");
      var_6.ent._id_ECD1 = undefined;

      if(var_4)
        var_6.ent setModel(var_6.script_modelname + var_0);
      else if(var_0 == "_red" && scripts\engine\utility::cointoss() && isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + "_red_widgets"))) {
        var_6.ent._id_13D1A = spawn("script_model", var_6.ent.origin);
        var_6.ent._id_13D1A.angles = var_6.ent.angles;
        var_6.ent._id_13D1A setModel(var_6.script_modelname + "_red_widgets");
      } else if(var_0 == "_int_01" && isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.script_modelname + "_int_01"))) {
        var_6.ent._id_13D1A = spawn("script_model", var_6.ent.origin);
        var_6.ent._id_13D1A.angles = var_6.ent.angles;
        var_6.ent._id_13D1A setModel(var_6.script_modelname + "_int_01");
      } else if(var_0 == "_red")
        var_6.ent setModel(var_6.script_modelname + var_0);
      else if(var_0 == "_lp") {
        if(!isDefined(scripts\engine\utility::array_find(level._id_FD6E._id_ECDC, var_6.ent.model + var_0))) {
          continue;
        }
        var_6.ent setModel(var_6.ent.model + var_0);
      } else if(issubstr(var_6.ent.model, "_red_lp"))
        var_6.ent setModel(var_6.script_modelname + "_red");
      else
        var_6.ent setModel(var_6.script_modelname + var_0);

      if(getnumparts(var_6.ent.model) <= 1) {
        continue;
      }
      var_6.ent _id_FDF2();
      var_6.ent _meth_8184();

      if(isDefined(var_6.ent._id_13D1A))
        var_6.ent._id_13D1A thread _id_FDF9(var_6.ent);

      if(var_6.ent._id_ECD8.size > 1)
        var_6.ent showpart(var_6.ent._id_ECD8[randomint(var_6.ent._id_ECD8.size)]);
      else if(var_6.ent._id_ECD0.size > 1)
        var_6.ent showpart(var_6.ent._id_ECD0[randomint(var_6.ent._id_ECD0.size)]);
      else if(var_6.ent._id_ECD7.size > 1)
        var_6.ent showpart(var_6.ent._id_ECD7[randomint(var_6.ent._id_ECD7.size)]);

      wait(randomfloatrange(0, var_1));
      continue;
    }
  }
}

_id_FDF9(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");
  _id_FDF2();
  self _meth_8184();
  var_1 = [];

  if(self._id_ECD8.size > 0)
    var_1[var_1.size] = "flip";

  if(self._id_ECD0.size > 0)
    var_1[var_1.size] = "anim";

  if(self._id_ECD7.size > 0)
    var_1[var_1.size] = "flash";

  if(var_1.size < 1) {
    return;
  }
  switch (var_1[randomint(var_1.size)]) {
    case "flip":
      self showpart(self._id_ECD8[randomint(self._id_ECD8.size)]);
      break;
    case "anim":
      var_2 = getnumparts(self.model);

      for(;;) {
        for(var_3 = 0; var_3 < var_2; var_3++) {
          var_4 = getpartname(self.model, var_3);

          if(var_4 == "shipcrib_bridge_screen_08_int_01") {
            continue;
          }
          if(randomint(3)) {
            continue;
          }
          self showpart(var_4);
          var_5 = undefined;
          var_6 = 0;

          if(scripts\engine\utility::cointoss()) {
            var_5 = randomint(var_0._id_ECD8.size);
            var_0 showpart(var_0._id_ECD8[var_5]);
            var_6 = 1;
          }

          wait(randomfloatrange(0.075, 0.2));
          self hidepart(var_4);

          if(var_6)
            var_0 hidepart(var_0._id_ECD8[var_5]);
        }
      }

      break;
    case "flash":
      var_7 = randomint(self._id_ECD7.size);

      for(;;) {
        self showpart(self._id_ECD7[var_7]);
        wait 0.2;
        self hidepart(self._id_ECD7[var_7]);
        wait 0.2;
      }

      break;
  }
}

_id_FDF2() {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");
  var_0 = getnumparts(self.model);
  self._id_ECD3 = undefined;
  self._id_ECD8 = [];
  self._id_ECDF = [];
  self._id_ECD0 = [];
  self._id_ECD7 = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getpartname(self.model, var_1);

    if(getsubstr(var_2, 0, 4) == "NOE3_bsod") {
      self._id_ECD3 = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 6) == "widget") {
      self._id_ECDF[self._id_ECDF.size] = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 4) == "anim") {
      self._id_ECD0[self._id_ECD0.size] = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 5) == "flash") {
      self._id_ECD7[self._id_ECD7.size] = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 4) == "flip") {
      self._id_ECD8[self._id_ECD8.size] = var_2;
      continue;
    }
  }

  if(self._id_ECD0.size > 0 && self._id_ECD8.size > 0) {
    foreach(var_1, var_4 in self._id_ECD0) {
      var_5 = getsubstr(var_4, 8, var_4.size);

      if(scripts\engine\utility::array_contains(self._id_ECD8, var_5)) {
        if(!isDefined(self._id_ECD1))
          self._id_ECD1 = [];

        if(!isDefined(self._id_ECD1[var_5]))
          self._id_ECD1[var_5] = [];

        self._id_ECD0 = scripts\engine\utility::array_remove(self._id_ECD0, var_4);
        self._id_ECD1[var_5] = scripts\engine\utility::array_add(self._id_ECD1[var_5], var_4);
      }
    }
  }
}

_id_FDF0() {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");
  var_0 = getnumparts(self.model);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getpartname(self.model, var_1);

    if(getsubstr(var_2, 0, 10) == "background") {
      self._id_CBB7 = var_2;
      self._id_ECD2 = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 10) == "wheel_spin") {
      self._id_ECDE = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 11) == "wheel_solid") {
      self._id_ECDD = var_2;
      continue;
    } else if(getsubstr(var_2, 0, 4) == "logo") {
      self._id_ECD9 = var_2;
      continue;
    }
  }
}

_id_FDEF(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");

  if(!isDefined(var_0))
    var_0 = 4;

  if(!isDefined(self._id_ECD4)) {
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, level._id_FD6E._id_ECCE);

    foreach(var_3 in var_1) {
      var_4 = getsubstr(var_3.script_modelname, 0, 20);

      if(getsubstr(self.model, 0, 20) != var_4)
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);

      if(self.origin == var_3.origin)
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }

    if(var_1.size > var_0) {
      self._id_ECD4 = [];

      for(var_6 = 0; var_6 < var_0; var_6++)
        self._id_ECD4[var_6] = var_1[var_6];
    } else
      self._id_ECD4 = var_1;
  }

  var_7 = [];

  for(var_6 = 0; var_6 < self._id_ECD4.size; var_6++) {
    if(isDefined(self._id_ECD4[var_6].ent._id_ECBF))
      var_7[var_6] = self._id_ECD4[var_6].ent._id_ECBF;
  }

  return var_7;
}

_id_FDEE(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("screen_stop_thinking");
  level endon("screens_stop_thinking");

  foreach(var_2 in var_0) {
    if(self.origin == var_2.ent.origin)
      return var_2.ent;
  }
}

debug_print3d(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("shipcrib_screens_debug") == 1)
    return;
}

_id_FDF5() {
  scripts\engine\utility::flag_wait("shipcrib_screens_initialized");
  level notify("screens_stop_thinking");
}