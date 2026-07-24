/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3872.gsc
**************************************/

#using_animtree("generic_human");

main() {
  level._id_92DE["wallconvo_guy1"] = ::_id_138CC;
  level._id_92DE["wallconvo_guy2"] = ::_id_138CD;
  level._id_EC85["generic"]["guy1_wall_convo_lean_idle"][0] = % titan_stealth_street_enemy01_wallconvo_idle;
  level._id_EC85["generic"]["guy1_wall_convo_lean_react_back"] = % titan_stealth_street_enemy01_wallconvo_react_back;
  level._id_EC85["generic"]["guy1_wall_convo_lean_react_front"] = % titan_stealth_street_enemy01_wallconvo_react_front;
  level._id_EC85["generic"]["guy1_wall_convo_lean_react_right"] = % titan_stealth_street_enemy01_wallconvo_react_right;
  level._id_EC85["generic"]["guy1_wall_convo_lean_death"] = % titan_stealth_street_enemy01_wallconvo_death;
  level._id_EC85["generic"]["guy1_wall_convo_lean_exit_left"] = % titan_stealth_street_enemy01_wallconvo_exit_left;
  level._id_EC85["generic"]["guy1_wall_convo_lean_exit_right"] = % titan_stealth_street_enemy01_wallconvo_exit_right;
  level._id_EC85["generic"]["guy1_wall_convo_lean_exit_front"] = % titan_stealth_street_enemy01_wallconvo_exit_front;
  level._id_EC85["generic"]["guy1_wall_convo_lean_exit_back"] = % titan_stealth_street_enemy01_wallconvo_exit_back;
  level._id_EC85["generic"]["guy2_wall_convo_lean_idle"][0] = % titan_stealth_street_enemy02_wallconvo_idle;
  level._id_EC85["generic"]["guy2_wall_convo_lean_react_left"] = % titan_stealth_street_enemy02_wallconvo_react_left;
  level._id_EC85["generic"]["guy2_wall_convo_lean_react_front"] = % titan_stealth_street_enemy02_wallconvo_react_front;
  level._id_EC85["generic"]["guy2_wall_convo_lean_react_right"] = % titan_stealth_street_enemy02_wallconvo_react_right;
  level._id_EC85["generic"]["guy2_wall_convo_lean_death"] = % titan_stealth_street_enemy02_wallconvo_death;
  level._id_EC85["generic"]["guy2_wall_convo_lean_exit_left"] = % titan_stealth_street_enemy02_wallconvo_exit_left;
  level._id_EC85["generic"]["guy2_wall_convo_lean_exit_right"] = % titan_stealth_street_enemy02_wallconvo_exit_right;
  level._id_EC85["generic"]["guy2_wall_convo_lean_exit_front"] = % titan_stealth_street_enemy02_wallconvo_exit_front;
  level._id_EC85["generic"]["guy2_wall_convo_lean_exit_back"] = % titan_stealth_street_enemy02_wallconvo_exit_back;
}

_id_138CC(var_0) {
  var_1 = [];
  var_1["right"] = "guy1_wall_convo_lean_react_right";
  var_1["forward"] = "guy1_wall_convo_lean_react_front";
  var_1["back"] = "guy1_wall_convo_lean_react_back";
  var_1["default"] = "guy1_wall_convo_lean_react_front";
  var_2["left"] = "guy1_wall_convo_lean_exit_left";
  var_2["right"] = "guy1_wall_convo_lean_exit_right";
  var_2["forward"] = "guy1_wall_convo_lean_exit_front";
  var_2["back"] = "guy1_wall_convo_lean_exit_back";
  var_2["default"] = "guy1_wall_convo_lean_exit_front";
  var_0 _id_0F27::_id_92CF(self, "guy1_wall_convo_lean_idle", var_1, "guy1_wall_convo_lean_death", undefined, 1);
  _id_0F27::_id_F320(var_2);
}

_id_138CD(var_0) {
  var_1 = [];
  var_1["right"] = "guy2_wall_convo_lean_react_right";
  var_1["forward"] = "guy2_wall_convo_lean_react_front";
  var_1["left"] = "guy2_wall_convo_lean_react_left";
  var_1["default"] = "guy2_wall_convo_lean_react_front";
  var_2["left"] = "guy2_wall_convo_lean_exit_left";
  var_2["right"] = "guy2_wall_convo_lean_exit_right";
  var_2["forward"] = "guy2_wall_convo_lean_exit_front";
  var_2["back"] = "guy2_wall_convo_lean_exit_back";
  var_2["default"] = "guy2_wall_convo_lean_exit_front";
  var_0 thread _id_0F27::_id_92CF(self, "guy2_wall_convo_lean_idle", var_1, "guy2_wall_convo_lean_death", undefined, 1);
  _id_0F27::_id_F320(var_2);
}