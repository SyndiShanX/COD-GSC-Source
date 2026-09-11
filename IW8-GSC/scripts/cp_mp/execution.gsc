/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\execution.gsc
***********************************************/

function _giveexecution(var0) {
  if(isbot(self) || isagent(self)) {
    return;
  }

  _clearexecution();
  var1 = execution_getpropweaponbyref(var0);

  if(isDefined(var1)) {
    self giveweapon(var1);
    self giveexecution(execution_getexecutionbyref(var0), var1);
  } else {
    self giveexecution(execution_getexecutionbyref(var0));
  }

  self.executionref = var0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teams", "createOperatorCustomization")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("teams", "createOperatorCustomization")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    thread ref_144e0();
    return;
  }
}

function _clearexecution() {
  if(isDefined(self.executionref)) {
    self clearexecution();
    var0 = execution_getpropweaponbyref(self.executionref);

    if(isDefined(var0) && self hasweapon(var0)) {
      self takeweapon(var0);
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

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp_cp/executiontable.csv", var0, 1);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    if(scripts\common\utility::iscp()) {
      var2 = scripts\engine\utility::multitablelookup(["mp/itemsourcetable.csv", "mp/itemsourcetable_ch2.csv"], 2, var1, 3);

      if(isDefined(var2) && var2 != "" && var2 != "iw8") {
        var0++;
        continue;
      }
    }

    var3 = tolower(var1);
    var4 = spawnStruct();
    var4.ref = var3;
    var5 = tablelookupbyrow("mp_cp/executiontable.csv", var0, 0);
    var4.id = int(var5);
    var6 = tablelookupbyrow("mp_cp/executiontable.csv", var0, 12);

    if(var6 != "none") {
      var4.execution = var6;
    }

    var7 = tablelookupbyrow("mp_cp/executiontable.csv", var0, 13);

    if(var7 != "none") {
      var4.propweapon = getcompleteweaponname(var7);

      if(nullweapon(var4.propweapon)) {
        var0++;
        continue;
      }
    }

    level.execution.table[var3] = var4;
  }
}

function execution_getexecutionbyref(var0) {
  var1 = level.execution.table[var0];

  if(isDefined(var1)) {
    return var1.execution;
  }

  if(isDefined(var0)) {
    var2 = "execution ref " + var0 + " not found in the execution table";
    var3 = var2 == undefined;
  }

  return undefined;
}

function execution_getpropweaponbyref(var0) {
  var1 = level.execution.table[var0];

  if(isDefined(var1)) {
    return var1.propweapon;
  }

  return undefined;
}

function execution_getrefbyplayer(var0) {
  return var0.executionref;
}

function execution_getidbyref(var0) {
  var1 = level.execution.table[var0];

  if(isDefined(var1)) {
    return var1.id;
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

function ref_144e0() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  var0 = 0;

  for(;;) {
    var1 = self isinexecutionattack() || self isinexecutionvictim();

    if(var1 != var0) {
      if(var1) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else {
        self disablephysicaldepthoffieldscripting();
      }
    }

    var0 = var1;
    waitframe();
  }
}