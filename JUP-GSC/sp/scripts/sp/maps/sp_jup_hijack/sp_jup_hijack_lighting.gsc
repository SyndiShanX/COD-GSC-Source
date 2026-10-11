/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting.gsc
***********************************************************************/

#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#using scripts\sp\vision;
#namespace sp_jup_hijack_lighting;

function main() {
  post_load_precache(&function_bf161307a213ad69);
  scripts\common\lighting::light_init();
  thread function_95238bbeaa618750();
  thread auto_dof();
  thread setup_flickerlight_presets();
  thread anim_sp::letterbox_enable(0, 0);
  thread function_fe37660adcbfb21d();
  thread wind_manage();
  thread function_a263e5861c5f3d28();
  flag_init("wind_on");
  flag_init("door_open");
  setsaveddvar(@ "hash_1ea8544d78048529", 0);
}

function function_bf161307a213ad69() {}

function function_95238bbeaa618750() {
  thread lerp_spot_intensity("lgt_ending_flashing_up", 0, 0);
  thread lerp_spot_intensity("lgt_ending_flashing_down", 0, 0);
  thread lerp_spot_intensity("lgt_ending_flashing_side", 0, 0);
}

function auto_dof() {
  level.player thread utility::dof_enable_autofocus(8, undefined, 5, 2);
}

function setup_flickerlight_presets() {
  create_flickerlight_preset("firelight_motion_medium", (0.7, 0.2246, 0), (0.7, 0.25, 0), 30, 0.05, 0.2, 20);
  function_bf134e4c6c36436("flashing_up", 0.05, 0.5, 0.05, 1, 3, 7, 0.1, 1.5);
}

function function_f8c846b71840b96d() {
  thread lerp_spot_intensity("wall_top_fill", 0, 0);
  set_vision_naked("sp_jup_vip_ext", 0.8);
  setsuncolorandintensity(0);
  setsundirection(anglesToForward((-16, 41.27, 0)));
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 500, 15, 50);
  setsaveddvar(@ "hash_1048f749a8b7aa91", 1);
  setsaveddvar(@ "hash_5a83a561cb4970b2", 1);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.5);
  setsaveddvar(@ "hash_36561ce503889667", 0.5);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.5);
  anim_sp::letterbox_enable(1, 1);
  thread anim_sp::letterbox_enable(0, 1.5);
}

function function_1be9145b47c4b31d() {
  thread function_61a998996cc98831();
  setsaveddvar(@ "hash_1dde331a8e0153d8", 12);
  setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 4);
  setsaveddvar(@ "hash_eca4b727b01fd254", 8);
  setsaveddvar(@ "hash_e08232af8b8b695c", 7);

  if(isplatformpc()) {
    setsaveddvar(@ "hash_63eb1893f96ac98d", 12);
  }

  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
}

function function_26280fbed5700639() {
  thread function_9160006a3f10b2cd();
  level.player thread utility::dof_enable_autofocus(8, undefined, 5, 2);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_cb82c01fec2d534b", 8);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_1ea8544d78048529", 1);
  }

  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
}

function function_bfddb1a3d19ec26c() {
  thread lerp_spot_intensity("lgt_intro_kid_key", 0, 4);
  wait 12;
  thread lerp_spot_intensity("lgt_intro_kid_key", 0, 0);
}

function function_fe37660adcbfb21d() {
  thread lerp_spot_intensity("cabin_tv_lights", 0, 0);
  flag_wait("lgt_intro_start");
  thread anim_sp::letterbox_enable(1, 0);
  animnode = getStruct("scene_hij_010_intro", "targetname");
  neighbor = animnode scene::get_entity("neighbor");
  stewardess = animnode scene::get_entity("stewardess");
  samara_3p = animnode scene::get_entity("samara_3p");
  player = animnode scene::get_entity("Player");
  child = animnode scene::get_entity("child");
  thread function_a44b977b4b9b4f37(animnode, neighbor, stewardess, samara_3p, player, child);
  thread function_1be9145b47c4b31d();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 200);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1.5);
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  thread function_bfddb1a3d19ec26c();
  thread lerp_spot_intensity("lgt_intro_phone_screen", 0, 0.3);
  thread lerp_spot_intensity("lgt_intro_rim_1", 0, 0);
  thread lerp_spot_intensity("lgt_intro_rim_1_intro", 0, 1);
  wait 0.1;
  setsaveddvar(@ "hash_6e3f8cef6be16b33", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 1);
  flag_wait("lgt_intro_phone");
  setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
  setsaveddvar(@ "hash_eca4b727b01fd254", 8);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 40);
  thread lerp_spot_intensity("cabin_lights_intro_off", 2, 0);
  thread lerp_spot_intensity("lgt_intro_phone_screen", 1, 0);
  thread lerp_spot_intensity("lgt_intro_rim_1", 1, 3);
  thread lerp_spot_intensity("lgt_intro_rim_1_intro", 1, 0);
  thread lerp_spot_intensity("lgt_intro_phone_screen_2", 1, 0.15);
  thread lerp_spot_intensity("lgt_intro_key_1", 3, 0.8);
  wait 2;
  thread lerp_spot_intensity("cabin_lights_intro_on", 2, 31);
  level waittill("lgt_look_left");
  level waittill("lgt_look_right");
  level waittill("lgt_look_left");
  level waittill("lgt_phone_and_neighbour");
  thread lerp_spot_intensity("lgt_intro_phone_screen_2", 1, 0.2);
  level waittill("lgt_look_face");
  thread lerp_spot_intensity("lgt_intro_phone_screen_2", 1, 0.1);
  flag_wait("lgt_intro_stand");
  thread lerp_spot_intensity("lgt_intro_rim_1", 1, 0);
  thread lerp_spot_intensity("lgt_intro_rim_2", 1, 0);
  thread lerp_spot_intensity("lgt_intro_phone_screen", 0, 0);
  thread lerp_spot_intensity("lgt_intro_fill_2", 2, 2);
  thread lerp_spot_intensity("lgt_intro_phone_screen_2", 1, 0);
  thread lerp_spot_intensity("lgt_intro_fill_stand", 2.5, 1.5);
  thread lerp_spot_intensity("cabin_lights_intro_on", 1, 0);
  thread lerp_spot_intensity("cabin_lights_intro_off", 1, 15.92);
  level waittill("lgt_intro_stand_end");
  flag_wait("lgt_intro_end");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_6e3f8cef6be16b33", 0);
    setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  }

  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  thread lerp_spot_intensity("lgt_intro_rim_2", 0, 0);
  thread lerp_spot_intensity("lgt_intro_fill_2", 0, 0);
  thread lerp_spot_intensity("lgt_intro_fill_stand", 0, 0);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(8, undefined, 5, 2);
  thread function_26280fbed5700639();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1500);
  thread lerp_spot_intensity("lgt_intro_rim_1", 0, 0);
  thread lerp_spot_intensity("lgt_intro_screen_1", 0, 0);
  thread lerp_spot_intensity("lgt_intro_key_1", 0, 0);
  thread lerp_spot_intensity("lgt_intro_rim_2", 0, 0);
  thread lerp_spot_intensity("lgt_intro_fill_2", 0, 0);
}

function function_a44b977b4b9b4f37(animnode, neighbor, stewardess, samara_3p, player, child) {
  wait 0.05;
  level.player thread utility::dof_enable_autofocus(1, child, 49, 49, undefined, "tag_helmetlight");
  wait 4;
  level.player thread utility::dof_enable_autofocus(10, undefined, 3, 3);
  wait 1;
  level.player thread utility::dof_enable_autofocus(5, undefined, 2, 2);
  wait 1;
  level.player thread utility::dof_enable_autofocus(5, neighbor, 10, 10, undefined, "tag_helmetlight");
  wait 0.5;
  level.player thread utility::dof_enable_autofocus(3, neighbor, 10, 10, undefined, "tag_helmetlight");
  wait 0.5;
  level.player thread utility::dof_enable_autofocus(1, neighbor, 1, 1, undefined, "tag_helmetlight", stewardess);
  flag_wait("lgt_intro_dof_samara");
  level.player thread utility::dof_enable_autofocus(4, samara_3p, 5, 5, undefined, "tag_helmetlight", stewardess);
  wait 0.5;
  level.player thread utility::dof_enable_autofocus(1, samara_3p, 20, 20, undefined, "tag_helmetlight");
  flag_wait("lgt_intro_dof_phone");
  level.player thread utility::dof_enable_autofocus(6, samara_3p, 5, 5, undefined, "tag_accessory_left");
  thread anim_sp::letterbox_enable(0, 2);
  flag_wait("lgt_intro_phone");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 15, 1, 1);
  level waittill("lgt_look_left");
  level.player thread utility::dof_enable_autofocus(1.5, neighbor, 10, 10, undefined, "tag_helmetlight");
  level waittill("lgt_look_right");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(3, 15, 10, 10);
  level waittill("lgt_look_left");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(1.5, neighbor, 10, 10, undefined, "tag_helmetlight");
  level waittill("lgt_phone_and_neighbour");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 18, 2, 1);
  level waittill("lgt_look_finger");
  level.player setphysicaldepthoffield(5, 20, 2, 1);
  level waittill("lgt_look_face");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(2.5, neighbor, 10, 10, undefined, "tag_helmetlight");
  level waittill("lgt_intro_stand");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 37, 1, 1);
  level waittill("lgt_intro_stand_end");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 37, 1, 1);
  thread function_ad4a9ef7d71ab546(animnode, neighbor, stewardess, samara_3p);
  thread function_8c97dd6577c78ea6(animnode, neighbor, stewardess, samara_3p);
}

function hide_every_frame() {
  self endon("death");
  level.player_rig endon("death");
  level.player_rig endon("kill_hide_every_frame");

  while(true) {
    level.player_rig hide();
    waitframe();
  }
}

function function_ad4a9ef7d71ab546(animnode, neighbor, stewardess, samara_3p) {
  flag_wait("lgt_intro_gun_grab");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(4, neighbor, 49, 49, undefined, "J_wrist_le");
  flag_wait("lgt_intro_gun_punch");
  level.player thread utility::dof_enable_autofocus(2, neighbor, 49, 49, undefined, "tag_helmetlight");
  wait 1;
  flag_wait("lgt_intro_gun_up");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 300);
  level.player thread utility::dof_disable_autofocus();
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  level.player disablephysicaldepthoffieldscripting();
  wait 1.8;
  level.player thread utility::dof_enable_autofocus(8, undefined, 5, 2);
}

function function_8c97dd6577c78ea6(animnode, neighbor, stewardess, samara_3p) {
  flag_wait("lgt_intro_end_dof");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 300);
  level.player disablephysicaldepthoffieldscripting();
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  wait 2;
  level.player thread utility::dof_enable_autofocus(8, undefined, 5, 2);
}

function function_510e7fb47810f595(animnode) {
  wait 0.05;
  level waittill("player_punched_start");
  actor_1 = animnode scene::get_entity("Actor 1");
  level.player thread utility::dof_enable_autofocus(1, actor_1, 49, 49, undefined, "j_head");
  level waittill("player_punched");
  level.player thread utility::dof_disable_autofocus();
  setblur(5, 0.25);
  level waittill("player_punched_end");
  setblur(0, 0);
}

function function_d20e92819af22401(animnode) {
  thread function_1be9145b47c4b31d();
  thread function_cc295a5efc71614b(animnode);
  thread function_43b720da40f9db5d();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 50);
  set_vision_naked("sp_jup_hijack_ending", 0.5);
  thread lerp_spot_intensity("lgt_ending_flashing_down_center", 0, 100);
  thread lerp_spot_intensity("lgt_ending_flashing_down", 0, 100);
  thread lerp_spot_intensity("lgt_para_side_cabin", 0, 20);
  thread lerp_spot_intensity("cine_enter_economy_orange", 0, 4);
  thread lerp_spot_intensity("cine_enter_economy_orange_2", 0, 2);
  thread lerp_spot_intensity("lgt_para_key_2", 0, 10);
  thread lerp_spot_intensity("lgt_para_key_1", 0, 20);
  thread lerp_spot_intensity("lgt_para_key_new", 0, 15);
  thread lerp_spot_intensity("lgt_para_top_omni", 0, 0);
  thread lerp_spot_intensity("lgt_para_fixture_down", 0, 0);
  thread lerp_spot_intensity("cabin_tv_lights", 0, 0);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  wait 0.05;
  actor_1 = animnode scene::get_entity("Actor 1");
}

function function_cc295a5efc71614b(animnode) {
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 50, 49, 49);
  level waittill("lgt_look_left");
  level.player setphysicaldepthoffield(2, 50, 49, 49);
  level waittill("lgt_look_straight");
  level.player setphysicaldepthoffield(2, 50, 49, 49);
  level waittill("lgt_look_left");
  level.player setphysicaldepthoffield(2, 50, 49, 49);
  level waittill("lgt_look_straight");
  level.player setphysicaldepthoffield(2, 50, 49, 49);
  level waittill("lgt_first_class_stop");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 150);
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(3, 30, 25, 25);
  wait 1;
  level.player setphysicaldepthoffield(4, 15, 25, 25);
  wait 0.5;
  level.player disablephysicaldepthoffieldscripting();
}

function function_43b720da40f9db5d() {
  wait 2;
  set_vision_naked("sp_jup_hijack_ending_dark", 1);
  wait 1;
  set_vision_naked("sp_jup_hijack_ending", 1);
  wait 1;
  set_vision_naked("sp_jup_hijack_ending_dark", 1);
  wait 1;
  set_vision_naked("sp_jup_hijack_ending", 1);
}

function function_c40e793c5a31c2f7(animnode) {
  wait 0.05;
  set_vision_naked("sp_jup_hijack_ending", 0.5);
  player_1 = animnode scene::get_entity("Player 1");
  makarov = animnode scene::get_entity("Makarov");
  steward = animnode scene::get_entity("steward");
  main_hijacker = animnode scene::get_entity("main_hijacker");
  second_hijacker = animnode scene::get_entity("second_hijacker");
  thread function_f49c958270137c85(player_1, makarov, steward, main_hijacker, second_hijacker);
  thread lerp_spot_intensity("lgt_para_key_new", 0, 15);
  thread lerp_spot_intensity("lgt_para_fill_new", 0, 0.5);
  thread lerp_spot_intensity("lgt_para_back_red", 0, 3);
  thread lerp_spot_intensity("lgt_para_back_red_fill", 0, 0.5);
  thread lerp_spot_intensity("lgt_para_back_red_kick", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_1", 0, 0);
  thread lerp_spot_intensity("lgt_para_fill_hijacker", 0, 0);
  thread lerp_spot_intensity("lgt_vest_door_open_off_lgt_01", 0, 0);
  thread lerp_spot_intensity("lgt_vest_door_open_off_lgt", 0, 0);
  thread lerp_spot_intensity("cine_para_top_cabin", 0, 0);
  wait 0.05;
  thread lerp_spot_intensity("lgt_para_side_cabin", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_orange", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_orange_2", 0, 0);
  flag_wait("lgt_mak_para_stop");
  thread lerp_spot_intensity("lgt_para_fill_left", 1, 3);
  thread lerp_spot_intensity("lgt_ending_flashing_down_center", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_1", 0, 0);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  flag_wait("lgt_mak_para_2nd_guy");
  thread lerp_spot_intensity("lgt_para_fill_left", 1, 0);
  thread lerp_spot_intensity("lgt_para_key_new", 2, 15);
  level waittill("lgt_mak_look_down");
  thread lerp_spot_intensity("lgt_para_key_2", 3, 3);
  level waittill("lgt_mak_look_up");
  flag_wait("lgt_mak_look_back");
  thread lerp_spot_intensity("lgt_para_key_new", 2, 10);
  flag_wait("lgt_mak_para_pre_door_open");
  flag_wait("lgt_mak_para_door_open");
  steward setscriptablepartstate("wind", "80", 0);
  main_hijacker setscriptablepartstate("wind", "100", 0);
  second_hijacker setscriptablepartstate("wind", "100", 0);
  makarov setscriptablepartstate("wind", "100", 0);
  wait 1;
  thread lerp_spot_intensity("lgt_vest_door_open", 0, 50);
  thread lerp_spot_intensity("lgt_vest_door_open_fill", 0, 7);
  thread lerp_spot_intensity("lgt_vest_door_open_bounce", 0, 10);
  thread lerp_spot_intensity("lgt_vest_door_open_off_lgt", 0, 0);
  thread function_933efe1877b5e28e();
  flag_wait("lgt_para_turn");
  thread lerp_spot_intensity("lgt_para_fill_new", 0, 0);
  thread lerp_spot_intensity("lgt_para_fixture_down", 0, 0);
  level waittill("lgt_mak_para_end");
  thread lerp_spot_intensity("lgt_vest_door_open", 0, 0);
  thread lerp_spot_intensity("cine_para_top_cabin", 0, 0);
  thread lerp_spot_intensity("lgt_para_side_cabin", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_1", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_2", 0, 0);
  thread lerp_spot_intensity("lgt_para_fill_2", 0, 0);
  thread lerp_spot_intensity("lgt_para_rim_2", 0, 0);
  thread lerp_spot_intensity("lgt_para_back_red", 0, 0);
  thread lerp_spot_intensity("lgt_para_back_red_fill", 0, 0);
  thread lerp_spot_intensity("lgt_para_back_red_kick", 0, 0);
}

function function_f49c958270137c85(player_1, makarov, var_5011329942afef99, main_hijacker, neighbor) {
  flag_wait("lgt_mak_para_stop");
  wait 1.5;
  level.player thread utility::dof_enable_autofocus(1, main_hijacker, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_mak_para_2nd_guy");
  level.player thread utility::dof_enable_autofocus(2.5, makarov, 49, 49, undefined, "tag_helmetlight");
  wait 7;
  level.player thread utility::dof_enable_autofocus(4, makarov, 5, 5, undefined, "tag_helmetlight");
  level waittill("lgt_mak_look_down");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 15, 49, 49);
  level waittill("lgt_mak_look_up");
  level.player setphysicaldepthoffield(4, 25, 20, 20);
  wait 1;
  level.player setphysicaldepthoffield(4, 22, 10, 10);
  level waittill("lgt_mak_phone_up");
  level.player setphysicaldepthoffield(5, 14, 49, 49);
  level waittill("lgt_mak_phone_hand_off");
  wait 0.5;
  level.player setphysicaldepthoffield(4, 50, 5, 5);
  level waittill("lgt_mak_look_down");
  level.player setphysicaldepthoffield(5, 12, 49, 49);
  level waittill("lgt_blink_start");
  thread player_bomb_blinking();
  thread function_8d0cbb338cb1d6b5(90);
  level waittill("lgt_mak_look_hand");
  level.player setphysicaldepthoffield(4, 10, 49, 49);
  lgt_para_key_new = getEnt("lgt_para_key_new", "targetname");
  lgt_para_key_new thread lerplightradius(0.75, 48);
  level waittill("lgt_mak_look_head");
  level.player setphysicaldepthoffield(4, 20, 49, 49);
  level waittill("lgt_mak_look_hand");
  level.player setphysicaldepthoffield(5, 10, 49, 49);
  flag_wait("lgt_mak_look_up");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(5, makarov, 49, 49, undefined, "tag_eye");
  flag_wait("lgt_mak_look_back");
  lgt_para_key_new = getEnt("lgt_para_key_new", "targetname");
  lgt_para_key_new thread lerplightradius(0.75, 50);
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 55, 20, 20);
  wait 2;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(5, makarov, 15, 15, undefined, "tag_eye");
  flag_wait("lgt_mak_para_pre_door_open");
  lgt_para_key_new thread lerplightradius(0.75, 60);
  flag_wait("lgt_mak_para_door_open");
  wait 0.7;
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  flag_wait("lgt_mak_jump");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 100, 25, 25);
  wait 4;
  level.player setphysicaldepthoffield(4, 20, 25, 25);
  level waittill("lgt_mak_para_end");
}

function function_933efe1877b5e28e() {
  if(!flag("door_open")) {
    flag_set("door_open");
    thread function_5fb8b1c04076392d();
    wait 1;
    thread lerp_spot_intensity("cabin_tv_lights", 0, 0);
    thread lerp_spot_intensity("lgt_para_key_new", 1, 0);
    thread lerp_spot_intensity("lgt_para_fill_new", 1, 0);
    wait 0.05;
    light1 = getEnt("lgt_para_fixture_down", "script_noteworthy");
    thread lerp_spot_intensity("lgt_para_key_1", 0, 0);
    light5 = getEnt("lgt_para_key_2", "targetname");
    light7 = getEnt("lgt_para_fill_2", "targetname");
    light8 = getEnt("lgt_para_rim_2", "targetname");
    var_747e06c0b98abc58 = [light1, light5, light7, light8];

    if(isDefined(var_747e06c0b98abc58)) {
      foreach(light in var_747e06c0b98abc58) {
        light setlightcolor((0.1, 0.1, 0.1));
        j = randomfloatrange(0.5, 2);
        i = randomfloatrange(0.1, 0.5);
        light thread lighting::blink_light(j, i, 0.01);
      }
    }

    wait 1.5;
    thread lerp_spot_intensity("lgt_para_key_3", 1, 5);
    flag_wait("lgt_para_turn");
    thread lerp_spot_intensity("cabin_lights", 0, 0);
    set_vision_naked("sp_jup_hijack_ending", 0.5);
    thread lerp_spot_intensity("lgt_ending_flashing_down", 0, 15);
    wait 0.05;
    lights = getEntArray("lgt_ending_flashing_down", "targetname");

    if(isDefined(lights)) {
      foreach(light in lights) {
        light setlightcolor((0, 0.3, 0.3));
        j = randomfloatrange(1, 3);
        i = randomfloatrange(0.1, 0.5);
        light thread lighting::blink_light(j, i, 0.01);
      }
    }

    wait 0.05;
    var_dc9fcc6f4d5375a5 = getEntArray("lgt_ending_flashing_up", "targetname");

    if(isDefined(var_dc9fcc6f4d5375a5)) {
      foreach(light in var_dc9fcc6f4d5375a5) {
        light setlightintensity(0.1);
        light setlightcolor((0, 0.3, 0.3));
        j = randomfloatrange(1, 10);
        i = randomfloatrange(0.1, 0.5);
        light thread lighting::blink_light(j, i, 0.01);
      }
    }

    wait 0.05;
    var_dc9fcc6f4d5375a5 = getEntArray("lgt_ending_flashing_side", "targetname");

    if(isDefined(var_dc9fcc6f4d5375a5)) {
      foreach(light in var_dc9fcc6f4d5375a5) {
        light setlightintensity(0.1);
        light setlightcolor((0.4, 0.25, 0.1));
        j = randomfloatrange(0.5, 2.5);
        i = randomfloatrange(0.1, 0.5);
        light thread lighting::flicker_light(j, i, 0.3, 1);
      }
    }
  }
}

function function_ea9880e4a1f28d26(animnode) {
  flag_wait("lgt_enter_economy_start");
  thread function_1be9145b47c4b31d();
  waitframe();
  player_1 = animnode scene::get_entity("Player 1");
  actor_1 = animnode scene::get_entity("Actor 1");
  civ_blocker_01 = animnode scene::get_entity("civ_blocker_01");
  takedown_civ_phone = animnode scene::get_entity("takedown_civ_phone");
  takedown_civ_r = animnode scene::get_entity("takedown_civ_r");
  thread function_fafc5205edb57e0(actor_1, civ_blocker_01, player_1, takedown_civ_phone);
  thread function_933efe1877b5e28e();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 100);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1.5);
  thread lerp_spot_intensity("seatbeltLight_01", 0, 1);
  thread lerp_spot_intensity("lgt_para_key_new", 0, 5);
  thread lerp_spot_intensity("lgt_para_key_3", 0, 1.5);
  thread lerp_spot_intensity("lgt_economy_down_green", 0, 5);
  thread lerp_spot_intensity("cine_enter_economy_orange", 0, 4);
  flag_wait("lgt_wind_off");
  flag_wait("lgt_enter_economy_stop");
  thread lerp_spot_intensity("lgt_economy_down_green", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_new", 0, 0);
  thread lerp_spot_intensity("lgt_para_key_3", 0, 0);
  thread lerp_spot_intensity("lgt_ending_flashing_down", 2, 0);
  thread lerp_spot_intensity("cine_enter_economy_key", 1, 2);
  thread lerp_spot_intensity("cine_enter_economy_fill", 1, 1);
  flag_wait("lgt_enter_economy_curtain_open");
  thread lerp_spot_intensity("cine_enter_economy_rim", 0.5, 10);
  flag_wait("lgt_enter_economy_curtain_push");
  setsaveddvar(@ "hash_e08232af8b8b695c", 7);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 15);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_6e3f8cef6be16b33", 0);
    setsaveddvar(@ "hash_e08232af8b8b695c", 4);
    setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  }

  if(isplatformps5() || isplatformxb4()) {
    setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  }

  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 200);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 3);
  thread lerp_spot_intensity("cine_enter_economy_orange_2", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_rim", 0.1, 0);
  wait 1;
  thread lerp_spot_intensity("cine_para_top_cabin", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_key", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_rim", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_orange", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_fill", 0, 0);
  thread lerp_spot_intensity("cine_enter_economy_orange_2", 0, 2);
  wait 2.5;
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  flag_wait_either("flag_weapon_fire_attempted", "flag_take_player_down");
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 3);
  countdown_phone = animnode scene::get_entity("countdown_phone");
  thread function_a3f6e3e178503e71(takedown_civ_phone, takedown_civ_r, countdown_phone);
  wait 0.05;
  thread function_fb683c4b79940399(player_1);
  level.accelerationfactor = 0.1;
  flag_wait("hij_0700_explosion");
  set_vision_naked("sp_jup_hijack_ending_explosion", 0.4);
  flag_wait("lgt_enter_economy_end");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 300);
}

function function_a3f6e3e178503e71(takedown_civ_phone, takedown_civ_r, countdown_phone) {
  wait 0.75;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 19, 49, 49);
  flag_wait("lgt_tackled_kick");
  level.player thread utility::dof_enable_autofocus(1, undefined, 10, 10);
  wait 1.5;
  level.player thread utility::dof_enable_autofocus(1.5, countdown_phone, 45, 45, undefined, "TAG_ORIGIN");
  wait 1.5;
  level.player thread utility::dof_enable_autofocus(1.5, countdown_phone, 45, 45, undefined, "TAG_ORIGIN");
}

function function_fb683c4b79940399(player_1) {
  key2 = getEnt("lgt_tackled_key", "targetname");
  thread lerp_spot_intensity("lgt_tackled_key", 0.25, 10);
  key = getEnt("lgt_tackled_ground_key", "targetname");
  fill = getEnt("lgt_tackled_ground_fill", "targetname");
  top = getEnt("lgt_tackled_top", "targetname");
  top_end = getEnt("lgt_tackled_top_end", "targetname");
  rim = getEnt("lgt_tackled_rim", "targetname");
  var_3bbc602edc0f5741 = getStruct("cine_exfil_ground_target", "targetname");
  key_diff = key.origin[0] - var_3bbc602edc0f5741.origin[0];
  fill_diff = fill.origin[0] - var_3bbc602edc0f5741.origin[0];
  top_diff = top.origin[0] - var_3bbc602edc0f5741.origin[0];
  var_590daf1d5cf659fc = top_end.origin[0] - var_3bbc602edc0f5741.origin[0];
  rim_diff = rim.origin[0] - var_3bbc602edc0f5741.origin[0];
  wait 0.05;
  var_3bbc602edc0f5741.origin = player_1.origin;
  key_new = var_3bbc602edc0f5741.origin[0] + key_diff + 60;
  fill_new = var_3bbc602edc0f5741.origin[0] + fill_diff + 60;
  top_new = var_3bbc602edc0f5741.origin[0] + top_diff + 50;
  var_16fa52d7d4255957 = var_3bbc602edc0f5741.origin[0] + var_590daf1d5cf659fc + 200;
  rim_new = var_3bbc602edc0f5741.origin[0] + rim_diff + 150;
  key2 moveTo((player_1.origin[0], key2.origin[1], key2.origin[2]), 0.01);
  wait 0.05;
  wait 1;
  thread lerp_spot_intensity("lgt_tackled_rim", 0.25, 5);
  wait 0.5;
  thread lerp_spot_intensity("lgt_tackled_ground_key", 0.5, 10);
  thread lerp_spot_intensity("lgt_mak_exit_rims", 0.5, 0);

  if(isplatformxb4() || isplatformps5() || isplatformpc()) {
    thread lerp_spot_intensity("lgt_tackled_rim", 0.25, 5);
    thread lerp_spot_intensity("lgt_tackled_ground_fill", 0.5, 4);
    thread lerp_spot_intensity("lgt_tackled_top", 0.5, 20);
  }

  wait 0.5;
  key movex(key_new, 0.01);
  top movex(top_new, 0.01);
  top_end movex(var_16fa52d7d4255957, 0.01);
  fill movex(fill_new, 0.01);
  rim movex(rim_new, 0.01);
  wait 4;
  thread lerp_spot_intensity("lgt_tackled_top_end", 0.25, 40);
  wait 0.5;
  thread lerp_spot_intensity("lgt_tackled_key", 0.25, 0);
  thread lerp_spot_intensity("lgt_tackled_rim", 0.25, 0);
}

function function_fafc5205edb57e0(actor_1, civ_blocker_01, player_1, takedown_civ_phone) {
  flag_wait("lgt_para_turn");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(2.5, actor_1, 5, 5, undefined, "j_head");
  flag_wait("lgt_enter_economy_stop");
  level.player thread utility::dof_enable_autofocus(2.5, actor_1, 5, 5, undefined, "tag_helmetlight");
  flag_wait("lgt_enter_economy_curtain_open");
  level.player thread utility::dof_enable_autofocus(10, actor_1, 15, 15, undefined, "tag_helmetlight");
  flag_wait("lgt_enter_economy_curtain_push");
  flag_wait("lgt_enter_economy_look_down");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(10, 20, 25, 25);
  flag_wait("lgt_enter_economy_stand");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(4, undefined, 5, 2);
}

function function_5fb8b1c04076392d() {
  setsaveddvar(@ "hash_351ca4838eccf185", 1);

  for(;;) {
    t = round(randomfloatrange(0.5, 1.5), 0.1);
    e = round(randomfloatrange(1, 3), 0.1);
    i = round(randomfloatrange(0.05, 0.2), 0.1);
    wait 0.05;
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", e, i);
    wait i;
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 0, i);
    wait t;
  }
}

function wind_manage() {
  for(;;) {
    flag_wait("wind_on");

    if(isDefined(level.ally1)) {
      level.ally1 setscriptablepartstate("wind", "100", 0);
    }

    if(isDefined(level.ally2)) {
      level.ally2 setscriptablepartstate("wind", "100", 0);
    }

    if(isDefined(level.makarov)) {
      level.makarov setscriptablepartstate("wind", "100", 0);
    }

    while(flag("wind_on")) {
      waitframe();
    }

    if(isDefined(level.ally1)) {
      level.ally1 setscriptablepartstate("wind", "0", 0);
    }

    if(isDefined(level.ally2)) {
      level.ally2 setscriptablepartstate("wind", "0", 0);
    }

    if(isDefined(level.makarov)) {
      level.makarov setscriptablepartstate("wind", "0", 0);
    }
  }
}

function function_a263e5861c5f3d28() {
  flag_wait("flag_mexican_standoff_begin");
  thread lerp_spot_intensity("intro_curtain_lights", 3, 160);
}

function player_bomb_blinking(var_f2d1551733441221) {
  lgt_para_key_new = getEnt("lgt_player_bomb_blinking", "targetname");
  childthread model_flicker_preset("lgt_player_bomb_blinking", 1000, 2, 2, undefined, undefined, 0.25, 0.256, 2, 2.1, "lgt_player_bomb_blinking_off", undefined, 0, "jup_hijack_scn_makarov_reveal_bomb_beep");
  player = level.player;

  if(isDefined(var_f2d1551733441221)) {
    player = level.player;
  }

  if(isDefined(player.chest_tag)) {
    player.chest_tag delete();
  }

  player.tag_chest = spawn_tag_origin();
  tag_chest = player.tag_chest;
  tag_chest show();
  lgt_para_key_new linkTo(tag_chest);

  if(isDefined(var_f2d1551733441221)) {
    tag_chest linktoplayerview(player, "tag_camera", (0, 15, -57), (-10, 0, 0), 0);
    return;
  }

  tag_chest linktoplayerview(player, "tag_camera", (0, 15, -57), (-10, 0, 0), 0);
}

function function_872ab8327e05cf14() {
  setsaveddvar(@ "hash_351ca4838eccf185", 1);
  t = round(randomfloatrange(0.5, 1.5), 0.15);
  e = round(randomfloatrange(-1, -0.6), 0.15);
  i = round(randomfloatrange(0.2, 0.45), 0.15);
  wait 0.05;
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", e, i);
  wait i;
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 0, i);
  wait t;
  setsaveddvar(@ "hash_351ca4838eccf185", 0);
}

function function_8d0cbb338cb1d6b5(timeleft) {
  level.accelerationfactor = 1;
  finalacceleration = 0.03;
  stepsize = (level.accelerationfactor - finalacceleration) / timeleft * 20;

  while(level.accelerationfactor > finalacceleration) {
    level.accelerationfactor -= stepsize;

    if(level.accelerationfactor < finalacceleration) {
      level.accelerationfactor = finalacceleration;
    }

    wait 0.05;
    timeleft -= 0.05;
  }
}