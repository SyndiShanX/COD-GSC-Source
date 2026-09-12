/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots.gsc
***********************************************/

function main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    return;
  }

  setup_callbacks();
  scripts\mp\bots\bots_personality::setup_personalities();
  level.badplace_cylinder_func = &badplace_cylinder;
  level.badplace_delete_func = &badplace_delete;

  if(isDefined(level.deactivate_laser_trap)) {
    [[level.deactivate_laser_trap]]();
  } else {
    scripts\mp\bots\bots_killstreaks::bot_killstreak_setup();
  }

  scripts\mp\bots\bots_loadout::init();
  thread init();
  load_gametype_scripts_for_scriptdev();
}

function setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = &spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = &bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = &scripts\mp\bots\bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["bots_remove_from_level_targets"] = &scripts\mp\bots\bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["think"] = &bot_think;
  level.bot_funcs["on_killed"] = &on_bot_killed;
  level.bot_funcs["should_do_killcam"] = &bot_should_do_killcam;
  level.bot_funcs["get_attacker_ent"] = &scripts\mp\bots\bots_util::bot_get_known_attacker;
  level.bot_funcs["should_pickup_weapons"] = &bot_should_pickup_weapons;
  level.bot_funcs["on_damaged"] = &bot_damage_callback;
  level.bot_funcs["gametype_think"] = &default_gametype_think;
  level.bot_funcs["leader_dialog"] = &scripts\mp\bots\bots_util::bot_leader_dialog;
  level.bot_funcs["player_spawned"] = &bot_player_spawned;
  level.bot_funcs["should_start_cautious_approach"] = &scripts\mp\bots\bots_strategy::should_start_cautious_approach_default;
  level.bot_funcs["know_enemies_on_start"] = &bot_know_enemies_on_start;
  level.bot_funcs["bot_get_rank_xp"] = &bot_get_rank_xp;
  level.bot_funcs["ai_3d_sighting_model"] = &bot_3d_sighting_model;
  level.bot_funcs["dropped_weapon_think"] = &bot_think_seek_dropped_weapons;
  level.bot_funcs["dropped_weapon_cancel"] = &should_stop_seeking_weapon;
  level.bot_funcs["crate_can_use"] = &crate_can_use_always;
  level.bot_funcs["crate_low_ammo_check"] = &crate_low_ammo_check;
  level.bot_funcs["crate_should_claim"] = &crate_should_claim;
  level.bot_funcs["crate_wait_use"] = &crate_wait_use;
  level.bot_funcs["crate_in_range"] = &crate_in_range;
  level.bot_funcs["post_teleport"] = &bot_post_teleport;
  level.bot_funcs["bot_set_difficulty"] = &scripts\mp\bots\bots_util::bot_set_difficulty;
  level.bot_funcs["bot_set_personality"] = &scripts\mp\bots\bots_util::bot_set_personality;
  level.bot_funcs["bot_think_watch_enemy"] = &bot_think_watch_enemy;
  level.bot_funcs["bot_think_tactical_goals"] = &scripts\mp\bots\bots_strategy::bot_think_tactical_goals;
  level.bot_funcs["bot_bots_enabled_or_added"] = &scripts\mp\bots\bots_util::bot_bots_enabled_or_added;
  level.bot_funcs["revive_think"] = &bot_think_revive;
  level.bot_random_path_function = &scripts\mp\bots\bots_personality::bot_random_path_default;
  level.bot_find_defend_node_func["capture"] = &scripts\mp\bots\bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["capture_zone"] = &scripts\mp\bots\bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["protect"] = &scripts\mp\bots\bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["protect_zone"] = &scripts\mp\bots\bots_strategy::find_defend_node_protect_zone;
  level.bot_find_defend_node_func["bodyguard"] = &scripts\mp\bots\bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["patrol"] = &scripts\mp\bots\bots_strategy::find_defend_node_patrol;
  scripts\mp\bots\bots_gametype_war::setup_callbacks();
}

function codecallback_leaderdialog(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_1);
    return;
  }
}

function init() {
  thread monitor_smoke_grenades();
  thread bot_triggers();
  initbotlevelvariables();

  if(!shouldspawnbots()) {
    return;
  }

  refresh_existing_bots();
  var_0 = botsystemstatus();

  if(var_0 == "enabled_fill_open" || var_0 == "enabled_fill_open_dev") {
    setmatchdata("hasBots", 1);

    if(istrue(level.multiteambased)) {
      thread bot_connect_monitor_multiteam();
      return;
    }

    thread bot_connect_monitor();
    return;
  }

  thread bot_monitor_team_limits();
}

function initbotlevelvariables() {
  if(!isDefined(level.crateownerusetime)) {
    level.crateownerusetime = 500;
  }

  if(!isDefined(level.cratenonownerusetime)) {
    level.cratenonownerusetime = 3000;
  }

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name = "iw6_panzerfaust3";
  level.bot_fallback_weapon = "iw8_knife";
  level.zonecount = getzonecount();
  level.bot_light_volumes = getEntArray("bot_light_area", "targetname");
  level.bot_dark_volumes = getEntArray("bot_dark_area", "targetname");
  initbotmapextents();
  level.bot_variables_initialized = 1;
}

function initbotmapextents() {
  if(isDefined(level.teleportgetactivenodesfunc)) {
    var_0 = [[level.teleportgetactivenodesfunc]]();
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
    return;
  }
}

function bot_post_teleport() {
  level.bot_variables_initialized = undefined;
  level.bot_initialized_remote_vehicles = undefined;
  initbotmapextents();
  level.bot_variables_initialized = 1;
}

function shouldspawnbots() {
  return true;
}

function refresh_existing_bots() {
  wait 1;

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      if(isalive(var_1)) {
        var_1.equipment_enabled = 1;
        var_1.bot_team = var_1.team;
        var_1.debug_ai_aggro = 1;
        var_1 thread[[level.bot_funcs["think"]]]();
      }
    }
  }
}

function bot_player_spawned() {
  bot_set_loadout_class();
}

function bot_set_loadout_class() {
  if(!isDefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while(!isDefined(level.bot_loadouts_initialized)) {
        wait 0.05;
      }

      if(isDefined(self.override_class_function)) {
        self.bot_class = [[self.override_class_function]]();
        return;
      }

      self.bot_class = scripts\mp\bots\bots_personality::bot_setup_callback_class();
      return;
    }

    self.bot_class = self.class;
    return;
  }
}

function watch_players_connecting() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0) && level.players.size > 0) {
      level.players_waiting_to_join = scripts\engine\utility::array_add(level.players_waiting_to_join, var_0);
      GscBinSkip4(0x35, var_0);
    }
  }
}

function bots_notify_on_spawn(var_0) {
  var_0 endon("bots_human_disconnected");

  while(!scripts\engine\utility::array_contains(level.players, var_0)) {
    wait 0.05;
  }

  var_0 notify("bots_human_spawned");
}

function bots_notify_on_disconnect(var_0) {
  var_0 endon("bots_human_spawned");
  var_0 waittill("disconnect");
  var_0 notify("bots_human_disconnected");
}

function bots_remove_from_array_on_notify(var_0) {
  var_0 scripts\engine\utility::ref_143A5("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = scripts\engine\utility::array_remove(level.players_waiting_to_join, var_0);
}

function monitor_pause_spawning() {
  level.players_waiting_to_join = [];
  GscBinSkip4(0x35);
}

function bot_can_join_team(var_0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(scripts\mp\teams::getjointeampermissions(var_0)) {
    return true;
  }

  return false;
}

function bot_allowed_to_switch_teams() {
  if(isDefined(level.bots_disable_team_switching) && level.bots_disable_team_switching) {
    return false;
  }

  if(isDefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled) {
    return false;
  }

  return true;
}

function bot_connect_monitor_multiteam() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  GscBinSkip4(0x35);
}

function bot_connect_monitor() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  GscBinSkip4(0x35);
}

function bot_monitor_team_limits() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
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
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

function update_max_players_from_team_agents() {
  if(isDefined(level.agentarray)) {
    foreach(var_1 in level.agentarray) {
      if(isDefined(var_1.isactive) && var_1.isactive) {
        if(scripts\mp\utility\entity::isteamparticipant(var_1) && isDefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis")) {
          level.bot_max_players_on_team[var_1.team]++;
        }
      }
    }

    return;
  }
}

function bot_get_player_team() {
  if(isDefined(self.team)) {
    return self.team;
  }

  if(isDefined(self.pers["team"])) {
    return self.pers["team"];
  }

  return undefined;
}

function bot_get_host_team() {
  foreach(var_1 in level.players) {
    if(!isai(var_1) && var_1 ishost()) {
      return bot_get_player_team(var_1);
    }
  }

  return "spectator";
}

function bot_get_human_picked_team() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
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

function player_picked_team(var_0) {
  if(isDefined(var_0.team) && var_0.team != "spectator") {
    return true;
  }

  if(isDefined(var_0.spectating_actively) && var_0.spectating_actively) {
    return true;
  }

  if(var_0 ismlgspectator() && isDefined(var_0.team) && var_0.team == "spectator") {
    return true;
  }

  return false;
}

function damageskipburndownlow() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
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

function bot_client_counts() {
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

function cat_array_add(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  if(!isDefined(var_0[var_1])) {
    var_0 = 0;
  }

  var_0 = var_0[var_1] + 1;
  return var_0;
}

function cat_array_get(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0[var_1])) {
    return 0;
  }

  return var_0[var_1];
}

function move_bots_from_team_to_team(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(isDefined(var_5.connected) && var_5.connected && isbot(var_5) && var_5.team == var_1) {
      var_5.bot_team = var_2;

      if(isDefined(var_3)) {
        var_5 scripts\mp\bots\bots_util::bot_set_difficulty(var_3);
      }

      var_5 notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_2));
      wait 0.05;
      var_5 notify("loadout_class_selected", var_5.bot_class);
      var_0--;

      if(var_0 <= 0) {
        break;
      }

      wait 0.1;
    }
  }
}

function bots_update_difficulty(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(isDefined(var_3.connected) && var_3.connected && isbot(var_3) && var_3.team == var_0) {
      if(var_1 != var_3 botgetdifficulty()) {
        var_3 scripts\mp\bots\bots_util::bot_set_difficulty(var_1);
      }
    }
  }
}

function bot_drop() {
  kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

function drop_bots(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4.connected) && var_4.connected && isbot(var_4) && (!isDefined(var_1) || isDefined(var_4.team) && var_4.team == var_1)) {
      var_2 = var_4;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!var_2[var_6] scripts\cp_mp\utility\player_utility::_isalive()) {
      bot_drop(var_2[var_6]);
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[var_6]);
      var_0--;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    bot_drop(var_2[var_6]);
    var_0--;
  }
}

function bot_lui_convert_team_to_int(var_0) {
  if(var_0 == "axis") {
    return 0;
  }

  if(var_0 == "allies") {
    return 1;
  }

  if(var_0 == "autoassign" || var_0 == "random") {
    return 2;
  }

  return 3;
}

function spawn_bot_latent(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while(!self canspawnbotortestclient()) {
    if(gettime() >= var_3) {
      kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
      var_2.abort = 1;
      return;
    }

    wait 0.05;

    if(!isDefined(self)) {
      var_2.abort = 1;
      return;
    }
  }

  if(!scripts\mp\bots\bots_util::dev_spawning_bots()) {
    var_4 = randomfloatrange(0.25, 2);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_4);
  }

  if(!isDefined(self)) {
    var_2.abort = 1;
    return;
  }

  self spawnbotortestclient();
  self.equipment_enabled = 1;
  self.bot_team = var_0;

  if(isDefined(var_2.difficulty)) {
    scripts\mp\bots\bots_util::bot_set_difficulty(var_2.difficulty);
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }

  self thread[[level.bot_funcs["think"]]]();
  var_2.ready = 1;
}

function spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 15000;
  var_7 = [];

  for(var_8 = var_7.size; level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6; var_8++) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = undefined;

    if(isbotmatchmakingenabled()) {
      if(level.teambased) {
        var_9 = addmpbottoteam(var_1);
      } else {
        var_9 = addmpbottoteam("none");
      }
    } else {
      var_9 = addbot("");
    }

    if(!isDefined(var_9)) {
      if(isDefined(var_3) && var_3) {
        if(isDefined(var_4)) {
          self notify(var_4);
        }

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    }

    var_10 = spawnStruct();
    var_10.bot = var_9;
    var_10.ready = 0;
    var_10.abort = 0;
    var_10.index = var_8;
    var_10.difficulty = var_5;
    var_7 = var_10;
    thread spawn_bot_latent(var_10.bot, var_1, var_2);
  }

  var_11 = 0;
  var_6 = gettime() + 60000;

  while(var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10.ready || var_10.abort) {
        var_11++;
      }
    }

    wait 0.05;
  }

  if(isDefined(var_4)) {
    self notify(var_4);
    return;
  }
}

function bot_gametype_chooses_team() {
  if(scripts\mp\utility\game::matchmakinggame() && self.sessionteam != "none") {
    var_0 = 0;
  } else if(!scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && scripts\mp\utility\game::doesmodesupportplayerteamchoice()) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  return !var_0;
}

function bot_gametype_chooses_class() {
  return istrue(level.bots_gametype_handles_class_choice);
}

function bot_is_ready_to_spawn() {
  if(!isDefined(self.classcallback)) {
    if(!bot_gametype_chooses_class()) {
      return false;
    }
  }

  return true;
}

function bot_think() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while(!isDefined(self.pers["team"])) {
    wait 0.05;
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
  jumpiftrue(isDefined(self.debug_ai_aggro)) LOC_00000103;
  var_1 = 1;
  self.debug_ai_aggro = 1;
  jumpiftrue(bot_gametype_chooses_team()) LOC_00000103;
  var_2 = self.pers["team"] != "spectator" && !isDefined(self.bot_team);

  if(!var_2) {
    var_3 = isDefined(self.bot_team) && self.bot_team != self.pers["team"];

    if(var_3) {
      self notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var_0));
    }

    wait 0.5;

    if(self.pers["team"] == "spectator") {
      bot_drop();
      return;
    }
  }

  for(;;) {
    scripts\mp\bots\bots_util::bot_set_difficulty(self botgetdifficulty());
    self.difficulty = self botgetdifficulty();
    var_4 = self botgetdifficultysetting("advancedPersonality");

    if(var_1 && isDefined(var_4) && var_4 != 0) {
      scripts\mp\bots\bots_personality::bot_balance_personality();
    }

    scripts\mp\bots\bots_personality::bot_assign_personality_functions();

    if(var_1) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["class_select_override"])) {
        self[[level.bot_funcs["class_select_override"]]]();
      } else {
        bot_set_loadout_class();

        if(!bot_gametype_chooses_class()) {
          if(isDefined(self.connecttime) && self.connecttime == gettime()) {
            waittillframeend();
            waittillframeend();
          }

          self notify("loadout_class_selected", self.bot_class);
        }
      }

      if(self.health == 0) {
        self.bwaitingforteamselect = 1;
        self notify("bot_ready_to_spawn");
        self waittill("spawned_player");
        self.bwaitingforteamselect = undefined;
        self.bot_team = var_0;
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"])) {
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();
      }

      var_1 = 0;
    }

    scripts\mp\bots\bots_loadout::deactive_trophy_protection();
    dead_target_count();
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

function dead_target_count() {
  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    self botsetflag("only_headshots", 1);
    return;
  }
}

function respawn_watcher() {
  self endon("started_spawnPlayer");

  while(!self.waitingtospawn) {
    wait 0.05;
  }

  if(scripts\mp\playerlogic::needsbuttontorespawn()) {
    while(self.waitingtospawn) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0) {
          self botpressbutton("use", 0.5);
        }
      }

      wait 1;
    }

    return;
  }
}

function bot_get_rank_xp() {
  if(scripts\mp\bots\bots_util::bot_israndom() == 0) {
    if(!isDefined(self.pers["rankxp"])) {
      self.pers["rankxp"] = 0;
    }

    return self.pers["rankxp"];
  }

  var_0 = self botgetdifficulty();
  var_1 = "bot_rank_" + var_0;

  if(isDefined(self.pers[var_1]) && self.pers[var_1] > 0) {
    return self.pers[var_1];
  }

  var_2 = bot_random_ranks_for_difficulty(var_0);
  var_3 = var_2["rank"];
  var_4 = var_2["prestige"];
  var_5 = scripts\mp\rank::getrankinfominxp(var_3);
  var_6 = var_5 + scripts\mp\rank::getrankinfoxpamt(var_3);
  var_7 = randomintrange(var_5, var_6 + 1);
  self.pers[var_1] = var_7;
  return var_7;
}

function bot_3d_sighting_model(var_0) {
  thread bot_3d_sighting_model_thread(var_0);
}

function bot_3d_sighting_model_thread(var_0) {
  var_0 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(var_0) && scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
      self botgetimperfectenemyinfo(var_0, var_0.origin);
    }

    wait 0.1;
  }
}

function bot_random_ranks_for_difficulty(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "rank", 0);
}

function crate_can_use_always(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return false;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return false;
  }

  return true;
}

function get_human_player() {
  var_0 = undefined;
  var_1 = getEntArray("player", "classname");

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2].connected) && var_1[var_2].connected && !isai(var_1[var_2]) && (!isDefined(var_0) || var_0.team == "spectator")) {
        var_0 = var_1[var_2];
      }
    }
  }

  return var_0;
}

function bot_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5) {
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
    if(isDefined(self.fnbotdamagecallback)) {
      self[[self.fnbotdamagecallback]](var_0, var_1, var_2, var_3, var_4, var_5);
    }

    if(level.teambased) {
      if(isDefined(var_4.team) && var_4.team == self.team) {
        return;
      } else if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
        return;
      }
    }

    var_6 = scripts\mp\bots\bots_util::bot_get_known_attacker(var_0, var_4);

    if(isDefined(var_6)) {
      self botsetattacker(var_6);
    }
  }

  if(isagent(self)) {
    self notify("agentDamage");
    return;
  }
}

function on_bot_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var_10 = scripts\mp\bots\bots_util::bot_get_known_attacker(var_1, var_0);

  if(isDefined(var_10) && (var_10.classname == "script_vehicle" || var_10.classname == "script_model") && isDefined(var_10.helitype)) {
    var_11 = self botgetdifficultysetting("launcherRespawnChance");

    if(randomfloat(1) < var_11) {
      self.respawn_with_launcher = 1;
      return;
    }

    return;
  }
}

function bot_should_do_killcam() {
  if(istrue(game["isLaunchChunk"])) {
    return true;
  }

  var_5 = 0;
  var_6 = self botgetdifficulty();

  if(var_6 == "recruit") {
    var_5 = 0.1;
  } else if(var_6 == "regular") {
    var_5 = 0.4;
  } else if(var_6 == "hardened") {
    var_5 = 0.7;
  } else if(var_6 == "veteran") {
    var_5 = 1;
  }

  return randomfloat(1) < 1 - var_5;
}

function bot_should_pickup_weapons() {
  return true;
}

function bot_restart_think_threads() {
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]]();
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();
  self thread[[level.bot_funcs["revive_think"]]]();
  thread bot_think_crate();
  thread bot_think_crate_blocking_path();
  thread scripts\mp\bots\bots_killstreaks::bot_think_killstreak();
  thread scripts\mp\bots\bots_killstreaks::bot_think_watch_aerial_killstreak();
  thread bot_think_gametype();
  thread bot_think_dynamic_doors();
  thread bot_think_nvg();
}

function sortdoorsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.closestdoorpos) < distancesquared(var_1.origin, self.closestdoorpos);
}

function bot_think_dynamic_doors() {
  self notify("bot_think_dynamic_doors");
  self endon("bot_think_dynamic_doors");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self getmodifierlocationonpath("door", 64);

    if(isDefined(var_0)) {
      self.closestdoorpos = var_0;
      var_1 = getentarrayinradius("dynamic_door", "targetname", var_0, 64);

      if(var_1.size > 0) {
        var_1 = scripts\engine\utility::array_sort_with_func(var_1, &sortdoorsbydistance);
        var_2 = var_1[0];

        if(isDefined(var_2.state) && var_2 scripts\mp\door::door_can_open_check()) {
          var_2 thread scripts\mp\door::cheapopen(self);
        }
      }

      self.closestdoorpos = undefined;
    }

    wait 0.05;
  }
}

function bot_think_nvg() {
  self notify("bot_think_nvg");
  self endon("bot_think_nvg");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();

  for(;;) {
    var_1 = 0;
    var_2 = 0;

    if(isDefined(level.bot_light_volumes)) {
      foreach(var_4 in level.bot_light_volumes) {
        if(self istouching(var_4)) {
          var_2 = 1;
          break;
        }
      }
    }

    if(isDefined(level.bot_dark_volumes)) {
      foreach(var_4 in level.bot_dark_volumes) {
        if(self istouching(var_4)) {
          var_1 = 1;
          break;
        }
      }
    }

    if(istrue(self.inmotionlight)) {
      var_2 = 1;
    }

    if(var_1 || var_0 && !var_2) {
      self botsetflag("dark_area", 1);
      self.indarkarea = 1;
    } else if(!var_1 && istrue(self.indarkarea)) {
      self botsetflag("dark_area", 0);
      self.indarkarea = 0;
    }

    wait 0.25;
  }
}

function bot_think_watch_enemy(var_0) {
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
    if(isDefined(self.enemy)) {
      if(self botcanseeentity(self.enemy)) {
        self.last_enemy_sight_time = gettime();
      }
    }

    wait 0.05;
  }
}

function bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = "throwingknife_mp";

  for(;;) {
    var_1 = 0;

    if(scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var_2 = getEntArray("dropped_weapon", "targetname");
        var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          bot_seek_dropped_weapon(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self getammocount(var_0) == 0;

      if(var_6) {
        if(isDefined(self.going_for_knife)) {
          wait 5;
          continue;
        }

        var_7 = getEntArray("dropped_knife", "targetname");
        var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }

          if(!isDefined(var_10.calculated_closest_point)) {
            var_11 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10.closest_point_on_grid = var_11;
              var_10.calculated_closest_point = 1;
            } else {
              continue;
            }
          }

          if(isDefined(var_10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            bot_seek_dropped_weapon(var_10);
          }
        }
      } else if(var_5) {
        self.going_for_knife = undefined;
      }
    }

    wait randomfloatrange(0.25, 0.75);
  }
}

function bot_seek_dropped_weapon(var_0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var_0) == 0) {
    var_1 = undefined;

    if(var_0.targetname == "dropped_weapon") {
      var_2 = 1;
      var_3 = self getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == getweaponmodel(var_5)) {
          var_2 = 0;
        }
      }

      if(var_2) {
        var_1 = &bot_pickup_weapon;
      }
    }

    var_7 = spawnStruct();
    var_7.object = var_0;
    var_7.script_goal_radius = 12;
    var_7.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var_7.action_thread = var_1;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var_0.origin, 100, var_7);
    return;
  }
}

function bot_pickup_weapon(var_0) {
  self botpressbutton("use", 2);
  wait 2;
}

function should_stop_seeking_weapon(var_0) {
  if(!isDefined(var_0.object)) {
    return true;
  }

  if(var_0.object.targetname == "dropped_weapon") {
    if(scripts\mp\bots\bots_util::bot_get_total_gun_ammo() > 0) {
      return true;
    }
  } else if(var_0.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return true;
    }
  }

  return false;
}

function crate_in_range(var_0) {
  if(!isDefined(var_0.owner) || var_0.owner != self) {
    if(distancesquared(self.origin, var_0.origin) > 4194304) {
      return false;
    }
  }

  return true;
}

function bot_crate_valid(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = self[[level.bot_funcs["crate_can_use"]]](var_0);

  if(!var_1) {
    if(scripts\mp\utility\game::getgametype() == "grnd") {
      var_1 = 1;
    }
  }

  if(!var_1) {
    return false;
  }

  if(!crate_landed_and_on_path_grid(var_0)) {
    return false;
  }

  if(level.teambased && isDefined(var_0.bomb) && isDefined(var_0.team) && var_0.team == self.team) {
    return false;
  }

  if(!self[[level.bot_funcs["crate_in_range"]]](var_0)) {
    return false;
  }

  if(!isDefined(level.bot_can_use_box_by_type)) {
    return false;
  }

  if(isDefined(var_0.boxtype)) {
    if(isDefined(level.boxsettings) && isDefined(level.boxsettings[var_0.boxtype]) && ![[level.boxsettings[var_0.boxtype].canusecallback]]()) {
      return false;
    }

    if(isDefined(var_0.disabled_use_for) && isDefined(var_0.disabled_use_for[self getentitynumber()]) && var_0.disabled_use_for[self getentitynumber()]) {
      return false;
    }

    if(!self[[level.bot_can_use_box_by_type[var_0.boxtype]]](var_0)) {
      return false;
    }
  } else if(datakey(var_0)) {
    return false;
  }

  return isDefined(var_0);
}

function datakey(var_0) {
  return false;
}

function crate_landed_and_on_path_grid(var_0) {
  if(!crate_has_landed(var_0)) {
    return false;
  }

  if(!crate_is_on_path_grid(var_0)) {
    return false;
  }

  return isDefined(var_0);
}

function crate_has_landed(var_0) {
  if(isDefined(var_0.boxtype)) {
    return (gettime() > var_0.birthtime + 1000);
  }

  return isDefined(var_0.droppingtoground) && !var_0.droppingtoground;
}

function crate_is_on_path_grid(var_0) {
  if(!isDefined(var_0.on_path_grid)) {
    crate_calculate_on_path_grid(var_0);
  }

  return isDefined(var_0) && var_0.on_path_grid;
}

function node_within_use_radius_of_crate(var_0, var_1) {
  if(isDefined(var_1.boxtype) && var_1.boxtype == "scavenger_bag") {
    return (abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 18);
  }

  var_2 = getdvarfloat("player_useRadius");
  var_3 = distancesquared(var_1.origin, var_0.origin + (0, 0, 40));
  return var_3 <= var_2 * var_2;
}

function crate_calculate_on_path_grid(var_0) {
  thread crate_monitor_position();
  var_0.on_path_grid = 0;
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0.forcedisconnectuntil)) {
    var_1 = var_0.forcedisconnectuntil;
    var_2 = gettime() + 30000;
    var_0.forcedisconnectuntil = var_2;
    var_0 notify("path_disconnect");
  }

  wait 0.05;

  if(!isDefined(var_0)) {
    return;
  }

  var_3 = crate_get_nearest_valid_nodes(var_0);

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_3) && var_3.size > 0) {
    var_0.nearest_nodes = var_3;
    var_0.on_path_grid = 1;
  } else {
    var_4 = getdvarfloat("player_useRadius");
    var_5 = getnodesinradiussorted(var_0.origin, var_4 * 2, 0)[0];
    var_6 = var_0 getpointinbounds(0, 0, -1);
    var_7 = undefined;

    if(isDefined(var_0.boxtype) && var_0.boxtype == "scavenger_bag") {
      if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(var_0.origin, var_4)) {
        var_7 = var_0.origin;
      }
    } else {
      var_7 = botgetclosestnavigablepoint(var_0.origin, var_4);
    }

    if(isDefined(var_5) && !var_5 nodeisdisconnected() && isDefined(var_7) && abs(var_5.origin[2] - var_6[2]) < 30) {
      var_0.nearest_points = [var_7];
      var_0.nearest_nodes = [var_5];
      var_0.on_path_grid = 1;
    }
  }

  if(isDefined(var_0.forcedisconnectuntil)) {
    if(var_0.forcedisconnectuntil == var_2) {
      var_0.forcedisconnectuntil = var_1;
      return;
    }

    return;
  }
}

function crate_get_nearest_valid_nodes(var_0) {
  var_1 = getnodesinradiussorted(var_0.origin, 256, 0);

  for(var_2 = var_1.size; var_2 > 0; var_2--) {
    var_1 = var_1[var_2 - 1];
  }

  var_1 = getclosestnodeinsight(var_0.origin);
  var_3 = undefined;

  if(isDefined(var_0.forcedisconnectuntil)) {
    var_3 = getsentientcounts();
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

    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }

    if(sighttracepassed(var_0.origin, var_6.origin + (0, 0, 55), 0, var_0)) {
      wait 0.05;

      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_0.forcedisconnectuntil)) {
        var_4 = var_6;

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
        var_9 = randomint(var_3);
        var_10 = nvidiahighlightsrequestpermissions(var_9);

        if(isDefined(var_10) && distancesquared(var_6.origin, var_10.origin) > 250000) {
          var_7 = var_10;
        }
      }

      if(isDefined(var_7)) {
        var_11 = scripts\mp\bots\bots_util::bot_queued_process("GetNodesOnPathCrate", &scripts\mp\bots\bots_util::func_get_nodes_on_path, var_6.origin, var_7.origin);

        if(isDefined(var_11)) {
          var_4 = var_6;

          if(var_4.size == var_5) {
            return var_4;
          }
        }
      }
    }
  }

  return undefined;
}

function crate_get_bot_target(var_0) {
  if(isDefined(var_0.nearest_points)) {
    return var_0.nearest_points[0];
  }

  if(isDefined(var_0.nearest_nodes) && var_0.nearest_nodes.size > 0) {
    if(var_0.nearest_nodes.size > 1) {
      var_1 = scripts\engine\utility::array_reverse(self botnodescoremultiple(var_0.nearest_nodes, "node_exposed"));
      return scripts\engine\utility::random_weight_sorted(var_1).origin;
    }

    return var_1.nearest_nodes[0].origin;
  }
}

function crate_get_bot_target_check_distance(var_0, var_1) {
  var_2 = crate_get_bot_target(var_0);
  var_2 = getclosestpointonnavmesh(var_2, self);
  var_3 = var_1 * 0.9;
  var_3 *= var_3;

  if(distancesquared(var_0.origin, var_2) <= var_3) {
    return var_2;
  }

  return undefined;
}

function bot_think_crate() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("player_useRadius");

  for(;;) {
    var_1 = randomfloatrange(2, 4);
    scripts\engine\utility::waittill_notify_or_timeout("new_crate_to_take", var_1);

    if(isDefined(self.boxes) && self.boxes.size == 0) {
      self.boxes = undefined;
    }

    var_2 = level.carepackages;

    if(!scripts\mp\bots\bots_util::bot_in_combat() && isDefined(self.boxes)) {
      var_2 = scripts\engine\utility::array_combine(var_2, self.boxes);
    }

    if(isDefined(level.bot_scavenger_bags) && scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var_2 = scripts\engine\utility::array_combine(var_2, level.bot_scavenger_bags);
    }

    var_2 = scripts\engine\utility::array_removeundefined(var_2);

    if(var_2.size == 0) {
      continue;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    var_3 = [];

    foreach(var_6, var_5 in var_2) {
      if(bot_crate_valid(var_5)) {
        var_3 = var_5;
      }
    }

    var_3 = scripts\engine\utility::array_remove_duplicates(var_3);

    if(var_3.size == 0) {
      continue;
    }

    var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_3);
    var_7 = self getnearestnode();

    if(!isDefined(var_7)) {
      continue;
    }

    var_8 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    var_9 = (var_8 || randomint(100) < 50) && !scripts\cp_mp\emp_debuff::is_empd();
    var_10 = undefined;

    foreach(var_5 in var_3) {
      var_12 = 0;

      if((!isDefined(var_5.owner) || var_5.owner != self) && !isDefined(var_5.boxtype)) {
        var_13 = [];

        foreach(var_15 in level.players) {
          if(!isDefined(var_15.team)) {
            continue;
          }

          if(!isai(var_15) && level.teambased && var_15.team == self.team) {
            if(distancesquared(var_15.origin, var_5.origin) < 490000) {
              var_13 = var_15;
            }
          }
        }

        if(var_13.size > 0) {
          var_17 = var_13[0] getnearestnode();

          if(isDefined(var_17)) {
            var_12 = 0;

            foreach(var_19 in var_5.nearest_nodes) {
              var_12 |= nodesvisible(var_17, var_19, 1);
            }
          }
        }
      }

      if(!var_12) {
        var_21 = isDefined(var_5.bots) && isDefined(var_5.bots[self.team]) && var_5.bots[self.team] > 0;
        var_22 = 0;

        foreach(var_19 in var_5.nearest_nodes) {
          var_22 |= nodesvisible(var_7, var_19, 1);
        }

        if(var_22 || var_9 && !var_21) {
          var_10 = var_5;
          break;
        }
      }
    }

    var_6 = undefined;
    var_8 = undefined;

    if(isDefined(var_5)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(var_5.boxtype)) {
          if(!isDefined(var_5.bots)) {
            var_5.bots = [];
          }

          var_5.bots[self.team] = 1;
        }
      }

      var_9 = spawnStruct();
      var_9.object = var_5;
      var_9.start_thread = &watch_bot_died_during_crate;
      var_9.should_abort = &crate_picked_up;
      var_10 = undefined;

      if(isDefined(var_5.boxtype)) {
        if(isDefined(var_5.boxtouchonly) && var_5.boxtouchonly) {
          var_9.script_goal_radius = 16;
          var_9.action_thread = undefined;
          var_10 = var_5.origin;
        } else {
          var_9.script_goal_radius = 50;
          var_9.action_thread = &use_box;
          var_11 = crate_get_bot_target_check_distance(var_5, < error > );

          if(!isDefined(var_11)) {
            continue;
          }

          var_11 -= var_5.origin;
          var_29 = length(var_11) * randomfloat(1);
          var_10 = var_5.origin + vectorNormalize(var_11) * var_29 + (0, 0, 12);
        }
      } else {
        var_9.action_thread = &use_crate;
        var_9.end_thread = &stop_using_crate;
        var_10 = crate_get_bot_target_check_distance(var_5, < error > );

        if(!isDefined(var_10)) {
          continue;
        }

        var_9.script_goal_radius = < error > -distance(var_5.origin, var_10 + (0, 0, 40));
        var_10 += (0, 0, 24);
      }

      if(isDefined(var_9.script_goal_radius)) {}

      var_5 notify("path_disconnect");
      wait 0.05;

      if(!isDefined(var_5)) {
        continue;
      }

      scripts\mp\bots\bots_strategy::bot_new_tactical_goal("airdrop_crate", var_10, 30, var_9);
    }
  }
}

function bot_should_use_ballistic_vest_crate(var_0) {
  return true;
}

function crate_should_claim() {
  return true;
}

function crate_low_ammo_check() {
  return false;
}

function bot_should_use_ammo_crate(var_0) {
  if(createheadicon(self getcurrentweapon()) == level.boxsettings[var_0.boxtype].minigunweapon) {
    return false;
  }

  return true;
}

function bot_pre_use_ammo_crate(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
  wait 1;
}

function bot_post_use_ammo_crate(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(isundefinedweapon());
  self.secondaryweapon = self getcurrentweapon();
}

function bot_should_use_scavenger_bag(var_0) {
  if(scripts\mp\bots\bots_util::bot_get_low_on_ammo(0.66)) {
    var_1 = self getnearestnode();

    if(isDefined(var_0.nearest_nodes) && isDefined(var_0.nearest_nodes[0]) && isDefined(var_1)) {
      if(nodesvisible(var_1, var_0.nearest_nodes[0], 1)) {
        if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
          return true;
        }
      }
    }
  }

  return false;
}

function bot_should_use_grenade_crate(var_0) {
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1) {
    if(self getweaponammostock(var_3) == 0) {
      return true;
    }
  }

  return false;
}

function bot_should_use_juicebox_crate(var_0) {
  return true;
}

function crate_monitor_position() {
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

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(self.origin, var_0)) {
      self.on_path_grid = undefined;
      self.nearest_nodes = undefined;
      self.nearest_points = undefined;
    }
  }
}

function crate_wait_use() {}

function crate_picked_up(var_0) {
  if(!isDefined(var_0.object)) {
    return true;
  }

  return false;
}

function use_crate(var_0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_0.object enableplayeruse(self);
    wait 0.05;
  }

  self[[level.bot_funcs["crate_wait_use"]]]();

  if(isDefined(var_0.object.owner) && var_0.object.owner == self) {
    var_1 = level.crateownerusetime / 1000 + 0.5;
  } else {
    var_1 = level.cratenonownerusetime / 1000 + 1;
  }

  self botpressbutton("use", var_1);

  while(var_1 > 0 && isDefined(var_1.object)) {
    wait 0.05;
    var_1 -= 0.05;
  }

  if(var_1 > 0) {
    wait randomfloatrange(0.05, 0.5);
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_1.object)) {
      var_1.object disableplayeruse(self);
    }
  }

  if(isDefined(var_1.object)) {
    if(!isDefined(var_1.object.bots_used)) {
      var_1.object.bots_used = [];
    }

    var_1.object.bots_used[var_1.object.bots_used.size] = self;
    return;
  }
}

function use_box(var_0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_0.object enableplayeruse(self);
    wait 0.05;
  }

  if(isDefined(var_0.object) && isDefined(var_0.object.boxtype)) {
    var_1 = var_0.object.boxtype;

    if(isDefined(level.bot_pre_use_box_of_type[var_1])) {
      self[[level.bot_pre_use_box_of_type[var_1]]](var_0.object);
    }

    if(isDefined(var_0.object)) {
      var_2 = level.boxsettings[var_0.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("use", var_2);
      wait var_2;

      if(isDefined(level.bot_post_use_box_of_type[var_1])) {
        self[[level.bot_post_use_box_of_type[var_1]]](var_0.object);
      }
    }
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_0.object)) {
      var_0.object disableplayeruse(self);
      return;
    }

    return;
  }
}

function watch_bot_died_during_crate(var_0) {
  thread bot_watch_for_death(var_0.object);
}

function stop_using_crate(var_0) {
  if(isDefined(var_0.object)) {
    var_0.object.bots[self.team] = 0;
    return;
  }
}

function bot_watch_for_death(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 endon("revived");
  level endon("game_ended");
  var_1 = self.team;
  self waittill("death_or_disconnect");

  if(isDefined(var_0)) {
    var_0.bots[var_1] = 0;
    return;
  }
}

function bot_think_crate_blocking_path() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("player_useRadius");

  for(;;) {
    wait 3;

    if(self useButtonPressed()) {
      continue;
    }

    if(scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_1 = level.carepackages;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }

      var_4 = self getplayeruseentity();

      if(!isDefined(var_4) || var_4 != var_3) {
        continue;
      }

      if(distancesquared(self.origin, var_3.origin) < var_0 * var_0) {
        if(!datakey(var_3)) {
          if(isDefined(var_3.owner) && var_3.owner == self) {
            self botpressbutton("use", level.crateownerusetime / 1000 + 0.5);
            continue;
          }

          self botpressbutton("use", level.cratenonownerusetime / 1000 + 0.5);
        }
      }
    }
  }
}

function bot_think_revive() {
  self notify("bot_think_revive");
  self endon("bot_think_revive");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }

  jumpiffalse(!scripts\mp\utility\game::islaststandenabled() && !scripts\mp\utility\game::isteamreviveenabled()) LOC_00000038;
  return;
}

function watch_bot_died_during_revive(var_0) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    thread bot_watch_for_death(var_0.object.owner);
    return;
  }
}

function stop_reviving(var_0) {
  if(isDefined(var_0.object.owner)) {
    var_0.object.owner.bots[self.team] = 0;
    return;
  }
}

function player_revived_or_dead(var_0) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    if(!isDefined(var_0.object.owner) || var_0.object.owner.health <= 0) {
      return true;
    }

    if(!isDefined(var_0.object.owner.inlaststand) || !var_0.object.owner.inlaststand) {
      return true;
    }
  } else if(!isDefined(var_0.object.owner) || var_0.object.owner.health > 0) {
    return true;
  }

  return false;
}

function revive_player(var_0) {
  if(isDefined(var_0.object.owner)) {
    var_0.object.owner.bots[self.team] = 1;
  }

  if(scripts\mp\utility\game::islaststandenabled()) {
    var_1 = var_0.object.owner.origin;
  } else {
    var_1 = var_1.object.origin;
  }

  if(distancesquared(self.origin, var_1) > 4096) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_1.object enableplayeruse(self);
    wait 0.05;
  }

  var_2 = self.team;
  self botpressbutton("use", level.laststandrevivetimer + 0.5);
  wait level.laststandrevivetimer + 1.5;

  if(isDefined(var_1.object.owner)) {
    var_1.object.owner.bots[var_2] = 0;
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_1.object)) {
      var_1.object disableplayeruse(self);
      return;
    }

    return;
  }
}

function bot_can_revive() {
  if(isDefined(self.laststand) && self.laststand == 1) {
    return false;
  }

  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("revive")) {
    return false;
  }

  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    return false;
  }

  if(scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    return true;
  }

  if(isDefined(level.bot_funcs["tactical_revive_override"])) {
    var_0 = self[[level.bot_funcs["tactical_revive_override"]]]();

    if(var_0) {
      self.tutorial_lead_collected = 0;
      return true;
    }
  }

  var_1 = self botgetscriptgoaltype();

  if(var_1 == "none" || var_1 == "hunt" || var_1 == "guard") {
    return true;
  }

  return false;
}

function revive_watch_for_finished(var_0) {
  self endon("death_or_disconnect");
  self endon("bad_path");
  self endon("goal");
  var_0 scripts\engine\utility::ref_143A5("death", "revived");
  self notify("bad_path");
}

function bot_know_enemies_on_start() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }

  while(!scripts\mp\utility\game::gamehasstarted() || !scripts\mp\flags::gameflag("prematch_done")) {
    wait 0.05;
  }

  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3) && isDefined(self.team) && isDefined(var_3.team) && !istestclient(self, var_3)) {
      if(!isDefined(var_3.bot_start_known_by_enemy)) {
        var_0 = var_3;
      }

      if(isai(var_3) && !isDefined(var_3.bot_start_know_enemy)) {
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
    return;
  }
}

function bot_think_gametype() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = 0;

  if(level.gametype == "br") {
    var_0 = 1;
  }

  if(!var_0) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  self thread[[level.bot_funcs["gametype_think"]]]();
}

function default_gametype_think() {}

function monitor_smoke_grenades() {
  level.bot_smoke_sight_clip_large = getEnt("smoke_grenade_sight_clip_256", "targetname");
  jumpiftrue(isDefined(level.bot_smoke_sight_clip_large)) LOC_0000001d;
  return;
}

function handle_smoke() {
  self endon("late_death");
  thread smoke_grenade_late_death();
  self waittill("explode", var_0);
  thread init_leave_cave(var_0);
}

function init_leave_cave(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 show();
  wait 1;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  var_1 setmovertransparentvolume();
  wait 8.75;
  var_1 delete();
}

function smoke_grenade_late_death() {
  self endon("explode");
  self waittill("death");
  waittillframeend();
  self notify("late_death");
}

function bot_add_scavenger_bag(var_0) {
  var_1 = 0;
  var_0.boxtype = "scavenger_bag";
  var_0.boxtouchonly = 1;

  if(!isDefined(level.bot_scavenger_bags)) {
    level.bot_scavenger_bags = [];
  }

  foreach(var_3 in level.bot_scavenger_bags) {
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
    if(isai(var_6) && var_6 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var_6 notify("new_crate_to_take");
    }
  }
}

function bot_triggers() {
  var_0 = getEntArray("bot_flag_set", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    thread bot_flag_trigger(var_2);
  }
}

function bot_flag_trigger(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(scripts\mp\utility\entity::isaigameparticipant(var_1)) {
      var_1 notify("flag_trigger_set_" + var_0);
      var_1 botsetflag(var_0, 1);
      thread bot_flag_trigger_clear(var_1);
    }
  }
}

function bot_flag_trigger_clear(var_0) {
  self endon("flag_trigger_set_" + var_0);
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend();
  self botsetflag(var_0, 0);
}

function load_gametype_scripts_for_scriptdev() {}