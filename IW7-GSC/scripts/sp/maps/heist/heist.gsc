/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist.gsc
*******************************************/

main() {
  scripts\sp\utility::_id_116CB("heist");
  scripts\sp\maps\heist\gen\heist_art::main();
  scripts\sp\maps\heist\heist_fx::main();
  scripts\sp\maps\heist\heist_precache::main();
  scripts\sp\maps\heist\heist_anim::main();
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_924A();
  scripts\sp\maps\heist\heist_flytomons::_id_95E8();
  _id_FA53();
  _id_8D1E();
  _id_6E3A();
  _id_8D1A();
  var_0 = ["mons_landed", "mons_lift", "mons_top_deck", "mons_mid_deck", "mons_breach", "mons_interior", "mons_bridge"];
  scripts\sp\starts::_id_48E4(var_0);
  scripts\sp\starts::_id_48E1("mons_landed", "Olympus Mons has been temporarily disabled. You have landed on it and now move to take the bridge");
  scripts\sp\starts::_id_48E2("mons_bridge", scripts\engine\utility::flag_wait, "heist_end_launch_seq");
  _id_978A();
  scripts\sp\utility::_id_16CC("small_long", 0.15, 10, 2048);
  scripts\sp\utility::_id_16CC("small_med", 0.1, 5, 2048);
  scripts\sp\utility::_id_16CC("small_short", 0.15, 1, 2048);
  scripts\sp\utility::_id_16CC("medium_medium", 0.25, 3, 2048);
  scripts\sp\utility::_id_16CC("large_short", 0.45, 1, 2048);
  scripts\sp\utility::_id_16CC("large_medium_constant", 0.45, 2, 2048);
  setdvarifuninitialized("debug_lift_top", 0);
  setdvarifuninitialized("debug_cranes", 0);
  setdvarifuninitialized("debug_fleet", 0);
  setdvarifuninitialized("ret_timing_offset", -0.5);
  setsaveddvar("r_spotLightEntityShadows", 1);
  scripts\sp\load::main();

  if(getdvarint("r_reflectionProbeGenerate") == 1) {} else
    getEnt("bridge_window_shields_scriptmodel", "targetname") delete();

  level.allies = [];
  thread _id_12648();
  thread _id_9712();
  thread objectives();
  scripts\sp\maps\heist\heist_lift::cargo_lift_preinit();
  scripts\engine\utility::array_thread(getEntArray("door_with_lock", "script_noteworthy"), scripts\sp\maps\heist\heist_util::_id_F363, undefined, "lock");
  thread scripts\sp\maps\heist\heist_util::_id_BD33();
  scripts\engine\utility::array_thread(getEntArray("off_on_load", "script_noteworthy"), scripts\engine\utility::trigger_off);
  scripts\engine\utility::array_thread(getEntArray("off_on_load", "targetname"), scripts\engine\utility::trigger_off);
  level._id_4E79 = getEnt("debris_concrete_rubble_lg_03_clip", "targetname");
  level._id_4E79 notsolid();
  level._id_4E79 connectpaths();
  level._id_4EEA = 0;
  setsaveddvar("sm_sunSampleSizeNear", 0.1);
  scripts\sp\utility::_id_16EB("hint_melee", "^3[{+melee}]^7", ::_id_9005);
  scripts\sp\utility::_id_16EB("boost_hint", &"HEIST_MONS_BOOST", scripts\sp\maps\heist\heist_deck::_id_BA4F);
  scripts\sp\utility::_id_16EB("hacking_hint_pickup", &"HEIST_HACK_PICKUP", scripts\sp\maps\heist\heist_hack::_id_87CE);
  scripts\sp\utility::_id_16EB("hacking_hint_slot", &"HEIST_HACK_SLOT", scripts\sp\maps\heist\heist_hack::_id_87E5);
  scripts\sp\utility::_id_16EB("hacking_hint_ammo", &"HEIST_HACK_AMMO", scripts\sp\maps\heist\heist_hack::_id_8783);
  scripts\sp\utility::_id_16EB("hacking_hint_use", &"HEIST_HACK_USE", scripts\sp\maps\heist\heist_hack::_id_87F1);
  scripts\engine\utility::array_call(getEntArray("notsolid_on_load", "script_noteworthy"), ::notsolid);
  thread _id_ABDC();
  scripts\sp\utility::_id_228A(getEntArray("lift_floor", "targetname"));
  thread scripts\sp\maps\heist\heist_hangar::_id_C603();
  level._id_BA7F = undefined;
  var_1 = getEnt("olympus_mons_fspar", "targetname");

  if(isDefined(var_1)) {
    level._id_BA7F = spawnStruct();
    level._id_BA7F.origin = var_1.origin;
    level._id_BA7F.angles = var_1.angles;
    level._id_BA7F.model = var_1.model;
    var_1 delete();
  }

  scripts\sp\maps\heist\heist_util::_id_8E74();
  level thread _id_0A2F::_id_3D61();
  var_2 = ["pathblocker_hangar_shift_1_main", "pathblocker_hangar_shift_2_main"];

  foreach(var_4 in var_2) {
    foreach(var_6 in getEntArray(var_4, "targetname")) {
      var_6 notsolid();
    }
  }
}

_id_FA53() {
  scripts\sp\utility::_id_F343("prisoner_finale");
  var_0 = _id_7D16();
  scripts\sp\utility::_id_1749("test_mons_skybox", ::_id_11731, "Test Mons Skybox", ::_id_11730, var_0["mons_landed"], undefined);
  scripts\sp\utility::_id_1749("prisoner_finale", scripts\sp\maps\heist\heist_un_rooftop::_id_D93F, "Prisoner Finale", scripts\sp\maps\heist\heist_un_rooftop::_id_D93D, var_0["prisoner_finale"], scripts\sp\maps\heist\heist_un_rooftop::_id_D93E);
  scripts\sp\utility::_id_1749("top_of_church", scripts\sp\maps\heist\heist_un_rooftop::_id_119FE, "Top Of Church", scripts\sp\maps\heist\heist_un_rooftop::_id_119F5, var_0["top_of_church"], undefined);
  scripts\sp\utility::_id_1749("jackal_arrives", scripts\sp\maps\heist\heist_flytomons::_id_A0A2, "Jackal Arrives", scripts\sp\maps\heist\heist_flytomons::_id_A09D, var_0["top_of_church"], scripts\sp\maps\heist\heist_un_rooftop::_id_3B4B);
  scripts\sp\utility::_id_1749("mons_landed", scripts\sp\maps\heist\heist_hangar::_id_BABE, "Mons Hangar", scripts\sp\maps\heist\heist_hangar::_id_BABD, var_0["mons_hangar"], scripts\sp\maps\heist\heist_hangar::_id_4084);
  scripts\sp\utility::_id_1749("hangar_c12", scripts\sp\maps\heist\heist_hangar_c12::_id_8A27, "c12 Hangar", scripts\sp\maps\heist\heist_hangar_c12::_id_8A26, var_0["mons_hangar"], scripts\sp\maps\heist\heist_hangar::_id_4085);
  scripts\sp\utility::_id_1749("mons_lift", scripts\sp\maps\heist\heist_lift::_id_BAC9, "Mons Lift", scripts\sp\maps\heist\heist_lift::_id_BAC8, var_0["mons_hangar"], undefined);
  scripts\sp\utility::_id_1749("mons_top_deck", scripts\sp\maps\heist\heist_deck::_id_BAF4, "Mons Top Deck", scripts\sp\maps\heist\heist_deck::_id_BAF3, var_0["mons_deck"], undefined);
  scripts\sp\utility::_id_1749("mons_mid_deck", scripts\sp\maps\heist\heist_deck::_id_BACD, "Mons Mid Deck", scripts\sp\maps\heist\heist_deck::_id_BACC, var_0["mons_deck"], undefined);
  scripts\sp\utility::_id_1749("mons_end_deck", scripts\sp\maps\heist\heist_deck::_id_BA7C, "Mons End Deck", scripts\sp\maps\heist\heist_deck::_id_BA7B, var_0["mons_deck"], scripts\sp\maps\heist\heist_lift::cleanup_lift);
  scripts\sp\utility::_id_1749("mons_breach", scripts\sp\maps\heist\heist_breach::_id_10BBD, "Bridge Breach", scripts\sp\maps\heist\heist_breach::_id_B194, var_0["mons_bridge_approach"], undefined);
  scripts\sp\utility::_id_1749("mons_hack", scripts\sp\maps\heist\heist_hack::_id_10C70, "Robot Hack", scripts\sp\maps\heist\heist_hack::_id_B1EF, var_0["mons_bridge_approach"], scripts\sp\maps\heist\heist_hack::_id_8D18);
  scripts\sp\utility::_id_1749("kotch_kill", scripts\sp\maps\heist\heist_bridge::_id_10C94, "Kotch Kill", scripts\sp\maps\heist\heist_bridge::_id_B207, var_0["mons_bridge_approach"], undefined);
  scripts\sp\utility::_id_1749("mons_launch", scripts\sp\maps\heist\heist_bridge::_id_10CB1, "Mons Launch", scripts\sp\maps\heist\heist_bridge::_id_B211, var_0["mons_launch"], undefined);
}

_id_8D1E() {
  precacherumble("light_1s");
  precacherumble("light_2s");
  precacherumble("heavy_3s");
  precacheshader("apache_target_lock");
  precacheitem("iw7_gunless");
  precacheitem("heist_aa_mg");
  precacheitem("cap_turret_proj_weapon");
  precacheitem("cap_turret_proj_heist");
  precachemodel("viewmodel_base_viewhands_iw7");
  precachemodel("vm_hero_protagonist_fullbody");
  precachemodel("seeker_grenade_wm");
  precachemodel("tactical_knife_iw7_wm");
  precachemodel("equipment_sp_transponder");
  precachemodel("equipment_sp_transponder_broken");
  precachemodel("building_geneva_vista_periph_un_01_dest_full_animate");
  precachemodel("seeker_grenade_heist_breach_wm");
  precachemodel("building_aatis_planetary_defense_gun_large");
  precachemodel("la_building_06_ygb_dest_full_animate");
  precachemodel("building_periph_geneva_01_light_dest_full_animate");
  precachemodel("building_periph_geneva_06_light_dest_full_animate");
  precachemodel("building_office_geneva_mid_highrise_01_dest");
  precachemodel("building_office_geneva_mid_highrise_05_dest");
  precachemodel("building_office_geneva_mid_highrise_03_small_dest");
  precachemodel("building_geneva_vista_periph_highrise_04_half_dest");
  precachemodel("building_periph_geneva_02_dest");
  precachemodel("la_building_08_dest");
  precachemodel("la_building_11_dest");
  precachemodel("la_building_14_dest");
  precachemodel("sdf_console_control_panel_11_scale_off");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_01_clear");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_01");
  precachemodel("body_sdf_kotch_blood");
  precachemodel("head_sdf_kotch_blood_hqss");
}

_id_6E3A() {
  scripts\engine\utility::flag_init("place_holder");
  scripts\engine\utility::flag_init("allies_spawned");
  scripts\engine\utility::flag_init("ship_list_pause");
  scripts\engine\utility::flag_init("ship_list_active");
  scripts\engine\utility::flag_init("ship_list_stopping");
  scripts\engine\utility::flag_init("transient_top_of_church");
  scripts\engine\utility::flag_init("transient_jackal_arrives");
  scripts\engine\utility::flag_init("transient_mons_hangar");
  scripts\engine\utility::flag_init("transient_mons_lift");
  scripts\engine\utility::flag_init("transient_mons_deck");
  scripts\engine\utility::flag_init("transient_mons_bridge_approach");
  scripts\engine\utility::flag_init("transient_mons_launch");
  scripts\engine\utility::flag_init("mons_boost");
  scripts\engine\utility::flag_init("mons_boost_failed");
  scripts\engine\utility::flag_init("slide_scene_done");
  scripts\engine\utility::flag_init("prisoner_finale_end");
  scripts\engine\utility::flag_init("mons_aim_at_church");
  scripts\engine\utility::flag_init("jackal_arrives_player_jumped");
  scripts\engine\utility::flag_init("jackal_arrives_end");
  scripts\engine\utility::flag_init("top_of_church_sdf_arrival_start");
  scripts\engine\utility::flag_init("top_of_church_sdf_arrival_fire");
  scripts\engine\utility::flag_init("top_of_church_end");
  scripts\engine\utility::flag_init("player_failed_to_launch");
  scripts\engine\utility::flag_init("early_final_retreat");
  scripts\engine\utility::flag_init("hangar_runners_pit");
  scripts\engine\utility::flag_init("hangar_bay_doors_closed");
  scripts\engine\utility::flag_init("hangar_shiplist_fx_enabled");
  scripts\engine\utility::flag_init("close_hangar_bay_doors");
  scripts\engine\utility::flag_init("mons_landed_end");
  scripts\engine\utility::flag_init("mons_dropship_done");
  scripts\engine\utility::flag_init("hangar_first_door_open");
  scripts\engine\utility::flag_init("hangar_door_one_close");
  scripts\engine\utility::flag_init("hangar_door_two_close");
  scripts\engine\utility::flag_init("stop_hangar_middle_respawn");
  scripts\engine\utility::flag_init("dropship_dropoff_done");
  scripts\engine\utility::flag_init("enemy_dropship_1_leaving");
  scripts\engine\utility::flag_init("enemy_dropship_1_delete");
  scripts\engine\utility::flag_init("enemy_dropship_2_delete");
  scripts\engine\utility::flag_init("enemy_dropship_2_unloading");
  scripts\engine\utility::flag_init("lift_nag_end");
  scripts\engine\utility::flag_init("hangar_lift_1_triggered");
  scripts\engine\utility::flag_init("hangar_lift_2a_triggered");
  scripts\engine\utility::flag_init("hangar_lift_2b_triggered");
  scripts\engine\utility::flag_init("hangar_lift_end_triggered");
  scripts\engine\utility::flag_init("hangar_encounters_end");
  scripts\engine\utility::flag_init("retreat_to_c12");
  scripts\engine\utility::flag_init("event_hangar_bank_left_done");
  scripts\engine\utility::flag_init("elevator_ready");
  scripts\engine\utility::flag_init("lift_moving_cover_state_1");
  scripts\engine\utility::flag_init("lift_encounter_reinforce");
  scripts\engine\utility::flag_init("ethan_on_lift");
  scripts\engine\utility::flag_init("brooks_on_lift");
  scripts\engine\utility::flag_init("salter_on_lift");
  scripts\engine\utility::flag_init("kashima_on_lift");
  scripts\engine\utility::flag_init("lift_start_move");
  scripts\engine\utility::flag_init("mons_top_deck_end");
  scripts\engine\utility::flag_init("mons_mid_deck_end");
  scripts\engine\utility::flag_init("deck_combat_end");
  scripts\engine\utility::flag_init("player_on_mons_deck");
  scripts\engine\utility::flag_init("building_pos_moveup");
  scripts\engine\utility::flag_init("building_crash_into_om");
  scripts\engine\utility::flag_init("building_start_scrape");
  scripts\engine\utility::flag_init("building_rotated_to_zero");
  scripts\engine\utility::flag_init("steel_dragon_scene_done");
  scripts\engine\utility::flag_init("lift_end");
  scripts\engine\utility::flag_init("lift_nag_active");
  scripts\engine\utility::flag_init("dropship_go");
  scripts\engine\utility::flag_init("end_deck_startpoint");
  scripts\engine\utility::flag_init("deck_runner_go");
  scripts\engine\utility::flag_init("seekers_released");
  scripts\engine\utility::flag_init("run_anim_done");
  scripts\engine\utility::flag_init("breach_room_success");
  scripts\engine\utility::flag_init("deck_allies_press");
  scripts\engine\utility::flag_init("hack_sequence_complete");
  scripts\engine\utility::flag_init("player_in_bot");
  scripts\engine\utility::flag_init("dialogue_mid_deck_complete");
  scripts\engine\utility::flag_init("lgt_deck_hangar_door");
  scripts\engine\utility::flag_init("bridge_defend");
  scripts\engine\utility::flag_init("retreat_bridge");
  scripts\engine\utility::flag_init("hacked_robot_scene_active");
  scripts\engine\utility::flag_init("defensive_gesture_active");
  scripts\engine\utility::flag_init("dialogue_hack_nag");
  scripts\engine\utility::flag_init("close_deck_door");
  scripts\engine\utility::flag_init("breach_ready");
  scripts\engine\utility::flag_init("flag_hint_melee");
  scripts\engine\utility::flag_init("move_bridge_blast_shields");
  scripts\engine\utility::flag_init("mons_breach_end");
  scripts\engine\utility::flag_init("mons_bridge_end");
  scripts\engine\utility::flag_init("mons_launch_end");
  scripts\engine\utility::flag_init("pre_load_mons_launch");
  scripts\engine\utility::flag_init("heist_wait_launch");
  scripts\engine\utility::flag_init("heist_end_launch_seq");
  scripts\engine\utility::flag_init("bridge_crew_killed");
  scripts\engine\utility::flag_init("breach_started");
  scripts\engine\utility::flag_init("breach_room_cleared");
  scripts\engine\utility::flag_init("bridge_taken_by_player");
  scripts\engine\utility::flag_init("bridge_start_self_destruct");
  scripts\engine\utility::flag_init("hacked_robot_enters_bridge");
  scripts\engine\utility::flag_init("melee_interrupted");
  scripts\engine\utility::flag_init("kotch_vo_active");
  scripts\engine\utility::flag_init("mons_destruct_started");
  scripts\engine\utility::flag_init("bridge_alerted");
  scripts\engine\utility::flag_init("bridge_path_start_brooks");
  scripts\engine\utility::flag_init("bridge_path_start_salter");
  scripts\engine\utility::flag_init("bridge_path_start_kashima");
  scripts\engine\utility::flag_init("bridge_robots_saluting");
  scripts\engine\utility::flag_init("kotch_death_start");
  scripts\engine\utility::flag_init("bridge_shields_open");
  scripts\engine\utility::flag_init("self_destruct_started");
  scripts\engine\utility::flag_init("level_end");
}

_id_8D1A() {
  level._id_1C85 = ["frag", "emp"];
  level._id_1C84 = [];
  level._id_1C82 = [];
}

_id_ABDC() {
  level._id_10C59 = gettime();
  scripts\engine\utility::flag_wait("level_end");
  var_0 = gettime() - level._id_10C59;
  var_0 = var_0 / 1000;
  var_0 = var_0 / 60;
}

_id_9712() {
  _id_0B6C::_id_9717();
}

_id_8EA3(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = "targetname";
  }

  var_3 = getEnt(var_0, var_2);

  if(isDefined(var_3)) {
    var_3 hide();
  }

  level._id_F05E = scripts\engine\utility::array_add(level._id_F05E, var_3);
}

_id_F044() {
  level._id_7695 = [];
  level._id_7696 = [];
  level._id_F05A = [];
  level._id_F05D = [];
  level._id_F05B = getEntArray("sdf_skybox_destroyer", "targetname");
  level._id_F05C = getEntArray("sdf_skybox_frigate", "targetname");
  level._id_F05A = scripts\engine\utility::array_combine(level._id_F05B, level._id_F05C);
  level._id_F05A = scripts\engine\utility::array_randomize(level._id_F05A);
}

_id_F052() {
  level._id_BAE8 = scripts\sp\utility::_id_7D40("mons_skybox", "targetname");
  level._id_BAE8 notsolid();
  level._id_BAE8._id_4348 = getEnt("fake_mons_collision", "targetname");
  level._id_BAE8._id_4348 solid();
  level._id_BAE8._id_4348 linkTo(level._id_BAE8);
  level._id_BAE8._id_1FBB = "olympus_mons";
  level._id_BAE8 scripts\sp\anim::_id_F64A();
  level._id_BAE8.target = "mons_skybox_path1";
  level._id_BAE8 castdistantshadows();
  level._id_BAE8 hide();
  level._id_BAEA = getEnt("mons_hangar_clip", "targetname");
  level._id_BAEA linkTo(level._id_BAE8);
  var_0 = getEntArray("light_mons_hangar_fake", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 linkTo(level._id_BAE8);
  }

  level notify("mons_fake_hangar_lights_off");
  var_4 = getEnt("refl_mons_fake_hangar", "targetname");
  var_4 linkTo(level._id_BAE8);
  level._id_BAE9 = getEntArray("mons_hangar", "targetname");

  foreach(var_6 in level._id_BAE9) {
    var_6 notsolid();
    var_6 castdistantshadows();
    var_6 hide();
  }

  level._id_BAE8 thread _id_0BB8::_id_39D0("off");
  level._id_BAE8 thread _id_0BB8::_id_39CD("off");
}

_id_F04F() {
  if(isDefined(level._id_BA6F)) {
    return;
  }
  level._id_BA6F = 1;
  wait 1.0;
  level._id_BAE9 = getEntArray("mons_hangar", "targetname");

  if(isDefined(level._id_BAE9)) {
    foreach(var_1 in level._id_BAE9) {
      var_1 delete();
    }
  }

  level notify("mons_fake_hangar_lights_off");
  var_3 = getEntArray("light_mons_hangar_fake", "script_noteworthy");

  foreach(var_5 in var_3) {
    var_5 delete();
  }

  var_7 = getEnt("refl_mons_fake_hangar", "targetname");

  if(isDefined(var_7)) {
    var_7 delete();
  }

  level._id_BAEA = getEnt("mons_hangar_clip", "targetname");

  if(isDefined(level._id_BAEA)) {
    level._id_BAEA delete();
  }

  level._id_BAE8 = scripts\sp\utility::_id_7D40("mons_skybox", "targetname");

  if(isDefined(level._id_BAE8._id_4348)) {
    level._id_BAE8._id_4348 delete();
  }

  if(isDefined(level._id_BAE8)) {
    level._id_BAE8 thread _id_0BB8::_id_39D0("off");
    level._id_BAE8 thread _id_0BB8::_id_39CD("off");
    level._id_BAE8 _id_0BB4::_id_5171();
    level._id_BAE8 _id_0BA9::_id_397B();
  }
}

_id_F054() {
  var_0 = getEnt("retribution_skybox", "targetname");
  level._id_E3F6 = var_0 scripts\sp\utility::_id_10808();
  level._id_E3F6._id_1FBB = "retribution";
  level._id_E3F6 scripts\sp\anim::_id_F64A();
  level._id_E3F6 notsolid();
  level._id_E3F6 castdistantshadows();
  level._id_E3F6._id_6A21 = [];
  var_1 = scripts\engine\utility::getStruct("retribution_ext_lights", "script_noteworthy");

  foreach(var_3 in getEntArray("retribution_ext_lights", "script_noteworthy")) {
    if(issubstr(var_3.classname, "light")) {
      var_4 = var_3.origin - var_1.origin;

      if(!isDefined(var_1.angles)) {
        var_1.angles = (0, 0, 0);
      }

      var_5 = scripts\engine\utility::anglebetweenvectors(anglesToForward(var_3.angles), anglesToForward(var_1.angles));
      var_3 linkTo(level._id_E3F6, "tag_origin", var_4, (0, var_5, 0));
      level._id_E3F6._id_6A21[level._id_E3F6._id_6A21.size] = var_3;
    }
  }

  wait 0.1;
  level._id_E3F6 thread _id_0BB8::_id_39D0("off");
  level._id_E3F6 thread _id_0BB8::_id_39CD("off");
  level._id_E3F6 hide();
}

_id_F045(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 scripts\sp\utility::_id_10808();
  level._id_F05D = scripts\engine\utility::array_add(level._id_F05D, var_1);

  if(getdvarint("debug_fleet")) {
    var_1 thread _id_D8F7();
  }

  return var_1;
}

_id_D8F7() {
  self endon("death");
  var_0 = ".";

  if(isDefined(self._id_6A0B)) {
    var_0 = self._id_6A0B;
  }

  for(;;) {
    wait 0.1;
  }
}

_id_3F91() {
  var_0 = scripts\engine\utility::getStruct("vfx_crashed_destroyer01", "targetname");
  var_1 = scripts\engine\utility::getStruct("vfx_crashed_destroyer02", "targetname");
  playFX(level._effect["vfx_hst_smoke_plume_distant_cap_crash"], var_0.origin);
  playFX(level._effect["vfx_hst_smoke_plume_distant_cap_crash"], var_1.origin);
}

_id_9005() {
  return !scripts\engine\utility::flag("flag_hint_melee");
}

_id_978A() {
  scripts\sp\utility::_id_1263F("heist_transient_ignore_tr");
  scripts\sp\utility::_id_1263F("heist_base_tr");
  scripts\sp\utility::_id_1263F("heist_city_tr");
  scripts\sp\utility::_id_1263F("heist_city_mover_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_cic_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_hangar_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_ext_combat_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_gun_deck_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_lift_combat_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_outer_hull_tr");
  scripts\sp\utility::_id_1263F("heist_geo_om_bridge_tr");
  scripts\sp\utility::_id_1263F("heist_cap_ships_tr");
}

_id_7D16(var_0) {
  var_1["none"] = [];
  var_1["prisoner_finale"] = ["heist_city_tr"];
  var_1["top_of_church"] = ["heist_base_tr", "heist_cap_ships_tr", "heist_city_tr", "heist_geo_om_hangar_tr"];
  var_1["mons_hangar"] = ["heist_base_tr", "heist_geo_om_hangar_tr", "heist_geo_om_lift_combat_tr"];
  var_1["mons_lift"] = ["heist_base_tr", "heist_geo_om_lift_combat_tr"];
  var_1["mons_deck"] = ["heist_base_tr", "heist_geo_om_ext_combat_tr", "heist_geo_om_gun_deck_tr", "heist_geo_om_lift_combat_tr", "heist_geo_om_outer_hull_tr", "heist_geo_om_bridge_tr"];
  var_1["mons_bridge_approach"] = ["heist_base_tr", "heist_geo_om_gun_deck_tr", "heist_geo_om_cic_tr", "heist_cap_ships_tr", "heist_geo_om_bridge_tr"];
  var_1["mons_launch"] = ["heist_city_mover_tr", "heist_cap_ships_tr", "heist_geo_om_bridge_tr"];

  if(isDefined(var_0)) {
    return var_1[var_0];
  }

  return var_1;
}

_id_12648() {
  scripts\engine\utility::flag_wait("start_is_set");
  scripts\engine\utility::waitframe();

  switch (level._id_10CDA) {
    case "prisoner_finale":
      _id_AE0D("prisoner_finale");
      scripts\engine\utility::flag_wait("transient_top_of_church");
    case "jackal_arrives":
    case "top_of_church":
      _id_AE0D("top_of_church");
      scripts\engine\utility::flag_wait("transient_mons_hangar");
    case "hangar_c12":
    case "mons_lift":
    case "mons_landed":
      _id_AE0D("mons_hangar");
      scripts\engine\utility::flag_wait("transient_mons_lift");
      _id_AE0D("mons_lift");
      scripts\engine\utility::flag_wait("transient_mons_deck");
    case "mons_end_deck":
    case "mons_mid_deck":
    case "mons_top_deck":
      _id_AE0D("mons_deck");
      scripts\engine\utility::flag_wait("transient_mons_bridge_approach");
      scripts\sp\maps\heist\heist_lift::cleanup_lift();
    case "kotch_kill":
    case "mons_hack":
    case "mons_breach":
      _id_AE0D("mons_bridge_approach");
      scripts\engine\utility::flag_wait("transient_mons_launch");
    case "mons_launch":
      _id_AE0D("mons_launch");
      break;
    case "test_mons_skybox":
      break;
    default:
  }
}

_id_AE0D(var_0) {
  var_1 = _id_7D16(var_0);

  if(isDefined(level._id_4BCB)) {
    foreach(var_3 in _id_7D16(level._id_4BCB)) {
      if(!isDefined(scripts\engine\utility::array_find(var_1, var_3))) {
        thread scripts\sp\utility::_id_1264E(var_3);
      }
    }
  }

  foreach(var_3 in var_1) {
    thread scripts\sp\utility::_id_12641(var_3);
  }

  level._id_4BCB = var_0;
}

objectives() {
  scripts\engine\utility::flag_init("obj_flytomons");
  scripts\engine\utility::flag_init("obj_securethehangar");
  scripts\engine\utility::flag_init("obj_killc12");
  scripts\engine\utility::flag_init("obj_getonlift");
  scripts\engine\utility::flag_init("obj_gettobridge");
  scripts\engine\utility::flag_init("obj_hack");
  scripts\engine\utility::flag_init("obj_stopkotch");
  scripts\engine\utility::flag_init("obj_gotokotch");
  scripts\engine\utility::flag_init("obj_dealwithkotch");
  scripts\engine\utility::flag_init("obj_initiatelaunch");
  scripts\engine\utility::flag_wait("start_is_set");
  scripts\engine\utility::waitframe();

  switch (level._id_10CDA) {
    case "jackal_arrives":
    case "top_of_church":
    case "prisoner_finale":
      scripts\engine\utility::flag_wait("obj_flytomons");
      var_0 = scripts\engine\utility::getStruct("jump_obj", "targetname");
      level._id_D127._id_116AE = level._id_D127 scripts\engine\utility::spawn_tag_origin();
      level._id_D127._id_116AE linkTo(level._id_D127, "j_weapon_hatch_right2", (0, 0, 30), (0, 0, 0));
      objective_add(scripts\sp\utility::_id_C264("obj_flytomons"), "current", &"HEIST_OBJ_FLYTOMONS");
      objective_onentity(scripts\sp\utility::_id_C264("obj_flytomons"), level._id_D127._id_116AE);
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_flytomons", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_flytomons"));
    case "mons_landed":
      scripts\engine\utility::flag_wait("obj_securethehangar");
      objective_add(scripts\sp\utility::_id_C264("obj_securethehangar"), "current", &"HEIST_OBJ_SECURETHEHANGAR");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_securethehangar", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_securethehangar"));
    case "hangar_c12":
      scripts\engine\utility::flag_wait("obj_killc12");
      objective_add(scripts\sp\utility::_id_C264("obj_killc12"), "current", &"HEIST_OBJ_KILLC12");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_killc12", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_killc12"));
    case "mons_lift":
      scripts\engine\utility::flag_wait("obj_getonlift");
      objective_add(scripts\sp\utility::_id_C264("obj_getonlift"), "current", &"HEIST_OBJ_GETONLIFT");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_getonlift", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_getonlift"));
      scripts\engine\utility::flag_wait("obj_gettobridge");
      objective_add(scripts\sp\utility::_id_C264("obj_gettobridge"), "current", &"HEIST_OBJ_GETTOBRIDGE");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_gettobridge", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_gettobridge"));
    case "mons_hack":
    case "mons_end_deck":
    case "mons_breach":
    case "mons_mid_deck":
    case "mons_top_deck":
      scripts\engine\utility::flag_wait("obj_hack");
      objective_add(scripts\sp\utility::_id_C264("obj_hack"), "current", &"HEIST_OBJ_HACK");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_hack", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_hack"));
      scripts\engine\utility::flag_wait("obj_stopkotch");
      objective_add(scripts\sp\utility::_id_C264("obj_stopkotch"), "current", &"HEIST_OBJ_STOPKOTCH");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_stopkotch", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_stopkotch"));
    case "kotch_kill":
      scripts\engine\utility::flag_wait("obj_gotokotch");
      objective_add(scripts\sp\utility::_id_C264("obj_gotokotch"), "current", &"HEIST_OBJ_GOTOKOTCH");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_gotokotch", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_gotokotch"));
      scripts\engine\utility::flag_wait("obj_dealwithkotch");
      objective_add(scripts\sp\utility::_id_C264("obj_dealwithkotch"), "current", &"HEIST_OBJ_DEALWITHKOTCH");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_dealwithkotch", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_dealwithkotch"));
    case "mons_launch":
      scripts\engine\utility::flag_wait("obj_initiatelaunch");
      objective_add(scripts\sp\utility::_id_C264("obj_initiatelaunch"), "current", &"HEIST_OBJ_INITIATELAUNCH");
      thread scripts\sp\maps\heist\heist_util::flag_waitopen_any("obj_initiatelaunch", scripts\sp\utility::_id_C27C, scripts\sp\utility::_id_C264("obj_initiatelaunch"));
      break;
    case "test_mons_skybox":
      break;
    default:
  }
}

_id_11731() {
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_test_mons_skybox", "targetname"));
}

_id_11730() {
  thread _id_8AC2();
  level waittill("poop");
  scripts\sp\maps\heist\heist_util::_id_96E0();
  var_0 = getEntArray("heist_mons_moving_city_new", "targetname");
  level._id_10291 = var_0[0];
  level._id_10291._id_10CC9 = level._id_10291.origin;
  level._id_10291._id_10B9F = level._id_10291.angles;
  var_1 = (0, 0, 0);
  var_2 = (0, 0, 0);
  var_3 = 1;
  var_4 = 1;

  if(var_4) {
    var_5 = scripts\engine\utility::getStruct("continue_test_mons_skybox", "targetname") scripts\engine\utility::spawn_tag_origin();
    var_5.origin = (var_5.origin[0], var_5.origin[1] + 6000, var_5.origin[2]);
    level._id_10291 linkTo(var_5);

    for(;;) {
      var_5 rotateYaw(90, 30, 0, 0);
      var_5 waittill("rotatedone");
    }
  } else {
    for(;;) {
      var_3 = var_3 * -1;
      var_6 = (0, 0, 0);
      var_7 = (0, 0, 0);
      var_1 = (randomintrange(25000, 50001) * var_3, randomintrange(2500, 5001) * -1, 0);
      var_2 = (randomintrange(2, 4) * var_3, randomintrange(14, 17) * var_3, 1);
      var_6 = level._id_10291._id_10CC9 + var_1;
      var_7 = level._id_10291._id_10B9F + var_2;
      level._id_10291 moveTo(var_6, 60, 7, 3);
      level._id_10291 rotateTo(var_7, 60, 7, 1);
      level._id_8632 rotateTo(var_7 / 2 * -1, 60, 7, 3);
      level._id_10291 waittill("movedone");
      var_8 = randomfloatrange(1.5, 2.0);
      level.player _meth_8291(0.17, 0.17, 0.17, var_8, 0, -1, 0, 15, 15, 15);
      level.player playRumbleOnEntity("light_2s");
      var_1 = (500 * var_3, 500, 0);
      var_2 = (0, 2 * var_3 * -1, 2);
      var_6 = level._id_10291.origin + var_1;
      var_7 = level._id_10291.angles + var_2;
      level._id_10291 moveTo(var_6, 10, 1, 4);
      level._id_10291 rotateTo(var_7, 10, 1, 4);
      level._id_10291 waittill("movedone");
      var_8 = randomfloatrange(1.5, 2.0);
      level.player _meth_8291(0.17, 0.17, 0.17, var_8, 0, -1, 0, 15, 15, 15);
      level.player playRumbleOnEntity("light_2s");
    }
  }

  level waittill("ISaidSo");
}

_id_8AC2(var_0) {
  if(isDefined(var_0) && var_0 == 0) {
    return;
  }
  level._id_10291 = getEntArray("city_pie", "script_noteworthy");
  var_1 = getEnt("test_link", "targetname");
  var_2 = getEnt("city_pie_01", "targetname");
  level._id_10293 = 1;
  var_3 = scripts\engine\utility::getStruct("mons_skybox_rotate", "targetname") scripts\engine\utility::spawn_tag_origin();

  foreach(var_5 in level._id_10291) {
    var_5 linkTo(var_3);
  }

  var_1 linkTo(var_3);
}