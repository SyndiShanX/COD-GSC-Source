/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3871.gsc
************************/

main() {
  level.var_92DE["desk_lean"] = ::func_5281;
  level.var_92DE["wall_lean"] = ::func_138A7;
  level.var_EC85["generic"]["lean_intro"] = % titan_stealth_street_enemy01_lean_intro;
  level.var_EC85["generic"]["lean_idle"][0] = % titan_stealth_street_enemy01_lean_idle;
  level.var_EC85["generic"]["lean_react_left"] = % titan_stealth_street_enemy01_lean_react_left;
  level.var_EC85["generic"]["lean_react_forward"] = % titan_stealth_street_enemy01_lean_react_front;
  level.var_EC85["generic"]["lean_react_right"] = % titan_stealth_street_enemy01_lean_react_right;
  level.var_EC85["generic"]["lean_death"] = % titan_stealth_street_enemy01_lean_death;
  level.var_EC85["generic"]["lean_exit_right"] = % titan_stealth_street_enemy01_lean_exit_right;
  level.var_EC85["generic"]["lean_exit_left"] = % titan_stealth_street_enemy01_lean_exit_left;
  level.var_EC85["generic"]["lean_exit_forward"] = % titan_stealth_street_enemy01_lean_exit_front;
  level.var_EC85["generic"]["lean_exit_back"] = % titan_stealth_street_enemy01_lean_exit_back;
  level.var_EC85["generic"]["wall_lean_idle"][0] = % titan_stealth_street_enemy01_walllean_idle;
  level.var_EC85["generic"]["wall_lean_react_left"] = % titan_stealth_street_enemy01_walllean_react_left;
  level.var_EC85["generic"]["wall_lean_react_forward"] = % titan_stealth_street_enemy01_walllean_react_front;
  level.var_EC85["generic"]["wall_lean_react_right"] = % titan_stealth_street_enemy01_walllean_react_right;
  level.var_EC85["generic"]["wall_lean_death"] = % titan_stealth_street_enemy01_walllean_death;
  level.var_EC85["generic"]["wall_lean_exit_left"] = % titan_stealth_street_enemy01_walllean_exit_left;
  level.var_EC85["generic"]["wall_lean_exit_right"] = % titan_stealth_street_enemy01_walllean_exit_right;
  level.var_EC85["generic"]["wall_lean_exit_forward"] = % titan_stealth_street_enemy01_walllean_exit_front;
  level.var_EC85["generic"]["wall_lean_exit_back"] = % titan_stealth_street_enemy01_walllean_exit_back;
}

func_5281(param_00) {
  var_01 = [];
  var_01["left"] = "lean_react_left";
  var_01["right"] = "lean_react_right";
  var_01["forward"] = "lean_react_forward";
  var_01["default"] = "lean_react_forward";
  var_02["left"] = "lean_exit_left";
  var_02["right"] = "lean_exit_right";
  var_02["forward"] = "lean_exit_forward";
  var_02["back"] = "lean_exit_back";
  var_02["default"] = "lean_exit_forward";
  self.var_1FBB = "generic";
  param_00 lib_0F27::func_92CF(self, "lean_idle", var_01, "lean_death", undefined, 1);
  lib_0F27::func_F320(var_02);
}

func_138A7(param_00) {
  var_01 = [];
  var_01["left"] = "wall_lean_react_left";
  var_01["right"] = "wall_lean_react_right";
  var_01["forward"] = "wall_lean_react_forward";
  var_01["default"] = "wall_lean_react_forward";
  var_02["left"] = "wall_lean_exit_left";
  var_02["right"] = "wall_lean_exit_right";
  var_02["forward"] = "wall_lean_exit_forward";
  var_02["back"] = "wall_lean_exit_back";
  var_02["default"] = "wall_lean_exit_forward";
  self.var_1FBB = "generic";
  param_00 lib_0F27::func_92CF(self, "wall_lean_idle", var_01, "wall_lean_death");
  lib_0F27::func_F320(var_02);
}