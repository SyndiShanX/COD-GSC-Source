/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy.gsc
***********************************************/

main() {
  scripts\sp\maps\embassy\gen\embassy_art.gsc::main();
  scripts\sp\maps\embassy\embassy_fx.gsc::main();
  scripts\sp\maps\embassy\embassy_anim.gsc::main();
  scripts\sp\maps\embassy\embassy_lighting.gsc::main();
  scripts\sp\maps\embassy\embassy_precache.gsc::main();
  scripts\sp\player\ally_equipment::ally_equipment_init();
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 5);
  setdvarifuninitialized("scr_emb_greenlight", 0);
  setdvarifuninitialized("ambo_goal_test", 0);
  setdvarifuninitialized("scr_emb_cctv_safe", 0);
  setdvarifuninitialized("scr_emb_cctv_caught", 0);
  setdvarifuninitialized("scr_emb_heli_crawl_fail", 1);
  setdvarifuninitialized("scr_emb_trailer", 0);
  setdvarifuninitialized("scr_emb_draw_screen_type", 0);
  scripts\engine\sp\utility::transient_init("embassy_building_tr");
  scripts\engine\sp\utility::transient_init("embassy_building_cctv_tr");
  scripts\engine\sp\utility::transient_init("embassy_streets_field_tr");
  scripts\engine\sp\utility::transient_init("embassy_compound_anims_tr");
  scripts\engine\sp\utility::transient_init("embassy_compound_anims_middle_tr");
  scripts\engine\sp\utility::transient_init("embassy_compound_anims_end_tr");
  embassy_starts();
  embassy_fx();
  embassy_precache();
  embassy_flags();
  embassy_hints();
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  embassy_inits();
  var_0 = ["frag", "flash", "molotov", "semtex"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::vision_set_init();
  scripts\engine\sp\utility::intro_screen_create(&"EMBASSY/INTRO_TITLE", &"EMBASSY/INTRO_DATE", &"EMBASSY/INTRO_WHO", &"EMBASSY/INTRO_SQUAD", &"EMBASSY/INTRO_LOCATION");
  scripts\engine\sp\utility::intro_screen_custom_func(scripts\engine\sp\utility::empty_func);
  loadout();
  spawn_funcs();
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, -60), level.player.angles);
  level.player.rig hide();
  level.player.rig dontcastshadows();
  init_perimeter_lights();
  createthreatbiasgroup("player");
  createthreatbiasgroup("price");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("mortar_house_guys");
  createthreatbiasgroup("ignore_mortar_house_guys");
  level.player setthreatbiasgroup("player");
  thread adjust_allowed_civilian_deaths();
  thread scripts\sp\maps\embassy\embassy_util.gsc::track_player_combat_time();
  thread scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_objectives();
  thread scripts\sp\maps\embassy\embassy_util.gsc::focusflag();
  setDvar("scr_emb_playtest", 1);
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

hide_delay() {
  wait 0.1;
  level.player.rig hide();
}

embassy_starts() {
  scripts\engine\sp\utility::add_start("infil_helicopter", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_start, "Infil Helicopter", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_catchup);
  scripts\engine\sp\utility::add_start("infil_helicopter_crawl", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crawl_start, "Infil Helicopter Crawl", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crawl_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crawl_catchup);
  scripts\engine\sp\utility::add_start("infil_helicopter_crash", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crash_start, "Infil Helicopter Crash", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crash_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::helicopter_crash_catchup);
  scripts\engine\sp\utility::add_start("infil_embassy_rooftop", scripts\sp\maps\embassy\embassy_infil.gsc::embassy_roof_start, "Embassy Rooftop", scripts\sp\maps\embassy\embassy_infil.gsc::embassy_roof_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::embassy_roof_catchup);
  scripts\engine\sp\utility::add_start("infil_offices", scripts\sp\maps\embassy\embassy_infil.gsc::offices_start, "Offices", scripts\sp\maps\embassy\embassy_infil.gsc::offices_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::offices_catchup);
  scripts\engine\sp\utility::add_start("infil_stairwell", scripts\sp\maps\embassy\embassy_infil.gsc::stairwell_start, "Stairwell", scripts\sp\maps\embassy\embassy_infil.gsc::stairwell_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::stairwell_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_metal_detectors", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_metal_detectors_start, "BPG Metal Detectors", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_metal_detectors_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_metal_detectors_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_scene", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_scene_start, "BPG Scene", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_scene_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_scene_catchup);
  scripts\engine\sp\utility::add_start("infil_truck_office", scripts\sp\maps\embassy\embassy_infil.gsc::truck_office_start, "Truck Office", scripts\sp\maps\embassy\embassy_infil.gsc::truck_office_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::truck_office_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_combat", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_combat_start, "BPG Combat", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_combat_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::bp_glass_combat_catchup);
  scripts\engine\sp\utility::add_start("infil_basement", scripts\sp\maps\embassy\embassy_infil.gsc::basement_start, "Basement", scripts\sp\maps\embassy\embassy_infil.gsc::basement_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::basement_catchup);
  scripts\engine\sp\utility::add_start("infil_saferoom", scripts\sp\maps\embassy\embassy_infil.gsc::saferoom_start, "Saferoom", scripts\sp\maps\embassy\embassy_infil.gsc::saferoom_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::saferoom_catchup);
  scripts\engine\sp\utility::add_start("cctv_01", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_start, "CCTV Start", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_catchup);
  scripts\engine\sp\utility::add_start("cctv_post_intro", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_post_intro_start, "CCTV Post Intro", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_post_intro_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_post_intro_catchup);
  scripts\engine\sp\utility::add_start("cctv_02", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_02_start, "CCTV Mid", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_02_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_02_catchup);
  scripts\engine\sp\utility::add_start("escape", scripts\sp\maps\embassy\embassy_infil.gsc::escape_start, "Escape", scripts\sp\maps\embassy\embassy_infil.gsc::escape_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_infil.gsc::escape_catchup);
  scripts\engine\sp\utility::add_start("escape_combat", scripts\sp\maps\embassy\embassy_infil.gsc::escape_combat_start, "Escape Combat", scripts\sp\maps\embassy\embassy_infil.gsc::escape_combat_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::escape_combat_catchup);
  scripts\engine\sp\utility::add_start("alley", scripts\sp\maps\embassy\embassy_infil.gsc::alley_start, "Alley", scripts\sp\maps\embassy\embassy_infil.gsc::alley_main, "embassy_building_and_streets", scripts\sp\maps\embassy\embassy_infil.gsc::alley_catchup);
  scripts\engine\sp\utility::add_start("residence_arrival", scripts\sp\maps\embassy\embassy_defend.gsc::residence_arrival_start, "Residence Arrival", scripts\sp\maps\embassy\embassy_defend.gsc::residence_arrival_main, "embassy_building_and_streets_and_compund", scripts\sp\maps\embassy\embassy_defend.gsc::residence_arrival_catchup);
  scripts\engine\sp\utility::add_start("approach", scripts\sp\maps\embassy\embassy_defend.gsc::defend_approach_start, "Approach", scripts\sp\maps\embassy\embassy_defend.gsc::defend_approach_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_approach_catchup);
  scripts\engine\sp\utility::add_start("movement", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_0_start, "Movement", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_0_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_0_catchup);
  scripts\engine\sp\utility::add_start("flare", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_1_start, "Flare", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_1_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_1_catchup);
  scripts\engine\sp\utility::add_start("trucks", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_trucks_start, "Trucks", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_trucks_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_trucks_catchup);
  scripts\engine\sp\utility::add_start("mortar", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_mortars_start, "Mortar", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_mortars_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_mortars_catchup);
  scripts\engine\sp\utility::add_start("push", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_push_start, "Push", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_push_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_2_push_catchup);
  scripts\engine\sp\utility::add_start("triage_scene", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_triage_start, "Triage Scene", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_triage_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_triage_catchup);
  scripts\engine\sp\utility::add_start("building_fight", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_buildings_start, "Building Fight", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_buildings_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_3_buildings_catchup);
  scripts\engine\sp\utility::add_start("Unknown Car", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_targeting_start, "Unknown Car", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_targeting_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_targeting_catchup);
  scripts\engine\sp\utility::add_start("laser_targeting_2", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_technicles_start, "Laser Targeting_2", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_technicles_main, "embassy_streets_and_anims_mid", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_technicles_catchup);
  scripts\engine\sp\utility::add_start("snipers", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_snipers_start, "snipers", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_4_snipers_main, "embassy_streets_and_anims_mid");
  scripts\engine\sp\utility::add_start("mortar_building_attack", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_attack_start, "Mortar Building Attack Start", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_attack_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_attack_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_boost", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_boost_start, "Boost", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_boost_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_boost_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_exterior", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_start, "Mortar Building", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_5_mortar_house_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_rooftop", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_6_start, "Residence", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_6_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wave_6_catchup);
  scripts\engine\sp\utility::add_start("wolf_escapes", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_start, "Wolf Escapes", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_catchup);
  scripts\engine\sp\utility::add_start("wolf_escapes_scene", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_scene_start, "Wolf Escapes Scene", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_scene_main, "embassy_ending", scripts\sp\maps\embassy\embassy_defend.gsc::defend_wolf_escapes_catchup);
  scripts\engine\sp\utility::add_start("Art", ::art_start, "Art", ::art_main, "embassy_streets_field_tr", ::art_catchup);
  scripts\engine\sp\utility::add_start("cctv_bink", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_start, "cctv_bink", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_bink_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_cctv.gsc::security_cam_01_catchup);
  scripts\engine\sp\utility::add_start("cctv_outro_bink", scripts\sp\maps\embassy\embassy_cctv.gsc::cctv_outro_bink_start, "cctv_outro_bink", scripts\sp\maps\embassy\embassy_cctv.gsc::cctv_outro_bink_main, "embassy_building_all", scripts\sp\maps\embassy\embassy_cctv.gsc::cctv_outro_bink_catchup);
  scripts\engine\sp\utility::set_default_start("infil_helicopter");
}

mortar_anim() {
  scripts\sp\maps\embassy\embassy_defend.gsc::defend_inits();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player]);
  var_0 = scripts\engine\sp\utility::spawn_targetname("ally_01_mortar", 1);
  var_0.animname = "ally_01_mortar";
  var_1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_1 scripts\common\anim::anim_single_solo(var_0, "rooftops_begin");
}

embassy_precache() {
  precacheitem("iw8_sn_mike14");
  precachemodel("security_monitor_02_screens");
  precachemodel("un_office_computer_monitor_01_screens");
  precachemodel("un_office_computer_monitor_03_screens");
  precachemodel("un_office_dual_wall_monitor_01_screens");
  precachemodel("electronics_fire_alarm_01_white_on");
  precachemodel("electronics_fire_alarm_01_white_off");
  precachemodel("head_sc_m_alameer_civ_bg_nohair");
  precachemodel("body_al_qatala_urban_civ_3_1");
  precachemodel("al_qatala_urban_civ_bomb_vest");
  var_0 = ["scaffolding_a", "scaffolding_b", "scaffolding_c"];

  foreach(var_2 in var_0)
  hide_scaffolding_mayhem(var_2);

  scripts\engine\utility::flag_init("forever");
  scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_precache();
  scripts\sp\maps\embassy\embassy_defend.gsc::embassy_defend_precache();
  scripts\sp\maps\embassy\embassy_cctv.gsc::embassy_cctv_precache();
}

embassy_fx() {
  scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_fx();
  scripts\sp\maps\embassy\embassy_defend.gsc::embassy_defend_fx();
  scripts\sp\maps\embassy\embassy_cctv.gsc::embassy_cctv_fx();
}

hide_scaffolding_mayhem(var_0) {
  hidemayhem(var_0);
  hidemayhem(var_0 + "_tarps");
}

init_perimeter_lights() {
  wait 0.15;
  var_0 = getscriptablearray("perimeter_lights", "targetname");
  var_1 = getEntArray("light_spot", "classname");

  foreach(var_3 in var_0) {
    var_1 = sortbydistance(var_1, var_3.origin);
    level thread scripts\sp\maps\embassy\embassy_defend.gsc::perimeter_light_ondeath(var_3, var_1[0]);
  }
}

loadout() {
  var_0 = level.player.meleeweapons;
  level.player takeallweapons();

  foreach(var_2 in var_0)
  level.player scripts\engine\sp\utility::give_melee_weapon(var_2);

  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player scripts\engine\sp\utility::give_offhand("flash");

  if(scripts\sp\starts::is_after_start("infil_embassy_rooftop")) {
    var_4[0] = scripts\sp\utility::make_weapon("iw8_pi_golf21");

    if(scripts\sp\starts::is_after_start("infil_truck_office")) {
      var_4[1] = var_4[0];
      var_4[0] = scripts\sp\utility::make_weapon("iw8_sm_mpapa7", ["reflex_west01"]);
    }

    if(scripts\sp\starts::is_after_start("residence_arrival")) {
      var_4[0] = scripts\sp\utility::make_weapon("iw8_sn_mike14", ["snprscope_mike14"]);
      var_4[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01"]);
    }

    foreach(var_6 in var_4)
    level.player giveweapon(var_6, 0, 0, 0, 1);

    level.player givemaxammo(var_4[0]);
    level.player switchtoweapon(var_4[0]);
  }

  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewmodel_arms_kyle_desert");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_kyle_desert");
  level.player scripts\sp\player::give_player_max_armor();
}

firemode_feedback() {
  level.player endon("death");
  var_0 = "_off";

  for(;;) {
    while(nullweapon(level.player getcurrentweapon()))
      waitframe();

    var_1 = level.player getcurrentweapon();
    var_2 = 0;

    if(issubstr(var_1.basename, "sel"))
      var_2 = 1;

    level.player waittill("weapon_change", var_3);
    var_4 = createheadicon(var_3);

    if(var_2 && issubstr(var_4, "sel")) {
      level.player playRumbleOnEntity("damage_heavy");
      level.player playSound("wpfoly_acog_ads_toggle" + var_0);
      level.player forceplaygestureviewmodel("ges_fall_back", undefined, 0.05, 0.97);
      var_0 = scripts\engine\utility::ter_op(var_0 == "_off", "_on", "_off");
    }
  }
}

adjust_allowed_civilian_deaths() {
  if(!scripts\sp\starts::is_after_start("infil_saferoom")) {
    scripts\engine\utility::flag_wait("friendly_penalties_lowered");
    var_0 = level.friendlyfire["max_participation"];
    var_1 = level.player.participation;
    level.friendlyfire["max_participation"] = level.friendlyfire["friend_kill_points"] * -2;
    level.player.participation = level.friendlyfire["friend_kill_points"] * -2;
    scripts\engine\utility::flag_waitopen("friendly_penalties_lowered");
    level.friendlyfire["max_participation"] = var_0;
    level.player.participation = var_1;
  }
}

art_start() {}

art_main() {}

art_catchup() {}

spawn_funcs() {
  var_0 = scripts\engine\utility::array_combine(getspawnerarray("patrol_03"), getspawnerarray("patrol_01"), getspawnerarray("table_beating_enemy"));
  var_1 = scripts\engine\utility::array_combine(getspawnerarray("wave_0_enemies"), getspawnerarray("wave_0_1_enemies"), getspawnerarray("wave_0_2_enemies"));
  var_2 = scripts\engine\utility::array_combine(getspawnerarray("wave_1"), getspawnerarray("wave_1_extra_1"), getspawnerarray("wave_1_extra_2"), getspawnerarray("wave_1_extra_3"));
  var_3 = scripts\engine\utility::array_combine(getspawnerarray("wave_2_enemies"), getspawnerarray("wave_2_extra_1"), getspawnerarray("wave_2_extra_2"), getspawnerarray("wave_2_extra_3"), getspawnerarray("push_inside__refill"));
  var_4 = scripts\engine\utility::array_combine(getspawnerarray("scaffolding_a_guys"), getspawnerarray("scaffolding_b_guys"), getspawnerarray("scaffolding_c_guys"), getspawnerarray("guard_rails_guys"));
  var_5 = scripts\engine\sp\utility::get_spawner_array("wave_4_street_guys", "script_noteworthy");
  var_5 = scripts\engine\utility::array_combine(var_5, getspawnerarray("horde_02"));
  var_6 = getspawnerarray("wave_4_corner_guys");
  var_7 = scripts\engine\utility::array_combine(getspawnerarray("wave_4_field_1"), getspawnerarray("wave_4_field_2"));
  var_8 = getspawnerarray("mortar_house_guys");
  var_9 = getspawnerarray("wave_5_mortar_house_exterior");
  var_10 = getspawner("doorbust_guy", "script_noteworthy");
  var_11 = getspawner("stairs_guy", "script_noteworthy");
  var_12 = getspawner("suicide_bomber", "targetname");
  var_13 = getspawnerarray("technical_dudes_01");
  var_14 = getspawner("technical_dude_gunner_01", "targetname");
  var_15 = getspawnerarray("technical_dudes_02");
  var_16 = getspawnerarray("technical_dudes_03");
  var_17 = getspawnerarray("technical_dudes_04");
  var_18 = getspawnerarray("technical_dudes_05");
  var_19 = getspawnerarray("technical_dudes_06");
  var_20 = getspawnerarray("technical_dudes_07");
  var_21 = getspawnerarray("technical_dudes_08");
  var_22 = getspawnerarray("technical_dudes_09");
  var_23 = getspawnerarray("technical_dudes_10");
  level.heli_guys = [];
  var_10 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\embassy\embassy_defend.gsc::doorbust_guy_spawn_func);
  var_11 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\embassy\embassy_defend.gsc::stairs_guy_spawn_func);
  var_12 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\embassy\embassy_defend.gsc::suicide_bomber_spawn_func);
  var_14 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\embassy\embassy_defend.gsc::wave_1_technical_gunner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function(var_0, scripts\sp\maps\embassy\embassy_cctv.gsc::camera_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_1, scripts\sp\maps\embassy\embassy_defend.gsc::distant_enemies_spawn_func);
  scripts\engine\sp\utility::array_spawn_function(var_2, scripts\sp\maps\embassy\embassy_defend.gsc::wave_1_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_3, scripts\sp\maps\embassy\embassy_defend.gsc::wave_2_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_4, scripts\sp\maps\embassy\embassy_defend.gsc::wave_3_building_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_5, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_street_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_6, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_corner_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_7, scripts\sp\maps\embassy\embassy_defend.gsc::wave_5_street_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_9, scripts\sp\maps\embassy\embassy_defend.gsc::wave_5_mortar_run_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_8, scripts\sp\maps\embassy\embassy_defend.gsc::mortar_house_guys_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_13, scripts\sp\maps\embassy\embassy_defend.gsc::wave_1_technical_enemy_behavior_01);
  scripts\engine\sp\utility::array_spawn_function(var_15, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_16, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_17, scripts\sp\maps\embassy\embassy_defend.gsc::wave_6_technical_04_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_18, scripts\sp\maps\embassy\embassy_defend.gsc::wave_6_technical_05_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_19, scripts\sp\maps\embassy\embassy_defend.gsc::wave_6_technical_06_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_20, scripts\sp\maps\embassy\embassy_defend.gsc::wave_6_technical_07_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_21, scripts\sp\maps\embassy\embassy_defend.gsc::wave_6_technical_08_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_22, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_23, scripts\sp\maps\embassy\embassy_defend.gsc::wave_4_technical_03_enemy_behavior);
}

embassy_flags() {
  scripts\engine\utility::flag_init("player_pushed_focus");
  scripts\engine\utility::flag_init("player_in_scene");
  scripts\engine\utility::flag_init("friendly_penalties_lowered");
  scripts\engine\utility::flag_init("audio_outside_crowd_loop");
  scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_flags();
  scripts\sp\maps\embassy\embassy_defend.gsc::embassy_defend_flags();
  scripts\sp\maps\embassy\embassy_cctv.gsc::embassy_cctv_flags();
  scripts\sp\maps\embassy\embassy_util.gsc::embassy_util_flags();
}

embassy_hints() {
  scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_hints();
}

embassy_inits() {
  level.autosave.enemydistcheck = 0;
  scripts\sp\maps\embassy\embassy_infil.gsc::embassy_infil_init();
  scripts\sp\maps\embassy\embassy_cctv.gsc::embassy_cctv_init();
}