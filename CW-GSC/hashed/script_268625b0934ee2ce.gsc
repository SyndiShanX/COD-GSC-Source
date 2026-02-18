/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_268625b0934ee2ce.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter_table;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\util_shared;
#namespace player;

function scalevolume(ent, vol) {}

#namespace stealth_player;

function stealth_noteworthy_thread(enabled, callouts) {
  self notify(#"stealth_noteworthy_thread");

  if(!isDefined(enabled)) {
    enabled = 1;
  }

  if(!enabled) {
    return;
  }

  self endoncallback(&function_19d52da4, #"stealth_noteworthy_thread", #"disconnect");
  assert(isPlayer(self));

  while(!isDefined(self.stealth)) {
    wait 1;
  }

  callback::on_ai_killed(&function_3a7a5076);
  stealth_noteworthy_init();

  self thread function_1e099116();

  if(!isDefined(self.stealth.stealth_noted)) {
    self.stealth.stealth_noted = [];
  }

  self childthread stealth_noteworthy_kill_monitor();

  if(is_true(callouts)) {
    self childthread stealth_noteworthy_callouts(1);
  }

  contents = stealth_noteworthy_aim_contents();

  while(true) {
    level flag::wait_till("stealth_enabled");
    level flag::wait_till_clear("stealth_spotted");
    bestdot = -1;
    var_17280c7c = undefined;

    if(self playerads() > level.stealth.noteworthy.stealth_noteworthy_min_ads) {
      eye = self getplayercamerapos();
      eye_dir = anglesToForward(self getplayerangles());
      targets = stealth_noteworthy_entities(self.origin, 20000, "axis", level.stealth.noteworthy.civilians_aim, level.stealth.noteworthy.fakeactors_aim);

      foreach(tgt in targets) {
        entnum = tgt getentitynumber();

        if(isDefined(self.stealth.stealth_noted[entnum])) {
          continue;
        }

        tgteye = tgt stealth_noteworthy_get_eye();
        dir = vectornormalize(tgteye - eye);
        dot = vectordot(eye_dir, dir);

        if(dot > level.stealth.noteworthy.stealth_noteworthy_min_dot && dot > bestdot) {
          if(sighttracepassed(tgteye, eye, 0, self)) {
            bestdot = dot;
            var_17280c7c = tgt;
          }
        }
      }

      if(isDefined(var_17280c7c)) {
        self thread stealth_noteworthy_delayed("aim", var_17280c7c);
      }

      foreach(entnum, ent in self.stealth.stealth_noted) {
        if(!isDefined(self.stealth.stealth_noted[entnum])) {
          self.stealth.stealth_noted[entnum] = undefined;
        }
      }
    }

    waitframe(1);
  }
}

function private function_19d52da4(parm) {
  callback::remove_on_ai_killed(&function_3a7a5076);
}

function private stealth_noteworthy_init() {
  if(isDefined(level.stealth.noteworthy)) {
    return;
  }

  function_5ac4dc99("<dev string:x38>", 0);

  level.stealth.noteworthy = spawnStruct();
  level.stealth.noteworthy.priority_func = &stealth_noteworthy_priority;
  level.stealth.noteworthy.stealth_noteworthy_min_ads = 0.3;
  level.stealth.noteworthy.stealth_noteworthy_min_dot = 0.99;
  level.stealth.noteworthy.stealth_noteworthy_min_delay = 0.25;
  level.stealth.noteworthy.stealth_noteworthy_max_delay = 0.5;
  level.stealth.noteworthy.callout_enabled = [];
  level.stealth.noteworthy.callout_enabled[# "left"] = 1;
  level.stealth.noteworthy.callout_enabled[# "right"] = 1;
  level.stealth.noteworthy.callout_enabled[# "ahead"] = 0;
  level.stealth.noteworthy.callout_enabled[# "behind"] = 1;
  level.stealth.noteworthy.callout_enabled[# "below"] = 1;
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
  level.stealth.noteworthy.callout_traces = 0;
  level.stealth.noteworthy.callout_spotted = 0;
}

function private stealth_noteworthy_kill_monitor() {
  assert(isPlayer(self));
  killedquickly = 0;
  kills = undefined;

  while(true) {
    kills = self.stats[# "kills"];

    if(!isDefined(kills)) {
      kills = 0;
    }

    lastkillcount = kills;
    lastkilltime = gettime();
    level flag::wait_till("stealth_enabled");
    level flag::wait_till_clear("stealth_spotted");
    wait_result = level waittill(#"ai_killed");
    victim = wait_result.evictim;
    attacker = wait_result.eattacker;
    meansofdeath = wait_result.smeansofdeath;
    weapon = wait_result.weapon;

    if(isDefined(attacker) && attacker != self) {
      continue;
    }

    if(!level flag::get("stealth_enabled") || level flag::get("stealth_spotted")) {
      continue;
    }

    if(isDefined(victim) && isDefined(victim.team) && victim.team != "axis") {
      self thread stealth_noteworthy_delayed("civilian_kill", victim);
    }

    kills = self.stats[# "kills"];

    if(!isDefined(kills)) {
      kills = 1;
    }

    deltakills = kills - lastkillcount;

    if(gettime() - lastkilltime > 1000) {
      killedquickly = 0;
    }

    isbullet = isDefined(weapon) && weapon.isbulletweapon;

    if(deltakills >= 2 && isbullet) {
      self thread stealth_noteworthy_delayed("good_kill_double", victim, 1);
    }

    killedquickly += deltakills;

    if(killedquickly > 1) {
      self thread stealth_noteworthy_delayed("good_kill_impressive", victim, 1);
      continue;
    }

    if(isbullet) {
      self thread stealth_noteworthy_delayed("good_kill_bullet", victim, 1);
      continue;
    }

    self thread stealth_noteworthy_delayed("good_kill", victim, 1);
  }
}

function private function_3a7a5076(var_854423c5) {
  var_854423c5.evictim = self;
  level notify(#"ai_killed", var_854423c5);
}

function private stealth_noteworthy_delayed(eventname, target, var_78a2f9b6, delay) {
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

  self notify(#"stealth_noteworthy_delayed");
  self endon(#"stealth_noteworthy_delayed");
  self endon(#"disconnect");

  if(is_true(var_78a2f9b6) && isDefined(self.stealth.maxalertlevel)) {
    self.stealth.stealth_note_start_alert = self.stealth.maxalertlevel;
  }

  if(!isDefined(delay)) {
    delay = randomfloatrange(level.stealth.noteworthy.stealth_noteworthy_min_delay, level.stealth.noteworthy.stealth_noteworthy_max_delay);
  }

  if(delay > 0) {
    wait delay;
  }

  function_1eaaceab(self.stealth.stealth_note_pending_targets);

  if(is_true(var_78a2f9b6) && isDefined(self.stealth.maxalertlevel) && self.stealth.stealth_note_start_alert < self.stealth.maxalertlevel) {
    self.stealth.stealth_note_pending = undefined;
    self.stealth.stealth_note_pending_targets = undefined;
    return;
  }

  if(eventname == "aim") {
    eye = self getplayercamerapos();
    eye_dir = anglesToForward(self getplayerangles());
    contents = stealth_noteworthy_aim_contents();

    foreach(ent in self.stealth.stealth_note_pending_targets) {
      tgteye = ent stealth_noteworthy_get_eye();
      dir = vectornormalize(tgteye - eye);
      dot = vectordot(eye_dir, dir);

      if(dot < level.stealth.noteworthy.stealth_noteworthy_min_dot || !sighttracepassed(tgteye, eye, 0, self)) {
        self.stealth.stealth_note_pending = undefined;
        self.stealth.stealth_note_pending_targets = undefined;
        return;
      }
    }

    foreach(target in self.stealth.stealth_note_pending_targets) {
      self.stealth.stealth_noted[target getentitynumber()] = target;
    }
  }

  self notify("stealth_noteworthy", {
    #event: eventname, #targets: self.stealth.stealth_note_pending_targets
  });
  self.stealth.stealth_note_pending = undefined;
  self.stealth.stealth_note_pending_targets = undefined;
}

function private stealth_noteworthy_priority(eventname) {
  if(!isDefined(eventname)) {
    return -1;
  }

  switch (eventname) {
    case # "civilian_kill":
      return 70;
    case # "good_kill_double":
      return 60;
    case # "good_kill_impressive":
      return 50;
    case # "good_kill_bullet":
      return 40;
    case # "good_kill":
      return 30;
    case # "aim":
      return 20;
    case # "callout_ahead":
    case # "callout_below":
    case # "callout_right":
    case # "callout_left":
    case # "callout_behind":
      return 10;
  }

  return 0;
}

function private function_1e099116() {
  while(true) {
    wait_result = getplayers()[0] waittill("<dev string:x54>");
    eventname = wait_result.event;
    subjectlist = wait_result.targets;

    if(getdvarint(#"hash_3ca672bc9412d156")) {
      foreach(subject in subjectlist) {
        if(isDefined(subject)) {
          iprintln("<dev string:x6a>" + eventname + "<dev string:x83>" + subject getentitynumber());
          continue;
        }

        iprintln("<dev string:x6a>" + eventname + "<dev string:x8a>");
      }
    }
  }
}

function private stealth_noteworthy_aim_contents() {}

function private stealth_noteworthy_entities(origin, radius, team = "axis", civilians, fakeactors) {
  if(is_true(civilians)) {
    entities = function_e45cbe76(origin, radius, team, "neutral");
  } else {
    entities = function_e45cbe76(origin, radius, team);
  }

  function_1eaaceab(entities);

  if(is_true(fakeactors)) {
    var_33ed2ca8 = [];

    foreach(fake_actor in var_33ed2ca8) {
      if(isDefined(fake_actor.team) && (fake_actor.team == team || is_true(civilians) && fake_actor.team == "neutral")) {
        entities[entities.size] = fake_actor;
      }
    }
  }

  return entities;
}

function stealth_noteworthy_callouts(enabled) {
  self notify(#"stealth_noteworthy_callouts");
  self endon(#"stealth_noteworthy_callouts");

  if(!is_true(enabled)) {
    return;
  }

  level.stealth.noteworthy.callout_next = 0;

  while(true) {
    wait 0.5;
    level flag::wait_till("stealth_enabled");

    if(!level.stealth.noteworthy.callout_spotted) {
      level flag::wait_till_clear("stealth_spotted");
    }

    entities = stealth_noteworthy_entities(self.origin, level.stealth.noteworthy.callout_radius, undefined, level.stealth.noteworthy.civilians_callout, level.stealth.noteworthy.fakeactors_callout);
    callouts = stealth_noteworthy_callouts_init();
    self_eye = self getplayercamerapos();

    foreach(ent in entities) {
      if(!isDefined(ent.stealth)) {
        continue;
      }

      if(is_true(ent.stealth.callout_disabled)) {
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

      if(self stealth_noteworthy_visible(ent, should_trace)) {
        ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        continue;
      }

      if(gettime() < level.stealth.noteworthy.callout_next) {
        continue;
      }

      type = self stealth_noteworthy_callout_type(ent);

      if(isDefined(type)) {
        entnum = ent getentitynumber();

        if(is_true(level.stealth.noteworthy.callout_civilians)) {
          foreach(existing_ent in callouts.results[# "all"]) {
            if(existing_ent.team != ent.team && existing_ent.team == "neutral") {
              callouts = stealth_noteworthy_callouts_init();
            }

            break;
          }
        }

        callouts.results[# "all"][entnum] = ent;
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
      var_2a0b59fb = [];

      foreach(ent in callouts.results[type]) {
        var_d853ee3f = stealth_noteworthy_entities(ent.origin, level.stealth.noteworthy.callout_bunch_radius, ent.team, 0, level.stealth.noteworthy.fakeactors_callout);

        foreach(other_ent in var_d853ee3f) {
          var_2a0b59fb[other_ent getentitynumber()] = other_ent;
          other_ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }
      }

      foreach(ent in var_2a0b59fb) {
        callouts.results[type][ent getentitynumber()] = ent;
      }

      self stealth_noteworthy_delayed("callout_" + type, callouts.results[type], undefined, 0);
    }
  }
}

function private stealth_noteworthy_callouts_init() {
  callouts = spawnStruct();
  callouts.results[# "left"] = [];
  callouts.results[# "right"] = [];
  callouts.results[# "ahead"] = [];
  callouts.results[# "behind"] = [];
  callouts.results[# "below"] = [];
  callouts.results[# "all"] = [];
  callouts.closest_type = undefined;
  callouts.closest_dist_sq = sqr(20000);
  return callouts;
}

function private stealth_noteworthy_callout_type(ent) {
  type = undefined;
  self_fwd = anglesToForward(self.angles);
  self_right = vectorcross(self_fwd, (0, 0, 1));
  dir = vectornormalize(ent.origin - self.origin);
  dot_fwd = vectordot(self_fwd, dir);

  if(dot_fwd > 0.7) {
    type = "ahead";
  } else if(dot_fwd < -0.6) {
    type = "behind";
  } else {
    height = ent.origin[2] - self.origin[2];

    if(dot_fwd > 0 && height < -100) {
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

  if(isDefined(type) && !is_true(level.stealth.noteworthy.callout_enabled[type])) {
    return undefined;
  }

  return type;
}

function private stealth_noteworthy_visible(other, var_5958f865) {
  if(!util::within_fov(self.origin, self.angles, other.origin, 0.7)) {
    return false;
  }

  eye = self getEye();

  if(isPlayer(self)) {
    eye = self getplayercamerapos();
  }

  if(stealth_noteworthy_trace(eye, other.origin, other)) {
    return true;
  }

  if(var_5958f865 || stealth_noteworthy_trace(eye, other stealth_noteworthy_get_eye(), other)) {
    return true;
  }

  return false;
}

function private stealth_noteworthy_get_eye() {
  eye = self.origin + (0, 0, 50);

  if(isPlayer(self)) {
    eye = self getplayercamerapos();
  } else if(issentient(self)) {
    eye = self getEye();
  }

  return eye;
}

function private stealth_noteworthy_trace(start, end, ignore_ent) {
  level.stealth.noteworthy.callout_traces++;

  if(level.stealth.noteworthy.callout_traces > 3) {
    waitframe(1);
    level.stealth.noteworthy.callout_traces = 1;
  }

  return sighttracepassed(start, end, 0, self, ignore_ent);
}

function ambient_player_thread(var_bfd9f922, var_ececce87, var_d572c578, var_4fb611ad) {
  assert(isPlayer(self));
  self notify(#"ambient_player_thread");
  self endon(#"ambient_player_thread", #"disconnect");

  if(!isDefined(var_bfd9f922)) {
    var_bfd9f922 = 10;
  }

  if(!isDefined(var_ececce87)) {
    var_ececce87 = 15;
  }

  if(!isDefined(var_d572c578)) {
    var_d572c578 = 20;
  }

  if(!isDefined(var_4fb611ad)) {
    var_4fb611ad = 40;
  }

  level.stealth.candidatesvoice = [];

  while(true) {
    if(!isalive(self)) {
      waitframe(1);
      continue;
    }

    self flag::wait_till("stealth_enabled");

    if(level.stealth.candidatesvoice.size == 0) {
      wait 1;
    } else {
      wait randomfloatrange(var_bfd9f922, var_ececce87);
    }

    if(level flag::get("stealth_spotted")) {
      continue;
    }

    level.stealth.candidatesvoice = self ambient_candidates(0, 1);

    if(level.stealth.candidatesvoice.size > 0) {
      speaker = level.stealth.candidatesvoice[0];
      type = "idle";

      if(isDefined(speaker.demeanoroverride) && speaker.demeanoroverride == "alert") {
        type = "idle_alert";
      }

      speaker thread namespace_979752dc::addeventplaybcs("stealth", type);
      speaker.stealth.vo_next_ambient = gettime() + randomfloatrange(var_d572c578, var_4fb611ad) * 1000;
    }
  }
}

function private ambient_candidates(includeradio, includevoice) {
  maxdist = 1000;
  candidates = [];

  if(!includeradio && !includevoice) {
    return candidates;
  }

  if(includeradio && !includevoice && !battlechatter_table::exists("stealth", "radio", "convo")) {
    return candidates;
  }

  checklist = function_e45cbe76(self.origin, maxdist, "axis");

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

    if(enemy isinscriptedstate()) {
      continue;
    }

    if(isDefined(enemy.fnisinstealthidle) && !is_true(enemy[[enemy.fnisinstealthidle]]())) {
      continue;
    }

    if(enemy.species == "dog") {
      continue;
    }

    if(isDefined(enemy.stealth)) {
      if(isDefined(enemy.stealth.vo_next_ambient) && gettime() < enemy.stealth.vo_next_ambient) {
        continue;
      }

      if(isDefined(enemy.stealth.last_sound_time) && gettime() - enemy.stealth.last_sound_time < 10000) {
        continue;
      }

      if(isDefined(enemy.stealth.last_severity_time) && gettime() - enemy.stealth.last_severity_time < 10000) {
        continue;
      }
    }

    candidates[candidates.size] = enemy;
  }

  candidates = arraysortclosest(candidates, self.origin);
  return candidates;
}

function ambient_player_stop() {
  self notify(#"ambient_player_thread");
}