/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\ent_manager.gsc
***********************************************/

function init() {
  level.entbudgetused = 0;
  level.entbudget = getdvarint("scr_disposable_entity_budget", 200);
  level.budgetedents = [];
}

function registerspawncount(var_0) {
  self.entcount = var_0;
  level.entbudgetused += var_0;
  updatebudget();
}

function deregisterspawn() {
  if(isDefined(self.entcount) && !isDefined(self.deregistered)) {
    level.entbudgetused -= self.entcount;
    self.deregistered = 1;
    self.entcount = undefined;

    if(level.entbudgetused < 0) {
      level.entbudgetused = 0;
    }
  }

  if(isDefined(self.entdeletefunc)) {
    level.budgetedents = scripts\engine\utility::array_remove(level.budgetedents, self);
    self.entdeletefunc = undefined;
    return;
  }
}

function registerspawn(var_0, var_1) {
  self.entcount = var_0;
  self.entdeletefunc = var_1;
  level.entbudgetused += var_0;
  level.budgetedents[level.budgetedents.size] = self;
  updatebudget();
}

function updatebudget() {
  if(level.entbudgetused > level.entbudget) {
    if(isDefined(level.budgetedents[0])) {
      level.entbudgetused -= level.budgetedents[0].entcount;
      self[[level.budgetedents[0].entdeletefunc]]();
    }

    level.budgetedents = scripts\engine\utility::array_slice(level.budgetedents, 0, 1);
    return;
  }
}