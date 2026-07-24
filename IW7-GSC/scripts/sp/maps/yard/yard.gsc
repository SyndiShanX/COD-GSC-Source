/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard.gsc
*****************************************/

main() {
  scripts\sp\utility::_id_116CB("yard");
  scripts\sp\utility::_id_1263F("yard_base_tr");
  scripts\sp\utility::_id_1263F("yard_base_capitalship_tr");
  scripts\sp\utility::_id_1263F("yard_vista_tr");
  scripts\sp\utility::_id_1263F("yard_vista_ring_tr");
  scripts\sp\utility::_id_1263F("yard_elevator_tr");
  scripts\sp\utility::_id_1263F("yard_pod_chamber_tr");
  scripts\sp\utility::_id_1263F("yard_airlock_tr");
  scripts\sp\utility::_id_1263F("yard_tram_tr");
  scripts\sp\utility::_id_1263F("yard_tram_central_tr");
  scripts\sp\utility::_id_1263F("yard_central_hallway_tr");
  scripts\sp\utility::_id_1263F("yard_central_tr");
  scripts\sp\utility::_id_1263F("yard_server_tr");
  scripts\sp\utility::_id_1263F("yard_central_hub_tr");
  scripts\sp\utility::_id_1263F("yard_end_dont_unload_tr");
  scripts\engine\utility::flag_init("trig_01_set_yard");
  scripts\engine\utility::flag_init("trig_02_set_yard_int_defend");
  scripts\engine\utility::flag_init("trig_03_set_yard_int_defend");
  scripts\engine\utility::flag_init("trig_04_set_yard_int");
  scripts\engine\utility::flag_init("trig_05_set_yard_int_defend");
  scripts\engine\utility::flag_init("central_hack_ethan_end");
  scripts\sp\utility::_id_F343("elevator_arrival");
  scripts\sp\utility::_id_1749("elevator_arrival", scripts\sp\maps\yard\yard_elevator::_id_10C2B, "", scripts\sp\maps\yard\yard_elevator::_id_B1CA, ["yard_elevator_tr", "yard_pod_chamber_tr"], scripts\sp\maps\yard\yard_elevator::_id_3B5A);
  scripts\sp\utility::_id_1749("elevator_combat", scripts\sp\maps\yard\yard_elevator::_id_10C2C, "", scripts\sp\maps\yard\yard_elevator::_id_B1CB, ["yard_base_tr", "yard_elevator_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_pod_chamber_tr"], scripts\sp\maps\yard\yard_elevator::_id_3B5B);
  scripts\sp\utility::_id_1749("elevator_mac_death", scripts\sp\maps\yard\yard_elevator::_id_10C33, "", scripts\sp\maps\yard\yard_elevator::_id_B1D2, ["yard_base_tr", "yard_elevator_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_pod_chamber_tr"], scripts\sp\maps\yard\yard_elevator::_id_3B62);
  scripts\sp\utility::_id_1749("elevator_ambush", scripts\sp\maps\yard\yard_elevator::_id_10C2A, "", scripts\sp\maps\yard\yard_elevator::_id_B1C9, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_airlock_tr", "yard_pod_chamber_tr", "yard_tram_tr", "yard_tram_central_tr"], scripts\sp\maps\yard\yard_elevator::_id_3B59);
  scripts\sp\utility::_id_1749("junction_tram", scripts\sp\maps\yard\yard_junction::_id_10C92, "", scripts\sp\maps\yard\yard_junction::_id_B205, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_tram_tr", "yard_central_hallway_tr", "yard_tram_central_tr"]);
  scripts\sp\utility::_id_1749("junction_arrive", scripts\sp\maps\yard\yard_junction::_id_10C8F, "", scripts\sp\maps\yard\yard_junction::_id_B202, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_tram_tr", "yard_central_hallway_tr", "yard_central_hub_tr"]);
  scripts\sp\utility::_id_1749("junction_capture", scripts\sp\maps\yard\yard_junction::_id_10C90, "", scripts\sp\maps\yard\yard_junction::_id_B203, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_central_hallway_tr", "yard_central_hub_tr"]);
  scripts\sp\utility::_id_1749("junction_spaced", scripts\sp\maps\yard\yard_junction::_id_10C91, "", scripts\sp\maps\yard\yard_junction::_id_B204, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_central_hallway_tr", "yard_central_hub_tr", "yard_central_tr"]);
  scripts\sp\utility::_id_1749("central_elevator", scripts\sp\maps\yard\yard_central::_id_10BDD, "", scripts\sp\maps\yard\yard_central::_id_B19F, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_central_hub_tr", "yard_central_tr"], scripts\sp\maps\yard\yard_central::_id_3B48);
  scripts\sp\utility::_id_1749("central_defend", scripts\sp\maps\yard\yard_central::_id_10BDC, "", scripts\sp\maps\yard\yard_central::_id_B19E, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_central_tr"], scripts\sp\maps\yard\yard_central::_id_3B47);
  scripts\sp\utility::_id_1749("central_hack_ethan", scripts\sp\maps\yard\yard_central::_id_10BDF, "", scripts\sp\maps\yard\yard_central::_id_B1A1, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_vista_ring_tr", "yard_tram_central_tr", "yard_central_tr", "yard_server_tr"], scripts\sp\maps\yard\yard_central::_id_3B4A);
  scripts\sp\utility::_id_1749("ending", scripts\sp\maps\yard\yard_ending::_id_10C3C, "", scripts\sp\maps\yard\yard_ending::_id_B1DA, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_central_tr", "yard_end_dont_unload_tr"], scripts\sp\maps\yard\yard_ending::_id_3B65);
  scripts\sp\utility::_id_1749("ending_yard_crash_test", scripts\sp\maps\yard\yard_ending::_id_6359, "", undefined, ["yard_base_tr", "yard_base_capitalship_tr", "yard_vista_tr", "yard_central_tr", "yard_end_dont_unload_tr"], undefined);
  _id_D83F();

  if(getDvar("createfx") != "") {
    level thread _id_88CA();
  }

  scripts\sp\load::main();
  scripts\sp\maps\yard\yard_audio::main();
  _id_D704();
}

_id_D83F() {
  scripts\sp\maps\yard\gen\yard_art::main();
  scripts\sp\maps\yard\yard_fx::main();
  scripts\sp\maps\yard\yard_precache::main();
  scripts\sp\maps\yard\yard_anim::main();
  _id_0E45::_id_5F81();
  setsaveddvar("sm_sunSampleSizeNear", 1);
  setsaveddvar("r_umbraShadowCasters", 1);
  setsaveddvar("r_tessellationOverride", 0);
  scripts\sp\maps\yard\yard_lighting::main();
  _id_0B53::_id_B908("veh_mil_air_ca_destroyer", "sp/model_damage_tables/veh_mil_air_ca_destroyer_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_destroyer_fx.csv");
  precacheitem("iw7_gunless");
  precacheturret("cap_turret_large");
  precachestring(&"YARD_HINT_OPEN");
  precachestring(&"YARD_HINT_CYCLE");
  precachestring(&"YARD_PLANT_CHARGE");
  precachestring(&"YARD_HINT_EXTEND_BRIDGE");
  precachestring(&"YARD_HINT_HACK_TERMINAL");
  precachestring(&"YARD_HINT_PULL");
  precachestring(&"YARD_HINT_ENABLE_FIRE_CONTROL");
  precachestring(&"YARD_HINT_ESCAPE_JACKAL");
  scripts\sp\utility::_id_16EB("ethan_hack", &"YARD_HINT_HACK_ETHAN");
  scripts\sp\utility::_id_16EB("player_escape", &"YARD_HINT_ESCAPE");
  scripts\sp\utility::_id_16EB("ethan_destruct", &"YARD_HINT_DESTRUCT");
  scripts\sp\utility::_id_16EB("crawl_hint", &"YARD_CRAWL_HINT", scripts\sp\maps\yard\yard_junction::vent_prone_success);
  _id_9809();
}

_id_9809() {
  scripts\sp\maps\yard\yard_elevator::_id_6072();
  scripts\sp\maps\yard\yard_junction::_id_A50C();
  scripts\sp\maps\yard\yard_central::_id_3BDE();
  scripts\sp\maps\yard\yard_ending::_id_6342();
  scripts\engine\utility::flag_init("yard_start_objectives");
  scripts\engine\utility::flag_init("yard_obj_ambush_done");
  scripts\engine\utility::flag_init("yard_obj_locate_command_done");
  scripts\engine\utility::flag_init("yard_obj_activate_controls_done");
  scripts\engine\utility::flag_init("yard_obj_hack_ethan_done");
  scripts\engine\utility::flag_init("yard_obj_destroy_core_done");
}

_id_D704() {
  setsaveddvar("r_umbraMinObjectContribution", 0);
  precachemodel("base_grapple_rope");
  precachemodel("base_grapple_scale_rope");
  precachemodel("viewmodel_base_viewhands_iw7");
  precachemodel("weapon_handheld_hacking_device_vm");
  precachemodel("tactical_knife_iw7_vm");
  precachemodel("debris_exterior_damaged_metal_panels_08_scl50");
  precachemodel("equipment_sdf_kiosk_01_red_off");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_04");
  precachemodel("vm_eth3n_arms");
  precachemodel("sdf_core_console_01_rig");
  precachemodel("fullbody_hero_eth3n_vm_legs");
  precachemodel("eth3n_shadow");
  scripts\engine\utility::array_call(getEntArray("notsolid_on_load", "script_noteworthy"), ::notsolid);
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), scripts\sp\utility::_id_8E7E);
  scripts\engine\utility::array_thread(getEntArray("off_on_load", "script_noteworthy"), scripts\engine\utility::trigger_off);
  createthreatbiasgroup("player");
  createthreatbiasgroup("c12");
  createthreatbiasgroup("ignore_player");
  createthreatbiasgroup("allies_left");
  createthreatbiasgroup("allies_right");
  createthreatbiasgroup("axis_left");
  createthreatbiasgroup("axis_right");
  level.player setthreatbiasgroup("player");
  level.player _id_0E4B::_id_8E06();
  setignoremegroup("player", "ignore_player");
  _id_0B6C::_id_9717();
  _id_0F21::main();
  scripts\engine\utility::delaythread(2.0, _id_0F26::_id_117D3, 0);
  _id_0E45::main();
  scripts\sp\maps\yard\yard_elevator::_id_60BB();
  scripts\sp\maps\yard\yard_junction::_id_A50E();
  thread scripts\sp\maps\yard\yard_util::_id_13E43();
  thread _id_8E7C();
  thread _id_8EB5();
  level thread _id_0A2F::_id_3D61();
}

_id_88CA() {
  thread _id_49BE();

  while(!istransientloaded("yard_pod_chamber_tr")) {
    wait 0.05;
  }

  wait 1;
  level._id_B11F = scripts\engine\utility::getStruct("mac_death_ap", "targetname");
  level._id_B126 = scripts\sp\utility::_id_10639("mac_kiosk");
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_B126, "mac_death_scene_e");
  var_0 = getEnt("drop_pod_launch", "targetname");
  var_0 hide();
  level._id_D617 = getEnt("pod_of_death_base", "targetname");
  level._id_D617 hide();
}

_id_49BE() {
  while(!istransientloaded("yard_server_tr")) {
    wait 0.05;
  }

  wait 1;
  var_0 = scripts\engine\utility::getStruct("org_anim_power_core", "targetname");
  var_1 = scripts\sp\utility::_id_10639("j_prop_panel");
  var_2 = [];
  var_2[0] = var_1;
  var_0 scripts\sp\anim::_id_1EC1(var_2, "panel_start_01");
  var_3 = getEnt("panel_new", "targetname");
  var_3.origin = var_1 gettagorigin("tag_door");
  var_3.angles = var_1 gettagangles("tag_door");
  var_3 linkTo(var_1, "tag_door");
  var_4 = getEnt("console_new", "targetname");
  var_4.origin = var_1 gettagorigin("tag_console");
  var_4.angles = var_1 gettagangles("tag_console");
  var_4 linkTo(var_1, "tag_console");
  var_5 = getEnt("panel_dest", "targetname");
  var_5.origin = var_1 gettagorigin("tag_door");
  var_5.angles = var_1 gettagangles("tag_door");
  var_5 linkTo(var_1, "tag_door");
  var_6 = getEnt("console_dest", "targetname");
  var_6.origin = var_1 gettagorigin("tag_console");
  var_6.angles = var_1 gettagangles("tag_console");
  var_6 linkTo(var_1, "tag_console");
  var_4 hide();
  var_3 hide();
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "panel_end");
}

_id_8E7C() {
  var_0 = getEntArray("salter_deck_geo", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_4 = getEntArray("salter_deck_models", "targetname");

  foreach(var_6 in var_4) {
    var_6 hide();
  }

  var_8 = getEntArray("yard_debris_field", "targetname");

  foreach(var_6 in var_8) {
    var_6 hide();
  }
}

_id_8EB5() {
  var_0 = getEntArray("control_room_vista_dome_01", "targetname");

  if(isDefined(var_0) && var_0.size) {
    foreach(var_2 in var_0) {
      var_2 hide();
    }
  }
}