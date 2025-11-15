/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3870.gsc
************************/

main() {
  level.var_92DE["guy1_convo"] = ::func_8728;
  level.var_92DE["guy2_convo"] = ::func_8729;
  level.var_EC85["generic"]["guy1_convo_idle"][0] = % titan_stealth_street_enemy01_convo_idle;
  level.var_EC85["generic"]["guy1_convo_react_left"] = % titan_stealth_street_enemy01_convo_react_left;
  level.var_EC85["generic"]["guy1_convo_react_front"] = % titan_stealth_street_enemy01_convo_react_front;
  level.var_EC85["generic"]["guy1_convo_react_back"] = % titan_stealth_street_enemy01_convo_react_back;
  level.var_EC85["generic"]["guy1_convo_react_right"] = % titan_stealth_street_enemy01_convo_react_right;
  level.var_EC85["generic"]["guy1_convo_death"] = % titan_stealth_street_enemy01_convo_death;
  level.var_EC85["generic"]["guy1_convo_exit_front"] = % titan_stealth_street_enemy01_convo_exit_front;
  level.var_EC85["generic"]["guy1_convo_exit_back"] = % titan_stealth_street_enemy01_convo_exit_back;
  level.var_EC85["generic"]["guy1_convo_exit_left"] = % titan_stealth_street_enemy01_convo_exit_left;
  level.var_EC85["generic"]["guy1_convo_exit_right"] = % titan_stealth_street_enemy01_convo_exit_right;
  level.var_EC85["generic"]["guy2_convo_idle"][0] = % titan_stealth_street_enemy02_convo_idle;
  level.var_EC85["generic"]["guy2_convo_react_left"] = % titan_stealth_street_enemy02_convo_react_left;
  level.var_EC85["generic"]["guy2_convo_react_front"] = % titan_stealth_street_enemy02_convo_react_front;
  level.var_EC85["generic"]["guy2_convo_react_back"] = % titan_stealth_street_enemy02_convo_react_back;
  level.var_EC85["generic"]["guy2_convo_react_right"] = % titan_stealth_street_enemy02_convo_react_right;
  level.var_EC85["generic"]["guy2_convo_death"] = % titan_stealth_street_enemy02_convo_death;
  level.var_EC85["generic"]["guy2_convo_exit_front"] = % titan_stealth_street_enemy02_convo_exit_front;
  level.var_EC85["generic"]["guy2_convo_exit_back"] = % titan_stealth_street_enemy02_convo_exit_back;
  level.var_EC85["generic"]["guy2_convo_exit_left"] = % titan_stealth_street_enemy02_convo_exit_left;
  level.var_EC85["generic"]["guy2_convo_exit_right"] = % titan_stealth_street_enemy02_convo_exit_right;
}

func_8728(param_00) {
  var_01["left"] = "guy1_convo_react_left";
  var_01["right"] = "guy1_convo_react_right";
  var_01["forward"] = "guy1_convo_react_front";
  var_01["back"] = "guy1_convo_react_back";
  var_01["default"] = "guy1_convo_react_front";
  var_02["left"] = "guy1_convo_exit_left";
  var_02["right"] = "guy1_convo_exit_right";
  var_02["forward"] = "guy1_convo_exit_front";
  var_02["back"] = "guy1_convo_exit_back";
  var_02["default"] = "guy1_convo_exit_front";
  param_00 lib_0F27::func_92CF(self, "guy1_convo_idle", var_01, "guy1_convo_death");
  lib_0F27::func_F320(var_02);
}

func_8729(param_00) {
  var_01["left"] = "guy2_convo_react_left";
  var_01["right"] = "guy2_convo_react_right";
  var_01["forward"] = "guy2_convo_react_front";
  var_01["back"] = "guy2_convo_react_back";
  var_01["default"] = "guy2_convo_react_front";
  var_02["left"] = "guy2_convo_exit_left";
  var_02["right"] = "guy2_convo_exit_right";
  var_02["forward"] = "guy2_convo_exit_front";
  var_02["back"] = "guy2_convo_exit_back";
  var_02["default"] = "guy2_convo_exit_front";
  param_00 lib_0F27::func_92CF(self, "guy2_convo_idle", var_01, "guy2_convo_death");
  lib_0F27::func_F320(var_02);
}