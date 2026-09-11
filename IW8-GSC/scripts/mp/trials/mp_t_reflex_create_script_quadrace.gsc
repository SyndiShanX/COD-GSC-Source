/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_t_reflex_create_script_quadrace.gsc
********************************************************************/

function ref_134b8(var0, var1, var2, var3) {
  if(!soldier_br_isalert()) {
    return false;
  }

  if(istrue(self.noturnanims)) {
    return false;
  }

  var4 = scripts\asm\asm::asm_geteventtime(var0, "sharp_turn");

  if(!isDefined(var4)) {
    return false;
  }

  var5 = 50;
  var6 = gettime();

  if(var6 - var4 > var5) {
    return false;
  }

  var7 = scripts\asm\asm::asm_geteventdata(var0, "sharp_turn");
  var8 = var7[1];
  var9 = var7[2];
  var10 = var7[3];
  var11 = 22500;

  if(var9 && self pathdisttogoal() > 90 || lengthsquared(self.velocity) > var11) {
    var12 = 0;
    var13 = undefined;

    if(!isarray(var3)) {
      var14 = var3;
    } else {
      var14 = var4[0];

      if(var4.size > 1 && var4[1] == 1) {
        var13 = 1;
      }

      if(var4.size > 2) {
        var14 = scripts\asm\asm_bb::bb_getprefixstring(var4[2]);
      }
    }

    var15 = "";

    if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentnotabomber()) {
      var15 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
      var16 = scripts\asm\shared\utility::getbasearchetype();
      self.turnspeedtarget = getnearestspeedthresholdname(var16, var15);
    } else {
      self.turnspeedtarget = undefined;
    }

    var17 = ref_13484(var1, var14, var11, var9, var10, var13, var14, var15);

    if(!isDefined(var17)) {
      return false;
    }

    if(self.a.sharpturnnumberindex > 2 && self.a.sharpturnnumberindex < 6) {
      return false;
    }

    self.a.sharpturnindex = var17;
    self.a.sharpturncorner = var11;
    self.a.sharpturnnextpathpoint = var9;
    return true;
  }

  return false;
}

function ref_13484(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = 22.5;

  if(!isDefined(var6)) {
    var6 = "";
  }

  if(!isDefined(var7)) {
    var7 = "";
  }

  if(var5) {
    if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_left")) {
      var9 = var6 + "left";
    } else if(scripts\asm\asm::asm_eventfiredrecently(var1, "pass_right")) {
      var9 = var7 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var9 = var8 + "right";
    } else {
      var9 += "left";
    }
  } else {
    var9 = var9;
  }

  var10 = self actorcalcsharpturnanim(var5, var6, var7, var9, var9, var9, var9);
  var11 = var10[0];
  var12 = var10[1];
  var10 = undefined;
  self.a.sharpturnnumberindex = var12;
  return var11;
}

function ref_13490(var0, var1, var2) {
  return self.a.sharpturnindex;
}

function ref_1348b(var0, var1, var2) {
  var3 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_left")) {
    var3 = "left";
  } else if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_right")) {
    var3 = "right";
  } else if(self.asm.footsteps.foot == "right") {
    var3 = "right";
  }

  var4 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
  var5 = 0;
  var6 = scripts\asm\shared\utility::getarrivalnode();
  var7 = scripts\asm\shared\utility::nodeshouldfaceangles(var6);
  var8 = 6400;

  if(scripts\anim\utility_common::recentlysawenemy() || !isDefined(self.enemy)) {
    var5 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
  } else if(var7 && length2dsquared(var6.origin - self.origin) < var8) {
    var5 = scripts\asm\shared\utility::getnodeforwardyaw(var6) - self.angles[1];
  } else if(istrue(self.brjugg_watchstartnotify)) {
    var9 = 0;

    if(issentient(self.enemy)) {
      var9 = self hastacvis(self.enemy);
    } else {
      var9 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);
    }

    if(var9) {
      var5 = vectortoyaw(self.enemy.origin - self.origin);
    }
  }

  var5 = angleclamp180(var5);
  var10 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var11 = getangleindex(var5, 22.5);
  var12 = var3 + var10[var11] + var4;
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var12);
}

function ref_134bc(var0, var1, var2, var3) {
  if(!isDefined(self.asm.strafe_foot)) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(self getreacquirestate() == "enabled") {
    return false;
  }

  if(!soldier_br_isalert()) {
    return false;
  }

  var4 = scripts\asm\soldier\move::getstairsenterdist();
  var5 = self getstairsstateatdist(var4);

  if(var5 != "none") {
    return false;
  }

  var6 = self aigettargetspeed();

  if(self.lookaheaddist < 90) {
    return false;
  }

  var7 = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9) {
    return false;
  }

  var8 = self asmeventfiredwithin(var0, "sharp_turn", 50);

  if(var8) {
    var9 = angleclamp180(var7 - self.angles[1]);
    var10 = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(var10 - var9)) > 45) {
      return false;
    }
  } else {
    var10 = angleclamp180(var8 - self.angles[1]);
  }

  var11 = scripts\asm\shared\utility::getshootfrompos();
  var12 = scripts\asm\track::getshootpos(var11);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe()) {
    var13 = 0;
  } else if(isDefined(var13) || self iscurrentenemyvalid()) {
    if(isDefined(var13)) {
      var14 = var13.shootpos;
    } else {
      jumpiffalse(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000) LOC_00000160;
      return false;
    }

    if(distance2dsquared(var14, self.origin) < 22500) {
      return false;
    }

    var15 = var14 - self getposonpath(32);
    var16 = vectortoyaw(var15);

    if(abs(angleclamp180(var16 - self.angles[1])) < 45) {
      return false;
    }

    var13 = angleclamp180(var11 - var16);
  } else if(istrue(self._blackboard.forcestrafe)) {
    return false;
  } else {
    if(var13 || self pathdisttogoal() < 64) {
      return false;
    }

    var13 = angleclamp180(var12 - self.desiredangle);
  }

  if(abs(angleclamp180(var13 - var13)) < 45) {
    return false;
  }

  var17 = scripts\asm\soldier\move::yawdiffto2468(var13);
  var18 = scripts\asm\soldier\move::yawdiffto2468(var13);

  if(var17 == var18) {
    return false;
  }

  var19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var20 = scripts\asm\shared\utility::getbasearchetype();
    var19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
    self.strafepoispeedtarget = getnearestspeedthresholdname(var20, var19);
  } else {
    self.strafepoispeedtarget = undefined;
  }

  var21 = var19 + "_" + self.asm.strafe_foot + "_" + var17 + "_to_" + var18;

  if(!scripts\asm\asm::asm_hasalias(var7, var21)) {
    if(var17 == "4" || var17 == "6") {
      var21 = var19 + "_feet_together_" + var17 + "_to_" + var18;
    } else {
      var21 = var19 + "_foot_l_forward_" + var17 + "_to_" + var18;
    }

    if(!scripts\asm\asm::asm_hasalias(var7, var21)) {
      return false;
    }
  }

  self.asm.strafeaimchangealias = var21;
  return true;
}

function ref_134bb(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfired(var0, "code_move") && ref_134bc(var0, var1, var2, var3)) {
    return true;
  }

  return false;
}

function ref_134bd(var0, var1, var2, var3) {
  if(!scripts\asm\soldier\arrival::shoulddoarrival()) {
    return false;
  }

  if(self.facemotion) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(isDefined(self.node) && isDefined(self.node.angles)) {
    return false;
  }

  var4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var4)) {
    if(scripts\engine\utility::absangleclamp180(var4.angles[1] - self.angles[1]) > 15) {
      return false;
    }
  }

  if(self getreacquirestate() == "enabled" && self._blackboard.reacquiresteptime >= gettime() - 50) {
    return false;
  }

  var5 = self.requestedgoalpos - self.origin;
  var6 = length(var5);

  if(var6 > 96) {
    return false;
  }

  if(var6 < self pathdisttogoal() * 0.8) {
    return false;
  }

  var7 = vectortoyaw(var5);
  var8 = angleclamp180(var7 - self.angles[1]);
  var9 = getangleindex(var8, 22.5);
  var10 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var11 = scripts\asm\shared\utility::getbasearchetype();
  var12 = length(self.velocity);
  var13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
  var14 = getanimspeedthreshold(var11, "walk");
  var15 = getanimspeedthreshold(var11, "shuffle");
  var16 = getanimspeedthreshold(var11, "fast");

  if(!var14 && !var15 && !var16) {
    return false;
  }

  var17 = "l";

  if(self.asm.footsteps.foot == "right") {
    var17 = "r";
  }

  var18 = var13 + var10[var9] + var17;
  var19 = scripts\asm\asm::asm_lookupanimfromalias(var2, var18);
  var20 = scripts\asm\asm::asm_getxanim(var2, var19);
  var21 = getmovedelta(var20);
  var22 = length(var21);

  if(var22 < 0.75 * var6 || var22 > 1.5 * var6) {
    return false;
  }

  var23 = length2d(self.velocity) * level.framedurationseconds;
  var24 = self getposonpath(var23);

  if(var22 < length(self.requestedgoalpos - var24)) {
    return false;
  }

  var25 = 0.7;
  var26 = 1.3;

  if(var13 == "shuffle") {
    var25 = 0.9;
  } else if(var13 == "fast") {
    var26 = 1.2;
  }

  self.asm.strafearrival_animindex = var19;
  self.asm.strafearrival_idealstartpos = self.requestedgoalpos - rotatevector(var21, self.angles);
  var27 = getnearestspeedthresholdname(var11, var13);

  if(isDefined(var27)) {
    self.asm.strafearrival_rate = clamp(var12 / var27, var25, var26);
  } else {
    self.asm.strafearrival_rate = var25;
  }

  self.asm.strafearrival_duration = int(getanimlength(var20) * self.asm.strafearrival_rate * 750);
  return true;
}

function ref_13488(var0, var1, var2) {
  var3 = "";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var4 = scripts\asm\soldier\move::determinedesiredexitspeed();
    var5 = scripts\asm\shared\utility::getbasearchetype();
    var3 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
    self.exitspeedtarget = getnearestspeedthresholdname(var5, var3);
  } else {
    self.exitspeedtarget = undefined;
  }

  if(!scripts\asm\soldier\move::checktransitionpreconditions()) {
    return undefined;
  }

  var6 = undefined;
  var7 = 0;

  if(isDefined(var2)) {
    var7 = var2;
  }

  var6 = scripts\asm\soldier\move::determinestartanim(var1, var7, var3);
  return var6;
}

function ref_134a8(var0, var1, var2, var3) {
  var4 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      var4 = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      var4 = self._blackboard.shootparams_ent.origin;
    }
  }

  if(!isDefined(var4)) {
    if(isDefined(self.smartfacingpos)) {
      var4 = self.smartfacingpos;
    }
  }

  if(!isDefined(var4)) {
    var5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349a();

    if(isDefined(var5) && isalive(var5)) {
      var4 = var5.origin;
    }
  }

  if(!isDefined(var4) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36 && self.combatmode != "no_cover") {
    var4 = self.node.origin + anglesToForward(self.node.angles) * 384;
  }

  if(!isDefined(var4)) {
    return false;
  }

  var6 = self.angles[1] - vectortoyaw(var4 - self.origin);
  var7 = distancesquared(self.origin, var4);

  if(var7 < 65536) {
    var8 = sqrt(var7);

    if(var8 > 3) {
      var6 += asin(-3 / var8);
    }
  }

  return abs(angleclamp180(var6)) > self.turnthreshold;
}

function soldier_br_chooseexposedidle(var0, var1, var2) {
  if(!soldier_br_isalert()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "casual");
  }

  return scripts\asm\soldier\script_funcs::chooseanimidle_interiorexterior(var0, var1, var2);
}

function soldier_br_isalert(var0, var1, var2, var3) {
  return self.spec == "soldier_lw_br_rpg" || self.alertlevel != "noncombat";
}

function soldier_br_playturnanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  scripts\common\gameskill::didsomethingotherthanshooting();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy)) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle 3d", self.angles);
  }

  if(isDefined(self.node)) {
    self animmode("angle deltas");
  } else {
    self animmode("zonly_physics");
  }

  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self.stepoutyaw = angleclamp180(getangledelta(var4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var5 = 1;
  self aisetanim(var1, var3, var5);

  if(scripts\asm\soldier\script_funcs::shouldfaceenemyinexposed()) {
    thread scripts\asm\soldier\script_funcs::playturnanim_turnanimanglefixup(var4, var1);
  }

  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function soldier_br_chooseturnanim(var0, var1, var2) {
  if(!soldier_br_isalert()) {
    self.desiredturnyaw = scripts\asm\soldier\script_funcs::getturndesiredyaw();
    var3 = scripts\asm\soldier\patrol::patrol_choosestationaryturnanim(var0, var1, var2);
    self.desiredturnyaw = undefined;
    return var3;
  }

  return scripts\asm\soldier\script_funcs::chooseturnanim(var1, var2, var3);
}

function soldier_br_playturnanim_cleanup(var0, var1, var2) {
  self.useanimgoalweight = 0;
  self.stepoutyaw = undefined;
  self.desiredturnyaw = undefined;
}