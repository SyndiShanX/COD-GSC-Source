/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\stealth\player.gsc
*****************************************/

#using scripts\anim\battlechatter_table;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace namespace_5a0f99556b0f68f7;

function stealth_noteworthy_thread(enabled, callouts, goodkilldelaysec = 30) {
  self notify("6\xd9\xc9a\xd5\xc5h\xe8U\x81l\x96:\x03v@Kn\x10\xe8\xaai\x1ac\xfc");

  if(!isDefined(enabled)) {
    enabled = 1;
  }

  if(!enabled) {
    return;
  }

  self endon("6\xd9\xc9a\xd5\xc5h\xe8U\x81l\x96:\x03v@Kn\x10\xe8\xaai\x1ac\xfc");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  assert(isPlayer(self));

  while(!isDefined(self.stealth)) {
    wait 1;
  }

  stealth_noteworthy_init();

  thread function_a9ec991d227436ff();

  if(!isDefined(self.stealth.stealth_noted)) {
    self.stealth.stealth_noted = [];
  }

  childthread stealth_noteworthy_kill_monitor(goodkilldelaysec);

  if(istrue(callouts)) {
    childthread stealth_noteworthy_callouts(1);
  }

  contents = stealth_noteworthy_aim_contents();

  while(true) {
    utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    utility::flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
    bestdot = -1;
    besttgt = undefined;

    if(self playerads() > level.stealth.noteworthy.stealth_noteworthy_min_ads && function_e1657736c751247c()) {
      eye = self getEye();
      eye_dir = anglesToForward(self getplayerangles());
      targets = stealth_noteworthy_entities(self.origin, 20000, "?\xb1\xc0\x9a", level.stealth.noteworthy.civilians_aim, level.stealth.noteworthy.fakeactors_aim);

      foreach(tgt in targets) {
        entnum = tgt getentitynumber();

        if(isDefined(self.stealth.stealth_noted[entnum])) {
          continue;
        }

        tgteye = tgt stealth_noteworthy_get_eye();
        dir = vectorNormalize(tgteye - eye);
        dot = vectordot(eye_dir, dir);

        if(dot > level.stealth.noteworthy.stealth_noteworthy_min_dot && dot > bestdot) {
          if(trace::ray_trace_passed(tgteye, eye, undefined, contents)) {
            bestdot = dot;
            besttgt = tgt;
          }
        }
      }

      if(isDefined(besttgt)) {
        thread stealth_noteworthy_delayed("\xb5\x10\xb9", besttgt);
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
  level.stealth.noteworthy.callout_enabled["=\xff0b"] = 1;
  level.stealth.noteworthy.callout_enabled["o0\xee\xc1\x8c"] = 1;
  level.stealth.noteworthy.callout_enabled[">\x8b\x9fe\xcb"] = 0;
  level.stealth.noteworthy.callout_enabled["&\x95\x1aKn\x91"] = 1;
  level.stealth.noteworthy.callout_enabled["\x1eU\x83\xd8\xd7"] = 1;
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
  level.stealth.noteworthy.callout_trace_contents = trace::create_ainosight_contents();
  level.stealth.noteworthy.callout_traces = 0;
  level.stealth.noteworthy.callout_spotted = 0;
  level utility::flag_set("\x89\xc34\x9b\x05Q\x04\x12\xac\xb3\xd4\x1a\x83\xc1T\f\xa7\xd7wM\x03\xcb-\xfb\xe0");
}

function function_e1657736c751247c() {
  current_weapon_name = self getcurrentweapon().basename;

  if(isDefined(current_weapon_name) && isDefined(level.stealth.noteworthy.var_563465d446c001cf)) {
    foreach(weapon_name in level.stealth.noteworthy.var_563465d446c001cf) {
      if(weapon_name == current_weapon_name) {
        return false;
      }
    }
  }

  return true;
}

function function_2da0f17e6869b878(weaponname) {
  assert(isDefined(level.stealth) && isDefined(level.stealth.noteworthy));

  if(!isDefined(level.stealth.noteworthy.var_563465d446c001cf)) {
    level.stealth.noteworthy.var_563465d446c001cf = [];
  }

  level.stealth.noteworthy.var_563465d446c001cf[level.stealth.noteworthy.var_563465d446c001cf.size] = weaponname;
}

function stealth_noteworthy_kill_monitor(goodkilldelaysec = 30) {
  assert(isPlayer(self));
  killedquickly = 0;
  kills = undefined;
  goodkilldelayms = goodkilldelaysec * 1000;
  nextgoodkill = 0;

  while(true) {
    kills = self.stats["E\xb9\xf4j\x0f"];

    if(!isDefined(kills)) {
      kills = 0;
    }

    lastkillcount = kills;
    lastkilltime = gettime();
    utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    utility::flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
    level waittill("[G=mX\xeb\\\xd7\x05", victim, attacker, meansofdeath, weapon);

    if(!isDefined(attacker) || attacker != self) {
      continue;
    }

    if(!utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") || utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
      continue;
    }

    if(isDefined(victim) && isDefined(victim.team) && victim.team != "?\xb1\xc0\x9a") {
      thread stealth_noteworthy_delayed("@\xc6\xf3\xe9\xea\xa7\xaa\x9e\xdd\xe2\x8c]p", victim);
    }

    kills = self.stats["E\xb9\xf4j\x0f"];

    if(!isDefined(kills)) {
      kills = 1;
    }

    deltakills = kills - lastkillcount;

    if(gettime() - lastkilltime > 1000) {
      killedquickly = 0;
    }

    isbullet = isDefined(weapon) && weapontype(weapon) == "\xd7\xdb\xaaU\x82\xb0";

    if(deltakills >= 2 && isbullet) {
      thread stealth_noteworthy_delayed("5\xbd\x01\x92\x80\xd7\x8eJ(\xd6\x16Y\x06+\x12<", victim, 1);
    }

    killedquickly += deltakills;

    if(killedquickly > 1) {
      thread stealth_noteworthy_delayed("\x95\x90\x18s\x10\xb1Z\x1a\xfb\xde\xf8\x16t\x1b\xe1\x15\x11X\xfb\xd6", victim, 1);
      continue;
    }

    if(lastkilltime > nextgoodkill) {
      nextgoodkill = lastkilltime + goodkilldelayms;

      if(isbullet) {
        thread stealth_noteworthy_delayed("\xa1?n ^\x98P\x182\x14&F,j\xca\\", victim, 1);
        continue;
      }

      thread stealth_noteworthy_delayed("3\x91\\\x12#b\xc8\xf7\xa6", victim, 1);
    }
  }
}

function stealth_noteworthy_delayed(eventname, target, var_eb2b4fe4f46d36fb, delay) {
  if(!(isDefined(level.stealth) && isDefined(self.stealth) && isDefined(level.stealth.noteworthy))) {
    return;
  }

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

    if(eventname == "\xb5\x10\xb9") {
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

  self notify("\x10\x9e\x9fm\x01\xdc\f\xf5@\xf5\x8d\xbc\x87\xa9\xbd*\xc2w\xa739\xe5\xf8\x8dC\xf2");
  self endon("\x10\x9e\x9fm\x01\xdc\f\xf5@\xf5\x8d\xbc\x87\xa9\xbd*\xc2w\xa739\xe5\xf8\x8dC\xf2");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  stealthmaxalertlevel = function_6a6f5b005f046081(self);

  if(istrue(var_eb2b4fe4f46d36fb)) {
    self.stealth.stealth_note_start_alert = stealthmaxalertlevel;
  }

  if(!isDefined(delay)) {
    delay = randomfloatrange(level.stealth.noteworthy.stealth_noteworthy_min_delay, level.stealth.noteworthy.stealth_noteworthy_max_delay);
  }

  if(delay > 0) {
    wait delay;
  }

  if(isstartstr(eventname, "3\x91\\\x12#b\xc8\xf7\xa6")) {
    self.stealth.stealth_note_pending_targets = utility::array_combine(self.stealth.stealth_note_pending_targets);
  } else {
    self.stealth.stealth_note_pending_targets = utility::array_removedead_or_dying(self.stealth.stealth_note_pending_targets);
  }

  stealthmaxalertlevel = function_6a6f5b005f046081(self);

  if(istrue(var_eb2b4fe4f46d36fb) && self.stealth.stealth_note_start_alert < stealthmaxalertlevel) {
    self.stealth.stealth_note_pending = undefined;
    self.stealth.stealth_note_pending_targets = undefined;
    return;
  }

  if(eventname == "\xb5\x10\xb9") {
    eye = self getEye();
    eye_dir = anglesToForward(self getplayerangles());
    contents = stealth_noteworthy_aim_contents();

    foreach(ent in self.stealth.stealth_note_pending_targets) {
      tgteye = ent stealth_noteworthy_get_eye();
      dir = vectorNormalize(tgteye - eye);
      dot = vectordot(eye_dir, dir);

      if(dot < level.stealth.noteworthy.stealth_noteworthy_min_dot || !trace::ray_trace_passed(tgteye, eye, undefined, contents)) {
        self.stealth.stealth_note_pending = undefined;
        self.stealth.stealth_note_pending_targets = undefined;
        return;
      }
    }

    foreach(target in self.stealth.stealth_note_pending_targets) {
      self.stealth.stealth_noted[target getentitynumber()] = target;
    }
  }

  self notify("\x9c\xbb\xfc\x83\"\x02n'{\x03GN\xe4\xa4*\x10\xc8\xa6", eventname, self.stealth.stealth_note_pending_targets);
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

function function_a9ec991d227436ff() {
  while(true) {
    level.player waittill("<dev string:x24>", eventname, subjectlist);

    if(getdvarint(@ "hash_8434b3949f1e535d")) {
      foreach(subject in subjectlist) {
        if(isDefined(subject)) {
          iprintln("<dev string:x3a>" + eventname + "<dev string:x53>" + subject getentitynumber());
          continue;
        }

        iprintln("<dev string:x3a>" + eventname + "<dev string:x5a>");
      }
    }
  }
}

function function_38ecc052c4f58544(timeout) {
  self endon("<dev string:x71>");
  level endon("<dev string:x7a>");

  while(isDefined(self) && self getthreatsight(level.player) > 0) {
    waitframe();
  }

  if(isDefined(timeout)) {
    wait timeout;
  }

  self hudoutlinedisable();
}

function stealth_noteworthy_aim_contents() {
  return trace::create_contents(0, 1, 0, 1, 0, 1);
}

function stealth_noteworthy_entities(origin, radius, team, civilians, fakeactors) {
  if(!isDefined(team)) {
    team = "?\xb1\xc0\x9a";
  }

  if(istrue(civilians)) {
    entities = getaiarrayinradius(origin, radius, team, "\xba\xa5\x1f\xc9m\x80i");
  } else {
    entities = getaiarrayinradius(origin, radius, team);
  }

  entities = utility::array_removedead_or_dying(entities);

  if(istrue(fakeactors)) {
    var_931a9c3f506ffdfe = getfakeaiarrayinradius(origin, radius);

    foreach(fake_actor in var_931a9c3f506ffdfe) {
      if(isDefined(fake_actor.team) && (fake_actor.team == team || istrue(civilians) && fake_actor.team == "\xba\xa5\x1f\xc9m\x80i")) {
        entities[entities.size] = fake_actor;
      }
    }
  }

  return entities;
}

function stealth_noteworthy_callouts(enabled) {
  self notify("\xd7\x9f\xf8\xcfc5Cv<\xba\x10\xe9\xaf\xf7\xdc\x88\xfd\x86W\x9ac\xad\xe9@\xee&\xbb");
  self endon("\xd7\x9f\xf8\xcfc5Cv<\xba\x10\xe9\xaf\xf7\xdc\x88\xfd\x86W\x9ac\xad\xe9@\xee&\xbb");

  if(!istrue(enabled)) {
    return;
  }

  level.stealth.noteworthy.callout_next = 0;

  while(true) {
    wait 0.5;
    utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");

    if(!level.stealth.noteworthy.callout_spotted) {
      utility::flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
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
          foreach(existing_ent in callouts.results["\xc0\xc6J"]) {
            if(existing_ent.team != ent.team && existing_ent.team == "\xba\xa5\x1f\xc9m\x80i") {
              callouts = stealth_noteworthy_callouts_init();
            }

            break;
          }
        }

        callouts.results["\xc0\xc6J"][entnum] = ent;
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
      var_2875a0d5b72c2a5b = [];

      foreach(ent in callouts.results[type]) {
        var_e9d6b87c3f12fda3 = stealth_noteworthy_entities(ent.origin, level.stealth.noteworthy.callout_bunch_radius, ent.team, 0, level.stealth.noteworthy.fakeactors_callout);

        foreach(other_ent in var_e9d6b87c3f12fda3) {
          if(!isDefined(other_ent.stealth)) {
            continue;
          }

          if(istrue(other_ent.stealth.callout_disabled)) {
            continue;
          }

          var_2875a0d5b72c2a5b[other_ent getentitynumber()] = other_ent;
          other_ent.stealth.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }
      }

      foreach(ent in var_2875a0d5b72c2a5b) {
        callouts.results[type][ent getentitynumber()] = ent;
      }

      stealth_noteworthy_delayed("a\\\tT\x80\xd6\xe3<" + type, callouts.results[type], undefined, 0);
    }
  }
}

function stealth_noteworthy_callouts_init() {
  callouts = spawnStruct();
  callouts.results["=\xff0b"] = [];
  callouts.results["o0\xee\xc1\x8c"] = [];
  callouts.results[">\x8b\x9fe\xcb"] = [];
  callouts.results["&\x95\x1aKn\x91"] = [];
  callouts.results["\x1eU\x83\xd8\xd7"] = [];
  callouts.results["\xc0\xc6J"] = [];
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
    type = ">\x8b\x9fe\xcb";
  } else if(dot_fwd < -0.7) {
    type = "&\x95\x1aKn\x91";
  } else {
    height = ent.origin[2] - self.origin[2];

    if(dot_fwd > 0.7 && height < -100) {
      type = "\x1eU\x83\xd8\xd7";
    } else {
      dot_right = vectordot(self_right, dir);

      if(dot_right < -0.7) {
        type = "=\xff0b";
      } else if(dot_right > 0.7) {
        type = "o0\xee\xc1\x8c";
      }
    }
  }

  if(isDefined(type) && !istrue(level.stealth.noteworthy.callout_enabled[type])) {
    return undefined;
  }

  return type;
}

function stealth_noteworthy_visible(other, var_d68c2b881f6cd070) {
  if(!utility::within_fov(self.origin, self.angles, other.origin, 0.7)) {
    return false;
  }

  eye = self getEye();

  if(stealth_noteworthy_trace(eye, other.origin + (0, 0, 18), other)) {
    return true;
  }

  if(var_d68c2b881f6cd070 || stealth_noteworthy_trace(eye, other stealth_noteworthy_get_eye(), other)) {
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
  return trace::ray_trace_passed(start, end, [self, ignore_ent], level.stealth.noteworthy.callout_trace_contents);
}

function stealth_noteworthy_trace_safety_check() {
  level.stealth.noteworthy.callout_traces++;

  if(level.stealth.noteworthy.callout_traces > 3) {
    waitframe();
    level.stealth.noteworthy.callout_traces = 1;
  }
}

function ambient_player_thread(var_165fe7d09cae9be3, var_2bc85dba3509cfbd, var_ea1026bfc5afb662, var_5c180750d826746c) {}

function ambient_candidates(includeradio, includevoice) {
  maxdist = 1000;
  candidates = [];

  if(!includeradio && !includevoice) {
    return candidates;
  }

  if(includeradio && !includevoice && !battlechatter_table::bctable_exists("\x12\xc2\xc8\x9d-\x1d\x9b", "\x1a[\xae\x81a", "j=\xca\xd1X")) {
    return candidates;
  }

  checklist = getaiarrayinradius(self.origin, maxdist, "?\xb1\xc0\x9a");
  checklist = utility::array_removeundefined(checklist);

  foreach(enemy in checklist) {
    if(!includeradio && !isalive(enemy)) {
      continue;
    }

    if(!includeradio && (!isDefined(enemy.stealth) || issentient(enemy) && enemy.alertlevel == "\xe3\xd0\xc3e\x85h")) {
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

    if(enemy.unittype == "\xde\x9d\xa5") {
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
  self notify("\x1d\bX\xaa\xb5L}Fm\xc6\xb3m5dIy\xab\x82\xe1d\xc0");
}

function sixthsense_init() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player.sixthsense = spawnStruct();
  level.player.sixthsense.active = 1;

  setdvarifuninitialized(@ "hash_3a87475a75de0350", 0);

  childthread sixthsense_think();
}

function sixthsense_think() {
  level endon("G\x16\x15\xb8\x13\x8d\xb0\xe6\b\xfc/\xad\xc7\xf90D");

  while(true) {
    waitframe();

    if(!level.player.sixthsense.active) {
      sixthsense_updatehud(0, 0);
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

  foreach(enemy in getaiarray("\x9a\x1f\x83\x1bs=\x13\xf8")) {
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

    if(isDefined(enemy.fnsixthsensecansee)) {
      if(!enemy[[enemy.fnsixthsensecansee]]()) {
        continue;
      }
    } else if(!enemy cansee(level.player)) {
      continue;
    }

    direction = level.player getsixthsensedirection(enemy);

    if(enemy utility::function_4c52c2d0a7b596cf() && !isDefined(enemy.forcesixthsense)) {
      spottedmask |= direction;
      continue;
    }

    if(sixthsensedebug) {
      thread utility::draw_line_for_time(enemy getEye(), playerpos, 0, 0, 1, 0.2);
      enemy hudoutlineenable("<dev string:x88>");
      enemy thread function_38ecc052c4f58544(5);
    }

    sightmask |= direction;
  }

  level.player sixthsense_updatehud(sightmask, spottedmask);
}

function sixthsense_updatehud(sightmask, spottedmask) {
  if(!isDefined(level.player.sixthsense.hud)) {
    hudarray = [];
    hudarray["=\xff0b"] = newhudelem();
    hudarray["=\xff0b"] setshader("\x01d\xd8\x91\xec\xb8\xc7\xe2\x96uF\xac\x1f\xb0FP\xb3J\xce\xf7OX\x98\xe9\xd4T\x1a", 150, 480);
    hudarray["=\xff0b"].x = 0;
    hudarray["=\xff0b"].y = 0;
    hudarray["=\xff0b"].alignx = "=\xff0b";
    hudarray["=\xff0b"].aligny = "\x1d Q";
    hudarray["=\xff0b"].horzalign = "=\xff0b";
    hudarray["=\xff0b"].vertalign = "\x1d Q";
    hudarray["=\xff0b"].sort = 0;
    hudarray["=\xff0b"].alpha = 0;
    hudarray["=\xff0b"].color = (0.925, 0.519, 0.14);
    hudarray["o0\xee\xc1\x8c"] = newhudelem();
    hudarray["o0\xee\xc1\x8c"] setshader(":\xe5\xfcu\xa9\xc1\xfc\x94\xe0\x90-\x86\xcc4\b\f1\xf4\x95\x03\xb2\xf4\xb7\x186-0", 150, 480);
    hudarray["o0\xee\xc1\x8c"].x = 0;
    hudarray["o0\xee\xc1\x8c"].y = 0;
    hudarray["o0\xee\xc1\x8c"].alignx = "o0\xee\xc1\x8c";
    hudarray["o0\xee\xc1\x8c"].aligny = "\x1d Q";
    hudarray["o0\xee\xc1\x8c"].horzalign = "o0\xee\xc1\x8c";
    hudarray["o0\xee\xc1\x8c"].vertalign = "\x1d Q";
    hudarray["o0\xee\xc1\x8c"].sort = 0;
    hudarray["o0\xee\xc1\x8c"].alpha = 0;
    hudarray["o0\xee\xc1\x8c"].color = (0.925, 0.519, 0.14);
    hudarray[":\x85?\x96L"] = newhudelem();
    hudarray[":\x85?\x96L"] setshader("!\xa4\x1a\xf8:_\xa9p-\x9e\xc9k5Q\x1e\x13\xbcN\xd0\xc0x\xe7+p y\xf7", 1280, 150);
    hudarray[":\x85?\x96L"].x = 0;
    hudarray[":\x85?\x96L"].y = 480;
    hudarray[":\x85?\x96L"].alignx = "=\xff0b";
    hudarray[":\x85?\x96L"].aligny = "\x14#\x01\x89\f\x81";
    hudarray[":\x85?\x96L"].horzalign = "=\xff0b";
    hudarray[":\x85?\x96L"].vertalign = "\x1d Q";
    hudarray[":\x85?\x96L"].sort = 0;
    hudarray[":\x85?\x96L"].alpha = 0;
    hudarray[":\x85?\x96L"].color = (0.925, 0.519, 0.14);

    if(getdvarint(@ "hash_82eb856681438f08") == 0) {
      hudarray["\x93p\xf7g\xde"] = newhudelem();
      hudarray["\x93p\xf7g\xde"] setshader("\xbb\xd2dv\xf5\xd99\x852i\x95\xdcG\xbe\x8e\xf6p\xfa\xa3o\xd7b\xf6\xd1\xa3\xed\xb5", 1280, 150);
      hudarray["\x93p\xf7g\xde"].x = 0;
      hudarray["\x93p\xf7g\xde"].y = 0;
      hudarray["\x93p\xf7g\xde"].alignx = "=\xff0b";
      hudarray["\x93p\xf7g\xde"].aligny = "\x1d Q";
      hudarray["\x93p\xf7g\xde"].horzalign = "=\xff0b";
      hudarray["\x93p\xf7g\xde"].vertalign = "\x1d Q";
      hudarray["\x93p\xf7g\xde"].sort = 0;
      hudarray["\x93p\xf7g\xde"].alpha = 0;
      hudarray["\x93p\xf7g\xde"].color = (0.925, 0.519, 0.14);
    }

    level.player.sixthsense.hud = hudarray;
  }

  foreach(dir in getarraykeys(level.player.sixthsense.hud)) {
    active = function_83c34de191310f5c(dir, sightmask);
    spotted = function_83c34de191310f5c(dir, spottedmask);

    if(getdvarint(@ "hash_3a810db500922b6c") != 0) {
      function_bcf22a38c1d7ed38(dir, active, spotted);
    }

    if(isDefined(level.var_d3e74bb2d8230954)) {
      [[level.var_d3e74bb2d8230954]](dir, active, spotted);
    }

    function_e0e38ecbc99ba919(dir, active, spotted, sightmask, spottedmask);
  }
}

function function_83c34de191310f5c(dir, mask) {
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
      assertmsg("<dev string:x9f>" + dir);
      break;
  }

  foreach(constvalue in consts) {
    if(mask &constvalue) {
      return true;
    }
  }

  return false;
}

function function_bcf22a38c1d7ed38(dir, active, spotted) {
  elem = level.player.sixthsense.hud[dir];
  elem.color = spotted ? (1, 0.14, 0.519) : (0.925, 0.519, 0.14);
  elem fadeovertime(active ? 1 : 3);
  elem.alpha = active ? 1 : 0;
}

function function_e0e38ecbc99ba919(dir, active, spotted, sightmask, spottedmask) {
  if(sightmask > 0) {
    if(spottedmask == 0 && function_4c869cfc6e1058eb() != "\x1f\x93?pK+\x9c") {
      if(!isDefined(level.player.var_28a8d103e628a295)) {
        level.player.var_28a8d103e628a295 = gettime();
      }

      if(gettime() >= level.player.var_28a8d103e628a295) {
        level.player.var_28a8d103e628a295 = gettime() + 5000;
        level.player playSound("\xff\xdf\x881Q\f\xc9Tl\xc3\x84\xc9\xb4\xdb,\xb9n\x97-\x9d\xf0s\xc8=&\x19$\xb1\xc21\x8b\xfb\xf7\xe4\xe0");
      }
    }
  }

  if(spottedmask > 0) {
    if(!isDefined(level.player.var_310066552c93a0b7)) {
      level.player.var_310066552c93a0b7 = gettime();
    }

    if(gettime() >= level.player.var_310066552c93a0b7) {
      level.player.var_310066552c93a0b7 = gettime() + 5000;
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
    return (utility::isleft2d(self.origin, forward2d, enemy.origin) ? 4 : 1);
  }

  if(dot >= 0.5) {
    return (utility::isleft2d(self.origin, forward2d, enemy.origin) ? 128 : 64);
  }

  if(dot >= -0.707107) {
    return (utility::isleft2d(self.origin, forward2d, enemy.origin) ? 32 : 8);
  }

  return 16;
}