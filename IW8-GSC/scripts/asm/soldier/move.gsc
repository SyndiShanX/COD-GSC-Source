/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\move.gsc
***********************************************/

function playanim_exit(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self.asm.customdata.exitstate = undefined;

  if(isDefined(self.battlechatterallowed) && self.battlechatterallowed) {
    var4 = issubstr(var1, "cover");
    thread movebattlechatter_helper(var4);
  }

  if(!isDefined(var3)) {
    var5 = self aigetdesiredspeed();
    var6 = 50;

    if(var6 > var5) {
      var6 = 0.5 * var5;
    }

    self aisettargetspeed(var6);
    scripts\asm\asm::asm_fireevent(var0, "abort");
    scripts\asm\asm::asm_fireevent(var0, "code_move");
    scripts\asm\asm::asm_fireevent(var0, "end");
    scripts\asm\asm::asm_fireevent(var0, "finish");
    return;
  }

  thread scripts\asm\shared\utility::waitfordooropen(var2, var3, 1);
  var7 = 0;

  if(isDefined(var5)) {
    var7 = var5;
  }

  playstartanim(var2, var3, var6, var7);

  if(isDefined(self.exitspeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    self aisettargetspeed(float(self.exitspeedtarget));
    return;
  }
}

function chooseanim_exit(var0, var1, var2) {
  if(!checktransitionpreconditions()) {
    return undefined;
  }

  var3 = undefined;
  var4 = 0;

  if(isDefined(var2)) {
    var4 = var2;
  }

  var3 = determinestartanim(var1, var4);
  return var3;
}

function determinedesiredexitspeed() {
  var0 = 70;
  var1 = self getdesiredscaledspeedforposalongpath(var0);

  if(self.cautiousnavigation) {
    var1 = 90;
  }

  return var1;
}

function chooseanim_exitsoldier(var0, var1, var2) {
  var3 = "";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var4 = determinedesiredexitspeed();
    var5 = scripts\asm\shared\utility::getbasearchetype();
    var3 = getanimspeedbetweenthresholds(var5, var4);
    self.exitspeedtarget = getnearestspeedthresholdname(var5, var3);
  } else {
    self.exitspeedtarget = undefined;
  }

  if(!checktransitionpreconditions()) {
    return undefined;
  }

  var6 = undefined;
  var7 = 0;

  if(isDefined(var2)) {
    var7 = var2;
  }

  var6 = determinestartanim(var1, var7, var3);
  return var6;
}

function getstartanim(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var4 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  var5 = var4[var2];

  if(var5 == 8) {
    if(var3 < 0) {
      var6 = var5 + "r" + var1;
    } else {
      var6 = var6 + "l" + var2;
    }
  } else {
    var6 += var3;
  }

  return scripts\asm\asm::asm_lookupanimfromaliasifexists(var2, var6);
}

function getstartmindist() {
  var0 = scripts\asm\asm::asm_getdemeanor();

  if(var0 == "casual" || var0 == "casual_gun" || self aigetdesiredspeed() <= 60) {
    return 75;
  }

  return 100;
}

function determinestartanim(var0, var1, var2) {
  var3 = self getnegotiationstartnode();

  if(isDefined(var3)) {
    var4 = var3.origin;
  } else {
    var4 = self.pathgoalpos;
  }

  var5 = scripts\anim\exit_node::getexitnode();

  if(var2) {
    var6 = self.origin + self.lookaheaddir * self.lookaheaddist;
    var7 = var6;
  } else {
    var6 = self getposonpath(128);
    var7 = self getposonpath(32);
  }

  var8 = vectortoangles(var6 - self.origin);
  var9 = vectortoangles(var7 - self.origin);

  if(scripts\asm\shared\utility::nodeshouldfaceangles(var7) && !var4) {
    var10 = var7.angles;
  } else {
    var10 = self.angles;
  }

  var11 = angleclamp180(var9[1] - var10[1]);
  var12 = angleclamp180(var10[1] - var10[1]);
  var13 = vectortoangles(self.lookaheaddir);
  var14 = angleclamp180(var13[1] - var10[1]);

  if(abs(var14) > 135 && abs(var11) < 90) {
    return undefined;
  }

  if(length2dsquared(self.velocity) > 16) {
    var15 = vectortoangles(self.velocity);

    if(abs(angleclamp180(var15[1] - var9[1])) < 45) {
      return;
    }
  }

  var16 = getstartmindist();

  if(self pathdisttogoal(1) < var16) {
    return;
  }

  var17 = getangleindices(var11);
  var18 = self getnavposition();
  var19 = var17[0];
  var20 = undefined;

  if(isDefined(self.asm.customdata.exitstate)) {
    var20 = getstartanim(self.asm.customdata.exitstate, var5, var19, var12);
  } else {
    var20 = getstartanim(var4, var5, var19, var12);
  }

  if(!isDefined(self.asm.customdata.exitstate)) {
    var21 = issubstr(var4, "cover");
    var22 = var10;
    jumpiffalse(var21 && isDefined(var6)) LOC_00000203;
    var23 = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
    var24 = var23[var19];

    if(issubstr(var4, "left") && var19 == 4) {
      var24 *= -1;
    }

    var22 = (0, angleclamp(var6.angles[1] + var24), 0);
    goto LOC_0000023b;
  }

  return var21;
}

function movebattlechatter_helper(var0) {
  self endon("death");
  waitframe();
  movestartbattlechatter(var0);
}

function terminateexitstartanim(var0, var1, var2) {
  self.asm.customdata.ignoreexitwarp = undefined;
  terminatestartanim(var0, var1, var2);
}

function terminatestartanim(var0, var1, var2) {
  self.isexiting = 0;
  self motionwarpcancel();
}

function playstartanim(var0, var1, var2, var3) {
  self endon(var1 + "_finished");
  var4 = self getposonpath(128);
  var5 = vectortoangles(var4 - self.origin);
  var6 = angleclamp180(var5[1] - self.angles[1]);
  var7 = scripts\asm\asm::asm_getxanim(var1, var2);
  var8 = getnotetracktimes(var7, "code_move");
  var9 = getnotetracktimes(var7, "corner");
  var10 = getnotetracktimes(var7, "warp_exit_start");
  var11 = getnotetracktimes(var7, "warp_exit_end");
  var12 = 1;

  if(var8.size > 0) {
    thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
    thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
    var12 = var8[0];
  }

  var13 = getangledelta3d(var7, 0, var12);
  self animmode("zonly_physics", 0);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
  var14 = self.moveplaybackrate;

  if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentasoldier()) {
    var14 = 1;
  }

  var15 = getmovedelta(var7, 0, var12);
  var16 = length(var15);
  var17 = self getposonpath(var16);

  if(var16 > 1) {
    var18 = var17 - self getnavposition();
  } else {
    var18 = self getposonpath(12) - self getnavposition();
  }

  var19 = vectortoyaw(var18);
  scripts\asm\asm::asm_playfacialanim(var1, var2, var8);
  self aisetanim(var2, var3, var15);
  var20 = 1;
  var21 = spawnStruct();
  var21.xanim = var8;

  if(isDefined(self.asm.customdata.ignoreexitwarp)) {} else if(var10.size > 0) {
    var22 = getmovedelta(var8, 0, var10[0]);
    var23 = length(var22);
    var24 = self getposonpath(var23);
    var25 = var18;

    if(var17 - var23 < 2) {
      var25 = self getposonpath(var17 + 6);
    }

    var26 = var25 - var24;
    var27 = vectortoyaw(var26);

    if(var11.size > 0 && var11[0] > 0 && var11[0] < var10[0]) {
      var21.posalongpath = var24;
      var21.anglealongpath = var27;
      var21.endnote = "corner";

      if(var12.size > 0 && var12[0] < var10[0]) {
        var21.duration = int((var12[0] - var11[0]) * getanimlength(var8) * 1000 / var15);
      }
    } else {
      scripts\engine\utility::motionwarpwithnotetracks(var8, var24, (0, var27, 0), undefined, "corner", undefined, 0);
    }
  } else if(var11.size == 0 || var11[0] == 0) {
    var28 = undefined;

    if(var11.size > 0 && var12.size > 0 && var12[0] < var9[0]) {
      var28 = int((var12[0] - var11[0]) * getanimlength(var8) * 1000);
    }

    scripts\engine\utility::motionwarpwithnotetracks(var8, var18, (0, var19, 0), undefined, "code_move", var28, 0);
  }

  if(!isDefined(var21.posalongpath)) {
    var21.posalongpath = var18;
    var21.anglealongpath = var19;
    var21.endnote = "code_move";

    if(var11.size > 0 && var12.size > 0) {
      var21.duration = int((var12[0] - var11[0]) * getanimlength(var8) * 1000 / var15);
    }
  }

  self.isexiting = 1;
  var29 = self getgroundentity();

  if(isDefined(var29)) {
    var21 = motionwarp_localizedata(var21, var29);
  }

  scripts\asm\asm::asm_donotetracks(var1, var2, &handlewarpexitstart, var21, undefined, !var4);
  self motionwarpcancel();

  if(var4) {
    self animmode("normal", 0);
    self orientmode("face motion");
    scripts\asm\asm::asm_donotetracks(var1, var2);
    return;
  }
}

function motionwarp_localizedata(var0, var1) {
  var2 = invertangles(var1.angles);
  var3 = var0.posalongpath - var1.origin;
  var4 = rotatevector(var3, var2);
  var0.posalongpath = var4;
  var0.anglealongpath = combineangles((0, var0.anglealongpath, 0), var2);
  var0.groundent = var1;
  return var0;
}

function motionwarp_getworldifydata(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = var0.groundent;

  if(isDefined(var3)) {
    var4 = var0.posalongpath;
    var5 = rotatevector(var4, var3.angles);
    var1 = var5 + var3.origin;
    var6 = combineangles(var0.anglealongpath, var3.angles);
    var2 = var6[1];
    return [var1, var2];
  }

  return [var3.posalongpath, var3.anglealongpath];
}

function handlewarpexitstart(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  if(var0 == "warp_exit_start" && !isDefined(self.asm.customdata.ignoreexitwarp)) {
    var4 = var1.endnote;

    if(!isDefined(var4)) {
      var4 = "warp_exit_end";
    }

    var5 = undefined;

    if(isDefined(var1.duration)) {
      var5 = var1.duration - var1.duration % 50;
    }

    var6 = motionwarp_getworldifydata(var1);
    var2 = var6[0];
    var3 = var6[1];
    var6 = undefined;
    scripts\engine\utility::motionwarpwithnotetracks(var1.xanim, var2, (0, var3, 0), "warp_exit_start", var4, var5, 0);
  }

  if(var0 == "code_move" || var0 == "corner") {
    self.isexiting = 0;
    return;
  }
}

function checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(!self.facemotion) {
    return false;
  }

  if(isDefined(self.disableexits) && self.disableexits) {
    return false;
  }

  if(self.stairsstate != "none") {
    return false;
  }

  var0 = 100;
  var1 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_getdemeanor() == "casual" || scripts\asm\asm::asm_getdemeanor() == "casual_gun" || self aigetdesiredspeed() <= 60) {
    var0 = 50;

    if(istrue(self.disablearrivals)) {
      var0 = 25;
    }
  } else if(istrue(self.disablearrivals)) {
    var0 = 50;
  }

  if(self pathdisttogoal() < var0) {
    return false;
  }

  return true;
}

function casualshoulddosharpturn(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var3[2]) || var3[2] != var4) {
    return false;
  }

  if(!shoulddosharpturn(var0, var1, var2, var3)) {
    return false;
  }

  var5 = self.a.sharpturnnumberindex;
  return var5 < 2 || var5 > 6;
}

function shoulddosharpturn(var0, var1, var2, var3) {
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
      var16 = self aigetdesiredspeed();
      var17 = length(self.velocity);
      var18 = (var17 + var16) * 0.5;
      var19 = scripts\asm\shared\utility::getbasearchetype();
      var15 = getnextlowestspeedthresholdstring(var19, var18);

      if(var15 == "sprint") {
        var15 = "run";
      }

      var19 = scripts\asm\shared\utility::getbasearchetype();
      self.turnspeedtarget = getnearestspeedthresholdname(var19, var15);
    } else {
      self.turnspeedtarget = undefined;
    }

    var20 = calculatesharpturnanim(var1, var14, var11, var9, var10, var13, var14, var15);

    if(!isDefined(var20)) {
      return false;
    }

    if(self.a.sharpturnnumberindex > 2 && self.a.sharpturnnumberindex < 6) {
      return false;
    }

    self.a.sharpturnindex = var20;
    self.a.sharpturncorner = var11;
    self.a.sharpturnnextpathpoint = var9;
    return true;
  }

  return false;
}

function calculatesharpturnanim(var0, var1, var2, var3, var4, var5, var6, var7) {
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

function choosesharpturnanim(var0, var1, var2) {
  return self.a.sharpturnindex;
}

function handlecornernotetrack(var0, var1) {
  if(var0 == "corner") {
    self motionwarpcancel();

    if(!isDefined(self.pathgoalpos)) {
      return;
    }

    if(self.lookaheaddist > 4) {
      var2 = vectortoyaw(self.lookaheaddir);
    } else {
      return;
    }

    var3 = var1;
    var4 = getnotetracktimes(var3, "corner");
    var5 = getnotetracktimes(var3, "code_move");
    var6 = 1;

    if(var5.size > 0) {
      var6 = var5[0];
    }

    var7 = (var6 - var4[0]) * getanimlength(var3) * 1000;

    if(var7 < level.frameduration) {
      return;
    }

    var8 = getmovedelta(var3, var4[0], var6);
    var9 = getangledelta(var3, var4[0], var6);
    var10 = angleclamp180(var2 - self.angles[1] - var9);

    if(abs(var10) > 60) {
      return;
    }

    var11 = (0, var2 - var9, 0);
    var12 = self.origin + rotatevector(var8, self.angles);
    var12 = getclosestpointonnavmesh(var12, self, 0, 1);
    var13 = var12 - rotatevector(var8, var11);
    self motionwarpwithanim(var13, var11, var12, (0, var2, 0), int(var7));
    return;
  }
}

function playsharpturnanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self.a.sharpturnindex = undefined;
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  var5 = self.moveplaybackrate;

  if(isDefined(self.turnspeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var6 = self aigetdesiredspeed();
    var7 = length(self.velocity);
    var8 = (var7 + var6) * 0.5;
    var5 = var8 / self.turnspeedtarget;
  }

  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self aisetanim(var1, var3, var5);
  GscBinSkip4(0x35, var4, var5);
}

function sharpturn_setupmotionwarp(var0, var1) {
  waitframe();

  if(isDefined(self.a.sharpturncorner) && isDefined(self.a.sharpturnnextpathpoint)) {
    var2 = getnotetracktimes(var0, "corner");

    if(var2.size > 0) {
      var3 = var2[0];
      var4 = getanimlength(var0);
      var5 = level.frameduration / 1000 / var4;
      var6 = getmovedelta(var0, var5, var3);
      var7 = (0, getangledelta(var0, var5, var3), 0);
      var8 = var4 * var3 / var1;

      if(var8 > 0.05) {
        self.useanimgoalweight = 1;
        self setupmotionwarpforturn(self.a.sharpturncorner, self.a.sharpturnnextpathpoint, var6, var7, var8);
      }
    }

    self.a.sharpturncorner = undefined;
    self.a.sharpturnnextpathpoint = undefined;
    return;
  }
}

function sharpturn_terminate(var0, var1, var2) {
  self motionwarpcancel();
  self.useanimgoalweight = 0;
}

function stoprunngun(var0, var1, var2) {
  self.runngun = 0;
  self.runngundisableaim = undefined;
  self.runnguntime = gettime() + randomintrange(1000, 1500);
  self setdefaultaimlimits();
  self.aimyawspeed = 0;
  self.baimedataimtarget = 0;
}

function runngun_watchapproach(var0) {
  self endon(var0 + "_finished");
  self endon("death");

  for(;;) {
    var1 = self aigettargetspeed();

    if(self pathdisttogoal() < var1 * 1.3 || gettime() > self.runnguntime - 500) {
      var2 = self getaimangle();

      if(abs(var2[1]) > 90) {
        self.runngundisableaim = 1;
        return;
      }
    }

    waitframe();
  }
}

function playrunngun(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.runngun = 1;
  self.rightaimlimit = -180;
  self.leftaimlimit = 180;
  self.aimyawspeed = 360;
  self.runnguntime = gettime() + randomintrange(2500, 3500);
  thread runngun_watchapproach(var1);
  playmoveloop_codeblend(var0, var1, var2);
}

function updatestumble() {
  if(!isDefined(self.stumbletimer) || self.stumbletimer < gettime()) {
    if(randomfloatrange(0, 1) < 0.3) {
      self.shouldstumble = 1;
      self.stumbletimer = gettime() + 20000;
      self.stumbledelay = gettime() + randomfloatrange(0, 3000);
      return;
    }

    return;
  }
}

function playmoveloop_codeblend(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
  self aisetanim(var1, var3);
  thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
  thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 0);
  self aisetspeedscalemode("speed");
  updatestumble();

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1, &handlestrafenotetracks);
  }
}

function playmovestrafeloop_codeblend(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
  self aisetanim(var1, var3);
  self aisetspeedscalemode("strafe");
  childthread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  GscBinSkip4(0x35);
}

function playmovestrafeloop_forwardbackwardmonitor() {
  for(;;) {
    if(length2dsquared(self.velocity) > 1) {
      var0 = self.angles[1];
      var1 = vectortoyaw(self.velocity);
      var2 = angleclamp180(var1 - var0);

      if(self._blackboard.busebackwardstrafespace) {
        if(-85 < var2 && var2 < 35) {
          self._blackboard.busebackwardstrafespace = 0;
        }
      } else if(var2 < -90 || var2 > 130) {
        self._blackboard.busebackwardstrafespace = 1;
      }
    }

    waitframe();
  }
}

function strafeloop_codeblend_cleanup(var0, var1, var2) {
  self aisetspeedscalemode("none");
}

function yawdiffto2468(var0) {
  if(var0 < -135) {
    return "2";
  }

  if(var0 < -45) {
    return "6";
  }

  if(var0 > 135) {
    return "2";
  }

  if(var0 > 45) {
    return "4";
  }

  return "8";
}

function shouldstrafeaimchange(var0, var1, var2, var3) {
  if(!isDefined(self.asm.strafe_foot)) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(self getreacquirestate() == "enabled") {
    return false;
  }

  if(isonanystairs()) {
    return false;
  }

  var4 = getstairsenterdist();
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

  var17 = yawdiffto2468(var13);
  var18 = yawdiffto2468(var13);

  if(var17 == var18) {
    return false;
  }

  var19 = "fast";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var20 = scripts\asm\shared\utility::getbasearchetype();
    var19 = getnextlowestspeedthresholdstring(var20, var11);

    if(var19 == "shuffle" || var19 == "walk") {
      var19 = "walk";
    } else if(var19 != "fast") {
      var19 = "fast";
    }

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

function shouldrestartaimchange(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfired(var0, "code_move") && shouldstrafeaimchange(var0, var1, var2, var3)) {
    return true;
  }

  return false;
}

function aimchangeorientation(var0, var1, var2, var3, var4) {
  self endon("end_aim_change_orient");
  self.aimchange_oldturnrate = self.turnrate;
  var5 = getangledelta(var0, 0, var2);
  var6 = var3 - self.angles[1];
  var6 = angleclamp180(var6);
  var7 = angleclamp180(var6 - var5);

  while(isDefined(self) && isalive(self)) {
    var8 = self aigetanimtime(var0);
    var9 = min(var8 + level.frameduration / 1000 / var4 * var1, 1);
    var10 = getangledelta(var0, var8, var9);
    var11 = var10 / var5;
    var12 = var7 * var11;
    var13 = var10 + var12;
    var14 = angleclamp(self.angles[1] + var13);
    var15 = angleclamp(self.angles[1] + var13 * 3);
    self orientmode("face angle", var15);

    if(var13 != 0) {
      var16 = abs(angleclamp180(self.angles[1] - var14)) / level.frameduration;

      if(var16 > 0) {
        self.turnrate = var16;
      }
    }

    waitframe();
  }
}

function playanim_strafeaimchange(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self.asm.strafeaimchangealias = undefined;
  self.sharpturnforceusevelocity = 1;
  var5 = 1;
  var6 = undefined;

  if(isDefined(self.strafepoispeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var7 = self aigettargetspeed();
    var5 = var7 / self.strafepoispeedtarget;
    var6 = var7;
    var5 = clamp(var5, 0.6, 1.4);
  }

  self aisetanim(var1, var3, var5);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  var8 = getnotetracktimes(var4, "code_move");
  var9 = getnotetracktimes(var4, "finish");
  var10 = 1;

  if(var8.size > 0) {
    var10 = var8[0];
  } else if(var9.size > 0) {
    var10 = var9[0];
  }

  var11 = getanimlength(var4);
  var12 = var11 * var10;
  var13 = vectortoyaw(self.lookaheaddir);
  var14 = undefined;

  if(!istrue(self.facemotion) && !istrue(self.predictedfacemotion) && !self shouldcautiousstrafe()) {
    var15 = getmovedelta(var4, 0, var10);
    var16 = self getposonpath(length(var15));
    var17 = scripts\asm\shared\utility::getshootfrompos();
    var18 = scripts\asm\track::getshootpos(var17);
    var19 = undefined;

    if(isDefined(var18)) {
      var19 = var18.shootpos;
    } else if(isDefined(self.enemy)) {
      var19 = self lastknownpos(self.enemy);
    }

    if(isDefined(var19)) {
      var20 = vectorNormalize(var19 - var16);
      var13 = vectortoyaw(var20);
      var14 = var19;
    }
  }

  thread aimchangeorientation(var4, var5, var10, var13, var11);
  var21 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    if(self.aimchange_oldturnrate > 0) {
      self.turnrate = self.aimchange_oldturnrate;
    }

    self.aimchange_oldturnrate = undefined;
  }

  if(var21 == "code_move") {
    if(isDefined(var14)) {
      self orientmode("face point", var14);
    } else {
      self orientmode("face angle", var13);
    }

    self animmode("normal");
    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  }

  if(isDefined(var6)) {
    self aisettargetspeed(var6);
    return;
  }
}

function chooseanim_strafeaimchange(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.asm.strafeaimchangealias);
}

function strafeaimchange_cleanup(var0, var1, var2) {
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    self.turnrate = self.aimchange_oldturnrate;
    self.aimchange_oldturnrate = undefined;
  }

  self.sharpturnforceusevelocity = 0;
}

function handlestrafenotetracks(var0) {
  switch (var0) {
    case "anim_pose = feet_together":
      self.asm.strafe_foot = "feet_together";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = feet_apart":
      self.asm.strafe_foot = "feet_apart";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = foot_l_forward":
      self.asm.strafe_foot = "foot_l_forward";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = foot_r_forward":
      self.asm.strafe_foot = "foot_r_forward";
      self.asm.strafe_foot_time = gettime();
      break;
  }
}

function playanim_strafearrival(var0, var1, var2) {
  self startcoverarrival(self.origin, self.angles[1]);
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function chooseanim_strafearrival(var0, var1, var2) {
  if(!isDefined(self.asm.strafe_foot)) {
    return scripts\asm\asm::asm_getrandomanim(var0, var1);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.asm.strafe_foot);
}

function playanim_strafestart(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  self aisetspeedscalemode("strafe");
  self aisettargetspeed(self aigetdesiredspeed());
  GscBinSkip4(0x35);
}

function playanim_strafereverse(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 0.4;
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var4);
  self orientmode("face enemy or motion");
  self getpartyid(1);
  var5 = scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, undefined, 0);

  if(var5 == "code_move") {
    self animmode("normal");
    var5 = scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(var0, "end");
}

function strafereverse_cleanup(var0, var1, var2) {
  self getpartyid(0);
}

function playanim_strafereverse_donotetracks(var0, var1) {
  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, undefined, 0);
  }
}

function shouldstrafearrive(var0, var1, var2, var3) {
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
  var13 = "fast";
  var14 = getanimspeedthreshold(var11, "shuffle");
  var15 = getanimspeedthreshold(var11, "fast");

  if(!var14 && !var15) {
    var13 = "walk";
  } else if(var14 && var12 < getcoveranglelimits(var11, "shuffle", "walk", 0.2)) {
    var13 = "shuffle";
  } else if(var15) {
    if(var12 < getcoveranglelimits(var11, "walk", "fast", 0.2)) {
      var13 = "walk";
    } else {
      var13 = "fast";
    }
  } else {
    var13 = "walk";
  }

  var16 = "l";

  if(self.asm.footsteps.foot == "right") {
    var16 = "r";
  }

  var17 = var13 + var10[var9] + var16;
  var18 = scripts\asm\asm::asm_lookupanimfromalias(var2, var17);
  var19 = scripts\asm\asm::asm_getxanim(var2, var18);
  var20 = getmovedelta(var19);
  var21 = length(var20);

  if(var21 < 0.75 * var6 || var21 > 1.5 * var6) {
    return false;
  }

  var22 = length2d(self.velocity) * level.framedurationseconds;
  var23 = self getposonpath(var22);

  if(var21 < length(self.requestedgoalpos - var23)) {
    return false;
  }

  var24 = 0.7;
  var25 = 1.3;

  if(var13 == "shuffle") {
    var24 = 0.9;
  } else if(var13 == "fast") {
    var25 = 1.2;
  }

  self.asm.strafearrival_animindex = var18;
  self.asm.strafearrival_idealstartpos = self.requestedgoalpos - rotatevector(var20, self.angles);
  self.asm.strafearrival_rate = clamp(var12 / getnearestspeedthresholdname(var11, var13), var24, var25);
  self.asm.strafearrival_duration = int(getanimlength(var19) * self.asm.strafearrival_rate * 750);
  return true;
}

function chooseanim_strafearrive(var0, var1, var2) {
  return self.asm.strafearrival_animindex;
}

function playanim_strafearrive(var0, var1, var2) {
  self endon(var1 + "_finished");
  self motionwarpwithanim(self.asm.strafearrival_idealstartpos, self.angles, self.requestedgoalpos, self.angles, self.asm.strafearrival_duration);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3, self.asm.strafearrival_rate);
  self startcoverarrival();
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function playanim_strafearrive_cleanup(var0, var1, var2) {
  self motionwarpcancel();
  self finishcoverarrival();
  self.asm.strafearrival_idealstartpos = undefined;
  self.asm.strafearrival_duration = undefined;
  self.asm.strafearrival_animindex = undefined;
  self.asm.strafearrival_rate = undefined;
}

function choosewalkandtalkanims(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = [];
  GscBinSkip0(0x2e, 0, scripts\asm\asm::asm_lookupanimfromalias(var1, "0"));
}

function shouldwalkandtalk() {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.walk_and_talk_requested) && self._blackboard.walk_and_talk_requested;
}

function walkandtalkdonotetracks(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1);
  }
}

function movewalkandtalk(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
  thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
  var3 = scripts\asm\asm::asm_getmoveplaybackrate();
  scripts\asm\asm::asm_updatefrantic();
  self codemoveanimrate(var3);
  scripts\asm\asm::asm_updatefrantic();
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  var5 = var4.anims;
  var6 = var4.forwardanim;
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanim(var1, var6, 1, 0.2, 1);
  thread walkandtalkdonotetracks(var0, var1);
  var7 = 0;
  var8 = 20;

  for(;;) {
    var9 = scripts\asm\asm::asm_eventfired(var0, "cover_approach");
    var10 = self pathdisttogoal();

    if(var9 && var10 < 150) {
      var11 = anglediffwalkandtalk();
      var12 = 1;

      while(var12 <= var8) {
        var13 = var12 / var8;
        var14 = var13 * var13 * (3 - 2 * var13);
        var15 = var11;
        var16 = var15 * var14;
        var17 = var15 - var16;
        var18 = getwalkandtalkanimweights(var17);

        for(var19 = 0; var19 < var18.size; var19++) {
          self setanim(var5[var19], var18[var19], 0.2, 1, 1);
        }

        var12++;
        wait 0.05;
        waittillframeend();
      }

      while(var9) {
        var18 = getwalkandtalkanimweights(0);

        for(var12 = 0; var12 < var18.size; var12++) {
          if(isDefined(var5[var12])) {
            self setanim(var5[var12], var18[var12], 0.2, 1, 1);
          }
        }

        wait 0.05;
        waittillframeend();
      }

      continue;
    }

    var11 = anglediffwalkandtalk();
    var20 = var7 - var11;

    if(var20 < 0) {
      var20 *= -1;
    }

    if(var20 >= 60) {
      var21 = var7;
      var22 = var7;
      var12 = 1;

      while(var12 <= var8) {
        var11 = anglediffwalkandtalk();
        var23 = var21 - var11;

        if(var23 < 0) {
          var23 *= -1;
        }

        if(var23 >= 60) {
          if(var12 == 1) {
            var12 = 1;
          } else {
            var12 -= 1;
          }

          var24 = var21 - var7;
          var13 = var12 / var8;
          var14 = var13 * var13 * (3 - 2 * var13);
          var25 = var24 * var14;
          var22 = var25 + var7;
          var12 = 1;
          var7 = var22;
        }

        var13 = var12 / var8;
        var14 = var13 * var13 * (3 - 2 * var13);
        var15 = var11 - var22;
        var16 = var15 * var14;
        var17 = var16 + var7;
        var18 = getwalkandtalkanimweights(var17);

        for(var19 = 0; var19 < var18.size; var19++) {
          self setanim(var5[var19], var18[var19], 0.2, 1, 1);
        }

        var12++;
        var21 = var11;
        wait 0.05;
        waittillframeend();
      }
    } else {
      var18 = getwalkandtalkanimweights(var11);

      for(var12 = 0; var12 < var18.size; var12++) {
        if(isDefined(var5[var12])) {
          self setanim(var5[var12], var18[var12], 0.2, 1, 1);
        }
      }

      wait 0.05;
      waittillframeend();
    }

    var7 = var11;
  }
}

function anglediffwalkandtalk() {
  var0 = self.walk_and_talk_target.origin;
  var1 = self.origin;
  var2 = var0 - var1;
  var3 = anglesToForward(self.angles);
  var4 = vectorcross(var3, var2);
  var5 = vectorNormalize(var4);
  var6 = vectorNormalize(var2);
  var7 = vectorNormalize(var3);
  var8 = vectordot(var6, var7);

  if(isDefined(self.walk_and_talk_hemisphere)) {
    var9 = scripts\engine\math::anglebetweenvectors(var2, var3);

    if(self.walk_and_talk_hemisphere == "right") {
      if(var8 <= -1) {
        return -180;
      }

      return (var9 * -1);
    }

    if(var8 >= 1) {
      return 180;
    }

    return var9;
  }

  if(var8 >= 1) {
    return 180;
  }

  if(var8 <= -1) {
    return -180;
  }

  var9 = scripts\engine\math::anglebetweenvectors(var2, var3);

  if(var5[2] == -1) {
    var9 *= -1;
  }

  return var9;
}

function getwalkandtalkanimweights(var0) {
  var1 = [];

  for(var2 = 0; var2 < 3; var2++) {
    var1 = 0;
  }

  var3 = [-180, 0, 180];

  for(var2 = 0; var0 >= var3[var2]; var2++) {}

  var4 = var2 - 1;
  var5 = var2;
  var6 = (var0 - var3[var4]) / (var3[var5] - var3[var4]);
  var7 = 1 - var6;
  var1 = var7;
  var1 = var6;
  var1 = max(0.01, var1[1]);
  return var1;
}

function movestartbattlechatter(var0) {
  var1 = scripts\asm\asm::asm_getdemeanor();

  if(var1 == "frantic" || var1 == "combat" || var1 == "sprint") {
    scripts\anim\battlechatter_wrapper::evaluatemoveevent(var0);
    return;
  }
}

function shouldreloadwhilemoving(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_reloadrequested()) {
    return false;
  }

  var4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var4, self aigetdesiredspeed())) {
    var5 = 500;
  } else {
    var5 = 600;
  }

  var6 = self pathdisttogoal();
  return var5 < var6;
}

function choosereloadwhilemoving(var0, var1, var2) {
  var3 = "reload";
  var4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var4, self aigetdesiredspeed())) {
    var3 = "cqbreload";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function playreloadwhilemoving(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
  thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, scripts\asm\asm::asm_getxanim(var1, var3));
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function terminatereloadwhilemoving(var0, var1, var2) {
  if(!scripts\asm\asm::asm_eventfired(var0, "reload done")) {
    scripts\anim\weaponlist::refillclip();
  }

  scripts\asm\soldier\script_funcs::reload_cleanup(var0, var1, var2);
}

function isonanystairs() {
  return isDefined(self.pathgoalpos) && self.stairsstate != "none";
}

function getstairsenterdist() {
  var0 = scripts\asm\asm::asm_getdemeanor();

  switch (var0) {
    case "casual":
      return 23;
    case "casual_gun":
      return 17;
    default:
      var1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var1, self aigetdesiredspeed())) {
        return 20;
      }

      return 36;
  }
}

function shouldenterstairsstatepassthrough(var0, var1, var2, var3) {
  var4 = undefined;

  if(isarray(var3)) {
    var4 = var3[0];
  } else {
    var4 = var3;
  }

  if(self.stairsstate == var4) {
    return true;
  }

  var5 = getstairsenterdist();
  var6 = self getstairsstateatdist(var5);

  if(var6 == var4) {
    return true;
  }

  return false;
}

function determinecurrentstairsstate(var0, var1, var2, var3) {
  var4 = undefined;

  if(isarray(var3)) {
    var4 = var3[0];
  } else {
    var4 = var3;
  }

  if(self.stairsstate == var4) {
    return true;
  }

  return var4 == self getstairsstateatdist(0);
}

function getstairsexitdist() {
  var0 = scripts\asm\asm::asm_getdemeanor();

  switch (var0) {
    case "casual":
      return 13;
    case "casual_gun":
      return 10;
    case "frantic":
    case "combat":
      var1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var1, self aigetdesiredspeed())) {
        return 13;
      }

      return 10;
    default:
      return 28;
  }
}

function getstairsexitdistup() {
  var0 = scripts\asm\asm::asm_getdemeanor();

  switch (var0) {
    case "casual":
      return 24;
    case "casual_gun":
      return 24;
    default:
      var1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var1, self aigetdesiredspeed())) {
        return 15;
      }

      return 28;
  }
}

function getgroundangle() {
  var0 = self actorgetgroundslope();

  if(abs(var0) > 0.99) {
    return 0;
  }

  var1 = acos(var0);
  return var1;
}

function shouldinterruptstairsarrival(var0, var1, var2, var3) {
  return self.stairsstate != "none" && shouldexitstairsstate(var0, var1, var2, var3);
}

function shouldexitstairsstate(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.disablestairsexits) && self._blackboard.disablestairsexits) {
    return false;
  }

  if(self.stairsstate == "none") {
    return true;
  }

  var4 = var3;

  if(!self codemoverequested()) {
    return true;
  }

  var5 = getstairsexitdist();

  if(isDefined(var3) && var3 == "up") {
    var5 = getstairsexitdistup();
  }

  if(self.stairsstate != var4) {
    return true;
  }

  var6 = self getstairsstateatdist(var5);
  return var6 != self.stairsstate;
}

function chooseanim_stairs(var0, var1, var2) {
  if(self.asm.footsteps.foot == "left") {
    var3 = "right";
  } else {
    var3 = "left";
  }

  var4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var4, self aigetdesiredspeed())) {
    var5 = "cqb" + var3;

    if(scripts\asm\asm::asm_hasalias(var2, var5)) {
      var3 = var5;
    }
  }

  var6 = scripts\asm\asm::asm_lookupanimfromalias(var2, var3);
  return var6;
}

function chooseanim_stairs_rise_run(var0, var1, var2) {
  var3 = "8x10";
  var4 = getgroundangle();

  if(var4 < 27.75) {
    var3 = "8x20";
  }

  if(var4 >= 27.75 && var4 < 36.2) {
    var3 = "8x12";
  }

  if(var4 >= 36.2 && var4 < 41.85) {
    var3 = "8x10";
  }

  if(var4 >= 41.85) {
    var3 = "8x8";
  }

  var5 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var5, self aigetdesiredspeed())) {
    var6 = "cqb" + var3;

    if(scripts\asm\asm::asm_hasalias(var1, var6)) {
      var3 = var6;
    }
  }

  var7 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return var7;
}

function playanim_stairs(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
  playmoveloop_codeblend(var0, var1, var2);
}

function stairs_terminate(var0, var1, var2) {
  self setdefaultaimlimits();
}

function slopeupdate(var0, var1, var2) {
  if(isagent(self)) {
    return;
  }

  if(isDefined(self.useslopes) && self.useslopes == 1) {
    var3 = 0;
    var4 = 0;
    var5 = (0, 0, 1);
    self endon(var1 + "_finished");
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var1 + "_knob");
    var7 = scripts\asm\asm::asm_getxanim(var1, var6);
    var8 = scripts\asm\asm::asm_lookupanimfromalias(var1, var1 + "_scrub_anim");
    var9 = scripts\asm\asm::asm_getxanim(var1, var8);
    self setanim(var7, 1, 0.1, 0);
    self setanim(var9, 1, 0.1, 0);

    for(;;) {
      var10 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 12), self.origin - (0, 0, 999));
      var11 = var10["normal"];
      var11 = vectorlerp(var5, var11, 0.25);
      var5 = var11;
      var12 = anglestoup(self.angles);
      var13 = scripts\engine\math::vector_project_onto_plane(var11, var12);
      var14 = self.angles;
      var15 = anglesToForward(var14);
      var16 = scripts\engine\math::anglebetweenvectorssigned(var15, var13, var12);
      var3 = var16 + 180;
      var17 = var11[2];
      var4 = scripts\engine\math::normalize_value(1, 0.707, var17);
      var4 = 1 - var4;
      self setanim(var7, var4, 0.2, 0);
      self setcustomnodegameparameter("slopes_scrub_direction", var3);
      waitframe();
    }

    return;
  }
}

function slopecleanup(var0, var1, var2) {
  if(isagent(self)) {
    return;
  }

  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, var1 + "_knob");
  self clearanim(scripts\asm\asm::asm_getxanim(var1, var3), 0.1, "ease_inout_quad");
}

function shouldstumble(var0, var1, var2) {
  var3 = scripts\asm\shared\utility::findoverridearchetype("default");

  if(var3 != "rebel" || !isalive(self.enemy)) {
    return false;
  }

  if(!isDefined(self.shouldstumble) || !self.shouldstumble) {
    return false;
  }

  if(!isDefined(self.stumbledelay) || self.stumbledelay > gettime()) {
    return false;
  }

  var4 = getnearestspeedthresholdname(var3, "jog");
  var5 = length(self.velocity);

  if(var5 < var4) {
    return false;
  }

  var6 = 280;
  var7 = 265;
  var8 = 0.93969;
  var9 = self getposonpath(var6);
  var10 = var9 - self.origin;
  var11 = anglesToForward(self.angles);
  var12 = self stairswithindistance(var6);

  if(vectordot(var11, var10) < var8 || length(var10) < var7 || var12) {
    return false;
  }

  return true;
}

function stumblechooseanim(var0, var1, var2) {
  var3 = scripts\asm\shared\utility::getbasearchetype();
  var4 = getnearestspeedthresholdname(var3, "run");
  var5 = getnearestspeedthresholdname(var3, "sprint");
  var6 = length(self.velocity);
  var7 = "stumble_jog";

  if(var6 > var5) {
    var7 = "stumble_sprint";
  }

  if(var6 > var4) {
    var7 = "stumble_run";
  }

  return scripts\asm\asm::asm_chooseanim(var0, var1, var7);
}

function stumbleterminate(var0, var1, var2) {
  self.shouldstumble = undefined;
}

function playanim_stumble(var0, var1, var2) {
  thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
  thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 0);
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}