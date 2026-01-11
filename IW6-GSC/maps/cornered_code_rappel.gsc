/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_code_rappel.gsc
*****************************************/

cornered_start_rappel(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  level.rpl = var_3;
  cnd_plyr_rpl_move_setup(var_3, var_0, var_1, var_2);
  cnd_plyr_rpl_setup_globals(var_3, var_2, var_0);
  cnd_plyr_rpl_legs_setup(var_3, var_2);
  cnd_plyr_rpl_setup_dvars(var_3, var_2);
  cnd_plyr_rpl_setup_player(var_3, var_2);
  thread cnd_plyr_rpl_move(var_3, var_0, var_1, var_2);
}

cornered_stop_rappel() {
  if(isDefined(level.rpl)) {
    common_scripts\utility::flag_set("stop_manage_player_rappel_movement");
  }
}

cnd_plyr_rpl_move(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  thread cnd_plyr_rpl_handle_jump(var_3, var_0);
  thread cnd_plyr_rpl_handle_view_lerp(var_3, var_0);

  while(!common_scripts\utility::flag("stop_manage_player_rappel_movement")) {
    cnd_rpl_calc_move(var_0, var_3);
    cnd_rpl_do_vertical_move(var_0, var_3);
    cnd_rpl_do_lateral_move(var_0, var_3);
    cnd_rpl_do_stop_sway(var_0, var_3);
    cnd_rpl_do_wind(var_0, var_3);
    cnd_rpl_do_rope(var_0, var_3);
    cnd_rpl_do_weapon_bob(var_0, var_3);
    cnd_rpl_do_move_bob(var_0, var_3);
    cnd_rpl_do_legs(var_0, var_3);
    wait(var_0.time_slice);
  }

  cnd_rpl_cleanup(var_3);
}

cornered_start_random_wind() {
  if(isDefined(level.rpl)) {
    level.rpl.wind_random = 1;
  }
}

cornered_stop_random_wind() {
  if(isDefined(level.rpl)) {
    level.rpl.wind_random = 0;
  }
}

cnd_rpl_stealth_ckpt(var_0) {
  if(var_0.rappel_type != "stealth") {
    return;
  }
  if(!isDefined(level.start_point) || level.start_point != "rappel_stealth") {
    return;
  }
  var_1[0] = level.cornered_player_arms;
  level.zipline_anim_struct thread maps\_anim::anim_single(var_1, "cornered_zipline_player");
  wait 0.1;
  level.zipline_anim_struct maps\_anim::anim_set_time(var_1, "cornered_zipline_player", 1.0);
  wait 0.1;
  level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
  wait 0.1;
}

#using_animtree("animated_props");

cnd_plyr_rpl_move_setup(var_0, var_1, var_2, var_3) {
  cnd_rpl_stealth_ckpt(var_3);
  var_4 = level.player common_scripts\utility::spawn_tag_origin();
  var_4.angles = level.player getplayerangles();
  var_5 = common_scripts\utility::getstruct(var_1, "targetname");
  var_0.rope_origin = var_5 common_scripts\utility::spawn_tag_origin();

  if(var_3.rappel_type == "stealth") {
    var_0.rope_origin.origin = var_0.rope_origin.origin + (-16, 0, 0);
  }

  level.rpl_rope_anim_origin = spawn("script_model", var_0.rope_origin.origin);
  level.rpl_rope_anim_origin.angles = var_0.rope_origin.angles + (0, -90, 0);
  level.rpl_rope_anim_origin setModel("generic_prop_raven");
  level.rpl_rope_anim_origin useanimtree(#animtree);
  level.rpl_rope_anim_origin linkto(var_0.rope_origin, "tag_origin");
  level.rpl_physical_rope_origin = var_5 common_scripts\utility::spawn_tag_origin();
  level.rpl_physical_rope_anim_origin = spawn("script_model", var_0.rope_origin.origin);
  level.rpl_physical_rope_anim_origin.angles = var_0.rope_origin.angles + (0, -90, 0);
  level.rpl_physical_rope_anim_origin setModel("generic_prop_raven");
  level.rpl_physical_rope_anim_origin useanimtree(#animtree);
  level.rpl_physical_rope_anim_origin linkto(level.rpl_physical_rope_origin, "tag_origin");
  var_6 = (0, 90, 0);

  if(var_3.lateral_plane == 2) {
    var_6 = (0, 325, 0);
  }

  level.rpl_jump_anim_origin = var_4 common_scripts\utility::spawn_tag_origin();
  level.rpl_jump_anim_origin.angles = var_6;
  level.rpl_jump_anim_origin setModel("generic_prop_raven");
  level.rpl_jump_anim_origin useanimtree(#animtree);
  level.rpl_jump_anim_origin linkto(level.rpl_rope_anim_origin, "J_prop_1");
  level.rpl_plyr_anim_origin = var_4 common_scripts\utility::spawn_tag_origin();
  level.rpl_plyr_anim_origin.angles = var_6;
  level.rpl_plyr_anim_origin setModel("generic_prop_raven");
  level.rpl_plyr_anim_origin useanimtree(#animtree);
  level.rpl_plyr_anim_origin linkto(level.rpl_jump_anim_origin, "J_prop_1");
  level.plyr_rpl_groundref = getent(var_2, "targetname");
  level.plyr_rpl_groundref.origin = var_4.origin;

  if(var_3.rappel_type == "inverted") {
    level.plyr_rpl_groundref.angles = (90, 270, 0);
  }

  level.plyr_rpl_groundref setModel("tag_origin");
  level.player playersetgroundreferenceent(level.plyr_rpl_groundref);
  level.plyr_rpl_groundref linkto(level.rpl_plyr_anim_origin, "J_prop_1");
  level.player.dof_ref_ent = level.plyr_rpl_groundref;
  var_7 = level.plyr_rpl_groundref;

  if(rappel_use_plyr_legs(var_3)) {
    var_8 = anglesToForward(var_6);
    var_9 = var_8[0] * 30;
    var_10 = var_8[1] * 30;
    var_11 = 8;

    if(var_3.rappel_type == "combat") {
      var_9 = var_8[0] * 10;
      var_10 = var_8[1] * 10;
      var_11 = 12;
    }

    level.player_torso_offset_origin = level.plyr_rpl_groundref common_scripts\utility::spawn_tag_origin();
    level.player_torso_offset_origin.origin = level.player_torso_offset_origin.origin + (var_9, var_10, var_11);
    level.player_torso_offset_origin linkto(level.plyr_rpl_groundref);
    var_7 = level.player_torso_offset_origin;
  }

  wait 0.1;

  if(var_3.rappel_type == "inverted") {
    level.player playerlinkto(var_7, "tag_origin", 1, var_3.right_arc, var_3.left_arc, var_3.top_arc, var_3.bottom_arc, 0);
  } else {
    level.player playerlinktodelta(var_7, "tag_origin", 1, var_3.right_arc, var_3.left_arc, var_3.top_arc, var_3.bottom_arc, 1);
  }

  level.player playerlinkeduselinkedvelocity(1);
  cnd_rpl_rope_setup(var_0, var_3);

  if(rappel_use_plyr_legs(var_3)) {
    level.rappel_player_legs = maps\_utility::spawn_anim_model("player_rappel_legs");
    level.rappel_player_legs.origin = level.rpl_plyr_anim_origin.origin;
    level.rappel_player_legs.angles = level.rpl_plyr_anim_origin.angles;
    level.rpl_plyr_legs_link_ent = level.rpl_plyr_anim_origin;

    if(var_3.rappel_type == "stealth") {
      var_8 = anglesToForward(var_6);
      var_9 = var_8[0] * 20;
      var_10 = var_8[1] * 20;
      var_11 = -5;
      level.rpl_plyr_legs_link_ent = level.rpl_plyr_anim_origin common_scripts\utility::spawn_tag_origin();
      level.rpl_plyr_legs_link_ent.origin = level.rpl_plyr_legs_link_ent.origin + (var_9, var_10, var_11);
      level.rpl_plyr_legs_link_ent linkto(level.rpl_plyr_anim_origin);
    }

    level.rappel_player_legs dontcastshadows();
    level.rappel_player_legs linkto(level.rpl_plyr_legs_link_ent);
  }

  var_4 delete();
  maps\cornered_code::delete_if_defined(level.player_force_origin_ent);
}

cnd_rpl_rope_setup(var_0, var_1) {
  if(var_1.rappel_type == "inverted") {
    return;
  }
  if(var_1.rappel_type == "stealth") {
    var_0.player_rope_unwind_anim = % cnd_rappel_stealth_top_rope_unwind;
    var_0.player_rope_unwind_length = 990.8;
  } else if(var_1.rappel_type == "combat") {
    var_0.player_rope_unwind_anim = % cnd_rappel_combat_top_rope_unwind;
    var_0.player_rope_unwind_length = 1600.33;
  }

  level.cnd_rappel_tele_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
  level.cnd_rappel_tele_rope.origin = level.rpl_physical_rope_anim_origin.origin;
  level.cnd_rappel_tele_rope.angles = (0, 0, 0);
  level.cnd_rappel_tele_rope linkto(level.rpl_physical_rope_anim_origin, "J_prop_1");

  if(!isDefined(level.cnd_rappel_player_rope)) {
    level.cnd_rappel_player_rope = maps\_utility::spawn_anim_model("cnd_rappel_player_rope");
    level.cnd_rappel_player_rope.origin = level.cnd_rappel_tele_rope gettagorigin("J_Tele_50");
    level.cnd_rappel_player_rope.angles = level.cnd_rappel_tele_rope gettagangles("J_Tele_50");
  }

  var_2 = (0, 0, 0);

  if(var_1.rappel_type == "stealth") {
    level.cnd_rappel_player_rope linkto(level.cnd_rappel_tele_rope, "J_Tele_50", (0, 0, 0), var_2);
  } else {
    thread cnd_delay_rope_link();
  }

  level.cnd_rappel_tele_rope setanim(var_0.player_rope_unwind_anim, 1, 0, 0);
  cnd_plyr_rope_set_idle();
  var_3 = 1.0 / var_0.player_rope_unwind_length;
  var_4 = 33 * var_3;
  level.cnd_rappel_tele_rope setanimtime(var_0.player_rope_unwind_anim, var_4);
  level.cnd_rappel_player_rope dontcastshadows();
  level.cnd_rappel_tele_rope dontcastshadows();

  if(var_1.rappel_type == "combat") {
    level.rpl_physical_rope_origin.angles = level.rpl_physical_rope_origin.angles + (-1.2, 0, 0);
  } else {}
}

cnd_delay_rope_link() {
  common_scripts\utility::waitframe();
  level.cnd_rappel_player_rope linkto(level.cnd_rappel_tele_rope, "J_Tele_50");
}

cnd_plyr_rope_set_idle() {
  level.cnd_rappel_player_rope setanim( % cnd_rappel_idle_rope_player, 1, 0, 1);
}

cnd_plyr_rpl_legs_setup(var_0, var_1) {
  if(!rappel_use_plyr_legs(var_1)) {
    return;
  }
  var_0.legs_idle_anim = rpl_get_legs_idle_anim();
  var_0.legs_move_parent_node = rpl_legs_get_parent_node_move();
  var_0.move = [];
  var_0.move["down"] = spawnStruct();
  var_0.move["up"] = spawnStruct();
  var_0.move["right"] = spawnStruct();
  var_0.move["left"] = spawnStruct();
  var_0.move["right_down"] = spawnStruct();
  var_0.move["right_up"] = spawnStruct();
  var_0.move["left_down"] = spawnStruct();
  var_0.move["left_up"] = spawnStruct();
  var_0.move["down"].vector = (0, 1, 0);
  var_0.move["up"].vector = (0, -1, 0);
  var_0.move["right"].vector = (1, 0, 0);
  var_0.move["left"].vector = (-1, 0, 0);
  var_0.move["right_down"].vector = vectornormalize((1, 1, 0));
  var_0.move["right_up"].vector = vectornormalize((1, -1, 0));
  var_0.move["left_down"].vector = vectornormalize((-1, 1, 0));
  var_0.move["left_up"].vector = vectornormalize((-1, -1, 0));
  var_0.move["down"].playing = 0;
  var_0.move["up"].playing = 0;
  var_0.move["right"].playing = 0;
  var_0.move["left"].playing = 0;
  var_0.move["right_down"].playing = 0;
  var_0.move["right_up"].playing = 0;
  var_0.move["left_down"].playing = 0;
  var_0.move["left_up"].playing = 0;
  var_0.cosine90 = cos(90);
  var_0.cosine45 = cos(45);
  var_0.cosine22_5 = cos(22.5);
  var_0.cosine15 = cos(15);
  var_0.cosine11_25 = cos(11.25);
  var_0.move_state_idle = 0;
  var_0.move_state_start = 1;
  var_0.move_state_loop = 2;
  var_0.move_state_loop_run = 3;
  var_0.move_state_stop = 4;
  var_0.move_state_idle_shift = 5;
  var_0.move_state_shift_back = 6;
  var_0.move_state_jump = 7;
  var_0.animtype_parent = 0;
  var_0.animtype_idle = 1;
  var_0.animtype_start = 2;
  var_0.animtype_loop = 3;
  var_0.animtype_loop_run = 4;
  var_0.animtype_stop = 5;
  var_0.animtype_run_stop = 6;
  var_0.animtype_idle_shift = 7;
  var_0.animtype_shift_back = 8;
  var_0.move_state = var_0.move_state_idle;
  var_0.last_move_state = var_0.move_state_idle;
  var_0.state_anim_percent_complete = 0.9;
  var_0.leg_anim_blend_time = 0.2;
  var_0.leg_anim_blend_time_fast = 0.05;
  var_0.leg_clear_anim_blend_time = 0.2;
  var_0.leg_clear_anim_blend_time_fast = 0.05;
  var_0.leg_idle_anim_blend_time = 0.4;
  var_0.leg_idle_trans_anim_blend_time = 0.2;
  var_0.leg_jump_anim_blend_time = 0.5;
  setdvarifuninitialized("rappel_legs_scale_horizontal", 1.5);
  setdvarifuninitialized("rappel_legs_scale_run", 1.0);
  setdvarifuninitialized("rappel_legs_scale_up", 1.2);
  setdvarifuninitialized("rappel_legs_scale_down", 1.2);
  var_0.legs_flag_name = "rappel_legs";
  var_2 = "left_down";
  var_3 = "right_down";
  thread cnd_rpl_legs_notetracks(var_0, var_2, var_3);
}

cnd_plyr_rpl_setup_globals(var_0, var_1, var_2) {
  var_0.move_vel = 0;
  var_0.time_slice = 0.05;
  var_0.rope_start_rot = var_0.rope_origin.angles[2];
  var_0.vertical_change_this_update = 0;
  var_0.farthest_distance_down = distance(level.rpl_plyr_anim_origin.origin, var_0.rope_origin.origin);
  var_0.clearing_bob_anim = 0;
  var_0.current_foot = "left";
  var_0.jumpcomplete = 1;
  var_0.glass_broken_under_player = 0;
  var_0.current_dist_to_top = 0;
  var_0.at_edge = 0;
  var_0.maxropejumpangle = 5.8362;
  var_0.tangentjump = tan(var_0.maxropejumpangle);
  var_0.walk_up_amount = 35;
  var_0.wind_random = 0;
  var_0.wind_random_delay_min = 4000;
  var_0.wind_random_delay_max = 10000;
  var_0.wind_random_next_time = 0;
  var_0.wind_strength = 0;
  var_0.wind_state = "calm";
  var_0.wind_last_state = "calm";
  var_0.wind_pushing_player = 0;
  var_0.player_anim_origin = cnd_get_plyr_anim_origin();
  var_0.player_anim_origin setanim( % rappel_player_look_center, 1.0, 0, 1);
  var_0.player_anim_origin thread watch_footstep_notetrack();

  if(var_2 == "rope_ref_stealth") {
    var_3 = getent("player_rappel_ground_ref_stealth", "targetname");
  } else if(var_2 == "rope_ref_combat") {
    var_3 = getent("player_rappel_ground_ref_combat", "targetname");
  } else {
    var_3 = getent("player_rappel_ground_ref_stealth", "targetname");
  }

  var_0.forward_direction_worldspace = vectornormalize(anglesToForward(var_3.angles * (0, 1, 0)));
  var_0.right_direction_worldspace = vectornormalize(anglestoright(var_3.angles * (0, 1, 0)));
  var_0.up_direction_worldspace = vectornormalize(anglestoup(var_3.angles * (0, 1, 0)));
}

cnd_plyr_rpl_setup_dvars(var_0, var_1) {
  setdvarifuninitialized("rappel_use_stop_momentum", "0");
  setdvarifuninitialized("rappel_stop_momentum_initial", "0.6");
  setdvarifuninitialized("rappel_stop_momentum_time", "0.7");
  setdvarifuninitialized("rappel_use_relative_controls", "1");
  setsaveddvar("player_moveThreshhold", 1.0);
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.072 0.033");
  setsaveddvar("player_lateralPlane", var_1.lateral_plane);
  setsaveddvar("bullet_penetrationHitsClients", 1);
  setsaveddvar("bullet_penetrationActorHitsActors", 1);
  var_0.bg_weaponbobamplitudebase = getdvarfloat("bg_weaponBobAmplitudeBase");
  var_0.g_speed = getdvarfloat("g_speed");
  var_0.bg_viewbobmax = getdvarfloat("bg_viewBobMax");
}

cnd_plyr_rpl_death(var_0, var_1) {
  level endon("stop_manage_player_rappel_movement");
  level.player waittill("death");

  if(rappel_use_plyr_legs(var_1)) {
    level.rappel_player_legs hide();
  }
}

cnd_plyr_rpl_setup_player(var_0, var_1) {
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(isDefined(var_1.allow_sprint) && var_1.allow_sprint) {
    level.player allowsprint(1);
  } else {
    level.player allowsprint(0);
  }

  level.player allowmelee(0);
  level.player enablemousesteer(1);
  thread cnd_plyr_rpl_death(var_0, var_1);
}

cnd_rpl_calc_move(var_0, var_1) {
  var_2 = 0.78;
  var_3 = 0.65;
  var_0.jumping = common_scripts\utility::flag("player_jumping");
  var_4 = level.player getnormalizedmovement();
  var_0.player_stick_magnitude = max(abs(var_4[0]), abs(var_4[1]));
  var_5 = level.player getplayerangles();
  var_0.player_angles_worldspace = combineangles(level.plyr_rpl_groundref.angles, var_5);
  var_6 = getdvarint("rappel_use_relative_controls", 0);

  if(!var_6) {
    if(isDefined(var_0.last_player_angles_worldspace) && var_0.player_stick_magnitude > 0) {
      var_0.player_angles_worldspace = var_0.last_player_angles_worldspace;
    }
  }

  var_7 = anglesToForward(var_0.player_angles_worldspace);
  var_8 = anglestoright(var_0.player_angles_worldspace);
  var_9 = anglestoup(var_0.player_angles_worldspace);
  level.player.linked_world_space_forward = var_7;
  var_0.dist_player_to_top = rpl_calc_dist_player_to_top(var_0, 1);
  var_0.player_at_lower_limit = isDefined(level.rappel_lower_limit) && var_0.dist_player_to_top > level.rappel_lower_limit;
  var_0.player_at_upper_limit = isDefined(level.rappel_upper_limit) && var_0.dist_player_to_top < level.rappel_upper_limit;
  var_10 = distance(level.rpl_plyr_anim_origin.origin, var_0.rope_origin.origin);
  var_11 = var_0.farthest_distance_down - var_0.walk_up_amount;
  var_0.vert_dist_to_vert_cap = var_10 - var_11;
  var_0.player_at_vertical_upper_cap = abs(var_0.vert_dist_to_vert_cap) < 2;
  var_12 = var_0.player_at_lower_limit || var_0.player_at_upper_limit || var_0.player_at_vertical_upper_cap;
  var_13 = var_7 * var_4[0];
  var_14 = var_8 * var_4[1];
  var_15 = vectornormalize(var_13 + var_14);
  var_16 = vectordot(var_15, var_0.right_direction_worldspace);
  var_17 = common_scripts\utility::sign(var_16);
  var_0.right_move_strength = var_0.player_stick_magnitude * var_17 * sqrt(abs(var_16));
  var_18 = abs(vectordot(var_7, var_0.forward_direction_worldspace));
  var_19 = var_9 * var_4[0] * var_18;
  var_20 = var_7 * var_4[0] * (1 - var_18);
  var_21 = vectornormalize(var_19 + var_20 + var_14);
  var_22 = vectordot(var_21, -1 * var_0.up_direction_worldspace);
  var_22 = var_22 * (2 - var_18);
  var_22 = clamp(var_22, -1.0, 1.0);
  var_0.down_move_strength = clamp(var_22, -1.0, 1.0) * var_0.player_stick_magnitude;
  var_23 = abs(var_4[0]) > 0.9 && abs(var_16) > 0.7;

  if(!var_12 && abs(var_0.down_move_strength) > 0 && !var_23) {
    var_24 = var_3 + var_18 * (var_2 - var_3);
    var_25 = abs(var_22) > var_24;

    if(var_1.rappel_type == "inverted") {
      var_25 = var_25 &abs(var_0.right_move_strength) < 0.4;
    }

    if(var_25) {
      var_0.right_move_strength = 0;
    } else if(abs(var_22) > var_24 - 0.1) {
      var_0.right_move_strength = var_0.right_move_strength * 0.5;
    } else if(abs(var_22) > var_24 - 0.2) {
      var_0.right_move_strength = var_0.right_move_strength * 0.75;
    }
  }

  cnd_rpl_plyr_too_close_to_allies(var_0);
}

cnd_rpl_plyr_too_close_to_allies(var_0) {
  var_1 = 0;
  var_2 = 3600;
  var_3 = 16900;
  var_4 = 25600;
  var_5 = 6400;
  var_6 = 10000;
  var_7 = var_2;
  var_8 = var_0.lateral_change_this_update;

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  foreach(var_10 in level.allies) {
    if(var_10.animname == "rorke") {
      var_10.player_moving_toward_me = var_0.right_move_strength != 0 && common_scripts\utility::sign(var_0.right_move_strength) > 0 || var_8 != 0 && common_scripts\utility::sign(var_8) > 0;
    } else {
      var_10.player_moving_toward_me = var_0.right_move_strength != 0 && common_scripts\utility::sign(var_0.right_move_strength) < 0 || var_8 != 0 && common_scripts\utility::sign(var_8) < 0;
    }

    if(!isDefined(var_10.move_type)) {
      continue;
    }
    var_11 = var_10 maps\cornered_code_rappel_allies::ally_rappel_distance2dsquared_to_player();

    if(isDefined(var_0.jumping) && var_0.jumping) {
      var_7 = var_6;
    } else if(var_10.move_type == "idle" || issubstr(var_10.move_type, "move_away")) {
      var_7 = var_2;
    } else if(issubstr(var_10.move_type, "move_back")) {
      var_7 = var_3;
    } else if(var_10.move_type == "turn_away") {
      var_7 = var_4;
    } else {
      var_7 = var_5;
    }

    if(var_10.player_moving_toward_me && var_11 <= var_7) {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    var_0.right_move_strength = 0;
    var_0.down_move_strength = 0;
    var_0.player_stick_magnitude = 0;
    var_0.too_close_to_ally = 1;
  } else
    var_0.too_close_to_ally = 0;
}

cnd_rpl_do_vertical_move(var_0, var_1) {
  if(!common_scripts\utility::flag("player_allow_rappel_down")) {
    common_scripts\utility::flag_clear("player_moving_down");
  } else {
    var_2 = var_0.vertical_change_this_update;
    var_0.vertical_change_this_update = 0;
    var_0.glass_broken_under_player = 0;
    var_3 = anglestoup(level.rpl_rope_anim_origin gettagangles("J_prop_1"));

    if(var_0.jumping && isDefined(level.rappel_jump_land_struct) && isDefined(level.player.forcing_rappel_jump_to_struct)) {
      var_4 = cnd_get_rope_anim_origin();
      var_5 = 0.7;
      var_6 = getanimlength(level.rappel_jump_anim) * var_5;
      var_7 = var_4 getanimtime(level.rappel_jump_anim);
      var_8 = (1 - var_7) * var_6;
      var_9 = int(var_8 / var_0.time_slice);
      var_10 = level.rappel_jump_land_struct.origin[2] - level.player.origin[2];

      if(var_9) {
        var_0.vertical_change_this_update = var_10 / var_9;
      }
    } else if(var_0.down_move_strength > 0 || var_0.down_move_strength < 0 && !var_0.jumping) {
      if(var_0.down_move_strength > 0) {
        var_0.vertical_change_this_update = -1 * var_0.down_move_strength * rpl_get_max_downward_speed();

        if(var_0.jumping) {
          var_0.vertical_change_this_update = var_0.vertical_change_this_update * 1.5;
        }

        if(var_0.glass_broken_under_player) {
          var_0.vertical_change_this_update = var_0.vertical_change_this_update * 4.2;
        }
      } else if(isDefined(var_1.allow_walk_up) && var_1.allow_walk_up) {
        var_0.vertical_change_this_update = -1 * var_0.down_move_strength * rpl_get_max_upward_speed();

        if(var_0.player_at_vertical_upper_cap) {
          var_11 = 1.0;
          var_0.vertical_change_this_update = 0.0;
        } else {
          var_0.vertical_change_this_update = min(var_0.vertical_change_this_update, var_0.vert_dist_to_vert_cap);
          var_11 = 1 - min(var_0.vert_dist_to_vert_cap / var_0.walk_up_amount, 1.0);
          var_0.vertical_change_this_update = var_0.vertical_change_this_update * (1 - var_11 * var_11);
        }
      }
    }

    if(var_0.jumping && !isDefined(level.player.forcing_rappel_jump_to_struct) && var_2 < 0) {
      var_0.vertical_change_this_update = min(var_0.vertical_change_this_update, var_2 * 0.9);
    }

    if(isDefined(level.rappel_lower_limit) && var_0.vertical_change_this_update < 0) {
      if(var_0.player_at_lower_limit) {
        var_0.vertical_change_this_update = 0;
      } else {
        var_0.vertical_change_this_update = max(var_0.vertical_change_this_update, var_0.dist_player_to_top - level.rappel_lower_limit);
      }
    } else if(isDefined(level.rappel_upper_limit) && var_0.vertical_change_this_update > 0) {
      if(var_0.player_at_upper_limit) {
        var_0.vertical_change_this_update = 0;
      } else {
        var_0.vertical_change_this_update = min(var_0.vertical_change_this_update, var_0.dist_player_to_top - level.rappel_upper_limit);
      }
    }

    if(abs(var_0.vertical_change_this_update) < 0.05) {
      var_0.vertical_change_this_update = 0;
    }

    if(abs(var_0.vertical_change_this_update) > 0) {
      level.rpl_plyr_anim_origin unlink();
      level.rpl_plyr_anim_origin.origin = level.rpl_plyr_anim_origin.origin + var_3 * var_0.vertical_change_this_update;
      level.rpl_plyr_anim_origin linkto(level.rpl_jump_anim_origin, "J_prop_1");
    }

    if(var_0.vertical_change_this_update < 0 || var_0.jumping) {
      common_scripts\utility::flag_set("player_moving_down");
      return;
    }

    common_scripts\utility::flag_clear("player_moving_down");
  }
}

cnd_rpl_do_lateral_move(var_0, var_1) {
  var_2 = 0.7;
  var_3 = 0.85;
  var_4 = 5;

  if(var_1.rappel_type == "combat") {
    var_4 = 2;
  }

  var_5 = var_0.rope_origin.angles[2] - var_0.rope_start_rot;

  if(var_0.jumping && isDefined(level.rappel_jump_land_struct) && isDefined(level.player.forcing_rappel_jump_to_struct)) {
    var_6 = cnd_get_rope_anim_origin();
    var_7 = 0.7;
    var_8 = getanimlength(level.rappel_jump_anim) * var_7;
    var_9 = var_6 getanimtime(level.rappel_jump_anim);
    var_10 = (1 - var_9) * var_8;
    level.anim_length_frames_left = int(var_10 / var_0.time_slice);
    var_11 = var_0.rope_origin.angles[2];
    var_12 = maps\cornered_code::rappel_get_plane_normal_left(var_1.rappel_type);
    var_13 = maps\cornered_code::rappel_get_plane_d(var_12, var_0.rope_origin.origin);
    var_14 = distance(level.rappel_jump_land_struct.origin, var_0.rope_origin.origin);
    var_15 = vectordot(var_12, level.rappel_jump_land_struct.origin) + var_13;
    level.new_rope_roll = -1 * asin(var_15 / var_14);
    level.roll_diff = level.new_rope_roll - var_11;

    if(level.anim_length_frames_left > 0) {
      var_0.lateral_change_this_update = level.roll_diff / level.anim_length_frames_left;
    }
  } else {
    if(var_0.jumping) {
      var_16 = 0;
      var_17 = 1.0;
    } else {
      var_16 = clamp(var_0.right_move_strength, -1.0, 1.0);
      var_17 = maps\_utility::linear_interpolate(sqrt(abs(var_16)), var_2, var_3);
    }

    var_18 = 1.95;
    var_19 = 1.95;
    var_20 = rpl_calc_max_yaw_right(var_0);
    var_21 = rpl_calc_max_yaw_left(var_0);
    var_0.max_rotation_speed = rpl_calc_max_rot_speed(var_0, var_1);

    if(var_1.rappel_type == "combat") {
      var_18 = 4;
      var_19 = 4;
    }

    var_0.on_right_side = var_5 >= 0;

    if(level.player issprinting()) {
      var_18 = var_18 * 1.5;
    }

    var_22 = abs(var_5) - var_4;

    if(var_22 >= 0) {
      var_23 = -1 * common_scripts\utility::sign(var_5);

      if(var_0.on_right_side) {
        var_0.player_percent_toward_max_yaw = var_22 / (var_20 - var_4);
      } else {
        var_0.player_percent_toward_max_yaw = var_22 / (abs(var_21) - var_4);
      }

      var_24 = var_23 * var_0.player_percent_toward_max_yaw;

      if(!var_0.jumping) {
        var_24 = var_24 * abs(var_16);
      }
    } else
      var_24 = 0;

    var_25 = var_24 * var_19;
    var_26 = var_16 * var_18;
    var_0.move_vel = (var_0.move_vel + var_26 + var_25) * var_17;
    var_0.move_vel = clamp(var_0.move_vel, -1 * var_0.max_rotation_speed, var_0.max_rotation_speed);
    var_27 = var_5 > var_0.rope_start_rot + var_20;
    var_28 = var_5 < var_0.rope_start_rot + var_21;
    var_29 = var_28 && var_0.player_stick_magnitude > 0 && var_0.right_move_strength <= 0;
    var_30 = var_27 && var_0.player_stick_magnitude > 0 && var_0.right_move_strength >= 0;

    if(var_29) {
      var_31 = var_0.rope_start_rot + var_21;
    } else if(var_30) {
      var_31 = var_0.rope_start_rot + var_20;
    } else {
      var_31 = var_5 + var_0.move_vel * var_0.time_slice;
      var_31 = min(var_31, var_0.rope_start_rot + var_20);
      var_31 = max(var_31, var_0.rope_start_rot + var_21);
    }

    var_0.lateral_change_this_update = var_31 - var_5;
    var_0.lateral_dist_change = sin(abs(var_0.lateral_change_this_update)) * var_0.dist_player_to_top;

    if(!var_29 && !var_30) {
      var_32 = abs(var_0.rope_start_rot + var_20 - var_5);
      var_33 = abs(var_0.rope_start_rot + var_21 - var_5);

      if(var_0.right_move_strength == 0 && var_32 <= var_33) {
        var_34 = var_32;
      } else if(var_0.right_move_strength == 0) {
        var_34 = var_33;
      } else if(common_scripts\utility::sign(var_0.right_move_strength) == 1) {
        var_34 = var_32;
      } else {
        var_34 = var_33;
      }

      var_0.approx_dist_from_edge = sin(abs(var_34)) * var_0.dist_player_to_top;
      var_35 = abs(var_0.lateral_dist_change - var_0.approx_dist_from_edge);

      if(var_0.at_edge) {
        var_0.at_edge = common_scripts\utility::sign(var_0.lateral_change_this_update) == var_0.at_edge_sign;
      }

      var_36 = var_0.at_edge || var_35 < 5;

      if(var_36) {
        if(common_scripts\utility::sign(var_0.lateral_change_this_update) == common_scripts\utility::sign(var_0.right_move_strength) || var_0.right_move_strength == 0) {
          var_0.lateral_change_this_update = 0;
          var_0.move_vel = 0;
          var_0.at_edge = 1;

          if(var_0.lateral_change_this_update == 0) {
            var_0.at_edge_sign = 0;
          } else {
            var_0.at_edge_sign = common_scripts\utility::sign(var_0.lateral_change_this_update);
          }
        }
      }

      var_37 = 0.2;

      if(var_1.rappel_type == "inverted") {
        var_37 = 0.5;
      }

      if(var_0.lateral_dist_change < var_37) {
        var_0.lateral_change_this_update = 0;
        var_0.move_vel = 0;
      }
    } else {
      var_38 = 2;

      if(var_0.dist_player_to_top == 0) {
        var_39 = var_38;
      } else {
        var_39 = asin(var_38 / var_0.dist_player_to_top);
      }

      var_0.lateral_change_this_update = clamp(var_0.lateral_change_this_update, -1 * var_39, var_39);
    }

    if(isDefined(var_0.stop_momentum) && abs(var_0.stop_momentum) > 0.01) {
      var_0.lateral_change_this_update = var_0.stop_momentum;
      var_0.stop_momentum = var_0.stop_momentum - var_0.stop_momentum_change;
    }

    var_40 = getdvarint("rappel_use_relative_controls", 0);
    var_41 = abs(var_0.lateral_change_this_update) > 0.01 || abs(var_0.vertical_change_this_update) > 0;

    if(!var_40 && var_41) {
      var_0.last_player_angles_worldspace = var_0.player_angles_worldspace;
    } else {
      var_0.last_player_angles_worldspace = undefined;
    }
  }

  cnd_rpl_handle_jumping_toward_allies(var_0);

  if(abs(var_0.lateral_change_this_update) > 0) {
    var_0.rope_origin rotateroll(var_0.lateral_change_this_update, var_0.time_slice, 0, 0);
  }
}

cnd_rpl_handle_jumping_toward_allies(var_0) {
  if(!var_0.jumping) {
    return;
  }
  foreach(var_2 in level.allies) {
    if(var_2.animname == "rorke") {
      var_2.player_moving_toward_me = var_0.lateral_change_this_update != 0 && common_scripts\utility::sign(var_0.lateral_change_this_update) > 0;
      continue;
    }

    var_2.player_moving_toward_me = var_0.lateral_change_this_update != 0 && common_scripts\utility::sign(var_0.lateral_change_this_update) < 0;
  }
}

cnd_rpl_do_stop_sway(var_0, var_1) {
  var_2 = var_0.player_anim_origin getanimweight( % rappel_player_stop_l) > 0;
  var_3 = var_0.player_anim_origin getanimweight( % rappel_player_stop_r) > 0;
  var_4 = var_2 || var_3;
  var_5 = abs(var_0.down_move_strength) > 0.2 || abs(var_0.right_move_strength) > 0.2;

  if(var_4 && var_5 && !isDefined(var_0.clearing_sways)) {
    var_6 = % rappel_player_stop_l;

    if(var_3) {
      var_6 = % rappel_player_stop_r;
    }

    var_0.player_anim_origin clearanim(var_6, 0.4);
    var_0.clearing_sways = 1;
  }

  if(isDefined(var_0.clearing_sways) && var_0.clearing_sways && !var_4) {
    var_0.clearing_sways = undefined;
  }

  if(!isDefined(var_0.begin_sway)) {
    return;
  }
  if(_rpl_legs_is_horizontal(var_0.stop_anim_direction)) {
    var_6 = % rappel_player_stop_l;

    if(var_0.stop_anim_direction == "right") {
      var_6 = % rappel_player_stop_r;
    }

    var_7 = 0.2;
    var_0.player_anim_origin setanimrestart(var_6, 1.0, var_7, 1.0);

    if(var_0.player_anim_origin getanimweight( % rappel_player_wind_push) > 0) {
      var_0.player_anim_origin clearanim( % rappel_player_wind_push, var_7);
    }

    var_0.clearing_sways = undefined;
  }

  var_0.begin_sway = undefined;
}

cnd_rpl_do_wind(var_0, var_1) {
  if(var_1.rappel_type == "combat") {
    return;
  }
  if(!var_0.wind_random) {
    var_0.wind_state = "stop";
    return;
  }

  var_0.wind_last_state = var_0.wind_state;

  if(var_0.wind_random_next_time > gettime()) {
    return;
  }
  var_2 = 2;
  var_3 = 2;
  var_4 = 1 / (var_2 / 0.05);
  var_5 = 1 / (var_3 / 0.05);
  var_6 = 1.8;
  var_7 = % rappel_player_wind_push;

  if(var_1.rappel_type == "inverted") {
    var_7 = % rappel_player_inv_wind_push;
  }

  if(var_0.wind_state == "strong") {
    var_0.wind_state = "down";
  } else if(var_0.wind_state == "stop" || var_0.wind_state == "calm") {
    var_0.wind_state = "up";
    common_scripts\utility::exploder("6111");
  }

  if(var_0.wind_state == "up") {
    var_0.wind_strength = var_0.wind_strength + var_4;
  } else if(var_0.wind_state == "down") {
    var_0.wind_strength = var_0.wind_strength - var_5;
  }

  if(var_0.wind_strength >= 1 && var_0.wind_state == "up") {
    var_0.wind_random_next_time = gettime() + 200.0;
    var_0.wind_state = "steady";
    var_0.wind_strength = 1;
  } else if(!var_0.wind_pushing_player && var_0.wind_strength >= 0.7) {
    var_8 = 0.2;
    var_0.wind_pushing_player = 1;
    var_0.player_anim_origin setanimrestart(var_7, 1.0, var_8, 1.0);
    var_0.player_anim_origin playrumbleonentity("light_in_out_2s");

    if(var_0.player_anim_origin getanimweight( % rappel_player_stop_l) > 0) {
      var_0.player_anim_origin clearanim( % rappel_player_stop_l, var_8);
    }

    if(var_0.player_anim_origin getanimweight( % rappel_player_stop_r) > 0) {
      var_0.player_anim_origin clearanim( % rappel_player_stop_r, var_8);
    }
  } else if(var_0.wind_pushing_player && var_0.wind_strength >= 1 && var_0.wind_state == "steady") {
    var_0.wind_random_next_time = gettime() + var_6 * 1000;
    var_0.wind_strength = 1;
    var_0.wind_state = "strong";
  } else if(var_0.wind_strength <= 0 && var_0.wind_state == "down") {
    var_0.wind_random_next_time = gettime() + randomfloatrange(var_0.wind_random_delay_min, var_0.wind_random_delay_max);
    var_0.wind_strength = 0;
    var_0.wind_state = "calm";
    var_0.wind_pushing_player = 0;
  }

  thread maps\cornered_audio::aud_do_wind(var_0.wind_state);
}

cnd_rpl_do_rope(var_0, var_1) {
  if(var_1.rappel_type == "inverted") {
    return;
  }
  if(!isDefined(level.rpl_physical_rope_origin)) {
    return;
  }
  if(abs(var_0.vertical_change_this_update) > 0) {
    var_2 = 1.0 / var_0.player_rope_unwind_length;
    var_3 = level.cnd_rappel_tele_rope getanimtime(var_0.player_rope_unwind_anim);
    var_4 = var_3 + -1 * var_0.vertical_change_this_update * var_2;
    var_4 = clamp(var_4, 0, 0.9999);
    level.cnd_rappel_tele_rope setanimtime(var_0.player_rope_unwind_anim, var_4);
  }

  if(abs(var_0.lateral_change_this_update) > 0) {
    level.rpl_physical_rope_origin rotateroll(var_0.lateral_change_this_update, var_0.time_slice, 0, 0);
  }

  if(var_0.jumping) {
    return;
  }
  var_5 = var_0.move_state == var_0.move_state_loop_run && var_0.last_move_state != var_0.move_state_loop_run;
  var_6 = var_0.move_state != var_0.move_state_loop_run && var_0.last_move_state == var_0.move_state_loop_run;
  var_7 = var_0.wind_state == "up" || var_0.wind_state == "down" || var_0.wind_state == "steady" || var_0.wind_state == "strong";
  var_8 = var_0.wind_state == "up" && var_0.wind_last_state != "up";
  var_9 = var_0.wind_state == "calm";
  var_10 = var_0.wind_state == "stop" && level.cnd_rappel_player_rope getanimweight( % cnd_rappel_wind_shake_rope_player) > 0;
  var_11 = 0.06;
  var_12 = level.cnd_rappel_player_rope getanimtime( % cnd_rappel_lag_r_rope_player);
  var_13 = level.cnd_rappel_player_rope getanimtime( % cnd_rappel_lag_l_rope_player);
  var_14 = level.cnd_rappel_player_rope getanimtime( % cnd_rappel_shake_rope_player);
  var_15 = level.cnd_rappel_player_rope getanimtime( % cnd_rappel_jump_shake_rope_player);
  var_16 = var_12 > 0 && var_12 < 1;
  var_17 = var_13 > 0 && var_13 < 1;
  var_18 = var_14 > 0 && var_14 < 1;
  var_19 = var_15 > 0 && var_15 < 1;
  var_20 = var_16 || var_17 || var_18 || var_19;

  if(var_5) {
    if(var_0.stop_anim_direction == "left") {
      level.cnd_rappel_player_rope setanimknobrestart( % cnd_rappel_lag_l_rope_player, 1, 0.2, 1);
    } else {
      level.cnd_rappel_player_rope setanimknobrestart( % cnd_rappel_lag_r_rope_player, 1, 0.2, 1);
    }
  } else if(var_6)
    level.cnd_rappel_player_rope setanimknobrestart( % cnd_rappel_shake_rope_player, 1, 0.2, 1);
  else {
    if(var_20) {
      return;
    }
    if(var_8) {
      level.cnd_rappel_player_rope setanimknob( % cnd_rappel_wind_shake_rope_player, 1.0, 0.2, var_0.wind_strength);
    } else if(var_7) {
      level.cnd_rappel_player_rope setanimknob( % cnd_rappel_wind_shake_rope_player, 1.0, 0.2, var_0.wind_strength);
    } else if(var_10) {
      level.cnd_rappel_player_rope setanimknob( % cnd_rappel_idle_rope_player_add, 1.0, 0.2, 1.0);
    } else if(var_9) {
      level.cnd_rappel_player_rope setanimknob( % cnd_rappel_wind_shake_rope_player, 1.0, 0.2, var_11);
    } else {}
  }
}

cnd_rpl_do_weapon_bob(var_0, var_1) {
  var_0.down_leg_move_percent = abs(var_0.vertical_change_this_update) / rpl_get_max_downward_speed();
  var_0.up_leg_move_percent = abs(var_0.vertical_change_this_update) / rpl_get_max_upward_speed();

  if(var_0.max_rotation_speed > 0) {
    var_0.horz_leg_move_percent = abs(var_0.lateral_change_this_update) / (var_0.max_rotation_speed * var_0.time_slice);
  } else {
    var_0.horz_leg_move_percent = 0;
  }

  var_2 = 22.4;

  if(var_0.jumping) {
    if(var_0.bg_weaponbobamplitudebase != 0) {
      setsaveddvar("bg_weaponBobAmplitudeBase", 0);
      setsaveddvar("g_speed", 0);
      var_0.bg_weaponbobamplitudebase = 0;
    }
  } else if(abs(var_0.vertical_change_this_update) > 0 || abs(var_0.lateral_change_this_update) > 0) {
    var_3 = 0.05;
    var_4 = 5;

    if(common_scripts\utility::sign(var_0.vertical_change_this_update) == -1) {
      var_5 = var_2 / rappel_vertical_speed_to_world_units(rpl_get_max_downward_speed());
      var_6 = rappel_vertical_speed_to_world_units(rpl_get_max_downward_speed()) + 40;
    } else {
      var_5 = var_2 / rappel_vertical_speed_to_world_units(rpl_get_max_upward_speed());
      var_6 = rappel_vertical_speed_to_world_units(rpl_get_max_upward_speed()) + 40;
    }

    var_7 = var_2 / rappel_lateral_speed_to_world_units(rpl_get_max_lateral_speed());
    var_8 = rappel_lateral_speed_to_world_units(rpl_get_max_lateral_speed());
    var_9 = 1;
    var_10 = 0;

    if(var_1.rappel_type == "inverted") {
      var_10 = var_0.down_leg_move_percent;
    } else {
      var_9 = var_0.horz_leg_move_percent;
    }

    if(abs(var_0.vertical_change_this_update) == 0) {
      var_9 = 1.0;
    } else if(abs(var_0.lateral_change_this_update) == 0) {
      var_9 = 0.0;
    }

    if(var_1.rappel_type == "inverted") {
      var_9 = 1 - var_10;
    } else {
      var_10 = 1 - var_9;
    }

    var_11 = var_5 * var_10 + var_7 * var_9;
    var_12 = var_6 * var_10 + var_8 * var_9;
    var_13 = var_0.bg_weaponbobamplitudebase;
    var_14 = var_0.g_speed;
    var_15 = var_11 - var_13;

    if(abs(var_15) > var_3) {
      var_11 = var_13 + common_scripts\utility::sign(var_15) * var_3;
    }

    var_16 = var_12 - var_14;

    if(abs(var_16) > var_4) {
      var_12 = var_14 + common_scripts\utility::sign(var_16) * var_4;
    }

    if(var_0.g_speed != var_12) {
      setsaveddvar("g_speed", var_12);
      var_0.g_speed = var_12;
    }

    if(var_0.bg_weaponbobamplitudebase != var_11) {
      setsaveddvar("bg_weaponBobAmplitudeBase", var_11);
      var_0.bg_weaponbobamplitudebase = var_11;
    }
  }
}

cnd_rpl_do_move_bob(var_0, var_1) {
  var_2 = % rappel_movement_player_bob;
  var_3 = % rappel_movement_player_bob_descend;
  var_4 = 4.0;
  var_5 = abs(var_0.lateral_change_this_update) > 0.1 || abs(var_0.vertical_change_this_update) > 0.1;
  var_6 = abs(var_0.lateral_change_this_update) > 0.1 && abs(var_0.vertical_change_this_update) < 0.1;
  var_7 = abs(var_0.lateral_change_this_update) < 0.1 && abs(var_0.vertical_change_this_update) > 0.1;

  if(var_0.jumpcomplete && var_0.bg_viewbobmax == 0) {
    setsaveddvar("bg_viewBobMax", 8);
    var_0.bg_viewbobmax = 8;
  } else if(!var_0.jumpcomplete && var_0.bg_viewbobmax == 8) {
    setsaveddvar("bg_viewBobMax", 0);
    var_0.bg_viewbobmax = 0;
  }

  if(var_5 && var_0.jumpcomplete && !var_0.glass_broken_under_player) {
    var_0.clearing_bob_anim = 0;
    var_8 = var_2;
    var_9 = var_3;

    if(var_7) {
      var_8 = var_3;
      var_9 = var_2;
    }

    var_10 = 0.7;

    if(level.player getstance() == "crouch") {
      var_10 = 0.5;
    }

    if(var_0.max_rotation_speed > 0) {
      var_11 = abs(var_0.lateral_change_this_update) / (var_0.max_rotation_speed * var_0.time_slice);
    } else {
      var_11 = 0;
    }

    var_12 = abs(var_0.vertical_change_this_update) / rpl_get_max_downward_speed() * 0.45;
    var_13 = max(var_11, var_12);
    var_14 = max(0.01, var_10 * var_13);

    if(rpl_get_max_downward_speed() > 10) {
      var_14 = 1.0;
    }

    var_15 = var_4 * var_13;

    if(var_15 > 0) {
      var_0.player_anim_origin setflaggedanim("bobanim", var_8, var_14, 0.15, var_15);
    } else {
      var_0.player_anim_origin clearanim(var_8, 0.2);
    }

    var_0.player_anim_origin clearanim(var_9, 0.2);

    if(var_0.player_anim_origin getanimtime(var_8) == 1) {
      var_0.player_anim_origin setanimtime(var_8, 0);
      return;
    }
  } else if(!var_0.clearing_bob_anim) {
    var_0.clearing_bob_anim = 1;
    var_0.player_anim_origin clearanim(var_2, 1);
    var_0.player_anim_origin clearanim(var_3, 1);
  }
}

cnd_rpl_legs_notetracks(var_0, var_1, var_2) {
  for(;;) {
    level.rappel_player_legs waittill(var_0.legs_flag_name, var_3);

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      var_0.current_foot = "left";
    } else if(var_3 == var_2) {
      var_0.current_foot = "right";
    }

    if(var_3 == "ps_step_run_plr_rappel") {
      thread maps\cornered_audio::aud_rappel("foot");
    }
  }
}

cnd_rpl_do_legs(var_0, var_1) {
  if(!rappel_use_plyr_legs(var_1) || !isDefined(level.rappel_player_legs)) {
    return;
  }
  rpl_legs_set_anim_move_strength(var_0);
  var_0.cur_move_vect_norm = vectornormalize((var_0.anim_right_move_strength, var_0.anim_down_move_strength, 0));
  var_3 = abs(var_0.anim_down_move_strength) > 0 || abs(var_0.anim_right_move_strength) > 0;
  var_0.last_move_vect_norm = var_0.cur_move_vect_norm;
  var_0.last_move_state = var_0.move_state;

  if(var_0.jumping && var_0.move_state != var_0.move_state_jump) {
    var_0.move_state = var_0.move_state_jump;
  }

  if(var_0.move_state == var_0.move_state_idle) {
    if(var_3 && rpl_legs_is_idle_ready(var_0)) {
      var_0.move_state = var_0.move_state_start;
    }
  } else if(var_0.move_state == var_0.move_state_jump) {
    if(!var_0.jumping) {
      var_0.move_state = var_0.move_state_idle;
    }
  } else if(var_0.move_state == var_0.move_state_start) {
    var_4 = rpl_legs_is_start_state_complete(var_0, var_3);

    if(var_4 && var_3) {
      var_0.move_state = var_0.move_state_loop;
    } else if(!var_3) {
      var_0.move_state = var_0.move_state_idle;
    }
  } else if(var_0.move_state == var_0.move_state_stop) {
    var_4 = rpl_legs_is_stop_state_complete(var_0);

    if(var_4 && !var_3) {
      var_0.move_state = var_0.move_state_idle;
    } else if(var_3) {
      var_0.move_state = var_0.move_state_loop;
    }
  } else if(var_0.move_state == var_0.move_state_loop_run) {
    var_5 = rpl_legs_is_loop_state_changing_direction(var_0, var_3);
    var_6 = rpl_legs_should_use_run_loop(var_0);
    var_7 = rpl_legs_traveling_horizontal(var_0, var_3);

    if(!var_3) {
      var_0.move_state = var_0.move_state_stop;
    } else if(var_5) {
      var_0.move_state = var_0.move_state_idle;
    } else if(!var_6 || !var_7) {
      var_0.move_state = var_0.move_state_loop;
    }
  } else {
    var_5 = rpl_legs_is_loop_state_changing_direction(var_0, var_3);
    var_6 = rpl_legs_should_use_run_loop(var_0);
    var_7 = rpl_legs_traveling_horizontal(var_0, var_3);

    if(!var_3) {
      var_0.move_state = var_0.move_state_stop;
    } else if(var_5) {
      var_0.move_state = var_0.move_state_idle;
    } else if(var_6 && var_7) {
      var_0.move_state = var_0.move_state_loop_run;
    }
  }

  plyr_rappel_legs_set_origin(var_0);

  if(isDefined(var_1.allow_sprint) && var_1.allow_sprint) {
    level.player allowsprint(!var_0.jumping && rpl_legs_traveling_horizontal(var_0, var_3));
  }

  rpl_legs_process_state(var_0);
}

rpl_legs_is_idle_ready(var_0) {
  var_1 = rpl_legs_get_idle_anim(var_0);
  var_2 = level.rappel_player_legs getanimweight(var_1);

  if(var_2 >= 0.4) {
    return 1;
  }

  return 0;
}

rpl_legs_set_anim_move_strength(var_0) {
  var_0.anim_right_move_strength = var_0.right_move_strength;

  if(abs(var_0.lateral_change_this_update) < 0.01) {
    var_0.anim_right_move_strength = 0;
  }

  var_0.anim_down_move_strength = var_0.down_move_strength;

  if(abs(var_0.vertical_change_this_update) < 0.01) {
    var_0.anim_down_move_strength = 0;
  }
}

rpl_legs_process_state(var_0) {
  var_1 = var_0.last_move_state != var_0.move_state;

  if(var_0.move_state == var_0.move_state_idle) {
    rpl_legs_set_idle(var_0);

    if(var_1) {
      rpl_legs_clear_all_move_anims(var_0);
      var_0.was_running = undefined;
    }
  } else if(var_0.move_state == var_0.move_state_jump) {
    if(var_1) {
      rpl_legs_clear_all_idle_anims(var_0);
      rpl_legs_clear_all_move_anims(var_0);
    }
  } else if(var_0.move_state == var_0.move_state_start || var_0.move_state == var_0.move_state_stop) {
    var_2 = 0;

    if(var_1) {
      var_2 = 1;

      if(var_0.move_state == var_0.move_state_stop && getdvarint("rappel_use_stop_momentum") == 1) {
        var_0.stop_momentum = getdvarfloat("rappel_stop_momentum_initial") * common_scripts\utility::sign(var_0.lateral_change_this_update);
        var_3 = getdvarfloat("rappel_stop_momentum_time");
        var_0.stop_momentum_change = var_0.stop_momentum / (var_3 * 20.0);
      }

      if(var_0.move_state == var_0.move_state_stop) {
        var_0.was_running = var_0.last_move_state == var_0.move_state_loop_run;
        var_0.begin_sway = 1;
      } else
        var_0.was_running = undefined;
    }

    if(var_0.move_state == var_0.move_state_stop) {
      var_4 = var_0.stop_anim_direction;
    } else {
      var_4 = rpl_legs_get_start_move_direction(var_0);
      var_0.last_start_anim_direction = var_4;
      var_0.stop_anim_direction = var_4;
    }

    var_5 = [];
    var_5[var_4] = 1.0;
    var_6 = rpl_legs_get_anim_type(var_0);
    var_7 = rpl_get_state_anim(var_0, var_6, var_4);
    var_8 = 1.0;
    var_9 = rpl_legs_get_blend_time(var_0, var_6, var_4);
    var_10 = rpl_legs_get_animation_rate(var_0, var_4, var_6);
    var_0.move[var_4].playing = 1;
    rpl_legs_set_anim(var_7, var_8, var_9, var_10, var_2, var_0.legs_flag_name);

    if(var_1) {
      rpl_legs_clear_anim(var_0.legs_move_parent_node, rpl_legs_get_clear_blend_time(var_0, var_0.animtype_parent, undefined));
      rpl_legs_clear_unused_anims(var_0, var_5);
      return;
    }
  } else {
    var_11 = var_0.move_state == var_0.move_state_loop_run;
    var_5 = rpl_legs_get_move_directions(var_0, var_11);
    var_12 = rpl_legs_get_direction_weights(var_5);
    var_0.stop_anim_direction = rpl_legs_get_stop_move_direction(var_0);
    var_13 = rpl_legs_changed_directions(var_0, var_5);
    var_14 = getarraykeys(var_0.move);

    foreach(var_4 in var_14) {
      if(isDefined(var_5[var_4])) {
        var_6 = rpl_legs_get_anim_type(var_0);
        var_7 = rpl_get_state_anim(var_0, var_6, var_4);
        var_8 = var_12[var_4];
        var_9 = rpl_legs_get_blend_time(var_0, var_6, var_4);
        var_10 = rpl_legs_get_animation_rate(var_0, var_4, var_6);
        var_0.move[var_4].playing = 1;
        rpl_legs_set_anim(var_7, var_8, var_9, var_10, 0, var_0.legs_flag_name);
      }
    }

    if(var_1 || var_13) {
      rpl_legs_clear_unused_anims(var_0, var_5);
    }

    if(var_1) {
      var_0.current_foot = "left";
    }
  }
}

rpl_legs_changed_directions(var_0, var_1) {
  var_2 = getarraykeys(var_1);

  foreach(var_4 in var_2) {
    if(!var_0.move[var_4].playing) {
      return 1;
    }
  }

  return 0;
}

rpl_legs_should_use_run_loop(var_0) {
  var_1 = 0.8;

  if(var_0.horz_leg_move_percent < var_1) {
    return 0;
  }

  return 1;
}

rpl_legs_traveling_horizontal(var_0, var_1) {
  if(!var_1) {
    return 0;
  }

  var_2 = rpl_legs_get_move_directions(var_0, 1);
  var_3 = getarraykeys(var_2);

  if(_rpl_legs_is_horizontal(var_3[0])) {
    return 1;
  }

  return 0;
}

rpl_legs_is_loop_state_changing_direction(var_0, var_1) {
  var_2 = vectordot(var_0.last_move_vect_norm, var_0.cur_move_vect_norm);

  if(var_2 <= var_0.cosine90) {
    return 1;
  }

  return 0;
}

rpl_legs_is_start_state_complete(var_0, var_1) {
  if(var_1) {
    var_2 = rpl_legs_get_start_move_direction(var_0);
    var_3 = rpl_legs_get_previous_move_directions(var_0);
    var_4 = var_3[0];

    if(isDefined(var_4) && var_2 != var_4) {
      return 1;
    }
  }

  var_5 = getarraykeys(var_0.move);

  foreach(var_7 in var_5) {
    var_8 = rpl_legs_get_anim_type(var_0);
    var_9 = rpl_get_state_anim(var_0, var_8, var_7);
    var_10 = level.rappel_player_legs getanimtime(var_9);

    if(var_10 > 0 && var_10 < var_0.state_anim_percent_complete) {
      return 0;
    }
  }

  return 1;
}

rpl_legs_is_stop_state_complete(var_0) {
  var_1 = rpl_legs_get_anim_type(var_0);
  var_2 = rpl_get_state_anim(var_0, var_1, var_0.stop_anim_direction);
  var_3 = level.rappel_player_legs getanimtime(var_2);
  return var_3 == 1;
}

rpl_legs_get_previous_move_directions(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0.move);

  foreach(var_4 in var_2) {
    if(var_0.move[var_4].playing) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

rpl_legs_get_animation_rate(var_0, var_1, var_2) {
  if(var_2 == var_0.animtype_stop || var_2 == var_0.animtype_run_stop) {
    return 1.0;
  }

  var_3 = getdvarfloat("rappel_legs_scale_horizontal");
  var_4 = getdvarfloat("rappel_legs_scale_up");
  var_5 = getdvarfloat("rappel_legs_scale_down");

  if(var_2 == var_0.animtype_loop_run) {
    var_3 = getdvarfloat("rappel_legs_scale_run");
  }

  if(var_1 == "down") {
    return var_0.down_leg_move_percent * var_5;
  } else if(var_1 == "up") {
    return var_0.up_leg_move_percent * var_4;
  } else if(var_1 == "left" || var_1 == "right") {
    return var_0.horz_leg_move_percent * var_3;
  } else if(var_1 == "left_down" || var_1 == "right_down") {
    var_6 = length((var_0.horz_leg_move_percent, var_0.down_leg_move_percent, 0));
    var_7 = var_5;
    return var_6 * var_7;
  } else {
    var_6 = length((var_0.horz_leg_move_percent, var_0.up_leg_move_percent, 0));
    var_7 = var_4;
    return var_6 * var_7;
  }
}

rpl_legs_get_direction_weights(var_0) {
  var_1 = getarraykeys(var_0);
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_2 = var_2 + var_0[var_4];
  }

  var_6 = [];

  foreach(var_4 in var_1) {
    var_6[var_4] = var_0[var_4] / var_2;
  }

  return var_6;
}

_rpl_legs_is_diagonal(var_0) {
  return var_0 == "left_up" || var_0 == "left_down" || var_0 == "right_up" || var_0 == "right_down";
}

_rpl_legs_is_horizontal(var_0) {
  return var_0 == "left" || var_0 == "right";
}

rpl_legs_get_start_move_direction(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = getarraykeys(var_0.move);

  foreach(var_5 in var_3) {
    var_6 = vectordot(var_0.cur_move_vect_norm, var_0.move[var_5].vector);

    if(var_6 <= var_0.cosine22_5) {
      continue;
    }
    if(_rpl_legs_is_diagonal(var_5)) {
      var_2 = var_5;
    }

    var_1[var_1.size] = var_5;
  }

  if(var_1.size == 2) {
    var_1 = common_scripts\utility::array_remove(var_1, var_2);
  }

  return var_1[0];
}

rpl_legs_get_stop_move_direction(var_0) {
  var_1 = rpl_legs_get_move_directions(var_0, 1);
  var_2 = getarraykeys(var_1);
  return var_2[0];
}

rpl_legs_get_move_directions(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_0.move);

  foreach(var_5 in var_3) {
    var_6 = vectordot(var_0.cur_move_vect_norm, var_0.move[var_5].vector);

    if(var_6 <= var_0.cosine45) {
      continue;
    }
    var_2[var_5] = var_6;
  }

  if(var_2.size == 2) {
    var_8 = [];
    var_3 = getarraykeys(var_2);

    foreach(var_5 in var_3) {
      var_6 = var_2[var_5];

      if(var_6 <= var_0.cosine15) {
        continue;
      }
      var_8[var_5] = var_6;
    }

    if(var_8.size == 1) {
      return var_8;
    }
  }

  if(var_2.size == 2) {
    var_3 = getarraykeys(var_2);

    if(common_scripts\utility::array_contains(var_3, "left") && common_scripts\utility::array_contains(var_3, "left_down")) {
      var_2["left_down"] = undefined;
    } else if(common_scripts\utility::array_contains(var_3, "right") && common_scripts\utility::array_contains(var_3, "right_down")) {
      var_2["right_down"] = undefined;
    }
  }

  if(var_2.size == 2 && var_1) {
    var_2["left_down"] = undefined;
    var_2["right_down"] = undefined;
    var_2["left_up"] = undefined;
    var_2["right_up"] = undefined;
  }

  return var_2;
}

rpl_legs_get_blend_time(var_0, var_1, var_2) {
  if(var_1 == var_0.animtype_loop || var_1 == var_0.animtype_loop_run) {
    if(rpl_legs_is_state_direction_anim_complete(var_0, var_0.animtype_start, var_2)) {
      return var_0.leg_anim_blend_time_fast;
    }
  }

  return var_0.leg_anim_blend_time;
}

rpl_legs_get_clear_blend_time(var_0, var_1, var_2) {
  if(var_0.move_state == var_0.move_state_jump) {
    return var_0.leg_jump_anim_blend_time;
  } else if(var_1 == var_0.animtype_start) {
    if(var_0.move_state == var_0.move_state_start) {
      return var_0.leg_clear_anim_blend_time_fast;
    }
  } else if(var_1 == var_0.animtype_loop || var_1 == var_0.animtype_loop_run || var_1 == var_0.animtype_parent) {
    if(var_0.move_state == var_0.move_state_idle) {
      return var_0.leg_idle_anim_blend_time;
    }

    if(var_0.move_state == var_0.move_state_start && rpl_legs_is_start_anim_ready_to_blend_out_loops(var_0, var_0.last_start_anim_direction)) {
      return 0;
    }
  }

  return var_0.leg_clear_anim_blend_time;
}

rpl_legs_is_start_anim_ready_to_blend_out_loops(var_0, var_1) {
  var_2 = 0.5;
  var_3 = rpl_get_state_anim(var_0, var_0.animtype_start, var_1);
  var_4 = level.rappel_player_legs getanimtime(var_3);

  if(var_4 >= var_2) {
    return 1;
  }

  return 0;
}

rpl_legs_is_state_direction_anim_complete(var_0, var_1, var_2) {
  var_3 = rpl_get_state_anim(var_0, var_1, var_2);
  var_4 = level.rappel_player_legs getanimtime(var_3);
  var_5 = level.rappel_player_legs getanimweight(var_3);

  if(var_4 >= var_0.state_anim_percent_complete && var_5 > 0) {
    return 1;
  }

  return 0;
}

rpl_legs_clear_all_idle_anims(var_0) {
  var_1 = rpl_legs_get_clear_blend_time(var_0, var_0.animtype_idle, undefined);
  var_2 = var_0.legs_idle_anim;
  rpl_legs_clear_anim(var_2, var_1);
}

rpl_legs_clear_all_move_anims(var_0, var_1) {
  rpl_legs_clear_anim(var_0.legs_move_parent_node, rpl_legs_get_clear_blend_time(var_0, var_0.animtype_parent, undefined));
  var_2 = getarraykeys(var_0.move);

  foreach(var_4 in var_2) {
    var_0.move[var_4].playing = 0;

    if(isDefined(var_1)) {
      rpl_legs_clear_anim(rpl_get_walk_start_anim(var_4), var_1);
      rpl_legs_clear_anim(rpl_get_walk_loop_anim(var_4), var_1);
      rpl_legs_clear_anim(rpl_get_walk_stop_anim(var_4), var_1);

      if(_rpl_legs_is_horizontal(var_4)) {
        rpl_legs_clear_anim(rpl_get_run_loop_anim(var_4), var_1);
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "left"), var_1);
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "right"), var_1);
      }

      continue;
    }

    rpl_legs_clear_anim(rpl_get_walk_start_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_start, var_4));
    rpl_legs_clear_anim(rpl_get_walk_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop, var_4));
    rpl_legs_clear_anim(rpl_get_walk_stop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_stop, var_4));

    if(_rpl_legs_is_horizontal(var_4)) {
      rpl_legs_clear_anim(rpl_get_run_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop_run, var_4));
      rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "left"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
      rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "right"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
    }
  }
}

rpl_legs_clear_unused_anims(var_0, var_1) {
  rpl_legs_clear_all_idle_anims(var_0);
  var_2 = getarraykeys(var_0.move);

  foreach(var_4 in var_2) {
    if(!isDefined(var_1[var_4])) {
      var_0.move[var_4].playing = 0;
      rpl_legs_clear_anim(rpl_get_walk_start_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_start, var_4));
      rpl_legs_clear_anim(rpl_get_walk_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop, var_4));
      rpl_legs_clear_anim(rpl_get_walk_stop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_stop, var_4));

      if(_rpl_legs_is_horizontal(var_4)) {
        rpl_legs_clear_anim(rpl_get_run_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop_run, var_4));
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "left"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "right"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
      }

      continue;
    }

    if(var_0.move_state != var_0.move_state_start) {
      rpl_legs_clear_anim(rpl_get_walk_start_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_start, var_4));
    }

    if(var_0.move_state != var_0.move_state_loop) {
      rpl_legs_clear_anim(rpl_get_walk_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop, var_4));
    }

    if(var_0.move_state != var_0.move_state_loop_run && _rpl_legs_is_horizontal(var_4)) {
      rpl_legs_clear_anim(rpl_get_run_loop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_loop_run, var_4));
    }

    if(var_0.move_state != var_0.move_state_stop) {
      rpl_legs_clear_anim(rpl_get_walk_stop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_stop, var_4));

      if(_rpl_legs_is_horizontal(var_4)) {
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "left"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
        rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "right"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
      }

      continue;
    }

    var_5 = isDefined(var_0.was_running) && var_0.was_running;
    var_6 = isDefined(var_0.current_foot) && var_0.current_foot == "right";
    var_7 = isDefined(var_0.current_foot) && var_0.current_foot == "left";

    if(var_5) {
      rpl_legs_clear_anim(rpl_get_walk_stop_anim(var_4), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_stop, var_4));
    }

    if(!var_5 && !var_6 && _rpl_legs_is_horizontal(var_4)) {
      rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "right"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
    }

    if(!var_5 && !var_7 && _rpl_legs_is_horizontal(var_4)) {
      rpl_legs_clear_anim(rpl_get_run_stop_anim(var_4, "left"), rpl_legs_get_clear_blend_time(var_0, var_0.animtype_run_stop, var_4));
    }
  }
}

rpl_legs_get_idle_anim(var_0) {
  var_1 = var_0.legs_idle_anim;
  return var_1;
}

rpl_legs_set_idle(var_0) {
  var_1 = rpl_legs_get_idle_anim(var_0);
  level.rappel_player_legs setanim(var_1, 1.0, var_0.leg_idle_anim_blend_time, 1.0);
}

rpl_legs_set_anim(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = isDefined(var_4) && var_4;
  var_7 = isDefined(var_5);

  if(var_6 && var_7) {
    level.rappel_player_legs setflaggedanimrestart(var_5, var_0, var_1, var_2, var_3);
  } else if(var_6) {
    level.rappel_player_legs setanimrestart(var_0, var_1, var_2, var_3);
  } else if(var_7) {
    level.rappel_player_legs setflaggedanim(var_5, var_0, var_1, var_2, var_3);
  } else {
    level.rappel_player_legs setanim(var_0, var_1, var_2, var_3);
  }
}

rpl_legs_clear_anim(var_0, var_1) {
  level.rappel_player_legs clearanim(var_0, var_1);
}

rpl_legs_get_anim_type(var_0) {
  if(var_0.move_state == var_0.move_state_start) {
    return var_0.animtype_start;
  } else if(var_0.move_state == var_0.move_state_idle) {
    return var_0.animtype_idle;
  } else if(var_0.move_state == var_0.move_state_stop && isDefined(var_0.was_running) && var_0.was_running) {
    return var_0.animtype_run_stop;
  } else if(var_0.move_state == var_0.move_state_stop) {
    return var_0.animtype_stop;
  } else if(var_0.move_state == var_0.move_state_loop) {
    return var_0.animtype_loop;
  } else if(var_0.move_state == var_0.move_state_loop_run) {
    return var_0.animtype_loop_run;
  } else if(var_0.move_state == var_0.move_state_idle_shift) {
    return var_0.animtype_idle_shift;
  } else if(var_0.move_state == var_0.move_state_shift_back) {
    return var_0.animtype_shift_back;
  } else {}
}

rpl_get_state_anim(var_0, var_1, var_2) {
  if(var_1 == var_0.animtype_start) {
    return rpl_get_walk_start_anim(var_2);
  } else if(var_1 == var_0.animtype_loop) {
    return rpl_get_walk_loop_anim(var_2);
  } else if(var_1 == var_0.animtype_loop_run) {
    return rpl_get_run_loop_anim(var_2);
  } else if(var_1 == var_0.animtype_stop) {
    return rpl_get_walk_stop_anim(var_2);
  } else if(var_1 == var_0.animtype_run_stop) {
    return rpl_get_run_stop_anim(var_2, var_0.current_foot);
  } else if(var_1 == var_0.animtype_idle) {
    return rpl_get_idle_anim(var_2);
  } else {}
}

#using_animtree("player");

rpl_get_idle_anim(var_0) {
  switch (var_0) {
    case "down":
    case "up":
      return % cnd_rappel_idle_playerlegs;
    default:
      break;
  }
}

rpl_legs_get_parent_node_move() {
  return % cnd_rappel_playerlegs_movement;
}

rpl_get_run_loop_anim(var_0) {
  switch (var_0) {
    case "right_up":
    case "right_down":
    case "right":
      return % cnd_rappel_move_run_right_loop_playerlegs;
    case "left_up":
    case "left_down":
    case "left":
      return % cnd_rappel_move_run_left_loop_playerlegs;
    default:
      break;
  }
}

rpl_get_walk_loop_anim(var_0) {
  switch (var_0) {
    case "down":
      return % cnd_rappel_move_down_loop_playerlegs;
    case "up":
      return % cnd_rappel_move_up_loop_playerlegs;
    case "right":
      return % cnd_rappel_move_right_loop_playerlegs;
    case "left":
      return % cnd_rappel_move_left_loop_playerlegs;
    case "right_down":
      return % cnd_rappel_move_down_right_loop_playerlegs;
    case "right_up":
      return % cnd_rappel_move_up_right_loop_playerlegs;
    case "left_down":
      return % cnd_rappel_move_down_left_loop_playerlegs;
    case "left_up":
      return % cnd_rappel_move_up_left_loop_playerlegs;
    default:
      break;
  }
}

rpl_get_walk_start_anim(var_0) {
  switch (var_0) {
    case "down":
      return % cnd_rappel_move_down_start_playerlegs;
    case "up":
      return % cnd_rappel_move_up_start_playerlegs;
    case "right":
      return % cnd_rappel_move_right_start_playerlegs;
    case "left":
      return % cnd_rappel_move_left_start_playerlegs;
    case "right_down":
      return % cnd_rappel_move_down_right_start_playerlegs;
    case "right_up":
      return % cnd_rappel_move_up_right_start_playerlegs;
    case "left_down":
      return % cnd_rappel_move_down_left_start_playerlegs;
    case "left_up":
      return % cnd_rappel_move_up_left_start_playerlegs;
    default:
      break;
  }
}

rpl_get_walk_stop_anim(var_0) {
  return % cnd_rappel_move_stop;
}

rpl_get_run_stop_anim(var_0, var_1) {
  return % cnd_rappel_move_stop;
}

rpl_get_legs_idle_anim() {
  return % cnd_rappel_idle_playerlegs;
}

rpl_get_legs_jump_anim() {
  if(isDefined(level.rappel_legs_jump_anim)) {
    return level.rappel_legs_jump_anim;
  } else {
    return % cnd_rappel_jump_playerlegs;
  }
}

rpl_get_garden_entry_legs_static_anim() {
  return % cornered_combat_rappel_garden_entry_static_playerlegs;
}

rpl_get_garden_entry_arms_static_anim() {
  return % cornered_combat_rappel_garden_entry_static_playerarms;
}

watch_footstep_notetrack() {
  common_scripts\utility::flag_wait("player_has_exited_the_building");

  while(!common_scripts\utility::flag("inverted_rappel_finished")) {
    self waittill("bobanim", var_0);

    if(var_0 == "ps_step_run_plr_rappel") {
      maps\cornered_audio::aud_rappel("foot");
      wait 0.2;
    }
  }
}

cnd_rpl_cleanup(var_0) {
  level.rappel_jump_land_struct = undefined;
  level.player.forcing_rappel_jump_to_struct = undefined;
  level.player.linked_world_space_forward = undefined;
  level.rappel_jump_anim = undefined;

  if(var_0.rappel_type != "combat") {
    level.player allowcrouch(1);
    level.player allowsprint(1);
    level.player allowprone(1);
    level.player allowmelee(1);
  }

  level.player enablemousesteer(0);
  level.level_specific_dof = 0;
  level.player.dof_ref_ent = undefined;
  setsaveddvar("player_moveThreshhold", 10.0);
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.055 0.025");
  setsaveddvar("player_lateralPlane", 0);
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.16);
  setsaveddvar("g_speed", 190.0);
  setsaveddvar("bg_viewBobMax", 8);
  setsaveddvar("bullet_penetrationHitsClients", 0);
  setsaveddvar("bullet_penetrationActorHitsActors", 0);
  maps\cornered_code::delete_if_defined(level.rpl.rope_origin);
  maps\cornered_code::delete_if_defined(level.rpl_physical_rope_origin);
  maps\cornered_code::delete_if_defined(level.rpl_jump_anim_origin);
  maps\cornered_code::delete_if_defined(level.rpl_jump_anim_origin);
  maps\cornered_code::delete_if_defined(level.player_torso_offset_origin);
  maps\cornered_code::delete_if_defined(level.rpl_plyr_legs_link_ent);
  level.rpl = undefined;
  common_scripts\utility::flag_clear("stop_manage_player_rappel_movement");
}

rappel_limit_vertical_move(var_0, var_1) {
  var_2 = rpl_calc_dist_player_to_top(level.rpl, 1);
  level.rappel_lower_limit = var_2 - var_0;
  level.rappel_upper_limit = var_2 - var_1;
}

rappel_clear_vertical_limits() {
  level.rappel_lower_limit = undefined;
  level.rappel_upper_limit = undefined;
}

rpl_calc_max_yaw_right(var_0) {
  var_1 = rpl_calc_dist_player_to_top(var_0);

  if(level.rappel_max_lateral_dist_right / var_1 > 1) {
    return 60;
  }

  var_2 = asin(level.rappel_max_lateral_dist_right / var_1);
  return var_2;
}

rpl_calc_max_yaw_left(var_0) {
  var_1 = rpl_calc_dist_player_to_top(var_0);

  if(level.rappel_max_lateral_dist_left / var_1 > 1) {
    return -60;
  }

  var_2 = asin(-1 * level.rappel_max_lateral_dist_left / var_1);
  return var_2;
}

rpl_calc_max_rot_speed(var_0, var_1) {
  var_2 = rpl_get_max_lateral_speed();

  if(rappel_use_plyr_legs(var_1)) {
    var_0.anim_right_move_strength = var_0.right_move_strength;
    var_0.anim_down_move_strength = var_0.down_move_strength;

    if(abs(var_0.vertical_change_this_update) == 0) {
      var_0.anim_down_move_strength = 0;
    }

    var_0.cur_move_vect_norm = vectornormalize((var_0.anim_right_move_strength, var_0.anim_down_move_strength, 0));
    var_3 = abs(var_0.anim_down_move_strength) > 0 || abs(var_0.anim_right_move_strength) > 0;
    var_4 = rpl_legs_traveling_horizontal(var_0, var_3);

    if(!var_4 && var_3 && common_scripts\utility::sign(var_0.vertical_change_this_update) == -1) {
      var_2 = rpl_get_max_downward_speed();
    }
  }

  var_5 = rpl_calc_dist_player_to_top(var_0);
  var_6 = var_2 * 1000 / var_5;

  if(!var_0.jumping && level.player maps\_utility::isads()) {
    var_6 = var_6 * 0.25;
  }

  if(level.player issprinting()) {
    var_6 = var_6 * 1.5;
  }

  if(var_0.too_close_to_ally) {
    var_6 = 0;
  }

  return var_6;
}

rpl_calc_dist_player_to_top(var_0, var_1) {
  var_2 = distance(level.player.origin, level.rpl_rope_anim_origin.origin);

  if(isDefined(var_1) && var_1) {
    return var_2;
  }

  if(abs(var_0.current_dist_to_top - var_2) > 10) {
    var_0.current_dist_to_top = var_2;
  }

  return var_0.current_dist_to_top;
}

player_rappel_force_jump_away(var_0) {
  if(isDefined(var_0)) {
    level.player.forcing_rappel_jump_to_struct = 1;
    level.rappel_jump_land_struct = var_0;
  }

  level.player notify("playerforcejump");
}

#using_animtree("animated_props");

cnd_plyr_rpl_handle_jump(var_0, var_1) {
  level endon("stop_manage_player_rappel_movement");
  var_2 = % rappel_movement_player_jump_still;
  common_scripts\utility::flag_clear("player_jumping");
  notifyoncommand("playerjump", "+gostand");
  notifyoncommand("playerjump", "+moveup");
  var_3 = cnd_get_rope_anim_origin();
  var_4 = var_3.angles[0];
  var_1.initial_dist_z_from_top = abs(level.player.origin[2] - var_1.rope_origin.origin[2]);

  for(;;) {
    level.player common_scripts\utility::waittill_either("playerjump", "playerforcejump");

    if(!common_scripts\utility::flag("force_jump") && !common_scripts\utility::flag("disable_rappel_jump")) {
      level.player allowjump(0);
      var_5 = isDefined(level.player.forcing_rappel_jump_to_struct) && level.player.forcing_rappel_jump_to_struct;
      common_scripts\utility::flag_set("player_jumping");
      var_1.jumpcomplete = 0;
      var_6 = rpl_get_rotate_jump_anim(var_0);
      level.rappel_jump_anim = var_6;
      var_7 = getanimlength(var_6);
      thread rappel_rope_additive_jump_animations(var_0, var_7);
      thread maps\cornered_audio::aud_rappel("jump");
      rappel_rope_animate_rotate(var_1, var_3, var_6, var_2);

      if(rappel_use_plyr_legs(var_0)) {
        var_8 = rpl_get_legs_jump_anim();
        level.rappel_player_legs setanimrestart(var_8, 1.0, var_1.leg_jump_anim_blend_time, 1.0);
      }

      var_9 = var_7 * rpl_get_jump_percent_considered_complete(var_0);
      var_10 = var_7 - var_9;

      if(!var_5) {
        wait(var_9);
      } else {
        wait(var_7);
      }

      common_scripts\utility::flag_clear("player_jumping");
      level.player allowjump(1);

      if(var_5) {
        level notify("player_force_jump_landed");
        thread end_legs_jump_anim(var_1);
      } else if(rappel_use_plyr_legs(var_0))
        thread end_legs_jump_anim(var_1, var_10);
    }
  }
}

cnd_plyr_rpl_handle_view_lerp(var_0, var_1) {
  level.player endon("death");

  if(!rappel_use_plyr_legs(var_0)) {
    return;
  }
  level endon("stop_manage_player_rappel_movement");
  thread cnd_plyr_catch_fire_reload(var_0, var_1);
  var_2 = 0.2;
  var_3 = 15;
  var_4 = var_0.right_arc;
  var_5 = var_0.left_arc;
  var_6 = var_0.top_arc;
  var_7 = var_0.bottom_arc;
  var_8 = max(1, var_7 - var_3);
  level.player notifyonplayercommand("rappel_lerp", "+usereload");
  level.player notifyonplayercommand("rappel_lerp", "+reload");
  level.player notifyonplayercommand("rappel_lerp_weap", "weapnext");

  for(;;) {
    var_9 = level.player common_scripts\utility::waittill_any_return("rappel_lerp", "rappel_lerp_fire", "rappel_lerp_weap");

    if(var_9 == "rappel_lerp") {
      var_10 = level.player getcurrentprimaryweapon();
      var_11 = level.player getweaponammoclip(var_10);
      var_12 = weaponclipsize(var_10);

      if(var_11 == var_12) {
        continue;
      }
    }

    level.player lerpviewangleclamp(var_2, 0, 0, var_4, var_5, var_6, var_8);
    wait(var_2);

    if(var_9 == "rappel_lerp_fire") {
      wait 1;
    }

    while(level.player isreloading() || level.player isswitchingweapon()) {
      common_scripts\utility::waitframe();
    }

    level.player lerpviewangleclamp(var_2, 0, 0, var_4, var_5, var_6, var_7);
  }
}

cnd_plyr_catch_fire_reload(var_0, var_1) {
  level.player endon("death");
  level endon("stop_manage_player_rappel_movement");
  level.player notifyonplayercommand("player_fired", "+attack");
  level.player notifyonplayercommand("player_fired", "+attack_akimbo_accessible");

  for(;;) {
    level.player waittill("player_fired");
    var_2 = level.player getcurrentprimaryweapon();
    var_3 = 1;

    while(level.player isfiring() || level.player attackbuttonpressed() || var_3) {
      var_4 = level.player getweaponammoclip(var_2);

      if(var_4 == 0) {
        level.player notify("rappel_lerp_fire");
        common_scripts\utility::waitframe();
        continue;
      } else {
        if(var_3) {
          var_5 = level.player common_scripts\utility::waittill_notify_or_timeout_return("player_fired", 0.2);

          if(!isDefined(var_5) || var_5 != "timeout") {
            continue;
          }
        } else
          common_scripts\utility::waitframe();

        var_3 = 0;
      }
    }
  }
}

rpl_get_jump_percent_considered_complete(var_0) {
  var_1 = var_0.jump_type;

  if(isDefined(level.rappel_rotate_jump_anim) || var_1 == "jump_small") {
    return 1.0;
  } else {
    return 0.65;
  }
}

rpl_get_rotate_jump_anim(var_0) {
  var_1 = var_0.jump_type;

  if(isDefined(level.rappel_rotate_jump_anim)) {
    return level.rappel_rotate_jump_anim;
  } else if(var_1 == "jump_small") {
    return % rappel_movement_player_jump_rotate_sm;
  } else {
    return % rappel_movement_player_jump_rotate;
  }
}

rappel_rope_additive_jump_animations(var_0, var_1) {
  if(var_0.rappel_type == "inverted") {
    return;
  }
  level.cnd_rappel_player_rope setanimknobrestart( % cnd_rappel_idle_rope_player_add, 1.0, 0.5, 1.0);
  wait(var_1 - 0.3);
  level.cnd_rappel_player_rope setanimknobrestart( % cnd_rappel_jump_shake_rope_player, 1, 0, 1);
}

rappel_rope_animate_rotate(var_0, var_1, var_2, var_3) {
  var_4 = abs(level.player.origin[2] - var_0.rope_origin.origin[2]);
  var_5 = var_0.initial_dist_z_from_top / var_4;
  var_6 = atan(var_5 * var_0.tangentjump);
  var_7 = var_6 / var_0.maxropejumpangle;
  var_7 = clamp(var_7, 0, 1.0);
  var_8 = 1.0 - var_7;
  var_1 setanim(var_2, var_7, 0, 1);
  var_1 setanimtime(var_2, 0);
  level.rpl_physical_rope_anim_origin setanim(var_2, var_7, 0, 1);
  level.rpl_physical_rope_anim_origin setanimtime(var_2, 0);
  var_1 setanim(var_3, var_8, 0, 1);
  var_1 setanimtime(var_3, 0);
  level.rpl_physical_rope_anim_origin setanim(var_3, var_8, 0, 1);
  level.rpl_physical_rope_anim_origin setanimtime(var_3, 0);
}

end_legs_jump_anim(var_0, var_1) {
  level endon("stop_manage_player_rappel_movement");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = rpl_get_legs_jump_anim();

  if(level.rappel_player_legs getanimtime(var_2) > 0.9) {
    level.rappel_player_legs clearanim(var_2, 0.2);
    var_0.jumpcomplete = 1;
  }
}

plyr_is_moving_up(var_0) {
  if(var_0.move_state != var_0.move_state_start && var_0.move_state != var_0.move_state_loop) {
    return 0;
  }

  if(var_0.move_state == var_0.move_state_start) {
    var_1 = rpl_legs_get_start_move_direction(var_0);

    if(var_1 == "up" || var_1 == "left_up" || var_1 == "right_up") {
      return 1;
    }
  } else {
    var_2 = rpl_legs_get_move_directions(var_0, 0);
    var_3 = getarraykeys(var_2);

    if(common_scripts\utility::array_contains(var_3, "up") || common_scripts\utility::array_contains(var_3, "left_up") || common_scripts\utility::array_contains(var_3, "right_up")) {
      return 1;
    }
  }

  return 0;
}

plyr_rappel_legs_set_origin(var_0) {
  var_1 = getdvarint("move_up_offset", 20);
  var_2 = getdvarfloat("move_up_lerp", 5.0);
  level.rappel_player_legs unlink();
  var_3 = level.rpl_plyr_legs_link_ent.origin;
  var_4 = 0;

  if(!isDefined(var_0.last_legs_offset)) {
    var_0.last_legs_offset = 0;
  }

  if(plyr_is_moving_up(var_0)) {
    var_4 = var_4 + var_1;
  }

  var_5 = var_4 - var_0.last_legs_offset;

  if(abs(var_5) > 0 && abs(var_5) > var_2) {
    var_4 = var_0.last_legs_offset + common_scripts\utility::sign(var_5) * var_2;
  }

  var_0.last_legs_offset = var_4;

  if(abs(var_4) > 0) {
    var_6 = -1 * anglestoup(level.rpl_rope_anim_origin gettagangles("J_prop_1"));
    var_7 = vectornormalize(var_6) * var_4;
    var_3 = var_3 + var_7;
  }

  level.rappel_player_legs.origin = var_3;
  level.rappel_player_legs linkto(level.rpl_plyr_legs_link_ent);
}

plyr_rappel_jump_down(var_0, var_1) {
  common_scripts\utility::flag_set("force_jump");
  common_scripts\utility::flag_clear("player_jumping");

  if(isDefined(var_1)) {
    var_2 = % rappel_movement_player_jump_rotate;
  } else {
    var_2 = % rappel_movement_player_jump_rotate2;
  }

  var_3 = % rappel_movement_player_jump_still;
  var_4 = cnd_get_rope_anim_origin();
  var_5 = var_4.angles[0];
  level.player setstance("stand");
  level.player allowjump(0);
  common_scripts\utility::flag_set("player_jumping");
  level.rpl.jumpcomplete = 0;
  thread maps\cornered_audio::aud_rappel_jump_down(0.5, 1.6);
  var_6 = getanimlength(var_2);
  thread rappel_rope_additive_jump_animations(var_0, var_6);
  rappel_rope_animate_rotate(level.rpl, var_4, var_2, var_3);
  var_7 = rpl_get_legs_jump_anim();

  if(rappel_use_plyr_legs(var_0)) {
    level.rappel_player_legs setanim(var_7, 1.0, 0.2, 1.0);
    level.rappel_player_legs setanimtime(var_7, 0.0);
  }

  wait(var_6);

  if(rappel_use_plyr_legs(var_0)) {
    level.rappel_player_legs clearanim(var_7, 0.2);
  }

  level.player allowjump(1);
  common_scripts\utility::flag_clear("player_jumping");
  common_scripts\utility::flag_clear("force_jump");
  level.rpl.jumpcomplete = 1;
  level.player_jump_down_finished = 1;
}

rappel_use_plyr_legs(var_0) {
  if(!var_0.show_legs) {
    return 0;
  }

  return 1;
}

cnd_get_rope_anim_origin() {
  return level.rpl_rope_anim_origin;
}

cnd_get_plyr_anim_origin() {
  return level.rpl_plyr_anim_origin;
}

rappel_lateral_speed_to_world_units(var_0) {
  return var_0 * 140 / 8.0;
}

rappel_vertical_speed_to_world_units(var_0) {
  return var_0 * 20;
}

rpl_get_max_lateral_speed() {
  return level.rappel_max_lateral_speed;
}

rpl_get_max_upward_speed() {
  return level.rappel_max_upward_speed;
}

rpl_get_max_downward_speed() {
  return level.rappel_max_downward_speed;
}