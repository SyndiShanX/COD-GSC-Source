/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\utility.gsc
***********************************************/

function dotraversal() {
  self endon("killanimscript");
  var0 = self getnegotiationstartnode();
  var1 = var0.animscript;
  self notify("traverse_begin", var1, var0);
  self waittill("traverse_end");
}

function chooseanimwithoverride(var0, var1, var2) {
  return false;
}

function loopanimfortime(var0, var1, var2) {
  self endon(var1 + "_finished");
  self endon("terminate_ai_threads");
  var3 = "loop_end";
  var4 = 2;

  if(isarray(var2)) {
    if(var2.size > 0) {
      var4 = var2[0];
    }

    if(var2.size > 1) {
      var3 = var2[1];
    }
  } else {
    var4 = var2;
  }

  thread scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
  wait var4;
  scripts\asm\asm::asm_fireevent(var0, var3);
}

function waitforcoverapproach_mp(var0, var1) {
  self endon(var1 + "_finished");

  if(self islegacyagent()) {
    self requeststopsoonnotify();
    self waittill("stop_soon");
    self.approachdir = self.lookaheaddir;
    scripts\asm\asm::asm_fireevent(var0, "cover_approach", self.approachdir);
    return;
  }
}

function waitforpathchange(var0, var1) {
  self endon(var1 + "_finished");
  self waittill("path_set");
  var2 = self.origin + self.lookaheaddir * self.lookaheaddist;
  var3 = [0, var2, 1, self.origin, self.lookaheaddist];
  scripts\asm\asm::asm_fireevent(var0, "sharp_turn", var3);
  thread waitforpathchange(var0, var1);
}

function waitforsharpturn_mp(var0, var1, var2) {}

function playmoveloop_mp(var0, var1, var2) {
  thread waitforcoverapproach_mp(var0, var1);

  if(self islegacyagent()) {
    thread waitforsharpturn_mp(var0, var1);
  } else {
    thread scripts\asm\shared\utility::waitforsharpturn(var0, var1);
  }

  thread waitforpathchange(var0, var1);
  var3 = 1;

  if(isDefined(self.asm.moveplaybackrate)) {
    var3 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var3 = self.moveplaybackrate;
  }

  scripts\asm\asm::asm_loopanimstate(var0, var1, var3);
}

function isfacingenemy(var0) {
  if(!isDefined(var0)) {
    var0 = 0.5;
  }

  var1 = anglesToForward(self.angles);
  var2 = vectorNormalize(self.enemy.origin - self.origin);
  var3 = vectordot(var1, var2);

  if(var3 < var0) {
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

function getshootpos(var0) {
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

  var0 = self getmuzzleangle();
  var1 = scripts\asm\shared\utility::getshootfrompos();
  var2 = getshootpos(var1);

  if(!isDefined(var2)) {
    return false;
  }

  var3 = vectortoangles(var2 - var1);
  var4 = scripts\engine\utility::absangleclamp180(var0[1] - var3[1]);

  if(var4 > anim.aimyawdifffartolerance) {
    if(distancesquared(self getEye(), var2) > anim.aimyawdiffclosedistsq || var4 > anim.aimyawdiffclosetolerance) {}
  }

  var5 = getaimpitchdifftolerance();
  return scripts\engine\utility::absangleclamp180(var0[0] - var3[0]) <= var5;
}

function getaimpitchdifftolerance() {
  if(isDefined(self.aimpitchdifftolerance)) {
    return self.aimpitchdifftolerance;
  }

  return anim.aimpitchdifftolerance;
}

function delayslowmotion(var0, var1, var2, var3) {}

function delaymodifybasefov(var0, var1, var2) {}

function animscriptmp(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var5)) {
    thread animscriptmp_watchcancel(var5);
  }

  if(istrue(var3)) {
    thread animscriptmp_loop_internal(var0, var1, var2, var4);
    return;
  }

  thread animscriptmp_single_internal(var0, var1, var2, var4);
}

function cancelanimscriptmp() {
  if(!scripts\asm\asm_bb::bb_isanimScripted()) {
    return 0;
  }

  cancelanimscriptmp_internal();
  self notify("CancelAnimscriptMP");
}

function animscriptmp_watchcancel(var0) {
  self endon("AnimscriptMP_Complete");
  self endon("death");
  self endon("CancelAnimscriptMP");
  self waittill(var0);
  cancelanimscriptmp();
}

function animscriptmp_single_internal(var0, var1, var2, var3) {
  animscriptmp_internal(var0, var1, var2, var3);

  if(isDefined(self) && isalive(self)) {
    cancelanimscriptmp_internal();
    self notify("AnimscriptMP_Complete");
    return;
  }
}

function animscriptmp_loop_internal(var0, var1, var2, var3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  for(;;) {
    animscriptmp_internal(var0, var1, var2, var3);
  }
}

function animscriptmp_internal(var0, var1, var2, var3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  if(!isDefined(var3)) {
    var3 = 1;
  }

  scripts\asm\shared\utility::setoverridearchetype("animscript", var0, 1);
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var4 = archetypegetrandomalias(var0, var1, var2, scripts\asm\asm::asm_isfrantic());
  self aisetanim(var1, var4, var3);
  self aisetanimrate(var1, var4, var3);
  var5 = animsetgetallanimindicesforalias(var0, var1, var4);
  var6 = getanimlength(var5);
  self.scripted_mode = 1;
  self.ignoreall = 1;
  wait var6 / var3;
}

function cancelanimscriptmp_internal() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  scripts\asm\shared\utility::clearoverridearchetype("animscript", 0, 0);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

function burndowntime(var0, var1, var2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();

  if(!isDefined(var2)) {
    var2 = "animscripted";
  }

  var3 = scripts\asm\asm::asm_lookupanimfromalias(var2, var0);
  self aisetanim(var2, var3);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!var1) {
    var4 = scripts\asm\asm::asm_getxanim(var2, var3);
    var5 = getanimlength(var4);
    wait var5;
    return;
  }
}

function burningdown(var0, var1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  self aisetanim("animscripted", var2);
  var3 = scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(var3);

  if(var1 < var4) {
    wait var4 - var1;
    return;
  }
}

function bunkerinteriorkeypads(var0) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var1 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var2 = scripts\asm\asm::asm_getxanim("animscripted", var1);
  var3 = getanimlength(var2);

  if(var3 < 0.05) {
    var3 = 0.05;
  }

  for(;;) {
    self aisetanim("animscripted", var1);
    wait var3;
  }
}

function bunkermusicstarted(var0, var1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var3 = scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(var3);

  if(var1 < var4) {
    var4 -= var1;
  }

  if(var4 < 0.05) {
    var4 = 0.05;
  }

  for(;;) {
    self aisetanim("animscripted", var2);
    wait var4;
  }
}

function bunkernum(var0, var1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var3 = scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(var3);

  if(var4 < 0.05) {
    var4 = 0.05;
  }

  var5 = var1;

  while(var5 >= 0) {
    self aisetanim("animscripted", var2);
    wait var4;
    var5 -= var4;
  }
}

function bunkeropened(var0, var1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var3 = scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(var3);

  if(var4 < 0.05) {
    var4 = 0.05;
  }

  while(var1 > 0) {
    self aisetanim("animscripted", var2);
    wait var4;
    var1--;
  }
}

function bunkervaults(var0, var1, var2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var3 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var4 = scripts\asm\asm::asm_getxanim("animscripted", var3);

  if(isDefined(var2)) {
    var5 = var1 gettagorigin(var2);
    var6 = var1 gettagangles(var2);
  } else {
    var5 = var3.origin;
    var6 = var3.angles;
  }

  var7 = getstartorigin(var5, var6, var6);
  var8 = getstartangles(var5, var6, var6);
  self dontinterpolate();
  self forceteleport(var7, var8, 9999999, 0);

  for(;;) {
    self aisetanim("animscripted", var5);
    var9 = getanimlength(var6);
    wait var9;
  }
}

function burningpartlogic(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = "animscripted";
  }

  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var5 = scripts\asm\asm::asm_lookupanimfromalias(var4, var0);
  var6 = scripts\asm\asm::asm_getxanim(var4, var5);

  if(isDefined(var2)) {
    var7 = var1 gettagorigin(var2);
    var8 = var1 gettagangles(var2);
  } else {
    var7 = var3.origin;
    var8 = var3.angles;
  }

  var9 = getstartorigin(var7, var8, var8);
  var10 = getstartangles(var7, var8, var8);
  self dontinterpolate();
  self forceteleport(var9, var10, 9999999, 0);
  self aisetanim(var6, var7);

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!var5) {
    var11 = getanimlength(var8);
    wait var11;
    return;
  }
}

function burnfxstates(var0, var1, var2, var3) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var4 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var0);
  var5 = scripts\asm\asm::asm_getxanim("animscripted", var4);
  var6 = getmovedelta(var5);
  var7 = getangledelta3d(var5);
  var8 = combineangles(var2, invertangles(var7));
  var9 = var1 - rotatevector(var6, var8);
  self dontinterpolate();
  self forceteleport(var9, var8, 9999999, 0);
  self aisetanim("animscripted", var4);

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!var3) {
    var10 = getanimlength(var5);
    wait var10;
    return;
  }
}

function bunkercounteruav() {
  scripts\asm\asm_bb::bb_clearanimScripted();
}