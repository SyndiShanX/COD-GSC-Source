/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\move.gsc
****************************************/

#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace move;

function playanim_exit(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startanim = asm::asm_getanim(asmname, statename);
  self.var_c9829cc678d083b1 = undefined;

  if(isDefined(level.battlechatter) && isDefined(self.battlechatterallowed) && self.battlechatterallowed) {
    var_8ce119c843175fed = issubstr(statename, ":\xc9\x93\xe1?");
    thread movebattlechatter_helper(var_8ce119c843175fed);
  }

  if(!isDefined(startanim)) {
    desiredspeed = self aigetdesiredspeed();
    targetspeed = 50;

    if(targetspeed > desiredspeed) {
      targetspeed = 0.5 * desiredspeed;
    }

    self aisettargetspeed(targetspeed);
    asm::asm_fireevent(asmname, "\v\xc4\xed9\x1d");
    asm::asm_fireevent(asmname, "f\x97\xb9`\xd1~\x80(\xca");
    asm::asm_fireevent(asmname, "8\xdb\x90");
    asm::asm_fireevent(asmname, "\xd7\xca\xae\xca\xff\xdb");
    return;
  }

  self.var_998e131a705c01a2 = 1;
  self.var_526b6d7c80f6bbb3 = 1;
  var_e75f7fda0eea4831 = 0;

  if(isDefined(params)) {
    var_e75f7fda0eea4831 = params;
  }

  playstartanim(asmname, statename, startanim, var_e75f7fda0eea4831);

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
  var_40aacb1b071e0bc0 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1])) {
    var_40aacb1b071e0bc0 = params[1];
  }

  exitanim = determinestartanim(statename, var_40aacb1b071e0bc0);
  return exitanim;
}

function determinedesiredexitspeed() {
  var_91172510cdd8d384 = 70;
  desiredspeed = self getdesiredscaledspeedforposalongpath(var_91172510cdd8d384);

  if(self.cautiousnavigation) {
    desiredspeed = 90;
  }

  return desiredspeed;
}

function chooseanim_exitsoldier(asmname, statename, params) {
  suffix = "";

  if(utility::isentasoldier() && utility::demeanorhasblendspace()) {
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
  var_40aacb1b071e0bc0 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1])) {
    var_40aacb1b071e0bc0 = params[1];
  }

  exitanim = determinestartanim(statename, var_40aacb1b071e0bc0, suffix);
  return exitanim;
}

function getstartanim(statename, optionalsuffix, idx, nearanglediff) {
  if(!isDefined(optionalsuffix)) {
    optionalsuffix = "";
  }

  assert(!asm::asm_hasalias(statename, "<dev string:x24>" + optionalsuffix));
  assert(!asm::asm_hasalias(statename, "<dev string:x29>" + optionalsuffix));
  var_8982b1a74cc2999a = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  keypadidx = var_8982b1a74cc2999a[idx];

  if(keypadidx == 8) {
    if(nearanglediff < 0) {
      aliasname = keypadidx + "4" + optionalsuffix;
    } else {
      aliasname = keypadidx + "\xd5" + optionalsuffix;
    }
  } else {
    aliasname = keypadidx + optionalsuffix;
  }

  return asm::asm_lookupanimfromaliasifexists(statename, aliasname);
}

function getstartmindist() {
  demeanor = asm::asm_getdemeanor();

  if(demeanor == "#yDV,\xd6" || demeanor == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5" || self aigetdesiredspeed() <= 60) {
    return 75;
  }

  return 100;
}

function getexitnode() {
  exitnode = undefined;
  limit = 400;

  if(utility::actor_is3d()) {
    limit = 1024;
  } else if(isDefined(self.heat)) {
    limit = 4096;
  }

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < limit) {
    exitnode = self.node;
  } else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < limit) {
    exitnode = self.prevnode;
  }

  if(isDefined(self.heat) && !utility::actor_is3d()) {
    if(isDefined(exitnode) && absangleclamp180(self.angles[1] - exitnode.angles[1]) > 30) {
      return undefined;
    }
  }

  return exitnode;
}

function determinestartanim(statename, var_40aacb1b071e0bc0, optionalsuffix) {
  negstartnode = self getnegotiationstartnode();

  if(isDefined(negstartnode)) {
    goalpos = negstartnode.origin;
  } else {
    goalpos = self.pathgoalpos;
  }

  assert(isDefined(goalpos));
  exitnode = getexitnode();

  if(var_40aacb1b071e0bc0) {
    lookaheadpos = self.origin + self.lookaheaddir * self.lookaheaddist;
    nearlookaheadpos = lookaheadpos;
  } else {
    lookaheadpos = self getposonpath(128);
    nearlookaheadpos = self getposonpath(32);
  }

  lookaheadangles = vectortoangles(lookaheadpos - self.origin);
  nearlookaheadangles = vectortoangles(nearlookaheadpos - self.origin);

  if(utility::nodeshouldfaceangles(exitnode) && !var_40aacb1b071e0bc0) {
    currentangles = exitnode.angles;
  } else {
    currentangles = self.angles;
  }

  anglediff = angleclamp180(lookaheadangles[1] - currentangles[1]);
  nearanglediff = angleclamp180(nearlookaheadangles[1] - currentangles[1]);
  var_13c7d8ffb41c7a8e = vectortoangles(self.lookaheaddir);
  var_b81c05b55cd6fc64 = angleclamp180(var_13c7d8ffb41c7a8e[1] - currentangles[1]);

  if(abs(var_b81c05b55cd6fc64) > 135 && abs(anglediff) < 90) {
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

  if(isDefined(self.var_c9829cc678d083b1)) {
    startanim = getstartanim(self.var_c9829cc678d083b1, optionalsuffix, idx, nearanglediff);
  } else {
    startanim = getstartanim(statename, optionalsuffix, idx, nearanglediff);
  }

  if(!isDefined(self.var_c9829cc678d083b1)) {
    exitcover = issubstr(statename, ":\xc9\x93\xe1?");
    animangles = currentangles;

    if(exitcover && isDefined(exitnode)) {
      var_e6830a6a66d17c7e = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
      yawoffset = var_e6830a6a66d17c7e[idx];

      if(issubstr(statename, "=\xff0b") && idx == 4) {
        yawoffset *= -1;
      }

      animangles = (0, angleclamp(exitnode.angles[1] + yawoffset), 0);
    } else {
      var_5a5ee3518be492c7 = [180, -135, -90, -45, 0, 45, 90, 135, 180];
      yawoffset = var_5a5ee3518be492c7[idx];
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
        var_f56ae506f2df9fc5 = math::wrap(-179, 179, angleclamp180(adjustedexitangles[1] - currentangles[1]));
        var_b02702a2dfb5fd5 = getangleindices(var_f56ae506f2df9fc5, 45);
        var_5071c7a950f72a93 = angleclamp180(animangles[1] - currentangles[1]);
        currentexitangles = getangleindices(var_5071c7a950f72a93);
        newindex = var_b02702a2dfb5fd5[0];

        for(i = var_b02702a2dfb5fd5.size - 1; i >= 0; i--) {
          angleindex = var_b02702a2dfb5fd5[i];

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

function movebattlechatter_helper(var_8ce119c843175fed) {
  self endon("\x1e\xfd\xd1\xa2\a");
  waitframe();
  movestartbattlechatter(var_8ce119c843175fed);
}

function function_234235dc4a37a51f(statename) {
  if(getdvarint(@ "hash_79e471363d9c6b91", 0) == 0) {
    return;
  }

  self notify("<dev string:x2e>");
  self endon("<dev string:x43>");
  self endon(statename + "<dev string:x58>");

  while(true) {
    print3d(self.origin + (0, 0, 72), "<dev string:x65>", (1, 0.25, 0.25), 1, 2, 1);
    wait 0.05;
  }
}

function function_5604fd901d361416(suffix, statename, node) {
  if(isDefined(suffix) && suffix != "<dev string:x6a>") {
    thread function_234235dc4a37a51f(statename);
  }

  if(isDefined(node) && node.type != "<dev string:x76>") {
    thread function_234235dc4a37a51f(statename);
  }
}

function playstartanim(asmname, statename, startanim, var_e75f7fda0eea4831) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  lookaheadpos = self getposonpath(128);
  lookaheadangles = vectortoangles(lookaheadpos - self.origin);
  anglediff = angleclamp180(lookaheadangles[1] - self.angles[1]);
  startxanim = asm::asm_getxanim(statename, startanim);
  var_e5893352def4c7ec = getnotetracktimes(startxanim, "f\x97\xb9`\xd1~\x80(\xca");
  cornertimes = getnotetracktimes(startxanim, "\x9f\xd3\xfcWM-");
  warpstarttimes = getnotetracktimes(startxanim, "\x17\x8c(L\xbbW\ro\xfbO[\xb4\x8eB\t");
  var_a662fcabbea06fe7 = getnotetracktimes(startxanim, "\x05\x9b}\xc8\xa2<\xfe\x83\x9c\x17\xb9\xbe\x1f");
  endtimefrac = 1;

  if(var_e5893352def4c7ec.size > 0) {
    self.requestarrivalnotify = 1;
    endtimefrac = var_e5893352def4c7ec[0];
  }

  startanimangles = getangledelta3d(startxanim, 0, endtimefrac);
  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa", 0);
  self setuseanimgoalweight(0.2);
  exitrate = self.moveplaybackrate;

  if(utility::demeanorhasblendspace() && utility::isentasoldier()) {
    exitrate = 1;
  }

  var_cb6aec9a3891c1e7 = getmovedelta(startxanim, 0, endtimefrac);
  var_1d758a00543a799d = length(var_cb6aec9a3891c1e7);
  var_b1db40d80f40113a = self getposonpath(var_1d758a00543a799d);

  if(var_1d758a00543a799d > 1) {
    var_7a618cb5e3e16615 = var_b1db40d80f40113a - self getnavposition();
  } else {
    var_7a618cb5e3e16615 = self getposonpath(12) - self getnavposition();
  }

  var_762067e7a3bb848d = vectortoyaw(var_7a618cb5e3e16615);
  asm::asm_playfacialanim(asmname, statename, startxanim);
  self aisetanim(statename, startanim, exitrate);
  var_5fbbff62308dab10 = 1;
  animdata = spawnStruct();
  animdata.xanim = startxanim;

  if(isDefined(self.asm.customdata.ignoreexitwarp)) {} else if(cornertimes.size > 0) {
    cornertranslation = getmovedelta(startxanim, 0, cornertimes[0]);
    cornerdist = length(cornertranslation);
    cornerposonpath = self getposonpath(cornerdist);
    var_9745088b8a0a6b9a = var_b1db40d80f40113a;

    if(var_1d758a00543a799d - cornerdist < 2) {
      var_9745088b8a0a6b9a = self getposonpath(var_1d758a00543a799d + 6);
    }

    var_54af174356e1505 = var_9745088b8a0a6b9a - cornerposonpath;
    var_7ebf75cdf883a74d = vectortoyaw(var_54af174356e1505);

    if(warpstarttimes.size > 0 && warpstarttimes[0] > 0 && warpstarttimes[0] < cornertimes[0]) {
      animdata.posalongpath = cornerposonpath;
      animdata.anglealongpath = var_7ebf75cdf883a74d;
      animdata.endnote = "\x9f\xd3\xfcWM-";

      if(var_a662fcabbea06fe7.size > 0 && var_a662fcabbea06fe7[0] < cornertimes[0]) {
        animdata.duration = int((var_a662fcabbea06fe7[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000 / exitrate);
      }
    } else {
      utility::motionwarpwithnotetracks(startxanim, cornerposonpath, (0, var_7ebf75cdf883a74d, 0), undefined, "\x9f\xd3\xfcWM-", undefined, 0);
    }
  } else if(warpstarttimes.size == 0 || warpstarttimes[0] == 0) {
    assert(var_e5893352def4c7ec.size > 0, "<dev string:x81>" + getxhashsourcename(getanimname(startxanim)));
    duration = undefined;

    if(warpstarttimes.size > 0 && var_a662fcabbea06fe7.size > 0 && var_a662fcabbea06fe7[0] < var_e5893352def4c7ec[0]) {
      duration = int((var_a662fcabbea06fe7[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000);
    }

    utility::motionwarpwithnotetracks(startxanim, var_b1db40d80f40113a, (0, var_762067e7a3bb848d, 0), undefined, "f\x97\xb9`\xd1~\x80(\xca", duration, 0);
  }

  if(!isDefined(animdata.posalongpath)) {
    animdata.posalongpath = var_b1db40d80f40113a;
    animdata.anglealongpath = var_762067e7a3bb848d;
    animdata.endnote = "f\x97\xb9`\xd1~\x80(\xca";

    if(warpstarttimes.size > 0 && var_a662fcabbea06fe7.size > 0) {
      animdata.duration = int((var_a662fcabbea06fe7[0] - warpstarttimes[0]) * getanimlength(startxanim) * 1000 / exitrate);
    }
  }

  groundent = self getgroundentity();

  if(isDefined(groundent)) {
    animdata = motionwarp_localizedata(animdata, groundent);
  }

  asm::asm_donotetracks(asmname, statename, &handlewarpexitstart, animdata, undefined, !var_e75f7fda0eea4831);
  self motionwarpcancel();

  if(var_e75f7fda0eea4831) {
    self animmode("+0a<s,", 0);
    self orientmode("\xa1\xd7\x97\xd7\xf4h\xe0%\xbe \xa1");
    asm::asm_donotetracks(asmname, statename);
  }
}

function motionwarp_localizedata(animdata, groundent) {
  var_c83bb6a1490541a2 = invertangles(groundent.angles);
  var_2272d5083bf18b3 = animdata.posalongpath - groundent.origin;
  var_4ad57d947d8391a0 = rotatevector(var_2272d5083bf18b3, var_c83bb6a1490541a2);
  animdata.posalongpath = var_4ad57d947d8391a0;
  animdata.anglealongpath = combineangles((0, animdata.anglealongpath, 0), var_c83bb6a1490541a2);
  animdata.groundent = groundent;
  return animdata;
}

function motionwarp_getworldifydata(animdata) {
  posalongpath = undefined;
  anglealongpath = undefined;
  groundent = animdata.groundent;

  if(isDefined(groundent)) {
    var_4ad57d947d8391a0 = animdata.posalongpath;
    var_2272d5083bf18b3 = rotatevector(var_4ad57d947d8391a0, groundent.angles);
    posalongpath = var_2272d5083bf18b3 + groundent.origin;
    angles = combineangles(animdata.anglealongpath, groundent.angles);
    anglealongpath = angles[1];
    return [posalongpath, anglealongpath];
  }

  return [animdata.posalongpath, animdata.anglealongpath];
}

function handlewarpexitstart(note, params) {
  posalongpath = undefined;
  anglealongpath = undefined;

  if(note == "\x17\x8c(L\xbbW\ro\xfbO[\xb4\x8eB\t" && !isDefined(self.asm.customdata.ignoreexitwarp)) {
    assert(isDefined(params) && isstruct(params));
    endnote = params.endnote;

    if(!isDefined(endnote)) {
      endnote = "\x05\x9b}\xc8\xa2<\xfe\x83\x9c\x17\xb9\xbe\x1f";
    }

    duration = undefined;

    if(isDefined(params.duration)) {
      duration = params.duration - params.duration % 50;
    }

    assert(animhasnotetrack(params.xanim, endnote));
    [posalongpath, anglealongpath] = motionwarp_getworldifydata(params);
    utility::motionwarpwithnotetracks(params.xanim, posalongpath, (0, anglealongpath, 0), "\x17\x8c(L\xbbW\ro\xfbO[\xb4\x8eB\t", endnote, duration, 0);
  }
}

function checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos)) {
    asm::debug_arrival("<dev string:xb3>" + self getentitynumber() + "<dev string:xce>");

    return false;
  }

  if(!self.facemotion) {
    asm::debug_arrival("<dev string:xb3>" + self getentitynumber() + "<dev string:xf2>");

    return false;
  }

  if(isDefined(self.disableexits) && self.disableexits) {
    asm::debug_arrival("<dev string:xb3>" + self getentitynumber() + "<dev string:x111>");

    return false;
  }

  if(self.stairsstate != "\r+x5") {
    asm::debug_arrival("<dev string:xb3>" + self getentitynumber() + "<dev string:x131>");

    return false;
  }

  mindist = 100;
  demeanor = asm::asm_getdemeanor();

  if(asm::asm_getdemeanor() == "#yDV,\xd6" || asm::asm_getdemeanor() == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5" || self aigetdesiredspeed() <= 60) {
    mindist = 50;

    if(istrue(self.disablearrivals)) {
      mindist = 25;
    }
  } else if(istrue(self.disablearrivals)) {
    mindist = 50;
  }

  if(self pathdisttogoal() < mindist) {
    asm::debug_arrival("<dev string:xb3>" + self getentitynumber() + "<dev string:x141>");

    return false;
  }

  return true;
}

function chooseanim_runngun(asmname, statename, params) {
  self.runngun = 1;
  assert(isDefined(self.enemy), "<dev string:x159>");
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
    runningfireanim = asm::asm_lookupanimfromalias(statename, "x\x1d\xd0\xbdS\x8eA\xf3\xbb\xcf\x13&>\x94_\xed@\"\x90");
  } else if(faceyawdelta < -100) {
    runningfireanim = asm::asm_lookupanimfromalias(statename, "\xb2\x80\xbb8\x11\xdcTx\xdd\xdf\x88\xb0\xb2.\xd54\xfb\xd2w\xb3");
  } else if(faceyawdelta > 0) {
    runningfireanim = asm::asm_lookupanimfromalias(statename, "\xa5\x8c\xa0\xec|\x96\xeb\xaaj\x80fe\xedv\xc0d5\x9c\r");
  } else {
    runningfireanim = asm::asm_lookupanimfromalias(statename, "\bO\xf6~My_\xc5@\xb9S\x87\x814O\xb0X\x9f\x98S");
  }

  self.var_998e131a705c01a2 = 1;
  self.var_526b6d7c80f6bbb3 = 0;
  self function_49c18f2181d12acd();
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

  if(self getreacquirestate() == "\xfaBL\xa7\x85\xcb@") {
    return false;
  }

  if(isonanystairs()) {
    return false;
  }

  stairsenterdist = self getstairsenterdist();
  var_4014ee22c6ac8efd = self getstairsstateatdist(stairsenterdist);

  if(var_4014ee22c6ac8efd != "\r+x5") {
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

  var_57bd408645004b25 = self asmeventfiredwithin(asmname, "\xdc\xa1\v\x93\x1c\xf5Gu\x9c\xb9", 50);

  if(var_57bd408645004b25) {
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
    if(var_57bd408645004b25 || self pathdisttogoal() < 64) {
      return false;
    }

    faceyawdelta = angleclamp180(pathyaw - self.desiredangle);
  }

  if(abs(angleclamp180(headingyawdelta - faceyawdelta)) < 45) {
    return false;
  }

  curdir = asm::yawdiffto2468(headingyawdelta);
  desireddir = asm::yawdiffto2468(faceyawdelta);

  if(curdir == desireddir) {
    return false;
  }

  speedstring = "\x8f\x8f\x0e\x12";

  if(utility::isentasoldier() && utility::demeanorhasblendspace()) {
    archetype = self getbasearchetype();
    speedstring = getnearestspeedthresholdname(archetype, targetspeed);

    if(speedstring == "U%\xce@\x9f\xdeU" || speedstring == "\x82}\xeb\x93") {
      speedstring = "\x82}\xeb\x93";
    } else if(speedstring != "\x8f\x8f\x0e\x12") {
      speedstring = "\x8f\x8f\x0e\x12";
    }

    self.strafepoispeedtarget = getanimspeedthreshold(archetype, speedstring);
  } else {
    self.strafepoispeedtarget = undefined;
  }

  alias = speedstring + "w" + self.asm.strafe_foot + "w" + curdir + "\n\xd9o\xf8" + desireddir;

  if(!asm::asm_hasalias(tostatename, alias)) {
    if(curdir == "P" || curdir == "\xbb") {
      alias = speedstring + "\xa9\"s\x8f\xbc$vo\x7fuw\xac\x8d=T" + curdir + "\n\xd9o\xf8" + desireddir;
    } else {
      alias = speedstring + "~\x91\xc6\xd7\xc5Dy\xb8\x1c\x16}4\xf2)\x92#" + curdir + "\n\xd9o\xf8" + desireddir;
    }

    if(!asm::asm_hasalias(tostatename, alias)) {
      return false;
    }
  }

  self.asm.strafeaimchangealias = alias;
  return true;
}

function shouldrestartaimchange(asmname, statename, tostatename, params) {
  if(asm::asm_eventfired(asmname, "f\x97\xb9`\xd1~\x80(\xca") && shouldstrafeaimchange(asmname, statename, tostatename, params)) {
    return true;
  }

  return false;
}

function aimchangeorientation(turnxanim, rate, endtime, faceyawtarget, totalanimlength) {
  self endon("\xce\xe1\x06\xd9\"n?\xfa\xf2\a\xbd4\xbc\xc8>\xd1T\x11.w\xca");
  self.aimchange_oldturnrate = self.turnrate;
  totalangledelta = getangledelta(turnxanim, 0, endtime);
  yawtotarget = faceyawtarget - self.angles[1];
  yawtotarget = angleclamp180(yawtotarget);
  totalyawfixup = angleclamp180(yawtotarget - totalangledelta);
  animyawremaining = totalangledelta;

  while(isDefined(self) && isalive(self)) {
    currentanimtime = self aigetanimtime(turnxanim);
    nextanimtime = min(currentanimtime + level.frameduration / 1000 / totalanimlength * rate, 1);
    var_d2ef98416fc547f1 = getangledelta(turnxanim, currentanimtime, nextanimtime);

    if((animyawremaining - var_d2ef98416fc547f1) * animyawremaining > 0) {
      animyawremaining -= var_d2ef98416fc547f1;
    } else {
      var_d2ef98416fc547f1 = animyawremaining;
      animyawremaining = 0;
    }

    lerpfraction = var_d2ef98416fc547f1 / totalangledelta;
    var_911ea5c43ac05856 = totalyawfixup * lerpfraction;
    rotatethisframe = var_d2ef98416fc547f1 + var_911ea5c43ac05856;
    faceangle = angleclamp(self.angles[1] + rotatethisframe);
    var_dd7adabc81d328c8 = angleclamp(self.angles[1] + clamp(rotatethisframe * 3, -179, 179.9));
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", var_dd7adabc81d328c8);

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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animindex = asm::asm_getanim(asmname, statename);
  turnxanim = asm::asm_getxanim(statename, animindex);
  self.asm.strafeaimchangealias = undefined;
  self.sharpturnforceusevelocity = 1;
  rate = 1;
  exitspeed = undefined;

  if(isDefined(self.strafepoispeedtarget) && utility::isentasoldier() && utility::demeanorhasblendspace()) {
    targetspeed = self aigettargetspeed();
    rate = targetspeed / self.strafepoispeedtarget;
    exitspeed = targetspeed;
    rate = clamp(rate, 0.6, 1.4);
  }

  self aisetanim(statename, animindex, rate);
  asm::asm_playfacialanim(asmname, statename, turnxanim);
  codemovetimes = getnotetracktimes(turnxanim, "f\x97\xb9`\xd1~\x80(\xca");
  finishnotes = getnotetracktimes(turnxanim, "\xd7\xca\xae\xca\xff\xdb");
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
  note = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  self notify("\xce\xe1\x06\xd9\"n?\xfa\xf2\a\xbd4\xbc\xc8>\xd1T\x11.w\xca");

  if(isDefined(self.aimchange_oldturnrate)) {
    if(self.aimchange_oldturnrate > 0) {
      self.turnrate = self.aimchange_oldturnrate;
    }

    self.aimchange_oldturnrate = undefined;
  }

  if(note == "f\x97\xb9`\xd1~\x80(\xca") {
    if(isDefined(facetargetpos)) {
      self orientmode("\xfc\x9f\\\x9e\x16\xbc\xbe\xca\xed\x12", facetargetpos);
    } else {
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", faceyawtarget);
    }

    self animmode("+0a<s,");
    asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  }

  if(isDefined(exitspeed)) {
    self aisettargetspeed(exitspeed);
  }
}

function chooseanim_strafeaimchange(asmname, statename, params) {
  assert(isDefined(self.asm.strafeaimchangealias));
  return asm::asm_lookupanimfromalias(statename, self.asm.strafeaimchangealias);
}

function strafeaimchange_cleanup(asmname, statename, params) {
  self notify("\xce\xe1\x06\xd9\"n?\xfa\xf2\a\xbd4\xbc\xc8>\xd1T\x11.w\xca");

  if(isDefined(self.aimchange_oldturnrate)) {
    self.turnrate = self.aimchange_oldturnrate;
    self.aimchange_oldturnrate = undefined;
  }

  self.sharpturnforceusevelocity = 0;
}

function handlestrafenotetracks(note) {
  switch (note) {
    case #"hash_e13cf484a444d070":
      self.asm.strafe_foot = "\xdf\xe9h4\xc9\r\xef\xb7\xb7\xf1;R\x8a";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_622de61830d10b28":
      self.asm.strafe_foot = "\xfb\x03\xde\xa1\x96\xff/%)\xb6";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_725f3a6c07952190":
      self.asm.strafe_foot = "\xe4\x1a\xdf\xc1\x1e\x01\x91Tf \xd7t\xc4O";
      self.asm.strafe_foot_time = gettime();
      break;
    case #"hash_e81afc35eec1256e":
      self.asm.strafe_foot = "Tjh\xec\xe9\xb7\x99v\xffl\aR\"\x9c";
      self.asm.strafe_foot_time = gettime();
      break;
  }
}

function playanim_strafereverse(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  zonlytime = 0.4;
  blankanimid = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, blankanimid);
  self orientmode("\x15]\x19\x90}\xcb\xb6\b*N4Y\x85\x0f\x13\x141\xe2\xe7\xa7");
  self setstrafereverse(1);
  endnote = asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);

  if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
    self animmode("+0a<s,");
    endnote = asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);
  }

  asm::asm_fireevent(asmname, "8\xdb\x90");
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
  moveanims[0] = asm::asm_lookupanimfromalias(statename, "\xfe");
  moveanims[1] = asm::asm_lookupanimfromalias(statename, "\x87");
  moveanims[2] = asm::asm_lookupanimfromalias(statename, "\x19");
  animstruct.anims = moveanims;
  animstruct.forwardanim = asm::asm_lookupanimfromalias(statename, "\xa17\xd3\x9fT\x14P");
  return animstruct;
}

function shouldwalkandtalk() {
  return asm_bb::bb_moverequested() && isDefined(self._blackboard.walk_and_talk_requested) && self._blackboard.walk_and_talk_requested;
}

function walkandtalkdonotetracks(asmname, statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    asm::asm_donotetracks(asmname, statename);
  }
}

function movewalkandtalk(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self.requestarrivalnotify = 1;
  rate = asm::asm_getmoveplaybackrate();
  asm::asm_updatefrantic();
  self codemoveanimrate(rate);
  asm::asm_updatefrantic();
  animstruct = asm::asm_getanim(asmname, statename);
  anims = animstruct.anims;
  forwardanim = animstruct.forwardanim;
  self aiclearanim(asm::asm_getbodyknob(), 0.2);
  self setflaggedanim(statename, forwardanim, 1, 0.2, 1);
  thread walkandtalkdonotetracks(asmname, statename);
  lastangle = 0;
  blendframes = 20;

  while(true) {
    arrival = asm::asm_eventfired(asmname, "\x1b\xb7\xd9+\x9c\xbe\xb0\x1c\a'\xbd\vcC");
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
      var_a2a8fd064011a6e8 = lastangle;
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
          var_a2a8fd064011a6e8 = newactualangle + lastangle;
          index = 1;
          lastangle = var_a2a8fd064011a6e8;
        }

        i = index / blendframes;
        result = i * i * (3 - 2 * i);
        transitiondegree = anglediff - var_a2a8fd064011a6e8;
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

    if(self.walk_and_talk_hemisphere == "o0\xee\xc1\x8c") {
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
  var_cf168c9a9fea1921 = (yaw - anglearray[last_index]) / (anglearray[next_index] - anglearray[last_index]);
  var_565b8877517d12aa = 1 - var_cf168c9a9fea1921;
  animweights[last_index] = var_565b8877517d12aa;
  animweights[next_index] = var_cf168c9a9fea1921;
  animweights[1] = max(0.01, animweights[1]);
  return animweights;
}

function movestartbattlechatter(var_8ce119c843175fed) {
  movetype = asm::asm_getdemeanor();

  if(movetype == "]\"\x81\x02y\xf7\xa4" || movetype == "\xe3\xd0\xc3e\x85h" || movetype == "\x05\xb1\x1c\x86\x11\xc7") {
    function_99e8e66d1969d7cb(self, undefined, "\x80[\xb3\x9d", var_8ce119c843175fed);
  }
}

function shouldreloadwhilemoving(asmname, statename, tostatename, params) {
  if(!asm_bb::bb_reloadrequested()) {
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
  alias = "\xc9\xca\x1boX\x8c";
  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    alias = "\xff\xf1\xad(\x13\xa0O]\x8d";
  }

  return asm::asm_lookupanimfromalias(statename, alias);
}

function playreloadwhilemoving(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self.requestarrivalnotify = 1;
  reloadanim = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, reloadanim);
  asm::asm_playfacialanim(asmname, statename, asm::asm_getxanim(statename, reloadanim));
  asm::asm_donotetracks(asmname, statename);
}

function terminatereloadwhilemoving(asmname, statename, params) {
  if(!asm::asm_eventfired(asmname, "\xc9\xca\x1boX\x8c\x10\xc8on\xca")) {
    weaponlist::refillclip();
  }

  namespace_ad29b7c653247c74::reload_cleanup(asmname, statename, params);
}

function isonanystairs() {
  return isDefined(self.pathgoalpos) && self.stairsstate != "\r+x5";
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

  if(self.asm.footsteps.foot == "=\xff0b") {
    alias = "o0\xee\xc1\x8c";
  } else {
    alias = "=\xff0b";
  }

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    altalias = "\x15'\xa3" + alias;

    if(asm::asm_hasalias(statename, altalias)) {
      alias = altalias;
    }
  }

  stairsanim = asm::asm_lookupanimfromalias(statename, alias);
  return stairsanim;
}

function chooseanim_stairs_rise_run(asmname, statename, params) {
  alias = "\xef\xa8\vj";
  angle = getgroundangle();

  if(angle < 27.75) {
    alias = "\xa7\xb1\xf3\xbf";
  }

  if(angle >= 27.75 && angle < 36.2) {
    alias = "w\xd9\x87\x86";
  }

  if(angle >= 36.2 && angle < 41.85) {
    alias = "\xef\xa8\vj";
  }

  if(angle >= 41.85) {
    alias = "\xad\x1bz";
  }

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    altalias = "\x15'\xa3" + alias;

    if(asm::asm_hasalias(statename, altalias)) {
      alias = altalias;
    }
  }

  stairsanim = asm::asm_lookupanimfromalias(statename, alias);
  return stairsanim;
}

function stumblechooseanim(asmname, statename, params) {
  archetype = self getbasearchetype();
  runthreshold = getanimspeedthreshold(archetype, "\x14+`");
  sprintthreshold = getanimspeedthreshold(archetype, "\x05\xb1\x1c\x86\x11\xc7");
  speed = length(self.velocity);
  alias = "\t\xf4\xaft\xc2\xf6\xa9F1\xe8`";

  if(isDefined(sprintthreshold) && speed > sprintthreshold) {
    alias = "|M\xcd\xda\xe1\x0e\xef\xe7\xef\xc7\x10 \xd1a";
  }

  if(isDefined(runthreshold) && speed > runthreshold) {
    alias = "7\xbeU\xaa>E1\x93\x9e\x10|";
  }

  return asm::asm_chooseanim(asmname, statename, alias);
}

function playanim_stumble(asmname, statename, params) {
  self.requestarrivalnotify = 1;
  self.var_998e131a705c01a2 = 1;
  self.var_526b6d7c80f6bbb3 = 0;
  asm::asm_playanimstate(asmname, statename, params);
}