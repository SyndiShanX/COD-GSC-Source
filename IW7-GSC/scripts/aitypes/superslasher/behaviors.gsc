/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\superslasher\behaviors.gsc
******************************************************/

superslasher_isonroof() {
  return self.bt.locationstate == 0;
}

superslasher_isonground() {
  return self.bt.locationstate == 2;
}

superslasher_isgoingtoroof() {
  return self.bt.locationstate == 1;
}

superslasher_isgoingtoground() {
  return self.bt.locationstate == 3;
}

superslasher_isfinalstage() {
  return self.health <= self.maxhealth * 0.1;
}

superslasher_init(var_0) {
  self setnavlayer("superslasher");
  self.bt.locationstate = 0;
  self.bt.allownextaction = gettime() + 1000;
  self.bt.imaskchange = 0;
  self.nextsummonid = 0;
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmaytaunt = 0;
  self.bmayshockwave = 1;
  self.bmaywire = 0;
  self.bmayshark = 1;
  roof_initbehaviors();
  self.bt.onroofstarttime = gettime() - 120000 + 2000;
  setnextidlesoundtime();
  setdvarifuninitialized("btSuperSlasherShield", 0);
  setdvarifuninitialized("btSuperSlasherTargetTimer", 20000);
  setdvarifuninitialized("btSuperSlasherRush", 0);
  self.animratescale = 1.25;
  self.moveplaybackrate = self.animratescale;
  self.moveratescale = self.moveplaybackrate;
  return level.success;
}

dointro(var_0) {
  if(!isDefined(self._blackboard.bintrorequested)) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("intro_anim", "end")) {
    self._blackboard.bintrorequested = undefined;
    return level.success;
  }

  return level.running;
}

updateeveryframe(var_0) {
  if(!isalive(self)) {
    return level.failure;
  }

  if((isDefined(self.scripted) && self.scripted) || isDefined(self._blackboard.bgameended)) {
    self clearpath();
    self ghostskulls_total_waves(512);
    return level.failure;
  }

  updatetarget();
  self.moveplaybackrate = self.animratescale;
  self.moveratescale = self.moveplaybackrate;
  updateidlesound();
  return level.success;
}

setnextidlesoundtime() {
  self.nextidlesoundtime = gettime() + 3000 + randomint(2000);
}

updateidlesound() {
  if(gettime() > self.nextidlesoundtime) {
    if(isDefined(self._blackboard.bmoving) || isDefined(self._blackboard.bidle)) {
      self playsoundonmovingent("zmb_vo_supslasher_idle_grunt");
    }

    setnextidlesoundtime();
  }
}

isvalidtarget(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(var_0.ignoreme || isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping.ignoreme) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 0;
  }

  return 1;
}

settarget(var_0) {
  self.bt.target = var_0;
  self.bt.targetstarttime = gettime();
}

updatetarget() {
  var_0 = !isDefined(self.bt.target) || !isvalidtarget(self.bt.target);
  if(!var_0) {
    var_1 = getdvarint("btSuperSlasherTargetTimer");
    var_0 = var_1 > 0 && gettime() > self.bt.targetstarttime + var_1;
  }

  if(var_0) {
    var_2 = level.players;
    if(isDefined(self.bt.target)) {
      var_2 = scripts\engine\utility::array_remove(var_2, self.bt.target);
    }

    var_3 = [];
    foreach(var_5 in var_2) {
      if(isvalidtarget(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    if(var_3.size > 0) {
      settarget(var_3[randomint(var_3.size)]);
    }
  }
}

dotrapped(var_0) {
  if(isDefined(self._blackboard.btraprequested)) {
    return level.running;
  }

  return level.success;
}

shouldgotoroof(var_0) {
  if(self.bt.locationstate != 2) {
    return level.failure;
  }

  if(superslasher_isfinalstage()) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bstaggerrequested)) {
    return level.success;
  }

  if(isDefined(self._blackboard.bgotoroofrequested)) {
    return level.success;
  }

  return level.failure;
}

walktoroof_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.instancedata[var_0].objective_playermask_hidefromall = getclosestpointonnavmesh(level.superslashergotogroundspot, self);
  if(distance2dsquared(self.origin, level.superslashergotogroundspot) < 1296) {
    self.bt.instancedata[var_0].bgoodtogo = 1;
  }
}

walktoroof(var_0) {
  if(isDefined(self.bt.instancedata[var_0].bgoodtogo)) {
    return level.success;
  }

  var_1 = gettime();
  var_2 = 10000;
  if(var_1 > self.bt.instancedata[var_0].starttime + var_2) {
    return level.success;
  }

  if(var_1 > self.bt.instancedata[var_0].starttime + 500) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      return level.success;
    }
  }

  self ghostskulls_complete_status(self.bt.instancedata[var_0].objective_playermask_hidefromall);
  self ghostskulls_total_waves(64);
  return level.running;
}

walktoroof_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

jumptoroof_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.broofrequested = 1;
  self._blackboard.iroofjump = 0;
  scripts\aitypes\superslasher\util::ongotoroof_init();
  scripts\asm\superslasher\superslasher_actions::killallsharks(self);
  self notify("kill_sharks");
}

jumptoroof(var_0) {
  var_1 = 15000;
  var_2 = gettime();
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    self setorigin(level.superslasherrooftopspot, 1);
    self.angles = level.superslasherrooftopangles;
    self.bt.locationstate = 0;
    roof_initbehaviors();
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("jumptoroof", "end")) {
    self.bt.locationstate = 0;
    roof_initbehaviors();
    return level.success;
  }

  return level.running;
}

jumptoroof_cleanup(var_0) {
  self._blackboard.broofrequested = undefined;
  self.bt.instancedata[var_0] = undefined;
}

roof_initbehaviors() {
  self clearpath();
  self ghostskulls_total_waves(512);
  var_0 = gettime();
  self.bt.onroofstarttime = var_0;
  self._blackboard.bonroof = 1;
  self.bt.bcaninterruptfortimer = 1;
  self._blackboard.bgotoroofrequested = undefined;
  self.bt.allownextaction = var_0 + 1000;
  scripts\aitypes\superslasher\util::onroof_init();
}

stagger_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
}

dostagger(var_0) {
  if(!isDefined(self._blackboard.bstaggerrequested)) {
    return level.success;
  }

  var_1 = 5000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("staggeranim", "end")) {
    return level.success;
  }

  self clearpath(self.origin);
  self ghostskulls_total_waves(36);
  return level.running;
}

stagger_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.bstaggerrequested = undefined;
}

shouldgotoground(var_0) {
  if(self.bt.locationstate != 0) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bstaggerrequested)) {
    return level.success;
  }

  if(isDefined(self._blackboard.bgotogroundrequested)) {
    return level.success;
  }

  if(superslasher_isonroof()) {
    return level.success;
  }

  return level.failure;
}

gotoground_init(var_0) {
  self._blackboard.bgroundrequested = 1;
  self.bt.locationstate = 3;
  if(!isDefined(self.bt.igroundphase)) {
    self.bt.igroundphase = 0;
  } else {
    self.bt.igroundphase++;
  }

  scripts\aitypes\superslasher\util::ongotoground_init();
}

gotoground(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("jumptoground", "end")) {
    self.bt.locationstate = 2;
    ground_initbehaviors();
    return level.success;
  }

  return level.running;
}

ground_initbehaviors() {
  self clearpath(self.origin);
  self ghostskulls_total_waves(24);
  var_0 = gettime();
  self.bt.ongroundstarttime = var_0;
  self._blackboard.bonroof = 0;
  self.bt.bcaninterruptfortimer = 1;
  self._blackboard.bgotogroundrequested = undefined;
  self.bt.allownextaction = var_0 + 1000;
  self.bt.allowgroundpoundtime = var_0;
  self.bt.allowthrowsawtime = var_0;
  self.bt.allowthrowsawfantime = var_0;
  self.bt.allowgroundjumptime = var_0;
  self.bt.allowstomptime = var_0;
  self.bt.allowshockwavetime = var_0 + -6536;
  self.bt.allowsharktime = var_0 + 29000;
  scripts\aitypes\superslasher\util::onground_init();
  if(isDefined(self.btrophysystem)) {
    thread dotrophysystem();
  }
}

gotoground_cleanup(var_0) {
  self._blackboard.bgroundrequested = undefined;
}

isonroof(var_0) {
  if(self.bt.locationstate == 0) {
    return level.success;
  }

  return level.failure;
}

shouldtaunt(var_0) {
  if(!isDefined(self.bmaytaunt) || !self.bmaytaunt) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowtaunttime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  if(self.bt.locationstate == 2) {
    return level.failure;
  }

  if(isanyplayerwithinradius(100)) {
    return level.failure;
  }

  return level.success;
}

taunt_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self.bt.bcaninterruptfortimer = 0;
  self._blackboard.btauntrequested = 1;
}

taunt_setnextallowedtime() {
  var_0 = gettime();
  if(self.bt.locationstate == 0) {
    self.bt.allowtaunttime = var_0 + 3000;
  } else {
    self.bt.allowtaunttime = var_0 + 10000;
  }

  self.bt.allownextaction = var_0 + 1000;
}

dotaunt(var_0) {
  var_1 = 20000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    taunt_setnextallowedtime();
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("tauntanim", "end")) {
    taunt_setnextallowedtime();
    return level.success;
  }

  self clearpath(self.origin);
  self ghostskulls_total_waves(64);
  return level.running;
}

taunt_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.bt.bcaninterruptfortimer = 1;
  self._blackboard.btauntrequested = undefined;
}

dotauntcontinuously(var_0) {
  self clearpath(self.origin);
  self ghostskulls_total_waves(64);
  if(isDefined(self._blackboard.bstoptauntingcontinuously)) {
    if(scripts\asm\asm::asm_ephemeraleventfired("tauntanim", "end")) {
      taunt_setnextallowedtime();
      self._blackboard.bstoptauntingcontinuously = undefined;
      return level.success;
    }
  }

  return level.running;
}

shouldgroundpound(var_0) {
  if(!superslasher_isonground()) {
    return level.failure;
  }

  if(gettime() < self.bt.allowgroundpoundtime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  if(!isanyplayerwithinradius(256)) {
    return level.failure;
  }

  return level.success;
}

groundpound_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self clearpath(self.origin);
  self ghostskulls_total_waves(36);
  self.bt.bcaninterruptfortimer = 0;
  self._blackboard.bgroundpoundrequested = 1;
}

dogroundpound(var_0) {
  var_1 = 12000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    groundpound_setnextallowedtime();
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("groundpoundanim", "end")) {
    groundpound_setnextallowedtime();
    return level.success;
  }

  return level.running;
}

groundpound_setnextallowedtime() {
  var_0 = gettime();
  self.bt.allowgroundpoundtime = var_0 + 5000;
  self.bt.allownextaction = var_0 + 1000;
}

groundpound_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.bt.bcaninterruptfortimer = 1;
  self._blackboard.bgroundpoundrequested = undefined;
}

shouldmelee(var_0) {
  if(!isDefined(self.bt.target)) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  if(isanyplayerwithinradius(128)) {
    return level.success;
  }

  return level.failure;
}

melee_charge_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.meleetarget = self.bt.target;
  var_1 = getdvarint("btSuperSlasherRush") != 0;
  if(var_1) {
    if(distance2dsquared(self.origin, self.bt.target.origin) > 300) {
      scripts\asm\asm_bb::bb_requestmeleecharge(self.bt.target, self.bt.target.origin);
      self.bt.instancedata[var_0].bcharge = 1;
      self.bt.bcaninterruptfortimer = 0;
    }
  }
}

melee_charge(var_0) {
  if(isDefined(self._blackboard.bmoving)) {
    var_1 = -28672;
  } else {
    var_1 = 20736;
  }

  if(isDefined(self.bt.target) && isvalidtarget(self.bt.target)) {
    if(!isDefined(self._blackboard.bcommittedtoanim)) {
      var_2 = self.bt.target.origin - self.origin;
      var_3 = length2dsquared(var_2);
      if(var_3 < var_1) {
        self.bt.instancedata[var_0].bsuccess = 1;
        return level.success;
      }
    }
  } else {
    self.bt.instancedata[var_0].bsuccess = 1;
    return level.success;
  }

  var_4 = gettime();
  if(var_4 > self.bt.instancedata[var_0].starttime + 200 && !isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  var_5 = 5000;
  if(var_4 > self.bt.instancedata[var_0].starttime + var_5) {
    return level.failure;
  }

  var_6 = 1000;
  if(isDefined(self.bt.instancedata[var_0].bcharge) && var_4 > self.bt.instancedata[var_0].starttime + var_6) {
    var_7 = anglesToForward(self.angles);
    var_8 = self _meth_84AC();
    if(navtrace(var_8, var_8 + var_7 * 36)) {
      self.bt.instancedata[var_0].bsuccess = 1;
      return level.success;
    }
  }

  var_9 = getclosestpointonnavmesh(self.bt.target.origin, self);
  self ghostskulls_complete_status(var_9);
  self ghostskulls_total_waves(24);
  return level.running;
}

melee_charge_cleanup(var_0) {
  if(!isDefined(self.bt.instancedata[var_0].bsuccess)) {
    self.bt.meleetarget = undefined;
    scripts\asm\asm_bb::bb_clearmeleechargerequest();
  }

  self.bt.bcaninterruptfortimer = 1;
  self.bt.instancedata[var_0] = undefined;
}

melee_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.bcaninterruptfortimer = 0;
  scripts\asm\asm_bb::bb_requestmelee(self.bt.meleetarget);
}

domelee(var_0) {
  var_1 = 8000;
  if(gettime() > self.bt.instancedata[var_0].starttime + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("meleeanim", "end")) {
    return level.success;
  }

  if(isDefined(self.bt.meleetarget)) {
    var_2 = getclosestpointonnavmesh(self.bt.meleetarget.origin, self);
    self ghostskulls_complete_status(var_2);
    self ghostskulls_total_waves(24);
  } else {
    self clearpath(self.origin);
    self ghostskulls_total_waves(36);
  }

  return level.running;
}

melee_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.bt.bcaninterruptfortimer = 1;
  self.bt.meleetarget = undefined;
  scripts\asm\asm_bb::bb_clearmeleerequest();
  scripts\asm\asm_bb::bb_clearmeleechargerequest();
  self.bt.allownextaction = gettime() + 1000;
}

shouldthrowsaw(var_0) {
  if(!isDefined(self.bmayfrisbee) || !self.bmayfrisbee) {
    return level.failure;
  }

  var_1 = gettime();
  if(!isDefined(self.bt.target)) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowthrowsawtime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  if(self.bt.locationstate == 2) {
    if(isanyplayerwithinradius(256)) {
      return level.failure;
    }

    var_2 = anglesToForward(self.angles);
    var_3 = self.bt.target.origin - self.origin;
    if(vectordot(var_2, var_3) < 0) {
      return level.failure;
    }

    var_4 = getclosestpointonnavmesh(self.bt.target.origin, self);
    if(!navisstraightlinereachable(self _meth_84AC(), var_4)) {
      return level.failure;
    }
  }

  return level.success;
}

throwsaw_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bthrowsawrequested = 1;
  self._blackboard.throwsawtarget = self.bt.target;
  self._blackboard.throwsawbackuptargetpos = self.bt.target.origin;
  self._blackboard.throwsawchargetime = 1;
}

dothrowsaw(var_0) {
  var_1 = 6001;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwsawanim", "end")) {
    return level.success;
  }

  self clearpath(self.origin);
  self ghostskulls_total_waves(64);
  return level.running;
}

throwsaw_setnextallowedtime() {
  var_0 = gettime();
  if(self.bt.locationstate == 0) {
    self.bt.allowthrowsawtime = var_0 + 9000;
  } else {
    self.bt.allowthrowsawtime = var_0 + 8000;
  }

  self.bt.allownextaction = var_0 + 1000;
}

throwsaw_cleanup(var_0) {
  throwsaw_setnextallowedtime();
  self._blackboard.bthrowsawrequested = undefined;
  self._blackboard.throwsawtarget = undefined;
  self.bt.instancedata[var_0] = undefined;
}

shouldthrowsawfan(var_0) {
  if(!superslasher_isonground()) {
    return level.failure;
  }

  if(!isDefined(self.bmaysawfan) || !self.bmaysawfan) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowthrowsawfantime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  return level.success;
}

throwsawfan_setnextallowedtime() {
  var_0 = gettime();
  self.bt.allowthrowsawfantime = var_0 + 9500;
  self.bt.allownextaction = var_0 + 1000;
}

throwsawfan_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bthrowsawfanrequested = 1;
}

dothrowsawfan(var_0) {
  var_1 = 5000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("sawfananim", "end")) {
    return level.success;
  }

  self clearpath(self.origin);
  self ghostskulls_total_waves(64);
  return level.running;
}

throwsawfan_cleanup(var_0) {
  throwsawfan_setnextallowedtime();
  self._blackboard.bthrowsawfanrequested = undefined;
  self.bt.instancedata[var_0] = undefined;
}

shouldstomp(var_0) {
  if(!isDefined(self.bmaystomp) || !self.bmaystomp) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowstomptime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = -1;
  var_4 = undefined;
  foreach(var_6 in level.players) {
    if(!isvalidtarget(var_6)) {
      continue;
    }

    var_7 = var_6.origin - self.origin;
    var_8 = vectordot(var_2, var_7);
    if(var_8 > 768) {
      continue;
    }

    if(var_8 < 0) {
      continue;
    }

    var_9 = vectordot(var_2, var_7 / var_8);
    if(var_9 > var_3) {
      var_3 = var_9;
      var_4 = var_6;
    }
  }

  if(var_3 > 0) {
    self._blackboard.bstomprequested = 1;
    self._blackboard.stomptarget = var_4;
    self._blackboard.stompdist = 768;
    return level.success;
  }

  return level.failure;
}

stomp_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
}

dostomp(var_0) {
  var_1 = 15000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("stompanim", "end")) {
    return level.success;
  }

  self clearpath();
  return level.running;
}

stomp_setnextallowedtime() {
  var_0 = gettime();
  self.bt.allownextaction = var_0 + 1000;
  self.bt.allowstomptime = var_0 + 9000;
}

stomp_cleanup(var_0) {
  self._blackboard.bstomprequested = undefined;
  self._blackboard.stomptarget = undefined;
  self._blackboard.stompdist = undefined;
  stomp_setnextallowedtime();
  self.bt.instancedata[var_0] = undefined;
}

shouldshockwave(var_0) {
  if(!isDefined(self.bmayshockwave) || !self.bmayshockwave) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  if(isDefined(self.bshockwaverequested)) {
    return level.success;
  }

  return level.failure;
}

shockwave_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bshockwaverequested = 1;
  self.bshockwaverequested = undefined;
}

doshockwave(var_0) {
  var_1 = 12000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("shockwaveanim", "end")) {
    return level.success;
  }

  return level.running;
}

shockwave_setnextallowedtime() {
  var_0 = gettime();
  self.bt.allownextaction = var_0 + 1000;
  self.bt.allowshockwavetime = var_0 + -6536;
}

shockwave_cleanup(var_0) {
  shockwave_setnextallowedtime();
  self._blackboard.bshockwaverequested = undefined;
  self.bt.instancedata[var_0] = undefined;
}

shoulddowires(var_0) {
  if(!isDefined(self.bmaywire) || !self.bmaywire) {
    return level.failure;
  }

  if(!superslasher_isonroof()) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bwired)) {
    return level.failure;
  }

  return level.success;
}

wires_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bwiresrequested = 1;
}

dowires(var_0) {
  var_1 = 5000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("wiresanim", "end")) {
    return level.success;
  }

  return level.running;
}

wires_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.bwiresrequested = undefined;
}

wires_stop(var_0) {
  scripts\asm\superslasher\superslasher_actions::stopwireattack();
  return level.success;
}

shoulddosharks(var_0) {
  if(!isDefined(self.bmayshark) || !self.bmayshark) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowsharktime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  return level.success;
}

sharks_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bsharksrequested = 1;
}

dosharks(var_0) {
  var_1 = 15000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("sharksanim", "end")) {
    return level.success;
  }

  self clearpath();
  return level.running;
}

sharks_setnextallowedtime() {
  var_0 = gettime();
  self.bt.allownextaction = var_0 + 1000;
  self.bt.allowsharktime = var_0 + 29000;
}

sharks_cleanup(var_0) {
  sharks_setnextallowedtime();
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.bsharksrequested = undefined;
}

shouldjumpmove(var_0) {
  if(!isDefined(self.bmayjumpattack) || !self.bmayjumpattack) {
    return level.failure;
  }

  if(!superslasher_isonground()) {
    return level.failure;
  }

  var_1 = gettime();
  if(var_1 < self.bt.allownextaction) {
    return level.failure;
  }

  if(var_1 < self.bt.allowgroundjumptime) {
    return level.failure;
  }

  if(isDefined(self._blackboard.bcommittedtoanim)) {
    return level.failure;
  }

  var_2 = 147456;
  if(isDefined(self.bt.target)) {
    var_3 = getclosestpointonnavmesh(self.bt.target.origin, self);
    if(distance2dsquared(self.origin, var_3) >= var_2) {
      var_4 = self _meth_84AC();
      if(navisstraightlinereachable(var_4, var_3, self)) {
        return level.success;
      }
    }
  }

  return level.failure;
}

jumpmove_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.bjumpmoverequested = 1;
  self._blackboard.jumptargetpos = getclosestpointonnavmesh(self.bt.target.origin, self);
  self ghostskulls_complete_status(self._blackboard.jumptargetpos);
}

dojumpmove(var_0) {
  var_1 = 4000;
  if(gettime() > self.bt.instancedata[var_0] + var_1) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("jumpmoveanim", "end")) {
    return level.success;
  }

  return level.running;
}

jumpmove_setnextallowedtime() {
  self.bt.allowgroundjumptime = gettime() + 7000;
}

jumpmove_cleanup(var_0) {
  jumpmove_setnextallowedtime();
  self._blackboard.bjumpmoverequested = undefined;
  self.bt.instancedata[var_0] = undefined;
}

move_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
}

move(var_0) {
  var_1 = gettime();
  if(var_1 >= self.bt.instancedata[var_0]) {
    if(isDefined(self.bt.target) && isvalidtarget(self.bt.target)) {
      var_2 = 5000;
      var_3 = getclosestpointonnavmesh(self.bt.target.origin, self);
      self ghostskulls_complete_status(var_3);
      self ghostskulls_total_waves(36);
      self.bt.instancedata[var_0] = var_1 + var_2;
    }
  }

  return level.running;
}

move_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

isanyplayerwithinradius(var_0) {
  var_1 = var_0 * var_0;
  foreach(var_3 in level.players) {
    if(isvalidtarget(var_3)) {
      if(distance2dsquared(self.origin, var_3.origin) < var_1) {
        return 1;
      }
    }
  }

  return 0;
}

dotrophysystem() {
  self endon("killshield");
  self endon("death");
  var_0 = 3;
  self.shields = [];
  for(var_1 = 0; var_1 < var_0; var_1++) {
    self.shields[var_1] = setupshield(var_1, var_0);
    wait(0.05);
  }

  for(;;) {
    for(var_1 = 0; var_1 < var_0; var_1++) {
      updateshield(self.shields[var_1]);
    }

    self.lastdamagedir = [];
    wait(0.05);
  }
}

setupshield(var_0, var_1) {
  var_2 = 96;
  var_3 = 120;
  var_4 = -90;
  var_5 = angleclamp180(var_0 * 360 / var_1);
  var_6 = (var_2, 0, var_3);
  var_7 = spawn("script_model", self.origin + rotatevector(var_6, (0, var_5, 0)));
  var_7 setModel("superslasher_trophy_system");
  var_7.angles = (0, self.angles[1] + var_4, 0);
  var_7.halfrange = 180 / var_1;
  var_7.midrange = var_5;
  var_7.offset = var_6;
  var_7.lastdamagetime = 0;
  var_7.beffect = 0;
  var_7.effectontime = 0;
  var_7.angleoffset = var_4;
  var_7.curangle = var_5;
  var_7.sine = 0;
  var_7.targetangle = var_5;
  return var_7;
}

updateshield(var_0) {
  var_1 = 4;
  var_2 = gettime();
  var_3 = 1000;
  var_4 = 0;
  if(var_0.beffect && var_2 - var_0.effectontime > var_3) {
    var_0 setscriptablepartstate("shield", "off");
    var_0.beffect = 0;
    var_4 = 1;
  }

  if(self.lastdamagedir.size > 0) {
    foreach(var_6 in self.lastdamagedir) {
      var_7 = vectortoyaw(var_6);
      if(abs(angleclamp180(var_7 - var_0.midrange)) < var_0.halfrange) {
        var_0.targetangle = var_7;
        var_0.lastdamagetime = self.lastdamagetime;
        if(!var_0.beffect && !var_4) {
          var_0 setscriptablepartstate("shield", "impact");
          var_0.effectontime = var_2;
          var_0.beffect = 1;
        }

        break;
      }
    }
  }

  var_9 = 3000;
  if(var_2 - var_0.lastdamagetime > var_9) {
    var_0.targetangle = var_0.midrange;
  }

  var_0A = angleclamp180(var_0.targetangle - var_0.curangle);
  var_0A = clamp(var_0A, -1 * var_1, var_1);
  var_0.curangle = angleclamp180(var_0.curangle + var_0A);
  var_0B = self.origin + rotatevector(var_0.offset, (0, var_0.curangle, 0));
  var_0C = var_0B + (0, 0, sin(var_0.sine) * 12);
  var_0.sine = var_0.sine + 3 % 360;
  var_0.origin = var_0C;
  var_0.angles = (0, var_0.curangle + var_0.angleoffset, 0);
}

shieldcleanup() {
  if(isDefined(self.shields)) {
    self notify("killshield");
    foreach(var_1 in self.shields) {
      var_1 delete();
    }

    self.shields = undefined;
  }
}