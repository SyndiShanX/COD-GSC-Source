/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\cap.gsc
**************************************/

#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace asm_cap;

function function_d5f3ba0089e6bb87(asmname, statename, params) {
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

  warptarget = self function_564775eb2acf5e3f();
  targetangles = self.angles;

  if(isDefined(warptarget)) {
    targetpos = warptarget.origin;
    movedirnormalized = vectorNormalize(targetpos - self.origin);
    targetangles = vectortoangles(movedirnormalized);
  }

  targetyaw = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = asm::yawdiffto2468(targetyaw);

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

function cap_playanim_pushed(asmname, statename, params) {
  self.lasttimepushed = gettime();
  self.attitude = "curious";
  cap_playanim(asmname, statename, params);
}

function function_b0881496c5f588c3(asmname, sourceciv) {
  self endon("death");
  player = getclosestplayer(sourceciv.origin);

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
    var_228e5851bf553acb = lengthsquared(tootherciv);
    maxdistance = 80;

    if(var_228e5851bf553acb > maxdistance * maxdistance) {
      continue;
    }

    var_e43eacb01fe4be6e = vectorNormalize(tootherciv);
    dot = vectordot(var_e43eacb01fe4be6e, movedirnormalized);

    if(dot > 0.96) {
      otherciv asm::asm_fireevent(asmname, "player_pushed");
    }
  }
}

function private getclosestplayer(testorigin) {
  if(utility::ismp()) {
    radius = 700;
    players = getplayersinradius(testorigin, radius);

    if(!isDefined(players)) {
      return;
    }

    if(players.size == 0) {
      return;
    }

    players = sortbydistance(players, testorigin);
    return players[0];
  }

  return level.player;
}

function cap_playanim_pushed_hard(asmname, statename, params) {
  thread function_b0881496c5f588c3(asmname, self);
  self.lasttimepushed = gettime();
  self.attitude = "angered";
  cap_playanim(asmname, statename, params);
}

function function_f867c83bad54ffa8(statename) {
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
  self.capanimid = asm::asm_getanim(asmname, statename);
  cap_playanim_internal(asmname, statename, params, self.capanimid);
}

function cap_playanim_internal(asmname, statename, params, animid) {
  self endon(statename + "_finished");
  xanim = asm::asm_getxanim(statename, animid);
  function_1e26c70280259c3f(statename, xanim);

  if(isai(self)) {
    var_cbe0a3d32726f09e = self function_90f71263a5ae4ecb();

    if(isDefined(var_cbe0a3d32726f09e)) {
      if(var_cbe0a3d32726f09e isscriptableinstance()) {
        function_ded2e1c43ae7caf(statename, var_cbe0a3d32726f09e);
      } else {
        function_d5fb8f35869be0d6(statename, var_cbe0a3d32726f09e);
      }
    }

    self aisetanim(statename, animid);
  } else {
    bodyanimid = asm::asm_lookupanimfromalias("knobs", "body");
    bodyxanim = asm::asm_getxanim("knobs", bodyanimid);
    self setflaggedanimknoballrestart(statename, xanim, bodyxanim, 1, 0.2, 1);
    self setanim(bodyxanim, 1, 0.2);

    if(statename == "relaxed" || statename == "single_loop" || statename == "group_loop") {
      cap_proceduralturn_forward();
    } else if(isarray(params) && params.size == 2) {
      proceduralturn = params[1];

      if(proceduralturn) {
        childthread cap_proceduralturn();
      }
    }
  }

  function_8045e4c15184ed50(statename, xanim);
  cap_propanim(asmname, statename, params);
  asm::asm_playfacialanim(asmname, statename, xanim);
  cap_donotetracks(asmname, statename);
}

function function_4de072f9061e4554(asmname, statename, params) {
  cap_playanim(asmname, statename, params);

  if(isDefined(self.node)) {
    self.keepclaimednodeifvalid = 1;
  }
}

function function_e7eb6dd4c6bee96a(asmname, statename, params) {
  self.keepclaimednodeifvalid = 0;
}

function function_1e26c70280259c3f(statename, xanim, animtime) {
  if(isDefined(self.relativestates) && arraycontains(self.relativestates, statename)) {
    return;
  }

  scriptednode = function_5a86a8fec880930b();

  if(!isDefined(scriptednode)) {
    return;
  }

  if(!isDefined(animtime)) {
    animtime = 0;
  }

  origin = scriptednode.origin;
  angles = scriptednode.angles ?? (0, 0, 0);
  startorg = getoriginforanimtime(origin, angles, xanim, animtime);
  startangles = getanglesforanimtime(origin, angles, xanim, animtime);

  if(isai(self)) {
    self forceteleport(startorg, startangles, 9999);
    return;
  }

  self.origin = startorg;
  self.angles = startangles;
}

function function_5a86a8fec880930b() {
  if(isDefined(self.scriptednodebypass)) {
    return;
  }

  var_7237854e3be197ca = self.scriptednode;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  var_7237854e3be197ca = self.animnode;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  var_7237854e3be197ca = self.scripted_animnode;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  var_7237854e3be197ca = self.scripted_anim_node;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }
}

function function_8045e4c15184ed50(statename, xanim) {
  if(!isDefined(self.resumestatetime) || !isDefined(self.resumestatetime[statename])) {
    return;
  }

  var_2fa91f90efb30033 = self;

  if(isDefined(self.var_2fa91f90efb30033)) {
    var_2fa91f90efb30033 = self.var_2fa91f90efb30033;
  }

  resumetime = var_2fa91f90efb30033.resumestatetime[statename];
  assert(isDefined(resumetime), "<dev string:x24>" + statename + "<dev string:x50>");
  function_1e26c70280259c3f(statename, xanim, resumetime);
  self setanimtime(xanim, resumetime);
  thread function_fe3a3571bf158f81(statename, xanim);
}

function function_fe3a3571bf158f81(statename, xanim) {
  self endon(statename + "_finished");

  while(true) {
    self.resumestatetime[statename] = self getanimtime(xanim);
    waitframe();
  }
}

function cap_proceduralturn() {
  while(true) {
    player = getclosestplayer(self.origin);

    if(!isDefined(player)) {
      waitframe();
      continue;
    }

    target = player;

    if(isalive(self._blackboard.var_8141bfd7b74a80f6)) {
      enemy = self._blackboard.var_8141bfd7b74a80f6;
    }

    totarget = target.origin - self.origin;
    distsqrtotarget = lengthsquared(totarget);
    anglediff = angleclamp180(vectortoyaw(totarget) - self.angles[1]);
    var_a73e896d91e2aa7a = [[300, 180], [0, 10]];
    angletouse = 0;

    foreach(pair in var_a73e896d91e2aa7a) {
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

function cap_proceduralturn_forward() {
  rotationspeed = 70;

  while(true) {
    origin = self.caporigin + anglesToForward(self.capangles) * 50;

    if(isalive(self._blackboard.var_8141bfd7b74a80f6)) {
      enemy = self._blackboard.var_8141bfd7b74a80f6;
    }

    totarget = origin - self.origin;
    distsqrtotarget = lengthsquared(totarget);
    anglediff = angleclamp180(vectortoyaw(totarget) - self.angles[1]);
    var_a73e896d91e2aa7a = [[300, 180], [0, 10]];
    angletouse = 0;

    foreach(pair in var_a73e896d91e2aa7a) {
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

function function_c3561644e599fa70(xanim, tracktime) {}

function function_aca38f6190adaf8b(xanim, tracktime) {}

function function_7061e465eb4117da(player) {}

function cap_loopanim(asmname, statename, params) {
  self endon(statename + "_finished");

  while(true) {
    animid = asm::asm_getanim(asmname, statename);
    xanim = asm::asm_getxanim(statename, animid);
    function_1e26c70280259c3f(statename, xanim);

    if(isai(self)) {
      self aisetanim(statename, animid);
      asm::asm_playfacialanim(asmname, statename, xanim);
    } else {
      bodyanimid = asm::asm_lookupanimfromalias("knobs", "body");
      bodyxanim = asm::asm_getxanim("knobs", bodyanimid);
      self setflaggedanimknoballrestart(statename, xanim, bodyxanim, 1, 0.2, 1);
    }

    cap_propanim(asmname, statename, params);
    cap_donotetracks(asmname, statename);
  }
}

function cap_donotetracks(asmname, statename) {
  notehandler = asm::asm_getnotehandler(asmname, statename);

  for(endnote = undefined; !isDefined(endnote) || !isstring(endnote) || endnote != "end"; endnote = asm::asm_donotetracks(asmname, statename, notehandler)) {}

  return endnote;
}

function cap_notetrackhandler(notetrack) {
  notetracks::notetrack_prefix_handler(notetrack);
  return undefined;
}

function cap_chooseanim(asmname, statename, params) {
  if(!isDefined(params)) {
    randomalias = cap_lookuprandomalias(statename);
    return cap_lookupanimfromalias(statename, randomalias);
  }

  result = undefined;
  prefixstr = asm_bb::bb_getprefixstring(params);

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

function cap_chooseanimdistance(asmname, statename, params) {
  neardistthreshold = 450;
  neardistthresholdsqr = neardistthreshold * neardistthreshold;
  player = getclosestplayer(self.origin);

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
    contents = trace::create_contents(1, 0, 0, 0, 0, 0, 0);
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

function function_da5175524f57289a(asmname, statename, params) {
  if(!isDefined(params)) {
    randomalias = cap_lookuprandomalias(statename);
    return function_38d1e30680a5d36f(statename, randomalias);
  }

  result = undefined;
  prefixstr = asm_bb::bb_getprefixstring(params);

  if(isDefined(prefixstr)) {
    randomalias = cap_lookuprandomalias(statename, prefixstr);
    result = function_38d1e30680a5d36f(statename, randomalias);
  } else {
    result = function_38d1e30680a5d36f(statename, params);
  }

  return result;
}

function cap_lookupanimfromalias(statename, alias) {
  arcname = self.animsetname;
  assert(isDefined(arcname), "<dev string:x77>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm::asm_isfrantic());
  assert(isDefined(animresult), "<dev string:x9e>" + alias + "<dev string:xb7>" + arcname + "<dev string:xc9>" + statename + "<dev string:xd4>" + self.classname);
  return animresult;
}

function function_38d1e30680a5d36f(statename, alias) {
  arcname = self.animsetname;

  if(!isDefined(self.var_f6cf297cd6c37337)) {
    self.var_f6cf297cd6c37337 = [];
  }

  if(!isDefined(self.var_f6cf297cd6c37337[statename])) {
    self.var_f6cf297cd6c37337[statename] = [];
  }

  if(!isDefined(self.var_f6cf297cd6c37337[statename][alias])) {
    self.var_f6cf297cd6c37337[statename][alias] = 0;
  }

  animindices = animsetgetallanimindicesforalias(arcname, statename, alias);
  animresult = animindices[self.var_f6cf297cd6c37337[statename][alias]];
  self.var_f6cf297cd6c37337[statename][alias]++;

  if(self.var_f6cf297cd6c37337[statename][alias] >= animindices.size) {
    self.var_f6cf297cd6c37337[statename][alias] = 0;
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
    if(!allownone) {
      msg = "<dev string:xdd>" + statename + "<dev string:xb7>" + archetype;

      if(isDefined(optionalprefix)) {
        msg += "<dev string:x105>" + optionalprefix;
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

  if(!allownone && !isDefined(chosen)) {
    msg = "<dev string:xdd>" + statename + "<dev string:xb7>" + archetype;

    if(isDefined(optionalprefix)) {
      msg += "<dev string:x105>" + optionalprefix;
    }

    assertmsg(msg);
  }

  return chosen;
}

function cap_event(asmname, statename, tostatename, params) {
  return false;
}

function cap_time_elapsed(asmname, statename, tostatename, params) {
  return false;
}

function function_5ba84486682aad55(asmname, statename, tostatename, params) {
  if(isai(self)) {
    return self codemoverequested();
  }

  return 0;
}

function function_2a155fba2493edcc(asmname, statename, params) {
  if(isDefined(params)) {
    assert(!isarray(params));
    asm_bb::bb_setcivilianstate(params);
  }

  self._blackboard.var_5ee32e89826cf63f = 1;
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
        aliasname = utility::random(aliasnames);
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
      propxanim = utility::random(propxanim);
    }

    scriptednode = function_5a86a8fec880930b();
    assert(isDefined(scriptednode), "<dev string:x116>");
    origin = scriptednode.origin;
    angles = scriptednode.angles ?? (0, 0, 0);
    prop animScripted(aliasname, origin, angles, propxanim);
  }
}

function cap_exit(asmname, statename, params) {
  if(!isalive(self)) {
    return;
  }

  cap::cap_exit();

  if(isstring(params)) {
    asm::asm_setstate(params);
  }
}

function function_ca554cf947d19584(asmname, statename, params) {
  if(isDefined(self.var_a9c672ba703a1aa3)) {
    self[[self.var_a9c672ba703a1aa3]](asmname, statename, params);
    return;
  }

  death::playdeathanimcommon(asmname, statename, params);
}

function cap_exit_long_death_death(asmname, statename, params) {
  cap::cap_exit();
  asm::asm_setstate("long_death_death");
}

function cap_exit_death(asmname, statename, params) {
  cap::cap_exit();
  asm::asm_setstate("death_generic");
}

function function_bbf33f428d6f0394(asmname, statename, params) {
  if(isDefined(self.var_ba65c0d36e610d7d)) {
    self[[self.var_ba65c0d36e610d7d]](asmname, statename, params);
    return;
  }

  asm::asm_playanimstate(asmname, statename, params);
  self notify("killanimscript");
}

function cap_exit_pain(asmname, statename, params) {
  cap::cap_exit();

  if(self.currentpose == "crouch") {
    asm::asm_setstate("pain_crouch");
    return;
  }

  asm::asm_setstate("pain_stand");
}

function function_bab17bc4cac0e3b2(asmname, statename, params) {
  cap::cap_exit();
  asm::asm_setstate("special_pain_in");
}

function cap_exit_long_death_skip_intro(asmname, statename, params) {
  cap::cap_exit();
  cache = self.forcelongdeathskipintroanim;
  self.forcelongdeathskipintroanim = 1;
  self.skipdyingbackcrawl = 1;
  asm::asm_setstate("choose_long_death");
  self.forcelongdeathskipintroanim = cache;
}

function cap_donothing(asmname, statename, params) {}

function cap_init(asmname, fromstate, tostate, params) {
  self.attitude = "relaxed";
}

function cap_attitude(asmname, fromstate, tostate, params) {
  assert(isDefined(params) && !isarray(params));
  return self.attitude == params;
}

function cap_shouldreact(asmname, statename, tostatename, params) {
  return self.attitude != "relaxed";
}

function cap_shouldreactlow(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_2be091d2ce1d5a7d":
      return 1;
    default:
      return 0;
  }
}

function cap_shouldreactmed(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_dd76edf4ebd198bd":
    case #"hash_f140fd4db5ed4df1":
      return 1;
    default:
      return 0;
  }
}

function cap_shouldreacthigh(asmname, statename, tostatename, params) {
  switch (self.attitude) {
    case #"hash_6da61cb2c6d68687":
    case #"hash_ea9150ecc8538d74":
      return 1;
    default:
      return 0;
  }
}

function function_b5f2aad0ceeb3d97(asmname, statename, tostatename, params) {
  assert(isDefined(params), "<dev string:x154>");

  if(!utility::flag_exist(params)) {
    return false;
  }

  return utility::flag(params);
}

function function_2a76e1ce63b18f19(asmname, statename, tostatename, params) {
  assert(isnumber(params), "<dev string:x198>");

  foreach(player in level.players) {
    if(distancesquared(self.origin, player.origin) <= params * params) {
      return true;
    }
  }

  return false;
}

function function_bb499c66c154c1db(asmname, statename, tostatename, params) {
  return function_48706802989070b5(params, 1);
}

function function_cf4877ea05753e49(asmname, statename, tostatename, params) {
  return function_48706802989070b5(params, 0);
}

function private function_48706802989070b5(params, dosighttrace) {
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

    if(utility::within_fov(playerorigin, playerangles, lookatorigin, fov)) {
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

function function_632eebf5e5bce8ea(asmname, statename, tostatename, params) {
  assert(isDefined(params), "<dev string:x1e8>");
  return self findoverridearchetype("default") == params;
}

function function_b79833801d9577e6(note, params) {
  capnotehandler(note, params, 1);
}

function capnotehandler(note, params, ispain) {
  statename = self asmgetcurrentstate(self.asmname);
  interactionscriptmodel = self function_90f71263a5ae4ecb();

  if(isDefined(interactionscriptmodel)) {
    notehandler_interactionscriptmodel(note, statename, interactionscriptmodel);
  } else if(isstartstr(note, "cigarette")) {
    note = getsubstr(note, 10);
    notehandler_smoking(note, statename);
  } else if(isstartstr(note, "pack")) {
    note = getsubstr(note, 5);
    notehandler_cigarettepack(note, statename);
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
  } else if(isstartstr(note, "champaign_glass")) {
    note = getsubstr(note, 17);
    notehandler_champaignglass(note, statename);
  } else if(isstartstr(note, "napkin")) {
    note = getsubstr(note, 8);
    notehandler_napkin(note, statename);
  } else if(isstartstr(note, "liquor_glass")) {
    note = getsubstr(note, 14);
    notehandler_liquorglass(note, statename);
  } else if(isstartstr(note, "liquor_bottle")) {
    note = getsubstr(note, 15);
    notehandler_liquorbottle(note, statename);
  } else {
    function_16430184dcaacf09(note, statename, ispain);
  }
}

function function_16430184dcaacf09(note, statename, ispain) {
  switch (self.animsetname) {
    case #"hash_fae46b750738b9fd":
    case #"hash_149d7c5dce32a188":
    case #"hash_dc358932f675ac5a":
    case #"hash_d3a9a445b7f7c070":
    case #"hash_2bd6311d82467727":
    case #"hash_c6cc13c8b340fbfe":
    case #"hash_a2eb0bfd79516586":
    case #"hash_62169a0a62911cd5":
    case #"hash_987dc0e7afc41c5e":
    case #"hash_913d19a6e389869f":
    case #"hash_4f7b216c29f9fab5":
    case #"hash_dcd5de9c5dea1236":
      notehandler_cellphone(note, statename);
      break;
    case #"hash_1a4a2ede12d242d4":
    case #"hash_1affbd57655557bc":
    case #"hash_c7dfb72d7a9773bc":
    case #"hash_dfb2fcdf70819894":
    case #"hash_dfb2ffdf70819d4d":
    case #"hash_443ed45254f63e9b":
    case #"hash_443ed55254f6402e":
    case #"hash_7f68acbb81f632ca":
    case #"hash_c37f34c3ce368de":
    case #"hash_95d5c26c8f417596":
    case #"hash_9eb1b619faced36c":
    case #"hash_a0646f7e85fe3b2b":
    case #"hash_c46030dad508a702":
      notehandler_smoking(note, statename);
      break;
    case #"hash_6c70e540a4c2e2f3":
    case #"hash_949259d5442d2da1":
      notehandler_drinking(note, statename, ispain);
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
      function_39586589ede59a57(note, statename);
      break;
    case #"hash_83798f841323be0f":
      notehandler_sleeping(note, statename);
      break;
    case #"hash_d179924720fd42a4":
      notehandler_bag(note, statename);
      break;
    case #"hash_2de89aea4cd52b1e":
    case #"hash_61494122de3eece8":
    case #"hash_61494422de3ef1a1":
      notehandler_champaignglass(note, statename);
      break;
    case #"hash_d79c3c62ed12cbbe":
      notehandler_napkin(note, statename);
      break;
    case #"hash_2f68707913d297c5":
    case #"hash_e435cfbec9b863c8":
      notehandler_liquorglass(note, statename);
      break;
    case #"hash_b92ab7afc12023b5":
    case #"hash_54c0453a5d0a345a":
      notehandler_liquorbottle(note, statename);
      break;
  }
}

function function_64053b572b4d36b0() {
  self endon("death");
  ai = self getlinkedparent();

  while(isDefined(self) && self islinked() && !ai.in_melee && !ai.in_melee_death && isalive(ai)) {
    waitframe();
  }

  if(isDefined(ai)) {
    if(isDefined(ai.idle_fx)) {
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_right");
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_left");
      ai.idle_fx = undefined;
    }

    if(!level.var_c294a30622f899b5) {
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

  if(hand == "left" || hand == "l") {
    handtag = "tag_accessory_left";
  }

  return handtag;
}

function function_d5fb8f35869be0d6(asmstate, interactionscriptmodel) {
  animsname = interactionscriptmodel function_1467eb5cc4102bf4(asmstate);

  if(isDefined(animsname)) {
    interactionscriptmodel thread animation::anim_single_solo(interactionscriptmodel, animsname);
  }
}

function function_ded2e1c43ae7caf(asmstate, interactionscriptmodel) {
  interactionscriptmodel setscriptablepartstate(interactionscriptmodel.partname, asmstate, 0);
}

function notehandler_interactionscriptmodel(note, statename, interactionscriptmodel) {
  switch (note) {
    case #"hash_6fb23e39e833ccc9":
      bonename = interactionscriptmodel function_599699f695591103();

      if(isDefined(bonename)) {
        interactionscriptmodel linkTo(self, bonename, (0, 0, 0), (0, 0, 0));
      }

      break;
    case #"hash_92bcabbf88850fb2":
      bonename = interactionscriptmodel function_599699f695591103();

      if(isDefined(bonename)) {
        interactionscriptmodel unlink();
      }

      break;
  }
}

function notehandler_cellphone(note, statename) {
  self endon(statename + "_finished");
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(idle_getcellphone(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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

    self.idle_prop = animation::anim_link_tag_model(function_90db32130bc71deb(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_90db32130bc71deb() {
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

    self.idle_prop = animation::anim_link_tag_model(function_64d13ca3f8c792be(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_64d13ca3f8c792be() {
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
    self.idle_prop = animation::anim_link_tag_model("food_bread_slice", handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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
    self.idle_prop = animation::anim_link_tag_model("food_trash_bag_chips_01", handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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

    self.idle_prop = animation::anim_link_tag_model(function_68e721497784be41(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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

function function_68e721497784be41() {
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
    thread utility::playsoundontag("fly_t10_ai_smoking_exhale_01", "j_head", undefined, undefined, undefined);
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

function notehandler_cigarettepack(note, statename) {
  action = getsubstr(note, 0, 6);
  handtag = gethandtag(note);

  switch (action) {
    case #"hash_2d1403e602f082a4":
      if(isDefined(self.idle_prop_pack)) {
        return;
      }

      self.idle_prop_pack = animation::anim_link_tag_model(function_74fcbb8a6075305c(), handtag);
      self.idle_prop_pack thread function_64053b572b4d36b0();
      break;
    case #"hash_682ec8b49fe7aa12":
      if(isDefined(self.idle_prop_pack)) {
        self.idle_prop_pack delete();
        self.idle_prop_pack = undefined;
      }

      break;
  }
}

function function_74fcbb8a6075305c() {
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

    self.idle_prop = animation::anim_link_tag_model(idle_focusflashlight(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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
  modelname = "c_t10_gear_flashlight_map_reading_anim";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_focus_flashlight"])) {
    modelname = level.scr_model["idle_focus_flashlight"];
  }

  return modelname;
}

function notehandler_drinking(note, statename, ispain) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_481ffce7fc751da7(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      if(ispain) {
        self.idle_prop unlink();
        self.idle_prop = undefined;
        return;
      }

      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_481ffce7fc751da7() {
  modelname = "p7_bottle_plastic_16oz_water";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_bottle"])) {
    modelname = level.scr_model["idle_bottle"];
  }

  return modelname;
}

function notehandler_champaignglass(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_cb51f142bcc3cc33(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_cb51f142bcc3cc33() {
  modelname = "t10_tableware_glass_flute_champagne_01_filled_b";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_champaignglass"])) {
    modelname = level.scr_model["idle_champaignglass"];
  }

  return modelname;
}

function notehandler_napkin(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_ea9ad62f6ce64d64(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_ea9ad62f6ce64d64() {
  modelname = "t10_tableware_napkin_cloth_folded_03_dest_02";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_napkin"])) {
    modelname = level.scr_model["idle_napkin"];
  }

  return modelname;
}

function notehandler_liquorglass(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_9d4e3bcc6bc5bb09(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_9d4e3bcc6bc5bb09() {
  modelname = "t10_tableware_glass_tumbler_sml_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_liquorglass"])) {
    modelname = level.scr_model["idle_liquorglass"];
  }

  return modelname;
}

function notehandler_liquorbottle(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_c54fa8e54d72cecf(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_c54fa8e54d72cecf() {
  modelname = "t10_food_bottle_glass_liquor_08";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_liquorbottle"])) {
    modelname = level.scr_model["idle_liquorbottle"];
  }

  return modelname;
}

function notehandler_crowbar(note, statename) {
  handtag = gethandtag(note);

  if(isstartstr(note, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(function_afd17c253068e399(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
    return;
  }

  if(isstartstr(note, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function function_afd17c253068e399() {
  modelname = "parts_jup_misc_crowbar";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_crowbar"])) {
    modelname = level.scr_model["idle_crowbar"];
  }

  return modelname;
}

function notehandler_sleeping(note, statename) {
  if(isDefined(self getinteractionid())) {}
}

function notehandler_pistol(note, statename) {
  handtag = "tag_accessory_right";
  gun = "weapon_wm_pi_mike1911_phys";

  if(isDefined(self getinteractionid())) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    if(!isDefined(self.idle_table)) {
      tableoffset = anglesToForward(self.angles) * 18 + (0, 0, -2);
      self.idle_table = utility::spawn_model(function_2320b4e0344fed1d(), self.origin + tableoffset, self.angles);
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
      self.idle_table = utility::spawn_model(function_2320b4e0344fed1d(), self.origin + tableoffset, self.angles);
    }
  }
}

function notehandler_laptop(note, statename) {
  handtag = "tag_accessory_right";

  if(isDefined(self getinteractionid())) {
    if(!isDefined(self.idle_table)) {
      tableoffset = anglesToForward(self.angles) * 22 + (0, 0, -2);
      self.idle_table = utility::spawn_model(function_2320b4e0344fed1d(), self.origin + tableoffset, self.angles);
    }

    if(isDefined(self.idle_laptop)) {
      return;
    }

    laptopoffset = anglesToForward(self.angles) * 30 + (0, 0, 31);
    self.idle_laptop = utility::spawn_model(function_730007b0ea5c9207(), self.origin + laptopoffset, self.angles);
  }
}

function function_730007b0ea5c9207() {
  modelname = "misc_wm_blackbox_laptop";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_laptop"])) {
    modelname = level.scr_model["idle_laptop"];
  }

  return modelname;
}

function function_39586589ede59a57(note, statename) {
  handtag = "tag_accessory_right";

  if(isDefined(self getinteractionid())) {
    if(isDefined(self.idle_prop)) {
      return;
    }

    self.idle_prop = animation::anim_link_tag_model(idle_getcellphone(), handtag);
    self.idle_prop thread function_64053b572b4d36b0();
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
      self.idle_bag = utility::spawn_model(modelname, self._blackboard.var_8690cdaf3fef6fec, self._blackboard.var_54bc96b8017ea2ee);
      self.idle_bag useanimtree(level.scr_animtree["idle_bag"]);
      self.idle_bag animrelative("wait", self._blackboard.var_8690cdaf3fef6fec + offset, self._blackboard.var_54bc96b8017ea2ee, propanim);
      self.idle_bag.key = "wait";
      thread function_f47ce971e1c78885();
    }
  }

  if(!isDefined(self.idle_bag)) {
    return;
  }

  if(statename == "group_loop" && !self.idle_bag.isidle) {
    self.idle_bag.key = "idle";
    self.idle_bag.isidle = 1;
    propanim = level.scr_anim["idle_bag"]["idle"];
    self.idle_bag animrelative("idle", self._blackboard.var_8690cdaf3fef6fec + offset, self._blackboard.var_54bc96b8017ea2ee, propanim);
    self.idle_bag thread function_f159bd9d9fb8b581();
  }
}

function function_f159bd9d9fb8b581() {
  self endon("death");
  self notify("prop_singleton");
  self endon("prop_singleton");
  self waittill("idle");
  self.isidle = 0;
}

function function_f47ce971e1c78885() {
  self endon("death");
  self.idle_bag endon("death");

  while(isDefined(self getinteractionid())) {
    waitframe();
  }

  self.idle_bag delete();
  self.idle_bag = undefined;
}

function notehandler_chair(note, statename) {}

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

function function_2320b4e0344fed1d() {
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

  if(isDefined(self.idle_prop_pack)) {
    props[props.size] = self.idle_prop_pack;
  }

  if(isDefined(self.idle_fx)) {
    smoking_cleanup();
  }

  if(props.size == 0) {
    return;
  }

  foreach(prop in props) {
    if(!level.var_c294a30622f899b5) {
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

  if(utility::issp()) {
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
  self function_49d3154c50a04d58();

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

function function_b07023605221e73c(asmname, statename, params) {
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

function function_83ef1379dd15e081(asmname, statename, params) {
  if(!isDefined(self._blackboard.coweralias)) {
    coweralias = asm::asm_getrandomalias(statename);
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

  if(params == "cardinal") {
    absanglediff = abs(anglediff);
    animindex = "2";

    if(absanglediff > 135) {
      animindex = "8";
    } else if(anglediff > 45 && anglediff <= 135) {
      animindex = "6";
    } else if(anglediff >= -135 && anglediff < -45) {
      animindex = "4";
    }

    turnanim = asm::asm_lookupanimfromalias(statename, animindex);
    assert(isDefined(turnanim), "<dev string:x21f>" + animindex + "<dev string:x23c>" + self.animsetname);
  } else {
    animmap = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
    animindex = getangleindex(anglediff, 22.5);
    animalias = animmap[animindex];
    turnanim = asm::asm_lookupanimfromalias(statename, animmap[animindex]);
    assert(isDefined(turnanim), "<dev string:x256>" + animmap[animindex] + "<dev string:x23c>" + self.animsetname);
  }

  return turnanim;
}

function function_8a8727784428ee26(asmname, statename, tostatename, params) {
  return isDefined(self.turntarget);
}

function function_b6a01df66755ad67(asmname, statename, tostatename, params) {
  interactionid = self getinteractionid();

  if(!interactionid) {
    return 0;
  }

  if(!isDefined(archetypegetaliases(self.animsetname, tostatename))) {
    return 0;
  }

  return function_521b5a0a07a246a8(interactionid, "friendDown");
}

function function_42bf7bda1fa0820f(asmname, statename, params) {
  alias = self.blackboard.bseqphase ?? "idle";
  return cap_lookupanimfromalias(statename, alias);
}