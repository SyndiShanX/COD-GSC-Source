/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_scriptlights.gsc
*****************************************/

main() {
  init_lights();
}

init_lights() {
  var_0 = getEntArray("intro_cargo_light_test", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::intro_cargo_light_test);
}

intro_cargo_light_test() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("cargo_doors_opened");
  var_0 = 0;

  if(maps\_utility::is_gen4())
    var_0 = 15;
  else
    var_0 = 1.8;

  var_1 = 0.01;
  var_2 = 0.05;
  wait 1.5;

  while(var_1 < var_0) {
    var_1 = var_1 + var_2;
    self setlightintensity(var_1);
    wait 0.05;
  }
}