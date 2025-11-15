/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\_bots.gsc
*************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  setup_callbacks();
  scripts\mp\bots\_bots_personality::setup_personalities();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  scripts\mp\bots\_bots_killstreaks::bot_killstreak_setup();
  scripts\mp\bots\_bots_powers::func_2E53();
  scripts\mp\bots\_bots_loadout::init();
  level thread init();
}

setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = ::spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = ::scripts\mp\bots\_bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["bots_remove_from_level_targets"] = ::scripts\mp\bots\_bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["bots_make_entity_sentient"] = ::bot_make_entity_sentient;
  level.bot_funcs["think"] = ::bot_think;
  level.bot_funcs["on_killed"] = ::on_bot_killed;
  level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
  level.bot_funcs["get_attacker_ent"] = ::scripts\mp\bots\_bots_util::bot_get_known_attacker;
  level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
  level.bot_funcs["on_damaged"] = ::bot_damage_callback;
  level.bot_funcs["gametype_think"] = ::default_gametype_think;
  level.bot_funcs["leader_dialog"] = ::scripts\mp\bots\_bots_util::bot_leader_dialog;
  level.bot_funcs["player_spawned"] = ::bot_player_spawned;
  level.bot_funcs["should_start_cautious_approach"] = ::scripts\mp\bots\_bots_strategy::should_start_cautious_approach_default;
  level.bot_funcs["know_enemies_on_start"] = ::bot_know_enemies_on_start;
  level.bot_funcs["bot_get_rank_xp"] = ::bot_get_rank_xp;
  level.bot_funcs["ai_3d_sighting_model"] = ::bot_3d_sighting_model;
  level.bot_funcs["dropped_weapon_think"] = ::bot_think_seek_dropped_weapons;
  level.bot_funcs["dropped_weapon_cancel"] = ::should_stop_seeking_weapon;
  level.bot_funcs["crate_can_use"] = ::crate_can_use_always;
  level.bot_funcs["crate_low_ammo_check"] = ::crate_low_ammo_check;
  level.bot_funcs["crate_should_claim"] = ::crate_should_claim;
  level.bot_funcs["crate_wait_use"] = ::crate_wait_use;
  level.bot_funcs["crate_in_range"] = ::crate_in_range;
  level.bot_funcs["post_teleport"] = ::bot_post_teleport;
  level.bot_random_path_function = [];
  level.bot_random_path_function["allies"] = ::scripts\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_random_path_function["axis"] = ::scripts\mp\bots\_bots_personality::bot_random_path_default;
  level.bot_can_use_box_by_type["deployable_vest"] = ::bot_should_use_ballistic_vest_crate;
  level.bot_can_use_box_by_type["deployable_ammo"] = ::bot_should_use_ammo_crate;
  level.bot_can_use_box_by_type["scavenger_bag"] = ::bot_should_use_scavenger_bag;
  level.bot_can_use_box_by_type["deployable_grenades"] = ::bot_should_use_grenade_crate;
  level.bot_can_use_box_by_type["deployable_juicebox"] = ::bot_should_use_juicebox_crate;
  level.bot_pre_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
  level.bot_post_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
  level.bot_find_defend_node_func["capture"] = ::scripts\mp\bots\_bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["capture_zone"] = ::scripts\mp\bots\_bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["protect"] = ::scripts\mp\bots\_bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["bodyguard"] = ::scripts\mp\bots\_bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["patrol"] = ::scripts\mp\bots\_bots_strategy::find_defend_node_patrol;
  scripts\mp\bots\gametype_war::setup_callbacks();
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    scripts\mp\bots\_bots_fireteam::bot_fireteam_setup_callbacks();
  }
}

codecallback_leaderdialog(param_00, param_01) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](param_00, param_01);
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
  var_00 = botautoconnectenabled();
  if(var_00 > 0) {
    setmatchdata("hasBots", 1);
    if(scripts\mp\utility::bot_is_fireteam_mode()) {
      level thread scripts\mp\bots\_bots_fireteam::bot_fireteam_init();
      level thread scripts\mp\bots\_bots_fireteam_commander::init();
      return;
    }

    level thread bot_connect_monitor();
  }
}

initbotlevelvariables() {
  if(!isDefined(level.crateownerusetime)) {
    level.crateownerusetime = 500;
  }

  if(!isDefined(level.cratenonownerusetime)) {
    level.cratenonownerusetime = 3000;
  }

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name = "iw6_panzerfaust3";
  level.bot_fallback_weapon = "iw7_knife";
  level.zonecount = getzonecount();
  level.atk_bomber = undefined;
  initbotmapextents();
}

initbotmapextents() {
  if(isDefined(level.teleportgetactivenodesfunc)) {
    var_00 = [[level.teleportgetactivenodesfunc]]();
  } else {
    var_00 = getallnodes();
  }

  level.bot_map_min_x = 0;
  level.bot_map_max_x = 0;
  level.bot_map_min_y = 0;
  level.bot_map_max_y = 0;
  level.bot_map_min_z = 0;
  level.bot_map_max_z = 0;
  if(var_00.size > 1) {
    level.bot_map_min_x = var_00[0].origin[0];
    level.bot_map_max_x = var_00[0].origin[0];
    level.bot_map_min_y = var_00[0].origin[1];
    level.bot_map_max_y = var_00[0].origin[1];
    level.bot_map_min_z = var_00[0].origin[2];
    level.bot_map_max_z = var_00[0].origin[2];
    for(var_01 = 1; var_01 < var_00.size; var_01++) {
      var_02 = var_00[var_01].origin;
      if(var_02[0] < level.bot_map_min_x) {
        level.bot_map_min_x = var_02[0];
      }

      if(var_02[0] > level.bot_map_max_x) {
        level.bot_map_max_x = var_02[0];
      }

      if(var_02[1] < level.bot_map_min_y) {
        level.bot_map_min_y = var_02[1];
      }

      if(var_02[1] > level.bot_map_max_y) {
        level.bot_map_max_y = var_02[1];
      }

      if(var_02[2] < level.bot_map_min_z) {
        level.bot_map_min_z = var_02[2];
      }

      if(var_02[2] > level.bot_map_max_z) {
        level.bot_map_max_z = var_02[2];
      }
    }
  }

  level.bot_map_center = (level.bot_map_min_x + level.bot_map_max_x / 2, level.bot_map_min_y + level.bot_map_max_y / 2, level.bot_map_min_z + level.bot_map_max_z / 2);
  level.bot_variables_initialized = 1;
}

bot_post_teleport() {
  level.bot_variables_initialized = undefined;
  level.bot_initialized_remote_vehicles = undefined;
  initbotmapextents();
  scripts\mp\bots\_bots_killstreaks_remote_vehicle::remote_vehicle_setup();
}

shouldspawnbots() {
  return 1;
}

refresh_existing_bots() {
  wait(1);
  foreach(var_01 in level.players) {
    if(isbot(var_01)) {
      if(isalive(var_01)) {
        var_01.equipment_enabled = 1;
        var_01.bot_team = var_01.team;
        var_01.bot_spawned_before = 1;
        var_01 thread[[level.bot_funcs["think"]]]();
        continue;
      }
    }
  }
}

bot_player_spawned() {
  bot_set_loadout_class();
  if(isDefined(self.prev_personality)) {
    scripts\mp\bots\_bots_util::bot_set_personality(self.prev_personality);
    self.prev_personality = undefined;
  }
}

bot_set_loadout_class() {
  if(!isDefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while(!isDefined(level.bot_loadouts_initialized)) {
        wait(0.05);
      }

      if(isDefined(self.override_class_function)) {
        self.bot_class = [
          [self.override_class_function]
        ]();
        return;
      }

      self.bot_class = scripts\mp\bots\_bots_personality::bot_setup_callback_class();
      return;
    }

    self.bot_class = self.class;
  }
}

watch_players_connecting() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00) && level.players.size > 0) {
      level.players_waiting_to_join = scripts\engine\utility::array_add(level.players_waiting_to_join, var_00);
      childthread bots_notify_on_spawn(var_00);
      childthread bots_notify_on_disconnect(var_00);
      childthread bots_remove_from_array_on_notify(var_00);
    }
  }
}

bots_notify_on_spawn(param_00) {
  param_00 endon("bots_human_disconnected");
  while(!scripts\engine\utility::array_contains(level.players, param_00)) {
    wait(0.05);
  }

  param_00 notify("bots_human_spawned");
}

bots_notify_on_disconnect(param_00) {
  param_00 endon("bots_human_spawned");
  param_00 waittill("disconnect");
  param_00 notify("bots_human_disconnected");
}

bots_remove_from_array_on_notify(param_00) {
  param_00 scripts\engine\utility::waittill_any_3("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = scripts\engine\utility::array_remove(level.players_waiting_to_join, param_00);
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

    wait(0.5);
  }
}

bot_can_join_team(param_00) {
  if(scripts\mp\utility::matchmakinggame()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(scripts\mp\teams::getjointeampermissions(param_00)) {
    return 1;
  }

  return 0;
}

bot_connect_monitor(param_00, param_01) {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_02 = 1.5;
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
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
      continue;
    }

    var_03 = isDefined(level.bots_ignore_team_balance) || !level.teambased;
    var_04 = botgetteamlimit(0);
    var_05 = botgetteamlimit(1);
    if(level.rankedmatch) {
      var_06 = "default";
      var_07 = "default";
    } else {
      var_06 = botgetteamdifficulty(0);
      var_07 = botgetteamdifficulty(1);
    }

    var_08 = "allies";
    var_09 = "axis";
    var_0A = bot_client_counts();
    var_0B = cat_array_get(var_0A, "humans");
    if(var_0B > 1) {
      var_0C = bot_get_host_team();
      if(!scripts\mp\utility::matchmakinggame() && isDefined(var_0C) && var_0C != "spectator") {
        var_08 = var_0C;
        var_09 = scripts\mp\utility::getotherteam(var_0C);
      } else {
        var_0D = cat_array_get(var_0A, "humans_allies");
        var_0E = cat_array_get(var_0A, "humans_axis");
        if(var_0E > var_0D) {
          var_08 = "axis";
          var_09 = "allies";
        }
      }
    } else {
      var_0F = get_human_player();
      if(isDefined(var_0F)) {
        var_10 = var_0F bot_get_player_team();
        if(isDefined(var_10) && var_10 != "spectator") {
          var_08 = var_10;
          var_09 = scripts\mp\utility::getotherteam(var_10);
        }
      }
    }

    var_11 = scripts\mp\bots\_bots_util::bot_get_team_limit();
    var_12 = scripts\mp\bots\_bots_util::bot_get_team_limit();
    if(var_11 + var_12 < scripts\mp\bots\_bots_util::bot_get_client_limit()) {
      if(var_11 < var_04) {
        var_11++;
      } else if(var_12 < var_05) {
        var_12++;
      }
    }

    var_13 = cat_array_get(var_0A, "humans_" + var_08);
    var_14 = cat_array_get(var_0A, "humans_" + var_09);
    var_15 = var_13 + var_14;
    var_16 = cat_array_get(var_0A, "spectator");
    var_17 = 0;
    var_18 = 0;
    while(var_16 > 0) {
      var_19 = var_13 + var_17 + 1 <= var_11;
      var_1A = var_14 + var_18 + 1 <= var_12;
      if(var_19 && !var_1A) {
        var_17++;
        continue;
      }

      if(!var_19 && var_1A) {
        var_18++;
        continue;
      }

      if(var_19 && var_1A) {
        if(var_16 % 2 == 1) {
          var_17++;
          continue;
        }

        var_18++;
      }

      var_16--;
    }

    var_1B = cat_array_get(var_0A, "bots_" + var_08);
    var_1C = cat_array_get(var_0A, "bots_" + var_09);
    var_1D = var_1B + var_1C;
    if(var_1D > 0) {
      level.bot_cm_spawned_bots = 1;
    }

    var_1E = 0;
    if(!level.bot_cm_human_picked) {
      var_1E = !bot_get_human_picked_team();
      if(!var_1E) {
        level.bot_cm_human_picked = 1;
      }
    }

    if(var_1E) {
      var_1F = !getdvarint("systemlink") && !getdvarint("onlinegame");
      var_20 = !var_03 && var_05 != var_04 && !level.bot_cm_spawned_bots && level.bot_cm_waited_players_time < 10 || !scripts\mp\utility::gameflag("prematch_done");
      if(var_1F || var_20) {
        level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_02;
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
        continue;
      }
    }

    var_21 = int(min(var_11 - var_13 - var_17, var_04));
    var_22 = int(min(var_12 - var_14 - var_18, var_05));
    var_23 = 1;
    var_24 = var_21 + var_22 + var_0B;
    var_25 = var_04 + var_05 + var_0B;
    var_26 = [-1, -1];
    while(var_24 < scripts\mp\bots\_bots_util::bot_get_client_limit() && var_24 < var_25) {
      if(var_23 && var_21 < var_04 && bot_can_join_team(var_08)) {
        var_21++;
      } else if(!var_23 && var_22 < var_05 && bot_can_join_team(var_09)) {
        var_22++;
      }

      var_24 = var_21 + var_22 + var_0B;
      if(var_26[var_23] == var_24) {
        break;
      }

      var_26[var_23] = var_24;
      var_23 = !var_23;
    }

    if(var_04 == var_05 && !var_03 && var_17 == 1 && var_18 == 0 && var_22 > 0) {
      if(!isDefined(level.bot_prematchdonetime) && scripts\mp\utility::gameflag("prematch_done")) {
        level.bot_prematchdonetime = gettime();
      }

      if(var_1E && !isDefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000) {
        var_22--;
      }
    }

    var_27 = var_21 - var_1B;
    var_28 = var_22 - var_1C;
    var_29 = 1;
    if(var_03) {
      var_2A = var_11 + var_12;
      var_2B = var_04 + var_05;
      var_2C = var_13 + var_14;
      var_2D = var_1B + var_1C;
      var_2E = int(min(var_2A - var_2C, var_2B));
      var_2F = var_2E - var_2D;
      if(var_2F == 0) {
        var_29 = 0;
      } else if(var_2F > 0) {
        var_27 = int(var_2F / 2) + var_2F % 2;
        var_28 = int(var_2F / 2);
      } else if(var_2F < 0) {
        var_30 = var_2F * -1;
        var_27 = -1 * int(min(var_30, var_1B));
        var_28 = -1 * var_30 + var_27;
      }
    } else if(!scripts\mp\utility::matchmakinggame() && var_27 * var_28 < 0 && scripts\mp\utility::gameflag("prematch_done") && !isDefined(level.bots_disable_team_switching)) {
      var_31 = int(min(abs(var_27), abs(var_28)));
      if(var_27 > 0) {
        move_bots_from_team_to_team(var_31, var_09, var_08, var_06);
      } else if(var_28 > 0) {
        move_bots_from_team_to_team(var_31, var_08, var_09, var_07);
      }

      var_29 = 0;
    }

    if(var_29) {
      if(var_28 < 0) {
        drop_bots(var_28 * -1, var_09);
      }

      if(var_27 < 0) {
        drop_bots(var_27 * -1, var_08);
      }

      if(var_28 > 0) {
        level thread spawn_bots(var_28, var_09, undefined, undefined, "spawned_enemies", var_07);
      }

      if(var_27 > 0) {
        level thread spawn_bots(var_27, var_08, undefined, undefined, "spawned_allies", var_06);
      }

      if(var_28 > 0 && var_27 > 0) {
        level scripts\engine\utility::waittill_multiple("spawned_enemies", "spawned_allies");
      } else if(var_28 > 0) {
        level waittill("spawned_enemies");
      } else if(var_27 > 0) {
        level waittill("spawned_allies");
      }
    }

    if(var_07 != var_06) {
      bots_update_difficulty(var_09, var_07);
      bots_update_difficulty(var_08, var_06);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
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
  foreach(var_01 in level.players) {
    if(!isai(var_01) && var_01 ishost()) {
      return var_01 bot_get_player_team();
    }
  }

  return "spectator";
}

bot_get_human_picked_team() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in level.players) {
    if(!isai(var_04)) {
      if(var_04 ishost()) {
        var_00 = 1;
      }

      if(player_picked_team(var_04)) {
        var_01 = 1;
        if(var_04 ishost()) {
          var_02 = 1;
        }
      }
    }
  }

  return var_02 || var_01 && !var_00;
}

player_picked_team(param_00) {
  if(isDefined(param_00.team) && param_00.team != "spectator") {
    return 1;
  }

  if(isDefined(param_00.spectating_actively) && param_00.spectating_actively) {
    return 1;
  }

  if(param_00 ismlgspectator() && isDefined(param_00.team) && param_00.team == "spectator") {
    return 1;
  }

  return 0;
}

bot_client_counts() {
  var_00 = [];
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    var_02 = level.players[var_01];
    if(isDefined(var_02) && isDefined(var_02.team)) {
      var_00 = cat_array_add(var_00, "all");
      var_00 = cat_array_add(var_00, var_02.team);
      if(isbot(var_02)) {
        var_00 = cat_array_add(var_00, "bots");
        var_00 = cat_array_add(var_00, "bots_" + var_02.team);
        continue;
      }

      var_00 = cat_array_add(var_00, "humans");
      var_00 = cat_array_add(var_00, "humans_" + var_02.team);
    }
  }

  return var_00;
}

cat_array_add(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = [];
  }

  if(!isDefined(param_00[param_01])) {
    param_00[param_01] = 0;
  }

  param_00[param_01] = param_00[param_01] + 1;
  return param_00;
}

cat_array_get(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_00[param_01])) {
    return 0;
  }

  return param_00[param_01];
}

move_bots_from_team_to_team(param_00, param_01, param_02, param_03) {
  foreach(var_05 in level.players) {
    if(!isDefined(var_05.team)) {
      continue;
    }

    if(isDefined(var_05.connected) && var_05.connected && isbot(var_05) && var_05.team == param_01) {
      var_05.bot_team = param_02;
      if(isDefined(param_03)) {
        var_05 scripts\mp\bots\_bots_util::bot_set_difficulty(param_03);
      }

      var_05 notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(param_02));
      wait(0.05);
      var_05 notify("luinotifyserver", "class_select", var_05.bot_class);
      param_00--;
      if(param_00 <= 0) {
        break;
      } else {
        wait(0.1);
      }
    }
  }
}

bots_update_difficulty(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!isDefined(var_03.team)) {
      continue;
    }

    if(isDefined(var_03.connected) && var_03.connected && isbot(var_03) && var_03.team == param_00) {
      if(param_01 != var_03 botgetdifficulty()) {
        var_03 scripts\mp\bots\_bots_util::bot_set_difficulty(param_01);
      }
    }
  }
}

bot_drop() {
  kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
  wait(0.1);
}

drop_bots(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.players) {
    if(isDefined(var_04.connected) && var_04.connected && isbot(var_04) && !isDefined(param_01) || isDefined(var_04.team) && var_04.team == param_01) {
      var_02[var_02.size] = var_04;
    }
  }

  for(var_06 = var_02.size - 1; var_06 >= 0; var_06--) {
    if(param_00 <= 0) {
      break;
    }

    if(!scripts\mp\utility::isreallyalive(var_02[var_06])) {
      var_02[var_06] bot_drop();
      var_02 = scripts\engine\utility::array_remove(var_02, var_02[var_06]);
      param_00--;
    }
  }

  for(var_06 = var_02.size - 1; var_06 >= 0; var_06--) {
    if(param_00 <= 0) {
      break;
    }

    var_02[var_06] bot_drop();
    param_00--;
  }
}

bot_lui_convert_team_to_int(param_00) {
  if(param_00 == "axis") {
    return 0;
  }

  if(param_00 == "allies") {
    return 1;
  }

  if(param_00 == "autoassign" || param_00 == "random") {
    return 2;
  }

  return 3;
}

spawn_bot_latent(param_00, param_01, param_02) {
  var_03 = gettime() + -5536;
  while(!self canspawntestclient()) {
    if(gettime() >= var_03) {
      kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
      param_02.abort = 1;
      return;
    }

    wait(0.05);
    if(!isDefined(self)) {
      param_02.abort = 1;
      return;
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(randomfloatrange(0.25, 2));
  if(!isDefined(self)) {
    param_02.abort = 1;
    return;
  }

  self giveplayerbonuscash();
  self.pers["isBot"] = 1;
  self.equipment_enabled = 1;
  self.bot_team = param_00;
  if(isDefined(param_02.difficulty)) {
    scripts\mp\bots\_bots_util::bot_set_difficulty(param_02.difficulty);
  }

  if(isDefined(param_01)) {
    self[[param_01]]();
  }

  self thread[[level.bot_funcs["think"]]]();
  param_02.ready = 1;
}

find_squad_member_index(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  for(var_04 = 0; var_04 < 10; var_04++) {
    var_03 = 0;
    var_05 = param_00 getplayerdata("mp", "squadHQ", "aiSquadMembers", var_04);
    if(var_05 == var_02) {
      var_04++;
      continue;
    }

    if(!isDefined(level.human_team_bot_added) || !isDefined(level.human_team_bot_added[var_05]) || level.human_team_bot_added[var_05] == 0) {
      return var_05;
    }
  }

  return -1;
}

spawn_bots(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = gettime() + 10000;
  var_07 = [];
  var_08 = var_07.size;
  while(level.players.size < scripts\mp\bots\_bots_util::bot_get_client_limit() && var_07.size < param_00 && gettime() < var_06) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_09 = undefined;
    if(isbotmatchmakingenabled()) {
      if(level.teambased) {
        var_09 = addmpbottoteam(param_01);
      } else {
        var_09 = addmpbottoteam("none");
      }
    } else {
      var_09 = addbot("", 0, 0, 0);
    }

    if(!isDefined(var_09)) {
      if(isDefined(param_03) && param_03) {
        if(isDefined(param_04)) {
          self notify(param_04);
        }

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_0A = spawnStruct();
      var_0A.bot = var_09;
      var_0A.ready = 0;
      var_0A.abort = 0;
      var_0A.index = var_08;
      var_0A.difficulty = param_05;
      var_07[var_07.size] = var_0A;
      var_0A.bot thread spawn_bot_latent(param_01, param_02, var_0A);
      var_08++;
    }
  }

  var_0B = 0;
  var_06 = gettime() + -5536;
  while(var_0B < var_07.size && gettime() < var_06) {
    var_0B = 0;
    foreach(var_0A in var_07) {
      if(var_0A.ready || var_0A.abort) {
        var_0B++;
      }
    }

    wait(0.05);
  }

  if(isDefined(param_04)) {
    self notify(param_04);
  }
}

bot_gametype_chooses_team() {
  if(!level.teambased) {
    return 1;
  }

  if(isDefined(level.bots_gametype_handles_team_choice) && level.bots_gametype_handles_team_choice) {
    return 1;
  }

  return 0;
}

bot_gametype_chooses_class() {
  return isDefined(level.bots_gametype_handles_class_choice) && level.bots_gametype_handles_class_choice;
}

bot_is_ready_to_spawn() {
  if(!isDefined(self.classcallback)) {
    return 0;
  }

  return 1;
}

bot_think() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");
  while(!isDefined(self.pers["team"])) {
    wait(0.05);
  }

  level.hasbots = 1;
  if(bot_gametype_chooses_team()) {
    self.bot_team = self.pers["team"];
  }

  var_00 = self.bot_team;
  if(!isDefined(var_00)) {
    var_00 = self.pers["team"];
  }

  scripts\mp\bots\_bots_killstreaks::bot_killstreak_setup();
  self.entity_number = self getentitynumber();
  var_01 = 0;
  if(!isDefined(self.bot_spawned_before)) {
    var_01 = 1;
    self.bot_spawned_before = 1;
    if(!bot_gametype_chooses_team()) {
      self notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_00));
      wait(0.5);
      if(self.pers["team"] == "spectator") {
        bot_drop();
        return;
      }
    }
  }

  for(;;) {
    scripts\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
    var_02 = self botgetdifficultysetting("advancedPersonality");
    if(var_01 && isDefined(var_02) && var_02 != 0) {
      scripts\mp\bots\_bots_personality::bot_balance_personality();
    }

    scripts\mp\bots\_bots_personality::bot_assign_personality_functions();
    if(var_01) {
      bot_set_loadout_class();
      if(!bot_gametype_chooses_class()) {
        self notify("luinotifyserver", "class_select", self.bot_class);
      }

      if(self.health == 0) {
        self.bwaitingforteamselect = 1;
        self notify("bot_ready_to_spawn");
        self waittill("spawned_player");
        self.bwaitingforteamselect = undefined;
        self.bot_team = var_00;
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"])) {
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();
      }

      var_01 = 0;
    }

    bot_restart_think_threads();
    wait(0.1);
    self waittill("death");
    respawn_watcher();
    self waittill("spawned_player");
  }
}

respawn_watcher() {
  self endon("started_spawnPlayer");
  while(!self.waitingtospawn) {
    wait(0.05);
  }

  if(scripts\mp\playerlogic::needsbuttontorespawn()) {
    while(self.waitingtospawn) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0) {
          self botpressbutton("use", 0.5);
        }
      }

      wait(1);
    }
  }
}

bot_get_rank_xp() {
  if(scripts\mp\utility::bot_israndom() == 0) {
    if(!isDefined(self.pers["rankxp"])) {
      self.pers["rankxp"] = 0;
    }

    return self.pers["rankxp"];
  }

  var_00 = self botgetdifficulty();
  var_01 = "bot_rank_" + var_00;
  if(isDefined(self.pers[var_01]) && self.pers[var_01] > 0) {
    return self.pers[var_01];
  }

  var_02 = bot_random_ranks_for_difficulty(var_00);
  var_03 = var_02["rank"];
  var_04 = var_02["prestige"];
  var_05 = scripts\mp\rank::getrankinfominxp(var_03);
  var_06 = var_05 + scripts\mp\rank::getrankinfoxpamt(var_03);
  var_07 = randomintrange(var_05, var_06 + 1);
  self.pers[var_01] = var_07;
  return var_07;
}

bot_3d_sighting_model(param_00) {
  thread bot_3d_sighting_model_thread(param_00);
}

bot_3d_sighting_model_thread(param_00) {
  param_00 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(isalive(self) && !self botcanseeentity(param_00) && scripts\engine\utility::within_fov(self.origin, self.angles, param_00.origin, self botgetfovdot())) {
      self botgetimperfectenemyinfo(param_00, param_00.origin);
    }

    wait(0.1);
  }
}

bot_random_ranks_for_difficulty(param_00) {
  var_01 = [];
  var_01["rank"] = 0;
  var_01["prestige"] = 0;
  if(param_00 == "default") {
    return var_01;
  }

  if(!isDefined(level.bot_rnd_rank)) {
    level.bot_rnd_rank = [];
    level.bot_rnd_rank["recruit"][0] = 0;
    level.bot_rnd_rank["recruit"][1] = 5;
    level.bot_rnd_rank["regular"][0] = 6;
    level.bot_rnd_rank["regular"][1] = 9;
    level.bot_rnd_rank["hardened"][0] = 10;
    level.bot_rnd_rank["hardened"][1] = 19;
    level.bot_rnd_rank["veteran"][0] = 20;
    level.bot_rnd_rank["veteran"][1] = 29;
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

  if(isDefined(level.bot_rnd_rank[param_00][0]) && isDefined(level.bot_rnd_rank[param_00][1])) {
    var_01["rank"] = randomintrange(level.bot_rnd_rank[param_00][0], level.bot_rnd_rank[param_00][1] + 1);
  }

  if(isDefined(level.bot_rnd_prestige[param_00][0]) && isDefined(level.bot_rnd_prestige[param_00][1])) {
    var_01["prestige"] = randomintrange(level.bot_rnd_prestige[param_00][0], level.bot_rnd_prestige[param_00][1] + 1);
  }

  return var_01;
}

crate_can_use_always(param_00) {
  if(isagent(self) && !isDefined(param_00.boxtype)) {
    return 0;
  }

  if(isDefined(param_00.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(param_00.cratetype)) {
    return 0;
  }

  return 1;
}

get_human_player() {
  var_00 = undefined;
  var_01 = getEntArray("player", "classname");
  if(isDefined(var_01)) {
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      if(isDefined(var_01[var_02]) && isDefined(var_01[var_02].connected) && var_01[var_02].connected && !isai(var_01[var_02]) && !isDefined(var_00) || var_00.team == "spectator") {
        var_00 = var_01[var_02];
      }
    }
  }

  return var_00;
}

bot_damage_callback(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(param_02 == "MOD_FALLING" || param_02 == "MOD_SUICIDE") {
    return;
  }

  if(param_01 <= 0) {
    return;
  }

  if(!isDefined(param_04)) {
    if(!isDefined(param_00)) {
      return;
    }

    param_04 = param_00;
  }

  if(isDefined(param_04)) {
    if(isDefined(self.fnbotdamagecallback)) {
      self[[self.fnbotdamagecallback]](param_00, param_01, param_02, param_03, param_04, param_05);
    }

    if(level.teambased) {
      if(isDefined(param_04.team) && param_04.team == self.team) {
        return;
      } else if(isDefined(param_00) && isDefined(param_00.team) && param_00.team == self.team) {
        return;
      }
    }

    var_06 = scripts\mp\bots\_bots_util::bot_get_known_attacker(param_00, param_04);
    if(isDefined(var_06)) {
      self getpassivemessage(var_06);
    }
  }
}

on_bot_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self getotherteam();
  self botclearscriptgoal();
  var_0A = scripts\mp\bots\_bots_util::bot_get_known_attacker(param_01, param_00);
  if(!scripts\mp\utility::bot_is_fireteam_mode() && isDefined(var_0A) && var_0A.classname == "script_vehicle" && isDefined(var_0A.helitype)) {
    var_0B = self botgetdifficultysetting("launcherRespawnChance");
    if(randomfloat(1) < var_0B) {
      self.respawn_with_launcher = 1;
    }
  }
}

bot_should_do_killcam() {
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return 0;
  }

  var_00 = 0;
  var_01 = self botgetdifficulty();
  if(var_01 == "recruit") {
    var_00 = 0.1;
  } else if(var_01 == "regular") {
    var_00 = 0.4;
  } else if(var_01 == "hardened") {
    var_00 = 0.7;
  } else if(var_01 == "veteran") {
    var_00 = 1;
  }

  return randomfloat(1) < 1 - var_00;
}

bot_should_pickup_weapons() {
  if(scripts\mp\utility::isjuggernaut()) {
    return 0;
  }

  return 1;
}

bot_restart_think_threads() {
  thread bot_think_watch_enemy();
  thread scripts\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();
  thread bot_think_level_acrtions();
  thread bot_think_crate();
  thread scripts\mp\bots\_bots_supers::bot_think_supers();
  thread scripts\mp\bots\_bots_powers::bot_think_powers();
  thread bot_think_crate_blocking_path();
  thread scripts\mp\bots\_bots_killstreaks::bot_think_killstreak();
  thread scripts\mp\bots\_bots_killstreaks::bot_think_watch_aerial_killstreak();
  thread bot_think_gametype();
}

bot_think_watch_enemy(param_00) {
  var_01 = "spawned_player";
  if(isDefined(param_00) && param_00) {
    var_01 = "death";
  }

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var_01);
  self endon("disconnect");
  level endon("game_ended");
  self.last_enemy_sight_time = gettime();
  for(;;) {
    if(isDefined(self.isnodeoccupied)) {
      if(self botcanseeentity(self.isnodeoccupied)) {
        self.last_enemy_sight_time = gettime();
      }
    }

    wait(0.05);
  }
}

bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = "throwingknife_mp";
  for(;;) {
    var_01 = 0;
    if(scripts\mp\bots\_bots_util::bot_out_of_ammo() && self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      var_02 = getEntArray("dropped_weapon", "targetname");
      var_03 = scripts\engine\utility::get_array_of_closest(self.origin, var_02);
      if(var_03.size > 0) {
        var_04 = var_03[0];
        bot_seek_dropped_weapon(var_04);
      }
    }

    if(!scripts\mp\bots\_bots_util::bot_in_combat() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      var_05 = self hasweapon(var_00);
      var_06 = var_05 && self getrunningforwardpainanim(var_00) == 0;
      if(var_06) {
        if(isDefined(self.going_for_knife)) {
          wait(5);
          continue;
        }

        var_07 = getEntArray("dropped_knife", "targetname");
        var_08 = scripts\engine\utility::get_array_of_closest(self.origin, var_07);
        foreach(var_0A in var_08) {
          if(!isDefined(var_0A)) {
            continue;
          }

          if(!isDefined(var_0A.calculated_closest_point)) {
            var_0B = scripts\mp\bots\_bots_util::bot_queued_process("BotGetClosestNavigablePoint", ::scripts\mp\bots\_bots_util::func_bot_get_closest_navigable_point, var_0A.origin, 32, self);
            if(isDefined(var_0A)) {
              var_0A.closest_point_on_grid = var_0B;
              var_0A.calculated_closest_point = 1;
            } else {
              continue;
            }
          }

          if(isDefined(var_0A.closest_point_on_grid)) {
            self.going_for_knife = 1;
            bot_seek_dropped_weapon(var_0A);
          }
        }
      } else if(var_05) {
        self.going_for_knife = undefined;
      }
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

bot_seek_dropped_weapon(param_00) {
  if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", param_00) == 0) {
    var_01 = undefined;
    if(param_00.var_336 == "dropped_weapon") {
      var_02 = 1;
      var_03 = self getweaponslistprimaries();
      foreach(var_05 in var_03) {
        if(param_00.model == getweaponmodel(var_05)) {
          var_02 = 0;
        }
      }

      if(var_02) {
        var_01 = ::bot_pickup_weapon;
      }
    }

    var_07 = spawnStruct();
    var_07.object = param_00;
    var_07.script_goal_radius = 12;
    var_07.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var_07.action_thread = var_01;
    scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", param_00.origin, 100, var_07);
  }
}

bot_pickup_weapon(param_00) {
  self botpressbutton("use", 2);
  wait(2);
}

should_stop_seeking_weapon(param_00) {
  if(!isDefined(param_00.object)) {
    return 1;
  }

  if(param_00.object.var_336 == "dropped_weapon") {
    if(scripts\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0) {
      return 1;
    }
  } else if(param_00.object.var_336 == "dropped_knife") {
    if(scripts\mp\bots\_bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

bot_think_level_acrtions(param_00) {
  self notify("bot_think_level_actions");
  self endon("bot_think_level_actions");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("calculate_new_level_targets", randomfloatrange(2, 10));
    if(!isDefined(level.level_specific_bot_targets) || level.level_specific_bot_targets.size == 0) {
      continue;
    }

    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal("map_interactive_object")) {
      continue;
    }

    if(scripts\mp\bots\_bots_util::bot_in_combat() || scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    var_01 = undefined;
    foreach(var_03 in level.level_specific_bot_targets) {
      if(scripts\engine\utility::array_contains(var_03.high_priority_for, self)) {
        var_01 = var_03;
        break;
      }
    }

    if(!isDefined(var_01)) {
      if(randomint(100) > 25) {
        continue;
      }

      var_05 = scripts\engine\utility::get_array_of_closest(self.origin, level.level_specific_bot_targets);
      var_06 = 256;
      if(isDefined(param_00)) {
        var_06 = param_00;
      } else if(self botgetscriptgoaltype() == "hunt" && self botpursuingscriptgoal()) {
        var_06 = 512;
      }

      if(distancesquared(self.origin, var_05[0].origin) > var_06 * var_06) {
        continue;
      }

      var_01 = var_05[0];
    }

    var_07 = 0;
    if(var_01.bot_interaction_type == "damage") {
      var_07 = bot_should_melee_level_damage_target(var_01);
      if(var_07) {
        var_08 = var_01.origin[2] - var_01.bot_targets[0].origin[2] + 55;
        var_09 = var_01.origin[2] - var_01.bot_targets[1].origin[2] + 55;
        if(var_08 > 55 && var_09 > 55) {
          if(scripts\engine\utility::array_contains(var_01.high_priority_for, self)) {
            var_01.high_priority_for = scripts\engine\utility::array_remove(var_01.high_priority_for, self);
          }

          continue;
        }
      }

      var_0A = weaponclass(self getcurrentweapon());
      if(var_0A == "spread") {
        var_0B = var_01.bot_targets[0].origin - var_01.origin;
        var_0C = var_01.bot_targets[1].origin - var_01.origin;
        var_0D = lengthsquared(var_0B);
        var_0E = lengthsquared(var_0C);
        if(var_0D > 22500 && var_0E > 22500) {
          if(scripts\engine\utility::array_contains(var_01.high_priority_for, self)) {
            var_01.high_priority_for = scripts\engine\utility::array_remove(var_01.high_priority_for, self);
          }

          continue;
        }
      }
    }

    var_0F = spawnStruct();
    var_0F.object = var_01;
    if(var_01.bot_interaction_type == "damage") {
      if(var_07) {
        var_0F.should_abort = ::level_trigger_should_abort_melee;
      } else {
        var_0F.should_abort = ::level_trigger_should_abort_ranged;
      }
    }

    if(var_01.bot_interaction_type == "use") {
      var_0F.action_thread = ::use_use_trigger;
      var_0F.should_abort = ::level_trigger_should_abort;
      var_0F.script_goal_yaw = vectortoangles(var_01.origin - var_01.bot_target.origin)[1];
      scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("map_interactive_object", var_01.bot_target.origin, 10, var_0F);
      continue;
    }

    if(var_01.bot_interaction_type == "damage") {
      if(var_07) {
        var_0F.action_thread = ::melee_damage_trigger;
        var_0F.script_goal_radius = 20;
      } else {
        var_0F.action_thread = ::attack_damage_trigger;
        var_0F.script_goal_radius = 50;
      }

      var_10 = undefined;
      var_11 = scripts\mp\bots\_bots_util::bot_queued_process("GetPathDistLevelAction", ::scripts\mp\bots\_bots_util::func_get_path_dist, self.origin, var_01.bot_targets[0].origin);
      var_12 = scripts\mp\bots\_bots_util::bot_queued_process("GetPathDistLevelAction", ::scripts\mp\bots\_bots_util::func_get_path_dist, self.origin, var_01.bot_targets[1].origin);
      if(!isDefined(var_01)) {
        continue;
      }

      if(var_11 <= 0 && var_12 <= 0) {
        continue;
      }

      if(var_11 > 0) {
        if(var_12 < 0 || var_11 <= var_12) {
          var_10 = var_01.bot_targets[0];
        }
      }

      if(var_12 > 0) {
        if(var_11 < 0 || var_12 <= var_11) {
          var_10 = var_01.bot_targets[1];
        }
      }

      if(!var_07) {
        childthread monitor_node_visible(var_10);
      }

      scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("map_interactive_object", var_10.origin, 10, var_0F);
    }
  }
}

bot_should_melee_level_damage_target(param_00) {
  var_01 = self getcurrentweapon();
  var_02 = scripts\mp\bots\_bots_util::bot_out_of_ammo() || self.hasriotshieldequipped || isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1 || weaponclass(var_01) == "grenade" || scripts\mp\weapons::isknifeonly(var_01);
  return var_02;
}

monitor_node_visible(param_00) {
  self endon("goal");
  wait(0.1);
  for(;;) {
    if(weaponclass(self getcurrentweapon()) == "spread") {
      if(distancesquared(self.origin, param_00.origin) > 90000) {
        wait(0.05);
        continue;
      }
    }

    var_01 = self getnearestnode();
    if(isDefined(var_01)) {
      if(nodesvisible(var_01, param_00)) {
        if(sighttracepassed(self.origin + (0, 0, 55), param_00.origin + (0, 0, 55), 0, self)) {
          self notify("goal");
        }
      }
    }

    wait(0.05);
  }
}

attack_damage_trigger(param_00) {
  if(param_00.object.origin[2] - self getEye()[2] > 55) {
    if(distance2dsquared(param_00.object.origin, self.origin) < 225) {
      return;
    }
  }

  self botsetflag("disable_movement", 1);
  look_at_damage_trigger(param_00.object, 0.3);
  self botpressbutton("ads", 0.3);
  wait(0.25);
  var_01 = gettime();
  while(isDefined(param_00.object) && !isDefined(param_00.object.already_used) && gettime() - var_01 < 5000) {
    look_at_damage_trigger(param_00.object, 0.15);
    self botpressbutton("ads", 0.15);
    self botpressbutton("attack");
    wait(0.1);
  }

  self botsetflag("disable_movement", 0);
}

melee_damage_trigger(param_00) {
  self botsetflag("disable_movement", 1);
  look_at_damage_trigger(param_00.object, 0.3);
  wait(0.25);
  var_01 = gettime();
  while(isDefined(param_00.object) && !isDefined(param_00.object.already_used) && gettime() - var_01 < 5000) {
    look_at_damage_trigger(param_00.object, 0.15);
    self botpressbutton("melee");
    wait(0.1);
  }

  self botsetflag("disable_movement", 0);
}

look_at_damage_trigger(param_00, param_01) {
  var_02 = param_00.origin;
  if(distance2dsquared(self.origin, var_02) < 100) {
    var_02 = (var_02[0], var_02[1], self getEye()[2]);
  }

  self botlookatpoint(var_02, param_01, "script_forced");
}

use_use_trigger(param_00) {
  if(isagent(self)) {
    scripts\engine\utility::allow_usability(1);
    param_00.object enableplayeruse(self);
    wait(0.05);
  }

  var_01 = param_00.object.use_time;
  self botpressbutton("use", var_01);
  wait(var_01);
  if(isagent(self)) {
    scripts\engine\utility::allow_usability(0);
    if(isDefined(param_00.object)) {
      param_00.object disableplayeruse(self);
    }
  }
}

level_trigger_should_abort_melee(param_00) {
  if(level_trigger_should_abort(param_00)) {
    return 1;
  }

  if(!bot_should_melee_level_damage_target(param_00.object)) {
    return 1;
  }

  return 0;
}

level_trigger_should_abort_ranged(param_00) {
  if(level_trigger_should_abort(param_00)) {
    return 1;
  }

  if(bot_should_melee_level_damage_target(param_00.object)) {
    return 1;
  }

  return 0;
}

level_trigger_should_abort(param_00) {
  if(!isDefined(param_00.object)) {
    return 1;
  }

  if(isDefined(param_00.object.already_used)) {
    return 1;
  }

  if(scripts\mp\bots\_bots_util::bot_in_combat()) {
    return 1;
  }

  return 0;
}

crate_in_range(param_00) {
  if(!isDefined(param_00.triggerportableradarping) || param_00.triggerportableradarping != self) {
    if(distancesquared(self.origin, param_00.origin) > 4194304) {
      return 0;
    }
  }

  return 1;
}

bot_crate_valid(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = self[[level.bot_funcs["crate_can_use"]]](param_00);
  if(!var_01) {
    if(level.gametype == "grnd") {
      var_01 = 1;
    }
  }

  if(!var_01) {
    return 0;
  }

  if(!crate_landed_and_on_path_grid(param_00)) {
    return 0;
  }

  if(level.teambased && isDefined(param_00.bomb) && isDefined(param_00.team) && param_00.team == self.team) {
    return 0;
  }

  if(!self[[level.bot_funcs["crate_in_range"]]](param_00)) {
    return 0;
  }

  if(isDefined(param_00.boxtype)) {
    if(isDefined(level.boxsettings[param_00.boxtype]) && ![
        [level.boxsettings[param_00.boxtype].canusecallback]
      ]()) {
      return 0;
    }

    if(isDefined(param_00.disabled_use_for) && isDefined(param_00.disabled_use_for[self getentitynumber()]) && param_00.disabled_use_for[self getentitynumber()]) {
      return 0;
    }

    if(!self[[level.bot_can_use_box_by_type[param_00.boxtype]]](param_00)) {
      return 0;
    }
  }

  return isDefined(param_00);
}

crate_landed_and_on_path_grid(param_00) {
  if(!crate_has_landed(param_00)) {
    return 0;
  }

  if(!crate_is_on_path_grid(param_00)) {
    return 0;
  }

  return isDefined(param_00);
}

crate_has_landed(param_00) {
  if(isDefined(param_00.boxtype)) {
    return gettime() > param_00.var_64 + 1000;
  }

  return isDefined(param_00.droppingtoground) && !param_00.droppingtoground;
}

crate_is_on_path_grid(param_00) {
  if(!isDefined(param_00.on_path_grid)) {
    crate_calculate_on_path_grid(param_00);
  }

  return isDefined(param_00) && param_00.on_path_grid;
}

node_within_use_radius_of_crate(param_00, param_01) {
  if(isDefined(param_01.boxtype) && param_01.boxtype == "scavenger_bag") {
    return abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 18;
  }

  var_02 = getdvarfloat("player_useRadius");
  var_03 = distancesquared(param_01.origin, param_00.origin + (0, 0, 40));
  return var_03 <= var_02 * var_02;
}

crate_calculate_on_path_grid(param_00) {
  param_00 thread crate_monitor_position();
  param_00.on_path_grid = 0;
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(param_00.forcedisconnectuntil)) {
    var_01 = param_00.forcedisconnectuntil;
    var_02 = gettime() + 30000;
    param_00.forcedisconnectuntil = var_02;
    param_00 notify("path_disconnect");
  }

  wait(0.05);
  if(!isDefined(param_00)) {
    return;
  }

  var_03 = crate_get_nearest_valid_nodes(param_00);
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(var_03) && var_03.size > 0) {
    param_00.nearest_nodes = var_03;
    param_00.on_path_grid = 1;
  } else {
    var_04 = getdvarfloat("player_useRadius");
    var_05 = getnodesinradiussorted(param_00.origin, var_04 * 2, 0)[0];
    var_06 = param_00 getpointinbounds(0, 0, -1);
    var_07 = undefined;
    if(isDefined(param_00.boxtype) && param_00.boxtype == "scavenger_bag") {
      if(scripts\mp\bots\_bots_util::bot_point_is_on_pathgrid(param_00.origin)) {
        var_07 = param_00.origin;
      }
    } else {
      var_07 = botgetclosestnavigablepoint(param_00.origin, var_04);
    }

    if(isDefined(var_05) && !var_05 getweaponbarsize() && isDefined(var_07) && abs(var_05.origin[2] - var_06[2]) < 30) {
      param_00.nearest_points = [var_07];
      param_00.nearest_nodes = [var_05];
      param_00.on_path_grid = 1;
    }
  }

  if(isDefined(param_00.forcedisconnectuntil)) {
    if(param_00.forcedisconnectuntil == var_02) {
      param_00.forcedisconnectuntil = var_01;
    }
  }
}

crate_get_nearest_valid_nodes(param_00) {
  var_01 = getnodesinradiussorted(param_00.origin, 256, 0);
  for(var_02 = var_01.size; var_02 > 0; var_02--) {
    var_01[var_02] = var_01[var_02 - 1];
  }

  var_01[0] = getclosestnodeinsight(param_00.origin);
  var_03 = undefined;
  if(isDefined(param_00.forcedisconnectuntil)) {
    var_03 = getallnodes();
  }

  var_04 = [];
  var_05 = 1;
  if(!isDefined(param_00.boxtype)) {
    var_05 = 2;
  }

  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_06 = var_01[var_02];
    if(!isDefined(var_06) || !isDefined(param_00)) {
      continue;
    }

    if(var_06 getweaponbarsize()) {
      continue;
    }

    if(!node_within_use_radius_of_crate(var_06, param_00)) {
      if(var_02 == 0) {
        continue;
      } else {
        break;
      }
    }

    wait(0.05);
    if(!isDefined(param_00)) {
      break;
    }

    if(sighttracepassed(param_00.origin, var_06.origin + (0, 0, 55), 0, param_00)) {
      wait(0.05);
      if(!isDefined(param_00)) {
        break;
      }

      if(!isDefined(param_00.forcedisconnectuntil)) {
        var_04[var_04.size] = var_06;
        if(var_04.size == var_05) {
          return var_04;
        } else {
          continue;
        }
      }

      var_07 = undefined;
      var_08 = 0;
      while(!isDefined(var_07) && var_08 < 100) {
        var_08++;
        var_09 = scripts\engine\utility::random(var_03);
        if(distancesquared(var_06.origin, var_09.origin) > 250000) {
          var_07 = var_09;
        }
      }

      if(isDefined(var_07)) {
        var_0A = scripts\mp\bots\_bots_util::bot_queued_process("GetNodesOnPathCrate", ::scripts\mp\bots\_bots_util::func_get_nodes_on_path, var_06.origin, var_07.origin);
        if(isDefined(var_0A)) {
          var_04[var_04.size] = var_06;
          if(var_04.size == var_05) {
            return var_04;
          } else {
            continue;
          }
        }
      }
    }
  }

  return undefined;
}

crate_get_bot_target(param_00) {
  if(isDefined(param_00.nearest_points)) {
    return param_00.nearest_points[0];
  }

  if(isDefined(param_00.nearest_nodes)) {
    if(param_00.nearest_nodes.size > 1) {
      var_01 = scripts\engine\utility::array_reverse(self getparent(param_00.nearest_nodes, "node_exposed"));
      return scripts\engine\utility::random_weight_sorted(var_01).origin;
    } else {
      return var_01.nearest_nodes[0].origin;
    }
  }
}

crate_get_bot_target_check_distance(param_00, param_01) {
  var_02 = crate_get_bot_target(param_00);
  var_02 = getclosestpointonnavmesh(var_02, self);
  var_03 = param_01 * 0.9;
  var_03 = var_03 * var_03;
  if(distancesquared(param_00.origin, var_02) <= var_03) {
    return var_02;
  }

  return undefined;
}

bot_think_crate() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = getdvarfloat("player_useRadius");
  for(;;) {
    var_01 = randomfloatrange(2, 4);
    scripts\engine\utility::waittill_notify_or_timeout("new_crate_to_take", var_01);
    if(isDefined(self.boxes) && self.boxes.size == 0) {
      self.boxes = undefined;
    }

    var_02 = level.carepackages;
    if(!scripts\mp\bots\_bots_util::bot_in_combat() && isDefined(self.boxes)) {
      var_02 = scripts\engine\utility::array_combine(var_02, self.boxes);
    }

    if(isDefined(level.bot_scavenger_bags) && scripts\mp\utility::_hasperk("specialty_scavenger")) {
      var_02 = scripts\engine\utility::array_combine(var_02, level.bot_scavenger_bags);
    }

    var_02 = scripts\engine\utility::array_removeundefined(var_02);
    if(var_02.size == 0) {
      continue;
    }

    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    var_03 = [];
    foreach(var_05 in var_02) {
      if(bot_crate_valid(var_05)) {
        var_03[var_03.size] = var_05;
      }
    }

    var_03 = scripts\engine\utility::array_remove_duplicates(var_03);
    if(var_03.size == 0) {
      continue;
    }

    var_03 = scripts\engine\utility::get_array_of_closest(self.origin, var_03);
    var_07 = self getnearestnode();
    if(!isDefined(var_07)) {
      continue;
    }

    var_08 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    var_09 = (var_08 || randomint(100) < 50) && !scripts\mp\killstreaks\_emp_common::isemped();
    var_0A = undefined;
    foreach(var_05 in var_03) {
      var_0C = 0;
      if((!isDefined(var_05.triggerportableradarping) || var_05.triggerportableradarping != self) && !isDefined(var_05.boxtype)) {
        var_0D = [];
        foreach(var_0F in level.players) {
          if(!isDefined(var_0F.team)) {
            continue;
          }

          if(!isai(var_0F) && level.teambased && var_0F.team == self.team) {
            if(distancesquared(var_0F.origin, var_05.origin) < 490000) {
              var_0D[var_0D.size] = var_0F;
            }
          }
        }

        if(var_0D.size > 0) {
          var_11 = var_0D[0] getnearestnode();
          if(isDefined(var_11)) {
            var_0C = 0;
            foreach(var_13 in var_05.nearest_nodes) {
              var_0C = var_0C | nodesvisible(var_11, var_13, 1);
            }
          }
        }
      }

      if(!var_0C) {
        var_15 = isDefined(var_05.bots) && isDefined(var_05.bots[self.team]) && var_05.bots[self.team] > 0;
        var_16 = 0;
        foreach(var_13 in var_05.nearest_nodes) {
          var_16 = var_16 | nodesvisible(var_07, var_13, 1);
        }

        if(var_16 || var_09 && !var_15) {
          var_0A = var_05;
          break;
        }
      }
    }

    if(isDefined(var_0A)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(var_0A.boxtype)) {
          if(!isDefined(var_0A.bots)) {
            var_0A.bots = [];
          }

          var_0A.bots[self.team] = 1;
        }
      }

      var_1A = spawnStruct();
      var_1A.object = var_0A;
      var_1A.start_thread = ::watch_bot_died_during_crate;
      var_1A.should_abort = ::crate_picked_up;
      var_1B = undefined;
      if(isDefined(var_0A.boxtype)) {
        if(isDefined(var_0A.boxtouchonly) && var_0A.boxtouchonly) {
          var_1A.script_goal_radius = 16;
          var_1A.action_thread = undefined;
          var_1B = var_0A.origin;
        } else {
          var_1A.script_goal_radius = 50;
          var_1A.action_thread = ::use_box;
          var_1C = crate_get_bot_target_check_distance(var_0A, var_00);
          if(!isDefined(var_1C)) {
            continue;
          }

          var_1C = var_1C - var_0A.origin;
          var_1D = length(var_1C) * randomfloat(1);
          var_1B = var_0A.origin + vectornormalize(var_1C) * var_1D + (0, 0, 12);
        }
      } else {
        var_1A.action_thread = ::use_crate;
        var_1A.end_thread = ::stop_using_crate;
        var_1B = crate_get_bot_target_check_distance(var_0A, var_00);
        if(!isDefined(var_1B)) {
          continue;
        }

        var_1A.script_goal_radius = var_00 - distance(var_0A.origin, var_1B + (0, 0, 40));
        var_1B = var_1B + (0, 0, 24);
      }

      if(isDefined(var_1A.script_goal_radius)) {}

      var_0A notify("path_disconnect");
      wait(0.05);
      if(!isDefined(var_0A)) {
        continue;
      }

      scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("airdrop_crate", var_1B, 30, var_1A);
    }
  }
}

bot_should_use_ballistic_vest_crate(param_00) {
  return 1;
}

crate_should_claim() {
  return 1;
}

crate_low_ammo_check() {
  return 0;
}

bot_should_use_ammo_crate(param_00) {
  if(self getcurrentweapon() == level.boxsettings[param_00.boxtype].minigunweapon) {
    return 0;
  }

  return 1;
}

bot_post_use_ammo_crate(param_00) {
  scripts\mp\utility::_switchtoweapon(self.secondaryweapon);
  wait(1);
}

bot_post_use_ammo_crate(param_00) {
  scripts\mp\utility::_switchtoweapon("none");
  self.secondaryweapon = self getcurrentweapon();
}

bot_should_use_scavenger_bag(param_00) {
  if(scripts\mp\bots\_bots_util::bot_get_low_on_ammo(0.66)) {
    var_01 = self getnearestnode();
    if(isDefined(param_00.nearest_nodes) && isDefined(param_00.nearest_nodes[0]) && isDefined(var_01)) {
      if(nodesvisible(var_01, param_00.nearest_nodes[0], 1)) {
        if(scripts\engine\utility::within_fov(self.origin, self.angles, param_00.origin, self botgetfovdot())) {
          return 1;
        }
      }
    }
  }

  return 0;
}

bot_should_use_grenade_crate(param_00) {
  var_01 = self getweaponslistoffhands();
  foreach(var_03 in var_01) {
    if(self getweaponammostock(var_03) == 0) {
      return 1;
    }
  }

  return 0;
}

bot_should_use_juicebox_crate(param_00) {
  return 1;
}

crate_monitor_position() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    var_00 = self.origin;
    wait(0.5);
    if(!isalive(self)) {
      return;
    }

    if(!scripts\mp\bots\_bots_util::bot_vectors_are_equal(self.origin, var_00)) {
      self.on_path_grid = undefined;
      self.nearest_nodes = undefined;
      self.nearest_points = undefined;
    }
  }
}

crate_wait_use() {}

crate_picked_up(param_00) {
  if(!isDefined(param_00.object)) {
    return 1;
  }

  return 0;
}

use_crate(param_00) {
  if(isagent(self)) {
    scripts\engine\utility::allow_usability(1);
    param_00.object enableplayeruse(self);
    wait(0.05);
  }

  self[[level.bot_funcs["crate_wait_use"]]]();
  if(isDefined(param_00.object.triggerportableradarping) && param_00.object.triggerportableradarping == self) {
    var_01 = level.crateownerusetime / 1000 + 0.5;
  } else {
    var_01 = level.cratenonownerusetime / 1000 + 1;
  }

  self botpressbutton("use", var_01);
  wait(var_01);
  if(isagent(self)) {
    scripts\engine\utility::allow_usability(0);
    if(isDefined(param_00.object)) {
      param_00.object disableplayeruse(self);
    }
  }

  if(isDefined(param_00.object)) {
    if(!isDefined(param_00.object.bots_used)) {
      param_00.object.bots_used = [];
    }

    param_00.object.bots_used[param_00.object.bots_used.size] = self;
  }
}

use_box(param_00) {
  if(isagent(self)) {
    scripts\engine\utility::allow_usability(1);
    param_00.object enableplayeruse(self);
    wait(0.05);
  }

  if(isDefined(param_00.object) && isDefined(param_00.object.boxtype)) {
    var_01 = param_00.object.boxtype;
    if(isDefined(level.bot_pre_use_box_of_type[var_01])) {
      self[[level.bot_pre_use_box_of_type[var_01]]](param_00.object);
    }

    if(isDefined(param_00.object)) {
      var_02 = level.boxsettings[param_00.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("use", var_02);
      wait(var_02);
      if(isDefined(level.bot_post_use_box_of_type[var_01])) {
        self[[level.bot_post_use_box_of_type[var_01]]](param_00.object);
      }
    }
  }

  if(isagent(self)) {
    scripts\engine\utility::allow_usability(0);
    if(isDefined(param_00.object)) {
      param_00.object disableplayeruse(self);
    }
  }
}

watch_bot_died_during_crate(param_00) {
  thread bot_watch_for_death(param_00.object);
}

stop_using_crate(param_00) {
  if(isDefined(param_00.object)) {
    param_00.object.bots[self.team] = 0;
  }
}

bot_watch_for_death(param_00) {
  param_00 endon("death");
  param_00 endon("revived");
  param_00 endon("disconnect");
  level endon("game_ended");
  var_01 = self.team;
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  if(isDefined(param_00)) {
    param_00.bots[var_01] = 0;
  }
}

bot_think_crate_blocking_path() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = getdvarfloat("player_useRadius");
  for(;;) {
    wait(3);
    if(self usebuttonpressed()) {
      continue;
    }

    if(scripts\mp\utility::isusingremote()) {
      continue;
    }

    var_01 = level.carepackages;
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = var_01[var_02];
      if(!isDefined(var_03)) {
        continue;
      }

      if(distancesquared(self.origin, var_03.origin) < var_00 * var_00) {
        if(var_03.triggerportableradarping == self) {
          self botpressbutton("use", level.crateownerusetime / 1000 + 0.5);
          continue;
        }

        self botpressbutton("use", level.cratenonownerusetime / 1000 + 0.5);
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
    var_00 = 2;
    var_01 = getEntArray("revive_trigger", "targetname");
    if(var_01.size > 0) {
      var_00 = 0.05;
    }

    level scripts\engine\utility::waittill_notify_or_timeout("player_last_stand", var_00);
    if(!bot_can_revive()) {
      continue;
    }

    var_01 = getEntArray("revive_trigger", "targetname");
    if(var_01.size > 1) {
      var_01 = sortbydistance(var_01, self.origin);
      if(isDefined(self.triggerportableradarping)) {
        for(var_02 = 0; var_02 < var_01.size; var_02++) {
          if(var_01[var_02].triggerportableradarping != self.triggerportableradarping) {
            continue;
          }

          if(var_02 == 0) {
            break;
          }

          var_03 = var_01[var_02];
          var_01[var_02] = var_01[0];
          var_01[0] = var_03;
          break;
        }
      }
    }

    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_04 = var_01[var_02];
      var_05 = var_04.triggerportableradarping;
      if(!isDefined(var_05)) {
        continue;
      }

      if(var_05 == self) {
        continue;
      }

      if(!isalive(var_05)) {
        continue;
      }

      if(var_05.team != self.team) {
        continue;
      }

      if(!isDefined(var_05.inlaststand) || !var_05.inlaststand) {
        continue;
      }

      if(isDefined(var_05.bots) && isDefined(var_05.bots[self.team]) && var_05.bots[self.team] > 0) {
        continue;
      }

      if(distancesquared(self.origin, var_05.origin) < 4194304) {
        var_06 = spawnStruct();
        var_06.object = var_04;
        var_06.script_goal_radius = 64;
        if(isDefined(self.last_revive_fail_time) && gettime() - self.last_revive_fail_time < 1000) {
          var_06.script_goal_radius = 32;
        }

        var_06.start_thread = ::watch_bot_died_during_revive;
        var_06.end_thread = ::stop_reviving;
        var_06.should_abort = ::player_revived_or_dead;
        var_06.action_thread = ::revive_player;
        scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("revive", var_05.origin, 60, var_06);
        break;
      }
    }
  }
}

watch_bot_died_during_revive(param_00) {
  thread bot_watch_for_death(param_00.object.triggerportableradarping);
}

stop_reviving(param_00) {
  if(isDefined(param_00.object.triggerportableradarping)) {
    param_00.object.triggerportableradarping.bots[self.team] = 0;
  }
}

player_revived_or_dead(param_00) {
  if(!isDefined(param_00.object.triggerportableradarping) || param_00.object.triggerportableradarping.health <= 0) {
    return 1;
  }

  if(!isDefined(param_00.object.triggerportableradarping.inlaststand) || !param_00.object.triggerportableradarping.inlaststand) {
    return 1;
  }

  return 0;
}

revive_player(param_00) {
  if(distancesquared(self.origin, param_00.object.triggerportableradarping.origin) > 4096) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(isagent(self)) {
    scripts\engine\utility::allow_usability(1);
    param_00.object enableplayeruse(self);
    wait(0.05);
  }

  var_01 = self.team;
  self botpressbutton("use", level.laststandrevivetimer / 1000 + 0.5);
  wait(level.laststandrevivetimer / 1000 + 1.5);
  if(isDefined(param_00.object.triggerportableradarping)) {
    param_00.object.bots[var_01] = 0;
  }

  if(isagent(self)) {
    scripts\engine\utility::allow_usability(0);
    if(isDefined(param_00.object)) {
      param_00.object disableplayeruse(self);
    }
  }
}

bot_can_revive() {
  if(isDefined(self.setlasermaterial) && self.setlasermaterial == 1) {
    return 0;
  }

  if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal("revive")) {
    return 0;
  }

  if(scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    return 0;
  }

  if(scripts\mp\bots\_bots_util::bot_is_bodyguarding()) {
    return 1;
  }

  var_00 = self botgetscriptgoaltype();
  if(var_00 == "none" || var_00 == "hunt" || var_00 == "guard") {
    return 1;
  }

  return 0;
}

revive_watch_for_finished(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("bad_path");
  self endon("goal");
  param_00 scripts\engine\utility::waittill_any_3("death", "revived");
  self notify("bad_path");
}

bot_know_enemies_on_start() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(gettime() > 15000) {
    return;
  }

  while(!scripts\mp\utility::gamehasstarted() || !scripts\mp\utility::gameflag("prematch_done")) {
    wait(0.05);
  }

  var_00 = undefined;
  var_01 = undefined;
  for(var_02 = 0; var_02 < level.players.size; var_02++) {
    var_03 = level.players[var_02];
    if(isDefined(var_03) && isDefined(self.team) && isDefined(var_03.team) && isenemyteam(self.team, var_03.team)) {
      if(!isDefined(var_03.bot_start_known_by_enemy)) {
        var_00 = var_03;
      }

      if(isai(var_03) && !isDefined(var_03.bot_start_know_enemy)) {
        var_01 = var_03;
      }
    }
  }

  if(isDefined(var_00)) {
    self.bot_start_know_enemy = 1;
    var_00.bot_start_known_by_enemy = 1;
    self getenemyinfo(var_00);
  }

  if(isDefined(var_01)) {
    var_01.bot_start_know_enemy = 1;
    self.bot_start_known_by_enemy = 1;
    var_01 getenemyinfo(self);
  }
}

bot_make_entity_sentient(param_00, param_01) {
  if(isDefined(param_01)) {
    return self makeentitysentient(param_00, param_01);
  }

  return self makeentitysentient(param_00);
}

bot_think_gametype() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::gameflagwait("prematch_done");
  self thread[[level.bot_funcs["gametype_think"]]]();
}

default_gametype_think() {}

monitor_smoke_grenades() {
  for(;;) {
    level waittill("smoke", var_00, var_01);
    if(var_01 == "smoke_grenade_mp") {
      var_00 thread monitor_smoke_grenade();
    }
  }
}

monitor_smoke_grenade() {
  self endon("late_death");
  thread smoke_grenade_late_death();
  self waittill("explode", var_00);
  wait(1);
  var_01 = spawn("script_model", var_00);
  var_01 show();
  var_02 = getent("smoke_grenade_sight_clip_256", "targetname");
  if(isDefined(var_02)) {
    var_01 clonebrushmodeltoscriptmodel(var_02);
  }

  wait(9.25);
  var_01 delete();
}

smoke_grenade_late_death() {
  self endon("explode");
  self waittill("death");
  waittillframeend;
  self notify("late_death");
}

bot_add_scavenger_bag(param_00) {
  var_01 = 0;
  param_00.boxtype = "scavenger_bag";
  param_00.boxtouchonly = 1;
  if(!isDefined(level.bot_scavenger_bags)) {
    level.bot_scavenger_bags = [];
  }

  foreach(var_04, var_03 in level.bot_scavenger_bags) {
    if(!isDefined(var_03)) {
      var_01 = 1;
      level.bot_scavenger_bags[var_04] = param_00;
      break;
    }
  }

  if(!var_01) {
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = param_00;
  }

  foreach(var_06 in level.participants) {
    if(isai(var_06) && var_06 scripts\mp\utility::_hasperk("specialty_scavenger")) {
      var_06 notify("new_crate_to_take");
    }
  }
}

bot_triggers() {
  var_00 = getEntArray("bot_flag_set", "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.script_noteworthy)) {
      continue;
    }

    var_02 thread bot_flag_trigger(var_02.script_noteworthy);
  }
}

bot_flag_trigger(param_00) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_01);
    if(scripts\mp\utility::isaigameparticipant(var_01)) {
      var_01 notify("flag_trigger_set_" + param_00);
      var_01 botsetflag(param_00, 1);
      var_01 thread bot_flag_trigger_clear(param_00);
    }
  }
}

bot_flag_trigger_clear(param_00) {
  self endon("flag_trigger_set_" + param_00);
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waitframe();
  waittillframeend;
  self botsetflag(param_00, 0);
}