/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\emp_debuff_cp.gsc
***********************************************/

emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_88D513EC563A05D8582FB24EA8A6A052B55BAB372B", ::getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_871F133A5501E99CD93097C339B478A09BF903F5CD", ::setplayerempimmune);
}

getplayerempimmune() {
  return isDefined(self.empnotallowed);
}

setplayerempimmune(var_0) {
  if(!isDefined(self.empnotallowed))
    self.empnotallowed = 0;

  if(var_0) {
    self.empnotallowed--;

    if(self.empnotallowed == 0)
      self.empnotallowed = undefined;
  } else
    self.empnotallowed++;
}