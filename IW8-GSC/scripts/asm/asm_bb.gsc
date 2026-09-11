/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
***********************************************/

function bb_getprefixstring(var_0) {
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

function bb_requeststance(var_0) {
  self._blackboard.desiredstance = var_0;
}

function bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

function bb_isrequestedstance_refresh(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\shared\utility::determinerequestedstance();
  return var_4 == var_3;
}

function bb_isrequestedstanceanddemeanor(var_0, var_1, var_2, var_3) {
  return self._blackboard.desiredstance == var_3[0] && scripts\asm\asm::asm_getdemeanor() == var_3[1];
}

function bb_setisincombat(var_0) {
  self.bisincombat = !isDefined(var_0) || var_0;
}

function bb_isincombat() {
  return self.bisincombat;
}

function bb_isweaponclass(var_0, var_1, var_2, var_3) {
  return weaponclass(self.weapon) == var_3;
}

function bb_shoulddroprocketlauncher(var_0, var_1, var_2, var_3) {
  if(weaponclass(self.weapon) != "rocketlauncher") {
    return false;
  }

  var_4 = bb_getrequestedweapon();

  if(!isDefined(var_4)) {
    return false;
  }

  return var_4 != "rocketlauncher";
}

function bb_requestmove() {}

function bb_clearmoverequest() {}

function bb_moverequested() {
  return self codemoverequested();
}

function bb_movetyperequested(var_0) {
  return self._blackboard.movetype == var_0;
}

function bb_requestmovetype(var_0) {
  self._blackboard.movetype = var_0;
}

function bb_requestweapon(var_0) {
  self._blackboard.weaponrequest = var_0;
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

function bb_requestreload(var_0) {
  if(!isDefined(var_0)) {
    self._blackboard.breload = 1;
    return;
  }

  self._blackboard.breload = var_0;
}

function bb_reloadrequested() {
  return self._blackboard.breload;
}

function bb_requestthrowgrenade(var_0, var_1) {
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

function bb_throwgrenaderequested() {
  if(isDefined(self._blackboard.bthrowgrenade)) {
    return (self._blackboard.bthrowgrenade && isDefined(self._blackboard.throwgrenadetarget));
  }

  return false;
}

function bb_getthrowgrenadetarget() {
  return self._blackboard.throwgrenadetarget;
}

function bb_requestfire(var_0) {
  if(!isDefined(var_0)) {
    self._blackboard.bfire = 1;
    return;
  }

  self._blackboard.bfire = var_0;
}

function bb_firerequested() {
  return istrue(self._blackboard.bfire);
}

function bb_newshootparams(var_0, var_1, var_2) {
  self._blackboard.shootparams_writeid++;
  self._blackboard.shootparams_starttime = gettime();
  self._blackboard.shootparams_pos = var_0;
  self._blackboard.shootparams_ent = var_1;
  self._blackboard.shootparams_buseentinshootcalc = var_2;
  self._blackboard.shootparams_objective = "normal";
  self._blackboard.shootparams_valid = 1;
}

function bb_updateshootparams(var_0, var_1, var_2) {
  if(bb_issameshootparamsent(var_1, var_2)) {
    bb_updateshootparams_posandent(var_0, var_1, var_2);
    return;
  }

  bb_newshootparams(var_0, var_1, var_2);
}

function bb_claimshootparams(var_0) {
  self._blackboard.shootparams_taskid = var_0;
}

function bb_issameshootparamsent(var_0, var_1) {
  if(!istrue(self._blackboard.shootparams_valid)) {
    return false;
  }

  if(isDefined(var_0) && !isDefined(self._blackboard.shootparams_ent)) {
    return false;
  } else if(!isDefined(var_0) && isDefined(self._blackboard.shootparams_ent)) {
    return false;
  } else if(isDefined(var_0) && isDefined(self._blackboard.shootparams_ent) && var_0 != self._blackboard.shootparams_ent) {
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

function bb_updateshootparams_pos(var_0) {
  self._blackboard.shootparams_pos = var_0;
}

function bb_updateshootparams_posandent(var_0, var_1, var_2) {
  self._blackboard.shootparams_pos = var_0;
  self._blackboard.shootparams_ent = var_1;
  self._blackboard.shootparams_buseentinshootcalc = var_2;
}

function bb_clearshootparams() {
  self._blackboard.shootparams_ent = undefined;
  self._blackboard.shootparams_valid = 0;
}

function bb_setshootparams(var_0, var_1) {}

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

function bb_requestcoverstate(var_0) {
  self._blackboard.coverstate = var_0;
}

function bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate)) {
    return "none";
  }

  return self._blackboard.coverstate;
}

function bb_requestcoverexposetype(var_0) {
  self._blackboard.coverexposetype = var_0;
}

function bb_getrequestedcoverexposetype() {
  return self._blackboard.coverexposetype;
}

function bb_requestcoverblindfire(var_0) {
  self._blackboard.blindfire = var_0;
}

function bb_setcovernode(var_0) {
  self._blackboard.covernode = var_0;
  self._blackboard.bhascovernode = isDefined(var_0);
}

function bb_hadcovernode(var_0, var_1, var_2, var_3) {
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

function bb_requestturret(var_0) {
  self._blackboard.requestedturret = var_0;
}

function bb_requestturretpose(var_0) {
  self._blackboard.requestedturretpose = var_0;
}

function bb_hasshufflenode(var_0, var_1, var_2, var_3) {
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

function bb_requestmelee(var_0) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = var_0;
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

function bb_meleeinprogress(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequestedcomplete);
}

function bb_meleecomplete(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.meleerequestedcomplete) && self._blackboard.meleerequestedcomplete;
}

function bb_meleerequested() {
  return self._blackboard.meleerequested;
}

function bb_meleerequestinvalid(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee)) {
    return true;
  }

  if(!isDefined(self.melee.target)) {
    return true;
  }

  return false;
}

function bb_requestmeleecharge(var_0, var_1) {
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = var_0;
  self._blackboard.meleerequestedcharge_targetposition = var_1;
}

function bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = 0;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

function bb_meleechargerequested() {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.pathgoalpos);
}

function bb_meleechargeaborted(var_0, var_1, var_2, var_3) {
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

function bb_requestgrenadereturnthrow(var_0) {
  self._blackboard.bgrenadereturnthrow = var_0;
}

function bb_requestwhizby(var_0) {
  self._blackboard.whizbyevent = var_0;
}

function bb_iswhizbyrequested() {
  return isDefined(self._blackboard.whizbyevent);
}

function bb_getrequestedwhizby() {
  return self._blackboard.whizbyevent;
}

function bb_isfrantic() {
  var_0 = bb_getcovernode();

  if(!isDefined(var_0)) {
    var_0 = self.node;
  }

  var_1 = isDefined(var_0) && (var_0.type == "Conceal Crouch" || var_0.type == "Conceal Stand");
  return self._blackboard.movetype == "frantic" && !var_1;
}

function bb_ismissingaleg() {
  var_0 = bb_getmissingleg();

  if(isDefined(var_0)) {
    return true;
  }

  return false;
}

function bb_getmissingleg() {
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

function ispartdismembered(var_0) {
  if(!isDefined(self._blackboard)) {
    return false;
  }

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0])) {
      return false;
    }

    return (self._blackboard.scriptableparts[var_0].state == "dismember");
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  return isDefined(self._blackboard.dismemberedparts[var_0]);
}

function bb_ispartdismembered(var_0, var_1, var_2, var_3) {
  return ispartdismembered(var_3);
}

function waspartjustdismembered(var_0) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0])) {
      return false;
    }

    if(self._blackboard.scriptableparts[var_0].state != "dismember") {
      return false;
    }

    return (self._blackboard.scriptableparts[var_0].time == gettime());
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  if(!isDefined(self._blackboard.dismemberedparts[var_0])) {
    return false;
  }

  return self._blackboard.dismemberedparts[var_0] == gettime();
}

function bb_waspartjustdismembered(var_0, var_1, var_2, var_3) {
  return waspartjustdismembered(var_3);
}

function bb_werepartsdismemberedinorder(var_0, var_1, var_2, var_3) {
  return ispartdismembered(var_3[0]) && waspartjustdismembered(var_3[1]);
}

function bb_dismemberedpart(var_0) {
  self._blackboard.dismemberedparts[var_0] = gettime();
}

function bb_setselfdestruct(var_0) {
  self._blackboard.selfdestruct = var_0;
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

function bb_setheadless(var_0) {
  self._blackboard.isheadless = var_0;
}

function bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab)) {
    return false;
  }

  return isDefined(self._blackboard.isheadless);
}

function bb_setcanrodeo(var_0, var_1) {
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

function bb_canrodeo(var_0) {
  if(!isDefined(self._blackboard.rodeo)) {
    return false;
  }

  if(!isDefined(self._blackboard.rodeo[var_0])) {
    return false;
  }

  if(!self._blackboard.rodeo[var_0]) {
    return false;
  }

  return true;
}

function bb_setrodeorequest(var_0) {
  self._blackboard.rodeorequest = var_0;
}

function bb_clearrodeorequest(var_0) {
  self._blackboard.rodeorequested = undefined;
}

function bb_isrodeorequested(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.rodeorequest)) {
    return false;
  }

  return true;
}

function bb_setmeleetarget(var_0) {
  self.melee = spawnStruct();
  var_0.melee = spawnStruct();
  self.melee.target = var_0;
  self.melee.partner = var_0;
  var_0.melee.partner = self;
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

function bb_setcrawlmelee(var_0) {
  self._blackboard.crawlmelee = var_0;
}

function bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

function bb_sethaywire(var_0) {
  self._blackboard.haywire = var_0;
}

function bb_ishaywire() {
  return isDefined(self._blackboard.haywire);
}

function bb_gethaywire() {
  return self._blackboard.haywire;
}

function bb_setisinbadcrouchspot(var_0) {
  self._blackboard.bbadcrouchspot = var_0;
}

function bb_isinbadcrouchspot() {
  return istrue(self._blackboard.bbadcrouchspot);
}

function bb_setcivilianstate(var_0) {
  if(isDefined(self._blackboard.civstate) && self._blackboard.civstate == var_0) {
    return;
  }

  self._blackboard.civstate = var_0;
  self._blackboard.civstatetime = gettime();
}

function bb_getcivilianstate() {
  return self._blackboard.civstate;
}

function bb_getcivilianstatetime() {
  return self._blackboard.civstatetime;
}

function bb_civilianrequestspeed(var_0) {
  scripts\engine\utility::set_movement_speed(var_0);
}

function bb_isshort() {
  return istrue(self._blackboard.short);
}

function bb_setshort(var_0) {
  self._blackboard.short = var_0;
}

function bb_smartobjectrequested() {
  return isDefined(self._blackboard.smartobject);
}

function bb_requestsmartobject(var_0) {
  self._blackboard.smartobject = var_0;
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

function bb_requestcovermultiswitch(var_0, var_1) {
  self._blackboard.docovermultiswitchnode = var_0;
  self._blackboard.docovermultiswitchnodetype = var_1;
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

function bb_canplaygesture(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return false;
  }

  if(isDefined(var_3) && self._blackboard.gesturerequest.gesture != var_3) {
    return false;
  }

  if(!isDefined(self._blackboard.gesturerequest.latestalias)) {
    return false;
  }

  if(gettime() > self._blackboard.gesturerequest.timeoutms) {
    return false;
  }

  var_4 = self._blackboard.gesturerequest.latestalias;

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    return false;
  }

  return true;
}

function bb_shouldwildfire(var_0, var_1, var_2) {
  if(!istrue(self._blackboard.isrebel)) {
    return false;
  }

  var_3 = 50;
  return randomint(100) <= var_3;
}