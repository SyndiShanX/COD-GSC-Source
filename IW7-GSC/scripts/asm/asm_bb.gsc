/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
**********************************/

func_2980(var_0, var_1) {
  self._blackboard.var_1FC7[var_0] = var_1;
}

func_2927(var_0) {
  if(isDefined(self._blackboard.var_1FC7) && isDefined(self._blackboard.var_1FC7[var_0])) {
    return self._blackboard.var_1FC7[var_0];
  }

  return undefined;
}

func_2928(var_0) {
  var_1 = func_2927(var_0);
  if(isDefined(var_1) && var_1.size > 0) {
    return var_1 + "_";
  }

  return undefined;
}

bb_wantstostrafe() {
  if(isDefined(self._blackboard.meleerequested) && self._blackboard.meleerequested) {
    return 1;
  }

  if(isDefined(self._blackboard.bwantstostrafe)) {
    return self._blackboard.bwantstostrafe;
  }

  return 0;
}

func_9DA4(var_0, var_1, var_2, var_3) {
  return self.a.pose == var_3;
}

bb_requestsmartobject(var_0) {
  self._blackboard.var_527D = var_0;
}

func_292C() {
  return self._blackboard.var_527D;
}

func_2949(var_0, var_1, var_2, var_3) {
  return self._blackboard.var_527D == var_3;
}

bb_setisincombat(var_0) {
  self._blackboard.var_2B11 = !isDefined(var_0) || var_0;
}

bb_isincombat() {
  if(isDefined(self._blackboard.var_2B11)) {
    return self._blackboard.var_2B11;
  }

  return 0;
}

bb_isweaponclass(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::weaponclass(self.var_394) == var_3;
}

bb_shoulddroprocketlauncher(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::weaponclass(self.var_394) != "rocketlauncher") {
    return 0;
  }

  var_4 = bb_getrequestedweapon();
  if(!isDefined(var_4)) {
    return 0;
  }

  return var_4 != "rocketlauncher";
}

bb_requestmove() {}

bb_clearmoverequest() {}

bb_moverequested() {
  return self codemoverequested();
}

func_2958(var_0, var_1, var_2, var_3) {
  return !self codemoverequested();
}

bb_movetyperequested(var_0) {
  return self._blackboard.movetype == var_0;
}

bb_requestmovetype(var_0) {
  self._blackboard.movetype = var_0;
  if(var_0 == "cqb") {
    self.asm.var_13CAF = 0;
  }
}

bb_requestweapon(var_0) {
  self._blackboard.weaponrequest = var_0;
}

bb_clearweaponrequest() {
  self._blackboard.weaponrequest = undefined;
}

bb_getrequestedweapon() {
  return self._blackboard.weaponrequest;
}

bb_requestreload(var_0) {
  if(!isDefined(var_0)) {
    self._blackboard.breload = 1;
    return;
  }

  self._blackboard.breload = var_0;
}

bb_reloadrequested() {
  if(isDefined(self._blackboard.breload)) {
    return self._blackboard.breload;
  }

  return 0;
}

bb_requestthrowgrenade(var_0, var_1) {
  if(!isDefined(var_0)) {
    self._blackboard.bthrowgrenade = 1;
  } else {
    self._blackboard.bthrowgrenade = var_0;
  }

  if(self._blackboard.bthrowgrenade) {
    self._blackboard.throwgrenadetarget = var_1;
    return;
  }

  self._blackboard.throwgrenadetarget = undefined;
}

bb_throwgrenaderequested() {
  if(isDefined(self._blackboard.bthrowgrenade)) {
    return self._blackboard.bthrowgrenade && isDefined(self._blackboard.throwgrenadetarget);
  }

  return 0;
}

bb_getthrowgrenadetarget() {
  return self._blackboard.throwgrenadetarget;
}

bb_requestfire(var_0, var_1) {
  if(!isDefined(var_0)) {
    self._blackboard.bfire = 1;
  } else {
    self._blackboard.bfire = var_0;
  }

  if(self._blackboard.bfire) {
    self._blackboard.var_1182F = var_1;
    return;
  }

  self._blackboard.var_1182F = undefined;
}

func_298B() {
  if(isDefined(self._blackboard.bfire)) {
    return self._blackboard.bfire && isDefined(self._blackboard.var_1182F);
  }

  return 0;
}

func_2931() {
  return self._blackboard.var_1182F;
}

bb_requestfire(var_0) {
  if(!isDefined(var_0)) {
    self._blackboard.var_2AA6 = 1;
    return;
  }

  self._blackboard.var_2AA6 = var_0;
}

func_291C() {
  if(isDefined(self._blackboard.var_2AA6)) {
    return self._blackboard.var_2AA6;
  }

  return 0;
}

bb_setshootparams(var_0, var_1) {
  self._blackboard.shootparams = var_0;
  if(isDefined(var_0)) {
    self._blackboard.shootparams.target = var_1;
    if(isDefined(var_1)) {
      self._blackboard.shootparams.var_3137 = 1;
      return;
    }

    self._blackboard.shootparams.var_3137 = undefined;
  }
}

func_2985() {
  if(isDefined(self._blackboard.shootparams)) {
    if(isDefined(self.var_FED1) && isDefined(self._blackboard.shootparams.pos)) {
      return 1;
    }

    if(isDefined(self.dontevershoot) && self.dontevershoot) {
      return 0;
    }

    if(isDefined(self._blackboard.shootparams.target) && isDefined(self.isnodeoccupied) && self.isnodeoccupied == self._blackboard.shootparams.target) {
      return scripts\engine\utility::func_9DA3();
    }
  }

  return 0;
}

func_2961(var_0) {
  self._blackboard.coverstate = var_0;
}

bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate)) {
    return "none";
  }

  return self._blackboard.coverstate;
}

func_2948(var_0, var_1, var_2, var_3) {
  return bb_getrequestedcoverstate() == var_3;
}

func_2944(var_0, var_1, var_2, var_3) {
  return bb_getrequestedcoverstate() != var_3;
}

func_295E(var_0) {
  self._blackboard.var_4720 = var_0;
}

func_2929() {
  return self._blackboard.var_4720;
}

func_2947(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.var_4720) && self._blackboard.var_4720 == var_3;
}

func_2946(var_0, var_1, var_2, var_3) {
  return bb_getrequestedcoverstate() == "exposed" && func_2947(var_0, var_1, var_2, var_3);
}

func_2943(var_0, var_1, var_2, var_3) {
  return bb_getrequestedcoverstate() != "exposed" || !func_2947(var_0, var_1, var_2, var_3);
}

func_295D(var_0) {
  self._blackboard.var_2996 = var_0;
}

func_291A() {
  return isDefined(self._blackboard.var_2996) && self._blackboard.var_2996;
}

bb_setcovernode(var_0) {
  self._blackboard.covernode = var_0;
  self._blackboard.bhascovernode = isDefined(var_0);
}

func_2932() {
  return isDefined(self._blackboard.bhascovernode) && self._blackboard.bhascovernode;
}

bb_getcovernode() {
  return self._blackboard.covernode;
}

bb_getrequestedturret() {
  if(isDefined(self._blackboard.requestedturret)) {
    return self._blackboard.requestedturret;
  }

  return undefined;
}

func_296E(var_0) {
  self._blackboard.requestedturret = var_0;
}

func_296F(var_0) {
  self._blackboard.var_E1AF = var_0;
}

bb_hasshufflenode(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.shufflenode) && isDefined(self.target_getindexoftarget) && self._blackboard.shufflenode == self.target_getindexoftarget && distancesquared(self.target_getindexoftarget.origin, self.origin) > 16;
}

func_2936(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.shufflenode)) {
    return 0;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(self._blackboard.shufflenode != self.target_getindexoftarget) {
    return 0;
  }

  if(distancesquared(self.target_getindexoftarget.origin, self.origin) <= 16) {
    return 0;
  }

  if(self._blackboard.shufflenode.type != var_3) {
    return 0;
  }

  return 1;
}

func_9F53(var_0, var_1) {
  var_2 = vectornormalize(var_0.origin - self.origin);
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectorcross(var_3, var_2);
  if(var_4[2] > 0 && var_1 == "left") {
    return 1;
  }

  if(var_4[2] < 0 && var_1 == "right") {
    return 1;
  }

  return 0;
}

func_2935(var_0, var_1, var_2, var_3) {
  if(!bb_hasshufflenode(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return func_9F53(self._blackboard.shufflenode, var_3);
}

func_2933(var_0, var_1, var_2, var_3) {
  if(!bb_hasshufflenode(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  if(!func_9F53(self._blackboard.shufflenode, var_3)) {
    return 0;
  }

  if(var_3 == "right") {
    return self._blackboard.var_1016B.type == "Cover Right" && self._blackboard.shufflenode.type == "Cover Left";
  }

  return self._blackboard.var_1016B.type == "Cover Left" && self._blackboard.shufflenode.type == "Cover Right";
}

bb_setanimscripted() {
  self._blackboard.animscriptedactive = 1;
}

bb_clearanimscripted() {
  self._blackboard.animscriptedactive = 0;
}

bb_isanimscripted() {
  if(!isDefined(self.script)) {
    return 0;
  }

  return self.script == "scripted" || self.script == "<custom>" || scripts\engine\utility::istrue(self._blackboard.animscriptedactive);
}

bb_requestmelee(var_0) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = var_0;
  self._blackboard.meleerequestedcomplete = 0;
}

bb_getmeleetarget() {
  if(!isDefined(self._blackboard.meleerequested)) {
    return undefined;
  }

  return self._blackboard.meleerequestedtarget;
}

bb_clearmeleerequest() {
  self._blackboard.meleerequested = undefined;
  self._blackboard.meleerequestedtarget = undefined;
}

bb_clearmeleerequestcomplete() {
  self._blackboard.meleerequestedcomplete = undefined;
}

bb_meleeinprogress(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequestedcomplete);
}

bb_meleecomplete(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequestedcomplete) && self._blackboard.meleerequestedcomplete;
}

bb_meleerequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequested) && self._blackboard.meleerequested;
}

bb_meleerequestinvalid(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(!isDefined(self.melee.target)) {
    return 1;
  }

  return 0;
}

bb_requestmeleecharge(var_0, var_1) {
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = var_0;
  self._blackboard.meleerequestedcharge_targetposition = var_1;
}

bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = undefined;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

bb_meleechargerequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.vehicle_getspawnerarray);
}

func_2957(var_0, var_1, var_2, var_3) {
  return !bb_meleechargerequested(var_0, var_1, var_2, var_3);
}

bb_meleechargeaborted(var_0, var_1, var_2, var_3) {
  if(bb_meleechargerequested(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return 1;
}

func_2923() {
  if(!isDefined(self._blackboard.meleerequestedcharge)) {
    return undefined;
  }

  return self._blackboard.meleerequestedcharge_target;
}

func_2924() {
  return self._blackboard.meleerequestedcharge_targetposition;
}

func_2964(var_0) {
  self._blackboard.var_2AB0 = var_0;
}

func_293D(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.var_2AB0) && self._blackboard.var_2AB0;
}

func_2963(var_0) {
  self._blackboard.var_2AAF = var_0;
}

func_293C() {
  return isDefined(self._blackboard.var_2AAF) && self._blackboard.var_2AAF;
}

bb_requestwhizby(var_0) {
  self._blackboard.whizbyevent = var_0;
}

bb_iswhizbyrequested() {
  return isDefined(self._blackboard.whizbyevent);
}

bb_getrequestedwhizby() {
  return self._blackboard.whizbyevent;
}

bb_isfrantic() {
  var_0 = bb_getcovernode();
  if(!isDefined(var_0)) {
    var_0 = self.target_getindexoftarget;
  }

  var_1 = isDefined(var_0) && var_0.type == "Conceal Crouch" || var_0.type == "Conceal Stand";
  return self._blackboard.movetype == "frantic" && !var_1;
}

bb_ismissingaleg() {
  var_0 = bb_getmissingleg();
  if(isDefined(var_0)) {
    return 1;
  }

  return 0;
}

bb_getmissingleg() {
  var_0 = 0;
  var_1 = undefined;
  if(!isDefined(self._blackboard.dismemberedparts)) {
    return var_1;
  }

  if(isDefined(self._blackboard.dismemberedparts["left_leg"])) {
    var_0++;
    var_1 = "left";
  }

  if(isDefined(self._blackboard.dismemberedparts["right_leg"])) {
    var_0++;
    var_1 = "right";
  }

  if(var_0 == 2) {
    var_1 = "both";
  }

  return var_1;
}

ispartdismembered(var_0) {
  if(!isDefined(self._blackboard)) {
    return 0;
  }

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0])) {
      return 0;
    }

    return self._blackboard.scriptableparts[var_0].state == "dismember";
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return 0;
  }

  return isDefined(self._blackboard.dismemberedparts[var_0]);
}

bb_ispartdismembered(var_0, var_1, var_2, var_3) {
  return ispartdismembered(var_3);
}

waspartjustdismembered(var_0) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0])) {
      return 0;
    }

    if(self._blackboard.scriptableparts[var_0].state != "dismember") {
      return 0;
    }

    return self._blackboard.scriptableparts[var_0].time == gettime();
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return 0;
  }

  if(!isDefined(self._blackboard.dismemberedparts[var_0])) {
    return 0;
  }

  return self._blackboard.dismemberedparts[var_0] == gettime();
}

func_298F(var_0, var_1, var_2, var_3) {
  return waspartjustdismembered(var_3);
}

bb_werepartsdismemberedinorder(var_0, var_1, var_2, var_3) {
  return ispartdismembered(var_3[0]) && waspartjustdismembered(var_3[1]);
}

bb_dismemberedpart(var_0) {
  self._blackboard.dismemberedparts[var_0] = gettime();
}

bb_setselfdestruct(var_0) {
  self._blackboard.selfdestruct = var_0;
}

bb_isselfdestruct() {
  if(!isDefined(self._blackboard.selfdestruct)) {
    if(isDefined(self.bt.forceselfdestructtimer) && gettime() > self.bt.forceselfdestructtimer) {
      self._blackboard.selfdestruct = 1;
    }
  }

  return isDefined(self._blackboard.selfdestruct);
}

func_2972() {
  self._blackboard.selfdestructnow = 1;
}

bb_selfdestructnow() {
  return isDefined(self._blackboard.selfdestructnow);
}

bb_setheadless(var_0) {
  self._blackboard.isheadless = var_0;
}

bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab)) {
    return 0;
  }

  return isDefined(self._blackboard.isheadless);
}

bb_setcanrodeo(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = "left";
  if(var_0 == var_2) {
    var_2 = "right";
  }

  if(isDefined(self._blackboard.rodeo) && isDefined(self._blackboard.rodeo[var_2])) {
    self._blackboard.rodeo[var_2] = 0;
    self._blackboard.rodeo[var_0] = 0;
    return;
  }

  self._blackboard.rodeo[var_0] = var_1;
}

bb_canrodeo(var_0) {
  if(!isDefined(self._blackboard.rodeo)) {
    return 0;
  }

  if(!isDefined(self._blackboard.rodeo[var_0])) {
    return 0;
  }

  if(!self._blackboard.rodeo[var_0]) {
    return 0;
  }

  return 1;
}

bb_setrodeorequest(var_0) {
  self._blackboard.rodeorequested = var_0;
}

bb_clearrodeorequest(var_0) {
  self._blackboard.var_E600 = undefined;
}

bb_isrodeorequested(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.rodeorequested)) {
    return 0;
  }

  return 1;
}

bb_setmeleetarget(var_0) {
  self.melee = spawnStruct();
  var_0.melee = spawnStruct();
  self.melee.target = var_0;
  self.melee.partner = var_0;
  var_0.melee.partner = self;
}

bb_clearmeleetarget() {
  if(!isDefined(self.melee)) {
    return;
  }

  if(isDefined(self.melee.target)) {
    self.melee.target.melee = undefined;
  }

  if(isDefined(self.melee.temp_ent)) {
    self.melee.temp_ent delete();
  }

  self.melee = undefined;
}

func_2977(var_0) {
  self._blackboard.crawlmelee = var_0;
}

bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

func_297B(var_0) {
  self._blackboard.var_8C52 = var_0;
}

func_293E() {
  return isDefined(self._blackboard.var_8C52);
}

func_2922() {
  return self._blackboard.var_8C52;
}

bb_setisinbadcrouchspot(var_0) {
  self._blackboard.var_2992 = var_0;
}

bb_isinbadcrouchspot() {
  return isDefined(self._blackboard.var_2992) && self._blackboard.var_2992;
}

bb_setcivilianstate(var_0) {
  self._blackboard.civstate = var_0;
  self._blackboard.civstatetime = gettime();
}

func_291D(var_0) {
  return self._blackboard.civstate;
}

func_291E() {
  return self._blackboard.civstatetime;
}

func_1005F(var_0, var_1, var_2, var_3) {
  return !isDefined(self.bpowerdown) || !self.bpowerdown;
}

bb_isshort() {
  return isDefined(self._blackboard.var_FEED) && self._blackboard.var_FEED;
}

func_2984(var_0) {
  self._blackboard.var_FEED = var_0;
}