/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cp.gsc
***********************************************/

transition_parachutestate(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard.parachutestate) && self._blackboard.parachutestate == params;
}