/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\ent_manager.gsc
***********************************************/

init() {
  level.entbudgetused = 0;
  level.entbudget = getdvarint("dvar_3E029CF0DE92274B", 200);
  level.budgetedents = [];
}

registerspawncount(entcount) {
  self.entcount = entcount;
  level.entbudgetused = level.entbudgetused + entcount;
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

registerspawn(entcount, deletefunc) {
  self.entcount = entcount;
  self.entdeletefunc = deletefunc;
  level.entbudgetused = level.entbudgetused + entcount;
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