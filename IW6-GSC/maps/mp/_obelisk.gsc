/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_obelisk.gsc
*****************************************************/

obelisk_init() {
  level.scanned_obelisks = [];
  level.drill_tutorial_text = &"MP_ALIEN_DESCENT_DRILL_TUTORIAL_HINT";
}

obelisk() {
  var_0 = select_obelisks();
  level thread maps\mp\alien\_spawnlogic::encounter_cycle_spawn("drill_planted");

  foreach(var_2 in var_0)
  var_2 thread obelisk_listener(var_2);

  level waittill("obelisk_destroyed");
  maps\mp\alien\_spawn_director::end_cycle();
  level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
}

obelisk_listener(var_0) {
  level endon("game_ended");
  var_0 notify("stop_listening");
  var_0 endon("stop_listening");

  if(isDefined(level.drill) && !isDefined(level.drill_carrier))
    level waittill("drill_pickedup");

  var_1 = maps\mp\alien\_hive::get_hive_waypoint_dist(var_0, 1300);
  var_0 thread maps\mp\alien\_hive::set_hive_icon("waypoint_alien_scan", var_1);
  var_2 = var_0 maps\mp\alien\_drill::wait_for_drill_plant();
  level.current_hive_name = var_0.target;
  level.encounter_name = var_0.target;
  level.drill_carrier = undefined;

  if(level.cycle_count == 1)
    level maps\mp\_utility::delaythread(1, maps\mp\alien\_music_and_dialog::playvoforwavestart);

  var_0 thread scanning(var_0, var_0.origin, var_2);
  var_0 maps\mp\alien\_hive::disable_other_strongholds();
  maps\mp\_utility::delaythread(2, maps\mp\alien\_challenge::spawn_challenge);
  maps\mp\alien\_gamescore::reset_encounter_performance();
  common_scripts\utility::flag_wait("drill_detonated");
  var_0 thread scan_complete_sequence(var_0);
  add_to_scanned_obelisk_list(var_0);
  maps\mp\alien\_challenge::end_current_challenge();
  maps\mp\alien\_gamescore::calculate_and_show_encounter_scores(level.players, maps\mp\alien\_hive::get_regular_hive_score_component_name_list());
  level.stronghold_hive_locs = common_scripts\utility::array_remove(level.stronghold_hive_locs, var_0);
  level.current_hive_name = level.current_hive_name + "_post";
  level.num_hive_destroyed++;

  if(isDefined(var_0.scene_trig))
    var_0.scene_trig notify("trigger", level.players[0]);

  give_players_rewards();
  level notify("obelisk_destroyed");
  var_0 notify("stop_listening");
}

give_players_rewards() {
  foreach(var_1 in level.players) {
    var_1 maps\mp\alien\_persistence::eog_player_update_stat("hivesdestroyed", 1);
    var_1 thread maps\mp\alien\_hive::wait_to_give_rewards();
  }
}

select_obelisks() {
  var_0 = [];
  var_1 = maps\mp\alien\_utility::get_current_area_name();

  foreach(var_3 in level.stronghold_hive_locs) {
    if(!(var_3.area_name == var_1)) {
      continue;
    }
    if(!var_3 maps\mp\alien\_hive::dependent_hives_removed()) {
      continue;
    }
    var_0 = common_scripts\utility::array_add(var_0, var_3);
  }

  return var_0;
}

scanning(var_0, var_1, var_2) {
  var_0 endon("stop_listening");
  var_0 endon("drill_complete");
  var_0 thread set_scanner_state_plant(var_0, var_1, var_2);
  level.drill endon("death");
  level.drill.owner = var_2;
  level.drill.stronghold = var_0;
  common_scripts\utility::flag_set("drill_drilling");
  level.drill waittill("drill_finished_plant_anim");
  var_0 maps\mp\alien\_drill::init_drilling_parameters();
  var_0 thread set_scanner_state_scan(var_0, var_2);
  level.drill waittill("offline", var_3, var_4);
  var_0 thread maps\mp\alien\_drill::set_drill_state_offline();
  wait 2;
  maps\mp\gametypes\aliens::alienendgame("axis", maps\mp\alien\_hud::get_end_game_string_index("drill_destroyed"));
}

set_scanner_state_plant(var_0, var_1, var_2) {
  if(isDefined(level.drill)) {
    level.drill delete();
    level.drill = undefined;
  }

  level.drill = spawn("script_model", var_1);
  level.drill setModel("mp_laser_drill");
  level.drill playSound("alien_drill_scanner_plant");
  level.drill.state = "planted";
  level.drill.angles = var_0.angles;
  level.drill.maxhealth = 20000 + level.drill_health_hardcore;
  level.drill.health = int(20000 + level.drill_health_hardcore * var_2 maps\mp\alien\_perk_utility::perk_getdrillhealthscalar());
  level.drill thread maps\mp\alien\_drill::watch_to_repair(var_0);
  level.drill thread maps\mp\alien\_drill::watch_drill_health_for_challenge();
  maps\mp\alien\_outline_proto::add_to_outline_drill_watch_list(level.drill, 0);
  level thread maps\mp\alien\_music_and_dialog::playvoforbombplant(var_2);
  maps\mp\alien\_drill::destroy_drill_icon();
  level.drill scriptmodelplayanim("alien_drill_scan_enter");
  wait 4;
  level.drill notify("drill_finished_plant_anim");
}

set_scanner_state_scan(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stop_listening");
  level.drill.state = "online";
  level.drill makeentitysentient("allies");
  level.drill setthreatbiasgroup("drill");
  level.drill setCanDamage(1);
  level.drill makeunusable();
  level.drill sethintstring("");
  level.drill.threatbias = -3000;
  level.drill scriptmodelplayanim("alien_drill_scan_loop");
  level.drill thread sfx_scanner_on(level.drill);
  maps\mp\alien\_drill::update_drill_health_hud();
  level thread obelisk_scan_fx(var_0);

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.wave_spawned) && var_3.wave_spawned)
      var_3 getenemyinfo(level.drill);
  }

  var_0.depth_marker = gettime();
  var_0 thread maps\mp\alien\_drill::handle_bomb_damage();
  var_0 thread maps\mp\alien\_drill::monitor_drill_complete(var_0.depth);
  var_0 thread maps\mp\alien\_hive::set_hive_icon("waypoint_alien_defend");
  maps\mp\alien\_drill::destroy_drill_icon();
  maps\mp\alien\_hud::turn_on_drill_meter_hud(var_0.depth);
  level thread maps\mp\alien\_drill::watch_drill_depth_for_vo(var_0.depth);
}

obelisk_scan_fx(var_0) {
  var_0 endon("death");
  var_0 endon("stop_listening");

  for(;;) {
    playFXOnTag(level._effect["obelisk_scan_loop"], level.drill, "tag_laser");
    wait 5;
  }
}

sfx_scanner_on(var_0) {
  level.drill_sfx_lp = spawn_sfx_and_play(var_0.origin, var_0, 0, "alien_drill_scanner_lp");
}

scan_complete_sequence(var_0) {
  var_0 thread play_obelisk_scan_complete_animations(var_0.scriptables[0]);
  var_0 notify("hive_dying");
  var_0 maps\mp\alien\_hive::destroy_hive_icon();
  maps\mp\alien\_outline_proto::remove_from_outline_drill_watch_list(level.drill);
  level.drill scriptmodelplayanim("alien_drill_scan_exit");
  level.drill sfx_scanner_off(level.drill);
  stopFXOnTag(level._effect["obelisk_scan_loop"], level.drill, "tag_laser");
  wait 3.8;

  if(!isDefined(var_0.last_hive) || !var_0.last_hive) {
    var_1 = level.drill.origin + (0, 0, 8);
    maps\mp\alien\_drill::drop_drill(var_1, var_0.angles - (0, 90, 0));
  }

  if(isDefined(var_0.last_hive) && var_0.last_hive)
    common_scripts\utility::flag_set("hives_cleared");

  common_scripts\utility::flag_clear("drill_detonated");

  if(!maps\mp\alien\_utility::is_true(level.no_grab_drill_vo))
    level maps\mp\_utility::delaythread(8, maps\mp\alien\_music_and_dialog::play_vo_for_grab_drill);
}

play_obelisk_scan_complete_animations(var_0) {
  var_1 = 5.0;
  var_0 setscriptablepartstate(0, 1);
  wait(var_1);
  var_0 setscriptablepartstate(0, 2);
}

sfx_scanner_off(var_0) {
  var_0 playSound("alien_drill_scanner_off");
  safe_delete(level.drill_sfx_lp);
  safe_delete(level.drill_overheat_lp_02);
}

wait_for_all_scanned_obelisk_destroyed(var_0, var_1, var_2) {
  foreach(var_4 in level.scanned_obelisks)
  var_4 thread obelisk_damage_listener(var_4, var_0, var_1, "waypoint_alien_destroy");

  for(;;) {
    level waittill("scanned_obelisk_destroyed", var_6);
    level.scanned_obelisks = common_scripts\utility::array_remove(level.scanned_obelisks, var_6);

    if(level.scanned_obelisks.size == 0)
      return;
  }
}

add_to_scanned_obelisk_list(var_0) {
  level.scanned_obelisks[level.scanned_obelisks.size] = var_0;
}

obelisk_damage_listener(var_0, var_1, var_2, var_3) {
  var_4 = get_obelisk_clip(var_0);
  var_4 setCanDamage(1);
  var_4 setCanRadiusDamage(1);
  var_0.health = var_1;
  var_5 = maps\mp\alien\_hud::make_waypoint(var_3, 20, 20, 1, var_4.origin);
  var_6 = spawn("script_model", var_0.scriptables[0].origin);
  var_6.angles = var_0.scriptables[0].angles;
  var_6 setModel("dct_alien_obelisk");
  maps\mp\alien\_outline_proto::enable_outline_for_players(var_6, level.players, 2, 0, "high");

  for(;;) {
    var_4 waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(!isDefined(var_8.team) || var_8.team != "allies") {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_16) && !common_scripts\utility::array_contains(var_2, var_16))
      var_7 = int(var_7 * 0.1);

    if(isDefined(var_8)) {
      var_17 = "standard";

      if(isDefined(var_16) && var_16 == "alienvanguard_projectile_mp")
        var_17 = "hitaliensoft";

      if(!isplayer(var_8) && isDefined(var_8.inuseby))
        var_8 = var_8.inuseby;

      var_8 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_17);
    }

    var_0.health = var_0.health - var_7;

    if(var_0.health < 0) {
      break;
    } else {
      if(var_0.health < var_1 * 0.33) {
        var_0.scriptables[0] setscriptablepartstate(0, "damaged_2");
        maps\mp\alien\_outline_proto::enable_outline_for_players(var_6, level.players, 1, 0, "high");
        continue;
      }

      if(var_0.health < var_1 * 0.66) {
        var_0.scriptables[0] setscriptablepartstate(0, "damaged_1");
        maps\mp\alien\_outline_proto::enable_outline_for_players(var_6, level.players, 5, 0, "high");
      }
    }
  }

  var_0 thread sfx_obelisk_destroyed();
  maps\mp\alien\_outline_proto::disable_outline_for_players(var_6, level.players);
  var_6 delete();
  var_0.scriptables[0] setscriptablepartstate(0, "remove");
  var_4 delete();
  var_5 destroy();
  level notify("scanned_obelisk_destroyed", var_0);
}

spawn_sfx_and_play(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", var_0);
  var_4 linkto(var_1);
  var_4 thread play_sfx(var_4, var_2, var_3);
  return var_4;
}

play_sfx(var_0, var_1, var_2) {
  wait(var_1);
  var_0 playLoopSound(var_2);
}

safe_delete(var_0) {
  if(isDefined(var_0))
    var_0 delete();
}

get_obelisk_clip(var_0) {
  foreach(var_2 in self.removeables) {
    if(var_2.classname == "script_brushmodel")
      return var_2;
  }
}

sfx_obelisk_destroyed() {
  playsoundatpos(self.origin, "alien_obelisk_destroyed");
}