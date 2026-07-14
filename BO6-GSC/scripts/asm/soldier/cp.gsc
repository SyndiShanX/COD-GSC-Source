/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cp.gsc
**************************************/

#namespace cp;

function transition_parachutestate(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.parachutestate) && self._blackboard.parachutestate == params;
}

function function_df6717c43e186ed8(asmname, statename, tostatename, params) {
  return self codemoverequested() && isDefined(self.grenade);
}