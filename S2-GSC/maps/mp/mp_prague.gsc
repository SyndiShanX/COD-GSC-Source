/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_prague.gsc
*********************************************/

func_00F9() {
  level.add_bcs_location_mappings_callback = ::add_bcs_location_mappings_callback;
  maps\mp\mp_prague_precache::func_F9();
  maps\createart\mp_prague_art::func_F9();
  maps\mp\mp_prague_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_prague_lighting::func_F9();
  maps\mp\mp_prague_aud::func_F9();
  maps\mp\_water::func_D5();
  maps\mp\_compass::func_8A2F("compass_map_mp_prague");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_prague_osp";
  level.var_6C5E = "mp_prague_osp";
  level.var_3445 = "mp_prague_drone";
  level.var_343A = "mp_prague_drone";
  level.var_A853 = "mp_prague_warbird";
  level.var_A852 = "mp_prague_warbird";
  level.var_5A7C = "mp_prague_killstreak";
  level.var_5A6B = "mp_prague_killstreak";
  level.var_47CD = "mp_prague_glide1";
  level.var_47CE = "mp_prague_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  level.var_7C62 = 6500;
  setperformancedvars();
  level thread rotatewaterwheel();
}

rotatewaterwheel() {
  level endon("game_ended");
  var_00 = 1800;
  var_01 = getent("water_wheel", "targetname");
  for(;;) {
    var_01 rotatevelocity((-2, 0, 0), var_00);
    wait(var_00);
  }
}

setperformancedvars() {
  setDvar("293", "800");
  setDvar("5298", "300");
}

add_bcs_location_mappings_callback() {
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_columns", "mp_prag_columns");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_sandbags", "mp_prag_sandbags");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_stairwell", "mp_prag_stairwell");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_upstairs_window", "mp_prag_upstairs_window");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_window", "mp_prag_window");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_archway", "mp_prag_archway");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_street", "mp_prag_street");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_tree", "mp_prag_tree");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_road", "mp_prag_road");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_balcony", "mp_prag_balcony");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_stairs", "mp_prag_stairs");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_ambulance", "mp_prag_ambulance");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_statue", "mp_prag_statue");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_headquarters", "mp_prag_headquarters");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_loading_dock", "mp_prag_loading_dock");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_truck", "mp_prag_truck");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_prag_vehicles", "mp_prag_vehicles");
}