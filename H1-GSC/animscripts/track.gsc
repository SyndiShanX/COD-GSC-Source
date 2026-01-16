/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\track.gsc
********************************/

#using_animtree("generic_human");

trackshootentorpos() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  trackloop( % aim_2, % aim_4, % aim_6, % aim_8);
}

trackloop(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = 1;
  var_9 = 0;
  var_10 = 0;
  var_11 = 10;
  var_12 = (0, 0, 0);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0.1;
  var_18 = 0;

  if(self.type == "dog") {
    var_19 = 0;
    self.shootent = self.enemy;
  } else {
    var_19 = 1;
    var_20 = 0;
    var_21 = 0;

    if(isdefined(self.covercrouchlean_aimmode))
      var_20 = anim.covercrouchleanpitch;

    var_22 = self.script;

    if(var_22 == "cover_multi") {
      if(self.cover.state == "right")
        var_22 = "cover_right";
      else if(self.cover.state == "left")
        var_22 = "cover_left";
    }

    if((var_22 == "cover_left" || var_22 == "cover_right") && isdefined(self.a.cornermode) && self.a.cornermode == "lean")
      var_21 = self.covernode.angles[1] - self.angles[1];

    var_12 = (var_20, var_21, 0);
  }

  for (;;) {
    incranimaimweight();

    if(self gettagindex("tag_flash") == -1) {
      wait 0.05;
      continue;
    }

    var_23 = animscripts\shared::getshootfrompos();
    var_24 = self.shootpos;

    if(isdefined(self.shootent)) {
      if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
        var_24 = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
      else
        var_24 = self.shootent getshootatpos();
    } else if(isdefined(var_24) && isdefined(self.forceaimtorwardsenemy) && isdefined(self.enemy))
      var_24 = self.enemy getshootatpos();

    if(!isdefined(var_24) && animscripts\utility::shouldcqb())
      var_24 = trackloop_cqbshootpos(var_23);

    var_25 = isdefined(self.onsnowmobile) || isdefined(self.onatv);
    var_26 = isdefined(var_24);
    var_27 = (0, 0, 0);

    if(var_26)
      var_27 = var_24;

    var_28 = 0;
    var_29 = isdefined(self.stepoutyaw);

    if(var_29)
      var_28 = self.stepoutyaw;

    var_7 = self getaimangle(var_23, var_27, var_26, var_12, var_28, var_29, var_25);
    var_30 = var_7[0];
    var_31 = var_7[1];
    var_7 = undefined;
    var_32 = undefined;

    if(self.a.pose == "prone") {
      var_32 = self.proneaimlimits;
      var_30 = clamp(var_30, var_32.downaimlimit, var_32.upaimlimit);
      var_31 = clamp(var_31, var_32.leftaimlimit, var_32.rightaimlimit);
    } else {
      var_32 = spawnstruct();
      var_32.rightaimlimit = self.rightaimlimit;
      var_32.leftaimlimit = self.leftaimlimit;
      var_32.upaimlimit = self.upaimlimit;
      var_32.downaimlimit = self.downaimlimit;
    }

    if(animscripts\utility::isspaceai()) {
      var_33 = self.angles[2] * -1;
      var_34 = var_30 * cos(var_33) - var_31 * sin(var_33);
      var_35 = var_30 * sin(var_33) + var_31 * cos(var_33);
      var_30 = var_34;
      var_31 = var_35;
      var_30 = clamp(var_30, var_32.downaimlimit, var_32.upaimlimit);
      var_31 = clamp(var_31, var_32.leftaimlimit, var_32.rightaimlimit);
    }

    if(var_10 > 0) {
      var_10 = var_10 - 1;
      var_11 = max(10, var_11 - 5);
    } else if(self.relativedir && self.relativedir != var_9) {
      var_10 = 2;
      var_11 = 30;
    } else
      var_11 = 10;

    var_36 = squared(var_11);
    var_9 = self.relativedir;
    var_37 = self.movemode != "stop" || !var_8;

    if(var_37) {
      var_38 = var_31 - var_5;

      if(squared(var_38) > var_36) {
        var_31 = var_5 + clamp(var_38, -1 * var_11, var_11);
        var_31 = clamp(var_31, var_32.leftaimlimit, var_32.rightaimlimit);
      }

      var_39 = var_30 - var_6;

      if(squared(var_39) > var_36) {
        var_30 = var_6 + clamp(var_39, -1 * var_11, var_11);
        var_30 = clamp(var_30, var_32.downaimlimit, var_32.upaimlimit);
      }
    }

    var_8 = 0;
    var_5 = var_31;
    var_6 = var_30;
    trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_30, var_31, var_32);
    wait 0.05;
  }
}

trackloop_cqbshootpos(var_0) {
  var_1 = undefined;
  var_2 = anglestoforward(self.angles);

  if(isdefined(self.cqb_target)) {
    if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
      var_1 = animscripts\combat_utility::get_last_known_shoot_pos(self.cqb_target);
    else
      var_1 = self.cqb_target getshootatpos();

    if(isdefined(self.cqb_wide_target_track)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isdefined(var_1) && isdefined(self.cqb_point_of_interest)) {
    var_1 = self.cqb_point_of_interest;

    if(isdefined(self.cqb_wide_poi_track)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  return var_1;
}

trackloop_anglesfornoshootpos(var_0, var_1) {
  if(animscripts\utility::recentlysawenemy()) {
    var_2 = self.enemy getshootatpos() - self.enemy.origin;
    var_3 = self lastknownpos(self.enemy) + var_2;
    return trackloop_getdesiredangles(var_3 - var_0, var_1);
  }

  var_4 = 0;
  var_5 = 0;

  if(isdefined(self.node) && isdefined(anim.iscombatscriptnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16)
    var_5 = angleclamp180(self.angles[1] - self.node.angles[1]);
  else {
    var_6 = self getanglestolikelyenemypath();

    if(isdefined(var_6)) {
      var_5 = angleclamp180(self.angles[1] - var_6[1]);
      var_4 = angleclamp180(360 - var_6[0]);
    }
  }

  return (var_4, var_5, 0);
}

trackloop_getdesiredangles(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  var_3 = 0;
  var_4 = 0;

  if(self.stairsstate == "up") {
    if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech)
      var_3 = -40;
  } else if(self.stairsstate == "down") {
    if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech) {
      var_3 = 40;
      var_4 = 12;
    }
  }

  var_5 = 360 - var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);

  if(isdefined(self.stepoutyaw))
    var_6 = self.stepoutyaw - var_2[1];
  else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_7 + self.angles[1] - var_2[1];
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

trackloop_clampangles(var_0, var_1, var_2) {
  if(isdefined(self.onsnowmobile) || isdefined(self.onatv)) {
    if(var_1 > self.rightaimlimit || var_1 < self.leftaimlimit)
      var_1 = 0;

    if(var_0 > self.upaimlimit || var_0 < self.downaimlimit)
      var_0 = 0;
  } else if(var_2 && (abs(var_1) > anim.maxanglecheckyawdelta || abs(var_0) > anim.maxanglecheckpitchdelta)) {
    var_1 = 0;
    var_0 = 0;
  } else {
    if(self.gunblockedbywall)
      var_1 = clamp(var_1, -10, 10);
    else
      var_1 = clamp(var_1, self.leftaimlimit, self.rightaimlimit);

    var_0 = clamp(var_0, self.downaimlimit, self.upaimlimit);
  }

  return (var_0, var_1, 0);
}

trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0.1;

  if(isdefined(self.aimblendtime))
    var_13 = self.aimblendtime;

  if(var_6 > 0) {
    var_11 = clamp(var_6 / self.animaimlimit.rightaimlimit * self.a.aimweight, 0, 1);
    var_10 = 1;
  } else if(var_6 < 0) {
    var_9 = clamp(var_6 / self.animaimlimit.leftaimlimit * self.a.aimweight, 0, 1);
    var_10 = 1;
  }

  if(var_5 > 0) {
    var_12 = var_5 / var_7.upaimlimit * self.a.aimweight;
    var_10 = 1;
  } else if(var_5 < 0) {
    var_8 = var_5 / var_7.downaimlimit * self.a.aimweight;
    var_10 = 1;
  }

  self setanimlimited(var_0, var_8, var_13, 1, 1);
  self setanimlimited(var_1, var_9, var_13, 1, 1);
  self setanimlimited(var_2, var_11, var_13, 1, 1);
  self setanimlimited(var_3, var_12, var_13, 1, 1);

  if(isdefined(var_4))
    self setanimlimited(var_4, var_10, var_13, 1, 1);
}

setanimaimweight(var_0, var_1) {
  if(!isdefined(var_1) || var_1 <= 0) {
    self.a.aimweight = var_0;
    self.a.aimweight_start = var_0;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isdefined(self.a.aimweight))
      self.a.aimweight = 0;

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = int(var_1 * 20);
  }

  self.a.aimweight_t = 0;
}

incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    var_0 = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - var_0) + self.a.aimweight_end * var_0;
  }
}