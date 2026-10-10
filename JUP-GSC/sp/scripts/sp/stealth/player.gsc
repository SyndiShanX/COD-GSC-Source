/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\stealth\player.gsc
***********************************************/

#using scripts\anim\battlechatter_table;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\utility;
#namespace player;

function stealth_noteworthy_thread(enabled, callouts) {
  self notify("stealth_noteworthy_thread");

  if(!isDefined(enabled)) {
    enabled = 1;
  }

  if(!enabled) {
    return;
  }

  self endon("stealth_noteworthy_thread");
  self endon("disconnect");
  assert(isPlayer(self));

  while(!isDefined(self.stealth)) {
    wait 1;
  }

  stealth_noteworthy_init();

  thread function_61e159123eb6f896();

  if(!isDefined(self.stealth.stealth_noted)) {
    self.stealth.stealth_noted = [];
  }

  childthread stealth_noteworthy_kill_monitor();

  if(istrue(callouts)) {
    childthread stealth_noteworthy_callouts(1);
  }

  contents = stealth_noteworthy_aim_contents();

  while(true) {
    flag_wait("stealth_enabled");
    flag_waitopen("stealth_spotted");
    bestdot = -1;
    var_5d2a2a8b837615b6 = undefined;

    if(self playerads() > level.stealth.noteworthy.stealth_noteworthy_min_ads) {
      eye = self getEye();
      eye_dir = anglesToForward(self getplayerangles());
      targets = stealth_noteworthy_entities(self.origin, 20000, "axis", level.stealth.noteworthy.civilians_aim, level.stealth.noteworthy.fakeactors_aim);

      foreach(tgt in targets) {
        entnum = tgt getentitynumber();

        if(isDefined(self.stealth.stealth_noted[entnum])) {
          continue;
        }

        tgteye = tgt stealth_noteworthy_get_eye();
        dir = vectorNormalize(tgteye - eye);
        dot = vectordot(eye_dir, dir);

        if(dot > level.stealth.noteworthy.stealth_noteworthy_min_dot && dot > bestdot) {
          if(scripts\engine\trace::ray_trace_passed(tgteye, eye, undefined, contents)) {
            bestdot = dot;
            var_5d2a2a8b837615b6 = tgt;
          }
        }
      }

      if(isDefined(var_5d2a2a8b837615b6)) {
        thread stealth_noteworthy_delayed("aim", var_5d2a2a8b837615b6);
      }

      foreach(entnum, ent in self.stealth.stealth_noted) {
        if(!isDefined(self.stealth.stealth_noted[entnum])) {
          self.stealth.stealth_noted[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

function stealth_noteworthy_init() {
  if(isDefined(level.stealth.noteworthy)) {
    return;
  }

  setdvarifuninitialized(@ "hash_8434b3949f1e535d", 0);

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
  level flag_set("stealth_noteworthy_inited");
}

function stealth_noteworthy_kill_monitor() {
  assert(isPlayer(self));
  killedquickly = 0;
  kills = undefined;

  while(true) {
    kills = self.stats["kills"];

    if(!isDefined(kills)) {
      kills = 0;
    }

    lastkillcount = kills;
    lastkilltime = gettime();
    flag_wait("stealth_enabled");
    flag_waitopen("stealth_spotted");
    level waittill("ai_killed", victim, attacker, meansofdeath, weapon);

    if(!isDefined(attacker) || attacker != self) {
      continue;
    }

    if(!flag("stealth_enabled") || flag("stealth_spotted")) {
      continue;
    }

    if(isDefined(victim) && isDefined(victim.team) && victim.team != "axis") {
      thread stealth_noteworthy_delayed("civilian_kill", victim);
    }

    kills = self.stats["kills"];

    if(!isDefined(kills)) {
      kills = 1;
    }

    deltakills = kills - lastkillcount;

    if(gettime() - lastkilltime > 1000) {
      killedquickly = 0;
    }

    isbullet = isDefined(weapon) && weapontype(weapon) == "bullet";

    if(deltakills >= 2 && isbullet) {
      thread stealth_noteworthy_delayed("good_kill_double", victim, 1);
    }

    killedquickly += deltakills;

    if(killedquickly > 1) {
      thread stealth_noteworthy_delayed("good_kill_impressive", victim, 1);
      continue;
    }

    if(isbullet) {
      thread stealth_noteworthy_delayed("good_kill_bullet", victim, 1);
      continue;
    }

    thread stealth_noteworthy_delayed("good_kill", victim, 1);
  }
}

function stealth_noteworthy_delayed(eventname, target, var_dc524d5756a28562, delay) {
  targets = undefined;
  entnum = undefined;

  if(isarray(target)) {
    targets = target;
  } else {
    entnum = target getentitynumber();
    targets = [];
    targets[entnum] = target;
  }

  if(isDefined(self.stealth.stealth_note_pending)) {
    if([[level.stealth.noteworthy.priority_func]](self.stealth.stealth_note_pending) > [[level.stealth.noteworthy.priority_func]](eventname)) {
      return;
    }

    if(eventname == "aim") {
      if(isDefined(self.stealth.stealth_note_pending_targets[entnum])) {
        return;
      }

      self.stealth.stealth_note_pending_targets = targets;
    } else if(self.stealth.stealth_note_pending == eventname) {
      self.stealth.stealth_note_pending_targets[entnum] = target;
    } else {
      self.stealth.stealth_note_pending_targets = targets;
    }
  } else {
    self.stealth.stealth_note_pending = eventname;
    self.stealth.stealth_note_pending_targets = targets;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");
  var_47d2bd504a119e32 = function_725f1665c849c38(self);

  if(istrue(var_dc524d5756a28562)) {
    self.stealth.stealth_note_start_alert = var_47d2bd504a119e32;
  }

  if(!isDefined(delay)) {
    delay = randomfloatrange(level.stealth.noteworthy.stealth_noteworthy_min_delay, level.stealth.noteworthy.stealth_noteworthy_max_delay);
  }

  if(delay > 0) {
    wait delay;
  }

  if(isstartstr(eventname, "good_kill")) {
    self.stealth.stealth_note_pending_targets = array_combine(self.stealth.stealth_note_pending_targets);
  } else {
    self.stealth.stealth_note_pending_targets = array_removedead_or_dying(self.stealth.stealth_note_pending_targets);
  }

  var_47d2bd504a119e32 = function_725f1665c849c38(self);

  if(istrue(var_dc524d5756a28562) && self.stealth.stealth_note_start_alert < var_47d2bd504a119e32) {
    self.stealth.stealth_note_pending = undefined;
    self.stealth.stealth_note_pending_targets = undefined;
    return;
  }

  if(eventname == "aim") {
    eye = self getEye();
    eye_dir = anglesToForward(self getplayerangles());
    contents = stealth_noteworthy_aim_contents();

    foreach(ent in self.stealth.stealth_note_pending_targets) {
      tgteye = ent stealth_noteworthy_get_eye();
      dir = vectorNormalize(tgteye - eye);
      dot = vectordot(eye_dir, dir);

      if(dot < level.stealth.noteworthy.stealth_noteworthy_min_dot || !scripts\engine\trace::ray_trace_passed(tgteye, eye, undefined, contents)) {
        self.stealth.stealth_note_pending = undefined;
        self.stealth.stealth_note_pending_targets = undefined;
        return;
      }
    }

    foreach(target in self.stealth.stealth_note_pending_targets) {
      self.stealth.stealth_noted[target getentitynumber()] = target;
    }
  }

  self notify("stealth_noteworthy", eventname, self.stealth.stealth_note_pending_targets);
  self.stealth.stealth_note_pending = undefined;
  self.stealth.stealth_note_pending_targets = undefined;
}

function stealth_noteworthy_priority(eventname) {
  if(!isDefined(eventname)) {
    return -1;
  }

  switch (eventname) {
    case #"hash_f60ebddde2ee0f29":
      return 70;
    case #"hash_10a6338a862cd8bf":
      return 60;
    case #"hash_b54da6bf6764881f":
      return 50;
    case #"hash_f30e36d66620594e":
      return 40;
    case #"hash_a64562871acfadf9":
      return 30;
    case #"hash_c57516c109cc3d6":
      return 20;
    case #"hash_64065f87493125ee":
    case #"hash_72bf88925caef6c8":
    case #"hash_aa271d9cc72e1115":
    case #"hash_bc512d79f62ed755":
    case #"hash_e31ceb31d8625de1":
      return 10;
  }

  return 0;
}

function function_61e159123eb6f896() {
  while(true) {
    level.player waittill("<dev string:x1c>", eventname, subjectlist);

    if(getdvarint(@ "hash_8434b3949f1e535d")) {
      foreach(subject in subjectlist) {
        if(isDefined(subject)) {
          iprintln("<dev string:x2f>" + eventname + "<dev string:x45>" + subject getentitynumber());
          continue;
        }

        iprintln("<dev string:x2f>" + eventname + "<dev string:x49>");
      }
    }
  }
}

function function_e3b8b11bfb019b21(timeout) {
  self endon("<dev string:x5d>");
  level endon("<dev string:x63>");

  while(isDefined(self) && self getthreatsight(level.player) > 0) {
    waitframe();
  }

  if(isDefined(timeout)) {
    wait timeout;
  }

  self hudoutlinedisable();
}

function stealth_noteworthy_aim_contents() {
  return scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1);
}

function stealth_noteworthy_entities(origin, radius, team, civilians, fakeactors) {
  if(!isDefined(team)) {
    team = "axis";
  }

  if(istrue(civilians)) {
    entities = getaiarrayinradius(origin, radius, team, "neutral");
  } else {
    entities = getaiarrayinradius(origin, radius, team);
  }

  entities = array_removedead_or_dying(entities);

  if(istrue(fakeactors)) {
    var_226f19ab7c6e987f = getfakeaiarrayinradius(origin, radius);

    foreach(fake_actor in var_226f19ab7c6e987f) {
      if(isDefined(fake_actor.team) && (fake_actor.team == team || istrue(civilians) && fake_actor.team == "neutral")) {
        entities[entities.size] = fake_actor;
      }
    }
  }

  return entities;
}

function stealth_noteworthy_callouts(enabled) {
  self notify("stealth_noteworthy_callouts");
  self endon("stealth_noteworthy_callouts");

  if(!istrue(enabled)) {
    return;
  }

  level.stealth.noteworthy.callout_next = 0;

  while(true) {
    wait 0.5;
    flag_wait("stealth_enabled");

    if(!level.stealth.noteworthy.callout_spotted) {
      flag_waitopen("stealth_spotted");
    }

    entities = stealth_noteworthy_entities(self.origin, level.stealth.noteworthy.callout_radius, undefined, level.stealth.noteworthy.civilians_callout, level.stealth.noteworthy.fakeactors_callout);
    callouts = stealth_noteworthy_callouts_init();
    self_eye = self getEye();

    foreach(ent in entities) {
      if(!isDefined(ent.stealth)) {
        continue;
      }

      if(istrue(ent.stealth.callout_disabled)) {
        continue;
      }

      if(isDefined(ent.stealth.callout_next) && gettime() < ent.stealth.callout_next) {
        continue;
      }

      if(isDefined(level.stealth.noteworthy.callout_func_validator) && !self[[level.stealth.noteworthy.callout_func_validator]](ent)) {
        continue;
      }

      should_trace = distancesquared(self.origin, ent.origin) > level.stealth.noteworthy.callout_proximity_radius * level.stealth.noteworthy.callout_proximity_radius;

      if(should_trace && !stealth_noteworthy_trace(ent stealth_noteworthy_get_eye(), self_eye, ent)) {
        continue;
      }

      if(stealth_noteworthy_visible(ent, should_trace)) {
        ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        continue;
      }

      if(gettime() < level.stealth.noteworthy.callout_next) {
        continue;
      }

      type = stealth_noteworthy_callout_type(ent);

      if(isDefined(type)) {
        entnum = ent getentitynumber();

        if(istrue(level.stealth.noteworthy.callout_civilians)) {
          foreach(existing_ent in callouts.results["all"]) {
            if(existing_ent.team != ent.team && existing_ent.team == "neutral") {
              callouts = stealth_noteworthy_callouts_init();
            }

            break;
          }
        }

        callouts.results["all"][entnum] = ent;
        dist_sq = distancesquared(self.origin, ent.origin);

        if(dist_sq < callouts.closest_dist_sq) {
          callouts.closest_dist_sq = dist_sq;
          callouts.closest_type = type;
        }

        callouts.results[type][entnum] = ent;
      }
    }

    if(isDefined(callouts.closest_type)) {
      type = callouts.closest_type;

      foreach(ent in callouts.results[type]) {
        ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
      }

      level.stealth.noteworthy.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_all;
      var_dad53b1877d9909e = [];

      foreach(ent in callouts.results[type]) {
        var_7720b9932e50148e = stealth_noteworthy_entities(ent.origin, level.stealth.noteworthy.callout_bunch_radius, ent.team, 0, level.stealth.noteworthy.fakeactors_callout);

        foreach(other_ent in var_7720b9932e50148e) {
          if(!isDefined(other_ent.stealth)) {
            continue;
          }

          if(istrue(other_ent.stealth.callout_disabled)) {
            continue;
          }

          var_dad53b1877d9909e[other_ent getentitynumber()] = other_ent;
          other_ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }
      }

      foreach(ent in var_dad53b1877d9909e) {
        callouts.results[type][ent getentitynumber()] = ent;
      }

      stealth_noteworthy_delayed("callout_" + type, callouts.results[type], undefined, 0);
    }
  }
}

function stealth_noteworthy_callouts_init() {
  callouts = spawnStruct();
  callouts.results["left"] = [];
  callouts.results["right"] = [];
  callouts.results["ahead"] = [];
  callouts.results["behind"] = [];
  callouts.results["below"] = [];
  callouts.results["all"] = [];
  callouts.closest_type = undefined;
  callouts.closest_dist_sq = squared(20000);
  return callouts;
}

function stealth_noteworthy_callout_type(ent) {
  type = undefined;
  self_fwd = anglesToForward(self.angles);
  self_right = vectorcross(self_fwd, (0, 0, 1));
  dir = vectorNormalize(ent.origin - self.origin);
  dot_fwd = vectordot(self_fwd, dir);

  if(dot_fwd > 0.7) {
    type = "ahead";
  } else if(dot_fwd < -0.7) {
    type = "behind";
  } else {
    height = ent.origin[2] - self.origin[2];

    if(dot_fwd > 0.7 && height < -100) {
      type = "below";
    } else {
      dot_right = vectordot(self_right, dir);

      if(dot_right < -0.7) {
        type = "left";
      } else if(dot_right > 0.7) {
        type = "right";
      }
    }
  }

  if(isDefined(type) && !istrue(level.stealth.noteworthy.callout_enabled[type])) {
    return undefined;
  }

  return type;
}

function stealth_noteworthy_visible(other, var_88266fd50ecb7909) {
  if(!within_fov(self.origin, self.angles, other.origin, 0.7)) {
    return false;
  }

  eye = self getEye();

  if(stealth_noteworthy_trace(eye, other.origin + (0, 0, 18), other)) {
    return true;
  }

  if(var_88266fd50ecb7909 || stealth_noteworthy_trace(eye, other stealth_noteworthy_get_eye(), other)) {
    return true;
  }

  return false;
}

function stealth_noteworthy_get_eye() {
  eye = self.origin + (0, 0, 50);

  if(issentient(self)) {
    eye = self getEye();
  }

  return eye;
}

function stealth_noteworthy_trace(start, end, ignore_ent) {
  stealth_noteworthy_trace_safety_check();
  return scripts\engine\trace::ray_trace_passed(start, end, [self, ignore_ent], level.stealth.noteworthy.callout_trace_contents);
}

function stealth_noteworthy_trace_safety_check() {
  level.stealth.noteworthy.callout_traces++;

  if(level.stealth.noteworthy.callout_traces > 3) {
    waitframe();
    level.stealth.noteworthy.callout_traces = 1;
  }
}

function ambient_player_thread(var_e80854bc30ef7692, var_e8091311a0985e4, var_bf7eb5daf1c3fc77, var_1e6c1e4bb0511be9) {}

function ambient_candidates(includeradio, includevoice) {
  maxdist = 1000;
  candidates = [];

  if(!includeradio && !includevoice) {
    return candidates;
  }

  if(includeradio && !includevoice && !bctable_exists("stealth", "radio", "convo")) {
    return candidates;
  }

  checklist = getaiarrayinradius(self.origin, maxdist, "axis");
  checklist = array_removeundefined(checklist);

  foreach(enemy in checklist) {
    if(!includeradio && !isalive(enemy)) {
      continue;
    }

    if(!includeradio && (!isDefined(enemy.stealth) || issentient(enemy) && enemy.alertlevel == "combat")) {
      continue;
    }

    if(issentient(enemy) && enemy.ignoreall) {
      continue;
    }

    if(issentient(enemy) && !isDefined(enemy.stealth)) {
      continue;
    }

    if(isDefined(enemy.fnisinstealthidlescriptedanim) && enemy[[enemy.fnisinstealthidlescriptedanim]]()) {
      continue;
    }

    if(isDefined(enemy.fnisinstealthidle) && !istrue(enemy[[enemy.fnisinstealthidle]]())) {
      continue;
    }

    if(enemy.unittype == "dog") {
      continue;
    }

    if(isDefined(enemy.stealth)) {
      if(isDefined(enemy.stealth.vo_next_ambient) && gettime() < enemy.stealth.vo_next_ambient) {
        continue;
      }

      if(isDefined(enemy.stealth.last_sound_time) && gettime() - enemy.stealth.last_sound_time < 10000) {
        continue;
      }

      if(isDefined(enemy.last_severity_time) && gettime() - enemy.last_severity_time < 10000) {
        continue;
      }
    }

    candidates[candidates.size] = enemy;
  }

  candidates = sortbydistance(candidates, self.origin);
  return candidates;
}

function ambient_player_stop() {
  self notify("ambient_player_thread");
}

function sixthsense_init() {
  level.player endon("death");
  level.player.sixthsense = spawnStruct();
  level.player.sixthsense.active = 1;

  setdvarifuninitialized(@ "hash_3a87475a75de0350", 0);

  childthread sixthsense_think();
}

function sixthsense_think() {
  level endon("stop_sixth_sense");

  while(true) {
    waitframe();

    if(!level.player.sixthsense.active) {
      function_21d44d6e55ff1ad2(0, 0);
      continue;
    }

    sixthsense_think_internal();
  }
}

function sixthsense_think_internal() {
  sixthsensedebug = 0;

  sixthsensedebug = getdvarint(@ "hash_3a87475a75de0350");

  process = 0;
  sightmask = 0;
  spottedmask = 0;
  playerpos = level.player getEye();

  if(istrue(level.player.ignoreme) || istrue(level.player.notarget)) {
    return;
  }

  foreach(enemy in getaiarray("bad_guys")) {
    if(process >= 25) {
      process = 0;
      waitframe();
    }

    if(!isalive(enemy)) {
      continue;
    }

    if(!isDefined(enemy.stealth) && !isDefined(enemy.forcesixthsense)) {
      continue;
    }

    if(istrue(enemy.ignoreall)) {
      continue;
    }

    if(distancesquared(enemy.origin, playerpos) > 16000000) {
      continue;
    }

    process += 1;

    if(isDefined(enemy.var_2bccfebe0b2b566)) {
      if(!enemy[[enemy.var_2bccfebe0b2b566]]()) {
        continue;
      }
    } else if(!enemy cansee(level.player)) {
      continue;
    }

    direction = level.player getsixthsensedirection(enemy);

    if(enemy function_6a86dd83c01f8faa() && !isDefined(enemy.forcesixthsense)) {
      spottedmask |= direction;
      continue;
    }

    if(sixthsensedebug) {
      thread draw_line_for_time(enemy getEye(), playerpos, 0, 0, 1, 0.2);
      enemy hudoutlineenable("<dev string:x6e>");
      enemy thread function_e3b8b11bfb019b21(5);
    }

    sightmask |= direction;
  }

  level.player function_21d44d6e55ff1ad2(sightmask, spottedmask);
}

function function_21d44d6e55ff1ad2(sightmask, spottedmask) {
  if(!isDefined(level.player.sixthsense.hud)) {
    hudarray = [];
    hudarray["left"] = newhudelem();
    hudarray["left"] setshader("widg_gradient_left_to_right", 150, 480);
    hudarray["left"].x = 0;
    hudarray["left"].y = 0;
    hudarray["left"].alignx = "left";
    hudarray["left"].aligny = "top";
    hudarray["left"].horzalign = "left";
    hudarray["left"].vertalign = "top";
    hudarray["left"].sort = 0;
    hudarray["left"].alpha = 0;
    hudarray["left"].color = (0.925, 0.519, 0.14);
    hudarray["right"] = newhudelem();
    hudarray["right"] setshader("widg_gradient_right_to_left", 150, 480);
    hudarray["right"].x = 0;
    hudarray["right"].y = 0;
    hudarray["right"].alignx = "right";
    hudarray["right"].aligny = "top";
    hudarray["right"].horzalign = "right";
    hudarray["right"].vertalign = "top";
    hudarray["right"].sort = 0;
    hudarray["right"].alpha = 0;
    hudarray["right"].color = (0.925, 0.519, 0.14);
    hudarray["lower"] = newhudelem();
    hudarray["lower"] setshader("widg_gradient_bottom_to_top", 1280, 150);
    hudarray["lower"].x = 0;
    hudarray["lower"].y = 480;
    hudarray["lower"].alignx = "left";
    hudarray["lower"].aligny = "bottom";
    hudarray["lower"].horzalign = "left";
    hudarray["lower"].vertalign = "top";
    hudarray["lower"].sort = 0;
    hudarray["lower"].alpha = 0;
    hudarray["lower"].color = (0.925, 0.519, 0.14);

    if(getdvarint(@ "hash_82eb856681438f08") == 0) {
      hudarray["upper"] = newhudelem();
      hudarray["upper"] setshader("widg_gradient_top_to_bottom", 1280, 150);
      hudarray["upper"].x = 0;
      hudarray["upper"].y = 0;
      hudarray["upper"].alignx = "left";
      hudarray["upper"].aligny = "top";
      hudarray["upper"].horzalign = "left";
      hudarray["upper"].vertalign = "top";
      hudarray["upper"].sort = 0;
      hudarray["upper"].alpha = 0;
      hudarray["upper"].color = (0.925, 0.519, 0.14);
    }

    level.player.sixthsense.hud = hudarray;
  }

  foreach(dir in getarraykeys(level.player.sixthsense.hud)) {
    active = function_14c8d34a7e2b92c1(dir, sightmask);
    spotted = function_14c8d34a7e2b92c1(dir, spottedmask);

    if(getdvarint(@ "hash_3a810db500922b6c") != 0) {
      function_8736c4028a753995(dir, active, spotted);
    }

    if(isDefined(level.var_28c0d60e971ff699)) {
      [[level.var_28c0d60e971ff699]](dir, active, spotted);
    }

    function_494fda903ef1977c(dir, active, spotted, sightmask, spottedmask);
  }
}

function function_14c8d34a7e2b92c1(dir, mask) {
  consts = [];

  switch (dir) {
    case #"hash_c9b3133a17a3b2d0":
      consts = [128, 32];
      break;
    case #"hash_96815ce4f2a3dbc5":
      consts = [64, 8];
      break;
    case #"hash_1e6b44ab584b8527":
      consts = [4, 2, 1];
      break;
    case #"hash_c325f7340a63499a":
      consts = [16];
      break;
    default:
      assertmsg("SIXTH SENSE: Unrecognized direction " + dir);
      break;
  }

  foreach(constvalue in consts) {
    if(mask &constvalue) {
      return true;
    }
  }

  return false;
}

function function_8736c4028a753995(dir, active, spotted) {
  elem = level.player.sixthsense.hud[dir];
  elem.color = ter_op(spotted, (1, 0.14, 0.519), (0.925, 0.519, 0.14));
  elem fadeovertime(ter_op(active, 1, 3));
  elem.alpha = ter_op(active, 1, 0);
}

function function_494fda903ef1977c(dir, active, spotted, sightmask, spottedmask) {
  if(sightmask > 0) {
    if(spottedmask == 0 && function_eac0cd99c9c6d8ee() != "spotted") {
      if(!isDefined(level.player.var_33df676309c77fc4)) {
        level.player.var_33df676309c77fc4 = gettime();
      }

      if(gettime() >= level.player.var_33df676309c77fc4) {
        level.player.var_33df676309c77fc4 = gettime() + 5000;
        level.player playSound("ui_stealth_threat_hud_periph_vision");
      }
    }
  }

  if(spottedmask > 0) {
    if(!isDefined(level.player.var_80221e9c5627503a)) {
      level.player.var_80221e9c5627503a = gettime();
    }

    if(gettime() >= level.player.var_80221e9c5627503a) {
      level.player.var_80221e9c5627503a = gettime() + 5000;
    }
  }
}

function getsixthsensedirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  forward2d = (forward[0], forward[1], forward[2]);
  forward2d = vectorNormalize(forward2d);
  toenemy = enemy.origin - self.origin;
  toenemy2d = (toenemy[0], toenemy[1], toenemy[2]);
  toenemy2d = vectorNormalize(toenemy2d);
  dot = vectordot(forward2d, toenemy2d);

  if(dot >= 0.92388) {
    return 2;
  }

  if(dot >= 0.5) {
    return ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 4, 1);
  }

  if(dot >= 0.5) {
    return ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 128, 64);
  }

  if(dot >= -0.707107) {
    return ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 32, 8);
  }

  return 16;
}