/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\track.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

trackshootentorpos() {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self endon("_encstr_AF740E1B3D1809AEF37B376E43C038EF");
  self endon("_encstr_A6C7065BACB1CA95");
  trackloop(%_encstr_82E506B096B5F58C, %_encstr_91E506B02DDA7D43, %_encstr_B8E5069E731339E6, %_encstr_AAE506A832FD17AA);
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

  if(self.type == "_encstr_AA180446F6EC") {
    var_13 = 0;
    self.shootent = self.enemy;
  } else {
    var_13 = 1;
    var_14 = 0;
    var_15 = 0;

    if(isDefined(self.covercrouchlean_aimmode))
      var_14 = anim.covercrouchleanpitch;

    var_16 = self.script;

    if((var_16 == "_encstr_87970BBFC71BCD10D7953951BB" || var_16 == "_encstr_91280CE8026B33B37F7ABBA448FB") && isDefined(self.a.cornermode) && self.a.cornermode == "_encstr_9BAD05B1560B9B")
      var_15 = self.covernode.angles[1] - self.angles[1];

    var_12 = (var_14, var_15, 0);
  }

  for(;;) {
    incranimaimweight();
    var_17 = scripts\asm\shared\utility::getshootfrompos();
    var_18 = self.shootpos;

    if(isDefined(self.shootent))
      var_18 = self.shootent getshootatpos();

    if(!isDefined(var_18) && _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::shouldcqb())
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

    var_7 = self setaimangles(var_17, var_21, var_20, var_12, var_22, var_23, var_19);
    var_24 = var_7[0];
    var_25 = var_7[1];
    var_7 = undefined;

    if(scripts\engine\utility::actor_is3d()) {
      var_26 = self.angles[2] * -1;
      var_27 = var_24 * cos(var_26) - var_25 * sin(var_26);
      var_28 = var_24 * sin(var_26) + var_25 * cos(var_26);
      var_24 = var_27;
      var_25 = var_28;
      var_24 = clamp(var_24, self.upaimlimit, self.downaimlimit);
      var_25 = clamp(var_25, self.rightaimlimit, self.leftaimlimit);
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
    var_30 = self.movemode != "_encstr_B419059BD17BE0" || !var_8;

    if(var_30) {
      var_31 = var_25 - var_5;

      if(squared(var_31) > var_29) {
        var_25 = var_5 + clamp(var_31, -1 * var_11, var_11);
        var_25 = clamp(var_25, self.rightaimlimit, self.leftaimlimit);
      }

      var_32 = var_24 - var_6;

      if(squared(var_32) > var_29) {
        var_24 = var_6 + clamp(var_32, -1 * var_11, var_11);
        var_24 = clamp(var_24, self.upaimlimit, self.downaimlimit);
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
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isDefined(var_1) && isDefined(self.cqb_point_of_interest)) {
    var_1 = self.cqb_point_of_interest;

    if(isDefined(self.cqb_wide_poi_track)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  return var_1;
}

trackloop_anglesfornoshootpos(var_0, var_1) {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::recentlysawenemy()) {
    var_2 = self.enemy getshootatpos() - self.enemy.origin;
    var_3 = self lastknownpos(self.enemy) + var_2;
    return trackloop_getdesiredangles(var_3 - var_0, var_1);
  }

  var_4 = 0;
  var_5 = 0;

  if(isDefined(self.node) && isDefined(anim.iscombatscriptnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16)
    var_5 = angleclamp180(self.node.angles[1] - self.angles[1]);
  else {
    var_6 = self getanglestolikelyenemypath();

    if(isDefined(var_6)) {
      var_5 = angleclamp180(var_6[1] - self.angles[1]);
      var_4 = angleclamp180(var_6[0]);
    }
  }

  return (var_4, var_5, 0);
}

trackloop_getdesiredangles(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  var_3 = 0;
  var_4 = 0;

  if(self.stairsstate == "_encstr_87070365F7")
    var_3 = 40;
  else if(self.stairsstate == "_encstr_9767056D0FBFA8") {
    var_3 = -40;
    var_4 = -12;
  }

  var_5 = var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);

  if(isDefined(self.stepoutyaw))
    var_6 = var_2[1] - self.stepoutyaw;
  else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_2[1] - (var_7 + self.angles[1]);
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

trackloop_clampangles(var_0, var_1, var_2) {
  if(isDefined(self.onsnowmobile) || isDefined(self.onatv)) {
    if(var_1 > self.leftaimlimit || var_1 < self.rightaimlimit)
      var_1 = 0;

    if(var_0 > self.downaimlimit || var_0 < self.upaimlimit)
      var_0 = 0;
  } else if(var_2 && (abs(var_1) > anim.maxanglecheckyawdelta || abs(var_0) > anim.maxanglecheckpitchdelta)) {
    var_1 = 0;
    var_0 = 0;
  } else {
    if(self.gunblockedbywall)
      var_1 = clamp(var_1, -10, 10);
    else
      var_1 = clamp(var_1, self.rightaimlimit, self.leftaimlimit);

    var_0 = clamp(var_0, self.upaimlimit, self.downaimlimit);
  }

  return (var_0, var_1, 0);
}

trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_6 < 0) {
    var_10 = var_6 / self.rightaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_6 > 0) {
    var_8 = var_6 / self.leftaimlimit * self.a.aimweight;
    var_9 = 1;
  }

  if(var_5 < 0) {
    var_11 = var_5 / self.upaimlimit * self.a.aimweight;
    var_9 = 1;
  } else if(var_5 > 0) {
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