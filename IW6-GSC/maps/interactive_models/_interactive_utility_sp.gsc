/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\_interactive_utility_sp.gsc
***************************************************************/

drawcircleuntilnotify(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::issp()) {
    var_5 = 16;

    for(var_6 = 0; var_6 < 360; var_6 = var_6 + 360 / var_5) {
      var_7 = var_6 + 360 / var_5;
      thread maps\_utility::draw_line_until_notify(var_0 + (var_1 * cos(var_6), var_1 * sin(var_6), 0), var_0 + (var_1 * cos(var_7), var_1 * sin(var_7), 0), var_2[0], var_2[1], var_2[2], var_3, var_4);
    }
  }
}