/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots.gsc
********************************/

main() {
  if(isdefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(getdvarint("virtualLobbyActive") == 1) {
    return;
  }
  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    return;
  }
  setup_callbacks();
  maps\mp\bots\_bots_personality::setup_personalities();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;

  if(isdefined(level.bot_killstreak_setup_func))
    [[level.bot_killstreak_setup_func]]();
  else
    maps\mp\bots\_bots_ks::bot_killstreak_setup();

  maps\mp\bots\_bots_loadout::init();
  level thread init();
}

setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = ::spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = maps\mp\bots\_bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["bots_remove_from_level_targets"] = maps\mp\bots\_bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["bots_make_entity_sentient"] = ::bot_make_entity_sentient;
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
  level.bot_random_path_function = [];
  level.bot_random_path_function["allies"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_random_path_function["axis"] = maps\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_find_defend_node_func["capture"] = maps\mp\bots\_bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["capture_zone"] = maps\mp\bots\_bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["protect"] = maps\mp\bots\_bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["bodyguard"] = maps\mp\bots\_bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["patrol"] = maps\mp\bots\_bots_strategy::find_defend_node_patrol;
  maps\mp\bots\_bots_gametype_war::setup_callbacks();
}

codecallback_leaderdialog(var_0, var_1) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["leader_dialog"]))
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_1);
}

init() {
  thread monitor_smoke_grenades();
  thread bot_triggers();
  initbotlevelvariables();

  if(!shouldspawnbots()) {
    return;
  }
  refresh_existing_bots();
  var_0 = botautoconnectenabled();

  if(var_0 == "enabled_fill_open" || var_0 == "enabled_fill_open_dev") {
    setmatchdata("hasBots", 1);
    level thread bot_connect_monitor();
  } else
    level thread bot_monitor_team_limits();
}

initbotlevelvariables() {
  if(!isdefined(level.crateownerusetime))
    level.crateownerusetime = 500;

  if(!isdefined(level.cratenonownerusetime))
    level.cratenonownerusetime = 3000;

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name["recruit"] = "rpg_mp";
  level.bot_respawn_launcher_name["regular"] = "rpg_mp";
  level.bot_respawn_launcher_name["hardened"] = "rpg_mp";
  level.bot_respawn_launcher_name["veteran"] = "rpg_mp";
  level.bot_fallback_weapon = "h1_ak47";
  level.zonecount = getzonecount();
  initbotmapextents();
  level thread maps\mp\bots\_bots_gametype_oldschool::bot_oldschool_init();
}

initbotmapextents() {
  if(isdefined(level.teleportgetactivenodesfunc))
    var_0 = [
      [level.teleportgetactivenodesfunc]
    ]();
  else
    var_0 = getallnodes();

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

    for (var_1 = 1; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1].origin;

      if(var_2[0] < level.bot_map_min_x)
        level.bot_map_min_x = var_2[0];

      if(var_2[0] > level.bot_map_max_x)
        level.bot_map_max_x = var_2[0];

      if(var_2[1] < level.bot_map_min_y)
        level.bot_map_min_y = var_2[1];

      if(var_2[1] > level.bot_map_max_y)
        level.bot_map_max_y = var_2[1];

      if(var_2[2] < level.bot_map_min_z)
        level.bot_map_min_z = var_2[2];

      if(var_2[2] > level.bot_map_max_z)
        level.bot_map_max_z = var_2[2];
    }
  }

  level.bot_map_center = ((level.bot_map_min_x + level.bot_map_max_x) / 2, (level.bot_map_min_y + level.bot_map_max_y) / 2, (level.bot_map_min_z + level.bot_map_max_z) / 2);
  level.bot_variables_initialized = 1;
}

bot_post_teleport() {
  level.bot_variables_initialized = undefined;
  initbotmapextents();
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
  if(!isdefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while (!isdefined(level.bot_loadouts_initialized))
        wait 0.05;

      if(isdefined(self.override_class_function))
        self.bot_class = [
          [self.override_class_function]
        ]();
      else
        self.bot_class = maps\mp\bots\_bots_personality::bot_setup_callback_class();
    } else
      self.bot_class = self.class;
  }
}

watch_players_connecting() {
  for (;;) {
    level waittill("connected", var_0);

    if(!isai(var_0) && level.players.size > 0) {
      level.players_waiting_to_join = common_scripts\utility::array_add(level.players_waiting_to_join, var_0);
      childthread bots_notify_on_spawn(var_0);
      childthread bots_notify_on_disconnect(var_0);
      childthread bots_remove_from_array_on_notify(var_0);
    }
  }
}

bots_notify_on_spawn(var_0) {
  var_0 endon("bots_human_disconnected");

  while (!common_scripts\utility::array_contains(level.players, var_0))
    wait 0.05;

  var_0 notify("bots_human_spawned");
}

bots_notify_on_disconnect(var_0) {
  var_0 endon("bots_human_spawned");
  var_0 waittill("disconnect");
  var_0 notify("bots_human_disconnected");
}

bots_remove_from_array_on_notify(var_0) {
  var_0 common_scripts\utility::waittill_any("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = common_scripts\utility::array_remove(level.players_waiting_to_join, var_0);
}

monitor_pause_spawning() {
  level.players_waiting_to_join = [];
  childthread watch_players_connecting();

  for (;;) {
    if(level.players_waiting_to_join.size > 0)
      level.pausing_bot_connect_monitor = 1;
    else
      level.pausing_bot_connect_monitor = 0;

    wait 0.5;
  }
}

bot_can_join_team(var_0) {
  if(maps\mp\_utility::matchmakinggame())
    return 1;

  if(!level.teambased)
    return 1;

  if(maps\mp\gametypes\_teams::getjointeampermissions(var_0))
    return 1;

  return 0;
}

bot_allowed_to_switch_teams() {
  if(isdefined(level.bots_disable_team_switching) && level.bots_disable_team_switching)
    return 0;

  if(isdefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
    return 0;

  return 1;
}

bot_connect_monitor(var_0, var_1) {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_2 = 1.5;

  if(!isdefined(level.bot_cm_spawned_bots))
    level.bot_cm_spawned_bots = 0;

  if(!isdefined(level.bot_cm_waited_players_time))
    level.bot_cm_waited_players_time = 0;

  if(!isdefined(level.bot_cm_human_picked))
    level.bot_cm_human_picked = 0;

  for (;;) {
    if(level.pausing_bot_connect_monitor) {
      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
      continue;
    }

    var_3 = isdefined(level.bots_ignore_team_balance) || !level.teambased;
    var_4 = botgetteamlimit(0);
    var_5 = botgetteamlimit(1);
    var_6 = botgetteamdifficulty(0);
    var_7 = botgetteamdifficulty(1);
    var_11 = "allies";

    if(isdefined(level.bot_last_team_ally))
      var_11 = level.bot_last_team_ally;

    var_12 = "axis";

    if(isdefined(level.bot_last_team_enemy))
      var_12 = level.bot_last_team_enemy;

    var_13 = bot_client_counts();
    var_14 = cat_array_get(var_13, "humans");

    if(var_14 > 1) {
      var_15 = bot_get_host_team();

      if(!maps\mp\_utility::matchmakinggame() && isdefined(var_15) && var_15 != "spectator") {
        var_11 = var_15;
        var_12 = maps\mp\_utility::getotherteam(var_15);
      } else {
        var_16 = cat_array_get(var_13, "humans_allies");
        var_17 = cat_array_get(var_13, "humans_axis");

        if(var_17 > var_16) {
          var_11 = "axis";
          var_12 = "allies";
        }
      }
    } else {
      var_18 = get_human_player();

      if(isdefined(var_18)) {
        var_19 = var_18 bot_get_player_team();

        if(isdefined(var_19) && var_19 != "spectator") {
          var_11 = var_19;
          var_12 = maps\mp\_utility::getotherteam(var_19);
        }
      }
    }

    level.bot_last_team_ally = var_11;
    level.bot_last_team_enemy = var_12;
    var_20 = maps\mp\bots\_bots_util::bot_get_team_limit();
    var_21 = maps\mp\bots\_bots_util::bot_get_team_limit();
    var_22 = maps\mp\bots\_bots_util::bot_get_client_limit();

    if(var_20 + var_21 < var_22) {
      if(var_20 < var_4)
        var_20++;
      else if(var_21 < var_5)
        var_21++;
    }

    var_23 = cat_array_get(var_13, "humans_" + var_11);
    var_24 = cat_array_get(var_13, "humans_" + var_12);
    var_25 = var_23 + var_24;
    var_26 = cat_array_get(var_13, "spectator");
    var_27 = 0;

    for (var_28 = 0; var_26 > 0; var_26--) {
      var_29 = var_23 + var_27 + 1 <= var_20;
      var_30 = var_24 + var_28 + 1 <= var_21;

      if(var_29 && !var_30) {
        var_27++;
        continue;
      }

      if(!var_29 && var_30) {
        var_28++;
        continue;
      }

      if(var_29 && var_30) {
        if(var_26 % 2 == 1) {
          var_27++;
          continue;
        }

        var_28++;
      }
    }

    var_31 = cat_array_get(var_13, "bots_" + var_11);
    var_32 = cat_array_get(var_13, "bots_" + var_12);
    var_33 = var_31 + var_32;

    if(var_33 > 0)
      level.bot_cm_spawned_bots = 1;

    var_34 = 0;

    if(!level.bot_cm_human_picked) {
      var_34 = !bot_get_human_picked_team();

      if(!var_34)
        level.bot_cm_human_picked = 1;
    }

    if(var_34) {
      var_35 = !isonlinegame();
      var_36 = !var_3 && var_5 != var_4 && !level.bot_cm_spawned_bots && (level.bot_cm_waited_players_time < 10 || !maps\mp\_utility::gameflag("prematch_done"));
      var_37 = 0;

      if(var_35 || var_36 || var_37) {
        level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_2;
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
        continue;
      }
    }

    var_38 = int(min(var_20 - var_23 - var_27, var_4));
    var_39 = int(min(var_21 - var_24 - var_28, var_5));
    var_40 = 1;
    var_41 = var_38 + var_39 + var_14;
    var_42 = var_4 + var_5 + var_14;

    for (var_43 = [-1, -1]; var_41 < var_22 && var_41 < var_42; var_40 = !var_40) {
      if(var_40 && var_38 < var_4 && bot_can_join_team(var_11))
        var_38++;
      else if(!var_40 && var_39 < var_5 && bot_can_join_team(var_12))
        var_39++;

      var_41 = var_38 + var_39 + var_14;

      if(var_43[var_40] == var_41) {
        break;
      }

      var_43[var_40] = var_41;
    }

    level.bot_max_players_on_team[var_11] = int(var_38 + var_23 + var_27);
    level.bot_max_players_on_team[var_12] = int(var_39 + var_24 + var_28);
    update_max_players_from_team_agents();

    if(var_4 == var_5 && !var_3 && var_27 == 1 && var_28 == 0 && var_39 > 0) {
      if(!isdefined(level.bot_prematchdonetime) && maps\mp\_utility::gameflag("prematch_done"))
        level.bot_prematchdonetime = gettime();

      if(var_34 && (!isdefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000))
        var_39--;
    }

    var_45 = var_38 - var_31;
    var_46 = var_39 - var_32;
    var_47 = 1;

    if(var_3) {
      var_48 = var_20 + var_21;
      var_49 = var_4 + var_5;
      var_50 = var_23 + var_24;
      var_51 = var_31 + var_32;
      var_52 = int(min(var_48 - var_50, var_49));
      var_53 = var_52 - var_51;

      if(var_53 == 0)
        var_47 = 0;
      else if(var_53 > 0) {
        var_45 = int(var_53 / 2) + var_53 % 2;
        var_46 = int(var_53 / 2);
      } else if(var_53 < 0) {
        var_54 = var_53 * -1;
        var_45 = -1 * int(min(var_54, var_31));
        var_46 = -1 * (var_54 + var_45);
      }
    } else if(!maps\mp\_utility::matchmakinggame() && (var_45 * var_46 < 0 && maps\mp\_utility::gameflag("prematch_done") && bot_allowed_to_switch_teams())) {
      var_55 = int(min(abs(var_45), abs(var_46)));

      if(var_45 > 0)
        move_bots_from_team_to_team(var_55, var_12, var_11, var_6);
      else if(var_46 > 0)
        move_bots_from_team_to_team(var_55, var_11, var_12, var_7);

      var_47 = 0;
    }

    if(var_47) {
      if(var_46 < 0)
        drop_bots(var_46 * -1, var_12);

      if(var_45 < 0)
        drop_bots(var_45 * -1, var_11);

      if(var_46 > 0)
        level thread spawn_bots(var_46, var_12, undefined, undefined, "spawned_enemies", var_7);

      if(var_45 > 0)
        level thread spawn_bots(var_45, var_11, undefined, undefined, "spawned_allies", var_6);

      if(var_46 > 0 && var_45 > 0)
        level common_scripts\utility::waittill_multiple("spawned_enemies", "spawned_allies");
      else if(var_46 > 0)
        level waittill("spawned_enemies");
      else if(var_45 > 0)
        level waittill("spawned_allies");
    }

    if(var_7 != var_6) {
      bots_update_difficulty(var_12, var_7);
      bots_update_difficulty(var_11, var_6);
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  }
}

bot_monitor_team_limits() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  for (;;) {
    level.bot_max_players_on_team["allies"] = 0;
    level.bot_max_players_on_team["axis"] = 0;

    foreach(var_2 in level.players) {
      if(isdefined(var_2.team) && (var_2.team == "allies" || var_2.team == "axis"))
        level.bot_max_players_on_team[var_2.team]++;
    }

    update_max_players_from_team_agents();
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

update_max_players_from_team_agents() {
  if(isdefined(level.agentarray)) {
    foreach(var_1 in level.agentarray) {
      if(isdefined(var_1.isactive) && var_1.isactive) {
        if(maps\mp\_utility::isteamparticipant(var_1) && isdefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis"))
          level.bot_max_players_on_team[var_1.team]++;
      }
    }
  }
}

bot_get_player_team() {
  if(isdefined(self.team))
    return self.team;

  if(isdefined(self.pers["team"]))
    return self.pers["team"];

  return undefined;
}

bot_get_host_team() {
  foreach(var_1 in level.players) {
    if(!isai(var_1) && var_1 ishost())
      return var_1 bot_get_player_team();
  }

  return "spectator";
}

bot_get_human_picked_team() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      if(var_4 ishost())
        var_0 = 1;

      if(player_picked_team(var_4)) {
        var_1 = 1;

        if(var_4 ishost())
          var_2 = 1;
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

player_picked_team(var_0) {
  if(isdefined(var_0.team) && var_0.team != "spectator")
    return 1;

  if(isdefined(var_0.spectating_actively) && var_0.spectating_actively)
    return 1;

  if(var_0 ismlgspectator())
    return 1;

  return 0;
}

bot_client_counts() {
  var_0 = [];

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(isdefined(var_2) && isdefined(var_2.team)) {
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
  if(!isdefined(var_0))
    var_0 = [];

  if(!isdefined(var_0[var_1]))
    var_0[var_1] = 0;

  var_0[var_1] = var_0[var_1] + 1;
  return var_0;
}

cat_array_get(var_0, var_1) {
  if(!isdefined(var_0))
    return 0;

  if(!isdefined(var_0[var_1]))
    return 0;

  return var_0[var_1];
}

move_bots_from_team_to_team(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isdefined(var_5.team)) {
      continue;
    }
    if(isdefined(var_5.connected) && var_5.connected && isbot(var_5) && var_5.team == var_1) {
      var_5.bot_team = var_2;

      if(isdefined(var_3))
        var_5 maps\mp\bots\_bots_util::bot_set_difficulty(var_3);

      var_5 notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_2));
      wait 0.05;
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
    if(!isdefined(var_3.team)) {
      continue;
    }
    if(isdefined(var_3.connected) && var_3.connected && isbot(var_3) && var_3.team == var_0) {
      if(var_1 != var_3 botgetdifficulty())
        var_3 maps\mp\bots\_bots_util::bot_set_difficulty(var_1);
    }
  }
}

bot_drop() {
  kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

drop_bots(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isdefined(var_4.connected) && var_4.connected && isbot(var_4) && (!isdefined(var_1) || isdefined(var_4.team) && var_4.team == var_1))
      var_2[var_2.size] = var_4;
  }

  for (var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!maps\mp\_utility::isreallyalive(var_2[var_6])) {
      var_2[var_6] bot_drop();
      var_2 = common_scripts\utility::array_remove(var_2, var_2[var_6]);
      var_0--;
    }
  }

  for (var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    var_2[var_6] bot_drop();
    var_0--;
  }
}

bot_lui_convert_team_to_int(var_0) {
  if(var_0 == "axis")
    return 0;
  else if(var_0 == "allies")
    return 1;
  else if(var_0 == "autoassign" || var_0 == "random")
    return 2;
  else
    return 3;
}

spawn_bot_latent(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while (!self canspawntestclient()) {
    if(gettime() >= var_3) {
      kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
      var_2.abort = 1;
      return;
    }

    wait 0.05;

    if(!isdefined(self)) {
      var_2.abort = 1;
      return;
    }
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(randomfloatrange(0.25, 2.0));

  if(!isdefined(self)) {
    var_2.abort = 1;
    return;
  }

  self spawntestclient();
  self.equipment_enabled = 1;
  self.bot_team = var_0;

  if(isdefined(var_2.difficulty))
    maps\mp\bots\_bots_util::bot_set_difficulty(var_2.difficulty);

  if(isdefined(var_1))
    self[[var_1]]();

  self thread[[level.bot_funcs["think"]]]();
  var_2.ready = 1;
}

spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 10000;
  var_7 = [];
  var_8 = var_7.size;

  while (level.players.size < maps\mp\bots\_bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = addbot("");

    if(!isdefined(var_9)) {
      if(isdefined(var_3) && var_3) {
        if(isdefined(var_4))
          self notify(var_4);

        return;
      }

      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_10 = spawnstruct();
      var_10.bot = var_9;
      var_10.ready = 0;
      var_10.abort = 0;
      var_10.index = var_8;
      var_10.difficulty = var_5;
      var_7[var_7.size] = var_10;
      var_10.bot thread spawn_bot_latent(var_1, var_2, var_10);
      var_8++;
    }
  }

  var_11 = 0;
  var_6 = gettime() + 60000;

  while (var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10.ready || var_10.abort)
        var_11++;
    }

    wait 0.05;
  }

  if(isdefined(var_4))
    self notify(var_4);
}

bot_gametype_chooses_team() {
  if(maps\mp\_utility::matchmakinggame() && self.sessionteam != "none")
    var_0 = 0;
  else if(!maps\mp\_utility::matchmakinggame() && !maps\mp\_utility::forceautoassign() && maps\mp\_utility::allowteamchoice())
    var_0 = 1;
  else
    var_0 = 0;

  return !var_0;
}

bot_gametype_chooses_class() {
  return isdefined(level.bots_gametype_handles_class_choice) && level.bots_gametype_handles_class_choice;
}

bot_think() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while (!isdefined(self.pers["team"]))
    wait 0.05;

  level.hasbots = 1;

  if(bot_gametype_chooses_team())
    self.bot_team = self.pers["team"];

  var_0 = self.bot_team;

  if(!isdefined(var_0))
    var_0 = self.pers["team"];

  self.entity_number = self getentitynumber();
  var_1 = 0;

  if(!isdefined(self.bot_spawned_before)) {
    var_1 = 1;
    self.bot_spawned_before = 1;

    if(!bot_gametype_chooses_team()) {
      var_2 = self.pers["team"] != "spectator" && !isdefined(self.bot_team);

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

  for (;;) {
    maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
    self.difficulty = self botgetdifficulty();
    var_3 = self botgetdifficultysetting("advancedPersonality");

    if(var_1 && isdefined(var_3) && var_3 != 0)
      maps\mp\bots\_bots_personality::bot_balance_personality();

    maps\mp\bots\_bots_personality::bot_assign_personality_functions();

    if(var_1) {
      bot_set_loadout_class();

      if(!bot_gametype_chooses_class()) {
        if(maps\mp\_utility::ishodgepodgeph() && var_0 == game["attackers"] && game["roundsPlayed"] > 0)
          wait 0.5;

        self notify("luinotifyserver", "class_select", self.bot_class);
      }

      if(self.health == 0)
        self waittill("spawned_player");

      if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["know_enemies_on_start"]))
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();

      var_1 = 0;
    }

    maps\mp\bots\_bots_loadout::bot_modify_behavior_from_loadout();
    bot_modify_behavior_from_tweakables();
    bot_restart_think_threads();
    wait 0.1;
    self waittill("death");
    respawn_watcher();
    self waittill("spawned_player");
  }
}

bot_set_rank_options() {
  if(!isdefined(self.pers["shouldApplyEmblemToWeapon"]))
    self.pers["shouldApplyEmblemToWeapon"] = self.pers["rank"] >= 29 && common_scripts\utility::cointoss();

  if(!isdefined(self.pers["shouldApplyEmblemToCharacter"]))
    self.pers["shouldApplyEmblemToCharacter"] = self.pers["rank"] >= 19 && common_scripts\utility::cointoss();
}

bot_modify_behavior_from_tweakables() {
  if(maps\mp\gametypes\_tweakables::gettweakablevalue("game", "onlyheadshots"))
    self botsetflag("only_headshots", 1);
}

respawn_watcher() {
  self endon("started_spawnPlayer");

  while (!self.waitingtospawn)
    wait 0.05;

  if(maps\mp\gametypes\_playerlogic::needsbuttontorespawn()) {
    while (self.waitingtospawn) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0)
          self botpressbutton("use", 0.5);
      }

      wait 1.0;
    }
  }
}

bot_israndom() {
  return self botisrandomized();
}

bot_get_rank_xp_and_prestige() {
  var_0 = spawnstruct();

  if(!bot_israndom()) {
    if(!isdefined(self.pers["rankxp"]))
      self.pers["rankxp"] = 0;

    if(!isdefined(self.pers["prestige"]))
      self.pers["prestige"] = 0;

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

  if(isdefined(var_4))
    var_0.rankxp = var_4;
  else {
    if(!isdefined(var_6))
      var_6 = bot_random_ranks_for_difficulty(var_1);

    var_7 = var_6["rank"];
    var_8 = maps\mp\gametypes\_rank::getrankinfominxp(var_7);
    var_9 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_7);
    var_10 = randomintrange(var_8, var_9);
    self.pers[var_2] = var_10;
    var_0.rankxp = var_10;
  }

  if(isdefined(var_5))
    var_0.prestige = var_5;
  else {
    if(!isdefined(var_6))
      var_6 = bot_random_ranks_for_difficulty(var_1);

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

  for (;;) {
    if(isalive(self) && !self botcanseeentity(var_0) && common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot()))
      self botgetimperfectenemyinfo(var_0, var_0.origin);

    wait 0.1;
  }
}

bot_random_ranks_for_difficulty(var_0) {
  var_1 = [];
  var_1["rank"] = 0;
  var_1["prestige"] = 0;

  if(var_0 == "default")
    return var_1;

  if(!isdefined(level.bot_rnd_rank)) {
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

  if(!isdefined(level.bot_rnd_prestige)) {
    level.bot_rnd_prestige = [];
    level.bot_rnd_prestige["recruit"][0] = 0;
    level.bot_rnd_prestige["recruit"][1] = 0;
    level.bot_rnd_prestige["regular"][0] = 0;
    level.bot_rnd_prestige["regular"][1] = 0;
    level.bot_rnd_prestige["hardened"][0] = 0;
    level.bot_rnd_prestige["hardened"][1] = 0;
    level.bot_rnd_prestige["veteran"][0] = 0;
    level.bot_rnd_prestige["veteran"][1] = level.maxprestige;
  }

  var_1["rank"] = randomintrange(level.bot_rnd_rank[var_0][0], level.bot_rnd_rank[var_0][1] + 1);
  var_1["prestige"] = randomintrange(level.bot_rnd_prestige[var_0][0], level.bot_rnd_prestige[var_0][1] + 1);
  return var_1;
}

crate_can_use_always(var_0) {
  if(isagent(self) && !isdefined(var_0.boxtype))
    return 0;

  return 1;
}

get_human_player() {
  var_0 = undefined;
  var_1 = getentarray("player", "classname");

  if(isdefined(var_1)) {
    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isdefined(var_1[var_2]) && isdefined(var_1[var_2].connected) && var_1[var_2].connected && !isai(var_1[var_2]) && (!isdefined(var_0) || var_0.team == "spectator"))
        var_0 = var_1[var_2];
    }
  }

  return var_0;
}

bot_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(self) || !isalive(self)) {
    return;
  }
  if(var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE") {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isdefined(var_4)) {
    if(!isdefined(var_0)) {
      return;
    }
    var_4 = var_0;
  }

  if(isdefined(var_4)) {
    if(level.teambased) {
      if(isdefined(var_4.team) && var_4.team == self.team)
        return;
      else if(isdefined(var_0) && isdefined(var_0.team) && var_0.team == self.team)
        return;
    }

    var_6 = maps\mp\bots\_bots_util::bot_get_known_attacker(var_0, var_4);

    if(isdefined(var_6))
      self botsetattacker(var_6);
  }
}

on_bot_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var_10 = maps\mp\bots\_bots_util::bot_get_known_attacker(var_1, var_0);

  if(isdefined(var_10) && var_10.classname == "misc_turret" && isdefined(var_10.chopper))
    var_10 = var_10.chopper;

  if(isdefined(var_10) && (var_10.classname == "script_vehicle" || var_10.classname == "script_model") && isdefined(var_10.helitype)) {
    var_11 = self botgetdifficultysetting("launcherRespawnChance");

    if(randomfloat(1.0) < var_11)
      self.respawn_with_launcher = 1;
  }
}

bot_should_do_killcam() {
  var_5 = 0.0;
  var_6 = self botgetdifficulty();

  if(var_6 == "recruit")
    var_5 = 0.1;
  else if(var_6 == "regular")
    var_5 = 0.4;
  else if(var_6 == "hardened")
    var_5 = 0.7;
  else if(var_6 == "veteran")
    var_5 = 1.0;

  return randomfloat(1.0) < 1.0 - var_5;
}

bot_should_pickup_weapons() {
  if(maps\mp\_utility::isjuggernaut())
    return 0;

  return 1;
}

bot_restart_think_threads() {
  thread bot_think_watch_enemy();
  thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();
  thread maps\mp\bots\_bots_gametype_oldschool::bot_think_oldschool();
  thread maps\mp\bots\_bots_ks::bot_think_killstreak();
  thread maps\mp\bots\_bots_ks::bot_think_watch_aerial_killstreak();
  thread bot_think_gametype();
}

bot_think_watch_enemy(var_0) {
  var_1 = "spawned_player";

  if(isdefined(var_0) && var_0)
    var_1 = "death";

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var_1);
  self endon("disconnect");
  level endon("game_ended");
  self.last_enemy_sight_time = 0;

  for (;;) {
    if(isdefined(self.enemy)) {
      if(self botcanseeentity(self.enemy))
        self.last_enemy_sight_time = gettime();
    }

    wait 0.05;
  }
}

bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    var_0 = 0;

    if(maps\mp\bots\_bots_util::bot_out_of_ammo()) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
        var_1 = getentarray("dropped_weapon", "targetname");
        var_2 = common_scripts\utility::get_array_of_closest(self.origin, var_1);

        if(var_2.size > 0) {
          var_3 = var_2[0];
          bot_seek_dropped_weapon(var_3);
        }
      }
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

bot_seek_dropped_weapon(var_0) {
  if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var_0) == 0) {
    var_1 = undefined;

    if(var_0.targetname == "dropped_weapon") {
      var_2 = 1;
      var_3 = self getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == getweaponmodel(var_5))
          var_2 = 0;
      }

      if(var_2)
        var_1 = ::bot_pickup_weapon;
    }

    var_7 = spawnstruct();
    var_7.object = var_0;
    var_7.script_goal_radius = 12;
    var_7.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var_7.action_thread = var_1;
    maps\mp\bots\_bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var_0.origin, 100, var_7);
  }
}

bot_pickup_weapon(var_0) {
  self botpressbutton("use", 2);
  wait 2;
}

should_stop_seeking_weapon(var_0) {
  if(!isdefined(var_0.object))
    return 1;

  if(var_0.object.targetname == "dropped_weapon") {
    if(maps\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0)
      return 1;
  } else if(var_0.object.targetname == "dropped_knife") {
    if(maps\mp\bots\_bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

bot_know_enemies_on_start() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }
  while (!maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::gameflag("prematch_done"))
    wait 0.05;

  var_0 = undefined;
  var_1 = undefined;

  for (var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isdefined(var_3) && isdefined(self.team) && isdefined(var_3.team) && !isalliedsentient(self, var_3)) {
      if(!isdefined(var_3.bot_start_known_by_enemy))
        var_0 = var_3;

      if(isai(var_3) && !isdefined(var_3.bot_start_know_enemy))
        var_1 = var_3;
    }
  }

  if(isdefined(var_0)) {
    self.bot_start_know_enemy = 1;
    var_0.bot_start_known_by_enemy = 1;
    self getenemyinfo(var_0);
  }

  if(isdefined(var_1)) {
    var_1.bot_start_know_enemy = 1;
    self.bot_start_known_by_enemy = 1;
    var_1 getenemyinfo(self);
  }
}

bot_make_entity_sentient(var_0, var_1) {
  if(isdefined(var_1))
    return self makeentitysentient(var_0, var_1);
  else
    return self makeentitysentient(var_0);
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
  level.bot_smoke_sight_clip_small = getent("smoke_grenade_sight_clip_small", "targetname");

  if(!isdefined(level.bot_smoke_sight_clip_small)) {
    return;
  }
  level.bot_smoke_sight_clip_medium = getent("smoke_grenade_sight_clip_medium", "targetname");

  if(!isdefined(level.bot_smoke_sight_clip_medium)) {
    return;
  }
  level.bot_smoke_sight_clip_large = getent("smoke_grenade_sight_clip_large", "targetname");

  if(!isdefined(level.bot_smoke_sight_clip_large)) {
    return;
  }
  for (;;) {
    level waittill("smoke", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "h1_smokegrenade_mp")
      var_0 thread handle_smoke();
  }
}

handle_smoke() {
  self waittill("explode", var_0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 show();
  var_1.origin = var_0;
  var_2 = 0.3;
  wait(var_2);
  var_2 = 0.65;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_small);
  wait(var_2);
  var_2 = 1.5;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_medium);
  wait(var_2);
  var_2 = 7.95;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  wait(var_2);
  var_1 delete();
}

bot_add_scavenger_bag(var_0) {
  var_1 = 0;
  var_0.boxtype = "scavenger_bag";
  var_0.boxtouchonly = 1;

  if(!isdefined(level.bot_scavenger_bags))
    level.bot_scavenger_bags = [];

  foreach(var_4, var_3 in level.bot_scavenger_bags) {
    if(!isdefined(var_3)) {
      var_1 = 1;
      level.bot_scavenger_bags[var_4] = var_0;
      break;
    }
  }

  if(!var_1)
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = var_0;

  foreach(var_6 in level.participants) {
    if(isai(var_6) && var_6 maps\mp\_utility::_hasperk("specialty_scavenger"))
      var_6 notify("new_crate_to_take");
  }
}

bot_triggers() {
  var_0 = getentarray("bot_flag_set", "targetname");

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      continue;
    }
    var_2 thread bot_flag_trigger(var_2.script_noteworthy);
  }
}

bot_flag_trigger(var_0) {
  self endon("death");

  for (;;) {
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