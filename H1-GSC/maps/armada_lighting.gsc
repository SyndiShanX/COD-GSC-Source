/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\armada_lighting.gsc
********************************/

main() {
  thread setup_dof_presets();
  thread tv_station_visionset();
  level.cheat_invert_override = "_bright";
  apply_lighting_pass_armada("armada_ride", 0.0);
  play_flickering_light();
  setup_lighting_triggers();
  thread play_flickering_light();
  var_0 = getent("lightshadow", "targetname");
  var_0 setlightshadowstate("force_off");
  var_0 office_light_force_on();
  setsaveddvar("fx_cast_shadow", 0);
}

init_level_lighting_flags() {}

setup_dof_presets() {}

setup_lighting_triggers() {
  var_0 = getentarray("script_lightset_change", "targetname");
  common_scripts\utility::array_thread(var_0, ::lighting_trigger_think);
}

lighting_trigger_think() {
  if(!isdefined(self.script_noteworthy)) {
    return;
  }
  for (;;) {
    self waittill("trigger");

    if(self.script_noteworthy != level.current_light_set)
      apply_lighting_pass_armada(self.script_noteworthy);
  }
}

apply_lighting_pass_armada(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "armada_exterior":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada", var_1);
      maps\_utility::vision_set_fog_changes("armada", var_1);
      level.player maps\_utility::set_light_set_player("armada");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_ride":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_ride", var_1);
      maps\_utility::vision_set_fog_changes("armada_ride", var_1);
      level.player maps\_utility::set_light_set_player("armada_ride");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_interior_HQ":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_hq", var_1);
      maps\_utility::vision_set_fog_changes("armada_hq", var_1);
      level.player maps\_utility::set_light_set_player("armada_interior_HQ");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_interior_TVStation":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada_tvs", var_1);
      level.player maps\_utility::set_light_set_player("armada_interior_TVStation");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_Hall":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada_tvs", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_Hall");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_Kitchen":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada_tvs", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_Kitchen");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_Roof01":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_Roof01");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_Stairwell":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada_tvs", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_Stairwell");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_Roof02":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada", var_1);
      maps\_utility::vision_set_fog_changes("armada", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_Roof02");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    case "armada_TVStation_End":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada_tvs", var_1);
      maps\_utility::vision_set_fog_changes("armada_tvs", var_1);
      level.player maps\_utility::set_light_set_player("armada_TVStation_End");
      level.player setclutforplayer("clut_armada", var_1);
      break;
    default:
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("armada", var_1);
      maps\_utility::vision_set_fog_changes("armada", var_1);
      level.player maps\_utility::set_light_set_player("armada");
      level.player setclutforplayer("clut_armada", var_1);
      break;
  }

  level.current_light_set = var_0;
}

turn_off_primary_lights() {
  wait 1;
  var_0 = getentarray("tv_primary_light", "targetname");
  var_1 = getentarray("hq_primary_light", "targetname");

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] setlightintensity(0);

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] setlightintensity(0);
}

tv_station_visionset() {
  common_scripts\utility::flag_wait("tvstation_entered");
  maps\_utility::set_vision_set("armada_tvs", 3);
}

play_flickering_light() {
  var_0 = 200;
  var_1 = 6000;
  var_2["on"] = "emt_light_flicker_on";
  var_2["off"] = "emt_light_flicker_off";
  var_2["loop"] = "emt_light_flicker_lp";
  var_2["vol_env"] = [[var_0, 0.2],
    [var_1, 1.0]
  ];
  thread maps\_lighting::model_flicker_preset("flicker_1", 0, var_0, var_1, undefined, undefined, 0.5, 1, 0.005, 0.05, undefined, var_2, 100);
  thread maps\_lighting::model_flicker_preset("flicker_2", 0, var_0, var_1, undefined, undefined, 0.01, 5, 0.005, 0.05, undefined, var_2, 100);
}

office_light_force_on() {
  var_0 = getentarray("office_light_trigger_on", "targetname");
  var_1 = getentarray("office_light_trigger_off", "targetname");
  common_scripts\utility::array_thread(var_0, ::office_light_trigger, self, "force_on");
  common_scripts\utility::array_thread(var_1, ::office_light_trigger, self, "force_off");
}

office_light_trigger(var_0, var_1) {
  for (;;) {
    self waittill("trigger");
    var_0 setlightshadowstate(var_1);
  }
}