/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_bb.gsc
***********************************************/

bb_getprefixstring(category) {
  return undefined;
}

bb_wantstostrafe() {
  if(isDefined(self._blackboard.meleerequested) && self._blackboard.meleerequested)
    return 1;

  if(isDefined(self._blackboard.bwantstostrafe))
    return self._blackboard.bwantstostrafe;

  return 0;
}

bb_requeststance(stance) {
  self._blackboard.desiredstance = stance;
}

bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

bb_isrequestedstance_refresh(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_55372344A55A6D53 = scripts\asm\shared\utility::determinerequestedstance();
  return _id_55372344A55A6D53 == params;
}

bb_isrequestedstanceanddemeanor(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._blackboard.desiredstance == params[0] && scripts\asm\asm::asm_getdemeanor() == params[1];
}

bb_setisincombat(_id_8D72886DAEE52B56) {
  self.bisincombat = !isDefined(_id_8D72886DAEE52B56) || _id_8D72886DAEE52B56;
}

bb_isincombat() {
  return self.bisincombat;
}

bb_isweaponclass(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return weaponclass(self.weapon) == params;
}

bb_shoulddroprocketlauncher(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(weaponclass(self.weapon) != "rocketlauncher")
    return 0;

  _id_86EDB844B65F73E7 = bb_getrequestedweapon();

  if(!isDefined(_id_86EDB844B65F73E7))
    return 0;

  return _id_86EDB844B65F73E7 != "rocketlauncher";
}

bb_requestmove() {}

bb_clearmoverequest() {}

bb_moverequested() {
  return self codemoverequested();
}

bb_movetyperequested(movetype) {
  return self._blackboard.movetype == movetype;
}

bb_requestmovetype(movetype) {
  self._blackboard.movetype = movetype;
}

bb_requestweapon(weapon) {
  self._blackboard.weaponrequest = weapon;
}

bb_clearweaponrequest() {
  self._blackboard.weaponrequest = "none";
}

bb_getrequestedweapon() {
  if(isDefined(self._blackboard.weaponrequest) && self._blackboard.weaponrequest == "none")
    return undefined;

  return self._blackboard.weaponrequest;
}

bb_requestreload(breload) {
  if(!isDefined(breload))
    self._blackboard.breload = 1;
  else
    self._blackboard.breload = breload;
}

bb_reloadrequested() {
  return self._blackboard.breload;
}

bb_throwgrenaderequested() {
  if(isDefined(self._blackboard.bthrowgrenade))
    return self._blackboard.bthrowgrenade && isDefined(self._blackboard.throwgrenadetarget);

  return 0;
}

bb_getthrowgrenadetarget() {
  return self._blackboard.throwgrenadetarget;
}

bb_requestfire(bfire) {
  if(!isDefined(bfire))
    self._blackboard.bfire = 1;
  else
    self._blackboard.bfire = bfire;
}

bb_firerequested() {
  return istrue(self._blackboard.bfire);
}

bb_claimshootparams(taskid) {
  self._blackboard.shootparams_taskid = taskid;
}

bb_shootparams_idsmatch() {
  if(!istrue(self._blackboard.shootparams_valid))
    return 0;

  if(!isDefined(self._blackboard.shootparams_readid))
    return 0;

  return self._blackboard.shootparams_writeid == self._blackboard.shootparams_readid;
}

bb_updateshootparams_pos(pos) {
  self._blackboard.shootparams_pos = pos;
}

bb_clearshootparams() {
  self._blackboard.shootparams_ent = undefined;
  self._blackboard.shootparams_valid = 0;
}

bb_setshootparams(shootparams, target) {}

bb_requestcoverstate(state, _id_55B1B4A8C2BA7AA2) {
  self setcoverstate(state, _id_55B1B4A8C2BA7AA2);
}

bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate))
    return "none";

  return self._blackboard.coverstate;
}

bb_requestcoverexposetype(_id_270393D6FB596021) {
  self._blackboard.coverexposetype = _id_270393D6FB596021;
}

bb_getrequestedcoverexposetype() {
  return self._blackboard.coverexposetype;
}

bb_requestcoverblindfire(_id_690E06DB214B7BEC) {
  self._blackboard.blindfire = _id_690E06DB214B7BEC;
}

bb_setcovernode(node) {
  self.covernode = node;
}

bb_hadcovernode(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self.covernode);
}

bb_getcovernode() {
  return self.covernode;
}

bb_getrequestedturret() {
  if(isDefined(self._blackboard.requestedturret))
    return self._blackboard.requestedturret;

  return undefined;
}

bb_requestturret(turret) {
  self._blackboard.requestedturret = turret;

  if(isDefined(turret.script_delay_min))
    self._id_29CA84991E64EC65 = turret.script_delay_min;

  if(isDefined(turret.script_delay_max))
    self._id_29EE8E991E8D7D1B = turret.script_delay_max;
}

bb_requestturretpose(_id_5CAA9F9F456B4040) {
  self._blackboard.requestedturretpose = _id_5CAA9F9F456B4040;
}

bb_hasshufflenode(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard.shufflenode) && isDefined(self.node) && self._blackboard.shufflenode == self.node && distancesquared(self.node.origin, self.origin) > 16;
}

bb_setanimScripted() {
  self._blackboard.animscriptedactive = 1;
}

bb_clearanimScripted() {
  self._blackboard.animscriptedactive = 0;
}

bb_isanimScripted() {
  if(isDefined(self.script)) {
    if(self.script == "scripted" || self.script == "<custom>")
      return 1;
  }

  return istrue(self._blackboard.animscriptedactive);
}

bb_requestmelee(target) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = target;
  self._blackboard.meleerequestedcomplete = 0;
}

bb_getmeleetarget() {
  if(!self._blackboard.meleerequested)
    return undefined;

  return self._blackboard.meleerequestedtarget;
}

bb_clearmeleerequest() {
  self._blackboard.meleerequested = 0;
  self._blackboard.meleerequestedtarget = undefined;
}

bb_clearmeleerequestcomplete() {
  self._blackboard.meleerequestedcomplete = undefined;
}

bb_meleeinprogress(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard.meleerequestedcomplete);
}

bb_meleecomplete(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard.meleerequestedcomplete) && self._blackboard.meleerequestedcomplete;
}

bb_meleerequested() {
  return self._blackboard.meleerequested;
}

bb_meleerequestinvalid(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self._id_A97AC004F00C5DF9)
    return 1;

  if(!isDefined(self._id_9BFC452192B23C7A))
    return 1;

  return 0;
}

bb_requestmeleecharge(target, targetpos) {
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = target;
  self._blackboard.meleerequestedcharge_targetposition = targetpos;
}

bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = 0;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

bb_meleechargerequested() {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.pathgoalpos);
}

bb_meleechargeaborted(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(bb_meleechargerequested())
    return 0;

  return 1;
}

bb_getmeleechargetarget() {
  if(!isDefined(self._blackboard.meleerequestedcharge) || !self._blackboard.meleerequestedcharge)
    return undefined;

  return self._blackboard.meleerequestedcharge_target;
}

bb_getmeleechargetargetpos() {
  return self._blackboard.meleerequestedcharge_targetposition;
}

bb_requestgrenadereturnthrow(_id_864246CFF0439473) {
  self._blackboard.bgrenadereturnthrow = _id_864246CFF0439473;
}

bb_iswhizbyrequested() {
  return isDefined(self._blackboard._id_9F7C458052D2C805);
}

bb_isfrantic() {
  covernode = bb_getcovernode();

  if(!isDefined(covernode))
    covernode = self.node;

  _id_A31FCF6FA75167D6 = isDefined(covernode) && (covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand");
  return self._blackboard.movetype == "frantic" && !_id_A31FCF6FA75167D6;
}

bb_ismissingaleg() {
  _id_AA19EFF12D6BB163 = bb_getmissingleg();

  if(isDefined(_id_AA19EFF12D6BB163))
    return 1;

  return 0;
}

bb_getmissingleg() {
  count = 0;
  str = undefined;

  if(!isDefined(self._blackboard.dismemberedparts))
    return str;

  if(isDefined(self._blackboard.dismemberedparts["left_leg"])) {
    count++;
    str = "left";
  }

  if(isDefined(self._blackboard.dismemberedparts["right_leg"])) {
    count++;
    str = "right";
  }

  if(count == 2)
    str = "both";

  return str;
}

ispartdismembered(part) {
  if(!isDefined(self._blackboard))
    return 0;

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[part]))
      return 0;

    return self._blackboard.scriptableparts[part].state == "dismember";
  }

  if(!isDefined(self._blackboard.dismemberedparts))
    return 0;

  return isDefined(self._blackboard.dismemberedparts[part]);
}

bb_ispartdismembered(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return ispartdismembered(params);
}

waspartjustdismembered(part) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[part]))
      return 0;

    if(self._blackboard.scriptableparts[part].state != "dismember")
      return 0;

    return self._blackboard.scriptableparts[part].time == gettime();
  }

  if(!isDefined(self._blackboard.dismemberedparts))
    return 0;

  if(!isDefined(self._blackboard.dismemberedparts[part]))
    return 0;

  return self._blackboard.dismemberedparts[part] == gettime();
}

bb_waspartjustdismembered(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return waspartjustdismembered(params);
}

bb_werepartsdismemberedinorder(asm, statename, _id_F2B19B25D457C2A6, params) {
  return ispartdismembered(params[0]) && waspartjustdismembered(params[1]);
}

bb_dismemberedpart(part) {
  self._blackboard.dismemberedparts[part] = gettime();
}

bb_setselfdestruct(val) {
  self._blackboard.selfdestruct = val;
}

bb_isselfdestruct() {
  if(!isDefined(self._blackboard.selfdestruct)) {
    if(isDefined(self.bt.forceselfdestructtimer) && gettime() > self.bt.forceselfdestructtimer)
      self._blackboard.selfdestruct = 1;
  }

  return isDefined(self._blackboard.selfdestruct);
}

bb_selfdestructnow() {
  self._blackboard.selfdestructnow = 1;
}

bb_shouldselfdestructnow() {
  return isDefined(self._blackboard.selfdestructnow);
}

bb_setheadless(val) {
  self._blackboard.isheadless = val;
}

bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab))
    return 0;

  return isDefined(self._blackboard.isheadless);
}

bb_setcanrodeo(_id_A66BA9B157533F5A, _id_E7096CE45CDA4606) {
  if(!isDefined(_id_E7096CE45CDA4606))
    _id_E7096CE45CDA4606 = 1;

  _id_77E9DEB121363114 = "left";

  if(_id_A66BA9B157533F5A == _id_77E9DEB121363114)
    _id_77E9DEB121363114 = "right";

  if(isDefined(self._blackboard.rodeo) && isDefined(self._blackboard.rodeo[_id_77E9DEB121363114])) {
    self._blackboard.rodeo[_id_77E9DEB121363114] = 0;
    self._blackboard.rodeo[_id_A66BA9B157533F5A] = 0;
    return;
  }

  self._blackboard.rodeo[_id_A66BA9B157533F5A] = _id_E7096CE45CDA4606;
}

bb_canrodeo(_id_A66BA9B157533F5A) {
  if(!isDefined(self._blackboard.rodeo))
    return 0;

  if(!isDefined(self._blackboard.rodeo[_id_A66BA9B157533F5A]))
    return 0;

  if(!self._blackboard.rodeo[_id_A66BA9B157533F5A])
    return 0;

  return 1;
}

bb_setrodeorequest(val) {
  self._blackboard.rodeorequest = val;
}

bb_clearrodeorequest(val) {
  self._blackboard.rodeorequested = undefined;
}

bb_isrodeorequested(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._blackboard.rodeorequest))
    return 0;

  return 1;
}

bb_clearmeleetarget() {
  self _meth_0BDCB37A9431E654();
}

bb_setcrawlmelee(val) {
  self._blackboard.crawlmelee = val;
}

bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

bb_sethaywire(val) {
  self._blackboard.haywire = val;
}

bb_ishaywire() {
  return isDefined(self._blackboard.haywire);
}

bb_gethaywire() {
  return self._blackboard.haywire;
}

bb_setisinbadcrouchspot(bbadcrouchspot) {
  self._blackboard.bbadcrouchspot = bbadcrouchspot;
}

bb_isinbadcrouchspot() {
  return istrue(self._blackboard.bbadcrouchspot);
}

bb_setcivilianstate(state) {}

bb_getcivilianstate() {
  return "deprecated";
}

bb_getcivilianstatetime() {
  return self._blackboard.civstatetime;
}

bb_civilianrequestspeed(speed) {
  self aisetdesiredspeed(speed);
}

bb_isshort() {
  return istrue(self._blackboard._id_04AC74770BB9BB41);
}

bb_setshort(value) {
  self._blackboard._id_04AC74770BB9BB41 = value;
}

bb_smartobjectrequested() {
  return isDefined(self._blackboard.smartobject);
}

bb_requestsmartobject(value) {
  self._blackboard.smartobject = value;

  if(isDefined(self._blackboard.smartobject) && isDefined(self._blackboard.smartobject.angles)) {
    self._blackboard._id_69005B71B6433121 = 1;
    self._blackboard._id_B9EB5585D7A64EC1 = self._blackboard.smartobject.angles;
  }
}

bb_getrequestedsmartobject() {
  return self._blackboard.smartobject;
}

bb_clearsmartobject() {
  self._blackboard.smartobject = undefined;
  self._blackboard._id_69005B71B6433121 = 0;
  bb_clearplaysmartobject();
}

bb_requestplaysmartobject() {
  self._blackboard.bplaysmartobject = 1;
}

bb_clearplaysmartobject() {
  self._blackboard.bplaysmartobject = 0;
}

bb_playsmartobjectrequested() {
  return istrue(self._blackboard.bplaysmartobject);
}

bb_getrequestedcovermultiswitchnodetype() {
  return self._blackboard.docovermultiswitchnodetype;
}

bb_iscovermultiswitchrequested() {
  return isDefined(self._blackboard.docovermultiswitchnodetype);
}

bb_canplaygesture(asmname, statename, _id_F2B19B25D457C2A6, gesture) {
  if(!isDefined(self._blackboard.gesturerequest))
    return 0;

  if(isDefined(gesture) && self._blackboard.gesturerequest.gesture != gesture)
    return 0;

  if(!isDefined(self._blackboard.gesturerequest.latestalias))
    return 0;

  if(gettime() > self._blackboard.gesturerequest.timeoutms)
    return 0;

  _id_1CF23414DFA8574F = self._blackboard.gesturerequest.latestalias;

  if(!scripts\asm\asm::asm_hasalias(_id_F2B19B25D457C2A6, _id_1CF23414DFA8574F))
    return 0;

  return 1;
}