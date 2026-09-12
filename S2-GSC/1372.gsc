/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1372.gsc
*********************************************/

init() {
  var_00 = level.var_A41["zombie"];
  var_00["think"] = ::func_AB57;
  var_00["move_mode"] = ::func_AB54;
  var_00["post_model"] = ::func_AB52;
  var_00["ragdoll_overrides"] = ::func_AB56;
  var_00["on_damaged"] = ::func_AB55;
  var_00["is_hit_weak_point"] = ::func_AB53;
  level.var_A41["zombie_berserker"] = var_00;
  var_01["whole_body"] = "zom_sprinter_base";
  var_01["heads"] = ["zom_sprinter_head"];
  var_02 = spawnStruct();
  var_02.var_A4B = "zombie_berserker";
  var_02.var_EAE = "zombie_animclass";
  var_02.var_879 = "zombie_generic";
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
  lib_0547::func_A52(var_02, "zombie_berserker");
  common_scripts\utility::func_92C("zmb_sprinter_head_flies", "vfx/zombie/zmb_sprinter_head_flies");
}

func_AB57() {
  var_00 = 0.08722223;
  self method_85E0(1);
  self method_85DE(var_00);
  self.var_2FA4 = 0;
  self.cornerlessturnmindegreeoverride = 70;
  self method_85A1("zombie_berserker");
  self.stuckfortraversalthreshold = 16;
  lib_0566::func_ABB4();
}

func_AB54() {
  self.var_64C2 = 1.1 * lib_054D::func_4440();
  return "sprint";
}

func_4759() {
  self endon("death");
  wait 0.05;
  wait 0.05;
  wait 0.05;
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sprinter_head_flies"), self, "j_head");
}

func_AB52() {
  var_00 = self method_8445("j_head");
  if(var_00 == -1) {}

  thread func_4759();
}

func_AB56() {
  return 0.8;
}

func_AB55(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(param_05 == "panzerschreck_zm" || param_05 == "bazooka_zm") {
    param_02 = self.maxhealth;
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_AB53(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_08) && param_08 == "head" || param_08 == "helmet") {
    return 1;
  }

  return 0;
}