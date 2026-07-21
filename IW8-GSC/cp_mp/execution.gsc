/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\execution.gsc
***********************************************/

_giveexecution(var_0) {
  if(isbot(self) || isagent(self)) {
    return;
  }
  _clearexecution();
  var_1 = execution_getpropweaponbyref(var_0);

  if(isDefined(var_1)) {
    self giveweapon(var_1);
    self giveexecution(execution_getexecutionbyref(var_0), var_1);
  } else
    self giveexecution(execution_getexecutionbyref(var_0));

  self.executionref = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B14806D156B0B5B9", "_encstr_8F851C1B9CCAB03AACE90E594E161DDBC986AE9BD1DB5B2D4F2CD196F6CD"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B14806D156B0B5B9", "_encstr_8F851C1B9CCAB03AACE90E594E161DDBC986AE9BD1DB5B2D4F2CD196F6CD")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0")]]())
    thread _id_144E0();
}

_clearexecution() {
  if(isDefined(self.executionref)) {
    self clearexecution();
    var_0 = execution_getpropweaponbyref(self.executionref);

    if(isDefined(var_0) && self hasweapon(var_0))
      self takeweapon(var_0);

    self.executionref = undefined;
  }
}

hasexecution() {
  return isDefined(self.executionref);
}

execution_init() {
  level.execution = spawnStruct();
  level.enableexecutionattackfunc = ::enableexecutionattackwrapper;
  level.disableexecutionattackfunc = ::disableexecutionattackwrapper;
  level.enableexecutionvictimfunc = ::enableexecutionvictimwrapper;
  level.disableexecutionvictimfunc = ::disableexecutionvictimwrapper;
  execution_loadtable();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B1100A561EACC6AB3AB47BCD", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B1100A561EACC6AB3AB47BCD", "_encstr_88C5055208731B")]]();
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
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", var_0, 1);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    if(scripts\common\utility::iscp()) {
      var_2 = scripts\engine\utility::_encstr_A60611BAC359A32CD843EAFC53C07507727BE3(["_encstr_968317A04A15C3311D1833E2CDD030E923911E09E22EF99B35", "_encstr_B4C71B5B43763328F5CDF348F3CAD87D9B6F3DD18FD98E105AF5F9C35B"], 2, var_1, 3);

      if(isDefined(var_2) && var_2 != "_encstr_B40101" && var_2 != "_encstr_B21904D2EE0E") {
        var_0++;
        continue;
      }
    }

    var_3 = tolower(var_1);
    var_4 = spawnStruct();
    var_4.ref = var_3;
    var_5 = tablelookupbyrow("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", var_0, 0);
    var_4.id = int(var_5);
    var_6 = tablelookupbyrow("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", var_0, 12);

    if(var_6 != "_encstr_8BBA05185F8B99")
      var_4.execution = var_6;

    var_7 = tablelookupbyrow("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", var_0, 13);

    if(var_7 != "_encstr_8BBA05185F8B99") {
      var_4.propweapon = getcompleteweaponname(var_7);

      if(nullweapon(var_4.propweapon)) {
        var_0++;
        continue;
      }
    }

    level.execution.table[var_3] = var_4;
    var_0++;
  }
}

execution_getexecutionbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1))
    return var_1.execution;

  if(isDefined(var_0)) {
    var_2 = "_encstr_8A050FB2EA5567B3502B6F6651887FAB2F" + var_0 + "_encstr_872922AAF590632028F8539D71F2813ADF291337D1CDEB3D58830BA408B890D3C79D8B8F";
    var_3 = var_2 == undefined;
  }

  return undefined;
}

execution_getpropweaponbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1))
    return var_1.propweapon;

  return undefined;
}

execution_getrefbyplayer(var_0) {
  return var_0.executionref;
}

execution_getidbyref(var_0) {
  var_1 = level.execution.table[var_0];

  if(isDefined(var_1))
    return var_1.id;
}

execution_blockladders() {
  if(self isonladder()) {
    if(!istrue(self.ladderexecutionblocked)) {
      scripts\common\utility::allow_execution_attack(0);
      scripts\common\utility::allow_execution_victim(0);
      self.ladderexecutionblocked = 1;
    }
  } else if(istrue(self.ladderexecutionblocked)) {
    scripts\common\utility::allow_execution_attack(1);
    scripts\common\utility::allow_execution_victim(1);
    self.ladderexecutionblocked = undefined;
  }
}

_id_144E0() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8B531177C24736D0A4E654F0B26CAE1DD2ED37");
  self endon("_encstr_8B531177C24736D0A4E654F0B26CAE1DD2ED37");
  var_0 = 0;

  for(;;) {
    var_1 = self isinexecutionattack() || self isinexecutionvictim();

    if(var_1 != var_0) {
      if(var_1) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else
        self disablephysicaldepthoffieldscripting();
    }

    var_0 = var_1;
    waitframe();
  }
}