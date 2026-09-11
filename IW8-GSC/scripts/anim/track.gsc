/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\track.gsc
***********************************************/

#using_animtree("");

function trackshootentorpos() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  trackloop(%aim_2, %aim_4, $aim_6, %aim_8);
}

function trackloop(var0, var1, var2, var3, var4) {
  var5 = 0;
  var6 = 0;
  var7 = (0, 0, 0);
  var8 = 1;
  var9 = 0;
  var10 = 0;
  var11 = 10;
  var12 = (0, 0, 0);

  if(self.type == "dog") {
    var13 = 0;
    self.shootent = self.enemy;
    goto LOC_000000d2;
  }

  var13 = 1;
  var14 = 0;
  var15 = 0;

  if(isDefined(self.covercrouchlean_aimmode)) {
    var14 = anim.covercrouchleanpitch;
  }

  var16 = self.script;

  if((var16 == "cover_left" || var16 == "cover_right") && isDefined(self.a.cornermode) && self.a.cornermode == "lean") {
    var15 = self.covernode.angles[1] - self.angles[1];
  }

  var13 = (var14, var15, 0);

  for(;;) {
    incranimaimweight();
    var17 = scripts\asm\shared\utility::getshootfrompos();
    var18 = self.shootpos;

    if(isDefined(self.shootent)) {
      var18 = self.shootent getshootatpos();
    }

    if(!isDefined(var18) && scripts\anim\utility::shouldcqb()) {
      var18 = trackloop_cqbshootpos(var17);
    }

    var19 = isDefined(self.onsnowmobile) || isDefined(self.onatv);
    var20 = isDefined(var18);
    var21 = (0, 0, 0);

    if(var20) {
      var21 = var18;
    }

    var22 = 0;
    var23 = isDefined(self.stepoutyaw);

    if(var23) {
      var22 = self.stepoutyaw;
    }

    var8 = self setaimangles(var17, var21, var20, var13, var22, var23, var19);
    var24 = var8[0];
    var25 = var8[1];
    var8 = undefined;

    if(scripts\engine\utility::actor_is3d()) {
      var26 = self.angles[2] * -1;
      var27 = var24 * cos(var26) - var25 * sin(var26);
      var28 = var24 * sin(var26) + var25 * cos(var26);
      var24 = var27;
      var25 = var28;
      var24 = clamp(var24, self.upaimlimit, self.downaimlimit);
      var25 = clamp(var25, self.rightaimlimit, self.leftaimlimit);
    }

    if(var11 > 0) {
      var11 -= 1;
      var12 = max(10, var12 - 5);
    } else if(self.relativedir && self.relativedir != var10) {
      var11 = 2;
      var12 = 30;
    } else {
      var12 = 10;
    }

    var29 = squared(var12);
    var10 = self.relativedir;
    var30 = self.movemode != "stop" || !var9;

    if(var30) {
      var31 = var25 - var6;

      if(squared(var31) > var29) {
        var25 = var6 + clamp(var31, -1 * var12, var12);
        var25 = clamp(var25, self.rightaimlimit, self.leftaimlimit);
      }

      var32 = var24 - var7;

      if(squared(var32) > var29) {
        var24 = var7 + clamp(var32, -1 * var12, var12);
        var24 = clamp(var24, self.upaimlimit, self.downaimlimit);
      }
    }

    var9 = 0;
    var6 = var25;
    var7 = var24;
    trackloop_setanimweights(var1, var2, var3, var4, var5, var24, var25);
    wait 0.05;
  }
}

function trackloop_cqbshootpos(var0) {
  var1 = undefined;
  var2 = anglesToForward(self.angles);

  if(isDefined(self.cqb_target)) {
    var1 = self.cqb_target getshootatpos();

    if(isDefined(self.cqb_wide_target_track)) {
      if(vectordot(vectorNormalize(var1 - var0), var2) < 0.177) {
        var1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var1 - var0), var2) < 0.643) {
      var1 = undefined;
    }
  }

  if(!isDefined(var1) && isDefined(self.cqb_point_of_interest)) {
    var1 = self.cqb_point_of_interest;

    if(isDefined(self.cqb_wide_poi_track)) {
      if(vectordot(vectorNormalize(var1 - var0), var2) < 0.177) {
        var1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var1 - var0), var2) < 0.643) {
      var1 = undefined;
    }
  }

  return var1;
}

function trackloop_anglesfornoshootpos(var0, var1) {
  if(scripts\anim\utility_common::recentlysawenemy()) {
    var2 = self.enemy getshootatpos() - self.enemy.origin;
    var3 = self lastknownpos(self.enemy) + var2;
    return trackloop_getdesiredangles(var3 - var0, var1);
  }

  var4 = 0;
  var5 = 0;

  if(isDefined(self.node) && isDefined(anim.iscombatscriptnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16) {
    var5 = angleclamp180(self.node.angles[1] - self.angles[1]);
  } else {
    var6 = self getanglestolikelyenemypath();

    if(isDefined(var6)) {
      var5 = angleclamp180(var6[1] - self.angles[1]);
      var4 = angleclamp180(var6[0]);
    }
  }

  return (var4, var5, 0);
}

function trackloop_getdesiredangles(var0, var1) {
  var2 = vectortoangles(var0);
  var3 = 0;
  var4 = 0;

  if(self.stairsstate == "up") {
    var3 = 40;
  } else if(self.stairsstate == "down") {
    var3 = -40;
    var4 = -12;
  }

  var5 = var2[0];
  var5 = angleclamp180(var5 + var1[0] + var3);
  jumpiffalse(isDefined(self.stepoutyaw)) LOC_00000066;
  var6 = var2[1] - self.stepoutyaw;
  goto LOC_00000094;
}

function trackloop_clampangles(var0, var1, var2) {
  if(isDefined(self.onsnowmobile) || isDefined(self.onatv)) {
    if(var1 > self.leftaimlimit || var1 < self.rightaimlimit) {
      var1 = 0;
    }

    if(var0 > self.downaimlimit || var0 < self.upaimlimit) {
      var0 = 0;
    }
  } else if(var2 && (abs(var1) > anim.maxanglecheckyawdelta || abs(var0) > anim.maxanglecheckpitchdelta)) {
    var1 = 0;
    var0 = 0;
  } else {
    if(self.gunblockedbywall) {
      var1 = clamp(var1, -10, 10);
    } else {
      var1 = clamp(var1, self.rightaimlimit, self.leftaimlimit);
    }

    var0 = clamp(var0, self.upaimlimit, self.downaimlimit);
  }

  return (var0, var1, 0);
}

function trackloop_setanimweights(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = 0;

  if(var6 < 0) {
    var10 = var6 / self.rightaimlimit * self.a.aimweight;
    var9 = 1;
  } else if(var6 > 0) {
    var8 = var6 / self.leftaimlimit * self.a.aimweight;
    var9 = 1;
  }

  if(var5 < 0) {
    var11 = var5 / self.upaimlimit * self.a.aimweight;
    var9 = 1;
  } else if(var5 > 0) {
    var7 = var5 / self.downaimlimit * self.a.aimweight;
    var9 = 1;
  }

  self setanimlimited(var0, var7, 0.1, 1, 1);
  self setanimlimited(var1, var8, 0.1, 1, 1);
  self setanimlimited(var2, var10, 0.1, 1, 1);
  self setanimlimited(var3, var11, 0.1, 1, 1);

  if(isDefined(var4)) {
    self setanimlimited(var4, var9, 0.1, 1, 1);
    return;
  }
}

function setanimaimweight(var0, var1) {
  if(!isDefined(var1) || var1 <= 0) {
    self.a.aimweight = var0;
    self.a.aimweight_start = var0;
    self.a.aimweight_end = var0;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight)) {
      self.a.aimweight = 0;
    }

    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = var0;
    self.a.aimweight_transframes = int(var1 * 20);
  }

  self.a.aimweight_t = 0;
}

function incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    var0 = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - var0) + self.a.aimweight_end * var0;
    return;
  }
}