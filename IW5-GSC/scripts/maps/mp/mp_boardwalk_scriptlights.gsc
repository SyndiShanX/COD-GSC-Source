/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_boardwalk_scriptlights.gsc
*********************************************************/

main() {
  init_lights();
}

init_lights() {
  var_0 = getEntArray("bw_trash_fire_light_scripted", "targetname");
  common_scripts\utility::array_thread(var_0, ::bw_trash_fire_light_scripted);
}

bw_trash_fire_light_scripted() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.3, var_0 * 1);
    var_3 = randomfloatrange(0.05, 0.1);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}