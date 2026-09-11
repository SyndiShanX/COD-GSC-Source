/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\arrival.gsc
***********************************************/

function shoulddoarrival() {
  if(istrue(self.disablearrivals)) {
    return false;
  }

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) < 16384) {
    return false;
  }

  if(self.stairsstate != "none" || self stairswithindistance(256)) {
    return false;
  }

  return true;
}

function notshouldstartarrival(var0, var1, var2, var3) {
  return !shouldstartarrival(var0, var1, var3);
}

function getmaxarrivaldistfornodetype(var0) {
  return 256;
}

function shouldstartarrival(var0, var1, var2, var3) {
  if(!shoulddoarrival()) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  var4 = scripts\asm\shared\utility::getarrivalnode();

  if(!scripts\asm\asm::asm_eventfired(var0, "cover_approach")) {
    return false;
  }

  if(isDefined(var3)) {
    if(!isarray(var3)) {
      var5 = var3;
    } else if(var4.size < 1) {
      var5 = "Exposed";
    } else {
      var5 = var5[0];
    }
  } else {
    var5 = "Exposed";
  }

  if(!scripts\asm\shared\utility::isarrivaltype(var3, var4, var5, var5)) {
    return false;
  }

  var6 = distance(self.origin, self.pathgoalpos);
  var7 = getmaxarrivaldistfornodetype(var5);

  if(var6 > var7) {
    return false;
  }

  var8 = 0;

  if(isDefined(var5) && var5.size > 1) {
    var8 = int(var5[1]);
  }

  var9 = undefined;
  var10 = undefined;
  var11 = undefined;

  if(var5 == "Exposed Moving") {
    var11 = "code_move";
  }

  var12 = scripts\asm\asm::asm_getdemeanor();

  if(var12 == "casual" || var12 == "casual_gun" || var12 == "patrol") {
    var13 = 0.053;

    if(self pathdisttogoal() < 25) {
      var13 = 2;
    }

    self.asm.stopdata = calculatestopdata(var3, var4, var5, var5, var8, undefined, var9, var13, undefined, var10, var11);
  } else {
    self.asm.stopdata = calculatestopdata(var3, var4, var5, var5, var8, undefined, var9, undefined, undefined, var10, var11);
  }

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function shouldstartcasualarrivalaftercodemove(var0, var1, var2, var3) {
  if(!scripts\asm\asm::asm_eventfired(var0, "code_move")) {
    return 0;
  }

  return shouldstartcasualarrival(var0, var1, var2, var3);
}

function shouldstartcasualarrival(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var3) || var4 != var3[2]) {
    return false;
  }

  return shouldstartarrival(var0, var1, var2, var3);
}

function shouldstartcasualarrivalwithgunaftercodemove(var0, var1, var2, var3) {
  if(!scripts\asm\asm::asm_eventfired(var0, "code_move")) {
    return 0;
  }

  return shouldstartcasualarrivalwithgun(var0, var1, var2, var3);
}

function shouldstartcasualarrivalwithgun(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var3) || var4 != var3[2]) {
    return false;
  }

  return shouldstartarrival(var0, var1, var2, var3);
}

function patrolshouldstop() {
  var0 = scripts\asm\shared\utility::getarrivalnode();

  if(!isDefined(var0)) {
    return 1;
  }

  if(!isDefined(var0.patrol_stop)) {
    return 1;
  }

  return var0.patrol_stop;
}

function shouldstartarrivalpatrol(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return false;
  }

  if(!patrolshouldstop()) {
    return false;
  }

  if(isDefined(self._blackboard.doortoopen)) {
    return false;
  }

  return shouldstartarrival(var0, var1, var2, var3);
}

function chooseanim_arrival(var0, var1, var2) {
  return self.asm.stopdata;
}

function calculatestopdata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(var12) && !self btgoalvalid() && isDefined(self.scriptedarrivalent) && self.scriptedarrivalent == var12) {
    if(distance2dsquared(self.scriptedarrivalent.origin, self.pathgoalpos) > 4096) {
      if(!isDefined(self.scriptedarrivalent.calculatestopdatawarningtime) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration) {
        self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
      } else {
        self.scriptedarrivalent delete();
        self.scriptedarrivalent = undefined;
        var12 = scripts\asm\shared\utility::getarrivalnode();
      }
    }
  }

  var13 = undefined;

  if(isDefined(var12)) {
    var13 = var12.origin;
  } else {
    var13 = self.pathgoalpos;
  }

  var14 = var13 - self.origin;
  var14 = vectorNormalize((var14[0], var14[1], 0));

  if(vectordot(var14, anglesToForward(self.angles)) < 0.707) {
    return undefined;
  }

  if(var3 == "Custom") {
    var2 = self.asm.customdata.arrivalstate;
    var4 = self.asm.customdata.arrivalusefootdown;
  }

  if(!isDefined(var6)) {
    var6 = "";
  }

  var15 = "";

  if(var4) {
    var16 = "left";

    if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_left")) {
      var16 = "left";
    } else if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_right")) {
      var16 = "right";
    } else if(self.asm.footsteps.foot == "right") {
      var16 = "right";
    }

    if(isDefined(var6)) {
      var15 = var6 + var16;
    } else {
      var15 = var16;
    }
  } else {
    var15 = var6;
  }

  var17 = scripts\asm\shared\utility::nodeshouldfaceangles(var12);
  var18 = undefined;
  var19 = undefined;

  if((var3 == "Exposed" || var3 == "Exposed Crouch") && (scripts\anim\utility_common::recentlysawenemy() || scripts\asm\shared\utility::shouldinitiallyattackfromexposed())) {
    if(!scripts\asm\asm_bb::bb_shootparamsvalid() && !isDefined(self.smartfacingpos)) {
      if(isDefined(var12) && isDefined(var12.angles)) {
        var18 = var12.angles[1];
        var19 = var12.angles;
        var17 = 1;
      } else {
        var17 = 0;
      }
    } else {
      var20 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
      var19 = (0, self.angles[1] + var20, 0);
      var18 = var19[1];
      var17 = 1;
    }
  } else if(var17) {
    var18 = scripts\asm\shared\utility::getnodeforwardyaw(var12, undefined, 0);
    var19 = var12.angles;
  }

  var21 = self actorcalcstopdata(var13, var19, getcustomarrivalangles(), var5, var17, var2, var18, var15, var6, var7, var8, var3, var9, var10, var11);
  return var21;
}

function playanim_waitforpathset(var0, var1) {
  self endon("runto_arrived");
  self endon(var1 + "_finished");
  self waittill("path_set");
  scripts\asm\asm::asm_fireevent(var0, "abort");
}

function playanim_waitforpathclear(var0, var1) {
  self endon("runto_arrived");
  self endon(var1 + "_finished");

  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  scripts\asm\asm::asm_fireevent(var0, "abort");
}

function arrivalterminate_patrol(var0, var1, var2) {
  self motionwarpcancel();
  self finishcoverarrival();

  if(patrolshouldstop()) {
    var3 = scripts\asm\shared\utility::getarrivalnode();
    var4 = self;

    if(scripts\asm\shared\utility::nodeshouldfaceangles(var3)) {
      var4 = var3;
    }

    self orientmode("face angle", var4.angles[1]);
    return;
  }
}

function arrivalterminatewait(var0) {
  self endon("death");
  self.asm.arriving = var0;
  self waittill(var0 + "_finished");
  self.asm.arriving = undefined;
}

function finisharrival(var0, var1, var2) {
  self motionwarpcancel();
  self finishcoverarrival();
}

function playanim_arrival_handlestandevent(var0, var1, var2, var3) {
  self endon(var1 + "_finished");
  self.asm.arrivalstopfired = 0;
  var4 = getmovedelta(var2, 0, 1);
  var5 = getanimlength(var2);
  var6 = 0.05 / var5;
  var7 = 1 - var6;

  while(var7 > 0) {
    var8 = getmovedelta(var2, 0, var7);

    if(lengthsquared(var4 - var8) >= 64) {
      break;
    }

    var7 -= var6;
  }

  var9 = var7 * var5 / var3;
  wait var9;
  self.asm.arrivalstopfired = 1;
}

function returnoncorner(var0) {
  if(var0 == "corner") {
    return 1;
  }
}

function returnonwarpstart(var0) {
  if(var0 == "warp_arrival_start") {
    return 1;
  }
}

function calculateadjustedspeedforshortpath(var0, var1) {
  var2 = 64;
  var3 = 110;

  if(var1 >= var2 && var1 <= var3) {
    var4 = (var1 - var2) / (var3 - var2);
    var5 = self aigettargetspeed();
    return ((1 - var4) * var5 + var4 * var0);
  }

  return var2;
}

function playanim_arrival(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 1;

  if(isDefined(var2)) {
    var3 = var2;
  }

  self.asm.arrivalasmstatename = var1;
  self.a.arrivalasmstatename = var1;
  thread arrivalterminatewait(var1);
  var4 = scripts\asm\asm::asm_getanim(var0, var1);

  if(!isDefined(var4)) {
    self orientmode("face motion");
    scripts\asm\asm::asm_fireevent(var0, "abort", undefined);
    return;
  }

  self orientmode("face angle", self.angles[1]);
  var5 = var4.finalangles;
  var6 = var4.angleindex;
  var7 = (0, var5[1] - var4.angledelta, 0);
  var8 = var4.startpos;
  var9 = var7[1];

  if(isDefined(var4.parentpos) && isDefined(var4.parentangles)) {
    var10 = var4.startpos - var4.parentpos;
    var10 = rotatevectorinverted(var10, var4.parentangles);
    var11 = invertangles(var4.parentangles);
    var12 = combineangles(var7, var11);
    var13 = self getnavspaceent();
    var10 = rotatevector(var10, var13.angles);
    var8 = var10 + var13.origin;
    var14 = combineangles(var12, var13.angles);
    var9 = var14[1];
  }

  var15 = var1;

  if(isDefined(self.asm.customdata) && isDefined(self.asm.customdata.arrivalstate)) {
    var15 = self.asm.customdata.arrivalstate;
  }

  var16 = var4.stopanim;
  var17 = scripts\asm\asm::asm_getxanim(var15, var16);
  var18 = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(var4.customtargetpos)) {
    var19 = var4.customtargetpos;
  } else if(isDefined(var19)) {
    var19 = var19.origin;
  } else {
    var19 = self.pathgoalpos;
  }

  if(!istrue(var6.bskipstartcoverarrival)) {
    self startcoverarrival();
  }

  if(animhasnotetrack(var19, "code_move")) {
    self animmode("zonly_physics", 0);
    var20 = scripts\engine\utility::motionwarpwithnotetracks(var19, var19, var6.finalangles, undefined, "corner", undefined);
    self aisetanim(var17, var18, var20);
    scripts\asm\asm::asm_donotetracks(var2, var3, &returnoncorner, undefined, var17);
    self aisetanim(var17, var18, 1);
    scripts\asm\asm::asm_donotetracks(var2, var3, undefined, undefined, var17);
    return;
  }

  if(isDefined(self.asm.customdata.custom_arrival_animmode)) {
    var21 = self.asm.customdata.custom_arrival_animmode;
    self animmode(var21);
  } else {
    self animmode("zonly_physics", 0);
  }

  scripts\asm\asm::asm_playfacialanim(var3, var4, var19);
  var22 = 1;

  if(isDefined(var20)) {
    var23 = length(var7.movedelta);
    var24 = length(self.origin - var20);

    if(var24 > 1) {
      var22 = var23 / length(self.origin - var20);
    }

    var22 = clamp(var22, 0.8, 1.3);
  }

  var25 = var6 * var22;

  if(isDefined(self.arrivalspeed)) {
    var25 *= self.arrivalspeed;
  }

  if(isDefined(self.arrivalspeedtarget) && isDefined(self.arrivaldesiredspeed) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var25 = self.arrivaldesiredspeed / self.arrivalspeedtarget;
    self.arrivaldesiredspeed = undefined;
    var26 = 0.8;
    var25 = max(var26, var25);
  }

  thread playanim_arrival_handlestandevent(var3, var4, var19, var25);
  self aisetanim(var18, var19, var25);
  var27 = 1;

  if(animhasnotetrack(var19, "warp_arrival_start")) {
    var28 = getnotetracktimes(var19, "warp_arrival_start");
    var29 = getnotetracktimes(var19, "warp_arrival_end");

    if(var28[0] > 0) {
      scripts\asm\asm::asm_donotetracks(var3, var4, &returnonwarpstart, undefined, var18, 0);
    }

    var30 = getanimlength(var19);
    var31 = var28[0];

    if(var31 > 0) {
      var31 = var28[0] * var30 * 1000;
      var31 -= scripts\engine\utility::mod(int(var31), level.frameduration);
      var31 = var31 / var30 / 1000;
    }

    var27 = var29[0];
    var32 = int((var27 - var31) * var30 / var25 * 1000);
    var32 += level.frameduration - scripts\engine\utility::mod(var32, level.frameduration);
    scripts\engine\utility::motionwarpwithtimes(var19, var20, var7.finalangles, var31, 1, var32, 0);
  } else {
    var33 = 500;

    if(animhasnotetrack(var19, "start_aim")) {
      var27 = getnotetracktimes(var19, "start_aim")[0];
      var34 = getanimlength(var19);
      var33 = int(var27 * var34 / var25 * 1000);

      if(var33 < 300 && var34 / var25 >= 0.15) {
        var33 = 300;
      }
    }

    self motionwarpwithanim(var16, var15, var20, var7.finalangles, var33);
  }

  if(!isagent(self)) {
    var35 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var4, "conceal_add");

    if(isDefined(var35) && isDefined(var19) && isDefined(var19.type) && (var19.type == "Conceal Crouch" || var19.type == "Conceal Stand")) {
      var36 = scripts\asm\asm::asm_getxanim(var4, var35);
      var30 = getanimlength(var19);
      var37 = var30 * var27 * 0.3;
      thread scripts\asm\soldier\cover::start_conceal_add(var4, var36, var37);
    }
  }

  scripts\asm\asm::asm_donotetracks(var3, var4, scripts\asm\asm::asm_getnotehandler(var3, var4), undefined, var18);
  self.a.movement = "stop";
}

function getcustomarrivalangles() {
  if(isDefined(self.asm.customdata.arrivalangles)) {
    return self.asm.customdata.arrivalangles;
  }

  return undefined;
}

function getstopanims(var0, var1, var2, var3, var4) {
  var5 = [];
  GscBinSkip0(0x2e, 5, scripts\asm\asm::asm_lookupdirectionalfootanim(1, var0, var1, var3, var4));
}

function shouldconsiderarrival(var0, var1, var2, var3) {
  if(!shoulddoarrival()) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(isDefined(self._blackboard.doortoopen)) {
    return false;
  }

  if(!scripts\asm\asm::asm_eventfired(var0, "cover_approach")) {
    return false;
  }

  return true;
}

function shouldconsiderarrivalaftercodemove(var0, var1, var2, var3) {
  if(!scripts\asm\asm::asm_eventfired(var0, "code_move")) {
    return false;
  }

  return shouldconsiderarrival(var0, var1, var2, var3);
}

function shouldstartarrivalpassthroughswitchcustom(var0, var1, var2, var3) {
  var4 = "Custom";
  var5 = distance(self.origin, self.pathgoalpos);
  var6 = getmaxarrivaldistfornodetype(var4);

  if(var5 > var6) {
    return false;
  }

  var7 = 0;

  if(isDefined(self.asm.customdata.arrivalusefootdown)) {
    var7 = self.asm.customdata.arrivalusefootdown;
  }

  var8 = scripts\asm\asm::asm_geteventdata(var0, "cover_approach");
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = "";
  var13 = undefined;

  if(isDefined(self.asm.customdata.arrivaloptionalprefix)) {
    var13 = self.asm.customdata.arrivaloptionalprefix;
  }

  self.asm.stopdata = calculatestopdata(var0, var1, self.asm.customdata.arrivalstate, var4, var7, var8, var13, var11, undefined, var9, var10, var12);

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function shouldstartarrivalpassthroughswitch(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    if(!isarray(var3)) {
      var4 = var3;
    } else if(var4.size < 1) {
      var4 = "Exposed";
    } else {
      var4 = var4[0];
    }
  } else {
    var4 = "Exposed";
  }

  var5 = self aiprecalcshouldstartarrival();

  if(!isDefined(var5)) {
    return false;
  }

  if(isDefined(var5["desiredspeed"])) {
    self.arrivaldesiredspeed = var5["desiredspeed"];
  }

  if(isDefined(var5["targetspeed"])) {
    self.arrivalspeedtarget = var5["targetspeed"];
  } else {
    self.arrivalspeedtarget = undefined;
  }

  var6 = "";

  if(isDefined(var5["speed"])) {
    var6 = var5["speed"];
  }

  var7 = 0;

  if(isDefined(var4) && isarray(var4) && var4.size >= 2) {
    var7 = 1;
  }

  var8 = scripts\asm\asm::asm_geteventdata(var3, "cover_approach");
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;

  if(var4 == "Exposed Moving") {
    var10 = "code_move";
    var11 = 0.07;
  }

  self.asm.stopdata = calculatestopdata(var3, var4, var4, var4, var7, var8, undefined, var11, undefined, var9, var10, var6);

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function shouldstartarrivalpassthrough(var0, var1, var2, var3) {
  return false;
}

function shouldstartarrivalpassthroughcivilian(var0, var1, var2, var3) {
  if(!isDefined(var3) || var3.size < 1) {
    var4 = "Exposed";
  } else {
    var4 = var4[0];
  }

  if(!scripts\asm\shared\utility::isarrivaltypecivilian(var1, var4)) {
    return false;
  }

  var5 = distance(self.origin, self.pathgoalpos);
  var6 = getmaxarrivaldistfornodetype(var4);

  if(var5 > var6) {
    return false;
  }

  var7 = 0;

  if(isDefined(var4) && var4.size >= 2) {
    var7 = 1;
  }

  var8 = scripts\asm\asm::asm_geteventdata(var1, "cover_approach");
  var9 = "";
  var10 = scripts\asm\asm_bb::bb_getcivilianstate();

  if(var10 == "panic" || var10 == "stealth" || var10 == "casual") {
    var11 = length(self.velocity);
    var12 = scripts\asm\shared\utility::getbasearchetype();
    var9 = getnextlowestspeedthresholdstring(var12, var11);
    self.arrivalspeedtarget = getnearestspeedthresholdname(var12, var9);
  } else {
    self.arrivalspeedtarget = undefined;
  }

  var13 = 0.053;

  if(self pathdisttogoal() < 25) {
    var13 = 2;
  }

  self.asm.stopdata = calculatestopdata(var1, var2, var3, var4, var7, var8, undefined, var13, 0.3, undefined, undefined, var9);

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function transition_arrivalisstopped(var0, var1, var2, var3) {
  return self.asm.arrivalstopfired;
}

function chooseanim_zeroarrival(var0, var1, var2) {
  var3 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_left")) {
    var3 = "left";
  } else if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_right")) {
    var3 = "right";
  } else if(self.asm.footsteps.foot == "right") {
    var3 = "right";
  }

  var4 = "shuffle";
  var5 = 0;
  var6 = scripts\asm\shared\utility::getarrivalnode();
  var7 = scripts\asm\shared\utility::nodeshouldfaceangles(var6);
  var8 = 6400;

  if(scripts\anim\utility_common::recentlysawenemy() || !isDefined(self.enemy)) {
    var5 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
  } else if(var7 && length2dsquared(var6.origin - self.origin) < var8) {
    var5 = scripts\asm\shared\utility::getnodeforwardyaw(var6) - self.angles[1];
  } else if(istrue(self.allowattackfromexposednonode)) {
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

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var10 = self aigettargetspeed();
    var11 = scripts\asm\shared\utility::getbasearchetype();
    var4 = getnextlowestspeedthresholdstring(var11, var10);
  }

  var12 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var13 = getangleindex(var5, 22.5);
  var14 = var3 + var12[var13] + var4;
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
}

function playanim_zeroarrival(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = 1;
  self aisetanim(var1, var3, var5);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self clearpath();
}

function playanim_zeroarrival_cleanup(var0, var1, var2) {}