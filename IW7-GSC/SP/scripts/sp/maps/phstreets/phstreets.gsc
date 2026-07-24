/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phstreets\phstreets.gsc
***************************************************/

main() {
  scripts\sp\utility::_id_116CB("phstreets");
  setdvarifuninitialized("dont_load_nextmission", 0);
  setdvarifuninitialized("e3", 0);
  setdvarifuninitialized("e3_swap", 0);
  setdvarifuninitialized("exec_review", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.45);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 6);
  setsaveddvar("r_offloadPrimaryLights", 2);
  setsaveddvar("glass_damageToWeaken", 25);
  setsaveddvar("glass_damageToDestroy", 100);
  setsaveddvar("r_reactiveMotionHelicopterLimit", 0);
  setsaveddvar("r_reactiveMotionPlayerHeightAdjust", -45);
  level._id_BFF4 = 1;
  level._id_55FE = 1;
  scripts\sp\maps\phstreets\gen\phstreets_art::main();
  scripts\sp\maps\phstreets\phstreets_fx::main();
  scripts\sp\maps\phstreets\phstreets_precache::main();
  scripts\sp\maps\phstreets\phstreets_anim::main();
  var_0 = ["Crash Wakeup", "Crash Combat", "Bar", "Grenades", "Street Civs", "Civs Execution", "Cap Crash Lake", "Square Combat", "Cap Crash Dust", "C6 Intro", "Drop Pods", "Robot Alley", "Cafe"];
  scripts\sp\starts::_id_48E1("Crash Wakeup", "SDF has invaded the city of Geneva. Reyes and his squad have crash landed and must get to the Aatis tower to stop the attack.");
  scripts\sp\starts::_id_48E4(var_0);

  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    _id_894E();
  }

  var_1 = ["geneva_periph_lake_tr", "phstreets_mall_tr"];
  var_2 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_mall_tr", "phstreets_streets_tr"];
  var_3 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_streets_tr"];
  var_4 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_streets_tr", "phstreets_robots_tr"];
  var_5 = ["geneva_periph_lake_tr", "phstreets_streets_tr", "phstreets_robots_tr"];
  var_6 = ["phstreets_streets_tr", "phstreets_robots_tr"];
  var_7 = ["phstreets_robots_tr"];
  var_8 = ["phstreets_robots_tr", "phstreets_tower_ex_tr"];
  var_9 = ["phstreets_robots_tr", "phstreets_hill_tr", "phstreets_tower_ex_tr"];
  var_10 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_robots_tr", "phstreets_hill_tr", "phstreets_tower_ex_tr"];
  var_11 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_hill_tr", "phstreets_tower_ex_tr", "phstreets_fountain_tr"];
  var_12 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_hill_tr", "phstreets_tower_ex_tr", "phstreets_fountain_tr", "phstreets_tower_tr", "phstreets_hvt_tr"];
  var_13 = ["phstreets_fountain_tr", "phstreets_tower_tr", "phstreets_hvt_tr"];
  var_14 = ["phstreets_hvt_tr"];
  scripts\sp\utility::_id_F343("Crash Wakeup");
  scripts\sp\utility::_id_1749("Crash Wakeup", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_481B, "", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_480E, var_1, scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_47F7);
  scripts\sp\utility::_id_1749("Crash Combat", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_4802, "", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_4800, var_1, scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_47FC);
  scripts\sp\utility::_id_1749("Bar", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_281D, "", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_2819, var_2, scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_2813);
  scripts\sp\utility::_id_1749("Grenades", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_85D9, "", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_85D8, var_2, scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_85D6);
  scripts\sp\utility::_id_1749("Street Civs", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FEB, "", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FEA, var_3, scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FE5);
  scripts\sp\utility::_id_1749("Civs Execution", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FE9, "", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FE8, var_3, scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FE7);
  scripts\sp\utility::_id_1749("Cap Crash Lake", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3954, "", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3953, var_3, scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3951);
  scripts\sp\utility::_id_1749("Square Combat", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_10B15, "", scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_10B0D, var_4, scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_10B00);
  scripts\sp\utility::_id_1749("Cap Crash Dust", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_3950, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_394F, var_6, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_394C);
  scripts\sp\utility::_id_1749("C6 Intro", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_337D, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_337B, var_7, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_3378);
  scripts\sp\utility::_id_1749("Drop Pods", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_5D50, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_5D4E, var_7, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_5D4A);
  scripts\sp\utility::_id_1749("Robot Alley", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_E576, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_E573, var_7, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_E569);
  scripts\sp\utility::_id_1749("Cafe", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36C7, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36C4, var_8, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36C8);
  scripts\sp\utility::_id_1749("Cafe Hacking", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36C2, "", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36C1, var_8, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_36BF);
  scripts\sp\utility::_id_1749("Hill Street", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FCE, "", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FCD, var_9, scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FC8);
  scripts\sp\utility::_id_1749("Hill Basement", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F18, "", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F15, var_10, scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F0B);
  scripts\sp\utility::_id_1749("Hill Trench", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FDA, "", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FD7, var_11, scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FD5);
  scripts\sp\utility::_id_1749("Hill Run", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FBE, "", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FBA, var_11, scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8FA7);
  scripts\sp\utility::_id_1749("Hill Combat", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F4F, "", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F49, var_11, scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F41);
  scripts\sp\utility::_id_1749("Tower Entrance", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_11A66, "", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_11A65, var_12, scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_11A63);
  scripts\sp\utility::_id_1749("HVT Intro", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_9235, "", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_9234, var_12, scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_9232);
  scripts\sp\utility::_id_1749("HVT Breach", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_921B, "", scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_921A, var_13, scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_9218);
  scripts\sp\utility::_id_1263F("phstreets_mall_tr");
  scripts\sp\utility::_id_1263F("phstreets_streets_tr");
  scripts\sp\utility::_id_1263F("phstreets_robots_tr");
  scripts\sp\utility::_id_1263F("phstreets_hill_tr");
  scripts\sp\utility::_id_1263F("phstreets_fountain_tr");
  scripts\sp\utility::_id_1263F("phstreets_tower_ex_tr");
  scripts\sp\utility::_id_1263F("phstreets_tower_tr");
  scripts\sp\utility::_id_1263F("phstreets_hvt_tr");
  scripts\sp\utility::_id_1263F("geneva_periph_lake_tr");
  scripts\sp\utility::_id_1263F("geneva_periph_south_tr");
  setdvarifuninitialized("camera_fx_enabled", 1);

  if(getdvarint("camera_fx_enabled")) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_37A9();
  }

  scripts\sp\load::main();
  _id_CAE7();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_65D6();
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), scripts\sp\utility::_id_8E7E);
  scripts\engine\utility::array_thread(getEntArray("animated_models", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1F8A);
  scripts\engine\utility::array_thread(getEntArray("off_on_load", "script_noteworthy"), scripts\engine\utility::trigger_off);
  scripts\engine\utility::array_thread(getEntArray("player_shadow_off", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_D290);
  scripts\engine\utility::array_thread(getEntArray("ally_advance_trigger", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1CC5);
  scripts\engine\utility::array_thread(getEntArray("threat_bias_trigger", "targetname"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_117BC);
  scripts\engine\utility::array_thread(getEntArray("player_in_ocean", "targetname"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_D20D);
  scripts\engine\utility::array_thread(getEntArray("traversal_glass_trig", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_126C4);
  scripts\engine\utility::array_thread(getEntArray("player_disable_stance", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_D024);
  scripts\engine\utility::array_thread(getEntArray("minobjectcontribution_trigger", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B7C2);
  thread _id_CAE8();
  thread scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_3FCB();
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  scripts\sp\maps\phstreets\phstreets_lights::main();
}

_id_CAE7() {
  level._id_11937 = 0.05;
  thread scripts\sp\utility::_id_241F(1);
  precachemodel("body_hero_protagonist_vm_legs_naval");
  _id_0B0F::_id_9543();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13D54();
  _id_0E40::_id_F9B6();
  scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_C9DD();
  scripts\sp\maps\pearlharbor\pearlharbor_streets::_id_C9E3();
  scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_C9E2();
  scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_C9DF();
  scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_C9E4();
  scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_C9E0();
  thread _id_0B9C::_id_13BFD();
}

_id_CAE8() {
  createthreatbiasgroup("snipers");
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  setthreatbias("player", "snipers", 2000);
  thread _id_ABE0();
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  level._id_10281["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph";
  level._id_10281["allies"] = "veh_mil_air_un_jackal_drone_atmos_periph";
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_48BF();
  wait 0.1;

  if(scripts\engine\utility::flag("crash_wakeup_complete")) {
    var_0 = 0;

    if(scripts\engine\utility::flag("grenade_give_scene_done")) {
      var_0 = 1;
    }

    var_1 = 0;

    if(scripts\engine\utility::flag("player_got_hackdevice")) {
      var_1 = 1;
    }

    level.player thread scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_82C2(var_0, var_1);
  }

  thread _id_1264B();

  if(getdvarint("camera_fx_enabled")) {
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_CCBE();
  }
}

_id_ABE0() {
  scripts\engine\utility::flag_wait("crash_wakeup_complete");
  scripts\sp\utility::_id_C264("OBJECTIVE_TOWER");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_TOWER"), &"PHSTREETS_OBJECTIVE_TOWER");
  scripts\sp\utility::_id_C264("OBJECTIVE_TOWER");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_HILL"), &"PHSTREETS_OBJECTIVE_HILL");
  scripts\sp\utility::_id_C264("OBJECTIVE_HILL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_BREACH"), &"PHSTREETS_OBJECTIVE_BREACH");
  scripts\sp\utility::_id_C264("OBJECTIVE_BREACH");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_TOWER"), "current");
  scripts\engine\utility::flag_wait("player_at_hill_trench");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_TOWER"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_HILL"), "current");
  scripts\engine\utility::flag_wait("fountain_vo_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_HILL"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_BREACH"), "current");
  scripts\engine\utility::flag_wait("tower_objective_complete");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_BREACH"));
}

_id_1264B() {
  for(;;) {
    level waittill("new_transient_loaded");
    setsaveddvar("r_usePrebuiltSunShadow", 2);
    wait 0.1;
    setsaveddvar("r_usePrebuiltSunShadow", 1);
    wait 2.0;
  }
}

_id_F51C(var_0, var_1) {
  setaudiotriggerstate("dustystreetcrash", var_0, var_1);
  setaudiotriggerstate("battle_state", var_0, var_1);
}

_id_894E() {
  scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_8E73();
}