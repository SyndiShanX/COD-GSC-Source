/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_building_entry.gsc
********************************************/

cornered_building_entry_pre_load() {
  common_scripts\utility::flag_init("player_out_of_rorkes_way");
  common_scripts\utility::flag_init("player_looking_towards_rorke");
  common_scripts\utility::flag_init("rorke_started_cutting_glass");
  common_scripts\utility::flag_init("player_finished_cutting");
  common_scripts\utility::flag_init("player_jumped_into_building");
  common_scripts\utility::flag_init("enter_building_ready");
  common_scripts\utility::flag_init("player_in_building");
  common_scripts\utility::flag_init("rorke_at_wave_node");
  common_scripts\utility::flag_init("move_rorke_to_power_junction_entrance");
  common_scripts\utility::flag_init("rorke_reached_power_junction_room_node");
  common_scripts\utility::flag_init("player_entering_building");
  common_scripts\utility::flag_init("player_can_upload_virus");
  common_scripts\utility::flag_init("rorke_at_virus_upload");
  common_scripts\utility::flag_init("virus_upload_loop");
  common_scripts\utility::flag_init("player_started_virus_upload");
  common_scripts\utility::flag_init("player_started_uploading");
  common_scripts\utility::flag_init("player_start_upload");
  common_scripts\utility::flag_init("player_stop_upload");
  common_scripts\utility::flag_init("player_leave_upload");
  common_scripts\utility::flag_init("spawn_power_junction_patrol");
  common_scripts\utility::flag_init("start_power_junction_patrol_chatter");
  common_scripts\utility::flag_init("start_power_junction_patrol_wave_1");
  common_scripts\utility::flag_init("start_power_junction_patrol_wave_2");
  common_scripts\utility::flag_init("start_power_junction_patrol_shadowkill_enemy");
  common_scripts\utility::flag_init("rorke_in_guard_loop");
  common_scripts\utility::flag_init("virus_upload_bar_almost_complete");
  common_scripts\utility::flag_init("force_virus_upload_bar_complete");
  common_scripts\utility::flag_init("virus_upload_bar_complete");
  common_scripts\utility::flag_init("virus_audio_stop_loop");
  common_scripts\utility::flag_init("force_player_to_end_virus_upload");
  common_scripts\utility::flag_init("finish_upload");
  common_scripts\utility::flag_init("virus_dynamic_dof_on");
  common_scripts\utility::flag_init("swap_rorke_head");
  common_scripts\utility::flag_init("rorke_in_alcove");
  common_scripts\utility::flag_init("enemy_at_shadow_kill_node");
  common_scripts\utility::flag_init("shadowkill_phone_on");
  common_scripts\utility::flag_init("shadow_kill_enemy_phone_out");
  common_scripts\utility::flag_init("shadowkill_phone_off");
  common_scripts\utility::flag_init("shadow_kill_start");
  common_scripts\utility::flag_init("shadow_kill_goggles_on");
  common_scripts\utility::flag_init("shadow_kill_stab");
  common_scripts\utility::flag_init("shadow_kill_done");
  common_scripts\utility::flag_init("start_patrol_vo");
  common_scripts\utility::flag_init("patrol_out_of_start_hallway");
  common_scripts\utility::flag_init("patrol_out_of_shadow_kill_volume");
  common_scripts\utility::flag_init("last_patroller_out_of_shadow_kill_volume");
  common_scripts\utility::flag_init("patrol_out_of_power_junction_hallway");
  common_scripts\utility::flag_init("power_junction_patrol_killed");
  common_scripts\utility::flag_init("enemies_aware");
  common_scripts\utility::flag_init("all_in");
  common_scripts\utility::flag_init("rorke_at_hall_end");
  common_scripts\utility::flag_init("rorke_at_building_exit_node");
  common_scripts\utility::flag_init("player_has_exited_the_building");
  common_scripts\utility::flag_init("exit_building_ready");
  common_scripts\utility::flag_init("player_exiting_building");
  common_scripts\utility::flag_init("player_ready_to_deploy_virus");
  common_scripts\utility::flag_init("player_deployed_virus");
  common_scripts\utility::flag_init("spawn_balcony_enemies");
  common_scripts\utility::flag_init("balcony_enemies_on_balcony");
  common_scripts\utility::flag_init("player_shot");
  common_scripts\utility::flag_init("kill_balcony_enemies");
  common_scripts\utility::flag_init("player_is_past_balcony_and_enemies_are_alive");
  common_scripts\utility::flag_init("balcony_enemies_killed");
  common_scripts\utility::flag_init("player_is_past_sleeping_enemy_below");
  common_scripts\utility::flag_init("sleeping_enemy_below_dead");
  common_scripts\utility::flag_init("inverted_rorke_done");
  common_scripts\utility::flag_init("inverted_baker_done");
  common_scripts\utility::flag_init("player_can_start_inverted_kill");
  common_scripts\utility::flag_init("player_not_in_inverted_kill_volume");
  common_scripts\utility::flag_init("inverted_kill_fail");
  common_scripts\utility::flag_init("player_initiated_pounce");
  common_scripts\utility::flag_init("player_pounce");
  common_scripts\utility::flag_init("inverted_kill_enemy_started_turning_around");
  common_scripts\utility::flag_init("inverted_kill_enemy_turned_around");
  common_scripts\utility::flag_init("player_inverted_kill_enemy_pounce_fail_end");
  common_scripts\utility::flag_init("player_knife_throw_enemy_dead");
  common_scripts\utility::flag_init("inverted_kill_knife_rorke");
  common_scripts\utility::flag_init("rorke_inverted_kill");
  common_scripts\utility::flag_init("knife_is_touching_enemy");
  common_scripts\utility::flag_init("start_knife_throw");
  common_scripts\utility::flag_init("player_aims_knife_at_enemy");
  common_scripts\utility::flag_init("player_not_aiming_at_enemy");
  common_scripts\utility::flag_init("player_throws_knife");
  common_scripts\utility::flag_init("player_throws_knife_fail");
  common_scripts\utility::flag_init("player_failed_to_throw_knife");
  precachemodel("cnd_laser_cutter");
  precachemodel("cnd_window_pane_fx");
  precachemodel("cnd_window_pane_cutout_player");
  precachemodel("cnd_window_cutout_shattered_player");
  precachemodel("cnd_window_pane_cutout_ally");
  precachemodel("cnd_window_cutout_shattered_ally");
  precachemodel("cnd_window_cut_ribbon");
  precachemodel("cnd_rappel_tele_rope");
  precachemodel("cnd_rappel_tele_rope_obj");
  precachemodel("cnd_hand_held_device_bink");
  precachemodel("cnd_server_rack_anim");
  precachemodel("cnd_server_rack_anim_obj");
  precachemodel("cnd_server_rack_anim_drive_obj");
  precachemodel("hjk_laptop_animated_on");
  precachemodel("cnd_cellphone_01_on_anim");
  precachemodel("cnd_cellphone_01_off_anim");
  precachemodel("weapon_bolo_knife");
  precachemodel("weapon_parabolic_knife");
  precachemodel("viewmodel_lg_push_knife");
  precachemodel("projectile_lg_push_knife");
  precacheitem("computer_idf");
  precacheitem("push_knife");
  precacheitem("throwing_push_knife");
  precacheitem("imbel_hide_acog_silenced_cornered");
  precacheitem("kriss_hide_eotech_silenced_cornered");
  precachestring(&"CORNERED_ENTER_BUILDING");
  precachestring(&"CORNERED_ENTER_BUILDING_CONSOLE");
  precachestring(&"CORNERED_START_UPLOAD_VIRUS");
  precachestring(&"CORNERED_START_UPLOAD_VIRUS_CONSOLE");
  precachestring(&"CORNERED_UPLOAD_VIRUS");
  precachestring(&"CORNERED_EXIT_BUILDING");
  precachestring(&"CORNERED_EXIT_BUILDING_CONSOLE");
  precachestring(&"CORNERED_INVERTED_KILL");
  precachestring(&"CORNERED_KNIFE_THROW");
  maps\_utility::add_hint_string("virus_upload", &"CORNERED_UPLOAD_VIRUS", ::should_break_virus_upload_hint);
  maps\_utility::add_hint_string("virus_deploy", &"CORNERED_DEPLOY_VIRUS");
  maps\_utility::add_hint_string("inverted_kill", &"CORNERED_INVERTED_KILL", ::should_break_inverted_kill_hint);
  maps\_utility::add_hint_string("knife_throw", &"CORNERED_KNIFE_THROW");
  level.clean_window_player = getent("clean_window_player", "targetname");
  level.clean_window_rorke = getent("clean_window_rorke", "targetname");
  level.start_inverted_rappel_trigger = getent("start_inverted_rappel_trigger", "targetname");
  level.start_inverted_rappel_trigger common_scripts\utility::trigger_off();
  level.balcony_enemies_clip = getent("balcony_enemies_clip", "targetname");
  level.balcony_enemies_clip notsolid();
  level.balcony_enemies_clip connectpaths();
  level.inverted_kill_balcony_door_clip = getent("inverted_kill_balcony_door_clip", "targetname");
  level.inverted_kill_balcony_door_clip notsolid();
  level.inverted_kill_balcony_door_clip connectpaths();
  level.move_rorke_to_window_trigger = getent("move_rorke_to_window_trigger", "targetname");
  level.move_rorke_to_window_trigger common_scripts\utility::trigger_off();
  common_scripts\utility::flag_init("building_entry_finished");
  common_scripts\utility::flag_init("shadow_kill_finished");
  common_scripts\utility::flag_init("inverted_rappel_finished");
}

setup_building_entry() {
  level.building_entry_startpoint = 1;
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_lighting::fireworks_stealth_rappel();
  thread maps\cornered_audio::aud_check("building_entry");
  thread building_entry_tv();
  thread maps\cornered_code::delete_window_reflectors();
  level.player thread maps\cornered_code::player_flap_sleeves();
  maps\cornered_lighting::do_specular_sun_lerp(1);
}

setup_shadow_kill() {
  level.shadow_kill_startpoint = 1;
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_lighting::fireworks_stealth_rappel();
  thread building_entry_tv();
  thread maps\cornered::obj_upload_virus();
  thread maps\cornered_audio::aud_check("shadow_kill");
  var_0 = getent("building_entry_tv_script_brushmodel", "targetname");
  thread maps\cornered_code::watch_tv_for_damage(var_0, "player_has_exited_the_building", undefined, level.hide_bink_brush);
  thread maps\cornered_code::delete_window_reflectors();
}

setup_inverted_rappel() {
  level.inverted_rappel_startpoint = 1;
  thread maps\cornered_audio::aud_check("inverted");
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_lighting::fireworks_stealth_rappel();
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  var_0 = getent("building_entry_tv_script_brushmodel", "targetname");
  thread maps\cornered_code::watch_tv_for_damage(var_0, "player_has_exited_the_building", undefined, level.hide_bink_brush);
  thread maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::delete_window_reflectors();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
}

begin_building_entry() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  thread building_entry();
  common_scripts\utility::flag_wait("building_entry_finished");

  if(maps\cornered_code::is_e3())
    thread maps\_utility::autosave_by_name_silent("building_entry");
  else
    thread maps\_utility::autosave_tactical();
}

begin_shadow_kill() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  thread shadow_kill();
  common_scripts\utility::flag_wait("shadow_kill_finished");

  if(maps\cornered_code::is_e3())
    thread maps\_utility::autosave_by_name_silent("shadow_kill");
  else
    thread maps\_utility::autosave_tactical();
}

begin_inverted_rappel() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  thread inverted_rappel();
  common_scripts\utility::flag_wait("inverted_rappel_finished");
  thread directory_cinematic_after_save();
}

directory_cinematic_after_save() {
  maps\_utility::autosave_tactical();
  wait 5;
  thread maps\cornered_interior::courtyard_directory();
}

building_entry() {
  if(isDefined(level.building_entry_startpoint)) {
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

    foreach(var_2 in level.allies)
    var_2 maps\cornered_code_rappel_allies::ally_rappel_start_rope(var_0.rappel_type);

    level.player thread maps\cornered_code::player_flap_sleeves();
  }

  var_4 = getent("building_entry_tv_script_brushmodel", "targetname");
  thread maps\cornered_code::watch_tv_for_damage(var_4, "player_has_exited_the_building", undefined, level.hide_bink_brush);
  thread handle_building_entry();
  thread building_entry_combat();
  thread allies_building_entry_vo();
  common_scripts\utility::waitframe();
  level.allies[level.const_rorke] thread allies_building_entry_movement();
  level.allies[level.const_baker] thread allies_building_entry_movement();
}

shadow_kill() {
  thread handle_shadow_kill();
  thread shadow_kill_combat();
  thread allies_shadow_kill_vo();
  common_scripts\utility::waitframe();
  level.allies[level.const_rorke] thread allies_shadow_kill_movement();
  level.allies[level.const_baker] thread allies_shadow_kill_movement();
}

inverted_rappel() {
  thread handle_rappel_inverted();
  thread inverted_rappel_combat();
  thread allies_inverted_rappel_vo();
  common_scripts\utility::waitframe();
  level.allies[level.const_rorke] thread allies_inverted_rappel_movement();
  level.allies[level.const_baker] thread allies_inverted_rappel_movement();

  if(isDefined(level.inverted_rappel_startpoint)) {
    thread setup_window_cutout(level.clean_window_player, "cnd_window_pane_cutout_player");
    thread setup_window_cutout(level.clean_window_rorke, "cnd_window_pane_cutout_ally");
  }
}

setup_window_cutout(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_0 delete();
  var_2 setModel(var_1);
  var_2 show();
  var_2 thread maps\cornered_code::entity_cleanup("player_pounce");
}

should_break_enter_building_hint() {
  return common_scripts\utility::flag("player_pressed_use_button");
}

trigger_disable_on_jump() {
  level endon("player_entering_building");

  for(;;) {
    common_scripts\utility::flag_wait("player_jumping");
    self.force_off = 1;
    common_scripts\utility::flag_waitopen("player_jumping");
    self.force_off = undefined;
  }
}

handle_building_entry() {
  level.shadowkill_struct = common_scripts\utility::getstruct("shadow_kill_anim_struct", "targetname");
  level.rappel_entry_anim_struct = common_scripts\utility::getstruct("rappel_entry_anim_struct_stealth", "targetname");
  level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
  maps\cornered_code_rappel::cornered_stop_random_wind();
  thread maps\cornered_audio::aud_stop_wind();
  common_scripts\utility::flag_wait("enter_building_ready");
  level.rappel_window_frame_obj show();
  level.rappel_window_frame_obj maps\_utility::glow();
  var_0 = common_scripts\utility::getstruct("entry_look_at", "targetname");
  var_1 = getent("player_enter_building_trigger", "targetname");

  if(!maps\cornered_code::is_e3()) {
    if(level.player common_scripts\utility::is_player_gamepad_enabled())
      var_1 sethintstring(&"CORNERED_ENTER_BUILDING_CONSOLE");
    else
      var_1 sethintstring(&"CORNERED_ENTER_BUILDING");
  }

  var_1 thread trigger_disable_on_jump();
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_1, var_0, cos(50), 0, 1, level.plyr_rpl_groundref);
  common_scripts\utility::flag_set("player_entering_building");
  maps\cornered_code_rappel::rappel_clear_vertical_limits();
  thread maps\cornered_audio::aud_rappel("enter");
  level.rappel_window_frame_obj maps\_utility::stopglow();
  level.rappel_window_frame_obj delete();
  player_enter_building();
  maps\cornered_code::delete_building_glow();
  common_scripts\utility::flag_set("player_in_building");
  common_scripts\utility::flag_clear("player_jumping");
  level.player allowjump(1);
}

delay_show_legs_entry() {
  wait 1.5;
  level.cornered_player_legs show();
}

player_enter_building() {
  level.building_entry_exit_anim_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "rappel_stealth_cut");
  var_0 = maps\_utility::spawn_anim_model("cnd_rappel_player_rope");
  var_0 hide();
  level.building_entry_exit_anim_struct thread maps\_anim::anim_first_frame_solo(var_0, "cornered_rappel_stealth_enterbldg_cut_playerline");

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  maps\cornered_code_rappel::cornered_stop_rappel();
  wait 0.1;
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player common_scripts\utility::_disableweapon();
  level.player maps\cornered_code::player_stop_flap_sleeves();
  level.player unlink();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.rappel_player_legs.origin;
  var_1.angles = level.rappel_player_legs.angles;
  level.rappel_player_legs linkto(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.cnd_rappel_player_rope unlink();
  wait 0.1;
  var_2 = 0.5;
  var_3 = 0.2;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", var_2);
  var_1 moveto(var_1.origin + (0, 0, -100), var_2, 0, 0);
  level.cnd_rappel_player_rope moveto(var_0.origin, var_3, 0, 0);
  level.cnd_rappel_player_rope rotateto(var_0.angles, var_3, 0, 0);
  wait 0.5;
  level.rappel_player_legs delete();
  var_1 delete();
  var_0 delete();
  maps\cornered_code::show_player_arms();
  thread delay_show_legs_entry();
  level.cornered_player_arms maps\cornered_code::player_flap_sleeves();
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "rappel_stealth_cut");
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single_solo(level.cnd_rappel_player_rope, "cornered_rappel_stealth_enterbldg_cut_playerline");
  level.cornered_player_arms thread glass_cutting_fx_notetrack_handler();
  level.cornered_player_arms waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("player_finished_cutting");
  level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 1, 60, 60, 60, 15);
  thread maps\cornered_audio::aud_rappel("enter2");
  common_scripts\utility::flag_set("player_jumped_into_building");
  thread maps\cornered_fx::turn_off_rain_fx();
  maps\cornered_lighting::do_specular_sun_lerp(0);
  level.building_entry_exit_anim_struct notify("stop_player_loop");
  waittillframeend;
  level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "rappel_stealth_jump");
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single_solo(level.cnd_rappel_player_rope, "cornered_rappel_stealth_enterbldg_jump_playerline");
  wait 0.03;
  level.player playersetgroundreferenceent(undefined);
  level.cornered_player_arms waittillmatch("single anim", "end");
  level.player unlink();
  level.player freezecontrols(0);
  level.player allowcrouch(1);
  level.player allowprone(1);
  maps\cornered_code::hide_player_arms();
  level.cornered_player_legs hide();
  level.cornered_player_arms maps\cornered_code::player_stop_flap_sleeves();
  level.player_exit_to_inverted_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
  level.building_entry_exit_anim_struct maps\_anim::anim_first_frame_solo(level.player_exit_to_inverted_rope, "rappel_stealth_exit");

  if(isDefined(level.cnd_rappel_player_rope))
    level.cnd_rappel_player_rope delete();
}

glass_cutting_fx_notetrack_handler(var_0) {
  var_1 = [];
  var_2 = [];

  for(;;) {
    self waittill("single anim", var_3);

    switch (var_3) {
      case "start_fx_trail_15":
      case "start_fx_trail_14":
      case "start_fx_trail_12":
      case "start_fx_trail_11":
      case "start_fx_trail_10":
      case "start_fx_trail_9":
      case "start_fx_trail_8":
      case "start_fx_trail_7":
      case "start_fx_trail_6":
      case "start_fx_trail_5":
      case "start_fx_trail_4":
      case "start_fx_trail_3":
        if(self.animname == "rorke") {
          playFXOnTag(level._effect["torch_cutting_glass_spark_ondeath"], self, "tag_shield_back");
          playFXOnTag(level._effect["torch_cutting_glass_spark_crack"], self, "tag_shield_back");
        } else {
          playFXOnTag(level._effect["torch_cutting_glass_spark_ondeath2"], self, "tag_knife_attach");
          playFXOnTag(level._effect["torch_cutting_glass_spark_crack"], self, "tag_knife_attach");
          playFXOnTag(level._effect["torch_cutting_glass_spark_crack_rev"], self, "tag_knife_attach");
        }

        break;
    }
  }
}

spawn_glass_cutter(var_0) {
  if(var_0.animname == "rorke") {
    level.rorke_glass_cutter = spawn("script_model", var_0 gettagorigin("tag_weapon_chest"));
    level.rorke_glass_cutter setModel("cnd_laser_cutter");
    level.rorke_glass_cutter linkto(var_0, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
    level.window_fx_model = spawn("script_model", level.clean_window_rorke.origin);
    level.window_fx_model setModel("cnd_window_pane_fx");
    level.window_fx_model thread maps\cornered_code::entity_cleanup("player_pounce");
  } else {
    level.player_glass_cutter = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
    level.player_glass_cutter setModel("cnd_laser_cutter");
    level.player_glass_cutter linkto(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  }
}

glass_cutter_on(var_0) {
  if(var_0.animname == "rorke") {
    playFXOnTag(level._effect["torch_cutting_glass_beam"], level.rorke_glass_cutter, "tag_fx");
    playFXOnTag(level._effect["torch_cutting_glass_spark"], var_0, "tag_inhand");
    playFXOnTag(level._effect["torch_cutting_glass_heatribbon"], var_0, "tag_inhand");
    level.window_ribbon_rorke = spawn("script_model", (0, 0, 0));
    level.window_ribbon_rorke setModel("cnd_window_cut_ribbon");
    level.window_ribbon_rorke.animname = "window_ribbon";
    level.window_ribbon_rorke maps\_anim::setanimtree();
    level.window_ribbon_rorke hide();
    level.building_entry_exit_anim_struct maps\_anim::anim_first_frame_solo(level.window_ribbon_rorke, "cnd_rappel_stealth_enter_bldg_ribbon1");
    level.window_ribbon_rorke show();
    level.building_entry_exit_anim_struct maps\_anim::anim_single_solo(level.window_ribbon_rorke, "cnd_rappel_stealth_enter_bldg_ribbon1");
  } else {
    playFXOnTag(level._effect["torch_cutting_glass_beam_player"], level.player_glass_cutter, "tag_fx");
    playFXOnTag(level._effect["torch_cutting_glass_spark"], var_0, "tag_weapon_left");
    playFXOnTag(level._effect["torch_cutting_glass_heatribbon_player"], var_0, "tag_weapon_left");
    level.window_ribbon_player = spawn("script_model", (0, 0, 0));
    level.window_ribbon_player setModel("cnd_window_cut_ribbon");
    level.window_ribbon_player.animname = "window_ribbon";
    level.window_ribbon_player maps\_anim::setanimtree();
    level.window_ribbon_player hide();
    level.building_entry_exit_anim_struct maps\_anim::anim_first_frame_solo(level.window_ribbon_player, "cnd_rappel_stealth_enter_bldg_ribbon2");
    level.window_ribbon_player show();
    level.building_entry_exit_anim_struct maps\_anim::anim_single_solo(level.window_ribbon_player, "cnd_rappel_stealth_enter_bldg_ribbon2");
  }
}

glass_cutter_off(var_0) {
  if(var_0.animname == "rorke") {
    stopFXOnTag(level._effect["torch_cutting_glass_beam"], level.rorke_glass_cutter, "tag_fx");
    stopFXOnTag(level._effect["torch_cutting_glass_spark"], var_0, "tag_inhand");
    stopFXOnTag(level._effect["torch_cutting_glass_heatribbon"], var_0, "tag_inhand");
  } else {
    stopFXOnTag(level._effect["torch_cutting_glass_beam_player"], level.player_glass_cutter, "tag_fx");
    stopFXOnTag(level._effect["torch_cutting_glass_spark"], var_0, "tag_weapon_left");
    stopFXOnTag(level._effect["torch_cutting_glass_heatribbon_player"], var_0, "tag_weapon_left");
  }
}

delete_glass_cutter(var_0) {
  if(var_0.animname == "rorke")
    level.rorke_glass_cutter delete();
  else
    level.player_glass_cutter delete();
}

punch_glass(var_0) {
  if(var_0.animname == "rorke") {
    level.window_ribbon_rorke delete();
    level.cut_window_rorke = spawn("script_model", level.clean_window_rorke.origin);
    level.cut_window_rorke setModel("cnd_window_pane_cutout_ally");
    level.window_cutout_shattered_rorke = spawn("script_model", level.clean_window_rorke.origin);
    level.window_cutout_shattered_rorke setModel("cnd_window_cutout_shattered_ally");
    level.clean_window_rorke delete();
    level.cut_window_rorke show();
    level.window_cutout_shattered_rorke show();
    common_scripts\utility::exploder(87421);
    level.window_cutout_shattered_rorke.animname = "window_cutout_shattered_rorke";
    level.window_cutout_shattered_rorke maps\_anim::setanimtree();
    level.window_cutout_shattered_rorke maps\_anim::anim_single_solo(level.window_cutout_shattered_rorke, "cnd_rappel_stealth_enter_bldg_window1");
    level.window_cutout_shattered_rorke thread maps\cornered_code::entity_cleanup("player_pounce");
    level.cut_window_rorke thread maps\cornered_code::entity_cleanup("player_pounce");
  } else {
    level.window_ribbon_player delete();
    level.cut_window_player = spawn("script_model", level.clean_window_player.origin);
    level.cut_window_player setModel("cnd_window_pane_cutout_player");
    level.window_cutout_shattered_player = spawn("script_model", level.clean_window_player.origin);
    level.window_cutout_shattered_player setModel("cnd_window_cutout_shattered_player");
    level.clean_window_player delete();
    level.cut_window_player show();
    level.window_cutout_shattered_player show();
    common_scripts\utility::exploder(87422);
    level.window_cutout_shattered_player.animname = "window_cutout_shattered_player";
    level.window_cutout_shattered_player maps\_anim::setanimtree();
    level.window_cutout_shattered_player maps\_anim::anim_single_solo(level.window_cutout_shattered_player, "cnd_rappel_stealth_enter_bldg_window2");
    level.window_cutout_shattered_player thread maps\cornered_code::entity_cleanup("player_pounce");
    level.cut_window_player thread maps\cornered_code::entity_cleanup("player_pounce");
  }

  maps\_utility::stop_exploder(10);
}

building_entry_gun_up(var_0) {
  common_scripts\utility::flag_set("move_rorke_to_power_junction_entrance");
  level.player common_scripts\utility::_enableweapon();
}

building_entry_tv() {
  if(level.start_point != "shadow_kill") {
    setsaveddvar("cg_cinematicFullScreen", "0");
    cinematicingameloop("cornered_concert");
    common_scripts\utility::flag_wait("player_in_power_junction_hallway");
    stopcinematicingame();

    if(isDefined(level.hide_bink_brush))
      level.hide_bink_brush show();

    var_0 = getent("building_entry_tv_light", "targetname");

    if(isDefined(var_0))
      var_0 setlightintensity(0.01);
  } else {
    level.hide_bink_brush show();
    var_0 = getent("building_entry_tv_light", "targetname");

    if(isDefined(var_0))
      var_0 setlightintensity(0.01);
  }

  common_scripts\utility::flag_wait("virus_upload_bar_complete");
  wait 1;
  cinematicingameloop("cornered_concert");

  if(isDefined(level.hide_bink_brush))
    level.hide_bink_brush delete();

  common_scripts\utility::flag_wait("player_exiting_building");
  stopcinematicingame();
}

upload_virus_setup() {
  level.laptop = maps\_utility::spawn_anim_model("laptop");
  level.laptop setModel("hjk_laptop_animated_on");
  level.laptop.animname = "laptop";
  level.shadowkill_struct maps\_anim::anim_first_frame_solo(level.laptop, "virus_upload_laptop_enter");
  level.device = maps\_utility::spawn_anim_model("handheld_device");
  level.device setModel("cnd_hand_held_device_bink");
  level.device.animname = "handheld_device";
  level.device hide();
  level.rack = maps\_utility::spawn_anim_model("rack");
  level.rack setModel("cnd_server_rack_anim");
  level.rack.animname = "rack";
  var_0 = getent("server_rack_clip", "targetname");
  var_0 linkto(level.rack, "j_rack", (0, 0, 0), (0, 90, 0));
  level.virus_upload_anim_array = [];
  level.virus_upload_anim_array[0] = level.cornered_player_arms;
  level.virus_upload_anim_array[1] = level.device;
  level.virus_upload_anim_array[2] = level.rack;
  level.shadowkill_struct maps\_anim::anim_first_frame(level.virus_upload_anim_array, "virus_upload_enter");
  common_scripts\utility::flag_wait("player_can_upload_virus");
  thread virus_upload_bink_start();
  level.rack setModel("cnd_server_rack_anim_obj");
  level.virus_upload_trigger = getent("player_upload_virus_trigger", "targetname");
  level.virus_upload_trigger common_scripts\utility::trigger_off();
  level.virus_upload_lookat = common_scripts\utility::getstruct("player_upload_virus_lookat", "targetname");
  level.rack_pull_out_trigger = getent("player_pulling_out_rack_trigger_old", "targetname");
  level.rack_pull_out_lookat = common_scripts\utility::getstruct("pulling_out_rack_lookat", "targetname");
  var_1 = getent("player_pulling_out_rack_trigger", "targetname");
  var_1 delete();

  if(!maps\cornered_code::is_e3()) {
    if(level.player common_scripts\utility::is_player_gamepad_enabled())
      level.rack_pull_out_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS_CONSOLE");
    else
      level.rack_pull_out_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS");
  }

  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(level.rack_pull_out_trigger, level.rack_pull_out_lookat, cos(40));
  common_scripts\utility::flag_set("player_started_virus_upload");
  setsaveddvar("ammoCounterHide", 1);
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  thread maps\cornered_audio::aud_virus("plant");
  level.rack setModel("cnd_server_rack_anim");

  if(level.player common_scripts\utility::isweaponenabled())
    level.player common_scripts\utility::_disableweapon();

  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  level.player freezecontrols(1);
  wait 0.4;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.6);
  level.player maps\cornered_code::player_hideviewmodelsleeveflaps();
  thread delay_show_animated_hands(0.6, level.device);
  level.bink_is_paused = undefined;
  thread force_player_to_end_upload();
  thread watch_player_button_press();
  level.player.is_in_upload = 1;
  common_scripts\utility::flag_set("virus_dynamic_dof_on");
  level.player thread maps\cornered_lighting::virus_dynamic_dof("virus_upload_bar_complete");
  level.shadowkill_struct maps\_anim::anim_single(level.virus_upload_anim_array, "virus_upload_enter");
  level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 0, 15, 15, 15, 10);
  thread player_upload_virus_hint();
  thread upload_virus_loop();
  level.upload_progress = 1;
  level.max_upload = 100;
  thread inverted_rappel_setup();
  common_scripts\utility::flag_wait("spawn_power_junction_patrol");
  thread gun_down_trigger();
  thread shut_server_rack();
  common_scripts\utility::flag_wait("player_exiting_building");
  level.rack delete();
  level.laptop delete();
  setsaveddvar("aim_aimAssistRangeScale", "1");
}

player_upload_virus_hint() {
  level endon("virus_upload_bar_complete");
  var_0 = 3;
  thread upload_hint_cleanup(var_0);

  for(;;) {
    common_scripts\utility::flag_clear("player_started_uploading");
    thread maps\cornered_code::time_to_pass_before_hint(var_0, "virus_upload", "player_started_uploading", 0, 2);
    var_1 = common_scripts\utility::flag_wait_any_return("player_start_upload", "player_leave_upload");
    common_scripts\utility::flag_set("player_started_uploading");

    if(var_1 == "player_start_upload")
      common_scripts\utility::flag_wait("player_stop_upload");

    if(var_1 == "player_leave_upload")
      common_scripts\utility::flag_waitopen("player_leave_upload");

    common_scripts\utility::waitframe();
  }
}

upload_hint_cleanup(var_0) {
  common_scripts\utility::flag_wait("virus_upload_bar_complete");
  common_scripts\utility::flag_set("player_started_uploading");
}

should_break_virus_upload_hint() {
  return common_scripts\utility::flag("player_started_uploading");
}

upload_virus_enter() {
  level endon("force_player_upload_end");
  level endon("enemies_aware");

  if(isDefined(level.rack_shut)) {
    level.rack setModel("cnd_server_rack_anim_obj");
    level.rack_pull_out_trigger common_scripts\utility::trigger_on();

    if(!maps\cornered_code::is_e3()) {
      if(level.player common_scripts\utility::is_player_gamepad_enabled())
        level.rack_pull_out_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS_CONSOLE");
      else
        level.rack_pull_out_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS");
    }

    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(level.rack_pull_out_trigger, level.rack_pull_out_lookat, cos(40));
    level.rack setModel("cnd_server_rack_anim");
    level.shadowkill_struct maps\_anim::anim_first_frame(level.virus_upload_anim_array, "virus_upload_enter");
  } else {
    level.rack setModel("cnd_server_rack_anim_drive_obj");
    level.virus_upload_trigger common_scripts\utility::trigger_on();

    if(!maps\cornered_code::is_e3()) {
      if(level.player common_scripts\utility::is_player_gamepad_enabled())
        level.virus_upload_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS_CONSOLE");
      else
        level.virus_upload_trigger sethintstring(&"CORNERED_START_UPLOAD_VIRUS");
    }

    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(level.virus_upload_trigger, level.virus_upload_lookat, cos(40));
    thread maps\cornered_audio::aud_virus("restart");
    level.rack setModel("cnd_server_rack_anim");
  }

  thread upload_virus_anims();
}

delay_show_animated_hands(var_0, var_1) {
  wait(var_0);
  level.cornered_player_arms show();

  if(isDefined(var_1))
    var_1 show();

  level.player freezecontrols(0);
}

upload_virus_anims() {
  setsaveddvar("ammoCounterHide", 1);

  if(level.player common_scripts\utility::isweaponenabled())
    level.player common_scripts\utility::_disableweapon();

  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  level.player freezecontrols(1);
  level.player.is_in_upload = 1;
  common_scripts\utility::flag_set("virus_dynamic_dof_on");
  wait 0.4;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.6);
  level.player maps\cornered_code::player_hideviewmodelsleeveflaps();
  thread delay_show_animated_hands(0.6, level.device);
  thread watch_player_button_press();

  if(isDefined(level.rack_shut)) {
    thread maps\cornered_audio::aud_virus("replant");
    level.shadowkill_struct maps\_anim::anim_single(level.virus_upload_anim_array, "virus_upload_enter");
    level.rack_shut = undefined;
  } else {
    level.shadowkill_struct thread maps\_anim::anim_single_solo(level.virus_upload_anim_array[0], "virus_upload_enter_fast");
    level.shadowkill_struct maps\_anim::anim_single_solo(level.virus_upload_anim_array[1], "virus_upload_enter_fast");
  }

  level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 0, 15, 15, 15, 10);

  if(common_scripts\utility::flag("force_player_to_end_virus_upload"))
    upload_virus_exit();
  else
    upload_virus_loop();
}

upload_virus_loop() {
  common_scripts\utility::flag_set("virus_upload_loop");
  thread watch_player_left_stick();
  thread virus_upload_bink();
  thread upload_virus_loop_anims();
  common_scripts\utility::flag_wait_any("virus_upload_bar_complete", "player_leave_upload", "force_player_to_end_virus_upload");
  common_scripts\utility::flag_clear("virus_upload_loop");
  level.shadowkill_struct notify("stop_player_virus_upload_loop");
  upload_virus_exit();
}

upload_virus_loop_anims() {
  level endon("virus_upload_bar_complete");
  level endon("player_leave_upload");
  level endon("force_player_to_end_virus_upload");

  if(common_scripts\utility::flag("player_start_upload")) {
    var_0 = "player_stop_upload";
    var_1 = "player_start_upload";
    level.shadowkill_struct thread maps\_anim::anim_loop(level.virus_upload_anim_array, "virus_upload_active_loop", "stop_player_virus_upload_loop");
  } else {
    var_0 = "player_start_upload";
    var_1 = "player_stop_upload";
    level.shadowkill_struct thread maps\_anim::anim_loop(level.virus_upload_anim_array, "virus_upload_loop", "stop_player_virus_upload_loop");
  }

  while(common_scripts\utility::flag("virus_upload_loop")) {
    common_scripts\utility::flag_wait(var_0);
    level.shadowkill_struct notify("stop_player_virus_upload_loop");
    level.shadowkill_struct thread maps\_anim::anim_loop(level.virus_upload_anim_array, "virus_upload_active_loop", "stop_player_virus_upload_loop");
    common_scripts\utility::flag_wait(var_1);
    level.shadowkill_struct notify("stop_player_virus_upload_loop");
    level.shadowkill_struct thread maps\_anim::anim_loop(level.virus_upload_anim_array, "virus_upload_loop", "stop_player_virus_upload_loop");
  }
}

watch_player_button_press() {
  level endon("force_player_to_end_virus_upload");
  level endon("virus_upload_bar_complete");
  level endon("force_virus_upload_bar_complete");
  common_scripts\utility::flag_wait("virus_upload_loop");

  while(common_scripts\utility::flag("virus_upload_loop")) {
    wait 0.05;

    if(common_scripts\utility::flag("player_leave_upload")) {
      return;
    }
    if(level.player attackbuttonpressed()) {
      var_0 = 0;

      while(level.player attackbuttonpressed()) {
        common_scripts\utility::flag_set("player_start_upload");
        common_scripts\utility::flag_clear("player_stop_upload");
        wait 0.05;
      }

      if(common_scripts\utility::flag("player_start_upload")) {
        common_scripts\utility::flag_set("player_stop_upload");
        common_scripts\utility::flag_clear("player_start_upload");
      }
    }
  }
}

watch_player_left_stick() {
  level endon("force_player_to_end_virus_upload");
  level endon("virus_upload_bar_complete");
  level endon("force_virus_upload_bar_complete");
  common_scripts\utility::flag_clear("player_leave_upload");

  while(common_scripts\utility::flag("virus_upload_loop")) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] < 0) {
      if(common_scripts\utility::flag("player_stop_upload") || !common_scripts\utility::flag("player_start_upload"))
        common_scripts\utility::flag_set("player_leave_upload");
    }

    common_scripts\utility::waitframe();
  }
}

upload_virus_exit() {
  if(common_scripts\utility::flag("virus_upload_bar_complete")) {
    level.shadowkill_struct notify("stop_player_virus_upload_loop");
    level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
    level.shadowkill_struct maps\_anim::anim_single(level.virus_upload_anim_array, "virus_upload_end");
    level.player unlink();

    if(!level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_enableweapon();

    level.player maps\cornered_code::player_showviewmodelsleeveflaps();

    if(!level.player common_scripts\utility::isweaponswitchenabled())
      level.player common_scripts\utility::_enableweaponswitch();

    level.player allowfire(1);
    level.allow_fire = 1;
    level.player enableweaponpickup();
    setsaveddvar("ammoCounterHide", 0);
    level.player allowcrouch(1);
    level.player allowprone(1);
    maps\cornered_code::hide_player_arms();
    level.device hide();
    wait 0.5;
    level.player.is_in_upload = undefined;
    common_scripts\utility::flag_clear("virus_dynamic_dof_on");
  } else {
    level.shadowkill_struct notify("stop_player_virus_upload_loop");
    thread maps\cornered_audio::aud_virus("stop");
    level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
    level.shadowkill_struct thread maps\_anim::anim_single_solo(level.virus_upload_anim_array[0], "virus_upload_end_fast");
    level.shadowkill_struct maps\_anim::anim_single_solo(level.virus_upload_anim_array[1], "virus_upload_end_fast");
    level.player unlink();
    level.player allowcrouch(1);
    level.player allowprone(1);
    maps\cornered_code::hide_player_arms();
    level.device hide();
    wait 0.5;
    level.player.is_in_upload = undefined;
    common_scripts\utility::flag_clear("virus_dynamic_dof_on");

    if(common_scripts\utility::flag("force_player_to_end_virus_upload")) {
      if(level.player getcurrentweapon() == "computer_idf") {
        level.player switchtoweapon(level.player.currentweapon);

        if(!level.player common_scripts\utility::isweaponenabled())
          level.player common_scripts\utility::_enableweapon();

        level.player maps\cornered_code::player_showviewmodelsleeveflaps();
        wait 0.5;
        level.player takeweapon("computer_idf");

        if(!level.player common_scripts\utility::isweaponswitchenabled())
          level.player common_scripts\utility::_enableweaponswitch();

        level.player allowfire(1);
        level.allow_fire = 1;
        level.player enableweaponpickup();
        setsaveddvar("ammoCounterHide", 0);
      } else {
        if(!level.player common_scripts\utility::isweaponenabled())
          level.player common_scripts\utility::_enableweapon();

        level.player maps\cornered_code::player_showviewmodelsleeveflaps();

        if(!level.player common_scripts\utility::isweaponswitchenabled())
          level.player common_scripts\utility::_enableweaponswitch();

        level.player allowfire(1);
        level.allow_fire = 1;
        level.player enableweaponpickup();
        setsaveddvar("ammoCounterHide", 0);
      }
    } else {
      level.player.currentweapon = level.player getcurrentweapon();
      level.player giveweapon("computer_idf");
      level.player switchtoweaponimmediate("computer_idf");

      if(level.player common_scripts\utility::isweaponswitchenabled())
        level.player common_scripts\utility::_disableweaponswitch();

      wait 0.2;

      if(!level.player common_scripts\utility::isweaponenabled())
        level.player common_scripts\utility::_enableweapon();

      level.player maps\cornered_code::player_showviewmodelsleeveflaps();
      setsaveddvar("ammoCounterHide", 1);
      thread player_in_upload_volume();
      upload_virus_enter();
    }
  }
}

player_in_upload_volume() {
  level endon("force_player_upload_end");
  var_0 = getent("player_virus_upload_volume", "targetname");
  level.player allowfire(0);
  level.allow_fire = undefined;
  level.player disableweaponpickup();

  while(level.player istouching(var_0) && !isDefined(level.player.is_in_upload))
    wait 0.05;

  if(isDefined(level.player.is_in_upload)) {
    level.player switchtoweapon(level.player.currentweapon);
    level.player takeweapon("computer_idf");
    return;
  }

  level.player switchtoweapon(level.player.currentweapon);

  if(level.player.currentweapon == "imbel+acog_sp+silencer_sp")
    wait 1.0;
  else
    wait 0.5;

  level.player takeweapon("computer_idf");

  if(!level.player common_scripts\utility::isweaponswitchenabled())
    level.player common_scripts\utility::_enableweaponswitch();

  level.player allowfire(1);
  level.allow_fire = 1;
  level.player enableweaponpickup();
  setsaveddvar("ammoCounterHide", 0);
}

virus_upload_bink_start() {
  if(isDefined(level.start_point) && level.start_point == "shadow_kill")
    wait 2;

  if(isDefined(level.start_point) && level.start_point != "shadow_kill") {
    common_scripts\utility::flag_wait("player_in_power_junction_hallway");
    wait 0.75;
  }

  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame("cornered_pda_upload");

  while(cinematicgetframe() <= 20)
    common_scripts\utility::waitframe();

  pausecinematicingame(1);
}

virus_upload_bink() {
  virus_upload_bink_internal();

  if(!common_scripts\utility::flag("force_virus_upload_bar_complete")) {
    if(!isDefined(level.bink_is_paused)) {
      pausecinematicingame(1);
      level.bink_is_paused = 1;
    }
  }
}

virus_upload_bink_internal() {
  level endon("virus_upload_bar_complete");
  level endon("player_leave_upload");
  level endon("force_player_to_end_virus_upload");
  level endon("force_virus_upload_bar_complete");

  while(common_scripts\utility::flag("virus_upload_loop")) {
    common_scripts\utility::flag_wait("player_start_upload");

    if(common_scripts\utility::flag("virus_upload_loop")) {
      pausecinematicingame(0);
      level.bink_start_time = gettime();
      level.bink_is_paused = undefined;
      thread virus_upload_bink_progress();
    }

    common_scripts\utility::flag_wait_any("virus_upload_bar_complete", "player_stop_upload", "force_player_to_end_virus_upload");

    if(common_scripts\utility::flag("virus_upload_loop")) {
      pausecinematicingame(1);
      level.bink_is_paused = 1;
      wait 0.05;
    }
  }
}

virus_upload_bink_progress() {
  while(!isDefined(level.bink_is_paused)) {
    level.bink_current_time = cinematicgettimeinmsec();
    level.bink_percentage = level.bink_current_time / 22000;

    if(level.bink_percentage == 0)
      level.bink_percentage = 1.0;

    thread maps\cornered_audio::audio_check_to_play_a_beep_or_not();

    if(level.bink_percentage >= 0.2) {
      if(!common_scripts\utility::flag("spawn_power_junction_patrol"))
        common_scripts\utility::flag_set("spawn_power_junction_patrol");
    }

    if(level.bink_percentage >= 0.92) {
      if(!common_scripts\utility::flag("virus_upload_bar_almost_complete"))
        common_scripts\utility::flag_set("virus_upload_bar_almost_complete");
    }

    if(level.bink_percentage >= 0.93) {
      if(!common_scripts\utility::flag("force_virus_upload_bar_complete"))
        common_scripts\utility::flag_set("force_virus_upload_bar_complete");
    }

    if(level.bink_percentage >= 1.0) {
      if(!common_scripts\utility::flag("virus_upload_bar_complete"))
        common_scripts\utility::flag_set("virus_upload_bar_complete");

      break;
    }

    wait 0.05;
  }
}

force_player_to_end_upload() {
  level endon("virus_upload_bar_complete");
  common_scripts\utility::flag_wait_either("force_player_upload_end", "enemies_aware");

  if(isDefined(level.player.is_in_upload)) {
    if(!common_scripts\utility::flag("force_virus_upload_bar_complete")) {
      level.player waittill("damage");
      common_scripts\utility::flag_set("force_player_to_end_virus_upload");
    }
  } else {
    if(isDefined(level.rack_shut))
      level.rack_pull_out_trigger common_scripts\utility::trigger_off();
    else
      level.virus_upload_trigger common_scripts\utility::trigger_off();

    level.rack setModel("cnd_server_rack_anim");

    if(level.player getcurrentweapon() == "computer_idf") {
      level.player switchtoweapon(level.player.currentweapon);
      wait 0.4;

      if(level.player.currentweapon == "imbel+acog_sp+silencer_sp")
        wait 1.0;
      else
        wait 0.5;

      level.player takeweapon("computer_idf");

      if(!level.player common_scripts\utility::isweaponswitchenabled())
        level.player common_scripts\utility::_enableweaponswitch();

      level.player allowfire(1);
      level.allow_fire = 1;
      level.player enableweaponpickup();
      setsaveddvar("ammoCounterHide", 0);
    }
  }

  if(!common_scripts\utility::flag("force_virus_upload_bar_complete")) {
    common_scripts\utility::flag_wait_any("finish_upload", "enemies_aware");

    if(!common_scripts\utility::flag("power_junction_patrol_killed"))
      thread watch_player_after_shadow_kill();

    maps\_utility::delaythread(2, common_scripts\utility::flag_clear, "force_player_to_end_virus_upload");

    if(!common_scripts\utility::flag("enemies_aware"))
      upload_virus_enter();
  }
}

watch_player_after_shadow_kill() {
  level endon("virus_upload_bar_complete");
  common_scripts\utility::flag_wait("enemies_aware");

  if(isDefined(level.rack_shut))
    level.rack_pull_out_trigger common_scripts\utility::trigger_off();
  else
    level.virus_upload_trigger common_scripts\utility::trigger_off();

  level.rack setModel("cnd_server_rack_anim");
  common_scripts\utility::flag_wait("power_junction_patrol_killed");
  upload_virus_enter();
}

inverted_rappel_setup() {
  common_scripts\utility::flag_wait("virus_upload_bar_complete");

  if(!isDefined(level.player_exit_to_inverted_rope)) {
    level.player_exit_to_inverted_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
    level.building_entry_exit_anim_struct maps\_anim::anim_first_frame_solo(level.player_exit_to_inverted_rope, "rappel_stealth_exit");
    level.rorke_exit_to_inverted_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
    level.rorke_exit_to_inverted_rope.animname = "building_entry_rope_rorke";
    level.building_entry_exit_anim_struct maps\_anim::anim_last_frame_solo(level.rorke_exit_to_inverted_rope, "building_entry_rorke");
  }

  common_scripts\utility::exploder(5001);
  common_scripts\utility::exploder(5002);
  common_scripts\utility::exploder(5003);
  common_scripts\utility::exploder(5004);
  common_scripts\utility::exploder(3456);
}

gun_down_trigger() {
  common_scripts\utility::flag_wait("spawn_power_junction_patrol");
  setsaveddvar("aim_aimAssistRangeScale", "0");
  level.player.computer_idf = undefined;
  gun_down_trigger_internal();

  if(isDefined(level.has_hidden_weapon_equipped)) {
    level.player allowsprint(1);
    level.player allowfire(1);
    level.allow_fire = 1;

    if(level.player maps\_utility::isads()) {
      level.player allowfire(1);
      level.allow_fire = 1;

      while(level.player maps\_utility::isads()) {
        if(level.player isfiring()) {
          while(level.player maps\_utility::isads())
            wait 0.05;

          break;
        }

        wait 0.05;
      }
    }

    var_0 = level.player getweaponslistprimaries();
    level.player.equipped_hide_weapon = level.player getcurrentweapon();

    foreach(var_2 in var_0) {
      if(var_2 != level.player.equipped_hide_weapon)
        level.player.unequipped_hide_weapon = var_2;
    }

    determine_weapon();
    var_4 = level.player getweaponammostock(level.player.equipped_hide_weapon);
    var_5 = level.player getweaponammoclip(level.player.equipped_hide_weapon);
    var_6 = level.player getweaponammostock(level.player.unequipped_hide_weapon);
    var_7 = level.player getweaponammoclip(level.player.unequipped_hide_weapon);

    if(level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_disableweapon();

    wait 0.5;
    level.player takeallweapons();
    level.player giveweapon(level.player.equipped_weapon, 0, 0, 0, 1);
    level.player giveweapon(level.player.unequipped_weapon, 0, 0, 0, 1);
    level.player switchtoweapon(level.player.equipped_weapon);
    wait 0.3;
    level.player setweaponammostock(level.player.equipped_weapon, var_4);
    level.player setweaponammoclip(level.player.equipped_weapon, var_5);
    level.player setweaponammostock(level.player.unequipped_weapon, var_6);
    level.player setweaponammoclip(level.player.unequipped_weapon, var_7);

    if(!level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_enableweapon();
  }
}

gun_down_trigger_internal() {
  level endon("shadow_kill_stab");
  level endon("enemies_aware");
  level.has_hidden_weapon_equipped = undefined;

  for(;;) {
    common_scripts\utility::flag_wait("gun_down_trigger");
    level.player allowsprint(0);
    var_0 = level.player getweaponslistprimaries();

    foreach(var_2 in var_0) {
      if(var_2 == "computer_idf") {
        if(level.player getcurrentweapon() == "computer_idf")
          level.player.computer_idf = 1;

        level.player.equipped_weapon = level.player.currentweapon;
        level.player takeweapon("computer_idf");
        setsaveddvar("ammoCounterHide", 0);
      }
    }

    var_0 = level.player getweaponslistprimaries();

    if(!isDefined(level.player.computer_idf))
      level.player.equipped_weapon = level.player getcurrentweapon();
    else
      level.player.computer_idf = undefined;

    foreach(var_2 in var_0) {
      if(var_2 != level.player.equipped_weapon)
        level.player.unequipped_weapon = var_2;
    }

    determine_weapon(1);
    var_6 = level.player getweaponammostock(level.player.equipped_weapon);
    var_7 = level.player getweaponammoclip(level.player.equipped_weapon);
    var_8 = level.player getweaponammostock(level.player.unequipped_weapon);
    var_9 = level.player getweaponammoclip(level.player.unequipped_weapon);

    if(level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_disableweapon();

    if(level.player.equipped_weapon == "imbel+acog_sp+silencer_sp")
      wait 1.0;
    else
      wait 0.5;

    level.player takeallweapons();
    level.player giveweapon(level.player.equipped_hide_weapon, 0, 0, 0, 1);
    level.player giveweapon(level.player.unequipped_hide_weapon, 0, 0, 0, 1);
    level.player switchtoweapon(level.player.equipped_hide_weapon);
    wait 0.3;
    level.player setweaponammostock(level.player.equipped_hide_weapon, var_6);
    level.player setweaponammoclip(level.player.equipped_hide_weapon, var_7);
    level.player setweaponammostock(level.player.unequipped_hide_weapon, var_8);
    level.player setweaponammoclip(level.player.unequipped_hide_weapon, var_9);

    if(!level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_enableweapon();

    if(level.player.equipped_hide_weapon == "imbel_hide_acog_silenced_cornered+acog_sp+silencer_sp")
      wait 0.5;
    else
      wait 0.5;

    level.has_hidden_weapon_equipped = 1;
    thread hold_fire_unless_ads();
    common_scripts\utility::flag_waitopen("gun_down_trigger");
    level.player allowsprint(1);
    var_0 = level.player getweaponslistprimaries();
    level.player.equipped_hide_weapon = level.player getcurrentweapon();

    foreach(var_2 in var_0) {
      if(var_2 != level.player.equipped_hide_weapon)
        level.player.unequipped_hide_weapon = var_2;
    }

    determine_weapon();
    var_12 = level.player getweaponammostock(level.player.equipped_hide_weapon);
    var_13 = level.player getweaponammoclip(level.player.equipped_hide_weapon);
    var_14 = level.player getweaponammostock(level.player.unequipped_hide_weapon);
    var_15 = level.player getweaponammoclip(level.player.unequipped_hide_weapon);

    if(level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_disableweapon();

    if(level.player.equipped_hide_weapon == "imbel_hide_acog_silenced_cornered+acog_sp+silencer_sp")
      wait 0.5;
    else
      wait 0.5;

    level.player takeallweapons();
    level.player giveweapon(level.player.equipped_weapon, 0, 0, 0, 1);
    level.player giveweapon(level.player.unequipped_weapon, 0, 0, 0, 1);
    level.player switchtoweapon(level.player.equipped_weapon);
    wait 0.3;
    level.player setweaponammostock(level.player.equipped_weapon, var_12);
    level.player setweaponammoclip(level.player.equipped_weapon, var_13);
    level.player setweaponammostock(level.player.unequipped_weapon, var_14);
    level.player setweaponammoclip(level.player.unequipped_weapon, var_15);

    if(!level.player common_scripts\utility::isweaponenabled())
      level.player common_scripts\utility::_enableweapon();

    if(level.player.equipped_weapon == "imbel+acog_sp+silencer_sp")
      wait 0.5;
    else
      wait 0.5;

    level.has_hidden_weapon_equipped = undefined;
  }
}

determine_weapon(var_0) {
  level endon("shadow_kill_stab");
  level endon("enemies_aware");

  if(isDefined(var_0)) {
    if(level.player.equipped_weapon == "imbel+acog_sp+silencer_sp") {
      level.player.equipped_hide_weapon = "imbel_hide_acog_silenced_cornered+acog_sp+silencer_sp";
      level.player.unequipped_hide_weapon = "kriss_hide_eotech_silenced_cornered+eotechsmg_sp+silencer_sp";
    } else {
      level.player.equipped_hide_weapon = "kriss_hide_eotech_silenced_cornered+eotechsmg_sp+silencer_sp";
      level.player.unequipped_hide_weapon = "imbel_hide_acog_silenced_cornered+acog_sp+silencer_sp";
    }
  } else if(level.player.equipped_hide_weapon == "imbel_hide_acog_silenced_cornered+acog_sp+silencer_sp") {
    level.player.equipped_weapon = "imbel+acog_sp+silencer_sp";
    level.player.unequipped_weapon = "kriss+eotechsmg_sp+silencer_sp";
  } else {
    level.player.equipped_weapon = "kriss+eotechsmg_sp+silencer_sp";
    level.player.unequipped_weapon = "imbel+acog_sp+silencer_sp";
  }
}

hold_fire_unless_ads() {
  level endon("shadow_kill_stab");
  level endon("enemies_aware");

  while(common_scripts\utility::flag("gun_down_trigger")) {
    level.player allowfire(0);
    level.allow_fire = undefined;

    if(level.player playerads() == 1) {
      wait 0.1;
      level.player allowfire(1);
      level.allow_fire = 1;

      while(level.player playerads() == 1) {
        if(level.player isfiring()) {
          while(level.player playerads() == 1)
            wait 0.05;

          level.player allowfire(0);
          level.allow_fire = undefined;
        }

        wait 0.05;
      }
    }

    wait 0.05;
  }

  level.player allowfire(1);
  level.allow_fire = 1;
}

shut_server_rack() {
  level endon("virus_upload_bar_complete");
  level endon("enemies_aware");
  common_scripts\utility::flag_wait("force_player_upload_end");

  if(isDefined(level.player.is_in_upload)) {
    while(isDefined(level.player.is_in_upload))
      wait 0.05;
  }

  level.shadowkill_struct maps\_anim::anim_single_solo(level.virus_upload_anim_array[2], "virus_upload_end");
  level.rack_shut = 1;
}

festival_spotlights() {
  var_0 = common_scripts\utility::getstructarray("festival_spotlight", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = maps\_utility::spawn_anim_model("festival_spotlight", var_3.origin);
    var_4 linkto(level.vista_pivot);
    var_1 = common_scripts\utility::add_to_array(var_1, var_4);
  }

  foreach(var_4 in var_1) {
    playFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_1");
    playFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_2");
    wait(randomfloatrange(0.1, 0.8));
    var_4 thread maps\_anim::anim_loop_solo(var_4, "cornered_festival_spotlight_1", "stop_loop");
  }

  if(level.start_point == "intro" || level.start_point == "zipline" || level.start_point == "rappel_stealth" || level.start_point == "building_entry" || level.start_point == "shadow_kill" || level.start_point == "inverted_rappel" || level.start_point == "courtyard")
    common_scripts\utility::flag_wait("baker_security_vo");

  foreach(var_4 in var_1) {
    stopFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_1");
    stopFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_2");
    var_4 notify("stop_loop");
    var_4 stopanimscripted();
  }

  common_scripts\utility::flag_wait("fall_down_shake");

  foreach(var_4 in var_1) {
    playFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_1");
    playFXOnTag(level._effect["vfx_festival_spot_cnd"], var_4, "J_prop_2");
    wait(randomfloatrange(0.1, 0.8));
    var_4 thread maps\_anim::anim_loop_solo(var_4, "cornered_festival_spotlight_1", "stop_loop");
  }
}

festival_balloons() {
  var_0 = getEntArray("balloon_cluster_1", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_0, var_1);
  var_2 = getEntArray("balloon_cluster_2", "script_noteworthy");
  var_3 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_2, var_3);
  var_4 = getEntArray("balloon_cluster_3", "script_noteworthy");
  var_5 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_4, var_5);
  var_6 = getEntArray("balloon_cluster_4", "script_noteworthy");
  var_7 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_6, var_7);
  var_8 = getEntArray("balloon_cluster_5", "script_noteworthy");
  var_9 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_8, var_9);
  var_10 = getEntArray("balloon_cluster_6", "script_noteworthy");
  var_11 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_10, var_11);
  var_12 = getEntArray("balloon_cluster_7", "script_noteworthy");
  var_13 = maps\_utility::spawn_anim_model("festival_balloon");
  thread festival_balloons_internal(var_12, var_13);
}

festival_balloons_internal(var_0, var_1) {
  var_1 linkto(level.vista_pivot);

  foreach(var_3 in var_0)
  var_3 linkto(var_1, "J_prop_1");

  wait(randomfloatrange(0.3, 2.5));
  var_1 thread maps\_anim::anim_loop_solo(var_1, "cornered_balloon_wiggle", "stop_loop");

  if(level.start_point == "intro" || level.start_point == "zipline" || level.start_point == "rappel_stealth" || level.start_point == "building_entry" || level.start_point == "shadow_kill" || level.start_point == "inverted_rappel" || level.start_point == "courtyard")
    common_scripts\utility::flag_wait("baker_security_vo");

  var_1 notify("stop_loop");
  var_1 stopanimscripted();
  common_scripts\utility::flag_wait("fall_down_shake");
  wait(randomfloatrange(0.3, 2.5));
  var_1 thread maps\_anim::anim_loop_solo(var_1, "cornered_balloon_wiggle", "stop_loop");
}

ambient_building_lights() {
  var_0 = getent("window_light_1a", "targetname");
  var_1 = getent("window_light_1b", "targetname");
  var_2 = getent("window_light_1c", "targetname");
  var_3 = getent("window_light_1d", "targetname");
  var_4 = getent("window_light_4a", "targetname");
  var_5 = getent("window_light_4b", "targetname");
  var_0 thread ambient_building_lights_internal(5, 15);
  var_1 thread ambient_building_lights_internal(0, 10);
  var_2 thread ambient_building_lights_internal(5, 15);
  var_3 thread ambient_building_lights_internal(0, 10);
  var_4 thread ambient_building_lights_internal(5, 15);
  var_5 thread ambient_building_lights_internal(0, 10);
  var_6 = getent("vista_elevator_a", "targetname");
  var_7 = getent("vista_elevator_b", "targetname");
  var_8 = getent("vista_elevator_c", "targetname");
  var_9 = getent("vista_elevator_d", "targetname");
  var_6 thread ambient_building_elevators(19184, 29680);
  var_7 thread ambient_building_elevators(19184, 29680);
  var_8 thread ambient_building_elevators(7138, 23298);
  var_9 thread ambient_building_elevators(7138, 23298);
}

ambient_building_lights_internal(var_0, var_1) {
  if(common_scripts\utility::cointoss()) {
    self hide();
    self.is_hidden = 1;
  } else
    self.is_hidden = undefined;

  while(!common_scripts\utility::flag("baker_security_vo")) {
    wait(randomfloatrange(var_0, var_1));

    if(isDefined(self.is_hidden)) {
      self show();
      self.is_hidden = undefined;
      continue;
    }

    self hide();
    self.is_hidden = 1;
  }

  if(isDefined(self))
    self delete();
}

ambient_building_elevators(var_0, var_1) {
  while(!common_scripts\utility::flag("baker_security_vo")) {
    if(common_scripts\utility::cointoss())
      self.going_up = 1;
    else
      self.going_up = undefined;

    var_2 = 180 * randomintrange(5, 40);
    var_3 = var_2 * 0.005;

    if(self.origin[2] + var_2 > var_1 && isDefined(self.going_up)) {
      continue;
    }
    if(self.origin[2] - var_2 < var_0 && !isDefined(self.going_up)) {
      continue;
    }
    if(isDefined(self.going_up)) {
      self moveto(self.origin + (0, 0, var_2), var_3, 0.5, 0.5);
      self.going_up = undefined;
      wait(var_3);
    } else {
      self moveto(self.origin + (0, 0, var_2 * -1), var_3, 0.5, 0.5);
      self.going_up = 1;
      wait(var_3);
    }

    wait(randomfloatrange(5, 10));
  }

  if(isDefined(self))
    self delete();
}

building_entry_combat() {
  var_0 = getent("player_out_rorke_building_entry_volume", "targetname");
  thread maps\cornered_code::watch_player_in_volume(var_0, "player_out_of_rorkes_way");
  common_scripts\utility::flag_wait("player_out_of_rorkes_way");
  level.rappel_max_lateral_dist_right = 200;
  level.rappel_max_lateral_dist_left = 370;
  maps\cornered_code::waittill_player_looking_at_rorke(10);
  common_scripts\utility::flag_set("player_looking_towards_rorke");
}

allies_building_entry_vo() {
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_rke_targetfloor");

  if(!isDefined(level.building_entry_startpoint))
    thread player_in_rorkes_way();

  common_scripts\utility::flag_wait("rorke_started_cutting_glass");
  wait 1;
  common_scripts\utility::flag_set("enter_building_ready");
  common_scripts\utility::flag_wait("player_finished_cutting");
  common_scripts\utility::flag_wait("player_in_building");
  maps\_utility::music_play("mus_cornered_entry");
  level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_powersystemisin");
  wait 1;
  common_scripts\utility::flag_set("building_entry_finished");
  wait 2.5;
  thread maps\cornered::obj_upload_virus();
}

player_in_rorkes_way() {
  level endon("player_out_of_rorkes_way");
  wait 3;

  if(!common_scripts\utility::flag("player_out_of_rorkes_way"))
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_youreinmyway");

  var_0 = maps\_utility::make_array("cornered_mrk_move", "cornered_mrk_youreinmyway");
  thread maps\cornered_code::nag_until_flag(var_0, "player_out_of_rorkes_way", 10, 15, 5);
}

nag_player_to_jump() {
  wait 1;

  if(!common_scripts\utility::flag("player_jumped_into_building"))
    maps\cornered_code::temp_dialogue("Rorke", "Rook, kick that glass in and get in here!");
}

allies_building_entry_movement() {
  if(isDefined(level.building_entry_startpoint)) {
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
    common_scripts\utility::waitframe();
  }

  if(self.animname == "rorke") {
    if(!isDefined(level.building_entry_startpoint)) {
      maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
      maps\cornered_code_rappel_allies::ally_rappel_stop_shooting();
      rorke_move_to_building_entry();
    }

    rorke_building_entry_movement();
  } else if(isDefined(level.building_entry_startpoint))
    level.building_entry_exit_anim_struct thread maps\_anim::anim_loop_solo(self, "cnd_rappel_inverted_idle_" + self.animname, "stop_loop");
  else {
    maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
    maps\cornered_code_rappel_allies::ally_rappel_stop_shooting();
    baker_building_entry_movement();
  }
}

baker_building_entry_movement() {
  self notify("stop_loop");
  self stopanimscripted();
  maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
}

rorke_move_to_building_entry() {
  self notify("stop_loop");

  if(!common_scripts\utility::flag("player_out_of_rorkes_way")) {
    maps\cornered_code_rappel_allies::ally_start_calm_idle("stealth");
    common_scripts\utility::flag_wait("player_out_of_rorkes_way");
    maps\cornered_code_rappel_allies::ally_stop_calm_idle();
  }

  var_0 = self.origin[0];
  var_1 = level.rorke_glass_start_org[0];
  var_2 = abs(var_0 - var_1);
  var_3 = 9;
  var_4 = maps\cornered_code::ally_get_horizontal_start_distance("left");
  var_5 = maps\cornered_code::ally_get_horizontal_stop_distance("left");
  var_6 = var_4 + var_5;

  if(var_2 < var_6 - var_3) {
    return;
  }
  var_7 = "move_back_start";
  var_8 = "move_back";
  var_9 = "move_back_stop";
  var_10 = var_1 + var_5;
  self notify("stop_loop");
  maps\_anim::anim_single_solo(self, var_7);
  var_0 = self.origin[0];
  var_11 = 9;
  var_0 = var_0 - var_11;

  if(var_0 > var_10) {
    thread maps\_anim::anim_loop_solo(self, var_8, "stop_loop");

    while(var_0 > var_10) {
      common_scripts\utility::waitframe();
      var_0 = self.origin[0] - var_11;
    }
  }

  var_12 = (var_10, self.origin[1], level.rorke_glass_start_org[2]);
  self forceteleport(var_12, self.angles, 20);
  maps\_anim::anim_single_solo(self, var_9);
}

rorke_building_entry_movement() {
  self.cnd_rappel_tele_rope.animname = "building_entry_rope_rorke";
  var_0 = [];
  var_0[0] = self;
  var_0[1] = self.cnd_rappel_tele_rope;
  level.building_entry_exit_anim_struct maps\_anim::anim_first_frame(var_0, "building_entry_rorke");
  maps\cornered_code_rappel_allies::ally_rappel_start_aiming("stealth");
  common_scripts\utility::flag_wait("player_looking_towards_rorke");
  maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  thread maps\cornered_audio::aud_rappel("r_glass");
  maps\cornered_code_rappel_allies::ally_rappel_stop_rope();
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single(var_0, "building_entry_rorke");
  thread glass_cutting_fx_notetrack_handler();
  wait 2.25;
  common_scripts\utility::flag_set("rorke_started_cutting_glass");
  self waittillmatch("single anim", "end");
  maps\cornered_code_rappel_allies::ally_rappel_rope_cleanup();
  self.ignoreall = 1;
  self.moveplaybackrate = 0.92;
  var_1 = getnode("rorke_entry_node", "targetname");
  thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_1);
  common_scripts\utility::flag_wait("move_to_power_junction_room_entrance");
  var_1 = getnode("rorke_power_junction_entrance_node", "targetname");
  thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_1);
  common_scripts\utility::flag_wait("move_into_power_junction_room");
  common_scripts\utility::flag_set("player_can_upload_virus");
  self.moveplaybackrate = 1;
}

handle_shadow_kill() {
  if(isDefined(level.shadow_kill_startpoint)) {
    thread setup_window_cutout(level.clean_window_player, "cnd_window_pane_cutout_player");
    thread setup_window_cutout(level.clean_window_rorke, "cnd_window_pane_cutout_ally");
    common_scripts\utility::flag_set("player_can_upload_virus");
    var_0 = getent("move_into_power_junction_room_trigger", "targetname");
    var_0 delete();
    var_0 = getent("move_to_power_junction_room_entrance_trigger", "targetname");
    var_0 delete();
    level.shadowkill_struct = common_scripts\utility::getstruct("shadow_kill_anim_struct", "targetname");
    level.rappel_entry_anim_struct = common_scripts\utility::getstruct("rappel_entry_anim_struct_stealth", "targetname");
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
  }

  level.force_rorke_pathing_clip = getent("force_rorke_pathing_clip", "targetname");
  level.force_rorke_pathing_clip notsolid();
  level.force_rorke_pathing_clip connectpaths();
  thread upload_virus_setup();
}

shadow_kill_combat() {
  level.patrol_react_anim_count = 1;
  maps\_utility::array_spawn_function_targetname("power_junction_patrollers", ::power_junction_patrollers);
  common_scripts\utility::flag_clear("enemies_aware");
  level.first_two_patrollers_at_goal = 0;
  level.second_two_patrollers_at_goal = 0;
  common_scripts\utility::flag_wait("spawn_power_junction_patrol");
  thread door_sounds("door_sound_struct", "crnd_door_open1_virus_room", "crnd_door_close1_virus_room");
  var_0 = maps\_utility::array_spawn_targetname("power_junction_patrollers");
  thread manage_power_junction_patrol();
  thread shadow_kill_patrol_vo();
  level.patroller_deleted = 0;
  thread check_patrol_in_volume(var_0);
  thread watch_for_player_to_break_stealth(var_0);
  common_scripts\utility::flag_wait_either("all_in", "enemies_aware");
  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  maps\_utility::waittill_dead(var_0);
  common_scripts\utility::flag_set("power_junction_patrol_killed");
}

door_sounds(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct(var_0, "targetname");
  thread common_scripts\utility::play_sound_in_space(var_1, var_3.origin);
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space(var_2, var_3.origin);
}

manage_power_junction_patrol() {
  level endon("enemies_aware");
  wait 2.0;
  common_scripts\utility::flag_set("start_power_junction_patrol_chatter");
  wait 2.0;
  common_scripts\utility::flag_set("start_power_junction_patrol_wave_1");
  wait 2.0;
  common_scripts\utility::flag_set("start_power_junction_patrol_wave_2");
}

power_junction_patrollers() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";
  self.allowdeath = 1;
  self.patrol_walk_anim = "cornered_shadowkill_patrol_walk";

  if(self.script_noteworthy == "shadow_kill_enemy")
    thread shadow_kill_enemy_setup();
  else {
    thread maps\cornered_code::wait_till_shot(undefined, "enemies_aware");
    thread stealth_is_broken();
    thread alert_all_on_death();
  }

  self.volume = getent("power_junction_patrollers_start_hallway_volume", "targetname");
  thread maps\cornered_code::watch_for_death_and_alert_all_in_volume("enemies_aware", "enemies_aware");

  if(self.script_noteworthy == "enemy_1") {
    level.first_patroller = self;
    common_scripts\utility::flag_wait("start_power_junction_patrol_wave_1");
    thread waittill_goal_and_animate();
  }

  if(self.script_noteworthy == "enemy_2") {
    level.second_patroller = self;
    common_scripts\utility::flag_wait("start_power_junction_patrol_wave_1");
    thread waittill_goal_and_animate();
  }

  if(self.script_noteworthy == "enemy_3") {
    common_scripts\utility::flag_wait("start_power_junction_patrol_wave_2");
    thread waittill_goal_and_animate();
  }

  if(self.script_noteworthy == "enemy_4") {
    common_scripts\utility::flag_wait("start_power_junction_patrol_wave_2");
    thread waittill_goal_and_animate();
    var_0 = getent("power_junction_post_shadow_kill_volume", "targetname");
    thread handle_volume_touching(var_0, "last_patroller_out_of_shadow_kill_volume", "last_patroller_out_of_shadow_kill_volume");
  }
}

waittill_goal_and_animate() {
  self endon("death");
  level endon("enemies_aware");
  self waittill("reached_path_end");

  if(self.script_noteworthy == "enemy_1" || self.script_noteworthy == "enemy_2") {
    level.first_two_patrollers_at_goal++;

    while(level.first_two_patrollers_at_goal < 2)
      wait 0.05;
  }

  if(self.script_noteworthy == "enemy_3" || self.script_noteworthy == "enemy_4") {
    level.second_two_patrollers_at_goal++;

    while(level.second_two_patrollers_at_goal < 2)
      wait 0.05;
  }

  level.shadowkill_struct thread maps\_anim::anim_single_solo(self, "cornered_shadowkill_" + self.script_noteworthy);
  self waittillmatch("single anim", "end");
  var_0 = common_scripts\utility::getstruct("resume_patrol_" + self.script_noteworthy, "targetname");
  self.target = var_0.targetname;
  self notify("end_patrol");
  thread maps\_patrol::patrol(self.target);
}

shadow_kill_enemy_setup() {
  self endon("death");
  level endon("enemies_aware");
  level.shadow_kill_enemy = self;
  thread maps\cornered_code::wait_till_shot("shadow_kill_stab", "enemies_aware");
  thread stealth_is_broken("shadow_kill_stab");
  thread alert_all_on_death();
  common_scripts\utility::flag_wait("start_power_junction_patrol_wave_2");
  wait 0.5;
  self waittill("goal");
  level.shadowkill_struct maps\_anim::anim_reach_solo(self, "shadowkill_end_enemy");
  level.shadowkill_struct thread maps\_anim::anim_single_solo(self, "shadowkill_end_enemy");
  thread shadowkill_phone_off();
  thread shadow_kill_enemy();
}

alert_all_on_death() {
  level endon("shadow_kill_stab");
  self waittill("death");

  if(!common_scripts\utility::flag("enemies_aware"))
    common_scripts\utility::flag_set("enemies_aware");
}

shadow_kill_enemy() {
  common_scripts\utility::flag_wait("shadow_kill_stab");
  self.allowdeath = 0;
  self.team = "neutral";
  self setCanDamage(0);
  self.ignoreme = 1;
  self waittillmatch("single anim", "end");
  self.a.nodeath = 1;
  self.diequietly = 1;
  self.allowdeath = 1;
  self.noragdoll = 1;
  self.a.disablelongdeath = 1;
  self kill();
}

stop_patrol_vo() {
  self endon("death");
  level waittill("enemies_aware");
  self stopsounds();
}

shadow_kill_patrol_vo() {
  level.first_patroller endon("death");
  level.second_patroller endon("death");
  level endon("enemies_aware");
  level.first_patroller thread stop_patrol_vo();
  level.second_patroller thread stop_patrol_vo();
  common_scripts\utility::flag_wait("start_power_junction_patrol_chatter");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_imalmostdonewith");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_iheartheresa");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_maybeilldothat");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_youdontwantto");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_laughter");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_laughter");
  common_scripts\utility::flag_wait("force_player_upload_end");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_maybeillgoto");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_iwishicould");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_leaveearlywhosgonna");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_whatifweget");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_wewontgetcaught");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_allrightletsgo");
  wait 2.5;
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_heyweshouldsee");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_areyoucrazyhes");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_imsurehecan");
  level.second_patroller maps\_utility::smart_dialogue("cornered_saf2_youmyfriendare");
  level.first_patroller maps\_utility::smart_dialogue("cornered_saf1_imnottroublei");
  maps\cornered_audio::aud_filter_off();
  level.player seteqlerp(1, 1);
}

stealth_is_broken(var_0) {
  self endon("death");

  if(isDefined(var_0))
    level endon(var_0);

  common_scripts\utility::flag_wait("enemies_aware");
  maps\_utility::anim_stopanimscripted();
  self notify("end_patrol");
  maps\_utility::set_moveplaybackrate(1.0);
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  maps\_utility::set_baseaccuracy(15);
  player_seek_cnd();
}

player_seek_cnd() {
  self endon("death");
  self endon("stop_player_seek");
  self.goalradius = 100;
  wait(randomfloatrange(0, 2));

  for(;;) {
    var_0 = getnodesinradiussorted(level.player.origin, 500, 0, 128);

    if(isDefined(var_0) && var_0.size > 0) {
      self setgoalnode(var_0[0]);
      wait(randomfloatrange(2, 5));
      continue;
    }

    self setgoalpos(level.player.origin);
    wait(randomfloatrange(1, 2));
  }
}

check_patrol_in_volume(var_0) {
  level endon("enemies_aware");
  var_1 = getent("delete_power_junction_patrol_volume", "targetname");
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isalive(var_4) && var_4.script_noteworthy != "shadow_kill_enemy")
      var_2 = common_scripts\utility::add_to_array(var_2, var_4);
  }

  for(;;) {
    var_6 = 1;

    foreach(var_8 in var_2) {
      if(isalive(var_8) && !var_8 istouching(var_1))
        var_6 = 0;
    }

    if(var_6) {
      foreach(var_8 in var_2) {
        if(isalive(var_8))
          var_8 thread wait_till_offscreen_then_delete();
      }

      break;
    }

    wait 0.05;
  }

  while(level.patroller_deleted < var_2.size)
    wait 0.05;

  common_scripts\utility::flag_set("all_in");
  thread door_sounds("door_sound_struct_2", "crnd_door_open2_virus_room", "crnd_door_close2_virus_room");
}

wait_till_offscreen_then_delete() {
  level endon("enemies_aware");
  var_0 = 0;

  while(!var_0) {
    if(!maps\_utility::player_can_see_ai(self)) {
      var_0 = 1;
      continue;
    }

    wait 0.1;
  }

  self delete();
  level.patroller_deleted++;
}

watch_for_player_to_break_stealth(var_0) {
  level endon("all_in");
  var_1 = getent("watch_for_player_shoot_volume", "targetname");
  common_scripts\utility::array_thread(var_0, ::watch_for_player_to_shoot_while_enemy_in_volume, var_1, "enemies_aware", "all_in");
  var_1 = getent("power_junction_patrollers_start_hallway_volume", "targetname");
  level.player thread handle_volume_touching(var_1, "enemies_aware", "patrol_out_of_start_hallway");
  var_1 = getent("power_junction_shadow_kill_volume", "targetname");
  common_scripts\utility::array_thread(var_0, ::handle_volume_touching, var_1, "patrol_out_of_start_hallway", "patrol_out_of_start_hallway");
  common_scripts\utility::flag_wait("patrol_out_of_start_hallway");
  var_1 = getent("power_junction_shadow_kill_volume", "targetname");
  level.player thread handle_volume_touching(var_1, "enemies_aware", "shadow_kill_stab");
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy != "shadow_kill_enemy")
      var_2 = common_scripts\utility::add_to_array(var_2, var_4);
  }

  var_1 = getent("power_junction_post_shadow_kill_volume", "targetname");
  common_scripts\utility::array_thread(var_2, ::handle_volume_touching, var_1, "patrol_out_of_shadow_kill_volume", "patrol_out_of_shadow_kill_volume");
  common_scripts\utility::flag_wait("patrol_out_of_shadow_kill_volume");
  var_1 = getent("power_junction_post_shadow_kill_volume", "targetname");
  common_scripts\utility::array_thread(var_2, ::handle_volume_touching, var_1, "enemies_aware", "enemies_aware", 1);
  var_1 = getent("power_junction_weapons_free_volume", "targetname");
  common_scripts\utility::array_thread(var_0, ::handle_volume_touching, var_1, "patrol_out_of_power_junction_hallway", "enemies_aware");
  common_scripts\utility::flag_wait("patrol_out_of_power_junction_hallway");
  var_1 = getent("outside_power_junction_hallway_volume", "targetname");
  level.player thread handle_volume_touching(var_1, "enemies_aware", "enemies_aware");
}

watch_for_player_to_shoot_while_enemy_in_volume(var_0, var_1, var_2) {
  self endon("death");

  while(!common_scripts\utility::flag(var_2)) {
    if(self istouching(var_0) && level.player istouching(var_0)) {
      if(level.player attackbuttonpressed() && !isDefined(level.player.is_in_upload) && level.player getcurrentweapon() != "computer_idf") {
        if(isDefined(level.allow_fire)) {
          if(!common_scripts\utility::flag(var_1))
            common_scripts\utility::flag_set(var_1);
        }

        break;
      }
    }

    wait 0.01;
  }
}

handle_volume_touching(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("enemies_aware");

  if(isDefined(var_2))
    level endon(var_2);

  for(;;) {
    if(self istouching(var_0)) {
      if(isDefined(var_3)) {
        if(level.player istouching(var_0)) {
          var_4 = distance(level.player.origin, self.origin);

          if(var_4 < 200) {
            common_scripts\utility::flag_set(var_1);
            break;
          }
        }
      } else {
        common_scripts\utility::flag_set(var_1);
        break;
      }
    }

    wait 0.05;
  }
}

allies_shadow_kill_vo() {
  thread rorke_shadow_kill_vo();
  thread stealth_break_rorke_vo();
  common_scripts\utility::flag_wait_any("all_in", "enemies_aware");

  if(common_scripts\utility::flag("enemies_aware") && !common_scripts\utility::flag("all_in"))
    common_scripts\utility::flag_wait("power_junction_patrol_killed");

  if(!common_scripts\utility::flag("virus_upload_bar_complete"))
    common_scripts\utility::flag_wait("virus_upload_bar_complete");

  wait 1;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_letsgettothe");
  common_scripts\utility::flag_set("obj_upload_virus_complete");
  level.start_inverted_rappel_trigger common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait("start_inverted_rappel");
  common_scripts\utility::flag_set("shadow_kill_finished");
}

rorke_shadow_kill_vo() {
  level endon("enemies_aware");
  common_scripts\utility::flag_wait("player_in_power_junction_hallway");

  if(!common_scripts\utility::flag("rorke_at_virus_upload")) {
    common_scripts\utility::flag_wait("rorke_at_virus_upload");

    if(!common_scripts\utility::flag("player_started_virus_upload"))
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_uploadthevirus");
  }

  var_0 = maps\_utility::make_array("cornered_mrk_planttheviruswe", "cornered_mrk_moveyourasscmon");
  thread maps\cornered_code::nag_until_flag(var_0, "player_started_virus_upload", 10, 15, 5);
  thread weapon_down_vo();
  common_scripts\utility::flag_wait("let_them_pass");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_letthempass");
  maps\_utility::music_play("mus_cornered_takedown");
  common_scripts\utility::flag_wait("shadow_kill_done");

  if(!common_scripts\utility::flag("virus_upload_bar_complete")) {
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_ivegotyourback");
    common_scripts\utility::flag_set("finish_upload");
    thread virus_upload_vo_nags();
    common_scripts\utility::flag_wait("virus_upload_bar_complete");
    wait 1.5;
  } else
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_waitforemto");
}

virus_upload_vo_nags() {
  var_0 = maps\_utility::make_array("cornered_mrk_planttheviruswe", "cornered_mrk_moveyourasscmon");
  thread maps\cornered_code::nag_until_flag(var_0, "player_start_upload", 10, 15, 5);
}

weapon_down_vo() {
  level endon("enemies_aware");
  level endon("let_them_pass");
  common_scripts\utility::flag_wait("rorke_in_alcove");
  var_0 = getent("player_shadow_kill_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      level.allies[level.const_rorke] thread maps\_utility::smart_radio_dialogue("cornered_mrk_weapondown");
      break;
    }

    wait 0.05;
  }
}

stealth_break_rorke_vo() {
  level endon("all_in");
  common_scripts\utility::flag_wait("enemies_aware");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_shitwhatareyou");
  common_scripts\utility::flag_wait("power_junction_patrol_killed");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_targetsdown");

  if(!common_scripts\utility::flag("virus_upload_bar_complete")) {
    wait 1;
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_finishtheupload");
    common_scripts\utility::flag_set("finish_upload");
    thread virus_upload_vo_nags();
  }
}

allies_shadow_kill_movement() {
  if(!isDefined(level.building_entry_exit_anim_struct)) {
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
    common_scripts\utility::waitframe();
  }

  if(self.animname == "rorke") {
    thread shadow_kill_leadup();
    thread rorke_react_to_stealth_break("shadow_kill_stab");
    common_scripts\utility::flag_wait("power_junction_patrol_killed");

    if(common_scripts\utility::flag("shadow_kill_stab") || common_scripts\utility::flag("enemies_aware")) {
      maps\_utility::enable_surprise();
      self.ignoresuppression = 0;
      self.disablebulletwhizbyreaction = 0;
      self.disablefriendlyfirereaction = 0;
      self.disablereactionanims = 0;
      maps\_utility::set_baseaccuracy(1);
    }

    if(!common_scripts\utility::flag("virus_upload_bar_complete")) {
      if(common_scripts\utility::flag("enemies_aware")) {
        var_0 = getnode("rorke_wait_for_virus_upload_node", "targetname");
        thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_0);
      }

      common_scripts\utility::flag_wait("virus_upload_bar_complete");
      wait 2;
    }

    thread allies_building_exit_hookup();
  } else if(isDefined(level.shadow_kill_startpoint))
    level.building_entry_exit_anim_struct thread maps\_anim::anim_loop_solo(self, "cnd_rappel_inverted_idle_" + self.animname, "stop_loop");
  else {
    common_scripts\utility::flag_wait("player_started_virus_upload");
    maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
    level.allies[0] maps\cornered_code_rappel_allies::ally_rappel_stop_rope();
    level.allies[0].cnd_rappel_tele_rope delete();
    level.building_entry_exit_anim_struct notify("stop_loop");
    level.building_entry_exit_anim_struct thread maps\_anim::anim_loop_solo(self, "cnd_rappel_inverted_idle_" + self.animname, "stop_loop");
  }
}

shadow_kill_leadup() {
  level endon("enemies_aware");
  self.ignoreall = 1;

  if(!isDefined(level.shadow_kill_startpoint))
    common_scripts\utility::flag_wait("move_into_power_junction_room");

  thread maps\cornered_audio::aud_virus("r_approach");
  level.shadowkill_struct maps\_anim::anim_reach_solo(self, "virus_upload_enter_rorke");
  level.shadowkill_struct maps\_anim::anim_single_solo(self, "virus_upload_enter_rorke");
  common_scripts\utility::flag_set("rorke_at_virus_upload");
  thread maps\cornered_audio::aud_virus("r_loop");
  level.shadowkill_struct thread maps\_anim::anim_loop_solo(self, "virus_upload_loop_rorke", "stop_loop");
  common_scripts\utility::flag_wait("start_power_junction_patrol_chatter");
  level.shadowkill_struct notify("stop_loop");
  thread maps\cornered_audio::aud_virus("r_end");
  level.shadowkill_struct maps\_anim::anim_single_solo(self, "virus_upload_end_rorke");
  common_scripts\utility::flag_set("rorke_in_guard_loop");
  level.shadowkill_struct thread maps\_anim::anim_loop_solo(self, "virus_upload_guard_loop_rorke", "stop_loop");
  common_scripts\utility::flag_wait_any("virus_upload_bar_almost_complete", "force_player_upload_end");
  level.shadowkill_struct notify("stop_loop");
  level.shadowkill_struct maps\_anim::anim_single_solo(self, "virus_upload_guard_hide_rorke");
  common_scripts\utility::flag_set("rorke_in_alcove");
  level.shadowkill_struct thread maps\_anim::anim_loop_solo(self, "shadowkill_front_idle", "stop_loop");
  common_scripts\utility::flag_wait("let_them_pass");
  wait 1;
  level.shadowkill_struct notify("stop_loop");
  waittillframeend;
  self stopanimscripted();
  level.shadowkill_struct maps\_anim::anim_single_solo(self, "shadowkill_front_to_back");
  level.shadowkill_struct thread maps\_anim::anim_loop_solo(self, "shadowkill_back_idle", "stop_loop");
  common_scripts\utility::flag_wait("shadow_kill_start");
  level.shadowkill_struct notify("stop_loop");
  level.allies[level.const_rorke] stopanimscripted();
  level.rorke_knife = spawn("script_model", (0, 0, 0));
  level.rorke_knife setModel("weapon_bolo_knife");
  level.rorke_knife hide();
  level.rorke_knife linkto(level.allies[level.const_rorke], "tag_stowed_back", (0, 0, 0), (0, 0, 0));
  thread maps\cornered_audio::aud_virus("kill");
  level.shadowkill_struct thread maps\_anim::anim_single_solo(level.allies[level.const_rorke], "shadowkill_end");
  thread rorke_shadow_kill();
  common_scripts\utility::flag_wait("shadow_kill_done");
  var_0 = getnode("rorke_post_shadow_kill_node", "targetname");
  level.allies[level.const_rorke] thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_0);
}

rorke_shadow_kill() {
  level endon("power_junction_patrol_killed");
  level.shadowkill_struct waittill("shadowkill_end");
  common_scripts\utility::flag_set("shadow_kill_done");
  thread rorke_react_to_stealth_break("power_junction_patrol_killed");
}

laptop_open(var_0) {
  level.shadowkill_struct maps\_anim::anim_single_solo(level.laptop, "virus_upload_laptop_enter");
}

laptop_on(var_0) {
  common_scripts\utility::exploder("cell_screen_glow");
}

laptop_close(var_0) {
  level.shadowkill_struct maps\_anim::anim_single_solo(level.laptop, "virus_upload_laptop_end");
}

laptop_off(var_0) {
  maps\_utility::stop_exploder("cell_screen_glow");
}

shadowkill_goggles_off(var_0) {}

shadowkill_knife_show(var_0) {
  level.rorke_knife show();
}

shadowkill_knife_delete(var_0) {
  if(isDefined(level.rorke_knife))
    level.rorke_knife delete();
}

shadowkill_knife_stab(var_0) {
  if(!common_scripts\utility::flag("enemies_aware")) {
    common_scripts\utility::flag_set("shadow_kill_stab");
    var_0 maps\_utility::disable_surprise();
    var_0.ignoresuppression = 1;
    var_0.disablebulletwhizbyreaction = 1;
    var_0.disablefriendlyfirereaction = 1;
    var_0.disablereactionanims = 1;
    var_0 maps\_utility::set_baseaccuracy(5);
  }
}

shadowkill_goggles_on(var_0) {
  common_scripts\utility::flag_set("shadow_kill_goggles_on");
}

rorke_start_shadowkill(var_0) {
  common_scripts\utility::flag_set("shadow_kill_start");
}

shadowkill_phone_show(var_0) {
  common_scripts\utility::flag_set("shadow_kill_enemy_phone_out");
  level.shadowkill_enemy_phone_array = [];
  level.shadowkill_enemy_phone_array[0] = spawn("script_model", (0, 0, 0));
  level.shadowkill_enemy_phone_array[0] setModel("cnd_cellphone_01_off_anim");
  level.shadowkill_enemy_phone_array[0].animname = "shadowkill_enemy_phone_off";
  level.shadowkill_enemy_phone_array[0] maps\_anim::setanimtree();
  level.shadowkill_enemy_phone_array[0] hide();
  level.shadowkill_enemy_phone_array[1] = spawn("script_model", (0, 0, 0));
  level.shadowkill_enemy_phone_array[1] setModel("cnd_cellphone_01_on_anim");
  level.shadowkill_enemy_phone_array[1].animname = "shadowkill_enemy_phone_on";
  level.shadowkill_enemy_phone_array[1] maps\_anim::setanimtree();
  level.shadowkill_enemy_phone_array[1] hide();
  thread shadowkill_phone();
  thread handle_phone_if_stealth_is_broken();
}

shadowkill_phone() {
  level endon("enemies_aware");
  level.shadowkill_struct maps\_anim::anim_first_frame(level.shadowkill_enemy_phone_array, "shadowkill_enter_enemy");
  level.shadowkill_enemy_phone_array[0] show();
  level.shadowkill_struct maps\_anim::anim_single(level.shadowkill_enemy_phone_array, "shadowkill_enter_enemy");

  foreach(var_1 in level.shadowkill_enemy_phone_array)
  var_1 thread maps\cornered_code::entity_cleanup("player_exiting_building");
}

handle_phone_if_stealth_is_broken() {
  level endon("shadow_kill_stab");
  common_scripts\utility::flag_wait("enemies_aware");

  if(common_scripts\utility::flag("shadowkill_phone_on")) {
    level.shadowkill_enemy_phone_array[0] show();
    level.shadowkill_enemy_phone_array[1] hide();
    stopFXOnTag(level._effect["cell_screen_glow"], level.shadowkill_enemy_phone_array[1], "tag_fx");
    common_scripts\utility::flag_set("shadowkill_phone_off");
  }

  foreach(var_1 in level.shadowkill_enemy_phone_array)
  var_1 thread maps\cornered_code::entity_cleanup();
}

shadowkill_phone_on(var_0) {
  level.shadowkill_enemy_phone_array[1] show();
  level.shadowkill_enemy_phone_array[0] hide();
  wait 0.5;

  if(isDefined(level.shadowkill_enemy_phone_array[1]))
    playFXOnTag(level._effect["cell_screen_glow"], level.shadowkill_enemy_phone_array[1], "tag_fx");

  common_scripts\utility::flag_set("shadowkill_phone_on");
}

shadowkill_phone_off(var_0) {
  level endon("shadowkill_phone_off");
  var_1 = getnotetracktimes(maps\_utility::getanim("shadowkill_end_enemy"), "phone_off");
  var_2 = getanimlength(maps\_utility::getanim("shadowkill_end_enemy"));
  var_3 = var_2 * var_1[0];
  var_3 = var_3 - 0.4;
  wait(var_3);

  if(common_scripts\utility::flag("shadowkill_phone_on")) {
    level.shadowkill_enemy_phone_array[0] show();
    level.shadowkill_enemy_phone_array[1] hide();
    stopFXOnTag(level._effect["cell_screen_glow"], level.shadowkill_enemy_phone_array[1], "tag_fx");
  }
}

allies_building_exit_hookup() {
  level endon("player_exiting_building");

  if(!isDefined(level.inverted_rappel_startpoint)) {
    maps\_utility::enable_cqbwalk();
    level.move_rorke_to_window_trigger common_scripts\utility::trigger_on();
    level.force_rorke_pathing_clip solid();
    level.force_rorke_pathing_clip disconnectpaths();
    var_0 = getnode("rorke_wait_at_end_of_hall_node", "targetname");
    thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_0, "rorke_at_hall_end");
    thread hall_clear_vo();
    common_scripts\utility::flag_wait("move_rorke_to_window");
    maps\_utility::disable_exits();
    var_0 = getnode("rorke_building_exit_wait_node", "targetname");
    level.building_entry_exit_anim_struct thread maps\_anim::anim_reach_solo(self, "cnd_rappel_stealth_exit_bldg_hookup_" + self.animname);
    wait 2;
    maps\_utility::enable_exits();
    maps\_utility::disable_cqbwalk();
    level.force_rorke_pathing_clip notsolid();
    level.force_rorke_pathing_clip connectpaths();
    level.force_rorke_pathing_clip delete();
    self waittill("goal");
    common_scripts\utility::flag_set("rorke_at_building_exit_node");
  }

  if(!isDefined(level.building_entry_exit_anim_struct))
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");

  level.building_entry_exit_anim_struct maps\_anim::anim_single_solo(self, "cnd_rappel_stealth_exit_bldg_hookup_" + self.animname);
  level.building_entry_exit_anim_struct thread maps\_anim::anim_loop_solo(self, "cnd_rappel_stealth_exit_bldg_wait_loop_" + self.animname, "stop_loop");
}

hall_clear_vo() {
  self endon("rorke_at_building_exit_node");
  common_scripts\utility::flag_wait("rorke_at_hall_end");

  if(!common_scripts\utility::flag("move_rorke_to_window")) {
    wait 1.75;
    level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_clear_2");
  }
}

rorke_react_to_stealth_break(var_0) {
  level endon(var_0);
  common_scripts\utility::flag_wait("enemies_aware");
  level.shadowkill_struct notify("stop_loop");
  waittillframeend;
  self stopanimscripted();
  self.ignoreall = 0;
  maps\_utility::set_baseaccuracy(0.2);
  maps\_utility::disable_surprise();
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.disablereactionanims = 1;
  self.dontmelee = 1;

  if(common_scripts\utility::flag("shadow_kill_start")) {
    var_1 = getnode("rorke_post_shadow_kill_node", "targetname");
    thread maps\cornered_code::send_to_node_and_set_flag_if_specified_when_reached(var_1);
  } else {}
}

handle_rappel_inverted() {
  if(isDefined(level.inverted_rappel_startpoint)) {
    if(!isDefined(level.player_exit_to_inverted_rope))
      level.player_exit_to_inverted_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");

    level.rappel_entry_anim_struct = common_scripts\utility::getstruct("rappel_entry_anim_struct_stealth", "targetname");
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");
    level.rorke_exit_to_inverted_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
    level.rorke_exit_to_inverted_rope.animname = "building_entry_rope_rorke";
    level.building_entry_exit_anim_struct maps\_anim::anim_last_frame_solo(level.rorke_exit_to_inverted_rope, "building_entry_rorke");
    level.building_entry_exit_anim_struct maps\_anim::anim_first_frame_solo(level.player_exit_to_inverted_rope, "rappel_stealth_exit");
    common_scripts\utility::exploder(5001);
    common_scripts\utility::exploder(5002);
    common_scripts\utility::exploder(5003);
    common_scripts\utility::exploder(5004);
  }

  if(common_scripts\utility::flag("rappel_down_ready"))
    common_scripts\utility::flag_clear("rappel_down_ready");

  if(common_scripts\utility::flag("player_allow_rappel_down"))
    common_scripts\utility::flag_clear("player_allow_rappel_down");

  level.player_exit_to_inverted_rope setModel("cnd_rappel_tele_rope_obj");
  common_scripts\utility::flag_wait("exit_building_ready");
  var_0 = getent("player_exit_building_trigger", "targetname");

  if(!maps\cornered_code::is_e3()) {
    if(level.player common_scripts\utility::is_player_gamepad_enabled())
      var_0 sethintstring(&"CORNERED_EXIT_BUILDING_CONSOLE");
    else
      var_0 sethintstring(&"CORNERED_EXIT_BUILDING");
  }

  var_1 = common_scripts\utility::getstruct("inverted_look_at", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, var_1, cos(40), 0, 1);
  common_scripts\utility::flag_set("player_exiting_building");
  thread virus_deploy_bink();
  level.player_exit_to_inverted_rope setModel("cnd_rappel_tele_rope");
  thread maps\cornered_audio::aud_invert("start");
  player_exit_building();
  thread constrict_player_view_at_top();
  thread virus_deploy();
  thread detonate_lights_off();
  common_scripts\utility::flag_wait("rappel_down_ready");

  if(!maps\cornered_code::is_e3())
    thread maps\cornered_code::player_move_on_rappel_hint();

  common_scripts\utility::flag_set("player_allow_rappel_down");
  maps\cornered_code_rappel::rappel_limit_vertical_move(-10000, 0);
  common_scripts\utility::flag_wait("spawn_inverted_kill_enemies");
  level.player allowmelee(0);
  level.player allowads(0);
  wait 0.5;
  level.player.currentweapon = level.player getcurrentweapon();

  if(level.player common_scripts\utility::isweaponenabled())
    level.player common_scripts\utility::_disableweapon();

  level.player allowfire(0);
  level.player giveweapon("push_knife");
  level.player switchtoweapon("push_knife");
  level.player common_scripts\utility::_disableweaponswitch();

  if(!level.player common_scripts\utility::isweaponenabled())
    level.player common_scripts\utility::_enableweapon();

  maps\cornered_code_rappel::cornered_stop_random_wind();
  thread maps\cornered_audio::aud_stop_wind();
  thread maps\cornered_audio::aud_invert("knife");
  setsaveddvar("ammoCounterHide", 1);
  level.rappel_max_downward_speed = 4.0;
  level.rappel_max_lateral_speed = 3.0;
  thread funnel_player();
  common_scripts\utility::exploder(12);
  common_scripts\utility::flag_wait("start_inverted_kill_prompting");
  level.rappel_max_downward_speed = 2.0;
  level.rappel_max_lateral_speed = 2.0;
  player_inverted_kill();
  thread maps\cornered_interior::courtyard_intro_elevator();
  thread maps\cornered_interior::courtyard_intro_elevator_guys();
  maps\cornered_code_rappel::cornered_stop_rappel();
  common_scripts\utility::flag_clear("disable_rappel_jump");
  level.player allowjump(1);
  level.player thread player_handle_outside_effects();
  common_scripts\utility::flag_wait("start_courtyard");
  common_scripts\utility::flag_wait("inverted_rorke_done");

  if(!maps\cornered_code::is_e3())
    common_scripts\utility::flag_set("inverted_rappel_finished");

  maps\_utility::stop_exploder(23);
  maps\_utility::stop_exploder(3456);
}

player_handle_outside_effects() {
  level endon("junction_entrance_close");
  var_0 = getent("inverted_kill_balcony", "targetname");
  var_1 = 1;

  for(;;) {
    if(!var_1)
      var_0 waittill("trigger");

    if(level.player istouching(var_0)) {
      if(!var_1) {
        var_1 = 1;
        maps\cornered_code::player_flap_sleeves();
        maps\cornered_lighting::do_specular_sun_lerp(1);
      }
    } else if(var_1) {
      var_1 = 0;
      level.player maps\cornered_code::player_stop_flap_sleeves();
      maps\cornered_lighting::do_specular_sun_lerp(0);
    }

    common_scripts\utility::waitframe();
  }
}

player_exit_building() {
  level.reflection_window_inverted show();
  level.building_entry_exit_anim_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "rappel_stealth_exit");

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  level.player freezecontrols(1);
  level.player allowfire(0);
  level.player common_scripts\utility::_disableweapon();
  wait 0.3;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.5);
  wait 0.5;
  maps\cornered_code::show_player_arms();
  level.cornered_player_legs show();
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "rappel_stealth_exit");
  level.building_entry_exit_anim_struct thread maps\_anim::anim_single_solo(level.player_exit_to_inverted_rope, "rappel_stealth_exit");
  setsaveddvar("ammoCounterHide", 1);
  level.player.currentweapon = level.player getcurrentweapon();
  level.player giveweapon("computer_idf");
  level.player switchtoweapon("computer_idf");
  level.player common_scripts\utility::_disableweaponswitch();
  level.cornered_player_arms waittillmatch("single anim", "end");
  maps\cornered_code::hide_player_arms();
  level.cornered_player_legs hide();
  common_scripts\utility::flag_set("player_has_exited_the_building");
  maps\cornered_lighting::do_specular_sun_lerp(1);
  level.player freezecontrols(0);
  level.player common_scripts\utility::_enableweapon();
  level.player thread maps\cornered_code::player_flap_sleeves();
  level.rappel_max_lateral_dist_right = 20;
  level.rappel_max_lateral_dist_left = 250;
  level.rappel_max_downward_speed = 7.0;
  level.rappel_max_lateral_speed = 7.0;
  level.rappel_max_upward_speed = 3.0;
  var_0 = spawnStruct();
  var_0.right_arc = 80;
  var_0.left_arc = 80;
  var_0.top_arc = 60;
  var_0.bottom_arc = 60;
  var_0.allow_sprint = 0;
  var_0.jump_type = "jump_small";
  var_0.allow_walk_up = 1;
  var_0.show_legs = 0;
  var_0.lateral_plane = 1;
  var_0.rappel_type = "inverted";
  level.rappel_params = var_0;
  maps\cornered_code_rappel::cornered_start_rappel("rope_ref_stealth", "player_rappel_ground_ref_upside_down_stealth", var_0);
  maps\cornered_code_rappel::cornered_start_random_wind();

  foreach(var_2 in level.allies)
  var_2 maps\cornered_code_rappel_allies::ally_rappel_start_rope(var_0.rappel_type);

  level.player_exit_to_inverted_rope delete();

  if(isDefined(level.rorke_exit_to_inverted_rope))
    level.rorke_exit_to_inverted_rope delete();

  common_scripts\utility::flag_wait("player_ready_to_deploy_virus");
  wait 0.25;
  level.player allowfire(1);
  level.player enableweaponpickup();
}

constrict_player_view_at_top() {
  level endon("player_initiated_pounce");
  var_0 = getent("inverted_rappel_restrict_player_view_volume", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("constrict_player_view");
    level.player lerpviewangleclamp(0.5, 0, 0, 50, 50, 60, 40);
    common_scripts\utility::flag_waitopen("constrict_player_view");
    level.player lerpviewangleclamp(0.5, 0, 0, 80, 80, 60, 60);
    wait 0.05;
  }
}

virus_deploy_bink() {
  wait 0.25;
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame("cornered_pda_activate");

  while(cinematicgetframe() <= 1)
    common_scripts\utility::waitframe();

  pausecinematicingame(1);
}

virus_deploy() {
  if(!level.player attackbuttonpressed()) {
    level.player notifyonplayercommand("deploy", "+attack");
    level.player notifyonplayercommand("deploy", "+attack_akimbo_accessible");

    if(!maps\cornered_code::is_e3())
      level.player thread maps\cornered_code::time_to_pass_before_hint(3, "virus_deploy", "player_deployed_virus");

    level.player waittill("deploy");
  }

  pausecinematicingame(0);
  thread maps\cornered_audio::aud_virus("activate");
  common_scripts\utility::flag_set("player_deployed_virus");
  level.player common_scripts\utility::_disableweapon();
  wait 3.0;
  level.player takeweapon("computer_idf");
  level.player switchtoweapon(level.player.currentweapon);
  level.player common_scripts\utility::_enableweaponswitch();
  level.player common_scripts\utility::_enableweapon();
  setsaveddvar("ammoCounterHide", 0);
}

detonate_lights_off() {
  common_scripts\utility::flag_wait("player_deployed_virus");
  wait 2;
  var_0 = getEntArray("emissive_windows_9", "targetname");
  turn_lights_off(var_0, "brushes");
  level.large_outside_lights_on = getEntArray("large_outside_lights_on", "targetname");

  foreach(var_2 in level.large_outside_lights_on)
  var_2 hide();

  level.large_outside_lights_off = getEntArray("large_outside_lights_off", "targetname");

  foreach(var_5 in level.large_outside_lights_off)
  var_5 show();

  for(var_7 = 10; var_7 <= 35; var_7++) {
    wait 0.2;
    var_8 = getEntArray("lights_floor_" + var_7, "targetname");
    turn_lights_off(var_8, "lights");
    var_0 = getEntArray("emissive_window_brush_" + var_7, "targetname");
    turn_lights_off(var_0, "brushes");

    if(var_7 == 13)
      maps\_utility::stop_exploder(5001);

    if(var_7 == 21)
      maps\_utility::stop_exploder(5002);

    if(var_7 == 25)
      maps\_utility::stop_exploder(5003);

    if(var_7 == 28)
      maps\_utility::stop_exploder(5004);

    if(var_7 == 28)
      maps\_utility::stop_exploder(56);
  }
}

turn_lights_off(var_0, var_1) {
  if(var_1 == "lights") {
    foreach(var_3 in var_0)
    var_3 setlightintensity(0.01);
  } else {
    foreach(var_6 in var_0)
    var_6 delete();
  }
}

funnel_player() {
  var_0 = common_scripts\utility::getstruct("inverted_rappel_z_max", "targetname");
  level.z_min = level.player.origin[2];
  level.z_max = var_0.origin[2];
  var_1 = level.rappel_max_lateral_dist_right;
  var_2 = -120;
  var_3 = level.rappel_max_lateral_dist_left;
  var_4 = 210;
  thread funnel_player_internal(var_1, var_2, "right");
  thread funnel_player_internal(var_3, var_4, "left");
}

funnel_player_internal(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_3 - var_1;
  var_5 = level.z_max - level.z_min;

  for(;;) {
    if(var_0 <= var_1) {
      break;
    } else {
      var_6 = level.rpl_plyr_anim_origin gettagorigin("j_prop_1")[2];
      var_7 = var_6 - level.z_min;
      var_8 = var_7 / var_5;
      var_0 = var_3 - var_8 * var_4;

      if(var_2 == "right")
        level.rappel_max_lateral_dist_right = var_0;
      else
        level.rappel_max_lateral_dist_left = var_0;
    }

    common_scripts\utility::waitframe();
  }
}

player_inverted_kill() {
  thread player_inverted_kill_fail();
  level.player_push_knife = spawn("script_model", (0, 0, 0));
  level.player_push_knife setModel("viewmodel_lg_push_knife");
  level.player_push_knife hide();
  level.player_push_knife linkto(level.cornered_player_arms, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  level.rappel_entry_anim_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "pounce_player");
  common_scripts\utility::flag_wait("player_can_start_inverted_kill");
  player_initiates_inverted_kill();

  if(common_scripts\utility::flag("inverted_kill_fail_kill_player") || common_scripts\utility::flag("inverted_kill_enemy_turned_around")) {
    common_scripts\utility::flag_set("player_not_in_inverted_kill_volume");
    level.player waittill("death");
  } else {
    common_scripts\utility::flag_set("player_initiated_pounce");
    thread maps\cornered_audio::aud_invert("ready");
    level.player common_scripts\utility::_disableweapon();

    if(common_scripts\utility::flag("inverted_kill_fail_trigger")) {
      level.rappel_entry_anim_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "pounce_player_fail");
      common_scripts\utility::flag_set("inverted_kill_fail");
    }

    player_lerp_to_anim_start();
    common_scripts\utility::flag_set("player_pounce");
    thread maps\cornered_audio::aud_invert("pounce");
    level.player unlink();
    thread clear_groundref();
    level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
    thread player_pounce_anim();
    common_scripts\utility::flag_wait("start_knife_throw");
    var_0 = get_knife_reticle();
    thread flag_if_player_aims_knife_at_enemy(var_0, 0);
    level.rappel_entry_anim_struct thread maps\_anim::anim_first_frame_solo(level.cornered_player_arms, "knife_throw");
    level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 1, 15, 15, 5, 10);
    level.player enableslowaim();
    wait 0.5;
    thread flag_if_player_aims_knife_at_enemy(var_0, 1);
    player_throws_knife();

    if(common_scripts\utility::flag("player_failed_to_throw_knife")) {
      var_0 destroy();
      setslowmotion(0.1, 1.0, 0.05);
      level.player disableslowaim();
    } else {
      if(common_scripts\utility::flag("player_throws_knife")) {
        thread maps\cornered_audio::aud_invert("slow_end");
        level.player common_scripts\utility::_disableweapon();
        level.player takeweapon("throwing_push_knife");
        level.player_push_knife unlink();
        level.player_push_knife delete();
        level.player_push_knife_projectile = spawn("script_model", (0, 0, 0));
        level.player_push_knife_projectile setModel("projectile_lg_push_knife");
        level.player_push_knife_projectile hide();
        level.player_push_knife_projectile linkto(level.cornered_player_arms, "tag_weapon_right", (5, 0, 0), (0, 0, 0));
        level.rappel_entry_anim_struct thread maps\_anim::anim_first_frame_solo(level.cornered_player_arms, "knife_throw");
        level.player_push_knife_projectile show();
        level.cornered_player_arms show();
        thread watch_push_knife_throw();
        level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(level.cornered_player_arms, "knife_throw");
        thread do_knife_throw_blood();
        var_0 destroy();
        wait 0.25;
        setslowmotion(0.25, 1.0, 0.5);
        level.player disableslowaim();
        level.cornered_player_arms waittillmatch("single anim", "end");
        level.rappel_entry_anim_struct maps\_anim::anim_single_solo(level.cornered_player_arms, "pounce_stand");
        level.player unlink();
        maps\cornered_code::hide_player_arms();
        level.cornered_player_legs hide();
        level.cornered_player_arms maps\cornered_code::player_stop_flap_sleeves();
        level.player maps\cornered_code::player_stop_flap_sleeves();
        wait 3;
        level.player maps\cornered_code::player_showviewmodelsleeveflaps();
        level.player switchtoweapon(level.player.currentweapon);
        level.player allowfire(1);
        level.player allowmelee(1);
        level.player allowads(1);
        level.player common_scripts\utility::_enableweapon();
        level.player common_scripts\utility::_enableweaponswitch();
        setsaveddvar("ammoCounterHide", 0);
        return;
      }

      if(common_scripts\utility::flag("player_throws_knife_fail")) {
        var_0 destroy();
        setslowmotion(0.25, 1.0, 0.5);
        level.player disableslowaim();
        wait 0.8;
        level.player maps\cornered_code::player_hideviewmodel();
        level.player common_scripts\utility::_disableweapon();
      }
    }
  }
}

do_knife_throw_blood() {
  wait 0.53;
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0.angles = vectortoangles((1, 0, 1));
  var_0 linkto(level.player_knife_throw_enemy, "tag_weapon_chest", (0, -6, 0), (0, -90, 0));
  playFXOnTag(common_scripts\utility::getfx("neck_stab_blood"), var_0, "tag_origin");
  wait 5;
  var_0 delete();
}

weapon_anim_start(var_0) {
  maps\cornered_code::hide_player_arms();
  level.player_push_knife hide();
  wait 0.25;
  level.player takeweapon("push_knife");
  level.player giveweapon("throwing_push_knife");
  level.player switchtoweapon("throwing_push_knife");
  level.player common_scripts\utility::_enableweapon();
  common_scripts\utility::flag_set("start_knife_throw");
}

player_inverted_kill_fail() {
  level endon("player_initiated_pounce");
  common_scripts\utility::flag_wait("inverted_kill_fail_trigger");
  common_scripts\utility::flag_wait("inverted_kill_fail_stop_player");
  maps\cornered_code_rappel::rappel_limit_vertical_move(0, 0);
}

player_pounce_anim() {
  if(common_scripts\utility::flag("inverted_kill_fail"))
    level.rappel_entry_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "pounce_player_fail");
  else {
    level.rappel_entry_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "pounce_player");
    level thread do_inverted_kill_blood();
  }

  wait 0.1;
  level.cornered_player_arms show();
  level.cornered_player_arms maps\cornered_code::player_stop_flap_sleeves();
  maps\cornered_code::hide_player_arms_sleeve_flaps();
  level.player maps\cornered_code::player_hideviewmodelsleeveflaps();
  level.cornered_player_legs show();
  level.player_push_knife show();
  level.cornered_player_arms waittillmatch("single anim", "player_land_balcony");
  level.reflection_window_inverted delete();
  level.player allowfire(1);
  wait 2.5;
  thread maps\cornered_audio::aud_invert("slow");
  setslowmotion(1.0, 0.25, 0.05);
  level.cornered_player_arms waittillmatch("single anim", "end");
  level.player allowstand(1);
  level.player setstance("stand");
}

do_inverted_kill_blood() {
  level.player_inverted_kill_enemy waittillmatch("single anim", "stab_contact");
  var_0 = level.player_inverted_kill_enemy gettagorigin("tag_weapon_chest");
  playFX(common_scripts\utility::getfx("neck_stab_blood"), var_0, (0, 0, 1), (1, 0, 0));
}

watch_push_knife_throw() {
  for(;;) {
    if(isDefined(level.player_knife_throw_enemy) && level.player_push_knife_projectile istouching(level.player_knife_throw_enemy)) {
      break;
    }

    wait 0.05;
  }

  level.player_push_knife_projectile unlink();

  if(isDefined(level.player_knife_throw_enemy))
    level.player_push_knife_projectile linkto(level.player_knife_throw_enemy, "tag_weapon_chest", (0, -6, 0), (0, -90, 0));

  common_scripts\utility::flag_wait("courtyard_intro_goto_elevator");
  level.player_push_knife_projectile delete();
}

player_initiates_inverted_kill() {
  level endon("inverted_kill_fail_kill_player");
  level endon("inverted_kill_enemy_turned_around");
  var_0 = getent("inverted_kill_start_volume", "targetname");
  common_scripts\utility::flag_set("player_not_in_inverted_kill_volume");

  for(;;) {
    if(level.player istouching(var_0)) {
      if(common_scripts\utility::flag("player_not_in_inverted_kill_volume")) {
        common_scripts\utility::flag_clear("player_not_in_inverted_kill_volume");

        if(!maps\cornered_code::is_e3())
          level.player maps\_utility::display_hint_timeout("inverted_kill", 5);
      }

      if(level.player meleebuttonpressed() || level.player attackbuttonpressed()) {
        if(!common_scripts\utility::flag("player_jumping")) {
          if(!common_scripts\utility::flag("inverted_kill_fail_kill_player")) {
            break;
          }
        }
      }
    } else if(!common_scripts\utility::flag("player_not_in_inverted_kill_volume"))
      common_scripts\utility::flag_set("player_not_in_inverted_kill_volume");

    wait 0.05;
  }

  common_scripts\utility::flag_set("player_not_in_inverted_kill_volume");
}

should_break_inverted_kill_hint() {
  return common_scripts\utility::flag("player_not_in_inverted_kill_volume");
}

clear_groundref() {
  wait 0.5;
  level.player playersetgroundreferenceent(undefined);
}

player_lerp_to_anim_start() {
  var_0 = level.cornered_player_arms gettagorigin("tag_camera") - (0, 0, 60);
  var_1 = level.cornered_player_arms gettagangles("tag_camera");
  var_2 = distance(level.player.origin, var_0);
  var_3 = 432;
  var_4 = var_2 / var_3;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_origin", var_4);
  wait(var_4);
}

flag_if_player_aims_knife_at_enemy(var_0, var_1) {
  level notify("flag_if_player_aims_knife_at_enemy");
  level endon("flag_if_player_aims_knife_at_enemy");
  level.player_knife_throw_enemy endon("death");
  level endon("player_throws_knife");
  level endon("player_throws_knife_fail");
  level endon("player_failed_to_throw_knife");

  for(;;) {
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(level.player getplayerangles());
    var_4 = bulletTrace(level.player getEye() + var_3 * 20, level.player getEye() + var_3 * 50000, 1, level.player_inverted_kill_enemy);

    if(isDefined(var_4["entity"]) && var_4["entity"] == level.player_knife_throw_enemy) {
      common_scripts\utility::flag_set("player_aims_knife_at_enemy");
      var_0.color = (1, 0.65, 0);
      level.player allowfire(0);
    } else {
      common_scripts\utility::flag_clear("player_aims_knife_at_enemy");
      var_0.color = (1, 1, 1);

      if(var_1)
        level.player allowfire(1);
    }

    wait 0.05;
  }
}

get_knife_reticle() {
  if(!isDefined(level.knife_reticle)) {
    var_0 = newclienthudelem(level.player);
    var_0.x = 0;
    var_0.y = 0;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0 setshader("reticle_center_cross", 32, 32);
    var_0.hidewhendead = 1;
    var_0.hidewheninmenu = 1;
    var_0.sort = 205;
    var_0.foreground = 1;
    var_0.color = (1, 1, 1);
    var_0.alpha = 1;
    level.knife_reticle = var_0;
  }

  return level.knife_reticle;
}

player_throws_knife() {
  level endon("player_failed_to_throw_knife");
  level.player notifyonplayercommand("throw", "+attack");
  level.player notifyonplayercommand("throw", "+melee");
  level.player notifyonplayercommand("throw", "+melee_breath");
  level.player notifyonplayercommand("throw", "+melee_zoom");
  level.player notifyonplayercommand("throw", "+frag");

  for(;;) {
    level.player waittill("throw");

    if(common_scripts\utility::flag("player_aims_knife_at_enemy")) {
      common_scripts\utility::flag_set("player_throws_knife");
      break;
    } else {
      common_scripts\utility::flag_set("player_throws_knife_fail");
      break;
    }
  }
}

inverted_rappel_combat() {
  common_scripts\utility::flag_wait("player_exiting_building");
  common_scripts\utility::flag_clear("enemies_aware");
  common_scripts\utility::flag_clear("player_shot");
  maps\_utility::array_spawn_function_targetname("sleeping_enemy_below", ::sleeping_enemy_below_setup);
  var_0 = maps\_utility::array_spawn_targetname("sleeping_enemy_below");
  maps\_utility::array_spawn_function_targetname("rappel_balcony_enemies", ::rappel_balcony_setup);
  common_scripts\utility::flag_wait("spawn_balcony_enemies");
  level.rappel_balcony_enemies = maps\_utility::array_spawn_targetname("rappel_balcony_enemies");
  var_1 = getDvar("ragdoll_max_life");
  setsaveddvar("ragdoll_max_life", 20000);
  thread allies_help_when_player_shoots_balcony_enemies();
  level.rappel_balcony_enemies = maps\_utility::array_removedead_or_dying(level.rappel_balcony_enemies);
  maps\_utility::waittill_dead(level.rappel_balcony_enemies);
  common_scripts\utility::flag_set("balcony_enemies_killed");
  common_scripts\utility::flag_clear("enemies_aware");
  common_scripts\utility::flag_wait("spawn_inverted_kill_enemies");
  maps\_utility::array_spawn_function_targetname("inverted_kill_enemies", ::inverted_kill_enemies_setup);
  var_2 = maps\_utility::array_spawn_targetname("inverted_kill_enemies");
  wait 10;
  setsaveddvar("ragdoll_max_life", var_1);
}

allies_help_when_player_shoots_balcony_enemies() {
  level endon("balcony_enemies_killed");
  common_scripts\utility::flag_wait("balcony_enemies_on_balcony");
  thread player_shoots();
  common_scripts\utility::flag_wait_or_timeout("player_shot", 8);
  level.player common_scripts\utility::waittill_notify_or_timeout("damage", 1);
  thread maps\cornered_code::ally_to_magicbullet(level.allies[level.const_rorke], level.rappel_balcony_enemies);
  wait 2;
  thread maps\cornered_code::ally_to_magicbullet(level.allies[level.const_rorke], level.rappel_balcony_enemies);
}

player_shoots(var_0) {
  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  for(;;) {
    if(level.player attackbuttonpressed()) {
      common_scripts\utility::flag_set("player_shot");
      break;
    }

    wait 0.05;
  }
}

rappel_balcony_setup() {
  self endon("death");
  self.animname = "generic";
  self.ignoreall = 1;
  self.health = 50;
  thread if_player_passes_balcony_before_killing();
  thread maps\cornered_code::wait_till_shot(undefined, "enemies_aware");
  thread balcony_anims();

  if(self.script_noteworthy == "cornered_inv_balcony_walkin_enemy2") {
    var_0 = getent("inverted_rappel_balcony_volume", "targetname");

    for(;;) {
      if(self istouching(var_0)) {
        common_scripts\utility::flag_set("balcony_enemies_on_balcony");
        break;
      }

      wait 0.05;
    }
  }

  common_scripts\utility::flag_wait("balcony_enemies_on_balcony");
  self.allowdeath = 1;
  level.balcony_enemies_clip solid();
  level.balcony_enemies_clip disconnectpaths();
  common_scripts\utility::flag_wait("enemies_aware");

  if(self.script_noteworthy == "cornered_inv_balcony_walkin_enemy2") {
    self.ignoreall = 0;
    level.rappel_entry_anim_struct notify("stop_loop");
    waittillframeend;
    maps\_utility::anim_stopanimscripted();
    self.favoriteenemy = level.player;
  }
}

#using_animtree("generic_human");

balcony_anims() {
  self endon("death");
  level endon("enemies_aware");
  level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, self.script_noteworthy);

  if(self.script_noteworthy == "cornered_inv_balcony_walkin_enemy1") {
    wait 4;
    self.deathanim = % cornered_inv_balcony_death_enemy1;
  }

  self waittillmatch("single anim", "end");
  level.rappel_entry_anim_struct thread maps\_anim::anim_loop_solo(self, self.script_noteworthy + "_loop", "stop_loop");
}

if_player_passes_balcony_before_killing() {
  self endon("death");
  common_scripts\utility::flag_wait("player_is_past_balcony");

  if(!common_scripts\utility::flag("player_is_past_balcony_and_enemies_are_alive"))
    common_scripts\utility::flag_set("player_is_past_balcony_and_enemies_are_alive");

  wait(randomfloatrange(0.25, 0.75));
  var_0 = level.allies[level.const_rorke] gettagorigin("j_head");
  var_1 = self gettagorigin("j_head");
  var_2 = vectornormalize(var_1 - var_0);
  var_3 = var_0 + var_2 * (distance(var_1, var_0) - 10);
  self.health = 1;
  magicbullet(level.allies[level.const_rorke].weapon, var_3, var_1);
  wait 1;
  self kill();
}

sleeping_enemy_below_setup() {
  self.ignoreall = 1;
  self.animname = "generic";
  self.diequietly = 1;
  self.noragdoll = 1;
  self.health = 10;
  self.deathanim = % cnd_rappel_stealth_3rd_floor_sleeping_enemy_death;
  var_0 = getent("sleeping_enemy_below_chair", "targetname");
  var_0.animname = "chair";
  var_0 maps\_anim::setanimtree();
  var_1[0] = self;
  var_1[1] = var_0;
  self.struct = common_scripts\utility::getstruct("sleeping_enemy_below_struct", "targetname");
  self.struct thread maps\_anim::anim_loop(var_1, "sleep_idle", "stop_loop");
  common_scripts\utility::flag_wait("player_is_past_balcony");
  common_scripts\utility::waitframe();
  self.allowdeath = 1;
  thread sleeping_enemy_below_alerted_or_killed(var_1, var_0);
  thread watch_for_death_achievement();
  level thread cleanup_sleeping_enemy(self, var_0);
  thread maps\cornered_code::wait_till_shot("enemies_aware", undefined, "enemy_aware");
  thread maps\cornered_code::alert_all();
}

sleeping_enemy_below_alerted_or_killed(var_0, var_1) {
  level endon("start_inverted_kill_prompting");
  common_scripts\utility::waittill_any("enemy_aware", "death");

  if(isalive(self)) {
    level notify("sleeping_guy_awake");
    self.struct notify("stop_loop");
    waittillframeend;
    self.deathanim = % exposed_death_headshot;
    self.struct maps\_anim::anim_single(var_0, "sleep_react");
    self.ignoreall = 0;
    self.noragdoll = 0;
    self.favoriteenemy = level.player;
  } else if(!isalive(self))
    var_1 thread maps\_anim::anim_single_solo(var_1, "sleep_death");
}

watch_for_death_achievement() {
  level endon("sleeping_guy_awake");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && isPlayer(var_1)) {
    self kill();
    level.player maps\_utility::player_giveachievement_wrapper("LEVEL_7A");
  }
}

cleanup_sleeping_enemy(var_0, var_1) {
  common_scripts\utility::flag_wait("start_courtyard");

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();
}

inverted_kill_enemies_setup() {
  self.ignoreall = 1;
  self.animname = "generic";
  self.a.nodeath = 1;
  self.diequietly = 1;
  self.allowdeath = 1;
  self.noragdoll = 1;
  self.a.disablelongdeath = 1;

  if(self.script_noteworthy == "guy1") {
    level.player_inverted_kill_enemy = self;
    thread maps\cornered_code::head_swap("head_fed_basic_a");
    player_inverted_kill_enemy_anims();

    if(isDefined(self.walkin_anim))
      self stopanimscripted();
    else {
      level.rappel_entry_anim_struct notify("stop_player_inverted_kill_enemy_idle");
      waittillframeend;
    }

    if(common_scripts\utility::flag("inverted_kill_fail_trigger")) {
      if(!common_scripts\utility::flag("player_pounce")) {
        player_inverted_kill_enemy_fail_anim();

        if(common_scripts\utility::flag("player_pounce")) {
          if(common_scripts\utility::flag("inverted_kill_enemy_started_turning_around")) {
            if(!common_scripts\utility::flag("inverted_kill_enemy_turned_around")) {
              self stopanimscripted();
              level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_pounce_fail2");
              wait 1;
              maps\_utility::gun_remove();
              self waittillmatch("single anim", "end");
              self kill();
            } else {
              self.ignoreall = 0;
              self.favoriteenemy = level.player;
            }
          } else {
            self stopanimscripted();
            level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_pounce_fail");
            wait 1;
            maps\_utility::gun_remove();
            self waittillmatch("single anim", "end");
            self kill();
          }
        } else {
          self.ignoreall = 0;
          self.favoriteenemy = level.player;
        }
      } else {
        level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_pounce");
        wait 1;
        maps\_utility::gun_remove();
        self waittillmatch("single anim", "end");
        self kill();
      }
    } else {
      level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_pounce");
      wait 1;
      maps\_utility::gun_remove();
      self waittillmatch("single anim", "end");
      self kill();
    }
  }

  if(self.script_noteworthy == "guy2") {
    level.player_knife_throw_enemy = self;
    level.rappel_entry_anim_struct maps\_anim::anim_first_frame_solo(self, "player_knife_throw_enemy_pounce");
    self hide();
    common_scripts\utility::flag_wait("player_pounce");
    self show();
    thread player_knife_throw_enemy();
    common_scripts\utility::flag_wait_any("player_throws_knife", "player_failed_to_throw_knife", "player_throws_knife_fail");

    if(common_scripts\utility::flag("player_throws_knife")) {
      thread maps\cornered_audio::aud_invert("throw");
      self stopanimscripted();
      var_0 = getnode("knife_throw_enemy_node", "targetname");
      maps\_utility::set_goal_radius(8);
      self setgoalnode(var_0);
      self.deathanim = % cornered_inv_tkdn_death_guy2;
      thread maps\cornered_audio::aud_invert("hit");
      wait 0.5;
      self kill();
      common_scripts\utility::flag_set("player_knife_throw_enemy_dead");
    } else {
      wait 1;
      self shoot();
      wait 0.2;
      self shoot();
      wait 0.1;
      self shoot();
      wait 0.1;
      thread move_player_up_at_death();
      level.player unlink();
      level.player kill();
    }
  }

  if(self.script_noteworthy == "guy3") {
    self hide();
    level.rappel_entry_anim_struct maps\_anim::anim_first_frame_solo(self, "rorke_inverted_kill_enemy_pounce");
    common_scripts\utility::flag_wait("player_pounce");
    self show();
    thread rorke_inverted_kill_enemy();
    common_scripts\utility::flag_wait("rorke_inverted_kill");
    self stopanimscripted();
    common_scripts\utility::waitframe();
    self.deathanim = % cornered_inv_tkdn_death_guy3;
    self kill();
  }
}

move_player_up_at_death() {
  level.player waittill("death");
  level.player setorigin(level.player.origin + (0, 0, 16));
}

allow_inverted_kill(var_0) {
  common_scripts\utility::flag_set("player_can_start_inverted_kill");
}

player_inverted_kill_enemy_anims() {
  level endon("player_pounce");
  level endon("inverted_kill_fail_trigger");
  self.walkin_anim = 1;
  level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_walkin");
  wait 0.1;
  maps\_anim::anim_self_set_time("player_inverted_kill_enemy_walkin", 0.12);
  maps\_anim::anim_set_rate_single(self, "player_inverted_kill_enemy_walkin", 1.65);
  self waittillmatch("single anim", "end");
  self.walkin_anim = undefined;
  level.rappel_entry_anim_struct thread maps\_anim::anim_loop_solo(self, "player_inverted_kill_enemy_idle", "stop_player_inverted_kill_enemy_idle");
  common_scripts\utility::flag_wait("player_pounce");
}

player_inverted_kill_enemy_fail_anim() {
  level endon("player_pounce");
  level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_inverted_kill_enemy_pounce_alert");
  wait 0.01;
  thread player_pushes_too_far();
  var_0 = maps\_utility::getanim("player_inverted_kill_enemy_pounce_alert");

  while(self getanimtime(var_0) < 0.35)
    wait 0.05;

  common_scripts\utility::flag_set("inverted_kill_enemy_started_turning_around");

  while(self getanimtime(var_0) < 0.45)
    wait 0.05;

  common_scripts\utility::flag_set("inverted_kill_enemy_turned_around");
  thread inverted_kill_enemy_kills_player();
  self waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("player_inverted_kill_enemy_pounce_fail_end");
  level.rappel_entry_anim_struct thread maps\_anim::anim_last_frame_solo(self, "player_inverted_kill_enemy_pounce_alert");
}

player_pushes_too_far() {
  level endon("player_pounce");
  level endon("player_inverted_kill_enemy_pounce_fail_end");
  common_scripts\utility::flag_wait("inverted_kill_fail_kill_player");
  maps\_anim::anim_set_rate_internal("player_inverted_kill_enemy_pounce_alert", 1.5);
}

inverted_kill_enemy_kills_player() {
  magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, 0, 64));
  wait 0.2;
  magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, 0, 64));
  wait 0.2;
  magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, 0, 64));
  wait 0.2;
  magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, 0, 64));
  level.player kill();
}

player_knife_throw_enemy() {
  level endon("player_throws_knife");
  wait 1;
  level.rappel_entry_anim_struct thread maps\_anim::anim_single_solo(self, "player_knife_throw_enemy_pounce");
  wait 4;
  common_scripts\utility::flag_set("player_failed_to_throw_knife");
  self waittillmatch("single anim", "end");
  var_0 = getnode("knife_throw_enemy_node", "targetname");
  self setgoalnode(var_0);
}

rorke_inverted_kill_enemy() {
  level endon("rorke_inverted_kill");
  wait 1;
  level.rappel_entry_anim_struct maps\_anim::anim_single_solo(self, "rorke_inverted_kill_enemy_pounce");
  var_0 = getnode("rorke_inverted_kill_enemy_node", "targetname");
  self setgoalnode(var_0);
}

autosave_past_balcony() {
  common_scripts\utility::flag_wait("balcony_enemies_killed");
  thread maps\_utility::autosave_now_silent();
}

allies_inverted_rappel_vo() {
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_hookuptothe");
  var_0 = maps\_utility::make_array("cornered_mrk_moveitkid", "cornered_mrk_comeonhookup");
  thread maps\cornered_code::nag_until_flag(var_0, "player_exiting_building", 10, 15, 5);
  common_scripts\utility::flag_set("exit_building_ready");
  common_scripts\utility::flag_wait("player_has_exited_the_building");
  common_scripts\utility::flag_wait("player_ready_to_deploy_virus");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_killthelights");
  var_0 = maps\_utility::make_array("cornered_mrk_activatethevirus", "cornered_mrk_killthelights");
  thread maps\cornered_code::nag_until_flag(var_0, "player_deployed_virus", 10, 15, 5);
  common_scripts\utility::flag_wait("player_deployed_virus");
  wait 3;
  common_scripts\utility::flag_set("spawn_balcony_enemies");
  common_scripts\utility::flag_set("rappel_down_ready");
  level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_bkr_beautiful");
  common_scripts\utility::flag_wait("balcony_enemies_on_balcony");
  level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_twoontheleft");
  level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_mrk_movedownandtake");
  common_scripts\utility::flag_wait_either("balcony_enemies_killed", "player_is_past_balcony");
  wait 0.25;

  if(common_scripts\utility::flag("player_is_past_balcony")) {
    if(common_scripts\utility::flag("player_is_past_balcony_and_enemies_are_alive"))
      level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_ivegotem");
  } else if(common_scripts\utility::flag("balcony_enemies_killed"))
    level.allies[level.const_baker] maps\_utility::smart_radio_dialogue("cornered_hsh_targetsdown");

  thread sleeping_enemy_below_vo();
  thread autosave_past_balcony();
  common_scripts\utility::flag_wait("spawn_inverted_kill_enemies");
  wait 0.25;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_onerightbelowyou");
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_movedownabovehim");
  common_scripts\utility::flag_wait("start_inverted_kill_prompting");
  thread inverted_kill_too_close_vo();
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_alrighttakehimout");
  common_scripts\utility::flag_wait("player_knife_throw_enemy_dead");
  wait 5;
}

sleeping_enemy_below_vo() {}

inverted_kill_too_close_vo() {
  level endon("player_initiated_pounce");
  common_scripts\utility::flag_wait("inverted_kill_too_close_vo");
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_nottooclose");
}

allies_inverted_rappel_movement() {
  if(!isDefined(level.rappel_anim_struct))
    level.rappel_anim_struct = getent("allies_rappel_struct_stealth", "targetname");

  if(!isDefined(level.building_entry_exit_anim_struct))
    level.building_entry_exit_anim_struct = common_scripts\utility::getstruct("rappel_stealth_building_entry_exit_anim_struct", "targetname");

  if(isDefined(level.inverted_rappel_startpoint)) {
    if(self.animname == "baker")
      level.building_entry_exit_anim_struct thread maps\_anim::anim_loop_solo(self, "cnd_rappel_inverted_idle_" + self.animname, "stop_loop");
  }

  common_scripts\utility::flag_wait("player_has_exited_the_building");
  level.building_entry_exit_anim_struct notify("stop_loop");

  if(self.animname == "rorke")
    inverted_rappel_movement_rorke();
  else
    inverted_rappel_movement_baker();
}

inverted_rappel_movement_rorke() {
  var_0 = common_scripts\utility::getstruct("inverted_rappel_start_rorke", "targetname");
  var_0 thread maps\_anim::anim_single_solo(self, "cornered_inv_run_stop");
  wait 0.25;
  common_scripts\utility::flag_set("player_ready_to_deploy_virus");
  self waittillmatch("single anim", "end");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");
  common_scripts\utility::flag_wait("player_deployed_virus");
  wait 3;
  self notify("stop_loop");
  maps\_anim::anim_single_solo(self, "cornered_inv_run_start");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_run", "stop_loop");
  wait 0.5;
  self notify("stop_loop");
  maps\_anim::anim_single_solo(self, "cornered_inv_run_stop_aim_left");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle_rorke", "stop_loop");
  common_scripts\utility::flag_wait_either("balcony_enemies_killed", "player_is_past_balcony");

  if(common_scripts\utility::flag("player_is_past_balcony")) {
    self notify("stop_loop");
    waittillframeend;
    var_1 = common_scripts\utility::getstruct("inverted_rappel_balcony_teleport_rorke", "targetname");
    var_1 maps\_anim::anim_first_frame_solo(self, "cornered_inv_run_start");
  } else if(common_scripts\utility::flag("balcony_enemies_killed")) {
    wait 1;
    self notify("stop_loop");
    waittillframeend;
  }

  inverted_rappel_ally_movement();

  if(common_scripts\utility::flag("player_initiated_pounce")) {
    self notify("stop_loop");
    waittillframeend;
    self stopanimscripted();
    level.rappel_entry_anim_struct maps\_anim::anim_first_frame_solo(self, "cornered_inv_tkdn_pounce_rorke");
  } else {
    knife_out_rorke_anims();

    if(common_scripts\utility::flag("player_initiated_pounce")) {
      self notify("stop_loop");
      waittillframeend;
      self stopanimscripted();
      level.rappel_entry_anim_struct maps\_anim::anim_first_frame_solo(self, "cornered_inv_tkdn_pounce_rorke");
    }
  }

  common_scripts\utility::flag_wait("player_knife_throw_enemy_dead");
  self notify("stop_loop");
  waittillframeend;
  self stopanimscripted();

  if(!common_scripts\utility::flag("inverted_kill_knife_rorke")) {
    level.rorke_inverted_kill_knife = spawn("script_model", (0, 0, 0));
    level.rorke_inverted_kill_knife setModel("weapon_parabolic_knife");
    level.rorke_inverted_kill_knife linkto(level.allies[level.const_rorke], "TAG_INHAND", (0, 0, 0), (0, 0, 0));
  }

  maps\cornered_code_rappel_allies::ally_rappel_stop_rope();
  self.ignoreall = 1;
  self.ignoreme = 1;
  level.rappel_entry_anim_struct maps\_anim::anim_single_solo(self, "cornered_inv_tkdn_pounce_rorke");
  maps\cornered_code_rappel_allies::ally_rappel_rope_cleanup();
  common_scripts\utility::flag_set("inverted_rorke_done");
}

knife_out_rorke_anims() {
  level endon("player_initiated_pounce");
  self notify("stop_loop");
  waittillframeend;
  level.rappel_entry_anim_struct maps\_anim::anim_single_solo(self, "cornered_inv_run_drift_right_rorke");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");

  if(common_scripts\utility::flag("spawn_inverted_kill_enemies")) {
    self notify("stop_loop");
    waittillframeend;
    maps\_anim::anim_single_solo(self, "cornered_inv_knife_out_rorke");
    thread maps\_anim::anim_loop_solo(self, "cornered_inv_knife_idle_rorke", "stop_loop");
  } else {
    common_scripts\utility::flag_wait("spawn_inverted_kill_enemies");
    wait 1;
    self notify("stop_loop");
    waittillframeend;
    maps\_anim::anim_single_solo(self, "cornered_inv_knife_out_rorke");
    thread maps\_anim::anim_loop_solo(self, "cornered_inv_knife_idle_rorke", "stop_loop");
  }
}

spawn_rorke_inverted_kill_knife(var_0) {
  level.rorke_inverted_kill_knife = spawn("script_model", (0, 0, 0));
  level.rorke_inverted_kill_knife setModel("weapon_parabolic_knife");
  level.rorke_inverted_kill_knife linkto(level.allies[level.const_rorke], "TAG_INHAND", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_set("inverted_kill_knife_rorke");
}

inverted_rappel_movement_baker() {
  maps\_anim::anim_single_solo(self, "cornered_inv_run_start");
  maps\_anim::anim_single_solo(self, "cornered_inv_run_stop_aim_left");
  inverted_rappel_ally_idles("balcony_enemies_on_balcony", "cornered_inv_idle", "cornered_inv_idle_fidgit_1");
  self notify("stop_loop");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle_baker", "stop_loop");
  common_scripts\utility::flag_wait("balcony_enemies_killed");
  self notify("stop_loop");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");
  common_scripts\utility::flag_wait_either("balcony_enemies_killed", "player_is_past_balcony");

  if(common_scripts\utility::flag("player_is_past_balcony")) {
    self notify("stop_loop");
    waittillframeend;
    var_0 = common_scripts\utility::getstruct("inverted_rappel_balcony_teleport_baker", "targetname");
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_inv_run_start");
  } else if(common_scripts\utility::flag("balcony_enemies_killed")) {
    wait 2;
    self notify("stop_loop");
    waittillframeend;
  }

  inverted_rappel_ally_movement();
  var_1 = undefined;
  common_scripts\utility::flag_wait("player_knife_throw_enemy_dead");
  self notify("stop_loop");
  self stopanimscripted();

  if(!isDefined(var_1)) {
    maps\cornered_code_rappel_allies::ally_rappel_stop_rope();
    var_1 = [];
    var_1[0] = self;
    var_1[1] = self.cnd_rappel_tele_rope;
    level.rappel_entry_anim_struct maps\_anim::anim_first_frame(var_1, "cornered_inv_tkdn_pounce_baker");
  }

  self.ignoreall = 1;
  self.ignoreme = 1;
  level.rappel_entry_anim_struct thread maps\_anim::anim_single(var_1, "cornered_inv_tkdn_pounce_baker");
  self waittillmatch("single anim", "cornered_hsh_iknowtheplan");
  level.allies[level.const_baker] thread maps\cornered_code::char_dialog_add_and_go("cornered_hsh_iknowtheplan");
  self waittillmatch("single anim", "end");
  level.rappel_entry_anim_struct thread maps\_anim::anim_loop_solo(self.cnd_rappel_tele_rope, "cornered_inv_tkdn_baker_rope_loop", "stop_baker_rope_loop");
  common_scripts\utility::flag_wait("baker_security_vo");
  level.rappel_entry_anim_struct notify("stop_baker_rope_loop");
  self.cnd_rappel_tele_rope delete();
  maps\cornered_code_rappel_allies::ally_rappel_rope_cleanup();
  thread maps\cornered_interior::courtyard_intro_baker_exit();
}

inverted_rappel_ally_idles(var_0, var_1, var_2) {
  level endon(var_0);

  for(;;) {
    thread maps\_anim::anim_loop_solo(self, var_1, "stop_loop");
    wait(randomfloatrange(0.5, 2.0));
    self notify("stop_loop");
    waittillframeend;
    maps\_anim::anim_single_solo(self, var_2);
  }
}

inverted_rappel_ally_movement() {
  level endon("player_knife_throw_enemy_dead");
  maps\_anim::anim_single_solo(self, "cornered_inv_run_start");
  thread maps\_anim::anim_loop_solo(self, "cornered_inv_run", "stop_loop");
  var_0 = getent("inverted_rappel_stop_volume_1", "targetname");
  move_to_volume(var_0);

  if(!common_scripts\utility::flag("inverted_rappel_start_ally_move_1")) {
    self notify("stop_loop");
    maps\_anim::anim_single_solo(self, "cornered_inv_run_stop");
    thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");
    common_scripts\utility::flag_wait("inverted_rappel_start_ally_move_1");
    wait(randomfloatrange(0.0, 0.25));
    self notify("stop_loop");
    maps\_anim::anim_single_solo(self, "cornered_inv_run_start");
    thread maps\_anim::anim_loop_solo(self, "cornered_inv_run", "stop_loop");
  }

  if(self.animname == "rorke") {
    var_0 = getent("inverted_rappel_rorke_stop_volume", "targetname");
    move_to_volume(var_0);
  } else {
    var_0 = getent("inverted_rappel_stop_volume_2", "targetname");
    move_to_volume(var_0);

    if(!common_scripts\utility::flag("inverted_rappel_start_ally_move_2")) {
      self notify("stop_loop");
      maps\_anim::anim_single_solo(self, "cornered_inv_run_stop");
      thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");
      common_scripts\utility::flag_wait("inverted_rappel_start_ally_move_2");
      wait(randomfloatrange(0.0, 0.25));
      self notify("stop_loop");
      maps\_anim::anim_single_solo(self, "cornered_inv_run_start");
      thread maps\_anim::anim_loop_solo(self, "cornered_inv_run", "stop_loop");
    }

    var_0 = getent("inverted_rappel_stop_volume", "targetname");
    move_to_volume(var_0);
    self notify("stop_loop");
    maps\_anim::anim_single_solo(self, "cornered_inv_run_stop");
    thread maps\_anim::anim_loop_solo(self, "cornered_inv_idle", "stop_loop");
  }
}

move_to_volume(var_0) {
  if(!self istouching(var_0)) {
    for(;;) {
      if(self istouching(var_0)) {
        break;
      }

      wait 0.05;
    }
  }
}

rorke_inverted_kill(var_0) {
  common_scripts\utility::flag_set("rorke_inverted_kill");
  thread maps\cornered_audio::aud_invert("r_pounce");

  if(maps\cornered_code::is_e3()) {
    wait 2;
    thread maps\cornered_code::interest_of_time_transition();
  }
}

rorke_inverted_kill_knife_putaway(var_0) {
  level.rorke_inverted_kill_knife thread maps\cornered_code::entity_cleanup();
  maps\cornered_lighting::fireworks_stop();
  common_scripts\utility::waitframe();
  thread maps\cornered_lighting::fireworks_courtyard();
}

inverted_baker_door(var_0) {
  var_1 = maps\_utility::spawn_anim_model("courtyard_entry");
  var_2 = getent("cy_entry_door1", "targetname");
  var_3 = getent("cy_entry_door1_handle", "targetname");
  var_4 = getent("cy_entry_door2", "targetname");
  var_3 linkto(var_2);
  level.rappel_entry_anim_struct maps\_anim::anim_first_frame_solo(var_1, "cornered_inv_tkdn_doors");
  var_2 linkto(var_1, "j_prop_1");
  var_4 linkto(var_1, "j_prop_2");
  level.rappel_entry_anim_struct maps\_anim::anim_single_solo(var_1, "cornered_inv_tkdn_doors");
}