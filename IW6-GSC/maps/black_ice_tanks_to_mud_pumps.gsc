/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_tanks_to_mud_pumps.gsc
*************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_vignette_engineroom_workers_door");
  common_scripts\utility::flag_init("flag_vignette_engineroom_workers_hallway");
  common_scripts\utility::flag_init("flag_engine_room_hallway");
  common_scripts\utility::flag_init("flag_top_drive_walkway");
  common_scripts\utility::flag_init("flag_vision_mudpumps");
  common_scripts\utility::flag_init("flag_vision_engine_room");
  common_scripts\utility::flag_init("flag_tanks_end");
  common_scripts\utility::flag_init("flag_engine_room_end");
  common_scripts\utility::flag_init("flag_player_crouching");
  common_scripts\utility::flag_init("flag_engine_room_nodamage");
  common_scripts\utility::flag_init("flag_mudpumps_end");
  common_scripts\utility::flag_init("flag_fire_damage_on");
  common_scripts\utility::flag_init("flag_player_at_topdrive");
  common_scripts\utility::flag_init("flag_topdrive_duck_ally1");
  common_scripts\utility::flag_init("flag_topdrive_duck_ally2");
  common_scripts\utility::flag_init("flag_mudpumps_heli_scene_active");
  common_scripts\utility::flag_init("flag_topdrive_ally1_full_anim");
}

section_precache() {
  maps\_utility::add_hint_string("hint_crouch_stance", & "BLACK_ICE_ENGINE_ROOM_SMOKE_DUCK", ::hint_crouch);
  maps\_utility::add_hint_string("hint_crouch_crouch", & "BLACK_ICE_ENGINE_ROOM_SMOKE_DUCK_CROUCH", ::hint_crouch);
  precachestring(&"BLACK_ICE_ENGINE_ROOM_SMOKE_DEATH");
}

hint_crouch() {
  return 0 || (level.player getstance() != "stand" || !common_scripts\utility::flag("flag_vision_engine_room"));
}

section_post_inits() {
  level._tanks = spawnStruct();
  level._engine_room = spawnStruct();
  level._engine_room.damage_smoke_ent = common_scripts\utility::spawn_tag_origin();
  level._tanks.struct_bridge = common_scripts\utility::getstruct("struct_tanks_bridge_fall_scene", "targetname");

  if(isDefined(level._tanks.struct_bridge)) {
    level._tanks.pipe = getent("model_tanks_pipe", "targetname");
    level._tanks.pipe maps\_utility::assign_animtree("tanks_pipe");
    level._tanks.bridge = getent("model_tanks_bridge", "targetname");
    level._tanks.bridge maps\_utility::assign_animtree("tanks_bridge");
    level._tanks.bridge_destroyed = getent("model_tanks_bridge_damaged", "targetname");
    level._tanks.bridge_destroyed maps\_utility::assign_animtree("tanks_bridge");
    level._tanks.bridge_destroyed hide();

    if(maps\black_ice_util::start_point_is_before("tanks"))
      common_scripts\utility::array_call(getEntArray("opt_hide_tanks", "script_noteworthy"), ::hide);

    var_0 = [level._tanks.pipe, level._tanks.bridge_destroyed, level._tanks.bridge];
    level._tanks.struct_bridge maps\_anim::anim_first_frame(var_0, "tanks_bridge_fall_scene");
    level._engine_room.baker_enter_struct = common_scripts\utility::getstruct("struct_engine_room_baker_enter", "targetname");
    level._engine_room.door = maps\black_ice_util::setup_door("model_engine_room_door", undefined, "jnt_door");
  } else
    iprintln("black_ice_tanks_to_mud_pumps.gsc: Warning - Tanks bridge struct missing (compiled out?)");
}

start_tanks() {
  iprintln("Tanks");
  maps\black_ice_util::player_start("player_start_tanks");
  var_0 = ["struct_ally_start_tanks_01", "struct_ally_start_tanks_02"];
  common_scripts\utility::exploder("tanks_oil_rain");
  common_scripts\utility::exploder("tanks_lights");
  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  level._allies maps\black_ice_util::teleport_allies(var_0);
}

start_engine_room() {
  iprintln("Engine Room");
  common_scripts\utility::flag_set("flag_fire_damage_on");
  maps\black_ice_util::player_start("player_start_derrick");
  var_0 = ["struct_ally_start_derrick_01", "struct_ally_start_derrick_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_cqbwalk);
  thread engineroom_door();
  thread maps\black_ice_fx::engineroom_turn_on_fx();
  thread maps\black_ice_util::black_ice_geyser2_pulse();
  common_scripts\utility::exploder("tanks_oil_rain");
  common_scripts\utility::exploder("tanks_lights");
  maps\_utility::stop_exploder("refinery_lights");
}

start_mudpumps() {
  iprintln("Mudpumps");
  common_scripts\utility::flag_set("flag_fire_damage_on");
  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  maps\black_ice_util::player_start("player_start_mudpumps");
  var_0 = ["struct_ally_01_start_mudpumps", "struct_ally_02_start_mudpumps"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  thread maps\black_ice_fx::engineroom_turn_on_fx();
  thread maps\black_ice_anim::ambient_derrick_animation();
  thread maps\black_ice_refinery::util_show_destroyed_derrick();
  thread maps\black_ice_util::black_ice_geyser2_pulse();
}

main_tanks() {
  common_scripts\utility::array_call(getEntArray("opt_hide_tanks", "script_noteworthy"), ::show);
  thread dialogue_tanks();
  thread allies_tanks();
  thread enemies_tanks();
  thread event_tanks_bridge_fall_scene();
  thread util_flicker_geyeser_light();
  common_scripts\utility::flag_wait("flag_tanks_end");
}

main_engine_room() {
  thread dialogue_engine_room();
  thread allies_engine_room();
  thread enemies_engine_room();
  common_scripts\utility::flag_set("flag_fire_damage_on");
  common_scripts\utility::flag_clear("flag_fx_screen_bokehdots_rain");
  maps\_art::sunflare_changes("mudpumps", 0.1);
  thread maps\black_ice_anim::ambient_derrick_animation();
  thread maps\black_ice_refinery::util_show_destroyed_derrick();
  thread maps\black_ice_audio::sfx_delete_refinery_fire_nodes();
  thread maps\black_ice_audio::sfx_delete_refinery_alarm_node();
  maps\_utility::stop_exploder("refinery_lights");
  common_scripts\utility::flag_wait("flag_engine_room_end");
}

main_mudpumps() {
  common_scripts\utility::array_call(getEntArray("opt_hide_derrick", "script_noteworthy"), ::show);
  thread event_topdrive_fall();
  thread dialogue_mudpumps();
  thread allies_mudpumps();
  thread cleanup_topdrive();
  thread maps\black_ice_refinery::util_refinery_stack_cleanup();

  if(maps\_utility::is_gen4())
    thread maps\black_ice_anim::spawn_dead_bodies_mudpumps();

  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  thread maps\black_ice_fx::fx_command_window_light_on();
  maps\_utility::stop_exploder("tanks_oil_rain");
  maps\_utility::stop_exploder("tanks_lights");
  common_scripts\utility::flag_wait("flag_mudpumps_end");
}

dialogue_tanks() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::smart_radio_dialogue("blackice_bkr_securedexfil");
  level._allies[0] maps\_utility::smart_dialogue("blackice_diz_inoursights");
  maps\_utility::smart_radio_dialogue("blackice_bkr_commandcenter");
}

dialogue_engine_room() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  level waittill("notify_dialogue_stay_low");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_staylowmovefast");
  maps\_utility::trigger_wait_targetname("trig_engine_room_hallway");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
}

dialogue_mudpumps() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::flag_wait("flag_top_drive_walkway");
  maps\_utility::smart_radio_dialogue("black_ice_oby_oneonewereonstation");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_copythatjustkeep");
}

allies_tanks() {
  var_0 = level._allies[0];
  var_0 pushplayer(1);
  thread maps\black_ice_util::flag_wait_func("flag_engineroom_player_start", common_scripts\utility::flag_set, "flag_tanks_end");
  common_scripts\utility::flag_wait("flag_tanks_engineroom_door");
  maps\_utility::trigger_wait_targetname("trig_baker_kill_door_guys");

  if(level._enemies["engine_room_door"].size > 0) {
    level notify("notify_stop_engineroom_entry_timeout");
    wait 1;
    var_0 maps\black_ice_util::ally_cqb_kill("engine_room_door");
    var_0 maps\_utility::disable_cqbwalk();
  }

  common_scripts\utility::flag_set("flag_tanks_end");

  if(!common_scripts\utility::flag("flag_engineroom_engagement_start")) {
    if(!common_scripts\utility::flag_exist("trig_allies_engine_room_start") || !common_scripts\utility::flag("trig_allies_engine_room_start"))
      maps\_utility::activate_trigger_with_targetname("trig_allies_engine_room_enter");

    var_1 = level._engine_room.baker_enter_struct;
    var_0 maps\_utility::disable_ai_color();
    var_1 maps\_anim::anim_reach_solo(var_0, "engine_room_enter");
    level notify("notify_dialogue_stay_low");
    var_1 maps\_anim::anim_single_solo(var_0, "engine_room_enter");
    var_0 maps\_utility::enable_ai_color();
    var_0 maps\_utility::enable_cqbwalk();
  }
}

allies_engine_room() {
  level._engine_room.vol = "vol_retreat_engine_room_1";
  level._allies thread maps\black_ice_util_ai::ally_advance_watcher("trig_allies_engine_room_start", "engine_room_extinguisher");
  level._allies[0] pushplayer(1);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_pain);
  common_scripts\utility::array_thread(level._allies, ::util_set_max_visible_dist);
  level.player util_set_max_visible_dist();
  level._allies[0] maps\black_ice_util::ignore_everything();

  if(level.start_point == "engine_room") {
    level notify("notify_dialogue_stay_low");
    maps\_utility::activate_trigger_with_targetname("trig_allies_engine_room_enter");
    level._engine_room.baker_enter_struct maps\_anim::anim_single_solo(level._allies[0], "engine_room_enter");
    level._allies[0] maps\_utility::enable_ai_color();
    level._allies[0] maps\_utility::enable_cqbwalk();
  }

  common_scripts\utility::flag_wait("flag_vignette_engineroom_workers_hallway");

  if(!common_scripts\utility::flag("flag_engineroom_engagement_start") && level._enemies["engine_room_extinguisher"].size >= 3) {
    wait 1;
    level._allies[0] maps\black_ice_util::ally_cqb_kill("engine_room_extinguisher", 256, 1, 1, "flag_engineroom_engagement_start");
    wait 0.5;
  }

  level._allies[0] maps\black_ice_util::unignore_everything();
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoresuppression, 1);
  maps\_utility::activate_trigger_with_targetname("trig_engine_room_hallway");
  common_scripts\utility::flag_wait("flag_engine_room_end");
  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_pain);
  common_scripts\utility::array_thread(level._allies, ::util_clear_max_visible_dist);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoresuppression, 0);
  level.player util_clear_max_visible_dist();
}

allies_mudpumps() {
  level._allies[0].goalradius = 16;
  common_scripts\utility::flag_wait("flag_mudpumps_end");
  level._allies[0].goalradius = 2048;
}

util_set_max_visible_dist() {
  self.maxvisibledist_old = self.maxvisibledist;
  self.maxvisibledist = 384;
}

util_clear_max_visible_dist() {
  self.maxvisibledist = self.maxvisibledist_old;
}

player_smoke_duck() {
  self endon("notify_stop_player_smoke_duck");
  var_0 = 0;
  thread maps\black_ice_fx::engineroom_headsmoke_fx_start();
  thread maps\black_ice_fx::engineroom_heat_fx_shake();
  var_1 = 0;
  common_scripts\utility::flag_set("flag_player_crouching");

  for(;;) {
    if(self getstance() == "stand") {
      if(!common_scripts\utility::flag("flag_engine_room_nodamage")) {
        if(!var_1) {
          thread player_smoke_hint();
          var_1 = 1;
        }

        if(common_scripts\utility::flag("flag_player_crouching")) {
          common_scripts\utility::flag_clear("flag_player_crouching");
          setblur(0.5, 0.5);
          thread player_cough_rumble();
          thread player_cough_sound();
          thread player_cough_damage();
        }
      }
    } else if(!common_scripts\utility::flag("flag_player_crouching")) {
      common_scripts\utility::flag_set("flag_player_crouching");
      setblur(0, 0.5);
    }

    wait 0.05;
  }
}

player_smoke_hint() {
  self endon("notify_stop_player_smoke_duck");

  if(level.console || level.player usinggamepad())
    maps\_utility::display_hint("hint_crouch_stance");
  else if(maps\_utility::is_command_bound("+togglecrouch") || !maps\_utility::is_command_bound("+stance"))
    maps\_utility::display_hint("hint_crouch_crouch");
  else
    maps\_utility::display_hint("hint_crouch_stance");
}

player_cough_damage() {
  self endon("notify_stop_player_smoke_duck");
  level endon("flag_player_crouching");

  for(;;) {
    if(self.health > 40) {
      if(!common_scripts\utility::flag("flag_engine_room_nodamage"))
        self dodamage(40, level.player.origin, level._engine_room.damage_smoke_ent);
    } else if(!common_scripts\utility::flag("flag_engine_room_nodamage")) {
      level.player kill();
      setdvar("ui_deadquote", & "BLACK_ICE_ENGINE_ROOM_SMOKE_DEATH");
      maps\_utility::missionfailedwrapper();
    }

    wait 1;
  }
}

player_cough_rumble() {
  var_0 = 0;

  while(!common_scripts\utility::flag("flag_player_crouching") && common_scripts\utility::flag("flag_vision_engine_room")) {
    if(!common_scripts\utility::flag("flag_engine_room_nodamage")) {
      if(var_0 == 0) {
        self playrumblelooponentity("tank_rumble");
        var_0 = 1;
      }
    } else if(var_0 == 1) {
      stopallrumbles();
      var_0 = 0;
    }

    wait(level.timestep);
  }

  stopallrumbles();
}

player_cough_sound() {
  self endon("notify_stop_player_smoke_duck");
  level endon("flag_player_crouching");

  for(;;) {
    if(!common_scripts\utility::flag("flag_engine_room_nodamage"))
      maps\_utility::smart_radio_dialogue("blackice_plr_cough");

    wait 0.05;
  }
}

player_smoke_duck_end() {
  thread maps\black_ice_fx::engineroom_headsmoke_fx_end();
  self notify("notify_stop_player_smoke_duck");
  common_scripts\utility::flag_set("flag_player_crouching");
  stopallrumbles();
  setblur(0, 0.5);
}

enemies_tanks() {
  level._enemies["engine_room_door"] = [];
  thread enemies_engineroom_entry();
  maps\_utility::array_spawn_function_targetname("enemies_tanks_01", ::spawnfunc_enemy_tanks);
}

spawnfunc_enemy_tanks() {
  self endon("death");
  maps\black_ice_util_ai::add_to_group("tanks_run", 0);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 8;
  self waittill("goal");
  self delete();
}

enemies_engine_room() {
  thread enemies_engineroom_extinguisher("engine_room_extinguisher");
  maps\_utility::array_spawn_function_targetname("spawner_engine_room_extinguish", ::spawnfunc_engine_room_extinguisher_guys);
  maps\_utility::array_spawn_function_targetname("spawner_engine_room_attack", ::spawnfunc_engine_room_reinforcements);
  maps\_utility::array_spawn_function_targetname("spawner_engine_room_attack_retreat", ::spawnfunc_engine_room_reinforcements_2);
  thread enemies_engine_room_reinforcements();
  thread maps\black_ice_util_ai::retreat_watcher("trig_engineroom_retreat", "engine_room_extinguisher", "vol_retreat_engine_room_1", 3);
}

enemies_engine_room_reinforcements() {
  common_scripts\utility::flag_wait("flag_engineroom_engagement_start");
  maps\_utility::array_spawn_targetname("spawner_engine_room_attack");
}

event_tanks_bridge_fall_scene() {
  maps\_utility::trigger_wait_targetname("trig_tanks_enter");
  common_scripts\utility::flag_set("flag_tanks_catwalk_collapse");
  thread maps\black_ice_audio::sfx_blackice_catwalk_explode();
  thread maps\black_ice_fx::tanks_bridge_fall_explosions();
  thread maps\black_ice_fx::tanks_bridge_fall_fx();
  var_0 = getent("enemy_tanks_catwalk_scene_1", "targetname") maps\_utility::spawn_ai(1);
  var_1 = getent("enemy_tanks_catwalk_scene_2", "targetname") maps\_utility::spawn_ai(1);
  var_0.animname = "tanks_guy_1";
  var_1.animname = "tanks_guy_2";
  var_0.v.nogun = 1;
  var_1.v.nogun = 1;
  wait 0.05;
  var_0 maps\black_ice_util_ai::add_to_group("tanks_bridge", 0);
  var_1 maps\black_ice_util_ai::add_to_group("tanks_bridge", 0);
  level._tanks.struct_bridge thread tank_guy_anim(var_0, "tanks_bridge_fall_scene", "tanks_bridge_fall_death");
  level._tanks.struct_bridge thread tank_guy_anim(var_1, "tanks_bridge_fall_scene");
  var_2 = [level._tanks.pipe, level._tanks.bridge_destroyed, level._tanks.bridge];
  level._tanks.struct_bridge thread maps\_anim::anim_single(var_2, "tanks_bridge_fall_scene");
  level waittill("notify_bridge_model_swap");
  level._tanks.bridge hide();
  level._tanks.bridge_destroyed show();
}

tank_guy_anim(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("kill");
  thread maps\black_ice_vignette::vignette_single_solo(var_0, var_1, undefined, undefined, var_2);
  var_0 thread util_enable_death_anim();
  var_0 waittill("msg_vignette_start_anim_done");
  var_0 delete();
}

util_enable_death_anim() {
  self endon("death");
  self endon("kill");
  level waittill("notify_tanks_start_custom_death");
  self.v.death_anim_anytime = 1;
  level waittill("notify_tanks_end_custom_death");
  self.v.death_anim_anytime = 0;
}

enemies_engineroom_entry() {
  common_scripts\utility::flag_wait("flag_tanks_engineroom_door");
  thread engineroom_door();
  thread maps\black_ice_fx::engineroom_turn_on_fx();
  thread maps\black_ice_audio::sfx_tanks_door_open();
  var_0 = ["actor_vignette_engineroom_door_1", "actor_vignette_engineroom_door_2"];
  var_1 = ["ai0", "ai1"];
  var_2 = ["blackice_ru1_cough", "blackice_ru2_cough", "blackice_ru3_cough"];
  var_3 = [];
  var_4 = common_scripts\utility::getstruct("vignette_engineroom_workers", "script_noteworthy");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = getent(var_0[var_5], "targetname") maps\_utility::spawn_ai(1);
    var_6.animname = var_1[var_5];
    var_6.v.death_anim_anytime = 1;
    var_3 = common_scripts\utility::array_add(var_3, var_6);
    var_4 thread maps\black_ice_vignette::vignette_single_solo(var_6, "engineroom_workers_throughdoor", "engineroom_workers_idle", undefined, "engineroom_workers_death");
    var_6 thread enemies_engineroom_entry_cough(var_2[var_5]);
  }

  level._enemies["engine_room_door"] = var_3;
}

engineroom_door() {
  var_0 = level._engine_room.door;
  var_0 maps\black_ice_util::open_door([120, -10], 0.6);
  common_scripts\utility::flag_wait("flag_engine_room_end");
  var_0 maps\black_ice_util::close_door();
}

enemies_engineroom_entry_cough(var_0) {
  self endon("death");
  level endon("notify_stop_engineroom_entry_timeout");

  for(;;) {
    thread maps\_utility::play_sound_on_tag(var_0, undefined, 1, "notify_sound_end");
    self waittill("notify_sound_end");
  }
}

util_delete_on_vignette_kill(var_0) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0))
    var_0 delete();
}

enemies_engineroom_extinguisher(var_0) {
  level._enemies["engine_room_extinguisher"] = [];
  var_1 = getEntArray("spawner_engine_room_extinguish", "targetname");
  var_2 = [];
  var_2[0] = getent("origin_engine_room_extinguish_2", "targetname");
  var_2[1] = getent("origin_engine_room_extinguish_3", "targetname");
  var_2[2] = getent("origin_engine_room_extinguish_1", "targetname");
  common_scripts\utility::flag_wait("flag_engineroom_player_start");
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = maps\_utility::spawn_anim_model("extinguisher");
    var_6 = var_1[var_4] maps\_utility::spawn_ai(1);
    var_6.animname = "extinguisher_guy";
    var_6.v.prop = var_5;
    var_6.v.prop_launch = 1;
    var_2[var_4] thread maps\black_ice_vignette::vignette_single_solo(var_6, undefined, "extinguisher_loop" + (var_4 + 1), "extinguisher_loop_break" + (var_4 + 1));
    var_6 thread enemies_engineroom_extinguisher_fx(var_5);
    var_6 thread enemies_engineroom_extinguisher_interrupt();
    var_3 = common_scripts\utility::array_add(var_3, var_6);
  }

  level._enemies[var_0] = var_3;
}

enemies_engineroom_extinguisher_interrupt() {
  level waittill("msg_vignette_interrupt");
  common_scripts\utility::flag_set("flag_engineroom_engagement_start");

  if(isalive(self)) {
    wait 1;
    maps\_utility::enable_cqbwalk();
    maps\black_ice_util_ai::add_to_group("engine_room_extinguisher");
    util_set_max_visible_dist();
  }
}

enemies_engineroom_extinguisher_fx(var_0) {
  self endon("death");
  self endon("msg_vignette_interrupt");

  for(;;) {
    for(var_1 = 0; var_1 < 5; var_1++) {
      thread maps\black_ice_audio::sfx_blackice_fire_extinguisher_spray(var_0);
      playFXOnTag(common_scripts\utility::getfx("fire_extinguisher_spray"), var_0, "tag_fx");
      wait 0.1;
    }
  }
}

spawnfunc_engine_room_extinguisher_guys() {
  self.a.disablelongdeath = 1;
  self.v.interrupt_level = 1;
  self.v.interrupt_all_notifies = 1;
  maps\black_ice_util_ai::add_to_group("engine_room_extinguisher");
}

spawnfunc_engine_room_reinforcements() {
  maps\black_ice_util_ai::add_to_group("engine_room_extinguisher");
  maps\_utility::enable_cqbwalk();
  util_set_max_visible_dist();
  self.a.disablelongdeath = 1;
}

spawnfunc_engine_room_reinforcements_2() {
  maps\black_ice_util_ai::add_to_group("engine_room_extinguisher_2", "vol_retreat_derrick_2");
  self.a.disablelongdeath = 1;
  maps\black_ice_util::ignore_everything();
  self endon("death");
  wait 4;
  thread maps\_utility::ai_delete_when_out_of_sight([self], 256);
}

event_topdrive_fall(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_topdrive", "script_noteworthy");
  var_2 = common_scripts\utility::getstruct("struct_mudpumps_topdrive_duck", "targetname");
  maps\black_ice_util::array_thread_targetname("trig_mudpumps_player_spawn_heli", maps\black_ice_util::waittill_trigger, "notify_spawn_pipedeck_heli");
  thread maps\black_ice_util::waittill_trigger_ent_targetname("trig_mudpumps_player_spawn_heli", level.player, common_scripts\utility::flag_set, "flag_player_at_topdrive");
  var_1 thread heli_spawn();
  var_3 = getent("model_mudpmps_topdrive", "targetname");
  var_3 maps\_utility::assign_animtree("top_drive");
  var_4 = maps\_utility::spawn_anim_model("drill_pipe1", level.player.origin);
  var_5 = maps\_utility::spawn_anim_model("drill_pipe2", level.player.origin);
  var_6 = maps\_utility::spawn_anim_model("drill_pipe3", level.player.origin);
  var_7 = maps\_utility::spawn_anim_model("drill_pipe4", level.player.origin);
  var_8 = [var_3, var_4, var_5, var_6, var_7];
  var_1 maps\_anim::anim_first_frame(var_8, "fall");
  maps\_utility::trigger_wait_targetname("trig_top_drive_fall");
  level._allies[0] thread event_topdrive_fall_ally1_duck(var_2);
  level._allies[1] thread event_topdrive_fall_ally2_duck(var_2);
  wait 0.6;
  thread maps\black_ice_audio::sfx_blackice_engine_beam_fall(var_3);
  var_1 thread maps\_anim::anim_single(var_8, "fall");
  maps\black_ice_util::quake("scn_blackice_engine_dist_explo", 0.64);
}

event_topdrive_fall_ally1_duck(var_0) {
  maps\_utility::trigger_wait_targetname("trig_mudpumps_ally1_duck");
  var_0 maps\_anim::anim_reach_solo(self, "topdrive_duck");

  if(common_scripts\utility::flag("flag_player_at_topdrive"))
    var_0 maps\_anim::anim_single_solo(self, "topdrive_duck");
  else {
    common_scripts\utility::flag_set("flag_topdrive_ally1_full_anim");
    var_0 maps\_anim::anim_single_solo(self, "topdrive_duck_full");
  }

  maps\_utility::enable_ai_color();
  common_scripts\utility::flag_set("flag_topdrive_duck_ally1");
}

event_topdrive_fall_ally2_duck(var_0) {
  common_scripts\utility::flag_wait("flag_mudpumps_end");
  var_0 maps\_anim::anim_reach_solo(self, "topdrive_duck");
  var_0 maps\_anim::anim_single_solo(self, "topdrive_duck");
  maps\_utility::enable_ai_color();
  common_scripts\utility::flag_set("flag_topdrive_duck_ally2");
}

cleanup_topdrive() {
  var_0 = getent("brush_topdrive_blocker", "targetname");
  var_1 = getEntArray("topdrive_debris", "targetname");
  common_scripts\utility::array_call(var_1, ::hide);

  while(!common_scripts\utility::flag("flag_topdrive_duck_ally1") || !common_scripts\utility::flag("flag_topdrive_duck_ally2") || common_scripts\utility::flag("flag_vision_mudpumps") || common_scripts\utility::flag("flag_vision_engine_room"))
    wait 0.05;

  common_scripts\utility::array_call(var_1, ::show);
  var_0 moveto(var_0.origin - (0, 0, 136), 0.05);
}

heli_spawn() {
  common_scripts\utility::flag_set("flag_mudpumps_heli_scene_active");
  var_0 = 1;

  if(maps\black_ice_util::start_point_is_after("mudpumps"))
    var_0 = 0;

  if(var_0)
    level waittill("notify_spawn_pipedeck_heli");

  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("vehicle_exfil_helo");
  level._vehicles["exfil_heli"] = var_1;
  var_1 vehicle_turnengineoff();
  var_1.animname = "pipedeck_heli";
  var_1 maps\_vehicle::godon();
  var_1.fire_turret = 0;
  var_1.turret_move = 0;
  var_1.turret_aim = maps\_utility::spawn_anim_model("pipedeck_heli_target");
  var_1.turret_aim hide();
  var_1.turret_aim.origin = var_1 gettagorigin("tag_flash") + (anglesToForward(var_1 gettagangles("tag_flash")) + -1 * anglestoup(var_1 gettagangles("tag_flash")) * 256);
  var_1.turret_aim linkto(var_1);
  var_1.turret_impact = common_scripts\utility::spawn_tag_origin();
  var_1.turret_aim unlink();
  var_1 thread heli_turret_and_spotlight_aim(1.5);
  var_1 thread maps\black_ice_pipe_deck::heli_spot_on_single(level.player, 0.5, 1);

  if(var_0 && common_scripts\utility::flag("flag_player_at_topdrive") && common_scripts\utility::flag("flag_topdrive_ally1_full_anim"))
    var_1 thread heli_spot_search_intro();
  else
    var_1 heli_spotlight_on();

  var_1 thread maps\black_ice_pipe_deck::heli_player_quake();
  var_1 thread maps\black_ice_pipe_deck::heli_player_rumble();

  if(var_0) {
    thread maps\black_ice_audio::sfx_heli_flyin_mudpumps(var_1);
    maps\_anim::anim_single_solo(var_1, "heli_reveal");
    thread heli_loop(var_1);
    common_scripts\utility::flag_wait("flag_mudpumps_end");
    self notify("stop_loop");
    var_1 stopanimscripted();
    var_1 thread maps\_vehicle_code::animate_drive_idle();
  }

  common_scripts\utility::flag_clear("flag_mudpumps_heli_scene_active");
  return var_1;
}

heli_spotlight_on() {
  playFXOnTag(level._effect["heli_spotlight"], self, "tag_flash");
}

heli_spotlight_extrabright() {
  playFXOnTag(level._effect["heli_spotlight_bright"], self, "tag_flash");
  level waittill("flag_mudpumps_end");
  stopFXOnTag(level._effect["heli_spotlight_bright"], self, "tag_flash");
  playFXOnTag(level._effect["heli_spotlight_bright_fade"], self, "tag_flash");
}

heli_spot_search_intro() {
  wait 2.5;
  heli_spotlight_on();
  thread heli_spotlight_extrabright();
  common_scripts\utility::flag_wait("flag_player_at_topdrive");
  wait 3;
  thread maps\black_ice_pipe_deck::heli_spot_on_single(level._allies[0], 0.5, 1);
}

heli_loop(var_0) {
  level endon("flag_mudpumps_end");
  thread maps\_anim::anim_loop_solo(var_0, "heli_reveal_loop");
}

heli_turret_and_spotlight_aim(var_0) {
  self endon("noise_off");
  self endon("death");

  for(;;) {
    var_1 = (randomfloatrange(-1 * var_0, var_0), randomfloatrange(-1 * var_0, var_0), randomfloatrange(-1 * var_0, var_0));
    self setturrettargetent(self.turret_aim, var_1);
    wait 0.1;
  }
}

util_flicker_geyeser_light() {
  var_0 = getEntArray("tanks_geyser_1", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(2.5);
    var_2 thread maps\black_ice_util::flicker(0.2, 0.8);
  }
}