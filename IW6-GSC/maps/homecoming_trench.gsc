/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_trench.gsc
**************************************/

trench_spawn_functions() {
  maps\_utility::array_spawn_function_noteworthy("trench_main_friendlies", ::trench_main_friendlies);
  maps\_utility::array_spawn_function_noteworthy("trench_friendly_orange_guy", ::trench_friendly_orange_guy);
  getent("trench_artemis_guy", "script_noteworthy") maps\_utility::add_spawn_function(::trench_artemis_guy);
  maps\_utility::array_spawn_function_noteworthy("trench_artemis_friendlies", ::trench_artemis_friendlies);
  getent("trench_first_nh90_lander", "script_noteworthy") maps\_utility::add_spawn_function(::trench_first_nh90_lander);
  getent("trench_artemis", "targetname") maps\_utility::add_spawn_function(::trench_artemis);
  getent("trench_hovercraft_a10", "script_noteworthy") maps\_utility::add_spawn_function(::trench_hovercraft_a10);
  maps\_utility::array_spawn_function_targetname("trench_hovercraft", ::trench_hovercraft_over_moment);
  getent("trench_hovercraft_passer", "targetname") maps\_utility::add_spawn_function(::trench_hovercraft_side_sand);
  var_0 = getEntArray("tower_post_explosion_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_off);
}

beach_sequence_trenches() {
  common_scripts\utility::flag_wait("FLAG_start_trenches");
  common_scripts\utility::flag_set("FLAG_stop_trench_drones");
  setsaveddvar("ai_friendlysuppression", 1);
  setsaveddvar("ai_friendlyfireblockduration", 1);
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  level.mortar_min_dist = 700;
  level.mortarexcluders = [getaiarray("allies", "axis")];
  level.availabledrones = 25;
  var_0 = getEntArray("bunker_trench_drones", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 maps\homecoming_util::delete_safe();
    }
  }

  level notify("stop_mortars 0");
  thread maps\homecoming_util::set_mortar_on(3);
  thread maps\homecoming_util::ambient_distant_battlechatter("distant_battlechatter_beach", "beach_ambient_battlechatter_stop", "us");
  thread trench_custom_mortars();
  thread maps\homecoming_util::function_trigger_switch("beach_ambient_on", "beach_ambient_off", ::trench_beach_axis_ambient, ::trench_beach_axis_ambient_off, "stop_beach_ambient_switch", 1);
  thread maps\homecoming_util::function_trigger_switch("beach_start_stuff", "trenches_rightpath_start", ::trench_beach_allies_ambient, ::trench_beach_allies_ambient_off, "stop_beach_ambient_switch", 1);
  thread maps\homecoming_util::function_trigger_switch("trench_ambient_hovercrafts_on", "trench_hovecraft_trigger", ::trench_beach_ambient_hovercrafts_on, ::trench_beach_ambient_hovercrafts_off, "stop_beach_ambient_switch");
  level.trench_beach_hovercrafts = maps\_utility::array_spawn(getEntArray("trench_bunker_hovercrafts", "script_noteworthy"));
  level.hesh maps\homecoming_util::set_ai_array("trench_main_friendlies");
  level.hesh maps\homecoming_util::ignore_everything();
  level.hesh maps\_utility::enable_sprint();
  level.hesh maps\_utility::delaythread(8, maps\_utility::disable_sprint);
  level.hesh maps\_utility::delaythread(8, maps\homecoming_util::clear_ignore_everything);
  level.player setthreatbiasgroup("trench_player_squad");
  level.hesh setthreatbiasgroup("trench_player_squad");
  thread beach_trenches_combat();
  thread beach_trenches_dialogue();
  common_scripts\utility::flag_wait_any("FLAG_trench_a10_mechanic", "TRIGFLAG_a10_destroy_trench_tank");

  if(!common_scripts\utility::flag("TRIGFLAG_a10_destroy_trench_tank")) {
    level.a10_mechanic_skip_end_vo = 1;
    thread maps\homecoming_a10::a10_strafe_mechanic("player_a10_trench_area_3");
  }

  common_scripts\utility::flag_wait_any("FLAG_trench_tank_destroyed", "TRIGFLAG_a10_destroy_trench_tank");
  var_4 = getEntArray("trenches_hovercraft_runners", "targetname");
  maps\_utility::array_notify(var_4, "stop_drone_runners");
  level.drone_runner_group["hovercraftRunners"] = common_scripts\utility::array_removeundefined(level.drone_runner_group["hovercraftRunners"]);
  thread maps\homecoming_util::kill_over_time(level.drone_runner_group["hovercraftRunners"], 0, 0.5);
  maps\_utility::activate_trigger("trenches_moveup_trig4", "targetname");
  level notify("stop_trench_hovercraft_reinforcers");
  thread maps\homecoming_a10::a10_mechanic_off();
}

beach_trenches_dialogue() {
  common_scripts\utility::flag_wait("FLAG_hesh_balcony_wave");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("homcom_hsh_youregoodgetup");
  wait 0.5;
  thread maps\_utility::autosave_by_name("trench");
  maps\_utility::smart_radio_dialogue("homcom_hsh_enemytroopsadvancingout");
  common_scripts\utility::flag_wait("FLAG_trench_first_strafe_done");
  maps\_utility::smart_radio_dialogue("homcom_com_raptor21dronecontrols");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_rogerthatpatchme");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("homcom_dcon_raptor21weresurrounded");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_weremakingourway");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("homcom_com_alldefensiveunitsbe");

  if(!common_scripts\utility::flag("player_not_doing_strafe")) {
    common_scripts\utility::flag_wait("player_not_doing_strafe");
  }

  var_0 = getaiarray("allies");
  var_0 = common_scripts\utility::array_remove(var_0, level.hesh);
  var_1 = maps\homecoming_util::getclosest2d(level.player.origin, var_0);

  if(isDefined(var_1)) {
    var_1 maps\_utility::play_sound_on_tag("homcom_us2_sirthosetrenchesare", "j_head");
  }
  else {
    level.hesh maps\_utility::play_sound_on_tag("homcom_us2_sirthosetrenchesare", "j_head");
  }

  level.hesh maps\_utility::dialogue_queue("homcom_hsh_ifthattowergoes");
  common_scripts\utility::flag_wait("FLAG_trenches_hovercraft_spawned");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_commandwehavean");
  maps\_utility::smart_radio_dialogue("homcom_com_copythattheyvebeen");
  common_scripts\utility::flag_wait("FLAG_trench_tank_unload_complete");
  var_0 = getaiarray("allies");
  var_0 = common_scripts\utility::array_remove(var_0, level.hesh);
  var_1 = maps\homecoming_util::getclosest2d(level.player.origin, var_0);

  if(isDefined(var_1)) {
    var_1 maps\_utility::play_sound_on_tag("homcom_us2_enemytankpullingout", "j_head");
  }
  else {
    level.hesh maps\_utility::play_sound_on_tag("homcom_us2_enemytankpullingout", "j_head");
  }

  level.hesh maps\_utility::dialogue_queue("homcom_hsh_usethea10drones");
  common_scripts\utility::flag_set("FLAG_trench_a10_mechanic");
  common_scripts\utility::flag_wait("FLAG_trench_tank_destroyed");

  if(isDefined(level.player_destroyed_trench_tank)) {
    level.hesh maps\_utility::dialogue_queue("homcom_hsh_tankdestroyedgoodjob");
  }

  wait 1.5;
  maps\_utility::smart_radio_dialogue("homcom_dcon_raptor21weresurrounded");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_wilcowerealmostthere");
  thread beach_trenches_part2_dialogue();
}

beach_trenches_part2_dialogue() {
  common_scripts\utility::flag_wait("TRIGFLAG_start_trenches_part2");
  maps\homecoming_util::delete_ai_array("trench_artemis_frendlies");
  common_scripts\utility::flag_wait("TRIGFLAG_start_tower_destruction_sequence");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_dronecontrolenemyforces");
  maps\_utility::smart_radio_dialogue("homcom_dcon_rogerthatrepositioning");
  common_scripts\utility::flag_set("FLAG_allow_tower_a10");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_calleminmake");
  common_scripts\utility::flag_wait("FLAG_allow_a10_strafe_crash");
  common_scripts\utility::flag_wait("a10_strafe_complete");
  wait 5.9;
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_doorsopening");
  common_scripts\utility::flag_wait("FLAG_player_a10_lockon");
  maps\_utility::smart_radio_dialogue("homcom_dcon_enemylockonbeginning");
  maps\_utility::smart_radio_dialogue("homcom_dcon_dronetwosbeenhit");
}

beach_trenches_combat() {
  thread trenches_combat_right_path();
  thread initial_trench_enemies();
  thread trench_main_friendlies_respawner_logic();
  var_0 = getEntArray("trench_friendly_turret", "script_noteworthy");
  var_1 = getEntArray("trench_entrance_turret_targets", "targetname");

  foreach(var_3 in var_0) {
  var_3 thread maps\homecoming_util::turret_shoot_targets(var_1, 1);
  }

  maps\_utility::activate_trigger("trench_start_friendlies", "targetname");
  level endon("TRIGFLAG_player_entering_nest");
  maps\homecoming_util::waittill_trigger("trench_start_combat");
  var_5 = getent("trenches_bridge_runner", "targetname");
  var_5.randomdeath = [7, 15];
  var_5.drone_lookahead_value = 128;
  var_5 maps\_utility::add_spawn_function(maps\homecoming_drones::set_noragdoll);
  var_5 maps\_utility::add_spawn_function(maps\homecoming_drones::drone_bloodfx);
  var_5 maps\_utility::delaythread(3, maps\homecoming_drones::beach_path_drones);
  var_6 = getEntArray("trenches_hovercraft_runners", "targetname");

  foreach(var_8 in var_6) {
    var_8.randomdeath = [5, 20];
    var_8.drone_lookahead_value = 128;
    var_8 thread maps\homecoming_drones::beach_path_drones("hovercraftRunners");
  }

  maps\homecoming_util::waittill_trigger("trenches_street_trig");
  maps\_spawner::flood_spawner_scripted(getEntArray("trench_enemies_1_flooders", "targetname"));
  maps\homecoming_util::waittill_trigger("trench_chargers_1_trig");
  var_10 = getEntArray("trench_chargers_1", "targetname");

  if(isDefined(var_10[0])) {
    var_11 = common_scripts\utility::getstruct(var_10[0].target, "targetname");
    thread trench_chargers(var_10, var_11, 1.8, 3.5);
  }

  maps\_spawner::flood_spawner_scripted(getEntArray("trench_hescotower_lower_enemies", "targetname"));
  maps\homecoming_util::waittill_trigger("trenches_entrance_trig");
  var_12 = maps\homecoming_util::get_ai_array("trench_main_friendlies");

  foreach(var_14 in var_12) {
    var_14.ignorerandombulletdamage = 1;
    var_14.ignoresuppression = 1;
    var_14.disablebulletwhizbyreaction = 1;
  }

  var_5 thread maps\_utility::notify_delay("stop_drone_runners", randomintrange(2, 5));
  maps\_spawner::flood_spawner_scripted(getEntArray("trench_enemy_flooders_2", "targetname"));
  maps\homecoming_util::waittill_trigger("trenches_moveup_trig1");
  var_12 = maps\homecoming_util::get_ai_array("trench_main_friendlies");

  foreach(var_14 in var_12) {
    var_14.ignorerandombulletdamage = 0;
    var_14.ignoresuppression = 0;
    var_14.disablebulletwhizbyreaction = 0;
  }

  maps\_utility::activate_trigger("trench_moveup_watcher_namer", "script_noteworthy");
  maps\homecoming_util::waittill_trigger("trenches_rightpath_start");
  common_scripts\utility::flag_set("FLAG_start_trench_hovercraft_tank");
  var_1 = getEntArray("trench_hovercraft_turret_targets", "targetname");

  foreach(var_3 in var_0) {
  var_3 thread maps\homecoming_util::turret_shoot_targets(var_1, 1);
  }

  maps\_utility::activate_trigger("trenches_rightpath_moveup_watcher", "script_noteworthy");
  maps\homecoming_util::waittill_trigger("trenches_moveup_trig3");
  common_scripts\utility::flag_set("FLAG_halfway_through_trenches");
  var_20 = getEntArray("trench_flooders_tank", "targetname");

  if(var_20.size != 0) {
    maps\_spawner::flood_spawner_scripted(var_20);
  }
}

beach_trenches_combat_part2() {
  common_scripts\utility::flag_wait("TRIGFLAG_start_trenches_part2");
  thread maps\_utility::autosave_by_name("trench2");
  level.hesh.grenadeawareness = 0;
  level notify("beach_ambient_battlechatter_stop");
  maps\_spawner::flood_spawner_scripted(getEntArray("tower_top_marine_flooders", "targetname"));
  thread maps\homecoming_util::function_trigger_switch("beach_tower_runners_on", "beach_tower_runners_off", ::beach_tower_runners_on, ::beach_tower_runners_off, "tower_pre_explosion_cleanup", 1);
  maps\_spawner::flood_spawner_scripted(getEntArray("tower_enemy_attackers", "targetname"));
  common_scripts\utility::flag_wait("TRIGFLAG_start_tower_entrance_battle");
  thread maps\homecoming_util::function_trigger_switch("trench_tower_kill_player_on", "trench_tower_kill_player_off", ::beach_tower_killplayer_on, ::beach_tower_killplayer_off, "tower_pre_explosion_cleanup");
  setignoremegroup("tower_ground_enemies_1", "trench_player_squad");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("tower_enemy_tanks");
  thread trench_tower_hind();
  common_scripts\utility::flag_wait("FLAG_allow_tower_a10");
  thread maps\homecoming_a10::a10_strafe_mechanic("tower_player_a10_strafe", ::warthog_player_crash, ::a10_squadron_tower_crash, ::warthog_player_fadeout_crash);
  common_scripts\utility::flag_wait("FLAG_start_tower_explosion");
  thread maps\homecoming_a10::a10_mechanic_off(1);
  common_scripts\utility::flag_wait("a10_strafe_complete");
  thread maps\_utility::autosave_by_name("tower_explosion");
  level notify("stop_tower_hind");
  level notify("tower_stop_killing_player");
  level notify("tower_pre_explosion_cleanup");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 delete();
      continue;
    }

    var_2 thread maps\homecoming_util::delete_on_flag("TRIGFLAG_player_leaving_tower_parking_area");
  }

  maps\_utility::array_notify(getEntArray("beach_tower_runners", "targetname"), "stop_drone_runners");
  var_4 = level.drones["axis"].array;
  thread maps\homecoming_util::kill_over_time(var_4, 0.4, 0.8);
  maps\_spawner::killspawner(666);
  maps\_spawner::killspawner(665);
  var_5 = maps\homecoming_util::get_ai_array("tower_top_marines");
  maps\_utility::array_delete(var_5);
  var_6 = maps\homecoming_util::get_ai_array("tower_enemy_attackers");
  maps\_utility::array_kill(var_6);
  maps\_utility::clearthreatbias("tower_top_marines", "tower_ground_enemies_1");
  maps\_utility::clearthreatbias("trench_player_squad", "tower_ground_enemies_2");
  maps\homecoming_util::a10_vista_strafe_group_delete("vista_pier_a10s");
  maps\homecoming_util::a10_vista_strafe_group_delete("vista_ship_a10s");
  thread trench_tower_explosion_scene();
  common_scripts\utility::flag_set("FLAG_start_tower_retreat");
}

beach_tower_runners_on() {
  var_0 = getEntArray("beach_tower_runners", "targetname");

  foreach(var_2 in var_0) {
    var_2.randomdeath = [4, 16];
    var_3 = 0;

    if(isDefined(var_2.script_wait)) {
      var_3 = var_2.script_wait;
    }

    var_2 maps\_utility::delaythread(var_3, maps\homecoming_drones::beach_path_drones);
  }
}

beach_tower_runners_off() {
  var_0 = getEntArray("beach_tower_runners", "targetname");
  maps\_utility::array_notify(var_0, "stop_drone_runners");
}

beach_tower_killplayer_on() {
  level endon("tower_stop_killing_player");

  for(;;) {
    var_0 = randomintrange(5, 15);
    level.player dodamage(var_0, level.player.origin);
    common_scripts\utility::flag_wait_or_timeout("used_a10_strafe", randomfloatrange(0.4, 1.2));

    if(common_scripts\utility::flag("used_a10_strafe")) {
      level.player dodamage(99999, level.player.origin);
      break;
    }
  }
}

beach_tower_killplayer_off() {
  level notify("tower_stop_killing_player");
}

trenches_combat_right_path() {
  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_nest");
  var_0 = getent("trenches_moveup_trig3", "targetname");

  if(isDefined(var_0)) {
    var_0 notify("trigger");
  }
}

trench_custom_mortars() {
  level endon("stop_trench_custom_mortars");
  var_0 = common_scripts\utility::getstructarray("trench_mortars", "targetname");
  var_1 = gettime();
  var_2 = 400;
  var_3 = 1200;
  var_4 = 10000;
  var_5 = 500;
  var_6 = 0.4;
  var_7 = 0.2;
  var_8 = cos(45);
  var_9 = var_0;

  while(!common_scripts\utility::flag("TRIGFLAG_tower_entrance")) {
    wait(randomfloatrange(2, 4));
    var_10 = [];

    foreach(var_12 in var_9) {
      if(maps\_utility::within_fov_2d(level.player getEye(), level.player getplayerangles(), var_12.origin, var_8)) {
        var_13 = distance2dsquared(var_12.origin, level.player.origin);

        if(var_13 > squared(var_2) && var_13 < squared(var_3)) {
          if(isDefined(var_12.lastused)) {
            if(gettime() - var_12.lastused < var_4) {
              continue;
            }
          }

          var_10 = common_scripts\utility::array_add(var_10, var_12);
        }
      }
    }

    if(var_10.size == 0) {
      continue;
    }
    var_15 = common_scripts\utility::random(var_10);

    if(!isDefined(var_15)) {
      continue;
    }
    playFX(common_scripts\utility::getfx(var_15.script_fxid), var_15.origin, anglesToForward(var_15.angles));
    earthquake(var_6, var_7, var_15.origin, var_5);
    var_9 = common_scripts\utility::array_remove(var_0, var_15);
    var_15.lastused = gettime();

    if(common_scripts\utility::cointoss()) {
      if(gettime() - var_1 < 10000) {
        continue;
      }
      var_1 = gettime();
      var_10 = common_scripts\utility::array_remove(var_10, var_15);

      if(var_10.size == 0) {
        continue;
      }
      var_15 = common_scripts\utility::random(var_10);
      wait(randomfloatrange(0.1, 0.3));
      playFX(common_scripts\utility::getfx(var_15.script_fxid), var_15.origin, anglesToForward(var_15.angles));
      earthquake(var_6, var_7, var_15.origin, var_5);
      var_9 = common_scripts\utility::array_remove(var_0, var_15);
      var_15.lastused = gettime();
    }
  }
}

trench_main_friendlies() {
  level endon("stop_main_friendlies_respawning");
  var_0 = self.spawner;
  maps\homecoming_util::set_ai_array("trench_main_friendlies");
  self waittill("death");
  var_1 = var_0;

  if(common_scripts\utility::flag("FLAG_trench_respawner_2")) {
    var_1 = getent("trench_main_friendlies_respawner_2", "targetname");
  }
  else if(common_scripts\utility::flag("FLAG_trench_respawner_1")) {
    var_1 = getent("trench_main_friendlies_respawner_1", "targetname");
  }

  for(;;) {
    var_2 = var_1 maps\_utility::spawn_ai();

    if(isDefined(var_2)) {
      break;
    }

    wait 0.2;
  }
}

trench_main_friendlies_respawner_logic() {
  maps\homecoming_util::waittill_trigger("trenches_moveup_trig2");
  common_scripts\utility::flag_set("FLAG_trench_respawner_1");
  common_scripts\utility::flag_wait("FLAG_over_trench_hovercraft_gone");
  common_scripts\utility::flag_set("FLAG_trench_respawner_2");
}

trench_friendly_orange_guy() {
  maps\homecoming_util::set_ai_array("trench_main_friendlies");
  thread maps\_utility::magic_bullet_shield();
  maps\homecoming_util::waittill_trigger("trenches_entrance_trig");
  maps\_utility::set_force_color("g");
  maps\homecoming_util::waittill_trigger("trenches_moveup_trig1");
  maps\_utility::set_force_color("o");
  maps\homecoming_util::waittill_trigger("trenches_moveup_trig4");
  maps\_utility::set_force_color("g");
}

trench_hovercraft_side_sand() {
  var_0 = ["tag_fx_water_splash9", "tag_fx_water_splash8", "tag_fx_water_splash7", "tag_fx_water_splash6"];

  foreach(var_2 in var_0) {
    var_3 = -70;

    if(var_2 == "tag_fx_water_splash6") {
      var_3 = -90;
    }

    thread trench_hovercraft_side_sand_fx(var_2, var_3);
  }
}

trench_hovercraft_side_sand_fx(var_0, var_1) {
  self endon("death");
  self endon("stop_fx");
  self endon("stop_side_sand");

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = anglestoright(self gettagangles(var_0));
    var_2 = var_2 + var_3 * var_1;
    var_2 = var_2 + (0, 0, 25);
    playFX(common_scripts\utility::getfx("hovercraft_side_sand"), var_2);
    wait 0.1;
  }
}

trench_first_nh90_lander() {
  self.takeoffdelay = 7;
}

trench_artemis() {
  var_0 = self;
  level.trench_artemis = var_0;
  var_0.artemisnofiresound = 1;
  var_0 thread maps\homecoming_util::artemis_think();
  common_scripts\utility::flag_wait("FLAG_start_trenches");
  var_0 notify("stop_firing_for_good");
  var_1 = common_scripts\utility::getstruct("trench_artemis_default_target", "targetname");
  var_0 setturrettargetvec(var_1.origin);
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  level.trench_artemis.gunner maps\homecoming_util::delete_safe();
  level.trench_artemis maps\homecoming_util::delete_safe();
}

trench_artemis_guy() {
  thread maps\_utility::magic_bullet_shield();
  maps\homecoming_util::set_ai_array("trench_artemis_frendlies");
  maps\homecoming_util::waittill_trigger(getent("trench_artemis_start_trig", "script_noteworthy"));
  maps\homecoming_util::ignore_everything();
  var_0 = level.trench_artemis;
  var_0.artemisnofiresound = undefined;
  level.trench_artemis.gunner = self;
  var_0 maps\_anim::anim_generic_reach(self, "artemis_getin", "tag_gunner");
  self linkto(var_0, "tag_gunner", (0, 0, 0), (0, 0, 0));
  var_0 maps\_anim::anim_generic(self, "artemis_getin", "tag_gunner");
  var_0 thread maps\_anim::anim_generic_loop(self, "artemis_loop", "stop_anim", "tag_gunner");
  var_0 thread maps\homecoming_util::artemis_think();
  self waittill("death");
  var_0 notify("stop_firing_for_good");
}

trench_artemis_friendlies() {
  var_0 = self.spawner;
  maps\homecoming_util::set_ai_array("trench_main_friendlies");
  maps\homecoming_util::set_ai_array("trench_artemis_frendlies");
  self waittill("death");

  if(common_scripts\utility::flag("TRIGFLAG_start_trenches_part2")) {
    return;
  }
  while(!common_scripts\utility::flag("TRIGFLAG_start_trenches_part2")) {
    var_1 = var_0 maps\_utility::spawn_ai();

    if(isDefined(var_1)) {
      break;
    }

    wait 0.2;
  }
}

trench_chargers(var_0, var_1, var_2, var_3) {
  var_0 = common_scripts\utility::array_randomize(var_0);

  while(var_0.size > 0) {
    foreach(var_5 in var_0) {
      if(!isDefined(var_5)) {
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
        continue;
      }

      var_6 = var_5 maps\_utility::spawn_ai();
      var_6 thread trench_chargers_think(var_1);

      if(var_5.count == 0) {
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
      }

      wait(randomfloatrange(var_2, var_3));
    }
  }
}

trench_chargers_think(var_0) {
  self endon("death");
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  self.ignorerandombulletdamage = 1;
  self setgoalpos(var_0.origin);
  self.goalradius = var_0.radius;
  self waittill("goal");
  wait(randomfloatrange(0.2, 0.8));
  maps\_utility::die();
}

tower_rappel_nh90() {
  var_0 = getnode("tower_rappelers_node", "targetname");
  var_1 = self.riders;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_1) {
    if(isDefined(var_5.script_startingposition)) {
      continue;
    }
    if(isDefined(var_5.script_goalvolume)) {
      var_3 = common_scripts\utility::array_add(var_3, var_5);
      continue;
    }

    var_5 maps\homecoming_util::ignore_everything();
    var_2 = common_scripts\utility::array_add(var_2, var_5);
  }

  self waittill("unloaded");
  common_scripts\utility::flag_set("FLAG_start_tower_hind");
  var_2 = maps\_utility::array_removedead_or_dying(var_2);
  common_scripts\utility::array_thread(var_2, maps\_utility::magic_bullet_shield);
  common_scripts\utility::array_thread(var_2, maps\homecoming_util::waittill_real_goal, var_0, 1);
  var_3 = maps\_utility::array_removedead_or_dying(var_3);
  common_scripts\utility::array_thread(var_3, maps\_utility::set_ignoreall, 0);
  common_scripts\utility::array_thread(var_3, maps\_utility::set_ignoreme, 0);

  for(;;) {
    var_2 = maps\_utility::array_removedead_or_dying(var_2);

    if(var_2.size == 0) {
      break;
    }

    wait 1;
  }
}

initial_trench_enemies() {
  maps\_utility::array_spawn(getEntArray("initial_trench_enemies", "targetname"));
  var_0 = getEntArray("initial_trench_flooders", "targetname");
  maps\_spawner::flood_spawner_scripted(var_0);
  maps\homecoming_util::waittill_trigger("trench_start_combat");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_index)) {
      var_2.count = 0;
      continue;
    }

    var_2.count = var_2.script_index;
  }
}

trench_enemy_nest_ai() {
  self endon("death");
  var_0 = self.spawner;
  self.ignoreme = 1;
  self.a.disablelongdeath = 1;
  thread maps\homecoming_util::enemy_rpg_unlimited_ammo("stop_rpg_ammo");
  var_1 = var_0 common_scripts\utility::get_linked_ents();

  while(!common_scripts\utility::flag("TRIGFLAG_player_entering_nest")) {
    if(self.weapon != "panzerfaust3") {
      maps\_utility::forceuseweapon("panzerfaust3", "primary");
    }

    var_2 = var_1[randomint(var_1.size)];
    self setentitytarget(var_2);
    maps\_utility::add_wait(maps\_utility::waittill_msg, "shooting");
    maps\_utility::add_wait(common_scripts\utility::flag_wait, "TRIGFLAG_player_entering_nest");
    maps\_utility::do_wait_any();

    if(common_scripts\utility::flag("TRIGFLAG_player_entering_nest")) {
      break;
    }
  }

  self notify("stop_rpg_ammo");
  self.a.rockets = 0;
  self.ignoreme = 0;
  self clearentitytarget();
}

trench_hovercraft_a10() {
  common_scripts\utility::flag_set("FLAG_trenches_hovercraft_spawned");
  self.deflaterate = 1.5;
  self.delaytankunload = 1;

  while(!isDefined(self.tanks)) {
    wait 0.1;
  }

  var_0 = self.tanks[0];
  var_0.turretturntime = 2;
  var_0.firetime = [3.5, 6];
  maps\_utility::array_spawn(getEntArray("trench_hovecraft_ai", "targetname"), undefined, 1);
  common_scripts\utility::flag_wait("FLAG_start_trench_hovercraft_tank");
  self.delaytankunload = undefined;
  self.stopdroneunload = 1;
  maps\_utility::ent_flag_set("hovercraft_allow_tank_unload");
  var_0 maps\_utility::ent_flag_wait("hovercraft_unload_complete");
  common_scripts\utility::flag_set("FLAG_trench_tank_unload_complete");

  if(!common_scripts\utility::flag("TRIGFLAG_a10_destroy_trench_tank")) {
    var_1 = [1, 2];
    thread maps\homecoming_util::spawn_and_reinforce("trench_hovecraft_ai", var_1, "stop_trench_hovercraft_reinforcers", 1);
    level.strafetargetvehicles = common_scripts\utility::array_add(level.strafetargetvehicles, var_0);
  }

  var_0 maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  level maps\_utility::add_wait(common_scripts\utility::flag_waitopen, "player_not_doing_strafe");
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, "TRIGFLAG_a10_destroy_trench_tank");
  maps\_utility::do_wait_any();
  var_2 = 0;

  if(!common_scripts\utility::flag("player_not_doing_strafe")) {
    common_scripts\utility::flag_wait("player_not_doing_strafe");

    if(isDefined(var_0) && isalive(var_0)) {
      var_0 maps\_vehicle::godoff();
      var_0 notify("death");
      var_2 = 1;
    }

    level.player_destroyed_trench_tank = 1;
    common_scripts\utility::flag_set("FLAG_trench_tank_destroyed");
  }

  if(isDefined(var_0) && isalive(var_0) && !var_2) {
    common_scripts\utility::flag_set("FLAG_trench_tank_destroyed");
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("trench_hovercraft_a10");
    var_3 waittill("strafe_done");
    var_0 maps\_vehicle::godoff();
    var_0 notify("death");
  }

  maps\_utility::ent_flag_set("hovercraft_unload_complete");
}

#using_animtree("vehicles");

trench_hovercraft_over_moment() {
  self setanimrestart( % hovercraft_enemy_lower_fans, 1, 1, 1);
  self setanim( % hovercraft_enemy_upper_fans, 1, 0.2, 1);
  var_0 = self.script_index;
  self waittill("startfx");
  setsaveddvar("ai_friendlysuppression", 0);
  setsaveddvar("ai_friendlyfireblockduration", 0);
  self notify("stop_side_sand");
  var_1 = maps\homecoming_util::get_ai_array("trench_main_friendlies");
  common_scripts\utility::array_thread(var_1, ::trench_hovercraft_over_moment_stumblers);
  common_scripts\utility::exploder("hovercraft_wash_" + var_0);
  var_2 = [(-4346.43, 7126.79, -95), (-4539.72, 6679.33, -108.995)];
  var_3 = [];

  foreach(var_7, var_5 in var_2) {
    var_6 = spawn("script_origin", var_5);
    var_6 playLoopSound("trench_hovercraft_wind");
    var_6 scalevolume(0, 0);
    var_6 common_scripts\utility::delaycall(0.05, ::scalevolume, 1, 1);
    var_3[var_7] = var_6;
  }

  var_8 = ["bottompropellerback1_jnt", "bottompropellermid1_jnt", "bottompropellerfront1_jnt"];
  var_9 = ["trench_hovercraft_fans_back", "trench_hovercraft_fans_middle", "trench_hovercraft_fans_front"];

  foreach(var_12, var_11 in var_8) {
  thread maps\_utility::play_loop_sound_on_tag(var_9[var_12], var_11);
  }

  common_scripts\utility::flag_wait_any("TRIGFLAG_start_tower_destruction_sequence", "FLAG_over_trench_hovercraft_gone");

  if(common_scripts\utility::flag("TRIGFLAG_start_tower_destruction_sequence")) {
    self vehicle_setspeed(25, 5, 5);
    common_scripts\utility::flag_wait("FLAG_over_trench_hovercraft_gone");
  }

  maps\_utility::stop_exploder("hovercraft_wash_" + var_0);
  common_scripts\utility::array_thread(var_3, maps\_utility::sound_fade_and_delete, 2);
  setsaveddvar("ai_friendlysuppression", 1);
  setsaveddvar("ai_friendlyfireblockduration", 1);
}

trench_hovercraft_over_moment_stumblers() {
  self endon("death");
  var_0 = getent("trench_hovercraft_stumblers_trig", "targetname");

  if(!isDefined(self.magic_bullet_shield)) {
    maps\_utility::magic_bullet_shield();
  }

  while(!common_scripts\utility::flag("FLAG_over_trench_hovercraft_gone")) {
    if(self istouching(var_0)) {
      maps\_utility::set_generic_run_anim("hovercraft_stumble_walk_" + randomintrange(1, 3));
      maps\homecoming_util::ignore_everything();
      self pushplayer(1);
      maps\_utility::disable_turnanims();
      maps\_utility::pathrandompercent_zero();
      maps\_utility::walkdist_zero();

      while(self istouching(var_0)) {
        if(common_scripts\utility::flag("FLAG_over_trench_hovercraft_gone")) {
          break;
        }

        wait 0.05;
      }

      maps\_utility::clear_generic_run_anim();
      maps\_utility::enable_turnanims();
      self pushplayer(0);
      maps\_utility::pathrandompercent_reset();
      maps\_utility::walkdist_reset();

      if(self == level.hesh) {
        self.ignoreall = 0;
      }
      else {
        maps\homecoming_util::clear_ignore_everything();
      }
    }

    wait 0.05;
  }

  if(self != level.hesh) {
    maps\_utility::stop_magic_bullet_shield();
  }

  maps\_utility::clear_generic_run_anim();
  self pushplayer(0);
  maps\_utility::enable_turnanims();

  if(self == level.hesh) {
    self.ignoreall = 0;
  }
  else {
    maps\homecoming_util::clear_ignore_everything();
  }

  if(isDefined(self.old_walkdistfacingmotion)) {
    maps\_utility::walkdist_reset();
  }

  if(isDefined(self.old_pathrandompercent)) {
    maps\_utility::pathrandompercent_reset();
  }
}

trench_tower_explosion_scene() {
  thread warthog_player_tower_crash();
  wait 0.8;
  trench_tower_explode();
}

#using_animtree("script_model");

trench_tower_explode() {
  trench_tower_explode_missiles();
  var_0 = getEntArray("tower_blowup_migs", "targetname");
  var_1 = 1.35;

  foreach(var_3 in var_0) {
    var_4 = var_3 maps\_vehicle::spawn_vehicle_and_gopath();
    playFXOnTag(level._effect["afterburner"], var_4, "tag_engine_right");
    playFXOnTag(level._effect["afterburner"], var_4, "tag_engine_left");
    var_1 = 1.55;

    if(isDefined(var_3.script_delay)) {
      var_1 = var_1 + var_3.script_delay;
    }
    else {
      var_1 = 1.35;
    }

    common_scripts\utility::noself_delaycall(var_1, ::playfxontag, level._effect["mig_ignite"], var_4, "tag_engine_right");
    common_scripts\utility::noself_delaycall(var_1, ::playfxontag, level._effect["mig_ignite"], var_4, "tag_engine_left");
  }

  common_scripts\utility::exploder("tower_exp");
  var_6 = (-4488, 9376, 524);
  earthquake(0.75, 2, var_6, 5000);
  thread common_scripts\utility::play_sound_in_space("trench_tower_explosion", var_6);
  wait 0.1;
  var_7 = undefined;
  var_8 = getEntArray("trench_tower_pieces", "targetname");

  foreach(var_10 in var_8) {
    var_10 maps\_utility::show_entity();

    if(isDefined(var_10.script_parameters)) {
      var_11 = strtok(var_10.script_parameters, " ");

      foreach(var_13 in var_11) {
        var_13 = "j_airport_tower_" + var_13;
        var_10 hidepart(var_13, var_10.model);
      }
    }

    if(!isDefined(var_10.animation)) {
      continue;
    }
    var_10 useanimtree(#animtree);
    var_10.animname = "tower";
    var_15 = var_10.animation;
    var_10 thread maps\_anim::anim_single_solo(var_10, var_15);
    var_16 = getanimlength(var_10 maps\_utility::getanim(var_15));
    var_10 common_scripts\utility::delaycall(var_16, ::hide);
  }

  var_18 = getEntArray("guard_tower_intact", "targetname");
  var_19 = getEntArray("guard_tower_destroyed", "targetname");
  common_scripts\utility::array_thread(var_19, maps\_utility::show_entity);
  common_scripts\utility::array_thread(var_18, maps\_utility::hide_entity);
  var_20 = getEntArray("tower_explosion_models", "targetname");
  common_scripts\utility::array_thread(var_20, maps\_utility::hide_entity);
  common_scripts\utility::flag_set("FLAG_tower_explosion_done");
}

trench_tower_explode_missiles() {
  var_0 = common_scripts\utility::getstructarray("tower_explosion_missile_start", "targetname");
  var_0 = sort_by_index(var_0);
  var_1 = 1.2;
  var_2 = 1;

  foreach(var_10, var_4 in var_0) {
    var_5 = common_scripts\utility::getstruct(var_4.target, "targetname");
    var_6 = vectornormalize(var_5.origin - var_4.origin);
    var_7 = vectortoangles(var_6);
    var_8 = spawn("script_model", var_4.origin);
    var_8 setModel("projectile_slamraam_missile");
    var_8.angles = var_7;
    playFXOnTag(common_scripts\utility::getfx("tower_missile_trails"), var_8, "tag_fx");
    var_9 = var_10 + 1;
    var_8 thread maps\_utility::play_sound_on_entity("missile_incoming_0" + var_9);
    var_8 moveto(var_5.origin, var_1);
    var_8 common_scripts\utility::delaycall(var_1, ::delete);

    if(var_2) {
      wait 0.4;
    }

    var_2 = 0;
  }

  wait(var_1 - 0.4);
}

warthog_player_tower_crash() {
  var_0 = common_scripts\utility::getstruct("a10_crash_start", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("vehicle_a10_warthog_iw6");
  var_3 = vectornormalize(var_1.origin - var_0.origin);
  var_4 = vectortoangles(var_3);
  var_2.angles = var_4;
  var_5 = anglesToForward(var_4);
  var_2.origin = var_2.origin + var_5 * 1500;
  var_2 thread warthog_crash_roll();
  common_scripts\utility::noself_delaycall(1.2, ::playfxontag, common_scripts\utility::getfx("hind_damage_trail"), var_2, "tag_engine_left");
  var_2 thread maps\homecoming_util::playloopingfx("airplane_smoke_trail", 0.05, undefined, "tag_engine_left");
  var_2 thread maps\homecoming_util::playloopingfx("airplane_smoke_trail", 0.05, undefined, "tag_engine_right");
  var_2 thread maps\homecoming_util::playloopingfx("airplane_smoke_trail", 0.05, undefined, "tag_left_wingtip");
  var_2 thread maps\_utility::play_sound_on_entity("scn_home_a10_incoming_crash");
  var_2 moveto(var_1.origin, 1.8, 1, 0);
  var_2 waittill("movedone");
  var_2 delete();
}

warthog_crash_roll() {
  self endon("death");

  for(;;) {
    self rotateroll(360, 1.5);
    wait 1.5;
  }
}

sort_by_index(var_0) {
  var_1 = var_0;

  foreach(var_5, var_3 in var_0) {
    var_4 = var_3.script_index;
    var_1 = common_scripts\utility::array_remove(var_0, var_3);
    var_1 = common_scripts\utility::array_insert(var_1, var_3, var_4);
  }

  return var_1;
}

warthog_player_crash(var_0) {
  if(level.a10_uses != 1) {
    common_scripts\utility::flag_set("FLAG_allow_a10_strafe_crash");
    return;
  }

  var_0 endon("death");
  wait 2;
  common_scripts\utility::flag_set("FLAG_player_a10_lockon");
  level.player notify("enable_a10_lockon_warning");
}

warthog_player_fadeout_crash(var_0) {
  if(level.a10_uses != 1) {
    common_scripts\utility::flag_wait("a10_strafe_complete");
    level.skipa10endfade = 1;
    level.a10_mechanic_ambient_dialogue_off = 1;
    level.lasta10cinematic = 1;
    return;
  }

  level.player thread maps\_utility::play_sound_on_entity("a10_tablet_static");
  var_1 = maps\_hud_util::create_client_overlay("overlay_static", 1, level.player);
  var_2 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  var_2.sort = -1;
  common_scripts\utility::flag_wait("a10_strafe_complete");
  var_1 thread maps\_hud_util::fade_over_time(0, 1);
  var_2 thread maps\_hud_util::fade_over_time(0, 1);
  var_1 common_scripts\utility::delaycall(1, ::destroy);
  var_2 common_scripts\utility::delaycall(1, ::destroy);
}

a10_squadron_tower_crash(var_0) {
  if(level.a10_uses != 1) {
    return;
  }
  if(!var_0 maps\homecoming_util::parameters_check("crasher")) {
    return;
  }
  level.a10_mechanic_skip_end = 1;
  common_scripts\utility::flag_set("FLAG_start_tower_explosion");
  var_1 = getvehiclenode("tower_a10_squadron_carsh_path", "targetname");
  var_0 attachpath(var_1);
  var_2 = 4;
  thread a10_squadron_tower_crash_missile(var_0, var_2);
  thread a10_squadron_tower_crash_flares_warthog(var_0, var_2);
  common_scripts\utility::noself_delaycall(var_2, ::playfxontag, common_scripts\utility::getfx("osprey_engine_explosion"), var_0, "tag_origin");
  var_0 maps\_utility::delaythread(var_2, maps\homecoming_util::playloopingfx, "a10_damaged_smoke", 0.05, undefined, "TAG_LEFT_WINGTIP");
  var_0 maps\_utility::delaythread(var_2, maps\homecoming_util::playloopingfx, "a10_damaged_smoke", 0.05, undefined, "TAG_RIGHT_WINGTIP");
  var_0 common_scripts\utility::delaycall(2, ::hudoutlinedisable);
  var_0 waittill("reached_end_node");
  playFX(common_scripts\utility::getfx("aerial_explosion_mig29"), var_0.origin + (0, 0, 250));
  wait 0.1;
  var_0 hide();
}

a10_squadron_tower_crash_flares_warthog(var_0, var_1) {
  var_2 = 1.9;
  wait(var_2);
  var_1 = var_1 - var_2;
  var_3 = var_1 * 1000;
  var_4 = gettime();

  while(gettime() - var_4 < var_3) {
    var_0 thread maps\homecoming_util::shootflares("tag_gun");
    wait 0.3;
  }
}

a10_squadron_tower_crash_missile(var_0, var_1) {
  wait(var_1 - 0.5);
  var_2 = var_0.origin + (0, -500, -1000);
  var_3 = magicbullet("sparrow_missile", var_2, var_0.origin);
  var_3 missile_settargetent(var_0);
  var_3 hudoutlineenable(4, 0);
}

trench_tower_hind() {
  level endon("stop_tower_hind");
  var_0 = getEntArray("trench_tower_hind", "targetname");

  for(;;) {
    if(common_scripts\utility::flag("FLAG_start_tower_explosion")) {
      return;
    }
    var_1 = common_scripts\utility::random(var_0);
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    level.towerhind = var_2;
    var_2 thread maps\homecoming_util::vehicle_path_notifications();
    var_2 waittill("reached_dynamic_path_end");
    var_2.script_burst_min = 9;
    var_2.script_burst_max = 21;
    var_2.firewait = 0.15;
    var_2.currenttrig = "back";
    var_2.playerintrench = 1;
    var_2 thread tower_hind_targetplayer();
    var_2 thread trench_tower_hind_pathlogic();
    var_2 thread trench_tower_hind_leave();
    var_2 maps\homecoming_util::heli_enable_rocketdeath(1);
    var_2 waittill("death");
    common_scripts\utility::flag_wait("player_not_doing_strafe");
  }
}

trench_tower_hind_targetent() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self, "tag_origin", (0, 0, -125), (0, 0, 0));
  target_set(var_0, (0, 0, 0));
  target_hidefromplayer(var_0, level.player);
  self waittill("death");
  var_0 delete();
}

trench_tower_hind_pathlogic() {
  self endon("death");
  self endon("tower_hind_stop_logic");
  var_0 = common_scripts\utility::getstructarray("tower_hind_dynamic_paths", "targetname");
  var_1 = getEntArray("tower_hind_trigs", "targetname");
  var_2 = [];
  var_3 = [];

  foreach(var_8, var_5 in var_0) {
    var_6 = var_5 maps\_utility::get_linked_structs();
    var_7 = [];
    var_7[0] = var_5;
    var_7 = common_scripts\utility::array_combine(var_7, var_6);
    var_2[var_5.script_noteworthy] = var_7;
    var_3[var_1[var_8].script_noteworthy] = var_1[var_8];
  }

  var_9 = "back";
  var_10 = undefined;

  for(;;) {
    var_11 = undefined;

    foreach(var_13 in var_3) {
      if(level.player istouching(var_13)) {
        var_11 = var_13;
        break;
      }
    }

    if(!isDefined(var_11)) {
      var_10 = 1;
      var_11 = var_3[var_9];
      self.playerintrench = 1;
    } else if(isDefined(var_10))
      var_10 = undefined;

    var_15 = var_11.script_noteworthy;
    self.currenttrig = var_15;
    thread trench_tower_hind_gopath(var_2[var_15], var_15);

    if(isDefined(var_10)) {
      while(!level.player istouching(var_11)) {
        wait 0.1;
      }
    }

    self.playerintrench = 0;

    for(;;) {
      while(level.player istouching(var_11)) {
        wait 0.1;
      }

      wait 1.5;

      if(!level.player istouching(var_11)) {
        break;
      }
    }
  }
}

trench_tower_hind_gopath(var_0, var_1) {
  self endon("death");
  self notify("new_tower_path");
  self endon("new_tower_path");
  self endon("tower_hind_stop_logic");
  var_2 = common_scripts\utility::getclosest(self.origin, var_0);
  self vehicle_setspeed(25, 25, 5);
  self setneargoalnotifydist(64);

  for(;;) {
    var_3 = common_scripts\utility::array_remove(var_0, var_2);
    var_2 = var_3[randomint(var_3.size)];
    self vehicle_helisetai(var_2.origin, undefined, undefined, undefined, var_2.script_goalyaw, undefined, var_2.angles[1], 0, 0, 0, 0, 0, 1);
    self waittill("near_goal");
    self vehicle_setspeed(15, 5, 5);
    wait(randomfloat(2));
  }
}

trench_tower_hind_leave() {
  self endon("death");
  common_scripts\utility::flag_wait("FLAG_player_a10_lockon");
  self notify("tower_hind_stop_logic");
  self notify("stop_firing");
  self clearlookatent();
  self vehicle_setspeed(60, 40, 10);
  var_0 = common_scripts\utility::getstruct("tower_hind_leave_start", "targetname");
  thread maps\_vehicle_code::vehicle_paths_helicopter(var_0);
  self waittill("reached_dynamic_path_end");
  self delete();
}

tower_hind_targetplayer() {
  self endon("death");
  self endon("tower_hind_stop_logic");
  var_0 = spawn("script_origin", level.player.origin);
  thread maps\homecoming_util::heli_fire_turret(var_0, 1);
  var_1 = common_scripts\utility::getstruct("tower_hind_back_target", "targetname");
  var_2 = var_1;

  for(;;) {
    var_3 = 25;
    var_4 = 0.05;

    if(self.playerintrench == 1) {
      var_5 = var_1.origin;
      var_3 = 128;
      var_4 = 0.2;
    } else if(!common_scripts\utility::flag("player_not_doing_strafe"))
      var_5 = var_2;
    else {
      var_5 = level.player.origin + (0, 0, 30);
      level.player dodamage(20, level.player.origin);
    }

    var_2 = var_5;
    var_6 = maps\homecoming_util::return_point_in_circle(var_5, var_3);
    var_0.origin = var_6;
    wait(var_4);
  }
}

trench_beach_axis_ambient() {
  thread maps\homecoming_util::set_mortar_on(5);
  var_0 = getEntArray("trench_beach_ambient_drones", "targetname");
  common_scripts\utility::array_thread(var_0, maps\homecoming_beach::bunker_enemy_cover_drones, "beach_ambient_stop", "beach_ambient_enemy_drones");
  common_scripts\utility::flag_clear("FLAG_stop_trench_beach_runners");
  var_1 = getEntArray("trench_beach_ambient_runners", "targetname");
  maps\_utility::array_spawn_function(var_1, maps\homecoming_util::hovercraft_drone_default);
  var_2 = ["run", "run_n_gun"];
  var_3 = [2, 5];
  var_1 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_trench_beach_runners", var_3, var_2, undefined, undefined, 10);
  var_1 = getEntArray("trench_beach_ambient_runners2", "targetname");
  maps\_utility::array_spawn_function(var_1, maps\homecoming_util::hovercraft_drone_default);
  var_4 = [5, 8];
  var_1 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_trench_beach_runners", var_3, var_2, undefined, var_4, 10);
  var_5 = common_scripts\utility::getstructarray("trench_beach_ambient_fire", "targetname");

  foreach(var_7 in var_5) {
  thread maps\homecoming_util::ambient_smallarms_fire(var_7, "beach_ambient_stop");
  }

  if(isDefined(level.trench_beach_hovercrafts)) {
    common_scripts\utility::array_thread(level.trench_beach_hovercrafts, maps\homecoming_util::hovercraft_deploy_smoke);
  }
}

trench_beach_axis_ambient_off() {
  level notify("beach_ambient_stop");
  common_scripts\utility::flag_set("FLAG_stop_trench_beach_runners");
  var_0 = maps\homecoming_util::get_ai_array("beach_ambient_enemy_drones");
  common_scripts\utility::array_thread(var_0, maps\homecoming_util::delete_safe);
  maps\_utility::array_notify(level.trench_beach_hovercrafts, "stop_deploying_smoke");
}

trench_beach_ambient_hovercrafts_on() {
  common_scripts\utility::array_call(level.trench_beach_hovercrafts, ::show);
}

trench_beach_ambient_hovercrafts_off() {
  level endon("stop_beach_ambient_switch");

  for(;;) {
    foreach(var_1 in level.trench_beach_hovercrafts) {
      if(var_1 maps\homecoming_util::parameters_check("donthide")) {
        continue;
      }
      var_1 hide();
    }

    common_scripts\utility::flag_wait("player_inside_a10");
    common_scripts\utility::array_call(level.trench_beach_hovercrafts, ::show);
    common_scripts\utility::flag_waitopen("player_inside_a10");
  }
}

trench_beach_allies_ambient() {
  var_0 = getEntArray("trench_beach_ally_drones", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 maps\_utility::spawn_ai();
    var_4 maps\_utility::magic_bullet_shield();

    if(var_3 maps\homecoming_util::noteworthy_check("animate_on_path")) {
      var_4.weaponsound = "drone_r5rgp_fire_npc";
      var_4 thread maps\homecoming_drones::drone_animate_on_path();
    }

    var_4 maps\homecoming_util::set_ai_array("beach_ambient_ally_drones");
    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  thread maps\homecoming_util::set_mortar_on(17);
}

trench_beach_allies_ambient_off() {
  var_0 = maps\homecoming_util::get_ai_array("beach_ambient_ally_drones");
  common_scripts\utility::array_thread(var_0, maps\homecoming_util::delete_safe);
  level notify("stop_mortars 17");
}

bottom_tower_enemies() {
  var_0 = getEntArray("tower_bottom_enemies", "targetname");
  var_1 = maps\_utility::array_spawn(var_0);

  for(var_2 = gettime(); !common_scripts\utility::flag("TRIGFLAG_player_entering_tower") && var_1.size > 2; var_1 = maps\_utility::array_removedead_or_dying(var_1)) {
    wait 0.1;
  }

  while(gettime() - var_2 < 5000) {
    wait 0.1;
  }

  common_scripts\utility::flag_set("FLAG_hesh_move_through_tower");
  var_3 = getnodearray("tower_top_runner_nodes", "targetname");

  foreach(var_6, var_5 in var_1) {
    wait(randomfloatrange(0, 0.8));

    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    var_5.ignoreall = 1;
    var_5.goalradius = 56;
    var_5 setgoalnode(var_3[var_6]);
  }

  var_7 = getent("tower_bottom_enemies_volume", "targetname");

  while(var_1.size > 0) {
    wait 0.1;
    var_1 = maps\_utility::array_removedead_or_dying(var_1);

    foreach(var_5 in var_1) {
      if(!var_5 istouching(var_7)) {
        continue;
      }
      if(level.player maps\_utility::player_can_see_ai(var_5)) {
        continue;
      }
      var_5 delete();
    }
  }
}

top_tower_enemies() {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  var_0 = self.health;
  self.health = 2;
  maps\_utility::disable_long_death();
  thread maps\homecoming_util::waittill_stealth_notify();
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "TRIGFLAG_alert_tower_enemies");
  level maps\_utility::add_wait(maps\_utility::waittill_msg, "stealth_event_notify");
  maps\_utility::do_wait_any();
  wait(randomfloatrange(0.4, 0.8));
  self stopanimscripted();
  self.animspot notify("stop_loop");
  self notify("stop_loop");
  self notify("stop_fake_behavior");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.health = var_0;
}