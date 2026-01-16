/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_2_dialog.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\panama_utility;
#include maps\_anim;
#include maps\_vehicle;
#include maps\panama_2_dialog;

play_woods_ambulence_dialog() {
  level.player say_dialog("wood_come_on_you_sick_fu_0");
}

dialog_intro_to_slums() {
}

slum_vo_ambulance() {
  flag_wait("ambulance_complete");
  wait 1;

  if(!flag("ambulance_staff_killed"))
    level.player say_dialog("wood_get_outta_here_go_0", 2);

  level.mason say_dialog("huds_mason_do_you_still_0");
  level.mason say_dialog("maso_affirmative_0");
  level.mason say_dialog("huds_proceed_to_the_army_0");
  level.mason say_dialog("huds_you_ll_be_directed_t_0");
}

dialog_building_collapse() {
  level endon("magic_alley_vo");
  trigger_wait("slums_heli_fly");
  level.player say_dialog("wood_us_forces_are_pushin_0");
  level.mason say_dialog("maso_we_push_north_watc_0", 2);
  level.player say_dialog("wood_we_got_infantry_all_0", 2);
  level.mason say_dialog("maso_pick_a_route_through_0", 1);
  level.mason say_dialog("maso_i_ll_handle_noriega_0");
}

dialog_balcony_enemies() {
  level endon("slums_e_02_helicopter");
  trigger_wait("sm_slums_axis_mgnest");
  level.mason say_dialog("maso_on_the_balcony_rig_0", 2);
  level.mason say_dialog("maso_they_got_a_heavy_gun_0", 2);
  waittill_spawn_manager_cleared("sm_slums_axis_mgnest");
  level.player say_dialog("wood_they_re_down_move_0");
}

dialog_rooftop() {
  level endon("slums_e_02_helicopter");
  trigger_wait("sm_rooftop_and_windows_alley");
  level.mason say_dialog("maso_eyes_high_woods_0", 3);
  level.mason say_dialog("maso_they_ve_got_the_high_0");
  level.player say_dialog("wood_stay_in_cover_0", 2);
}

dialog_van_jump() {
  level endon("kill_gazebo_vo");
  trigger_wait("slums_e_23_start");
  level.mason say_dialog("maso_guy_on_top_of_the_va_0", 3);
  level.player say_dialog("wood_i_see_him_0");
  ai = get_ais_from_scene("parking_jump", "slums_park_digbat_01");

  while(isalive(ai))
    wait 0.1;

  level.player say_dialog("wood_crazy_fuckin_bastar_0");
  level.mason say_dialog("maso_which_way_now_fuckf_0");
  level.noriega say_dialog("nori_we_need_to_go_throug_0", 1);
  level.noriega say_dialog("nori_the_park_is_on_the_r_0", 2);
  flag_wait("mv_noriega_to_before_gazebo");
  level.mason say_dialog("wood_friendlies_up_ahead_0");
}

park_movement_vo() {
  level endon("mv_noriega_right_of_church");
  trigger_wait("mason_noriega_gazebo_trigger", "targetname", level.noriega);
  level.mason say_dialog("maso_don_t_fucking_move_0", 2);
  wait 15;
  flag_set("mv_noriega_to_gazebo");
  level.mason say_dialog("maso_alright_let_s_go_0");
  level.player say_dialog("wood_we_got_heavy_fightin_0", 0.3);
  level.mason say_dialog("maso_shit_this_side_s_n_0", 4);
  level.player say_dialog("wood_push_through_don_t_0", 0.4);
  level.player say_dialog("wood_keep_your_head_down_0", 0.8);
  level.mason say_dialog("maso_which_way_which_way_0", 0.5);
  level.noriega say_dialog("nori_there_is_a_church_to_0", 0.4);
  level.mason say_dialog("maso_we_got_too_much_figh_0", 2);
  level.mason say_dialog("maso_right_side_in_the_0", 0.5);
}

magic_alley_movement() {
  trigger_wait("mason_noriega_magic_alley", "targetname", level.noriega);
  level notify("magic_alley_vo");
  wait 1;
  level.mason say_dialog("maso_you_don_t_move_witho_0", 0.5);
  level.player say_dialog("wood_dammit_mason_got_0", 1);
  level.player say_dialog("wood_i_swear_if_that_bas_0");
  level.mason say_dialog("maso_you_don_t_move_witho_0");
}

dialog_church() {
  trigger_wait("dialog_church");
  level.noriega say_dialog("nori_there_s_the_church_0");
  level.mason say_dialog("maso_push_through_the_chu_0");
  level.mason say_dialog("maso_our_boys_are_pushing_0");

  if(distance2d(level.player.origin, level.mason.origin) < 160000)
    level.player say_dialog("wood_stay_the_fuck_outta_0");

  trigger_wait("slums_e4_start");
  level.mason say_dialog("maso_come_on_go_0");

  if(distance2d(level.player.origin, level.mason.origin) < 160000)
    level.player say_dialog("wood_now_what_0", 3);

  level.noriega say_dialog("nori_there_through_the_0");
  level.mason say_dialog("wood_come_on_mason_i_v_0");
}

personal_pdf_battle_dialog() {
  vo_triggers = getentarray("dialog_triggers", "targetname");

  for(i = 0; i < vo_triggers.size; i++)
    vo_triggers[i] thread parse_vo_and_play_them();
}

parse_vo_and_play_them() {
  dialog_vos = strtok(self.script_noteworthy, ";");
  self waittill("trigger", guy);
  guy endon("death");

  for(i = 0; i < dialog_vos.size; i++)
    guy say_dialog(dialog_vos[i], randomfloatrange(0.5, 2));
}