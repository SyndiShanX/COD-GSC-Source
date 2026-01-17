/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier.gsc
*****************************************************/

main() {
  carrier_starts();
  maps\_utility::template_level("carrier");
  maps\createart\carrier_art::main();
  maps\carrier_precache::main();
  maps\carrier_fx::main();
  setsaveddvar("r_ssaofadedepth", 1100);
  level.vttype = "silenthawk";
  level.vtmodel = "vehicle_silenthawk";
  level.vtclassname = "script_vehicle_silenthawk_open";
  maps\_vehicle::build_aianims(maps\carrier_anim::set_silenthawk_override_anims, vehicle_scripts\silenthawk::set_vehicle_anims);
  thread maps\carrier_code_zodiac::init_zodiacs();
  thread maps\carrier_code::init_gunboats();
  maps\carrier_anim::main();

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    level.tilt_sky = getent("carrier_tilt_sky", "targetname");
    level.tilt_sky hide();
  }

  if(getdvar("createfx") != "")
    thread create_fx_ent_setup();

  maps\_load::main();
  maps\_dynamic_run_speed::main();
  precache_for_startpoints();
  maps\carrier_audio::main();
  maps\carrier_code::carrier_init();
  maps\_drone_ai::init();
  thread maps\carrier_fx::fx_init();
  thread maps\carrier_scriptlights::main();
  maps\hud_outline_objective::outline_enable();
}

carrier_starts() {
  maps\_utility::default_start(maps\carrier_slow_intro::setup_slow_intro);
  maps\_utility::set_default_start("slow_intro");
  maps\_utility::add_start("slow_intro", maps\carrier_slow_intro::setup_slow_intro, "Slow Intro", maps\carrier_slow_intro::begin_slow_intro, undefined, maps\carrier_slow_intro::catchup_slow_intro);
  maps\_utility::add_start("medbay", maps\carrier_slow_intro::setup_medbay, "Medbay", maps\carrier_slow_intro::begin_medbay, undefined, maps\carrier_slow_intro::catchup_medbay);
  maps\_utility::add_start("deck_combat", maps\carrier_deck_combat::setup_deck_combat, "Deck Combat", maps\carrier_deck_combat::begin_deck_combat, undefined, maps\carrier_deck_combat::catchup_deck_combat);
  maps\_utility::add_start("deck_transition", maps\carrier_deck_transition::setup_deck_transition, "Deck Transition", maps\carrier_deck_transition::begin_deck_transition, undefined, maps\carrier_deck_transition::catchup_deck_transition);
  maps\_utility::add_start("defend_zodiac", maps\carrier_defend_zodiac::setup_defend_zodiac, "Defend Zodiac", maps\carrier_defend_zodiac::begin_defend_zodiac, undefined, maps\carrier_defend_zodiac::catchup_defend_zodiac);
  maps\_utility::add_start("run_to_sparrow", maps\carrier_sparrow_run::setup_run_to_sparrow, "Run To Sparrow", maps\carrier_sparrow_run::begin_run_to_sparrow, undefined, maps\carrier_sparrow_run::catchup_run_to_sparrow);
  maps\_utility::add_start("defend_sparrow", maps\carrier_defend_sparrow::setup_defend_sparrow, "Defend Sparrow", maps\carrier_defend_sparrow::begin_defend_sparrow, undefined, maps\carrier_defend_sparrow::catchup_defend_sparrow);
  maps\_utility::add_start("deck_victory", maps\carrier_deck_victory::setup_deck_victory, "Victory Deck", maps\carrier_deck_victory::begin_deck_victory, undefined, maps\carrier_deck_victory::catchup_deck_victory);
  maps\_utility::add_start("deck_tilt", maps\carrier_deck_tilt::setup_deck_tilt, "Deck Tilt", maps\carrier_deck_tilt::begin_deck_tilt, undefined, maps\carrier_deck_tilt::catchup_deck_tilt);
}

precache_for_startpoints() {
  maps\carrier_slow_intro::slow_intro_pre_load();
  maps\carrier_deck_combat::deck_combat_pre_load();
  maps\carrier_deck_transition::deck_transition_pre_load();
  maps\carrier_defend_zodiac::defend_zodiac_pre_load();
  maps\carrier_sparrow_run::run_to_sparrow_pre_load();
  maps\carrier_defend_sparrow::defend_sparrow_pre_load();
  maps\carrier_deck_victory::deck_victory_pre_load();
  maps\carrier_deck_tilt::deck_tilt_pre_load();
  maps\carrier_code_sparrow::sparrow_init();
  maps\carrier_vista::vista_pre_load();
  obj_flags();
  precachemodel("generic_prop_raven");
  thread post_load();
}

post_load() {
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 9);
  maps\carrier_planes::setup_planes();
  thread maps\carrier_code::clear_deck_props();
  thread maps\carrier_code::move_deck_props();
  thread maps\carrier_code::vista_boats();
}

obj_flags() {
  common_scripts\utility::flag_init("obj_flight_deck_complete");
  common_scripts\utility::flag_init("obj_deck_combat_complete");
  common_scripts\utility::flag_init("obj_regroup_with_hesh_complete");
  common_scripts\utility::flag_init("obj_defend_carrier_complete");
  common_scripts\utility::flag_init("obj_sparrow_complete");
  common_scripts\utility::flag_init("obj_gunship_complete");
  common_scripts\utility::flag_init("obj_exfil_complete");
  precachestring(&"CARRIER_OBJ_FLIGHT_DECK");
  precachestring(&"CARRIER_OBJ_CLEAR_DECK");
  precachestring(&"CARRIER_OBJ_REGROUP_WITH_HESH");
  precachestring(&"CARRIER_OBJ_DEFEND_CARRIER");
  precachestring(&"CARRIER_OBJ_SPARROW");
  precachestring(&"CARRIER_OBJ_GUNSHIP");
  precachestring(&"CARRIER_OBJ_EXFIL");
}

obj_flight_deck() {
  var_0 = 1;
  objective_add(var_0, "active", &"CARRIER_OBJ_FLIGHT_DECK");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_flight_deck_complete");
  objective_state(var_0, "done");
}

obj_clear_deck() {
  var_0 = 2;
  objective_add(var_0, "active", &"CARRIER_OBJ_CLEAR_DECK");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_deck_combat_complete");
  objective_state(var_0, "done");
}

obj_regroup_with_hesh() {
  var_0 = 3;
  objective_add(var_0, "active", &"CARRIER_OBJ_REGROUP_WITH_HESH");
  objective_state(var_0, "current");
  objective_onentity(var_0, level.hesh, (0, 0, 70));
  objective_setpointertextoverride(var_0, &"CARRIER_OBJ_FOLLOW");
  var_1 = getdvar("objectiveFadeTooFar");
  setsaveddvar("objectiveFadeTooFar", 1);
  wait 3;
  setsaveddvar("objectiveFadeTooFar", var_1);
  common_scripts\utility::flag_wait("control_pad_objective");
  objective_position(var_0, (0, 0, 0));
  var_2 = getent("osrpey_control_pad", "targetname");
  objective_onentity(var_0, var_2, (0, 0, 8));
  objective_setpointertextoverride(var_0);
  common_scripts\utility::flag_wait("picked_up_control_pad");
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait("obj_regroup_with_hesh_complete");
  objective_state(var_0, "done");
}

obj_defend_carrier() {
  var_0 = 4;
  objective_add(var_0, "active", &"CARRIER_OBJ_DEFEND_CARRIER");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  wait 1;
  var_1 = common_scripts\utility::getstruct("defend_dot", "targetname");
  objective_position(var_0, var_1.origin);
  objective_setpointertextoverride(var_0, &"CARRIER_OBJ_DEFEND");
  common_scripts\utility::flag_wait_any("defend_zodiac_arrived_catwalk", "gunship_attack");
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait("obj_defend_carrier_complete");
  objective_state(var_0, "done");
}

obj_sparrow() {
  var_0 = 5;
  objective_add(var_0, "active", &"CARRIER_OBJ_SPARROW");
  objective_state(var_0, "current");

  if(!common_scripts\utility::flag("gunship_trans_mid")) {
    objective_onentity(var_0, level.hesh, (0, 0, 70));
    objective_setpointertextoverride(var_0, &"CARRIER_OBJ_FOLLOW");
    var_1 = getdvar("objectiveFadeTooFar");
    setsaveddvar("objectiveFadeTooFar", 1);
    common_scripts\utility::flag_wait("gunship_trans_mid");
    setsaveddvar("objectiveFadeTooFar", var_1);
    wait 1;
    objective_state(var_0, "current");
    objective_setpointertextoverride(var_0);
  } else {
    objective_position(var_0, (1246, 5696, 1418));
    common_scripts\utility::flag_wait("start_knockdown_moment");
  }

  var_2 = getent("defend_sparrow_control", "targetname");
  objective_position(var_0, var_2.origin);
  common_scripts\utility::flag_wait("obj_sparrow_complete");
  objective_state(var_0, "done");
}

obj_gunship() {
  var_0 = 6;
  objective_add(var_0, "active", &"CARRIER_OBJ_GUNSHIP");
  objective_state(var_0, "current");
  var_1 = level.ac_130 common_scripts\utility::spawn_tag_origin();
  var_1 linkto(level.ac_130);
  objective_onentity(var_0, var_1, (0, 0, 840));
  common_scripts\utility::flag_wait("ac_130_hit");
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait("ac130_start_attack_run");
  objective_onentity(var_0, var_1, (0, 0, 840));
  common_scripts\utility::flag_wait("ac_130_hit");
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait("ac130_start_attack_run");
  objective_onentity(var_0, var_1, (0, 0, 840));
  common_scripts\utility::flag_wait("ac_130_hit");
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait("defend_sparrow_finished");
  var_1 delete();
  common_scripts\utility::flag_wait("obj_gunship_complete");
  objective_state(var_0, "done");
}

obj_exfil() {
  var_0 = 7;
  var_1 = getent("exfil_obj_origin", "targetname");
  objective_add(var_0, "active", &"CARRIER_OBJ_EXFIL");
  objective_state(var_0, "current");
  objective_position(var_0, var_1.origin);
  common_scripts\utility::flag_wait("obj_exfil_complete");

  if(common_scripts\utility::flag("player_at_silenthawk"))
    objective_state(var_0, "done");
  else
    objective_state(var_0, "failed");
}

create_fx_ent_setup() {
  wait 2;
  var_0 = getEntArray("deck_intact_odin", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = getent("island_antenna", "targetname");
  var_4.animname = "tilt_tower";
  var_4 maps\_anim::setanimtree();
  var_5 = getent("tower_corner", "targetname");
  var_6 = maps\_utility::spawn_anim_model("tilt_tower_corner");
  var_5 delete();
  var_7 = getEntArray("deck_damaged", "targetname");

  foreach(var_2 in var_7)
  var_2 movez(-4096, 0.05);

  var_10 = getEntArray("deck_clean", "targetname");
  maps\_utility::array_delete(var_10);
  var_11 = getEntArray("stern_corner_clean", "targetname");
  maps\_utility::array_delete(var_11);
  var_12 = getent("carrier_elevator_rear_scripted", "targetname");
  var_12 delete();
  common_scripts\utility::waitframe();
  var_13 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_13 thread maps\_anim::anim_last_frame_solo(var_4, "carrier_deck_tilt_tower_b");
  var_13 thread maps\_anim::anim_last_frame_solo(var_6, "carrier_deck_tilt_island_corner");
  wait 0.25;
  thread maps\carrier_slow_intro::hide_deck_objects();
  level.sliding_jet1 = getEntArray("sliding_jet1", "targetname");
  level.sliding_jet2 = getEntArray("sliding_jet2", "targetname");
  level.sliding_jet3 = getEntArray("sliding_jet3", "targetname");
  level.sliding_jet11 = getEntArray("sliding_jet11", "targetname");
  level.sliding_jet12 = getEntArray("sliding_jet12", "targetname");
  level.sliding_jet20 = getEntArray("sliding_jet20", "targetname");
  common_scripts\utility::array_thread(level.sliding_jet1, maps\_utility::hide_entity);
  common_scripts\utility::array_thread(level.sliding_jet2, maps\_utility::hide_entity);
  common_scripts\utility::array_thread(level.sliding_jet3, maps\_utility::hide_entity);
  common_scripts\utility::array_thread(level.sliding_jet11, maps\_utility::hide_entity);
  common_scripts\utility::array_thread(level.sliding_jet12, maps\_utility::hide_entity);
  common_scripts\utility::array_thread(level.sliding_jet20, maps\_utility::hide_entity);
  var_14 = getent("anim_jet_launcher1", "targetname");
  var_14 hide();
  var_14 = getent("anim_jet_launcher2", "targetname");
  var_14 hide();
  var_15 = getEntArray("intro_static_jets", "targetname");
  common_scripts\utility::array_thread(var_15, maps\_utility::hide_entity);
  var_16 = getent("blast_shield4", "targetname");
  var_17 = getent("blast_shield5", "targetname");
  var_18 = getent("blast_shield6", "targetname");
  var_16 hide();
  var_17 hide();
  var_18 hide();
}