/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\embassy\embassy.gsc
***********************************************/

function main() {
  scripts\sp\maps\embassy\gen\embassy_art::main();
  scripts\sp\maps\embassy\embassy_fx::main();
  scripts\sp\maps\embassy\embassy_anim::main();
  scripts\sp\maps\embassy\embassy_lighting::main();
  scripts\sp\maps\embassy\embassy_precache::main();
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
  var0 = ["frag", "flash", "molotov", "semtex"];
  scripts\engine\sp\utility::offhandprecache(var0);
  thread scripts\sp\maps\embassy\embassy_lighting::vision_set_init();
  scripts\engine\sp\utility::intro_screen_create(&"EMBASSY/INTRO_TITLE", &"EMBASSY/INTRO_DATE", &"EMBASSY/INTRO_WHO", &"EMBASSY/INTRO_SQUAD", &"EMBASSY/INTRO_LOCATION");
  scripts\engine\sp\utility::intro_screen_custom_func(&scripts\engine\sp\utility::empty_func);
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
  thread scripts\sp\maps\embassy\embassy_util::track_player_combat_time();
  thread scripts\sp\maps\embassy\embassy_infil::embassy_infil_objectives();
  thread scripts\sp\maps\embassy\embassy_util::focusflag();
  setDvar("scr_emb_playtest", 1);
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

function hide_delay() {
  wait 0.1;
  level.player.rig hide();
}

function embassy_starts() {
  scripts\engine\sp\utility::add_start("infil_helicopter", &scripts\sp\maps\embassy\embassy_infil::helicopter_start, "Infil Helicopter", &scripts\sp\maps\embassy\embassy_infil::helicopter_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::helicopter_catchup);
  scripts\engine\sp\utility::add_start("infil_helicopter_crawl", &scripts\sp\maps\embassy\embassy_infil::helicopter_crawl_start, "Infil Helicopter Crawl", &scripts\sp\maps\embassy\embassy_infil::helicopter_crawl_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::helicopter_crawl_catchup);
  scripts\engine\sp\utility::add_start("infil_helicopter_crash", &scripts\sp\maps\embassy\embassy_infil::helicopter_crash_start, "Infil Helicopter Crash", &scripts\sp\maps\embassy\embassy_infil::helicopter_crash_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::helicopter_crash_catchup);
  scripts\engine\sp\utility::add_start("infil_embassy_rooftop", &scripts\sp\maps\embassy\embassy_infil::embassy_roof_start, "Embassy Rooftop", &scripts\sp\maps\embassy\embassy_infil::embassy_roof_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::embassy_roof_catchup);
  scripts\engine\sp\utility::add_start("infil_offices", &scripts\sp\maps\embassy\embassy_infil::offices_start, "Offices", &scripts\sp\maps\embassy\embassy_infil::offices_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::offices_catchup);
  scripts\engine\sp\utility::add_start("infil_stairwell", &scripts\sp\maps\embassy\embassy_infil::stairwell_start, "Stairwell", &scripts\sp\maps\embassy\embassy_infil::stairwell_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::stairwell_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_metal_detectors", &scripts\sp\maps\embassy\embassy_infil::bp_glass_metal_detectors_start, "BPG Metal Detectors", &scripts\sp\maps\embassy\embassy_infil::bp_glass_metal_detectors_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::bp_glass_metal_detectors_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_scene", &scripts\sp\maps\embassy\embassy_infil::bp_glass_scene_start, "BPG Scene", &scripts\sp\maps\embassy\embassy_infil::bp_glass_scene_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::bp_glass_scene_catchup);
  scripts\engine\sp\utility::add_start("infil_truck_office", &scripts\sp\maps\embassy\embassy_infil::truck_office_start, "Truck Office", &scripts\sp\maps\embassy\embassy_infil::truck_office_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::truck_office_catchup);
  scripts\engine\sp\utility::add_start("infil_bp_glass_combat", &scripts\sp\maps\embassy\embassy_infil::bp_glass_combat_start, "BPG Combat", &scripts\sp\maps\embassy\embassy_infil::bp_glass_combat_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::bp_glass_combat_catchup);
  scripts\engine\sp\utility::add_start("infil_basement", &scripts\sp\maps\embassy\embassy_infil::basement_start, "Basement", &scripts\sp\maps\embassy\embassy_infil::basement_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::basement_catchup);
  scripts\engine\sp\utility::add_start("infil_saferoom", &scripts\sp\maps\embassy\embassy_infil::saferoom_start, "Saferoom", &scripts\sp\maps\embassy\embassy_infil::saferoom_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::saferoom_catchup);
  scripts\engine\sp\utility::add_start("cctv_01", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_start, "CCTV Start", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_catchup);
  scripts\engine\sp\utility::add_start("cctv_post_intro", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_post_intro_start, "CCTV Post Intro", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_post_intro_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_post_intro_catchup);
  scripts\engine\sp\utility::add_start("cctv_02", &scripts\sp\maps\embassy\embassy_cctv::security_cam_02_start, "CCTV Mid", &scripts\sp\maps\embassy\embassy_cctv::security_cam_02_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_cctv::security_cam_02_catchup);
  scripts\engine\sp\utility::add_start("escape", &scripts\sp\maps\embassy\embassy_infil::escape_start, "Escape", &scripts\sp\maps\embassy\embassy_infil::escape_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_infil::escape_catchup);
  scripts\engine\sp\utility::add_start("escape_combat", &scripts\sp\maps\embassy\embassy_infil::escape_combat_start, "Escape Combat", &scripts\sp\maps\embassy\embassy_infil::escape_combat_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::escape_combat_catchup);
  scripts\engine\sp\utility::add_start("alley", &scripts\sp\maps\embassy\embassy_infil::alley_start, "Alley", &scripts\sp\maps\embassy\embassy_infil::alley_main, "embassy_building_and_streets", &scripts\sp\maps\embassy\embassy_infil::alley_catchup);
  scripts\engine\sp\utility::add_start("residence_arrival", &scripts\sp\maps\embassy\embassy_defend::residence_arrival_start, "Residence Arrival", &scripts\sp\maps\embassy\embassy_defend::residence_arrival_main, "embassy_building_and_streets_and_compund", &scripts\sp\maps\embassy\embassy_defend::residence_arrival_catchup);
  scripts\engine\sp\utility::add_start("approach", &scripts\sp\maps\embassy\embassy_defend::defend_approach_start, "Approach", &scripts\sp\maps\embassy\embassy_defend::defend_approach_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_approach_catchup);
  scripts\engine\sp\utility::add_start("movement", &scripts\sp\maps\embassy\embassy_defend::defend_wave_0_start, "Movement", &scripts\sp\maps\embassy\embassy_defend::defend_wave_0_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_0_catchup);
  scripts\engine\sp\utility::add_start("flare", &scripts\sp\maps\embassy\embassy_defend::defend_wave_1_start, "Flare", &scripts\sp\maps\embassy\embassy_defend::defend_wave_1_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_1_catchup);
  scripts\engine\sp\utility::add_start("trucks", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_trucks_start, "Trucks", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_trucks_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_trucks_catchup);
  scripts\engine\sp\utility::add_start("mortar", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_mortars_start, "Mortar", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_mortars_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_mortars_catchup);
  scripts\engine\sp\utility::add_start("push", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_push_start, "Push", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_push_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_2_push_catchup);
  scripts\engine\sp\utility::add_start("triage_scene", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_triage_start, "Triage Scene", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_triage_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_triage_catchup);
  scripts\engine\sp\utility::add_start("building_fight", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_buildings_start, "Building Fight", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_buildings_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_3_buildings_catchup);
  scripts\engine\sp\utility::add_start("Unknown Car", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_targeting_start, "Unknown Car", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_targeting_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_targeting_catchup);
  scripts\engine\sp\utility::add_start("laser_targeting_2", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_technicles_start, "Laser Targeting_2", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_technicles_main, "embassy_streets_and_anims_mid", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_technicles_catchup);
  scripts\engine\sp\utility::add_start("snipers", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_snipers_start, "snipers", &scripts\sp\maps\embassy\embassy_defend::defend_wave_4_snipers_main, "embassy_streets_and_anims_mid");
  scripts\engine\sp\utility::add_start("mortar_building_attack", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_attack_start, "Mortar Building Attack Start", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_attack_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_attack_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_boost", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_boost_start, "Boost", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_boost_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_boost_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_exterior", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_start, "Mortar Building", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wave_5_mortar_house_catchup);
  scripts\engine\sp\utility::add_start("mortar_building_rooftop", &scripts\sp\maps\embassy\embassy_defend::defend_wave_6_start, "Residence", &scripts\sp\maps\embassy\embassy_defend::defend_wave_6_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wave_6_catchup);
  scripts\engine\sp\utility::add_start("wolf_escapes", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_start, "Wolf Escapes", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_catchup);
  scripts\engine\sp\utility::add_start("wolf_escapes_scene", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_scene_start, "Wolf Escapes Scene", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_scene_main, "embassy_ending", &scripts\sp\maps\embassy\embassy_defend::defend_wolf_escapes_catchup);
  scripts\engine\sp\utility::add_start("Art", &art_start, "Art", &art_main, "embassy_streets_field_tr", &art_catchup);
  scripts\engine\sp\utility::add_start("cctv_bink", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_start, "cctv_bink", &scripts\sp\maps\embassy\embassy_cctv::security_cam_bink_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_cctv::security_cam_01_catchup);
  scripts\engine\sp\utility::add_start("cctv_outro_bink", &scripts\sp\maps\embassy\embassy_cctv::cctv_outro_bink_start, "cctv_outro_bink", &scripts\sp\maps\embassy\embassy_cctv::cctv_outro_bink_main, "embassy_building_all", &scripts\sp\maps\embassy\embassy_cctv::cctv_outro_bink_catchup);
  scripts\engine\sp\utility::set_default_start("infil_helicopter");
}

function mortar_anim() {
  scripts\sp\maps\embassy\embassy_defend::defend_inits();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player]);
  var0 = scripts\engine\sp\utility::spawn_targetname("ally_01_mortar", 1);
  var0.animname = "ally_01_mortar";
  var1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var1 scripts\common\anim::anim_single_solo(var0, "rooftops_begin");
}

function embassy_precache() {
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
  var0 = ["scaffolding_a", "scaffolding_b", "scaffolding_c"];

  foreach(var2 in var0) {
    hide_scaffolding_mayhem(var2);
  }

  scripts\engine\utility::flag_init("forever");
  scripts\sp\maps\embassy\embassy_infil::embassy_infil_precache();
  scripts\sp\maps\embassy\embassy_defend::embassy_defend_precache();
  scripts\sp\maps\embassy\embassy_cctv::embassy_cctv_precache();
}

function embassy_fx() {
  scripts\sp\maps\embassy\embassy_infil::embassy_infil_fx();
  scripts\sp\maps\embassy\embassy_defend::embassy_defend_fx();
  scripts\sp\maps\embassy\embassy_cctv::embassy_cctv_fx();
}

function hide_scaffolding_mayhem(var0) {
  hidemayhem(var0);
  hidemayhem(var0 + "_tarps");
}

function init_perimeter_lights() {
  wait 0.15;
  var0 = getscriptablearray("perimeter_lights", "targetname");
  var1 = getEntArray("light_spot", "classname");

  foreach(var3 in var0) {
    var1 = sortbydistance(var1, var3.origin);
    level thread scripts\sp\maps\embassy\embassy_defend::perimeter_light_ondeath(var3, var1[0]);
  }
}

function loadout() {
  var0 = level.player.meleeweapons;
  level.player takeallweapons();

  foreach(var2 in var0) {
    level.player scripts\engine\sp\utility::give_melee_weapon(var2);
  }

  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player scripts\engine\sp\utility::give_offhand("flash");

  if(scripts\sp\starts::is_after_start("infil_embassy_rooftop")) {
    GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_pi_golf21"));
  }

  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewmodel_arms_kyle_desert");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_kyle_desert");
  level.player scripts\sp\player::give_player_max_armor();
}

function firemode_feedback() {
  level.player endon("death");

  for(var0 = "_off";; var0 = scripts\engine\utility::ter_op(var0 == "_off", "_on", "_off")) {
    while(nullweapon(level.player getcurrentweapon())) {
      waitframe();
    }

    var1 = level.player getcurrentweapon();
    var2 = 0;

    if(issubstr(var1.basename, "sel")) {
      var2 = 1;
    }

    level.player waittill("weapon_change", var3);
    var4 = createheadicon(var3);

    if(var2 && issubstr(var4, "sel")) {
      level.player playRumbleOnEntity("damage_heavy");
      level.player playSound("wpfoly_acog_ads_toggle" + var0);
      level.player forceplaygestureviewmodel("ges_fall_back", undefined, 0.05, 0.97);
    }
  }
}

function adjust_allowed_civilian_deaths() {
  if(!scripts\sp\starts::is_after_start("infil_saferoom")) {
    scripts\engine\utility::flag_wait("friendly_penalties_lowered");
    var0 = level.friendlyfire["max_participation"];
    var1 = level.player.participation;
    level.friendlyfire["max_participation"] = level.friendlyfire["friend_kill_points"] * -2;
    level.player.participation = level.friendlyfire["friend_kill_points"] * -2;
    scripts\engine\utility::flag_waitopen("friendly_penalties_lowered");
    level.friendlyfire["max_participation"] = var0;
    level.player.participation = var1;
    return;
  }
}

function art_start() {}

function art_main() {}

function art_catchup() {}

function spawn_funcs() {
  var0 = scripts\engine\utility::array_combine(getspawnerarray("patrol_03"), getspawnerarray("patrol_01"), getspawnerarray("table_beating_enemy"));
  var1 = scripts\engine\utility::array_combine(getspawnerarray("wave_0_enemies"), getspawnerarray("wave_0_1_enemies"), getspawnerarray("wave_0_2_enemies"));
  var2 = scripts\engine\utility::array_combine(getspawnerarray("wave_1"), getspawnerarray("wave_1_extra_1"), getspawnerarray("wave_1_extra_2"), getspawnerarray("wave_1_extra_3"));
  var3 = scripts\engine\utility::array_combine(getspawnerarray("wave_2_enemies"), getspawnerarray("wave_2_extra_1"), getspawnerarray("wave_2_extra_2"), getspawnerarray("wave_2_extra_3"), getspawnerarray("push_inside__refill"));
  var4 = scripts\engine\utility::array_combine(getspawnerarray("scaffolding_a_guys"), getspawnerarray("scaffolding_b_guys"), getspawnerarray("scaffolding_c_guys"), getspawnerarray("guard_rails_guys"));
  var5 = scripts\engine\sp\utility::get_spawner_array("wave_4_street_guys", "script_noteworthy");
  var5 = scripts\engine\utility::array_combine(var5, getspawnerarray("horde_02"));
  var6 = getspawnerarray("wave_4_corner_guys");
  var7 = scripts\engine\utility::array_combine(getspawnerarray("wave_4_field_1"), getspawnerarray("wave_4_field_2"));
  var8 = getspawnerarray("mortar_house_guys");
  var9 = getspawnerarray("wave_5_mortar_house_exterior");
  var10 = getspawner("doorbust_guy", "script_noteworthy");
  var11 = getspawner("stairs_guy", "script_noteworthy");
  var12 = getspawner("suicide_bomber", "targetname");
  var13 = getspawnerarray("technical_dudes_01");
  var14 = getspawner("technical_dude_gunner_01", "targetname");
  var15 = getspawnerarray("technical_dudes_02");
  var16 = getspawnerarray("technical_dudes_03");
  var17 = getspawnerarray("technical_dudes_04");
  var18 = getspawnerarray("technical_dudes_05");
  var19 = getspawnerarray("technical_dudes_06");
  var20 = getspawnerarray("technical_dudes_07");
  var21 = getspawnerarray("technical_dudes_08");
  var22 = getspawnerarray("technical_dudes_09");
  var23 = getspawnerarray("technical_dudes_10");
  level.heli_guys = [];
  var10 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\embassy\embassy_defend::doorbust_guy_spawn_func);
  var11 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\embassy\embassy_defend::stairs_guy_spawn_func);
  var12 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\embassy\embassy_defend::suicide_bomber_spawn_func);
  var14 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\embassy\embassy_defend::wave_1_technical_gunner_spawn_func);
  scripts\engine\sp\utility::array_spawn_function(var0, &scripts\sp\maps\embassy\embassy_cctv::camera_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var1, &scripts\sp\maps\embassy\embassy_defend::distant_enemies_spawn_func);
  scripts\engine\sp\utility::array_spawn_function(var2, &scripts\sp\maps\embassy\embassy_defend::wave_1_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var3, &scripts\sp\maps\embassy\embassy_defend::wave_2_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var4, &scripts\sp\maps\embassy\embassy_defend::wave_3_building_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var5, &scripts\sp\maps\embassy\embassy_defend::wave_4_street_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var6, &scripts\sp\maps\embassy\embassy_defend::wave_4_corner_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var7, &scripts\sp\maps\embassy\embassy_defend::wave_5_street_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var9, &scripts\sp\maps\embassy\embassy_defend::wave_5_mortar_run_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var8, &scripts\sp\maps\embassy\embassy_defend::mortar_house_guys_behavior);
  scripts\engine\sp\utility::array_spawn_function(var13, &scripts\sp\maps\embassy\embassy_defend::wave_1_technical_enemy_behavior_01);
  scripts\engine\sp\utility::array_spawn_function(var15, &scripts\sp\maps\embassy\embassy_defend::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var16, &scripts\sp\maps\embassy\embassy_defend::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var17, &scripts\sp\maps\embassy\embassy_defend::wave_6_technical_04_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var18, &scripts\sp\maps\embassy\embassy_defend::wave_6_technical_05_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var19, &scripts\sp\maps\embassy\embassy_defend::wave_6_technical_06_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var20, &scripts\sp\maps\embassy\embassy_defend::wave_6_technical_07_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var21, &scripts\sp\maps\embassy\embassy_defend::wave_6_technical_08_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var22, &scripts\sp\maps\embassy\embassy_defend::wave_4_technical_03_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var23, &scripts\sp\maps\embassy\embassy_defend::wave_4_technical_03_enemy_behavior);
}

function embassy_flags() {
  scripts\engine\utility::flag_init("player_pushed_focus");
  scripts\engine\utility::flag_init("player_in_scene");
  scripts\engine\utility::flag_init("friendly_penalties_lowered");
  scripts\engine\utility::flag_init("audio_outside_crowd_loop");
  scripts\sp\maps\embassy\embassy_infil::embassy_infil_flags();
  scripts\sp\maps\embassy\embassy_defend::embassy_defend_flags();
  scripts\sp\maps\embassy\embassy_cctv::embassy_cctv_flags();
  scripts\sp\maps\embassy\embassy_util::embassy_util_flags();
}

function embassy_hints() {
  scripts\sp\maps\embassy\embassy_infil::embassy_infil_hints();
}

function embassy_inits() {
  level.autosave.enemydistcheck = 0;
  scripts\sp\maps\embassy\embassy_infil::embassy_infil_init();
  scripts\sp\maps\embassy\embassy_cctv::embassy_cctv_init();
}