/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\execution.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\operator;
#using scripts\engine\utility;
#namespace execution;

function function_1ea3e44fd8a18d1() {
  if(isbot(self) && getdvarint(@ "hash_eb038ca43332e718", 0) == 0) {
    return false;
  }

  if(istestclient(self)) {
    return false;
  }

  return true;
}

function _giveexecution(ref, isfirstperson) {
  if(!function_1ea3e44fd8a18d1()) {
    return;
  }

  thread execution_monitor();

  if(function_3b6961b424a382f()) {
    var_25a38dfaf37fc298 = tolower(getDvar(@ "hash_88ba4ca6e5ff9d5a", ""));

    if(isDefined(level.execution.table[var_25a38dfaf37fc298])) {
      ref = var_25a38dfaf37fc298;
    }
  }

  _clearexecution(istrue(isfirstperson));
  propweapon = execution_getpropweaponbyref(ref);
  execution = execution_getexecutionbyref(ref);
  assertex(isDefined(execution), "<dev string:x1c>" + ref);

  if(!isDefined(execution)) {
    return;
  }

  if(isDefined(propweapon)) {
    self giveweapon(propweapon);
    self giveexecution(execution, propweapon, istrue(isfirstperson));
  } else {
    self giveexecution(execution, undefined, istrue(isfirstperson));
  }

  if(istrue(function_700277400dcb7857(ref))) {
    function_43a90e553f84c31c();
  }

  self.executionref = ref;

  if(issharedfuncdefined("game", "lpcFeatureGated") && ![[getsharedfunc("game", "lpcFeatureGated")]]()) {
    thread watchinexecution();
  }
}

function _clearexecution(isfirstperson) {
  if(isDefined(self.executionref)) {
    self clearexecution(istrue(isfirstperson));
    propweapon = execution_getpropweaponbyref(self.executionref);

    if(isDefined(propweapon) && self hasweapon(propweapon)) {
      self takeweapon(propweapon);
    }

    self.executionref = undefined;
  }
}

function hasexecution() {
  return isDefined(self.executionref);
}

function execution_monitor() {
  self notify("exec_monitor_request");
  self endon("exec_monitor_request");

  while(true) {
    self waittill("execution_begin", victiment);

    if(isDefined(self.executionref) && isDefined(self.suit)) {
      aliasstring = "mus_" + self.suit + "_" + self.executionref;

      if(soundexists(aliasstring)) {
        self playlocalsound(aliasstring);
        victiment playlocalsound(aliasstring);
      }
    }

    if(isDefined(victiment)) {
      if(isDefined(victiment.basearchetype) && victiment.basearchetype == "zombie_base") {
        victiment setentitysoundcontext("gender", "zombie");
      }
    }

    wait 2;
  }
}

function execution_init() {
  assertex(!isDefined(level.execution), "execution_init was called more than once.");
  level.execution = spawnStruct();
  level.enableexecutionattackfunc = &enableexecutionattackwrapper;
  level.disableexecutionattackfunc = &disableexecutionattackwrapper;
  level.enableexecutionvictimfunc = &enableexecutionvictimwrapper;
  level.disableexecutionvictimfunc = &disableexecutionvictimwrapper;
  execution_loadtable();

  if(issharedfuncdefined("execution", "init")) {
    [[getsharedfunc("execution", "init")]]();
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

  foreach(executionref in scripts\cp_mp\operator::function_232a4826a2bd2bfd()) {
    struct = spawnStruct();
    struct.ref = executionref;
    id = scripts\cp_mp\operator::function_3daf6bb451cf826e(executionref);
    assertex(isDefined(id), "Executions error -\"" + executionref + "\" has no id.");
    struct.id = int(id);
    execution = scripts\cp_mp\operator::function_75322d3c8f9c9ccb(executionref);
    assertex(isDefined(execution) && execution != "", "Executions error -\"" + executionref + "\" has no execution.");

    if(execution != "none") {
      struct.execution = execution;
    }

    propweapon = scripts\cp_mp\operator::function_3bd82b573b8f64f3(executionref);
    assertex(isDefined(propweapon) && propweapon != "", "Executions error -\"" + executionref + "\" has no prop weapon.");

    if(propweapon != "none") {
      struct.propweapon = makeweapon(propweapon);

      if(isnullweapon(struct.propweapon)) {
        continue;
      }
    }

    level.execution.table[executionref] = struct;
  }
}

function execution_getexecutionbyref(ref) {
  assertex(isDefined(level.execution), "execution_getExecutionByRef called before execution_init.");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.execution;
  }

  return undefined;
}

function execution_getpropweaponbyref(ref) {
  assertex(isDefined(level.execution), "execution_getPropWeaponByRef called before execution_init.");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.propweapon;
  }

  return undefined;
}

function execution_getrefbyplayer(player) {
  return player.executionref;
}

function execution_getidbyref(ref) {
  assertex(isDefined(level.execution), "execution_getIDByRef called before execution_init.");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.id;
  }
}

function function_700277400dcb7857(ref) {
  assertex(isDefined(level.execution), "execution_getIDByRef called before execution_init.");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.petenabled;
  }
}

function function_43a90e553f84c31c() {
  scripts\common\values::set("pet_execution", "hide_operator_backpack", 1);
}

function execution_blockladders() {
  if(self isonladder()) {
    if(!istrue(self.ladderexecutionblocked)) {
      val::set("ladderExecution", "execution_attack", 0);
      val::set("ladderExecution", "execution_victim", 0);
      self.ladderexecutionblocked = 1;
    }

    return;
  }

  if(istrue(self.ladderexecutionblocked)) {
    val::reset_all("ladderExecution");
    self.ladderexecutionblocked = undefined;
  }
}

function watchinexecution() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  var_a9ee87cc06bd6b39 = 0;

  while(true) {
    inexecution = self isinexecutionattack() || self isinexecutionvictim();

    if(inexecution != var_a9ee87cc06bd6b39 && !scripts\common\utility::isusingremote()) {
      if(inexecution) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else {
        self disablephysicaldepthoffieldscripting();
      }
    }

    var_a9ee87cc06bd6b39 = inexecution;
    waitframe();
  }
}

function is_in_takedown() {
  return self isinexecutionvictim() || self isinexecutionattack();
}