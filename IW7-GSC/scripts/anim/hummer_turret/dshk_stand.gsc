/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\dshk_stand.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  var_0 = self _meth_8164();
  var_1 = _id_7927();
  self._id_5270 = "stand";
  scripts\anim\utility::_id_12E5F();
  self.primaryturretanim = % gazgunner_aim;
  self._id_17E4 = % gaz_turret_aim_6_add;
  self._id_17E5 = % gaz_turret_aim_4_add;
  self._id_17E0 = % additive_gazgunner_aim_leftright;
  self._id_17E3 = % gaz_turret_idle;
  self._id_17E1 = % gaz_turret_idle;
  self._id_17E2 = % gaz_turret_fire;
  self._id_17E6 = % additive_gazgunner_usegun;
  self._id_12A5F = % gazgunner_death;
  self._id_12A5E = var_1;
  self._id_12A7F[0] = % gaz_turret_paina;
  self._id_12A7F[1] = % gaz_turret_painb;
  self._id_12A66 = % gaz_turret_flincha;
  self._id_12A81 = % gaz_turret_paina;
  self._id_12A93 = % gazgunner;
  var_2 = [];
  var_2["humvee_turret_flinchA"] = % gaz_turret_flincha;
  var_2["humvee_turret_flinchB"] = % gaz_turret_flinchb;
  self._id_12A92 = var_2;
  var_0 _id_FA6A();
  thread scripts\anim\hummer_turret\minigun_code::main(var_0);
}

_id_7927() {
  var_0 = % gaz_turret_death;

  if(isDefined(self._id_E500)) {
    if(isDefined(level._id_5F07)) {
      var_0 = self[[level._id_5F07]]();
    }
  }

  return var_0;
}

#using_animtree("vehicles");

_id_FA6A() {
  self _meth_83D0(#animtree);
  self._id_C937 = % humvee_passenger_2_turret_minigun;
  self._id_129B8 = % humvee_turret_2_passenger_minigun;
}