/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\move.gsc
***********************************************/

playanim_exit(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self.asm.customdata.exitstate = undefined;

  if(isDefined(self.battlechatterallowed) && self.battlechatterallowed) {
    var_4 = issubstr(var_1, "cover");
    thread movebattlechatter_helper(var_4);
  }

  if(!isDefined(var_3)) {
    var_5 = self aigetdesiredspeed();
    var_6 = 50.0;

    if(var_6 > var_5)
      var_6 = 0.5 * var_5;

    self aisettargetspeed(var_6);
    scripts\asm\asm::asm_fireevent(var_0, "abort");
    scripts\asm\asm::asm_fireevent(var_0, "code_move");
    scripts\asm\asm::asm_fireevent(var_0, "end");
    scripts\asm\asm::asm_fireevent(var_0, "finish");
    return;
  }

  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  var_7 = 0;

  if(isDefined(var_2))
    var_7 = var_2;

  playstartanim(var_0, var_1, var_3, var_7);

  if(isDefined(self.exitspeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace())
    self aisettargetspeed(float(self.exitspeedtarget));
}

chooseanim_exit(var_0, var_1, var_2) {
  if(!checktransitionpreconditions())
    return undefined;

  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_2))
    var_4 = var_2;

  var_3 = determinestartanim(var_1, var_4);
  return var_3;
}

determinedesiredexitspeed() {
  var_0 = 70.0;
  var_1 = self getdesiredscaledspeedforposalongpath(var_0);

  if(self.cautiousnavigation)
    var_1 = 90;

  return var_1;
}

chooseanim_exitsoldier(var_0, var_1, var_2) {
  var_3 = "";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_4 = determinedesiredexitspeed();
    var_5 = scripts\asm\shared\utility::getbasearchetype();
    var_3 = getanimspeedbetweenthresholds(var_5, var_4);
    self.exitspeedtarget = getnearestspeedthresholdname(var_5, var_3);
  } else
    self.exitspeedtarget = undefined;

  if(!checktransitionpreconditions())
    return undefined;

  var_6 = undefined;
  var_7 = 0;

  if(isDefined(var_2))
    var_7 = var_2;

  var_6 = determinestartanim(var_1, var_7, var_3);
  return var_6;
}

getstartanim(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = "";

  var_4 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  var_5 = var_4[var_2];

  if(var_5 == 8) {
    if(var_3 < 0)
      var_6 = var_5 + "r" + var_1;
    else
      var_6 = var_5 + "l" + var_1;
  } else
    var_6 = var_5 + var_1;

  return scripts\asm\asm::asm_lookupanimfromaliasifexists(var_0, var_6);
}

getstartmindist() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  if(var_0 == "casual" || var_0 == "casual_gun" || self aigetdesiredspeed() <= 60)
    return 75.0;

  return 100.0;
}

determinestartanim(var_0, var_1, var_2) {
  var_3 = self getnegotiationstartnode();

  if(isDefined(var_3))
    var_4 = var_3.origin;
  else
    var_4 = self.pathgoalpos;

  var_5 = scripts\anim\exit_node.gsc::getexitnode();

  if(var_1) {
    var_6 = self.origin + self.lookaheaddir * self.lookaheaddist;
    var_7 = var_6;
  } else {
    var_6 = self getposonpath(128);
    var_7 = self getposonpath(32);
  }

  var_8 = vectortoangles(var_6 - self.origin);
  var_9 = vectortoangles(var_7 - self.origin);

  if(scripts\asm\shared\utility::nodeshouldfaceangles(var_5) && !var_1)
    var_10 = var_5.angles;
  else
    var_10 = self.angles;

  var_11 = angleclamp180(var_8[1] - var_10[1]);
  var_12 = angleclamp180(var_9[1] - var_10[1]);
  var_13 = vectortoangles(self.lookaheaddir);
  var_14 = angleclamp180(var_13[1] - var_10[1]);

  if(abs(var_14) > 135 && abs(var_11) < 90)
    return undefined;

  if(length2dsquared(self.velocity) > 16) {
    var_15 = vectortoangles(self.velocity);

    if(abs(angleclamp180(var_15[1] - var_8[1])) < 45)
      return;
  }

  var_16 = getstartmindist();

  if(self pathdisttogoal(1) < var_16) {
    return;
  }
  var_17 = getangleindices(var_11);
  var_18 = self getnavposition();
  var_19 = var_17[0];
  var_20 = undefined;

  if(isDefined(self.asm.customdata.exitstate))
    var_20 = getstartanim(self.asm.customdata.exitstate, var_2, var_19, var_12);
  else
    var_20 = getstartanim(var_0, var_2, var_19, var_12);

  if(!isDefined(self.asm.customdata.exitstate)) {
    var_21 = issubstr(var_0, "cover");
    var_22 = var_10;

    if(var_21 && isDefined(var_5)) {
      var_23 = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
      var_24 = var_23[var_19];

      if(issubstr(var_0, "left") && var_19 == 4)
        var_24 = var_24 * -1;

      var_22 = (0, angleclamp(var_5.angles[1] + var_24), 0);
    } else {
      var_25 = [180, -135, -90, -45, 0, 45, 90, 135, 180];
      var_24 = var_25[var_19];
      var_22 = (0, angleclamp(self.angles[1] + var_24), 0);
    }

    var_26 = 20.0;
    var_27 = anglesToForward(var_22);
    var_28 = var_27 * self aigettargetspeed();
    var_29 = vectorNormalize(var_27) * 5.0;
    var_30 = self getadjustedexitdirection(var_26, var_28, var_29);

    switch (var_30[0]) {
      case 1:
        var_30[1] = vectorNormalize(var_30[1]);
        var_31 = vectortoangles(var_30[1]);
        var_32 = scripts\engine\math::wrap(-179, 179, angleclamp180(var_31[1] - var_10[1]));
        var_33 = getangleindices(var_32, 45);
        var_34 = angleclamp180(var_22[1] - var_10[1]);
        var_35 = getangleindices(var_34);
        var_36 = var_33[0];

        for(var_37 = var_33.size - 1; var_37 >= 0; var_37--) {
          var_38 = var_33[var_37];

          if(var_38 == var_35[0])
            continue;
          else if((var_19 == 8 || var_19 == 0) && (var_38 == 8 || var_38 == 0))
            continue;
          else if(var_38 == var_19) {
            continue;
          }
          var_36 = var_38;
          break;
        }

        var_19 = var_36;
        self.asm.customdata.ignoreexitwarp = 1;
        var_20 = getstartanim(var_0, var_2, var_19, var_12);
        break;
      case 2:
        var_20 = undefined;
        break;
      default:
        break;
    }
  }

  return var_20;
}

movebattlechatter_helper(var_0) {
  self endon("death");
  waitframe();
  movestartbattlechatter(var_0);
}

terminateexitstartanim(var_0, var_1, var_2) {
  self.asm.customdata.ignoreexitwarp = undefined;
  terminatestartanim(var_0, var_1, var_2);
}

terminatestartanim(var_0, var_1, var_2) {
  self.isexiting = 0;
  self motionwarpcancel();
}

playstartanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self getposonpath(128);
  var_5 = vectortoangles(var_4 - self.origin);
  var_6 = angleclamp180(var_5[1] - self.angles[1]);
  var_7 = scripts\asm\asm::asm_getxanim(var_1, var_2);
  var_8 = getnotetracktimes(var_7, "code_move");
  var_9 = getnotetracktimes(var_7, "corner");
  var_10 = getnotetracktimes(var_7, "warp_exit_start");
  var_11 = getnotetracktimes(var_7, "warp_exit_end");
  var_12 = 1;

  if(var_8.size > 0) {
    thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
    thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
    var_12 = var_8[0];
  }

  var_13 = getangledelta3d(var_7, 0, var_12);
  self animmode("zonly_physics", 0);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
  var_14 = self.moveplaybackrate;

  if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentasoldier())
    var_14 = 1;

  var_15 = getmovedelta(var_7, 0.0, var_12);
  var_16 = length(var_15);
  var_17 = self getposonpath(var_16);

  if(var_16 > 1)
    var_18 = var_17 - self getnavposition();
  else
    var_18 = self getposonpath(12) - self getnavposition();

  var_19 = vectortoyaw(var_18);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_7);
  self aisetanim(var_1, var_2, var_14);
  var_20 = 1;
  var_21 = spawnStruct();
  var_21.xanim = var_7;

  if(isDefined(self.asm.customdata.ignoreexitwarp)) {} else if(var_9.size > 0) {
    var_22 = getmovedelta(var_7, 0, var_9[0]);
    var_23 = length(var_22);
    var_24 = self getposonpath(var_23);
    var_25 = var_17;

    if(var_16 - var_23 < 2)
      var_25 = self getposonpath(var_16 + 6);

    var_26 = var_25 - var_24;
    var_27 = vectortoyaw(var_26);

    if(var_10.size > 0 && var_10[0] > 0 && var_10[0] < var_9[0]) {
      var_21.posalongpath = var_24;
      var_21.anglealongpath = var_27;
      var_21.endnote = "corner";

      if(var_11.size > 0 && var_11[0] < var_9[0])
        var_21.duration = int((var_11[0] - var_10[0]) * getanimlength(var_7) * 1000 / var_14);
    } else
      scripts\engine\utility::motionwarpwithnotetracks(var_7, var_24, (0, var_27, 0), undefined, "corner", undefined, 0);
  } else if(var_10.size == 0 || var_10[0] == 0) {
    var_28 = undefined;

    if(var_10.size > 0 && var_11.size > 0 && var_11[0] < var_8[0])
      var_28 = int((var_11[0] - var_10[0]) * getanimlength(var_7) * 1000);

    scripts\engine\utility::motionwarpwithnotetracks(var_7, var_17, (0, var_19, 0), undefined, "code_move", var_28, 0);
  }

  if(!isDefined(var_21.posalongpath)) {
    var_21.posalongpath = var_17;
    var_21.anglealongpath = var_19;
    var_21.endnote = "code_move";

    if(var_10.size > 0 && var_11.size > 0)
      var_21.duration = int((var_11[0] - var_10[0]) * getanimlength(var_7) * 1000 / var_14);
  }

  self.isexiting = 1;
  var_29 = self getgroundentity();

  if(isDefined(var_29))
    var_21 = motionwarp_localizedata(var_21, var_29);

  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlewarpexitstart, var_21, undefined, !var_3);
  self motionwarpcancel();

  if(var_3) {
    self animmode("normal", 0);
    self orientmode("face motion");
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
  }
}

motionwarp_localizedata(var_0, var_1) {
  var_2 = invertangles(var_1.angles);
  var_3 = var_0.posalongpath - var_1.origin;
  var_4 = rotatevector(var_3, var_2);
  var_0.posalongpath = var_4;
  var_0.anglealongpath = combineangles((0, var_0.anglealongpath, 0), var_2);
  var_0.groundent = var_1;
  return var_0;
}

motionwarp_getworldifydata(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.groundent;

  if(isDefined(var_3)) {
    var_4 = var_0.posalongpath;
    var_5 = rotatevector(var_4, var_3.angles);
    var_1 = var_5 + var_3.origin;
    var_6 = combineangles(var_0.anglealongpath, var_3.angles);
    var_2 = var_6[1];
    return [var_1, var_2];
  } else
    return [var_0.posalongpath, var_0.anglealongpath];
}

handlewarpexitstart(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(var_0 == "warp_exit_start" && !isDefined(self.asm.customdata.ignoreexitwarp)) {
    var_4 = var_1.endnote;

    if(!isDefined(var_4))
      var_4 = "warp_exit_end";

    var_5 = undefined;

    if(isDefined(var_1.duration))
      var_5 = var_1.duration - var_1.duration % 50;

    [var_2, var_3] = motionwarp_getworldifydata(var_1);
    scripts\engine\utility::motionwarpwithnotetracks(var_1.xanim, var_2, (0, var_3, 0), "warp_exit_start", var_4, var_5, 0);
  }

  if(var_0 == "code_move" || var_0 == "corner")
    self.isexiting = 0;
}

checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!self.facemotion)
    return 0;

  if(isDefined(self.disableexits) && self.disableexits)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  var_0 = 100;
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_getdemeanor() == "casual" || scripts\asm\asm::asm_getdemeanor() == "casual_gun" || self aigetdesiredspeed() <= 60) {
    var_0 = 50;

    if(istrue(self.disablearrivals))
      var_0 = 25;
  } else if(istrue(self.disablearrivals))
    var_0 = 50;

  if(self pathdisttogoal() < var_0)
    return 0;

  return 1;
}

casualshoulddosharpturn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var_3[2]) || var_3[2] != var_4)
    return 0;

  if(!shoulddosharpturn(var_0, var_1, var_2, var_3))
    return 0;

  var_5 = self.a.sharpturnnumberindex;
  return var_5 < 2 || var_5 > 6;
}

shoulddosharpturn(var_0, var_1, var_2, var_3) {
  if(istrue(self.noturnanims))
    return 0;

  var_4 = scripts\asm\asm::asm_geteventtime(var_0, "sharp_turn");

  if(!isDefined(var_4))
    return 0;

  var_5 = 50;
  var_6 = gettime();

  if(var_6 - var_4 > var_5)
    return 0;

  var_7 = scripts\asm\asm::asm_geteventdata(var_0, "sharp_turn");
  var_8 = var_7[1];
  var_9 = var_7[2];
  var_10 = var_7[3];
  var_11 = 22500;

  if(var_9 && self pathdisttogoal() > 90 || lengthsquared(self.velocity) > var_11) {
    var_12 = 0;
    var_13 = undefined;

    if(!isarray(var_3))
      var_14 = var_3;
    else {
      var_14 = var_3[0];

      if(var_3.size > 1 && var_3[1] == 1)
        var_12 = 1;

      if(var_3.size > 2)
        var_13 = scripts\asm\asm_bb::bb_getprefixstring(var_3[2]);
    }

    var_15 = "";

    if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentnotabomber()) {
      var_16 = self aigetdesiredspeed();
      var_17 = length(self.velocity);
      var_18 = (var_17 + var_16) * 0.5;
      var_19 = scripts\asm\shared\utility::getbasearchetype();
      var_15 = getnextlowestspeedthresholdstring(var_19, var_18);

      if(var_15 == "sprint")
        var_15 = "run";

      var_19 = scripts\asm\shared\utility::getbasearchetype();
      self.turnspeedtarget = getnearestspeedthresholdname(var_19, var_15);
    } else
      self.turnspeedtarget = undefined;

    var_20 = calculatesharpturnanim(var_0, var_14, var_10, var_8, var_9, var_12, var_13, var_15);

    if(!isDefined(var_20))
      return 0;

    if(self.a.sharpturnnumberindex > 2 && self.a.sharpturnnumberindex < 6)
      return 0;

    self.a.sharpturnindex = var_20;
    self.a.sharpturncorner = var_10;
    self.a.sharpturnnextpathpoint = var_8;
    return 1;
  }

  return 0;
}

calculatesharpturnanim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 22.5;

  if(!isDefined(var_6))
    var_6 = "";

  if(!isDefined(var_7))
    var_7 = "";

  if(var_5) {
    if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left"))
      var_9 = var_6 + "left";
    else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_right"))
      var_9 = var_6 + "right";
    else if(self.asm.footsteps.foot == "right")
      var_9 = var_6 + "right";
    else
      var_9 = var_6 + "left";
  } else
    var_9 = var_6;

  [var_11, var_12] = self actorcalcsharpturnanim(var_1, var_2, var_3, var_8, var_9, var_6, var_7);
  self.a.sharpturnnumberindex = var_12;
  return var_11;
}

choosesharpturnanim(var_0, var_1, var_2) {
  return self.a.sharpturnindex;
}

handlecornernotetrack(var_0, var_1) {
  if(var_0 == "corner") {
    self motionwarpcancel();

    if(!isDefined(self.pathgoalpos)) {
      return;
    }
    if(self.lookaheaddist > 4)
      var_2 = vectortoyaw(self.lookaheaddir);
    else
      return;

    var_3 = var_1;
    var_4 = getnotetracktimes(var_3, "corner");
    var_5 = getnotetracktimes(var_3, "code_move");
    var_6 = 1;

    if(var_5.size > 0)
      var_6 = var_5[0];

    var_7 = (var_6 - var_4[0]) * getanimlength(var_3) * 1000;

    if(var_7 < level.frameduration) {
      return;
    }
    var_8 = getmovedelta(var_3, var_4[0], var_6);
    var_9 = getangledelta(var_3, var_4[0], var_6);
    var_10 = angleclamp180(var_2 - self.angles[1] - var_9);

    if(abs(var_10) > 60) {
      return;
    }
    var_11 = (0, var_2 - var_9, 0);
    var_12 = self.origin + rotatevector(var_8, self.angles);
    var_12 = getclosestpointonnavmesh(var_12, self, 0, 1);
    var_13 = var_12 - rotatevector(var_8, var_11);
    self motionwarpwithanim(var_13, var_11, var_12, (0, var_2, 0), int(var_7));
  }
}

playsharpturnanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self.a.sharpturnindex = undefined;
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  var_5 = self.moveplaybackrate;

  if(isDefined(self.turnspeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_6 = self aigetdesiredspeed();
    var_7 = length(self.velocity);
    var_8 = (var_7 + var_6) * 0.5;
    var_5 = var_8 / self.turnspeedtarget;
  }

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self aisetanim(var_1, var_3, var_5);
  childthread sharpturn_setupmotionwarp(var_4, var_5);
  var_9 = scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlecornernotetrack, var_4, undefined, 0);
  self motionwarpcancel();
  self orientmode("face enemy or motion");
  self animmode("normal", 0);

  if(var_9 == "code_move") {
    thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
    thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
    var_10 = getnotetracktimes(var_4, "finish");

    if(var_10.size > 0)
      scripts\asm\asm::asm_donotetracks(var_0, var_1);
  }
}

sharpturn_setupmotionwarp(var_0, var_1) {
  waitframe();

  if(isDefined(self.a.sharpturncorner) && isDefined(self.a.sharpturnnextpathpoint)) {
    var_2 = getnotetracktimes(var_0, "corner");

    if(var_2.size > 0) {
      var_3 = var_2[0];
      var_4 = getanimlength(var_0);
      var_5 = level.frameduration / 1000 / var_4;
      var_6 = getmovedelta(var_0, var_5, var_3);
      var_7 = (0, getangledelta(var_0, var_5, var_3), 0);
      var_8 = var_4 * var_3 / var_1;

      if(var_8 > 0.05) {
        self.useanimgoalweight = 1;
        self setupmotionwarpforturn(self.a.sharpturncorner, self.a.sharpturnnextpathpoint, var_6, var_7, var_8);
      }
    }

    self.a.sharpturncorner = undefined;
    self.a.sharpturnnextpathpoint = undefined;
  }
}

sharpturn_terminate(var_0, var_1, var_2) {
  self motionwarpcancel();
  self.useanimgoalweight = 0;
}

stoprunngun(var_0, var_1, var_2) {
  self.runngun = 0;
  self.runngundisableaim = undefined;
  self.runnguntime = gettime() + randomintrange(1000, 1500);
  self setdefaultaimlimits();
  self.aimyawspeed = 0;
  self.baimedataimtarget = 0;
}

runngun_watchapproach(var_0) {
  self endon(var_0 + "_finished");
  self endon("death");

  for(;;) {
    var_1 = self aigettargetspeed();

    if(self pathdisttogoal() < var_1 * 1.3 || gettime() > self.runnguntime - 500) {
      var_2 = self getaimangle();

      if(abs(var_2[1]) > 90) {
        self.runngundisableaim = 1;
        return;
      }
    }

    waitframe();
  }
}

playrunngun(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.runngun = 1;
  self.rightaimlimit = -180;
  self.leftaimlimit = 180;
  self.aimyawspeed = 360;
  self.runnguntime = gettime() + randomintrange(2500, 3500);
  thread runngun_watchapproach(var_1);
  playmoveloop_codeblend(var_0, var_1, var_2);
}

updatestumble() {
  if(!isDefined(self.stumbletimer) || self.stumbletimer < gettime()) {
    if(randomfloatrange(0, 1) < 0.3) {
      self.shouldstumble = 1;
      self.stumbletimer = gettime() + 20000.0;
      self.stumbledelay = gettime() + randomfloatrange(0.0, 3000.0);
    }
  }
}

playmoveloop_codeblend(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
  self aisetanim(var_1, var_3);
  thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
  thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 0);
  self aisetspeedscalemode("speed");
  updatestumble();

  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlestrafenotetracks);
}

playmovestrafeloop_codeblend(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
  self aisetanim(var_1, var_3);
  self aisetspeedscalemode("strafe");
  childthread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  childthread playmovestrafeloop_forwardbackwardmonitor();

  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlestrafenotetracks);
}

playmovestrafeloop_forwardbackwardmonitor() {
  for(;;) {
    if(length2dsquared(self.velocity) > 1) {
      var_0 = self.angles[1];
      var_1 = vectortoyaw(self.velocity);
      var_2 = angleclamp180(var_1 - var_0);

      if(self._blackboard.busebackwardstrafespace) {
        if(-85 < var_2 && var_2 < 35)
          self._blackboard.busebackwardstrafespace = 0;
      } else if(var_2 < -90 || var_2 > 130)
        self._blackboard.busebackwardstrafespace = 1;
    }

    waitframe();
  }
}

strafeloop_codeblend_cleanup(var_0, var_1, var_2) {
  self aisetspeedscalemode("none");
}

yawdiffto2468(var_0) {
  if(var_0 < -135)
    return "2";
  else if(var_0 < -45)
    return "6";
  else if(var_0 > 135)
    return "2";
  else if(var_0 > 45)
    return "4";
  else
    return "8";
}

shouldstrafeaimchange(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asm.strafe_foot))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(self getreacquirestate() == "enabled")
    return 0;

  if(isonanystairs())
    return 0;

  var_4 = getstairsenterdist();
  var_5 = self getstairsstateatdist(var_4);

  if(var_5 != "none")
    return 0;

  var_6 = self aigettargetspeed();

  if(self.lookaheaddist < 90)
    return 0;

  var_7 = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9)
    return 0;

  var_8 = self asmeventfiredwithin(var_0, "sharp_turn", 50);

  if(var_8) {
    var_9 = angleclamp180(var_7 - self.angles[1]);
    var_10 = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(var_10 - var_9)) > 45)
      return 0;
  } else
    var_10 = angleclamp180(var_7 - self.angles[1]);

  var_11 = scripts\asm\shared\utility::getshootfrompos();
  var_12 = scripts\asm\track::getshootpos(var_11);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe())
    var_13 = 0;
  else if(isDefined(var_12) || self iscurrentenemyvalid()) {
    if(isDefined(var_12))
      var_14 = var_12.shootpos;
    else {
      if(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000)
        return 0;

      var_14 = self lastknownpos(self.enemy);
    }

    if(distance2dsquared(var_14, self.origin) < 22500)
      return 0;

    var_15 = var_14 - self getposonpath(32);
    var_16 = vectortoyaw(var_15);

    if(abs(angleclamp180(var_16 - self.angles[1])) < 45)
      return 0;

    var_13 = angleclamp180(var_7 - var_16);
  } else if(istrue(self._blackboard.forcestrafe))
    return 0;
  else {
    if(var_8 || self pathdisttogoal() < 64)
      return 0;

    var_13 = angleclamp180(var_7 - self.desiredangle);
  }

  if(abs(angleclamp180(var_10 - var_13)) < 45)
    return 0;

  var_17 = yawdiffto2468(var_10);
  var_18 = yawdiffto2468(var_13);

  if(var_17 == var_18)
    return 0;

  var_19 = "fast";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_20 = scripts\asm\shared\utility::getbasearchetype();
    var_19 = getnextlowestspeedthresholdstring(var_20, var_6);

    if(var_19 == "shuffle" || var_19 == "walk")
      var_19 = "walk";
    else if(var_19 != "fast")
      var_19 = "fast";

    self.strafepoispeedtarget = getnearestspeedthresholdname(var_20, var_19);
  } else
    self.strafepoispeedtarget = undefined;

  var_21 = var_19 + "_" + self.asm.strafe_foot + "_" + var_17 + "_to_" + var_18;

  if(!scripts\asm\asm::asm_hasalias(var_2, var_21)) {
    if(var_17 == "4" || var_17 == "6")
      var_21 = var_19 + "_feet_together_" + var_17 + "_to_" + var_18;
    else
      var_21 = var_19 + "_foot_l_forward_" + var_17 + "_to_" + var_18;

    if(!scripts\asm\asm::asm_hasalias(var_2, var_21))
      return 0;
  }

  self.asm.strafeaimchangealias = var_21;
  return 1;
}

shouldrestartaimchange(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "code_move") && shouldstrafeaimchange(var_0, var_1, var_2, var_3))
    return 1;

  return 0;
}

aimchangeorientation(var_0, var_1, var_2, var_3, var_4) {
  self endon("end_aim_change_orient");
  self.aimchange_oldturnrate = self.turnrate;
  var_5 = getangledelta(var_0, 0.0, var_2);
  var_6 = var_3 - self.angles[1];
  var_6 = angleclamp180(var_6);
  var_7 = angleclamp180(var_6 - var_5);

  while(isDefined(self) && isalive(self)) {
    var_8 = self aigetanimtime(var_0);
    var_9 = min(var_8 + level.frameduration / 1000.0 / var_4 * var_1, 1.0);
    var_10 = getangledelta(var_0, var_8, var_9);
    var_11 = var_10 / var_5;
    var_12 = var_7 * var_11;
    var_13 = var_10 + var_12;
    var_14 = angleclamp(self.angles[1] + var_13);
    var_15 = angleclamp(self.angles[1] + var_13 * 3);
    self orientmode("face angle", var_15);

    if(var_13 != 0.0) {
      var_16 = abs(angleclamp180(self.angles[1] - var_14)) / level.frameduration;

      if(var_16 > 0)
        self.turnrate = var_16;
    }

    waitframe();
  }
}

playanim_strafeaimchange(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self.asm.strafeaimchangealias = undefined;
  self.sharpturnforceusevelocity = 1;
  var_5 = 1;
  var_6 = undefined;

  if(isDefined(self.strafepoispeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_7 = self aigettargetspeed();
    var_5 = var_7 / self.strafepoispeedtarget;
    var_6 = var_7;
    var_5 = clamp(var_5, 0.6, 1.4);
  }

  self aisetanim(var_1, var_3, var_5);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  var_8 = getnotetracktimes(var_4, "code_move");
  var_9 = getnotetracktimes(var_4, "finish");
  var_10 = 1;

  if(var_8.size > 0)
    var_10 = var_8[0];
  else if(var_9.size > 0)
    var_10 = var_9[0];

  var_11 = getanimlength(var_4);
  var_12 = var_11 * var_10;
  var_13 = vectortoyaw(self.lookaheaddir);
  var_14 = undefined;

  if(!istrue(self.facemotion) && !istrue(self.predictedfacemotion) && !self shouldcautiousstrafe()) {
    var_15 = getmovedelta(var_4, 0, var_10);
    var_16 = self getposonpath(length(var_15));
    var_17 = scripts\asm\shared\utility::getshootfrompos();
    var_18 = scripts\asm\track::getshootpos(var_17);
    var_19 = undefined;

    if(isDefined(var_18))
      var_19 = var_18.shootpos;
    else if(isDefined(self.enemy))
      var_19 = self lastknownpos(self.enemy);

    if(isDefined(var_19)) {
      var_20 = vectorNormalize(var_19 - var_16);
      var_13 = vectortoyaw(var_20);
      var_14 = var_19;
    }
  }

  thread aimchangeorientation(var_4, var_5, var_10, var_13, var_11);
  var_21 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    if(self.aimchange_oldturnrate > 0)
      self.turnrate = self.aimchange_oldturnrate;

    self.aimchange_oldturnrate = undefined;
  }

  if(var_21 == "code_move") {
    if(isDefined(var_14))
      self orientmode("face point", var_14);
    else
      self orientmode("face angle", var_13);

    self animmode("normal");
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  }

  if(isDefined(var_6))
    self aisettargetspeed(var_6);
}

chooseanim_strafeaimchange(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.asm.strafeaimchangealias);
}

strafeaimchange_cleanup(var_0, var_1, var_2) {
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    self.turnrate = self.aimchange_oldturnrate;
    self.aimchange_oldturnrate = undefined;
  }

  self.sharpturnforceusevelocity = 0;
}

handlestrafenotetracks(var_0) {
  switch (var_0) {
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

playanim_strafearrival(var_0, var_1, var_2) {
  self startcoverarrival(self.origin, self.angles[1]);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

chooseanim_strafearrival(var_0, var_1, var_2) {
  if(!isDefined(self.asm.strafe_foot))
    return scripts\asm\asm::asm_getrandomanim(var_0, var_1);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.asm.strafe_foot);
}

playanim_strafestart(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  self aisetspeedscalemode("strafe");
  self aisettargetspeed(self aigetdesiredspeed());
  childthread playmovestrafeloop_forwardbackwardmonitor();

  for(;;) {
    var_4 = scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlestrafenotetracks, undefined, undefined, 0);

    if(var_4 == "code_move")
      self animmode("normal", 0);
  }
}

playanim_strafereverse(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0.4;
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_4);
  self orientmode("face enemy or motion");
  self getpartyid(1);
  var_5 = scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, undefined, 0);

  if(var_5 == "code_move") {
    self animmode("normal");
    var_5 = scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(var_0, "end");
}

strafereverse_cleanup(var_0, var_1, var_2) {
  self getpartyid(0);
}

playanim_strafereverse_donotetracks(var_0, var_1) {
  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, undefined, 0);
}

shouldstrafearrive(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\soldier\arrival::shoulddoarrival())
    return 0;

  if(self.facemotion)
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(self.node) && isDefined(self.node.angles))
    return 0;

  var_4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var_4)) {
    if(scripts\engine\utility::absangleclamp180(var_4.angles[1] - self.angles[1]) > 15)
      return 0;
  }

  if(self getreacquirestate() == "enabled" && self._blackboard.reacquiresteptime >= gettime() - 50)
    return 0;

  var_5 = self.requestedgoalpos - self.origin;
  var_6 = length(var_5);

  if(var_6 > 96)
    return 0;

  if(var_6 < self pathdisttogoal() * 0.8)
    return 0;

  var_7 = vectortoyaw(var_5);
  var_8 = angleclamp180(var_7 - self.angles[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var_11 = scripts\asm\shared\utility::getbasearchetype();
  var_12 = length(self.velocity);
  var_13 = "fast";
  var_14 = getanimspeedthreshold(var_11, "shuffle");
  var_15 = getanimspeedthreshold(var_11, "fast");

  if(!var_14 && !var_15)
    var_13 = "walk";
  else if(var_14 && var_12 < getcoveranglelimits(var_11, "shuffle", "walk", 0.2))
    var_13 = "shuffle";
  else if(var_15) {
    if(var_12 < getcoveranglelimits(var_11, "walk", "fast", 0.2))
      var_13 = "walk";
    else
      var_13 = "fast";
  } else
    var_13 = "walk";

  var_16 = "l";

  if(self.asm.footsteps.foot == "right")
    var_16 = "r";

  var_17 = var_13 + var_10[var_9] + var_16;
  var_18 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_17);
  var_19 = scripts\asm\asm::asm_getxanim(var_2, var_18);
  var_20 = getmovedelta(var_19);
  var_21 = length(var_20);

  if(var_21 < 0.75 * var_6 || var_21 > 1.5 * var_6)
    return 0;

  var_22 = length2d(self.velocity) * level.framedurationseconds;
  var_23 = self getposonpath(var_22);

  if(var_21 < length(self.requestedgoalpos - var_23))
    return 0;

  var_24 = 0.7;
  var_25 = 1.3;

  if(var_13 == "shuffle")
    var_24 = 0.9;
  else if(var_13 == "fast")
    var_25 = 1.2;

  self.asm.strafearrival_animindex = var_18;
  self.asm.strafearrival_idealstartpos = self.requestedgoalpos - rotatevector(var_20, self.angles);
  self.asm.strafearrival_rate = clamp(var_12 / getnearestspeedthresholdname(var_11, var_13), var_24, var_25);
  self.asm.strafearrival_duration = int(getanimlength(var_19) * self.asm.strafearrival_rate * 750);
  return 1;
}

chooseanim_strafearrive(var_0, var_1, var_2) {
  return self.asm.strafearrival_animindex;
}

playanim_strafearrive(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self motionwarpwithanim(self.asm.strafearrival_idealstartpos, self.angles, self.requestedgoalpos, self.angles, self.asm.strafearrival_duration);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3, self.asm.strafearrival_rate);
  self startcoverarrival();
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playanim_strafearrive_cleanup(var_0, var_1, var_2) {
  self motionwarpcancel();
  self finishcoverarrival();
  self.asm.strafearrival_idealstartpos = undefined;
  self.asm.strafearrival_duration = undefined;
  self.asm.strafearrival_animindex = undefined;
  self.asm.strafearrival_rate = undefined;
}

choosewalkandtalkanims(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = [];
  var_4[0] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_4[1] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_4[2] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3.anims = var_4;
  var_3.forwardanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  return var_3;
}

shouldwalkandtalk() {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.walk_and_talk_requested) && self._blackboard.walk_and_talk_requested;
}

walkandtalkdonotetracks(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

movewalkandtalk(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
  thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  var_3 = scripts\asm\asm::asm_getmoveplaybackrate();
  scripts\asm\asm::asm_updatefrantic();
  self codemoveanimrate(var_3);
  scripts\asm\asm::asm_updatefrantic();
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = var_4.anims;
  var_6 = var_4.forwardanim;
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanim(var_1, var_6, 1.0, 0.2, 1.0);
  thread walkandtalkdonotetracks(var_0, var_1);
  var_7 = 0;
  var_8 = 20;

  for(;;) {
    var_9 = scripts\asm\asm::asm_eventfired(var_0, "cover_approach");
    var_10 = self pathdisttogoal();

    if(var_9 && var_10 < 150) {
      var_11 = anglediffwalkandtalk();
      var_12 = 1;

      while(var_12 <= var_8) {
        var_13 = var_12 / var_8;
        var_14 = var_13 * var_13 * (3 - 2 * var_13);
        var_15 = var_11;
        var_16 = var_15 * var_14;
        var_17 = var_15 - var_16;
        var_18 = getwalkandtalkanimweights(var_17);

        for(var_19 = 0; var_19 < var_18.size; var_19++)
          self setanim(var_5[var_19], var_18[var_19], 0.2, 1.0, 1);

        var_12++;
        wait 0.05;
        waittillframeend;
      }

      while(var_9) {
        var_18 = getwalkandtalkanimweights(0);

        for(var_12 = 0; var_12 < var_18.size; var_12++) {
          if(isDefined(var_5[var_12]))
            self setanim(var_5[var_12], var_18[var_12], 0.2, 1.0, 1);
        }

        wait 0.05;
        waittillframeend;
      }

      continue;
    }

    var_11 = anglediffwalkandtalk();
    var_20 = var_7 - var_11;

    if(var_20 < 0)
      var_20 = var_20 * -1;

    if(var_20 >= 60) {
      var_21 = var_7;
      var_22 = var_7;
      var_12 = 1;

      while(var_12 <= var_8) {
        var_11 = anglediffwalkandtalk();
        var_23 = var_21 - var_11;

        if(var_23 < 0)
          var_23 = var_23 * -1;

        if(var_23 >= 60) {
          if(var_12 == 1)
            var_12 = 1;
          else
            var_12 = var_12 - 1;

          var_24 = var_21 - var_7;
          var_13 = var_12 / var_8;
          var_14 = var_13 * var_13 * (3 - 2 * var_13);
          var_25 = var_24 * var_14;
          var_22 = var_25 + var_7;
          var_12 = 1;
          var_7 = var_22;
        }

        var_13 = var_12 / var_8;
        var_14 = var_13 * var_13 * (3 - 2 * var_13);
        var_15 = var_11 - var_22;
        var_16 = var_15 * var_14;
        var_17 = var_16 + var_7;
        var_18 = getwalkandtalkanimweights(var_17);

        for(var_19 = 0; var_19 < var_18.size; var_19++)
          self setanim(var_5[var_19], var_18[var_19], 0.2, 1.0, 1);

        var_12++;
        var_21 = var_11;
        wait 0.05;
        waittillframeend;
      }
    } else {
      var_18 = getwalkandtalkanimweights(var_11);

      for(var_12 = 0; var_12 < var_18.size; var_12++) {
        if(isDefined(var_5[var_12]))
          self setanim(var_5[var_12], var_18[var_12], 0.2, 1.0, 1);
      }

      wait 0.05;
      waittillframeend;
    }

    var_7 = var_11;
  }
}

anglediffwalkandtalk() {
  var_0 = self.walk_and_talk_target.origin;
  var_1 = self.origin;
  var_2 = var_0 - var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectorcross(var_3, var_2);
  var_5 = vectorNormalize(var_4);
  var_6 = vectorNormalize(var_2);
  var_7 = vectorNormalize(var_3);
  var_8 = vectordot(var_6, var_7);

  if(isDefined(self.walk_and_talk_hemisphere)) {
    var_9 = scripts\engine\math::anglebetweenvectors(var_2, var_3);

    if(self.walk_and_talk_hemisphere == "right") {
      if(var_8 <= -1)
        return -180;

      return var_9 * -1;
      return;
    }

    if(var_8 >= 1)
      return 180;

    return var_9;
    return;
  } else {
    if(var_8 >= 1)
      return 180;

    if(var_8 <= -1)
      return -180;
    else {
      var_9 = scripts\engine\math::anglebetweenvectors(var_2, var_3);

      if(var_5[2] == -1)
        var_9 = var_9 * -1;

      return var_9;
    }
  }
}

getwalkandtalkanimweights(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 3; var_2++)
    var_1[var_2] = 0;

  var_3 = [-180, 0, 180];

  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = (var_0 - var_3[var_4]) / (var_3[var_5] - var_3[var_4]);
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;
  var_1[1] = max(0.01, var_1[1]);
  return var_1;
}

movestartbattlechatter(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(var_1 == "frantic" || var_1 == "combat" || var_1 == "sprint")
    scripts\anim\battlechatter_wrapper.gsc::evaluatemoveevent(var_0);
}

shouldreloadwhilemoving(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_reloadrequested())
    return 0;

  var_4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var_4, self aigetdesiredspeed()))
    var_5 = 500;
  else
    var_5 = 600;

  var_6 = self pathdisttogoal();
  return var_5 < var_6;
}

choosereloadwhilemoving(var_0, var_1, var_2) {
  var_3 = "reload";
  var_4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var_4, self aigetdesiredspeed()))
    var_3 = "cqbreload";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

playreloadwhilemoving(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
  thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_1, var_3));
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

terminatereloadwhilemoving(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "reload done"))
    scripts\anim\weaponlist.gsc::refillclip();

  scripts\asm\soldier\script_funcs::reload_cleanup(var_0, var_1, var_2);
}

isonanystairs() {
  return isDefined(self.pathgoalpos) && self.stairsstate != "none";
}

getstairsenterdist() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 23;
    case "casual_gun":
      return 17;
    default:
      var_1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var_1, self aigetdesiredspeed()))
        return 20;

      return 36;
  }
}

shouldenterstairsstatepassthrough(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isarray(var_3))
    var_4 = var_3[0];
  else
    var_4 = var_3;

  if(self.stairsstate == var_4)
    return 1;

  var_5 = getstairsenterdist();
  var_6 = self getstairsstateatdist(var_5);

  if(var_6 == var_4)
    return 1;

  return 0;
}

determinecurrentstairsstate(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isarray(var_3))
    var_4 = var_3[0];
  else
    var_4 = var_3;

  if(self.stairsstate == var_4)
    return 1;

  return var_4 == self getstairsstateatdist(0.0);
}

getstairsexitdist() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 13;
    case "casual_gun":
      return 10;
    case "frantic":
    case "combat":
      var_1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var_1, self aigetdesiredspeed()))
        return 13;

      return 10;
    default:
      return 28;
  }
}

getstairsexitdistup() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 24;
    case "casual_gun":
      return 24;
    default:
      var_1 = scripts\asm\shared\utility::getbasearchetype();

      if(scripts\asm\shared\utility::isspeedwithincqbrange(var_1, self aigetdesiredspeed()))
        return 15;

      return 28;
  }
}

getgroundangle() {
  var_0 = self actorgetgroundslope();

  if(abs(var_0) > 0.99)
    return 0;

  var_1 = acos(var_0);
  return var_1;
}

shouldinterruptstairsarrival(var_0, var_1, var_2, var_3) {
  return self.stairsstate != "none" && shouldexitstairsstate(var_0, var_1, var_2, var_3);
}

shouldexitstairsstate(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.disablestairsexits) && self._blackboard.disablestairsexits)
    return 0;

  if(self.stairsstate == "none")
    return 1;

  var_4 = var_3;

  if(!self codemoverequested())
    return 1;

  var_5 = getstairsexitdist();

  if(isDefined(var_3) && var_3 == "up")
    var_5 = getstairsexitdistup();

  if(self.stairsstate != var_4)
    return 1;

  var_6 = self getstairsstateatdist(var_5);
  return var_6 != self.stairsstate;
}

chooseanim_stairs(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "left")
    var_3 = "right";
  else
    var_3 = "left";

  var_4 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var_4, self aigetdesiredspeed())) {
    var_5 = "cqb" + var_3;

    if(scripts\asm\asm::asm_hasalias(var_1, var_5))
      var_3 = var_5;
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_6;
}

chooseanim_stairs_rise_run(var_0, var_1, var_2) {
  var_3 = "8x10";
  var_4 = getgroundangle();

  if(var_4 < 27.75)
    var_3 = "8x20";

  if(var_4 >= 27.75 && var_4 < 36.2)
    var_3 = "8x12";

  if(var_4 >= 36.2 && var_4 < 41.85)
    var_3 = "8x10";

  if(var_4 >= 41.85)
    var_3 = "8x8";

  var_5 = scripts\asm\shared\utility::getbasearchetype();

  if(scripts\asm\shared\utility::isspeedwithincqbrange(var_5, self aigetdesiredspeed())) {
    var_6 = "cqb" + var_3;

    if(scripts\asm\asm::asm_hasalias(var_1, var_6))
      var_3 = var_6;
  }

  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_7;
}

playanim_stairs(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
  playmoveloop_codeblend(var_0, var_1, var_2);
}

stairs_terminate(var_0, var_1, var_2) {
  self setdefaultaimlimits();
}

slopeupdate(var_0, var_1, var_2) {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self.useslopes) && self.useslopes == 1) {
    var_3 = 0;
    var_4 = 0;
    var_5 = (0, 0, 1);
    self endon(var_1 + "_finished");
    var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_1 + "_knob");
    var_7 = scripts\asm\asm::asm_getxanim(var_1, var_6);
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_1 + "_scrub_anim");
    var_9 = scripts\asm\asm::asm_getxanim(var_1, var_8);
    self setanim(var_7, 1.0, 0.1, 0);
    self setanim(var_9, 1.0, 0.1, 0);

    for(;;) {
      var_10 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 12), self.origin - (0, 0, 999));
      var_11 = var_10["normal"];
      var_11 = vectorlerp(var_5, var_11, 0.25);
      var_5 = var_11;
      var_12 = anglestoup(self.angles);
      var_13 = scripts\engine\math::vector_project_onto_plane(var_11, var_12);
      var_14 = self.angles;
      var_15 = anglesToForward(var_14);
      var_16 = scripts\engine\math::anglebetweenvectorssigned(var_15, var_13, var_12);
      var_3 = var_16 + 180;
      var_17 = var_11[2];
      var_4 = scripts\engine\math::normalize_value(1, 0.707, var_17);
      var_4 = 1 - var_4;
      self setanim(var_7, var_4, 0.2, 0);
      self setcustomnodegameparameter("slopes_scrub_direction", var_3);
      waitframe();
    }
  }
}

slopecleanup(var_0, var_1, var_2) {
  if(isagent(self)) {
    return;
  }
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_1 + "_knob");
  self clearanim(scripts\asm\asm::asm_getxanim(var_1, var_3), 0.1, "ease_inout_quad");
}

shouldstumble(var_0, var_1, var_2) {
  var_3 = scripts\asm\shared\utility::findoverridearchetype("default");

  if(var_3 != "rebel" || !isalive(self.enemy))
    return 0;

  if(!isDefined(self.shouldstumble) || !self.shouldstumble)
    return 0;

  if(!isDefined(self.stumbledelay) || self.stumbledelay > gettime())
    return 0;

  var_4 = getnearestspeedthresholdname(var_3, "jog");
  var_5 = length(self.velocity);

  if(var_5 < var_4)
    return 0;

  var_6 = 280;
  var_7 = 265;
  var_8 = 0.93969;
  var_9 = self getposonpath(var_6);
  var_10 = var_9 - self.origin;
  var_11 = anglesToForward(self.angles);
  var_12 = self stairswithindistance(var_6);

  if(vectordot(var_11, var_10) < var_8 || length(var_10) < var_7 || var_12)
    return 0;

  return 1;
}

stumblechooseanim(var_0, var_1, var_2) {
  var_3 = scripts\asm\shared\utility::getbasearchetype();
  var_4 = getnearestspeedthresholdname(var_3, "run");
  var_5 = getnearestspeedthresholdname(var_3, "sprint");
  var_6 = length(self.velocity);
  var_7 = "stumble_jog";

  if(var_6 > var_5)
    var_7 = "stumble_sprint";

  if(var_6 > var_4)
    var_7 = "stumble_run";

  return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_7);
}

stumbleterminate(var_0, var_1, var_2) {
  self.shouldstumble = undefined;
}

playanim_stumble(var_0, var_1, var_2) {
  thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
  thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 0);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}