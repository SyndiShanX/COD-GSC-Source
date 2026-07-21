/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\patrol.gsc
***********************************************/

patrol_reactendswithmove(var_0, var_1, var_2, var_3) {
  return length(self.velocity) > 1;
}

patrol_shouldreact(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth) || !isDefined(self.stealth.patrol_react_magnitude) || !isDefined(self.stealth.patrol_react_time))
    return 0;

  var_4 = 200;

  if(gettime() > self.stealth.patrol_react_time + var_4)
    return 0;

  if(isDefined(self.stealth.investigateevent))
    self glanceatpos(self.stealth.investigateevent.origin);

  return 1;
}

patrol_shouldcombatrereact(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth) || !isDefined(self.enemy))
    return 0;

  if(scripts\asm\asm::asm_getdemeanor() == "combat" && self cansee(self.enemy)) {
    self.stealth.patrol_react_magnitude = "med";
    self.stealth.patrol_react_pos = self.enemy.origin;
    self.stealth.patrol_react_time = gettime();
    return 1;
  }

  return 0;
}

playanim_patrolreact(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  playanim_patrolreact_internal(var_0, var_1, var_1);
}

playanim_patrolreact_internal(var_0, var_1, var_2) {
  self.stealth.breacting = self.stealth.patrol_react_magnitude;

  if(shouldpatrolreactaim()) {
    if(distance2dsquared(self.origin, self.stealth.patrol_react_pos) > 1024)
      self setlookat(self.stealth.patrol_react_pos);
  }

  var_3 = self asmgetanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_2, var_3);
  var_5 = 1;

  if(isDefined(self.stealth.reactendtime)) {
    var_6 = 1;
    var_7 = getnotetracktimes(var_4, "code_move");

    if(var_7.size > 0)
      var_6 = var_7[0];

    var_8 = getanimlength(var_4) * var_6;
    var_9 = 0.05 + (self.stealth.reactendtime - gettime()) / 1000;

    if(var_9 < 0.2)
      var_9 = 0.2;

    var_5 = clamp(var_8 / var_9, 0.8, 1.3);
    self.stealth.reactendtime = undefined;
  }

  self aisetanim(var_2, var_3, var_5);
  self.stealth.patrol_react_magnitude = undefined;
  self.stealth.patrol_react_time = undefined;
  scripts\asm\asm::asm_donotetrackswithinterceptor(var_0, var_1, ::flashlightreactionnotehandler, undefined, var_2);
}

shouldpatrolreactaim(var_0, var_1, var_2, var_3) {
  return self.stealth.patrol_react_magnitude == "large" || self.stealth.patrol_react_magnitude == "med" || self.stealth.patrol_react_magnitude == "smed";
}

shouldpatrolreactlookaround(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_getdemeanor() == "combat" && !isDefined(self.enemy) && self[[self.fnisinstealthcombat]]();
}

shouldpatrolreactlookaroundabort(var_0, var_1, var_2, var_3) {
  return isDefined(self.enemy);
}

chooseanim_patrolreactlookaround(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, scripts\engine\utility::string(getpatrolreactdirindex()));
}

chooseanim_patrolreactlookaround_checkflashlight(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::string(getpatrolreactdirindex());
  return chooseanim_patrol_checkflashlight(var_0, var_1, var_3);
}

getpatrolreactdirindex() {
  var_0 = 0;

  if(isDefined(self.stealth.patrol_react_pos)) {
    var_1 = self.stealth.patrol_react_pos - self.origin;

    if(length2dsquared(var_1) < 36)
      var_0 = 0;
    else {
      var_2 = vectortoyaw(var_1);
      var_0 = self.angles[1] - var_2;
    }
  }

  return getreactangleindex(var_0);
}

getpatrolreactalias() {
  var_0 = getpatrolreactdirindex();
  var_1 = self.stealth.patrol_react_magnitude + "_" + var_0;
  return var_1;
}

chooseanim_patrolreact(var_0, var_1, var_2) {
  var_3 = getpatrolreactalias();
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

chooseanim_patrolreact_checkflashlight(var_0, var_1, var_2) {
  var_3 = getpatrolreactalias();
  return chooseanim_patrol_checkflashlight(var_0, var_1, var_3);
}

patrolreact_terminate(var_0, var_1, var_2) {
  self.stealth.breacting = undefined;
  self stoplookat();
}

getreactangleindex(var_0) {
  var_0 = angleclamp180(var_0);

  if(var_0 > 135 || var_0 < -135)
    var_1 = 2;
  else if(var_0 < -45)
    var_1 = 4;
  else if(var_0 > 45)
    var_1 = 6;
  else
    var_1 = 8;

  return var_1;
}

handlefacegoalnotetrack(var_0, var_1, var_2) {
  if(var_1 == "face_goal" && isDefined(self.stealth.patrol_react_pos)) {
    var_3 = self.stealth.patrol_react_pos - self.origin;
    var_4 = vectortoyaw(var_3);
    thread facegoalthread(var_0, var_4);
    return 1;
  }

  return 0;
}

facegoalthread(var_0, var_1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_2 = 1;
    var_3 = self.enemy;

    if(!isDefined(var_3)) {
      if(isDefined(self.stealth.investgate_entity) && isPlayer(self.stealth.investigate_entity))
        var_3 = self.stealth.investigate_entity;
    }

    if(isDefined(var_3) && isPlayer(var_3) && distance(self.origin, var_3.origin) <= 200)
      var_2 = 0;

    var_4 = 0.25;

    if(isDefined(var_3) && issentient(var_3)) {
      if(!var_2 || var_2 && self cansee(var_3)) {
        var_5 = var_3.origin - self.origin;
        var_1 = vectortoyaw(var_5);
        var_4 = 0.5;
      }
    }

    var_6 = angleclamp180(var_1 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var_6 * var_4);
    waitframe();
  }
}

patrol_playanim_randomrate(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = randomfloatrange(0.8, 1.2);
  self aisetanim(var_1, var_3, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_1, var_3));
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

patrol_getstationaryturnangle() {
  if(isDefined(self._blackboard.idlenode))
    return angleclamp180(self._blackboard.idlenode.angles[1] - self.angles[1]);
  else if(isDefined(self.patrol_custom_face_angle))
    return angleclamp180(self.patrol_custom_face_angle - self.angles[1]);
  else if(isDefined(self._blackboard.bfacesomedecentdirectionwhenidle)) {
    var_0 = makeweapon(self.origin, 256, 96);

    if(isDefined(var_0)) {
      var_1 = angleclamp180(vectortoyaw(var_0) - self.angles[1]);
      return var_1;
    }
  }

  return undefined;
}

patrol_shoulddostationaryturn(var_0, var_1, var_2, var_3) {
  var_4 = patrol_getstationaryturnangle();
  var_5 = isDefined(var_4) && abs(var_4) > 10.0;
  self.desiredturnyaw = var_4;
  return var_5;
}

patrol_choosestationaryturnanim(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self.desiredturnyaw))
    var_3 = self.desiredturnyaw;

  if(!isDefined(var_3))
    var_4 = "8";
  else if(var_3 < -135)
    var_4 = "2r";
  else if(var_3 > 135)
    var_4 = "2l";
  else if(var_3 < -45)
    var_4 = "6";
  else if(var_3 > 45)
    var_4 = "4";
  else
    var_4 = "8";

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return var_5;
}

patrol_playanim_idle(var_0, var_1, var_2) {
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
}

handlestationaryturnfacegoalnotetrack(var_0, var_1) {
  if(var_0 == "face_goal" && isDefined(self.desiredturnyaw) && isDefined(var_1.statename)) {
    var_2 = getnotetracktimes(var_1.xanim, "face_goal_end");
    var_3 = undefined;

    if(!isDefined(var_2))
      return undefined;

    var_4 = getanimlength(var_1.xanim);
    var_5 = self getanimtime(var_1.xanim);
    var_3 = var_2[0] - var_5;
    var_6 = getangledelta(var_1.xanim, 0, 1);
    var_7 = angleclamp180(self.desiredturnyaw - var_6);
    var_3 = var_3 * var_4;
    thread patrol_stationaryturnfixupthread(var_1.statename, var_7, var_3);
  } else if(var_0 == "end")
    return 0;

  return undefined;
}

patrol_stationaryturnfixupthread(var_0, var_1, var_2) {
  self notify("FaceYawThread");
  self endon("FaceYawThread");
  self endon("death");
  self endon(var_0 + "_finished");
  var_3 = var_2 * (1000 / level.frameduration);
  var_4 = var_1 / var_3;

  while(var_3 >= 0) {
    self orientmode("face angle", angleclamp(self.angles[1] + var_4));
    var_3 = var_3 - 1;
    waitframe();
  }
}

patrol_playanim_idlestationaryturn(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  scripts\common\gameskill::didsomethingotherthanshooting();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy))
    self orientmode("face enemy");
  else
    self orientmode("face angle 3d", self.angles);

  if(isDefined(self.node))
    self animmode("angle deltas");
  else
    self animmode("zonly_physics");

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.stepoutyaw = angleclamp180(getangledelta(var_4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var_5 = 1;
  self aisetanim(var_1, var_3, var_5);
  var_6 = spawnStruct();
  var_6.xanim = var_4;
  var_6.statename = var_1;
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handlestationaryturnfacegoalnotetrack, var_6);
}

patrol_shouldarrival_examine(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!isDefined(self.stealth.bexaminerequested) || !self.stealth.bexaminerequested)
    return 0;

  if(!isDefined(self.stealth.corpse.investigatealias)) {
    var_4 = archetypegetaliases(self.asm.archetype, var_2);
    self.stealth.corpse.investigatealias = var_4[randomint(var_4.size)];
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, self.stealth.corpse.investigatealias);
  var_6 = scripts\asm\asm::asm_getxanim(var_2, var_5);
  var_7 = getmovedelta(var_6);
  var_8 = length(var_7);
  var_9 = 12;
  var_10 = 12;
  var_11 = self.lookaheaddist;

  if(var_11 < var_8 - var_10)
    return 0;

  var_12 = self pathdisttogoal();

  if(var_12 > var_8 + var_9)
    return 0;

  if(var_12 < var_8 - var_10)
    return 0;

  var_13 = self.pathgoalpos - self.origin;
  var_14 = spawnStruct();
  var_14.angledelta = 0;
  var_14.finalangles = vectortoangles(var_13);
  var_14.stopanim = var_5;
  var_14.movedelta = var_7;
  var_14.startpos = self.pathgoalpos - rotatevector(var_7, var_14.finalangles);
  self.asm.stopdata = var_14;
  return 1;
}

patrol_finisharrival(var_0, var_1, var_2) {
  if(isDefined(self.stealth) && isDefined(self.stealth.corpse))
    self.stealth.corpse.investigatealias = undefined;

  self.stealth.bexaminerequested = undefined;
  scripts\asm\soldier\arrival::finisharrival(var_0, var_1, var_2);
}

patrol_isidlecurious(var_0, var_1, var_2, var_3) {
  return isDefined(self.stealth) && isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious;
}

patrol_isnotidlecurious(var_0, var_1, var_2, var_3) {
  return !patrol_isidlecurious(var_0, var_1, var_2, var_3);
}

patrol_playanim_idlecurious(var_0, var_1, var_2) {
  thread patrol_playanim_idlecurious_facelastknownhelper(var_1, self.stealth.idlecurioustarget);
  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

patrol_playanim_idlecurious_facelastknownhelper(var_0, var_1) {
  self endon(var_0 + "_finished");

  while(isDefined(var_1) && isalive(var_1)) {
    var_2 = self lastknownpos(var_1);
    var_3 = var_2 - self.origin;
    self orientmode("face angle", vectortoyaw(var_3));
    waitframe();
  }
}

patrol_shouldinvestigatelookaround(var_0, var_1, var_2, var_3) {
  return isDefined(self.stealth) && isDefined(self.stealth.binvestigatelookaround) && self.stealth.binvestigatelookaround;
}

patrol_notshouldinvestigatelookaround(var_0, var_1, var_2, var_3) {
  return !patrol_shouldinvestigatelookaround(var_0, var_1, var_2, var_3);
}

patrol_shouldpulloutflashlight(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.bflashlight) || !self._blackboard.bflashlight)
    return 0;

  return !isDefined(self.asm.flashlight) || !self.asm.flashlight;
}

patrol_shouldputawayflashlight(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight)
    return 0;

  return isDefined(self.asm.flashlight) && self.asm.flashlight;
}

patrol_magicflashlightdetach(var_0, var_1, var_2) {
  if(isDefined(self.asm.flashlight) && self.asm.flashlight)
    detachflashlight();

  if(istrue(self._blackboard.bflashlight) && !self.flashlight)
    self[[self.fnstealthflashlighton]]();
}

patrol_magicflashlighton(var_0, var_1, var_2) {
  if(istrue(self._blackboard.bflashlight))
    self[[self.fnstealthflashlighton]]();
}

chooseanim_patrol_checkflashlight(var_0, var_1, var_2) {
  var_3 = var_2;

  if(isDefined(self.asm.flashlight) && self.asm.flashlight)
    var_3 = "fl_" + var_3;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

patrol_hasflashlightout(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm.flashlight) && self.asm.flashlight;
}

patrol_nothasflashlightout(var_0, var_1, var_2, var_3) {
  return !patrol_hasflashlightout(var_0, var_1, var_2, var_3);
}

patrol_playanim_pulloutflashlight(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self.stealth.flashlightxanim = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_4 = self.moveplaybackrate;

  if(length(self.velocity) < 1)
    var_4 = randomfloatrange(0.8, 1.2);

  self aisetanim(var_1, var_3, var_4);
  self aisetanimrate(var_1, var_3, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_1, var_3));
  var_5 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));

  if(var_5 == "code_move")
    var_5 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

flashlightnotehandler(var_0) {
  if(var_0 == "attach") {
    var_1 = 1;

    if(isDefined(self.stealth.flashlightxanim) && self getanimweight(self.stealth.flashlightxanim) > 0) {
      var_1 = !animhasnotetrack(self.stealth.flashlightxanim, "flashlight_on");
      self.stealth.flashlightxanim = undefined;
    }

    attachflashlight(var_1);
  } else if(var_0 == "detach") {
    detachflashlight();

    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && isDefined(self._blackboard.bflashlight) && self._blackboard.bflashlight)
      self[[self.fnstealthflashlighton]]();
  } else if(var_0 == "flashlight_on")
    self[[self.fnstealthflashlighton]]();
  else if(var_0 == "flashlight_off")
    self[[self.fnstealthflashlightoff]](0);
}

setflashlightmodel(var_0) {
  if(isai(self))
    detachflashlight();

  self.flashlightmodeloverride = var_0;

  if(isai(self) && istrue(self.asm.flashlight))
    attachflashlight(1);
}

getflashlightmodel() {
  var_0 = "attachment_wm_tac_light_held";

  if(isDefined(self.flashlightmodeloverride))
    var_0 = self.flashlightmodeloverride;
  else if(isDefined(level.flashlightmodeloverride))
    var_0 = level.flashlightmodeloverride;

  return var_0;
}

attachflashlight(var_0) {
  self[[self.fnstealthflashlightoff]](0);
  var_1 = getflashlightmodel();
  self attach(var_1, "tag_accessory_left", 1);
  self.flashlightmodel = var_1;
  self.asm.flashlight = 1;
  self.flashlightfxoverridetag = "tag_light";

  if(var_0)
    self[[self.fnstealthflashlighton]]();
}

detachflashlight() {
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

flashlightreactionnotehandler(var_0, var_1, var_2) {
  flashlightnotehandler(var_1);
  return handlefacegoalnotetrack(var_0, var_1);
}

patrol_idle_setupreaction(var_0, var_1, var_2) {
  if(isDefined(self.stealth.investigateevent)) {
    scripts\common\utility::demeanor_override("alert");
    self.stealth.patrol_react_magnitude = "small";
    self.stealth.patrol_react_pos = self.stealth.investigateevent.investigate_pos;
    self.stealth.patrol_react_time = gettime();
  }
}

patrol_movetransition_check(var_0, var_1, var_2, var_3) {
  if(isDefined(self.asm.footsteps.foot) && self.asm.footsteps.foot == "right")
    return 0;

  var_4 = self pathdisttogoal();

  if(var_4 < 96)
    return 0;

  return 1;
}

patrol_shouldusehuntexit(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthhunt]]() || self[[self.fnisinstealthinvestigate]]();
}

patrol_needtoturntohuntlookaround(var_0, var_1, var_2, var_3) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedsmartobject()))
    return 0;

  if(istrue(self.limitstealthturning))
    return 0;

  var_4 = undefined;

  if(isDefined(self.asm.customdata.arrivalangles))
    var_4 = self.asm.customdata.arrivalangles[1];
  else {
    var_5 = makeweapon(self.origin, 256, 96);

    if(isDefined(var_5))
      var_4 = vectortoyaw(var_5);
  }

  if(!isDefined(var_4))
    return 0;

  var_6 = angleclamp180(var_4 - self.angles[1]);

  if(abs(var_6) < 25)
    return 0;

  self.desiredturnyaw = var_6;
  return 1;
}

patrol_needtostopforpath(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfiredrecently(var_0, "sharp_turn"))
    return 0;

  if(distance2dsquared(self.pathgoalpos, self.origin) < 16)
    return 0;

  var_4 = anglesToForward(self.angles);
  var_5 = vectordot(self.lookaheaddir, var_4);
  var_6 = 0;

  if(self pathdisttogoal() > 100)
    var_6 = -0.707;

  if(vectordot(self.lookaheaddir, var_4) > var_6)
    return 0;

  var_7 = "left";

  if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_left"))
    var_7 = "left";
  else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "pass_right"))
    var_7 = "right";
  else if(self.asm.footsteps.foot == "right")
    var_7 = "right";

  var_8 = spawnStruct();
  var_8.angleindex = 4;
  var_8.angledelta = 0;
  var_8.stopanim = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_7 + "2");
  var_9 = scripts\asm\asm::asm_getxanim(var_2, var_8.stopanim);
  var_8.movedelta = getmovedelta(var_9);
  var_10 = rotatevector(var_8.movedelta, self.angles);
  var_11 = self.origin + var_10;
  var_12 = navtrace(self.origin, var_11, self, 1);
  var_13 = var_12["position"];
  var_8.startpos = var_13 - var_10;
  var_8.finalangles = self.angles;
  var_8.bskipstartcoverarrival = 1;
  var_8.customtargetpos = var_13;
  self.asm.stopdata = var_8;
  return 1;
}