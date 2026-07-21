/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\corpse.gsc
***********************************************/

corpse_init_entity() {
  self.stealth.corpse = spawnStruct();
}

corpse_init_level() {
  if(isDefined(level.stealth) && isDefined(level.stealth.corpse)) {
    return;
  }
  level.stealth.corpse = spawnStruct();
  level.stealth.corpse.reset_time = 30;
  level scripts\stealth\utility::set_stealth_func("_encstr_AB180B9B2B50397F40B3033BB9", ::corpse_seen);
  level scripts\stealth\utility::set_stealth_func("_encstr_A59A0DF1E5353075B9DF8785AB43CD", ::corpse_found);
  set_corpse_ranges_default();
}

set_corpse_ranges_default() {
  var_0["_encstr_87710BBFFF2A6BC0377758139B"] = 600;
  var_0["_encstr_99A90CC42D130F4E7971C2EAE881"] = 300;
  var_0["_encstr_97540BC2FF7F2641F988425F15"] = 100;
  set_corpse_ranges(var_0);
}

set_corpse_ranges(var_0) {
  if(!isDefined(var_0["_encstr_88680C6034366527170715C1D314"]))
    var_0["_encstr_88680C6034366527170715C1D314"] = var_0["_encstr_97540BC2FF7F2641F988425F15"];

  level.stealth.corpse.shadow_distsqrd = squared(var_0["_encstr_88680C6034366527170715C1D314"]);
  level.stealth.corpse.sight_distsqrd = squared(var_0["_encstr_87710BBFFF2A6BC0377758139B"]);
  level.stealth.corpse.detect_distsqrd = squared(var_0["_encstr_99A90CC42D130F4E7971C2EAE881"]);
  level.stealth.corpse.found_distsqrd = squared(var_0["_encstr_97540BC2FF7F2641F988425F15"]);
}

set_corpse_ignore() {
  level.stealth.ignore_corpse[self getentitynumber()] = self.origin;
}

set_corpse_entity() {
  level.stealth.additional_corpse[self getentitynumber()] = self;
}

corpse_check_shadow(var_0) {
  if(!isDefined(self.in_shadow_origin) || distancesquared(self.in_shadow_origin, var_0) > 1.0) {
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

corpse_sight() {
  if(isDefined(self.stealth.corpse_nexttime) && gettime() < self.stealth.corpse_nexttime) {
    return;
  }
  if(scripts\engine\utility::ent_flag("_encstr_994C161B88E37E9393234F6048787B0931B883323053B5E3")) {
    return;
  }
  if(self.ignoreall) {
    return;
  }
  if(istrue(self.stealth.corpse.investigating)) {
    return;
  }
  if(isDefined(self.stealth.corpse.ent))
    self.stealth.corpse_nexttime = gettime() + 100;
  else
    self.stealth.corpse_nexttime = gettime() + 1000;

  var_0 = [];

  if(isDefined(level.fngetcorpsearrayfunc))
    var_0 = [[level.fngetcorpsearrayfunc]]();

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

    if(isDefined(self.stealth.override_corpse_found_dist))
      var_8 = self.stealth.override_corpse_found_dist * self.stealth.override_corpse_found_dist;

    if(isDefined(self.stealth.override_corpse_sight_dist))
      var_9 = self.stealth.override_corpse_sight_dist * self.stealth.override_corpse_sight_dist;

    if(isDefined(self.stealth.override_corpse_detect_dist))
      var_10 = self.stealth.override_corpse_detect_dist * self.stealth.override_corpse_detect_dist;

    if(var_4 corpse_check_shadow(var_6)) {
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

      if(var_12 <= var_7)
        continue;
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

    var_13 = anglesToForward(self gettagangles("_encstr_A130084D2FDAD8AA8F62"));
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

    if(istrue(var_1.seen) && isDefined(self.stealth.corpse.ent) && self.stealth.corpse.ent == var_1)
      self.stealth.patrol_react_last = gettime();

    self aieventlistenerevent("_encstr_A59A0DF1E5353075B9DF8785AB43CD", var_1, var_1 scripts\stealth\utility::getcorpseorigin());
  } else if(isDefined(var_2)) {
    thread corpse_seen_claim(var_2);
    self aieventlistenerevent("_encstr_AB180B9B2B50397F40B3033BB9", var_2, var_2 scripts\stealth\utility::getcorpseorigin());
  }
}

corpse_found(var_0) {
  self notify("_encstr_86BE0D806A0241CB3FEF8408BD6B51");
  self endon("_encstr_86BE0D806A0241CB3FEF8408BD6B51");
  self endon("_encstr_AD75063D571AE108");
  var_1 = var_0.entity;
  var_2 = var_1 scripts\stealth\utility::getcorpseorigin();

  if(isDefined(self.stealth.corpse.ent))
    self.stealth.corpse.ent.seen = undefined;

  self.stealth.corpse.ent = var_1;
  self.stealth.bexaminerequested = 1;

  if(isDefined(level.fnsetcorpseremovetimerfunc))
    var_1[[level.fnsetcorpseremovetimerfunc]](level.stealth.corpse.reset_time);
}

corpse_seen(var_0) {
  var_1 = var_0.entity;
  var_2 = var_1 scripts\stealth\utility::getcorpseorigin();
  self.stealth.corpse.origin = var_2;
  self.stealth.bexaminerequested = 1;
  thread corpse_seen_claim(var_1);
}

corpse_seen_claim(var_0) {
  self notify("_encstr_937F1276A703C3378F2978C0A265B77993518BF9");
  self endon("_encstr_937F1276A703C3378F2978C0A265B77993518BF9");

  if(isDefined(self.stealth.corpse.ent))
    self.stealth.corpse.ent.seen = undefined;

  var_0.seen = 1;
  self.stealth.corpse.ent = var_0;
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0.seen = undefined;

  if(isDefined(self))
    thread corpse_clear();
}

corpse_clear() {
  if(isDefined(self.stealth) && isDefined(self.stealth.corpse)) {
    if(isDefined(self.stealth.corpse.ent))
      self.stealth.corpse.ent.seen = undefined;

    self.stealth.corpse.ent = undefined;
    self.stealth.corpse.investigating = undefined;
  }
}

suspicious_door_sighting() {
  if(!isDefined(self.stealth.suspicious_door))
    self.stealth.suspicious_door = spawnStruct();

  if(isDefined(self.stealth.suspicious_door.nexttime) && gettime() < self.stealth.suspicious_door.nexttime) {
    return;
  }
  if(scripts\engine\utility::ent_flag("_encstr_994C161B88E37E9393234F6048787B0931B883323053B5E3")) {
    return;
  }
  if(self.ignoreall) {
    return;
  }
  if(istrue(self.stealth.suspicious_door.investigating)) {
    return;
  }
  if(isDefined(self.stealth.suspicious_door.ent))
    self.stealth.suspicious_door.nexttime = gettime() + 100;
  else
    self.stealth.suspicious_door.nexttime = gettime() + 1000;

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

      if(var_12 <= var_7)
        continue;
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

    var_13 = anglesToForward(self gettagangles("_encstr_A130084D2FDAD8AA8F62"));
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

    if(istrue(var_1.seen) && isDefined(self.stealth.suspicious_door.ent) && self.stealth.suspicious_door.ent == var_1)
      self.stealth.patrol_react_last = gettime();

    if(isDefined(var_3.cam_structs))
      var_16 = var_3.cam_structs[0].origin;
    else
      var_16 = var_3.origin;

    self aieventlistenerevent("_encstr_85511026C3AB79B8F32FF8D0BF37D18FB2AA", var_1, var_16);
  }
}

suspicious_door_found(var_0) {
  var_1 = var_0.entity;

  if(isDefined(var_1.aiopener)) {
    return;
  }
  var_1.aiopener = self;

  if(isDefined(var_1.cam_structs) && isDefined(var_1.cam_structs[0]))
    var_2 = var_1.cam_structs[0].origin;
  else
    var_2 = var_1.origin;

  var_3 = getclosestpointonnavmesh(var_2, self);
  var_0.origin = var_2 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  var_0.investigate_pos = getclosestpointonnavmesh(var_0.origin, self);
  scripts\stealth\enemy::bt_set_stealth_state("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", var_0);
}