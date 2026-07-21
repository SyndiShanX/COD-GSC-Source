/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive.gsc
***********************************************/

main() {
  setsaveddvar("MMLNNQSTTL", 0);
  scripts\sp\maps\captive\gen\captive_art.gsc::main();
  scripts\sp\maps\captive\captive_fx.gsc::main();
  scripts\sp\maps\captive\captive_precache.gsc::main();
  scripts\sp\maps\captive\captive_anim.gsc::main();
  scripts\sp\maps\captive\captive_lighting.gsc::main();
  scripts\engine\sp\utility::transient_init("captive_basement_tr");
  scripts\engine\sp\utility::transient_init("captive_gas_tr");
  scripts\engine\sp\utility::transient_init("captive_exterior_tr");
  preload();
  init_flags();
  scripts\sp\maps\captive\captive_lighting.gsc::setup_lighting();
  starts();
  setsaveddvar("MRNRKKOPLN", 6);
  setsaveddvar("MQPQKNPQOK", 3);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("OLSKLTPPMR", 1);
  setsaveddvar("NQTLPTNSSO", 3);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  var_0 = ["frag_farah", "noisemaker"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  level.player.grenadetimers["frag_farah"] = randomintrange(1000, 20000);
  anim.grenadetimers["AI_frag_farah"] = randomintrange(0, 20000);
  spawn_funcs();
  setup_hints();
  scripts\sp\player\teenagefarah::teenage_farah_setup();
  setomnvar("ai_fulllight", 0.09);
  setomnvar("ai_nolight", 0.01);
  scripts\sp\maps\captive\captive_util.gsc::setup_cell_doors();
  scripts\sp\maps\captive\captive_util.gsc::setup_linked_collision_entities("factory_door");
  scripts\sp\maps\captive\captive_util.gsc::setup_linked_collision_entities("exterior_gate");
  level.player notifyonplayercommand("take_breath", "+breath_sprint");
  level.player notifyonplayercommand("release_breath", "-breath_sprint");
  level.player notifyonplayercommand("jump_pressed", "+gostand");
  level.player notifyonplayercommand("jump_pressed", "+stanceup");
  level.player notifyonplayercommand("stance_pressed", "+stance");
  level.player notifyonplayercommand("stance_pressed", "+togglecrouch");
  level.player notifyonplayercommand("stance_pressed", "+movedown");
  level.player notifyonplayercommand("stance_down_pressed", "+stancedown");
  level.player notifyonplayercommand("use_pressed", "+usereload");
  level.player notifyonplayercommand("use_pressed", "+activate");
  level.player notifyonplayercommand("switch_weapon_pressed", "+weapnext");
  level.player notifyonplayercommand("secondary_offhand_pressed", "+smoke");
  setsaveddvar("NKTRSSTMRQ", 0.5);
  scripts\sp\utility::nvidiaansel_overridecollisionradius(8.0);
  level.playermover = scripts\engine\utility::spawn_script_origin(level.player.origin);
  thread player_breath_context();
  thread scripts\sp\maps\captive\captive_util.gsc::track_player_combat_time();
  level.player setclothtype("cloth");
  var_1 = getEntArray("lerp_fov_trigger", "targetname");

  foreach(var_3 in var_1)
  var_3 thread scripts\sp\maps\captive\captive_util.gsc::lerp_fov_over_distance_trigger();

  level thread scripts\engine\utility::exploder("corridor_light");
  thread setup_vfx_int_vs_ext();
  var_5 = getEnt("warehouse_truck_1", "targetname");
  var_5 vehicle_turnengineoff();
  var_6 = getEnt("warehouse_truck_2", "targetname");
  var_6 vehicle_turnengineoff();
  level.sniperroof = getEnt("sniper_roof", "targetname");
  level.sniperroofdestroyed = getEnt("sniper_roof_destroyed", "targetname");
  level.sniperroofdestroyed hide();
  level.dodgedbullet = 1;
  getEnt("barkov_bed_clip", "targetname") notsolid();
  var_7 = nvidiahighlightsrequestpermissions(538);

  if(isDefined(var_7) && isDefined(var_7.apex_delta)) {
    var_8 = var_7.apex_delta;
    var_8 = (var_8[0], var_8[1], 0);
    var_8 = vectorNormalize(var_8);
    var_7.apex_delta = var_7.apex_delta + var_8 * 7.5;
  }
}

player_breath_context() {
  wait 0.5;
  level.player setentitysoundcontext("gender", "female");
}

preload() {
  scripts\sp\player\teenagefarah::teenage_farah_precache();
  scripts\sp\maps\captive\captive_break.gsc::break_precache();
  precachemodel("hat_gasmask");
  precachemodel("hat_hero_price_gasmask");
  precachemodel("weapon_wm_me_spoonshank");
  precachemodel("captive_thrown_rock");
  precachemodel("electrical_cell_door_button_lights_red");
  precachemodel("electrical_cell_door_button_lights_green");
  precachemodel("misc_vm_halligan_tool");
  precachemodel("furniture_old_wooden_chair_vm_01");
  precachemodel("ee_lighting_string_light_caged_01");
  precachemodel("head_sc_m_ahmadzai");
  precachemodel("head_sc_m_bansal");
  precachemodel("head_sc_m_kargorgis_civ");
  precachemodel("head_sc_m_jimenez");
  precachemodel("head_sc_m_karlin");
  scripts\engine\sp\utility::add_hint_string("slide", &"SCRIPT/SLIDE_HINT", scripts\sp\maps\captive\captive_exterior_fight.gsc::player_did_slide);
  scripts\engine\sp\utility::add_hint_string("slide_tap", &"SCRIPT/SLIDE_HINT_TAP", scripts\sp\maps\captive\captive_exterior_fight.gsc::player_did_slide);
}

spawn_funcs() {
  scripts\engine\sp\utility::array_spawn_function_targetname("barkov", scripts\sp\maps\captive\captive_break.gsc::barkov_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("henchman", scripts\sp\maps\captive\captive_break.gsc::henchman_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("henchman2", scripts\sp\maps\captive\captive_break.gsc::henchman_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("henchman3", scripts\sp\maps\captive\captive_break.gsc::henchman_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("basement_guards", scripts\sp\maps\captive\captive_basement_stealth.gsc::basement_guard_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("window_view_guards", scripts\sp\maps\captive\captive_util.gsc::background_guard_not_reachable_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("ayah", scripts\sp\maps\captive\captive_util.gsc::prisoner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("nadia", scripts\sp\maps\captive\captive_util.gsc::prisoner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("ghalia", scripts\sp\maps\captive\captive_util.gsc::prisoner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("darine", scripts\sp\maps\captive\captive_util.gsc::prisoner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("azadeh", scripts\sp\maps\captive\captive_util.gsc::prisoner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("sas", scripts\sp\maps\captive\captive_util.gsc::sas_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("factory_floor_initial_guards_reinforce", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("factory_floor_secondary_guards", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("factory_floor_tertiary_guards", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("factory_floor_door_opener", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("alley_guards", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_1_1", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_1_2", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_1_3", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_2", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_3_1", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_3_2", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("rpg_enemy", scripts\sp\maps\captive\captive_exterior_fight.gsc::rpg_ai);
  scripts\engine\sp\utility::array_spawn_function_targetname("exterior_wave_3_extra", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("building_defense", scripts\sp\maps\captive\captive_util.gsc::swap_to_farah_frag);
  scripts\engine\sp\utility::array_spawn_function_targetname("meet_sas_guards", scripts\sp\maps\captive\captive_util.gsc::background_guard_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("gas_factory_mid_guards", scripts\sp\maps\captive\captive_util.gsc::gas_factory_mid_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("gas_lab_guards", scripts\sp\maps\captive\captive_util.gsc::background_guard_spawn_func);
}

setup_hints() {
  scripts\engine\sp\utility::add_hint_string("aim_noisemaker", &"CAPTIVE/AIM_ROCK_HINT", scripts\sp\maps\captive\captive_cell_escape.gsc::has_aimed_noisemaker);
  scripts\engine\sp\utility::add_hint_string("aim_noisemaker_toggle", &"CAPTIVE/AIM_ROCK_HINT_TOGGLE", scripts\sp\maps\captive\captive_cell_escape.gsc::has_aimed_noisemaker);
  scripts\engine\sp\utility::add_hint_string("throw_noisemaker", &"CAPTIVE/THROW_ROCK_HINT", scripts\sp\maps\captive\captive_cell_escape.gsc::has_thrown_noisemaker);
  scripts\engine\sp\utility::add_hint_string("throw_noisemaker_toggle", &"CAPTIVE/THROW_ROCK_HINT_TOGGLE", scripts\sp\maps\captive\captive_cell_escape.gsc::has_thrown_noisemaker);
  scripts\engine\sp\utility::add_hint_string("take_breath", &"CAPTIVE/TAKE_BREATH", scripts\sp\maps\captive\captive_break.gsc::waterboard_has_taken_breath);
  scripts\engine\sp\utility::add_hint_string("move_head", &"CAPTIVE/BREAK_WATERBOARD_TUTORIAL", scripts\sp\maps\captive\captive_break.gsc::waterboard_has_moved_head);
  scripts\engine\sp\utility::add_hint_string("move_head_kbm", &"CAPTIVE/BREAK_WATERBOARD_TUTORIAL_KBM", scripts\sp\maps\captive\captive_break.gsc::waterboard_has_moved_head);
  scripts\engine\sp\utility::add_hint_string("cannot_place", &"CAPTIVE/CHAIR_FAIL", scripts\sp\maps\captive\captive_cellblock_escape.gsc::has_displayed_chair_fail);
}

init_flags() {
  scripts\sp\maps\captive\captive_break.gsc::break_flags();
  scripts\sp\maps\captive\captive_cell_escape.gsc::cell_escape_flags();
  scripts\sp\maps\captive\captive_cellblock_escape.gsc::cellblock_escape_flags();
  scripts\sp\maps\captive\captive_basement_stealth.gsc::basement_stealth_flags();
  scripts\sp\maps\captive\captive_free_prisoners.gsc::free_prisoners_flags();
  scripts\sp\maps\captive\captive_factory_floor.gsc::factory_floor_flags();
  scripts\sp\maps\captive\captive_meet_sas.gsc::meet_sas_flags();
  scripts\sp\maps\captive\captive_exterior_fight.gsc::exterior_fight_flags();
  scripts\sp\maps\captive\captive_bunker.gsc::bunker_flags();
  scripts\sp\maps\captive\captive_vo.gsc::captive_vo_flags();
}

starts() {
  scripts\engine\sp\utility::set_default_start("break_intro");
  scripts\engine\sp\utility::add_start("break_intro", scripts\sp\maps\captive\captive_break.gsc::break_start, "Break Intro", scripts\sp\maps\captive\captive_break.gsc::break_intro_main, "basement", scripts\sp\maps\captive\captive_break.gsc::break_catchup);

  if(!scripts\sp\maps\captive\captive_util.gsc::should_skip_torture_scene()) {
    scripts\engine\sp\utility::add_start("break_orders", scripts\sp\maps\captive\captive_break.gsc::break_orders_start, "Break Orders", scripts\sp\maps\captive\captive_break.gsc::break_orders_main, "basement", scripts\sp\maps\captive\captive_break.gsc::break_orders_catchup);
    scripts\engine\sp\utility::add_start("break_waterboard", scripts\sp\maps\captive\captive_break.gsc::break_waterboard_start, "Break Waterboard", scripts\sp\maps\captive\captive_break.gsc::break_waterboard_main, "basement", scripts\sp\maps\captive\captive_break.gsc::break_waterboard_catchup);
    scripts\engine\sp\utility::add_start("break_final", scripts\sp\maps\captive\captive_break.gsc::break_final_start, "Break Final", scripts\sp\maps\captive\captive_break.gsc::break_final_main, "basement", scripts\sp\maps\captive\captive_break.gsc::break_final_catchup);
  } else
    scripts\engine\sp\utility::add_start("break_final", scripts\sp\maps\captive\captive_break.gsc::break_final_start, "Break Final", scripts\sp\maps\captive\captive_break.gsc::break_final_main_wegame, "basement", scripts\sp\maps\captive\captive_break.gsc::break_final_catchup);

  scripts\engine\sp\utility::add_start("cell_escape", scripts\sp\maps\captive\captive_cell_escape.gsc::cell_escape_start, "Cell Escape", scripts\sp\maps\captive\captive_cell_escape.gsc::cell_escape_main, "basement", scripts\sp\maps\captive\captive_cell_escape.gsc::cell_escape_catchup);
  scripts\engine\sp\utility::add_start("cellblock_escape", scripts\sp\maps\captive\captive_cellblock_escape.gsc::cellblock_escape_start, "Cellblock Escape", scripts\sp\maps\captive\captive_cellblock_escape.gsc::cellblock_escape_main, "basement", scripts\sp\maps\captive\captive_cellblock_escape.gsc::cellblock_escape_catchup);
  scripts\engine\sp\utility::add_start("basement_stealth", scripts\sp\maps\captive\captive_basement_stealth.gsc::basement_stealth_start, "Basement Stealth", scripts\sp\maps\captive\captive_basement_stealth.gsc::basement_stealth_main, "basement", scripts\sp\maps\captive\captive_basement_stealth.gsc::basement_stealth_catchup);
  scripts\engine\sp\utility::add_start("free_prisoners", scripts\sp\maps\captive\captive_free_prisoners.gsc::free_prisoners_start, "Free Prisoners", scripts\sp\maps\captive\captive_free_prisoners.gsc::free_prisoners_main, "basement", scripts\sp\maps\captive\captive_free_prisoners.gsc::free_prisoners_catchup);
  scripts\engine\sp\utility::add_start("factory_floor", scripts\sp\maps\captive\captive_factory_floor.gsc::factory_floor_start, "Factory Floor", scripts\sp\maps\captive\captive_factory_floor.gsc::factory_floor_main, "exterior_only", scripts\sp\maps\captive\captive_factory_floor.gsc::factory_floor_catchup);
  scripts\engine\sp\utility::add_start("exterior_fight", scripts\sp\maps\captive\captive_exterior_fight.gsc::exterior_fight_start, "Exterior Fight", scripts\sp\maps\captive\captive_exterior_fight.gsc::exterior_fight_main, "exterior_only", scripts\sp\maps\captive\captive_exterior_fight.gsc::exterior_fight_catchup);
  scripts\engine\sp\utility::add_start("meet_sas", scripts\sp\maps\captive\captive_meet_sas.gsc::meet_sas_start, "Meet SAS", scripts\sp\maps\captive\captive_meet_sas.gsc::meet_sas_main, "exterior_only", scripts\sp\maps\captive\captive_meet_sas.gsc::meet_sas_catchup);
  scripts\engine\sp\utility::add_start("bunker", scripts\sp\maps\captive\captive_bunker.gsc::bunker_start, "Bunker", scripts\sp\maps\captive\captive_bunker.gsc::bunker_main, "exterior_gas", scripts\sp\maps\captive\captive_bunker.gsc::bunker_catchup);
  scripts\engine\sp\utility::add_start("bink_speech", scripts\sp\maps\captive\captive_break.gsc::bink_speech, "", scripts\sp\maps\captive\captive_break.gsc::bink_speech_main, "basement");
}

setup_vfx_int_vs_ext() {
  scripts\engine\utility::flag_wait("load_finished");
  waitframe();

  for(;;) {
    scripts\engine\utility::stop_exploder("sunflare_exterior");
    scripts\engine\utility::exploder("sunflare_interior");
    scripts\engine\utility::flag_wait("flag_vfx_exterior");
    waitframe();
    scripts\engine\utility::stop_exploder("sunflare_interior");
    scripts\engine\utility::exploder("sunflare_exterior");
    scripts\engine\utility::flag_waitopen("flag_vfx_exterior");
    waitframe();
  }
}