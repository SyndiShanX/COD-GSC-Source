/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\saw\stand.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  self.a._id_0D2B = "stop";
  var_0 = self getturret();
  var_0 thread _id_647D(self);
  self._id_4888 = % standsawgunner_aim;
  self._id_48B8 = % saw_gunner_idle;
  self._id_48B4 = % saw_gunner_firing_add;
  thread animscripts\saw\common::main(var_0);
}

#using_animtree("mg42");

_id_647D(var_0) {
  self useanimtree(#animtree);
  self._id_48B8 = % saw_gunner_idle_mg;
  self._id_48B4 = % saw_gunner_firing_mg_add;
  self endon("death");
  var_0 waittill("killanimscript");
  self stopuseanimtree();
}