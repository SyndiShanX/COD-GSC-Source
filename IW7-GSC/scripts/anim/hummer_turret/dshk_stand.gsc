/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\dshk_stand.gsc
*****************************************************/

main() {
  var_0 = self _meth_8164();
  var_1 = func_7927();
  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  self.primaryturretanim = % gazgunner_aim;
  self.var_17E4 = % gaz_turret_aim_6_add;
  self.var_17E5 = % gaz_turret_aim_4_add;
  self.var_17E0 = % additive_gazgunner_aim_leftright;
  self.var_17E3 = % gaz_turret_idle;
  self.var_17E1 = % gaz_turret_idle;
  self.var_17E2 = % gaz_turret_fire;
  self.var_17E6 = % additive_gazgunner_usegun;
  self.var_12A5F = % gazgunner_death;
  self.var_12A5E = var_1;
  self.var_12A7F[0] = % gaz_turret_paina;
  self.var_12A7F[1] = % gaz_turret_painb;
  self.var_12A66 = % gaz_turret_flincha;
  self.var_12A81 = % gaz_turret_paina;
  self.var_12A93 = % gazgunner;
  var_2 = [];
  var_2["humvee_turret_flinchA"] = % gaz_turret_flincha;
  var_2["humvee_turret_flinchB"] = % gaz_turret_flinchb;
  self.var_12A92 = var_2;
  var_0 func_FA6A();
  thread scripts\anim\hummer_turret\minigun_code::main(var_0);
}

func_7927() {
  var_0 = % gaz_turret_death;
  if(isDefined(self.var_E500)) {
    if(isDefined(level.var_5F07)) {
      var_0 = self[[level.var_5F07]]();
    }
  }

  return var_0;
}

func_FA6A() {
  self glinton(#animtree);
  self.var_C937 = % humvee_passenger_2_turret_minigun;
  self.var_129B8 = % humvee_turret_2_passenger_minigun;
}