/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\asm_bb.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace asm_bb;

function bb_getprefixstring(category) {
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

function bb_requeststance(stance) {
  self._blackboard.desiredstance = stance;
}

function bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

function bb_isrequestedstance_refresh(asmname, statename, tostatename, params) {
  requestedstance = determinerequestedstance();
  return requestedstance == params;
}

function bb_isrequestedstanceanddemeanor(asmname, statename, tostatename, params) {
  assert(isDefined(params) && params.size == 2);
  return self._blackboard.desiredstance == params[0] && scripts\asm\asm::asm_getdemeanor() == params[1];
}

function bb_setisincombat(bincombat) {
  self.bisincombat = !isDefined(bincombat) || bincombat;
}

function bb_isincombat() {
  return self.bisincombat;
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

function bb_requestmove() {}

function bb_clearmoverequest() {}

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
  if(isDefined(self._blackboard.weaponrequest) && self._blackboard.weaponrequest == "none") {
    return undefined;
  }

  return self._blackboard.weaponrequest;
}

function bb_requestreload(breload) {
  if(!isDefined(breload)) {
    self._blackboard.breload = 1;
    return;
  }

  self._blackboard.breload = breload;
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

function bb_requestfire(bfire) {
  if(!isDefined(bfire)) {
    self._blackboard.bfire = 1;
    return;
  }

  self._blackboard.bfire = bfire;
}

function bb_firerequested() {
  return istrue(self._blackboard.bfire);
}

function bb_claimshootparams(taskid) {
  self._blackboard.shootparams_taskid = taskid;
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

function bb_updateshootparams_pos(pos) {
  assert(istrue(self._blackboard.shootparams_valid));
  self._blackboard.shootparams_pos = pos;
}

function bb_clearshootparams() {
  self._blackboard.shootparams_ent = undefined;
  self._blackboard.shootparams_valid = 0;
}

function bb_setshootparams(shootparams, target) {
  assertmsg("<dev string:x1c>");
}

function bb_requestcoverstate(state, var_55b1b4a8c2ba7aa2) {
  self setcoverstate(state, var_55b1b4a8c2ba7aa2);
}

function bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate)) {
    return "none";
  }

  return self._blackboard.coverstate;
}

function bb_requestcoverexposetype(exposetype) {
  self._blackboard.coverexposetype = exposetype;
}

function bb_getrequestedcoverexposetype() {
  return self._blackboard.coverexposetype;
}

function bb_requestcoverblindfire(var_690e06db214b7bec) {
  self._blackboard.blindfire = var_690e06db214b7bec;
}

function bb_setcovernode(node) {
  self.covernode = node;
}

function bb_hadcovernode(asmname, statename, tostatename, params) {
  return isDefined(self.covernode);
}

function bb_getcovernode() {
  return self.covernode;
}

function bb_getrequestedturret() {
  if(isDefined(self._blackboard.requestedturret)) {
    return self._blackboard.requestedturret;
  }

  return undefined;
}

function bb_requestturret(turret) {
  self._blackboard.requestedturret = turret;

  if(isDefined(turret.script_delay_min)) {
    self.var_29ca84991e64ec65 = turret.script_delay_min;
  }

  if(isDefined(turret.script_delay_max)) {
    self.var_29ee8e991e8d7d1b = turret.script_delay_max;
  }
}

function bb_requestturretpose(pose) {
  assert(!isDefined(pose) || pose == "<dev string:x4b>" || pose == "<dev string:x54>" || pose == "<dev string:x5e>" || pose == "<dev string:x67>");
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

function bb_meleerequested() {
  return self._blackboard.meleerequested;
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

function bb_requestgrenadereturnthrow(bthrow) {
  self._blackboard.bgrenadereturnthrow = bthrow;
}

function bb_iswhizbyrequested() {
  return isDefined(self._blackboard.whizbyeventtime);
}

function bb_isfrantic() {
  covernode = bb_getcovernode();

  if(!isDefined(covernode)) {
    covernode = self.node;
  }

  var_a31fcf6fa75167d6 = isDefined(covernode) && (covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand");
  return self._blackboard.movetype == "frantic" && !var_a31fcf6fa75167d6;
}

function bb_ismissingaleg() {
  missing = bb_getmissingleg();

  if(isDefined(missing)) {
    return true;
  }

  return false;
}

function bb_getmissingleg() {
  count = 0;
  str = undefined;

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return str;
  }

  if(isDefined(self._blackboard.dismemberedparts["left_leg"])) {
    count++;
    str = "left";
  }

  if(isDefined(self._blackboard.dismemberedparts["right_leg"])) {
    count++;
    str = "right";
  }

  if(count == 2) {
    str = "both";
  }

  return str;
}

function ispartdismembered(part) {
  if(!isDefined(self._blackboard)) {
    return false;
  }

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[part])) {
      return false;
    }

    return (self._blackboard.scriptableparts[part].state == "dismember");
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  return isDefined(self._blackboard.dismemberedparts[part]);
}

function bb_ispartdismembered(asmname, statename, tostatename, params) {
  return ispartdismembered(params);
}

function waspartjustdismembered(part) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[part])) {
      return false;
    }

    if(self._blackboard.scriptableparts[part].state != "dismember") {
      return false;
    }

    return (self._blackboard.scriptableparts[part].time == gettime());
  }

  if(!isDefined(self._blackboard.dismemberedparts)) {
    return false;
  }

  if(!isDefined(self._blackboard.dismemberedparts[part])) {
    return false;
  }

  return self._blackboard.dismemberedparts[part] == gettime();
}

function bb_waspartjustdismembered(asmname, statename, tostatename, params) {
  return waspartjustdismembered(params);
}

function bb_werepartsdismemberedinorder(asm, statename, tostatename, params) {
  return ispartdismembered(params[0]) && waspartjustdismembered(params[1]);
}

function bb_dismemberedpart(part) {
  self._blackboard.dismemberedparts[part] = gettime();
}

function bb_setselfdestruct(val) {
  self._blackboard.selfdestruct = val;
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

function bb_setheadless(val) {
  self._blackboard.isheadless = val;
}

function bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab)) {
    return false;
  }

  return isDefined(self._blackboard.isheadless);
}

function bb_setcanrodeo(side, var_e7096ce45cda4606) {
  if(!isDefined(var_e7096ce45cda4606)) {
    var_e7096ce45cda4606 = 1;
  }

  opposite = "left";

  if(side == opposite) {
    opposite = "right";
  }

  if(isDefined(self._blackboard.rodeo) && isDefined(self._blackboard.rodeo[opposite])) {
    self._blackboard.rodeo[opposite] = 0;
    self._blackboard.rodeo[side] = 0;
    return;
  }

  self._blackboard.rodeo[side] = var_e7096ce45cda4606;
}

function bb_canrodeo(side) {
  if(!isDefined(self._blackboard.rodeo)) {
    return false;
  }

  if(!isDefined(self._blackboard.rodeo[side])) {
    return false;
  }

  if(!self._blackboard.rodeo[side]) {
    return false;
  }

  return true;
}

function bb_setrodeorequest(val) {
  self._blackboard.rodeorequest = val;
}

function bb_clearrodeorequest(val) {
  self._blackboard.rodeorequested = undefined;
}

function bb_isrodeorequested(asmname, statename, tostatename, params) {
  if(!isDefined(self._blackboard.rodeorequest)) {
    return false;
  }

  return true;
}

function bb_clearmeleetarget() {
  self function_bdcb37a9431e654();
}

function bb_setcrawlmelee(val) {
  self._blackboard.crawlmelee = val;
}

function bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

function bb_sethaywire(val) {
  self._blackboard.haywire = val;
}

function bb_ishaywire() {
  return isDefined(self._blackboard.haywire);
}

function bb_gethaywire() {
  return self._blackboard.haywire;
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

  if(!scripts\asm\asm::asm_hasalias(tostatename, gesture_alias)) {
    return false;
  }

  return true;
}