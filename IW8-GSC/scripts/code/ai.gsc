/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\ai.gsc
***********************************************/

function free_expendable() {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return;
  }

  var_0 = self.spawner;
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    var_1.suspendvars = self.suspendvars;
  } else {
    var_1.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    var_1.stealth = spawnStruct();
    var_1.stealth.bsmstate = self.stealth.bsmstate;
    var_1.stealth.investigateevent = self.stealth.investigateevent;
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        var_1.target = self.node.targetname;
      }

      var_1.node = self.node;
    }

    var_1.target = self.node.targetname;
  }

  var_0.suspended_ai = var_1;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free)) {
    free_groupname(self.script_suspend_group);
    return;
  }
}

function free_groupname(var_0) {
  if(!isDefined(level.processfreegroupname)) {
    level.processfreegroupname = [];
  }

  if(isDefined(level.processfreegroupname[var_0])) {
    return;
  }

  level.processfreegroupname[var_0] = 1;
  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }

    if(!isDefined(var_3.script_suspend_group)) {
      continue;
    }

    if(var_3.script_suspend_group != var_0) {
      continue;
    }

    var_3.script_free = 1;
    free_expendable(var_3);
    var_3 delete();
  }

  level.processfreegroupname[var_0] = undefined;
}

function create_weapon_in_script(var_0, var_1) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(var_0)) {
      var_2 = isundefinedweapon();
    } else if(!isarray(var_1) && var_1 == "") {
      var_2 = isundefinedweapon();
    } else if(isarray(var_2)) {
      var_2 = getcompleteweaponname(var_2[randomint(var_2.size)]);
    } else {
      var_2 = getcompleteweaponname(var_2);
    }

    if(!nullweapon(var_2)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(var_2) && var_2 == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = var_2;
      } else {
        self.scriptedweaponfailed_primaryarray = var_2;
      }
    }

    return var_2;
  }

  return [[level.fnscriptedweaponassignment]](var_2, var_2);
}