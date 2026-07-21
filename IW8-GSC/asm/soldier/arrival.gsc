/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\arrival.gsc
***********************************************/

shoulddoarrival() {
  if(istrue(self.disablearrivals))
    return 0;

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) < 16384)
    return 0;

  if(self.stairsstate != "none" || self stairswithindistance(256.0))
    return 0;

  return 1;
}

notshouldstartarrival(var_0, var_1, var_2, var_3) {
  return !shouldstartarrival(var_0, var_1, var_3);
}

getmaxarrivaldistfornodetype(var_0) {
  return 256.0;
}

shouldstartarrival(var_0, var_1, var_2, var_3) {
  if(!shoulddoarrival())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  var_4 = scripts\asm\shared\utility::getarrivalnode();

  if(!scripts\asm\asm::asm_eventfired(var_0, "cover_approach"))
    return 0;

  if(isDefined(var_3)) {
    if(!isarray(var_3))
      var_5 = var_3;
    else if(var_3.size < 1)
      var_5 = "Exposed";
    else
      var_5 = var_3[0];
  } else
    var_5 = "Exposed";

  if(!scripts\asm\shared\utility::isarrivaltype(var_0, var_1, var_2, var_5))
    return 0;

  var_6 = distance(self.origin, self.pathgoalpos);
  var_7 = getmaxarrivaldistfornodetype(var_5);

  if(var_6 > var_7)
    return 0;

  var_8 = 0;

  if(isDefined(var_3) && var_3.size > 1)
    var_8 = int(var_3[1]);

  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_5 == "Exposed Moving")
    var_11 = "code_move";

  var_12 = scripts\asm\asm::asm_getdemeanor();

  if(var_12 == "casual" || var_12 == "casual_gun" || var_12 == "patrol") {
    var_13 = 0.053;

    if(self pathdisttogoal() < 25.0)
      var_13 = 2.0;

    self.asm.stopdata = calculatestopdata(var_0, var_1, var_2, var_5, var_8, undefined, var_9, var_13, undefined, var_10, var_11);
  } else
    self.asm.stopdata = calculatestopdata(var_0, var_1, var_2, var_5, var_8, undefined, var_9, undefined, undefined, var_10, var_11);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

shouldstartcasualarrivalaftercodemove(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "code_move"))
    return 0;

  return shouldstartcasualarrival(var_0, var_1, var_2, var_3);
}

shouldstartcasualarrival(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var_3) || var_4 != var_3[2])
    return 0;

  return shouldstartarrival(var_0, var_1, var_2, var_3);
}

shouldstartcasualarrivalwithgunaftercodemove(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "code_move"))
    return 0;

  return shouldstartcasualarrivalwithgun(var_0, var_1, var_2, var_3);
}

shouldstartcasualarrivalwithgun(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var_3) || var_4 != var_3[2])
    return 0;

  return shouldstartarrival(var_0, var_1, var_2, var_3);
}

patrolshouldstop() {
  var_0 = scripts\asm\shared\utility::getarrivalnode();

  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.patrol_stop))
    return 1;

  return var_0.patrol_stop;
}

shouldstartarrivalpatrol(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isincombat())
    return 0;

  if(!patrolshouldstop())
    return 0;

  if(isDefined(self._blackboard.doortoopen))
    return 0;

  return shouldstartarrival(var_0, var_1, var_2, var_3);
}

chooseanim_arrival(var_0, var_1, var_2) {
  return self.asm.stopdata;
}

calculatestopdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(var_12) && !self btgoalvalid() && isDefined(self.scriptedarrivalent) && self.scriptedarrivalent == var_12) {
    if(distance2dsquared(self.scriptedarrivalent.origin, self.pathgoalpos) > 4096) {
      if(!isDefined(self.scriptedarrivalent.calculatestopdatawarningtime) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration)
        self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
      else {
        self.scriptedarrivalent delete();
        self.scriptedarrivalent = undefined;
        var_12 = scripts\asm\shared\utility::getarrivalnode();
      }
    }
  }

  var_13 = undefined;

  if(isDefined(var_12))
    var_13 = var_12.origin;
  else
    var_13 = self.pathgoalpos;

  var_14 = var_13 - self.origin;
  var_14 = vectorNormalize((var_14[0], var_14[1], 0));

  if(vectordot(var_14, anglesToForward(self.angles)) < 0.707)
    return undefined;

  if(var_3 == "Custom") {
    var_2 = self.asm.customdata.arrivalstate;
    var_4 = self.asm.customdata.arrivalusefootdown;
  }

  if(!isDefined(var_6))
    var_6 = "";

  var_15 = "";

  if(var_4) {
    var_16 = "left";

    if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left"))
      var_16 = "left";
    else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_right"))
      var_16 = "right";
    else if(self.asm.footsteps.foot == "right")
      var_16 = "right";

    if(isDefined(var_6))
      var_15 = var_6 + var_16;
    else
      var_15 = var_16;
  } else
    var_15 = var_6;

  var_17 = scripts\asm\shared\utility::nodeshouldfaceangles(var_12);
  var_18 = undefined;
  var_19 = undefined;

  if((var_3 == "Exposed" || var_3 == "Exposed Crouch") && (scripts\anim\utility_common.gsc::recentlysawenemy() || scripts\asm\shared\utility::shouldinitiallyattackfromexposed())) {
    if(!scripts\asm\asm_bb::bb_shootparamsvalid() && !isDefined(self.smartfacingpos)) {
      if(isDefined(var_12) && isDefined(var_12.angles)) {
        var_18 = var_12.angles[1];
        var_19 = var_12.angles;
        var_17 = 1;
      } else
        var_17 = 0;
    } else {
      var_20 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
      var_19 = (0, self.angles[1] + var_20, 0);
      var_18 = var_19[1];
      var_17 = 1;
    }
  } else if(var_17) {
    var_18 = scripts\asm\shared\utility::getnodeforwardyaw(var_12, undefined, 0);
    var_19 = var_12.angles;
  }

  var_21 = self actorcalcstopdata(var_13, var_19, getcustomarrivalangles(), var_5, var_17, var_2, var_18, var_15, var_6, var_7, var_8, var_3, var_9, var_10, var_11);
  return var_21;
}

playanim_waitforpathset(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  self waittill("path_set");
  scripts\asm\asm::asm_fireevent(var_0, "abort");
}

playanim_waitforpathclear(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");

  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  scripts\asm\asm::asm_fireevent(var_0, "abort");
}

arrivalterminate_patrol(var_0, var_1, var_2) {
  self motionwarpcancel();
  self finishcoverarrival();

  if(patrolshouldstop()) {
    var_3 = scripts\asm\shared\utility::getarrivalnode();
    var_4 = self;

    if(scripts\asm\shared\utility::nodeshouldfaceangles(var_3))
      var_4 = var_3;

    self orientmode("face angle", var_4.angles[1]);
  }
}

arrivalterminatewait(var_0) {
  self endon("death");
  self.asm.arriving = var_0;
  self waittill(var_0 + "_finished");
  self.asm.arriving = undefined;
}

finisharrival(var_0, var_1, var_2) {
  self motionwarpcancel();
  self finishcoverarrival();
}

playanim_arrival_handlestandevent(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.asm.arrivalstopfired = 0;
  var_4 = getmovedelta(var_2, 0.0, 1.0);
  var_5 = getanimlength(var_2);
  var_6 = 0.05 / var_5;

  for(var_7 = 1.0 - var_6; var_7 > 0.0; var_7 = var_7 - var_6) {
    var_8 = getmovedelta(var_2, 0.0, var_7);

    if(lengthsquared(var_4 - var_8) >= 64) {
      break;
    }
  }

  var_9 = var_7 * var_5 / var_3;
  wait(var_9);
  self.asm.arrivalstopfired = 1;
}

returnoncorner(var_0) {
  if(var_0 == "corner")
    return 1;
}

returnonwarpstart(var_0) {
  if(var_0 == "warp_arrival_start")
    return 1;
}

calculateadjustedspeedforshortpath(var_0, var_1) {
  var_2 = 64;
  var_3 = 110;

  if(var_1 >= var_2 && var_1 <= var_3) {
    var_4 = (var_1 - var_2) / (var_3 - var_2);
    var_5 = self aigettargetspeed();
    return (1 - var_4) * var_5 + var_4 * var_0;
  }

  return var_0;
}

playanim_arrival(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 1.0;

  if(isDefined(var_2))
    var_3 = var_2;

  self.asm.arrivalasmstatename = var_1;
  self.a.arrivalasmstatename = var_1;
  thread arrivalterminatewait(var_1);
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);

  if(!isDefined(var_4)) {
    self orientmode("face motion");
    scripts\asm\asm::asm_fireevent(var_0, "abort", undefined);
    return;
  }

  self orientmode("face angle", self.angles[1]);
  var_5 = var_4.finalangles;
  var_6 = var_4.angleindex;
  var_7 = (0, var_5[1] - var_4.angledelta, 0);
  var_8 = var_4.startpos;
  var_9 = var_7[1];

  if(isDefined(var_4.parentpos) && isDefined(var_4.parentangles)) {
    var_10 = var_4.startpos - var_4.parentpos;
    var_10 = rotatevectorinverted(var_10, var_4.parentangles);
    var_11 = invertangles(var_4.parentangles);
    var_12 = combineangles(var_7, var_11);
    var_13 = self getnavspaceent();
    var_10 = rotatevector(var_10, var_13.angles);
    var_8 = var_10 + var_13.origin;
    var_14 = combineangles(var_12, var_13.angles);
    var_9 = var_14[1];
  }

  var_15 = var_1;

  if(isDefined(self.asm.customdata) && isDefined(self.asm.customdata.arrivalstate))
    var_15 = self.asm.customdata.arrivalstate;

  var_16 = var_4.stopanim;
  var_17 = scripts\asm\asm::asm_getxanim(var_15, var_16);
  var_18 = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(var_4.customtargetpos))
    var_19 = var_4.customtargetpos;
  else if(isDefined(var_18))
    var_19 = var_18.origin;
  else
    var_19 = self.pathgoalpos;

  if(!istrue(var_4.bskipstartcoverarrival))
    self startcoverarrival();

  if(animhasnotetrack(var_17, "code_move")) {
    self animmode("zonly_physics", 0);
    var_20 = scripts\engine\utility::motionwarpwithnotetracks(var_17, var_19, var_4.finalangles, undefined, "corner", undefined);
    self aisetanim(var_15, var_16, var_20);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, ::returnoncorner, undefined, var_15);
    self aisetanim(var_15, var_16, 1);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, var_15);
    return;
  }

  if(isDefined(self.asm.customdata.custom_arrival_animmode)) {
    var_21 = self.asm.customdata.custom_arrival_animmode;
    self animmode(var_21);
  } else
    self animmode("zonly_physics", 0);

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_17);
  var_22 = 1.0;

  if(isDefined(var_19)) {
    var_23 = length(var_4.movedelta);
    var_24 = length(self.origin - var_19);

    if(var_24 > 1.0)
      var_22 = var_23 / length(self.origin - var_19);

    var_22 = clamp(var_22, 0.8, 1.3);
  }

  var_25 = var_3 * var_22;

  if(isDefined(self.arrivalspeed))
    var_25 = var_25 * self.arrivalspeed;

  if(isDefined(self.arrivalspeedtarget) && isDefined(self.arrivaldesiredspeed) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_25 = self.arrivaldesiredspeed / self.arrivalspeedtarget;
    self.arrivaldesiredspeed = undefined;
    var_26 = 0.8;
    var_25 = max(var_26, var_25);
  }

  thread playanim_arrival_handlestandevent(var_0, var_1, var_17, var_25);
  self aisetanim(var_15, var_16, var_25);
  var_27 = 1.0;

  if(animhasnotetrack(var_17, "warp_arrival_start")) {
    var_28 = getnotetracktimes(var_17, "warp_arrival_start");
    var_29 = getnotetracktimes(var_17, "warp_arrival_end");

    if(var_28[0] > 0.0)
      scripts\asm\asm::asm_donotetracks(var_0, var_1, ::returnonwarpstart, undefined, var_15, 0);

    var_30 = getanimlength(var_17);
    var_31 = var_28[0];

    if(var_31 > 0) {
      var_31 = var_28[0] * var_30 * 1000;
      var_31 = var_31 - scripts\engine\utility::mod(int(var_31), level.frameduration);
      var_31 = var_31 / var_30 / 1000;
    }

    var_27 = var_29[0];
    var_32 = int((var_27 - var_31) * var_30 / var_25 * 1000.0);
    var_32 = var_32 + (level.frameduration - scripts\engine\utility::mod(var_32, level.frameduration));
    scripts\engine\utility::motionwarpwithtimes(var_17, var_19, var_4.finalangles, var_31, 1.0, var_32, 0);
  } else {
    var_33 = 500;

    if(animhasnotetrack(var_17, "start_aim")) {
      var_27 = getnotetracktimes(var_17, "start_aim")[0];
      var_34 = getanimlength(var_17);
      var_33 = int(var_27 * var_34 / var_25 * 1000);

      if(var_33 < 300 && var_34 / var_25 >= 0.15)
        var_33 = 300;
    }

    self motionwarpwithanim(var_8, var_7, var_19, var_4.finalangles, var_33);
  }

  if(!isagent(self)) {
    var_35 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, "conceal_add");

    if(isDefined(var_35) && isDefined(var_18) && isDefined(var_18.type) && (var_18.type == "Conceal Crouch" || var_18.type == "Conceal Stand")) {
      var_36 = scripts\asm\asm::asm_getxanim(var_1, var_35);
      var_30 = getanimlength(var_17);
      var_37 = var_30 * var_27 * 0.3;
      thread scripts\asm\soldier\cover::start_conceal_add(var_1, var_36, var_37);
    }
  }

  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), undefined, var_15);
  self.a.movement = "stop";
}

getcustomarrivalangles() {
  if(isDefined(self.asm.customdata.arrivalangles))
    return self.asm.customdata.arrivalangles;

  return undefined;
}

getstopanims(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[5] = scripts\asm\asm::asm_lookupdirectionalfootanim(1, var_0, var_1, var_3, var_4);
  var_5[4] = scripts\asm\asm::asm_lookupdirectionalfootanim(2, var_0, var_1, var_3, var_4);
  var_5[3] = scripts\asm\asm::asm_lookupdirectionalfootanim(3, var_0, var_1, var_3, var_4);
  var_5[6] = scripts\asm\asm::asm_lookupdirectionalfootanim(4, var_0, var_1, var_3, var_4);
  var_5[2] = scripts\asm\asm::asm_lookupdirectionalfootanim(6, var_0, var_1, var_3, var_4);
  var_5[7] = scripts\asm\asm::asm_lookupdirectionalfootanim(7, var_0, var_1, var_3, var_4);
  var_5[0] = scripts\asm\asm::asm_lookupdirectionalfootanim(8, var_0, var_1, var_3, var_4);
  var_5[1] = scripts\asm\asm::asm_lookupdirectionalfootanim(9, var_0, var_1, var_3, var_4);
  var_5[8] = var_5[0];
  return var_5;
}

shouldconsiderarrival(var_0, var_1, var_2, var_3) {
  if(!shoulddoarrival())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(self._blackboard.doortoopen))
    return 0;

  if(!scripts\asm\asm::asm_eventfired(var_0, "cover_approach"))
    return 0;

  return 1;
}

shouldconsiderarrivalaftercodemove(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "code_move"))
    return 0;

  return shouldconsiderarrival(var_0, var_1, var_2, var_3);
}

shouldstartarrivalpassthroughswitchcustom(var_0, var_1, var_2, var_3) {
  var_4 = "Custom";
  var_5 = distance(self.origin, self.pathgoalpos);
  var_6 = getmaxarrivaldistfornodetype(var_4);

  if(var_5 > var_6)
    return 0;

  var_7 = 0;

  if(isDefined(self.asm.customdata.arrivalusefootdown))
    var_7 = self.asm.customdata.arrivalusefootdown;

  var_8 = scripts\asm\asm::asm_geteventdata(var_0, "cover_approach");
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = "";
  var_13 = undefined;

  if(isDefined(self.asm.customdata.arrivaloptionalprefix))
    var_13 = self.asm.customdata.arrivaloptionalprefix;

  self.asm.stopdata = calculatestopdata(var_0, var_1, self.asm.customdata.arrivalstate, var_4, var_7, var_8, var_13, var_11, undefined, var_9, var_10, var_12);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

shouldstartarrivalpassthroughswitch(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(!isarray(var_3))
      var_4 = var_3;
    else if(var_3.size < 1)
      var_4 = "Exposed";
    else
      var_4 = var_3[0];
  } else
    var_4 = "Exposed";

  var_5 = self aiprecalcshouldstartarrival();

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_5["desiredspeed"]))
    self.arrivaldesiredspeed = var_5["desiredspeed"];

  if(isDefined(var_5["targetspeed"]))
    self.arrivalspeedtarget = var_5["targetspeed"];
  else
    self.arrivalspeedtarget = undefined;

  var_6 = "";

  if(isDefined(var_5["speed"]))
    var_6 = var_5["speed"];

  var_7 = 0;

  if(isDefined(var_3) && isarray(var_3) && var_3.size >= 2)
    var_7 = 1;

  var_8 = scripts\asm\asm::asm_geteventdata(var_0, "cover_approach");
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_4 == "Exposed Moving") {
    var_10 = "code_move";
    var_11 = 0.07;
  }

  self.asm.stopdata = calculatestopdata(var_0, var_1, var_2, var_4, var_7, var_8, undefined, var_11, undefined, var_9, var_10, var_6);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

shouldstartarrivalpassthrough(var_0, var_1, var_2, var_3) {
  return 0;
}

shouldstartarrivalpassthroughcivilian(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || var_3.size < 1)
    var_4 = "Exposed";
  else
    var_4 = var_3[0];

  if(!scripts\asm\shared\utility::isarrivaltypecivilian(var_0, var_4))
    return 0;

  var_5 = distance(self.origin, self.pathgoalpos);
  var_6 = getmaxarrivaldistfornodetype(var_4);

  if(var_5 > var_6)
    return 0;

  var_7 = 0;

  if(isDefined(var_3) && var_3.size >= 2)
    var_7 = 1;

  var_8 = scripts\asm\asm::asm_geteventdata(var_0, "cover_approach");
  var_9 = "";
  var_10 = scripts\asm\asm_bb::bb_getcivilianstate();

  if(var_10 == "panic" || var_10 == "stealth" || var_10 == "casual") {
    var_11 = length(self.velocity);
    var_12 = scripts\asm\shared\utility::getbasearchetype();
    var_9 = getnextlowestspeedthresholdstring(var_12, var_11);
    self.arrivalspeedtarget = getnearestspeedthresholdname(var_12, var_9);
  } else
    self.arrivalspeedtarget = undefined;

  var_13 = 0.053;

  if(self pathdisttogoal() < 25.0)
    var_13 = 2.0;

  self.asm.stopdata = calculatestopdata(var_0, var_1, var_2, var_4, var_7, var_8, undefined, var_13, 0.3, undefined, undefined, var_9);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

transition_arrivalisstopped(var_0, var_1, var_2, var_3) {
  return self.asm.arrivalstopfired;
}

chooseanim_zeroarrival(var_0, var_1, var_2) {
  var_3 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left"))
    var_3 = "left";
  else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_right"))
    var_3 = "right";
  else if(self.asm.footsteps.foot == "right")
    var_3 = "right";

  var_4 = "shuffle";
  var_5 = 0;
  var_6 = scripts\asm\shared\utility::getarrivalnode();
  var_7 = scripts\asm\shared\utility::nodeshouldfaceangles(var_6);
  var_8 = 6400.0;

  if(scripts\anim\utility_common.gsc::recentlysawenemy() || !isDefined(self.enemy))
    var_5 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
  else if(var_7 && length2dsquared(var_6.origin - self.origin) < var_8)
    var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_6) - self.angles[1];
  else if(istrue(self.allowattackfromexposednonode)) {
    var_9 = 0;

    if(issentient(self.enemy))
      var_9 = self hastacvis(self.enemy);
    else
      var_9 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);

    if(var_9)
      var_5 = vectortoyaw(self.enemy.origin - self.origin);
  }

  var_5 = angleclamp180(var_5);

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_10 = self aigettargetspeed();
    var_11 = scripts\asm\shared\utility::getbasearchetype();
    var_4 = getnextlowestspeedthresholdstring(var_11, var_10);
  }

  var_12 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var_13 = getangleindex(var_5, 22.5);
  var_14 = var_3 + var_12[var_13] + var_4;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
}

playanim_zeroarrival(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = 1.0;
  self aisetanim(var_1, var_3, var_5);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self clearpath();
}

playanim_zeroarrival_cleanup(var_0, var_1, var_2) {}