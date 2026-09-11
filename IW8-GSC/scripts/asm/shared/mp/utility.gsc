/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\utility.gsc
***********************************************/

function dotraversal() {
  self endon("killanimscript");
  var_0 = self getnegotiationstartnode();
  var_1 = var_0.animscript;
  self notify("traverse_begin", var_1, var_0);
  self waittill("traverse_end");
}

function chooseanimwithoverride(var_0, var_1, var_2) {
  return false;
}

function loopanimfortime(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("terminate_ai_threads");
  var_3 = "loop_end";
  var_4 = 2;

  if(isarray(var_2)) {
    if(var_2.size > 0) {
      var_4 = var_2[0];
    }

    if(var_2.size > 1) {
      var_3 = var_2[1];
    }
  } else {
    var_4 = var_2;
  }

  thread scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
  wait var_4;
  scripts\asm\asm::asm_fireevent(var_0, var_3);
}

function waitforcoverapproach_mp(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(self islegacyagent()) {
    self requeststopsoonnotify();
    self waittill("stop_soon");
    self.approachdir = self.lookaheaddir;
    scripts\asm\asm::asm_fireevent(var_0, "cover_approach", self.approachdir);
    return;
  }
}

function waitforpathchange(var_0, var_1) {
  self endon(var_1 + "_finished");
  self waittill("path_set");
  var_2 = self.origin + self.lookaheaddir * self.lookaheaddist;
  var_3 = [0, var_2, 1, self.origin, self.lookaheaddist];
  scripts\asm\asm::asm_fireevent(var_0, "sharp_turn", var_3);
  thread waitforpathchange(var_0, var_1);
}

function waitforsharpturn_mp(var_0, var_1, var_2) {}

function playmoveloop_mp(var_0, var_1, var_2) {
  thread waitforcoverapproach_mp(var_0, var_1);

  if(self islegacyagent()) {
    thread waitforsharpturn_mp(var_0, var_1);
  } else {
    thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  }

  thread waitforpathchange(var_0, var_1);
  var_3 = 1;

  if(isDefined(self.asm.moveplaybackrate)) {
    var_3 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_3 = self.moveplaybackrate;
  }

  scripts\asm\asm::asm_loopanimstate(var_0, var_1, var_3);
}

function isfacingenemy(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = vectorNormalize(self.enemy.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 < var_0) {
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
  if(scripts\asm\asm_bb::bb_getrequestedstance() == "crouch") {
    return true;
  }

  return false;
}

function getshootpos(var_0) {
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

  var_0 = self getmuzzleangle();
  var_1 = scripts\asm\shared\utility::getshootfrompos();
  var_2 = getshootpos(var_1);

  if(!isDefined(var_2)) {
    return false;
  }

  var_3 = vectortoangles(var_2 - var_1);
  var_4 = scripts\engine\utility::absangleclamp180(var_0[1] - var_3[1]);

  if(var_4 > anim.aimyawdifffartolerance) {
    if(distancesquared(self getEye(), var_2) > anim.aimyawdiffclosedistsq || var_4 > anim.aimyawdiffclosetolerance) {}
  }

  var_5 = getaimpitchdifftolerance();
  return scripts\engine\utility::absangleclamp180(var_0[0] - var_3[0]) <= var_5;
}

function getaimpitchdifftolerance() {
  if(isDefined(self.aimpitchdifftolerance)) {
    return self.aimpitchdifftolerance;
  }

  return anim.aimpitchdifftolerance;
}

function delayslowmotion(var_0, var_1, var_2, var_3) {}

function delaymodifybasefov(var_0, var_1, var_2) {}

function animscriptmp(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    thread animscriptmp_watchcancel(var_5);
  }

  if(istrue(var_3)) {
    thread animscriptmp_loop_internal(var_0, var_1, var_2, var_4);
    return;
  }

  thread animscriptmp_single_internal(var_0, var_1, var_2, var_4);
}

function cancelanimscriptmp() {
  if(!scripts\asm\asm_bb::bb_isanimScripted()) {
    return 0;
  }

  cancelanimscriptmp_internal();
  self notify("CancelAnimscriptMP");
}

function animscriptmp_watchcancel(var_0) {
  self endon("AnimscriptMP_Complete");
  self endon("death");
  self endon("CancelAnimscriptMP");
  self waittill(var_0);
  cancelanimscriptmp();
}

function animscriptmp_single_internal(var_0, var_1, var_2, var_3) {
  animscriptmp_internal(var_0, var_1, var_2, var_3);

  if(isDefined(self) && isalive(self)) {
    cancelanimscriptmp_internal();
    self notify("AnimscriptMP_Complete");
    return;
  }
}

function animscriptmp_loop_internal(var_0, var_1, var_2, var_3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  for(;;) {
    animscriptmp_internal(var_0, var_1, var_2, var_3);
  }
}

function animscriptmp_internal(var_0, var_1, var_2, var_3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  scripts\asm\shared\utility::setoverridearchetype("animscript", var_0, 1);
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_4 = archetypegetrandomalias(var_0, var_1, var_2, scripts\asm\asm::asm_isfrantic());
  self aisetanim(var_1, var_4, var_3);
  self aisetanimrate(var_1, var_4, var_3);
  var_5 = animsetgetallanimindicesforalias(var_0, var_1, var_4);
  var_6 = getanimlength(var_5);
  self.scripted_mode = 1;
  self.ignoreall = 1;
  wait var_6 / var_3;
}

function cancelanimscriptmp_internal() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  scripts\asm\shared\utility::clearoverridearchetype("animscript", 0, 0);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

function burndowntime(var_0, var_1, var_2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();

  if(!isDefined(var_2)) {
    var_2 = "animscripted";
  }

  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_0);
  self aisetanim(var_2, var_3);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    var_4 = scripts\asm\asm::asm_getxanim(var_2, var_3);
    var_5 = getanimlength(var_4);
    wait var_5;
    return;
  }
}

function burningdown(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  self aisetanim("animscripted", var_2);
  var_3 = scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(var_3);

  if(var_1 < var_4) {
    wait var_4 - var_1;
    return;
  }
}

function bunkerinteriorkeypads(var_0) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_1 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_2 = scripts\asm\asm::asm_getxanim("animscripted", var_1);
  var_3 = getanimlength(var_2);

  if(var_3 < 0.05) {
    var_3 = 0.05;
  }

  for(;;) {
    self aisetanim("animscripted", var_1);
    wait var_3;
  }
}

function bunkermusicstarted(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(var_3);

  if(var_1 < var_4) {
    var_4 -= var_1;
  }

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  for(;;) {
    self aisetanim("animscripted", var_2);
    wait var_4;
  }
}

function bunkernum(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(var_3);

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  var_5 = var_1;

  while(var_5 >= 0) {
    self aisetanim("animscripted", var_2);
    wait var_4;
    var_5 -= var_4;
  }
}

function bunkeropened(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(var_3);

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  while(var_1 > 0) {
    self aisetanim("animscripted", var_2);
    wait var_4;
    var_1--;
  }
}

function bunkervaults(var_0, var_1, var_2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_4 = scripts\asm\asm::asm_getxanim("animscripted", var_3);

  if(isDefined(var_2)) {
    var_5 = var_1 gettagorigin(var_2);
    var_6 = var_1 gettagangles(var_2);
  } else {
    var_5 = var_3.origin;
    var_6 = var_3.angles;
  }

  var_7 = getstartorigin(var_5, var_6, var_6);
  var_8 = getstartangles(var_5, var_6, var_6);
  self dontinterpolate();
  self forceteleport(var_7, var_8, 9999999, 0);

  for(;;) {
    self aisetanim("animscripted", var_5);
    var_9 = getanimlength(var_6);
    wait var_9;
  }
}

function burningpartlogic(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = "animscripted";
  }

  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_4, var_0);
  var_6 = scripts\asm\asm::asm_getxanim(var_4, var_5);

  if(isDefined(var_2)) {
    var_7 = var_1 gettagorigin(var_2);
    var_8 = var_1 gettagangles(var_2);
  } else {
    var_7 = var_3.origin;
    var_8 = var_3.angles;
  }

  var_9 = getstartorigin(var_7, var_8, var_8);
  var_10 = getstartangles(var_7, var_8, var_8);
  self dontinterpolate();
  self forceteleport(var_9, var_10, 9999999, 0);
  self aisetanim(var_6, var_7);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!var_5) {
    var_11 = getanimlength(var_8);
    wait var_11;
    return;
  }
}

function burnfxstates(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_4 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_5 = scripts\asm\asm::asm_getxanim("animscripted", var_4);
  var_6 = getmovedelta(var_5);
  var_7 = getangledelta3d(var_5);
  var_8 = combineangles(var_2, invertangles(var_7));
  var_9 = var_1 - rotatevector(var_6, var_8);
  self dontinterpolate();
  self forceteleport(var_9, var_8, 9999999, 0);
  self aisetanim("animscripted", var_4);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    var_10 = getanimlength(var_5);
    wait var_10;
    return;
  }
}

function bunkercounteruav() {
  scripts\asm\asm_bb::bb_clearanimScripted();
}