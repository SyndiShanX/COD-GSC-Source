/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\move.gsc
***********************************************/



#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace move;

function playanim_exit(asmname, statename, params) {
  self endon(statename + "_finished");
  startanim = asm_getanim(asmname, statename);
  self.var_57e1b0c4ad45db70 = undefined;

  if(isDefined(self.battlechatterallowed) && self.battlechatterallowed) {
    var_2e5e380655d9414 = issubstr(statename, "cover");
    thread movebattlechatter_helper(var_2e5e380655d9414);
  }

  if(!isDefined(startanim)) {
    desiredspeed = self aigetdesiredspeed();
    targetspeed = 50;

    if(targetspeed > desiredspeed) {
      targetspeed = 0.5 * desiredspeed;
    }

    self aisettargetspeed(targetspeed);
    asm_fireevent(asmname, "abort");
    asm_fireevent(asmname, "code_move");
    asm_fireevent(asmname, "end");
    asm_fireevent(asmname, "finish");
    return;
  }

  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 1;
  var_bef3b4b769e8abe4 = 0;

  if(isDefined(params)) {
    var_bef3b4b769e8abe4 = params;
  }

  playstartanim(asmname, statename, startanim, var_bef3b4b769e8abe4);

  if(isDefined(self.exitspeedtarget)) {
    self aisettargetspeed(float(self.exitspeedtarget));
  }
}

function chooseanim_exit(asmname, statename, params) {
  bsoldierversion = 0;

  if(isDefined(params)) {
    if(isarray(params)) {
      bsoldierversion = istrue(params[0]);
    } else {
      bsoldierversion = istrue(params);
    }
  }

  if(bsoldierversion) {
    return chooseanim_exitsoldier(asmname, statename, params);
  }

  if(!checktransitionpreconditions()) {
    return undefined;
  }

  exitanim = undefined;
  var_8a1b6d26fbf96ea9 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1])) {
    var_8a1b6d26fbf96ea9 = params[1];
  }

  exitanim = determinestartanim(statename, var_8a1b6d26fbf96ea9);
  return exitanim;
}

function determinedesiredexitspeed() {
  var_a7d951a8f516dc41 = 70;
  desiredspeed = self getdesiredscaledspeedforposalongpath(var_a7d951a8f516dc41);

  if(self.cautiousnavigation) {
    desiredspeed = 90;
  }

  return desiredspeed;
}

function chooseanim_exitsoldier(asmname, statename, params) {
  suffix = "";

  if(isentasoldier() && demeanorhasblendspace()) {
    desiredspeed = determinedesiredexitspeed();
    archetype = self getbasearchetype();
    suffix = getnextlowestspeedthresholdstring(archetype, desiredspeed);
    self.exitspeedtarget = getanimspeedthreshold(archetype, suffix);
  } else {
    self.exitspeedtarget = undefined;
  }

  if(!checktransitionpreconditions()) {
    return undefined;
  }

  exitanim = undefined;
  var_8a1b6d26fbf96ea9 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1])) {
    var_8a1b6d26fbf96ea9 = params[1];
  }

  exitanim = determinestartanim(statename, var_8a1b6d26fbf96ea9, suffix);
  return exitanim;
}

function getstartanim(statename, optionalsuffix, idx, nearanglediff) {
  if(!isDefined(optionalsuffix)) {
    optionalsuffix = "";
  }

  assert(!asm_hasalias(statename, "0" + optionalsuffix));
  assert(!asm_hasalias(statename, "5" + optionalsuffix));
  var_f9129a56a004cdb7 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  keypadidx = var_f9129a56a004cdb7[idx];

  if(keypadidx == 8) {
    if(nearanglediff < 0) {
      aliasname = keypadidx + "r" + optionalsuffix;
    } else {
      aliasname = keypadidx + "l" + optionalsuffix;
    }
  } else {
    aliasname = keypadidx + optionalsuffix;
  }

  return asm_lookupanimfromaliasifexists(statename, aliasname);
}

function getstartmindist() {
  demeanor = asm_getdemeanor();

  if(demeanor == "casual" || demeanor == "casual_gun" || self aigetdesiredspeed() <= 60) {
    return 75;
  }

  return 100;
}

function getexitnode() {
  exitnode = undefined;
  limit = 400;

  if(actor_is3d()) {
    limit = 1024;
  } else if(isDefined(self.heat)) {
    limit = 4096;
  }

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < limit) {
    exitnode = self.node;
  } else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < limit) {
    exitnode = self.prevnode;
  }

  if(isDefined(self.heat) && !actor_is3d()) {
    if(isDefined(exitnode) && absangleclamp180(self.angles[1] - exitnode.angles[1]) > 30) {
      return undefined;
    }
  }

  return exitnode;
}

function determinestartanim(statename, var_8a1b6d26fbf96ea9, optionalsuffix) {
  negstartnode = self getnegotiationstartnode();

  if(isDefined(negstartnode)) {
    goalpos = negstartnode.origin;
  } else {
    goalpos = self.pathgoalpos;
  }

  assert(isDefined(goalpos));
  exitnode = getexitnode();

  if(var_8a1b6d26fbf96ea9) {
    lookaheadpos = self.origin + self.lookaheaddir * self.lookaheaddist;
    nearlookaheadpos = lookaheadpos;
  } else {
    lookaheadpos = self getposonpath(128);
    nearlookaheadpos = self getposonpath(32);
  }

  lookaheadangles = vectortoangles(lookaheadpos - self.origin);
  nearlookaheadangles = vectortoangles(nearlookaheadpos - self.origin);

  if(nodeshouldfaceangles(exitnode) && !var_8a1b6d26fbf96ea9) {
    currentangles = exitnode.angles;
  } else {
    currentangles = self.angles;
  }

  anglediff = angleclamp180(lookaheadangles[1] - currentangles[1]);
  nearanglediff = angleclamp180(nearlookaheadangles[1] - currentangles[1]);
  var_28f7bf20c229aedb = vectortoangles(self.lookaheaddir);
  var_8ebc075f7302487d = angleclamp180(var_28f7bf20c229aedb[1] - currentangles[1]);

  if(abs(var_8ebc075f7302487d) > 135 && abs(anglediff) < 90) {
    return undefined;
  }

  if(length2dsquared(self.velocity) > 64) {
    velangles = vectortoangles(self.velocity);

    if(abs(angleclamp180(velangles[1] - lookaheadangles[1])) < 45) {
      return;
    }
  }

  mindist = getstartmindist();

  if(self pathdisttogoal(1) < mindist) {
    return;
  }

  angleindices = getangleindices(anglediff);
  curpossnapped = self getnavposition();
  idx = angleindices[0];
  startanim = undefined;

  if(isDefined(self.var_57e1b0c4ad45db70)) {
    startanim = getstartanim(self.var_57e1b0c4ad45db70, optionalsuffix, idx, nearanglediff);
  } else {
    startanim = getstartanim(statename, optionalsuffix, idx, nearanglediff);
  }

  if(!isDefined(self.var_57e1b0c4ad45db70)) {
    exitcover = issubstr(statename, "cover");
    animangles = currentangles;

    if(exitcover && isDefined(exitnode)) {
      var_950fdaf84ee5363 = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
      yawoffset = var_950fdaf84ee5363[idx];

      if(issubstr(statename, "left") && idx == 4) {
        yawoffset *= -1;
      }

      animangles = (0, angleclamp(exitnode.angles[1] + yawoffset), 0);
    } else {
      var_fd659656ff546e = [180, -135, -90, -45, 0, 45, 90, 135, 180];
      yawoffset = var_fd659656ff546e[idx];
      animangles = (0, angleclamp(self.angles[1] + yawoffset), 0);
    }

    fmindist = 20;
    animmovedelta = anglesToForward(animangles);
    velocity = animmovedelta * self aigettargetspeed();
    movedelta = vectorNormalize(animmovedelta) * 5;
    exitdata = self getadjustedexitdirection(fmindist, velocity, movedelta);

    switch (exitdata[0]) {
      case 1:
        exitdata[1] = vectorNormalize(exitdata[1]);
        adjustedexitangles = vectortoangles(exitdata[1]);
        var_cbfa26d1fe952710 = math::wrap(-179, 179, angleclamp180(adjustedexitangles[1] - currentangles[1]));
        var_926edf5ccd852690 = getangleindices(var_cbfa26d1fe952710, 45);
        var_4b4b8fb40b0a2db2 = angleclamp180(animangles[1] - currentangles[1]);
        currentexitangles = getangleindices(var_4b4b8fb40b0a2db2);
        newindex = var_926edf5ccd852690[0];

        for(i = var_926edf5ccd852690.size - 1; i >= 0; i--) {
          angleindex = var_926edf5ccd852690[i];

          if(angleindex == currentexitangles[0]) {
            continue;
          } else if((idx == 8 || idx == 0) && (angleindex == 8 || angleindex == 0)) {
            continue;
          } else if(angleindex == idx) {
            continue;
          }

          newindex = angleindex;
          break;
        }

        idx = newindex;
        self.asm.customdata.ignoreexitwarp = 1;
        startanim = getstartanim(statename, optionalsuffix, idx, nearanglediff);
        break;
      case 2:
        startanim = undefined;
        break;
      default:
        break;
    }
  }

  return startanim;
}

function movebattlechatter_helper(var_2e5e380655d9414) {
  self endon("death");
  waitframe();
  movestartbattlechatter(var_2e5e380655d9414);
}

function function_c0771b0b4a16ebde(statename) {
  if(getdvarint(@ "hash_79e471363d9c6b91", 0) == 0) {
    return;
  }

  self notify("<dev string:x1c>");
  self endon("<dev string:x2e>");
  self endon(statename + "<dev string:x40>");

  while(true) {
    print3d(self.origin + (0, 0, 72), "<dev string:x4a>", (1, 0.25, 0.25), 1, 2, 1);
    wait 0.05;
  }
}

function function_ac721a17dab10e87(suffix, statename, node) {
  if(isDefined(suffix) && suffix != "<dev string:x4c>") {
    thread function_c0771b0b4a16ebde(statename);
  }

  if(isDefined(node) && node.type != "<dev string:x55>") {
    thread function_c0771b0b4a16ebde(statename);
  }
}

function playstartanim(asmname, statename, startanim, var_bef3b4b769e8abe4) {
  self endon(statename + "_finished");
  lookaheadpos = self getposonpath(128);
  lookaheadangles = vectortoangles(lookaheadpos - self.origin);
  anglediff = angleclamp180(lookaheadangles[1] - self.angles[1]);
  startxanim = asm_getxanim(statename, startanim);
  var_370a8c08be55a7a5 = getnotetracktimes(startxanim, "code_move");
  cornertimes = getnotetracktimes(startxanim, "corner");
  warpstarttimes = getnotetracktimes(startxanim, "warp_exit_start");
  var_d9a20f501851b31e = getnotetracktimes(startxanim, "warp_exit_end");
  endtimefrac = 1;

  if(var_370a8c08be55a7a5.size > 0) {
    self.requestarrivalnotify = 1;
    endtimefrac = var_370a8c08be55a7a5[0];
  }

  startanimangles = getangledelta3d(startxanim, 0, endtimefrac);
  self animmode("zonly_physics", 0);
  self setuseanimgoalweight(0.2);
  exitrate = self.moveplaybackrate;

  if(demeanorhasblendspace() && isentasoldier()) {
    exitrate = 1;
  }

  var_da09f2e04da7570e = getmovedelta(startxanim, 0, endtimefrac);
  var_c4ec2d674bc02eb4 = length(var_da09f2e04da7570e);
  var_9c52e37b49e97a0b = self getposonpath(var_c4ec2d674bc02eb4);

  if(var_c4ec2d674bc02eb4 > 1) {
    var_b46ed9e10e2b2da0 = var_9c52e37b49e97a0b - self getnavposition();
  } else {
    var_b46ed9e10e2b2da0 = self getposonpath(12) - self getnavposition();
  }

  var_2c820822533ffafc = vectortoyaw(var_b46ed9e10e2b2da0);
  asm_playfacialanim(asmname, statename, startxanim);
  self aisetanim(statename, startanim, exitrate);
  var_5c0d1cbfc351f2e1 = 1;
  animdata = spawnStruct();
  animdata.xanim = startxanim;

  if(isDefined(self.asm.customdata.ignoreexitwarp)) {} else if(cornertimes.size > 0) {
    cornertranslation = getmovedelta(startxanim, 0, cornertimes[0]);
    cornerdist = length(cornertranslation);
    cornerposonpath = self getposonpath(cornerdist);
    var_5076fb03fb7166e3 = var_9c52e37b49e97a0b;

    if(var_c4ec2d674bc02eb4 - cornerdist < 2) {
      var_5076fb03fb7166e3 = self getposonpath(var_c4ec2d674bc02eb4 + 6);
    }

    var_f41896ed9d57f898 = var_5076fb03fb7166e3 - cornerposonpath;
    var_364f8dea82c92744 = vectortoyaw(var_f41896ed9d57f898);

    if(warpstarttimes.size > 0 && warpstarttimes[0] > 0 && warpstarttimes[0] < cornertimes[0]) {
      animdata.posalongpath = cornerposonpath;
      animdata.anglealongpath = var_364f8dea82c92744;
      animdata.endnote = "corner";

      if(var_d9a20f501851b31e.size > 0 && var_d9a20f501851b31e[0] < cornertimes[0]) {
        animdata.duration = int((var_d9a20f501851b31e[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000 / exitrate);
      }
    } else {
      motionwarpwithnotetracks(startxanim, cornerposonpath, (0, var_364f8dea82c92744, 0), undefined, "corner", undefined, 0);
    }
  } else if(warpstarttimes.size == 0 || warpstarttimes[0] == 0) {
    assertex(var_370a8c08be55a7a5.size > 0, "Animation requires code_move for motion warp: " + getxhashsourcename(getanimname(startxanim)));
    duration = undefined;

    if(warpstarttimes.size > 0 && var_d9a20f501851b31e.size > 0 && var_d9a20f501851b31e[0] < var_370a8c08be55a7a5[0]) {
      duration = int((var_d9a20f501851b31e[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000);
    }

    motionwarpwithnotetracks(startxanim, var_9c52e37b49e97a0b, (0, var_2c820822533ffafc, 0), undefined, "code_move", duration, 0);
  }

  if(!isDefined(animdata.posalongpath)) {
    animdata.posalongpath = var_9c52e37b49e97a0b;
    animdata.anglealongpath = var_2c820822533ffafc;
    animdata.endnote = "code_move";

    if(warpstarttimes.size > 0 && var_d9a20f501851b31e.size > 0) {
      animdata.duration = int((var_d9a20f501851b31e[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000 / exitrate);
    }
  }

  groundent = self getgroundentity();

  if(isDefined(groundent)) {
    animdata = motionwarp_localizedata(animdata, groundent);
  }

  asm_donotetracks(asmname, statename, &handlewarpexitstart, animdata, undefined, !var_bef3b4b769e8abe4);
  self motionwarpcancel();

  if(var_bef3b4b769e8abe4) {
    self animmode("normal", 0);
    self orientmode("face motion");
    asm_donotetracks(asmname, statename);
  }
}

function motionwarp_localizedata(animdata, groundent) {
  var_d352089b1ad84c9f = invertangles(groundent.angles);
  var_ae6b4de373bb5886 = animdata.posalongpath - groundent.origin;
  var_175bb7a3f0ea3191 = rotatevector(var_ae6b4de373bb5886, var_d352089b1ad84c9f);
  animdata.posalongpath = var_175bb7a3f0ea3191;
  animdata.anglealongpath = combineangles((0, animdata.anglealongpath, 0), var_d352089b1ad84c9f);
  animdata.groundent = groundent;
  return animdata;
}

function motionwarp_getworldifydata(animdata) {
  posalongpath = undefined;
  anglealongpath = undefined;
  groundent = animdata.groundent;

  if(isDefined(groundent)) {
    var_175bb7a3f0ea3191 = animdata.posalongpath;
    var_ae6b4de373bb5886 = rotatevector(var_175bb7a3f0ea3191, groundent.angles);
    posalongpath = var_ae6b4de373bb5886 + groundent.origin;
    angles = combineangles(animdata.anglealongpath, groundent.angles);
    anglealongpath = angles[1];
    return [posalongpath, anglealongpath];
  }

  return [animdata.posalongpath, animdata.anglealongpath];
}

function handlewarpexitstart(note, params) {
  posalongpath = undefined;
  anglealongpath = undefined;

  if(note == "warp_exit_start" && !isDefined(self.asm.customdata.ignoreexitwarp)) {
    assert(isDefined(params) && isstruct(params));
    endnote = params.endnote;

    if(!isDefined(endnote)) {
      endnote = "warp_exit_end";
    }

    duration = undefined;

    if(isDefined(params.duration)) {
      duration = params.duration - params.duration % 50;
    }

    assert(animhasnotetrack(params.xanim, endnote));
    [posalongpath, anglealongpath] = motionwarp_getworldifydata(params);
    motionwarpwithnotetracks(params.xanim, posalongpath, (0, anglealongpath, 0), "warp_exit_start", endnote, duration, 0);
  }
}

function checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos)) {
    debug_arrival("<dev string:x5d>" + self getentitynumber() + "<dev string:x75>");

    return false;
  }

  if(!self.facemotion) {
    debug_arrival("<dev string:x5d>" + self getentitynumber() + "<dev string:x96>");

    return false;
  }

  if(isDefined(self.disableexits) && self.disableexits) {
    debug_arrival("<dev string:x5d>" + self getentitynumber() + "<dev string:xb2>");

    return false;
  }

  if(self.stairsstate != "none") {
    debug_arrival("<dev string:x5d>" + self getentitynumber() + "<dev string:xcf>");

    return false;
  }

  mindist = 100;
  demeanor = asm_getdemeanor();

  if(asm_getdemeanor() == "casual" || asm_getdemeanor() == "casual_gun" || self aigetdesiredspeed() <= 60) {
    mindist = 50;

    if(istrue(self.disablearrivals)) {
      mindist = 25;
    }
  } else if(istrue(self.disablearrivals)) {
    mindist = 50;
  }

  if(self pathdisttogoal() < mindist) {
    debug_arrival("<dev string:x5d>" + self getentitynumber() + "<dev string:xdc>");

    return false;
  }

  return true;
}

function chooseanim_runngun(asmname, statename, params) {
  self.runngun = 1;
  assertex(isDefined(self.enemy), "No enemy?! This should be guaranteed via check in ai_asm_builtin.cpp::ShouldRunNGun");
  shootfrompos = self getshootfrompos();
  targetposstruct = self getshootpos(shootfrompos);

  if(isDefined(targetposstruct)) {
    targetpos = targetposstruct.shootpos;
  } else {
    targetpos = self lastknownpos(self.enemy);
  }

  metotargetdir = targetpos - self getposonpath(14);
  metotargetyaw = vectortoyaw(metotargetdir);
  pathyaw = vectortoyaw(self.lookaheaddir);
  faceyawdelta = angleclamp180(metotargetyaw - pathyaw);
  runningfireanim = -1;

  if(faceyawdelta > 100) {
    runningfireanim = asm_lookupanimfromalias(statename, "run_n_gun_hard_left");
  } else if(faceyawdelta < -100) {
    runningfireanim = asm_lookupanimfromalias(statename, "run_n_gun_hard_right");
  } else if(faceyawdelta > 0) {
    runningfireanim = asm_lookupanimfromalias(statename, "run_n_gun_soft_left");
  } else {
    runningfireanim = asm_lookupanimfromalias(statename, "run_n_gun_soft_right");
  }

  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 0;
  self function_952292d70c3bd39c();
  return runningfireanim;
}

function stoprunngun(asmname, statename, params) {
  self.runngun = 0;
  self.runngundisableaim = 0;
  self.baimedataimtarget = 0;
}

function shouldstrafeaimchange(asmname, statename, tostatename, params) {
  bdisableaimchange = 1;

  if(bdisableaimchange) {
    return false;
  }

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

  stairsenterdist = self getstairsenterdist();
  var_50cfd72556c53ee8 = self getstairsstateatdist(stairsenterdist);

  if(var_50cfd72556c53ee8 != "none") {
    return false;
  }

  targetspeed = self aigettargetspeed();

  if(self.lookaheaddist < 90) {
    return false;
  }

  pathyaw = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9) {
    return false;
  }

  var_8c3ab01d2f494a38 = self asmeventfiredwithin(asmname, "sharp_turn", 50);

  if(var_8c3ab01d2f494a38) {
    newheadingyawdelta = angleclamp180(pathyaw - self.angles[1]);
    headingyawdelta = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(headingyawdelta - newheadingyawdelta)) > 45) {
      return false;
    }
  } else {
    headingyawdelta = angleclamp180(pathyaw - self.angles[1]);
  }

  shootfrompos = self getshootfrompos();
  targetposstruct = self getshootpos(shootfrompos);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe()) {
    faceyawdelta = 0;
  } else if(isDefined(targetposstruct) || self iscurrentenemyvalid()) {
    if(isDefined(targetposstruct)) {
      targetpos = targetposstruct.shootpos;
    } else {
      if(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000) {
        return false;
      }

      targetpos = self lastknownpos(self.enemy);
    }

    if(distance2dsquared(targetpos, self.origin) < 22500) {
      return false;
    }

    metotargetdir = targetpos - self getposonpath(32);
    metotargetyaw = vectortoyaw(metotargetdir);

    if(abs(angleclamp180(metotargetyaw - self.angles[1])) < 45) {
      return false;
    }

    faceyawdelta = angleclamp180(pathyaw - metotargetyaw);
  } else if(istrue(self._blackboard.forcestrafe)) {
    return false;
  } else {
    if(var_8c3ab01d2f494a38 || self pathdisttogoal() < 64) {
      return false;
    }

    faceyawdelta = angleclamp180(pathyaw - self.desiredangle);
  }

  if(abs(angleclamp180(headingyawdelta - faceyawdelta)) < 45) {
    return false;
  }

  curdir = scripts\asm\asm::yawdiffto2468(headingyawdelta);
  desireddir = scripts\asm\asm::yawdiffto2468(faceyawdelta);

  if(curdir == desireddir) {
    return false;
  }

  speedstring = "fast";

  if(isentasoldier() && demeanorhasblendspace()) {
    archetype = self getbasearchetype();
    speedstring = getnearestspeedthresholdname(archetype, targetspeed);

    if(speedstring == "shuffle" || speedstring == "walk") {
      speedstring = "walk";
    } else if(speedstring != "fast") {
      speedstring = "fast";
    }

    self.strafepoispeedtarget = getanimspeedthreshold(archetype, speedstring);
  } else {
    self.strafepoispeedtarget = undefined;
  }

  alias = speedstring + "_" + self.asm.strafe_foot + "_" + curdir + "_to_" + desireddir;

  if(!asm_hasalias(tostatename, alias)) {
    if(curdir == "4" || curdir == "6") {
      alias = speedstring + "_feet_together_" + curdir + "_to_" + desireddir;
    } else {
      alias = speedstring + "_foot_l_forward_" + curdir + "_to_" + desireddir;
    }

    if(!asm_hasalias(tostatename, alias)) {
      return false;
    }
  }

  self.asm.strafeaimchangealias = alias;
  return true;
}

function shouldrestartaimchange(asmname, statename, tostatename, params) {
  if(asm_eventfired(asmname, "code_move") && shouldstrafeaimchange(asmname, statename, tostatename, params)) {
    return true;
  }

  return false;
}

function aimchangeorientation(turnxanim, rate, endtime, faceyawtarget, totalanimlength) {
  self endon("end_aim_change_orient");
  self.aimchange_oldturnrate = self.turnrate;
  totalangledelta = getangledelta(turnxanim, 0, endtime);
  yawtotarget = faceyawtarget - self.angles[1];
  yawtotarget = angleclamp180(yawtotarget);
  totalyawfixup = angleclamp180(yawtotarget - totalangledelta);
  animyawremaining = totalangledelta;

  while(isDefined(self) && isalive(self)) {
    currentanimtime = self aigetanimtime(turnxanim);
    nextanimtime = min(currentanimtime + level.frameduration / 1000 / totalanimlength * rate, 1);
    var_8ccbb038d1a5d254 = getangledelta(turnxanim, currentanimtime, nextanimtime);

    if((animyawremaining - var_8ccbb038d1a5d254) * animyawremaining > 0) {
      animyawremaining -= var_8ccbb038d1a5d254;
    } else {
      var_8ccbb038d1a5d254 = animyawremaining;
      animyawremaining = 0;
    }

    lerpfraction = var_8ccbb038d1a5d254 / totalangledelta;
    var_bac2c21af365572b = totalyawfixup * lerpfraction;
    rotatethisframe = var_8ccbb038d1a5d254 + var_bac2c21af365572b;
    faceangle = angleclamp(self.angles[1] + rotatethisframe);
    var_6b38b069b1d09ad = angleclamp(self.angles[1] + clamp(rotatethisframe * 3, -179, 179.9));
    self orientmode("face angle", var_6b38b069b1d09ad);

    if(rotatethisframe != 0) {
      turnrate = abs(angleclamp180(self.angles[1] - faceangle)) / level.frameduration;

      if(turnrate > 0) {
        self.turnrate = turnrate;
      }
    }

    waitframe();
  }
}

function playanim_strafeaimchange(asmname, statename, params) {
  self endon(statename + "_finished");
  animindex = asm_getanim(asmname, statename);
  turnxanim = asm_getxanim(statename, animindex);
  self.asm.strafeaimchangealias = undefined;
  self.sharpturnforceusevelocity = 1;
  rate = 1;
  exitspeed = undefined;

  if(isDefined(self.strafepoispeedtarget) && isentasoldier() && demeanorhasblendspace()) {
    targetspeed = self aigettargetspeed();
    rate = targetspeed / self.strafepoispeedtarget;
    exitspeed = targetspeed;
    rate = clamp(rate, 0.6, 1.4);
  }

  self aisetanim(statename, animindex, rate);
  asm_playfacialanim(asmname, statename, turnxanim);
  codemovetimes = getnotetracktimes(turnxanim, "code_move");
  finishnotes = getnotetracktimes(turnxanim, "finish");
  endtime = 1;

  if(codemovetimes.size > 0) {
    endtime = codemovetimes[0];
  } else if(finishnotes.size > 0) {
    endtime = finishnotes[0];
  }

  totalanimlength = getanimlength(turnxanim);
  animlength = totalanimlength * endtime;
  faceyawtarget = vectortoyaw(self.lookaheaddir);
  facetargetpos = undefined;

  if(!istrue(self.facemotion) && !istrue(self.predictedfacemotion) && !self shouldcautiousstrafe()) {
    animmovedelta = getmovedelta(turnxanim, 0, endtime);
    pathendpos = self getposonpath(length(animmovedelta));
    shootfrompos = self getshootfrompos();
    targetposstruct = self getshootpos(shootfrompos);
    enemypos = undefined;

    if(isDefined(targetposstruct)) {
      enemypos = targetposstruct.shootpos;
    } else if(isDefined(self.enemy)) {
      enemypos = self lastknownpos(self.enemy);
    }

    if(isDefined(enemypos)) {
      metotargetdir = vectorNormalize(enemypos - pathendpos);
      faceyawtarget = vectortoyaw(metotargetdir);
      facetargetpos = enemypos;
    }
  }

  thread aimchangeorientation(turnxanim, rate, endtime, faceyawtarget, totalanimlength);
  note = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    if(self.aimchange_oldturnrate > 0) {
      self.turnrate = self.aimchange_oldturnrate;
    }

    self.aimchange_oldturnrate = undefined;
  }

  if(note == "code_move") {
    if(isDefined(facetargetpos)) {
      self orientmode("face point", facetargetpos);
    } else {
      self orientmode("face angle", faceyawtarget);
    }

    self animmode("normal");
    asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  }

  if(isDefined(exitspeed)) {
    self aisettargetspeed(exitspeed);
  }
}

function chooseanim_strafeaimchange(asmname, statename, params) {
  assert(isDefined(self.asm.strafeaimchangealias));
  return asm_lookupanimfromalias(statename, self.asm.strafeaimchangealias);
}

function strafeaimchange_cleanup(asmname, statename, params) {
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    self.turnrate = self.aimchange_oldturnrate;
    self.aimchange_oldturnrate = undefined;
  }

  self.sharpturnforceusevelocity = 0;
}

function handlestrafenotetracks(note) {
  switch (note) {
    case #"hash_e13cf484a444d070":
      self.asm.strafe_foot = "feet_together";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_622de61830d10b28":
      self.asm.strafe_foot = "feet_apart";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_725f3a6c07952190":
      self.asm.strafe_foot = "foot_l_forward";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_e81afc35eec1256e":
      self.asm.strafe_foot = "foot_r_forward";
      self.asm.strafe_foot_time = gettime();
      break;
  }
}

function playanim_strafereverse(asmname, statename, params) {
  self endon(statename + "_finished");
  zonlytime = 0.4;
  blankanimid = asm_getanim(asmname, statename);
  self aisetanim(statename, blankanimid);
  self orientmode("face enemy or motion");
  self setstrafereverse(1);
  endnote = asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);

  if(endnote == "code_move") {
    self animmode("normal");
    endnote = asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);
  }

  asm_fireevent(asmname, "end");
}

function strafereverse_cleanup(asmname, statename, params) {
  self setstrafereverse(0);
}

function chooseanim_strafearrive(asmname, statename, params) {
  assert(isDefined(self.asm.strafearrival_animindex));
  return self.asm.strafearrival_animindex;
}

function choosewalkandtalkanims(asmname, statename, params) {
  animstruct = spawnStruct();
  moveanims = [];
  moveanims[0] = asm_lookupanimfromalias(statename, "0");
  moveanims[1] = asm_lookupanimfromalias(statename, "1");
  moveanims[2] = asm_lookupanimfromalias(statename, "2");
  animstruct.anims = moveanims;
  animstruct.forwardanim = asm_lookupanimfromalias(statename, "forward");
  return animstruct;
}

function shouldwalkandtalk() {
  return bb_moverequested() && isDefined(self._blackboard.walk_and_talk_requested) && self._blackboard.walk_and_talk_requested;
}

function walkandtalkdonotetracks(asmname, statename) {
  self endon(statename + "_finished");

  while(true) {
    asm_donotetracks(asmname, statename);
  }
}

function movewalkandtalk(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  rate = asm_getmoveplaybackrate();
  asm_updatefrantic();
  self codemoveanimrate(rate);
  asm_updatefrantic();
  animstruct = asm_getanim(asmname, statename);
  anims = animstruct.anims;
  forwardanim = animstruct.forwardanim;
  self aiclearanim(asm_getbodyknob(), 0.2);
  self setflaggedanim(statename, forwardanim, 1, 0.2, 1);
  thread walkandtalkdonotetracks(asmname, statename);
  lastangle = 0;
  blendframes = 20;

  while(true) {
    arrival = asm_eventfired(asmname, "cover_approach");
    disttogoal = self pathdisttogoal();

    if(arrival && disttogoal < 150) {
      anglediff = anglediffwalkandtalk();
      index = 1;

      while(index <= blendframes) {
        i = index / blendframes;
        result = i * i * (3 - 2 * i);
        transitiondegree = anglediff;
        actualangle = transitiondegree * result;
        interpolatedangle = transitiondegree - actualangle;
        animweights = getwalkandtalkanimweights(interpolatedangle);

        for(animindex = 0; animindex < animweights.size; animindex++) {
          self setanim(anims[animindex], animweights[animindex], 0.2, 1, 1);
        }

        index++;
        wait 0.05;
        waittillframeend();
      }

      while(arrival) {
        animweights = getwalkandtalkanimweights(0);

        for(index = 0; index < animweights.size; index++) {
          if(isDefined(anims[index])) {
            self setanim(anims[index], animweights[index], 0.2, 1, 1);
          }
        }

        wait 0.05;
        waittillframeend();
      }

      continue;
    }

    anglediff = anglediffwalkandtalk();
    largetransition = lastangle - anglediff;

    if(largetransition < 0) {
      largetransition *= -1;
    }

    if(largetransition >= 60) {
      lastplayerangle = lastangle;
      var_71ea1ef57b26f1b9 = lastangle;
      index = 1;

      while(index <= blendframes) {
        anglediff = anglediffwalkandtalk();
        secondarylargetransition = lastplayerangle - anglediff;

        if(secondarylargetransition < 0) {
          secondarylargetransition *= -1;
        }

        if(secondarylargetransition >= 60) {
          if(index == 1) {
            index = 1;
          } else {
            index -= 1;
          }

          newangle = lastplayerangle - lastangle;
          i = index / blendframes;
          result = i * i * (3 - 2 * i);
          newactualangle = newangle * result;
          var_71ea1ef57b26f1b9 = newactualangle + lastangle;
          index = 1;
          lastangle = var_71ea1ef57b26f1b9;
        }

        i = index / blendframes;
        result = i * i * (3 - 2 * i);
        transitiondegree = anglediff - var_71ea1ef57b26f1b9;
        actualangle = transitiondegree * result;
        interpolatedangle = actualangle + lastangle;
        animweights = getwalkandtalkanimweights(interpolatedangle);

        for(animindex = 0; animindex < animweights.size; animindex++) {
          self setanim(anims[animindex], animweights[animindex], 0.2, 1, 1);
        }

        index++;
        lastplayerangle = anglediff;
        wait 0.05;
        waittillframeend();
      }
    } else {
      animweights = getwalkandtalkanimweights(anglediff);

      for(index = 0; index < animweights.size; index++) {
        if(isDefined(anims[index])) {
          self setanim(anims[index], animweights[index], 0.2, 1, 1);
        }
      }

      wait 0.05;
      waittillframeend();
    }

    lastangle = anglediff;
  }
}

function anglediffwalkandtalk() {
  targetpos = self.walk_and_talk_target.origin;
  actorpos = self.origin;
  offsetdir = targetpos - actorpos;
  facingdir = anglesToForward(self.angles);
  cross = vectorcross(facingdir, offsetdir);
  crossnormalize = vectorNormalize(cross);
  offsetnorm = vectorNormalize(offsetdir);
  facingnorm = vectorNormalize(facingdir);
  dot = vectordot(offsetnorm, facingnorm);

  if(isDefined(self.walk_and_talk_hemisphere)) {
    anglediff = math::anglebetweenvectors(offsetdir, facingdir);

    if(self.walk_and_talk_hemisphere == "right") {
      if(dot <= -1) {
        return -180;
      }

      return (anglediff * -1);
    } else {
      if(dot >= 1) {
        return 180;
      }

      return anglediff;
    }

    return;
  }

  if(dot >= 1) {
    return 180;
  }

  if(dot <= -1) {
    return -180;
  }

  anglediff = math::anglebetweenvectors(offsetdir, facingdir);

  if(crossnormalize[2] == -1) {
    anglediff *= -1;
  }

  return anglediff;
}

function getwalkandtalkanimweights(yaw) {
  animweights = [];

  for(index = 0; index < 3; index++) {
    animweights[index] = 0;
  }

  anglearray = [-180, 0, 180];

  for(index = 0; yaw >= anglearray[index]; index++) {
    assert(index < anglearray.size);
  }

  last_index = index - 1;
  next_index = index;
  assert(index > 0 && index <= 3);
  var_e0c8607002f43670 = (yaw - anglearray[last_index]) / (anglearray[next_index] - anglearray[last_index]);
  var_538bf88f24008653 = 1 - var_e0c8607002f43670;
  animweights[last_index] = var_538bf88f24008653;
  animweights[next_index] = var_e0c8607002f43670;
  animweights[1] = max(0.01, animweights[1]);
  return animweights;
}

function movestartbattlechatter(var_2e5e380655d9414) {
  movetype = scripts\asm\asm::asm_getdemeanor();

  if(movetype == "frantic" || movetype == "combat" || movetype == "sprint") {
    addbattlechatternotify(self, undefined, "move", var_2e5e380655d9414);
  }
}

function shouldreloadwhilemoving(asmname, statename, tostatename, params) {
  if(!scripts\asm\asm_bb::bb_reloadrequested()) {
    return false;
  }

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    mindist = 500;
  } else {
    mindist = 600;
  }

  disttogoal = self pathdisttogoal();
  return mindist < disttogoal;
}

function choosereloadwhilemoving(asmname, statename, params) {
  alias = "reload";
  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    alias = "cqbreload";
  }

  return asm_lookupanimfromalias(statename, alias);
}

function playreloadwhilemoving(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  reloadanim = asm_getanim(asmname, statename);
  self aisetanim(statename, reloadanim);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, reloadanim));
  asm_donotetracks(asmname, statename);
}

function terminatereloadwhilemoving(asmname, statename, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "reload done")) {
    scripts\anim\weaponlist::refillclip();
  }

  scripts\asm\soldier\script_funcs::reload_cleanup(asmname, statename, params);
}

function isonanystairs() {
  return isDefined(self.pathgoalpos) && self.stairsstate != "none";
}

function getgroundangle() {
  slope = self actorgetgroundslope();

  if(abs(slope) > 0.99) {
    return 0;
  }

  riserun = acos(slope);
  return riserun;
}

function chooseanim_stairs(asmname, statename, params) {
  assert(isDefined(self.asm.footsteps.foot));

  if(self.asm.footsteps.foot == "left") {
    alias = "right";
  } else {
    alias = "left";
  }

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    altalias = "cqb" + alias;

    if(asm_hasalias(statename, altalias)) {
      alias = altalias;
    }
  }

  stairsanim = asm_lookupanimfromalias(statename, alias);
  return stairsanim;
}

function chooseanim_stairs_rise_run(asmname, statename, params) {
  alias = "8x10";
  angle = getgroundangle();

  if(angle < 27.75) {
    alias = "8x20";
  }

  if(angle >= 27.75 && angle < 36.2) {
    alias = "8x12";
  }

  if(angle >= 36.2 && angle < 41.85) {
    alias = "8x10";
  }

  if(angle >= 41.85) {
    alias = "8x8";
  }

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    altalias = "cqb" + alias;

    if(asm_hasalias(statename, altalias)) {
      alias = altalias;
    }
  }

  stairsanim = asm_lookupanimfromalias(statename, alias);
  return stairsanim;
}

function slopeupdate(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  if(isDefined(self.useslopes) && self.useslopes == 1) {
    var_873556140ea95085 = 0;
    var_d3ee4b860b00683f = 0;
    var_8c6d33f889f4ea11 = (0, 0, 1);
    self endon(statename + "_finished");
    addknob = asm_lookupanimfromalias(statename, statename + "_knob");
    addanim = asm_getxanim(statename, addknob);
    var_3e9fff4931014eb8 = asm_lookupanimfromalias(statename, statename + "_scrub_anim");
    scrubanim = asm_getxanim(statename, var_3e9fff4931014eb8);
    self setanim(addanim, 1, 0.1, 0);
    self setanim(scrubanim, 1, 0.1, 0);

    while(true) {
      rayinfo = ray_trace(self.origin + (0, 0, 12), self.origin - (0, 0, 999));
      raynormal = rayinfo["normal"];
      raynormal = vectorlerp(var_8c6d33f889f4ea11, raynormal, 0.25);
      var_8c6d33f889f4ea11 = raynormal;
      var_753cc7857ed5a9ed = anglestoup(self.angles);
      normproj = math::vector_project_onto_plane(raynormal, var_753cc7857ed5a9ed);
      yawangles = self.angles;
      anglesforward = anglesToForward(yawangles);
      normang = anglebetweenvectorssigned(anglesforward, normproj, var_753cc7857ed5a9ed);
      var_873556140ea95085 = normang + 180;
      var_e08b4ab11320959 = raynormal[2];
      var_d3ee4b860b00683f = math::normalize_value(1, 0.707, var_e08b4ab11320959);
      var_d3ee4b860b00683f = 1 - var_d3ee4b860b00683f;
      self setanim(addanim, var_d3ee4b860b00683f, 0.2, 0);
      self setcustomnodegameparameter("slopes_scrub_direction", var_873556140ea95085);

      line(self.origin, self.origin + 300 * anglesforward, (1, 0, 0), 4);
      line(self.origin, self.origin + 300 * raynormal, (0, 1, 0), 4);
      line(self.origin, self.origin + 300 * normproj, (0, 0, 1), 4);
      print3d(self.origin + (24, 0, 66), "<dev string:xf1>" + var_873556140ea95085 + "<dev string:xf9>" + var_d3ee4b860b00683f, (0.5, 0.5, 0.75), 1, 0.45, 1);

      waitframe();
    }
  }
}

function slopecleanup(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  knob = asm_lookupanimfromalias(statename, statename + "_knob");
  self clearanim(asm_getxanim(statename, knob), 0.1, "ease_inout_quad");
}

function stumblechooseanim(asmname, statename, params) {
  archetype = self getbasearchetype();
  runthreshold = getanimspeedthreshold(archetype, "run");
  sprintthreshold = getanimspeedthreshold(archetype, "sprint");
  speed = length(self.velocity);
  alias = "stumble_jog";

  if(isDefined(sprintthreshold) && speed > sprintthreshold) {
    alias = "stumble_sprint";
  }

  if(isDefined(runthreshold) && speed > runthreshold) {
    alias = "stumble_run";
  }

  return asm_chooseanim(asmname, statename, alias);
}

function playanim_stumble(asmname, statename, params) {
  self.requestarrivalnotify = 1;
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 0;
  asm_playanimstate(asmname, statename, params);
}