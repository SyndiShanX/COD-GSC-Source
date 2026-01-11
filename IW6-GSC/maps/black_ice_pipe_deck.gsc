/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_pipe_deck.gsc
****************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_pipe_deck_end");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_1");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_2");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_3");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_4");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_5");
  common_scripts\utility::flag_init("flag_vision_pipedeck_heat_fx");
  common_scripts\utility::flag_init("flag_pipe_deck_hat_1");
  common_scripts\utility::flag_init("flag_pipe_deck_hat_2");
  common_scripts\utility::flag_init("flag_pipe_deck_hat_3");
  common_scripts\utility::flag_init("flag_start_pipe_steam");
  common_scripts\utility::flag_init("flag_pd_godrays_start");
  common_scripts\utility::flag_init("flag_pipedeck_explosion");
  common_scripts\utility::flag_init("flag_heli_support_success");
  common_scripts\utility::flag_init("flag_pipedeck_player_killzone");
  common_scripts\utility::flag_init("flag_derrick_pipe_run_jump");
  common_scripts\utility::flag_init("flag_pipe_deck_mgs_down");
  common_scripts\utility::flag_init("flag_command_allies_enter");
}

section_precache() {
  precacheitem("panzerfaust3_straight");
}

section_post_inits() {
  level._pipe_deck = spawnStruct();
  level._fire_damage_ent = common_scripts\utility::spawn_tag_origin();
  level._pipe_deck.boats_struct = common_scripts\utility::getstruct("vignette_lifeboats", "script_noteworthy");

  if(isDefined(level._pipe_deck.boats_struct)) {
    level._pipe_deck.derrick_scene_struct = common_scripts\utility::getstruct("struct_derrick_scene", "targetname");

    if(maps\black_ice_util::start_point_is_before("mudpumps")) {
      common_scripts\utility::array_call(getEntArray("opt_hide_derrick", "script_noteworthy"), ::hide);
    }

    var_0 = getEntArray("turret_command", "script_noteworthy");

    foreach(var_2 in var_0) {
    var_2 makeunusable();
    }
  } else
    iprintln("black_ice_pipe_deck.gsc: Warning - Pipe Deck boats struct missing (compiled out?)");
}

start() {
  iprintln("Pipe_Deck");
  common_scripts\utility::flag_set("flag_fire_damage_on");
  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  maps\black_ice_util::player_start("player_start_pipe_deck");
  var_0 = ["struct_ally_start_pipe_deck_01", "struct_ally_start_pipe_deck_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  thread maps\black_ice_util::black_ice_geyser_pulse();
  thread pipedecklights();
  thread maps\black_ice_util::black_ice_geyser2_pulse();
  thread pipedeck_godrays();
  thread maps\black_ice_fx::fx_command_window_light_on();
  thread maps\black_ice_refinery::util_refinery_stack_cleanup();
  var_1 = maps\black_ice_tanks_to_mud_pumps::heli_spawn();
}

main() {
  thread dialogue();
  thread enemies();
  thread allies();
  thread threatbias();
  thread fx_command_snow();
  thread pipedeck_godrays();
  thread pipedecklights();

  if(maps\_utility::is_gen4()) {
    thread maps\black_ice_anim::vig_pipdeck_wires();
    thread maps\black_ice_anim::spawn_dead_bodies_pipe_deck();
  }

  light_com_center_lights_on();
  maps\_art::sunflare_changes("pipedeck", 0.1);
  thread util_open_exfil_door();
  thread event_boat_drop();
  thread heli();
  maps\black_ice_fx::pipe_deck_fx();
  maps\black_ice_fx::fx_command_window_light_on();
  level._vehicles["exfil_heli"] notify("stop_kicking_up_dust");
  common_scripts\utility::flag_wait("flag_pipe_deck_end");
  common_scripts\utility::flag_clear("flag_fx_screen_bokehdots_rain");
  level.player.ignoreme = 0;
  maps\_utility::trigger_wait_targetname("trig_command_allies_enter");
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "flag_command_allies_enter");
}

dialogue() {
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  level._allies[0] thread maps\_utility::smart_dialogue("blackice_bkr_upahead");
}

dialogue_boats_run() {
  wait(randomintrange(0, 1));
  var_0 = ["blackice_ru1_grabanak", "blackice_ru2_fallback"];
  maps\_utility::smart_dialogue(common_scripts\utility::random(var_0));
}

dialogue_mgs_1() {
  level endon("flag_pipe_deck_mgs_down");
  wait 5;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_getthosemgsdown");
  level notify("dialogue_mgs_done");
}

dialogue_mgs_2() {
  level endon("flag_pipe_deck_mgs_down");
  level waittill("notify_one_mg_left");
  level._allies[1] maps\_utility::smart_dialogue("black_ice_hsh_gotanothermgon");
}

dialogue_end() {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_twoonebalconyssecureyoure");
  maps\_utility::smart_radio_dialogue("black_ice_oby_copykeeganlightit");
  level notify("notify_heli_support_final");
}

allies() {
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_pain);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoresuppression, 1);
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::ignore_everything);
  maps\_utility::disable_trigger_with_targetname("trig_command_allies_enter");
  level._allies thread maps\black_ice_util_ai::ally_advance_watcher("trig_derrick_allies_1", "derrick_main", "flag_pipe_deck_end");
  maps\_utility::trigger_wait_targetname("trig_pipe_deck_ally_boats");
  level._allies[0] maps\_utility::enable_cqbwalk();
  wait 2;
  level maps\_utility::wait_for_notify_or_timeout("stop_ally_cqb_kill", 7);
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::unignore_everything);
  common_scripts\utility::flag_wait("flag_pipe_deck_end");
  maps\_utility::enable_trigger_with_targetname("trig_command_allies_enter");
  maps\_utility::activate_trigger_with_targetname("trig_derrick_ally_7");
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_pain);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoresuppression, 0);
}

enemies() {
  level._enemies["derrick_main"] = [];
  level._enemies["derrick_balcony"] = [];
  maps\_utility::array_spawn_function_targetname("enemy_derrick_scene", ::spawnfunc_enemies_derrick_heat_shield);
  maps\_utility::array_spawn_function_targetname("enemy_pipe_deck_wave_1_2", ::spawnfunc_enemies_pipe_run);
  maps\_utility::array_spawn_function_noteworthy("enemy_boat_scene_01", ::spawnfunc_enemies_boats, 1);
  maps\_utility::array_spawn_function_noteworthy("enemy_boat_scene_02", ::spawnfunc_enemies_boats);
  maps\_utility::array_spawn_function_noteworthy("enemy_pipedeck_command_balcony", ::spawnfunc_enemies_balcony);
  maps\_utility::array_spawn_function_noteworthy("enemy_pipedeck_spawner", ::spawnfunc_enemies_generic);
  maps\_utility::array_spawn_function_noteworthy("enemy_pipedeck_spawner_ignore", ::spawnfunc_enemies_generic_ignore);
  maps\_utility::array_spawn_function_noteworthy("enemy_pipedeck_spawner_rush", ::spawnfunc_enemies_generic_rush);
  thread maps\black_ice_util_ai::retreat_watcher("trig_derrick_retreat", "derrick_main", "vol_retreat_derrick_1", 3);
  thread enemies_mg_watcher("derrick_balcony", "turret_command_2", "node_turret_command_2");
  thread enemies_mg_watcher("derrick_balcony", "turret_command_3", "node_turret_command_3");
  level waittill("notify_balcony_spawned");
  level notify("notify_pipedeck_final_battle_start");
  thread dialogue_mgs_1();
  thread dialogue_mgs_2();

  while(level._enemies["derrick_balcony"].size < 2) {
    wait 0.05;
  }

  var_0 = 0;

  while(level._enemies["derrick_balcony"].size > 0) {
    level._enemies["derrick_balcony"] = maps\_utility::remove_dead_from_array(level._enemies["derrick_balcony"]);

    if(!var_0 && level._enemies["derrick_balcony"].size == 1) {
      var_0 = 1;
      level notify("notify_one_mg_left");
    }

    wait 0.2;
  }

  common_scripts\utility::flag_set("flag_pipe_deck_mgs_down");
  thread dialogue_end();
  level waittill("notify_heli_support_final");
  thread maps\_spawner::killspawner(20);
  wait 3;
  var_1 = getent("vol_retreat_derrick_final", "script_noteworthy");
  var_2 = getnodearray("node_command_ground_retreat", "targetname");
  var_3 = getnode("node_command_balcony_retreat", "targetname");
  var_4 = sortbydistance(maps\_utility::remove_dead_from_array(level._enemies["derrick_main"]), var_1.origin);
  var_5 = maps\_utility::remove_dead_from_array(level._enemies["derrick_balcony"]);

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_7 = var_4[var_6];

    if(var_6 < 3) {
      var_7 setgoalvolumeauto(var_1);
      var_7 maps\_utility::delaythread(5, maps\_utility_code::kill_deathflag_proc, 2);
      continue;
    }

    if(common_scripts\utility::random([0, 1, 2])) {
      var_7 thread maps\_utility_code::kill_deathflag_proc(2);
      continue;
    }

    var_7 setgoalnode(common_scripts\utility::random(var_2));
    var_7 maps\black_ice_util::ignore_everything();
    var_7 thread delete_at_goal();
  }

  common_scripts\utility::array_thread(var_5, common_scripts\utility::delaycall, randomfloatrange(0, 1), ::setgoalnode, var_3);
  common_scripts\utility::array_thread(var_5, maps\black_ice_util::ignore_everything);
  thread maps\_utility::ai_delete_when_out_of_sight(var_5, 256);
  wait 5;
  common_scripts\utility::flag_set("flag_pipe_deck_end");
}

delete_at_goal() {
  self endon("death");
  self.goalradius = 16;
  self waittill("goal");
  self delete();
}

spawnfunc_enemies_boats(var_0) {
  self.animname = self.script_parameters;
  self.v.instant_death = 0;
  self.a.disablelongdeath = 1;
  self.ignoreall = 1;
  self.maxfaceenemydist = 384;
  self.health = 1;

  if(isDefined(var_0) && var_0) {
    self.ragdoll_immediate = 1;
    self.v.death_on_end = 1;
  }

  var_1 = level._pipe_deck.boats_struct;

  if(issubstr(self.animname, "6")) {
    self.v.prop = maps\_utility::spawn_anim_model("lifeboat_crates");
    self.v.prop hidepart("jbone_01");
    self.v.prop hidepart("jbone_02");
    self.v.prop hidepart("jbone_04");
    self.v.prop hidepart("jbone_05");
    getent("brush_pipedeck_crate_1", "targetname") linkto(self.v.prop, "jbone_03", (0, 0, 0), (0, 0, 0));
    var_1 maps\_anim::anim_first_frame_solo(self.v.prop, "lifeboat_deploy");
  }

  if(issubstr(self.animname, "7")) {
    self.v.prop = maps\_utility::spawn_anim_model("lifeboat_crates");
    self.v.prop hidepart("jbone_01");
    self.v.prop hidepart("jbone_02");
    self.v.prop hidepart("jbone_03");
    self.v.prop hidepart("jbone_04");
    getent("brush_pipedeck_crate_2", "targetname") linkto(self.v.prop, "jbone_05", (0, 0, 0), (0, 0, 0));
    var_1 maps\_anim::anim_first_frame_solo(self.v.prop, "lifeboat_deploy");
  }

  self endon("death");
  var_1 maps\_anim::anim_first_frame_solo(self, "lifeboat_deploy");
  maps\black_ice_util_ai::add_to_group("derrick_main");
  maps\_utility::trigger_wait_targetname("trig_pipe_deck_boats_scene_start");
  var_1 maps\black_ice_vignette::vignette_single_solo(self, "lifeboat_deploy");

  if(isDefined(var_0) && var_0) {
    return;
  }
  thread dialogue_boats_run();
  thread maps\black_ice_util_ai::ignore_to_goal();
}

spawnfunc_enemies_derrick_heat_shield() {
  maps\black_ice_util_ai::add_to_group("derrick_main");
  self.animname = self.script_parameters;
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 256;
  level._pipe_deck.derrick_scene_struct maps\black_ice_vignette::vignette_single_solo(self, "heat_shield_run");
}

spawnfunc_enemies_pipe_run() {
  maps\black_ice_util_ai::add_to_group("derrick_other");
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 384;
  self endon("death");
  thread maps\black_ice_util_ai::ignore_to_goal();
  common_scripts\utility::flag_wait("flag_derrick_pipe_run_jump");
  var_0 = getent("brush_pipe_run_blocker", "targetname");

  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 delete();
  }

  maps\black_ice_util_ai::add_to_group("derrick_main");
}

spawnfunc_enemies_balcony() {
  level notify("notify_balcony_spawned");
  self setthreatbiasgroup("balcony");
  self.script_forcegoal = 1;
  self.noragdoll = 1;

  if(issubstr(self.classname, "rpg")) {
    maps\black_ice_util_ai::add_to_group("derrick_balcony_rpg", 0);
  }
  else {
    maps\black_ice_util_ai::add_to_group("derrick_balcony", 0);
  }

  self.on_turret = 0;
  thread maps\black_ice_util_ai::ignore_to_goal();
}

deathfunc_balcony() {
  self.deathanim = level.scr_anim["generic"]["cw_falling_death"][randomint(level.scr_anim["generic"]["cw_falling_death"].size)];
}

spawnfunc_enemies_generic() {
  maps\black_ice_util_ai::add_to_group("derrick_main");
  self.maxfaceenemydist = 384;
}

spawnfunc_enemies_generic_ignore() {
  maps\black_ice_util_ai::add_to_group("derrick_main");
  self.maxfaceenemydist = 384;
  thread maps\black_ice_util_ai::ignore_to_goal();
}

spawnfunc_enemies_generic_rush() {
  maps\black_ice_util_ai::add_to_group("derrick_main", 0);
  self.maxfaceenemydist = 384;
}

enemies_mg_watcher(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");
  var_3.toparc = 0;
  var_4 = getent("brush_shield_" + var_1, "targetname");
  var_4.angles = (0, 0, -25);
  var_4.origin = var_3 gettagorigin("TAG_BARREL") + anglesToForward(var_3 gettagangles("TAG_FLASH")) * -20;
  var_4 linkto(var_3, "TAG_BARREL");
  var_4 delete();
  maps\_utility::trigger_wait("trig_derrick_balcony_spawn", "script_noteworthy");
  wait 2;
  var_5 = getnode(var_2, "targetname");

  if(!isDefined(level._enemies[var_0])) {
    level._enemies[var_0] = [];
  }

  var_6 = undefined;

  for(;;) {
    if(!isturretactive(var_3)) {
      var_7 = maps\_utility::remove_dead_from_array(level._enemies[var_0]);
      var_7 = sortbydistance(var_7, var_3.origin);

      if(var_7.size > 0) {
        if(!isDefined(var_6)) {
          foreach(var_9 in var_7) {
            if(!var_9.on_turret) {
              var_6 = var_9;
              var_6.on_turret = 1;
              break;
            }
          }
        } else if(isalive(var_6)) {
          var_11 = var_6 enemies_get_on_mg(var_0, var_3, var_5);

          if(isDefined(var_11)) {
            while(isturretactive(var_3)) {
              wait 0.05;
            }

            if(isalive(var_6)) {
              var_6.on_turret = 0;
            }
          }
        } else
          break;
      } else
        break;
    }

    wait 0.2;
  }

  var_3 turretfiredisable();
}

enemies_mg_watcher_shield_damage() {
  self endon("flag_pipe_deck_end");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage");
    self radiusdamage(self.origin, 128, 100, 100);
  }
}

enemies_get_on_mg(var_0, var_1, var_2) {
  self endon("death");
  self.on_turret = 1;
  self setgoalnode(var_2);
  self.goalradius = 16;
  self.fixednode = 1;
  self waittill("goal");
  maps\_spawner::use_a_turret(var_1);
  return 1;
}

threatbias() {
  level.player setthreatbiasgroup("player");
  createthreatbiasgroup("balcony");
  maps\_utility::trigger_wait("trig_derrick_allies_support_1", "script_noteworthy");
  setthreatbias("axis", "player", 300);
  maps\_utility::trigger_wait("trig_derrick_balcony_spawn", "script_noteworthy");
  maps\_utility::clearthreatbias("axis", "player");
  thread player_killzone();
}

player_killzone() {
  level endon("flag_pipe_deck_end");

  for(;;) {
    common_scripts\utility::flag_wait("flag_pipedeck_player_killzone");
    level.player.ignoreme = 0;
    setthreatbias("axis", "player", 1000);
    setthreatbias("axis", "allies", 0);
    var_0 = getaiarray("axis");

    if(var_0.size == 0) {
      break;
    }

    common_scripts\utility::array_thread(var_0, maps\_utility::set_baseaccuracy, 10);
    common_scripts\utility::flag_waitopen("flag_pipedeck_player_killzone");
    setthreatbias("axis", "player", 0);
    setthreatbias("axis", "allies", 1000);
    var_0 = getaiarray("axis");

    if(var_0.size == 0) {
      break;
    }

    common_scripts\utility::array_thread(var_0, maps\_utility::set_baseaccuracy, 1);
  }
}

heli() {
  var_0 = level._vehicles["exfil_heli"];
  var_0 thread heli_support_pipe_deck();
  var_0 thread heli_support_final();
}

heli_support_pipe_deck() {
  common_scripts\utility::flag_wait("flag_mudpumps_end");
  common_scripts\utility::flag_waitopen("flag_mudpumps_heli_scene_active");
  thread maps\black_ice_audio::sfx_heli_flyin_pipedeck(self);
  var_0 = common_scripts\utility::getstruct("struct_heli_mudpumps_stairs", "targetname");
  self setvehgoalpos(var_0.origin, 1);
  var_1 = getent("origin_heli_aim_boats_1", "script_noteworthy");
  self setlookatent(var_1);
  maps\_utility::trigger_wait_targetname("trig_pipe_deck_boats_scene_start");
  thread maps\black_ice_audio::sfx_heli_move_pipedeck(self);
  var_2 = common_scripts\utility::getstruct("struct_heli_boats", "targetname");
  self setvehgoalpos(var_2.origin, 1);
  thread heli_spot_on_single(var_1, 2);
  wait 5;
  var_3 = common_scripts\utility::getstructarray("struct_heli_aim_boats_2", "script_noteworthy");
  var_3 = sortbydistance(var_3, self.origin);

  for(var_4 = 1; var_4 < var_3.size; var_4++) {
    thread heli_spot_on_single(var_3[var_4], 1, 1);
    wait 1;
  }

  var_5 = common_scripts\utility::getstruct("struct_heli_boats_exit", "targetname");
  maps\_utility::vehicle_detachfrompath();
  self.currentnode = var_5;
  maps\_utility::vehicle_resumepath();
  heli_fire_turret_start();
  heli_spot_stop();
  wait 2;
  heli_fire_turret_stop();
  thread heli_support_leave();
  level waittill("notify_heli_leave");
  var_5 = common_scripts\utility::getstruct("struct_heli_leave_boats", "targetname");
  maps\_utility::vehicle_detachfrompath();
  self.currentnode = var_5;
  maps\_utility::vehicle_resumepath();
  self vehicle_setspeed(50);
}

heli_support_leave() {
  self clearlookatent();
  var_0 = getEntArray("enemy_pipe_deck_wave_1_2", "targetname")[0];
  var_1 = level._vehicles["exfil_heli"];
  var_2 = (var_1.origin[0] - 256, var_1.origin[1] - 1024, var_1.origin[2]);
  magicbullet("panzerfaust3_straight", var_0.origin, var_2);
  thread maps\black_ice_audio::sfx_heli_flyaway_boats(var_1);
  wait 1;
  level notify("notify_heli_leave");
}

heli_support_final() {
  level waittill("notify_heli_support_final");
  level thread maps\black_ice_util::waittill_notify_func("notify_heli_anim_fire_on", maps\_utility::delaythread, 1, maps\black_ice_fx::fx_command_window_light_off);
  thread maps\black_ice_audio::sfx_assault_heli_engine(self);
  thread maps\black_ice_audio::sfx_assault_heli_flyin();
  thread heli_fire_anim();
  self.turret_aim unlink();
  var_0 = getent("brushmodel_command_glass", "targetname");
  var_0 delete();
  var_1 = common_scripts\utility::getstruct("struct_heli_support", "script_noteworthy");
  maps\_utility::vehicle_detachfrompath();
  var_2 = [self, self.turret_aim];
  var_1 maps\_anim::anim_single(var_2, "final_support", undefined, 12);
  self notify("notify_stop_anim_turret_fire");
  self.turret_aim maps\_utility::anim_stopanimscripted();
  light_com_center_lights_off();
  thread maps\_vehicle_code::animate_drive_idle();
  self vehicle_setspeed(5);
  thread maps\_utility::vehicle_dynamicpath(common_scripts\utility::getstruct("struct_pipedeck_heli_idle", "targetname"));
  thread heli_spot_on_single(level._allies[0], 1.5);
  common_scripts\utility::flag_wait("flag_command_allies_enter");
  heli_spot_stop();
  self vehicle_setspeed(50);
  maps\_utility::vehicle_detachfrompath();
  thread maps\black_ice_audio::sfx_heli_flyaway_cmd_center(self);
  thread maps\_utility::vehicle_dynamicpath(common_scripts\utility::getstruct("struct_heli_leave_final", "targetname"));
  self waittill("reached_dynamic_path_end");
  self notify("deleted");
  self delete();
}

heli_spot_on_single(var_0, var_1, var_2) {
  self notify("notify_stop_heli_spot_single");
  self endon("notify_stop_heli_spot_single");
  self endon("deleted");
  var_3 = 0.5;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = 1;

  if(isDefined(var_2)) {
    var_4 = 0;
  }

  if(isai(var_0)) {
    while(isalive(var_0)) {
      if(var_4) {
        self setlookatent(var_0);
      }

      self.turret_aim moveto(var_0.origin + (0, 0, 32), var_3);
      wait 0.05;
    }
  } else if(var_0 == level.player) {
    for(;;) {
      if(var_4) {
        self setlookatent(var_0);
      }

      self.turret_aim moveto(var_0.origin + (0, 0, 32), var_3);
      wait 0.05;
    }
  } else {
    if(var_4) {
      self setlookatent(var_0);
    }

    self.turret_aim moveto(var_0.origin + (0, 0, 32), var_3);
    wait 0.05;
  }
}

heli_spot_stop() {
  self notify("notify_stop_heli_spot_single");
  self clearlookatent();
  self clearturrettarget();
  self.turret_aim linkto(self);
}

debug_heli_spot() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.turret_aim.origin;
  var_0 linkto(self.turret_aim);
  var_0 thread maps\black_ice_util::debug_pos_3d();
}

event_boat_drop() {
  var_0 = level._pipe_deck.boats_struct;
  var_1 = getEntArray("model_lifeboat", "targetname");

  foreach(var_3 in var_1) {
  var_3 maps\_utility::assign_animtree(var_3.script_parameters);
  }

  var_5 = maps\_utility::spawn_anim_model("lifeboat_crates");
  var_5 hidepart("jbone_03");
  var_5 hidepart("jbone_05");
  var_6[0] = var_5;
  var_6 = common_scripts\utility::array_combine(var_6, var_1);
  maps\_utility::trigger_wait_targetname("trig_pipe_deck_boats_scene_setup");
  var_0 maps\_anim::anim_first_frame(var_6, "lifeboat_deploy");
  maps\_utility::trigger_wait_targetname("trig_pipe_deck_boats_scene_start");
  var_0 thread maps\_anim::anim_single(var_6, "lifeboat_deploy");
}

heli_player_quake() {
  self endon("deleted");
  var_0 = 0.092;
  var_1 = 400;
  var_2 = 1750;

  for(;;) {
    var_3 = distance(level.player.origin, self.origin);
    var_4 = maps\black_ice_util::normalize_value(var_1, var_2, var_3);
    var_5 = maps\black_ice_util::factor_value_min_max(var_0, 0, var_4);

    if(var_5 > 0) {
      earthquake(var_5, 0.4, level.player.origin, 1000);
    }

    wait 0.17;
  }
}

heli_player_rumble() {
  self endon("deleted");

  for(;;) {
    self playrumbleonentity("hind_flyover");
    wait 0.15;
  }
}

heli_fire_anim() {
  self endon("notify_stop_anim_turret_fire");

  for(;;) {
    level waittill("notify_heli_anim_fire_on");
    heli_fire_turret_start();
    level waittill("notify_heli_anim_fire_off");
    heli_fire_turret_stop();
  }
}

heli_fire_turret_start() {
  if(!self.fire_turret) {
    self.fire_turret = 1;
    thread heli_fire_turret();
    thread heli_turret_ground_fx();
    thread maps\black_ice_audio::sfx_heli_turret_fire_start();
    thread maps\black_ice_audio::sfx_heli_turret_shells();
    playFXOnTag(common_scripts\utility::getfx("hind_shell_eject"), self, "tag_flash");
  }
}

heli_fire_turret_stop() {
  if(self.fire_turret) {
    self.fire_turret = 0;
    thread maps\black_ice_audio::sfx_heli_turret_fire_stop();
    thread maps\black_ice_audio::sfx_heli_turret_shells_stop();
    stopFXOnTag(common_scripts\utility::getfx("hind_shell_eject"), self, "tag_flash");
  }
}

heli_fire_turret() {
  while(self.fire_turret) {
    self fireweapon();
    wait 0.1;
  }
}

heli_turret_ground_fx() {
  var_0 = 0;

  while(self.fire_turret) {
    var_1 = self gettagorigin("tag_flash");
    var_2 = var_1 + anglesToForward(self gettagangles("tag_flash")) * 1000;
    var_3 = bulletTrace(var_1, var_2, 0);

    if(var_3["surfacetype"] != "none") {
      self.turret_impact.origin = var_3["position"];
      self.turret_impact.angles = vectortoangles(var_3["normal"]);

      if(!var_0) {
        playFXOnTag(common_scripts\utility::getfx("hind_turret_impacts"), self.turret_impact, "tag_origin");
        thread maps\black_ice_audio::sfx_heli_turret_fire_squibs();
        var_0 = 1;
      }
    } else if(var_0) {
      stopFXOnTag(common_scripts\utility::getfx("hind_turret_impacts"), self.turret_impact, "tag_origin");
      thread maps\black_ice_audio::sfx_heli_turret_fire_squibs_stop();
      var_0 = 0;
    }

    wait 0.05;
  }

  if(var_0) {
    stopFXOnTag(common_scripts\utility::getfx("hind_turret_impacts"), self.turret_impact, "tag_origin");
    thread maps\black_ice_audio::sfx_heli_turret_fire_squibs_stop();
  }
}

util_open_exfil_door() {
  var_0 = level._exfil.door;
  maps\_utility::trigger_wait_targetname("trig_exfil_door_open");
  var_0 maps\black_ice_util::open_door([120, -20], 0.6);
  maps\black_ice_fx::fx_command_interior_on();
}

fx_command_snow() {
  var_0 = 0;

  for(;;) {
    if(common_scripts\utility::flag("flag_vision_command")) {
      if(var_0 == 0) {
        common_scripts\utility::exploder("command_snow");
        var_0 = 1;
      }
    } else if(var_0 == 1) {
      maps\_utility::stop_exploder("command_snow");
      var_0 = 0;
    }

    wait(level.timestep);
  }
}

light_com_center_lights_on() {
  var_0 = getent("comms_overhead_1", "targetname");
  var_1 = getent("comms_overhead_2", "targetname");
  var_0 setlightintensity(10);
  var_1 setlightintensity(10);
  var_2 = getEntArray("comms_uplight", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] setlightintensity(10);
  }
}

light_com_center_lights_off() {
  var_0 = getent("comms_overhead_1", "targetname");
  var_1 = getent("comms_overhead_2", "targetname");
  var_0 setlightintensity(2);
  var_1 setlightintensity(2);
  var_2 = getEntArray("comms_uplight", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] setlightintensity(0.01);
  }
}

pipedeck_godrays() {
  var_0 = getent("cc_gr_origin", "targetname");

  if(maps\_utility::is_gen4()) {
    maps\black_ice_util::god_rays_from_world_location(var_0.origin, "flag_pd_godrays_start", "flag_teleport_rig", undefined, undefined);
  }
}

light_command_lights_out() {
  level waittill("notify_command_lights_out");
  light_com_center_lights_off();
}

pipedecklights() {
  var_0 = getEntArray("lights_pipedeck_a", "targetname");
  var_1 = getEntArray("lights_pipedeck_b", "targetname");
  var_2 = getEntArray("lights_pipedeck_c", "targetname");
  var_3 = [getent("escape_emergency_1", "targetname")];

  foreach(var_5 in var_1) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_2) {
  var_5 setlightradius(12);
  }

  maps\_utility::trigger_wait("trig_lights_pipedeck_b", "targetname");

  foreach(var_5 in var_1) {
  var_5 setlightradius(400);
  }

  foreach(var_5 in var_2) {
  var_5 setlightradius(550);
  }

  maps\_utility::trigger_wait("trig_lights_pipedeck_a", "targetname");

  foreach(var_5 in var_0) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_1) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_2) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_3) {
  var_5 setlightradius(12);
  }

  level waittill("flag_start_lights");

  foreach(var_5 in var_3) {
  var_5 setlightradius(350);
  }
}