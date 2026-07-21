/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_vignette_alleys_anim.gsc
**********************************************************************/

main() {
  level_anims_player();
  humans();
  script_models();
  level_anims_vehicles();
}

#using_animtree("player");

level_anims_player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_hero_kyle_urban_fullbody";
  level.scr_anim["player_rig"]["stp_street_car_hit_pickup"] = % stp_street_car_hit_pickup_plr;
  level.scr_anim["player_rig"]["stp_street_car_hit_exit"] = % stp_street_car_hit_exit_plr;
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["apt_stairs_civ01"]["apt_stairs_scene"] = % stp_apt_stairs_throw_civ01;
  level.scr_anim["apt_stairs_civ01"]["apt_stairs_scene_idle"][0] = % stp_apt_stairs_throw_civ01_idle;
  scripts\common\anim::addnotetrack_customfunction("apt_stairs_civ01", "squib_hit", ::civ_stairs_death, "apt_stairs_scene");
  level.scr_anim["doorPeak"]["stp_vig_doorpeak"] = % stp_bar_010_civilian_stairwell_intro_civ01;
  level.scr_anim["doorPeak"]["stp_vig_doorpeak_alert"] = % stp_bar_010_civilian_stairwell_react_gun_civ01;
  level.scr_anim["doorPeak"]["stp_vig_doorpeak_casual"] = % stp_bar_010_civilian_stairwell_react_nogun_civ01;
  level.scr_anim["blockCiv01"]["apt_stairs_block_idle"][0] = % stp_apt_hall_blockers_stand_idle_civ01;
  level.scr_anim["blockCiv01"]["apt_stairs_block_react"] = % stp_apt_hall_blockers_stand_react_civ01;
  level.scr_anim["blockCiv01"]["apt_stairs_block_react_idle"][0] = % stp_apt_hall_blockers_stand_idle_civ01;
  level.scr_anim["blockCiv02"]["apt_stairs_block_idle"][0] = % stp_apt_hall_blockers_stand_idle_civ02;
  level.scr_anim["blockCiv02"]["apt_stairs_block_react"] = % stp_apt_hall_blockers_stand_react_civ02;
  level.scr_anim["blockCiv02"]["apt_stairs_block_react_idle"][0] = % stp_apt_hall_blockers_stand_idle_civ02;
  level.scr_anim["enforcer"]["stp_apt_grenade"] = % stp_apt_grenade_enf01;
  level.scr_anim["enforcer"]["stp_apt_grenade_loop"][0] = % stp_apt_grenade_enf01_loop_scene;
  level.scr_anim["enforcer"]["stp_apt_grenade_outro"] = % stp_apt_grenade_enf01_outro_scene;
  level.scr_goaltime["enforcer"]["stp_apt_grenade_outro"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("enforcer", "grenade_throw", ::enforcer_grenade_throw, "stp_apt_grenade_outro");
  scripts\common\anim::addnotetrack_customfunction("enforcer", "window_break", ::enforcer_window_break, "stp_apt_grenade_outro");
  level.scr_anim["enforcer"]["stp_street_car_hit"] = % stp_street_car_hit_enf;
  level.scr_goaltime["enforcer"]["stp_street_car_hit"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("enforcer", "van_hit", ::enforcer_van_hit, "stp_street_car_hit");
  scripts\common\anim::addnotetrack_customfunction("enforcer", "ground_impact", ::enforcer_ground_impact, "stp_street_car_hit");
  level.scr_anim["enforcer"]["stp_street_car_hit_idle"][0] = % stp_street_car_hit_idle_enf;
  level.scr_anim["enforcer"]["stp_street_car_hit_pickup"] = % stp_street_car_hit_pickup_enf;
  level.scr_goaltime["enforcer"]["stp_street_car_hit_pickup"] = 0.05;
  level.scr_anim["enforcer"]["stp_street_car_hit_idle02"][0] = % stp_street_car_hit_idle02_enf;
  level.scr_anim["enforcer"]["stp_street_car_hit_death_enf"] = % stp_street_car_hit_death_enf;
  level.scr_goaltime["enforcer"]["stp_street_car_hit_death_enf"] = 0.05;
  level.scr_anim["price"]["stp_street_car_hit"] = % stp_street_car_hit_price;
  level.scr_anim["price"]["stp_street_car_hit_pickup_idle"][0] = % stp_street_car_hit_pickup_idle_price;
  level.scr_anim["price"]["stp_street_car_hit_get_in"] = % stp_street_car_hit_get_in_price;
  level.scr_anim["price"]["stp_street_car_hit_pickup"] = % stp_street_car_hit_pickup_price;
  level.scr_anim["price"]["stp_street_car_hit_idle02"][0] = % stp_street_car_hit_idle02_price;
  level.scr_anim["nikolai"]["stp_street_car_hit"] = % stp_street_car_hit_nikolai;
  level.scr_goaltime["nikolai"]["stp_street_car_hit"] = 0.05;
  level.scr_anim["nikolai"]["stp_street_car_hit_idle"][0] = % stp_street_car_hit_idle_nikolai;
  level.scr_anim["nikolai"]["stp_street_car_hit_pickup"] = % stp_street_car_hit_pickup_nikolai;
  level.scr_goaltime["nikolai"]["stp_street_car_hit_pickup"] = 0.05;
  level.scr_anim["nikolai"]["stp_street_car_hit_get_in"] = % stp_street_car_hit_get_in_nikolai;
  level.scr_goaltime["nikolai"]["stp_street_car_hit_get_in"] = 0.05;
  level.scr_anim["nikolai"]["stp_street_car_hit_idle02"][0] = % stp_street_car_hit_idle02_nikolai;
  level.scr_anim["streetciv01"]["stp_bar_street_run"] = % stp_bar_street_run_civ01;
  scripts\common\anim::addnotetrack_customfunction("streetciv01", "shot_squib", ::bar_street_civ_shot_squib, "stp_bar_street_run");
  level.scr_anim["streetcouplemale"]["stp_bar_street_couple_run"] = % stp_bar_street_couple_run_civ01;
  level.scr_anim["streetcouplemale"]["stp_bar_street_couple_idle"][0] = % stp_bar_street_couple_idle_civ01;
  level.scr_anim["streetcouplefemale"]["stp_bar_street_couple_run"] = % stp_bar_street_couple_run_civ02;
  level.scr_anim["streetcouplefemale"]["stp_bar_street_couple_idle"][0] = % stp_bar_street_couple_idle_civ02;
  level.scr_anim["generic"]["lon_pic_010_civ01_idle"][0] = % lon_pic_010_civ01_idle;
  level.scr_anim["generic"]["lon_pic_010_civ01_standoff"] = % lon_pic_010_civ01_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ02_idle"][0] = % lon_pic_010_civ02_idle;
  level.scr_anim["generic"]["lon_pic_010_civ02_standoff"] = % lon_pic_010_civ02_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ04_idle"][0] = % lon_pic_010_civ04_idle;
  level.scr_anim["generic"]["lon_pic_010_civ04_standoff"] = % lon_pic_010_civ04_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ06_idle"][0] = % lon_pic_010_civ06_idle;
  level.scr_anim["generic"]["lon_pic_010_civ06_standoff"] = % lon_pic_010_civ06_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ08_idle"][0] = % lon_pic_010_civ08_idle;
  level.scr_anim["generic"]["lon_pic_010_civ08_standoff"] = % lon_pic_010_civ08_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ20_idle"][0] = % lon_pic_010_civ20_idle;
  level.scr_anim["generic"]["lon_pic_010_civ20_standoff"] = % lon_pic_010_civ20_standoff;
  level.scr_anim["generic"]["lon_pic_010_civ36_idle"][0] = % lon_pic_010_civ36_idle;
  level.scr_anim["generic"]["lon_pic_010_civ36_standoff"] = % lon_pic_010_civ36_standoff;
  level.scr_anim["generic"]["civ_casual_run_exit_2"] = % civ_casual_run_exit_2;
  level.scr_anim["generic"]["civ_casual_run_exit_3"] = % civ_casual_run_exit_3;
  level.scr_anim["generic"]["civ_stl_exposed_stand_fast_exit_2"] = % civ_stl_exposed_stand_fast_exit_2;
  level.scr_anim["generic"]["civ_stl_exposed_stand_fast_exit_3"] = % civ_stl_exposed_stand_fast_exit_3;
  level.scr_anim["generic"]["stp_can_020_street_civs_flee_civ01"] = % stp_can_020_street_civs_flee_civ01;
  level.scr_anim["generic"]["sh_022_marketplace_idle_civ02"][0] = % sh_022_marketplace_idle_civ02;
  level.scr_anim["generic"]["sh_022_marketplace_react_coward_civ02"] = % sh_022_marketplace_react_coward_civ02;
  level.scr_anim["generic"]["hf_grnd_red_civ_run_turn_r_6_trip"] = % hf_grnd_red_civ_run_turn_r_6_trip;
  level.scr_anim["trafficdriver"]["stp_street_traffic"][0] = % reb_vh_techo_driver_idle_search01;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "uk_house_door_interior_01_36w_r";
  level.scr_anim["door"]["stp_vig_doorpeak"] = % stp_bar_010_civilian_stairwell_open_door;
  level.scr_anim["door"]["stp_vig_doorpeak_alert"] = % stp_bar_010_civilian_stairwell_close_gun_door;
  level.scr_anim["door"]["stp_vig_doorpeak_casual"] = % stp_bar_010_civilian_stairwell_close_nogun_door;
  level.scr_animtree["box"] = #animtree;
  level.scr_model["box"] = "p7_box_cardboard_e_closed";
  level.scr_anim["box"]["stp_vig_doorpeak_alert"] = % stp_bar_010_civilian_stairwell_react_gun_box;
  level.scr_anim["box"]["stp_vig_doorpeak_casual"] = % stp_bar_010_civilian_stairwell_react_nogun_box;
}

#using_animtree("vehicles");

level_anims_vehicles() {
  level.scr_animtree["car"] = #animtree;
  level.scr_anim["car"]["stp_street_car_hit"] = % stp_street_car_hit_enter_van;
  level.scr_goaltime["car"]["stp_street_car_hit"] = 0.05;
  level.scr_anim["car"]["stp_street_car_hit_idle"][0] = % stp_street_car_hit_idle_van;
  level.scr_anim["car"]["stp_street_car_hit_pickup"] = % stp_street_car_hit_pickup_van;
  level.scr_goaltime["car"]["stp_street_car_hit_pickup"] = 0.05;
  level.scr_anim["car"]["stp_street_car_hit_get_in"] = % stp_street_car_hit_get_in_van;
  level.scr_anim["car"]["stp_street_car_hit_nik_get_in"] = % stp_street_car_hit_nik_get_in_van;
  level.scr_goaltime["car"]["stp_street_car_hit_nik_get_in"] = 0.05;
  level.scr_anim["car"]["stp_street_car_hit_price_get_in"] = % stp_street_car_hit_price_get_in_van;
  level.scr_anim["car"]["stp_street_car_hit_idle02"][0] = % stp_street_car_hit_idle02_van;
  level.scr_anim["car"]["stp_street_car_hit_exit"] = % stp_street_car_hit_door_close_van;
  level.scr_anim["car"]["stp_street_car_drive"] = % stp_street_car_hit_drive_exit_van;
  level.scr_anim["car"]["doors_open_back_right_van"] = % stp_gauntlet_doors_open_back_right_van;
  level.scr_anim["car"]["doors_open_rear_van"] = % stp_gauntlet_doors_open_rear_van;
  level.scr_anim["car"]["doors_close_back_right_van"] = % stp_gauntlet_doors_close_back_right_van;
  level.scr_anim["car"]["doors_close_rear_van"] = % stp_gauntlet_doors_close_rear_van;
}

enforcer_van_hit(var_0) {
  scripts\engine\utility::flag_set("flag_gauntlet_enforcer_van_hit");
  playrumbleonposition("grenade_rumble", level.enforcer.origin);
  earthquake(0.4, 0.5, level.enforcer.origin, 800);
  waitframe();
  var_1 = playFXOnTag(scripts\engine\utility::getfx("vfx_bd_blood_hit_01"), level.enforcer, "j_spine4");
  var_2 = playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), level.enforcer, "j_head");
  playFXOnTag(scripts\engine\utility::getfx("cold_breath_run"), level.enforcer, "j_head");
}

enforcer_ground_impact(var_0) {
  scripts\engine\utility::flag_set("flag_gauntlet_enforcer_ground_impact");
  waitframe();
  var_1 = playFXOnTag(scripts\engine\utility::getfx("vfx_bd_blood_hit_01"), level.enforcer, "j_head");
  playFXOnTag(scripts\engine\utility::getfx("cold_breath_run"), level.enforcer, "j_head");
}

civ_stairs_death(var_0) {
  var_0 thread civ_stairs_blood_splatter();
  playFXOnTag(scripts\engine\utility::getfx("vfx_bd_blood_hit_01"), var_0, "j_shoulder_ri");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), var_0, "j_shoulder_le");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_body_explode_gib2"), var_0, "j_spine4");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), var_0, "tag_eye");
  var_0 notify("end_blood_splatter");
}

civ_stairs_blood_splatter() {
  self endon("death");
  self endon("end_blood_splatter");

  for(;;) {
    if(scripts\engine\sp\utility::players_within_distance(250, self getEye())) {
      level.player thread scripts\sp\player::bloodoverlay(1.0, 3.0, 4.0);
      level.player thread scripts\sp\player::damagebloodoverlaydirectional(self getEye(), "MOD_RIFLE_BULLET", 8.0);
      break;
    }

    waitframe();
  }
}

enforcer_grenade_throw(var_0) {
  scripts\engine\utility::flag_set("flag_apartment_enforcer_grenade_throw");
}

enforcer_window_break(var_0) {
  scripts\engine\utility::flag_set("flag_apartment_enforcer_window_break");
}

bar_street_civ_shot_squib(var_0) {
  var_1 = scripts\engine\utility::getStruct("street_pursuit_magicbullet_start", "targetname");
  var_2 = getcompleteweaponname("iw8_ar_akilo47");
  magicbullet(var_2, var_1.origin, var_0 gettagorigin("j_spine4"));
  playFXOnTag(scripts\engine\utility::getfx("vfx_body_explode_gib2"), var_0, "j_spine4");
}