/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port.gsc
***************************************************/

main() {
  enableforcedsunshadows();
  setsaveddvar("sm_sunSampleSizeNear", 0.6);
  setsaveddvar("sm_sunStageBounds", 0);
  setsaveddvar("glass_damageToWeaken", 25);
  setsaveddvar("glass_damageToDestroy", 50);
  setsaveddvar("r_tessellationOverride", 0);
  scripts\sp\utility::_id_116CB("moon_port");
  scripts\sp\maps\moon_port\gen\moon_port_art::main();
  scripts\sp\maps\moon_port\moon_port_fx::main();
  scripts\sp\maps\moon_port\moon_port_anim::main();
  scripts\sp\maps\moon_port\moon_port_precache::main();

  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    _id_DE57();
    var_0 = getEntArray("restribution_welldeck_door", "targetname");

    foreach(var_2 in var_0) {
      var_3 = spawn("script_model", var_2.origin);
      var_3.angles = var_2.angles;
      var_3 setModel(var_2.model);
    }

    var_5 = getEntArray("mn_welldeck_lights", "script_noteworthy");

    foreach(var_7 in var_5)
    var_7 setlightintensity(1);

    var_9 = getEntArray("mn_welldeck_claxons", "script_noteworthy");

    foreach(var_7 in var_9)
    var_7 setlightintensity(1);
  }

  if(getdvarint("greenlight") == 0)
    scripts\sp\utility::_id_F343("Ride Deploy");
  else
    scripts\sp\utility::_id_F343("Tutorials");

  _id_1296B();
  scripts\engine\utility::flag_init("player_indoor_p1");
  scripts\engine\utility::flag_init("player_indoor_p2");
  scripts\engine\utility::flag_init("player_indoor_p1_noblur");
  scripts\engine\utility::flag_init("player_indoor_p2_noblur");
  scripts\engine\utility::flag_init("player_outdoor_noblur");
  scripts\engine\utility::flag_init("pause_helmet_hiding");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_D219();

  if(getdvarint("r_reflectionProbeGenerate") == 0) {
    var_12 = getEntArray("bakedScreen", "targetname");

    foreach(var_14 in var_12)
    var_14 delete();
  }

  var_16 = ["moon_port_welldeck_tr", "moon_port_infil_tr"];
  var_17 = ["moon_port_welldeck_tr", "moon_port_base_in_tr", "moon_port_infil_tr", "moon_port_crash_room_tr"];
  var_18 = ["moon_port_welldeck_tr", "moon_port_base_in_tr", "moon_port_base_in_tr", "moon_port_infil_tr", "moon_port_crash_room_tr"];
  var_19 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_crash_room_tr", "moon_port_tutorials_tr", "moon_port_concourse_tr"];
  var_20 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_concourse_tr"];
  var_21 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_tutorials_tr", "moon_port_concourse_tr"];
  var_22 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_concourse_tr", "moon_port_harass_tr"];
  var_23 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_concourse_tr", "moon_port_harass_tr", "moon_port_hangar_halls_tr"];
  var_24 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_periph_tr", "moon_port_harass_tr", "moon_port_hangar_halls_tr"];
  var_25 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_harass_tr", "moon_port_hangar_halls_tr"];
  var_26 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_hangar_halls_tr"];
  var_27 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_hangar_halls_tr", "moon_port_hangar_tr"];
  var_28 = ["moon_port_base_in_tr", "moon_port_base_tr", "moon_port_hangar_halls_tr", "moon_port_hangar_tr", "moon_port_hangar_end_tr"];
  var_29 = ["moon_port_hangar_tr", "moon_port_hangar_end_tr"];
  var_30 = ["moon_port_hangar_end_tr"];
  var_31 = ["moon_port_hangar_end_tr", "moon_port_hangar_bink_tr"];
  level._id_13133 = [var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31];
  scripts\sp\utility::_id_1749("Ride Deploy", scripts\sp\maps\moon_port\moon_port_intro::_id_E4F2, "Ride Deploy", scripts\sp\maps\moon_port\moon_port_intro::_id_E4F1, var_16, scripts\sp\maps\moon_port\moon_port_intro::_id_E4EF);
  scripts\sp\utility::_id_1749("Ride Crash", scripts\sp\maps\moon_port\moon_port_intro::_id_E4EE, "Ride Crash", scripts\sp\maps\moon_port\moon_port_intro::_id_E4ED, var_18, scripts\sp\maps\moon_port\moon_port_intro::_id_E4EB);
  scripts\sp\utility::_id_1749("Tutorials", scripts\sp\maps\moon_port\moon_port_intro::_id_12ABA, "Tutorials", scripts\sp\maps\moon_port\moon_port_intro::_id_12AB9, var_19, scripts\sp\maps\moon_port\moon_port_intro::_id_12AB6);
  scripts\sp\utility::_id_1749("Concourse Start", scripts\sp\maps\moon_port\moon_port_concourse::_id_44E5, "Concourse Start", scripts\sp\maps\moon_port\moon_port_concourse::_id_44E1, var_21, scripts\sp\maps\moon_port\moon_port_concourse::_id_44D9);
  scripts\sp\utility::_id_1749("Concourse Combat", scripts\sp\maps\moon_port\moon_port_concourse::_id_44C9, "Concourse Combat", scripts\sp\maps\moon_port\moon_port_concourse::_id_44C8, var_22, scripts\sp\maps\moon_port\moon_port_concourse::_id_44C5);
  scripts\sp\utility::_id_1749("C8 Fight", scripts\sp\maps\moon_port\moon_port_concourse::_id_3459, "C8 Fight", scripts\sp\maps\moon_port\moon_port_concourse::_id_3458, var_22, scripts\sp\maps\moon_port\moon_port_concourse::_id_3457);
  scripts\sp\utility::_id_1749("Shields Intro", scripts\sp\maps\moon_port\moon_port_concourse::_id_FC88, "Shield Intro", scripts\sp\maps\moon_port\moon_port_concourse::_id_FC82, var_22, scripts\sp\maps\moon_port\moon_port_concourse::_id_FC7E);
  scripts\sp\utility::_id_1749("Shields Hallway", scripts\sp\maps\moon_port\moon_port_concourse::_id_FC7C, "Shield Hallway", scripts\sp\maps\moon_port\moon_port_concourse::_id_FC7B, var_22, scripts\sp\maps\moon_port\moon_port_concourse::_id_FC79);
  scripts\sp\utility::_id_1749("C8 Coastguard", scripts\sp\maps\moon_port\moon_port_concourse::_id_3440, "C8 Coastguard", scripts\sp\maps\moon_port\moon_port_concourse::_id_343F, var_22, scripts\sp\maps\moon_port\moon_port_concourse::_id_343C);
  scripts\sp\utility::_id_1749("Coast Guard", scripts\sp\maps\moon_port\moon_port_harass::_id_42E6, "Coast Guard", scripts\sp\maps\moon_port\moon_port_harass::_id_42E4, var_22, scripts\sp\maps\moon_port\moon_port_harass::_id_42E1);
  scripts\sp\utility::_id_1749("Walkway", scripts\sp\maps\moon_port\moon_port_harass::_id_1389A, "Walkway", scripts\sp\maps\moon_port\moon_port_harass::_id_13896, var_23, scripts\sp\maps\moon_port\moon_port_harass::_id_1388D);
  scripts\sp\utility::_id_1749("Decompression", scripts\sp\maps\moon_port\moon_port_harass::_id_4F8A, "Decompression", scripts\sp\maps\moon_port\moon_port_harass::_id_4F86, var_23, scripts\sp\maps\moon_port\moon_port_harass::_id_4F77);
  scripts\sp\utility::_id_1749("Harass", scripts\sp\maps\moon_port\moon_port_harass::_id_8B21, "Harass", scripts\sp\maps\moon_port\moon_port_harass::_id_8B0F, var_24, scripts\sp\maps\moon_port\moon_port_harass::_id_8AF4);
  scripts\sp\utility::_id_1749("Hangar Halls", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A66, "Hangar Halls", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A63, var_24, scripts\sp\maps\moon_port\moon_port_hangar::_id_8A5F);
  scripts\sp\utility::_id_1749("Loot Room", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A20, "Loot Room", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A1F, var_25, scripts\sp\maps\moon_port\moon_port_hangar::_id_8A1B);
  scripts\sp\utility::_id_1749("Hangar Combat", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A2F, "Hangar Combat", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A2D, var_28, scripts\sp\maps\moon_port\moon_port_hangar::_id_8A2A);
  scripts\sp\utility::_id_1749("Hangar End", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A4B, "Hangar End", scripts\sp\maps\moon_port\moon_port_hangar::_id_8A4A, var_28, scripts\sp\maps\moon_port\moon_port_hangar::_id_8A47);
  scripts\sp\utility::_id_1749("Launch", scripts\sp\maps\moon_port\moon_port_hangar::_id_A283, "Launch", scripts\sp\maps\moon_port\moon_port_hangar::_id_A281, var_30);
  scripts\sp\utility::_id_1749("Launch Capture", scripts\sp\maps\moon_port\moon_port_hangar::_id_A27F, "Launch", scripts\sp\maps\moon_port\moon_port_hangar::_id_A281, var_31);
  scripts\sp\utility::_id_1749("Geo NoGame", ::_id_7786, "Go NoGame", ::_id_7785, var_16);
  var_32 = ["Concourse Start", "Concourse Combat", "Shields Intro"];
  scripts\sp\starts::_id_48E4(var_32);
  scripts\sp\starts::_id_48E1("Concourse Start", "Reyes and crew just made their way into the moon port and have yet to come into contact with the enemy...");
  scripts\sp\starts::_id_48E2("Shields Intro", scripts\engine\utility::flag_wait, "player_grabbed_shield");
  scripts\sp\utility::_id_1263F("moon_port_welldeck_tr");
  scripts\sp\utility::_id_1263F("moon_port_infil_tr");
  scripts\sp\utility::_id_1263F("moon_port_crash_room_tr");
  scripts\sp\utility::_id_1263F("moon_port_tutorials_tr");
  scripts\sp\utility::_id_1263F("moon_port_concourse_tr");
  scripts\sp\utility::_id_1263F("moon_port_harass_tr");
  scripts\sp\utility::_id_1263F("moon_port_hangar_halls_tr");
  scripts\sp\utility::_id_1263F("moon_port_hangar_tr");
  scripts\sp\utility::_id_1263F("moon_port_hangar_end_tr");
  scripts\sp\utility::_id_1263F("moon_port_hangar_bink_tr");
  scripts\sp\utility::_id_1263F("moon_port_periph_tr");
  scripts\sp\utility::_id_1263F("moon_port_base_tr");
  scripts\sp\utility::_id_1263F("moon_port_base_in_tr");
  scripts\sp\load::main();
  _id_0B0F::_id_9543();
  level._id_10281["axis"] = "veh_mil_air_ca_jackal_drone_space_periph";
  level._id_10281["allies"] = "veh_mil_air_un_jackal_drone_space_periph";
  level._id_1027F = 0;
  _id_BB31();
  _id_BB2E();
  level thread _id_0A2F::_id_3D61();
  _id_BB33();
}

_id_BB31() {
  scripts\sp\maps\moon_port\moon_port_intro::_id_9ACD();
  scripts\sp\maps\moon_port\moon_port_concourse::_id_44E8();
  scripts\sp\maps\moon_port\moon_port_fob::_id_71FB();
  scripts\sp\maps\moon_port\moon_port_harass::_id_8B19();
  scripts\sp\maps\moon_port\moon_port_hangar::_id_8AAE();
  precacheitem("offhandshield");
  precacheshader("hud_icon_window_shatter");
  precacheshader("blank");
  precachemodel("vm_hero_protagonist_base");
  precachemodel("vm_hero_protagonist_arms");
  precachemodel("helmet_hero_protagonist_crack");
  precachemodel("fx_org_view");
  precachesuit("moon_low_g_exterior");
  precachesuit("moon_low_g_interior");
  precachesuit("moon_low_g_superjump");
}

_id_BB2E() {
  scripts\engine\utility::flag_init("low_g_on");
  scripts\sp\maps\moon_port\moon_port_intro::_id_9AB5();
  scripts\sp\maps\moon_port\moon_port_concourse::_id_44D4();
  scripts\sp\maps\moon_port\moon_port_fob::_id_71E7();
  scripts\sp\maps\moon_port\moon_port_harass::_id_4F81();
  scripts\sp\maps\moon_port\moon_port_harass::_id_8AFF();
  scripts\sp\maps\moon_port\moon_port_hangar::_id_8A57();
}

_id_BB33() {
  thread _id_ABE0();
  createthreatbiasgroup("player");
  createthreatbiasgroup("allies");
  level.player setthreatbiasgroup("player");
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), scripts\sp\utility::_id_8E7E);
  scripts\sp\maps\moon_port\moon_port_util::_id_D1E2();
  scripts\sp\maps\moon_port\moon_port_util::_id_5364();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_B8F3();
  level._id_4C22 = 10;
  scripts\sp\maps\moon_port\moon_port_ambience::_id_F8B8();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_10198();
  _id_0B1F::_id_1AB7(1, getEnt("airlock_door_security", "targetname"), _id_0B1E::_id_794D("airlock_bodies_peek"));
  _id_245A("blocker_tutorials");
  _id_245A("blocker_concourse_1");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_2723("blocker_tutorials", "start_concourse_main", 110);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_2723("blocker_concourse_1", "player_grabbed_shield", 110);
  _id_0B20::_id_5A38();
  scripts\engine\utility::waitframe();

  if(scripts\engine\utility::flag("player_grabbed_shield"))
    level.player giveweapon("offhandshield");

  scripts\engine\utility::waitframe();
  level._id_1093A = ::_id_10196;
  thread scripts\sp\maps\moon_port\moon_port_util::_id_FA58();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_B693();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_2AE7();
  thread _id_1264B();
  thread _id_F9DD();
  scripts\sp\utility::_id_F44E(1);
  var_0 = getEnt("hangar_window_blocker", "targetname");

  if(isDefined(var_0))
    var_0 hide();

  if(isDefined(level.doors["hangar_door"])) {
    level.doors["hangar_door"] showpart("door_locked");
    level.doors["hangar_door"] hidepart("door_unlocked");
    level.doors["hangar_door"] hidepart("door_inactive");
  }

  level._id_AA8C = getEnt("player_jackal", "targetname");
  level._id_AA8C hide();
}

_id_ABE0() {
  scripts\sp\utility::_id_C264("OBJECTIVE_INFIL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_INFIL"), &"MOON_PORT_OBJECTIVE_INFIL");
  scripts\sp\utility::_id_C264("OBJECTIVE_SECURE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_SECURE"), &"MOON_PORT_OBJECTIVE_SECURE");
  scripts\sp\utility::_id_C264("OBJECTIVE_COAST_GUARD");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_COAST_GUARD"), &"MOON_PORT_OBJECTIVE_COAST_GUARD");
  scripts\sp\utility::_id_C264("OBJECTIVE_HANGAR");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_HANGAR"), &"MOON_PORT_OBJECTIVE_HANGAR");
  scripts\sp\utility::_id_C264("OBJECTIVE_JACKAL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_JACKAL"), &"MOON_PORT_OBJECTIVE_JACKAL");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_INFIL"), "current");
  scripts\engine\utility::flag_wait("shutter_tut_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_INFIL"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_SECURE"), "current");
  scripts\engine\utility::flag_wait("shutter_tut_done");
  scripts\engine\utility::flag_wait("coastguard_obj");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_COAST_GUARD"), "active");
  scripts\engine\utility::flag_wait("coastguard_c8_dead");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_COAST_GUARD"));
  scripts\engine\utility::flag_wait("player_at_hangar_window");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_SECURE"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_HANGAR"), "current");
  scripts\engine\utility::flag_wait("salter_unlock_ordered");
  wait 3;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_HANGAR"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_JACKAL"), "current");
}

_id_10196() {
  if(isDefined(level._id_4D80)) {
    if(level.player istouching(level._id_4D80))
      return 0;

    return 1;
  } else
    return 1;
}

_id_245A(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = var_1 scripts\engine\utility::get_target_array();

  foreach(var_4 in var_2)
  var_4 linkTo(var_1);
}

_id_F9DD() {
  wait 0.5;
  scripts\engine\utility::flag_wait("moon_port_harass_tr_loaded");
  wait 0.5;

  if(isDefined(level._id_BA3F)) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("monorail_monorail_monorail", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level._id_BA3F = spawn("script_model", var_0.origin);
  level._id_BA3F.angles = var_0.angles;
  level._id_BA3F setModel("vfx_moon_monorail_buckle");
  level._id_BA3F._id_1FBB = "monorail";
  level._id_BA3F scripts\sp\anim::_id_F64A();
}

_id_BB34() {}

_id_DE57() {
  var_0 = scripts\engine\utility::getStructArray("moon_infil_shutters", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_10639("shutters");
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_3 _meth_82A2(var_3 scripts\sp\utility::_id_7DC1("shutters_close"), 1, 0, 99999);
  }
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

_id_7786() {
  level.allies = [];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_tutorials");
}

_id_7785() {
  var_0 = 0;

  for(;;) {
    if(level.player useButtonPressed()) {
      var_1 = level._id_13133[var_0];
      var_0 = var_0 + 1;

      if(var_0 >= level._id_13133.size)
        var_0 = 0;

      var_2 = level._id_13133[var_0];
      var_3 = [];
      var_4 = [];

      foreach(var_6 in var_1) {
        if(!scripts\engine\utility::array_contains(var_2, var_6))
          var_3[var_3.size] = var_6;
      }

      foreach(var_6 in var_2) {
        if(!scripts\engine\utility::array_contains(var_1, var_6))
          var_4[var_4.size] = var_6;
      }

      scripts\sp\utility::_id_12651(var_3);
      wait 1.0;
      scripts\sp\utility::_id_12643(var_4);
    }

    while(level.player useButtonPressed())
      wait 0.1;

    wait 0.1;
  }
}

_id_1296B() {
  var_0 = getEntArray("explosion_harass_01", "targetname");
  var_0 = scripts\sp\utility::_id_22A2(var_0, getEntArray("explosion_harass_01", "targetname"));
  var_0 = scripts\sp\utility::_id_22A2(var_0, getEntArray("explosion_infil_02", "targetname"));
  var_0 = scripts\sp\utility::_id_22A2(var_0, getEntArray("mn_welldeck_claxons", "script_noteworthy"));
  var_0[var_0.size] = getEnt("explosion_infil_03", "targetname");
  var_0[var_0.size] = getEnt("explosion_infil_04", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_C3C2 = var_2 _meth_8134();
    var_2 setlightintensity(0);
  }
}