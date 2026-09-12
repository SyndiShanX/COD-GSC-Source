/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\execution.gsc
***********************************************/

function _giveexecution(var_0) {
  if(isbot(self) || isagent(self)) {
    return;
  }

  _clearexecution();
  var_1 = execution_getpropweaponbyref(var_0);

  if(isDefined(var_1)) {
    self giveweapon(var_1);
    self giveexecution(execution_getexecutionbyref(var_0), var_1);
  } else {
    self giveexecution(execution_getexecutionbyref(var_0));
  }

  self.executionref = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teams", "createOperatorCustomization")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("teams", "createOperatorCustomization")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    thread ref_144E0();
    return;
  }
}

function _clearexecution() {
  if(isDefined(self.executionref)) {
    self clearexecution();
    var_0 = execution_getpropweaponbyref(self.executionref);

    if(isDefined(var_0) && self hasweapon(var_0)) {
      self takeweapon(var_0);
    }

    self.executionref = undefined;
    return;
  }
}

function hasexecution() {
  return isDefined(self.executionref);
}

function execution_init() {
  level.execution = spawnStruct();
  level.enableexecutionattackfunc = &enableexecutionattackwrapper;
  level.disableexecutionattackfunc = &disableexecutionattackwrapper;
  level.enableexecutionvictimfunc = &enableexecutionvictimwrapper;
  level.disableexecutionvictimfunc = &disableexecutionvictimwrapper;
  execution_loadtable();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("execution", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("execution", "init")]]();
    return;
  }
}

function enableexecutionattackwrapper() {
  self enableexecutionattack();
}

function disableexecutionattackwrapper() {
  self disableexecutionattack();
}

function enableexecutionvictimwrapper() {
  self enableexecutionvictim();
}

function disableexecutionvictimwrapper() {
  self disableexecutionvictim();
}

function execution_loadtable() {
  level.execution.table = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp_cp/executiontable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(scripts\common\utility::iscp()) {
      var_2 = scripts\engine\utility::multitablelookup(["mp/itemsourcetable.csv", "mp/itemsourcetable_ch2.csv"], 2, var_1, 3);

      if(isDefined(var_2) && var_2 != "" && var_2 != "iw8") {
        var_0++;
        continue;
      }
    }

    var_3 = tolower(var_1);
    var_4 = spawnStruct();
    var_4.ref = var_3;
    var_5 = tablelookupbyrow("mp_cp/executiontable.csv", var_0, 0);
    var_4.id = int(var_5);
    var_6 = tablelookupbyrow("mp_cp/executiontable.csv", var_0, 12);

    if(var_6 != "none") {
      var_4.execution = var_6;
    }

    var_7 = tablelookupbyrow("mp_cp/executiontable.csv", var_0, 13);

    if(var_7 != "none") {
      var_4.propweapon = getcompleteweaponname(var_7);

      if(nullweapon(var_4.propweapon)) {
        var_0++;
        continue;
      }
    }

    level.execution.table[var_3] = var_4;
  }
}

function execution_getexecutionbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1)) {
    return var_1.execution;
  }

  if(isDefined(var_0)) {
    var_2 = "execution ref " + var_0 + " not found in the execution table";
    var_3 = var_2 == undefined;
  }

  return undefined;
}

function execution_getpropweaponbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1)) {
    return var_1.propweapon;
  }

  return undefined;
}

function execution_getrefbyplayer(var_0) {
  return var_0.executionref;
}

function execution_getidbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1)) {
    return var_1.id;
  }
}

function execution_blockladders() {
  if(self isonladder()) {
    if(!istrue(self.ladderexecutionblocked)) {
      scripts\common\utility::allow_execution_attack(0);
      scripts\common\utility::allow_execution_victim(0);
      self.ladderexecutionblocked = 1;
      return;
    }

    return;
  }

  if(istrue(self.ladderexecutionblocked)) {
    scripts\common\utility::allow_execution_attack(1);
    scripts\common\utility::allow_execution_victim(1);
    self.ladderexecutionblocked = undefined;
    return;
  }
}

function ref_144E0() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  var_0 = 0;

  for(;;) {
    var_1 = self isinexecutionattack() || self isinexecutionvictim();

    if(var_1 != var_0) {
      if(var_1) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else {
        self disablephysicaldepthoffieldscripting();
      }
    }

    var_0 = var_1;
    waitframe();
  }
}