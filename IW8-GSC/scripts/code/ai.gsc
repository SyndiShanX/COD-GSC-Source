/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\ai.gsc
***********************************************/

function free_expendable() {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return;
  }

  var0 = self.spawner;
  var1 = spawnStruct();
  var1.origin = self.origin;
  var1.angles = self.angles;
  var1.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    var1.suspendvars = self.suspendvars;
  } else {
    var1.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    var1.stealth = spawnStruct();
    var1.stealth.bsmstate = self.stealth.bsmstate;
    var1.stealth.investigateevent = self.stealth.investigateevent;
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        var1.target = self.node.targetname;
      }

      var1.node = self.node;
    }

    var1.target = self.node.targetname;
  }

  var0.suspended_ai = var1;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free)) {
    free_groupname(self.script_suspend_group);
    return;
  }
}

function free_groupname(var0) {
  if(!isDefined(level.processfreegroupname)) {
    level.processfreegroupname = [];
  }

  if(isDefined(level.processfreegroupname[var0])) {
    return;
  }

  level.processfreegroupname[var0] = 1;
  var1 = getaiarray();

  foreach(var3 in var1) {
    if(var3 == self) {
      continue;
    }

    if(!isDefined(var3.script_suspend_group)) {
      continue;
    }

    if(var3.script_suspend_group != var0) {
      continue;
    }

    var3.script_free = 1;
    free_expendable(var3);
    var3 delete();
  }

  level.processfreegroupname[var0] = undefined;
}

function create_weapon_in_script(var0, var1) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(var0)) {
      var2 = isundefinedweapon();
    } else if(!isarray(var1) && var1 == "") {
      var2 = isundefinedweapon();
    } else if(isarray(var2)) {
      var2 = getcompleteweaponname(var2[randomint(var2.size)]);
    } else {
      var2 = getcompleteweaponname(var2);
    }

    if(!nullweapon(var2)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(var2) && var2 == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = var2;
      } else {
        self.scriptedweaponfailed_primaryarray = var2;
      }
    }

    return var2;
  }

  return [[level.fnscriptedweaponassignment]](var2, var2);
}