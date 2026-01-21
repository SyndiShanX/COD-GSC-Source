/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_code_slide.gsc
****************************************/

building_fall_slide_setup() {
  common_scripts\utility::flag_init("left_pressed");
  common_scripts\utility::flag_init("right_pressed");
}

#using_animtree("player");

building_fall_anim_rig() {
  level.base_falling_hands_anim = % cornered_building_fall_slide_player;
  level.base_falling_legs_anim = % cornered_building_fall_slide_player_viewleg;
  var_0 = level.fall_arms_and_legs[0];
  var_1 = level.fall_arms_and_legs[1];
  var_2 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_3 = maps\_utility::spawn_anim_model("player_bldg_fall");
  var_2 thread maps\_anim::anim_first_frame_solo(var_3, "cornered_building_fall_slide_player");
  var_3 hide();
  level.fall_path_rig = var_3;
  var_2 thread maps\_anim::anim_single_solo(var_3, "cornered_building_fall_slide_player");
  var_2 thread maps\_anim::anim_single_solo(var_0, "cornered_building_fall_slide_player");
  var_0 setanim(%cornered_building_fall_slide_player_l, 0.01, 0);
  var_0 setanim(%cornered_building_fall_slide_player_r, 0.01, 0);
  var_2 thread maps\_anim::anim_single_solo(var_1, "cornered_building_fall_slide_player");
  var_1 setanim(%cornered_building_fall_slide_player_viewleg_l, 0.01, 0);
  var_1 setanim(%cornered_building_fall_slide_player_viewleg_r, 0.01, 0);
  thread input_monitor();
  thread player_play_anims(var_0, var_1);
}

input_monitor() {
  level.player endon("death");
  level endon("fall_slide_ending");

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[1] >= 0.15) {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_set("right_pressed");
    } else if(var_0[1] <= -0.15) {
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_set("left_pressed");
    } else {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("right_pressed");
    }

    common_scripts\utility::waitframe();
  }
}

player_play_anims(var_0, var_1) {
  level.player endon("death");
  level endon("fall_slide_ending");
  var_2 = 1.45;
  var_3 = 1.45;

  for(;;) {
    if(common_scripts\utility::flag("left_pressed")) {
      var_0 setanim(%cornered_building_fall_slide_player_l, 1, var_2);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_l, 1, var_2);
      var_0 setanim(level.base_falling_hands_anim, 0.01, var_2);
      var_1 setanim(level.base_falling_legs_anim, 0.01, var_2);
      var_0 setanim(%cornered_building_fall_slide_player_r, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_r, 0.01, var_3);
      common_scripts\utility::flag_waitopen("left_pressed");
      var_0 setanim(level.base_falling_hands_anim, 1, var_3);
      var_1 setanim(level.base_falling_legs_anim, 1, var_3);
      var_0 setanim(%cornered_building_fall_slide_player_l, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_l, 0.01, var_3);
      var_0 setanim(%cornered_building_fall_slide_player_r, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_r, 0.01, var_3);
      continue;
    }

    if(common_scripts\utility::flag("right_pressed")) {
      var_0 setanim(%cornered_building_fall_slide_player_r, 1, var_2);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_r, 1, var_2);
      var_0 setanim(level.base_falling_hands_anim, 0.01, var_2);
      var_1 setanim(level.base_falling_legs_anim, 0.01, var_2);
      var_0 setanim(%cornered_building_fall_slide_player_l, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_l, 0.01, var_3);
      common_scripts\utility::flag_waitopen("right_pressed");
      var_0 setanim(level.base_falling_hands_anim, 1, var_3);
      var_1 setanim(level.base_falling_legs_anim, 1, var_3);
      var_0 setanim(%cornered_building_fall_slide_player_r, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_r, 0.01, var_3);
      var_0 setanim(%cornered_building_fall_slide_player_l, 0.01, var_3);
      var_1 setanim(%cornered_building_fall_slide_player_viewleg_l, 0.01, var_3);
      continue;
    }

    common_scripts\utility::flag_wait_any("left_pressed", "right_pressed");
  }
}