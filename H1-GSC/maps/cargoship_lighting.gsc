/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\cargoship_lighting.gsc
***************************************/

main() {
  precache_lighting_and_fx();
  init_level_lighting_flags();
  level.cheat_highcontrast_override = "_night";
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread generic_lights_flickering();
  setup_lighting_triggers();
  setup_lights_triggers();
  thread init_emergency_lights();
  thread explosion_lerping();
}

precache_lighting_and_fx() {
  precacheshader("overlay_hunted_red");
  precacheshader("overlay_hunted_black");
  precacheshader("credits_iw_presents");
  precacheshader("credits_cod4");
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
  if(self.script_noteworthy == "special") {
    thread special_lighting_trigger_think();
    return;
  }

  for (;;) {
    self waittill("trigger");

    if(self.script_noteworthy != level.current_light_set)
      apply_lighting_pass_cargoship(self.script_noteworthy);
  }
}

set_level_lighting_values() {
  setsaveddvar("sm_sunSampleSizeNear", ".5");
  setsaveddvar("r_specularColorScale", "3");
  setsaveddvar("sm_cacheSpotShadowsEnabled", 0);
  setsaveddvar("sm_cacheSunShadowEnabled", 0);
  setsaveddvar("r_useSunShadowPortals", 1);
  setsaveddvar("fx_cast_shadow", 0);
  apply_lighting_pass_cargoship("cargoship_intro", 0.0);
}

apply_lighting_pass_cargoship(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "cargoship_intro":
      if(!isdefined(var_1))
        var_1 = 0.0;

      maps\_utility::set_vision_set("cargoship_intro", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_intro", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_intro");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_exterior":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("cargoship_exterior", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_exterior", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_exterior");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_exterior_helitrans_vision":
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::set_vision_set("cargoship_introtransit", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_exterior");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_interior":
      if(!isdefined(var_1))
        var_1 = 3.0;

      maps\_utility::set_vision_set("cargoship_interior_upperdeck", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_interior_upperdeck", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_interior_upperdeck");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_interior_transition":
      if(!isdefined(var_1))
        var_1 = 2.0;

      maps\_utility::set_vision_set("cargoship_interior_transition", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_interior_transition", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_interior_transition");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_explosion":
      if(!isdefined(var_1))
        var_1 = 2.0;

      maps\_utility::set_vision_set("cargoship_explosion", 0.2);
      wait 0.3;
      maps\_utility::vision_set_fog_changes("cargoship_interior_cargohold_alert", var_1);
      maps\_utility::set_vision_set("cargoship_interior_cargohold_alert_igc", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_interior_cargohold_alert");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_escape":
      if(!isdefined(var_1))
        var_1 = 2.0;

      maps\_utility::set_vision_set("cargoship_interior_cargohold_alert", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_interior_cargohold_alert", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_interior_cargohold_alert");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_exterior_outro":
      if(!isdefined(var_1))
        var_1 = 2.0;

      maps\_utility::set_vision_set("cargoship_exterior_outro", var_1);
      maps\_utility::fog_set_changes("cargoship_exterior");
      level.player maps\_utility::set_light_set_player("cargoship_exterior_outro");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    case "cargoship_outro":
      if(!isdefined(var_1))
        var_1 = 2.0;

      maps\_utility::set_vision_set("cargoship_outro", var_1);
      maps\_utility::vision_set_fog_changes("cargoship_outro", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_outro");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
    default:
      if(!isdefined(var_1))
        var_1 = 1.0;

      maps\_utility::vision_set_fog_changes("cargoship_exterior", var_1);
      level.player maps\_utility::set_light_set_player("cargoship_exterior");
      level.player setclutforplayer("clut_cargoship", var_1);
      break;
  }

  level.current_light_set = var_0;
}

activate_outside_lights() {
  level.current_lights = "outside";
  activate_lights("lights_outside", 1);
  activate_lights("lights_inside", 0);
  activate_lights("lights_cabin_stern_side", 0);
  activate_lights("lights_cabin_stern_side2", 0);
}

activate_lights(var_0, var_1, var_2) {
  if(!isdefined(var_0) || !isdefined(var_1)) {
    return;
  }
  var_3 = getentarray(var_0, "targetname");
  var_4 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_6 in var_3)
  var_6 set_light_intensity(!var_1, var_2);

  foreach(var_6 in var_4)
  var_6 set_light_intensity(!var_1, var_2);
}

set_light_intensity(var_0, var_1) {
  var_2 = self;
  var_3 = getentarray(self.target, "targetname");

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isdefined(var_5.script_parameters) && var_5.script_parameters == "light") {
      var_2 = var_5;
      break;
    }
  }

  if(isdefined(var_2) && (!isdefined(var_2.tv) || var_2.tv maps\_interactive_objects::is_tv_emitting_light())) {
    if(!isdefined(var_2.old_light_intensity))
      var_2.old_light_intensity = var_2 getlightintensity();

    var_2 setlightintensity(common_scripts\utility::ter_op(var_0, 0.0, var_2.old_light_intensity));

    if(isdefined(var_1))
      var_2 setlightshadowstate(var_1);
  }
}

setup_lights_triggers() {
  activate_outside_lights();
  var_0 = getentarray("script_lights_change", "targetname");
  common_scripts\utility::array_thread(var_0, ::lights_trigger_think);
}

lights_trigger_think() {
  if(!isdefined(self.script_noteworthy)) {
    return;
  }
  for (;;) {
    self waittill("trigger");

    if(self.script_noteworthy != level.current_lights)
      apply_lights_change(self.script_noteworthy);
  }
}

apply_lights_change(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  var_1 = strtok(self.script_parameters, ":; ");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = tolower(var_3);
    var_5 = var_4 == "on";
    var_6 = var_4 == "off";

    if(var_5 || var_6) {
      var_2++;
      var_7 = strtok(var_1[var_2], ", ");

      for (var_8 = 0; var_8 < var_7.size; var_8++) {
        var_9 = var_7[var_8];
        activate_lights(var_9, var_5);
      }
    }
  }

  level.current_lights = var_0;
}

generic_lights_flickering() {
  thread maps\_lighting::model_flicker_preset("flicker_1", 0, 200, 3000, undefined, undefined, 0.005, 0.5, 0.005, 0.05, undefined, undefined, 100);
}

aftdeck_lights_flickering() {
  thread maps\_lighting::model_flicker_preset("flicker_3", 0, 150, 8000, undefined, undefined, 0.005, 0.5, 0.005, 0.05, undefined, undefined, 100);
}

cargohold_lights_flickering() {
  thread maps\_lighting::model_flicker_preset("flicker_2", 0, 200, 8000, undefined, undefined, 0.005, 0.5, 0.005, 0.6, undefined, undefined, 100);
}

sinking_ship_lights_flickering() {
  thread maps\_lighting::model_flicker_preset("flicker_4", 0, 2, 100, undefined, undefined, 0.005, 0.5, 0.005, 0.6, undefined, undefined, 100);
}

init_emergency_lights() {
  var_0 = getentarray("emergency_light", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.code_classname == "light")
      var_2 setlightintensity(0);
  }
}

activate_emergency_lights() {
  var_0 = getentarray("emergency_light", "targetname");
  var_1 = getentarray("emergency_light_rotator", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4 linkto(var_3);
    playfxontag(common_scripts\utility::getfx("emergency_light"), var_4, "tag_origin");
  }

  foreach(var_7 in var_0) {
    if(var_7.code_classname == "light")
      var_7 setlightintensity(var_7.script_index);

    var_8 = undefined;

    if(isdefined(var_7.script_linkto))
      var_8 = getent(var_7.script_linkto, "script_linkname");

    if(!isdefined(var_8))
      var_8 = var_7;

    var_7 thread emergency_light_rotation(anglestoup(var_8.angles));
  }
}

emergency_light_rotation(var_0) {
  var_1 = 18;

  for (;;) {
    var_2 = anglestoaxis(self.angles);
    var_2["forward"] = rotatepointaroundvector(var_0, var_2["forward"], var_1);
    var_2["right"] = rotatepointaroundvector(var_0, var_2["right"], var_1);
    var_2["up"] = vectorcross(var_2["forward"], var_2["right"]);
    self.angles = axistoangles(var_2["forward"], var_2["right"], var_2["up"]);
    wait 0.05;
  }
}

explosion_lerping() {
  common_scripts\utility::flag_wait("escape_explosion");
  maps\_lighting::lerp_spot_intensity("fire", 0, 250000);
  maps\_lighting::lerp_spot_intensity("fire_crate", 0, 250000);
  maps\_lighting::lerp_spot_intensity("price_fall_fill", 0, 55000);
  maps\_lighting::lerp_spot_intensity("gaz_fall_rim", 1, 20000);
  wait 8;
  maps\_lighting::lerp_spot_intensity("gaz_fall_rim", 0, 0);
  maps\_lighting::lerp_spot_intensity("gaz_rim", 0, 65000);
  wait 5;
  maps\_lighting::lerp_spot_intensity("price_fill", 0, 65000);
  maps\_lighting::lerp_spot_intensity("price_bounce", 0, 15000);
  maps\_lighting::lerp_spot_intensity("price_fall_fill", 1, 0);
  common_scripts\utility::flag_wait("escape_get_to_catwalks");
  maps\_lighting::lerp_spot_intensity("price_fill", 1, 0);
  maps\_lighting::lerp_spot_intensity("gaz_rim", 1, 0);
  maps\_lighting::lerp_spot_intensity("price_bounce", 1, 0);
}

special_lighting_trigger_think() {
  for (;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("escape_exterior_visionset"))
      var_0 = "cargoship_exterior_outro";
    else
      var_0 = "cargoship_exterior";

    if(var_0 != level.current_light_set)
      apply_lighting_pass_cargoship(var_0);
  }
}