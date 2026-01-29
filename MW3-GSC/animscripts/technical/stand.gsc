/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\technical\stand.gsc
*******************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  self.a._id_0D2B = "stop";
  var_0 = self getturret();
  var_0 thread _id_647D(self);
  self._id_4888 = % technicalgunner_aim;
  self._id_48B8 = % technical_turret_driveidle;
  self._id_48B4 = % technical_turret_firing;
  self._id_0D18 = ::_id_685F;
  self._id_0D50 = % technical_turret_death;
  thread animscripts\saw\common::main(var_0);
}

_id_685F() {
  self setflaggedanimknoballrestart("painanim", % technical_turret_pain, % body, 1, 0.1, 1);
  animscripts\shared::_id_0C51("painanim");
}

#using_animtree("mg42");

_id_647D(var_0) {
  self.leftarc = 180;
  self.rightarc = 180;
  self useanimtree(#animtree);
  self._id_48B8 = % saw_gunner_idle_mg;
  self._id_48B4 = % saw_gunner_firing_mg_add;
  self endon("death");
  var_0 waittill("killanimscript");
  self stopuseanimtree();
}