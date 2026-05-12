/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1372.gsc
*********************************************/

lib_055C::func_00D5() {
  var_00 = level.var_0A41["zombie"];
  var_00["think"] = ::lib_055C::func_AB57;
  var_00["move_mode"] = ::lib_055C::func_AB54;
  var_00["post_model"] = ::lib_055C::func_AB52;
  var_00["ragdoll_overrides"] = ::lib_055C::func_AB56;
  var_00["on_damaged"] = ::lib_055C::func_AB55;
  var_00["is_hit_weak_point"] = ::lib_055C::func_AB53;
  level.var_0A41["zombie_berserker"] = var_00;
  var_01["whole_body"] = "zom_sprinter_base";
  var_01["heads"] = ["zom_sprinter_head"];
  var_02 = spawnStruct();
  var_02.var_0A4B = "zombie_berserker";
  var_02.var_0EAE = "zombie_animclass";
  var_02.var_0879 = "zombie_generic";
  var_02.var_5ED2["sprinter"] = var_01;
  var_02.var_4C12 = 0.5;
  var_02.var_60E2 = 30;
  var_02.var_8302 = 65;
  var_02.var_8303 = 15;
  var_02.parenttype = "zombie_generic";
  var_02.suppressive_fire_speed_multiplier = 0.3;
  var_02.tacklebymelee = 1;
  var_02.tacklebycharge = 1;
  var_02.knockbyravensword = 1;
  var_02.shockbyteslablood = 1;
  var_02.energyhold = 1;
  var_02.energyholdkill = 1;
  var_02.energyholdsecondary = 1;
  var_02.throwable = 1;
  lib_0547::func_0A52(var_02, "zombie_berserker");
  common_scripts\utility::func_092C("zmb_sprinter_head_flies", "vfx/zombie/zmb_sprinter_head_flies");
}

lib_055C::func_AB57() {
  var_00 = 0.08722223;
  self method_85E0(1);
  self method_85DE(var_00);
  self.var_2FA4 = 0;
  self.cornerlessturnmindegreeoverride = 70;
  self method_85A1("zombie_berserker");
  self.stuckfortraversalthreshold = 16;
  lib_0566::func_ABB4();
}

lib_055C::func_AB54() {
  self.var_64C2 = 1.1 * lib_054D::func_4440();
  return "sprint";
}

lib_055C::func_4759() {
  self endon("death");
  wait 0.05;
  wait 0.05;
  wait 0.05;
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sprinter_head_flies"), self, "j_head");
}

lib_055C::func_AB52() {
  var_00 = self method_8445("j_head");
  if(var_00 == -1) {}

  thread lib_055C::func_4759();
}

lib_055C::func_AB56() {
  return 0.8;
}

lib_055C::func_AB55(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(param_05 == "panzerschreck_zm" || param_05 == "bazooka_zm") {
    param_02 = self.var_00FB;
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

lib_055C::func_AB53(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_08) && param_08 == "head" || param_08 == "helmet") {
    return 1;
  }

  return 0;
}