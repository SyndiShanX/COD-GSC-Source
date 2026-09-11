/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\patrol.gsc
***********************************************/

function patrol_reactendswithmove(var0, var1, var2, var3) {
  return length(self.velocity) > 1;
}

function patrol_shouldreact(var0, var1, var2, var3) {
  if(!isDefined(self.stealth) || !isDefined(self.stealth.patrol_react_magnitude) || !isDefined(self.stealth.patrol_react_time)) {
    return false;
  }

  var4 = 200;

  if(gettime() > self.stealth.patrol_react_time + var4) {
    return false;
  }

  if(isDefined(self.stealth.investigateevent)) {
    self glanceatpos(self.stealth.investigateevent.origin);
  }

  return true;
}

function patrol_shouldcombatrereact(var0, var1, var2, var3) {
  if(!isDefined(self.stealth) || !isDefined(self.enemy)) {
    return false;
  }

  if(scripts\asm\asm::asm_getdemeanor() == "combat" && self cansee(self.enemy)) {
    self.stealth.patrol_react_magnitude = "med";
    self.stealth.patrol_react_pos = self.enemy.origin;
    self.stealth.patrol_react_time = gettime();
    return true;
  }

  return false;
}

function playanim_patrolreact(var0, var1, var2) {
  self endon(var1 + "_finished");
  playanim_patrolreact_internal(var0, var1, var1);
}

function playanim_patrolreact_internal(var0, var1, var2) {
  self.stealth.breacting = self.stealth.patrol_react_magnitude;

  if(shouldpatrolreactaim()) {
    if(distance2dsquared(self.origin, self.stealth.patrol_react_pos) > 1024) {
      self setlookat(self.stealth.patrol_react_pos);
    }
  }

  var3 = self asmgetanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var2, var3);
  var5 = 1;

  if(isDefined(self.stealth.reactendtime)) {
    var6 = 1;
    var7 = getnotetracktimes(var4, "code_move");

    if(var7.size > 0) {
      var6 = var7[0];
    }

    var8 = getanimlength(var4) * var6;
    var9 = 0.05 + (self.stealth.reactendtime - gettime()) / 1000;

    if(var9 < 0.2) {
      var9 = 0.2;
    }

    var5 = clamp(var8 / var9, 0.8, 1.3);
    self.stealth.reactendtime = undefined;
  }

  self aisetanim(var2, var3, var5);
  self.stealth.patrol_react_magnitude = undefined;
  self.stealth.patrol_react_time = undefined;
  scripts\asm\asm::asm_donotetrackswithinterceptor(var0, var1, &flashlightreactionnotehandler, undefined, var2);
}

function shouldpatrolreactaim(var0, var1, var2, var3) {
  return self.stealth.patrol_react_magnitude == "large" || self.stealth.patrol_react_magnitude == "med" || self.stealth.patrol_react_magnitude == "smed";
}

function shouldpatrolreactlookaround(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_getdemeanor() == "combat" && !isDefined(self.enemy) && self[[self.fnisinstealthcombat]]();
}

function shouldpatrolreactlookaroundabort(var0, var1, var2, var3) {
  return isDefined(self.enemy);
}

function chooseanim_patrolreactlookaround(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, scripts\engine\utility::string(getpatrolreactdirindex()));
}

function chooseanim_patrolreactlookaround_checkflashlight(var0, var1, var2) {
  var3 = scripts\engine\utility::string(getpatrolreactdirindex());
  return chooseanim_patrol_checkflashlight(var0, var1, var3);
}

function getpatrolreactdirindex() {
  var0 = 0;

  if(isDefined(self.stealth.patrol_react_pos)) {
    var1 = self.stealth.patrol_react_pos - self.origin;

    if(length2dsquared(var1) < 36) {
      var0 = 0;
    } else {
      var2 = vectortoyaw(var1);
      var0 = self.angles[1] - var2;
    }
  }

  return getreactangleindex(var0);
}

function getpatrolreactalias() {
  var0 = getpatrolreactdirindex();
  var1 = self.stealth.patrol_react_magnitude + "_" + var0;
  return var1;
}

function chooseanim_patrolreact(var0, var1, var2) {
  var3 = getpatrolreactalias();
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function chooseanim_patrolreact_checkflashlight(var0, var1, var2) {
  var3 = getpatrolreactalias();
  return chooseanim_patrol_checkflashlight(var0, var1, var3);
}

function patrolreact_terminate(var0, var1, var2) {
  self.stealth.breacting = undefined;
  self stoplookat();
}

function getreactangleindex(var0) {
  var0 = angleclamp180(var0);

  if(var0 > 135 || var0 < -135) {
    var1 = 2;
  } else if(var1 < -45) {
    var1 = 4;
  } else if(var1 > 45) {
    var1 = 6;
  } else {
    var1 = 8;
  }

  return var1;
}

function handlefacegoalnotetrack(var0, var1, var2) {
  if(var1 == "face_goal" && isDefined(self.stealth.patrol_react_pos)) {
    var3 = self.stealth.patrol_react_pos - self.origin;
    var4 = vectortoyaw(var3);
    thread facegoalthread(var0, var4);
    return true;
  }

  return false;
}

function facegoalthread(var0, var1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var0 + "_finished");

  for(;;) {
    var2 = 1;
    var3 = self.enemy;

    if(!isDefined(var3)) {
      if(isDefined(self.stealth.investgate_entity) && isPlayer(self.stealth.investigate_entity)) {
        var3 = self.stealth.investigate_entity;
      }
    }

    if(isDefined(var3) && isPlayer(var3) && distance(self.origin, var3.origin) <= 200) {
      var2 = 0;
    }

    var4 = 0.25;

    if(isDefined(var3) && issentient(var3)) {
      if(!var2 || var2 && self cansee(var3)) {
        var5 = var3.origin - self.origin;
        var1 = vectortoyaw(var5);
        var4 = 0.5;
      }
    }

    var6 = angleclamp180(var1 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var6 * var4);
    waitframe();
  }
}

function patrol_playanim_randomrate(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = randomfloatrange(0.8, 1.2);
  self aisetanim(var1, var3, var4);
  scripts\asm\asm::asm_playfacialanim(var0, var1, scripts\asm\asm::asm_getxanim(var1, var3));
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function patrol_getstationaryturnangle() {
  if(isDefined(self._blackboard.idlenode)) {
    return angleclamp180(self._blackboard.idlenode.angles[1] - self.angles[1]);
  } else if(isDefined(self.patrol_custom_face_angle)) {
    return angleclamp180(self.patrol_custom_face_angle - self.angles[1]);
  } else if(isDefined(self._blackboard.bfacesomedecentdirectionwhenidle)) {
    var0 = makeweapon(self.origin, 256, 96);

    if(isDefined(var0)) {
      var1 = angleclamp180(vectortoyaw(var0) - self.angles[1]);
      return var1;
    }
  }

  return undefined;
}

function patrol_shoulddostationaryturn(var0, var1, var2, var3) {
  var4 = patrol_getstationaryturnangle();
  var5 = isDefined(var4) && abs(var4) > 10;
  self.desiredturnyaw = var4;
  return var5;
}

function patrol_choosestationaryturnanim(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(self.desiredturnyaw)) {
    var3 = self.desiredturnyaw;
  }

  if(!isDefined(var3)) {
    var4 = "8";
  } else if(var4 < -135) {
    var4 = "2r";
  } else if(var4 > 135) {
    var4 = "2l";
  } else if(var4 < -45) {
    var4 = "6";
  } else if(var4 > 45) {
    var4 = "4";
  } else {
    var4 = "8";
  }

  var5 = scripts\asm\asm::asm_lookupanimfromalias(var4, var4);
  return var5;
}

function patrol_playanim_idle(var0, var1, var2) {
  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function handlestationaryturnfacegoalnotetrack(var0, var1) {
  if(var0 == "face_goal" && isDefined(self.desiredturnyaw) && isDefined(var1.statename)) {
    var2 = getnotetracktimes(var1.xanim, "face_goal_end");
    var3 = undefined;

    if(!isDefined(var2)) {
      return undefined;
    }

    var4 = getanimlength(var1.xanim);
    var5 = self getanimtime(var1.xanim);
    var3 = var2[0] - var5;
    var6 = getangledelta(var1.xanim, 0, 1);
    var7 = angleclamp180(self.desiredturnyaw - var6);
    var3 *= var4;
    thread patrol_stationaryturnfixupthread(var1.statename, var7, var3);
  } else if(var0 == "end") {
    return 0;
  }

  return undefined;
}

function patrol_stationaryturnfixupthread(var0, var1, var2) {
  self notify("FaceYawThread");
  self endon("FaceYawThread");
  self endon("death");
  self endon(var0 + "_finished");
  var3 = var2 * 1000 / level.frameduration;
  var4 = var1 / var3;

  while(var3 >= 0) {
    self orientmode("face angle", angleclamp(self.angles[1] + var4));
    var3 -= 1;
    waitframe();
  }
}

function patrol_playanim_idlestationaryturn(var0, var1, var2) {
  self endon(var1 + "_finished");
  scripts\common\gameskill::didsomethingotherthanshooting();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy)) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle 3d", self.angles);
  }

  if(isDefined(self.node)) {
    self animmode("angle deltas");
  } else {
    self animmode("zonly_physics");
  }

  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self.stepoutyaw = angleclamp180(getangledelta(var4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var5 = 1;
  self aisetanim(var1, var3, var5);
  var6 = spawnStruct();
  var6.xanim = var4;
  var6.statename = var1;
  scripts\asm\asm::asm_donotetracks(var0, var1, &handlestationaryturnfacegoalnotetrack, var6);
}

function patrol_shouldarrival_examine(var0, var1, var2, var3) {
  if(!isDefined(self.stealth)) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(!isDefined(self.stealth.bexaminerequested) || !self.stealth.bexaminerequested) {
    return false;
  }

  if(!isDefined(self.stealth.corpse.investigatealias)) {
    var4 = archetypegetaliases(self.asm.archetype, var2);
    self.stealth.corpse.investigatealias = var4[randomint(var4.size)];
  }

  var5 = scripts\asm\asm::asm_lookupanimfromalias(var2, self.stealth.corpse.investigatealias);
  var6 = scripts\asm\asm::asm_getxanim(var2, var5);
  var7 = getmovedelta(var6);
  var8 = length(var7);
  var9 = 12;
  var10 = 12;
  var11 = self.lookaheaddist;

  if(var11 < var8 - var10) {
    return false;
  }

  var12 = self pathdisttogoal();

  if(var12 > var8 + var9) {
    return false;
  }

  if(var12 < var8 - var10) {
    return false;
  }

  var13 = self.pathgoalpos - self.origin;
  var14 = spawnStruct();
  var14.angledelta = 0;
  var14.finalangles = vectortoangles(var13);
  var14.stopanim = var5;
  var14.movedelta = var7;
  var14.startpos = self.pathgoalpos - rotatevector(var7, var14.finalangles);
  self.asm.stopdata = var14;
  return true;
}

function patrol_finisharrival(var0, var1, var2) {
  if(isDefined(self.stealth) && isDefined(self.stealth.corpse)) {
    self.stealth.corpse.investigatealias = undefined;
  }

  self.stealth.bexaminerequested = undefined;
  scripts\asm\soldier\arrival::finisharrival(var0, var1, var2);
}

function patrol_isidlecurious(var0, var1, var2, var3) {
  return isDefined(self.stealth) && isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious;
}

function patrol_isnotidlecurious(var0, var1, var2, var3) {
  return !patrol_isidlecurious(var0, var1, var2, var3);
}

function patrol_playanim_idlecurious(var0, var1, var2) {
  thread patrol_playanim_idlecurious_facelastknownhelper(var1, self.stealth.idlecurioustarget);
  scripts\asm\asm::asm_playanimstate(var0, var1);
}

function patrol_playanim_idlecurious_facelastknownhelper(var0, var1) {
  self endon(var0 + "_finished");

  while(isDefined(var1) && isalive(var1)) {
    var2 = self lastknownpos(var1);
    var3 = var2 - self.origin;
    self orientmode("face angle", vectortoyaw(var3));
    waitframe();
  }
}

function patrol_shouldinvestigatelookaround(var0, var1, var2, var3) {
  return isDefined(self.stealth) && isDefined(self.stealth.binvestigatelookaround) && self.stealth.binvestigatelookaround;
}

function patrol_notshouldinvestigatelookaround(var0, var1, var2, var3) {
  return !patrol_shouldinvestigatelookaround(var0, var1, var2, var3);
}

function patrol_shouldpulloutflashlight(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.bflashlight) || !self._blackboard.bflashlight) {
    return false;
  }

  return !isDefined(self.asm.flashlight) || !self.asm.flashlight;
}

function patrol_shouldputawayflashlight(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight) {
    return false;
  }

  return isDefined(self.asm.flashlight) && self.asm.flashlight;
}

function patrol_magicflashlightdetach(var0, var1, var2) {
  if(isDefined(self.asm.flashlight) && self.asm.flashlight) {
    detachflashlight();
  }

  if(istrue(self._blackboard.bflashlight) && !self.flashlight) {
    self[[self.fnstealthflashlighton]]();
    return;
  }
}

function patrol_magicflashlighton(var0, var1, var2) {
  if(istrue(self._blackboard.bflashlight)) {
    self[[self.fnstealthflashlighton]]();
    return;
  }
}

function chooseanim_patrol_checkflashlight(var0, var1, var2) {
  var3 = var2;

  if(isDefined(self.asm.flashlight) && self.asm.flashlight) {
    var3 = "fl_" + var3;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function patrol_hasflashlightout(var0, var1, var2, var3) {
  return isDefined(self.asm.flashlight) && self.asm.flashlight;
}

function patrol_nothasflashlightout(var0, var1, var2, var3) {
  return !patrol_hasflashlightout(var0, var1, var2, var3);
}

function patrol_playanim_pulloutflashlight(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self.stealth.flashlightxanim = scripts\asm\asm::asm_getxanim(var1, var3);
  var4 = self.moveplaybackrate;

  if(length(self.velocity) < 1) {
    var4 = randomfloatrange(0.8, 1.2);
  }

  self aisetanim(var1, var3, var4);
  self aisetanimrate(var1, var3, var4);
  scripts\asm\asm::asm_playfacialanim(var0, var1, scripts\asm\asm::asm_getxanim(var1, var3));
  var5 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));

  if(var5 == "code_move") {
    var5 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
    return;
  }
}

function flashlightnotehandler(var0) {
  if(var0 == "attach") {
    var1 = 1;

    if(isDefined(self.stealth.flashlightxanim) && self getanimweight(self.stealth.flashlightxanim) > 0) {
      var1 = !animhasnotetrack(self.stealth.flashlightxanim, "flashlight_on");
      self.stealth.flashlightxanim = undefined;
    }

    attachflashlight(var1);
    return;
  }

  if(var0 == "detach") {
    detachflashlight();

    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight) {
      self[[self.fnstealthflashlighton]]();
      return;
    }

    return;
  }

  if(var0 == "flashlight_on") {
    self[[self.fnstealthflashlighton]]();
    return;
  }

  if(var0 == "flashlight_off") {
    self[[self.fnstealthflashlightoff]](0);
    return;
  }
}

function setflashlightmodel(var0) {
  if(isai(self)) {
    detachflashlight();
  }

  self.flashlightmodeloverride = var0;

  if(isai(self) && istrue(self.asm.flashlight)) {
    attachflashlight(1);
    return;
  }
}

function getflashlightmodel() {
  var0 = "attachment_wm_tac_light_held";

  if(isDefined(self.flashlightmodeloverride)) {
    var0 = self.flashlightmodeloverride;
  } else if(isDefined(level.flashlightmodeloverride)) {
    var0 = level.flashlightmodeloverride;
  }

  return var0;
}

function attachflashlight(var0) {
  self[[self.fnstealthflashlightoff]](0);
  var1 = getflashlightmodel();
  self attach(var1, "tag_accessory_left", 1);
  self.flashlightmodel = var1;
  self.asm.flashlight = 1;
  self.flashlightfxoverridetag = "tag_light";

  if(var0) {
    self[[self.fnstealthflashlighton]]();
    return;
  }
}

function detachflashlight() {
  if(!istrue(self.asm.flashlight)) {
    return;
  }

  self[[self.fnstealthflashlightoff]](0);

  if(isDefined(self.flashlightmodel)) {
    self detach(self.flashlightmodel, "tag_accessory_left");
    self.flashlightmodel = undefined;
  }

  self.asm.flashlight = 0;
  self.flashlightfxoverridetag = undefined;
}

function flashlightreactionnotehandler(var0, var1, var2) {
  flashlightnotehandler(var1);
  return handlefacegoalnotetrack(var0, var1);
}

function patrol_idle_setupreaction(var0, var1, var2) {
  if(isDefined(self.stealth.investigateevent)) {
    scripts\common\utility::demeanor_override("alert");
    self.stealth.patrol_react_magnitude = "small";
    self.stealth.patrol_react_pos = self.stealth.investigateevent.investigate_pos;
    self.stealth.patrol_react_time = gettime();
    return;
  }
}

function patrol_movetransition_check(var0, var1, var2, var3) {
  if(isDefined(self.asm.footsteps.foot) && self.asm.footsteps.foot == "right") {
    return false;
  }

  var4 = self pathdisttogoal();

  if(var4 < 96) {
    return false;
  }

  return true;
}

function patrol_shouldusehuntexit(var0, var1, var2, var3) {
  if(!isDefined(self.stealth)) {
    return false;
  }

  return self[[self.fnisinstealthhunt]]() || self[[self.fnisinstealthinvestigate]]();
}

function patrol_needtoturntohuntlookaround(var0, var1, var2, var3) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedsmartobject())) {
    return false;
  }

  if(istrue(self.limitstealthturning)) {
    return false;
  }

  var4 = undefined;

  if(isDefined(self.asm.customdata.arrivalangles)) {
    var4 = self.asm.customdata.arrivalangles[1];
  } else {
    var5 = makeweapon(self.origin, 256, 96);

    if(isDefined(var5)) {
      var4 = vectortoyaw(var5);
    }
  }

  if(!isDefined(var4)) {
    return false;
  }

  var6 = angleclamp180(var4 - self.angles[1]);

  if(abs(var6) < 25) {
    return false;
  }

  self.desiredturnyaw = var6;
  return true;
}

function patrol_needtostopforpath(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfiredrecently(var0, "sharp_turn")) {
    return false;
  }

  if(distance2dsquared(self.pathgoalpos, self.origin) < 16) {
    return false;
  }

  var4 = anglesToForward(self.angles);
  var5 = vectordot(self.lookaheaddir, var4);
  var6 = 0;

  if(self pathdisttogoal() > 100) {
    var6 = -0.707;
  }

  if(vectordot(self.lookaheaddir, var4) > var6) {
    return false;
  }

  var7 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_left")) {
    var7 = "left";
  } else if(scripts\asm\asm::asm_eventfiredrecently(var0, "pass_right")) {
    var7 = "right";
  } else if(self.asm.footsteps.foot == "right") {
    var7 = "right";
  }

  var8 = spawnStruct();
  var8.angleindex = 4;
  var8.angledelta = 0;
  var8.stopanim = scripts\asm\asm::asm_lookupanimfromalias(var2, var7 + "2");
  var9 = scripts\asm\asm::asm_getxanim(var2, var8.stopanim);
  var8.movedelta = getmovedelta(var9);
  var10 = rotatevector(var8.movedelta, self.angles);
  var11 = self.origin + var10;
  var12 = navtrace(self.origin, var11, self, 1);
  var13 = var12["position"];
  var8.startpos = var13 - var10;
  var8.finalangles = self.angles;
  var8.bskipstartcoverarrival = 1;
  var8.customtargetpos = var13;
  self.asm.stopdata = var8;
  return true;
}