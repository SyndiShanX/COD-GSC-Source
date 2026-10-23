/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots.gsc
******************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(getdvarint("4017") == 1) {
    return;
  }
  if(getdvarint("233") == 1) {
    return;
  }
  if(_func_367()) {
    return;
  }
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  setup_callbacks();
  maps\mp\bots\_bots_personality::setup_personalities();
  level.badplace_cylinder_func = ::_badplace_cylinder;
  level.badplace_delete_func = ::_badplace_delete;

  if(isDefined(level.bot_killstreak_setup_func)) {
    [[level.bot_killstreak_setup_func]]();
  } else {
    maps\mp\bots\_bots_ks::bot_killstreak_setup();
  }

  maps\mp\bots\_bots_loadout::init();
  level thread init();
}

setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = ::spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = maps\mp\bots\_bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["bots_remove_from_level_targets"] = maps\mp\bots\_bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["bots_make_entity_sentient"] = ::_id_1A70;
  level.bot_funcs["bots_free_entity_sentient"] = ::bot_free_entity_sentient;
  level.bot_funcs["think"] = ::bot_think;
  level.bot_funcs["on_killed"] = ::on_bot_killed;
  level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
  level.bot_funcs["get_attacker_ent"] = maps\mp\bots\_bots_util::bot_get_known_attacker;
  level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
  level.bot_funcs["on_damaged"] = ::bot_damage_callback;
  level.bot_funcs["gametype_think"] = ::default_gametype_think;
  level.bot_funcs["leader_dialog"] = maps\mp\bots\_bots_util::bot_leader_dialog;
  level.bot_funcs["player_spawned"] = ::bot_player_spawned;
  level.bot_funcs["should_start_cautious_approach"] = maps\mp\bots\_bots_strategy::should_start_cautious_approach_default;
  level.bot_funcs["know_enemies_on_start"] = ::bot_know_enemies_on_start;
  level.bot_funcs["bot_get_rank_xp_and_prestige"] = ::bot_get_rank_xp_and_prestige;
  level.bot_funcs["bot_set_rank_options"] = ::bot_set_rank_options;
  level.bot_funcs["ai_3d_sighting_model"] = ::bot_3d_sighting_model;
  level.bot_funcs["dropped_weapon_think"] = ::bot_think_seek_dropped_weapons;
  level.bot_funcs["dropped_weapon_cancel"] = ::should_stop_seeking_weapon;
  level.bot_funcs["crate_can_use"] = ::crate_can_use_always;
  level.bot_funcs["post_teleport"] = ::bot_post_teleport;
  level.bot_funcs["bot_set_difficulty"] = maps\mp\bots\_bots_util::bot_set_difficulty;
  level.bot_funcs["bot_set_personality"] = maps\mp\bots\_bots_util::bot_set_personality;
  level.bot_funcs["bot_think_watch_enemy"] = ::bot_think_watch_enemy;
  level.bot_funcs["bot_think_tactical_goals"] = maps\mp\bots\_bots_strategy::bot_think_tactical_goals;
  level.bot_funcs["bot_bots_enabled_or_added"] = maps\mp\bots\_bots_util::bot_bots_enabled_or_added;
  level.bot_random_path_function = [];
  level.bot_random_path_function["allies"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_random_path_function["axis"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_random_path_function["hostile"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_random_path_function["neutral"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_find_defend_node_func["capture"] = maps\mp\bots\_bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["capture_zone"] = maps\mp\bots\_bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["protect"] = maps\mp\bots\_bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["protect_zone"] = maps\mp\bots\_bots_strategy::_id_3B73;
  level.bot_find_defend_node_func["bodyguard"] = maps\mp\bots\_bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["patrol"] = maps\mp\bots\_bots_strategy::find_defend_node_patrol;
  _id_87BF();
  maps\mp\bots\_bots_gametype_war::setup_callbacks();
}

_id_87BF() {
  level.bot_funcs["crate_low_ammo_check"] = ::_id_273D;
  level.bot_funcs["crate_should_claim"] = ::_id_2741;
  level.bot_funcs["crate_wait_use"] = ::_id_2743;
  level.bot_funcs["crate_in_range"] = ::crate_in_range;
  level.bot_can_use_box_by_type["deployable_vest"] = ::_id_1AE6;
  level.bot_can_use_box_by_type["deployable_ammo"] = ::bot_should_use_ammo_crate;
  level.bot_can_use_box_by_type["scavenger_bag"] = ::bot_should_use_scavenger_bag;
  level.bot_can_use_box_by_type["deployable_grenades"] = ::bot_should_use_grenade_crate;
  level.bot_can_use_box_by_type["deployable_juicebox"] = ::_id_1AE8;
  level.bot_pre_use_box_of_type["deployable_ammo"] = ::_id_1AA1;
  level.bot_post_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
}

_id_0049(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_1);
  }
}

init() {
  thread monitor_smoke_grenades();
  thread bot_triggers();
  initbotlevelvariables();

  if(!shouldspawnbots()) {
    return;
  }
  refresh_existing_bots();
  var_0 = _botautoconnectenabled();

  if(var_0 == "enabled_fill_open" || var_0 == "enabled_fill_open_dev" || level._id_53C7) {
    setmatchdata("match_common", "has_bots", 1);
    level thread bot_connect_monitor();
  } else
    level thread bot_monitor_team_limits();
}

initbotlevelvariables() {
  if(!isDefined(level.crateownerusetime)) {
    level.crateownerusetime = 500;
  }

  if(!isDefined(level.cratenonownerusetime)) {
    level.cratenonownerusetime = 3000;
  }

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name["recruit"] = "iw5_maaws";
  level.bot_respawn_launcher_name["regular"] = "iw5_maaws";
  level.bot_respawn_launcher_name["hardened"] = "iw5_maaws";
  level.bot_respawn_launcher_name["veteran"] = "iw5_maaws";
  level.bot_fallback_weapon = "m1garand_mp";
  level.zonecount = _getzonecount();
  initbotmapextents();
}

initbotmapextents() {
  if(isDefined(level.teleportgetactivenodesfunc)) {
    var_0 = [[level.teleportgetactivenodesfunc]]();
  } else {
    var_0 = _getallnodes();
  }

  level.bot_map_min_x = 0;
  level.bot_map_max_x = 0;
  level.bot_map_min_y = 0;
  level.bot_map_max_y = 0;
  level.bot_map_min_z = 0;
  level.bot_map_max_z = 0;

  if(var_0.size > 1) {
    level.bot_map_min_x = var_0[0].origin[0];
    level.bot_map_max_x = var_0[0].origin[0];
    level.bot_map_min_y = var_0[0].origin[1];
    level.bot_map_max_y = var_0[0].origin[1];
    level.bot_map_min_z = var_0[0].origin[2];
    level.bot_map_max_z = var_0[0].origin[2];

    for(var_1 = 1; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1].origin;

      if(var_2[0] < level.bot_map_min_x) {
        level.bot_map_min_x = var_2[0];
      }

      if(var_2[0] > level.bot_map_max_x) {
        level.bot_map_max_x = var_2[0];
      }

      if(var_2[1] < level.bot_map_min_y) {
        level.bot_map_min_y = var_2[1];
      }

      if(var_2[1] > level.bot_map_max_y) {
        level.bot_map_max_y = var_2[1];
      }

      if(var_2[2] < level.bot_map_min_z) {
        level.bot_map_min_z = var_2[2];
      }

      if(var_2[2] > level.bot_map_max_z) {
        level.bot_map_max_z = var_2[2];
      }
    }
  }

  level.bot_map_center = ((level.bot_map_min_x + level.bot_map_max_x) / 2, (level.bot_map_min_y + level.bot_map_max_y) / 2, (level.bot_map_min_z + level.bot_map_max_z) / 2);
  level.bot_variables_initialized = 1;
}

bot_post_teleport() {
  level.bot_variables_initialized = undefined;
  level.bot_initialized_remote_vehicles = undefined;
  initbotmapextents();
  maps\mp\bots\_bots_ks_remote_vehicle::remote_vehicle_setup();
}

shouldspawnbots() {
  return 1;
}

refresh_existing_bots() {
  wait 1;

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      var_1.equipment_enabled = 1;
      var_1.bot_team = var_1.team;
      var_1.bot_spawned_before = 1;
      var_1 thread[[level.bot_funcs["think"]]]();
    }
  }
}

bot_player_spawned() {
  bot_set_loadout_class();
}

bot_set_loadout_class() {
  if(!isDefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while(!isDefined(level.bot_loadouts_initialized)) {
        waitframe();
      }

      if(isDefined(self.override_class_function)) {
        self.bot_class = [[self.override_class_function]]();
      } else {
        self.bot_class = maps\mp\bots\_bots_personality::bot_setup_callback_class();
      }
    } else
      self.bot_class = self.class;
  }
}

watch_players_connecting() {
  for(;;) {
    level waittill("connected", var_0);

    if(!_isai(var_0) && level.players.size > 0) {
      level.players_waiting_to_join = common_scripts\utility::_id_0F6F(level.players_waiting_to_join, var_0);
      childthread bots_notify_on_spawn(var_0);
      childthread bots_notify_on_disconnect(var_0);
      childthread bots_remove_from_array_on_notify(var_0);
    }
  }
}

bots_notify_on_spawn(var_0) {
  var_0 endon("bots_human_disconnected");

  while(!common_scripts\utility::_id_0F79(level.players, var_0)) {
    waitframe();
  }

  var_0 notify("bots_human_spawned");
}

bots_notify_on_disconnect(var_0) {
  var_0 endon("bots_human_spawned");
  var_0 waittill("disconnect");
  var_0 notify("bots_human_disconnected");
}

bots_remove_from_array_on_notify(var_0) {
  var_0 common_scripts\utility::waittill_any("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = common_scripts\utility::_id_0F93(level.players_waiting_to_join, var_0);
}

monitor_pause_spawning() {
  level.players_waiting_to_join = [];
  childthread watch_players_connecting();

  for(;;) {
    if(level.players_waiting_to_join.size > 0) {
      level.pausing_bot_connect_monitor = 1;
    } else {
      level.pausing_bot_connect_monitor = 0;
    }

    wait 0.5;
  }
}

bot_can_join_team(var_0) {
  if(maps\mp\_utility::matchmakinggame()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(_id_0510::getjointeampermissions(var_0)) {
    return 1;
  }

  return 0;
}

bot_allowed_to_switch_teams() {
  if(isDefined(level.bots_disable_team_switching) && level.bots_disable_team_switching) {
    return 0;
  }

  if(isDefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled) {
    return 0;
  }

  return 1;
}

bot_connect_monitor() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  if(!isDefined(level.bot_cm_spawned_bots)) {
    level.bot_cm_spawned_bots = 0;
  }

  if(!isDefined(level.bot_cm_waited_players_time)) {
    level.bot_cm_waited_players_time = 0;
  }

  if(!isDefined(level.bot_cm_human_picked)) {
    level.bot_cm_human_picked = 0;
  }

  for(;;) {
    if(level.pausing_bot_connect_monitor) {
      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
      continue;
    }

    var_1 = isDefined(level.bots_ignore_team_balance) || !level.teambased;
    var_2 = _botgetteamlimit(0);
    var_3 = _botgetteamlimit(1);

    if(level._id_53C7) {
      var_2 = level.setshader;
      var_3 = level.settargetent;
    }

    var_4 = _botgetteamdifficulty(0);
    var_5 = _botgetteamdifficulty(1);
    var_9 = "allies";

    if(isDefined(level.bot_last_team_ally)) {
      var_9 = level.bot_last_team_ally;
    }

    var_10 = "axis";

    if(isDefined(level.bot_last_team_enemy)) {
      var_10 = level.bot_last_team_enemy;
    }

    var_11 = bot_client_counts();
    var_12 = cat_array_get(var_11, "humans");

    if(var_12 > 1) {
      var_13 = bot_get_host_team();

      if(!maps\mp\_utility::matchmakinggame() && isDefined(var_13) && var_13 != "spectator") {
        var_9 = var_13;
        var_10 = maps\mp\_utility::getotherteam(var_13);
      } else {
        var_14 = cat_array_get(var_11, "humans_allies");
        var_15 = cat_array_get(var_11, "humans_axis");

        if(var_15 > var_14) {
          var_9 = "axis";
          var_10 = "allies";
        }
      }
    } else {
      var_16 = get_human_player();

      if(isDefined(var_16)) {
        var_17 = var_16 bot_get_player_team();

        if(isDefined(var_17) && var_17 != "spectator") {
          var_9 = var_17;
          var_10 = maps\mp\_utility::getotherteam(var_17);
        }
      }
    }

    level.bot_last_team_ally = var_9;
    level.bot_last_team_enemy = var_10;
    var_18 = maps\mp\bots\_bots_util::bot_get_team_limit();
    var_19 = maps\mp\bots\_bots_util::bot_get_team_limit();
    var_20 = maps\mp\bots\_bots_util::bot_get_client_limit();

    if(var_18 + var_19 < var_20) {
      if(var_18 < var_2) {
        var_18++;
      } else if(var_19 < var_3) {
        var_19++;
      }
    }

    var_21 = cat_array_get(var_11, "humans_" + var_9);
    var_22 = cat_array_get(var_11, "humans_" + var_10);
    var_23 = var_21 + var_22;
    var_24 = cat_array_get(var_11, "spectator");
    var_25 = 0;

    for(var_26 = 0; var_24 > 0; var_24--) {
      var_27 = var_21 + var_25 + 1 <= var_18;
      var_28 = var_22 + var_26 + 1 <= var_19;

      if(var_27 && !var_28) {
        var_25++;
        continue;
      }

      if(!var_27 && var_28) {
        var_26++;
        continue;
      }

      if(var_27 && var_28) {
        if(var_24 % 2 == 1) {
          var_25++;
          continue;
        }

        var_26++;
      }
    }

    var_29 = cat_array_get(var_11, "bots_" + var_9);
    var_30 = cat_array_get(var_11, "bots_" + var_10);
    var_31 = var_29 + var_30;

    if(var_31 > 0) {
      level.bot_cm_spawned_bots = 1;
    }

    var_32 = 0;

    if(!level.bot_cm_human_picked) {
      var_32 = !bot_get_human_picked_team();

      if(!var_32) {
        level.bot_cm_human_picked = 1;
      }
    }

    if(var_32) {
      var_33 = !_isonlinegame();
      var_34 = var_3 != var_2;
      var_35 = !bot_get_human_picked_team() && !var_1 && var_34 && !level.bot_cm_spawned_bots && (level.bot_cm_waited_players_time < 10 || !maps\mp\_utility::gameflag("prematch_done"));
      var_36 = 0;

      if(var_33 || var_35 || var_36) {
        level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_0;
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
        continue;
      }
    }

    var_37 = int(_min(var_18 - var_21 - var_25, var_2));
    var_38 = int(_min(var_19 - var_22 - var_26, var_3));
    var_39 = 1;
    var_40 = var_37 + var_38 + var_12;
    var_41 = var_2 + var_3 + var_12;

    for(var_42 = [-1, -1]; var_40 < var_20 && var_40 < var_41; var_39 = !var_39) {
      if(var_39 && var_37 < var_2 && bot_can_join_team(var_9)) {
        var_37++;
      } else if(!var_39 && var_38 < var_3 && bot_can_join_team(var_10)) {
        var_38++;
      }

      var_40 = var_37 + var_38 + var_12;

      if(var_42[var_39] == var_40) {
        break;
      }

      var_42[var_39] = var_40;
    }

    level.bot_max_players_on_team[var_9] = int(var_37 + var_21 + var_25);
    level.bot_max_players_on_team[var_10] = int(var_38 + var_22 + var_26);
    update_max_players_from_team_agents();

    if(var_2 == var_3 && !var_1 && var_25 == 1 && var_26 == 0 && var_38 > 0) {
      if(!isDefined(level.bot_prematchdonetime) && maps\mp\_utility::gameflag("prematch_done")) {
        level.bot_prematchdonetime = gettime();
      }

      if(var_32 && (!isDefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000)) {
        var_38--;
      }
    }

    var_44 = var_37 - var_29;
    var_45 = var_38 - var_30;
    var_46 = 1;

    if(var_1) {
      var_47 = var_18 + var_19;
      var_48 = var_2 + var_3;
      var_49 = var_21 + var_22;
      var_50 = var_29 + var_30;
      var_51 = int(_min(var_47 - var_49, var_48));
      var_52 = var_51 - var_50;

      if(var_52 == 0) {
        var_46 = 0;
      } else if(var_52 > 0) {
        var_44 = int(var_52 / 2) + var_52 % 2;
        var_45 = int(var_52 / 2);
      } else if(var_52 < 0) {
        var_53 = var_52 * -1;
        var_44 = -1 * int(_min(var_53, var_29));
        var_45 = -1 * (var_53 + var_44);
      }
    } else if(!maps\mp\_utility::matchmakinggame() && (var_44 * var_45 < 0 && maps\mp\_utility::gameflag("prematch_done") && bot_allowed_to_switch_teams())) {
      var_54 = int(_min(_abs(var_44), _abs(var_45)));

      if(var_44 > 0) {
        move_bots_from_team_to_team(var_54, var_10, var_9, var_4);
      } else if(var_45 > 0) {
        move_bots_from_team_to_team(var_54, var_9, var_10, var_5);
      }

      var_46 = 0;
    }

    if(var_46) {
      if(var_45 < 0) {
        drop_bots(var_45 * -1, var_10);
      }

      if(var_44 < 0) {
        drop_bots(var_44 * -1, var_9);
      }

      if(var_45 > 0) {
        level thread spawn_bots(var_45, var_10, undefined, undefined, "spawned_enemies", var_5);
      }

      if(var_44 > 0) {
        level thread spawn_bots(var_44, var_9, undefined, undefined, "spawned_allies", var_4);
      }

      if(var_45 > 0 && var_44 > 0) {
        level common_scripts\utility::waittill_multiple("spawned_enemies", "spawned_allies");
      } else if(var_45 > 0) {
        level waittill("spawned_enemies");
      } else if(var_44 > 0) {
        level waittill("spawned_allies");
      }
    }

    if(var_5 != var_4) {
      bots_update_difficulty(var_10, var_5);
      bots_update_difficulty(var_9, var_4);
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

bot_monitor_team_limits() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  for(;;) {
    level.bot_max_players_on_team["allies"] = 0;
    level.bot_max_players_on_team["axis"] = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.team) && (var_2.team == "allies" || var_2.team == "axis")) {
        level.bot_max_players_on_team[var_2.team]++;
      }
    }

    update_max_players_from_team_agents();
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

update_max_players_from_team_agents() {
  if(isDefined(level._id_0A4E)) {
    foreach(var_1 in level._id_0A4E) {
      if(isDefined(var_1.isactive) && var_1.isactive) {
        if(maps\mp\_utility::isteamparticipant(var_1) && isDefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis")) {
          level.bot_max_players_on_team[var_1.team]++;
        }
      }
    }
  }
}

bot_get_player_team() {
  if(isDefined(self.team)) {
    return self.team;
  }

  if(isDefined(self.pers["team"])) {
    return self.pers["team"];
  }

  return undefined;
}

bot_get_host_team() {
  foreach(var_1 in level.players) {
    if(!_isai(var_1) && var_1 ishost()) {
      return var_1 bot_get_player_team();
    }
  }

  return "spectator";
}

bot_get_human_picked_team() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!_isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(player_picked_team(var_4)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

player_picked_team(var_0) {
  if(isDefined(var_0.team) && var_0.team != "spectator") {
    return 1;
  }

  if(isDefined(var_0.spectating_actively) && var_0.spectating_actively) {
    return 1;
  }

  if(var_0 ismlgspectator()) {
    return 1;
  }

  return 0;
}

bot_get_human_picked_class() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!_isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(isDefined(var_4.class)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

bot_client_counts() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(isDefined(var_2) && isDefined(var_2.team)) {
      var_0 = cat_array_add(var_0, "all");
      var_0 = cat_array_add(var_0, var_2.team);

      if(isbot(var_2)) {
        var_0 = cat_array_add(var_0, "bots");
        var_0 = cat_array_add(var_0, "bots_" + var_2.team);
        continue;
      }

      var_0 = cat_array_add(var_0, "humans");
      var_0 = cat_array_add(var_0, "humans_" + var_2.team);
    }
  }

  return var_0;
}

cat_array_add(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  if(!isDefined(var_0[var_1])) {
    var_0[var_1] = 0;
  }

  var_0[var_1] = var_0[var_1] + 1;
  return var_0;
}

cat_array_get(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0[var_1])) {
    return 0;
  }

  return var_0[var_1];
}

move_bots_from_team_to_team(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(isDefined(var_5.connected) && var_5.connected && isbot(var_5) && var_5.team == var_1) {
      var_5.bot_team = var_2;

      if(isDefined(var_3)) {
        var_5 maps\mp\bots\_bots_util::bot_set_difficulty(var_3);
      }

      var_5 notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_2));
      waitframe();
      var_5 notify("luinotifyserver", "class_select", var_5.bot_class);
      var_0--;

      if(var_0 <= 0) {
        break;
      } else
        wait 0.1;
    }
  }
}

bots_update_difficulty(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(isDefined(var_3.connected) && var_3.connected && isbot(var_3) && var_3.team == var_0) {
      if(var_1 != var_3 botgetdifficulty()) {
        var_3 maps\mp\bots\_bots_util::bot_set_difficulty(var_1);
      }
    }
  }
}

bot_drop() {
  _kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

drop_bots(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4.connected) && var_4.connected && isbot(var_4) && (!isDefined(var_1) || isDefined(var_4.team) && var_4.team == var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!maps\mp\_utility::isreallyalive(var_2[var_6])) {
      var_2[var_6] bot_drop();
      var_2 = common_scripts\utility::_id_0F93(var_2, var_2[var_6]);
      var_0--;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    var_2[var_6] bot_drop();
    var_0--;
  }
}

bot_lui_convert_team_to_int(var_0) {
  if(var_0 == "axis") {
    return 0;
  } else if(var_0 == "allies") {
    return 1;
  } else if(var_0 == "autoassign" || var_0 == "random") {
    return 2;
  } else {
    return 3;
  }
}

spawn_bot_latent(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while(!self canspawntestclient()) {
    if(gettime() >= var_3) {
      _kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
      var_2._id_0843 = 1;
      return;
    }

    waitframe();

    if(!isDefined(self)) {
      var_2._id_0843 = 1;
      return;
    }
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(_randomfloatrange(0.25, 2.0));

  if(!isDefined(self)) {
    var_2._id_0843 = 1;
    return;
  }

  self spawntestclient();
  self.equipment_enabled = 1;
  self.bot_team = var_0;

  if(isDefined(var_2.difficulty)) {
    maps\mp\bots\_bots_util::bot_set_difficulty(var_2.difficulty);
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }

  self thread[[level.bot_funcs["think"]]]();
  var_2.ready = 1;
}

spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 10000;
  var_7 = [];
  var_8 = var_7.size;

  while(level.players.size < maps\mp\bots\_bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = _addbot("", var_1);

    if(!isDefined(var_9)) {
      if(isDefined(var_3) && var_3) {
        if(isDefined(var_4)) {
          self notify(var_4);
        }

        return;
      }

      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_10 = spawnStruct();
      var_10.bot = var_9;
      var_10.ready = 0;
      var_10._id_0843 = 0;
      var_10._id_00D4 = var_8;
      var_10.difficulty = var_5;
      var_7[var_7.size] = var_10;
      var_10.bot thread spawn_bot_latent(var_1, var_2, var_10);
      var_8++;
    }
  }

  var_11 = 0;
  var_6 = gettime() + 60000;

  while(var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10.ready || var_10._id_0843) {
        var_11++;
      }
    }

    waitframe();
  }

  if(isDefined(var_4)) {
    self notify(var_4);
  }
}

bot_gametype_chooses_team() {
  if(maps\mp\_utility::matchmakinggame() && self._id_0179 != "none") {
    var_0 = 0;
  } else if(!maps\mp\_utility::matchmakinggame() && maps\mp\_utility::_id_0C2D()) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  return !var_0;
}

bot_gametype_chooses_class() {
  return isDefined(level.bots_gametype_handles_class_choice) && level.bots_gametype_handles_class_choice;
}

bot_think() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while(!isDefined(self.pers["team"])) {
    waitframe();
  }

  level.hasbots = 1;

  if(bot_gametype_chooses_team()) {
    self.bot_team = self.pers["team"];
  }

  var_0 = self.bot_team;

  if(!isDefined(var_0)) {
    var_0 = self.pers["team"];
  }

  self.entity_number = self getentitynumber();
  var_1 = 0;

  if(!isDefined(self.bot_spawned_before)) {
    var_1 = 1;
    self.bot_spawned_before = 1;

    if(!bot_gametype_chooses_team()) {
      var_2 = self.pers["team"] != "spectator" && !isDefined(self.bot_team);

      if(!var_2) {
        self notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_0));
        wait 0.5;

        if(self.pers["team"] == "spectator") {
          bot_drop();
          return;
        }
      }
    }
  }

  for(;;) {
    maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
    self.difficulty = self botgetdifficulty();
    var_3 = self botgetdifficultysetting("advancedPersonality");

    if(var_1 && isDefined(var_3) && var_3 != 0) {
      maps\mp\bots\_bots_personality::bot_balance_personality();
    }

    maps\mp\bots\_bots_personality::bot_assign_personality_functions();

    if(var_1) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["class_select_override"])) {
        self[[level.bot_funcs["class_select_override"]]]();
      } else {
        bot_set_loadout_class();

        if(!bot_gametype_chooses_class()) {
          if(isDefined(self.connecttime) && self.connecttime == gettime()) {
            waittillframeend;
            waittillframeend;
          }

          if(maps\mp\_utility::isprophuntgametype() && var_0 == game["attackers"] && game["roundsPlayed"] > 0) {
            wait 0.5;
          }

          self notify("luinotifyserver", "class_select", self.bot_class);
        }
      }

      if(self.health == 0) {
        self waittill("spawned_player");
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"])) {
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();
      }

      var_1 = 0;
    }

    maps\mp\bots\_bots_loadout::bot_modify_behavior_from_loadout();
    bot_modify_behavior_from_tweakables();
    bot_restart_think_threads();
    wait 0.1;
    self waittill("death");

    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_death_func"])) {
      self[[level.bot_funcs["post_death_func"]]]();
    }

    respawn_watcher();
    self waittill("spawned_player");
  }
}

bot_set_rank_options() {}

bot_modify_behavior_from_tweakables() {
  if(_id_0511::gettweakablevalue("game", "onlyheadshots")) {
    self botsetflag("only_headshots", 1);
  }
}

respawn_watcher() {
  self endon("started_spawnPlayer");

  while(!self.waitingtospawn) {
    waitframe();
  }

  if(maps\mp\gametypes\_playerlogic::needsbuttontorespawn()) {
    while(self.waitingtospawn) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0) {
          self botpressbutton("use", 0.5);
        }
      }

      wait 1.0;
    }
  }
}

bot_israndom() {
  return self botisrandomized();
}

bot_get_rank_xp_and_prestige() {
  var_0 = spawnStruct();

  if(!bot_israndom()) {
    if(!isDefined(self.pers["rankxp"])) {
      self.pers["rankxp"] = 0;
    }

    if(!isDefined(self.pers["prestige"])) {
      self.pers["prestige"] = 0;
    }

    var_0.rankxp = self.pers["rankxp"];
    var_0.prestige = self.pers["prestige"];
    return var_0;
  }

  var_1 = self botgetdifficulty();
  var_2 = "bot_rank_" + var_1;
  var_3 = "bot_prestige_" + var_1;
  var_4 = self.pers[var_2];
  var_5 = self.pers[var_3];
  var_6 = undefined;

  if(isDefined(var_4)) {
    var_0.rankxp = var_4;
  } else {
    if(!isDefined(var_6)) {
      var_6 = bot_random_ranks_for_difficulty(var_1);
    }

    var_7 = var_6["rank"];
    var_8 = maps\mp\gametypes\_rank::getrankinfominxp(var_7);
    var_9 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_7);
    var_10 = _randomintrange(var_8, var_9);
    self.pers[var_2] = var_10;
    var_0.rankxp = var_10;
  }

  if(isDefined(var_5)) {
    var_0.prestige = var_5;
  } else {
    if(!isDefined(var_6)) {
      var_6 = bot_random_ranks_for_difficulty(var_1);
    }

    var_11 = var_6["prestige"];
    self.pers[var_3] = var_11;
    var_0.prestige = var_11;
  }

  return var_0;
}

bot_3d_sighting_model(var_0) {
  thread bot_3d_sighting_model_thread(var_0);
}

bot_3d_sighting_model_thread(var_0) {
  var_0 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(var_0) && common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
      self botgetimperfectenemyinfo(var_0, var_0.origin);
    }

    wait 0.1;
  }
}

bot_random_ranks_for_difficulty(var_0) {
  var_1 = [];
  var_1["rank"] = 0;
  var_1["prestige"] = 0;

  if(var_0 == "default") {
    return var_1;
  }

  if(!isDefined(level.bot_rnd_rank)) {
    level.bot_rnd_rank = [];
    level.bot_rnd_rank["recruit"][0] = 0;
    level.bot_rnd_rank["recruit"][1] = 1;
    level.bot_rnd_rank["regular"][0] = 20;
    level.bot_rnd_rank["regular"][1] = 28;
    level.bot_rnd_rank["hardened"][0] = 40;
    level.bot_rnd_rank["hardened"][1] = 48;
    level.bot_rnd_rank["veteran"][0] = 50;
    level.bot_rnd_rank["veteran"][1] = 54;
  }

  if(!isDefined(level.bot_rnd_prestige)) {
    level.bot_rnd_prestige = [];
    level.bot_rnd_prestige["recruit"][0] = 0;
    level.bot_rnd_prestige["recruit"][1] = 0;
    level.bot_rnd_prestige["regular"][0] = 0;
    level.bot_rnd_prestige["regular"][1] = 0;
    level.bot_rnd_prestige["hardened"][0] = 0;
    level.bot_rnd_prestige["hardened"][1] = 0;
    level.bot_rnd_prestige["veteran"][0] = 0;
    level.bot_rnd_prestige["veteran"][1] = 9;
  }

  var_1["rank"] = _randomintrange(level.bot_rnd_rank[var_0][0], level.bot_rnd_rank[var_0][1] + 1);
  var_1["prestige"] = _randomintrange(level.bot_rnd_prestige[var_0][0], level.bot_rnd_prestige[var_0][1] + 1);
  return var_1;
}

crate_can_use_always(var_0) {
  if(_isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  return 1;
}

get_human_player() {
  var_0 = undefined;
  var_1 = getEntArray("player", "classname");

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2].connected) && var_1[var_2].connected && !_isai(var_1[var_2]) && (!isDefined(var_0) || var_0.team == "spectator")) {
        var_0 = var_1[var_2];
      }
    }
  }

  return var_0;
}

bot_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE") {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(var_4)) {
    if(!isDefined(var_0)) {
      return;
    }
    var_4 = var_0;
  }

  if(isDefined(var_4)) {
    if(level.teambased) {
      if(isDefined(var_4.team) && var_4.team == self.team) {
        return;
      } else if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
        return;
      }
    }

    var_6 = maps\mp\bots\_bots_util::bot_get_known_attacker(var_0, var_4);

    if(isDefined(var_6)) {
      self botsetattacker(var_6);
    }
  }

  if(_isagent(self)) {
    self notify("agentDamage");
  }
}

on_bot_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var_10 = maps\mp\bots\_bots_util::bot_get_known_attacker(var_1, var_0);

  if(isDefined(var_10) && var_10.classname == "misc_turret" && isDefined(var_10.chopper)) {
    var_10 = var_10.chopper;
  }

  if(isDefined(var_10) && (var_10.classname == "script_vehicle" || var_10.classname == "script_model") && isDefined(var_10.helitype)) {
    var_11 = self botgetdifficultysetting("launcherRespawnChance");

    if(_randomfloat(1.0) < var_11) {
      self.respawn_with_launcher = 1;
    }
  }
}

bot_should_do_killcam() {
  var_5 = 0.0;
  var_6 = self botgetdifficulty();

  if(var_6 == "recruit") {
    var_5 = 0.1;
  } else if(var_6 == "regular") {
    var_5 = 0.4;
  } else if(var_6 == "hardened") {
    var_5 = 0.7;
  } else if(var_6 == "veteran") {
    var_5 = 1.0;
  }

  return _randomfloat(1.0) < 1.0 - var_5;
}

bot_should_pickup_weapons() {
  return 1;
}

bot_restart_think_threads() {
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]]();
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();

  if(!level._id_53C7) {
    thread _id_1AFE();
    thread _id_1AFF();
  }

  if(maps\mp\_utility::_id_0F5C()) {
    thread maps\mp\bots\_bots_ks::bot_think_killstreak();
    thread maps\mp\bots\_bots_ks::bot_think_watch_aerial_killstreak();
  }

  thread bot_think_gametype();
}

bot_think_watch_enemy(var_0) {
  var_1 = "spawned_player";

  if(isDefined(var_0) && var_0) {
    var_1 = "death";
  }

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var_1);
  self endon("disconnect");
  level endon("game_ended");
  self.last_enemy_sight_time = 0;

  for(;;) {
    if(isDefined(self._id_0088)) {
      if(self botcanseeentity(self._id_0088)) {
        self.last_enemy_sight_time = gettime();
      }
    }

    waitframe();
  }
}

bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = 0;

    if(maps\mp\bots\_bots_util::bot_out_of_ammo()) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = common_scripts\utility::get_array_of_closest(self.origin, var_1);

        if(var_2.size > 0) {
          var_3 = var_2[0];
          bot_seek_dropped_weapon(var_3);
        }
      }
    }

    wait(_randomfloatrange(0.25, 0.75));
  }
}

bot_seek_dropped_weapon(var_0) {
  if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var_0) == 0) {
    var_1 = undefined;

    if(var_0.targetname == "dropped_weapon") {
      var_2 = 1;
      var_3 = self getweaponlistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == _getweaponmodel(var_5)) {
          var_2 = 0;
        }
      }

      if(var_2) {
        var_1 = ::bot_pickup_weapon;
      }
    }

    var_7 = spawnStruct();
    var_7.object = var_0;
    var_7.script_goal_radius = 12;
    var_7.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var_7._id_087F = var_1;
    maps\mp\bots\_bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var_0.origin, 100, var_7);
  }
}

bot_pickup_weapon(var_0) {
  self botpressbutton("use", 2);
  wait 2;
}

should_stop_seeking_weapon(var_0) {
  if(!isDefined(var_0.object)) {
    return 1;
  }

  if(var_0.object.targetname == "dropped_weapon") {
    if(maps\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0) {
      return 1;
    }
  } else if(var_0.object.targetname == "dropped_knife") {
    if(maps\mp\bots\_bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

crate_in_range(var_0) {
  if(!isDefined(var_0._id_0117) || var_0._id_0117 != self) {
    if(distancesquared(self.origin, var_0.origin) > 4194304) {
      return 0;
    }
  }

  return 1;
}

bot_crate_valid(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!self[[level.bot_funcs["crate_can_use"]]](var_0)) {
    return 0;
  }

  if(!crate_landed_and_on_path_grid(var_0)) {
    return 0;
  }

  if(level.teambased && isDefined(var_0.bomb) && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(!self[[level.bot_funcs["crate_in_range"]]](var_0)) {
    return 0;
  }

  if(isDefined(var_0.boxtype)) {
    if(isDefined(level.boxsettings) && isDefined(level.boxsettings[var_0.boxtype]) && ![[level.boxsettings[var_0.boxtype].canusecallback]]()) {
      return 0;
    }

    if(isDefined(var_0.disabled_use_for) && isDefined(var_0.disabled_use_for[self getentitynumber()]) && var_0.disabled_use_for[self getentitynumber()]) {
      return 0;
    }

    if(!self[[level.bot_can_use_box_by_type[var_0.boxtype]]](var_0)) {
      return 0;
    }
  } else if(_id_1A13(var_0))
    return 0;

  return isDefined(var_0);
}

_id_1A13(var_0) {
  if(isDefined(var_0._id_944E) && isDefined(self.pers["killstreaks"])) {
    foreach(var_2 in self.pers["killstreaks"]) {
      if(common_scripts\utility::_id_562E(var_2._id_5703) && isDefined(var_2.streakname) && var_2.streakname == var_0._id_944E) {
        return 1;
      }
    }
  }

  return 0;
}

crate_landed_and_on_path_grid(var_0) {
  if(!crate_has_landed(var_0)) {
    return 0;
  }

  if(!crate_is_on_path_grid(var_0)) {
    return 0;
  }

  return isDefined(var_0);
}

crate_has_landed(var_0) {
  if(isDefined(var_0.boxtype)) {
    return gettime() > var_0._id_002B + 1000;
  } else {
    return isDefined(var_0.droppingtoground) && !var_0.droppingtoground;
  }
}

crate_is_on_path_grid(var_0) {
  if(!isDefined(var_0.on_path_grid)) {
    crate_calculate_on_path_grid(var_0);
  }

  return isDefined(var_0) && var_0.on_path_grid;
}

node_within_use_radius_of_crate(var_0, var_1) {
  if(isDefined(var_1.boxtype) && var_1.boxtype == "scavenger_bag") {
    return _abs(var_0.origin[0] - var_1.origin[0]) < 36 && _abs(var_0.origin[0] - var_1.origin[0]) < 36 && _abs(var_0.origin[0] - var_1.origin[0]) < 18;
  } else {
    var_2 = getdvarfloat("2098");
    var_3 = distancesquared(var_1.origin, var_0.origin + (0, 0, 40));
    return var_3 <= var_2 * var_2;
  }
}

crate_calculate_on_path_grid(var_0) {
  var_0 thread crate_monitor_position();
  var_0.on_path_grid = 0;
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0.forcedisconnectuntil)) {
    var_1 = var_0.forcedisconnectuntil;
    var_2 = gettime() + 30000;
    var_0.forcedisconnectuntil = var_2;
    var_0 notify("path_disconnect");
  }

  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = [];
  var_3 = crate_get_nearest_valid_nodes(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_3) && var_3.size > 0) {
    var_0.nearest_nodes = var_3;
    var_0.on_path_grid = 1;
  } else {
    var_4 = getdvarfloat("2098");
    var_5 = _getnodesinradiussorted(var_0.origin, var_4 * 2, 0)[0];
    var_6 = var_0 getpointinbounds(0, 0, -1);
    var_7 = undefined;

    if(isDefined(var_0.boxtype) && var_0.boxtype == "scavenger_bag") {
      if(maps\mp\bots\_bots_util::bot_point_is_on_pathgrid(var_0.origin)) {
        var_7 = var_0.origin;
      }
    } else
      var_7 = _botgetclosestnavigablepoint(var_0.origin, var_4);

    if(isDefined(var_5) && !var_5 nodeisdisconnected() && isDefined(var_7) && _abs(var_5.origin[2] - var_6[2]) < 30) {
      var_0.nearest_points = [var_7];
      var_0.nearest_nodes = [var_5];
      var_0.on_path_grid = 1;
    }
  }

  if(isDefined(var_0.forcedisconnectuntil)) {
    if(var_0.forcedisconnectuntil == var_2) {
      var_0.forcedisconnectuntil = var_1;
    }
  }
}

crate_get_nearest_valid_nodes(var_0) {
  var_1 = _getnodesinradiussorted(var_0.origin, 256, 0);

  for(var_2 = var_1.size; var_2 > 0; var_2--) {
    var_1[var_2] = var_1[var_2 - 1];
  }

  var_1[0] = _getclosestnodeinsight(var_0.origin);
  var_3 = undefined;

  if(isDefined(var_0.forcedisconnectuntil)) {
    var_3 = _getallnodes();
  }

  var_4 = [];
  var_5 = 1;

  if(!isDefined(var_0.boxtype)) {
    var_5 = 2;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_6 = var_1[var_2];

    if(!isDefined(var_6) || !isDefined(var_0)) {
      continue;
    }
    if(var_6 nodeisdisconnected()) {
      continue;
    }
    if(!node_within_use_radius_of_crate(var_6, var_0)) {
      if(var_2 == 0) {
        continue;
      } else {
        break;
      }
    }

    waitframe();

    if(!isDefined(var_0)) {
      break;
    }

    if(_sighttracepassed(var_0.origin, var_6.origin + (0, 0, 55), 0, var_0)) {
      waitframe();

      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_0.forcedisconnectuntil)) {
        var_4[var_4.size] = var_6;

        if(var_4.size == var_5) {
          return var_4;
        } else {
          continue;
        }
      }

      var_7 = undefined;
      var_8 = 0;

      while(!isDefined(var_7) && var_8 < 100) {
        var_8++;
        var_9 = common_scripts\utility::random(var_3);

        if(distancesquared(var_6.origin, var_9.origin) > 250000) {
          var_7 = var_9;
        }
      }

      if(isDefined(var_7)) {
        var_10 = maps\mp\bots\_bots_util::bot_queued_process("GetNodesOnPathCrate", maps\mp\bots\_bots_util::func_get_nodes_on_path, var_6.origin, var_7.origin);

        if(isDefined(var_10)) {
          var_4[var_4.size] = var_6;

          if(var_4.size == var_5) {
            return var_4;
          } else {
            continue;
          }
        }
      }
    }
  }

  return undefined;
}

crate_get_bot_target(var_0) {
  if(isDefined(var_0.nearest_points)) {
    return var_0.nearest_points[0];
  }

  if(isDefined(var_0.nearest_nodes) && var_0.nearest_nodes.size > 0) {
    var_1 = common_scripts\utility::_id_0FA2(self botnodescoremultiple(var_0.nearest_nodes, "node_exposed"));
    return common_scripts\utility::random_weight_sorted(var_1).origin;
  }
}

_id_1AFE() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("2098");

  for(;;) {
    var_1 = _randomfloatrange(2, 4);
    common_scripts\utility::waittill_notify_or_timeout("new_crate_to_take", var_1);

    if(isDefined(self.boxes) && self.boxes.size == 0) {
      self.boxes = undefined;
    }

    var_2 = level._id_1FFD;

    if(!maps\mp\bots\_bots_util::bot_in_combat() && isDefined(self.boxes)) {
      var_2 = common_scripts\utility::_id_0F73(var_2, self.boxes);
    }

    if(isDefined(level.bot_scavenger_bags) && maps\mp\_utility::_hasperk("specialty_scavenger")) {
      var_2 = common_scripts\utility::_id_0F73(var_2, level.bot_scavenger_bags);
    }

    var_2 = common_scripts\utility::_id_0FA0(var_2);

    if(var_2.size == 0) {
      continue;
    }
    if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    var_3 = [];

    foreach(var_5 in var_2) {
      if(bot_crate_valid(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    var_3 = common_scripts\utility::_id_0F97(var_3);

    if(var_3.size == 0) {
      continue;
    }
    var_3 = common_scripts\utility::get_array_of_closest(self.origin, var_3);
    var_7 = self getnearestnode();

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    var_9 = (var_8 || randomint(100) < 50) && !maps\mp\_utility::_id_56D7();
    var_10 = undefined;

    foreach(var_5 in var_3) {
      var_12 = 0;

      if((!isDefined(var_5._id_0117) || var_5._id_0117 != self) && !isDefined(var_5.boxtype)) {
        var_13 = [];

        foreach(var_15 in level.players) {
          if(!isDefined(var_15.team)) {
            continue;
          }
          if(!_isai(var_15) && level.teambased && var_15.team == self.team) {
            if(distancesquared(var_15.origin, var_5.origin) < 490000) {
              var_13[var_13.size] = var_15;
            }
          }
        }

        if(var_13.size > 0) {
          var_17 = var_13[0] getnearestnode();

          if(isDefined(var_17)) {
            var_12 = 0;

            foreach(var_19 in var_5.nearest_nodes) {
              var_12 = var_12 | _nodesvisible(var_17, var_19, 1);
            }
          }
        }
      }

      if(!var_12) {
        var_21 = isDefined(var_5.bots) && isDefined(var_5.bots[self.team]) && var_5.bots[self.team] > 0;
        var_22 = 0;

        foreach(var_19 in var_5.nearest_nodes) {
          var_22 = var_22 | _nodesvisible(var_7, var_19, 1);
        }

        if(var_22 || var_9 && !var_21) {
          var_10 = var_5;
          break;
        }
      }
    }

    if(isDefined(var_10)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(var_10.boxtype)) {
          if(!isDefined(var_10.bots)) {
            var_10.bots = [];
          }

          var_10.bots[self.team] = 1;
        }
      }

      var_26 = spawnStruct();
      var_26.object = var_10;
      var_26.start_thread = ::watch_bot_died_during_crate;
      var_26.should_abort = ::crate_picked_up;
      var_27 = undefined;

      if(isDefined(var_10.boxtype)) {
        if(isDefined(var_10.boxtouchonly) && var_10.boxtouchonly) {
          var_26.script_goal_radius = 16;
          var_26._id_087F = undefined;
          var_27 = var_10.origin;
        } else {
          var_26.script_goal_radius = 50;
          var_26._id_087F = ::use_box;
          var_28 = crate_get_bot_target(var_10) - var_10.origin;
          var_29 = length(var_28) * _randomfloat(1.0);
          var_27 = var_10.origin + vectorNormalize(var_28) * var_29 + (0, 0, 12);
        }
      } else {
        var_26._id_087F = ::use_crate;
        var_26.end_thread = ::stop_using_crate;
        var_27 = crate_get_bot_target(var_10);
        var_26.script_goal_radius = var_0 - distance(var_10.origin, var_27 + (0, 0, 40));
        var_27 = var_27 + (0, 0, 24);
      }

      if(isDefined(var_26.script_goal_radius)) {}

      var_10 notify("path_disconnect");
      waitframe();

      if(!isDefined(var_10)) {
        continue;
      }
      maps\mp\bots\_bots_strategy::bot_new_tactical_goal("airdrop_crate", var_27, 30, var_26);
    }
  }
}

_id_1AE6(var_0) {
  return 1;
}

_id_2741() {
  return 1;
}

_id_273D() {
  return 0;
}

bot_should_use_ammo_crate(var_0) {
  if(self getcurrentweapon() == level.boxsettings[var_0.boxtype].minigunweapon) {
    return 0;
  }

  return 1;
}

_id_1AA1(var_0) {
  self switchtoweapon(self.botclearscriptenemy);
  wait 1.0;
}

bot_post_use_ammo_crate(var_0) {
  self switchtoweapon("none");
  self.botclearscriptenemy = self getcurrentweapon();
}

bot_should_use_scavenger_bag(var_0) {
  if(maps\mp\bots\_bots_util::bot_get_low_on_ammo(0.66)) {
    var_1 = self getnearestnode();

    if(isDefined(var_0.nearest_nodes) && isDefined(var_0.nearest_nodes[0]) && isDefined(var_1)) {
      if(_nodesvisible(var_1, var_0.nearest_nodes[0], 1)) {
        if(common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
          return 1;
        }
      }
    }
  }

  return 0;
}

bot_should_use_grenade_crate(var_0) {
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1) {
    if(self getweaponammostock(var_3) == 0) {
      return 1;
    }
  }

  return 0;
}

_id_1AE8(var_0) {
  return 1;
}

crate_monitor_position() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = self.origin;
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(self.origin, var_0)) {
      self.on_path_grid = undefined;
      self.nearest_nodes = undefined;
      self.nearest_points = undefined;
    }
  }
}

_id_2743() {}

crate_picked_up(var_0) {
  if(!isDefined(var_0.object)) {
    return 1;
  }

  return 0;
}

use_crate(var_0) {
  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0.object enableplayeruse(self);
    waitframe();
  }

  self[[level.bot_funcs["crate_wait_use"]]]();

  if(isDefined(var_0.object._id_0117) && var_0.object._id_0117 == self) {
    var_1 = level.crateownerusetime / 1000 + 0.5;
  } else {
    var_1 = level.cratenonownerusetime / 1000 + 1.0;
  }

  self botpressbutton("use", var_1);

  while(var_1 > 0 && isDefined(var_0.object)) {
    waitframe();
    var_1 = var_1 - 0.05;
  }

  if(var_1 > 0) {
    wait(_randomfloatrange(0.05, 0.5));
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0.object)) {
      var_0.object disableplayeruse(self);
    }
  }

  if(isDefined(var_0.object)) {
    if(!isDefined(var_0.object.bots_used)) {
      var_0.object.bots_used = [];
    }

    var_0.object.bots_used[var_0.object.bots_used.size] = self;
  }
}

use_box(var_0) {
  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0.object enableplayeruse(self);
    waitframe();
  }

  if(isDefined(var_0.object) && isDefined(var_0.object.boxtype)) {
    var_1 = var_0.object.boxtype;

    if(isDefined(level.bot_pre_use_box_of_type[var_1])) {
      self[[level.bot_pre_use_box_of_type[var_1]]](var_0.object);
    }

    if(isDefined(var_0.object)) {
      var_2 = level.boxsettings[var_0.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("use", var_2);
      wait(var_2);

      if(isDefined(level.bot_post_use_box_of_type[var_1])) {
        self[[level.bot_post_use_box_of_type[var_1]]](var_0.object);
      }
    }
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0.object)) {
      var_0.object disableplayeruse(self);
    }
  }
}

watch_bot_died_during_crate(var_0) {
  thread bot_watch_for_death(var_0.object);
}

stop_using_crate(var_0) {
  if(isDefined(var_0.was_goliath_pod_goal) && var_0.was_goliath_pod_goal) {
    self botsetstance("none");
    self botlookatpoint(undefined);
  }

  if(isDefined(var_0.object)) {
    var_0.object.bots[self.team] = 0;
  }
}

bot_watch_for_death(var_0) {
  var_0 endon("death");
  var_0 endon("revived");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = self.team;
  common_scripts\utility::waittill_any("death", "disconnect");

  if(isDefined(var_0)) {
    var_0.bots[var_1] = 0;
  }
}

_id_1AFF() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("2098");

  for(;;) {
    wait 3;

    if(self useButtonPressed()) {
      continue;
    }
    if(maps\mp\_utility::isusingremote()) {
      continue;
    }
    var_1 = level._id_1FFD;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      var_4 = self playergetuseent();

      if(!isDefined(var_4) || var_4 != var_3) {
        continue;
      }
      if(distancesquared(self.origin, var_3.origin) < var_0 * var_0) {
        if(!_id_1A13(var_3)) {
          if(isDefined(var_3._id_0117) && var_3._id_0117 == self) {
            self botpressbutton("use", level.crateownerusetime / 1000 + 0.5);
            continue;
          }

          self botpressbutton("use", level.cratenonownerusetime / 1000 + 0.5);
        }
      }
    }
  }
}

bot_think_revive() {
  self notify("bot_think_revive");
  self endon("bot_think_revive");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  for(;;) {
    var_0 = 2.0;
    var_1 = getEntArray("revive_trigger", "targetname");

    if(var_1.size > 0) {
      var_0 = 0.05;
    }

    level common_scripts\utility::waittill_notify_or_timeout("player_last_stand", var_0);

    if(!bot_can_revive()) {
      continue;
    }
    var_1 = getEntArray("revive_trigger", "targetname");

    if(var_1.size > 1) {
      var_1 = _sortbydistance(var_1, self.origin);

      if(isDefined(self._id_0117)) {
        for(var_2 = 0; var_2 < var_1.size; var_2++) {
          if(var_1[var_2]._id_0117 != self._id_0117) {
            continue;
          }
          if(var_2 == 0) {
            break;
          }

          var_3 = var_1[var_2];
          var_1[var_2] = var_1[0];
          var_1[0] = var_3;
          break;
        }
      }
    }

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_4 = var_1[var_2];
      var_5 = var_4._id_0117;

      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5 == self) {
        continue;
      }
      if(!isalive(var_5)) {
        continue;
      }
      if(var_5.team != self.team) {
        continue;
      }
      if(!isDefined(var_5.inlaststand) || !var_5.inlaststand) {
        continue;
      }
      if(isDefined(var_5.bots) && isDefined(var_5.bots[self.team]) && var_5.bots[self.team] > 0) {
        continue;
      }
      if(distancesquared(self.origin, var_5.origin) < 4194304) {
        var_6 = spawnStruct();
        var_6.object = var_4;
        var_6.script_goal_radius = 64;

        if(isDefined(self.last_revive_fail_time) && gettime() - self.last_revive_fail_time < 1000) {
          var_6.script_goal_radius = 32;
        }

        var_6.start_thread = ::watch_bot_died_during_revive;
        var_6.end_thread = ::stop_reviving;
        var_6.should_abort = ::player_revived_or_dead;
        var_6._id_087F = ::revive_player;
        maps\mp\bots\_bots_strategy::bot_new_tactical_goal("revive", var_5.origin, 60, var_6);
        break;
      }
    }
  }
}

watch_bot_died_during_revive(var_0) {
  thread bot_watch_for_death(var_0.object._id_0117);
}

stop_reviving(var_0) {
  if(isDefined(var_0.object._id_0117)) {
    var_0.object._id_0117.bots[self.team] = 0;
  }
}

player_revived_or_dead(var_0) {
  if(!isDefined(var_0.object._id_0117) || var_0.object._id_0117.health <= 0) {
    return 1;
  }

  if(!isDefined(var_0.object._id_0117.inlaststand) || !var_0.object._id_0117.inlaststand) {
    return 1;
  }

  return 0;
}

revive_player(var_0) {
  if(distancesquared(self.origin, var_0.object._id_0117.origin) > 4096) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0.object enableplayeruse(self);
    waitframe();
  }

  var_1 = self.team;
  self botpressbutton("use", level.laststandusetime / 1000 + 0.5);
  wait(level.laststandusetime / 1000 + 1.5);

  if(isDefined(var_0.object._id_0117)) {
    var_0.object.bots[var_1] = 0;
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0.object)) {
      var_0.object disableplayeruse(self);
    }
  }
}

bot_can_revive() {
  if(isDefined(self._id_00E8) && self._id_00E8 == 1) {
    return 0;
  }

  if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("revive")) {
    return 0;
  }

  if(maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    return 0;
  }

  if(maps\mp\bots\_bots_util::bot_is_bodyguarding()) {
    return 1;
  }

  var_0 = self botgetscriptgoaltype();

  if(var_0 == "none" || var_0 == "hunt" || var_0 == "guard") {
    return 1;
  }

  return 0;
}

revive_watch_for_finished(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("bad_path");
  self endon("goal");
  var_0 common_scripts\utility::waittill_any("death", "revived");
  self notify("bad_path");
}

bot_know_enemies_on_start() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }
  while(!maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::gameflag("prematch_done")) {
    waitframe();
  }

  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3) && isDefined(self.team) && isDefined(var_3.team) && !_isalliedsentient(self, var_3)) {
      if(!isDefined(var_3.bot_start_known_by_enemy)) {
        var_0 = var_3;
      }

      if(_isai(var_3) && !isDefined(var_3.bot_start_know_enemy)) {
        var_1 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    self.bot_start_know_enemy = 1;
    var_0.bot_start_known_by_enemy = 1;
    self getenemyinfo(var_0);
  }

  if(isDefined(var_1)) {
    var_1.bot_start_know_enemy = 1;
    self.bot_start_known_by_enemy = 1;
    var_1 getenemyinfo(self);
  }
}

_id_1A70(var_0, var_1, var_2, var_3, var_4) {
  return self makeentitysentient(var_0, var_1, var_2, var_3, var_4);
}

bot_free_entity_sentient() {
  self freeentitysentient();
}

bot_think_gametype() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  self thread[[level.bot_funcs["gametype_think"]]]();
}

default_gametype_think() {}

monitor_smoke_grenades() {
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  level.bot_smoke_sight_clip_small = _getEnt("smoke_grenade_sight_clip_small", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_small)) {
    return;
  }
  level.bot_smoke_sight_clip_medium = _getEnt("smoke_grenade_sight_clip_medium", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_medium)) {
    return;
  }
  level.bot_smoke_sight_clip_large = _getEnt("smoke_grenade_sight_clip_large", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_large)) {
    return;
  }
  for(;;) {
    level waittill("smoke", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "smoke_grenade_mp" || var_2 == "smoke_grenade_axis_mp" || var_2 == "smoke_grenade_expeditionary_mp" || var_2 == "smoke_grenade_axis_expeditionary_mp") {
      var_0 thread handle_smoke();
    }
  }
}

handle_smoke() {
  self waittill("explode", var_0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 show();
  var_1 seticonsize(1);
  var_1.origin = var_0;
  var_2 = 0.3;
  wait(var_2);
  var_2 = 0.4;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_small);
  wait(var_2);
  var_2 = 0.45;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_medium);
  wait(var_2);
  var_2 = 9.8;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  wait(var_2);
  var_2 = 1.0;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_medium);
  wait(var_2);
  var_2 = 0.65;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_small);
  wait(var_2);
  var_1 delete();
}

bot_add_scavenger_bag(var_0) {
  var_1 = 0;
  var_0.boxtype = "scavenger_bag";
  var_0.boxtouchonly = 1;

  if(!isDefined(level.bot_scavenger_bags)) {
    level.bot_scavenger_bags = [];
  }

  foreach(var_4, var_3 in level.bot_scavenger_bags) {
    if(!isDefined(var_3)) {
      var_1 = 1;
      level.bot_scavenger_bags[var_4] = var_0;
      break;
    }
  }

  if(!var_1) {
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = var_0;
  }

  foreach(var_6 in level.participants) {
    if(_isai(var_6) && var_6 maps\mp\_utility::_hasperk("specialty_scavenger")) {
      var_6 notify("new_crate_to_take");
    }
  }
}

bot_triggers() {
  var_0 = getEntArray("bot_flag_set", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    var_2 thread bot_flag_trigger(var_2._id_0165);
  }
}

bot_flag_trigger(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(maps\mp\_utility::isaigameparticipant(var_1)) {
      var_1 notify("flag_trigger_set_" + var_0);
      var_1 botsetflag(var_0, 1);
      var_1 thread bot_flag_trigger_clear(var_0);
    }
  }
}

bot_flag_trigger_clear(var_0) {
  self endon("flag_trigger_set_" + var_0);
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend;
  self botsetflag(var_0, 0);
}