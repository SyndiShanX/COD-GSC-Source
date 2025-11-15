/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_interior_nvg.gsc
*******************************************/

clockwork_interior_nvg_pre_load() {
  common_scripts\utility::flag_init("start_nvg_guy_anims");
  common_scripts\utility::flag_init("lights_out");
  common_scripts\utility::flag_init("garage_fail_done");
  common_scripts\utility::flag_init("nvg_light_on");
  common_scripts\utility::flag_init("nvg_go_go_go");
  common_scripts\utility::flag_init("inside_clear");
  common_scripts\utility::flag_init("entry_clear");
  common_scripts\utility::flag_init("halls_clear");
  common_scripts\utility::flag_init("security_complete");
  common_scripts\utility::flag_init("into_hall");
  common_scripts\utility::flag_init("FLAG_eyes_and_ears_complete");
  common_scripts\utility::flag_init("FLAG_start_hacking");
  common_scripts\utility::flag_init("nvg_halls_flashlight2");
  common_scripts\utility::flag_init("nvg_halls2_dead");
  common_scripts\utility::flag_init("insideb_clear");
  common_scripts\utility::flag_init("nvgs_on");
  common_scripts\utility::flag_init("NVG_player_runs_ahead");
  common_scripts\utility::flag_init("nvg_enemies_provoked");
  common_scripts\utility::flag_init("start_garage_ambience");
  common_scripts\utility::flag_init("start_closing_vault_door");
  common_scripts\utility::flag_init("lights_out_approach");
  common_scripts\utility::flag_init("camera_track_player");
  common_scripts\utility::flag_init("player_in_garage");
  common_scripts\utility::flag_init("entry_guard_anims");
  common_scripts\utility::flag_init("security_room_b_anims");
  common_scripts\utility::flag_init("security_room_anims");
  common_scripts\utility::flag_init("garage_enemies_provoked");
  common_scripts\utility::flag_init("intro_spotlight");
  common_scripts\utility::flag_init("FLAG_player_getout_jeep");
  common_scripts\utility::flag_init("FLAG_player_leave_garage");
  common_scripts\utility::flag_init("power_out_failsafe");
  common_scripts\utility::flag_init("lights_off");
  common_scripts\utility::flag_init("player_in_garage2");
  common_scripts\utility::flag_init("interior_start_point");
  common_scripts\utility::flag_init("FLAG_blackout_enemy3");
  common_scripts\utility::flag_init("entry_guard_anims_scripted");
  common_scripts\utility::flag_init("bo_buddies45_dead");
  common_scripts\utility::flag_init("bo_buddies3_dead");
  common_scripts\utility::flag_init("entry_clear");
  common_scripts\utility::flag_init("vault_closed");
  maps\_utility::precache("viewmodel_NVG");
  precachemodel("generic_prop_raven");
  precachemodel("weapon_p226");
  precachemodel("machinery_xray_scanner_bin_single");
  precachemodel("clk_metal_detector_wand");
  level.vault_damage_trigger = getent("kill_player_vaultdoor", "targetname");
  level.vault_damage_trigger common_scripts\utility::trigger_off();
}

setup_interior() {
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  maps\_utility::vision_set_changes("clockwork_garage", 0);
  thread init_tunnel();
  thread handle_tunnel_ambience();
  level.jeep = maps\_vehicle::spawn_vehicle_from_targetname("interior_jeep");
  level.jeep hidepart("back_door_left_jnt");
  wait 0.25;
  level.player_door = maps\_utility::spawn_anim_model("jeep_left_door");
  level.player_door linkto(level.jeep, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  level.allies[0].script_startingposition = 1;
  level.allies[1].script_startingposition = 0;
  level.allies[2].script_startingposition = 3;

  foreach(var_1 in level.allies)
  level.jeep thread maps\_vehicle_aianim::guy_enter(var_1);

  if(level.woof)
    maps\clockwork_code::link_dog_to_jeep(level.jeep);

  thread maps\clockwork_intro::exit_jeep_anims();
  common_scripts\utility::flag_set("FLAG_player_getout_jeep");
  common_scripts\utility::flag_set("interior_start_point");
  common_scripts\utility::flag_set("start_garage_ambience");
  common_scripts\utility::flag_set("jeep_intro_ride_done");
  thread maps\clockwork_intro::blackout_timer(41, & "CLOCKWORK_POWERDOWN", 0, 1);
  maps\clockwork_audio::checkpoint_interior();

  if(level.woof) {
    level.dog thread maps\ally_attack_dog::lock_player_control_until_flag("nvgs_on");
    level.dog maps\_utility::set_dog_walk_anim();
  }
}

init_tunnel() {
  level.tunnel_door_scene = getent("lights_out_scene", "targetname");
  level.tunnel_door = maps\_utility::spawn_anim_model("vault_door");
  level.tunnel_door_scene thread maps\_anim::anim_first_frame_solo(level.tunnel_door, "tunnel_vault");
  level.tunnel_door_clip = getent("entrance_door_clip", "targetname");
  level.tunnel_door_clip linkto(level.tunnel_door);
  common_scripts\utility::flag_wait("start_closing_vault_door");
  thread turn_on_vault_damage();
  thread maps\clockwork_audio::entry_door_close();
  level.tunnel_door_scene thread maps\_anim::anim_single_solo(level.tunnel_door, "tunnel_vault");
  thread flag_set_turn_off_garage_failsafe();
  level.tunnel_door thread disconnect_paths_at_end_anim(level.tunnel_door_clip);
  common_scripts\utility::flag_wait("power_out_failsafe");
  var_0 = getEntArray("player_in_garage", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(level.player istouching(var_3))
      var_1 = 1;
  }

  if(isDefined(var_1))
    thread mission_failed_garage();

  var_5 = undefined;

  foreach(var_3 in var_0) {
    if(level.allies[0] istouching(var_3) || level.allies[1] istouching(var_3) || level.allies[2] istouching(var_3))
      var_5 = 1;
  }

  if(isDefined(var_5))
    thread mission_failed_garage();

  common_scripts\utility::flag_set("garage_fail_done");
}

flag_set_turn_off_garage_failsafe() {
  wait 21;
  maps\_utility::disable_trigger_with_targetname("TRIG_inside_entrance");
  common_scripts\utility::flag_set("inside_entrance");
}

cleanup_garage_guys() {
  if(isDefined(level.interior_guards)) {
    foreach(var_1 in level.interior_guards) {
      if(isDefined(var_1) && isalive(var_1))
        var_1 delete();
    }
  }

  if(isDefined(level.exterior_guards)) {
    foreach(var_1 in level.exterior_guards) {
      if(isDefined(var_1) && isalive(var_1))
        var_1 delete();
    }
  }

  var_1 = level.nvg_moment_guardsb[2];

  if(isDefined(var_1) && isalive(var_1))
    var_1 delete();
}

turn_on_vault_damage() {
  wait 24;
  level.vault_damage_trigger common_scripts\utility::trigger_on();
  wait 10;
  level.vault_damage_trigger common_scripts\utility::trigger_off();
}

disconnect_paths_at_end_anim(var_0) {
  self waittillmatch("single anim", "end");
  var_0 disconnectpaths();
  level notify("vault_closed");
  common_scripts\utility::flag_set("vault_closed");
  thread cleanup_garage_guys();
}

mission_failed_garage() {
  setdvar("ui_deadquote", & "CLOCKWORK_QUOTE_KEEP_UP");
  maps\_utility::missionfailedwrapper();
}

mission_failed_garage_provoke() {
  setdvar("ui_deadquote", & "CLOCKWORK_QUOTE_COMPROMISE");
  maps\_utility::missionfailedwrapper();
}

begin_interior() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");

  if(level.woof)
    thread handle_dog_interior();

  var_0 = common_scripts\utility::array_combine(getEntArray("chaos_decals", "targetname"), getEntArray("chaos_decals1", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals2", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals_delete", "targetname"));

  foreach(var_2 in var_0)
  var_2 hide();

  thread handle_blackout();
  thread control_nvg_lightmodels();
  thread maps\clockwork_code::blend_movespeedscale_custom(26, 0.25);
  level.player allowsprint(0);
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::cool_walk, 1);
  level.allies[0].animname = "baker";
  level.allies[0] maps\_utility::set_run_anim("walk_gun_unwary");
  level.allies[1].animname = "keegan";
  level.allies[1] maps\_utility::set_run_anim("walk_gun_unwary");
  level.allies[2].animname = "cipher";
  level.allies[2] maps\_utility::set_run_anim("walk_gun_unwary");

  foreach(var_5 in level.allies) {
    var_5.no_pistol_switch = 1;
    var_5.dontmelee = 1;
  }

  wait 2;

  if(getdvar("clockwork_disable_bad_vo", "0") == "0") {
    var_7 = maps\_utility::get_closest_ai(level.player.origin, "axis");
    var_7 maps\clockwork_code::char_dialog_add_and_go("clockwork_spg1_heyyoucantpark");
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_wewontbelong");
  }

  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("nvgs_on");

  foreach(var_9 in level.allies) {
    var_9.old_baseaccuracy = var_9.baseaccuracy;
    var_9 maps\_utility::set_baseaccuracy(500);
  }

  wait 1;
  thread hacking_eyes_and_ears();
  common_scripts\utility::flag_wait_any("at_vault_door", "FLAG_eyes_and_ears_complete");

  foreach(var_9 in level.allies) {
    var_9.baseaccuracy = var_9.old_baseaccuracy;
    var_9.disableplayeradsloscheck = 0;
  }
}

handle_tunnel_ambience() {
  common_scripts\utility::flag_wait("start_garage_ambience");
  thread player_inside_nvg_area();
  maps\_utility::array_spawn_function_noteworthy("tunnel_wave_guy", ::wave_anim);
  thread handle_nvg_guards();
  thread garage_player_fired_gun();
  var_0 = maps\clockwork_code::array_spawn_targetname_allow_fail("tunnel_guard_patrol");
  var_1 = maps\clockwork_code::array_spawn_targetname_allow_fail("idle_guys");

  foreach(var_3 in var_0) {
    if(var_3.type == "dog") {
      var_3.animname = "generic";
      var_3 maps\_utility::set_run_anim("iw6_dog_walk");
      var_3 maps\_utility::disable_turnanims();
      var_3.team = "axis";
      continue;
    }

    var_3.disablearrivals = 1;
    var_3.disableexits = 1;
    var_3.animname = "generic";
    var_3 maps\_utility::set_run_anim("walk_gun_unwary");
    var_3 thread garage_alert_handle();
  }

  foreach(var_3 in var_1) {
    if(var_3.type == "dog") {
      var_3.team = "axis";
      continue;
    }

    var_3 thread tunnel_idle_guys();
  }

  level.interior_guards = common_scripts\utility::array_combine(var_0, var_1);
  thread failcase_garage(level.interior_guards);
  wait 1;
  var_7 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(240);
  common_scripts\utility::waitframe();
  wait 1;
  var_8 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(241);
}

tunnel_idle_guys() {
  if(isDefined(self.animation)) {
    self.animname = "generic";
    self.allowdeath = 1;
    thread maps\_anim::anim_generic_loop(self, self.animation, "end_generic_loop");
  }
}

wave_anim() {
  level endon("garage_enemies_provoked");
  var_0 = common_scripts\utility::getstruct("tunnel_wave", "targetname");
  self.animname = "generic";
  var_0 maps\_anim::anim_reach_solo(self, "tunnel_wave");
  self.scene = var_0;

  if(isDefined(self) && isalive(self)) {
    var_0 thread maps\_anim::anim_loop_solo(self, "tunnel_wave", "stop_loop");
    self.allowdeath = 1;
    self.ignoreme = 1;
  }
}

camera_track_player() {
  var_0 = 0.5;
  var_1 = getent("sec_cam_track", "targetname");
  var_1.angles = (var_1.angles[0], var_1.angles[1], 0);

  while(common_scripts\utility::flag("camera_track_player")) {
    wait 0.1;
    var_2 = vectortoangles(level.player.origin - var_1.origin) + (0, -90, 0);
    var_2 = (0, var_2[1], var_2[2]);
    var_1 rotateto(var_2, var_0, var_0 * 0.5, var_0 * 0.5);
  }
}

handle_nvg_guards() {
  level.nvg_recover_anim = [];
  level.nvg_recover_anim[0] = "nvg_recover_anim1";
  var_0 = getent("nvg_guy1", "targetname");
  var_1 = getent("nvg_guy2", "targetname");
  var_2 = getent("nvg_guy3", "targetname");
  var_3 = getent("nvg_guy4", "targetname");
  var_4 = getent("nvg_guy5", "targetname");
  var_5 = var_0 maps\_utility::spawn_ai();
  var_6 = var_1 maps\_utility::spawn_ai();
  var_7 = var_2 maps\_utility::spawn_ai();
  var_8 = var_3 maps\_utility::spawn_ai();
  var_9 = var_4 maps\_utility::spawn_ai();
  level.nvg_moment_guardsa[0] = var_5;
  level.nvg_moment_guardsa[1] = var_6;
  level.nvg_moment_guardsb[0] = var_7;
  level.nvg_moment_guardsb[1] = var_8;
  level.nvg_moment_guardsb[2] = var_9;
  var_10 = 1;

  foreach(var_12 in level.nvg_moment_guardsa) {
    var_12.animname = "nvg_guy" + var_10;
    var_12 maps\_utility::set_allowdeath(1);
    var_12.dontdropweapon = 1;
    var_10++;
  }

  var_14 = 3;

  foreach(var_12 in level.nvg_moment_guardsb) {
    var_12.animname = "nvg_guy" + var_14;
    var_12 maps\_utility::set_allowdeath(1);
    var_12.dontdropweapon = 1;
    var_14++;
  }

  maps\_utility::array_spawn_function_targetname("entry_guards", ::blackout_loop_anims, "entry_guard_anims");
  maps\_utility::array_spawn_function_targetname("nvg_security_room_b", ::blackout_loop_anims, "security_room_b_anims");
  maps\_utility::array_spawn_function_targetname("nvg_security_room_b1", ::blackout_loop_anims, "security_room_b_anims");
  maps\_utility::array_spawn_function_targetname("nvg_security_room", ::blackout_loop_anims, "security_room_anims");
  thread blackout_enemy3();
  thread blackout_enemy45();
  var_17 = maps\clockwork_code::array_spawn_targetname_allow_fail("entry_guards");
  var_18 = maps\_utility::spawn_targetname("entry_guards_scripted1");
  var_19 = maps\_utility::spawn_targetname("entry_guards_scripted2");
  var_18 maps\_utility::disable_long_death();
  var_19 maps\_utility::disable_long_death();
  thread blackout_enemy1and2_react_anims(var_18, var_19);
  var_20 = common_scripts\utility::array_combine(level.nvg_moment_guardsa, level.nvg_moment_guardsb);
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_20, var_20.size, "nvg_go_go_go");
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_17, var_17.size, "security_room_b_anims");
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_20, var_20.size - 1, "entry_guard_anims");
  common_scripts\utility::array_thread(var_20, maps\_utility::disable_long_death);
  thread nvg_animted_scene(var_20);
  thread handle_lower_flashlight_guys();
  common_scripts\utility::flag_wait("lights_out");

  foreach(var_12 in level.allies) {
    var_12 maps\_utility::forceuseweapon("cz805bren+reflex_sp+silencer_sp", "primary");
    var_12.no_pistol_switch = undefined;
    var_12.dontmelee = undefined;
    var_12 pushplayer(0);
  }

  var_23 = maps\clockwork_code::array_spawn_targetname_allow_fail("nvg_security_room_b");
  var_24 = maps\clockwork_code::array_spawn_targetname_allow_fail("nvg_security_room_b1");
  var_25 = maps\clockwork_code::array_spawn_targetname_allow_fail("nvg_security_room");
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_25, var_25.size, "inside_clear");
  maps\clockwork_code::blend_movespeedscale_custom(90, 1);
  level notify("starting_new_player_dyn_move");
  common_scripts\utility::flag_wait("nvgs_on");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_cleanhouse");
  wait 1.25;
  thread maps\clockwork_code::attack_targets(level.allies, level.nvg_moment_guardsa, 0.2, 0.5, 1);
  wait 0.25;
  thread maps\clockwork_code::attack_targets(level.allies, level.nvg_moment_guardsb, 0.2, 0.5, 1);
  wait 0.75;
  maps\clockwork_code::safe_activate_trigger_with_targetname("nvg_go_go_go");

  foreach(var_27 in level.allies)
  var_27 maps\_utility::enable_ai_color();

  var_29 = common_scripts\utility::add_to_array(var_17, var_18);
  var_30 = common_scripts\utility::add_to_array(var_29, var_19);
  wait 2;
  thread maps\clockwork_code::attack_targets(level.allies, var_30, 0.8, 1.1, 1);
  maps\_utility::waittill_aigroupcleared("nvg_grp_lower");
  maps\clockwork_code::safe_activate_trigger_with_targetname("nvg_go_go_go2");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_roomclear");
  wait 1.2;
  maps\clockwork_code::attack_targets(level.allies, var_23, 0.85, 1, 1);
  common_scripts\utility::flag_wait("attack_insideb");
  maps\clockwork_code::attack_targets(level.allies, var_24, 0.85, 1, 1);
  common_scripts\utility::flag_wait_or_timeout("insideb_clear", 1);
  var_31 = [];
  var_31[0] = level.bo_enemy3;
  var_31[1] = level.bo_enemy4;
  var_31[2] = level.bo_enemy5;
  maps\clockwork_code::attack_targets(level.allies, var_31, 0.75, 1, 1);
  maps\clockwork_code::attack_targets(level.allies, var_25, 0.75, 1, 1);

  foreach(var_27 in level.allies)
  var_27.ignoreall = 0;

  common_scripts\utility::flag_wait("security_complete");

  foreach(var_12 in level.allies) {
    var_12.ignoresuppression = 0;
    var_12.ignorerandombulletdamage = 0;
    var_12.ignoreexplosionevents = 0;
    var_12.disablebulletwhizbyreaction = 0;
    var_12.disablefriendlyfirereaction = 0;
  }
}

handle_lower_flashlight_guys() {
  common_scripts\utility::flag_wait("nvg_halls_flashlight2");
  maps\_utility::array_spawn_function_targetname("nvg_halls_flashlight2", ::attach_flashlight);
  maps\_utility::array_spawn_function_targetname("nvg_halls_flashlight2", ::one_hit_kill);
  var_0 = maps\clockwork_code::array_spawn_targetname_allow_fail("nvg_halls_flashlight2");
  common_scripts\utility::flag_wait("nvg_halls2_dead");
  wait 1;
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_clear");
}

handle_lights_out_approach() {
  level endon("blackout_early");
  level endon("garage_enemies_provoked");
  var_0 = getent("lights_out_scene", "targetname");
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cipher";

  foreach(var_2 in level.allies)
  var_2 maps\_utility::disable_ai_color();

  level.allies[0] thread reach_and_play_anim("merrick_start_lights_out", var_0, 0.5);
  level.allies[1] thread reach_and_play_anim("keegan_start_lights_out", var_0, 1);
  level.allies[2] thread reach_and_play_anim("hesh_start_lights_out", var_0, 1.25);
}

reach_and_play_anim(var_0, var_1, var_2) {
  level endon("blackout_early");
  level endon("garage_enemies_provoked");
  var_3 = common_scripts\utility::getstruct(var_0, "targetname");

  if(isDefined(var_3))
    maps\_utility::follow_path(var_3);

  var_1 maps\_anim::anim_reach_solo(self, "lights_out_approach");
  var_1 thread maps\_anim::anim_single_solo(self, "lights_out_approach");
  common_scripts\utility::flag_wait("allies_prep_lightsout");

  foreach(var_5 in level.allies) {
    maps\_utility::enable_ai_color();
    self.alertlevel = "alert";
  }

  self setgoalpos(self.origin);
  var_1 maps\_anim::anim_single_solo(self, "lights_out_breakout");
}

nvg_animted_scene(var_0) {
  var_1 = getent("lights_out_scene", "targetname");
  level.override_dog_enemy = var_0[1];

  foreach(var_3 in var_0) {
    var_3.animated_scene = "lights_out";
    var_3.animated_scene_org = var_1;
  }

  var_5 = maps\_utility::spawn_anim_model("nvg_bin_joint", var_1.origin);
  var_6 = maps\_utility::spawn_anim_model("nvg_bin", var_1.origin);
  var_7 = maps\_utility::spawn_anim_model("weapon_p226", var_1.origin);
  var_6 linkto(var_5, "J_prop_1");
  var_7 linkto(var_5, "J_prop_2");
  var_5 thread bin_failsafe(var_6, var_7);
  var_0[0] maps\_utility::gun_remove();
  var_0[2] maps\_utility::gun_remove();
  var_8 = spawn("script_model", (0, 0, 0));
  var_8 setModel("clk_metal_detector_wand");
  var_8 linkto(var_0[3], "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
  var_1 thread maps\_anim::anim_first_frame(var_0, "lights_out");
  var_1 thread maps\_anim::anim_first_frame_solo(var_5, "bin_joint");
  common_scripts\utility::flag_wait("start_nvg_guy_anims");
  var_1 thread maps\_anim::anim_single(var_0, "lights_out");
  var_1 thread maps\_anim::anim_single_solo(var_5, "bin_joint");
  thread maps\clockwork_audio::security_beeps();
  thread delete_wand_at_lights_out(var_8);
  common_scripts\utility::flag_wait("explosion_start");

  if(isDefined(var_8))
    var_8 delete();

  if(isDefined(var_6))
    var_6 delete();
}

delete_wand_at_lights_out(var_0) {
  common_scripts\utility::flag_wait("lights_out");

  if(isDefined(var_0))
    var_0 delete();
}

bin_failsafe(var_0, var_1) {
  level common_scripts\utility::waittill_any("blackout_early", "garage_enemies_provoked");
  maps\_utility::anim_stopanimscripted();
  var_2 = randomfloatrange(10, 100);
  var_3 = vectornormalize(var_0.origin - 1 - var_0.origin);
  var_0 unlink();
  var_0 physicslaunchclient(var_0.origin, var_3 * var_2);
  var_4 = vectornormalize(var_1.origin - 1 - var_1.origin);
  var_1 unlink();
  var_1 physicslaunchclient(var_1.origin, var_3 * var_2);
}

cool_walk_at_end_of_anim(var_0) {
  foreach(var_2 in var_0)
  var_2 thread waittillend_of_anim_set_walk();
}

waittillend_of_anim_set_walk() {
  self endon("death");
  self endon("lights_out");
  self waittillmatch("single anim", "end");
  set_cool_walk();
}

set_cool_walk() {
  self.disablearrivals = 1;
  self.disableexits = 1;
  maps\clockwork_code::set_run_anim_ref(level.scr_anim["generic"]["walk_gun_unwary"]);
}

blackout_loop_anims(var_0) {
  self endon("death");
  self.health = 1;
  common_scripts\utility::flag_wait("lights_out");
  wait 0.2;

  if(isDefined(self) && isalive(self)) {
    self.animname = "generic";
    self.allowdeath = 1;
    thread maps\_anim::anim_generic_loop(self, "nvg_recover_anim1", "recover_stop_loop");
    thread nvg_blackout_anims(var_0);
  }
}

nvg_blackout_anims(var_0) {
  var_1 = getent("lights_out_scene", "targetname");
  self endon("death");

  if(isDefined(self) && isalive(self)) {
    if(!isDefined(self.script_noteworthy))
      common_scripts\utility::flag_wait(var_0);

    if(isDefined(self.script_noteworthy) && !(self.script_noteworthy == "blackout_blind_fire_pistol"))
      common_scripts\utility::flag_wait(var_0);
  } else
    return;

  self notify("recover_stop_loop");
  waittillframeend;
  self.allowdeath = 1;

  if(isDefined(self) && isalive(self)) {
    if(isDefined(self.animation)) {
      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "blackout_blind_fire_pistol")
        thread maps\_anim::anim_loop_solo(self, self.animation);
      else
        thread maps\_anim::anim_generic(self, self.animation);
    }

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "blackout_blind_fire_pistol") {
      common_scripts\utility::flag_wait(var_0);
      thread shoot_loop();
    }

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "security_room_guys")
      thread shoot_loop();
  }
}

guy_setup_for_blackout() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self notify("recover_stop_loop");
  self.animname = "generic";
  self.allowdeath = 1;
  self.ignoreall = 1;
  maps\_utility::disable_long_death();
}

blackout_enemy1and2_react_anims(var_0, var_1) {
  common_scripts\utility::flag_wait("lights_out");
  var_2 = getent("lights_out_scene", "targetname");
  var_3 = maps\_utility::spawn_anim_model("bo_alerted_door_jt", var_2.origin);
  level.bo_alerted_door = maps\_utility::spawn_anim_model("bo_alerted_door", var_2.origin);
  level.bo_alerted_door linkto(var_3, "J_prop_1");
  thread delete_during_chaos(level.bo_alerted_door);
  var_2 thread maps\_anim::anim_first_frame_solo(var_3, "alerted_door_joint");
  var_0 guy_setup_for_blackout();
  var_1 guy_setup_for_blackout();
  var_0 thread nvg_run_and_trip_guy(var_2);
  nvg_wait_for_flags_or_timeout("NVG_player_runs_ahead", "nvg_enemies_provoked", 5);

  if(isDefined(var_1) && isalive(var_1)) {
    var_2 thread maps\_anim::anim_single_solo(var_1, "clockwork_nvg_hallway_alerted_enemy2");
    var_2 thread maps\_anim::anim_single_solo(var_3, "alerted_door_joint");
  }
}

delete_during_chaos(var_0) {
  common_scripts\utility::flag_wait("defend_finished");

  if(isDefined(var_0))
    var_0 delete();
}

nvg_run_and_trip_guy(var_0) {
  wait 3;

  if(isDefined(self) && isalive(self))
    var_0 thread maps\_anim::anim_single_solo(self, "clockwork_nvg_hallway_run_and_trip_enemy1");
}

nvg_wait_for_flags_or_timeout(var_0, var_1, var_2) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait(var_2);
}

blackout_enemy3() {
  var_0 = getent("lights_out_scene", "targetname");
  common_scripts\utility::flag_wait("FLAG_blackout_enemy3");
  var_1 = getent("nvg_security_room_enemy3", "targetname");
  level.bo_enemy3 = var_1 maps\_utility::spawn_ai(1);
  level.bo_enemy3.animname = "generic";
  level.bo_enemy3.allowdeath = 1;
  var_2 = maps\_utility::spawn_anim_model("bo_grope_door_jt", var_0.origin);
  var_3 = maps\_utility::spawn_anim_model("bo_grope_door", var_0.origin);
  var_3 linkto(var_2, "J_prop_1");
  var_0 thread maps\_anim::anim_single_solo(var_2, "bo_grope_door_joint");
  var_0 thread maps\_anim::anim_single_solo(level.bo_enemy3, "clockwork_nvg_hallway_grope_enemy3");
  wait 0.1;
  var_4 = getent("door3_enemy_clip", "targetname");
  var_4 linkto(var_3);
  common_scripts\utility::flag_wait_or_timeout("bo_buddies3_dead", 3);

  if(isDefined(level.bo_enemy3) && isalive(level.bo_enemy3))
    maps\clockwork_code::attack_targets(level.allies, maps\_utility::make_array(level.bo_enemy3), 0.3, 0.4, 1);
}

blackout_enemy45() {
  var_0 = getent("lights_out_scene", "targetname");
  common_scripts\utility::flag_wait("FLAG_blackout_enemy45");
  var_1 = getent("nvg_security_room_enemy4", "targetname");
  level.bo_enemy4 = var_1 maps\_utility::spawn_ai(1);
  level.bo_enemy4.animname = "generic";
  level.bo_enemy4.allowdeath = 1;
  var_0 thread maps\_anim::anim_single_solo(level.bo_enemy4, "clockwork_nvg_hallway_buddies_enemy4");
  var_1 = getent("nvg_security_room_enemy5", "targetname");
  level.bo_enemy5 = var_1 maps\_utility::spawn_ai(1);
  level.bo_enemy5.allowdeath = 1;
  level.bo_enemy5.animname = "generic";
  var_0 thread maps\_anim::anim_single_solo(level.bo_enemy5, "clockwork_nvg_hallway_buddies_enemy5");
  common_scripts\utility::flag_wait_or_timeout("bo_buddies45_dead", 6);

  if(isDefined(level.bo_enemy4) && isalive(level.bo_enemy4))
    maps\clockwork_code::attack_targets(level.allies, maps\_utility::make_array(level.bo_enemy4), 0.3, 0.4, 1);

  if(isDefined(level.bo_enemy5) && isalive(level.bo_enemy5))
    maps\clockwork_code::attack_targets(level.allies, maps\_utility::make_array(level.bo_enemy5), 0.3, 0.4, 1);
}

shoot_loop() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(0.2, 1));

    if(self.weapon == "none") {
      return;
    }
    self shootblank();
    wait(randomfloatrange(0.3, 1.3));

    if(self.weapon == "none") {
      return;
    }
    self shootblank();
  }
}

attach_flashlight() {
  playFXOnTag(level._effect["flashlight"], self, "tag_flash");
  self.have_flashlight = 1;
}

one_hit_kill() {
  self.health = 1;
}

lights_out_soldier_vo(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_goingon");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru2_comebackon");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_yurisfault");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru2_almostover");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_youdoing");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru2_whatishappening");
}

nvg_ally_vo() {
  common_scripts\utility::flag_wait("nvgs_on");
  wait 1;
  maps\clockwork_code::killtimer();
  common_scripts\utility::flag_wait("nvg_go_go_go");
  wait 0.5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_go");
  common_scripts\utility::flag_wait("entry_clear");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_donthavemuchtime");
  common_scripts\utility::flag_wait("inside_clear");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_buginplace");
  common_scripts\utility::flag_wait("FLAG_start_hacking");
  common_scripts\utility::flag_wait("FLAG_eyes_and_ears_complete");
  common_scripts\utility::flag_set("security_complete");
  common_scripts\utility::flag_wait("nvg_halls_flashlight2");

  foreach(var_1 in level.allies) {
    var_1 maps\_utility::disable_pain();
    var_1 maps\_utility::disable_bulletwhizbyreaction();
  }

  wait 1;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_movementahead");
  common_scripts\utility::flag_wait("nvg_halls2_dead");

  foreach(var_1 in level.allies) {
    var_1 maps\_utility::enable_pain();
    var_1 maps\_utility::enable_bulletwhizbyreaction();
  }

  thread maps\clockwork_audio::hacking_music();
}

hacking_eyes_and_ears() {
  var_0 = common_scripts\utility::getstruct("scn_eyes_and_ears", "targetname");
  var_1 = getent("security_cipher_hack", "targetname");
  var_1.animname = "server";
  var_1 maps\_anim::setanimtree();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "eyes_and_ears");
  common_scripts\utility::flag_wait("inside_clear");
  var_2 = getaiarray("axis");
  common_scripts\utility::array_thread(var_2, maps\clockwork_code::die_quietly);

  foreach(var_4 in level.allies)
  var_4 maps\_utility::disable_cqbwalk();

  thread maps\_utility::autosave_by_name("eyes_and_ears");
  var_6 = maps\_utility::spawn_anim_model("bug_device_joint", var_0.origin);
  var_7 = maps\_utility::spawn_anim_model("bug_device", var_0.origin);
  var_7 linkto(var_6, "J_prop_1");
  var_7 hide();
  var_8 = maps\_utility::spawn_anim_model("bug_glowstick_joint", var_0.origin);
  var_9 = maps\_utility::spawn_anim_model("bug_glowstick", var_0.origin);
  var_9 linkto(var_8, "J_prop_1");
  var_9 hide();
  var_10 = [];
  var_10[0] = level.allies[2];
  var_10[1] = var_1;
  var_10[0].animname = "cipher";
  level.allies[0].animname = "baker";
  var_11 = maps\_utility::make_array(level.allies[0], level.allies[2]);
  var_0 maps\_anim::anim_reach_together(var_11, "eyes_and_ears");
  common_scripts\utility::flag_set("FLAG_start_hacking");
  var_9 show();
  var_7 show();
  var_0 thread maps\_anim::anim_single_solo(var_6, "bug_joint");
  var_0 thread maps\_anim::anim_single(var_10, "eyes_and_ears");
  var_0 thread maps\_anim::anim_single_solo(var_8, "glowstick_joint");
  var_0 thread maps\_anim::anim_single_solo(level.allies[0], "eyes_and_ears");
  thread maps\clockwork_audio::hacking();
  thread maps\clockwork_audio::glowstick_hacking();
  wait 3;
  thread pip_vo();
  common_scripts\utility::flag_wait("security_complete");
  var_10[0] maps\clockwork_code::show_dufflebag(1);
  common_scripts\utility::flag_set("FLAG_eyes_and_ears_complete");
  level.allies[2] maps\_utility::enable_ai_color();
  level.allies[0] maps\_utility::enable_ai_color();
  common_scripts\utility::flag_wait("explosion_start");

  if(isDefined(var_7))
    var_7 delete();

  if(isDefined(var_9))
    var_9 delete();

  if(isDefined(var_6))
    var_6 delete();

  if(isDefined(var_8))
    var_8 delete();
}

pip_vo() {
  common_scripts\utility::flag_wait("FLAG_checkcheck");
  level.player maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_check_2");
}

handle_blackout() {
  common_scripts\utility::flag_wait("lights_out");
  common_scripts\utility::exploder(260);
  common_scripts\utility::flag_set("tubelight_parking");
  common_scripts\utility::flag_set("cagelight");
  maps\_utility::stop_exploder(250);
  maps\_utility::stop_exploder(300);
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::cool_walk, 0);
  common_scripts\utility::array_thread(level.allies, maps\_utility::cqb_walk, "on");
  thread nvg_ally_vo();
  thread nvgs_on_blackout();
  thread lights_out_soldier_vo(level.nvg_moment_guardsb[1], level.nvg_moment_guardsb[0]);
  var_0 = getent("lights_out_scene", "targetname");
  common_scripts\utility::flag_wait("nvgs_on");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "seal");
  thread player_light();
  level.player allowsprint(1);
  level.player allowjump(1);
}

player_light() {
  if(level.xb3 || level.ps4) {
    level endon("death");
    var_0 = common_scripts\utility::spawn_tag_origin();
    playFXOnTag(level._effect["player_nvg_light"], var_0, "tag_origin");
    thread keep_track_of_nvg_light();

    while(!common_scripts\utility::flag("lights_on")) {
      if(common_scripts\utility::flag("nvg_light_on")) {
        var_0.angles = level.player getplayerangles();
        var_0.origin = level.player.origin + (0, 0, 64);
      } else
        var_0.origin = (0, 0, 0);

      wait 0.01;
    }

    var_0 delete();
  }
}

nvg_area_lights_on_fx() {
  common_scripts\utility::exploder(250);
  common_scripts\utility::exploder(301);
}

keep_track_of_nvg_light() {
  level endon("death");
  level.player notifyonplayercommand("nvg_toggle", "+actionslot 1");
  common_scripts\utility::flag_set("nvg_light_on");

  while(!common_scripts\utility::flag("lights_on")) {
    level.player waittill("night_vision_off");
    common_scripts\utility::flag_clear("nvg_light_on");
    level.player waittill("night_vision_on");
    common_scripts\utility::flag_set("nvg_light_on");
    wait 0.05;
  }
}

nvgs_on_blackout() {
  level endon("notify_nvgs_on");
  thread maps\clockwork_audio::power_down();
  maps\_utility::vision_set_changes("clockwork_lights_off", 0);
  visionsetnight("clockwork_night");
  common_scripts\utility::flag_set("lights_out");
  level.player enableweaponswitch();
  level.player setactionslot(1, "nightvision");
  level.player thread maps\_utility::display_hint("nvg");
  thread nvg_on_check();
  wait 3;
  thread maps\clockwork_code::nvg_goggles_on();
  level.player notify("player_cancel_hold_fire");
  common_scripts\utility::flag_set("nvgs_on");
}

nvg_on_check() {
  level endon("notify_nvgs_on");

  for(;;) {
    wait 0.1;

    if(isDefined(level.player.nightvision_enabled)) {
      common_scripts\utility::flag_set("nvgs_on");
      level.player notify("player_cancel_hold_fire");
      level notify("notify_nvgs_on");
      break;
    }
  }
}

nvg_alert_handle() {
  level endon("ready_nvgs");
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  common_scripts\utility::waittill_any("ai_event", "flashbang");
  common_scripts\utility::flag_set("nvg_enemies_provoked");
  maps\_utility::clear_run_anim();
  maps\_utility::anim_stopanimscripted();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self notify("stop_going_to_node");
  self setgoalpos(self.origin);
  maps\_utility::gun_recall();
}

garage_alert_handle() {
  self endon("player_in_nvg");
  self endon("death");
  self endon("garage_enemies_provoked");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  common_scripts\utility::waittill_any("ai_event", "flashbang");
  common_scripts\utility::flag_set("garage_enemies_provoked");
  level notify("garage_enemies_provoked");
}

garage_player_fired_gun() {
  level endon("player_in_nvg");
  level endon("garage_enemies_provoked");
  level.player waittill("weapon_fired");
  common_scripts\utility::flag_set("garage_enemies_provoked");
  level notify("garage_enemies_provoked");
}

nvg_area_player_fired_gun() {
  level endon("ready_nvgs");
  level.player waittill("weapon_fired");
  common_scripts\utility::flag_set("nvg_enemies_provoked");
}

failcase_blackout_early() {
  level endon("ready_nvgs");
  common_scripts\utility::flag_wait("nvg_enemies_provoked");

  foreach(var_1 in level.allies)
  var_1.old_disablearrivals = 0;

  level notify("blackout_early");
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_damncutitnow");

  foreach(var_1 in level.nvg_moment_guardsa) {
    if(isDefined(var_1)) {
      var_1 maps\_utility::clear_run_anim();
      var_1 maps\_utility::anim_stopanimscripted();
      var_1.ignoreme = 0;
      var_1.ignoreall = 0;
      var_1 notify("stop_going_to_node");
      var_1 setgoalpos(var_1.origin);
      var_1 maps\_utility::gun_recall();
    }
  }

  foreach(var_1 in level.nvg_moment_guardsb) {
    if(isDefined(var_1)) {
      var_1 maps\_utility::clear_run_anim();
      var_1 maps\_utility::anim_stopanimscripted();
      var_1.ignoreme = 0;
      var_1.ignoreall = 0;
      var_1 notify("stop_going_to_node");
      var_1 setgoalpos(var_1.origin);
      var_1 maps\_utility::gun_recall();
    }
  }

  foreach(var_1 in level.allies) {
    var_1 notify("stop_going_to_node");
    var_1 maps\_utility::clear_run_anim();
    var_1 maps\_utility::anim_stopanimscripted();
    var_1 maps\_utility::enable_cqbwalk();
    var_1 setgoalpos(var_1.origin);
    var_1 maps\_utility::enable_ai_color();
  }

  wait 1;
  maps\_utility::activate_trigger_with_targetname("nvg_provoked_colors");
  common_scripts\utility::flag_set("lights_out");
  common_scripts\utility::flag_set("lights_off");
  level.timer destroy();
}

failcase_garage(var_0) {
  level endon("vault_closed");
  level endon("player_in_nvg");
  common_scripts\utility::flag_wait("garage_enemies_provoked");
  thread garage_missionfail();
  thread alert_inside_guys_early();
  maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.allies[1] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_damnitrook");
  wait 0.25;

  foreach(var_2 in level.allies) {
    var_2 notify("stop_going_to_node");
    var_2 maps\_utility::clear_run_anim();
    var_2 maps\_utility::anim_stopanimscripted();
    var_2 maps\_utility::enable_cqbwalk();
    var_2.ignoreall = 0;
    var_2.ignoreme = 0;
  }

  wait 0.05;

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 maps\_utility::clear_run_anim();
      var_2.ignoreall = 0;
      var_2.ignoreme = 0;

      if(var_2.type == "dog") {
        continue;
      }
      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "tunnel_wave_guy" && isDefined(var_2.scene))
        var_2.scene notify("stop_loop");

      var_2 notify("stop_loop");
      var_2 maps\_utility::anim_stopanimscripted();
      var_2 notify("end_generic_loop");
      var_2 maps\_utility::gun_recall();
    }
  }
}

garage_missionfail() {
  wait 6;
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_abortmission");
  mission_failed_garage_provoke();
}

player_inside_nvg_area() {
  level endon("garage_enemies_provoked");
  common_scripts\utility::flag_wait("inside_entrance");
  level notify("player_in_nvg");
  thread nvg_area_player_fired_gun();
  thread failcase_blackout_early();

  foreach(var_1 in level.nvg_moment_guardsa) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 thread nvg_alert_handle();
  }

  foreach(var_1 in level.nvg_moment_guardsb) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 thread nvg_alert_handle();
  }
}

alert_inside_guys_early() {
  foreach(var_1 in level.nvg_moment_guardsa) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 thread nvg_alert_handle();
  }

  foreach(var_1 in level.nvg_moment_guardsb) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 thread nvg_alert_handle();
  }
}

control_nvg_lightmodels() {
  var_0 = getEntArray("nvg_lab_lights", "targetname");
  common_scripts\utility::flag_wait("lights_out");
  control_nvg_staticscreens_off();

  foreach(var_2 in var_0) {
    var_2.on_version = var_2.model;
    var_2 setModel(var_2.script_parameters);
  }

  common_scripts\utility::flag_wait("lights_on");
  control_nvg_staticscreens_on();

  foreach(var_2 in var_0)
  var_2 setModel(var_2.on_version);
}

control_nvg_staticscreens_off() {
  var_0 = getEntArray("nvg_monitors", "targetname");
  var_1 = getEntArray("nvg_mainscreens", "targetname");
  var_2 = getent("nvg_mapscreen", "targetname");
  var_3 = getent("nvg_mapscreen_light_accents", "targetname");

  foreach(var_5 in var_0)
  var_5 hide();

  foreach(var_5 in var_1)
  var_5 hide();

  var_2 hide();
  var_3 hide();
}

control_nvg_staticscreens_on() {
  var_0 = getEntArray("nvg_monitors", "targetname");
  var_1 = getEntArray("nvg_mainscreens", "targetname");
  var_2 = getent("nvg_mapscreen", "targetname");
  var_3 = getent("nvg_mapscreen_light_accents", "targetname");

  foreach(var_5 in var_0)
  var_5 show();

  foreach(var_5 in var_1)
  var_5 show();

  var_2 show();
  var_3 show();
}

player_failcase_leave_garage() {
  common_scripts\utility::flag_wait("FLAG_player_leave_garage");
  setdvar("ui_deadquote", & "CLOCKWORK_QUOTE_LEFT_TEAM");
  maps\_utility::missionfailedwrapper();
}

handle_dog_interior() {
  common_scripts\utility::flag_wait("nvgs_on");
  wait 1.3;
  level.dog maps\_utility::clear_run_anim();
  level.dog maps\_utility::set_ignoreall(0);

  if(isDefined(level.override_dog_enemy) && isalive(level.override_dog_enemy)) {
    level.override_dog_enemy.leave_for_dog = 1;
    level.override_dog_enemy maps\_utility::set_ignoreme(1);
    level.player notify("dog_attack_override");
    level.override_dog_enemy common_scripts\utility::waittill_notify_or_timeout("dead", 15);
  }

  level.dog setdogattackradius(200);
}