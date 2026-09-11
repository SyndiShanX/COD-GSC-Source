/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\corpse.gsc
***********************************************/

function corpse_init_entity() {
  self.stealth.corpse = spawnStruct();
}

function corpse_init_level() {
  if(isDefined(level.stealth) && isDefined(level.stealth.corpse)) {
    return;
  }

  level.stealth.corpse = spawnStruct();
  level.stealth.corpse.reset_time = 30;
  level scripts\stealth\utility::set_stealth_func("saw_corpse", &corpse_seen);
  level scripts\stealth\utility::set_stealth_func("found_corpse", &corpse_found);
  set_corpse_ranges_default();
}

function set_corpse_ranges_default() {
  GscBinSkip1(0x45, "sight_dist", 600);
}

function set_corpse_ranges(var_0) {
  if(!isDefined(var_0["shadow_dist"])) {
    GscBinSkip0(0x2e, "shadow_dist", var_0["found_dist"]);
  }

  level.stealth.corpse.shadow_distsqrd = squared(var_0["shadow_dist"]);
  level.stealth.corpse.sight_distsqrd = squared(var_0["sight_dist"]);
  level.stealth.corpse.detect_distsqrd = squared(var_0["detect_dist"]);
  level.stealth.corpse.found_distsqrd = squared(var_0["found_dist"]);
}

function set_corpse_ignore() {
  level.stealth.ignore_corpse[self getentitynumber()] = self.origin;
}

function set_corpse_entity() {
  level.stealth.additional_corpse[self getentitynumber()] = self;
}

function corpse_check_shadow(var_0) {
  if(!isDefined(self.in_shadow_origin) || distancesquared(self.in_shadow_origin, var_0) > 1) {
    self.in_shadow = undefined;

    if(isDefined(level.trigger_stealth_shadow)) {
      foreach(var_2 in level.trigger_stealth_shadow) {
        if(isDefined(var_2) && ispointinvolume(var_0, var_2)) {
          self.in_shadow = 1;
          break;
        }
      }
    }

    self.in_shadow_origin = var_0;
  }

  return istrue(self.in_shadow);
}

function corpse_sight() {
  if(isDefined(self.stealth.corpse_nexttime) && gettime() < self.stealth.corpse_nexttime) {
    return;
  }

  if(scripts\engine\utility::ent_flag("stealth_hold_position")) {
    return;
  }

  if(self.ignoreall) {
    return;
  }

  if(istrue(self.stealth.corpse.investigating)) {
    return;
  }

  if(isDefined(self.stealth.corpse.ent)) {
    self.stealth.corpse_nexttime = gettime() + 100;
  } else {
    self.stealth.corpse_nexttime = gettime() + 1000;
  }

  var_0 = [];

  if(isDefined(level.fngetcorpsearrayfunc)) {
    var_0 = [[level.fngetcorpsearrayfunc]]();
  }

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(isDefined(level.stealth.ignore_corpse) && isDefined(level.stealth.ignore_corpse[var_5]) && distancesquared(level.stealth.ignore_corpse[var_5], var_4.origin) < squared(100)) {
      level.stealth.ignore_corpse[var_5] = undefined;
      var_4.found = 1;
    }

    if(isDefined(var_4.found)) {
      continue;
    }

    var_6 = var_4 scripts\stealth\utility::getcorpseorigin();
    var_7 = distancesquared(self.origin, var_6);
    var_8 = level.stealth.corpse.found_distsqrd;
    var_9 = level.stealth.corpse.sight_distsqrd;
    var_10 = level.stealth.corpse.detect_distsqrd;

    if(isDefined(self.stealth.override_corpse_found_dist)) {
      var_8 = self.stealth.override_corpse_found_dist * self.stealth.override_corpse_found_dist;
    }

    if(isDefined(self.stealth.override_corpse_sight_dist)) {
      var_9 = self.stealth.override_corpse_sight_dist * self.stealth.override_corpse_sight_dist;
    }

    if(isDefined(self.stealth.override_corpse_detect_dist)) {
      var_10 = self.stealth.override_corpse_detect_dist * self.stealth.override_corpse_detect_dist;
    }

    if(corpse_check_shadow(var_4, var_6)) {
      var_9 = level.stealth.corpse.shadow_distsqrd;
      var_10 = level.stealth.corpse.shadow_distsqrd;
    }

    if(var_7 < var_8) {
      if(abs(self.origin[2] - var_6[2]) < 60) {
        var_1 = var_4;
        break;
      }
    }

    if(isDefined(self.stealth.corpse.ent)) {
      if(self.stealth.corpse.ent == var_4) {
        continue;
      }

      var_11 = self.stealth.corpse.ent scripts\stealth\utility::getcorpseorigin();
      var_12 = distancesquared(self.origin, var_11);

      if(var_12 <= var_7) {
        continue;
      }
    }

    if(var_7 > var_9) {
      continue;
    }

    if(var_6[2] - self.origin[2] > 128) {
      continue;
    }

    if(var_7 < var_10) {
      if(!isDefined(var_4.seen) && self cansee(var_4)) {
        var_2 = var_4;
        break;
      }
    }

    var_13 = anglesToForward(self gettagangles("tag_eye"));
    var_14 = vectorNormalize(var_6 + (0, 0, 30) - self getEye());

    if(vectordot(var_13, var_14) > 0.55) {
      if(!isDefined(var_4.seen) && self cansee(var_4)) {
        var_2 = var_4;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1.found = 1;

    if(istrue(var_1.seen) && isDefined(self.stealth.corpse.ent) && self.stealth.corpse.ent == var_1) {
      self.stealth.patrol_react_last = gettime();
    }

    self aieventlistenerevent("found_corpse", var_1, var_1 scripts\stealth\utility::getcorpseorigin());
    return;
  }

  if(isDefined(var_2)) {
    thread corpse_seen_claim(var_2);
    self aieventlistenerevent("saw_corpse", var_2, var_2 scripts\stealth\utility::getcorpseorigin());
    return;
  }
}

function corpse_found(var_0) {
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");
  var_1 = var_0.entity;
  var_2 = var_1 scripts\stealth\utility::getcorpseorigin();

  if(isDefined(self.stealth.corpse.ent)) {
    self.stealth.corpse.ent.seen = undefined;
  }

  self.stealth.corpse.ent = var_1;
  self.stealth.bexaminerequested = 1;

  if(isDefined(level.fnsetcorpseremovetimerfunc)) {
    var_1[[level.fnsetcorpseremovetimerfunc]](level.stealth.corpse.reset_time);
    return;
  }
}

function corpse_seen(var_0) {
  var_1 = var_0.entity;
  var_2 = var_1 scripts\stealth\utility::getcorpseorigin();
  self.stealth.corpse.origin = var_2;
  self.stealth.bexaminerequested = 1;
  thread corpse_seen_claim(var_1);
}

function corpse_seen_claim(var_0) {
  self notify("corpse_seen_claim");
  self endon("corpse_seen_claim");

  if(isDefined(self.stealth.corpse.ent)) {
    self.stealth.corpse.ent.seen = undefined;
  }

  var_0.seen = 1;
  self.stealth.corpse.ent = var_0;
  self waittill("death");

  if(isDefined(var_0)) {
    var_0.seen = undefined;
  }

  if(isDefined(self)) {
    thread corpse_clear();
    return;
  }
}

function corpse_clear() {
  if(isDefined(self.stealth) && isDefined(self.stealth.corpse)) {
    if(isDefined(self.stealth.corpse.ent)) {
      self.stealth.corpse.ent.seen = undefined;
    }

    self.stealth.corpse.ent = undefined;
    self.stealth.corpse.investigating = undefined;
    return;
  }
}

function suspicious_door_sighting() {
  if(!isDefined(self.stealth.suspicious_door)) {
    self.stealth.suspicious_door = spawnStruct();
  }

  if(isDefined(self.stealth.suspicious_door.nexttime) && gettime() < self.stealth.suspicious_door.nexttime) {
    return;
  }

  if(scripts\engine\utility::ent_flag("stealth_hold_position")) {
    return;
  }

  if(self.ignoreall) {
    return;
  }

  if(istrue(self.stealth.suspicious_door.investigating)) {
    return;
  }

  if(isDefined(self.stealth.suspicious_door.ent)) {
    self.stealth.suspicious_door.nexttime = gettime() + 100;
  } else {
    self.stealth.suspicious_door.nexttime = gettime() + 1000;
  }

  var_0 = level.stealth.suspicious_door.doors;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_0) {
    var_5 = var_3 getentitynumber();

    if(isDefined(var_3.found)) {
      continue;
    }

    var_6 = var_3.origin;
    var_7 = distancesquared(self.origin, var_6);
    var_8 = level.stealth.suspicious_door.found_distsqrd;
    var_9 = level.stealth.suspicious_door.sight_distsqrd;
    var_10 = level.stealth.suspicious_door.detect_distsqrd;

    if(var_7 < var_8) {
      if(abs(self.origin[2] - var_6[2]) < 60) {
        var_1 = var_3;
        break;
      }
    }

    if(isDefined(self.stealth.suspicious_door.ent)) {
      if(self.stealth.suspicious_door.ent == var_3) {
        continue;
      }

      var_11 = self.stealth.suspicious_door.ent.origin;
      var_12 = distancesquared(self.origin, var_11);

      if(var_12 <= var_7) {
        continue;
      }
    }

    if(var_7 > var_9) {
      continue;
    }

    if(var_6[2] - self.origin[2] > 128) {
      continue;
    }

    if(var_7 < var_10) {
      if(!isDefined(var_3.seen) && self cansee(var_3) && scripts\engine\utility::can_trace_to_ai(var_3.origin, self, level.stealth.cantracetoaiignoreents)) {
        var_2 = var_3;
        break;
      }
    }

    var_13 = anglesToForward(self gettagangles("tag_eye"));
    var_14 = vectorNormalize(var_6 + (0, 0, 30) - self getEye());

    if(vectordot(var_13, var_14) > 0.55) {
      if(!isDefined(var_3.seen) && self cansee(var_3) && scripts\engine\utility::can_trace_to_ai(var_3.origin, self, level.stealth.cantracetoaiignoreents)) {
        var_2 = var_3;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1.found = 1;
    var_16 = undefined;

    if(istrue(var_1.seen) && isDefined(self.stealth.suspicious_door.ent) && self.stealth.suspicious_door.ent == var_1) {
      self.stealth.patrol_react_last = gettime();
    }

    if(isDefined(var_3.cam_structs)) {
      var_16 = var_3.cam_structs[0].origin;
    } else {
      var_16 = var_3.origin;
    }

    self aieventlistenerevent("suspicious_door", var_1, var_16);
    return;
  }
}

function suspicious_door_found(var_0) {
  var_1 = var_0.entity;

  if(isDefined(var_1.aiopener)) {
    return;
  }

  var_1.aiopener = self;

  if(isDefined(var_1.cam_structs) && isDefined(var_1.cam_structs[0])) {
    var_2 = var_1.cam_structs[0].origin;
  } else {
    var_2 = var_2.origin;
  }

  var_3 = getclosestpointonnavmesh(var_2, self);
  var_1.origin = var_2 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  var_1.investigate_pos = getclosestpointonnavmesh(var_1.origin, self);
  scripts\stealth\enemy::bt_set_stealth_state("investigate", var_1);
}