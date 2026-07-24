/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3870.gsc
**************************************/

#using_animtree("generic_human");

main() {
  level._id_92DE["guy1_convo"] = ::_id_8728;
  level._id_92DE["guy2_convo"] = ::_id_8729;
  level._id_EC85["generic"]["guy1_convo_idle"][0] = % titan_stealth_street_enemy01_convo_idle;
  level._id_EC85["generic"]["guy1_convo_react_left"] = % titan_stealth_street_enemy01_convo_react_left;
  level._id_EC85["generic"]["guy1_convo_react_front"] = % titan_stealth_street_enemy01_convo_react_front;
  level._id_EC85["generic"]["guy1_convo_react_back"] = % titan_stealth_street_enemy01_convo_react_back;
  level._id_EC85["generic"]["guy1_convo_react_right"] = % titan_stealth_street_enemy01_convo_react_right;
  level._id_EC85["generic"]["guy1_convo_death"] = % titan_stealth_street_enemy01_convo_death;
  level._id_EC85["generic"]["guy1_convo_exit_front"] = % titan_stealth_street_enemy01_convo_exit_front;
  level._id_EC85["generic"]["guy1_convo_exit_back"] = % titan_stealth_street_enemy01_convo_exit_back;
  level._id_EC85["generic"]["guy1_convo_exit_left"] = % titan_stealth_street_enemy01_convo_exit_left;
  level._id_EC85["generic"]["guy1_convo_exit_right"] = % titan_stealth_street_enemy01_convo_exit_right;
  level._id_EC85["generic"]["guy2_convo_idle"][0] = % titan_stealth_street_enemy02_convo_idle;
  level._id_EC85["generic"]["guy2_convo_react_left"] = % titan_stealth_street_enemy02_convo_react_left;
  level._id_EC85["generic"]["guy2_convo_react_front"] = % titan_stealth_street_enemy02_convo_react_front;
  level._id_EC85["generic"]["guy2_convo_react_back"] = % titan_stealth_street_enemy02_convo_react_back;
  level._id_EC85["generic"]["guy2_convo_react_right"] = % titan_stealth_street_enemy02_convo_react_right;
  level._id_EC85["generic"]["guy2_convo_death"] = % titan_stealth_street_enemy02_convo_death;
  level._id_EC85["generic"]["guy2_convo_exit_front"] = % titan_stealth_street_enemy02_convo_exit_front;
  level._id_EC85["generic"]["guy2_convo_exit_back"] = % titan_stealth_street_enemy02_convo_exit_back;
  level._id_EC85["generic"]["guy2_convo_exit_left"] = % titan_stealth_street_enemy02_convo_exit_left;
  level._id_EC85["generic"]["guy2_convo_exit_right"] = % titan_stealth_street_enemy02_convo_exit_right;
}

_id_8728(var_0) {
  var_1["left"] = "guy1_convo_react_left";
  var_1["right"] = "guy1_convo_react_right";
  var_1["forward"] = "guy1_convo_react_front";
  var_1["back"] = "guy1_convo_react_back";
  var_1["default"] = "guy1_convo_react_front";
  var_2["left"] = "guy1_convo_exit_left";
  var_2["right"] = "guy1_convo_exit_right";
  var_2["forward"] = "guy1_convo_exit_front";
  var_2["back"] = "guy1_convo_exit_back";
  var_2["default"] = "guy1_convo_exit_front";
  var_0 _id_0F27::_id_92CF(self, "guy1_convo_idle", var_1, "guy1_convo_death");
  _id_0F27::_id_F320(var_2);
}

_id_8729(var_0) {
  var_1["left"] = "guy2_convo_react_left";
  var_1["right"] = "guy2_convo_react_right";
  var_1["forward"] = "guy2_convo_react_front";
  var_1["back"] = "guy2_convo_react_back";
  var_1["default"] = "guy2_convo_react_front";
  var_2["left"] = "guy2_convo_exit_left";
  var_2["right"] = "guy2_convo_exit_right";
  var_2["forward"] = "guy2_convo_exit_front";
  var_2["back"] = "guy2_convo_exit_back";
  var_2["default"] = "guy2_convo_exit_front";
  var_0 _id_0F27::_id_92CF(self, "guy2_convo_idle", var_1, "guy2_convo_death");
  _id_0F27::_id_F320(var_2);
}