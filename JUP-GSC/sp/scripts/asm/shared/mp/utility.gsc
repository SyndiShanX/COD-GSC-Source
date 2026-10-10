/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\shared\mp\utility.gsc
************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace utility;

function dotraversal() {
  self endon("killanimscript");
  startnode = self getnegotiationstartnode();
  animscript = startnode.animscript;
  self notify("traverse_begin", animscript, startnode);
  self waittill("traverse_end");
}

function chooseanimwithoverride(asmname, statename, params) {
  return false;
}

function loopanimfortime(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("terminate_ai_threads");
  endevent = "loop_end";
  t = 2;

  if(isarray(params)) {
    if(params.size > 0) {
      t = params[0];
    }

    if(params.size > 1) {
      endevent = params[1];
    }
  } else {
    t = params;
  }

  thread function_fb56c9527636713f(asmname, statename, 1);
  wait t;
  asm_fireevent(asmname, endevent);
}

function waitforpathchange(asmname, statename) {
  self endon(statename + "_finished");
  self waittill("path_set");
  var_2920e731907ba823 = self.lookaheaddir * self.lookaheaddist;
  turnparams = [0, var_2920e731907ba823, 0, self.origin, self.lookaheaddist];
  asm_fireevent(asmname, "sharp_turn", turnparams);
  thread waitforpathchange(asmname, statename);
}

function playmoveloop_mp(asmname, statename, params) {
  thread waitforpathchange(asmname, statename);
  rate = 1;

  if(isDefined(self.asm.moveplaybackrate)) {
    rate = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    rate = self.moveplaybackrate;
  }

  function_fb56c9527636713f(asmname, statename, rate);
}

function isfacingenemy(mindot) {
  if(!isDefined(mindot)) {
    mindot = 0.5;
  }

  forward = anglesToForward(self.angles);
  dirtoenemy = vectorNormalize(self.enemy.origin - self.origin);
  dot = vectordot(forward, dirtoenemy);

  if(dot < mindot) {
    return false;
  }

  return true;
}

function isweaponfacingenemy() {
  if(isaimedataimtarget()) {
    return true;
  }

  return false;
}

function wantstocrouch() {
  if(bb_getrequestedstance() == "crouch") {
    return true;
  }

  return false;
}

function function_71eefa1c0da64a21(shootfrompos) {
  if(!istrue(self._blackboard.shootparams_valid)) {
    return undefined;
  } else if(isDefined(self._blackboard.shootparams_ent)) {
    return self._blackboard.shootparams_ent getshootatpos();
  } else if(isDefined(self._blackboard.shootparams_pos)) {
    return self._blackboard.shootparams_pos;
  } else if(isDefined(self.enemy)) {
    return self.enemy getshootatpos();
  }

  return undefined;
}

function isaimedataimtarget() {
  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent)) {
    return true;
  }

  weaponangles = self getmuzzleangle();
  shootfrompos = self getshootfrompos();
  shootpos = function_71eefa1c0da64a21(shootfrompos);

  if(!isDefined(shootpos)) {
    return false;
  }

  var_17ffbc15989cd7cb = vectortoangles(shootpos - shootfrompos);
  absyawdiff = absangleclamp180(weaponangles[1] - var_17ffbc15989cd7cb[1]);

  if(absyawdiff > anim.aimyawdifffartolerance) {
    if(distancesquared(self getEye(), shootpos) > anim.aimyawdiffclosedistsq || absyawdiff > anim.aimyawdiffclosetolerance) {}
  }

  aimpitchdifftolerance = getaimpitchdifftolerance();
  return absangleclamp180(weaponangles[0] - var_17ffbc15989cd7cb[0]) <= aimpitchdifftolerance;
}

function getaimpitchdifftolerance() {
  if(isDefined(self.aimpitchdifftolerance)) {
    return self.aimpitchdifftolerance;
  }

  return anim.aimpitchdifftolerance;
}

function delayslowmotion(delay, start, end, time) {}

function delaymodifybasefov(delay, fov, time) {}

function animscriptmp(archetype, statename, aliasname, loop, playbackrate, customendon, scriptednode, tag) {
  if(isDefined(customendon)) {
    thread animscriptmp_watchcancel(customendon);
  }

  if(istrue(loop)) {
    thread animscriptmp_loop_internal(archetype, statename, aliasname, playbackrate, scriptednode, tag);
    return;
  }

  thread animscriptmp_single_internal(archetype, statename, aliasname, playbackrate, scriptednode, tag);
}

function cancelanimscriptmp() {
  if(!scripts\asm\asm_bb::bb_isanimScripted()) {
    return 0;
  }

  cancelanimscriptmp_internal();
  self notify("CancelAnimscriptMP");
}

function animscriptmp_watchcancel(customendon) {
  self endon("AnimscriptMP_Complete");
  self endon("death");
  self endon("CancelAnimscriptMP");
  self waittill(customendon);
  cancelanimscriptmp();
}

function animscriptmp_single_internal(archetype, statename, aliasname, playbackrate, scriptnode, tag) {
  animscriptmp_internal(archetype, statename, aliasname, playbackrate, scriptnode, tag);
  var_e1940c994503c932 = isDefined(playbackrate) && playbackrate == 0;

  if(!var_e1940c994503c932 && isDefined(self) && isalive(self)) {
    cancelanimscriptmp_internal();
    self notify("AnimscriptMP_Complete");
    self notify("single anim", "end");
    self notify("looping anim", "end");
  }
}

function animscriptmp_loop_internal(archetype, statename, aliasname, playbackrate, scriptnode, tag) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  while(true) {
    animscriptmp_internal(archetype, statename, aliasname, playbackrate, scriptnode, tag);
  }
}

function private function_7618d8f3ba2fbcea(xanim, scriptnode, tag, animindex) {
  if(isDefined(tag)) {
    assert(isent(scriptnode));
    startpos = scriptnode gettagorigin(tag);
    startangles = scriptnode gettagangles(tag);
  } else {
    startpos = scriptnode.origin;
    startangles = scriptnode.angles;
  }

  animstartpos = getstartorigin(startpos, startangles, xanim);
  animstartangles = getstartangles(startpos, startangles, xanim);
  self dontinterpolate();
  self forceteleport(animstartpos, animstartangles, 9999999, 0);
}

function animscriptmp_internal(archetype, statename, aliasname, playbackrate, scriptnode, tag) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  if(!isDefined(playbackrate)) {
    playbackrate = 1;
  }

  self setoverridearchetype("animscript", archetype, 1);
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = archetypegetrandomalias(archetype, statename, aliasname, asm_isfrantic());
  xanim = animsetgetanimfromindex(archetype, statename, animindex);

  if(isDefined(scriptnode)) {
    function_7618d8f3ba2fbcea(xanim, scriptnode, tag, animindex);
  }

  self aisetanim(statename, animindex, playbackrate);
  self aisetanimrate(statename, animindex, playbackrate);
  animlength = getanimlength(xanim);
  self.scripted_mode = 1;
  self.ignoreall = 1;

  if(playbackrate > 0) {
    wait animlength / playbackrate;
  }
}

function cancelanimscriptmp_internal() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  self scriptedanimfinished();
  self clearoverridearchetype("animscript", 0, 0);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

function animscripted_single(aliasname, var_1a11aea0c900b403, statename) {
  scripts\asm\asm_mp::asm_setanimScripted();

  if(!isDefined(statename)) {
    statename = "animscripted";
  }

  animindex = asm_lookupanimfromalias(statename, aliasname);
  self aisetanim(statename, animindex);

  if(!isDefined(var_1a11aea0c900b403)) {
    var_1a11aea0c900b403 = 0;
  }

  if(!var_1a11aea0c900b403) {
    xanim = asm_getxanim(statename, animindex);
    animlength = getanimlength(xanim);
    wait animlength;
  }
}

function function_dd94e74da0ad6ead(aliasname, statename) {
  scripts\asm\asm_mp::asm_setanimScripted();

  if(!isDefined(statename)) {
    statename = "animscripted";
  }

  animindex = asm_lookupanimfromalias(statename, aliasname);
  self aisetanim(statename, animindex, 0);
}

function animscripted_single_earlyend(aliasname, time) {
  assert(time > 0);
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  self aisetanim("animscripted", animindex);
  xanim = asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(time < animlength) {
    wait animlength - time;
  }
}

function animscripted_loop(aliasname) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05) {
    animlength = 0.05;
  }

  while(true) {
    self aisetanim("animscripted", animindex);
    wait animlength;
  }
}

function animscripted_loop_earlyend(aliasname, time) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(time < animlength) {
    animlength -= time;
  }

  if(animlength < 0.05) {
    animlength = 0.05;
  }

  while(true) {
    self aisetanim("animscripted", animindex);
    wait animlength;
  }
}

function animscripted_loop_for_time(aliasname, time) {
  assert(time > 0);
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05) {
    animlength = 0.05;
  }

  timeremaining = time;

  while(timeremaining >= 0) {
    self aisetanim("animscripted", animindex);
    wait animlength;
    timeremaining -= animlength;
  }
}

function animscripted_loop_n_times(aliasname, numloops) {
  assert(numloops);
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);

  if(animlength < 0.05) {
    animlength = 0.05;
  }

  while(numloops > 0) {
    self aisetanim("animscripted", animindex);
    wait animlength;
    numloops--;
  }
}

function animscripted_loop_relative(aliasname, ent, tag) {
  self endon("death");
  assert(isDefined(ent));
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  function_7618d8f3ba2fbcea(xanim, ent, tag, animindex);

  while(true) {
    if(!istrue(self._blackboard.animscriptedactive)) {
      return;
    }

    self aisetanim("animscripted", animindex);
    animlength = getanimlength(xanim);
    wait animlength;
  }
}

function animscripted_single_relative(aliasname, ent, tag, var_1a11aea0c900b403, statename) {
  assert(isDefined(ent));

  if(!isDefined(statename)) {
    statename = "animscripted";
  }

  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias(statename, aliasname);
  xanim = asm_getxanim(statename, animindex);
  function_7618d8f3ba2fbcea(xanim, ent, tag, animindex);
  self aisetanim(statename, animindex);

  if(!isDefined(var_1a11aea0c900b403)) {
    var_1a11aea0c900b403 = 0;
  }

  if(!var_1a11aea0c900b403) {
    animlength = getanimlength(xanim);
    wait animlength;
  }
}

function animscripted_single_arrive_at(aliasname, pos, angles, var_1a11aea0c900b403) {
  scripts\asm\asm_mp::asm_setanimScripted();
  animindex = asm_lookupanimfromalias("animscripted", aliasname);
  xanim = asm_getxanim("animscripted", animindex);
  animdelta = getmovedelta(xanim);
  animangles = getangledelta3d(xanim);
  startangles = combineangles(angles, invertangles(animangles));
  startpos = pos - rotatevector(animdelta, startangles);
  self dontinterpolate();
  self forceteleport(startpos, startangles, 9999999, 0);
  self aisetanim("animscripted", animindex);

  if(!isDefined(var_1a11aea0c900b403)) {
    var_1a11aea0c900b403 = 0;
  }

  if(!var_1a11aea0c900b403) {
    animlength = getanimlength(xanim);
    wait animlength;
  }
}

function animscripted_clear() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  self scriptedanimfinished();
}

function function_8fa69650e33c84ef(anime) {
  if(!isDefined(level.scr_anim) || !isDefined(self.animname) || !isDefined(level.scr_anim[self.animname]) || !isDefined(level.scr_anim[self.animname][anime])) {
    return false;
  }

  return true;
}

function animscriptedagent(anime, anim_string, org, animangles, anim_flag) {
  self endon("death");

  if(isstring(anim_flag)) {
    ent_flag_set(anim_flag);
  }

  aliasname = level.scr_anim[self.animname][anime];
  callback_name = anime + "_animscripted";
  callback::callback(callback_name);

  if(isDefined(org)) {
    anim_node = spawnStruct();
    anim_node.origin = org;
    anim_node.angles = animangles;
    scripts\asm\shared\mp\utility::animscripted_single_relative(aliasname, anim_node);
  } else {
    scripts\asm\shared\mp\utility::animscripted_single(aliasname);
  }

  scripts\asm\shared\mp\utility::animscripted_clear();
  self notify(anim_string, "end");

  if(isstring(anim_flag)) {
    ent_flag_clear(anim_flag);
  }
}

function function_8efc1cbdaa97f95e(anime) {
  spawn_anim = scripts\asm\asm::asm_lookupanimfromalias("animscripted", level.scr_anim[self.animname][anime]);
  spawn_xanim = animsetgetanimfromindex(scripts\asm\shared\utility::function_2285421dfc79c4d5(), "animscripted", spawn_anim);
  var_7d881d4e81293ae5 = getmovedelta(spawn_xanim, 0, 1);
  return var_7d881d4e81293ae5;
}

function ai_anim_first_frame(animation, animname) {
  level_archetype = "agent_scripted_" + getDvar(@ "g_mapname");
  aliasname = getanimname(animation);

  if(archetypeassetloaded(level_archetype)) {
    thread scripts\asm\shared\mp\utility::animscriptmp(level_archetype, "animscripted", aliasname, undefined, 0);
    return;
  }

  statename = "animscripted";
  thread scripts\asm\shared\mp\utility::function_dd94e74da0ad6ead(aliasname, statename);
}