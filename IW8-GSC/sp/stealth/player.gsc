/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stealth\player.gsc
***********************************************/

stealth_noteworthy_thread(var_0, var_1) {
  self notify("stealth_noteworthy_thread");

  if(!isDefined(var_0))
    var_0 = 1;

  if(!var_0) {
    return;
  }
  self endon("stealth_noteworthy_thread");
  self endon("disconnect");

  while(!isDefined(self.stealth))
    wait 1.0;

  stealth_noteworthy_init();

  if(!isDefined(self.stealth.stealth_noted))
    self.stealth.stealth_noted = [];

  childthread stealth_noteworthy_kill_monitor();

  if(istrue(var_1))
    childthread stealth_noteworthy_callouts(1);

  var_2 = stealth_noteworthy_aim_contents();

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    var_3 = -1.0;
    var_4 = undefined;

    if(self playerads() > level.stealth.noteworthy.stealth_noteworthy_min_ads) {
      var_5 = self getEye();
      var_6 = anglesToForward(self getplayerangles());
      var_7 = stealth_noteworthy_entities(self.origin, 20000, "axis", level.stealth.noteworthy.civilians_aim, level.stealth.noteworthy.fakeactors_aim);

      foreach(var_9 in var_7) {
        var_10 = var_9 getentitynumber();

        if(isDefined(self.stealth.stealth_noted[var_10])) {
          continue;
        }
        var_11 = var_9 stealth_noteworthy_get_eye();
        var_12 = vectorNormalize(var_11 - var_5);
        var_13 = vectordot(var_6, var_12);

        if(var_13 > level.stealth.noteworthy.stealth_noteworthy_min_dot && var_13 > var_3) {
          if(scripts\engine\trace::ray_trace_passed(var_11, var_5, undefined, var_2)) {
            var_3 = var_13;
            var_4 = var_9;
          }
        }
      }

      if(isDefined(var_4))
        thread stealth_noteworthy_delayed("aim", var_4);

      foreach(var_10, var_16 in self.stealth.stealth_noted) {
        if(!isDefined(self.stealth.stealth_noted[var_10]))
          self.stealth.stealth_noted[var_10] = undefined;
      }
    }

    waitframe();
  }
}

stealth_noteworthy_init() {
  if(isDefined(level.stealth.noteworthy)) {
    return;
  }
  level.stealth.noteworthy = spawnStruct();
  level.stealth.noteworthy.priority_func = ::stealth_noteworthy_priority;
  level.stealth.noteworthy.stealth_noteworthy_min_ads = 0.3;
  level.stealth.noteworthy.stealth_noteworthy_min_dot = 0.99;
  level.stealth.noteworthy.stealth_noteworthy_min_delay = 0.25;
  level.stealth.noteworthy.stealth_noteworthy_max_delay = 0.5;
  level.stealth.noteworthy.callout_enabled = [];
  level.stealth.noteworthy.callout_enabled["left"] = 1;
  level.stealth.noteworthy.callout_enabled["right"] = 1;
  level.stealth.noteworthy.callout_enabled["ahead"] = 0;
  level.stealth.noteworthy.callout_enabled["behind"] = 1;
  level.stealth.noteworthy.callout_enabled["below"] = 1;
  level.stealth.noteworthy.fakeactors_aim = 1;
  level.stealth.noteworthy.fakeactors_callout = 0;
  level.stealth.noteworthy.civilians_aim = 1;
  level.stealth.noteworthy.civilians_callout = 1;
  level.stealth.noteworthy.callout_debounce_guy = 60000;
  level.stealth.noteworthy.callout_debounce_all = 15000;
  level.stealth.noteworthy.callout_radius = 800;
  level.stealth.noteworthy.callout_proximity_radius = 0;
  level.stealth.noteworthy.callout_bunch_radius = 100;
  level.stealth.noteworthy.callout_func_validator = undefined;
  level.stealth.noteworthy.callout_trace_contents = scripts\engine\trace::create_ainosight_contents();
  level.stealth.noteworthy.callout_traces = 0;
  level.stealth.noteworthy.callout_spotted = 0;
}

stealth_noteworthy_kill_monitor() {
  var_0 = 0;
  var_1 = undefined;

  for(;;) {
    var_1 = self.stats["kills"];

    if(!isDefined(var_1))
      var_1 = 0;

    var_2 = var_1;
    var_3 = gettime();
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level waittill("ai_killed", var_4, var_5, var_6, var_7);

    if(!isDefined(var_5) || var_5 != self) {
      continue;
    }
    if(!scripts\engine\utility::flag("stealth_enabled") || scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4.team) && var_4.team != "axis")
      thread stealth_noteworthy_delayed("civilian_kill", var_4);

    var_1 = self.stats["kills"];

    if(!isDefined(var_1))
      var_1 = 1;

    var_8 = var_1 - var_2;

    if(gettime() - var_3 > 1000)
      var_0 = 0;

    var_9 = isDefined(var_7) && weapontype(var_7) == "bullet";

    if(var_8 >= 2 && var_9)
      thread stealth_noteworthy_delayed("good_kill_double", var_4, 1);

    var_0 = var_0 + var_8;

    if(var_0 > 1) {
      thread stealth_noteworthy_delayed("good_kill_impressive", var_4, 1);
      continue;
    }

    if(var_9) {
      thread stealth_noteworthy_delayed("good_kill_bullet", var_4, 1);
      continue;
    }

    thread stealth_noteworthy_delayed("good_kill", var_4, 1);
  }
}

stealth_noteworthy_delayed(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;

  if(isarray(var_1))
    var_4 = var_1;
  else {
    var_5 = var_1 getentitynumber();
    var_4 = [];
    var_4[var_5] = var_1;
  }

  if(isDefined(self.stealth.stealth_note_pending)) {
    if([[level.stealth.noteworthy.priority_func]](self.stealth.stealth_note_pending) > [[level.stealth.noteworthy.priority_func]](var_0)) {
      return;
    }
    if(var_0 == "aim") {
      if(isDefined(self.stealth.stealth_note_pending_targets[var_5])) {
        return;
      }
      self.stealth.stealth_note_pending_targets = var_4;
    } else if(self.stealth.stealth_note_pending == var_0)
      self.stealth.stealth_note_pending_targets[var_5] = var_1;
    else
      self.stealth.stealth_note_pending_targets = var_4;
  } else {
    self.stealth.stealth_note_pending = var_0;
    self.stealth.stealth_note_pending_targets = var_4;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");

  if(istrue(var_2) && isDefined(self.stealth.maxalertlevel))
    self.stealth.stealth_note_start_alert = self.stealth.maxalertlevel;

  if(!isDefined(var_3))
    var_3 = randomfloatrange(level.stealth.noteworthy.stealth_noteworthy_min_delay, level.stealth.noteworthy.stealth_noteworthy_max_delay);

  if(var_3 > 0)
    wait(var_3);

  if(isstartstr(var_0, "good_kill"))
    self.stealth.stealth_note_pending_targets = scripts\engine\utility::array_combine(self.stealth.stealth_note_pending_targets);
  else
    self.stealth.stealth_note_pending_targets = scripts\engine\utility::array_removedead_or_dying(self.stealth.stealth_note_pending_targets);

  if(istrue(var_2) && isDefined(self.stealth.maxalertlevel) && self.stealth.stealth_note_start_alert < self.stealth.maxalertlevel) {
    self.stealth.stealth_note_pending = undefined;
    self.stealth.stealth_note_pending_targets = undefined;
    return;
  }

  if(var_0 == "aim") {
    var_6 = self getEye();
    var_7 = anglesToForward(self getplayerangles());
    var_8 = stealth_noteworthy_aim_contents();

    foreach(var_10 in self.stealth.stealth_note_pending_targets) {
      var_11 = var_10 stealth_noteworthy_get_eye();
      var_12 = vectorNormalize(var_11 - var_6);
      var_13 = vectordot(var_7, var_12);

      if(var_13 < level.stealth.noteworthy.stealth_noteworthy_min_dot || !scripts\engine\trace::ray_trace_passed(var_11, var_6, undefined, var_8)) {
        self.stealth.stealth_note_pending = undefined;
        self.stealth.stealth_note_pending_targets = undefined;
        return;
      }
    }

    foreach(var_1 in self.stealth.stealth_note_pending_targets)
    self.stealth.stealth_noted[var_1 getentitynumber()] = var_1;
  }

  self notify("stealth_noteworthy", var_0, self.stealth.stealth_note_pending_targets);
  self.stealth.stealth_note_pending = undefined;
  self.stealth.stealth_note_pending_targets = undefined;
}

stealth_noteworthy_priority(var_0) {
  if(!isDefined(var_0))
    return -1;

  switch (var_0) {
    case "civilian_kill":
      return 70;
    case "good_kill_double":
      return 60;
    case "good_kill_impressive":
      return 50;
    case "good_kill_bullet":
      return 40;
    case "good_kill":
      return 30;
    case "aim":
      return 20;
    case "callout_behind":
    case "callout_ahead":
    case "callout_below":
    case "callout_right":
    case "callout_left":
      return 10;
  }

  return 0;
}

stealth_noteworthy_aim_contents() {
  return scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1);
}

stealth_noteworthy_entities(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = "axis";

  if(istrue(var_3))
    var_5 = getaiarrayinradius(var_0, var_1, var_2, "neutral");
  else
    var_5 = getaiarrayinradius(var_0, var_1, var_2);

  var_5 = scripts\engine\utility::array_removedead_or_dying(var_5);

  if(istrue(var_4)) {
    var_6 = onmatchbegin(var_0, var_1);

    foreach(var_8 in var_6) {
      if(isDefined(var_8.team) && (var_8.team == var_2 || istrue(var_3) && var_8.team == "neutral"))
        var_5[var_5.size] = var_8;
    }
  }

  return var_5;
}

stealth_noteworthy_callouts(var_0) {
  self notify("stealth_noteworthy_callouts");
  self endon("stealth_noteworthy_callouts");

  if(!istrue(var_0)) {
    return;
  }
  level.stealth.noteworthy.callout_next = 0;

  for(;;) {
    wait 0.5;
    scripts\engine\utility::flag_wait("stealth_enabled");

    if(!level.stealth.noteworthy.callout_spotted)
      scripts\engine\utility::flag_waitopen("stealth_spotted");

    var_1 = stealth_noteworthy_entities(self.origin, level.stealth.noteworthy.callout_radius, undefined, level.stealth.noteworthy.civilians_callout, level.stealth.noteworthy.fakeactors_callout);
    var_2 = stealth_noteworthy_callouts_init();
    var_3 = self getEye();

    foreach(var_5 in var_1) {
      if(!isDefined(var_5.stealth)) {
        continue;
      }
      if(istrue(var_5.stealth.callout_disabled)) {
        continue;
      }
      if(isDefined(var_5.stealth.callout_next) && gettime() < var_5.stealth.callout_next) {
        continue;
      }
      if(isDefined(level.stealth.noteworthy.callout_func_validator) && !self[[level.stealth.noteworthy.callout_func_validator]](var_5)) {
        continue;
      }
      var_6 = distancesquared(self.origin, var_5.origin) > level.stealth.noteworthy.callout_proximity_radius * level.stealth.noteworthy.callout_proximity_radius;

      if(var_6 && !stealth_noteworthy_trace(var_5 stealth_noteworthy_get_eye(), var_3, var_5)) {
        continue;
      }
      if(stealth_noteworthy_visible(var_5, var_6)) {
        var_5.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        continue;
      }

      if(gettime() < level.stealth.noteworthy.callout_next) {
        continue;
      }
      var_7 = stealth_noteworthy_callout_type(var_5);

      if(isDefined(var_7)) {
        var_8 = var_5 getentitynumber();

        if(istrue(level.stealth.noteworthy.callout_civilians)) {
          foreach(var_10 in var_2.results["all"]) {
            if(var_10.team != var_5.team && var_10.team == "neutral")
              var_2 = stealth_noteworthy_callouts_init();

            break;
          }
        }

        var_2.results["all"][var_8] = var_5;
        var_12 = distancesquared(self.origin, var_5.origin);

        if(var_12 < var_2.closest_dist_sq) {
          var_2.closest_dist_sq = var_12;
          var_2.closest_type = var_7;
        }

        var_2.results[var_7][var_8] = var_5;
      }
    }

    if(isDefined(var_2.closest_type)) {
      var_7 = var_2.closest_type;

      foreach(var_5 in var_2.results[var_7])
      var_5.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;

      level.stealth.noteworthy.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_all;
      var_16 = [];

      foreach(var_5 in var_2.results[var_7]) {
        var_18 = stealth_noteworthy_entities(var_5.origin, level.stealth.noteworthy.callout_bunch_radius, var_5.team, 0, level.stealth.noteworthy.fakeactors_callout);

        foreach(var_20 in var_18) {
          var_16[var_20 getentitynumber()] = var_20;
          var_20.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }
      }

      foreach(var_5 in var_16)
      var_2.results[var_7][var_5 getentitynumber()] = var_5;

      stealth_noteworthy_delayed("callout_" + var_7, var_2.results[var_7], undefined, 0);
    }
  }
}

stealth_noteworthy_callouts_init() {
  var_0 = spawnStruct();
  var_0.results["left"] = [];
  var_0.results["right"] = [];
  var_0.results["ahead"] = [];
  var_0.results["behind"] = [];
  var_0.results["below"] = [];
  var_0.results["all"] = [];
  var_0.closest_type = undefined;
  var_0.closest_dist_sq = squared(20000);
  return var_0;
}

stealth_noteworthy_callout_type(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorcross(var_2, (0, 0, 1));
  var_4 = vectorNormalize(var_0.origin - self.origin);
  var_5 = vectordot(var_2, var_4);

  if(var_5 > 0.7)
    var_1 = "ahead";
  else if(var_5 < -0.7)
    var_1 = "behind";
  else {
    var_6 = var_0.origin[2] - self.origin[2];

    if(var_5 > 0.7 && var_6 < -100)
      var_1 = "below";
    else {
      var_7 = vectordot(var_3, var_4);

      if(var_7 < -0.7)
        var_1 = "left";
      else if(var_7 > 0.7)
        var_1 = "right";
    }
  }

  if(isDefined(var_1) && !istrue(level.stealth.noteworthy.callout_enabled[var_1]))
    return undefined;

  return var_1;
}

stealth_noteworthy_visible(var_0, var_1) {
  if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.7))
    return 0;

  var_2 = self getEye();

  if(stealth_noteworthy_trace(var_2, var_0.origin + (0, 0, 18), var_0))
    return 1;

  if(var_1 || stealth_noteworthy_trace(var_2, var_0 stealth_noteworthy_get_eye(), var_0))
    return 1;

  return 0;
}

stealth_noteworthy_get_eye() {
  var_0 = self.origin + (0, 0, 50);

  if(issentient(self))
    var_0 = self getEye();

  return var_0;
}

stealth_noteworthy_trace(var_0, var_1, var_2) {
  stealth_noteworthy_trace_safety_check();
  return scripts\engine\trace::ray_trace_passed(var_0, var_1, [self, var_2], level.stealth.noteworthy.callout_trace_contents);
}

stealth_noteworthy_trace_safety_check() {
  level.stealth.noteworthy.callout_traces++;

  if(level.stealth.noteworthy.callout_traces > 3) {
    waitframe();
    level.stealth.noteworthy.callout_traces = 1;
  }
}

ambient_player_thread(var_0, var_1, var_2, var_3) {
  self notify("ambient_player_thread");
  self endon("ambient_player_thread");
  self endon("disconnect");

  if(!isDefined(var_0))
    var_0 = 10;

  if(!isDefined(var_1))
    var_1 = 15;

  if(!isDefined(var_2))
    var_2 = 20;

  if(!isDefined(var_3))
    var_3 = 40;

  level.stealth.candidatesvoice = [];
  level.stealth.candidatesradio = [];

  for(;;) {
    if(!isalive(self)) {
      waitframe();
      continue;
    }

    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    if(level.stealth.candidatesvoice.size == 0 && level.stealth.candidatesradio.size == 0)
      wait 1;
    else
      wait(randomfloatrange(var_0, var_1));

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }
    level.stealth.candidatesvoice = ambient_candidates(0, 1);
    level.stealth.candidatesradio = ambient_candidates(1, 0);
    var_4 = undefined;
    var_5 = "idle";
    var_6 = undefined;

    if(level.stealth.candidatesvoice.size > 0 && level.stealth.candidatesradio.size > 0) {
      if(scripts\engine\utility::cointoss()) {
        var_4 = level.stealth.candidatesradio[0];
        var_5 = "radio";
        var_6 = "convo";
      } else
        var_4 = level.stealth.candidatesvoice[0];
    } else if(level.stealth.candidatesradio.size > 0) {
      var_4 = level.stealth.candidatesradio[0];
      var_5 = "radio";
      var_6 = "convo";
    } else if(level.stealth.candidatesvoice.size > 0)
      var_4 = level.stealth.candidatesvoice[0];

    if(isDefined(var_4)) {
      if(var_5 == "idle" && isDefined(var_4.demeanoroverride) && var_4.demeanoroverride == "alert")
        var_5 = "idle_alert";

      var_4 thread scripts\stealth\utility::addeventplaybcs("stealth", var_5, var_6);
      var_4.stealth.vo_next_ambient = gettime() + randomfloatrange(var_2, var_3) * 1000.0;
    }
  }
}

ambient_candidates(var_0, var_1) {
  var_2 = 1000;
  var_3 = [];

  if(!var_0 && !var_1)
    return var_3;

  if(var_0 && !var_1 && !scripts\anim\battlechatter_table.gsc::bctable_exists("stealth", "radio", "convo"))
    return var_3;

  var_4 = getaiarrayinradius(self.origin, var_2, "axis");
  var_4 = scripts\engine\utility::array_removeundefined(var_4);

  foreach(var_6 in var_4) {
    if(!var_0 && !isalive(var_6)) {
      continue;
    }
    if(!var_0 && (!isDefined(var_6.stealth) || issentient(var_6) && var_6.alertlevel == "combat")) {
      continue;
    }
    if(issentient(var_6) && var_6.ignoreall) {
      continue;
    }
    if(issentient(var_6) && !isDefined(var_6.stealth)) {
      continue;
    }
    if(isDefined(var_6.fnisinstealthidlescriptedanim) && var_6[[var_6.fnisinstealthidlescriptedanim]]()) {
      continue;
    }
    if(isDefined(var_6.fnisinstealthidle) && !istrue(var_6[[var_6.fnisinstealthidle]]())) {
      continue;
    }
    if(var_6.subclass == "dog") {
      continue;
    }
    if(isDefined(var_6.stealth)) {
      if(isDefined(var_6.stealth.vo_next_ambient) && gettime() < var_6.stealth.vo_next_ambient) {
        continue;
      }
      if(isDefined(var_6.stealth.last_sound_time) && gettime() - var_6.stealth.last_sound_time < 10000) {
        continue;
      }
      if(isDefined(var_6.stealth.last_severity_time) && gettime() - var_6.stealth.last_severity_time < 10000)
        continue;
    }

    var_3[var_3.size] = var_6;
  }

  var_3 = sortbydistance(var_3, self.origin);
  return var_3;
}

ambient_player_stop() {
  self notify("ambient_player_thread");
}