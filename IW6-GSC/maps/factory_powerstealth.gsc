/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_powerstealth.gsc
*****************************************/

section_precache() {
  precacheitem("factory_knife");
  precachemodel("Viewmodel_knife_iw6");
  precachemodel("head_fed_army_d");
  precachemodel("com_flashlight_on");
  precachemodel("shipping_frame_50cal");
  precachemodel("shipping_frame_crates");
  precachemodel("shipping_frame_minigun");
  precachemodel("vld_playing_card_deck");
  precachemodel("cnd_cellphone_01_on");
  precachemodel("com_folding_chair");
  precachemodel("weapon_p226");
  precachemodel("fac_ambush_desk_search_chair");
  precachemodel("trash_cup_tall2");
  precachestring(&"FACTORY_DROP_KILL_HINT");
}

section_flag_init() {
  common_scripts\utility::flag_init("loading_area_guards_dead");
  common_scripts\utility::flag_init("conveyor_guards");
  common_scripts\utility::flag_init("entered_conveyor");
  common_scripts\utility::flag_init("powerstealth_ready");
  common_scripts\utility::flag_init("powerstealth_split");
  common_scripts\utility::flag_init("ps_first_wave_in_position");
  common_scripts\utility::flag_init("ps_first_kills_done");
  common_scripts\utility::flag_init("ps_rogers_first_kill_done");
  common_scripts\utility::flag_init("ps_second_wave_start");
  common_scripts\utility::flag_init("ps_second_wave_dialogue_done");
  common_scripts\utility::flag_init("ps_bravo_second_pos_ready");
  common_scripts\utility::flag_init("charlie_posted_up");
  common_scripts\utility::flag_init("ps_charlie_second_enemy_alerted");
  common_scripts\utility::flag_init("tunnel_guard_arrived");
  common_scripts\utility::flag_init("guard_tunnel_alerted");
  common_scripts\utility::flag_init("guard_platform_alerted");
  common_scripts\utility::flag_init("catwalk_guard_dead");
  common_scripts\utility::flag_init("keegan_killed_window_guard");
  common_scripts\utility::flag_init("ps_foreman_office_entry");
  common_scripts\utility::flag_init("second_charlie_kill_arrived");
  common_scripts\utility::flag_init("throat_stab_chair");
  common_scripts\utility::flag_init("throat_stab_sequence_aborted");
  common_scripts\utility::flag_init("ps_alpha_kill_second");
  common_scripts\utility::flag_init("ps_second_kill_made");
  common_scripts\utility::flag_init("ps_second_kills_done");
  common_scripts\utility::flag_init("bravo_second_kill_arrived");
  common_scripts\utility::flag_init("ps_final_wave_start");
  common_scripts\utility::flag_init("start_break_area_kill");
  common_scripts\utility::flag_init("ps_final_kill_made");
  common_scripts\utility::flag_init("ps_final_kills_done");
  common_scripts\utility::flag_init("ps_right_path_a");
  common_scripts\utility::flag_init("ps_alpha_second_pos_ready");
  common_scripts\utility::flag_init("ps_charlie_second_pos_ready");
  common_scripts\utility::flag_init("ps_alpha_tunnel_approach");
  common_scripts\utility::flag_init("ps_alpha_final_pos_ready");
  common_scripts\utility::flag_init("ps_final_kill_bravo_ready");
  common_scripts\utility::flag_init("player_broke_break_area");
  common_scripts\utility::flag_init("ps_baker_at_final_kill");
  common_scripts\utility::flag_init("ps_break_area_triggered");
  common_scripts\utility::flag_init("break_area_first_dead");
  common_scripts\utility::flag_init("ps_break_area_done");
  common_scripts\utility::flag_init("ps_alert_chair_guard");
  common_scripts\utility::flag_init("ps_alpha_done");
  common_scripts\utility::flag_init("ps_bravo_done");
  common_scripts\utility::flag_init("ps_charlie_done");
  common_scripts\utility::flag_init("window_alerted");
  common_scripts\utility::flag_init("railing_tumble_kill_ready");
  common_scripts\utility::flag_init("bravo_final_kill_arrived");
  common_scripts\utility::flag_init("start_final_rogers_kill");
  common_scripts\utility::flag_init("smoker_arrived");
  common_scripts\utility::flag_init("powerstealth_midpoint");
  common_scripts\utility::flag_init("speed_100");
  common_scripts\utility::flag_init("ps_end_setup");
  common_scripts\utility::flag_init("powerstealth_end");
  common_scripts\utility::flag_init("open_exit_doors");
  common_scripts\utility::flag_init("lgt_playerkill_jumpdown");
  common_scripts\utility::flag_init("lgt_playerkill_done");
  common_scripts\utility::flag_init("lgt_intro_reveal");
  common_scripts\utility::flag_init("ps_gate_allies_arrived");
  common_scripts\utility::flag_init("ps_gate_open");
  common_scripts\utility::flag_init("charlie_at_gate");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("chair_stab_hint", &"SCRIPT_PLATFORM_OILRIG_HINT_STEALTH_KILL", ::hint_chair_stab_should_break);
}

hint_chair_stab_should_break() {
  if(common_scripts\utility::flag("throat_stab_chair") || !common_scripts\utility::flag("ready_to_stab_neck")) {
    return 1;
  }

  return 0;
}

powerstealth_start() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_pain();
    var_1 maps\_utility::disable_surprise();
  }

  level.player switchtoweapon(level.default_weapon);
  level.player takeweapon("flash_grenade");
  level.player takeweapon("fraggrenade");
  common_scripts\utility::flag_set("intro_checkpoint_done");
  common_scripts\utility::flag_set("player_entered_awning");
  common_scripts\utility::flag_set("outer_perim_cleared");
  common_scripts\utility::flag_set("entered_factory_1");
  common_scripts\utility::flag_set("factory_entrance_setup");
  common_scripts\utility::flag_set("trainyard_enemy_dead");
  teleport_squad("powerstealth", "deltaecho");
  maps\_utility::player_speed_percent(70);
  thread conveyor_crate_setup();
  maps\_utility::battlechatter_off();
  thread maps\_weather::rainnone(3);
}

powerstealth() {
  maps\_utility::player_speed_percent(70);
  thread maps\factory_ambush::ambush_dest_screens();
  thread maps\factory_intro::train_cleanup();
  powerstealth_setup();
  powerstealth_enc();

  foreach(var_1 in level.squad) {
    var_1.disableplayeradsloscheck = 0;
    var_1 pushplayer(0);
    var_1.moveplaybackrate = 1.0;
    var_1 maps\_utility::enable_pain();
  }

  common_scripts\utility::flag_wait_all("ps_alpha_done", "ps_bravo_done", "ps_charlie_done");
}

powerstealth_setup() {
  common_scripts\utility::flag_wait("through_conveyor");

  foreach(var_1 in level.squad) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1.disableplayeradsloscheck = 1;
    var_1 pushplayer(1);
  }

  level thread factory_stealth_settings();
  maps\_stealth_utility::stealth_set_default_stealth_function("factory_stealth", ::factory_stealth_settings);
  var_3 = getent("ps_guard_1_platform", "script_noteworthy");
  var_3 maps\_utility::add_spawn_function(::ps_guard_platform_think);
  level.guard_platform = var_3 maps\_utility::spawn_ai();
  wait 0.5;
  var_4 = getent("ps_guard_2_tunnel", "script_noteworthy");
  var_4 maps\_utility::add_spawn_function(::ps_guard_tunnel_think);
  level.guard_tunnel = var_4 maps\_utility::spawn_ai();
  wait 0.5;
  var_5 = getent("ps_guard_window_01", "script_noteworthy");
  var_5 maps\_utility::add_spawn_function(::ps_guard_window_01_think);
  level.guard_window_01 = var_5 maps\_utility::spawn_ai();
  wait 0.5;
  var_6 = getent("ps_guard_window_02", "script_noteworthy");
  var_6 maps\_utility::add_spawn_function(::ps_guard_window_02_think);
  level.guard_window_02 = var_6 maps\_utility::spawn_ai();
  wait 0.5;
  var_7 = getent("ps_final_rogers_kill", "script_noteworthy");
  var_7 maps\_utility::add_spawn_function(::ps_final_rogers_kill_think);
  level.guard_office_sleeper = var_7 maps\_utility::spawn_ai();
  var_8 = getEntArray("powerstealth_final_kills", "targetname");

  foreach(var_10 in var_8) {
  var_10 maps\_utility::add_spawn_function(::final_alpha_kill_think);
  }

  maps\factory_util::safe_trigger_by_targetname("powerstealth_final_kills_spawner");
  thread maps\factory_weapon_room::presat_init_revolving_door();
}

ps_guard_platform_think() {
  self endon("death");
  level endon("ps_charlie_second_enemy_alerted");
  level endon("guard_platform_alerted");
  ps_guard_standard_settings();
  self.patrol_walk = ["walk_gun_unwary"];
  self.moveplaybackrate = 0.6;
  maps\_utility::set_generic_run_anim_array(common_scripts\utility::random(self.patrol_walk));
  attach_flashlight(1, 1);
  var_0 = getnode(self.target, "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "flashlight_search_loop");
  var_0 thread maps\_anim::anim_loop_solo(self, "flashlight_search_loop", "stop_loop");
  common_scripts\utility::flag_wait("powerstealth_split");
  maps\_utility::waittill_entity_in_range_or_timeout(level.player, 475, 2.5);
  thread ps_guard_platform_think_breakout(var_0);
  ps_guard_platform_continue_patrol(var_0);
}

ps_guard_platform_continue_patrol(var_0) {
  level endon("ps_charlie_second_enemy_alerted");
  level endon("guard_platform_alerted");
  self.dontdrop_flashlight = 1;
  detach_flashlight();
  wait 0.1;
  attach_flashlight(1, 0);
  self.dontdrop_flashlight = undefined;
  self stopanimscripted();
  var_0 notify("stop_loop");
  self.goalradius = 8;
  var_0 = getent("guard_platform_walk_and_search", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "active_patrolwalk_v4");
  var_0 maps\_anim::anim_single_solo(self, "active_patrolwalk_v4");
  maps\_anim::anim_single_solo(self, "active_patrolwalk_v5");
  maps\_anim::anim_single_solo(self, "active_patrolwalk_pause");
  thread maps\_anim::anim_loop_solo(self, "flashlight_search_loop", "stop_loop");
}

ps_guard_platform_think_breakout(var_0) {
  self endon("death");
  thread set_flags_on_notify("ps_charlie_second_enemy_alerted");
  thread watch_for_player(90, "ps_charlie_second_enemy_alerted");
  thread wait_for_waking_event("guard_platform_alerted");
  common_scripts\utility::flag_wait_any("ps_charlie_second_enemy_alerted", "guard_platform_alerted");
  common_scripts\utility::flag_set("ps_charlie_second_enemy_alerted");
  common_scripts\utility::flag_set("guard_platform_alerted");
  self.goalradius = 8;
  self stopanimscripted();
  var_0 notify("stop_loop");
  self setgoalpos(self.origin);
  maps\_utility::clear_generic_run_anim();
  maps\_utility::clear_generic_idle_anim();
  self.ignoreall = 0;
  self.see_player = 1;
  self.favoriteenemy = level.player;
  waittillframeend;
  self setgoalpos(level.player.origin);
  detach_flashlight();
}

set_flags_on_notify(var_0) {
  self endon("death");
  self waittill(var_0);
  common_scripts\utility::flag_set(var_0);
}

ps_guard_tunnel_think() {
  self endon("death");
  level endon("guard_tunnel_alerted");
  ps_guard_standard_settings(1);
  thread watch_for_player(25, undefined, 1, 1);
  thread wait_for_waking_event("guard_tunnel_alerted");
  thread notify_alpha_on_alert();
  thread ps_guard_tunnel_breakout();
  var_0 = getent("ps_guard_2_tunnel_start_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "casual_stand_idle");
  var_0 thread maps\_anim::anim_loop_solo(self, "casual_stand_idle", "stop_loop");
  common_scripts\utility::flag_wait("ps_alpha_second_pos_ready");
  common_scripts\utility::waittill_either("baker_in_position", "ps_charlie_second_pos_ready");
  var_0 stopanimscripted();
  var_0 notify("stop_loop");

  if(!self.see_player) {
    ps_guard_tunnel_patrol(var_0);
  }
}

#using_animtree("generic_human");

ps_guard_tunnel_patrol(var_0) {
  self endon("death");
  level endon("guard_tunnel_alerted");
  var_0 maps\_anim::anim_reach_solo(self, "active_patrolwalk_turn_180");
  maps\_utility::delaythread(0.01, maps\_anim::anim_set_rate_single, self, "active_patrolwalk_turn_180", 0.75);
  var_0 maps\_anim::anim_single_solo(self, "active_patrolwalk_turn_180");
  attach_flashlight(1);
  var_0 = getent("ps_guard_2_tunnel_node", "script_noteworthy");
  maps\_utility::delaythread(0.01, maps\_anim::anim_set_rate_single, self, "active_patrolwalk_v2", 0.75);
  var_0 thread maps\_anim::anim_single_solo(self, "active_patrolwalk_v2");
  var_1 = self getanimtime( % active_patrolwalk_v2);

  while(var_1 < 0.94) {
    var_1 = self getanimtime( % active_patrolwalk_v2);
    wait 0.05;
  }

  self.goalradius = 8;
  self stopanimscripted();
  self.see_player = 1;
  self.favoriteenemy = level.player;
  self setgoalpos(level.player.origin);
  self.ignoreall = 0;
  maps\_utility::clear_generic_run_anim();
  maps\_utility::clear_generic_idle_anim();
  detach_flashlight();
  level.squad["ALLY_ALPHA"] notify("second_kill_ready");
  self waittill("damage");
}

ps_guard_tunnel_breakout() {
  self endon("death");
  common_scripts\utility::flag_wait("guard_tunnel_alerted");
  self.ignoreall = 0;
  self stopanimscripted();
  self.see_player = 1;
  self.favoriteenemy = level.player;
  self setgoalpos(level.player.origin);
  self.ignoreall = 0;
  maps\_utility::clear_generic_run_anim();
  maps\_utility::clear_generic_idle_anim();
  detach_flashlight();
}

notify_alpha_on_alert() {
  self endon("death");
  self.alerted = 0;

  while(!self.alerted) {
    wait 0.5;
  }

  common_scripts\utility::flag_set("guard_tunnel_alerted");
  level.squad["ALLY_ALPHA"] notify("guard_tunnel_alerted");
}

attack_closest_enemies(var_0) {
  self endon("death");

  while(isalive(self)) {
    var_1 = maps\_utility::get_closest_living(self.origin, var_0);
    self.favoriteenemy = var_1;
    wait 0.2;
  }
}

watch_for_player(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("in_animation");
  level endon("railgun_reveal_setup");
  var_4 = cos(var_0);
  self.see_player = 0;

  while(isalive(self)) {
    wait 0.1;
    var_5 = distance(level.player.origin, self.origin);

    if(isDefined(var_5)) {
      if(var_5 > 200) {
        continue;
      }
      else {
        var_6 = common_scripts\utility::within_fov(self.origin, self.angles, level.player.origin, var_4);

        if(!var_6) {
          if(var_5 < 80) {
            break;
          } else
            continue;

          continue;
        }

        if(!isDefined(var_2)) {
          wait(var_5 / 100);
        }
        else {
          wait(var_5 / 175);
        }

        var_7 = common_scripts\utility::within_fov(self.origin, self.angles, level.player.origin, var_4);

        if(!var_7) {
          continue;
        }
        else {
          break;
        }
      }
    }
  }

  thread delay_stealth_break(1);

  if(isDefined(var_1)) {
    self notify(var_1);
  }
  else {
    self.goalradius = 8;
    self stopanimscripted();
    self setgoalpos(self.origin);
    self.ignoreall = 0;
    self.see_player = 1;
    self.favoriteenemy = level.player;
    maps\_utility::clear_generic_run_anim();
    maps\_utility::clear_generic_idle_anim();

    if(isDefined(var_3)) {
      detach_flashlight();
    }
  }

  self.alerted = 1;
}

delay_stealth_break(var_0) {
  self endon("death");
  wait(var_0);
  level notify("stealth_broken");
}

ps_check_for_player_damage() {
  self endon("death");
  level endon("stealth_broken");
  level endon("presat_revolving_door_dialog_done");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player) {
    level.player maps\_player_stats::register_kill(self, "MOD_PISTOL_BULLET");
  }
}

ps_final_rogers_kill_think() {
  self endon("death");
  ps_guard_standard_settings();
  self.animname = "generic";
  level.sleeping_guard = self;
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("cnd_cellphone_01_on");
  var_0.origin = self gettagorigin("tag_inhand");
  var_0 linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 = getent("sleeping_guard_node", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame_solo(self, "sleep_enter");
  self waittill("done_waking_up");
  var_1 notify("stop_loop");
  self stopanimscripted();
}

final_alpha_kill_think() {
  level endon("railgun_reveal_setup");
  self.allowdeath = 1;
  maps\_utility::magic_bullet_shield();
  var_0 = common_scripts\utility::getstruct("rest_area_kills", "script_noteworthy");
  var_1 = getent(self.script_noteworthy + "_org", "script_noteworthy");
  var_2 = [];

  if(var_1.script_noteworthy == "ps_break_area_a_org") {
    var_3 = maps\_utility::spawn_anim_model("chair_opfor01");
    var_4 = getent("col_chair_breakarea_01", "script_noteworthy");
    var_4 notsolid();
    var_2["chair_opfor01"] = var_3;
    var_2["opfor01"] = self;
    self.animname = "opfor01";
    level.guard_breakarea_01 = self;
    var_5 = maps\_utility::get_living_ai("ps_break_area_b", "script_noteworthy");
    var_0 = getent("ps_break_area_a_org", "script_noteworthy");
  } else {
    var_3 = maps\_utility::spawn_anim_model("chair_opfor02");
    var_4 = getent("col_chair_breakarea_02", "script_noteworthy");
    var_4 notsolid();
    var_2["chair_opfor02"] = var_3;
    var_2["opfor02"] = self;
    self.animname = "opfor02";
    level.guard_breakarea_02 = self;
    var_5 = maps\_utility::get_living_ai("ps_break_area_a", "script_noteworthy");
    var_0 = getent("ps_break_area_b_org", "script_noteworthy");
  }

  var_0 thread maps\_anim::anim_loop_solo(var_3, "break_area_idle_chair", "stop_loop");
  var_0 thread maps\_anim::anim_loop_solo(self, self.animation, "stop_loop");

  if(var_1.script_noteworthy == "ps_break_area_a_org") {
    thread break_area_gun_handling_a();
  }
  else {
    thread break_area_gun_handling_b();
  }

  thread watch_for_player(350, "player_broke_break_area");
  var_6 = common_scripts\utility::waittill_any_return("damage", "friend_is_dead", "player_broke_break_area", "ps_baker_at_final_kill");
  common_scripts\utility::flag_set("ps_break_area_triggered");
  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();

  if(var_6 == "damage") {
    var_5 notify("friend_is_dead");
    self.allowdeath = 0;
    self.noragdoll = 1;

    if(self.animname == "opfor01") {
      level.guard_breakarea_01 thread maps\factory_audio::stealth_kill_table_right_sfx();
    }
    else {
      level.guard_breakarea_02 thread maps\factory_audio::stealth_kill_table_left_sfx();
    }

    var_0 notify("stop_loop");
    maps\_utility::anim_stopanimscripted();

    if(isDefined(self.magic_bullet_shield)) {
      maps\_utility::stop_magic_bullet_shield();
    }

    self.alreadyshot = 1;
    var_0 maps\_anim::anim_single(var_2, "rest_area_kills");
    var_3 thread do_chair_collision(var_4);

    if(isalive(self)) {
      maps\factory_anim::kill_no_react();
    }
  } else if(var_6 == "friend_is_dead") {
    var_0 notify("stop_loop");
    maps\_utility::anim_stopanimscripted();
    maps\_utility::stop_magic_bullet_shield();
    maps\_utility::disable_surprise();
    self.allowdeath = 1;
    self stopsounds();

    if(common_scripts\utility::flag("ps_alpha_final_pos_ready") && isalive(self)) {
      self playSound("factory_sp1_enlamadre");
    }

    if(self.animname == "opfor01") {
      level.guard_breakarea_01 thread maps\factory_audio::stealth_kill_table_alert_right_sfx();
      var_0 thread maps\_anim::anim_single_solo(var_3, "break_area_react_a_chair");
      var_0 maps\_anim::anim_single_solo(self, "break_area_react_a");
    } else {
      level.guard_breakarea_02 thread maps\factory_audio::stealth_kill_table_alert_left_sfx();
      var_0 thread maps\_anim::anim_single_solo(var_3, "break_area_react_b_chair");
      var_0 maps\_anim::anim_single_solo(self, "break_area_react_b");
    }

    var_3 thread do_chair_collision(var_4);
    var_7 = [level.squad["ALLY_ALPHA"], level.player];

    while(isalive(self)) {
      var_8 = maps\_utility::get_closest_living(self.origin, var_7);
      self.favoriteenemy = var_8;
      wait 0.2;
    }
  } else if(var_6 == "player_broke_break_area") {
    var_0 notify("stop_loop");
    maps\_utility::anim_stopanimscripted();
    maps\_utility::stop_magic_bullet_shield();
    maps\_utility::disable_surprise();
    self stopsounds();

    if(common_scripts\utility::flag("ps_alpha_final_pos_ready") && isalive(self)) {
      thread maps\_utility::smart_dialogue("factory_sp1_quienchingadoson");
    }

    if(self.animname == "opfor01") {
      level.guard_breakarea_01 thread maps\factory_audio::stealth_kill_table_alert_right_sfx();
      var_0 thread maps\_anim::anim_single_solo(var_3, "break_area_react_a_chair");
      var_0 thread maps\_anim::anim_single_solo(self, "break_area_react_a");
    } else {
      level.guard_breakarea_02 thread maps\factory_audio::stealth_kill_table_alert_left_sfx();
      var_0 thread maps\_anim::anim_single_solo(var_3, "break_area_react_b_chair");
      var_0 thread maps\_anim::anim_single_solo(self, "break_area_react_b");
    }

    var_3 thread do_chair_collision(var_4);
    var_5 notify("player_broke_break_area");
    var_7 = [level.squad["ALLY_ALPHA"], level.player];

    while(isalive(self)) {
      var_8 = maps\_utility::get_closest_living(self.origin, var_7);
      self.favoriteenemy = var_8;
      wait 0.2;
    }
  } else if(var_6 == "ps_baker_at_final_kill") {
    self stopsounds();
    maps\_utility::stop_magic_bullet_shield();
    self.allowdeath = 0;
    self.noragdoll = 1;
    var_0 notify("stop_loop");
    maps\_utility::anim_stopanimscripted();
    level.guard_breakarea_01 thread maps\factory_audio::stealth_kill_table_right_sfx();
    level.guard_breakarea_02 thread maps\factory_audio::stealth_kill_table_left_sfx();
    var_0 maps\_anim::anim_single(var_2, "rest_area_kills");
    var_3 thread do_chair_collision(var_4);
    maps\factory_anim::kill_no_react();
  }
}

break_area_gun_handling_a() {
  self endon("death");
  wait 0.1;
  var_0 = spawn("weapon_" + self.weapon, self gettagorigin("j_gun"));
  var_0.angles = self gettagangles("j_gun");
  common_scripts\utility::waitframe();
  maps\_utility::gun_remove();
  self waittill("grab_gun");
  maps\_utility::gun_recall();
  var_0 delete();
}

break_area_gun_handling_b() {
  self endon("death");
  wait 0.1;
  var_0 = spawn("weapon_" + self.weapon, self gettagorigin("j_gun") + (0, 0, 10));
  var_0.angles = self gettagangles("j_gun");
  common_scripts\utility::waitframe();
  maps\_utility::gun_remove();
  self waittill("grab_gun");
  maps\_utility::gun_recall();
  var_0 delete();
}

do_chair_collision(var_0) {
  self endon("done_with_collision");

  for(;;) {
    if(!maps\_utility::players_within_distance(32, self.origin)) {
      break;
    }

    wait 0.1;
  }

  self notify("done_with_collision");
}

ps_guard_window_01_think() {
  self endon("death");
  ps_guard_standard_settings();
  maps\_utility::set_generic_run_anim("walk_gun_unwary");
  maps\_utility::set_generic_idle_anim("patrol_idle_stretch");
  common_scripts\utility::flag_wait_any("ps_bravo_second_pos_ready", "ps_alpha_second_pos_ready", "ps_charlie_second_pos_ready");
  self.goalradius = 8;
  var_0 = getnode("ps_guard_window_01_idle", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "dufflebag_casual_idle");
  self.animname = "enemy";
  self.deathanim = % factory_power_stealth_console_death;
  var_0 thread maps\_anim::anim_loop_solo(self, "dufflebag_casual_idle");
  thread wait_for_waking_event("window_alerted");
  var_1 = common_scripts\utility::waittill_any_return("damage", "wake_up");

  if(var_1 == "wake_up") {
    self stopanimscripted();
    self.deathanim = undefined;
    self.ignoreme = 1;
    maps\_anim::anim_single_solo(self, "prague_intro_dock_guard_reaction_02");
  }

  common_scripts\utility::flag_set("guard_window_01_dead");
}

ps_guard_window_02_think() {
  self endon("death");
  self.goalradius = 8;
  ps_guard_standard_settings();
  common_scripts\utility::flag_wait_any("guard_window_01_dead", "start_break_area_kill");
}

monitor_player_distance() {
  while(isalive(self)) {
    var_0 = distance(level.player.origin, self.origin);

    if(var_0 > 100) {
      continue;
    }
    else {
      wait 3.0;
      self stopanimscripted();
      self.ignoreall = 0;
      self.see_player = 1;
      common_scripts\utility::flag_set("ps_final_kill_made");
      break;
    }

    wait 0.4;
  }
}

ps_guard_standard_settings(var_0) {
  self.goalradius = 8;
  self.allowdeath = 1;
  self.animname = "enemy";
  self.health = 1;
  self.ignoreall = 1;

  if(isDefined(var_0)) {
    self.patrol_walk = ["walk_gun_unwary", "patrol_bored_patrolwalk", "patrol_bored_patrolwalk_twitch"];
    self.patrol_idle = ["patrol_idle_stretch", "patrol_idle_smoke", "patrol_idle_checkphone"];
    maps\_utility::set_generic_run_anim_array(common_scripts\utility::random(self.patrol_walk));
    maps\_utility::set_generic_idle_anim(common_scripts\utility::random(self.patrol_idle));
  }
}

factory_stealth_settings() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 350;
  var_0["stand"] = 512;
  var_1 = [];
  var_1["prone"] = 512;
  var_1["crouch"] = 3000;
  var_1["stand"] = 4000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
  var_2 = [];
  var_2["player_dist"] = 750;
  var_2["sight_dist"] = 750;
  var_2["detect_dist"] = 128;
  var_2["found_dist"] = 96;
  var_2["found_dog_dist"] = 50;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_2);
}

powerstealth_enc() {
  thread ps_begin();
  thread ps_first_wave();
  thread ps_second_wave();
  thread ps_final_wave();
  common_scripts\utility::flag_wait("powerstealth_midpoint");
  common_scripts\utility::flag_wait("powerstealth_end");

  foreach(var_1 in level.squad) {
  var_1.script_pushable = 0;
  }

  common_scripts\utility::flag_clear("_stealth_spotted");
}

ps_begin() {
  thread ps_gate_animation();
  level endon("ps_second_wave_start");

  foreach(var_1 in level.squad) {
    var_1 notify("stop_adjust_movement_speed");
    var_1.script_pushable = 0;
    var_1 maps\_utility::disable_pain();
  }

  level.ai_friendlyfireblockduration = getdvarfloat("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  level.squad["ALLY_ALPHA"] thread alpha_ps_animation();
  level.squad["ALLY_BRAVO"] thread bravo_ps_movement();
  common_scripts\utility::flag_wait("ps_begin");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_goright");
  common_scripts\utility::flag_set("ps_gate_allies_arrived");
  wait 1.5;
  level thread maps\_utility::smart_radio_dialogue("factory_bkr_go");
  thread maps\factory_audio::audio_factory_reveal_mix("three");
  common_scripts\utility::flag_wait("ps_gate_open");
  maps\factory_util::safe_trigger_by_targetname("sca_powerstealth_start");
  wait 1;
  common_scripts\utility::flag_set("powerstealth_ready");
  level.squad["ALLY_ALPHA"] thread alpha_ps_start_settings();
  common_scripts\utility::flag_wait("exited_conveyor");
  thread maps\_weather::rainnone(8);
  thread ps_end();
}

alpha_ps_animation() {
  var_0 = getnode("ps_intro_alpha_idle", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(level.squad["ALLY_ALPHA"], "factory_power_stealth_ally_intro_loop");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_power_stealth_ally_intro_loop", "stop_loop");
  common_scripts\utility::flag_wait("charlie_at_gate");
  common_scripts\utility::flag_wait("ps_gate_allies_arrived");
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_ally_intro_talk");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_power_stealth_ally_exit_loop", "stop_loop");
  common_scripts\utility::flag_wait("powerstealth_ready");
  wait 1.5;
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_ally_intro_exit");
}

ps_gate_animation() {
  common_scripts\utility::flag_wait("ps_begin");
  wait 1;
  var_0 = getent("ps_gate", "targetname");
  level.squad["ALLY_CHARLIE"].goalradius = 32;
  level.squad["ALLY_CHARLIE"] waittill("goal");
  common_scripts\utility::flag_set("charlie_at_gate");
  wait 0.25;
  thread maps\factory_audio::audio_powerstealth_gate_unlock();
  level.squad["ALLY_CHARLIE"] maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "card_swipe");
  level.squad["ALLY_CHARLIE"] pushplayer(1);
  thread maps\factory_audio::audio_powerstealth_gate_open();
  var_1 = 0.25;
  var_0 movey(2, var_1, 0.05, 0.05);
  wait(var_1);
  var_2 = 2;
  var_0 movey(50, var_2, 1, 0.1);
  wait(var_2 * 0.75);
  common_scripts\utility::flag_set("ps_gate_open");
  wait(var_2 * 0.25);
  var_3 = getent("ps_gate_collision", "targetname");
  var_3 notsolid();
  common_scripts\utility::flag_wait("powerstealth_midpoint");
  var_0 movey(-52, var_2, 0.5, 0.1);
  var_3 solid();
}

alpha_ps_start_settings() {
  maps\_utility::enable_ai_color_dontmove();
  self setgoalnode(getnode("ps_first_wave_alpha_node", "script_noteworthy"));
  maps\_utility::disable_pain();
  self pushplayer(1);
  maps\_utility::disable_bulletwhizbyreaction();
  self.ignoresuppression = 1;
  self.ignorerandombulletdamage = 1;
  self.disablefriendlyfirereaction = 1;
  self.disableplayeradsloscheck = 1;
}

bravo_ps_movement() {
  maps\_utility::enable_cqbwalk();
  common_scripts\utility::flag_wait("powerstealth_ready");
  maps\_utility::disable_cqbwalk();
  common_scripts\utility::flag_wait("powerstealth_split");
}

ps_first_wave() {
  level endon("railgun_reveal_setup");
  var_0 = maps\_utility::get_ai_group_count("ps_first_wave");
  thread ps_first_wave_dialogue();
  level.squad["ALLY_ALPHA"] thread wait_for_alpha_arrival();
  thread maps\factory_util::check_trigger_flagset("sca_ps_low_path_start");
  common_scripts\utility::flag_wait("exited_conveyor");

  if(isDefined(getent("sca_ps_first_kills_done", "targetname"))) {
    maps\factory_util::safe_trigger_by_targetname("sca_ps_first_kills_done");
  }
}

wait_for_alpha_arrival() {
  var_0 = getnode("ps_first_wave_alpha_node", "script_noteworthy");
  maps\_utility::waittill_entity_in_range(var_0, 200);
  common_scripts\utility::flag_set("ps_first_wave_in_position");
}

ps_first_wave_dialogue() {
  level endon("ps_first_kills_done");
  common_scripts\utility::flag_wait("ps_first_wave_in_position");
  wait 0.1;
  common_scripts\utility::flag_set("ps_first_kills_done");
}

ps_first_kill_progression() {
  level endon("ps_second_wave_start");
  var_0 = 0;

  foreach(var_2 in level.squad) {
    if(isalive(var_2.favoriteenemy)) {
      var_2 maps\_utility::cqb_aim(var_2.favoriteenemy);
      wait 0.1;
      var_2 shootblank();
      var_2 maps\factory_intro::safe_magic_bullet(var_2 gettagorigin("tag_flash"), var_2.favoriteenemy getshootatpos());
      var_2.favoriteenemy kill(var_2.origin, var_2);
      var_0 = var_0 + 1;
    }
  }

  if(var_0 > 2) {
    maps\_utility::smart_radio_dialogue("factory_rgs_thatsakill");
    wait 0.1;
  }

  common_scripts\utility::flag_set("ps_first_kills_done");
}

ps_second_wave() {
  level.squad["ALLY_ALPHA"] thread ps_second_wave_alpha();
  level.squad["ALLY_BRAVO"] thread ps_second_wave_bravo();
  level.squad["ALLY_CHARLIE"] thread ps_second_wave_charlie();
  common_scripts\utility::flag_wait("ps_second_wave_start");
  common_scripts\utility::flag_set("ps_second_wave_dialogue_done");
  maps\factory_util::safe_trigger_by_targetname("sca_ps_bravo_second_position");
  common_scripts\utility::flag_wait("ps_charlie_second_pos_ready");
  common_scripts\utility::flag_set("ps_second_kills_done");
  maps\factory_util::safe_trigger_by_targetname("sca_ps_second_kills_done");
}

ps_second_wave_alpha() {
  level endon("railgun_reveal_setup");
  common_scripts\utility::flag_wait("powerstealth_split");
  thread tunnel_interrupt();

  if(!common_scripts\utility::flag("guard_tunnel_dead") && !common_scripts\utility::flag("guard_tunnel_alerted")) {
    tunnel_first_position();
  }
  else {
    var_0 = getnode("baker_first_position_node", "script_noteworthy");
    self setgoalnode(var_0);
  }

  thread break_area_dialogue(level.guard_breakarea_01, level.guard_breakarea_02);

  if(!common_scripts\utility::flag("guard_tunnel_dead") && !common_scripts\utility::flag("guard_tunnel_alerted")) {
    tunnel_second_position();
  }

  var_1 = getent("vol_ps_with_baker", "targetname");

  if(!common_scripts\utility::flag("guard_tunnel_alerted")) {
    if(common_scripts\utility::flag("ps_player_with_alpha_second") && isalive(level.guard_tunnel) && level.player istouching(var_1)) {
      tunnel_melee_scene();
    }
    else {
      var_0 = getnode("alpha_quick_kill", "script_noteworthy");
      self.goalradius = 8;
      self setgoalnode(var_0);
      self waittill("goal");
    }
  }

  if(isalive(level.guard_tunnel)) {
    ps_second_wave_alpha_execute(level.guard_tunnel);
  }

  self setlookatentity();
  ps_final_wave_alpha();
}

tunnel_first_position() {
  level endon("guard_tunnel_dead");
  level endon("guard_tunnel_alerted");
  self.goalradius = 8;
  var_0 = getnode("baker_first_position_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "factory_power_stealth_lower_hallway_enter_ally");

  if(common_scripts\utility::flag("ps_player_with_alpha_second")) {
    var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_lower_hallway_enter_ally");
  }
}

tunnel_second_position() {
  level endon("guard_tunnel_dead");
  self endon("guard_tunnel_alerted");
  self.goalradius = 8;
  var_0 = getnode("baker_first_position_node", "script_noteworthy");
  var_1 = getnode("baker_second_position", "script_noteworthy");
  var_2 = distance(level.player.origin, var_1.origin);
  var_3 = getent("vol_ps_with_baker", "targetname");
  level.guard_tunnel notify("baker_in_position");

  if(var_2 > 80 && level.player istouching(var_3)) {
    var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_lower_hallway_cross_ally");
    var_1 = getnode("baker_second_position", "script_noteworthy");
    self setgoalnode(var_1);
  } else {
    var_0 = getnode("baker_first_position_node", "script_noteworthy");
    self setgoalnode(var_0);
  }
}

tunnel_interrupt() {
  level endon("guard_tunnel_dead");
  common_scripts\utility::flag_wait("guard_tunnel_alerted");
  self stopanimscripted();
  var_0 = getnode("baker_second_position", "script_noteworthy");
  self setgoalnode(var_0);
}

tunnel_melee_scene() {
  self endon("guard_tunnel_alerted");
  level endon("guard_tunnel_dead");
  self setlookatentity(level.player);
  wait 0.5;
  self setlookatentity(level.guard_tunnel);
  thread maps\_utility::smart_dialogue("factory_mrk_hesallyours");
  self waittill("second_kill_ready");
  wait 0.5;
  wait 1.0;
}

ps_second_wave_alpha_execute(var_0) {
  level endon("railgun_reveal_setup");
  var_0.allowdeath = 1;
  var_0.noragdoll = 0;

  if(isalive(var_0)) {
    self.favoriteenemy = var_0;
    maps\_utility::disable_surprise();
    self.no_pistol_switch = 1;
    self.ignoreall = 0;
    var_0 waittill("death");
    self.ignoreall = 1;
    self.no_pistol_switch = 0;
  }
}

ps_second_wave_bravo() {
  level endon("railgun_reveal_setup");
  common_scripts\utility::flag_wait_any("ps_bravo_second_pos_ready", "guard_tunnel_dead");

  if(level.player istouching(getent("ps_player_with_bravo", "script_noteworthy"))) {
    thread maps\_utility::smart_radio_dialogue("factory_kgn_loganandihave");
    thread maps\_utility::handsignal("stop");
  }

  common_scripts\utility::flag_set("ps_charlie_second_pos_ready");
  common_scripts\utility::flag_set("ps_alpha_second_pos_ready");
  var_0 = getent("ps_bravo_office_approach", "script_noteworthy");
  ps_bravo_office_approach(var_0);

  if(isalive(level.guard_window_01)) {
    self stopanimscripted();
    var_0 notify("stop_loop");
    ps_second_wave_bravo_execute(level.guard_window_01, var_0);
  } else {
    self stopanimscripted();
    var_0 notify("stop_loop");
    self.goalradius = 128;
    self setgoalnode(getnode("bravo_final_kill_start", "script_noteworthy"));
  }

  common_scripts\utility::flag_wait("guard_tunnel_dead");
  ps_final_wave_bravo();
}

ps_bravo_office_approach(var_0) {
  level.guard_window_01 endon("death");
  common_scripts\utility::flag_wait_any("ps_second_wave_start", "guard_tunnel_dead");
  wait 2.0;
  level thread bravo_office_lights();
  bravo_sneak(var_0);
  common_scripts\utility::flag_wait_any("ps_final_kill_bravo_ready", "ps_alert_chair_guard", "start_break_area_kill");
}

bravo_office_lights() {
  var_0 = getEntArray("office_light_right_path", "script_noteworthy");

  foreach(var_2 in var_0) {
  thread bravo_office_lights_flicker(var_2);
  }
}

bravo_office_lights_flicker(var_0) {
  var_1 = 0.5;

  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 <= 3; var_2++) {
      var_0 setlightintensity(0.5);
      wait 0.02;
      var_0 setlightintensity(0);
      wait(randomfloatrange(0.01, 0.04));
    }

    var_3 = 0.9;

    if(maps\_utility::is_gen4()) {
      var_3 = 1.5;
    }

    while(var_1 <= var_3) {
      var_0 setlightintensity(var_1);
      wait 0.06;
      var_1 = var_1 + 0.25;
    }
  }
}

bravo_sneak(var_0) {
  level endon("keegan_killed_window_guard");
  level.guard_window_01 endon("death");
  var_0 maps\_anim::anim_reach_solo(self, "keegan_office_kill_enter");
  thread bravo_sneak_dialogue();
  var_0 maps\_anim::anim_single_solo(self, "keegan_office_kill_enter");
  var_0 thread maps\_anim::anim_loop_solo(self, "keegan_office_kill_loop", "stop_loop");
  self notify("bravo_in_window_position");
  self.in_position = 1;
  wait 3.5;
}

bravo_sneak_dialogue() {
  level.guard_window_01 endon("death");
  var_0 = getent("vol_ps_with_keegan", "targetname");

  if(level.player istouching(var_0) && isalive(level.guard_window_01)) {
    thread maps\_utility::smart_dialogue("factory_kgn_getdownwaitfor");
    self waittill("bravo_in_window_position");
    thread maps\_utility::smart_dialogue("factory_kgn_takehim");
  }
}

bravo_shoot_office_guard(var_0) {
  if(isalive(level.guard_window_01)) {
    var_0 maps\_utility::cqb_aim(level.guard_window_01);
    wait 0.2;
    var_0 shootblank();
    var_0 maps\factory_intro::safe_magic_bullet(var_0 gettagorigin("tag_flash"), level.guard_window_01 getshootatpos());
  }
}

ps_second_wave_bravo_execute(var_0, var_1) {
  if(isalive(var_0)) {
    var_1 maps\_anim::anim_single_solo(self, "keegan_office_kill_shoot");
    thread maps\_anim::anim_generic_loop(self, "exposed_crouch_idle_twitch_v2", "stop_loop");
  } else {
    thread maps\_utility::smart_dialogue("factory_kgn_goodkill");

    if(isDefined(self.in_position)) {
      var_1 maps\_anim::anim_single_solo(self, "keegan_office_kill_exit");
    }
  }

  common_scripts\utility::flag_set("keegan_killed_window_guard");
}

ps_second_wave_charlie() {
  level endon("railgun_reveal_setup");
  common_scripts\utility::flag_wait("powerstealth_split");
  var_0 = getent("ps_corner_kill_charlie_org", "targetname");
  thread handle_sleeping_guy(level.sleeping_guard);
  thread ps_second_wave_breakout(var_0);
  self.goalradius = 16;

  if(!common_scripts\utility::flag("ps_charlie_second_enemy_alerted") && !common_scripts\utility::flag("guard_platform_alerted")) {
    charlie_post_at_corner(var_0);
    var_0 notify("stop_loop");
    var_0 stopanimscripted();

    if(!common_scripts\utility::flag("guard_platform_alerted")) {
      var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_ally_corner_exit");
    }
  }

  maps\_utility::enable_cqbwalk();

  if(isalive(level.guard_platform) && !common_scripts\utility::flag("guard_platform_alerted")) {
    ps_second_wave_charlie_execute(level.guard_platform);
  }

  common_scripts\utility::flag_set("ps_second_kill_made");
  common_scripts\utility::flag_wait("ps_rogers_first_kill_done");

  if(level.player istouching(getent("vol_ps_top_level", "script_noteworthy"))) {
    thread maps\_utility::smart_radio_dialogue("factory_hsh_loganandiare");
  }
  else {
    thread maps\_utility::smart_radio_dialogue("factory_hsh_flashlightisdown");
  }

  self.ignoreall = 1;
  self.favoriteenemy = undefined;
  thread ps_final_wave_charlie();
}

charlie_post_at_corner(var_0) {
  level endon("ps_charlie_second_enemy_alerted");
  var_0 maps\_anim::anim_reach_solo(self, "factory_power_stealth_ally_corner_entrance");
  var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_ally_corner_entrance");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_power_stealth_ally_corner_idle", "stop_loop");
  common_scripts\utility::flag_set("charlie_posted_up");

  if(level.player istouching(getent("vol_ps_top_level", "script_noteworthy"))) {
    wait 1.8;

    if(isalive(level.guard_platform)) {
      thread maps\_utility::smart_dialogue("factory_hsh_shoothimnow");
    }

    common_scripts\utility::flag_wait_or_timeout("ps_rogers_first_kill_done", 5.2);
  }
}

ps_second_wave_charlie_execute(var_0) {
  level endon("railgun_reveal_setup");
  self.goalradius = 190;
  var_1 = getnode("charlie_quick_kill", "script_noteworthy");
  self setgoalnode(var_1);

  if(isalive(var_0)) {
    maps\_utility::cqb_aim(var_0);
    wait 0.2;
    self shootblank();
    maps\factory_intro::safe_magic_bullet(self gettagorigin("tag_flash"), var_0 getshootatpos());
    var_0 kill();
  }
}

ps_second_wave_breakout(var_0) {
  level endon("ps_rogers_first_kill_done");
  common_scripts\utility::flag_wait_any("ps_charlie_second_enemy_alerted", "guard_platform_alerted");
  level.guard_platform thread delay_stealth_break(1);
  self stopanimscripted();
  var_0 notify("stop_loop");

  if(common_scripts\utility::flag("charlie_posted_up")) {
    var_0 maps\_anim::anim_single_solo(self, "factory_power_stealth_ally_corner_exit");
  }

  self.goalradius = 64;
  self setgoalpos(level.guard_platform.origin);
  self.ignoreall = 0;
  self.favoriteenemy = level.guard_platform;
  level.guard_platform waittill("death");
}

ps_final_wave() {
  common_scripts\utility::flag_wait("ps_second_kills_done");

  foreach(var_1 in level.squad) {
  var_1 pushplayer(0);
  }

  common_scripts\utility::flag_wait_all("powerstealth_end", "ps_break_area_done");
  common_scripts\utility::flag_set("ps_final_kills_done");

  foreach(var_1 in level.squad) {
  var_1 maps\_utility::enable_ai_color_dontmove();
  }

  maps\factory_util::safe_trigger_by_targetname("sca_ps_final_kills_done");
}

ps_final_wave_alpha() {
  level endon("railgun_reveal_setup");
  var_0 = getent("vol_ps_baker_final_kill", "script_noteworthy");

  if(level.player istouching(var_0) && !common_scripts\utility::flag("ps_break_area_triggered")) {
    wait 0.3;
  }

  var_1 = getent("vol_ps_top_level", "script_noteworthy");
  var_2 = getent("vol_ps_rogers_wait_for_melee_kill", "script_noteworthy");

  if(level.player istouching(var_1) || level.player istouching(var_2)) {
    common_scripts\utility::flag_wait_or_timeout("ps_foreman_office_entry", 12.0);
  }

  common_scripts\utility::flag_set("start_break_area_kill");
  self pushplayer(0);

  if(level.player istouching(var_0)) {
    thread maps\_utility::smart_dialogue("factory_mrk_cmonletsmove");
  }

  ps_final_wave_alpha_execution_scene();

  if(!common_scripts\utility::flag("ps_break_area_triggered")) {
    ps_final_wave_alpha_execute();
  }
  else {
    ps_final_wave_alpha_breakout();
  }

  var_3 = getnode("ALLY_ALPHA_weapon_security_node", "targetname");
  maps\_anim::anim_reach_cleanup_solo(level.squad["ALLY_ALPHA"]);
  self setgoalnode(var_3);
  maps\_utility::enable_ai_color_dontmove();
  self waittill("goal");
  self pushplayer(0);
  maps\_utility::enable_bulletwhizbyreaction();
  self.ignoresuppression = 0;
  self.ignorerandombulletdamage = 0;
  self.disablefriendlyfirereaction = 0;
  self.disableplayeradsloscheck = 0;
  setsaveddvar("ai_friendlyFireBlockDuration", level.ai_friendlyfireblockduration);
  thread maps\_utility::smart_radio_dialogue("factory_mrk_bottomclear");
  common_scripts\utility::flag_set("ps_alpha_done");
}

ps_final_wave_alpha_execution_scene() {
  level endon("ps_break_area_triggered");
  self.goalradius = 8;
  var_0 = getent("alpha_final_kill_origin", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "factory_power_stealth_breakarea_ally_shoot");
  var_0 thread maps\_anim::anim_single_solo(self, "factory_power_stealth_breakarea_ally_shoot");
}

break_area_dialogue(var_0, var_1) {
  level endon("ps_break_area_triggered");
  level endon("break_area_first_dead");
  var_0 endon("death");
  var_1 endon("death");
  var_0 maps\_utility::dialogue_queue("factory_sp1_miranomeimporta");
  wait 0.5;
  var_1 maps\_utility::dialogue_queue("factory_sp2_peroyaterminaronlas");
  wait 0.5;
  var_0 maps\_utility::dialogue_queue("factory_sp1_ycuandosesupone");
  wait 0.5;
  var_1 maps\_utility::dialogue_queue("factory_sp2_elseorventuradijo");
  wait 0.5;
  var_0 maps\_utility::dialogue_queue("factory_sp1_puesesperoquelo");
  wait 0.5;
  var_1 maps\_utility::dialogue_queue("factory_sp2_yoandoigual");
  wait 0.8;
  var_0 maps\_utility::dialogue_queue("factory_sp1_quhoratienes");
  wait 0.5;
  var_1 maps\_utility::dialogue_queue("factory_sp2_dosymedia");
  wait 0.5;
  var_0 maps\_utility::dialogue_queue("factory_sp1_putamadrenosquedan");
}

ps_alpha_pistol_switch(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("weapon_p226");
  var_1 linkto(var_0, "tag_inhand", (10, 0, 2), (0, 0, 0));
  level.pistol = var_1;
  wait 1.7;
  var_1 delete();
}

ps_alpha_pistol_fire(var_0) {
  if(!common_scripts\utility::flag("break_area_first_dead")) {
    level.squad["ALLY_ALPHA"] maps\factory_intro::safe_magic_bullet(level.pistol gettagorigin("tag_flash"), level.break_area_guard_array[0] getshootatpos(), "p226_tactical+silencerpistol_sp");
    common_scripts\utility::flag_set("break_area_first_dead");
  } else
    level.squad["ALLY_ALPHA"] maps\factory_intro::safe_magic_bullet(level.pistol gettagorigin("tag_flash"), level.break_area_guard_array[1] getshootatpos(), "p226_tactical+silencerpistol_sp");
}

ps_final_wave_alpha_breakout() {
  level endon("ps_break_area_done");
  self stopanimscripted();
  var_0 = getnode("alpha_final_kill_node", "script_noteworthy");
  self setgoalnode(var_0);
  self.ignoreall = 0;
  var_1 = [level.guard_tunnel, level.guard_breakarea_01, level.guard_breakarea_02];

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      self.favoriteenemy = var_3;

      while(!isDefined(var_3.alreadyshot) && isalive(var_3)) {
        wait 0.1;
      }
    }
  }

  wait 0.5;

  if(level.player istouching(getent("vol_ps_baker_final_kill", "script_noteworthy"))) {
    thread maps\_utility::smart_dialogue("factory_mrk_breaksover");
  }

  self.ignoreall = 1;
}

ps_final_wave_alpha_execute() {
  level endon("railgun_reveal_setup");
  var_0 = maps\_utility::get_living_ai("ps_break_area_a", "script_noteworthy");
  var_1 = maps\_utility::get_living_ai("ps_break_area_b", "script_noteworthy");
  level.break_area_guard_array = [var_0, var_1];

  foreach(var_0 in level.break_area_guard_array) {
  var_0 thread ps_check_for_player_damage();
  }

  wait 0.8;
  var_4 = getent("vol_ps_baker_final_kill", "script_noteworthy");

  if(level.player istouching(var_4) && !common_scripts\utility::flag("ps_break_area_triggered")) {
    thread maps\_utility::smart_dialogue("factory_mrk_breaksover");
    wait 0.3;
  }

  wait 0.65;
  common_scripts\utility::flag_set("ps_baker_at_final_kill");

  foreach(var_0 in level.break_area_guard_array) {
    if(isDefined(var_0) && isalive(var_0) && !isDefined(level.pistol)) {
      maps\_utility::cqb_aim(var_0);
      self shootblank();
      level.squad["ALLY_ALPHA"] maps\factory_intro::safe_magic_bullet(level.squad["ALLY_ALPHA"] gettagorigin("tag_flash"), var_0 getshootatpos());
    }

    wait 0.3;
  }

  maps\_utility::enable_pain();
  common_scripts\utility::flag_set("ps_break_area_done");
}

ps_final_wave_bravo() {
  level endon("railgun_reveal_setup");
  ps_final_wave_bravo_execute(level.guard_window_01);
  maps\_utility::enable_ai_color_dontmove();
  thread ps_bravo_at_door();
  thread maps\_utility::smart_radio_dialogue("factory_kgn_rightclear");
  common_scripts\utility::flag_set("ps_bravo_done");
}

ps_bravo_at_door() {
  var_0 = getnode("ALLY_BRAVO_weapon_security_node", "targetname");
  self.goalradius = 8;
  self setgoalnode(var_0);
  self waittill("goal");
  common_scripts\utility::flag_set("presat_bravo_in_position");
}

ps_final_wave_bravo_execute(var_0) {
  level endon("railgun_reveal_setup");
  common_scripts\utility::flag_wait_any("guard_window_01_dead", "ps_break_area_triggered", "keegan_killed_window_guard");

  if(level.player istouching(getent("vol_ps_with_keegan", "targetname"))) {
    thread maps\_utility::smart_dialogue("factory_kgn_lookslikehehad");
  }

  var_1 = getent("ps_guard_window_02_death", "script_noteworthy");

  if(isalive(level.guard_window_02)) {
    level.guard_window_02 thread railing_tumble_scene();
    level.guard_window_02.goalradius = 8;
    var_1 maps\_anim::anim_reach_solo(level.guard_window_02, "keegan_top_stairway_kill");
  }

  if(isalive(level.guard_window_02)) {
    var_1 thread maps\_anim::anim_single_solo(level.guard_window_02, "keegan_top_stairway_kill");
    level.guard_window_02.allowdeath = 1;
    maps\_utility::cqb_aim(level.guard_window_02);
    self.favoriteenemy = level.guard_window_02;
  }

  wait 2.2;

  if(isalive(level.guard_window_02)) {
    level.guard_window_02.allowdeath = 0;
    level.guard_window_02.a.nodeath = 1;

    for(var_2 = 0; var_2 < 3; var_2++) {
      self shootblank();
      maps\factory_intro::safe_magic_bullet(self gettagorigin("tag_flash"), level.guard_window_02 getshootatpos());
      wait 0.0769;
    }

    level.guard_window_02.deathanim = undefined;
    level waittill("guard_window_02_dead");
    thread powerstealth_dialogue_call(200, "factory_kgn_ekia");
  }

  maps\_utility::anim_stopanimscripted();
}

railing_tumble_scene() {
  level.guard_window_02 endon("death");
  wait 1.5;
  thread custom_door_open("door_ps_right_path_org", 100, 0.3);
  level.guard_window_02 thread maps\factory_audio::stealth_kill_railing_sfx();
  common_scripts\utility::flag_set("railing_tumble_kill_ready");
}

ps_final_wave_charlie() {
  level endon("presat_started");
  maps\_utility::enable_ai_color_dontmove();
  thread throat_stab_abort_monitor();

  if(!common_scripts\utility::flag("throat_stab_chair")) {
    charlie_signal();
  }

  var_0 = getent("vol_ps_rogers_wait_for_melee_kill", "script_noteworthy");

  if(level.player istouching(var_0) && isalive(level.sleeping_guard)) {
    wait 0.5;
    level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_dialogue("factory_hsh_makeitquietif");

    while(distance(level.player.origin, level.sleeping_guard.origin) < 600 && !common_scripts\utility::flag("throat_stab_chair") && isalive(level.sleeping_guard)) {
      wait 0.5;
    }
  } else
    common_scripts\utility::flag_wait("guard_tunnel_dead");

  if(!common_scripts\utility::flag("throat_stab_chair")) {
    charlie_finish_office();
  }
  else if(isDefined(level.sleeping_guard) && !isDefined(level.player.in_stab_animation)) {
    self.ignoreall = 0;
    self.favoriteenemy = level.sleeping_guard;
    level.sleeping_guard waittill("death");
    self.ignoreall = 1;
  }

  if(level.player istouching(getent("vol_ps_chair_office", "script_noteworthy"))) {
    self.goalradius = 8;
    maps\_utility::enable_cqbwalk();
    var_1 = getnode("charlie_post_office_idle", "script_noteworthy");
    self setgoalnode(var_1);
    maps\_anim::anim_reach_cleanup_solo(self);
  }

  maps\_utility::enable_ai_color_dontmove();
  maps\_utility::disable_cqbwalk();

  while(isDefined(level.player.in_stab_animation)) {
    wait 0.5;
  }

  maps\_utility::smart_radio_dialogue("factory_hsh_topclear");
  thread ps_charlie_at_door();
  common_scripts\utility::flag_set("ps_charlie_done");
}

ps_charlie_at_door() {
  var_0 = getnode("ALLY_CHARLIE_weapon_security_node", "targetname");
  self pushplayer(1);
  self.goalradius = 32;
  self setgoalnode(var_0);
  self waittill("goal");
  common_scripts\utility::flag_set("presat_charlie_in_position");
}

throat_stab_abort_monitor() {
  level.sleeping_guard endon("death");
  common_scripts\utility::flag_wait("throat_stab_sequence_aborted");
  common_scripts\utility::flag_set("throat_stab_chair");

  if(isDefined(level.sleep_guard)) {
    self.ignoreall = 0;
    self.favoriteenemy = level.sleeping_guard;
    self.goalradius = 8;
    self setgoalpos(level.sleeping_guard.origin);
    level.sleeping_guard waittill("death");
    self.ignoreall = 1;
  }
}

charlie_signal() {
  level endon("presat_started");
  level.sleeping_guard endon("death");
  level endon("throat_stab_chair");
  self.goalradius = 8;
  maps\_utility::disable_cqbwalk();
  var_0 = getnode("charlie_final_kill_post", "script_noteworthy");
  var_0 maps\_anim::anim_reach_and_approach_solo(self, "CornerStndR_alert_signal_enemy_spotted");
  maps\_utility::disable_cqbwalk();
  self waittill("goal");
  maps\_utility::enable_cqbwalk();
  var_1 = getent("vol_ps_rogers_signal_player", "script_noteworthy");

  if(level.player istouching(var_1)) {
    maps\_anim::anim_generic(self, "CornerStndR_alert_signal_enemy_spotted");
  }

  self setgoalnode(var_0);
  wait 0.5;
}

charlie_finish_office() {
  level endon("presat_started");
  level.sleeping_guard endon("death");
  level endon("throat_stab_chair");
  level endon("throat_stab_sequence_aborted");
  var_0 = getent("vol_ps_chair_office", "script_noteworthy");

  if(isalive(level.sleeping_guard) && !level.player istouching(var_0)) {
    self.goalradius = 64;
    self setgoalnode(getnode("charlie_post_office_idle", "script_noteworthy"));
    wait 1.0;
  }

  if(isalive(level.sleeping_guard)) {
    ps_final_wave_charlie_execute(level.sleeping_guard);
  }
}

ps_final_wave_charlie_execute(var_0) {
  level endon("presat_started");

  if(isalive(var_0) && !isDefined(level.player.in_stab_animation)) {
    self.goalradius = 16;
    var_1 = getnode("charlie_shoot_sleeper_node", "script_noteworthy");
    self setgoalnode(var_1);
    self waittill("goal");
    maps\_utility::disable_surprise();
    maps\_utility::cqb_aim(var_0);
    wait 0.2;
    thread flash();
    maps\factory_intro::safe_magic_bullet(self gettagorigin("tag_flash"), var_0 getshootatpos());
    var_0 kill();
    maps\_utility::enable_surprise();

    if(common_scripts\utility::flag("ps_foreman_office_entry")) {
      wait 0.8;
      level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_dialogue("factory_hsh_cmonadamletskeep");
    }
  }
}

ps_end() {
  common_scripts\utility::flag_wait_any("ps_alpha_done", "ps_bravo_done", "ps_charlie_done");
  var_0 = getEntArray("sca_ps_delete", "script_noteworthy");

  foreach(var_2 in var_0) {
  var_2 common_scripts\utility::trigger_off();
  }
}

flash() {
  playFXOnTag(common_scripts\utility::getfx("office_muzzle_flash"), self, "tag_flash");
}

setup_patrol() {
  self endon("death");
  self.animname = "generic";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.health = 1;
  self.moveplaybackrate = 1.4;
  self.patrol_walk = ["walk_gun_unwary", "patrol_bored_patrolwalk", "patrol_bored_patrolwalk_twitch"];
  self.patrol_idle = ["patrol_idle_stretch", "patrol_idle_smoke", "patrol_idle_checkphone"];
  maps\_utility::set_generic_run_anim_array(common_scripts\utility::random(self.patrol_walk));
  maps\_utility::set_generic_idle_anim(common_scripts\utility::random(self.patrol_idle));
  maps\_stealth_utility::stealth_default();

  if(isDefined(self.target)) {
    start_patrol(self.target);
  }
}

start_patrol(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  thread maps\_patrol::patrol(var_0);
}

powerstealth_dialogue_call(var_0, var_1) {
  if(!maps\_utility::players_within_distance(var_0, self.origin)) {
    maps\_utility::smart_radio_dialogue(var_1);
  }
}

handle_sleeping_guy(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.allowdeath = 1;
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0.dontevershoot = 1;
  var_0.health = 50;
  var_0.animname = "generic";
  var_0 maps\_utility::set_battlechatter(0);
  var_0.deathanim = % factory_power_stealth_opfor_console_death_shot;
  var_1 = maps\_utility::spawn_anim_model("chair");
  level.chair_col = getent("col_chair_rolling", "script_noteworthy");
  level.chair_col linkto(var_1, "tag_chair_collision", (0, 0, 0), (90, 0, 0));
  chair_col_setup();
  var_0 thread check_for_melee_stab(var_1);
  var_0 thread anim_sleep(var_1);
  var_0 thread wake_guy_up(var_1);

  if(isalive(var_0)) {
    var_0 waittill("death");
  }

  if(isDefined(level.player.in_stab_animation)) {
    level.player waittill("stab_finished");
  }
  else {
    var_1 thread maps\factory_audio::stealth_kill_console_sfx(var_0);
    var_1 thread knock_over_chair("sleeper_shot");
  }

  clean_up_stab();
  common_scripts\utility::flag_wait("presat_revolving_door_closed");
  var_1 delete();
}

ready_to_stab() {
  level.player allowmelee(0);
  level.player.ready_to_neck_stab = 1;
  var_0 = common_scripts\utility::within_fov(self.origin, self.angles, level.player.origin, 280);

  if(!var_0) {
    level.player maps\_utility::display_hint("chair_stab_hint");
  }

  common_scripts\utility::flag_set("ready_to_stab_neck");
}

clean_up_stab() {
  if(isDefined(level.player.ready_to_neck_stab) && level.player.ready_to_neck_stab) {
    level.player.ready_to_neck_stab = undefined;
    level.player allowmelee(1);
    common_scripts\utility::flag_clear("ready_to_stab_neck");
  }
}

check_for_melee_stab(var_0) {
  self endon("death");
  level.player endon("death");
  self endon("guy_waking_up");
  var_1 = 22500;

  for(;;) {
    var_2 = distancesquared(level.player.origin, self.origin);
    var_3 = abs(angleclamp180(level.player.angles[1] - self.angles[1]));

    if(var_3 < 45 && var_2 < var_1) {
      ready_to_stab();

      if(level.player meleebuttonpressed() && isalive(self) && !level.player ismeleeing() && !level.player isthrowinggrenade()) {
        thread throat_stab_me(var_0);
        return;
      }
    } else
      clean_up_stab();

    wait 0.05;
  }
}

throat_stab_me(var_0) {
  level.player.in_stab_animation = 1;
  thread maps\factory_audio::stealth_kill_throat_stab_sfx();
  common_scripts\utility::flag_set("throat_stab_chair");
  var_1 = maps\factory_intro::player_start_stabbing();
  level.player setstance("stand");
  level.player allowcrouch(0);
  var_2 = spawnStruct();
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_3 = [];
  var_3[0] = var_1;
  var_3[1] = self;
  var_4 = getent("sleeping_guard_node", "script_noteworthy");
  var_4 maps\_anim::anim_first_frame_solo(var_1, "throat_stab");
  var_5 = 0.4;
  level.player playerlinktoblend(var_1, "tag_player", var_5, 0.3, 0.08);
  wait(var_5);
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 show();

  if(isalive(self)) {
    var_1 show();
    var_1 attach("Viewmodel_knife_iw6", "tag_weapon_right", 1);
    var_0 thread knock_over_chair("throat_stab");
    var_4 maps\_anim::anim_single(var_3, "throat_stab");
    maps\_vignette_util::vignette_actor_kill();
    var_1 detach("Viewmodel_knife_iw6", "tag_weapon_right", 1);
    var_1 hide();
  }

  level.player unlink();
  var_1 delete();
  maps\factory_intro::player_done_stabbing();
  level.player.in_stab_animation = undefined;
  level.player notify("stab_finished");
  level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_dialogue("factory_hsh_niceonebro");
}

anim_sleep(var_0) {
  self endon("death");
  self endon("guy_waking_up");
  var_1 = getent("sleeping_guard_node", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "sleep_enter");
  common_scripts\utility::flag_wait("powerstealth_midpoint");
  var_1 thread maps\_anim::anim_single_solo(var_0, "sleep_enter");
  var_1 maps\_anim::anim_single_solo(self, "sleep_enter");
  var_1 thread maps\_anim::anim_loop_solo(self, "sleep_idle", "stop_loop");
}

wake_guy_up(var_0) {
  self endon("death");
  thread detect_player_proximity();
  wait_for_waking_event();
  self notify("guy_waking_up");
  common_scripts\utility::flag_set("throat_stab_sequence_aborted");
  self stopanimscripted();
  clean_up_stab();
  self.deathanim = undefined;
  var_1 = getent("sleeping_guard_node", "script_noteworthy");
  var_0 thread knock_over_chair("sleep_react");
  var_1 maps\_anim::anim_single_solo(self, "sleep_react");
  self notify("done_waking_up");
  maps\_utility::disable_surprise();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.dontevershoot = undefined;
  self.goalradius = 8;
  self setgoalpos(level.player.origin);
  self.health = 1;
  thread maps\_utility::set_battlechatter(1);
  thread maps\_utility::gun_recall();
}

detect_player_proximity() {
  self endon("death");
  self endon("guy_waking_up");
  common_scripts\utility::flag_wait("ps_alert_chair_guard");
  self notify("guy_waking_up");
}

wait_for_waking_event(var_0) {
  self endon("death");
  self endon("flashbang");
  self endon("guy_waking_up");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("explode");
  self addaieventlistener("projectile_impact");

  for(;;) {
    self waittill("ai_event", var_1);
    self notify("wake_up");
    thread delay_stealth_break(1);

    if(isDefined(var_0)) {
      common_scripts\utility::flag_set(var_0);
    }

    if(var_1 == "gunshot" || var_1 == "bulletwhizby" || var_1 == "explode") {
      return;
    }
  }
}

knock_over_chair(var_0) {
  if(!isDefined(self.knocked_over)) {
    self.knocked_over = 1;
    var_1 = getent("sleeping_guard_node", "script_noteworthy");

    if(var_0 == "sleeper_shot" || var_0 == "sleep_react") {
      thread maps\factory_audio::stealth_kill_console_chair_sfx();
    }

    var_1 maps\_anim::anim_single_solo(self, var_0);
    thread chair_col(var_0);
  }
}

chair_col(var_0) {
  self endon("done_with_collision");

  for(;;) {
    if(!maps\_utility::players_within_distance(96, self.origin)) {
      level.chair_col unlink();
      level.chair_col notsolid();
      level.chair_col delete();
      var_1 = "";

      switch (var_0) {
        case "sleeper_shot":
          var_1 = "_shot";
          break;
        case "throat_stab":
          var_1 = "_stabbed";
          break;
        case "sleep_react":
          var_1 = "_react";
          break;
      }

      var_2 = getent("col_chair_rolling" + var_1, "script_noteworthy");
      var_2 solid();
      self.knocked_over = 1;
      break;
    }

    wait 0.5;
  }

  self notify("done_with_collision");
}

chair_col_setup() {
  var_0 = getent("col_chair_rolling_shot", "script_noteworthy");
  var_1 = getent("col_chair_rolling_stabbed", "script_noteworthy");
  var_2 = getent("col_chair_rolling_react", "script_noteworthy");
  var_0 notsolid();
  var_1 notsolid();
  var_2 notsolid();
}

knock_over_chair_default(var_0) {
  var_0 endon("done_waking_up");
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5);
  self.knocked_over = 0;
  thread knock_over_chair("sleeper_shot");
}

custom_door_open(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_5 = getent(var_0, "targetname");
  var_6 = getEntArray(var_5.target, "targetname");

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_6[var_7] linkto(var_5);
  }

  var_8 = var_5.angles;
  var_5 rotateto(var_5.angles + (0, var_1, 0), var_2);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(var_6[var_7].classname != "script_model") {
      var_6[var_7] connectpaths();
    }
  }

  var_5 waittill("rotatedone");

  if(isDefined(var_3)) {
    if(!isDefined(var_4)) {
      var_4 = 3.5;
    }

    wait(var_4);
    var_5 rotateto(var_8, var_2 / 4);

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(var_6[var_7].classname != "script_model") {
        var_6[var_7] disconnectpaths();
      }
    }
  }
}

teleport_squad(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = ["ALLY_ALPHA", "ALLY_BRAVO", "ALLY_CHARLIE", "ALLY_ECHO"];
  }
  else {
    var_2 = ["ALLY_ALPHA", "ALLY_BRAVO", "ALLY_CHARLIE"];
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    maps\factory_util::actor_teleport(level.squad[var_2[var_3]], var_2[var_3] + "_" + var_0 + "_teleport");
    var_4 = getnode(var_2[var_3] + "_" + var_0 + "_node", "targetname");
    level.squad[var_2[var_3]] setgoalnode(var_4);
  }
}

teleport_squadmember(var_0, var_1) {
  maps\factory_util::actor_teleport(level.squad[var_1], var_1 + "_" + var_0 + "_teleport");
}

squad_stealth_on() {
  foreach(var_1 in level.squad) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 maps\_utility::enable_cqbwalk();
  }
}

squad_stealth_off() {
  foreach(var_1 in level.squad) {
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
    var_1 maps\_utility::disable_cqbwalk();
    var_1.moveplaybackrate = 1.0;
  }
}

conveyor_crate_setup() {
  thread spawn_crate_above_round_door();
  thread maps\factory_anim::conveyor_system();
}

spawn_crate_above_round_door() {
  level endon("presat_locked");
  level endon("stop_crate_conveyor_system");

  for(;;) {
    var_0 = randomintrange(0, 3);

    if(var_0 == 0) {
      var_1 = "shipping_frame_50cal";
    }
    else if(var_0 == 1) {
      var_1 = "shipping_frame_crates";
    }
    else if(var_0 == 2) {
      var_1 = "shipping_frame_minigun";
    }
    else {
      var_1 = "shipping_frame_crates";
    }

    var_2 = spawn("script_model", (6421, 1703, 550));
    var_2 setModel(var_1);
    var_2 thread crate_above_round_door_move();
    var_2 thread maps\factory_audio::audio_crate_move_above_door();
    wait(randomfloatrange(1.2, 5.0));
  }
}

crate_above_round_door_move() {
  self rotateto((6, 0, 0), 0.1);
  self moveto((8229, 1703, 348), 28);
  self waittill("movedone");
  self delete();
}

attach_flashlight(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self attach("com_flashlight_on", "tag_inhand", 1);
  self.have_flashlight = 1;
  flashlight_light(var_0, var_1, var_2);
  thread detach_flashlight_on_death();
}

detach_flashlight_on_death() {
  self waittill("death");

  if(isDefined(self)) {
    detach_flashlight();
    wait 0.25;
  }
}

detach_flashlight() {
  if(!isDefined(self.have_flashlight)) {
    return;
  }
  self detach("com_flashlight_on", "tag_inhand");
  flashlight_light(0);
  self.have_flashlight = undefined;
}

flashlight_light(var_0, var_1, var_2) {
  var_3 = "tag_light";

  if(var_0) {
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel("tag_origin");
    var_4 hide();
    var_4 linkto(self, var_3, (0, 0, 0), (0, 0, 0));
    thread flashlight_light_death(var_4);

    if(var_1) {
      if(var_2) {
        playFXOnTag(level._effect["flashlight_spotlight_rain"], var_4, "tag_origin");
        return;
      }

      playFXOnTag(level._effect["flashlight_spotlight_flare"], var_4, "tag_origin");
      return;
      return;
    }

    playFXOnTag(level._effect["flashlight"], var_4, "tag_origin");
    return;
  } else if(isDefined(self.have_flashlight))
    self notify("flashlight_off");
}

flashlight_light_death(var_0) {
  common_scripts\utility::waittill_either("death", "flashlight_off");
  var_0 delete();
  self.have_flashlight = undefined;
  waittillframeend;
  wait 0.1;

  if(!isDefined(self.dontdrop_flashlight)) {
    playFXOnTag(level._effect["dropped_flashlight_spotlight_runner"], self, "tag_inhand");
  }
}

ignore_move_suppression(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  for(;;) {
    if(self ismovesuppressed()) {
      maps\_utility::set_ignoresuppression(1);
      wait 4;
    } else if(isDefined(self.ignoresuppression) && self.ignoresuppression)
      maps\_utility::set_ignoresuppression(0);

    wait 0.25;
  }
}

move_warning_light(var_0, var_1, var_2) {
  level endon("presat_locked");
  var_3 = common_scripts\utility::spawn_tag_origin();
  playFXOnTag(level._effect["glow_red_light_400_strobe"], var_3, "tag_origin");
  var_4 = getent("reveal_crane_org", "targetname");

  for(;;) {
    var_3.origin = var_4.origin + (var_0, var_1, var_2);
    wait 0.05;
  }
}

rotate_warning_light() {
  level endon("presat_locked");

  for(;;) {
    self rotateyaw(360, 2);
    wait 2;
  }
}

animate_tank_crane() {
  var_0 = getEntArray("factory_entrance_tank_loading", "script_noteworthy");
  level.tank_crane_soundorg_loop = spawn("script_origin", (5400, 3044, 478));
  level.tank_crane_soundorg_start_stop = spawn("script_origin", (5400, 3044, 478));
  thread move_warning_light(-125, 0, -85);
  thread move_warning_light(65, 0, -85);
  wait 4.0;

  foreach(var_2 in var_0) {
  var_2 movex(-675, 18, 2, 6);
  }

  level.tank_crane_soundorg_loop movex(-675, 18, 2, 6);
  level.tank_crane_soundorg_start_stop movex(-675, 18, 2, 6);
  thread maps\factory_audio::audio_crane_movement_factory_reveal_01(18, 2, 6);
  wait 18.0;

  foreach(var_2 in var_0) {
  var_2 movez(-60, 10, 2, 6);
  }

  level.tank_crane_soundorg_loop movez(-44, 10, 2, 6);
  level.tank_crane_soundorg_start_stop movez(-44, 10, 2, 6);
}

factory_entrance_reveal_animate_pieces() {
  thread factory_entrance_reveal_animate_crane();
}

factory_entrance_reveal_animate_crane() {
  thread maps\factory_anim::allies_enter_factory_cranes();
}

factory_entrance_reveal_animate_loading_crate01a() {
  var_0 = getent("loading_container_01a_org", "targetname");
  var_0 thread loading_platform_lights(95, 70, 40);
  var_0 thread loading_platform_lights(-95, 70, 40);
  var_1 = getent("loading_crate01a_path02", "targetname");
  var_2 = [];
  var_2 = getEntArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
  var_4 linkto(var_0);
  }

  wait 0.7;
  wait 17.0;
  var_0 moveto(var_1.origin, 45.0, 1.0, 1.0);
}

factory_entrance_reveal_animate_loading_crate02() {
  var_0 = getent("loading_crate_02a_origin", "targetname");
  var_1 = getent("loading_crate02_path01", "targetname");
  var_2 = getent("loading_crate02a_path02", "targetname");
  var_3 = getent("loading_crate02a_path03", "targetname");
  var_4 = getent("loading_crate02a_path04", "targetname");
  var_5 = [];
  var_5 = getEntArray(var_0.target, "targetname");

  foreach(var_7 in var_5) {
  var_7 linkto(var_0);
  }

  var_0 moveto(var_1.origin, 0.7, 0.3, 0.3);
  wait 0.7;
  var_0 moveto(var_2.origin, 17.0, 1.0, 1.0);
  wait 17.0;
  var_0 moveto(var_3.origin, 10.0, 0.5, 0.5);
  wait 10.0;
  var_0 moveto(var_4.origin, 45.0, 1.0, 1.0);
  wait 10.0;
  wait 17.0;
}

factory_entrance_reveal_animate_loader01() {
  var_0 = getent("loader_platform01_org", "targetname");
  var_0 thread loading_platform_lights(95, 70, 40);
  var_0 thread loading_platform_lights(-95, 70, 40);
  var_1 = getent("loading_crate02a_path03", "targetname");
  var_2 = getent("loading_crate02a_path04", "targetname");
  var_3 = [];
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
  var_5 linkto(var_0);
  }

  var_7 = getent("loading_crate_02a_origin", "targetname");
  var_8 = [];
  var_8 = getEntArray(var_7.target, "targetname");

  foreach(var_10 in var_8) {
  var_10 linkto(var_7);
  }

  var_7.origin = var_0.origin + (0, 0, -15);
  var_7 linkto(var_0);
  var_0.origin = var_0.origin + (0, 0, 0);
  wait 20.8;
  var_0 moveto(var_2.origin, 45.0, 1.0, 1.0);
}

loading_platform_lights(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::spawn_tag_origin();
  playFXOnTag(level._effect["factory_moving_piece_light"], var_3, "tag_origin");
  var_3.origin = self.origin + (var_0, var_1, var_2);
  var_3 linkto(self);
  common_scripts\utility::flag_wait("open_exit_doors");
  stopFXOnTag(level._effect["factory_moving_piece_light"], var_3, "tag_origin");
  iprintlnbold("killing platform tag_origin");
  var_3 delete();
}

move_crates() {
  var_0 = getent("loader_platform01_org", "targetname");
  var_1 = getent("entrance_crate_01", "targetname");
  var_2 = getent("entrance_crate_02", "targetname");
  var_3 = getent("entrance_crate_03", "targetname");
  var_4 = getent("entrance_crate_04", "targetname");
  var_1 thread loading_platform_lights(0, 46, 90);
  var_2 thread loading_platform_lights(0, 46, 90);
  var_3 thread loading_platform_lights(0, 46, 90);
  var_4 thread loading_platform_lights(0, 46, 90);
  wait 2;
  var_1 movex(-440, 13);
  var_2 movex(-440, 13);
  var_3 movex(-900, 20);
  var_4 movex(-900, 20);
  var_1 waittill("movedone");
  var_1 movex(-130, 4);
  var_2 movey(-200, 5);
  var_2 waittill("movedone");
  var_1 movey(-200, 5);
  var_2 movex(-130, 4);
  var_3 movex(900, 20);
  var_4 movex(900, 20);
  var_2 waittill("movedone");
  var_3 movex(-900, 20);
  var_4 movex(-900, 20);
}

move_forklifts() {
  var_0 = getent("forklift_entrance01", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin + (0, 0, 70);
  var_1 linkto(var_0);
  playFXOnTag(level._effect["light_blink_forklift"], var_1, "tag_origin");
  common_scripts\utility::flag_wait("open_exit_doors");
  stopFXOnTag(level._effect["light_blink_forklift"], var_1, "tag_origin");
}

forkilft_movement() {
  var_0 = getent("forklift_entrance01", "targetname");
  var_1 = getent("forklift_loc_00", "targetname");
  var_2 = getent("forklift_loc_00a", "targetname");
  var_3 = getent("forklift_loc_01", "targetname");
  var_4 = getent("forklift_loc_01a", "targetname");
  var_5 = getent("forklift_loc_02", "targetname");
  var_6 = getent("forklift_loc_02a", "targetname");
  var_7 = getent("forklift_loc_03", "targetname");
  var_8 = getent("forklift_loc_03a", "targetname");
  var_9 = getent("forklift_loc_04", "targetname");
  var_10 = getent("forklift_loc_04a", "targetname");

  for(;;) {
    forklift_turnandmoveto(var_3);
    forklift_turnandmoveto(var_4);
    forklift_turnandmoveto(var_3);
    forklift_turnandmoveto(var_9);
    forklift_turnandmoveto(var_10);
    forklift_turnandmoveto(var_9);
    forklift_turnandmoveto(var_1);
    forklift_turnandmoveto(var_2);
    forklift_turnandmoveto(var_1);
    forklift_turnandmoveto(var_5);
    forklift_turnandmoveto(var_6);
    forklift_turnandmoveto(var_5);
    forklift_turnandmoveto(var_1);
    forklift_turnandmoveto(var_2);
    forklift_turnandmoveto(var_1);
    forklift_turnandmoveto(var_7);
    forklift_turnandmoveto(var_8);
    forklift_turnandmoveto(var_7);
  }
}

forklift_turnandmoveto(var_0) {
  var_1 = getent("forklift_entrance01", "targetname");
  var_1 moveto(var_0.origin, 3);
  var_1 waittill("movedone");
}