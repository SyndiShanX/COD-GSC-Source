/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_intro.gsc
*****************************************************/

intro_start() {
  maps\odin_util::move_player_to_start_point("start_odin_intro");
  thread maps\odin_escape::manage_earth("hide");

  if(isDefined(level.prologue) && level.prologue == 1)
    common_scripts\utility::flag_set("do_transition_to_odin");

  level.space_breathing_enabled = 1;
}

section_precache() {
  precachestring(&"ODIN_INTROSCREEN_LINE_0");
  precachestring(&"ODIN_INTROSCREEN_LINE_1");
  precachestring(&"ODIN_INTROSCREEN_LINE_2");
  precachestring(&"ODIN_INTROSCREEN_LINE_3");
  precachestring(&"ODIN_INTRO_BUMPER_HINT2");
  precachestring(&"ODIN_INTRO_BUMPER_HINT2_PC");
  precachestring(&"ODIN_INTRO_BUMPER_HINT2_CROUCH");
  precachestring(&"ODIN_INTRO_BUMPER_HINT");
  precachestring(&"ODIN_INTRO_BUMPER_HINT_PC");
  precachestring(&"ODIN_STRAY_INTRO_WARNING");
  precachestring(&"ODIN_FAIL_STRAY_INTRO");
  precachemodel("viewmodel_space_tar21");
}

section_flag_init() {
  common_scripts\utility::flag_init("start_transition_to_youngblood");
  common_scripts\utility::flag_init("do_transition_to_odin");
  common_scripts\utility::flag_init("intro_show_introtext");
  common_scripts\utility::flag_init("clear_to_tweak_player");
  common_scripts\utility::flag_init("player_is_leaving");
  common_scripts\utility::flag_init("shuttle_starts_moving");
  common_scripts\utility::flag_init("DOF_Rack_Complete");
  common_scripts\utility::flag_init("kyra_is_in_station");
  common_scripts\utility::flag_init("clear_to_tweak_player_forced");
  common_scripts\utility::flag_init("open_exterior_hatch");
  common_scripts\utility::flag_init("wall_push_tweak_player");
  common_scripts\utility::flag_init("push_player_hard_wall");
  common_scripts\utility::flag_init("get_intro_moving");
  common_scripts\utility::flag_init("remove_bumper_hint");
  common_scripts\utility::flag_init("ally_at_exterior_hatch");
  common_scripts\utility::flag_init("remove_temp_blocker");
  common_scripts\utility::flag_init("exterior_hatch_opening");
  common_scripts\utility::flag_init("player_at_airlock");
  common_scripts\utility::flag_init("invasion_clear");
  common_scripts\utility::flag_init("airlock_begin_pressurize");
  common_scripts\utility::flag_init("airlock_pressurized_and_open");
  common_scripts\utility::flag_init("mission_failed");
  common_scripts\utility::flag_init("pause_bumper_hints");
  common_scripts\utility::flag_init("intro_fade_done");
  common_scripts\utility::flag_init("begin_dof_rack_fade");
  common_scripts\utility::flag_init("player_can_rise");
  common_scripts\utility::flag_init("player_can_fall");
  common_scripts\utility::flag_init("intro_vin_lines_done");
  common_scripts\utility::flag_init("start_player_intro_anim");
  common_scripts\utility::flag_init("ally_should_nag");
  common_scripts\utility::flag_init("astronaut_needs_helps");
  common_scripts\utility::flag_init("clear_helper_mark");
  common_scripts\utility::flag_init("nags_should_overlap");
  common_scripts\utility::flag_init("notetracked_lines_are_done");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("intro_bumper_hint", &"ODIN_INTRO_BUMPER_HINT", ::hint_bumpers_intro);
  maps\_utility::add_hint_string("intro_bumper_hint2", &"ODIN_INTRO_BUMPER_HINT2", ::hint_bumpers_intro2);
  maps\_utility::add_hint_string("intro_bumper_hint2_PC", &"ODIN_INTRO_BUMPER_HINT2_PC", ::hint_bumpers_intro2);
  maps\_utility::add_hint_string("intro_bumper_hint2_CROUCH", &"ODIN_INTRO_BUMPER_HINT2_CROUCH", ::hint_bumpers_intro2);
  maps\_utility::add_hint_string("intro_bumper_hint_pc", &"ODIN_INTRO_BUMPER_HINT_PC", ::hint_bumpers_intro);
  maps\_utility::add_hint_string("intro_stray_fail", &"ODIN_FAIL_STRAY_INTRO");
  maps\_utility::add_hint_string("intro_stray_warn", &"ODIN_STRAY_INTRO_WARNING", ::hint_stray_warn);
}

hint_bumpers_intro() {
  if(common_scripts\utility::flag("pause_bumper_hints"))
    return 1;
  else
    return 0;
}

hint_bumpers_intro2() {
  if(common_scripts\utility::flag("pause_bumper_hints"))
    return 1;
  else
    return 0;
}

hint_stray_warn() {
  if(common_scripts\utility::flag("intro_player_in_bounds") || !common_scripts\utility::flag("intro_player_death_area"))
    return 1;
  else
    return 0;
}

intro_main() {
  if(isDefined(level.prologue) && level.prologue == 1)
    thread maps\_utility::autosave_now();

  common_scripts\utility::flag_clear("enable_player_thruster_audio");
  thread maps\odin_anim::empty_suit_animation();
  level.player freezecontrols(1);
  level.space_breathing_enabled = 1;

  if(isDefined(level.prologue) && level.prologue == 1) {
    common_scripts\utility::flag_wait("do_transition_to_odin");
    maps\odin_util::move_player_to_start_point("start_odin_intro");
  }

  thread intro_setup();
  thread shuttle_docking();
  thread player_near_station_checker();
  thread open_exterior_hatch();
  thread airlock_interior_hatch();
  thread maps\odin_util::initial_satellite_placement();
  thread maps\odin_escape::manage_earth("hide");
  thread maps\odin_fx::satellite_rcs_thrusters();
  odin_intro_screen();
  thread intro_dialogue();
  level.ally intro_vignette();
  level.ally station_entrance_to_infiltration();
  thread intro_cleanup(0);
}

intro_setup() {
  thread dof_rack();
  thread player_intro_anim();
  thread maps\odin_fx::fx_space_glass();
  level.player setviewmodel("viewhands_us_space");
  level.player disableweapons();
  setsaveddvar("ammoCounterHide", "1");
  maps\odin_util::actor_teleport(level.ally, "odin_intro_ally_tp");
  level.ally.animname = "odin_ally";
  level.ally.ignoreall = 1;
  level.ally maps\_utility::gun_remove();

  if(!isDefined(level.prologue))
    setsaveddvar("cg_fov", 70);

  level thread intro_ally_idle();
}

intro_ally_idle() {
  var_0 = getent("scriptednode_player", "script_noteworthy");
  var_0 thread maps\_anim::anim_loop_solo(level.ally, "odin_intro_kyra_idle", "stop_loop");
  level waittill("intro_stop_ally_idle");
  var_0 notify("stop_loop");
}

intro_dialogue() {
  level endon("player_at_airlock");
  common_scripts\utility::flag_wait("intro_vin_lines_done");
  nag_check_dialogue("odin_cub_payloadthisisodin");
  nag_check_dialogue("odin_kyr_odinmainwereheading");

  if(!common_scripts\utility::flag("player_at_entrance"))
    nag_check_dialogue("odin_cub_rogerwerepreppingairlock");

  if(!common_scripts\utility::flag("player_at_entrance"))
    nag_check_dialogue("odin_cub_payloadtenmetersbegin");

  if(!common_scripts\utility::flag("player_at_entrance"))
    wait 4;

  if(!common_scripts\utility::flag("player_at_entrance"))
    nag_check_dialogue("odin_cub_fivemeterspayload");

  if(!common_scripts\utility::flag("player_at_entrance"))
    wait 3;

  if(!common_scripts\utility::flag("player_at_entrance"))
    nag_check_dialogue("odin_cub_twometerszeroyour");

  common_scripts\utility::flag_wait("player_at_entrance");
  maps\_utility::smart_radio_dialogue("odin_cub_budkyraairlockc");

  if(!common_scripts\utility::flag("airlock_begin_pressurize") && !common_scripts\utility::flag("kyra_is_in_station"))
    nag_check_dialogue("odin_pyl_capturing");

  if(!common_scripts\utility::flag("airlock_begin_pressurize") && !common_scripts\utility::flag("kyra_is_in_station"))
    nag_check_dialogue("odin_pyl_talkbackisbarberpole");

  if(!common_scripts\utility::flag("airlock_begin_pressurize") && !common_scripts\utility::flag("kyra_is_in_station"))
    nag_check_dialogue("odin_cub_copypayload");

  common_scripts\utility::flag_wait("notetracked_lines_are_done");
  nag_check_dialogue("odin_cub_payloadwehavehard");
  nag_check_dialogue("odin_cub_andyouareparked");
}

nag_check_dialogue(var_0) {
  common_scripts\utility::flag_set("nags_should_overlap");
  maps\_utility::smart_radio_dialogue(var_0);
  common_scripts\utility::flag_clear("nags_should_overlap");
}

player_near_station_checker() {
  level endon("start_transition_to_youngblood");
  var_0 = getent("ally_airlock_touch", "targetname");
  thread player_too_far_death();
  wait 1;

  for(;;) {
    common_scripts\utility::flag_waitopen("intro_player_in_bounds");

    if(common_scripts\utility::flag("player_approaching_infiltration") || level.player istouching(var_0))
      return;
    else {
      common_scripts\utility::flag_set("astronaut_needs_helps");
      level.player thread maps\_utility::display_hint("intro_stray_warn");
      common_scripts\utility::flag_set("astronaut_needs_help");
    }

    common_scripts\utility::flag_wait("intro_player_in_bounds");
  }
}

player_too_far_death() {
  level endon("start_transition_to_youngblood");
  wait 1;

  for(;;) {
    common_scripts\utility::flag_waitopen("intro_player_death_area");

    if(common_scripts\utility::flag("player_approaching_infiltration"))
      return;
    else {
      common_scripts\utility::flag_set("mission_failed");
      level notify("new_quote_string");
      setdvar("ui_deadquote", "@ODIN_FAIL_STRAY_INTRO");
      maps\_utility::missionfailedwrapper();
    }

    common_scripts\utility::flag_wait("intro_player_death_area");
  }
}

intro_vignette() {
  common_scripts\utility::flag_set("no_push_zone");
  var_0 = getent("scriptednode_player", "script_noteworthy");
  thread ally_intro_anims_and_logic(var_0);
  thread manage_exterior_hatch_lights();
  common_scripts\utility::flag_set("begin_dof_rack_fade");
  common_scripts\utility::flag_wait("DOF_Rack_Complete");
  wait_for_player_movement_or_time();
  common_scripts\utility::flag_set("objective_return_to_station");
  common_scripts\utility::flag_wait("ally_at_exterior_hatch");
  level notify("stop_nag");
  var_0 notify("stop_loop");
  self stopanimscripted();
  waittillframeend;
}

intro_vin_ln_1(var_0) {
  maps\_utility::smart_radio_dialogue("odin_kyr_budyoushouldbe");
}

intro_vin_ln_2(var_0) {
  maps\_utility::smart_radio_dialogue("odin_cub_iseeittoo");
  maps\_utility::music_play("mus_odin_intro");
}

intro_vin_ln_3(var_0) {
  maps\_utility::smart_radio_dialogue("odin_kyr_okbudcomeon");
  common_scripts\utility::flag_set("intro_vin_lines_done");
}

ally_intro_anims_and_logic(var_0) {
  wait 2.5;
  level notify("intro_stop_ally_idle");
  common_scripts\utility::flag_set("start_player_intro_anim");
  var_0 maps\_anim::anim_first_frame_solo(self, "odin_intro_kyra_satellite_idle");
  var_0 maps\_anim::anim_single_solo(self, "odin_intro_kyra_satellite_idle");
  level.ally rubber_band_kyra("intro_exterior_scene", 320, var_0);
  common_scripts\utility::flag_clear("no_push_zone");
  common_scripts\utility::flag_set("ally_at_exterior_hatch");
}

#using_animtree("generic_human");

rubber_band_kyra(var_0, var_1, var_2) {
  level endon("airlock_pressurized_and_open");
  var_2 thread maps\_anim::anim_single_solo(self, var_0);
  var_3 = 1.5;
  var_4 = 1;
  var_5 = 0;
  level.random_nag_line = 99;
  thread idle_nag_counter();
  var_6 = getent("intro_hatch_door_blocker_org", "targetname");

  for(;;) {
    var_7 = self getanimtime(%odin_intro_kyra);
    var_8 = level.player.origin[0] - level.ally.origin[0];

    if(var_4 == 1) {
      var_4 = 0;

      while(var_3 <= 2.5) {
        var_7 = self getanimtime(%odin_intro_kyra);
        var_3 = var_3 + 0.02;
        self setanimtime(%odin_intro_kyra, var_7);
        maps\_anim::anim_set_rate_single(self, var_0, var_3);
        wait 0.05;
      }
    }

    var_9 = distancesquared(level.player.origin, var_6.origin);
    var_10 = distancesquared(level.ally.origin, var_6.origin);

    if(var_9 >= var_10) {
      var_3 = maps\odin_util::factor_value_min_max(0, 3, maps\odin_util::normalize_value(0, var_1, var_8));
      var_3 = 3 - var_3;
    } else {
      var_3 = var_3 + 0.05;

      if(var_3 >= 3)
        var_3 = 3;
    }

    if(var_7 >= 0.7)
      common_scripts\utility::flag_set("open_exterior_hatch");

    if(var_7 >= 1) {
      return;
    }
    if(var_3 <= 0.25 && var_5 == 0) {
      var_11 = var_7;
      common_scripts\utility::flag_set("ally_should_nag");
      level.ally setanim(%odin_intro_kyra_wait_idle, 1, 0.5, 1);
      var_5 = 1;
    } else if(var_3 > 0) {
      level.ally notify("stop_idle_loop");
      self setanim(%odin_intro_kyra, 1, 0.5);
      level.ally setanim(%odin_intro_kyra_wait_idle, 0, 0.5, 1);
      maps\_anim::anim_set_rate_single(self, var_0, var_3);
      var_5 = 0;
    }

    if(var_3 >= 0.1) {
      common_scripts\utility::flag_clear("ally_should_nag");
      level notify("ally_is_moving");
    }

    wait 0.05;
  }
}

player_intro_anim() {
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_1 = getent("scriptednode_player", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "intro_exterior_scene");
  var_2 = 0;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_2, var_2, var_2, 1);
  common_scripts\utility::flag_wait("intro_fade_done");
  var_2 = 30;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_2, var_2, var_2, 1);
  common_scripts\utility::flag_wait("start_player_intro_anim");
  wait 6.5;
  thread maps\_utility::autosave_by_name("Odin_intro_start");
  level.player thread maps\odin_audio::sfx_player_intro_movement();
  var_1 maps\_anim::anim_single_solo(var_0, "intro_exterior_scene");
  level.player unlink();
  common_scripts\utility::flag_set("prologue_ready_for_thrusters");
  var_0 delete();
  common_scripts\utility::flag_set("enable_player_thruster_audio");
  common_scripts\utility::flag_set("intro_show_introtext");
  thread prompt_player_controls();
  common_scripts\utility::flag_set("clear_to_tweak_player");
  thread tweak_off_axis_player();
}

wait_for_player_movement_or_time() {
  level endon("airlock_pressurized_and_open");
  var_0 = level.player getorigin();

  for(;;) {
    var_1 = level.player getorigin();

    for(var_2 = 0; var_2 < 3; var_2++) {
      var_3 = var_0[var_2];
      var_4 = var_1[var_2];

      if(var_3 < 0)
        var_3 = var_3 * -1;

      if(var_4 < 0)
        var_4 = var_4 * -1;

      if(var_3 - var_4 >= 1 || var_4 - var_3 <= -1) {
        common_scripts\utility::flag_set("player_is_leaving");
        return;
      }
    }

    wait 0.05;
  }
}

shuttle_docking() {
  var_0 = getent("shuttle_stop_movement_vol", "targetname");
  var_1 = maps\_utility::spawn_anim_model("shuttle");
  level.intro_ent_del[level.intro_ent_del.size] = var_1;
  var_1 thread shuttle_fx();
  var_2 = getent("scriptednode_player", "script_noteworthy");
  var_3 = [];
  var_3["shuttle"] = var_1;
  var_2 maps\_anim::anim_first_frame_solo(var_1, "odin_intro_shuttle");
  var_0 linkto(var_1);
  maps\_anim::anim_set_rate(var_3, "odin_intro_shuttle", 5);
  wait 7;
  thread maps\odin_audio::sfx_shuttle_passby(var_1);
  common_scripts\utility::flag_set("shuttle_starts_moving");
  var_2 maps\_anim::anim_single_solo(var_1, "odin_intro_shuttle");
}

shuttle_fx() {
  level.shuttle_thrust_brake = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = level.shuttle_thrust_brake;
  level.shuttle_thrust_brake.origin = self.origin + (720, 0, 30);
  level.shuttle_thrust_brake.angles = self.angles;
  level.shuttle_thrust_brake linkto(self);
  level.shuttle_thrust_fl = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = level.shuttle_thrust_fl;
  level.shuttle_thrust_fl.origin = self.origin + (620, 95, 5);
  level.shuttle_thrust_fl.angles = self.angles + (0, 90, 0);
  level.shuttle_thrust_fl linkto(self);
  level.shuttle_thrust_fr = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = level.shuttle_thrust_fr;
  level.shuttle_thrust_fr.origin = self.origin + (620, -95, 5);
  level.shuttle_thrust_fr.angles = self.angles + (0, -90, 0);
  level.shuttle_thrust_fr linkto(self);
  level.shuttle_thrust_rl = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = level.shuttle_thrust_rl;
  level.shuttle_thrust_rl.origin = self.origin + (-57, 80, 10);
  level.shuttle_thrust_rl.angles = self.angles + (0, 90, 0);
  level.shuttle_thrust_rl linkto(self);
  level.shuttle_thrust_rr = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = level.shuttle_thrust_rr;
  level.shuttle_thrust_rr.origin = self.origin + (-57, -80, 10);
  level.shuttle_thrust_rr.angles = self.angles + (0, -90, 0);
  level.shuttle_thrust_rr linkto(self);
  common_scripts\utility::flag_wait("shuttle_starts_moving");
  wait 4.7;
  maps\_utility::delaythread(1, ::shuttle_thrust, "CW", 3);
  maps\_utility::delaythread(1.5, ::shuttle_thrust, "brake", 30);
  maps\_utility::delaythread(2, ::shuttle_thrust, "CW", 2);
  maps\_utility::delaythread(3.5, ::shuttle_thrust, "brake", 30);
  maps\_utility::delaythread(4.5, ::shuttle_thrust, "NOSECCW", 10);
  maps\_utility::delaythread(5.0, ::shuttle_thrust, "brake", 20);
  maps\_utility::delaythread(5.5, ::shuttle_thrust, "CW", 13);
  maps\_utility::delaythread(6.5, ::shuttle_thrust, "CW", 3);
  maps\_utility::delaythread(8.0, ::shuttle_thrust, "brake", 20);
  maps\_utility::delaythread(8.5, ::shuttle_thrust, "NOSECCW", 10);
  maps\_utility::delaythread(12.5, ::shuttle_thrust, "CW", 6);
  maps\_utility::delaythread(13.0, ::shuttle_thrust, "NOSECCW", 13);
  maps\_utility::delaythread(13.5, ::shuttle_thrust, "brake", 13);
  maps\_utility::delaythread(14.5, ::shuttle_thrust, "CW", 3);
  maps\_utility::delaythread(17.5, ::shuttle_thrust, "NOSECCW", 13);
  maps\_utility::delaythread(20.0, ::shuttle_thrust, "NOSEUP", 3);
  maps\_utility::delaythread(21.0, ::shuttle_thrust, "NOSECCW", 16);
  maps\_utility::delaythread(21.5, ::shuttle_thrust, "brake", 15);
  maps\_utility::delaythread(22.5, ::shuttle_thrust, "CW", 20);
  maps\_utility::delaythread(22.5, ::shuttle_thrust, "NOSECW", 13);
  maps\_utility::delaythread(23.5, ::shuttle_thrust, "CCW", 10);
  maps\_utility::delaythread(24.5, ::shuttle_thrust, "brake", 13);
  maps\_utility::delaythread(25.0, ::shuttle_thrust, "NOSECW", 6);
  maps\_utility::delaythread(25.5, ::shuttle_thrust, "CCW", 10);
  maps\_utility::delaythread(27.5, ::shuttle_thrust, "brake", 16);
  maps\_utility::delaythread(29.5, ::shuttle_thrust, "CCW", 30);
  maps\_utility::delaythread(30.0, ::shuttle_thrust, "NOSEUP", 23);
  maps\_utility::delaythread(30.5, ::shuttle_thrust, "brake", 13);
  maps\_utility::delaythread(31.0, ::shuttle_thrust, "CCW", 3);
  maps\_utility::delaythread(31.5, ::shuttle_thrust, "brake", 1);
  maps\_utility::delaythread(32.0, ::shuttle_thrust, "NOSECCW", 10);
  maps\_utility::delaythread(33.0, ::shuttle_thrust, "NOSEDOWN", 13);
  maps\_utility::delaythread(33.5, ::shuttle_thrust, "NOSECCW", 3);
  maps\_utility::delaythread(34.5, ::shuttle_thrust, "UP", 23);
  maps\_utility::delaythread(35.5, ::shuttle_thrust, "NOSECCW", 3);
  maps\_utility::delaythread(36.5, ::shuttle_thrust, "UP", 13);
  maps\_utility::delaythread(38.5, ::shuttle_thrust, "DOWN", 13);
  maps\_utility::delaythread(39.0, ::shuttle_thrust, "NOSECCW", 13);
  maps\_utility::delaythread(39.5, ::shuttle_thrust, "DOWN", 25);
  maps\_utility::delaythread(40.0, ::shuttle_thrust, "DOWN", 13);
  maps\_utility::delaythread(40.3, ::shuttle_thrust, "NOSECCW", 8);
  maps\_utility::delaythread(40.5, ::shuttle_thrust, "DOWN", 5);
  maps\_utility::delaythread(40.9, ::shuttle_thrust, "DOWN", 2);
  maps\_utility::delaythread(41.3, ::shuttle_thrust, "DOWN", 2);
  maps\_utility::delaythread(42.0, maps\odin_fx::fx_shuttle_dock);
  wait 50;
  level.shuttle_thrust_brake delete();
  level.shuttle_thrust_fl delete();
  level.shuttle_thrust_fr delete();
  level.shuttle_thrust_rl delete();
  level.shuttle_thrust_rr delete();
}

shuttle_thrust(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(var_0 == "brake") {
    for(var_6 = 0; var_6 < var_1; var_6++) {
      playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], level.shuttle_thrust_brake, "tag_origin");
      wait 0.05;
    }

    return;
  }

  if(var_0 == "NOSECW") {
    for(var_6 = 0; var_6 < var_1; var_6++) {
      playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], level.shuttle_thrust_fl, "tag_origin");
      playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], level.shuttle_thrust_rr, "tag_origin");
    }

    return;
  }

  if(var_0 == "NOSECCW") {
    for(var_6 = 0; var_6 < var_1; var_6++) {
      playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], level.shuttle_thrust_fr, "tag_origin");
      playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], level.shuttle_thrust_rl, "tag_origin");
      wait 0.05;
    }

    return;
  }

  if(var_0 == "CW") {
    var_2 = 90;
    var_3 = -90;
    var_4 = 90;
    var_5 = -90;
  }

  if(var_0 == "CCW") {
    var_2 = -90;
    var_3 = 90;
    var_4 = -90;
    var_5 = 90;
  }

  if(var_0 == "UP") {
    var_2 = 90;
    var_3 = 90;
    var_4 = 90;
    var_5 = 90;
  }

  if(var_0 == "DOWN") {
    var_2 = -90;
    var_3 = -90;
    var_4 = -90;
    var_5 = -90;
  }

  if(var_0 == "NOSEUP") {
    var_2 = -90;
    var_3 = -90;
    var_4 = 90;
    var_5 = 90;
  }

  if(var_0 == "NOSEDOWN") {
    var_2 = 90;
    var_3 = 90;
    var_4 = -90;
    var_5 = -90;
  }

  var_7 = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = var_7;
  var_7.origin = level.shuttle_thrust_rl.origin;
  var_7.angles = level.shuttle_thrust_rl.angles;
  var_8 = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = var_8;
  var_8.origin = level.shuttle_thrust_rr.origin;
  var_8.angles = level.shuttle_thrust_rr.angles;
  var_9 = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = var_9;
  var_9.origin = level.shuttle_thrust_fl.origin;
  var_9.angles = level.shuttle_thrust_fl.angles;
  var_10 = common_scripts\utility::spawn_tag_origin();
  level.intro_ent_del[level.intro_ent_del.size] = var_10;
  var_10.origin = level.shuttle_thrust_fr.origin;
  var_10.angles = level.shuttle_thrust_fr.angles;
  var_7 linkto(level.shuttle_thrust_rl, "tag_origin", (0, 0, 0), (var_2, 0, 0));
  var_8 linkto(level.shuttle_thrust_rr, "tag_origin", (0, 0, 0), (var_3, 0, 0));
  var_9 linkto(level.shuttle_thrust_fl, "tag_origin", (0, 0, 0), (var_4, 0, 0));
  var_10 linkto(level.shuttle_thrust_fr, "tag_origin", (0, 0, 0), (var_5, 0, 0));

  for(var_6 = 0; var_6 < var_1; var_6++) {
    playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], var_7, "tag_origin");
    playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], var_8, "tag_origin");
    playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], var_9, "tag_origin");
    playFXOnTag(level._effect["vfx_shuttle_manuvr_thrust"], var_10, "tag_origin");
    wait 0.05;
  }

  wait 1;
  var_7 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
}

dof_rack() {
  if(maps\_utility::is_gen4())
    maps\_art::dof_enable_script(20, 112, 6, 1999, 200000, 0, 0);
  else
    maps\_art::dof_enable_script(12, 92, 4, 1999, 200000, 0, 0);

  common_scripts\utility::flag_wait("begin_dof_rack_fade");
  wait 5;
  maps\_art::dof_enable_script(0, 0, 0, 0, 0, 0, 5);
  common_scripts\utility::flag_set("DOF_Rack_Complete");
}

prompt_player_controls() {
  level endon("airlock_pressurized_and_open");
  thread track_odin_up();
  var_0 = gettime();
  var_1 = gettime() - 4000;

  while(!common_scripts\utility::flag("player_can_rise") && var_1 < var_0) {
    var_1 = gettime() - 4000;

    if(!common_scripts\utility::flag("intro_player_in_bounds") || !common_scripts\utility::flag("intro_player_death_area")) {
      common_scripts\utility::flag_set("pause_bumper_hints");
      common_scripts\utility::flag_wait("intro_player_in_bounds");
      var_0 = gettime();
      var_1 = gettime() - 4000;
      common_scripts\utility::flag_clear("pause_bumper_hints");
    } else if(level.player usinggamepad())
      thread maps\_utility::display_hint("intro_bumper_hint");
    else
      thread maps\_utility::display_hint("intro_bumper_hint_pc");

    wait 0.01;
  }

  common_scripts\utility::flag_set("pause_bumper_hints");
  wait 1;
  thread second_bumper_hint();
}

track_odin_up() {
  common_scripts\utility::flag_clear("player_can_rise");
  level.player notifyonplayercommand("pressed_up", "+frag");
  level.player notifyonplayercommand("pressed_up", "+gostand");
  level.player waittill("pressed_up");
  common_scripts\utility::flag_set("player_can_rise");
}

second_bumper_hint() {
  level endon("airlock_pressurized_and_open");
  wait 1;
  var_0 = gettime();
  var_1 = gettime() - 4000;
  thread track_odin_down();
  common_scripts\utility::flag_clear("pause_bumper_hints");

  while(!common_scripts\utility::flag("player_can_fall") && var_1 < var_0) {
    var_1 = gettime() - 4000;

    if(!common_scripts\utility::flag("intro_player_in_bounds") || !common_scripts\utility::flag("intro_player_death_area")) {
      common_scripts\utility::flag_set("pause_bumper_hints");
      common_scripts\utility::flag_wait("intro_player_in_bounds");
      var_0 = gettime();
      var_1 = gettime() - 4000;
      common_scripts\utility::flag_clear("pause_bumper_hints");
    } else if(level.player usinggamepad())
      thread maps\_utility::display_hint("intro_bumper_hint2");
    else if(maps\_utility::is_command_bound("+crouch") || !maps\_utility::is_command_bound("+stance"))
      thread maps\_utility::display_hint("intro_bumper_hint2_CROUCH");
    else
      thread maps\_utility::display_hint("intro_bumper_hint2_PC");

    wait 0.05;
  }

  common_scripts\utility::flag_set("pause_bumper_hints");
}

track_odin_down() {
  common_scripts\utility::flag_clear("player_can_fall");
  level.player notifyonplayercommand("pressed_down", "+smoke");
  level.player notifyonplayercommand("pressed_down", "+toggleprone");
  level.player notifyonplayercommand("pressed_down", "+stance");
  level.player waittill("pressed_down");
  common_scripts\utility::flag_set("player_can_fall");
}

ally_nagging(var_0) {
  level endon("airlock_pressurized_and_open");
  level endon("ally_is_moving");
  var_1 = [];
  var_1[0] = "odin_kyr_budfollowmewe";
  var_1[1] = "odin_kyr_altcomeonbudthisway";
  var_2 = 0;
  wait(var_0);

  if(level.random_nag_line == var_2)
    var_2 = 1;

  if(common_scripts\utility::flag("nags_should_overlap") && common_scripts\utility::flag("ally_should_nag"))
    maps\_utility::smart_radio_dialogue_overlap(var_1[var_2]);
  else if(common_scripts\utility::flag("ally_should_nag"))
    maps\_utility::smart_radio_dialogue(var_1[var_2]);

  level.random_nag_line = var_2;
  common_scripts\utility::flag_set("astronaut_needs_help");
  common_scripts\utility::flag_set("astronaut_needs_helps");
}

idle_nag_counter() {
  level endon("airlock_pressurized_and_open");

  for(;;) {
    common_scripts\utility::flag_wait("ally_should_nag");
    var_0 = randomfloatrange(8, 13);
    ally_nagging(var_0);
    wait 0.01;
  }
}

open_exterior_hatch() {
  var_0 = getent("scriptednode_pdoor", "targetname");
  var_1 = getent("intro_airlock_door", "targetname");
  var_1.animname = "space_round_hatch";
  var_1 maps\_utility::assign_animtree("space_round_hatch");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_intro_exterior_door_open");
  var_2 = getent("intro_hatch_door_blocker", "targetname");
  var_3 = getent("intro_hatch_door_blocker_org", "targetname");
  var_3 linkto(var_1, "door_DM");
  var_2 linkto(var_3);
  common_scripts\utility::flag_wait("open_exterior_hatch");
  thread maps\odin_ally::odin_invasion_scene();
  var_0 maps\_anim::anim_single_solo(var_1, "odin_intro_exterior_door_open");

  for(;;) {
    if(level.ally istouching(getent("ally_airlock_touch", "targetname")) && level.player istouching(getent("ally_airlock_touch", "targetname"))) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("clear_helper_mark");
  thread maps\odin_audio::sfx_close_first_door(var_0);
  var_0 maps\_anim::anim_single_solo(var_1, "odin_infiltrate_exterior_door_close");
  common_scripts\utility::flag_set("airlock_begin_pressurize");
  thread maps\odin_fx::god_rays_airlock();
  thread maps\odin_ally::airlock_compression_door();
  wait 3;
  maps\_utility::stop_exploder("intro_ambient_airlock_dust");
  common_scripts\utility::exploder("intro_airlock_compression");
  thread maps\odin_fx::airlock_glass_fog();
  wait 4.5;
  maps\_utility::stop_exploder("intro_airlock_compression");
  common_scripts\utility::exploder("intro_airlock_complete");
}

airlock_interior_hatch() {
  var_0 = getent("scriptednode_squareDoor", "targetname");
  var_1 = maps\_utility::spawn_anim_model("space_square_hatch");
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = (3884, 47446, 48549);
  var_1 retargetscriptmodellighting(var_2);
  level.intro_ent_del[level.intro_ent_del.size] = var_1;
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_infiltrate_door_open");
  var_3 = getent("intro_airlock_hatch_blocker", "targetname");
  var_4 = getent("intro_airlock_hatch_blocker_org", "targetname");
  var_4 linkto(var_1, "tag_origin");
  var_3 linkto(var_4);
  common_scripts\utility::flag_wait("open_airlock_door");
  thread maps\odin_audio::sfx_airlock_door();
  common_scripts\utility::flag_set("airlock_pressurized_and_open");
  var_0 maps\_anim::anim_single_solo(var_1, "odin_infiltrate_door_open");
}

manage_exterior_hatch_lights() {
  level endon("start_transition_to_youngblood");
  var_0 = getEntArray("intro_exterior_hatch_lights_on", "targetname");
  var_1 = getEntArray("intro_exterior_hatch_lights_beams", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);
  var_2 = getEntArray("intro_exterior_hatch_lights", "targetname");
  var_3 = getent("intro_exterior_hatch_light", "targetname");

  foreach(var_5 in var_0)
  var_5 hide();

  common_scripts\utility::flag_wait("exterior_hatch_opening");

  foreach(var_5 in var_2)
  var_5 delete();

  foreach(var_5 in var_0)
  var_5 show();

  var_3 setlightintensity(1.1);
  common_scripts\utility::flag_wait("player_approaching_infiltration");

  foreach(var_5 in var_0)
  var_5 delete();
}

station_entrance_to_infiltration() {
  var_0 = getent("anim_entrance_to_infiltrate", "script_noteworthy");
  common_scripts\utility::flag_set("remove_temp_blocker");
  var_0 maps\_anim::anim_single_solo(self, "odin_infiltrate_kyra_entrance");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_infiltrate_kyra_midpoint_idle", "stop_loop");
  common_scripts\utility::flag_set("kyra_is_in_station");
  common_scripts\utility::flag_wait("player_entered_station");
  common_scripts\utility::flag_set("open_airlock_door");
  var_0 notify("stop_loop");
}

mosley_airlock_ln_1(var_0) {
  if(common_scripts\utility::flag("nags_should_overlap"))
    maps\_utility::smart_radio_dialogue_overlap("odin_ast1_pressurizingairlock");
  else
    maps\_utility::smart_radio_dialogue("odin_ast1_pressurizingairlock");
}

mosley_airlock_ln_2(var_0) {
  if(common_scripts\utility::flag("nags_should_overlap"))
    maps\_utility::smart_radio_dialogue_overlap("odin_ast1_reallylookingforwardto");
  else
    maps\_utility::smart_radio_dialogue("odin_ast1_reallylookingforwardto");

  common_scripts\utility::flag_set("notetracked_lines_are_done");
}

ally_movement() {
  level endon("get_intro_moving");
  level endon("airlock_pressurized_and_open");
  maps\_utility::delaythread(10.0, common_scripts\utility::flag_set, "get_intro_moving");

  while(level.player istouching(getent("vol_player_at_satellite", "script_noteworthy")) && !common_scripts\utility::flag("get_intro_moving"))
    wait 0.1;
}

tweak_off_axis_player() {
  level.rndpitchmax = 2;
  level.rndrollhmax = 10;
  level.desired_bob_pitch = 0;
  level.desired_bob_roll = 0;
  thread tweak_player_view_based_on_movement();
  thread tweak_player_wall_push();
  var_0 = common_scripts\utility::spawn_tag_origin();
  level.view_ref_ent = var_0;
  level.player playersetgroundreferenceent(level.view_ref_ent);
  level.view_ref_base_rotator = common_scripts\utility::spawn_tag_origin();
  level.view_ref_base_rotator.angles = level.view_ref_ent.angles;

  if(level.start_point == "odin_intro") {
    common_scripts\utility::flag_clear("clear_to_tweak_player");
    common_scripts\utility::flag_wait("intro_fade_done");
    common_scripts\utility::flag_set("clear_to_tweak_player");
  }

  thread rotation_reset(level.view_ref_ent);

  while(!common_scripts\utility::flag("stop_tweaking_player")) {
    if(common_scripts\utility::flag("clear_to_tweak_player") && !common_scripts\utility::flag("clear_to_tweak_player_forced") && !common_scripts\utility::flag("wall_push_tweak_player")) {
      var_1 = randomfloatrange(0 - level.rndpitchmax, level.rndpitchmax);
      var_2 = randomfloatrange(0 - level.rndrollhmax, level.rndrollhmax);
      var_3 = randomfloatrange(10, 30);
      var_4 = var_3 * 0.25;
      level.view_ref_base_rotator rotateto((var_1, 0, var_2), var_3, var_4, var_4);
      level.view_ref_base_rotator waittill("rotatedone");
    } else
      wait 1.0;

    wait 0.05;
  }

  level.view_ref_base_rotator notify("rotatedone");
  level.view_ref_ent notify("rotatedone");
  level.view_ref_ent rotateto((0, 0, 0), 2, 0, 0);
  level.view_ref_base_rotator rotateto((0, 0, 0), 2, 0, 0);
  wait 2;
  level.player playersetgroundreferenceent(undefined);
  level.view_ref_ent delete();
  level.view_ref_base_rotator delete();
  level notify("tweaking_is_done");
}

rotation_reset(var_0) {
  wait 1;
  level endon("tweaking_is_done");

  for(;;) {
    common_scripts\utility::flag_waitopen("clear_to_tweak_player");
    level.view_ref_base_rotator notify("rotatedone");
    level.view_ref_ent notify("rotatedone");
    level.view_ref_ent rotateto((0, 0, 0), 2, 0, 0);
    level.view_ref_base_rotator rotateto((0, 0, 0), 2, 0, 0);
    wait 2;

    while(!common_scripts\utility::flag("clear_to_tweak_player")) {
      level.view_ref_base_rotator notify("rotatedone");
      level.view_ref_ent notify("rotatedone");
      level.view_ref_ent rotateto((0, 0, 0), 2, 0, 0);
      level.view_ref_base_rotator rotateto((0, 0, 0), 2, 0, 0);
      wait 1;
    }
  }
}

tweak_player_view_based_on_movement() {
  level endon("tweaking_is_done");

  if(level.start_point == "odin_intro")
    wait 1;

  level.view_ref_movement_rotator = common_scripts\utility::spawn_tag_origin();
  var_0 = 1;
  var_1 = "x";
  var_2 = 0;

  while(!common_scripts\utility::flag("stop_tweaking_player")) {
    if(!common_scripts\utility::flag("wall_push_tweak_player") && common_scripts\utility::flag("clear_to_tweak_player")) {
      level.player playersetgroundreferenceent(level.view_ref_ent);

      if(isDefined(level.bob_axis)) {
        if(level.bob_axis == var_1 && level.bob_value == var_2) {
          var_0 = var_0 + 0.5;

          if(var_0 > 3)
            var_0 = 3;
        } else
          var_0 = 1.0;

        if(level.bob_axis == "x") {
          if(level.bob_value > 0) {
            level.desired_bob_pitch = 0 - level.bob_value * var_0 * 0.5 * cos(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * 0.5 * sin(level.player.angles[1]);
          } else {
            level.desired_bob_pitch = 0 - level.bob_value * var_0 * 0.5 * cos(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * 0.5 * sin(level.player.angles[1]);
          }
        }

        if(level.bob_axis == "y") {
          if(level.bob_value > 0) {
            level.desired_bob_pitch = 0 - level.bob_value * var_0 * sin(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * cos(level.player.angles[1]);
          } else {
            level.desired_bob_pitch = 0 - level.bob_value * var_0 * sin(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * cos(level.player.angles[1]);
          }
        }

        if(level.bob_axis == "z") {
          if(level.bob_value > 0) {
            level.desired_bob_pitch = level.bob_value * var_0 * cos(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * sin(level.player.angles[1]);
          } else {
            level.desired_bob_pitch = level.bob_value * var_0 * cos(level.player.angles[1]);
            level.desired_bob_roll = 0 - level.bob_value * var_0 * sin(level.player.angles[1]);
          }
        }

        var_1 = level.bob_axis;
        var_2 = level.bob_value;

        if(level.bob_value == 0)
          level.bob_axis = undefined;

        var_3 = randomfloatrange(1.5, 2.2);
        var_4 = level.view_ref_base_rotator.angles[0] + level.desired_bob_pitch;
        var_5 = level.view_ref_base_rotator.angles[2] + level.desired_bob_roll;
        level.view_ref_ent rotateto((var_4, 0, var_5), var_3, var_3 * 0.2, var_3 * 0.8);
        level.view_ref_ent waittill("rotatedone");
      }
    }

    wait 0.05;
  }

  level.view_ref_movement_rotator delete();
}

tweak_player_view_do_rotate() {
  var_0 = level.view_ref_base_rotator.angles[0] + level.desired_bob_pitch;
  var_1 = level.view_ref_base_rotator.angles[2] + level.desired_bob_roll;
  level.view_ref_ent rotateto((var_0, 0, var_1), 1.6, 0.8, 0.8);
  level.view_ref_ent waittill("rotatedone");
}

tweak_off_translation_player() {
  level endon("start_transition_to_youngblood");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    var_3 = randomint(3);

    if(var_3 == 0) {
      var_4 = randomfloatrange(10, 30);
      var_5 = randomfloatrange(-300, 300);
      var_6 = randomfloatrange(-300, 300);
      var_7 = randomfloatrange(-300, 300);
    } else {
      var_4 = randomfloatrange(5, 10);
      var_5 = 0;
      var_6 = 0;
      var_7 = 0;
    }

    var_8 = (var_5 - var_0) * (1 / var_4);
    var_9 = (var_6 - var_1) * (1 / var_4);
    var_10 = (var_7 - var_2) * (1 / var_4);

    while(var_4 > 0) {
      if(common_scripts\utility::flag("clear_to_tweak_player") && !common_scripts\utility::flag("clear_to_tweak_player_forced")) {
        var_0 = var_0 + var_8;
        var_1 = var_1 + var_9;
        var_2 = var_2 + var_10;
        setsaveddvar("player_swimWaterCurrent", (var_0, var_1, var_2));
        var_4 = var_4 - 1;
        wait 0.05;
        continue;
      }

      wait 1.0;
    }

    if(var_3 == 0) {
      wait(randomfloatrange(0.5, 1));
      continue;
    }

    wait(randomfloatrange(0.5, 1));
  }
}

tweak_player_wall_push() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("wall_push_tweak_player");

    if(common_scripts\utility::flag("clear_to_tweak_player")) {
      wait 0.8;

      if(level.player.angles[1] < -120 || level.player.angles[1] > 120) {
        var_0 = randomfloatrange(-2, 2);

        if(level.view_ref_ent.angles[2] > 0)
          var_1 = randomfloatrange(-25, -5);
        else
          var_1 = randomfloatrange(5, 25);
      } else {
        var_1 = randomfloatrange(-2, 2);

        if(level.view_ref_ent.angles[0] > 0)
          var_0 = randomfloatrange(-25, -5);
        else
          var_0 = randomfloatrange(5, 25);
      }

      var_2 = randomfloatrange(2.3, 3.8);
      level.view_ref_ent rotateto((var_0, 0, var_1), var_2, 0, var_2 * 0.8);
      wait(var_2);
      common_scripts\utility::flag_clear("wall_push_tweak_player");
      level.view_ref_base_rotator.angles = level.view_ref_ent.angles;
      continue;
    }

    wait 1;
  }
}

odin_intro_screen() {
  var_0 = 2;
  var_1 = 4;
  var_2 = 5.5;
  var_3 = 6;

  if(!isDefined(level.prologue) || level.prologue == 0)
    var_0 = 0;

  thread introscreen_generic_fade_in("white", var_2, var_1, var_0);
  wait 2.75;
  var_4 = [];
  var_4[0] = &"ODIN_INTROSCREEN_LINE_0";
  thread maps\_utility::stylized_center_text(var_4, var_3);
  thread delayed_intro();
  wait 4.0;
  common_scripts\utility::flag_set("intro_fade_done");
}

introscreen_generic_fade_in(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1.5;

  if(!isDefined(var_3))
    maps\_hud_util::start_overlay(var_0);
  else
    maps\_hud_util::fade_out(var_3, var_0);

  wait(var_1);
  maps\_hud_util::fade_in(var_2, var_0);
  wait(var_2);
  setsaveddvar("com_cinematicEndInWhite", 0);
}

delayed_intro() {
  common_scripts\utility::flag_wait("intro_show_introtext");
  wait 4.0;
  level.introscreen = spawnStruct();
  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;
  level.introscreen.lines = [ &"ODIN_INTROSCREEN_LINE_3", &"ODIN_INTROSCREEN_LINE_2", &"ODIN_INTROSCREEN_LINE_1"];
  maps\_introscreen::introscreen(1, undefined);
}

fifteen_minutes_earlier_feed_lines(var_0, var_1) {
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_3 * var_1 + 1;
    maps\_utility::delaythread(var_5, ::centerlinethread, var_0[var_4], var_0.size - var_3 - 1, var_1, var_4);
  }
}

centerlinethread(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");

  if(!isDefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle_adjustable";
  var_4.sort = 1;
  var_4.foreground = 1;
  var_4 settext(var_0);
  var_4.alpha = 0;
  var_4 fadeovertime(0.2);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = 2.4;
  var_4.color = (1, 1, 1);
  var_4.font = "objective";
  var_4.glowcolor = (0, 0, 0);
  var_4.glowalpha = 1;
  var_5 = int(var_2 * 1000);
  var_4 setpulsefx(30, var_5, 700);
  thread maps\_introscreen::hudelem_destroy(var_4);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isstring(var_3)) {
    return;
  }
  if(var_3 != "date")
    return;
}

intro_cleanup(var_0) {
  if(var_0 == 0) {
    common_scripts\utility::flag_wait("gun_struggle_commence_trig");

    if(isDefined(level.intro_ent_del)) {
      foreach(var_2 in level.intro_ent_del) {
        if(isDefined(var_2))
          var_2 delete();
      }
    }
  }

  maps\odin_util::safe_delete_noteworthy("intro_trig_to_clean");
  maps\odin_util::safe_delete_noteworthy("intro_ent_to_clean");
  var_4 = getEntArray("intro_tar_to_clean", "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6))
      var_6 delete();
  }

  var_8 = getEntArray("intro_earth", "targetname");

  foreach(var_10 in var_8)
  var_10 delete();
}