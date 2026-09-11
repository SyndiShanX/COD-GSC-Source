/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stealth\player.gsc
***********************************************/

function stealth_noteworthy_thread(var0, var1) {
  self notify("stealth_noteworthy_thread");

  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!var0) {
    return;
  }

  self endon("stealth_noteworthy_thread");
  self endon("disconnect");

  while(!isDefined(self.stealth)) {
    wait 1;
  }

  stealth_noteworthy_init();

  if(!isDefined(self.stealth.stealth_noted)) {
    self.stealth.stealth_noted = [];
  }

  GscBinSkip4(0x35);
}

function stealth_noteworthy_init() {
  if(isDefined(level.stealth.noteworthy)) {
    return;
  }

  level.stealth.noteworthy = spawnStruct();
  level.stealth.noteworthy.priority_func = &stealth_noteworthy_priority;
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

function stealth_noteworthy_kill_monitor() {
  var0 = 0;
  var1 = undefined;

  for(;;) {
    var1 = self.stats["kills"];

    if(!isDefined(var1)) {
      var1 = 0;
    }

    var2 = var1;
    var3 = gettime();
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level waittill("ai_killed", var4, var5, var6, var7);

    if(!isDefined(var5) || var5 != self) {
      continue;
    }

    if(!scripts\engine\utility::flag("stealth_enabled") || scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    if(isDefined(var4) && isDefined(var4.team) && var4.team != "axis") {
      thread stealth_noteworthy_delayed("civilian_kill", var4);
    }

    var1 = self.stats["kills"];

    if(!isDefined(var1)) {
      var1 = 1;
    }

    var8 = var1 - var2;

    if(gettime() - var3 > 1000) {
      var0 = 0;
    }

    var9 = isDefined(var7) && weapontype(var7) == "bullet";

    if(var8 >= 2 && var9) {
      thread stealth_noteworthy_delayed("good_kill_double", var4, 1);
    }

    var0 += var8;

    if(var0 > 1) {
      thread stealth_noteworthy_delayed("good_kill_impressive", var4, 1);
      continue;
    }

    if(var9) {
      thread stealth_noteworthy_delayed("good_kill_bullet", var4, 1);
      continue;
    }

    thread stealth_noteworthy_delayed("good_kill", var4, 1);
  }
}

function stealth_noteworthy_delayed(var0, var1, var2, var3) {
  var4 = undefined;
  var5 = undefined;

  if(isarray(var1)) {
    var4 = var1;
  } else {
    var5 = var1 getentitynumber();
    var4 = [];
    var4 = var1;
  }

  if(isDefined(self.stealth.stealth_note_pending)) {
    if([[level.stealth.noteworthy.priority_func]](self.stealth.stealth_note_pending) > [[level.stealth.noteworthy.priority_func]](var0)) {
      return;
    }

    if(var0 == "aim") {
      if(isDefined(self.stealth.stealth_note_pending_targets[var5])) {
        return;
      }

      self.stealth.stealth_note_pending_targets = var4;
    } else if(self.stealth.stealth_note_pending == var0) {
      self.stealth.stealth_note_pending_targets[var5] = var1;
    } else {
      self.stealth.stealth_note_pending_targets = var4;
    }
  } else {
    self.stealth.stealth_note_pending = var0;
    self.stealth.stealth_note_pending_targets = var4;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");

  if(istrue(var2) && isDefined(self.stealth.maxalertlevel)) {
    self.stealth.stealth_note_start_alert = self.stealth.maxalertlevel;
  }

  if(!isDefined(var3)) {
    var3 = randomfloatrange(level.stealth.noteworthy.stealth_noteworthy_min_delay, level.stealth.noteworthy.stealth_noteworthy_max_delay);
  }

  if(var3 > 0) {
    wait var3;
  }

  if(isstartstr(var0, "good_kill")) {
    self.stealth.stealth_note_pending_targets = scripts\engine\utility::array_combine(self.stealth.stealth_note_pending_targets);
  } else {
    self.stealth.stealth_note_pending_targets = scripts\engine\utility::array_removedead_or_dying(self.stealth.stealth_note_pending_targets);
  }

  if(istrue(var2) && isDefined(self.stealth.maxalertlevel) && self.stealth.stealth_note_start_alert < self.stealth.maxalertlevel) {
    self.stealth.stealth_note_pending = undefined;
    self.stealth.stealth_note_pending_targets = undefined;
    return;
  }

  if(var0 == "aim") {
    var6 = self getEye();
    var7 = anglesToForward(self getplayerangles());
    var8 = stealth_noteworthy_aim_contents();

    foreach(var10 in self.stealth.stealth_note_pending_targets) {
      var11 = stealth_noteworthy_get_eye(var10);
      var12 = vectorNormalize(var11 - var6);
      var13 = vectordot(var7, var12);

      if(var13 < level.stealth.noteworthy.stealth_noteworthy_min_dot || !scripts\engine\trace::ray_trace_passed(var11, var6, undefined, var8)) {
        self.stealth.stealth_note_pending = undefined;
        self.stealth.stealth_note_pending_targets = undefined;
        return;
      }
    }

    foreach(var1 in self.stealth.stealth_note_pending_targets) {
      self.stealth.stealth_noted[var1 getentitynumber()] = var1;
    }
  }

  self notify("stealth_noteworthy", var0, self.stealth.stealth_note_pending_targets);
  self.stealth.stealth_note_pending = undefined;
  self.stealth.stealth_note_pending_targets = undefined;
}

function stealth_noteworthy_priority(var0) {
  if(!isDefined(var0)) {
    return -1;
  }

  switch (var0) {
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

function stealth_noteworthy_aim_contents() {
  return scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1);
}

function stealth_noteworthy_entities(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = "axis";
  }

  if(istrue(var3)) {
    var5 = getaiarrayinradius(var0, var1, var2, "neutral");
  } else {
    var5 = getaiarrayinradius(var1, var2, var3);
  }

  var5 = scripts\engine\utility::array_removedead_or_dying(var5);

  if(istrue(var5)) {
    var6 = onmatchbegin(var1, var2);

    foreach(var8 in var6) {
      if(isDefined(var8.team) && (var8.team == var3 || istrue(var4) && var8.team == "neutral")) {
        var5 = var8;
      }
    }
  }

  return var5;
}

function stealth_noteworthy_callouts(var0) {
  self notify("stealth_noteworthy_callouts");
  self endon("stealth_noteworthy_callouts");

  if(!istrue(var0)) {
    return;
  }

  level.stealth.noteworthy.callout_next = 0;

  for(;;) {
    wait 0.5;
    scripts\engine\utility::flag_wait("stealth_enabled");

    if(!level.stealth.noteworthy.callout_spotted) {
      scripts\engine\utility::flag_waitopen("stealth_spotted");
    }

    var1 = stealth_noteworthy_entities(self.origin, level.stealth.noteworthy.callout_radius, undefined, level.stealth.noteworthy.civilians_callout, level.stealth.noteworthy.fakeactors_callout);
    var2 = stealth_noteworthy_callouts_init();
    var3 = self getEye();

    foreach(var5 in var1) {
      if(!isDefined(var5.stealth)) {
        continue;
      }

      if(istrue(var5.stealth.callout_disabled)) {
        continue;
      }

      if(isDefined(var5.stealth.callout_next) && gettime() < var5.stealth.callout_next) {
        continue;
      }

      if(isDefined(level.stealth.noteworthy.callout_func_validator) && !self[[level.stealth.noteworthy.callout_func_validator]](var5)) {
        continue;
      }

      var6 = distancesquared(self.origin, var5.origin) > level.stealth.noteworthy.callout_proximity_radius * level.stealth.noteworthy.callout_proximity_radius;

      if(var6 && !stealth_noteworthy_trace(stealth_noteworthy_get_eye(var5), var3, var5)) {
        continue;
      }

      if(stealth_noteworthy_visible(var5, var6)) {
        var5.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        continue;
      }

      if(gettime() < level.stealth.noteworthy.callout_next) {
        continue;
      }

      var7 = stealth_noteworthy_callout_type(var5);

      if(isDefined(var7)) {
        var8 = var5 getentitynumber();

        if(istrue(level.stealth.noteworthy.callout_civilians)) {
          foreach(var10 in var2.results["all"]) {
            if(var10.team != var5.team && var10.team == "neutral") {
              var2 = stealth_noteworthy_callouts_init();
            }

            break;
          }
        }

        var2.results["all"][var8] = var5;
        var12 = distancesquared(self.origin, var5.origin);

        if(var12 < var2.closest_dist_sq) {
          var2.closest_dist_sq = var12;
          var2.closest_type = var7;
        }

        var2.results[var7][var8] = var5;
      }
    }

    if(isDefined(var2.closest_type)) {
      var7 = var2.closest_type;

      foreach(var5 in var2.results[var7]) {
        var5.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
      }

      level.stealth.noteworthy.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_all;
      var16 = [];

      foreach(var5 in var2.results[var7]) {
        var18 = stealth_noteworthy_entities(var5.origin, level.stealth.noteworthy.callout_bunch_radius, var5.team, 0, level.stealth.noteworthy.fakeactors_callout);

        foreach(var20 in var18) {
          var16 = var20;
          var20.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }
      }

      foreach(var5 in var16) {
        var2.results[var7][var5 getentitynumber()] = var5;
      }

      stealth_noteworthy_delayed("callout_" + var7, var2.results[var7], undefined, 0);
    }
  }
}

function stealth_noteworthy_callouts_init() {
  var0 = spawnStruct();
  var0.results["left"] = [];
  var0.results["right"] = [];
  var0.results["ahead"] = [];
  var0.results["behind"] = [];
  var0.results["below"] = [];
  var0.results["all"] = [];
  var0.closest_type = undefined;
  var0.closest_dist_sq = squared(20000);
  return var0;
}

function stealth_noteworthy_callout_type(var0) {
  var1 = undefined;
  var2 = anglesToForward(self.angles);
  var3 = vectorcross(var2, (0, 0, 1));
  var4 = vectorNormalize(var0.origin - self.origin);
  var5 = vectordot(var2, var4);

  if(var5 > 0.7) {
    var1 = "ahead";
  } else if(var5 < -0.7) {
    var1 = "behind";
  } else {
    var6 = var0.origin[2] - self.origin[2];

    if(var5 > 0.7 && var6 < -100) {
      var1 = "below";
    } else {
      var7 = vectordot(var3, var4);

      if(var7 < -0.7) {
        var1 = "left";
      } else if(var7 > 0.7) {
        var1 = "right";
      }
    }
  }

  if(isDefined(var1) && !istrue(level.stealth.noteworthy.callout_enabled[var1])) {
    return undefined;
  }

  return var1;
}

function stealth_noteworthy_visible(var0, var1) {
  if(!scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, 0.7)) {
    return false;
  }

  var2 = self getEye();

  if(stealth_noteworthy_trace(var2, var0.origin + (0, 0, 18), var0)) {
    return true;
  }

  if(var1 || stealth_noteworthy_trace(var2, stealth_noteworthy_get_eye(var0), var0)) {
    return true;
  }

  return false;
}

function stealth_noteworthy_get_eye() {
  var0 = self.origin + (0, 0, 50);

  if(issentient(self)) {
    var0 = self getEye();
  }

  return var0;
}

function stealth_noteworthy_trace(var0, var1, var2) {
  stealth_noteworthy_trace_safety_check();
  return scripts\engine\trace::ray_trace_passed(var0, var1, [self, var2], level.stealth.noteworthy.callout_trace_contents);
}

function stealth_noteworthy_trace_safety_check() {
  level.stealth.noteworthy.callout_traces++;

  if(level.stealth.noteworthy.callout_traces > 3) {
    waitframe();
    level.stealth.noteworthy.callout_traces = 1;
    return;
  }
}

function ambient_player_thread(var0, var1, var2, var3) {
  self notify("ambient_player_thread");
  self endon("ambient_player_thread");
  self endon("disconnect");

  if(!isDefined(var0)) {
    var0 = 10;
  }

  if(!isDefined(var1)) {
    var1 = 15;
  }

  if(!isDefined(var2)) {
    var2 = 20;
  }

  if(!isDefined(var3)) {
    var3 = 40;
  }

  level.stealth.candidatesvoice = [];
  level.stealth.candidatesradio = [];

  for(;;) {
    if(!isalive(self)) {
      waitframe();
      continue;
    }

    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    if(level.stealth.candidatesvoice.size == 0 && level.stealth.candidatesradio.size == 0) {
      wait 1;
    } else {
      wait randomfloatrange(var0, var1);
    }

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    level.stealth.candidatesvoice = ambient_candidates(0, 1);
    level.stealth.candidatesradio = ambient_candidates(1, 0);
    var4 = undefined;
    var5 = "idle";
    var6 = undefined;

    if(level.stealth.candidatesvoice.size > 0 && level.stealth.candidatesradio.size > 0) {
      if(scripts\engine\utility::cointoss()) {
        var4 = level.stealth.candidatesradio[0];
        var5 = "radio";
        var6 = "convo";
      } else {
        var4 = level.stealth.candidatesvoice[0];
      }
    } else if(level.stealth.candidatesradio.size > 0) {
      var4 = level.stealth.candidatesradio[0];
      var5 = "radio";
      var6 = "convo";
    } else if(level.stealth.candidatesvoice.size > 0) {
      var4 = level.stealth.candidatesvoice[0];
    }

    if(isDefined(var4)) {
      if(var5 == "idle" && isDefined(var4.demeanoroverride) && var4.demeanoroverride == "alert") {
        var5 = "idle_alert";
      }

      var4 thread scripts\stealth\utility::addeventplaybcs("stealth", var5, var6);
      var4.stealth.vo_next_ambient = gettime() + randomfloatrange(var2, var3) * 1000;
    }
  }
}

function ambient_candidates(var0, var1) {
  var2 = 1000;
  var3 = [];

  if(!var0 && !var1) {
    return var3;
  }

  if(var0 && !var1 && !scripts\anim\battlechatter_table::bctable_exists("stealth", "radio", "convo")) {
    return var3;
  }

  var4 = getaiarrayinradius(self.origin, var2, "axis");
  var4 = scripts\engine\utility::array_removeundefined(var4);

  foreach(var6 in var4) {
    if(!var0 && !isalive(var6)) {
      continue;
    }

    if(!var0 && (!isDefined(var6.stealth) || issentient(var6) && var6.alertlevel == "combat")) {
      continue;
    }

    if(issentient(var6) && var6.ignoreall) {
      continue;
    }

    if(issentient(var6) && !isDefined(var6.stealth)) {
      continue;
    }

    if(isDefined(var6.fnisinstealthidlescriptedanim) && var6[[var6.fnisinstealthidlescriptedanim]]()) {
      continue;
    }

    if(isDefined(var6.fnisinstealthidle) && !istrue(var6[[var6.fnisinstealthidle]]())) {
      continue;
    }

    if(var6.subclass == "dog") {
      continue;
    }

    if(isDefined(var6.stealth)) {
      if(isDefined(var6.stealth.vo_next_ambient) && gettime() < var6.stealth.vo_next_ambient) {
        continue;
      }

      if(isDefined(var6.stealth.last_sound_time) && gettime() - var6.stealth.last_sound_time < 10000) {
        continue;
      }

      if(isDefined(var6.stealth.last_severity_time) && gettime() - var6.stealth.last_severity_time < 10000) {
        continue;
      }
    }

    var3 = var6;
  }

  var3 = sortbydistance(var3, self.origin);
  return var3;
}

function ambient_player_stop() {
  self notify("ambient_player_thread");
}