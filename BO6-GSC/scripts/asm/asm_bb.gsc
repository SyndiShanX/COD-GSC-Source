/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#namespace asm_bb;

function bb_getprefixstring(category) {
  return undefined;
}

function bb_requeststance(stance) {
  self._blackboard.desiredstance = stance;
}

function bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

function bb_isrequestedstance_refresh(asmname, statename, tostatename, params) {
  requestedstance = utility::determinerequestedstance();
  return requestedstance == params;
}

function bb_isrequestedstanceanddemeanor(asmname, statename, tostatename, params) {
  assert(isDefined(params) && params.size == 2);
  return self._blackboard.desiredstance == params[0] && asm::asm_getdemeanor() == params[1];
}

function bb_setisincombat(bincombat) {
  self.bisincombat = !isDefined(bincombat) || bincombat;
}

function bb_isweaponclass(asmname, statename, tostatename, params) {
  return weaponclass(self.weapon) == params;
}

function bb_shoulddroprocketlauncher(asmname, statename, tostatename, params) {
  if(weaponclass(self.weapon) != "rocketlauncher") {
    return false;
  }

  requestedweapon = bb_getrequestedweapon();

  if(!isDefined(requestedweapon)) {
    return false;
  }

  return requestedweapon != "rocketlauncher";
}

function bb_moverequested() {
  return self codemoverequested();
}

function bb_movetyperequested(movetype) {
  return self._blackboard.movetype == movetype;
}

function bb_requestmovetype(movetype) {
  self._blackboard.movetype = movetype;
}

function bb_requestweapon(weapon) {
  self._blackboard.weaponrequest = weapon;
}

function bb_clearweaponrequest() {
  self._blackboard.weaponrequest = "none";
}

function bb_getrequestedweapon() {
  if(self._blackboard.weaponrequest == "none") {
    return undefined;
  }

  return self._blackboard.weaponrequest;
}

function bb_reloadrequested() {
  return self._blackboard.breload;
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

function bb_claimshootparams(taskid) {
  self._blackboard.shootparams_taskid = taskid;
}

function bb_updateshootparams_pos(pos) {
  assert(self._blackboard.shootparams_valid);
  self._blackboard.shootparams_pos = pos;
}

function bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate)) {
    return "none";
  }

  return self._blackboard.coverstate;
}

function bb_hadcovernode(asmname, statename, tostatename, params) {
  return isDefined(self.covernode);
}

function bb_getcovernode() {
  return self.covernode;
}

function bb_getrequestedturret() {
  var_7237854e3be197ca = self._blackboard.requestedturret;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }
}

function bb_requestturret(turret) {
  self._blackboard.requestedturret = turret;
}

function function_988e0cf7bedac7eb() {
  if(isDefined(self._blackboard.var_22f41abfc5a5f544) && isDefined(self._blackboard.var_abd24c35bdded560)) {
    return [self._blackboard.var_22f41abfc5a5f544, self._blackboard.var_abd24c35bdded560];
  }

  return undefined;
}

function function_d97733fe1476f19e(vehicle, turretindex) {
  self._blackboard.var_22f41abfc5a5f544 = vehicle;
  self._blackboard.var_abd24c35bdded560 = turretindex;
}

function bb_requestturretpose(pose) {
  assert(!isDefined(pose) || pose == "<dev string:x24>" || pose == "<dev string:x2d>" || pose == "<dev string:x37>" || pose == "<dev string:x40>");
  self._blackboard.requestedturretpose = pose;
}

function bb_hasshufflenode(asmname, statename, tostatename, params) {
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

function bb_requestmelee(target) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = target;
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
}

function bb_clearmeleerequestcomplete() {
  self._blackboard.meleerequestedcomplete = undefined;
}

function bb_meleeinprogress(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.meleerequestedcomplete);
}

function bb_meleecomplete(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.meleerequestedcomplete) && self._blackboard.meleerequestedcomplete;
}

function bb_meleerequestinvalid(asmname, statename, tostatename, params) {
  if(!self.in_melee) {
    return true;
  }

  if(!isDefined(self.meleetarget)) {
    return true;
  }

  return false;
}

function bb_requestmeleecharge(target, targetpos) {
  assert(isDefined(targetpos));
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = target;
  self._blackboard.meleerequestedcharge_targetposition = targetpos;
}

function bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = 0;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

function bb_meleechargerequested() {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.pathgoalpos);
}

function bb_meleechargeaborted(asmname, statename, tostatename, params) {
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
  assert(isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge);
  return self._blackboard.meleerequestedcharge_targetposition;
}

function bb_iswhizbyrequested() {
  return isDefined(self._blackboard.whizbyeventtime);
}

function bb_clearmeleetarget() {
  self function_a227728f297b8669();
}

function bb_setisinbadcrouchspot(bbadcrouchspot) {
  self._blackboard.bbadcrouchspot = bbadcrouchspot;
}

function bb_isinbadcrouchspot() {
  return istrue(self._blackboard.bbadcrouchspot);
}

function bb_setcivilianstate(state) {}

function bb_getcivilianstate() {
  return "deprecated";
}

function bb_getcivilianstatetime() {
  return self._blackboard.civstatetime;
}

function bb_civilianrequestspeed(speed) {
  self aisetdesiredspeed(speed);
}

function bb_isshort() {
  return istrue(self._blackboard.bshort);
}

function bb_setshort(value) {
  self._blackboard.bshort = value;
}

function bb_smartobjectrequested() {
  return isDefined(self._blackboard.smartobject);
}

function bb_requestsmartobject(value) {
  self._blackboard.smartobject = value;

  if(isDefined(self._blackboard.smartobject) && isDefined(self._blackboard.smartobject.angles)) {
    self._blackboard.smartobjectvalid = 1;
    self._blackboard.smartobjectangles = self._blackboard.smartobject.angles;
  }
}

function bb_getrequestedsmartobject() {
  return self._blackboard.smartobject;
}

function bb_clearsmartobject() {
  self._blackboard.smartobject = undefined;
  self._blackboard.smartobjectvalid = 0;
  bb_clearplaysmartobject();
}

function bb_requestplaysmartobject() {
  assert(isDefined(self._blackboard.smartobject));
  self._blackboard.bplaysmartobject = 1;
}

function bb_clearplaysmartobject() {
  self._blackboard.bplaysmartobject = 0;
}

function bb_playsmartobjectrequested() {
  return istrue(self._blackboard.bplaysmartobject);
}

function bb_getrequestedcovermultiswitchnodetype() {
  assert(isDefined(self._blackboard.docovermultiswitchnodetype));
  return self._blackboard.docovermultiswitchnodetype;
}

function bb_iscovermultiswitchrequested() {
  return isDefined(self._blackboard.docovermultiswitchnodetype);
}

function bb_canplaygesture(asmname, statename, tostatename, gesture) {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return false;
  }

  if(isDefined(gesture) && self._blackboard.gesturerequest.gesture != gesture) {
    return false;
  }

  if(!isDefined(self._blackboard.gesturerequest.latestalias)) {
    return false;
  }

  if(gettime() > self._blackboard.gesturerequest.timeoutms) {
    return false;
  }

  gesture_alias = self._blackboard.gesturerequest.latestalias;

  if(!asm::asm_hasalias(tostatename, gesture_alias)) {
    return false;
  }

  return true;
}