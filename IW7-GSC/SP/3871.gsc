/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3871.gsc
**************************************/

#using_animtree("generic_human");

main() {
  level._id_92DE["desk_lean"] = ::_id_5281;
  level._id_92DE["wall_lean"] = ::_id_138A7;
  level._id_EC85["generic"]["lean_intro"] = % titan_stealth_street_enemy01_lean_intro;
  level._id_EC85["generic"]["lean_idle"][0] = % titan_stealth_street_enemy01_lean_idle;
  level._id_EC85["generic"]["lean_react_left"] = % titan_stealth_street_enemy01_lean_react_left;
  level._id_EC85["generic"]["lean_react_forward"] = % titan_stealth_street_enemy01_lean_react_front;
  level._id_EC85["generic"]["lean_react_right"] = % titan_stealth_street_enemy01_lean_react_right;
  level._id_EC85["generic"]["lean_death"] = % titan_stealth_street_enemy01_lean_death;
  level._id_EC85["generic"]["lean_exit_right"] = % titan_stealth_street_enemy01_lean_exit_right;
  level._id_EC85["generic"]["lean_exit_left"] = % titan_stealth_street_enemy01_lean_exit_left;
  level._id_EC85["generic"]["lean_exit_forward"] = % titan_stealth_street_enemy01_lean_exit_front;
  level._id_EC85["generic"]["lean_exit_back"] = % titan_stealth_street_enemy01_lean_exit_back;
  level._id_EC85["generic"]["wall_lean_idle"][0] = % titan_stealth_street_enemy01_walllean_idle;
  level._id_EC85["generic"]["wall_lean_react_left"] = % titan_stealth_street_enemy01_walllean_react_left;
  level._id_EC85["generic"]["wall_lean_react_forward"] = % titan_stealth_street_enemy01_walllean_react_front;
  level._id_EC85["generic"]["wall_lean_react_right"] = % titan_stealth_street_enemy01_walllean_react_right;
  level._id_EC85["generic"]["wall_lean_death"] = % titan_stealth_street_enemy01_walllean_death;
  level._id_EC85["generic"]["wall_lean_exit_left"] = % titan_stealth_street_enemy01_walllean_exit_left;
  level._id_EC85["generic"]["wall_lean_exit_right"] = % titan_stealth_street_enemy01_walllean_exit_right;
  level._id_EC85["generic"]["wall_lean_exit_forward"] = % titan_stealth_street_enemy01_walllean_exit_front;
  level._id_EC85["generic"]["wall_lean_exit_back"] = % titan_stealth_street_enemy01_walllean_exit_back;
}

_id_5281(var_0) {
  var_1 = [];
  var_1["left"] = "lean_react_left";
  var_1["right"] = "lean_react_right";
  var_1["forward"] = "lean_react_forward";
  var_1["default"] = "lean_react_forward";
  var_2["left"] = "lean_exit_left";
  var_2["right"] = "lean_exit_right";
  var_2["forward"] = "lean_exit_forward";
  var_2["back"] = "lean_exit_back";
  var_2["default"] = "lean_exit_forward";
  self._id_1FBB = "generic";
  var_0 _id_0F27::_id_92CF(self, "lean_idle", var_1, "lean_death", undefined, 1);
  _id_0F27::_id_F320(var_2);
}

_id_138A7(var_0) {
  var_1 = [];
  var_1["left"] = "wall_lean_react_left";
  var_1["right"] = "wall_lean_react_right";
  var_1["forward"] = "wall_lean_react_forward";
  var_1["default"] = "wall_lean_react_forward";
  var_2["left"] = "wall_lean_exit_left";
  var_2["right"] = "wall_lean_exit_right";
  var_2["forward"] = "wall_lean_exit_forward";
  var_2["back"] = "wall_lean_exit_back";
  var_2["default"] = "wall_lean_exit_forward";
  self._id_1FBB = "generic";
  var_0 _id_0F27::_id_92CF(self, "wall_lean_idle", var_1, "wall_lean_death");
  _id_0F27::_id_F320(var_2);
}