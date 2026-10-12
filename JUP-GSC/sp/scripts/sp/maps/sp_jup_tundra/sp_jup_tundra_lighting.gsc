/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting.gsc
********************************************************************/



#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace sp_jup_tundra_lighting;

function main() {
  utility::post_load_precache(&function_bf161307a213ad69);
  lighting::light_init();
  init_flags();
}

function init_flags() {
  utility::flag_init("dof_before_trigger_ready");
  utility::flag_init("dof_after_trigger_ready");
  utility::flag_init("dof_after_explosion");
  utility::flag_init("dof_veh01_take_down_start");
  utility::flag_init("dof_veh01_take_down_end");
}

function function_bf161307a213ad69() {}

function function_6897558dfb39aa64() {
  wait 0.2;
  level.player enablephysicaldepthoffieldscripting();
  wait 0.2;
  level.player setphysicaldepthoffield(0.6, 1, 0.2, 0.2);
  wait 2;
  level.player setphysicaldepthoffield(1.2, 50, 4.5, 2);
  wait 4.5;
  level.player setphysicaldepthoffield(1.4, 90, 1.5, 2);
  wait 2;
  level.player thread utility::dof_enable_autofocus(28, level.price, 3, 3, undefined, "j_wrist_le");
  wait 5;
}

function function_5298f777621c5db() {
  wait 0.2;
  level.player enablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(28, undefined, 2.5, 2.5);
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_detonate_005", 5, 50000);
  wait 8;
  level.player setphysicaldepthoffield(4, 110, 2, 2);
  utility::flag_wait("dof_before_trigger_ready");
  wait 1.25;
  level.player thread utility::dof_enable_autofocus(28, undefined, 6, 4);
  wait 2;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_disable_autofocus();
}

function function_2e27831383e65419() {
  wait 0.2;
  utility::flag_wait("veh01_player_takedown_start");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(6, 18, 4, 4);
  wait 6.5;
  wait 0.2;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_disable_autofocus();
}

function function_daeb375b8068a30a() {
  wait 0.2;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  wait 0.2;
  level.player setphysicaldepthoffield(4, 35, 2, 2);
  wait 12.5;
  level.player setphysicaldepthoffield(4, 14, 3, 3);
  wait 2;
  level.player setphysicaldepthoffield(3, 17, 3, 3);
  wait 4;
  level.player setphysicaldepthoffield(3.5, 30, 35, 35);
  wait 1;
  level.player setphysicaldepthoffield(3, 17, 35, 35);
  wait 3;
  level.player setphysicaldepthoffield(3, 30, 5, 5);
  wait 4;
  level.player setphysicaldepthoffield(2.5, 34, 5, 5);
  wait 5;
  level.player setphysicaldepthoffield(3, 28, 5, 5);
  wait 3.5;
  level.player setphysicaldepthoffield(4.5, 40, 3, 3);
  wait 6.5;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_disable_autofocus();
  wait 0.2;
}

function function_15c17e3a7339336e() {
  wait 0.1;
  thread function_cee2f8effa73eb79();
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_001", 0, 0);
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_002", 0, 0);
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_005", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_fill", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_rim", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_top", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_torch_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_extract_uplight", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_004", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_009", 0, 0);
  lerp_spot_intensity("omni_veh_01_fill", 0, 0);
  lerp_spot_intensity("omni_veh_01_fill_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_fill", 0, 100);
  lerp_spot_intensity("lighting_01_cinematic_intro_rim", 0, 4000);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_001", 0, 5000);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_002", 0, 500);
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 5, 3800);
  lerp_spot_intensity("lighting_01_cinematic_detonate_002", 5, 15000);
  thread function_6897558dfb39aa64();
}

function function_cee2f8effa73eb79() {
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_001", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_001", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_002", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_004", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_005", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_007", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_008", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_009", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_010", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_012", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_014", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_016", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_017", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_018", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_019", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_020", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_021", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_022", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_023", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_024", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_025", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_026", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_027", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_028", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_029", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_030", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_031", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_032", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_033", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_034", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_035", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_036", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_037", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_038", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_039", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_040", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_041", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_043", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_044", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_046", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_047", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_048", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_049", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_050", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_051", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_052", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_053", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_055", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_056", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_057", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_058", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_059", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_060", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_061", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_062", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_063", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_064", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_065", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_066", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_067", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_068", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_069", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_070", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_071", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_072", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_073", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_074", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_075", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_076", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_077", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_078", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_079", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_080", 0, 0);
  lerp_spot_intensity("lighting_NEW_uplights_081", 0, 0);
}

function function_f714a8596d55fdc6() {
  wait 0.05;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(12, 110, 4, 4);
  level.player thread utility::dof_enable_autofocus(2, undefined, 6, 6);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_001", 0, 30000);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_002", 0, 50000);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 0, 20000);
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 10, 4000);
  lerp_spot_intensity("lighting_01_cinematic_intro_fill", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_rim", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_top", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_002", 0, 0);
  wait 4;
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_detonate_005", 5, 30000);
  lerp_spot_intensity("lighting_01_cinematic_detonate_003", 1, 120);
  wait 5;
  level.player thread utility::dof_enable_autofocus(28, undefined, 1, 1);
  wait 3;
  level.player thread utility::dof_disable_autofocus();
  utility::flag_wait("dof_before_trigger_ready");
}

function function_b5c58f7313680759() {
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_intro_uplight_001", 0, 30000);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_intro_uplight_002", 0, 50000);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 0, 20000);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_detonate_001", 0, 4000);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_detonate_003", 0, 120);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_detonate_005", 0, 30000);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_002", 0, 0);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_003", 0, 0);
  scripts\common\lighting::lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 0, 0);
  thread function_cee2f8effa73eb79();
}

function function_351a30b5a2b23f92() {
  wait 0.5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(28, 110, 4, 4);
}

function function_76d126b1903cb419() {
  wait 1;
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_001", 4, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_002", 5, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 5, 0);
  wait 0.2;
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 12, 0);
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_detonate_003", 6, 200);
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_detonate_002", 7, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_003", 6, 0);
  wait 6;
  lerp_spot_intensity("lighting_01_cinematic_detonate_005", 6, 0);
  wait 3;
  lerp_spot_intensity("omni_veh_01_fill", 4, 500);
  lerp_spot_intensity("omni_veh_01_fill_002", 4, 300);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 2, 400);
  level.player thread utility::dof_enable_autofocus(28, undefined, 6, 2);
  wait 4;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 2, 800);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_003", 2, 300);
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_004", 2, 750);
  utility::trigger_wait_targetname("intro_flag_dome_04_on_trig");
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 1, 10);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 1, 400);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_02_rim_002", 4, 200);
  level.player thread utility::dof_disable_autofocus();
}

function function_68563c5b6707be36() {
  wait 0.2;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(3, 15, 5, 5);
  lerp_spot_intensity("lighting_01_cinematic_takedown_001", 0.1, 20);
  lerp_spot_intensity("omni_veh_01_fill_002", 1, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_02_rim_002", 1, 35);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 1, 150);
  wait 10;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 0.5, 100);
  wait 2.5;
  lerp_spot_intensity("lighting_01_cinematic_takedown_001", 2, 0);
  lerp_spot_intensity("omni_veh_01_fill_002", 2, 200);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_02_rim_002", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 2, 200);
  wait 0.5;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_disable_autofocus();
}

function function_f2d397de671c4106() {
  wait 0.2;
  thread function_66fc988eb1eb4d9a();
  thread function_daeb375b8068a30a();
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 2, 30);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 1, 4);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 1, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 0, 0);
  wait 1.9;
  wait 3;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 0.5, 150);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 0.5, 50);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 0.5, 100);
  wait 5.6;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_torch_001", 0, 150);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_009", 2, 30);
  wait 1.1;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_torch_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_004", 2, 0);
  wait 10.3;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 1, 120);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 1, 100);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 2, 120);
  lerp_spot_intensity("fake_sky_light_001", 2, 6000);
  lerp_spot_intensity("fake_sky_light_002", 2, 6000);
  lerp_spot_intensity("fake_sky_light_003", 2, 6000);
  lerp_spot_intensity("fake_sky_light_004", 2, 6000);
  lerp_spot_intensity("fake_sky_light_005", 2, 6000);
  wait 4;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 1, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 1, 0);
  wait 1;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 4, 0);
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_extract_uplight", 2, 100);
  wait 2;
  wait 2;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_009", 5, 0);
  thread function_5074bd2cec487f36();
}

function function_66fc988eb1eb4d9a() {
  wait 0.2;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_003", 0, 0);
  lerp_spot_intensity("omni_veh_01_fill", 2, 0);
  lerp_spot_intensity("omni_veh_01_fill_002", 2, 0);
  lerp_spot_intensity("car_004_hazard_light_001", 2, 0);
  lerp_spot_intensity("car_004_hazard_light_001_spot", 2, 0);
  lerp_spot_intensity("car_004_hazard_light_002", 2, 0);
  lerp_spot_intensity("car_004_hazard_light_002_spot", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_003", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_002", 2, 0);
}

function function_5a34f5aa53fc3d08() {
  wait 0.2;
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 2, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 2, 0);
}

function function_5074bd2cec487f36() {
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_001", 0, 0);
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_002", 0, 0);
  lerp_spot_intensity("lighting_01_cine_intro_uplight_extra_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_detonate_005", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_bg_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_fill", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_rim", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_top", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_intro_uplight_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_takedown_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_extract_torch_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_003", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_extract_uplight", 0, 0);
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_004", 0, 0);
  lerp_spot_intensity("omni_veh_01_fill", 0, 0);
  lerp_spot_intensity("omni_veh_01_fill_002", 0, 0);
  wait 6;
  lerp_spot_intensity("fake_sky_light_001", 3, 0);
  lerp_spot_intensity("fake_sky_light_002", 3, 0);
  lerp_spot_intensity("fake_sky_light_003", 3, 0);
  lerp_spot_intensity("fake_sky_light_004", 3, 0);
  lerp_spot_intensity("fake_sky_light_005", 3, 0);
}

function function_4ed440b189e29d12() {
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_001", 4, 0);
}

function function_4ed43fb189e29adf() {
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_002", 4, 0);
}

function function_4b47f9bc027eaf12() {
  lerp_spot_intensity("lighting_01_cinematic_vehicle_rim_004", 4, 0);
}

function function_8ae161287c9ca604() {
  wait 1;
  var_6303df312c8d30b6 = getEnt("in_water_trigger", "targetname");

  if(isDefined(var_6303df312c8d30b6)) {
    if(level.player istouching(var_6303df312c8d30b6)) {
      setsaveddvar(@ "sm_sunsamplesizenear", 5);
      return;
    }

    setsaveddvar(@ "sm_sunsamplesizenear", 0.025);
  }
}