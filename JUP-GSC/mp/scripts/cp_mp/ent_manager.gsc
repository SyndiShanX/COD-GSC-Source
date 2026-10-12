/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\ent_manager.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ent_manager;

function init() {
  level.entbudgetused = 0;
  level.entbudget = getdvarint(@ "hash_3e029cf0de92274b", 200);
  level.budgetedents = [];
}

function registerspawncount(entcount) {
  self.entcount = entcount;
  level.entbudgetused += entcount;
  updatebudget();
}

function deregisterspawn() {
  if(isDefined(self.entcount) && !isDefined(self.deregistered)) {
    level.entbudgetused -= self.entcount;
    self.deregistered = 1;
    self.entcount = undefined;

    if(level.entbudgetused < 0) {
      level.entbudgetused = 0;
      assertmsg("<dev string:x1c>");
    }
  }

  if(isDefined(self.entdeletefunc)) {
    level.budgetedents = scripts\engine\utility::array_remove(level.budgetedents, self);
    self.entdeletefunc = undefined;
  }
}

function registerspawn(entcount, deletefunc) {
  if(!isDefined(self)) {
    return;
  }

  self.entcount = entcount;
  self.entdeletefunc = deletefunc;
  level.entbudgetused += entcount;
  level.budgetedents[level.budgetedents.size] = self;
  updatebudget();
}

function updatebudget() {
  if(level.entbudgetused > level.entbudget) {
    if(isDefined(level.budgetedents[0])) {
      level.entbudgetused -= level.budgetedents[0].entcount;
      self[[level.budgetedents[0].entdeletefunc]]();
    } else {
      assertmsg("<dev string:x4f>");
    }

    level.budgetedents = scripts\engine\utility::array_slice(level.budgetedents, 0, 1);
  }
}

function function_a5aa9e07f21b879e() {
  if(isDefined(level.budgetedents)) {
    foreach(ent in level.budgetedents) {
      if(isDefined(ent.entdeletefunc)) {
        ent[[ent.entdeletefunc]]();
      }
    }
  }
}

# /