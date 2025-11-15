/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
**********************************/

func_2980(param_00, param_01) {
  self.var_1198.var_1FC7[param_00] = param_01;
}

func_2927(param_00) {
  if(isDefined(self.var_1198.var_1FC7) && isDefined(self.var_1198.var_1FC7[param_00])) {
    return self.var_1198.var_1FC7[param_00];
  }

  return undefined;
}

func_2928(param_00) {
  var_01 = func_2927(param_00);
  if(isDefined(var_01) && var_01.size > 0) {
    return var_01 + "_";
  }

  return undefined;
}

bb_wantstostrafe() {
  if(isDefined(self.var_1198.meleerequested) && self.var_1198.meleerequested) {
    return 1;
  }

  if(isDefined(self.var_1198.bwantstostrafe)) {
    return self.var_1198.bwantstostrafe;
  }

  return 0;
}

func_9DA4(param_00, param_01, param_02, param_03) {
  return self.a.pose == param_03;
}

bb_requestsmartobject(param_00) {
  self.var_1198.var_527D = param_00;
}

func_292C() {
  return self.var_1198.var_527D;
}

func_2949(param_00, param_01, param_02, param_03) {
  return self.var_1198.var_527D == param_03;
}

bb_setisincombat(param_00) {
  self.var_1198.var_2B11 = !isDefined(param_00) || param_00;
}

bb_isincombat() {
  if(isDefined(self.var_1198.var_2B11)) {
    return self.var_1198.var_2B11;
  }

  return 0;
}

bb_isweaponclass(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::weaponclass(self.var_394) == param_03;
}

bb_shoulddroprocketlauncher(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::weaponclass(self.var_394) != "rocketlauncher") {
    return 0;
  }

  var_04 = bb_getrequestedweapon();
  if(!isDefined(var_04)) {
    return 0;
  }

  return var_04 != "rocketlauncher";
}

bb_requestmove() {}

bb_clearmoverequest() {}

bb_moverequested() {
  return self codemoverequested();
}

func_2958(param_00, param_01, param_02, param_03) {
  return !self codemoverequested();
}

bb_movetyperequested(param_00) {
  return self.var_1198.movetype == param_00;
}

bb_requestmovetype(param_00) {
  self.var_1198.movetype = param_00;
  if(param_00 == "cqb") {
    self.asm.var_13CAF = 0;
  }
}

bb_requestweapon(param_00) {
  self.var_1198.weaponrequest = param_00;
}

bb_clearweaponrequest() {
  self.var_1198.weaponrequest = undefined;
}

bb_getrequestedweapon() {
  return self.var_1198.weaponrequest;
}

bb_requestreload(param_00) {
  if(!isDefined(param_00)) {
    self.var_1198.breload = 1;
    return;
  }

  self.var_1198.breload = param_00;
}

bb_reloadrequested() {
  if(isDefined(self.var_1198.breload)) {
    return self.var_1198.breload;
  }

  return 0;
}

bb_requestthrowgrenade(param_00, param_01) {
  if(!isDefined(param_00)) {
    self.var_1198.bthrowgrenade = 1;
  } else {
    self.var_1198.bthrowgrenade = param_00;
  }

  if(self.var_1198.bthrowgrenade) {
    self.var_1198.throwgrenadetarget = param_01;
    return;
  }

  self.var_1198.throwgrenadetarget = undefined;
}

bb_throwgrenaderequested() {
  if(isDefined(self.var_1198.bthrowgrenade)) {
    return self.var_1198.bthrowgrenade && isDefined(self.var_1198.throwgrenadetarget);
  }

  return 0;
}

bb_getthrowgrenadetarget() {
  return self.var_1198.throwgrenadetarget;
}

bb_requestfire(param_00, param_01) {
  if(!isDefined(param_00)) {
    self.var_1198.bfire = 1;
  } else {
    self.var_1198.bfire = param_00;
  }

  if(self.var_1198.bfire) {
    self.var_1198.var_1182F = param_01;
    return;
  }

  self.var_1198.var_1182F = undefined;
}

func_298B() {
  if(isDefined(self.var_1198.bfire)) {
    return self.var_1198.bfire && isDefined(self.var_1198.var_1182F);
  }

  return 0;
}

func_2931() {
  return self.var_1198.var_1182F;
}

bb_requestfire(param_00) {
  if(!isDefined(param_00)) {
    self.var_1198.var_2AA6 = 1;
    return;
  }

  self.var_1198.var_2AA6 = param_00;
}

func_291C() {
  if(isDefined(self.var_1198.var_2AA6)) {
    return self.var_1198.var_2AA6;
  }

  return 0;
}

bb_setshootparams(param_00, param_01) {
  self.var_1198.shootparams = param_00;
  if(isDefined(param_00)) {
    self.var_1198.shootparams.target = param_01;
    if(isDefined(param_01)) {
      self.var_1198.shootparams.var_3137 = 1;
      return;
    }

    self.var_1198.shootparams.var_3137 = undefined;
  }
}

func_2985() {
  if(isDefined(self.var_1198.shootparams)) {
    if(isDefined(self.var_FED1) && isDefined(self.var_1198.shootparams.pos)) {
      return 1;
    }

    if(isDefined(self.dontevershoot) && self.dontevershoot) {
      return 0;
    }

    if(isDefined(self.var_1198.shootparams.target) && isDefined(self.isnodeoccupied) && self.isnodeoccupied == self.var_1198.shootparams.target) {
      return scripts\engine\utility::func_9DA3();
    }
  }

  return 0;
}

func_2961(param_00) {
  self.var_1198.coverstate = param_00;
}

bb_getrequestedcoverstate() {
  if(!isDefined(self.var_1198.coverstate)) {
    return "none";
  }

  return self.var_1198.coverstate;
}

func_2948(param_00, param_01, param_02, param_03) {
  return bb_getrequestedcoverstate() == param_03;
}

func_2944(param_00, param_01, param_02, param_03) {
  return bb_getrequestedcoverstate() != param_03;
}

func_295E(param_00) {
  self.var_1198.var_4720 = param_00;
}

func_2929() {
  return self.var_1198.var_4720;
}

func_2947(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.var_4720) && self.var_1198.var_4720 == param_03;
}

func_2946(param_00, param_01, param_02, param_03) {
  return bb_getrequestedcoverstate() == "exposed" && func_2947(param_00, param_01, param_02, param_03);
}

func_2943(param_00, param_01, param_02, param_03) {
  return bb_getrequestedcoverstate() != "exposed" || !func_2947(param_00, param_01, param_02, param_03);
}

func_295D(param_00) {
  self.var_1198.var_2996 = param_00;
}

func_291A() {
  return isDefined(self.var_1198.var_2996) && self.var_1198.var_2996;
}

bb_setcovernode(param_00) {
  self.var_1198.covernode = param_00;
  self.var_1198.bhascovernode = isDefined(param_00);
}

func_2932() {
  return isDefined(self.var_1198.bhascovernode) && self.var_1198.bhascovernode;
}

bb_getcovernode() {
  return self.var_1198.covernode;
}

bb_getrequestedturret() {
  if(isDefined(self.var_1198.requestedturret)) {
    return self.var_1198.requestedturret;
  }

  return undefined;
}

func_296E(param_00) {
  self.var_1198.requestedturret = param_00;
}

func_296F(param_00) {
  self.var_1198.var_E1AF = param_00;
}

bb_hasshufflenode(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.shufflenode) && isDefined(self.target_getindexoftarget) && self.var_1198.shufflenode == self.target_getindexoftarget && distancesquared(self.target_getindexoftarget.origin, self.origin) > 16;
}

func_2936(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_1198.shufflenode)) {
    return 0;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(self.var_1198.shufflenode != self.target_getindexoftarget) {
    return 0;
  }

  if(distancesquared(self.target_getindexoftarget.origin, self.origin) <= 16) {
    return 0;
  }

  if(self.var_1198.shufflenode.type != param_03) {
    return 0;
  }

  return 1;
}

func_9F53(param_00, param_01) {
  var_02 = vectornormalize(param_00.origin - self.origin);
  var_03 = anglesToForward(param_00.angles);
  var_04 = vectorcross(var_03, var_02);
  if(var_04[2] > 0 && param_01 == "left") {
    return 1;
  }

  if(var_04[2] < 0 && param_01 == "right") {
    return 1;
  }

  return 0;
}

func_2935(param_00, param_01, param_02, param_03) {
  if(!bb_hasshufflenode(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  return func_9F53(self.var_1198.shufflenode, param_03);
}

func_2933(param_00, param_01, param_02, param_03) {
  if(!bb_hasshufflenode(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  if(!func_9F53(self.var_1198.shufflenode, param_03)) {
    return 0;
  }

  if(param_03 == "right") {
    return self.var_1198.var_1016B.type == "Cover Right" && self.var_1198.shufflenode.type == "Cover Left";
  }

  return self.var_1198.var_1016B.type == "Cover Left" && self.var_1198.shufflenode.type == "Cover Right";
}

bb_setanimscripted() {
  self.var_1198.animscriptedactive = 1;
}

bb_clearanimscripted() {
  self.var_1198.animscriptedactive = 0;
}

bb_isanimscripted() {
  if(!isDefined(self.script)) {
    return 0;
  }

  return self.script == "scripted" || self.script == "<custom>" || scripts\engine\utility::istrue(self.var_1198.animscriptedactive);
}

bb_requestmelee(param_00) {
  self.var_1198.meleerequested = 1;
  self.var_1198.meleerequestedtarget = param_00;
  self.var_1198.meleerequestedcomplete = 0;
}

bb_getmeleetarget() {
  if(!isDefined(self.var_1198.meleerequested)) {
    return undefined;
  }

  return self.var_1198.meleerequestedtarget;
}

bb_clearmeleerequest() {
  self.var_1198.meleerequested = undefined;
  self.var_1198.meleerequestedtarget = undefined;
}

bb_clearmeleerequestcomplete() {
  self.var_1198.meleerequestedcomplete = undefined;
}

bb_meleeinprogress(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.meleerequestedcomplete);
}

bb_meleecomplete(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.meleerequestedcomplete) && self.var_1198.meleerequestedcomplete;
}

bb_meleerequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.meleerequested) && self.var_1198.meleerequested;
}

bb_meleerequestinvalid(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(!isDefined(self.melee.target)) {
    return 1;
  }

  return 0;
}

bb_requestmeleecharge(param_00, param_01) {
  self.var_1198.meleerequestedcharge = 1;
  self.var_1198.meleerequestedcharge_target = param_00;
  self.var_1198.meleerequestedcharge_targetposition = param_01;
}

bb_clearmeleechargerequest() {
  self.var_1198.meleerequestedcharge = undefined;
  self.var_1198.meleerequestedcharge_target = undefined;
  self.var_1198.meleerequestedcharge_targetposition = undefined;
}

bb_meleechargerequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.meleerequestedcharge) && self.var_1198.meleerequestedcharge && isDefined(self.vehicle_getspawnerarray);
}

func_2957(param_00, param_01, param_02, param_03) {
  return !bb_meleechargerequested(param_00, param_01, param_02, param_03);
}

bb_meleechargeaborted(param_00, param_01, param_02, param_03) {
  if(bb_meleechargerequested(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  return 1;
}

func_2923() {
  if(!isDefined(self.var_1198.meleerequestedcharge)) {
    return undefined;
  }

  return self.var_1198.meleerequestedcharge_target;
}

func_2924() {
  return self.var_1198.meleerequestedcharge_targetposition;
}

func_2964(param_00) {
  self.var_1198.var_2AB0 = param_00;
}

func_293D(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.var_2AB0) && self.var_1198.var_2AB0;
}

func_2963(param_00) {
  self.var_1198.var_2AAF = param_00;
}

func_293C() {
  return isDefined(self.var_1198.var_2AAF) && self.var_1198.var_2AAF;
}

bb_requestwhizby(param_00) {
  self.var_1198.whizbyevent = param_00;
}

bb_iswhizbyrequested() {
  return isDefined(self.var_1198.whizbyevent);
}

bb_getrequestedwhizby() {
  return self.var_1198.whizbyevent;
}

bb_isfrantic() {
  var_00 = bb_getcovernode();
  if(!isDefined(var_00)) {
    var_00 = self.target_getindexoftarget;
  }

  var_01 = isDefined(var_00) && var_00.type == "Conceal Crouch" || var_00.type == "Conceal Stand";
  return self.var_1198.movetype == "frantic" && !var_01;
}

bb_ismissingaleg() {
  var_00 = bb_getmissingleg();
  if(isDefined(var_00)) {
    return 1;
  }

  return 0;
}

bb_getmissingleg() {
  var_00 = 0;
  var_01 = undefined;
  if(!isDefined(self.var_1198.dismemberedparts)) {
    return var_01;
  }

  if(isDefined(self.var_1198.dismemberedparts["left_leg"])) {
    var_00++;
    var_01 = "left";
  }

  if(isDefined(self.var_1198.dismemberedparts["right_leg"])) {
    var_00++;
    var_01 = "right";
  }

  if(var_00 == 2) {
    var_01 = "both";
  }

  return var_01;
}

ispartdismembered(param_00) {
  if(!isDefined(self.var_1198)) {
    return 0;
  }

  if(isDefined(self.var_1198.scriptableparts)) {
    if(!isDefined(self.var_1198.scriptableparts[param_00])) {
      return 0;
    }

    return self.var_1198.scriptableparts[param_00].state == "dismember";
  }

  if(!isDefined(self.var_1198.dismemberedparts)) {
    return 0;
  }

  return isDefined(self.var_1198.dismemberedparts[param_00]);
}

bb_ispartdismembered(param_00, param_01, param_02, param_03) {
  return ispartdismembered(param_03);
}

waspartjustdismembered(param_00) {
  if(isDefined(self.var_1198.scriptableparts)) {
    if(!isDefined(self.var_1198.scriptableparts[param_00])) {
      return 0;
    }

    if(self.var_1198.scriptableparts[param_00].state != "dismember") {
      return 0;
    }

    return self.var_1198.scriptableparts[param_00].time == gettime();
  }

  if(!isDefined(self.var_1198.dismemberedparts)) {
    return 0;
  }

  if(!isDefined(self.var_1198.dismemberedparts[param_00])) {
    return 0;
  }

  return self.var_1198.dismemberedparts[param_00] == gettime();
}

func_298F(param_00, param_01, param_02, param_03) {
  return waspartjustdismembered(param_03);
}

bb_werepartsdismemberedinorder(param_00, param_01, param_02, param_03) {
  return ispartdismembered(param_03[0]) && waspartjustdismembered(param_03[1]);
}

bb_dismemberedpart(param_00) {
  self.var_1198.dismemberedparts[param_00] = gettime();
}

bb_setselfdestruct(param_00) {
  self.var_1198.selfdestruct = param_00;
}

bb_isselfdestruct() {
  if(!isDefined(self.var_1198.selfdestruct)) {
    if(isDefined(self.var_3135.forceselfdestructtimer) && gettime() > self.var_3135.forceselfdestructtimer) {
      self.var_1198.selfdestruct = 1;
    }
  }

  return isDefined(self.var_1198.selfdestruct);
}

func_2972() {
  self.var_1198.selfdestructnow = 1;
}

bb_selfdestructnow() {
  return isDefined(self.var_1198.selfdestructnow);
}

bb_setheadless(param_00) {
  self.var_1198.isheadless = param_00;
}

bb_isheadless() {
  if(isDefined(self.var_3135.crawlmeleegrab)) {
    return 0;
  }

  return isDefined(self.var_1198.isheadless);
}

bb_setcanrodeo(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_02 = "left";
  if(param_00 == var_02) {
    var_02 = "right";
  }

  if(isDefined(self.var_1198.rodeo) && isDefined(self.var_1198.rodeo[var_02])) {
    self.var_1198.rodeo[var_02] = 0;
    self.var_1198.rodeo[param_00] = 0;
    return;
  }

  self.var_1198.rodeo[param_00] = param_01;
}

bb_canrodeo(param_00) {
  if(!isDefined(self.var_1198.rodeo)) {
    return 0;
  }

  if(!isDefined(self.var_1198.rodeo[param_00])) {
    return 0;
  }

  if(!self.var_1198.rodeo[param_00]) {
    return 0;
  }

  return 1;
}

bb_setrodeorequest(param_00) {
  self.var_1198.rodeorequested = param_00;
}

bb_clearrodeorequest(param_00) {
  self.var_1198.var_E600 = undefined;
}

bb_isrodeorequested(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_1198.rodeorequested)) {
    return 0;
  }

  return 1;
}

bb_setmeleetarget(param_00) {
  self.melee = spawnStruct();
  param_00.melee = spawnStruct();
  self.melee.target = param_00;
  self.melee.partner = param_00;
  param_00.melee.partner = self;
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

func_2977(param_00) {
  self.var_1198.crawlmelee = param_00;
}

bb_iscrawlmelee() {
  return isDefined(self.var_1198.crawlmelee);
}

func_297B(param_00) {
  self.var_1198.var_8C52 = param_00;
}

func_293E() {
  return isDefined(self.var_1198.var_8C52);
}

func_2922() {
  return self.var_1198.var_8C52;
}

bb_setisinbadcrouchspot(param_00) {
  self.var_1198.var_2992 = param_00;
}

bb_isinbadcrouchspot() {
  return isDefined(self.var_1198.var_2992) && self.var_1198.var_2992;
}

bb_setcivilianstate(param_00) {
  self.var_1198.civstate = param_00;
  self.var_1198.civstatetime = gettime();
}

func_291D(param_00) {
  return self.var_1198.civstate;
}

func_291E() {
  return self.var_1198.civstatetime;
}

func_1005F(param_00, param_01, param_02, param_03) {
  return !isDefined(self.bpowerdown) || !self.bpowerdown;
}

bb_isshort() {
  return isDefined(self.var_1198.var_FEED) && self.var_1198.var_FEED;
}

func_2984(param_00) {
  self.var_1198.var_FEED = param_00;
}