/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\track.gsc
*****************************************************/

#using_animtree("generic_human");

trackshootentorpos() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  trackloop(%aim_2, %aim_4, %aim_6, %aim_8);
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

  if(self.type == "dog") {
    var_13 = 0;
    self.shootent = self.enemy;
  } else {
    var_13 = 1;
    var_14 = 0;
    var_15 = 0;

    if(isDefined(self.covercrouchlean_aimmode))
      var_14 = anim.covercrouchleanpitch;

    var_16 = self.script;

    if(var_16 == "cover_multi") {
      if(self.cover.state == "right")
        var_16 = "cover_right";
      else if(self.cover.state == "left")
        var_16 = "cover_left";
    }

    if((var_16 == "cover_left" || var_16 == "cover_right") && isDefined(self.a.cornermode) && self.a.cornermode == "lean")
      var_15 = self.covernode.angles[1] - self.angles[1];

    var_12 = (var_14, var_15, 0);
  }

  for(;;) {
    incranimaimweight();
    var_17 = animscripts\shared::getshootfrompos();
    var_18 = self.shootpos;

    if(isDefined(self.shootent))
      var_18 = self.shootent getshootatpos();

    if(!isDefined(var_18) && animscripts\utility::shouldcqb())
      var_18 = trackloop_cqbshootpos(var_17);

    var_19 = isDefined(self.onsnowmobile) || isDefined(self.onatv);
    var_20 = isDefined(var_18);
    var_21 = (0, 0, 0);

    if(var_20)
      var_21 = var_18;

    var_22 = 0;
    var_23 = isDefined(self.stepoutyaw);

    if(var_23)
      var_22 = self.stepoutyaw;

    var_7 = self getaimangle(var_17, var_21, var_20, var_12, var_22, var_23, var_19);
    var_24 = var_7[0];
    var_25 = var_7[1];
    var_7 = undefined;

    if(animscripts\utility::isspaceai()) {
      var_26 = self.angles[2] * -1;
      var_27 = var_24 * cos(var_26) - var_25 * sin(var_26);
      var_28 = var_24 * sin(var_26) + var_25 * cos(var_26);
      var_24 = var_27;
      var_25 = var_28;
      var_24 = clamp(var_24, self.downaimlimit, self.upaimlimit);
      var_25 = clamp(var_25, self.leftaimlimit, self.rightaimlimit);
    }

    if(var_10 > 0) {
      var_10 = var_10 - 1;
      var_11 = max(10, var_11 - 5);
    } else if(self.relativedir && self.relativedir != var_9) {
      var_10 = 2;
      var_11 = 30;
    } else
      var_11 = 10;

    var_29 = squared(var_11);
    var_9 = self.relativedir;
    var_30 = self.movemode != "stop" || !var_8;

    if(var_30) {
      var_31 = var_25 - var_5;

      if(squared(var_31) > var_29) {
        var_25 = var_5 + clamp(var_31, -1 * var_11, var_11);
        var_25 = clamp(var_25, self.leftaimlimit, self.rightaimlimit);
      }

      var_32 = var_24 - var_6;

      if(squared(var_32) > var_29) {
        var_24 = var_6 + clamp(var_32, -1 * var_11, var_11);
        var_24 = clamp(var_24, self.downaimlimit, self.upaimlimit);
      }
    }

    var_8 = 0;
    var_5 = var_25;
    var_6 = var_24;
    trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_24, var_25);
    wait 0.05;
  }
}

trackloop_cqbshootpos(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);

  if(isDefined(self.cqb_target)) {
    var_1 = self.cqb_target getshootatpos();

    if(isDefined(self.cqb_wide_target_track)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isDefined(var_1) && isDefined(self.cqb_point_of_interest)) {
    var_1 = self.cqb_point_of_interest;

    if(isDefined(self.cqb_wide_poi_track)) {
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

  if(isDefined(self.node) && isDefined(anim.iscombatscriptnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16)
    var_5 = angleclamp180(self.angles[1] - self.node.angles[1]);
  else {
    var_6 = self getanglestolikelyenemypath();

    if(isDefined(var_6)) {
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

  if(self.stairsstate == "up")
    var_3 = -40;
  else if(self.stairsstate == "down") {
    var_3 = 40;
    var_4 = 12;
  }

  var_5 = 360 - var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);

  if(isDefined(self.stepoutyaw))
    var_6 = self.stepoutyaw - var_2[1];
  else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_7 + self.angles[1] - var_2[1];
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

trackloop_clampangles(var_0, var_1, var_2) {
  if(isDefined(self.onsnowmobile) || isDefined(self.onatv)) {
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

trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_6 > 0) {
    var_10 = var_6 / self.rightaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_6 < 0) {
    var_8 = var_6 / self.leftaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  if(var_5 > 0) {
    var_11 = var_5 / self.upaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_5 < 0) {
    var_7 = var_5 / self.downaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  self setanimlimited(var_0, var_7, 0.1, 1, 1);
  self setanimlimited(var_1, var_8, 0.1, 1, 1);
  self setanimlimited(var_2, var_10, 0.1, 1, 1);
  self setanimlimited(var_3, var_11, 0.1, 1, 1);

  if(isDefined(var_4))
    self setanimlimited(var_4, var_9, 0.1, 1, 1);
}

setanimaimweight(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a.aimweight = var_0;
    self.a.aimweight_start = var_0;
    self.a.aimweight_end = var_0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight))
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