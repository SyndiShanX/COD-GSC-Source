/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_rappel.gsc
*****************************************************/

cornered_rappel_pre_load() {
  common_scripts\utility::flag_init("c_rappel_player_on_rope");
  common_scripts\utility::flag_init("c_rappel_jumpdown_allowed");
  common_scripts\utility::flag_init("c_rappel_first_jump_done");
  common_scripts\utility::flag_init("c_rappel_second_jump_starting");
  common_scripts\utility::flag_init("c_rappel_second_jump_done");
  common_scripts\utility::flag_init("c_rappel_final_jump_starting");
  common_scripts\utility::flag_init("floor_clear");
  common_scripts\utility::flag_init("force_jump");
  common_scripts\utility::flag_init("player_jumping");
  common_scripts\utility::flag_init("c_rappel_player_pressed_jump");
  common_scripts\utility::flag_init("stop_manage_player_rappel_movement");
  common_scripts\utility::flag_init("here_they_come");
  common_scripts\utility::flag_init("all_rappel_one_enemies_in_front_dead");
  common_scripts\utility::flag_init("all_rappel_two_enemies_in_front_dead");
  common_scripts\utility::flag_init("start_glass_fx");
  common_scripts\utility::flag_init("stop_watch_player_pitch");
  common_scripts\utility::flag_init("baker_start_jump");
  common_scripts\utility::flag_init("part_one_start");
  common_scripts\utility::flag_init("part_one_complete");
  common_scripts\utility::flag_init("part_two_complete");
  common_scripts\utility::flag_init("p2_second_wave_downstairs_ready_to_spawn");
  common_scripts\utility::flag_init("player_has_looked_up");
  common_scripts\utility::flag_init("nag_reset");
  common_scripts\utility::flag_init("move_into_building");
  common_scripts\utility::flag_init("player_has_looked_up_for_count");
  common_scripts\utility::flag_init("move_on_from_part_one");
  common_scripts\utility::flag_init("stop_dmg_check");
  common_scripts\utility::flag_init("copymachine_go");
  common_scripts\utility::flag_init("copymachine_anim_done");
  common_scripts\utility::flag_init("copymachine_ai_done");
  common_scripts\utility::flag_init("grenade_thrown");
  common_scripts\utility::flag_init("kill_grenade_anim");
  common_scripts\utility::flag_init("grenade_roll_explode");
  common_scripts\utility::flag_init("player_is_away_from_grenade");
  common_scripts\utility::flag_init("throw_grenade");
  common_scripts\utility::flag_init("grenade_thrower_dead");
  common_scripts\utility::flag_init("rappel_finished");
  precachestring(&"CORNERED_RAPPEL_DOWN");
  precachemodel("cnd_rappel_railing_obj");
  precachemodel("projectile_m67fraggrenade");
  precachemodel("cnd_garden_glass_entry_ally");
  precachemodel("cnd_garden_glass_entry_baker");
  precachemodel("cnd_garden_glass_entry_player");
  maps\_utility::add_hint_string("rappel_down", &"CORNERED_RAPPEL_DOWN", ::player_combat_rappel_is_jumping);
  level.copymachine = getent("photocopier", "script_noteworthy");
  level.grenade_roll_grenade = getent("grenade_roll_grenade", "targetname");
  level.grenade_roll_grenade hide();
  level.cnd_rappel_railing_obj = getent("cnd_rappel_railing_obj", "targetname");
  level.cnd_rappel_railing_obj hide();
}

setup_rappel() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  level.combat_rappel_startpoint = 1;
  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  thread maps\cornered_audio::aud_check("rappel");
  maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  var_0 = getent("combat_rappel_fall_volume", "targetname");
  var_0 thread maps\cornered_code::cornered_falling_death();
  thread maps\cornered_lighting::fireworks_junction_post();
  level.combat_rappel_rope_coil_rorke show();
  level.combat_rappel_rope_coil_player show();
  level.combat_rappel_rope_coil_baker show();
}

begin_rappel() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  thread handle_rappel();
  thread setup_garden_entry();
  common_scripts\utility::flag_wait("rappel_finished");
  thread maps\_utility::autosave_now();
}

handle_rappel() {
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  thread maps\_utility::battlechatter_on("allies");
  thread maps\_utility::battlechatter_on("axis");
  thread rappel_section();
  common_scripts\utility::flag_wait("rappel_finished");
}

rappel_section() {
  thread player_combat_rappel_begin();
  level.allies[level.const_rorke] thread allies_to_rappel();
  level.allies[level.const_baker] thread allies_to_rappel();
  thread allies_rappel_vo();
  thread combat_rappel_enemies_pt1();
}

player_combat_rappel_begin() {
  level.player endon("death");
  level.player_start_rappel_struct = common_scripts\utility::getstruct("player_start_rappel_struct", "targetname");
  level.player_start_rappel_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "rappel_combat_start");
  level.rappel_max_lateral_dist_right = 300;
  level.rappel_max_lateral_dist_left = 300;
  level.rappel_max_downward_speed = 4.0;
  level.rappel_max_upward_speed = 3.0;
  level.rappel_max_lateral_speed = 9.0;
  level.cnd_rappel_railing_obj show();
  level.cnd_rappel_railing_obj maps\_utility::glow();
  level.combat_rappel_rope_coil_player maps\_utility::glow();
  var_0 = getent("player_rappel_trigger", "targetname");

  if(level.player common_scripts\utility::is_player_gamepad_enabled())
    var_0 sethintstring(&"CORNERED_EXIT_BUILDING_CONSOLE");
  else
    var_0 sethintstring(&"CORNERED_EXIT_BUILDING");

  var_1 = common_scripts\utility::getstruct("player_start_rappel_struct", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, level.player_start_rappel_struct, cos(60), 0, 1);
  common_scripts\utility::flag_set("c_rappel_player_on_rope");

  if(isDefined(level.player.has_binoculars) && level.player.has_binoculars == 1)
    level.player maps\cornered_binoculars::take_binoculars();

  level.combat_rappel_rope_coil_player maps\_utility::stopglow();
  level.cnd_rappel_railing_obj maps\_utility::stopglow();
  level.cnd_rappel_railing_obj delete();
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  maps\cornered_code::take_away_offhands();

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 0.8;
  }

  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  level.player_exit_to_combat_rappel_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
  level.player_exit_to_combat_rappel_rope hide();
  level.player_start_rappel_struct thread maps\_anim::anim_first_frame_solo(level.player_exit_to_combat_rappel_rope, "rappel_combat_start");
  var_2 = maps\_utility::spawn_anim_model("combat_exit_rope");
  level.cnd_rappel_player_rope = maps\_utility::spawn_anim_model("cnd_rappel_player_rope");
  level.cnd_rappel_player_rope hide();
  level.cnd_rappel_player_rope linkto(var_2, "j_prop_1", (0, 0, 0), (0, 0, 0));
  maps\cornered_code_rappel::cnd_plyr_rope_set_idle();
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.6);
  thread maps\cornered_audio::aud_rappel_combat("event");
  thread maps\cornered_audio::aud_junction("hookup");
  level.player_start_rappel_struct thread maps\_anim::anim_single(level.arms_and_legs, "rappel_combat_start");
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(level.player_exit_to_combat_rappel_rope, "rappel_combat_start");
  level.player_start_rappel_struct thread maps\_anim::anim_first_frame_solo(var_2, "rappel_combat_start");
  var_3 = getent("combat_rappel_fall_volume", "targetname");
  var_3 delete();
  wait 0.6;
  level.cornered_player_arms show();
  maps\cornered_code::hide_player_arms_sleeve_flaps();
  level.cornered_player_legs show();
  level.player freezecontrols(0);
  level.player enableinvulnerability();
  wait 0.2;
  level.player_exit_to_combat_rappel_rope show();
  level.cornered_player_arms thread player_exit_to_combat_rappel_notetrack_handler(var_2);
  wait 1.5;
  maps\cornered_lighting::do_specular_sun_lerp(1);
  common_scripts\utility::flag_set("here_they_come");
  level.combat_rappel_rope_coil_rorke delete();
  level.combat_rappel_rope_coil_player delete();
  level.combat_rappel_rope_coil_baker delete();
  level.cornered_player_arms waittillmatch("single anim", "end");
  var_2 delete();
  maps\_utility::music_play("mus_cornered_combat_rappel");
  common_scripts\utility::flag_set("c_rappel_first_jump_done");
}

player_exit_to_combat_rappel_notetrack_handler(var_0) {
  var_1 = 0;

  for(;;) {
    self waittill("single anim", var_2);

    switch (var_2) {
      case "start_prop_rope":
        if(!var_1) {
          level.cnd_rappel_player_rope show();
          level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_0, "rappel_combat_start");
          var_1 = 1;
        }

        break;
      case "delete_player_rope":
        level.player_exit_to_combat_rappel_rope delete();
        break;
      case "camera_look":
        break;
      case "glass_hit_1":
        level.player playrumbleonentity("light_1s");
        break;
      case "baker_start":
        common_scripts\utility::flag_set("baker_start_jump");
        break;
      case "glass_hit_2":
        level.player playrumbleonentity("light_1s");
        break;
      case "gun_up":
        level.player enableweapons();
        level.player thread maps\cornered_code::player_flap_sleeves();
        break;
      case "camera_free":
        thread player_combat_rappel();
        level.player disableinvulnerability();
        maps\cornered_code::hide_player_arms();
        level.cornered_player_legs hide();
        common_scripts\utility::flag_set("part_one_start");
        break;
    }

    wait 0.05;
  }
}

lerp_player_view_jump(var_0) {
  level.player lerpviewangleclamp(1.0, 0, 0, 0, 0, 0, var_0.bottom_arc);
  wait 2;
  level.player lerpviewangleclamp(1.0, 0, 0, var_0.right_arc, var_0.left_arc, var_0.top_arc, var_0.bottom_arc);
}

player_combat_rappel() {
  if(common_scripts\utility::flag("c_rappel_player_pressed_jump"))
    common_scripts\utility::flag_clear("c_rappel_player_pressed_jump");

  if(common_scripts\utility::flag("c_rappel_jumpdown_allowed"))
    common_scripts\utility::flag_clear("c_rappel_jumpdown_allowed");

  common_scripts\utility::flag_clear("player_allow_rappel_down");
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
  var_0.lateral_plane = 2;
  var_0.rappel_type = "combat";
  level.rappel_params = var_0;
  maps\cornered_code_rappel::cornered_start_rappel("rope_ref_combat", "player_rappel_ground_ref_combat", var_0);
  thread handle_rope_hitting_enemies();
  common_scripts\utility::flag_set("player_allow_rappel_down");
  maps\cornered_code_rappel::rappel_limit_vertical_move(0, 100);
  common_scripts\utility::flag_wait("c_rappel_jumpdown_allowed");
  common_scripts\utility::flag_set("disable_rappel_jump");
  level.player thread maps\_utility::display_hint("rappel_down");
  level thread player_wait_for_jump_button();
  common_scripts\utility::flag_wait("c_rappel_player_pressed_jump");
  thread lerp_player_view_jump(var_0);
  wait 1;
  player_combat_rappel_second_jump(var_0);
  common_scripts\utility::flag_clear("c_rappel_jumpdown_allowed");
  common_scripts\utility::flag_clear("disable_rappel_jump");
  maps\cornered_code_rappel::rappel_limit_vertical_move(0, 100);
  level.rappel_max_lateral_dist_right = 500;
  level.rappel_max_lateral_dist_left = 500;
  common_scripts\utility::flag_wait("c_rappel_jumpdown_allowed");
  common_scripts\utility::flag_set("disable_rappel_jump");
  common_scripts\utility::flag_clear("c_rappel_player_pressed_jump");
  level.player thread maps\_utility::display_hint("rappel_down");
  level thread player_wait_for_jump_button();
  thread combat_rappel_spawn_garden_entry_enemies();
  common_scripts\utility::flag_wait("c_rappel_player_pressed_jump");
  common_scripts\utility::flag_set("c_rappel_final_jump_starting");
  maps\_utility::delaythread(0.7, maps\cornered_audio::aud_start_garden_events);
  common_scripts\utility::exploder(1200);
  combat_rappel_garden_entry();
  common_scripts\utility::flag_clear("disable_rappel_jump");
}

handle_rope_hitting_enemies() {
  level endon("c_rappel_final_jump_starting");

  while(!isDefined(level.cnd_rappel_player_rope))
    common_scripts\utility::waitframe();

  for(;;) {
    var_0 = level.cnd_rappel_player_rope gettagorigin("joint9");
    var_1 = level.cnd_rappel_player_rope gettagorigin("joint1");
    var_2 = vectornormalize(var_1 - var_0);
    var_3 = var_0 + var_2 * 400;
    var_4 = bulletTrace(var_0, var_3, 1, level.player, 0, 1);
    var_5 = var_4["entity"];
    var_6 = isDefined(var_5) && isDefined(var_5.animname) && (var_5.animname == "rorke" || var_5.animname == "baker");

    if(isDefined(var_5) && isai(var_5) && isalive(var_5) && !var_6 && !isDefined(var_5.balcony_death))
      var_5 kill();

    wait 0.1;
  }
}

need_to_hold() {
  if(level.console || level.player common_scripts\utility::is_player_gamepad_enabled())
    return 1;

  var_0 = getkeybinding("+gostand");

  if(var_0["key1"] == &"KEY_MWHEELUP" || var_0["key2"] == &"KEY_MWHEELUP" || var_0["key1"] == &"KEY_MWHEELDOWN" || var_0["key2"] == &"KEY_MWHEELDOWN")
    return 0;

  return 1;
}

player_wait_for_jump_button() {
  for(;;) {
    wait 0.05;

    if(level.player jumpbuttonpressed()) {
      var_0 = 0;
      var_1 = need_to_hold();

      while(level.player jumpbuttonpressed() && var_1) {
        if(var_0 >= 0.25) {
          break;
        }

        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_1 && var_0 < 0.25) {
        continue;
      }
      if(!common_scripts\utility::flag("player_jumping"))
        common_scripts\utility::flag_set("c_rappel_player_pressed_jump");
    }
  }
}

player_combat_rappel_is_jumping() {
  return common_scripts\utility::flag("c_rappel_player_pressed_jump");
}

player_combat_rappel_second_jump(var_0) {
  common_scripts\utility::flag_set("c_rappel_second_jump_starting");
  var_1 = spawnStruct();
  var_1.angles = (0, -35, 0);
  var_1.origin = (-24953, 6284, 21677);
  common_scripts\utility::flag_clear("disable_rappel_jump");
  level.rappel_lower_limit = undefined;
  maps\cornered_code_rappel::player_rappel_force_jump_away(var_1);
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("disable_rappel_jump");
  level waittill("player_force_jump_landed");
  common_scripts\utility::flag_set("c_rappel_second_jump_done");
}

combat_rappel_garden_entry_should_shift_allies(var_0) {
  return var_0.anim_ref != "C" && var_0.anim_ref != "L1" && var_0.anim_ref != "R1";
}

combat_rappel_garden_entry_allies(var_0) {
  var_1 = "rappel_combat_end";

  if(combat_rappel_garden_entry_should_shift_allies(var_0))
    var_1 = "rappel_combat_end_shift";

  foreach(var_3 in level.allies) {
    var_3 maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
    var_3 unlink();
    var_3 notify("stop_loop");
    level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_3, var_1);
    var_3 maps\cornered_code_rappel_allies::ally_rappel_rope_cleanup();
  }
}

combat_rappel_garden_entry_ropes(var_0) {
  var_1 = "cornered_combat_rappel_garden_entry_rope_";

  if(combat_rappel_garden_entry_should_shift_allies(var_0))
    var_1 = "cornered_combat_rappel_garden_entry_shift_rope_";

  foreach(var_3 in level.allies) {
    if(!isDefined(var_3.cnd_rappel_tele_rope))
      var_3.cnd_rappel_tele_rope = maps\_utility::spawn_anim_model("rope");

    var_4 = var_1 + var_3.animname;
    var_3.cnd_rappel_tele_rope.animname = "rope";
    level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_3.cnd_rappel_tele_rope, var_4);
  }
}

get_tree() {
  var_0 = common_scripts\utility::getstruct("garden_baker", "targetname");
  var_1 = getEntArray("garden_entry_tree", "targetname");

  if(var_1.size == 1)
    return var_1[0];

  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_1) {
    var_6 = distancesquared(var_5.origin, var_0.origin);

    if(var_3 == -1 || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

get_bush() {
  var_0 = common_scripts\utility::getstruct("garden_baker", "targetname");
  var_1 = getEntArray("garden_entry_bush", "targetname");

  if(var_1.size == 1)
    return var_1[0];

  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_1) {
    var_6 = distancesquared(var_5.origin, var_0.origin);

    if(var_3 == -1 || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

#using_animtree("animated_props");

combat_rappel_garden_entry_tree() {
  var_0 = get_tree();
  var_1 = get_bush();
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("generic_prop_raven");
  var_2 useanimtree(#animtree);
  var_2.animname = "tree";
  var_1.origin = var_0.origin;
  var_0 linkto(var_2, "j_prop_1");
  var_1 linkto(var_2, "j_prop_2");
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_2, "cornered_combat_rappel_garden_entry_tree_shake");
}

combat_rappel_garden_entry_grenades() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("generic_prop_raven");
  var_0 useanimtree(#animtree);
  var_0.animname = "grenades";
  var_1 = level.allies[0] magicgrenade((0, 0, 0), (0, 0, 0), 100, 0);
  var_1 linkto(var_0, "J_prop_1");
  var_2 = level.allies[0] magicgrenade((0, 0, 0), (0, 0, 0), 100, 0);
  var_2 linkto(var_0, "J_prop_2");
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_0, "cornered_combat_rappel_garden_entry_grenades");
  var_3 = level.allies[level.const_baker];
  var_4 = 0;

  while(var_4 < 2) {
    var_3 waittill("single anim", var_5);

    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = undefined;

    if(var_5 == "grenade_explode1")
      var_6 = var_1;
    else if(var_5 == "grenade_explode2")
      var_6 = var_2;

    if(!isDefined(var_6)) {
      continue;
    }
    var_4++;
    var_6 detonate();
  }
}

combat_rappel_spawn_garden_entry_enemies() {
  var_0 = 4;
  level.garden_entry_enemies = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(var_1 + 1 == 2) {
      continue;
    }
    var_2 = getent("garden_entry_enemies", "targetname");
    var_2.count = 1;
    var_3 = maps\_utility::spawn_targetname("garden_entry_enemies", 1);
    var_3.animname = "generic";
    var_3.ignoreme = 1;
    var_3.ignoreall = 1;
    var_3.a.nodeath = 1;
    var_3.anim_ref = "cornered_combat_rappel_garden_entry_redshirt" + (var_1 + 1);
    level.player_start_rappel_struct thread maps\_anim::anim_generic_first_frame(var_3, var_3.anim_ref);
    level.garden_entry_enemies[level.garden_entry_enemies.size] = var_3;
    common_scripts\utility::waitframe();
  }
}

combat_rappel_garden_entry_enemies() {
  for(var_0 = 0; var_0 < level.garden_entry_enemies.size; var_0++) {
    var_1 = level.garden_entry_enemies[var_0];
    var_1.animname = "generic";
    var_1.entry = 1;
    level.player_start_rappel_struct thread maps\_anim::anim_generic(var_1, var_1.anim_ref);
    var_1 thread combat_rappel_garden_entry_enemy_death();
  }

  maps\_utility::waittill_dead(level.garden_entry_enemies);
  level.garden_entry_enemies = undefined;
}

combat_rappel_garden_entry_enemy_death() {
  self endon("death");

  for(;;) {
    self waittill("single anim", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 != "start_ragdoll" && var_0 != "end") {
      continue;
    }
    self.a.nodeath = 1;

    if(var_0 == "end") {
      self.a.nodeath = 0;
      self.ragdoll_immediate = 1;
    }

    self kill();
    return;
  }
}

combat_rappel_garden_entry_setup_jumpoints() {
  if(!isDefined(level.player_start_rappel_struct))
    level.player_start_rappel_struct = common_scripts\utility::getstruct("player_start_rappel_struct", "targetname");

  var_0 = level.player_start_rappel_struct;
  level.jump_anims = [];
  level.jump_anims[0] = create_jump_point(var_0, "C");
  level.jump_anims[1] = create_jump_point(var_0, "R1");
  level.jump_anims[2] = create_jump_point(var_0, "R2");
  level.jump_anims[3] = create_jump_point(var_0, "R3");
  level.jump_anims[4] = create_jump_point(var_0, "R4");
  level.jump_anims[5] = create_jump_point(var_0, "L1");
  level.jump_anims[6] = create_jump_point(var_0, "L2");
  level.jump_anims[7] = create_jump_point(var_0, "L3");
}

create_jump_point(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.anim_ref = var_1;
  var_3 = level.scr_anim["jump_info"][var_1];
  var_2.start_origin = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_2.start_angles = getstartangles(var_0.origin, var_0.angles, var_3);
  var_2.anim_length = getanimlength(var_3);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_2.start_origin;
  var_4.angles = var_2.start_angles;
  var_4 setModel("generic_prop_raven");
  var_4 useanimtree(#animtree);
  var_4.animname = "jump_info";
  var_4 setanim(var_3, 1.0, 0, 0);
  common_scripts\utility::waitframe();
  var_2.start_origin = var_4 gettagorigin("J_prop_1");
  var_2.start_angles = var_4 gettagangles("J_prop_1");
  var_2.rope_origin = var_4 gettagorigin("J_prop_2");
  var_2.rope_angles = var_4 gettagangles("J_prop_2");
  var_4 delete();
  return var_2;
}

get_jump_info() {
  var_0 = -1;
  var_1 = undefined;

  foreach(var_3 in level.jump_anims) {
    var_4 = distancesquared(level.player.origin, var_3.start_origin);

    if(var_4 < var_0 || var_0 == -1) {
      var_0 = var_4;
      var_1 = var_3;
    }
  }

  return var_1;
}

spawn_jump_point(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.start_origin;
  var_1.angles = var_0.start_angles;
  var_1 setModel("generic_prop_raven");
  var_1 useanimtree(#animtree);
  var_1.animname = "jump_info";
  return var_1;
}

combat_rappel_garden_entry_setup_glass() {
  var_0 = getent("garden_entry_glass_player_still", "targetname");
  var_1 = getent("garden_entry_glass_ally_still", "targetname");
  var_2 = getent("garden_entry_glass_player_still2", "targetname");
  var_0 hide();
  var_1 hide();
  var_2 hide();
}

combat_rappel_garden_entry_glass() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("cnd_garden_glass_entry_ally");
  var_0 useanimtree(#animtree);
  var_0.animname = "glass";
  var_0 hide();
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("cnd_garden_glass_entry_baker");
  var_1 useanimtree(#animtree);
  var_1.animname = "glass";
  var_1 hide();
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("cnd_garden_glass_entry_player");
  var_2 useanimtree(#animtree);
  var_2.animname = "glass";
  var_2 hide();
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_0, "cornered_combat_rappel_garden_entry_ally_glass");
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_1, "cornered_combat_rappel_garden_entry_baker_glass");
  level.player_start_rappel_struct thread maps\_anim::anim_single_solo(var_2, "cornered_combat_rappel_garden_entry_player_glass");
  var_3 = getent("garden_entry_glass_player_clean", "targetname");
  var_4 = getent("garden_entry_glass_ally_clean", "targetname");
  var_5 = getent("garden_entry_glass_player_still", "targetname");
  var_6 = getent("garden_entry_glass_player_still2", "targetname");
  var_7 = getent("garden_entry_glass_ally_still", "targetname");
  var_8 = level.allies[level.const_rorke];
  var_9 = 0;

  while(var_9 < 3) {
    var_8 waittill("single anim", var_10);

    if(!isDefined(var_10)) {
      continue;
    }
    if(var_10 == "show_glass_right") {
      var_4 delete();
      var_7 show();
      var_0 show();
      var_9++;
      thread maps\cornered_audio::aud_rappel_combat("window1");
      continue;
    }

    if(var_10 == "show_glass_left") {
      var_3 delete();
      var_5 show();
      var_1 show();
      var_9++;
      thread maps\cornered_audio::aud_rappel_combat("window2");
      continue;
    }

    if(var_10 == "show_glass_plyr") {
      var_5 delete();
      var_6 show();
      var_2 show();
      var_9++;
      thread maps\cornered_audio::aud_rappel_combat("window3");
      level.player playrumbleonentity("light_1s");
    }
  }
}

combat_rappel_garden_entry_slowmo() {
  wait 1.4;
  var_0 = maps\_utility::get_living_ai_array("garden_entry_fodder", "script_noteworthy");
  var_1 = maps\_utility::get_living_ai_array("garden_entry_temp_fodder", "script_noteworthy");

  foreach(var_3 in var_0)
  var_3.health = 1;

  foreach(var_3 in var_1)
  var_3.health = 1;

  wait 2.0;
  level.player lerpviewangleclamp(0.2, 0, 0, 0, 0, 0, 0);
  level.player disableweapons();
  wait 0.5;
  level.player enableweapons();
  maps\cornered_code::give_back_offhands();
  level.player lerpviewangleclamp(0, 0, 0, 55, 55, 55, 10);

  foreach(var_3 in var_0) {
    if(isalive(var_3))
      var_3 kill();
  }

  common_scripts\utility::flag_wait("garden_player_in_garden");

  foreach(var_3 in var_1) {
    if(isalive(var_3))
      var_3.health = 150;
  }
}

combat_rappel_garden_entry_first_frame(var_0, var_1) {
  level.player_start_rappel_struct maps\_anim::anim_first_frame_solo(var_0, var_1.anim_ref);
  var_2 = (0, 325, 0);
  var_3 = var_0 gettagorigin("J_prop_1");
  level.rappel_player_arms = maps\_utility::spawn_anim_model("player_rappel_arms");
  level.rappel_player_arms.origin = var_3;
  level.rappel_player_arms.angles = var_2;
  level.rappel_player_arms dontcastshadows();
  level.rappel_player_arms hide();
  level.rappel_player_arms linkto(var_0, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_4 = maps\cornered_code_rappel::rpl_get_garden_entry_arms_static_anim();
  level.rappel_player_arms setanimknob(var_4, 1.0, 0, 0);
  common_scripts\utility::waitframe();
}

combat_rappel_garden_entry_set_small_rotate_jump() {
  level.rappel_rotate_jump_anim = % rappel_movement_player_small_jump_rotate;
}

combat_rappel_garden_entry() {
  if(!isDefined(level.player_start_rappel_struct))
    level.player_start_rappel_struct = common_scripts\utility::getstruct("player_start_rappel_struct", "targetname");

  thread combat_rappel_garden_entry_setup_weapon();
  level.player enableinvulnerability();
  var_0 = get_jump_info();
  var_1 = spawn_jump_point(var_0);
  combat_rappel_garden_entry_first_frame(var_1, var_0);
  combat_rappel_garden_entry_player(var_1, var_0);
  maps\_utility::delaythread(1.0, common_scripts\utility::flag_set, "garden_spawn_first_enemies");
  maps\_utility::delaythread(1.0, common_scripts\utility::flag_set, "rappel_finished");
  thread maps\cornered_audio::aud_rappel_combat("swing");
  var_2 = getdvar("cg_hudGrenadeIconOffset");
  setsaveddvar("cg_hudGrenadeIconOffset", "512");
  thread combat_rappel_garden_entry_enemies();
  thread combat_rappel_garden_entry_allies(var_0);
  thread combat_rappel_garden_entry_ropes(var_0);
  thread combat_rappel_garden_entry_tree();
  thread combat_rappel_garden_entry_grenades();
  thread combat_rappel_garden_entry_glass();
  thread combat_rappel_garden_entry_slowmo();
  level.player_start_rappel_struct maps\_anim::anim_single_solo(var_1, var_0.anim_ref);
  thread maps\_utility::autosave_now();
  level.jump_anims = undefined;
  level.player unlink();
  level.rappel_player_legs delete();
  level.rappel_player_arms delete();

  if(isDefined(var_1))
    var_1 delete();

  setsaveddvar("cg_hudGrenadeIconOffset", var_2);
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  level.player allowsprint(1);
  common_scripts\utility::flag_set("garden_player_in_garden");
  var_3 = 3.0;
  wait(var_3);
  level.player disableinvulnerability();
}

combat_rappel_garden_entry_setup_weapon() {
  level.player allowmelee(0);
}

combat_rappel_garden_entry_player(var_0, var_1) {
  var_2 = var_0 gettagorigin("J_prop_1");
  var_3 = var_0 gettagangles("J_prop_1");
  var_4 = var_0 gettagorigin("J_prop_2");
  var_5 = var_0 gettagangles("J_prop_2");

  if(!isDefined(level.rappel_player_legs)) {
    level.rappel_player_legs = maps\_utility::spawn_anim_model("player_rappel_legs", var_2);
    level.rappel_player_legs.angles = var_3;
    level.rappel_player_legs dontcastshadows();
    var_6 = maps\cornered_code_rappel::rpl_get_legs_idle_anim();
    level.rappel_player_legs setanim(var_6, 1.0, 0, 1.0);
    level.player playerlinkto(level.rappel_player_legs, "tag_origin", 0, 120, 120, 60, 50, 0);
    wait 2;
  }

  if(!isDefined(level.cnd_rappel_player_rope)) {
    level.cnd_rappel_player_rope = maps\_utility::spawn_anim_model("cnd_rappel_player_rope", var_4);
    level.cnd_rappel_player_rope.angles = var_5;
    maps\cornered_code_rappel::cnd_plyr_rope_set_idle();
    common_scripts\utility::waitframe();
  }

  if(!isDefined(level.start_point) || level.start_point != "garden")
    combat_rappel_garden_entry_double_jump(var_0);

  var_7 = 0.2;
  combat_rappel_garden_entry_blend_to_position(var_7, var_0);
  var_6 = maps\cornered_code_rappel::rpl_get_garden_entry_legs_static_anim();
  var_8 = maps\cornered_code_rappel::rpl_get_garden_entry_arms_static_anim();
  level.rappel_player_arms setanimknob(var_8, 1.0, 0.2, 1.0);
  level.rappel_player_legs setanimknob(var_6, 1.0, 0.2, 1.0);
  thread combat_rappel_garden_entry_finish_player_rope(var_1);
}

combat_rappel_garden_entry_double_jump(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0 gettagorigin("j_prop_1");
  var_1.angles = var_0 gettagangles("j_prop_1");
  common_scripts\utility::flag_clear("disable_rappel_jump");
  var_2 = var_0 gettagorigin("J_prop_2");
  var_3 = var_0 gettagangles("J_prop_2");
  combat_rappel_garden_entry_set_small_rotate_jump();
  combat_rappel_garden_entry_set_small_legs_jump();
  var_4 = 0.7;
  var_5 = getanimlength(level.rappel_legs_jump_anim);
  var_6 = var_5 * var_4;
  var_7 = var_5 * 0.8;
  level.player_torso_offset_origin linkto(level.rappel_player_legs, "tag_origin");
  level.rpl_physical_rope_origin delete();
  maps\cornered_code_rappel::player_rappel_force_jump_away(var_1);
  thread combat_rappel_garden_entry_rotate_legs(var_6);
  thread maps\cornered_code::lerp_entity_to_position_accurate(level.cnd_rappel_player_rope, var_2, var_3, var_6);
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("disable_rappel_jump");
  level waittill("player_force_jump_landed");
  maps\cornered_code_rappel::cornered_stop_rappel();
  level.player maps\cornered_code::player_stop_flap_sleeves();
  level.rappel_legs_jump_anim = undefined;
  level.rappel_rotate_jump_anim = undefined;
}

combat_rappel_garden_entry_rotate_legs(var_0) {
  var_1 = var_0 / 0.05;
  var_2 = level.rappel_player_legs.angles[2];
  var_3 = -1 * var_2 / var_1;
  common_scripts\utility::waitframe();

  for(var_4 = 0; var_4 < var_1; var_4++) {
    level.rappel_player_legs unlink();
    var_5 = level.rappel_player_legs.angles[2] + var_3;
    var_6 = (level.rappel_player_legs.angles[0], level.rappel_player_legs.angles[1], var_5);
    level.rappel_player_legs.angles = var_6;
    level.rappel_player_legs linkto(level.rpl_plyr_legs_link_ent);
    common_scripts\utility::waitframe();
  }
}

#using_animtree("player");

combat_rappel_garden_entry_set_small_legs_jump() {
  level.rappel_legs_jump_anim = % cnd_rappel_small_jump_playerlegs;
}

combat_rappel_garden_entry_blend_to_position(var_0, var_1) {
  var_2 = var_1 gettagorigin("J_prop_1");
  var_3 = var_1 gettagangles("J_prop_1");
  var_4 = var_1 gettagorigin("J_prop_2");
  var_5 = var_1 gettagangles("J_prop_2");
  maps\_utility::delaythread(var_0, ::player_clear_groundref);
  thread maps\cornered_code::lerp_entity_to_position_accurate(level.rappel_player_legs, var_2, var_3, var_0);
  level.player playerlinktoblend(level.rappel_player_arms, "tag_player", var_0);

  foreach(var_7 in level.allies)
  var_7 maps\cornered_code_rappel_allies::ally_rappel_stop_rope();

  wait(var_0);
  level.rappel_player_legs linkto(var_1, "J_prop_1", (0, 0, 0), (0, 0, 0));
  level.cnd_rappel_player_rope linkto(var_1, "J_prop_2", (0, 0, 0), (0, 0, 0));
}

combat_rappel_garden_entry_finish_player_rope(var_0) {
  var_1 = var_0.anim_length;
  var_2 = 3.8;
  var_3 = var_1 - var_2;
  wait(var_2);
  level.cnd_rappel_player_rope unlink();
  wait(var_3);
  level.cnd_rappel_player_rope delete();
}

setup_garden_entry() {
  combat_rappel_garden_entry_setup_jumpoints();
  combat_rappel_garden_entry_setup_glass();
}

player_clear_groundref() {
  level.player playersetgroundreferenceent(undefined);
  common_scripts\utility::waitframe();
  level.player playerlinktodelta(level.rappel_player_arms, "tag_player", 1, 55, 55, 55, 10, 0);
}

allies_to_rappel() {
  if(!isDefined(self.magic_bullet_shield))
    maps\_utility::magic_bullet_shield();

  if(isDefined(level.combat_rappel_startpoint))
    level.player_start_rappel_struct thread maps\_anim::anim_loop_solo(self, "cornered_junction_c4_idle_" + self.animname, "stop_loop_" + self.animname);

  common_scripts\utility::flag_wait("c_rappel_player_on_rope");
  thread allies_rappel_anims();
}

allies_rappel_anims() {
  if(self.animname == "rorke") {
    if(!isDefined(level.rorke_and_combat_rappel_rope)) {
      level.combat_rappel_rope_rorke = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
      level.combat_rappel_rope_rorke.animname = "combat_rappel_exit_rope_rorke";
      level.rorke_and_combat_rappel_rope = [];
      level.rorke_and_combat_rappel_rope[0] = self;
      level.rorke_and_combat_rappel_rope[1] = level.combat_rappel_rope_rorke;
      level.player_start_rappel_struct maps\_anim::anim_first_frame_solo(level.combat_rappel_rope_rorke, "combat_rappel_building_exit_rorke");
    }

    level.player_start_rappel_struct notify("stop_loop_rorke");
    level.player_start_rappel_struct maps\_anim::anim_single(level.rorke_and_combat_rappel_rope, "combat_rappel_building_exit_rorke");
    level.combat_rappel_rope_rorke delete();
    maps\cornered_code_rappel_allies::ally_rappel_start_rope("combat");
  } else {
    common_scripts\utility::flag_wait("baker_start_jump");
    level.player_start_rappel_struct notify("stop_loop_baker");
    self.move_type = "animating";
    thread die_hard_explosion_fx();
    thread maps\cornered_audio::aud_rappel_combat("explode");
    var_0 = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
    var_0.animname = "rope";
    var_1 = [];
    var_1[0] = self;
    var_1[1] = var_0;
    level.player_start_rappel_struct maps\_anim::anim_first_frame(var_1, "combat_rappel_building_exit_baker");
    level.player_start_rappel_struct maps\_anim::anim_single(var_1, "combat_rappel_building_exit_baker");
    var_0 delete();
    maps\cornered_code_rappel_allies::ally_rappel_start_rope("combat");
  }

  level.flag_to_check = "all_rappel_one_enemies_in_front_dead";
  thread maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("combat", "one", "c_rappel_second_jump_starting");
  common_scripts\utility::flag_wait("c_rappel_second_jump_starting");
  level.flag_to_check = "all_rappel_two_enemies_in_front_dead";
  self notify("stop_loop");
  waittillframeend;
  maps\cornered_code_rappel_allies::ally_rappel_stop_aiming();
  maps\cornered_code_rappel_allies::ally_rappel_stop_shooting();
  level.player_start_rappel_struct maps\_anim::anim_single_solo(self, "cornered_combat_rappel_jump_down_" + self.animname);
  maps\cornered_code_rappel_allies::ally_rappel_start_aiming("combat");
  maps\cornered_code_rappel_allies::ally_rappel_start_shooting();
  thread maps\cornered_code_rappel_allies::ally_rappel_start_movement_horizontal("combat", "two", "c_rappel_final_jump_starting");
}

die_hard_explosion_fx() {
  wait 0.95;
  common_scripts\utility::exploder("diehard_explosion");
  level.player playrumbleonentity("heavy_2s");
  earthquake(0.25, 1, level.player.origin, 800);
}

allies_rappel_vo() {
  common_scripts\utility::flag_wait("here_they_come");
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_heretheycome");
  wait 1;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_kgn_makeitquickhesh");
  common_scripts\utility::flag_wait("c_rappel_first_jump_done");
  wait 1.25;
  thread maps\_utility::smart_radio_dialogue_interrupt("cornered_hsh_aboveus");
  thread copymachine_falling_vo();
  common_scripts\utility::flag_wait("floor_clear");
  wait 1.0;
  common_scripts\utility::flag_clear("floor_clear");
  thread maps\_utility::smart_radio_dialogue_interrupt("cornered_mrk_enemiesonthefloor");
  common_scripts\utility::flag_set("c_rappel_jumpdown_allowed");
  common_scripts\utility::flag_wait("c_rappel_second_jump_done");
  wait 2.0;
  common_scripts\utility::flag_wait("move_into_building");
  maps\_utility::smart_radio_dialogue_interrupt("cornered_hsh_weneedtoget");
  common_scripts\utility::flag_set("c_rappel_jumpdown_allowed");
}

copymachine_falling_vo() {
  common_scripts\utility::flag_wait("copymachine_go");
  wait 2;
}

combat_rappel_enemies_pt1() {
  level.balcony_fall_deaths = 0;
  level.total_balcony_deaths = 0;
  level.last_balcony_death = 0;
  level.last_balcony_death_idx = 1;
  level.enemies_above = [];
  common_scripts\utility::flag_wait("c_rappel_player_on_rope");
  thread break_enemy_windows();
  thread enemy_drones_junction_hallway();
  thread enemy_drones_pt1_upper();
  thread enemy_drones_pt1_lower();
  level.cr_rorke_volume = getent("cr_rorke_side", "targetname");
  level.cr_baker_volume = getent("cr_baker_side", "targetname");
  wait 5.0;
  thread enemy_drones_pt1_lower_runners();
  common_scripts\utility::flag_wait("part_one_start");
  wait 1;
  level.enemies_above_killed = 0;
  maps\_utility::array_spawn_function_targetname("enemies_above_lower_floor", maps\cornered_code::death_func);
  maps\_utility::array_spawn_function_targetname("enemies_above_lower_floor", ::enemies_pt1_lower_behavior);
  thread randomly_spawn_above_enemies_targetname("enemies_above_lower_floor");
  common_scripts\utility::waitframe();
  maps\_utility::array_spawn_function_targetname("enemies_above_upper_floor", maps\cornered_code::death_func);
  maps\_utility::array_spawn_function_targetname("enemies_above_upper_floor", ::enemies_pt1_upper_behavior);
  thread randomly_spawn_above_enemies_targetname("enemies_above_upper_floor");
  maps\cornered_code::waittill_enemies_above_killed(3, 15);
  thread copymachine_window_event();
  maps\_utility::stop_exploder(12);
  maps\_utility::stop_exploder(13);
  maps\_utility::stop_exploder(14);
  maps\_utility::array_spawn_function_targetname("enemies_above_junction_floor", maps\cornered_code::death_func);
  maps\_utility::array_spawn_function_targetname("enemies_above_junction_floor", ::enemies_pt1_junction_behavior);
  randomly_spawn_above_enemies_targetname("enemies_above_junction_floor");
  level.enemies_above = maps\_utility::array_removedead(level.enemies_above);

  while(level.enemies_above.size >= 2) {
    level.enemies_above = maps\_utility::array_removedead(level.enemies_above);
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("move_on_from_part_one");
  common_scripts\utility::flag_set("part_one_complete");
  common_scripts\utility::flag_set("floor_clear");
  thread maps\_utility::autosave_now();
  common_scripts\utility::flag_wait("c_rappel_player_pressed_jump");
  thread combat_rappel_enemies_pt2();
}

randomly_spawn_above_enemies_targetname(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(level.enemies_above.size > 0) {
      var_4 = randomfloatrange(0.4, 1);
      wait(var_4);
    }

    var_3.count = 1;
    var_5 = var_3 maps\_utility::spawn_ai(1);
    level.enemies_above[level.enemies_above.size] = var_5;
  }
}

enemy_drones_junction_hallway() {
  var_0 = getEntArray("junction_runner_drones", "targetname");
  wait 1.5;
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
}

enemy_drones_pt1_upper() {
  var_0 = getEntArray("hallway_talker_drone", "targetname");
  maps\_utility::array_spawn_function_targetname("hallway_talker_drone", ::enemy_drone_anim, undefined, 12.0, 1);
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
  wait 2.0;
  var_1 = getEntArray("hallway_runner_drone", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai, 1);
}

enemy_drones_pt1_lower() {
  var_0 = getEntArray("lower_drone", "targetname");
  maps\_utility::array_spawn_function_targetname("lower_drone", ::enemy_drone_anim, 0, 11.5);
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
}

enemy_drones_pt1_lower_runners() {
  var_0 = getEntArray("lower_drone_runners", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
}

enemy_drone_anim(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 != 0)
    wait(var_0);

  if(isDefined(var_2) && var_2 == 1)
    thread maps\_anim::anim_generic_loop(self, self.script_animation);
  else
    thread maps\_anim::anim_generic(self, self.script_animation);

  if(isDefined(var_1) && var_1 != 0)
    wait(var_1);

  self delete();
}

enemies_pt1_lower_behavior() {
  thread enemy_pt1_setup("p1_lower_floor_node");
}

enemies_pt1_upper_behavior() {
  thread enemy_pt1_setup("p1_upper_floor_node");
}

enemies_pt1_junction_behavior() {
  thread enemy_pt1_setup("p1_junction_floor_node");
}

enemy_pt1_setup(var_0) {
  self endon("death");
  self endon("enemy_above_shot");
  self.baseaccuracy = 1;
  maps\_utility::disable_long_death();
  self.animname = "generic";
  self.allowdeath = 1;
  var_1 = getnodearray(var_0, "targetname");
  var_2 = eliminate_used_nodes(var_1);
  var_3 = sortbydistance(var_2, self.origin);
  var_4 = randomint(2);

  if(var_4 == 1)
    var_5 = var_3[1];
  else
    var_5 = var_3[0];

  if(self.script_noteworthy == "p1_lower") {
    foreach(var_7 in var_2) {
      if(isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "p1_lower_center_node")
        var_5 = var_7;
    }
  }

  var_5.chosen = 1;
  self forceteleport(var_5.origin, var_5.angles);

  while(!common_scripts\utility::flag("move_on_from_part_one")) {
    self.isanimating = 1;
    play_random_window_lean_anim(var_5);
    self.isanimating = 0;
    common_scripts\utility::waitframe();
  }

  send_to_death_volume();
}

play_random_window_lean_anim(var_0) {
  self endon("death");
  self endon("enemy_above_shot");
  var_1 = randomintrange(1, 8);

  if(distance(self.origin, level.player.origin) <= 256)
    var_1 = 2;

  if(self istouching(level.cr_rorke_volume) && var_1 == 3)
    var_1 = 4;

  if(self istouching(level.cr_baker_volume) && var_1 == 4)
    var_1 = 3;

  var_0 maps\_anim::anim_single_solo(self, "enemy_above_" + var_1 + "_start");
  thread maps\_anim::anim_loop_solo(self, "enemy_above_" + var_1 + "_loop", "stop_loop");

  if(var_1 == 5 || var_1 == 6 || var_1 == 7)
    var_2 = randomfloatrange(1.0, 2.25);
  else
    var_2 = randomintrange(5, 10);

  wait(var_2);
  self notify("stop_loop");
  maps\_anim::anim_single_solo(self, "enemy_above_" + var_1 + "_end");
}

eliminate_used_nodes(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.chosen) || !var_3.chosen)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

copymachine_window_event() {
  var_0 = getnodearray("p1_junction_floor_node", "targetname");
  var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
  level.closest_start_struct = common_scripts\utility::getstruct(var_1.target, "targetname");
  common_scripts\utility::waitframe();
  maps\_utility::array_spawn_function_targetname("copier_dude", maps\cornered_code::death_func);
  maps\_utility::array_spawn_function_targetname("copier_dude", ::copymachine_ai);
  common_scripts\utility::waitframe();
  var_2 = maps\_utility::array_spawn_targetname("copier_dude", 1);
  level.enemies_above = common_scripts\utility::array_combine(var_2, level.enemies_above);
  level.player childthread maps\cornered_code::watch_player_pitch_in_volume("copymachine_window_event_volume", "copymachine", "stop_watch_player_pitch");
  common_scripts\utility::flag_wait("stop_watch_player_pitch");
  common_scripts\utility::flag_set("player_has_looked_up");
  level.copymachine_rig = maps\_utility::spawn_anim_model("copymachine_rig", level.closest_start_struct.origin);
  level.copymachine_rig.angles = level.closest_start_struct.angles;
  waittillframeend;
  level.copymachine linkto(level.copymachine_rig, "J_prop_1", (0, 0, 0), (0, 0, 0));
  level.copymachine_rig maps\_anim::anim_first_frame_solo(level.copymachine_rig, "copymachine_fall");
  level.copymachine show();
  level.copymachine_rig thread maps\_anim::anim_single_solo(level.copymachine_rig, "copymachine_fall");
  thread maps\cornered_audio::aud_rappel_combat("copy", level.copymachine_rig);
  common_scripts\utility::flag_set("copymachine_go");
  var_3 = getent("copymachine_clip", "targetname");
  var_3 linkto(level.copymachine_rig, "J_prop_1", (0, -8, 20), (0, 0, 0));
  var_3 thread copymachine_hit_detect("copymachine_anim_done");
  level.copymachine_rig waittillmatch("single anim", "end");
  level.copymachine unlink();
  level.copymachine physicslaunchclient(level.copymachine.origin + (0, 0, 4), (0, 0, -600));
  level.copymachine_rig delete();
  common_scripts\utility::flag_set("copymachine_anim_done");
  thread copymachine_cleanup();
}

copymachine_hit_detect(var_0) {
  level endon(var_0);
  common_scripts\utility::flag_clear("stop_dmg_check");
  var_1 = level.player.maxhealth * 0.7;

  while(!common_scripts\utility::flag("stop_dmg_check")) {
    var_2 = self istouching(level.player);

    if(var_2) {
      level.player dodamage(var_1, self.origin, self);
      thread maps\cornered_audio::aud_rappel_combat("hit");
      common_scripts\utility::flag_set("stop_dmg_check");
      level.player maps\_utility::player_giveachievement_wrapper("LEVEL_7B");
      return;
    }

    common_scripts\utility::waitframe();
  }
}

copymachine_ai() {
  self endon("death");
  self endon("enemy_above_shot");
  var_0 = getnode(level.closest_start_struct.script_noteworthy + "_node_1", "script_noteworthy");
  self setgoalnode(var_0);
  maps\_utility::set_goal_radius(8);
  wait 0.1;
  var_1 = getnode(var_0.script_linkto, "script_linkname");
  self setgoalnode(var_1);
  wait 0.75;
  self forceteleport(self.origin, var_1.angles);
  self.animname = "generic";
  self.allowdeath = 1;
  self.ignoreall = 0;
  common_scripts\utility::flag_set("copymachine_ai_done");

  while(!common_scripts\utility::flag("move_on_from_part_one")) {
    self.isanimating = 1;
    play_random_window_lean_anim(var_1);
    self.isanimating = 0;
  }
}

copymachine_break_glass(var_0) {
  var_1 = common_scripts\utility::getstructarray("p1_upper_glass_damage_struct", "targetname");
  var_2 = common_scripts\utility::getclosest(level.closest_start_struct.origin, var_1);
  glassradiusdamage(var_2.origin, 96, 50, 50);
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_2.origin;
  playFXOnTag(common_scripts\utility::getfx("copier_papers_falling"), var_3, "tag_origin");
  wait 5;
  var_3 delete();
}

copymachine_cleanup() {
  common_scripts\utility::flag_wait("rappel_finished");

  if(isDefined(level.copymachine))
    level.copymachine delete();
}

combat_rappel_enemies_pt2() {
  level endon("rappel_finished");
  maps\_utility::array_spawn_function_targetname("p2_first_wave_downstairs", ::enemy_spawner_setup);
  maps\_utility::array_spawn_function_targetname("p2_first_wave_downstairs", ::enemy_lower_level);
  maps\_utility::array_spawn_function_targetname("p2_first_wave_upstairs", ::enemy_spawner_setup);
  maps\_utility::array_spawn_function_targetname("p2_first_wave_upstairs", ::pt2_upper_enemy_anim);
  maps\_utility::array_spawn_function_targetname("p2_second_wave_downstairs", ::enemy_spawner_setup);
  maps\_utility::array_spawn_function_targetname("p2_second_wave_upstairs", ::enemy_spawner_setup);
  level.rappel_combat_two_volume_upstairs = getent("rappel_combat_two_volume_upstairs", "targetname");
  level.rappel_combat_two_volume_downstairs = getent("rappel_combat_two_volume_downstairs", "targetname");
  level.all_rappel_pt3_enemies = [];
  level.all_rappel_pt3_downstairs_enemies = [];
  var_0 = maps\_utility::array_spawn_targetname("p2_first_wave_downstairs", 1);
  level.all_rappel_pt3_downstairs_enemies = var_0;
  var_1 = maps\_utility::array_spawn_targetname("p2_first_wave_upstairs", 1);
  level.all_rappel_pt3_enemies = common_scripts\utility::array_combine(var_1, var_0);
  thread monitor_deaths_on_dynamic_array(level.all_rappel_pt3_enemies, "move_into_building", 6, 20);
  maps\_utility::waittill_dead_or_dying(level.all_rappel_pt3_enemies, 3);
  var_2 = maps\_utility::array_spawn_targetname("p2_second_wave_downstairs", 1);
  level.all_rappel_pt3_enemies = common_scripts\utility::array_combine(level.all_rappel_pt3_enemies, var_2);
  level.all_rappel_pt3_downstairs_enemies = common_scripts\utility::array_combine(level.all_rappel_pt3_downstairs_enemies, var_2);
  var_3 = maps\_utility::array_spawn_targetname("p2_second_wave_upstairs", 1);
  level.all_rappel_pt3_enemies = common_scripts\utility::array_combine(level.all_rappel_pt3_enemies, var_3);
  common_scripts\utility::flag_wait("move_into_building");
  wait 1.0;
  thread player_kills_all_pt3_enemies();
  thread kill_pt3_enemies_on_player_jump();
  common_scripts\utility::flag_set("floor_clear");
}

enemy_spawner_setup() {
  self endon("death");
  self.baseaccuracy = 0.2;
  maps\_utility::disable_long_death();
}

pt2_upper_enemy_anim() {
  if(isDefined(self.script_animation)) {
    self.allowdeath = 1;
    var_0 = getent("rappel_combat_two_volume_upstairs", "targetname");
    maps\_anim::anim_generic(self, self.script_animation);
    self setgoalvolumeauto(var_0);
  }
}

enemy_lower_level() {
  self endon("death");
  self endon("c_rappel_final_jump_starting");
  self.ignoreall = 1;
  self waittill("goal");
  self.ignoreall = 0;
  self setgoalvolumeauto(level.rappel_combat_two_volume_downstairs);
  self waittill("goal");
}

kill_pt3_enemies_on_player_jump() {
  common_scripts\utility::flag_wait("rappel_finished");
  wait 4.0;
  level.all_rappel_pt3_enemies = maps\_utility::array_removedead(level.all_rappel_pt3_enemies);

  if(level.all_rappel_pt3_enemies.size > 0) {
    foreach(var_1 in level.all_rappel_pt3_enemies) {
      if(isalive(var_1)) {
        if(isDefined(var_1.magic_bullet_shield) && var_1.magic_bullet_shield)
          var_1 maps\_utility::stop_magic_bullet_shield();

        var_1 kill();
      }
    }
  }
}

player_kills_all_pt3_enemies() {
  level endon("c_rappel_final_jump_starting");
  level.all_rappel_pt3_enemies = maps\_utility::array_removedead(level.all_rappel_pt3_enemies);
  maps\_utility::waittill_dead_or_dying(level.all_rappel_pt3_enemies);
  common_scripts\utility::flag_set("all_rappel_two_enemies_in_front_dead");
  level.flag_to_check = undefined;
}

monitor_deaths_on_dynamic_array(var_0, var_1, var_2, var_3) {
  self endon("timeout");

  if(!isDefined(var_3))
    var_3 = 10;

  var_4 = 0;
  thread monitor_timeout(var_3, var_1);

  for(;;) {
    maps\_utility::waittill_dead_or_dying(var_0, 1);
    var_4++;
    var_0 = maps\_utility::array_removedead(var_0);

    if(var_4 >= var_2) {
      break;
    }
  }

  common_scripts\utility::flag_set(var_1);
}

monitor_timeout(var_0, var_1) {
  wait(var_0);
  self notify("timeout");

  if(!common_scripts\utility::flag(var_1))
    common_scripts\utility::flag_set(var_1);
}

break_enemy_windows() {
  wait 10.5;
  thread break_window("p1_upper");
  wait 0.5;
  thread break_window("p1_lower");
}

break_window(var_0) {
  for(var_1 = 1; var_1 <= 8; var_1++) {
    var_2 = common_scripts\utility::getstruct(var_0 + "_glass_damage_struct_" + var_1, "script_noteworthy");

    if(isDefined(var_2))
      glassradiusdamage(var_2.origin, 96, 50, 50);
  }
}

send_to_death_volume() {
  self endon("death");
  var_0 = undefined;

  if(isalive(self) && self.script_noteworthy == "p1_upper")
    var_0 = getent("p1_upper_volume", "targetname");
  else if(isalive(self) && self.script_noteworthy == "copymachine_ai" || isalive(self) && self.script_noteworthy == "p1_junction")
    var_0 = getent("p1_junction_volume", "targetname");
  else if(isalive(self) && self.script_noteworthy == "p1_lower")
    var_0 = getent("p1_lower_volume", "targetname");
  else if(isalive(self) && self.script_noteworthy == "p1_ahead") {
    var_1 = getEntArray("p1_ahead_volume", "targetname");
    var_1 = sortbydistance(var_1, self.origin);
    var_0 = var_1[0];
  }

  if(isalive(self)) {
    self setgoalvolumeauto(var_0);
    common_scripts\utility::waittill_notify_or_timeout("goal", 5);
    self notify("stop_death_func");
  }

  if(isalive(self)) {
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
      maps\_utility::stop_magic_bullet_shield();

    self kill();
  }
}