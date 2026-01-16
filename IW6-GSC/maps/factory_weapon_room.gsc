/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_weapon_room.gsc
****************************************/

section_precache() {
  precacherumble("light_1s");
  precacherumble("heavy_1s");
}

section_flag_init() {
  common_scripts\utility::flag_init("presat_bravo_in_position");
  common_scripts\utility::flag_init("presat_charlie_in_position");
  common_scripts\utility::flag_init("presat_revolving_door_dialog_done");
  common_scripts\utility::flag_init("presat_open_revolving_door");
  common_scripts\utility::flag_init("presat_door_anim_done");
  common_scripts\utility::flag_init("presat_revolving_door_opened");
  common_scripts\utility::flag_init("presat_revolving_door_closed");
  common_scripts\utility::flag_init("presat_started");
  common_scripts\utility::flag_init("presat_go_loud");
  common_scripts\utility::flag_init("alert_platform_guards");
  common_scripts\utility::flag_init("presat_done");
  common_scripts\utility::flag_init("player_finsh_presat");
  common_scripts\utility::flag_init("presat_locked");
  common_scripts\utility::flag_init("presat_synctransients");
  common_scripts\utility::flag_init("open_sat_entrance");
  common_scripts\utility::flag_init("pre_sat_door_alpha_in_position");
  common_scripts\utility::flag_init("pre_sat_door_charlie_in_position");
  common_scripts\utility::flag_init("sat_entrance_allies_go");
  common_scripts\utility::flag_init("start_moving_satellite_pieces");
  common_scripts\utility::flag_init("sat_room_allies_move_in");
  common_scripts\utility::flag_init("sat_room_approach_drawbridge");
  common_scripts\utility::flag_init("sat_room_bridge_down");
  common_scripts\utility::flag_init("sat_room_alpha_found_it");
  common_scripts\utility::flag_init("sat_room_alpha_enter_done");
  common_scripts\utility::flag_init("sat_room_player_knifed");
  common_scripts\utility::flag_init("sat_room_player_pulled");
  common_scripts\utility::flag_init("sat_room_alpha_get_down");
  common_scripts\utility::flag_init("sat_room_saw_board_front");
  common_scripts\utility::flag_init("sat_room_player_flipped");
  common_scripts\utility::flag_init("sat_room_continue");
  common_scripts\utility::flag_init("sat_room_exiting");
  common_scripts\utility::flag_init("sat_room_clear");
  common_scripts\utility::flag_init("lgt_weapon_room_jump");
  common_scripts\utility::flag_init("lgt_weapon_sequencing");
  common_scripts\utility::flag_init("railgun_reveal_setup");
  common_scripts\utility::flag_init("sat_raise_rod_01");
  common_scripts\utility::flag_init("sat_raise_rod_02");
  common_scripts\utility::flag_init("sat_raise_cpu_cover");
  common_scripts\utility::flag_init("platform_unresolve_collision");
  common_scripts\utility::flag_init("start_camera_moment");
  common_scripts\utility::flag_init("give_use_hint_if_needed");
  common_scripts\utility::flag_init("player_using_camera");
  common_scripts\utility::flag_init("sat_begin_looking_for_B");
  common_scripts\utility::flag_init("cam_B_confirmed");
  common_scripts\utility::flag_init("sat_allow_scan");
  common_scripts\utility::flag_init("cam_A_scanned");
  common_scripts\utility::flag_init("cam_B_scanned");
  common_scripts\utility::flag_init("sat_drawbridge_up");
}

presat_room_start() {
  level.player maps\factory_util::move_player_to_start_point("playerstart_presat_room");
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "ws_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "ws_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "ws_start_charlie");
  maps\factory_util::safe_trigger_by_targetname("sca_ps_final_kills_done");
  maps\factory_powerstealth::squad_stealth_on();
  common_scripts\utility::flag_set("entered_factory_1");
  thread presat_init_revolving_door();
  maps\_utility::player_speed_percent(65);
  level thread maps\factory_powerstealth::factory_stealth_settings();
  maps\_stealth_utility::stealth_set_default_stealth_function("factory_stealth", maps\factory_powerstealth::factory_stealth_settings);
  common_scripts\utility::flag_set("powerstealth_end");
  common_scripts\utility::flag_set("ps_alpha_done");
  common_scripts\utility::flag_set("presat_bravo_in_position");
  common_scripts\utility::flag_set("presat_charlie_in_position");
  maps\_utility::battlechatter_off();
  thread maps\_weather::rainnone(8);
  thread maps\factory_intro::train_cleanup();
}

presat_room() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::enable_bulletwhizbyreaction();
    var_1 maps\_utility::enable_pain();
  }

  common_scripts\utility::flag_wait("presat_entrance");
  maps\_utility::autosave_by_name("presat_room");
  common_scripts\utility::flag_wait_all("ps_alpha_done", "presat_bravo_in_position", "presat_charlie_in_position");

  foreach(var_4 in level.squad) {
    var_4 maps\_utility::disable_surprise();
    var_4.disableplayeradsloscheck = 1;
  }

  thread maps\factory_anim::presat_door_open();
  thread presat_dialogue();
  thread pre_sat_weapons_drop();
  thread presat_ally_movement();
  thread presat_enemies();
  thread presat_airlock_doors();
  thread presat_moving_platform();
  thread presat_moving_platform_02();
  thread presat_transient_load();
  wait 0.1;
  thread presat_agvs();
  thread presat_glass_decals("presat_decal_left_office_L");
  thread presat_glass_decals("presat_decal_left_office_R");
  thread presat_glass_decals("presat_decal_right_office_L");
  thread presat_glass_decals("presat_decal_right_office_R");
  thread presat_fans("presat_fan_1", 16);
  thread presat_fans("presat_fan_2", 22);
  common_scripts\utility::flag_wait("presat_allies_go_loud");
  maps\_utility::player_speed_percent(100, 5);
  var_6 = level.player.threatbias;
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  common_scripts\utility::flag_set("_stealth_spotted");
  maps\_stealth_utility::disable_stealth_system();
  maps\_utility::waittill_aigroupcleared("presat_enemies");
  common_scripts\utility::flag_set("presat_done");
  common_scripts\utility::flag_wait("railgun_reveal_setup");
  thread presat_cleanup();
}

presat_transient_load() {
  common_scripts\utility::flag_wait("presat_revolving_door_closed");
  maps\_utility::transient_unloadall_and_load("factory_mid_tr");
  common_scripts\utility::flag_wait("presat_synctransients");
  maps\factory_util::sync_transients();
}

presat_dialogue() {
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "presat_revolving_door_dialog_done");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_oldboywevereachedthe");
  maps\_utility::smart_radio_dialogue("factory_oby_nocamerasinblack");
  thread maps\_weather::rainnone(8);
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_headingin");
  common_scripts\utility::flag_wait("presat_allies_go_loud");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_multipletangosgohot");
  wait 0.2;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_keepmoving");
  wait 1.6;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_morecontactsstructureat");
  maps\_utility::waittill_aigroupcleared("presat_enemies");
  maps\_utility::waittill_aigroupcleared("presat_enemies_backup");
  wait 0.45;
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_hsh_clear");
  maps\_utility::smart_radio_dialogue("factory_oby_nochatteronenemy");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_copyoldboy");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_housemainweare");
  maps\_utility::smart_radio_dialogue("factory_hqr_rogerjericho11continue");
  common_scripts\utility::flag_wait_all("sat_open_moment", "pre_sat_door_alpha_in_position", "pre_sat_door_charlie_in_position");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_pressurelockeddoorthis");
  thread maps\factory_audio::sfx_metal_door_unlock();
  maps\_utility::smart_radio_dialogue("factory_oby_roger");
  common_scripts\utility::flag_set("open_sat_entrance");
  wait 0.35;
  common_scripts\utility::flag_set("sat_entrance_allies_go");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_bingo");
}

pre_sat_weapons_drop() {
  var_0 = spawn("weapon_gm6+scopegm6_sp", (8119, 580, 260));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
}

presat_ally_movement() {
  common_scripts\utility::flag_wait("presat_door_anim_done");
  maps\factory_util::safe_trigger_by_targetname("presat_allies_enter");

  foreach(var_1 in level.squad) {
    var_1.ignoresuppression = 1;
    var_1.disableplayeradsloscheck = 1;
    var_1.suppressionwait_old = var_1.suppressionwait;
    var_1.suppressionwait = 0;
    var_1 maps\_utility::disable_surprise();
    var_1.ignorerandombulletdamage = 1;
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_danger_react();
    var_1.disablefriendlyfirereaction = 1;
    level.ai_friendlyfireblockduration = getdvarfloat("ai_friendlyFireBlockDuration");
    setsaveddvar("ai_friendlyFireBlockDuration", 0);
  }

  thread presat_disable_ally_noreact();
  common_scripts\utility::flag_wait("alert_platform_guards");

  foreach(var_1 in level.squad) {
    var_1 pushplayer(0);
    var_1.moveplaybackrate = 1.0;
    var_1.goalradius = 4;
    var_1.fixednodesaferadius = 512;
    var_1 maps\_utility::enable_ai_color_dontmove();
    var_1 maps\_utility::enable_cqbwalk();
    var_1.ignoreall = 0;
    var_1 maps\_utility::delaythread(1.5, maps\_utility::set_ignoreme, 0);
    var_1 maps\_utility::delaythread(2.0, maps\_utility::enable_surprise);
  }

  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::set_team_bcvoice("allies", "seal");
  level.squad["ALLY_BRAVO"] thread presat_ally_walk_around();
  thread presat_allies_wait_in_office();
  common_scripts\utility::flag_wait("presat_office");
  maps\_utility::waittill_aigroupcleared("presat_enemies");
  maps\_utility::waittill_aigroupcleared("presat_enemies_backup");
  maps\factory_util::safe_trigger_by_targetname("presat_allies_wait_at_sat_door");
  common_scripts\utility::flag_wait("sat_open_moment");
  var_5 = getent("sat_room_enter_node", "targetname");
  thread pre_sat_door_alpha_get_ready(var_5);
  thread pre_sat_door_charlie_get_ready(var_5);
  common_scripts\utility::flag_wait_all("pre_sat_door_alpha_in_position", "pre_sat_door_charlie_in_position", "sat_entrance_allies_go");
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "weapon_room_dialogue_trigger");
  var_5 thread maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "sat_room_enter_alpha");
  var_5 thread maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "sat_room_enter_charlie");
  var_5 maps\_anim::anim_reach_solo(level.squad["ALLY_BRAVO"], "sat_room_enter_bravo");
  var_5 maps\_anim::anim_single_solo(level.squad["ALLY_BRAVO"], "sat_room_enter_bravo");
  maps\_anim::anim_reach_cleanup_solo(level.squad["ALLY_BRAVO"]);

  foreach(var_7 in level.squad) {
    var_7 setgoalpos(var_7.origin);
    var_7 maps\_utility::disable_cqbwalk();
  }

  common_scripts\utility::flag_set("sat_room_allies_move_in");

  foreach(var_1 in level.squad) {
    var_1 pushplayer(1);
    var_1.moveplaybackrate = 1.0;
    var_1.goalradius = 0;
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
    var_1.ignoresuppression = 0;
    var_1.disableplayeradsloscheck = 0;
    var_1.suppressionwait = var_1.suppressionwait_old;
    var_1 maps\_utility::enable_surprise();
    var_1.ignorerandombulletdamage = 0;
    var_1 maps\_utility::enable_bulletwhizbyreaction();
    var_1.disablefriendlyfirereaction = 0;
    setsaveddvar("ai_friendlyFireBlockDuration", level.ai_friendlyfireblockduration);
  }
}

pre_sat_door_alpha_get_ready(var_0) {
  level.squad["ALLY_ALPHA"].goalradius = 32;
  level.squad["ALLY_ALPHA"] common_scripts\utility::waittill_notify_or_timeout("goal", 60);
  common_scripts\utility::flag_set("pre_sat_door_alpha_in_position");
}

pre_sat_door_charlie_get_ready(var_0) {
  level.squad["ALLY_CHARLIE"].goalradius = 32;
  level.squad["ALLY_CHARLIE"] common_scripts\utility::waittill_notify_or_timeout("goal", 60);
  common_scripts\utility::flag_set("pre_sat_door_charlie_in_position");
}

presat_disable_ally_noreact() {
  common_scripts\utility::flag_wait("presat_close_revolving_door");

  foreach(var_1 in level.squad) {
    var_1 maps\_utility::enable_surprise();
    var_1.disableplayeradsloscheck = 0;
    var_1.ignorerandombulletdamage = 0;
    var_1 maps\_utility::enable_bulletwhizbyreaction();
    var_1.disablefriendlyfirereaction = 0;
  }
}

presat_ally_walk_around() {
  level endon("presat_stop_walk_around");
  self.goalradius = 0;
  var_0 = getnode("presat_walk_around_node", "targetname");
  self setgoalpos(var_0.origin);
  self waittill("goal");
  var_0 = getnode(var_0.target, "targetname");
  self setgoalpos(var_0.origin);
  self waittill("goal");
  var_0 = getnode(var_0.target, "targetname");
  self setgoalpos(var_0.origin);
  self waittill("goal");
  maps\factory_util::safe_trigger_by_targetname("presat_walk_around_node_01");
  self waittill("goal");
  wait 1.5;
  maps\factory_util::safe_trigger_by_targetname("presat_walk_around_node_02");
  self waittill("goal");
  wait 1.5;
  maps\factory_util::safe_trigger_by_targetname("presat_walk_around_node_03");
}

presat_allies_wait_in_office() {
  for(var_0 = 10; var_0 > 2; var_0 = maps\_utility::get_ai_group_count("presat_enemies") + maps\_utility::get_ai_group_count("presat_enemies_backup"))
    wait 0.1;

  level notify("presat_stop_walk_around");
  maps\factory_util::safe_trigger_by_targetname("presat_allies_clear_office");
  maps\factory_util::safe_delete_targetname("presat_allies_enter");
  maps\factory_util::safe_delete_targetname("presat_allies_move_in");
  maps\factory_util::safe_delete_targetname("presat_allies_on_office");
}

presat_enemies() {
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  var_0 = getEntArray("presat_initial_enemies_02", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_3)) {
      var_2 delete();
      continue;
    }

    var_3 thread presat_office_guards_react();
  }

  var_5 = getEntArray("presat_initial_enemies_01", "targetname");

  foreach(var_2 in var_5) {
    var_3 = var_2 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_3)) {
      var_2 delete();
      continue;
    }

    var_3.ignoreall = 1;
    var_3.animname = "enemy";
    var_3.dontevershoot = 1;
    var_3 thread wait_for_waking_event();
    var_3 maps\_utility::set_generic_run_anim_array("walk_gun_unwary");

    if(isDefined(var_3.target))
      var_3 thread maps\_patrol::patrol(var_3.target);

    var_3 thread presat_react_stop_patrol("patrol_bored_walk_2_scared_idle_turn_l_90");
  }

  common_scripts\utility::flag_wait_any("presat_revolving_door_opened", "presat_started");
  maps\_utility::waittill_aigroupcount("presat_enemies", 5);
  var_8 = getEntArray("presat_backup_enemies", "targetname");

  foreach(var_2 in var_8) {
    var_3 = var_2 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_3)) {
      var_2 delete();
      continue;
    }

    var_3.health = 1;
    var_3.a.disablelongdeath = 1;
  }
}

wait_for_waking_event() {
  self endon("death");
  self endon("flashbang");
  self endon("guy_waking_up");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("explode");
  self addaieventlistener("projectile_impact");

  for(;;) {
    self waittill("ai_event", var_0);

    if(var_0 == "gunshot" || var_0 == "bulletwhizby" || var_0 == "explode") {
      common_scripts\utility::flag_set("alert_platform_guards");
      common_scripts\utility::flag_set("presat_go_loud");
      return;
    }
  }
}

presat_react_stop_patrol(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("alert_platform_guards");
  self.ignoreall = 0;
  self stopanimscripted();
  maps\_utility::clear_generic_run_anim();

  if(isDefined(var_0))
    maps\_anim::anim_single_solo(self, var_0);

  wait 0.5;
  self.dontevershoot = undefined;
}

presat_office_guards_react() {
  self.ignoreall = 1;
  common_scripts\utility::flag_wait("alert_platform_guards");
  wait(randomfloatrange(0.5, 1.5));
  self.ignoreall = 0;
}

presat_moving_platform() {
  level endon("presat_locked");
  var_0 = create_loader_platform("loading_platform_node", "loading_platform");
  var_0 thread platform_enemies();
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  var_0 thread platform_lights("platform_warning_light_01", "platform_brake_light_01");
  var_0 thread path_disconnector();
  var_1 = getent("moving_platform_start_position", "targetname");
  var_0 moveto(var_1.origin, 0.1);
  var_0 waittill("movedone");
  var_0 thread maps\factory_audio::moving_platform_warning_beeps_sfx(var_1.origin);
  var_0 thread maps\factory_audio::moving_platform_movement_loop_sfx(var_1.origin, 42.8);
  var_0 notify("spawn_enemies");
  var_2 = getent("moving_platform_end_position", "targetname");
  var_0 thread platform_speed_changer(var_1, var_2);
  var_0 thread platform_stop_for_actors(var_2);
  var_0 movex(1450, 90, 5, 5);
  var_0 waittill("movedone");
  var_0 notify("stop_scripts");
}

presat_moving_platform_02() {
  level endon("presat_locked");
  var_0 = create_loader_platform("loading_platform_02_node", "loading_platform_02");
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  var_0 thread platform_lights("platform_warning_light_02", "platform_brake_light_02");
  var_0 thread path_disconnector();
  var_1 = getent("moving_platform_02_start_position", "targetname");
  var_0 moveto(var_1.origin, 0.1);
  var_0 waittill("movedone");
  var_2 = getent("moving_platform_02_end_position", "targetname");
  var_3 = abs(var_1.origin[0] - var_2.origin[0]);
  var_0 thread maps\factory_audio::moving_platform_movement_loop_sfx(var_1.origin, 26);
  var_0 movex(var_3, 30, 5, 5);
  var_0 waittill("movedone");
  var_0 notify("stop_scripts");
}

create_loader_platform(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = getEntArray(var_1, "targetname");

  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "connector_node")
        var_2.connector_node = var_5;
      else if(var_5.script_noteworthy == "disconnector_node")
        var_2.disconnector_node = var_5;
      else if(var_5.script_noteworthy == "platform_collision_detection_volume") {
        var_5 enablelinkto();
        var_2.platform_collision_detection_volume = var_5;
      }
    }

    var_5 linkto(var_2);
  }

  return var_2;
}

delete_loader_platform() {
  var_0 = getEntArray("loading_platform", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_model") {
      var_2 delete();
      continue;
    }

    var_2 hide();
  }
}

platform_enemies() {
  self waittill("spawn_enemies");
  var_0 = getEntArray("presat_platform_enemies", "targetname");
  var_1 = getEntArray("platform_guard_node", "script_noteworthy");
  var_2 = [];

  foreach(var_6, var_4 in var_0) {
    var_5 = var_4 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_5)) {
      return;
    }
    var_5 forceteleport(var_1[var_6].origin, var_1[var_6].angles);
    var_5 linkto(self);
    var_5.ignoreall = 1;
    var_2[var_2.size] = var_5;
    var_5 thread wait_for_waking_event();
    var_5 thread alert_on_death();
  }

  thread alert_platform_guards(var_2);
  thread alert_platform_guards_on_sight(var_2);
  common_scripts\utility::flag_wait("presat_revolving_door_opened");
  wait 2.1;
  common_scripts\utility::flag_set("alert_platform_guards");
}

alert_on_death() {
  self waittill("damage");
  common_scripts\utility::flag_set("alert_platform_guards");
  self.noragdoll = 1;
}

alert_platform_guards(var_0) {
  common_scripts\utility::flag_wait("alert_platform_guards");

  foreach(var_2 in var_0) {
    wait(randomfloatrange(0.25, 0.45));

    if(!isDefined(var_2)) {
      continue;
    }
    var_2.ignoreall = 0;
    var_2 stopanimscripted();
    var_2.animname = "enemy";
    var_2.favoriteenemy = level.player;
  }
}

alert_platform_guards_on_sight(var_0) {
  common_scripts\utility::flag_wait("presat_started");
  wait 1.0;
  common_scripts\utility::flag_set("alert_platform_guards");
}

path_disconnector(var_0, var_1) {
  self endon("death");
  self endon("stop_scripts");
  level endon("presat_locked");
  var_2 = getEntArray("moving_platform_path_trigger", "targetname");

  foreach(var_4 in var_2) {
    var_4.connected = 0;

    if(!isDefined(var_4.script_parameters)) {
      var_4 connectpaths();
      var_4.connected = 1;
    }

    var_4 notsolid();
  }

  var_6 = self.disconnector_node;
  var_7 = self.connector_node;

  for(;;) {
    foreach(var_4 in var_2) {
      if(var_4.connected && var_6 istouching(var_4)) {
        var_4 solid();
        var_4 disconnectpaths();
        var_4.connected = 0;
        var_4 notsolid();
        continue;
      }

      if(!var_4.connected && var_7 istouching(var_4)) {
        var_4 solid();
        var_4 connectpaths();
        var_4.connected = 1;
        var_4 notsolid();
      }
    }

    wait 3.0;
  }
}

platform_lights(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2 common_scripts\utility::spawn_tag_origin();
  var_3 linkto(self);
  playFXOnTag(level._effect["amber_light_45_beacon_nolight_beam"], var_3, "tag_origin");
  playFXOnTag(level._effect["amber_light_45_beacon_glow"], var_3, "tag_origin");
  playFXOnTag(level._effect["factory_amber_flare"], var_3, "tag_origin");
  var_4 = getEntArray(var_1, "script_noteworthy");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5[var_5.size] = var_7 common_scripts\utility::spawn_tag_origin();
    var_5[var_5.size - 1] linkto(self);
    playFXOnTag(level._effect["factory_presat_brake_light"], var_5[var_5.size - 1], "tag_origin");
  }

  common_scripts\utility::flag_wait("presat_locked");
  var_3 delete();

  foreach(var_10 in var_5)
  var_10 delete();
}

platform_speed_changer(var_0, var_1) {
  self endon("stop_scripts");
  level endon("presat_locked");
  common_scripts\utility::flag_wait("player_on_platform");

  if(!isDefined(self)) {
    return;
  }
  var_2 = abs(self.origin[0] - var_1.origin[0]);
  var_3 = var_2 / 32.0;

  if(var_3 > 10.0)
    self moveto(var_1.origin, var_3, 5.0, 5.0);
}

platform_stop_for_actors(var_0) {
  self endon("stop_scripts");
  level endon("presat_locked");

  if(!isDefined(self.platform_collision_detection_volume)) {
    return;
  }
  var_1 = self.platform_collision_detection_volume;

  for(;;) {
    var_2 = var_1 maps\_utility::get_ai_touching_volume();

    if(level.player istouching(var_1) || var_2.size >= 1 || var_0 istouching(var_1)) {
      self moveto(self.origin + (15, 0, 0), 1.0, 0.5, 0.5);
      return;
    }

    wait 0.25;
    wait 0.25;
  }
}

platform_squash() {
  self endon("stop_scripts");
  level endon("presat_locked");
  level waittill("presat_close_revolving_door");
  common_scripts\utility::flag_set("platform_unresolve_collision");
}

presat_airlock_doors() {
  thread presat_revolving_door();
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_enter_01", 0.75, 0.1, "lock_presat_01");
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_enter_02", 0.75, 0.1, "lock_presat_02", "open_sat_entrance");
  thread presat_tube_cleanser("sat_tube_1_cleanse", "stop_tube_1_cleanse");
}

presat_init_revolving_door() {
  common_scripts\utility::flag_wait("entered_factory_1");
  thread maps\factory_fx::fx_show_hide("fx_sat_revolving_door_light_off", "fx_sat_revolving_door_light_on");
  wait 3.0;
  var_0 = getent("revolving_door_origin", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 linkto(var_0);
    var_3 connectpaths();
  }

  level.presat_door = var_0;
  level.presat_door_slider_01 = getent("revolving_door_slider_01", "targetname");
  level.presat_door_slider_02 = getent("revolving_door_slider_02", "targetname");

  if(isDefined(level.presat_door_slider_01))
    level.presat_door_slider_01 movex(110, 0.1);

  if(isDefined(level.presat_door_slider_02))
    level.presat_door_slider_02 movex(-110, 0.1);
}

presat_revolving_door() {
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  thread maps\factory_util::god_rays_round_door_open();
  thread cleanup_all_axis();
  thread maps\factory_audio::sfx_revolving_door_open(level.presat_door);
  thread maps\factory_fx::fx_sat_revolving_door_light_setup();
  common_scripts\utility::exploder("presat_ambient");
  level.presat_door rotateyaw(90, 4.83);
  level.presat_door_slider_01 movex(-110, 4.83);
  level.presat_door_slider_02 movex(110, 4.83);
  wait 5.0;
  common_scripts\utility::flag_set("presat_revolving_door_opened");
  common_scripts\utility::flag_wait("presat_close_revolving_door");
  level notify("stop_box_conveyor_system");
  var_0 = getent("presat_door_safe_vol", "targetname");

  for(;;) {
    var_1 = var_0 maps\_utility::get_ai_touching_volume("allies");

    if(var_1.size == 3 && level.player istouching(var_0)) {
      break;
    }

    wait 1.0;
  }

  level.presat_door rotateyaw(-90, 2);
  level.presat_door waittill("rotatedone");
  wait 0.25;
  level notify("stop_box_conveyor_system");
  common_scripts\utility::flag_set("presat_revolving_door_closed");
}

presat_tube_cleanser(var_0, var_1) {
  level endon(var_1);

  for(;;) {
    common_scripts\utility::flag_wait(var_0);
    common_scripts\utility::exploder("presat_air_cleanse");
    wait 10.5;
  }
}

presat_agvs() {
  common_scripts\utility::flag_wait("presat_started");
  var_0 = getent("presat_forklift_01_spawner", "targetname");
  var_0 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor, "presat_forklift_02");
  var_0 = getent("presat_forklift_02_spawner", "targetname");
  var_0 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  var_0 = getent("presat_forklift_03_spawner", "targetname");
  var_0 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  common_scripts\utility::flag_wait("presat_open_revolving_door");
  maps\factory_util::safe_trigger_by_targetname("presat_forklift_01");
  maps\factory_util::safe_trigger_by_targetname("presat_forklift_02");
  maps\factory_util::safe_trigger_by_targetname("presat_forklift_03");
  common_scripts\utility::flag_wait("presat_agv_allow_agv2");
  maps\factory_util::safe_trigger_by_targetname("presat_forklift_01");
}

presat_cleanup(var_0) {
  if(!isDefined(var_0))
    level waittill("presat_locked");

  thread cleanup_all_axis();
  maps\factory_util::safe_delete_targetname("presat_initial_enemies_01");
  maps\factory_util::safe_delete_targetname("presat_initial_enemies_02");
  maps\factory_util::safe_delete_targetname("presat_backup_enemies");
  maps\factory_util::safe_delete_targetname("presat_platform_enemies");
  var_1 = maps\_utility::get_vehicle("presat_forklift_01_spawner", "targetname");
  maps\factory_util::safe_delete(var_1);
  thread delete_loader_platform();
  maps\factory_util::safe_delete_targetname("presat_fan_1");
  maps\factory_util::safe_delete_targetname("presat_fan_2");
  maps\factory_util::safe_delete_targetname("revolving_door_origin");
  maps\factory_util::safe_delete_targetname("presat_room_door");
  level notify("stop_box_conveyor_system");
}

cleanup_all_axis() {
  var_0 = getaispeciesarray("axis", "all");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(!isDefined(var_2.magic_bullet_shield))
        var_2 thread maps\factory_ambush::kill_after_time(0.0, 1.0);
    }
  }
}

presat_glass_decals(var_0) {
  level endon("lock_presat_01");
  var_1 = getglass(var_0);
  var_2 = getent(var_0, "targetname");

  for(;;) {
    if(isglassdestroyed(var_1)) {
      if(isDefined(var_2))
        var_2 delete();

      break;
    }

    wait 0.05;
  }
}

presat_fans(var_0, var_1) {
  level endon("presat_locked");
  var_2 = getent(var_0, "targetname");

  for(;;) {
    var_2 rotatepitch(360, var_1, 0, 0);
    wait(var_1);
  }
}

sat_room_start() {
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "ALLY_ALPHA_weapon_room_teleport");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "ALLY_BRAVO_weapon_room_teleport");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "ALLY_CHARLIE_weapon_room_teleport");
  level.player maps\factory_util::move_player_to_start_point("playerstart_weapon_room_alt");
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_enter_01", 0.75, 0.1, "lock_presat_01");
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_enter_02", 0.75, 0.1, "lock_presat_02", "open_sat_entrance");
  maps\factory_util::safe_trigger_by_targetname("presat_allies_wait_at_sat_door");
  var_0 = getent("sat_room_enter_node", "targetname");
  thread pre_sat_door_alpha_get_ready(var_0);
  thread pre_sat_door_charlie_get_ready(var_0);
  common_scripts\utility::flag_wait_all("pre_sat_door_alpha_in_position", "pre_sat_door_charlie_in_position", "sat_open_moment");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_pressurelockeddoorthis");
  thread maps\factory_audio::sfx_metal_door_unlock();
  maps\_utility::smart_radio_dialogue("factory_oby_roger");
  common_scripts\utility::flag_set("open_sat_entrance");
  wait 0.35;
  common_scripts\utility::flag_set("sat_entrance_allies_go");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_bingo");
  var_0 = getent("sat_room_enter_node", "targetname");
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "weapon_room_dialogue_trigger");
  var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "sat_room_enter_alpha");
  var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "sat_room_enter_charlie");
  var_0 maps\_anim::anim_reach_solo(level.squad["ALLY_BRAVO"], "sat_room_enter_bravo");
  var_0 maps\_anim::anim_single_solo(level.squad["ALLY_BRAVO"], "sat_room_enter_bravo");
  common_scripts\utility::flag_set("sat_room_allies_move_in");
}

sat_room() {
  if(isDefined(level.do_sat_shortcut)) {
    common_scripts\utility::flag_wait("sat_room_clear");
    return;
  }

  thread maps\factory_audio::sfx_rog_reveal_setup();
  thread sat_room_move_pieces();
  thread maps\factory_camera::sat_room_camera();
  thread maps\factory_anim::factory_assembly_line_play();
  thread sat_room_doors();
  thread sat_room_ally_movement();
  thread setup_assembly_room_door();
  thread maps\_weather::rainnone(2);
  var_0 = common_scripts\utility::array_combine(getEntArray("sat_target_A_tag_nodes", "targetname"), getEntArray("sat_target_B_tag_nodes", "targetname"));

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  common_scripts\utility::flag_set("lgt_weapon_room_jump");
  level thread sat_automated_bridge();
  thread sat_room_dialogue();
  common_scripts\utility::flag_wait("sat_room_continue");
  thread sat_cleanup();
  common_scripts\utility::flag_wait("reveal_room_player_at_exit");
  level.squad["ALLY_ALPHA"] pushplayer(1);
  level.squad["ALLY_ALPHA"].goalradius = 0;
  level.squad["ALLY_ALPHA"] waittill("goal");
  level.squad["ALLY_ALPHA"].goalradius = 2048;
  level.squad["ALLY_CHARLIE"] pushplayer(1);
  level.squad["ALLY_CHARLIE"].goalradius = 0;
  level.squad["ALLY_CHARLIE"] waittill("goal");
  level.squad["ALLY_CHARLIE"].goalradius = 2048;
  common_scripts\utility::flag_set("sat_room_exiting");
  level thread maps\factory_util::open_door("ambush_door_pivot_left", -160, 0.5, 1);
  level thread maps\factory_util::open_door("ambush_door_pivot_right", 145, 0.5, 1);
  wait 3.0;
  thread maps\factory_ambush::ambush_setup();
  maps\factory_anim::reveal_room_exit_door();
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally01_position");
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally02_position");
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally03_position");

  if(common_scripts\utility::flag("entered_pre_ambush_room")) {
    wait 0.1;
    maps\factory_util::safe_trigger_by_targetname("ambush_room_ally_positions");
    level.squad["ALLY_ALPHA"] maps\_utility::set_generic_idle_anim("casual_stand_idle");
  }

  common_scripts\utility::flag_set("sat_room_clear");
}

sat_room_dialogue() {
  common_scripts\utility::flag_wait("weapon_room_dialogue_trigger");
  common_scripts\utility::flag_set("lgt_weapon_sequencing");
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_hsh_shit");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_kgn_lookslikesomekind");
  common_scripts\utility::flag_set("sat_raise_rod_01");
  common_scripts\utility::flag_set("sat_raise_rod_02");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_withahellof");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_touchdownhousemainrecce");
  maps\_utility::smart_radio_dialogue("factory_hqr_copyjerichoweneed");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_adamgetyoureyes");
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_keegangetthemain");
  common_scripts\utility::flag_wait("presat_locked");
  common_scripts\utility::flag_set("give_use_hint_if_needed");
  common_scripts\utility::flag_set("start_camera_moment");
  common_scripts\utility::flag_wait("player_using_camera");
  wait 0.2;
  maps\_utility::smart_radio_dialogue("factory_hqr_visualfeedisup");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_copyhousemainsend");
  maps\_utility::smart_radio_dialogue("factory_hqr_adampanupto");
  common_scripts\utility::flag_set("sat_begin_looking_for_B");
  common_scripts\utility::flag_wait("cam_B_confirmed");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("factory_hqr_okthatsthemain");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_liketheonesthat");
  maps\_utility::smart_radio_dialogue("factory_els_yeahbutthesearesmaller");
  maps\_utility::smart_radio_dialogue("factory_hqr_scanovertothe");
  maps\_utility::delaythread(4.2, common_scripts\utility::flag_set, "sat_drawbridge_up");
  maps\_utility::delaythread(5.0, common_scripts\utility::flag_set, "sat_raise_cpu_cover");
  wait 0.33;
  maps\_utility::smart_radio_dialogue("factory_hqr_damn12rodstungsten");
  sat_room_anim_dialogue();
}

sat_room_anim_dialogue() {
  maps\_utility::smart_radio_dialogue("factory_hqr_goodworkjerichothis");
  common_scripts\utility::flag_set("sat_room_continue");

  if(level.player.has_binoculars == 1)
    maps\factory_camera::disable_camera();

  maps\_utility::smart_radio_dialogue("factory_hqr_arclightyouareconfirmed");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_letsmove");
  maps\_utility::smart_radio_dialogue("factory_arc_copyoverlordgenesis");
  maps\_utility::smart_radio_dialogue("factory_hqr_arclight2425and");
  maps\_utility::smart_radio_dialogue("factory_hqr_ripanyandall");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_copythathousemain");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_oldboyyoucopythat");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_oby_copywereonit");
  common_scripts\utility::flag_wait("sat_room_exiting");
}

sat_room_ally_movement() {
  common_scripts\utility::flag_wait("sat_room_allies_move_in");
  level.squad["ALLY_ALPHA"] thread maps\factory_anim::sat_room_alpha_typing();
  wait 0.5;
  thread charlie_moves_in_and_idles();
  wait 1;
  level.squad["ALLY_BRAVO"] thread maps\factory_anim::sat_room_bravo_typing_01();
  common_scripts\utility::flag_wait("cam_B_confirmed");
  wait 0.2;
  var_0 = getent("automated_bridge_blocker", "script_noteworthy");
  var_0 connectpaths();
  var_0 delete();
  maps\factory_util::safe_trigger_by_targetname("sat_room_ally_wait_for_bridge");
  common_scripts\utility::flag_wait("sat_room_bridge_down");
  wait 0.1;
  common_scripts\utility::flag_wait("sat_room_continue");
  level notify("stop_nag");
  wait 0.25;

  foreach(var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 maps\_utility::disable_cqbwalk();
  }

  maps\factory_util::safe_trigger_by_targetname("weapon_room_exit_positions");
}

charlie_moves_in_and_idles() {
  maps\factory_util::safe_trigger_by_targetname("sat_room_charlie_move_in");
  level.squad["ALLY_CHARLIE"] waittill("goal");
  wait 1;
  level.squad["ALLY_CHARLIE"] thread maps\_anim::anim_loop_solo(level.squad["ALLY_CHARLIE"], "casual_stand_idle", "stop_loop");
  common_scripts\utility::flag_wait("sat_room_continue");
  level.squad["ALLY_CHARLIE"] notify("stop_loop");
}

sat_delayed_force_camera() {
  if(isDefined(level.player.binoculars_active) && level.player.binoculars_active && level.player.current_binocular_zoom_level != 0) {
    level.player.current_binocular_zoom_level = 0;
    level.player thread maps\factory_camera::binoculars_zoom();
  }

  wait 2.5;

  if(isDefined(level.player.binoculars_active) && !level.player.binoculars_active) {
    var_0 = 1;
    level.player notify("use_binoculars", var_0);
  }
}

sat_room_doors() {
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_exit_01", 0.75, 0.1, "lock_sat", "sat_room_continue");
  thread maps\factory_util::create_automatic_sliding_door("sliding_door_sat_exit_02", 0.75, 0.1, "lock_sat");
  common_scripts\utility::flag_wait_all("pre_sat_door_alpha_in_position", "pre_sat_door_charlie_in_position", "sat_open_moment");
  level notify("lock_presat_01");
  common_scripts\utility::flag_wait("sat_room_player_down_stairs");
  var_0 = getent("sat_room_vol", "targetname");

  while(var_0 maps\_utility::get_ai_touching_volume("allies").size < 3)
    wait 0.1;

  while(!level.player istouching(var_0))
    wait 0.1;

  level notify("lock_presat_02");
  common_scripts\utility::flag_set("presat_locked");
  common_scripts\utility::flag_wait("sat_room_exiting");
  level notify("lock_sat");
}

sat_cleanup(var_0) {
  if(!isDefined(var_0))
    level waittill("lock_sat");

  level notify("stop_nag");

  if(!isDefined(var_0)) {
    foreach(var_2 in level.squad)
    var_2.moveplaybackrate = 1.0;
  }

  maps\factory_util::safe_delete_targetname("sat_automated_bridge_right");
  maps\factory_util::safe_delete_targetname("sat_automated_bridge_left");
  maps\factory_util::safe_delete_targetname("sat_automated_bridge_right_org");
  maps\factory_util::safe_delete_targetname("sat_automated_bridge_left_org");
  maps\factory_util::safe_delete_noteworthy("sat_cleanup_object");
  maps\factory_util::safe_delete_noteworthy("sat_shoot_pos");

  if(!isDefined(var_0))
    common_scripts\utility::flag_wait("ambush_triggered");

  thread delete_jumpsuits();
  maps\factory_util::safe_delete_targetname("sat_rod_tube_01_cover");
  maps\factory_util::safe_delete_targetname("sat_rod_tube_02_cover");
  maps\factory_util::safe_delete_noteworthy("sliding_door_sat_enter_02");
  maps\factory_util::safe_delete_noteworthy("sliding_door_sat_exit_01");
  maps\factory_util::safe_delete_noteworthy("sliding_door_sat_exit_02");
  maps\factory_util::safe_delete_noteworthy("sliding_door_sat_enter_01");
}

delete_jumpsuits() {
  var_0 = getEntArray("interactive_oilrig_jumpsuit", "targetname");

  foreach(var_2 in var_0) {
    var_2 notify("stop_scripts");

    if(isDefined(var_2.target)) {
      var_3 = getEntArray(var_2.target, "targetname");

      foreach(var_5 in var_3)
      var_5 delete();
    }

    var_2 delete();
  }
}

setup_assembly_room_door() {
  var_0 = getent("factory_assembly_room_door", "targetname");
  var_1 = getent("reveal_room_exit_door_connector", "targetname");
  var_1 linkto(var_0);
  var_0.connector = var_1;
  level.assembly_room_door = var_0;
  thread maps\factory_fx::fx_show_hide("assembly_cardreader_lock", "assembly_cardreader_unlock");
  maps\_utility::stop_exploder("assembly_cardreader_unlock");
  common_scripts\utility::exploder("assembly_cardreader_lock");
}

sat_cpu_cover(var_0) {
  maps\factory_util::safe_delete_targetname("sat_cpu_cover");
}

sat_automated_bridge() {
  var_0 = getent("sat_automated_bridge_right_org", "targetname");
  var_1 = getEntArray("sat_automated_bridge_right", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(var_0);

  thread sat_automated_bridge_struts();
  var_0 rotatepitch(80, 5);
  common_scripts\utility::flag_wait("sat_drawbridge_up");
  var_0 rotatepitch(-80, 6);
  thread maps\factory_audio::sfx_bridge_lower(var_0);
  wait 4.0;
  common_scripts\utility::flag_set("sat_room_bridge_down");
  common_scripts\utility::flag_wait("sat_room_exiting");
  maps\factory_util::safe_delete(var_0);
}

sat_automated_bridge_struts() {
  var_0 = getent("sat_automated_bridge_right_struts_org", "targetname");
  var_1 = getEntArray("sat_automated_bridge_right_lifts", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(var_0);

  common_scripts\utility::flag_wait("sat_drawbridge_up");
}

sat_interact_activate_hint(var_0, var_1, var_2) {
  level endon(var_1);

  if(isDefined(var_2))
    wait(var_2);

  var_3 = getsticksconfig();

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    if(var_3 == "thumbstick_southpaw" || var_3 == "thumbstick_legacy")
      var_4 = var_0["gamepad_l"];
    else
      var_4 = var_0["gamepad"];
  } else if(var_3 == "thumbstick_southpaw" || var_3 == "thumbstick_legacy")
    var_4 = var_0["hint_l"];
  else
    var_4 = var_0["hint"];

  level.player thread maps\_utility::display_hint(var_4);

  for(;;) {
    wait 5.0;
    level.player thread maps\_utility::display_hint(var_4);
  }
}

sat_room_move_pieces() {
  var_0 = getent("satellite_room_nosecone_org", "targetname");
  var_1 = getent("satellite_room_vert1_org", "targetname");
  var_2 = getent("satellite_room_rog_holder_org", "targetname");
  var_3 = getent("satellite_room_rog_rack_system_org", "targetname");
  var_4 = getent("satellite_ROG_01_org", "targetname");
  var_5 = getent("satellite_ROG_02_org", "targetname");
  var_6 = getent("satellite_ROG_03_org", "targetname");
  var_7 = getent("satellite_ROG_04_org", "targetname");
  var_8 = getent("satellite_ROG_05_org", "targetname");
  var_9 = getent("satellite_ROG_06_org", "targetname");
  var_10 = getent("satellite_room_dest_org", "targetname");
  var_11 = getEntArray(var_0.target, "targetname");

  foreach(var_13 in var_11)
  var_13 linkto(var_0);

  var_15 = getEntArray(var_1.target, "targetname");

  foreach(var_13 in var_15)
  var_13 linkto(var_1);

  var_18 = getEntArray(var_2.target, "targetname");

  foreach(var_13 in var_18)
  var_13 linkto(var_2);

  var_21 = getEntArray(var_3.target, "targetname");

  foreach(var_13 in var_21)
  var_13 linkto(var_3);

  var_24 = getEntArray(var_4.target, "targetname");

  foreach(var_13 in var_24)
  var_13 linkto(var_4);

  var_27 = getEntArray(var_5.target, "targetname");

  foreach(var_13 in var_27)
  var_13 linkto(var_5);

  var_30 = getEntArray(var_6.target, "targetname");

  foreach(var_13 in var_30)
  var_13 linkto(var_6);

  var_33 = getEntArray(var_7.target, "targetname");

  foreach(var_13 in var_33)
  var_13 linkto(var_7);

  var_36 = getEntArray(var_8.target, "targetname");

  foreach(var_13 in var_36)
  var_13 linkto(var_8);

  var_39 = getEntArray(var_9.target, "targetname");

  foreach(var_13 in var_39)
  var_13 linkto(var_9);

  var_42 = getEntArray(var_10.target, "targetname");

  foreach(var_13 in var_42)
  var_13 linkto(var_10);

  var_5 linkto(var_4);
  var_6 linkto(var_5);
  var_7 linkto(var_6);
  var_8 linkto(var_7);
  var_9 linkto(var_8);
  var_3 linkto(var_2);
  var_1 moveto((var_10.origin[0], var_1.origin[1], var_1.origin[2]), 1);
  var_2 moveto((var_10.origin[0], var_2.origin[1], var_2.origin[2]), 1);
  var_4 moveto((var_10.origin[0], var_4.origin[1], var_4.origin[2]), 1);
  var_0 movez(205, 20, 0, 6);
  wait 5;
  thread maps\factory_audio::sfx_rods_move();
  var_2 moveto((var_4.origin[0], var_4.origin[1], var_10.origin[2]), 10, 0, 3);
  var_4 moveto((var_4.origin[0], var_4.origin[1], var_10.origin[2]), 10, 0, 3);
  wait 6;
  var_1 moveto((var_10.origin[0], var_10.origin[1] + 130, var_1.origin[2]), 10, 0, 3);
  var_2 moveto((var_10.origin[0], var_10.origin[1] + 130, var_10.origin[2]), 10, 0, 3);
  var_4 moveto((var_10.origin[0], var_10.origin[1] + 130, var_10.origin[2]), 10, 0, 3);
  var_2 waittill("movedone");
  thread maps\factory_audio::sfx_rods_hallway_stop();
  wait 1;
  thread maps\factory_audio::sfx_rods_load();
  var_3 unlink();
  var_45 = var_5.origin[1] - var_4.origin[1];
  var_3 moveto((var_3.origin[0], var_4.origin[1] + var_45, var_3.origin[2]), 3, 0.3, 0.3);
  var_3 waittill("movedone");
  rog_move_and_rotate(var_4, var_5, var_4, var_3, var_45, var_10);
  rog_move_and_rotate(var_5, var_6, var_4, var_3, var_45, var_10);
  rog_move_and_rotate(var_6, var_7, var_4, var_3, var_45, var_10);
  rog_move_and_rotate(var_7, var_8, var_4, var_3, var_45, var_10);
  rog_move_and_rotate(var_8, undefined, var_4, var_3, var_45, var_10);
  wait 1;
  var_9 unlink();
  var_9 linkto(var_3);
  var_3 unlink();
  var_3 moveto((var_3.origin[0], var_9.origin[1] + var_45 * 2, var_3.origin[2]), 3, 0.3, 0.3);
  var_3 waittill("movedone");
  var_3 linkto(var_2);
  var_1 moveto((var_1.origin[0], var_1.origin[1] + var_45 * 2, var_1.origin[2]), 10, 3, 3);
  var_2 moveto((var_2.origin[0], var_2.origin[1] + var_45 * 2, var_2.origin[2] - var_45), 10, 3, 3);
  common_scripts\utility::flag_wait("player_used_computer");
  var_46 = getEntArray("satellite_room_moving_parts", "script_noteworthy");

  foreach(var_48 in var_46) {
    if(isDefined(var_48))
      var_48 delete();
  }
}

rog_move_and_rotate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_3 linkto(var_0);
  var_0 moveto((var_5.origin[0], var_5.origin[1], var_5.origin[2]), 3, 0.3, 0.3);
  var_0 waittill("movedone");

  if(isDefined(var_1)) {
    var_1 unlink();
    var_3 unlink();
    var_3 moveto((var_3.origin[0], var_1.origin[1] + var_4, var_3.origin[2]), 3, 0.3, 0.3);
    wait 1;

    if(var_2 != var_0)
      var_0 linkto(var_2);
    else
      var_5 linkto(var_2);

    var_2 rotateyaw(-72, 3, 0.5, 0.5);
    var_2 waittill("rotatedone");
  }
}