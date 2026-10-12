/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_milbase\sp_jup_milbase_lighting.gsc
**********************************************************************/



#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\lights;
#using scripts\sp\utility;
#using scripts\sp\vision;
#namespace sp_jup_milbase_lighting;

function main() {
  post_load_precache(&function_bf161307a213ad69);
  scripts\sp\lights::init();
  scripts\common\lighting::light_init();
  thread anim_sp::letterbox_enable(0, 0);
  thread setup_flickerlight_presets();
  thread play_lights();
  thread function_3f35a5c4023a3d66();
  thread function_94a9e2a3d2a56c56();
  thread function_43e6626b2f24503c();
  thread function_67b410f43834c751();
  thread function_b259a8f6deec57ea();
  thread function_b0c69eb4c5c04de3();
  level.var_de75283c123dcbb7 = 0;
  level.var_d2e76b124d4d0219 = getEntArray("sfx_light_white", "targetname");
  level.var_f7d9831c340db03 = getEntArray("sfx_light_red", "targetname");
}

function function_bf161307a213ad69() {
  level.visionnakeddefault = "sp_jup_milbase";
  level.current_visionset = "sp_jup_milbase";
}

function function_3f35a5c4023a3d66() {
  wait 0.05;
  run_thread_on_targetname("milbase_office_flow_lgt_trig", &milbase_office_flow_lgt_trig);
}

function milbase_office_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_milbase", 0.8);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_94a9e2a3d2a56c56() {
  wait 0.05;
  run_thread_on_targetname("milbase_interior_lgt_trig", &milbase_interior_lgt_trig);
}

function milbase_interior_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_milbase_interior", 0.8);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_43e6626b2f24503c() {
  wait 0.05;
  run_thread_on_targetname("milbase_roof_lgt_trig", &milbase_roof_lgt_trig);
}

function milbase_roof_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_milbase_cine_exfil", 0.5);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function setup_flickerlight_presets() {
  create_flickerlight_preset("firelight_motion_medium", (1, 0.2246, 0), (1, 0.25, 0), 30, 0.05, 0.2, 20);
  create_flickerlight_preset("electric_medium", (0, 0.2246, 1), (0, 0.4, 1), 1, 0.05, 0.2, 2);
  create_flickerlight_preset("pulse_medium", (0, 1, 0), (0, 0, 1), 1, 0.5, 2, 2);
  create_flickerlight_preset("pulse_red", (1, 0, 0), (0, 0, 0), 3, 1.5, 3, 2);
  create_flickerlight_preset("pulse_red_dim", (1, 0, 0), (0, 0, 0), 300, 1.5, 3, 2);
  function_bf134e4c6c36436("flicker1", 5, 40, 0.05, 0.15, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker2", 0.05, 0.5, 0.05, 0.25, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker4", 850, 0.5, 0.05, 0.4, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker5", 0.1, 5, 0.01, 0.05, 3, 15, 0.1, 3);
  function_bf134e4c6c36436("flicker12", 0.005, 397.89, 0.01, 0.05, 3, 15, 0.1, 3);
  function_bf134e4c6c36436("flicker13", 0.005, 6.37, 0.01, 0.05, 3, 15, 0.1, 3);
  function_bf134e4c6c36436("flickerflare", 25, 40, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare1", 15, 20, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare2", 2, 4, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare3", 20, 30, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare4", 5, 10, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare5", 70, 100, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("door_flicker", 5, 10, 0.01, 0.02, 2, 4, 0.01, 0.02);
  function_bf134e4c6c36436("beeping_01", 0.001, 200, 0.01, 1.5, 1, 2, 0.01, 2);
}

function play_lights() {
  wait 0.2;
  function_bb536503bca3484c("flicker1", "electric01");
  function_bb536503bca3484c("flicker2", "pulse01");
  function_bb536503bca3484c("flicker4", "electric02");
  function_bb536503bca3484c("flicker5", "pulse02");
  function_bb536503bca3484c("flicker12", "Corridor_ceilings_lgt_02");
  function_bb536503bca3484c("flicker13", "Corridor_ceilings_lgt_03");
  function_bb536503bca3484c("door_flicker", "cellar_door_main_lgt");
  function_bb536503bca3484c("door_flicker", "cellar_door_main_lgt_01");
  function_bb536503bca3484c("beeping_01", "beeping_01");
}

function lights_flicker() {
  thread lerp_spot_intensity("lobby_desk_Lamp_lgt_01", 0.025, 0);
  thread lerp_spot_intensity("Lobby_lgt_main", 0.025, 0);
  thread lerp_spot_intensity("lobby_downlights_lgt_01", 0.025, 0);
  thread lerp_spot_intensity("Corridor_ceilings_lgt", 0.025, 0);
  thread lerp_spot_intensity("red_wall_corridor_lgt_02", 0.5, 3.22);
  thread lerp_spot_intensity("red_wall_corridor_lgt_01", 0.5, 71.62);
  thread lerp_spot_intensity("green_gas_lgt_01", 0.5, 716.2);
  thread lerp_spot_intensity("green_gas_lgt_02", 0.5, 143.24);
  thread lerp_spot_intensity("green_gas_lgt_03", 0.05, 397.89);
  thread lerp_spot_intensity("green_gas_lgt_04", 0.05, 477.46);
  thread lerp_spot_intensity("elevator_yuri_lgt", 0.05, 59.68);
  thread function_7461930061f9770f();
  thread function_d2072b05e3481e8d();
}

function cp_escape() {
  set_vision_naked("sp_jup_milbase", 0);
  thread lerp_spot_intensity("lobby_desk_Lamp_lgt_01", 0.025, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key", 0.05, 10);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_monitor_rim", 0.05, 10);
  thread lerp_spot_intensity("red_wall_corridor_lgt_02", 0.05, 3.22);
  thread lerp_spot_intensity("red_wall_corridor_lgt_01", 0.05, 71.62);
  thread lerp_spot_intensity("green_gas_lgt_01", 0.05, 716.2);
  thread lerp_spot_intensity("green_gas_lgt_02", 0.05, 143.24);
  thread lerp_spot_intensity("green_gas_lgt_03", 0.05, 397.89);
  thread lerp_spot_intensity("green_gas_lgt_04", 0.05, 477.46);
  thread lerp_spot_intensity("elevator_yuri_lgt", 0.05, 59.68);
  thread lerp_spot_intensity("lgt_cine_yuri_15_exit_fill", 0.05, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_corridor_fill", 0.05, 0);
}

function function_1be9145b47c4b31d() {
  thread function_61a998996cc98831();
  setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
  setsaveddvar(@ "hash_eca4b727b01fd254", 2);
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
}

function function_26280fbed5700639() {
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_cb82c01fec2d534b", 8);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_1ea8544d78048529", 1);
  }

  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
}

function function_67b410f43834c751() {
  anim_org = utility::getStruct("milbase_infil", "targetname");
  wait 0.05;
  laswell_01 = anim_org scene::get_entity("laswell_01");
  flag_wait("lgt_cine_approaching");
  set_vision_naked("sp_jup_milbase_cine", 1);
  thread function_1be9145b47c4b31d();
  thread function_6342c97b5439f5bb(laswell_01);
  flag_wait("lgt_cine_closeup");
  flag_wait("lgt_cine_laswell_arrived");
  wait 2.5;
  scripts\sp\anim::letterbox_enable(0, 2);
  flag_wait("lgt_cine_laswell_stop");
  level waittill("lgt_cine_infil_end");
  set_vision_naked("sp_jup_milbase", 1.5);
  thread function_26280fbed5700639();
}

function function_b259a8f6deec57ea() {
  flag_wait("lgt_cine_scene_starts");
  set_vision_naked("sp_jup_milbase_cine_yuri", 1);
  thread function_1be9145b47c4b31d();
  thread function_ba559e6f3495ff4();
  setsaveddvar(@ "hash_1ea8544d78048529", 15);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
  setsaveddvar(@ "hash_eca4b727b01fd254", 3);
  setsaveddvar(@ "hash_93b4b56b615317b9", 250);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key", 0.5, 111.41);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_monitor_rim", 0.5, 24.59);
  thread lerp_spot_intensity("lgt_cine_laswell_corridor_fill", 0.5, 10);
  thread lerp_spot_intensity("lgt_cine_room_pc_fill_03", 0.5, 35.81);
  thread lerp_spot_intensity("lgt_cine_yuri_17_room_fill", 0.5, 3.18);
  thread lerp_spot_intensity("lgt_cine_laswell_close_door_pc_01", 0.5, 7.96);
  thread lerp_spot_intensity("lgt_cine_laswell_enter_rim_01", 0.5, 3.18);
  flag_wait("lgt_cine_laswell_reach_door");
  thread lerp_spot_intensity("lgt_cine_laswell_enter_rim_02", 0.5, 5.57);
  thread lerp_spot_intensity("lgt_cine_laswell_corridor_fill", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_enter_rim_01", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_enter_rim_02", 0.5, 0);
  flag_wait("lgt_cine_laswell_runs_to_yuri");
  thread lerp_spot_intensity("lgt_cine_laswell_talking_headset_rim", 0, 1.2);
  thread lerp_spot_intensity("lgt_cine_room_fill_back", 0, 0.4);
  thread lerp_spot_intensity("lgt_cine_laswell_rim_headset_01", 2.5, 48);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_02", 3, 27.85);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 20);
  flag_wait("lgt_cine_bomb_goess_off");
  thread lerp_spot_intensity("lgt_cine_room_pc_fill_03", 3, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_talking_headset_rim", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_fill_05", 0.05, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_02", 0.05, 0);
  thread lerp_spot_intensity("lgt_cine_room_pc_fill", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_room_pc_fill_02", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_room_fill_back", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_17_room_fill", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_rim_headset_01", 0.5, 0);
  thread function_d2072b05e3481e8d();
  thread set_vision_naked("sp_jup_milbase_cine_yuri_dust", 0.5);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 50);
  flag_wait("lgt_cine_lobby_lgt_off");
  thread lerp_spot_intensity("Lobby_lgt_main", 0.05, 0);
  thread lerp_spot_intensity("lobby_downlights_lgt_01", 0.05, 0);
  thread lerp_spot_intensity("Corridor_ceilings_lgt", 0.05, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key", 0.05, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_monitor_rim", 0.05, 0);
  thread lerp_spot_intensity("green_gas_lgt_01", 0.05, 716.2);
  thread lerp_spot_intensity("green_gas_lgt_02", 0.05, 143.24);
  thread lerp_spot_intensity("green_gas_lgt_03", 0.05, 397.89);
  thread lerp_spot_intensity("green_gas_lgt_04", 0.05, 477.46);
  flag_wait("lgt_cine_yuri_runs_to_door");
  thread lerp_spot_intensity("lgt_cine_yuri_01_usb_key_fill", 0.05, 21.92);
  thread lerp_spot_intensity("lgt_cine_laswell_lightsoff_pc", 0.05, 5.57);
  thread lerp_spot_intensity("lgt_cine_laswell_lightsoff_table", 0.05, 5.57);
  thread lerp_spot_intensity("elevator_yuri_lgt", 0.05, 59.68);
  flag_wait("lgt_cine_yuri_opes_door");
  thread lerp_spot_intensity("lgt_cine_yuri_15_exit_fill", 0.05, 0.95);
  flag_wait("lgt_cine_looking_at_laswell");
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_monitor_rim", 0.05, 24.59);
  flag_wait("lgt_cine_laswell_looking_at_usb");
  thread lerp_spot_intensity("lgt_cine_yuri_15_exit_fill", 0.05, 0);
  flag_wait("lgt_cine_laswell_face_close_up");
  scripts\sp\anim::letterbox_enable(0, 1.5);
  level waittill("lgt_cine_yuri_end");
  thread lerp_spot_intensity("lgt_cine_yuri_01_usb_key_fill", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_yuri_01_pc_key_monitor_rim", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_lightsoff_pc", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_laswell_lightsoff_table", 0.5, 0);
  thread function_26280fbed5700639();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 0);
  wait 0.5;
  set_vision_naked("sp_jup_milbase", 1.5);
  wait 1;
}

function function_b0c69eb4c5c04de3(laswell, nikolai) {
  placement = getStruct("milbase_exfil_eyepos", "targetname");
  wait 0.05;
  laswell = placement scene::get_entity("laswell");
  nikolai = placement scene::get_entity("nikolai");
  wait 0.5;
  flag_wait("lgt_cine_runtoward_heli");
  set_vision_naked("sp_jup_milbase_cine_exfil", 1);
  thread function_1be9145b47c4b31d();
  thread function_b5f0378af9b938b1(laswell, nikolai);
  scripts\sp\anim::letterbox_enable(1, 1.5);
  level.player showviewmodel();
  wait 1;
  flag_wait("lgt_cine_jumpinto_heli");
  level.player hideviewmodel();
  thread lerp_spot_intensity("lgt_cine_exfil_rim_get_up_01", 0.5, 6.37);
  flag_wait("lgt_cine_landed_heli");
  thread lerp_spot_intensity("lgt_cine_exfil_rim_look_outside_fill_02", 0.5, 15.92);
  thread lerp_spot_intensity("lgt_cine_exfil_fake_sun_rim_02", 0.5, 15.92);
  thread lerp_spot_intensity("lgt_cine_exfil_rim_look_outside_01", 0.5, 43.77);
  thread lerp_spot_intensity("lgt_cine_exfil_sun_laswell_arm", 0.5, 23.87);
  flag_wait("lgt_cine_set_up");
  thread lerp_spot_intensity("lgt_cine_exfil_polit_thumb_up_01", 0.5, 95.49);
  flag_wait("lgt_cine_look_outside");
  flag_wait("lgt_cine_looking_at_pilot");
  flag_wait("lgt_cine_gave_thumbup");
  thread lerp_spot_intensity("lgt_cine_exfil_polit_thumb_up_01", 2, 0);
  thread lerp_spot_intensity("lgt_cine_exfil_sun_laswell_arm", 0.5, 0);
  flag_wait("lgt_cine_heli_flysoff");
  thread lerp_spot_intensity("lgt_cine_exfil_fake_sun_rim_02", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_exfil_rim_get_up_01", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_exfil_rim_look_outside_fill_02", 0.5, 0);
  thread lerp_spot_intensity("lgt_cine_exfil_rim_look_outside_01", 0.5, 0);
  thread function_26280fbed5700639();
}

function function_6342c97b5439f5bb(laswell_01) {
  flag_wait("lgt_cine_approaching");
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  wait 0.05;
  level.player thread utility::dof_enable_autofocus(3.2, laswell_01, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_cine_closeup");
  level.player thread utility::dof_enable_autofocus(4, laswell_01, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_cine_laswell_arrived");
  level.player thread utility::dof_enable_autofocus(3, laswell_01, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_cine_closeup_head");
  level.player thread utility::dof_enable_autofocus(4.2, laswell_01, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_cine_laswell_stop");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 1500, 2, 2);
  wait 0.5;
  level.player setphysicaldepthoffield(4, 2500, 5, 5);
  level waittill("lgt_cine_infil_end");
  level.player disablephysicaldepthoffieldscripting();
  wait 0.5;
  level.player disablephysicaldepthoffieldscripting();
}

function function_ba559e6f3495ff4() {
  flag_wait("lgt_cine_scene_starts");
  wait 0.5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2.8, 20.6, 40, 40);
  flag_wait("lgt_cine_laswell_reach_door");
  level.player setphysicaldepthoffield(2.8, 20.6, 40, 40);
  flag_wait("lgt_cine_laswell_cam_pullback");
  level.player setphysicaldepthoffield(3.2, 40, 40, 40);
  flag_wait("lgt_cine_laswell_entering");
  level.player setphysicaldepthoffield(3.2, 22, 40, 40);
  flag_wait("lgt_cine_laswell_runs_to_yuri");
  level.player setphysicaldepthoffield(3.2, 130, 30, 30);
  flag_wait("lgt_cine_bomb_goess_off");
  level.player setphysicaldepthoffield(3.2, 92, 30, 30);
  flag_wait("lgt_cine_lobby_lgt_off");
  level.player setphysicaldepthoffield(3.2, 32.51, 30, 30);
  flag_wait("lgt_cine_yuri_runs_to_door");
  level.player setphysicaldepthoffield(3.2, 79.92, 30, 30);
  flag_wait("lgt_cine_looking_at_laswell");
  level.player setphysicaldepthoffield(3.4, 58.89, 30, 30);
  flag_wait("lgt_cine_laswell_looking_at_usb");
  level.player setphysicaldepthoffield(3.4, 31.77, 30, 30);
  flag_wait("lgt_cine_laswell_face_close_up");
  level waittill("lgt_cine_yuri_end");
  level.player disablephysicaldepthoffieldscripting();
}

function function_b5f0378af9b938b1(laswell, nikolai) {
  flag_wait("lgt_cine_runtoward_heli");
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  wait 0.05;
  level.player thread utility::dof_enable_autofocus(1, laswell, 30, 30, undefined, "j_thumb_ri_3");
  flag_wait("lgt_cine_runtoward_heli");
  wait 0.5;
  level.player thread utility::dof_enable_autofocus(2, laswell, 30, 30, undefined, "j_helmet");
  wait 1;
  flag_wait("lgt_cine_jumpinto_heli");
  level.player thread utility::dof_enable_autofocus(2, laswell, 30, 30, undefined, "j_helmet");
  flag_wait("lgt_cine_landed_heli");
  level.player thread utility::dof_enable_autofocus(1.8, laswell, 30, 30, undefined, "j_ball_ri");
  flag_wait("lgt_cine_set_up");
  level.player thread utility::dof_enable_autofocus(1.8, laswell, 30, 30, undefined, "j_head");
  flag_wait("lgt_cine_look_outside");
  level.player thread utility::dof_enable_autofocus(1.8, laswell, 30, 30, undefined, "j_head");
  flag_wait("lgt_cine_looking_at_pilot");
  level.player thread utility::dof_enable_autofocus(1.8, nikolai, 30, 30, undefined, "j_wrist_ri");
  flag_wait("lgt_cine_gave_thumbup");
  level.player thread utility::dof_enable_autofocus(1.8, nikolai, 30, 30, undefined, "j_wrist_ri");
  wait 0.5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 250, 30, 30);
  flag_wait("lgt_cine_heli_flysoff");
  level.player disablephysicaldepthoffieldscripting();
  level.player disablephysicaldepthoffieldscripting();
}

function function_7461930061f9770f() {
  spots = getEntArray("white_wall_flicker_spots", "targetname");
  spots2 = getEntArray("white_wall_flicker_spots2", "targetname");

  foreach(light in spots) {
    foreach(lights in spots2) {
      light setlightintensity(0);
      lights setlightintensity(0);
    }
  }

  while(true) {
    thread function_35cadef737423263();
    thread lerp_spot_intensity("white_wall_flicker_spots", 0, 925);
    thread lerp_spot_intensity("white_wall_flicker_spots2", 0, 120);
    wait 0.1;
    thread lerp_spot_intensity("white_wall_flicker_spots", 0.15, 0);
    thread lerp_spot_intensity("white_wall_flicker_spots2", 0.3, 0);
    wait 0.85;
  }
}

function function_d2072b05e3481e8d() {
  spots = getEntArray("red_wall_flicker_spots", "targetname");
  spots2 = getEntArray("red_wall_flicker_spots2", "targetname");

  foreach(light in spots) {
    foreach(lights in spots2) {
      light setlightintensity(0);
      lights setlightintensity(0);
    }
  }

  while(true) {
    thread function_105fa09032209fa5();
    thread lerp_spot_intensity("red_wall_flicker_spots", 0, 200);
    thread lerp_spot_intensity("red_wall_flicker_spots2", 0, 20);
    wait 0.1;
    thread lerp_spot_intensity("red_wall_flicker_spots", 0.3, 0);
    thread lerp_spot_intensity("red_wall_flicker_spots2", 0.175, 0);
    wait 0.75;
  }
}

function function_35cadef737423263() {
  if(level.var_de75283c123dcbb7 < 3) {
    foreach(light in level.var_d2e76b124d4d0219) {
      light playSound("sfx_white_light_pulse");
    }
  }

  level.var_de75283c123dcbb7 += 1;

  if(level.var_de75283c123dcbb7 == 4) {
    level.var_de75283c123dcbb7 = 0;
  }
}

function function_105fa09032209fa5() {
  foreach(light in level.var_f7d9831c340db03) {
    light playSound("sfx_red_light_pulse");
  }
}