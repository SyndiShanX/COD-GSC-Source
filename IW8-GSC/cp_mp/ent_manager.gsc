/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\ent_manager.gsc
***********************************************/

init() {
  level.entbudgetused = 0;
  level.entbudget = getdvarint("_encstr_A6A11D6B46DACF97AFDF4F17379F217525F6BF3AFB60A3CB17C91BE9C1F55B", 200);
  level.budgetedents = [];
}

registerspawncount(var_0) {
  self.entcount = var_0;
  level.entbudgetused = level.entbudgetused + var_0;
  updatebudget();
}

deregisterspawn() {
  if(isDefined(self.entcount) && !isDefined(self.deregistered)) {
    level.entbudgetused = level.entbudgetused - self.entcount;
    self.deregistered = 1;
    self.entcount = undefined;

    if(level.entbudgetused < 0)
      level.entbudgetused = 0;
  }

  if(isDefined(self.entdeletefunc)) {
    level.budgetedents = scripts\engine\utility::array_remove(level.budgetedents, self);
    self.entdeletefunc = undefined;
  }
}

registerspawn(var_0, var_1) {
  self.entcount = var_0;
  self.entdeletefunc = var_1;
  level.entbudgetused = level.entbudgetused + var_0;
  level.budgetedents[level.budgetedents.size] = self;
  updatebudget();
}

updatebudget() {
  if(level.entbudgetused > level.entbudget) {
    if(isDefined(level.budgetedents[0])) {
      level.entbudgetused = level.entbudgetused - level.budgetedents[0].entcount;
      self[[level.budgetedents[0].entdeletefunc]]();
    } else {}

    level.budgetedents = scripts\engine\utility::array_slice(level.budgetedents, 0, 1);
  }
}