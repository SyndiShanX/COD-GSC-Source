/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
***********************************************/

function bb_getprefixstring(var0) {
  return undefined;
}

function bb_wantstostrafe() {
  if(isDefined(self._blackboard.meleerequested) && self._blackboard.meleerequested) {
    return 1;
  }

  if(isDefined(self._blackboard.bwantstostrafe)) {
    return self._blackboard.bwantstostrafe;
  }

  return 0;
}

function bb_requeststance(var0) {
  self._blackboard.desiredstance = var0;
}

function bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

function bb_isrequestedstance_refresh(var0, var1, var2, var3) {
  var4 = scripts\asm\shared\utility::determinerequestedstance();
  return var4 == var3;
}

function bb_isrequestedstanceanddemeanor(var0, var1, var2, var3) {
  return self._blackboard.desiredstance == var3[0] && scripts\asm\asm::asm_getdemeanor() == var3[1];
}

function bb_setisincombat(var0) {
  self.bisincombat = !isDefined(var0) || var0;
}

function bb_isincombat() {
  return self.bisincombat;
}

function bb_isweaponclass(var0, var1, var2, var3) {
  return weaponclass(self.weapon) == var3;
}

function bb_shoulddroprocketlauncher(var0, var1, var2, var3) {
  if(weaponclass(self.weapon) != "rocketlauncher") {
    return false;
  }

  var4 = bb_getrequestedweapon();

  if(!isDefined(var4)) {
    return false;
  }

  return var4 != "rocketlauncher";
}

function bb_requestmove() {}

function bb_clearmoverequest() {}

function bb_moverequested() {
  return self codemoverequested();
}

function bb_movetyperequested(var0) {
  return self._blackboard.movetype == var0;
}

function bb_requestmovetype(var0) {
  self._blackboard.movetype = var0;
}

function bb_requestweapon(var0) {
  self._blackboard.weaponrequest = var0;
}

function bb_clearweaponrequest() {
  self._blackboard.weaponrequest = "none";
}

function bb_getrequestedweapon() {
  if(isDefined(self._blackboard.weaponrequest) && self._blackboard.weaponrequest == "none") {
    return undefined;
  }

  return self._blackboard.weaponrequest;
}

function bb_requestreload(var0) {
  if(!isDefined(var0)) {
    self._blackboard.breload = 1;
    return;
  }

  self._blackboard.breload = var0;
}

function bb_reloadrequested() {
  return self._blackboard.breload;
}

function bb_requestthrowgrenade(var0, var1) {
  if(!isDefined(var0)) {
    self._blackboard.bthrowgrenade = 1;
  } else {
    self._blackboard.bthrowgrenade = var0;
  }

  if(self._blackboard.bthrowgrenade) {
    self._blackboard.throwgrenadetarget = var1;
    return;
  }

  self._blackboard.throwgrenadetarget = undefined;
}

function bb_throwgrenaderequested() {
  if(isDefined(self._blackboard.bthrowgrenade)) {
    return (self._blackboard.bthrowgrenade && isDefined(self._blackboard.throwgrenadetarget));
  }

  return false;
}

function bb_getthrowgrenadetarget() {
  return self._blackboard.throwgrenadetarget;
}

function bb_requestfire(var0) {
  if(!isDefined(var0)) {
    self._blackboard.bfire = 1;
    return;
  }

  self._blackboard.bfire = var0;
}

function bb_firerequested() {
  return istrue(self._blackboard.bfire);
}

function bb_newshootparams(var0, var1, var2) {
  self._blackboard.shootparams_writeid++;
  self._blackboard.shootparams_starttime = gettime();
  self._blackboard.shootparams_pos = var0;
  self._blackboard.shootparams_ent = var1;
  self._blackboard.shootparams_buseentinshootcalc = var2;
  self._blackboard.shootparams_objective = "normal";
  self._blackboard.shootparams_valid = 1;
}

function bb_updateshootparams(var0, var1, var2) {
  if(bb_issameshootparamsent(var1, var2)) {
    bb_updateshootparams_posandent(var0, var1, var2);
    return;
  }

  bb_newshootparams(var0, var1, var2);
}

function bb_claimshootparams(var0) {
  self._blackboard.shootparams_taskid = var0;
}

function bb_issameshootparamsent(var0, var1) {
  if(!istrue(self._blackboard.shootparams_valid)) {
    return false;
  }

  if(isDefined(var0) && !isDefined(self._blackboard.shootparams_ent)) {
    return false;
  } else if(!isDefined(var0) && isDefined(self._blackboard.shootparams_ent)) {
    return false;
  } else if(isDefined(var0) && isDefined(self._blackboard.shootparams_ent) && var0 != self._blackboard.shootparams_ent) {
    return false;
  }

  return true;
}

function bb_shootparams_empty() {
  if(!istrue(self._blackboard.shootparams_valid)) {
    return true;
  }

  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent)) {
    return true;
  }

  return false;
}

function bb_shootparams_idsmatch() {
  if(!istrue(self._blackboard.shootparams_valid)) {
    return false;
  }

  if(!isDefined(self._blackboard.shootparams_readid)) {
    return false;
  }

  return self._blackboard.shootparams_writeid == self._blackboard.shootparams_readid;
}

function bb_updateshootparams_pos(var0) {
  self._blackboard.shootparams_pos = var0;
}

function bb_updateshootparams_posandent(var0, var1, var2) {
  self._blackboard.shootparams_pos = var0;
  self._blackboard.shootparams_ent = var1;
  self._blackboard.shootparams_buseentinshootcalc = var2;
}

function bb_clearshootparams() {
  self._blackboard.shootparams_ent = undefined;
  self._blackboard.shootparams_valid = 0;
}

function bb_setshootparams(var0, var1) {}

function bb_shootparamsvalid() {
  if(istrue(self._blackboard.shootparams_valid)) {
    if(isDefined(self.shootposoverride) && isDefined(self._blackboard.shootparams_pos)) {
      return 1;
    }

    if(istrue(self.dontevershoot)) {
      return 0;
    }

    if(isDefined(self._blackboard.shootparams_ent) && isDefined(self.enemy) && self.enemy == self._blackboard.shootparams_ent) {
      return self iscurrentenemyvalid();
    }
  }

  return 0;
}

function bb_requestcoverstate(var0) {
  self._blackboard.coverstate = var0;
}

function bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate)) {
    return "none";
  }

  return self._blackboard.coverstate;
}

function bb_requestcoverexposetype(var0) {
  self._blackboard.coverexposetype = var0;
}

function bb_getrequestedcoverexposetype() {
  return self._blackboard.coverexposetype;
}

function bb_requestcoverblindfire(var0) {
  self._blackboard.blindfire = var0;
}

function bb_setcovernode(var0) {
  self._blackboard.covernode = var0;
  self._blackboard.bhascovernode = isDefined(var0);
}

function bb_hadcovernode(var0, var1, var2, var3) {
  return istrue(self._blackboard.bhascovernode);
}

function bb_getcovernode() {
  return self._blackboard.covernode;
}

function bb_getrequestedturret() {
  if(isDefined(self._blackboard.requestedturret)) {
    return self._blackboard.requestedturret;
  }

  return undefined;
}

function bb_requestturret(var0) {
  self._blackboard.requestedturret = var0;
}

function bb_requestturretpose(var0) {
  self._blackboard.requestedturretpose = var0;
}

function bb_hasshufflenode(var0, var1, var2, var3) {
  return isDefined(self._blackboard.shufflenode) && isDefined(self.node) && self._blackboard.shufflenode == self.node && distancesquared(self.node.origin, self.origin) > 16;
}

function bb_setanimScripted() {
  self._blackboard.animscriptedactive = 1;
}

function bb_clearanimScripted() {
  self._blackboard.animscriptedactive = 0;
}

function bb_isanimScripted() {
  if(isDefined(self.script)) {
    if(self.script == "scripted" || self.script == "<custom>") {
      return true;
    }
  }

  return istrue(self._blackboard.animscriptedactive);
}

function bb_requestmelee(var0) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = var0;
  self._blackboard.meleerequestedcomplete = 0;
}

function bb_getmeleetarget() {
  if(!self._blackboard.meleerequested) {
    return undefined;
  }

  return self._blackboard.meleerequestedtarget;
}

function bb_clearmeleerequest() {
  self._blackboard.meleerequested = 0;
  self._blackboard.meleerequestedtarget = undefined;
  self._blackboard.ref_11bc0 = undefined;
}

function bb_clearmeleerequestcomplete() {
  self._blackboard.meleerequestedcomplete = undefined;
}

function bb_meleeinprogress(var0, var1, var2, var3) {
  return isDefined(self._blackboard.meleerequestedcomplete);
}

function bb_meleecomplete(var0, var1, var2, var3) {
  return isDefined(self._blackboard.meleerequestedcomplete) && self._blackboard.meleerequestedcomplete;
}

function bb_meleerequested() {
  return self._blackboard.meleerequested;
}

function bb_meleerequestinvalid(var0, var1, var2, var3) {
  if(!isDefined(self.melee)) {
    return true;
  }

  if(!isDefined(self.melee.target)) {
    return true;
  }

  return false;
}

function bb_requestmeleecharge(var0, var1) {
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = var0;
  self._blackboard.meleerequestedcharge_targetposition = var1;
}

function bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = 0;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

function bb_meleechargerequested() {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.pathgoalpos);
}

function bb_meleechargeaborted(var0, var1, var2, var3) {
  if(bb_meleechargerequested()) {
    return false;
  }

  return true;
}

function bb_getmeleechargetarget() {
  if(!isDefined(self._blackboard.meleerequestedcharge) || !self._blackboard.meleerequestedcharge) {
    return undefined;
  }

  return self._blackboard.meleerequestedcharge_target;
}

function bb_getmeleechargetargetpos() {
  return self._blackboard.meleerequestedcharge_targetposition;
}

function bb_requestgrenadereturnthrow(var0) {
  self._blackboard.bgrenadereturnthrow = var0;
}

function bb_requestwhizby(var0) {
  self._blackboard.whizbyevent = var0;
}

function bb_iswhizbyrequested() {
  return isDefined(self._blackboard.whizbyevent);
}

function bb_getrequestedwhizby() {
  return self._blackboard.whizbyevent;
}

function bb_isfrantic() {
  var0 = bb_getcovernode();

  if(!isDefined(var0)) {
    var0 = self.node;
  }

  var1 = isDefined(var0) && (var0.type == "Conceal Crouch" || var0.type == "Conceal Stand");
  return self._blackboard.movetype == "frantic" && !var1;
}

function bb_ismissingaleg() {
  var0 = bb_getmissingleg();

  if(isDefined(var0)) {
    return true;
  }

  return false;
}

function bb_getmissingleg() {
  var0 = 0;
  var1 = undefined;

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return var1;
  }

  if(isDefined(self._blackboard.dismemberedparts["left_leg"])) {
    var0++;
    var1 = "left";
  }

  if(isDefined(self._blackboard.dismemberedparts["right_leg"])) {
    var0++;
    var1 = "right";
  }

  if(var0 == 2) {
    var1 = "both";
  }

  return var1;
}

function ispartdismembered(var0) {
  if(!isDefined(self._blackboard)) {
    return false;
  }

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var0])) {
      return false;
    }

    return (self._blackboard.scriptableparts[var0].state == "dismember");
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  return isDefined(self._blackboard.dismemberedparts[var0]);
}

function bb_ispartdismembered(var0, var1, var2, var3) {
  return ispartdismembered(var3);
}

function waspartjustdismembered(var0) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var0])) {
      return false;
    }

    if(self._blackboard.scriptableparts[var0].state != "dismember") {
      return false;
    }

    return (self._blackboard.scriptableparts[var0].time == gettime());
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  if(!isDefined(self._blackboard.dismemberedparts[var0])) {
    return false;
  }

  return self._blackboard.dismemberedparts[var0] == gettime();
}

function bb_waspartjustdismembered(var0, var1, var2, var3) {
  return waspartjustdismembered(var3);
}

function bb_werepartsdismemberedinorder(var0, var1, var2, var3) {
  return ispartdismembered(var3[0]) && waspartjustdismembered(var3[1]);
}

function bb_dismemberedpart(var0) {
  self._blackboard.dismemberedparts[var0] = gettime();
}

function bb_setselfdestruct(var0) {
  self._blackboard.selfdestruct = var0;
}

function bb_isselfdestruct() {
  if(!isDefined(self._blackboard.selfdestruct)) {
    if(isDefined(self.bt.forceselfdestructtimer) && gettime() > self.bt.forceselfdestructtimer) {
      self._blackboard.selfdestruct = 1;
    }
  }

  return isDefined(self._blackboard.selfdestruct);
}

function bb_selfdestructnow() {
  self._blackboard.selfdestructnow = 1;
}

function bb_shouldselfdestructnow() {
  return isDefined(self._blackboard.selfdestructnow);
}

function bb_setheadless(var0) {
  self._blackboard.isheadless = var0;
}

function bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab)) {
    return false;
  }

  return isDefined(self._blackboard.isheadless);
}

function bb_setcanrodeo(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = "left";

  if(var0 == var2) {
    var2 = "right";
  }

  if(isDefined(self._blackboard.rodeo) && isDefined(self._blackboard.rodeo[var2])) {
    self._blackboard.rodeo[var2] = 0;
    self._blackboard.rodeo[var0] = 0;
    return;
  }

  self._blackboard.rodeo[var0] = var1;
}

function bb_canrodeo(var0) {
  if(!isDefined(self._blackboard.rodeo)) {
    return false;
  }

  if(!isDefined(self._blackboard.rodeo[var0])) {
    return false;
  }

  if(!self._blackboard.rodeo[var0]) {
    return false;
  }

  return true;
}

function bb_setrodeorequest(var0) {
  self._blackboard.rodeorequest = var0;
}

function bb_clearrodeorequest(var0) {
  self._blackboard.rodeorequested = undefined;
}

function bb_isrodeorequested(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.rodeorequest)) {
    return false;
  }

  return true;
}

function bb_setmeleetarget(var0) {
  self.melee = spawnStruct();
  var0.melee = spawnStruct();
  self.melee.target = var0;
  self.melee.partner = var0;
  var0.melee.partner = self;
}

function bb_clearmeleetarget() {
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

function bb_setcrawlmelee(var0) {
  self._blackboard.crawlmelee = var0;
}

function bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

function bb_sethaywire(var0) {
  self._blackboard.haywire = var0;
}

function bb_ishaywire() {
  return isDefined(self._blackboard.haywire);
}

function bb_gethaywire() {
  return self._blackboard.haywire;
}

function bb_setisinbadcrouchspot(var0) {
  self._blackboard.bbadcrouchspot = var0;
}

function bb_isinbadcrouchspot() {
  return istrue(self._blackboard.bbadcrouchspot);
}

function bb_setcivilianstate(var0) {
  if(isDefined(self._blackboard.civstate) && self._blackboard.civstate == var0) {
    return;
  }

  self._blackboard.civstate = var0;
  self._blackboard.civstatetime = gettime();
}

function bb_getcivilianstate() {
  return self._blackboard.civstate;
}

function bb_getcivilianstatetime() {
  return self._blackboard.civstatetime;
}

function bb_civilianrequestspeed(var0) {
  scripts\engine\utility::set_movement_speed(var0);
}

function bb_isshort() {
  return istrue(self._blackboard.short);
}

function bb_setshort(var0) {
  self._blackboard.short = var0;
}

function bb_smartobjectrequested() {
  return isDefined(self._blackboard.smartobject);
}

function bb_requestsmartobject(var0) {
  self._blackboard.smartobject = var0;
}

function bb_getrequestedsmartobject() {
  return self._blackboard.smartobject;
}

function bb_clearsmartobject() {
  self._blackboard.smartobject = undefined;
  bb_clearplaysmartobject();
}

function bb_requestplaysmartobject() {
  self._blackboard.bplaysmartobject = 1;
}

function bb_clearplaysmartobject() {
  self._blackboard.bplaysmartobject = undefined;
}

function bb_playsmartobjectrequested() {
  return istrue(self._blackboard.bplaysmartobject);
}

function bb_requestcovermultiswitch(var0, var1) {
  self._blackboard.docovermultiswitchnode = var0;
  self._blackboard.docovermultiswitchnodetype = var1;
}

function bb_getrequestedcovermultiswitchnodetype() {
  return [self._blackboard.docovermultiswitchnode, self._blackboard.docovermultiswitchnodetype];
}

function bb_resetcovermultiswitch() {
  self._blackboard.docovermultiswitchnode = undefined;
  self._blackboard.docovermultiswitchnodetype = undefined;
}

function bb_iscovermultiswitchrequested() {
  return isDefined(self._blackboard.docovermultiswitchnode);
}

function bb_canplaygesture(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return false;
  }

  if(isDefined(var3) && self._blackboard.gesturerequest.gesture != var3) {
    return false;
  }

  if(!isDefined(self._blackboard.gesturerequest.latestalias)) {
    return false;
  }

  if(gettime() > self._blackboard.gesturerequest.timeoutms) {
    return false;
  }

  var4 = self._blackboard.gesturerequest.latestalias;

  if(!scripts\asm\asm::asm_hasalias(var2, var4)) {
    return false;
  }

  return true;
}

function bb_shouldwildfire(var0, var1, var2) {
  if(!istrue(self._blackboard.isrebel)) {
    return false;
  }

  var3 = 50;
  return randomint(100) <= var3;
}