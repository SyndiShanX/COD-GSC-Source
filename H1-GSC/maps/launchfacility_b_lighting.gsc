/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_b_lighting.gsc
**********************************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread setup_spinning_ents();
  thread setup_emissive_pulsing();
  level.default_clut = "clut_launchfacility_b";
  level.default_lightset = "launchfacility_b";
  level.default_visionset = "launchfacility_b";
  level.nightvisionlightset = "launchfacility_b_nightvision";
  visionsetnight("launchfacility_b_nightvision");
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("launchfacility_b", 0);
  level.player maps\_utility::set_light_set_player("launchfacility_b");
  level.player setclutforplayer("clut_launchfacility_b", 0.0);
}

setup_spinning_ents() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_1 = getentarray("spinning", "targetname");

  foreach(var_3 in var_1) {
    var_4 = getent(var_3.script_linkto, "script_linkname");
    wait 1.0;

    if(isdefined(var_4)) {
      var_3 linkto(var_0);
      var_3 thread maps\_utility::yaw_ent_by_linked(1.0);
      var_4 thread maps\_utility::rotate_ent_with_ent(var_3);
    }
  }
}

setup_emissive_pulsing() {
  var_0 = getentarray("emissive_pulsing", "targetname");
  common_scripts\utility::array_thread(var_0, ::emissive_pulsing);
}

emissive_pulsing() {
  var_0 = 0.5;
  var_1 = 0.2;
  var_2 = 0.5;
  var_3 = 1.0;

  if(isdefined(self.script_noteworthy)) {
    var_4 = strtok(self.script_noteworthy, " ");

    if(isdefined(var_4[0]))
      var_2 = float(var_4[0]);

    if(isdefined(var_4[1]))
      var_3 = float(var_4[1]);
  }

  var_5 = 0.05;
  var_6 = var_3;
  var_7 = 0.0 - (var_3 - var_2) / (var_0 / var_5);
  var_8 = (var_3 - var_2) / (var_1 / var_5);

  for (;;) {
    var_6 = emissive_ramp(var_0, var_6, var_7, var_2, var_3);
    wait 1;
    var_6 = emissive_ramp(var_1, var_6, var_8, var_2, var_3);
    wait 0.5;
  }
}

emissive_ramp(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 0.05;

  while (var_5 < var_0) {
    var_1 = var_1 + var_2;
    var_1 = clamp(var_1, var_3, var_4);
    self setmaterialscriptparam(var_1, 0.0);
    var_5 = var_5 + var_6;
    wait(var_6);
  }

  return var_1;
}