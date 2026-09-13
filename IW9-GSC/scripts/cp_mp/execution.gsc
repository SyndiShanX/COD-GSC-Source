/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\execution.gsc
***********************************************/

_id_01EA3E44FD8A18D1() {
  if(!isDefined(self))
    return 0;

  if(isbot(self) && getdvarint("dvar_EB038CA43332E718", 0) == 0)
    return 0;

  if(istestclient(self))
    return 0;

  return 1;
}

_giveexecution(ref) {
  if(!_id_01EA3E44FD8A18D1()) {
    return;
  }
  thread _id_E3EEFF0E08C5BCD4();

  if(_func_03B6961B424A382F()) {
    _id_25A38DFAF37FC298 = tolower(getDvar("dvar_88BA4CA6E5FF9D5A", ""));

    if(isDefined(level.execution.table[_id_25A38DFAF37FC298]))
      ref = _id_25A38DFAF37FC298;
  }

  _clearexecution();
  propweapon = execution_getpropweaponbyref(ref);

  if(ref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western")
    propweapon = level.execution.table[ref]._id_D0B793BC71140446;

  if(isDefined(propweapon)) {
    self giveweapon(propweapon);
    self giveexecution(execution_getexecutionbyref(ref), propweapon);
  } else
    self giveexecution(execution_getexecutionbyref(ref));

  if(_id_700277400DCB7857(ref))
    _id_43A90E553F84C31C();

  self.executionref = ref;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]())
    thread watchinexecution();
}

_clearexecution() {
  if(isDefined(self.executionref)) {
    self clearexecution();
    propweapon = execution_getpropweaponbyref(self.executionref);

    if(self.executionref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western")
      propweapon = "iw9_execution_spear_wings";

    if(isDefined(propweapon) && self hasweapon(propweapon))
      self takeweapon(propweapon);

    self.executionref = undefined;
  }
}

hasexecution() {
  return isDefined(self.executionref);
}

_id_E3EEFF0E08C5BCD4() {
  self notify("exec_monitor_request");
  self endon("exec_monitor_request");

  for(;;) {
    self waittill("execution_begin", _id_3B77B9FD262214BE);

    if(isDefined(self.executionref) && isDefined(self.suit)) {
      _id_6FAB8D17004374F6 = "mus_" + self.suit + "_" + self.executionref;

      if(soundexists(_id_6FAB8D17004374F6)) {
        self playlocalsound(_id_6FAB8D17004374F6);
        _id_3B77B9FD262214BE playlocalsound(_id_6FAB8D17004374F6);
      }
    }

    wait 2;
  }
}

execution_init() {
  level.execution = spawnStruct();
  level.enableexecutionattackfunc = ::enableexecutionattackwrapper;
  level.disableexecutionattackfunc = ::disableexecutionattackwrapper;
  level.enableexecutionvictimfunc = ::enableexecutionvictimwrapper;
  level.disableexecutionvictimfunc = ::disableexecutionvictimwrapper;
  execution_loadtable();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("execution", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("execution", "init")]]();
}

enableexecutionattackwrapper() {
  self enableexecutionattack();
}

disableexecutionattackwrapper() {
  self disableexecutionattack();
}

enableexecutionvictimwrapper() {
  self enableexecutionvictim();
}

disableexecutionvictimwrapper() {
  self disableexecutionvictim();
}

execution_loadtable() {
  level.execution.table = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow("mp_cp/executiontable.csv", _id_CB89110314447B2F, 1);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    _id_39061D840C9E9B1F = tolower(ref);
    struct = spawnStruct();
    struct.ref = _id_39061D840C9E9B1F;
    id = tablelookupbyrow("mp_cp/executiontable.csv", _id_CB89110314447B2F, 0);
    struct.id = int(id);
    execution = tablelookupbyrow("mp_cp/executiontable.csv", _id_CB89110314447B2F, 12);

    if(execution != "none")
      struct.execution = execution;

    propweapon = tablelookupbyrow("mp_cp/executiontable.csv", _id_CB89110314447B2F, 13);

    if(propweapon != "none") {
      struct.propweapon = makeweapon(propweapon);

      if(execution == "execution_062")
        struct._id_D0B793BC71140446 = "iw9_execution_spear_wings";

      if(isnullweapon(struct.propweapon)) {
        _id_CB89110314447B2F++;
        continue;
      }
    }

    _id_D95A43AAE1A4AA60 = tablelookup("mp_cp/executiontable.csv", 1, _id_39061D840C9E9B1F, 18);
    struct._id_C5AF638225C7DDEF = scripts\engine\utility::ter_op(_id_D95A43AAE1A4AA60 == "1", 1, 0);
    level.execution.table[_id_39061D840C9E9B1F] = struct;
    _id_CB89110314447B2F++;
  }
}

execution_getexecutionbyref(ref) {
  struct = level.execution.table[ref];

  if(isDefined(struct))
    return struct.execution;

  return undefined;
}

execution_getpropweaponbyref(ref) {
  struct = level.execution.table[ref];

  if(isDefined(struct))
    return struct.propweapon;

  return undefined;
}

execution_getrefbyplayer(player) {
  return player.executionref;
}

execution_getidbyref(ref) {
  struct = level.execution.table[ref];

  if(isDefined(struct))
    return struct.id;
}

_id_700277400DCB7857(ref) {
  if(!isDefined(ref))
    return 0;

  struct = level.execution.table[ref];

  if(isDefined(struct))
    return istrue(struct._id_C5AF638225C7DDEF);
}

_id_43A90E553F84C31C() {
  _id_3B64EB40368C1450::set("pet_execution", "hide_operator_backpack", 1);
}

execution_blockladders() {
  if(self isonladder()) {
    if(!istrue(self.ladderexecutionblocked)) {
      _id_3B64EB40368C1450::set("ladderExecution", "execution_attack", 0);
      _id_3B64EB40368C1450::set("ladderExecution", "execution_victim", 0);
      self.ladderexecutionblocked = 1;
    }
  } else if(istrue(self.ladderexecutionblocked)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ladderExecution");
    self.ladderexecutionblocked = undefined;
  }
}

watchinexecution() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  _id_A9EE87CC06BD6B39 = 0;

  for(;;) {
    _id_350E6177AC9228D0 = self isinexecutionattack() || self isinexecutionvictim();

    if(_id_350E6177AC9228D0 != _id_A9EE87CC06BD6B39 && !scripts\cp_mp\utility\player_utility::isusingremote()) {
      if(_id_350E6177AC9228D0) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else
        self disablephysicaldepthoffieldscripting();
    }

    _id_A9EE87CC06BD6B39 = _id_350E6177AC9228D0;
    waitframe();
  }
}