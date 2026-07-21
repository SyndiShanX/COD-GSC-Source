/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown.gsc
***********************************************/

main() {
  level.player_death_override = 1;
  level.civ_cleanup_array = [];
  scripts\engine\sp\utility::set_default_start("buried_start");
  scripts\engine\sp\utility::add_start("buried_start", ::buried_start, "", scripts\sp\maps\hometown\hometown_attack.gsc::buried_main, "buried_only", ::buried_catchup);
  scripts\engine\sp\utility::add_start("carried_start", ::carried_start, "", scripts\sp\maps\hometown\hometown_attack.gsc::carried_main, "main_town_buried_carried", ::carried_catchup);
  scripts\engine\sp\utility::add_start("alley_start", ::alley_start, "", scripts\sp\maps\hometown\hometown_attack.gsc::alley_main, "main_town_boss", ::alley_catchup);
  scripts\engine\sp\utility::add_start("gas_attack_start", ::gas_attack_start, "", scripts\sp\maps\hometown\hometown_attack.gsc::gas_attack_main, "main_town_boss", ::gas_attack_catchup);
  scripts\engine\sp\utility::add_start("house_enter_start", ::house_enter_start, "", scripts\sp\maps\hometown\hometown_house.gsc::house_enter_main, "main_town_boss", ::house_enter_catchup);

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene())
    scripts\engine\sp\utility::add_start("house_boss_start", ::house_boss_start, "", scripts\sp\maps\hometown\hometown_house.gsc::house_boss_main, "main_town_boss", ::house_boss_catchup);

  scripts\engine\sp\utility::add_start("house_exit_start", ::house_exit_start, "", scripts\sp\maps\hometown\hometown_house.gsc::house_exit_main, "main_town_boss", ::house_exit_catchup);
  scripts\engine\sp\utility::add_start("gas_start", ::gas_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::gas_main, "main_town_boss", ::gas_catchup);
  scripts\engine\sp\utility::add_start("gas_mid_start", ::gas_mid_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::gas_mid_main, "main_town_poppies", ::gas_mid_catchup);
  scripts\engine\sp\utility::add_start("gas_exit_start", ::gas_exit_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::gas_exit_main, "main_town_poppies", ::gas_exit_catchup);
  scripts\engine\sp\utility::add_start("poppies_start", ::poppies_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::poppies_main, "main_town_poppies", ::poppies_catchup);
  scripts\engine\sp\utility::add_start("pistol_start", ::pistol_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::pistol_main, "main_town_poppies", ::pistol_catchup);
  scripts\engine\sp\utility::add_start("drive_start", ::drive_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::drive_main, "poppies_bunker", ::drive_catchup);
  scripts\engine\sp\utility::add_start("bunker_start", ::bunker_start, "", scripts\sp\maps\hometown\hometown_escape.gsc::bunker_main, "bunker_only", ::bunker_catchup);
  scripts\sp\maps\hometown\hometown_anim.gsc::main();
  scripts\sp\maps\hometown\gen\hometown_art.gsc::main();
  scripts\sp\maps\hometown\hometown_fx.gsc::main();
  scripts\sp\maps\hometown\hometown_precache.gsc::main();
  scripts\sp\maps\hometown\hometown_vo.gsc::main();
  scripts\sp\maps\hometown\hometown_lighting.gsc::main();
  preload();
  scripts\sp\fakeactor::fakeactor_spawner_init();
  scripts\engine\sp\utility::transient_init("hometown_buried_tr");
  scripts\engine\sp\utility::transient_init("hometown_main_town_tr");
  scripts\engine\sp\utility::transient_init("hometown_main_town_carried_tr");
  scripts\engine\sp\utility::transient_init("hometown_main_town_boss_tr");
  scripts\engine\sp\utility::transient_init("hometown_buried_tr");
  scripts\engine\sp\utility::transient_init("hometown_poppies_tr");
  scripts\engine\sp\utility::transient_init("hometown_periph_tr");
  scripts\engine\sp\utility::transient_init("hometown_bunker_tr");
  hometown_flags();
  setsaveddvar("MQPQKNPQOK", 1);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("OLSKLTPPMR", 0.6);
  setsaveddvar("LQLSPQOPKM", 20);
  setsaveddvar("NQTLPTNSSO", 1);
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 5);
  reactive_foliage();
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  scripts\stealth\clear_regions::init_hunt_regions();
  scripts\engine\sp\utility::add_hint_string("stab_soldier", &"HOMETOWN/STAB_SOLDIER", scripts\sp\player\context_melee::context_melee_hint_break);
  scripts\engine\sp\utility::add_hint_string("stab_soldier_noweap", &"HOMETOWN/FIND_WEAPON_HINT", scripts\sp\player\context_melee::context_melee_hint_break);
  scripts\engine\sp\utility::add_hint_string("stab_soldier_blocked", &"HOMETOWN/STAB_SOLDIER_BLOCKED", scripts\sp\player\context_melee::context_melee_hint_fail);

  if(!getdvarint("context_melee_use_cursor_hint")) {
    scripts\sp\utility::context_melee_set_custom_hint("stab_soldier");
    scripts\sp\utility::context_melee_set_blocked_custom_hint("stab_soldier_blocked");
  } else {
    scripts\sp\utility::context_melee_set_custom_hint(&"HOMETOWN/STAB_SOLDIER_HINT");
    scripts\sp\utility::context_melee_set_blocked_custom_hint(&"HOMETOWN/STAB_SOLDIER_BLOCKED");
  }

  scripts\engine\sp\utility::add_hint_string("cell_hint", &"HOMETOWN/CELL_HINT");
  scripts\engine\sp\utility::add_hint_string("rubble_hint", &"HOMETOWN/RUBBLE_HINT");
  scripts\sp\nvg\nvg_player::main();
  scripts\sp\player\youngfarrah::youngfarrahsetup();
  thread scripts\sp\maps\hometown\hometown_util.gsc::register_farah_deaths();
  var_0 = ["frag"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  thread civ_cleanup_monitor();
  thread hometown_objectives();
  thread hometown_stealth();
  setdvarifuninitialized("scr_pistol_physics_hack_off", 0);
  setdvarifuninitialized("scr_spawn_poppies_gas", 0);
  setdvarifuninitialized("scr_use_procedural_bones", 1);
  setdvarifuninitialized("scr_no_springcam", 0);
  setdvarifuninitialized("scr_no_pistol_mayhem", 0);
  setdvarifuninitialized("scr_no_father_mayhem", 0);
  setdvarifuninitialized("scr_no_buried_link", 0);
  setdvarifuninitialized("greenlight", 0);
  setdvarifuninitialized("greenlight_three_stab", 0);
  setDvar("context_melee_blocked_hints", 0);
  setsaveddvar("MTLLLKROOM", 0);
  level thread scripts\sp\utility::context_melee_enable(0);
  thread helicopters_controller();
  thread trucks_controller();
  thread player_breath_context();
  scripts\engine\sp\utility::disable_trigger_with_noteworthy("house_door_approach_trigger");
  scripts\engine\sp\utility::disable_trigger_with_noteworthy("road_cross_trigger");
  scripts\engine\sp\utility::disable_trigger_with_noteworthy("road_cross_mid_trigger");
  scripts\sp\utility::nvidiaansel_overridecollisionradius(5.0);
}

player_breath_context() {
  wait 5;
  level.player setentitysoundcontext("gender", "child_female");
  level.player setclothtype("cloth");
}

helicopters_controller() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("hometown_helo_alley_close", ::helo_controller_spawn_func_alley_close);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("hometown_helo_alley_far", ::helo_controller_spawn_func_alley_far);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("hometown_helo_poppies_close", ::helo_controller_spawn_func_poppies_close);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("hometown_helo_poppies_far", ::helo_controller_spawn_func_poppies_far);
  thread helo_alley_wait();
  thread helo_poppies_wait();
}

helo_alley_wait() {
  scripts\engine\utility::flag_wait("helo_move_alley");
}

helo_poppies_wait() {
  scripts\engine\utility::flag_wait("helo_move_01");
}

helo_controller_spawn_func_alley_close() {
  self vehicle_turnengineoff();
  self stopsounds();
  scripts\engine\utility::flag_wait("helo_move_alley");
  self playSound("scn_chopper_4_passby_lr");
}

helo_controller_spawn_func_alley_far() {
  self vehicle_turnengineoff();
  self stopsounds();
  scripts\engine\utility::flag_wait("helo_move_alley");
  self playSound("scn_chopper_3_passby_lr");
}

helo_controller_spawn_func_poppies_close() {
  self vehicle_turnengineoff();
  self stopsounds();
  scripts\engine\utility::flag_wait("helo_move_01");
  self playSound("scn_chopper_5_passby_lr");
}

helo_controller_spawn_func_poppies_far() {
  self vehicle_turnengineoff();
  self stopsounds();
  scripts\engine\utility::flag_wait("helo_move_01");
  self playSound("scn_chopper_6_passby_lr");
  level.player clearclienttriggeraudiozone(10.0);
}

trucks_controller() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("poppies_umike_a", ::trucks_controller_spawn_func_poppies_hill_umike);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("poppies_umike_b", ::trucks_controller_spawn_func_poppies_shed_umike);
}

trucks_controller_spawn_func_poppies_hill_umike() {
  self vehicle_turnengineoff();
  self stopsounds();
}

trucks_controller_spawn_func_poppies_hill_pickup() {
  self vehicle_turnengineoff();
  self stopsounds();
  scripts\engine\utility::flag_wait("truckmove01");
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_pair_engine_01");
  wait 9.132;
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_pair_engine_02");
  wait 9.068;
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_pair_engine_03");
}

trucks_controller_spawn_func_poppies_shed_umike() {
  self vehicle_turnengineoff();
  self stopsounds();
  level.shed_umike = self;
  level notify("audio_stop_shed_truck_idle_lp");
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_by_engine_01");
  wait 8.22;
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_by_engine_02");
  wait 8.947;
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_by_engine_03");
  wait 9.635;
  thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_by_engine_04");
}

hometown_flags() {
  scripts\engine\utility::flag_init("objective_attract_help");
  scripts\engine\utility::flag_init("objective_escape_rubble_complete");
  scripts\engine\utility::flag_init("objective_get_to_hadir");
  scripts\engine\utility::flag_init("objective_entered_house_complete");
  scripts\engine\utility::flag_init("objective_prepare_to_escape");
  scripts\engine\utility::flag_init("russian_entered_house");
  scripts\engine\utility::flag_init("russian_entered_house_objective");
  scripts\engine\utility::flag_init("objective_find_a_weapon");
  scripts\engine\utility::flag_init("objective_kill_the_soldier");
  scripts\engine\utility::flag_init("objective_get_gas_mask");
  scripts\engine\utility::flag_init("objective_leave_the_house");
  scripts\engine\utility::flag_init("objective_escape_the_gas");
  scripts\engine\utility::flag_init("objective_find_a_way_out_of_town");
  scripts\engine\utility::flag_init("objective_get_the_pistol");
  scripts\engine\utility::flag_init("objective_shoot_the_soldiers");
  scripts\engine\utility::flag_init("objective_steal_the_vehicle");
  scripts\engine\utility::flag_init("objectives_ready");
  scripts\engine\utility::flag_init("alley_pre_start_passed");
  scripts\engine\utility::flag_init("alley_start_passed");
  scripts\engine\utility::flag_init("alley_mid_passed");
  scripts\engine\utility::flag_init("alley_attack_start_passed");
  scripts\engine\utility::flag_init("audio_stop_air_raid_siren");
  scripts\engine\utility::flag_init("player_went_to_kitchen");
  scripts\engine\utility::flag_init("player_went_to_foyer");
  scripts\engine\utility::flag_init("player_found_a_weapon");
  scripts\engine\utility::flag_init("tried_to_get_gun");
  scripts\engine\utility::flag_init("got_gas_mask_from_boss");
  scripts\engine\utility::flag_init("patrol_cover_blown");
  scripts\engine\utility::flag_init("road_cross_flag");
  scripts\engine\utility::flag_init("road_cross_mid_flag");
  scripts\engine\utility::flag_init("playground_pre_flag");
  scripts\engine\utility::flag_init("playground_pipe_exit_flag");
  scripts\engine\utility::flag_init("playground_mid_flag");
  scripts\engine\utility::flag_init("playground_gate_flag");
  scripts\engine\utility::flag_init("cars_street_start_flag");
  scripts\engine\utility::flag_init("cars_flank_mid_flag");
  scripts\engine\utility::flag_init("town_exit_gate_start_flag");
  scripts\engine\utility::flag_init("town_exit_alley_mid_flag");
  scripts\engine\utility::flag_init("gas_last_building_enter_pre_flag");
  scripts\engine\utility::flag_init("gas_last_building_enter_flag");
  scripts\engine\utility::flag_init("village_exit_flag");
  scripts\engine\utility::flag_init("enemy_picked_up_pistol");
  scripts\engine\utility::flag_init("execution_a_flag");
  scripts\engine\utility::flag_init("lantern_break");
  scripts\engine\utility::flag_init("lantern_smoke");
  scripts\engine\utility::flag_init("straggler_start");
  scripts\engine\utility::flag_init("gas_mask_remove_flag");
  scripts\engine\utility::flag_init("safe_for_hadir_to_progress");
  scripts\engine\utility::flag_init("objective_return_to_base");
  scripts\engine\utility::flag_init("goliath_weapon_exists");
  scripts\engine\utility::flag_init("goliath_weapon_exists_hint");
  scripts\engine\utility::flag_init("lantern_spawned");
  scripts\engine\utility::flag_init("tried_to_get_gun_hadir_anim_done");
}

hometown_objectives() {
  scripts\engine\utility::flag_set("objectives_ready");
  wait 1.5;
  scripts\engine\utility::flag_wait("objective_attract_help");

  if(isDefined(level.buried_rebar_model))
    var_0 = level.buried_rebar_model;
  else
    var_0 = scripts\engine\utility::getStruct("escape_rubble_objective", "script_noteworthy");

  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1.origin = var_1.origin + (-1, 0, 0);
  scripts\engine\sp\objectives::objective_add("hometown_objective", "current", var_1.origin, &"HOMETOWN/ATTRACT_HELP", &"HOMETOWN/BRICK");
  scripts\engine\utility::flag_wait("objective_escape_rubble_complete");
  var_2 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_2.origin, &"HOMETOWN/GET_TO_HADIR", &"HOMETOWN/FARAHS_HOUSE");
  scripts\engine\utility::flag_wait("objective_get_to_hadir");
  var_2 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_2.origin, &"HOMETOWN/GET_TO_HADIR", &"HOMETOWN/FARAHS_HOUSE");
  scripts\engine\utility::flag_wait("objective_entered_house_complete");

  if(!isDefined(level.farah_father_ai)) {
    var_3 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
    var_4 = var_3.origin;
  } else
    var_4 = level.farah_father_ai;

  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/PREPARE_TO_ESCAPE", &"HOMETOWN/FATHER");

  if(isvector(var_4))
    scripts\engine\sp\objectives::objective_set_position("hometown_objective", var_4);
  else
    scripts\engine\sp\objectives::objective_set_on_entity("hometown_objective", "dad", var_4);

  scripts\engine\sp\objectives::objective_set_z_offset("hometown_objective", 72);
  scripts\engine\utility::flag_wait("russian_entered_house_objective");

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    if(!isDefined(level.hadir_melee_weapon_pickup)) {
      var_5 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
      var_6 = var_5.origin;
    } else
      var_6 = level.hadir_melee_weapon_pickup;

    scripts\engine\sp\objectives::objective_remove_all_locations("hometown_objective");
    scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/HIDE_FROM_THE_SOLDIER");
    scripts\engine\utility::flag_wait("goliath_weapon_exists");
    scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/FIND_WEAPON");
    scripts\engine\utility::flag_wait("objective_kill_the_soldier");

    if(!isDefined(level.goliath_ai)) {
      var_7 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
      var_8 = var_7.origin;
    } else
      var_8 = level.goliath_ai;

    scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/ATTACK_THE_SOLDIER");
  }

  scripts\engine\utility::flag_wait("objective_get_gas_mask");

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {}

  if(!isDefined(level.goliath_body_model)) {
    var_7 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
    var_8 = var_7.origin;
  } else
    var_8 = level.goliath_body_model;

  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/SEARCH_BODY", &"HOMETOWN/BODY");

  if(isvector(var_8))
    scripts\engine\sp\objectives::objective_set_position("hometown_objective", var_8);
  else
    scripts\engine\sp\objectives::objective_set_on_entity("hometown_objective", "goliath", var_8);

  scripts\engine\sp\objectives::objective_set_z_offset("hometown_objective", 15);
  scripts\engine\utility::flag_wait("objective_leave_the_house");
  var_9 = scripts\engine\utility::getStruct("hadir_house_objective", "script_noteworthy");
  scripts\engine\sp\objectives::objective_remove_all_locations("hometown_objective");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_9.origin, &"HOMETOWN/GET_OUTSIDE", &"HOMETOWN/FRONT_DOOR");
  scripts\engine\utility::flag_wait("objective_escape_the_gas");
  var_10 = scripts\engine\utility::getStruct("escape_village_objective", "script_noteworthy");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_10.origin, &"HOMETOWN/ESCAPE_THE_GAS", &"HOMETOWN/ESCAPE");
  scripts\engine\utility::flag_wait("objective_find_a_way_out_of_town");
  var_11 = scripts\engine\utility::getStruct("get_to_car_objective_high", "script_noteworthy");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_11.origin, &"HOMETOWN/OUT_OF_TOWN", &"HOMETOWN/ROAD");
  scripts\engine\utility::flag_wait("objective_get_the_pistol");

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    var_12 = getEnt("farah_pistol_pickup", "script_noteworthy");
    scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/GET_THE_PISTOL", &"HOMETOWN/REVOLVER");
    scripts\engine\sp\objectives::objective_add_location_entity("hometown_objective", "pistol", var_12);
    scripts\engine\utility::flag_wait("objective_shoot_the_soldiers");
    scripts\engine\sp\objectives::objective_remove_all_locations("hometown_objective");
    var_13 = scripts\engine\utility::getStruct("get_to_car_objective_high", "script_noteworthy");
    scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/KILL_THE_SOLDIERS", &"HOMETOWN/SOLDIERS");
  }

  scripts\engine\utility::flag_wait("objective_steal_the_vehicle");

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {}

  var_14 = scripts\engine\utility::getStruct("get_to_car_objective_high", "script_noteworthy");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", var_14.origin, &"HOMETOWN/STEAL_THE_VEHICLE", &"HOMETOWN/ESCAPE");
  scripts\engine\utility::flag_wait("objective_return_to_base");
  scripts\engine\sp\objectives::objective_update("hometown_objective", "current", undefined, &"HOMETOWN/RETURN_TO_BASE");
  scripts\engine\sp\objectives::objective_remove_all_locations("hometown_objective");
}

hometown_stealth() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  level.stealth.proximity_combat_radius_fake_sight = 40;
  level.stealth.proximity_combat_radius_sight = 80;
}

reactive_foliage() {
  setsaveddvar("MKPPNSLNQQ", 30);
  setsaveddvar("MPLOLNMSRO", 20);
  setsaveddvar("NSKKMRPOQQ", 40);
  setsaveddvar("NKOSNKPNKL", 8);
}

buried_start() {
  level.player setclienttriggeraudiozone("ht_rubble_start", 0.05);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("buried_start", [level.player]);
  scripts\engine\utility::flag_set("lighting_buried_start");
}

buried_catchup() {
  level.player thread scripts\sp\maps\hometown\hometown_util.gsc::weapon_monitor();
  thread scripts\engine\utility::exploder("burried_sun");
}

carried_start() {
  setomnvar("ui_hide_hud", 1);
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("buried_start", [level.player]);
  thread scripts\sp\maps\hometown\hometown_attack.gsc::sfx_intro_chaos();
  var_0 = getEnt("buried_org", "script_noteworthy");
  var_1 = getEnt("carried_org", "script_noteworthy");
  level.rail_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var_0.origin, var_0.angles);
  level.buried_rubble_01_model = scripts\engine\sp\utility::spawn_anim_model("buried_rubble_01", var_0.origin, var_0.angles);
  level.buried_rubble_02_model = scripts\engine\sp\utility::spawn_anim_model("buried_rubble_02", var_0.origin, var_0.angles);
  level.buried_rubble_03_model = scripts\engine\sp\utility::spawn_anim_model("buried_rubble_03", var_0.origin, var_0.angles);
  level.buried_rubble_04_model = scripts\engine\sp\utility::spawn_anim_model("buried_rubble_04", var_0.origin, var_0.angles);
  level.farah_mother_model = scripts\engine\sp\utility::spawn_anim_model("farah_mother", var_0.origin, var_0.angles);
  level.farah_mother_model setModel("body_civ_syrkistan_female_1_1");
  level.farah_mother_model attach("head_sc_f_eghbali_civ_bloody");
  level.farah_mother_model.fakeactor_face_anim = 1;
  level.farah_mother_model.animationarchetype = "soldier";
  level.farah_sister_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("farah_sister", var_0, 1);
  thread scripts\sp\maps\hometown\hometown_attack.gsc::buried_rubble_setup();
  level.kargorgis_wh01_model = var_1 scripts\sp\maps\hometown\hometown_util.gsc::spawn_dude_play_anim_and_delete("white_helmet_1", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_2", "head_sc_m_kargorgis_civ_helmet_bg_dust", "white_helemets_go");
  level.ahmadzai_wh02_model = var_1 scripts\sp\maps\hometown\hometown_util.gsc::spawn_dude_play_anim_and_delete("white_helmet_2", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_1", "head_sc_m_ahmadzai_civ_helmet_bg_dust", "white_helemets_go");
  level.yurteri_wh03_model = var_1 scripts\sp\maps\hometown\hometown_util.gsc::spawn_dude_play_anim_and_delete("white_helmet_3", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_3", "head_sc_m_yurteri_civ_helmet_bg_dust", "white_helemets_go");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("lighting_carried_start");
  level.player scripts\common\utility::allow_cinematic_motion(0);
}

carried_catchup() {
  level.player thread scripts\sp\maps\hometown\hometown_util.gsc::weapon_monitor();
  scripts\engine\utility::stop_exploder("burried_sun");
}

alley_start() {
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("alley_start", [level.player]);
  setmusicstate("mx_hometown_02_alley_lp");
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_father();
  thread scripts\sp\maps\hometown\hometown_attack.gsc::audio_dist_shootings();
  var_0 = scripts\engine\utility::getStruct("alley_father_start", "script_noteworthy");
  level.farah_father_ai forceteleport(var_0.origin, var_0.angles);
  var_1 = getEnt("alley_scenes_node", "script_noteworthy");
  var_1 thread scripts\sp\maps\hometown\hometown_attack.gsc::alley_looped_anims();
  thread scripts\sp\maps\hometown\hometown_attack.gsc::alley_triggers_monitor();
  thread scripts\sp\maps\hometown\hometown_attack.gsc::gas_attack_triggers_monitor();
  scripts\engine\utility::flag_set("lighting_alley_start");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
}

alley_catchup() {
  level notify("rail_started");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::stop_exploder("burried_sun");
}

gas_attack_start() {
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("gas_attack_start", [level.player]);
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_father();
  var_0 = scripts\engine\utility::getStruct("gas_attack_father_start", "script_noteworthy");
  level.farah_father_ai forceteleport(var_0.origin, var_0.angles);
  var_1 = getEnt("alley_scenes_node", "script_noteworthy");
  var_1 thread scripts\sp\maps\hometown\hometown_attack.gsc::alley_looped_anims();
  thread scripts\sp\maps\hometown\hometown_attack.gsc::alley_triggers_monitor();
  thread scripts\sp\maps\hometown\hometown_attack.gsc::gas_attack_triggers_monitor();
  scripts\engine\utility::flag_set("lighting_gas_attack_start");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\sp\maps\hometown\hometown_attack.gsc::alley_setup();
  var_2 = getnode("gas_attack_steet_mid_node", "targetname");
  level.farah_father_ai setgoalnode(var_2);
  level.gas_attack_left_anim_node notify("stop_loop");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_last_frame_solo(level.gasattack_ambulance_truck_model, "gasattack_intro");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh01_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh02_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh03_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ01_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ02_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ03_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ04_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ05_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ06_model, "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ07_model, "gasattack_idle");
  thread scripts\sp\maps\hometown\hometown_attack.gsc::post_alley_scene();
}

gas_attack_catchup() {
  level notify("rail_started");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::stop_exploder("burried_sun");
}

house_enter_start() {
  level.house_intro_deadbolt_model = getEnt("boss_house_deadbolt", "script_noteworthy");
  level.house_intro_deadbolt_model.animname = "house_intro_deadbolt";
  level.house_intro_deadbolt_model scripts\engine\sp\utility::assign_animtree("house_intro_deadbolt");
  level.door_clip_boss_enter = getEnt("house_door_clip_boss_enter", "script_noteworthy");
  level.door_clip_boss_enter notsolid();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("house_enter_start", [level.player]);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_attack.gsc::spawn_door_model();
  scripts\engine\utility::flag_set("lighting_house_enter_start");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_father();
  thread gas_victims_start_loops();
  level.player scripts\common\utility::allow_melee(0);
  var_0 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_0 scripts\engine\sp\utility::hide_entity();
  var_1 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_1 scripts\engine\sp\utility::hide_entity();
}

house_enter_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
}

house_boss_start() {
  level.house_intro_deadbolt_model = getEnt("boss_house_deadbolt", "script_noteworthy");
  level.house_intro_deadbolt_model.animname = "house_intro_deadbolt";
  level.house_intro_deadbolt_model scripts\engine\sp\utility::assign_animtree("house_intro_deadbolt");
  level.door_clip_boss_enter = getEnt("house_door_clip_boss_enter", "script_noteworthy");
  level.dad_phone_blocker = getEnt("dad_phone_blocker", "script_noteworthy");
  level.dad_phone_blocker scripts\engine\sp\utility::hide_entity();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  thread scripts\engine\utility::exploder("window_gas");
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_stab_model_swap_monitor();
  scripts\engine\sp\utility::set_start_location("house_boss_start", [level.player]);
  visionsetnaked("hometown_house_int_postfire", 0.0);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_attack.gsc::spawn_door_model();
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_goliath_boss();
  scripts\sp\maps\hometown\hometown_util.gsc::goliath_bloody_footsteps();
  level.hadir_body_model = scripts\engine\sp\utility::spawn_anim_model("hadir_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread scripts\sp\maps\hometown\hometown_house.gsc::hadir_procedural_bones();
  level.hadir_body_model attach("head_sc_m_coto");
  level.hadir_body_model.fakeactor_face_anim = 1;
  level.hadir_body_model.animationarchetype = "soldier";
  level.hadir_body_model hide();
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_father();
  var_0 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_0 scripts\engine\sp\utility::hide_entity();
  var_1 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_1 scripts\engine\sp\utility::hide_entity();
  var_2 = scripts\engine\sp\utility::spawn_anim_model("house_intro_pack", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_3 = scripts\engine\sp\utility::spawn_anim_model("house_intro_lantern", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_2, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_3, "house_dad_dies");
  level thread scripts\sp\maps\hometown\hometown_house.gsc::lantern_fire(var_3);
  scripts\engine\utility::flag_set("lantern_break");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("lighting_house_boss_start");
  level.goliath_melee_weapon_spawn_count = 0;
  level.player thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_player_death_monitor();
  level thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_round_monitor();
  level thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_knife_monitor();
  level thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_player_location_monitor();
  level thread scripts\sp\maps\hometown\hometown_house.gsc::goliath_struggle();
  thread gas_victims_start_loops();
  var_4 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard_b", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("house_intro_dresser", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_7 = scripts\engine\sp\utility::spawn_anim_model("house_intro_hutch", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_6, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_7, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_4, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_5, "house_get_mask_kitchen");
  level.dead_dad_blocker = getEnt("dead_dad_blocker", "script_noteworthy");
  level.dead_dad_blocker_hadir = getEnt("dead_dad_blocker_hadir", "script_noteworthy");
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::hide_entity();
  level.dead_boss_blocker = getEnt("dead_boss_blocker", "script_noteworthy");
  level.dead_boss_blocker scripts\engine\sp\utility::hide_entity();
  level.dead_boss_blocker_use = getEnt("dead_boss_blocker_use", "script_noteworthy");
  level.dead_boss_blocker_use scripts\engine\sp\utility::hide_entity();
  thread scripts\sp\maps\hometown\hometown_vo.gsc::farah_idle_hide_hints();
}

house_boss_catchup() {
  level notify("house_entered");
  scripts\engine\utility::stop_exploder("burried_sun");
}

house_exit_start() {
  level.house_intro_deadbolt_model = getEnt("boss_house_deadbolt", "script_noteworthy");
  level.house_intro_deadbolt_model.animname = "house_intro_deadbolt";
  level.house_intro_deadbolt_model scripts\engine\sp\utility::assign_animtree("house_intro_deadbolt");
  level.door_clip_boss_enter = getEnt("house_door_clip_boss_enter", "script_noteworthy");
  level.dad_phone_blocker = getEnt("dad_phone_blocker", "script_noteworthy");
  level.dad_phone_blocker scripts\engine\sp\utility::hide_entity();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  thread scripts\engine\utility::exploder("window_gas");
  level.current_knife_weapon_string = "iw8_knife_kid_screwdriver";
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("house_exit_start", [level.player]);
  visionsetnaked("hometown_house_int", 0.0);
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_attack.gsc::spawn_door_model();
  var_1 = scripts\engine\utility::getStructArray("boss_struggle_loc_" + level.player scripts\sp\maps\hometown\hometown_house.gsc::get_current_house_room(), "script_noteworthy");
  level.boss_struggle_anim_node = scripts\engine\utility::random(var_1);
  level.boss_struggle_anim_node_safe = level.boss_struggle_anim_node;
  level.father_body_model = scripts\engine\sp\utility::spawn_anim_model("farah_father_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread scripts\sp\maps\hometown\hometown_house.gsc::dad_procedural_bones();
  level.father_body_model attach("head_hero_farahs_father");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.father_body_model, "house_dad_dead_frame");
  var_2 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_2 scripts\engine\sp\utility::hide_entity();
  var_3 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_3 scripts\engine\sp\utility::hide_entity();
  var_4 = scripts\engine\sp\utility::spawn_anim_model("house_intro_pack", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("house_intro_lantern", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_4, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_5, "house_dad_dies");
  level thread scripts\sp\maps\hometown\hometown_house.gsc::lantern_fire(var_5);
  scripts\engine\utility::flag_set("lantern_break");
  scripts\engine\utility::flag_set("lantern_smoke");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("lighting_house_exit_start");
  thread gas_victims_start_loops();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  level.boss_kill_sling_model = scripts\engine\sp\utility::spawn_anim_model("boss_kill_sling", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_7 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard_b", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_8 = scripts\engine\sp\utility::spawn_anim_model("house_intro_dresser", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_9 = scripts\engine\sp\utility::spawn_anim_model("house_intro_hutch", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_8, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_9, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_6, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_7, "house_get_mask_kitchen");
  level.hadir_ai attach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
  level.get_mask_anim_node = level.boss_struggle_anim_node;
  level.gas_mask_from_boss_model_pre = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_boss", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  thread lastframe_boss_mask();
  level.dead_dad_blocker = getEnt("dead_dad_blocker", "script_noteworthy");
  level.dead_dad_blocker_hadir = getEnt("dead_dad_blocker_hadir", "script_noteworthy");
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::hide_entity();
  level.dead_boss_blocker = getEnt("dead_boss_blocker", "script_noteworthy");
  level.dead_boss_blocker_use = getEnt("dead_boss_blocker_use", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_util.gsc::boss_blocker();
}

lastframe_boss_mask() {
  waitframe();
  level.gas_mask_from_boss_model_pre thread scripts\common\anim::anim_first_frame_solo(level.gas_mask_from_boss_model_pre, "try_get_gun_scene");
}

house_exit_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
  thread scripts\engine\utility::exploder("gasgrenadeplayground");
  scripts\engine\utility::stop_exploder("ceilingsmoke");
}

gas_start() {
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("gas_start", [level.player]);
  thread scripts\engine\utility::exploder("gas_cam_01");
  setaudiotriggerstate("gas_outsidehouse", "gasthrown", 1.0);
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 = scripts\engine\utility::getStruct("hadir_gas_start", "script_noteworthy");
  level.hadir_ai forceteleport(var_1.origin, var_1.angles);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  thread gas_victims_start_loops();
  var_2 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_2 scripts\engine\sp\utility::hide_entity();
  var_3 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_3 scripts\engine\sp\utility::hide_entity();
  scripts\sp\maps\hometown\hometown_attack.gsc::kill_chickens();
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("lighting_gas_start");
  thread scripts\sp\maps\hometown\hometown_house.gsc::player_putgasmaskon();
  level.hadir_ai attach("hat_child_hadir_gas_mask");
  wait 1;
  visionsetnaked("", 0.0);
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
}

gas_victims_start_loops() {
  level.gas_attack_left_anim_node = scripts\engine\utility::getStruct("gas_attack_from_left_node", "script_noteworthy");
  var_0 = scripts\engine\sp\utility::spawn_anim_model("gasattack_ambulance_truck", level.gas_attack_left_anim_node.origin, level.gas_attack_left_anim_node.angles);
  var_1 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_wh("gasattack_wh01", level.gas_attack_left_anim_node, 1);
  var_2 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_wh("gasattack_wh02", level.gas_attack_left_anim_node, 1);
  var_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_wh("gasattack_wh03", level.gas_attack_left_anim_node, 1);
  var_4 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("gasattack_civ01", level.gas_attack_left_anim_node, 1);
  var_5 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("gasattack_civ02", level.gas_attack_left_anim_node, 1);
  var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gasattack_civ03", level.gas_attack_left_anim_node, 1);
  var_7 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gasattack_civ04", level.gas_attack_left_anim_node, 1);
  var_8 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gasattack_civ05", level.gas_attack_left_anim_node, 1);
  var_9 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gasattack_civ06", level.gas_attack_left_anim_node, 1);
  var_10 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("gasattack_civ07", level.gas_attack_left_anim_node, 1);
  var_11 = scripts\engine\sp\utility::spawn_anim_model("gasattack_enemy_truck_02", level.gas_attack_left_anim_node.origin, level.gas_attack_left_anim_node.angles);
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_first_frame_solo(var_0, "gasattack_intro");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_1, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_2, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_3, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_4, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_5, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_6, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_7, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_8, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_9, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(var_10, "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_first_frame_solo(var_11, "gasattack_attack");
}

gas_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
  thread scripts\engine\utility::exploder("gasgrenadeplayground");
  thread scripts\engine\utility::exploder("gas_cam_01");

  if(isDefined(level.hadir_ai))
    level.hadir_ai thread scripts\sp\maps\hometown\hometown_util.gsc::stayahead_turbo_check();
}

gas_mid_start() {
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  level.playground_anim_node = scripts\engine\utility::getStruct("playground_exit_anim_node", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  scripts\engine\sp\utility::set_start_location("gas_mid_start", [level.player]);
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  setaudiotriggerstate("gas_outsidehouse", "gasthrown", 1.0);
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 = scripts\engine\utility::getStruct("hadir_gas_start", "script_noteworthy");
  level.hadir_ai forceteleport(var_1.origin, var_1.angles);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  thread gas_victims_start_loops();
  var_2 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_2 scripts\engine\sp\utility::hide_entity();
  var_3 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_3 scripts\engine\sp\utility::hide_entity();
  scripts\sp\maps\hometown\hometown_attack.gsc::kill_chickens();
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("lighting_gas_mid_start");
  visionsetnaked("hometown_gas_close_mid", 0.0);
  thread scripts\sp\maps\hometown\hometown_house.gsc::player_putgasmaskon();
  level.hadir_ai attach("hat_child_hadir_gas_mask");
  scripts\sp\maps\hometown\hometown_escape.gsc::gas_main_setup(1);
  wait 1;
  visionsetnaked("", 0.0);
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
}

gas_mid_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
  thread scripts\engine\utility::exploder("gasgrenadeplayground");
  thread scripts\engine\utility::exploder("gas_cam_01");
}

gas_exit_start() {
  thread scripts\sp\maps\hometown\hometown_util.gsc::gas_cover_blown_monitor();
  scripts\engine\sp\utility::set_start_location("gas_exit_start", [level.player]);
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_square();
  thread scripts\sp\maps\hometown\hometown_util.gsc::buried_kill_trigger();
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  setaudiotriggerstate("gas_outsidehouse", "gasthrown", 1.0);
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 = getnode("hadir_exit_gas_start", "script_noteworthy");
  level.hadir_ai forceteleport(var_1.origin, var_1.angles);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  thread gas_victims_start_loops();
  var_2 = getEnt("pre_boss_house_gate", "script_noteworthy");
  var_2 scripts\engine\sp\utility::hide_entity();
  var_3 = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  var_3 scripts\engine\sp\utility::hide_entity();
  scripts\sp\maps\hometown\hometown_attack.gsc::kill_chickens();
  scripts\engine\utility::stop_exploder("gas_cam_01");
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("lighting_gas_exit_start");
  visionsetnaked("hometown_gas_close_less", 0.0);
  thread scripts\sp\maps\hometown\hometown_house.gsc::player_putgasmaskon();
  level.hadir_ai attach("hat_child_hadir_gas_mask");
  scripts\sp\maps\hometown\hometown_escape.gsc::gas_main_setup(1);
  var_4 = getnode("hadir_exit_gas_start", "script_noteworthy");
  level.hadir_ai setgoalnode(var_4);
  wait 1;
  visionsetnaked("", 0.0);
  thread scripts\sp\maps\hometown\hometown_escape.gsc::hadir_move_speed_gas_exit(1);
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
}

gas_exit_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
  thread scripts\engine\utility::exploder("gasgrenadeplayground");
  scripts\engine\utility::stop_exploder("gas_cam_01");
}

poppies_start() {
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("poppies_start", [level.player]);
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.hadir_ai attach("hat_child_hadir_gas_mask");
  var_1 = scripts\engine\utility::getStruct("hadir_poppies_start", "script_noteworthy");
  level.hadir_ai forceteleport(var_1.origin, var_1.angles);
  thread scripts\sp\maps\hometown\hometown_house.gsc::player_putgasmaskon();
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("objective_escape_the_gas");
  scripts\engine\utility::flag_set("lighting_poppies_start");
  thread scripts\sp\maps\hometown\hometown_escape.gsc::hadir_move_speed_gas_exit(1);
  thread scripts\sp\maps\hometown\hometown_escape.gsc::hadir_beckon_loop();
  thread hadir_poppies_start_anim();
  level.hadir_ai setModel("body_hero_hadir_child_bloody");

  if(getdvarint("scr_spawn_poppies_gas"))
    thread scripts\engine\utility::exploder("adir_gas");

  level.player setsuit("iw8_kid_slow_sprint");
  level.gas_window_blocker = getEnt("gas_window_blocker", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_escape.gsc::delete_window_blocker();
}

poppies_catchup() {
  scripts\engine\utility::stop_exploder("burried_sun");
  scripts\engine\utility::stop_exploder("gas_cam_01");
}

pistol_start() {
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("pistol_start", [level.player]);
  setaudiotriggerstate("gas_outsidehouse", "", 1.0);
  setmusicstate("mx_hometown_17_poppies_execution");
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 = scripts\engine\utility::getStruct("hadir_pistol_start", "script_noteworthy");
  level.hadir_ai forceteleport(var_1.origin, var_1.angles);
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("objective_escape_the_gas");
  scripts\engine\utility::flag_set("objective_find_a_way_out_of_town");
  scripts\engine\utility::flag_set("lighting_pistol_start");
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
  level.player setsuit("iw8_kid_slow_sprint");
}

pistol_catchup() {
  level notify("poppies_start");
  scripts\engine\utility::stop_exploder("burried_sun");
  scripts\engine\utility::stop_exploder("gas_cam_01");
}

drive_start() {
  thread melee_setup();
  scripts\engine\sp\utility::set_start_location("drive_start", [level.player]);
  setaudiotriggerstate("gas_outsidehouse", "", 1.0);
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 = getEnt("end_russian_truck", "script_noteworthy");
  var_1 delete();
  level.pistol_intro_anim_node = scripts\engine\utility::getStruct("pistol_intro_anim_node", "script_noteworthy");
  level.phone_kid_idle_child01_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child01", level.pistol_intro_anim_node);
  level.phone_kid_idle_child02_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child02", level.pistol_intro_anim_node);
  level.phone_kid_idle_child03_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child03", level.pistol_intro_anim_node);
  level.phone_kid_idle_cage02_model = scripts\engine\sp\utility::spawn_anim_model("phone_kid_idle_cage02", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  level.end_russian_truck_model = scripts\engine\sp\utility::spawn_anim_model("end_russian_truck", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("objective_escape_the_gas");
  scripts\engine\utility::flag_set("objective_find_a_way_out_of_town");
  scripts\engine\utility::flag_set("objective_get_the_pistol");
  scripts\engine\utility::flag_set("objective_shoot_the_soldiers");
  scripts\engine\utility::flag_set("objective_steal_the_vehicle");
  scripts\engine\utility::flag_set("lighting_drive_start");
  level.pistol_intro_anim_node = scripts\engine\utility::getStruct("pistol_intro_anim_node", "script_noteworthy");
  level.pistol_intro_anim_node_truck = scripts\engine\utility::getStruct("pistol_intro_anim_node_truck", "script_noteworthy");
  level.pistol_intro_anim_node_truck01 = scripts\engine\utility::getStruct("pistol_intro_anim_node_truck01", "script_noteworthy");
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
}

drive_catchup() {}

bunker_start() {
  scripts\engine\sp\utility::set_start_location("bunker_start", [level.player]);
  setaudiotriggerstate("gas_outsidehouse", "", 1.0);
  scripts\engine\utility::flag_set("objective_attract_help");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  scripts\engine\utility::flag_set("russian_entered_house");
  scripts\engine\utility::flag_set("russian_entered_house_objective");
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  scripts\engine\utility::flag_set("objective_find_a_weapon");
  scripts\engine\utility::flag_set("objective_kill_the_soldier");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  scripts\engine\utility::flag_set("objective_escape_the_gas");
  scripts\engine\utility::flag_set("objective_find_a_way_out_of_town");
  scripts\engine\utility::flag_set("objective_get_the_pistol");
  scripts\engine\utility::flag_set("objective_shoot_the_soldiers");
  scripts\engine\utility::flag_set("objective_steal_the_vehicle");
  scripts\engine\utility::flag_set("lighting_bunker_start");
  scripts\engine\utility::flag_set("objective_return_to_base");
  level.bunker_gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_russian", 1.0);
  level.bunker_gas_mask_overlay.lowresbackground = 1;
  level.bunker_gas_mask_overlay.sort = 0;
  level.bunkerblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  level.bunkerblackoverlay.lowresbackground = 1;
  level.bunkerblackoverlay.sort = 1;
}

bunker_catchup() {}

melee_setup() {}

preload() {
  scripts\sp\player\youngfarrah::youngfarrahprecache();
  precachemodel("weapon_vm_me_screwdriver");
  precachemodel("weapon_vm_me_scissors");
  precachemodel("weapon_vm_me_kitchen_knife");
  precachemodel("weapon_wm_me_screwdriver");
  precachemodel("weapon_wm_me_scissors");
  precachemodel("weapon_wm_me_kitchen_knife");
  precachemodel("weapon_vm_me_screwdriver_bloody");
  precachemodel("weapon_vm_me_scissors_bloody");
  precachemodel("weapon_vm_me_kitchen_knife_bloody");
  precachemodel("weapon_wm_me_screwdriver_bloody");
  precachemodel("weapon_wm_me_scissors_bloody");
  precachemodel("weapon_wm_me_kitchen_knife_bloody");
  precachemodel("attachment_wm_receiver_akilo47");
  precachemodel("attachment_wm_reflex_west01");
  precachemodel("attachment_wm_smgbarrel_akilo47");
  precachemodel("attachment_wm_smgmag_akilo47");
  precachemodel("attachment_wm_tac_light");
  precachemodel("attachment_wm_vertgrip_stubby01");
  precachemodel("hat_child_hadir_gas_mask_wm");
  precachemodel("veh8_mil_air_suniform25");
  precachemodel("equipment_dyn_folding_backboard_stretcher");
  precacheshader("gasmask_overlay_russian");
  precachemodel("prop_gasmask_russian_soldier_boss");
  precachestring(&"HOMETOWN/HIDE_FROM_SOLDIER_HINT");
  precachestring(&"HOMETOWN/BOSS_HIDE_HINT");
  precachestring(&"HOMETOWN/FIND_WEAPON_HINT");
  precachestring(&"HOMETOWN/BOSS_NEW_WEAPON_DEATH");
  precachestring(&"HOMETOWN/GAS_ATTACK_DEATH");
  precachestring(&"HOMETOWN/ALREADY_HAVE_WEAPON");
  precachestring(&"HOMETOWN/FIRE_PISTOL");
  scripts\engine\sp\utility::add_hint_string("already_have_weapon_hint", &"HOMETOWN/ALREADY_HAVE_WEAPON");
  scripts\engine\sp\utility::add_hint_string("hint_hold_fire", &"HOMETOWN/FIRE_PISTOL", scripts\sp\maps\hometown\hometown_escape.gsc::hintfirepistolcheck);
  precachestring(&"HOMETOWN/RUBBLE_HINT");
  precachestring(&"HOMETOWN/BOSS_KILLED");
  precachestring(&"HOMETOWN/PISTOL_SOLDIERS_KILLED");
  precachemodel("head_sc_f_eghbali_civ_dust");
  precachemodel("head_sc_f_eghbali_civ_bloody");
  precachemodel("com_teddy_bear");
  precachemodel("misc_luggage_01");
  precachemodel("offhand_vm_cellphone_old_on");
  precachemodel("offhand_vm_cellphone_old");
  precachemodel("viewhands_alex_fullbody");
  precachemodel("body_white_helmets_male_1");
  precachemodel("body_white_helmets_male_2");
  precachemodel("body_white_helmets_male_3");
  precachemodel("hat_child_hadir_gas_mask");
  precachemodel("body_civ_syrkistan_female_1_1");
  precachemodel("body_civ_syrkistan_female_1_1");
  precachemodel("body_civ_syrkistan_female_1_1");
  precachemodel("weapon_vm_me_soscar_knife");
  precachemodel("attachment_wm_pi_cpapa_mag");
  precachemodel("attachment_wm_pi_cpapa_barrel");
  precachemodel("attachment_wm_receiver_akilo47");
  precachemodel("attachment_wm_stock_akilo47");
  precachemodel("attachment_wm_barrel_akilo47");
  precachemodel("attachment_wm_mag_akilo47");
  precacheshader("hud_icon_equipment_cellphone");
  precacheshader("overlay_hometown_vignette");
  precachemodel("body_civ_syrkistan_male_1_1");
  precachemodel("body_civ_syrkistan_male_2_1");
  precachemodel("body_civ_syrkistan_male_3_1");
  precachemodel("body_civ_syrkistan_male_4_1");
  precachemodel("body_civ_syrkistan_male_5_1");
  precachemodel("body_civ_syrkistan_male_6_1");
  precachemodel("body_civ_syrkistan_male_7_1");
  precachemodel("body_civ_syrkistan_male_8_1");
  precachemodel("body_civ_syrkistan_male_9_1");
  precachemodel("body_civ_syrkistan_male_10_1");
  precachemodel("body_civ_syrkistan_female_1_2");
  precachemodel("body_civ_syrkistan_female_4_1");
  precachemodel("body_civ_syrkistan_female_4_2");
  precachemodel("body_civ_syrkistan_female_5_1");
  precachemodel("body_civ_syrkistan_female_5_2");
  precachemodel("body_civ_syrkistan_female_6_1");
  precachemodel("body_civ_syrkistan_female_6_2");
  precachemodel("body_civ_syrkistan_female_8_2");
  precachemodel("body_civ_syrkistan_female_10_1");
  precachemodel("body_civ_syrkistan_female_10_2");
  precachemodel("body_civ_syrkistan_girl_1_1");
  precachemodel("body_civ_syrkistan_girl_2_1");
  precachemodel("body_civ_syrkistan_girl_3_1");
  precachemodel("body_civ_syrkistan_girl_4_1");
  precachemodel("body_civ_syrkistan_girl_5_1");
  precachemodel("body_civ_syrkistan_girl_6_1");
  precachemodel("body_civ_syrkistan_boy_1_1");
  precachemodel("body_civ_syrkistan_boy_2_1");
  precachemodel("body_civ_syrkistan_boy_3_1");
  precachemodel("body_civ_syrkistan_boy_4_1");
  precachemodel("body_civ_syrkistan_boy_5_1");
  precachemodel("body_civ_syrkistan_boy_6_1");
  precachemodel("head_sc_f_roa_dust");
  precachemodel("hat_hero_farahs_father_wind");
  precachemodel("head_sc_m_ahmadzai_civ_helmet_bg_dust");
  precachemodel("head_sc_m_alameer_civ_helmet_bg_dust");
  precachemodel("head_sc_m_kargorgis_civ_helmet_bg_dust");
  precachemodel("head_sc_m_yurteri_civ_helmet_bg_dust");
  precachemodel("default_character_shadow");
  precachemodel("head_sc_m_naficy_civ_dust");
  precachemodel("viewhands_farrah_bloody");
  precachemodel("hat_waist_child_hadir_gas_mask");
  precachemodel("me_furniture_frame_mod_black_sm_02_g");
  precachemodel("body_hero_hadir_child_bloody");
  precachemodel("body_russian_soldier_boss_stab_1_chest_dad");
  precachemodel("body_russian_soldier_boss_stab_2_leg_l_back");
  precachemodel("body_russian_soldier_boss_stab_3_leg_r_back");
  precachemodel("body_russian_soldier_boss_stab_4_neck");
  precachemodel("head_russian_soldier_boss_stab_4_neck");
  precachemodel("body_russian_soldier_boss_stab_5_chest_a");
  precachemodel("body_russian_soldier_boss_stab_6_chest_b");
  precachemodel("body_russian_soldier_boss_stab_7_chest_c");
  precachemodel("body_russian_soldier_boss_stab_8_chest_d");
  precachemodel("body_russian_soldier_boss_stab_9_gunshots");
  precachemodel("head_sc_m_mrehin_civ_bg_dust");
  precachemodel("head_sc_m_arakelyan_civ_bg_dust");
  precachemodel("head_sc_m_bansal_civ_bg_dust");
  precachemodel("head_sc_m_alameer_civ_bg_dust");
  precachemodel("head_sc_m_haghighi_civ_bg_dust");
  precachemodel("head_sc_m_nassernia_civ_bg_dust");
  precachemodel("head_sc_m_ahmadzai_civ_bg_dust");
  precachemodel("head_sc_m_ahmadzai_civ_helmet_bg_dust");
  precachemodel("head_sc_m_alameer_civ_helmet_bg_dust");
  precachemodel("head_sc_m_kargorgis_civ_helmet_bg_dust");
  precachemodel("head_sc_m_yurteri_civ_helmet_bg_dust");
  precachemodel("head_sc_f_toyouri_civ_bg_no_hair_dust");
  precachemodel("head_sc_f_rezaee_civ_bg_dust");
  precachemodel("head_sc_f_eghbali_civ_bg_dust");
  precachemodel("head_sc_m_naficy_civ_bg_dust");
  precachemodel("head_sc_f_roa_bg_dust");
  precachemodel("head_sc_f_fausto_bg_dust");
  precachemodel("head_sc_f_kohli_bg_dust");
  precachemodel("head_villain_barkov");
  precachemodel("body_villain_hometown_barkov");
  precachemodel("head_sc_m_ward_blendshape");
  precachemodel("head_sc_m_coto_blendshape");
  precachemodel("head_sc_m_fahselt_civ_bg_dust");
  precachemodel("head_sc_f_roa_bg_dust");
  precachemodel("hat_sc_m_nassernia_headscarf");
  precachemodel("hat_sc_m_nassernia_headwrap");
  precachemodel("hat_sc_m_nassernia_helmet");
  precachemodel("hat_sc_m_nassernia_pakol");
  precachemodel("hat_sc_m_bansal_headscarf");
  precachemodel("hat_sc_m_bansal_headwrap");
  precachemodel("hat_sc_m_bansal_helmet");
  precachemodel("hat_sc_m_bansal_pakol");
  precachemodel("hat_sc_m_mrehin_civ_beanie");
  precachemodel("hat_sc_m_mrehin_pakol");
  precachemodel("hat_sc_m_mrehin_scarf");
  precachemodel("hat_sc_m_mrehin_fullwrap");
  precachemodel("hat_sc_m_ahmadzai_pakol");
  precachemodel("hat_sc_m_ahmadzai_scarf");
  precachemodel("hat_sc_m_ahmadzai_fullwrap");
  precachemodel("head_sc_m_ahmadzai_bg_dust_civ_no_hair");
  precachemodel("hat_hero_farah_sas_gasmask");
  precachemodel("prop_child_hadir_gas_mask");
  precachemodel("prop_gasmask");
  precachestring(&"HOMETOWN/CELLPHONE");
  precachestring(&"HOMETOWN/AK47");
  precachestring(&"HOMETOWN/GASMASK");
  precachestring(&"HOMETOWN/CLIMB");
  precachestring(&"HOMETOWN/PRY");
  precachestring(&"HOMETOWN/KNIFE");
  precachestring(&"HOMETOWN/BRICK");
  precachestring(&"HOMETOWN/SCISSORS");
  precachestring(&"HOMETOWN/SCREWDRIVER");
  precachestring(&"HOMETOWN/CALL_HADIR");
  precachestring(&"HOMETOWN/OPEN");
  precachestring(&"HOMETOWN/PISTOL");
  precachestring(&"HOMETOWN/ATTRACT_HELP");
  precachestring(&"HOMETOWN/VOICES");
  precachestring(&"HOMETOWN/GET_TO_HADIR");
  precachestring(&"HOMETOWN/FARAHS_HOUSE");
  precachestring(&"HOMETOWN/PREPARE_TO_ESCAPE");
  precachestring(&"HOMETOWN/FATHER");
  precachestring(&"HOMETOWN/HIDE_FROM_THE_SOLDIER");
  precachestring(&"HOMETOWN/ATTACK_THE_SOLDIER");
  precachestring(&"HOMETOWN/SOLDIER");
  precachestring(&"HOMETOWN/SEARCH_BODY");
  precachestring(&"HOMETOWN/BODY");
  precachestring(&"HOMETOWN/GET_OUTSIDE");
  precachestring(&"HOMETOWN/FRONT_DOOR");
  precachestring(&"HOMETOWN/ESCAPE_THE_GAS");
  precachestring(&"HOMETOWN/ESCAPE");
  precachestring(&"HOMETOWN/OUT_OF_TOWN");
  precachestring(&"HOMETOWN/ROAD");
  precachestring(&"HOMETOWN/GET_THE_PISTOL");
  precachestring(&"HOMETOWN/REVOLVER");
  precachestring(&"HOMETOWN/KILL_THE_SOLDIERS");
  precachestring(&"HOMETOWN/SOLDIERS");
  precachestring(&"HOMETOWN/STEAL_THE_VEHICLE");
  precachestring(&"HOMETOWN/RETURN_TO_BASE");
  precachestring(&"HOMETOWN/FOLLOW_FATHER");
  precachestring(&"HOMETOWN/FIND_WEAPON");
  precachestring(&"HOMETOWN/SEARCH_THE_GROUND");
  scripts\engine\sp\utility::add_hint_string("search_ground_hint", &"HOMETOWN/SEARCH_THE_GROUND");
  level_vfx();
}

level_vfx() {
  level._effect["vfx_tear_screenfx_01"] = loadfx("vfx/iw8/char/tears/vfx_tear_screenfx_01");
  level._effect["vfx_tear_gas_tears"] = loadfx("vfx/test/norris/vfx_tear_gas_tears.vfx");
  level._effect["bloody_footprint"] = loadfx("vfx/iw8/char/footsteps/vfx_footstep_blood.vfx");
  level._effect["vfx_htown_blood_stab"] = loadfx("vfx/iw8/level/hometown/vfx_htown_blood_stab.vfx");
}

civ_cleanup_monitor() {
  level waittill("clean_up_civs");
  var_0 = scripts\engine\utility::array_removeundefined(level.civ_cleanup_array);

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

hadir_poppies_start_anim() {
  var_0 = scripts\engine\utility::getStruct("poppies_enter_anim_node", "script_noteworthy");
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  var_0 scripts\common\anim::anim_single_solo(level.hadir_ai, "Hole_exit_hadir");
}