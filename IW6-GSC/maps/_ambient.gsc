/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ambient.gsc
*****************************************************/

use_eq_settings(var_0, var_1) {
  if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  maps\_audio::set_filter(var_0, var_1);
}

deactivate_index(var_0) {
  level.eq_track[var_0] = "";
  level.player deactivateeq(var_0);
}

blend_to_eq_track(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = 0.05;
  var_4 = var_2 / var_3;
  var_5 = 1 / var_4;

  for(var_6 = 0; var_6 <= 1; var_6 = var_6 + var_5) {
    level.player seteqlerp(var_6, var_0);
    wait(var_3);
  }

  level.player seteqlerp(1, var_0);
}