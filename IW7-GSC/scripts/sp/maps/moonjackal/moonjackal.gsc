/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moonjackal\moonjackal.gsc
*****************************************************/

main() {
  setsaveddvar("sm_sunSampleSizeNear", 8.0, 2.0);
  setsaveddvar("r_heightFieldSunShadowFade", 16000.0, 2.0);
  setsaveddvar("r_volumetricsScatterTemporalFactor", 0.5);
  scripts\sp\utility::_id_116CB("moonjackal");
  scripts\sp\maps\moonjackal\gen\moonjackal_art::main();
  scripts\sp\maps\moonjackal\moonjackal_fx::main();
  scripts\sp\maps\moonjackal\moonjackale_precache::main();
  scripts\sp\maps\moonjackal\moonjackal_anim::main();
  var_0 = ["moonjackal_hangar_tr"];
  var_1 = ["moonjackal_hangar_tr", "moonjackal_arena_tr", "moonjackal_ships_tr"];
  var_2 = ["moonjackal_arena_tr", "moonjackal_ships_tr"];
  var_3 = ["moonjackal_arena_tr", "moonjackal_ships_tr", "moonjackal_end_tr"];
  scripts\sp\utility::_id_F343("launch");
  scripts\sp\utility::_id_1749("Climb Capture", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_AA9A, "Climb Capture", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_AA65, var_1);
  scripts\sp\utility::_id_1749("Launch", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_AA9A, "Launch", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_AA86, var_1);
  scripts\sp\utility::_id_1749("Dogfight", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_58A1, "Dogfight", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_5897, var_2);
  scripts\sp\utility::_id_1749("Dogfight lockon", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_5895, "Dogfight lock", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_5892, var_2);
  scripts\sp\utility::_id_1749("Missileboat Attack", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_B873, "Missileboat Attack", scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_B860, var_3);
  scripts\sp\utility::_id_1749("Transition", scripts\sp\maps\moonjackal\moonjackal_transition::_id_1266D, "Transition", scripts\sp\maps\moonjackal\moonjackal_transition::_id_12664, var_3);
  scripts\sp\utility::_id_1749("Transition Auto", scripts\sp\maps\moonjackal\moonjackal_transition::_id_12659, "Transition Auto", scripts\sp\maps\moonjackal\moonjackal_transition::_id_12664, var_3);
  scripts\sp\utility::_id_1749("Transition Bink", scripts\sp\maps\moonjackal\moonjackal_transition::_id_1265B, "Transition Bink", scripts\sp\maps\moonjackal\moonjackal_transition::_id_12664, var_3);
  scripts\sp\utility::_id_1749("test death", scripts\sp\maps\moonjackal\moonjackal_transition::_id_11721, "test_death", scripts\sp\maps\moonjackal\moonjackal_transition::_id_12664, var_3);
  scripts\sp\utility::_id_1263F("moonjackal_hangar_tr");
  scripts\sp\utility::_id_1263F("moonjackal_arena_tr");
  scripts\sp\utility::_id_1263F("moonjackal_ships_tr");
  scripts\sp\utility::_id_1263F("moonjackal_end_tr");
  scripts\sp\load::main();
  _id_0E4B::_id_8E06();
  enableforcedsunshadows();
  _id_BB4D();
  _id_BB4B();
  _id_BB4E();
}

_id_BB4D() {
  scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_589C();
  precachestring(&"MOONJACKAL_OBJ_SKELTERS");
  precachestring(&"JACKAL_OBJECTIVE_MISSILE_BOATS_MENU");
  precachestring(&"MOONJACKAL_OBJ_TIGRIS");
}

_id_BB4B() {
  scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_5881();
  scripts\sp\maps\moonjackal\moonjackal_transition::_id_1265F();
  scripts\sp\utility::_id_16EB("start_transition", &"MOONJACKAL_START_TRANSITION", ::_id_900C);
  scripts\sp\utility::_id_16EB("move_clear", &"MOONJACKAL_MOVE_CLEAR", ::_id_9006);
}

_id_900C() {
  if(scripts\engine\utility::flag("started_transition") || !scripts\engine\utility::flag("launch_area_clear")) {
    return 1;
  }

  return 0;
}

_id_9006() {
  if(scripts\engine\utility::flag("started_transition") || scripts\engine\utility::flag("launch_area_clear")) {
    return 1;
  }

  return 0;
}

_id_BB4E() {
  enableforcedsunshadows();
  level._id_4C22 = 10;
  level._id_12FB7 = 1;
  thread _id_B8F3();
  thread _id_B8C5();
  setsaveddvar("sm_suncascadeSizeMultiplier1", 1);
  setsaveddvar("sm_sunSampleSizeNear", 1.03);
  _id_0BDC::_id_10CD8();
  _id_0E4B::_id_8DEA();
}

_id_B8F3() {
  level._id_111D0 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare_moonjackal"), level._id_111D0, "tag_origin");
  level._id_111D0._id_1120D = getmapsunangles();
  level._id_111D0.suncolor = getmapsuncolorandintensity();
  level._id_111D0._id_99E5 = level._id_111D0.suncolor[3];
  level._id_111D0.suncolor = (level._id_111D0.suncolor[0], level._id_111D0.suncolor[1], level._id_111D0.suncolor[2]);
  level._id_111D0._id_75AC = (0, 0, 0);
  level._id_111D0.hangar_intensity = 24;
  level._id_111D0.final_intensity = 19;
  level._id_111D0.hangar_sunangles = (-13, 70, 0);
  level._id_111D0.final_sunangles = (-18, 70, 0);
  level._id_111D0.hangar_sunoffset = (3, 0, 0);
  level._id_111D0.final_sunoffset = (0, 0, 0);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_3C44(level._id_111D0.final_sunangles, 0);
  scripts\engine\utility::flag_init("flag_pause_sun_fx_updates");

  for(;;) {
    if(scripts\engine\utility::flag("flag_pause_sun_fx_updates")) {
      wait 0.05;
      continue;
    }

    if(isDefined(level._id_D127) && level._id_D127 _id_0BDC::_id_A2A7()) {
      var_0 = level._id_D127.origin;
    } else {
      var_0 = level.player.origin;
    }

    var_1 = (200000, 0, 0);
    var_1 = rotatevector(var_1, level._id_111D0._id_1120D + level._id_111D0._id_75AC);
    level._id_111D0.origin = var_0 + var_1;
    wait 0.05;
  }
}

_id_B8C5() {
  scripts\sp\utility::_id_C264("OBJ_SKELTERS");
  scripts\sp\utility::_id_C264("OBJ_MISSILEBOAT");
  scripts\sp\utility::_id_C264("OBJ_TIGRIS");
  waittillframeend;
  var_0 = 0;

  if(level._id_10CDA != "default") {
    var_0 = 1;
  }

  switch (level._id_10CDA) {
    case "default":
    case "launch":
      scripts\engine\utility::flag_wait("takeoff_runway_blocker");
    case "dogfight lockon":
    case "dogfight":
      objective_add(scripts\sp\utility::_id_C264("OBJ_SKELTERS"), "active", &"MOONJACKAL_OBJ_SKELTERS");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SKELTERS"), "current");
      scripts\engine\utility::flag_wait("dogfight_done");
      scripts\engine\utility::flag_wait("missileboats_arrived");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SKELTERS"), "done");
    case "missileboat attack":
      objective_add(scripts\sp\utility::_id_C264("OBJ_MISSILEBOAT"), "active", &"JACKAL_OBJECTIVE_MISSILE_BOATS_MENU");
      objective_state(scripts\sp\utility::_id_C264("OBJ_MISSILEBOAT"), "current");
      scripts\engine\utility::flag_wait("missileboat_done");
      objective_state(scripts\sp\utility::_id_C264("OBJ_MISSILEBOAT"), "done");
    case "transition":
      objective_add(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), "active", &"MOONJACKAL_OBJ_TIGRIS");
      objective_state(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), "current");
    default:
  }
}