/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\asm_bb.gsc
***********************************************/

bb_getprefixstring(var_0) {
  return undefined;
}

bb_wantstostrafe() {
  if(isDefined(self._blackboard.meleerequested) && self._blackboard.meleerequested)
    return 1;

  if(isDefined(self._blackboard.bwantstostrafe))
    return self._blackboard.bwantstostrafe;

  return 0;
}

bb_requeststance(var_0) {
  self._blackboard.desiredstance = var_0;
}

bb_getrequestedstance() {
  return self._blackboard.desiredstance;
}

bb_isrequestedstance_refresh(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\shared\utility::determinerequestedstance();
  return var_4 == var_3;
}

bb_isrequestedstanceanddemeanor(var_0, var_1, var_2, var_3) {
  return self._blackboard.desiredstance == var_3[0] && scripts\asm\asm::asm_getdemeanor() == var_3[1];
}

bb_setisincombat(var_0) {
  self.bisincombat = !isDefined(var_0) || var_0;
}

bb_isincombat() {
  return self.bisincombat;
}

bb_isweaponclass(var_0, var_1, var_2, var_3) {
  return weaponclass(self.weapon) == var_3;
}

bb_shoulddroprocketlauncher(var_0, var_1, var_2, var_3) {
  if(weaponclass(self.weapon) != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    return 0;

  var_4 = bb_getrequestedweapon();

  if(!isDefined(var_4))
    return 0;

  return var_4 != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0";
}

bb_requestmove() {}

bb_clearmoverequest() {}

bb_moverequested() {
  return self codemoverequested();
}

bb_movetyperequested(var_0) {
  return self._blackboard.movetype == var_0;
}

bb_requestmovetype(var_0) {
  self._blackboard.movetype = var_0;
}

bb_requestweapon(var_0) {
  self._blackboard.weaponrequest = var_0;
}

bb_clearweaponrequest() {
  self._blackboard.weaponrequest = "_encstr_8BBA05185F8B99";
}

bb_getrequestedweapon() {
  if(isDefined(self._blackboard.weaponrequest) && self._blackboard.weaponrequest == "_encstr_8BBA05185F8B99")
    return undefined;

  return self._blackboard.weaponrequest;
}

bb_requestreload(var_0) {
  if(!isDefined(var_0))
    self._blackboard.breload = 1;
  else
    self._blackboard.breload = var_0;
}

bb_reloadrequested() {
  return self._blackboard.breload;
}

bb_requestthrowgrenade(var_0, var_1) {
  if(!isDefined(var_0))
    self._blackboard.bthrowgrenade = 1;
  else
    self._blackboard.bthrowgrenade = var_0;

  if(self._blackboard.bthrowgrenade)
    self._blackboard.throwgrenadetarget = var_1;
  else
    self._blackboard.throwgrenadetarget = undefined;
}

bb_throwgrenaderequested() {
  if(isDefined(self._blackboard.bthrowgrenade))
    return self._blackboard.bthrowgrenade && isDefined(self._blackboard.throwgrenadetarget);

  return 0;
}

bb_getthrowgrenadetarget() {
  return self._blackboard.throwgrenadetarget;
}

bb_requestfire(var_0) {
  if(!isDefined(var_0))
    self._blackboard.bfire = 1;
  else
    self._blackboard.bfire = var_0;
}

bb_firerequested() {
  return istrue(self._blackboard.bfire);
}

bb_newshootparams(var_0, var_1, var_2) {
  self._blackboard.shootparams_writeid++;
  self._blackboard.shootparams_starttime = gettime();
  self._blackboard.shootparams_pos = var_0;
  self._blackboard.shootparams_ent = var_1;
  self._blackboard.shootparams_buseentinshootcalc = var_2;
  self._blackboard.shootparams_objective = "_encstr_820E07FAE8780B3A4C";
  self._blackboard.shootparams_valid = 1;
}

bb_updateshootparams(var_0, var_1, var_2) {
  if(bb_issameshootparamsent(var_1, var_2))
    bb_updateshootparams_posandent(var_0, var_1, var_2);
  else
    bb_newshootparams(var_0, var_1, var_2);
}

bb_claimshootparams(var_0) {
  self._blackboard.shootparams_taskid = var_0;
}

bb_issameshootparamsent(var_0, var_1) {
  if(!istrue(self._blackboard.shootparams_valid))
    return 0;

  if(isDefined(var_0) && !isDefined(self._blackboard.shootparams_ent))
    return 0;
  else if(!isDefined(var_0) && isDefined(self._blackboard.shootparams_ent))
    return 0;
  else if(isDefined(var_0) && isDefined(self._blackboard.shootparams_ent) && var_0 != self._blackboard.shootparams_ent)
    return 0;

  return 1;
}

bb_shootparams_empty() {
  if(!istrue(self._blackboard.shootparams_valid))
    return 1;

  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent))
    return 1;

  return 0;
}

bb_shootparams_idsmatch() {
  if(!istrue(self._blackboard.shootparams_valid))
    return 0;

  if(!isDefined(self._blackboard.shootparams_readid))
    return 0;

  return self._blackboard.shootparams_writeid == self._blackboard.shootparams_readid;
}

bb_updateshootparams_pos(var_0) {
  self._blackboard.shootparams_pos = var_0;
}

bb_updateshootparams_posandent(var_0, var_1, var_2) {
  self._blackboard.shootparams_pos = var_0;
  self._blackboard.shootparams_ent = var_1;
  self._blackboard.shootparams_buseentinshootcalc = var_2;
}

bb_clearshootparams() {
  self._blackboard.shootparams_ent = undefined;
  self._blackboard.shootparams_valid = 0;
}

bb_setshootparams(var_0, var_1) {}

bb_shootparamsvalid() {
  if(istrue(self._blackboard.shootparams_valid)) {
    if(isDefined(self.shootposoverride) && isDefined(self._blackboard.shootparams_pos))
      return 1;

    if(istrue(self.dontevershoot))
      return 0;

    if(isDefined(self._blackboard.shootparams_ent) && isDefined(self.enemy) && self.enemy == self._blackboard.shootparams_ent)
      return self iscurrentenemyvalid();
  }

  return 0;
}

bb_requestcoverstate(var_0) {
  self._blackboard.coverstate = var_0;
}

bb_getrequestedcoverstate() {
  if(!isDefined(self._blackboard.coverstate))
    return "_encstr_8BBA05185F8B99";

  return self._blackboard.coverstate;
}

bb_requestcoverexposetype(var_0) {
  self._blackboard.coverexposetype = var_0;
}

bb_getrequestedcoverexposetype() {
  return self._blackboard.coverexposetype;
}

bb_requestcoverblindfire(var_0) {
  self._blackboard.blindfire = var_0;
}

bb_setcovernode(var_0) {
  self._blackboard.covernode = var_0;
  self._blackboard.bhascovernode = isDefined(var_0);
}

bb_hadcovernode(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.bhascovernode);
}

bb_getcovernode() {
  return self._blackboard.covernode;
}

bb_getrequestedturret() {
  if(isDefined(self._blackboard.requestedturret))
    return self._blackboard.requestedturret;

  return undefined;
}

bb_requestturret(var_0) {
  self._blackboard.requestedturret = var_0;
}

bb_requestturretpose(var_0) {
  self._blackboard.requestedturretpose = var_0;
}

bb_hasshufflenode(var_0, var_1, var_2, var_3) {
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
    if(self.script == "_encstr_84DB09430E5B9A0B6D2001" || self.script == "_encstr_83F30911AECB135CC058C2")
      return 1;
  }

  return istrue(self._blackboard.animscriptedactive);
}

bb_requestmelee(var_0) {
  self._blackboard.meleerequested = 1;
  self._blackboard.meleerequestedtarget = var_0;
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
  self._blackboard._id_11BC0 = undefined;
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

bb_meleerequested() {
  return self._blackboard.meleerequested;
}

bb_meleerequestinvalid(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee))
    return 1;

  if(!isDefined(self.melee.target))
    return 1;

  return 0;
}

bb_requestmeleecharge(var_0, var_1) {
  self._blackboard.meleerequestedcharge = 1;
  self._blackboard.meleerequestedcharge_target = var_0;
  self._blackboard.meleerequestedcharge_targetposition = var_1;
}

bb_clearmeleechargerequest() {
  self._blackboard.meleerequestedcharge = 0;
  self._blackboard.meleerequestedcharge_target = undefined;
  self._blackboard.meleerequestedcharge_targetposition = undefined;
}

bb_meleechargerequested() {
  return isDefined(self._blackboard.meleerequestedcharge) && self._blackboard.meleerequestedcharge && isDefined(self.pathgoalpos);
}

bb_meleechargeaborted(var_0, var_1, var_2, var_3) {
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

bb_requestgrenadereturnthrow(var_0) {
  self._blackboard.bgrenadereturnthrow = var_0;
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

  if(!isDefined(var_0))
    var_0 = self.node;

  var_1 = isDefined(var_0) && (var_0.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C" || var_0.type == "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8");
  return self._blackboard.movetype == "_encstr_965108334E0B373A961B" && !var_1;
}

bb_ismissingaleg() {
  var_0 = bb_getmissingleg();

  if(isDefined(var_0))
    return 1;

  return 0;
}

bb_getmissingleg() {
  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(self._blackboard.dismemberedparts))
    return var_1;

  if(isDefined(self._blackboard.dismemberedparts["_encstr_A95F091BB2CC8EBEC62BD9"])) {
    var_0++;
    var_1 = "_encstr_A5AD056A019C63";
  }

  if(isDefined(self._blackboard.dismemberedparts["_encstr_91F40A7AB3E9A3E34790BA92"])) {
    var_0++;
    var_1 = "_encstr_8253060E2B5FE330";
  }

  if(var_0 == 2)
    var_1 = "_encstr_A99B055607BB60";

  return var_1;
}

ispartdismembered(var_0) {
  if(!isDefined(self._blackboard))
    return 0;

  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0]))
      return 0;

    return self._blackboard.scriptableparts[var_0].state == "_encstr_96560AC82DB95B2BDA31954E";
  }

  if(!isDefined(self._blackboard.dismemberedparts))
    return 0;

  return isDefined(self._blackboard.dismemberedparts[var_0]);
}

bb_ispartdismembered(var_0, var_1, var_2, var_3) {
  return ispartdismembered(var_3);
}

waspartjustdismembered(var_0) {
  if(isDefined(self._blackboard.scriptableparts)) {
    if(!isDefined(self._blackboard.scriptableparts[var_0]))
      return 0;

    if(self._blackboard.scriptableparts[var_0].state != "_encstr_96560AC82DB95B2BDA31954E")
      return 0;

    return self._blackboard.scriptableparts[var_0].time == gettime();
  }

  if(!isDefined(self._blackboard.dismemberedparts))
    return 0;

  if(!isDefined(self._blackboard.dismemberedparts[var_0]))
    return 0;

  return self._blackboard.dismemberedparts[var_0] == gettime();
}

bb_waspartjustdismembered(var_0, var_1, var_2, var_3) {
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

bb_setheadless(var_0) {
  self._blackboard.isheadless = var_0;
}

bb_isheadless() {
  if(isDefined(self.bt.crawlmeleegrab))
    return 0;

  return isDefined(self._blackboard.isheadless);
}

bb_setcanrodeo(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = "_encstr_A5AD056A019C63";

  if(var_0 == var_2)
    var_2 = "_encstr_8253060E2B5FE330";

  if(isDefined(self._blackboard.rodeo) && isDefined(self._blackboard.rodeo[var_2])) {
    self._blackboard.rodeo[var_2] = 0;
    self._blackboard.rodeo[var_0] = 0;
    return;
  }

  self._blackboard.rodeo[var_0] = var_1;
}

bb_canrodeo(var_0) {
  if(!isDefined(self._blackboard.rodeo))
    return 0;

  if(!isDefined(self._blackboard.rodeo[var_0]))
    return 0;

  if(!self._blackboard.rodeo[var_0])
    return 0;

  return 1;
}

bb_setrodeorequest(var_0) {
  self._blackboard.rodeorequest = var_0;
}

bb_clearrodeorequest(var_0) {
  self._blackboard.rodeorequested = undefined;
}

bb_isrodeorequested(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.rodeorequest))
    return 0;

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
  if(isDefined(self.melee.target))
    self.melee.target.melee = undefined;

  if(isDefined(self.melee.temp_ent))
    self.melee.temp_ent delete();

  self.melee = undefined;
}

bb_setcrawlmelee(var_0) {
  self._blackboard.crawlmelee = var_0;
}

bb_iscrawlmelee() {
  return isDefined(self._blackboard.crawlmelee);
}

bb_sethaywire(var_0) {
  self._blackboard.haywire = var_0;
}

bb_ishaywire() {
  return isDefined(self._blackboard.haywire);
}

bb_gethaywire() {
  return self._blackboard.haywire;
}

bb_setisinbadcrouchspot(var_0) {
  self._blackboard.bbadcrouchspot = var_0;
}

bb_isinbadcrouchspot() {
  return istrue(self._blackboard.bbadcrouchspot);
}

bb_setcivilianstate(var_0) {
  if(isDefined(self._blackboard.civstate) && self._blackboard.civstate == var_0) {
    return;
  }
  self._blackboard.civstate = var_0;
  self._blackboard.civstatetime = gettime();
}

bb_getcivilianstate() {
  return self._blackboard.civstate;
}

bb_getcivilianstatetime() {
  return self._blackboard.civstatetime;
}

bb_civilianrequestspeed(var_0) {
  scripts\engine\utility::set_movement_speed(var_0);
}

bb_isshort() {
  return istrue(self._blackboard.short);
}

bb_setshort(var_0) {
  self._blackboard.short = var_0;
}

bb_smartobjectrequested() {
  return isDefined(self._blackboard.smartobject);
}

bb_requestsmartobject(var_0) {
  self._blackboard.smartobject = var_0;
}

bb_getrequestedsmartobject() {
  return self._blackboard.smartobject;
}

bb_clearsmartobject() {
  self._blackboard.smartobject = undefined;
  bb_clearplaysmartobject();
}

bb_requestplaysmartobject() {
  self._blackboard.bplaysmartobject = 1;
}

bb_clearplaysmartobject() {
  self._blackboard.bplaysmartobject = undefined;
}

bb_playsmartobjectrequested() {
  return istrue(self._blackboard.bplaysmartobject);
}

bb_requestcovermultiswitch(var_0, var_1) {
  self._blackboard.docovermultiswitchnode = var_0;
  self._blackboard.docovermultiswitchnodetype = var_1;
}

bb_getrequestedcovermultiswitchnodetype() {
  return [self._blackboard.docovermultiswitchnode, self._blackboard.docovermultiswitchnodetype];
}

bb_resetcovermultiswitch() {
  self._blackboard.docovermultiswitchnode = undefined;
  self._blackboard.docovermultiswitchnodetype = undefined;
}

bb_iscovermultiswitchrequested() {
  return isDefined(self._blackboard.docovermultiswitchnode);
}

bb_canplaygesture(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.gesturerequest))
    return 0;

  if(isDefined(var_3) && self._blackboard.gesturerequest.gesture != var_3)
    return 0;

  if(!isDefined(self._blackboard.gesturerequest.latestalias))
    return 0;

  if(gettime() > self._blackboard.gesturerequest.timeoutms)
    return 0;

  var_4 = self._blackboard.gesturerequest.latestalias;

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4))
    return 0;

  return 1;
}

bb_shouldwildfire(var_0, var_1, var_2) {
  if(!istrue(self._blackboard.isrebel))
    return 0;

  var_3 = 50;
  return randomint(100) <= var_3;
}