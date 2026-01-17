/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_infil.gsc
*****************************************************/

cornered_infil_pre_load() {
  common_scripts\utility::flag_init("player_moved_during_rappel");
  common_scripts\utility::flag_init("player_jumped_during_rappel");
  common_scripts\utility::flag_init("rappel_down_ready");
  common_scripts\utility::flag_init("first_jump_start_stealth");
  common_scripts\utility::flag_init("first_jump_done_stealth");
  common_scripts\utility::flag_init("second_jump_start_stealth");
  common_scripts\utility::flag_init("second_jump_done_stealth");
  common_scripts\utility::flag_init("final_jump_start_stealth");
  common_scripts\utility::flag_init("floor_clear");
  common_scripts\utility::flag_init("force_jump");
  common_scripts\utility::flag_init("disable_rappel_jump");
  common_scripts\utility::flag_init("player_jumping");
  common_scripts\utility::flag_init("player_pressed_use_button");
  common_scripts\utility::flag_init("start_manage_player_rappel_movement");
  common_scripts\utility::flag_init("stop_manage_player_rappel_movement");
  common_scripts\utility::flag_init("player_allow_rappel_down");
  common_scripts\utility::flag_init("player_moving_down");
  common_scripts\utility::flag_init("laptop_guy_react");
  common_scripts\utility::flag_init("rorke_reached_combat_floor");
  common_scripts\utility::flag_init("baker_reached_combat_floor");
  common_scripts\utility::flag_init("team_ready");
  common_scripts\utility::flag_init("rorke_back");
  common_scripts\utility::flag_init("baker_back");
  common_scripts\utility::flag_init("rorke_is_moving");
  common_scripts\utility::flag_init("baker_is_moving");
  common_scripts\utility::flag_init("stop_anim_move");
  common_scripts\utility::flag_init("rorke_stop_anim_move");
  common_scripts\utility::flag_init("baker_stop_anim_move");
  common_scripts\utility::flag_init("allies_ready_first_combat_floor");
  common_scripts\utility::flag_init("rorke_stealth_broken");
  common_scripts\utility::flag_init("baker_stealth_broken");
  common_scripts\utility::flag_init("stop_look_up_nags");
  common_scripts\utility::flag_init("nag_reset");
  common_scripts\utility::flag_init("nag_timeout_reset");
  common_scripts\utility::flag_init("jump_down_nag_vo");
  common_scripts\utility::flag_init("move_into_building");
  common_scripts\utility::flag_init("intro_vo_done");
  common_scripts\utility::flag_init("shot_at_left_guys");
  common_scripts\utility::flag_init("shot_at_middle_guys");
  common_scripts\utility::flag_init("shot_at_right_guys");
  common_scripts\utility::flag_init("player_shot_in_left_volume");
  common_scripts\utility::flag_init("player_shot_in_middle_volume");
  common_scripts\utility::flag_init("player_shot_in_right_volume");
  common_scripts\utility::flag_init("enemies_on_left_next");
  common_scripts\utility::flag_init("enemies_on_right_next");
  common_scripts\utility::flag_init("enemies_in_middle_next");
  common_scripts\utility::flag_init("allies_stealth_behavior_end");
  common_scripts\utility::flag_init("player_threw_grenade");
  common_scripts\utility::flag_init("all_clear");
  common_scripts\utility::flag_init("first_floor_combat_weapons_free");
  common_scripts\utility::flag_init("first_floor_enemies_dead");
  common_scripts\utility::flag_init("first_floor_patroller_1_in_place");
  common_scripts\utility::flag_init("first_floor_first_enemy_dead");
  common_scripts\utility::flag_init("killed_out_of_order");
  common_scripts\utility::flag_init("first_floor_sitting_laptop_guy_dead");
  common_scripts\utility::flag_init("first_floor_patroller_1_dead");
  common_scripts\utility::flag_init("first_floor_patroller_2_dead");
  common_scripts\utility::flag_init("start_elevator_anims");
  common_scripts\utility::flag_init("elevator_doors_ready_to_open");
  common_scripts\utility::flag_init("elevator_doors_opening");
  common_scripts\utility::flag_init("elevator_doors_open");
  common_scripts\utility::flag_init("elevator_doors_ready_to_close");
  common_scripts\utility::flag_init("elevator_doors_shut");
  common_scripts\utility::flag_init("elevator_gone");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_out_of_elevator");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_out_middle_volume");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_leave_elevator");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_patrol_vo_said");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_heading_to_kitchen");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_in_kitchen");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_alert_node");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_will_be_alerted");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_will_be_alerted_2");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_at_stir_node");
  common_scripts\utility::flag_init("fridge_guy_alerted_or_dead");
  common_scripts\utility::flag_init("second_floor_fridge_guy_killed_too_soon");
  common_scripts\utility::flag_init("second_floor_left_enemies_taken_out");
  common_scripts\utility::flag_init("kitchen_alerted");
  common_scripts\utility::flag_init("poker_table_alerted");
  common_scripts\utility::flag_init("poker_table_spooked");
  common_scripts\utility::flag_init("poker_table_enemy_1_standing");
  common_scripts\utility::flag_init("poker_table_game_continues");
  common_scripts\utility::flag_init("spook_fridge_guy");
  common_scripts\utility::flag_init("second_floor_fridge_guy_spooked");
  common_scripts\utility::flag_init("fridge_guy_leaving_fridge");
  common_scripts\utility::flag_init("second_floor_fridge_guy_start_patrol");
  common_scripts\utility::flag_init("second_floor_fridge_guy_end_patrol");
  common_scripts\utility::flag_init("second_floor_fridge_guy_in_middle_volume");
  common_scripts\utility::flag_init("second_floor_fridge_guy_leaving_kitchen");
  common_scripts\utility::flag_init("second_floor_fridge_guy_will_be_alerted");
  common_scripts\utility::flag_init("take_the_shot_vo");
  common_scripts\utility::flag_init("second_floor_fridge_guy_out_of_middle_volume");
  common_scripts\utility::flag_init("second_floor_enemies_dead");
  common_scripts\utility::flag_init("stealth_broken_vo_said");
  common_scripts\utility::flag_init("second_floor_stealth_broken");
  common_scripts\utility::flag_init("second_floor_fridge_guy_dead");
  common_scripts\utility::flag_init("second_floor_kitchenette_guy_dead");
  common_scripts\utility::flag_init("allies_reached_target_floor");
  precachemodel("bo_p_glo_beer_bottle01_world");
  precachestring(&"CORNERED_RAPPEL_HINT_PC");
  precachestring(&"CORNERED_RAPPEL_HINT_GAMEPAD");
  precachestring(&"CORNERED_RAPPEL_HINT_GAMEPAD_NO_GLYPH");
  precachestring(&"CORNERED_RAPPEL_HINT_GAMEPAD_L");
  precachestring(&"CORNERED_RAPPEL_HINT_GAMEPAD_L_NO_GLYPH");
  precachestring(&"CORNERED_RAPPEL_JUMP");
  maps\_utility::add_hint_string("rappel_movement_pc", &"CORNERED_RAPPEL_HINT_PC", ::should_break_rappel_movement_hint);
  maps\_utility::add_hint_string("rappel_movement_gamepad", &"CORNERED_RAPPEL_HINT_GAMEPAD", ::should_break_rappel_movement_hint);
  maps\_utility::add_hint_string("rappel_movement_gamepad_no_glyph", &"CORNERED_RAPPEL_HINT_GAMEPAD_NO_GLYPH", ::should_break_rappel_movement_hint);
  maps\_utility::add_hint_string("rappel_movement_gamepad_l", &"CORNERED_RAPPEL_HINT_GAMEPAD_L", ::should_break_rappel_movement_hint);
  maps\_utility::add_hint_string("rappel_movement_gamepad_l_no_glyph", &"CORNERED_RAPPEL_HINT_GAMEPAD_L_NO_GLYPH", ::should_break_rappel_movement_hint);
  maps\_utility::add_hint_string("jump", &"CORNERED_RAPPEL_JUMP");
  var_0 = getent("player_rappel_rope_stealth", "targetname");
  var_0 hide();
  level.first_floor_shift_right_trigger = getent("first_floor_shift_right_trigger", "targetname");
  level.first_floor_shift_right_trigger common_scripts\utility::trigger_off();
  level.laptop_destroyed = getent("laptop_sit_react_laptop_destroyed", "targetname");
  level.laptop_destroyed hide();
  level.second_floor_shift_left_trigger = getent("second_floor_shift_left_trigger", "targetname");
  level.second_floor_shift_left_trigger common_scripts\utility::trigger_off();
  level.hide_bink_brush = getent("hide_bink_brush", "targetname");
  level.hide_bink_brush hide();
  common_scripts\utility::flag_init("rappel_stealth_finished");
  level.rappel_rope_rig = undefined;
  level.rappel_max_lateral_dist_right = 300;
  level.rappel_max_lateral_dist_left = 250;
  level.rappel_max_lateral_speed = 9.0;
  level.rappel_max_downward_speed = 4.0;
  level.rappel_max_upward_speed = 3.0;
  var_1 = common_scripts\utility::getstruct("third_combat_floor", "targetname");
  var_2 = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
  var_3 = var_2.origin;
  var_4 = var_2.angles;
  level.rorke_glass_start_org = getstartorigin(var_3, var_4, level.scr_anim["rorke"]["building_entry_rorke"]);
  var_1.origin = (level.rorke_glass_start_org[0], level.rorke_glass_start_org[1], level.rorke_glass_start_org[2]);
}

rappel_ignore_first_two_encounters() {
  return 0;
}

setup_rappel_stealth() {
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  level.rappel_stealth_checkpoint = 1;
  thread maps\cornered_audio::aud_check("rappel_stealth");
  thread rappel_stealth();
  thread maps\cornered_code::delete_window_reflectors();
  level.player thread maps\cornered_code::player_flap_sleeves();
  maps\cornered_lighting::do_specular_sun_lerp(1);
}

begin_rappel_stealth() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  thread maps\cornered_audio::aud_rappel("event1");
  thread maps\cornered_lighting::fireworks_stealth_rappel();
  common_scripts\utility::flag_wait("rappel_stealth_finished");

  if(maps\cornered_code::is_e3())
    thread maps\_utility::autosave_by_name_silent("rappel_stealth");
  else
    thread maps\_utility::autosave_tactical();
}

rappel_stealth() {
  thread handle_rappel_stealth();
  thread rappel_stealth_combat();
  thread allies_rappel_stealth_vo();
  thread maps\cornered_building_entry::building_entry_tv();
  level.ally_zipline_count = 0;
  level.reached_target_floor_count = 0;
  level.allies[level.const_rorke] thread allies_rappel_stealth_anims();
  level.allies[level.const_baker] thread allies_rappel_stealth_anims();
}

handle_rappel_stealth() {
  if(!isDefined(level.zipline_anim_struct))
    level.zipline_anim_struct = common_scripts\utility::getstruct("zipline_anim_struct", "targetname");

  level.player thread maps\cornered_code::unlimited_ammo();
  var_0 = spawnStruct();
  var_0.right_arc = 120;
  var_0.left_arc = 120;
  var_0.top_arc = 60;
  var_0.bottom_arc = 50;
  var_0.allow_walk_up = 1;
  var_0.allow_glass_break_slide = 1;
  var_0.allow_sprint = 1;
  var_0.jump_type = "jump_normal";
  var_0.show_legs = 1;
  var_0.lateral_plane = 1;
  var_0.rappel_type = "stealth";
  level.rappel_params = var_0;
  maps\cornered_code_rappel::cornered_start_rappel("rope_ref_stealth", "player_rappel_ground_ref_stealth", var_0);
  maps\cornered_code_rappel::cornered_start_random_wind();
  level.player thread maps\cornered_code::player_flap_sleeves();

  if(!rappel_ignore_first_two_encounters()) {
    common_scripts\utility::flag_wait("rappel_down_ready");
    level maps\cornered_code::player_move_on_rappel_hint();
    wait 0.5;
    common_scripts\utility::flag_clear("rappel_down_ready");
    common_scripts\utility::flag_set("player_allow_rappel_down");
    thread watch_vertical_limit("first_floor_enemies_dead", "stop_for_first_floor_combat", "stop_at_first_combat_floor_trigger");
    common_scripts\utility::flag_wait_either("stop_for_first_floor_combat", "first_floor_enemies_dead");
    level.rappel_max_lateral_dist_right = 500;
    level.rappel_max_lateral_dist_left = 330;
    common_scripts\utility::flag_wait("rappel_down_ready");
    wait 0.5;
    common_scripts\utility::flag_clear("rappel_down_ready");
    common_scripts\utility::flag_set("player_allow_rappel_down");
    maps\cornered_code_rappel::rappel_clear_vertical_limits();
    thread watch_vertical_limit("second_floor_enemies_dead", "stop_for_second_floor_combat", "stop_at_second_combat_floor_trigger");
    common_scripts\utility::flag_wait_either("stop_for_second_floor_combat", "second_floor_enemies_dead");
  } else {
    level.rappel_max_lateral_dist_right = 500;
    level.rappel_max_lateral_dist_left = 330;
  }

  common_scripts\utility::flag_wait("rappel_down_ready");
  wait 0.5;
  common_scripts\utility::flag_set("player_allow_rappel_down");
  maps\cornered_code_rappel::rappel_clear_vertical_limits();
  common_scripts\utility::flag_wait("stop_for_third_floor_combat");
  var_1 = maps\cornered_code_rappel::rpl_calc_dist_player_to_top(level.rpl, 1);
  maps\cornered_code_rappel::rappel_limit_vertical_move(-85, var_1);
  var_2 = getEntArray("stop_at_third_combat_floor_trigger", "targetname");

  foreach(var_4 in var_2)
  var_4 delete();

  common_scripts\utility::flag_wait("allies_reached_target_floor");
  common_scripts\utility::flag_set("rappel_stealth_finished");
}

should_break_rappel_movement_hint() {
  return common_scripts\utility::flag("player_moved_during_rappel");
}

watch_vertical_limit(var_0, var_1, var_2) {
  level endon(var_0);
  common_scripts\utility::flag_wait(var_1);
  var_3 = maps\cornered_code_rappel::rpl_calc_dist_player_to_top(level.rpl, 1);
  maps\cornered_code_rappel::rappel_limit_vertical_move(-125, var_3);
  var_4 = getEntArray(var_2, "targetname");

  foreach(var_6 in var_4)
  var_6 delete();
}

rappel_stealth_combat() {
  maps\_utility::array_spawn_function_noteworthy("first_floor_patroller_1", ::first_floor_patroller_1_setup);
  maps\_utility::array_spawn_function_noteworthy("first_floor_patroller_2", ::first_floor_patroller_2_setup);
  maps\_utility::array_spawn_function_noteworthy("first_floor_sitting_laptop_guy", ::first_floor_sitting_laptop_guy_setup);
  maps\_utility::array_spawn_function_targetname("second_floor_enemies_poker_table", ::second_floor_poker_table_guys_setup);
  maps\_utility::array_spawn_function_noteworthy("second_floor_fridge_guy", ::second_floor_fridge_guy_setup);
  maps\_utility::array_spawn_function_noteworthy("second_floor_kitchenette_guy", ::second_floor_kitchenette_guy_setup);
  maps\_utility::array_spawn_function_noteworthy("second_floor_elevator_guy_1", ::second_floor_elevator_guy_setup);
  maps\_utility::array_spawn_function_noteworthy("second_floor_elevator_guy_2", ::second_floor_elevator_guy_setup);

  if(!rappel_ignore_first_two_encounters()) {
    level.first_floor_combat_enemies_right = [];
    common_scripts\utility::flag_wait("empty_floor_1");
    var_0 = maps\_utility::array_spawn_targetname("first_floor_enemies", 1);
    thread allies_help_when_player_shoots_first_floor();
    thread maps\cornered_code::check_ai_array_for_death(var_0, "first_floor_enemies_dead");
    common_scripts\utility::flag_wait("first_floor_enemies_dead");
    common_scripts\utility::flag_clear("enemies_aware");
    common_scripts\utility::flag_clear("player_shot_in_right_volume");
    level.second_floor_anim_struct = common_scripts\utility::getstruct("second_floor_anim_struct", "targetname");
    level.second_floor_left_enemies = [];
    level.second_floor_middle_enemies = [];
    var_1 = maps\_utility::array_spawn_targetname("second_floor_enemies", 1);
    var_2 = maps\_utility::array_spawn_targetname("second_floor_enemies_poker_table", 1);
    level.second_floor_enemies = common_scripts\utility::array_combine(var_1, var_2);
    thread open_elevator_doors();
    thread allies_help_when_player_shoots_second_floor_left();
    thread allies_help_when_player_shoots_second_floor_middle_or_right();
    thread maps\cornered_code::check_ai_array_for_death(level.second_floor_enemies, "second_floor_enemies_dead");
    common_scripts\utility::flag_wait("second_floor_enemies_dead");
    common_scripts\utility::flag_clear("enemies_aware");
    common_scripts\utility::flag_clear("intro_vo_done");
    common_scripts\utility::flag_clear("shot_at_left_guys");
    common_scripts\utility::flag_clear("shot_at_middle_guys");
    common_scripts\utility::flag_clear("shot_at_right_guys");
    common_scripts\utility::flag_clear("player_shot_in_left_volume");
    common_scripts\utility::flag_clear("player_shot_in_middle_volume");
    common_scripts\utility::flag_clear("player_shot_in_right_volume");
    common_scripts\utility::flag_clear("enemies_on_left_next");
    common_scripts\utility::flag_clear("stealth_broken_vo_said");
  }
}

#using_animtree("generic_human");

first_floor_sitting_laptop_guy_setup() {
  self endon("death");
  var_0 = getent("rappel_stealth_tv_script_brushmodel", "targetname");
  thread maps\cornered_code::watch_tv_for_damage(var_0, "player_jumped_into_building", 1);
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.noragdoll = 1;
  self.health = 50;
  self.deathanim = % cnd_rappel_stealth_chair_death_rear;
  childthread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  childthread maps\cornered_code::alert_all();
  self.struct = common_scripts\utility::getstruct(self.script_noteworthy + "_struct", "targetname");
  self.struct thread maps\_anim::anim_loop_solo(self, "laptop_sit_idle_calm", "stop_loop");
  thread first_floor_sitting_laptop_guy_react();
}

first_floor_sitting_laptop_guy_react() {
  self endon("death");
  var_0 = maps\_utility::spawn_anim_model("laptop_sit_react_props");
  var_0 thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_1 = maps\_utility::spawn_anim_model("laptop_sit_react_props");
  var_1 thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_2 = getent("laptop_sit_react_chair", "targetname");
  var_2 thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_3 = getent("laptop_sit_react_laptop", "targetname");
  var_3 setCanDamage(1);
  var_3 thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_3 thread watch_for_damage();
  level.laptop_destroyed thread maps\cornered_code::entity_cleanup("player_entering_building");
  self.struct maps\_anim::anim_first_frame_solo(var_0, "laptop_sit_react");
  self.struct maps\_anim::anim_first_frame_solo(var_1, "laptop_sit_react");
  var_2 linkto(var_0, "J_prop_1");
  var_3 linkto(var_1, "J_prop_2");
  level.laptop_destroyed linkto(var_1, "J_prop_2");
  level.laptop_hdr = getent("laptop_hdr", "targetname");
  var_4 = var_3 common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_1, "J_prop_2");
  level.laptop_hdr linkto(var_4, "tag_origin");
  level.laptop_hdr thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_4 thread maps\cornered_code::entity_cleanup("player_entering_building");
  var_5 = [];
  var_5[0] = self;
  var_5[1] = var_0;
  self waittill("enemy_aware");
  common_scripts\utility::flag_set("laptop_guy_react");
  thread first_floor_sitting_laptop_guy_react_laptop(var_1);
  maps\_utility::clear_deathanim();
  self.struct thread maps\_anim::anim_single(var_5, "laptop_sit_react");
  wait 2.5;
  self.allowdeath = 0;
  wait 1.0;
  self.allowdeath = 1;
  self waittillmatch("single anim", "end");
  maps\_utility::disable_surprise();
  self.disablebulletwhizbyreaction = 1;
  self.disablereactionanims = 1;
  self.ignoreall = 0;
  self.noragdoll = 0;
  self.struct notify("stop_loop");
  waittillframeend;
  maps\_utility::anim_stopanimscripted();
}

watch_for_damage() {
  self waittill("damage");
  self hide();
  level.laptop_hdr hide();
  level.laptop_destroyed show();
  playFXOnTag(level._effect["powerlines_c"], level.laptop_destroyed, "tag_fx");
}

first_floor_sitting_laptop_guy_react_laptop(var_0) {
  wait 2.25;

  if(isalive(self))
    self.struct maps\_anim::anim_single_solo(var_0, "laptop_sit_react_laptop");
}

first_floor_patroller_1_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.health = 50;
  self.patrol_walk_anim = "active_patrolwalk_gundown";
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread maps\cornered_code::alert_all();
  thread watch_patrollers("first_floor_patroller_2_dead");
  level.first_floor_combat_enemies_right = common_scripts\utility::add_to_array(level.first_floor_combat_enemies_right, self);
  thread two_guys_talking_patrol();
  self waittill("enemy_aware");

  if(common_scripts\utility::flag("first_floor_patroller_1_in_place")) {
    self notify("stop_loop");
    thread maps\_anim::anim_single_solo(self, "so_hijack_texting_reaction");
    wait 0.5;

    if(isDefined(level.enemy_patrol_phone))
      level.enemy_patrol_phone delete();

    self waittillmatch("single anim", "end");
  } else
    thread maps\_anim::anim_single_solo(self, "patrol_react");

  self.ignoreall = 0;

  if(!common_scripts\utility::flag("enemies_aware"))
    common_scripts\utility::flag_set("enemies_aware");
}

first_floor_patroller_2_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.health = 50;
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread maps\cornered_code::alert_all();
  thread watch_patrollers("first_floor_patroller_1_dead");
  level.first_floor_combat_enemies_right = common_scripts\utility::add_to_array(level.first_floor_combat_enemies_right, self);
  thread two_guys_talking_patrol();
  self waittill("enemy_aware");

  if(isDefined(self.struct))
    self.struct notify("stop_loop");
  else
    self notify("stop_loop");

  waittillframeend;
  maps\_utility::anim_stopanimscripted();
  maps\_anim::anim_single_solo(self, "exposed_idle_reactA");
  self.ignoreall = 0;

  if(!common_scripts\utility::flag("enemies_aware"))
    common_scripts\utility::flag_set("enemies_aware");
}

watch_patrollers(var_0) {
  self endon("death");
  level endon("enemies_aware");
  common_scripts\utility::flag_wait(var_0);
  self notify("enemy_aware");
}

two_guys_talking_patrol() {
  self endon("death");
  self endon("enemy_aware");
  level endon("enemies_aware");

  if(self.script_noteworthy == "first_floor_patroller_1") {
    common_scripts\utility::flag_wait("first_floor_patroller_1_in_place");
    level.enemy_patrol_phone = spawn("script_model", (0, 0, 0));
    level.enemy_patrol_phone linkto(self, "tag_inhand", (0, -1, 0), (0, 0, 0));
    level.enemy_patrol_phone setModel("cnd_cellphone_01_off_anim");
    thread maps\_anim::anim_loop_solo(self, "so_hijack_search_texting_loop", "stop_loop");
  } else {
    self.struct = common_scripts\utility::getstruct("first_floor_patrol_talking_struct", "targetname");
    self.struct thread maps\_anim::anim_loop_solo(self, "first_floor_patroller_2", "stop_loop");
  }
}

allies_help_when_player_shoots_first_floor() {
  common_scripts\utility::flag_wait("first_floor_shift_right");
  var_0 = level.allies[level.const_rorke];
  var_0.start_aiming_after_move = 1;
  var_0 maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(1);
  common_scripts\utility::waitframe();

  if(var_0 maps\cornered_code_rappel_allies::ally_is_calm_idling()) {
    var_0 maps\cornered_code_rappel_allies::ally_stop_calm_idle();
    var_0 maps\cornered_code_rappel_allies::ally_rappel_start_aiming("stealth");
  }

  if(common_scripts\utility::flag("first_floor_combat_weapons_free")) {
    var_1 = getent("first_floor_right_volume_player", "targetname");
    level.player thread maps\cornered_code::watch_for_player_to_shoot_while_in_volume(var_1, "player_shot_in_right_volume", "first_floor_enemies_dead");
    thread maps\cornered_code::waittill_dead_set_flag(level.first_floor_combat_enemies_right, "player_shot_in_right_volume", "first_floor_enemies_dead");
    level.player maps\cornered_code::coordinated_kills(var_0, level.first_floor_combat_enemies_right, "player_shot_in_right_volume", "first_floor_enemies_dead");
    var_0 maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
    var_0 maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(0);
    var_0 maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
  }
}

open_elevator_doors() {
  var_0 = getEntArray("rappel_stealth_elevator_doors", "targetname");
  var_1 = getent("elevator_door_clip_right", "targetname");
  var_2 = getent("elevator_door_clip_left", "targetname");
  level.door_shut_x = 0;
  level.door_open_x = 0;

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == "right") {
      level.door_shut_x = var_4.origin[0];
      level.door_open_x = var_4.origin[0] + 58;
    }
  }

  common_scripts\utility::flag_wait("elevator_doors_ready_to_open");

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == "right") {
      var_1 linkto(var_4);
      var_4 moveto(var_4.origin + (58, 0, 0), 2.5, 0.5, 0.5);
      var_1 connectpaths();
      continue;
    }

    var_2 linkto(var_4);
    var_4 moveto(var_4.origin + (-58, 0, 0), 2.5, 0.5, 0.5);
    var_2 connectpaths();
  }

  wait 2;
  common_scripts\utility::flag_set("elevator_doors_open");
  common_scripts\utility::flag_wait_all("elevator_doors_ready_to_close", "second_floor_kitchenette_guy_out_of_elevator");
  wait 1;
  thread open_elevator_doors_if_stealth_broken(var_0, var_1, var_2);
  thread close_elevator_doors(var_0, var_1, var_2);
}

close_elevator_doors(var_0, var_1, var_2) {
  level endon("second_floor_stealth_broken");

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == "right") {
      var_4 moveto(var_4.origin + (-58, 0, 0), 2.5, 0.5, 0.5);
      continue;
    }

    var_4 moveto(var_4.origin + (58, 0, 0), 2.5, 0.5, 0.5);
  }

  wait 1.5;
  var_1 disconnectpaths();
  var_2 disconnectpaths();
  wait 1.5;
  common_scripts\utility::flag_set("elevator_doors_shut");
  wait 3;
  common_scripts\utility::flag_set("elevator_gone");
}

open_elevator_doors_if_stealth_broken(var_0, var_1, var_2) {
  level endon("elevator_gone");
  common_scripts\utility::flag_wait("second_floor_stealth_broken");
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(var_6.script_noteworthy == "right") {
      level.door_current_x = var_6.origin[0];
      var_3 = level.door_open_x - level.door_current_x;
    }
  }

  foreach(var_6 in var_0) {
    if(var_6.script_noteworthy == "right") {
      var_6 moveto(var_6.origin + (var_3, 0, 0), 2);
      continue;
    }

    var_6 moveto(var_6.origin + (var_3 * -1, 0, 0), 2);
  }

  wait 2;
  var_1 connectpaths();
  var_2 connectpaths();
}

second_floor_poker_table_guys_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.noragdoll = 1;
  self.health = 50;
  level.second_floor_middle_enemies = common_scripts\utility::add_to_array(level.second_floor_middle_enemies, self);

  if(self.script_noteworthy == "enemy_1") {
    self.struct = common_scripts\utility::getstruct("enemy_1", "targetname");
    self.animation = "enemy_1_cards_idle";
    self.interruptedanim = "enemy_1_cards_interrupted";
    self.reactanim = "enemy_1_cards_alert";
    self.deathanim = % cnd_rappel_stealth_chair_death_right;
    thread chair_death_right();
  }

  if(self.script_noteworthy == "enemy_2") {
    self.struct = common_scripts\utility::getstruct("enemy_2", "targetname");
    self.animation = "enemy_2_cards_idle";
    self.interruptedanim = "enemy_2_cards_interrupted";
    self.reactanim = "enemy_2_cards_alert";
    self.deathanim = % cnd_rappel_stealth_chair_death_rear;
  }

  if(self.script_noteworthy == "enemy_3") {
    self.struct = common_scripts\utility::getstruct("enemy_3", "targetname");
    self.animation = "enemy_3_cards_idle";
    self.interruptedanim = "enemy_3_cards_interrupted";
    self.reactanim = "enemy_3_cards_alert";
    self.deathanim = % cnd_rappel_stealth_chair_death_left_1;
  }

  self.struct thread maps\_anim::anim_loop_solo(self, self.animation, "stop_loop");
  thread enemy_poker_cards();
  thread poker_table_spooked();
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread handle_alerted();
  thread maps\cornered_code::alert_all("poker_table_alerted", "second_floor_stealth_broken");
  self.volume = getent("second_floor_middle_volume", "targetname");
  thread maps\cornered_code::watch_for_death_and_alert_all_in_volume();
  self waittill("enemy_aware");
  self.noragdoll = 0;
  maps\_utility::clear_deathanim();

  if(!common_scripts\utility::flag("poker_table_alerted"))
    common_scripts\utility::flag_set("poker_table_alerted");
}

enemy_poker_cards() {
  var_0 = self gettagorigin("j_index_ri_3");
  var_1 = getent(self.script_noteworthy + "_card_1", "script_noteworthy");
  var_2 = getent(self.script_noteworthy + "_card_2", "script_noteworthy");
  var_1.origin = var_0;
  var_2.origin = var_0;

  if(self.script_noteworthy == "enemy_1") {
    var_1 linkto(self, "j_index_le_3", (1, 2, 0), (90, 270, 5));
    var_2 linkto(self, "j_index_le_3", (1, 2, 0), (90, 270, 5));
  } else {
    var_1 linkto(self, "j_index_ri_3", (1, 2, 0), (90, 270, 5));
    var_2 linkto(self, "j_index_ri_3", (1, 2, 0), (90, 270, 5));
  }

  if(self.script_noteworthy == "enemy_1")
    thread enemy1_spooked_drop_poker_cards(var_1, var_2);

  thread enemy_drop_poker_cards(var_1, var_2);
}

enemy1_spooked_drop_poker_cards(var_0, var_1) {
  self endon("enemy_aware");
  self endon("damage");
  self endon("death");
  common_scripts\utility::flag_wait("poker_table_spooked");
  var_0 delete();
  var_1 delete();
}

enemy_drop_poker_cards(var_0, var_1) {
  common_scripts\utility::waittill_any("enemy_aware", "damage", "death");

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();

  playFXOnTag(level._effect["vfx_playing_cards_burst"], self, "j_index_ri_3");
}

poker_table_spooked() {
  self endon("death");
  self endon("enemy_aware");
  level endon("enemies_aware");
  level endon("second_floor_enemies_dead");
  common_scripts\utility::flag_wait_any("player_shot_in_left_volume", "second_floor_left_enemies_taken_out");
  maps\_utility::delaythread(1, common_scripts\utility::flag_set, "poker_table_spooked");
  var_0 = getent("second_floor_left_volume_player", "targetname");

  while(level.player istouching(var_0))
    common_scripts\utility::waitframe();

  var_1 = common_scripts\utility::getstruct("enemy_2", "targetname");
  maps\cornered_code::waittill_player_looking_at_ent(var_1, 10);
  self.struct notify("stop_loop");
  waittillframeend;
  maps\_utility::anim_stopanimscripted();

  if(self.script_noteworthy == "enemy_1") {
    self.struct thread maps\_anim::anim_single_solo(self, self.interruptedanim);
    common_scripts\utility::flag_wait("poker_table_enemy_1_standing");
    self.reactanim = undefined;
    maps\_utility::clear_deathanim();
    common_scripts\utility::flag_waitopen("poker_table_enemy_1_standing");
    self.reactanim = "enemy_1_cards_alert";
    self.deathanim = % cnd_rappel_stealth_chair_death_right;
    self waittillmatch("single anim", "end");
    self.struct thread maps\_anim::anim_loop_solo(self, self.animation, "stop_loop");
  } else {
    self.struct maps\_anim::anim_single_solo(self, self.interruptedanim);
    self.struct thread maps\_anim::anim_loop_solo(self, self.animation, "stop_loop");
  }
}

chair_death_right() {
  self endon("enemy_aware");
  self waittill("death");

  if(common_scripts\utility::flag("poker_table_enemy_1_standing")) {
    return;
  }
  var_0 = getent("chair_death_right", "targetname");
  var_0.animname = "chair";
  var_0 maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_single_solo(var_0, "chair_death_right");
}

enemy_1_standing(var_0) {
  common_scripts\utility::flag_set("poker_table_enemy_1_standing");
}

enemy_1_sitting(var_0) {
  common_scripts\utility::flag_clear("poker_table_enemy_1_standing");
  common_scripts\utility::flag_set("poker_table_game_continues");
}

second_floor_fridge_guy_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.health = 50;
  self.patrol_walk_anim = "cornered_stealth_loop_fridge_guy";
  self.patrol_no_stop_transition = 1;
  level.second_floor_left_enemies = common_scripts\utility::add_to_array(level.second_floor_left_enemies, self);
  thread fridge_anims();
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread maps\cornered_code::alert_all("second_floor_stealth_broken");
  self.volume = getent("second_floor_left_volume", "targetname");
  thread maps\cornered_code::watch_for_death_and_alert_all_in_volume("second_floor_fridge_guy_out_of_middle_volume");
  self waittill("enemy_aware");

  if(common_scripts\utility::flag("second_floor_kitchenette_guy_in_kitchen")) {
    if(!common_scripts\utility::flag("kitchen_alerted"))
      common_scripts\utility::flag_set("kitchen_alerted");
  }
}

fridge_anims() {
  self endon("death");
  var_0 = getent("fridge", "targetname");
  var_0.animname = "fridge";
  var_0 maps\_anim::setanimtree();
  thread handle_beer_bottles();
  level.guy_fridge_beers[0] = self;
  level.guy_fridge_beers[1] = var_0;
  level.second_floor_anim_struct thread maps\_anim::anim_first_frame_solo(level.guy_fridge_beers[1], "cornered_stealth_fridge_anims");
  thread fridge_guy_alerted();
  thread second_floor_fridge_guy_path();
  var_1 = common_scripts\utility::getstruct("second_floor_fridge_guy_start_patrol", "targetname");
  var_1 waittill("trigger");
  waittillframeend;
  level.second_floor_anim_struct thread maps\_anim::anim_loop_solo(self, "fridge_idle", "stop_loop");
}

second_floor_fridge_guy_path() {
  self endon("death");
  self endon("enemy_aware");
  self endon("enemy_spooked");
  self.skip_start_transition = 1;
  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_at_stir_node");
  common_scripts\utility::flag_wait("second_floor_shift_left");
  level.second_floor_anim_struct notify("stop_loop");
  waittillframeend;
  self stopanimscripted();
  common_scripts\utility::flag_set("fridge_guy_leaving_fridge");
  level.second_floor_anim_struct maps\_anim::anim_single(level.guy_fridge_beers, "cornered_stealth_fridge_anims");
  common_scripts\utility::flag_set("second_floor_fridge_guy_start_patrol");
  self.reactanim = "patrol_react";
  self.patrol_no_stop_transition = undefined;
  common_scripts\utility::flag_wait("second_floor_fridge_guy_leaving_kitchen");

  if(common_scripts\utility::flag("second_floor_poker_guys_dead"))
    common_scripts\utility::flag_set("second_floor_fridge_guy_will_be_alerted");
  else {
    var_0 = getent(self.volume.targetname + "_player", "targetname");

    if(level.player istouching(var_0))
      common_scripts\utility::flag_set("take_the_shot_vo");
  }

  common_scripts\utility::flag_wait("second_floor_fridge_guy_in_middle_volume");
  self.volume = getent("second_floor_middle_volume", "targetname");

  if(common_scripts\utility::flag("second_floor_poker_guys_dead")) {
    thread second_floor_fridge_guy_spooked();
    common_scripts\utility::flag_set("second_floor_fridge_guy_spooked");
  } else {
    common_scripts\utility::flag_wait("second_floor_fridge_guy_end_patrol");
    self delete();
  }
}

fridge_light_off(var_0) {
  var_1 = getEntArray("rappel_stealth_fridge_light", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0.1);
}

second_floor_fridge_guy_spooked() {
  self endon("death");
  self endon("enemy_aware");
  self notify("end_patrol");
  maps\_utility::clear_run_anim();
  maps\_utility::set_run_anim("cqb_walk");
  self.patrol_walk_anim = "cqb_walk";
  maps\_utility::set_moveplaybackrate(0.5);
  var_0 = common_scripts\utility::getstruct("second_floor_fridge_guy_middle_spook_patrol_start", "targetname");
  self.target = var_0.targetname;
  thread maps\_patrol::patrol(self.target);
  common_scripts\utility::flag_wait("second_floor_fridge_guy_middle_spook_patrol_end");
  thread maps\_anim::anim_loop_solo(self, "stationary_look_around", "stop_loop");
  wait(randomfloatrange(1.0, 2.5));
  self notify("stop_loop");
  waittillframeend;
  common_scripts\utility::flag_set("enemies_aware");
}

fridge_guy_alerted() {
  self endon("enemy_spooked");
  common_scripts\utility::waittill_any("enemy_aware", "death");
  common_scripts\utility::flag_set("fridge_guy_alerted_or_dead");

  if(isalive(self)) {
    if(common_scripts\utility::flag("fridge_guy_leaving_fridge") && !common_scripts\utility::flag("second_floor_fridge_guy_start_patrol")) {
      level.second_floor_anim_struct notify("stop_loop");
      waittillframeend;
      self stopanimscripted();
      level.guy_fridge_beers[1] stopanimscripted();
      self.ignoreall = 0;
    } else if(common_scripts\utility::flag("fridge_guy_leaving_fridge") && common_scripts\utility::flag("second_floor_fridge_guy_start_patrol")) {
      self notify("end_patrol");
      self.ignoreall = 0;
    } else if(!common_scripts\utility::flag("fridge_guy_leaving_fridge")) {
      level.second_floor_anim_struct notify("stop_loop");
      waittillframeend;
      self stopanimscripted();
      level.guy_fridge_beers[1] maps\_anim::anim_single_solo(self, "fridge_react");
      self.ignoreall = 0;
    }
  }
}

handle_beer_bottles() {
  var_0 = [];
  var_0[0] = spawn("script_model", (0, 0, 0));
  var_0[0] setModel("bo_p_glo_beer_bottle01_world");
  var_0[0] linkto(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  var_0[1] = spawn("script_model", (0, 0, 0));
  var_0[1] setModel("bo_p_glo_beer_bottle01_world");
  var_0[1] linkto(self, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  var_0[2] = spawn("script_model", (0, 0, 0));
  var_0[2] setModel("bo_p_glo_beer_bottle01_world");
  var_0[2] linkto(self, "tag_stowed_back", (0, 0, 0), (0, 0, 0));
  var_0[3] = spawn("script_model", (0, 0, 0));
  var_0[3] setModel("bo_p_glo_beer_bottle01_world");
  var_0[3] linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_0[4] = spawn("script_model", (0, 0, 0));
  var_0[4] setModel("bo_p_glo_beer_bottle01_world");
  var_0[4] linkto(self, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_wait_any("fridge_guy_alerted_or_dead", "second_floor_fridge_guy_end_patrol", "second_floor_fridge_guy_spooked");

  if(common_scripts\utility::flag("second_floor_fridge_guy_end_patrol")) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2))
        var_2 delete();
    }
  } else {
    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        var_2 unlink();
        var_2 physicslaunchclient(self.origin + (0, 0, 2), (0, 0, -10));
      }
    }

    common_scripts\utility::flag_wait("stop_for_third_floor_combat");

    foreach(var_2 in var_0) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }
}

second_floor_kitchenette_guy_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.diequietly = 1;
  self.health = 50;
  self.patrol_walk_anim = "active_patrolwalk_gundown";
  maps\_utility::disable_pain();
  maps\_utility::disable_surprise();
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::set_ignoresuppression(1);
  level.second_floor_left_enemies = common_scripts\utility::add_to_array(level.second_floor_left_enemies, self);
  thread second_floor_kitchenette_guy();
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread handle_alerted();
  thread maps\cornered_code::alert_all("second_floor_stealth_broken");
  var_0 = getent("elevator_volume", "targetname");
  thread watch_while_in_volume_and_set_flag_when_out(var_0, "second_floor_kitchenette_guy_out_of_elevator");
  common_scripts\utility::flag_wait_all("elevator_doors_open", "second_floor_combat_vo");
  common_scripts\utility::flag_set("second_floor_kitchenette_guy_leave_elevator");
  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_out_of_elevator");
  self.reactanim = "patrol_react";
  maps\_utility::enable_pain();
  maps\_utility::enable_surprise();
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::set_ignoresuppression(0);
  var_0 = getent("second_floor_middle_volume", "targetname");
  thread watch_while_in_volume_and_set_flag_when_out(var_0, "second_floor_kitchenette_guy_out_middle_volume");
  self.volume = getent("second_floor_middle_volume", "targetname");
  thread maps\cornered_code::watch_for_death_and_alert_all_in_volume("second_floor_kitchenette_guy_out_middle_volume");
  var_0 = getent("second_floor_left_volume", "targetname");
  self.volume = getent("second_floor_left_volume", "targetname");
  thread maps\cornered_code::watch_for_death_and_alert_all_in_volume("intro_vo_done");
  self waittill("enemy_aware");

  if(common_scripts\utility::flag("second_floor_kitchenette_guy_in_kitchen")) {
    if(!common_scripts\utility::flag("kitchen_alerted"))
      common_scripts\utility::flag_set("kitchen_alerted");
  }

  if(common_scripts\utility::flag("second_floor_kitchenette_guy_at_stir_node")) {
    if(isDefined(level.enemy_patrol_phone))
      level.enemy_patrol_phone delete();
  }
}

second_floor_kitchenette_guy() {
  self endon("death");
  self endon("enemy_aware");
  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_heading_to_kitchen");

  if(common_scripts\utility::flag("second_floor_fridge_guy_dead"))
    common_scripts\utility::flag_set("second_floor_kitchenette_guy_will_be_alerted");

  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_in_kitchen");

  if(common_scripts\utility::flag("second_floor_fridge_guy_dead"))
    common_scripts\utility::flag_set("second_floor_kitchenette_guy_will_be_alerted_2");

  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_alert_node");

  if(common_scripts\utility::flag("second_floor_fridge_guy_dead"))
    thread kitchenette_guy_spooked();
  else
    thread kitchenette_guy_continue();
}

kitchenette_guy_spooked() {
  self endon("death");
  self endon("enemy_aware");
  thread maps\_anim::anim_loop_solo(self, "stationary_look_around", "stop_loop");
  wait(randomfloatrange(2.0, 3.5));
  self notify("stop_loop");
  waittillframeend;
  self notify("end_patrol");
  self notify("enemy_aware");
}

kitchenette_guy_continue() {
  self endon("death");
  self endon("enemy_aware");
  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_at_stir_node");
  self.reactanim = "patrol_bored_react_look_retreat";
  level.enemy_patrol_phone = spawn("script_model", (0, 0, 0));
  level.enemy_patrol_phone linkto(self, "tag_inhand", (0, 1, 0), (0, 0, 0));
  level.enemy_patrol_phone setModel("cnd_cellphone_01_off_anim");
  thread maps\_anim::anim_loop_solo(self, "patrol_bored_idle_cellphone", "stop_loop");
}

second_floor_elevator_guy_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.deathanim = % exposed_death;
  thread maps\cornered_code::wait_till_shot("enemies_aware", "second_floor_stealth_broken", "enemy_aware");
  thread maps\cornered_code::alert_all("second_floor_stealth_broken");
  thread elevator_guys_react();

  if(self.script_noteworthy == "second_floor_elevator_guy_1")
    thread elevator_anims("cornered_stealth_elevator_enemy1");
  else
    thread elevator_anims("cornered_stealth_elevator_enemy2");
}

elevator_anims(var_0) {
  self endon("death");
  self endon("enemy_aware");
  level.second_floor_anim_struct maps\_anim::anim_first_frame_solo(self, var_0);
  common_scripts\utility::flag_wait("start_elevator_anims");
  level.second_floor_anim_struct thread maps\_anim::anim_single_solo(self, var_0);
  wait 0.05;
  maps\_anim::anim_self_set_time(var_0, 0.4);
  common_scripts\utility::flag_wait("elevator_gone");
  self delete();
}

elevator_door_close(var_0) {
  common_scripts\utility::flag_set("elevator_doors_ready_to_close");
}

elevator_guys_react() {
  self endon("death");
  self waittill("enemy_aware");
  self stopanimscripted();
  self.ignoreall = 0;
  var_0 = getent("second_floor_middle_volume", "targetname");
  self setgoalvolumeauto(var_0);
}

allies_help_when_player_shoots_second_floor_left() {
  level endon("second_floor_fridge_guy_in_middle_volume");
  level endon("second_floor_fridge_guy_killed_too_soon");
  level endon("second_floor_stealth_broken");
  common_scripts\utility::flag_wait("second_floor_kitchenette_guy_out_middle_volume");
  common_scripts\utility::flag_wait("second_floor_shift_left");
  var_0 = level.allies[level.const_baker];
  var_0.start_aiming_after_move = 1;
  var_0 maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(1);
  common_scripts\utility::waitframe();

  if(var_0 maps\cornered_code_rappel_allies::ally_is_calm_idling()) {
    var_0 maps\cornered_code_rappel_allies::ally_stop_calm_idle();
    var_0 maps\cornered_code_rappel_allies::ally_rappel_start_aiming("stealth");
  }

  var_0 thread ally_reset_second_floor_left();
  var_1 = getent("second_floor_left_volume_player", "targetname");
  level.player thread maps\cornered_code::watch_for_player_to_shoot_while_in_volume(var_1, "player_shot_in_left_volume", "second_floor_enemies_dead");
  childthread maps\cornered_code::waittill_dead_set_flag(level.second_floor_left_enemies, "player_shot_in_left_volume", "second_floor_enemies_dead");
  level.player maps\cornered_code::coordinated_kills(level.allies[level.const_baker], level.second_floor_left_enemies, "player_shot_in_left_volume", "second_floor_enemies_dead", "shot_at_left_guys");
}

ally_reset_second_floor_left() {
  common_scripts\utility::flag_wait_any("second_floor_fridge_guy_in_middle_volume", "second_floor_fridge_guy_killed_too_soon", "second_floor_stealth_broken", "second_floor_enemies_dead");
  maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(0);
  maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
}

allies_help_when_player_shoots_second_floor_middle_or_right() {
  level endon("second_floor_stealth_broken");
  var_0 = level.allies[level.const_rorke];
  common_scripts\utility::flag_wait("intro_vo_done");
  common_scripts\utility::flag_waitopen("rorke_is_moving");
  var_0 = level.allies[level.const_rorke];

  while(!var_0 maps\cornered_code::ally_can_see_any_enemy() && !common_scripts\utility::flag("second_floor_enemies_dead")) {
    var_0.move_to_see_enemies = 1;
    var_0.start_aiming_after_move = 1;
    var_0 waittill("aim_after_move");
  }

  if(common_scripts\utility::flag("second_floor_enemies_dead")) {
    return;
  }
  var_0 maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(1);
  common_scripts\utility::waitframe();

  if(var_0 maps\cornered_code_rappel_allies::ally_is_calm_idling()) {
    var_0 maps\cornered_code_rappel_allies::ally_stop_calm_idle();
    var_0 maps\cornered_code_rappel_allies::ally_rappel_start_aiming("stealth");
  }

  var_0 thread ally_reset_second_floor_right();
  var_1 = getent("second_floor_middle_volume_player", "targetname");
  level.player childthread maps\cornered_code::watch_for_player_to_shoot_while_in_volume(var_1, "player_shot_in_middle_volume", "second_floor_enemies_dead");
  var_1 = getent("second_floor_right_volume_player", "targetname");
  level.player childthread maps\cornered_code::watch_for_player_to_shoot_while_in_volume(var_1, "player_shot_in_middle_volume", "second_floor_enemies_dead");
  childthread maps\cornered_code::waittill_dead_set_flag(level.second_floor_middle_enemies, "player_shot_in_middle_volume", "second_floor_enemies_dead");
  level.player childthread maps\cornered_code::coordinated_kills(level.allies[level.const_rorke], level.second_floor_middle_enemies, "player_shot_in_middle_volume", "second_floor_enemies_dead", "shot_at_middle_guys");
}

ally_reset_second_floor_right() {
  common_scripts\utility::flag_wait_any("second_floor_stealth_broken", "second_floor_enemies_dead");
  maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
}

watch_while_in_volume_and_set_flag_when_out(var_0, var_1) {
  self endon("death");
  var_2 = undefined;

  for(;;) {
    if(self istouching(var_0) && !isDefined(var_2))
      var_2 = 1;

    if(!self istouching(var_0) && isDefined(var_2) && var_2 == 1)
      var_2 = 0;

    if(isDefined(var_2) && var_2 == 0) {
      common_scripts\utility::flag_set(var_1);
      break;
    }

    wait 0.05;
  }
}

handle_alerted(var_0) {
  self endon("death");
  self waittill("enemy_aware");

  if(isDefined(var_0)) {
    if(!common_scripts\utility::flag(var_0))
      common_scripts\utility::flag_set(var_0);
  }

  if(isDefined(self.struct)) {
    self.struct notify("stop_loop");
    waittillframeend;
    self stopanimscripted();
    self.favoriteenemy = level.player;
  } else {
    self notify("stop_loop");
    waittillframeend;
    self stopanimscripted();
    self.favoriteenemy = level.player;
  }

  if(isDefined(self.reactanim))
    maps\_anim::anim_single_solo(self, self.reactanim);

  if(isDefined(self.weapon_removed))
    maps\_utility::gun_recall();

  self.ignoreall = 0;
}

allies_rappel_stealth_vo() {
  level endon("rorke_killed");
  level endon("rorke_killed_2");
  level endon("baker_killed");

  if(isDefined(level.rappel_stealth_checkpoint)) {
    wait 0.25;
    common_scripts\utility::flag_wait("rappel_down_ready");
  } else
    wait 4;

  level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_linessecureletsmove");

  if(!isDefined(level.rappel_stealth_checkpoint))
    common_scripts\utility::flag_wait("rappel_down_ready");

  var_0 = maps\_utility::make_array("cornered_hsh_letsheaddownbro", "cornered_mrk_comeondropdown");
  thread maps\cornered_code::nag_until_flag(var_0, "approaching_first_combat_floor", 10, 15, 5);

  if(!rappel_ignore_first_two_encounters()) {
    common_scripts\utility::flag_wait("approaching_first_combat_floor");
    thread rappel_stealth_first_floor_combat_vo();
    thread rappel_stealth_first_floor_combat_stealth_broken_vo();
    thread first_floor_enemies_shot_out_of_order();
    common_scripts\utility::flag_wait("first_floor_enemies_dead");

    if(common_scripts\utility::flag("first_floor_combat_weapons_free") && !common_scripts\utility::flag("enemies_aware")) {
      wait 1.0;
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_targetsdownwereclear");
      wait 0.5;
    } else {
      wait 1.0;
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_targetsdownwereclear");
      wait 0.5;
      common_scripts\utility::flag_wait("allies_stealth_behavior_end");
      common_scripts\utility::flag_clear("allies_stealth_behavior_end");
    }

    level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_movetothenext");
    common_scripts\utility::flag_set("rappel_down_ready");

    if(maps\cornered_code::is_e3())
      thread maps\_utility::autosave_now_silent();
    else
      thread maps\_utility::autosave_now();

    wait 0.5;
    common_scripts\utility::flag_wait("approaching_second_floor_combat");
    level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_hsh_moreenemiesbelow");
    wait 0.5;
    common_scripts\utility::flag_set("elevator_doors_ready_to_open");
    thread rappel_stealth_second_floor_combat_vo();
    thread rappel_stealth_second_floor_combat_stealth_broken_vo();
    common_scripts\utility::flag_wait("second_floor_enemies_dead");

    if(common_scripts\utility::flag("second_floor_stealth_broken")) {
      wait 1.0;
      level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_clear");
      wait 0.5;
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_letsgetmovin");
      common_scripts\utility::flag_wait("allies_stealth_behavior_end");
      common_scripts\utility::flag_clear("allies_stealth_behavior_end");
    } else {
      wait 1.0;
      level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_clear");
      wait 0.5;
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_keepitmovin");
    }

    common_scripts\utility::flag_set("rappel_down_ready");
  }
}

rappel_stealth_table_guy_nag() {
  level endon("first_floor_sitting_laptop_guy_dead");
  level endon("laptop_guy_react");
  wait 20;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_guyatthetable");
}

rappel_stealth_first_floor_combat_vo() {
  level endon("enemies_aware");
  level endon("killed_out_of_order");
  level endon("first_floor_enemies_dead");
  common_scripts\utility::flag_set("first_floor_patrol_start");
  level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_enemiesbelow");

  if(!common_scripts\utility::flag("first_floor_combat_vo")) {
    level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_rke_noquick");
    wait 1;
  }

  common_scripts\utility::flag_wait("first_floor_combat_vo");
  thread laptop_guy_react_vo();

  if(!common_scripts\utility::flag("first_floor_sitting_laptop_guy_dead") && !common_scripts\utility::flag("laptop_guy_react")) {
    thread rappel_stealth_table_guy_nag();
    common_scripts\utility::waitframe();
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_guyatthetable");
  }

  common_scripts\utility::flag_set("first_floor_combat_weapons_free");
  common_scripts\utility::flag_wait("first_floor_sitting_laptop_guy_dead");
  common_scripts\utility::flag_set("allies_ready_first_combat_floor");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_goodshiftrightlets");
  common_scripts\utility::flag_clear("first_floor_combat_weapons_free");
  level.first_floor_shift_right_trigger common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait("first_floor_shift_right");
  common_scripts\utility::flag_set("first_floor_combat_weapons_free");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_onyoukid");
}

laptop_guy_react_vo() {
  level endon("first_floor_sitting_laptop_guy_dead");
  level waittill("notify_vo_line");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_huhlookatthis");
}

rappel_stealth_first_floor_combat_stealth_broken_vo() {
  level endon("first_floor_enemies_dead");
  common_scripts\utility::flag_wait("enemies_aware");

  if(!common_scripts\utility::flag("first_floor_combat_weapons_free"))
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
}

first_floor_enemies_shot_out_of_order() {
  common_scripts\utility::flag_wait_any("first_floor_patroller_1_dead", "first_floor_patroller_2_dead");

  if(!common_scripts\utility::flag("first_floor_sitting_laptop_guy_dead")) {
    common_scripts\utility::flag_set("killed_out_of_order");

    if(common_scripts\utility::flag("first_floor_patroller_1_dead")) {
      if(!common_scripts\utility::flag("enemies_aware")) {
        common_scripts\utility::flag_set("enemies_aware");
        level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
      }
    } else if(common_scripts\utility::flag("first_floor_patroller_2_dead")) {
      if(!common_scripts\utility::flag("enemies_aware")) {
        common_scripts\utility::flag_set("enemies_aware");
        level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
      }
    }
  }
}

rappel_stealth_second_floor_combat_vo() {
  level endon("enemies_aware");
  level endon("second_floor_enemies_dead");
  thread second_floor_combat_intro_vo();
  thread second_floor_combat_left_enemies_down();
  thread second_floor_combat_middle_enemies_down();
  var_0 = "cornered_mrk_gotmovementinthe";
  thread notify_patrol_movement_vo("poker_table_spooked", level.allies[level.const_rorke], var_0, "poker_table_alerted");
  var_0 = "cornered_mrk_alrightsmoketheseguys";
  thread notify_patrol_movement_vo("poker_table_game_continues", level.allies[level.const_rorke], var_0, "poker_table_alerted");
  var_0 = "cornered_mrk_anotherontheway";
  thread notify_patrol_movement_vo("second_floor_kitchenette_guy_will_be_alerted", level.allies[level.const_rorke], var_0, "second_floor_kitchenette_guy_dead");
  var_0 = "cornered_mrk_drophimquick";
  thread notify_patrol_movement_vo("second_floor_kitchenette_guy_will_be_alerted_2", level.allies[level.const_rorke], var_0, "second_floor_kitchenette_guy_dead");
  var_0 = "cornered_hsh_gotaguyon";
  thread notify_patrol_movement_vo("second_floor_fridge_guy_start_patrol", level.allies[level.const_baker], var_0, "second_floor_fridge_guy_dead");
  var_0 = "cornered_mrk_hesgoingtosee";
  thread notify_patrol_movement_vo("second_floor_fridge_guy_will_be_alerted", level.allies[level.const_rorke], var_0, "second_floor_fridge_guy_dead");
  var_0 = "cornered_hsh_taketheshot";
  thread notify_patrol_movement_vo("take_the_shot_vo", level.allies[level.const_baker], var_0, "second_floor_fridge_guy_dead");
  var_0 = "cornered_hsh_takehimoutnow";
  thread notify_patrol_movement_vo("second_floor_fridge_guy_middle_spook_patrol_near_end", level.allies[level.const_baker], var_0, "second_floor_fridge_guy_dead");
  thread watch_for_death_to_notify_vo("second_floor_kitchenette_guy_dead", "second_floor_fridge_guy_dead", "second_floor_kitchenette_guy_in_kitchen", level.allies[level.const_rorke], "cornered_mrk_holdyourfire_2", "second_floor_fridge_guy_killed_too_soon");
}

rappel_stealth_second_floor_combat_stealth_broken_vo() {
  level endon("second_floor_enemies_dead");
  thread pre_elevator_doors_shut();
  common_scripts\utility::flag_wait("elevator_doors_shut");
  level.second_floor_shift_left_trigger common_scripts\utility::trigger_on();
  thread second_floor_stealth_broken_middle_vo();
  thread second_floor_stealth_broken_left_vo();
}

pre_elevator_doors_shut() {
  level endon("elevator_gone");
  common_scripts\utility::flag_wait("poker_table_alerted");
  level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
  common_scripts\utility::flag_set("second_floor_stealth_broken");
}

second_floor_stealth_broken_middle_vo() {
  level endon("second_floor_enemies_dead");
  level endon("second_floor_stealth_broken");
  level endon("second_floor_left_enemies_taken_out");
  common_scripts\utility::flag_wait("poker_table_alerted");

  if(!common_scripts\utility::flag("intro_vo_done")) {
    if(!common_scripts\utility::flag("stealth_broken_vo_said")) {
      common_scripts\utility::flag_set("stealth_broken_vo_said");
      level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
    }

    wait 5;
    level.second_floor_middle_enemies = maps\_utility::array_removedead(level.second_floor_middle_enemies);

    if(level.second_floor_middle_enemies.size > 0)
      common_scripts\utility::flag_set("second_floor_stealth_broken");
  } else {
    wait 5;
    level.second_floor_middle_enemies = maps\_utility::array_removedead(level.second_floor_middle_enemies);

    if(level.second_floor_middle_enemies.size > 0)
      common_scripts\utility::flag_set("second_floor_stealth_broken");
  }
}

second_floor_stealth_broken_left_vo() {
  level endon("second_floor_enemies_dead");
  level endon("second_floor_stealth_broken");
  common_scripts\utility::flag_wait("kitchen_alerted");

  if(!common_scripts\utility::flag("intro_vo_done")) {
    if(!common_scripts\utility::flag("stealth_broken_vo_said")) {
      common_scripts\utility::flag_set("stealth_broken_vo_said");
      level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
    }

    wait 5;
    level.second_floor_left_enemies = maps\_utility::array_removedead(level.second_floor_left_enemies);

    if(level.second_floor_left_enemies.size > 0)
      common_scripts\utility::flag_set("second_floor_stealth_broken");
  } else {
    wait 5;
    level.second_floor_left_enemies = maps\_utility::array_removedead(level.second_floor_left_enemies);

    if(level.second_floor_left_enemies.size > 0)
      common_scripts\utility::flag_set("second_floor_stealth_broken");
  }
}

second_floor_combat_intro_vo() {
  level endon("enemies_aware");
  level endon("second_floor_fridge_guy_spooked");
  level endon("second_floor_fridge_guy_killed_too_soon");
  level endon("poker_table_alerted");
  level endon("player_shot_in_middle_volume");
  level endon("player_shot_in_right_volume");
  level endon("second_floor_enemies_dead");
  common_scripts\utility::flag_wait("second_floor_combat_vo");
  var_0 = getEntArray("second_floor_combat_vo_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  common_scripts\utility::flag_set("start_elevator_anims");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_holdyourfire_2");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_gotthreeatthe");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_hsh_leftsideonein");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_shiftlefthitthe");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_waintuntilhesin");
  common_scripts\utility::flag_set("intro_vo_done");
  level.second_floor_shift_left_trigger common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait_all("second_floor_shift_left", "second_floor_kitchenette_guy_in_kitchen");
  level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_onyoubro");
}

second_floor_combat_left_enemies_down() {
  level endon("enemies_aware");
  level endon("poker_table_alerted");
  level endon("second_floor_poker_guys_dead");
  level endon("second_floor_enemies_dead");
  common_scripts\utility::flag_wait_either("second_floor_fridge_guy_dead", "second_floor_kitchenette_guy_dead");

  if(common_scripts\utility::flag("second_floor_fridge_guy_dead")) {
    if(common_scripts\utility::flag("second_floor_fridge_guy_killed_too_soon"))
      common_scripts\utility::flag_wait("second_floor_kitchenette_guy_dead");
    else
      common_scripts\utility::flag_wait("second_floor_kitchenette_guy_dead");
  } else if(common_scripts\utility::flag("second_floor_kitchenette_guy_dead"))
    common_scripts\utility::flag_wait("second_floor_fridge_guy_dead");

  common_scripts\utility::flag_set("second_floor_left_enemies_taken_out");
}

second_floor_combat_middle_enemies_down() {
  level endon("enemies_aware");
  level endon("second_floor_fridge_guy_dead");
  level endon("second_floor_kitchenette_guy_dead");
  level endon("second_floor_enemies_dead");
  level endon("second_floor_stealth_broken");
  common_scripts\utility::flag_wait("second_floor_poker_guys_dead");
  common_scripts\utility::flag_set("enemies_on_left_next");

  if(common_scripts\utility::flag("stealth_broken_vo_said")) {
    wait 0.5;
    level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_mrk_messykidnowtake");
  } else {
    wait 0.5;
    level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_mrk_nicenowletshit");
  }
}

watch_for_death_to_notify_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0);
  common_scripts\utility::flag_wait(var_1);

  if(!common_scripts\utility::flag(var_2)) {
    if(isDefined(var_5))
      common_scripts\utility::flag_set(var_5);

    wait 0.5;
    var_3 maps\_utility::smart_radio_dialogue(var_4);
  }
}

notify_patrol_movement_vo(var_0, var_1, var_2, var_3, var_4) {
  level endon("enemies_aware");
  level endon(var_3);
  common_scripts\utility::flag_wait(var_0);
  wait 0.5;
  var_1 maps\_utility::smart_radio_dialogue(var_2);

  if(isDefined(var_4))
    common_scripts\utility::flag_set(var_4);
}

allies_rappel_stealth_anims() {
  maps\cornered_code_rappel_allies::ally_rappel_movement_setup("stealth", "first_floor_enemies_dead");

  if(isDefined(level.rappel_stealth_checkpoint)) {
    level.zipline_anim_struct = common_scripts\utility::getstruct("zipline_anim_struct", "targetname");
    level.zipline_anim_struct thread maps\_anim::anim_single_solo(self, "zipline_" + self.animname);
    common_scripts\utility::waitframe();
    self setanim(maps\_utility::getanim("zipline_" + self.animname), 1.0, 0, 0);
    self setanimtime(maps\_utility::getanim("zipline_" + self.animname), 0.98);
    wait 1;
    maps\cornered_code_rappel_allies::ally_rappel_start_rope(level.rappel_params.rappel_type);
  } else {
    for(;;) {
      if(isDefined(self.zipline) && self.zipline == 0) {
        break;
      }

      wait 0.05;
    }
  }

  level.ally_zipline_count++;

  if(level.ally_zipline_count == 2)
    common_scripts\utility::flag_set("rappel_down_ready");

  self.stealth_broken_flag = self.animname + "_stealth_broken";
  maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("stealth", "first", "player_moving_down");
  common_scripts\utility::flag_wait("player_moving_down");
  maps\cornered_code_rappel_allies::ally_stop_calm_idle();
  level.allies_stealth_behavior_end_count = 0;

  if(!rappel_ignore_first_two_encounters()) {
    allies_move_down_to_first_floor_combat();
    common_scripts\utility::flag_wait("first_floor_enemies_dead");

    if(common_scripts\utility::flag(self.stealth_broken_flag)) {
      for(;;) {
        if(isDefined(self.stealth_behavior_over)) {
          self.stealth_behavior_over = undefined;
          break;
        }

        wait 0.05;
      }

      common_scripts\utility::flag_clear(self.stealth_broken_flag);
      maps\_utility::set_baseaccuracy(1);
      self.accuracy = 1;
    } else
      level notify("floor_complete_end_stealth_threads");

    if(!common_scripts\utility::flag("rappel_down_ready"))
      common_scripts\utility::flag_wait("rappel_down_ready");

    if(!common_scripts\utility::flag("player_moving_down"))
      common_scripts\utility::flag_wait("player_moving_down");

    allies_move_down_to_second_floor_combat();
    common_scripts\utility::flag_wait("second_floor_enemies_dead");

    if(common_scripts\utility::flag(self.stealth_broken_flag)) {
      for(;;) {
        if(isDefined(self.stealth_behavior_over)) {
          self.stealth_behavior_over = undefined;
          break;
        }

        wait 0.05;
      }

      common_scripts\utility::flag_clear(self.stealth_broken_flag);
      maps\_utility::set_baseaccuracy(1);
      self.accuracy = 1;
    } else
      level notify("floor_complete_end_stealth_threads");

    common_scripts\utility::flag_wait("rappel_down_ready");
    common_scripts\utility::flag_wait("player_moving_down");
  }

  allies_move_down_to_third_floor_combat();
  level.reached_target_floor_count++;

  if(level.reached_target_floor_count == 2)
    common_scripts\utility::flag_set("allies_reached_target_floor");
}

allies_move_down_to_first_floor_combat() {
  level endon(self.stealth_broken_flag);
  level.last_goal_struct = 0;
  level.vertical_struct = [];
  level.vertical_struct[0] = common_scripts\utility::getstruct("first_empty_floor", "targetname");
  level.vertical_struct[1] = common_scripts\utility::getstruct("first_combat_floor", "targetname");
  ally_rappel_stealth_movement_vertical("first_floor_enemies_dead");

  if(!common_scripts\utility::flag("first_floor_enemies_dead")) {
    thread handle_allies_if_stealth_broken("first_floor_enemies_dead", "enemies_aware", "first");
    maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("stealth", "first", "rappel_down_ready");
  }

  self notify("stop_loop");

  if(isDefined(self.hiding)) {
    maps\_anim::anim_single_solo(self, "hide_exit_" + self.animname);
    self.hiding = undefined;
  }

  maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
}

allies_move_down_to_second_floor_combat() {
  level endon(self.stealth_broken_flag);
  level.last_goal_struct = 0;
  level.vertical_struct = [];
  level.vertical_struct[0] = common_scripts\utility::getstruct("second_combat_floor", "targetname");
  ally_rappel_stealth_movement_vertical("second_floor_enemies_dead");

  if(!common_scripts\utility::flag("second_floor_enemies_dead")) {
    thread handle_allies_if_stealth_broken("second_floor_enemies_dead", "second_floor_stealth_broken", "second");
    maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("stealth", "second", "rappel_down_ready");
  }

  self notify("stop_loop");

  if(isDefined(self.hiding)) {
    maps\_anim::anim_single_solo(self, "hide_exit_" + self.animname);
    self.hiding = undefined;
  }

  maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
}

allies_move_down_to_third_floor_combat() {
  level endon(self.stealth_broken_flag);
  level.last_goal_struct = 0;
  level.vertical_struct = [];
  level.vertical_struct[0] = common_scripts\utility::getstruct("second_empty_floor", "targetname");
  level.vertical_struct[1] = common_scripts\utility::getstruct("third_combat_floor", "targetname");

  if(self.animname == "rorke") {
    maps\cornered_code_rappel_allies::ally_rappel_pause_movement_horizontal(0);
    rorke_move_to_glass_position();
  }

  ally_rappel_stealth_movement_vertical(undefined, 1, 1);
}

handle_allies_if_stealth_broken(var_0, var_1, var_2) {
  level endon("floor_complete_end_stealth_threads");

  if(!common_scripts\utility::flag(var_1))
    common_scripts\utility::flag_wait(var_1);

  wait 1;
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set(self.stealth_broken_flag);
  maps\_utility::set_baseaccuracy(5000000);
  self.accuracy = 5000000;

  if(common_scripts\utility::flag(var_0)) {
    self.stealth_behavior_over = 1;
    level.allies_stealth_behavior_end_count++;

    if(level.allies_stealth_behavior_end_count == 2) {
      common_scripts\utility::flag_set("allies_stealth_behavior_end");
      level.allies_stealth_behavior_end_count = 0;
    }

    return;
  }

  maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("stealth", "first", var_0);

  if(maps\cornered_code_rappel_allies::ally_is_aiming())
    maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();

  if(!maps\cornered_code_rappel_allies::ally_is_calm_idling())
    maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");

  self.stealth_behavior_over = 1;
  level.allies_stealth_behavior_end_count++;

  if(level.allies_stealth_behavior_end_count == 2) {
    common_scripts\utility::flag_set("allies_stealth_behavior_end");
    level.allies_stealth_behavior_end_count = 0;
  }
}

ally_rappel_moving_vertical_stop(var_0, var_1) {
  if(var_0) {
    var_2 = (self.origin[0], self.origin[1], var_1);
    self forceteleport(var_2, self.angles, 20);
  }

  var_3 = "move_" + self.rappel_move_direction + "_stop";
  self notify("stop_loop");
  self notify("stop_rappel_anim");
  maps\_anim::anim_single_solo(self, var_3);
}

ally_rappel_moving_change_direction(var_0) {
  if(var_0 == self.rappel_move_direction) {
    return;
  }
  self endon("stop_rappel_anim");
  var_1 = "move_" + var_0 + "_start";
  var_2 = "move_" + var_0;

  if(maps\cornered_code_rappel_allies::ally_is_aiming())
    maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  else if(maps\cornered_code_rappel_allies::ally_is_calm_idling())
    maps\cornered_code_rappel_allies::ally_stop_calm_idle();

  self.rappel_move_direction = var_0;
  self notify("stop_loop");
  self.doing_start_anim = 1;
  maps\_anim::anim_single_solo(self, var_1);
  self.doing_start_anim = 0;
  thread maps\_anim::anim_loop_solo(self, var_2, "stop_loop");
}

ally_rappel_moving_stop_idle() {
  self.rappel_move_direction = "idle";

  if(!maps\cornered_code_rappel_allies::ally_is_calm_idling()) {
    self notify("stop_loop");
    maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
  }
}

rorke_move_to_glass_position() {
  var_0 = self.origin[0];
  var_1 = level.rorke_glass_start_org[0];
  var_2 = abs(var_0 - var_1);
  var_3 = maps\cornered_code::ally_get_horizontal_start_distance("right");
  var_4 = maps\cornered_code::ally_get_horizontal_stop_distance("right");
  var_5 = maps\cornered_code::ally_get_horizontal_start_distance("left");
  var_6 = maps\cornered_code::ally_get_horizontal_stop_distance("left");
  var_7 = "move_away_start";
  var_8 = "move_away";
  var_9 = "move_away_stop";
  var_10 = var_1;
  var_11 = 0;

  if(var_0 < var_1) {
    var_12 = var_3 + var_4;

    if(var_2 < var_12)
      var_10 = var_1 + var_5 + var_6;

    var_10 = var_10 - var_4;
    var_11 = 1;
  } else {
    var_12 = var_5 + var_6;
    var_13 = var_1 + var_12;

    if(var_0 < var_13) {
      var_1 = var_13;
      var_10 = var_1 - var_4;
      var_11 = 1;
    }
  }

  if(!var_11) {
    return;
  }
  self notify("stop_loop");
  maps\_anim::anim_single_solo(self, var_7);
  var_14 = 9;
  var_0 = self.origin[0];
  var_0 = var_0 + var_14;

  if(var_0 < var_10) {
    thread maps\_anim::anim_loop_solo(self, var_8, "stop_loop");

    while(var_0 < var_10) {
      common_scripts\utility::waitframe();
      var_0 = self.origin[0] + var_14;
    }
  }

  var_15 = (var_10, self.origin[1], self.origin[2]);
  self forceteleport(var_15, self.angles, 20);
  maps\_anim::anim_single_solo(self, var_9);
}

ally_rappel_stealth_movement_vertical(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level endon(var_0);

  var_3 = self.animname + "_reached_combat_floor";

  if(common_scripts\utility::flag(var_3))
    common_scripts\utility::flag_clear(var_3);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  self.rappel_move_direction = "";
  var_4 = 10000;
  var_5 = 48400;
  var_6 = 176400;
  var_7 = (0, 90, 0);
  self forceteleport(self.origin, var_7);
  self.out_volume = getent(self.animname + "_stealth_out", "targetname");
  self.in_volume = getent(self.animname + "_stealth_in", "targetname");
  self.doing_start_anim = 0;

  while(!common_scripts\utility::flag(var_3)) {
    var_8 = maps\cornered_code::ally_get_vertical_stop_anim_distance(self.rappel_move_direction);
    var_9 = find_closest_struct_below_player();
    var_10 = var_9.origin[2] + var_8;
    var_11 = common_scripts\utility::distance_2d_squared(self.origin, level.player.origin);
    var_12 = self.origin[2] > var_10;
    var_13 = self.origin[2] <= var_10;
    var_14 = self istouching(self.out_volume);
    var_15 = self istouching(self.in_volume);
    var_16 = var_9.origin[2] == level.vertical_struct[level.vertical_struct.size - 1].origin[2];
    var_17 = abs(self.origin[2] - var_10);
    var_18 = var_2 && var_16;

    if(var_13) {
      if(self.rappel_move_direction != "" && self.rappel_move_direction != "idle") {
        ally_rappel_moving_vertical_stop(var_18, var_10);
        self.doing_start_anim = 0;
      }

      ally_rappel_moving_stop_idle();

      if(var_16)
        common_scripts\utility::flag_set(var_3);
    } else if(self.doing_start_anim) {
      common_scripts\utility::waitframe();
      continue;
    } else if(var_1)
      thread ally_rappel_moving_change_direction("down");
    else if(var_11 < var_4) {
      if(!var_14)
        thread ally_rappel_moving_change_direction("away");
      else if(var_12)
        thread ally_rappel_moving_change_direction("down");
    } else if(var_11 < var_5) {
      if(!var_14) {
        if(var_12)
          thread ally_rappel_moving_change_direction("down_away");
      } else if(var_12)
        thread ally_rappel_moving_change_direction("down");
    } else if(var_11 >= var_6) {
      if(!var_15) {
        if(var_12)
          thread ally_rappel_moving_change_direction("down_back");
      } else if(var_12)
        thread ally_rappel_moving_change_direction("down");
    } else if(var_12)
      thread ally_rappel_moving_change_direction("down");

    common_scripts\utility::waitframe();
  }
}

find_closest_struct_below_player() {
  var_0 = undefined;

  for(var_1 = 0; var_1 < level.vertical_struct.size; var_1++) {
    if(level.vertical_struct[var_1].origin[2] <= level.player.origin[2]) {
      var_0 = level.vertical_struct[var_1];
      level.last_goal_struct = var_0;
      break;
    }
  }

  if(!isDefined(var_0))
    var_0 = level.last_goal_struct;

  return var_0;
}