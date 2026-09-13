/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\utility.gsc
***********************************************/

dotraversal() {
  self endon("killanimscript");
  startnode = self getnegotiationstartnode();
  animscript = startnode.animscript;
  self notify("traverse_begin", animscript, startnode);
  self waittill("traverse_end");
}

chooseanimwithoverride(asmname, statename, params) {
  return 0;
}

loopanimfortime(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("terminate_ai_threads");
  _id_6DE89AC92D7FA442 = "loop_end";
  t = 2;

  if(isarray(params)) {
    if(params.size > 0)
      t = params[0];

    if(params.size > 1)
      _id_6DE89AC92D7FA442 = params[1];
  } else
    t = params;

  thread scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1);
  wait(t);
  scripts\asm\asm::asm_fireevent(asmname, _id_6DE89AC92D7FA442);
}

waitforpathchange(asmname, statename) {
  self endon(statename + "_finished");
  self waittill("path_set");
  _id_2920E731907BA823 = self.lookaheaddir * self.lookaheaddist;
  _id_16E62139C4B7A264 = [0, _id_2920E731907BA823, 0, self.origin, self.lookaheaddist];
  scripts\asm\asm::asm_fireevent(asmname, "sharp_turn", _id_16E62139C4B7A264);
  thread waitforpathchange(asmname, statename);
}

playmoveloop_mp(asmname, statename, params) {
  thread waitforpathchange(asmname, statename);
  rate = 1.0;

  if(isDefined(self.asm.moveplaybackrate))
    rate = self.asm.moveplaybackrate;
  else if(isDefined(self.moveplaybackrate))
    rate = self.moveplaybackrate;

  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, rate);
}

isfacingenemy(_id_ED9AE4EC33B989C6) {
  if(!isDefined(_id_ED9AE4EC33B989C6))
    _id_ED9AE4EC33B989C6 = 0.5;

  forward = anglesToForward(self.angles);
  _id_A1711C6DD17E7EA7 = vectorNormalize(self.enemy.origin - self.origin);
  dot = vectordot(forward, _id_A1711C6DD17E7EA7);

  if(dot < _id_ED9AE4EC33B989C6)
    return 0;

  return 1;
}

isweaponfacingenemy() {
  if(isaimedataimtarget())
    return 1;

  return 0;
}

wantstocrouch() {
  if(scripts\asm\asm_bb::bb_getrequestedstance() == "crouch")
    return 1;

  return 0;
}

_id_71EEFA1C0DA64A21(_id_63A5B32B096323BE) {
  if(!istrue(self._blackboard.shootparams_valid))
    return undefined;
  else if(isDefined(self._blackboard.shootparams_ent))
    return self._blackboard.shootparams_ent getshootatpos();
  else if(isDefined(self._blackboard.shootparams_pos))
    return self._blackboard.shootparams_pos;
  else if(isDefined(self.enemy))
    return self.enemy getshootatpos();

  return undefined;
}

isaimedataimtarget() {
  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent))
    return 1;

  _id_9CBCD63169EBE6B9 = self getmuzzleangle();
  _id_63A5B32B096323BE = self getshootfrompos();
  shootpos = _id_71EEFA1C0DA64A21(_id_63A5B32B096323BE);

  if(!isDefined(shootpos))
    return 0;

  _id_17FFBC15989CD7CB = vectortoangles(shootpos - _id_63A5B32B096323BE);
  _id_9AFF98D3936D9DA1 = absangleclamp180(_id_9CBCD63169EBE6B9[1] - _id_17FFBC15989CD7CB[1]);

  if(_id_9AFF98D3936D9DA1 > anim.aimyawdifffartolerance) {
    if(distancesquared(self getEye(), shootpos) > anim.aimyawdiffclosedistsq || _id_9AFF98D3936D9DA1 > anim.aimyawdiffclosetolerance) {}
  }

  aimpitchdifftolerance = getaimpitchdifftolerance();
  return absangleclamp180(_id_9CBCD63169EBE6B9[0] - _id_17FFBC15989CD7CB[0]) <= aimpitchdifftolerance;
}

getaimpitchdifftolerance() {
  if(isDefined(self.aimpitchdifftolerance))
    return self.aimpitchdifftolerance;
  else
    return anim.aimpitchdifftolerance;
}

delayslowmotion(delay, start, end, time) {}

delaymodifybasefov(delay, fov, time) {}

animscriptmp(archetype, statename, aliasname, loop, _id_C08B84490B532FB2, _id_FBB4259C26024712) {
  if(isDefined(_id_FBB4259C26024712))
    thread animscriptmp_watchcancel(_id_FBB4259C26024712);

  if(istrue(loop))
    thread animscriptmp_loop_internal(archetype, statename, aliasname, _id_C08B84490B532FB2);
  else
    thread animscriptmp_single_internal(archetype, statename, aliasname, _id_C08B84490B532FB2);
}

cancelanimscriptmp() {
  if(!scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  cancelanimscriptmp_internal();
  self notify("CancelAnimscriptMP");
}

animscriptmp_watchcancel(_id_FBB4259C26024712) {
  self endon("AnimscriptMP_Complete");
  self endon("death");
  self endon("CancelAnimscriptMP");
  self waittill(_id_FBB4259C26024712);
  cancelanimscriptmp();
}

animscriptmp_single_internal(archetype, statename, aliasname, _id_C08B84490B532FB2) {
  animscriptmp_internal(archetype, statename, aliasname, _id_C08B84490B532FB2);

  if(isDefined(self) && isalive(self)) {
    cancelanimscriptmp_internal();
    self notify("AnimscriptMP_Complete");
  }
}

animscriptmp_loop_internal(archetype, statename, aliasname, _id_C08B84490B532FB2) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  for(;;)
    animscriptmp_internal(archetype, statename, aliasname, _id_C08B84490B532FB2);
}

animscriptmp_internal(archetype, statename, aliasname, _id_C08B84490B532FB2) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  if(!isDefined(_id_C08B84490B532FB2))
    _id_C08B84490B532FB2 = 1;

  self setoverridearchetype("animscript", archetype, 1);
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = archetypegetrandomalias(archetype, statename, aliasname, scripts\asm\asm::asm_isfrantic());
  self aisetanim(statename, animindex, _id_C08B84490B532FB2);
  self aisetanimrate(statename, animindex, _id_C08B84490B532FB2);
  xanim = animsetgetanimfromindex(archetype, statename, animindex);
  animlength = getanimlength(xanim);
  self.scripted_mode = 1;
  self.ignoreall = 1;
  wait(animlength / _id_C08B84490B532FB2);
}

cancelanimscriptmp_internal() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  self clearoverridearchetype("animscript", 0, 0);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

animscripted_single(aliasname, _id_1A11AEA0C900B403, statename) {
  scripts\asm\asm_mp::asm_setanimScripted();

  if(!isDefined(statename))
    statename = "animscripted";

  animindex = scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
  self aisetanim(statename, animindex);

  if(!isDefined(_id_1A11AEA0C900B403))
    _id_1A11AEA0C900B403 = 0;

  if(!_id_1A11AEA0C900B403) {
    xanim = scripts\asm\asm::asm_getxanim(statename, animindex);
    animlength = getanimlength(xanim);
    wait(animlength);
  }
}

animscripted_single_earlyend(aliasname, time) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  self aisetanim("animscripted", animindex);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(time < animlength)
    wait(animlength - time);
}

animscripted_loop(aliasname) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05)
    animlength = 0.05;

  for(;;) {
    self aisetanim("animscripted", animindex);
    wait(animlength);
  }
}

animscripted_loop_earlyend(aliasname, time) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(time < animlength)
    animlength = animlength - time;

  if(animlength < 0.05)
    animlength = 0.05;

  for(;;) {
    self aisetanim("animscripted", animindex);
    wait(animlength);
  }
}

animscripted_loop_for_time(aliasname, time) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05)
    animlength = 0.05;

  for(timeremaining = time; timeremaining >= 0; timeremaining = timeremaining - animlength) {
    self aisetanim("animscripted", animindex);
    wait(animlength);
  }
}

animscripted_loop_n_times(aliasname, _id_0106BDA484C78A52) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05)
    animlength = 0.05;

  while(_id_0106BDA484C78A52 > 0) {
    self aisetanim("animscripted", animindex);
    wait(animlength);
    _id_0106BDA484C78A52--;
  }
}

animscripted_loop_relative(aliasname, ent, tag) {
  self endon("death");
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);

  if(isDefined(tag)) {
    startpos = ent gettagorigin(tag);
    startangles = ent gettagangles(tag);
  } else {
    startpos = ent.origin;
    startangles = ent.angles;
  }

  _id_BCF9684C0529009A = getstartorigin(startpos, startangles, xanim);
  _id_F20BC08C9FC211A0 = getstartangles(startpos, startangles, xanim);
  self dontinterpolate();
  self forceteleport(_id_BCF9684C0529009A, _id_F20BC08C9FC211A0, 9999999, 0);

  for(;;) {
    if(!istrue(self._blackboard.animscriptedactive)) {
      return;
    }
    self aisetanim("animscripted", animindex);
    animlength = getanimlength(xanim);
    wait(animlength);
  }
}

animscripted_single_relative(aliasname, ent, tag, _id_1A11AEA0C900B403, statename) {
  if(!isDefined(statename))
    statename = "animscripted";

  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
  xanim = scripts\asm\asm::asm_getxanim(statename, animindex);

  if(isDefined(tag)) {
    startpos = ent gettagorigin(tag);
    startangles = ent gettagangles(tag);
  } else {
    startpos = ent.origin;
    startangles = ent.angles;
  }

  _id_BCF9684C0529009A = getstartorigin(startpos, startangles, xanim);
  _id_F20BC08C9FC211A0 = getstartangles(startpos, startangles, xanim);
  self dontinterpolate();
  self forceteleport(_id_BCF9684C0529009A, _id_F20BC08C9FC211A0, 9999999, 0);
  self aisetanim(statename, animindex);

  if(!isDefined(_id_1A11AEA0C900B403))
    _id_1A11AEA0C900B403 = 0;

  if(!_id_1A11AEA0C900B403) {
    animlength = getanimlength(xanim);
    wait(animlength);
  }
}

animscripted_single_arrive_at(aliasname, pos, angles, _id_1A11AEA0C900B403) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", aliasname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_95ABCCFE668F369A = getmovedelta(xanim);
  _id_8C94765CA587F86C = getangledelta3d(xanim);
  startangles = combineangles(angles, invertangles(_id_8C94765CA587F86C));
  startpos = pos - rotatevector(_id_95ABCCFE668F369A, startangles);
  self dontinterpolate();
  self forceteleport(startpos, startangles, 9999999, 0);
  self aisetanim("animscripted", animindex);

  if(!isDefined(_id_1A11AEA0C900B403))
    _id_1A11AEA0C900B403 = 0;

  if(!_id_1A11AEA0C900B403) {
    animlength = getanimlength(xanim);
    wait(animlength);
  }
}

animscripted_clear() {
  scripts\asm\asm_bb::bb_clearanimScripted();
}

_id_8FA69650E33C84EF(anime) {
  if(!isDefined(level.scr_anim) || !isDefined(level.scr_anim[self.animname]) || !isDefined(level.scr_anim[self.animname][anime]))
    return 0;

  return 1;
}

_id_577D8ABFF6067C23(anime, _id_314C4455B996B224, org, _id_8C94765CA587F86C) {
  self endon("death");
  aliasname = level.scr_anim[self.animname][anime];

  if(isDefined(org)) {
    anim_node = spawnStruct();
    anim_node.origin = org;
    anim_node.angles = _id_8C94765CA587F86C;
    animscripted_single_relative(aliasname, anim_node);
  } else
    animscripted_single(aliasname);

  animscripted_clear();
  self notify(_id_314C4455B996B224, "end");
}