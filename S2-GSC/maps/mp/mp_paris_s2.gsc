/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_paris_s2.gsc
*********************************************/

func_00F9() {
  level.add_bcs_location_mappings_callback = ::add_bcs_location_mappings_callback;
  maps\mp\mp_paris_s2_precache::func_F9();
  maps\createart\mp_paris_s2_art::func_F9();
  maps\mp\mp_paris_s2_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_paris_s2_lighting::func_F9();
  maps\mp\mp_paris_s2_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_paris_s2");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_paris_s2_killstreak";
  level.var_5A6B = "mp_paris_s2_killstreak";
  level.var_47CD = "mp_paris_s2_glide1";
  level.var_47CE = "mp_paris_s2_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  precacherumble("tank_convoy_rumble_low");
  thread animate_tanks();
}

animate_tanks() {
  var_00 = getEntArray("tank_scripted_node", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.var_116);
    var_03 setModel("ger_tank_panzer_iv_base_01_mp_paris");
    var_03 method_8495("mp_paris_tank_convoy_anim_01", var_02.var_116, var_02.var_1D);
    var_03 thread rumbletankloop();
    var_03 lib_0378::func_8D74("aud_tank_drive");
    wait(randomfloatrange(6, 16));
  }
}

rumbletankloop() {
  level endon("game_ended");
  for(;;) {
    function_01BB("tank_convoy_rumble_low", self.var_116);
    earthquake(0.1, 1, self.var_116, 650);
    wait(0.5);
  }
}

add_bcs_location_mappings_callback() {
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_apartments", "mp_par_apartments");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_couch", "mp_par_couch");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_downstairs_window", "mp_par_downstairs_window");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_sedan", "mp_par_sedan");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_mp_par_window", "mp_par_window");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_archway", "mp_par_archway");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_butcher_shop", "mp_par_butcher_shop");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_crates", "mp_par_crates");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_gate", "mp_par_gate");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_street", "mp_par_street");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_tank", "mp_par_tank");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_road", "mp_par_road");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_balcony", "mp_par_balcony");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_courtyard", "mp_par_courtyard");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_stairs", "mp_par_stairs");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_alley", "mp_par_alley");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_truck", "mp_par_truck");
  common_scripts\_bcs_location_trigs::func_903("trigger_multiple_bcs_dlc_mp_par_vehicles", "mp_par_vehicles");
}