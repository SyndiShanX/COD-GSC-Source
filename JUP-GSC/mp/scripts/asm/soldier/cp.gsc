/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cp.gsc
***********************************************/

#namespace cp;

function transition_parachutestate(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.parachutestate) && self._blackboard.parachutestate == params;
}

function function_6cef6e9599101b35(asmname, statename, tostatename, params) {
  return self codemoverequested() && isDefined(self.grenade);
}