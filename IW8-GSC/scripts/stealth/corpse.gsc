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

function set_corpse_ranges(var0) {
  if(!isDefined(var0["shadow_dist"])) {
    GscBinSkip0(0x2e, "shadow_dist", var0["found_dist"]);
  }

  level.stealth.corpse.shadow_distsqrd = squared(var0["shadow_dist"]);
  level.stealth.corpse.sight_distsqrd = squared(var0["sight_dist"]);
  level.stealth.corpse.detect_distsqrd = squared(var0["detect_dist"]);
  level.stealth.corpse.found_distsqrd = squared(var0["found_dist"]);
}

function set_corpse_ignore() {
  level.stealth.ignore_corpse[self getentitynumber()] = self.origin;
}

function set_corpse_entity() {
  level.stealth.additional_corpse[self getentitynumber()] = self;
}

function corpse_check_shadow(var0) {
  if(!isDefined(self.in_shadow_origin) || distancesquared(self.in_shadow_origin, var0) > 1) {
    self.in_shadow = undefined;

    if(isDefined(level.trigger_stealth_shadow)) {
      foreach(var2 in level.trigger_stealth_shadow) {
        if(isDefined(var2) && ispointinvolume(var0, var2)) {
          self.in_shadow = 1;
          break;
        }
      }
    }

    self.in_shadow_origin = var0;
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

  var0 = [];

  if(isDefined(level.fngetcorpsearrayfunc)) {
    var0 = [[level.fngetcorpsearrayfunc]]();
  }

  var1 = undefined;
  var2 = undefined;

  foreach(var4 in var0) {
    var5 = var4 getentitynumber();

    if(isDefined(level.stealth.ignore_corpse) && isDefined(level.stealth.ignore_corpse[var5]) && distancesquared(level.stealth.ignore_corpse[var5], var4.origin) < squared(100)) {
      level.stealth.ignore_corpse[var5] = undefined;
      var4.found = 1;
    }

    if(isDefined(var4.found)) {
      continue;
    }

    var6 = var4 scripts\stealth\utility::getcorpseorigin();
    var7 = distancesquared(self.origin, var6);
    var8 = level.stealth.corpse.found_distsqrd;
    var9 = level.stealth.corpse.sight_distsqrd;
    var10 = level.stealth.corpse.detect_distsqrd;

    if(isDefined(self.stealth.override_corpse_found_dist)) {
      var8 = self.stealth.override_corpse_found_dist * self.stealth.override_corpse_found_dist;
    }

    if(isDefined(self.stealth.override_corpse_sight_dist)) {
      var9 = self.stealth.override_corpse_sight_dist * self.stealth.override_corpse_sight_dist;
    }

    if(isDefined(self.stealth.override_corpse_detect_dist)) {
      var10 = self.stealth.override_corpse_detect_dist * self.stealth.override_corpse_detect_dist;
    }

    if(corpse_check_shadow(var4, var6)) {
      var9 = level.stealth.corpse.shadow_distsqrd;
      var10 = level.stealth.corpse.shadow_distsqrd;
    }

    if(var7 < var8) {
      if(abs(self.origin[2] - var6[2]) < 60) {
        var1 = var4;
        break;
      }
    }

    if(isDefined(self.stealth.corpse.ent)) {
      if(self.stealth.corpse.ent == var4) {
        continue;
      }

      var11 = self.stealth.corpse.ent scripts\stealth\utility::getcorpseorigin();
      var12 = distancesquared(self.origin, var11);

      if(var12 <= var7) {
        continue;
      }
    }

    if(var7 > var9) {
      continue;
    }

    if(var6[2] - self.origin[2] > 128) {
      continue;
    }

    if(var7 < var10) {
      if(!isDefined(var4.seen) && self cansee(var4)) {
        var2 = var4;
        break;
      }
    }

    var13 = anglesToForward(self gettagangles("tag_eye"));
    var14 = vectorNormalize(var6 + (0, 0, 30) - self getEye());

    if(vectordot(var13, var14) > 0.55) {
      if(!isDefined(var4.seen) && self cansee(var4)) {
        var2 = var4;
        break;
      }
    }
  }

  if(isDefined(var1)) {
    var1.found = 1;

    if(istrue(var1.seen) && isDefined(self.stealth.corpse.ent) && self.stealth.corpse.ent == var1) {
      self.stealth.patrol_react_last = gettime();
    }

    self aieventlistenerevent("found_corpse", var1, var1 scripts\stealth\utility::getcorpseorigin());
    return;
  }

  if(isDefined(var2)) {
    thread corpse_seen_claim(var2);
    self aieventlistenerevent("saw_corpse", var2, var2 scripts\stealth\utility::getcorpseorigin());
    return;
  }
}

function corpse_found(var0) {
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");
  var1 = var0.entity;
  var2 = var1 scripts\stealth\utility::getcorpseorigin();

  if(isDefined(self.stealth.corpse.ent)) {
    self.stealth.corpse.ent.seen = undefined;
  }

  self.stealth.corpse.ent = var1;
  self.stealth.bexaminerequested = 1;

  if(isDefined(level.fnsetcorpseremovetimerfunc)) {
    var1[[level.fnsetcorpseremovetimerfunc]](level.stealth.corpse.reset_time);
    return;
  }
}

function corpse_seen(var0) {
  var1 = var0.entity;
  var2 = var1 scripts\stealth\utility::getcorpseorigin();
  self.stealth.corpse.origin = var2;
  self.stealth.bexaminerequested = 1;
  thread corpse_seen_claim(var1);
}

function corpse_seen_claim(var0) {
  self notify("corpse_seen_claim");
  self endon("corpse_seen_claim");

  if(isDefined(self.stealth.corpse.ent)) {
    self.stealth.corpse.ent.seen = undefined;
  }

  var0.seen = 1;
  self.stealth.corpse.ent = var0;
  self waittill("death");

  if(isDefined(var0)) {
    var0.seen = undefined;
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

  var0 = level.stealth.suspicious_door.doors;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  foreach(var3 in var0) {
    var5 = var3 getentitynumber();

    if(isDefined(var3.found)) {
      continue;
    }

    var6 = var3.origin;
    var7 = distancesquared(self.origin, var6);
    var8 = level.stealth.suspicious_door.found_distsqrd;
    var9 = level.stealth.suspicious_door.sight_distsqrd;
    var10 = level.stealth.suspicious_door.detect_distsqrd;

    if(var7 < var8) {
      if(abs(self.origin[2] - var6[2]) < 60) {
        var1 = var3;
        break;
      }
    }

    if(isDefined(self.stealth.suspicious_door.ent)) {
      if(self.stealth.suspicious_door.ent == var3) {
        continue;
      }

      var11 = self.stealth.suspicious_door.ent.origin;
      var12 = distancesquared(self.origin, var11);

      if(var12 <= var7) {
        continue;
      }
    }

    if(var7 > var9) {
      continue;
    }

    if(var6[2] - self.origin[2] > 128) {
      continue;
    }

    if(var7 < var10) {
      if(!isDefined(var3.seen) && self cansee(var3) && scripts\engine\utility::can_trace_to_ai(var3.origin, self, level.stealth.cantracetoaiignoreents)) {
        var2 = var3;
        break;
      }
    }

    var13 = anglesToForward(self gettagangles("tag_eye"));
    var14 = vectorNormalize(var6 + (0, 0, 30) - self getEye());

    if(vectordot(var13, var14) > 0.55) {
      if(!isDefined(var3.seen) && self cansee(var3) && scripts\engine\utility::can_trace_to_ai(var3.origin, self, level.stealth.cantracetoaiignoreents)) {
        var2 = var3;
        break;
      }
    }
  }

  if(isDefined(var1)) {
    var1.found = 1;
    var16 = undefined;

    if(istrue(var1.seen) && isDefined(self.stealth.suspicious_door.ent) && self.stealth.suspicious_door.ent == var1) {
      self.stealth.patrol_react_last = gettime();
    }

    if(isDefined(var3.cam_structs)) {
      var16 = var3.cam_structs[0].origin;
    } else {
      var16 = var3.origin;
    }

    self aieventlistenerevent("suspicious_door", var1, var16);
    return;
  }
}

function suspicious_door_found(var0) {
  var1 = var0.entity;

  if(isDefined(var1.aiopener)) {
    return;
  }

  var1.aiopener = self;

  if(isDefined(var1.cam_structs) && isDefined(var1.cam_structs[0])) {
    var2 = var1.cam_structs[0].origin;
  } else {
    var2 = var2.origin;
  }

  var3 = getclosestpointonnavmesh(var2, self);
  var1.origin = var2 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  var1.investigate_pos = getclosestpointonnavmesh(var1.origin, self);
  scripts\stealth\enemy::bt_set_stealth_state("investigate", var1);
}