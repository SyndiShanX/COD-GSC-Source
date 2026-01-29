/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\dshk_stand.gsc
****************************************************/

#using_animtree("generic_human");

main() {
  var_0 = self getturret();
  var_1 = _id_48D5();
  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  self._id_4888 = % gazgunner_aim;
  self._id_48A6 = % gaz_turret_aim_6_add;
  self._id_48A5 = % gaz_turret_aim_4_add;
  self._id_489A = % additive_gazgunner_aim_leftright;
  self._id_48B8 = % gaz_turret_idle;
  self._id_48B9 = % gaz_turret_idle;
  self._id_48B4 = % gaz_turret_fire;
  self._id_4899 = % additive_gazgunner_usegun;
  self._id_48D4 = % gazgunner_death;
  self._id_4894 = var_1;
  self._id_4890[0] = % gaz_turret_paina;
  self._id_4890[1] = % gaz_turret_painb;
  self._id_4891 = % gaz_turret_flincha;
  self._id_48BF = % gaz_turret_paina;
  self._id_489B = % gazgunner;
  var_2 = [];
  var_2["humvee_turret_flinchA"] = % gaz_turret_flincha;
  var_2["humvee_turret_flinchB"] = % gaz_turret_flinchb;
  self._id_4896 = var_2;
  var_0 _id_48D7();
  thread animscripts\hummer_turret\minigun_code::main(var_0);
}

_id_48D5() {
  var_0 = % gaz_turret_death;

  if(isDefined(self._id_0EF1)) {
    if(isDefined(level._id_48D6)) {
      var_0 = self[[level._id_48D6]]();
    }
  }

  return var_0;
}

#using_animtree("vehicles");

_id_48D7() {
  self useanimtree(#animtree);
  self._id_48AB = % humvee_passenger_2_turret_minigun;
  self._id_48D8 = % humvee_turret_2_passenger_minigun;
}