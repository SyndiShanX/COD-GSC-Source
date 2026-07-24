/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3865.gsc
**************************************/

_id_4682() {
  self._id_10E6D._id_466C = spawnStruct();
}

_id_4683() {
  if(isDefined(level._id_10E6D) && isDefined(level._id_10E6D._id_466C)) {
    return;
  }
  _id_4681();
  level._id_10E6D._id_466C = spawnStruct();
  level._id_10E6D._id_466C._id_E237 = 30;
  level _id_0F27::_id_F5B4("saw_corpse", ::_id_4687);
  level _id_0F27::_id_F5B4("found_corpse", ::_id_467E);
  _id_F30F();
}

#using_animtree("generic_human");

_id_4681() {
  level._id_EC85["generic"]["check_body_1"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_01;
  level._id_EC85["generic"]["check_body_2"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_02;
  level._id_EC85["generic"]["check_body_3"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_03;
  level._id_EC85["generic"]["check_body_4"] = % hm_grnd_yel_patrol_seekclear_checkbody_ar_04;
}

_id_F30F() {
  var_0["sight_dist"] = 600;
  var_0["detect_dist"] = 300;
  var_0["found_dist"] = 100;
  _id_F30E(var_0);
}

_id_F30E(var_0) {
  level._id_10E6D._id_466C._id_101E0 = squared(var_0["sight_dist"]);
  level._id_10E6D._id_466C._id_53A1 = squared(var_0["detect_dist"]);
  level._id_10E6D._id_466C._id_733B = squared(var_0["found_dist"]);
}

_id_F30D() {
  level._id_10E6D._id_930F[self getentitynumber()] = self.origin;
}

_id_468A() {
  if(isDefined(self._id_10E6D._id_4686) && gettime() < self._id_10E6D._id_4686) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("stealth_hold_position")) {
    return;
  }
  if(self.ignoreall) {
    return;
  }
  if(scripts\engine\utility::is_true(self._id_10E6D._id_466C._id_9B2C)) {
    return;
  }
  if(isDefined(self._id_10E6D._id_466C.ent))
    self._id_10E6D._id_4686 = gettime() + 100;
  else
    self._id_10E6D._id_4686 = gettime() + 1000;

  var_0 = getcorpsearray();
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(isDefined(level._id_10E6D._id_930F) && isDefined(level._id_10E6D._id_930F[var_5]) && distancesquared(level._id_10E6D._id_930F[var_5], var_4.origin) < squared(100)) {
      level._id_10E6D._id_930F[var_5] = undefined;
      var_4.found = 1;
    }

    if(isDefined(var_4.found)) {
      continue;
    }
    var_6 = var_4 scripts\sp\utility::_id_78E4();
    var_7 = distancesquared(self.origin, var_6);
    var_8 = level._id_10E6D._id_466C._id_733B;
    var_9 = level._id_10E6D._id_466C._id_101E0;
    var_10 = level._id_10E6D._id_466C._id_53A1;

    if(isDefined(self._id_10E6D._id_C810))
      var_8 = self._id_10E6D._id_C810 * self._id_10E6D._id_C810;

    if(isDefined(self._id_10E6D._id_C811))
      var_9 = self._id_10E6D._id_C811 * self._id_10E6D._id_C811;

    if(isDefined(self._id_10E6D._id_C80F))
      var_10 = self._id_10E6D._id_C80F * self._id_10E6D._id_C80F;

    if(var_7 < var_8) {
      if(abs(self.origin[2] - var_6[2]) < 60) {
        var_1 = var_4;
        break;
      }
    }

    if(isDefined(self._id_10E6D._id_466C.ent)) {
      if(self._id_10E6D._id_466C.ent == var_4) {
        continue;
      }
      var_11 = self._id_10E6D._id_466C.ent scripts\sp\utility::_id_78E4();
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
      if(!isDefined(var_4._id_F182) && self cansee(var_4)) {
        var_2 = var_4;
        break;
      }
    }

    var_13 = anglesToForward(self gettagangles("tag_eye"));
    var_14 = vectorNormalize(var_6 + (0, 0, 30) - self getEye());

    if(vectordot(var_13, var_14) > 0.55) {
      if(!isDefined(var_4._id_F182) && self cansee(var_4)) {
        var_2 = var_4;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1.found = 1;

    if(scripts\engine\utility::is_true(var_1._id_F182) && isDefined(self._id_10E6D._id_466C.ent) && self._id_10E6D._id_466C.ent == var_1)
      self._id_10E6D._id_C997 = gettime();

    self _meth_84F7("found_corpse", var_1, var_1 scripts\sp\utility::_id_78E4());
  } else if(isDefined(var_2)) {
    thread _id_4688(var_2);
    self _meth_84F7("saw_corpse", var_2, var_2 scripts\sp\utility::_id_78E4());
  }
}

_id_467E(var_0) {
  self notify("investigate_behavior");
  self notify("stop_runto_and_lookaround");
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");
  self endon("investigate_behavior");
  self endon("stop_runto_and_lookaround");
  var_1 = var_0.entity;
  var_2 = var_1 scripts\sp\utility::_id_78E4();

  if(isDefined(self._id_10E6D._id_466C.ent))
    self._id_10E6D._id_466C.ent._id_F182 = undefined;

  self._id_10E6D._id_466C.ent = undefined;
  var_1 _meth_82CB(level._id_10E6D._id_466C._id_E237);

  if(!isDefined(self._id_1FBB) && isDefined(self._id_1FEC) && self._id_1FEC == "generic_human")
    self._id_1FBB = "generic";

  var_3 = ["check_body_1", "check_body_2", "check_body_3", "check_body_4"];
  var_4 = var_3[randomint(var_3.size)];
  self._id_10E6D._id_466C._id_9B2C = 1;
  _id_0F27::_id_CD58(var_2, var_4);
  thread _id_467C();
  var_0.origin = self.origin + anglesToForward((0, randomfloatrange(0, 360), 0)) * 100;
  var_0._id_9B22 = getclosestpointonnavmesh(var_0.origin, self);
  self._id_10E6D._id_C997 = gettime();
  thread _id_0F22::_id_9B24(var_0);
}

_id_4687(var_0) {
  var_1 = var_0.entity;
  var_2 = var_1 scripts\sp\utility::_id_78E4();
  self._id_10E6D._id_466C.origin = var_2;
  thread _id_4688(var_1);
  thread _id_4689(var_1);
  self._id_10E6D._id_C985 = undefined;
}

_id_4688(var_0) {
  self notify("corpse_seen_claim");
  self endon("corpse_seen_claim");

  if(isDefined(self._id_10E6D._id_466C.ent))
    self._id_10E6D._id_466C.ent._id_F182 = undefined;

  var_0._id_F182 = 1;
  self._id_10E6D._id_466C.ent = var_0;
  self waittill("death");

  if(isDefined(var_0))
    var_0._id_F182 = undefined;

  if(isDefined(self))
    thread _id_467C();
}

_id_4689(var_0) {
  self endon("death");
  var_0 endon("death");
  self notify("corpse_seen_follow");
  self endon("corpse_seen_follow");
  self endon("investigate_behavior");
  self endon("stop_runto_and_lookaround");
  self endon("corpse_found");
  var_1 = self.origin;
  var_2 = self.origin;

  for(;;) {
    wait 0.05;

    if(!isDefined(var_0)) {
      return;
    }
    var_3 = var_0 scripts\sp\utility::_id_78E4();

    if(distancesquared(var_1, var_3) > 0.1) {
      var_1 = var_3;
      var_4 = getclosestpointonnavmesh(var_1, self);

      if(distancesquared(var_3, var_2) > 0.1) {
        var_2 = var_4;
        scripts\sp\utility::_id_F3DC(var_2);
      }
    }
  }
}

_id_467C() {
  if(isDefined(self._id_10E6D._id_466C)) {
    if(isDefined(self._id_10E6D._id_466C.ent))
      self._id_10E6D._id_466C.ent._id_F182 = undefined;

    self._id_10E6D._id_466C.ent = undefined;
    self._id_10E6D._id_466C._id_9B2C = undefined;
  }
}