/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_anim.gsc
**************************************************/

main() {
  player();
  generic_human();
  script_models();
  vehicles();
  scriptables();
}

#using_animtree("player");

player() {
  setdvarifuninitialized("trailer_car_cam", 0);
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_kyle_sas_urban";
  level.scr_anim["player_rig"]["intro_slamzoom"] = % lon_pic_010_sas_enter_whole_plr;
  level.scr_goaltime["player_rig"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "sfx_plr_van_getout", ::sfx_plr_van_getout, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "player_fov", ::player_fov_change, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "intro_remove_fov_user_scale", ::intro_remove_fov_user_scale, "intro_slamzoom");
  scripts\common\anim::addnotetrack_notify("player_rig", "notify_fp", "fp_transition", "intro_slamzoom");
  scripts\common\anim::addnotetrack_notify("player_rig", "car_is_close", "car_is_close", "intro_slamzoom");
  scripts\common\anim::addnotetrack_notify("player_rig", "notify_exit_car", "get_out_of_car", "intro_slamzoom");
  level.scr_anim["player_rig"]["car_explosion"] = % lon_pic_010_plr_explosion;
  level.scr_goaltime["player_rig"]["car_explosion"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "first_raise", ::start_first_raise, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::car_explosion_add_fov_user_scale_override, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::car_explosion_remove_fov_user_scale_override, "car_explosion");
  scripts\common\anim::addnotetrack_notify("player_rig", "move_scene", "move_knockback_scene", "car_explosion");
  level.scr_anim["player_rig"]["car_explosion_short"] = % lon_pic_010_plr_explosion_short;
  level.scr_goaltime["player_rig"]["car_explosion_short"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "first_raise", ::start_first_raise, "car_explosion_short");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::car_explosion_add_fov_user_scale_override, "car_explosion_short");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::car_explosion_remove_fov_user_scale_override, "car_explosion_short");
  level.scr_anim["player_rig"]["car_explosion_left"] = % lon_pic_010_plr_explosion_left;
  level.scr_goaltime["player_rig"]["car_explosion_left"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "first_raise", ::start_first_raise, "car_explosion_left");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::car_explosion_add_fov_user_scale_override, "car_explosion_left");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::car_explosion_remove_fov_user_scale_override, "car_explosion_left");
  level.scr_anim["player_rig"]["car_jumper_cam"] = % pic_carterrorist_a_loop_shoot_cam;
  level.scr_anim["player_rig"]["price_spec_intro"] = % lon_tto_010_plr;
  level.scr_anim["player_rig"]["end_boom"] = % lon_bmb_020_boom_plr;
  level.scr_goaltime["player_rig"]["end_boom"] = 0.7;
  scripts\common\anim::addnotetrack_notify("player_rig", "fade_out", "fade_out_scene", "end_boom");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "audio_bomb_mix_start", ::audio_mix_bomb_explo, "end_boom");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "audio_mix_fade_start", ::audio_mix_fade_out_end_of_level, "end_boom");
}

start_first_raise(var_0) {
  level.player hideviewmodel();
  level.player enableweapons();
}

player_fov_change(var_0) {
  level.player modifybasefov(65, 1.7);
  level notify("cine_letterboxing");
  thread sfx_amb_car_int();
  wait 6;
  scripts\engine\utility::flag_set("camera_move_done");
}

sfx_amb_car_int() {
  level endon("intro_skipped");
  level.player setclienttriggeraudiozone("piccadilly_car_int", 3);
  level waittill("get_out_of_car");
  wait 2.5;
  level.player clearclienttriggeraudiozone(2.5);
}

start_ending_cinematic(var_0) {
  pausecinematicingame(0);
}

#using_animtree("generic_human");

generic_human() {
  level.scr_anim["civ1"]["intro_slamzoom"] = % lon_pic_010_civ01_enter;
  level.scr_goaltime["civ1"]["intro_slamzoom"] = 0;
  level.scr_anim["civ1"]["intro"][0] = % lon_pic_010_civ01_idle;
  level.scr_anim["civ1"]["intro_standoff"] = % lon_pic_010_civ01_standoff;
  level.scr_goaltime["civ1"]["intro_standoff"] = 0.6;
  level.scr_anim["civ1"]["intro_run"] = % lon_pic_010_civ01_explosion;
  level.scr_goaltime["civ1"]["intro_run"] = 0.2;
  level.scr_anim["civ1"]["intro_last_frame"][0] = % lon_pic_010_civ01_explosion_wounded_idle;
  level.scr_anim["civ2"]["intro_slamzoom"] = % lon_pic_010_civ02_enter;
  level.scr_goaltime["civ2"]["intro_slamzoom"] = 0;
  level.scr_anim["civ2"]["intro"][0] = % lon_pic_010_civ02_idle;
  level.scr_anim["civ2"]["intro_standoff"] = % lon_pic_010_civ02_standoff;
  level.scr_goaltime["civ2"]["intro_standoff"] = 0.4;
  level.scr_anim["civ2"]["intro_run"] = % lon_pic_010_civ02_explosion;
  level.scr_goaltime["civ2"]["intro_run"] = 0.2;
  level.scr_anim["civ2"]["intro_last_frame"][0] = % lon_pic_010_civ02_explosion_wounded_idle;
  level.scr_anim["civ3"]["intro_slamzoom"] = % lon_pic_010_civ03_enter;
  level.scr_goaltime["civ3"]["intro_slamzoom"] = 0;
  level.scr_anim["civ3"]["intro"][0] = % lon_pic_010_civ03_idle;
  level.scr_anim["civ3"]["intro_standoff"] = % lon_pic_010_civ03_standoff;
  level.scr_goaltime["civ3"]["intro_standoff"] = 0.4;
  level.scr_anim["civ3"]["intro_run"] = % lon_pic_010_civ03_explosion;
  level.scr_goaltime["civ3"]["intro_run"] = 0.2;
  level.scr_anim["civ3"]["intro_idle"][0] = % lon_pic_010_civ03_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ3", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ4"]["intro_slamzoom"] = % lon_pic_010_civ04_enter;
  level.scr_goaltime["civ4"]["intro_slamzoom"] = 0;
  level.scr_anim["civ4"]["intro"][0] = % lon_pic_010_civ04_idle;
  level.scr_anim["civ4"]["intro_standoff"] = % lon_pic_010_civ04_standoff;
  level.scr_goaltime["civ4"]["intro_standoff"] = 0.4;
  level.scr_anim["civ4"]["intro_run"] = % lon_pic_010_civ04_explosion;
  level.scr_goaltime["civ4"]["intro_run"] = 0.2;
  level.scr_anim["civ4"]["intro_idle"][0] = % lon_pic_010_civ04_explosion_wounded_idle;
  level.scr_anim["civ5"]["intro_slamzoom"] = % lon_pic_010_civ05_enter;
  level.scr_goaltime["civ5"]["intro_slamzoom"] = 0;
  level.scr_anim["civ5"]["intro"][0] = % lon_pic_010_civ05_idle;
  level.scr_anim["civ5"]["intro_standoff"] = % lon_pic_010_civ05_standoff;
  level.scr_goaltime["civ5"]["intro_standoff"] = 0.6;
  level.scr_anim["civ5"]["intro_run"] = % lon_pic_010_civ05_explosion;
  level.scr_goaltime["civ5"]["intro_run"] = 0.2;
  level.scr_anim["civ5"]["intro_last_frame"][0] = % lon_pic_010_civ05_explosion_wounded_idle;
  level.scr_anim["civ6"]["intro_slamzoom"] = % lon_pic_010_civ06_enter;
  level.scr_goaltime["civ6"]["intro_slamzoom"] = 0;
  level.scr_anim["civ6"]["intro"][0] = % lon_pic_010_civ06_idle;
  level.scr_anim["civ6"]["intro_standoff"] = % lon_pic_010_civ06_standoff;
  level.scr_goaltime["civ6"]["intro_standoff"] = 0.4;
  level.scr_anim["civ6"]["intro_run"] = % lon_pic_010_civ06_explosion;
  level.scr_goaltime["civ6"]["intro_run"] = 0.2;
  level.scr_anim["civ6"]["intro_idle"][0] = % lon_pic_010_civ06_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ6", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ7"]["intro_slamzoom"] = % lon_pic_010_civ07_enter;
  level.scr_goaltime["civ7"]["intro_slamzoom"] = 0;
  level.scr_anim["civ7"]["intro"][0] = % lon_pic_010_civ07_idle;
  level.scr_anim["civ7"]["intro_standoff"] = % lon_pic_010_civ07_standoff;
  level.scr_goaltime["civ7"]["intro_standoff"] = 0.6;
  level.scr_anim["civ7"]["intro_run"] = % lon_pic_010_civ07_explosion;
  level.scr_goaltime["civ7"]["intro_run"] = 0.2;
  level.scr_anim["civ7"]["intro_idle"][0] = % lon_pic_010_civ07_explosion_wounded_idle;
  level.scr_anim["civ8"]["intro_slamzoom"] = % lon_pic_010_civ08_enter;
  level.scr_goaltime["civ8"]["intro_slamzoom"] = 0;
  level.scr_anim["civ8"]["intro"][0] = % lon_pic_010_civ08_idle;
  level.scr_anim["civ8"]["intro_standoff"] = % lon_pic_010_civ08_standoff;
  level.scr_goaltime["civ8"]["intro_standoff"] = 0.4;
  level.scr_anim["civ8"]["intro_run"] = % lon_pic_010_civ08_explosion;
  level.scr_goaltime["civ8"]["intro_run"] = 0.2;
  level.scr_anim["civ8"]["intro_idle"][0] = % lon_pic_010_civ08_explosion_wounded_idle;
  level.scr_anim["civ9"]["intro_slamzoom"] = % lon_pic_010_civ09_enter;
  level.scr_goaltime["civ9"]["intro_slamzoom"] = 0;
  level.scr_anim["civ9"]["intro"][0] = % lon_pic_010_civ09_idle;
  level.scr_anim["civ9"]["intro_standoff"] = % lon_pic_010_civ09_standoff;
  level.scr_goaltime["civ9"]["intro_standoff"] = 0.4;
  level.scr_anim["civ9"]["intro_run"] = % lon_pic_010_civ09_explosion;
  level.scr_goaltime["civ9"]["intro_run"] = 0.2;
  level.scr_anim["civ9"]["intro_idle"][0] = % lon_pic_010_civ09_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ9", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ10"]["intro_slamzoom"] = % lon_pic_010_civ10_enter;
  level.scr_goaltime["civ10"]["intro_slamzoom"] = 0;
  level.scr_anim["civ10"]["intro"][0] = % lon_pic_010_civ10_idle;
  level.scr_anim["civ10"]["intro_standoff"] = % lon_pic_010_civ10_standoff;
  level.scr_goaltime["civ10"]["intro_standoff"] = 0.4;
  level.scr_anim["civ10"]["intro_run"] = % lon_pic_010_civ10_explosion;
  level.scr_goaltime["civ10"]["intro_run"] = 0.2;
  level.scr_anim["civ10"]["intro_idle"][0] = % lon_pic_010_civ10_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ10", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ11"]["intro_slamzoom"] = % lon_pic_010_civ11_enter;
  level.scr_goaltime["civ11"]["intro_slamzoom"] = 0;
  level.scr_anim["civ11"]["intro"][0] = % lon_pic_010_civ11_idle;
  level.scr_anim["civ11"]["intro_standoff"] = % lon_pic_010_civ11_standoff;
  level.scr_goaltime["civ11"]["intro_standoff"] = 0.6;
  level.scr_anim["civ11"]["intro_run"] = % lon_pic_010_civ11_explosion;
  level.scr_goaltime["civ11"]["intro_run"] = 0.2;
  level.scr_anim["civ11"]["intro_idle"][0] = % lon_pic_010_civ11_explosion_wounded_idle;
  level.scr_anim["civ12"]["intro_slamzoom"] = % lon_pic_010_civ12_enter;
  level.scr_goaltime["civ12"]["intro_slamzoom"] = 0;
  level.scr_anim["civ12"]["intro"][0] = % lon_pic_010_civ12_idle;
  level.scr_anim["civ12"]["intro_standoff"] = % lon_pic_010_civ12_standoff;
  level.scr_goaltime["civ12"]["intro_standoff"] = 0.6;
  level.scr_anim["civ12"]["intro_run"] = % lon_pic_010_civ12_explosion;
  level.scr_goaltime["civ12"]["intro_run"] = 0.2;
  level.scr_anim["civ12"]["intro_idle"][0] = % lon_pic_010_civ12_explosion_wounded_idle;
  level.scr_anim["civ13"]["intro_slamzoom"] = % lon_pic_010_civ13_enter;
  level.scr_goaltime["civ13"]["intro_slamzoom"] = 0;
  level.scr_anim["civ13"]["intro"][0] = % lon_pic_010_civ13_idle;
  level.scr_anim["civ13"]["intro_standoff"] = % lon_pic_010_civ13_standoff;
  level.scr_goaltime["civ13"]["intro_standoff"] = 0.6;
  level.scr_anim["civ13"]["intro_run"] = % lon_pic_010_civ13_explosion;
  level.scr_goaltime["civ13"]["intro_run"] = 0.2;
  level.scr_anim["civ13"]["intro_last_frame"][0] = % lon_pic_010_civ13_explosion_wounded_idle;
  level.scr_anim["civ14"]["intro_slamzoom"] = % lon_pic_010_civ14_enter;
  level.scr_goaltime["civ14"]["intro_slamzoom"] = 0;
  level.scr_anim["civ14"]["intro"][0] = % lon_pic_010_civ14_idle;
  level.scr_anim["civ14"]["intro_standoff"] = % lon_pic_010_civ14_standoff;
  level.scr_goaltime["civ14"]["intro_standoff"] = 0.4;
  level.scr_anim["civ14"]["intro_run"] = % lon_pic_010_civ14_explosion;
  level.scr_goaltime["civ14"]["intro_run"] = 0.2;
  level.scr_anim["civ14"]["intro_idle"][0] = % lon_pic_010_civ14_explosion_wounded_idle;
  level.scr_anim["civ15"]["intro_slamzoom"] = % lon_pic_010_civ15_enter;
  level.scr_goaltime["civ15"]["intro_slamzoom"] = 0;
  level.scr_anim["civ15"]["intro"][0] = % lon_pic_010_civ15_idle;
  level.scr_anim["civ15"]["intro_standoff"] = % lon_pic_010_civ15_standoff;
  level.scr_goaltime["civ15"]["intro_standoff"] = 0.6;
  level.scr_anim["civ15"]["intro_run"] = % lon_pic_010_civ15_explosion;
  level.scr_goaltime["civ15"]["intro_run"] = 0.2;
  level.scr_anim["civ15"]["intro_idle"][0] = % lon_pic_010_civ15_explosion_wounded_idle;
  level.scr_anim["civ16"]["intro_slamzoom"] = % lon_pic_010_civ16_enter;
  level.scr_goaltime["civ16"]["intro_slamzoom"] = 0;
  level.scr_anim["civ16"]["intro"][0] = % lon_pic_010_civ16_idle;
  level.scr_anim["civ16"]["intro_standoff"] = % lon_pic_010_civ16_standoff;
  level.scr_goaltime["civ16"]["intro_standoff"] = 0.4;
  level.scr_anim["civ16"]["intro_run"] = % lon_pic_010_civ16_explosion;
  level.scr_goaltime["civ16"]["intro_run"] = 0.2;
  level.scr_anim["civ16"]["intro_idle"][0] = % lon_pic_010_civ16_explosion_wounded_idle;
  level.scr_anim["civ17"]["intro_slamzoom"] = % lon_pic_010_civ17_enter;
  level.scr_goaltime["civ17"]["intro_slamzoom"] = 0;
  level.scr_anim["civ17"]["intro"][0] = % lon_pic_010_civ17_idle;
  level.scr_anim["civ17"]["intro_standoff"] = % lon_pic_010_civ17_standoff;
  level.scr_goaltime["civ17"]["intro_standoff"] = 0.4;
  level.scr_anim["civ17"]["intro_run"] = % lon_pic_010_civ17_explosion;
  level.scr_goaltime["civ17"]["intro_run"] = 0.2;
  level.scr_anim["civ17"]["intro_idle"][0] = % lon_pic_010_civ17_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ17", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ18"]["intro_slamzoom"] = % lon_pic_010_civ18_enter;
  level.scr_goaltime["civ18"]["intro_slamzoom"] = 0;
  level.scr_anim["civ18"]["intro"][0] = % lon_pic_010_civ18_idle;
  level.scr_anim["civ18"]["intro_standoff"] = % lon_pic_010_civ18_standoff;
  level.scr_goaltime["civ18"]["intro_standoff"] = 0.4;
  level.scr_anim["civ18"]["intro_run"] = % lon_pic_010_civ18_explosion;
  level.scr_goaltime["civ18"]["intro_run"] = 0.2;
  level.scr_anim["civ18"]["intro_last_frame"][0] = % lon_pic_010_civ18_explosion_wounded_idle;
  level.scr_anim["civ19"]["intro_slamzoom"] = % lon_pic_010_civ19_enter;
  level.scr_goaltime["civ19"]["intro_slamzoom"] = 0;
  level.scr_anim["civ19"]["intro"][0] = % lon_pic_010_civ19_idle;
  level.scr_anim["civ19"]["intro_standoff"] = % lon_pic_010_civ19_standoff;
  level.scr_goaltime["civ19"]["intro_standoff"] = 0.6;
  level.scr_anim["civ19"]["intro_run"] = % lon_pic_010_civ19_explosion;
  level.scr_goaltime["civ19"]["intro_run"] = 0.2;
  level.scr_anim["civ19"]["intro_last_frame"][0] = % lon_pic_010_civ19_explosion_wounded_idle;
  level.scr_anim["civ20"]["intro_slamzoom"] = % lon_pic_010_civ20_enter;
  level.scr_goaltime["civ20"]["intro_slamzoom"] = 0;
  level.scr_anim["civ20"]["intro"][0] = % lon_pic_010_civ20_idle;
  level.scr_anim["civ20"]["intro_standoff"] = % lon_pic_010_civ20_standoff;
  level.scr_goaltime["civ20"]["intro_standoff"] = 0.6;
  level.scr_anim["civ20"]["intro_run"] = % lon_pic_010_civ20_explosion;
  level.scr_goaltime["civ20"]["intro_run"] = 0.2;
  level.scr_anim["civ20"]["intro_idle"][0] = % lon_pic_010_civ20_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ20", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ21"]["intro_slamzoom"] = % lon_pic_010_civ21_enter;
  level.scr_goaltime["civ21"]["intro_slamzoom"] = 0;
  level.scr_anim["civ21"]["intro"][0] = % lon_pic_010_civ21_idle;
  level.scr_anim["civ21"]["intro_standoff"] = % lon_pic_010_civ21_standoff;
  level.scr_goaltime["civ21"]["intro_standoff"] = 0.6;
  level.scr_anim["civ21"]["intro_run"] = % lon_pic_010_civ21_explosion;
  level.scr_goaltime["civ21"]["intro_run"] = 0.2;
  level.scr_anim["civ21"]["intro_last_frame"][0] = % lon_pic_010_civ21_explosion_wounded_idle;
  level.scr_anim["civ22"]["intro_slamzoom"] = % lon_pic_010_civ22_enter;
  level.scr_goaltime["civ22"]["intro_slamzoom"] = 0;
  level.scr_anim["civ23"]["intro_slamzoom"] = % lon_pic_010_civ23_enter;
  level.scr_goaltime["civ23"]["intro_slamzoom"] = 0;
  level.scr_anim["civ23"]["intro"][0] = % lon_pic_010_civ23_idle;
  level.scr_anim["civ23"]["intro_standoff"] = % lon_pic_010_civ23_standoff;
  level.scr_goaltime["civ23"]["intro_standoff"] = 0.4;
  level.scr_anim["civ23"]["intro_run"] = % lon_pic_010_civ23_explosion;
  level.scr_goaltime["civ23"]["intro_run"] = 0.2;
  level.scr_anim["civ23"]["intro_idle"][0] = % lon_pic_010_civ23_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ23", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ24"]["intro_slamzoom"] = % lon_pic_010_civ24_enter;
  level.scr_goaltime["civ24"]["intro_slamzoom"] = 0;
  level.scr_anim["civ24"]["intro"][0] = % lon_pic_010_civ24_idle;
  level.scr_anim["civ24"]["intro_standoff"] = % lon_pic_010_civ24_standoff;
  level.scr_goaltime["civ24"]["intro_standoff"] = 0.4;
  level.scr_anim["civ24"]["intro_run"] = % lon_pic_010_civ24_explosion;
  level.scr_goaltime["civ24"]["intro_run"] = 0.2;
  level.scr_anim["civ24"]["intro_idle"][0] = % lon_pic_010_civ24_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ24", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ25"]["intro_slamzoom"] = % lon_pic_010_civ25_enter;
  level.scr_goaltime["civ25"]["intro_slamzoom"] = 0;
  level.scr_anim["civ25"]["intro"][0] = % lon_pic_010_civ25_idle;
  level.scr_anim["civ25"]["intro_run"] = % lon_pic_010_civ25_explosion;
  level.scr_goaltime["civ25"]["intro_run"] = 0.2;
  level.scr_anim["civ26"]["intro_slamzoom"] = % lon_pic_010_civ26_enter;
  level.scr_goaltime["civ26"]["intro_slamzoom"] = 0;
  level.scr_anim["civ26"]["intro"][0] = % lon_pic_010_civ26_idle;
  level.scr_anim["civ26"]["intro_run"] = % lon_pic_010_civ26_explosion;
  level.scr_goaltime["civ26"]["intro_run"] = 0.2;
  level.scr_anim["civ27"]["intro_slamzoom"] = % lon_pic_010_civ27_enter;
  level.scr_goaltime["civ27"]["intro_slamzoom"] = 0;
  level.scr_anim["civ27"]["intro"][0] = % lon_pic_010_civ27_idle;
  level.scr_anim["civ27"]["intro_standoff"] = % lon_pic_010_civ27_standoff;
  level.scr_goaltime["civ27"]["intro_standoff"] = 0.4;
  level.scr_anim["civ27"]["intro_run"] = % lon_pic_010_civ27_explosion;
  level.scr_goaltime["civ27"]["intro_run"] = 0.2;
  level.scr_anim["civ27"]["intro_idle"][0] = % lon_pic_010_civ27_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ27", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ28"]["intro_slamzoom"] = % lon_pic_010_civ28_enter;
  level.scr_goaltime["civ28"]["intro_slamzoom"] = 0;
  level.scr_anim["civ28"]["intro"][0] = % lon_pic_010_civ28_idle;
  level.scr_anim["civ28"]["intro_standoff"] = % lon_pic_010_civ28_standoff;
  level.scr_goaltime["civ28"]["intro_standoff"] = 0.4;
  level.scr_anim["civ28"]["intro_run"] = % lon_pic_010_civ28_explosion;
  level.scr_goaltime["civ28"]["intro_run"] = 0.2;
  level.scr_anim["civ28"]["intro_idle"][0] = % lon_pic_010_civ28_explosion_wounded_idle;
  scripts\common\anim::addnotetrack_customfunction("civ28", "in_position", ::civ_in_position, "intro_slamzoom");
  level.scr_anim["civ29"]["intro_slamzoom"] = % lon_pic_010_civ29_enter;
  level.scr_goaltime["civ29"]["intro_slamzoom"] = 0;
  level.scr_anim["civ29"]["intro"][0] = % lon_pic_010_civ29_idle;
  level.scr_anim["civ29"]["intro_run"] = % lon_pic_010_civ29_explosion;
  level.scr_goaltime["civ29"]["intro_run"] = 0.2;
  level.scr_anim["civ31"]["intro_slamzoom"] = % lon_pic_010_civ37_enter;
  level.scr_goaltime["civ31"]["intro_slamzoom"] = 0;
  level.scr_anim["civ32"]["intro_slamzoom"] = % lon_pic_010_civ36_enter;
  level.scr_goaltime["civ32"]["intro_slamzoom"] = 0;
  level.scr_anim["civ32"]["intro"][0] = % lon_pic_010_civ36_idle;
  level.scr_anim["civ32"]["intro_standoff"] = % lon_pic_010_civ36_standoff;
  level.scr_goaltime["civ32"]["intro_standoff"] = 0.4;
  level.scr_anim["civ32"]["intro_run"] = % lon_pic_010_civ36_explosion;
  level.scr_goaltime["civ32"]["intro_run"] = 0.2;
  level.scr_anim["civ32"]["intro_idle"][0] = % lon_pic_010_civ36_explosion_wounded_idle;
  level.scr_anim["civ33"]["intro_slamzoom"] = % lon_pic_010_civ33_enter;
  level.scr_goaltime["civ33"]["intro_slamzoom"] = 0;
  level.scr_anim["civ33"]["intro"][0] = % lon_pic_010_civ33_idle;
  level.scr_anim["civ33"]["intro_standoff"] = % lon_pic_010_civ33_standoff;
  level.scr_goaltime["civ33"]["intro_standoff"] = 0.6;
  level.scr_anim["civ33"]["intro_run"] = % lon_pic_010_civ33_explosion;
  level.scr_goaltime["civ33"]["intro_run"] = 0.2;
  level.scr_anim["civ33"]["intro_last_frame"][0] = % lon_pic_010_civ33_explosion_wounded_idle;
  level.scr_anim["civ34"]["intro_slamzoom"] = % lon_pic_010_civ34_enter;
  level.scr_goaltime["civ34"]["intro_slamzoom"] = 0;
  level.scr_anim["civ34"]["intro"][0] = % lon_pic_010_civ34_idle;
  level.scr_anim["civ34"]["intro_standoff"] = % lon_pic_010_civ34_standoff;
  level.scr_goaltime["civ34"]["intro_standoff"] = 0.6;
  level.scr_anim["civ34"]["intro_run"] = % lon_pic_010_civ34_explosion;
  level.scr_goaltime["civ34"]["intro_run"] = 0.2;
  level.scr_anim["civ34"]["intro_last_frame"][0] = % lon_pic_010_civ34_explosion_wounded_idle;
  level.scr_anim["civ35"]["intro_slamzoom"] = % lon_pic_010_civ35_enter;
  level.scr_goaltime["civ35"]["intro_slamzoom"] = 0;
  level.scr_anim["civ35"]["intro"][0] = % lon_pic_010_civ35_idle;
  level.scr_anim["civ35"]["intro_standoff"] = % lon_pic_010_civ35_standoff;
  level.scr_goaltime["civ35"]["intro_standoff"] = 0.6;
  level.scr_anim["civ35"]["intro_run"] = % lon_pic_010_civ35_explosion;
  level.scr_goaltime["civ35"]["intro_run"] = 0.2;
  level.scr_anim["civ35"]["intro_idle"][0] = % lon_pic_010_civ35_explosion_wounded_idle;
  level.scr_anim["generic"]["background_idle1"] = % civ_casual_idle;
  level.scr_anim["generic"]["background_idle2"] = % civ_casual_idle_twitch_a;
  level.scr_anim["generic"]["background_idle3"] = % civ_casual_idle_twitch_b;
  level.scr_anim["generic"]["background_idle4"] = % civ_casual_idle_twitch_c;
  level.scr_anim["civ36"]["intro"][0] = % lon_intersect_civ01_idle;
  level.scr_anim["civ36"]["intro_standoff"] = % lon_intersect_civ1_standoff;
  level.scr_goaltime["civ36"]["intro_standoff"] = 0.6;
  level.scr_anim["civ36"]["intro_standoff_idle"][0] = % lon_intersect_civ1_standoff_idle;
  level.scr_anim["civ36"]["intro_car"] = % lon_intersect_civ1_car;
  level.scr_goaltime["civ36"]["intro_car"] = 0.3;
  level.scr_anim["civ36"]["intro_run"] = % lon_intersect_civ1_explosion;
  level.scr_goaltime["civ36"]["intro_run"] = 0.2;
  level.scr_anim["civ36"]["intro_run_idle"][0] = % lon_intersect_civ1_explosion_idle;
  level.scr_anim["civ37"]["intro"][0] = % lon_intersect_civ02_idle;
  level.scr_anim["civ37"]["intro_standoff"] = % lon_intersect_civ2_standoff;
  level.scr_goaltime["civ37"]["intro_standoff"] = 0.4;
  level.scr_anim["civ37"]["intro_standoff_idle"][0] = % lon_intersect_civ2_standoff_idle;
  level.scr_anim["civ37"]["intro_car"] = % lon_intersect_civ2_car;
  level.scr_goaltime["civ37"]["intro_car"] = 0.3;
  level.scr_anim["civ37"]["intro_run"] = % lon_intersect_civ2_explosion;
  level.scr_goaltime["civ37"]["intro_run"] = 0.2;
  level.scr_anim["civ37"]["intro_last_frame"][0] = % lon_intersect_civ2_explosion_idle;
  level.scr_anim["civ38"]["intro"][0] = % lon_intersect_civ03_idle;
  level.scr_anim["civ38"]["intro_standoff"] = % lon_intersect_civ3_standoff;
  level.scr_goaltime["civ38"]["intro_standoff"] = 0.4;
  level.scr_anim["civ38"]["intro_standoff_idle"][0] = % lon_intersect_civ3_standoff_idle;
  level.scr_anim["civ38"]["intro_car"] = % lon_intersect_civ3_car;
  level.scr_goaltime["civ38"]["intro_car"] = 0.3;
  level.scr_anim["civ38"]["intro_run"] = % lon_intersect_civ3_explosion;
  level.scr_goaltime["civ38"]["intro_run"] = 0.2;
  level.scr_anim["civ38"]["intro_run_idle"][0] = % lon_intersect_civ3_explosion_idle;
  level.scr_anim["civ39"]["intro"][0] = % lon_intersect_civ04_idle;
  level.scr_anim["civ39"]["intro_standoff"] = % lon_intersect_civ4_standoff;
  level.scr_goaltime["civ39"]["intro_standoff"] = 0.4;
  level.scr_anim["civ39"]["intro_standoff_idle"][0] = % lon_intersect_civ4_standoff_idle;
  level.scr_anim["civ39"]["intro_car"] = % lon_intersect_civ4_car;
  level.scr_goaltime["civ39"]["intro_car"] = 0.3;
  level.scr_anim["civ39"]["intro_run"] = % lon_intersect_civ4_explosion;
  level.scr_goaltime["civ39"]["intro_run"] = 0.2;
  level.scr_anim["civ39"]["intro_run_idle"][0] = % lon_intersect_civ4_explosion_idle;
  level.scr_anim["civ40"]["intro"][0] = % lon_intersect_civ05_idle;
  level.scr_anim["civ40"]["intro_standoff"] = % lon_intersect_civ5_standoff;
  level.scr_goaltime["civ40"]["intro_standoff"] = 0.4;
  level.scr_anim["civ40"]["intro_standoff_idle"][0] = % lon_intersect_civ5_standoff_idle;
  level.scr_anim["civ40"]["intro_car"] = % lon_intersect_civ5_car;
  level.scr_goaltime["civ40"]["intro_car"] = 0.3;
  level.scr_anim["civ40"]["intro_run"] = % lon_intersect_civ5_explosion;
  level.scr_goaltime["civ40"]["intro_run"] = 0.2;
  level.scr_anim["civ40"]["intro_last_frame"][0] = % lon_intersect_civ5_explosion_idle;
  level.scr_anim["civ41"]["intro"][0] = % lon_intersect_civ06_idle;
  level.scr_anim["civ41"]["intro_standoff"] = % lon_intersect_civ6_standoff;
  level.scr_goaltime["civ41"]["intro_standoff"] = 0.4;
  level.scr_anim["civ41"]["intro_standoff_idle"][0] = % lon_intersect_civ6_standoff_idle;
  level.scr_anim["civ41"]["intro_car"] = % lon_intersect_civ6_car;
  level.scr_goaltime["civ41"]["intro_car"] = 0.3;
  level.scr_anim["civ41"]["intro_run"] = % lon_intersect_civ6_explosion;
  level.scr_goaltime["civ41"]["intro_run"] = 0.2;
  level.scr_anim["civ41"]["intro_last_frame"][0] = % lon_intersect_civ6_explosion_idle;
  level.scr_anim["civ42"]["intro"][0] = % lon_intersect_civ07_idle;
  level.scr_anim["civ42"]["intro_standoff"] = % lon_intersect_civ7_standoff;
  level.scr_goaltime["civ42"]["intro_standoff"] = 0.4;
  level.scr_anim["civ42"]["intro_standoff_idle"][0] = % lon_intersect_civ7_standoff_idle;
  level.scr_anim["civ42"]["intro_car"] = % lon_intersect_civ7_car;
  level.scr_goaltime["civ42"]["intro_car"] = 0.3;
  level.scr_anim["civ42"]["intro_run"] = % lon_intersect_civ7_explosion;
  level.scr_goaltime["civ42"]["intro_run"] = 0.2;
  level.scr_anim["civ42"]["intro_last_frame"][0] = % lon_intersect_civ7_explosion_idle;
  level.scr_anim["civ43"]["intro"][0] = % lon_intersect_civ08_idle;
  level.scr_anim["civ43"]["intro_standoff"] = % lon_intersect_civ8_standoff;
  level.scr_goaltime["civ43"]["intro_standoff"] = 0.4;
  level.scr_anim["civ43"]["intro_standoff_idle"][0] = % lon_intersect_civ8_standoff_idle;
  level.scr_anim["civ43"]["intro_car"] = % lon_intersect_civ8_car;
  level.scr_goaltime["civ43"]["intro_car"] = 0.3;
  level.scr_anim["civ43"]["intro_run"] = % lon_intersect_civ8_explosion;
  level.scr_goaltime["civ43"]["intro_run"] = 0.2;
  level.scr_anim["civ43"]["intro_last_frame"][0] = % lon_intersect_civ8_explosion_idle;
  level.scr_anim["civ44"]["intro"][0] = % lon_intersect_civ09_idle;
  level.scr_anim["civ44"]["intro_standoff"] = % lon_intersect_civ9_standoff;
  level.scr_goaltime["civ44"]["intro_standoff"] = 0.4;
  level.scr_anim["civ44"]["intro_standoff_idle"][0] = % lon_intersect_civ9_standoff_idle;
  level.scr_anim["civ44"]["intro_car"] = % lon_intersect_civ9_car;
  level.scr_goaltime["civ44"]["intro_car"] = 0.3;
  level.scr_anim["civ44"]["intro_run"] = % lon_intersect_civ9_explosion;
  level.scr_goaltime["civ44"]["intro_run"] = 0.2;
  level.scr_anim["civ44"]["intro_run_idle"][0] = % lon_intersect_civ9_explosion_idle;
  level.scr_anim["civ45"]["intro"][0] = % lon_intersect_civ10_idle;
  level.scr_anim["civ45"]["intro_standoff"] = % lon_intersect_civ10_standoff;
  level.scr_goaltime["civ45"]["intro_standoff"] = 0.4;
  level.scr_anim["civ45"]["intro_standoff_idle"][0] = % lon_intersect_civ10_standoff_idle;
  level.scr_anim["civ45"]["intro_car"] = % lon_intersect_civ10_car;
  level.scr_goaltime["civ45"]["intro_car"] = 0.3;
  level.scr_anim["civ45"]["intro_run"] = % lon_intersect_civ10_explosion;
  level.scr_goaltime["civ45"]["intro_run"] = 0.2;
  level.scr_anim["civ45"]["intro_last_frame"][0] = % lon_intersect_civ10_explosion_idle;
  level.scr_anim["civ46"]["intro"][0] = % lon_intersect_civ11_idle;
  level.scr_anim["civ46"]["intro_standoff"] = % lon_intersect_civ11_standoff;
  level.scr_goaltime["civ46"]["intro_standoff"] = 0.4;
  level.scr_anim["civ46"]["intro_standoff_idle"][0] = % lon_intersect_civ11_standoff_idle;
  level.scr_anim["civ46"]["intro_car"] = % lon_intersect_civ11_car;
  level.scr_goaltime["civ46"]["intro_car"] = 0.3;
  level.scr_anim["civ46"]["intro_run"] = % lon_intersect_civ11_explosion;
  level.scr_goaltime["civ46"]["intro_run"] = 0.2;
  level.scr_anim["civ46"]["intro_run_idle"][0] = % lon_intersect_civ11_explosion_idle;
  level.scr_anim["civ47"]["intro"][0] = % lon_intersect_civ12_idle;
  level.scr_anim["civ47"]["intro_standoff"] = % lon_intersect_civ12_standoff;
  level.scr_goaltime["civ47"]["intro_standoff"] = 0.4;
  level.scr_anim["civ47"]["intro_standoff_idle"][0] = % lon_intersect_civ12_standoff_idle;
  level.scr_anim["civ47"]["intro_car"] = % lon_intersect_civ12_car;
  level.scr_goaltime["civ47"]["intro_car"] = 0.3;
  level.scr_anim["civ47"]["intro_run"] = % lon_intersect_civ12_explosion;
  level.scr_goaltime["civ47"]["intro_run"] = 0.2;
  level.scr_anim["civ47"]["intro_last_frame"][0] = % lon_intersect_civ12_explosion_idle;
  level.scr_anim["civ48"]["intro"][0] = % lon_intersect_civ13_idle;
  level.scr_anim["civ48"]["intro_standoff"] = % lon_intersect_civ13_standoff;
  level.scr_goaltime["civ48"]["intro_standoff"] = 0.4;
  level.scr_anim["civ48"]["intro_standoff_idle"][0] = % lon_intersect_civ13_standoff_idle;
  level.scr_anim["civ48"]["intro_car"] = % lon_intersect_civ13_car;
  level.scr_goaltime["civ48"]["intro_car"] = 0.3;
  level.scr_anim["civ48"]["intro_run"] = % lon_intersect_civ13_explosion;
  level.scr_goaltime["civ48"]["intro_run"] = 0.2;
  level.scr_anim["civ48"]["intro_last_frame"][0] = % lon_intersect_civ13_explosion_idle;
  level.scr_anim["civ49"]["intro"][0] = % lon_intersect_civ14_idle;
  level.scr_anim["civ49"]["intro_standoff"] = % lon_intersect_civ14_standoff;
  level.scr_goaltime["civ49"]["intro_standoff"] = 0.4;
  level.scr_anim["civ49"]["intro_standoff_idle"][0] = % lon_intersect_civ14_standoff_idle;
  level.scr_anim["civ49"]["intro_car"] = % lon_intersect_civ14_car;
  level.scr_goaltime["civ49"]["intro_car"] = 0.3;
  level.scr_anim["civ49"]["intro_run"] = % lon_intersect_civ14_explosion;
  level.scr_goaltime["civ49"]["intro_run"] = 0.2;
  level.scr_anim["civ49"]["intro_run_idle"][0] = % lon_intersect_civ14_explosion_idle;
  level.scr_anim["civ50"]["intro"][0] = % lon_intersect_civ15_idle;
  level.scr_anim["civ50"]["intro_standoff"] = % lon_intersect_civ15_standoff;
  level.scr_goaltime["civ50"]["intro_standoff"] = 0.4;
  level.scr_anim["civ50"]["intro_standoff_idle"][0] = % lon_intersect_civ15_standoff_idle;
  level.scr_anim["civ50"]["intro_car"] = % lon_intersect_civ15_car;
  level.scr_goaltime["civ50"]["intro_car"] = 0.3;
  level.scr_anim["civ50"]["intro_run"] = % lon_intersect_civ15_explosion;
  level.scr_goaltime["civ50"]["intro_run"] = 0.2;
  level.scr_anim["civ50"]["intro_run_idle"][0] = % lon_intersect_civ15_explosion_idle;
  level.scr_anim["civ51"]["intro"][0] = % lon_intersect_civ16_idle;
  level.scr_anim["civ51"]["intro_standoff"] = % lon_intersect_civ16_standoff;
  level.scr_goaltime["civ51"]["intro_standoff"] = 0.4;
  level.scr_anim["civ51"]["intro_standoff_idle"][0] = % lon_intersect_civ16_standoff_idle;
  level.scr_anim["civ51"]["intro_car"] = % lon_intersect_civ16_car;
  level.scr_goaltime["civ51"]["intro_car"] = 0.3;
  level.scr_anim["civ51"]["intro_run"] = % lon_intersect_civ16_explosion;
  level.scr_goaltime["civ51"]["intro_run"] = 0.2;
  level.scr_anim["civ51"]["intro_run_idle"][0] = % lon_intersect_civ16_explosion_idle;
  level.scr_anim["civ52"]["intro"][0] = % lon_intersect_civ17_idle;
  level.scr_anim["civ52"]["intro_standoff"] = % lon_intersect_civ17_standoff;
  level.scr_goaltime["civ52"]["intro_standoff"] = 0.4;
  level.scr_anim["civ52"]["intro_standoff_idle"][0] = % lon_intersect_civ17_standoff_idle;
  level.scr_anim["civ52"]["intro_car"] = % lon_intersect_civ17_car;
  level.scr_goaltime["civ52"]["intro_car"] = 0.3;
  level.scr_anim["civ52"]["intro_run"] = % lon_intersect_civ17_explosion;
  level.scr_goaltime["civ52"]["intro_run"] = 0.2;
  level.scr_anim["civ52"]["intro_run_idle"][0] = % lon_intersect_civ17_explosion_idle;
  level.scr_anim["civ53"]["intro"][0] = % lon_intersect_civ18_idle;
  level.scr_anim["civ53"]["intro_standoff"] = % lon_intersect_civ18_standoff;
  level.scr_goaltime["civ53"]["intro_standoff"] = 0.4;
  level.scr_anim["civ53"]["intro_standoff_idle"][0] = % lon_intersect_civ18_standoff_idle;
  level.scr_anim["civ53"]["intro_car"] = % lon_intersect_civ18_car;
  level.scr_goaltime["civ53"]["intro_car"] = 0.3;
  level.scr_anim["civ53"]["intro_run"] = % lon_intersect_civ18_explosion;
  level.scr_goaltime["civ53"]["intro_run"] = 0.2;
  level.scr_anim["civ53"]["intro_last_frame"][0] = % lon_intersect_civ18_explosion_idle;
  level.scr_anim["civ54"]["post_explosion_death"] = % lon_intersect_civ19_explosion_death;
  level.scr_anim["civ55"]["post_explosion_death"] = % lon_intersect_civ20_explosion_death;
  level.scr_anim["civ56"]["post_explosion_death"] = % lon_intersect_civ21_explosion_death;
  level.scr_anim["civ57"]["post_explosion_death"] = % lon_intersect_civ22_explosion_death;
  level.scr_anim["civ58"]["post_explosion_death"] = % lon_intersect_civ23_explosion_death;
  level.scr_anim["civ59"]["post_explosion_death"] = % lon_intersect_civ24_explosion_death;
  level.scr_anim["kyle"]["intro_slamzoom"] = % lon_pic_010_sas_enter_kyle;
  level.scr_goaltime["kyle"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("kyle", "kyle_swap", ::kyle_swap, "intro_slamzoom");
  scripts\common\anim::addnotetrack_mayhemstart("kyle", "mayhem_start", %lon_pic_010_sas_enter_kyle_face, "intro_slamzoom");
  level.scr_anim["sas1"]["intro_slamzoom"] = % lon_pic_010_sas_enter_01;
  level.scr_goaltime["sas1"]["intro_slamzoom"] = 0;
  level.scr_anim["sas1"]["intro_slamzoom_v1_arrival"] = % lon_pic_010_sas_enter_idle_01;
  level.scr_goaltime["sas1"]["intro_slamzoom_v1_arrival"] = 0.3;
  level.scr_anim["sas1"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_sas_idle_01;
  level.scr_goaltime["sas1"]["intro_slamzoom_v1_idle"] = 0.4;
  level.scr_anim["sas1"]["intro_slamzoom_v1_exit"] = % lon_pic_010_sas_idle_exit_01;
  level.scr_goaltime["sas1"]["intro_slamzoom_v1_exit"] = 0.4;
  level.scr_anim["sas1"]["intro_slamzoom_v2"] = % lon_pic_010_sas_standoff_enter_01;
  level.scr_goaltime["sas1"]["intro_slamzoom_v2"] = 0.3;
  level.scr_anim["sas2"]["intro_slamzoom"] = % lon_pic_010_sas_enter_02;
  level.scr_goaltime["sas2"]["intro_slamzoom"] = 0;
  level.scr_anim["sas2"]["intro_slamzoom_v1_arrival"] = % lon_pic_010_sas_enter_idle_02;
  level.scr_goaltime["sas2"]["intro_slamzoom_v1_arrival"] = 0.3;
  level.scr_anim["sas2"]["intro_slamzoom_v1_sas2_idle"][0] = % lon_pic_010_sas_idle_02;
  level.scr_goaltime["sas2"]["intro_slamzoom_v1_sas2_idle"] = 0.4;
  level.scr_anim["sas2"]["intro_slamzoom_v1_sas2_idle_nags"][0] = % lon_pic_010_sas_nag_02;
  level.scr_anim["sas2"]["intro_slamzoom_v1_sas2_idle_nags_timer"] = 12;
  level.scr_anim["sas2"]["intro_slamzoom_v1_exit"] = % lon_pic_010_sas_idle_exit_02;
  level.scr_goaltime["sas2"]["intro_slamzoom_v1_exit"] = 0.4;
  level.scr_anim["sas2"]["intro_slamzoom_v2"] = % lon_pic_010_sas_standoff_enter_02;
  level.scr_goaltime["sas2"]["intro_slamzoom_v2"] = 0.1;
  scripts\common\anim::addnotetrack_mayhemstart("sas2", "mayhem_start", %lon_pic_010_sas_enter_02_face, "intro_slamzoom");
  scripts\common\anim::addnotetrack_mayhemend("sas2", "mayhem_end", %lon_pic_010_sas_enter_02_face, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("sas2", "nag", ::notify_self_nag, "intro_slamzoom_v1_sas2_idle_nags");
  scripts\common\anim::addnotetrack_notify("sas2", "walla_pre_expl_notify", "vo_pre_expl_walla", "intro_slamzoom_v1_exit");
  level.scr_anim["sas3"]["intro_slamzoom"] = % lon_pic_010_sas_enter_04;
  level.scr_goaltime["sas3"]["intro_slamzoom"] = 0;
  level.scr_anim["sas3"]["intro_slamzoom_v1_arrival"] = % lon_pic_010_enter_sas_idle_04;
  level.scr_goaltime["sas3"]["intro_slamzoom_v1_arrival"] = 0.3;
  level.scr_anim["sas3"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_sas_idle_04;
  level.scr_goaltime["sas3"]["intro_slamzoom_v1_idle"] = 0.4;
  level.scr_anim["sas3"]["intro_slamzoom_v1_exit"] = % lon_pic_010_sas_idle_exit_04;
  level.scr_goaltime["sas3"]["intro_slamzoom_v1_exit"] = 0.4;
  level.scr_anim["sas3"]["intro_slamzoom_v2"] = % lon_pic_010_sas_standoff_enter_04;
  level.scr_goaltime["sas3"]["intro_slamzoom_v2"] = 0.4;
  level.scr_anim["car1_terry1"]["intro_slamzoom"] = % lon_pic_010_terrorist_car_enter;
  level.scr_goaltime["car1_terry1"]["intro_slamzoom"] = 0;
  level.scr_anim["car1_terry1"]["intro_slamzoom_v1_arrival"] = % lon_pic_010_terrorist_car_enter_idle;
  level.scr_goaltime["car1_terry1"]["intro_slamzoom_v1_arrival"] = 0;
  level.scr_anim["car1_terry1"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_car_idle;
  level.scr_goaltime["car1_terry1"]["intro_slamzoom_v1_idle"] = 0;
  level.scr_anim["car1_terry1"]["intro_slamzoom_v1_exit"] = % lon_pic_010_terrorist_car_idle_exit;
  level.scr_goaltime["car1_terry1"]["intro_slamzoom_v1_exit"] = 0;
  level.scr_anim["car1_terry1"]["intro_slamzoom_v2"] = % lon_pic_010_terrorist_car_standoff_enter;
  level.scr_goaltime["car1_terry1"]["intro_slamzoom_v2"] = 0;
  scripts\common\anim::addnotetrack_customfunction("car1_terry1", "sfx_car_door_open", ::sfx_car_door_open, "intro_slamzoom_v2");
  level.scr_anim["car1_terry2"]["intro_slamzoom"] = % lon_pic_010_terrorist_car_enter_02;
  level.scr_goaltime["car1_terry2"]["intro_slamzoom"] = 0;
  level.scr_anim["car1_terry2"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_car_idle_02;
  level.scr_goaltime["car1_terry2"]["intro_slamzoom_v1_idle"] = 0;
  level.scr_anim["car1_terry2"]["intro_slamzoom_v1_exit"] = % lon_pic_010_terrorist_car_idle_exit_02;
  level.scr_goaltime["car1_terry2"]["intro_slamzoom_v1_exit"] = 0;
  level.scr_anim["car1_terry2"]["intro_slamzoom_v2"] = % lon_pic_010_terrorist_car_standoff_enter_02;
  level.scr_goaltime["car1_terry2"]["intro_slamzoom_v2"] = 0;
  level.scr_anim["car1_terry3"]["intro_slamzoom"] = % lon_pic_010_terrorist_car_enter_03;
  level.scr_goaltime["car1_terry3"]["intro_slamzoom"] = 0;
  level.scr_anim["car1_terry3"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_car_idle_03;
  level.scr_goaltime["car1_terry3"]["intro_slamzoom_v1_idle"] = 0;
  level.scr_anim["car1_terry3"]["intro_slamzoom_v1_exit"] = % lon_pic_010_terrorist_car_idle_exit_03;
  level.scr_goaltime["car1_terry3"]["intro_slamzoom_v1_exit"] = 0;
  level.scr_anim["car1_terry3"]["intro_slamzoom_v2"] = % lon_pic_010_terrorist_car_standoff_enter_03;
  level.scr_goaltime["car1_terry3"]["intro_slamzoom_v2"] = 0;
  level.scr_anim["car2_terry1"]["intro_slamzoom"] = % lon_pic_010_terrorist_enter_02;
  level.scr_anim["car2_terry1"]["intro_temp_idle"][0] = % vehicle_ralfa_civ_idle_lf;
  level.scr_anim["car2_terry1"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_idle_01;
  level.scr_anim["car2_terry2"]["intro_slamzoom"] = % lon_pic_010_terrorist_enter_03;
  level.scr_anim["car2_terry2"]["intro_temp_idle"][0] = % vehicle_ralfa_civ_idle_lf;
  level.scr_anim["car2_terry2"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_idle_02;
  level.scr_anim["car2_terry3"]["intro_slamzoom"] = % lon_pic_010_terrorist_enter_04;
  level.scr_anim["car2_terry3"]["intro_temp_idle"][0] = % vehicle_ralfa_civ_idle_lf;
  level.scr_anim["car2_terry3"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_terrorist_idle_03;
  level.scr_anim["car2_terry_driver"]["intro_slamzoom"] = % lon_pic_010_terrorist_enter_01;
  level.scr_goaltime["car2_terry_driver"]["intro_slamzoom"] = 0;
  level.scr_anim["sas1"]["standoff"] = % lon_pic_010_sas_standoff_01;
  level.scr_goaltime["sas1"]["standoff"] = 0.4;
  level.scr_anim["sas2"]["standoff"] = % lon_pic_010_sas_standoff_02;
  level.scr_goaltime["sas2"]["standoff"] = 0.4;
  level.scr_anim["sas2"]["standoff_idle"][0] = % lon_pic_010_sas_standoff_idle_02;
  level.scr_goaltime["sas2"]["standoff_idle"] = 0;
  level.scr_anim["sas3"]["standoff"] = % lon_pic_010_sas_standoff_04;
  level.scr_goaltime["sas3"]["standoff"] = 0.4;
  scripts\common\anim::addnotetrack_customfunction("sas2", "sfx_car_door_slam", ::sfx_car_door_slam, "standoff");
  level.scr_anim["car1_terry1"]["standoff"] = % lon_pic_010_terrorist_car_standoff;
  level.scr_goaltime["car1_terry1"]["standoff"] = 0.4;
  level.scr_anim["car1_terry2"]["standoff"] = % lon_pic_010_terrorist_car_standoff_02;
  level.scr_goaltime["car1_terry2"]["standoff"] = 0.4;
  level.scr_anim["car1_terry3"]["standoff"] = % lon_pic_010_terrorist_car_standoff_03;
  level.scr_goaltime["car1_terry3"]["standoff"] = 0.4;
  level.scr_anim["car2_terry1"]["standoff"] = % lon_pic_010_terrorist_standoff_01;
  level.scr_goaltime["car2_terry1"]["standoff"] = 0.4;
  level.scr_anim["car2_terry2"]["standoff"] = % lon_pic_010_terrorist_standoff_02;
  level.scr_goaltime["car2_terry2"]["standoff"] = 0.4;
  level.scr_anim["car2_terry3"]["standoff"] = % lon_pic_010_terrorist_standoff_03;
  level.scr_goaltime["car2_terry3"]["standoff"] = 0.4;
  scripts\common\anim::addnotetrack_customfunction("car2_terry2", "sfx_van_door_open", ::sfx_van_door_open, "standoff");
  level.scr_anim["sas1"]["car2_drives_off"] = % lon_pic_010_sas_exp_enter_01;
  level.scr_goaltime["sas1"]["car2_drives_off"] = 0.3;
  level.scr_anim["sas2"]["car2_drives_off"] = % lon_pic_010_sas_exp_enter_02;
  level.scr_goaltime["sas2"]["car2_drives_off"] = 0.3;
  level.scr_anim["sas3"]["car2_drives_off"] = % lon_pic_010_sas_exp_enter_04;
  level.scr_goaltime["sas3"]["car2_drives_off"] = 0.3;
  level.scr_anim["car1_terry1"]["car2_drives_off"] = % lon_pic_010_terrorist_car_exp_enter;
  level.scr_goaltime["car1_terry1"]["car2_drives_off"] = 0.3;
  level.scr_anim["car1_terry2"]["car2_drives_off"] = % lon_pic_010_terrorist_car_exp_enter_02;
  level.scr_goaltime["car1_terry2"]["car2_drives_off"] = 0.3;
  level.scr_anim["car1_terry3"]["car2_drives_off"] = % lon_pic_010_terrorist_car_exp_enter_03;
  level.scr_goaltime["car1_terry3"]["car2_drives_off"] = 0.3;
  level.scr_anim["car2_terry1"]["car2_drives_off"] = % lon_pic_010_terrorist_exp_enter_01;
  level.scr_goaltime["car2_terry1"]["car2_drives_off"] = 0.3;
  level.scr_anim["car2_terry2"]["car2_drives_off"] = % lon_pic_010_terrorist_exp_enter_02;
  level.scr_goaltime["car2_terry2"]["car2_drives_off"] = 0.3;
  level.scr_anim["car2_terry3"]["car2_drives_off"] = % lon_pic_010_terrorist_exp_enter_03;
  level.scr_goaltime["car2_terry3"]["car2_drives_off"] = 0.3;
  level.scr_anim["sas1"]["car_explosion"] = % lon_pic_010_sas_explosion_01;
  level.scr_goaltime["sas1"]["car_explosion"] = 0.2;
  level.scr_anim["sas1"]["car_explosion_enter"] = % lon_pic_010_sas_explosion_enter_idle_01;
  level.scr_goaltime["sas1"]["car_explosion_enter"] = 0.2;
  level.scr_anim["sas1"]["car_explosion_idle"][0] = % lon_pic_010_sas_explosion_idle_01;
  level.scr_goaltime["sas1"]["car_explosion_idle"] = 0.4;
  level.scr_anim["sas1"]["car_explosion_idle_exit"] = % lon_pic_010_sas_explosion_idle_exit_01;
  level.scr_goaltime["sas1"]["car_explosion_idle_exit"] = 0;
  level.scr_anim["sas1"]["car_explosion_exit"] = % lon_pic_010_sas_explosion_exit_01;
  level.scr_goaltime["sas1"]["car_explosion_exit"] = 0;
  level.scr_anim["sas2"]["car_explosion"] = % lon_pic_010_sas_explosion_02;
  level.scr_goaltime["sas2"]["car_explosion"] = 0.2;
  level.scr_anim["sas3"]["car_explosion"] = % lon_pic_010_sas_explosion_04;
  level.scr_goaltime["sas3"]["car_explosion"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("sas2", "drop_weapon", ::drop_weapon_now, "car_explosion");
  level.scr_anim["car1_terry1"]["car_explosion"] = % lon_pic_010_terrorist_car_explosion;
  level.scr_goaltime["car1_terry1"]["car_explosion"] = 0.2;
  level.scr_anim["car1_terry2"]["car_explosion"] = % lon_pic_010_terrorist_car_exp_02;
  level.scr_goaltime["car1_terry2"]["car_explosion"] = 0.2;
  level.scr_anim["car1_terry3"]["car_explosion"] = % lon_pic_010_terrorist_car_exp_03;
  level.scr_goaltime["car1_terry3"]["car_explosion"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("car1_terry1", "fire", ::bullettracer_hack, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("car1_terry2", "already_dead", ::already_dead, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("car1_terry3", "already_dead", ::already_dead, "car_explosion");
  level.scr_anim["car2_terry1"]["car_explosion"] = % lon_pic_010_terrorist_explosion_01;
  level.scr_goaltime["car2_terry1"]["car_explosion"] = 0.2;
  level.scr_anim["car2_terry2"]["car_explosion"] = % lon_pic_010_terrorist_explosion_02;
  level.scr_goaltime["car2_terry2"]["car_explosion"] = 0.2;
  level.scr_anim["car2_terry3"]["car_explosion"] = % lon_pic_010_terrorist_explosion_03;
  level.scr_goaltime["car2_terry3"]["car_explosion"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("car2_terry1", "drop_weapon", ::drop_weapon_now, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("car2_terry2", "drop_weapon", ::drop_weapon_now, "car_explosion");
  scripts\common\anim::addnotetrack_customfunction("car2_terry3", "drop_weapon", ::drop_weapon_now, "car_explosion");
  level.scr_anim["sas1"]["post_kill"] = % lon_pic_010_sas_post_kill_01;
  level.scr_anim["car2_terry1"]["post_kill"] = % lon_pic_010_terrorist_post_kill_01;
  level.scr_anim["price"]["price_spec_intro"] = % lon_tto_010_price;
  level.scr_anim["price"]["price_spec_intro_idle"][0] = % lon_tto_010_price_idle;
  level.scr_anim["price"]["price_spec_intro_idle_nags"][0] = % lon_tto_010_price_nag_1;
  level.scr_anim["price"]["price_spec_intro_idle_nags_timer"] = 13;
  level.scr_anim["price"]["price_spec_intro_exit"] = % lon_tto_010_price_corner;
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %lon_tto_010_price_face, "price_spec_intro");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %lon_tto_010_price_face, "price_spec_intro");
  scripts\common\anim::addnotetrack_customfunction("price", "nag", ::notify_self_nag, "price_spec_intro_idle_nags");
  level.scr_face["price"]["dx_vom_pri_move_to_balcony_hostages_10"] = % dx_vom_pri_move_to_balcony_hostages_10_face;
  level.scr_face["price"]["dx_vom_pri_move_to_balcony_hostages_20"] = % dx_vom_pri_move_to_balcony_hostages_20_face;
  level.scr_face["price"]["dx_vom_pri_move_to_balcony_hostages_30"] = % dx_vom_pri_move_to_balcony_hostages_30_face;
  level.scr_anim["terry"]["price_spec_intro"] = % lon_tto_010_terrorist;
  level.scr_anim["sas1"]["price_spec_intro"] = % lon_tto_010_ally01;
  level.scr_anim["sas2"]["price_spec_intro"] = % lon_tto_010_ally02;
  level.scr_anim["sas3"]["price_spec_intro"] = % lon_tto_010_ally03;
  scripts\common\anim::addnotetrack_customfunction("terry", "shot", ::spec_terry_shot, "price_spec_intro");
  level.scr_anim["price"]["stairs_arrival"] = % lon_bmb_020_stairs_bottom_enter_price;
  level.scr_anim["price"]["stairs_arrival_idle"][0] = % lon_bmb_020_stairs_bottom_idle_price;
  level.scr_anim["price"]["stairs_to_mid"] = % lon_bmb_020_stairs_bottom_up_price;
  level.scr_anim["price"]["stairs_to_mid_idle"][0] = % lon_bmb_020_stairs_mid_idle_price;
  level.scr_face["price"]["dx_vom_pri_hostage_bomb_124"] = % dx_vom_pri_hostage_bomb_124_face;
  level.scr_anim["price"]["end"] = % lon_bmb_020_enter_price;
  level.scr_goaltime["price"]["end"] = 0.7;
  level.scr_anim["price"]["end_radio"] = % lon_bmb_020_radio_price;
  level.scr_goaltime["price"]["end_radio"] = 0.05;
  level.scr_anim["price"]["end_idle"][0] = % lon_bmb_020_idle_price;
  level.scr_goaltime["price"]["end_idle"] = 0.2;
  level.scr_anim["price"]["end_nag"] = % lon_bmb_020_nag_price;
  level.scr_anim["price"]["end_boom"] = % lon_bmb_020_boom_price;
  level.scr_goaltime["price"]["end_boom"] = 0.8;
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_a_start", %lon_bmb_020_boom_price_a_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_a_end", %lon_bmb_020_boom_price_a_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_b_start", %lon_bmb_020_boom_price_b_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_b_end", %lon_bmb_020_boom_price_b_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_c_start", %lon_bmb_020_boom_price_c_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_c_end", %lon_bmb_020_boom_price_c_face, "end_boom");
  level.scr_anim["gap_hostage"]["end"] = % lon_bmb_020_enter_hostage;
  level.scr_goaltime["gap_hostage"]["end"] = 0.7;
  level.scr_anim["gap_hostage"]["end_radio"] = % lon_bmb_020_radio_hostage;
  level.scr_goaltime["gap_hostage"]["end_radio"] = 0.05;
  level.scr_anim["gap_hostage"]["end_idle"][0] = % lon_bmb_020_idle_hostage;
  level.scr_goaltime["gap_hostage"]["end_idle"] = 0.2;
  level.scr_anim["gap_hostage"]["end_nag"] = % lon_bmb_020_nag_hostage;
  level.scr_anim["gap_hostage"]["end_boom"] = % lon_bmb_020_boom_hostage;
  level.scr_goaltime["gap_hostage"]["end_boom"] = 0.7;
  scripts\common\anim::addnotetrack_notify("gap_hostage", "beep_faster", "beep_faster", "end_boom");
  scripts\common\anim::addnotetrack_notify("gap_hostage", "beep_fastest", "beep_fastest", "end_boom");
  scripts\common\anim::addnotetrack_customfunction("gap_hostage", "start_countdown", ::start_countdown, "end_boom");
  scripts\common\anim::addnotetrack_customfunction("gap_hostage", "explosion", ::start_explosion, "end_boom");
  scripts\common\anim::addnotetrack_mayhemstart("gap_hostage", "mayhem_start", %lon_bmb_020_boom_hostage_face, "end_boom");
  scripts\common\anim::addnotetrack_mayhemend("gap_hostage", "mayhem_end", %lon_bmb_020_boom_hostage_face, "end_boom");
  level.scr_anim["hostage1"]["end_idle"][0] = % lon_bmb_020_idle_civ_01;
  level.scr_goaltime["hostage1"]["end_idle"] = 0.4;
  level.scr_anim["hostage1"]["end_react"] = % lon_bmb_020_react_civ_01;
  level.scr_anim["hostage1"]["end_boom"] = % lon_bmb_020_boom_civ_01;
  level.scr_goaltime["hostage1"]["end_boom"] = 0.7;
  level.scr_anim["hostage2"]["end_idle"][0] = % lon_bmb_020_idle_civ_02;
  level.scr_goaltime["hostage2"]["end_idle"] = 0.4;
  level.scr_anim["hostage2"]["end_react"] = % lon_bmb_020_react_civ_02;
  level.scr_anim["hostage2"]["end_boom"] = % lon_bmb_020_boom_civ_02;
  level.scr_goaltime["hostage2"]["end_boom"] = 0.7;
  level.scr_anim["hostage3"]["end_idle"][0] = % lon_bmb_020_idle_civ_03;
  level.scr_goaltime["hostage3"]["end_idle"] = 0.4;
  level.scr_anim["hostage3"]["end_react"] = % lon_bmb_020_react_civ_03;
  level.scr_anim["hostage3"]["end_boom"] = % lon_bmb_020_boom_civ_03;
  level.scr_goaltime["hostage3"]["end_boom"] = 0.7;
  level.scr_anim["hostage4"]["end_idle"][0] = % lon_bmb_020_idle_civ_04;
  level.scr_goaltime["hostage4"]["end_idle"] = 0.4;
  level.scr_anim["hostage4"]["end_react"] = % lon_bmb_020_react_civ_04;
  level.scr_anim["hostage4"]["end_boom"] = % lon_bmb_020_boom_civ_04;
  level.scr_goaltime["hostage4"]["end_boom"] = 0.7;
  level.scr_anim["hostage5"]["end_idle"][0] = % lon_bmb_020_idle_civ_05;
  level.scr_goaltime["hostage5"]["end_idle"] = 0.4;
  level.scr_anim["hostage5"]["end_react"] = % lon_bmb_020_react_civ_05;
  level.scr_anim["hostage5"]["end_boom"] = % lon_bmb_020_boom_civ_05;
  level.scr_goaltime["hostage5"]["end_boom"] = 0.7;
  level.scr_anim["hostage6"]["end_idle"][0] = % lon_bmb_020_idle_civ_06;
  level.scr_goaltime["hostage6"]["end_idle"] = 0.4;
  level.scr_anim["hostage6"]["end_react"] = % lon_bmb_020_react_civ_06;
  level.scr_anim["hostage6"]["end_boom"] = % lon_bmb_020_boom_civ_06;
  level.scr_goaltime["hostage6"]["end_boom"] = 0.7;
  level.scr_anim["price"]["balcony_throw"] = % sw_rail_throw_short_hesh;
  level.scr_anim["gap_hostage"]["balcony_throw"] = % sw_rail_throw_short_enemy;
  level.scr_anim["price"]["fastrope"] = % vh_blima_rappel_soldier4_drop;
  level.scr_anim["generic"]["fastrope"] = % vh_blima_rappel_soldier4_drop;
  level.scr_anim["generic"]["armed_car_idle1"][0] = % prisoner_car_a_front_pass_idle;
  level.scr_anim["generic"]["armed_car_idle2"][0] = % prisoner_car_b_front_pass_idle;
  level.scr_anim["traffic_intro_terry1"]["traffic_intro"] = % lon_pic_050_cars_crashing_t01;
  level.scr_anim["traffic_intro_terry2"]["traffic_intro"] = % lon_pic_050_cars_crashing_t02;
  level.scr_anim["generic"]["ph_dust_civi_stun_walk_07"][0] = % ph_dust_civi_stun_walk_07;
  level.scr_anim["generic"]["ph_dust_civi_stun_walk_08"][0] = % ph_dust_civi_stun_walk_08;
  level.scr_anim["generic"]["ph_dust_civi_stun_walk_10"][0] = % ph_dust_civi_stun_walk_10;
  level.scr_anim["generic"]["ph_dust_civi_stun_car_lean_kneel"][0] = % ph_dust_civi_stun_car_lean_kneel;
  level.scr_anim["generic"]["ph_dust_civi_stun_walk_01_loop"][0] = % ph_dust_civi_stun_walk_01_loop;
  level.scr_anim["generic"]["ph_dust_civi_stun_walk_02_loop"][0] = % ph_dust_civi_stun_walk_02_loop;
  level.scr_anim["generic"]["walk_01"] = % ph_dust_civi_stun_walk_01;
  level.scr_anim["generic"]["walk_01_idle"][0] = % ph_dust_civi_stun_walk_01_loop;
  level.scr_anim["generic"]["walk_02"] = % ph_dust_civi_stun_walk_02;
  level.scr_anim["generic"]["walk_02_idle"][0] = % ph_dust_civi_stun_walk_02_loop;
  level.scr_anim["generic"]["walk_03"] = % ph_dust_civi_stun_walk_06;
  level.scr_anim["generic"]["walk_03_idle"][0] = % ph_dust_civi_stun_walk_01_loop;
  level.scr_anim["generic"]["walk_04"] = % ph_dust_civi_stun_walk_04;
  level.scr_anim["generic"]["walk_04_idle"][0] = % ph_dust_civi_stun_walk_02_loop;
  level.scr_anim["ralfa_rf"]["car_idle_rf"][0] = % lon_int_010_civ_car_reactions_ralfa_idle;
  level.scr_anim["ralfa_rf"]["car_right_fwd_rf"] = % lon_int_010_civ_car_reactions_ralfa_look_right_fwd;
  level.scr_anim["ralfa_rf"]["car_right_rf"] = % lon_int_010_civ_car_reactions_ralfa_look_right_side;
  level.scr_anim["ralfa_rf"]["car_right_back_rf"] = % lon_int_010_civ_car_reactions_ralfa_look_right_back;
  level.scr_anim["ralfa_rf"]["car_react_rf"] = % lon_int_010_civ_car_reactions_ralfa_gun_react_right;
  level.scr_anim["ralfa_rf"]["car_react_rf_idle"][0] = % lon_int_010_civ_car_reactions_ralfa_gun_react_right_idle;
  level.scr_anim["ralfa_rf"]["car_react_back_rf"] = % lon_int_010_civ_car_reactions_ralfa_gun_right_back_to_normal;
  level.scr_anim["ralfa_lf"]["car_idle_lf"][0] = % lon_int_010_civ_car_reactions_ralfa_idle;
  level.scr_anim["ralfa_lf"]["car_left_fwd_lf"] = % lon_int_010_civ_car_reactions_ralfa_look_left_fwd;
  level.scr_anim["ralfa_lf"]["car_left_lf"] = % lon_int_010_civ_car_reactions_ralfa_look_left_side;
  level.scr_anim["ralfa_lf"]["car_left_back_lf"] = % lon_int_010_civ_car_reactions_ralfa_look_left_back;
  level.scr_anim["ralfa_lf"]["car_react_lf"] = % lon_int_010_civ_car_reactions_ralfa_gun_react_left;
  level.scr_anim["ralfa_lf"]["car_react_lf_idle"][0] = % lon_int_010_civ_car_reactions_ralfa_gun_react_left_idle;
  level.scr_anim["ralfa_lf"]["car_react_back_lf"] = % lon_int_010_civ_car_reactions_ralfa_gun_left_back_to_normal;
  level.scr_anim["calfa_rf"]["car_idle_rf"][0] = % lon_int_010_civ_car_reactions_calfa_idle;
  level.scr_anim["calfa_rf"]["car_right_fwd_rf"] = % lon_int_010_civ_car_reactions_calfa_look_right_fwd;
  level.scr_anim["calfa_rf"]["car_right_rf"] = % lon_int_010_civ_car_reactions_calfa_look_right_side;
  level.scr_anim["calfa_rf"]["car_right_back_rf"] = % lon_int_010_civ_car_reactions_calfa_look_right_back;
  level.scr_anim["calfa_rf"]["car_react_rf"] = % lon_int_010_civ_car_reactions_calfa_gun_react_right;
  level.scr_anim["calfa_rf"]["car_react_rf_idle"][0] = % lon_int_010_civ_car_reactions_calfa_gun_react_right_idle;
  level.scr_anim["calfa_rf"]["car_react_back_rf"] = % lon_int_010_civ_car_reactions_calfa_gun_right_back_to_normal;
  level.scr_anim["calfa_lf"]["car_idle_lf"][0] = % lon_int_010_civ_car_reactions_calfa_idle;
  level.scr_anim["calfa_lf"]["car_left_fwd_lf"] = % lon_int_010_civ_car_reactions_calfa_look_left_fwd;
  level.scr_anim["calfa_lf"]["car_left_lf"] = % lon_int_010_civ_car_reactions_calfa_look_left_side;
  level.scr_anim["calfa_lf"]["car_left_back_lf"] = % lon_int_010_civ_car_reactions_calfa_look_left_back;
  level.scr_anim["calfa_lf"]["car_react_lf"] = % lon_int_010_civ_car_reactions_calfa_gun_react_left;
  level.scr_anim["calfa_lf"]["car_react_lf_idle"][0] = % lon_int_010_civ_car_reactions_calfa_gun_react_left_idle;
  level.scr_anim["calfa_lf"]["car_react_back_lf"] = % lon_int_010_civ_car_reactions_calfa_gun_left_back_to_normal;
  level.scr_anim["skilo_rf"]["car_idle_rf"][0] = % lon_int_010_civ_car_reactions_skilo_idle;
  level.scr_anim["skilo_rf"]["car_right_fwd_rf"] = % lon_int_010_civ_car_reactions_skilo_look_right_fwd;
  level.scr_anim["skilo_rf"]["car_right_rf"] = % lon_int_010_civ_car_reactions_skilo_look_right_side;
  level.scr_anim["skilo_rf"]["car_right_back_rf"] = % lon_int_010_civ_car_reactions_skilo_look_right_back;
  level.scr_anim["skilo_rf"]["car_react_rf"] = % lon_int_010_civ_car_reactions_skilo_gun_react_right;
  level.scr_anim["skilo_rf"]["car_react_rf_idle"][0] = % lon_int_010_civ_car_reactions_skilo_gun_react_right_idle;
  level.scr_anim["skilo_rf"]["car_react_back_rf"] = % lon_int_010_civ_car_reactions_skilo_gun_right_back_to_normal;
  level.scr_anim["skilo_rf"]["car_death"] = % vehicle_skilo_civ_death_rf;
  level.scr_goaltime["skilo_rf"]["car_death"] = 1;
  level.scr_anim["skilo_lf"]["car_idle_lf"][0] = % lon_int_010_civ_car_reactions_skilo_idle;
  level.scr_anim["skilo_lf"]["car_left_fwd_lf"] = % lon_int_010_civ_car_reactions_skilo_look_left_fwd;
  level.scr_anim["skilo_lf"]["car_left_lf"] = % lon_int_010_civ_car_reactions_skilo_look_left_side;
  level.scr_anim["skilo_lf"]["car_left_back_lf"] = % lon_int_010_civ_car_reactions_skilo_look_left_back;
  level.scr_anim["skilo_lf"]["car_react_lf"] = % lon_int_010_civ_car_reactions_skilo_gun_react_left;
  level.scr_anim["skilo_lf"]["car_react_lf_idle"][0] = % lon_int_010_civ_car_reactions_skilo_gun_react_left_idle;
  level.scr_anim["skilo_lf"]["car_react_back_lf"] = % lon_int_010_civ_car_reactions_skilo_gun_left_back_to_normal;
  level.scr_anim["skilo_lf"]["car_death"] = % vehicle_skilo_civ_death_lf;
  level.scr_goaltime["skilo_lf"]["car_death"] = 1;
  level.scr_anim["car_jumper_victim_r"]["idle"][0] = % lon_int_010_civ_car_idle_right;
  level.scr_anim["car_jumper_victim_l"]["idle"][0] = % lon_int_010_civ_car_idle_left;
  level.scr_anim["car_jumper_victim_r"]["car_death"] = % vehicle_skilo_civ_death_rf;
  level.scr_anim["car_jumper_victim_l"]["car_death"] = % vehicle_skilo_civ_death_lf;
  level.scr_anim["victor40_rf"]["car_idle_rf"][0] = % lon_int_010_civ_car_reactions_victor_idle;
  level.scr_anim["victor40_rf"]["car_right_fwd_rf"] = % lon_int_010_civ_car_reactions_victor_look_right_fwd;
  level.scr_anim["victor40_rf"]["car_right_rf"] = % lon_int_010_civ_car_reactions_victor_look_right_side;
  level.scr_anim["victor40_rf"]["car_right_back_rf"] = % lon_int_010_civ_car_reactions_victor_look_right_back;
  level.scr_anim["victor40_rf"]["car_react_rf"] = % lon_int_010_civ_car_reactions_victor_gun_react_right;
  level.scr_anim["victor40_rf"]["car_react_rf_idle"][0] = % lon_int_010_civ_car_reactions_victor_gun_react_right_idle;
  level.scr_anim["victor40_rf"]["car_react_back_rf"] = % lon_int_010_civ_car_reactions_victor_gun_right_back_to_normal;
  level.scr_anim["victor40_lf"]["car_idle_lf"][0] = % lon_int_010_civ_car_reactions_victor_idle;
  level.scr_anim["victor40_lf"]["car_left_fwd_lf"] = % lon_int_010_civ_car_reactions_victor_look_left_fwd;
  level.scr_anim["victor40_lf"]["car_left_lf"] = % lon_int_010_civ_car_reactions_victor_look_left_side;
  level.scr_anim["victor40_lf"]["car_left_back_lf"] = % lon_int_010_civ_car_reactions_victor_look_left_back;
  level.scr_anim["victor40_lf"]["car_react_lf"] = % lon_int_010_civ_car_reactions_victor_gun_react_left;
  level.scr_anim["victor40_lf"]["car_react_lf_idle"][0] = % lon_int_010_civ_car_reactions_victor_gun_react_left_idle;
  level.scr_anim["victor40_lf"]["car_react_back_lf"] = % lon_int_010_civ_car_reactions_victor_gun_left_back_to_normal;
  level.scr_anim["male_rf"]["decho_idle"][0] = % vehicle_decho_civ_idle_rf;
  level.scr_anim["male_rf"]["decho_scared_idle"][0] = % vehicle_decho_civ_scared_idle_rf;
  level.scr_anim["male_rf"]["decho_death"] = % vehicle_decho_civ_death_rf;
  level.scr_anim["male_rf"]["decho_exit_fwd"] = % vehicle_decho_civ_getout_rf_fwd;
  level.scr_anim["male_rf"]["decho_exit_side"] = % vehicle_decho_civ_getout_rf_side;
  level.scr_anim["male_rf"]["decho_exit_back"] = % vehicle_decho_civ_getout_rf_back;
  level.scr_anim["male_lf"]["decho_idle"][0] = % vehicle_decho_civ_idle_lf;
  level.scr_anim["male_lf"]["decho_scared_idle"][0] = % vehicle_decho_civ_scared_idle_lf;
  level.scr_anim["male_lf"]["decho_death"] = % vehicle_decho_civ_death_lf;
  level.scr_anim["male_lf"]["decho_exit_fwd"] = % vehicle_decho_civ_getout_lf_fwd;
  level.scr_anim["male_lf"]["decho_exit_side"] = % vehicle_decho_civ_getout_lf_side;
  level.scr_anim["male_lf"]["decho_exit_back"] = % vehicle_decho_civ_getout_lf_back;
  level.scr_anim["male_rf"]["calfa_idle"][0] = % vehicle_calfa_civ_idle_rf;
  level.scr_anim["male_rf"]["calfa_scared_idle"][0] = % vehicle_calfa_civ_scared_idle_rf;
  level.scr_anim["male_rf"]["calfa_death"] = % vehicle_calfa_civ_death_rf;
  level.scr_anim["male_rf"]["calfa_exit_fwd"] = % vehicle_calfa_civ_getout_rf_fwd;
  level.scr_anim["male_rf"]["calfa_exit_side"] = % vehicle_calfa_civ_getout_rf_side;
  level.scr_anim["male_rf"]["calfa_exit_back"] = % vehicle_calfa_civ_getout_rf_back;
  level.scr_anim["male_lf"]["calfa_idle"][0] = % vehicle_calfa_civ_idle_lf;
  level.scr_anim["male_lf"]["calfa_scared_idle"][0] = % vehicle_calfa_civ_scared_idle_lf;
  level.scr_anim["male_lf"]["calfa_death"] = % vehicle_calfa_civ_death_lf;
  level.scr_anim["male_lf"]["calfa_exit_fwd"] = % vehicle_calfa_civ_getout_lf_fwd;
  level.scr_anim["male_lf"]["calfa_exit_side"] = % vehicle_calfa_civ_getout_lf_side;
  level.scr_anim["male_lf"]["calfa_exit_back"] = % vehicle_calfa_civ_getout_lf_back;
  level.scr_anim["male_rf"]["ralfa_idle"][0] = % vehicle_ralfa_civ_idle_rf;
  level.scr_anim["male_rf"]["ralfa_scared_idle"][0] = % vehicle_ralfa_civ_scared_idle_rf;
  level.scr_anim["male_rf"]["ralfa_death"] = % vehicle_ralfa_civ_death_rf;
  level.scr_anim["male_rf"]["ralfa_exit_fwd"] = % vehicle_ralfa_civ_getout_rf_fwd;
  level.scr_anim["male_rf"]["ralfa_exit_side"] = % vehicle_ralfa_civ_getout_rf_side;
  level.scr_anim["male_rf"]["ralfa_exit_back"] = % vehicle_ralfa_civ_getout_rf_back;
  level.scr_anim["male_lf"]["ralfa_idle"][0] = % vehicle_ralfa_civ_idle_lf;
  level.scr_anim["male_lf"]["ralfa_scared_idle"][0] = % vehicle_ralfa_civ_scared_idle_lf;
  level.scr_anim["male_lf"]["ralfa_death"] = % vehicle_ralfa_civ_death_lf;
  level.scr_anim["male_lf"]["ralfa_exit_fwd"] = % vehicle_ralfa_civ_getout_lf_fwd;
  level.scr_anim["male_lf"]["ralfa_exit_side"] = % vehicle_ralfa_civ_getout_lf_side;
  level.scr_anim["male_lf"]["ralfa_exit_back"] = % vehicle_ralfa_civ_getout_lf_back;
  level.scr_anim["male_rf"]["skilo_idle"][0] = % vehicle_skilo_civ_idle_rf;
  level.scr_anim["male_rf"]["skilo_scared_idle"][0] = % vehicle_skilo_civ_scared_idle_rf;
  level.scr_anim["male_rf"]["skilo_death"] = % vehicle_skilo_civ_death_rf;
  level.scr_anim["male_rf"]["skilo_exit_fwd"] = % vehicle_skilo_civ_getout_rf_fwd;
  level.scr_anim["male_rf"]["skilo_exit_side"] = % vehicle_skilo_civ_getout_rf_side;
  level.scr_anim["male_rf"]["skilo_exit_back"] = % vehicle_skilo_civ_getout_rf_back;
  level.scr_anim["male_lf"]["skilo_idle"][0] = % vehicle_skilo_civ_idle_lf;
  level.scr_anim["male_lf"]["skilo_scared_idle"][0] = % vehicle_skilo_civ_scared_idle_lf;
  level.scr_anim["male_lf"]["skilo_death"] = % vehicle_skilo_civ_death_lf;
  level.scr_anim["male_lf"]["skilo_exit_fwd"] = % vehicle_skilo_civ_getout_lf_fwd;
  level.scr_anim["male_lf"]["skilo_exit_side"] = % vehicle_skilo_civ_getout_lf_side;
  level.scr_anim["male_lf"]["skilo_exit_back"] = % vehicle_skilo_civ_getout_lf_back;
  level.scr_anim["male_rf"]["victor40_idle"][0] = % vehicle_victor40_civ_idle_rf;
  level.scr_anim["male_rf"]["victor40_scared_idle"][0] = % vehicle_victor40_civ_scared_idle_rf;
  level.scr_anim["male_rf"]["victor40_death"] = % vehicle_victor40_civ_death_rf;
  level.scr_anim["male_rf"]["victor40_exit_fwd"] = % vehicle_victor40_civ_getout_rf_fwd;
  level.scr_anim["male_rf"]["victor40_exit_side"] = % vehicle_victor40_civ_getout_rf_side;
  level.scr_anim["male_rf"]["victor40_exit_back"] = % vehicle_victor40_civ_getout_rf_back;
  level.scr_anim["male_lf"]["victor40_idle"][0] = % vehicle_victor40_civ_idle_lf;
  level.scr_anim["male_lf"]["victor40_scared_idle"][0] = % vehicle_victor40_civ_scared_idle_lf;
  level.scr_anim["male_lf"]["victor40_death"] = % vehicle_victor40_civ_death_lf;
  level.scr_anim["male_lf"]["victor40_exit_fwd"] = % vehicle_victor40_civ_getout_lf_fwd;
  level.scr_anim["male_lf"]["victor40_exit_side"] = % vehicle_victor40_civ_getout_lf_side;
  level.scr_anim["male_lf"]["victor40_exit_back"] = % vehicle_victor40_civ_getout_lf_back;
  level.scr_anim["car_jumper"]["car_jump_start"] = % pic_carterrorist_a_enter;
  level.scr_anim["car_jumper"]["car_jump_exit_back"] = % pic_carterrorist_a_react_behind;
  level.scr_anim["car_jumper"]["car_jump_exit_front"] = % pic_carterrorist_a_react_front;
  level.scr_anim["car_jumper"]["car_jump_idle"][0] = % pic_carterrorist_a_loop;
  level.scr_anim["car_jumper"]["car_jump_start_shoot"] = % pic_carterrorist_a_start_shoot;
  level.scr_anim["car_jumper"]["car_jump_loop_shoot"][0] = % pic_carterrorist_a_loop_shoot;
  level.scr_anim["car_jumper"]["car_jump_death"] = % pic_carterrorist_a_death;
  level.scr_anim["police01"]["police_arrive"] = % lon_pic_020_cops_arrive_police01;
  scripts\common\anim::addnotetrack_customfunction("police01", "dead", ::police_die, "police_arrive");
  scripts\common\anim::addnotetrack_customfunction("police01", "shot", ::make_visible_notsolid, "police_arrive");
  scripts\common\anim::addnotetrack_customfunction("police01", "shot", ::squib_chest, "police_arrive");
  level.scr_anim["police02"]["police_arrive"] = % lon_pic_020_cops_arrive_police02;
  scripts\common\anim::addnotetrack_customfunction("police02", "dead", ::police_die, "police_arrive");
  scripts\common\anim::addnotetrack_customfunction("police02", "shot", ::squib_chest, "police_arrive");
  level.scr_anim["bus_death_civ01"]["bus_death"] = % lon_pic_025_bus_death_civ01;
  level.scr_anim["bus_death_civ02"]["bus_death"] = % lon_pic_025_bus_death_civ02;
  level.scr_anim["bus_death_civ03"]["bus_death"] = % lon_pic_025_bus_death_civ03;
  level.scr_anim["bus_death_civ04"]["bus_death"] = % lon_pic_025_bus_death_civ04;
  level.scr_anim["bus_death_civ05"]["bus_death"] = % lon_pic_025_bus_death_civ05;
  level.scr_anim["bus_death_enmy01"]["bus_death"] = % lon_pic_025_bus_death_enmy01;
  level.scr_anim["lw_t1"]["lilly_whites_execution_idle"][0] = % lon_pic_031_lilly_executions_t01_start_idle;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_idle"][0] = % lon_pic_031_lilly_executions_civ01_start_idle;
  level.scr_anim["lw_civ2"]["lilly_whites_execution_idle"][0] = % lon_pic_031_lilly_executions_civ02_start_idle;
  level.scr_anim["lw_civ3"]["lilly_whites_execution_idle"][0] = % lon_pic_031_lilly_executions_civ03_start_idle;
  level.scr_anim["lw_t1"]["lilly_whites_execution"] = % lon_pic_031_lilly_executions_t01_start;
  level.scr_anim["lw_civ1"]["lilly_whites_execution"] = % lon_pic_031_lilly_executions_civ01_start;
  level.scr_anim["lw_civ2"]["lilly_whites_execution"] = % lon_pic_031_lilly_executions_civ02_start;
  level.scr_anim["lw_civ3"]["lilly_whites_execution"] = % lon_pic_031_lilly_executions_civ03_start;
  level.scr_anim["lw_civ1"]["lilly_whites_free"] = % lon_pic_031_lilly_executions_civ01_react;
  level.scr_anim["lw_civ2"]["lilly_whites_free"] = % lon_pic_031_lilly_executions_civ03_react;
  level.scr_anim["lw_civ3"]["lilly_whites_free"] = % lon_pic_031_lilly_executions_civ02_react;
  level.scr_anim["lw_civ1"]["lilly_whites_free_idle"][0] = % lon_pic_031_lilly_executions_civ01_react_idle;
  level.scr_anim["lw_civ2"]["lilly_whites_free_idle"][0] = % lon_pic_031_lilly_executions_civ03_react_idle;
  level.scr_anim["lw_civ3"]["lilly_whites_free_idle"][0] = % lon_pic_031_lilly_executions_civ02_react_idle;
  level.scr_anim["lw_civ1"]["lilly_whites_free_cower"] = % lon_pic_031_lilly_executions_civ01_react_gun;
  level.scr_anim["lw_civ2"]["lilly_whites_free_cower"] = % lon_pic_031_lilly_executions_civ03_react_gun;
  level.scr_anim["lw_civ3"]["lilly_whites_free_cower"] = % lon_pic_031_lilly_executions_civ02_react_gun;
  scripts\common\anim::addnotetrack_customfunction("lw_civ2", "shot", ::lilly_civ_shot, "lilly_whites_execution");
  scripts\common\anim::addnotetrack_customfunction("lw_civ3", "shot", ::lilly_civ_shot, "lilly_whites_execution");
  level.scr_anim["lw_t1"]["lilly_whites_execution_struggle"][0] = % lon_pic_031_lilly_executions_t01_struggle_loop;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_struggle"][0] = % lon_pic_031_lilly_executions_civ01_struggle_loop;
  level.scr_anim["lw_t1"]["lilly_whites_execution_enemy_death"] = % lon_pic_031_lilly_executions_t01_enemy_death;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_enemy_death"] = % lon_pic_031_lilly_executions_civ01_enemy_death;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_enemy_death_idle"][0] = % lon_pic_031_lilly_executions_civ01_enemy_death_idle;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_enemy_death_cower"] = % lon_pic_031_lilly_executions_civ01_enemy_death_react_gun;
  level.scr_anim["lw_t1"]["lilly_whites_execution_civ_death"] = % lon_pic_031_lilly_executions_t01_civ_death;
  level.scr_anim["lw_civ1"]["lilly_whites_execution_civ_death"] = % lon_pic_031_lilly_executions_civ01_civ_death;
  level.scr_anim["left_underground_t1"]["left_underground_execution"] = % lon_pic_035_subway_executions_t01_execute;
  level.scr_anim["left_underground_t2"]["left_underground_execution"] = % lon_pic_035_subway_executions_t02_execute;
  level.scr_anim["left_underground_civ1"]["left_underground_execution"] = % lon_pic_035_subway_executions_civ01_execute;
  level.scr_anim["left_underground_civ2"]["left_underground_execution"] = % lon_pic_035_subway_executions_civ02_execute;
  level.scr_anim["left_underground_civ3"]["left_underground_execution"] = % lon_pic_035_subway_executions_civ03_execute;
  level.scr_anim["left_underground_civ4"]["left_underground_execution"] = % lon_pic_035_subway_executions_civ04_execute;
  scripts\common\anim::addnotetrack_customfunction("left_underground_civ1", "shot", ::left_underground_civ, "left_underground_execution");
  scripts\common\anim::addnotetrack_customfunction("left_underground_civ2", "shot", ::left_underground_civ, "left_underground_execution");
  scripts\common\anim::addnotetrack_customfunction("left_underground_civ3", "shot", ::left_underground_civ, "left_underground_execution");
  scripts\common\anim::addnotetrack_customfunction("left_underground_civ4", "shot", ::left_underground_civ, "left_underground_execution");
  level.scr_anim["left_underground_civ1"]["left_underground_execution_idle"][0] = % lon_pic_035_subway_executions_civ01_idle;
  level.scr_anim["left_underground_civ2"]["left_underground_execution_idle"][0] = % lon_pic_035_subway_executions_civ02_idle;
  level.scr_anim["left_underground_civ3"]["left_underground_execution_idle"][0] = % lon_pic_035_subway_executions_civ03_idle;
  level.scr_anim["left_underground_civ4"]["left_underground_execution_idle"][0] = % lon_pic_035_subway_executions_civ04_idle;
  level.scr_anim["left_underground_civ1"]["left_underground_execution_getup"] = % lon_pic_035_subway_executions_civ01_react;
  level.scr_anim["left_underground_civ2"]["left_underground_execution_getup"] = % lon_pic_035_subway_executions_civ02_react;
  level.scr_anim["left_underground_civ3"]["left_underground_execution_getup"] = % lon_pic_035_subway_executions_civ03_react;
  level.scr_anim["left_underground_civ4"]["left_underground_execution_getup"] = % lon_pic_035_subway_executions_civ04_react;
  level.scr_anim["left_underground_civ1"]["left_underground_execution_getup_idle"][0] = % lon_pic_035_subway_executions_civ01_react_idle;
  level.scr_anim["left_underground_civ2"]["left_underground_execution_getup_idle"][0] = % lon_pic_035_subway_executions_civ02_react_idle;
  level.scr_anim["left_underground_civ3"]["left_underground_execution_getup_idle"][0] = % lon_pic_035_subway_executions_civ03_react_idle;
  level.scr_anim["left_underground_civ4"]["left_underground_execution_getup_idle"][0] = % lon_pic_035_subway_executions_civ04_react_idle;
  level.scr_anim["left_underground_civ1"]["left_underground_execution_react_ads"] = % lon_pic_035_subway_executions_civ01_react_gun;
  level.scr_anim["left_underground_civ2"]["left_underground_execution_react_ads"] = % lon_pic_035_subway_executions_civ02_react_gun;
  level.scr_anim["left_underground_civ3"]["left_underground_execution_react_ads"] = % lon_pic_035_subway_executions_civ03_react_gun;
  level.scr_anim["left_underground_civ4"]["left_underground_execution_react_ads"] = % lon_pic_035_subway_executions_civ04_react_gun;
  level.scr_anim["left_underground_t1"]["left_underground_execution_react_r"] = % lon_pic_035_subway_executions_t01_react_right;
  level.scr_anim["left_underground_t2"]["left_underground_execution_react_r"] = % lon_pic_035_subway_executions_t02_react_right;
  level.scr_anim["left_underground_t1"]["left_underground_execution_react_l"] = % lon_pic_035_subway_executions_t01_react_left;
  level.scr_anim["left_underground_t2"]["left_underground_execution_react_l"] = % lon_pic_035_subway_executions_t02_react_left;
  level.scr_anim["left_underground_t1"]["left_underground_execution_death"] = % lon_pic_035_subway_executions_t01_death;
  level.scr_anim["left_underground_t2"]["left_underground_execution_death"] = % lon_pic_035_subway_executions_t02_death;
  level.scr_anim["generic"]["generic_hostage_idle1"][0] = % lon_pic_031_lilly_executions_civ01_start_idle_relative;
  level.scr_anim["generic"]["generic_hostage_idle2"][0] = % lon_pic_031_lilly_executions_civ02_start_idle_relative;
  level.scr_anim["generic"]["generic_hostage_idle3"][0] = % lon_pic_031_lilly_executions_civ03_start_idle_relative;
  level.scr_anim["generic"]["generic_hostage_getup"] = % lon_pic_035_subway_executions_civ01_react_relative;
  level.scr_anim["subway_right_civ1"]["right_subway_escape"] = % lon_pic_026_subway_exit_death01;
  level.scr_anim["subway_right_civ2"]["right_subway_escape"] = % lon_pic_026_subway_exit_death_02_civ1;
  level.scr_anim["subway_right_civ3"]["right_subway_escape"] = % lon_pic_026_subway_exit_death_02_civ2;
  level.scr_anim["subway_right_civ4"]["right_subway_escape"] = % lon_pic_026_subway_exit_escape_civ1;
  level.scr_anim["subway_right_civ5"]["right_subway_escape"] = % lon_pic_026_subway_exit_escape_civ2;
  level.scr_anim["subway_right_rescue_p"]["right_subway_rescue"] = % lon_pic_060_subway_police_officer;
  level.scr_anim["subway_right_rescue_civ1"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ01;
  level.scr_anim["subway_right_rescue_civ2"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ02;
  level.scr_anim["subway_right_rescue_civ3"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ03;
  level.scr_anim["subway_right_rescue_civ4"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ04;
  level.scr_anim["subway_right_rescue_civ5"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ05;
  level.scr_anim["subway_right_rescue_civ6"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ06;
  level.scr_anim["subway_right_rescue_civ7"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ07;
  level.scr_anim["subway_right_rescue_civ8"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ08;
  level.scr_anim["subway_right_rescue_civ9"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ09;
  level.scr_anim["subway_right_rescue_civ10"]["right_subway_rescue"] = % lon_pic_060_subway_police_civ10;
  level.scr_anim["sting_rescue_p"]["sting_rescue_idle"][0] = % lon_pic_040_sting_police_officer_idle;
  level.scr_anim["sting_rescue_civ1"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ01_idle;
  level.scr_anim["sting_rescue_civ2"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ02_idle;
  level.scr_anim["sting_rescue_civ3"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ03_idle;
  level.scr_anim["sting_rescue_civ4"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ04_idle;
  level.scr_anim["sting_rescue_civ5"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ05_idle;
  level.scr_anim["sting_rescue_civ6"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ06_idle;
  level.scr_anim["sting_rescue_civ7"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ07_idle;
  level.scr_anim["sting_rescue_civ8"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ08_idle;
  level.scr_anim["sting_rescue_civ8"]["sting_rescue_idle"][0] = % lon_pic_040_sting_civ08_idle;
  level.scr_anim["sting_rescue_p"]["sting_rescue"] = % lon_pic_040_sting_police_officer;
  level.scr_anim["sting_rescue_civ1"]["sting_rescue"] = % lon_pic_040_sting_civ01;
  level.scr_anim["sting_rescue_civ2"]["sting_rescue"] = % lon_pic_040_sting_civ02;
  level.scr_anim["sting_rescue_civ3"]["sting_rescue"] = % lon_pic_040_sting_civ03;
  level.scr_anim["sting_rescue_civ4"]["sting_rescue"] = % lon_pic_040_sting_civ04;
  level.scr_anim["sting_rescue_civ5"]["sting_rescue"] = % lon_pic_040_sting_civ05;
  level.scr_anim["sting_rescue_civ6"]["sting_rescue"] = % lon_pic_040_sting_civ06;
  level.scr_anim["sting_rescue_civ7"]["sting_rescue"] = % lon_pic_040_sting_civ07;
  level.scr_anim["sting_rescue_civ8"]["sting_rescue"] = % lon_pic_040_sting_civ08;
  level.scr_anim["sting_rescue_p"]["sting_rescue_end"][0] = % lon_pic_040_sting_police_officer_end_idle;
  level.scr_goaltime["sting_rescue_p"]["sting_rescue"] = 1.5;
  level.scr_anim["sting_rescue_civ1"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ01_end_idle;
  level.scr_anim["sting_rescue_civ2"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ02_end_idle;
  level.scr_anim["sting_rescue_civ3"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ03_end_idle;
  level.scr_anim["sting_rescue_civ4"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ04_end_idle;
  level.scr_anim["sting_rescue_civ5"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ05_end_idle;
  level.scr_anim["sting_rescue_civ6"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ06_end_idle;
  level.scr_anim["sting_rescue_civ7"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ07_end_idle;
  level.scr_anim["sting_rescue_civ8"]["sting_rescue_end"][0] = % lon_pic_040_sting_civ08_end_idle;
  level.scr_anim["generic"]["shipcrib_moon_injured_guyA_idle_01"][0] = % shipcrib_moon_injured_guya_idle_01;
  level.scr_anim["generic"]["shipcrib_moon_injured_guyA_idle_02"][0] = % shipcrib_moon_injured_guya_idle_02;
  level.scr_anim["generic"]["shipcrib_moon_injured_guyA_idle_03"][0] = % shipcrib_moon_injured_guya_idle_03;
  level.scr_anim["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level.scr_anim["generic"]["mars_crib_un_elevator_injured_loop_01"][0] = % mars_crib_un_elevator_injured_loop_01;
  level.scr_anim["generic"]["ph_mall_injured_civi_02_idle"][0] = % ph_mall_injured_civi_02_idle;
  level.scr_anim["generic"]["ph_hill400_allied_injured_ambient_loop_02"][0] = % ph_hill400_allied_injured_ambient_loop_02;
  level.scr_anim["generic"]["lon_int_010_subway_idle"][0] = % lon_int_010_subway_idle;
  level.scr_goaltime["generic"]["lon_int_010_subway_death"] = 0.65;
  level.scr_anim["generic"]["lon_int_010_subway_death"] = % lon_int_010_subway_death;
  scripts\common\anim::addnotetrack_customfunction("generic", "shot", ::headshot_death, "lon_int_010_subway_death");
  level.scr_anim["guy1"]["drag01_intro_idle"][0] = % shipcrib_moon_injured_drag01_guyb_idle_01;
  level.scr_anim["guy1"]["drag01"] = % shipcrib_moon_injured_drag01_guyb;
  level.scr_anim["guy1"]["drag01_outro_idle"][0] = % shipcrib_moon_injured_drag01_guyb_idle_02;
  level.scr_anim["guy2"]["drag01_intro_idle"][0] = % shipcrib_moon_injured_drag01_guyc_idle_01;
  level.scr_anim["guy2"]["drag01"] = % shipcrib_moon_injured_drag01_guyc;
  level.scr_anim["guy2"]["drag01_outro_idle"][0] = % shipcrib_moon_injured_drag01_guyc_idle_02;
  level.scr_anim["guy1"]["drag02_intro_idle"][0] = % shipcrib_moon_injured_drag02_guyb_idle_01;
  level.scr_anim["guy1"]["drag02"] = % shipcrib_moon_injured_drag02_guyb;
  level.scr_anim["guy1"]["drag02_outro_idle"][0] = % shipcrib_moon_injured_drag02_guyb_idle_02;
  level.scr_anim["guy2"]["drag02_intro_idle"][0] = % shipcrib_moon_injured_drag02_guyc_idle_01;
  level.scr_anim["guy2"]["drag02"] = % shipcrib_moon_injured_drag02_guyc;
  level.scr_anim["guy2"]["drag02_outro_idle"][0] = % shipcrib_moon_injured_drag02_guyc_idle_02;
  level.scr_anim["guy2"]["drag03_intro_idle"][0] = % shipcrib_moon_injured_drag03_guyb_idle_01;
  level.scr_anim["guy2"]["drag03"] = % shipcrib_moon_injured_drag03_guyb;
  level.scr_anim["guy2"]["drag03_outro_idle"][0] = % shipcrib_moon_injured_drag03_guyb_idle_02;
  level.scr_anim["guy1"]["drag03_intro_idle"][0] = % shipcrib_moon_injured_drag03_guyc_idle_01;
  level.scr_anim["guy1"]["drag03"] = % shipcrib_moon_injured_drag03_guyc;
  level.scr_anim["guy1"]["drag03_outro_idle"][0] = % shipcrib_moon_injured_drag03_guyc_idle_02;
  level.scr_anim["civ01"]["idle"][0] = % lon_pic_015_leaning_civ_01_idle;
  level.scr_anim["civ01"]["injured_death"] = % lon_pic_015_leaning_civ_01_death;
  scripts\common\anim::addnotetrack_customfunction("civ01", "shot_head", ::squib_head, "injured_death");
  level.scr_anim["civ03"]["idle"][0] = % lon_pic_015_leaning_civ_03_idle;
  level.scr_anim["civ03"]["injured_death"] = % lon_pic_015_leaning_civ_03_death;
  scripts\common\anim::addnotetrack_customfunction("civ03", "shot_chest", ::squib_chest, "injured_death");
  scripts\common\anim::addnotetrack_customfunction("civ03", "shot_head", ::squib_head, "injured_death");
  level.scr_anim["civ04"]["idle"][0] = % lon_pic_015_leaning_civ_04_idle;
  level.scr_anim["civ04"]["run"] = % lon_pic_015_leaning_civ_04_run;
  level.scr_anim["civ04"]["dying_idle"][0] = % lon_pic_015_leaning_civ_04_dying_idle;
  level.scr_anim["civ04"]["injured_death"] = % lon_pic_015_leaning_civ_04_death;
  scripts\common\anim::addnotetrack_customfunction("civ04", "shot_back", ::squib_back, "run");
  scripts\common\anim::addnotetrack_customfunction("civ04", "pain", scripts\sp\maps\piccadilly\piccadilly_util.gsc::pain_vo, "dying_idle");
  level.scr_anim["civ05"]["idle"][0] = % lon_pic_015_leaning_civ_05_idle;
  level.scr_anim["civ05"]["run"] = % lon_pic_015_leaning_civ_05_run;
  scripts\common\anim::addnotetrack_customfunction("civ05", "shot_left_leg", ::squib_left_leg, "run");
  level.scr_anim["civ05"]["dying_idle"][0] = % lon_pic_015_leaning_civ_05_dying_idle;
  level.scr_anim["civ05"]["injured_death"] = % lon_pic_015_leaning_civ_05_death;
  scripts\common\anim::addnotetrack_customfunction("civ05", "shot_head", ::squib_head, "injured_death");
  scripts\common\anim::addnotetrack_customfunction("civ05", "pain", scripts\sp\maps\piccadilly\piccadilly_util.gsc::pain_vo, "injured_death");
  level.scr_anim["civ06"]["idle"][0] = % lon_pic_015_leaning_civ_06_idle;
  level.scr_anim["civ06"]["injured_death"] = % lon_pic_015_leaning_civ_06_death;
  scripts\common\anim::addnotetrack_customfunction("civ06", "shot_leg", ::squib_left_leg, "injured_death");
  scripts\common\anim::addnotetrack_customfunction("civ06", "shot_back", ::squib_back, "injured_death");
  level.scr_anim["civ07"]["idle"][0] = % lon_pic_015_leaning_civ_07_idle;
  level.scr_anim["civ07"]["injured_death"] = % lon_pic_015_leaning_civ_07_death;
  scripts\common\anim::addnotetrack_customfunction("civ07", "shot_chest", ::squib_chest, "injured_death");
  level.scr_anim["civ08"]["idle"][0] = % lon_pic_015_leaning_civ_08_idle;
  level.scr_anim["civ08"]["injured_death"] = % lon_pic_015_leaning_civ_08_death;
  scripts\common\anim::addnotetrack_customfunction("civ08", "shot_chest", ::squib_chest, "injured_death");
  level.scr_anim["ralfa_right"]["left_crash_exit"] = % lon_pic_lft_050_cars_exit_terry_right;
  level.scr_anim["ralfa_left"]["left_crash_exit"] = % lon_pic_lft_050_cars_exit_terry_left;
  level.scr_anim["civ1"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_civ1_enter;
  level.scr_anim["civ3"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_civ3_enter;
  level.scr_anim["civ4"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_civ4_enter;
  level.scr_anim["civ7"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_civ7_enter;
  level.scr_anim["civ8"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_civ8_enter;
  level.scr_anim["terry"]["bus_rescue_start"] = % lon_pic_ctr_030_bus_sniper_terry2_enter;
  scripts\common\anim::addnotetrack_flag("terry", "kill_civ1", "bus_scene_kill_civ1", "bus_rescue_start");
  scripts\common\anim::addnotetrack_flag("terry", "kill_civs", "bus_scene_kill_civs", "bus_rescue_start");
  level.scr_anim["civ3"]["bus_rescue_idle_enter"] = % lon_pic_ctr_030_bus_sniper_civ3_idle_enter;
  level.scr_anim["civ7"]["bus_rescue_idle_enter"] = % lon_pic_ctr_030_bus_sniper_civ7_idle_enter;
  level.scr_anim["civ8"]["bus_rescue_idle_enter"] = % lon_pic_ctr_030_bus_sniper_civ8_idle_enter;
  level.scr_anim["civ1"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ1_idle;
  level.scr_anim["civ3"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ3_idle;
  level.scr_anim["civ4"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ4_idle;
  level.scr_anim["civ7"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ7_idle;
  level.scr_anim["civ8"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ8_idle;
  level.scr_anim["terry"]["bus_rescue_idle"][0] = % lon_pic_ctr_030_bus_sniper_terry2_idle;
  level.scr_anim["civ3"]["bus_rescue_exit"] = % lon_pic_ctr_030_bus_sniper_civ3_exit;
  level.scr_anim["civ4"]["bus_rescue_exit"] = % lon_pic_ctr_030_bus_sniper_civ4_exit;
  level.scr_anim["civ7"]["bus_rescue_exit"] = % lon_pic_ctr_030_bus_sniper_civ7_exit;
  level.scr_anim["civ8"]["bus_rescue_exit"] = % lon_pic_ctr_030_bus_sniper_civ8_exit;
  level.scr_anim["civ1"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_civ1_death;
  level.scr_anim["civ3"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_civ3_death;
  level.scr_anim["civ4"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_civ4_death;
  level.scr_anim["civ7"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_civ7_death;
  level.scr_anim["civ8"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_civ8_death;
  level.scr_anim["terry"]["bus_rescue_death"] = % lon_pic_ctr_030_bus_sniper_terry2_death;
  level.scr_anim["civ3"]["bus_rescued_enter"] = % lon_pic_ctr_030_bus_sniper_civ3_crouch_enter;
  level.scr_anim["civ4"]["bus_rescued_enter"] = % lon_pic_ctr_030_bus_sniper_civ4_crouch_enter;
  level.scr_anim["civ7"]["bus_rescued_enter"] = % lon_pic_ctr_030_bus_sniper_civ7_crouch_enter;
  level.scr_anim["civ8"]["bus_rescued_enter"] = % lon_pic_ctr_030_bus_sniper_civ8_crouch_enter;
  level.scr_anim["civ3"]["bus_rescued_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ3_crouch_idle;
  level.scr_anim["civ4"]["bus_rescued_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ4_crouch_idle;
  level.scr_anim["civ7"]["bus_rescued_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ7_crouch_idle;
  level.scr_anim["civ8"]["bus_rescued_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ8_crouch_idle;
}

civ_in_position(var_0) {
  var_0 scripts\engine\utility::ent_flag_set("this_anim_finished");
}

lilly_civ_shot(var_0) {
  if(!isalive(level.lilly_terry)) {
    return;
  }
  level.lillywhites_civs = scripts\engine\utility::array_remove(level.lillywhites_civs, var_0);
  thread squib_head(var_0);
  var_0 notify("shot");
  wait 1;
  var_0 startragdoll();

  if(!isai(var_0)) {
    var_0 setCanDamage(0);
    var_0 freeentitysentient();
    var_0 notsolid();
  }
}

notify_self_nag(var_0) {
  var_0 notify("nag");
}

kyle_swap(var_0) {
  var_0 delete();
}

bullettracer_hack(var_0) {
  var_1 = var_0 gettagorigin("tag_flash");
  var_2 = var_1 + anglesToForward(var_0 gettagangles("tag_flash")) * 100;
  bullettracer(var_1, var_2, "iw8_ar_akilo47", 1);
}

spec_terry_shot(var_0) {
  scripts\engine\utility::flag_set("price_intro_terry_shot");
  level.price shoot(1, var_0 getEye());
  wait 0.1;
  level.price shoot(1, var_0 getEye());

  if(isDefined(level.player_radio_emitter))
    level.player_radio_emitter notify("death");
}

already_dead(var_0) {
  var_0.allowdeath = 0;
  drop_weapon_now(var_0);
}

drop_weapon_now(var_0) {
  if(isalive(var_0)) {
    var_0 dropweapon(var_0.weapon, "right", 0);
    var_0 scripts\common\ai::gun_remove();
  }
}

left_underground_civ(var_0) {
  var_0.shot = 1;
  squib_head(var_0);
  wait 2;

  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
  var_0 kill();
}

headshot_death(var_0) {
  squib_head(var_0);
  wait 0.1;
  var_0 thread scripts\anim\shared.gsc::dropallaiweapons();
  wait 1.6;
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0.ragdoll_immediate = 1;
  var_0.a.nodeath = 1;
  var_0.allowdeath = 1;
  var_0 scripts\engine\sp\utility::die();
}

squib_left_leg(var_0) {
  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::pain_vo();
  thread scripts\engine\utility::play_sound_in_space("ar_whiz_near_near_in", var_0 gettagorigin("j_knee_le"));
  playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var_0, "j_knee_le");
  thread scripts\engine\utility::play_sound_in_space("npc_bullet_impact_script", var_0 gettagorigin("j_knee_le"));
}

squib_back(var_0) {
  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::death_vo();
  thread scripts\engine\utility::play_sound_in_space("ar_whiz_near_near_in", var_0 gettagorigin("tag_shield_back"));
  playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var_0, "tag_shield_back");
  thread scripts\engine\utility::play_sound_in_space("npc_bullet_impact_script", var_0 gettagorigin("tag_shield_back"));
}

squib_chest(var_0) {
  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::death_vo();
  thread scripts\engine\utility::play_sound_in_space("ar_whiz_near_near_in", var_0 gettagorigin("j_chest"));
  playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var_0, "j_chest");
  thread scripts\engine\utility::play_sound_in_space("npc_bullet_impact_script", var_0 gettagorigin("j_chest"));

  if(isai(var_0) && !istrue(var_0.ignoreme))
    var_0.ignoreme = 1;
}

squib_head(var_0) {
  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::death_vo();
  thread scripts\engine\utility::play_sound_in_space("ar_whiz_near_near_in", var_0 gettagorigin("tag_eye"));
  playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var_0, "tag_eye");
  thread scripts\engine\utility::play_sound_in_space("npc_bullet_impact_script", var_0 gettagorigin("tag_eye"));
}

make_visible_notsolid(var_0) {
  var_0 visiblenotsolid();
}

police_die(var_0) {
  var_0 scripts\anim\shared.gsc::dropallaiweapons();
  var_0.ragdoll_immediate = 1;
  var_0.allowdeath = 1;
  var_0 scripts\engine\sp\utility::die();
}

start_countdown(var_0) {
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("sp_piccadilly_vest_timer");
}

start_explosion(var_0) {
  scripts\engine\utility::flag_set("hostage_explosion");
  var_0.bomb_exploded = 1;
  scripts\engine\utility::exploder("suicide_bomb");
  thread sfx_bombvest_expl_finale(level.hostage.origin);
  var_1 = level.player gettagorigin("j_head");
  earthquake(0.5, 0.7, var_1, 200);
  screenshake(var_1, 2, 0, 0, 0.5);
  playrumbleonposition("grenade_rumble", var_1);
  level.player shellshock("default_nosound", 3.2);
  level.player scripts\engine\utility::delaycall(2.7, ::fadeoutshellshock);
  wait 0.2;
  var_2 = scripts\sp\endmission::getlevelindex(level.script);
  scripts\sp\endmission::setfadetime(var_2, 0);
  var_3 = var_2 + 1;
  var_4 = scripts\sp\endmission::getlevelbink(var_3);
  level.endmission_bink_skip = 1;
  setsaveddvar("LNSNKKLPLL", "0");
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var_4, 1, 1, 1, 0, 0, 1);
}

sfx_bombvest_expl_finale(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playexplosionsound("scn_piccadilly_bombvest_expl_finale_lr", "exp");
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["debris1"] = #animtree;
  level.scr_model["debris1"] = "uk_debris_pic_specstore_blocker_01";
  level.scr_anim["debris1"]["price_spec_intro"] = % lon_tto_010_blocker;
  level.scr_animtree["debris2"] = #animtree;
  level.scr_model["debris2"] = "uk_debris_pic_specstore_blocker_02";
  level.scr_anim["debris2"]["price_spec_intro"] = % lon_tto_010_back_blocker;
  level.scr_animtree["intro_bus"] = #animtree;
  level.scr_anim["intro_bus"]["intro_slamzoom"] = % lon_pic_010_bus_enter;
  scripts\common\anim::addnotetrack_customfunction("intro_bus", "temp_cut", ::stop_anim, "intro_slamzoom");
  level.scr_animtree["right_car1_shell"] = #animtree;
  level.scr_model["right_car1_shell"] = "veh8_piccadilly_crash_gr1_secho_soft";
  level.scr_anim["right_car1_shell"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_secho_soft;
  level.scr_animtree["right_car2_shell"] = #animtree;
  level.scr_model["right_car2_shell"] = "veh8_piccadilly_crash_gr1_walfa_soft";
  level.scr_anim["right_car2_shell"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_walfa_soft;
  level.scr_animtree["right_car3_shell"] = #animtree;
  level.scr_model["right_car3_shell"] = "veh8_piccadilly_crash_gr1_victor_soft";
  level.scr_anim["right_car3_shell"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_victor_soft;
  level.scr_animtree["right_car4_shell"] = #animtree;
  level.scr_model["right_car4_shell"] = "veh8_piccadilly_crash_gr1_skilo_soft";
  level.scr_anim["right_car4_shell"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_skilo_soft;
  level.scr_animtree["left_crash_car2_shell"] = #animtree;
  level.scr_model["left_crash_car2_shell"] = "veh8_piccadilly_accident_gr2_victor_soft";
  level.scr_anim["left_crash_car2_shell"]["left_car_crash"] = % veh8_piccadilly_accident_gr2_victor_soft;
  level.scr_animtree["sting_rescue_reg"] = #animtree;
  level.scr_model["sting_rescue_reg"] = "greece_cash_register";
  level.scr_anim["sting_rescue_reg"]["sting_rescue_idle"][0] = % lon_pic_040_sting_register_idle;
  level.scr_anim["sting_rescue_reg"]["sting_rescue"] = % lon_pic_040_sting_register;
  level.scr_animtree["sting_rescue_car"] = #animtree;
  level.scr_model["sting_rescue_car"] = "veh8_civ_lnd_victor40";
  level.scr_anim["sting_rescue_car"]["sting_rescue"] = % lon_pic_040_sting_veh01;
  level.scr_animtree["volvo_police"] = #animtree;
  level.scr_model["volvo_police"] = "veh8_civ_lnd_victor40_police";
  level.scr_anim["volvo_police"]["police_arrive"] = % lon_pic_020_cops_arrive_veh01;
}

stop_anim(var_0) {
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
}

vehicles() {}

#using_animtree("scriptables");

scriptables() {
  level.scr_animtree["sas_intro_decho"] = #animtree;
  level.scr_anim["sas_intro_decho"]["intro_slamzoom"] = % lon_pic_010_sas_enter_asierra;
  level.scr_goaltime["sas_intro_decho"]["intro_slamzoom"] = 0;
  level.scr_anim["trailer_car"]["door_open"] = % vehicle_skilo_car_getout_rr_side;
  level.scr_animtree["car1_bomb"] = #animtree;
  level.scr_anim["car1_bomb"]["intro_slamzoom"] = % lon_pic_010_car_skilo_enter_02;
  level.scr_goaltime["car1_bomb"]["intro_slamzoom"] = 0;
  level.scr_anim["car1_bomb"]["intro_slamzoom_v1_exit"] = % lon_pic_010_car_skilo_idle_exit;
  level.scr_goaltime["car1_bomb"]["intro_slamzoom_v1_exit"] = 0;
  level.scr_anim["car1_bomb"]["intro_slamzoom_v2"] = % lon_pic_010_car_skilo_standoff_enter;
  level.scr_goaltime["car1_bomb"]["intro_slamzoom_v2"] = 0;
  level.scr_anim["car1_bomb"]["intro_standoff"] = % lon_pic_010_car_skilo_standoff;
  level.scr_goaltime["car1_bomb"]["intro_standoff"] = 0.4;
  level.scr_anim["car1_bomb"]["car_explosion"] = % lon_pic_010_car_skilo_exp_02;
  level.scr_goaltime["car1_bomb"]["car_explosion"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("car1_bomb", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car1_bomb", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["car2_bomb"] = #animtree;
  level.scr_anim["car2_bomb"]["intro_slamzoom"] = % lon_pic_010_suicide_car_enter;
  level.scr_goaltime["car2_bomb"]["intro_slamzoom"] = 0;
  level.scr_anim["car2_bomb"]["intro_slamzoom_v1_idle"][0] = % lon_pic_010_suicide_car_idle;
  level.scr_goaltime["car2_bomb"]["intro_slamzoom_v1_idle"] = 0;
  level.scr_anim["car2_bomb"]["standoff"] = % lon_pic_010_suicide_car_standoff;
  level.scr_goaltime["car2_bomb"]["standoff"] = 0.4;
  level.scr_anim["car2_bomb"]["car2_drives_off"] = % lon_pic_010_suicide_car_exp_enter;
  level.scr_goaltime["car2_bomb"]["car2_drives_off"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "sfx_van_passby", ::sfx_van_passby, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "car_braking", ::scriptable_braking, "car2_drives_off");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "car_reset", ::scriptable_brake_reset, "car2_drives_off");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "pre_explo_mix_1", ::sfx_pre_explo_mix_change_1, "car2_drives_off");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "pre_explo_mix_2", ::sfx_pre_explo_mix_change_2, "car2_drives_off");
  scripts\common\anim::addnotetrack_customfunction("car2_bomb", "explosion", ::car2_bomb_explosion, "car2_drives_off");
  level.scr_animtree["car3_bomb"] = #animtree;
  level.scr_anim["car3_bomb"]["intro_slamzoom"] = % lon_pic_010_car_ralpha_enter_03;
  level.scr_goaltime["car3_bomb"]["intro_slamzoom"] = 0;
  level.scr_anim["car3_bomb"]["car2_drives_off"] = % lon_pic_010_car_ralpha_exp_enter_03;
  level.scr_goaltime["car3_bomb"]["car2_drives_off"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("car3_bomb", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car3_bomb", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["car4_bomb"] = #animtree;
  level.scr_anim["car4_bomb"]["intro_slamzoom"] = % lon_pic_010_car_cab_enter_02;
  level.scr_goaltime["car4_bomb"]["intro_slamzoom"] = 0;
  level.scr_anim["car4_bomb"]["car2_drives_off"] = % lon_pic_010_car_cab_exp_enter_02;
  level.scr_goaltime["car4_bomb"]["car2_drives_off"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("car4_bomb", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("car4_bomb", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car1"] = #animtree;
  level.scr_anim["intro_car1"]["intro_slamzoom"] = % lon_pic_010_car_ralfa_enter_01;
  level.scr_goaltime["intro_car1"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car1", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car1", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car2"] = #animtree;
  level.scr_anim["intro_car2"]["intro_slamzoom"] = % lon_pic_010_car_victor_enter_01;
  level.scr_goaltime["intro_car2"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car2", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car2", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car3"] = #animtree;
  level.scr_anim["intro_car3"]["intro_slamzoom"] = % lon_pic_010_car_skilo_enter_01;
  level.scr_goaltime["intro_car3"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car3", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car3", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car4"] = #animtree;
  level.scr_anim["intro_car4"]["intro_slamzoom"] = % lon_pic_010_car_secho_enter_01;
  level.scr_goaltime["intro_car4"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car4", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car4", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car5"] = #animtree;
  level.scr_anim["intro_car5"]["intro_slamzoom"] = % lon_pic_010_car_cab_enter_01;
  level.scr_goaltime["intro_car5"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car5", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car5", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car6"] = #animtree;
  level.scr_anim["intro_car6"]["intro_slamzoom"] = % lon_pic_010_car_ralfa_enter_02;
  level.scr_goaltime["intro_car6"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car6", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car6", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car7"] = #animtree;
  level.scr_anim["intro_car7"]["intro_slamzoom"] = % lon_pic_010_car_victor_enter_02;
  level.scr_goaltime["intro_car7"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car7", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car7", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car8"] = #animtree;
  level.scr_anim["intro_car8"]["intro_slamzoom"] = % lon_pic_010_car_secho_enter_02;
  level.scr_goaltime["intro_car8"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car8", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car8", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car9"] = #animtree;
  level.scr_anim["intro_car9"]["intro_slamzoom"] = % lon_pic_010_car_victor_enter_03;
  level.scr_goaltime["intro_car9"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car9", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car9", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car10"] = #animtree;
  level.scr_anim["intro_car10"]["intro_slamzoom"] = % lon_pic_010_car_skilo_enter_03;
  level.scr_goaltime["intro_car10"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car10", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car10", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car10", "sfx_sedan_passby", ::sfx_sedan_passby, "intro_slamzoom");
  level.scr_animtree["intro_car11"] = #animtree;
  level.scr_anim["intro_car11"]["intro_slamzoom"] = % lon_pic_010_car_secho_enter_03;
  level.scr_goaltime["intro_car11"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car11", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car11", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car12"] = #animtree;
  level.scr_anim["intro_car12"]["intro_slamzoom"] = % lon_pic_010_car_victor_enter_04;
  level.scr_goaltime["intro_car12"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car12", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car12", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  level.scr_animtree["intro_car13"] = #animtree;
  level.scr_anim["intro_car13"]["intro_slamzoom"] = % lon_pic_010_car_secho_enter_04;
  level.scr_goaltime["intro_car13"]["intro_slamzoom"] = 0;
  scripts\common\anim::addnotetrack_customfunction("intro_car13", "car_braking", ::scriptable_braking, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car13", "car_reset", ::scriptable_brake_reset, "intro_slamzoom");
  scripts\common\anim::addnotetrack_customfunction("intro_car13", "sfx_taxi_passby", ::sfx_taxi_passby, "intro_slamzoom");
  level.scr_anim["decho"]["rf_exit"] = % vehicle_decho_car_getout_rf_side;
  level.scr_anim["decho"]["lf_exit"] = % vehicle_decho_car_getout_lf_side;
  level.scr_anim["calfa"]["rf_exit"] = % vehicle_calfa_car_getout_rf_side;
  level.scr_anim["calfa"]["lf_exit"] = % vehicle_calfa_car_getout_lf_side;
  level.scr_anim["ralfa"]["rf_exit"] = % vehicle_ralfa_car_getout_rf_side;
  level.scr_anim["ralfa"]["lf_exit"] = % vehicle_ralfa_car_getout_lf_side;
  level.scr_anim["skilo"]["rf_exit"] = % vehicle_skilo_car_getout_rf_side;
  level.scr_anim["skilo"]["lf_exit"] = % vehicle_skilo_car_getout_lf_side;
  level.scr_anim["victor40"]["rf_exit"] = % vehicle_victor40_car_getout_rf_side;
  level.scr_anim["victor40"]["lf_exit"] = % vehicle_victor40_car_getout_lf_side;
  level.scr_animtree["right_car1"] = #animtree;
  level.scr_anim["right_car1"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_secho;
  scripts\common\anim::addnotetrack_customfunction("right_car1", "light_front_left_dead", ::light_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "light_front_right_dead", ::light_front_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "light_back_left_dead", ::light_back_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "light_back_right_dead", ::light_back_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "windshield_front_dead", ::windshield_front_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "windshield_back_dead", ::windshield_back_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "window_front_left_dead", ::window_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "window_front_right_dead", ::window_front_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "window_back_right_dead", ::window_back_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "grill_dead", ::grill_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "mirror_left_dead", ::mirror_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "mirror_right_dead", ::mirror_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car1", "enable_damage", ::enable_damage, "right_car_crash1");
  level.scr_animtree["right_car2"] = #animtree;
  level.scr_anim["right_car2"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_walfa;
  scripts\common\anim::addnotetrack_customfunction("right_car2", "light_front_left_dead", ::light_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car2", "enable_damage", ::enable_damage, "right_car_crash1");
  level.scr_animtree["right_car3"] = #animtree;
  level.scr_anim["right_car3"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_victor;
  scripts\common\anim::addnotetrack_customfunction("right_car3", "light_front_left_dead", ::light_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car3", "light_front_right_dead", ::light_front_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car3", "windshield_front_dead", ::windshield_front_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car3", "door_front_right_dmg", ::door_front_right_dmg, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car3", "enable_damage", ::enable_damage, "right_car_crash1");
  level.scr_animtree["right_car4"] = #animtree;
  level.scr_anim["right_car4"]["right_car_crash1"] = % veh8_piccadilly_crash_gr1_skilo;
  scripts\common\anim::addnotetrack_customfunction("right_car4", "light_front_left_dead", ::light_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "light_front_right_dead", ::light_front_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "light_back_left_dead", ::light_back_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "light_back_right_dead", ::light_back_right_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "windshield_front_dead", ::windshield_front_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "windshield_back_dead", ::windshield_back_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "window_front_left_dead", ::window_front_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "window_back_left_dead", ::window_back_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "mirror_left_dead", ::mirror_left_dead, "right_car_crash1");
  scripts\common\anim::addnotetrack_customfunction("right_car4", "enable_damage", ::enable_damage, "right_car_crash1");
  level.scr_animtree["left_crash_car1"] = #animtree;
  level.scr_anim["left_crash_car1"]["left_car_crash"] = % veh8_piccadilly_accident_gr2_ralfa;
  scripts\common\anim::addnotetrack_customfunction("left_crash_car1", "light_front_right_dead", ::light_front_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car1", "custom_impact_nose", ::custom_impact_nose, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car1", "enable_damage", ::enable_damage, "left_car_crash");
  level.scr_animtree["left_crash_car2"] = #animtree;
  level.scr_anim["left_crash_car2"]["left_car_crash"] = % veh8_piccadilly_accident_gr2_victor;
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "light_front_left_dead", ::light_front_left_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "light_front_right_dead", ::light_front_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "light_back_left_dead", ::light_back_left_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "light_back_right_dead", ::light_back_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "windshield_front_dead", ::windshield_front_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "windshield_back_dead", ::windshield_back_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "door_back_left_dmg", ::door_back_left_dmg, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "mirror_left_dead", ::mirror_left_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "mirror_right_dead", ::mirror_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_front_left_dead", ::window_front_left_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_front_right_dead", ::window_front_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_back_left_dead", ::window_back_left_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_back_right_dead", ::window_back_right_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_fin", ::custom_eject_fin, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_siren", ::custom_eject_siren, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_rack_bar", ::custom_eject_rack_bar, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_spoiler", ::custom_eject_spoiler, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_back_left_corner_dead", ::window_back_left_corner_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "window_back_right_corner_dead", ::window_back_right_corner_dead, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_hood", ::custom_eject_hood, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_door_front_left", ::custom_eject_door_front_left, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_door_back_left", ::custom_eject_door_back_left, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "custom_eject_trunk", ::custom_eject_trunk, "left_car_crash");
  scripts\common\anim::addnotetrack_customfunction("left_crash_car2", "enable_damage", ::enable_damage, "left_car_crash");
  level.scr_animtree["left_crash_car3"] = #animtree;
  level.scr_anim["left_crash_car3"]["left_car_crash"] = % veh8_piccadilly_accident_gr2_calfa;
  scripts\common\anim::addnotetrack_customfunction("left_crash_car3", "enable_damage", ::enable_damage, "left_car_crash");
  level.scr_anim["car_jumper_car"]["car_jump_start"] = % pic_car_movement_a_enter;
  level.scr_anim["car_jumper_car"]["car_jump_exit_back"] = % pic_car_movement_a_react_behind;
  level.scr_anim["car_jumper_car"]["car_jump_exit_front"] = % pic_car_movement_a_react_front;
  level.scr_anim["car_jumper_car"]["car_jump_idle"][0] = % pic_car_movement_a_loop;
  level.scr_anim["car_jumper_car"]["car_jump_loop_shoot"][0] = % pic_car_movement_a_loop_shoot;
  level.scr_anim["car_jumper_car"]["car_jump_death"] = % pic_car_movement_a_death;
}

car2_bomb_explosion(var_0) {
  var_1 = scripts\engine\utility::getStruct("carbomb_det", "targetname");
  level notify("vo_expl_walla");
  thread scripts\engine\utility::play_sound_in_space("pdilly_first_explosion", var_1.origin);
  thread player_dist_check(var_1);
  scripts\engine\utility::exploder("taxiexplosion");
  scripts\engine\utility::stop_exploder("traffic_lights_intro");
  wait 0.1;
  var_0 setscriptablepartstate("Piccadilly_Death", "picc_death");
  wait 0.7;
  scripts\engine\utility::exploder("aftermath");
}

player_dist_check(var_0) {
  var_1 = distancesquared(level.player.origin, var_0.origin);

  if(var_1 <= 600)
    level.player kill();
}

scriptable_braking(var_0) {
  var_0 setscriptablepartstate("lights_controller", "taillights_braking");
}

scriptable_brake_reset(var_0) {
  var_0 setscriptablepartstate("lights_controller", "on_nolight");
}

window_front_left_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_front_left_dead", 1);
}

window_front_right_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_front_right_dead", 1);
}

window_back_left_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_back_left_dead", 1);
}

window_back_right_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_back_right_dead", 1);
}

windshield_front_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "windshield_front_dead", 1);
}

windshield_back_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "windshield_back_dead", 1);
}

light_front_left_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "light_front_left_dead", 1);
}

light_front_right_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "light_front_right_dead", 1);
}

light_back_left_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "light_back_left_dead", 1);
}

light_back_right_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "light_back_right_dead", 1);
}

grill_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "grill_dead", 1);
}

mirror_left_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "mirror_left_dead", 1);
}

mirror_right_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "mirror_right_dead", 1);
}

door_front_right_dmg(var_0) {
  earthquake(0.25, 0.5, level.player.origin, 800);
  playrumbleonposition("damage_heavy", level.player.origin);
  var_0 setscriptablepartstate("Notetrack Handler", "door_front_right_dmg", 1);
}

door_front_left_dmg(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "door_front_left_dmg", 1);
}

door_back_right_dmg(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "door_back_right_dmg", 1);
}

door_back_left_dmg(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "door_back_left_dmg", 1);
}

custom_eject_fin(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_fin", 1);
}

custom_eject_siren(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_siren", 1);
}

custom_eject_rack_bar(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_rack_bar", 1);
}

custom_eject_spoiler(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_spoiler", 1);
}

window_back_left_corner_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_back_left_corner_dead", 1);
}

window_back_right_corner_dead(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "window_back_right_corner_dead", 1);
}

custom_impact_nose(var_0) {
  earthquake(0.25, 0.5, level.player.origin, 800);
  playrumbleonposition("damage_heavy", level.player.origin);
  var_0 setscriptablepartstate("Notetrack Handler", "custom_impact_nose", 1);
}

custom_eject_hood(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_hood", 1);
}

custom_eject_door_front_left(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_door_front_left", 1);
}

custom_eject_door_back_left(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_door_back_left", 1);
}

custom_eject_trunk(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "custom_eject_trunk", 1);
}

enable_damage(var_0) {
  var_0 setscriptablepartstate("Notetrack Handler", "enable_damage", 1);
}

sfx_pre_explo_mix_change_1(var_0) {}

sfx_pre_explo_mix_change_2(var_0) {
  level.player setsoundsubmix("fade_all_except_explo");
}

sfx_van_passby(var_0) {
  var_0 playSound("scn_piccadilly_intro_car_by_van");
}

sfx_taxi_passby(var_0) {
  var_0 playSound("scn_piccadilly_intro_car_by_taxi");
}

sfx_sedan_passby(var_0) {
  var_0 playSound("scn_piccadilly_intro_car_by_gen_01");
}

sfx_car_door_open(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_enemy_car_door_open", (-2597, -3605, 40));
  level notify("vo_pre_expl_walla");
}

sfx_car_door_slam(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_enemy_car_door_slam", (-2597, -3605, 40));
}

sfx_van_door_open(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_van_door_open", (-2314, -3535, 59));
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_van_fs", (-2314, -3535, 59));
}

sfx_plr_van_getout(var_0) {
  level.player playSound("scn_piccadilly_intro_03_lr");
}

intro_remove_fov_user_scale(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

car_explosion_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

car_explosion_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 0.5);
}

audio_mix_bomb_explo(var_0) {
  level.player setclienttriggeraudiozone("piccadilly_end_fade_music", 6.0);
}

audio_mix_fade_out_end_of_level(var_0) {}