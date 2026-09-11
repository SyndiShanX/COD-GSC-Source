/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_t_reflex_create_script_quadrace.gsc
********************************************************************/

function ref_134b8(var_0, var_1, var_2, var_3) {
  if(!soldier_br_isalert()) {
    return false;
  }

  if(istrue(self.noturnanims)) {
    return false;
  }

  var_4 = scripts\asm\asm::asm_geteventtime(var_0, "sharp_turn");

  if(!isDefined(var_4)) {
    return false;
  }

  var_5 = 50;
  var_6 = gettime();

  if(var_6 - var_4 > var_5) {
    return false;
  }

  var_7 = scripts\asm\asm::asm_geteventdata(var_0, "sharp_turn");
  var_8 = var_7[1];
  var_9 = var_7[2];
  var_10 = var_7[3];
  var_11 = 22500;

  if(var_9 && self pathdisttogoal() > 90 || lengthsquared(self.velocity) > var_11) {
    var_12 = 0;
    var_13 = undefined;

    if(!isarray(var_3)) {
      var_14 = var_3;
    } else {
      var_14 = var_4[0];

      if(var_4.size > 1 && var_4[1] == 1) {
        var_13 = 1;
      }

      if(var_4.size > 2) {
        var_14 = scripts\asm\asm_bb::bb_getprefixstring(var_4[2]);
      }
    }

    var_15 = "";

    if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentnotabomber()) {
      var_15 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
      var_16 = scripts\asm\shared\utility::getbasearchetype();
      self.turnspeedtarget = getnearestspeedthresholdname(var_16, var_15);
    } else {
      self.turnspeedtarget = undefined;
    }

    var_17 = ref_13484(var_1, var_14, var_11, var_9, var_10, var_13, var_14, var_15);

    if(!isDefined(var_17)) {
      return false;
    }

    if(self.a.sharpturnnumberindex > 2 && self.a.sharpturnnumberindex < 6) {
      return false;
    }

    self.a.sharpturnindex = var_17;
    self.a.sharpturncorner = var_11;
    self.a.sharpturnnextpathpoint = var_9;
    return true;
  }

  return false;
}

function ref_13484(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 22.5;

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  if(!isDefined(var_7)) {
    var_7 = "";
  }

  if(var_5) {
    if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left")) {
      var_9 = var_6 + "left";
    } else if(scripts\asm\asm::asm_eventfiredrecently(var_1, "pass_right")) {
      var_9 = var_7 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_9 = var_8 + "right";
    } else {
      var_9 += "left";
    }
  } else {
    var_9 = var_9;
  }

  var_10 = self actorcalcsharpturnanim(var_5, var_6, var_7, var_9, var_9, var_9, var_9);
  var_11 = var_10[0];
  var_12 = var_10[1];
  var_10 = undefined;
  self.a.sharpturnnumberindex = var_12;
  return var_11;
}

function ref_13490(var_0, var_1, var_2) {
  return self.a.sharpturnindex;
}

function ref_1348b(var_0, var_1, var_2) {
  var_3 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left")) {
    var_3 = "left";
  } else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_right")) {
    var_3 = "right";
  } else if(self.asm.footsteps.foot == "right") {
    var_3 = "right";
  }

  var_4 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
  var_5 = 0;
  var_6 = scripts\asm\shared\utility::getarrivalnode();
  var_7 = scripts\asm\shared\utility::nodeshouldfaceangles(var_6);
  var_8 = 6400;

  if(scripts\anim\utility_common::recentlysawenemy() || !isDefined(self.enemy)) {
    var_5 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
  } else if(var_7 && length2dsquared(var_6.origin - self.origin) < var_8) {
    var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_6) - self.angles[1];
  } else if(istrue(self.brjugg_watchstartnotify)) {
    var_9 = 0;

    if(issentient(self.enemy)) {
      var_9 = self hastacvis(self.enemy);
    } else {
      var_9 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);
    }

    if(var_9) {
      var_5 = vectortoyaw(self.enemy.origin - self.origin);
    }
  }

  var_5 = angleclamp180(var_5);
  var_10 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var_11 = getangleindex(var_5, 22.5);
  var_12 = var_3 + var_10[var_11] + var_4;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_12);
}

function ref_134bc(var_0, var_1, var_2, var_3) {
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

  var_4 = scripts\asm\soldier\move::getstairsenterdist();
  var_5 = self getstairsstateatdist(var_4);

  if(var_5 != "none") {
    return false;
  }

  var_6 = self aigettargetspeed();

  if(self.lookaheaddist < 90) {
    return false;
  }

  var_7 = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9) {
    return false;
  }

  var_8 = self asmeventfiredwithin(var_0, "sharp_turn", 50);

  if(var_8) {
    var_9 = angleclamp180(var_7 - self.angles[1]);
    var_10 = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(var_10 - var_9)) > 45) {
      return false;
    }
  } else {
    var_10 = angleclamp180(var_8 - self.angles[1]);
  }

  var_11 = scripts\asm\shared\utility::getshootfrompos();
  var_12 = scripts\asm\track::getshootpos(var_11);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe()) {
    var_13 = 0;
  } else if(isDefined(var_13) || self iscurrentenemyvalid()) {
    if(isDefined(var_13)) {
      var_14 = var_13.shootpos;
    } else {
      jumpiffalse(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000) LOC_00000160;
      return false;
    }

    if(distance2dsquared(var_14, self.origin) < 22500) {
      return false;
    }

    var_15 = var_14 - self getposonpath(32);
    var_16 = vectortoyaw(var_15);

    if(abs(angleclamp180(var_16 - self.angles[1])) < 45) {
      return false;
    }

    var_13 = angleclamp180(var_11 - var_16);
  } else if(istrue(self._blackboard.forcestrafe)) {
    return false;
  } else {
    if(var_13 || self pathdisttogoal() < 64) {
      return false;
    }

    var_13 = angleclamp180(var_12 - self.desiredangle);
  }

  if(abs(angleclamp180(var_13 - var_13)) < 45) {
    return false;
  }

  var_17 = scripts\asm\soldier\move::yawdiffto2468(var_13);
  var_18 = scripts\asm\soldier\move::yawdiffto2468(var_13);

  if(var_17 == var_18) {
    return false;
  }

  var_19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_20 = scripts\asm\shared\utility::getbasearchetype();
    var_19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
    self.strafepoispeedtarget = getnearestspeedthresholdname(var_20, var_19);
  } else {
    self.strafepoispeedtarget = undefined;
  }

  var_21 = var_19 + "_" + self.asm.strafe_foot + "_" + var_17 + "_to_" + var_18;

  if(!scripts\asm\asm::asm_hasalias(var_7, var_21)) {
    if(var_17 == "4" || var_17 == "6") {
      var_21 = var_19 + "_feet_together_" + var_17 + "_to_" + var_18;
    } else {
      var_21 = var_19 + "_foot_l_forward_" + var_17 + "_to_" + var_18;
    }

    if(!scripts\asm\asm::asm_hasalias(var_7, var_21)) {
      return false;
    }
  }

  self.asm.strafeaimchangealias = var_21;
  return true;
}

function ref_134bb(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "code_move") && ref_134bc(var_0, var_1, var_2, var_3)) {
    return true;
  }

  return false;
}

function ref_134bd(var_0, var_1, var_2, var_3) {
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

  var_4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var_4)) {
    if(scripts\engine\utility::absangleclamp180(var_4.angles[1] - self.angles[1]) > 15) {
      return false;
    }
  }

  if(self getreacquirestate() == "enabled" && self._blackboard.reacquiresteptime >= gettime() - 50) {
    return false;
  }

  var_5 = self.requestedgoalpos - self.origin;
  var_6 = length(var_5);

  if(var_6 > 96) {
    return false;
  }

  if(var_6 < self pathdisttogoal() * 0.8) {
    return false;
  }

  var_7 = vectortoyaw(var_5);
  var_8 = angleclamp180(var_7 - self.angles[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var_11 = scripts\asm\shared\utility::getbasearchetype();
  var_12 = length(self.velocity);
  var_13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
  var_14 = getanimspeedthreshold(var_11, "walk");
  var_15 = getanimspeedthreshold(var_11, "shuffle");
  var_16 = getanimspeedthreshold(var_11, "fast");

  if(!var_14 && !var_15 && !var_16) {
    return false;
  }

  var_17 = "l";

  if(self.asm.footsteps.foot == "right") {
    var_17 = "r";
  }

  var_18 = var_13 + var_10[var_9] + var_17;
  var_19 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_18);
  var_20 = scripts\asm\asm::asm_getxanim(var_2, var_19);
  var_21 = getmovedelta(var_20);
  var_22 = length(var_21);

  if(var_22 < 0.75 * var_6 || var_22 > 1.5 * var_6) {
    return false;
  }

  var_23 = length2d(self.velocity) * level.framedurationseconds;
  var_24 = self getposonpath(var_23);

  if(var_22 < length(self.requestedgoalpos - var_24)) {
    return false;
  }

  var_25 = 0.7;
  var_26 = 1.3;

  if(var_13 == "shuffle") {
    var_25 = 0.9;
  } else if(var_13 == "fast") {
    var_26 = 1.2;
  }

  self.asm.strafearrival_animindex = var_19;
  self.asm.strafearrival_idealstartpos = self.requestedgoalpos - rotatevector(var_21, self.angles);
  var_27 = getnearestspeedthresholdname(var_11, var_13);

  if(isDefined(var_27)) {
    self.asm.strafearrival_rate = clamp(var_12 / var_27, var_25, var_26);
  } else {
    self.asm.strafearrival_rate = var_25;
  }

  self.asm.strafearrival_duration = int(getanimlength(var_20) * self.asm.strafearrival_rate * 750);
  return true;
}

function ref_13488(var_0, var_1, var_2) {
  var_3 = "";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_4 = scripts\asm\soldier\move::determinedesiredexitspeed();
    var_5 = scripts\asm\shared\utility::getbasearchetype();
    var_3 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
    self.exitspeedtarget = getnearestspeedthresholdname(var_5, var_3);
  } else {
    self.exitspeedtarget = undefined;
  }

  if(!scripts\asm\soldier\move::checktransitionpreconditions()) {
    return undefined;
  }

  var_6 = undefined;
  var_7 = 0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  var_6 = scripts\asm\soldier\move::determinestartanim(var_1, var_7, var_3);
  return var_6;
}

function ref_134a8(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      var_4 = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      var_4 = self._blackboard.shootparams_ent.origin;
    }
  }

  if(!isDefined(var_4)) {
    if(isDefined(self.smartfacingpos)) {
      var_4 = self.smartfacingpos;
    }
  }

  if(!isDefined(var_4)) {
    var_5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349a();

    if(isDefined(var_5) && isalive(var_5)) {
      var_4 = var_5.origin;
    }
  }

  if(!isDefined(var_4) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36 && self.combatmode != "no_cover") {
    var_4 = self.node.origin + anglesToForward(self.node.angles) * 384;
  }

  if(!isDefined(var_4)) {
    return false;
  }

  var_6 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);

  if(var_7 < 65536) {
    var_8 = sqrt(var_7);

    if(var_8 > 3) {
      var_6 += asin(-3 / var_8);
    }
  }

  return abs(angleclamp180(var_6)) > self.turnthreshold;
}

function soldier_br_chooseexposedidle(var_0, var_1, var_2) {
  if(!soldier_br_isalert()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "casual");
  }

  return scripts\asm\soldier\script_funcs::chooseanimidle_interiorexterior(var_0, var_1, var_2);
}

function soldier_br_isalert(var_0, var_1, var_2, var_3) {
  return self.spec == "soldier_lw_br_rpg" || self.alertlevel != "noncombat";
}

function soldier_br_playturnanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  scripts\common\gameskill::didsomethingotherthanshooting();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);

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

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.stepoutyaw = angleclamp180(getangledelta(var_4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var_5 = 1;
  self aisetanim(var_1, var_3, var_5);

  if(scripts\asm\soldier\script_funcs::shouldfaceenemyinexposed()) {
    thread scripts\asm\soldier\script_funcs::playturnanim_turnanimanglefixup(var_4, var_1);
  }

  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

function soldier_br_chooseturnanim(var_0, var_1, var_2) {
  if(!soldier_br_isalert()) {
    self.desiredturnyaw = scripts\asm\soldier\script_funcs::getturndesiredyaw();
    var_3 = scripts\asm\soldier\patrol::patrol_choosestationaryturnanim(var_0, var_1, var_2);
    self.desiredturnyaw = undefined;
    return var_3;
  }

  return scripts\asm\soldier\script_funcs::chooseturnanim(var_1, var_2, var_3);
}

function soldier_br_playturnanim_cleanup(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self.stepoutyaw = undefined;
  self.desiredturnyaw = undefined;
}