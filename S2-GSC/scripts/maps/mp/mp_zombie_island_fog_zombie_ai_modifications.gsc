/****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_fog_zombie_ai_modifications.gsc
****************************************************************************/

init() {
  add_zombie_passive_behavior();
}

add_zombie_passive_behavior() {
  while(!isDefined(level._id_0A41) || !isDefined(level._id_0A41["zombie_exploder"]))
    waitframe();

  level._id_0A41["zombie_exploder"]["get_action_params"] = ::_id_AB91;
}

_id_AB91() {
  var_0 = _id_054D::_id_AC22();

  if(common_scripts\utility::_id_562E(self._id_392C)) {
    if(self._id_3937._id_3F22 == 1)
      var_0["script_var"] = "tick_bomb";
    else
      var_0["script_var"] = "held_bomb";
  } else
    var_0["script_var"] = "drop_bomb";

  if(common_scripts\utility::_id_3794("zombie_passive")) {
    var_0["move_style"] = "crippled";
    var_0["move_speed"] = "passive";
  } else
    var_0["move_speed"] = self._id_0108;

  return var_0;
}