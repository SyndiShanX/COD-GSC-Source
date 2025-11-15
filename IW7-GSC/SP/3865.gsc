/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3865.gsc
************************/

func_4682() {
  self.var_10E6D.var_466C = spawnStruct();
}

func_4683() {
  if(isDefined(level.var_10E6D) && isDefined(level.var_10E6D.var_466C)) {
    return;
  }

  func_4681();
  level.var_10E6D.var_466C = spawnStruct();
  level.var_10E6D.var_466C.var_E237 = 30;
  level lib_0F27::func_F5B4("saw_corpse", ::func_4687);
  level lib_0F27::func_F5B4("found_corpse", ::func_467E);
  func_F30F();
}

func_4681() {
  level.var_EC85["generic"]["check_body_1"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_01;
  level.var_EC85["generic"]["check_body_2"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_02;
  level.var_EC85["generic"]["check_body_3"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_03;
  level.var_EC85["generic"]["check_body_4"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_04;
}

func_F30F() {
  var_00["sight_dist"] = 600;
  var_00["detect_dist"] = 300;
  var_00["found_dist"] = 100;
  func_F30E(var_00);
}

func_F30E(param_00) {
  level.var_10E6D.var_466C.var_101E0 = squared(param_00["sight_dist"]);
  level.var_10E6D.var_466C.var_53A1 = squared(param_00["detect_dist"]);
  level.var_10E6D.var_466C.var_733B = squared(param_00["found_dist"]);
}

func_F30D() {
  level.var_10E6D.var_930F[self getentitynumber()] = self.origin;
}

func_468A() {
  if(isDefined(self.var_10E6D.var_4686) && gettime() < self.var_10E6D.var_4686) {
    return;
  }

  if(scripts\sp\utility::func_65DB("stealth_hold_position")) {
    return;
  }

  if(self.precacheleaderboards) {
    return;
  }

  if(scripts\engine\utility::istrue(self.var_10E6D.var_466C.var_9B2C)) {
    return;
  }

  if(isDefined(self.var_10E6D.var_466C.ent)) {
    self.var_10E6D.var_4686 = gettime() + 100;
  } else {
    self.var_10E6D.var_4686 = gettime() + 1000;
  }

  var_00 = getcorpsearray();
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in var_00) {
    var_05 = var_04 getentitynumber();
    if(isDefined(level.var_10E6D.var_930F) && isDefined(level.var_10E6D.var_930F[var_05]) && distancesquared(level.var_10E6D.var_930F[var_05], var_04.origin) < squared(100)) {
      level.var_10E6D.var_930F[var_05] = undefined;
      var_04.found = 1;
    }

    if(isDefined(var_04.found)) {
      continue;
    }

    var_06 = var_04 scripts\sp\utility::func_78E4();
    var_07 = distancesquared(self.origin, var_06);
    var_08 = level.var_10E6D.var_466C.var_733B;
    var_09 = level.var_10E6D.var_466C.var_101E0;
    var_0A = level.var_10E6D.var_466C.var_53A1;
    if(isDefined(self.var_10E6D.var_C810)) {
      var_08 = self.var_10E6D.var_C810 * self.var_10E6D.var_C810;
    }

    if(isDefined(self.var_10E6D.var_C811)) {
      var_09 = self.var_10E6D.var_C811 * self.var_10E6D.var_C811;
    }

    if(isDefined(self.var_10E6D.var_C80F)) {
      var_0A = self.var_10E6D.var_C80F * self.var_10E6D.var_C80F;
    }

    if(var_07 < var_08) {
      if(abs(self.origin[2] - var_06[2]) < 60) {
        var_01 = var_04;
        break;
      }
    }

    if(isDefined(self.var_10E6D.var_466C.ent)) {
      if(self.var_10E6D.var_466C.ent == var_04) {
        continue;
      }

      var_0B = self.var_10E6D.var_466C.ent scripts\sp\utility::func_78E4();
      var_0C = distancesquared(self.origin, var_0B);
      if(var_0C <= var_07) {
        continue;
      }
    }

    if(var_07 > var_09) {
      continue;
    }

    if(var_06[2] - self.origin[2] > 128) {
      continue;
    }

    if(var_07 < var_0A) {
      if(!isDefined(var_04.var_F182) && self getpersstat(var_04)) {
        var_02 = var_04;
        break;
      }
    }

    var_0D = anglesToForward(self gettagangles("tag_eye"));
    var_0E = vectornormalize(var_06 + (0, 0, 30) - self getEye());
    if(vectordot(var_0D, var_0E) > 0.55) {
      if(!isDefined(var_04.var_F182) && self getpersstat(var_04)) {
        var_02 = var_04;
        break;
      }
    }
  }

  if(isDefined(var_01)) {
    var_01.found = 1;
    if(scripts\engine\utility::istrue(var_01.var_F182) && isDefined(self.var_10E6D.var_466C.ent) && self.var_10E6D.var_466C.ent == var_01) {
      self.var_10E6D.var_C997 = gettime();
    }

    self _meth_84F7("found_corpse", var_01, var_01 scripts\sp\utility::func_78E4());
    return;
  }

  if(isDefined(var_02)) {
    thread func_4688(var_02);
    self _meth_84F7("saw_corpse", var_02, var_02 scripts\sp\utility::func_78E4());
  }
}

func_467E(param_00) {
  self notify("investigate_behavior");
  self notify("stop_runto_and_lookaround");
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");
  self endon("investigate_behavior");
  self endon("stop_runto_and_lookaround");
  var_01 = param_00.issplitscreen;
  var_02 = var_01 scripts\sp\utility::func_78E4();
  if(isDefined(self.var_10E6D.var_466C.ent)) {
    self.var_10E6D.var_466C.ent.var_F182 = undefined;
  }

  self.var_10E6D.var_466C.ent = undefined;
  var_01 _meth_82CB(level.var_10E6D.var_466C.var_E237);
  if(!isDefined(self.var_1FBB) && isDefined(self.var_1FEC) && self.var_1FEC == "generic_human") {
    self.var_1FBB = "generic";
  }

  var_03 = ["check_body_1", "check_body_2", "check_body_3", "check_body_4"];
  var_04 = var_03[randomint(var_03.size)];
  self.var_10E6D.var_466C.var_9B2C = 1;
  lib_0F27::func_CD58(var_02, var_04);
  thread func_467C();
  param_00.origin = self.origin + anglesToForward((0, randomfloatrange(0, 360), 0)) * 100;
  param_00.var_9B22 = getclosestpointonnavmesh(param_00.origin, self);
  self.var_10E6D.var_C997 = gettime();
  thread lib_0F22::func_9B24(param_00);
}

func_4687(param_00) {
  var_01 = param_00.issplitscreen;
  var_02 = var_01 scripts\sp\utility::func_78E4();
  self.var_10E6D.var_466C.origin = var_02;
  thread func_4688(var_01);
  thread func_4689(var_01);
  self.var_10E6D.var_C985 = undefined;
}

func_4688(param_00) {
  self notify("corpse_seen_claim");
  self endon("corpse_seen_claim");
  if(isDefined(self.var_10E6D.var_466C.ent)) {
    self.var_10E6D.var_466C.ent.var_F182 = undefined;
  }

  param_00.var_F182 = 1;
  self.var_10E6D.var_466C.ent = param_00;
  self waittill("death");
  if(isDefined(param_00)) {
    param_00.var_F182 = undefined;
  }

  if(isDefined(self)) {
    thread func_467C();
  }
}

func_4689(param_00) {
  self endon("death");
  param_00 endon("death");
  self notify("corpse_seen_follow");
  self endon("corpse_seen_follow");
  self endon("investigate_behavior");
  self endon("stop_runto_and_lookaround");
  self endon("corpse_found");
  var_01 = self.origin;
  var_02 = self.origin;
  for(;;) {
    wait(0.05);
    if(!isDefined(param_00)) {
      return;
    }

    var_03 = param_00 scripts\sp\utility::func_78E4();
    if(distancesquared(var_01, var_03) > 0.1) {
      var_01 = var_03;
      var_04 = getclosestpointonnavmesh(var_01, self);
      if(distancesquared(var_03, var_02) > 0.1) {
        var_02 = var_04;
        scripts\sp\utility::func_F3DC(var_02);
      }
    }
  }
}

func_467C() {
  if(isDefined(self.var_10E6D.var_466C)) {
    if(isDefined(self.var_10E6D.var_466C.ent)) {
      self.var_10E6D.var_466C.ent.var_F182 = undefined;
    }

    self.var_10E6D.var_466C.ent = undefined;
    self.var_10E6D.var_466C.var_9B2C = undefined;
  }
}