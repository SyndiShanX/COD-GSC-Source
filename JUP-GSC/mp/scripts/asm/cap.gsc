/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\cap.gsc
***********************************************/

#using script_147448f3f080c636;
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cap;

function function_11bc1c4cee238a68(asmname, statename, params) {
  uselr = 0;
  aliasprefix = "";

  if(isDefined(params)) {
    if(!isarray(params)) {
      aliasprefix = params;
    } else {
      aliasprefix = params[0];
      uselr = params[1];
    }
  }

  warptarget = self function_e430df0f7376ec66();
  targetangles = self.angles;

  if(isDefined(warptarget)) {
    targetpos = warptarget.origin;
    movedirnormalized = vectorNormalize(targetpos - self.origin);
    targetangles = vectortoangles(movedirnormalized);
  }

  targetyaw = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(targetyaw);

  if(uselr && angleindex == "2") {
    if(targetyaw < 0) {
      angleindex = "2l";
    } else {
      angleindex = "2r";
    }
  }

  aliasname = aliasprefix + angleindex;
  turnanim = cap_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

function function_64d568ec73ec23f9(asmname, statename, params) {
  self.lasttimepushed = gettime();
  self.attitude = "curious";
  namespace_2b520709cc9e7442::function_fff7117076af2d16(self, level.var_9958731831312749.var_30f007ac9a8e642e, "curious", 0, 1);
  cap_playanim(asmname, statename, params);
}

function function_286c69ed2c750e6c(asmname, sourceciv) {
  self endon("death");
  player = namespace_2b520709cc9e7442::getclosestplayer(sourceciv.origin);

  if(!isDefined(player)) {
    return;
  }

  movedirnormalized = vectorNormalize(sourceciv.origin - player.origin);
  sourcecivorigin = sourceciv.origin;
  wait 0.5;

  foreach(otherciv in level.civreactdata.civs) {
    if(!isalive(otherciv) || otherciv == sourceciv) {
      continue;
    }

    if(isDefined(otherciv.capgroup) && isDefined(sourceciv.gapgroup)) {
      if(level.capgroups[otherciv.gapgroup] == level.capgroups[sourceciv.capgroup]) {
        continue;
      }
    }

    tootherciv = otherciv.origin - sourcecivorigin;
    var_691f481a8bba4062 = lengthsquared(tootherciv);
    maxdistance = 80;

    if(var_691f481a8bba4062 > maxdistance * maxdistance) {
      continue;
    }

    var_332ea4b12d924c65 = vectorNormalize(tootherciv);
    dot = vectordot(var_332ea4b12d924c65, movedirnormalized);

    if(dot > 0.96) {
      otherciv asm_fireevent(asmname, "player_pushed");
    }
  }
}

function function_c72398c24fe24b5b(asmname, statename, params) {
  thread function_286c69ed2c750e6c(asmname, self);
  self.lasttimepushed = gettime();
  self.attitude = "angered";
  cap_playanim(asmname, statename, params);
}

function function_f16999f33ef5381d(statename) {
  self notify("lerp_arrive_finished");
  self endon("death");
  self endon("lerp_arrive_finished");
  alpha = 0;
  startorigin = self.origin;
  startangles = self.angles;
  targetpos = getclosestpointonnavmesh(self.origin, self);
  xanim = animsetgetanimfromindex(self.animsetname, statename, self.capanimid);
  animend = getoriginforanimtime(self.origin, self.angles, xanim, 1);
  animlength = getanimlength(xanim);
  starttime = gettime();

  if(ispointonnavmesh(animend)) {
    self notify("lerp_arrive_finished");
    return;
  }

  while(alpha < animlength) {
    waitframe();
    alpha = (gettime() - starttime) / 1000;
    newpos = vectorlerp(self.origin, targetpos, alpha);
    self forceteleport(newpos, startangles);
  }

  self notify("lerp_arrive_finished");
}

function cap_playanim(asmname, statename, params) {
  self.capanimid = asm_getanim(asmname, statename);
  function_fb8afeabd23a5ef5(asmname, statename, params, self.capanimid);
}

function function_fb8afeabd23a5ef5(asmname, statename, params, animid) {
  self endon(statename + "_finished");
  xanim = asm_getxanim(statename, animid);
  function_38adb9f7ae99df6a(statename, xanim);

  if(isai(self)) {
    self aisetanim(statename, animid);
  } else {
    bodyanimid = asm_lookupanimfromalias("knobs", "body");
    bodyxanim = asm_getxanim("knobs", bodyanimid);
    self setflaggedanimknoballrestart(statename, xanim, bodyxanim, 1, 0.2, 1);
    self setanim(bodyxanim, 1, 0.2);

    if(statename == "relaxed" || statename == "single_loop" || statename == "group_loop") {
      function_46602711ed8e40d6();
    } else if(isDefined(params) && isarray(params) && params.size == 2) {
      proceduralturn = params[1];

      if(proceduralturn) {
        childthread cap_proceduralturn();
      }
    }
  }

  function_7d6e619c3450bef3(statename, xanim);
  cap_propanim(asmname, statename, params);
  asm_playfacialanim(asmname, statename, xanim);
  cap_donotetracks(asmname, statename);
}

function function_e7652690c4fbe131(asmname, statename, params) {
  cap_playanim(asmname, statename, params);

  if(isDefined(self.node)) {
    self.keepclaimednodeifvalid = 1;
  }
}

function function_ae21268aec38d315(asmname, statename, params) {
  self.keepclaimednodeifvalid = 0;
}

function function_38adb9f7ae99df6a(statename, xanim, animtime) {
  if(isDefined(self.relativestates) && array_contains(self.relativestates, statename)) {
    return;
  }

  scriptednode = function_76b0413f0e5d4dd2();

  if(!isDefined(scriptednode)) {
    return;
  }

  if(!isDefined(animtime)) {
    animtime = 0;
  }

  origin = scriptednode.origin;
  angles = default_to(scriptednode.angles, (0, 0, 0));
  startorg = getoriginforanimtime(origin, angles, xanim, animtime);
  startangles = getanglesforanimtime(origin, angles, xanim, animtime);

  if(isai(self)) {
    self forceteleport(startorg, startangles, 9999);
    return;
  }

  self.origin = startorg;
  self.angles = startangles;
}

function function_76b0413f0e5d4dd2() {
  if(isDefined(self.scriptednodebypass)) {
    return undefined;
  }

  if(isDefined(self.scriptednode)) {
    return self.scriptednode;
  }

  if(isDefined(self.animnode)) {
    return self.animnode;
  }

  if(isDefined(self.scripted_animnode)) {
    return self.scripted_animnode;
  }

  if(isDefined(self.var_98b372c0f9b463ba)) {
    return self.var_98b372c0f9b463ba;
  }

  return undefined;
}

function function_7d6e619c3450bef3(statename, xanim) {
  if(!isDefined(self.resumestatetime) || !array_contains_key(self.resumestatetime, statename)) {
    return;
  }

  var_dcf5e86549620338 = self;

  if(isDefined(self.var_dcf5e86549620338)) {
    var_dcf5e86549620338 = self.var_dcf5e86549620338;
  }

  resumetime = var_dcf5e86549620338.resumestatetime[statename];
  assert(isDefined(resumetime), "<dev string:x1c>" + statename + "<dev string:x48>");
  function_38adb9f7ae99df6a(statename, xanim, resumetime);
  self setanimtime(xanim, resumetime);
  thread function_c886dae06eba7d4a(statename, xanim);
}

function function_c886dae06eba7d4a(statename, xanim) {
  self endon(statename + "_finished");

  while(true) {
    self.resumestatetime[statename] = self getanimtime(xanim);
    waitframe();
  }
}

function cap_proceduralturn() {
  while(true) {
    player = namespace_2b520709cc9e7442::getclosestplayer(self.origin);

    if(!isDefined(player)) {
      waitframe();
      continue;
    }

    target = player;

    if(isalive(self._blackboard.var_610cb18ecc1af719)) {
      enemy = self._blackboard.var_610cb18ecc1af719;
    }

    totarget = target.origin - self.origin;
    distsqrtotarget = lengthsquared(totarget);
    anglediff = angleclamp180(vectortoyaw(totarget) - self.angles[1]);
    var_706fe99ce1efa2b7 = [[300, 180], [0, 10]];
    angletouse = 0;

    foreach(pair in var_706fe99ce1efa2b7) {
      distancesqr = pair[0] * pair[0];

      if(distsqrtotarget > distancesqr) {
        angletouse = pair[1];
        break;
      }
    }

    shouldrotate = abs(anglediff) > angletouse;

    if(shouldrotate) {
      rotationspeed = 25;
      duration = abs(anglediff) / rotationspeed * 1000;
      remainingframes = int(ceil(duration / level.frameduration));

      while(remainingframes > 0) {
        anglediff = angleclamp180(vectortoyaw(target.origin - self.origin) - self.angles[1]);
        lerpfraction = 1 / remainingframes;
        remainingyaw = anglediff;
        yaw = angleclamp(self.angles[1] + remainingyaw * lerpfraction);
        self.angles = (0, yaw, 0);
        remainingframes--;
        waitframe();
      }
    }

    waitframe();
  }
}

function function_46602711ed8e40d6() {
  rotationspeed = 70;

  while(true) {
    origin = self.caporigin + anglesToForward(self.capangles) * 50;

    if(isalive(self._blackboard.var_610cb18ecc1af719)) {
      enemy = self._blackboard.var_610cb18ecc1af719;
    }

    totarget = origin - self.origin;
    distsqrtotarget = lengthsquared(totarget);
    anglediff = angleclamp180(vectortoyaw(totarget) - self.angles[1]);
    var_706fe99ce1efa2b7 = [[300, 180], [0, 10]];
    angletouse = 0;

    foreach(pair in var_706fe99ce1efa2b7) {
      distancesqr = pair[0] * pair[0];

      if(distsqrtotarget > distancesqr) {
        angletouse = pair[1];
        break;
      }
    }

    shouldrotate = abs(anglediff) > angletouse;

    if(shouldrotate) {
      duration = abs(anglediff) / rotationspeed * 1000;
      remainingframes = int(ceil(duration / level.frameduration));

      while(remainingframes > 0) {
        anglediff = angleclamp180(vectortoyaw(origin - self.origin) - self.angles[1]);
        lerpfraction = 1 / remainingframes;
        remainingyaw = anglediff;
        yaw = angleclamp(self.angles[1] + remainingyaw * lerpfraction);
        self.angles = (0, yaw, 0);
        remainingframes--;
        waitframe();
      }
    }

    waitframe();
  }
}

function function_2944e6470a84b96d(xanim, tracktime) {}

function function_f9d6133768491200(xanim, tracktime) {}

function function_7495a975f79b957(player) {}

function cap_loopanim(asmname, statename, params) {
  self endon(statename + "_finished");

  while(true) {
    animid = asm_getanim(asmname, statename);
    xanim = asm_getxanim(statename, animid);
    function_38adb9f7ae99df6a(statename, xanim);

    if(isai(self)) {
      self aisetanim(statename, animid);
      asm_playfacialanim(asmname, statename, xanim);
    } else {
      bodyanimid = asm_lookupanimfromalias("knobs", "body");
      bodyxanim = asm_getxanim("knobs", bodyanimid);
      self setflaggedanimknoballrestart(statename, xanim, bodyxanim, 1, 0.2, 1);
    }

    cap_propanim(asmname, statename, params);
    cap_donotetracks(asmname, statename);
  }
}

function cap_donotetracks(asmname, statename) {
  notehandler = asm_getnotehandler(asmname, statename);

  for(endnote = undefined; !isDefined(endnote) || !isstring(endnote) || endnote != "end"; endnote = asm_donotetracks(asmname, statename, notehandler)) {}

  return endnote;
}

function cap_notetrackhandler(notetrack) {
  scripts\anim\notetracks::notetrack_prefix_handler(notetrack);
  return undefined;
}

function cap_chooseanim(asmname, statename, params) {
  if(!isDefined(params)) {
    randomalias = cap_lookuprandomalias(statename);
    return cap_lookupanimfromalias(statename, randomalias);
  }

  result = undefined;
  prefixstr = bb_getprefixstring(params);

  if(isDefined(prefixstr)) {
    randomalias = cap_lookuprandomalias(statename, prefixstr);
    result = cap_lookupanimfromalias(statename, randomalias);
  } else {
    result = cap_lookupanimfromalias(statename, params);
  }

  return result;
}

function cap_hasalias(statename, alias) {
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);
  return isDefined(animresult);
}

function function_b6050fd3b28e7aef(asmname, statename, params) {
  neardistthreshold = 450;
  neardistthresholdsqr = neardistthreshold * neardistthreshold;
  player = namespace_2b520709cc9e7442::getclosestplayer(self.origin);

  if(!isDefined(player)) {
    distancealias = "far";

    if(cap_hasalias(statename, distancealias)) {
      result = cap_lookupanimfromalias(statename, distancealias);
      return result;
    }

    randomalias = cap_lookuprandomalias(statename);
    return cap_lookupanimfromalias(statename, randomalias);
  }

  distsqr = distancesquared(self.origin, player.origin);
  distancealias = undefined;

  if(distsqr < neardistthresholdsqr) {
    contents = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
    excludelist = [player, self];
    origin = self.origin + (0, 0, 30);
    end = player.origin + (0, 0, 30);

    if(isai(self)) {
      hitresult = physics_charactercast(origin, end, self, 30, self.angles, contents, excludelist, "physicsquery_closest");

      if(hitresult.size) {
        distancealias = "far";
      } else {
        distancealias = "near";
      }
    } else {
      distancealias = "near";
    }
  } else {
    distancealias = "far";
  }

  if(cap_hasalias(statename, distancealias)) {
    result = cap_lookupanimfromalias(statename, distancealias);
    return result;
  }

  randomalias = cap_lookuprandomalias(statename);
  return cap_lookupanimfromalias(statename, randomalias);
}

function function_7c6b7c2cd3357729(asmname, statename, params) {
  if(!isDefined(params)) {
    randomalias = cap_lookuprandomalias(statename);
    return function_658df657ca37f542(statename, randomalias);
  }

  result = undefined;
  prefixstr = bb_getprefixstring(params);

  if(isDefined(prefixstr)) {
    randomalias = cap_lookuprandomalias(statename, prefixstr);
    result = function_658df657ca37f542(statename, randomalias);
  } else {
    result = function_658df657ca37f542(statename, params);
  }

  return result;
}

function cap_lookupanimfromalias(statename, alias) {
  arcname = self.animsetname;
  assertex(isDefined(arcname), "<dev string:x6f>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  assertex(isDefined(animresult), "<dev string:x96>" + alias + "<dev string:xaf>" + arcname + "<dev string:xc1>" + statename + "<dev string:xcc>" + self.classname);
  return animresult;
}

function function_658df657ca37f542(statename, alias) {
  arcname = self.animsetname;

  if(!isDefined(self.var_30452ad282afcd76)) {
    self.var_30452ad282afcd76 = [];
  }

  if(!isDefined(self.var_30452ad282afcd76[statename])) {
    self.var_30452ad282afcd76[statename] = [];
  }

  if(!isDefined(self.var_30452ad282afcd76[statename][alias])) {
    self.var_30452ad282afcd76[statename][alias] = 0;
  }

  animindices = animsetgetallanimindicesforalias(arcname, statename, alias);
  animresult = animindices[self.var_30452ad282afcd76[statename][alias]];
  self.var_30452ad282afcd76[statename][alias]++;

  if(self.var_30452ad282afcd76[statename][alias] >= animindices.size) {
    self.var_30452ad282afcd76[statename][alias] = 0;
  }

  return animresult;
}

function cap_lookuprandomalias(statename, optionalprefix, allownone) {
  archetype = self.animsetname;
  aliases = archetypegetaliases(archetype, statename);
  possible = 0;
  chosen = undefined;
  prefixlen = -1;

  if(isDefined(optionalprefix)) {
    prefixlen = optionalprefix.size;
  }

  if(!isDefined(aliases)) {
    if(!istrue(allownone)) {
      msg = "<dev string:xd5>" + statename + "<dev string:xaf>" + archetype;

      if(isDefined(optionalprefix)) {
        msg += "<dev string:xfd>" + optionalprefix;
      }

      assertmsg(msg);
    }

    return undefined;
  }

  foreach(aliasname in aliases) {
    if(prefixlen < 0 || getsubstr(aliasname, 0, prefixlen) == optionalprefix) {
      possible += 1;
      chance = 1 / possible;

      if(randomfloat(1) <= chance) {
        chosen = aliasname;
      }
    }
  }

  if(!istrue(allownone) && !isDefined(chosen)) {
    msg = "<dev string:xd5>" + statename + "<dev string:xaf>" + archetype;

    if(isDefined(optionalprefix)) {
      msg += "<dev string:xfd>" + optionalprefix;
    }

    assertmsg(msg);
  }

  return chosen;
}

function cap_event(asmname, statename, tostatename, params) {
  return false;
}

function function_2d6b1385ffc3f5ca(asmname, statename, tostatename, params) {
  return false;
}

function function_85eca0a1310a70c(asmname, statename, tostatename, params) {
  if(isai(self)) {
    return self codemoverequested();
  }

  return 0;
}

function function_304541cf33d2193c(asmname, statename, params) {
  if(isDefined(params)) {
    assert(!isarray(params));

    if(self.unittype == "civilian") {
      bb_setcivilianstate(params);
    } else {
      if(self.unittype == "soldier" && params == "panic") {
        params = "combat";
      }

      if(self.unittype == "soldier" && params == "casual") {
        params = "patrol";
      }

      utility::demeanor_override(params);
    }
  }

  self._blackboard.var_9fbdce5fa10f8964 = 1;
}

function cap_propanim(asmname, statename, params) {
  if(!isDefined(self.animprops)) {
    return;
  }

  foreach(prop in self.animprops) {
    if(isDefined(params)) {
      aliasname = params;
    } else {
      aliasname = undefined;
      aliasnames = archetypegetaliases(prop.animsetname, statename);

      if(isDefined(aliasnames)) {
        aliasname = random(aliasnames);
      }
    }

    if(!isDefined(aliasname)) {
      continue;
    }

    alias = archetypegetalias(prop.animsetname, statename, aliasname, 0);

    if(!isDefined(alias)) {
      continue;
    }

    propxanim = alias.anims;

    if(isarray(propxanim)) {
      propxanim = random(propxanim);
    }

    scriptednode = function_76b0413f0e5d4dd2();
    assert(isDefined(scriptednode), "<dev string:x10e>");
    origin = scriptednode.origin;
    angles = default_to(scriptednode.angles, (0, 0, 0));
    prop animScripted(aliasname, origin, angles, propxanim);
  }
}

function cap_exit(asmname, statename, params) {
  if(!isalive(self)) {
    return;
  }

  scripts\common\cap::cap_exit();
}

function cap_exit_long_death_death(asmname, statename, params) {
  scripts\common\cap::cap_exit();
  asm_setstate("long_death_death");
}

function function_c348991ddd3c9ce5(asmname, statename, params) {
  scripts\common\cap::cap_exit();
  asm_setstate("death_generic");
}

function function_db8201ba3a4a894d(asmname, statename, params) {
  scripts\common\cap::cap_exit();

  if(self.currentpose == "crouch") {
    asm_setstate("pain_crouch");
    return;
  }

  asm_setstate("pain_stand");
}

function function_71fe3f0b4ea06ff1(asmname, statename, params) {
  scripts\common\cap::cap_exit();
  cache = self.forcelongdeathskipintroanim;
  self.forcelongdeathskipintroanim = 1;
  asm_setstate("choose_long_death");
  self.forcelongdeathskipintroanim = cache;
}

function cap_donothing(asmname, statename, params) {}

function cap_init(asmname, fromstate, tostate, params) {
  self.attitude = "relaxed";
}

function cap_attitude(asmname, fromstate, tostate, params) {
  assert(isDefined(params) && !isarray(params));
  return isDefined(self.attitude) && self.attitude == params;
}

function cap_shouldreact(asmname, statename, tostatename, params) {
  return self.attitude != "relaxed";
}

function function_e44a6892e1d2ec(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_2be091d2ce1d5a7d":
      return 1;
    default:
      return 0;
  }
}

function function_11df7068a03bb818(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_dd76edf4ebd198bd":
    case #"hash_f140fd4db5ed4df1":
      return 1;
    default:
      return 0;
  }
}

function function_9cfcf25e2674ea46(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_6da61cb2c6d68687":
    case #"hash_ea9150ecc8538d74":
      return 1;
    default:
      return 0;
  }
}

function function_fbaf3f50df29a0ca(asmname, statename, tostatename, params) {
  assert(isDefined(params), "<dev string:x14c>");

  if(!flag_exist(params)) {
    return 0;
  }

  return flag(params);
}

function function_84e2d261814f426(asmname, statename, tostatename, params) {
  assert(isDefined(params) && isnumber(params), "<dev string:x190>");

  foreach(player in level.players) {
    if(distancesquared(self.origin, player.origin) <= params * params) {
      return true;
    }
  }

  return false;
}

function function_d87741ac656cc282(asmname, statename, tostatename, params) {
  return function_9f458b5f165cfd34(params, 1);
}

function function_cd7b18478f9925a2(asmname, statename, tostatename, params) {
  return function_9f458b5f165cfd34(params, 0);
}

function private function_9f458b5f165cfd34(params, dosighttrace) {
  if(isai(self)) {
    lookatorigin = self getEye();
  } else {
    lookatorigin = self.origin;
  }

  if(isDefined(params)) {
    if(abs(params) > 1) {
      fov = cos(params);
    } else {
      fov = params;
    }
  } else {
    fov = 0.77;
  }

  foreach(player in level.players) {
    playerorigin = player getEye();
    playerangles = player getgunangles();

    if(within_fov(playerorigin, playerangles, lookatorigin, fov)) {
      if(!dosighttrace || sighttracepassed(playerorigin, lookatorigin, 0, self)) {
        return true;
      }
    }
  }

  return false;
}

function cap_isidling(asmname, statename, tostatename, params) {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthidle]]();
}

function cap_isinvestigating(asmname, statename, tostatename, params) {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthinvestigate]]();
}

function cap_ishunting(asmname, statename, tostatename, params) {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthhunt]]();
}

function cap_iscombating(asmname, statename, tostatename, params) {
  if(!isDefined(self.stealth)) {
    return 1;
  }

  return self[[self.fnisinstealthcombat]]();
}

function function_276b2832ae7c7cf7(asmname, statename, tostatename, params) {
  assert(isDefined(params), "<dev string:x1e0>");
  return self findoverridearchetype("default") == params;
}

function function_8439b78c94685919(asmname, statename, tostatename, params) {
  if(istrue(self.var_36023fdce648d2ea)) {
    return false;
  }

  if(istrue(self.interactionholdingpattern)) {
    return false;
  }

  if(isDefined(self._blackboard.idlenode) && isDefined(self._blackboard.idlenode.repeat_interaction)) {
    if(istrue(int(self._blackboard.idlenode.repeat_interaction))) {
      return false;
    }
  }

  return true;
}

function capnotehandler(note, params) {
  statename = self asmgetcurrentstate(self.asmname);

  if(isstartstr(note, "cigarette")) {
    note = getsubstr(note, 10);
    notehandler_smoking(note, statename);
  } else if(isstartstr(note, "pack")) {
    note = getsubstr(note, 5);
    function_78fc852578a2d6a9(note, statename);
  } else if(isstartstr(note, "phone")) {
    note = getsubstr(note, 6);
    notehandler_cellphone(note, statename);
  } else if(isstartstr(note, "bottle")) {
    note = getsubstr(note, 7);
    notehandler_drinking(note, statename);
  } else if(isstartstr(note, "flashlight")) {
    note = getsubstr(note, 7);
    notehandler_flashlight(note, statename);
  } else if(isstartstr(note, "bread")) {
    note = getsubstr(note, 6);
    notehandler_bread(note, statename);
  } else if(isstartstr(note, "chips")) {
    note = getsubstr(note, 6);
    notehandler_chips(note, statename);
  } else if(isstartstr(note, "pistol")) {
    note = getsubstr(note, 7);
    notehandler_pistol(note, statename);
  } else if(isstartstr(note, "laptop")) {
    note = getsubstr(note, 7);
    notehandler_laptop(note, statename);
  } else if(isstartstr(note, "tablet")) {
    note = getsubstr(note, 7);
    notehandler_tablet(note, statename);
  } else if(isstartstr(note, "radio")) {
    note = getsubstr(note, 6);
    notehandler_radio(note, statename);
  } else if(isstartstr(note, "chair")) {
    note = getsubstr(note, 6);
    notehandler_chair(note, statename);
  } else if(isstartstr(note, "crowbar")) {
    note = getsubstr(note, 8);
    notehandler_crowbar(note, statename);
  } else {
    function_245f3c9cf9fb2ed4(note, statename);
  }
}

function function_245f3c9cf9fb2ed4(note, statename) {
  switch (self.animsetname) {
    case #"hash_149d7c5dce32a188":
    case #"hash_2bd6311d82467727":
    case #"hash_4f7b216c29f9fab5":
    case #"hash_62169a0a62911cd5":
    case #"hash_913d19a6e389869f":
    case #"hash_987dc0e7afc41c5e":
    case #"hash_a2eb0bfd79516586":
    case #"hash_c6cc13c8b340fbfe":
    case #"hash_d3a9a445b7f7c070":
    case #"hash_dc358932f675ac5a":
    case #"hash_dcd5de9c5dea1236":
    case #"hash_fae46b750738b9fd":
      notehandler_cellphone(note, statename);
      break;
    case #"hash_7f68acbb81f632ca":
    case #"hash_c46030dad508a702":
    case #"hash_c7dfb72d7a9773bc":
      notehandler_smoking(note, statename);
      break;
    case #"hash_6c70e540a4c2e2f3":
    case #"hash_949259d5442d2da1":
      notehandler_drinking(note, statename);
      break;
    case #"hash_39f24bc45741f688":
      notehandler_flashlight(note, statename);
      break;
    case #"hash_7fb4c7dc8b3bba9a":
      notehandler_pistol(note, statename);
      break;
    case #"hash_60794fd45ef8d7ee":
      notehandler_laptop(note, statename);
      break;
    case #"hash_595ae802da4a9716":
      function_425680112c205848(note, statename);
      break;
    case #"hash_83798f841323be0f":
      notehandler_sleeping(note, statename);
      break;
    case #"hash_d179924720fd42a4":
      notehandler_bag(note, statename);
      break;
  }
}

function function_c2c313a844d139b9() {
  self endon("death");
  ai = self getlinkedparent();

  while(isDefined(self) && self islinked() && !istrue(ai.in_melee) && !istrue(ai.in_melee_death) && isalive(ai)) {
    waitframe();
  }

  if(isDefined(ai)) {
    if(isDefined(ai.idle_fx)) {
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_right");
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_left");
      ai.idle_fx = undefined;
    }

    if(!istrue(level.var_e908c9dbefd1f3e6)) {
      ai launchprop(self);
      thread prop_delete();
      return;
    }
  }

  self delete();
}

function gethandtag(note) {
  handtag = "tag_accessory_right";
  hand = getsubstr(note, 7);

  if(isDefined(hand) && (hand == "left" || hand == "l")) {
    handtag = "tag_accessory_left";
  }

  return handtag;
}

function notehandler_cellphone(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(idle_getcellphone(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function idle_getcellphone() {
  modelname = "offhand_wm_smartphone_on";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cellphone"])) {
    modelname = level.scr_model["idle_cellphone"];
  }

  return modelname;
}

function notehandler_tablet(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(function_4c8b20626e0c2f54(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_4c8b20626e0c2f54() {
  modelname = "offhand2h_wm_tablet_v0";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_tablet"])) {
    modelname = level.scr_model["idle_tablet"];
  }

  return modelname;
}

function notehandler_radio(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(function_cc9b64be81cb46ef(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_cc9b64be81cb46ef() {
  modelname = "electronics_walkie_talkie_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_radio"])) {
    modelname = level.scr_model["idle_radio"];
  }

  return modelname;
}

function notehandler_bread(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    self.idle_prop = scripts\common\anim::anim_link_tag_model("food_bread_slice", handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function notehandler_chips(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    self.idle_prop = scripts\common\anim::anim_link_tag_model("food_trash_bag_chips_01", handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function notehandler_smoking(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(function_f7b213561a5c3b4c(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    self.idle_fx = level.g_effect["cigarette_unlit"];
    playFXOnTag(self.idle_fx, self, handtag);
    self.idle_prop.handtag = handtag;
    return;
  }

  if(isstartstr(note, "light")) {
    if(isDefined(self.idle_prop.handtag)) {
      handtag = self.idle_prop.handtag;
    }

    self.idle_fx = level.g_effect["cigarette_lit"];
    playFXOnTag(self.idle_fx, self, handtag);
    stopFXOnTag(level.g_effect["cigarette_unlit"], self, handtag);
    playFX(level.g_effect["lighter_glow"], self gettagorigin(handtag));
    thread smoking_blowsmoke(statename);
    return;
  }

  if(isstartstr(note, "detach") || isstartstr(note, "toss")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }

    stopFXOnTag(level.g_effect["cigarette_lit"], self, handtag);
    self.idle_fx = undefined;

    if(isstartstr(note, "toss")) {
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin(handtag), anglesToForward(self gettagangles(handtag)));
    }
  }
}

function function_f7b213561a5c3b4c() {
  modelname = "misc_cigarette_01_centered";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cigarette"])) {
    modelname = level.scr_model["idle_cigarette"];
  }

  return modelname;
}

function smoking_blowsmoke(statename) {
  self endon("smoking_end");
  self endon("death");

  while(true) {
    self.smoke_fx_ent = playFXOnTag(level.g_effect["cigarette_smoke"], self, "tag_eye");
    waittime = randomintrange(5, 8);
    wait waittime;

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

function smoking_cleanup(asmname, statename, params) {
  self notify("smoking_end");

  if(isDefined(self.idle_fx)) {
    stopFXOnTag(self.idle_fx, self, "tag_accessory_right");
    stopFXOnTag(self.idle_fx, self, "tag_accessory_left");
    self.idle_fx = undefined;
  }

  if(isDefined(self.smoke_fx_ent)) {
    self.smoke_fx_ent delete();
    self.smoke_fx_ent = undefined;
  }

  idle_cleanup(asmname, statename, params);
}

function function_78fc852578a2d6a9(note, statename) {
  action = getsubstr(note, 0, 6);
  handtag = gethandtag(note);

  switch (action) {
    case #"hash_2d1403e602f082a4":
      if(isDefined(self.var_cdb39b13b6524b5b)) {
        return;
      }

      self.var_cdb39b13b6524b5b = scripts\common\anim::anim_link_tag_model(function_34554aaf056d23d(), handtag);
      self.var_cdb39b13b6524b5b thread function_c2c313a844d139b9();
      break;
    case #"hash_682ec8b49fe7aa12":
      if(isDefined(self.var_cdb39b13b6524b5b)) {
        self.var_cdb39b13b6524b5b delete();
        self.var_cdb39b13b6524b5b = undefined;
      }

      break;
  }
}

function function_34554aaf056d23d() {
  modelname = "misc_cigarette_pack_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cigarettepack"])) {
    modelname = level.scr_model["idle_cigarettepack"];
  }

  return modelname;
}

function notehandler_flashlight(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(idle_focusflashlight(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    self notify("enable_flashlight_fx");
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function idle_focusflashlight() {
  modelname = "jup_tool_flashlight_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_focus_flashlight"])) {
    modelname = level.scr_model["idle_focus_flashlight"];
  }

  return modelname;
}

function notehandler_drinking(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(function_6d9a6be03f41b2c(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_6d9a6be03f41b2c() {
  modelname = "p7_bottle_plastic_16oz_water";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_bottle"])) {
    modelname = level.scr_model["idle_bottle"];
  }

  return modelname;
}

function notehandler_crowbar(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = scripts\common\anim::anim_link_tag_model(function_ccfa6fb9cdc07744(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_ccfa6fb9cdc07744() {
  modelname = "parts_jup_misc_crowbar";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_crowbar"])) {
    modelname = level.scr_model["idle_crowbar"];
  }

  return modelname;
}

function notehandler_sleeping(note, statename) {
  if(isDefined(self getinteractionid())) {
    spawnchair();
  }
}

function notehandler_pistol(note, statename) {
  handtag = "tag_accessory_right";
  gun = "weapon_wm_pi_mike1911_phys";

  if(isDefined(self getinteractionid())) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    spawnchair();

    if(!isDefined(self.idle_table)) {
      tableoffset = anglesToForward(self.angles) * 18 + (0, 0, -2);
      self.idle_table = utility::spawn_model(function_fe4813e6b6140728(), self.origin + tableoffset, self.angles);
    }

    origin = self.origin + (0, 0, 34) + anglesToForward(self.angles) * 10 + anglestoright(self.angles) * -8;
    self.idle_prop = utility::spawn_model(gun, origin, self.angles + (0, 90, 90));
    return;
  }

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }
}

function notehandler_table(note, statename) {
  if(isDefined(self getinteractionid())) {
    if(!isDefined(self.idle_table)) {
      tableoffset = anglesToForward(self.angles) * 18 + (0, 0, -2);
      self.idle_table = utility::spawn_model(function_fe4813e6b6140728(), self.origin + tableoffset, self.angles);
    }
  }
}

function notehandler_laptop(note, statename) {
  handtag = "tag_accessory_right";

  if(isDefined(self getinteractionid())) {
    spawnchair();

    if(!isDefined(self.idle_table)) {
      tableoffset = anglesToForward(self.angles) * 22 + (0, 0, -2);
      self.idle_table = utility::spawn_model(function_fe4813e6b6140728(), self.origin + tableoffset, self.angles);
    }

    if(isDefined(self.idle_laptop)) {
      return;
    }

    laptopoffset = anglesToForward(self.angles) * 30 + (0, 0, 31);
    self.idle_laptop = utility::spawn_model(function_1ee6622550f2a5d0(), self.origin + laptopoffset, self.angles);
  }
}

function function_1ee6622550f2a5d0() {
  modelname = "misc_wm_blackbox_laptop";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_laptop"])) {
    modelname = level.scr_model["idle_laptop"];
  }

  return modelname;
}

function function_425680112c205848(note, statename) {
  handtag = "tag_accessory_right";

  if(isDefined(self getinteractionid())) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    spawnchair();
    self.idle_prop = scripts\common\anim::anim_link_tag_model(idle_getcellphone(), handtag);
    self.idle_prop thread function_c2c313a844d139b9();
    return;
  }

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }
}

function notehandler_bag(note, statename) {
  modelname = "container_fertilizer_bag_01_open";
  offset = (0, 0, -13);

  if(isDefined(self getinteractionid())) {
    if(!isDefined(self.idle_bag)) {
      propanim = level.scr_anim["idle_bag"]["wait"];
      self.idle_bag = utility::spawn_model(modelname, self._blackboard.var_ad5eda311c73f5d7, self._blackboard.var_66c82b7660f29059);
      self.idle_bag useanimtree(level.scr_animtree["idle_bag"]);
      self.idle_bag animrelative("wait", self._blackboard.var_ad5eda311c73f5d7 + offset, self._blackboard.var_66c82b7660f29059, propanim);
      self.idle_bag.key = "wait";
      thread function_399c8ad9434488e8();
    }
  }

  if(!isDefined(self.idle_bag)) {
    return;
  }

  if(statename == "group_loop" && !istrue(self.idle_bag.isidle)) {
    self.idle_bag.key = "idle";
    self.idle_bag.isidle = 1;
    propanim = level.scr_anim["idle_bag"]["idle"];
    self.idle_bag animrelative("idle", self._blackboard.var_ad5eda311c73f5d7 + offset, self._blackboard.var_66c82b7660f29059, propanim);
    self.idle_bag thread function_cbde85a808114924();
  }
}

function function_cbde85a808114924() {
  self endon("death");
  self notify("prop_singleton");
  self endon("prop_singleton");
  self waittill("idle");
  self.isidle = 0;
}

function function_399c8ad9434488e8() {
  self endon("death");
  self.idle_bag endon("death");

  while(isDefined(self getinteractionid())) {
    waitframe();
  }

  self.idle_bag delete();
  self.idle_bag = undefined;
}

function notehandler_chair(note, statename) {
  if(isstartstr(note, "spawn")) {
    spawnchair();
  }

  if(!isDefined(self.idle_chair)) {
    origin = getinteractionorigin(self getinteractionid());
    chairs = getscriptablearray("interactable_chair", "script_noteworthy");
    maxdist = 16;
    self.idle_chair = getclosest(origin, chairs, maxdist);
    return;
  }

  self.idle_chair.key = undefined;

  if(isstartstr(note, "enter")) {
    self.idle_chair.key = "enter";
  }

  if(isstartstr(note, "idle")) {
    self.idle_chair.key = "idle";
  }

  if(isstartstr(note, "exit")) {
    self.idle_chair.key = "exit";
  }

  if(isstartstr(note, "death")) {
    self.idle_chair.key = "death";
  }

  if(isstartstr(note, "pain")) {
    self.idle_chair.key = "pain";
  }

  if(isstartstr(note, "react")) {
    self.idle_chair.key = "react";
  }

  if(isDefined(self.idle_chair.key)) {
    propanim = level.scr_anim["idle_bag"][self.idle_chair.key];
    self.idle_chair animrelative("idle", self._blackboard.var_ad5eda311c73f5d7, self._blackboard.var_66c82b7660f29059, propanim);
    self.idle_chair thread function_cbde85a808114924();
  }
}

function spawnchair() {
  modelname = "cp_disco_folding_chair_lod0";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_chair"])) {
    modelname = level.scr_model["idle_chair"];
  }

  if(!isDefined(self.idle_chair)) {
    self.idle_chair = utility::spawn_model(modelname, self.origin + anglesToForward(self.angles) * -8, self.angles);
  }

  return modelname;
}

function function_fe4813e6b6140728() {
  modelname = "furniture_kitchen_end_table_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_table"])) {
    modelname = level.scr_model["idle_table"];
  }

  return modelname;
}

function cappropcleanup(asmname, statename, params) {
  smoking_cleanup(asmname, statename, params);
  prop_drop(asmname, statename, params);
}

function prop_drop(asmname, statename, params) {
  props = [];

  if(isDefined(self.idle_prop)) {
    props[props.size] = self.idle_prop;
  }

  if(isDefined(self.var_cdb39b13b6524b5b)) {
    props[props.size] = self.var_cdb39b13b6524b5b;
  }

  if(isDefined(self.idle_fx)) {
    smoking_cleanup();
  }

  if(props.size == 0) {
    return;
  }

  foreach(prop in props) {
    if(!istrue(level.var_e908c9dbefd1f3e6)) {
      launchprop(prop);
    }

    prop thread prop_delete();
  }
}

function launchprop(prop) {
  if(!isDefined(prop) || !isent(prop) || !isDefined(prop.model) || prop.model == "") {
    return;
  }

  launchforce = anglesToForward(self.angles);
  launchforce *= randomfloatrange(10, 20);
  forcex = launchforce[0];
  forcey = launchforce[1];
  forcez = randomfloatrange(1, 10);
  prop unlink();
  prop physicslaunchserver(prop.origin, (forcex, forcey, forcez));
}

function prop_delete() {
  interval = 10000;
  starttime = gettime();
  endtime = starttime + interval;

  if(utility::issp() || utility::function_ccf98e6391dd38b9()) {
    wait 1;

    while(isDefined(self) && isalive(level.player) && gettime() < endtime && distance2dsquared(level.player.origin, self.origin) < 16384) {
      wait 1;
    }
  }

  if(isDefined(self)) {
    self delete();
  }
}

function idle_cleanup(asmname, statename, params) {
  self.newenemyreactiondistsq = 262144;
  self function_f7cff9f6dafb297();

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

function function_eaf18f0250abb7e7(asmname, statename, params) {
  statename = "death_custom";
  alias = "death_custom_anim";
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function ininteraction(asmname, statename, params) {
  return isDefined(self getinteractionid());
}

function incap(asmname, statename, params) {
  return self.asmname != "civilian_react" || isDefined(self.customarrivalanimset);
}

function function_8c68332a9a43f4ea(asmname, statename, params) {
  if(!isDefined(self._blackboard.coweralias)) {
    coweralias = asm_getrandomalias(statename);
    self._blackboard.coweralias = cap_lookupanimfromalias(statename, coweralias);
  }

  alias = self._blackboard.coweralias;

  if(statename == "cower_to_panicked") {
    self._blackboard.coweralias = undefined;
  }

  return alias;
}

function shouldskiptransition(asmname, statename, tostatename, params) {
  return istrue(self._blackboard.skiptransition);
}

function capchooseturnanim(asmname, statename, params) {
  yawtotarget = vectortoyaw(self.turntarget.origin - self.origin);
  anglediff = angleclamp180(yawtotarget - self.angles[1]);
  turnanim = undefined;

  if(isDefined(params) && params == "cardinal") {
    absanglediff = abs(anglediff);
    animindex = "2";

    if(absanglediff > 135) {
      animindex = "8";
    } else if(anglediff > 45 && anglediff <= 135) {
      animindex = "6";
    } else if(anglediff >= -135 && anglediff < -45) {
      animindex = "4";
    }

    turnanim = asm_lookupanimfromalias(statename, animindex);
    assertex(isDefined(turnanim), "<dev string:x217>" + animindex + "<dev string:x234>" + self.animsetname);
  } else {
    animmap = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
    animindex = getangleindex(anglediff, 22.5);
    animalias = animmap[animindex];
    turnanim = asm_lookupanimfromalias(statename, animmap[animindex]);
    assertex(isDefined(turnanim), "<dev string:x24e>" + animmap[animindex] + "<dev string:x234>" + self.animsetname);
  }

  return turnanim;
}

function function_b98734875ecb0d81(asmname, statename, tostatename, params) {
  return isDefined(self.turntarget);
}